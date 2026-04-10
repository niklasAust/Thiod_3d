using UnityEngine;

#nullable enable

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

internal sealed class ConiferOptimizationContext
{
    public ConiferOptimizationContext(
        float fullConiferDistance,
        float reducedConiferDistance,
        float lowDetailConiferDistance,
        float culledConiferDistance,
        bool disableDistantConiferColliders,
        bool disableDistantConiferShadows,
        bool disableDistantConiferDecals)
    {
        FullConiferDistance = fullConiferDistance;
        ReducedConiferDistance = reducedConiferDistance;
        LowDetailConiferDistance = lowDetailConiferDistance;
        CulledConiferDistance = culledConiferDistance;
        DisableDistantConiferColliders = disableDistantConiferColliders;
        DisableDistantConiferShadows = disableDistantConiferShadows;
        DisableDistantConiferDecals = disableDistantConiferDecals;
    }

    public float FullConiferDistance { get; }
    public float ReducedConiferDistance { get; }
    public float LowDetailConiferDistance { get; }
    public float CulledConiferDistance { get; }
    public bool DisableDistantConiferColliders { get; }
    public bool DisableDistantConiferShadows { get; }
    public bool DisableDistantConiferDecals { get; }
}
