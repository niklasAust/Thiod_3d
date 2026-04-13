using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using Pinwheel.Griffin;
using UnityEngine;
using WorldGen;

#nullable enable

namespace Thiod.TileLoading.Runtime
{

internal readonly struct PlayerCentricSurfaceCellKey : IEquatable<PlayerCentricSurfaceCellKey>
{
    public PlayerCentricSurfaceCellKey(int x, int y, Vector2Int ownerTileCoordinate)
    {
        X = x;
        Y = y;
        OwnerTileCoordinate = ownerTileCoordinate;
    }

    public int X { get; }
    public int Y { get; }
    public Vector2Int OwnerTileCoordinate { get; }

    public bool Equals(PlayerCentricSurfaceCellKey other)
        => X == other.X &&
           Y == other.Y &&
           OwnerTileCoordinate == other.OwnerTileCoordinate;

    public override bool Equals(object? obj)
        => obj is PlayerCentricSurfaceCellKey other && Equals(other);

    public override int GetHashCode()
        => HashCode.Combine(X, Y, OwnerTileCoordinate);

    public override string ToString()
        => $"cell({X},{Y})@tile({OwnerTileCoordinate.x},{OwnerTileCoordinate.y})";
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

internal sealed class PlayerCentricSurfaceController
{
    private readonly IPlayerCentricSurfaceSettingsPort settings;
    private readonly IGenerationTelemetryPort telemetry;
    private readonly IPlayerCentricSurfaceBudgetPort budget;
    private readonly IPlayerCentricSurfaceGeometryPort geometry;
    private readonly IPlayerCentricSurfacePrototypePort prototypes;
    private readonly IPlayerCentricSurfaceRendererPort rendererPort;
    private readonly PlayerCentricSurfaceCacheBuilder cacheBuilder;
    private readonly Dictionary<Vector2Int, PlayerCentricSurfaceTileCache> tileCaches = new();
    private readonly Dictionary<PlayerCentricSurfaceCellKey, PlayerCentricSurfaceCellSource> cellSources = new();
    private readonly Dictionary<int, Vector2Int> tileByTerrainInstanceId = new();
    private readonly HashSet<PlayerCentricSurfaceCellKey> activeCellKeys = new();
    private float nextUpdateTime;

    public PlayerCentricSurfaceController(
        IPlayerCentricSurfaceSettingsPort settings,
        IGenerationTelemetryPort telemetry,
        IPlayerCentricSurfaceBudgetPort budget,
        IPlayerCentricSurfaceGeometryPort geometry,
        IPlayerCentricSurfacePrototypePort prototypes,
        IPlayerCentricSurfaceRendererPort rendererPort)
    {
        this.settings = settings;
        this.telemetry = telemetry;
        this.budget = budget;
        this.geometry = geometry;
        this.prototypes = prototypes;
        this.rendererPort = rendererPort;
        cacheBuilder = new PlayerCentricSurfaceCacheBuilder(settings, budget, geometry, prototypes);
    }

    public void ResetState()
    {
        nextUpdateTime = 0f;
    }

    public void ClearCaches()
    {
        foreach (PlayerCentricSurfaceCellKey cellKey in activeCellKeys.ToArray())
        {
            if (cellSources.TryGetValue(cellKey, out PlayerCentricSurfaceCellSource? source))
            {
                SetCellActive(source, false);
            }
        }

        foreach (KeyValuePair<Vector2Int, PlayerCentricSurfaceTileCache> entry in tileCaches.ToArray())
        {
            RemoveTileCache(entry.Key);
        }

        tileCaches.Clear();
        cellSources.Clear();
        tileByTerrainInstanceId.Clear();
        activeCellKeys.Clear();
    }

    public void PruneTileCaches(IEnumerable<Vector2Int> activeTileCoordinates)
    {
        var activeCoordinates = new HashSet<Vector2Int>(activeTileCoordinates);
        foreach (KeyValuePair<Vector2Int, PlayerCentricSurfaceTileCache> entry in tileCaches.ToArray())
        {
            if (activeCoordinates.Contains(entry.Key))
            {
                continue;
            }

            RemoveTileCache(entry.Key);
        }
    }

    public void RemoveCachesOwnedByContainer(Transform container)
    {
        if (container == null)
        {
            return;
        }

        var ownedTiles = new HashSet<Vector2Int>();
        foreach (GStylizedTerrain terrain in container.GetComponentsInChildren<GStylizedTerrain>(true))
        {
            if (terrain == null)
            {
                continue;
            }

            if (tileByTerrainInstanceId.TryGetValue(terrain.GetInstanceID(), out Vector2Int tileCoordinate))
            {
                ownedTiles.Add(tileCoordinate);
            }
        }

        foreach (Vector2Int tileCoordinate in ownedTiles)
        {
            RemoveTileCache(tileCoordinate);
        }
    }

    public void UpdateVegetation(
        bool forceImmediate,
        GeneratedTerrainBatchState? batchState = null,
        Stopwatch? totalStopwatch = null)
    {
        if (!ShouldUsePlayerCentricSurfaceVegetation())
        {
            foreach (PlayerCentricSurfaceCellKey activeCellKey in activeCellKeys.ToArray())
            {
                if (cellSources.TryGetValue(activeCellKey, out PlayerCentricSurfaceCellSource? activeSource))
                {
                    SetCellActive(activeSource, false);
                }
            }

            return;
        }

        if (!forceImmediate && Time.unscaledTime < nextUpdateTime)
        {
            return;
        }

        nextUpdateTime = Time.unscaledTime + Mathf.Max(0.01f, settings.PlayerCentricSurfaceUpdateIntervalSecondsInternal);
        Vector3? targetWorldPosition = settings.ResolveVegetationStreamingTargetWorldPositionInternal();
        int activatedCellCount = 0;
        int deactivatedCellCount = 0;

        if (!targetWorldPosition.HasValue)
        {
            foreach (PlayerCentricSurfaceCellKey activeCellKey in activeCellKeys.ToArray())
            {
                if (!cellSources.TryGetValue(activeCellKey, out PlayerCentricSurfaceCellSource? source))
                {
                    continue;
                }

                SetCellActive(source, false);
                deactivatedCellCount++;
            }

            RecordSurfaceUpdate(batchState, totalStopwatch, activatedCellCount, deactivatedCellCount);
            return;
        }

        float activationRadius = Mathf.Max(0f, settings.PlayerCentricSurfaceRadiusMetersInternal);
        float retentionRadius = activationRadius + Mathf.Max(0f, settings.PlayerCentricSurfaceHysteresisMetersInternal);
        var desiredCellKeys = new HashSet<PlayerCentricSurfaceCellKey>();
        foreach (KeyValuePair<PlayerCentricSurfaceCellKey, PlayerCentricSurfaceCellSource> entry in cellSources)
        {
            float radiusMeters = activeCellKeys.Contains(entry.Key)
                ? retentionRadius
                : activationRadius;
            if (DoesCellIntersectRadius(entry.Key, targetWorldPosition.Value, radiusMeters))
            {
                desiredCellKeys.Add(entry.Key);
            }
        }

        foreach (PlayerCentricSurfaceCellKey activeCellKey in activeCellKeys.ToArray())
        {
            if (desiredCellKeys.Contains(activeCellKey) ||
                !cellSources.TryGetValue(activeCellKey, out PlayerCentricSurfaceCellSource? source))
            {
                continue;
            }

            SetCellActive(source, false);
            deactivatedCellCount++;
        }

        foreach (PlayerCentricSurfaceCellKey desiredCellKey in desiredCellKeys)
        {
            if (activeCellKeys.Contains(desiredCellKey) ||
                !cellSources.TryGetValue(desiredCellKey, out PlayerCentricSurfaceCellSource? source))
            {
                continue;
            }

            if (SetCellActive(source, true))
            {
                activatedCellCount++;
            }
        }

        RecordSurfaceUpdate(batchState, totalStopwatch, activatedCellCount, deactivatedCellCount);
    }

    public void EnsureCaches(GeneratedTerrainBatchState batchState, Stopwatch totalStopwatch)
    {
        if (!ShouldUsePlayerCentricSurfaceVegetation())
        {
            return;
        }

        var sourceBuildStopwatch = Stopwatch.StartNew();
        int builtTileCacheCount = 0;
        int builtCellCount = 0;
        int builtPlacementCount = 0;
        for (int i = 0; i < batchState.Requests.Count; i++)
        {
            GeneratedTerrainRequest request = batchState.Requests[i];
            if (!TryGetTileCacheBuildTerrain(batchState, request, out Vector2Int tileCoordinate, out GStylizedTerrain? terrain))
            {
                continue;
            }

            if (!cacheBuilder.HasSurfacePlacements(request))
            {
                RemoveTileCache(tileCoordinate);
                continue;
            }

            if (tileCaches.TryGetValue(tileCoordinate, out PlayerCentricSurfaceTileCache? existingCache) &&
                cacheBuilder.CanReuseTileCache(batchState, terrain, existingCache))
            {
                tileByTerrainInstanceId[terrain.GetInstanceID()] = tileCoordinate;
                continue;
            }

            RemoveTileCache(tileCoordinate);
            PlayerCentricSurfaceBuildResult? buildResult = cacheBuilder.BuildTileCache(batchState, terrain, request);
            if (buildResult == null)
            {
                continue;
            }

            CommitBuildResult(buildResult);
            builtTileCacheCount++;
            builtCellCount += buildResult.CellCount;
            builtPlacementCount += buildResult.PlacementCount;
        }

        sourceBuildStopwatch.Stop();
        batchState.PlayerCentricSurfaceTileCacheBuildCount += builtTileCacheCount;
        batchState.PlayerCentricSurfaceCellBuildCount += builtCellCount;
        batchState.PlayerCentricSurfacePlacementCount += builtPlacementCount;
        batchState.PlayerCentricSurfaceSourceBuildCpuMilliseconds += sourceBuildStopwatch.Elapsed.TotalMilliseconds;
        telemetry.RecordGenerationPhaseTimingInternal(batchState, "player-centric surface source build", sourceBuildStopwatch.Elapsed);
        if (sourceBuildStopwatch.Elapsed.TotalMilliseconds > 0d)
        {
            telemetry.LogGenerationPhaseTimingInternal("player-centric surface source build", sourceBuildStopwatch.Elapsed);
        }

        UpdateVegetation(forceImmediate: true, batchState, totalStopwatch);
    }

    public IEnumerator EnsureCachesOverMultipleFrames(GeneratedTerrainBatchState batchState, Stopwatch totalStopwatch)
    {
        if (!ShouldUsePlayerCentricSurfaceVegetation())
        {
            yield break;
        }

        var sourceBuildStopwatch = Stopwatch.StartNew();
        var frameStopwatch = Stopwatch.StartNew();
        budget.RestartRuntimeChunkStopwatch(frameStopwatch);
        float frameBudgetMilliseconds = budget.ResolveRuntimePhaseBudgetMsInternal(budget.PlayerCentricSurfaceBuildBudgetMsPerFrameInternal);
        int builtTileCacheCount = 0;
        int builtCellCount = 0;
        int builtPlacementCount = 0;

        for (int i = 0; i < batchState.Requests.Count; i++)
        {
            if (batchState.PipelineId != budget.ActiveGenerationPipelineIdInternal)
            {
                yield break;
            }

            GeneratedTerrainRequest request = batchState.Requests[i];
            if (!TryGetTileCacheBuildTerrain(batchState, request, out Vector2Int tileCoordinate, out GStylizedTerrain? terrain))
            {
                continue;
            }

            if (!cacheBuilder.HasSurfacePlacements(request))
            {
                RemoveTileCache(tileCoordinate);
                continue;
            }

            if (tileCaches.TryGetValue(tileCoordinate, out PlayerCentricSurfaceTileCache? existingCache) &&
                cacheBuilder.CanReuseTileCache(batchState, terrain, existingCache))
            {
                tileByTerrainInstanceId[terrain.GetInstanceID()] = tileCoordinate;
                continue;
            }

            RemoveTileCache(tileCoordinate);
            PlayerCentricSurfaceBuildResult? buildResult = null;
            yield return cacheBuilder.BuildTileCacheOverMultipleFrames(
                batchState,
                terrain,
                request,
                frameStopwatch,
                frameBudgetMilliseconds,
                result => buildResult = result);

            if (buildResult == null)
            {
                continue;
            }

            CommitBuildResult(buildResult);
            builtTileCacheCount++;
            builtCellCount += buildResult.CellCount;
            builtPlacementCount += buildResult.PlacementCount;

            if (budget.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
            {
                budget.CommitRuntimeChunk(frameStopwatch);
                yield return null;
                budget.RestartRuntimeChunkStopwatch(frameStopwatch);
            }
        }

        sourceBuildStopwatch.Stop();
        batchState.PlayerCentricSurfaceTileCacheBuildCount += builtTileCacheCount;
        batchState.PlayerCentricSurfaceCellBuildCount += builtCellCount;
        batchState.PlayerCentricSurfacePlacementCount += builtPlacementCount;
        batchState.PlayerCentricSurfaceSourceBuildCpuMilliseconds += sourceBuildStopwatch.Elapsed.TotalMilliseconds;
        telemetry.RecordGenerationPhaseTimingInternal(batchState, "player-centric surface source build", sourceBuildStopwatch.Elapsed);
        if (sourceBuildStopwatch.Elapsed.TotalMilliseconds > 0d)
        {
            telemetry.LogGenerationPhaseTimingInternal("player-centric surface source build", sourceBuildStopwatch.Elapsed);
        }

        UpdateVegetation(forceImmediate: true, batchState, totalStopwatch);
    }

    private bool TryGetTileCacheBuildTerrain(
        GeneratedTerrainBatchState batchState,
        GeneratedTerrainRequest request,
        out Vector2Int tileCoordinate,
        out GStylizedTerrain terrain)
    {
        tileCoordinate = geometry.GetTileCoordinateInternal(request);
        terrain = null!;
        if (!batchState.TerrainByCoordinate.TryGetValue(tileCoordinate, out GStylizedTerrain? resolvedTerrain) ||
            resolvedTerrain == null)
        {
            return false;
        }

        terrain = resolvedTerrain;
        return true;
    }

    private void CommitBuildResult(PlayerCentricSurfaceBuildResult buildResult)
    {
        tileCaches[buildResult.TileCache.TileCoordinate] = buildResult.TileCache;
        tileByTerrainInstanceId[buildResult.TileCache.TerrainInstanceId] = buildResult.TileCache.TileCoordinate;
        CommitStagedCellSources(buildResult.StagedCellSources);
    }

    private void RemoveTileCache(Vector2Int tileCoordinate)
    {
        if (!tileCaches.TryGetValue(tileCoordinate, out PlayerCentricSurfaceTileCache? cache))
        {
            return;
        }

        if (cache.Terrain != null)
        {
            Transform? surfaceRoot = FindSurfaceRoot(cache.Terrain.transform);
            if (surfaceRoot != null)
            {
                rendererPort.RetireGeneratedContainerInternal(surfaceRoot);
            }
        }

        foreach (PlayerCentricSurfaceCellKey cellKey in cache.CellKeys)
        {
            activeCellKeys.Remove(cellKey);
            if (cellSources.TryGetValue(cellKey, out PlayerCentricSurfaceCellSource? source))
            {
                source.RuntimeContainer = null;
                cellSources.Remove(cellKey);
            }
        }

        tileCaches.Remove(tileCoordinate);
        tileByTerrainInstanceId.Remove(cache.TerrainInstanceId);
    }

    private void RecordSurfaceUpdate(
        GeneratedTerrainBatchState? batchState,
        Stopwatch? totalStopwatch,
        int activatedCellCount,
        int deactivatedCellCount)
    {
        if (batchState == null)
        {
            return;
        }

        batchState.PlayerCentricSurfaceActivatedCellCount += activatedCellCount;
        batchState.PlayerCentricSurfaceDeactivatedCellCount += deactivatedCellCount;
        batchState.PlayerCentricSurfaceActiveCellCount = activeCellKeys.Count;
        if (totalStopwatch == null)
        {
            return;
        }

        double elapsedMilliseconds = totalStopwatch.Elapsed.TotalMilliseconds;
        if (batchState.PlayerCentricSurfaceFirstVisibleMilliseconds <= 0d &&
            activeCellKeys.Count > 0)
        {
            batchState.PlayerCentricSurfaceFirstVisibleMilliseconds = elapsedMilliseconds;
        }

        batchState.PlayerCentricSurfaceFullSettledMilliseconds = elapsedMilliseconds;
    }

    private void CommitStagedCellSources(
        Dictionary<PlayerCentricSurfaceCellKey, PlayerCentricSurfaceCellSource> stagedCellSources)
    {
        foreach (KeyValuePair<PlayerCentricSurfaceCellKey, PlayerCentricSurfaceCellSource> entry in stagedCellSources)
        {
            if (!cellSources.TryGetValue(entry.Key, out PlayerCentricSurfaceCellSource? existingSource))
            {
                cellSources[entry.Key] = entry.Value;
                continue;
            }

            MergeCellSource(existingSource, entry.Value);
            if (existingSource.RuntimeContainer != null && existingSource.RuntimeContainer.gameObject.activeSelf)
            {
                InitializeCellRenderer(existingSource);
            }
        }
    }

    private static void MergeCellSource(
        PlayerCentricSurfaceCellSource target,
        PlayerCentricSurfaceCellSource source)
    {
        if (target == null || source == null)
        {
            return;
        }

        target.Terrain = source.Terrain;
        for (int prototypeIndex = 0; prototypeIndex < source.Prototypes.Count; prototypeIndex++)
        {
            TileLoaderInstancedVegetationPrototype prototype = source.Prototypes[prototypeIndex];
            int resolvedTargetPrototypeIndex;
            if (!target.PrototypeIndices.TryGetValue(prototype.Key, out resolvedTargetPrototypeIndex))
            {
                resolvedTargetPrototypeIndex = target.Prototypes.Count;
                target.PrototypeIndices[prototype.Key] = resolvedTargetPrototypeIndex;
                target.Prototypes.Add(prototype);
            }

            for (int placementIndex = 0; placementIndex < source.Placements.Count; placementIndex++)
            {
                TileLoaderInstancedVegetationPlacement placement = source.Placements[placementIndex];
                if (placement.PrototypeIndex != prototypeIndex)
                {
                    continue;
                }

                target.Placements.Add(new TileLoaderInstancedVegetationPlacement(
                    resolvedTargetPrototypeIndex,
                    placement.LocalPosition,
                    placement.LocalRotation,
                    placement.LocalScale,
                    placement.ConformToTerrainOnPromotion,
                    placement.SurfaceSampleLocalX,
                    placement.SurfaceSampleLocalZ,
                    placement.SurfaceVerticalOffset,
                    placement.SurfaceNormalOffset));
            }
        }
    }

    private void InitializeCellRenderer(PlayerCentricSurfaceCellSource source)
    {
        if (source.RuntimeContainer == null)
        {
            return;
        }

        TileLoaderInstancedVegetationRenderer renderer =
            source.RuntimeContainer.GetComponent<TileLoaderInstancedVegetationRenderer>() ??
            source.RuntimeContainer.gameObject.AddComponent<TileLoaderInstancedVegetationRenderer>();
        source.RuntimeContainer.gameObject.SetActive(true);
        renderer.Initialize(
            source.Prototypes,
            source.Placements,
            interactive: rendererPort.VegetationLoadModeInternal == VegetationLoadMode.HybridInteractive,
            interactionRadiusMeters: rendererPort.VegetationInteractionRadiusMetersInternal,
            interactionHysteresisMeters: rendererPort.VegetationInteractionHysteresisMetersInternal,
            rendererPort.RuntimeBudgetOwnerInternal,
            rendererPort.PrototypeInitBudgetMsPerFrameInternal);
    }

    private bool SetCellActive(PlayerCentricSurfaceCellSource source, bool active)
    {
        if (!active)
        {
            if (source.RuntimeContainer != null)
            {
                source.RuntimeContainer.gameObject.SetActive(false);
            }

            activeCellKeys.Remove(source.CellKey);
            return false;
        }

        if (source.Terrain == null || source.Placements.Count == 0)
        {
            return false;
        }

        Transform surfaceRoot = GetOrCreateSurfaceRoot(source.Terrain.transform);
        if (source.RuntimeContainer == null)
        {
            string cellContainerName = GetCellContainerName(source.CellKey);
            Transform? existing = surfaceRoot.Find(cellContainerName);
            if (existing == null)
            {
                var container = new GameObject(cellContainerName);
                container.transform.SetParent(surfaceRoot, false);
                container.transform.localPosition = Vector3.zero;
                container.transform.localRotation = Quaternion.identity;
                container.transform.localScale = Vector3.one;
                source.RuntimeContainer = container.transform;
            }
            else
            {
                source.RuntimeContainer = existing;
            }

            InitializeCellRenderer(source);
        }
        else if (!source.RuntimeContainer.gameObject.activeSelf)
        {
            source.RuntimeContainer.gameObject.SetActive(true);
        }

        activeCellKeys.Add(source.CellKey);
        return source.RuntimeContainer != null && source.RuntimeContainer.gameObject.activeInHierarchy;
    }

    private bool DoesCellIntersectRadius(
        PlayerCentricSurfaceCellKey cellKey,
        Vector3 targetWorldPosition,
        float radiusMeters)
    {
        if (radiusMeters <= 0f)
        {
            return false;
        }

        float cellSizeMeters = Mathf.Max(1f, settings.PlayerCentricSurfaceCellSizeMetersInternal);
        float minX = cellKey.X * cellSizeMeters;
        float maxX = minX + cellSizeMeters;
        float minZ = cellKey.Y * cellSizeMeters;
        float maxZ = minZ + cellSizeMeters;
        float deltaX = targetWorldPosition.x < minX
            ? minX - targetWorldPosition.x
            : targetWorldPosition.x > maxX
                ? targetWorldPosition.x - maxX
                : 0f;
        float deltaZ = targetWorldPosition.z < minZ
            ? minZ - targetWorldPosition.z
            : targetWorldPosition.z > maxZ
                ? targetWorldPosition.z - maxZ
                : 0f;
        return deltaX * deltaX + deltaZ * deltaZ <= radiusMeters * radiusMeters;
    }

    private bool ShouldUsePlayerCentricSurfaceVegetation()
    {
        return settings.IsPlayingInternal &&
               settings.PlayerCentricSurfaceVegetationEnabledInternal &&
               settings.PlaceSurfaceObjectsInternal;
    }

    private string GetSurfaceRootName()
    {
        return rendererPort.GetVegetationContainerNameInternal() + "_Surface";
    }

    private string GetCellContainerName(PlayerCentricSurfaceCellKey cellKey)
    {
        return $"Cell_{cellKey.X}_{cellKey.Y}";
    }

    private Transform? FindSurfaceRoot(Transform terrainTransform)
    {
        if (terrainTransform == null)
        {
            return null;
        }

        return terrainTransform.Find(GetSurfaceRootName());
    }

    private Transform GetOrCreateSurfaceRoot(Transform terrainTransform)
    {
        Transform? existing = FindSurfaceRoot(terrainTransform);
        if (existing != null)
        {
            return existing;
        }

        var container = new GameObject(GetSurfaceRootName());
        container.transform.SetParent(terrainTransform, false);
        container.transform.localPosition = Vector3.zero;
        container.transform.localRotation = Quaternion.identity;
        container.transform.localScale = Vector3.one;
        return container.transform;
    }
}

internal sealed class PlayerCentricSurfaceBuildResult
{
    public PlayerCentricSurfaceBuildResult(
        PlayerCentricSurfaceTileCache tileCache,
        Dictionary<PlayerCentricSurfaceCellKey, PlayerCentricSurfaceCellSource> stagedCellSources,
        int placementCount)
    {
        TileCache = tileCache;
        StagedCellSources = stagedCellSources;
        PlacementCount = placementCount;
    }

    public PlayerCentricSurfaceTileCache TileCache { get; }
    public Dictionary<PlayerCentricSurfaceCellKey, PlayerCentricSurfaceCellSource> StagedCellSources { get; }
    public int CellCount => TileCache.CellKeys.Count;
    public int PlacementCount { get; }
}

internal sealed class PlayerCentricSurfaceCacheBuilder
{
    private readonly IPlayerCentricSurfaceSettingsPort settings;
    private readonly IPlayerCentricSurfaceBudgetPort budget;
    private readonly IPlayerCentricSurfaceGeometryPort geometry;
    private readonly IPlayerCentricSurfacePrototypePort prototypes;

    public PlayerCentricSurfaceCacheBuilder(
        IPlayerCentricSurfaceSettingsPort settings,
        IPlayerCentricSurfaceBudgetPort budget,
        IPlayerCentricSurfaceGeometryPort geometry,
        IPlayerCentricSurfacePrototypePort prototypes)
    {
        this.settings = settings;
        this.budget = budget;
        this.geometry = geometry;
        this.prototypes = prototypes;
    }

    public bool HasSurfacePlacements(GeneratedTerrainRequest request)
    {
        IReadOnlyList<TileObjectPlacement> placedObjects = request.Layers.PlacedObjects ?? Array.Empty<TileObjectPlacement>();
        for (int i = 0; i < placedObjects.Count; i++)
        {
            if (ShouldRouteToPlayerCentricSurface(placedObjects[i]))
            {
                return true;
            }
        }

        return false;
    }

    public bool CanReuseTileCache(
        GeneratedTerrainBatchState batchState,
        GStylizedTerrain terrain,
        PlayerCentricSurfaceTileCache? existingCache)
    {
        return existingCache != null &&
               existingCache.CacheSignature == ResolveCacheSignature(batchState.CacheSignature) &&
               existingCache.TerrainInstanceId == terrain.GetInstanceID() &&
               existingCache.Terrain == terrain;
    }

    public PlayerCentricSurfaceBuildResult? BuildTileCache(
        GeneratedTerrainBatchState batchState,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request)
    {
        List<PreparedVegetationPlacement> preparedPlacements = PreparePlacementsForRequest(batchState, terrain, request);
        return BuildTileCacheResult(batchState, terrain, request, preparedPlacements);
    }

    public IEnumerator BuildTileCacheOverMultipleFrames(
        GeneratedTerrainBatchState batchState,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        Stopwatch frameStopwatch,
        float frameBudgetMilliseconds,
        Action<PlayerCentricSurfaceBuildResult?> assignResult)
    {
        List<PreparedVegetationPlacement> preparedPlacements = new();
        yield return PreparePlacementsForRequestOverMultipleFrames(
            batchState,
            terrain,
            request,
            frameStopwatch,
            frameBudgetMilliseconds,
            placements => preparedPlacements = placements);

        PlayerCentricSurfaceBuildResult? result = null;
        yield return BuildTileCacheResultOverMultipleFrames(
            batchState,
            terrain,
            request,
            preparedPlacements,
            frameStopwatch,
            frameBudgetMilliseconds,
            buildResult => result = buildResult);
        assignResult(result);
    }

    private IEnumerator BuildTileCacheResultOverMultipleFrames(
        GeneratedTerrainBatchState batchState,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        List<PreparedVegetationPlacement> preparedPlacements,
        Stopwatch frameStopwatch,
        float frameBudgetMilliseconds,
        Action<PlayerCentricSurfaceBuildResult?> assignResult)
    {
        PlayerCentricSurfaceBuildResult? result = null;
        if (preparedPlacements.Count > 0)
        {
            Vector2Int tileCoordinate = geometry.GetTileCoordinateInternal(request);
            var stagedCellSources = new Dictionary<PlayerCentricSurfaceCellKey, PlayerCentricSurfaceCellSource>();
            var tileCache = new PlayerCentricSurfaceTileCache(
                tileCoordinate,
                ResolveCacheSignature(batchState.CacheSignature),
                terrain);
            var buildState = new HybridVegetationBuildState(
                null,
                terrain,
                request,
                existingVegetationContainer: null,
                batchState.NormalizationMinHeight,
                batchState.NormalizationMaxHeight);

            for (int placementIndex = 0; placementIndex < preparedPlacements.Count; placementIndex++)
            {
                TryAddPreparedPlacementToCache(
                    batchState,
                    buildState,
                    preparedPlacements[placementIndex],
                    tileCoordinate,
                    tileCache,
                    stagedCellSources);

                if (!budget.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
                {
                    continue;
                }

                budget.CommitRuntimeChunk(frameStopwatch);
                yield return null;
                budget.RestartRuntimeChunkStopwatch(frameStopwatch);
            }

            result = FinalizeBuildResult(tileCache, stagedCellSources);
        }

        assignResult(result);
        if (budget.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
        {
            budget.CommitRuntimeChunk(frameStopwatch);
            yield return null;
            budget.RestartRuntimeChunkStopwatch(frameStopwatch);
        }
    }

    private PlayerCentricSurfaceBuildResult? BuildTileCacheResult(
        GeneratedTerrainBatchState batchState,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        List<PreparedVegetationPlacement> preparedPlacements)
    {
        if (preparedPlacements.Count == 0)
        {
            return null;
        }

        Vector2Int tileCoordinate = geometry.GetTileCoordinateInternal(request);
        var tileCache = new PlayerCentricSurfaceTileCache(
            tileCoordinate,
            ResolveCacheSignature(batchState.CacheSignature),
            terrain);
        var stagedCellSources = new Dictionary<PlayerCentricSurfaceCellKey, PlayerCentricSurfaceCellSource>();
        var buildState = new HybridVegetationBuildState(
            null,
            terrain,
            request,
            existingVegetationContainer: null,
            batchState.NormalizationMinHeight,
            batchState.NormalizationMaxHeight);

        for (int placementIndex = 0; placementIndex < preparedPlacements.Count; placementIndex++)
        {
            TryAddPreparedPlacementToCache(
                batchState,
                buildState,
                preparedPlacements[placementIndex],
                tileCoordinate,
                tileCache,
                stagedCellSources);
        }

        return FinalizeBuildResult(tileCache, stagedCellSources);
    }

    private bool TryAddPreparedPlacementToCache(
        GeneratedTerrainBatchState batchState,
        HybridVegetationBuildState buildState,
        PreparedVegetationPlacement preparedPlacement,
        Vector2Int tileCoordinate,
        PlayerCentricSurfaceTileCache tileCache,
        Dictionary<PlayerCentricSurfaceCellKey, PlayerCentricSurfaceCellSource> stagedCellSources)
    {
        TileObjectPlacement placement = preparedPlacement.Placement;
        GameObject? prefab = prototypes.LoadPrefabForPlacementInternal(placement, batchState);
        if (prefab == null)
        {
            batchState.PlayerCentricSurfaceMissingPrefabCount++;
            return false;
        }

        bool isTreeObject = prototypes.IsTreePlacementInternal(placement, prefab);
        if (isTreeObject)
        {
            return false;
        }

        TileLoaderInstancedVegetationPrototype? prototype = prototypes.GetOrCreateVegetationPrototypeInternal(
            null,
            placement,
            prefab,
            isTreeObject: false,
            supportsPromotion: prototypes.SupportsHybridPromotionInternal(placement));
        if (prototype == null ||
            !TryBuildInstancedPlacement(
                buildState,
                preparedPlacement,
                out TileLoaderInstancedVegetationPlacement instancedPlacement))
        {
            return false;
        }

        PlayerCentricSurfaceCellKey cellKey = ResolveCellKey(preparedPlacement.Geometry.WorldPosition, tileCoordinate);
        if (!stagedCellSources.TryGetValue(cellKey, out PlayerCentricSurfaceCellSource? cellSource))
        {
            cellSource = new PlayerCentricSurfaceCellSource(cellKey, tileCoordinate, buildState.Terrain);
            stagedCellSources[cellKey] = cellSource;
        }

        cellSource.Terrain = buildState.Terrain;
        tileCache.CellKeys.Add(cellKey);
        if (!cellSource.PrototypeIndices.TryGetValue(prototype.Key, out int prototypeIndex))
        {
            prototypeIndex = cellSource.Prototypes.Count;
            cellSource.PrototypeIndices[prototype.Key] = prototypeIndex;
            cellSource.Prototypes.Add(prototype);
        }

        cellSource.Placements.Add(new TileLoaderInstancedVegetationPlacement(
            prototypeIndex,
            instancedPlacement.LocalPosition,
            instancedPlacement.LocalRotation,
            instancedPlacement.LocalScale,
            conformToTerrainOnPromotion: preparedPlacement.Geometry.UseExactTerrainConformOnPromotion,
            instancedPlacement.SurfaceSampleLocalX,
            instancedPlacement.SurfaceSampleLocalZ,
            instancedPlacement.SurfaceVerticalOffset,
            instancedPlacement.SurfaceNormalOffset));
        return true;
    }

    private PlayerCentricSurfaceBuildResult? FinalizeBuildResult(
        PlayerCentricSurfaceTileCache tileCache,
        Dictionary<PlayerCentricSurfaceCellKey, PlayerCentricSurfaceCellSource> stagedCellSources)
    {
        if (tileCache.CellKeys.Count == 0)
        {
            return null;
        }

        int placementCount = 0;
        foreach (PlayerCentricSurfaceCellSource cellSource in stagedCellSources.Values)
        {
            placementCount += cellSource.PlacementCount;
        }

        return new PlayerCentricSurfaceBuildResult(tileCache, stagedCellSources, placementCount);
    }

    private IEnumerator PreparePlacementsForRequestOverMultipleFrames(
        GeneratedTerrainBatchState batchState,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        Stopwatch frameStopwatch,
        float frameBudgetMilliseconds,
        Action<List<PreparedVegetationPlacement>> assignPlacements)
    {
        var preparedPlacements = new List<PreparedVegetationPlacement>();
        var cappedPlacements = new Dictionary<int, List<PreparedVegetationPlacement>>();
        Vector2Int tileCoordinate = geometry.GetTileCoordinateInternal(request);
        bool isCenterTile = tileCoordinate == new Vector2Int(batchState.CenterTileCoordinate.x, batchState.CenterTileCoordinate.y);
        IReadOnlyList<TileObjectPlacement> placedObjects = request.Layers.PlacedObjects ?? Array.Empty<TileObjectPlacement>();

        for (int placementIndex = 0; placementIndex < placedObjects.Count; placementIndex++)
        {
            TileObjectPlacement placement = placedObjects[placementIndex];
            if (!TryCreatePreparedPlacement(batchState, terrain, request, isCenterTile, placement, out PreparedVegetationPlacement preparedPlacement))
            {
                continue;
            }

            AddPreparedPlacement(preparedPlacements, cappedPlacements, preparedPlacement);
            if (!budget.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
            {
                continue;
            }

            budget.CommitRuntimeChunk(frameStopwatch);
            yield return null;
            budget.RestartRuntimeChunkStopwatch(frameStopwatch);
        }

        AppendCappedPlacements(preparedPlacements, cappedPlacements);
        if (budget.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
        {
            budget.CommitRuntimeChunk(frameStopwatch);
            yield return null;
            budget.RestartRuntimeChunkStopwatch(frameStopwatch);
        }

        preparedPlacements.Sort((left, right) => left.StableHash.CompareTo(right.StableHash));
        geometry.PopulatePreparedPlacementGeometryNormalsInternal(batchState, tileStats: null, request, preparedPlacements);
        assignPlacements(preparedPlacements);
        if (budget.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
        {
            budget.CommitRuntimeChunk(frameStopwatch);
            yield return null;
            budget.RestartRuntimeChunkStopwatch(frameStopwatch);
        }
    }

    private List<PreparedVegetationPlacement> PreparePlacementsForRequest(
        GeneratedTerrainBatchState batchState,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request)
    {
        var preparedPlacements = new List<PreparedVegetationPlacement>();
        var cappedPlacements = new Dictionary<int, List<PreparedVegetationPlacement>>();
        Vector2Int tileCoordinate = geometry.GetTileCoordinateInternal(request);
        bool isCenterTile = tileCoordinate == new Vector2Int(batchState.CenterTileCoordinate.x, batchState.CenterTileCoordinate.y);
        IReadOnlyList<TileObjectPlacement> placedObjects = request.Layers.PlacedObjects ?? Array.Empty<TileObjectPlacement>();

        for (int placementIndex = 0; placementIndex < placedObjects.Count; placementIndex++)
        {
            if (!TryCreatePreparedPlacement(
                    batchState,
                    terrain,
                    request,
                    isCenterTile,
                    placedObjects[placementIndex],
                    out PreparedVegetationPlacement preparedPlacement))
            {
                continue;
            }

            AddPreparedPlacement(preparedPlacements, cappedPlacements, preparedPlacement);
        }

        AppendCappedPlacements(preparedPlacements, cappedPlacements);
        preparedPlacements.Sort((left, right) => left.StableHash.CompareTo(right.StableHash));
        geometry.PopulatePreparedPlacementGeometryNormalsInternal(batchState, tileStats: null, request, preparedPlacements);
        return preparedPlacements;
    }

    private bool TryCreatePreparedPlacement(
        GeneratedTerrainBatchState batchState,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        bool isCenterTile,
        TileObjectPlacement placement,
        out PreparedVegetationPlacement preparedPlacement)
    {
        preparedPlacement = default;
        if (!ShouldRouteToPlayerCentricSurface(placement))
        {
            if (geometry.IsTreeCoupledSurfacePlacementInternal(placement))
            {
                batchState.PlayerCentricSurfaceTreeCoupledPlacementExcludedCount++;
            }

            return false;
        }

        ulong stableHash = geometry.ComputeStablePlacementHashInternal(request, placement);
        if (!geometry.TryBuildPreparedPlacementGeometryInternal(
                batchState,
                tileStats: null,
                terrain,
                request,
                placement,
                isTreePlacement: false,
                enforceCurrentStreamingDistance: false,
                out PreparedPlacementGeometry preparedGeometry))
        {
            return false;
        }

        preparedPlacement = new PreparedVegetationPlacement(
            placement,
            stableHash,
            isCenterTile,
            VegetationPriorityBucket.CenterClutterAndGround,
            forceInstancingOnly: true,
            preparedGeometry);
        return true;
    }

    private static void AddPreparedPlacement(
        List<PreparedVegetationPlacement> preparedPlacements,
        Dictionary<int, List<PreparedVegetationPlacement>> cappedPlacements,
        PreparedVegetationPlacement preparedPlacement)
    {
        int? maxPlacementsPerTile = preparedPlacement.Placement.Definition.MaxPlacementsPerTile;
        if (!maxPlacementsPerTile.HasValue)
        {
            preparedPlacements.Add(preparedPlacement);
            return;
        }

        if (!cappedPlacements.TryGetValue(preparedPlacement.Placement.Definition.NumericId, out List<PreparedVegetationPlacement>? entries))
        {
            entries = new List<PreparedVegetationPlacement>();
            cappedPlacements[preparedPlacement.Placement.Definition.NumericId] = entries;
        }

        entries.Add(preparedPlacement);
    }

    private static void AppendCappedPlacements(
        List<PreparedVegetationPlacement> preparedPlacements,
        Dictionary<int, List<PreparedVegetationPlacement>> cappedPlacements)
    {
        foreach (KeyValuePair<int, List<PreparedVegetationPlacement>> entry in cappedPlacements)
        {
            List<PreparedVegetationPlacement> definitionPlacements = entry.Value;
            definitionPlacements.Sort((left, right) => left.StableHash.CompareTo(right.StableHash));
            int keepCount = definitionPlacements.Count == 0
                ? 0
                : Math.Min(
                    definitionPlacements[0].Placement.Definition.MaxPlacementsPerTile ?? definitionPlacements.Count,
                    definitionPlacements.Count);
            for (int i = 0; i < keepCount; i++)
            {
                preparedPlacements.Add(definitionPlacements[i]);
            }
        }
    }

    private bool TryBuildInstancedPlacement(
        HybridVegetationBuildState buildState,
        PreparedVegetationPlacement preparedPlacement,
        out TileLoaderInstancedVegetationPlacement instancedPlacement)
    {
        instancedPlacement = default;
        Vector3 localPosition = preparedPlacement.Geometry.LocalPosition;
        Vector3 localNormal = preparedPlacement.Geometry.LocalNormal;
        if (preparedPlacement.Geometry.UseExactTerrainConformOnLoad &&
            geometry.TrySampleGeneratedTerrainSurfaceInternal(
                buildState.Terrain,
                preparedPlacement.Geometry.LocalPosition.x,
                preparedPlacement.Geometry.LocalPosition.z,
                geometry.SurfaceObjectVerticalOffsetInternal,
                out Vector3 exactLocalSurfacePoint,
                out Vector3 exactLocalSurfaceNormal))
        {
            localPosition = exactLocalSurfacePoint;
            localNormal = exactLocalSurfaceNormal;
        }

        Quaternion localRotation = Quaternion.FromToRotation(Vector3.up, localNormal);
        float surfaceNormalOffset = geometry.GetSurfaceObjectOffsetInternal();
        localPosition += localNormal * surfaceNormalOffset;
        instancedPlacement = new TileLoaderInstancedVegetationPlacement(
            prototypeIndex: 0,
            localPosition,
            localRotation,
            Vector3.one,
            conformToTerrainOnPromotion: false,
            preparedPlacement.Geometry.LocalPosition.x,
            preparedPlacement.Geometry.LocalPosition.z,
            geometry.SurfaceObjectVerticalOffsetInternal,
            surfaceNormalOffset);
        return true;
    }

    private bool ShouldRouteToPlayerCentricSurface(TileObjectPlacement placement)
    {
        return IsPlayerCentricSurfaceTier(placement.Definition.StreamingTier) &&
               !geometry.IsTreeCoupledSurfacePlacementInternal(placement);
    }

    private string ResolveCacheSignature(string batchCacheSignature)
    {
        return $"{batchCacheSignature}|surface-v{settings.PlayerCentricSurfaceCacheVersionInternal.ToString(CultureInfo.InvariantCulture)}";
    }

    private PlayerCentricSurfaceCellKey ResolveCellKey(Vector3 worldPosition, Vector2Int ownerTileCoordinate)
    {
        float cellSizeMeters = Mathf.Max(1f, settings.PlayerCentricSurfaceCellSizeMetersInternal);
        return new PlayerCentricSurfaceCellKey(
            Mathf.FloorToInt(worldPosition.x / cellSizeMeters),
            Mathf.FloorToInt(worldPosition.z / cellSizeMeters),
            ownerTileCoordinate);
    }

    private static bool IsPlayerCentricSurfaceTier(TileObjectStreamingTier streamingTier)
    {
        return streamingTier == TileObjectStreamingTier.Clutter ||
               streamingTier == TileObjectStreamingTier.Ground;
    }
}

}
