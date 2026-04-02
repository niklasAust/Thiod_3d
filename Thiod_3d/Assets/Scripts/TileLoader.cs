using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using UnityEngine;
using WorldGen;
#if GRIFFIN
using Pinwheel.Griffin;
using Pinwheel.Griffin.API;
#endif

[ExecuteAlways]
public sealed class TileLoader : MonoBehaviour
{
    [Header("World Source")]
    [SerializeField] private string worldDataFile = "test_map.msgpack";
    [SerializeField] private bool loadOnEnableInEditMode = true;
    [SerializeField] private bool loadOnStartInPlayMode = false;

    [Header("Tile Selection")]
    [SerializeField] private Vector3Int unityTileCoordinate = new(83, 29, 0);
    [SerializeField] private bool invertUnityYForWorldGen = true;
    [SerializeField] private bool load3x3Neighborhood = false;

    [Header("Generation Overrides")]
    [SerializeField] private bool useMetadataGenerationSettings = true;
    [SerializeField] private int fallbackTileSize = 128;
    [SerializeField] private int fallbackHillSpacing = 64;
    [SerializeField] private float fallbackHillStrength = 1f;

    [Header("Terrain Output")]
    [SerializeField] private string generatedTerrainName = "LoadedTileTerrain";
    [SerializeField] private float terrainWidth = 128f;
    [SerializeField] private float terrainLength = 128f;
    [SerializeField] private float terrainHeight = 30f;
    [SerializeField] private int terrainGridSize = 16;

    [Header("Debug")]
    [SerializeField] private bool logHeightStats = true;

    private bool hasLoadedInCurrentEnableCycle;

    private void OnEnable()
    {
        hasLoadedInCurrentEnableCycle = false;

        if (!Application.isPlaying && loadOnEnableInEditMode)
        {
            LoadTileIntoScene();
        }
    }

    private void Start()
    {
        if (Application.isPlaying && loadOnStartInPlayMode)
        {
            LoadTileIntoScene();
        }
    }

    [ContextMenu("Update Terrain")]
    public void UpdateTerrain()
    {
        hasLoadedInCurrentEnableCycle = false;
        LoadTileIntoScene();
    }

    [ContextMenu("Load Demo Tile")]
    public void LoadTileIntoScene()
    {
#if !GRIFFIN
        Debug.LogError("Polaris/GRIFFIN is not enabled in this project, so TileLoader cannot create terrain.", this);
        return;
#else
        if (!Application.isPlaying && hasLoadedInCurrentEnableCycle && loadOnEnableInEditMode)
        {
            return;
        }

        try
        {
            string filePath = ResolveWorldDataFilePath(worldDataFile);
            if (!File.Exists(filePath))
            {
                Debug.LogError($"TileLoader could not find world data file at '{filePath}'.", this);
                return;
            }

            Dictionary<string, object> rawWorldData = WorldGenerator.LoadWorldDataBinary(filePath);
            LoadedWorldData loadedWorldData = ReconstructWorldData(rawWorldData);
            GenerationSettings settings = ResolveGenerationSettings(loadedWorldData.Metadata);

            var tileGenerator = new TileGenerator(loadedWorldData.WorldData, loadedWorldData.Seed);
            CreateOrUpdateTerrains(tileGenerator, loadedWorldData, settings);
            hasLoadedInCurrentEnableCycle = true;
        }
        catch (Exception ex)
        {
            Debug.LogException(ex, this);
        }
#endif
    }

#if GRIFFIN
    private void CreateOrUpdateTerrains(TileGenerator tileGenerator, LoadedWorldData loadedWorldData, GenerationSettings settings)
    {
        ClearGeneratedTerrains();

        int minOffset = load3x3Neighborhood ? -1 : 0;
        int maxOffset = load3x3Neighborhood ? 1 : 0;
        var terrainsToCreate = new List<GeneratedTerrainRequest>();
        var createdTerrains = new List<GStylizedTerrain>();
        double batchMinHeight = double.MaxValue;
        double batchMaxHeight = double.MinValue;
        int terrainGroupId = GetGeneratedTerrainGroupId();

        for (int offsetY = minOffset; offsetY <= maxOffset; offsetY++)
        {
            for (int offsetX = minOffset; offsetX <= maxOffset; offsetX++)
            {
                int unityTileX = unityTileCoordinate.x + offsetX;
                int unityTileY = unityTileCoordinate.y + offsetY;
                int worldTileY = invertUnityYForWorldGen ? -unityTileY : unityTileY;

                TileLayers layers = tileGenerator.GenerateTileLayers(
                    unityTileX,
                    worldTileY,
                    settings.TileSize,
                    settings.HillSpacing,
                    settings.HillStrength);

                string terrainObjectName = GetTerrainObjectName(offsetX, offsetY, unityTileX, unityTileY);
                Vector3 localPosition = new Vector3(offsetX * terrainWidth, 0f, offsetY * terrainLength);
                CalculateHeightRange(layers.Heightmap, out double tileMinHeight, out double tileMaxHeight);
                batchMinHeight = Math.Min(batchMinHeight, tileMinHeight);
                batchMaxHeight = Math.Max(batchMaxHeight, tileMaxHeight);
                terrainsToCreate.Add(new GeneratedTerrainRequest(
                    layers,
                    terrainObjectName,
                    localPosition,
                    unityTileX,
                    unityTileY,
                    tileMinHeight,
                    tileMaxHeight));
            }
        }

        double normalizationMinHeight = Math.Min(loadedWorldData.GlobalMinHeight, batchMinHeight);
        double normalizationMaxHeight = Math.Max(loadedWorldData.GlobalMaxHeight, batchMaxHeight);

        for (int i = 0; i < terrainsToCreate.Count; i++)
        {
            GeneratedTerrainRequest request = terrainsToCreate[i];
            GStylizedTerrain terrain = CreateTerrain(
                request.Layers,
                request.TerrainObjectName,
                request.LocalPosition,
                request.UnityTileX,
                request.UnityTileY,
                normalizationMinHeight,
                normalizationMaxHeight,
                request.LocalMinHeight,
                request.LocalMaxHeight,
                terrainGroupId);
            createdTerrains.Add(terrain);
        }

        if (createdTerrains.Count > 0)
        {
            RebuildTerrainSeams(createdTerrains);
        }
    }

    private void ClearGeneratedTerrains()
    {
        var toRemove = new List<Transform>();
        foreach (Transform child in transform)
        {
            if (child.name == generatedTerrainName || child.name.StartsWith(generatedTerrainName + "_", StringComparison.Ordinal))
            {
                toRemove.Add(child);
            }
        }

        for (int i = 0; i < toRemove.Count; i++)
        {
            DestroyImmediate(toRemove[i].gameObject);
        }
    }

    private string GetTerrainObjectName(int offsetX, int offsetY, int unityTileX, int unityTileY)
    {
        if (!load3x3Neighborhood && offsetX == 0 && offsetY == 0)
        {
            return generatedTerrainName;
        }

        return $"{generatedTerrainName}_{unityTileX}_{unityTileY}";
    }

    private GStylizedTerrain CreateTerrain(
        TileLayers layers,
        string terrainObjectName,
        Vector3 localPosition,
        int unityTileX,
        int unityTileY,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        double localMinHeight,
        double localMaxHeight,
        int terrainGroupId)
    {
        GTerrainData terrainData = Polaris.CreateAndInitTerrainData(GTexturingModel.ColorMap);
        terrainData.Geometry.StorageMode = GGeometry.GStorageMode.GenerateOnEnable;
        terrainData.Geometry.Width = terrainWidth;
        terrainData.Geometry.Length = terrainLength;
        terrainData.Geometry.Height = terrainHeight;
        terrainData.Geometry.HeightMapResolution = layers.Heightmap.GetLength(0);
        terrainData.Geometry.MeshBaseResolution = 0;
        terrainData.Geometry.MeshResolution = 3;
        terrainData.Geometry.ChunkGridSize = Mathf.Max(1, terrainGridSize);
        terrainData.Shading.CustomMaterial = CreateFallbackTerrainMaterial();
        terrainData.Shading.UpdateMaterials();

        Texture2D heightMap = Polaris.GetHeightMap(terrainData);
        Color[] pixels = BuildHeightPixels(layers.Heightmap, normalizationMinHeight, normalizationMaxHeight);
        heightMap.SetPixels(pixels);
        heightMap.Apply(false, false);

        GStylizedTerrain terrain = Polaris.CreateTerrain(terrainData);
        terrain.name = terrainObjectName;
        terrain.GroupId = terrainGroupId;
        terrain.AutoConnect = true;
        terrain.transform.SetParent(transform, false);
        terrain.transform.localPosition = localPosition;
        terrain.transform.localRotation = Quaternion.identity;
        terrain.transform.localScale = Vector3.one;
        terrain.TerrainData.Shading.UpdateMaterials();

        if (logHeightStats)
        {
            Debug.Log(
                $"TileLoader loaded Unity tile ({unityTileX},{unityTileY},0) as worldgen tile ({layers.TileX},{layers.TileY}) from '{worldDataFile}'. " +
                $"Tile range: {localMinHeight.ToString("F3", CultureInfo.InvariantCulture)} to {localMaxHeight.ToString("F3", CultureInfo.InvariantCulture)}. " +
                $"Normalization range: {normalizationMinHeight.ToString("F3", CultureInfo.InvariantCulture)} to {normalizationMaxHeight.ToString("F3", CultureInfo.InvariantCulture)}.",
                this);
        }

        return terrain;
    }

    private void RebuildTerrainSeams(List<GStylizedTerrain> terrains)
    {
        GStylizedTerrain.ConnectAdjacentTiles();

        Rect fullRegion = new Rect(0f, 0f, 1f, 1f);
        for (int i = 0; i < terrains.Count; i++)
        {
            GStylizedTerrain terrain = terrains[i];
            terrain.TerrainData.Geometry.SetRegionDirty(fullRegion);
            Polaris.UpdateTerrainMesh(terrain, new[] { fullRegion });
            terrain.TerrainData.Shading.UpdateMaterials();
        }
    }

    private int GetGeneratedTerrainGroupId()
    {
        int instanceId = Mathf.Abs(GetInstanceID());
        return instanceId == 0 ? 1 : instanceId;
    }

    private static Material CreateFallbackTerrainMaterial()
    {
        Shader shader =
            Shader.Find("Universal Render Pipeline/Lit") ??
            Shader.Find("Standard");

        if (shader == null)
        {
            throw new InvalidOperationException("TileLoader could not find a fallback terrain shader.");
        }

        var material = new Material(shader)
        {
            name = "TileLoaderTerrainMaterial",
        };

        if (material.HasProperty("_BaseColor"))
        {
            material.SetColor("_BaseColor", new Color(0.42f, 0.66f, 0.38f, 1f));
        }

        if (material.HasProperty("_Color"))
        {
            material.SetColor("_Color", new Color(0.42f, 0.66f, 0.38f, 1f));
        }

        return material;
    }

    private static Color[] BuildHeightPixels(double[,] heightmap, double minHeight, double maxHeight)
    {
        int resolutionY = heightmap.GetLength(0);
        int resolutionX = heightmap.GetLength(1);
        double range = Math.Max(maxHeight - minHeight, 1e-6);
        var pixels = new Color[resolutionX * resolutionY];

        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                float normalizedHeight = Mathf.Clamp01((float)((heightmap[y, x] - minHeight) / range));
                int flippedY = resolutionY - 1 - y;
                pixels[flippedY * resolutionX + x] = Polaris.EncodeHeightMapSample(normalizedHeight, 0f, 0f);
            }
        }

        return pixels;
    }

    private static void CalculateHeightRange(double[,] heightmap, out double minHeight, out double maxHeight)
    {
        int resolutionY = heightmap.GetLength(0);
        int resolutionX = heightmap.GetLength(1);
        minHeight = double.MaxValue;
        maxHeight = double.MinValue;

        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                double value = heightmap[y, x];
                if (value < minHeight)
                {
                    minHeight = value;
                }

                if (value > maxHeight)
                {
                    maxHeight = value;
                }
            }
        }

        if (double.IsInfinity(minHeight) || double.IsInfinity(maxHeight))
        {
            minHeight = 0;
            maxHeight = 0;
        }
    }
#endif

    private GenerationSettings ResolveGenerationSettings(IReadOnlyDictionary<string, object> metadata)
    {
        int tileSize = fallbackTileSize;
        int hillSpacing = fallbackHillSpacing;
        double hillStrength = fallbackHillStrength;

        if (useMetadataGenerationSettings && metadata != null)
        {
            IReadOnlyDictionary<string, object> config = TryGetDictionary(metadata, "config");
            UpdateIntFromMetadata(metadata, config, "tile_size", "tileSize", ref tileSize);
            UpdateIntFromMetadata(metadata, config, "hill_spacing", "hillSpacing", ref hillSpacing);
            UpdateDoubleFromMetadata(metadata, config, "hill_strength", "hillStrength", ref hillStrength);
        }

        return new GenerationSettings(tileSize, hillSpacing, hillStrength);
    }

    private static void UpdateIntFromMetadata(
        IReadOnlyDictionary<string, object> metadata,
        IReadOnlyDictionary<string, object> config,
        string snakeCaseKey,
        string camelCaseKey,
        ref int value)
    {
        if (TryGetInt(metadata, snakeCaseKey, out int metadataValue) || TryGetInt(metadata, camelCaseKey, out metadataValue))
        {
            value = metadataValue;
            return;
        }

        if (TryGetInt(config, snakeCaseKey, out int configValue) || TryGetInt(config, camelCaseKey, out configValue))
        {
            value = configValue;
        }
    }

    private static void UpdateDoubleFromMetadata(
        IReadOnlyDictionary<string, object> metadata,
        IReadOnlyDictionary<string, object> config,
        string snakeCaseKey,
        string camelCaseKey,
        ref double value)
    {
        if (TryGetDouble(metadata, snakeCaseKey, out double metadataValue) || TryGetDouble(metadata, camelCaseKey, out metadataValue))
        {
            value = metadataValue;
            return;
        }

        if (TryGetDouble(config, snakeCaseKey, out double configValue) || TryGetDouble(config, camelCaseKey, out configValue))
        {
            value = configValue;
        }
    }

    private LoadedWorldData ReconstructWorldData(Dictionary<string, object> raw)
    {
        IReadOnlyDictionary<string, object> metadata = TryGetDictionary(raw, "metadata");
        IReadOnlyDictionary<string, object> coordinateData = TryGetDictionary(raw, "data");

        int width = GetInt(metadata, "width", 200);
        int height = GetInt(metadata, "height", 200);
        int seed = GetInt(metadata, "seed", 0);
        double globalMinHeight = double.MaxValue;
        double globalMaxHeight = double.MinValue;

        double[][] elevation = CreateJagged<double>(height, width, 0d);
        int[][] biome = CreateJagged<int>(height, width, 0);
        double[][] temperature = CreateJagged<double>(height, width, 0d);
        double[][] humidity = CreateJagged<double>(height, width, 0d);
        double[][] tectonic = CreateJagged<double>(height, width, 0d);
        double[][] rivers = CreateJagged<double>(height, width, 0d);
        double[][] lakes = CreateJagged<double>(height, width, 0d);
        double[][] wind = CreateJagged<double>(height, width, 0d);
        RiverRasterization.RiverDirectionInfo?[][] riverDirection = CreateJagged<RiverRasterization.RiverDirectionInfo?>(height, width, null);
        double[][] seaCurrents = CreateJagged<double>(height, width, 0d);
        int[][] heightmapType = CreateJagged<int>(height, width, 0);
        string[][][] waterDirection = CreateJagged<string[]>(height, width, Array.Empty<string>());

        int halfWidth = width / 2;
        int halfHeight = height / 2;

        foreach ((string key, object value) in coordinateData)
        {
            IReadOnlyDictionary<string, object> pointData = TryGetDictionary(value);
            if (!TryParseCoordinates(key, halfWidth, halfHeight, out int x, out int y))
            {
                continue;
            }

            if (y >= height || x >= width)
            {
                continue;
            }

            elevation[y][x] = GetDouble(pointData, "elevation", 0d);
            biome[y][x] = GetInt(pointData, "biome", 0);
            temperature[y][x] = GetDouble(pointData, "temperature", 0d);
            humidity[y][x] = GetDouble(pointData, "humidity", 0d);
            tectonic[y][x] = GetDouble(pointData, "roughness", 0d);
            rivers[y][x] = GetDouble(pointData, "river", 0d);
            lakes[y][x] = GetDouble(pointData, "lake", 0d);
            wind[y][x] = GetDouble(pointData, "wind", 0d);

            if (elevation[y][x] < globalMinHeight)
            {
                globalMinHeight = elevation[y][x];
            }

            if (elevation[y][x] > globalMaxHeight)
            {
                globalMaxHeight = elevation[y][x];
            }

            if (TryGetObject(pointData, "river_direction", out object riverObject))
            {
                IReadOnlyDictionary<string, object> riverData = TryGetDictionary(riverObject);
                riverDirection[y][x] = new RiverRasterization.RiverDirectionInfo
                {
                    Inputs = ToDoubleDictionary(GetValue(riverData, "inputs", null)),
                    Outputs = ToDoubleDictionary(GetValue(riverData, "outputs", null)),
                    SinkType = GetValue(riverData, "sink_type", string.Empty)?.ToString(),
                    SourceType = GetValue(riverData, "source_type", string.Empty)?.ToString(),
                };
            }

            if (TryGetObject(pointData, "sea_current", out object seaCurrent))
            {
                seaCurrents[y][x] = ConvertToDouble(seaCurrent, 0d);
            }

            if (TryGetObject(pointData, "heightmap_type", out object typeObject))
            {
                heightmapType[y][x] = ConvertToInt(typeObject, 0);
            }

            if (TryGetObject(pointData, "water_direction", out object directionObject))
            {
                waterDirection[y][x] = ToStringArray(directionObject);
            }
        }

        var worldData = new Dictionary<string, object>(StringComparer.Ordinal)
        {
            ["elevation"] = elevation,
            ["biome"] = biome,
            ["temperature"] = temperature,
            ["humidity"] = humidity,
            ["tectonic"] = tectonic,
            ["rivers"] = rivers,
            ["lakes"] = lakes,
            ["wind"] = wind,
            ["config"] = TryGetDictionary(metadata, "config"),
        };

        if (riverDirection.Any(row => row.Any(cell => cell != null)))
        {
            worldData["river_direction"] = riverDirection;
        }

        if (seaCurrents.Any(row => row.Any(value => Math.Abs(value) > double.Epsilon)))
        {
            worldData["sea_currents"] = seaCurrents;
        }

        if (waterDirection.Any(row => row.Any(cell => cell != null && cell.Length > 0)))
        {
            worldData["water_direction"] = waterDirection;
        }

        if (heightmapType.Any(row => row.Any(value => value != 0)))
        {
            worldData["heightmap_type"] = heightmapType;
        }

        if (double.IsInfinity(globalMinHeight) || double.IsInfinity(globalMaxHeight))
        {
            globalMinHeight = 0;
            globalMaxHeight = 1;
        }

        return new LoadedWorldData(worldData, metadata, seed, globalMinHeight, globalMaxHeight);
    }

    private string ResolveWorldDataFilePath(string configuredPath)
    {
        if (string.IsNullOrWhiteSpace(configuredPath))
        {
            return string.Empty;
        }

        if (Path.IsPathRooted(configuredPath))
        {
            return configuredPath;
        }

        string relativePath = configuredPath.TrimStart('.', Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar);
        string[] candidates =
        {
            Path.Combine(Application.dataPath, relativePath),
            Path.Combine(Application.streamingAssetsPath, relativePath),
            Path.Combine(Application.persistentDataPath, relativePath),
            Path.Combine(Application.dataPath, Path.GetFileName(relativePath)),
            Path.Combine(Application.streamingAssetsPath, Path.GetFileName(relativePath)),
        };

        foreach (string candidate in candidates)
        {
            if (File.Exists(candidate))
            {
                return candidate;
            }
        }

        return candidates[0];
    }

    private static bool TryParseCoordinates(string key, int halfWidth, int halfHeight, out int x, out int y)
    {
        x = 0;
        y = 0;

        if (string.IsNullOrWhiteSpace(key))
        {
            return false;
        }

        string trimmed = key.Trim('[', ']');
        string[] parts = trimmed.Split(',');
        if (parts.Length != 2)
        {
            return false;
        }

        if (!int.TryParse(parts[0], NumberStyles.Integer, CultureInfo.InvariantCulture, out int centeredX) ||
            !int.TryParse(parts[1], NumberStyles.Integer, CultureInfo.InvariantCulture, out int centeredY))
        {
            return false;
        }

        x = centeredX + halfWidth;
        y = centeredY + halfHeight;
        return x >= 0 && y >= 0;
    }

    private static T[][] CreateJagged<T>(int height, int width, T defaultValue)
    {
        var values = new T[height][];
        for (int y = 0; y < height; y++)
        {
            values[y] = Enumerable.Repeat(defaultValue, width).ToArray();
        }

        return values;
    }

    private static IReadOnlyDictionary<string, object> TryGetDictionary(IReadOnlyDictionary<string, object> source, string key)
    {
        if (source != null && source.TryGetValue(key, out object value))
        {
            return TryGetDictionary(value);
        }

        return new Dictionary<string, object>(StringComparer.Ordinal);
    }

    private static IReadOnlyDictionary<string, object> TryGetDictionary(object value)
    {
        if (value is IReadOnlyDictionary<string, object> readOnlyStringDict)
        {
            return readOnlyStringDict;
        }

        if (value is Dictionary<string, object> stringDict)
        {
            return stringDict;
        }

        if (value is IReadOnlyDictionary<object, object> readOnlyObjectDict)
        {
            var converted = new Dictionary<string, object>(StringComparer.Ordinal);
            foreach ((object key, object itemValue) in readOnlyObjectDict)
            {
                converted[key?.ToString() ?? string.Empty] = itemValue;
            }

            return converted;
        }

        if (value is IDictionary<object, object> objectDict)
        {
            var converted = new Dictionary<string, object>(StringComparer.Ordinal);
            foreach ((object key, object itemValue) in objectDict)
            {
                converted[key?.ToString() ?? string.Empty] = itemValue;
            }

            return converted;
        }

        return new Dictionary<string, object>(StringComparer.Ordinal);
    }

    private static object GetValue(IReadOnlyDictionary<string, object> source, string key, object fallback)
    {
        return source != null && source.TryGetValue(key, out object value) ? value : fallback;
    }

    private static bool TryGetObject(IReadOnlyDictionary<string, object> source, string key, out object value)
    {
        if (source != null && source.TryGetValue(key, out value))
        {
            return true;
        }

        value = null;
        return false;
    }

    private static int GetInt(IReadOnlyDictionary<string, object> source, string key, int fallback)
    {
        return source != null && source.TryGetValue(key, out object value) ? ConvertToInt(value, fallback) : fallback;
    }

    private static double GetDouble(IReadOnlyDictionary<string, object> source, string key, double fallback)
    {
        return source != null && source.TryGetValue(key, out object value) ? ConvertToDouble(value, fallback) : fallback;
    }

    private static bool TryGetInt(IReadOnlyDictionary<string, object> source, string key, out int value)
    {
        if (source != null && source.TryGetValue(key, out object raw))
        {
            value = ConvertToInt(raw, 0);
            return true;
        }

        value = 0;
        return false;
    }

    private static bool TryGetDouble(IReadOnlyDictionary<string, object> source, string key, out double value)
    {
        if (source != null && source.TryGetValue(key, out object raw))
        {
            value = ConvertToDouble(raw, 0d);
            return true;
        }

        value = 0d;
        return false;
    }

    private static int ConvertToInt(object value, int fallback)
    {
        try
        {
            return Convert.ToInt32(value, CultureInfo.InvariantCulture);
        }
        catch
        {
            return fallback;
        }
    }

    private static double ConvertToDouble(object value, double fallback)
    {
        try
        {
            return Convert.ToDouble(value, CultureInfo.InvariantCulture);
        }
        catch
        {
            return fallback;
        }
    }

    private static Dictionary<string, double> ToDoubleDictionary(object value)
    {
        IReadOnlyDictionary<string, object> dictionary = TryGetDictionary(value);
        var result = new Dictionary<string, double>(StringComparer.Ordinal);
        foreach ((string key, object itemValue) in dictionary)
        {
            result[key] = ConvertToDouble(itemValue, 0d);
        }

        return result;
    }

    private static string[] ToStringArray(object value)
    {
        if (value is string[] stringArray)
        {
            return stringArray;
        }

        if (value is IEnumerable<object> objectEnumerable)
        {
            return objectEnumerable.Select(item => item?.ToString() ?? string.Empty).ToArray();
        }

        if (value is IEnumerable<string> stringEnumerable)
        {
            return stringEnumerable.ToArray();
        }

        return Array.Empty<string>();
    }

    private readonly struct LoadedWorldData
    {
        public LoadedWorldData(
            Dictionary<string, object> worldData,
            IReadOnlyDictionary<string, object> metadata,
            int seed,
            double globalMinHeight,
            double globalMaxHeight)
        {
            WorldData = worldData;
            Metadata = metadata;
            Seed = seed;
            GlobalMinHeight = globalMinHeight;
            GlobalMaxHeight = globalMaxHeight;
        }

        public Dictionary<string, object> WorldData { get; }
        public IReadOnlyDictionary<string, object> Metadata { get; }
        public int Seed { get; }
        public double GlobalMinHeight { get; }
        public double GlobalMaxHeight { get; }
    }

    private readonly struct GenerationSettings
    {
        public GenerationSettings(int tileSize, int hillSpacing, double hillStrength)
        {
            TileSize = tileSize;
            HillSpacing = hillSpacing;
            HillStrength = hillStrength;
        }

        public int TileSize { get; }
        public int HillSpacing { get; }
        public double HillStrength { get; }
    }

    private readonly struct GeneratedTerrainRequest
    {
        public GeneratedTerrainRequest(
            TileLayers layers,
            string terrainObjectName,
            Vector3 localPosition,
            int unityTileX,
            int unityTileY,
            double localMinHeight,
            double localMaxHeight)
        {
            Layers = layers;
            TerrainObjectName = terrainObjectName;
            LocalPosition = localPosition;
            UnityTileX = unityTileX;
            UnityTileY = unityTileY;
            LocalMinHeight = localMinHeight;
            LocalMaxHeight = localMaxHeight;
        }

        public TileLayers Layers { get; }
        public string TerrainObjectName { get; }
        public Vector3 LocalPosition { get; }
        public int UnityTileX { get; }
        public int UnityTileY { get; }
        public double LocalMinHeight { get; }
        public double LocalMaxHeight { get; }
    }
}
