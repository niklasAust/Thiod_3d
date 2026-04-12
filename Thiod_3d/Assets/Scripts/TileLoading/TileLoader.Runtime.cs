using UnityEngine;

#nullable enable

internal sealed class TileLoaderRuntime
{
    private readonly TileLoader owner;
    private readonly DynamicTileScheduler dynamicTileScheduler;

    public TileLoaderRuntime(TileLoader owner)
    {
        this.owner = owner;
        dynamicTileScheduler = new DynamicTileScheduler();
    }

    public void OnEnable()
    {
        owner.ResetRuntimeLifecycleState();
        dynamicTileScheduler.Reset();

        if (owner.ShouldLoadOnEnableInEditModeInternal())
        {
            owner.LoadTileIntoScene();
            return;
        }

#if UNITY_EDITOR
        if (!Application.isPlaying && owner.LoadOnEnableInEditModeInternal && owner.HasGeneratedTerrainsInternal())
        {
            owner.ScheduleEditorTerrainSeamRebuildInternal();
        }
#endif
    }

    public void Start()
    {
        if (Application.isPlaying && owner.DynamicTileLoadingEnabled)
        {
            if (dynamicTileScheduler.TryGetCurrentPlayerTileCoordinate(owner, out Vector3Int runtimeTileCoordinate))
            {
                dynamicTileScheduler.RequestLoad(owner, runtimeTileCoordinate, forceImmediate: true);
            }
            else if (owner.LoadOnStartInPlayModeInternal)
            {
                owner.LoadTileIntoScene();
            }

            return;
        }

        if (Application.isPlaying && owner.LoadOnStartInPlayModeInternal)
        {
            owner.LoadTileIntoScene();
            return;
        }

        if (Application.isPlaying && owner.HasGeneratedTerrainsInternal())
        {
            if (owner.UsesLegacyVegetationObjectsInternal())
            {
                owner.RegisterExistingGeneratedTreeObjectsInternal();
                owner.AlignExistingGeneratedSurfaceObjectsInternal();
            }

            owner.ScheduleRuntimeTerrainSeamRebuildInternal();
            if (owner.UsesLegacyVegetationObjectsInternal())
            {
                owner.UpdateConiferOptimizationInternal(forceFullIfNoTarget: true);
            }
        }
    }

    public void OnDisable()
    {
        owner.CancelActiveVegetationPopulationInternal();
        owner.StopActiveTerrainLoadCoroutineInternal();
        owner.ResetRuntimeStreamingStateOnDisable();
        dynamicTileScheduler.Reset();
    }

    public void Update()
    {
        if (!Application.isPlaying)
        {
            return;
        }

        owner.CleanupRetiredTerrainContainersInternal();
        owner.RunPendingRuntimeSeamRebuildInternal();

        bool dynamicLoadTriggered = owner.DynamicTileLoadingEnabled && dynamicTileScheduler.Refresh(owner);
        owner.UpdatePlayerCentricSurfaceVegetationInternal(forceImmediate: false);
        owner.UpdateScheduledInstancedVegetationInteractionsInternal();
        if (dynamicLoadTriggered)
        {
            return;
        }

        if (!owner.UsesLegacyVegetationObjectsInternal() || !owner.OptimizeConifersByDistanceInternal)
        {
            if (owner.ConiferOptimizationWasActive)
            {
                owner.ApplyConiferOptimizationToAllInternal(ConiferOptimizationTier.Full);
                owner.ConiferOptimizationWasActive = false;
            }

            return;
        }

        owner.ConiferOptimizationWasActive = true;
        if (Time.unscaledTime < owner.NextConiferOptimizationTime)
        {
            return;
        }

        owner.NextConiferOptimizationTime = Time.unscaledTime + Mathf.Max(0.05f, owner.ConiferOptimizationIntervalInternal);
        owner.UpdateConiferOptimizationInternal();
    }

    public bool RefreshDynamicLoadingInternal()
    {
        return dynamicTileScheduler.Refresh(owner);
    }

    public void RequestDynamicTileLoadProxy(TileLoader _, Vector3Int tileCoordinate, bool forceImmediate)
    {
        dynamicTileScheduler.RequestLoad(owner, tileCoordinate, forceImmediate);
    }

    public void TryDispatchQueuedDynamicLoad()
    {
        dynamicTileScheduler.TryDispatchQueuedLoad(owner);
    }

    public bool TryGetUnityTileCoordinateForDynamicLoadTarget(out Vector3Int tileCoordinate)
    {
        return dynamicTileScheduler.TryGetCurrentPlayerTileCoordinate(owner, out tileCoordinate);
    }

    public Vector3Int ResolveCurrentDesiredDynamicNeighborhoodCenter(Vector3Int fallbackTileCoordinate)
    {
        return dynamicTileScheduler.ResolveCurrentDesiredDynamicNeighborhoodCenter(owner, fallbackTileCoordinate);
    }

    public bool IsTileCoordinateWithinDynamicNeighborhood(Vector3Int tileCoordinate, Vector3Int centerTileCoordinate)
    {
        return dynamicTileScheduler.IsTileCoordinateWithinDynamicNeighborhood(owner, tileCoordinate, centerTileCoordinate);
    }
}
