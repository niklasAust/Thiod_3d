using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Threading.Tasks;
using Pinwheel.Griffin;
using UnityEngine;
using WorldGen;

#nullable enable

namespace Thiod.TileLoading.Runtime
{

internal sealed class TerrainStreamingPipeline
{
    private readonly ITerrainStreamingLifecyclePort lifecycle;
    private readonly ITerrainStreamingBatchPort batch;
    private readonly ITerrainStreamingCreationPort creation;
    private readonly ITerrainStreamingSeamPort seams;
    private readonly ITerrainStreamingShadingPort shading;
    private readonly IGenerationTelemetryPort telemetry;
    private readonly ITerrainStreamingBudgetPort budget;

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

    public TerrainStreamingPipeline(
        ITerrainStreamingLifecyclePort lifecycle,
        ITerrainStreamingBatchPort batch,
        ITerrainStreamingCreationPort creation,
        ITerrainStreamingSeamPort seams,
        ITerrainStreamingShadingPort shading,
        IGenerationTelemetryPort telemetry,
        ITerrainStreamingBudgetPort budget)
    {
        this.lifecycle = lifecycle;
        this.batch = batch;
        this.creation = creation;
        this.seams = seams;
        this.shading = shading;
        this.telemetry = telemetry;
        this.budget = budget;
    }

    public void Execute(TileGenerator tileGenerator, LoadedWorldData loadedWorldData, GenerationSettings settings)
    {
        int pipelineId = lifecycle.BeginTerrainGenerationPipelineInternal();
        bool doubleBufferedRuntimeSwap = lifecycle.IsPlayingInternal && lifecycle.DynamicTileLoadingEnabled;
        Transform? pendingBatchRoot = null;
        bool awaitingDeferredPhaseCompletion = false;
        lifecycle.TerrainPhaseLoadInProgressInternal = true;
        lifecycle.CancelActiveVegetationPopulationInternal();
        lifecycle.ResetGeneratedRuntimeArtifactsInternal();

        try
        {
            if (!doubleBufferedRuntimeSwap)
            {
                lifecycle.ClearGeneratedTerrainsInternal();
            }

            if (doubleBufferedRuntimeSwap)
            {
                awaitingDeferredPhaseCompletion = true;
                lifecycle.ActiveTerrainLoadCoroutineInternal = lifecycle.StartRuntimeCoroutine(
                    BuildAndStreamRuntimeTerrainBatch(
                        tileGenerator,
                        loadedWorldData,
                        settings,
                        pipelineId,
                        lifecycle.UnityTileCoordinate));
                return;
            }

            GeneratedTerrainBatchState batchState = batch.MeasureBatchWorldgenInternal(
                tileGenerator,
                loadedWorldData,
                settings,
                pipelineId);

            if (batchState.Requests.Count == 0)
            {
                return;
            }

            if (!batch.TryReuseActiveTerrainBatchRootInternal(batchState))
            {
                pendingBatchRoot = batch.CreateGeneratedTerrainBatchRootInternal(pipelineId, batchState.CenterTileCoordinate);
                batchState.BatchRoot = pendingBatchRoot;
            }

            creation.MeasureTerrainCreationPhaseInternal(batchState, () =>
            {
                int terrainGroupId = creation.GetGeneratedTerrainGroupIdInternal();
                for (int i = 0; i < batchState.Requests.Count; i++)
                {
                    GeneratedTerrainRequest request = batchState.Requests[i];
                    Vector2Int tileCoordinate = creation.GetTileCoordinateInternal(request);
                    if (batchState.TerrainByCoordinate.ContainsKey(tileCoordinate))
                    {
                        continue;
                    }

                    GStylizedTerrain terrain = creation.CreateTerrainInternal(
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
                    batchState.RegisterCreatedTerrain(tileCoordinate, request, terrain);
                }
            });

            batch.FinalizeTerrainBatchStateInternal(batchState);

            if (batchState.ActiveTerrains.Count == 0)
            {
                if (pendingBatchRoot != null)
                {
                    batch.DestroyGeneratedTerrainContainerInternal(pendingBatchRoot);
                    pendingBatchRoot = null;
                }

                return;
            }

            batch.PrepareDeferredGenerationTargetsInternal(batchState);
            seams.MeasureTerrainSeamsPhaseInternal(batchState, () => seams.RebuildTerrainSeamsInternal(batchState.ActiveTerrains));
            shading.MeasureTerrainShadingPhaseInternal(batchState, () => shading.ApplyTerrainShadingInternal(shading.GetTerrainsForStreamingShadingInternal(batchState)));

            awaitingDeferredPhaseCompletion = true;
            batch.ScheduleDeferredGenerationPhasesInternal(batchState);
        }
        finally
        {
            if (pendingBatchRoot != null)
            {
                batch.DestroyGeneratedTerrainContainerInternal(pendingBatchRoot);
            }

            if (!awaitingDeferredPhaseCompletion)
            {
                lifecycle.TerrainPhaseLoadInProgressInternal = false;
                lifecycle.TryDispatchQueuedDynamicLoadInternal();
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
            lifecycle.ActiveRuntimeRequestedTileCoordinateInternal = requestedCenterTileCoordinate;
            TileLoaderBatchPlanner planner = batch.CreateBatchPlannerInternal();
            string phaseName = batch.GetTerrainBatchWorldgenPhaseNameInternal();
            string cacheSignature = planner.BuildCacheSignature(loadedWorldData, settings);
            var stopwatch = Stopwatch.StartNew();
            Task<TileLoaderBatchPlanner.BatchBuildResult> buildTask = Task.Run(() =>
                planner.BuildBatchStateResult(
                    tileGenerator,
                    loadedWorldData,
                    settings,
                    pipelineId,
                    batch.CachedTerrainBatchInternal,
                    batch.ActiveGeneratedTerrainRootInternal != null,
                    batch.ActiveLoadedUnityTileCoordinate,
                    batch.ActiveTerrainTileCacheInternal,
                    batch.ActiveTerrainTileCacheSignatureInternal,
                    cacheSignature));

            while (!buildTask.IsCompleted)
            {
                if (pipelineId != lifecycle.ActiveGenerationPipelineIdInternal)
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
                    UnityEngine.Debug.LogException(exception);
                }

                yield break;
            }

            TileLoaderBatchPlanner.BatchBuildResult buildResult = buildTask.Result;
            batch.CachedTerrainBatchInternal = buildResult.CachedTerrainBatch;
            GeneratedTerrainBatchState batchState = buildResult.BatchState;
            stopwatch.Stop();
            telemetry.RecordGenerationPhaseTimingInternal(batchState, phaseName, stopwatch.Elapsed);
            telemetry.LogGenerationPhaseTimingInternal(phaseName, stopwatch.Elapsed);

            if (batchState.Requests.Count == 0)
            {
                yield break;
            }

            if (!batch.TryReuseActiveTerrainBatchRootInternal(batchState))
            {
                batchState.BatchRoot = batch.CreateGeneratedTerrainBatchRootInternal(pipelineId, batchState.CenterTileCoordinate);
            }

            handedOffToStreamCoroutine = true;
            yield return StreamRuntimeTerrainBatch(batchState);
        }
        finally
        {
            if (!handedOffToStreamCoroutine)
            {
                lifecycle.ActiveTerrainLoadCoroutineInternal = null;
                if (lifecycle.ActiveRuntimeRequestedTileCoordinateInternal.HasValue &&
                    lifecycle.ActiveRuntimeRequestedTileCoordinateInternal.Value == requestedCenterTileCoordinate)
                {
                    lifecycle.ActiveRuntimeRequestedTileCoordinateInternal = null;
                }

                if (lifecycle.ActiveVegetationPopulationCoroutineInternal == null)
                {
                    lifecycle.TerrainPhaseLoadInProgressInternal = false;
                    lifecycle.TryDispatchQueuedDynamicLoadInternal();
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
            if (lifecycle.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
            {
                yield break;
            }

            batch.FinalizeTerrainBatchStateInternal(batchState);
            if (batchState.ActiveTerrains.Count == 0)
            {
                if (batchState.BatchRoot != null)
                {
                    batch.DestroyGeneratedTerrainContainerInternal(batchState.BatchRoot);
                    batchState.BatchRoot = null;
                }

                yield break;
            }

            batch.PrepareDeferredGenerationTargetsInternal(batchState);
            yield return RebuildTerrainSeamsOverMultipleFrames(batchState);
            if (lifecycle.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
            {
                yield break;
            }

            yield return ApplyTerrainShadingOverMultipleFrames(batchState);
            if (lifecycle.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
            {
                yield break;
            }

            batch.ScheduleDeferredGenerationPhasesInternal(batchState);
            completed = true;
        }
        finally
        {
            if (lifecycle.ActiveTerrainLoadCoroutineInternal != null)
            {
                lifecycle.ActiveTerrainLoadCoroutineInternal = null;
            }

            if (!completed)
            {
                lifecycle.ReleaseTerrainPhaseAfterAbortedBatchInternal(batchState);
            }
        }
    }

    private IEnumerator CreateTerrainsOverMultipleFrames(GeneratedTerrainBatchState batchState)
    {
        var totalStopwatch = Stopwatch.StartNew();
        var frameStopwatch = Stopwatch.StartNew();
        budget.RestartRuntimeChunkStopwatch(frameStopwatch);
        float frameBudgetMilliseconds = budget.ResolveRuntimePhaseBudgetMsInternal(budget.TerrainCreationBudgetMsPerFrameInternal);
        int terrainGroupId = creation.GetGeneratedTerrainGroupIdInternal();
        List<GeneratedTerrainRequest> prioritizedRequests = creation.GetTerrainCreationRequestsInPriorityOrderInternal(batchState);
        PendingTerrainCreationState? pending = null;

        int requestIndex = 0;
        while (requestIndex < prioritizedRequests.Count || pending != null)
        {
            if (lifecycle.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
            {
                yield break;
            }

            if (pending == null)
            {
                GeneratedTerrainRequest request = prioritizedRequests[requestIndex];
                Vector2Int tileCoordinate = creation.GetTileCoordinateInternal(request);
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
                pending.TerrainData = creation.CreateTerrainDataForRuntimeCreationInternal(
                    pending.Request.Layers,
                    batchState.NormalizationMinHeight,
                    batchState.NormalizationMaxHeight,
                    pending.Request.LocalMaxHeight,
                    pending.Request.TileHilliness);
                if (budget.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
                {
                    budget.CommitRuntimeChunk(frameStopwatch);
                    yield return null;
                    budget.RestartRuntimeChunkStopwatch(frameStopwatch);
                }
                continue;
            }

            if (pending.HeightPixels == null)
            {
                pending.HeightPixels = creation.BuildTerrainHeightPixelsForRuntimeCreationInternal(
                    pending.Request.Layers.Heightmap,
                    batchState.NormalizationMinHeight,
                    batchState.NormalizationMaxHeight);
                if (budget.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
                {
                    budget.CommitRuntimeChunk(frameStopwatch);
                    yield return null;
                    budget.RestartRuntimeChunkStopwatch(frameStopwatch);
                }
                continue;
            }

            if (!pending.HeightmapApplied)
            {
                creation.UploadTerrainHeightPixelsForRuntimeCreationInternal(
                    pending.TerrainData,
                    pending.HeightPixels);
                pending.HeightmapApplied = true;
                if (budget.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
                {
                    budget.CommitRuntimeChunk(frameStopwatch);
                    yield return null;
                    budget.RestartRuntimeChunkStopwatch(frameStopwatch);
                }
                continue;
            }

            GStylizedTerrain terrain = creation.FinalizeRuntimeCreatedTerrainInternal(
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
            batchState.RegisterCreatedTerrain(pending.TileCoordinate, pending.Request, terrain);
            pending = null;

            if (!budget.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
            {
                continue;
            }

            budget.CommitRuntimeChunk(frameStopwatch);
            yield return null;
            budget.RestartRuntimeChunkStopwatch(frameStopwatch);
        }

        totalStopwatch.Stop();
        telemetry.RecordGenerationPhaseTimingInternal(batchState, "terrain creation", totalStopwatch.Elapsed);
        telemetry.LogGenerationPhaseTimingInternal("terrain creation", totalStopwatch.Elapsed);
    }

    private IEnumerator RebuildTerrainSeamsOverMultipleFrames(GeneratedTerrainBatchState batchState)
    {
        var totalStopwatch = Stopwatch.StartNew();
        var frameStopwatch = Stopwatch.StartNew();
        budget.RestartRuntimeChunkStopwatch(frameStopwatch);
        float frameBudgetMilliseconds = budget.ResolveRuntimePhaseBudgetMsInternal(budget.TerrainSeamBudgetMsPerFrameInternal);
        List<PendingTerrainSeamWorkItem> seamWorkItems = BuildTerrainSeamWorkItems(batchState);
        if (seamWorkItems.Count == 0)
        {
            totalStopwatch.Stop();
            telemetry.RecordGenerationPhaseTimingInternal(batchState, "terrain seams", totalStopwatch.Elapsed);
            telemetry.LogGenerationPhaseTimingInternal("terrain seams", totalStopwatch.Elapsed);
            yield break;
        }

        seams.ConnectAdjacentTerrainsInternal();

        for (int i = 0; i < seamWorkItems.Count; i++)
        {
            if (lifecycle.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
            {
                yield break;
            }

            PendingTerrainSeamWorkItem seamWorkItem = seamWorkItems[i];
            if (seamWorkItem.Terrain == null || seamWorkItem.Terrain.TerrainData == null)
            {
                continue;
            }

            seams.RebuildTerrainSeamsInternal(seamWorkItem.Terrain, seamWorkItem.SeamMask);
            if (!budget.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
            {
                continue;
            }

            budget.CommitRuntimeChunk(frameStopwatch);
            yield return null;
            budget.RestartRuntimeChunkStopwatch(frameStopwatch);
        }

        totalStopwatch.Stop();
        telemetry.RecordGenerationPhaseTimingInternal(batchState, "terrain seams", totalStopwatch.Elapsed);
        telemetry.LogGenerationPhaseTimingInternal("terrain seams", totalStopwatch.Elapsed);
    }

    private List<PendingTerrainSeamWorkItem> BuildTerrainSeamWorkItems(GeneratedTerrainBatchState batchState)
    {
        var seamMasksByCoordinate = new Dictionary<Vector2Int, TileLoaderTerrainSeamMask>();
        for (int i = 0; i < batchState.CreatedRequests.Count; i++)
        {
            Vector2Int tileCoordinate = creation.GetTileCoordinateInternal(batchState.CreatedRequests[i]);
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
        budget.RestartRuntimeChunkStopwatch(frameStopwatch);
        float frameBudgetMilliseconds = budget.ResolveRuntimePhaseBudgetMsInternal(budget.TerrainShadingBudgetMsPerFrameInternal);
        var terrainChunk = new List<GStylizedTerrain>(1);
        IReadOnlyList<GStylizedTerrain> shadingTerrains = shading.GetTerrainsForStreamingShadingInternal(batchState);

        for (int i = 0; i < shadingTerrains.Count; i++)
        {
            if (lifecycle.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
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
            shading.ApplyTerrainShadingInternal(terrainChunk);
            if (!budget.ShouldYieldAfterRuntimeChunk(frameStopwatch, frameBudgetMilliseconds))
            {
                continue;
            }

            budget.CommitRuntimeChunk(frameStopwatch);
            yield return null;
            budget.RestartRuntimeChunkStopwatch(frameStopwatch);
        }

        totalStopwatch.Stop();
        telemetry.RecordGenerationPhaseTimingInternal(batchState, "terrain shading", totalStopwatch.Elapsed);
        telemetry.LogGenerationPhaseTimingInternal("terrain shading", totalStopwatch.Elapsed);
    }
}

}
