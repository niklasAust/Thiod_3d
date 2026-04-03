using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using UnityEngine;
using UnityEngine.Rendering;
using WorldGen;
#if UNITY_EDITOR
using UnityEditor;
#endif
#if GRIFFIN
using Pinwheel.Griffin;
using Pinwheel.Griffin.API;
#endif

#nullable enable

[ExecuteAlways]
public sealed class TileLoader : MonoBehaviour
{
    private const int ConiferObjectNumericId = 22;
    private const string ConiferObjectId = "vegetation.conifer";
    private const string DefaultConiferPrefabAssetPath =
        "Assets/Synty/PolygonNatureBiomes/PNB_Alpine_Mountain/Prefabs/SM_Env_Pine_01.prefab";
    private const string DefaultLowlandTerrainMaterialAssetPath =
        "Assets/Synty/PolygonNatureBiomes/PNB_Alpine_Mountain/Terrain/Terrain_Materials/grass01.mat";
    private const string DefaultMidHeightTerrainMaterialAssetPath =
        "Assets/Synty/PolygonNatureBiomes/PNB_Alpine_Mountain/Terrain/Terrain_Materials/pine 1.mat";
    private const string DefaultSteepSlopeTerrainMaterialAssetPath =
        "Assets/Synty/PolygonNatureBiomes/PNB_Alpine_Mountain/Terrain/Terrain_Materials/rocks 2.mat";
    private const string DefaultPeakTerrainMaterialAssetPath =
        "Assets/Synty/PolygonNatureBiomes/PNB_Alpine_Mountain/Terrain/Terrain_Materials/snow.mat";

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
    [SerializeField] private TerrainShadingMode terrainShadingMode = TerrainShadingMode.PolarisTextureBlend;
    [SerializeField] private Material? lowlandTerrainMaterial;
    [SerializeField] private float lowlandTerrainTileSize = 24f;
    [SerializeField] private Material? midHeightTerrainMaterial;
    [SerializeField] private float midHeightTerrainTileSize = 28f;
    [SerializeField] private Material? steepSlopeTerrainMaterial;
    [SerializeField] private float steepSlopeTerrainTileSize = 18f;
    [SerializeField] private Material? peakTerrainMaterial;
    [SerializeField] private float peakTerrainTileSize = 26f;
    [SerializeField] [Range(0f, 1f)] private float midHeightStart = 0.24f;
    [SerializeField] [Range(0.01f, 1f)] private float midHeightBlend = 0.18f;
    [SerializeField] [Range(0f, 90f)] private float steepSlopeStartDegrees = 24f;
    [SerializeField] [Range(0.1f, 90f)] private float steepSlopeBlendDegrees = 12f;
    [SerializeField] [Range(0f, 1f)] private float peakHeightStart = 0.74f;
    [SerializeField] [Range(0.01f, 1f)] private float peakHeightBlend = 0.16f;

    [Header("Vegetation Output")]
    [SerializeField] private bool placeConiferTrees = true;
    [SerializeField] private string generatedVegetationContainerName = "Vegetation";
    [SerializeField] private float coniferVerticalOffset = 0f;

    [Header("Vegetation Optimization")]
    [SerializeField] private bool optimizeConifersByDistance = true;
    [SerializeField] private Transform? coniferOptimizationTarget;
    [SerializeField] private float fullConiferDistance = 80f;
    [SerializeField] private float reducedConiferDistance = 160f;
    [SerializeField] private float lowDetailConiferDistance = 280f;
    [SerializeField] private float culledConiferDistance = 420f;
    [SerializeField] private float coniferOptimizationInterval = 0.25f;
    [SerializeField] private bool disableDistantConiferColliders = true;
    [SerializeField] private bool disableDistantConiferShadows = true;

    [Header("Debug")]
    [SerializeField] private bool logHeightStats = true;

    private bool hasLoadedInCurrentEnableCycle;
    private bool coniferOptimizationWasActive;
    private float nextConiferOptimizationTime;
    private readonly List<GeneratedConiferInstance> generatedConiferInstances = new();

    private void OnEnable()
    {
        hasLoadedInCurrentEnableCycle = false;

        if (ShouldLoadOnEnableInEditMode())
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

    private void Update()
    {
        if (!Application.isPlaying)
        {
            return;
        }

        if (!optimizeConifersByDistance)
        {
            if (coniferOptimizationWasActive)
            {
                ApplyConiferOptimizationToAll(ConiferOptimizationTier.Full);
                coniferOptimizationWasActive = false;
            }

            return;
        }

        coniferOptimizationWasActive = true;
        if (Time.unscaledTime < nextConiferOptimizationTime)
        {
            return;
        }

        nextConiferOptimizationTime = Time.unscaledTime + Mathf.Max(0.05f, coniferOptimizationInterval);
        UpdateConiferOptimization();
    }

    private void OnValidate()
    {
        EnsureVegetationDefaults();
#if GRIFFIN
        EnsureShadingDefaults();
        ApplyShadingToGeneratedTerrains();
#endif
    }

    [ContextMenu("Update Terrain")]
    public void UpdateTerrain()
    {
        hasLoadedInCurrentEnableCycle = false;
        LoadTileIntoScene();
    }

    [ContextMenu("Apply Shading To Generated Terrains")]
    public void ApplyShadingToGeneratedTerrains()
    {
#if !GRIFFIN
        return;
#else
        foreach (GStylizedTerrain terrain in GetGeneratedTerrains())
        {
            if (terrain == null || terrain.TerrainData == null)
            {
                continue;
            }

            ApplyTerrainShading(terrain);
            terrain.TerrainData.Shading.UpdateMaterials();
            ApplyWorldAlignedSplatMaterialOffsets(terrain);
        }
#endif
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

            EnsureConiferDefinitionRegistered();
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

    private bool ShouldLoadOnEnableInEditMode()
    {
        if (Application.isPlaying || !loadOnEnableInEditMode)
        {
            return false;
        }

#if UNITY_EDITOR
        if (UnityEditor.EditorApplication.isPlayingOrWillChangePlaymode)
        {
            return false;
        }
#endif

        // Exiting play mode re-enables this ExecuteAlways component in edit mode.
        // If generated terrains already exist in the scene, avoid destroying and
        // rebuilding them immediately because Griffin can throw during OnDisable.
        if (HasGeneratedTerrains())
        {
            return false;
        }

        return true;
    }

    private bool HasGeneratedTerrains()
    {
        foreach (Transform child in transform)
        {
            if (child != null &&
                (child.name == generatedTerrainName || child.name.StartsWith(generatedTerrainName + "_", StringComparison.Ordinal)))
            {
                return true;
            }
        }

        return false;
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
            ApplyTerrainShading(createdTerrains);
            PopulateVegetation(terrainsToCreate, createdTerrains, normalizationMinHeight, normalizationMaxHeight);
            if (Application.isPlaying)
            {
                UpdateConiferOptimization(forceFullIfNoTarget: true);
            }
        }
    }

    private void ClearGeneratedTerrains()
    {
        generatedConiferInstances.Clear();
        nextConiferOptimizationTime = 0f;
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
            if (toRemove[i] == null)
            {
                continue;
            }

            if (Application.isPlaying)
            {
                Destroy(toRemove[i].gameObject);
            }
            else
            {
                DestroyImmediate(toRemove[i].gameObject);
            }
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
        GTexturingModel texturingModel = GetTexturingModel();
        GTerrainData terrainData = Polaris.CreateAndInitTerrainData(texturingModel);
        terrainData.Geometry.StorageMode = GGeometry.GStorageMode.GenerateOnEnable;
        terrainData.Geometry.Width = terrainWidth;
        terrainData.Geometry.Length = terrainLength;
        terrainData.Geometry.Height = terrainHeight;
        terrainData.Geometry.HeightMapResolution = layers.Heightmap.GetLength(0);
        terrainData.Geometry.MeshBaseResolution = 0;
        terrainData.Geometry.MeshResolution = 3;
        terrainData.Geometry.ChunkGridSize = Mathf.Max(1, terrainGridSize);
        ConfigureShading(terrainData, texturingModel, layers.Heightmap, normalizationMinHeight, normalizationMaxHeight);

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
        ApplyWorldAlignedSplatMaterialOffsets(terrain);

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

    private void ConfigureShading(
        GTerrainData terrainData,
        GTexturingModel texturingModel,
        double[,] sourceHeightmap,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        Material material = CreateTerrainMaterial(texturingModel);
        Polaris.SetTerrainMaterial(terrainData, material);
        ApplyTerrainShading(terrainData, sourceHeightmap, normalizationMinHeight, normalizationMaxHeight);
    }

    private Material CreateTerrainMaterial(GTexturingModel texturingModel)
    {
        if (terrainShadingMode == TerrainShadingMode.FallbackLit)
        {
            return CreateFallbackTerrainMaterial();
        }

        Shader baseShader =
            Shader.Find("Universal Render Pipeline/Lit") ??
            Shader.Find("Standard");

        if (baseShader == null)
        {
            throw new InvalidOperationException("TileLoader could not find a base shader to initialize a Polaris terrain material.");
        }

        var material = new Material(baseShader)
        {
            name = $"TileLoaderTerrainMaterial_{texturingModel}",
        };

        if (Polaris.InitTerrainMaterial(material, GLightingModel.PBR, texturingModel, GSplatsModel.Splats4))
        {
            return material;
        }

        if (Application.isPlaying)
        {
            Destroy(material);
        }
        else
        {
            DestroyImmediate(material);
        }
        Debug.LogWarning($"TileLoader could not initialize a Polaris material for {texturingModel}; falling back to URP Lit.", this);
        return CreateFallbackTerrainMaterial();
    }

    private GTexturingModel GetTexturingModel()
    {
        return terrainShadingMode == TerrainShadingMode.PolarisTextureBlend
            ? GTexturingModel.Splat
            : GTexturingModel.ColorMap;
    }

    private void ApplyTerrainShading(
        GTerrainData terrainData,
        double[,] sourceHeightmap,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        if (terrainData == null || terrainData.Shading == null)
        {
            return;
        }

        EnsureShadingDefaults();
        if (terrainShadingMode != TerrainShadingMode.PolarisTextureBlend)
        {
            return;
        }

        float[,] normalizedHeights = BuildNormalizedHeights(sourceHeightmap, normalizationMinHeight, normalizationMaxHeight);
        ApplyTextureBlendSettings(terrainData.Shading, terrainData, normalizedHeights, null);
    }

    private void ApplyTerrainShading(IReadOnlyList<GStylizedTerrain> terrains)
    {
        for (int i = 0; i < terrains.Count; i++)
        {
            GStylizedTerrain terrain = terrains[i];
            if (terrain == null || terrain.TerrainData == null)
            {
                continue;
            }

            ApplyTerrainShading(terrain);
            terrain.TerrainData.Shading.UpdateMaterials();
            ApplyWorldAlignedSplatMaterialOffsets(terrain);
        }
    }

    private void ApplyTerrainShading(GStylizedTerrain terrain)
    {
        if (terrain == null || terrain.TerrainData == null || terrain.TerrainData.Shading == null || terrainShadingMode != TerrainShadingMode.PolarisTextureBlend)
        {
            return;
        }

        EnsureShadingDefaults();
        Texture2D? heightTexture = terrain.TerrainData.Geometry?.HeightMap;
        if (heightTexture == null)
        {
            return;
        }

        float[,] normalizedHeights = DecodeNormalizedHeights(heightTexture);
        ApplyTextureBlendSettings(terrain.TerrainData.Shading, terrain.TerrainData, normalizedHeights, terrain);
    }

    private void ApplyTextureBlendSettings(GShading shading, GTerrainData terrainData, float[,] normalizedHeights, GStylizedTerrain? terrain)
    {
        GSplatPrototypeGroup splatGroup = shading.Splats;
        if (splatGroup == null)
        {
            splatGroup = ScriptableObject.CreateInstance<GSplatPrototypeGroup>();
            splatGroup.name = "TileLoader Splat Prototype Group";
            GCommon.TryAddObjectToAsset(splatGroup, terrainData);
        }

        shading.Splats = splatGroup;
        splatGroup.Prototypes = new List<GSplatPrototype>
        {
            CreateSplatPrototype(lowlandTerrainMaterial, lowlandTerrainTileSize),
            CreateSplatPrototype(midHeightTerrainMaterial, midHeightTerrainTileSize),
            CreateSplatPrototype(steepSlopeTerrainMaterial, steepSlopeTerrainTileSize),
            CreateSplatPrototype(peakTerrainMaterial, peakTerrainTileSize),
        };

        shading.SplatControlResolution = Mathf.Max(32, Mathf.Max(normalizedHeights.GetLength(0), normalizedHeights.GetLength(1)));
        shading.SetAlphamaps(BuildTextureBlendAlphamaps(normalizedHeights, terrain));
    }

    private float[,,] BuildTextureBlendAlphamaps(float[,] normalizedHeights, GStylizedTerrain? terrain)
    {
        int resolutionY = normalizedHeights.GetLength(0);
        int resolutionX = normalizedHeights.GetLength(1);
        const int layerCount = 4;
        var alphamaps = new float[resolutionY, resolutionX, layerCount];
        float sampleSpacingX = resolutionX > 1 ? terrainWidth / (resolutionX - 1f) : terrainWidth;
        float sampleSpacingZ = resolutionY > 1 ? terrainLength / (resolutionY - 1f) : terrainLength;

        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                float normalizedHeight = normalizedHeights[y, x];
                float slopeDegrees = terrain != null
                    ? SampleSlopeDegrees(terrain, normalizedHeights, x, y, sampleSpacingX, sampleSpacingZ)
                    : SampleSlopeDegrees(normalizedHeights, x, y, sampleSpacingX, sampleSpacingZ);
                float peakWeight = SmoothRange(normalizedHeight, peakHeightStart, peakHeightBlend);
                float cliffWeight = SmoothRange(slopeDegrees, steepSlopeStartDegrees, steepSlopeBlendDegrees) * (1f - peakWeight * 0.4f);
                float midWeight = SmoothRange(normalizedHeight, midHeightStart, midHeightBlend) * (1f - peakWeight);
                float lowWeight = 1f - Mathf.Clamp01(midWeight + peakWeight);

                lowWeight *= 1f - cliffWeight;
                midWeight *= 1f - cliffWeight * 0.75f;

                float total = lowWeight + midWeight + cliffWeight + peakWeight;
                if (total <= 1e-5f)
                {
                    lowWeight = 1f;
                    total = 1f;
                }

                int flippedY = resolutionY - 1 - y;
                alphamaps[flippedY, x, 0] = lowWeight / total;
                alphamaps[flippedY, x, 1] = midWeight / total;
                alphamaps[flippedY, x, 2] = cliffWeight / total;
                alphamaps[flippedY, x, 3] = peakWeight / total;
            }
        }

        return alphamaps;
    }

    private GSplatPrototype CreateSplatPrototype(Material? sourceMaterial, float tileSize)
    {
        return new GSplatPrototype
        {
            Texture = ExtractDiffuseTexture(sourceMaterial),
            NormalMap = ExtractNormalTexture(sourceMaterial),
            TileSize = new Vector2(Mathf.Max(1f, tileSize), Mathf.Max(1f, tileSize)),
            TileOffset = Vector2.zero,
            Metallic = ExtractFloat(sourceMaterial, "_Metallic", 0f),
            Smoothness = Mathf.Max(
                ExtractFloat(sourceMaterial, "_Smoothness", 0f),
                ExtractFloat(sourceMaterial, "_Glossiness", 0f)),
        };
    }

    private static Texture2D? ExtractDiffuseTexture(Material? sourceMaterial)
    {
        if (sourceMaterial == null)
        {
            return null;
        }

        return sourceMaterial.GetTexture("_BaseMap") as Texture2D ??
               sourceMaterial.GetTexture("_MainTex") as Texture2D;
    }

    private static Texture2D? ExtractNormalTexture(Material? sourceMaterial)
    {
        if (sourceMaterial == null)
        {
            return null;
        }

        return sourceMaterial.GetTexture("_BumpMap") as Texture2D ??
               sourceMaterial.GetTexture("_NormalMap") as Texture2D;
    }

    private static float ExtractFloat(Material? sourceMaterial, string propertyName, float fallback)
    {
        return sourceMaterial != null && sourceMaterial.HasProperty(propertyName)
            ? sourceMaterial.GetFloat(propertyName)
            : fallback;
    }

    private static float[,] BuildNormalizedHeights(double[,] sourceHeightmap, double minHeight, double maxHeight)
    {
        int resolutionY = sourceHeightmap.GetLength(0);
        int resolutionX = sourceHeightmap.GetLength(1);
        var normalizedHeights = new float[resolutionY, resolutionX];
        double range = Math.Max(maxHeight - minHeight, 1e-6);

        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                normalizedHeights[y, x] = Mathf.Clamp01((float)((sourceHeightmap[y, x] - minHeight) / range));
            }
        }

        return normalizedHeights;
    }

    private float SampleSlopeDegrees(GStylizedTerrain terrain, float[,] normalizedHeights, int x, int y, float sampleSpacingX, float sampleSpacingZ)
    {
        int resolutionY = normalizedHeights.GetLength(0);
        int resolutionX = normalizedHeights.GetLength(1);
        float leftHeight = SampleNormalizedHeightWithNeighbors(terrain, normalizedHeights, x - 1, y, resolutionX, resolutionY) * terrainHeight;
        float rightHeight = SampleNormalizedHeightWithNeighbors(terrain, normalizedHeights, x + 1, y, resolutionX, resolutionY) * terrainHeight;
        float downHeight = SampleNormalizedHeightWithNeighbors(terrain, normalizedHeights, x, y - 1, resolutionX, resolutionY) * terrainHeight;
        float upHeight = SampleNormalizedHeightWithNeighbors(terrain, normalizedHeights, x, y + 1, resolutionX, resolutionY) * terrainHeight;

        float dHdX = (rightHeight - leftHeight) / (2f * Mathf.Max(sampleSpacingX, 1e-4f));
        float dHdZ = (upHeight - downHeight) / (2f * Mathf.Max(sampleSpacingZ, 1e-4f));
        return Mathf.Atan(Mathf.Sqrt(dHdX * dHdX + dHdZ * dHdZ)) * Mathf.Rad2Deg;
    }

    private static float[,] DecodeNormalizedHeights(Texture2D heightTexture)
    {
        int resolutionY = heightTexture.height;
        int resolutionX = heightTexture.width;
        var normalizedHeights = new float[resolutionY, resolutionX];
        Color[] pixels = heightTexture.GetPixels();

        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                int flippedY = resolutionY - 1 - y;
                Color sample = pixels[flippedY * resolutionX + x];
                float height01 = 0f;
                float subdiv01 = 0f;
                float visibility01 = 0f;
                Polaris.DecodeHeightMapSample(sample, ref height01, ref subdiv01, ref visibility01);
                normalizedHeights[y, x] = height01;
            }
        }

        return normalizedHeights;
    }

    private float SampleSlopeDegrees(float[,] normalizedHeights, int x, int y, float sampleSpacingX, float sampleSpacingZ)
    {
        int resolutionY = normalizedHeights.GetLength(0);
        int resolutionX = normalizedHeights.GetLength(1);
        int left = Mathf.Max(x - 1, 0);
        int right = Mathf.Min(x + 1, resolutionX - 1);
        int down = Mathf.Max(y - 1, 0);
        int up = Mathf.Min(y + 1, resolutionY - 1);

        float leftHeight = normalizedHeights[y, left] * terrainHeight;
        float rightHeight = normalizedHeights[y, right] * terrainHeight;
        float downHeight = normalizedHeights[down, x] * terrainHeight;
        float upHeight = normalizedHeights[up, x] * terrainHeight;

        float dHdX = right == left ? 0f : (rightHeight - leftHeight) / ((right - left) * Mathf.Max(sampleSpacingX, 1e-4f));
        float dHdZ = up == down ? 0f : (upHeight - downHeight) / ((up - down) * Mathf.Max(sampleSpacingZ, 1e-4f));
        return Mathf.Atan(Mathf.Sqrt(dHdX * dHdX + dHdZ * dHdZ)) * Mathf.Rad2Deg;
    }

    private static float SampleNormalizedHeightWithNeighbors(
        GStylizedTerrain terrain,
        float[,] normalizedHeights,
        int sampleX,
        int sampleY,
        int resolutionX,
        int resolutionY)
    {
        if (sampleX >= 0 && sampleX < resolutionX && sampleY >= 0 && sampleY < resolutionY)
        {
            return normalizedHeights[sampleY, sampleX];
        }

        if (sampleX < 0 && sampleY >= 0 && sampleY < resolutionY)
        {
            return SampleTerrainTextureHeight(terrain.LeftNeighbor, resolutionX - 1, sampleY, normalizedHeights[sampleY, 0]);
        }

        if (sampleX >= resolutionX && sampleY >= 0 && sampleY < resolutionY)
        {
            return SampleTerrainTextureHeight(terrain.RightNeighbor, 0, sampleY, normalizedHeights[sampleY, resolutionX - 1]);
        }

        if (sampleY < 0 && sampleX >= 0 && sampleX < resolutionX)
        {
            return SampleTerrainTextureHeight(terrain.TopNeighbor, sampleX, resolutionY - 1, normalizedHeights[0, sampleX]);
        }

        if (sampleY >= resolutionY && sampleX >= 0 && sampleX < resolutionX)
        {
            return SampleTerrainTextureHeight(terrain.BottomNeighbor, sampleX, 0, normalizedHeights[resolutionY - 1, sampleX]);
        }

        int clampedX = Mathf.Clamp(sampleX, 0, resolutionX - 1);
        int clampedY = Mathf.Clamp(sampleY, 0, resolutionY - 1);
        return normalizedHeights[clampedY, clampedX];
    }

    private static float SampleTerrainTextureHeight(GStylizedTerrain? terrain, int x, int y, float fallback)
    {
        Texture2D? heightTexture = terrain?.TerrainData?.Geometry?.HeightMap;
        if (heightTexture == null)
        {
            return fallback;
        }

        int clampedX = Mathf.Clamp(x, 0, heightTexture.width - 1);
        int clampedY = Mathf.Clamp(y, 0, heightTexture.height - 1);
        int flippedY = heightTexture.height - 1 - clampedY;
        Color sample = heightTexture.GetPixel(clampedX, flippedY);
        float height01 = 0f;
        float subdiv01 = 0f;
        float visibility01 = 0f;
        Polaris.DecodeHeightMapSample(sample, ref height01, ref subdiv01, ref visibility01);
        return height01;
    }

    private void ApplyWorldAlignedSplatMaterialOffsets(GStylizedTerrain terrain)
    {
        if (terrainShadingMode != TerrainShadingMode.PolarisTextureBlend || terrain?.TerrainData?.Shading?.CustomMaterial == null)
        {
            return;
        }

        Material material = terrain.TerrainData.Shading.CustomMaterial;
        Vector3 origin = terrain.transform.localPosition;
        ApplyWorldAlignedSplatOffset(material, "_Splat0", lowlandTerrainTileSize, origin);
        ApplyWorldAlignedSplatOffset(material, "_Splat1", midHeightTerrainTileSize, origin);
        ApplyWorldAlignedSplatOffset(material, "_Splat2", steepSlopeTerrainTileSize, origin);
        ApplyWorldAlignedSplatOffset(material, "_Splat3", peakTerrainTileSize, origin);
    }

    private void ApplyWorldAlignedSplatOffset(Material material, string propertyName, float tileSize, Vector3 terrainOrigin)
    {
        if (material == null || !material.HasProperty(propertyName))
        {
            return;
        }

        float safeTileSize = Mathf.Max(1f, tileSize);
        material.SetTextureScale(propertyName, new Vector2(terrainWidth / safeTileSize, terrainLength / safeTileSize));
        material.SetTextureOffset(propertyName, new Vector2(terrainOrigin.x / safeTileSize, terrainOrigin.z / safeTileSize));
    }

    private static float SmoothRange(float value, float start, float blend)
    {
        return Mathf.SmoothStep(0f, 1f, Mathf.Clamp01((value - start) / Mathf.Max(1e-4f, blend)));
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

    private void PopulateVegetation(
        IReadOnlyList<GeneratedTerrainRequest> terrainRequests,
        IReadOnlyList<GStylizedTerrain> terrains,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        if (!placeConiferTrees)
        {
            return;
        }

        int terrainCount = Math.Min(terrainRequests.Count, terrains.Count);
        for (int i = 0; i < terrainCount; i++)
        {
            GeneratedTerrainRequest request = terrainRequests[i];
            GStylizedTerrain terrain = terrains[i];
            PopulateConiferTrees(terrain, request, normalizationMinHeight, normalizationMaxHeight);
        }
    }

    private void PopulateConiferTrees(
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        if (terrain == null || request.Layers.PlacedObjects == null || request.Layers.PlacedObjects.Count == 0)
        {
            return;
        }

        Transform? vegetationContainer = null;
        foreach (TileObjectPlacement placement in request.Layers.PlacedObjects)
        {
            if (!IsConiferPlacement(placement))
            {
                continue;
            }

            GameObject? prefab = LoadPrefabForPlacement(placement);
            if (prefab == null)
            {
                continue;
            }

            vegetationContainer ??= CreateVegetationContainer(terrain.transform);
            GameObject? instance = InstantiatePlacementPrefab(prefab);
            if (instance == null)
            {
                continue;
            }

            instance.name = prefab.name;
            instance.transform.SetParent(vegetationContainer, false);
            instance.transform.localPosition = GetConiferLocalPosition(
                request.Layers.Heightmap,
                placement,
                normalizationMinHeight,
                normalizationMaxHeight);
            instance.transform.localRotation = Quaternion.identity;
            instance.transform.localScale = Vector3.one;
            RegisterGeneratedConifer(instance);
        }
    }

    private Transform CreateVegetationContainer(Transform terrainTransform)
    {
        string containerName = string.IsNullOrWhiteSpace(generatedVegetationContainerName)
            ? "Vegetation"
            : generatedVegetationContainerName.Trim();
        Transform existing = terrainTransform.Find(containerName);
        if (existing != null)
        {
            return existing;
        }

        var container = new GameObject(containerName);
        container.transform.SetParent(terrainTransform, false);
        container.transform.localPosition = Vector3.zero;
        container.transform.localRotation = Quaternion.identity;
        container.transform.localScale = Vector3.one;
        return container.transform;
    }

    private static GameObject? InstantiatePlacementPrefab(GameObject prefab)
    {
#if UNITY_EDITOR
        if (!Application.isPlaying)
        {
            return PrefabUtility.InstantiatePrefab(prefab) as GameObject;
        }
#endif
        return Instantiate(prefab);
    }

    private GameObject? LoadPrefabForPlacement(TileObjectPlacement placement)
    {
        string? rawPath = placement.PrefabPath ?? placement.Definition.PrefabPath;
        if (string.IsNullOrWhiteSpace(rawPath))
        {
            return null;
        }

#if UNITY_EDITOR
        string? assetPath = NormalizeAssetPath(rawPath);
        if (!string.IsNullOrEmpty(assetPath))
        {
            GameObject asset = AssetDatabase.LoadAssetAtPath<GameObject>(assetPath);
            if (asset != null)
            {
                return asset;
            }
        }
#endif

        string? resourcesPath = NormalizeResourcesPath(rawPath);
        if (!string.IsNullOrEmpty(resourcesPath))
        {
            GameObject resource = Resources.Load<GameObject>(resourcesPath);
            if (resource != null)
            {
                return resource;
            }
        }

        Debug.LogWarning($"TileLoader could not resolve prefab path '{rawPath}' for placement '{placement.Definition.Id}'.", this);
        return null;
    }

    private static string? NormalizeAssetPath(string rawPath)
    {
        if (string.IsNullOrWhiteSpace(rawPath))
        {
            return null;
        }

        string normalized = rawPath.Replace('\\', '/').Trim();
        if (!normalized.StartsWith("Assets/", StringComparison.OrdinalIgnoreCase))
        {
            return null;
        }

        if (!normalized.EndsWith(".prefab", StringComparison.OrdinalIgnoreCase))
        {
            normalized += ".prefab";
        }

        return normalized;
    }

    private static string? NormalizeResourcesPath(string rawPath)
    {
        if (string.IsNullOrWhiteSpace(rawPath))
        {
            return null;
        }

        string normalized = rawPath.Replace('\\', '/').Trim();
        if (normalized.EndsWith(".prefab", StringComparison.OrdinalIgnoreCase))
        {
            normalized = normalized[..^7];
        }

        const string resourcesPrefix = "Resources/";
        int resourcesIndex = normalized.IndexOf(resourcesPrefix, StringComparison.OrdinalIgnoreCase);
        if (resourcesIndex >= 0)
        {
            return normalized[(resourcesIndex + resourcesPrefix.Length)..];
        }

        return normalized.StartsWith("Assets/", StringComparison.OrdinalIgnoreCase) ? null : normalized;
    }

    private Vector3 GetConiferLocalPosition(
        double[,] heightmap,
        TileObjectPlacement placement,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        int heightResolution = heightmap.GetLength(0);
        int widthResolution = heightmap.GetLength(1);
        float normalizedX = widthResolution > 1
            ? Mathf.Clamp01((float)(placement.X / (widthResolution - 1)))
            : 0f;
        float normalizedY = heightResolution > 1
            ? Mathf.Clamp01((float)(placement.Y / (heightResolution - 1)))
            : 0f;

        float localX = normalizedX * terrainWidth;
        float localZ = (1f - normalizedY) * terrainLength;
        float localY = SampleTerrainHeight(heightmap, placement.X, placement.Y, normalizationMinHeight, normalizationMaxHeight) +
                       coniferVerticalOffset;
        return new Vector3(localX, localY, localZ);
    }

    private float SampleTerrainHeight(
        double[,] heightmap,
        double sampleX,
        double sampleY,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        double rawHeight = SampleHeightmapBilinear(heightmap, sampleX, sampleY);
        double normalizationRange = Math.Max(normalizationMaxHeight - normalizationMinHeight, 1e-6);
        float normalizedHeight = Mathf.Clamp01((float)((rawHeight - normalizationMinHeight) / normalizationRange));
        return normalizedHeight * terrainHeight;
    }

    private static double SampleHeightmapBilinear(double[,] heightmap, double sampleX, double sampleY)
    {
        int height = heightmap.GetLength(0);
        int width = heightmap.GetLength(1);
        if (height == 0 || width == 0)
        {
            return 0d;
        }

        double clampedX = Math.Clamp(sampleX, 0d, width - 1d);
        double clampedY = Math.Clamp(sampleY, 0d, height - 1d);
        int x0 = (int)Math.Floor(clampedX);
        int y0 = (int)Math.Floor(clampedY);
        int x1 = Math.Min(x0 + 1, width - 1);
        int y1 = Math.Min(y0 + 1, height - 1);
        double tx = clampedX - x0;
        double ty = clampedY - y0;

        double h00 = heightmap[y0, x0];
        double h10 = heightmap[y0, x1];
        double h01 = heightmap[y1, x0];
        double h11 = heightmap[y1, x1];
        double hx0 = Lerp(h00, h10, tx);
        double hx1 = Lerp(h01, h11, tx);
        return Lerp(hx0, hx1, ty);
    }

    private static double Lerp(double a, double b, double t)
    {
        return a + (b - a) * t;
    }

    private void RegisterGeneratedConifer(GameObject instance)
    {
        if (instance == null)
        {
            return;
        }

        generatedConiferInstances.Add(new GeneratedConiferInstance(instance));
    }

    private void UpdateConiferOptimization(bool forceFullIfNoTarget = false)
    {
        generatedConiferInstances.RemoveAll(instance => instance.Root == null);
        if (generatedConiferInstances.Count == 0)
        {
            return;
        }

        Transform? target = ResolveConiferOptimizationTarget();
        if (target == null)
        {
            if (forceFullIfNoTarget)
            {
                ApplyConiferOptimizationToAll(ConiferOptimizationTier.Full);
            }

            return;
        }

        float fullDistanceSq = fullConiferDistance * fullConiferDistance;
        float reducedDistanceSq = reducedConiferDistance * reducedConiferDistance;
        float lowDetailDistanceSq = lowDetailConiferDistance * lowDetailConiferDistance;

        for (int i = 0; i < generatedConiferInstances.Count; i++)
        {
            GeneratedConiferInstance instance = generatedConiferInstances[i];
            float sqrDistance = (instance.Transform.position - target.position).sqrMagnitude;
            ConiferOptimizationTier tier = DetermineConiferTier(
                sqrDistance,
                fullDistanceSq,
                reducedDistanceSq,
                lowDetailDistanceSq);
            ApplyConiferOptimization(instance, tier);
        }
    }

    private void ApplyConiferOptimizationToAll(ConiferOptimizationTier tier)
    {
        generatedConiferInstances.RemoveAll(instance => instance.Root == null);
        for (int i = 0; i < generatedConiferInstances.Count; i++)
        {
            ApplyConiferOptimization(generatedConiferInstances[i], tier);
        }
    }

    private ConiferOptimizationTier DetermineConiferTier(
        float sqrDistance,
        float fullDistanceSq,
        float reducedDistanceSq,
        float lowDetailDistanceSq)
    {
        float culledDistanceSq = culledConiferDistance * culledConiferDistance;
        if (sqrDistance <= fullDistanceSq)
        {
            return ConiferOptimizationTier.Full;
        }

        if (sqrDistance <= reducedDistanceSq)
        {
            return ConiferOptimizationTier.Reduced;
        }

        if (sqrDistance <= lowDetailDistanceSq)
        {
            return ConiferOptimizationTier.LowDetail;
        }

        return sqrDistance <= culledDistanceSq
            ? ConiferOptimizationTier.LowDetail
            : ConiferOptimizationTier.Culled;
    }

    private void ApplyConiferOptimization(GeneratedConiferInstance instance, ConiferOptimizationTier tier)
    {
        if (instance.Root == null || instance.CurrentTier == tier)
        {
            return;
        }

        if (tier == ConiferOptimizationTier.Culled)
        {
            instance.Root.SetActive(false);
            instance.CurrentTier = tier;
            return;
        }

        if (!instance.Root.activeSelf)
        {
            instance.Root.SetActive(true);
        }

        switch (tier)
        {
            case ConiferOptimizationTier.Full:
                SetConiferLodObjects(instance, activeLodIndex: null);
                SetConiferLodGroupEnabled(instance, true);
                SetConiferCollidersEnabled(instance, true);
                RestoreConiferRendererState(instance);
                break;
            case ConiferOptimizationTier.Reduced:
                SetConiferLodObjects(instance, activeLodIndex: null);
                SetConiferLodGroupEnabled(instance, true);
                SetConiferCollidersEnabled(instance, !disableDistantConiferColliders);
                if (disableDistantConiferShadows)
                {
                    SetConiferShadowsEnabled(instance, false);
                }
                else
                {
                    RestoreConiferRendererState(instance);
                }

                break;
            case ConiferOptimizationTier.LowDetail:
                SetConiferLodObjects(instance, activeLodIndex: instance.LowestAvailableLodIndex);
                SetConiferLodGroupEnabled(instance, false);
                SetConiferCollidersEnabled(instance, false);
                if (disableDistantConiferShadows)
                {
                    SetConiferShadowsEnabled(instance, false);
                }
                else
                {
                    RestoreConiferRendererState(instance);
                }

                break;
        }

        instance.CurrentTier = tier;
    }

    private static void SetConiferLodGroupEnabled(GeneratedConiferInstance instance, bool enabled)
    {
        if (instance.LodGroup != null)
        {
            instance.LodGroup.enabled = enabled;
        }
    }

    private static void SetConiferCollidersEnabled(GeneratedConiferInstance instance, bool enabled)
    {
        for (int i = 0; i < instance.Colliders.Length; i++)
        {
            Collider collider = instance.Colliders[i];
            if (collider != null)
            {
                collider.enabled = enabled;
            }
        }
    }

    private static void SetConiferLodObjects(GeneratedConiferInstance instance, int? activeLodIndex)
    {
        GameObject?[] lodObjects = instance.LodObjects;
        if (lodObjects.Length == 0)
        {
            return;
        }

        for (int i = 0; i < lodObjects.Length; i++)
        {
            GameObject? lodObject = lodObjects[i];
            if (lodObject == null)
            {
                continue;
            }

            bool shouldBeActive = !activeLodIndex.HasValue || i == activeLodIndex.Value;
            if (lodObject.activeSelf != shouldBeActive)
            {
                lodObject.SetActive(shouldBeActive);
            }
        }
    }

    private static void SetConiferShadowsEnabled(GeneratedConiferInstance instance, bool enabled)
    {
        for (int i = 0; i < instance.Renderers.Length; i++)
        {
            Renderer renderer = instance.Renderers[i];
            if (renderer == null)
            {
                continue;
            }

            renderer.shadowCastingMode = enabled
                ? instance.OriginalShadowCastingModes[i]
                : ShadowCastingMode.Off;
            renderer.receiveShadows = enabled && instance.OriginalReceiveShadows[i];
        }
    }

    private static void RestoreConiferRendererState(GeneratedConiferInstance instance)
    {
        for (int i = 0; i < instance.Renderers.Length; i++)
        {
            Renderer renderer = instance.Renderers[i];
            if (renderer == null)
            {
                continue;
            }

            renderer.shadowCastingMode = instance.OriginalShadowCastingModes[i];
            renderer.receiveShadows = instance.OriginalReceiveShadows[i];
        }
    }

    private Transform? ResolveConiferOptimizationTarget()
    {
        if (coniferOptimizationTarget != null && coniferOptimizationTarget.gameObject.scene.IsValid())
        {
            return coniferOptimizationTarget;
        }

        if (TryFindSceneTransformWithComponent("CharacterLocomotion", out Transform? locomotionTransform))
        {
            coniferOptimizationTarget = locomotionTransform;
            return coniferOptimizationTarget;
        }

        if (Camera.main != null)
        {
            return Camera.main.transform;
        }

        return null;
    }

    private static bool TryFindSceneTransformWithComponent(string componentTypeName, out Transform? result)
    {
        Transform[] transforms = FindObjectsByType<Transform>(FindObjectsSortMode.None);
        for (int i = 0; i < transforms.Length; i++)
        {
            Transform transform = transforms[i];
            if (transform == null || !transform.gameObject.scene.IsValid())
            {
                continue;
            }

            if (transform.GetComponent(componentTypeName) != null)
            {
                result = transform;
                return true;
            }
        }

        result = null;
        return false;
    }

    private static bool IsConiferPlacement(TileObjectPlacement placement)
    {
        return placement.Definition.NumericId == ConiferObjectNumericId ||
               placement.Definition.Id.Equals(ConiferObjectId, StringComparison.OrdinalIgnoreCase);
    }

    private void EnsureConiferDefinitionRegistered()
    {
        if (TileObjectRegistry.TryGet(ConiferObjectNumericId, out _) ||
            TileObjectRegistry.TryGet(ConiferObjectId, out _))
        {
            return;
        }

        try
        {
            TileObjectRegistry.Register(
                new TileObjectDefinition(
                    ConiferObjectNumericId,
                    ConiferObjectId,
                    "Conifer",
                    TileObjectCategory.Vegetation,
                    new Rgba32(40, 110, 70, 255),
                    prefabPath: DefaultConiferPrefabAssetPath,
                    densityMultiplier: 1.0,
                    vegetationCategory: "tree"));
        }
        catch (InvalidOperationException)
        {
            // Another loader may have registered the definition between the guard and the register call.
        }
    }

    private int GetGeneratedTerrainGroupId()
    {
        int instanceId = Mathf.Abs(GetInstanceID());
        return instanceId == 0 ? 1 : instanceId;
    }

    private IEnumerable<GStylizedTerrain> GetGeneratedTerrains()
    {
        foreach (Transform child in transform)
        {
            if (child == null)
            {
                continue;
            }

            if (child.name != generatedTerrainName &&
                !child.name.StartsWith(generatedTerrainName + "_", StringComparison.Ordinal))
            {
                continue;
            }

            if (child.TryGetComponent(out GStylizedTerrain terrain))
            {
                yield return terrain;
            }
        }
    }

    private void EnsureShadingDefaults()
    {
        lowlandTerrainMaterial ??= LoadDefaultMaterial(DefaultLowlandTerrainMaterialAssetPath);
        midHeightTerrainMaterial ??= LoadDefaultMaterial(DefaultMidHeightTerrainMaterialAssetPath);
        steepSlopeTerrainMaterial ??= LoadDefaultMaterial(DefaultSteepSlopeTerrainMaterialAssetPath);
        peakTerrainMaterial ??= LoadDefaultMaterial(DefaultPeakTerrainMaterialAssetPath);
        lowlandTerrainTileSize = Mathf.Max(1f, lowlandTerrainTileSize);
        midHeightTerrainTileSize = Mathf.Max(1f, midHeightTerrainTileSize);
        steepSlopeTerrainTileSize = Mathf.Max(1f, steepSlopeTerrainTileSize);
        peakTerrainTileSize = Mathf.Max(1f, peakTerrainTileSize);
        midHeightBlend = Mathf.Max(0.01f, midHeightBlend);
        steepSlopeBlendDegrees = Mathf.Max(0.1f, steepSlopeBlendDegrees);
        peakHeightBlend = Mathf.Max(0.01f, peakHeightBlend);
    }

    private void EnsureVegetationDefaults()
    {
        if (string.IsNullOrWhiteSpace(generatedVegetationContainerName))
        {
            generatedVegetationContainerName = "Vegetation";
        }

        fullConiferDistance = Mathf.Max(0f, fullConiferDistance);
        reducedConiferDistance = Mathf.Max(fullConiferDistance, reducedConiferDistance);
        lowDetailConiferDistance = Mathf.Max(reducedConiferDistance, lowDetailConiferDistance);
        culledConiferDistance = Mathf.Max(lowDetailConiferDistance, culledConiferDistance);
        coniferOptimizationInterval = Mathf.Max(0.05f, coniferOptimizationInterval);
    }

    private static Material? LoadDefaultMaterial(string assetPath)
    {
#if UNITY_EDITOR
        return AssetDatabase.LoadAssetAtPath<Material>(assetPath);
#else
        return null;
#endif
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

            if (TryGetObject(pointData, "river_direction", out object? riverObject))
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

            if (TryGetObject(pointData, "sea_current", out object? seaCurrent))
            {
                seaCurrents[y][x] = ConvertToDouble(seaCurrent, 0d);
            }

            if (TryGetObject(pointData, "heightmap_type", out object? typeObject))
            {
                heightmapType[y][x] = ConvertToInt(typeObject, 0);
            }

            if (TryGetObject(pointData, "water_direction", out object? directionObject))
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

    private static IReadOnlyDictionary<string, object> TryGetDictionary(object? value)
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

    private static object? GetValue(IReadOnlyDictionary<string, object> source, string key, object? fallback)
    {
        return source != null && source.TryGetValue(key, out object value) ? value : fallback;
    }

    private static bool TryGetObject(IReadOnlyDictionary<string, object> source, string key, out object? value)
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

    private static int ConvertToInt(object? value, int fallback)
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

    private static double ConvertToDouble(object? value, double fallback)
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

    private static Dictionary<string, double> ToDoubleDictionary(object? value)
    {
        IReadOnlyDictionary<string, object> dictionary = TryGetDictionary(value);
        var result = new Dictionary<string, double>(StringComparer.Ordinal);
        foreach ((string key, object itemValue) in dictionary)
        {
            result[key] = ConvertToDouble(itemValue, 0d);
        }

        return result;
    }

    private static string[] ToStringArray(object? value)
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

    private enum ConiferOptimizationTier
    {
        Unknown = 0,
        Full = 1,
        Reduced = 2,
        LowDetail = 3,
        Culled = 4,
    }

    private sealed class GeneratedConiferInstance
    {
        public GeneratedConiferInstance(GameObject root)
        {
            Root = root;
            Transform = root.transform;
            LodGroup = root.GetComponent<LODGroup>();
            Colliders = root.GetComponentsInChildren<Collider>(true);
            Renderers = root.GetComponentsInChildren<Renderer>(true);
            OriginalShadowCastingModes = new ShadowCastingMode[Renderers.Length];
            OriginalReceiveShadows = new bool[Renderers.Length];
            for (int i = 0; i < Renderers.Length; i++)
            {
                Renderer renderer = Renderers[i];
                OriginalShadowCastingModes[i] = renderer.shadowCastingMode;
                OriginalReceiveShadows[i] = renderer.receiveShadows;
            }

            LodObjects = ExtractLodObjects(LodGroup);
            LowestAvailableLodIndex = FindLowestAvailableLodIndex(LodObjects);
        }

        public GameObject Root { get; }
        public Transform Transform { get; }
        public LODGroup? LodGroup { get; }
        public Collider[] Colliders { get; }
        public Renderer[] Renderers { get; }
        public ShadowCastingMode[] OriginalShadowCastingModes { get; }
        public bool[] OriginalReceiveShadows { get; }
        public GameObject?[] LodObjects { get; }
        public int? LowestAvailableLodIndex { get; }
        public ConiferOptimizationTier CurrentTier { get; set; }

        private static GameObject?[] ExtractLodObjects(LODGroup? lodGroup)
        {
            if (lodGroup == null)
            {
                return Array.Empty<GameObject?>();
            }

            LOD[] lods = lodGroup.GetLODs();
            var lodObjects = new GameObject?[lods.Length];
            for (int i = 0; i < lods.Length; i++)
            {
                Renderer[] renderers = lods[i].renderers;
                if (renderers != null && renderers.Length > 0 && renderers[0] != null)
                {
                    lodObjects[i] = renderers[0].gameObject;
                }
            }

            return lodObjects;
        }

        private static int? FindLowestAvailableLodIndex(GameObject?[] lodObjects)
        {
            for (int i = lodObjects.Length - 1; i >= 0; i--)
            {
                if (lodObjects[i] != null)
                {
                    return i;
                }
            }

            return null;
        }
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

    private enum TerrainShadingMode
    {
        PolarisTextureBlend,
        FallbackLit,
    }
}
