using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using Pinwheel.Griffin;
using UnityEngine;
using UnityEngine.Splines;
using WorldGen;

#nullable enable

namespace Thiod.TileLoading.Runtime
{

internal sealed class TileLoaderGenerationTelemetryPort : IGenerationTelemetryPort
{
    private readonly TileLoader owner;

    public TileLoaderGenerationTelemetryPort(TileLoader owner)
    {
        this.owner = owner;
    }

    public void RecordGenerationPhaseTimingInternal(GeneratedTerrainBatchState? batchState, string phaseName, TimeSpan elapsed)
        => owner.RecordGenerationPhaseTimingInternal(batchState, phaseName, elapsed);

    public void LogGenerationPhaseTimingInternal(string phaseName, TimeSpan elapsed)
        => owner.LogGenerationPhaseTimingInternal(phaseName, elapsed);
}

internal sealed class TileLoaderRuntimeBudgetPort :
    ITerrainStreamingBudgetPort,
    IVegetationStreamingBudgetPort,
    IPlayerCentricSurfaceBudgetPort,
    IInstancedVegetationRuntimeBudgetOwner
{
    private readonly TileLoader owner;

    public TileLoaderRuntimeBudgetPort(TileLoader owner)
    {
        this.owner = owner;
    }

    public float TerrainCreationBudgetMsPerFrameInternal => owner.TerrainCreationBudgetMsPerFrameInternal;
    public float TerrainSeamBudgetMsPerFrameInternal => owner.TerrainSeamBudgetMsPerFrameInternal;
    public float TerrainShadingBudgetMsPerFrameInternal => owner.TerrainShadingBudgetMsPerFrameInternal;
    public float RuntimeGlobalBudgetMsPerFrameInternal => owner.RuntimeGlobalBudgetMsPerFrameInternal;
    public float VegetationPlacementBudgetMsPerFrameInternal => owner.VegetationPlacementBudgetMsPerFrameInternal;
    public float PlayerCentricSurfaceBuildBudgetMsPerFrameInternal => owner.PlayerCentricSurfaceBuildBudgetMsPerFrameInternal;
    public int ActiveGenerationPipelineIdInternal => owner.ActiveGenerationPipelineIdInternal;

    public float ResolveRuntimePhaseBudgetMsInternal(float localBudgetMilliseconds)
        => owner.ResolveRuntimePhaseBudgetMsInternal(localBudgetMilliseconds);

    public void RestartRuntimeChunkStopwatch(Stopwatch chunkStopwatch)
        => owner.RestartRuntimeChunkStopwatch(chunkStopwatch);

    public bool ShouldYieldAfterRuntimeChunk(Stopwatch chunkStopwatch, float localBudgetMilliseconds, double minimumBudgetMilliseconds = 0.25d)
        => owner.ShouldYieldAfterRuntimeChunk(chunkStopwatch, localBudgetMilliseconds, minimumBudgetMilliseconds);

    public void CommitRuntimeChunk(Stopwatch chunkStopwatch)
        => owner.CommitRuntimeChunk(chunkStopwatch);

    public void RegisterInstancedVegetationRendererInternal(TileLoaderInstancedVegetationRenderer renderer)
        => owner.RegisterInstancedVegetationRendererInternal(renderer);

    public void UnregisterInstancedVegetationRendererInternal(TileLoaderInstancedVegetationRenderer renderer)
        => owner.UnregisterInstancedVegetationRendererInternal(renderer);
}

internal sealed class TerrainStreamingLifecyclePortAdapter : ITerrainStreamingLifecyclePort
{
    private readonly TileLoader owner;

    public TerrainStreamingLifecyclePortAdapter(TileLoader owner)
    {
        this.owner = owner;
    }

    public int BeginTerrainGenerationPipelineInternal() => owner.BeginTerrainGenerationPipelineInternal();
    public int ActiveGenerationPipelineIdInternal => owner.ActiveGenerationPipelineIdInternal;
    public bool IsPlayingInternal => owner.IsPlayingInternal;
    public bool DynamicTileLoadingEnabled => owner.DynamicTileLoadingEnabled;
    public bool TerrainPhaseLoadInProgressInternal { get => owner.TerrainPhaseLoadInProgressInternal; set => owner.TerrainPhaseLoadInProgressInternal = value; }
    public void CancelActiveVegetationPopulationInternal() => owner.CancelActiveVegetationPopulationInternal();
    public void ResetGeneratedRuntimeArtifactsInternal() => owner.ResetGeneratedRuntimeArtifactsInternal();
    public void ClearGeneratedTerrainsInternal() => owner.ClearGeneratedTerrainsInternal();
    public Coroutine StartRuntimeCoroutine(IEnumerator routine) => owner.StartRuntimeCoroutine(routine);
    public Coroutine? ActiveTerrainLoadCoroutineInternal { get => owner.ActiveTerrainLoadCoroutineInternal; set => owner.ActiveTerrainLoadCoroutineInternal = value; }
    public Coroutine? ActiveVegetationPopulationCoroutineInternal => owner.ActiveVegetationPopulationCoroutineInternal;
    public Vector3Int UnityTileCoordinate => owner.UnityTileCoordinate;
    public Vector3Int? ActiveRuntimeRequestedTileCoordinateInternal { get => owner.ActiveRuntimeRequestedTileCoordinateInternal; set => owner.ActiveRuntimeRequestedTileCoordinateInternal = value; }
    public bool ShouldAbortRuntimeTerrainStreamingInternal(GeneratedTerrainBatchState batchState) => owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState);
    public void ReleaseTerrainPhaseAfterAbortedBatchInternal(GeneratedTerrainBatchState batchState) => owner.ReleaseTerrainPhaseAfterAbortedBatchInternal(batchState);
    public void TryDispatchQueuedDynamicLoadInternal() => owner.TryDispatchQueuedDynamicLoadInternal();
}

internal sealed class TerrainStreamingBatchPortAdapter : ITerrainStreamingBatchPort
{
    private readonly TileLoader owner;

    public TerrainStreamingBatchPortAdapter(TileLoader owner)
    {
        this.owner = owner;
    }

    public GeneratedTerrainBatchState MeasureBatchWorldgenInternal(TileGenerator tileGenerator, LoadedWorldData loadedWorldData, GenerationSettings settings, int pipelineId)
        => owner.MeasureBatchWorldgenInternal(tileGenerator, loadedWorldData, settings, pipelineId);

    public bool TryReuseActiveTerrainBatchRootInternal(GeneratedTerrainBatchState batchState)
        => owner.TryReuseActiveTerrainBatchRootInternal(batchState);

    public Transform CreateGeneratedTerrainBatchRootInternal(int pipelineId, Vector3Int centerTileCoordinate)
        => owner.CreateGeneratedTerrainBatchRootInternal(pipelineId, centerTileCoordinate);

    public void FinalizeTerrainBatchStateInternal(GeneratedTerrainBatchState batchState)
        => owner.FinalizeTerrainBatchStateInternal(batchState);

    public void DestroyGeneratedTerrainContainerInternal(Transform? container)
        => owner.DestroyGeneratedTerrainContainerInternal(container);

    public void PrepareDeferredGenerationTargetsInternal(GeneratedTerrainBatchState batchState)
        => owner.PrepareDeferredGenerationTargetsInternal(batchState);

    public void ScheduleDeferredGenerationPhasesInternal(GeneratedTerrainBatchState batchState)
        => owner.ScheduleDeferredGenerationPhasesInternal(batchState);

    public string GetTerrainBatchWorldgenPhaseNameInternal() => owner.GetTerrainBatchWorldgenPhaseNameInternal();
    public TileLoaderBatchPlanner CreateBatchPlannerInternal() => owner.CreateBatchPlannerInternal();
    public GeneratedTerrainBatchCacheEntry? CachedTerrainBatchInternal { get => owner.CachedTerrainBatchInternal; set => owner.CachedTerrainBatchInternal = value; }
    public Transform? ActiveGeneratedTerrainRootInternal => owner.ActiveGeneratedTerrainRootInternal;
    public Vector3Int? ActiveLoadedUnityTileCoordinate => owner.ActiveLoadedUnityTileCoordinate;
    public Dictionary<Vector2Int, GeneratedTerrainTileData> ActiveTerrainTileCacheInternal => owner.ActiveTerrainTileCacheInternal;
    public string? ActiveTerrainTileCacheSignatureInternal => owner.ActiveTerrainTileCacheSignatureInternal;
}

internal sealed class TerrainStreamingCreationPortAdapter : ITerrainStreamingCreationPort
{
    private readonly TileLoader owner;

    public TerrainStreamingCreationPortAdapter(TileLoader owner)
    {
        this.owner = owner;
    }

    public void MeasureTerrainCreationPhaseInternal(GeneratedTerrainBatchState batchState, Action action) => owner.MeasureTerrainCreationPhaseInternal(batchState, action);
    public int GetGeneratedTerrainGroupIdInternal() => owner.GetGeneratedTerrainGroupIdInternal();
    public Vector2Int GetTileCoordinateInternal(GeneratedTerrainRequest request) => owner.GetTileCoordinateInternal(request);
    public GStylizedTerrain CreateTerrainInternal(TileLayers layers, string terrainObjectName, Vector3 localPosition, int unityTileX, int unityTileY, double normalizationMinHeight, double normalizationMaxHeight, double localMinHeight, double localMaxHeight, double tileHilliness, int terrainGroupId, Transform parent)
        => owner.CreateTerrainInternal(layers, terrainObjectName, localPosition, unityTileX, unityTileY, normalizationMinHeight, normalizationMaxHeight, localMinHeight, localMaxHeight, tileHilliness, terrainGroupId, parent);
    public List<GeneratedTerrainRequest> GetTerrainCreationRequestsInPriorityOrderInternal(GeneratedTerrainBatchState batchState) => owner.GetTerrainCreationRequestsInPriorityOrderInternal(batchState);
    public GTerrainData CreateTerrainDataForRuntimeCreationInternal(TileLayers layers, double normalizationMinHeight, double normalizationMaxHeight, double localMaxHeight, double tileHilliness)
        => owner.CreateTerrainDataForRuntimeCreationInternal(layers, normalizationMinHeight, normalizationMaxHeight, localMaxHeight, tileHilliness);
    public Color[] BuildTerrainHeightPixelsForRuntimeCreationInternal(double[,] heightmap, double normalizationMinHeight, double normalizationMaxHeight)
        => owner.BuildTerrainHeightPixelsForRuntimeCreationInternal(heightmap, normalizationMinHeight, normalizationMaxHeight);
    public void UploadTerrainHeightPixelsForRuntimeCreationInternal(GTerrainData terrainData, Color[] heightPixels)
        => owner.UploadTerrainHeightPixelsForRuntimeCreationInternal(terrainData, heightPixels);
    public GStylizedTerrain FinalizeRuntimeCreatedTerrainInternal(TileLayers layers, GTerrainData terrainData, string terrainObjectName, Vector3 localPosition, int unityTileX, int unityTileY, double normalizationMinHeight, double normalizationMaxHeight, double localMinHeight, double localMaxHeight, double tileHilliness, int terrainGroupId, Transform parent)
        => owner.FinalizeRuntimeCreatedTerrainInternal(layers, terrainData, terrainObjectName, localPosition, unityTileX, unityTileY, normalizationMinHeight, normalizationMaxHeight, localMinHeight, localMaxHeight, tileHilliness, terrainGroupId, parent);
}

internal sealed class TerrainStreamingSeamPortAdapter : ITerrainStreamingSeamPort
{
    private readonly TileLoader owner;

    public TerrainStreamingSeamPortAdapter(TileLoader owner)
    {
        this.owner = owner;
    }

    public void MeasureTerrainSeamsPhaseInternal(GeneratedTerrainBatchState batchState, Action action) => owner.MeasureTerrainSeamsPhaseInternal(batchState, action);
    public void RebuildTerrainSeamsInternal(IReadOnlyList<GStylizedTerrain> terrains) => owner.RebuildTerrainSeamsInternal(terrains);
    public void ConnectAdjacentTerrainsInternal() => owner.ConnectAdjacentTerrainsInternal();
    public void RebuildTerrainSeamsInternal(GStylizedTerrain terrain, TileLoaderTerrainSeamMask seamMask) => owner.RebuildTerrainSeamsInternal(terrain, seamMask);
}

internal sealed class TerrainStreamingShadingPortAdapter : ITerrainStreamingShadingPort
{
    private readonly TileLoader owner;

    public TerrainStreamingShadingPortAdapter(TileLoader owner)
    {
        this.owner = owner;
    }

    public void MeasureTerrainShadingPhaseInternal(GeneratedTerrainBatchState batchState, Action action) => owner.MeasureTerrainShadingPhaseInternal(batchState, action);
    public IReadOnlyList<GStylizedTerrain> GetTerrainsForStreamingShadingInternal(GeneratedTerrainBatchState batchState) => owner.GetTerrainsForStreamingShadingInternal(batchState);
    public void ApplyTerrainShadingInternal(IReadOnlyList<GStylizedTerrain> terrains) => owner.ApplyTerrainShadingInternal(terrains);
}

internal sealed class VegetationStreamingControllerOwner :
    IVegetationDeferredWorkflowOwner,
    IVegetationStreamingRiverPhaseOwner,
    IVegetationStreamingLifecyclePort,
    IVegetationStreamingReportingPort,
    IVegetationStreamingExecutionPort
{
    private readonly TileLoader owner;

    public VegetationStreamingControllerOwner(TileLoader owner)
    {
        this.owner = owner;
    }

    public int ActiveGenerationPipelineIdInternal => owner.ActiveGenerationPipelineIdInternal;
    public bool IsPlayingInternal => owner.IsPlayingInternal;
    public Coroutine StartRuntimeCoroutine(IEnumerator routine) => owner.StartRuntimeCoroutine(routine);
    public bool ShouldAbortDeferredGenerationInternal(GeneratedTerrainBatchState batchState) => owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState);
    public bool ShouldAbortRuntimeTerrainStreamingInternal(GeneratedTerrainBatchState batchState) => owner.ShouldAbortRuntimeTerrainStreamingInternal(batchState);
    public void ReleaseTerrainPhaseAfterAbortedBatchInternal(GeneratedTerrainBatchState batchState) => owner.ReleaseTerrainPhaseAfterAbortedBatchInternal(batchState);
    public void UpdateTreeOptimizationInternal(bool forceFullIfNoTarget = false) => owner.UpdateTreeOptimizationInternal(forceFullIfNoTarget);
    public Vector3? LastVegetationStreamingTargetWorldPositionInternal { get => owner.LastVegetationStreamingTargetWorldPositionInternal; set => owner.LastVegetationStreamingTargetWorldPositionInternal = value; }
    public Vector3? ResolveVegetationStreamingTargetWorldPositionInternal() => owner.ResolveVegetationStreamingTargetWorldPositionInternal();
    public int LastCompletedGenerationPipelineIdInternal { get => owner.LastCompletedGenerationPipelineIdInternal; set => owner.LastCompletedGenerationPipelineIdInternal = value; }
    public Vector3Int? LastCompletedRuntimeNeighborhoodCenterTileCoordinateInternal { get => owner.LastCompletedRuntimeNeighborhoodCenterTileCoordinateInternal; set => owner.LastCompletedRuntimeNeighborhoodCenterTileCoordinateInternal = value; }
    public Vector3Int? ActiveRuntimeRequestedTileCoordinateInternal { get => owner.ActiveRuntimeRequestedTileCoordinateInternal; set => owner.ActiveRuntimeRequestedTileCoordinateInternal = value; }
    public void LogGenerationBatchSummaryInternal(GeneratedTerrainBatchState batchState, string stage) => owner.LogGenerationBatchSummaryInternal(batchState, stage);
    public bool TerrainPhaseLoadInProgressInternal { get => owner.TerrainPhaseLoadInProgressInternal; set => owner.TerrainPhaseLoadInProgressInternal = value; }
    public void TryDispatchQueuedDynamicLoadInternal() => owner.TryDispatchQueuedDynamicLoadInternal();
    public void PromoteGeneratedTerrainBatchInternal(GeneratedTerrainBatchState batchState) => owner.PromoteGeneratedTerrainBatchInternal(batchState);
    public GenerationReporter Reporter => owner.Reporter;
    public void DiscardPendingVegetationBuildOutputsInternal(GeneratedTerrainBatchState batchState) => owner.DiscardPendingVegetationBuildOutputsInternal(batchState);
    public void StopRuntimeCoroutineInternal(Coroutine? routine) => owner.StopRuntimeCoroutineInternal(routine);
    public bool PlaceTreeObjectsInternal => owner.PlaceTreeObjectsInternal;
    public bool PlaceSurfaceObjectsInternal => owner.PlaceSurfaceObjectsInternal;
    public void EnsurePlayerCentricSurfaceCachesInternal(GeneratedTerrainBatchState batchState, Stopwatch totalStopwatch) => owner.EnsurePlayerCentricSurfaceCachesInternal(batchState, totalStopwatch);
    public bool UsesLegacyVegetationObjectsInternal() => owner.UsesLegacyVegetationObjectsInternal();
    public void MeasureVegetationRenderPhaseInternal(Action action) => owner.MeasureVegetationRenderPhaseInternal(action);
    public void PopulatePlacedObjectsLegacyInternal(GStylizedTerrain terrain, GeneratedTerrainRequest request, double normalizationMinHeight, double normalizationMaxHeight) => owner.PopulatePlacedObjectsLegacyInternal(terrain, request, normalizationMinHeight, normalizationMaxHeight);
    public List<VegetationWorkItem> PrepareVegetationWorkItemsInternal(GeneratedTerrainBatchState batchState, Stopwatch totalStopwatch) => owner.PrepareVegetationWorkItemsInternal(batchState, totalStopwatch);
    public void RecordGenerationPhaseTimingInternal(GeneratedTerrainBatchState? batchState, string phaseName, TimeSpan elapsed) => owner.RecordGenerationPhaseTimingInternal(batchState, phaseName, elapsed);
    public void LogGenerationPhaseTimingInternal(string phaseName, TimeSpan elapsed) => owner.LogGenerationPhaseTimingInternal(phaseName, elapsed);
    public HybridVegetationBuildState? BeginHybridVegetationBuildInternal(GeneratedTerrainBatchState? batchState, GStylizedTerrain terrain, GeneratedTerrainRequest request, double normalizationMinHeight, double normalizationMaxHeight) => owner.BeginHybridVegetationBuildInternal(batchState, terrain, request, normalizationMinHeight, normalizationMaxHeight);
    public Transform? FindVegetationContainerInternal(Transform terrainTransform) => owner.FindVegetationContainerInternal(terrainTransform);
    public void MarkRuntimeVegetationTileSettledInternal(Vector2Int tileCoordinate) => owner.MarkRuntimeVegetationTileSettledInternal(tileCoordinate);
    public void TryLogVegetationWorkQueueSummaryInternal(GeneratedTerrainBatchState batchState, IReadOnlyList<VegetationWorkItem> workItems) => owner.TryLogVegetationWorkQueueSummaryInternal(batchState, workItems);
    public void RetireGeneratedContainerInternal(Transform container) => owner.RetireGeneratedContainerInternal(container);
    public bool TryGetUnityTileCoordinateForWorldPositionInternal(Vector3 worldPosition, out Vector3Int tileCoordinate) => owner.TryGetUnityTileCoordinateForWorldPositionInternal(worldPosition, out tileCoordinate);
    public string GetVegetationBuildContainerNameInternal(int pipelineId) => owner.GetVegetationBuildContainerNameInternal(pipelineId);
    public bool ProcessPreparedHybridVegetationPlacementInternal(VegetationWorkItem workItem, PreparedVegetationPlacement preparedPlacement) => owner.ProcessPreparedHybridVegetationPlacementInternal(workItem, preparedPlacement);
    public Vector2Int GetTileCoordinateFromBuildRequestInternal(GeneratedTerrainRequest request) => owner.GetTileCoordinateFromBuildRequestInternal(request);
    public VegetationTileStreamingStats GetOrCreateVegetationTileStatsInternal(GeneratedTerrainBatchState batchState, Vector2Int tileCoordinate, bool isCenterTile) => owner.GetOrCreateVegetationTileStatsInternal(batchState, tileCoordinate, isCenterTile);
    public double FinalizeHybridVegetationBuildInternal(HybridVegetationBuildState buildState) => owner.FinalizeHybridVegetationBuildInternal(buildState);
    public bool FinalizeVegetationBuildOutputInternal(HybridVegetationBuildState buildState) => owner.FinalizeVegetationBuildOutputInternal(buildState);
    public void RecordPlacementPhaseTimingInternal(GeneratedTerrainBatchState? batchState, VegetationTileStreamingStats? tileStats, double elapsedMilliseconds, VegetationPlacementPhase placementPhase, VegetationWorkItem? workItem = null) => owner.RecordPlacementPhaseTimingInternal(batchState, tileStats, elapsedMilliseconds, placementPhase, workItem);
    public void TryLogVegetationWorkItemCompletionInternal(VegetationWorkItem workItem, VegetationTileStreamingStats? tileStats, int completedWorkItemCount, int visibleInstancedPlacementCount, bool rendererFinalizeDeferred, bool rendererReady, double rendererPrototypeInitMilliseconds) => owner.TryLogVegetationWorkItemCompletionInternal(workItem, tileStats, completedWorkItemCount, visibleInstancedPlacementCount, rendererFinalizeDeferred, rendererReady, rendererPrototypeInitMilliseconds);
    public void TryLogSettledVegetationTileInternal(Vector2Int tileCoordinate, VegetationTileStreamingStats tileStats) => owner.TryLogSettledVegetationTileInternal(tileCoordinate, tileStats);
    public void LogCenterTileVegetationReadyInternal(double elapsedMilliseconds) => owner.LogCenterTileVegetationReadyInternal(elapsedMilliseconds);
    public float ResolveRuntimePhaseBudgetMsInternal(float localBudgetMilliseconds) => owner.ResolveRuntimePhaseBudgetMsInternal(localBudgetMilliseconds);
    public float RuntimeGlobalBudgetMsPerFrameInternal => owner.RuntimeGlobalBudgetMsPerFrameInternal;
    public float VegetationPlacementBudgetMsPerFrameInternal => owner.VegetationPlacementBudgetMsPerFrameInternal;
    public bool ProcessNextVegetationWorkItemPlacementInternal(VegetationWorkItem workItem, Stopwatch totalStopwatch) => owner.ProcessNextVegetationWorkItemPlacementInternal(workItem, totalStopwatch);
    public void FinalizeVegetationWorkItemInternal(VegetationWorkItem workItem, Stopwatch totalStopwatch) => owner.FinalizeVegetationWorkItemInternal(workItem, totalStopwatch);
    public bool ShouldSpreadVegetationInstancingAcrossFramesInternal(GeneratedTerrainBatchState batchState) => owner.ShouldSpreadVegetationInstancingAcrossFramesInternal(batchState);
    public IEnumerator EnsurePlayerCentricSurfaceCachesOverMultipleFramesInternal(GeneratedTerrainBatchState batchState, Stopwatch totalStopwatch) => owner.EnsurePlayerCentricSurfaceCachesOverMultipleFramesInternal(batchState, totalStopwatch);
    public void RestartRuntimeChunkStopwatch(Stopwatch chunkStopwatch) => owner.RestartRuntimeChunkStopwatch(chunkStopwatch);
    public bool ShouldYieldAfterRuntimeChunk(Stopwatch chunkStopwatch, float localBudgetMilliseconds, double minimumBudgetMilliseconds = 0.25d) => owner.ShouldYieldAfterRuntimeChunk(chunkStopwatch, localBudgetMilliseconds, minimumBudgetMilliseconds);
    public void CommitRuntimeChunk(Stopwatch chunkStopwatch) => owner.CommitRuntimeChunk(chunkStopwatch);
    public void MeasureRiverWaterPhaseInternal(GeneratedTerrainBatchState batchState, Action action) => owner.MeasureRiverWaterPhaseInternal(batchState, action);
    public void ClearGeneratedRiverOutputsInternal(IReadOnlyList<GStylizedTerrain> terrains) => owner.ClearGeneratedRiverOutputsInternal(terrains);
    public void PopulateRiverWaterForBatchInternal(GeneratedTerrainBatchState batchState) => owner.PopulateRiverWaterForBatchInternal(batchState);
    public int GetRiverWaterPathCountInternal(GeneratedTerrainRequest request, GStylizedTerrain terrain) => owner.GetRiverWaterPathCountInternal(request, terrain);
    public bool PopulateRiverWaterForPathInternal(GeneratedTerrainRequest request, GStylizedTerrain terrain, int riverPathIndex, double normalizationMinHeight, double normalizationMaxHeight, Dictionary<string, Spline> riverSplineCache, IDictionary<string, RiverWaterSeamCrossSection> riverWaterSeams) => owner.PopulateRiverWaterForPathInternal(request, terrain, riverPathIndex, normalizationMinHeight, normalizationMaxHeight, riverSplineCache, riverWaterSeams);
    public void MeasureRiverSplinePhaseInternal(GeneratedTerrainBatchState batchState, Action action) => owner.MeasureRiverSplinePhaseInternal(batchState, action);
    public void PopulateRiverDebugSplinesForBatchInternal(GeneratedTerrainBatchState batchState) => owner.PopulateRiverDebugSplinesForBatchInternal(batchState);
    public bool PopulateRiverDebugSplinesForTerrainInternal(GeneratedTerrainRequest request, GStylizedTerrain terrain, double normalizationMinHeight, double normalizationMaxHeight, Dictionary<string, Spline> riverSplineCache) => owner.PopulateRiverDebugSplinesForTerrainInternal(request, terrain, normalizationMinHeight, normalizationMaxHeight, riverSplineCache);
    public void MeasureVegetationPlacementPhaseInternal(GeneratedTerrainBatchState batchState, Action action) => owner.MeasureVegetationPlacementPhaseInternal(batchState, action);
    public List<PreparedVegetationPlacement> PrepareVegetationPlacementsForRequestInternal(GeneratedTerrainBatchState batchState, Stopwatch totalStopwatch, GStylizedTerrain terrain, GeneratedTerrainRequest request) => owner.PrepareVegetationPlacementsForRequestInternal(batchState, totalStopwatch, terrain, request);
    public Vector2Int GetTileCoordinateInternal(GeneratedTerrainRequest request) => owner.GetTileCoordinateInternal(request);
}

internal sealed class PlayerCentricSurfaceSettingsPortAdapter : IPlayerCentricSurfaceSettingsPort
{
    private readonly TileLoader owner;

    public PlayerCentricSurfaceSettingsPortAdapter(TileLoader owner)
    {
        this.owner = owner;
    }

    public bool IsPlayingInternal => owner.IsPlayingInternal;
    public bool PlayerCentricSurfaceVegetationEnabledInternal => owner.PlayerCentricSurfaceVegetationEnabledInternal;
    public bool PlaceSurfaceObjectsInternal => owner.PlaceSurfaceObjectsInternal;
    public float PlayerCentricSurfaceUpdateIntervalSecondsInternal => owner.PlayerCentricSurfaceUpdateIntervalSecondsInternal;
    public Vector3? ResolveVegetationStreamingTargetWorldPositionInternal() => owner.ResolveVegetationStreamingTargetWorldPositionInternal();
    public float PlayerCentricSurfaceRadiusMetersInternal => owner.PlayerCentricSurfaceRadiusMetersInternal;
    public float PlayerCentricSurfaceHysteresisMetersInternal => owner.PlayerCentricSurfaceHysteresisMetersInternal;
    public float PlayerCentricSurfaceCellSizeMetersInternal => owner.PlayerCentricSurfaceCellSizeMetersInternal;
    public int PlayerCentricSurfaceCacheVersionInternal => owner.PlayerCentricSurfaceCacheVersionInternal;
}

internal sealed class PlayerCentricSurfaceGeometryPortAdapter : IPlayerCentricSurfaceGeometryPort
{
    private readonly TileLoader owner;

    public PlayerCentricSurfaceGeometryPortAdapter(TileLoader owner)
    {
        this.owner = owner;
    }

    public Vector2Int GetTileCoordinateInternal(GeneratedTerrainRequest request) => owner.GetTileCoordinateInternal(request);
    public bool TryBuildPreparedPlacementGeometryInternal(GeneratedTerrainBatchState batchState, VegetationTileStreamingStats? tileStats, GStylizedTerrain terrain, GeneratedTerrainRequest request, TileObjectPlacement placement, bool isTreePlacement, bool enforceCurrentStreamingDistance, out PreparedPlacementGeometry geometry)
        => owner.TryBuildPreparedPlacementGeometryInternal(batchState, tileStats, terrain, request, placement, isTreePlacement, enforceCurrentStreamingDistance, out geometry);
    public bool IsTreeCoupledSurfacePlacementInternal(TileObjectPlacement placement) => owner.IsTreeCoupledSurfacePlacementInternal(placement);
    public ulong ComputeStablePlacementHashInternal(GeneratedTerrainRequest request, TileObjectPlacement placement) => owner.ComputeStablePlacementHashInternal(request, placement);
    public void PopulatePreparedPlacementGeometryNormalsInternal(GeneratedTerrainBatchState batchState, VegetationTileStreamingStats? tileStats, GeneratedTerrainRequest request, List<PreparedVegetationPlacement> preparedPlacements)
        => owner.PopulatePreparedPlacementGeometryNormalsInternal(batchState, tileStats, request, preparedPlacements);
    public bool TrySampleGeneratedTerrainSurfaceInternal(GStylizedTerrain terrain, float localX, float localZ, float verticalOffset, out Vector3 exactLocalSurfacePoint, out Vector3 exactLocalSurfaceNormal)
        => owner.TrySampleGeneratedTerrainSurfaceInternal(terrain, localX, localZ, verticalOffset, out exactLocalSurfacePoint, out exactLocalSurfaceNormal);
    public float SurfaceObjectVerticalOffsetInternal => owner.SurfaceObjectVerticalOffsetInternal;
    public float GetSurfaceObjectOffsetInternal() => owner.GetSurfaceObjectOffsetInternal();
}

internal sealed class PlayerCentricSurfacePrototypePortAdapter : IPlayerCentricSurfacePrototypePort
{
    private readonly TileLoader owner;

    public PlayerCentricSurfacePrototypePortAdapter(TileLoader owner)
    {
        this.owner = owner;
    }

    public GameObject? LoadPrefabForPlacementInternal(TileObjectPlacement placement, GeneratedTerrainBatchState? batchState) => owner.LoadPrefabForPlacementInternal(placement, batchState);
    public bool IsTreePlacementInternal(TileObjectPlacement placement, GameObject prefab) => owner.IsTreePlacementInternal(placement, prefab);
    public TileLoaderInstancedVegetationPrototype? GetOrCreateVegetationPrototypeInternal(GeneratedTerrainBatchState? batchState, TileObjectPlacement placement, GameObject prefab, bool isTreeObject, bool supportsPromotion)
        => owner.GetOrCreateVegetationPrototypeInternal(batchState, placement, prefab, isTreeObject, supportsPromotion);
    public bool SupportsHybridPromotionInternal(TileObjectPlacement placement) => owner.SupportsHybridPromotionInternal(placement);
}

internal sealed class PlayerCentricSurfaceRendererPortAdapter : IPlayerCentricSurfaceRendererPort
{
    private readonly TileLoader owner;
    private readonly IInstancedVegetationRuntimeBudgetOwner runtimeBudgetOwner;

    public PlayerCentricSurfaceRendererPortAdapter(TileLoader owner, IInstancedVegetationRuntimeBudgetOwner runtimeBudgetOwner)
    {
        this.owner = owner;
        this.runtimeBudgetOwner = runtimeBudgetOwner;
    }

    public string GetVegetationContainerNameInternal() => owner.GetVegetationContainerNameInternal();
    public VegetationLoadMode VegetationLoadModeInternal => owner.VegetationLoadModeInternal;
    public float VegetationInteractionRadiusMetersInternal => owner.VegetationInteractionRadiusMetersInternal;
    public float VegetationInteractionHysteresisMetersInternal => owner.VegetationInteractionHysteresisMetersInternal;
    public float PrototypeInitBudgetMsPerFrameInternal => owner.PrototypeInitBudgetMsPerFrameInternal;
    public IInstancedVegetationRuntimeBudgetOwner RuntimeBudgetOwnerInternal => runtimeBudgetOwner;
    public void RetireGeneratedContainerInternal(Transform container) => owner.RetireGeneratedContainerInternal(container);
}

}
