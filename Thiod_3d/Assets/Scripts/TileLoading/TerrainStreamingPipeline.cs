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

            owner.PromoteGeneratedTerrainBatchInternal(batchState);
            pendingBatchRoot = null;
            owner.LogGenerationBatchSummaryInternal(batchState, "blocking");
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
            owner.PromoteGeneratedTerrainBatchInternal(batchState);
            owner.LogGenerationBatchSummaryInternal(batchState, "terrain-ready");

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
        float frameBudgetMilliseconds = Math.Max(0.25f, owner.TerrainCreationBudgetMsPerFrameInternal);
        int terrainGroupId = owner.GetGeneratedTerrainGroupIdInternal();
        List<GeneratedTerrainRequest> prioritizedRequests = owner.GetTerrainCreationRequestsInPriorityOrderInternal(batchState);

        for (int i = 0; i < prioritizedRequests.Count; i++)
        {
            if (owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
            {
                yield break;
            }

            GeneratedTerrainRequest request = prioritizedRequests[i];
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

            if (frameStopwatch.Elapsed.TotalMilliseconds < frameBudgetMilliseconds)
            {
                continue;
            }

            frameStopwatch.Restart();
            yield return null;
        }

        totalStopwatch.Stop();
        owner.RecordGenerationPhaseTimingInternal(batchState, "terrain creation", totalStopwatch.Elapsed);
        owner.LogGenerationPhaseTimingInternal("terrain creation", totalStopwatch.Elapsed);
    }

    private IEnumerator RebuildTerrainSeamsOverMultipleFrames(GeneratedTerrainBatchState batchState)
    {
        var totalStopwatch = Stopwatch.StartNew();
        var frameStopwatch = Stopwatch.StartNew();
        float frameBudgetMilliseconds = Math.Max(0.25f, owner.TerrainSeamBudgetMsPerFrameInternal);
        var terrainChunk = new List<GStylizedTerrain>(1);

        for (int i = 0; i < batchState.ActiveTerrains.Count; i++)
        {
            if (owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
            {
                yield break;
            }

            GStylizedTerrain terrain = batchState.ActiveTerrains[i];
            if (terrain == null || terrain.TerrainData == null)
            {
                continue;
            }

            terrainChunk.Clear();
            terrainChunk.Add(terrain);
            owner.RebuildTerrainSeamsInternal(terrainChunk);
            if (frameStopwatch.Elapsed.TotalMilliseconds < frameBudgetMilliseconds)
            {
                continue;
            }

            frameStopwatch.Restart();
            yield return null;
        }

        totalStopwatch.Stop();
        owner.RecordGenerationPhaseTimingInternal(batchState, "terrain seams", totalStopwatch.Elapsed);
        owner.LogGenerationPhaseTimingInternal("terrain seams", totalStopwatch.Elapsed);
    }

    private IEnumerator ApplyTerrainShadingOverMultipleFrames(GeneratedTerrainBatchState batchState)
    {
        var totalStopwatch = Stopwatch.StartNew();
        var frameStopwatch = Stopwatch.StartNew();
        float frameBudgetMilliseconds = Math.Max(0.25f, owner.TerrainShadingBudgetMsPerFrameInternal);
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
            if (frameStopwatch.Elapsed.TotalMilliseconds < frameBudgetMilliseconds)
            {
                continue;
            }

            frameStopwatch.Restart();
            yield return null;
        }

        totalStopwatch.Stop();
        owner.RecordGenerationPhaseTimingInternal(batchState, "terrain shading", totalStopwatch.Elapsed);
        owner.LogGenerationPhaseTimingInternal("terrain shading", totalStopwatch.Elapsed);
    }
}
