using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using Pinwheel.Griffin;
using UnityEngine;

#nullable enable

internal sealed class VegetationStreamingController
{
    private readonly TileLoader owner;
    private GeneratedTerrainBatchState? activeVegetationPopulationBatchState;
    private Stopwatch? activeVegetationPopulationStopwatch;

    public VegetationStreamingController(TileLoader owner)
    {
        this.owner = owner;
    }

    public Coroutine? ActiveVegetationPopulationCoroutine { get; private set; }

    public void ScheduleDeferredGenerationPhases(GeneratedTerrainBatchState batchState)
    {
        if (batchState.PipelineId != owner.ActiveGenerationPipelineIdInternal)
        {
            return;
        }

#if UNITY_EDITOR
        if (!owner.IsPlayingInternal)
        {
            UnityEditor.EditorApplication.delayCall += () => ContinueDeferredGenerationPhases(batchState);
            return;
        }
#endif

        owner.StartRuntimeCoroutine(ContinueDeferredGenerationPhasesNextFrame(batchState));
    }

    public void FinishDeferredGenerationPhases(GeneratedTerrainBatchState batchState)
    {
        if (owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
        {
            owner.ReleaseTerrainPhaseAfterAbortedBatchInternal(batchState);
            return;
        }

        if (owner.IsPlayingInternal)
        {
            owner.UpdateConiferOptimizationInternal(forceFullIfNoTarget: true);
        }

        owner.LastVegetationStreamingTargetWorldPositionInternal =
            batchState.VegetationStreamingTargetWorldPosition ??
            owner.ResolveVegetationStreamingTargetWorldPositionInternal();
        owner.LastCompletedGenerationPipelineIdInternal = batchState.PipelineId;
        owner.LastCompletedRuntimeNeighborhoodCenterTileCoordinateInternal = batchState.CenterTileCoordinate;
        if (owner.ActiveRuntimeRequestedTileCoordinateInternal.HasValue &&
            owner.ActiveRuntimeRequestedTileCoordinateInternal.Value == batchState.CenterTileCoordinate)
        {
            owner.ActiveRuntimeRequestedTileCoordinateInternal = null;
        }

        owner.LogGenerationBatchSummaryInternal(batchState, "complete");
        owner.TerrainPhaseLoadInProgressInternal = false;
        owner.TryDispatchQueuedDynamicLoadInternal();
    }

    private void EnsureTerrainStageVisible(GeneratedTerrainBatchState batchState, string stageLabel)
    {
        if (batchState.TerrainStageVisible)
        {
            return;
        }

        owner.PromoteGeneratedTerrainBatchInternal(batchState);
        batchState.TerrainStageVisible = true;
        owner.LogGenerationBatchSummaryInternal(batchState, stageLabel);
    }

    public void CancelActiveVegetationPopulation()
    {
        if (ActiveVegetationPopulationCoroutine == null)
        {
            return;
        }

        if (activeVegetationPopulationBatchState != null)
        {
            double elapsedMilliseconds = activeVegetationPopulationStopwatch?.Elapsed.TotalMilliseconds ?? 0d;
            owner.Reporter.InterruptAndLogPendingVegetationTileStats(activeVegetationPopulationBatchState, elapsedMilliseconds);
            owner.DiscardPendingVegetationBuildOutputsInternal(activeVegetationPopulationBatchState);
        }

        owner.StopRuntimeCoroutineInternal(ActiveVegetationPopulationCoroutine);
        ActiveVegetationPopulationCoroutine = null;
        activeVegetationPopulationBatchState = null;
        activeVegetationPopulationStopwatch = null;
    }

    public void PopulateVegetationImmediately(GeneratedTerrainBatchState batchState)
    {
        if (!owner.PlaceTreeObjectsInternal && !owner.PlaceSurfaceObjectsInternal)
        {
            return;
        }

        var totalStopwatch = Stopwatch.StartNew();
        owner.EnsurePlayerCentricSurfaceCachesInternal(batchState, totalStopwatch);

        int terrainCount = Math.Min(batchState.VegetationRefreshRequests.Count, batchState.VegetationRefreshTerrains.Count);
        if (owner.UsesLegacyVegetationObjectsInternal())
        {
            owner.MeasureVegetationRenderPhaseInternal(() =>
            {
                for (int i = 0; i < terrainCount; i++)
                {
                    owner.PopulatePlacedObjectsLegacyInternal(
                        batchState.VegetationRefreshTerrains[i],
                        batchState.VegetationRefreshRequests[i],
                        batchState.NormalizationMinHeight,
                        batchState.NormalizationMaxHeight);
                }
            });
            return;
        }

        var queuePrepStopwatch = Stopwatch.StartNew();
        var workItems = owner.PrepareVegetationWorkItemsInternal(batchState, totalStopwatch);
        queuePrepStopwatch.Stop();
        owner.RecordGenerationPhaseTimingInternal(batchState, "vegetation queue prep", queuePrepStopwatch.Elapsed);
        owner.LogGenerationPhaseTimingInternal("vegetation queue prep", queuePrepStopwatch.Elapsed);

        for (int i = 0; i < workItems.Count; i++)
        {
            VegetationWorkItem workItem = workItems[i];
            while (owner.ProcessNextVegetationWorkItemPlacementInternal(workItem, totalStopwatch))
            {
            }

            owner.FinalizeVegetationWorkItemInternal(workItem, totalStopwatch);
        }

        totalStopwatch.Stop();
        batchState.VegetationFullSettledMilliseconds = totalStopwatch.Elapsed.TotalMilliseconds;
            owner.Reporter.FinalizeAndLogPendingVegetationTileStats(batchState, batchState.VegetationFullSettledMilliseconds);
    }

    public List<VegetationWorkItem> PrepareVegetationWorkItems(GeneratedTerrainBatchState batchState, Stopwatch totalStopwatch)
    {
        var orderedWorkItems = new List<VegetationWorkItem>();
        var workItemsByBucket = new Dictionary<VegetationPriorityBucket, List<VegetationWorkItem>>();
        batchState.VegetationStreamingTargetWorldPosition = owner.ResolveVegetationStreamingTargetWorldPositionInternal();
        batchState.VegetationClearOnlyTerrains.Clear();
        int terrainCount = Math.Min(batchState.VegetationRefreshRequests.Count, batchState.VegetationRefreshTerrains.Count);
        for (int i = 0; i < terrainCount; i++)
        {
            GeneratedTerrainRequest request = batchState.VegetationRefreshRequests[i];
            GStylizedTerrain terrain = batchState.VegetationRefreshTerrains[i];
            Vector2Int tileCoordinate = owner.GetTileCoordinateInternal(request);
            Transform? existingVegetationContainer = owner.FindVegetationContainerInternal(terrain.transform);
            if (request.Layers.PlacedObjects == null || request.Layers.PlacedObjects.Count == 0)
            {
                if (existingVegetationContainer != null)
                {
                    batchState.VegetationClearOnlyTerrains.Add(terrain);
                }

                continue;
            }

            HybridVegetationBuildState? buildState = owner.BeginHybridVegetationBuildInternal(
                batchState,
                terrain,
                request,
                batchState.NormalizationMinHeight,
                batchState.NormalizationMaxHeight);
            if (buildState == null)
            {
                continue;
            }

            List<PreparedVegetationPlacement> preparedPlacements =
                owner.PrepareVegetationPlacementsForRequestInternal(batchState, totalStopwatch, terrain, request);
            if (preparedPlacements.Count == 0)
            {
                if (existingVegetationContainer != null)
                {
                    batchState.VegetationClearOnlyTerrains.Add(terrain);
                }
                else
                {
                    owner.MarkRuntimeVegetationTileSettledInternal(tileCoordinate);
                }

                continue;
            }

            foreach (VegetationPriorityBucket bucket in Enum.GetValues(typeof(VegetationPriorityBucket)))
            {
                List<PreparedVegetationPlacement>? bucketPlacements = null;
                for (int placementIndex = 0; placementIndex < preparedPlacements.Count; placementIndex++)
                {
                    PreparedVegetationPlacement preparedPlacement = preparedPlacements[placementIndex];
                    if (preparedPlacement.PriorityBucket != bucket)
                    {
                        continue;
                    }

                    bucketPlacements ??= new List<PreparedVegetationPlacement>();
                    bucketPlacements.Add(preparedPlacement);
                }

                if (bucketPlacements == null || bucketPlacements.Count == 0)
                {
                    continue;
                }

                if (!workItemsByBucket.TryGetValue(bucket, out List<VegetationWorkItem>? bucketWorkItems))
                {
                    bucketWorkItems = new List<VegetationWorkItem>();
                    workItemsByBucket[bucket] = bucketWorkItems;
                }

                int chunkSize = ResolveVegetationWorkItemChunkSize(bucket);
                int chunkCountForBucket = (bucketPlacements.Count + chunkSize - 1) / chunkSize;
                string bucketKey = bucket.ToString();
                int chunkOrdinalWithinBucket = 0;
                for (int chunkStart = 0; chunkStart < bucketPlacements.Count; chunkStart += chunkSize)
                {
                    int chunkCount = Math.Min(chunkSize, bucketPlacements.Count - chunkStart);
                    var chunkPlacements = new List<PreparedVegetationPlacement>(chunkCount);
                    for (int chunkIndex = 0; chunkIndex < chunkCount; chunkIndex++)
                    {
                        chunkPlacements.Add(bucketPlacements[chunkStart + chunkIndex]);
                    }

                    batchState.VegetationTileStats[tileCoordinate].RecordQueuedWorkItem(chunkPlacements.Count, bucket);
                    batchState.VegetationQueuedWorkItemCount++;
                    batchState.VegetationQueuedPlacementCount += chunkPlacements.Count;
                    IncrementCount(batchState.VegetationQueuedWorkItemsByBucket, bucketKey);
                    AddCount(batchState.VegetationQueuedPlacementsByBucket, bucketKey, chunkPlacements.Count);
                    bucketWorkItems.Add(new VegetationWorkItem(
                        buildState,
                        bucket,
                        chunkPlacements,
                        preparedPlacements[0].IsCenterTile,
                        chunkOrdinalWithinBucket,
                        chunkCountForBucket));
                    chunkOrdinalWithinBucket++;
                }
            }
        }

        foreach (VegetationPriorityBucket bucket in Enum.GetValues(typeof(VegetationPriorityBucket)))
        {
            if (!workItemsByBucket.TryGetValue(bucket, out List<VegetationWorkItem>? bucketWorkItems) ||
                bucketWorkItems.Count == 0)
            {
                continue;
            }

            orderedWorkItems.AddRange(bucketWorkItems);
        }

        for (int i = orderedWorkItems.Count - 1; i >= 0; i--)
        {
            if (!orderedWorkItems[i].IsCenterTile)
            {
                continue;
            }

            if (orderedWorkItems[i].PriorityBucket == VegetationPriorityBucket.OuterGroundAndDebris)
            {
                continue;
            }

            orderedWorkItems[i].MarksCenterTileReady = true;
            break;
        }

        if (!orderedWorkItems.Exists(item => item.MarksCenterTileReady))
        {
            for (int i = orderedWorkItems.Count - 1; i >= 0; i--)
            {
                if (!orderedWorkItems[i].IsCenterTile)
                {
                    continue;
                }

                orderedWorkItems[i].MarksCenterTileReady = true;
                break;
            }
        }

        var finalizedBuildStates = new HashSet<HybridVegetationBuildState>();
        for (int i = orderedWorkItems.Count - 1; i >= 0; i--)
        {
            VegetationWorkItem workItem = orderedWorkItems[i];
            if (finalizedBuildStates.Add(workItem.BuildState))
            {
                workItem.IsFinalChunkForTile = true;
            }
        }

        owner.TryLogVegetationWorkQueueSummaryInternal(batchState, orderedWorkItems);
        return orderedWorkItems;
    }

    public void FinalizeVegetationClearOnlyTerrains(GeneratedTerrainBatchState batchState)
    {
        for (int i = 0; i < batchState.VegetationClearOnlyTerrains.Count; i++)
        {
            GStylizedTerrain terrain = batchState.VegetationClearOnlyTerrains[i];
            if (terrain == null)
            {
                continue;
            }

            Transform? vegetationContainer = owner.FindVegetationContainerInternal(terrain.transform);
            if (vegetationContainer != null)
            {
                owner.RetireGeneratedContainerInternal(vegetationContainer);
            }

            if (owner.TryGetUnityTileCoordinateForWorldPositionInternal(terrain.transform.position, out Vector3Int tileCoordinate))
            {
                owner.MarkRuntimeVegetationTileSettledInternal(new Vector2Int(tileCoordinate.x, tileCoordinate.y));
            }
        }
    }

    public void DiscardPendingVegetationBuildOutputs(GeneratedTerrainBatchState batchState)
    {
        string buildContainerName = owner.GetVegetationBuildContainerNameInternal(batchState.PipelineId);
        for (int i = 0; i < batchState.VegetationRefreshTerrains.Count; i++)
        {
            GStylizedTerrain terrain = batchState.VegetationRefreshTerrains[i];
            if (terrain == null)
            {
                continue;
            }

            Transform? buildContainer = terrain.transform.Find(buildContainerName);
            if (buildContainer != null)
            {
                owner.RetireGeneratedContainerInternal(buildContainer);
            }
        }
    }

    public bool ProcessNextVegetationWorkItemPlacement(VegetationWorkItem workItem, Stopwatch totalStopwatch)
    {
        if (workItem.NextPlacementIndex >= workItem.Placements.Count)
        {
            return false;
        }

        PreparedVegetationPlacement preparedPlacement = workItem.Placements[workItem.NextPlacementIndex];
        workItem.NextPlacementIndex++;
        bool placementBecameVisible = owner.ProcessPreparedHybridVegetationPlacementInternal(workItem, preparedPlacement);
        if (placementBecameVisible && workItem.BuildState.BatchState != null)
        {
            Vector2Int tileCoordinate = owner.GetTileCoordinateFromBuildRequestInternal(workItem.BuildState.Request);
            VegetationTileStreamingStats tileStats = owner.GetOrCreateVegetationTileStatsInternal(
                workItem.BuildState.BatchState,
                tileCoordinate,
                workItem.IsCenterTile);
            tileStats.RecordVisible(totalStopwatch.Elapsed.TotalMilliseconds);
        }

        return workItem.NextPlacementIndex < workItem.Placements.Count;
    }

    public void FinalizeVegetationWorkItem(VegetationWorkItem workItem, Stopwatch totalStopwatch)
    {
        VegetationTileStreamingStats? tileStats = null;
        if (workItem.BuildState.BatchState != null)
        {
            tileStats = owner.GetOrCreateVegetationTileStatsInternal(
                workItem.BuildState.BatchState,
                owner.GetTileCoordinateFromBuildRequestInternal(workItem.BuildState.Request),
                workItem.IsCenterTile);
        }

        int previousFinalizedPlacementCount = workItem.BuildState.LastFinalizedPlacementCount;
        bool shouldFinalizeRenderer =
            workItem.IsFinalChunkForTile ||
            workItem.BuildState.Placements.Count <= 512;
        double rendererFinalizeMilliseconds = shouldFinalizeRenderer
            ? owner.FinalizeHybridVegetationBuildInternal(workItem.BuildState)
            : 0d;
        bool vegetationBecameVisible = false;
        if (workItem.IsFinalChunkForTile)
        {
            vegetationBecameVisible = owner.FinalizeVegetationBuildOutputInternal(workItem.BuildState);
        }

        if (!vegetationBecameVisible &&
            rendererFinalizeMilliseconds > 0d &&
            workItem.BuildState.VegetationContainer != null &&
            workItem.BuildState.VegetationContainer.gameObject.activeInHierarchy)
        {
            vegetationBecameVisible = true;
        }

        owner.RecordPlacementPhaseTimingInternal(
            workItem.BuildState.BatchState,
            tileStats,
            rendererFinalizeMilliseconds,
            VegetationPlacementPhase.RendererFinalize,
            workItem);
        if (vegetationBecameVisible)
        {
            tileStats?.RecordVisible(totalStopwatch.Elapsed.TotalMilliseconds);
        }
        else if (workItem.InstancedPlacementCount > 0)
        {
            tileStats?.RecordDeferredRendererFinalize();
            if (workItem.BuildState.BatchState != null)
            {
                workItem.BuildState.BatchState.VegetationDeferredRendererFinalizeCount++;
            }
        }

        if (rendererFinalizeMilliseconds > 0d)
        {
            tileStats?.RecordRendererFinalize();
            if (workItem.BuildState.BatchState != null)
            {
                workItem.BuildState.BatchState.VegetationRendererFinalizeCount++;
            }
        }

        if (workItem.BuildState.BatchState != null)
        {
            Vector2Int tileCoordinate = owner.GetTileCoordinateFromBuildRequestInternal(workItem.BuildState.Request);
            VegetationTileStreamingStats completedTileStats = tileStats ?? owner.GetOrCreateVegetationTileStatsInternal(
                workItem.BuildState.BatchState,
                tileCoordinate,
                workItem.IsCenterTile);
            int completedWorkItemCount = completedTileStats.RecordCompletedWorkItem(totalStopwatch.Elapsed.TotalMilliseconds);
            int visibleInstancedPlacementCount = vegetationBecameVisible
                ? Math.Max(0, workItem.BuildState.LastFinalizedPlacementCount - previousFinalizedPlacementCount)
                : 0;
            TileLoaderInstancedVegetationRenderer? renderer = workItem.BuildState.VegetationContainer != null
                ? workItem.BuildState.VegetationContainer.GetComponent<TileLoaderInstancedVegetationRenderer>()
                : null;
            owner.TryLogVegetationWorkItemCompletionInternal(
                workItem,
                completedTileStats,
                completedWorkItemCount,
                visibleInstancedPlacementCount,
                !shouldFinalizeRenderer && workItem.InstancedPlacementCount > 0,
                renderer == null || renderer.IsPrototypeRuntimeReady,
                renderer?.LastPrototypeInitializationMilliseconds ?? 0d);
            if (completedWorkItemCount >= completedTileStats.QueuedWorkItemCount)
            {
                owner.MarkRuntimeVegetationTileSettledInternal(tileCoordinate);
                owner.TryLogSettledVegetationTileInternal(tileCoordinate, completedTileStats);
            }
        }

        if (!workItem.MarksCenterTileReady ||
            workItem.BuildState.BatchState == null ||
            workItem.BuildState.BatchState.VegetationCenterReadyMilliseconds > 0d)
        {
            return;
        }

        workItem.BuildState.BatchState.VegetationCenterReadyMilliseconds = totalStopwatch.Elapsed.TotalMilliseconds;
        owner.LogCenterTileVegetationReadyInternal(workItem.BuildState.BatchState.VegetationCenterReadyMilliseconds);
    }

    private IEnumerator ContinueDeferredGenerationPhasesNextFrame(GeneratedTerrainBatchState batchState)
    {
        yield return null;
        if (!owner.IsPlayingInternal)
        {
            ContinueDeferredGenerationPhases(batchState);
            yield break;
        }

        yield return ContinueDeferredGenerationPhasesOverMultipleFrames(batchState);
    }

    private void ContinueDeferredGenerationPhases(GeneratedTerrainBatchState batchState)
    {
        if (owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
        {
            owner.ReleaseTerrainPhaseAfterAbortedBatchInternal(batchState);
            return;
        }

        switch (batchState.NextDeferredPhase)
        {
            case DeferredGenerationPhase.RiverWater:
                batchState.NextDeferredPhase = DeferredGenerationPhase.DebugSplines;
                owner.MeasureRiverWaterPhaseInternal(
                    batchState,
                    () =>
                    {
                        owner.ClearGeneratedRiverOutputsInternal(batchState.RiverRefreshTerrains);
                        owner.PopulateRiverWaterForBatchInternal(batchState);
                    });
                break;
            case DeferredGenerationPhase.DebugSplines:
                batchState.NextDeferredPhase = DeferredGenerationPhase.Vegetation;
                owner.MeasureRiverSplinePhaseInternal(
                    batchState,
                    () => owner.PopulateRiverDebugSplinesForBatchInternal(batchState));
                break;
            case DeferredGenerationPhase.Vegetation:
                EnsureTerrainStageVisible(batchState, "terrain-complete");
                batchState.NextDeferredPhase = DeferredGenerationPhase.Completed;
                if (owner.ShouldSpreadVegetationInstancingAcrossFramesInternal(batchState))
                {
                    activeVegetationPopulationBatchState = batchState;
                    activeVegetationPopulationStopwatch = Stopwatch.StartNew();
                    ActiveVegetationPopulationCoroutine = owner.StartRuntimeCoroutine(PopulateVegetationOverMultipleFrames(batchState));
                    return;
                }

                owner.MeasureVegetationPlacementPhaseInternal(
                    batchState,
                    () =>
                    {
                        PopulateVegetationImmediately(batchState);
                        FinalizeVegetationClearOnlyTerrains(batchState);
                    });
                FinishDeferredGenerationPhases(batchState);
                return;
            default:
                return;
        }

        if (batchState.NextDeferredPhase != DeferredGenerationPhase.Completed)
        {
            ScheduleDeferredGenerationPhases(batchState);
            return;
        }

        FinishDeferredGenerationPhases(batchState);
    }

    private IEnumerator ContinueDeferredGenerationPhasesOverMultipleFrames(GeneratedTerrainBatchState batchState)
    {
        if (owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
        {
            owner.ReleaseTerrainPhaseAfterAbortedBatchInternal(batchState);
            yield break;
        }

        if (batchState.NextDeferredPhase == DeferredGenerationPhase.RiverWater)
        {
            batchState.NextDeferredPhase = DeferredGenerationPhase.DebugSplines;
            yield return PopulateRiverWaterOverMultipleFrames(batchState);
            if (owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
            {
                owner.ReleaseTerrainPhaseAfterAbortedBatchInternal(batchState);
                yield break;
            }
        }

        if (batchState.NextDeferredPhase == DeferredGenerationPhase.DebugSplines)
        {
            batchState.NextDeferredPhase = DeferredGenerationPhase.Vegetation;
            if (!owner.IsPlayingInternal)
            {
                yield return PopulateRiverDebugSplinesOverMultipleFrames(batchState);
            }
            if (owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
            {
                owner.ReleaseTerrainPhaseAfterAbortedBatchInternal(batchState);
                yield break;
            }
        }

        if (batchState.NextDeferredPhase != DeferredGenerationPhase.Vegetation)
        {
            FinishDeferredGenerationPhases(batchState);
            yield break;
        }

        EnsureTerrainStageVisible(batchState, "terrain-complete");
        batchState.NextDeferredPhase = DeferredGenerationPhase.Completed;
        if (owner.ShouldSpreadVegetationInstancingAcrossFramesInternal(batchState))
        {
            activeVegetationPopulationBatchState = batchState;
            activeVegetationPopulationStopwatch = Stopwatch.StartNew();
            ActiveVegetationPopulationCoroutine = owner.StartRuntimeCoroutine(PopulateVegetationOverMultipleFrames(batchState));
            yield break;
        }

        owner.MeasureVegetationPlacementPhaseInternal(
            batchState,
            () =>
            {
                PopulateVegetationImmediately(batchState);
                FinalizeVegetationClearOnlyTerrains(batchState);
            });
        FinishDeferredGenerationPhases(batchState);
    }

    private IEnumerator PopulateRiverWaterOverMultipleFrames(GeneratedTerrainBatchState batchState)
    {
        var totalStopwatch = Stopwatch.StartNew();
        var frameStopwatch = Stopwatch.StartNew();
        owner.RestartRuntimeChunkStopwatch(frameStopwatch);
        owner.ClearGeneratedRiverOutputsInternal(batchState.RiverRefreshTerrains);
        var riverWaterSeams = new Dictionary<string, RiverWaterSeamCrossSection>(StringComparer.Ordinal);
        int terrainCount = Math.Min(batchState.RiverRefreshRequests.Count, batchState.RiverRefreshTerrains.Count);
        for (int i = 0; i < terrainCount; i++)
        {
            if (owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
            {
                yield break;
            }

            GeneratedTerrainRequest request = batchState.RiverRefreshRequests[i];
            GStylizedTerrain terrain = batchState.RiverRefreshTerrains[i];
            int riverPathCount = owner.GetRiverWaterPathCountInternal(request, terrain);
            if (riverPathCount == 0)
            {
                continue;
            }

            for (int riverPathIndex = 0; riverPathIndex < riverPathCount; riverPathIndex++)
            {
                if (owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
                {
                    yield break;
                }

                owner.PopulateRiverWaterForPathInternal(
                    request,
                    terrain,
                    riverPathIndex,
                    batchState.NormalizationMinHeight,
                    batchState.NormalizationMaxHeight,
                    batchState.RiverSplineCache,
                    riverWaterSeams);

                if (!owner.ShouldYieldAfterRuntimeChunk(frameStopwatch, owner.RuntimeGlobalBudgetMsPerFrameInternal))
                {
                    continue;
                }

                owner.CommitRuntimeChunk(frameStopwatch);
                yield return null;
                owner.RestartRuntimeChunkStopwatch(frameStopwatch);
            }
        }

        totalStopwatch.Stop();
        owner.RecordGenerationPhaseTimingInternal(batchState, "river water", totalStopwatch.Elapsed);
        owner.LogGenerationPhaseTimingInternal("river water", totalStopwatch.Elapsed);
    }

    private IEnumerator PopulateRiverDebugSplinesOverMultipleFrames(GeneratedTerrainBatchState batchState)
    {
        var totalStopwatch = Stopwatch.StartNew();
        var frameStopwatch = Stopwatch.StartNew();
        owner.RestartRuntimeChunkStopwatch(frameStopwatch);
        int terrainCount = Math.Min(batchState.RiverRefreshRequests.Count, batchState.RiverRefreshTerrains.Count);
        for (int i = 0; i < terrainCount; i++)
        {
            if (owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState))
            {
                yield break;
            }

            owner.PopulateRiverDebugSplinesForTerrainInternal(
                batchState.RiverRefreshRequests[i],
                batchState.RiverRefreshTerrains[i],
                batchState.NormalizationMinHeight,
                batchState.NormalizationMaxHeight,
                batchState.RiverSplineCache);

            if (!owner.ShouldYieldAfterRuntimeChunk(frameStopwatch, owner.RuntimeGlobalBudgetMsPerFrameInternal))
            {
                continue;
            }

            owner.CommitRuntimeChunk(frameStopwatch);
            yield return null;
            owner.RestartRuntimeChunkStopwatch(frameStopwatch);
        }

        totalStopwatch.Stop();
        owner.RecordGenerationPhaseTimingInternal(batchState, "river debug splines", totalStopwatch.Elapsed);
        owner.LogGenerationPhaseTimingInternal("river debug splines", totalStopwatch.Elapsed);
    }

    private IEnumerator PopulateVegetationOverMultipleFrames(GeneratedTerrainBatchState batchState)
    {
        bool completed = false;
        var totalStopwatch = Stopwatch.StartNew();
        try
        {
            yield return owner.EnsurePlayerCentricSurfaceCachesOverMultipleFramesInternal(batchState, totalStopwatch);
            var queuePrepStopwatch = Stopwatch.StartNew();
            var workItems = owner.PrepareVegetationWorkItemsInternal(batchState, totalStopwatch);
            queuePrepStopwatch.Stop();
            owner.RecordGenerationPhaseTimingInternal(batchState, "vegetation queue prep", queuePrepStopwatch.Elapsed);
            owner.LogGenerationPhaseTimingInternal("vegetation queue prep", queuePrepStopwatch.Elapsed);

            double frameBudgetMilliseconds = owner.ResolveRuntimePhaseBudgetMsInternal(owner.VegetationPlacementBudgetMsPerFrameInternal);
            var frameStopwatch = Stopwatch.StartNew();
            owner.RestartRuntimeChunkStopwatch(frameStopwatch);

            for (int workItemIndex = 0; workItemIndex < workItems.Count; workItemIndex++)
            {
                if (batchState.PipelineId != owner.ActiveGenerationPipelineIdInternal)
                {
                    yield break;
                }

                VegetationWorkItem workItem = workItems[workItemIndex];
                while (owner.ProcessNextVegetationWorkItemPlacementInternal(workItem, totalStopwatch))
                {
                    if (!owner.ShouldYieldAfterRuntimeChunk(frameStopwatch, (float)frameBudgetMilliseconds))
                    {
                        continue;
                    }

                    owner.CommitRuntimeChunk(frameStopwatch);
                    yield return null;
                    owner.RestartRuntimeChunkStopwatch(frameStopwatch);
                    if (batchState.PipelineId != owner.ActiveGenerationPipelineIdInternal)
                    {
                        yield break;
                    }
                }

                owner.FinalizeVegetationWorkItemInternal(workItem, totalStopwatch);
                if (!owner.ShouldYieldAfterRuntimeChunk(frameStopwatch, (float)frameBudgetMilliseconds))
                {
                    continue;
                }

                owner.CommitRuntimeChunk(frameStopwatch);
                yield return null;
                owner.RestartRuntimeChunkStopwatch(frameStopwatch);
            }

            totalStopwatch.Stop();
            batchState.VegetationFullSettledMilliseconds = totalStopwatch.Elapsed.TotalMilliseconds;
            FinalizeVegetationClearOnlyTerrains(batchState);
            owner.Reporter.FinalizeAndLogPendingVegetationTileStats(batchState, batchState.VegetationFullSettledMilliseconds);
            completed = true;
        }
        finally
        {
            if (activeVegetationPopulationBatchState == batchState)
            {
                activeVegetationPopulationBatchState = null;
                activeVegetationPopulationStopwatch = null;
            }

            ActiveVegetationPopulationCoroutine = null;
            if (completed && batchState.PipelineId == owner.ActiveGenerationPipelineIdInternal)
            {
                owner.RecordGenerationPhaseTimingInternal(batchState, "vegetation placement (spread)", totalStopwatch.Elapsed);
                owner.LogGenerationPhaseTimingInternal("vegetation placement (spread)", totalStopwatch.Elapsed);
                FinishDeferredGenerationPhases(batchState);
            }
            else if (!completed)
            {
                DiscardPendingVegetationBuildOutputs(batchState);
                owner.ReleaseTerrainPhaseAfterAbortedBatchInternal(batchState);
            }
        }
    }

    private static int ResolveVegetationWorkItemChunkSize(VegetationPriorityBucket bucket)
    {
        return bucket switch
        {
            VegetationPriorityBucket.CenterCanopyAndLarge => 32,
            VegetationPriorityBucket.OuterCanopyAndLarge => 48,
            VegetationPriorityBucket.CenterClutterAndGround => 192,
            VegetationPriorityBucket.OuterClutter => 192,
            VegetationPriorityBucket.OuterGroundAndDebris => 192,
            _ => 192,
        };
    }

    private static void IncrementCount(IDictionary<string, int> counts, string key)
    {
        if (counts.TryGetValue(key, out int existing))
        {
            counts[key] = existing + 1;
            return;
        }

        counts[key] = 1;
    }

    private static void AddCount(IDictionary<string, int> counts, string key, int amount)
    {
        if (counts.TryGetValue(key, out int existing))
        {
            counts[key] = existing + amount;
            return;
        }

        counts[key] = amount;
    }
}
