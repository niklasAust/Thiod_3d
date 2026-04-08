using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Serialization;
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
    private const string DefaultLowlandTerrainMaterialAssetPath =
        "Assets/Synty/PolygonNatureBiomes/PNB_Alpine_Mountain/Terrain/Terrain_Materials/grass01.mat";
    private const string DefaultLowlandTerrainMaterialVariantAssetPath =
        "Assets/Synty/PolygonNatureBiomes/PNB_Alpine_Mountain/Terrain/Terrain_Materials/grass02.mat";
    private const string DefaultMidHeightTerrainMaterialAssetPath =
        "Assets/Synty/PolygonNatureBiomes/PNB_Alpine_Mountain/Terrain/Terrain_Materials/pine 1.mat";
    private const string DefaultSteepSlopeTerrainMaterialAssetPath =
        "Assets/Synty/PolygonNatureBiomes/PNB_Alpine_Mountain/Terrain/Terrain_Materials/rocks 2.mat";
    private const string DefaultSteepSlopeTerrainMaterialVariantAssetPath =
        "Assets/Synty/PolygonNatureBiomes/PNB_Alpine_Mountain/Terrain/Terrain_Materials/rocks 3.mat";
    private const string DefaultPeakTerrainMaterialAssetPath =
        "Assets/Synty/PolygonNatureBiomes/PNB_Alpine_Mountain/Terrain/Terrain_Materials/snow.mat";
    private const string DefaultRiverWaterMaterialAssetPath =
        "Assets/Stylized Water 3/Materials/StylizedWater3_River.mat";
    private const double PreviewMaxElevationMeters = 2000.0;
    private const double MaxTileHeightUnits = 42.0;
    private const double MetersPerTileHeightUnit = PreviewMaxElevationMeters / MaxTileHeightUnits;

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

    [Header("River Terrain Carving")]
    [SerializeField, Range(0f, 1f)] private float riverCorridorSmoothingStrength = 0.35f;
    [SerializeField, Min(0)] private int riverCorridorSmoothingKernelRadius = 8;
    [SerializeField, Min(1)] private int riverCorridorSmoothingPasses = 3;
    [SerializeField, Min(0f)] private float riverCorridorDepressionMeters = 2f;
    [SerializeField, Min(0.05f)] private float riverCorridorMaxSlopeMetersPerSample = 1.25f;
    [SerializeField, Min(0.1f)] private float riverCorridorRadiusMultiplier = 1.25f;
    [SerializeField, Min(0)] private int riverCorridorMinRadiusSamples = 16;
    [SerializeField, Range(0f, 1f)] private float riverCorridorFillOuterFeatherStart = 0.72f;
    [SerializeField, Range(0f, 1f)] private float riverCorridorFillOuterFeatherStrength = 1f;
    [SerializeField, Min(0f)] private float riverDepthMultiplier = 0.18f;
    [SerializeField, Min(0f)] private float riverBankDepthMultiplier = 1f;
    [SerializeField, Min(0f)] private float riverCenterDepthMultiplier = 0f;
    [SerializeField, Min(0.05f)] private float riverCenterCarveWidthMultiplier = 1f;
    [SerializeField, Min(0f)] private float riverProfileMinDropMetersPerTile = 0.001f;
    [SerializeField, Min(0f)] private float riverProfileMaxDropMetersPerTile = 6f;
    [SerializeField, Range(0f, 1f)] private float riverCenterCarveSmoothingStrength = 0.35f;
    [SerializeField, Min(1)] private int riverCenterCarveSmoothingKernelRadius = 2;
    [SerializeField, Min(1)] private int riverCenterCarveSmoothingPasses = 1;
    [SerializeField, Range(0f, 1f)] private float riverCenterCarveSmoothingRetainedDepthFraction = 0.35f;
    [SerializeField, Range(0f, 1f)] private float riverBankSmoothingStrength = 0.35f;
    [SerializeField, Min(1)] private int riverBankSmoothingKernelRadius = 3;
    [SerializeField, Min(1)] private int riverBankSmoothingPasses = 1;
    [SerializeField, Min(1)] private int riverBankSmoothingBandRadiusSamples = 4;
    [FormerlySerializedAs("riverCarveWidthMultiplier")]
    [SerializeField, Min(0.1f)] private float riverWidthMultiplier = 1.5f;
    [SerializeField, Min(0f)] private float riverShoulderDepthMultiplier = 2f;

    [Header("Terrain Output")]
    [SerializeField] private string generatedTerrainName = "LoadedTileTerrain";
    [SerializeField] private float terrainWidth = 128f;
    [SerializeField] private float terrainLength = 128f;
    [SerializeField] private float terrainHeight = 30f;
    [SerializeField] private int terrainGridSize = 16;
    [SerializeField] private TerrainShadingMode terrainShadingMode = TerrainShadingMode.PolarisTextureBlend;
    [SerializeField] private string terrainDecalRenderingLayerName = "GroundDecals";
    [SerializeField] private Material? lowlandTerrainMaterial;
    [SerializeField] private Material? lowlandTerrainMaterialVariant;
    [SerializeField] private float lowlandTerrainTileSize = 24f;
    [SerializeField] private Material? midHeightTerrainMaterial;
    [SerializeField] private float midHeightTerrainTileSize = 28f;
    [SerializeField] private Material? steepSlopeTerrainMaterial;
    [SerializeField] private Material? steepSlopeTerrainMaterialVariant;
    [SerializeField] private float steepSlopeTerrainTileSize = 18f;
    [SerializeField] private Material? peakTerrainMaterial;
    [SerializeField] private float peakTerrainTileSize = 26f;
    [SerializeField] private float macroVariationScale = 420f;
    [SerializeField] [Range(0f, 1f)] private float macroVariationStrength = 0.18f;
    [SerializeField] private float surfaceVariantScale = 220f;
    [SerializeField] [Range(0f, 1f)] private float surfaceVariantStrength = 0.85f;
    [SerializeField] [Range(0.01f, 0.49f)] private float surfaceVariantTransition = 0.12f;
    [SerializeField] [Range(0f, 1f)] private float surfacePhaseOffsetStrength = 0.35f;
    [SerializeField] private bool mirrorTerrainVariantTextures = true;
    [SerializeField] private float macroTintScale = 640f;
    [SerializeField] [Range(0f, 1f)] private float macroTintStrength = 0.14f;
    [FormerlySerializedAs("midHeightStart")]
    [SerializeField] private float midHeightStartMeters = 480f;
    [FormerlySerializedAs("midHeightBlend")]
    [SerializeField] private float midHeightBlendMeters = 360f;
    [SerializeField] [Range(0f, 90f)] private float steepSlopeStartDegrees = 24f;
    [SerializeField] [Range(0.1f, 90f)] private float steepSlopeBlendDegrees = 12f;
    [SerializeField] private float ruggedSnowCapHillinessThreshold = 1.2f;
    [SerializeField] private float ruggedSnowCapHillinessBlend = 0.2f;
    [SerializeField] private float ruggedSnowCapBelowPeakMeters = 150f;
    [SerializeField] private float ruggedSnowCapMinStartMeters = 1200f;
    [SerializeField] private float ruggedSnowCapBlendMeters = 140f;
    [SerializeField] private float fullSnowStartMeters = 2500f;
    [SerializeField] private float fullSnowBlendMeters = 260f;
    [SerializeField] [Range(0f, 90f)] private float fullSnowRockSlopeStartDegrees = 48f;
    [SerializeField] [Range(0.1f, 90f)] private float fullSnowRockSlopeBlendDegrees = 12f;

    [Header("Placed Object Output")]
    [FormerlySerializedAs("placeConiferTrees")]
    [SerializeField] private bool placeTreeObjects = true;
    [FormerlySerializedAs("placeGrassClusters")]
    [SerializeField] private bool placeSurfaceObjects = true;
    [SerializeField] private string generatedVegetationContainerName = "Vegetation";
    [FormerlySerializedAs("coniferVerticalOffset")]
    [SerializeField] private float treeObjectVerticalOffset = 0f;
    [FormerlySerializedAs("grassClusterVerticalOffset")]
    [SerializeField] private float surfaceObjectVerticalOffset = 0f;

    [Header("River Water Output")]
    [SerializeField] private bool createRiverWater = true;
    [SerializeField] private string generatedRiverWaterContainerName = "Rivers";
    [SerializeField] private Material? riverWaterMaterial;
    [SerializeField] private string riverWaterMaterialAssetPath = DefaultRiverWaterMaterialAssetPath;
    [SerializeField, Min(0.05f)] private float riverWaterWidthMultiplier = 1.45f;
    [SerializeField, Min(0f)] private float riverWaterBedClearance = 0.18f;
    [SerializeField] private float riverWaterMeshVerticalOffset = 0f;
    [SerializeField, Min(0f)] private float riverWaterMinimumDownstreamDrop = 0.001f;
    [SerializeField, Min(1)] private int riverWaterSampleStride = 1;
    [SerializeField, Min(0.1f)] private float riverWaterUvLengthScale = 12f;
    [SerializeField, Min(0.1f)] private float riverWaterUvWidthScale = 1f;
    [SerializeField, Min(0f)] private float riverWaterSpeedMultiplier = 1f;
    [SerializeField, Min(0f)] private float riverWaterMinSegmentLength = 0.05f;
    [SerializeField, Min(1)] private int riverWaterTangentSmoothingRadius = 4;

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
    [SerializeField] private bool disableDistantConiferDecals = true;

    [Header("Grass Surface Alignment")]
    [SerializeField] private float grassClusterConformSurfaceOffset = -0.1f;

    [Header("Debug")]
    [SerializeField] private bool logHeightStats = true;
    [SerializeField, HideInInspector] private List<GeneratedTerrainShadingMetadata> generatedTerrainShadingMetadata = new();

    private bool hasLoadedInCurrentEnableCycle;
    private bool coniferOptimizationWasActive;
    private float nextConiferOptimizationTime;
    private bool pendingRuntimeSeamRebuild;
    private int runtimeSeamRebuildFrame;
    private bool hasWarnedMissingTerrainDecalRenderingLayer;
#if UNITY_EDITOR
    private bool pendingEditorSeamRebuild;
#endif
    private readonly List<GeneratedConiferInstance> generatedConiferInstances = new();

    private void OnEnable()
    {
        hasLoadedInCurrentEnableCycle = false;

        if (ShouldLoadOnEnableInEditMode())
        {
            LoadTileIntoScene();
        }
#if UNITY_EDITOR
        else if (!Application.isPlaying && loadOnEnableInEditMode && HasGeneratedTerrains())
        {
            ScheduleEditorTerrainSeamRebuild();
        }
#endif
    }

    private void Start()
    {
        if (Application.isPlaying && loadOnStartInPlayMode)
        {
            LoadTileIntoScene();
            return;
        }

        if (Application.isPlaying && HasGeneratedTerrains())
        {
            RegisterExistingGeneratedTreeObjects();
            AlignExistingGeneratedSurfaceObjects();
            ScheduleRuntimeTerrainSeamRebuild();
            UpdateConiferOptimization(forceFullIfNoTarget: true);
        }
    }

    private void Update()
    {
        if (!Application.isPlaying)
        {
            return;
        }

        if (pendingRuntimeSeamRebuild && Time.frameCount >= runtimeSeamRebuildFrame)
        {
            pendingRuntimeSeamRebuild = false;
            RebuildExistingGeneratedTerrainSeams();
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
        hasWarnedMissingTerrainDecalRenderingLayer = false;
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
            ApplyTerrainDecalRenderingLayer(terrain);
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

            var tileGenerator = new TileGenerator(loadedWorldData.WorldData, loadedWorldData.Seed);
            ConfigureTileGenerator(tileGenerator);
            CreateOrUpdateTerrains(tileGenerator, loadedWorldData, settings);
            hasLoadedInCurrentEnableCycle = true;
        }
        catch (Exception ex)
        {
            Debug.LogException(ex, this);
        }
#endif
    }

    private void ConfigureTileGenerator(TileGenerator tileGenerator)
    {
        tileGenerator.RiverCarveSettings = new RiverCarveSettings
        {
            DepthMultiplier = Math.Max(0f, riverDepthMultiplier),
            BankDepthMultiplier = Math.Max(0f, riverBankDepthMultiplier),
            CenterDepthMultiplier = Math.Max(0f, riverCenterDepthMultiplier),
            CenterCarveWidthMultiplier = Math.Max(0.05f, riverCenterCarveWidthMultiplier),
            WaterWidthMultiplier = Math.Max(0.05f, riverWaterWidthMultiplier),
            ChannelProfileExponent = 1f,
            RiverWidthMultiplier = Math.Max(0.1f, riverWidthMultiplier),
            ShoulderRadiusMultiplier = Math.Max(0.1f, riverWidthMultiplier),
            ShoulderDepthMultiplier = Math.Max(0f, riverShoulderDepthMultiplier),
            ShoulderFalloffExponent = 1f,
            RiverProfileMinDropMetersPerTile = Math.Max(0f, riverProfileMinDropMetersPerTile),
            RiverProfileMaxDropMetersPerTile = Math.Max(riverProfileMinDropMetersPerTile, riverProfileMaxDropMetersPerTile),
            CorridorSmoothingStrength = Mathf.Clamp01(riverCorridorSmoothingStrength),
            CorridorSmoothingKernelRadius = Math.Max(0, riverCorridorSmoothingKernelRadius),
            CorridorSmoothingPasses = Math.Max(1, riverCorridorSmoothingPasses),
            CorridorDepressionMeters = Math.Max(0f, riverCorridorDepressionMeters),
            CorridorMaxSlopeMetersPerSample = Math.Max(0.05f, riverCorridorMaxSlopeMetersPerSample),
            CorridorRadiusMultiplier = Math.Max(0.1f, riverCorridorRadiusMultiplier),
            CorridorMinRadiusSamples = Math.Max(0, riverCorridorMinRadiusSamples),
            CorridorFillOuterFeatherStart = Mathf.Clamp01(riverCorridorFillOuterFeatherStart),
            CorridorFillOuterFeatherStrength = Mathf.Clamp01(riverCorridorFillOuterFeatherStrength),
            BankSmoothingStrength = Mathf.Clamp01(riverBankSmoothingStrength),
            BankSmoothingKernelRadius = Math.Max(1, riverBankSmoothingKernelRadius),
            BankSmoothingPasses = Math.Max(1, riverBankSmoothingPasses),
            BankSmoothingBandRadiusSamples = Math.Max(1, riverBankSmoothingBandRadiusSamples),
            CenterSmoothingStrength = Mathf.Clamp01(riverCenterCarveSmoothingStrength),
            CenterSmoothingKernelRadius = Math.Max(1, riverCenterCarveSmoothingKernelRadius),
            CenterSmoothingPasses = Math.Max(1, riverCenterCarveSmoothingPasses),
            CenterSmoothingRetainedDepthFraction = Mathf.Clamp01(riverCenterCarveSmoothingRetainedDepthFraction),
        };
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

    private void ScheduleRuntimeTerrainSeamRebuild()
    {
        pendingRuntimeSeamRebuild = true;
        runtimeSeamRebuildFrame = Time.frameCount + 1;
    }

#if UNITY_EDITOR
    private void ScheduleEditorTerrainSeamRebuild()
    {
        if (pendingEditorSeamRebuild)
        {
            return;
        }

        pendingEditorSeamRebuild = true;
        EditorApplication.delayCall += RunDeferredEditorSeamRebuild;
    }

    private void RunDeferredEditorSeamRebuild()
    {
        EditorApplication.delayCall -= RunDeferredEditorSeamRebuild;
        pendingEditorSeamRebuild = false;

        if (this == null ||
            gameObject == null ||
            !gameObject.activeInHierarchy ||
            Application.isPlaying ||
            EditorApplication.isPlayingOrWillChangePlaymode ||
            !HasGeneratedTerrains())
        {
            return;
        }

        RebuildExistingGeneratedTerrainSeams();
    }
#endif

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
                    tileMaxHeight,
                    GetCenterTileHilliness(layers)));
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
                request.TileHilliness,
                terrainGroupId);
            createdTerrains.Add(terrain);
        }

        if (createdTerrains.Count > 0)
        {
            RebuildTerrainSeams(createdTerrains);
            ApplyTerrainShading(createdTerrains);
            PopulateRiverWater(terrainsToCreate, createdTerrains, normalizationMinHeight, normalizationMaxHeight);
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
        generatedTerrainShadingMetadata.Clear();
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
        double tileHilliness,
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
        ConfigureShading(
            terrainData,
            texturingModel,
            layers.Heightmap,
            normalizationMinHeight,
            normalizationMaxHeight,
            localMaxHeight,
            tileHilliness);

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
        SetTerrainShadingMetadata(
            terrainObjectName,
            normalizationMinHeight,
            normalizationMaxHeight,
            TileHeightUnitsToMeters(localMaxHeight),
            tileHilliness);
        terrain.TerrainData.Shading.UpdateMaterials();
        ApplyWorldAlignedSplatMaterialOffsets(terrain);
        ApplyTerrainDecalRenderingLayer(terrain);

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
        double normalizationMaxHeight,
        double localMaxHeight,
        double tileHilliness)
    {
        Material material = CreateTerrainMaterial(texturingModel);
        Polaris.SetTerrainMaterial(terrainData, material);
        ApplyTerrainShading(
            terrainData,
            sourceHeightmap,
            normalizationMinHeight,
            normalizationMaxHeight,
            localMaxHeight,
            tileHilliness);
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

        GSplatsModel splatsModel = terrainShadingMode == TerrainShadingMode.PolarisTextureBlend
            ? GSplatsModel.Splats8
            : GSplatsModel.Splats4;

        if (Polaris.InitTerrainMaterial(material, GLightingModel.PBR, texturingModel, splatsModel))
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
        double normalizationMaxHeight,
        double localMaxHeight,
        double tileHilliness)
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

        float[,] normalizedHeights = BuildNormalizedHeights(sourceHeightmap);
        float[,] heightMeters = BuildHeightMeters(sourceHeightmap);
        ApplyTextureBlendSettings(
            terrainData.Shading,
            terrainData,
            normalizedHeights,
            heightMeters,
            TileHeightUnitsToMeters(localMaxHeight),
            (float)tileHilliness,
            null);
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
            ApplyTerrainDecalRenderingLayer(terrain);
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
        GeneratedTerrainShadingMetadata? shadingMetadata = GetTerrainShadingMetadata(terrain.name);
        float[,] heightMeters = BuildHeightMetersFromNormalizedHeights(
            normalizedHeights,
            0.0,
            MaxTileHeightUnits);
        float localMaxHeightMeters = shadingMetadata.HasValue && shadingMetadata.Value.LocalMaxHeightMeters > 0f
            ? shadingMetadata.Value.LocalMaxHeightMeters
            : EstimateMaxHeightMeters(heightMeters);
        float tileHilliness = shadingMetadata.HasValue && shadingMetadata.Value.TileHilliness > 0.0
            ? (float)shadingMetadata.Value.TileHilliness
            : EstimateTileHilliness(heightMeters);
        if (!shadingMetadata.HasValue)
        {
            SetTerrainShadingMetadata(
                terrain.name,
                0.0,
                MaxTileHeightUnits,
                localMaxHeightMeters,
                tileHilliness);
        }
        else if (shadingMetadata.Value.LocalMaxHeightMeters <= 0f || shadingMetadata.Value.TileHilliness <= 0.0)
        {
            SetTerrainShadingMetadata(
                terrain.name,
                shadingMetadata.Value.NormalizationMinHeight,
                shadingMetadata.Value.NormalizationMaxHeight,
                localMaxHeightMeters,
                tileHilliness);
        }

        ApplyTextureBlendSettings(
            terrain.TerrainData.Shading,
            terrain.TerrainData,
            normalizedHeights,
            heightMeters,
            localMaxHeightMeters,
            tileHilliness,
            terrain);
    }

    private void ApplyTextureBlendSettings(
        GShading shading,
        GTerrainData terrainData,
        float[,] normalizedHeights,
        float[,] heightMeters,
        float localMaxHeightMeters,
        float tileHilliness,
        GStylizedTerrain? terrain)
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
            CreateSplatPrototype(lowlandTerrainMaterialVariant ?? lowlandTerrainMaterial, lowlandTerrainTileSize),
            CreateSplatPrototype(midHeightTerrainMaterial, midHeightTerrainTileSize),
            CreateSplatPrototype(steepSlopeTerrainMaterial, steepSlopeTerrainTileSize),
            CreateSplatPrototype(steepSlopeTerrainMaterialVariant ?? steepSlopeTerrainMaterial, steepSlopeTerrainTileSize),
            CreateSplatPrototype(peakTerrainMaterial, peakTerrainTileSize),
        };

        shading.SplatControlResolution = Mathf.Max(32, Mathf.Max(normalizedHeights.GetLength(0), normalizedHeights.GetLength(1)));
        shading.SetAlphamaps(BuildTextureBlendAlphamaps(normalizedHeights, heightMeters, localMaxHeightMeters, tileHilliness, terrain));
    }

    private float[,,] BuildTextureBlendAlphamaps(
        float[,] normalizedHeights,
        float[,] heightMeters,
        float localMaxHeightMeters,
        float tileHilliness,
        GStylizedTerrain? terrain)
    {
        int resolutionY = normalizedHeights.GetLength(0);
        int resolutionX = normalizedHeights.GetLength(1);
        const int layerCount = 6;
        var alphamaps = new float[resolutionY, resolutionX, layerCount];
        float sampleSpacingX = resolutionX > 1 ? terrainWidth / (resolutionX - 1f) : terrainWidth;
        float sampleSpacingZ = resolutionY > 1 ? terrainLength / (resolutionY - 1f) : terrainLength;
        Vector2 terrainOrigin = terrain != null
            ? new Vector2(terrain.transform.localPosition.x, terrain.transform.localPosition.z)
            : Vector2.zero;
        float ruggedSnowCapWeight = SmoothRange(tileHilliness, ruggedSnowCapHillinessThreshold, ruggedSnowCapHillinessBlend);
        float ruggedSnowCapStart = Mathf.Max(
            ruggedSnowCapMinStartMeters,
            localMaxHeightMeters - ruggedSnowCapBelowPeakMeters);
        float effectiveCapSnowBlend = Mathf.Lerp(fullSnowBlendMeters, ruggedSnowCapBlendMeters, ruggedSnowCapWeight);

        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                float worldX = terrainOrigin.x + x * sampleSpacingX;
                float worldZ = terrainOrigin.y + (resolutionY - 1 - y) * sampleSpacingZ;
                float absoluteHeightMeters = heightMeters[y, x];
                float macroBias = SampleSignedNoise(worldX, worldZ, macroVariationScale) * macroVariationStrength;
                float adjustedMidStart = Mathf.Max(0f, midHeightStartMeters + macroBias * 180f);
                float adjustedFullSnowStart = Mathf.Max(0f, fullSnowStartMeters + macroBias * 220f);
                float adjustedSlopeStart = Mathf.Clamp(steepSlopeStartDegrees + macroBias * 18f, 0f, 90f);
                float adjustedFullSnowRockSlope = Mathf.Clamp(fullSnowRockSlopeStartDegrees + macroBias * 6f, 0f, 90f);
                float slopeDegrees = terrain != null
                    ? SampleSlopeDegrees(terrain, normalizedHeights, x, y, sampleSpacingX, sampleSpacingZ)
                    : SampleSlopeDegrees(normalizedHeights, x, y, sampleSpacingX, sampleSpacingZ);
                float effectiveCapSnowStart = Mathf.Lerp(adjustedFullSnowStart, ruggedSnowCapStart, ruggedSnowCapWeight);
                float capSnowWeight = ruggedSnowCapWeight * SmoothRange(absoluteHeightMeters, effectiveCapSnowStart, effectiveCapSnowBlend);
                float highAltitudeSnowWeight = SmoothRange(absoluteHeightMeters, adjustedFullSnowStart, fullSnowBlendMeters);
                float steepRockInSnowWeight = SmoothRange(slopeDegrees, adjustedFullSnowRockSlope, fullSnowRockSlopeBlendDegrees);
                float snowWeight = Mathf.Max(capSnowWeight, highAltitudeSnowWeight);
                float peakWeight = snowWeight * (1f - steepRockInSnowWeight);
                float baseCliffWeight = SmoothRange(slopeDegrees, adjustedSlopeStart, steepSlopeBlendDegrees);
                float cliffWeight = Mathf.Max(baseCliffWeight * (1f - peakWeight * 0.25f), snowWeight * steepRockInSnowWeight);
                float midWeight = SmoothRange(absoluteHeightMeters, adjustedMidStart, midHeightBlendMeters) * (1f - peakWeight);
                float lowWeight = 1f - Mathf.Clamp01(midWeight + peakWeight);

                lowWeight *= 1f - cliffWeight;
                midWeight *= 1f - cliffWeight * 0.75f;

                float macroTintBias = SampleSignedNoise(worldX + 173.2f, worldZ - 91.7f, macroTintScale) * macroTintStrength;
                float lowlandVariantMix = SharpenVariantMix(
                    0.5f +
                    SampleSignedNoise(worldX - 47.3f, worldZ + 128.4f, surfaceVariantScale) * 0.5f * surfaceVariantStrength +
                    macroTintBias,
                    surfaceVariantTransition);
                float rockVariantMix = SharpenVariantMix(
                    0.5f +
                    SampleSignedNoise(worldX + 281.6f, worldZ + 54.1f, surfaceVariantScale * 0.85f) * 0.5f * surfaceVariantStrength +
                    macroTintBias * 0.75f,
                    surfaceVariantTransition);
                float lowWeightPrimary = lowWeight * (1f - lowlandVariantMix);
                float lowWeightVariant = lowWeight * lowlandVariantMix;
                float cliffWeightPrimary = cliffWeight * (1f - rockVariantMix);
                float cliffWeightVariant = cliffWeight * rockVariantMix;

                float total = lowWeightPrimary + lowWeightVariant + midWeight + cliffWeightPrimary + cliffWeightVariant + peakWeight;
                if (total <= 1e-5f)
                {
                    lowWeightPrimary = 1f;
                    lowWeightVariant = 0f;
                    midWeight = 0f;
                    cliffWeightPrimary = 0f;
                    cliffWeightVariant = 0f;
                    peakWeight = 0f;
                    total = 1f;
                }

                int flippedY = resolutionY - 1 - y;
                alphamaps[flippedY, x, 0] = lowWeightPrimary / total;
                alphamaps[flippedY, x, 1] = lowWeightVariant / total;
                alphamaps[flippedY, x, 2] = midWeight / total;
                alphamaps[flippedY, x, 3] = cliffWeightPrimary / total;
                alphamaps[flippedY, x, 4] = cliffWeightVariant / total;
                alphamaps[flippedY, x, 5] = peakWeight / total;
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

    private static float[,] BuildNormalizedHeights(double[,] sourceHeightmap)
    {
        int resolutionY = sourceHeightmap.GetLength(0);
        int resolutionX = sourceHeightmap.GetLength(1);
        var normalizedHeights = new float[resolutionY, resolutionX];

        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                normalizedHeights[y, x] = NormalizeHeightUnitsToTerrain(sourceHeightmap[y, x]);
            }
        }

        return normalizedHeights;
    }

    private static float[,] BuildHeightMeters(double[,] sourceHeightmap)
    {
        int resolutionY = sourceHeightmap.GetLength(0);
        int resolutionX = sourceHeightmap.GetLength(1);
        var heightMeters = new float[resolutionY, resolutionX];

        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                heightMeters[y, x] = TileHeightUnitsToMeters(sourceHeightmap[y, x]);
            }
        }

        return heightMeters;
    }

    private static float[,] BuildHeightMetersFromNormalizedHeights(float[,] normalizedHeights, double minHeightUnits, double maxHeightUnits)
    {
        int resolutionY = normalizedHeights.GetLength(0);
        int resolutionX = normalizedHeights.GetLength(1);
        var heightMeters = new float[resolutionY, resolutionX];
        double rangeUnits = Math.Max(maxHeightUnits - minHeightUnits, 1e-6);

        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                double heightUnits = minHeightUnits + normalizedHeights[y, x] * rangeUnits;
                heightMeters[y, x] = TileHeightUnitsToMeters(heightUnits);
            }
        }

        return heightMeters;
    }

    private static float TileHeightUnitsToMeters(double heightUnits)
    {
        return (float)Math.Max(0.0, heightUnits * MetersPerTileHeightUnit);
    }

    private static float EstimateMaxHeightMeters(float[,] heightMeters)
    {
        float maxHeightMeters = 0f;
        int resolutionY = heightMeters.GetLength(0);
        int resolutionX = heightMeters.GetLength(1);
        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                maxHeightMeters = Mathf.Max(maxHeightMeters, heightMeters[y, x]);
            }
        }

        return maxHeightMeters;
    }

    private static float EstimateTileHilliness(float[,] heightMeters)
    {
        return (float)TerrainUtils.ElevationToHilliness(EstimateMaxHeightMeters(heightMeters));
    }

    private GeneratedTerrainShadingMetadata? GetTerrainShadingMetadata(string terrainName)
    {
        for (int i = 0; i < generatedTerrainShadingMetadata.Count; i++)
        {
            if (string.Equals(generatedTerrainShadingMetadata[i].TerrainName, terrainName, StringComparison.Ordinal))
            {
                return generatedTerrainShadingMetadata[i];
            }
        }

        return null;
    }

    private void SetTerrainShadingMetadata(
        string terrainName,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        float localMaxHeightMeters,
        double tileHilliness)
    {
        for (int i = 0; i < generatedTerrainShadingMetadata.Count; i++)
        {
            if (string.Equals(generatedTerrainShadingMetadata[i].TerrainName, terrainName, StringComparison.Ordinal))
            {
                generatedTerrainShadingMetadata[i] = new GeneratedTerrainShadingMetadata(
                    terrainName,
                    normalizationMinHeight,
                    normalizationMaxHeight,
                    localMaxHeightMeters,
                    tileHilliness);
                return;
            }
        }

        generatedTerrainShadingMetadata.Add(new GeneratedTerrainShadingMetadata(
            terrainName,
            normalizationMinHeight,
            normalizationMaxHeight,
            localMaxHeightMeters,
            tileHilliness));
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
        ApplyWorldAlignedSplatOffset(material, "_Splat0", lowlandTerrainTileSize, origin, 0);
        ApplyWorldAlignedSplatOffset(material, "_Splat1", lowlandTerrainTileSize, origin, 1);
        ApplyWorldAlignedSplatOffset(material, "_Splat2", midHeightTerrainTileSize, origin, 2);
        ApplyWorldAlignedSplatOffset(material, "_Splat3", steepSlopeTerrainTileSize, origin, 3);
        ApplyWorldAlignedSplatOffset(material, "_Splat4", steepSlopeTerrainTileSize, origin, 4);
        ApplyWorldAlignedSplatOffset(material, "_Splat5", peakTerrainTileSize, origin, 5);
    }

    private void ApplyWorldAlignedSplatOffset(Material material, string propertyName, float tileSize, Vector3 terrainOrigin, int variationSeed)
    {
        if (material == null || !material.HasProperty(propertyName))
        {
            return;
        }

        float safeTileSize = Mathf.Max(1f, tileSize);
        Vector2 sign = ComputeSplatScaleSign(variationSeed);
        Vector2 phaseOffset = ComputeSplatPhaseOffset(variationSeed);
        material.SetTextureScale(propertyName, new Vector2((terrainWidth / safeTileSize) * sign.x, (terrainLength / safeTileSize) * sign.y));
        material.SetTextureOffset(
            propertyName,
            new Vector2((terrainOrigin.x / safeTileSize) * sign.x, (terrainOrigin.z / safeTileSize) * sign.y) + phaseOffset);
    }

    private void ApplyTerrainDecalRenderingLayer(GStylizedTerrain terrain)
    {
        if (terrain == null)
        {
            return;
        }

        uint terrainDecalRenderingLayerMask = GetTerrainDecalRenderingLayerMask();
        if (terrainDecalRenderingLayerMask == 0u)
        {
            return;
        }

        GTerrainChunk[] chunks = terrain.GetChunks();
        for (int i = 0; i < chunks.Length; i++)
        {
            MeshRenderer? renderer = chunks[i]?.MeshRendererComponent;
            if (renderer == null)
            {
                continue;
            }

            renderer.renderingLayerMask |= terrainDecalRenderingLayerMask;
        }
    }

    private uint GetTerrainDecalRenderingLayerMask()
    {
        string layerName = string.IsNullOrWhiteSpace(terrainDecalRenderingLayerName)
            ? string.Empty
            : terrainDecalRenderingLayerName.Trim();
        if (string.IsNullOrEmpty(layerName))
        {
            return 0u;
        }

        uint mask = RenderingLayerMask.GetMask(layerName);
        if (mask == 0u && !hasWarnedMissingTerrainDecalRenderingLayer)
        {
            hasWarnedMissingTerrainDecalRenderingLayer = true;
            Debug.LogWarning(
                $"TileLoader could not find rendering layer '{layerName}'. Generated terrain chunks will not receive the ground decal rendering layer until it exists in URP Global Settings.",
                this);
        }

        return mask;
    }

    private static float SmoothRange(float value, float start, float blend)
    {
        return Mathf.SmoothStep(0f, 1f, Mathf.Clamp01((value - start) / Mathf.Max(1e-4f, blend)));
    }

    private static float SampleSignedNoise(float worldX, float worldZ, float scale)
    {
        float safeScale = Mathf.Max(1f, scale);
        float noise =
            Mathf.PerlinNoise(worldX / safeScale + 11.37f, worldZ / safeScale + 29.51f) * 0.55f +
            Mathf.PerlinNoise(worldX / (safeScale * 0.47f) - 73.19f, worldZ / (safeScale * 0.47f) + 41.63f) * 0.3f +
            Mathf.PerlinNoise(worldX / (safeScale * 1.91f) + 101.8f, worldZ / (safeScale * 1.91f) - 17.24f) * 0.15f;
        return Mathf.Clamp01(noise) * 2f - 1f;
    }

    private static float SharpenVariantMix(float rawMix, float transition)
    {
        float clampedMix = Mathf.Clamp01(rawMix);
        float halfTransition = Mathf.Clamp(transition, 0.01f, 0.49f);
        float lowerBound = 0.5f - halfTransition;
        float upperBound = 0.5f + halfTransition;
        return Mathf.SmoothStep(0f, 1f, Mathf.InverseLerp(lowerBound, upperBound, clampedMix));
    }

    private Vector2 ComputeSplatScaleSign(int variationSeed)
    {
        if (!mirrorTerrainVariantTextures)
        {
            return Vector2.one;
        }

        return new Vector2((variationSeed & 1) == 0 ? 1f : -1f, (variationSeed & 2) == 0 ? 1f : -1f);
    }

    private Vector2 ComputeSplatPhaseOffset(int variationSeed)
    {
        float strength = Mathf.Clamp01(surfacePhaseOffsetStrength);
        if (strength <= 0f)
        {
            return Vector2.zero;
        }

        float offsetX = (Hash01(variationSeed * 92821 + 17) * 2f - 1f) * strength;
        float offsetY = (Hash01(variationSeed * 68917 + 53) * 2f - 1f) * strength;
        return new Vector2(offsetX, offsetY);
    }

    private static float Hash01(int seed)
    {
        unchecked
        {
            uint value = (uint)seed;
            value ^= value >> 16;
            value *= 0x7FEB352Du;
            value ^= value >> 15;
            value *= 0x846CA68Bu;
            value ^= value >> 16;
            return (value & 0x00FFFFFFu) / 16777215f;
        }
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
            ApplyTerrainDecalRenderingLayer(terrain);
        }
    }

    private void RebuildExistingGeneratedTerrainSeams()
    {
        var terrains = new List<GStylizedTerrain>();
        foreach (GStylizedTerrain terrain in GetGeneratedTerrains())
        {
            if (terrain != null && terrain.TerrainData != null)
            {
                terrains.Add(terrain);
            }
        }

        if (terrains.Count == 0)
        {
            return;
        }

        RebuildTerrainSeams(terrains);
        ApplyTerrainShading(terrains);
    }

    private void PopulateRiverWater(
        IReadOnlyList<GeneratedTerrainRequest> terrainRequests,
        IReadOnlyList<GStylizedTerrain> terrains,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        if (!createRiverWater)
        {
            return;
        }

        Material? waterMaterial = null;
        var riverWaterSeams = new Dictionary<string, RiverWaterSeamCrossSection>(StringComparer.Ordinal);
        int terrainCount = Math.Min(terrainRequests.Count, terrains.Count);
        for (int i = 0; i < terrainCount; i++)
        {
            GeneratedTerrainRequest request = terrainRequests[i];
            IReadOnlyList<RiverSurfacePath> riverPaths = request.Layers.RiverSurfacePaths;
            if (riverPaths.Count == 0)
            {
                continue;
            }

            waterMaterial ??= ResolveRiverWaterMaterial();
            if (waterMaterial == null)
            {
                Debug.LogWarning(
                    $"TileLoader could not resolve the Stylized Water river material at '{GetRiverWaterMaterialAssetPath()}'. Generated river meshes were skipped.",
                    this);
                return;
            }

            GStylizedTerrain terrain = terrains[i];
            if (terrain == null)
            {
                continue;
            }

            Transform riverContainer = CreateRiverWaterContainer(terrain.transform);
            Mesh? riverMesh = BuildRiverWaterMesh(
                terrain,
                request.Layers.RiverSurfaceHeightmap ?? request.Layers.Heightmap,
                riverPaths,
                request.Layers.RiverInfo,
                riverWaterSeams,
            request.Layers.RiverUsesProfile,
                normalizationMinHeight,
                normalizationMaxHeight);
            if (riverMesh == null)
            {
                continue;
            }

            var riverObject = new GameObject("RiverWater");
            riverObject.transform.SetParent(riverContainer, false);
            riverObject.transform.localPosition = Vector3.zero;
            riverObject.transform.localRotation = Quaternion.identity;
            riverObject.transform.localScale = Vector3.one;
            ApplyRiverWaterLayer(riverObject);

            MeshFilter meshFilter = riverObject.AddComponent<MeshFilter>();
            meshFilter.sharedMesh = riverMesh;

            MeshRenderer meshRenderer = riverObject.AddComponent<MeshRenderer>();
            meshRenderer.sharedMaterial = waterMaterial;
            ApplyRiverWaterMaterialOverrides(meshRenderer, waterMaterial);
            meshRenderer.shadowCastingMode = ShadowCastingMode.Off;
            meshRenderer.receiveShadows = false;
        }
    }

    private void ApplyRiverWaterMaterialOverrides(MeshRenderer meshRenderer, Material waterMaterial)
    {
        float speedMultiplier = Mathf.Max(0f, riverWaterSpeedMultiplier);
        if (Mathf.Approximately(speedMultiplier, 1f))
        {
            return;
        }

        var propertyBlock = new MaterialPropertyBlock();
        meshRenderer.GetPropertyBlock(propertyBlock);
        ApplyScaledMaterialFloat(propertyBlock, waterMaterial, "_Speed", speedMultiplier);
        ApplyScaledMaterialFloat(propertyBlock, waterMaterial, "_NormalSpeed", speedMultiplier);
        ApplyScaledMaterialFloat(propertyBlock, waterMaterial, "_FoamSpeed", speedMultiplier);
        ApplyScaledMaterialFloat(propertyBlock, waterMaterial, "_FoamSubSpeed", speedMultiplier);
        ApplyScaledMaterialFloat(propertyBlock, waterMaterial, "_IntersectionSpeed", speedMultiplier);
        ApplyScaledMaterialFloat(propertyBlock, waterMaterial, "_WaveSpeed", speedMultiplier);
        ApplyScaledMaterialFloat(propertyBlock, waterMaterial, "_SlopeSpeed", speedMultiplier);
        meshRenderer.SetPropertyBlock(propertyBlock);
    }

    private static void ApplyScaledMaterialFloat(
        MaterialPropertyBlock propertyBlock,
        Material sourceMaterial,
        string propertyName,
        float multiplier)
    {
        if (!sourceMaterial.HasProperty(propertyName))
        {
            return;
        }

        propertyBlock.SetFloat(propertyName, sourceMaterial.GetFloat(propertyName) * multiplier);
    }

    private Mesh? BuildRiverWaterMesh(
        GStylizedTerrain? terrain,
        double[,] heightmap,
        IReadOnlyList<RiverSurfacePath> riverPaths,
        RiverInfo? riverInfo,
        IDictionary<string, RiverWaterSeamCrossSection> riverWaterSeams,
        bool usesRiverProfile,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        var combineInstances = new List<CombineInstance>();
        int vertexCount = 0;

        for (int i = 0; i < riverPaths.Count; i++)
        {
            Mesh? pathMesh = BuildRiverWaterMesh(
                terrain,
                heightmap,
                riverPaths[i],
                riverInfo,
                riverWaterSeams,
                usesRiverProfile,
                normalizationMinHeight,
                normalizationMaxHeight);
            if (pathMesh == null)
            {
                continue;
            }

            vertexCount += pathMesh.vertexCount;
            combineInstances.Add(new CombineInstance
            {
                mesh = pathMesh,
                transform = Matrix4x4.identity,
            });
        }

        if (combineInstances.Count == 0)
        {
            return null;
        }

        if (combineInstances.Count == 1)
        {
            combineInstances[0].mesh.name = "Generated River Water Mesh";
            return combineInstances[0].mesh;
        }

        var combinedMesh = new Mesh
        {
            name = "Generated River Water Mesh"
        };
        if (vertexCount > ushort.MaxValue)
        {
            combinedMesh.indexFormat = IndexFormat.UInt32;
        }

        combinedMesh.CombineMeshes(combineInstances.ToArray(), true, false, false);
        combinedMesh.RecalculateBounds();
        combinedMesh.RecalculateNormals();
        combinedMesh.RecalculateTangents();
        return combinedMesh;
    }

    private Mesh? BuildRiverWaterMesh(
        GStylizedTerrain? terrain,
        double[,] heightmap,
        RiverSurfacePath riverPath,
        RiverInfo? riverInfo,
        IDictionary<string, RiverWaterSeamCrossSection> riverWaterSeams,
        bool usesRiverProfile,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        IReadOnlyList<RiverSurfacePoint> pathPoints = riverPath.Points;
        if (pathPoints.Count < 2 || riverPath.HalfWidthPixels <= 0.0)
        {
            return null;
        }

        var centers = new List<Vector3>();
        var sampledPoints = new List<RiverSurfacePoint>();
        var sampleSeams = new List<(bool IsSeam, string? Direction, bool IsStart)>();
        int stride = Math.Max(1, riverWaterSampleStride);
        for (int i = 0; i < pathPoints.Count; i += stride)
        {
            AddRiverWaterSample(i, force: false);
        }

        AddRiverWaterSample(pathPoints.Count - 1, force: true);

        if (centers.Count < 2)
        {
            return null;
        }

        int heightResolution = heightmap.GetLength(0);
        int widthResolution = heightmap.GetLength(1);
        float sampleSpacingX = widthResolution > 1 ? terrainWidth / (widthResolution - 1) : terrainWidth;
        float sampleSpacingZ = heightResolution > 1 ? terrainLength / (heightResolution - 1) : terrainLength;
        float metersPerSample = Mathf.Max(0.001f, (sampleSpacingX + sampleSpacingZ) * 0.5f);
        float baseHalfWidth = Mathf.Max(
            0.05f,
            (float)riverPath.HalfWidthPixels * metersPerSample * Mathf.Max(0.05f, riverWaterWidthMultiplier));
        float uvLengthScale = Mathf.Max(0.1f, riverWaterUvLengthScale);
        float uvWidthScale = Mathf.Max(0.1f, riverWaterUvWidthScale);
        float fadeFraction = Mathf.Clamp01((float)riverPath.FadeFraction);
        int tangentSmoothingRadius = Math.Max(1, riverWaterTangentSmoothingRadius);

        ApplyRiverWaterSurfaceHeights();
        ApplyRiverWaterSeamCenterCache();
        SmoothRiverWaterSeamAdjacentHeights();

        var vertices = new List<Vector3>(centers.Count * 2);
        var uvs = new List<Vector2>(centers.Count * 2);
        var colors = new List<Color>(centers.Count * 2);
        var triangles = new List<int>(Mathf.Max(0, centers.Count - 1) * 6);
        float downstreamDistance = 0f;

        for (int i = 0; i < centers.Count; i++)
        {
            if (i > 0)
            {
                downstreamDistance += HorizontalDistance(centers[i - 1], centers[i]);
            }

            Vector3 tangent = GetRiverWaterTangent(centers, sampledPoints, i, tangentSmoothingRadius);
            var seam = GetTileEdgeSeamInfluence(i);
            bool isTileEdgeSeam = seam.IsSeam && seam.Weight >= 0.999f;
            if (seam.IsSeam &&
                TryGetRiverWaterSeamTangent(seam.Direction, seam.IsStart, out Vector3 seamTangent))
            {
                tangent = isTileEdgeSeam
                    ? seamTangent
                    : Vector3.Slerp(tangent, seamTangent, Mathf.Clamp01(seam.Weight)).normalized;
            }

            Vector3 right = new(tangent.z, 0f, -tangent.x);
            if (right.sqrMagnitude <= 0.0001f)
            {
                right = Vector3.right;
            }
            else
            {
                right.Normalize();
            }

            float branchT = centers.Count > 1 ? i / (float)(centers.Count - 1) : 0f;
            float widthFactor = 1f;
            if (fadeFraction > 0f)
            {
                widthFactor = 1f - Mathf.InverseLerp(1f - fadeFraction, 1f, branchT);
            }

            float halfWidth = isTileEdgeSeam
                ? GetRiverWaterSeamHalfWidth(seam.Direction, seam.IsStart, baseHalfWidth, metersPerSample)
                : baseHalfWidth * Mathf.Clamp01(widthFactor);
            Vector3 leftVertex = centers[i] - right * halfWidth;
            Vector3 rightVertex = centers[i] + right * halfWidth;
            if (isTileEdgeSeam)
            {
                ApplyRiverWaterSeamCache(terrain, centers[i], riverWaterSeams, ref leftVertex, ref rightVertex);
            }

            float uvY = -downstreamDistance / uvLengthScale;

            vertices.Add(leftVertex);
            vertices.Add(rightVertex);
            uvs.Add(new Vector2(0f, uvY));
            uvs.Add(new Vector2(uvWidthScale, uvY));
            colors.Add(Color.white);
            colors.Add(Color.white);

            if (i == 0)
            {
                continue;
            }

            int left0 = (i - 1) * 2;
            int right0 = left0 + 1;
            int left1 = i * 2;
            int right1 = left1 + 1;
            triangles.Add(left0);
            triangles.Add(left1);
            triangles.Add(right0);
            triangles.Add(right0);
            triangles.Add(left1);
            triangles.Add(right1);
        }

        var mesh = new Mesh
        {
            name = "Generated River Water Mesh"
        };
        if (vertices.Count > ushort.MaxValue)
        {
            mesh.indexFormat = IndexFormat.UInt32;
        }

        mesh.SetVertices(vertices);
        mesh.SetUVs(0, uvs);
        mesh.SetColors(colors);
        mesh.SetTriangles(triangles, 0);
        mesh.RecalculateBounds();
        mesh.RecalculateNormals();
        mesh.RecalculateTangents();
        return mesh;

        void AddRiverWaterSample(int index, bool force)
        {
            RiverSurfacePoint pathPoint = pathPoints[index];
            var seam = GetEndpointSeamForPathIndex(index, pathPoint);
            Vector3 localPoint = GetTerrainLocalPoint(
                null,
                heightmap,
                pathPoint.X,
                pathPoint.Y,
                normalizationMinHeight,
                normalizationMaxHeight,
                0f);

            float minSegmentLength = Mathf.Max(0f, riverWaterMinSegmentLength);
            if (centers.Count > 0 && minSegmentLength > 0f)
            {
                float minSegmentSqr = minSegmentLength * minSegmentLength;
                if ((localPoint - centers[^1]).sqrMagnitude < minSegmentSqr)
                {
                    if (force)
                    {
                        centers[^1] = localPoint;
                        sampledPoints[^1] = pathPoint;
                        sampleSeams[^1] = seam;
                    }

                    return;
                }
            }

            centers.Add(localPoint);
            sampledPoints.Add(pathPoint);
            sampleSeams.Add(seam);
        }

        void ApplyRiverWaterSurfaceHeights()
        {
            float bedClearance = usesRiverProfile ? 0f : Mathf.Max(0f, riverWaterBedClearance);
            float meshVerticalOffset = riverWaterMeshVerticalOffset;
            float profileInset = usesRiverProfile ? 0.03f : 0f;
            var centerBedHeights = new float[centers.Count];

            for (int i = 0; i < centers.Count; i++)
            {
                centerBedHeights[i] = centers[i].y;
                float surfaceY = centerBedHeights[i] + bedClearance + meshVerticalOffset - profileInset;
                centers[i] = new Vector3(centers[i].x, surfaceY, centers[i].z);
            }

            if (usesRiverProfile)
            {
                return;
            }

            float dropPerSegment = centers.Count > 1
                ? Mathf.Max(0f, riverWaterMinimumDownstreamDrop) / (centers.Count - 1)
                : 0f;
            for (int i = 1; i < centers.Count; i++)
            {
                if (GetTileEdgeSeam(i).IsSeam)
                {
                    continue;
                }

                float maxDownstreamSurfaceY = centers[i - 1].y - dropPerSegment;
                if (centers[i].y > maxDownstreamSurfaceY)
                {
                    centers[i] = new Vector3(centers[i].x, maxDownstreamSurfaceY, centers[i].z);
                }
            }
        }

        (bool IsSeam, string? Direction, bool IsStart) GetEndpointSeamForPathIndex(
            int index,
            RiverSurfacePoint pathPoint)
        {
            bool isStart = index == 0;
            if (!isStart && index != pathPoints.Count - 1)
            {
                return default;
            }

            if (TryGetRiverWaterEndpointDirection(pathPoint, heightmap, out string? direction))
            {
                return (true, direction, isStart);
            }

            return default;
        }

        (bool IsSeam, string? Direction, bool IsStart) GetTileEdgeSeam(int sampleIndex)
        {
            if (sampleIndex < 0 || sampleIndex >= sampleSeams.Count)
            {
                return default;
            }

            return sampleSeams[sampleIndex];
        }

        float GetRiverWaterSeamHalfWidth(
            string? direction,
            bool isStart,
            float fallbackHalfWidth,
            float sampleMetersPerSample)
        {
            if (riverInfo != null &&
                TryGetRiverWaterEndpointFlow(riverInfo, direction, isStart, out double flow))
            {
                return Mathf.Max(
                    0.05f,
                    (float)MapRiverFlowToWaterWidthPixels(flow) *
                    sampleMetersPerSample *
                    Mathf.Max(0.05f, riverWaterWidthMultiplier));
            }

            return fallbackHalfWidth;
        }

        void ApplyRiverWaterSeamCenterCache()
        {
            if (terrain == null)
            {
                return;
            }

            Transform terrainTransform = terrain.transform;
            for (int i = 0; i < centers.Count; i++)
            {
                if (!GetTileEdgeSeam(i).IsSeam ||
                    !TryGetRiverWaterSeamKey(terrainTransform, centers[i], out string seamKey))
                {
                    continue;
                }

                if (riverWaterSeams.TryGetValue(seamKey, out RiverWaterSeamCrossSection seam))
                {
                    centers[i] = terrainTransform.InverseTransformPoint(seam.CenterWorld);
                    continue;
                }

                riverWaterSeams[seamKey] = new RiverWaterSeamCrossSection(
                    terrainTransform.TransformPoint(centers[i]));
            }
        }

        void SmoothRiverWaterSeamAdjacentHeights()
        {
            if (centers.Count < 3)
            {
                return;
            }

            if (GetTileEdgeSeam(0).IsSeam)
            {
                SmoothRiverWaterSeamAdjacentHeightsFrom(0, 1);
            }

            int lastIndex = centers.Count - 1;
            if (GetTileEdgeSeam(lastIndex).IsSeam)
            {
                SmoothRiverWaterSeamAdjacentHeightsFrom(lastIndex, -1);
            }
        }

        void SmoothRiverWaterSeamAdjacentHeightsFrom(int seamIndex, int direction)
        {
            int maxOffset = Math.Min(2, centers.Count - 1);
            for (int offset = 1; offset <= maxOffset; offset++)
            {
                int index = seamIndex + direction * offset;
                if (index < 0 || index >= centers.Count)
                {
                    break;
                }

                float weight = offset == 1 ? 0.65f : 0.35f;
                Vector3 center = centers[index];
                center.y = Mathf.Lerp(center.y, centers[seamIndex].y, weight);
                centers[index] = center;
            }
        }

        (bool IsSeam, string? Direction, bool IsStart, float Weight) GetTileEdgeSeamInfluence(int sampleIndex)
        {
            var seam = GetTileEdgeSeam(sampleIndex);
            if (seam.IsSeam)
            {
                return (true, seam.Direction, seam.IsStart, 1f);
            }

            if (sampleIndex <= 2)
            {
                var startSeam = GetTileEdgeSeam(0);
                if (startSeam.IsSeam)
                {
                    float weight = sampleIndex == 1 ? 0.85f : 0.45f;
                    return (true, startSeam.Direction, startSeam.IsStart, weight);
                }
            }

            int lastIndex = sampleSeams.Count - 1;
            int distanceFromEnd = lastIndex - sampleIndex;
            if (distanceFromEnd >= 1 && distanceFromEnd <= 2)
            {
                var endSeam = GetTileEdgeSeam(lastIndex);
                if (endSeam.IsSeam)
                {
                    float weight = distanceFromEnd == 1 ? 0.85f : 0.45f;
                    return (true, endSeam.Direction, endSeam.IsStart, weight);
                }
            }

            return default;
        }
    }

    private Transform CreateRiverWaterContainer(Transform terrainTransform)
    {
        string containerName = string.IsNullOrWhiteSpace(generatedRiverWaterContainerName)
            ? "Rivers"
            : generatedRiverWaterContainerName.Trim();
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
        ApplyRiverWaterLayer(container);
        return container.transform;
    }

    private Material? ResolveRiverWaterMaterial()
    {
        if (riverWaterMaterial != null)
        {
            return riverWaterMaterial;
        }

#if UNITY_EDITOR
        Material material = AssetDatabase.LoadAssetAtPath<Material>(GetRiverWaterMaterialAssetPath());
        if (material != null)
        {
            return material;
        }
#endif

        return null;
    }

    private string GetRiverWaterMaterialAssetPath()
    {
        return string.IsNullOrWhiteSpace(riverWaterMaterialAssetPath)
            ? DefaultRiverWaterMaterialAssetPath
            : riverWaterMaterialAssetPath.Replace('\\', '/').Trim();
    }

    private static Vector3 GetRiverWaterTangent(
        IReadOnlyList<Vector3> centers,
        IReadOnlyList<RiverSurfacePoint> sampledPoints,
        int index,
        int smoothingRadius)
    {
        int radius = Math.Max(1, smoothingRadius);
        int previousIndex = Math.Max(0, index - radius);
        int nextIndex = Math.Min(centers.Count - 1, index + radius);
        Vector3 tangent = centers[nextIndex] - centers[previousIndex];
        tangent.y = 0f;
        if (tangent.sqrMagnitude <= 0.0001f && sampledPoints.Count == centers.Count)
        {
            RiverSurfacePoint previous = sampledPoints[previousIndex];
            RiverSurfacePoint next = sampledPoints[nextIndex];
            tangent = new Vector3((float)(next.X - previous.X), 0f, (float)(previous.Y - next.Y));
        }

        if (tangent.sqrMagnitude <= 0.0001f)
        {
            return Vector3.forward;
        }

        return tangent.normalized;
    }

    private static bool TryGetRiverWaterSeamTangent(string? direction, bool isStartEndpoint, out Vector3 tangent)
    {
        tangent = direction switch
        {
            "N" => Vector3.forward,
            "S" => Vector3.back,
            "E" => Vector3.right,
            "W" => Vector3.left,
            _ => Vector3.zero
        };

        if (tangent.sqrMagnitude <= 0.0001f)
        {
            return false;
        }

        if (isStartEndpoint)
        {
            tangent = -tangent;
        }

        return true;
    }

    private static bool TryGetRiverWaterEndpointDirection(
        RiverSurfacePoint point,
        double[,] heightmap,
        out string? direction)
    {
        const double epsilon = 1e-4;
        double maxX = Math.Max(0, heightmap.GetLength(1) - 1);
        double maxY = Math.Max(0, heightmap.GetLength(0) - 1);
        if (point.X < -epsilon)
        {
            direction = "W";
            return true;
        }

        if (point.X > maxX + epsilon)
        {
            direction = "E";
            return true;
        }

        if (point.Y < -epsilon)
        {
            direction = "N";
            return true;
        }

        if (point.Y > maxY + epsilon)
        {
            direction = "S";
            return true;
        }

        direction = null;
        return false;
    }

    private static bool TryGetRiverWaterEndpointFlow(
        RiverInfo riverInfo,
        string? direction,
        bool isStartEndpoint,
        out double flow)
    {
        flow = 0.0;
        if (string.IsNullOrWhiteSpace(direction))
        {
            return false;
        }

        Dictionary<string, double> flows = isStartEndpoint
            ? riverInfo.Inputs
            : riverInfo.Outputs;
        return flows.TryGetValue(direction, out flow) && flow > 0.0;
    }

    private static double MapRiverFlowToWaterWidthPixels(double flow)
    {
        double[] flowPoints = { 0, 0.05, 0.4, 1.0, 2, 4, 8 };
        double[] widths = { 0, 1, 4, 7, 10, 14, 20 };

        if (flow <= flowPoints[0])
        {
            return widths[0];
        }

        if (flow >= flowPoints[^1])
        {
            return widths[^1];
        }

        for (int i = 1; i < flowPoints.Length; i++)
        {
            if (flow <= flowPoints[i])
            {
                double t = (flow - flowPoints[i - 1]) / (flowPoints[i] - flowPoints[i - 1]);
                return widths[i - 1] + t * (widths[i] - widths[i - 1]);
            }
        }

        return widths[^1];
    }

    private static void ApplyRiverWaterSeamCache(
        GStylizedTerrain? terrain,
        Vector3 localCenter,
        IDictionary<string, RiverWaterSeamCrossSection> riverWaterSeams,
        ref Vector3 leftVertex,
        ref Vector3 rightVertex)
    {
        Transform? terrainTransform = terrain != null ? terrain.transform : null;
        if (terrainTransform == null ||
            !TryGetRiverWaterSeamKey(terrainTransform, localCenter, out string seamKey))
        {
            return;
        }

        if (riverWaterSeams.TryGetValue(seamKey, out RiverWaterSeamCrossSection seam))
        {
            if (seam.HasVertices)
            {
                leftVertex = terrainTransform.InverseTransformPoint(seam.LeftWorld);
                rightVertex = terrainTransform.InverseTransformPoint(seam.RightWorld);
                return;
            }

            seam.SetVertices(
                terrainTransform.TransformPoint(leftVertex),
                terrainTransform.TransformPoint(rightVertex));
        }
        else
        {
            riverWaterSeams[seamKey] = new RiverWaterSeamCrossSection(
                terrainTransform.TransformPoint(localCenter),
                terrainTransform.TransformPoint(leftVertex),
                terrainTransform.TransformPoint(rightVertex));
        }
    }

    private static bool TryGetRiverWaterSeamKey(
        Transform terrainTransform,
        Vector3 localCenter,
        out string key)
    {
        Vector3 worldCenter = terrainTransform.TransformPoint(localCenter);
        string x = Math.Round(worldCenter.x, 3).ToString("F3", CultureInfo.InvariantCulture);
        string z = Math.Round(worldCenter.z, 3).ToString("F3", CultureInfo.InvariantCulture);
        key = x + ":" + z;
        return true;
    }

    private static float HorizontalDistance(Vector3 a, Vector3 b)
    {
        float dx = b.x - a.x;
        float dz = b.z - a.z;
        return Mathf.Sqrt(dx * dx + dz * dz);
    }

    private static void ApplyRiverWaterLayer(GameObject target)
    {
        int waterLayer = LayerMask.NameToLayer("Water");
        if (waterLayer >= 0)
        {
            target.layer = waterLayer;
        }
    }

    private void PopulateVegetation(
        IReadOnlyList<GeneratedTerrainRequest> terrainRequests,
        IReadOnlyList<GStylizedTerrain> terrains,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        if (!placeTreeObjects && !placeSurfaceObjects)
        {
            return;
        }

        int terrainCount = Math.Min(terrainRequests.Count, terrains.Count);
        for (int i = 0; i < terrainCount; i++)
        {
            GeneratedTerrainRequest request = terrainRequests[i];
            GStylizedTerrain terrain = terrains[i];
            PopulatePlacedObjects(terrain, request, normalizationMinHeight, normalizationMaxHeight);
        }
    }

    private void PopulatePlacedObjects(
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
            GameObject? prefab = LoadPrefabForPlacement(placement);
            if (prefab == null)
            {
                continue;
            }

            bool isTreeObject = IsTreePlacement(placement, prefab);
            if (isTreeObject && !placeTreeObjects)
            {
                continue;
            }

            if (!isTreeObject && !placeSurfaceObjects)
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
            instance.transform.localScale = Vector3.one;
            if (isTreeObject)
            {
                instance.transform.localPosition = GetPlacementLocalPosition(
                    terrain,
                    request.Layers.Heightmap,
                    placement,
                    normalizationMinHeight,
                    normalizationMaxHeight,
                    treeObjectVerticalOffset);
                instance.transform.localRotation = Quaternion.identity;
                RegisterGeneratedConifer(instance);
            }
            else
            {
                PlaceSurfaceObjectInstance(
                    instance.transform,
                    request.Layers.Heightmap,
                    placement,
                    normalizationMinHeight,
                    normalizationMaxHeight);
                RegisterGeneratedSurfaceObject(instance);
            }
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

    private Vector3 GetPlacementLocalPosition(
        GStylizedTerrain? terrain,
        double[,] heightmap,
        TileObjectPlacement placement,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        float verticalOffset)
    {
        return GetTerrainLocalPoint(
            terrain,
            heightmap,
            placement.X,
            placement.Y,
            normalizationMinHeight,
            normalizationMaxHeight,
            verticalOffset);
    }

    private Vector3 GetTerrainLocalPoint(
        GStylizedTerrain? terrain,
        double[,] heightmap,
        double sampleX,
        double sampleY,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        float verticalOffset)
    {
        int heightResolution = heightmap.GetLength(0);
        int widthResolution = heightmap.GetLength(1);
        float normalizedX = widthResolution > 1
            ? Mathf.Clamp01((float)(sampleX / (widthResolution - 1)))
            : 0f;
        float normalizedY = heightResolution > 1
            ? Mathf.Clamp01((float)(sampleY / (heightResolution - 1)))
            : 0f;

        float localX = normalizedX * terrainWidth;
        float localZ = (1f - normalizedY) * terrainLength;
        if (TrySampleGeneratedTerrainLocalPoint(terrain, localX, localZ, verticalOffset, out Vector3 terrainPoint))
        {
            return terrainPoint;
        }

        float localY = SampleTerrainHeight(heightmap, sampleX, sampleY, normalizationMinHeight, normalizationMaxHeight) +
                       verticalOffset;
        return new Vector3(localX, localY, localZ);
    }

    private Vector3 GetTerrainLocalNormal(
        GStylizedTerrain? terrain,
        double[,] heightmap,
        double sampleX,
        double sampleY,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        int heightResolution = heightmap.GetLength(0);
        int widthResolution = heightmap.GetLength(1);
        if (heightResolution <= 1 || widthResolution <= 1)
        {
            return Vector3.up;
        }

        Vector3 pointLeft = GetTerrainLocalPoint(
            terrain,
            heightmap,
            sampleX - 1d,
            sampleY,
            normalizationMinHeight,
            normalizationMaxHeight,
            0f);
        Vector3 pointRight = GetTerrainLocalPoint(
            terrain,
            heightmap,
            sampleX + 1d,
            sampleY,
            normalizationMinHeight,
            normalizationMaxHeight,
            0f);
        Vector3 pointBack = GetTerrainLocalPoint(
            terrain,
            heightmap,
            sampleX,
            sampleY - 1d,
            normalizationMinHeight,
            normalizationMaxHeight,
            0f);
        Vector3 pointForward = GetTerrainLocalPoint(
            terrain,
            heightmap,
            sampleX,
            sampleY + 1d,
            normalizationMinHeight,
            normalizationMaxHeight,
            0f);

        Vector3 tangentX = pointRight - pointLeft;
        Vector3 tangentY = pointForward - pointBack;
        Vector3 normal = Vector3.Cross(tangentX, tangentY);
        if (normal.sqrMagnitude <= 0.0001f)
        {
            return Vector3.up;
        }

        return normal.normalized;
    }

    private float SampleTerrainHeight(
        double[,] heightmap,
        double sampleX,
        double sampleY,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        double rawHeight = SampleHeightmapBilinear(heightmap, sampleX, sampleY);
        float normalizedHeight = NormalizeHeightUnitsToTerrain(rawHeight);
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

    private void RegisterGeneratedSurfaceObject(GameObject instance)
    {
        if (instance == null)
        {
            return;
        }

        TerrainConformBlanket blanket = instance.GetComponent<TerrainConformBlanket>();
        if (blanket != null)
        {
            if (Application.isPlaying)
            {
                Destroy(blanket);
            }
            else
            {
                DestroyImmediate(blanket);
            }
        }
    }

    private void AlignExistingGeneratedSurfaceObjects()
    {
        foreach (Transform child in transform)
        {
            if (!IsGeneratedTerrainTransform(child))
            {
                continue;
            }

            Transform vegetationContainer = child.Find(generatedVegetationContainerName);
            if (vegetationContainer == null)
            {
                continue;
            }

            for (int i = 0; i < vegetationContainer.childCount; i++)
            {
                Transform vegetationChild = vegetationContainer.GetChild(i);
                if (vegetationChild == null || IsTreeRoot(vegetationChild.gameObject))
                {
                    continue;
                }

                RegisterGeneratedSurfaceObject(vegetationChild.gameObject);
                AlignExistingSurfaceObjectToTerrain(vegetationChild);
            }
        }
    }

    private void RegisterExistingGeneratedTreeObjects()
    {
        generatedConiferInstances.Clear();

        foreach (Transform child in transform)
        {
            if (!IsGeneratedTerrainTransform(child))
            {
                continue;
            }

            Transform vegetationContainer = child.Find(generatedVegetationContainerName);
            if (vegetationContainer == null)
            {
                continue;
            }

            for (int i = 0; i < vegetationContainer.childCount; i++)
            {
                Transform vegetationChild = vegetationContainer.GetChild(i);
                if (vegetationChild == null || !IsTreeRoot(vegetationChild.gameObject))
                {
                    continue;
                }

                RegisterGeneratedConifer(vegetationChild.gameObject);
            }
        }
    }

    private void PlaceSurfaceObjectInstance(
        Transform surfaceObjectTransform,
        double[,] heightmap,
        TileObjectPlacement placement,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        if (surfaceObjectTransform == null)
        {
            return;
        }

        GStylizedTerrain terrain = surfaceObjectTransform.GetComponentInParent<GStylizedTerrain>();
        Vector3 localSurfacePoint = GetPlacementLocalPosition(
            terrain,
            heightmap,
            placement,
            normalizationMinHeight,
            normalizationMaxHeight,
            surfaceObjectVerticalOffset);
        Vector3 localSurfaceNormal = GetTerrainLocalNormal(
            terrain,
            heightmap,
            placement.X,
            placement.Y,
            normalizationMinHeight,
            normalizationMaxHeight);
        Quaternion localRotation = Quaternion.FromToRotation(Vector3.up, localSurfaceNormal);
        surfaceObjectTransform.localRotation = localRotation;
        surfaceObjectTransform.localPosition =
            localSurfacePoint +
            localSurfaceNormal * GetSurfaceObjectOffset();
    }

    private void AlignExistingSurfaceObjectToTerrain(Transform surfaceObjectTransform)
    {
        if (surfaceObjectTransform == null || !TrySampleSurfaceObjectSurface(surfaceObjectTransform, out RaycastHit surfaceHit))
        {
            return;
        }

        Quaternion worldRotation = Quaternion.FromToRotation(Vector3.up, surfaceHit.normal);
        surfaceObjectTransform.rotation = worldRotation;
        surfaceObjectTransform.position =
            surfaceHit.point +
            Vector3.up * surfaceObjectVerticalOffset +
            surfaceHit.normal * GetSurfaceObjectOffset();
    }

    private float GetSurfaceObjectOffset()
    {
        return grassClusterConformSurfaceOffset;
    }

    private bool TrySampleGeneratedTerrainLocalPoint(
        GStylizedTerrain? terrain,
        float localX,
        float localZ,
        float verticalOffset,
        out Vector3 localPoint)
    {
        localPoint = default;
        if (terrain == null || !terrain.isActiveAndEnabled || terrain.TerrainData == null)
        {
            return false;
        }

        Vector3 worldOrigin = terrain.transform.TransformPoint(new Vector3(localX, terrainHeight + 32f, localZ));
        if (!terrain.Raycast(new Ray(worldOrigin, Vector3.down), out RaycastHit terrainHit, terrainHeight + 96f))
        {
            return false;
        }

        Vector3 worldPoint = terrainHit.point + terrain.transform.up * verticalOffset;
        localPoint = terrain.transform.InverseTransformPoint(worldPoint);
        return true;
    }

    private static bool TrySampleSurfaceObjectSurface(Transform surfaceObjectTransform, out RaycastHit surfaceHit)
    {
        surfaceHit = default;
        if (surfaceObjectTransform == null)
        {
            return false;
        }

#if GRIFFIN
        GStylizedTerrain terrain = surfaceObjectTransform.GetComponentInParent<GStylizedTerrain>();
        if (terrain != null && terrain.isActiveAndEnabled && terrain.TerrainData != null)
        {
            Vector3 rayOrigin = surfaceObjectTransform.position + Vector3.up * 32f;
            if (terrain.Raycast(new Ray(rayOrigin, Vector3.down), out surfaceHit, 96f))
            {
                return true;
            }
        }
#endif

        RaycastHit[] hits = Physics.RaycastAll(
            surfaceObjectTransform.position + Vector3.up * 32f,
            Vector3.down,
            96f,
            ~0,
            QueryTriggerInteraction.Ignore);
        float closestDistance = float.PositiveInfinity;
        bool foundHit = false;
        for (int i = 0; i < hits.Length; i++)
        {
            RaycastHit hit = hits[i];
            if (hit.collider == null || hit.collider.transform.IsChildOf(surfaceObjectTransform))
            {
                continue;
            }

            if (hit.distance >= closestDistance)
            {
                continue;
            }

            closestDistance = hit.distance;
            surfaceHit = hit;
            foundHit = true;
        }

        return foundHit;
    }

    private bool IsGeneratedTerrainTransform(Transform candidate)
    {
        return candidate != null &&
               (candidate.name == generatedTerrainName ||
                candidate.name.StartsWith(generatedTerrainName + "_", StringComparison.Ordinal));
    }

    private static bool IsTreePlacement(TileObjectPlacement placement, GameObject prefab)
    {
        string? vegetationCategory = placement.Definition.VegetationCategory;
        if (!string.IsNullOrWhiteSpace(vegetationCategory))
        {
            return vegetationCategory.Equals("tree", StringComparison.OrdinalIgnoreCase);
        }

        return prefab != null && prefab.GetComponent<LODGroup>() != null;
    }

    private static bool IsTreeRoot(GameObject candidate)
    {
        return candidate != null &&
               candidate.GetComponent<LODGroup>() != null;
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
                RestoreConiferDecalState(instance);
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

                if (disableDistantConiferDecals)
                {
                    SetConiferDecalsEnabled(instance, false);
                }
                else
                {
                    RestoreConiferDecalState(instance);
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

                if (disableDistantConiferDecals)
                {
                    SetConiferDecalsEnabled(instance, false);
                }
                else
                {
                    RestoreConiferDecalState(instance);
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

    private static void SetConiferDecalsEnabled(GeneratedConiferInstance instance, bool enabled)
    {
        for (int i = 0; i < instance.DecalProjectors.Length; i++)
        {
            DecalProjector decalProjector = instance.DecalProjectors[i];
            if (decalProjector != null)
            {
                decalProjector.enabled = enabled;
            }
        }
    }

    private static void RestoreConiferDecalState(GeneratedConiferInstance instance)
    {
        for (int i = 0; i < instance.DecalProjectors.Length; i++)
        {
            DecalProjector decalProjector = instance.DecalProjectors[i];
            if (decalProjector != null)
            {
                decalProjector.enabled = instance.OriginalDecalProjectorStates[i];
            }
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

        if (TryFindSceneTransformWithTag("Player", out Transform? taggedPlayerTransform))
        {
            coniferOptimizationTarget = taggedPlayerTransform;
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

    private static bool TryFindSceneTransformWithTag(string tagName, out Transform? result)
    {
        GameObject[] taggedObjects;
        try
        {
            taggedObjects = GameObject.FindGameObjectsWithTag(tagName);
        }
        catch (UnityException)
        {
            result = null;
            return false;
        }

        for (int i = 0; i < taggedObjects.Length; i++)
        {
            GameObject taggedObject = taggedObjects[i];
            if (taggedObject == null || !taggedObject.scene.IsValid())
            {
                continue;
            }

            result = taggedObject.transform;
            return true;
        }

        result = null;
        return false;
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
        lowlandTerrainMaterialVariant ??= LoadDefaultMaterial(DefaultLowlandTerrainMaterialVariantAssetPath);
        midHeightTerrainMaterial ??= LoadDefaultMaterial(DefaultMidHeightTerrainMaterialAssetPath);
        steepSlopeTerrainMaterial ??= LoadDefaultMaterial(DefaultSteepSlopeTerrainMaterialAssetPath);
        steepSlopeTerrainMaterialVariant ??= LoadDefaultMaterial(DefaultSteepSlopeTerrainMaterialVariantAssetPath);
        peakTerrainMaterial ??= LoadDefaultMaterial(DefaultPeakTerrainMaterialAssetPath);
        lowlandTerrainTileSize = Mathf.Max(1f, lowlandTerrainTileSize);
        midHeightTerrainTileSize = Mathf.Max(1f, midHeightTerrainTileSize);
        steepSlopeTerrainTileSize = Mathf.Max(1f, steepSlopeTerrainTileSize);
        peakTerrainTileSize = Mathf.Max(1f, peakTerrainTileSize);
        macroVariationScale = Mathf.Max(1f, macroVariationScale);
        surfaceVariantScale = Mathf.Max(1f, surfaceVariantScale);
        surfaceVariantTransition = Mathf.Clamp(surfaceVariantTransition, 0.01f, 0.49f);
        surfacePhaseOffsetStrength = Mathf.Clamp01(surfacePhaseOffsetStrength);
        macroTintScale = Mathf.Max(1f, macroTintScale);
        midHeightStartMeters = Mathf.Max(0f, midHeightStartMeters);
        midHeightBlendMeters = Mathf.Max(1f, midHeightBlendMeters);
        steepSlopeBlendDegrees = Mathf.Max(0.1f, steepSlopeBlendDegrees);
        ruggedSnowCapHillinessThreshold = Mathf.Max(0f, ruggedSnowCapHillinessThreshold);
        ruggedSnowCapHillinessBlend = Mathf.Max(0.01f, ruggedSnowCapHillinessBlend);
        ruggedSnowCapBelowPeakMeters = Mathf.Max(0f, ruggedSnowCapBelowPeakMeters);
        ruggedSnowCapMinStartMeters = Mathf.Max(0f, ruggedSnowCapMinStartMeters);
        ruggedSnowCapBlendMeters = Mathf.Max(1f, ruggedSnowCapBlendMeters);
        fullSnowStartMeters = Mathf.Max(0f, fullSnowStartMeters);
        fullSnowBlendMeters = Mathf.Max(1f, fullSnowBlendMeters);
        fullSnowRockSlopeBlendDegrees = Mathf.Max(0.1f, fullSnowRockSlopeBlendDegrees);
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
        var pixels = new Color[resolutionX * resolutionY];

        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                float normalizedHeight = NormalizeHeightUnitsToTerrain(heightmap[y, x]);
                int flippedY = resolutionY - 1 - y;
                pixels[flippedY * resolutionX + x] = Polaris.EncodeHeightMapSample(normalizedHeight, 0f, 0f);
            }
        }

        return pixels;
    }

    private static float NormalizeHeightUnitsToTerrain(double heightUnits)
    {
        return Mathf.Clamp01((float)(heightUnits / Math.Max(MaxTileHeightUnits, 1e-6)));
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

    private static double GetCenterTileHilliness(TileLayers layers)
    {
        if (layers.SurroundingHilliness.GetLength(0) > 1 && layers.SurroundingHilliness.GetLength(1) > 1)
        {
            return layers.SurroundingHilliness[1, 1];
        }

        int centerY = layers.Heightmap.GetLength(0) / 2;
        int centerX = layers.Heightmap.GetLength(1) / 2;
        return TerrainUtils.ElevationToHilliness(TileHeightUnitsToMeters(layers.Heightmap[centerY, centerX]));
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

    private sealed class RiverWaterSeamCrossSection
    {
        public RiverWaterSeamCrossSection(Vector3 centerWorld)
        {
            CenterWorld = centerWorld;
        }

        public RiverWaterSeamCrossSection(Vector3 centerWorld, Vector3 leftWorld, Vector3 rightWorld)
            : this(centerWorld)
        {
            SetVertices(leftWorld, rightWorld);
        }

        public void SetVertices(Vector3 leftWorld, Vector3 rightWorld)
        {
            LeftWorld = leftWorld;
            RightWorld = rightWorld;
            HasVertices = true;
        }

        public Vector3 CenterWorld { get; }
        public Vector3 LeftWorld { get; private set; }
        public Vector3 RightWorld { get; private set; }
        public bool HasVertices { get; private set; }
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
            DecalProjectors = root.GetComponentsInChildren<DecalProjector>(true);
            OriginalShadowCastingModes = new ShadowCastingMode[Renderers.Length];
            OriginalReceiveShadows = new bool[Renderers.Length];
            for (int i = 0; i < Renderers.Length; i++)
            {
                Renderer renderer = Renderers[i];
                OriginalShadowCastingModes[i] = renderer.shadowCastingMode;
                OriginalReceiveShadows[i] = renderer.receiveShadows;
            }

            OriginalDecalProjectorStates = new bool[DecalProjectors.Length];
            for (int i = 0; i < DecalProjectors.Length; i++)
            {
                DecalProjector decalProjector = DecalProjectors[i];
                OriginalDecalProjectorStates[i] = decalProjector != null && decalProjector.enabled;
            }

            LodObjects = ExtractLodObjects(LodGroup);
            LowestAvailableLodIndex = FindLowestAvailableLodIndex(LodObjects);
        }

        public GameObject Root { get; }
        public Transform Transform { get; }
        public LODGroup? LodGroup { get; }
        public Collider[] Colliders { get; }
        public Renderer[] Renderers { get; }
        public DecalProjector[] DecalProjectors { get; }
        public ShadowCastingMode[] OriginalShadowCastingModes { get; }
        public bool[] OriginalReceiveShadows { get; }
        public bool[] OriginalDecalProjectorStates { get; }
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
            double localMaxHeight,
            double tileHilliness)
        {
            Layers = layers;
            TerrainObjectName = terrainObjectName;
            LocalPosition = localPosition;
            UnityTileX = unityTileX;
            UnityTileY = unityTileY;
            LocalMinHeight = localMinHeight;
            LocalMaxHeight = localMaxHeight;
            TileHilliness = tileHilliness;
        }

        public TileLayers Layers { get; }
        public string TerrainObjectName { get; }
        public Vector3 LocalPosition { get; }
        public int UnityTileX { get; }
        public int UnityTileY { get; }
        public double LocalMinHeight { get; }
        public double LocalMaxHeight { get; }
        public double TileHilliness { get; }
    }

    [Serializable]
    private struct GeneratedTerrainShadingMetadata
    {
        public GeneratedTerrainShadingMetadata(
            string terrainName,
            double normalizationMinHeight,
            double normalizationMaxHeight,
            float localMaxHeightMeters,
            double tileHilliness)
        {
            TerrainName = terrainName;
            NormalizationMinHeight = normalizationMinHeight;
            NormalizationMaxHeight = normalizationMaxHeight;
            LocalMaxHeightMeters = localMaxHeightMeters;
            TileHilliness = tileHilliness;
        }

        public string TerrainName;
        public double NormalizationMinHeight;
        public double NormalizationMaxHeight;
        public float LocalMaxHeightMeters;
        public double TileHilliness;
    }

    private enum TerrainShadingMode
    {
        PolarisTextureBlend,
        FallbackLit,
    }
}
