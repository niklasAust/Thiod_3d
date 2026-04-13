using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
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
public sealed partial class TileLoader : MonoBehaviour
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
    private const int PlayerCentricSurfaceCacheVersion = 2;

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
    [SerializeField, Range(0f, 0.49f)] private float dynamicLoadPreloadFraction = 0.22f;
    [SerializeField, Range(0f, 0.2f)] private float dynamicLoadHysteresisFraction = 0.08f;
    [SerializeField] private bool reuseOverlappingDynamicNeighborhoodTiles = true;
    [SerializeField, Min(0f)] private float retiredTerrainColliderGraceSeconds = 1.0f;

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

    [Header("Player-Centric Surface Vegetation")]
    [SerializeField] private bool playerCentricSurfaceVegetationEnabled = true;
    [SerializeField, Min(0f)] private float playerCentricSurfaceRadiusMeters = 80f;
    [SerializeField, Min(0f)] private float playerCentricSurfaceHysteresisMeters = 16f;
    [SerializeField, Min(1f)] private float playerCentricSurfaceCellSizeMeters = 16f;
    [SerializeField, Min(0.01f)] private float playerCentricSurfaceUpdateIntervalSeconds = 0.05f;

    [Header("Runtime Load Smoothing")]
    [SerializeField, Min(1)] private int worldgenWorkerCount = 4;
    [SerializeField, Min(0.25f)] private float runtimeGlobalBudgetMsPerFrame = 12f;
    [SerializeField, Min(0.25f)] private float terrainCreationBudgetMsPerFrame = 6f;
    [SerializeField, Min(0.25f)] private float terrainSeamBudgetMsPerFrame = 4f;
    [SerializeField, Min(0.25f)] private float terrainShadingBudgetMsPerFrame = 4f;
    [FormerlySerializedAs("spreadVegetationInstancingAcrossFrames")]
    [SerializeField] private bool spreadVegetationPlacementAcrossFrames = true;
    [FormerlySerializedAs("vegetationInstancingFrameBudgetMilliseconds")]
    [SerializeField, Min(0.25f)] private float vegetationPlacementBudgetMsPerFrame = 12f;
    [SerializeField, Min(0.25f)] private float playerCentricSurfaceBuildBudgetMsPerFrame = 4f;
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
    private readonly Dictionary<string, GameObject?> prefabCache = new(StringComparer.OrdinalIgnoreCase);
    private readonly Dictionary<string, TileLoaderInstancedVegetationPrototype?> vegetationPrototypeCache = new(StringComparer.OrdinalIgnoreCase);
    private readonly HashSet<string> loggedMissingPrefabPaths = new(StringComparer.OrdinalIgnoreCase);
    private readonly Dictionary<string, int> missingPrefabSkipCounts = new(StringComparer.OrdinalIgnoreCase);
    private TerrainSceneFacade? terrainSceneFacade;
    private GeneratedTerrainBatchCacheEntry? cachedTerrainBatch;
    private int activeGenerationPipelineId;
    private Material? cachedRiverWaterMaterial;
    private string? cachedRiverWaterMaterialPath;
    private TileLoaderRuntime? runtime;
    private TerrainStreamingPipeline? terrainStreamingPipeline;
    private VegetationStreamingController? vegetationStreamingController;
    private PlayerCentricSurfaceController? playerCentricSurfaceController;
    private GenerationReporter? generationReporter;
    private TileLoaderFrameBudgetCoordinator? runtimeFrameBudgetCoordinator;
    private readonly List<TileLoaderInstancedVegetationRenderer> scheduledInteractiveVegetationRenderers = new();
    private readonly HashSet<TileLoaderInstancedVegetationRenderer> scheduledInteractiveVegetationRendererSet = new();
    private int nextScheduledInteractiveVegetationRendererIndex;
    private int lastCompletedGenerationPipelineId;
    private Vector3Int? lastCompletedRuntimeNeighborhoodCenterTileCoordinate;
    private bool terrainPhaseLoadInProgress;
    private Coroutine? activeTerrainLoadCoroutine;
    private TileLoaderTerrainSampler? cachedTerrainSampler;
    private Vector3Int? activeLoadedUnityTileCoordinate;
    private Vector3Int? activeRuntimeRequestedTileCoordinate;
    private Vector3? lastVegetationStreamingTargetWorldPosition;
    private readonly Dictionary<Vector2Int, VegetationTileStreamingStatus> runtimeVegetationTileStatusByCoordinate = new();
    private static readonly Dictionary<string, CachedLoadedWorldData> LoadedWorldDataCache = new(StringComparer.OrdinalIgnoreCase);
    private static readonly ProfilerMarker BatchWorldgenMarker = new("TileLoader.BatchWorldgen");
    private static readonly ProfilerMarker TerrainCreationMarker = new("TileLoader.TerrainCreation");
    private static readonly ProfilerMarker TerrainSeamsMarker = new("TileLoader.TerrainSeams");
    private static readonly ProfilerMarker TerrainShadingMarker = new("TileLoader.TerrainShading");
    private static readonly ProfilerMarker RiverWaterMarker = new("TileLoader.RiverWater");
    private static readonly ProfilerMarker RiverSplineMarker = new("TileLoader.RiverDebugSplines");
    private static readonly ProfilerMarker TerrainCreateDataMarker = new("TileLoader.TerrainCreation.CreateData");
    private static readonly ProfilerMarker TerrainCreateHeightPixelsMarker = new("TileLoader.TerrainCreation.BuildHeightPixels");
    private static readonly ProfilerMarker TerrainUploadHeightmapMarker = new("TileLoader.TerrainCreation.UploadHeightmap");
    private static readonly ProfilerMarker TerrainInstantiateMarker = new("TileLoader.TerrainCreation.InstantiateTerrain");
    private static readonly ProfilerMarker TerrainConnectAdjacentMarker = new("TileLoader.TerrainSeams.ConnectAdjacentTiles");
    private static readonly ProfilerMarker VegetationInteractionSchedulerMarker = new("TileLoader.VegetationInteractionScheduler");

    private TerrainSceneFacade TerrainScene => terrainSceneFacade ??= new TerrainSceneFacade(this);
    private Transform? activeGeneratedTerrainRoot
    {
        get => TerrainScene.ActiveGeneratedTerrainRoot;
        set => TerrainScene.ActiveGeneratedTerrainRoot = value;
    }
    private string? activeTerrainTileCacheSignature
    {
        get => TerrainScene.ActiveTerrainTileCacheSignature;
        set => TerrainScene.ActiveTerrainTileCacheSignature = value;
    }
    private Dictionary<Vector2Int, GeneratedTerrainTileData> activeTerrainTileCache => TerrainScene.ActiveTerrainTileCache;
    private static readonly ProfilerMarker VegetationPlacementMarker = new("TileLoader.VegetationPlacement");
    private static readonly ProfilerMarker VegetationRenderMarker = new("TileLoader.VegetationRender");

    private void OnEnable()
    {
        runtime ??= new TileLoaderRuntime(this);
        runtime.OnEnable();
    }

    private void Start()
    {
        runtime ??= new TileLoaderRuntime(this);
        runtime.Start();
    }

    private void OnDisable()
    {
        runtime?.OnDisable();
    }

    private void Update()
    {
        runtime ??= new TileLoaderRuntime(this);
        runtime.Update();
    }

    internal bool DynamicTileLoadingEnabled => dynamicTileLoadingEnabled;
    internal bool LogGenerationPhaseTimingsEnabledInternal => logGenerationPhaseTimings;
    internal bool LogVegetationPlacementWorkItemsEnabledInternal => logVegetationPlacementWorkItems;
    internal bool ReuseOverlappingDynamicNeighborhoodTilesInternal => reuseOverlappingDynamicNeighborhoodTiles;
    internal float DynamicLoadCheckIntervalSeconds => dynamicLoadCheckIntervalSeconds;
    internal float DynamicLoadPreloadFraction => dynamicLoadPreloadFraction;
    internal float DynamicLoadHysteresisFraction => dynamicLoadHysteresisFraction;
    internal float RetiredTerrainColliderGraceSecondsInternal => retiredTerrainColliderGraceSeconds;
    internal bool IsPlayingInternal => Application.isPlaying;
    internal Transform? DynamicLoadTargetOverride => dynamicLoadTargetOverride;
    internal Vector3Int UnityTileCoordinate
    {
        get => unityTileCoordinate;
        set => unityTileCoordinate = value;
    }
    internal string GeneratedTerrainNameInternal => generatedTerrainName;
    internal string GeneratedTerrainBatchRootNamePrefixInternal => GeneratedTerrainBatchRootNamePrefix;
    internal Transform? ActiveGeneratedTerrainRootInternal => activeGeneratedTerrainRoot;
    internal string? ActiveTerrainTileCacheSignatureInternal => activeTerrainTileCacheSignature;
    internal Dictionary<Vector2Int, GeneratedTerrainTileData> ActiveTerrainTileCacheInternal => activeTerrainTileCache;
    internal Vector3Int? ActiveLoadedUnityTileCoordinate => activeLoadedUnityTileCoordinate;
    internal Vector3Int? ActiveRuntimeRequestedTileCoordinate => activeRuntimeRequestedTileCoordinate;
    internal bool IsTerrainPhaseLoadInProgress => terrainPhaseLoadInProgress;
    internal float TerrainWidthInternal => terrainWidth;
    internal float TerrainLengthInternal => terrainLength;
    internal bool LoadOnEnableInEditModeInternal => loadOnEnableInEditMode;
    internal bool LoadOnStartInPlayModeInternal => loadOnStartInPlayMode;
    internal bool OptimizeConifersByDistanceInternal => optimizeConifersByDistance;
    internal float ConiferOptimizationIntervalInternal => coniferOptimizationInterval;
    internal bool PlayerCentricSurfaceVegetationEnabledInternal => playerCentricSurfaceVegetationEnabled;
    internal float PlayerCentricSurfaceRadiusMetersInternal => playerCentricSurfaceRadiusMeters;
    internal float PlayerCentricSurfaceHysteresisMetersInternal => playerCentricSurfaceHysteresisMeters;
    internal float PlayerCentricSurfaceCellSizeMetersInternal => playerCentricSurfaceCellSizeMeters;
    internal float PlayerCentricSurfaceUpdateIntervalSecondsInternal => playerCentricSurfaceUpdateIntervalSeconds;
    internal float PlayerCentricSurfaceBuildBudgetMsPerFrameInternal => playerCentricSurfaceBuildBudgetMsPerFrame;
    internal float PrototypeInitBudgetMsPerFrameInternal => prototypeInitBudgetMsPerFrame;
    internal float VegetationInteractionRadiusMetersInternal => vegetationInteractionRadiusMeters;
    internal float VegetationInteractionHysteresisMetersInternal => vegetationInteractionHysteresisMeters;
    internal float SurfaceObjectVerticalOffsetInternal => surfaceObjectVerticalOffset;
    internal int PlayerCentricSurfaceCacheVersionInternal => PlayerCentricSurfaceCacheVersion;
    internal VegetationLoadMode VegetationLoadModeInternal => vegetationLoadMode;
    internal float TerrainCreationBudgetMsPerFrameInternal => terrainCreationBudgetMsPerFrame;
    internal float TerrainSeamBudgetMsPerFrameInternal => terrainSeamBudgetMsPerFrame;
    internal float TerrainShadingBudgetMsPerFrameInternal => terrainShadingBudgetMsPerFrame;
    internal float RuntimeGlobalBudgetMsPerFrameInternal => runtimeGlobalBudgetMsPerFrame;
    internal int LastCompletedGenerationPipelineIdInternal
    {
        get => lastCompletedGenerationPipelineId;
        set => lastCompletedGenerationPipelineId = value;
    }
    internal Vector3Int? LastCompletedRuntimeNeighborhoodCenterTileCoordinateInternal
    {
        get => lastCompletedRuntimeNeighborhoodCenterTileCoordinate;
        set => lastCompletedRuntimeNeighborhoodCenterTileCoordinate = value;
    }
    internal Vector3? LastVegetationStreamingTargetWorldPositionInternal
    {
        get => lastVegetationStreamingTargetWorldPosition;
        set => lastVegetationStreamingTargetWorldPosition = value;
    }
    internal bool ConiferOptimizationWasActive
    {
        get => coniferOptimizationWasActive;
        set => coniferOptimizationWasActive = value;
    }
    internal float NextConiferOptimizationTime
    {
        get => nextConiferOptimizationTime;
        set => nextConiferOptimizationTime = value;
    }

    internal int ActiveGenerationPipelineIdInternal => activeGenerationPipelineId;
    internal bool TerrainPhaseLoadInProgressInternal
    {
        get => terrainPhaseLoadInProgress;
        set => terrainPhaseLoadInProgress = value;
    }
    internal Coroutine? ActiveTerrainLoadCoroutineInternal
    {
        get => activeTerrainLoadCoroutine;
        set => activeTerrainLoadCoroutine = value;
    }
    internal Coroutine? ActiveVegetationPopulationCoroutineInternal => VegetationController.ActiveVegetationPopulationCoroutine;
    internal Vector3Int? ActiveRuntimeRequestedTileCoordinateInternal
    {
        get => activeRuntimeRequestedTileCoordinate;
        set => activeRuntimeRequestedTileCoordinate = value;
    }
    internal Vector3Int? TileGateBlockedUnityTileCoordinateInternal => runtime?.BlockedDynamicUnityTileCoordinateInternal;
    internal GeneratedTerrainBatchCacheEntry? CachedTerrainBatchInternal
    {
        get => cachedTerrainBatch;
        set => cachedTerrainBatch = value;
    }
    internal TerrainStreamingPipeline TerrainPipeline => terrainStreamingPipeline ??= new TerrainStreamingPipeline(this);
    internal VegetationStreamingController VegetationController => vegetationStreamingController ??= new VegetationStreamingController(this);
    internal PlayerCentricSurfaceController SurfaceController => playerCentricSurfaceController ??= new PlayerCentricSurfaceController(this);
    internal GenerationReporter Reporter => generationReporter ??= new GenerationReporter(this);
    internal TileLoaderFrameBudgetCoordinator RuntimeFrameBudgetCoordinator => runtimeFrameBudgetCoordinator ??= new TileLoaderFrameBudgetCoordinator();
    internal bool IsRuntimeVegetationTileSettledInternal(Vector2Int tileCoordinate)
        => runtimeVegetationTileStatusByCoordinate.TryGetValue(tileCoordinate, out VegetationTileStreamingStatus status) &&
           status == VegetationTileStreamingStatus.Settled;
    internal void MarkRuntimeVegetationTilePendingInternal(Vector2Int tileCoordinate)
        => MarkRuntimeVegetationTileStatus(tileCoordinate, VegetationTileStreamingStatus.Pending, preserveSettled: true);
    internal void MarkRuntimeVegetationTileSettledInternal(Vector2Int tileCoordinate)
        => MarkRuntimeVegetationTileStatus(tileCoordinate, VegetationTileStreamingStatus.Settled, preserveSettled: false);
    internal void SyncRuntimeVegetationTileStatusesInternal(IEnumerable<Vector2Int> activeTileCoordinates, bool preserveExistingStatuses)
        => SyncRuntimeVegetationTileStatuses(activeTileCoordinates, preserveExistingStatuses);
    internal void ClearRuntimeVegetationTileStatusesInternal() => runtimeVegetationTileStatusByCoordinate.Clear();

    internal void ResetRuntimeLifecycleState()
    {
        hasLoadedInCurrentEnableCycle = false;
        cachedTerrainSampler = null;
        lastVegetationStreamingTargetWorldPosition = null;
        lastCompletedRuntimeNeighborhoodCenterTileCoordinate = null;
        runtimeVegetationTileStatusByCoordinate.Clear();
        terrainSceneFacade ??= new TerrainSceneFacade(this);
        terrainStreamingPipeline ??= new TerrainStreamingPipeline(this);
        vegetationStreamingController ??= new VegetationStreamingController(this);
        playerCentricSurfaceController ??= new PlayerCentricSurfaceController(this);
        generationReporter ??= new GenerationReporter(this);
        runtimeFrameBudgetCoordinator ??= new TileLoaderFrameBudgetCoordinator();
        runtimeFrameBudgetCoordinator.Reset();
        playerCentricSurfaceController.ResetState();
    }

    internal void ResetRuntimeStreamingStateOnDisable()
    {
        terrainPhaseLoadInProgress = false;
        cachedTerrainSampler = null;
        activeRuntimeRequestedTileCoordinate = null;
        lastCompletedRuntimeNeighborhoodCenterTileCoordinate = null;
        runtimeVegetationTileStatusByCoordinate.Clear();
        runtimeFrameBudgetCoordinator?.Reset();
        playerCentricSurfaceController?.ResetState();
    }

    internal bool ShouldLoadOnEnableInEditModeInternal() => ShouldLoadOnEnableInEditMode();
    internal bool HasGeneratedTerrainsInternal() => HasGeneratedTerrains();
    internal bool UsesLegacyVegetationObjectsInternal() => UsesLegacyVegetationObjects();
    internal bool PlaceTreeObjectsInternal => placeTreeObjects;
    internal bool PlaceSurfaceObjectsInternal => placeSurfaceObjects;
    internal bool UsesBatchNeighborhoodLoadingInternal() => UsesBatchNeighborhoodLoading();
    internal void RegisterExistingGeneratedTreeObjectsInternal() => RegisterExistingGeneratedTreeObjects();
    internal void AlignExistingGeneratedSurfaceObjectsInternal() => AlignExistingGeneratedSurfaceObjects();
    internal void ScheduleRuntimeTerrainSeamRebuildInternal() => ScheduleRuntimeTerrainSeamRebuild();
    internal void ScheduleEditorTerrainSeamRebuildInternal()
    {
#if UNITY_EDITOR
        ScheduleEditorTerrainSeamRebuild();
#endif
    }
    internal void UpdateConiferOptimizationInternal(bool forceFullIfNoTarget = false) => UpdateConiferOptimization(forceFullIfNoTarget);
    internal void ApplyConiferOptimizationToAllInternal(ConiferOptimizationTier tier) => ApplyConiferOptimizationToAll(tier);
    internal void UpdatePlayerCentricSurfaceVegetationInternal(bool forceImmediate) => UpdatePlayerCentricSurfaceVegetation(forceImmediate);
    internal void CleanupRetiredTerrainContainersInternal() => CleanupRetiredTerrainContainers();
    internal void CancelActiveVegetationPopulationInternal() => CancelActiveVegetationPopulation();
    internal void ClearGeneratedTerrainsInternal() => ClearGeneratedTerrains();
    internal void DestroyGeneratedTerrainContainerInternal(Transform? container) => DestroyGeneratedTerrainContainer(container);
    internal Coroutine StartRuntimeCoroutine(IEnumerator routine) => StartCoroutine(routine);
    internal void StopRuntimeCoroutineInternal(Coroutine? routine)
    {
        if (routine != null)
        {
            StopCoroutine(routine);
        }
    }
    internal bool ShouldYieldAfterRuntimeChunk(Stopwatch chunkStopwatch, float localBudgetMilliseconds, double minimumBudgetMilliseconds = 0.25d)
        => RuntimeFrameBudgetCoordinator.ShouldYield(runtimeGlobalBudgetMsPerFrame, localBudgetMilliseconds, chunkStopwatch, minimumBudgetMilliseconds);
    internal void CommitRuntimeChunk(Stopwatch chunkStopwatch) => RuntimeFrameBudgetCoordinator.Commit(chunkStopwatch);
    internal void RestartRuntimeChunkStopwatch(Stopwatch chunkStopwatch) => RuntimeFrameBudgetCoordinator.RestartChunk(chunkStopwatch);
    internal float ResolveRuntimePhaseBudgetMsInternal(float localBudgetMilliseconds)
        => ResolveRuntimePhaseBudgetMs(localBudgetMilliseconds);
    internal void RegisterInstancedVegetationRendererInternal(TileLoaderInstancedVegetationRenderer renderer)
        => RegisterInstancedVegetationRenderer(renderer);
    internal void UnregisterInstancedVegetationRendererInternal(TileLoaderInstancedVegetationRenderer renderer)
        => UnregisterInstancedVegetationRenderer(renderer);
    internal void UpdateScheduledInstancedVegetationInteractionsInternal()
        => UpdateScheduledInstancedVegetationInteractions();
    internal int BeginTerrainGenerationPipelineInternal() => ++activeGenerationPipelineId;
    internal void ResetGeneratedRuntimeArtifactsInternal()
    {
        generatedConiferInstances.Clear();
        generatedTerrainShadingMetadata.Clear();
        nextConiferOptimizationTime = 0f;
    }
    internal string GetTerrainBatchWorldgenPhaseNameInternal() => UsesBatchNeighborhoodLoading() ? "3x3 batch worldgen" : "tile worldgen";
    internal TileLoaderBatchPlanner CreateBatchPlannerInternal() => CreateBatchPlanner();
    internal GeneratedTerrainBatchState MeasureBatchWorldgenInternal(
        TileGenerator tileGenerator,
        LoadedWorldData loadedWorldData,
        GenerationSettings settings,
        int pipelineId)
        => MeasureGenerationPhase(
            BatchWorldgenMarker,
            GetTerrainBatchWorldgenPhaseNameInternal(),
            () => BuildGeneratedTerrainBatchState(tileGenerator, loadedWorldData, settings, pipelineId));
    internal GeneratedTerrainBatchState BuildGeneratedTerrainBatchStateInternal(
        TileGenerator tileGenerator,
        LoadedWorldData loadedWorldData,
        GenerationSettings settings,
        int pipelineId)
        => BuildGeneratedTerrainBatchState(tileGenerator, loadedWorldData, settings, pipelineId);
    internal void MeasureTerrainCreationPhaseInternal(GeneratedTerrainBatchState batchState, Action action)
        => MeasureGenerationPhase(batchState, TerrainCreationMarker, "terrain creation", action);
    internal void MeasureTerrainSeamsPhaseInternal(GeneratedTerrainBatchState batchState, Action action)
        => MeasureGenerationPhase(batchState, TerrainSeamsMarker, "terrain seams", action);
    internal void MeasureTerrainShadingPhaseInternal(GeneratedTerrainBatchState batchState, Action action)
        => MeasureGenerationPhase(batchState, TerrainShadingMarker, "terrain shading", action);
    internal void MeasureRiverWaterPhaseInternal(GeneratedTerrainBatchState batchState, Action action)
        => MeasureGenerationPhase(batchState, RiverWaterMarker, "river water", action);
    internal void MeasureRiverSplinePhaseInternal(GeneratedTerrainBatchState batchState, Action action)
        => MeasureGenerationPhase(batchState, RiverSplineMarker, "river debug splines", action);
    internal void MeasureVegetationPlacementPhaseInternal(GeneratedTerrainBatchState batchState, Action action)
        => MeasureGenerationPhase(batchState, VegetationPlacementMarker, "vegetation placement", action);
    internal void MeasureVegetationRenderPhaseInternal(Action action)
        => MeasureGenerationPhase(VegetationRenderMarker, "vegetation GameObject instantiation", action);
    internal bool TryReuseActiveTerrainBatchRootInternal(GeneratedTerrainBatchState batchState) => TryReuseActiveTerrainBatchRoot(batchState);
    internal Transform CreateGeneratedTerrainBatchRootInternal(int pipelineId, Vector3Int centerTileCoordinate)
        => CreateGeneratedTerrainBatchRoot(pipelineId, centerTileCoordinate);
    internal void RecordGenerationPhaseTimingInternal(GeneratedTerrainBatchState? batchState, string phaseName, TimeSpan elapsed)
        => RecordGenerationPhaseTiming(batchState, phaseName, elapsed);
    internal void LogGenerationPhaseTimingInternal(string phaseName, TimeSpan elapsed) => LogGenerationPhaseTiming(phaseName, elapsed);
    internal bool ShouldAbortRuntimeTerrainStreamingInternal(GeneratedTerrainBatchState batchState) => ShouldAbortRuntimeTerrainStreaming(batchState);
    internal void FinalizeTerrainBatchStateInternal(GeneratedTerrainBatchState batchState) => FinalizeTerrainBatchState(batchState);
    internal void PrepareDeferredGenerationTargetsInternal(GeneratedTerrainBatchState batchState) => PrepareDeferredGenerationTargets(batchState);
    internal void PromoteGeneratedTerrainBatchInternal(GeneratedTerrainBatchState batchState) => PromoteGeneratedTerrainBatch(batchState);
    internal void LogGenerationBatchSummaryInternal(GeneratedTerrainBatchState batchState, string stage) => LogGenerationBatchSummary(batchState, stage);
    internal void ReleaseTerrainPhaseAfterAbortedBatchInternal(GeneratedTerrainBatchState batchState) => ReleaseTerrainPhaseAfterAbortedBatch(batchState);
    internal int GetGeneratedTerrainGroupIdInternal() => GetGeneratedTerrainGroupId();
    internal GStylizedTerrain CreateTerrainInternal(
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
        Transform parent)
        => CreateTerrain(
            layers,
            terrainObjectName,
            localPosition,
            unityTileX,
            unityTileY,
            normalizationMinHeight,
            normalizationMaxHeight,
            localMinHeight,
            localMaxHeight,
            tileHilliness,
            terrainGroupId,
            parent);
    internal GTerrainData CreateTerrainDataForRuntimeCreationInternal(
        TileLayers layers,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        double localMaxHeight,
        double tileHilliness)
        => CreateTerrainDataForRuntimeCreation(
            layers,
            normalizationMinHeight,
            normalizationMaxHeight,
            localMaxHeight,
            tileHilliness);
    internal Color[] BuildTerrainHeightPixelsForRuntimeCreationInternal(
        double[,] heightmap,
        double normalizationMinHeight,
        double normalizationMaxHeight)
        => BuildTerrainHeightPixelsForRuntimeCreation(heightmap, normalizationMinHeight, normalizationMaxHeight);
    internal void UploadTerrainHeightPixelsForRuntimeCreationInternal(
        GTerrainData terrainData,
        Color[] heightPixels)
        => UploadTerrainHeightPixelsForRuntimeCreation(terrainData, heightPixels);
    internal void ApplyTerrainHeightmapForRuntimeCreationInternal(
        GTerrainData terrainData,
        double[,] heightmap,
        double normalizationMinHeight,
        double normalizationMaxHeight)
        => ApplyTerrainHeightmapForRuntimeCreation(
            terrainData,
            heightmap,
            normalizationMinHeight,
            normalizationMaxHeight);
    internal GStylizedTerrain FinalizeRuntimeCreatedTerrainInternal(
        TileLayers layers,
        GTerrainData terrainData,
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
        Transform parent)
        => FinalizeRuntimeCreatedTerrain(
            layers,
            terrainData,
            terrainObjectName,
            localPosition,
            unityTileX,
            unityTileY,
            normalizationMinHeight,
            normalizationMaxHeight,
            localMinHeight,
            localMaxHeight,
            tileHilliness,
            terrainGroupId,
            parent);
    internal void ConnectAdjacentTerrainsInternal() => ConnectAdjacentTerrains();
    internal void RebuildTerrainSeamsInternal(GStylizedTerrain terrain, TileLoaderTerrainSeamMask seamMask)
        => RebuildTerrainSeams(terrain, seamMask);
    internal void RebuildTerrainSeamsInternal(IReadOnlyList<GStylizedTerrain> terrains)
        => RebuildTerrainSeams(terrains as List<GStylizedTerrain> ?? new List<GStylizedTerrain>(terrains));
    internal void ApplyTerrainShadingInternal(IReadOnlyList<GStylizedTerrain> terrains) => ApplyTerrainShading(terrains);
    internal IReadOnlyList<GStylizedTerrain> GetTerrainsForStreamingShadingInternal(GeneratedTerrainBatchState batchState)
        => GetTerrainsForStreamingShading(batchState);
    internal List<GeneratedTerrainRequest> GetTerrainCreationRequestsInPriorityOrderInternal(GeneratedTerrainBatchState batchState)
        => GetTerrainCreationRequestsInPriorityOrder(batchState);
    internal void ScheduleDeferredGenerationPhasesInternal(GeneratedTerrainBatchState batchState) => ScheduleDeferredGenerationPhases(batchState);
    internal bool ShouldSpreadVegetationInstancingAcrossFramesInternal(GeneratedTerrainBatchState batchState)
        => ShouldSpreadVegetationInstancingAcrossFrames(batchState);
    internal float VegetationPlacementBudgetMsPerFrameInternal => vegetationPlacementBudgetMsPerFrame;
    internal void ClearGeneratedRiverOutputsInternal(IReadOnlyList<GStylizedTerrain> terrains) => ClearGeneratedRiverOutputs(terrains);
    internal void PopulateRiverWaterForBatchInternal(GeneratedTerrainBatchState batchState)
        => PopulateRiverWater(
            batchState.RiverRefreshRequests,
            batchState.RiverRefreshTerrains,
            batchState.NormalizationMinHeight,
            batchState.NormalizationMaxHeight,
            batchState.RiverSplineCache);
    internal bool PopulateRiverWaterForTerrainInternal(
        GeneratedTerrainRequest request,
        GStylizedTerrain terrain,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        Dictionary<string, Spline> riverSplineCache,
        IDictionary<string, RiverWaterSeamCrossSection> riverWaterSeams)
        => PopulateRiverWaterForTerrain(
            request,
            terrain,
            normalizationMinHeight,
            normalizationMaxHeight,
            riverSplineCache,
            riverWaterSeams);
    internal int GetRiverWaterPathCountInternal(GeneratedTerrainRequest request, GStylizedTerrain terrain)
        => UseRiverBuilder(builder => builder.GetRiverWaterPathCount(request, terrain));
    internal bool PopulateRiverWaterForPathInternal(
        GeneratedTerrainRequest request,
        GStylizedTerrain terrain,
        int riverPathIndex,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        Dictionary<string, Spline> riverSplineCache,
        IDictionary<string, RiverWaterSeamCrossSection> riverWaterSeams)
        => UseRiverBuilder(builder => builder.PopulateRiverWaterForPath(
            request,
            terrain,
            riverPathIndex,
            normalizationMinHeight,
            normalizationMaxHeight,
            riverSplineCache,
            riverWaterSeams,
            this));
    internal void PopulateRiverDebugSplinesForBatchInternal(GeneratedTerrainBatchState batchState)
        => PopulateRiverDebugSplines(
            batchState.RiverRefreshRequests,
            batchState.RiverRefreshTerrains,
            batchState.NormalizationMinHeight,
            batchState.NormalizationMaxHeight,
            batchState.RiverSplineCache);
    internal bool PopulateRiverDebugSplinesForTerrainInternal(
        GeneratedTerrainRequest request,
        GStylizedTerrain terrain,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        Dictionary<string, Spline> riverSplineCache)
        => PopulateRiverDebugSplinesForTerrain(
            request,
            terrain,
            normalizationMinHeight,
            normalizationMaxHeight,
            riverSplineCache);
    internal void PopulateVegetationImmediatelyInternal(GeneratedTerrainBatchState batchState) => PopulateVegetationImmediately(batchState);
    internal void PopulateVegetationImmediatelyViaControllerInternal(GeneratedTerrainBatchState batchState)
        => VegetationController.PopulateVegetationImmediately(batchState);
    internal void EnsurePlayerCentricSurfaceCachesInternal(GeneratedTerrainBatchState batchState, Stopwatch totalStopwatch)
        => EnsurePlayerCentricSurfaceCaches(batchState, totalStopwatch);
    internal IEnumerator EnsurePlayerCentricSurfaceCachesOverMultipleFramesInternal(GeneratedTerrainBatchState batchState, Stopwatch totalStopwatch)
        => EnsurePlayerCentricSurfaceCachesOverMultipleFrames(batchState, totalStopwatch);
    internal List<VegetationWorkItem> PrepareVegetationWorkItemsInternal(GeneratedTerrainBatchState batchState, Stopwatch totalStopwatch)
        => VegetationController.PrepareVegetationWorkItems(batchState, totalStopwatch);
    internal bool ProcessNextVegetationWorkItemPlacementInternal(VegetationWorkItem workItem, Stopwatch totalStopwatch)
        => VegetationController.ProcessNextVegetationWorkItemPlacement(workItem, totalStopwatch);
    internal void FinalizeVegetationWorkItemInternal(VegetationWorkItem workItem, Stopwatch totalStopwatch)
        => VegetationController.FinalizeVegetationWorkItem(workItem, totalStopwatch);
    internal HybridVegetationBuildState? BeginHybridVegetationBuildInternal(
        GeneratedTerrainBatchState? batchState,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        double normalizationMinHeight,
        double normalizationMaxHeight)
        => BeginHybridVegetationBuild(batchState, terrain, request, normalizationMinHeight, normalizationMaxHeight);
    internal List<PreparedVegetationPlacement> PrepareVegetationPlacementsForRequestInternal(
        GeneratedTerrainBatchState batchState,
        Stopwatch totalStopwatch,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request)
        => PrepareVegetationPlacementsForRequest(batchState, totalStopwatch, terrain, request);
    internal void TryLogVegetationWorkQueueSummaryInternal(
        GeneratedTerrainBatchState batchState,
        IReadOnlyList<VegetationWorkItem> workItems)
        => TryLogVegetationWorkQueueSummary(batchState, workItems);
    internal void FinalizeVegetationClearOnlyTerrainsInternal(GeneratedTerrainBatchState batchState)
        => FinalizeVegetationClearOnlyTerrains(batchState);
    internal void DiscardPendingVegetationBuildOutputsInternal(GeneratedTerrainBatchState batchState)
        => DiscardPendingVegetationBuildOutputs(batchState);
    internal void PopulatePlacedObjectsLegacyInternal(
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        double normalizationMinHeight,
        double normalizationMaxHeight)
        => PopulatePlacedObjectsLegacy(terrain, request, normalizationMinHeight, normalizationMaxHeight);
    internal void FinalizeAndLogPendingVegetationTileStatsInternal(GeneratedTerrainBatchState batchState, double elapsedMilliseconds)
        => FinalizeAndLogPendingVegetationTileStats(batchState, elapsedMilliseconds);
    internal Transform? FindVegetationContainerInternal(Transform terrainTransform) => FindVegetationContainer(terrainTransform);
    internal void RetireGeneratedContainerInternal(Transform container) => RetireGeneratedContainer(container);
    internal string GetVegetationBuildContainerNameInternal(int pipelineId) => GetVegetationBuildContainerName(pipelineId);
    internal string GetVegetationContainerNameInternal() => GetVegetationContainerName();
    internal Vector2Int GetTileCoordinateFromBuildRequestInternal(GeneratedTerrainRequest request) => GetTileCoordinate(request);
    internal VegetationTileStreamingStats GetOrCreateVegetationTileStatsInternal(
        GeneratedTerrainBatchState batchState,
        Vector2Int tileCoordinate,
        bool isCenterTile)
        => GetOrCreateVegetationTileStats(batchState, tileCoordinate, isCenterTile);
    internal bool ProcessPreparedHybridVegetationPlacementInternal(VegetationWorkItem workItem, PreparedVegetationPlacement preparedPlacement)
        => ProcessPreparedHybridVegetationPlacement(workItem, preparedPlacement);
    internal double FinalizeHybridVegetationBuildInternal(HybridVegetationBuildState buildState)
        => FinalizeHybridVegetationBuild(buildState);
    internal bool FinalizeVegetationBuildOutputInternal(HybridVegetationBuildState buildState)
        => FinalizeVegetationBuildOutput(buildState);
    internal void TryLogVegetationWorkItemCompletionInternal(
        VegetationWorkItem workItem,
        VegetationTileStreamingStats? tileStats,
        int completedWorkItemCount,
        int visibleInstancedPlacementCount,
        bool rendererFinalizeDeferred,
        bool rendererReady,
        double rendererPrototypeInitMilliseconds)
        => TryLogVegetationWorkItemCompletion(
            workItem,
            tileStats,
            completedWorkItemCount,
            visibleInstancedPlacementCount,
            rendererFinalizeDeferred,
            rendererReady,
            rendererPrototypeInitMilliseconds);
    internal void TryLogSettledVegetationTileInternal(Vector2Int tileCoordinate, VegetationTileStreamingStats tileStats)
        => TryLogSettledVegetationTile(tileCoordinate, tileStats);
    internal void RecordPlacementPhaseTimingInternal(
        GeneratedTerrainBatchState? batchState,
        VegetationTileStreamingStats? tileStats,
        double elapsedMilliseconds,
        VegetationPlacementPhase placementPhase,
        VegetationWorkItem? workItem = null)
        => RecordPlacementPhaseTiming(batchState, tileStats, elapsedMilliseconds, placementPhase, workItem);
    internal void LogCenterTileVegetationReadyInternal(double elapsedMilliseconds)
    {
        if (logGenerationPhaseTimings)
        {
            Debug.Log(
                $"TileLoader center tile vegetation ready in {elapsedMilliseconds.ToString("F1", CultureInfo.InvariantCulture)} ms.",
                this);
        }
    }
    internal ulong ComputeStablePlacementHashInternal(GeneratedTerrainRequest request, TileObjectPlacement placement)
        => ComputeStablePlacementHash(request, placement);
    internal bool TryBuildPreparedPlacementGeometryInternal(
        GeneratedTerrainBatchState batchState,
        VegetationTileStreamingStats? tileStats,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        TileObjectPlacement placement,
        bool isTreePlacement,
        bool enforceCurrentStreamingDistance,
        out PreparedPlacementGeometry geometry)
        => TryBuildPreparedPlacementGeometry(
            batchState,
            tileStats,
            terrain,
            request,
            placement,
            isTreePlacement,
            enforceCurrentStreamingDistance,
            out geometry);
    internal void PopulatePreparedPlacementGeometryNormalsInternal(
        GeneratedTerrainBatchState batchState,
        VegetationTileStreamingStats? tileStats,
        GeneratedTerrainRequest request,
        List<PreparedVegetationPlacement> preparedPlacements)
        => PopulatePreparedPlacementGeometryNormals(batchState, tileStats, request, preparedPlacements);
    internal GameObject? LoadPrefabForPlacementInternal(TileObjectPlacement placement, GeneratedTerrainBatchState? batchState)
        => LoadPrefabForPlacement(placement, batchState);
    internal bool IsTreePlacementInternal(TileObjectPlacement placement, GameObject prefab) => IsTreePlacement(placement, prefab);
    internal bool SupportsHybridPromotionInternal(TileObjectPlacement placement) => SupportsHybridPromotion(placement);
    internal TileLoaderInstancedVegetationPrototype? GetOrCreateVegetationPrototypeInternal(
        GeneratedTerrainBatchState? batchState,
        TileObjectPlacement placement,
        GameObject prefab,
        bool isTreeObject,
        bool supportsPromotion)
        => GetOrCreateVegetationPrototype(batchState, placement, prefab, isTreeObject, supportsPromotion);
    internal bool TrySampleGeneratedTerrainSurfaceInternal(
        GStylizedTerrain terrain,
        float localX,
        float localZ,
        float verticalOffset,
        out Vector3 exactLocalSurfacePoint,
        out Vector3 exactLocalSurfaceNormal)
        => TrySampleGeneratedTerrainSurface(terrain, localX, localZ, verticalOffset, out exactLocalSurfacePoint, out exactLocalSurfaceNormal);
    internal float GetSurfaceObjectOffsetInternal() => GetSurfaceObjectOffset();
    internal void FinishDeferredGenerationPhasesInternal(GeneratedTerrainBatchState batchState) => FinishDeferredGenerationPhases(batchState);
    internal void TryDispatchQueuedDynamicLoadInternal() => TryDispatchQueuedDynamicLoad();
    internal bool TryGetUnityTileCoordinateForWorldPositionInternal(Vector3 worldPosition, out Vector3Int tileCoordinate)
        => TryGetUnityTileCoordinateForWorldPosition(worldPosition, out tileCoordinate);
    internal Vector3? ResolveVegetationStreamingTargetWorldPositionInternal() => ResolveVegetationStreamingTargetWorldPosition();

    internal void StopActiveTerrainLoadCoroutineInternal()
    {
        if (activeTerrainLoadCoroutine == null)
        {
            return;
        }

        StopCoroutine(activeTerrainLoadCoroutine);
        activeTerrainLoadCoroutine = null;
    }

    internal void RunPendingRuntimeSeamRebuildInternal()
    {
        if (!pendingRuntimeSeamRebuild || Time.frameCount < runtimeSeamRebuildFrame)
        {
            return;
        }

        pendingRuntimeSeamRebuild = false;
        RebuildExistingGeneratedTerrainSeams();
    }

    internal HashSet<Vector2Int> GetProtectedRuntimeTileCoordinatesInternal(Vector3Int requestedCenterTileCoordinate)
        => GetProtectedRuntimeTileCoordinates(requestedCenterTileCoordinate);
    internal Vector3 GetTerrainLocalPositionRelativeToBatchCenterInternal(Vector2Int tileCoordinate, Vector3Int centerTileCoordinate)
        => GetTerrainLocalPositionRelativeToBatchCenter(tileCoordinate, centerTileCoordinate);
    internal void LogBatchCenterDriftIfNeededInternal(string stage, GeneratedTerrainBatchState batchState)
        => LogBatchCenterDriftIfNeeded(stage, batchState);
    internal void ValidateReusedTerrainPlacementInternal(
        GeneratedTerrainBatchState batchState,
        GStylizedTerrain terrain,
        Vector2Int expectedTileCoordinate,
        string stage) => ValidateReusedTerrainPlacement(batchState, terrain, expectedTileCoordinate, stage);
    internal void ValidateBatchTerrainOrderingInternal(GeneratedTerrainBatchState batchState, string stage)
        => ValidateBatchTerrainOrdering(batchState, stage);
    internal void RemovePlayerCentricSurfaceCachesOwnedByContainerInternal(Transform container)
        => RemovePlayerCentricSurfaceCachesOwnedByContainer(container);
    internal void PrunePlayerCentricSurfaceTileCachesInternal(IEnumerable<Vector2Int> activeTileCoordinates)
        => PrunePlayerCentricSurfaceTileCaches(activeTileCoordinates);
    internal void SetActiveLoadedUnityTileCoordinateInternal(Vector3Int centerTileCoordinate)
        => activeLoadedUnityTileCoordinate = centerTileCoordinate;
    internal Vector2Int GetTileCoordinateInternal(GeneratedTerrainRequest request) => GetTileCoordinate(request);

    private bool UsesLegacyVegetationObjects()
    {
        return vegetationLoadMode == VegetationLoadMode.LegacyGameObjects;
    }

    private bool ShouldUsePlayerCentricSurfaceVegetation()
    {
        return Application.isPlaying &&
               playerCentricSurfaceVegetationEnabled &&
               placeSurfaceObjects;
    }

    private static bool IsPlayerCentricSurfaceTier(TileObjectStreamingTier streamingTier)
    {
        return streamingTier == TileObjectStreamingTier.Clutter ||
               streamingTier == TileObjectStreamingTier.Ground;
    }

    private void ClearPlayerCentricSurfaceCaches() => SurfaceController.ClearCaches();

    private void PrunePlayerCentricSurfaceTileCaches(IEnumerable<Vector2Int> activeTileCoordinates)
        => SurfaceController.PruneTileCaches(activeTileCoordinates);

    private void RemovePlayerCentricSurfaceCachesOwnedByContainer(Transform container)
        => SurfaceController.RemoveCachesOwnedByContainer(container);

    private void UpdatePlayerCentricSurfaceVegetation(
        bool forceImmediate,
        GeneratedTerrainBatchState? batchState = null,
        Stopwatch? totalStopwatch = null)
        => SurfaceController.UpdateVegetation(forceImmediate, batchState, totalStopwatch);

    private void RegisterInstancedVegetationRenderer(TileLoaderInstancedVegetationRenderer renderer)
    {
        if (renderer == null || !scheduledInteractiveVegetationRendererSet.Add(renderer))
        {
            return;
        }

        scheduledInteractiveVegetationRenderers.Add(renderer);
    }

    private void UnregisterInstancedVegetationRenderer(TileLoaderInstancedVegetationRenderer renderer)
    {
        if (renderer == null || !scheduledInteractiveVegetationRendererSet.Remove(renderer))
        {
            return;
        }

        int index = scheduledInteractiveVegetationRenderers.IndexOf(renderer);
        if (index < 0)
        {
            return;
        }

        scheduledInteractiveVegetationRenderers.RemoveAt(index);
        if (scheduledInteractiveVegetationRenderers.Count == 0)
        {
            nextScheduledInteractiveVegetationRendererIndex = 0;
            return;
        }

        if (nextScheduledInteractiveVegetationRendererIndex > index)
        {
            nextScheduledInteractiveVegetationRendererIndex--;
        }
        else if (nextScheduledInteractiveVegetationRendererIndex >= scheduledInteractiveVegetationRenderers.Count)
        {
            nextScheduledInteractiveVegetationRendererIndex = 0;
        }
    }

    private void UpdateScheduledInstancedVegetationInteractions()
    {
        if (!Application.isPlaying || scheduledInteractiveVegetationRenderers.Count == 0)
        {
            return;
        }

        Vector3? targetWorldPosition = ResolveVegetationStreamingTargetWorldPosition();
        if (!targetWorldPosition.HasValue)
        {
            return;
        }

        const float interactionBudgetMilliseconds = 4f;
        const int maxChildSnapGroupsPerFrame = 4;
        float localBudgetMilliseconds = Math.Min(Math.Max(0.1f, runtimeGlobalBudgetMsPerFrame), interactionBudgetMilliseconds);
        var frameStopwatch = Stopwatch.StartNew();
        RestartRuntimeChunkStopwatch(frameStopwatch);
        int remainingChildSnapGroups = maxChildSnapGroupsPerFrame;
        int rendererCount = scheduledInteractiveVegetationRenderers.Count;
        int startIndex = rendererCount > 0
            ? nextScheduledInteractiveVegetationRendererIndex % rendererCount
            : 0;
        int processedRendererCount = 0;
        bool processedAny = false;

        using (VegetationInteractionSchedulerMarker.Auto())
        {
            while (processedRendererCount < rendererCount)
            {
                int rendererIndex = (startIndex + processedRendererCount) % rendererCount;
                TileLoaderInstancedVegetationRenderer renderer = scheduledInteractiveVegetationRenderers[rendererIndex];
                processedRendererCount++;
                if (renderer == null || !renderer.IsScheduledInteractionActive)
                {
                    continue;
                }

                processedAny |= renderer.RunScheduledInteractionStep(
                    targetWorldPosition.Value,
                    Time.unscaledTime,
                    ref remainingChildSnapGroups);
                if (ShouldYieldAfterRuntimeChunk(frameStopwatch, localBudgetMilliseconds, minimumBudgetMilliseconds: 0.1d))
                {
                    break;
                }
            }
        }

        if (rendererCount > 0)
        {
            nextScheduledInteractiveVegetationRendererIndex = (startIndex + processedRendererCount) % rendererCount;
        }

        if (processedAny)
        {
            CommitRuntimeChunk(frameStopwatch);
        }
    }

    private float ResolveRuntimePhaseBudgetMs(float localBudgetMilliseconds)
    {
        float clampedLocalBudget = Mathf.Max(0.25f, localBudgetMilliseconds);
        float clampedGlobalBudget = Mathf.Max(0.25f, runtimeGlobalBudgetMsPerFrame);
        return Mathf.Max(clampedLocalBudget, clampedGlobalBudget);
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
        runtime ??= new TileLoaderRuntime(this);
        return runtime.RefreshDynamicLoadingInternal();
    }

    private void RequestDynamicTileLoad(Vector3Int tileCoordinate, bool forceImmediate = false)
    {
        runtime ??= new TileLoaderRuntime(this);
        runtime.RequestDynamicTileLoadProxy(this, tileCoordinate, forceImmediate);
    }

    private bool TryGetDynamicLoadTargetTileCoordinate(out Vector3Int tileCoordinate)
    {
        return TryGetUnityTileCoordinateForDynamicLoadTarget(out tileCoordinate);
    }

    private bool TryGetDynamicLoadTileCoordinateForWorldPosition(Vector3 worldPosition, out Vector3Int tileCoordinate)
    {
        return TryGetUnityTileCoordinateForWorldPosition(worldPosition, out tileCoordinate);
    }

    private Vector3Int ResolveLatchedDynamicLoadCoordinate(Vector3Int fallbackCoordinate)
    {
        return ResolveCurrentDesiredDynamicNeighborhoodCenter(fallbackCoordinate);
    }

    private static int ResolveDynamicLoadAxisCoordinate(
        int baseTileCoordinate,
        int latchedTargetCoordinate,
        int activeAxisCoordinate,
        float tileCoordinate,
        float deltaTile,
        float preloadFraction,
        float hysteresisFraction)
    {
        float tileProgress = tileCoordinate - Mathf.Floor(tileCoordinate);
        float hysteresis = Mathf.Clamp(hysteresisFraction, 0f, 0.2f);
        float advanceThreshold = Mathf.Clamp01(1f - preloadFraction + hysteresis);
        float retreatThreshold = Mathf.Clamp01(preloadFraction - hysteresis);
        int latchedDelta = latchedTargetCoordinate - baseTileCoordinate;
        int activeDelta = activeAxisCoordinate - baseTileCoordinate;

        if (activeDelta == 1 && tileProgress >= retreatThreshold)
        {
            return baseTileCoordinate + 1;
        }

        if (activeDelta == -1 && tileProgress <= 1f - retreatThreshold)
        {
            return baseTileCoordinate - 1;
        }

        if (latchedDelta == 1 && tileProgress > preloadFraction)
        {
            return tileProgress >= advanceThreshold ? baseTileCoordinate + 1 : baseTileCoordinate;
        }

        if (latchedDelta == -1 && tileProgress < 1f - preloadFraction)
        {
            return tileProgress <= 1f - advanceThreshold ? baseTileCoordinate - 1 : baseTileCoordinate;
        }

        const float movementEpsilon = 0.0005f;
        if (deltaTile >= movementEpsilon && tileProgress >= advanceThreshold)
        {
            return baseTileCoordinate + 1;
        }

        if (deltaTile <= -movementEpsilon && tileProgress <= 1f - advanceThreshold)
        {
            return baseTileCoordinate - 1;
        }

        return baseTileCoordinate;
    }

    private Transform? ResolveDynamicLoadTarget()
    {
        return dynamicLoadTargetOverride;
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
        runtime ??= new TileLoaderRuntime(this);
        runtime.TryDispatchQueuedDynamicLoad();
    }

    private IEnumerator DispatchQueuedDynamicLoadNextFrame()
    {
        yield break;
    }

    private void EnqueueDynamicTileLoadRequest(Vector3Int tileCoordinate)
    {
        RequestDynamicTileLoad(tileCoordinate);
    }

    private void PruneQueuedDynamicLoadRequests(Vector3Int preferredTileCoordinate)
    {
    }

    private bool TryResolveBestQueuedDynamicTileCoordinate(out Vector3Int tileCoordinate)
    {
        tileCoordinate = ResolveCurrentDesiredDynamicNeighborhoodCenter(unityTileCoordinate);
        return false;
    }

    private int CompareQueuedDynamicTilePriority(
        Vector3Int left,
        Vector3Int right,
        Vector3Int playerTileCoordinate,
        Vector3Int preferredTileCoordinate)
    {
        int leftPriority = ScoreQueuedDynamicTilePriority(left, playerTileCoordinate, preferredTileCoordinate);
        int rightPriority = ScoreQueuedDynamicTilePriority(right, playerTileCoordinate, preferredTileCoordinate);
        if (leftPriority != rightPriority)
        {
            return leftPriority.CompareTo(rightPriority);
        }

        int preferredDistanceComparison =
            GetDynamicTileDistance(left, preferredTileCoordinate).CompareTo(GetDynamicTileDistance(right, preferredTileCoordinate));
        if (preferredDistanceComparison != 0)
        {
            return preferredDistanceComparison;
        }

        return GetDynamicTileDistance(left, playerTileCoordinate).CompareTo(GetDynamicTileDistance(right, playerTileCoordinate));
    }

    private int ScoreQueuedDynamicTilePriority(
        Vector3Int candidate,
        Vector3Int playerTileCoordinate,
        Vector3Int preferredTileCoordinate)
    {
        if (candidate == playerTileCoordinate)
        {
            return 0;
        }

        Vector3Int preferredDelta = new Vector3Int(
            Math.Sign(preferredTileCoordinate.x - playerTileCoordinate.x),
            Math.Sign(preferredTileCoordinate.y - playerTileCoordinate.y),
            0);
        if (preferredDelta.x != 0 || preferredDelta.y != 0)
        {
            Vector3Int frontierCoordinate = new(
                playerTileCoordinate.x + preferredDelta.x,
                playerTileCoordinate.y + preferredDelta.y,
                playerTileCoordinate.z);
            if (candidate == frontierCoordinate)
            {
                return 1;
            }
        }

        int score = 10 + GetDynamicTileDistance(candidate, preferredTileCoordinate) * 2;
        score += GetDynamicTileDistance(candidate, playerTileCoordinate);
        if (preferredDelta.x != 0 || preferredDelta.y != 0)
        {
            int candidateDeltaX = candidate.x - playerTileCoordinate.x;
            int candidateDeltaY = candidate.y - playerTileCoordinate.y;
            if ((preferredDelta.x != 0 && Math.Sign(candidateDeltaX) == -preferredDelta.x) ||
                (preferredDelta.y != 0 && Math.Sign(candidateDeltaY) == -preferredDelta.y))
            {
                score += 20;
            }
        }

        return score;
    }

    private static int GetDynamicTileDistance(Vector3Int left, Vector3Int right)
    {
        return Math.Abs(left.x - right.x) + Math.Abs(left.y - right.y);
    }

    private Vector3Int ResolveCurrentDesiredDynamicNeighborhoodCenter(Vector3Int fallbackTileCoordinate)
    {
        runtime ??= new TileLoaderRuntime(this);
        return runtime.ResolveCurrentDesiredDynamicNeighborhoodCenter(fallbackTileCoordinate);
    }

    private int GetDynamicLoadNeighborhoodRadiusInTiles()
    {
        return UsesBatchNeighborhoodLoading() ? 1 : 0;
    }

    private bool IsTileCoordinateWithinDynamicNeighborhood(Vector3Int tileCoordinate, Vector3Int centerTileCoordinate)
    {
        runtime ??= new TileLoaderRuntime(this);
        return runtime.IsTileCoordinateWithinDynamicNeighborhood(tileCoordinate, centerTileCoordinate);
    }

    private bool IsRuntimeBatchStillRelevant(GeneratedTerrainBatchState batchState)
    {
        Vector3Int desiredCenterTileCoordinate = ResolveCurrentDesiredDynamicNeighborhoodCenter(batchState.CenterTileCoordinate);
        return IsTileCoordinateWithinDynamicNeighborhood(batchState.CenterTileCoordinate, desiredCenterTileCoordinate);
    }

    internal void InvalidateActiveRuntimeTerrainLoadIfStale(Vector3Int desiredCenterTileCoordinate)
    {
        if (!terrainPhaseLoadInProgress ||
            activeTerrainLoadCoroutine == null ||
            !activeRuntimeRequestedTileCoordinate.HasValue)
        {
            return;
        }

        Vector3Int activeRequestedCenter = activeRuntimeRequestedTileCoordinate.Value;
        if (IsTileCoordinateWithinDynamicNeighborhood(activeRequestedCenter, desiredCenterTileCoordinate))
        {
            return;
        }

        int stalePipelineId = activeGenerationPipelineId;
        activeGenerationPipelineId++;
        activeRuntimeRequestedTileCoordinate = desiredCenterTileCoordinate;
        Debug.Log(
            $"TileLoader aborted stale runtime batch pipeline {stalePipelineId} for center {activeRequestedCenter}; current desired center is {desiredCenterTileCoordinate}.",
            this);
    }

    private void CleanupAbortedRuntimeBatch(GeneratedTerrainBatchState batchState)
    {
        TerrainScene.CleanupAbortedRuntimeBatch(batchState);

        if (activeRuntimeRequestedTileCoordinate.HasValue &&
            activeRuntimeRequestedTileCoordinate.Value == batchState.CenterTileCoordinate)
        {
            activeRuntimeRequestedTileCoordinate = null;
        }
    }

    private void ReleaseTerrainPhaseAfterAbortedBatch(GeneratedTerrainBatchState batchState)
    {
        CleanupAbortedRuntimeBatch(batchState);
        if (activeTerrainLoadCoroutine == null && ActiveVegetationPopulationCoroutineInternal == null)
        {
            terrainPhaseLoadInProgress = false;
            TryDispatchQueuedDynamicLoad();
        }
    }

    private bool TryGetUnityTileCoordinateForDynamicLoadTarget(out Vector3Int tileCoordinate)
    {
        runtime ??= new TileLoaderRuntime(this);
        return runtime.TryGetUnityTileCoordinateForDynamicLoadTarget(out tileCoordinate);
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
        => TerrainPipeline.Execute(tileGenerator, loadedWorldData, settings);

    private bool ShouldAbortRuntimeTerrainStreaming(GeneratedTerrainBatchState batchState)
    {
        return this == null ||
               batchState.PipelineId != activeGenerationPipelineId ||
               !IsRuntimeBatchStillRelevant(batchState);
    }

    private IReadOnlyList<GStylizedTerrain> GetTerrainsForStreamingShading(GeneratedTerrainBatchState batchState)
    {
        // Runtime-created terrains are already shaded during CreateTerrain().
        return Array.Empty<GStylizedTerrain>();
    }

    private List<GeneratedTerrainRequest> GetTerrainCreationRequestsInPriorityOrder(GeneratedTerrainBatchState batchState)
    {
        var requests = new List<GeneratedTerrainRequest>(batchState.Requests.Count);
        for (int i = 0; i < batchState.Requests.Count; i++)
        {
            requests.Add(batchState.Requests[i]);
        }

        if (!Application.isPlaying || !dynamicTileLoadingEnabled)
        {
            return requests;
        }

        TryGetUnityTileCoordinateForDynamicLoadTarget(out Vector3Int playerTileCoordinate);
        Vector2Int playerTile = new(playerTileCoordinate.x, playerTileCoordinate.y);
        Vector2Int centerTile = new(batchState.CenterTileCoordinate.x, batchState.CenterTileCoordinate.y);
        Vector2Int preferredFrontier = new(
            playerTile.x + Math.Sign(centerTile.x - playerTile.x),
            playerTile.y + Math.Sign(centerTile.y - playerTile.y));
        requests.Sort((left, right) =>
            CompareTerrainCreationPriority(left, right, playerTile, centerTile, preferredFrontier));
        return requests;
    }

    private int CompareTerrainCreationPriority(
        GeneratedTerrainRequest left,
        GeneratedTerrainRequest right,
        Vector2Int playerTile,
        Vector2Int centerTile,
        Vector2Int preferredFrontier)
    {
        int leftPriority = ScoreTerrainCreationPriority(GetTileCoordinate(left), playerTile, centerTile, preferredFrontier);
        int rightPriority = ScoreTerrainCreationPriority(GetTileCoordinate(right), playerTile, centerTile, preferredFrontier);
        if (leftPriority != rightPriority)
        {
            return leftPriority.CompareTo(rightPriority);
        }

        return GetDynamicTileDistance(
            new Vector3Int(left.UnityTileX, left.UnityTileY, 0),
            new Vector3Int(centerTile.x, centerTile.y, 0))
            .CompareTo(GetDynamicTileDistance(
                new Vector3Int(right.UnityTileX, right.UnityTileY, 0),
                new Vector3Int(centerTile.x, centerTile.y, 0)));
    }

    private static int ScoreTerrainCreationPriority(
        Vector2Int tileCoordinate,
        Vector2Int playerTile,
        Vector2Int centerTile,
        Vector2Int preferredFrontier)
    {
        if (tileCoordinate == playerTile)
        {
            return 0;
        }

        if (tileCoordinate == preferredFrontier)
        {
            return 1;
        }

        if (tileCoordinate == centerTile)
        {
            return 2;
        }

        return 10 + Mathf.Abs(tileCoordinate.x - centerTile.x) + Mathf.Abs(tileCoordinate.y - centerTile.y);
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

    private TileLoaderConfigSnapshot CreateConfigSnapshot()
    {
        return new TileLoaderConfigSnapshot(
            new WorldSourceConfig(
                worldDataFile,
                loadOnEnableInEditMode,
                loadOnStartInPlayMode,
                useMetadataGenerationSettings,
                fallbackTileSize,
                fallbackHillSpacing,
                fallbackHillStrength,
                invertUnityYForWorldGen),
            new DynamicLoadingConfig(
                dynamicTileLoadingEnabled,
                dynamicLoadTargetOverride,
                dynamicLoadCheckIntervalSeconds,
                dynamicLoadPreloadFraction,
                dynamicLoadHysteresisFraction,
                reuseOverlappingDynamicNeighborhoodTiles,
                retiredTerrainColliderGraceSeconds,
                load3x3Neighborhood),
            new TerrainOutputConfig(
                unityTileCoordinate,
                generatedTerrainName,
                terrainWidth,
                terrainLength,
                terrainHeight,
                terrainGridSize),
            new VegetationConfig(
                placeTreeObjects,
                placeSurfaceObjects,
                vegetationLoadMode,
                vegetationInteractionRadiusMeters,
                vegetationInteractionHysteresisMeters,
                generatedVegetationContainerName,
                treeObjectVerticalOffset,
                surfaceObjectVerticalOffset,
                playerCentricSurfaceVegetationEnabled,
                playerCentricSurfaceRadiusMeters,
                playerCentricSurfaceHysteresisMeters,
                playerCentricSurfaceCellSizeMeters,
                playerCentricSurfaceUpdateIntervalSeconds,
                spreadVegetationPlacementAcrossFrames,
                vegetationPlacementBudgetMsPerFrame,
                playerCentricSurfaceBuildBudgetMsPerFrame,
                prototypeInitBudgetMsPerFrame,
                centerTileOnlyNonTreeBudgetFirst,
                highDetailPlacementRadiusMeters,
                midDetailPlacementRadiusMeters,
                highDetailTerrainConformRadiusMeters,
                grassClusterConformSurfaceOffset),
            new RiverConfig(
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
                createRiverWater,
                createRiverDebugSplines,
                generatedRiverWaterContainerName,
                generatedRiverSplineContainerName,
                riverWaterMaterial,
                riverWaterMaterialAssetPath,
                riverWaterWidthMultiplier,
                riverWaterBedClearance,
                riverWaterMeshVerticalOffset,
                riverWaterMeshVerticalOffsetAtNinetyDegrees,
                riverWaterMinimumDownstreamDrop,
                riverWaterSampleStride,
                riverSplineSamplingStep,
                riverSplineAvgElements,
                riverWaterUvLengthScale,
                riverWaterUvWidthScale,
                riverWaterSpeedMultiplier,
                riverWaterMinSegmentLength,
                riverWaterTangentSmoothingRadius),
            new OptimizationConfig(
                optimizeConifersByDistance,
                coniferOptimizationTarget,
                fullConiferDistance,
                reducedConiferDistance,
                lowDetailConiferDistance,
                culledConiferDistance,
                coniferOptimizationInterval,
                disableDistantConiferColliders,
                disableDistantConiferShadows,
                disableDistantConiferDecals),
            new DebugConfig(
                logHeightStats,
                logGenerationPhaseTimings,
                logVegetationPlacementWorkItems));
    }

    private TerrainBuildContext CreateTerrainBuildContext()
    {
        TileLoaderConfigSnapshot config = CreateConfigSnapshot();
        return new TerrainBuildContext(
            config.WorldSource.WorldDataFile,
            config.WorldSource.UseMetadataGenerationSettings,
            config.WorldSource.FallbackTileSize,
            config.WorldSource.FallbackHillSpacing,
            config.WorldSource.FallbackHillStrength,
            config.Terrain.UnityTileCoordinate,
            config.WorldSource.InvertUnityYForWorldGen,
            UsesBatchNeighborhoodLoading(),
            config.DynamicLoading.Enabled,
            config.DynamicLoading.ReuseOverlappingNeighborhoodTiles,
            config.Terrain.Width,
            config.Terrain.Length,
            config.Terrain.Height,
            config.Terrain.GridSize,
            config.Terrain.GeneratedTerrainName,
            config.River.WidthMultiplier,
            config.River.DepthMultiplier,
            config.River.BankDepthMultiplier,
            config.River.CenterDepthMultiplier,
            config.River.CenterDepthMultiplierAtNinetyDegrees,
            config.River.CenterCarveWidthMultiplier,
            config.River.CenterCarveWidthMultiplierAtNinetyDegrees,
            config.River.ProfileMinDropMetersPerTile,
            config.River.ProfileMaxDropMetersPerTile,
            config.River.CorridorDepressionMeters,
            config.River.CorridorMaxSlopeMetersPerSample,
            config.River.CorridorRadiusMultiplier,
            config.River.CorridorMinRadiusSamples,
            config.River.CorridorSmoothingStrength,
            config.River.CorridorSmoothingKernelRadius,
            config.River.CorridorSmoothingPasses,
            config.River.FinalSmoothingStrength,
            config.River.FinalSmoothingKernelRadius,
            config.River.FinalSmoothingPasses,
            config.River.FinalSmoothingRetainedDepthFraction,
            config.River.RiverWaterMeshVerticalOffset,
            config.River.RiverWaterMeshVerticalOffsetAtNinetyDegrees,
            VegetationStreamingPolicyVersion,
            config.Vegetation.PlaceTrees,
            config.Vegetation.PlaceSurfaceObjects);
    }

    private RiverBuildContext CreateRiverBuildContext()
    {
        TileLoaderConfigSnapshot config = CreateConfigSnapshot();
        return new RiverBuildContext(
            config.Terrain.Width,
            config.Terrain.Length,
            config.Terrain.Height,
            config.Terrain.GridSize,
            config.River.WidthMultiplier,
            config.River.DepthMultiplier,
            config.River.BankDepthMultiplier);
    }

    private VegetationBuildContext CreateVegetationBuildContext()
    {
        TileLoaderConfigSnapshot config = CreateConfigSnapshot();
        return new VegetationBuildContext(
            config.Terrain.Width,
            config.Terrain.Length,
            config.Terrain.Height,
            MaxTileHeightUnits,
            config.Vegetation.SurfaceObjectVerticalOffset,
            config.Vegetation.GrassClusterConformSurfaceOffset);
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
        TileLoaderConfigSnapshot config = CreateConfigSnapshot();
        return new ConiferOptimizationContext(
            config.Optimization.FullConiferDistance,
            config.Optimization.ReducedConiferDistance,
            config.Optimization.LowDetailConiferDistance,
            config.Optimization.CulledConiferDistance,
            config.Optimization.DisableDistantConiferColliders,
            config.Optimization.DisableDistantConiferShadows,
            config.Optimization.DisableDistantConiferDecals);
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

    private T UseRiverBuilder<T>(Func<TileLoaderRiverBuilder, T> func)
    {
        TileLoaderRiverSettings settings = CreateRiverSettings();
        try
        {
            return func(CreateRiverBuilder(settings));
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
            activeGeneratedTerrainRoot != null,
            activeLoadedUnityTileCoordinate,
            activeTerrainTileCache,
            activeTerrainTileCacheSignature);
    }

    private void ScheduleDeferredGenerationPhases(GeneratedTerrainBatchState batchState)
        => VegetationController.ScheduleDeferredGenerationPhases(batchState);

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
        => VegetationController.FinishDeferredGenerationPhases(batchState);

    private void CancelActiveVegetationPopulation()
        => VegetationController.CancelActiveVegetationPopulation();

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
        => Reporter.LogGenerationBatchSummary(batchState, stageLabel);

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

    private void FinalizeAndLogPendingVegetationTileStats(GeneratedTerrainBatchState batchState, double fallbackElapsedMilliseconds)
        => Reporter.FinalizeAndLogPendingVegetationTileStats(batchState, fallbackElapsedMilliseconds);

    private void InterruptAndLogPendingVegetationTileStats(GeneratedTerrainBatchState batchState, double interruptedElapsedMilliseconds)
        => Reporter.InterruptAndLogPendingVegetationTileStats(batchState, interruptedElapsedMilliseconds);

    private void TryLogSettledVegetationTile(Vector2Int tileCoordinate, VegetationTileStreamingStats tileStats)
        => Reporter.TryLogSettledVegetationTile(tileCoordinate, tileStats);

    private void TryLogInterruptedVegetationTile(Vector2Int tileCoordinate, VegetationTileStreamingStats tileStats)
        => Reporter.TryLogInterruptedVegetationTile(tileCoordinate, tileStats);

    private void TryLogVegetationWorkQueueSummary(
        GeneratedTerrainBatchState batchState,
        IReadOnlyList<VegetationWorkItem> workItems)
        => Reporter.TryLogVegetationWorkQueueSummary(batchState, workItems);

    private void TryLogVegetationWorkItemCompletion(
        VegetationWorkItem workItem,
        VegetationTileStreamingStats? tileStats,
        int completedWorkItemCount,
        int visibleInstancedPlacementCount,
        bool rendererFinalizeDeferred,
        bool rendererReady,
        double rendererPrototypeInitMilliseconds)
        => Reporter.TryLogVegetationWorkItemCompletion(
            workItem,
            tileStats,
            completedWorkItemCount,
            visibleInstancedPlacementCount,
            rendererFinalizeDeferred,
            rendererReady,
            rendererPrototypeInitMilliseconds);

    private void ClearGeneratedTerrains()
    {
        CancelActiveVegetationPopulation();
        generatedConiferInstances.Clear();
        generatedTerrainShadingMetadata.Clear();
        nextConiferOptimizationTime = 0f;
        ClearPlayerCentricSurfaceCaches();
        lastCompletedGenerationPipelineId = 0;
        lastCompletedRuntimeNeighborhoodCenterTileCoordinate = null;
        runtimeVegetationTileStatusByCoordinate.Clear();
        TerrainScene.ClearGeneratedTerrains();
        activeLoadedUnityTileCoordinate = null;
    }

    private void MarkRuntimeVegetationTileStatus(
        Vector2Int tileCoordinate,
        VegetationTileStreamingStatus status,
        bool preserveSettled)
    {
        if (preserveSettled &&
            runtimeVegetationTileStatusByCoordinate.TryGetValue(tileCoordinate, out VegetationTileStreamingStatus existingStatus) &&
            existingStatus == VegetationTileStreamingStatus.Settled)
        {
            return;
        }

        runtimeVegetationTileStatusByCoordinate[tileCoordinate] = status;
    }

    private void SyncRuntimeVegetationTileStatuses(IEnumerable<Vector2Int> activeTileCoordinates, bool preserveExistingStatuses)
    {
        var activeCoordinates = new HashSet<Vector2Int>(activeTileCoordinates);
        foreach (Vector2Int tileCoordinate in new List<Vector2Int>(runtimeVegetationTileStatusByCoordinate.Keys))
        {
            if (!activeCoordinates.Contains(tileCoordinate))
            {
                runtimeVegetationTileStatusByCoordinate.Remove(tileCoordinate);
            }
        }

        foreach (Vector2Int tileCoordinate in activeCoordinates)
        {
            if (preserveExistingStatuses &&
                runtimeVegetationTileStatusByCoordinate.ContainsKey(tileCoordinate))
            {
                continue;
            }

            runtimeVegetationTileStatusByCoordinate[tileCoordinate] = VegetationTileStreamingStatus.Pending;
        }
    }

    private string GetTerrainObjectName(int offsetX, int offsetY, int unityTileX, int unityTileY)
    {
        if (!UsesBatchNeighborhoodLoading() && offsetX == 0 && offsetY == 0)
        {
            return generatedTerrainName;
        }

        return $"{generatedTerrainName}_{unityTileX}_{unityTileY}";
    }

    private Transform CreateGeneratedTerrainBatchRoot(int pipelineId, Vector3Int centerTileCoordinate)
    {
        return TerrainScene.CreateGeneratedTerrainBatchRoot(pipelineId, centerTileCoordinate);
    }

    private Vector3 GetGeneratedTerrainBatchRootLocalPosition(Vector3Int centerTileCoordinate)
    {
        return TerrainScene.GetGeneratedTerrainBatchRootLocalPosition(centerTileCoordinate);
    }

    private bool TryReuseActiveTerrainBatchRoot(GeneratedTerrainBatchState batchState)
    {
        return TerrainScene.TryReuseActiveTerrainBatchRoot(batchState);
    }

    private HashSet<Vector2Int> GetProtectedRuntimeTileCoordinates(Vector3Int requestedCenterTileCoordinate)
    {
        var protectedCoordinates = new HashSet<Vector2Int>();
        if (!Application.isPlaying || !dynamicTileLoadingEnabled)
        {
            return protectedCoordinates;
        }

        if (!TryGetUnityTileCoordinateForDynamicLoadTarget(out Vector3Int playerTileCoordinate))
        {
            playerTileCoordinate = activeLoadedUnityTileCoordinate ?? requestedCenterTileCoordinate;
        }

        for (int offsetY = -1; offsetY <= 1; offsetY++)
        {
            for (int offsetX = -1; offsetX <= 1; offsetX++)
            {
                protectedCoordinates.Add(new Vector2Int(
                    playerTileCoordinate.x + offsetX,
                    playerTileCoordinate.y + offsetY));
            }
        }

        Vector2Int requestedCenter = new(requestedCenterTileCoordinate.x, requestedCenterTileCoordinate.y);
        Vector2Int playerTile = new(playerTileCoordinate.x, playerTileCoordinate.y);
        Vector2Int forwardTile = new(
            playerTile.x + Math.Sign(requestedCenter.x - playerTile.x),
            playerTile.y + Math.Sign(requestedCenter.y - playerTile.y));
        protectedCoordinates.Add(playerTile);
        protectedCoordinates.Add(forwardTile);
        return protectedCoordinates;
    }

    private Vector3 GetTerrainLocalPositionRelativeToBatchCenter(Vector2Int tileCoordinate, Vector3Int centerTileCoordinate)
    {
        return new Vector3(
            (tileCoordinate.x - centerTileCoordinate.x) * terrainWidth,
            0f,
            (tileCoordinate.y - centerTileCoordinate.y) * terrainLength);
    }

    private void FinalizeTerrainBatchState(GeneratedTerrainBatchState batchState)
    {
        batchState.ActiveTerrains.Clear();
        for (int i = 0; i < batchState.OrderedTileCoordinates.Count; i++)
        {
            Vector2Int tileCoordinate = batchState.OrderedTileCoordinates[i];
            if (batchState.TerrainByCoordinate.TryGetValue(tileCoordinate, out GStylizedTerrain terrain) &&
                terrain != null)
            {
                batchState.ActiveTerrains.Add(terrain);
            }
        }

        ValidateBatchTerrainOrdering(batchState, "finalize terrain batch");
    }

    private void PrepareDeferredGenerationTargets(GeneratedTerrainBatchState batchState)
    {
        batchState.RiverRefreshRequests.Clear();
        batchState.RiverRefreshTerrains.Clear();
        batchState.VegetationRefreshRequests.Clear();
        batchState.VegetationRefreshTerrains.Clear();
        batchState.VegetationStreamingTargetWorldPosition = ResolveVegetationStreamingTargetWorldPosition();

        bool refreshAllTiles =
            batchState.ReusedTerrainCount == 0 ||
            batchState.CreatedRequests.Count == 0 ||
            lastCompletedGenerationPipelineId != batchState.PipelineId - 1;
        bool skipReusedVegetationRefreshForPlayerCentricSurface = ShouldUsePlayerCentricSurfaceVegetation();
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
                for (int i = 0; i < batchState.Requests.Count; i++)
                {
                    Vector2Int tileCoordinate = GetTileCoordinate(batchState.Requests[i]);
                    if (createdTileCoordinates.Contains(tileCoordinate))
                    {
                        continue;
                    }

                    if (!skipReusedVegetationRefreshForPlayerCentricSurface &&
                        ShouldRefreshReusedVegetationTileForStreaming(
                            tileCoordinate,
                            lastVegetationStreamingTargetWorldPosition,
                            batchState.VegetationStreamingTargetWorldPosition))
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

    private bool ShouldRefreshReusedVegetationTileForStreaming(
        Vector2Int tileCoordinate,
        Vector3? previousStreamingTargetWorldPosition,
        Vector3? currentStreamingTargetWorldPosition)
    {
        VegetationTileRadiusState previousState = GetVegetationTileRadiusState(tileCoordinate, previousStreamingTargetWorldPosition);
        VegetationTileRadiusState currentState = GetVegetationTileRadiusState(tileCoordinate, currentStreamingTargetWorldPosition);
        if (previousState.IntersectsHighRadius != currentState.IntersectsHighRadius ||
            previousState.IntersectsMidRadius != currentState.IntersectsMidRadius)
        {
            return true;
        }

        if (!HasVegetationStreamingTargetMovedEnough(
                previousStreamingTargetWorldPosition,
                currentStreamingTargetWorldPosition))
        {
            return false;
        }

        return previousState.IntersectsHighRadius ||
               previousState.IntersectsMidRadius ||
               currentState.IntersectsHighRadius ||
               currentState.IntersectsMidRadius;
    }

    private VegetationTileRadiusState GetVegetationTileRadiusState(Vector2Int tileCoordinate, Vector3? targetWorldPosition)
    {
        if (!targetWorldPosition.HasValue)
        {
            return default;
        }

        return new VegetationTileRadiusState(
            DoesTileIntersectVegetationRadius(tileCoordinate, targetWorldPosition.Value, highDetailPlacementRadiusMeters),
            DoesTileIntersectVegetationRadius(tileCoordinate, targetWorldPosition.Value, midDetailPlacementRadiusMeters));
    }

    private bool DoesTileIntersectVegetationRadius(Vector2Int tileCoordinate, Vector3 targetWorldPosition, float radiusMeters)
    {
        if (radiusMeters <= 0f)
        {
            return false;
        }

        Vector3 localPosition = transform.InverseTransformPoint(targetWorldPosition);
        float minX = tileCoordinate.x * terrainWidth;
        float maxX = minX + terrainWidth;
        float minZ = tileCoordinate.y * terrainLength;
        float maxZ = minZ + terrainLength;
        float deltaX = localPosition.x < minX ? minX - localPosition.x : localPosition.x > maxX ? localPosition.x - maxX : 0f;
        float deltaZ = localPosition.z < minZ ? minZ - localPosition.z : localPosition.z > maxZ ? localPosition.z - maxZ : 0f;
        return deltaX * deltaX + deltaZ * deltaZ <= radiusMeters * radiusMeters;
    }

    private bool HasVegetationStreamingTargetMovedEnough(
        Vector3? previousStreamingTargetWorldPosition,
        Vector3? currentStreamingTargetWorldPosition)
    {
        if (!previousStreamingTargetWorldPosition.HasValue || !currentStreamingTargetWorldPosition.HasValue)
        {
            return false;
        }

        float minimumRefreshDistance = ResolveVegetationStreamingRefreshDistance();
        if (minimumRefreshDistance <= 0f)
        {
            return false;
        }

        return (currentStreamingTargetWorldPosition.Value - previousStreamingTargetWorldPosition.Value).sqrMagnitude >=
               minimumRefreshDistance * minimumRefreshDistance;
    }

    private float ResolveVegetationStreamingRefreshDistance()
    {
        float safeTileExtent = Mathf.Max(1f, Mathf.Min(terrainWidth, terrainLength));
        float nearRadius = Mathf.Max(1f, highDetailPlacementRadiusMeters);
        return Mathf.Max(4f, Mathf.Min(nearRadius * 0.5f, safeTileExtent * 0.2f));
    }

    private readonly struct VegetationTileRadiusState
    {
        public VegetationTileRadiusState(bool intersectsHighRadius, bool intersectsMidRadius)
        {
            IntersectsHighRadius = intersectsHighRadius;
            IntersectsMidRadius = intersectsMidRadius;
        }

        public bool IntersectsHighRadius { get; }
        public bool IntersectsMidRadius { get; }
    }

    private Dictionary<Vector2Int, GStylizedTerrain> GetGeneratedTerrainsByTileCoordinate(
        Transform batchRoot,
        Vector3Int centerTileCoordinate)
        => TerrainScene.GetGeneratedTerrainsByTileCoordinate(batchRoot, centerTileCoordinate);

    private Vector2Int GetTileCoordinate(GeneratedTerrainRequest request)
        => new(request.UnityTileX, request.UnityTileY);

    private Vector2Int GetTileCoordinate(GStylizedTerrain terrain, Vector3Int centerTileCoordinate)
        => TerrainScene.GetTileCoordinate(terrain, centerTileCoordinate);

    private Vector2Int ResolveTerrainTileCoordinate(GStylizedTerrain terrain, Vector3Int centerTileCoordinate)
        => TerrainScene.ResolveTerrainTileCoordinate(terrain, centerTileCoordinate);

    private bool TryGetTileCoordinateFromTerrainName(string terrainName, out Vector2Int tileCoordinate)
        => TerrainScene.TryGetTileCoordinateFromTerrainName(terrainName, out tileCoordinate);

    private void PromoteGeneratedTerrainBatch(GeneratedTerrainBatchState batchState)
    {
        TerrainScene.PromoteGeneratedTerrainBatch(batchState);
    }

    private void LogBatchCenterDriftIfNeeded(string stage, GeneratedTerrainBatchState batchState)
    {
        if (unityTileCoordinate == batchState.CenterTileCoordinate)
        {
            return;
        }

        Debug.LogWarning(
            $"TileLoader detected streaming center drift during {stage}. " +
            $"batchCenter=({batchState.CenterTileCoordinate.x},{batchState.CenterTileCoordinate.y},0), " +
            $"liveTarget=({unityTileCoordinate.x},{unityTileCoordinate.y},0), pipeline={batchState.PipelineId}.",
            this);
    }

    private void ValidateReusedTerrainPlacement(
        GeneratedTerrainBatchState batchState,
        GStylizedTerrain terrain,
        Vector2Int expectedTileCoordinate,
        string stage)
    {
        if (terrain == null)
        {
            return;
        }

        Vector3 expectedLocalPosition = GetTerrainLocalPositionRelativeToBatchCenter(expectedTileCoordinate, batchState.CenterTileCoordinate);
        Vector3 actualLocalPosition = terrain.transform.localPosition;
        if ((actualLocalPosition - expectedLocalPosition).sqrMagnitude > 0.0001f)
        {
            Debug.LogWarning(
                $"TileLoader detected reused terrain position drift during {stage}. " +
                $"tile=({expectedTileCoordinate.x},{expectedTileCoordinate.y}), expectedLocal={expectedLocalPosition}, actualLocal={actualLocalPosition}.",
                terrain);
        }

        Vector2Int resolvedTileCoordinate = ResolveTerrainTileCoordinate(terrain, batchState.CenterTileCoordinate);
        if (resolvedTileCoordinate != expectedTileCoordinate)
        {
            Debug.LogWarning(
                $"TileLoader detected reused terrain coordinate mismatch during {stage}. " +
                $"expected=({expectedTileCoordinate.x},{expectedTileCoordinate.y}), resolved=({resolvedTileCoordinate.x},{resolvedTileCoordinate.y}), name='{terrain.name}'.",
                terrain);
        }
    }

    private void ValidateBatchTerrainOrdering(GeneratedTerrainBatchState batchState, string stage)
    {
        if (batchState.OrderedTileCoordinates.Count == 0)
        {
            return;
        }

        var seenCoordinates = new HashSet<Vector2Int>();
        bool foundCenterTile = false;
        for (int i = 0; i < batchState.OrderedTileCoordinates.Count; i++)
        {
            Vector2Int tileCoordinate = batchState.OrderedTileCoordinates[i];
            if (!seenCoordinates.Add(tileCoordinate))
            {
                Debug.LogWarning(
                    $"TileLoader detected duplicate terrain coordinate during {stage}. " +
                    $"tile=({tileCoordinate.x},{tileCoordinate.y}), pipeline={batchState.PipelineId}.",
                    this);
            }

            if (tileCoordinate == new Vector2Int(batchState.CenterTileCoordinate.x, batchState.CenterTileCoordinate.y))
            {
                foundCenterTile = true;
            }

            if (!batchState.TerrainByCoordinate.TryGetValue(tileCoordinate, out GStylizedTerrain terrain) || terrain == null)
            {
                continue;
            }

            ValidateReusedTerrainPlacement(batchState, terrain, tileCoordinate, stage);
        }

        if (!foundCenterTile)
        {
            Debug.LogWarning(
                $"TileLoader detected a terrain ordering invariant failure during {stage}. " +
                $"missing center tile ({batchState.CenterTileCoordinate.x},{batchState.CenterTileCoordinate.y},0) in ordered coordinates.",
                this);
        }
    }

    private void DestroyAllGeneratedTerrainContainers(Transform? exceptRoot)
    {
        if (exceptRoot == null && activeGeneratedTerrainRoot == null)
        {
            return;
        }
    }

    private void RetireGeneratedTerrainContainers(Transform? exceptRoot)
    {
    }

    private void DestroyGeneratedTerrainContainer(Transform? container)
    {
        TerrainScene.DestroyGeneratedTerrainContainer(container);
    }

    private void RetireGeneratedTerrainContainer(Transform? container)
    {
    }

    private void CleanupRetiredTerrainContainers()
    {
        TerrainScene.CleanupRetiredTerrainContainers();
    }

    private void DestroyRetiredTerrainContainersImmediately()
    {
    }

    private bool IsGeneratedTerrainName(string candidateName)
        => TerrainScene.IsGeneratedTerrainName(candidateName);

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
        GTerrainData terrainData = CreateTerrainDataForRuntimeCreation(
            layers,
            normalizationMinHeight,
            normalizationMaxHeight,
            localMaxHeight,
            tileHilliness);
        ApplyTerrainHeightmapForRuntimeCreation(
            terrainData,
            layers.Heightmap,
            normalizationMinHeight,
            normalizationMaxHeight);
        return FinalizeRuntimeCreatedTerrain(
            layers,
            terrainData,
            terrainObjectName,
            localPosition,
            unityTileX,
            unityTileY,
            normalizationMinHeight,
            normalizationMaxHeight,
            localMinHeight,
            localMaxHeight,
            tileHilliness,
            terrainGroupId,
            parentRoot);
    }

    private GTerrainData CreateTerrainDataForRuntimeCreation(
        TileLayers layers,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        double localMaxHeight,
        double tileHilliness)
    {
        using (TerrainCreateDataMarker.Auto())
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
            return terrainData;
        }
    }

    private Color[] BuildTerrainHeightPixelsForRuntimeCreation(
        double[,] heightmap,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        using (TerrainCreateHeightPixelsMarker.Auto())
        {
            return BuildHeightPixels(heightmap, normalizationMinHeight, normalizationMaxHeight);
        }
    }

    private void UploadTerrainHeightPixelsForRuntimeCreation(
        GTerrainData terrainData,
        Color[] heightPixels)
    {
        using (TerrainUploadHeightmapMarker.Auto())
        {
            Texture2D heightMap = Polaris.GetHeightMap(terrainData);
            heightMap.SetPixels(heightPixels);
            heightMap.Apply(false, false);
        }
    }

    private void ApplyTerrainHeightmapForRuntimeCreation(
        GTerrainData terrainData,
        double[,] heightmap,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        Color[] heightPixels = BuildTerrainHeightPixelsForRuntimeCreation(
            heightmap,
            normalizationMinHeight,
            normalizationMaxHeight);
        UploadTerrainHeightPixelsForRuntimeCreation(terrainData, heightPixels);
    }

    private GStylizedTerrain FinalizeRuntimeCreatedTerrain(
        TileLayers layers,
        GTerrainData terrainData,
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
        using (TerrainInstantiateMarker.Auto())
        {
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

    private void ConnectAdjacentTerrains()
    {
        using (TerrainConnectAdjacentMarker.Auto())
        {
            UseTerrainShadingService(service => service.ConnectAdjacentTerrainTiles());
        }
    }

    private void RebuildTerrainSeams(GStylizedTerrain terrain, TileLoaderTerrainSeamMask seamMask)
    {
        if (terrain == null)
        {
            return;
        }

        UseTerrainShadingService(service => service.RebuildTerrainSeams(terrain, seamMask, this));
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

    private bool PopulateRiverWaterForTerrain(
        GeneratedTerrainRequest request,
        GStylizedTerrain terrain,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        Dictionary<string, Spline> riverSplineCache,
        IDictionary<string, RiverWaterSeamCrossSection> riverWaterSeams)
    {
        return UseRiverBuilder(builder => builder.PopulateRiverWaterForTerrain(
            request,
            terrain,
            normalizationMinHeight,
            normalizationMaxHeight,
            riverSplineCache,
            riverWaterSeams,
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

    private bool PopulateRiverDebugSplinesForTerrain(
        GeneratedTerrainRequest request,
        GStylizedTerrain terrain,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        Dictionary<string, Spline> riverSplineCache)
    {
        return UseRiverBuilder(builder => builder.PopulateRiverDebugSplinesForTerrain(
            request,
            terrain,
            normalizationMinHeight,
            normalizationMaxHeight,
            riverSplineCache));
    }

    private void EnsurePlayerCentricSurfaceCaches(GeneratedTerrainBatchState batchState, Stopwatch totalStopwatch)
        => SurfaceController.EnsureCaches(batchState, totalStopwatch);

    private IEnumerator EnsurePlayerCentricSurfaceCachesOverMultipleFrames(
        GeneratedTerrainBatchState batchState,
        Stopwatch totalStopwatch)
        => SurfaceController.EnsureCachesOverMultipleFrames(batchState, totalStopwatch);

    private void PopulateVegetationImmediately(GeneratedTerrainBatchState batchState)
        => VegetationController.PopulateVegetationImmediately(batchState);

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
            if (ShouldUsePlayerCentricSurfaceVegetation() &&
                IsPlayerCentricSurfaceTier(placement.Definition.StreamingTier))
            {
                continue;
            }

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
            FindVegetationContainer(terrain.transform),
            normalizationMinHeight,
            normalizationMaxHeight);
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

        TileLoaderInstancedDecalProjectorStream decalProjectorStream =
            buildState.VegetationContainer.GetComponent<TileLoaderInstancedDecalProjectorStream>() ??
            buildState.VegetationContainer.gameObject.AddComponent<TileLoaderInstancedDecalProjectorStream>();

        renderer.Initialize(
            buildState.Prototypes,
            buildState.Placements,
            vegetationLoadMode == VegetationLoadMode.HybridInteractive,
            vegetationInteractionRadiusMeters,
            vegetationInteractionHysteresisMeters,
            this,
            prototypeInitBudgetMsPerFrame);
        decalProjectorStream.Initialize(buildState.Prototypes, buildState.Placements);
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
            preparedPlacement.Geometry.UseExactTerrainConformOnPromotion,
            preparedPlacement.Geometry.LocalPosition.x,
            preparedPlacement.Geometry.LocalPosition.z,
            prototype.IsTree ? treeObjectVerticalOffset : surfaceObjectVerticalOffset,
            prototype.IsTree ? 0f : GetSurfaceObjectOffset());
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
        float verticalOffset = isTreeObject ? treeObjectVerticalOffset : surfaceObjectVerticalOffset;
        bool requiresExactTerrainConform = preparedPlacement.Geometry.UseExactTerrainConformOnLoad;

        var positionStopwatch = Stopwatch.StartNew();
        // Distant placements keep the precomputed heightmap position/normal and skip the terrain raycast.
        if (requiresExactTerrainConform &&
            TrySampleGeneratedTerrainSurface(
                buildState.Terrain,
                preparedPlacement.Geometry.LocalPosition.x,
                preparedPlacement.Geometry.LocalPosition.z,
                verticalOffset,
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
        string containerName = GetVegetationContainerName();
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

    private string GetVegetationContainerName()
    {
        return string.IsNullOrWhiteSpace(generatedVegetationContainerName)
            ? "Vegetation"
            : generatedVegetationContainerName.Trim();
    }

    private string GetVegetationBuildContainerName(int pipelineId)
    {
        return GetVegetationContainerName() + "_Build_" + pipelineId.ToString(CultureInfo.InvariantCulture);
    }

    private Transform? FindVegetationContainer(Transform terrainTransform)
    {
        if (terrainTransform == null)
        {
            return null;
        }

        return terrainTransform.Find(GetVegetationContainerName());
    }

    private Transform GetOrCreateVegetationBuildContainer(HybridVegetationBuildState buildState)
    {
        if (buildState.VegetationContainer != null)
        {
            return buildState.VegetationContainer;
        }

        int pipelineId = buildState.BatchState?.PipelineId ?? activeGenerationPipelineId;
        string buildContainerName = GetVegetationBuildContainerName(pipelineId);
        Transform? existing = buildState.Terrain.transform.Find(buildContainerName);
        if (existing != null)
        {
            buildState.VegetationContainer = existing;
            return existing;
        }

        var container = new GameObject(buildContainerName);
        container.transform.SetParent(buildState.Terrain.transform, false);
        container.transform.localPosition = Vector3.zero;
        container.transform.localRotation = Quaternion.identity;
        container.transform.localScale = Vector3.one;
        container.SetActive(buildState.ExistingVegetationContainer == null);
        buildState.VegetationContainer = container.transform;
        return buildState.VegetationContainer;
    }

    private bool FinalizeVegetationBuildOutput(HybridVegetationBuildState buildState)
    {
        if (buildState.HasSwappedVegetationContainer || buildState.VegetationContainer == null)
        {
            return false;
        }

        string canonicalContainerName = GetVegetationContainerName();
        Transform outputContainer = buildState.VegetationContainer;
        bool activatedContainer = !outputContainer.gameObject.activeSelf;
        if (buildState.ExistingVegetationContainer != null &&
            buildState.ExistingVegetationContainer != outputContainer)
        {
            RetireGeneratedContainer(buildState.ExistingVegetationContainer);
        }

        for (int childIndex = buildState.Terrain.transform.childCount - 1; childIndex >= 0; childIndex--)
        {
            Transform child = buildState.Terrain.transform.GetChild(childIndex);
            if (child == null || child == outputContainer)
            {
                continue;
            }

            if (child.name == canonicalContainerName ||
                child.name.StartsWith(canonicalContainerName + "_Build_", StringComparison.Ordinal))
            {
                RetireGeneratedContainer(child);
            }
        }

        outputContainer.name = canonicalContainerName;
        outputContainer.gameObject.SetActive(true);
        buildState.HasSwappedVegetationContainer = true;
        return activatedContainer;
    }

    private void FinalizeVegetationClearOnlyTerrains(GeneratedTerrainBatchState batchState)
        => VegetationController.FinalizeVegetationClearOnlyTerrains(batchState);

    private void DiscardPendingVegetationBuildOutputs(GeneratedTerrainBatchState batchState)
        => VegetationController.DiscardPendingVegetationBuildOutputs(batchState);

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
        var decalSources = new List<TileLoaderInstancedDecalProjectorSource>();
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

        if (isTreeObject)
        {
            DecalProjector[] decalProjectors = prefab.GetComponentsInChildren<DecalProjector>(true);
            for (int projectorIndex = 0; projectorIndex < decalProjectors.Length; projectorIndex++)
            {
                DecalProjector decalProjector = decalProjectors[projectorIndex];
                if (decalProjector == null ||
                    !decalProjector.enabled ||
                    decalProjector.material == null ||
                    decalProjector.gameObject == null ||
                    !decalProjector.gameObject.activeSelf)
                {
                    continue;
                }

                Matrix4x4 localMatrix = rootWorldToLocal * decalProjector.transform.localToWorldMatrix;
                decalSources.Add(new TileLoaderInstancedDecalProjectorSource(
                    decalProjector.gameObject,
                    decalProjector.material,
                    localMatrix,
                    decalProjector.drawDistance));
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
                renderSources,
                decalSources);
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
