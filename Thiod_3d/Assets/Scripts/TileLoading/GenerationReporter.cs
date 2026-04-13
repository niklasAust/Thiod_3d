using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using UnityEngine;

#nullable enable

namespace Thiod.TileLoading.Runtime
{

internal sealed class GenerationReporter
{
    private readonly TileLoader owner;

    public GenerationReporter(TileLoader owner)
    {
        this.owner = owner;
    }

    public void LogGenerationBatchSummary(GeneratedTerrainBatchState batchState, string stageLabel)
    {
        if (!owner.LogGenerationPhaseTimingsEnabledInternal || batchState.PhaseTimingsMilliseconds.Count == 0)
        {
            return;
        }

        double totalMilliseconds = 0d;
        foreach (KeyValuePair<string, double> phaseTiming in batchState.PhaseTimingsMilliseconds)
        {
            totalMilliseconds += phaseTiming.Value;
        }

        string slowestPhases = string.Join(
            ", ",
            batchState.PhaseTimingsMilliseconds
                .OrderByDescending(pair => pair.Value)
                .Take(4)
                .Select(pair =>
                    $"{pair.Key}={pair.Value.ToString("F1", CultureInfo.InvariantCulture)} ms"));
        Debug.Log(
            $"TileLoader {stageLabel} summary for center ({batchState.CenterTileCoordinate.x},{batchState.CenterTileCoordinate.y},0): " +
            $"total={totalMilliseconds.ToString("F1", CultureInfo.InvariantCulture)} ms, slowest=[{slowestPhases}], " +
            $"activeTiles={batchState.ActiveTerrains.Count}, createdTiles={batchState.CreatedTerrains.Count}, reusedTiles={batchState.ReusedTerrainCount}, " +
            $"removedTiles={batchState.RemovedTerrainCount}, reusedWorldgenTiles={batchState.ReusedRequestCount}, " +
            $"riverRefreshTiles={batchState.RiverRefreshTerrains.Count}, vegetationRefreshTiles={batchState.VegetationRefreshTerrains.Count}, " +
            $"surfaceTileCachesBuilt={batchState.PlayerCentricSurfaceTileCacheBuildCount}, surfaceCellsBuilt={batchState.PlayerCentricSurfaceCellBuildCount}, surfacePlacements={batchState.PlayerCentricSurfacePlacementCount}, " +
            $"vegGenerated={batchState.VegetationGeneratedPlacementCount}, vegKept={batchState.VegetationKeptPlacementCount}, " +
            $"vegSkippedPolicy={batchState.VegetationSkippedByPolicyCount}, vegSkippedDistance={batchState.VegetationSkippedByDistanceCount}, vegSkippedCap={batchState.VegetationSkippedByCapCount}, " +
            $"vegQueuedPlacements={batchState.VegetationQueuedPlacementCount}, vegWorkItems={batchState.VegetationQueuedWorkItemCount}, " +
            $"vegInstanced={batchState.VegetationInstancedPlacementCount}, vegLegacy={batchState.VegetationLegacyPlacementCount}, " +
            $"vegTreeCoupledSurface={batchState.VegetationTreeCoupledSurfacePlacementCount}, " +
            $"vegExactConform={batchState.VegetationExactTerrainConformPlacementCount}, vegApprox={batchState.VegetationApproximatePlacementCount}, " +
            $"vegDeferredFinalizes={batchState.VegetationDeferredRendererFinalizeCount}, vegRendererFinalizes={batchState.VegetationRendererFinalizeCount}, " +
            $"queuePrepCpuMs={batchState.VegetationQueuePrepCpuMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"placementCpuMs={batchState.VegetationPlacementCpuMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"surfaceSourceBuildCpuMs={batchState.PlayerCentricSurfaceSourceBuildCpuMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"prototypeCacheHits={batchState.VegetationPrototypeCacheHitCount}, prototypeCacheMisses={batchState.VegetationPrototypeCacheMissCount}, " +
            $"forcedInstancingOnly={batchState.VegetationForcedInstancingOnlyCount}, rendererInits={batchState.VegetationRendererInitializationCount}, " +
            $"prefabResolveMs={batchState.VegetationPrefabResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"prototypeResolveMs={batchState.VegetationPrototypeResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"positionBuildMs={batchState.VegetationPositionBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"normalBuildMs={batchState.VegetationNormalBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"rendererFinalizeMs={batchState.VegetationRendererFinalizeMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"prototypeInitMs={batchState.VegetationPrototypeInitializationMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"heightmapSamples={batchState.VegetationHeightmapSampleCount}, raycastSamples={batchState.VegetationRaycastSampleCount}, " +
            $"centerReadyMs={batchState.VegetationCenterReadyMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"fullSettledMs={batchState.VegetationFullSettledMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"surfaceActiveCells={batchState.PlayerCentricSurfaceActiveCellCount}, surfaceActivatedCells={batchState.PlayerCentricSurfaceActivatedCellCount}, surfaceDeactivatedCells={batchState.PlayerCentricSurfaceDeactivatedCellCount}, " +
            $"surfaceFirstVisibleMs={batchState.PlayerCentricSurfaceFirstVisibleMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, surfaceSettledMs={batchState.PlayerCentricSurfaceFullSettledMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"missingPrefabs={batchState.VegetationMissingPrefabCount}, surfaceMissingPrefabs={batchState.PlayerCentricSurfaceMissingPrefabCount}, surfaceTreeCoupledExcluded={batchState.PlayerCentricSurfaceTreeCoupledPlacementExcludedCount}, " +
            $"queueBuckets=[{FormatBucketSummary(batchState.VegetationQueuedPlacementsByBucket, batchState.VegetationQueuedWorkItemsByBucket, 6)}].",
            owner);

        if (batchState.VegetationTileStats.Count > 0)
        {
            string tileSummary = string.Join(
                "; ",
                batchState.VegetationTileStats
                    .OrderBy(pair => pair.Key.y)
                    .ThenBy(pair => pair.Key.x)
                    .Select(pair =>
                    {
                        VegetationTileStreamingStats stats = pair.Value;
                        string categories = FormatVegetationTileCategorySummary(stats, 5);
                        string settledOrInterruptedMs = stats.Status == VegetationTileStreamingStatus.Interrupted
                            ? stats.InterruptedMilliseconds.ToString("F1", CultureInfo.InvariantCulture)
                            : stats.TileReadyMilliseconds.ToString("F1", CultureInfo.InvariantCulture);
                        return $"tile({pair.Key.x},{pair.Key.y})[{(stats.IsCenterTile ? "center" : "outer")}]: status={stats.Status}, kept={stats.KeptCount}/{stats.GeneratedCount}, skipped={stats.SkippedCount}, queuedPlacements={stats.QueuedPlacementCount}, workItems={stats.QueuedWorkItemCount}, instanced={stats.InstancedPlacementCount}, legacy={stats.LegacyPlacementCount}, treeCoupledSurface={stats.TreeCoupledSurfacePlacementCount}, exactConform={stats.ExactTerrainConformPlacementCount}, approx={stats.ApproximatePlacementCount}, deferredFinalizes={stats.DeferredRendererFinalizeCount}, rendererFinalizes={stats.RendererFinalizeCount}, queuePrepCpuMs={stats.QueuePrepCpuMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, placementCpuMs={stats.PlacementCpuMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, prefabResolveMs={stats.PrefabResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, prototypeResolveMs={stats.PrototypeResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, positionBuildMs={stats.PositionBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, normalBuildMs={stats.NormalBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, rendererFinalizeMs={stats.RendererFinalizeMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, placementWallMs={stats.PlacementWallMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, firstVisibleWallMs={stats.FirstVisibleMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, settledWallMs={settledOrInterruptedMs}, heightmapSamples={stats.HeightmapSampleCount}, raycastSamples={stats.RaycastSampleCount}, buckets=[{FormatBucketSummary(stats.QueuedPlacementsByBucket, stats.QueuedWorkItemsByBucket, 4)}], cats=[{categories}]";
                    }));
            Debug.Log($"TileLoader vegetation tile stats: {tileSummary}", owner);
        }

        if (batchState.MissingPrefabCountsByPath.Count > 0)
        {
            string missingPrefabSummary = string.Join(
                ", ",
                batchState.MissingPrefabCountsByPath
                    .OrderByDescending(pair => pair.Value)
                    .Take(6)
                    .Select(pair => $"{pair.Key}={pair.Value}"));
            Debug.Log($"TileLoader missing prefab skips this batch: [{missingPrefabSummary}]", owner);
        }
    }

    public void FinalizeAndLogPendingVegetationTileStats(GeneratedTerrainBatchState batchState, double fallbackElapsedMilliseconds)
    {
        foreach (KeyValuePair<Vector2Int, VegetationTileStreamingStats> pair in batchState.VegetationTileStats)
        {
            VegetationTileStreamingStats tileStats = pair.Value;
            if (tileStats.QueuedWorkItemCount <= 0)
            {
                continue;
            }

            tileStats.MarkSettled(fallbackElapsedMilliseconds);
            TryLogSettledVegetationTile(pair.Key, tileStats);
        }
    }

    public void InterruptAndLogPendingVegetationTileStats(GeneratedTerrainBatchState batchState, double interruptedElapsedMilliseconds)
    {
        foreach (KeyValuePair<Vector2Int, VegetationTileStreamingStats> pair in batchState.VegetationTileStats)
        {
            VegetationTileStreamingStats tileStats = pair.Value;
            if (tileStats.QueuedWorkItemCount <= 0 || tileStats.Status == VegetationTileStreamingStatus.Settled)
            {
                continue;
            }

            tileStats.MarkInterrupted(interruptedElapsedMilliseconds);
            TryLogInterruptedVegetationTile(pair.Key, tileStats);
        }
    }

    public void TryLogSettledVegetationTile(Vector2Int tileCoordinate, VegetationTileStreamingStats tileStats)
    {
        if (!owner.LogGenerationPhaseTimingsEnabledInternal || tileStats.HasLoggedReady || tileStats.Status != VegetationTileStreamingStatus.Settled)
        {
            return;
        }

        tileStats.HasLoggedReady = true;
        Debug.Log(
            $"TileLoader tile ({tileCoordinate.x},{tileCoordinate.y}) vegetation fully settled: " +
            $"queuePrepCpuMs={tileStats.QueuePrepCpuMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"placementCpuMs={tileStats.PlacementCpuMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"prefabResolveMs={tileStats.PrefabResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"prototypeResolveMs={tileStats.PrototypeResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"positionBuildMs={tileStats.PositionBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"normalBuildMs={tileStats.NormalBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"rendererFinalizeMs={tileStats.RendererFinalizeMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"placementWallMs={tileStats.PlacementWallMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"settledWallMs={tileStats.TileReadyMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"kept={tileStats.KeptCount}/{tileStats.GeneratedCount}, skipped={tileStats.SkippedCount}, " +
            $"queuedPlacements={tileStats.QueuedPlacementCount}, workItems={tileStats.QueuedWorkItemCount}, instanced={tileStats.InstancedPlacementCount}, legacy={tileStats.LegacyPlacementCount}, treeCoupledSurface={tileStats.TreeCoupledSurfacePlacementCount}, missingPrefabs={tileStats.MissingPrefabCount}, exactConform={tileStats.ExactTerrainConformPlacementCount}, approx={tileStats.ApproximatePlacementCount}, deferredFinalizes={tileStats.DeferredRendererFinalizeCount}, rendererFinalizes={tileStats.RendererFinalizeCount}, " +
            $"heightmapSamples={tileStats.HeightmapSampleCount}, raycastSamples={tileStats.RaycastSampleCount}, " +
            $"{FormatFirstVisibleFragment(tileStats)}buckets=[{FormatBucketSummary(tileStats.QueuedPlacementsByBucket, tileStats.QueuedWorkItemsByBucket, 5)}], cats=[{FormatVegetationTileCategorySummary(tileStats, 6)}].",
            owner);
    }

    public void TryLogInterruptedVegetationTile(Vector2Int tileCoordinate, VegetationTileStreamingStats tileStats)
    {
        if (!owner.LogGenerationPhaseTimingsEnabledInternal || tileStats.HasLoggedReady || tileStats.Status != VegetationTileStreamingStatus.Interrupted)
        {
            return;
        }

        tileStats.HasLoggedReady = true;
        Debug.Log(
            $"TileLoader tile ({tileCoordinate.x},{tileCoordinate.y}) vegetation interrupted before settle: " +
            $"queuePrepCpuMs={tileStats.QueuePrepCpuMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"placementCpuMs={tileStats.PlacementCpuMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"prefabResolveMs={tileStats.PrefabResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"prototypeResolveMs={tileStats.PrototypeResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"positionBuildMs={tileStats.PositionBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"normalBuildMs={tileStats.NormalBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"rendererFinalizeMs={tileStats.RendererFinalizeMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"placementWallMs={tileStats.PlacementWallMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"interruptedWallMs={tileStats.InterruptedMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"kept={tileStats.KeptCount}/{tileStats.GeneratedCount}, skipped={tileStats.SkippedCount}, " +
            $"queuedPlacements={tileStats.QueuedPlacementCount}, workItems={tileStats.QueuedWorkItemCount}, instanced={tileStats.InstancedPlacementCount}, legacy={tileStats.LegacyPlacementCount}, treeCoupledSurface={tileStats.TreeCoupledSurfacePlacementCount}, missingPrefabs={tileStats.MissingPrefabCount}, exactConform={tileStats.ExactTerrainConformPlacementCount}, approx={tileStats.ApproximatePlacementCount}, deferredFinalizes={tileStats.DeferredRendererFinalizeCount}, rendererFinalizes={tileStats.RendererFinalizeCount}, " +
            $"heightmapSamples={tileStats.HeightmapSampleCount}, raycastSamples={tileStats.RaycastSampleCount}, " +
            $"{FormatFirstVisibleFragment(tileStats)}buckets=[{FormatBucketSummary(tileStats.QueuedPlacementsByBucket, tileStats.QueuedWorkItemsByBucket, 5)}], cats=[{FormatVegetationTileCategorySummary(tileStats, 6)}].",
            owner);
    }

    public void TryLogVegetationWorkQueueSummary(
        GeneratedTerrainBatchState batchState,
        IReadOnlyList<VegetationWorkItem> workItems)
    {
        if (!owner.LogGenerationPhaseTimingsEnabledInternal || !owner.LogVegetationPlacementWorkItemsEnabledInternal)
        {
            return;
        }

        int centerWorkItems = workItems.Count(item => item.IsCenterTile);
        int outerWorkItems = workItems.Count - centerWorkItems;
        int totalQueuedPlacements = workItems.Sum(item => item.Placements.Count);
        Debug.Log(
            $"TileLoader vegetation work queue: workItems={workItems.Count}, queuedPlacements={totalQueuedPlacements}, centerWorkItems={centerWorkItems}, outerWorkItems={outerWorkItems}, buckets=[{FormatBucketSummary(batchState.VegetationQueuedPlacementsByBucket, batchState.VegetationQueuedWorkItemsByBucket, 8)}].",
            owner);

        string tileQueueSummary = string.Join(
            "; ",
            batchState.VegetationTileStats
                .OrderBy(pair => pair.Key.y)
                .ThenBy(pair => pair.Key.x)
                .Where(pair => pair.Value.QueuedWorkItemCount > 0)
                .Select(pair =>
                {
                    VegetationTileStreamingStats stats = pair.Value;
                    return $"tile({pair.Key.x},{pair.Key.y})[{(stats.IsCenterTile ? "center" : "outer")}]: queuedPlacements={stats.QueuedPlacementCount}, workItems={stats.QueuedWorkItemCount}, buckets=[{FormatBucketSummary(stats.QueuedPlacementsByBucket, stats.QueuedWorkItemsByBucket, 4)}]";
                }));
        if (!string.IsNullOrWhiteSpace(tileQueueSummary))
        {
            Debug.Log($"TileLoader vegetation tile queue: {tileQueueSummary}", owner);
        }
    }

    public void TryLogVegetationWorkItemCompletion(
        VegetationWorkItem workItem,
        VegetationTileStreamingStats? tileStats,
        int completedWorkItemCount,
        int visibleInstancedPlacementCount,
        bool rendererFinalizeDeferred,
        bool rendererReady,
        double rendererPrototypeInitMilliseconds)
    {
        if (!owner.LogGenerationPhaseTimingsEnabledInternal || !owner.LogVegetationPlacementWorkItemsEnabledInternal)
        {
            return;
        }

        Vector2Int tileCoordinate = owner.GetTileCoordinateInternal(workItem.BuildState.Request);
        int totalQueuedWorkItems = tileStats != null ? tileStats.QueuedWorkItemCount : 0;
        Debug.Log(
            $"TileLoader vegetation chunk tile ({tileCoordinate.x},{tileCoordinate.y})[{(workItem.IsCenterTile ? "center" : "outer")}]: " +
            $"bucket={workItem.PriorityBucket}, chunk={workItem.ChunkIndexWithinBucket + 1}/{workItem.ChunkCountWithinBucket}, chunkPlacements={workItem.Placements.Count}, completedChunks={completedWorkItemCount}/{totalQueuedWorkItems}, " +
            $"instancedAdded={workItem.InstancedPlacementCount}, legacyAdded={workItem.LegacyPlacementCount}, visibleInstancedNow={visibleInstancedPlacementCount}, missingPrefabs={workItem.MissingPrefabCount}, forcedInstancingOnly={workItem.ForcedInstancingOnlyCount}, exactConform={workItem.ExactTerrainConformPlacementCount}, approx={workItem.ApproximatePlacementCount}, newPrototypes={workItem.NewPrototypeCount}, " +
            $"prefabResolveMs={workItem.PrefabResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, prototypeResolveMs={workItem.PrototypeResolveMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, positionBuildMs={workItem.PositionBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, normalBuildMs={workItem.NormalBuildMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, rendererFinalizeMs={workItem.RendererFinalizeMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, " +
            $"rendererDeferred={rendererFinalizeDeferred}, rendererReady={rendererReady}, rendererPrototypeInitMs={rendererPrototypeInitMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, cumulativeInstanced={workItem.BuildState.Placements.Count}, cumulativePrototypes={workItem.BuildState.Prototypes.Count}.",
            owner);
    }

    private static string FormatBucketSummary(
        IDictionary<string, int> placementCountsByBucket,
        IDictionary<string, int>? workItemCountsByBucket = null,
        int maxBuckets = 5)
    {
        if (placementCountsByBucket.Count == 0)
        {
            return "none";
        }

        IEnumerable<string> orderedBucketKeys = placementCountsByBucket
            .OrderByDescending(entry => entry.Value)
            .Take(Math.Max(1, maxBuckets))
            .Select(entry => entry.Key);
        return string.Join(
            ", ",
            orderedBucketKeys.Select(bucketKey =>
            {
                int placementCount = placementCountsByBucket.TryGetValue(bucketKey, out int placementValue)
                    ? placementValue
                    : 0;
                int workItemCount = workItemCountsByBucket != null &&
                                    workItemCountsByBucket.TryGetValue(bucketKey, out int workItemValue)
                    ? workItemValue
                    : 0;
                return workItemCountsByBucket == null
                    ? $"{bucketKey}={placementCount}"
                    : $"{bucketKey}={placementCount}p/{workItemCount}w";
            }));
    }

    private static string FormatVegetationTileCategorySummary(VegetationTileStreamingStats stats, int maxCategories = 5)
    {
        if (stats.GeneratedByCategory.Count == 0)
        {
            return "none";
        }

        return string.Join(
            ", ",
            stats.GeneratedByCategory
                .OrderByDescending(entry => entry.Value)
                .Take(Math.Max(1, maxCategories))
                .Select(entry =>
                {
                    int kept = stats.KeptByCategory.TryGetValue(entry.Key, out int keptValue) ? keptValue : 0;
                    return $"{entry.Key}={kept}/{entry.Value}";
                }));
    }

    private static string FormatFirstVisibleFragment(VegetationTileStreamingStats tileStats)
    {
        return tileStats.FirstVisibleMilliseconds > 0d
            ? $"firstVisibleWallMs={tileStats.FirstVisibleMilliseconds.ToString("F1", CultureInfo.InvariantCulture)}, "
            : string.Empty;
    }
}

}
