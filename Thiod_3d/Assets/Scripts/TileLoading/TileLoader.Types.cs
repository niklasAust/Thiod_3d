using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Splines;
using Pinwheel.Griffin;
using WorldGen;

#nullable enable

internal enum ConiferOptimizationTier
{
    Unknown = 0,
    Full = 1,
    Reduced = 2,
    LowDetail = 3,
    Culled = 4,
}

internal sealed class RiverWaterSeamCrossSection
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

    public Vector3 CenterWorld { get; }
    public Vector3 LeftWorld { get; private set; }
    public Vector3 RightWorld { get; private set; }
    public bool HasVertices { get; private set; }

    public void SetVertices(Vector3 leftWorld, Vector3 rightWorld)
    {
        LeftWorld = leftWorld;
        RightWorld = rightWorld;
        HasVertices = true;
    }
}

internal sealed class GeneratedConiferInstance
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

internal readonly struct LoadedWorldData
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

internal readonly struct GenerationSettings
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

internal readonly struct GeneratedTerrainTileData
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

internal readonly struct GeneratedTerrainRequest
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

    public Vector2Int TileCoordinate => new(UnityTileX, UnityTileY);
}

internal sealed class HybridVegetationBuildState
{
    public HybridVegetationBuildState(
        GeneratedTerrainBatchState? batchState,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        Transform? existingVegetationContainer,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        BatchState = batchState;
        Terrain = terrain;
        Request = request;
        ExistingVegetationContainer = existingVegetationContainer;
        NormalizationMinHeight = normalizationMinHeight;
        NormalizationMaxHeight = normalizationMaxHeight;
        Prototypes = new List<TileLoaderInstancedVegetationPrototype>();
        Placements = new List<TileLoaderInstancedVegetationPlacement>();
        PrototypeIndices = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
    }

    public GeneratedTerrainBatchState? BatchState { get; }
    public GStylizedTerrain Terrain { get; }
    public GeneratedTerrainRequest Request { get; }
    public Transform? ExistingVegetationContainer { get; }
    public double NormalizationMinHeight { get; }
    public double NormalizationMaxHeight { get; }
    public Transform? VegetationContainer { get; set; }
    public List<TileLoaderInstancedVegetationPrototype> Prototypes { get; }
    public List<TileLoaderInstancedVegetationPlacement> Placements { get; }
    public Dictionary<string, int> PrototypeIndices { get; }
    public int NextPlacementIndex { get; set; }
    public int LastFinalizedPlacementCount { get; set; }
    public bool HasSwappedVegetationContainer { get; set; }
}

internal sealed class VegetationWorkItem
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

internal readonly struct PreparedPlacementGeometry
{
    public PreparedPlacementGeometry(
        Vector3 localPosition,
        Vector3 localNormal,
        Vector3 worldPosition,
        float distanceToTargetSq,
        VegetationDensityZone densityZone,
        bool isSeamRisk,
        bool useExactTerrainConformOnLoad,
        bool useExactTerrainConformOnPromotion)
    {
        LocalPosition = localPosition;
        LocalNormal = localNormal;
        WorldPosition = worldPosition;
        DistanceToTargetSq = distanceToTargetSq;
        DensityZone = densityZone;
        IsSeamRisk = isSeamRisk;
        UseExactTerrainConformOnLoad = useExactTerrainConformOnLoad;
        UseExactTerrainConformOnPromotion = useExactTerrainConformOnPromotion;
    }

    public Vector3 LocalPosition { get; }
    public Vector3 LocalNormal { get; }
    public Vector3 WorldPosition { get; }
    public float DistanceToTargetSq { get; }
    public VegetationDensityZone DensityZone { get; }
    public bool IsSeamRisk { get; }
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
            IsSeamRisk,
            UseExactTerrainConformOnLoad,
            UseExactTerrainConformOnPromotion);
    }
}

internal readonly struct PreparedVegetationPlacement
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

internal readonly struct PlayerCentricSurfaceCellKey : IEquatable<PlayerCentricSurfaceCellKey>
{
    public PlayerCentricSurfaceCellKey(int x, int y)
    {
        X = x;
        Y = y;
    }

    public int X { get; }
    public int Y { get; }

    public bool Equals(PlayerCentricSurfaceCellKey other)
        => X == other.X && Y == other.Y;

    public override bool Equals(object? obj)
        => obj is PlayerCentricSurfaceCellKey other && Equals(other);

    public override int GetHashCode()
        => HashCode.Combine(X, Y);

    public override string ToString()
        => $"cell({X},{Y})";
}

internal sealed class PlayerCentricSurfaceCellSource
{
    public PlayerCentricSurfaceCellSource(
        PlayerCentricSurfaceCellKey cellKey,
        Vector2Int ownerTileCoordinate,
        GStylizedTerrain terrain)
    {
        CellKey = cellKey;
        OwnerTileCoordinate = ownerTileCoordinate;
        Terrain = terrain;
        Prototypes = new List<TileLoaderInstancedVegetationPrototype>();
        Placements = new List<TileLoaderInstancedVegetationPlacement>();
        PrototypeIndices = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
    }

    public PlayerCentricSurfaceCellKey CellKey { get; }
    public Vector2Int OwnerTileCoordinate { get; }
    public GStylizedTerrain Terrain { get; set; }
    public List<TileLoaderInstancedVegetationPrototype> Prototypes { get; }
    public List<TileLoaderInstancedVegetationPlacement> Placements { get; }
    public Dictionary<string, int> PrototypeIndices { get; }
    public Transform? RuntimeContainer { get; set; }
    public int PlacementCount => Placements.Count;
}

internal sealed class PlayerCentricSurfaceTileCache
{
    public PlayerCentricSurfaceTileCache(
        Vector2Int tileCoordinate,
        string cacheSignature,
        GStylizedTerrain terrain)
    {
        TileCoordinate = tileCoordinate;
        CacheSignature = cacheSignature ?? string.Empty;
        Terrain = terrain;
        TerrainInstanceId = terrain != null ? terrain.GetInstanceID() : 0;
        CellKeys = new HashSet<PlayerCentricSurfaceCellKey>();
    }

    public Vector2Int TileCoordinate { get; }
    public string CacheSignature { get; set; }
    public GStylizedTerrain Terrain { get; set; }
    public int TerrainInstanceId { get; set; }
    public HashSet<PlayerCentricSurfaceCellKey> CellKeys { get; }
}

internal sealed class VegetationTileStreamingStats
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
}

[Serializable]
internal struct GeneratedTerrainShadingMetadata
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

internal sealed class GeneratedTerrainBatchState
{
    public GeneratedTerrainBatchState(
        string cacheKey,
        string cacheSignature,
        int pipelineId,
        Vector3Int centerTileCoordinate,
        Vector3 batchRootLocalPosition,
        IReadOnlyList<GeneratedTerrainRequest> requests,
        IReadOnlyList<Vector2Int> orderedTileCoordinates,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        CacheKey = cacheKey;
        CacheSignature = cacheSignature;
        PipelineId = pipelineId;
        CenterTileCoordinate = centerTileCoordinate;
        BatchRootLocalPosition = batchRootLocalPosition;
        Requests = requests?.ToArray() ?? Array.Empty<GeneratedTerrainRequest>();
        OrderedTileCoordinates = orderedTileCoordinates?.ToArray() ?? Array.Empty<Vector2Int>();
        NormalizationMinHeight = normalizationMinHeight;
        NormalizationMaxHeight = normalizationMaxHeight;
        ActiveTerrains = new List<GStylizedTerrain>(Requests.Count);
        CreatedTerrains = new List<GStylizedTerrain>(Requests.Count);
        CreatedRequests = new List<GeneratedTerrainRequest>(Requests.Count);
        TerrainByCoordinate = new Dictionary<Vector2Int, GStylizedTerrain>();
        RequestsByCoordinate = new Dictionary<Vector2Int, GeneratedTerrainRequest>();
        NextDeferredPhase = DeferredGenerationPhase.RiverWater;
        RiverSplineCache = new Dictionary<string, Spline>(StringComparer.Ordinal);
        RiverRefreshRequests = new List<GeneratedTerrainRequest>(Requests.Count);
        RiverRefreshTerrains = new List<GStylizedTerrain>(Requests.Count);
        VegetationRefreshRequests = new List<GeneratedTerrainRequest>(Requests.Count);
        VegetationRefreshTerrains = new List<GStylizedTerrain>(Requests.Count);
        VegetationClearOnlyTerrains = new List<GStylizedTerrain>(Requests.Count);
        PhaseTimingsMilliseconds = new Dictionary<string, double>(StringComparer.Ordinal);
        VegetationTileStats = new Dictionary<Vector2Int, VegetationTileStreamingStats>();
        MissingPrefabCountsByPath = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
        VegetationQueuedPlacementsByBucket = new Dictionary<string, int>(StringComparer.Ordinal);
        VegetationQueuedWorkItemsByBucket = new Dictionary<string, int>(StringComparer.Ordinal);

        for (int i = 0; i < Requests.Count; i++)
        {
            GeneratedTerrainRequest request = Requests[i];
            RequestsByCoordinate[request.TileCoordinate] = request;
        }
    }

    public string CacheKey { get; }
    public string CacheSignature { get; }
    public int PipelineId { get; }
    public Vector3Int CenterTileCoordinate { get; }
    public Vector3 BatchRootLocalPosition { get; }
    public IReadOnlyList<GeneratedTerrainRequest> Requests { get; }
    public IReadOnlyList<Vector2Int> OrderedTileCoordinates { get; }
    public double NormalizationMinHeight { get; }
    public double NormalizationMaxHeight { get; }
    public List<GStylizedTerrain> ActiveTerrains { get; }
    public List<GStylizedTerrain> CreatedTerrains { get; }
    public List<GeneratedTerrainRequest> CreatedRequests { get; }
    public Dictionary<Vector2Int, GStylizedTerrain> TerrainByCoordinate { get; }
    public Dictionary<Vector2Int, GeneratedTerrainRequest> RequestsByCoordinate { get; }
    public Transform? BatchRoot { get; set; }
    public DeferredGenerationPhase NextDeferredPhase { get; set; }
    public Dictionary<string, Spline> RiverSplineCache { get; }
    public List<GeneratedTerrainRequest> RiverRefreshRequests { get; }
    public List<GStylizedTerrain> RiverRefreshTerrains { get; }
    public List<GeneratedTerrainRequest> VegetationRefreshRequests { get; }
    public List<GStylizedTerrain> VegetationRefreshTerrains { get; }
    public List<GStylizedTerrain> VegetationClearOnlyTerrains { get; }
    public Dictionary<string, double> PhaseTimingsMilliseconds { get; }
    public Dictionary<Vector2Int, VegetationTileStreamingStats> VegetationTileStats { get; }
    public Dictionary<string, int> MissingPrefabCountsByPath { get; }
    public Dictionary<string, int> VegetationQueuedPlacementsByBucket { get; }
    public Dictionary<string, int> VegetationQueuedWorkItemsByBucket { get; }
    public Vector3? VegetationStreamingTargetWorldPosition { get; set; }
    public bool TerrainStageVisible { get; set; }
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
    public int PlayerCentricSurfaceTileCacheBuildCount { get; set; }
    public int PlayerCentricSurfaceCellBuildCount { get; set; }
    public int PlayerCentricSurfacePlacementCount { get; set; }
    public int PlayerCentricSurfaceActiveCellCount { get; set; }
    public int PlayerCentricSurfaceActivatedCellCount { get; set; }
    public int PlayerCentricSurfaceDeactivatedCellCount { get; set; }
    public int PlayerCentricSurfaceMissingPrefabCount { get; set; }
    public double PlayerCentricSurfaceSourceBuildCpuMilliseconds { get; set; }
    public double PlayerCentricSurfaceFirstVisibleMilliseconds { get; set; }
    public double PlayerCentricSurfaceFullSettledMilliseconds { get; set; }

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

internal sealed class GeneratedTerrainBatchCacheEntry
{
    public GeneratedTerrainBatchCacheEntry(
        string cacheKey,
        string cacheSignature,
        Vector3Int centerTileCoordinate,
        Vector3 batchRootLocalPosition,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        IReadOnlyList<GeneratedTerrainRequest> requests,
        IReadOnlyList<Vector2Int> orderedTileCoordinates)
    {
        CacheKey = cacheKey;
        CacheSignature = cacheSignature;
        CenterTileCoordinate = centerTileCoordinate;
        BatchRootLocalPosition = batchRootLocalPosition;
        NormalizationMinHeight = normalizationMinHeight;
        NormalizationMaxHeight = normalizationMaxHeight;
        Requests = requests?.ToArray() ?? Array.Empty<GeneratedTerrainRequest>();
        OrderedTileCoordinates = orderedTileCoordinates?.ToArray() ?? Array.Empty<Vector2Int>();
    }

    public string CacheKey { get; }
    public string CacheSignature { get; }
    public Vector3Int CenterTileCoordinate { get; }
    public Vector3 BatchRootLocalPosition { get; }
    public double NormalizationMinHeight { get; }
    public double NormalizationMaxHeight { get; }
    public IReadOnlyList<GeneratedTerrainRequest> Requests { get; }
    public IReadOnlyList<Vector2Int> OrderedTileCoordinates { get; }

    public GeneratedTerrainBatchState CreateState(int pipelineId)
    {
        return new GeneratedTerrainBatchState(
            CacheKey,
            CacheSignature,
            pipelineId,
            CenterTileCoordinate,
            BatchRootLocalPosition,
            Requests,
            OrderedTileCoordinates,
            NormalizationMinHeight,
            NormalizationMaxHeight);
    }
}

internal readonly struct CachedLoadedWorldData
{
    public CachedLoadedWorldData(DateTime lastWriteUtc, LoadedWorldData data)
    {
        LastWriteUtc = lastWriteUtc;
        Data = data;
    }

    public DateTime LastWriteUtc { get; }
    public LoadedWorldData Data { get; }
}

internal enum DeferredGenerationPhase
{
    RiverWater,
    DebugSplines,
    Vegetation,
    Completed,
}

internal enum VegetationPriorityBucket
{
    CenterCanopyAndLarge,
    CenterClutterAndGround,
    OuterCanopyAndLarge,
    OuterClutter,
    OuterGroundAndDebris,
}

internal enum VegetationDensityZone
{
    High,
    Mid,
    Outer,
}

internal enum VegetationPlacementPhase
{
    PrefabResolve,
    PrototypeResolve,
    PositionBuild,
    NormalBuild,
    RendererFinalize,
}

internal enum VegetationTileStreamingStatus
{
    Pending,
    Visible,
    Settled,
    Interrupted,
}

internal enum VegetationLoadMode
{
    LegacyGameObjects,
    HybridInteractive,
    InstancesOnly,
}

internal enum TerrainShadingMode
{
    PolarisTextureBlend,
    FallbackLit,
}
