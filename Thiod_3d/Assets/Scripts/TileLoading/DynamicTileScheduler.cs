using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

#nullable enable

internal sealed class DynamicTileScheduler
{
    private Transform? cachedDynamicLoadTarget;
    private float nextDynamicLoadCheckTime;
    private bool dynamicLoadDispatchQueued;
    private Vector3Int? queuedDynamicUnityTileCoordinate;
    private readonly HashSet<Vector3Int> queuedDynamicUnityTileCoordinates = new();
    private Vector3 lastDynamicLoadTargetLocalPosition;
    private bool hasDynamicLoadTargetLocalPosition;

    public void Reset()
    {
        cachedDynamicLoadTarget = null;
        nextDynamicLoadCheckTime = 0f;
        dynamicLoadDispatchQueued = false;
        queuedDynamicUnityTileCoordinate = null;
        queuedDynamicUnityTileCoordinates.Clear();
        lastDynamicLoadTargetLocalPosition = default;
        hasDynamicLoadTargetLocalPosition = false;
    }

    public bool Refresh(TileLoader owner)
    {
        if (!Application.isPlaying || !owner.DynamicTileLoadingEnabled)
        {
            return false;
        }

        if (Time.unscaledTime < nextDynamicLoadCheckTime)
        {
            return false;
        }

        nextDynamicLoadCheckTime = Time.unscaledTime + Mathf.Max(0.01f, owner.DynamicLoadCheckIntervalSeconds);
        if (!TryGetDynamicLoadTargetTileCoordinate(owner, out Vector3Int runtimeTileCoordinate))
        {
            return false;
        }

        owner.UnityTileCoordinate = runtimeTileCoordinate;
        if (owner.IsTerrainPhaseLoadInProgress)
        {
            EnqueueDynamicTileLoadRequest(owner, runtimeTileCoordinate);
            owner.InvalidateActiveRuntimeTerrainLoadIfStale(runtimeTileCoordinate);
            return false;
        }

        if (owner.ActiveLoadedUnityTileCoordinate.HasValue &&
            owner.ActiveLoadedUnityTileCoordinate.Value == runtimeTileCoordinate &&
            owner.HasGeneratedTerrainsInternal())
        {
            return false;
        }

        RequestLoad(owner, runtimeTileCoordinate);
        return true;
    }

    public void RequestLoad(TileLoader owner, Vector3Int tileCoordinate, bool forceImmediate = false)
    {
        owner.UnityTileCoordinate = tileCoordinate;
        EnqueueDynamicTileLoadRequest(owner, tileCoordinate);

        if (!forceImmediate &&
            owner.ActiveLoadedUnityTileCoordinate.HasValue &&
            owner.ActiveLoadedUnityTileCoordinate.Value == tileCoordinate &&
            owner.HasGeneratedTerrainsInternal())
        {
            queuedDynamicUnityTileCoordinates.Remove(tileCoordinate);
            if (queuedDynamicUnityTileCoordinate == tileCoordinate)
            {
                queuedDynamicUnityTileCoordinate = null;
            }

            return;
        }

        if (owner.IsTerrainPhaseLoadInProgress)
        {
            owner.InvalidateActiveRuntimeTerrainLoadIfStale(tileCoordinate);
            return;
        }

        queuedDynamicUnityTileCoordinates.Remove(tileCoordinate);
        if (queuedDynamicUnityTileCoordinate == tileCoordinate)
        {
            queuedDynamicUnityTileCoordinate = null;
        }

        owner.LoadTileIntoScene();
    }

    public void TryDispatchQueuedLoad(TileLoader owner)
    {
        if (!Application.isPlaying || !owner.DynamicTileLoadingEnabled || owner.IsTerrainPhaseLoadInProgress)
        {
            return;
        }

        if (queuedDynamicUnityTileCoordinates.Count == 0 && !queuedDynamicUnityTileCoordinate.HasValue)
        {
            return;
        }

        if (!TryResolveBestQueuedDynamicTileCoordinate(owner, out Vector3Int requestedTileCoordinate))
        {
            queuedDynamicUnityTileCoordinate = null;
            return;
        }

        if (owner.ActiveLoadedUnityTileCoordinate.HasValue &&
            owner.ActiveLoadedUnityTileCoordinate.Value == requestedTileCoordinate &&
            owner.HasGeneratedTerrainsInternal())
        {
            queuedDynamicUnityTileCoordinates.Remove(requestedTileCoordinate);
            if (queuedDynamicUnityTileCoordinate == requestedTileCoordinate)
            {
                queuedDynamicUnityTileCoordinate = null;
            }

            return;
        }

        if (dynamicLoadDispatchQueued)
        {
            return;
        }

        dynamicLoadDispatchQueued = true;
        owner.StartRuntimeCoroutine(DispatchQueuedLoadNextFrame(owner));
    }

    public bool TryGetCurrentPlayerTileCoordinate(TileLoader owner, out Vector3Int tileCoordinate)
    {
        Transform? target = ResolveDynamicLoadTarget(owner);
        if (target != null &&
            owner.TryGetUnityTileCoordinateForWorldPositionInternal(target.position, out tileCoordinate))
        {
            tileCoordinate = new Vector3Int(tileCoordinate.x, tileCoordinate.y, owner.UnityTileCoordinate.z);
            return true;
        }

        tileCoordinate = owner.ActiveLoadedUnityTileCoordinate ?? owner.UnityTileCoordinate;
        return false;
    }

    public Vector3Int ResolveCurrentDesiredDynamicNeighborhoodCenter(TileLoader owner, Vector3Int fallbackTileCoordinate)
    {
        if (queuedDynamicUnityTileCoordinate.HasValue)
        {
            return queuedDynamicUnityTileCoordinate.Value;
        }

        if (owner.DynamicTileLoadingEnabled)
        {
            return owner.UnityTileCoordinate;
        }

        return owner.ActiveRuntimeRequestedTileCoordinate ??
               owner.ActiveLoadedUnityTileCoordinate ??
               fallbackTileCoordinate;
    }

    public int GetDynamicLoadNeighborhoodRadiusInTiles(TileLoader owner)
    {
        return owner.UsesBatchNeighborhoodLoadingInternal() ? 1 : 0;
    }

    public bool IsTileCoordinateWithinDynamicNeighborhood(TileLoader owner, Vector3Int tileCoordinate, Vector3Int centerTileCoordinate)
    {
        int radius = GetDynamicLoadNeighborhoodRadiusInTiles(owner);
        return Math.Abs(tileCoordinate.x - centerTileCoordinate.x) <= radius &&
               Math.Abs(tileCoordinate.y - centerTileCoordinate.y) <= radius;
    }

    private IEnumerator DispatchQueuedLoadNextFrame(TileLoader owner)
    {
        yield return null;
        dynamicLoadDispatchQueued = false;
        if (owner == null || !Application.isPlaying || owner.IsTerrainPhaseLoadInProgress)
        {
            yield break;
        }

        if (!TryResolveBestQueuedDynamicTileCoordinate(owner, out Vector3Int requestedTileCoordinate))
        {
            yield break;
        }

        RequestLoad(owner, requestedTileCoordinate, forceImmediate: true);
    }

    private void EnqueueDynamicTileLoadRequest(TileLoader owner, Vector3Int tileCoordinate)
    {
        queuedDynamicUnityTileCoordinates.Add(tileCoordinate);
        queuedDynamicUnityTileCoordinate = tileCoordinate;
        PruneQueuedDynamicLoadRequests(owner, tileCoordinate);
    }

    private void PruneQueuedDynamicLoadRequests(TileLoader owner, Vector3Int preferredTileCoordinate)
    {
        Vector3Int desiredCenterTileCoordinate = ResolveCurrentDesiredDynamicNeighborhoodCenter(owner, preferredTileCoordinate);
        int discardedRequestCount = 0;
        foreach (Vector3Int candidate in new List<Vector3Int>(queuedDynamicUnityTileCoordinates))
        {
            if (IsTileCoordinateWithinDynamicNeighborhood(owner, candidate, desiredCenterTileCoordinate))
            {
                continue;
            }

            queuedDynamicUnityTileCoordinates.Remove(candidate);
            discardedRequestCount++;
        }

        if (queuedDynamicUnityTileCoordinate.HasValue &&
            !IsTileCoordinateWithinDynamicNeighborhood(owner, queuedDynamicUnityTileCoordinate.Value, desiredCenterTileCoordinate))
        {
            queuedDynamicUnityTileCoordinate = null;
        }

        if (discardedRequestCount > 0)
        {
            Debug.Log(
                $"TileLoader discarded {discardedRequestCount} stale queued dynamic tile request(s) outside the current neighborhood around {desiredCenterTileCoordinate}.",
                owner);
        }
    }

    private bool TryResolveBestQueuedDynamicTileCoordinate(TileLoader owner, out Vector3Int tileCoordinate)
    {
        Vector3Int preferredTileCoordinate = queuedDynamicUnityTileCoordinate ?? owner.UnityTileCoordinate;
        Vector3Int desiredCenterTileCoordinate = ResolveCurrentDesiredDynamicNeighborhoodCenter(owner, preferredTileCoordinate);
        PruneQueuedDynamicLoadRequests(owner, desiredCenterTileCoordinate);
        if (queuedDynamicUnityTileCoordinates.Count == 0)
        {
            tileCoordinate = desiredCenterTileCoordinate;
            return false;
        }

        TryGetCurrentPlayerTileCoordinate(owner, out Vector3Int playerTileCoordinate);
        bool found = false;
        Vector3Int bestCoordinate = desiredCenterTileCoordinate;
        foreach (Vector3Int candidate in queuedDynamicUnityTileCoordinates)
        {
            if (!found ||
                CompareQueuedDynamicTilePriority(candidate, bestCoordinate, playerTileCoordinate, preferredTileCoordinate) < 0)
            {
                bestCoordinate = candidate;
                found = true;
            }
        }

        tileCoordinate = bestCoordinate;
        queuedDynamicUnityTileCoordinate = bestCoordinate;
        return found;
    }

    private int CompareQueuedDynamicTilePriority(
        Vector3Int left,
        Vector3Int right,
        Vector3Int playerTileCoordinate,
        Vector3Int preferredTileCoordinate)
    {
        int leftPriority = ScoreQueuedDynamicTilePriority(left, playerTileCoordinate, preferredTileCoordinate);
        int rightPriority = ScoreQueuedDynamicTilePriority(right, playerTileCoordinate, preferredTileCoordinate);
        if (leftPriority != rightPriority)
        {
            return leftPriority.CompareTo(rightPriority);
        }

        int preferredDistanceComparison =
            GetDynamicTileDistance(left, preferredTileCoordinate).CompareTo(GetDynamicTileDistance(right, preferredTileCoordinate));
        if (preferredDistanceComparison != 0)
        {
            return preferredDistanceComparison;
        }

        return GetDynamicTileDistance(left, playerTileCoordinate).CompareTo(GetDynamicTileDistance(right, playerTileCoordinate));
    }

    private int ScoreQueuedDynamicTilePriority(
        Vector3Int candidate,
        Vector3Int playerTileCoordinate,
        Vector3Int preferredTileCoordinate)
    {
        if (candidate == playerTileCoordinate)
        {
            return 0;
        }

        Vector3Int preferredDelta = new(
            Math.Sign(preferredTileCoordinate.x - playerTileCoordinate.x),
            Math.Sign(preferredTileCoordinate.y - playerTileCoordinate.y),
            0);
        if (preferredDelta.x != 0 || preferredDelta.y != 0)
        {
            Vector3Int frontierCoordinate = new(
                playerTileCoordinate.x + preferredDelta.x,
                playerTileCoordinate.y + preferredDelta.y,
                playerTileCoordinate.z);
            if (candidate == frontierCoordinate)
            {
                return 1;
            }
        }

        int score = 10 + GetDynamicTileDistance(candidate, preferredTileCoordinate) * 2;
        score += GetDynamicTileDistance(candidate, playerTileCoordinate);
        if (preferredDelta.x != 0 || preferredDelta.y != 0)
        {
            int candidateDeltaX = candidate.x - playerTileCoordinate.x;
            int candidateDeltaY = candidate.y - playerTileCoordinate.y;
            if ((preferredDelta.x != 0 && Math.Sign(candidateDeltaX) == -preferredDelta.x) ||
                (preferredDelta.y != 0 && Math.Sign(candidateDeltaY) == -preferredDelta.y))
            {
                score += 20;
            }
        }

        return score;
    }

    private static int GetDynamicTileDistance(Vector3Int left, Vector3Int right)
    {
        return Math.Abs(left.x - right.x) + Math.Abs(left.y - right.y);
    }

    private bool TryGetDynamicLoadTargetTileCoordinate(TileLoader owner, out Vector3Int tileCoordinate)
    {
        tileCoordinate = owner.UnityTileCoordinate;
        Transform? target = ResolveDynamicLoadTarget(owner);
        if (target == null)
        {
            return false;
        }

        return TryGetDynamicLoadTileCoordinateForWorldPosition(owner, target.position, out tileCoordinate);
    }

    private bool TryGetDynamicLoadTileCoordinateForWorldPosition(TileLoader owner, Vector3 worldPosition, out Vector3Int tileCoordinate)
    {
        if (!owner.TryGetUnityTileCoordinateForWorldPositionInternal(worldPosition, out Vector3Int baseTileCoordinate))
        {
            tileCoordinate = owner.UnityTileCoordinate;
            return false;
        }

        tileCoordinate = baseTileCoordinate;
        if (!Application.isPlaying || !owner.DynamicTileLoadingEnabled)
        {
            return true;
        }

        float preloadFraction = Mathf.Clamp(owner.DynamicLoadPreloadFraction, 0f, 0.49f);
        if (preloadFraction <= 0f)
        {
            return true;
        }

        float safeTerrainWidth = Mathf.Max(0.01f, owner.TerrainWidthInternal);
        float safeTerrainLength = Mathf.Max(0.01f, owner.TerrainLengthInternal);
        Vector3 localPosition = owner.transform.InverseTransformPoint(worldPosition);
        float tileCoordinateX = localPosition.x / safeTerrainWidth;
        float tileCoordinateY = localPosition.z / safeTerrainLength;
        float deltaTileX = 0f;
        float deltaTileY = 0f;
        if (hasDynamicLoadTargetLocalPosition)
        {
            deltaTileX = (localPosition.x - lastDynamicLoadTargetLocalPosition.x) / safeTerrainWidth;
            deltaTileY = (localPosition.z - lastDynamicLoadTargetLocalPosition.z) / safeTerrainLength;
        }

        Vector3Int latchedTargetCoordinate = ResolveLatchedDynamicLoadCoordinate(owner, baseTileCoordinate);
        Vector3Int activeCenterCoordinate = owner.ActiveLoadedUnityTileCoordinate ?? latchedTargetCoordinate;
        tileCoordinate = new Vector3Int(
            ResolveDynamicLoadAxisCoordinate(
                baseTileCoordinate.x,
                latchedTargetCoordinate.x,
                activeCenterCoordinate.x,
                tileCoordinateX,
                deltaTileX,
                preloadFraction,
                owner.DynamicLoadHysteresisFraction),
            ResolveDynamicLoadAxisCoordinate(
                baseTileCoordinate.y,
                latchedTargetCoordinate.y,
                activeCenterCoordinate.y,
                tileCoordinateY,
                deltaTileY,
                preloadFraction,
                owner.DynamicLoadHysteresisFraction),
            owner.UnityTileCoordinate.z);

        lastDynamicLoadTargetLocalPosition = localPosition;
        hasDynamicLoadTargetLocalPosition = true;
        return true;
    }

    private Vector3Int ResolveLatchedDynamicLoadCoordinate(TileLoader owner, Vector3Int fallbackCoordinate)
    {
        if (queuedDynamicUnityTileCoordinate.HasValue)
        {
            return queuedDynamicUnityTileCoordinate.Value;
        }

        if (queuedDynamicUnityTileCoordinates.Count > 0 &&
            TryResolveBestQueuedDynamicTileCoordinate(owner, out Vector3Int queuedCoordinate))
        {
            return queuedCoordinate;
        }

        return owner.ActiveLoadedUnityTileCoordinate ?? fallbackCoordinate;
    }

    private static int ResolveDynamicLoadAxisCoordinate(
        int baseTileCoordinate,
        int latchedTargetCoordinate,
        int activeAxisCoordinate,
        float tileCoordinate,
        float deltaTile,
        float preloadFraction,
        float hysteresisFraction)
    {
        float tileProgress = tileCoordinate - Mathf.Floor(tileCoordinate);
        float hysteresis = Mathf.Clamp(hysteresisFraction, 0f, 0.2f);
        float advanceThreshold = Mathf.Clamp01(1f - preloadFraction + hysteresis);
        float retreatThreshold = Mathf.Clamp01(preloadFraction - hysteresis);
        int latchedDelta = latchedTargetCoordinate - baseTileCoordinate;
        int activeDelta = activeAxisCoordinate - baseTileCoordinate;

        if (activeDelta == 1 && tileProgress >= retreatThreshold)
        {
            return baseTileCoordinate + 1;
        }

        if (activeDelta == -1 && tileProgress <= 1f - retreatThreshold)
        {
            return baseTileCoordinate - 1;
        }

        if (latchedDelta == 1 && tileProgress > preloadFraction)
        {
            return tileProgress >= advanceThreshold ? baseTileCoordinate + 1 : baseTileCoordinate;
        }

        if (latchedDelta == -1 && tileProgress < 1f - preloadFraction)
        {
            return tileProgress <= 1f - advanceThreshold ? baseTileCoordinate - 1 : baseTileCoordinate;
        }

        const float movementEpsilon = 0.0005f;
        if (deltaTile >= movementEpsilon && tileProgress >= advanceThreshold)
        {
            return baseTileCoordinate + 1;
        }

        if (deltaTile <= -movementEpsilon && tileProgress <= 1f - advanceThreshold)
        {
            return baseTileCoordinate - 1;
        }

        return baseTileCoordinate;
    }

    private Transform? ResolveDynamicLoadTarget(TileLoader owner)
    {
        if (owner.DynamicLoadTargetOverride != null)
        {
            cachedDynamicLoadTarget = owner.DynamicLoadTargetOverride;
            return cachedDynamicLoadTarget;
        }

        if (cachedDynamicLoadTarget != null &&
            cachedDynamicLoadTarget.gameObject != null &&
            cachedDynamicLoadTarget.gameObject.scene.IsValid())
        {
            return cachedDynamicLoadTarget;
        }

        if (TileLoaderConiferOptimizer.TryFindSceneTransformWithComponent("UltimateCharacterLocomotion", out Transform? ultimateLocomotionTransform))
        {
            cachedDynamicLoadTarget = ultimateLocomotionTransform;
            return cachedDynamicLoadTarget;
        }

        if (TileLoaderConiferOptimizer.TryFindSceneTransformWithComponent("CharacterLocomotion", out Transform? locomotionTransform))
        {
            cachedDynamicLoadTarget = locomotionTransform;
            return cachedDynamicLoadTarget;
        }

        if (TileLoaderConiferOptimizer.TryFindSceneTransformWithTag("Player", out Transform? taggedPlayerTransform))
        {
            cachedDynamicLoadTarget = taggedPlayerTransform;
            return cachedDynamicLoadTarget;
        }

        if (Camera.main != null)
        {
            cachedDynamicLoadTarget = Camera.main.transform;
            return cachedDynamicLoadTarget;
        }

        cachedDynamicLoadTarget = null;
        return null;
    }
}
