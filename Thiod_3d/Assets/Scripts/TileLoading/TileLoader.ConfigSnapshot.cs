using UnityEngine;

#nullable enable

internal sealed class TileLoaderConfigSnapshot
{
    public TileLoaderConfigSnapshot(
        WorldSourceConfig worldSource,
        DynamicLoadingConfig dynamicLoading,
        TerrainOutputConfig terrain,
        VegetationConfig vegetation,
        RiverConfig river,
        OptimizationConfig optimization,
        DebugConfig debug)
    {
        WorldSource = worldSource;
        DynamicLoading = dynamicLoading;
        Terrain = terrain;
        Vegetation = vegetation;
        River = river;
        Optimization = optimization;
        Debug = debug;
    }

    public WorldSourceConfig WorldSource { get; }
    public DynamicLoadingConfig DynamicLoading { get; }
    public TerrainOutputConfig Terrain { get; }
    public VegetationConfig Vegetation { get; }
    public RiverConfig River { get; }
    public OptimizationConfig Optimization { get; }
    public DebugConfig Debug { get; }
}

internal sealed class WorldSourceConfig
{
    public WorldSourceConfig(
        string worldDataFile,
        bool loadOnEnableInEditMode,
        bool loadOnStartInPlayMode,
        bool useMetadataGenerationSettings,
        int fallbackTileSize,
        int fallbackHillSpacing,
        float fallbackHillStrength,
        bool invertUnityYForWorldGen)
    {
        WorldDataFile = worldDataFile;
        LoadOnEnableInEditMode = loadOnEnableInEditMode;
        LoadOnStartInPlayMode = loadOnStartInPlayMode;
        UseMetadataGenerationSettings = useMetadataGenerationSettings;
        FallbackTileSize = fallbackTileSize;
        FallbackHillSpacing = fallbackHillSpacing;
        FallbackHillStrength = fallbackHillStrength;
        InvertUnityYForWorldGen = invertUnityYForWorldGen;
    }

    public string WorldDataFile { get; }
    public bool LoadOnEnableInEditMode { get; }
    public bool LoadOnStartInPlayMode { get; }
    public bool UseMetadataGenerationSettings { get; }
    public int FallbackTileSize { get; }
    public int FallbackHillSpacing { get; }
    public float FallbackHillStrength { get; }
    public bool InvertUnityYForWorldGen { get; }
}

internal sealed class DynamicLoadingConfig
{
    public DynamicLoadingConfig(
        bool enabled,
        Transform? targetOverride,
        float checkIntervalSeconds,
        float preloadFraction,
        float hysteresisFraction,
        bool reuseOverlappingNeighborhoodTiles,
        float retiredTerrainColliderGraceSeconds,
        bool load3x3Neighborhood)
    {
        Enabled = enabled;
        TargetOverride = targetOverride;
        CheckIntervalSeconds = checkIntervalSeconds;
        PreloadFraction = preloadFraction;
        HysteresisFraction = hysteresisFraction;
        ReuseOverlappingNeighborhoodTiles = reuseOverlappingNeighborhoodTiles;
        RetiredTerrainColliderGraceSeconds = retiredTerrainColliderGraceSeconds;
        Load3x3Neighborhood = load3x3Neighborhood;
    }

    public bool Enabled { get; }
    public Transform? TargetOverride { get; }
    public float CheckIntervalSeconds { get; }
    public float PreloadFraction { get; }
    public float HysteresisFraction { get; }
    public bool ReuseOverlappingNeighborhoodTiles { get; }
    public float RetiredTerrainColliderGraceSeconds { get; }
    public bool Load3x3Neighborhood { get; }
}

internal sealed class TerrainOutputConfig
{
    public TerrainOutputConfig(
        Vector3Int unityTileCoordinate,
        string generatedTerrainName,
        float width,
        float length,
        float height,
        int gridSize)
    {
        UnityTileCoordinate = unityTileCoordinate;
        GeneratedTerrainName = generatedTerrainName;
        Width = width;
        Length = length;
        Height = height;
        GridSize = gridSize;
    }

    public Vector3Int UnityTileCoordinate { get; }
    public string GeneratedTerrainName { get; }
    public float Width { get; }
    public float Length { get; }
    public float Height { get; }
    public int GridSize { get; }
}

internal sealed class VegetationConfig
{
    public VegetationConfig(
        bool placeTrees,
        bool placeSurfaceObjects,
        VegetationLoadMode loadMode,
        float interactionRadiusMeters,
        float interactionHysteresisMeters,
        string generatedVegetationContainerName,
        float treeObjectVerticalOffset,
        float surfaceObjectVerticalOffset,
        bool playerCentricSurfaceVegetationEnabled,
        float playerCentricSurfaceRadiusMeters,
        float playerCentricSurfaceHysteresisMeters,
        float playerCentricSurfaceCellSizeMeters,
        float playerCentricSurfaceUpdateIntervalSeconds,
        bool spreadPlacementAcrossFrames,
        float placementBudgetMsPerFrame,
        float playerCentricSurfaceBuildBudgetMsPerFrame,
        float prototypeInitBudgetMsPerFrame,
        bool centerTileOnlyNonTreeBudgetFirst,
        float highDetailPlacementRadiusMeters,
        float midDetailPlacementRadiusMeters,
        float highDetailTerrainConformRadiusMeters,
        float grassClusterConformSurfaceOffset)
    {
        PlaceTrees = placeTrees;
        PlaceSurfaceObjects = placeSurfaceObjects;
        LoadMode = loadMode;
        InteractionRadiusMeters = interactionRadiusMeters;
        InteractionHysteresisMeters = interactionHysteresisMeters;
        GeneratedVegetationContainerName = generatedVegetationContainerName;
        TreeObjectVerticalOffset = treeObjectVerticalOffset;
        SurfaceObjectVerticalOffset = surfaceObjectVerticalOffset;
        PlayerCentricSurfaceVegetationEnabled = playerCentricSurfaceVegetationEnabled;
        PlayerCentricSurfaceRadiusMeters = playerCentricSurfaceRadiusMeters;
        PlayerCentricSurfaceHysteresisMeters = playerCentricSurfaceHysteresisMeters;
        PlayerCentricSurfaceCellSizeMeters = playerCentricSurfaceCellSizeMeters;
        PlayerCentricSurfaceUpdateIntervalSeconds = playerCentricSurfaceUpdateIntervalSeconds;
        SpreadPlacementAcrossFrames = spreadPlacementAcrossFrames;
        PlacementBudgetMsPerFrame = placementBudgetMsPerFrame;
        PlayerCentricSurfaceBuildBudgetMsPerFrame = playerCentricSurfaceBuildBudgetMsPerFrame;
        PrototypeInitBudgetMsPerFrame = prototypeInitBudgetMsPerFrame;
        CenterTileOnlyNonTreeBudgetFirst = centerTileOnlyNonTreeBudgetFirst;
        HighDetailPlacementRadiusMeters = highDetailPlacementRadiusMeters;
        MidDetailPlacementRadiusMeters = midDetailPlacementRadiusMeters;
        HighDetailTerrainConformRadiusMeters = highDetailTerrainConformRadiusMeters;
        GrassClusterConformSurfaceOffset = grassClusterConformSurfaceOffset;
    }

    public bool PlaceTrees { get; }
    public bool PlaceSurfaceObjects { get; }
    public VegetationLoadMode LoadMode { get; }
    public float InteractionRadiusMeters { get; }
    public float InteractionHysteresisMeters { get; }
    public string GeneratedVegetationContainerName { get; }
    public float TreeObjectVerticalOffset { get; }
    public float SurfaceObjectVerticalOffset { get; }
    public bool PlayerCentricSurfaceVegetationEnabled { get; }
    public float PlayerCentricSurfaceRadiusMeters { get; }
    public float PlayerCentricSurfaceHysteresisMeters { get; }
    public float PlayerCentricSurfaceCellSizeMeters { get; }
    public float PlayerCentricSurfaceUpdateIntervalSeconds { get; }
    public bool SpreadPlacementAcrossFrames { get; }
    public float PlacementBudgetMsPerFrame { get; }
    public float PlayerCentricSurfaceBuildBudgetMsPerFrame { get; }
    public float PrototypeInitBudgetMsPerFrame { get; }
    public bool CenterTileOnlyNonTreeBudgetFirst { get; }
    public float HighDetailPlacementRadiusMeters { get; }
    public float MidDetailPlacementRadiusMeters { get; }
    public float HighDetailTerrainConformRadiusMeters { get; }
    public float GrassClusterConformSurfaceOffset { get; }
}

internal sealed class RiverConfig
{
    public RiverConfig(
        float widthMultiplier,
        float depthMultiplier,
        float bankDepthMultiplier,
        float centerDepthMultiplier,
        float centerDepthMultiplierAtNinetyDegrees,
        float centerCarveWidthMultiplier,
        float centerCarveWidthMultiplierAtNinetyDegrees,
        float profileMinDropMetersPerTile,
        float profileMaxDropMetersPerTile,
        float corridorDepressionMeters,
        float corridorMaxSlopeMetersPerSample,
        float corridorRadiusMultiplier,
        int corridorMinRadiusSamples,
        float corridorSmoothingStrength,
        int corridorSmoothingKernelRadius,
        int corridorSmoothingPasses,
        float finalSmoothingStrength,
        int finalSmoothingKernelRadius,
        int finalSmoothingPasses,
        float finalSmoothingRetainedDepthFraction,
        bool createRiverWater,
        bool createRiverDebugSplines,
        string generatedRiverWaterContainerName,
        string generatedRiverSplineContainerName,
        Material? riverWaterMaterial,
        string riverWaterMaterialAssetPath,
        float riverWaterWidthMultiplier,
        float riverWaterBedClearance,
        float riverWaterMeshVerticalOffset,
        float riverWaterMeshVerticalOffsetAtNinetyDegrees,
        float riverWaterMinimumDownstreamDrop,
        int riverWaterSampleStride,
        int riverSplineSamplingStep,
        int riverSplineAvgElements,
        float riverWaterUvLengthScale,
        float riverWaterUvWidthScale,
        float riverWaterSpeedMultiplier,
        float riverWaterMinSegmentLength,
        int riverWaterTangentSmoothingRadius)
    {
        WidthMultiplier = widthMultiplier;
        DepthMultiplier = depthMultiplier;
        BankDepthMultiplier = bankDepthMultiplier;
        CenterDepthMultiplier = centerDepthMultiplier;
        CenterDepthMultiplierAtNinetyDegrees = centerDepthMultiplierAtNinetyDegrees;
        CenterCarveWidthMultiplier = centerCarveWidthMultiplier;
        CenterCarveWidthMultiplierAtNinetyDegrees = centerCarveWidthMultiplierAtNinetyDegrees;
        ProfileMinDropMetersPerTile = profileMinDropMetersPerTile;
        ProfileMaxDropMetersPerTile = profileMaxDropMetersPerTile;
        CorridorDepressionMeters = corridorDepressionMeters;
        CorridorMaxSlopeMetersPerSample = corridorMaxSlopeMetersPerSample;
        CorridorRadiusMultiplier = corridorRadiusMultiplier;
        CorridorMinRadiusSamples = corridorMinRadiusSamples;
        CorridorSmoothingStrength = corridorSmoothingStrength;
        CorridorSmoothingKernelRadius = corridorSmoothingKernelRadius;
        CorridorSmoothingPasses = corridorSmoothingPasses;
        FinalSmoothingStrength = finalSmoothingStrength;
        FinalSmoothingKernelRadius = finalSmoothingKernelRadius;
        FinalSmoothingPasses = finalSmoothingPasses;
        FinalSmoothingRetainedDepthFraction = finalSmoothingRetainedDepthFraction;
        CreateRiverWater = createRiverWater;
        CreateRiverDebugSplines = createRiverDebugSplines;
        GeneratedRiverWaterContainerName = generatedRiverWaterContainerName;
        GeneratedRiverSplineContainerName = generatedRiverSplineContainerName;
        RiverWaterMaterial = riverWaterMaterial;
        RiverWaterMaterialAssetPath = riverWaterMaterialAssetPath;
        RiverWaterWidthMultiplier = riverWaterWidthMultiplier;
        RiverWaterBedClearance = riverWaterBedClearance;
        RiverWaterMeshVerticalOffset = riverWaterMeshVerticalOffset;
        RiverWaterMeshVerticalOffsetAtNinetyDegrees = riverWaterMeshVerticalOffsetAtNinetyDegrees;
        RiverWaterMinimumDownstreamDrop = riverWaterMinimumDownstreamDrop;
        RiverWaterSampleStride = riverWaterSampleStride;
        RiverSplineSamplingStep = riverSplineSamplingStep;
        RiverSplineAvgElements = riverSplineAvgElements;
        RiverWaterUvLengthScale = riverWaterUvLengthScale;
        RiverWaterUvWidthScale = riverWaterUvWidthScale;
        RiverWaterSpeedMultiplier = riverWaterSpeedMultiplier;
        RiverWaterMinSegmentLength = riverWaterMinSegmentLength;
        RiverWaterTangentSmoothingRadius = riverWaterTangentSmoothingRadius;
    }

    public float WidthMultiplier { get; }
    public float DepthMultiplier { get; }
    public float BankDepthMultiplier { get; }
    public float CenterDepthMultiplier { get; }
    public float CenterDepthMultiplierAtNinetyDegrees { get; }
    public float CenterCarveWidthMultiplier { get; }
    public float CenterCarveWidthMultiplierAtNinetyDegrees { get; }
    public float ProfileMinDropMetersPerTile { get; }
    public float ProfileMaxDropMetersPerTile { get; }
    public float CorridorDepressionMeters { get; }
    public float CorridorMaxSlopeMetersPerSample { get; }
    public float CorridorRadiusMultiplier { get; }
    public int CorridorMinRadiusSamples { get; }
    public float CorridorSmoothingStrength { get; }
    public int CorridorSmoothingKernelRadius { get; }
    public int CorridorSmoothingPasses { get; }
    public float FinalSmoothingStrength { get; }
    public int FinalSmoothingKernelRadius { get; }
    public int FinalSmoothingPasses { get; }
    public float FinalSmoothingRetainedDepthFraction { get; }
    public bool CreateRiverWater { get; }
    public bool CreateRiverDebugSplines { get; }
    public string GeneratedRiverWaterContainerName { get; }
    public string GeneratedRiverSplineContainerName { get; }
    public Material? RiverWaterMaterial { get; }
    public string RiverWaterMaterialAssetPath { get; }
    public float RiverWaterWidthMultiplier { get; }
    public float RiverWaterBedClearance { get; }
    public float RiverWaterMeshVerticalOffset { get; }
    public float RiverWaterMeshVerticalOffsetAtNinetyDegrees { get; }
    public float RiverWaterMinimumDownstreamDrop { get; }
    public int RiverWaterSampleStride { get; }
    public int RiverSplineSamplingStep { get; }
    public int RiverSplineAvgElements { get; }
    public float RiverWaterUvLengthScale { get; }
    public float RiverWaterUvWidthScale { get; }
    public float RiverWaterSpeedMultiplier { get; }
    public float RiverWaterMinSegmentLength { get; }
    public int RiverWaterTangentSmoothingRadius { get; }
}

internal sealed class OptimizationConfig
{
    public OptimizationConfig(
        bool optimizeConifersByDistance,
        Transform? coniferOptimizationTarget,
        float fullConiferDistance,
        float reducedConiferDistance,
        float lowDetailConiferDistance,
        float culledConiferDistance,
        float coniferOptimizationInterval,
        bool disableDistantConiferColliders,
        bool disableDistantConiferShadows,
        bool disableDistantConiferDecals)
    {
        OptimizeConifersByDistance = optimizeConifersByDistance;
        ConiferOptimizationTarget = coniferOptimizationTarget;
        FullConiferDistance = fullConiferDistance;
        ReducedConiferDistance = reducedConiferDistance;
        LowDetailConiferDistance = lowDetailConiferDistance;
        CulledConiferDistance = culledConiferDistance;
        ConiferOptimizationInterval = coniferOptimizationInterval;
        DisableDistantConiferColliders = disableDistantConiferColliders;
        DisableDistantConiferShadows = disableDistantConiferShadows;
        DisableDistantConiferDecals = disableDistantConiferDecals;
    }

    public bool OptimizeConifersByDistance { get; }
    public Transform? ConiferOptimizationTarget { get; }
    public float FullConiferDistance { get; }
    public float ReducedConiferDistance { get; }
    public float LowDetailConiferDistance { get; }
    public float CulledConiferDistance { get; }
    public float ConiferOptimizationInterval { get; }
    public bool DisableDistantConiferColliders { get; }
    public bool DisableDistantConiferShadows { get; }
    public bool DisableDistantConiferDecals { get; }
}

internal sealed class DebugConfig
{
    public DebugConfig(
        bool logHeightStats,
        bool logGenerationPhaseTimings,
        bool logVegetationPlacementWorkItems)
    {
        LogHeightStats = logHeightStats;
        LogGenerationPhaseTimings = logGenerationPhaseTimings;
        LogVegetationPlacementWorkItems = logVegetationPlacementWorkItems;
    }

    public bool LogHeightStats { get; }
    public bool LogGenerationPhaseTimings { get; }
    public bool LogVegetationPlacementWorkItems { get; }
}
