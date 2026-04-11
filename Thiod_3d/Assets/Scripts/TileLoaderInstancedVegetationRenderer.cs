using System;
using System.Collections.Generic;
using System.Collections;
using Stopwatch = System.Diagnostics.Stopwatch;
using UnityEngine;
using UnityEngine.Rendering;
#if GRIFFIN
using Pinwheel.Griffin;
#endif

#nullable enable

[Serializable]
public sealed class TileLoaderInstancedVegetationRenderSource
{
    public TileLoaderInstancedVegetationRenderSource(
        Mesh mesh,
        int subMeshIndex,
        Material material,
        Matrix4x4 localMatrix,
        ShadowCastingMode shadowCastingMode,
        bool receiveShadows,
        int layer)
    {
        Mesh = mesh;
        SubMeshIndex = subMeshIndex;
        Material = material;
        LocalMatrix = localMatrix;
        ShadowCastingMode = shadowCastingMode;
        ReceiveShadows = receiveShadows;
        Layer = layer;
    }

    public Mesh Mesh { get; }
    public int SubMeshIndex { get; }
    public Material Material { get; }
    public Matrix4x4 LocalMatrix { get; }
    public ShadowCastingMode ShadowCastingMode { get; }
    public bool ReceiveShadows { get; }
    public int Layer { get; }
}

[Serializable]
public sealed class TileLoaderInstancedVegetationPrototype
{
    public TileLoaderInstancedVegetationPrototype(
        string key,
        GameObject prefab,
        bool isTree,
        bool supportsPromotion,
        float maxRenderDistanceMeters,
        IReadOnlyList<TileLoaderInstancedVegetationRenderSource> renderSources)
    {
        Key = key ?? throw new ArgumentNullException(nameof(key));
        Prefab = prefab;
        IsTree = isTree;
        SupportsPromotion = supportsPromotion;
        MaxRenderDistanceMeters = maxRenderDistanceMeters;
        RenderSources = renderSources ?? throw new ArgumentNullException(nameof(renderSources));
    }

    public string Key { get; }
    public GameObject Prefab { get; }
    public bool IsTree { get; }
    public bool SupportsPromotion { get; }
    public float MaxRenderDistanceMeters { get; }
    public IReadOnlyList<TileLoaderInstancedVegetationRenderSource> RenderSources { get; }
    public object? SharedRuntime { get; set; }
}

public readonly struct TileLoaderInstancedVegetationPlacement
{
    public TileLoaderInstancedVegetationPlacement(
        int prototypeIndex,
        Vector3 localPosition,
        Quaternion localRotation,
        Vector3 localScale,
        bool conformToTerrainOnPromotion,
        float surfaceSampleLocalX,
        float surfaceSampleLocalZ,
        float surfaceVerticalOffset,
        float surfaceNormalOffset)
    {
        PrototypeIndex = prototypeIndex;
        LocalPosition = localPosition;
        LocalRotation = localRotation;
        LocalScale = localScale;
        ConformToTerrainOnPromotion = conformToTerrainOnPromotion;
        SurfaceSampleLocalX = surfaceSampleLocalX;
        SurfaceSampleLocalZ = surfaceSampleLocalZ;
        SurfaceVerticalOffset = surfaceVerticalOffset;
        SurfaceNormalOffset = surfaceNormalOffset;
    }

    public int PrototypeIndex { get; }
    public Vector3 LocalPosition { get; }
    public Quaternion LocalRotation { get; }
    public Vector3 LocalScale { get; }
    public bool ConformToTerrainOnPromotion { get; }
    public float SurfaceSampleLocalX { get; }
    public float SurfaceSampleLocalZ { get; }
    public float SurfaceVerticalOffset { get; }
    public float SurfaceNormalOffset { get; }
}

[DisallowMultipleComponent]
public sealed class TileLoaderPromotedVegetationInstance : MonoBehaviour
{
    [SerializeField] private bool keepAsGameObject;

    public bool KeepAsGameObject
    {
        get => keepAsGameObject;
        set => keepAsGameObject = value;
    }

    public int PlacementIndex { get; internal set; } = -1;
}

[ExecuteAlways]
[DisallowMultipleComponent]
public sealed class TileLoaderInstancedVegetationRenderer : MonoBehaviour
{
    private const int MaxInstancesPerDrawCall = 1023;
    private const float MinimumInteractionUpdateInterval = 0.2f;

    private TileLoaderInstancedVegetationPrototype[] _prototypes = Array.Empty<TileLoaderInstancedVegetationPrototype>();
    private TileLoaderInstancedVegetationPlacement[] _placements = Array.Empty<TileLoaderInstancedVegetationPlacement>();
    private PrototypeRuntime[] _prototypeRuntimes = Array.Empty<PrototypeRuntime>();
    private PlacementRuntimeState[] _placementStates = Array.Empty<PlacementRuntimeState>();
    private readonly Matrix4x4[] _matrixBuffer = new Matrix4x4[MaxInstancesPerDrawCall];
    private float _interactionRadiusMeters;
    private float _interactionHysteresisMeters;
    private bool _interactive;
    private float _nextInteractionUpdateTime;
    private Transform? _promotedContainer;
    private Coroutine? _runtimeBuildCoroutine;
    private float _prototypeInitBudgetMsPerFrame;

    public bool IsPrototypeRuntimeReady { get; private set; }
    public double LastPrototypeInitializationMilliseconds { get; private set; }
    public double LastInitializationCpuMilliseconds { get; private set; }

    public void Initialize(
        IReadOnlyList<TileLoaderInstancedVegetationPrototype> prototypes,
        IReadOnlyList<TileLoaderInstancedVegetationPlacement> placements,
        bool interactive,
        float interactionRadiusMeters,
        float interactionHysteresisMeters,
        float prototypeInitBudgetMsPerFrame)
    {
        ReleaseRuntimeData();

        _prototypes = new TileLoaderInstancedVegetationPrototype[prototypes.Count];
        for (int i = 0; i < _prototypes.Length; i++)
        {
            _prototypes[i] = prototypes[i];
        }

        _placements = new TileLoaderInstancedVegetationPlacement[placements.Count];
        _placementStates = new PlacementRuntimeState[placements.Count];
        for (int i = 0; i < _placements.Length; i++)
        {
            _placements[i] = placements[i];
            _placementStates[i] = new PlacementRuntimeState();
        }

        _interactive = interactive;
        _interactionRadiusMeters = Mathf.Max(0f, interactionRadiusMeters);
        _interactionHysteresisMeters = Mathf.Max(0f, interactionHysteresisMeters);
        _prototypeInitBudgetMsPerFrame = Mathf.Max(0.1f, prototypeInitBudgetMsPerFrame);
        _nextInteractionUpdateTime = 0f;
        LastPrototypeInitializationMilliseconds = 0d;
        LastInitializationCpuMilliseconds = 0d;
        IsPrototypeRuntimeReady = false;
        var initializeStopwatch = Stopwatch.StartNew();

        if (Application.isPlaying &&
            gameObject.activeInHierarchy &&
            _placements.Length > 512 &&
            _prototypeInitBudgetMsPerFrame > 0f)
        {
            _prototypeRuntimes = new PrototypeRuntime[_prototypes.Length];
            _runtimeBuildCoroutine = StartCoroutine(BuildPrototypeRuntimesOverMultipleFrames());
            enabled = _prototypes.Length > 0;
            initializeStopwatch.Stop();
            LastInitializationCpuMilliseconds = initializeStopwatch.Elapsed.TotalMilliseconds;
            return;
        }

        var stopwatch = Stopwatch.StartNew();
        _prototypeRuntimes = BuildPrototypeRuntimes(_prototypes, _placements);
        stopwatch.Stop();
        LastPrototypeInitializationMilliseconds = stopwatch.Elapsed.TotalMilliseconds;
        IsPrototypeRuntimeReady = true;
        enabled = _prototypeRuntimes.Length > 0;
        initializeStopwatch.Stop();
        LastInitializationCpuMilliseconds = initializeStopwatch.Elapsed.TotalMilliseconds;
    }

    private void OnEnable()
    {
        RenderPipelineManager.beginCameraRendering += HandleBeginCameraRendering;
    }

    private void OnDisable()
    {
        RenderPipelineManager.beginCameraRendering -= HandleBeginCameraRendering;
        ReleasePromotedInstances();
    }

    private void Update()
    {
        if (!Application.isPlaying || !_interactive || _placements.Length == 0)
        {
            return;
        }

        if (Time.unscaledTime < _nextInteractionUpdateTime)
        {
            return;
        }

        _nextInteractionUpdateTime = Time.unscaledTime + MinimumInteractionUpdateInterval;
        Transform? target = ResolveInteractionTarget();
        if (target == null)
        {
            return;
        }

        float promoteDistanceSq = _interactionRadiusMeters * _interactionRadiusMeters;
        float demoteDistance = _interactionRadiusMeters + _interactionHysteresisMeters;
        float demoteDistanceSq = demoteDistance * demoteDistance;

        for (int i = 0; i < _placements.Length; i++)
        {
            TileLoaderInstancedVegetationPlacement placement = _placements[i];
            if ((uint)placement.PrototypeIndex >= (uint)_prototypes.Length)
            {
                continue;
            }

            TileLoaderInstancedVegetationPrototype prototype = _prototypes[placement.PrototypeIndex];
            if (!prototype.SupportsPromotion)
            {
                continue;
            }

            Vector3 worldPosition = transform.TransformPoint(placement.LocalPosition);
            float sqrDistance = (worldPosition - target.position).sqrMagnitude;
            PlacementRuntimeState state = _placementStates[i];

            if (!state.IsPromoted && sqrDistance <= promoteDistanceSq)
            {
                PromotePlacement(i);
                continue;
            }

            if (!state.IsPromoted || sqrDistance < demoteDistanceSq)
            {
                continue;
            }

            TileLoaderPromotedVegetationInstance? marker = state.PromotedRoot != null
                ? state.PromotedRoot.GetComponent<TileLoaderPromotedVegetationInstance>()
                : null;
            if (marker != null && marker.KeepAsGameObject)
            {
                continue;
            }

            DemotePlacement(i);
        }
    }

    private void HandleBeginCameraRendering(ScriptableRenderContext context, Camera camera)
    {
        if (!isActiveAndEnabled || camera == null || _prototypeRuntimes.Length == 0)
        {
            return;
        }

        Matrix4x4 containerMatrix = transform.localToWorldMatrix;
        Vector3 cameraPosition = camera.transform.position;
        for (int prototypeIndex = 0; prototypeIndex < _prototypeRuntimes.Length; prototypeIndex++)
        {
            PrototypeRuntime prototypeRuntime = _prototypeRuntimes[prototypeIndex];
            if (prototypeRuntime == null || prototypeRuntime.RenderEntries.Length == 0)
            {
                continue;
            }

            float maxRenderDistanceMeters = _prototypes[prototypeIndex].MaxRenderDistanceMeters;
            bool limitByDistance = maxRenderDistanceMeters > 0f;
            float maxRenderDistanceSq = maxRenderDistanceMeters * maxRenderDistanceMeters;

            IReadOnlyList<int> placementIndices = prototypeRuntime.PlacementIndices;
            for (int renderEntryIndex = 0; renderEntryIndex < prototypeRuntime.RenderEntries.Length; renderEntryIndex++)
            {
                RenderEntryRuntime renderEntry = prototypeRuntime.RenderEntries[renderEntryIndex];
                if (renderEntry == null || renderEntry.Material == null || renderEntry.Mesh == null)
                {
                    continue;
                }

                int bufferCount = 0;
                for (int i = 0; i < placementIndices.Count; i++)
                {
                    int placementIndex = placementIndices[i];
                    if ((uint)placementIndex >= (uint)_placements.Length)
                    {
                        continue;
                    }

                    if (_placementStates[placementIndex].IsPromoted)
                    {
                        continue;
                    }

                    TileLoaderInstancedVegetationPlacement placement = _placements[placementIndex];
                    if (limitByDistance)
                    {
                        Vector3 worldPosition = transform.TransformPoint(placement.LocalPosition);
                        if ((worldPosition - cameraPosition).sqrMagnitude > maxRenderDistanceSq)
                        {
                            continue;
                        }
                    }

                    Matrix4x4 placementMatrix = Matrix4x4.TRS(
                        placement.LocalPosition,
                        placement.LocalRotation,
                        placement.LocalScale);
                    _matrixBuffer[bufferCount++] = containerMatrix * placementMatrix * renderEntry.LocalMatrix;

                    if (bufferCount < MaxInstancesPerDrawCall)
                    {
                        continue;
                    }

                    Graphics.DrawMeshInstanced(
                        renderEntry.Mesh,
                        renderEntry.SubMeshIndex,
                        renderEntry.Material,
                        _matrixBuffer,
                        bufferCount,
                        null,
                        renderEntry.ShadowCastingMode,
                        renderEntry.ReceiveShadows,
                        renderEntry.Layer,
                        camera,
                        LightProbeUsage.Off,
                        null);
                    bufferCount = 0;
                }

                if (bufferCount > 0)
                {
                    Graphics.DrawMeshInstanced(
                        renderEntry.Mesh,
                        renderEntry.SubMeshIndex,
                        renderEntry.Material,
                        _matrixBuffer,
                        bufferCount,
                        null,
                        renderEntry.ShadowCastingMode,
                        renderEntry.ReceiveShadows,
                        renderEntry.Layer,
                        camera,
                        LightProbeUsage.Off,
                        null);
                }
            }
        }
    }

    private PrototypeRuntime[] BuildPrototypeRuntimes(
        IReadOnlyList<TileLoaderInstancedVegetationPrototype> prototypes,
        IReadOnlyList<TileLoaderInstancedVegetationPlacement> placements)
    {
        var placementBuckets = new List<int>[prototypes.Count];
        for (int i = 0; i < placements.Count; i++)
        {
            TileLoaderInstancedVegetationPlacement placement = placements[i];
            if ((uint)placement.PrototypeIndex >= (uint)prototypes.Count)
            {
                continue;
            }

            placementBuckets[placement.PrototypeIndex] ??= new List<int>();
            placementBuckets[placement.PrototypeIndex].Add(i);
        }

        var runtimes = new PrototypeRuntime[prototypes.Count];
        for (int prototypeIndex = 0; prototypeIndex < prototypes.Count; prototypeIndex++)
        {
            TileLoaderInstancedVegetationPrototype prototype = prototypes[prototypeIndex];
            if (prototype == null || prototype.RenderSources.Count == 0)
            {
                runtimes[prototypeIndex] = PrototypeRuntime.Empty;
                continue;
            }

            PrototypeSharedRuntime sharedRuntime = GetOrCreateSharedRuntime(prototype);
            runtimes[prototypeIndex] = new PrototypeRuntime(
                placementBuckets[prototypeIndex] ?? new List<int>(),
                sharedRuntime.RenderEntries);
        }

        return runtimes;
    }

    private IEnumerator BuildPrototypeRuntimesOverMultipleFrames()
    {
        double frameBudgetMilliseconds = Math.Max(0.1f, _prototypeInitBudgetMsPerFrame);
        var totalStopwatch = Stopwatch.StartNew();
        var frameStopwatch = Stopwatch.StartNew();
        var placementBuckets = new List<int>[_prototypes.Length];

        for (int placementIndex = 0; placementIndex < _placements.Length; placementIndex++)
        {
            TileLoaderInstancedVegetationPlacement placement = _placements[placementIndex];
            if ((uint)placement.PrototypeIndex < (uint)_prototypes.Length)
            {
                placementBuckets[placement.PrototypeIndex] ??= new List<int>();
                placementBuckets[placement.PrototypeIndex].Add(placementIndex);
            }

            if (frameStopwatch.Elapsed.TotalMilliseconds < frameBudgetMilliseconds)
            {
                continue;
            }

            frameStopwatch.Restart();
            yield return null;
        }

        for (int prototypeIndex = 0; prototypeIndex < _prototypes.Length; prototypeIndex++)
        {
            TileLoaderInstancedVegetationPrototype prototype = _prototypes[prototypeIndex];
            if (prototype == null || prototype.RenderSources.Count == 0)
            {
                _prototypeRuntimes[prototypeIndex] = PrototypeRuntime.Empty;
            }
            else
            {
                PrototypeSharedRuntime sharedRuntime = GetOrCreateSharedRuntime(prototype);
                _prototypeRuntimes[prototypeIndex] = new PrototypeRuntime(
                    placementBuckets[prototypeIndex] ?? new List<int>(),
                    sharedRuntime.RenderEntries);
            }

            if (frameStopwatch.Elapsed.TotalMilliseconds < frameBudgetMilliseconds)
            {
                continue;
            }

            frameStopwatch.Restart();
            yield return null;
        }

        totalStopwatch.Stop();
        LastPrototypeInitializationMilliseconds = totalStopwatch.Elapsed.TotalMilliseconds;
        LastInitializationCpuMilliseconds = totalStopwatch.Elapsed.TotalMilliseconds;
        IsPrototypeRuntimeReady = true;
        _runtimeBuildCoroutine = null;
        enabled = _prototypeRuntimes.Length > 0;
    }

    private static PrototypeSharedRuntime GetOrCreateSharedRuntime(TileLoaderInstancedVegetationPrototype prototype)
    {
        if (prototype.SharedRuntime is PrototypeSharedRuntime cachedRuntime)
        {
            return cachedRuntime;
        }

        var renderEntries = new RenderEntryRuntime[prototype.RenderSources.Count];
        for (int sourceIndex = 0; sourceIndex < prototype.RenderSources.Count; sourceIndex++)
        {
            TileLoaderInstancedVegetationRenderSource source = prototype.RenderSources[sourceIndex];
            Material runtimeMaterial = CreateRuntimeInstancedMaterial(source.Material);
            renderEntries[sourceIndex] = new RenderEntryRuntime(
                source.Mesh,
                source.SubMeshIndex,
                runtimeMaterial,
                source.LocalMatrix,
                source.ShadowCastingMode,
                source.ReceiveShadows,
                source.Layer);
        }

        var sharedRuntime = new PrototypeSharedRuntime(renderEntries);
        prototype.SharedRuntime = sharedRuntime;
        return sharedRuntime;
    }

    private static Material CreateRuntimeInstancedMaterial(Material sourceMaterial)
    {
        if (sourceMaterial == null)
        {
            throw new ArgumentNullException(nameof(sourceMaterial));
        }

        if (sourceMaterial.enableInstancing)
        {
            return sourceMaterial;
        }

        var materialCopy = new Material(sourceMaterial)
        {
            enableInstancing = true,
            name = sourceMaterial.name + " (Instanced)"
        };
        return materialCopy;
    }

    private void PromotePlacement(int placementIndex)
    {
        if ((uint)placementIndex >= (uint)_placements.Length)
        {
            return;
        }

        ref PlacementRuntimeState state = ref _placementStates[placementIndex];
        if (state.IsPromoted)
        {
            return;
        }

        TileLoaderInstancedVegetationPlacement placement = _placements[placementIndex];
        if ((uint)placement.PrototypeIndex >= (uint)_prototypes.Length)
        {
            return;
        }

        TileLoaderInstancedVegetationPrototype prototype = _prototypes[placement.PrototypeIndex];
        if (prototype.Prefab == null)
        {
            return;
        }

        Transform parent = GetOrCreatePromotedContainer();
        GameObject instance = Instantiate(prototype.Prefab, parent, false);
        instance.name = prototype.Prefab.name;
        instance.transform.localPosition = placement.LocalPosition;
        instance.transform.localRotation = placement.LocalRotation;
        instance.transform.localScale = placement.LocalScale;
        if (placement.ConformToTerrainOnPromotion)
        {
            ConformPromotedPlacementToTerrain(instance.transform, placement, prototype.IsTree);
        }

        TileLoaderPromotedVegetationInstance marker = instance.GetComponent<TileLoaderPromotedVegetationInstance>();
        if (marker == null)
        {
            marker = instance.AddComponent<TileLoaderPromotedVegetationInstance>();
        }

        marker.PlacementIndex = placementIndex;
        state.PromotedRoot = instance;
        state.IsPromoted = true;
    }

    private void ConformPromotedPlacementToTerrain(
        Transform promotedTransform,
        TileLoaderInstancedVegetationPlacement placement,
        bool isTreeObject)
    {
        if (promotedTransform == null)
        {
            return;
        }

#if GRIFFIN
        GStylizedTerrain terrain = GetComponentInParent<GStylizedTerrain>();
        if (terrain == null || !terrain.isActiveAndEnabled || terrain.TerrainData == null)
        {
            return;
        }

        if (!TrySampleGeneratedTerrainSurface(
                terrain,
                placement.SurfaceSampleLocalX,
                placement.SurfaceSampleLocalZ,
                placement.SurfaceVerticalOffset,
                out Vector3 localSurfacePoint,
                out Vector3 localSurfaceNormal))
        {
            return;
        }

        Vector3 worldSurfacePoint = terrain.transform.TransformPoint(localSurfacePoint);
        Vector3 worldSurfaceNormal = terrain.transform.TransformDirection(localSurfaceNormal).normalized;
        if (!isTreeObject)
        {
            promotedTransform.rotation = Quaternion.FromToRotation(Vector3.up, worldSurfaceNormal);
            promotedTransform.position =
                worldSurfacePoint +
                worldSurfaceNormal * placement.SurfaceNormalOffset;
            return;
        }

        promotedTransform.position = worldSurfacePoint;
#endif
    }

#if GRIFFIN
    private static bool TrySampleGeneratedTerrainSurface(
        GStylizedTerrain terrain,
        float localX,
        float localZ,
        float verticalOffset,
        out Vector3 localPoint,
        out Vector3 localNormal)
    {
        localPoint = default;
        localNormal = Vector3.up;
        float terrainWidth = terrain.TerrainData?.Geometry?.Width ?? 0f;
        float terrainLength = terrain.TerrainData?.Geometry?.Length ?? 0f;
        float terrainHeight = terrain.TerrainData?.Geometry?.Height ?? 0f;
        if (terrainWidth <= 0f || terrainLength <= 0f || terrainHeight <= 0f)
        {
            return false;
        }

        float clampedLocalX = Mathf.Clamp(localX, 0f, terrainWidth);
        float clampedLocalZ = Mathf.Clamp(localZ, 0f, terrainLength);
        Vector3 worldOrigin = terrain.transform.TransformPoint(new Vector3(clampedLocalX, terrainHeight + 32f, clampedLocalZ));
        if (!terrain.Raycast(new Ray(worldOrigin, Vector3.down), out RaycastHit hit, terrainHeight + 96f))
        {
            return false;
        }

        Vector3 hitLocalPoint = terrain.transform.InverseTransformPoint(hit.point);
        Vector3 hitLocalNormal = terrain.transform.InverseTransformDirection(hit.normal).normalized;
        if (hitLocalNormal.sqrMagnitude <= 0.0001f)
        {
            hitLocalNormal = Vector3.up;
        }
        else if (hitLocalNormal.y < 0f)
        {
            hitLocalNormal = -hitLocalNormal;
        }

        localPoint = new Vector3(clampedLocalX, hitLocalPoint.y + verticalOffset, clampedLocalZ);
        localNormal = hitLocalNormal;
        return true;
    }
#endif

    private void DemotePlacement(int placementIndex)
    {
        if ((uint)placementIndex >= (uint)_placementStates.Length)
        {
            return;
        }

        ref PlacementRuntimeState state = ref _placementStates[placementIndex];
        if (!state.IsPromoted)
        {
            return;
        }

        if (state.PromotedRoot != null)
        {
            if (Application.isPlaying)
            {
                Destroy(state.PromotedRoot);
            }
            else
            {
                DestroyImmediate(state.PromotedRoot);
            }
        }

        state.PromotedRoot = null;
        state.IsPromoted = false;
    }

    private Transform GetOrCreatePromotedContainer()
    {
        if (_promotedContainer != null)
        {
            return _promotedContainer;
        }

        Transform existing = transform.Find("PromotedInstances");
        if (existing != null)
        {
            _promotedContainer = existing;
            return _promotedContainer;
        }

        var container = new GameObject("PromotedInstances");
        container.transform.SetParent(transform, false);
        container.transform.localPosition = Vector3.zero;
        container.transform.localRotation = Quaternion.identity;
        container.transform.localScale = Vector3.one;
        _promotedContainer = container.transform;
        return _promotedContainer;
    }

    private void ReleasePromotedInstances()
    {
        if (_placementStates.Length == 0)
        {
            return;
        }

        for (int i = 0; i < _placementStates.Length; i++)
        {
            if (_placementStates[i].PromotedRoot == null)
            {
                continue;
            }

            if (Application.isPlaying)
            {
                Destroy(_placementStates[i].PromotedRoot);
            }
            else
            {
                DestroyImmediate(_placementStates[i].PromotedRoot);
            }

            _placementStates[i].PromotedRoot = null;
            _placementStates[i].IsPromoted = false;
        }
    }

    private void ReleaseRuntimeData()
    {
        if (_runtimeBuildCoroutine != null)
        {
            StopCoroutine(_runtimeBuildCoroutine);
            _runtimeBuildCoroutine = null;
        }

        ReleasePromotedInstances();
        _prototypes = Array.Empty<TileLoaderInstancedVegetationPrototype>();
        _placements = Array.Empty<TileLoaderInstancedVegetationPlacement>();
        _prototypeRuntimes = Array.Empty<PrototypeRuntime>();
        _placementStates = Array.Empty<PlacementRuntimeState>();
        _promotedContainer = null;
        IsPrototypeRuntimeReady = false;
        LastPrototypeInitializationMilliseconds = 0d;
        LastInitializationCpuMilliseconds = 0d;
    }

    private Transform? ResolveInteractionTarget()
    {
        if (TryFindSceneTransformWithTag("Player", out Transform? taggedPlayerTransform))
        {
            return taggedPlayerTransform;
        }

        if (Camera.main != null)
        {
            return Camera.main.transform;
        }

        return null;
    }

    private static bool TryFindSceneTransformWithTag(string tagName, out Transform? result)
    {
        GameObject[] taggedObjects;
        try
        {
            taggedObjects = GameObject.FindGameObjectsWithTag(tagName);
        }
        catch (UnityException)
        {
            result = null;
            return false;
        }

        for (int i = 0; i < taggedObjects.Length; i++)
        {
            GameObject taggedObject = taggedObjects[i];
            if (taggedObject == null || !taggedObject.scene.IsValid())
            {
                continue;
            }

            result = taggedObject.transform;
            return true;
        }

        result = null;
        return false;
    }

    private sealed class PrototypeRuntime
    {
        public static readonly PrototypeRuntime Empty = new(Array.Empty<int>(), Array.Empty<RenderEntryRuntime>());

        public PrototypeRuntime(IReadOnlyList<int> placementIndices, RenderEntryRuntime[] renderEntries)
        {
            PlacementIndices = placementIndices;
            RenderEntries = renderEntries;
        }

        public IReadOnlyList<int> PlacementIndices { get; }
        public RenderEntryRuntime[] RenderEntries { get; }
    }

    private sealed class PrototypeSharedRuntime
    {
        public PrototypeSharedRuntime(RenderEntryRuntime[] renderEntries)
        {
            RenderEntries = renderEntries ?? throw new ArgumentNullException(nameof(renderEntries));
        }

        public RenderEntryRuntime[] RenderEntries { get; }
    }

    private sealed class RenderEntryRuntime
    {
        public RenderEntryRuntime(
            Mesh mesh,
            int subMeshIndex,
            Material material,
            Matrix4x4 localMatrix,
            ShadowCastingMode shadowCastingMode,
            bool receiveShadows,
            int layer)
        {
            Mesh = mesh;
            SubMeshIndex = subMeshIndex;
            Material = material;
            LocalMatrix = localMatrix;
            ShadowCastingMode = shadowCastingMode;
            ReceiveShadows = receiveShadows;
            Layer = layer;
        }

        public Mesh Mesh { get; }
        public int SubMeshIndex { get; }
        public Material Material { get; }
        public Matrix4x4 LocalMatrix { get; }
        public ShadowCastingMode ShadowCastingMode { get; }
        public bool ReceiveShadows { get; }
        public int Layer { get; }
    }

    private struct PlacementRuntimeState
    {
        public bool IsPromoted;
        public GameObject? PromotedRoot;
    }
}
