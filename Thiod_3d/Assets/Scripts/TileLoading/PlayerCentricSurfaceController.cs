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

internal sealed class PlayerCentricSurfaceController
{
    private readonly TileLoader owner;
    private readonly Dictionary<Vector2Int, PlayerCentricSurfaceTileCache> tileCaches = new();
    private readonly Dictionary<PlayerCentricSurfaceCellKey, PlayerCentricSurfaceCellSource> cellSources = new();
    private readonly Dictionary<int, Vector2Int> tileByTerrainInstanceId = new();
    private readonly HashSet<PlayerCentricSurfaceCellKey> activeCellKeys = new();
    private float nextUpdateTime;

    public PlayerCentricSurfaceController(TileLoader owner)
    {
        this.owner = owner;
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

        nextUpdateTime = Time.unscaledTime + Mathf.Max(0.01f, owner.PlayerCentricSurfaceUpdateIntervalSecondsInternal);
        Vector3? targetWorldPosition = owner.ResolveVegetationStreamingTargetWorldPositionInternal();
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

        float activationRadius = Mathf.Max(0f, owner.PlayerCentricSurfaceRadiusMetersInternal);
        float retentionRadius = activationRadius + Mathf.Max(0f, owner.PlayerCentricSurfaceHysteresisMetersInternal);
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
            Vector2Int tileCoordinate = owner.GetTileCoordinateInternal(request);
            if (!batchState.TerrainByCoordinate.TryGetValue(tileCoordinate, out GStylizedTerrain terrain) || terrain == null)
            {
                continue;
            }

            IReadOnlyList<TileObjectPlacement> placedObjects = request.Layers.PlacedObjects ?? Array.Empty<TileObjectPlacement>();
            bool hasSurfacePlacements = false;
            for (int placementIndex = 0; placementIndex < placedObjects.Count; placementIndex++)
            {
                if (ShouldRouteToPlayerCentricSurface(placedObjects[placementIndex]))
                {
                    hasSurfacePlacements = true;
                    break;
                }
            }

            if (!hasSurfacePlacements)
            {
                RemoveTileCache(tileCoordinate);
                continue;
            }

            int terrainInstanceId = terrain.GetInstanceID();
            if (tileCaches.TryGetValue(tileCoordinate, out PlayerCentricSurfaceTileCache? existingCache) &&
                existingCache.CacheSignature == ResolveCacheSignature(batchState.CacheSignature) &&
                existingCache.TerrainInstanceId == terrainInstanceId &&
                existingCache.Terrain == terrain)
            {
                tileByTerrainInstanceId[terrainInstanceId] = tileCoordinate;
                continue;
            }

            RemoveTileCache(tileCoordinate);
            PlayerCentricSurfaceTileCache? rebuiltCache = BuildTileCache(batchState, terrain, request);
            if (rebuiltCache == null)
            {
                continue;
            }

            tileCaches[tileCoordinate] = rebuiltCache;
            tileByTerrainInstanceId[rebuiltCache.TerrainInstanceId] = tileCoordinate;
            builtTileCacheCount++;
            builtCellCount += rebuiltCache.CellKeys.Count;
            foreach (PlayerCentricSurfaceCellKey cellKey in rebuiltCache.CellKeys)
            {
                if (cellSources.TryGetValue(cellKey, out PlayerCentricSurfaceCellSource? cellSource))
                {
                    builtPlacementCount += cellSource.PlacementCount;
                }
            }
        }

        sourceBuildStopwatch.Stop();
        batchState.PlayerCentricSurfaceTileCacheBuildCount += builtTileCacheCount;
        batchState.PlayerCentricSurfaceCellBuildCount += builtCellCount;
        batchState.PlayerCentricSurfacePlacementCount += builtPlacementCount;
        batchState.PlayerCentricSurfaceSourceBuildCpuMilliseconds += sourceBuildStopwatch.Elapsed.TotalMilliseconds;
        owner.RecordGenerationPhaseTimingInternal(batchState, "player-centric surface source build", sourceBuildStopwatch.Elapsed);
        if (sourceBuildStopwatch.Elapsed.TotalMilliseconds > 0d)
        {
            owner.LogGenerationPhaseTimingInternal("player-centric surface source build", sourceBuildStopwatch.Elapsed);
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
        owner.RestartRuntimeChunkStopwatch(frameStopwatch);
        float frameBudgetMilliseconds = owner.ResolveRuntimePhaseBudgetMsInternal(owner.PlayerCentricSurfaceBuildBudgetMsPerFrameInternal);
        int builtTileCacheCount = 0;
        int builtCellCount = 0;
        int builtPlacementCount = 0;

        for (int i = 0; i < batchState.Requests.Count; i++)
        {
            if (batchState.PipelineId != owner.ActiveGenerationPipelineIdInternal)
            {
                yield break;
            }

            GeneratedTerrainRequest request = batchState.Requests[i];
            Vector2Int tileCoordinate = owner.GetTileCoordinateInternal(request);
            if (!batchState.TerrainByCoordinate.TryGetValue(tileCoordinate, out GStylizedTerrain terrain) || terrain == null)
            {
                continue;
            }

            IReadOnlyList<TileObjectPlacement> placedObjects = request.Layers.PlacedObjects ?? Array.Empty<TileObjectPlacement>();
            bool hasSurfacePlacements = false;
            for (int placementIndex = 0; placementIndex < placedObjects.Count; placementIndex++)
            {
                if (ShouldRouteToPlayerCentricSurface(placedObjects[placementIndex]))
                {
                    hasSurfacePlacements = true;
                    break;
                }
            }

            if (!hasSurfacePlacements)
            {
                RemoveTileCache(tileCoordinate);
                continue;
            }

            int terrainInstanceId = terrain.GetInstanceID();
            if (tileCaches.TryGetValue(tileCoordinate, out PlayerCentricSurfaceTileCache? existingCache) &&
                existingCache.CacheSignature == ResolveCacheSignature(batchState.CacheSignature) &&
                existingCache.TerrainInstanceId == terrainInstanceId &&
                existingCache.Terrain == terrain)
            {
                tileByTerrainInstanceId[terrainInstanceId] = tileCoordinate;
                continue;
            }

            RemoveTileCache(tileCoordinate);
            PlayerCentricSurfaceTileCache? rebuiltCache = null;
            int rebuiltCellCount = 0;
            int rebuiltPlacementCount = 0;
            yield return BuildTileCacheOverMultipleFrames(
                batchState,
                terrain,
                request,
                frameStopwatch,
                frameBudgetMilliseconds,
                cache => rebuiltCache = cache,
                (cellCount, placementCount) =>
                {
                    rebuiltCellCount = cellCount;
                    rebuiltPlacementCount = placementCount;
                });

            if (rebuiltCache == null)
            {
                continue;
            }

            tileCaches[tileCoordinate] = rebuiltCache;
            tileByTerrainInstanceId[rebuiltCache.TerrainInstanceId] = tileCoordinate;
            builtTileCacheCount++;
            builtCellCount += rebuiltCellCount;
            builtPlacementCount += rebuiltPlacementCount;

            if (owner.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
            {
                owner.CommitRuntimeChunk(frameStopwatch);
                yield return null;
                owner.RestartRuntimeChunkStopwatch(frameStopwatch);
            }
        }

        sourceBuildStopwatch.Stop();
        batchState.PlayerCentricSurfaceTileCacheBuildCount += builtTileCacheCount;
        batchState.PlayerCentricSurfaceCellBuildCount += builtCellCount;
        batchState.PlayerCentricSurfacePlacementCount += builtPlacementCount;
        batchState.PlayerCentricSurfaceSourceBuildCpuMilliseconds += sourceBuildStopwatch.Elapsed.TotalMilliseconds;
        owner.RecordGenerationPhaseTimingInternal(batchState, "player-centric surface source build", sourceBuildStopwatch.Elapsed);
        if (sourceBuildStopwatch.Elapsed.TotalMilliseconds > 0d)
        {
            owner.LogGenerationPhaseTimingInternal("player-centric surface source build", sourceBuildStopwatch.Elapsed);
        }

        UpdateVegetation(forceImmediate: true, batchState, totalStopwatch);
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
                owner.RetireGeneratedContainerInternal(surfaceRoot);
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
            interactive: owner.VegetationLoadModeInternal == VegetationLoadMode.HybridInteractive,
            interactionRadiusMeters: owner.VegetationInteractionRadiusMetersInternal,
            interactionHysteresisMeters: owner.VegetationInteractionHysteresisMetersInternal,
            owner,
            owner.PrototypeInitBudgetMsPerFrameInternal);
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

        float cellSizeMeters = Mathf.Max(1f, owner.PlayerCentricSurfaceCellSizeMetersInternal);
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

    private IEnumerator BuildTileCacheOverMultipleFrames(
        GeneratedTerrainBatchState batchState,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        Stopwatch frameStopwatch,
        float frameBudgetMilliseconds,
        Action<PlayerCentricSurfaceTileCache?> assignCache,
        Action<int, int> assignCounts)
    {
        List<PreparedVegetationPlacement> preparedPlacements = new();
        yield return PreparePlacementsForRequestOverMultipleFrames(
            batchState,
            terrain,
            request,
            frameStopwatch,
            frameBudgetMilliseconds,
            placements => preparedPlacements = placements);

        PlayerCentricSurfaceTileCache? builtCache = null;
        int cellCount = 0;
        int placementCount = 0;
        if (preparedPlacements.Count > 0)
        {
            Vector2Int tileCoordinate = owner.GetTileCoordinateInternal(request);
            var stagedCellSources = new Dictionary<PlayerCentricSurfaceCellKey, PlayerCentricSurfaceCellSource>();
            builtCache = new PlayerCentricSurfaceTileCache(
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
                PreparedVegetationPlacement preparedPlacement = preparedPlacements[placementIndex];
                TileObjectPlacement placement = preparedPlacement.Placement;
                GameObject? prefab = owner.LoadPrefabForPlacementInternal(placement, batchState);
                if (prefab == null)
                {
                    batchState.PlayerCentricSurfaceMissingPrefabCount++;
                    continue;
                }

                bool isTreeObject = owner.IsTreePlacementInternal(placement, prefab);
                if (isTreeObject)
                {
                    continue;
                }

                TileLoaderInstancedVegetationPrototype? prototype = owner.GetOrCreateVegetationPrototypeInternal(
                    null,
                    placement,
                    prefab,
                    isTreeObject: false,
                    supportsPromotion: owner.SupportsHybridPromotionInternal(placement));
                if (prototype == null ||
                    !TryBuildInstancedPlacement(
                        buildState,
                        preparedPlacement,
                        out TileLoaderInstancedVegetationPlacement instancedPlacement))
                {
                    continue;
                }

                PlayerCentricSurfaceCellKey cellKey = ResolveCellKey(preparedPlacement.Geometry.WorldPosition, tileCoordinate);
                if (!stagedCellSources.TryGetValue(cellKey, out PlayerCentricSurfaceCellSource? cellSource))
                {
                    cellSource = new PlayerCentricSurfaceCellSource(cellKey, tileCoordinate, terrain);
                    stagedCellSources[cellKey] = cellSource;
                }

                cellSource.Terrain = terrain;
                builtCache.CellKeys.Add(cellKey);
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

                if (!owner.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
                {
                    continue;
                }

                owner.CommitRuntimeChunk(frameStopwatch);
                yield return null;
                owner.RestartRuntimeChunkStopwatch(frameStopwatch);
            }

            if (builtCache.CellKeys.Count == 0)
            {
                builtCache = null;
            }
            else
            {
                CommitStagedCellSources(stagedCellSources);
            }
        }

        if (builtCache != null)
        {
            cellCount = builtCache.CellKeys.Count;
            foreach (PlayerCentricSurfaceCellKey cellKey in builtCache.CellKeys)
            {
                if (cellSources.TryGetValue(cellKey, out PlayerCentricSurfaceCellSource? cellSource))
                {
                    placementCount += cellSource.PlacementCount;
                }
            }
        }

        assignCache(builtCache);
        assignCounts(cellCount, placementCount);
        if (owner.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
        {
            owner.CommitRuntimeChunk(frameStopwatch);
            yield return null;
            owner.RestartRuntimeChunkStopwatch(frameStopwatch);
        }
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
        Vector2Int tileCoordinate = owner.GetTileCoordinateInternal(request);
        bool isCenterTile = tileCoordinate == new Vector2Int(batchState.CenterTileCoordinate.x, batchState.CenterTileCoordinate.y);
        IReadOnlyList<TileObjectPlacement> placedObjects = request.Layers.PlacedObjects ?? Array.Empty<TileObjectPlacement>();

        for (int placementIndex = 0; placementIndex < placedObjects.Count; placementIndex++)
        {
            TileObjectPlacement placement = placedObjects[placementIndex];
            if (!ShouldRouteToPlayerCentricSurface(placement))
            {
                if (owner.IsTreeCoupledSurfacePlacementInternal(placement))
                {
                    batchState.PlayerCentricSurfaceTreeCoupledPlacementExcludedCount++;
                }

                continue;
            }

            ulong stableHash = owner.ComputeStablePlacementHashInternal(request, placement);
            if (!owner.TryBuildPreparedPlacementGeometryInternal(
                    batchState,
                    tileStats: null,
                    terrain,
                    request,
                    placement,
                    isTreePlacement: false,
                    enforceCurrentStreamingDistance: false,
                    out PreparedPlacementGeometry geometry))
            {
                continue;
            }

            var preparedPlacement = new PreparedVegetationPlacement(
                placement,
                stableHash,
                isCenterTile,
                VegetationPriorityBucket.CenterClutterAndGround,
                forceInstancingOnly: true,
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
            }
            else
            {
                preparedPlacements.Add(preparedPlacement);
            }

            if (!owner.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
            {
                continue;
            }

            owner.CommitRuntimeChunk(frameStopwatch);
            yield return null;
            owner.RestartRuntimeChunkStopwatch(frameStopwatch);
        }

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

            if (!owner.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
            {
                continue;
            }

            owner.CommitRuntimeChunk(frameStopwatch);
            yield return null;
            owner.RestartRuntimeChunkStopwatch(frameStopwatch);
        }

        preparedPlacements.Sort((left, right) => left.StableHash.CompareTo(right.StableHash));
        if (owner.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
        {
            owner.CommitRuntimeChunk(frameStopwatch);
            yield return null;
            owner.RestartRuntimeChunkStopwatch(frameStopwatch);
        }

        owner.PopulatePreparedPlacementGeometryNormalsInternal(batchState, tileStats: null, request, preparedPlacements);
        assignPlacements(preparedPlacements);
        if (owner.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
        {
            owner.CommitRuntimeChunk(frameStopwatch);
            yield return null;
            owner.RestartRuntimeChunkStopwatch(frameStopwatch);
        }
    }

    private PlayerCentricSurfaceTileCache? BuildTileCache(
        GeneratedTerrainBatchState batchState,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request)
    {
        List<PreparedVegetationPlacement> preparedPlacements = PreparePlacementsForRequest(batchState, terrain, request);
        if (preparedPlacements.Count == 0)
        {
            return null;
        }

        Vector2Int tileCoordinate = owner.GetTileCoordinateInternal(request);
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
            PreparedVegetationPlacement preparedPlacement = preparedPlacements[placementIndex];
            TileObjectPlacement placement = preparedPlacement.Placement;
            GameObject? prefab = owner.LoadPrefabForPlacementInternal(placement, batchState);
            if (prefab == null)
            {
                batchState.PlayerCentricSurfaceMissingPrefabCount++;
                continue;
            }

            bool isTreeObject = owner.IsTreePlacementInternal(placement, prefab);
            if (isTreeObject)
            {
                continue;
            }

            TileLoaderInstancedVegetationPrototype? prototype = owner.GetOrCreateVegetationPrototypeInternal(
                null,
                placement,
                prefab,
                isTreeObject: false,
                supportsPromotion: owner.SupportsHybridPromotionInternal(placement));
            if (prototype == null ||
                !TryBuildInstancedPlacement(
                    buildState,
                    preparedPlacement,
                    out TileLoaderInstancedVegetationPlacement instancedPlacement))
            {
                continue;
            }

            PlayerCentricSurfaceCellKey cellKey = ResolveCellKey(preparedPlacement.Geometry.WorldPosition, tileCoordinate);
            if (!cellSources.TryGetValue(cellKey, out PlayerCentricSurfaceCellSource? cellSource))
            {
                cellSource = new PlayerCentricSurfaceCellSource(cellKey, tileCoordinate, terrain);
                cellSources[cellKey] = cellSource;
            }

            cellSource.Terrain = terrain;
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
        }

        if (tileCache.CellKeys.Count == 0)
        {
            return null;
        }

        return tileCache;
    }

    private List<PreparedVegetationPlacement> PreparePlacementsForRequest(
        GeneratedTerrainBatchState batchState,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request)
    {
        var preparedPlacements = new List<PreparedVegetationPlacement>();
        var cappedPlacements = new Dictionary<int, List<PreparedVegetationPlacement>>();
        Vector2Int tileCoordinate = owner.GetTileCoordinateInternal(request);
        bool isCenterTile = tileCoordinate == new Vector2Int(batchState.CenterTileCoordinate.x, batchState.CenterTileCoordinate.y);
        IReadOnlyList<TileObjectPlacement> placedObjects = request.Layers.PlacedObjects ?? Array.Empty<TileObjectPlacement>();

        for (int placementIndex = 0; placementIndex < placedObjects.Count; placementIndex++)
        {
            TileObjectPlacement placement = placedObjects[placementIndex];
            if (!ShouldRouteToPlayerCentricSurface(placement))
            {
                if (owner.IsTreeCoupledSurfacePlacementInternal(placement))
                {
                    batchState.PlayerCentricSurfaceTreeCoupledPlacementExcludedCount++;
                }

                continue;
            }

            ulong stableHash = owner.ComputeStablePlacementHashInternal(request, placement);
            if (!owner.TryBuildPreparedPlacementGeometryInternal(
                    batchState,
                    tileStats: null,
                    terrain,
                    request,
                    placement,
                    isTreePlacement: false,
                    enforceCurrentStreamingDistance: false,
                    out PreparedPlacementGeometry geometry))
            {
                continue;
            }

            var preparedPlacement = new PreparedVegetationPlacement(
                placement,
                stableHash,
                isCenterTile,
                VegetationPriorityBucket.CenterClutterAndGround,
                forceInstancingOnly: true,
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

            preparedPlacements.Add(preparedPlacement);
        }

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

        preparedPlacements.Sort((left, right) => left.StableHash.CompareTo(right.StableHash));
        owner.PopulatePreparedPlacementGeometryNormalsInternal(batchState, tileStats: null, request, preparedPlacements);
        return preparedPlacements;
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
            owner.TrySampleGeneratedTerrainSurfaceInternal(
                buildState.Terrain,
                preparedPlacement.Geometry.LocalPosition.x,
                preparedPlacement.Geometry.LocalPosition.z,
                owner.SurfaceObjectVerticalOffsetInternal,
                out Vector3 exactLocalSurfacePoint,
                out Vector3 exactLocalSurfaceNormal))
        {
            localPosition = exactLocalSurfacePoint;
            localNormal = exactLocalSurfaceNormal;
        }

        Quaternion localRotation = Quaternion.FromToRotation(Vector3.up, localNormal);
        localPosition += localNormal * owner.GetSurfaceObjectOffsetInternal();
        instancedPlacement = new TileLoaderInstancedVegetationPlacement(
            prototypeIndex: 0,
            localPosition,
            localRotation,
            Vector3.one,
            conformToTerrainOnPromotion: false,
            preparedPlacement.Geometry.LocalPosition.x,
            preparedPlacement.Geometry.LocalPosition.z,
            owner.SurfaceObjectVerticalOffsetInternal,
            owner.GetSurfaceObjectOffsetInternal());
        return true;
    }

    private bool ShouldUsePlayerCentricSurfaceVegetation()
    {
        return owner.IsPlayingInternal &&
               owner.PlayerCentricSurfaceVegetationEnabledInternal &&
               owner.PlaceSurfaceObjectsInternal;
    }

    private static bool IsPlayerCentricSurfaceTier(TileObjectStreamingTier streamingTier)
    {
        return streamingTier == TileObjectStreamingTier.Clutter ||
               streamingTier == TileObjectStreamingTier.Ground;
    }

    private bool ShouldRouteToPlayerCentricSurface(TileObjectPlacement placement)
    {
        return IsPlayerCentricSurfaceTier(placement.Definition.StreamingTier) &&
               !owner.IsTreeCoupledSurfacePlacementInternal(placement);
    }

    private string ResolveCacheSignature(string batchCacheSignature)
    {
        return $"{batchCacheSignature}|surface-v{owner.PlayerCentricSurfaceCacheVersionInternal.ToString(CultureInfo.InvariantCulture)}";
    }

    private PlayerCentricSurfaceCellKey ResolveCellKey(Vector3 worldPosition, Vector2Int ownerTileCoordinate)
    {
        float cellSizeMeters = Mathf.Max(1f, owner.PlayerCentricSurfaceCellSizeMetersInternal);
        return new PlayerCentricSurfaceCellKey(
            Mathf.FloorToInt(worldPosition.x / cellSizeMeters),
            Mathf.FloorToInt(worldPosition.z / cellSizeMeters),
            ownerTileCoordinate);
    }

    private string GetSurfaceRootName()
    {
        return owner.GetVegetationContainerNameInternal() + "_Surface";
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
