using Opsive.UltimateCharacterController.Character;
using UnityEngine;
using UnityEngine.UI;

#nullable enable

internal sealed class TileLoaderRuntime
{
    private const float TileGateBoundaryInsetMeters = 0.1f;
    private const float LoadingSpinnerDegreesPerSecond = 240f;

    private readonly TileLoader owner;
    private readonly DynamicTileScheduler dynamicTileScheduler;
    private Vector2Int? lastSettledTileCoordinate;
    private Vector2Int? blockedTileCoordinate;
    private Vector3 lastSettledWorldPosition;
    private bool hasLastSettledWorldPosition;
    private bool isTileGateBlocking;
    private GameObject? loadingOverlayRoot;
    private RectTransform? loadingSpinnerRect;
    private CanvasGroup? loadingOverlayCanvasGroup;
    private Sprite? loadingSpinnerSprite;

    public TileLoaderRuntime(TileLoader owner)
    {
        this.owner = owner;
        dynamicTileScheduler = new DynamicTileScheduler();
    }

    public void OnEnable()
    {
        owner.ResetRuntimeLifecycleState();
        dynamicTileScheduler.Reset();
        ResetTileGateState(destroyOverlay: false);

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
        ResetTileGateState(destroyOverlay: true);
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
        UpdateTileGate();
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

        if (ShouldHoldConiferOptimizationAtFull())
        {
            owner.ApplyConiferOptimizationToAllInternal(ConiferOptimizationTier.Full);
            owner.ConiferOptimizationWasActive = false;
            owner.NextConiferOptimizationTime = Time.unscaledTime + Mathf.Max(0.05f, owner.ConiferOptimizationIntervalInternal);
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

    internal Vector3Int? BlockedDynamicUnityTileCoordinateInternal
    {
        get
        {
            if (!blockedTileCoordinate.HasValue)
            {
                return null;
            }

            Vector2Int blockedTile = blockedTileCoordinate.Value;
            return new Vector3Int(blockedTile.x, blockedTile.y, owner.UnityTileCoordinate.z);
        }
    }

    public Vector3Int ResolveCurrentDesiredDynamicNeighborhoodCenter(Vector3Int fallbackTileCoordinate)
    {
        return dynamicTileScheduler.ResolveCurrentDesiredDynamicNeighborhoodCenter(owner, fallbackTileCoordinate);
    }

    public bool IsTileCoordinateWithinDynamicNeighborhood(Vector3Int tileCoordinate, Vector3Int centerTileCoordinate)
    {
        return dynamicTileScheduler.IsTileCoordinateWithinDynamicNeighborhood(owner, tileCoordinate, centerTileCoordinate);
    }

    private void UpdateTileGate()
    {
        if (!owner.DynamicTileLoadingEnabled)
        {
            HideLoadingOverlay();
            return;
        }

        Transform? target = dynamicTileScheduler.GetDynamicLoadTarget(owner);
        if (target == null ||
            !owner.TryGetUnityTileCoordinateForWorldPositionInternal(target.position, out Vector3Int currentTileCoordinate))
        {
            HideLoadingOverlay();
            return;
        }

        var currentTile = new Vector2Int(currentTileCoordinate.x, currentTileCoordinate.y);
        if (!lastSettledTileCoordinate.HasValue)
        {
            if (owner.LastCompletedRuntimeNeighborhoodCenterTileCoordinateInternal.HasValue)
            {
                Vector3Int completedCenterCoordinate = owner.LastCompletedRuntimeNeighborhoodCenterTileCoordinateInternal.Value;
                lastSettledTileCoordinate = new Vector2Int(completedCenterCoordinate.x, completedCenterCoordinate.y);
                lastSettledWorldPosition = target.position;
                hasLastSettledWorldPosition = true;
            }
            else if (owner.ActiveLoadedUnityTileCoordinate.HasValue)
            {
                Vector3Int activeLoadedTileCoordinate = owner.ActiveLoadedUnityTileCoordinate.Value;
                var activeLoadedTile = new Vector2Int(activeLoadedTileCoordinate.x, activeLoadedTileCoordinate.y);
                if (owner.IsRuntimeVegetationTileSettledInternal(activeLoadedTile) &&
                    !owner.IsTerrainPhaseLoadInProgress &&
                    !owner.ActiveRuntimeRequestedTileCoordinateInternal.HasValue)
                {
                    lastSettledTileCoordinate = activeLoadedTile;
                    lastSettledWorldPosition = target.position;
                    hasLastSettledWorldPosition = true;
                }
            }
        }

        if (blockedTileCoordinate.HasValue)
        {
            Vector2Int blockedTile = blockedTileCoordinate.Value;
            if (IsTileGateReleasedForTile(blockedTile))
            {
                blockedTileCoordinate = null;
                isTileGateBlocking = false;
                HideLoadingOverlay();
                return;
            }

            if (!lastSettledTileCoordinate.HasValue)
            {
                isTileGateBlocking = false;
                HideLoadingOverlay();
                return;
            }

            Vector3 blockedWorldPosition = ResolveGatedWorldPosition(
                target.position,
                lastSettledTileCoordinate.Value,
                blockedTile);
            ApplyTileGatePosition(target, blockedWorldPosition);
            isTileGateBlocking = true;
            ShowLoadingOverlay();
            return;
        }

        if (IsTileGateReleasedForTile(currentTile))
        {
            lastSettledTileCoordinate = currentTile;
            lastSettledWorldPosition = target.position;
            hasLastSettledWorldPosition = true;
            blockedTileCoordinate = null;
            isTileGateBlocking = false;
            HideLoadingOverlay();
            return;
        }

        if (lastSettledTileCoordinate.HasValue && lastSettledTileCoordinate.Value == currentTile)
        {
            lastSettledWorldPosition = target.position;
            hasLastSettledWorldPosition = true;
            blockedTileCoordinate = null;
            isTileGateBlocking = false;
            HideLoadingOverlay();
            return;
        }

        if (!lastSettledTileCoordinate.HasValue)
        {
            blockedTileCoordinate = null;
            isTileGateBlocking = false;
            HideLoadingOverlay();
            return;
        }

        blockedTileCoordinate = currentTile;
        Vector3 gatedWorldPosition = ResolveGatedWorldPosition(
            target.position,
            lastSettledTileCoordinate.Value,
            blockedTileCoordinate.Value);
        ApplyTileGatePosition(target, gatedWorldPosition);
        isTileGateBlocking = true;
        ShowLoadingOverlay();
    }

    private Vector3 ResolveGatedWorldPosition(Vector3 targetWorldPosition, Vector2Int settledTileCoordinate, Vector2Int blockedTileCoordinate)
    {
        if (!hasLastSettledWorldPosition)
        {
            return targetWorldPosition;
        }

        int deltaX = blockedTileCoordinate.x - settledTileCoordinate.x;
        int deltaY = blockedTileCoordinate.y - settledTileCoordinate.y;
        if (Mathf.Abs(deltaX) > 1 || Mathf.Abs(deltaY) > 1)
        {
            return lastSettledWorldPosition;
        }

        if (deltaX == 0 && deltaY == 0)
        {
            return lastSettledWorldPosition;
        }

        Vector3 gatedLocalPosition = owner.transform.InverseTransformPoint(targetWorldPosition);
        bool clamped = false;
        if (deltaX > 0)
        {
            gatedLocalPosition.x = Mathf.Min(
                gatedLocalPosition.x,
                blockedTileCoordinate.x * owner.TerrainWidthInternal - TileGateBoundaryInsetMeters);
            clamped = true;
        }
        else if (deltaX < 0)
        {
            gatedLocalPosition.x = Mathf.Max(
                gatedLocalPosition.x,
                (blockedTileCoordinate.x + 1) * owner.TerrainWidthInternal + TileGateBoundaryInsetMeters);
            clamped = true;
        }

        if (deltaY > 0)
        {
            gatedLocalPosition.z = Mathf.Min(
                gatedLocalPosition.z,
                blockedTileCoordinate.y * owner.TerrainLengthInternal - TileGateBoundaryInsetMeters);
            clamped = true;
        }
        else if (deltaY < 0)
        {
            gatedLocalPosition.z = Mathf.Max(
                gatedLocalPosition.z,
                (blockedTileCoordinate.y + 1) * owner.TerrainLengthInternal + TileGateBoundaryInsetMeters);
            clamped = true;
        }

        return clamped ? owner.transform.TransformPoint(gatedLocalPosition) : lastSettledWorldPosition;
    }

    private void ApplyTileGatePosition(Transform target, Vector3 gatedWorldPosition)
    {
        UltimateCharacterLocomotion? ultimateCharacterLocomotion = target.GetComponentInParent<UltimateCharacterLocomotion>();
        if (ultimateCharacterLocomotion != null)
        {
            ultimateCharacterLocomotion.SetPosition(gatedWorldPosition, snapAnimator: false);
        }
        else
        {
            CharacterLocomotion? characterLocomotion = target.GetComponentInParent<CharacterLocomotion>();
            if (characterLocomotion != null)
            {
                characterLocomotion.SetPosition(gatedWorldPosition);
            }
            else
            {
                target.position = gatedWorldPosition;
            }
        }

        Rigidbody? rigidbody = target.GetComponentInParent<Rigidbody>();
        if (rigidbody != null && !rigidbody.isKinematic)
        {
            rigidbody.linearVelocity = Vector3.zero;
            rigidbody.angularVelocity = Vector3.zero;
        }
    }

    private void ShowLoadingOverlay()
    {
        EnsureLoadingOverlay();
        if (loadingOverlayRoot == null)
        {
            return;
        }

        loadingOverlayRoot.SetActive(true);
        if (loadingOverlayCanvasGroup != null)
        {
            loadingOverlayCanvasGroup.alpha = 1f;
        }

        if (loadingSpinnerRect != null)
        {
            loadingSpinnerRect.Rotate(0f, 0f, -LoadingSpinnerDegreesPerSecond * Time.unscaledDeltaTime);
        }
    }

    private void HideLoadingOverlay()
    {
        if (loadingOverlayRoot == null)
        {
            return;
        }

        loadingOverlayRoot.SetActive(false);
        if (loadingOverlayCanvasGroup != null)
        {
            loadingOverlayCanvasGroup.alpha = 0f;
        }
    }

    private void EnsureLoadingOverlay()
    {
        if (loadingOverlayRoot != null)
        {
            return;
        }

        loadingOverlayRoot = new GameObject("TileLoaderLoadingOverlay");
        Canvas canvas = loadingOverlayRoot.AddComponent<Canvas>();
        canvas.renderMode = RenderMode.ScreenSpaceOverlay;
        canvas.sortingOrder = short.MaxValue;
        loadingOverlayRoot.AddComponent<CanvasScaler>();
        loadingOverlayRoot.AddComponent<GraphicRaycaster>();
        loadingOverlayCanvasGroup = loadingOverlayRoot.AddComponent<CanvasGroup>();
        loadingOverlayRoot.SetActive(false);

        var spinnerRoot = new GameObject("LoadingCircle", typeof(RectTransform), typeof(Image));
        spinnerRoot.transform.SetParent(loadingOverlayRoot.transform, false);
        loadingSpinnerRect = spinnerRoot.GetComponent<RectTransform>();
        loadingSpinnerRect.anchorMin = new Vector2(0.5f, 0.5f);
        loadingSpinnerRect.anchorMax = new Vector2(0.5f, 0.5f);
        loadingSpinnerRect.pivot = new Vector2(0.5f, 0.5f);
        loadingSpinnerRect.sizeDelta = new Vector2(72f, 72f);
        loadingSpinnerRect.anchoredPosition = Vector2.zero;

        Image spinnerImage = spinnerRoot.GetComponent<Image>();
        spinnerImage.sprite = GetLoadingSpinnerSprite();
        spinnerImage.type = Image.Type.Filled;
        spinnerImage.fillMethod = Image.FillMethod.Radial360;
        spinnerImage.fillClockwise = true;
        spinnerImage.fillOrigin = 2;
        spinnerImage.fillAmount = 0.8f;
        spinnerImage.color = new Color(1f, 1f, 1f, 0.92f);
        spinnerImage.preserveAspect = true;
    }

    private Sprite GetLoadingSpinnerSprite()
    {
        if (loadingSpinnerSprite != null)
        {
            return loadingSpinnerSprite;
        }

        loadingSpinnerSprite = Sprite.Create(
            Texture2D.whiteTexture,
            new Rect(0f, 0f, Texture2D.whiteTexture.width, Texture2D.whiteTexture.height),
            new Vector2(0.5f, 0.5f));
        return loadingSpinnerSprite;
    }

    private void ResetTileGateState(bool destroyOverlay)
    {
        lastSettledTileCoordinate = null;
        blockedTileCoordinate = null;
        lastSettledWorldPosition = default;
        hasLastSettledWorldPosition = false;
        isTileGateBlocking = false;

        if (destroyOverlay && loadingOverlayRoot != null)
        {
            Object.Destroy(loadingOverlayRoot);
            loadingOverlayRoot = null;
            loadingSpinnerRect = null;
            loadingOverlayCanvasGroup = null;
        }
        else
        {
            HideLoadingOverlay();
        }
    }

    private bool IsTileGateReleasedForTile(Vector2Int tileCoordinate)
    {
        if (owner.LastCompletedRuntimeNeighborhoodCenterTileCoordinateInternal.HasValue)
        {
            Vector3Int completedCenterCoordinate = owner.LastCompletedRuntimeNeighborhoodCenterTileCoordinateInternal.Value;
            if (completedCenterCoordinate.x == tileCoordinate.x &&
                completedCenterCoordinate.y == tileCoordinate.y)
            {
                return true;
            }
        }

        if (owner.IsTerrainPhaseLoadInProgress || owner.ActiveRuntimeRequestedTileCoordinateInternal.HasValue)
        {
            return false;
        }

        if (!owner.ActiveLoadedUnityTileCoordinate.HasValue)
        {
            return false;
        }

        Vector3Int activeLoadedTileCoordinate = owner.ActiveLoadedUnityTileCoordinate.Value;
        return activeLoadedTileCoordinate.x == tileCoordinate.x &&
               activeLoadedTileCoordinate.y == tileCoordinate.y &&
               owner.IsRuntimeVegetationTileSettledInternal(tileCoordinate);
    }

    private bool ShouldHoldConiferOptimizationAtFull()
    {
        return owner.DynamicTileLoadingEnabled &&
               (owner.IsTerrainPhaseLoadInProgress ||
                owner.ActiveRuntimeRequestedTileCoordinateInternal.HasValue ||
                isTileGateBlocking);
    }
}
