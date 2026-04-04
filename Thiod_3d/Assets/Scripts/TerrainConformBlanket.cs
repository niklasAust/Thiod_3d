using System;
using System.Collections.Generic;
using UnityEngine;
using Pinwheel.Griffin;
#if UNITY_EDITOR
using UnityEditor;
#endif

[ExecuteAlways]
[DisallowMultipleComponent]
[AddComponentMenu("Environment/Terrain Conform Blanket")]
public sealed class TerrainConformBlanket : MonoBehaviour
{
    private const float AssumedRuntimeFrameDuration = 1f / 60f;
    private const int MaxRuntimeDistanceChecksPerFrame = 512;
    private const int MaxRuntimeConformsPerFrame = 2;
    private static readonly RaycastHit[] SharedRaycastHits = new RaycastHit[32];
    private static readonly List<TerrainConformBlanket> RuntimeBlankets = new();
    private static Transform cachedRuntimeTarget;
    private static GStylizedTerrain[] cachedPolarisTerrains = Array.Empty<GStylizedTerrain>();
    private static float nextRuntimeTargetRefreshTime;
    private static float nextPolarisTerrainRefreshTime;
    private static float minimumRuntimeCheckInterval = 0.25f;
    private static int runtimeBlanketCursor;
    private static RuntimeDriver runtimeDriver;
#if UNITY_EDITOR
    private static readonly List<TerrainConformBlanket> EditorBlankets = new();
    private const int MaxEditorConformsPerUpdate = 4;
    private static bool editorUpdateRegistered;
    private static int editorPendingConformCursor;
#endif

    [SerializeField] private LayerMask groundLayers = ~0;
    [SerializeField, Min(0.1f)] private float raycastStartHeight = 25f;
    [SerializeField, Min(0.1f)] private float raycastDistance = 80f;
    [SerializeField] private float surfaceOffset = 0f;
    [SerializeField, Min(0f)] private float buryDepth = 1f;
    [SerializeField, Range(0f, 1f)] private float samplePercentile = 1f;
    [SerializeField, Min(2)] private int sampleResolution = 16;
    [SerializeField, Min(0f)] private float footprintInset = 0f;
    [SerializeField, Range(0f, 1f)] private float bottomFollowHeight = 0.25f;
    [SerializeField, Range(0f, 1f)] private float topLockHeight = 0.65f;
    [SerializeField] private bool autoConformOnEnable = true;
    [SerializeField] private bool autoConformOnTransformChange = true;
    [SerializeField] private bool recalculateBounds = true;

    [Header("Runtime Optimization")]
    [SerializeField] private bool conformOnlyNearRuntimeTarget = true;
    [SerializeField] private Transform runtimeConformTarget;
    [SerializeField, Min(0.1f)] private float conformDistance = 40f;
    [SerializeField, Min(0.1f)] private float releaseDistance = 55f;
    [SerializeField, Min(0.05f)] private float runtimeDistanceCheckInterval = 0.25f;
    [SerializeField, Min(0.05f)] private float runtimeTargetRefreshInterval = 1f;

    [NonSerialized] private bool pendingConform;
    [NonSerialized] private bool hasConformedRuntimeMesh;
    [NonSerialized] private bool isWithinRuntimeConformRange;
    [NonSerialized] private Vector3 lastPosition;
    [NonSerialized] private Quaternion lastRotation;
    [NonSerialized] private Vector3 lastScale;
    [NonSerialized] private float nextRuntimeDistanceCheckTime;
    [NonSerialized] private GStylizedTerrain[] polarisTerrains = Array.Empty<GStylizedTerrain>();
    [NonSerialized] private readonly List<float> sampledHeights = new();
    [NonSerialized] private readonly List<MeshState> meshStates = new();

    private void OnEnable()
    {
        EnsureDefaultLayerMask();
        EnsureRuntimeOptimizationDefaults();
        RestoreSourceMeshes();
        CacheTransformState();
        nextRuntimeDistanceCheckTime = 0f;
        isWithinRuntimeConformRange = false;

        RegisterInstance(this);

        if (autoConformOnEnable && Application.isPlaying && !conformOnlyNearRuntimeTarget)
        {
            ScheduleConform();
        }
    }

    private void OnDisable()
    {
        UnregisterInstance(this);
        pendingConform = false;
        RestoreSourceMeshes();
    }

    private void OnValidate()
    {
        EnsureDefaultLayerMask();
        EnsureRuntimeOptimizationDefaults();
        buryDepth = Mathf.Max(0f, buryDepth);
        sampleResolution = Mathf.Max(2, sampleResolution);
        footprintInset = Mathf.Max(0f, footprintInset);
        samplePercentile = Mathf.Clamp01(samplePercentile);
        bottomFollowHeight = Mathf.Clamp01(bottomFollowHeight);
        topLockHeight = Mathf.Clamp(topLockHeight, bottomFollowHeight + 0.01f, 1f);
        ScheduleConform();
    }

    private void ProcessRuntimeUpdate(ref int remainingRuntimeConforms)
    {
        if (ShouldSkip())
        {
            return;
        }

        bool wasWithinRuntimeConformRange = isWithinRuntimeConformRange;
        if (!ShouldConformAtRuntime())
        {
            pendingConform = false;
            return;
        }

        if (!hasConformedRuntimeMesh && !wasWithinRuntimeConformRange && isWithinRuntimeConformRange)
        {
            pendingConform = true;
        }

        if (autoConformOnTransformChange && TransformChanged())
        {
            pendingConform = true;
        }

        if (!pendingConform)
        {
            return;
        }

        if (remainingRuntimeConforms <= 0)
        {
            return;
        }

        pendingConform = false;
        remainingRuntimeConforms--;
        ConformNow();
        CacheTransformState();
    }

    [ContextMenu("Conform To Terrain")]
    public void ConformNow()
    {
        if (ShouldSkip())
        {
            return;
        }

        if (!ShouldConformAtRuntime())
        {
            pendingConform = false;
            return;
        }

        RestoreSourceMeshes();
        if (!TryBuildFootprint(out var footprint))
        {
            return;
        }

        Physics.SyncTransforms();
        polarisTerrains = ResolvePolarisTerrains();

        if (!TryAnchorToFootprint(footprint))
        {
            return;
        }

        EnsureRuntimeMeshStates();
        DeformLowestVertices();
        hasConformedRuntimeMesh = true;
    }

    public void ConfigureForExternalOneShot(
        float configuredSurfaceOffset,
        float configuredBuryDepth,
        int configuredSampleResolution,
        float configuredBottomFollowHeight = 0.25f,
        float configuredTopLockHeight = 0.65f,
        bool configuredRecalculateBounds = false)
    {
        surfaceOffset = configuredSurfaceOffset;
        buryDepth = Mathf.Max(0f, configuredBuryDepth);
        sampleResolution = Mathf.Max(2, configuredSampleResolution);
        bottomFollowHeight = Mathf.Clamp01(configuredBottomFollowHeight);
        topLockHeight = Mathf.Clamp(configuredTopLockHeight, bottomFollowHeight + 0.01f, 1f);
        recalculateBounds = configuredRecalculateBounds;
        autoConformOnEnable = false;
        autoConformOnTransformChange = false;
        conformOnlyNearRuntimeTarget = false;
        pendingConform = false;
        EnsureDefaultLayerMask();
        EnsureRuntimeOptimizationDefaults();
    }

    public bool ConformOnceAndFreeze()
    {
        ConformNow();
        if (!hasConformedRuntimeMesh)
        {
            return false;
        }

        SuppressRuntimeProcessing();
        return true;
    }

    public void SuppressRuntimeProcessing()
    {
        pendingConform = false;
        autoConformOnEnable = false;
        autoConformOnTransformChange = false;
        UnregisterInstance(this);
    }

    [ContextMenu("Restore Source Meshes")]
    public void RestoreSourceMeshes()
    {
        var filters = GetComponentsInChildren<MeshFilter>(true);
        for (var i = 0; i < filters.Length; i++)
        {
            var filter = filters[i];
            if (filter == null)
            {
                continue;
            }

            var sourceMesh = ResolveSourceMesh(filter);
            if (sourceMesh == null)
            {
                continue;
            }

            if (filter.sharedMesh != null && filter.sharedMesh != sourceMesh)
            {
                ReleaseRuntimeMesh(filter.sharedMesh);
            }

            filter.sharedMesh = sourceMesh;
        }

        meshStates.Clear();
        hasConformedRuntimeMesh = false;
    }

    private void ScheduleConform()
    {
        if (ShouldSkip())
        {
            return;
        }

        if (!ShouldConformAtRuntime())
        {
            pendingConform = false;
            return;
        }

        pendingConform = true;
    }

    private bool TransformChanged()
    {
        return transform.position != lastPosition ||
               transform.rotation != lastRotation ||
               transform.lossyScale != lastScale;
    }

    private void CacheTransformState()
    {
        lastPosition = transform.position;
        lastRotation = transform.rotation;
        lastScale = transform.lossyScale;
    }

    private bool ShouldSkip()
    {
        if (!isActiveAndEnabled)
        {
            return true;
        }

#if UNITY_EDITOR
        if (!Application.isPlaying && PrefabUtility.IsPartOfPrefabAsset(gameObject))
        {
            return true;
        }
#endif

        return false;
    }

    [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
    private static void ResetRuntimeState()
    {
        RuntimeBlankets.Clear();
        cachedRuntimeTarget = null;
        cachedPolarisTerrains = Array.Empty<GStylizedTerrain>();
        nextRuntimeTargetRefreshTime = 0f;
        nextPolarisTerrainRefreshTime = 0f;
        minimumRuntimeCheckInterval = 0.25f;
        runtimeBlanketCursor = 0;
        runtimeDriver = null;
    }

    private static void RegisterInstance(TerrainConformBlanket blanket)
    {
        if (blanket == null)
        {
            return;
        }

        if (Application.isPlaying)
        {
            RegisterRuntimeBlanket(blanket);
            return;
        }

#if UNITY_EDITOR
        RegisterEditorBlanket(blanket);
#endif
    }

    private static void UnregisterInstance(TerrainConformBlanket blanket)
    {
        if (blanket == null)
        {
            return;
        }

        UnregisterRuntimeBlanket(blanket);

#if UNITY_EDITOR
        UnregisterEditorBlanket(blanket);
#endif
    }

    private static void RegisterRuntimeBlanket(TerrainConformBlanket blanket)
    {
        if (RuntimeBlankets.Contains(blanket))
        {
            return;
        }

        RuntimeBlankets.Add(blanket);
        minimumRuntimeCheckInterval = Mathf.Min(minimumRuntimeCheckInterval, blanket.runtimeDistanceCheckInterval);
        EnsureRuntimeDriver();
    }

    private static void UnregisterRuntimeBlanket(TerrainConformBlanket blanket)
    {
        int index = RuntimeBlankets.IndexOf(blanket);
        if (index < 0)
        {
            return;
        }

        RuntimeBlankets.RemoveAt(index);
        if (RuntimeBlankets.Count == 0)
        {
            runtimeBlanketCursor = 0;
            minimumRuntimeCheckInterval = 0.25f;
            return;
        }

        if (index < runtimeBlanketCursor)
        {
            runtimeBlanketCursor--;
        }

        runtimeBlanketCursor = Mathf.Clamp(runtimeBlanketCursor, 0, RuntimeBlankets.Count - 1);
        RecalculateMinimumRuntimeCheckInterval();
    }

    private static void EnsureRuntimeDriver()
    {
        if (runtimeDriver != null)
        {
            return;
        }

        GameObject driverObject = new("[TerrainConformBlanket Runtime]");
        driverObject.hideFlags = HideFlags.HideInHierarchy | HideFlags.DontSaveInEditor | HideFlags.DontSaveInBuild;
        UnityEngine.Object.DontDestroyOnLoad(driverObject);
        runtimeDriver = driverObject.AddComponent<RuntimeDriver>();
    }

    private static void ProcessRuntimeBlankets()
    {
        int count = RuntimeBlankets.Count;
        if (count == 0)
        {
            return;
        }

        int remainingRuntimeConforms = MaxRuntimeConformsPerFrame;
        int checksPerFrame = Mathf.Min(count, GetRuntimeChecksPerFrame(count));
        for (int processed = 0; processed < checksPerFrame && RuntimeBlankets.Count > 0; )
        {
            if (runtimeBlanketCursor >= RuntimeBlankets.Count)
            {
                runtimeBlanketCursor = 0;
            }

            TerrainConformBlanket blanket = RuntimeBlankets[runtimeBlanketCursor];
            runtimeBlanketCursor++;

            if (blanket == null || !blanket.isActiveAndEnabled)
            {
                UnregisterRuntimeBlanket(blanket);
                continue;
            }

            blanket.ProcessRuntimeUpdate(ref remainingRuntimeConforms);
            processed++;
        }
    }

    private static int GetRuntimeChecksPerFrame(int count)
    {
        float targetInterval = Mathf.Max(0.05f, minimumRuntimeCheckInterval);
        int checks = Mathf.CeilToInt(count * AssumedRuntimeFrameDuration / targetInterval);
        return Mathf.Clamp(checks, 32, Mathf.Min(count, MaxRuntimeDistanceChecksPerFrame));
    }

    private static void RecalculateMinimumRuntimeCheckInterval()
    {
        float minInterval = float.PositiveInfinity;
        for (int i = 0; i < RuntimeBlankets.Count; i++)
        {
            TerrainConformBlanket blanket = RuntimeBlankets[i];
            if (blanket == null)
            {
                continue;
            }

            minInterval = Mathf.Min(minInterval, blanket.runtimeDistanceCheckInterval);
        }

        minimumRuntimeCheckInterval = float.IsInfinity(minInterval)
            ? 0.25f
            : Mathf.Max(0.05f, minInterval);
    }

    private void EnsureRuntimeOptimizationDefaults()
    {
        conformDistance = Mathf.Max(0.1f, conformDistance);
        releaseDistance = Mathf.Max(conformDistance, releaseDistance);
        runtimeDistanceCheckInterval = Mathf.Max(0.05f, runtimeDistanceCheckInterval);
        runtimeTargetRefreshInterval = Mathf.Max(0.05f, runtimeTargetRefreshInterval);
    }

    private bool ShouldConformAtRuntime()
    {
        if (!Application.isPlaying || !conformOnlyNearRuntimeTarget)
        {
            return true;
        }

        if (Time.unscaledTime < nextRuntimeDistanceCheckTime)
        {
            return isWithinRuntimeConformRange;
        }

        nextRuntimeDistanceCheckTime = Time.unscaledTime + runtimeDistanceCheckInterval;

        Transform target = ResolveRuntimeConformTarget();
        if (target == null)
        {
            isWithinRuntimeConformRange = false;
            if (hasConformedRuntimeMesh)
            {
                RestoreSourceMeshes();
            }

            return false;
        }

        float sqrDistance = (transform.position - target.position).sqrMagnitude;
        float allowedDistanceSq = hasConformedRuntimeMesh
            ? releaseDistance * releaseDistance
            : conformDistance * conformDistance;
        isWithinRuntimeConformRange = sqrDistance <= allowedDistanceSq;

        if (!isWithinRuntimeConformRange && hasConformedRuntimeMesh)
        {
            RestoreSourceMeshes();
        }

        return isWithinRuntimeConformRange;
    }

    private Transform ResolveRuntimeConformTarget()
    {
        if (runtimeConformTarget != null && runtimeConformTarget.gameObject.scene.IsValid())
        {
            return runtimeConformTarget;
        }

        if (cachedRuntimeTarget != null &&
            cachedRuntimeTarget.gameObject.scene.IsValid() &&
            Time.unscaledTime < nextRuntimeTargetRefreshTime)
        {
            return cachedRuntimeTarget;
        }

        nextRuntimeTargetRefreshTime = Time.unscaledTime + runtimeTargetRefreshInterval;

        if (TryFindSceneTransformWithComponent("CharacterLocomotion", out Transform locomotionTransform))
        {
            cachedRuntimeTarget = locomotionTransform;
            return cachedRuntimeTarget;
        }

        if (TryFindSceneTransformWithTag("Player", out Transform taggedPlayer))
        {
            cachedRuntimeTarget = taggedPlayer;
            return cachedRuntimeTarget;
        }

        cachedRuntimeTarget = Camera.main != null ? Camera.main.transform : null;
        return cachedRuntimeTarget;
    }

    private static GStylizedTerrain[] ResolvePolarisTerrains()
    {
        if (!Application.isPlaying)
        {
            return FindObjectsByType<GStylizedTerrain>(FindObjectsSortMode.None);
        }

        if (cachedPolarisTerrains.Length > 0 && Time.unscaledTime < nextPolarisTerrainRefreshTime)
        {
            return cachedPolarisTerrains;
        }

        cachedPolarisTerrains = FindObjectsByType<GStylizedTerrain>(FindObjectsSortMode.None);
        nextPolarisTerrainRefreshTime = Time.unscaledTime + 1f;
        return cachedPolarisTerrains;
    }

    private static bool TryFindSceneTransformWithComponent(string componentTypeName, out Transform result)
    {
        Transform[] transforms = FindObjectsByType<Transform>(FindObjectsSortMode.None);
        for (int i = 0; i < transforms.Length; i++)
        {
            Transform candidate = transforms[i];
            if (candidate == null || !candidate.gameObject.scene.IsValid())
            {
                continue;
            }

            if (candidate.GetComponent(componentTypeName) != null)
            {
                result = candidate;
                return true;
            }
        }

        result = null;
        return false;
    }

    private static bool TryFindSceneTransformWithTag(string tagName, out Transform result)
    {
        GameObject[] gameObjects;
        try
        {
            gameObjects = GameObject.FindGameObjectsWithTag(tagName);
        }
        catch (UnityException)
        {
            result = null;
            return false;
        }

        for (int i = 0; i < gameObjects.Length; i++)
        {
            GameObject candidate = gameObjects[i];
            if (candidate == null || !candidate.scene.IsValid())
            {
                continue;
            }

            result = candidate.transform;
            return true;
        }

        result = null;
        return false;
    }

    private sealed class RuntimeDriver : MonoBehaviour
    {
        private void Update()
        {
            ProcessRuntimeBlankets();
        }

        private void OnDestroy()
        {
            if (runtimeDriver == this)
            {
                runtimeDriver = null;
            }
        }
    }

#if UNITY_EDITOR
    private static void RegisterEditorBlanket(TerrainConformBlanket blanket)
    {
        if (EditorBlankets.Contains(blanket))
        {
            return;
        }

        EditorBlankets.Add(blanket);
        if (editorUpdateRegistered)
        {
            return;
        }

        EditorApplication.update += ProcessEditorBlankets;
        editorUpdateRegistered = true;
    }

    private static void UnregisterEditorBlanket(TerrainConformBlanket blanket)
    {
        int index = EditorBlankets.IndexOf(blanket);
        if (index >= 0)
        {
            EditorBlankets.RemoveAt(index);
            if (index < editorPendingConformCursor)
            {
                editorPendingConformCursor--;
            }
        }

        if (EditorBlankets.Count > 0 || !editorUpdateRegistered)
        {
            return;
        }

        EditorApplication.update -= ProcessEditorBlankets;
        editorUpdateRegistered = false;
        editorPendingConformCursor = 0;
    }

    private static void ProcessEditorBlankets()
    {
        if (Application.isPlaying || EditorApplication.isPlayingOrWillChangePlaymode)
        {
            return;
        }

        for (int i = EditorBlankets.Count - 1; i >= 0; i--)
        {
            TerrainConformBlanket blanket = EditorBlankets[i];
            if (blanket == null)
            {
                EditorBlankets.RemoveAt(i);
                continue;
            }

            blanket.ProcessEditorUpdate();
        }

        ProcessPendingEditorConforms();

        if (EditorBlankets.Count == 0 && editorUpdateRegistered)
        {
            EditorApplication.update -= ProcessEditorBlankets;
            editorUpdateRegistered = false;
            editorPendingConformCursor = 0;
        }
    }

    private static void ProcessPendingEditorConforms()
    {
        if (EditorBlankets.Count == 0)
        {
            return;
        }

        int processed = 0;
        int inspected = 0;
        int blanketCount = EditorBlankets.Count;
        while (processed < MaxEditorConformsPerUpdate && inspected < blanketCount && EditorBlankets.Count > 0)
        {
            if (editorPendingConformCursor >= EditorBlankets.Count)
            {
                editorPendingConformCursor = 0;
            }

            TerrainConformBlanket blanket = EditorBlankets[editorPendingConformCursor];
            editorPendingConformCursor++;
            inspected++;

            if (blanket == null)
            {
                continue;
            }

            if (blanket.TryProcessPendingEditorConform())
            {
                processed++;
            }
        }

        if (processed > 0)
        {
            SceneView.RepaintAll();
        }
    }

    private void ProcessEditorUpdate()
    {
        if (ShouldSkip())
        {
            return;
        }

        if (autoConformOnTransformChange && TransformChanged())
        {
            ScheduleConform();
        }
    }

    private bool TryProcessPendingEditorConform()
    {
        if (this == null || Application.isPlaying || !pendingConform || ShouldSkip())
        {
            return false;
        }

        pendingConform = false;
        ConformNow();
        CacheTransformState();
        return true;
    }
#endif

    private void EnsureDefaultLayerMask()
    {
        if (groundLayers.value == 0)
        {
            groundLayers = ~0;
        }
    }

    private bool TryBuildFootprint(out MeshFootprint footprint)
    {
        footprint = default;

        var filters = GetComponentsInChildren<MeshFilter>(true);
        if (filters.Length == 0)
        {
            return false;
        }

        var rootWorldToLocal = transform.worldToLocalMatrix;
        var hasBounds = false;
        var minLocalX = float.PositiveInfinity;
        var maxLocalX = float.NegativeInfinity;
        var minLocalZ = float.PositiveInfinity;
        var maxLocalZ = float.NegativeInfinity;
        var lowestWorldY = float.PositiveInfinity;

        for (var i = 0; i < filters.Length; i++)
        {
            var filter = filters[i];
            var sourceMesh = ResolveSourceMesh(filter);
            if (filter == null || sourceMesh == null)
            {
                continue;
            }

#if UNITY_EDITOR
            EnsureMeshIsReadable(sourceMesh);
#endif

            var corners = GetBoundsCorners(sourceMesh.bounds);
            var localToRoot = rootWorldToLocal * filter.transform.localToWorldMatrix;

            for (var c = 0; c < corners.Length; c++)
            {
                var rootLocalCorner = localToRoot.MultiplyPoint3x4(corners[c]);
                minLocalX = Mathf.Min(minLocalX, rootLocalCorner.x);
                maxLocalX = Mathf.Max(maxLocalX, rootLocalCorner.x);
                minLocalZ = Mathf.Min(minLocalZ, rootLocalCorner.z);
                maxLocalZ = Mathf.Max(maxLocalZ, rootLocalCorner.z);

                var worldCorner = filter.transform.TransformPoint(corners[c]);
                lowestWorldY = Mathf.Min(lowestWorldY, worldCorner.y);
                hasBounds = true;
            }
        }

        if (!hasBounds)
        {
            return false;
        }

        var insetX = Mathf.Min(footprintInset, Mathf.Max(0f, (maxLocalX - minLocalX) * 0.5f - 0.01f));
        var insetZ = Mathf.Min(footprintInset, Mathf.Max(0f, (maxLocalZ - minLocalZ) * 0.5f - 0.01f));

        footprint = new MeshFootprint
        {
            MinLocalX = minLocalX + insetX,
            MaxLocalX = maxLocalX - insetX,
            MinLocalZ = minLocalZ + insetZ,
            MaxLocalZ = maxLocalZ - insetZ,
            LowestWorldY = lowestWorldY
        };

        return footprint.MaxLocalX > footprint.MinLocalX &&
               footprint.MaxLocalZ > footprint.MinLocalZ;
    }

    private bool TryAnchorToFootprint(MeshFootprint footprint)
    {
        sampledHeights.Clear();

        var sampleCount = Mathf.Max(2, sampleResolution);
        for (var z = 0; z < sampleCount; z++)
        {
            var zT = z / (float)(sampleCount - 1);
            var localZ = Mathf.Lerp(footprint.MinLocalZ, footprint.MaxLocalZ, zT);
            for (var x = 0; x < sampleCount; x++)
            {
                var xT = x / (float)(sampleCount - 1);
                var localX = Mathf.Lerp(footprint.MinLocalX, footprint.MaxLocalX, xT);
                var worldPoint = transform.TransformPoint(new Vector3(localX, 0f, localZ));
                if (TrySampleGroundHeight(worldPoint, out var groundHeight))
                {
                    sampledHeights.Add(groundHeight);
                }
            }
        }

        if (sampledHeights.Count == 0)
        {
            return false;
        }

        sampledHeights.Sort();
        var percentileIndex = Mathf.RoundToInt((sampledHeights.Count - 1) * samplePercentile);
        percentileIndex = Mathf.Clamp(percentileIndex, 0, sampledHeights.Count - 1);

        var targetGroundHeight = sampledHeights[percentileIndex] + surfaceOffset;
        var requiredDelta = targetGroundHeight - footprint.LowestWorldY - buryDepth;

        var position = transform.position;
        position.y += requiredDelta;
        transform.position = position;
        return true;
    }

    private void EnsureRuntimeMeshStates()
    {
        meshStates.Clear();

        var filters = GetComponentsInChildren<MeshFilter>(true);
        for (var i = 0; i < filters.Length; i++)
        {
            var filter = filters[i];
            var sourceMesh = ResolveSourceMesh(filter);
            if (filter == null || sourceMesh == null)
            {
                continue;
            }

#if UNITY_EDITOR
            EnsureMeshIsReadable(sourceMesh);
#endif

            var runtimeMesh = UnityEngine.Object.Instantiate(sourceMesh);
            runtimeMesh.name = $"{sourceMesh.name} (Conformed)";
            runtimeMesh.hideFlags = HideFlags.DontSaveInEditor | HideFlags.DontSaveInBuild;
            filter.sharedMesh = runtimeMesh;

            var sourceVertices = sourceMesh.vertices;
            meshStates.Add(new MeshState
            {
                Filter = filter,
                RuntimeMesh = runtimeMesh,
                SourceVertices = sourceVertices,
                MinSourceY = GetMinY(sourceVertices),
                MaxSourceY = GetMaxY(sourceVertices)
            });
        }
    }

    private void DeformLowestVertices()
    {
        for (var stateIndex = 0; stateIndex < meshStates.Count; stateIndex++)
        {
            var state = meshStates[stateIndex];
            if (state.Filter == null || state.RuntimeMesh == null || state.SourceVertices == null)
            {
                continue;
            }

            var newVertices = new Vector3[state.SourceVertices.Length];
            for (var i = 0; i < state.SourceVertices.Length; i++)
            {
                var sourceVertex = state.SourceVertices[i];
                var influence = CalculateFollowInfluence(sourceVertex.y, state.MinSourceY, state.MaxSourceY);
                if (influence <= 0f)
                {
                    newVertices[i] = sourceVertex;
                    continue;
                }

                var worldVertex = state.Filter.transform.TransformPoint(sourceVertex);
                if (!TrySampleGroundHeight(worldVertex, out var groundHeight))
                {
                    newVertices[i] = sourceVertex;
                    continue;
                }

                worldVertex.y = Mathf.Lerp(worldVertex.y, groundHeight + surfaceOffset, influence);
                newVertices[i] = state.Filter.transform.InverseTransformPoint(worldVertex);
            }

            state.RuntimeMesh.vertices = newVertices;
            if (recalculateBounds)
            {
                state.RuntimeMesh.RecalculateBounds();
            }
        }
    }

    private float CalculateFollowInfluence(float sourceY, float minSourceY, float maxSourceY)
    {
        if (maxSourceY <= minSourceY + 0.0001f)
        {
            return 1f;
        }

        var normalizedY = Mathf.InverseLerp(minSourceY, maxSourceY, sourceY);
        if (normalizedY <= bottomFollowHeight)
        {
            return 1f;
        }

        if (normalizedY >= topLockHeight)
        {
            return 0f;
        }

        var t = Mathf.InverseLerp(bottomFollowHeight, topLockHeight, normalizedY);
        return 1f - Mathf.SmoothStep(0f, 1f, t);
    }

    private bool TrySampleGroundHeight(Vector3 worldPoint, out float groundHeight)
    {
        if (TrySamplePolarisTerrainHeight(worldPoint, out groundHeight))
        {
            return true;
        }

        var rayOrigin = new Vector3(worldPoint.x, worldPoint.y + raycastStartHeight, worldPoint.z);
        if (TryGetGroundHit(rayOrigin, raycastStartHeight + raycastDistance, out var hit))
        {
            groundHeight = hit.point.y;
            return true;
        }

        groundHeight = 0f;
        return false;
    }

    private bool TrySamplePolarisTerrainHeight(Vector3 worldPoint, out float terrainHeight)
    {
        for (var i = 0; i < polarisTerrains.Length; i++)
        {
            var terrain = polarisTerrains[i];
            if (terrain == null || !terrain.isActiveAndEnabled || terrain.TerrainData == null)
            {
                continue;
            }

            var uv = terrain.WorldPointToUV(worldPoint);
            if (uv.x < -0.001f || uv.x > 1.001f || uv.y < -0.001f || uv.y > 1.001f)
            {
                continue;
            }

            uv.x = Mathf.Clamp01(uv.x);
            uv.y = Mathf.Clamp01(uv.y);
            var sample = terrain.GetInterpolatedHeightMapSample(uv);
            var worldSurface = terrain.NormalizedToWorldPoint(new Vector3(uv.x, sample.x, uv.y));
            terrainHeight = worldSurface.y;
            return true;
        }

        terrainHeight = 0f;
        return false;
    }

    private bool TryGetGroundHit(Vector3 rayOrigin, float rayDistance, out RaycastHit groundHit)
    {
        groundHit = default;
        var hitCount = Physics.RaycastNonAlloc(
            rayOrigin,
            Vector3.down,
            SharedRaycastHits,
            rayDistance,
            groundLayers,
            QueryTriggerInteraction.Ignore);

        if (hitCount <= 0)
        {
            return false;
        }

        var foundHit = false;
        var closestDistance = float.PositiveInfinity;
        for (var i = 0; i < hitCount; i++)
        {
            var hit = SharedRaycastHits[i];
            if (hit.collider == null || hit.collider.transform.IsChildOf(transform))
            {
                continue;
            }

            if (hit.distance >= closestDistance)
            {
                continue;
            }

            closestDistance = hit.distance;
            groundHit = hit;
            foundHit = true;
        }

        return foundHit;
    }

    private static Vector3[] GetBoundsCorners(Bounds bounds)
    {
        var min = bounds.min;
        var max = bounds.max;
        return new[]
        {
            new Vector3(min.x, min.y, min.z),
            new Vector3(max.x, min.y, min.z),
            new Vector3(min.x, max.y, min.z),
            new Vector3(max.x, max.y, min.z),
            new Vector3(min.x, min.y, max.z),
            new Vector3(max.x, min.y, max.z),
            new Vector3(min.x, max.y, max.z),
            new Vector3(max.x, max.y, max.z)
        };
    }

    private static float GetMinY(IReadOnlyList<Vector3> vertices)
    {
        var minY = float.PositiveInfinity;
        for (var i = 0; i < vertices.Count; i++)
        {
            if (vertices[i].y < minY)
            {
                minY = vertices[i].y;
            }
        }

        return minY;
    }

    private static float GetMaxY(IReadOnlyList<Vector3> vertices)
    {
        var maxY = float.NegativeInfinity;
        for (var i = 0; i < vertices.Count; i++)
        {
            if (vertices[i].y > maxY)
            {
                maxY = vertices[i].y;
            }
        }

        return maxY;
    }

    private static Mesh ResolveSourceMesh(MeshFilter filter)
    {
        if (filter == null)
        {
            return null;
        }

#if UNITY_EDITOR
        if (!Application.isPlaying)
        {
            var sourceFilter = PrefabUtility.GetCorrespondingObjectFromSource(filter);
            if (sourceFilter != null && sourceFilter.sharedMesh != null)
            {
                return sourceFilter.sharedMesh;
            }
        }
#endif

        return filter.sharedMesh;
    }

    private static void ReleaseRuntimeMesh(Mesh mesh)
    {
        if (mesh == null)
        {
            return;
        }

        var isRuntimeClone = (mesh.hideFlags & HideFlags.DontSaveInEditor) != 0 ||
                             (mesh.hideFlags & HideFlags.DontSaveInBuild) != 0;
        if (!isRuntimeClone)
        {
            return;
        }

#if UNITY_EDITOR
        if (!Application.isPlaying)
        {
            UnityEngine.Object.DestroyImmediate(mesh);
            return;
        }
#endif

        UnityEngine.Object.Destroy(mesh);
    }

#if UNITY_EDITOR
    private static void EnsureMeshIsReadable(Mesh mesh)
    {
        if (mesh == null || mesh.isReadable)
        {
            return;
        }

        var assetPath = AssetDatabase.GetAssetPath(mesh);
        if (string.IsNullOrEmpty(assetPath))
        {
            return;
        }

        var importer = AssetImporter.GetAtPath(assetPath) as ModelImporter;
        if (importer == null || importer.isReadable)
        {
            return;
        }

        importer.isReadable = true;
        importer.SaveAndReimport();
    }
#endif

    private sealed class MeshState
    {
        public MeshFilter Filter;
        public Mesh RuntimeMesh;
        public Vector3[] SourceVertices;
        public float MinSourceY;
        public float MaxSourceY;
    }

    private struct MeshFootprint
    {
        public float MinLocalX;
        public float MaxLocalX;
        public float MinLocalZ;
        public float MaxLocalZ;
        public float LowestWorldY;
    }
}
