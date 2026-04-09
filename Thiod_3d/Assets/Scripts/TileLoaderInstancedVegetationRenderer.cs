using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

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
        IReadOnlyList<TileLoaderInstancedVegetationRenderSource> renderSources)
    {
        Key = key ?? throw new ArgumentNullException(nameof(key));
        Prefab = prefab;
        IsTree = isTree;
        SupportsPromotion = supportsPromotion;
        RenderSources = renderSources ?? throw new ArgumentNullException(nameof(renderSources));
    }

    public string Key { get; }
    public GameObject Prefab { get; }
    public bool IsTree { get; }
    public bool SupportsPromotion { get; }
    public IReadOnlyList<TileLoaderInstancedVegetationRenderSource> RenderSources { get; }
}

public readonly struct TileLoaderInstancedVegetationPlacement
{
    public TileLoaderInstancedVegetationPlacement(
        int prototypeIndex,
        Vector3 localPosition,
        Quaternion localRotation,
        Vector3 localScale)
    {
        PrototypeIndex = prototypeIndex;
        LocalPosition = localPosition;
        LocalRotation = localRotation;
        LocalScale = localScale;
    }

    public int PrototypeIndex { get; }
    public Vector3 LocalPosition { get; }
    public Quaternion LocalRotation { get; }
    public Vector3 LocalScale { get; }
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

    public void Initialize(
        IReadOnlyList<TileLoaderInstancedVegetationPrototype> prototypes,
        IReadOnlyList<TileLoaderInstancedVegetationPlacement> placements,
        bool interactive,
        float interactionRadiusMeters,
        float interactionHysteresisMeters)
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
        _prototypeRuntimes = BuildPrototypeRuntimes(_prototypes, _placements);
        _nextInteractionUpdateTime = 0f;
        enabled = _prototypeRuntimes.Length > 0;
    }

    private void OnEnable()
    {
        RenderPipelineManager.beginCameraRendering += HandleBeginCameraRendering;
    }

    private void OnDisable()
    {
        RenderPipelineManager.beginCameraRendering -= HandleBeginCameraRendering;
        ReleasePromotedInstances();
        DestroyRuntimeMaterials();
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
            if (!prototype.IsTree || !prototype.SupportsPromotion)
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
        for (int prototypeIndex = 0; prototypeIndex < _prototypeRuntimes.Length; prototypeIndex++)
        {
            PrototypeRuntime prototypeRuntime = _prototypeRuntimes[prototypeIndex];
            if (prototypeRuntime == null || prototypeRuntime.RenderEntries.Length == 0)
            {
                continue;
            }

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

            runtimes[prototypeIndex] = new PrototypeRuntime(
                placementBuckets[prototypeIndex] ?? new List<int>(),
                renderEntries);
        }

        return runtimes;
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

        TileLoaderPromotedVegetationInstance marker = instance.GetComponent<TileLoaderPromotedVegetationInstance>();
        if (marker == null)
        {
            marker = instance.AddComponent<TileLoaderPromotedVegetationInstance>();
        }

        marker.PlacementIndex = placementIndex;
        state.PromotedRoot = instance;
        state.IsPromoted = true;
    }

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
        ReleasePromotedInstances();
        DestroyRuntimeMaterials();
        _prototypes = Array.Empty<TileLoaderInstancedVegetationPrototype>();
        _placements = Array.Empty<TileLoaderInstancedVegetationPlacement>();
        _prototypeRuntimes = Array.Empty<PrototypeRuntime>();
        _placementStates = Array.Empty<PlacementRuntimeState>();
        _promotedContainer = null;
    }

    private void DestroyRuntimeMaterials()
    {
        for (int prototypeIndex = 0; prototypeIndex < _prototypeRuntimes.Length; prototypeIndex++)
        {
            PrototypeRuntime prototypeRuntime = _prototypeRuntimes[prototypeIndex];
            if (prototypeRuntime == null)
            {
                continue;
            }

            for (int renderEntryIndex = 0; renderEntryIndex < prototypeRuntime.RenderEntries.Length; renderEntryIndex++)
            {
                RenderEntryRuntime renderEntry = prototypeRuntime.RenderEntries[renderEntryIndex];
                if (renderEntry == null || !renderEntry.OwnsMaterial || renderEntry.Material == null)
                {
                    continue;
                }

                if (Application.isPlaying)
                {
                    Destroy(renderEntry.Material);
                }
                else
                {
                    DestroyImmediate(renderEntry.Material);
                }
            }
        }
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
            OwnsMaterial = material != null && material.name.EndsWith(" (Instanced)", StringComparison.Ordinal);
        }

        public Mesh Mesh { get; }
        public int SubMeshIndex { get; }
        public Material Material { get; }
        public Matrix4x4 LocalMatrix { get; }
        public ShadowCastingMode ShadowCastingMode { get; }
        public bool ReceiveShadows { get; }
        public int Layer { get; }
        public bool OwnsMaterial { get; }
    }

    private struct PlacementRuntimeState
    {
        public bool IsPromoted;
        public GameObject? PromotedRoot;
    }
}
