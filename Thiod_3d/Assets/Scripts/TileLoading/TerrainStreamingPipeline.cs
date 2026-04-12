using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Threading.Tasks;
using Pinwheel.Griffin;
using UnityEngine;
using WorldGen;

#nullable enable

internal sealed class TerrainStreamingPipeline
{
    private readonly TileLoader owner;

    private sealed class PendingTerrainCreationState
    {
        public GeneratedTerrainRequest Request { get; set; }
        public Vector2Int TileCoordinate { get; set; }
        public GTerrainData? TerrainData { get; set; }
        public Color[]? HeightPixels { get; set; }
        public bool HeightmapApplied { get; set; }
    }

    private readonly struct PendingTerrainSeamWorkItem
    {
        public PendingTerrainSeamWorkItem(GStylizedTerrain terrain, TileLoaderTerrainSeamMask seamMask)
        {
            Terrain = terrain;
            SeamMask = seamMask;
        }

        public GStylizedTerrain Terrain { get; }
        public TileLoaderTerrainSeamMask SeamMask { get; }
    }

    public TerrainStreamingPipeline(TileLoader owner)
    {
        this.owner = owner;
    }

    public void Execute(TileGenerator tileGenerator, LoadedWorldData loadedWorldData, GenerationSettings settings)
    {
        int pipelineId = owner.BeginTerrainGenerationPipelineInternal();
        bool doubleBufferedRuntimeSwap = owner.IsPlayingInternal && owner.DynamicTileLoadingEnabled;
        Transform? pendingBatchRoot = null;
        bool awaitingDeferredPhaseCompletion = false;
        owner.TerrainPhaseLoadInProgressInternal = true;
        owner.CancelActiveVegetationPopulationInternal();
        owner.ResetGeneratedRuntimeArtifactsInternal();

        try
        {
            if (!doubleBufferedRuntimeSwap)
            {
                owner.ClearGeneratedTerrainsInternal();
            }

            if (doubleBufferedRuntimeSwap)
            {
                awaitingDeferredPhaseCompletion = true;
                owner.ActiveTerrainLoadCoroutineInternal = owner.StartRuntimeCoroutine(
                    BuildAndStreamRuntimeTerrainBatch(
                        tileGenerator,
                        loadedWorldData,
                        settings,
                        pipelineId,
                        owner.UnityTileCoordinate));
                return;
            }

            GeneratedTerrainBatchState batchState = owner.MeasureBatchWorldgenInternal(
                tileGenerator,
                loadedWorldData,
                settings,
                pipelineId);

            if (batchState.Requests.Count == 0)
            {
                return;
            }

            if (!owner.TryReuseActiveTerrainBatchRootInternal(batchState))
            {
                pendingBatchRoot = owner.CreateGeneratedTerrainBatchRootInternal(pipelineId, batchState.CenterTileCoordinate);
                batchState.BatchRoot = pendingBatchRoot;
            }

            owner.MeasureTerrainCreationPhaseInternal(batchState, () =>
            {
                int terrainGroupId = owner.GetGeneratedTerrainGroupIdInternal();
                for (int i = 0; i < batchState.Requests.Count; i++)
                {
                    GeneratedTerrainRequest request = batchState.Requests[i];
                    Vector2Int tileCoordinate = owner.GetTileCoordinateInternal(request);
                    if (batchState.TerrainByCoordinate.ContainsKey(tileCoordinate))
                    {
                        continue;
                    }

                    GStylizedTerrain terrain = owner.CreateTerrainInternal(
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

            owner.FinalizeTerrainBatchStateInternal(batchState);

            if (batchState.ActiveTerrains.Count == 0)
            {
                if (pendingBatchRoot != null)
                {
                    owner.DestroyGeneratedTerrainContainerInternal(pendingBatchRoot);
                    pendingBatchRoot = null;
                }

                return;
            }

            owner.PrepareDeferredGenerationTargetsInternal(batchState);
            owner.MeasureTerrainSeamsPhaseInternal(batchState, () => owner.RebuildTerrainSeamsInternal(batchState.ActiveTerrains));
            owner.MeasureTerrainShadingPhaseInternal(batchState, () => owner.ApplyTerrainShadingInternal(owner.GetTerrainsForStreamingShadingInternal(batchState)));

            awaitingDeferredPhaseCompletion = true;
            owner.ScheduleDeferredGenerationPhasesInternal(batchState);
        }
        finally
        {
            if (pendingBatchRoot != null)
            {
                owner.DestroyGeneratedTerrainContainerInternal(pendingBatchRoot);
            }

            if (!awaitingDeferredPhaseCompletion)
            {
                owner.TerrainPhaseLoadInProgressInternal = false;
                owner.TryDispatchQueuedDynamicLoadInternal();
            }
        }
    }

    private IEnumerator BuildAndStreamRuntimeTerrainBatch(
        TileGenerator tileGenerator,
        LoadedWorldData loadedWorldData,
        GenerationSettings settings,
        int pipelineId,
        Vector3Int requestedCenterTileCoordinate)
    {
        bool handedOffToStreamCoroutine = false;
        try
        {
            owner.ActiveRuntimeRequestedTileCoordinateInternal = requestedCenterTileCoordinate;
            TileLoaderBatchPlanner planner = owner.CreateBatchPlannerInternal();
            string phaseName = owner.GetTerrainBatchWorldgenPhaseNameInternal();
            string cacheSignature = planner.BuildCacheSignature(loadedWorldData, settings);
            var stopwatch = Stopwatch.StartNew();
            Task<TileLoaderBatchPlanner.BatchBuildResult> buildTask = Task.Run(() =>
                planner.BuildBatchStateResult(
                    tileGenerator,
                    loadedWorldData,
                    settings,
                    pipelineId,
                    owner.CachedTerrainBatchInternal,
                    owner.ActiveGeneratedTerrainRootInternal != null,
                    owner.ActiveLoadedUnityTileCoordinate,
                    owner.ActiveTerrainTileCacheInternal,
                    owner.ActiveTerrainTileCacheSignatureInternal,
                    cacheSignature));

            while (!buildTask.IsCompleted)
            {
                if (owner == null || pipelineId != owner.ActiveGenerationPipelineIdInternal)
                {
                    yield break;
                }

                yield return null;
            }

            if (buildTask.IsFaulted)
            {
                Exception? exception = buildTask.Exception?.GetBaseException() ?? buildTask.Exception;
                if (exception != null)
                {
                    UnityEngine.Debug.LogException(exception, owner);
                }

                yield break;
            }

            TileLoaderBatchPlanner.BatchBuildResult buildResult = buildTask.Result;
            owner.CachedTerrainBatchInternal = buildResult.CachedTerrainBatch;
            GeneratedTerrainBatchState batchState = buildResult.BatchState;
            stopwatch.Stop();
            owner.RecordGenerationPhaseTimingInternal(batchState, phaseName, stopwatch.Elapsed);
            owner.LogGenerationPhaseTimingInternal(phaseName, stopwatch.Elapsed);

            if (batchState.Requests.Count == 0)
            {
                yield break;
            }

            if (!owner.TryReuseActiveTerrainBatchRootInternal(batchState))
            {
                batchState.BatchRoot = owner.CreateGeneratedTerrainBatchRootInternal(pipelineId, batchState.CenterTileCoordinate);
            }

            handedOffToStreamCoroutine = true;
            yield return StreamRuntimeTerrainBatch(batchState);
        }
        finally
        {
            if (!handedOffToStreamCoroutine)
            {
                owner.ActiveTerrainLoadCoroutineInternal = null;
                if (owner.ActiveRuntimeRequestedTileCoordinateInternal.HasValue &&
                    owner.ActiveRuntimeRequestedTileCoordinateInternal.Value == requestedCenterTileCoordinate)
                {
                    owner.ActiveRuntimeRequestedTileCoordinateInternal = null;
                }

                if (owner.ActiveVegetationPopulationCoroutineInternal == null)
                {
                    owner.TerrainPhaseLoadInProgressInternal = false;
                    owner.TryDispatchQueuedDynamicLoadInternal();
                }
            }
        }
    }

    private IEnumerator StreamRuntimeTerrainBatch(GeneratedTerrainBatchState batchState)
    {
        bool completed = false;
        try
        {
            yield return CreateTerrainsOverMultipleFrames(batchState);
            if (owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
            {
                yield break;
            }

            owner.FinalizeTerrainBatchStateInternal(batchState);
            if (batchState.ActiveTerrains.Count == 0)
            {
                if (batchState.BatchRoot != null)
                {
                    owner.DestroyGeneratedTerrainContainerInternal(batchState.BatchRoot);
                    batchState.BatchRoot = null;
                }

                yield break;
            }

            owner.PrepareDeferredGenerationTargetsInternal(batchState);
            yield return RebuildTerrainSeamsOverMultipleFrames(batchState);
            if (owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
            {
                yield break;
            }

            yield return ApplyTerrainShadingOverMultipleFrames(batchState);
            if (owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
            {
                yield break;
            }

            owner.ScheduleDeferredGenerationPhasesInternal(batchState);
            completed = true;
        }
        finally
        {
            if (owner.ActiveTerrainLoadCoroutineInternal != null)
            {
                owner.ActiveTerrainLoadCoroutineInternal = null;
            }

            if (!completed)
            {
                owner.ReleaseTerrainPhaseAfterAbortedBatchInternal(batchState);
            }
        }
    }

    private IEnumerator CreateTerrainsOverMultipleFrames(GeneratedTerrainBatchState batchState)
    {
        var totalStopwatch = Stopwatch.StartNew();
        var frameStopwatch = Stopwatch.StartNew();
        owner.RestartRuntimeChunkStopwatch(frameStopwatch);
        float frameBudgetMilliseconds = owner.ResolveRuntimePhaseBudgetMsInternal(owner.TerrainCreationBudgetMsPerFrameInternal);
        int terrainGroupId = owner.GetGeneratedTerrainGroupIdInternal();
        List<GeneratedTerrainRequest> prioritizedRequests = owner.GetTerrainCreationRequestsInPriorityOrderInternal(batchState);
        PendingTerrainCreationState? pending = null;

        int requestIndex = 0;
        while (requestIndex < prioritizedRequests.Count || pending != null)
        {
            if (owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
            {
                yield break;
            }

            if (pending == null)
            {
                GeneratedTerrainRequest request = prioritizedRequests[requestIndex];
                Vector2Int tileCoordinate = owner.GetTileCoordinateInternal(request);
                requestIndex++;
                if (batchState.TerrainByCoordinate.ContainsKey(tileCoordinate))
                {
                    continue;
                }

                pending = new PendingTerrainCreationState
                {
                    Request = request,
                    TileCoordinate = tileCoordinate,
                };
            }

            if (pending.TerrainData == null)
            {
                pending.TerrainData = owner.CreateTerrainDataForRuntimeCreationInternal(
                    pending.Request.Layers,
                    batchState.NormalizationMinHeight,
                    batchState.NormalizationMaxHeight,
                    pending.Request.LocalMaxHeight,
                    pending.Request.TileHilliness);
                if (owner.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
                {
                    owner.CommitRuntimeChunk(frameStopwatch);
                    yield return null;
                    owner.RestartRuntimeChunkStopwatch(frameStopwatch);
                }
                continue;
            }

            if (pending.HeightPixels == null)
            {
                pending.HeightPixels = owner.BuildTerrainHeightPixelsForRuntimeCreationInternal(
                    pending.Request.Layers.Heightmap,
                    batchState.NormalizationMinHeight,
                    batchState.NormalizationMaxHeight);
                if (owner.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
                {
                    owner.CommitRuntimeChunk(frameStopwatch);
                    yield return null;
                    owner.RestartRuntimeChunkStopwatch(frameStopwatch);
                }
                continue;
            }

            if (!pending.HeightmapApplied)
            {
                owner.UploadTerrainHeightPixelsForRuntimeCreationInternal(
                    pending.TerrainData,
                    pending.HeightPixels);
                pending.HeightmapApplied = true;
                if (owner.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
                {
                    owner.CommitRuntimeChunk(frameStopwatch);
                    yield return null;
                    owner.RestartRuntimeChunkStopwatch(frameStopwatch);
                }
                continue;
            }

            GStylizedTerrain terrain = owner.FinalizeRuntimeCreatedTerrainInternal(
                pending.Request.Layers,
                pending.TerrainData,
                pending.Request.TerrainObjectName,
                pending.Request.LocalPosition,
                pending.Request.UnityTileX,
                pending.Request.UnityTileY,
                batchState.NormalizationMinHeight,
                batchState.NormalizationMaxHeight,
                pending.Request.LocalMinHeight,
                pending.Request.LocalMaxHeight,
                pending.Request.TileHilliness,
                terrainGroupId,
                batchState.BatchRoot!);
            batchState.CreatedTerrains.Add(terrain);
            batchState.CreatedRequests.Add(pending.Request);
            batchState.TerrainByCoordinate[pending.TileCoordinate] = terrain;
            pending = null;

            if (!owner.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
            {
                continue;
            }

            owner.CommitRuntimeChunk(frameStopwatch);
            yield return null;
            owner.RestartRuntimeChunkStopwatch(frameStopwatch);
        }

        totalStopwatch.Stop();
        owner.RecordGenerationPhaseTimingInternal(batchState, "terrain creation", totalStopwatch.Elapsed);
        owner.LogGenerationPhaseTimingInternal("terrain creation", totalStopwatch.Elapsed);
    }

    private IEnumerator RebuildTerrainSeamsOverMultipleFrames(GeneratedTerrainBatchState batchState)
    {
        var totalStopwatch = Stopwatch.StartNew();
        var frameStopwatch = Stopwatch.StartNew();
        owner.RestartRuntimeChunkStopwatch(frameStopwatch);
        float frameBudgetMilliseconds = owner.ResolveRuntimePhaseBudgetMsInternal(owner.TerrainSeamBudgetMsPerFrameInternal);
        List<PendingTerrainSeamWorkItem> seamWorkItems = BuildTerrainSeamWorkItems(batchState);
        if (seamWorkItems.Count == 0)
        {
            totalStopwatch.Stop();
            owner.RecordGenerationPhaseTimingInternal(batchState, "terrain seams", totalStopwatch.Elapsed);
            owner.LogGenerationPhaseTimingInternal("terrain seams", totalStopwatch.Elapsed);
            yield break;
        }

        owner.ConnectAdjacentTerrainsInternal();

        for (int i = 0; i < seamWorkItems.Count; i++)
        {
            if (owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
            {
                yield break;
            }

            PendingTerrainSeamWorkItem seamWorkItem = seamWorkItems[i];
            if (seamWorkItem.Terrain == null || seamWorkItem.Terrain.TerrainData == null)
            {
                continue;
            }

            owner.RebuildTerrainSeamsInternal(seamWorkItem.Terrain, seamWorkItem.SeamMask);
            if (!owner.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
            {
                continue;
            }

            owner.CommitRuntimeChunk(frameStopwatch);
            yield return null;
            owner.RestartRuntimeChunkStopwatch(frameStopwatch);
        }

        totalStopwatch.Stop();
        owner.RecordGenerationPhaseTimingInternal(batchState, "terrain seams", totalStopwatch.Elapsed);
        owner.LogGenerationPhaseTimingInternal("terrain seams", totalStopwatch.Elapsed);
    }

    private List<PendingTerrainSeamWorkItem> BuildTerrainSeamWorkItems(GeneratedTerrainBatchState batchState)
    {
        var seamMasksByCoordinate = new Dictionary<Vector2Int, TileLoaderTerrainSeamMask>();
        for (int i = 0; i < batchState.CreatedRequests.Count; i++)
        {
            Vector2Int tileCoordinate = owner.GetTileCoordinateInternal(batchState.CreatedRequests[i]);
            AddSeamMask(seamMasksByCoordinate, tileCoordinate, TileLoaderTerrainSeamMask.All);
            AddSeamMask(seamMasksByCoordinate, tileCoordinate + Vector2Int.left, TileLoaderTerrainSeamMask.Right);
            AddSeamMask(seamMasksByCoordinate, tileCoordinate + Vector2Int.right, TileLoaderTerrainSeamMask.Left);
            AddSeamMask(seamMasksByCoordinate, tileCoordinate + Vector2Int.up, TileLoaderTerrainSeamMask.Bottom);
            AddSeamMask(seamMasksByCoordinate, tileCoordinate + Vector2Int.down, TileLoaderTerrainSeamMask.Top);
        }

        var seamWorkItems = new List<PendingTerrainSeamWorkItem>(seamMasksByCoordinate.Count);
        foreach (KeyValuePair<Vector2Int, TileLoaderTerrainSeamMask> entry in seamMasksByCoordinate)
        {
            if (!batchState.TerrainByCoordinate.TryGetValue(entry.Key, out GStylizedTerrain terrain) || terrain == null)
            {
                continue;
            }

            seamWorkItems.Add(new PendingTerrainSeamWorkItem(terrain, entry.Value));
        }

        return seamWorkItems;
    }

    private static void AddSeamMask(
        IDictionary<Vector2Int, TileLoaderTerrainSeamMask> seamMasksByCoordinate,
        Vector2Int tileCoordinate,
        TileLoaderTerrainSeamMask seamMask)
    {
        if (!seamMasksByCoordinate.TryGetValue(tileCoordinate, out TileLoaderTerrainSeamMask existingMask))
        {
            seamMasksByCoordinate[tileCoordinate] = seamMask;
            return;
        }

        seamMasksByCoordinate[tileCoordinate] = existingMask | seamMask;
    }

    private IEnumerator ApplyTerrainShadingOverMultipleFrames(GeneratedTerrainBatchState batchState)
    {
        var totalStopwatch = Stopwatch.StartNew();
        var frameStopwatch = Stopwatch.StartNew();
        owner.RestartRuntimeChunkStopwatch(frameStopwatch);
        float frameBudgetMilliseconds = owner.ResolveRuntimePhaseBudgetMsInternal(owner.TerrainShadingBudgetMsPerFrameInternal);
        var terrainChunk = new List<GStylizedTerrain>(1);
        IReadOnlyList<GStylizedTerrain> shadingTerrains = owner.GetTerrainsForStreamingShadingInternal(batchState);

        for (int i = 0; i < shadingTerrains.Count; i++)
        {
            if (owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
            {
                yield break;
            }

            GStylizedTerrain terrain = shadingTerrains[i];
            if (terrain == null || terrain.TerrainData == null)
            {
                continue;
            }

            terrainChunk.Clear();
            terrainChunk.Add(terrain);
            owner.ApplyTerrainShadingInternal(terrainChunk);
            if (!owner.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
            {
                continue;
            }

            owner.CommitRuntimeChunk(frameStopwatch);
            yield return null;
            owner.RestartRuntimeChunkStopwatch(frameStopwatch);
        }

        totalStopwatch.Stop();
        owner.RecordGenerationPhaseTimingInternal(batchState, "terrain shading", totalStopwatch.Elapsed);
        owner.LogGenerationPhaseTimingInternal("terrain shading", totalStopwatch.Elapsed);
    }
}
