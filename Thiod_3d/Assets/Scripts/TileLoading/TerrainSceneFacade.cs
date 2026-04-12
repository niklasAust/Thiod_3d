using System;
using System.Collections.Generic;
using System.Globalization;
using Pinwheel.Griffin;
using UnityEngine;

#nullable enable

internal sealed class TerrainSceneFacade
{
    private readonly struct RetiredTerrainContainer
    {
        public RetiredTerrainContainer(Transform root, float destroyAtTime)
        {
            Root = root;
            DestroyAtTime = destroyAtTime;
        }

        public Transform Root { get; }
        public float DestroyAtTime { get; }
    }

    private readonly TileLoader owner;
    private readonly Dictionary<Vector2Int, GeneratedTerrainTileData> activeTerrainTileCache = new();
    private readonly List<RetiredTerrainContainer> retiredTerrainContainers = new();
    private Transform? activeGeneratedTerrainRoot;
    private string? activeTerrainTileCacheSignature;

    public TerrainSceneFacade(TileLoader owner)
    {
        this.owner = owner;
    }

    public Transform? ActiveGeneratedTerrainRoot
    {
        get => activeGeneratedTerrainRoot;
        set => activeGeneratedTerrainRoot = value;
    }

    public string? ActiveTerrainTileCacheSignature
    {
        get => activeTerrainTileCacheSignature;
        set => activeTerrainTileCacheSignature = value;
    }

    public Dictionary<Vector2Int, GeneratedTerrainTileData> ActiveTerrainTileCache => activeTerrainTileCache;

    public void ClearGeneratedTerrains()
    {
        activeTerrainTileCache.Clear();
        activeTerrainTileCacheSignature = null;
        DestroyRetiredTerrainContainersImmediately();
        DestroyAllGeneratedTerrainContainers(exceptRoot: null);
        activeGeneratedTerrainRoot = null;
    }

    public Transform CreateGeneratedTerrainBatchRoot(int pipelineId, Vector3Int centerTileCoordinate)
    {
        var rootObject = new GameObject($"{owner.GeneratedTerrainBatchRootNamePrefixInternal}_{pipelineId}");
        rootObject.transform.SetParent(owner.transform, false);
        rootObject.transform.localPosition = GetGeneratedTerrainBatchRootLocalPosition(centerTileCoordinate);
        rootObject.transform.localRotation = Quaternion.identity;
        rootObject.transform.localScale = Vector3.one;
        return rootObject.transform;
    }

    public Vector3 GetGeneratedTerrainBatchRootLocalPosition(Vector3Int centerTileCoordinate)
    {
        if (!Application.isPlaying || !owner.DynamicTileLoadingEnabled)
        {
            return Vector3.zero;
        }

        return new Vector3(
            centerTileCoordinate.x * owner.TerrainWidthInternal,
            0f,
            centerTileCoordinate.y * owner.TerrainLengthInternal);
    }

    public bool TryReuseActiveTerrainBatchRoot(GeneratedTerrainBatchState batchState)
    {
        if (!owner.ReuseOverlappingDynamicNeighborhoodTilesInternal ||
            activeGeneratedTerrainRoot == null ||
            !owner.ActiveLoadedUnityTileCoordinate.HasValue ||
            !string.Equals(activeTerrainTileCacheSignature, batchState.CacheSignature, StringComparison.Ordinal))
        {
            return false;
        }

        Dictionary<Vector2Int, GStylizedTerrain> existingTerrains = GetGeneratedTerrainsByTileCoordinate(
            activeGeneratedTerrainRoot,
            owner.ActiveLoadedUnityTileCoordinate.Value);
        if (existingTerrains.Count == 0)
        {
            return false;
        }

        var desiredCoordinates = new HashSet<Vector2Int>();
        var reusableTerrains = new Dictionary<Vector2Int, GStylizedTerrain>();
        for (int i = 0; i < batchState.Requests.Count; i++)
        {
            GeneratedTerrainRequest request = batchState.Requests[i];
            Vector2Int tileCoordinate = owner.GetTileCoordinateInternal(request);
            desiredCoordinates.Add(tileCoordinate);
            if (existingTerrains.TryGetValue(tileCoordinate, out GStylizedTerrain existingTerrain) &&
                existingTerrain != null)
            {
                reusableTerrains[tileCoordinate] = existingTerrain;
            }
        }

        if (reusableTerrains.Count == 0)
        {
            return false;
        }

        Transform batchRoot = activeGeneratedTerrainRoot;
        batchRoot.name = $"{owner.GeneratedTerrainBatchRootNamePrefixInternal}_{batchState.PipelineId}";
        batchRoot.localPosition = batchState.BatchRootLocalPosition;
        batchRoot.localRotation = Quaternion.identity;
        batchRoot.localScale = Vector3.one;
        batchState.BatchRoot = batchRoot;
        HashSet<Vector2Int> protectedCoordinates = owner.GetProtectedRuntimeTileCoordinatesInternal(batchState.CenterTileCoordinate);
        owner.LogBatchCenterDriftIfNeededInternal("terrain root reuse", batchState);

        foreach (KeyValuePair<Vector2Int, GStylizedTerrain> pair in existingTerrains)
        {
            if (desiredCoordinates.Contains(pair.Key))
            {
                continue;
            }

            if (protectedCoordinates.Contains(pair.Key))
            {
                pair.Value.transform.SetParent(batchRoot, false);
                pair.Value.transform.localPosition = owner.GetTerrainLocalPositionRelativeToBatchCenterInternal(pair.Key, batchState.CenterTileCoordinate);
                pair.Value.transform.localRotation = Quaternion.identity;
                pair.Value.transform.localScale = Vector3.one;
                continue;
            }

            batchState.RemovedTerrainCount++;
            DestroyGeneratedTerrainContainer(pair.Value.transform);
        }

        for (int i = 0; i < batchState.Requests.Count; i++)
        {
            GeneratedTerrainRequest request = batchState.Requests[i];
            Vector2Int tileCoordinate = owner.GetTileCoordinateInternal(request);
            if (!reusableTerrains.TryGetValue(tileCoordinate, out GStylizedTerrain terrain) || terrain == null)
            {
                continue;
            }

            terrain.name = request.TerrainObjectName;
            terrain.transform.SetParent(batchRoot, false);
            terrain.transform.localPosition = owner.GetTerrainLocalPositionRelativeToBatchCenterInternal(tileCoordinate, batchState.CenterTileCoordinate);
            terrain.transform.localRotation = Quaternion.identity;
            terrain.transform.localScale = Vector3.one;
            batchState.TerrainByCoordinate[tileCoordinate] = terrain;
            batchState.ReusedTerrainCount++;
            owner.ValidateReusedTerrainPlacementInternal(batchState, terrain, tileCoordinate, "terrain root reuse");
        }

        return batchState.ReusedTerrainCount > 0;
    }

    public void PromoteGeneratedTerrainBatch(GeneratedTerrainBatchState batchState)
    {
        if (batchState.BatchRoot == null)
        {
            return;
        }

        owner.LogBatchCenterDriftIfNeededInternal("terrain batch promotion", batchState);
        var previousTileCache = new Dictionary<Vector2Int, GeneratedTerrainTileData>(activeTerrainTileCache);
        string? previousTileCacheSignature = activeTerrainTileCacheSignature;
        activeGeneratedTerrainRoot = batchState.BatchRoot;
        owner.SetActiveLoadedUnityTileCoordinateInternal(batchState.CenterTileCoordinate);
        activeTerrainTileCache.Clear();
        for (int i = 0; i < batchState.OrderedTileCoordinates.Count; i++)
        {
            Vector2Int tileCoordinate = batchState.OrderedTileCoordinates[i];
            if (!batchState.RequestsByCoordinate.TryGetValue(tileCoordinate, out GeneratedTerrainRequest request))
            {
                continue;
            }

            activeTerrainTileCache[tileCoordinate] = new GeneratedTerrainTileData(
                request.Layers,
                request.UnityTileX,
                request.UnityTileY,
                request.LocalMinHeight,
                request.LocalMaxHeight,
                request.TileHilliness);
        }

        Dictionary<Vector2Int, GStylizedTerrain> retainedTerrains = GetGeneratedTerrainsByTileCoordinate(
            batchState.BatchRoot,
            batchState.CenterTileCoordinate);
        foreach (KeyValuePair<Vector2Int, GStylizedTerrain> pair in retainedTerrains)
        {
            if (activeTerrainTileCache.ContainsKey(pair.Key) ||
                !previousTileCache.TryGetValue(pair.Key, out GeneratedTerrainTileData tileData))
            {
                continue;
            }

            activeTerrainTileCache[pair.Key] = tileData;
        }

        activeTerrainTileCacheSignature = batchState.CacheSignature;
        owner.SyncRuntimeVegetationTileStatusesInternal(
            activeTerrainTileCache.Keys,
            preserveExistingStatuses: string.Equals(previousTileCacheSignature, batchState.CacheSignature, StringComparison.Ordinal));
        owner.PrunePlayerCentricSurfaceTileCachesInternal(activeTerrainTileCache.Keys);
        owner.ValidateBatchTerrainOrderingInternal(batchState, "terrain batch promotion");
        RetireGeneratedTerrainContainers(exceptRoot: batchState.BatchRoot);
    }

    public void CleanupRetiredTerrainContainers()
    {
        if (retiredTerrainContainers.Count == 0)
        {
            return;
        }

        float now = Time.unscaledTime;
        for (int i = retiredTerrainContainers.Count - 1; i >= 0; i--)
        {
            RetiredTerrainContainer entry = retiredTerrainContainers[i];
            if (entry.Root == null)
            {
                retiredTerrainContainers.RemoveAt(i);
                continue;
            }

            if (now < entry.DestroyAtTime)
            {
                continue;
            }

            DestroyGeneratedTerrainContainer(entry.Root);
            retiredTerrainContainers.RemoveAt(i);
        }
    }

    public void DestroyGeneratedTerrainContainer(Transform? container)
    {
        if (container == null)
        {
            return;
        }

        owner.RemovePlayerCentricSurfaceCachesOwnedByContainerInternal(container);

        if (Application.isPlaying)
        {
            UnityEngine.Object.Destroy(container.gameObject);
        }
        else
        {
            UnityEngine.Object.DestroyImmediate(container.gameObject);
        }
    }

    public void CleanupAbortedRuntimeBatch(GeneratedTerrainBatchState batchState)
    {
        if (batchState.BatchRoot != null && batchState.BatchRoot != activeGeneratedTerrainRoot)
        {
            DestroyGeneratedTerrainContainer(batchState.BatchRoot);
            batchState.BatchRoot = null;
        }
    }

    public bool IsGeneratedTerrainName(string candidateName)
    {
        return candidateName == owner.GeneratedTerrainNameInternal ||
               candidateName.StartsWith(owner.GeneratedTerrainNameInternal + "_", StringComparison.Ordinal);
    }

    public Dictionary<Vector2Int, GStylizedTerrain> GetGeneratedTerrainsByTileCoordinate(
        Transform batchRoot,
        Vector3Int centerTileCoordinate)
    {
        var terrainsByTileCoordinate = new Dictionary<Vector2Int, GStylizedTerrain>();
        foreach (GStylizedTerrain terrain in batchRoot.GetComponentsInChildren<GStylizedTerrain>(true))
        {
            if (terrain == null || !IsGeneratedTerrainName(terrain.name))
            {
                continue;
            }

            Vector2Int tileCoordinate = ResolveTerrainTileCoordinate(terrain, centerTileCoordinate);
            terrainsByTileCoordinate[tileCoordinate] = terrain;
        }

        return terrainsByTileCoordinate;
    }

    public Vector2Int GetTileCoordinate(GStylizedTerrain terrain, Vector3Int centerTileCoordinate)
    {
        float safeTerrainWidth = Mathf.Max(0.0001f, owner.TerrainWidthInternal);
        float safeTerrainLength = Mathf.Max(0.0001f, owner.TerrainLengthInternal);
        Vector3 localPosition = terrain.transform.localPosition;
        int offsetX = Mathf.RoundToInt(localPosition.x / safeTerrainWidth);
        int offsetY = Mathf.RoundToInt(localPosition.z / safeTerrainLength);
        return new Vector2Int(centerTileCoordinate.x + offsetX, centerTileCoordinate.y + offsetY);
    }

    public Vector2Int ResolveTerrainTileCoordinate(GStylizedTerrain terrain, Vector3Int centerTileCoordinate)
    {
        if (terrain != null && TryGetTileCoordinateFromTerrainName(terrain.name, out Vector2Int tileCoordinateFromName))
        {
            return tileCoordinateFromName;
        }

        return GetTileCoordinate(terrain!, centerTileCoordinate);
    }

    public bool TryGetTileCoordinateFromTerrainName(string terrainName, out Vector2Int tileCoordinate)
    {
        tileCoordinate = default;
        if (string.IsNullOrWhiteSpace(terrainName))
        {
            return false;
        }

        string prefix = owner.GeneratedTerrainNameInternal + "_";
        if (!terrainName.StartsWith(prefix, StringComparison.Ordinal))
        {
            return false;
        }

        string coordinateSuffix = terrainName.Substring(prefix.Length);
        string[] parts = coordinateSuffix.Split('_');
        if (parts.Length != 2 ||
            !int.TryParse(parts[0], NumberStyles.Integer, CultureInfo.InvariantCulture, out int tileX) ||
            !int.TryParse(parts[1], NumberStyles.Integer, CultureInfo.InvariantCulture, out int tileY))
        {
            return false;
        }

        tileCoordinate = new Vector2Int(tileX, tileY);
        return true;
    }

    private void DestroyAllGeneratedTerrainContainers(Transform? exceptRoot)
    {
        var containersToRemove = new HashSet<Transform>();
        foreach (GStylizedTerrain terrain in owner.GetComponentsInChildren<GStylizedTerrain>(true))
        {
            if (terrain == null || !IsGeneratedTerrainName(terrain.name))
            {
                continue;
            }

            Transform? topLevelContainer = GetTopLevelGeneratedTerrainContainer(terrain.transform);
            if (topLevelContainer == null || topLevelContainer == exceptRoot)
            {
                continue;
            }

            containersToRemove.Add(topLevelContainer);
        }

        foreach (Transform container in containersToRemove)
        {
            DestroyGeneratedTerrainContainer(container);
        }
    }

    private void RetireGeneratedTerrainContainers(Transform? exceptRoot)
    {
        var containersToRetire = new HashSet<Transform>();
        foreach (GStylizedTerrain terrain in owner.GetComponentsInChildren<GStylizedTerrain>(true))
        {
            if (terrain == null || !IsGeneratedTerrainName(terrain.name))
            {
                continue;
            }

            Transform? topLevelContainer = GetTopLevelGeneratedTerrainContainer(terrain.transform);
            if (topLevelContainer == null || topLevelContainer == exceptRoot)
            {
                continue;
            }

            containersToRetire.Add(topLevelContainer);
        }

        foreach (Transform container in containersToRetire)
        {
            RetireGeneratedTerrainContainer(container);
        }
    }

    private Transform? GetTopLevelGeneratedTerrainContainer(Transform terrainTransform)
    {
        if (terrainTransform == null)
        {
            return null;
        }

        Transform current = terrainTransform;
        while (current.parent != null && current.parent != owner.transform)
        {
            current = current.parent;
        }

        return current.parent == owner.transform ? current : null;
    }

    private void RetireGeneratedTerrainContainer(Transform? container)
    {
        if (container == null)
        {
            return;
        }

        owner.RemovePlayerCentricSurfaceCachesOwnedByContainerInternal(container);
        DisableTerrainContainerVisuals(container);
        retiredTerrainContainers.RemoveAll(entry => entry.Root == null || entry.Root == container);
        retiredTerrainContainers.Add(new RetiredTerrainContainer(
            container,
            Time.unscaledTime + Mathf.Max(0f, owner.RetiredTerrainColliderGraceSecondsInternal)));
    }

    private void DestroyRetiredTerrainContainersImmediately()
    {
        for (int i = retiredTerrainContainers.Count - 1; i >= 0; i--)
        {
            if (retiredTerrainContainers[i].Root != null)
            {
                DestroyGeneratedTerrainContainer(retiredTerrainContainers[i].Root);
            }
        }

        retiredTerrainContainers.Clear();
    }

    private static void DisableTerrainContainerVisuals(Transform container)
    {
        foreach (Renderer renderer in container.GetComponentsInChildren<Renderer>(true))
        {
            if (renderer != null)
            {
                renderer.enabled = false;
            }
        }

        foreach (UnityEngine.Terrain terrain in container.GetComponentsInChildren<UnityEngine.Terrain>(true))
        {
            if (terrain != null)
            {
                terrain.drawHeightmap = false;
                terrain.drawTreesAndFoliage = false;
            }
        }
    }
}
