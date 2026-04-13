using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using Pinwheel.Griffin;
using UnityEngine;

#nullable enable

namespace Thiod.TileLoading.Runtime
{

internal sealed class VegetationStreamingController
{
    private readonly IVegetationStreamingLifecyclePort lifecycle;
    private readonly IVegetationStreamingExecutionPort execution;
    private readonly IVegetationStreamingReportingPort reporting;
    private readonly IGenerationTelemetryPort telemetry;
    private readonly IVegetationStreamingBudgetPort budget;
    private readonly IVegetationDeferredWorkflowOwner workflowOwner;
    private readonly VegetationStreamingRiverPhaseProcessor riverPhases;
    private readonly TileLoaderDeferredWorkflow deferredWorkflow;
    private GeneratedTerrainBatchState? activeVegetationPopulationBatchState;
    private Stopwatch? activeVegetationPopulationStopwatch;

    public VegetationStreamingController(
        IVegetationStreamingLifecyclePort lifecycle,
        IVegetationStreamingExecutionPort execution,
        IVegetationStreamingReportingPort reporting,
        IGenerationTelemetryPort telemetry,
        IVegetationStreamingBudgetPort budget,
        IVegetationDeferredWorkflowOwner workflowOwner,
        IVegetationStreamingRiverPhaseOwner riverPhaseOwner)
    {
        this.lifecycle = lifecycle;
        this.execution = execution;
        this.reporting = reporting;
        this.telemetry = telemetry;
        this.budget = budget;
        this.workflowOwner = workflowOwner;
        riverPhases = new VegetationStreamingRiverPhaseProcessor(riverPhaseOwner);
        deferredWorkflow = new TileLoaderDeferredWorkflow(
            workflowOwner,
            riverPhases,
            EnsureTerrainStageVisible,
            ExecuteVegetationDeferredPhase);
    }

    public Coroutine? ActiveVegetationPopulationCoroutine { get; private set; }

    public void ScheduleDeferredGenerationPhases(GeneratedTerrainBatchState batchState)
    {
        if (batchState.PipelineId != lifecycle.ActiveGenerationPipelineIdInternal)
        {
            return;
        }

#if UNITY_EDITOR
        if (!workflowOwner.IsPlayingInternal)
        {
            UnityEditor.EditorApplication.delayCall += () => ContinueDeferredGenerationPhases(batchState);
            return;
        }
#endif

        lifecycle.StartRuntimeCoroutine(ContinueDeferredGenerationPhasesNextFrame(batchState));
    }

    public void FinishDeferredGenerationPhases(GeneratedTerrainBatchState batchState)
    {
        if (workflowOwner.ShouldAbortDeferredGenerationInternal(batchState))
        {
            workflowOwner.ReleaseTerrainPhaseAfterAbortedBatchInternal(batchState);
            return;
        }

        if (workflowOwner.IsPlayingInternal)
        {
            lifecycle.UpdateTreeOptimizationInternal(forceFullIfNoTarget: true);
        }

        lifecycle.LastVegetationStreamingTargetWorldPositionInternal =
            batchState.VegetationStreamingTargetWorldPosition ??
            lifecycle.ResolveVegetationStreamingTargetWorldPositionInternal();
        lifecycle.LastCompletedGenerationPipelineIdInternal = batchState.PipelineId;
        lifecycle.LastCompletedRuntimeNeighborhoodCenterTileCoordinateInternal = batchState.CenterTileCoordinate;
        if (lifecycle.ActiveRuntimeRequestedTileCoordinateInternal.HasValue &&
            lifecycle.ActiveRuntimeRequestedTileCoordinateInternal.Value == batchState.CenterTileCoordinate)
        {
            lifecycle.ActiveRuntimeRequestedTileCoordinateInternal = null;
        }

        lifecycle.LogGenerationBatchSummaryInternal(batchState, "complete");
        lifecycle.TerrainPhaseLoadInProgressInternal = false;
        lifecycle.TryDispatchQueuedDynamicLoadInternal();
    }

    private void EnsureTerrainStageVisible(GeneratedTerrainBatchState batchState, string stageLabel)
    {
        if (!batchState.TryPromoteTerrainStageVisible())
        {
            return;
        }

        lifecycle.PromoteGeneratedTerrainBatchInternal(batchState);
        lifecycle.LogGenerationBatchSummaryInternal(batchState, stageLabel);
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
            reporting.Reporter.InterruptAndLogPendingVegetationTileStats(activeVegetationPopulationBatchState, elapsedMilliseconds);
            reporting.DiscardPendingVegetationBuildOutputsInternal(activeVegetationPopulationBatchState);
        }

        lifecycle.StopRuntimeCoroutineInternal(ActiveVegetationPopulationCoroutine);
        ActiveVegetationPopulationCoroutine = null;
        activeVegetationPopulationBatchState = null;
        activeVegetationPopulationStopwatch = null;
    }

    public void PopulateVegetationImmediately(GeneratedTerrainBatchState batchState)
    {
        if (!execution.PlaceTreeObjectsInternal && !execution.PlaceSurfaceObjectsInternal)
        {
            return;
        }

        var totalStopwatch = Stopwatch.StartNew();
        execution.EnsurePlayerCentricSurfaceCachesInternal(batchState, totalStopwatch);

        int terrainCount = Math.Min(batchState.VegetationRefreshRequests.Count, batchState.VegetationRefreshTerrains.Count);
        if (execution.UsesLegacyVegetationObjectsInternal())
        {
            execution.MeasureVegetationRenderPhaseInternal(() =>
            {
                for (int i = 0; i < terrainCount; i++)
                {
                    GStylizedTerrain terrain = batchState.VegetationRefreshTerrains[i];
                    if (!IsValidVegetationRefreshTerrain(terrain))
                    {
                        continue;
                    }

                    execution.PopulatePlacedObjectsLegacyInternal(
                        terrain,
                        batchState.VegetationRefreshRequests[i],
                        batchState.NormalizationMinHeight,
                        batchState.NormalizationMaxHeight);
                }
            });
            return;
        }

        var queuePrepStopwatch = Stopwatch.StartNew();
        var workItems = execution.PrepareVegetationWorkItemsInternal(batchState, totalStopwatch);
        queuePrepStopwatch.Stop();
        telemetry.RecordGenerationPhaseTimingInternal(batchState, "vegetation queue prep", queuePrepStopwatch.Elapsed);
        telemetry.LogGenerationPhaseTimingInternal("vegetation queue prep", queuePrepStopwatch.Elapsed);

        for (int i = 0; i < workItems.Count; i++)
        {
            VegetationWorkItem workItem = workItems[i];
            while (execution.ProcessNextVegetationWorkItemPlacementInternal(workItem, totalStopwatch))
            {
            }

            execution.FinalizeVegetationWorkItemInternal(workItem, totalStopwatch);
        }

        totalStopwatch.Stop();
        batchState.MarkVegetationFullySettled(totalStopwatch.Elapsed.TotalMilliseconds);
        reporting.Reporter.FinalizeAndLogPendingVegetationTileStats(batchState, batchState.VegetationFullSettledMilliseconds);
    }

    public List<VegetationWorkItem> PrepareVegetationWorkItems(GeneratedTerrainBatchState batchState, Stopwatch totalStopwatch)
    {
        var orderedWorkItems = new List<VegetationWorkItem>();
        var workItemsByBucket = new Dictionary<VegetationPriorityBucket, List<VegetationWorkItem>>();
        batchState.VegetationStreamingTargetWorldPosition = lifecycle.ResolveVegetationStreamingTargetWorldPositionInternal();
        batchState.VegetationClearOnlyTerrains.Clear();
        int terrainCount = Math.Min(batchState.VegetationRefreshRequests.Count, batchState.VegetationRefreshTerrains.Count);
        for (int i = 0; i < terrainCount; i++)
        {
            GeneratedTerrainRequest request = batchState.VegetationRefreshRequests[i];
            GStylizedTerrain terrain = batchState.VegetationRefreshTerrains[i];
            if (!IsValidVegetationRefreshTerrain(terrain))
            {
                continue;
            }

            Vector2Int tileCoordinate = execution.GetTileCoordinateInternal(request);
            Transform? existingVegetationContainer = execution.FindVegetationContainerInternal(terrain.transform);
            if (request.Layers.PlacedObjects == null || request.Layers.PlacedObjects.Count == 0)
            {
                if (existingVegetationContainer != null)
                {
                    batchState.VegetationClearOnlyTerrains.Add(terrain);
                }

                continue;
            }

            HybridVegetationBuildState? buildState = execution.BeginHybridVegetationBuildInternal(
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
                execution.PrepareVegetationPlacementsForRequestInternal(batchState, totalStopwatch, terrain, request);
            if (preparedPlacements.Count == 0)
            {
                if (existingVegetationContainer != null)
                {
                    batchState.VegetationClearOnlyTerrains.Add(terrain);
                }
                else
                {
                    execution.MarkRuntimeVegetationTileSettledInternal(tileCoordinate);
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

        execution.TryLogVegetationWorkQueueSummaryInternal(batchState, orderedWorkItems);
        return orderedWorkItems;
    }

    private static bool IsValidVegetationRefreshTerrain(GStylizedTerrain terrain)
    {
        return terrain != null &&
               terrain.TerrainData != null;
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

            Transform? vegetationContainer = execution.FindVegetationContainerInternal(terrain.transform);
            if (vegetationContainer != null)
            {
                execution.RetireGeneratedContainerInternal(vegetationContainer);
            }

            if (execution.TryGetUnityTileCoordinateForWorldPositionInternal(terrain.transform.position, out Vector3Int tileCoordinate))
            {
                execution.MarkRuntimeVegetationTileSettledInternal(new Vector2Int(tileCoordinate.x, tileCoordinate.y));
            }
        }
    }

    public void DiscardPendingVegetationBuildOutputs(GeneratedTerrainBatchState batchState)
    {
        string buildContainerName = execution.GetVegetationBuildContainerNameInternal(batchState.PipelineId);
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
                execution.RetireGeneratedContainerInternal(buildContainer);
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
        bool placementBecameVisible = execution.ProcessPreparedHybridVegetationPlacementInternal(workItem, preparedPlacement);
        if (placementBecameVisible && workItem.BuildState.BatchState != null)
        {
            Vector2Int tileCoordinate = execution.GetTileCoordinateFromBuildRequestInternal(workItem.BuildState.Request);
            VegetationTileStreamingStats tileStats = execution.GetOrCreateVegetationTileStatsInternal(
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
            tileStats = execution.GetOrCreateVegetationTileStatsInternal(
                workItem.BuildState.BatchState,
                execution.GetTileCoordinateFromBuildRequestInternal(workItem.BuildState.Request),
                workItem.IsCenterTile);
        }

        int previousFinalizedPlacementCount = workItem.BuildState.LastFinalizedPlacementCount;
        bool shouldFinalizeRenderer =
            workItem.IsFinalChunkForTile ||
            workItem.BuildState.Placements.Count <= 512;
        double rendererFinalizeMilliseconds = shouldFinalizeRenderer
            ? execution.FinalizeHybridVegetationBuildInternal(workItem.BuildState)
            : 0d;
        bool vegetationBecameVisible = false;
        if (workItem.IsFinalChunkForTile)
        {
            vegetationBecameVisible = execution.FinalizeVegetationBuildOutputInternal(workItem.BuildState);
        }

        if (!vegetationBecameVisible &&
            rendererFinalizeMilliseconds > 0d &&
            workItem.BuildState.VegetationContainer != null &&
            workItem.BuildState.VegetationContainer.gameObject.activeInHierarchy)
        {
            vegetationBecameVisible = true;
        }

        execution.RecordPlacementPhaseTimingInternal(
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
            Vector2Int tileCoordinate = execution.GetTileCoordinateFromBuildRequestInternal(workItem.BuildState.Request);
            VegetationTileStreamingStats completedTileStats = tileStats ?? execution.GetOrCreateVegetationTileStatsInternal(
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
            execution.TryLogVegetationWorkItemCompletionInternal(
                workItem,
                completedTileStats,
                completedWorkItemCount,
                visibleInstancedPlacementCount,
                !shouldFinalizeRenderer && workItem.InstancedPlacementCount > 0,
                renderer == null || renderer.IsPrototypeRuntimeReady,
                renderer?.LastPrototypeInitializationMilliseconds ?? 0d);
            if (completedWorkItemCount >= completedTileStats.QueuedWorkItemCount)
            {
                execution.MarkRuntimeVegetationTileSettledInternal(tileCoordinate);
                execution.TryLogSettledVegetationTileInternal(tileCoordinate, completedTileStats);
            }
        }

        if (!workItem.MarksCenterTileReady ||
            workItem.BuildState.BatchState == null ||
            workItem.BuildState.BatchState.VegetationCenterReadyMilliseconds > 0d)
        {
            return;
        }

        if (workItem.BuildState.BatchState.TryMarkVegetationCenterReady(totalStopwatch.Elapsed.TotalMilliseconds))
        {
            execution.LogCenterTileVegetationReadyInternal(workItem.BuildState.BatchState.VegetationCenterReadyMilliseconds);
        }
    }

    private IEnumerator ContinueDeferredGenerationPhasesNextFrame(GeneratedTerrainBatchState batchState)
    {
        yield return null;
        if (!workflowOwner.IsPlayingInternal)
        {
            ContinueDeferredGenerationPhases(batchState);
            yield break;
        }

        yield return ContinueDeferredGenerationPhasesOverMultipleFrames(batchState);
    }

    private void ContinueDeferredGenerationPhases(GeneratedTerrainBatchState batchState)
    {
        HandleDeferredWorkflowResult(batchState, deferredWorkflow.ExecuteImmediate(batchState));
    }

    private IEnumerator ContinueDeferredGenerationPhasesOverMultipleFrames(GeneratedTerrainBatchState batchState)
    {
        yield return deferredWorkflow.ExecuteOverMultipleFrames(batchState);
        HandleDeferredWorkflowResult(batchState, deferredWorkflow.LastResult);
    }

    private DeferredWorkflowAdvanceResult ExecuteVegetationDeferredPhase(GeneratedTerrainBatchState batchState)
    {
        if (execution.ShouldSpreadVegetationInstancingAcrossFramesInternal(batchState))
        {
            activeVegetationPopulationBatchState = batchState;
            activeVegetationPopulationStopwatch = Stopwatch.StartNew();
            ActiveVegetationPopulationCoroutine = lifecycle.StartRuntimeCoroutine(PopulateVegetationOverMultipleFrames(batchState));
            return DeferredWorkflowAdvanceResult.StartedAsyncPhase;
        }

        execution.MeasureVegetationPlacementPhaseInternal(
            batchState,
            () =>
            {
                PopulateVegetationImmediately(batchState);
                FinalizeVegetationClearOnlyTerrains(batchState);
            });
        return DeferredWorkflowAdvanceResult.Completed;
    }

    private void HandleDeferredWorkflowResult(GeneratedTerrainBatchState batchState, DeferredWorkflowAdvanceResult result)
    {
        switch (result)
        {
            case DeferredWorkflowAdvanceResult.ScheduleNextPhase:
                ScheduleDeferredGenerationPhases(batchState);
                return;
            case DeferredWorkflowAdvanceResult.StartedAsyncPhase:
                return;
            case DeferredWorkflowAdvanceResult.Aborted:
                workflowOwner.ReleaseTerrainPhaseAfterAbortedBatchInternal(batchState);
                return;
            default:
                FinishDeferredGenerationPhases(batchState);
                return;
        }
    }

    private IEnumerator PopulateVegetationOverMultipleFrames(GeneratedTerrainBatchState batchState)
    {
        bool completed = false;
        var totalStopwatch = Stopwatch.StartNew();
        try
        {
            yield return execution.EnsurePlayerCentricSurfaceCachesOverMultipleFramesInternal(batchState, totalStopwatch);
            var queuePrepStopwatch = Stopwatch.StartNew();
            var workItems = execution.PrepareVegetationWorkItemsInternal(batchState, totalStopwatch);
            queuePrepStopwatch.Stop();
            telemetry.RecordGenerationPhaseTimingInternal(batchState, "vegetation queue prep", queuePrepStopwatch.Elapsed);
            telemetry.LogGenerationPhaseTimingInternal("vegetation queue prep", queuePrepStopwatch.Elapsed);

            double frameBudgetMilliseconds = budget.ResolveRuntimePhaseBudgetMsInternal(budget.VegetationPlacementBudgetMsPerFrameInternal);
            var frameStopwatch = Stopwatch.StartNew();
            budget.RestartRuntimeChunkStopwatch(frameStopwatch);

            for (int workItemIndex = 0; workItemIndex < workItems.Count; workItemIndex++)
            {
                if (batchState.PipelineId != lifecycle.ActiveGenerationPipelineIdInternal)
                {
                    yield break;
                }

                VegetationWorkItem workItem = workItems[workItemIndex];
                while (execution.ProcessNextVegetationWorkItemPlacementInternal(workItem, totalStopwatch))
                {
                    if (!budget.ShouldYieldAfterRuntimeChunk(frameStopwatch, (float)frameBudgetMilliseconds))
                    {
                        continue;
                    }

                    budget.CommitRuntimeChunk(frameStopwatch);
                    yield return null;
                    budget.RestartRuntimeChunkStopwatch(frameStopwatch);
                    if (batchState.PipelineId != lifecycle.ActiveGenerationPipelineIdInternal)
                    {
                        yield break;
                    }
                }

                execution.FinalizeVegetationWorkItemInternal(workItem, totalStopwatch);
                if (!budget.ShouldYieldAfterRuntimeChunk(frameStopwatch, (float)frameBudgetMilliseconds))
                {
                    continue;
                }

                budget.CommitRuntimeChunk(frameStopwatch);
                yield return null;
                budget.RestartRuntimeChunkStopwatch(frameStopwatch);
            }

            totalStopwatch.Stop();
            batchState.MarkVegetationFullySettled(totalStopwatch.Elapsed.TotalMilliseconds);
            FinalizeVegetationClearOnlyTerrains(batchState);
            reporting.Reporter.FinalizeAndLogPendingVegetationTileStats(batchState, batchState.VegetationFullSettledMilliseconds);
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
            if (completed && batchState.PipelineId == lifecycle.ActiveGenerationPipelineIdInternal)
            {
                telemetry.RecordGenerationPhaseTimingInternal(batchState, "vegetation placement (spread)", totalStopwatch.Elapsed);
                telemetry.LogGenerationPhaseTimingInternal("vegetation placement (spread)", totalStopwatch.Elapsed);
                FinishDeferredGenerationPhases(batchState);
            }
            else if (!completed)
            {
                DiscardPendingVegetationBuildOutputs(batchState);
                workflowOwner.ReleaseTerrainPhaseAfterAbortedBatchInternal(batchState);
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

internal sealed class VegetationStreamingRiverPhaseProcessor
{
    private readonly IVegetationStreamingRiverPhaseOwner owner;

    public VegetationStreamingRiverPhaseProcessor(IVegetationStreamingRiverPhaseOwner owner)
    {
        this.owner = owner;
    }

    public void ExecuteRiverWaterPhase(GeneratedTerrainBatchState batchState)
    {
        owner.MeasureRiverWaterPhaseInternal(
            batchState,
            () =>
            {
                owner.ClearGeneratedRiverOutputsInternal(batchState.RiverRefreshTerrains);
                owner.PopulateRiverWaterForBatchInternal(batchState);
            });
    }

    public void ExecuteRiverSplinePhase(GeneratedTerrainBatchState batchState)
    {
        owner.MeasureRiverSplinePhaseInternal(
            batchState,
            () => owner.PopulateRiverDebugSplinesForBatchInternal(batchState));
    }

    public IEnumerator PopulateRiverWaterOverMultipleFrames(GeneratedTerrainBatchState batchState)
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

    public IEnumerator PopulateRiverDebugSplinesOverMultipleFrames(GeneratedTerrainBatchState batchState)
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
}

internal enum DeferredWorkflowAdvanceResult
{
    ScheduleNextPhase,
    StartedAsyncPhase,
    Completed,
    Aborted,
}

internal sealed class TileLoaderDeferredWorkflow
{
    private readonly IVegetationDeferredWorkflowOwner owner;
    private readonly VegetationStreamingRiverPhaseProcessor riverPhases;
    private readonly Action<GeneratedTerrainBatchState, string> ensureTerrainStageVisible;
    private readonly Func<GeneratedTerrainBatchState, DeferredWorkflowAdvanceResult> executeVegetationPhase;

    public TileLoaderDeferredWorkflow(
        IVegetationDeferredWorkflowOwner owner,
        VegetationStreamingRiverPhaseProcessor riverPhases,
        Action<GeneratedTerrainBatchState, string> ensureTerrainStageVisible,
        Func<GeneratedTerrainBatchState, DeferredWorkflowAdvanceResult> executeVegetationPhase)
    {
        this.owner = owner;
        this.riverPhases = riverPhases;
        this.ensureTerrainStageVisible = ensureTerrainStageVisible;
        this.executeVegetationPhase = executeVegetationPhase;
        LastResult = DeferredWorkflowAdvanceResult.Completed;
    }

    public DeferredWorkflowAdvanceResult LastResult { get; private set; }

    public DeferredWorkflowAdvanceResult ExecuteImmediate(GeneratedTerrainBatchState batchState)
    {
        if (owner.ShouldAbortDeferredGenerationInternal(batchState))
        {
            return DeferredWorkflowAdvanceResult.Aborted;
        }

        DeferredWorkflowAdvanceResult result = batchState.NextDeferredPhase switch
        {
            DeferredGenerationPhase.RiverWater => ExecuteImmediateRiverWaterPhase(batchState),
            DeferredGenerationPhase.DebugSplines => ExecuteImmediateDebugSplinePhase(batchState),
            DeferredGenerationPhase.Vegetation => ExecuteVegetationPhase(batchState),
            _ => DeferredWorkflowAdvanceResult.Completed,
        };

        LastResult = result;
        return result;
    }

    public IEnumerator ExecuteOverMultipleFrames(GeneratedTerrainBatchState batchState)
    {
        LastResult = DeferredWorkflowAdvanceResult.Completed;
        if (owner.ShouldAbortDeferredGenerationInternal(batchState))
        {
            LastResult = DeferredWorkflowAdvanceResult.Aborted;
            yield break;
        }

        if (batchState.IsAwaitingPhase(DeferredGenerationPhase.RiverWater))
        {
            yield return riverPhases.PopulateRiverWaterOverMultipleFrames(batchState);
            if (owner.ShouldAbortDeferredGenerationInternal(batchState))
            {
                LastResult = DeferredWorkflowAdvanceResult.Aborted;
                yield break;
            }

            batchState.AdvanceDeferredPhase();
        }

        if (batchState.IsAwaitingPhase(DeferredGenerationPhase.DebugSplines))
        {
            if (!owner.IsPlayingInternal)
            {
                yield return riverPhases.PopulateRiverDebugSplinesOverMultipleFrames(batchState);
            }

            if (owner.ShouldAbortDeferredGenerationInternal(batchState))
            {
                LastResult = DeferredWorkflowAdvanceResult.Aborted;
                yield break;
            }

            batchState.AdvanceDeferredPhase();
        }

        LastResult = batchState.IsAwaitingPhase(DeferredGenerationPhase.Vegetation)
            ? ExecuteVegetationPhase(batchState)
            : DeferredWorkflowAdvanceResult.Completed;
    }

    private DeferredWorkflowAdvanceResult ExecuteImmediateRiverWaterPhase(GeneratedTerrainBatchState batchState)
    {
        riverPhases.ExecuteRiverWaterPhase(batchState);
        batchState.AdvanceDeferredPhase();
        return DeferredWorkflowAdvanceResult.ScheduleNextPhase;
    }

    private DeferredWorkflowAdvanceResult ExecuteImmediateDebugSplinePhase(GeneratedTerrainBatchState batchState)
    {
        riverPhases.ExecuteRiverSplinePhase(batchState);
        batchState.AdvanceDeferredPhase();
        return DeferredWorkflowAdvanceResult.ScheduleNextPhase;
    }

    private DeferredWorkflowAdvanceResult ExecuteVegetationPhase(GeneratedTerrainBatchState batchState)
    {
        ensureTerrainStageVisible(batchState, "terrain-complete");
        batchState.MarkDeferredWorkflowCompleted();
        return executeVegetationPhase(batchState);
    }
}

}
