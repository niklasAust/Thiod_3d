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
    private TileLoaderTerrainSampler? cachedTerrainSampler;
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
        cachedTerrainSampler = null;

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
        cachedTerrainSampler = null;
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
        cachedTerrainSampler = null;
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

    private TerrainBuildContext CreateTerrainBuildContext()
    {
        return new TerrainBuildContext(
            worldDataFile,
            useMetadataGenerationSettings,
            fallbackTileSize,
            fallbackHillSpacing,
            fallbackHillStrength,
            unityTileCoordinate,
            invertUnityYForWorldGen,
            UsesBatchNeighborhoodLoading(),
            dynamicTileLoadingEnabled,
            reuseOverlappingDynamicNeighborhoodTiles,
            terrainWidth,
            terrainLength,
            terrainHeight,
            terrainGridSize,
            generatedTerrainName,
            riverWidthMultiplier,
            riverDepthMultiplier,
            riverBankDepthMultiplier,
            riverCenterDepthMultiplier,
            riverCenterDepthMultiplierAtNinetyDegrees,
            riverCenterCarveWidthMultiplier,
            riverCenterCarveWidthMultiplierAtNinetyDegrees,
            riverProfileMinDropMetersPerTile,
            riverProfileMaxDropMetersPerTile,
            riverCorridorDepressionMeters,
            riverCorridorMaxSlopeMetersPerSample,
            riverCorridorRadiusMultiplier,
            riverCorridorMinRadiusSamples,
            riverCorridorSmoothingStrength,
            riverCorridorSmoothingKernelRadius,
            riverCorridorSmoothingPasses,
            riverFinalSmoothingStrength,
            riverFinalSmoothingKernelRadius,
            riverFinalSmoothingPasses,
            riverFinalSmoothingRetainedDepthFraction,
            riverWaterMeshVerticalOffset,
            riverWaterMeshVerticalOffsetAtNinetyDegrees,
            VegetationStreamingPolicyVersion,
            placeTreeObjects,
            placeSurfaceObjects);
    }

    private RiverBuildContext CreateRiverBuildContext()
    {
        return new RiverBuildContext(
            terrainWidth,
            terrainLength,
            terrainHeight,
            terrainGridSize,
            riverWidthMultiplier,
            riverDepthMultiplier,
            riverBankDepthMultiplier);
    }

    private VegetationBuildContext CreateVegetationBuildContext()
    {
        return new VegetationBuildContext(
            terrainWidth,
            terrainLength,
            terrainHeight,
            MaxTileHeightUnits,
            surfaceObjectVerticalOffset,
            grassClusterConformSurfaceOffset);
    }

    private TileLoaderRiverSettings CreateRiverSettings()
    {
        return new TileLoaderRiverSettings
        {
            CreateRiverWater = createRiverWater,
            CreateRiverDebugSplines = createRiverDebugSplines,
            GeneratedRiverWaterContainerName = generatedRiverWaterContainerName,
            GeneratedRiverSplineContainerName = generatedRiverSplineContainerName,
            RiverWaterMaterial = riverWaterMaterial,
            RiverWaterMaterialAssetPath = riverWaterMaterialAssetPath,
            CachedRiverWaterMaterial = cachedRiverWaterMaterial,
            CachedRiverWaterMaterialPath = cachedRiverWaterMaterialPath,
            RiverWaterWidthMultiplier = riverWaterWidthMultiplier,
            RiverWaterBedClearance = riverWaterBedClearance,
            RiverWaterMeshVerticalOffset = riverWaterMeshVerticalOffset,
            RiverWaterMeshVerticalOffsetAtNinetyDegrees = riverWaterMeshVerticalOffsetAtNinetyDegrees,
            RiverWaterMinimumDownstreamDrop = riverWaterMinimumDownstreamDrop,
            RiverWaterSampleStride = riverWaterSampleStride,
            RiverSplineSamplingStep = riverSplineSamplingStep,
            RiverSplineAvgElements = riverSplineAvgElements,
            RiverWaterUvLengthScale = riverWaterUvLengthScale,
            RiverWaterUvWidthScale = riverWaterUvWidthScale,
            RiverWaterSpeedMultiplier = riverWaterSpeedMultiplier,
            RiverWaterMinSegmentLength = riverWaterMinSegmentLength,
            RiverWaterTangentSmoothingRadius = riverWaterTangentSmoothingRadius,
            TerrainWidth = terrainWidth,
            TerrainLength = terrainLength,
        };
    }

    private void ApplyRiverSettings(TileLoaderRiverSettings settings)
    {
        createRiverWater = settings.CreateRiverWater;
        createRiverDebugSplines = settings.CreateRiverDebugSplines;
        generatedRiverWaterContainerName = settings.GeneratedRiverWaterContainerName;
        generatedRiverSplineContainerName = settings.GeneratedRiverSplineContainerName;
        riverWaterMaterial = settings.RiverWaterMaterial;
        riverWaterMaterialAssetPath = settings.RiverWaterMaterialAssetPath;
        cachedRiverWaterMaterial = settings.CachedRiverWaterMaterial;
        cachedRiverWaterMaterialPath = settings.CachedRiverWaterMaterialPath;
        riverWaterWidthMultiplier = settings.RiverWaterWidthMultiplier;
        riverWaterBedClearance = settings.RiverWaterBedClearance;
        riverWaterMeshVerticalOffset = settings.RiverWaterMeshVerticalOffset;
        riverWaterMeshVerticalOffsetAtNinetyDegrees = settings.RiverWaterMeshVerticalOffsetAtNinetyDegrees;
        riverWaterMinimumDownstreamDrop = settings.RiverWaterMinimumDownstreamDrop;
        riverWaterSampleStride = settings.RiverWaterSampleStride;
        riverSplineSamplingStep = settings.RiverSplineSamplingStep;
        riverSplineAvgElements = settings.RiverSplineAvgElements;
        riverWaterUvLengthScale = settings.RiverWaterUvLengthScale;
        riverWaterUvWidthScale = settings.RiverWaterUvWidthScale;
        riverWaterSpeedMultiplier = settings.RiverWaterSpeedMultiplier;
        riverWaterMinSegmentLength = settings.RiverWaterMinSegmentLength;
        riverWaterTangentSmoothingRadius = settings.RiverWaterTangentSmoothingRadius;
    }

    private ConiferOptimizationContext CreateConiferOptimizationContext()
    {
        return new ConiferOptimizationContext(
            fullConiferDistance,
            reducedConiferDistance,
            lowDetailConiferDistance,
            culledConiferDistance,
            disableDistantConiferColliders,
            disableDistantConiferShadows,
            disableDistantConiferDecals);
    }

    private TileLoaderConiferOptimizer CreateConiferOptimizer()
    {
        return new TileLoaderConiferOptimizer(CreateConiferOptimizationContext());
    }

    private TileLoaderBatchPlanner CreateBatchPlanner()
    {
        return new TileLoaderBatchPlanner(CreateTerrainBuildContext(), MetersPerTileHeightUnit);
    }

    private TileLoaderTerrainSampler CreateTerrainSampler()
    {
        return cachedTerrainSampler ??= new TileLoaderTerrainSampler(CreateVegetationBuildContext());
    }

    private TileLoaderRiverBuilder CreateRiverBuilder(TileLoaderRiverSettings settings)
    {
        return new TileLoaderRiverBuilder(settings, CreateTerrainSampler(), DefaultRiverWaterMaterialAssetPath);
    }

    private void UseRiverBuilder(Action<TileLoaderRiverBuilder> action)
    {
        TileLoaderRiverSettings settings = CreateRiverSettings();
        try
        {
            action(CreateRiverBuilder(settings));
        }
        finally
        {
            ApplyRiverSettings(settings);
        }
    }

    private TerrainShadingSettings CreateTerrainShadingSettings()
    {
        return new TerrainShadingSettings
        {
            TerrainShadingMode = terrainShadingMode,
            TerrainDecalRenderingLayerName = terrainDecalRenderingLayerName,
            LowlandTerrainMaterial = lowlandTerrainMaterial,
            LowlandTerrainMaterialVariant = lowlandTerrainMaterialVariant,
            MidHeightTerrainMaterial = midHeightTerrainMaterial,
            SteepSlopeTerrainMaterial = steepSlopeTerrainMaterial,
            SteepSlopeTerrainMaterialVariant = steepSlopeTerrainMaterialVariant,
            PeakTerrainMaterial = peakTerrainMaterial,
            LowlandTerrainTileSize = lowlandTerrainTileSize,
            MidHeightTerrainTileSize = midHeightTerrainTileSize,
            SteepSlopeTerrainTileSize = steepSlopeTerrainTileSize,
            PeakTerrainTileSize = peakTerrainTileSize,
            MacroVariationScale = macroVariationScale,
            MacroVariationStrength = macroVariationStrength,
            SurfaceVariantScale = surfaceVariantScale,
            SurfaceVariantStrength = surfaceVariantStrength,
            SurfaceVariantTransition = surfaceVariantTransition,
            SurfacePhaseOffsetStrength = surfacePhaseOffsetStrength,
            MirrorTerrainVariantTextures = mirrorTerrainVariantTextures,
            MacroTintScale = macroTintScale,
            MacroTintStrength = macroTintStrength,
            MidHeightStartMeters = midHeightStartMeters,
            MidHeightBlendMeters = midHeightBlendMeters,
            SteepSlopeStartDegrees = steepSlopeStartDegrees,
            SteepSlopeBlendDegrees = steepSlopeBlendDegrees,
            RuggedSnowCapHillinessThreshold = ruggedSnowCapHillinessThreshold,
            RuggedSnowCapHillinessBlend = ruggedSnowCapHillinessBlend,
            RuggedSnowCapBelowPeakMeters = ruggedSnowCapBelowPeakMeters,
            RuggedSnowCapMinStartMeters = ruggedSnowCapMinStartMeters,
            RuggedSnowCapBlendMeters = ruggedSnowCapBlendMeters,
            FullSnowStartMeters = fullSnowStartMeters,
            FullSnowBlendMeters = fullSnowBlendMeters,
            FullSnowRockSlopeStartDegrees = fullSnowRockSlopeStartDegrees,
            FullSnowRockSlopeBlendDegrees = fullSnowRockSlopeBlendDegrees,
            HasWarnedMissingTerrainDecalRenderingLayer = hasWarnedMissingTerrainDecalRenderingLayer,
            TerrainWidth = terrainWidth,
            TerrainLength = terrainLength,
            TerrainHeight = terrainHeight,
            MaxTileHeightUnits = MaxTileHeightUnits,
            MetersPerTileHeightUnit = MetersPerTileHeightUnit,
            GeneratedTerrainShadingMetadata = generatedTerrainShadingMetadata,
        };
    }

    private void ApplyTerrainShadingSettings(TerrainShadingSettings settings)
    {
        terrainShadingMode = settings.TerrainShadingMode;
        terrainDecalRenderingLayerName = settings.TerrainDecalRenderingLayerName;
        lowlandTerrainMaterial = settings.LowlandTerrainMaterial;
        lowlandTerrainMaterialVariant = settings.LowlandTerrainMaterialVariant;
        midHeightTerrainMaterial = settings.MidHeightTerrainMaterial;
        steepSlopeTerrainMaterial = settings.SteepSlopeTerrainMaterial;
        steepSlopeTerrainMaterialVariant = settings.SteepSlopeTerrainMaterialVariant;
        peakTerrainMaterial = settings.PeakTerrainMaterial;
        lowlandTerrainTileSize = settings.LowlandTerrainTileSize;
        midHeightTerrainTileSize = settings.MidHeightTerrainTileSize;
        steepSlopeTerrainTileSize = settings.SteepSlopeTerrainTileSize;
        peakTerrainTileSize = settings.PeakTerrainTileSize;
        macroVariationScale = settings.MacroVariationScale;
        macroVariationStrength = settings.MacroVariationStrength;
        surfaceVariantScale = settings.SurfaceVariantScale;
        surfaceVariantStrength = settings.SurfaceVariantStrength;
        surfaceVariantTransition = settings.SurfaceVariantTransition;
        surfacePhaseOffsetStrength = settings.SurfacePhaseOffsetStrength;
        mirrorTerrainVariantTextures = settings.MirrorTerrainVariantTextures;
        macroTintScale = settings.MacroTintScale;
        macroTintStrength = settings.MacroTintStrength;
        midHeightStartMeters = settings.MidHeightStartMeters;
        midHeightBlendMeters = settings.MidHeightBlendMeters;
        steepSlopeStartDegrees = settings.SteepSlopeStartDegrees;
        steepSlopeBlendDegrees = settings.SteepSlopeBlendDegrees;
        ruggedSnowCapHillinessThreshold = settings.RuggedSnowCapHillinessThreshold;
        ruggedSnowCapHillinessBlend = settings.RuggedSnowCapHillinessBlend;
        ruggedSnowCapBelowPeakMeters = settings.RuggedSnowCapBelowPeakMeters;
        ruggedSnowCapMinStartMeters = settings.RuggedSnowCapMinStartMeters;
        ruggedSnowCapBlendMeters = settings.RuggedSnowCapBlendMeters;
        fullSnowStartMeters = settings.FullSnowStartMeters;
        fullSnowBlendMeters = settings.FullSnowBlendMeters;
        fullSnowRockSlopeStartDegrees = settings.FullSnowRockSlopeStartDegrees;
        fullSnowRockSlopeBlendDegrees = settings.FullSnowRockSlopeBlendDegrees;
        hasWarnedMissingTerrainDecalRenderingLayer = settings.HasWarnedMissingTerrainDecalRenderingLayer;
        generatedTerrainShadingMetadata = settings.GeneratedTerrainShadingMetadata;
    }

    private TileLoaderTerrainShadingService CreateTerrainShadingService(TerrainShadingSettings settings)
    {
        return new TileLoaderTerrainShadingService(
            settings,
            DefaultLowlandTerrainMaterialAssetPath,
            DefaultLowlandTerrainMaterialVariantAssetPath,
            DefaultMidHeightTerrainMaterialAssetPath,
            DefaultSteepSlopeTerrainMaterialAssetPath,
            DefaultSteepSlopeTerrainMaterialVariantAssetPath,
            DefaultPeakTerrainMaterialAssetPath);
    }

    private void UseTerrainShadingService(Action<TileLoaderTerrainShadingService> action)
    {
        TerrainShadingSettings settings = CreateTerrainShadingSettings();
        try
        {
            action(CreateTerrainShadingService(settings));
        }
        finally
        {
            ApplyTerrainShadingSettings(settings);
        }
    }

    private T UseTerrainShadingService<T>(Func<TileLoaderTerrainShadingService, T> func)
    {
        TerrainShadingSettings settings = CreateTerrainShadingSettings();
        try
        {
            return func(CreateTerrainShadingService(settings));
        }
        finally
        {
            ApplyTerrainShadingSettings(settings);
        }
    }

    private GeneratedTerrainBatchState BuildGeneratedTerrainBatchState(
        TileGenerator tileGenerator,
        LoadedWorldData loadedWorldData,
        GenerationSettings settings,
        int pipelineId)
    {
        return CreateBatchPlanner().BuildBatchState(
            tileGenerator,
            loadedWorldData,
            settings,
            pipelineId,
            ref cachedTerrainBatch,
            activeGeneratedTerrainRoot,
            activeLoadedUnityTileCoordinate,
            activeTerrainTileCache,
            activeTerrainTileCacheSignature);
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
        _ = texturingModel;
        UseTerrainShadingService(service => service.ConfigureShading(
            terrainData,
            sourceHeightmap,
            normalizationMinHeight,
            normalizationMaxHeight,
            localMaxHeight,
            tileHilliness,
            this));
    }

    private GTexturingModel GetTexturingModel()
    {
        return UseTerrainShadingService(service => service.GetTexturingModel());
    }

    private void ApplyTerrainShading(
        GTerrainData terrainData,
        double[,] sourceHeightmap,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        double localMaxHeight,
        double tileHilliness)
    {
        UseTerrainShadingService(service => service.ApplyTerrainShading(
            terrainData,
            sourceHeightmap,
            normalizationMinHeight,
            normalizationMaxHeight,
            localMaxHeight,
            tileHilliness));
    }

    private void ApplyTerrainShading(IReadOnlyList<GStylizedTerrain> terrains)
    {
        UseTerrainShadingService(service => service.ApplyTerrainShading(terrains, this));
    }

    private void ApplyTerrainShading(GStylizedTerrain terrain)
    {
        UseTerrainShadingService(service => service.ApplyTerrainShading(terrain, this));
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
        return TileLoaderTerrainMathUtility.BuildNormalizedHeights(sourceHeightmap, MaxTileHeightUnits);
    }

    private static float[,] BuildHeightMeters(double[,] sourceHeightmap)
    {
        return TileLoaderTerrainMathUtility.BuildHeightMeters(sourceHeightmap, MetersPerTileHeightUnit);
    }

    private static float[,] BuildHeightMetersFromNormalizedHeights(float[,] normalizedHeights, double minHeightUnits, double maxHeightUnits)
    {
        return TileLoaderTerrainMathUtility.BuildHeightMetersFromNormalizedHeights(normalizedHeights, minHeightUnits, maxHeightUnits);
    }

    private static float TileHeightUnitsToMeters(double heightUnits)
    {
        return TileLoaderTerrainMathUtility.TileHeightUnitsToMeters(heightUnits, MetersPerTileHeightUnit);
    }

    private static float EstimateMaxHeightMeters(float[,] heightMeters)
    {
        return TileLoaderTerrainMathUtility.EstimateMaxHeightMeters(heightMeters);
    }

    private static float EstimateTileHilliness(float[,] heightMeters)
    {
        return TileLoaderTerrainMathUtility.EstimateTileHilliness(heightMeters);
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
        UseTerrainShadingService(service => service.SetTerrainShadingMetadata(
            terrainName,
            normalizationMinHeight,
            normalizationMaxHeight,
            localMaxHeightMeters,
            tileHilliness));
    }

    private void ApplyWorldAlignedSplatMaterialOffsets(GStylizedTerrain terrain)
    {
        UseTerrainShadingService(service => service.ApplyWorldAlignedSplatMaterialOffsets(terrain));
    }

    private void ApplyTerrainDecalRenderingLayer(GStylizedTerrain terrain)
    {
        UseTerrainShadingService(service => service.ApplyTerrainDecalRenderingLayer(terrain, this));
    }

    private void RebuildTerrainSeams(List<GStylizedTerrain> terrains)
    {
        UseTerrainShadingService(service => service.RebuildTerrainSeams(terrains, this));
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
        UseRiverBuilder(builder => builder.PopulateRiverWater(
            terrainRequests,
            terrains,
            normalizationMinHeight,
            normalizationMaxHeight,
            riverSplineCache,
            this));
    }

    private void PopulateRiverDebugSplines(
        IReadOnlyList<GeneratedTerrainRequest> terrainRequests,
        IReadOnlyList<GStylizedTerrain> terrains,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        Dictionary<string, Spline> riverSplineCache)
    {
        UseRiverBuilder(builder => builder.PopulateRiverDebugSplines(
            terrainRequests,
            terrains,
            normalizationMinHeight,
            normalizationMaxHeight,
            riverSplineCache));
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
        return TileLoaderVegetationPrototypeFactory.RequiresInstancingOnly(placement);
    }

    private static bool SupportsHybridPromotion(TileObjectPlacement placement)
    {
        return TileLoaderVegetationPrototypeFactory.SupportsHybridPromotion(placement);
    }

    private static float GetInstancedRenderDistanceMeters(TileObjectPlacement placement)
    {
        return TileLoaderVegetationPrototypeFactory.GetInstancedRenderDistanceMeters(placement);
    }

    private static Renderer[] ResolveInstancedPrototypeRenderers(GameObject prefab, bool isTreeObject)
    {
        return TileLoaderVegetationPrototypeFactory.ResolveInstancedPrototypeRenderers(prefab, isTreeObject);
    }

    private static Renderer[] FilterUsableInstancedRenderers(Renderer[]? renderers)
    {
        return TileLoaderVegetationPrototypeFactory.FilterUsableInstancedRenderers(renderers);
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
        return TileLoaderVegetationPrototypeFactory.NormalizeAssetPath(rawPath);
    }

    private static string? NormalizeResourcesPath(string rawPath)
    {
        return TileLoaderVegetationPrototypeFactory.NormalizeResourcesPath(rawPath);
    }

    private Vector3 GetPlacementLocalPosition(
        GStylizedTerrain? terrain,
        double[,] heightmap,
        TileObjectPlacement placement,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        float verticalOffset)
    {
        return CreateTerrainSampler().GetPlacementLocalPosition(
            terrain,
            heightmap,
            placement,
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
        return CreateTerrainSampler().GetTerrainLocalPoint(
            terrain,
            heightmap,
            sampleX,
            sampleY,
            normalizationMinHeight,
            normalizationMaxHeight,
            verticalOffset);
    }

    private Vector3 GetTerrainLocalPointFromHeightmapApprox(
        double[,] heightmap,
        double sampleX,
        double sampleY,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        float verticalOffset)
    {
        return CreateTerrainSampler().GetTerrainLocalPointFromHeightmapApprox(
            heightmap,
            sampleX,
            sampleY,
            normalizationMinHeight,
            normalizationMaxHeight,
            verticalOffset);
    }

    private Vector3 GetTerrainLocalNormal(
        GStylizedTerrain? terrain,
        double[,] heightmap,
        double sampleX,
        double sampleY,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        return CreateTerrainSampler().GetTerrainLocalNormal(
            terrain,
            heightmap,
            sampleX,
            sampleY,
            normalizationMinHeight,
            normalizationMaxHeight);
    }

    private Vector3 GetTerrainLocalNormalFromHeightmapApprox(
        double[,] heightmap,
        double sampleX,
        double sampleY,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        return CreateTerrainSampler().GetTerrainLocalNormalFromHeightmapApprox(
            heightmap,
            sampleX,
            sampleY,
            normalizationMinHeight,
            normalizationMaxHeight);
    }

    private float SampleTerrainHeight(
        double[,] heightmap,
        double sampleX,
        double sampleY,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        return CreateTerrainSampler().SampleTerrainHeight(
            heightmap,
            sampleX,
            sampleY,
            normalizationMinHeight,
            normalizationMaxHeight);
    }

    private static double SampleHeightmapBilinear(double[,] heightmap, double sampleX, double sampleY)
    {
        return TileLoaderTerrainMathUtility.SampleHeightmapBilinear(heightmap, sampleX, sampleY);
    }

    private static double Lerp(double a, double b, double t)
    {
        return TileLoaderTerrainMathUtility.Lerp(a, b, t);
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
        CreateTerrainSampler().PlaceSurfaceObjectInstance(
            surfaceObjectTransform,
            heightmap,
            placement,
            normalizationMinHeight,
            normalizationMaxHeight);
    }

    private void AlignExistingSurfaceObjectToTerrain(Transform surfaceObjectTransform)
    {
        CreateTerrainSampler().AlignExistingSurfaceObjectToTerrain(surfaceObjectTransform);
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
        return CreateTerrainSampler().TrySampleGeneratedTerrainLocalPoint(
            terrain,
            localX,
            localZ,
            verticalOffset,
            out localPoint);
    }

    private bool TrySampleGeneratedTerrainSurface(
        GStylizedTerrain? terrain,
        float localX,
        float localZ,
        float verticalOffset,
        out Vector3 localPoint,
        out Vector3 localNormal)
    {
        return CreateTerrainSampler().TrySampleGeneratedTerrainSurface(
            terrain,
            localX,
            localZ,
            verticalOffset,
            out localPoint,
            out localNormal);
    }

    private bool TrySampleGeneratedTerrainLocalMinimumPoint3x3(
        GStylizedTerrain? terrain,
        float localX,
        float localZ,
        float sampleSpacingX,
        float sampleSpacingZ,
        out float minimumY)
    {
        return CreateTerrainSampler().TrySampleGeneratedTerrainLocalMinimumPoint3x3(
            terrain,
            localX,
            localZ,
            sampleSpacingX,
            sampleSpacingZ,
            out minimumY);
    }

    private static bool TrySampleSurfaceObjectSurface(Transform surfaceObjectTransform, out RaycastHit surfaceHit)
    {
        return TileLoaderTerrainSampler.TrySampleSurfaceObjectSurface(surfaceObjectTransform, out surfaceHit);
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
        CreateConiferOptimizer().ApplyOptimizationToAll(generatedConiferInstances, tier);
    }

    private ConiferOptimizationTier DetermineConiferTier(
        float sqrDistance,
        float fullDistanceSq,
        float reducedDistanceSq,
        float lowDetailDistanceSq)
    {
        return CreateConiferOptimizer().DetermineTier(
            sqrDistance,
            fullDistanceSq,
            reducedDistanceSq,
            lowDetailDistanceSq);
    }

    private void ApplyConiferOptimization(GeneratedConiferInstance instance, ConiferOptimizationTier tier)
    {
        CreateConiferOptimizer().ApplyOptimization(instance, tier);
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
        return TileLoaderConiferOptimizer.TryFindSceneTransformWithComponent(componentTypeName, out result);
    }

    private static bool TryFindSceneTransformWithTag(string tagName, out Transform? result)
    {
        return TileLoaderConiferOptimizer.TryFindSceneTransformWithTag(tagName, out result);
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
        UseTerrainShadingService(service => service.EnsureShadingDefaults());
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

    private static Color[] BuildHeightPixels(double[,] heightmap, double minHeight, double maxHeight)
    {
        _ = minHeight;
        _ = maxHeight;
        return TileLoaderTerrainShadingService.BuildHeightPixels(heightmap, MaxTileHeightUnits);
    }

    private static float NormalizeHeightUnitsToTerrain(double heightUnits)
    {
        return TileLoaderTerrainMathUtility.NormalizeHeightUnitsToTerrain(heightUnits, MaxTileHeightUnits);
    }

    private static void CalculateHeightRange(double[,] heightmap, out double minHeight, out double maxHeight)
    {
        TileLoaderTerrainMathUtility.CalculateHeightRange(heightmap, out minHeight, out maxHeight);
    }

    private static double GetCenterTileHilliness(TileLayers layers)
    {
        return TileLoaderTerrainMathUtility.GetCenterTileHilliness(layers, MetersPerTileHeightUnit);
    }
#endif

    private GenerationSettings ResolveGenerationSettings(IReadOnlyDictionary<string, object> metadata)
    {
        return TileLoaderWorldDataUtility.ResolveGenerationSettings(CreateTerrainBuildContext(), metadata);
    }

    private LoadedWorldData ReconstructWorldData(Dictionary<string, object> raw)
    {
        return TileLoaderWorldDataUtility.ReconstructWorldData(raw);
    }

    private string ResolveWorldDataFilePath(string configuredPath)
    {
        return TileLoaderWorldDataUtility.ResolveWorldDataFilePath(configuredPath);
    }
}
