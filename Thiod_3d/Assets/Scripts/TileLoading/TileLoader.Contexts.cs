using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using Pinwheel.Griffin;
using UnityEngine;
using UnityEngine.Splines;
using WorldGen;

#nullable enable

namespace Thiod.TileLoading.Runtime
{

internal sealed class TerrainBuildContext
{
    public TerrainBuildContext(
        string worldDataFile,
        bool useMetadataGenerationSettings,
        int fallbackTileSize,
        int fallbackHillSpacing,
        double fallbackHillStrength,
        Vector3Int unityTileCoordinate,
        bool invertUnityYForWorldGen,
        bool useBatchNeighborhoodLoading,
        bool dynamicTileLoadingEnabled,
        bool reuseOverlappingDynamicNeighborhoodTiles,
        float terrainWidth,
        float terrainLength,
        float terrainHeight,
        int terrainGridSize,
        string generatedTerrainName,
        float riverWidthMultiplier,
        float riverDepthMultiplier,
        float riverBankDepthMultiplier,
        float riverCenterDepthMultiplier,
        float riverCenterDepthMultiplierAtNinetyDegrees,
        float riverCenterCarveWidthMultiplier,
        float riverCenterCarveWidthMultiplierAtNinetyDegrees,
        float riverProfileMinDropMetersPerTile,
        float riverProfileMaxDropMetersPerTile,
        float riverCorridorDepressionMeters,
        float riverCorridorMaxSlopeMetersPerSample,
        float riverCorridorRadiusMultiplier,
        int riverCorridorMinRadiusSamples,
        float riverCorridorSmoothingStrength,
        int riverCorridorSmoothingKernelRadius,
        int riverCorridorSmoothingPasses,
        float riverFinalSmoothingStrength,
        int riverFinalSmoothingKernelRadius,
        int riverFinalSmoothingPasses,
        float riverFinalSmoothingRetainedDepthFraction,
        float riverWaterMeshVerticalOffset,
        float riverWaterMeshVerticalOffsetAtNinetyDegrees,
        int vegetationStreamingPolicyVersion,
        bool placeTreeObjects,
        bool placeSurfaceObjects)
    {
        WorldDataFile = worldDataFile;
        UseMetadataGenerationSettings = useMetadataGenerationSettings;
        FallbackTileSize = fallbackTileSize;
        FallbackHillSpacing = fallbackHillSpacing;
        FallbackHillStrength = fallbackHillStrength;
        UnityTileCoordinate = unityTileCoordinate;
        InvertUnityYForWorldGen = invertUnityYForWorldGen;
        UseBatchNeighborhoodLoading = useBatchNeighborhoodLoading;
        DynamicTileLoadingEnabled = dynamicTileLoadingEnabled;
        ReuseOverlappingDynamicNeighborhoodTiles = reuseOverlappingDynamicNeighborhoodTiles;
        TerrainWidth = terrainWidth;
        TerrainLength = terrainLength;
        TerrainHeight = terrainHeight;
        TerrainGridSize = terrainGridSize;
        GeneratedTerrainName = generatedTerrainName;
        RiverWidthMultiplier = riverWidthMultiplier;
        RiverDepthMultiplier = riverDepthMultiplier;
        RiverBankDepthMultiplier = riverBankDepthMultiplier;
        RiverCenterDepthMultiplier = riverCenterDepthMultiplier;
        RiverCenterDepthMultiplierAtNinetyDegrees = riverCenterDepthMultiplierAtNinetyDegrees;
        RiverCenterCarveWidthMultiplier = riverCenterCarveWidthMultiplier;
        RiverCenterCarveWidthMultiplierAtNinetyDegrees = riverCenterCarveWidthMultiplierAtNinetyDegrees;
        RiverProfileMinDropMetersPerTile = riverProfileMinDropMetersPerTile;
        RiverProfileMaxDropMetersPerTile = riverProfileMaxDropMetersPerTile;
        RiverCorridorDepressionMeters = riverCorridorDepressionMeters;
        RiverCorridorMaxSlopeMetersPerSample = riverCorridorMaxSlopeMetersPerSample;
        RiverCorridorRadiusMultiplier = riverCorridorRadiusMultiplier;
        RiverCorridorMinRadiusSamples = riverCorridorMinRadiusSamples;
        RiverCorridorSmoothingStrength = riverCorridorSmoothingStrength;
        RiverCorridorSmoothingKernelRadius = riverCorridorSmoothingKernelRadius;
        RiverCorridorSmoothingPasses = riverCorridorSmoothingPasses;
        RiverFinalSmoothingStrength = riverFinalSmoothingStrength;
        RiverFinalSmoothingKernelRadius = riverFinalSmoothingKernelRadius;
        RiverFinalSmoothingPasses = riverFinalSmoothingPasses;
        RiverFinalSmoothingRetainedDepthFraction = riverFinalSmoothingRetainedDepthFraction;
        RiverWaterMeshVerticalOffset = riverWaterMeshVerticalOffset;
        RiverWaterMeshVerticalOffsetAtNinetyDegrees = riverWaterMeshVerticalOffsetAtNinetyDegrees;
        VegetationStreamingPolicyVersion = vegetationStreamingPolicyVersion;
        PlaceTreeObjects = placeTreeObjects;
        PlaceSurfaceObjects = placeSurfaceObjects;
    }

    public string WorldDataFile { get; }
    public bool UseMetadataGenerationSettings { get; }
    public int FallbackTileSize { get; }
    public int FallbackHillSpacing { get; }
    public double FallbackHillStrength { get; }
    public Vector3Int UnityTileCoordinate { get; }
    public bool InvertUnityYForWorldGen { get; }
    public bool UseBatchNeighborhoodLoading { get; }
    public bool DynamicTileLoadingEnabled { get; }
    public bool ReuseOverlappingDynamicNeighborhoodTiles { get; }
    public float TerrainWidth { get; }
    public float TerrainLength { get; }
    public float TerrainHeight { get; }
    public int TerrainGridSize { get; }
    public string GeneratedTerrainName { get; }
    public float RiverWidthMultiplier { get; }
    public float RiverDepthMultiplier { get; }
    public float RiverBankDepthMultiplier { get; }
    public float RiverCenterDepthMultiplier { get; }
    public float RiverCenterDepthMultiplierAtNinetyDegrees { get; }
    public float RiverCenterCarveWidthMultiplier { get; }
    public float RiverCenterCarveWidthMultiplierAtNinetyDegrees { get; }
    public float RiverProfileMinDropMetersPerTile { get; }
    public float RiverProfileMaxDropMetersPerTile { get; }
    public float RiverCorridorDepressionMeters { get; }
    public float RiverCorridorMaxSlopeMetersPerSample { get; }
    public float RiverCorridorRadiusMultiplier { get; }
    public int RiverCorridorMinRadiusSamples { get; }
    public float RiverCorridorSmoothingStrength { get; }
    public int RiverCorridorSmoothingKernelRadius { get; }
    public int RiverCorridorSmoothingPasses { get; }
    public float RiverFinalSmoothingStrength { get; }
    public int RiverFinalSmoothingKernelRadius { get; }
    public int RiverFinalSmoothingPasses { get; }
    public float RiverFinalSmoothingRetainedDepthFraction { get; }
    public float RiverWaterMeshVerticalOffset { get; }
    public float RiverWaterMeshVerticalOffsetAtNinetyDegrees { get; }
    public int VegetationStreamingPolicyVersion { get; }
    public bool PlaceTreeObjects { get; }
    public bool PlaceSurfaceObjects { get; }
}

internal sealed class RiverBuildContext
{
    public RiverBuildContext(
        float terrainWidth,
        float terrainLength,
        float terrainHeight,
        int terrainGridSize,
        float riverWidthMultiplier,
        float riverDepthMultiplier,
        float riverBankDepthMultiplier)
    {
        TerrainWidth = terrainWidth;
        TerrainLength = terrainLength;
        TerrainHeight = terrainHeight;
        TerrainGridSize = terrainGridSize;
        RiverWidthMultiplier = riverWidthMultiplier;
        RiverDepthMultiplier = riverDepthMultiplier;
        RiverBankDepthMultiplier = riverBankDepthMultiplier;
    }

    public float TerrainWidth { get; }
    public float TerrainLength { get; }
    public float TerrainHeight { get; }
    public int TerrainGridSize { get; }
    public float RiverWidthMultiplier { get; }
    public float RiverDepthMultiplier { get; }
    public float RiverBankDepthMultiplier { get; }
}

internal sealed class VegetationBuildContext
{
    public VegetationBuildContext(
        float terrainWidth,
        float terrainLength,
        float terrainHeight,
        double maxTileHeightUnits,
        float surfaceObjectVerticalOffset,
        float surfaceObjectConformOffset)
    {
        TerrainWidth = terrainWidth;
        TerrainLength = terrainLength;
        TerrainHeight = terrainHeight;
        MaxTileHeightUnits = maxTileHeightUnits;
        SurfaceObjectVerticalOffset = surfaceObjectVerticalOffset;
        SurfaceObjectConformOffset = surfaceObjectConformOffset;
    }

    public float TerrainWidth { get; }
    public float TerrainLength { get; }
    public float TerrainHeight { get; }
    public double MaxTileHeightUnits { get; }
    public float SurfaceObjectVerticalOffset { get; }
    public float SurfaceObjectConformOffset { get; }
}

internal sealed class TreeOptimizationContext
{
    public TreeOptimizationContext(
        float fullTreeDistance,
        float reducedTreeDistance,
        float lowDetailTreeDistance,
        float culledTreeDistance,
        bool disableDistantTreeColliders,
        bool disableDistantTreeShadows,
        bool disableDistantTreeDecals)
    {
        FullTreeDistance = fullTreeDistance;
        ReducedTreeDistance = reducedTreeDistance;
        LowDetailTreeDistance = lowDetailTreeDistance;
        CulledTreeDistance = culledTreeDistance;
        DisableDistantTreeColliders = disableDistantTreeColliders;
        DisableDistantTreeShadows = disableDistantTreeShadows;
        DisableDistantTreeDecals = disableDistantTreeDecals;
    }

    public float FullTreeDistance { get; }
    public float ReducedTreeDistance { get; }
    public float LowDetailTreeDistance { get; }
    public float CulledTreeDistance { get; }
    public bool DisableDistantTreeColliders { get; }
    public bool DisableDistantTreeShadows { get; }
    public bool DisableDistantTreeDecals { get; }
}

internal sealed class TileLoaderConfiguration
{
    public TileLoaderConfiguration(
        TileLoaderWorldSourceOptions worldSource,
        TileLoaderDynamicLoadingOptions dynamicLoading,
        TileLoaderTerrainOptions terrain,
        TileLoaderVegetationOptions vegetation,
        TileLoaderRiverOptions river,
        TileLoaderOptimizationOptions optimization,
        TileLoaderDebugOptions debug)
    {
        WorldSource = worldSource;
        DynamicLoading = dynamicLoading;
        Terrain = terrain;
        Vegetation = vegetation;
        River = river;
        Optimization = optimization;
        Debug = debug;
    }

    public TileLoaderWorldSourceOptions WorldSource { get; }
    public TileLoaderDynamicLoadingOptions DynamicLoading { get; }
    public TileLoaderTerrainOptions Terrain { get; }
    public TileLoaderVegetationOptions Vegetation { get; }
    public TileLoaderRiverOptions River { get; }
    public TileLoaderOptimizationOptions Optimization { get; }
    public TileLoaderDebugOptions Debug { get; }
}

internal sealed class TileLoaderWorldSourceOptions
{
    public TileLoaderWorldSourceOptions(
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

internal sealed class TileLoaderDynamicLoadingOptions
{
    public TileLoaderDynamicLoadingOptions(
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

internal sealed class TileLoaderTerrainOptions
{
    public TileLoaderTerrainOptions(
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

internal sealed class TileLoaderVegetationOptions
{
    public TileLoaderVegetationOptions(
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

internal sealed class TileLoaderRiverOptions
{
    public TileLoaderRiverOptions(
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

internal sealed class TileLoaderOptimizationOptions
{
    public TileLoaderOptimizationOptions(
        bool optimizeTreesByDistance,
        Transform? target,
        float fullTreeDistance,
        float reducedTreeDistance,
        float lowDetailTreeDistance,
        float culledTreeDistance,
        float treeOptimizationInterval,
        bool disableDistantTreeColliders,
        bool disableDistantTreeShadows,
        bool disableDistantTreeDecals)
    {
        OptimizeTreesByDistance = optimizeTreesByDistance;
        Target = target;
        FullTreeDistance = fullTreeDistance;
        ReducedTreeDistance = reducedTreeDistance;
        LowDetailTreeDistance = lowDetailTreeDistance;
        CulledTreeDistance = culledTreeDistance;
        TreeOptimizationInterval = treeOptimizationInterval;
        DisableDistantTreeColliders = disableDistantTreeColliders;
        DisableDistantTreeShadows = disableDistantTreeShadows;
        DisableDistantTreeDecals = disableDistantTreeDecals;
    }

    public bool OptimizeTreesByDistance { get; }
    public Transform? Target { get; }
    public float FullTreeDistance { get; }
    public float ReducedTreeDistance { get; }
    public float LowDetailTreeDistance { get; }
    public float CulledTreeDistance { get; }
    public float TreeOptimizationInterval { get; }
    public bool DisableDistantTreeColliders { get; }
    public bool DisableDistantTreeShadows { get; }
    public bool DisableDistantTreeDecals { get; }
}

internal sealed class TileLoaderDebugOptions
{
    public TileLoaderDebugOptions(
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

internal sealed class TileLoaderRuntimeState
{
    public bool HasLoadedInCurrentEnableCycle { get; set; }
    public bool PendingRuntimeSeamRebuild { get; set; }
    public int RuntimeSeamRebuildFrame { get; set; }
#if UNITY_EDITOR
    public bool PendingEditorSeamRebuild { get; set; }
#endif
    public GeneratedTerrainBatchCacheEntry? CachedTerrainBatch { get; set; }
    public int ActiveGenerationPipelineId { get; set; }
    public int LastCompletedGenerationPipelineId { get; set; }
    public Vector3Int? LastCompletedRuntimeNeighborhoodCenterTileCoordinate { get; set; }
    public bool TerrainPhaseLoadInProgress { get; set; }
    public Coroutine? ActiveTerrainLoadCoroutine { get; set; }
    public Vector3Int? ActiveLoadedUnityTileCoordinate { get; set; }
    public Vector3Int? ActiveRuntimeRequestedTileCoordinate { get; set; }
    public Vector3? LastVegetationStreamingTargetWorldPosition { get; set; }
    public Dictionary<Vector2Int, VegetationTileStreamingStatus> RuntimeVegetationTileStatusByCoordinate { get; } = new();

    public void ResetRuntimeLifecycle()
    {
        HasLoadedInCurrentEnableCycle = false;
        PendingRuntimeSeamRebuild = false;
        RuntimeSeamRebuildFrame = 0;
#if UNITY_EDITOR
        PendingEditorSeamRebuild = false;
#endif
        LastVegetationStreamingTargetWorldPosition = null;
        LastCompletedRuntimeNeighborhoodCenterTileCoordinate = null;
        RuntimeVegetationTileStatusByCoordinate.Clear();
    }

    public void ResetRuntimeStreaming()
    {
        TerrainPhaseLoadInProgress = false;
        ActiveTerrainLoadCoroutine = null;
        ActiveRuntimeRequestedTileCoordinate = null;
        LastCompletedRuntimeNeighborhoodCenterTileCoordinate = null;
        LastVegetationStreamingTargetWorldPosition = null;
        RuntimeVegetationTileStatusByCoordinate.Clear();
    }
}

internal sealed class TileLoaderServices
{
    private readonly TileLoader owner;
    private readonly TileLoaderRuntimeState state;
    private TileLoaderConfiguration? currentConfiguration;
    private TerrainSceneFacade? terrainSceneFacade;
    private TileLoaderRuntime? runtime;
    private TileLoaderGenerationTelemetryPort? generationTelemetryPort;
    private TileLoaderRuntimeBudgetPort? runtimeBudgetPort;
    private TerrainStreamingLifecyclePortAdapter? terrainStreamingLifecyclePort;
    private TerrainStreamingBatchPortAdapter? terrainStreamingBatchPort;
    private TerrainStreamingCreationPortAdapter? terrainStreamingCreationPort;
    private TerrainStreamingSeamPortAdapter? terrainStreamingSeamPort;
    private TerrainStreamingShadingPortAdapter? terrainStreamingShadingPort;
    private VegetationStreamingControllerOwner? vegetationStreamingControllerOwner;
    private PlayerCentricSurfaceSettingsPortAdapter? playerCentricSurfaceSettingsPort;
    private PlayerCentricSurfaceGeometryPortAdapter? playerCentricSurfaceGeometryPort;
    private PlayerCentricSurfacePrototypePortAdapter? playerCentricSurfacePrototypePort;
    private PlayerCentricSurfaceRendererPortAdapter? playerCentricSurfaceRendererPort;
    private TerrainStreamingPipeline? terrainStreamingPipeline;
    private VegetationStreamingController? vegetationStreamingController;
    private PlayerCentricSurfaceController? playerCentricSurfaceController;
    private TileLoaderTreeOptimizationController? treeOptimizationController;
    private GenerationReporter? generationReporter;
    private TileLoaderFrameBudgetCoordinator? runtimeFrameBudgetCoordinator;
    private TileLoaderTerrainSampler? cachedTerrainSampler;

    public TileLoaderServices(TileLoader owner, TileLoaderRuntimeState state)
    {
        this.owner = owner;
        this.state = state;
    }

    public TileLoaderConfiguration CurrentConfiguration => currentConfiguration ??= owner.CurrentConfigurationInternal;
    public TerrainSceneFacade TerrainScene => terrainSceneFacade ??= new TerrainSceneFacade(owner);
    public TileLoaderRuntime Runtime => runtime ??= new TileLoaderRuntime(owner);
    public TerrainStreamingPipeline TerrainPipeline => terrainStreamingPipeline ??= new TerrainStreamingPipeline(
        TerrainStreamingLifecyclePort,
        TerrainStreamingBatchPort,
        TerrainStreamingCreationPort,
        TerrainStreamingSeamPort,
        TerrainStreamingShadingPort,
        GenerationTelemetryPort,
        RuntimeBudgetPort);
    public VegetationStreamingController VegetationController => vegetationStreamingController ??= new VegetationStreamingController(
        VegetationControllerOwner,
        VegetationControllerOwner,
        VegetationControllerOwner,
        GenerationTelemetryPort,
        RuntimeBudgetPort,
        VegetationControllerOwner,
        VegetationControllerOwner);
    public PlayerCentricSurfaceController SurfaceController => playerCentricSurfaceController ??= new PlayerCentricSurfaceController(
        PlayerCentricSurfaceSettingsPort,
        GenerationTelemetryPort,
        RuntimeBudgetPort,
        PlayerCentricSurfaceGeometryPort,
        PlayerCentricSurfacePrototypePort,
        PlayerCentricSurfaceRendererPort);
    public TileLoaderTreeOptimizationController TreeOptimizationController => treeOptimizationController ??= new TileLoaderTreeOptimizationController(owner);
    public GenerationReporter Reporter => generationReporter ??= new GenerationReporter(owner);
    public TileLoaderFrameBudgetCoordinator FrameBudgetCoordinator => runtimeFrameBudgetCoordinator ??= new TileLoaderFrameBudgetCoordinator();
    public IInstancedVegetationRuntimeBudgetOwner InstancedVegetationRuntimeBudgetOwner => RuntimeBudgetPort;
    public TileLoaderTerrainSampler? CachedTerrainSampler
    {
        get => cachedTerrainSampler;
        set => cachedTerrainSampler = value;
    }

    private TileLoaderGenerationTelemetryPort GenerationTelemetryPort => generationTelemetryPort ??= new TileLoaderGenerationTelemetryPort(owner);
    private TileLoaderRuntimeBudgetPort RuntimeBudgetPort => runtimeBudgetPort ??= new TileLoaderRuntimeBudgetPort(owner);
    private TerrainStreamingLifecyclePortAdapter TerrainStreamingLifecyclePort => terrainStreamingLifecyclePort ??= new TerrainStreamingLifecyclePortAdapter(owner);
    private TerrainStreamingBatchPortAdapter TerrainStreamingBatchPort => terrainStreamingBatchPort ??= new TerrainStreamingBatchPortAdapter(owner);
    private TerrainStreamingCreationPortAdapter TerrainStreamingCreationPort => terrainStreamingCreationPort ??= new TerrainStreamingCreationPortAdapter(owner);
    private TerrainStreamingSeamPortAdapter TerrainStreamingSeamPort => terrainStreamingSeamPort ??= new TerrainStreamingSeamPortAdapter(owner);
    private TerrainStreamingShadingPortAdapter TerrainStreamingShadingPort => terrainStreamingShadingPort ??= new TerrainStreamingShadingPortAdapter(owner);
    private VegetationStreamingControllerOwner VegetationControllerOwner => vegetationStreamingControllerOwner ??= new VegetationStreamingControllerOwner(owner);
    private PlayerCentricSurfaceSettingsPortAdapter PlayerCentricSurfaceSettingsPort => playerCentricSurfaceSettingsPort ??= new PlayerCentricSurfaceSettingsPortAdapter(owner);
    private PlayerCentricSurfaceGeometryPortAdapter PlayerCentricSurfaceGeometryPort => playerCentricSurfaceGeometryPort ??= new PlayerCentricSurfaceGeometryPortAdapter(owner);
    private PlayerCentricSurfacePrototypePortAdapter PlayerCentricSurfacePrototypePort => playerCentricSurfacePrototypePort ??= new PlayerCentricSurfacePrototypePortAdapter(owner);
    private PlayerCentricSurfaceRendererPortAdapter PlayerCentricSurfaceRendererPort => playerCentricSurfaceRendererPort ??= new PlayerCentricSurfaceRendererPortAdapter(owner, RuntimeBudgetPort);

    public TileLoaderTerrainSampler GetOrCreateTerrainSampler(VegetationBuildContext context)
    {
        return cachedTerrainSampler ??= new TileLoaderTerrainSampler(context);
    }

    public void RefreshConfiguration()
    {
        currentConfiguration = owner.CurrentConfigurationInternal;
        ClearTerrainSampler();
    }

    public void ClearTerrainSampler()
    {
        cachedTerrainSampler = null;
    }

    public void OnDisableRuntime()
    {
        runtime?.OnDisable();
    }

    public void ResetRuntimeLifecycleState()
    {
        RefreshConfiguration();
        state.ResetRuntimeLifecycle();
        _ = TerrainScene;
        _ = TerrainPipeline;
        _ = VegetationController;
        _ = SurfaceController;
        _ = TreeOptimizationController;
        _ = Reporter;
        FrameBudgetCoordinator.Reset();
        SurfaceController.ResetState();
        TreeOptimizationController.ResetState();
    }

    public void ResetRuntimeStreamingStateOnDisable()
    {
        state.ResetRuntimeStreaming();
        RefreshConfiguration();
        runtimeFrameBudgetCoordinator?.Reset();
        playerCentricSurfaceController?.ResetState();
        treeOptimizationController?.ResetState();
    }
}

internal static class TileLoaderCompositionBuilder
{
    public static TileLoaderServices CreateServices(TileLoader owner, TileLoaderRuntimeState state)
    {
        return new TileLoaderServices(owner, state);
    }

    public static TerrainBuildContext CreateTerrainBuildContext(
        TileLoaderConfiguration config,
        bool useBatchNeighborhoodLoading,
        int vegetationStreamingPolicyVersion)
    {
        return new TerrainBuildContext(
            config.WorldSource.WorldDataFile,
            config.WorldSource.UseMetadataGenerationSettings,
            config.WorldSource.FallbackTileSize,
            config.WorldSource.FallbackHillSpacing,
            config.WorldSource.FallbackHillStrength,
            config.Terrain.UnityTileCoordinate,
            config.WorldSource.InvertUnityYForWorldGen,
            useBatchNeighborhoodLoading,
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
            vegetationStreamingPolicyVersion,
            config.Vegetation.PlaceTrees,
            config.Vegetation.PlaceSurfaceObjects);
    }

    public static RiverBuildContext CreateRiverBuildContext(TileLoaderConfiguration config)
    {
        return new RiverBuildContext(
            config.Terrain.Width,
            config.Terrain.Length,
            config.Terrain.Height,
            config.Terrain.GridSize,
            config.River.WidthMultiplier,
            config.River.DepthMultiplier,
            config.River.BankDepthMultiplier);
    }

    public static VegetationBuildContext CreateVegetationBuildContext(TileLoaderConfiguration config, double maxTileHeightUnits)
    {
        return new VegetationBuildContext(
            config.Terrain.Width,
            config.Terrain.Length,
            config.Terrain.Height,
            maxTileHeightUnits,
            config.Vegetation.SurfaceObjectVerticalOffset,
            config.Vegetation.GrassClusterConformSurfaceOffset);
    }

    public static TreeOptimizationContext CreateTreeOptimizationContext(TileLoaderConfiguration config)
    {
        return new TreeOptimizationContext(
            config.Optimization.FullTreeDistance,
            config.Optimization.ReducedTreeDistance,
            config.Optimization.LowDetailTreeDistance,
            config.Optimization.CulledTreeDistance,
            config.Optimization.DisableDistantTreeColliders,
            config.Optimization.DisableDistantTreeShadows,
            config.Optimization.DisableDistantTreeDecals);
    }

    public static TileLoaderTreeOptimizer CreateTreeOptimizer(TileLoaderConfiguration config)
    {
        return new TileLoaderTreeOptimizer(CreateTreeOptimizationContext(config));
    }

    public static TileLoaderBatchPlanner CreateBatchPlanner(
        TileLoaderConfiguration config,
        bool useBatchNeighborhoodLoading,
        double metersPerTileHeightUnit,
        int vegetationStreamingPolicyVersion)
    {
        return new TileLoaderBatchPlanner(
            CreateTerrainBuildContext(config, useBatchNeighborhoodLoading, vegetationStreamingPolicyVersion),
            metersPerTileHeightUnit);
    }

    public static TileLoaderRiverBuilder CreateRiverBuilder(
        TileLoaderRiverSettings settings,
        TileLoaderTerrainSampler terrainSampler,
        string defaultRiverWaterMaterialAssetPath)
    {
        return new TileLoaderRiverBuilder(settings, terrainSampler, defaultRiverWaterMaterialAssetPath);
    }
}

internal interface IGenerationTelemetryPort
{
    void RecordGenerationPhaseTimingInternal(GeneratedTerrainBatchState? batchState, string phaseName, TimeSpan elapsed);
    void LogGenerationPhaseTimingInternal(string phaseName, TimeSpan elapsed);
}

internal interface IRuntimeChunkBudgetPort
{
    float ResolveRuntimePhaseBudgetMsInternal(float localBudgetMilliseconds);
    void RestartRuntimeChunkStopwatch(Stopwatch chunkStopwatch);
    bool ShouldYieldAfterRuntimeChunk(Stopwatch chunkStopwatch, float localBudgetMilliseconds, double minimumBudgetMilliseconds = 0.25d);
    void CommitRuntimeChunk(Stopwatch chunkStopwatch);
}

internal interface IInstancedVegetationRuntimeBudgetOwner : IRuntimeChunkBudgetPort
{
    void RegisterInstancedVegetationRendererInternal(TileLoaderInstancedVegetationRenderer renderer);
    void UnregisterInstancedVegetationRendererInternal(TileLoaderInstancedVegetationRenderer renderer);
}

internal interface ITerrainStreamingLifecyclePort
{
    int BeginTerrainGenerationPipelineInternal();
    int ActiveGenerationPipelineIdInternal { get; }
    bool IsPlayingInternal { get; }
    bool DynamicTileLoadingEnabled { get; }
    bool TerrainPhaseLoadInProgressInternal { get; set; }
    void CancelActiveVegetationPopulationInternal();
    void ResetGeneratedRuntimeArtifactsInternal();
    void ClearGeneratedTerrainsInternal();
    Coroutine StartRuntimeCoroutine(IEnumerator routine);
    Coroutine? ActiveTerrainLoadCoroutineInternal { get; set; }
    Coroutine? ActiveVegetationPopulationCoroutineInternal { get; }
    Vector3Int UnityTileCoordinate { get; }
    Vector3Int? ActiveRuntimeRequestedTileCoordinateInternal { get; set; }
    bool ShouldAbortRuntimeTerrainStreamingInternal(GeneratedTerrainBatchState batchState);
    void ReleaseTerrainPhaseAfterAbortedBatchInternal(GeneratedTerrainBatchState batchState);
    void TryDispatchQueuedDynamicLoadInternal();
}

internal interface ITerrainStreamingBatchPort
{
    GeneratedTerrainBatchState MeasureBatchWorldgenInternal(TileGenerator tileGenerator, LoadedWorldData loadedWorldData, GenerationSettings settings, int pipelineId);
    bool TryReuseActiveTerrainBatchRootInternal(GeneratedTerrainBatchState batchState);
    Transform CreateGeneratedTerrainBatchRootInternal(int pipelineId, Vector3Int centerTileCoordinate);
    void FinalizeTerrainBatchStateInternal(GeneratedTerrainBatchState batchState);
    void DestroyGeneratedTerrainContainerInternal(Transform? container);
    void PrepareDeferredGenerationTargetsInternal(GeneratedTerrainBatchState batchState);
    void ScheduleDeferredGenerationPhasesInternal(GeneratedTerrainBatchState batchState);
    string GetTerrainBatchWorldgenPhaseNameInternal();
    TileLoaderBatchPlanner CreateBatchPlannerInternal();
    GeneratedTerrainBatchCacheEntry? CachedTerrainBatchInternal { get; set; }
    Transform? ActiveGeneratedTerrainRootInternal { get; }
    Vector3Int? ActiveLoadedUnityTileCoordinate { get; }
    Dictionary<Vector2Int, GeneratedTerrainTileData> ActiveTerrainTileCacheInternal { get; }
    string? ActiveTerrainTileCacheSignatureInternal { get; }
}

internal interface ITerrainStreamingCreationPort
{
    void MeasureTerrainCreationPhaseInternal(GeneratedTerrainBatchState batchState, Action action);
    int GetGeneratedTerrainGroupIdInternal();
    Vector2Int GetTileCoordinateInternal(GeneratedTerrainRequest request);
    GStylizedTerrain CreateTerrainInternal(
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
        Transform parent);
    List<GeneratedTerrainRequest> GetTerrainCreationRequestsInPriorityOrderInternal(GeneratedTerrainBatchState batchState);
    GTerrainData CreateTerrainDataForRuntimeCreationInternal(
        TileLayers layers,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        double localMaxHeight,
        double tileHilliness);
    Color[] BuildTerrainHeightPixelsForRuntimeCreationInternal(double[,] heightmap, double normalizationMinHeight, double normalizationMaxHeight);
    void UploadTerrainHeightPixelsForRuntimeCreationInternal(GTerrainData terrainData, Color[] heightPixels);
    GStylizedTerrain FinalizeRuntimeCreatedTerrainInternal(
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
        Transform parent);
}

internal interface ITerrainStreamingSeamPort
{
    void MeasureTerrainSeamsPhaseInternal(GeneratedTerrainBatchState batchState, Action action);
    void RebuildTerrainSeamsInternal(IReadOnlyList<GStylizedTerrain> terrains);
    void ConnectAdjacentTerrainsInternal();
    void RebuildTerrainSeamsInternal(GStylizedTerrain terrain, TileLoaderTerrainSeamMask seamMask);
}

internal interface ITerrainStreamingShadingPort
{
    void MeasureTerrainShadingPhaseInternal(GeneratedTerrainBatchState batchState, Action action);
    IReadOnlyList<GStylizedTerrain> GetTerrainsForStreamingShadingInternal(GeneratedTerrainBatchState batchState);
    void ApplyTerrainShadingInternal(IReadOnlyList<GStylizedTerrain> terrains);
}

internal interface ITerrainStreamingBudgetPort : IRuntimeChunkBudgetPort
{
    float TerrainCreationBudgetMsPerFrameInternal { get; }
    float TerrainSeamBudgetMsPerFrameInternal { get; }
    float TerrainShadingBudgetMsPerFrameInternal { get; }
}

internal interface IVegetationStreamingBudgetPort : IRuntimeChunkBudgetPort
{
    float RuntimeGlobalBudgetMsPerFrameInternal { get; }
    float VegetationPlacementBudgetMsPerFrameInternal { get; }
}

internal interface IVegetationDeferredWorkflowOwner
{
    bool IsPlayingInternal { get; }
    bool ShouldAbortDeferredGenerationInternal(GeneratedTerrainBatchState batchState);
    void ReleaseTerrainPhaseAfterAbortedBatchInternal(GeneratedTerrainBatchState batchState);
}

internal interface IVegetationStreamingRiverPhaseOwner
{
    bool ShouldAbortRuntimeTerrainStreamingInternal(GeneratedTerrainBatchState batchState);
    void RestartRuntimeChunkStopwatch(Stopwatch chunkStopwatch);
    bool ShouldYieldAfterRuntimeChunk(Stopwatch chunkStopwatch, float localBudgetMilliseconds, double minimumBudgetMilliseconds = 0.25d);
    void CommitRuntimeChunk(Stopwatch chunkStopwatch);
    void RecordGenerationPhaseTimingInternal(GeneratedTerrainBatchState? batchState, string phaseName, TimeSpan elapsed);
    void LogGenerationPhaseTimingInternal(string phaseName, TimeSpan elapsed);
    void MeasureRiverWaterPhaseInternal(GeneratedTerrainBatchState batchState, Action action);
    void ClearGeneratedRiverOutputsInternal(IReadOnlyList<GStylizedTerrain> terrains);
    void PopulateRiverWaterForBatchInternal(GeneratedTerrainBatchState batchState);
    int GetRiverWaterPathCountInternal(GeneratedTerrainRequest request, GStylizedTerrain terrain);
    bool PopulateRiverWaterForPathInternal(
        GeneratedTerrainRequest request,
        GStylizedTerrain terrain,
        int riverPathIndex,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        Dictionary<string, Spline> riverSplineCache,
        IDictionary<string, RiverWaterSeamCrossSection> riverWaterSeams);
    void MeasureRiverSplinePhaseInternal(GeneratedTerrainBatchState batchState, Action action);
    void PopulateRiverDebugSplinesForBatchInternal(GeneratedTerrainBatchState batchState);
    bool PopulateRiverDebugSplinesForTerrainInternal(
        GeneratedTerrainRequest request,
        GStylizedTerrain terrain,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        Dictionary<string, Spline> riverSplineCache);
    float RuntimeGlobalBudgetMsPerFrameInternal { get; }
}

internal interface IVegetationStreamingLifecyclePort
{
    int ActiveGenerationPipelineIdInternal { get; }
    Coroutine StartRuntimeCoroutine(IEnumerator routine);
    void UpdateTreeOptimizationInternal(bool forceFullIfNoTarget = false);
    Vector3? LastVegetationStreamingTargetWorldPositionInternal { get; set; }
    Vector3? ResolveVegetationStreamingTargetWorldPositionInternal();
    int LastCompletedGenerationPipelineIdInternal { get; set; }
    Vector3Int? LastCompletedRuntimeNeighborhoodCenterTileCoordinateInternal { get; set; }
    Vector3Int? ActiveRuntimeRequestedTileCoordinateInternal { get; set; }
    void LogGenerationBatchSummaryInternal(GeneratedTerrainBatchState batchState, string stage);
    bool TerrainPhaseLoadInProgressInternal { get; set; }
    void TryDispatchQueuedDynamicLoadInternal();
    void PromoteGeneratedTerrainBatchInternal(GeneratedTerrainBatchState batchState);
    void StopRuntimeCoroutineInternal(Coroutine? routine);
}

internal interface IVegetationStreamingReportingPort
{
    GenerationReporter Reporter { get; }
    void DiscardPendingVegetationBuildOutputsInternal(GeneratedTerrainBatchState batchState);
}

internal interface IVegetationStreamingExecutionPort
{
    bool PlaceTreeObjectsInternal { get; }
    bool PlaceSurfaceObjectsInternal { get; }
    void EnsurePlayerCentricSurfaceCachesInternal(GeneratedTerrainBatchState batchState, Stopwatch totalStopwatch);
    bool UsesLegacyVegetationObjectsInternal();
    void MeasureVegetationRenderPhaseInternal(Action action);
    void PopulatePlacedObjectsLegacyInternal(GStylizedTerrain terrain, GeneratedTerrainRequest request, double normalizationMinHeight, double normalizationMaxHeight);
    List<VegetationWorkItem> PrepareVegetationWorkItemsInternal(GeneratedTerrainBatchState batchState, Stopwatch totalStopwatch);
    HybridVegetationBuildState? BeginHybridVegetationBuildInternal(
        GeneratedTerrainBatchState? batchState,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        double normalizationMinHeight,
        double normalizationMaxHeight);
    Transform? FindVegetationContainerInternal(Transform terrainTransform);
    void MarkRuntimeVegetationTileSettledInternal(Vector2Int tileCoordinate);
    void TryLogVegetationWorkQueueSummaryInternal(GeneratedTerrainBatchState batchState, IReadOnlyList<VegetationWorkItem> workItems);
    void RetireGeneratedContainerInternal(Transform container);
    bool TryGetUnityTileCoordinateForWorldPositionInternal(Vector3 worldPosition, out Vector3Int tileCoordinate);
    string GetVegetationBuildContainerNameInternal(int pipelineId);
    bool ProcessPreparedHybridVegetationPlacementInternal(VegetationWorkItem workItem, PreparedVegetationPlacement preparedPlacement);
    Vector2Int GetTileCoordinateFromBuildRequestInternal(GeneratedTerrainRequest request);
    VegetationTileStreamingStats GetOrCreateVegetationTileStatsInternal(GeneratedTerrainBatchState batchState, Vector2Int tileCoordinate, bool isCenterTile);
    double FinalizeHybridVegetationBuildInternal(HybridVegetationBuildState buildState);
    bool FinalizeVegetationBuildOutputInternal(HybridVegetationBuildState buildState);
    void RecordPlacementPhaseTimingInternal(
        GeneratedTerrainBatchState? batchState,
        VegetationTileStreamingStats? tileStats,
        double elapsedMilliseconds,
        VegetationPlacementPhase placementPhase,
        VegetationWorkItem? workItem = null);
    void TryLogVegetationWorkItemCompletionInternal(
        VegetationWorkItem workItem,
        VegetationTileStreamingStats? tileStats,
        int completedWorkItemCount,
        int visibleInstancedPlacementCount,
        bool rendererFinalizeDeferred,
        bool rendererReady,
        double rendererPrototypeInitMilliseconds);
    void TryLogSettledVegetationTileInternal(Vector2Int tileCoordinate, VegetationTileStreamingStats tileStats);
    void LogCenterTileVegetationReadyInternal(double elapsedMilliseconds);
    float ResolveRuntimePhaseBudgetMsInternal(float localBudgetMilliseconds);
    float VegetationPlacementBudgetMsPerFrameInternal { get; }
    bool ProcessNextVegetationWorkItemPlacementInternal(VegetationWorkItem workItem, Stopwatch totalStopwatch);
    void FinalizeVegetationWorkItemInternal(VegetationWorkItem workItem, Stopwatch totalStopwatch);
    bool ShouldSpreadVegetationInstancingAcrossFramesInternal(GeneratedTerrainBatchState batchState);
    IEnumerator EnsurePlayerCentricSurfaceCachesOverMultipleFramesInternal(GeneratedTerrainBatchState batchState, Stopwatch totalStopwatch);
    void MeasureVegetationPlacementPhaseInternal(GeneratedTerrainBatchState batchState, Action action);
    List<PreparedVegetationPlacement> PrepareVegetationPlacementsForRequestInternal(
        GeneratedTerrainBatchState batchState,
        Stopwatch totalStopwatch,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request);
    Vector2Int GetTileCoordinateInternal(GeneratedTerrainRequest request);
}

internal interface IPlayerCentricSurfaceSettingsPort
{
    bool IsPlayingInternal { get; }
    bool PlayerCentricSurfaceVegetationEnabledInternal { get; }
    bool PlaceSurfaceObjectsInternal { get; }
    float PlayerCentricSurfaceUpdateIntervalSecondsInternal { get; }
    Vector3? ResolveVegetationStreamingTargetWorldPositionInternal();
    float PlayerCentricSurfaceRadiusMetersInternal { get; }
    float PlayerCentricSurfaceHysteresisMetersInternal { get; }
    float PlayerCentricSurfaceCellSizeMetersInternal { get; }
    int PlayerCentricSurfaceCacheVersionInternal { get; }
}

internal interface IPlayerCentricSurfaceGeometryPort
{
    Vector2Int GetTileCoordinateInternal(GeneratedTerrainRequest request);
    bool TryBuildPreparedPlacementGeometryInternal(
        GeneratedTerrainBatchState batchState,
        VegetationTileStreamingStats? tileStats,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        TileObjectPlacement placement,
        bool isTreePlacement,
        bool enforceCurrentStreamingDistance,
        out PreparedPlacementGeometry geometry);
    bool IsTreeCoupledSurfacePlacementInternal(TileObjectPlacement placement);
    ulong ComputeStablePlacementHashInternal(GeneratedTerrainRequest request, TileObjectPlacement placement);
    void PopulatePreparedPlacementGeometryNormalsInternal(
        GeneratedTerrainBatchState batchState,
        VegetationTileStreamingStats? tileStats,
        GeneratedTerrainRequest request,
        List<PreparedVegetationPlacement> preparedPlacements);
    bool TrySampleGeneratedTerrainSurfaceInternal(
        GStylizedTerrain terrain,
        float localX,
        float localZ,
        float verticalOffset,
        out Vector3 exactLocalSurfacePoint,
        out Vector3 exactLocalSurfaceNormal);
    float SurfaceObjectVerticalOffsetInternal { get; }
    float GetSurfaceObjectOffsetInternal();
}

internal interface IPlayerCentricSurfacePrototypePort
{
    GameObject? LoadPrefabForPlacementInternal(TileObjectPlacement placement, GeneratedTerrainBatchState? batchState);
    bool IsTreePlacementInternal(TileObjectPlacement placement, GameObject prefab);
    TileLoaderInstancedVegetationPrototype? GetOrCreateVegetationPrototypeInternal(
        GeneratedTerrainBatchState? batchState,
        TileObjectPlacement placement,
        GameObject prefab,
        bool isTreeObject,
        bool supportsPromotion);
    bool SupportsHybridPromotionInternal(TileObjectPlacement placement);
}

internal interface IPlayerCentricSurfaceRendererPort
{
    string GetVegetationContainerNameInternal();
    VegetationLoadMode VegetationLoadModeInternal { get; }
    float VegetationInteractionRadiusMetersInternal { get; }
    float VegetationInteractionHysteresisMetersInternal { get; }
    float PrototypeInitBudgetMsPerFrameInternal { get; }
    IInstancedVegetationRuntimeBudgetOwner RuntimeBudgetOwnerInternal { get; }
    void RetireGeneratedContainerInternal(Transform container);
}

internal interface IPlayerCentricSurfaceBudgetPort : IRuntimeChunkBudgetPort
{
    float PlayerCentricSurfaceBuildBudgetMsPerFrameInternal { get; }
    int ActiveGenerationPipelineIdInternal { get; }
}

}
