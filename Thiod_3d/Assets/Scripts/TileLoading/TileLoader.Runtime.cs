using Opsive.UltimateCharacterController.Character;
using UnityEngine;
using UnityEngine.UI;

#nullable enable

namespace Thiod.TileLoading.Runtime
{

internal sealed class TileLoaderRuntime
{
    private readonly TileLoader owner;
    private readonly DynamicTileScheduler dynamicTileScheduler;
    private readonly TileLoaderTileGateController tileGateController;

    public TileLoaderRuntime(TileLoader owner)
    {
        this.owner = owner;
        dynamicTileScheduler = new DynamicTileScheduler();
        tileGateController = new TileLoaderTileGateController(owner);
    }

    public void OnEnable()
    {
        owner.ResetRuntimeLifecycleState();
        dynamicTileScheduler.Reset();
        tileGateController.Reset(destroyOverlay: false);

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
                owner.UpdateTreeOptimizationInternal(forceFullIfNoTarget: true);
            }
        }
    }

    public void OnDisable()
    {
        owner.CancelActiveVegetationPopulationInternal();
        owner.StopActiveTerrainLoadCoroutineInternal();
        owner.ResetRuntimeStreamingStateOnDisable();
        dynamicTileScheduler.Reset();
        tileGateController.Reset(destroyOverlay: true);
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
        tileGateController.Update(dynamicTileScheduler);
        if (dynamicLoadTriggered)
        {
            return;
        }

        owner.UpdateRuntimeTreeOptimizationInternal(ShouldHoldTreeOptimizationAtFull());
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

    internal Vector3Int? BlockedDynamicUnityTileCoordinateInternal => tileGateController.BlockedDynamicUnityTileCoordinate;

    public Vector3Int ResolveCurrentDesiredDynamicNeighborhoodCenter(Vector3Int fallbackTileCoordinate)
    {
        return dynamicTileScheduler.ResolveCurrentDesiredDynamicNeighborhoodCenter(owner, fallbackTileCoordinate);
    }

    public bool IsTileCoordinateWithinDynamicNeighborhood(Vector3Int tileCoordinate, Vector3Int centerTileCoordinate)
    {
        return dynamicTileScheduler.IsTileCoordinateWithinDynamicNeighborhood(owner, tileCoordinate, centerTileCoordinate);
    }

    private bool ShouldHoldTreeOptimizationAtFull()
    {
        return owner.DynamicTileLoadingEnabled &&
               (owner.IsTerrainPhaseLoadInProgress ||
                owner.ActiveRuntimeRequestedTileCoordinateInternal.HasValue ||
                tileGateController.IsBlocking);
    }
}

internal sealed class TileLoaderLoadingOverlay
{
    private GameObject? root;
    private RectTransform? spinnerRect;
    private CanvasGroup? canvasGroup;
    private Sprite? spinnerSprite;

    public void Show(float rotationDegrees)
    {
        EnsureCreated();
        if (root == null)
        {
            return;
        }

        root.SetActive(true);
        if (canvasGroup != null)
        {
            canvasGroup.alpha = 1f;
        }

        if (spinnerRect != null)
        {
            spinnerRect.Rotate(0f, 0f, rotationDegrees);
        }
    }

    public void Hide()
    {
        if (root == null)
        {
            return;
        }

        root.SetActive(false);
        if (canvasGroup != null)
        {
            canvasGroup.alpha = 0f;
        }
    }

    public void Reset(bool destroy)
    {
        if (!destroy)
        {
            Hide();
            return;
        }

        if (root != null)
        {
            if (Application.isPlaying)
            {
                Object.Destroy(root);
            }
            else
            {
                Object.DestroyImmediate(root);
            }
        }

        root = null;
        spinnerRect = null;
        canvasGroup = null;
        spinnerSprite = null;
    }

    private void EnsureCreated()
    {
        if (root != null)
        {
            return;
        }

        root = new GameObject("TileLoaderLoadingOverlay");
        Canvas canvas = root.AddComponent<Canvas>();
        canvas.renderMode = RenderMode.ScreenSpaceOverlay;
        canvas.sortingOrder = short.MaxValue;
        root.AddComponent<CanvasScaler>();
        root.AddComponent<GraphicRaycaster>();
        canvasGroup = root.AddComponent<CanvasGroup>();
        root.SetActive(false);

        var spinnerRoot = new GameObject("LoadingCircle", typeof(RectTransform), typeof(Image));
        spinnerRoot.transform.SetParent(root.transform, false);
        spinnerRect = spinnerRoot.GetComponent<RectTransform>();
        spinnerRect.anchorMin = new Vector2(0.5f, 0.5f);
        spinnerRect.anchorMax = new Vector2(0.5f, 0.5f);
        spinnerRect.pivot = new Vector2(0.5f, 0.5f);
        spinnerRect.sizeDelta = new Vector2(72f, 72f);
        spinnerRect.anchoredPosition = Vector2.zero;

        Image spinnerImage = spinnerRoot.GetComponent<Image>();
        spinnerImage.sprite = GetSpinnerSprite();
        spinnerImage.type = Image.Type.Filled;
        spinnerImage.fillMethod = Image.FillMethod.Radial360;
        spinnerImage.fillClockwise = true;
        spinnerImage.fillOrigin = 2;
        spinnerImage.fillAmount = 0.8f;
        spinnerImage.color = new Color(1f, 1f, 1f, 0.92f);
        spinnerImage.preserveAspect = true;
    }

    private Sprite GetSpinnerSprite()
    {
        if (spinnerSprite != null)
        {
            return spinnerSprite;
        }

        spinnerSprite = Sprite.Create(
            Texture2D.whiteTexture,
            new Rect(0f, 0f, Texture2D.whiteTexture.width, Texture2D.whiteTexture.height),
            new Vector2(0.5f, 0.5f));
        return spinnerSprite;
    }
}

internal static class TileLoaderTileGateMath
{
    public static bool TryResolveClampedLocalPosition(
        Vector3 targetLocalPosition,
        Vector2Int settledTileCoordinate,
        Vector2Int blockedTileCoordinate,
        float terrainWidth,
        float terrainLength,
        float boundaryInsetMeters,
        out Vector3 clampedLocalPosition)
    {
        clampedLocalPosition = targetLocalPosition;

        int deltaX = blockedTileCoordinate.x - settledTileCoordinate.x;
        int deltaY = blockedTileCoordinate.y - settledTileCoordinate.y;
        if (Mathf.Abs(deltaX) > 1 || Mathf.Abs(deltaY) > 1 || (deltaX == 0 && deltaY == 0))
        {
            return false;
        }

        bool clamped = false;
        if (deltaX > 0)
        {
            clampedLocalPosition.x = Mathf.Min(
                clampedLocalPosition.x,
                blockedTileCoordinate.x * terrainWidth - boundaryInsetMeters);
            clamped = true;
        }
        else if (deltaX < 0)
        {
            clampedLocalPosition.x = Mathf.Max(
                clampedLocalPosition.x,
                (blockedTileCoordinate.x + 1) * terrainWidth + boundaryInsetMeters);
            clamped = true;
        }

        if (deltaY > 0)
        {
            clampedLocalPosition.z = Mathf.Min(
                clampedLocalPosition.z,
                blockedTileCoordinate.y * terrainLength - boundaryInsetMeters);
            clamped = true;
        }
        else if (deltaY < 0)
        {
            clampedLocalPosition.z = Mathf.Max(
                clampedLocalPosition.z,
                (blockedTileCoordinate.y + 1) * terrainLength + boundaryInsetMeters);
            clamped = true;
        }

        return clamped;
    }
}

internal sealed class TileLoaderTileGateController
{
    private const float TileGateBoundaryInsetMeters = 0.1f;
    private const float LoadingSpinnerDegreesPerSecond = 240f;

    private readonly TileLoader owner;
    private readonly TileLoaderLoadingOverlay loadingOverlay = new();
    private Vector2Int? lastSettledTileCoordinate;
    private Vector2Int? blockedTileCoordinate;
    private Vector3 lastSettledWorldPosition;
    private bool hasLastSettledWorldPosition;

    public TileLoaderTileGateController(TileLoader owner)
    {
        this.owner = owner;
    }

    public bool IsBlocking { get; private set; }

    public Vector3Int? BlockedDynamicUnityTileCoordinate
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

    public void Reset(bool destroyOverlay)
    {
        lastSettledTileCoordinate = null;
        blockedTileCoordinate = null;
        lastSettledWorldPosition = default;
        hasLastSettledWorldPosition = false;
        IsBlocking = false;
        loadingOverlay.Reset(destroyOverlay);
    }

    public void Update(DynamicTileScheduler dynamicTileScheduler)
    {
        if (!owner.DynamicTileLoadingEnabled)
        {
            loadingOverlay.Hide();
            return;
        }

        Transform? target = dynamicTileScheduler.GetDynamicLoadTarget(owner);
        if (target == null ||
            !owner.TryGetUnityTileCoordinateForWorldPositionInternal(target.position, out Vector3Int currentTileCoordinate))
        {
            loadingOverlay.Hide();
            return;
        }

        var currentTile = new Vector2Int(currentTileCoordinate.x, currentTileCoordinate.y);
        SeedLastSettledTile(target.position);

        if (blockedTileCoordinate.HasValue)
        {
            Vector2Int blockedTile = blockedTileCoordinate.Value;
            if (IsTileGateReleasedForTile(blockedTile))
            {
                ReleaseBlockedTile();
                return;
            }

            if (!lastSettledTileCoordinate.HasValue)
            {
                ClearBlockedTile();
                return;
            }

            ApplyBlockedTilePosition(target, blockedTile);
            return;
        }

        if (IsTileGateReleasedForTile(currentTile))
        {
            lastSettledTileCoordinate = currentTile;
            lastSettledWorldPosition = target.position;
            hasLastSettledWorldPosition = true;
            ReleaseBlockedTile();
            return;
        }

        if (lastSettledTileCoordinate.HasValue && lastSettledTileCoordinate.Value == currentTile)
        {
            lastSettledWorldPosition = target.position;
            hasLastSettledWorldPosition = true;
            ReleaseBlockedTile();
            return;
        }

        if (!lastSettledTileCoordinate.HasValue)
        {
            ClearBlockedTile();
            return;
        }

        blockedTileCoordinate = currentTile;
        ApplyBlockedTilePosition(target, currentTile);
    }

    private void SeedLastSettledTile(Vector3 targetWorldPosition)
    {
        if (lastSettledTileCoordinate.HasValue)
        {
            return;
        }

        if (owner.LastCompletedRuntimeNeighborhoodCenterTileCoordinateInternal.HasValue)
        {
            Vector3Int completedCenterCoordinate = owner.LastCompletedRuntimeNeighborhoodCenterTileCoordinateInternal.Value;
            lastSettledTileCoordinate = new Vector2Int(completedCenterCoordinate.x, completedCenterCoordinate.y);
            lastSettledWorldPosition = targetWorldPosition;
            hasLastSettledWorldPosition = true;
            return;
        }

        if (!owner.ActiveLoadedUnityTileCoordinate.HasValue)
        {
            return;
        }

        Vector3Int activeLoadedTileCoordinate = owner.ActiveLoadedUnityTileCoordinate.Value;
        var activeLoadedTile = new Vector2Int(activeLoadedTileCoordinate.x, activeLoadedTileCoordinate.y);
        if (owner.IsRuntimeVegetationTileSettledInternal(activeLoadedTile) &&
            !owner.IsTerrainPhaseLoadInProgress &&
            !owner.ActiveRuntimeRequestedTileCoordinateInternal.HasValue)
        {
            lastSettledTileCoordinate = activeLoadedTile;
            lastSettledWorldPosition = targetWorldPosition;
            hasLastSettledWorldPosition = true;
        }
    }

    private void ApplyBlockedTilePosition(Transform target, Vector2Int blockedTile)
    {
        if (!lastSettledTileCoordinate.HasValue)
        {
            ClearBlockedTile();
            return;
        }

        Vector3 blockedWorldPosition = ResolveGatedWorldPosition(
            target.position,
            lastSettledTileCoordinate.Value,
            blockedTile);
        ApplyTargetPosition(target, blockedWorldPosition);
        IsBlocking = true;
        loadingOverlay.Show(-LoadingSpinnerDegreesPerSecond * Time.unscaledDeltaTime);
    }

    private Vector3 ResolveGatedWorldPosition(
        Vector3 targetWorldPosition,
        Vector2Int settledTileCoordinate,
        Vector2Int blockedTileCoordinate)
    {
        if (!hasLastSettledWorldPosition)
        {
            return targetWorldPosition;
        }

        Vector3 targetLocalPosition = owner.transform.InverseTransformPoint(targetWorldPosition);
        if (!TileLoaderTileGateMath.TryResolveClampedLocalPosition(
                targetLocalPosition,
                settledTileCoordinate,
                blockedTileCoordinate,
                owner.TerrainWidthInternal,
                owner.TerrainLengthInternal,
                TileGateBoundaryInsetMeters,
                out Vector3 gatedLocalPosition))
        {
            return lastSettledWorldPosition;
        }

        return owner.transform.TransformPoint(gatedLocalPosition);
    }

    private static void ApplyTargetPosition(Transform target, Vector3 gatedWorldPosition)
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

    private void ReleaseBlockedTile()
    {
        blockedTileCoordinate = null;
        IsBlocking = false;
        loadingOverlay.Hide();
    }

    private void ClearBlockedTile()
    {
        blockedTileCoordinate = null;
        IsBlocking = false;
        loadingOverlay.Hide();
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
}

}
