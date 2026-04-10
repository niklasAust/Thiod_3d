using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using Stopwatch = System.Diagnostics.Stopwatch;
using UnityEngine;
using Unity.Mathematics;
using Unity.Profiling;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Serialization;
using UnityEngine.Splines;
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
    private const string GeneratedTerrainBatchRootNamePrefix = "_GeneratedTerrainBatch";
    private const double PreviewMaxElevationMeters = 2000.0;
    private const double MaxTileHeightUnits = 42.0;
    private const double MetersPerTileHeightUnit = PreviewMaxElevationMeters / MaxTileHeightUnits;
    private const int VegetationStreamingPolicyVersion = 1;

    [Header("World Source")]
    [SerializeField] private string worldDataFile = "test_map.msgpack";
    [SerializeField] private bool loadOnEnableInEditMode = true;
    [SerializeField] private bool loadOnStartInPlayMode = false;

    [Header("Tile Selection")]
    [SerializeField] private Vector3Int unityTileCoordinate = new(83, 29, 0);
    [SerializeField] private bool invertUnityYForWorldGen = true;
    [SerializeField] private bool load3x3Neighborhood = false;

    [Header("Dynamic Runtime Loading")]
    [SerializeField] private bool dynamicTileLoadingEnabled = false;
    [SerializeField] private Transform? dynamicLoadTargetOverride;
    [SerializeField, Min(0.01f)] private float dynamicLoadCheckIntervalSeconds = 0.10f;
    [SerializeField] private bool reuseOverlappingDynamicNeighborhoodTiles = true;

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
    [SerializeField, Min(0f)] private float riverCenterDepthMultiplier = 4f;
    [SerializeField, Min(0f)] private float riverCenterDepthMultiplierAtNinetyDegrees = 10f;
    [SerializeField, Min(0.05f)] private float riverCenterCarveWidthMultiplier = 4f;
    [SerializeField, Min(0.05f)] private float riverCenterCarveWidthMultiplierAtNinetyDegrees = 10f;
    [SerializeField, Min(0f)] private float riverProfileMinDropMetersPerTile = 0.001f;
    [SerializeField, Min(0f)] private float riverProfileMaxDropMetersPerTile = 6f;
    [FormerlySerializedAs("riverBankSmoothingStrength")]
    [FormerlySerializedAs("riverCenterCarveSmoothingStrength")]
    [SerializeField, Range(0f, 1f)] private float riverFinalSmoothingStrength = 1f;
    [FormerlySerializedAs("riverBankSmoothingKernelRadius")]
    [FormerlySerializedAs("riverCenterCarveSmoothingKernelRadius")]
    [SerializeField, Min(1)] private int riverFinalSmoothingKernelRadius = 8;
    [FormerlySerializedAs("riverBankSmoothingPasses")]
    [FormerlySerializedAs("riverCenterCarveSmoothingPasses")]
    [SerializeField, Min(1)] private int riverFinalSmoothingPasses = 6;
    [FormerlySerializedAs("riverCenterCarveSmoothingRetainedDepthFraction")]
    [SerializeField, Range(0f, 1f)] private float riverFinalSmoothingRetainedDepthFraction = 0.2f;
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
    [SerializeField] private VegetationLoadMode vegetationLoadMode = VegetationLoadMode.HybridInteractive;
    [SerializeField, Min(0f)] private float vegetationInteractionRadiusMeters = 80f;
    [SerializeField, Min(0f)] private float vegetationInteractionHysteresisMeters = 16f;
    [SerializeField] private string generatedVegetationContainerName = "Vegetation";
    [FormerlySerializedAs("coniferVerticalOffset")]
    [SerializeField] private float treeObjectVerticalOffset = 0f;
    [FormerlySerializedAs("grassClusterVerticalOffset")]
    [SerializeField] private float surfaceObjectVerticalOffset = 0f;

    [Header("Runtime Load Smoothing")]
    [SerializeField, Min(1)] private int worldgenWorkerCount = 4;
    [FormerlySerializedAs("spreadVegetationInstancingAcrossFrames")]
    [SerializeField] private bool spreadVegetationPlacementAcrossFrames = true;
    [FormerlySerializedAs("vegetationInstancingFrameBudgetMilliseconds")]
    [SerializeField, Min(0.25f)] private float vegetationPlacementBudgetMsPerFrame = 12f;
    [SerializeField, Min(0.1f)] private float prototypeInitBudgetMsPerFrame = 4f;
    [SerializeField] private bool centerTileOnlyNonTreeBudgetFirst = true;
    [SerializeField, Min(0f)] private float highDetailPlacementRadiusMeters = 45f;
    [SerializeField, Min(0f)] private float midDetailPlacementRadiusMeters = 110f;
    [SerializeField, Min(0f)] private float highDetailTerrainConformRadiusMeters = 35f;

    [Header("River Water Output")]
    [SerializeField] private bool createRiverWater = true;
    [SerializeField] private bool createRiverDebugSplines = true;
    [SerializeField] private string generatedRiverWaterContainerName = "Rivers";
    [SerializeField] private string generatedRiverSplineContainerName = "RiverDebugSpline";
    [SerializeField] private Material? riverWaterMaterial;
    [SerializeField] private string riverWaterMaterialAssetPath = DefaultRiverWaterMaterialAssetPath;
    [SerializeField, Min(0.05f)] private float riverWaterWidthMultiplier = 1.45f;
    [SerializeField, Min(0f)] private float riverWaterBedClearance = 0.18f;
    [SerializeField] private float riverWaterMeshVerticalOffset = 1.5f;
    [SerializeField] private float riverWaterMeshVerticalOffsetAtNinetyDegrees = 3f;
    [SerializeField, Min(0f)] private float riverWaterMinimumDownstreamDrop = 0.001f;
    [SerializeField, Min(1)] private int riverWaterSampleStride = 1;
    [SerializeField, Min(1)] private int riverSplineSamplingStep = 2;
    [SerializeField, Min(1)] private int riverSplineAvgElements = 1;
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
    [SerializeField] private bool logGenerationPhaseTimings = true;
    [SerializeField] private bool logVegetationPlacementWorkItems = true;
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
    private readonly Dictionary<Vector2Int, GeneratedTerrainTileData> activeTerrainTileCache = new();
    private readonly Dictionary<string, GameObject?> prefabCache = new(StringComparer.OrdinalIgnoreCase);
    private readonly Dictionary<string, TileLoaderInstancedVegetationPrototype?> vegetationPrototypeCache = new(StringComparer.OrdinalIgnoreCase);
    private readonly HashSet<string> loggedMissingPrefabPaths = new(StringComparer.OrdinalIgnoreCase);
    private readonly Dictionary<string, int> missingPrefabSkipCounts = new(StringComparer.OrdinalIgnoreCase);
    private GeneratedTerrainBatchCacheEntry? cachedTerrainBatch;
    private int activeGenerationPipelineId;
    private Material? cachedRiverWaterMaterial;
    private string? cachedRiverWaterMaterialPath;
    private Transform? activeGeneratedTerrainRoot;
    private string? activeTerrainTileCacheSignature;
    private Transform? cachedDynamicLoadTarget;
    private float nextDynamicLoadCheckTime;
    private int lastCompletedGenerationPipelineId;
    private bool terrainPhaseLoadInProgress;
    private bool dynamicLoadDispatchQueued;
    private Coroutine? activeVegetationPopulationCoroutine;
    private GeneratedTerrainBatchState? activeVegetationPopulationBatchState;
    private Stopwatch? activeVegetationPopulationStopwatch;
    private Vector3Int? queuedDynamicUnityTileCoordinate;
    private Vector3Int? activeLoadedUnityTileCoordinate;
    private static readonly Dictionary<string, CachedLoadedWorldData> LoadedWorldDataCache = new(StringComparer.OrdinalIgnoreCase);
    private static readonly ProfilerMarker BatchWorldgenMarker = new("TileLoader.BatchWorldgen");
    private static readonly ProfilerMarker TerrainCreationMarker = new("TileLoader.TerrainCreation");
    private static readonly ProfilerMarker TerrainSeamsMarker = new("TileLoader.TerrainSeams");
    private static readonly ProfilerMarker TerrainShadingMarker = new("TileLoader.TerrainShading");
    private static readonly ProfilerMarker RiverWaterMarker = new("TileLoader.RiverWater");
    private static readonly ProfilerMarker RiverSplineMarker = new("TileLoader.RiverDebugSplines");
    private static readonly ProfilerMarker VegetationPlacementMarker = new("TileLoader.VegetationPlacement");
    private static readonly ProfilerMarker VegetationRenderMarker = new("TileLoader.VegetationRender");

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
        if (Application.isPlaying && dynamicTileLoadingEnabled)
        {
            nextDynamicLoadCheckTime = 0f;
            if (TryGetDynamicLoadTargetTileCoordinate(out Vector3Int runtimeTileCoordinate))
            {
                RequestDynamicTileLoad(runtimeTileCoordinate, forceImmediate: true);
            }
            else if (loadOnStartInPlayMode)
            {
                LoadTileIntoScene();
            }

            return;
        }

        if (Application.isPlaying && loadOnStartInPlayMode)
        {
            LoadTileIntoScene();
            return;
        }

        if (Application.isPlaying && HasGeneratedTerrains())
        {
            if (UsesLegacyVegetationObjects())
            {
                RegisterExistingGeneratedTreeObjects();
                AlignExistingGeneratedSurfaceObjects();
            }

            ScheduleRuntimeTerrainSeamRebuild();
            if (UsesLegacyVegetationObjects())
            {
                UpdateConiferOptimization(forceFullIfNoTarget: true);
            }
        }
    }

    private void OnDisable()
    {
        CancelActiveVegetationPopulation();
        terrainPhaseLoadInProgress = false;
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

        if (dynamicTileLoadingEnabled && RefreshDynamicTileLoading())
        {
            return;
        }

        if (!UsesLegacyVegetationObjects() || !optimizeConifersByDistance)
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

    private bool UsesLegacyVegetationObjects()
    {
        return vegetationLoadMode == VegetationLoadMode.LegacyGameObjects;
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

            LoadedWorldData loadedWorldData = GetOrLoadCachedWorldData(filePath);
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
        tileGenerator.BatchGenerationWorkerCount = Math.Max(1, worldgenWorkerCount);
        tileGenerator.RiverCarveSettings = new RiverCarveSettings
        {
            DepthMultiplier = Math.Max(0f, riverDepthMultiplier),
            BankDepthMultiplier = Math.Max(0f, riverBankDepthMultiplier),
            CenterDepthMultiplier = Math.Max(0f, riverCenterDepthMultiplier),
            CenterDepthMultiplierAtMaxSlope = Math.Max(0f, riverCenterDepthMultiplierAtNinetyDegrees),
            CenterCarveWidthMultiplier = Math.Max(0.05f, riverCenterCarveWidthMultiplier),
            CenterCarveWidthMultiplierAtMaxSlope = Math.Max(0.05f, riverCenterCarveWidthMultiplierAtNinetyDegrees),
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
            FinalSmoothingStrength = Mathf.Clamp01(riverFinalSmoothingStrength),
            FinalSmoothingKernelRadius = Math.Max(1, riverFinalSmoothingKernelRadius),
            FinalSmoothingPasses = Math.Max(1, riverFinalSmoothingPasses),
            FinalSmoothingRetainedDepthFraction = Mathf.Clamp01(riverFinalSmoothingRetainedDepthFraction),
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
        if (activeGeneratedTerrainRoot != null)
        {
            foreach (GStylizedTerrain terrain in activeGeneratedTerrainRoot.GetComponentsInChildren<GStylizedTerrain>(true))
            {
                if (terrain != null)
                {
                    return true;
                }
            }
        }

        foreach (GStylizedTerrain terrain in GetComponentsInChildren<GStylizedTerrain>(true))
        {
            if (terrain != null && IsGeneratedTerrainName(terrain.name))
            {
                return true;
            }
        }

        return false;
    }

    private bool UsesBatchNeighborhoodLoading()
    {
        return load3x3Neighborhood || (Application.isPlaying && dynamicTileLoadingEnabled);
    }

    private bool RefreshDynamicTileLoading()
    {
        if (!Application.isPlaying || !dynamicTileLoadingEnabled)
        {
            return false;
        }

        if (Time.unscaledTime < nextDynamicLoadCheckTime)
        {
            return false;
        }

        nextDynamicLoadCheckTime = Time.unscaledTime + Mathf.Max(0.01f, dynamicLoadCheckIntervalSeconds);
        if (!TryGetDynamicLoadTargetTileCoordinate(out Vector3Int runtimeTileCoordinate))
        {
            return false;
        }

        unityTileCoordinate = runtimeTileCoordinate;
        if (terrainPhaseLoadInProgress)
        {
            queuedDynamicUnityTileCoordinate = runtimeTileCoordinate;
            return false;
        }

        if (activeLoadedUnityTileCoordinate.HasValue &&
            activeLoadedUnityTileCoordinate.Value == runtimeTileCoordinate &&
            HasGeneratedTerrains())
        {
            return false;
        }

        RequestDynamicTileLoad(runtimeTileCoordinate);
        return true;
    }

    private void RequestDynamicTileLoad(Vector3Int tileCoordinate, bool forceImmediate = false)
    {
        unityTileCoordinate = tileCoordinate;

        if (!forceImmediate &&
            activeLoadedUnityTileCoordinate.HasValue &&
            activeLoadedUnityTileCoordinate.Value == tileCoordinate &&
            HasGeneratedTerrains())
        {
            queuedDynamicUnityTileCoordinate = null;
            return;
        }

        if (terrainPhaseLoadInProgress)
        {
            queuedDynamicUnityTileCoordinate = tileCoordinate;
            return;
        }

        queuedDynamicUnityTileCoordinate = null;
        LoadTileIntoScene();
    }

    private bool TryGetDynamicLoadTargetTileCoordinate(out Vector3Int tileCoordinate)
    {
        tileCoordinate = unityTileCoordinate;
        Transform? target = ResolveDynamicLoadTarget();
        if (target == null)
        {
            return false;
        }

        return TryGetUnityTileCoordinateForWorldPosition(target.position, out tileCoordinate);
    }

    private Transform? ResolveDynamicLoadTarget()
    {
        if (dynamicLoadTargetOverride != null)
        {
            cachedDynamicLoadTarget = dynamicLoadTargetOverride;
            return cachedDynamicLoadTarget;
        }

        if (cachedDynamicLoadTarget != null &&
            cachedDynamicLoadTarget.gameObject != null &&
            cachedDynamicLoadTarget.gameObject.scene.IsValid())
        {
            return cachedDynamicLoadTarget;
        }

        if (TryFindSceneTransformWithComponent("UltimateCharacterLocomotion", out Transform? ultimateLocomotionTransform))
        {
            cachedDynamicLoadTarget = ultimateLocomotionTransform;
            return cachedDynamicLoadTarget;
        }

        if (TryFindSceneTransformWithComponent("CharacterLocomotion", out Transform? locomotionTransform))
        {
            cachedDynamicLoadTarget = locomotionTransform;
            return cachedDynamicLoadTarget;
        }

        if (TryFindSceneTransformWithTag("Player", out Transform? taggedPlayerTransform))
        {
            cachedDynamicLoadTarget = taggedPlayerTransform;
            return cachedDynamicLoadTarget;
        }

        if (Camera.main != null)
        {
            cachedDynamicLoadTarget = Camera.main.transform;
            return cachedDynamicLoadTarget;
        }

        cachedDynamicLoadTarget = null;
        return null;
    }

    private bool TryGetUnityTileCoordinateForWorldPosition(Vector3 worldPosition, out Vector3Int tileCoordinate)
    {
        float safeTerrainWidth = Mathf.Max(0.01f, terrainWidth);
        float safeTerrainLength = Mathf.Max(0.01f, terrainLength);
        Vector3 localPosition = transform.InverseTransformPoint(worldPosition);
        tileCoordinate = new Vector3Int(
            Mathf.FloorToInt(localPosition.x / safeTerrainWidth),
            Mathf.FloorToInt(localPosition.z / safeTerrainLength),
            unityTileCoordinate.z);
        return true;
    }

    private void TryDispatchQueuedDynamicLoad()
    {
        if (!Application.isPlaying || !dynamicTileLoadingEnabled || terrainPhaseLoadInProgress)
        {
            return;
        }

        if (!queuedDynamicUnityTileCoordinate.HasValue)
        {
            return;
        }

        Vector3Int requestedTileCoordinate = queuedDynamicUnityTileCoordinate.Value;
        if (activeLoadedUnityTileCoordinate.HasValue &&
            activeLoadedUnityTileCoordinate.Value == requestedTileCoordinate &&
            HasGeneratedTerrains())
        {
            queuedDynamicUnityTileCoordinate = null;
            return;
        }

        if (dynamicLoadDispatchQueued)
        {
            return;
        }

        dynamicLoadDispatchQueued = true;
        StartCoroutine(DispatchQueuedDynamicLoadNextFrame());
    }

    private IEnumerator DispatchQueuedDynamicLoadNextFrame()
    {
        yield return null;
        dynamicLoadDispatchQueued = false;
        if (this == null || !Application.isPlaying || terrainPhaseLoadInProgress)
        {
            yield break;
        }

        if (!queuedDynamicUnityTileCoordinate.HasValue)
        {
            yield break;
        }

        Vector3Int requestedTileCoordinate = queuedDynamicUnityTileCoordinate.Value;
        RequestDynamicTileLoad(requestedTileCoordinate, forceImmediate: true);
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
        activeGenerationPipelineId++;
        int pipelineId = activeGenerationPipelineId;
        bool doubleBufferedRuntimeSwap = Application.isPlaying && dynamicTileLoadingEnabled;
        Transform? pendingBatchRoot = null;
        bool awaitingDeferredPhaseCompletion = false;
        terrainPhaseLoadInProgress = true;
        CancelActiveVegetationPopulation();
        generatedConiferInstances.Clear();
        generatedTerrainShadingMetadata.Clear();
        nextConiferOptimizationTime = 0f;

        try
        {
            if (!doubleBufferedRuntimeSwap)
            {
                ClearGeneratedTerrains();
            }

            GeneratedTerrainBatchState batchState = MeasureGenerationPhase(
                BatchWorldgenMarker,
                UsesBatchNeighborhoodLoading() ? "3x3 batch worldgen" : "tile worldgen",
                () => BuildGeneratedTerrainBatchState(tileGenerator, loadedWorldData, settings, pipelineId));

            if (batchState.Requests.Count == 0)
            {
                return;
            }

            if (!doubleBufferedRuntimeSwap || !TryReuseActiveTerrainBatchRoot(batchState))
            {
                pendingBatchRoot = CreateGeneratedTerrainBatchRoot(pipelineId);
                batchState.BatchRoot = pendingBatchRoot;
            }

            MeasureGenerationPhase(
                batchState,
                TerrainCreationMarker,
                "terrain creation",
                () =>
                {
                    int terrainGroupId = GetGeneratedTerrainGroupId();
                    for (int i = 0; i < batchState.Requests.Count; i++)
                    {
                        GeneratedTerrainRequest request = batchState.Requests[i];
                        Vector2Int tileCoordinate = GetTileCoordinate(request);
                        if (batchState.TerrainByCoordinate.ContainsKey(tileCoordinate))
                        {
                            continue;
                        }

                        GStylizedTerrain terrain = CreateTerrain(
                            request.Layers,
                            request.TerrainObjectName,
                            request.LocalPosition,
                            request.UnityTileX,
                            request.UnityTileY,
                            batchState.NormalizationMinHeight,
                            batchState.NormalizationMaxHeight,
                            request.LocalMinHeight,
                            request.LocalMaxHeight,
                            request.TileHilliness,
                            terrainGroupId,
                            batchState.BatchRoot!);
                        batchState.CreatedTerrains.Add(terrain);
                        batchState.CreatedRequests.Add(request);
                        batchState.TerrainByCoordinate[tileCoordinate] = terrain;
                    }
                });

            FinalizeTerrainBatchState(batchState);

            if (batchState.ActiveTerrains.Count == 0)
            {
                if (pendingBatchRoot != null)
                {
                    DestroyGeneratedTerrainContainer(pendingBatchRoot);
                    pendingBatchRoot = null;
                }

                return;
            }

            PrepareDeferredGenerationTargets(batchState);

            MeasureGenerationPhase(
                batchState,
                TerrainSeamsMarker,
                "terrain seams",
                () => RebuildTerrainSeams(batchState.ActiveTerrains));

            MeasureGenerationPhase(
                batchState,
                TerrainShadingMarker,
                "terrain shading",
                () => ApplyTerrainShading(batchState.ActiveTerrains));

            PromoteGeneratedTerrainBatch(batchState);
            pendingBatchRoot = null;
            LogGenerationBatchSummary(batchState, "blocking");
            awaitingDeferredPhaseCompletion = true;
            ScheduleDeferredGenerationPhases(batchState);
        }
        finally
        {
            if (pendingBatchRoot != null)
            {
                DestroyGeneratedTerrainContainer(pendingBatchRoot);
            }

            if (!awaitingDeferredPhaseCompletion)
            {
                terrainPhaseLoadInProgress = false;
                TryDispatchQueuedDynamicLoad();
            }
        }
    }

    private LoadedWorldData GetOrLoadCachedWorldData(string filePath)
    {
        string normalizedPath = Path.GetFullPath(filePath);
        DateTime lastWriteUtc = File.GetLastWriteTimeUtc(normalizedPath);
        if (LoadedWorldDataCache.TryGetValue(normalizedPath, out CachedLoadedWorldData cached) &&
            cached.LastWriteUtc == lastWriteUtc)
        {
            return cached.Data;
        }

        Dictionary<string, object> rawWorldData = WorldGenerator.LoadWorldDataBinary(normalizedPath);
        LoadedWorldData loadedWorldData = ReconstructWorldData(rawWorldData);
        LoadedWorldDataCache[normalizedPath] = new CachedLoadedWorldData(lastWriteUtc, loadedWorldData);
        return loadedWorldData;
    }

    private GeneratedTerrainBatchState BuildGeneratedTerrainBatchState(
        TileGenerator tileGenerator,
        LoadedWorldData loadedWorldData,
        GenerationSettings settings,
        int pipelineId)
    {
        string cacheSignature = BuildGeneratedTerrainCacheSignature(loadedWorldData, settings);
        if (ShouldUseIncrementalNeighborhoodRequestReuse(cacheSignature))
        {
            return BuildIncrementalGeneratedTerrainBatchState(
                tileGenerator,
                loadedWorldData,
                settings,
                pipelineId,
                cacheSignature);
        }

        string cacheKey = BuildGeneratedTerrainBatchCacheKey(cacheSignature);
        if (cachedTerrainBatch != null && cachedTerrainBatch.CacheKey == cacheKey)
        {
            return cachedTerrainBatch.CreateState(pipelineId);
        }

        var requests = new List<GeneratedTerrainRequest>();
        double batchMinHeight = double.MaxValue;
        double batchMaxHeight = double.MinValue;

        if (UsesBatchNeighborhoodLoading())
        {
            int centerWorldTileY = invertUnityYForWorldGen ? -unityTileCoordinate.y : unityTileCoordinate.y;
            TileLayersBatch batch = tileGenerator.GenerateTileLayersBatch(
                unityTileCoordinate.x,
                centerWorldTileY,
                1,
                settings.TileSize,
                settings.HillSpacing,
                settings.HillStrength);

            for (int i = 0; i < batch.Entries.Count; i++)
            {
                TileLayersBatchEntry entry = batch.Entries[i];
                int unityOffsetY = invertUnityYForWorldGen ? -entry.OffsetY : entry.OffsetY;
                int unityTileX = unityTileCoordinate.x + entry.OffsetX;
                int unityTileY = unityTileCoordinate.y + unityOffsetY;
                Vector3 localPosition = new(entry.OffsetX * terrainWidth, 0f, unityOffsetY * terrainLength);
                string terrainObjectName = GetTerrainObjectName(entry.OffsetX, unityOffsetY, unityTileX, unityTileY);
                CalculateHeightRange(entry.Layers.Heightmap, out double tileMinHeight, out double tileMaxHeight);
                batchMinHeight = Math.Min(batchMinHeight, tileMinHeight);
                batchMaxHeight = Math.Max(batchMaxHeight, tileMaxHeight);
                requests.Add(new GeneratedTerrainRequest(
                    entry.Layers,
                    terrainObjectName,
                    localPosition,
                    unityTileX,
                    unityTileY,
                    tileMinHeight,
                    tileMaxHeight,
                    GetCenterTileHilliness(entry.Layers)));
            }
        }
        else
        {
            int unityTileX = unityTileCoordinate.x;
            int unityTileY = unityTileCoordinate.y;
            int worldTileY = invertUnityYForWorldGen ? -unityTileY : unityTileY;
            TileLayers layers = tileGenerator.GenerateTileLayers(
                unityTileX,
                worldTileY,
                settings.TileSize,
                settings.HillSpacing,
                settings.HillStrength);
            CalculateHeightRange(layers.Heightmap, out double tileMinHeight, out double tileMaxHeight);
            batchMinHeight = tileMinHeight;
            batchMaxHeight = tileMaxHeight;
            requests.Add(new GeneratedTerrainRequest(
                layers,
                generatedTerrainName,
                Vector3.zero,
                unityTileX,
                unityTileY,
                tileMinHeight,
                tileMaxHeight,
                GetCenterTileHilliness(layers)));
        }

        if (requests.Count == 0)
        {
            return new GeneratedTerrainBatchState(
                cacheKey,
                cacheSignature,
                pipelineId,
                unityTileCoordinate,
                Array.Empty<GeneratedTerrainRequest>(),
                loadedWorldData.GlobalMinHeight,
                loadedWorldData.GlobalMaxHeight);
        }

        double normalizationMinHeight = Math.Min(loadedWorldData.GlobalMinHeight, batchMinHeight);
        double normalizationMaxHeight = Math.Max(loadedWorldData.GlobalMaxHeight, batchMaxHeight);
        cachedTerrainBatch = new GeneratedTerrainBatchCacheEntry(
            cacheKey,
            cacheSignature,
            unityTileCoordinate,
            normalizationMinHeight,
            normalizationMaxHeight,
            requests);
        return cachedTerrainBatch.CreateState(pipelineId);
    }

    private string BuildGeneratedTerrainCacheSignature(LoadedWorldData loadedWorldData, GenerationSettings settings)
    {
        string worldPath = ResolveWorldDataFilePath(worldDataFile);
        long worldTicks = File.Exists(worldPath) ? File.GetLastWriteTimeUtc(worldPath).Ticks : 0L;
        string vegetationObjectsPath = Path.Combine(Application.dataPath, "Resources", "VegetationConfig", "vegetation_objects.json");
        string vegetationRulesPath = Path.Combine(Application.dataPath, "..", "Packages", "com.niklasaust.worldgen", "VegetationConfig", "vegetation_biome_rules.json");
        long vegetationObjectsTicks = File.Exists(vegetationObjectsPath) ? File.GetLastWriteTimeUtc(vegetationObjectsPath).Ticks : 0L;
        long vegetationRulesTicks = File.Exists(vegetationRulesPath) ? File.GetLastWriteTimeUtc(vegetationRulesPath).Ticks : 0L;

        return string.Join(
            "|",
            Path.GetFullPath(worldPath),
            worldTicks.ToString(CultureInfo.InvariantCulture),
            vegetationObjectsTicks.ToString(CultureInfo.InvariantCulture),
            vegetationRulesTicks.ToString(CultureInfo.InvariantCulture),
            loadedWorldData.Seed.ToString(CultureInfo.InvariantCulture),
            invertUnityYForWorldGen ? "invert" : "normal",
            UsesBatchNeighborhoodLoading() ? "3x3" : "single",
            settings.TileSize.ToString(CultureInfo.InvariantCulture),
            settings.HillSpacing.ToString(CultureInfo.InvariantCulture),
            settings.HillStrength.ToString("R", CultureInfo.InvariantCulture),
            terrainWidth.ToString("R", CultureInfo.InvariantCulture),
            terrainLength.ToString("R", CultureInfo.InvariantCulture),
            terrainHeight.ToString("R", CultureInfo.InvariantCulture),
            terrainGridSize.ToString(CultureInfo.InvariantCulture),
            riverWidthMultiplier.ToString("R", CultureInfo.InvariantCulture),
            riverDepthMultiplier.ToString("R", CultureInfo.InvariantCulture),
            riverBankDepthMultiplier.ToString("R", CultureInfo.InvariantCulture),
            riverCenterDepthMultiplier.ToString("R", CultureInfo.InvariantCulture),
            riverCenterDepthMultiplierAtNinetyDegrees.ToString("R", CultureInfo.InvariantCulture),
            riverCenterCarveWidthMultiplier.ToString("R", CultureInfo.InvariantCulture),
            riverCenterCarveWidthMultiplierAtNinetyDegrees.ToString("R", CultureInfo.InvariantCulture),
            riverProfileMinDropMetersPerTile.ToString("R", CultureInfo.InvariantCulture),
            riverProfileMaxDropMetersPerTile.ToString("R", CultureInfo.InvariantCulture),
            riverCorridorDepressionMeters.ToString("R", CultureInfo.InvariantCulture),
            riverCorridorMaxSlopeMetersPerSample.ToString("R", CultureInfo.InvariantCulture),
            riverCorridorRadiusMultiplier.ToString("R", CultureInfo.InvariantCulture),
            riverCorridorMinRadiusSamples.ToString(CultureInfo.InvariantCulture),
            riverCorridorSmoothingStrength.ToString("R", CultureInfo.InvariantCulture),
            riverCorridorSmoothingKernelRadius.ToString(CultureInfo.InvariantCulture),
            riverCorridorSmoothingPasses.ToString(CultureInfo.InvariantCulture),
            riverFinalSmoothingStrength.ToString("R", CultureInfo.InvariantCulture),
            riverFinalSmoothingKernelRadius.ToString(CultureInfo.InvariantCulture),
            riverFinalSmoothingPasses.ToString(CultureInfo.InvariantCulture),
            riverFinalSmoothingRetainedDepthFraction.ToString("R", CultureInfo.InvariantCulture),
            riverWaterMeshVerticalOffset.ToString("R", CultureInfo.InvariantCulture),
            riverWaterMeshVerticalOffsetAtNinetyDegrees.ToString("R", CultureInfo.InvariantCulture),
            VegetationStreamingPolicyVersion.ToString(CultureInfo.InvariantCulture),
            placeTreeObjects ? "trees" : "noTrees",
            placeSurfaceObjects ? "surface" : "noSurface");
    }

    private string BuildGeneratedTerrainBatchCacheKey(string cacheSignature)
    {
        return string.Join(
            "|",
            cacheSignature,
            unityTileCoordinate.x.ToString(CultureInfo.InvariantCulture),
            unityTileCoordinate.y.ToString(CultureInfo.InvariantCulture));
    }

    private bool ShouldUseIncrementalNeighborhoodRequestReuse(string cacheSignature)
    {
        if (!Application.isPlaying ||
            !dynamicTileLoadingEnabled ||
            !reuseOverlappingDynamicNeighborhoodTiles ||
            !UsesBatchNeighborhoodLoading() ||
            activeGeneratedTerrainRoot == null ||
            !activeLoadedUnityTileCoordinate.HasValue ||
            activeTerrainTileCache.Count == 0)
        {
            return false;
        }

        if (!string.Equals(activeTerrainTileCacheSignature, cacheSignature, StringComparison.Ordinal))
        {
            return false;
        }

        Vector3Int previousCenter = activeLoadedUnityTileCoordinate.Value;
        int deltaX = Math.Abs(unityTileCoordinate.x - previousCenter.x);
        int deltaY = Math.Abs(unityTileCoordinate.y - previousCenter.y);
        return deltaX <= 2 && deltaY <= 2;
    }

    private GeneratedTerrainBatchState BuildIncrementalGeneratedTerrainBatchState(
        TileGenerator tileGenerator,
        LoadedWorldData loadedWorldData,
        GenerationSettings settings,
        int pipelineId,
        string cacheSignature)
    {
        string cacheKey = BuildGeneratedTerrainBatchCacheKey(cacheSignature);
        var requests = new List<GeneratedTerrainRequest>(9);
        double batchMinHeight = double.MaxValue;
        double batchMaxHeight = double.MinValue;
        int reusedRequestCount = 0;

        for (int offsetY = -1; offsetY <= 1; offsetY++)
        {
            for (int offsetX = -1; offsetX <= 1; offsetX++)
            {
                int unityTileX = unityTileCoordinate.x + offsetX;
                int unityTileY = unityTileCoordinate.y + offsetY;
                Vector2Int tileCoordinate = new(unityTileX, unityTileY);
                if (!activeTerrainTileCache.TryGetValue(tileCoordinate, out GeneratedTerrainTileData tileData))
                {
                    tileData = BuildTerrainTileData(tileGenerator, settings, unityTileX, unityTileY);
                }
                else
                {
                    reusedRequestCount++;
                }

                batchMinHeight = Math.Min(batchMinHeight, tileData.LocalMinHeight);
                batchMaxHeight = Math.Max(batchMaxHeight, tileData.LocalMaxHeight);
                requests.Add(CreateTerrainRequest(tileData));
            }
        }

        double normalizationMinHeight = Math.Min(loadedWorldData.GlobalMinHeight, batchMinHeight);
        double normalizationMaxHeight = Math.Max(loadedWorldData.GlobalMaxHeight, batchMaxHeight);
        cachedTerrainBatch = new GeneratedTerrainBatchCacheEntry(
            cacheKey,
            cacheSignature,
            unityTileCoordinate,
            normalizationMinHeight,
            normalizationMaxHeight,
            requests);

        GeneratedTerrainBatchState batchState = cachedTerrainBatch.CreateState(pipelineId);
        batchState.ReusedRequestCount = reusedRequestCount;
        return batchState;
    }

    private GeneratedTerrainTileData BuildTerrainTileData(
        TileGenerator tileGenerator,
        GenerationSettings settings,
        int unityTileX,
        int unityTileY)
    {
        int worldTileY = invertUnityYForWorldGen ? -unityTileY : unityTileY;
        TileLayers layers = tileGenerator.GenerateTileLayers(
            unityTileX,
            worldTileY,
            settings.TileSize,
            settings.HillSpacing,
            settings.HillStrength);
        CalculateHeightRange(layers.Heightmap, out double tileMinHeight, out double tileMaxHeight);
        return new GeneratedTerrainTileData(
            layers,
            unityTileX,
            unityTileY,
            tileMinHeight,
            tileMaxHeight,
            GetCenterTileHilliness(layers));
    }

    private GeneratedTerrainRequest CreateTerrainRequest(GeneratedTerrainTileData tileData)
    {
        int offsetX = tileData.UnityTileX - unityTileCoordinate.x;
        int offsetY = tileData.UnityTileY - unityTileCoordinate.y;
        Vector3 localPosition = new(offsetX * terrainWidth, 0f, offsetY * terrainLength);
        string terrainObjectName = GetTerrainObjectName(offsetX, offsetY, tileData.UnityTileX, tileData.UnityTileY);
        return new GeneratedTerrainRequest(
            tileData.Layers,
            terrainObjectName,
            localPosition,
            tileData.UnityTileX,
            tileData.UnityTileY,
            tileData.LocalMinHeight,
            tileData.LocalMaxHeight,
            tileData.TileHilliness);
    }

    private void ScheduleDeferredGenerationPhases(GeneratedTerrainBatchState batchState)
    {
        if (batchState.PipelineId != activeGenerationPipelineId)
        {
            return;
        }

#if UNITY_EDITOR
        if (!Application.isPlaying)
        {
            EditorApplication.delayCall += () => ContinueDeferredGenerationPhases(batchState);
            return;
        }
#endif

        StartCoroutine(ContinueDeferredGenerationPhasesNextFrame(batchState));
    }

    private IEnumerator ContinueDeferredGenerationPhasesNextFrame(GeneratedTerrainBatchState batchState)
    {
        yield return null;
        ContinueDeferredGenerationPhases(batchState);
    }

    private void ContinueDeferredGenerationPhases(GeneratedTerrainBatchState batchState)
    {
        if (batchState.PipelineId != activeGenerationPipelineId || this == null)
        {
            return;
        }

        switch (batchState.NextDeferredPhase)
        {
            case DeferredGenerationPhase.RiverWater:
                batchState.NextDeferredPhase = DeferredGenerationPhase.DebugSplines;
                MeasureGenerationPhase(
                    batchState,
                    RiverWaterMarker,
                    "river water",
                    () =>
                    {
                        ClearGeneratedRiverOutputs(batchState.RiverRefreshTerrains);
                        PopulateRiverWater(
                        batchState.RiverRefreshRequests,
                        batchState.RiverRefreshTerrains,
                        batchState.NormalizationMinHeight,
                        batchState.NormalizationMaxHeight,
                        batchState.RiverSplineCache);
                    });
                break;
            case DeferredGenerationPhase.DebugSplines:
                batchState.NextDeferredPhase = DeferredGenerationPhase.Vegetation;
                MeasureGenerationPhase(
                    batchState,
                    RiverSplineMarker,
                    "river debug splines",
                    () => PopulateRiverDebugSplines(
                        batchState.RiverRefreshRequests,
                        batchState.RiverRefreshTerrains,
                        batchState.NormalizationMinHeight,
                        batchState.NormalizationMaxHeight,
                        batchState.RiverSplineCache));
                break;
            case DeferredGenerationPhase.Vegetation:
                batchState.NextDeferredPhase = DeferredGenerationPhase.Completed;
                if (ShouldSpreadVegetationInstancingAcrossFrames(batchState))
                {
                    activeVegetationPopulationBatchState = batchState;
                    activeVegetationPopulationStopwatch = Stopwatch.StartNew();
                    activeVegetationPopulationCoroutine = StartCoroutine(PopulateVegetationOverMultipleFrames(batchState));
                    return;
                }

                MeasureGenerationPhase(
                    batchState,
                    VegetationPlacementMarker,
                    "vegetation placement",
                    () =>
                    {
                        ClearGeneratedVegetationOutputs(batchState.VegetationRefreshTerrains);
                        PopulateVegetationImmediately(batchState);
                    });
                FinishDeferredGenerationPhases(batchState);
                return;
            default:
                return;
        }

        if (batchState.NextDeferredPhase != DeferredGenerationPhase.Completed)
        {
            ScheduleDeferredGenerationPhases(batchState);
            return;
        }

        FinishDeferredGenerationPhases(batchState);
    }

    private void MeasureGenerationPhase(ProfilerMarker marker, string phaseName, Action action)
        => MeasureGenerationPhase(null, marker, phaseName, action);

    private void MeasureGenerationPhase(
        GeneratedTerrainBatchState? batchState,
        ProfilerMarker marker,
        string phaseName,
        Action action)
    {
        using (marker.Auto())
        {
            var stopwatch = Stopwatch.StartNew();
            action();
            stopwatch.Stop();
            RecordGenerationPhaseTiming(batchState, phaseName, stopwatch.Elapsed);
            LogGenerationPhaseTiming(phaseName, stopwatch.Elapsed);
        }
    }

    private T MeasureGenerationPhase<T>(ProfilerMarker marker, string phaseName, Func<T> action)
        => MeasureGenerationPhase<T>(null, marker, phaseName, action);

    private T MeasureGenerationPhase<T>(
        GeneratedTerrainBatchState? batchState,
        ProfilerMarker marker,
        string phaseName,
        Func<T> action)
    {
        using (marker.Auto())
        {
            var stopwatch = Stopwatch.StartNew();
            T result = action();
            stopwatch.Stop();
            RecordGenerationPhaseTiming(batchState, phaseName, stopwatch.Elapsed);
            LogGenerationPhaseTiming(phaseName, stopwatch.Elapsed);
            return result;
        }
    }

    private void RecordGenerationPhaseTiming(
        GeneratedTerrainBatchState? batchState,
        string phaseName,
        System.TimeSpan elapsed)
    {
        if (batchState == null)
        {
            return;
        }

        batchState.RecordPhaseTiming(phaseName, elapsed.TotalMilliseconds);
    }

    private void LogGenerationPhaseTiming(string phaseName, System.TimeSpan elapsed)
    {
        if (!logGenerationPhaseTimings)
        {
            return;
        }

        UnityEngine.Debug.Log(
            $"TileLoader {phaseName} completed in {elapsed.TotalMilliseconds.ToString("F1", CultureInfo.InvariantCulture)} ms.",
            this);
    }

    private bool ShouldSpreadVegetationInstancingAcrossFrames(GeneratedTerrainBatchState batchState)
    {
        return Application.isPlaying &&
               spreadVegetationPlacementAcrossFrames &&
               !UsesLegacyVegetationObjects() &&
               batchState.VegetationRefreshTerrains.Count > 0;
    }

    private void FinishDeferredGenerationPhases(GeneratedTerrainBatchState batchState)
    {
        if (batchState.PipelineId != activeGenerationPipelineId || this == null)
        {
            return;
        }

        if (Application.isPlaying)
        {
            UpdateConiferOptimization(forceFullIfNoTarget: true);
        }

        lastCompletedGenerationPipelineId = batchState.PipelineId;
        LogGenerationBatchSummary(batchState, "complete");
        terrainPhaseLoadInProgress = false;
        TryDispatchQueuedDynamicLoad();
    }

    private void CancelActiveVegetationPopulation()
    {
        if (activeVegetationPopulationCoroutine == null)
        {
            return;
        }

        if (activeVegetationPopulationBatchState != null)
        {
            double elapsedMilliseconds = activeVegetationPopulationStopwatch?.Elapsed.TotalMilliseconds ?? 0d;
            InterruptAndLogPendingVegetationTileStats(activeVegetationPopulationBatchState, elapsedMilliseconds);
        }

        StopCoroutine(activeVegetationPopulationCoroutine);
        activeVegetationPopulationCoroutine = null;
        activeVegetationPopulationBatchState = null;
        activeVegetationPopulationStopwatch = null;
    }

    private void ClearGeneratedRiverOutputs(IReadOnlyList<GStylizedTerrain> terrains)
    {
        string containerName = string.IsNullOrWhiteSpace(generatedRiverWaterContainerName)
            ? "Rivers"
            : generatedRiverWaterContainerName.Trim();
        for (int i = 0; i < terrains.Count; i++)
        {
            GStylizedTerrain terrain = terrains[i];
            if (terrain == null)
            {
                continue;
            }

            Transform riverContainer = terrain.transform.Find(containerName);
            if (riverContainer != null)
            {
                RetireGeneratedContainer(riverContainer);
            }
        }
    }

    private void ClearGeneratedVegetationOutputs(IReadOnlyList<GStylizedTerrain> terrains)
    {
        string containerName = string.IsNullOrWhiteSpace(generatedVegetationContainerName)
            ? "Vegetation"
            : generatedVegetationContainerName.Trim();
        for (int i = 0; i < terrains.Count; i++)
        {
            GStylizedTerrain terrain = terrains[i];
            if (terrain == null)
            {
                continue;
            }

            Transform vegetationContainer = terrain.transform.Find(containerName);
            if (vegetationContainer != null)
            {
                RetireGeneratedContainer(vegetationContainer);
            }
        }
    }

    private void RetireGeneratedContainer(Transform container)
    {
        if (container == null)
        {
            return;
        }

        container.gameObject.SetActive(false);
        container.name = container.name + "_Retiring_" + activeGenerationPipelineId.ToString(CultureInfo.InvariantCulture);
        DestroyGeneratedTerrainContainer(container);
    }

    private void LogGenerationBatchSummary(GeneratedTerrainBatchState batchState, string stageLabel)
    {
        if (!logGenerationPhaseTimings || batchState.PhaseTimingsMilliseconds.Count == 0)
        {
            return;
        }

        double totalMilliseconds = 0d;
        foreach (KeyValuePair<string, double> phaseTiming in batchState.PhaseTimingsMilliseconds)
        {
            totalMilliseconds += phaseTiming.Value;
        }

        string slowestPhases = string.Join(
            ", ",
            batchState.PhaseTimingsMilliseconds
                .OrderByDescending(pair => pair.Value)
                .Take(4)
                .Select(pair =>
                    $"{pair.Key}={pair.Value.ToString("F1", CultureInfo.InvariantCulture)} ms"));
        Debug.Log(
            $"TileLoader {stageLabel} summary for center ({batchState.CenterTileCoordinate.x},{batchState.CenterTileCoordinate.y},0): " +
            $"total={totalMilliseconds.ToString("F1", CultureInfo.InvariantCulture)} ms, slowest=[{slowestPhases}], " +
            $"activeTiles={batchState.ActiveTerrains.Count}, createdTiles={batchState.CreatedTerrains.Count}, reusedTiles={batchState.ReusedTerrainCount}, " +
            $"removedTiles={batchState.RemovedTerrainCount}, reusedWorldgenTiles={batchState.ReusedRequestCount}, " +
            $"riverRefreshTiles={batchState.RiverRefreshTerrains.Count}, vegetationRefreshTiles={batchState.VegetationRefreshTerrains.Count}, " +
            $"vegGenerated={batchState.VegetationGeneratedPlacementCount}, vegKept={batchState.VegetationKeptPlacementCount}, " +
            $"vegSkippedPolicy={batchState.VegetationSkippedByPolicyCount}, vegSkippedDistance={batchState.VegetationSkippedByDistanceCount}, vegSkippedCap={batchState.VegetationSkippedByCapCount}, " +
            $"vegQueuedPlacements={batchState.VegetationQueuedPlacementCount}, vegWorkItems={batchState.VegetationQueuedWorkItemCount}, " +
            $"vegInstanced={batchState.VegetationInstancedPlacementCount}, vegLegacy={batchState.VegetationLegacyPlacementCount}, " +
            $"vegExactConform={batchState.VegetationExactTerrainConformPlacementCount}, vegApprox={batchState.VegetationApproximatePlacementCount}, " +
            $"vegDeferredFinalizes={batchState.VegetationDeferredRendererFinalizeCount}, vegRendererFinalizes={batchState.VegetationRendererFinalizeCount}, " +
            $"queuePrepCpuMs={batchState.VegetationQueuePrepCpuMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"placementCpuMs={batchState.VegetationPlacementCpuMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"prototypeCacheHits={batchState.VegetationPrototypeCacheHitCount}, prototypeCacheMisses={batchState.VegetationPrototypeCacheMissCount}, " +
            $"forcedInstancingOnly={batchState.VegetationForcedInstancingOnlyCount}, rendererInits={batchState.VegetationRendererInitializationCount}, " +
            $"prefabResolveMs={batchState.VegetationPrefabResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"prototypeResolveMs={batchState.VegetationPrototypeResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"positionBuildMs={batchState.VegetationPositionBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"normalBuildMs={batchState.VegetationNormalBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"rendererFinalizeMs={batchState.VegetationRendererFinalizeMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"prototypeInitMs={batchState.VegetationPrototypeInitializationMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"heightmapSamples={batchState.VegetationHeightmapSampleCount}, raycastSamples={batchState.VegetationRaycastSampleCount}, " +
            $"centerReadyMs={batchState.VegetationCenterReadyMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"fullSettledMs={batchState.VegetationFullSettledMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"missingPrefabs={batchState.VegetationMissingPrefabCount}, " +
            $"queueBuckets=[{FormatBucketSummary(batchState.VegetationQueuedPlacementsByBucket, batchState.VegetationQueuedWorkItemsByBucket, 6)}].",
            this);

        if (batchState.VegetationTileStats.Count > 0)
        {
            string tileSummary = string.Join(
                "; ",
                batchState.VegetationTileStats
                    .OrderBy(pair => pair.Key.y)
                    .ThenBy(pair => pair.Key.x)
                    .Select(pair =>
                    {
                        VegetationTileStreamingStats stats = pair.Value;
                        string categories = FormatVegetationTileCategorySummary(stats, 5);
                        string settledOrInterruptedMs = stats.Status == VegetationTileStreamingStatus.Interrupted
                            ? stats.InterruptedMilliseconds.ToString("F1", CultureInfo.InvariantCulture)
                            : stats.TileReadyMilliseconds.ToString("F1", CultureInfo.InvariantCulture);
                        return $"tile({pair.Key.x},{pair.Key.y})[{(stats.IsCenterTile ? "center" : "outer")}]: status={stats.Status}, kept={stats.KeptCount}/{stats.GeneratedCount}, skipped={stats.SkippedCount}, queuedPlacements={stats.QueuedPlacementCount}, workItems={stats.QueuedWorkItemCount}, instanced={stats.InstancedPlacementCount}, legacy={stats.LegacyPlacementCount}, exactConform={stats.ExactTerrainConformPlacementCount}, approx={stats.ApproximatePlacementCount}, deferredFinalizes={stats.DeferredRendererFinalizeCount}, rendererFinalizes={stats.RendererFinalizeCount}, queuePrepCpuMs={stats.QueuePrepCpuMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, placementCpuMs={stats.PlacementCpuMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, prefabResolveMs={stats.PrefabResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, prototypeResolveMs={stats.PrototypeResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, positionBuildMs={stats.PositionBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, normalBuildMs={stats.NormalBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, rendererFinalizeMs={stats.RendererFinalizeMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, placementWallMs={stats.PlacementWallMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, firstVisibleWallMs={stats.FirstVisibleMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, settledWallMs={settledOrInterruptedMs}, heightmapSamples={stats.HeightmapSampleCount}, raycastSamples={stats.RaycastSampleCount}, buckets=[{FormatBucketSummary(stats.QueuedPlacementsByBucket, stats.QueuedWorkItemsByBucket, 4)}], cats=[{categories}]";
                    }));
            Debug.Log($"TileLoader vegetation tile stats: {tileSummary}", this);
        }

        if (batchState.MissingPrefabCountsByPath.Count > 0)
        {
            string missingPrefabSummary = string.Join(
                ", ",
                batchState.MissingPrefabCountsByPath
                    .OrderByDescending(pair => pair.Value)
                    .Take(6)
                    .Select(pair => $"{pair.Key}={pair.Value}"));
            Debug.Log($"TileLoader missing prefab skips this batch: [{missingPrefabSummary}]", this);
        }
    }

    private static void IncrementCount(IDictionary<string, int> target, string key)
    {
        if (string.IsNullOrWhiteSpace(key))
        {
            return;
        }

        if (target.TryGetValue(key, out int existing))
        {
            target[key] = existing + 1;
            return;
        }

        target[key] = 1;
    }

    private static void AddCount(IDictionary<string, int> target, string key, int amount)
    {
        if (string.IsNullOrWhiteSpace(key) || amount == 0)
        {
            return;
        }

        if (target.TryGetValue(key, out int existing))
        {
            target[key] = existing + amount;
            return;
        }

        target[key] = amount;
    }

    private static string FormatBucketSummary(
        IDictionary<string, int> placementCountsByBucket,
        IDictionary<string, int>? workItemCountsByBucket = null,
        int maxBuckets = 5)
    {
        if (placementCountsByBucket.Count == 0)
        {
            return "none";
        }

        IEnumerable<string> orderedBucketKeys = placementCountsByBucket
            .OrderByDescending(entry => entry.Value)
            .Take(Math.Max(1, maxBuckets))
            .Select(entry => entry.Key);
        return string.Join(
            ", ",
            orderedBucketKeys.Select(bucketKey =>
            {
                int placementCount = placementCountsByBucket.TryGetValue(bucketKey, out int placementValue)
                    ? placementValue
                    : 0;
                int workItemCount = workItemCountsByBucket != null &&
                                    workItemCountsByBucket.TryGetValue(bucketKey, out int workItemValue)
                    ? workItemValue
                    : 0;
                return workItemCountsByBucket == null
                    ? $"{bucketKey}={placementCount}"
                    : $"{bucketKey}={placementCount}p/{workItemCount}w";
            }));
    }

    private static string FormatVegetationTileCategorySummary(VegetationTileStreamingStats stats, int maxCategories = 5)
    {
        if (stats.GeneratedByCategory.Count == 0)
        {
            return "none";
        }

        return string.Join(
            ", ",
            stats.GeneratedByCategory
                .OrderByDescending(entry => entry.Value)
                .Take(Math.Max(1, maxCategories))
                .Select(entry =>
                {
                    int kept = stats.KeptByCategory.TryGetValue(entry.Key, out int keptValue) ? keptValue : 0;
                    return $"{entry.Key}={kept}/{entry.Value}";
                }));
    }

    private void FinalizeAndLogPendingVegetationTileStats(GeneratedTerrainBatchState batchState, double fallbackElapsedMilliseconds)
    {
        foreach (KeyValuePair<Vector2Int, VegetationTileStreamingStats> pair in batchState.VegetationTileStats)
        {
            VegetationTileStreamingStats tileStats = pair.Value;
            if (tileStats.QueuedWorkItemCount <= 0)
            {
                continue;
            }

            tileStats.MarkSettled(fallbackElapsedMilliseconds);
            TryLogSettledVegetationTile(pair.Key, tileStats);
        }
    }

    private void InterruptAndLogPendingVegetationTileStats(GeneratedTerrainBatchState batchState, double interruptedElapsedMilliseconds)
    {
        foreach (KeyValuePair<Vector2Int, VegetationTileStreamingStats> pair in batchState.VegetationTileStats)
        {
            VegetationTileStreamingStats tileStats = pair.Value;
            if (tileStats.QueuedWorkItemCount <= 0 || tileStats.Status == VegetationTileStreamingStatus.Settled)
            {
                continue;
            }

            tileStats.MarkInterrupted(interruptedElapsedMilliseconds);
            TryLogInterruptedVegetationTile(pair.Key, tileStats);
        }
    }

    private void TryLogSettledVegetationTile(Vector2Int tileCoordinate, VegetationTileStreamingStats tileStats)
    {
        if (!logGenerationPhaseTimings || tileStats.HasLoggedReady || tileStats.Status != VegetationTileStreamingStatus.Settled)
        {
            return;
        }

        tileStats.HasLoggedReady = true;
        Debug.Log(
            $"TileLoader tile ({tileCoordinate.x},{tileCoordinate.y}) vegetation fully settled: " +
            $"queuePrepCpuMs={tileStats.QueuePrepCpuMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"placementCpuMs={tileStats.PlacementCpuMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"prefabResolveMs={tileStats.PrefabResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"prototypeResolveMs={tileStats.PrototypeResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"positionBuildMs={tileStats.PositionBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"normalBuildMs={tileStats.NormalBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"rendererFinalizeMs={tileStats.RendererFinalizeMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"placementWallMs={tileStats.PlacementWallMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"settledWallMs={tileStats.TileReadyMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"kept={tileStats.KeptCount}/{tileStats.GeneratedCount}, skipped={tileStats.SkippedCount}, " +
            $"queuedPlacements={tileStats.QueuedPlacementCount}, workItems={tileStats.QueuedWorkItemCount}, instanced={tileStats.InstancedPlacementCount}, legacy={tileStats.LegacyPlacementCount}, missingPrefabs={tileStats.MissingPrefabCount}, exactConform={tileStats.ExactTerrainConformPlacementCount}, approx={tileStats.ApproximatePlacementCount}, deferredFinalizes={tileStats.DeferredRendererFinalizeCount}, rendererFinalizes={tileStats.RendererFinalizeCount}, " +
            $"heightmapSamples={tileStats.HeightmapSampleCount}, raycastSamples={tileStats.RaycastSampleCount}, " +
            $"{FormatFirstVisibleFragment(tileStats)}buckets=[{FormatBucketSummary(tileStats.QueuedPlacementsByBucket, tileStats.QueuedWorkItemsByBucket, 5)}], cats=[{FormatVegetationTileCategorySummary(tileStats, 6)}].",
            this);
    }

    private void TryLogInterruptedVegetationTile(Vector2Int tileCoordinate, VegetationTileStreamingStats tileStats)
    {
        if (!logGenerationPhaseTimings || tileStats.HasLoggedReady || tileStats.Status != VegetationTileStreamingStatus.Interrupted)
        {
            return;
        }

        tileStats.HasLoggedReady = true;
        Debug.Log(
            $"TileLoader tile ({tileCoordinate.x},{tileCoordinate.y}) vegetation interrupted before settle: " +
            $"queuePrepCpuMs={tileStats.QueuePrepCpuMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"placementCpuMs={tileStats.PlacementCpuMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"prefabResolveMs={tileStats.PrefabResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"prototypeResolveMs={tileStats.PrototypeResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"positionBuildMs={tileStats.PositionBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"normalBuildMs={tileStats.NormalBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"rendererFinalizeMs={tileStats.RendererFinalizeMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"placementWallMs={tileStats.PlacementWallMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"interruptedWallMs={tileStats.InterruptedMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"kept={tileStats.KeptCount}/{tileStats.GeneratedCount}, skipped={tileStats.SkippedCount}, " +
            $"queuedPlacements={tileStats.QueuedPlacementCount}, workItems={tileStats.QueuedWorkItemCount}, instanced={tileStats.InstancedPlacementCount}, legacy={tileStats.LegacyPlacementCount}, missingPrefabs={tileStats.MissingPrefabCount}, exactConform={tileStats.ExactTerrainConformPlacementCount}, approx={tileStats.ApproximatePlacementCount}, deferredFinalizes={tileStats.DeferredRendererFinalizeCount}, rendererFinalizes={tileStats.RendererFinalizeCount}, " +
            $"heightmapSamples={tileStats.HeightmapSampleCount}, raycastSamples={tileStats.RaycastSampleCount}, " +
            $"{FormatFirstVisibleFragment(tileStats)}buckets=[{FormatBucketSummary(tileStats.QueuedPlacementsByBucket, tileStats.QueuedWorkItemsByBucket, 5)}], cats=[{FormatVegetationTileCategorySummary(tileStats, 6)}].",
            this);
    }

    private void TryLogVegetationWorkQueueSummary(
        GeneratedTerrainBatchState batchState,
        IReadOnlyList<VegetationWorkItem> workItems)
    {
        if (!logGenerationPhaseTimings || !logVegetationPlacementWorkItems)
        {
            return;
        }

        int centerWorkItems = workItems.Count(item => item.IsCenterTile);
        int outerWorkItems = workItems.Count - centerWorkItems;
        int totalQueuedPlacements = workItems.Sum(item => item.Placements.Count);
        Debug.Log(
            $"TileLoader vegetation work queue: workItems={workItems.Count}, queuedPlacements={totalQueuedPlacements}, centerWorkItems={centerWorkItems}, outerWorkItems={outerWorkItems}, buckets=[{FormatBucketSummary(batchState.VegetationQueuedPlacementsByBucket, batchState.VegetationQueuedWorkItemsByBucket, 8)}].",
            this);

        string tileQueueSummary = string.Join(
            "; ",
            batchState.VegetationTileStats
                .OrderBy(pair => pair.Key.y)
                .ThenBy(pair => pair.Key.x)
                .Where(pair => pair.Value.QueuedWorkItemCount > 0)
                .Select(pair =>
                {
                    VegetationTileStreamingStats stats = pair.Value;
                    return $"tile({pair.Key.x},{pair.Key.y})[{(stats.IsCenterTile ? "center" : "outer")}]: queuedPlacements={stats.QueuedPlacementCount}, workItems={stats.QueuedWorkItemCount}, buckets=[{FormatBucketSummary(stats.QueuedPlacementsByBucket, stats.QueuedWorkItemsByBucket, 4)}]";
                }));
        if (!string.IsNullOrWhiteSpace(tileQueueSummary))
        {
            Debug.Log($"TileLoader vegetation tile queue: {tileQueueSummary}", this);
        }
    }

    private void TryLogVegetationWorkItemCompletion(
        VegetationWorkItem workItem,
        VegetationTileStreamingStats? tileStats,
        int completedWorkItemCount,
        int visibleInstancedPlacementCount,
        bool rendererFinalizeDeferred,
        bool rendererReady,
        double rendererPrototypeInitMilliseconds)
    {
        if (!logGenerationPhaseTimings || !logVegetationPlacementWorkItems)
        {
            return;
        }

        Vector2Int tileCoordinate = GetTileCoordinate(workItem.BuildState.Request);
        int totalQueuedWorkItems = tileStats != null ? tileStats.QueuedWorkItemCount : 0;
        Debug.Log(
            $"TileLoader vegetation chunk tile ({tileCoordinate.x},{tileCoordinate.y})[{(workItem.IsCenterTile ? "center" : "outer")}]: " +
            $"bucket={workItem.PriorityBucket}, chunk={workItem.ChunkIndexWithinBucket + 1}/{workItem.ChunkCountWithinBucket}, chunkPlacements={workItem.Placements.Count}, completedChunks={completedWorkItemCount}/{totalQueuedWorkItems}, " +
            $"instancedAdded={workItem.InstancedPlacementCount}, legacyAdded={workItem.LegacyPlacementCount}, visibleInstancedNow={visibleInstancedPlacementCount}, missingPrefabs={workItem.MissingPrefabCount}, forcedInstancingOnly={workItem.ForcedInstancingOnlyCount}, exactConform={workItem.ExactTerrainConformPlacementCount}, approx={workItem.ApproximatePlacementCount}, newPrototypes={workItem.NewPrototypeCount}, " +
            $"prefabResolveMs={workItem.PrefabResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, prototypeResolveMs={workItem.PrototypeResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, positionBuildMs={workItem.PositionBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, normalBuildMs={workItem.NormalBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, rendererFinalizeMs={workItem.RendererFinalizeMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"rendererDeferred={rendererFinalizeDeferred}, rendererReady={rendererReady}, rendererPrototypeInitMs={rendererPrototypeInitMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, cumulativeInstanced={workItem.BuildState.Placements.Count}, cumulativePrototypes={workItem.BuildState.Prototypes.Count}.",
            this);
    }

    private static string FormatFirstVisibleFragment(VegetationTileStreamingStats tileStats)
    {
        return tileStats.FirstVisibleMilliseconds > 0d
            ? $"firstVisibleWallMs={tileStats.FirstVisibleMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, "
            : string.Empty;
    }

    private void ClearGeneratedTerrains()
    {
        CancelActiveVegetationPopulation();
        generatedConiferInstances.Clear();
        generatedTerrainShadingMetadata.Clear();
        nextConiferOptimizationTime = 0f;
        activeTerrainTileCache.Clear();
        activeTerrainTileCacheSignature = null;
        lastCompletedGenerationPipelineId = 0;
        DestroyAllGeneratedTerrainContainers(exceptRoot: null);
        activeGeneratedTerrainRoot = null;
        activeLoadedUnityTileCoordinate = null;
    }

    private string GetTerrainObjectName(int offsetX, int offsetY, int unityTileX, int unityTileY)
    {
        if (!UsesBatchNeighborhoodLoading() && offsetX == 0 && offsetY == 0)
        {
            return generatedTerrainName;
        }

        return $"{generatedTerrainName}_{unityTileX}_{unityTileY}";
    }

    private Transform CreateGeneratedTerrainBatchRoot(int pipelineId)
    {
        var rootObject = new GameObject($"{GeneratedTerrainBatchRootNamePrefix}_{pipelineId}");
        rootObject.transform.SetParent(transform, false);
        rootObject.transform.localPosition = GetGeneratedTerrainBatchRootLocalPosition();
        rootObject.transform.localRotation = Quaternion.identity;
        rootObject.transform.localScale = Vector3.one;
        return rootObject.transform;
    }

    private Vector3 GetGeneratedTerrainBatchRootLocalPosition()
    {
        if (!Application.isPlaying || !dynamicTileLoadingEnabled)
        {
            return Vector3.zero;
        }

        return new Vector3(
            unityTileCoordinate.x * terrainWidth,
            0f,
            unityTileCoordinate.y * terrainLength);
    }

    private bool TryReuseActiveTerrainBatchRoot(GeneratedTerrainBatchState batchState)
    {
        if (!reuseOverlappingDynamicNeighborhoodTiles ||
            activeGeneratedTerrainRoot == null ||
            !activeLoadedUnityTileCoordinate.HasValue ||
            !string.Equals(activeTerrainTileCacheSignature, batchState.CacheSignature, StringComparison.Ordinal))
        {
            return false;
        }

        Dictionary<Vector2Int, GStylizedTerrain> existingTerrains = GetGeneratedTerrainsByTileCoordinate(
            activeGeneratedTerrainRoot,
            activeLoadedUnityTileCoordinate.Value);
        if (existingTerrains.Count == 0)
        {
            return false;
        }

        var desiredCoordinates = new HashSet<Vector2Int>();
        var reusableTerrains = new Dictionary<Vector2Int, GStylizedTerrain>();
        for (int i = 0; i < batchState.Requests.Count; i++)
        {
            GeneratedTerrainRequest request = batchState.Requests[i];
            Vector2Int tileCoordinate = GetTileCoordinate(request);
            desiredCoordinates.Add(tileCoordinate);
            if (existingTerrains.TryGetValue(tileCoordinate, out GStylizedTerrain existingTerrain) &&
                existingTerrain != null)
            {
                reusableTerrains[tileCoordinate] = existingTerrain;
            }
        }

        if (reusableTerrains.Count == 0)
        {
            return false;
        }

        Transform batchRoot = activeGeneratedTerrainRoot;
        batchRoot.name = $"{GeneratedTerrainBatchRootNamePrefix}_{batchState.PipelineId}";
        batchRoot.localPosition = GetGeneratedTerrainBatchRootLocalPosition();
        batchRoot.localRotation = Quaternion.identity;
        batchRoot.localScale = Vector3.one;
        batchState.BatchRoot = batchRoot;

        foreach (KeyValuePair<Vector2Int, GStylizedTerrain> pair in existingTerrains)
        {
            if (desiredCoordinates.Contains(pair.Key))
            {
                continue;
            }

            batchState.RemovedTerrainCount++;
            DestroyGeneratedTerrainContainer(pair.Value.transform);
        }

        for (int i = 0; i < batchState.Requests.Count; i++)
        {
            GeneratedTerrainRequest request = batchState.Requests[i];
            Vector2Int tileCoordinate = GetTileCoordinate(request);
            if (!reusableTerrains.TryGetValue(tileCoordinate, out GStylizedTerrain terrain) || terrain == null)
            {
                continue;
            }

            terrain.name = request.TerrainObjectName;
            terrain.transform.SetParent(batchRoot, false);
            terrain.transform.localPosition = request.LocalPosition;
            terrain.transform.localRotation = Quaternion.identity;
            terrain.transform.localScale = Vector3.one;
            batchState.TerrainByCoordinate[tileCoordinate] = terrain;
            batchState.ReusedTerrainCount++;
        }

        return batchState.ReusedTerrainCount > 0;
    }

    private void FinalizeTerrainBatchState(GeneratedTerrainBatchState batchState)
    {
        batchState.ActiveTerrains.Clear();
        for (int i = 0; i < batchState.Requests.Count; i++)
        {
            GeneratedTerrainRequest request = batchState.Requests[i];
            if (batchState.TerrainByCoordinate.TryGetValue(GetTileCoordinate(request), out GStylizedTerrain terrain) &&
                terrain != null)
            {
                batchState.ActiveTerrains.Add(terrain);
            }
        }
    }

    private void PrepareDeferredGenerationTargets(GeneratedTerrainBatchState batchState)
    {
        batchState.RiverRefreshRequests.Clear();
        batchState.RiverRefreshTerrains.Clear();
        batchState.VegetationRefreshRequests.Clear();
        batchState.VegetationRefreshTerrains.Clear();

        bool refreshAllTiles =
            batchState.ReusedTerrainCount == 0 ||
            batchState.CreatedRequests.Count == 0 ||
            lastCompletedGenerationPipelineId != batchState.PipelineId - 1;
        var vegetationRefreshTiles = new HashSet<Vector2Int>();
        var riverRefreshTiles = new HashSet<Vector2Int>();

        if (refreshAllTiles)
        {
            for (int i = 0; i < batchState.Requests.Count; i++)
            {
                Vector2Int tileCoordinate = GetTileCoordinate(batchState.Requests[i]);
                vegetationRefreshTiles.Add(tileCoordinate);
                riverRefreshTiles.Add(tileCoordinate);
            }
        }
        else
        {
            var createdTileCoordinates = new HashSet<Vector2Int>();
            for (int i = 0; i < batchState.CreatedRequests.Count; i++)
            {
                Vector2Int tileCoordinate = GetTileCoordinate(batchState.CreatedRequests[i]);
                createdTileCoordinates.Add(tileCoordinate);
                vegetationRefreshTiles.Add(tileCoordinate);
                riverRefreshTiles.Add(tileCoordinate);
                riverRefreshTiles.Add(tileCoordinate + Vector2Int.left);
                riverRefreshTiles.Add(tileCoordinate + Vector2Int.right);
                riverRefreshTiles.Add(tileCoordinate + Vector2Int.up);
                riverRefreshTiles.Add(tileCoordinate + Vector2Int.down);
            }

            if (activeLoadedUnityTileCoordinate.HasValue)
            {
                Vector2Int previousCenterTileCoordinate = new(
                    activeLoadedUnityTileCoordinate.Value.x,
                    activeLoadedUnityTileCoordinate.Value.y);
                Vector2Int currentCenterTileCoordinate = new(
                    batchState.CenterTileCoordinate.x,
                    batchState.CenterTileCoordinate.y);

                for (int i = 0; i < batchState.Requests.Count; i++)
                {
                    Vector2Int tileCoordinate = GetTileCoordinate(batchState.Requests[i]);
                    if (createdTileCoordinates.Contains(tileCoordinate))
                    {
                        continue;
                    }

                    if (ShouldRefreshReusedVegetationTileForStreaming(
                            tileCoordinate,
                            previousCenterTileCoordinate,
                            currentCenterTileCoordinate))
                    {
                        vegetationRefreshTiles.Add(tileCoordinate);
                    }
                }
            }
        }

        for (int i = 0; i < batchState.Requests.Count; i++)
        {
            GeneratedTerrainRequest request = batchState.Requests[i];
            Vector2Int tileCoordinate = GetTileCoordinate(request);
            if (!batchState.TerrainByCoordinate.TryGetValue(tileCoordinate, out GStylizedTerrain terrain) || terrain == null)
            {
                continue;
            }

            if (riverRefreshTiles.Contains(tileCoordinate))
            {
                batchState.RiverRefreshRequests.Add(request);
                batchState.RiverRefreshTerrains.Add(terrain);
            }

            if (vegetationRefreshTiles.Contains(tileCoordinate))
            {
                batchState.VegetationRefreshRequests.Add(request);
                batchState.VegetationRefreshTerrains.Add(terrain);
            }
        }
    }

    private static bool ShouldRefreshReusedVegetationTileForStreaming(
        Vector2Int tileCoordinate,
        Vector2Int previousCenterTileCoordinate,
        Vector2Int currentCenterTileCoordinate)
    {
        bool wasCenterTile = tileCoordinate == previousCenterTileCoordinate;
        bool isCenterTile = tileCoordinate == currentCenterTileCoordinate;
        return wasCenterTile != isCenterTile;
    }

    private Dictionary<Vector2Int, GStylizedTerrain> GetGeneratedTerrainsByTileCoordinate(
        Transform batchRoot,
        Vector3Int centerTileCoordinate)
    {
        var terrainsByTileCoordinate = new Dictionary<Vector2Int, GStylizedTerrain>();
        foreach (GStylizedTerrain terrain in batchRoot.GetComponentsInChildren<GStylizedTerrain>(true))
        {
            if (terrain == null || !IsGeneratedTerrainName(terrain.name))
            {
                continue;
            }

            terrainsByTileCoordinate[GetTileCoordinate(terrain, centerTileCoordinate)] = terrain;
        }

        return terrainsByTileCoordinate;
    }

    private Vector2Int GetTileCoordinate(GeneratedTerrainRequest request)
        => new(request.UnityTileX, request.UnityTileY);

    private Vector2Int GetTileCoordinate(GStylizedTerrain terrain, Vector3Int centerTileCoordinate)
    {
        float safeTerrainWidth = Mathf.Max(0.0001f, terrainWidth);
        float safeTerrainLength = Mathf.Max(0.0001f, terrainLength);
        Vector3 localPosition = terrain.transform.localPosition;
        int offsetX = Mathf.RoundToInt(localPosition.x / safeTerrainWidth);
        int offsetY = Mathf.RoundToInt(localPosition.z / safeTerrainLength);
        return new Vector2Int(centerTileCoordinate.x + offsetX, centerTileCoordinate.y + offsetY);
    }

    private void PromoteGeneratedTerrainBatch(GeneratedTerrainBatchState batchState)
    {
        if (batchState.BatchRoot == null)
        {
            return;
        }

        activeGeneratedTerrainRoot = batchState.BatchRoot;
        activeLoadedUnityTileCoordinate = unityTileCoordinate;
        activeTerrainTileCache.Clear();
        for (int i = 0; i < batchState.Requests.Count; i++)
        {
            GeneratedTerrainRequest request = batchState.Requests[i];
            activeTerrainTileCache[GetTileCoordinate(request)] = new GeneratedTerrainTileData(
                request.Layers,
                request.UnityTileX,
                request.UnityTileY,
                request.LocalMinHeight,
                request.LocalMaxHeight,
                request.TileHilliness);
        }

        activeTerrainTileCacheSignature = batchState.CacheSignature;
        DestroyAllGeneratedTerrainContainers(exceptRoot: batchState.BatchRoot);
    }

    private void DestroyAllGeneratedTerrainContainers(Transform? exceptRoot)
    {
        var containersToRemove = new HashSet<Transform>();
        foreach (GStylizedTerrain terrain in GetComponentsInChildren<GStylizedTerrain>(true))
        {
            if (terrain == null || !IsGeneratedTerrainName(terrain.name))
            {
                continue;
            }

            Transform? topLevelContainer = GetTopLevelGeneratedTerrainContainer(terrain.transform);
            if (topLevelContainer == null || topLevelContainer == exceptRoot)
            {
                continue;
            }

            containersToRemove.Add(topLevelContainer);
        }

        foreach (Transform container in containersToRemove)
        {
            DestroyGeneratedTerrainContainer(container);
        }
    }

    private Transform? GetTopLevelGeneratedTerrainContainer(Transform terrainTransform)
    {
        if (terrainTransform == null)
        {
            return null;
        }

        Transform current = terrainTransform;
        while (current.parent != null && current.parent != transform)
        {
            current = current.parent;
        }

        return current.parent == transform ? current : null;
    }

    private void DestroyGeneratedTerrainContainer(Transform? container)
    {
        if (container == null)
        {
            return;
        }

        if (Application.isPlaying)
        {
            Destroy(container.gameObject);
        }
        else
        {
            DestroyImmediate(container.gameObject);
        }
    }

    private bool IsGeneratedTerrainName(string candidateName)
    {
        return candidateName == generatedTerrainName ||
               candidateName.StartsWith(generatedTerrainName + "_", StringComparison.Ordinal);
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
        int terrainGroupId,
        Transform parentRoot)
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
        terrain.transform.SetParent(parentRoot, false);
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
        double normalizationMaxHeight,
        Dictionary<string, Spline> riverSplineCache)
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
                request,
                riverPaths,
                request.Layers.RiverInfo,
                riverWaterSeams,
                request.Layers.RiverUsesProfile,
                riverSplineCache,
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

    private void PopulateRiverDebugSplines(
        IReadOnlyList<GeneratedTerrainRequest> terrainRequests,
        IReadOnlyList<GStylizedTerrain> terrains,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        Dictionary<string, Spline> riverSplineCache)
    {
        if (!createRiverDebugSplines)
        {
            return;
        }

        int terrainCount = Math.Min(terrainRequests.Count, terrains.Count);
        for (int i = 0; i < terrainCount; i++)
        {
            GeneratedTerrainRequest request = terrainRequests[i];
            IReadOnlyList<RiverSurfacePath> riverPaths = request.Layers.RiverSurfacePaths;
            if (riverPaths.Count == 0)
            {
                continue;
            }

            GStylizedTerrain terrain = terrains[i];
            if (terrain == null)
            {
                continue;
            }

            Transform riverContainer = CreateRiverWaterContainer(terrain.transform);
            SplineContainer splineContainer = CreateRiverDebugSplineContainer(riverContainer);
            IReadOnlyList<Spline> splines = BuildRiverDebugSplines(
                terrain,
                request.Layers.RiverSurfaceHeightmap ?? request.Layers.Heightmap,
                request,
                riverPaths,
                riverSplineCache,
                normalizationMinHeight,
                normalizationMaxHeight);
            splineContainer.Splines = splines;
            splineContainer.gameObject.SetActive(splines.Count > 0);
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
        GeneratedTerrainRequest request,
        IReadOnlyList<RiverSurfacePath> riverPaths,
        RiverInfo? riverInfo,
        IDictionary<string, RiverWaterSeamCrossSection> riverWaterSeams,
        bool usesRiverProfile,
        Dictionary<string, Spline> riverSplineCache,
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
                request,
                riverPaths[i],
                i,
                riverInfo,
                riverWaterSeams,
                usesRiverProfile,
                riverSplineCache,
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
        GeneratedTerrainRequest request,
        RiverSurfacePath riverPath,
        int riverPathIndex,
        RiverInfo? riverInfo,
        IDictionary<string, RiverWaterSeamCrossSection> riverWaterSeams,
        bool usesRiverProfile,
        Dictionary<string, Spline> riverSplineCache,
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
        int heightResolution = heightmap.GetLength(0);
        int widthResolution = heightmap.GetLength(1);
        float sampleSpacingX = widthResolution > 1 ? terrainWidth / (widthResolution - 1) : terrainWidth;
        float sampleSpacingZ = heightResolution > 1 ? terrainLength / (heightResolution - 1) : terrainLength;
        if (!TryBuildRiverWaterSplineSamples(
                terrain,
                heightmap,
                request,
                riverPath,
                riverPathIndex,
                pathPoints,
                sampleSpacingX,
                sampleSpacingZ,
                riverSplineCache,
                normalizationMinHeight,
                normalizationMaxHeight,
                centers,
                sampledPoints,
                sampleSeams))
        {
            return null;
        }

        ApplyRiverSplineAveraging();
        float[] riverSlopeDegrees = BuildRiverWaterSlopeDegrees(centers);
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

        void ApplyRiverSplineAveraging()
        {
            int averagingElements = Math.Max(1, riverSplineAvgElements);
            if (averagingElements <= 1 || centers.Count <= 1)
            {
                return;
            }

            int halfBefore = (averagingElements - 1) / 2;
            int halfAfter = averagingElements / 2;
            var averagedY = new float[centers.Count];

            for (int i = 0; i < centers.Count; i++)
            {
                int start = Math.Max(0, i - halfBefore);
                int end = Math.Min(centers.Count - 1, i + halfAfter);
                float sum = 0f;
                int count = 0;
                for (int sampleIndex = start; sampleIndex <= end; sampleIndex++)
                {
                    sum += centers[sampleIndex].y;
                    count++;
                }

                averagedY[i] = count > 0 ? sum / count : centers[i].y;
            }

            for (int i = 0; i < centers.Count; i++)
            {
                Vector3 center = centers[i];
                centers[i] = new Vector3(center.x, averagedY[i], center.z);
            }
        }

        void ApplyRiverWaterSurfaceHeights()
        {
            float bedClearance = usesRiverProfile ? 0f : Mathf.Max(0f, riverWaterBedClearance);
            float profileInset = usesRiverProfile ? 0.01f : 0f;
            var centerBedHeights = new float[centers.Count];

            for (int i = 0; i < centers.Count; i++)
            {
                centerBedHeights[i] = centers[i].y;
                float meshVerticalOffset = EvaluateSlopeDrivenRiverValue(
                    riverWaterMeshVerticalOffset,
                    riverWaterMeshVerticalOffsetAtNinetyDegrees,
                    riverSlopeDegrees[i]);
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

    private SplineContainer CreateRiverDebugSplineContainer(Transform riverContainer)
    {
        string containerName = string.IsNullOrWhiteSpace(generatedRiverSplineContainerName)
            ? "RiverDebugSpline"
            : generatedRiverSplineContainerName.Trim();
        Transform existing = riverContainer.Find(containerName);
        GameObject containerObject;
        if (existing != null)
        {
            containerObject = existing.gameObject;
        }
        else
        {
            containerObject = new GameObject(containerName);
            containerObject.transform.SetParent(riverContainer, false);
            containerObject.transform.localPosition = Vector3.zero;
            containerObject.transform.localRotation = Quaternion.identity;
            containerObject.transform.localScale = Vector3.one;
        }

        SplineContainer splineContainer = containerObject.GetComponent<SplineContainer>();
        if (splineContainer == null)
        {
            splineContainer = containerObject.AddComponent<SplineContainer>();
        }

        return splineContainer;
    }

    private IReadOnlyList<Spline> BuildRiverDebugSplines(
        GStylizedTerrain terrain,
        double[,] heightmap,
        GeneratedTerrainRequest request,
        IReadOnlyList<RiverSurfacePath> riverPaths,
        Dictionary<string, Spline> riverSplineCache,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        var splines = new List<Spline>(riverPaths.Count);
        int heightResolution = heightmap.GetLength(0);
        int widthResolution = heightmap.GetLength(1);
        float sampleSpacingX = widthResolution > 1 ? terrainWidth / (widthResolution - 1f) : terrainWidth;
        float sampleSpacingZ = heightResolution > 1 ? terrainLength / (heightResolution - 1f) : terrainLength;

        for (int i = 0; i < riverPaths.Count; i++)
        {
            Spline? spline = BuildRiverDebugSpline(
                terrain,
                heightmap,
                request,
                riverPaths[i],
                i,
                riverSplineCache,
                sampleSpacingX,
                sampleSpacingZ,
                normalizationMinHeight,
                normalizationMaxHeight);
            if (spline != null)
            {
                splines.Add(spline);
            }
        }

        return splines;
    }

    private Spline? BuildRiverDebugSpline(
        GStylizedTerrain terrain,
        double[,] heightmap,
        GeneratedTerrainRequest request,
        RiverSurfacePath riverPath,
        int riverPathIndex,
        Dictionary<string, Spline> riverSplineCache,
        float sampleSpacingX,
        float sampleSpacingZ,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        return GetOrBuildRiverTerrainConformedSpline(
            riverSplineCache,
            request,
            riverPathIndex,
            terrain,
            heightmap,
            riverPath,
            sampleSpacingX,
            sampleSpacingZ,
            normalizationMinHeight,
            normalizationMaxHeight,
            1,
            TangentMode.Linear);
    }

    private Spline? BuildRiverTerrainConformedSpline(
        GStylizedTerrain? terrain,
        double[,] heightmap,
        RiverSurfacePath riverPath,
        float sampleSpacingX,
        float sampleSpacingZ,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        int knotStep,
        TangentMode tangentMode)
    {
        IReadOnlyList<RiverSurfacePoint> pathPoints = riverPath.Points;
        if (pathPoints.Count < 2)
        {
            return null;
        }

        var spline = new Spline();
        int effectiveStep = Math.Max(1, knotStep);
        float terrainSampleSpacingX = Mathf.Max(0.05f, sampleSpacingX);
        float terrainSampleSpacingZ = Mathf.Max(0.05f, sampleSpacingZ);

        for (int i = 0; i < pathPoints.Count; i += effectiveStep)
        {
            AddRiverSplineKnot(i);
        }

        if ((pathPoints.Count - 1) % effectiveStep != 0)
        {
            AddRiverSplineKnot(pathPoints.Count - 1);
        }

        return spline.Count >= 2 ? spline : null;

        void AddRiverSplineKnot(int index)
        {
            RiverSurfacePoint pathPoint = pathPoints[index];
            Vector3 localPoint = GetTerrainLocalPoint(
                terrain,
                heightmap,
                pathPoint.X,
                pathPoint.Y,
                normalizationMinHeight,
                normalizationMaxHeight,
                0f);

            if (terrain != null &&
                TrySampleGeneratedTerrainLocalMinimumPoint3x3(
                    terrain,
                    localPoint.x,
                    localPoint.z,
                    terrainSampleSpacingX,
                    terrainSampleSpacingZ,
                    out float sampledMinY))
            {
                localPoint.y = sampledMinY;
            }

            spline.Add(new float3(localPoint.x, localPoint.y, localPoint.z), tangentMode);
        }
    }

    private Spline? GetOrBuildRiverTerrainConformedSpline(
        Dictionary<string, Spline> riverSplineCache,
        GeneratedTerrainRequest request,
        int riverPathIndex,
        GStylizedTerrain? terrain,
        double[,] heightmap,
        RiverSurfacePath riverPath,
        float sampleSpacingX,
        float sampleSpacingZ,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        int knotStep,
        TangentMode tangentMode)
    {
        string cacheKey = string.Join(
            "|",
            request.UnityTileX.ToString(CultureInfo.InvariantCulture),
            request.UnityTileY.ToString(CultureInfo.InvariantCulture),
            riverPathIndex.ToString(CultureInfo.InvariantCulture),
            knotStep.ToString(CultureInfo.InvariantCulture),
            ((int)tangentMode).ToString(CultureInfo.InvariantCulture),
            heightmap.GetLength(0).ToString(CultureInfo.InvariantCulture),
            heightmap.GetLength(1).ToString(CultureInfo.InvariantCulture));

        if (riverSplineCache.TryGetValue(cacheKey, out Spline cachedSpline))
        {
            return cachedSpline;
        }

        Spline? spline = BuildRiverTerrainConformedSpline(
            terrain,
            heightmap,
            riverPath,
            sampleSpacingX,
            sampleSpacingZ,
            normalizationMinHeight,
            normalizationMaxHeight,
            knotStep,
            tangentMode);
        if (spline != null)
        {
            riverSplineCache[cacheKey] = spline;
        }

        return spline;
    }

    private bool TryBuildRiverWaterSplineSamples(
        GStylizedTerrain? terrain,
        double[,] heightmap,
        GeneratedTerrainRequest request,
        RiverSurfacePath riverPath,
        int riverPathIndex,
        IReadOnlyList<RiverSurfacePoint> pathPoints,
        float sampleSpacingX,
        float sampleSpacingZ,
        Dictionary<string, Spline> riverSplineCache,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        List<Vector3> centers,
        List<RiverSurfacePoint> sampledPoints,
        List<(bool IsSeam, string? Direction, bool IsStart)> sampleSeams)
    {
        int splineStep = Math.Max(1, riverSplineSamplingStep);
        Spline? spline = GetOrBuildRiverTerrainConformedSpline(
            riverSplineCache,
            request,
            riverPathIndex,
            terrain,
            heightmap,
            riverPath,
            sampleSpacingX,
            sampleSpacingZ,
            normalizationMinHeight,
            normalizationMaxHeight,
            splineStep,
            TangentMode.AutoSmooth);

        if (spline == null)
        {
            return false;
        }

        var sourceSampleIndices = new List<int>();
        int meshStride = Math.Max(1, riverWaterSampleStride);
        for (int i = 0; i < pathPoints.Count; i += meshStride)
        {
            sourceSampleIndices.Add(i);
        }

        if (sourceSampleIndices.Count == 0 || sourceSampleIndices[^1] != pathPoints.Count - 1)
        {
            sourceSampleIndices.Add(pathPoints.Count - 1);
        }

        float minSegmentLength = Mathf.Max(0f, riverWaterMinSegmentLength);
        float minSegmentSqr = minSegmentLength * minSegmentLength;
        float denominator = Math.Max(1, pathPoints.Count - 1);

        for (int sampleIndex = 0; sampleIndex < sourceSampleIndices.Count; sampleIndex++)
        {
            int sourceIndex = sourceSampleIndices[sampleIndex];
            RiverSurfacePoint pathPoint = pathPoints[sourceIndex];
            float t = sourceIndex / denominator;
            float3 splinePosition = spline.EvaluatePosition(t);
            Vector3 localPoint = new(splinePosition.x, splinePosition.y, splinePosition.z);
            var seam = GetRiverWaterEndpointSeamForPathIndex(pathPoints, heightmap, sourceIndex, pathPoint);

            if (centers.Count > 0 && minSegmentLength > 0f)
            {
                if ((localPoint - centers[^1]).sqrMagnitude < minSegmentSqr)
                {
                    if (sampleIndex == sourceSampleIndices.Count - 1)
                    {
                        centers[^1] = localPoint;
                        sampledPoints[^1] = pathPoint;
                        sampleSeams[^1] = seam;
                    }

                    continue;
                }
            }

            centers.Add(localPoint);
            sampledPoints.Add(pathPoint);
            sampleSeams.Add(seam);
        }

        return centers.Count >= 2;
    }

    private Material? ResolveRiverWaterMaterial()
    {
        if (riverWaterMaterial != null)
        {
            return riverWaterMaterial;
        }

        string assetPath = GetRiverWaterMaterialAssetPath();
        if (cachedRiverWaterMaterial != null &&
            string.Equals(cachedRiverWaterMaterialPath, assetPath, StringComparison.OrdinalIgnoreCase))
        {
            return cachedRiverWaterMaterial;
        }

#if UNITY_EDITOR
        Material material = AssetDatabase.LoadAssetAtPath<Material>(assetPath);
        if (material != null)
        {
            cachedRiverWaterMaterial = material;
            cachedRiverWaterMaterialPath = assetPath;
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

    private static float[] BuildRiverWaterSlopeDegrees(IReadOnlyList<Vector3> centers)
    {
        var slopeDegrees = new float[centers.Count];
        for (int i = 0; i < centers.Count; i++)
        {
            int previousIndex = Math.Max(0, i - 1);
            int nextIndex = Math.Min(centers.Count - 1, i + 1);
            if (previousIndex == nextIndex)
            {
                continue;
            }

            Vector3 delta = centers[nextIndex] - centers[previousIndex];
            float horizontalDistance = new Vector2(delta.x, delta.z).magnitude;
            if (horizontalDistance <= 0.0001f)
            {
                continue;
            }

            slopeDegrees[i] = Mathf.Clamp(Mathf.Atan2(Mathf.Abs(delta.y), horizontalDistance) * Mathf.Rad2Deg, 0f, 90f);
        }

        return slopeDegrees;
    }

    private static float EvaluateSlopeDrivenRiverValue(float flatValue, float steepValue, float slopeDegrees)
    {
        return Mathf.Lerp(flatValue, steepValue, Mathf.Clamp01(slopeDegrees / 90f));
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

    private static (bool IsSeam, string? Direction, bool IsStart) GetRiverWaterEndpointSeamForPathIndex(
        IReadOnlyList<RiverSurfacePoint> pathPoints,
        double[,] heightmap,
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
        if (UsesLegacyVegetationObjects())
        {
            MeasureGenerationPhase(
                VegetationRenderMarker,
                "vegetation GameObject instantiation",
                () =>
                {
                    for (int i = 0; i < terrainCount; i++)
                    {
                        GeneratedTerrainRequest request = terrainRequests[i];
                        GStylizedTerrain terrain = terrains[i];
                        PopulatePlacedObjectsLegacy(terrain, request, normalizationMinHeight, normalizationMaxHeight);
                    }
                });
            return;
        }

        MeasureGenerationPhase(
            VegetationRenderMarker,
            "vegetation instancing",
            () =>
            {
                for (int i = 0; i < terrainCount; i++)
                {
                    GeneratedTerrainRequest request = terrainRequests[i];
                    GStylizedTerrain terrain = terrains[i];
                    PopulatePlacedObjectsHybrid(terrain, request, normalizationMinHeight, normalizationMaxHeight);
                }
            });
    }

    private void PopulateVegetationImmediately(GeneratedTerrainBatchState batchState)
    {
        if (!placeTreeObjects && !placeSurfaceObjects)
        {
            return;
        }

        int terrainCount = Math.Min(batchState.VegetationRefreshRequests.Count, batchState.VegetationRefreshTerrains.Count);
        if (UsesLegacyVegetationObjects())
        {
            MeasureGenerationPhase(
                VegetationRenderMarker,
                "vegetation GameObject instantiation",
                () =>
                {
                    for (int i = 0; i < terrainCount; i++)
                    {
                        PopulatePlacedObjectsLegacy(
                            batchState.VegetationRefreshTerrains[i],
                            batchState.VegetationRefreshRequests[i],
                            batchState.NormalizationMinHeight,
                            batchState.NormalizationMaxHeight);
                    }
                });
            return;
        }

        var totalStopwatch = Stopwatch.StartNew();
        var queuePrepStopwatch = Stopwatch.StartNew();
        List<VegetationWorkItem> workItems = PrepareVegetationWorkItems(batchState, totalStopwatch);
        queuePrepStopwatch.Stop();
        RecordGenerationPhaseTiming(batchState, "vegetation queue prep", queuePrepStopwatch.Elapsed);
        LogGenerationPhaseTiming("vegetation queue prep", queuePrepStopwatch.Elapsed);

        for (int i = 0; i < workItems.Count; i++)
        {
            VegetationWorkItem workItem = workItems[i];
            while (ProcessNextVegetationWorkItemPlacement(workItem, totalStopwatch))
            {
            }

            FinalizeVegetationWorkItem(workItem, totalStopwatch);
        }

        totalStopwatch.Stop();
        batchState.VegetationFullSettledMilliseconds = totalStopwatch.Elapsed.TotalMilliseconds;
        FinalizeAndLogPendingVegetationTileStats(batchState, batchState.VegetationFullSettledMilliseconds);
    }

    private IEnumerator PopulateVegetationOverMultipleFrames(GeneratedTerrainBatchState batchState)
    {
        bool completed = false;
        var totalStopwatch = Stopwatch.StartNew();
        try
        {
            ClearGeneratedVegetationOutputs(batchState.VegetationRefreshTerrains);

            var queuePrepStopwatch = Stopwatch.StartNew();
            List<VegetationWorkItem> workItems = PrepareVegetationWorkItems(batchState, totalStopwatch);
            queuePrepStopwatch.Stop();
            RecordGenerationPhaseTiming(batchState, "vegetation queue prep", queuePrepStopwatch.Elapsed);
            LogGenerationPhaseTiming("vegetation queue prep", queuePrepStopwatch.Elapsed);

            double frameBudgetMilliseconds = Math.Max(0.25f, vegetationPlacementBudgetMsPerFrame);
            var frameStopwatch = Stopwatch.StartNew();

            for (int workItemIndex = 0; workItemIndex < workItems.Count; workItemIndex++)
            {
                if (batchState.PipelineId != activeGenerationPipelineId || this == null)
                {
                    yield break;
                }

                VegetationWorkItem workItem = workItems[workItemIndex];
                while (ProcessNextVegetationWorkItemPlacement(workItem, totalStopwatch))
                {
                    if (frameStopwatch.Elapsed.TotalMilliseconds < frameBudgetMilliseconds)
                    {
                        continue;
                    }

                    frameStopwatch.Restart();
                    yield return null;
                    if (batchState.PipelineId != activeGenerationPipelineId || this == null)
                    {
                        yield break;
                    }
                }

                FinalizeVegetationWorkItem(workItem, totalStopwatch);
                if (frameStopwatch.Elapsed.TotalMilliseconds < frameBudgetMilliseconds)
                {
                    continue;
                }

                frameStopwatch.Restart();
                yield return null;
            }

            totalStopwatch.Stop();
            batchState.VegetationFullSettledMilliseconds = totalStopwatch.Elapsed.TotalMilliseconds;
            FinalizeAndLogPendingVegetationTileStats(batchState, batchState.VegetationFullSettledMilliseconds);
            completed = true;
        }
        finally
        {
            if (activeVegetationPopulationBatchState == batchState)
            {
                activeVegetationPopulationBatchState = null;
                activeVegetationPopulationStopwatch = null;
            }

            activeVegetationPopulationCoroutine = null;
            if (completed && batchState.PipelineId == activeGenerationPipelineId && this != null)
            {
                RecordGenerationPhaseTiming(
                    batchState,
                    "vegetation placement (spread)",
                    totalStopwatch.Elapsed);
                LogGenerationPhaseTiming("vegetation placement (spread)", totalStopwatch.Elapsed);
                FinishDeferredGenerationPhases(batchState);
            }
        }
    }

    private List<VegetationWorkItem> PrepareVegetationWorkItems(GeneratedTerrainBatchState batchState, Stopwatch totalStopwatch)
    {
        var orderedWorkItems = new List<VegetationWorkItem>();
        var workItemsByBucket = new Dictionary<VegetationPriorityBucket, List<VegetationWorkItem>>();
        batchState.VegetationStreamingTargetWorldPosition = ResolveVegetationStreamingTargetWorldPosition();
        int terrainCount = Math.Min(batchState.VegetationRefreshRequests.Count, batchState.VegetationRefreshTerrains.Count);
        for (int i = 0; i < terrainCount; i++)
        {
            GeneratedTerrainRequest request = batchState.VegetationRefreshRequests[i];
            GStylizedTerrain terrain = batchState.VegetationRefreshTerrains[i];
            Vector2Int tileCoordinate = GetTileCoordinate(request);
            HybridVegetationBuildState? buildState = BeginHybridVegetationBuild(
                batchState,
                terrain,
                request,
                batchState.NormalizationMinHeight,
                batchState.NormalizationMaxHeight);
            if (buildState == null)
            {
                continue;
            }

            List<PreparedVegetationPlacement> preparedPlacements = PrepareVegetationPlacementsForRequest(
                batchState,
                totalStopwatch,
                terrain,
                request);
            if (preparedPlacements.Count == 0)
            {
                continue;
            }

            foreach (VegetationPriorityBucket bucket in Enum.GetValues(typeof(VegetationPriorityBucket)))
            {
                List<PreparedVegetationPlacement>? bucketPlacements = null;
                for (int placementIndex = 0; placementIndex < preparedPlacements.Count; placementIndex++)
                {
                    PreparedVegetationPlacement preparedPlacement = preparedPlacements[placementIndex];
                    if (preparedPlacement.PriorityBucket != bucket)
                    {
                        continue;
                    }

                    bucketPlacements ??= new List<PreparedVegetationPlacement>();
                    bucketPlacements.Add(preparedPlacement);
                }

                if (bucketPlacements == null || bucketPlacements.Count == 0)
                {
                    continue;
                }

                if (!workItemsByBucket.TryGetValue(bucket, out List<VegetationWorkItem>? bucketWorkItems))
                {
                    bucketWorkItems = new List<VegetationWorkItem>();
                    workItemsByBucket[bucket] = bucketWorkItems;
                }

                int chunkSize = ResolveVegetationWorkItemChunkSize(bucket);
                int chunkCountForBucket = (bucketPlacements.Count + chunkSize - 1) / chunkSize;
                string bucketKey = bucket.ToString();
                int chunkOrdinalWithinBucket = 0;
                for (int chunkStart = 0; chunkStart < bucketPlacements.Count; chunkStart += chunkSize)
                {
                    int chunkCount = Math.Min(chunkSize, bucketPlacements.Count - chunkStart);
                    var chunkPlacements = new List<PreparedVegetationPlacement>(chunkCount);
                    for (int chunkIndex = 0; chunkIndex < chunkCount; chunkIndex++)
                    {
                        chunkPlacements.Add(bucketPlacements[chunkStart + chunkIndex]);
                    }

                    batchState.VegetationTileStats[tileCoordinate].RecordQueuedWorkItem(chunkPlacements.Count, bucket);
                    batchState.VegetationQueuedWorkItemCount++;
                    batchState.VegetationQueuedPlacementCount += chunkPlacements.Count;
                    IncrementCount(batchState.VegetationQueuedWorkItemsByBucket, bucketKey);
                    AddCount(batchState.VegetationQueuedPlacementsByBucket, bucketKey, chunkPlacements.Count);
                    bucketWorkItems.Add(new VegetationWorkItem(
                        buildState,
                        bucket,
                        chunkPlacements,
                        preparedPlacements[0].IsCenterTile,
                        chunkOrdinalWithinBucket,
                        chunkCountForBucket));
                    chunkOrdinalWithinBucket++;
                }
            }
        }

        foreach (VegetationPriorityBucket bucket in Enum.GetValues(typeof(VegetationPriorityBucket)))
        {
            if (!workItemsByBucket.TryGetValue(bucket, out List<VegetationWorkItem>? bucketWorkItems) ||
                bucketWorkItems.Count == 0)
            {
                continue;
            }

            orderedWorkItems.AddRange(bucketWorkItems);
        }

        for (int i = orderedWorkItems.Count - 1; i >= 0; i--)
        {
            if (!orderedWorkItems[i].IsCenterTile)
            {
                continue;
            }

            if (orderedWorkItems[i].PriorityBucket == VegetationPriorityBucket.OuterGroundAndDebris)
            {
                continue;
            }

            orderedWorkItems[i].MarksCenterTileReady = true;
            break;
        }

        if (!orderedWorkItems.Any(item => item.MarksCenterTileReady))
        {
            for (int i = orderedWorkItems.Count - 1; i >= 0; i--)
            {
                if (!orderedWorkItems[i].IsCenterTile)
                {
                    continue;
                }

                orderedWorkItems[i].MarksCenterTileReady = true;
                break;
            }
        }

        var finalizedBuildStates = new HashSet<HybridVegetationBuildState>();
        for (int i = orderedWorkItems.Count - 1; i >= 0; i--)
        {
            VegetationWorkItem workItem = orderedWorkItems[i];
            if (finalizedBuildStates.Add(workItem.BuildState))
            {
                workItem.IsFinalChunkForTile = true;
            }
        }

        TryLogVegetationWorkQueueSummary(batchState, orderedWorkItems);
        return orderedWorkItems;
    }

    private List<PreparedVegetationPlacement> PrepareVegetationPlacementsForRequest(
        GeneratedTerrainBatchState batchState,
        Stopwatch totalStopwatch,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request)
    {
        var preparedPlacements = new List<PreparedVegetationPlacement>();
        var cappedPlacements = new Dictionary<int, List<PreparedVegetationPlacement>>();
        Vector2Int tileCoordinate = GetTileCoordinate(request);
        bool isCenterTile = tileCoordinate == new Vector2Int(batchState.CenterTileCoordinate.x, batchState.CenterTileCoordinate.y);
        VegetationTileStreamingStats tileStats = GetOrCreateVegetationTileStats(batchState, tileCoordinate, isCenterTile);
        IReadOnlyList<TileObjectPlacement> placedObjects = request.Layers.PlacedObjects ?? Array.Empty<TileObjectPlacement>();
        double hashPolicyMilliseconds = 0d;
        double distanceAdmissionMilliseconds = 0d;
        double capApplicationMilliseconds = 0d;
        double geometryFinalizeMilliseconds = 0d;
        double sortMilliseconds = 0d;
        var phaseStopwatch = new Stopwatch();

        for (int placementIndex = 0; placementIndex < placedObjects.Count; placementIndex++)
        {
            TileObjectPlacement placement = placedObjects[placementIndex];
            string categoryName = GetPlacementCategoryName(placement);
            tileStats.RecordGenerated(categoryName);
            batchState.VegetationGeneratedPlacementCount++;

            string? vegetationCategory = placement.Definition.VegetationCategory;
            if (!placeTreeObjects && string.Equals(vegetationCategory, "tree", StringComparison.OrdinalIgnoreCase))
            {
                continue;
            }

            if (!placeSurfaceObjects &&
                !string.IsNullOrWhiteSpace(vegetationCategory) &&
                !string.Equals(vegetationCategory, "tree", StringComparison.OrdinalIgnoreCase))
            {
                continue;
            }

            phaseStopwatch.Restart();
            ulong stableHash = ComputeStablePlacementHash(request, placement);
            if (!ShouldKeepPlacementForTile(placement, isCenterTile, stableHash))
            {
                hashPolicyMilliseconds += phaseStopwatch.Elapsed.TotalMilliseconds;
                tileStats.RecordSkipped(categoryName);
                batchState.VegetationSkippedByPolicyCount++;
                continue;
            }
            hashPolicyMilliseconds += phaseStopwatch.Elapsed.TotalMilliseconds;

            bool isTreePlacement = string.Equals(vegetationCategory, "tree", StringComparison.OrdinalIgnoreCase);
            phaseStopwatch.Restart();
            if (!TryBuildPreparedPlacementGeometry(
                    batchState,
                    tileStats,
                    terrain,
                    request,
                    placement,
                    isTreePlacement,
                    out PreparedPlacementGeometry geometry))
            {
                distanceAdmissionMilliseconds += phaseStopwatch.Elapsed.TotalMilliseconds;
                tileStats.RecordSkipped(categoryName);
                batchState.VegetationSkippedByDistanceCount++;
                continue;
            }
            distanceAdmissionMilliseconds += phaseStopwatch.Elapsed.TotalMilliseconds;

            phaseStopwatch.Restart();
            if (!ShouldKeepPlacementForDensityZone(placement, geometry.DensityZone, stableHash))
            {
                hashPolicyMilliseconds += phaseStopwatch.Elapsed.TotalMilliseconds;
                tileStats.RecordSkipped(categoryName);
                batchState.VegetationSkippedByPolicyCount++;
                continue;
            }
            hashPolicyMilliseconds += phaseStopwatch.Elapsed.TotalMilliseconds;

            TileObjectStreamingTier streamingTier = placement.Definition.StreamingTier;
            var preparedPlacement = new PreparedVegetationPlacement(
                placement,
                stableHash,
                isCenterTile,
                DeterminePriorityBucket(isCenterTile, streamingTier),
                ShouldForceInstancingOnlyForPreparedPlacement(isCenterTile, streamingTier),
                geometry);

            int? maxPlacementsPerTile = placement.Definition.MaxPlacementsPerTile;
            if (maxPlacementsPerTile.HasValue)
            {
                if (!cappedPlacements.TryGetValue(placement.Definition.NumericId, out List<PreparedVegetationPlacement>? entries))
                {
                    entries = new List<PreparedVegetationPlacement>();
                    cappedPlacements[placement.Definition.NumericId] = entries;
                }

                entries.Add(preparedPlacement);
                continue;
            }

            tileStats.RecordKept(categoryName);
            batchState.VegetationKeptPlacementCount++;
            preparedPlacements.Add(preparedPlacement);
        }

        phaseStopwatch.Restart();
        foreach (KeyValuePair<int, List<PreparedVegetationPlacement>> entry in cappedPlacements)
        {
            List<PreparedVegetationPlacement> definitionPlacements = entry.Value;
            definitionPlacements.Sort((left, right) => left.StableHash.CompareTo(right.StableHash));
            int keepCount = definitionPlacements.Count == 0
                ? 0
                : Math.Min(
                    definitionPlacements[0].Placement.Definition.MaxPlacementsPerTile ?? definitionPlacements.Count,
                    definitionPlacements.Count);

            for (int i = 0; i < definitionPlacements.Count; i++)
            {
                PreparedVegetationPlacement preparedPlacement = definitionPlacements[i];
                string categoryName = GetPlacementCategoryName(preparedPlacement.Placement);
                if (i < keepCount)
                {
                    tileStats.RecordKept(categoryName);
                    batchState.VegetationKeptPlacementCount++;
                    preparedPlacements.Add(preparedPlacement);
                    continue;
                }

                tileStats.RecordSkipped(categoryName);
                batchState.VegetationSkippedByCapCount++;
            }
        }
        capApplicationMilliseconds += phaseStopwatch.Elapsed.TotalMilliseconds;

        phaseStopwatch.Restart();
        preparedPlacements.Sort((left, right) =>
        {
            int bucketCompare = left.PriorityBucket.CompareTo(right.PriorityBucket);
            return bucketCompare != 0
                ? bucketCompare
                : left.StableHash.CompareTo(right.StableHash);
        });
        sortMilliseconds += phaseStopwatch.Elapsed.TotalMilliseconds;

        phaseStopwatch.Restart();
        PopulatePreparedPlacementGeometryNormals(batchState, tileStats, request, preparedPlacements);
        geometryFinalizeMilliseconds += phaseStopwatch.Elapsed.TotalMilliseconds;

        double queuePrepCpuMilliseconds =
            hashPolicyMilliseconds +
            distanceAdmissionMilliseconds +
            capApplicationMilliseconds +
            geometryFinalizeMilliseconds +
            sortMilliseconds;
        batchState.VegetationQueuePrepCpuMilliseconds += queuePrepCpuMilliseconds;
        tileStats.RecordQueuePrep(queuePrepCpuMilliseconds, totalStopwatch.Elapsed.TotalMilliseconds);
        if (hashPolicyMilliseconds > 0d)
        {
            batchState.RecordPhaseTiming("vegetation queue prep/hash-policy", hashPolicyMilliseconds);
        }

        if (distanceAdmissionMilliseconds > 0d)
        {
            batchState.RecordPhaseTiming("vegetation queue prep/distance admission", distanceAdmissionMilliseconds);
        }

        if (capApplicationMilliseconds > 0d)
        {
            batchState.RecordPhaseTiming("vegetation queue prep/cap application", capApplicationMilliseconds);
        }

        if (sortMilliseconds > 0d)
        {
            batchState.RecordPhaseTiming("vegetation queue prep/sort", sortMilliseconds);
        }

        if (geometryFinalizeMilliseconds > 0d)
        {
            batchState.RecordPhaseTiming("vegetation queue prep/normal cache", geometryFinalizeMilliseconds);
        }

        return preparedPlacements;
    }

    private bool ProcessNextVegetationWorkItemPlacement(VegetationWorkItem workItem, Stopwatch totalStopwatch)
    {
        if (workItem.NextPlacementIndex >= workItem.Placements.Count)
        {
            return false;
        }

        PreparedVegetationPlacement preparedPlacement = workItem.Placements[workItem.NextPlacementIndex];
        workItem.NextPlacementIndex++;
        bool placementBecameVisible = ProcessPreparedHybridVegetationPlacement(workItem, preparedPlacement);
        if (placementBecameVisible && workItem.BuildState.BatchState != null)
        {
            Vector2Int tileCoordinate = GetTileCoordinate(workItem.BuildState.Request);
            VegetationTileStreamingStats tileStats = GetOrCreateVegetationTileStats(
                workItem.BuildState.BatchState,
                tileCoordinate,
                workItem.IsCenterTile);
            tileStats.RecordVisible(totalStopwatch.Elapsed.TotalMilliseconds);
        }

        return workItem.NextPlacementIndex < workItem.Placements.Count;
    }

    private bool ProcessPreparedHybridVegetationPlacement(
        VegetationWorkItem workItem,
        PreparedVegetationPlacement preparedPlacement)
    {
        HybridVegetationBuildState buildState = workItem.BuildState;
        TileObjectPlacement placement = preparedPlacement.Placement;
        VegetationTileStreamingStats? tileStats = null;
        if (buildState.BatchState != null)
        {
            tileStats = GetOrCreateVegetationTileStats(
                buildState.BatchState,
                GetTileCoordinate(buildState.Request),
                preparedPlacement.IsCenterTile);
        }

        var phaseStopwatch = Stopwatch.StartNew();
        GameObject? prefab = LoadPrefabForPlacement(placement, buildState.BatchState);
        phaseStopwatch.Stop();
        RecordPlacementPhaseTiming(
            buildState.BatchState,
            tileStats,
            phaseStopwatch.Elapsed.TotalMilliseconds,
            VegetationPlacementPhase.PrefabResolve,
            workItem);
        if (prefab == null)
        {
            workItem.RecordMissingPrefab();
            tileStats?.RecordMissingPrefab();
            return false;
        }

        bool isTreeObject = IsTreePlacement(placement, prefab);
        if (isTreeObject && !placeTreeObjects)
        {
            return false;
        }

        if (!isTreeObject && !placeSurfaceObjects)
        {
            return false;
        }

        bool requiresInstancingOnly = preparedPlacement.ForceInstancingOnly || RequiresInstancingOnly(placement);
        bool supportsPromotion = !preparedPlacement.ForceInstancingOnly && SupportsHybridPromotion(placement);
        phaseStopwatch.Restart();
        TileLoaderInstancedVegetationPrototype? prototype = GetOrCreateVegetationPrototype(
            buildState.BatchState,
            placement,
            prefab,
            isTreeObject,
            supportsPromotion);
        phaseStopwatch.Stop();
        RecordPlacementPhaseTiming(
            buildState.BatchState,
            tileStats,
            phaseStopwatch.Elapsed.TotalMilliseconds,
            VegetationPlacementPhase.PrototypeResolve,
            workItem);
        if (prototype != null &&
            TryBuildInstancedPlacement(
                buildState,
                tileStats,
                workItem,
                preparedPlacement,
                prototype,
                out TileLoaderInstancedVegetationPlacement instancedPlacement))
        {
            buildState.VegetationContainer ??= CreateVegetationContainer(buildState.Terrain.transform);
            if (!buildState.PrototypeIndices.TryGetValue(prototype.Key, out int prototypeIndex))
            {
                prototypeIndex = buildState.Prototypes.Count;
                buildState.PrototypeIndices[prototype.Key] = prototypeIndex;
                buildState.Prototypes.Add(prototype);
                workItem.NewPrototypeCount++;
            }

            buildState.Placements.Add(new TileLoaderInstancedVegetationPlacement(
                prototypeIndex,
                instancedPlacement.LocalPosition,
                instancedPlacement.LocalRotation,
                instancedPlacement.LocalScale,
                instancedPlacement.ConformToTerrainOnPromotion,
                instancedPlacement.SurfaceSampleLocalX,
                instancedPlacement.SurfaceSampleLocalZ,
                instancedPlacement.SurfaceVerticalOffset,
                instancedPlacement.SurfaceNormalOffset));
            workItem.RecordInstancedPlacement(preparedPlacement.ForceInstancingOnly);
            tileStats?.RecordInstancedPlacement(preparedPlacement.PriorityBucket, preparedPlacement.ForceInstancingOnly);
            if (buildState.BatchState != null)
            {
                buildState.BatchState.VegetationInstancedPlacementCount++;
                if (preparedPlacement.ForceInstancingOnly)
                {
                    buildState.BatchState.VegetationForcedInstancingOnlyCount++;
                }
            }
            return false;
        }

        if (vegetationLoadMode == VegetationLoadMode.InstancesOnly || requiresInstancingOnly)
        {
            return false;
        }

        buildState.VegetationContainer ??= CreateVegetationContainer(buildState.Terrain.transform);
        bool instantiated = InstantiatePreparedLegacyPlacement(
            buildState,
            tileStats,
            workItem,
            preparedPlacement,
            prefab,
            isTreeObject,
            buildState.VegetationContainer);
        if (instantiated)
        {
            workItem.RecordLegacyPlacement();
            tileStats?.RecordLegacyPlacement(preparedPlacement.PriorityBucket);
            if (buildState.BatchState != null)
            {
                buildState.BatchState.VegetationLegacyPlacementCount++;
            }
        }

        return instantiated;
    }

    private void FinalizeVegetationWorkItem(VegetationWorkItem workItem, Stopwatch totalStopwatch)
    {
        VegetationTileStreamingStats? tileStats = null;
        if (workItem.BuildState.BatchState != null)
        {
            tileStats = GetOrCreateVegetationTileStats(
                workItem.BuildState.BatchState,
                GetTileCoordinate(workItem.BuildState.Request),
                workItem.IsCenterTile);
        }

        int previousFinalizedPlacementCount = workItem.BuildState.LastFinalizedPlacementCount;
        bool shouldFinalizeRenderer =
            workItem.IsFinalChunkForTile ||
            workItem.BuildState.Placements.Count <= 512;
        double rendererFinalizeMilliseconds = shouldFinalizeRenderer
            ? FinalizeHybridVegetationBuild(workItem.BuildState)
            : 0d;
        RecordPlacementPhaseTiming(
            workItem.BuildState.BatchState,
            tileStats,
            rendererFinalizeMilliseconds,
            VegetationPlacementPhase.RendererFinalize,
            workItem);
        if (rendererFinalizeMilliseconds > 0d)
        {
            tileStats?.RecordVisible(totalStopwatch.Elapsed.TotalMilliseconds);
        }
        else if (workItem.InstancedPlacementCount > 0)
        {
            tileStats?.RecordDeferredRendererFinalize();
            if (workItem.BuildState.BatchState != null)
            {
                workItem.BuildState.BatchState.VegetationDeferredRendererFinalizeCount++;
            }
        }

        if (rendererFinalizeMilliseconds > 0d)
        {
            tileStats?.RecordRendererFinalize();
            if (workItem.BuildState.BatchState != null)
            {
                workItem.BuildState.BatchState.VegetationRendererFinalizeCount++;
            }
        }

        if (workItem.BuildState.BatchState != null)
        {
            Vector2Int tileCoordinate = GetTileCoordinate(workItem.BuildState.Request);
            VegetationTileStreamingStats completedTileStats = tileStats ?? GetOrCreateVegetationTileStats(
                workItem.BuildState.BatchState,
                tileCoordinate,
                workItem.IsCenterTile);
            int completedWorkItemCount = completedTileStats.RecordCompletedWorkItem(totalStopwatch.Elapsed.TotalMilliseconds);
            int visibleInstancedPlacementCount = rendererFinalizeMilliseconds > 0d
                ? Math.Max(0, workItem.BuildState.LastFinalizedPlacementCount - previousFinalizedPlacementCount)
                : 0;
            TileLoaderInstancedVegetationRenderer? renderer = workItem.BuildState.VegetationContainer != null
                ? workItem.BuildState.VegetationContainer.GetComponent<TileLoaderInstancedVegetationRenderer>()
                : null;
            TryLogVegetationWorkItemCompletion(
                workItem,
                completedTileStats,
                completedWorkItemCount,
                visibleInstancedPlacementCount,
                !shouldFinalizeRenderer && workItem.InstancedPlacementCount > 0,
                renderer == null || renderer.IsPrototypeRuntimeReady,
                renderer?.LastPrototypeInitializationMilliseconds ?? 0d);
            if (completedWorkItemCount >= completedTileStats.QueuedWorkItemCount)
            {
                TryLogSettledVegetationTile(tileCoordinate, completedTileStats);
            }
        }

        if (!workItem.MarksCenterTileReady ||
            workItem.BuildState.BatchState == null ||
            workItem.BuildState.BatchState.VegetationCenterReadyMilliseconds > 0d)
        {
            return;
        }

        workItem.BuildState.BatchState.VegetationCenterReadyMilliseconds = totalStopwatch.Elapsed.TotalMilliseconds;
        if (logGenerationPhaseTimings)
        {
            Debug.Log(
                $"TileLoader center tile vegetation ready in {workItem.BuildState.BatchState.VegetationCenterReadyMilliseconds.ToString("F1", CultureInfo.InvariantCulture)} ms.",
                this);
        }
    }

    private VegetationTileStreamingStats GetOrCreateVegetationTileStats(
        GeneratedTerrainBatchState batchState,
        Vector2Int tileCoordinate,
        bool isCenterTile)
    {
        if (batchState.VegetationTileStats.TryGetValue(tileCoordinate, out VegetationTileStreamingStats? existing))
        {
            return existing;
        }

        var created = new VegetationTileStreamingStats(tileCoordinate, isCenterTile);
        batchState.VegetationTileStats[tileCoordinate] = created;
        return created;
    }

    private static string GetPlacementCategoryName(TileObjectPlacement placement)
    {
        if (!string.IsNullOrWhiteSpace(placement.Definition.VegetationCategory))
        {
            return placement.Definition.VegetationCategory!;
        }

        return placement.Definition.Category.ToString().ToLowerInvariant();
    }

    private static bool ShouldKeepPlacementForTile(
        TileObjectPlacement placement,
        bool isCenterTile,
        ulong stableHash)
    {
        if (isCenterTile)
        {
            return true;
        }

        return placement.Definition.OuterTilePolicy switch
        {
            TileObjectOuterTilePolicy.Skip => false,
            TileObjectOuterTilePolicy.Reduced => StableHashToUnitInterval(stableHash) <= placement.Definition.OuterTileDensityScale,
            _ => true,
        };
    }

    private static int ResolveVegetationWorkItemChunkSize(VegetationPriorityBucket bucket)
    {
        return bucket switch
        {
            VegetationPriorityBucket.CenterCanopyAndLarge => 160,
            VegetationPriorityBucket.OuterCanopyAndLarge => 224,
            VegetationPriorityBucket.CenterClutterAndGround => 192,
            VegetationPriorityBucket.OuterClutter => 192,
            VegetationPriorityBucket.OuterGroundAndDebris => 192,
            _ => 192,
        };
    }

    private bool TryBuildPreparedPlacementGeometry(
        GeneratedTerrainBatchState batchState,
        VegetationTileStreamingStats tileStats,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        TileObjectPlacement placement,
        bool isTreePlacement,
        out PreparedPlacementGeometry geometry)
    {
        geometry = default;
        double[,] heightmap = request.Layers.Heightmap;
        Vector3 localPosition = GetTerrainLocalPointFromHeightmapApprox(
            heightmap,
            placement.X,
            placement.Y,
            batchState.NormalizationMinHeight,
            batchState.NormalizationMaxHeight,
            isTreePlacement ? treeObjectVerticalOffset : surfaceObjectVerticalOffset);
        RecordVegetationSampleCounts(batchState, tileStats, 1, 0);

        Vector3 worldPosition = terrain.transform.TransformPoint(localPosition);
        float distanceToTargetSq = 0f;
        VegetationDensityZone densityZone = VegetationDensityZone.High;
        Vector3? targetWorldPosition = batchState.VegetationStreamingTargetWorldPosition;
        if (Application.isPlaying && targetWorldPosition.HasValue)
        {
            distanceToTargetSq = (worldPosition - targetWorldPosition.Value).sqrMagnitude;
            float? loadDistanceMeters = placement.Definition.LoadDistanceMeters;
            if (loadDistanceMeters.HasValue && loadDistanceMeters.Value > 0f)
            {
                float maxDistanceSq = loadDistanceMeters.Value * loadDistanceMeters.Value;
                if (distanceToTargetSq > maxDistanceSq)
                {
                    return false;
                }
            }

            densityZone = ResolveVegetationDensityZone(distanceToTargetSq);
        }

        bool useExactTerrainConformOnLoad =
            !isTreePlacement &&
            targetWorldPosition.HasValue &&
            ShouldUseExactTerrainConformOnLoad(distanceToTargetSq);
        bool useExactTerrainConformOnPromotion =
            !isTreePlacement &&
            SupportsHybridPromotion(placement);
        geometry = new PreparedPlacementGeometry(
            localPosition,
            Vector3.up,
            worldPosition,
            distanceToTargetSq,
            densityZone,
            useExactTerrainConformOnLoad,
            useExactTerrainConformOnPromotion);
        return true;
    }

    private void PopulatePreparedPlacementGeometryNormals(
        GeneratedTerrainBatchState batchState,
        VegetationTileStreamingStats tileStats,
        GeneratedTerrainRequest request,
        List<PreparedVegetationPlacement> preparedPlacements)
    {
        if (preparedPlacements.Count == 0)
        {
            return;
        }

        double[,] heightmap = request.Layers.Heightmap;
        for (int placementIndex = 0; placementIndex < preparedPlacements.Count; placementIndex++)
        {
            PreparedVegetationPlacement preparedPlacement = preparedPlacements[placementIndex];
            if (string.Equals(
                    preparedPlacement.Placement.Definition.VegetationCategory,
                    "tree",
                    StringComparison.OrdinalIgnoreCase) ||
                preparedPlacement.Geometry.UseExactTerrainConformOnLoad)
            {
                continue;
            }

            Vector3 localNormal = GetTerrainLocalNormalFromHeightmapApprox(
                heightmap,
                preparedPlacement.Placement.X,
                preparedPlacement.Placement.Y,
                batchState.NormalizationMinHeight,
                batchState.NormalizationMaxHeight);
            RecordVegetationSampleCounts(batchState, tileStats, 4, 0);
            preparedPlacements[placementIndex] = preparedPlacement.WithGeometry(
                preparedPlacement.Geometry.WithLocalNormal(localNormal));
        }
    }

    private bool ShouldUseExactTerrainConformOnLoad(float distanceToTargetSq)
    {
        if (!Application.isPlaying)
        {
            return true;
        }

        if (highDetailTerrainConformRadiusMeters <= 0f)
        {
            return false;
        }

        float maxDistanceSq = highDetailTerrainConformRadiusMeters * highDetailTerrainConformRadiusMeters;
        return distanceToTargetSq <= maxDistanceSq;
    }

    private VegetationDensityZone ResolveVegetationDensityZone(float distanceToTargetSq)
    {
        if (!Application.isPlaying)
        {
            return VegetationDensityZone.High;
        }

        float clampedHighDetailRadius = Mathf.Max(0f, highDetailPlacementRadiusMeters);
        float clampedMidDetailRadius = Mathf.Max(clampedHighDetailRadius, midDetailPlacementRadiusMeters);
        float highDetailDistanceSq = clampedHighDetailRadius * clampedHighDetailRadius;
        if (distanceToTargetSq <= highDetailDistanceSq)
        {
            return VegetationDensityZone.High;
        }

        float midDetailDistanceSq = clampedMidDetailRadius * clampedMidDetailRadius;
        return distanceToTargetSq <= midDetailDistanceSq
            ? VegetationDensityZone.Mid
            : VegetationDensityZone.Outer;
    }

    private static bool ShouldKeepPlacementForDensityZone(
        TileObjectPlacement placement,
        VegetationDensityZone densityZone,
        ulong stableHash)
    {
        float densityScale = ResolveDensityScaleForZone(placement.Definition.StreamingTier, densityZone);
        if (densityScale >= 1f)
        {
            return true;
        }

        if (densityScale <= 0f)
        {
            return false;
        }

        return StableHashToUnitInterval(stableHash) <= densityScale;
    }

    private static float ResolveDensityScaleForZone(
        TileObjectStreamingTier streamingTier,
        VegetationDensityZone densityZone)
    {
        if (densityZone == VegetationDensityZone.High)
        {
            return 1f;
        }

        return streamingTier switch
        {
            TileObjectStreamingTier.Canopy => 0.6f,
            TileObjectStreamingTier.Large => 0.6f,
            TileObjectStreamingTier.Clutter => densityZone == VegetationDensityZone.Mid ? 0.35f : 0.1f,
            TileObjectStreamingTier.Ground => densityZone == VegetationDensityZone.Mid ? 0.15f : 0f,
            _ => 1f,
        };
    }

    private static void RecordVegetationSampleCounts(
        GeneratedTerrainBatchState? batchState,
        VegetationTileStreamingStats? tileStats,
        int heightmapSamples,
        int raycastSamples)
    {
        if (heightmapSamples > 0)
        {
            tileStats?.RecordHeightmapSamples(heightmapSamples);
            if (batchState != null)
            {
                batchState.VegetationHeightmapSampleCount += heightmapSamples;
            }
        }

        if (raycastSamples > 0)
        {
            tileStats?.RecordRaycastSamples(raycastSamples);
            if (batchState != null)
            {
                batchState.VegetationRaycastSampleCount += raycastSamples;
            }
        }
    }

    private void RecordPlacementPhaseTiming(
        GeneratedTerrainBatchState? batchState,
        VegetationTileStreamingStats? tileStats,
        double elapsedMilliseconds,
        VegetationPlacementPhase placementPhase,
        VegetationWorkItem? workItem = null)
    {
        if (elapsedMilliseconds <= 0d)
        {
            return;
        }

        tileStats?.RecordPlacementCpu(elapsedMilliseconds);
        tileStats?.RecordPlacementPhase(elapsedMilliseconds, placementPhase);
        workItem?.RecordPlacementPhase(elapsedMilliseconds, placementPhase);
        if (batchState == null)
        {
            return;
        }

        batchState.VegetationPlacementCpuMilliseconds += elapsedMilliseconds;
        switch (placementPhase)
        {
            case VegetationPlacementPhase.PrefabResolve:
                batchState.VegetationPrefabResolveMilliseconds += elapsedMilliseconds;
                break;
            case VegetationPlacementPhase.PrototypeResolve:
                batchState.VegetationPrototypeResolveMilliseconds += elapsedMilliseconds;
                break;
            case VegetationPlacementPhase.PositionBuild:
                batchState.VegetationPositionBuildMilliseconds += elapsedMilliseconds;
                break;
            case VegetationPlacementPhase.NormalBuild:
                batchState.VegetationNormalBuildMilliseconds += elapsedMilliseconds;
                break;
            case VegetationPlacementPhase.RendererFinalize:
                batchState.VegetationRendererFinalizeMilliseconds += elapsedMilliseconds;
                break;
        }
    }

    private VegetationPriorityBucket DeterminePriorityBucket(bool isCenterTile, TileObjectStreamingTier streamingTier)
    {
        if (streamingTier == TileObjectStreamingTier.Ground)
        {
            return isCenterTile
                ? VegetationPriorityBucket.CenterClutterAndGround
                : VegetationPriorityBucket.OuterGroundAndDebris;
        }

        if (streamingTier == TileObjectStreamingTier.Clutter)
        {
            if (!centerTileOnlyNonTreeBudgetFirst)
            {
                return isCenterTile
                    ? VegetationPriorityBucket.CenterClutterAndGround
                    : VegetationPriorityBucket.OuterClutter;
            }

            return isCenterTile
                ? VegetationPriorityBucket.CenterClutterAndGround
                : VegetationPriorityBucket.OuterClutter;
        }

        return isCenterTile
            ? VegetationPriorityBucket.CenterCanopyAndLarge
            : VegetationPriorityBucket.OuterCanopyAndLarge;
    }

    private static bool ShouldForceInstancingOnlyForPreparedPlacement(bool isCenterTile, TileObjectStreamingTier streamingTier)
    {
        return !isCenterTile &&
               (streamingTier == TileObjectStreamingTier.Clutter || streamingTier == TileObjectStreamingTier.Ground);
    }

    private Vector3? ResolveVegetationStreamingTargetWorldPosition()
    {
        if (!Application.isPlaying)
        {
            return null;
        }

        Transform? target = ResolveVegetationStreamingTarget();
        return target != null ? target.position : null;
    }

    private static Transform? ResolveVegetationStreamingTarget()
    {
        if (TryFindSceneTransformWithTag("Player", out Transform? taggedPlayerTransform))
        {
            return taggedPlayerTransform;
        }

        return Camera.main != null ? Camera.main.transform : null;
    }

    private static ulong ComputeStablePlacementHash(GeneratedTerrainRequest request, TileObjectPlacement placement)
    {
        ulong hash = 1469598103934665603UL;
        AppendHash(ref hash, unchecked((ulong)request.UnityTileX));
        AppendHash(ref hash, unchecked((ulong)request.UnityTileY));
        AppendHash(ref hash, unchecked((ulong)placement.Definition.NumericId));
        AppendHash(ref hash, unchecked((ulong)BitConverter.DoubleToInt64Bits(Math.Round(placement.X, 4))));
        AppendHash(ref hash, unchecked((ulong)BitConverter.DoubleToInt64Bits(Math.Round(placement.Y, 4))));

        string? rawPath = placement.PrefabPath ?? placement.Definition.PrefabPath;
        if (!string.IsNullOrWhiteSpace(rawPath))
        {
            for (int i = 0; i < rawPath.Length; i++)
            {
                AppendHash(ref hash, rawPath[i]);
            }
        }

        return hash;
    }

    private static void AppendHash(ref ulong hash, ulong value)
    {
        hash ^= value + 0x9e3779b97f4a7c15UL + (hash << 6) + (hash >> 2);
    }

    private static double StableHashToUnitInterval(ulong stableHash)
    {
        return (stableHash & 0x00FFFFFFUL) / 16777215.0;
    }

    private void PopulatePlacedObjectsLegacy(
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
            InstantiateLegacyPlacement(
                terrain,
                request,
                placement,
                prefab,
                isTreeObject,
                vegetationContainer,
                normalizationMinHeight,
                normalizationMaxHeight);
        }
    }

    private void PopulatePlacedObjectsHybrid(
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        HybridVegetationBuildState? buildState = BeginHybridVegetationBuild(
            null,
            terrain,
            request,
            normalizationMinHeight,
            normalizationMaxHeight);
        if (buildState == null)
        {
            return;
        }

        while (ProcessNextHybridVegetationPlacement(buildState))
        {
        }

        FinalizeHybridVegetationBuild(buildState);
    }

    private HybridVegetationBuildState? BeginHybridVegetationBuild(
        GeneratedTerrainBatchState? batchState,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        if (terrain == null || request.Layers.PlacedObjects == null || request.Layers.PlacedObjects.Count == 0)
        {
            return null;
        }

        return new HybridVegetationBuildState(
            batchState,
            terrain,
            request,
            normalizationMinHeight,
            normalizationMaxHeight);
    }

    private HybridVegetationBuildState? BeginHybridVegetationBuild(
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        return BeginHybridVegetationBuild(
            null,
            terrain,
            request,
            normalizationMinHeight,
            normalizationMaxHeight);
    }

    private bool ProcessNextHybridVegetationPlacement(HybridVegetationBuildState buildState)
    {
        IReadOnlyList<TileObjectPlacement> placedObjects = buildState.Request.Layers.PlacedObjects;
        if (buildState.NextPlacementIndex >= placedObjects.Count)
        {
            return false;
        }

        TileObjectPlacement placement = placedObjects[buildState.NextPlacementIndex];
        buildState.NextPlacementIndex++;
        GameObject? prefab = LoadPrefabForPlacement(placement);
        if (prefab == null)
        {
            return buildState.NextPlacementIndex < placedObjects.Count;
        }

        bool isTreeObject = IsTreePlacement(placement, prefab);
        if (isTreeObject && !placeTreeObjects)
        {
            return buildState.NextPlacementIndex < placedObjects.Count;
        }

        if (!isTreeObject && !placeSurfaceObjects)
        {
            return buildState.NextPlacementIndex < placedObjects.Count;
        }

        bool requiresInstancingOnly = RequiresInstancingOnly(placement);
        TileLoaderInstancedVegetationPrototype? prototype = GetOrCreateVegetationPrototype(placement, prefab, isTreeObject);
        if (prototype != null &&
            TryBuildInstancedPlacement(
                buildState.Terrain,
                buildState.Request,
                placement,
                prototype,
                buildState.NormalizationMinHeight,
                buildState.NormalizationMaxHeight,
                out TileLoaderInstancedVegetationPlacement instancedPlacement))
        {
            buildState.VegetationContainer ??= CreateVegetationContainer(buildState.Terrain.transform);
            if (!buildState.PrototypeIndices.TryGetValue(prototype.Key, out int prototypeIndex))
            {
                prototypeIndex = buildState.Prototypes.Count;
                buildState.PrototypeIndices[prototype.Key] = prototypeIndex;
                buildState.Prototypes.Add(prototype);
            }

            buildState.Placements.Add(new TileLoaderInstancedVegetationPlacement(
                prototypeIndex,
                instancedPlacement.LocalPosition,
                instancedPlacement.LocalRotation,
                instancedPlacement.LocalScale,
                instancedPlacement.ConformToTerrainOnPromotion,
                instancedPlacement.SurfaceSampleLocalX,
                instancedPlacement.SurfaceSampleLocalZ,
                instancedPlacement.SurfaceVerticalOffset,
                instancedPlacement.SurfaceNormalOffset));
            return buildState.NextPlacementIndex < placedObjects.Count;
        }

        if (vegetationLoadMode == VegetationLoadMode.InstancesOnly || requiresInstancingOnly)
        {
            return buildState.NextPlacementIndex < placedObjects.Count;
        }

        buildState.VegetationContainer ??= CreateVegetationContainer(buildState.Terrain.transform);
        InstantiateLegacyPlacement(
            buildState.Terrain,
            buildState.Request,
            placement,
            prefab,
            isTreeObject,
            buildState.VegetationContainer,
            buildState.NormalizationMinHeight,
            buildState.NormalizationMaxHeight);
        return buildState.NextPlacementIndex < placedObjects.Count;
    }

    private double FinalizeHybridVegetationBuild(HybridVegetationBuildState buildState)
    {
        if (buildState.VegetationContainer == null || buildState.Placements.Count == 0)
        {
            return 0d;
        }

        if (buildState.Placements.Count == buildState.LastFinalizedPlacementCount)
        {
            return 0d;
        }

        TileLoaderInstancedVegetationRenderer renderer = buildState.VegetationContainer.GetComponent<TileLoaderInstancedVegetationRenderer>();
        if (renderer == null)
        {
            renderer = buildState.VegetationContainer.gameObject.AddComponent<TileLoaderInstancedVegetationRenderer>();
        }

        renderer.Initialize(
            buildState.Prototypes,
            buildState.Placements,
            vegetationLoadMode == VegetationLoadMode.HybridInteractive,
            vegetationInteractionRadiusMeters,
            vegetationInteractionHysteresisMeters,
            prototypeInitBudgetMsPerFrame);
        buildState.LastFinalizedPlacementCount = buildState.Placements.Count;
        if (buildState.BatchState != null)
        {
            buildState.BatchState.VegetationRendererInitializationCount++;
            buildState.BatchState.VegetationPrototypeInitializationMilliseconds += renderer.LastPrototypeInitializationMilliseconds;
        }

        return renderer.LastInitializationCpuMilliseconds;
    }

    private bool TryBuildInstancedPlacement(
        HybridVegetationBuildState buildState,
        VegetationTileStreamingStats? tileStats,
        VegetationWorkItem? workItem,
        PreparedVegetationPlacement preparedPlacement,
        TileLoaderInstancedVegetationPrototype prototype,
        out TileLoaderInstancedVegetationPlacement instancedPlacement)
    {
        instancedPlacement = default;
        if (prototype == null)
        {
            return false;
        }

        CreatePreparedPlacementTransform(
            buildState,
            tileStats,
            workItem,
            preparedPlacement,
            prototype.IsTree,
            out Vector3 localPosition,
            out Quaternion localRotation,
            out bool usedExactTerrainConform);
        if (workItem != null)
        {
            workItem.RecordPlacementTransformMode(usedExactTerrainConform);
        }
        tileStats?.RecordPlacementTransformMode(usedExactTerrainConform);
        if (buildState.BatchState != null)
        {
            if (usedExactTerrainConform)
            {
                buildState.BatchState.VegetationExactTerrainConformPlacementCount++;
            }
            else
            {
                buildState.BatchState.VegetationApproximatePlacementCount++;
            }
        }
        instancedPlacement = new TileLoaderInstancedVegetationPlacement(
            0,
            localPosition,
            localRotation,
            Vector3.one,
            !prototype.IsTree && preparedPlacement.Geometry.UseExactTerrainConformOnPromotion,
            preparedPlacement.Geometry.LocalPosition.x,
            preparedPlacement.Geometry.LocalPosition.z,
            surfaceObjectVerticalOffset,
            GetSurfaceObjectOffset());
        return true;
    }

    private bool InstantiatePreparedLegacyPlacement(
        HybridVegetationBuildState buildState,
        VegetationTileStreamingStats? tileStats,
        VegetationWorkItem? workItem,
        PreparedVegetationPlacement preparedPlacement,
        GameObject prefab,
        bool isTreeObject,
        Transform vegetationContainer)
    {
        GameObject? instance = InstantiatePlacementPrefab(prefab);
        if (instance == null)
        {
            return false;
        }

        CreatePreparedPlacementTransform(
            buildState,
            tileStats,
            workItem,
            preparedPlacement,
            isTreeObject,
            out Vector3 localPosition,
            out Quaternion localRotation,
            out bool usedExactTerrainConform);
        if (workItem != null)
        {
            workItem.RecordPlacementTransformMode(usedExactTerrainConform);
        }
        tileStats?.RecordPlacementTransformMode(usedExactTerrainConform);
        if (buildState.BatchState != null)
        {
            if (usedExactTerrainConform)
            {
                buildState.BatchState.VegetationExactTerrainConformPlacementCount++;
            }
            else
            {
                buildState.BatchState.VegetationApproximatePlacementCount++;
            }
        }
        instance.name = prefab.name;
        instance.transform.SetParent(vegetationContainer, false);
        instance.transform.localScale = Vector3.one;
        instance.transform.localPosition = localPosition;
        instance.transform.localRotation = localRotation;
        if (isTreeObject)
        {
            RegisterGeneratedConifer(instance);
            return true;
        }

        RegisterGeneratedSurfaceObject(instance);
        return true;
    }

    private void CreatePreparedPlacementTransform(
        HybridVegetationBuildState buildState,
        VegetationTileStreamingStats? tileStats,
        VegetationWorkItem? workItem,
        PreparedVegetationPlacement preparedPlacement,
        bool isTreeObject,
        out Vector3 localPosition,
        out Quaternion localRotation,
        out bool usedExactTerrainConform)
    {
        localPosition = preparedPlacement.Geometry.LocalPosition;
        Vector3 localNormal = preparedPlacement.Geometry.LocalNormal;
        usedExactTerrainConform = false;

        var positionStopwatch = Stopwatch.StartNew();
        if (!isTreeObject &&
            preparedPlacement.Geometry.UseExactTerrainConformOnLoad &&
            TrySampleGeneratedTerrainSurface(
                buildState.Terrain,
                preparedPlacement.Geometry.LocalPosition.x,
                preparedPlacement.Geometry.LocalPosition.z,
                surfaceObjectVerticalOffset,
                out Vector3 exactLocalSurfacePoint,
                out Vector3 exactLocalSurfaceNormal))
        {
            localPosition = exactLocalSurfacePoint;
            localNormal = exactLocalSurfaceNormal;
            usedExactTerrainConform = true;
            RecordVegetationSampleCounts(buildState.BatchState, tileStats, 0, 1);
        }

        positionStopwatch.Stop();
        RecordPlacementPhaseTiming(
            buildState.BatchState,
            tileStats,
            positionStopwatch.Elapsed.TotalMilliseconds,
            VegetationPlacementPhase.PositionBuild,
            workItem);
        if (isTreeObject)
        {
            localRotation = Quaternion.identity;
            return;
        }

        var normalStopwatch = Stopwatch.StartNew();
        localRotation = Quaternion.FromToRotation(Vector3.up, localNormal);
        localPosition += localNormal * GetSurfaceObjectOffset();
        normalStopwatch.Stop();
        RecordPlacementPhaseTiming(
            buildState.BatchState,
            tileStats,
            normalStopwatch.Elapsed.TotalMilliseconds,
            VegetationPlacementPhase.NormalBuild,
            workItem);
    }

    private void InstantiateLegacyPlacement(
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        TileObjectPlacement placement,
        GameObject prefab,
        bool isTreeObject,
        Transform vegetationContainer,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        GameObject? instance = InstantiatePlacementPrefab(prefab);
        if (instance == null)
        {
            return;
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
            return;
        }

        PlaceSurfaceObjectInstance(
            instance.transform,
            request.Layers.Heightmap,
            placement,
            normalizationMinHeight,
            normalizationMaxHeight);
        RegisterGeneratedSurfaceObject(instance);
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

    private TileLoaderInstancedVegetationPrototype? GetOrCreateVegetationPrototype(
        TileObjectPlacement placement,
        GameObject prefab,
        bool isTreeObject)
    {
        return GetOrCreateVegetationPrototype(
            null,
            placement,
            prefab,
            isTreeObject,
            SupportsHybridPromotion(placement));
    }

    private TileLoaderInstancedVegetationPrototype? GetOrCreateVegetationPrototype(
        GeneratedTerrainBatchState? batchState,
        TileObjectPlacement placement,
        GameObject prefab,
        bool isTreeObject,
        bool supportsPromotion)
    {
        string? rawPath = placement.PrefabPath ?? placement.Definition.PrefabPath;
        if (string.IsNullOrWhiteSpace(rawPath))
        {
            return null;
        }

        float maxRenderDistanceMeters = GetInstancedRenderDistanceMeters(placement);
        string cacheKey = (isTreeObject ? "tree:" : "surface:") +
                          (supportsPromotion ? "hybrid:" : "instanced:") +
                          maxRenderDistanceMeters.ToString("F3", CultureInfo.InvariantCulture) + ":" +
                          rawPath.Replace('\\', '/').Trim();
        if (vegetationPrototypeCache.TryGetValue(cacheKey, out TileLoaderInstancedVegetationPrototype? cachedPrototype))
        {
            if (batchState != null)
            {
                batchState.VegetationPrototypeCacheHitCount++;
            }

            return cachedPrototype;
        }

        if (batchState != null)
        {
            batchState.VegetationPrototypeCacheMissCount++;
        }

        if (prefab.GetComponentsInChildren<SkinnedMeshRenderer>(true).Length > 0 ||
            prefab.GetComponentsInChildren<Animator>(true).Length > 0 ||
            prefab.GetComponentsInChildren<ParticleSystem>(true).Length > 0 ||
            prefab.GetComponentsInChildren<TerrainConformBlanket>(true).Length > 0)
        {
            vegetationPrototypeCache[cacheKey] = null;
            return null;
        }

        Renderer[] candidateRenderers = ResolveInstancedPrototypeRenderers(prefab, isTreeObject);
        var renderSources = new List<TileLoaderInstancedVegetationRenderSource>();
        Matrix4x4 rootWorldToLocal = prefab.transform.worldToLocalMatrix;
        for (int rendererIndex = 0; rendererIndex < candidateRenderers.Length; rendererIndex++)
        {
            Renderer renderer = candidateRenderers[rendererIndex];
            if (renderer == null || !renderer.TryGetComponent(out MeshFilter meshFilter))
            {
                continue;
            }

            Mesh mesh = meshFilter.sharedMesh;
            if (mesh == null)
            {
                continue;
            }

            Material[] materials = renderer.sharedMaterials;
            int subMeshCount = Math.Min(mesh.subMeshCount, materials.Length);
            Matrix4x4 localMatrix = rootWorldToLocal * renderer.transform.localToWorldMatrix;
            for (int subMeshIndex = 0; subMeshIndex < subMeshCount; subMeshIndex++)
            {
                Material material = materials[subMeshIndex];
                if (material == null)
                {
                    continue;
                }

                renderSources.Add(new TileLoaderInstancedVegetationRenderSource(
                    mesh,
                    subMeshIndex,
                    material,
                    localMatrix,
                    renderer.shadowCastingMode,
                    renderer.receiveShadows,
                    placement.Definition.Layer));
            }
        }

        TileLoaderInstancedVegetationPrototype? prototype = renderSources.Count == 0
            ? null
            : new TileLoaderInstancedVegetationPrototype(
                cacheKey,
                prefab,
                isTreeObject,
                supportsPromotion,
                maxRenderDistanceMeters,
                renderSources);
        vegetationPrototypeCache[cacheKey] = prototype;
        return prototype;
    }

    private static bool RequiresInstancingOnly(TileObjectPlacement placement)
    {
        return placement.Definition.InstancingMode == TileObjectInstancingMode.AlwaysGpuInstanced;
    }

    private static bool SupportsHybridPromotion(TileObjectPlacement placement)
    {
        return placement.Definition.InstancingMode != TileObjectInstancingMode.AlwaysGpuInstanced;
    }

    private static float GetInstancedRenderDistanceMeters(TileObjectPlacement placement)
    {
        return placement.Definition.LoadDistanceMeters ?? 0f;
    }

    private static Renderer[] ResolveInstancedPrototypeRenderers(GameObject prefab, bool isTreeObject)
    {
        if (prefab == null)
        {
            return Array.Empty<Renderer>();
        }

        LODGroup lodGroup = prefab.GetComponentInChildren<LODGroup>(true);
        if (isTreeObject && lodGroup != null && lodGroup.enabled)
        {
            LOD[] lods = lodGroup.GetLODs();
            for (int lodIndex = 0; lodIndex < lods.Length; lodIndex++)
            {
                Renderer[] lodRenderers = lods[lodIndex].renderers;
                Renderer[] validLodRenderers = FilterUsableInstancedRenderers(lodRenderers);
                if (validLodRenderers.Length > 0)
                {
                    return validLodRenderers;
                }
            }
        }

        return FilterUsableInstancedRenderers(prefab.GetComponentsInChildren<MeshRenderer>(true));
    }

    private static Renderer[] FilterUsableInstancedRenderers(Renderer[]? renderers)
    {
        if (renderers == null || renderers.Length == 0)
        {
            return Array.Empty<Renderer>();
        }

        var usableRenderers = new List<Renderer>(renderers.Length);
        for (int i = 0; i < renderers.Length; i++)
        {
            Renderer renderer = renderers[i];
            if (renderer == null ||
                !renderer.enabled ||
                renderer.gameObject == null ||
                !renderer.gameObject.activeSelf)
            {
                continue;
            }

            usableRenderers.Add(renderer);
        }

        return usableRenderers.Count == 0
            ? Array.Empty<Renderer>()
            : usableRenderers.ToArray();
    }

    private bool TryBuildInstancedPlacement(
        GStylizedTerrain? terrain,
        GeneratedTerrainRequest request,
        TileObjectPlacement placement,
        TileLoaderInstancedVegetationPrototype prototype,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        out TileLoaderInstancedVegetationPlacement instancedPlacement)
    {
        instancedPlacement = default;
        if (prototype == null)
        {
            return false;
        }

        Vector3 localPosition;
        Quaternion localRotation;
        if (prototype.IsTree)
        {
            localPosition = GetTerrainLocalPoint(
                terrain,
                request.Layers.Heightmap,
                placement.X,
                placement.Y,
                normalizationMinHeight,
                normalizationMaxHeight,
                treeObjectVerticalOffset);
            localRotation = Quaternion.identity;
        }
        else
        {
            Vector3 localSurfacePoint = GetTerrainLocalPoint(
                terrain,
                request.Layers.Heightmap,
                placement.X,
                placement.Y,
                normalizationMinHeight,
                normalizationMaxHeight,
                surfaceObjectVerticalOffset);
            Vector3 localSurfaceNormal = GetTerrainLocalNormal(
                terrain,
                request.Layers.Heightmap,
                placement.X,
                placement.Y,
                normalizationMinHeight,
                normalizationMaxHeight);
            localRotation = Quaternion.FromToRotation(Vector3.up, localSurfaceNormal);
            localPosition = localSurfacePoint + localSurfaceNormal * GetSurfaceObjectOffset();
        }

        instancedPlacement = new TileLoaderInstancedVegetationPlacement(
            0,
            localPosition,
            localRotation,
            Vector3.one,
            !prototype.IsTree,
            localPosition.x,
            localPosition.z,
            surfaceObjectVerticalOffset,
            GetSurfaceObjectOffset());
        return true;
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

    private GameObject? LoadPrefabForPlacement(TileObjectPlacement placement, GeneratedTerrainBatchState? batchState = null)
    {
        string? rawPath = placement.PrefabPath ?? placement.Definition.PrefabPath;
        if (string.IsNullOrWhiteSpace(rawPath))
        {
            return null;
        }

        string cacheKey = rawPath.Replace('\\', '/').Trim();
        if (prefabCache.TryGetValue(cacheKey, out GameObject? cachedPrefab))
        {
            return cachedPrefab;
        }

#if UNITY_EDITOR
        string? assetPath = NormalizeAssetPath(rawPath);
        if (!string.IsNullOrEmpty(assetPath))
        {
            GameObject asset = AssetDatabase.LoadAssetAtPath<GameObject>(assetPath);
            if (asset != null)
            {
                prefabCache[cacheKey] = asset;
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
                prefabCache[cacheKey] = resource;
                return resource;
            }
        }

        prefabCache[cacheKey] = null;
        if (batchState != null)
        {
            IncrementCount(batchState.MissingPrefabCountsByPath, rawPath);
            batchState.VegetationMissingPrefabCount++;
        }

        IncrementCount(missingPrefabSkipCounts, rawPath);
        if (loggedMissingPrefabPaths.Add(rawPath))
        {
            Debug.LogWarning(
                $"TileLoader could not resolve prefab path '{rawPath}' for placement '{placement.Definition.Id}'. Further misses will be suppressed and counted in the batch summary.",
                this);
        }

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

    private Vector3 GetTerrainLocalPointFromHeightmapApprox(
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

    private Vector3 GetTerrainLocalNormalFromHeightmapApprox(
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

        Vector3 pointLeft = GetTerrainLocalPointFromHeightmapApprox(
            heightmap,
            sampleX - 1d,
            sampleY,
            normalizationMinHeight,
            normalizationMaxHeight,
            0f);
        Vector3 pointRight = GetTerrainLocalPointFromHeightmapApprox(
            heightmap,
            sampleX + 1d,
            sampleY,
            normalizationMinHeight,
            normalizationMaxHeight,
            0f);
        Vector3 pointBack = GetTerrainLocalPointFromHeightmapApprox(
            heightmap,
            sampleX,
            sampleY - 1d,
            normalizationMinHeight,
            normalizationMaxHeight,
            0f);
        Vector3 pointForward = GetTerrainLocalPointFromHeightmapApprox(
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
        return TrySampleGeneratedTerrainSurface(
            terrain,
            localX,
            localZ,
            verticalOffset,
            out localPoint,
            out _);
    }

    private bool TrySampleGeneratedTerrainSurface(
        GStylizedTerrain? terrain,
        float localX,
        float localZ,
        float verticalOffset,
        out Vector3 localPoint,
        out Vector3 localNormal)
    {
        localPoint = default;
        localNormal = Vector3.up;
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
        localNormal = terrain.transform.InverseTransformDirection(terrainHit.normal).normalized;
        if (localNormal.sqrMagnitude <= 0.0001f)
        {
            localNormal = Vector3.up;
        }

        return true;
    }

    private bool TrySampleGeneratedTerrainLocalMinimumPoint3x3(
        GStylizedTerrain? terrain,
        float localX,
        float localZ,
        float sampleSpacingX,
        float sampleSpacingZ,
        out float minimumY)
    {
        minimumY = 0f;
        if (terrain == null || !terrain.isActiveAndEnabled || terrain.TerrainData == null)
        {
            return false;
        }

        if (!TrySampleGeneratedTerrainLocalPoint(
                terrain,
                Mathf.Clamp(localX, 0f, terrainWidth),
                Mathf.Clamp(localZ, 0f, terrainLength),
                0f,
                out Vector3 samplePoint))
        {
            return false;
        }

        minimumY = samplePoint.y;
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
        if (activeGeneratedTerrainRoot != null)
        {
            foreach (GStylizedTerrain terrain in activeGeneratedTerrainRoot.GetComponentsInChildren<GStylizedTerrain>(true))
            {
                if (terrain != null)
                {
                    yield return terrain;
                }
            }
            yield break;
        }

        foreach (GStylizedTerrain terrain in GetComponentsInChildren<GStylizedTerrain>(true))
        {
            if (terrain == null || !IsGeneratedTerrainName(terrain.name))
            {
                continue;
            }

            yield return terrain;
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
        vegetationInteractionRadiusMeters = Mathf.Max(0f, vegetationInteractionRadiusMeters);
        vegetationInteractionHysteresisMeters = Mathf.Max(0f, vegetationInteractionHysteresisMeters);
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

    private readonly struct GeneratedTerrainTileData
    {
        public GeneratedTerrainTileData(
            TileLayers layers,
            int unityTileX,
            int unityTileY,
            double localMinHeight,
            double localMaxHeight,
            double tileHilliness)
        {
            Layers = layers;
            UnityTileX = unityTileX;
            UnityTileY = unityTileY;
            LocalMinHeight = localMinHeight;
            LocalMaxHeight = localMaxHeight;
            TileHilliness = tileHilliness;
        }

        public TileLayers Layers { get; }
        public int UnityTileX { get; }
        public int UnityTileY { get; }
        public double LocalMinHeight { get; }
        public double LocalMaxHeight { get; }
        public double TileHilliness { get; }
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

    private sealed class HybridVegetationBuildState
    {
        public HybridVegetationBuildState(
            GeneratedTerrainBatchState? batchState,
            GStylizedTerrain terrain,
            GeneratedTerrainRequest request,
            double normalizationMinHeight,
            double normalizationMaxHeight)
        {
            BatchState = batchState;
            Terrain = terrain;
            Request = request;
            NormalizationMinHeight = normalizationMinHeight;
            NormalizationMaxHeight = normalizationMaxHeight;
            Prototypes = new List<TileLoaderInstancedVegetationPrototype>();
            Placements = new List<TileLoaderInstancedVegetationPlacement>();
            PrototypeIndices = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
        }

        public GeneratedTerrainBatchState? BatchState { get; }
        public GStylizedTerrain Terrain { get; }
        public GeneratedTerrainRequest Request { get; }
        public double NormalizationMinHeight { get; }
        public double NormalizationMaxHeight { get; }
        public Transform? VegetationContainer { get; set; }
        public List<TileLoaderInstancedVegetationPrototype> Prototypes { get; }
        public List<TileLoaderInstancedVegetationPlacement> Placements { get; }
        public Dictionary<string, int> PrototypeIndices { get; }
        public int NextPlacementIndex { get; set; }
        public int LastFinalizedPlacementCount { get; set; }
    }

    private sealed class VegetationWorkItem
    {
        public VegetationWorkItem(
            HybridVegetationBuildState buildState,
            VegetationPriorityBucket priorityBucket,
            IReadOnlyList<PreparedVegetationPlacement> placements,
            bool isCenterTile,
            int chunkIndexWithinBucket,
            int chunkCountWithinBucket)
        {
            BuildState = buildState;
            PriorityBucket = priorityBucket;
            Placements = placements;
            IsCenterTile = isCenterTile;
            ChunkIndexWithinBucket = chunkIndexWithinBucket;
            ChunkCountWithinBucket = Math.Max(1, chunkCountWithinBucket);
        }

        public HybridVegetationBuildState BuildState { get; }
        public VegetationPriorityBucket PriorityBucket { get; }
        public IReadOnlyList<PreparedVegetationPlacement> Placements { get; }
        public bool IsCenterTile { get; }
        public int ChunkIndexWithinBucket { get; }
        public int ChunkCountWithinBucket { get; }
        public bool MarksCenterTileReady { get; set; }
        public bool IsFinalChunkForTile { get; set; }
        public int NextPlacementIndex { get; set; }
        public int InstancedPlacementCount { get; private set; }
        public int LegacyPlacementCount { get; private set; }
        public int MissingPrefabCount { get; private set; }
        public int ForcedInstancingOnlyCount { get; private set; }
        public int ExactTerrainConformPlacementCount { get; private set; }
        public int ApproximatePlacementCount { get; private set; }
        public int NewPrototypeCount { get; set; }
        public double PrefabResolveMilliseconds { get; private set; }
        public double PrototypeResolveMilliseconds { get; private set; }
        public double PositionBuildMilliseconds { get; private set; }
        public double NormalBuildMilliseconds { get; private set; }
        public double RendererFinalizeMilliseconds { get; set; }

        public void RecordInstancedPlacement(bool forcedInstancingOnly)
        {
            InstancedPlacementCount++;
            if (forcedInstancingOnly)
            {
                ForcedInstancingOnlyCount++;
            }
        }

        public void RecordLegacyPlacement()
        {
            LegacyPlacementCount++;
        }

        public void RecordMissingPrefab()
        {
            MissingPrefabCount++;
        }

        public void RecordPlacementTransformMode(bool usedExactTerrainConform)
        {
            if (usedExactTerrainConform)
            {
                ExactTerrainConformPlacementCount++;
                return;
            }

            ApproximatePlacementCount++;
        }

        public void RecordPlacementPhase(double elapsedMilliseconds, VegetationPlacementPhase placementPhase)
        {
            switch (placementPhase)
            {
                case VegetationPlacementPhase.PrefabResolve:
                    PrefabResolveMilliseconds += elapsedMilliseconds;
                    break;
                case VegetationPlacementPhase.PrototypeResolve:
                    PrototypeResolveMilliseconds += elapsedMilliseconds;
                    break;
                case VegetationPlacementPhase.PositionBuild:
                    PositionBuildMilliseconds += elapsedMilliseconds;
                    break;
                case VegetationPlacementPhase.NormalBuild:
                    NormalBuildMilliseconds += elapsedMilliseconds;
                    break;
                case VegetationPlacementPhase.RendererFinalize:
                    RendererFinalizeMilliseconds += elapsedMilliseconds;
                    break;
            }
        }
    }

    private readonly struct PreparedPlacementGeometry
    {
        public PreparedPlacementGeometry(
            Vector3 localPosition,
            Vector3 localNormal,
            Vector3 worldPosition,
            float distanceToTargetSq,
            VegetationDensityZone densityZone,
            bool useExactTerrainConformOnLoad,
            bool useExactTerrainConformOnPromotion)
        {
            LocalPosition = localPosition;
            LocalNormal = localNormal;
            WorldPosition = worldPosition;
            DistanceToTargetSq = distanceToTargetSq;
            DensityZone = densityZone;
            UseExactTerrainConformOnLoad = useExactTerrainConformOnLoad;
            UseExactTerrainConformOnPromotion = useExactTerrainConformOnPromotion;
        }

        public Vector3 LocalPosition { get; }
        public Vector3 LocalNormal { get; }
        public Vector3 WorldPosition { get; }
        public float DistanceToTargetSq { get; }
        public VegetationDensityZone DensityZone { get; }
        public bool UseExactTerrainConformOnLoad { get; }
        public bool UseExactTerrainConformOnPromotion { get; }

        public PreparedPlacementGeometry WithLocalNormal(Vector3 localNormal)
        {
            return new PreparedPlacementGeometry(
                LocalPosition,
                localNormal,
                WorldPosition,
                DistanceToTargetSq,
                DensityZone,
                UseExactTerrainConformOnLoad,
                UseExactTerrainConformOnPromotion);
        }
    }

    private readonly struct PreparedVegetationPlacement
    {
        public PreparedVegetationPlacement(
            TileObjectPlacement placement,
            ulong stableHash,
            bool isCenterTile,
            VegetationPriorityBucket priorityBucket,
            bool forceInstancingOnly,
            PreparedPlacementGeometry geometry)
        {
            Placement = placement;
            StableHash = stableHash;
            IsCenterTile = isCenterTile;
            PriorityBucket = priorityBucket;
            ForceInstancingOnly = forceInstancingOnly;
            Geometry = geometry;
        }

        public TileObjectPlacement Placement { get; }
        public ulong StableHash { get; }
        public bool IsCenterTile { get; }
        public VegetationPriorityBucket PriorityBucket { get; }
        public bool ForceInstancingOnly { get; }
        public PreparedPlacementGeometry Geometry { get; }

        public PreparedVegetationPlacement WithGeometry(PreparedPlacementGeometry geometry)
        {
            return new PreparedVegetationPlacement(
                Placement,
                StableHash,
                IsCenterTile,
                PriorityBucket,
                ForceInstancingOnly,
                geometry);
        }
    }

    private sealed class VegetationTileStreamingStats
    {
        public VegetationTileStreamingStats(Vector2Int tileCoordinate, bool isCenterTile)
        {
            TileCoordinate = tileCoordinate;
            IsCenterTile = isCenterTile;
            GeneratedByCategory = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
            KeptByCategory = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
            SkippedByCategory = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
            QueuedPlacementsByBucket = new Dictionary<string, int>(StringComparer.Ordinal);
            QueuedWorkItemsByBucket = new Dictionary<string, int>(StringComparer.Ordinal);
        }

        public Vector2Int TileCoordinate { get; }
        public bool IsCenterTile { get; }
        public Dictionary<string, int> GeneratedByCategory { get; }
        public Dictionary<string, int> KeptByCategory { get; }
        public Dictionary<string, int> SkippedByCategory { get; }
        public Dictionary<string, int> QueuedPlacementsByBucket { get; }
        public Dictionary<string, int> QueuedWorkItemsByBucket { get; }
        public int GeneratedCount { get; private set; }
        public int KeptCount { get; private set; }
        public int SkippedCount { get; private set; }
        public int QueuedPlacementCount { get; private set; }
        public int InstancedPlacementCount { get; private set; }
        public int LegacyPlacementCount { get; private set; }
        public int MissingPrefabCount { get; private set; }
        public int ForcedInstancingOnlyCount { get; private set; }
        public int ExactTerrainConformPlacementCount { get; private set; }
        public int ApproximatePlacementCount { get; private set; }
        public int DeferredRendererFinalizeCount { get; private set; }
        public int RendererFinalizeCount { get; private set; }
        public int VisiblePlacementCount { get; private set; }
        public int QueuedWorkItemCount { get; private set; }
        public int CompletedWorkItemCount { get; private set; }
        public double TileReadyMilliseconds { get; private set; }
        public double FirstVisibleMilliseconds { get; private set; }
        public double InterruptedMilliseconds { get; private set; }
        public double QueuePrepCpuMilliseconds { get; private set; }
        public double PlacementCpuMilliseconds { get; private set; }
        public double PlacementWallMilliseconds { get; private set; }
        public double QueuePrepCompletedWallMilliseconds { get; private set; }
        public double PrefabResolveMilliseconds { get; private set; }
        public double PrototypeResolveMilliseconds { get; private set; }
        public double PositionBuildMilliseconds { get; private set; }
        public double NormalBuildMilliseconds { get; private set; }
        public double RendererFinalizeMilliseconds { get; private set; }
        public int HeightmapSampleCount { get; private set; }
        public int RaycastSampleCount { get; private set; }
        public bool HasLoggedReady { get; set; }
        public VegetationTileStreamingStatus Status { get; private set; }

        public void RecordGenerated(string categoryName)
        {
            GeneratedCount++;
            IncrementCount(GeneratedByCategory, categoryName);
        }

        public void RecordKept(string categoryName)
        {
            KeptCount++;
            IncrementCount(KeptByCategory, categoryName);
        }

        public void RecordSkipped(string categoryName)
        {
            SkippedCount++;
            IncrementCount(SkippedByCategory, categoryName);
        }

        public void RecordVisible(double elapsedMilliseconds)
        {
            VisiblePlacementCount++;
            if (FirstVisibleMilliseconds <= 0d)
            {
                FirstVisibleMilliseconds = elapsedMilliseconds;
            }

            if (Status == VegetationTileStreamingStatus.Pending)
            {
                Status = VegetationTileStreamingStatus.Visible;
            }
        }

        public void RecordQueuedWorkItem(int placementCount, VegetationPriorityBucket priorityBucket)
        {
            QueuedWorkItemCount++;
            QueuedPlacementCount += Math.Max(0, placementCount);
            string bucketKey = priorityBucket.ToString();
            IncrementCount(QueuedWorkItemsByBucket, bucketKey);
            AddCount(QueuedPlacementsByBucket, bucketKey, placementCount);
        }

        public void RecordQueuePrep(double cpuMilliseconds, double queuePrepCompletedWallMilliseconds)
        {
            QueuePrepCpuMilliseconds += cpuMilliseconds;
            QueuePrepCompletedWallMilliseconds = Math.Max(QueuePrepCompletedWallMilliseconds, queuePrepCompletedWallMilliseconds);
        }

        public void RecordPlacementCpu(double cpuMilliseconds)
        {
            PlacementCpuMilliseconds += cpuMilliseconds;
        }

        public void RecordPlacementPhase(double elapsedMilliseconds, VegetationPlacementPhase placementPhase)
        {
            switch (placementPhase)
            {
                case VegetationPlacementPhase.PrefabResolve:
                    PrefabResolveMilliseconds += elapsedMilliseconds;
                    break;
                case VegetationPlacementPhase.PrototypeResolve:
                    PrototypeResolveMilliseconds += elapsedMilliseconds;
                    break;
                case VegetationPlacementPhase.PositionBuild:
                    PositionBuildMilliseconds += elapsedMilliseconds;
                    break;
                case VegetationPlacementPhase.NormalBuild:
                    NormalBuildMilliseconds += elapsedMilliseconds;
                    break;
                case VegetationPlacementPhase.RendererFinalize:
                    RendererFinalizeMilliseconds += elapsedMilliseconds;
                    break;
            }
        }

        public void RecordInstancedPlacement(VegetationPriorityBucket priorityBucket, bool forcedInstancingOnly)
        {
            InstancedPlacementCount++;
            if (forcedInstancingOnly)
            {
                ForcedInstancingOnlyCount++;
            }
        }

        public void RecordLegacyPlacement(VegetationPriorityBucket priorityBucket)
        {
            LegacyPlacementCount++;
        }

        public void RecordMissingPrefab()
        {
            MissingPrefabCount++;
        }

        public void RecordForcedInstancingOnly()
        {
            ForcedInstancingOnlyCount++;
        }

        public void RecordPlacementTransformMode(bool usedExactTerrainConform)
        {
            if (usedExactTerrainConform)
            {
                ExactTerrainConformPlacementCount++;
                return;
            }

            ApproximatePlacementCount++;
        }

        public void RecordDeferredRendererFinalize()
        {
            DeferredRendererFinalizeCount++;
        }

        public void RecordRendererFinalize()
        {
            RendererFinalizeCount++;
        }

        public void RecordHeightmapSamples(int sampleCount)
        {
            HeightmapSampleCount += Math.Max(0, sampleCount);
        }

        public void RecordRaycastSamples(int sampleCount)
        {
            RaycastSampleCount += Math.Max(0, sampleCount);
        }

        public int RecordCompletedWorkItem(double elapsedMilliseconds)
        {
            CompletedWorkItemCount++;
            if (Status == VegetationTileStreamingStatus.Settled || CompletedWorkItemCount < QueuedWorkItemCount)
            {
                return CompletedWorkItemCount;
            }

            MarkSettled(elapsedMilliseconds);
            return CompletedWorkItemCount;
        }

        public void MarkSettled(double settledElapsedMilliseconds)
        {
            if (Status == VegetationTileStreamingStatus.Settled)
            {
                return;
            }

            TileReadyMilliseconds = settledElapsedMilliseconds;
            PlacementWallMilliseconds = Math.Max(0d, settledElapsedMilliseconds - QueuePrepCompletedWallMilliseconds);
            Status = VegetationTileStreamingStatus.Settled;
        }

        public void MarkInterrupted(double interruptedElapsedMilliseconds)
        {
            if (Status == VegetationTileStreamingStatus.Settled)
            {
                return;
            }

            InterruptedMilliseconds = interruptedElapsedMilliseconds;
            PlacementWallMilliseconds = Math.Max(0d, interruptedElapsedMilliseconds - QueuePrepCompletedWallMilliseconds);
            Status = VegetationTileStreamingStatus.Interrupted;
        }
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

    private sealed class GeneratedTerrainBatchState
    {
        public GeneratedTerrainBatchState(
            string cacheKey,
            string cacheSignature,
            int pipelineId,
            Vector3Int centerTileCoordinate,
            IReadOnlyList<GeneratedTerrainRequest> requests,
            double normalizationMinHeight,
            double normalizationMaxHeight)
        {
            CacheKey = cacheKey;
            CacheSignature = cacheSignature;
            PipelineId = pipelineId;
            CenterTileCoordinate = centerTileCoordinate;
            Requests = requests?.ToArray() ?? Array.Empty<GeneratedTerrainRequest>();
            NormalizationMinHeight = normalizationMinHeight;
            NormalizationMaxHeight = normalizationMaxHeight;
            ActiveTerrains = new List<GStylizedTerrain>(Requests.Count);
            CreatedTerrains = new List<GStylizedTerrain>(Requests.Count);
            CreatedRequests = new List<GeneratedTerrainRequest>(Requests.Count);
            TerrainByCoordinate = new Dictionary<Vector2Int, GStylizedTerrain>();
            NextDeferredPhase = DeferredGenerationPhase.RiverWater;
            RiverSplineCache = new Dictionary<string, Spline>(StringComparer.Ordinal);
            RiverRefreshRequests = new List<GeneratedTerrainRequest>(Requests.Count);
            RiverRefreshTerrains = new List<GStylizedTerrain>(Requests.Count);
            VegetationRefreshRequests = new List<GeneratedTerrainRequest>(Requests.Count);
            VegetationRefreshTerrains = new List<GStylizedTerrain>(Requests.Count);
            PhaseTimingsMilliseconds = new Dictionary<string, double>(StringComparer.Ordinal);
            VegetationTileStats = new Dictionary<Vector2Int, VegetationTileStreamingStats>();
            MissingPrefabCountsByPath = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
            VegetationQueuedPlacementsByBucket = new Dictionary<string, int>(StringComparer.Ordinal);
            VegetationQueuedWorkItemsByBucket = new Dictionary<string, int>(StringComparer.Ordinal);
        }

        public string CacheKey { get; }
        public string CacheSignature { get; }
        public int PipelineId { get; }
        public Vector3Int CenterTileCoordinate { get; }
        public IReadOnlyList<GeneratedTerrainRequest> Requests { get; }
        public double NormalizationMinHeight { get; }
        public double NormalizationMaxHeight { get; }
        public List<GStylizedTerrain> ActiveTerrains { get; }
        public List<GStylizedTerrain> CreatedTerrains { get; }
        public List<GeneratedTerrainRequest> CreatedRequests { get; }
        public Dictionary<Vector2Int, GStylizedTerrain> TerrainByCoordinate { get; }
        public Transform? BatchRoot { get; set; }
        public DeferredGenerationPhase NextDeferredPhase { get; set; }
        public Dictionary<string, Spline> RiverSplineCache { get; }
        public List<GeneratedTerrainRequest> RiverRefreshRequests { get; }
        public List<GStylizedTerrain> RiverRefreshTerrains { get; }
        public List<GeneratedTerrainRequest> VegetationRefreshRequests { get; }
        public List<GStylizedTerrain> VegetationRefreshTerrains { get; }
        public Dictionary<string, double> PhaseTimingsMilliseconds { get; }
        public Dictionary<Vector2Int, VegetationTileStreamingStats> VegetationTileStats { get; }
        public Dictionary<string, int> MissingPrefabCountsByPath { get; }
        public Dictionary<string, int> VegetationQueuedPlacementsByBucket { get; }
        public Dictionary<string, int> VegetationQueuedWorkItemsByBucket { get; }
        public Vector3? VegetationStreamingTargetWorldPosition { get; set; }
        public int ReusedTerrainCount { get; set; }
        public int RemovedTerrainCount { get; set; }
        public int ReusedRequestCount { get; set; }
        public int VegetationGeneratedPlacementCount { get; set; }
        public int VegetationKeptPlacementCount { get; set; }
        public int VegetationSkippedByPolicyCount { get; set; }
        public int VegetationSkippedByDistanceCount { get; set; }
        public int VegetationSkippedByCapCount { get; set; }
        public int VegetationQueuedWorkItemCount { get; set; }
        public int VegetationQueuedPlacementCount { get; set; }
        public int VegetationInstancedPlacementCount { get; set; }
        public int VegetationLegacyPlacementCount { get; set; }
        public int VegetationExactTerrainConformPlacementCount { get; set; }
        public int VegetationApproximatePlacementCount { get; set; }
        public int VegetationDeferredRendererFinalizeCount { get; set; }
        public int VegetationRendererFinalizeCount { get; set; }
        public int VegetationPrototypeCacheHitCount { get; set; }
        public int VegetationPrototypeCacheMissCount { get; set; }
        public int VegetationForcedInstancingOnlyCount { get; set; }
        public int VegetationMissingPrefabCount { get; set; }
        public int VegetationRendererInitializationCount { get; set; }
        public double VegetationPrototypeInitializationMilliseconds { get; set; }
        public double VegetationQueuePrepCpuMilliseconds { get; set; }
        public double VegetationPlacementCpuMilliseconds { get; set; }
        public double VegetationPrefabResolveMilliseconds { get; set; }
        public double VegetationPrototypeResolveMilliseconds { get; set; }
        public double VegetationPositionBuildMilliseconds { get; set; }
        public double VegetationNormalBuildMilliseconds { get; set; }
        public double VegetationRendererFinalizeMilliseconds { get; set; }
        public int VegetationHeightmapSampleCount { get; set; }
        public int VegetationRaycastSampleCount { get; set; }
        public double VegetationCenterReadyMilliseconds { get; set; }
        public double VegetationFullSettledMilliseconds { get; set; }

        public void RecordPhaseTiming(string phaseName, double elapsedMilliseconds)
        {
            if (string.IsNullOrWhiteSpace(phaseName))
            {
                return;
            }

            if (PhaseTimingsMilliseconds.TryGetValue(phaseName, out double existing))
            {
                PhaseTimingsMilliseconds[phaseName] = existing + elapsedMilliseconds;
                return;
            }

            PhaseTimingsMilliseconds[phaseName] = elapsedMilliseconds;
        }
    }

    private sealed class GeneratedTerrainBatchCacheEntry
    {
        public GeneratedTerrainBatchCacheEntry(
            string cacheKey,
            string cacheSignature,
            Vector3Int centerTileCoordinate,
            double normalizationMinHeight,
            double normalizationMaxHeight,
            IReadOnlyList<GeneratedTerrainRequest> requests)
        {
            CacheKey = cacheKey;
            CacheSignature = cacheSignature;
            CenterTileCoordinate = centerTileCoordinate;
            NormalizationMinHeight = normalizationMinHeight;
            NormalizationMaxHeight = normalizationMaxHeight;
            Requests = requests?.ToArray() ?? Array.Empty<GeneratedTerrainRequest>();
        }

        public string CacheKey { get; }
        public string CacheSignature { get; }
        public Vector3Int CenterTileCoordinate { get; }
        public double NormalizationMinHeight { get; }
        public double NormalizationMaxHeight { get; }
        public IReadOnlyList<GeneratedTerrainRequest> Requests { get; }

        public GeneratedTerrainBatchState CreateState(int pipelineId)
        {
            return new GeneratedTerrainBatchState(
                CacheKey,
                CacheSignature,
                pipelineId,
                CenterTileCoordinate,
                Requests,
                NormalizationMinHeight,
                NormalizationMaxHeight);
        }
    }

    private readonly struct CachedLoadedWorldData
    {
        public CachedLoadedWorldData(DateTime lastWriteUtc, LoadedWorldData data)
        {
            LastWriteUtc = lastWriteUtc;
            Data = data;
        }

        public DateTime LastWriteUtc { get; }
        public LoadedWorldData Data { get; }
    }

    private enum DeferredGenerationPhase
    {
        RiverWater,
        DebugSplines,
        Vegetation,
        Completed,
    }

    private enum VegetationPriorityBucket
    {
        CenterCanopyAndLarge,
        CenterClutterAndGround,
        OuterCanopyAndLarge,
        OuterClutter,
        OuterGroundAndDebris,
    }

    private enum VegetationDensityZone
    {
        High,
        Mid,
        Outer,
    }

    private enum VegetationPlacementPhase
    {
        PrefabResolve,
        PrototypeResolve,
        PositionBuild,
        NormalBuild,
        RendererFinalize,
    }

    private enum VegetationTileStreamingStatus
    {
        Pending,
        Visible,
        Settled,
        Interrupted,
    }

    private enum VegetationLoadMode
    {
        LegacyGameObjects,
        HybridInteractive,
        InstancesOnly,
    }

    private enum TerrainShadingMode
    {
        PolarisTextureBlend,
        FallbackLit,
    }
}
