using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

#nullable enable

namespace Thiod.TileLoading.Runtime
{

internal enum TreeOptimizationTier
{
    Unknown = 0,
    Full = 1,
    Reduced = 2,
    LowDetail = 3,
    Culled = 4,
}

internal sealed class GeneratedTreeInstance
{
    public GeneratedTreeInstance(GameObject root)
    {
        Root = root;
        Transform = root.transform;
        LodGroup = root.GetComponent<LODGroup>();
        Colliders = root.GetComponentsInChildren<Collider>(true);
        Renderers = root.GetComponentsInChildren<Renderer>(true);
        DecalProjectors = root.GetComponentsInChildren<DecalProjector>(true);
        OriginalShadowCastingModes = new ShadowCastingMode[Renderers.Length];
        OriginalReceiveShadows = new bool[Renderers.Length];
        for (int i = 0; i < Renderers.Length; i++)
        {
            Renderer renderer = Renderers[i];
            OriginalShadowCastingModes[i] = renderer.shadowCastingMode;
            OriginalReceiveShadows[i] = renderer.receiveShadows;
        }

        OriginalDecalProjectorStates = new bool[DecalProjectors.Length];
        for (int i = 0; i < DecalProjectors.Length; i++)
        {
            DecalProjector decalProjector = DecalProjectors[i];
            OriginalDecalProjectorStates[i] = decalProjector != null && decalProjector.enabled;
        }

        LodObjects = ExtractLodObjects(LodGroup);
        LowestAvailableLodIndex = FindLowestAvailableLodIndex(LodObjects);
    }

    public GameObject Root { get; }
    public Transform Transform { get; }
    public LODGroup? LodGroup { get; }
    public Collider[] Colliders { get; }
    public Renderer[] Renderers { get; }
    public DecalProjector[] DecalProjectors { get; }
    public ShadowCastingMode[] OriginalShadowCastingModes { get; }
    public bool[] OriginalReceiveShadows { get; }
    public bool[] OriginalDecalProjectorStates { get; }
    public GameObject?[] LodObjects { get; }
    public int? LowestAvailableLodIndex { get; }
    public TreeOptimizationTier CurrentTier { get; set; }

    private static GameObject?[] ExtractLodObjects(LODGroup? lodGroup)
    {
        if (lodGroup == null)
        {
            return System.Array.Empty<GameObject?>();
        }

        LOD[] lods = lodGroup.GetLODs();
        var lodObjects = new GameObject?[lods.Length];
        for (int i = 0; i < lods.Length; i++)
        {
            Renderer[] renderers = lods[i].renderers;
            if (renderers != null && renderers.Length > 0 && renderers[0] != null)
            {
                lodObjects[i] = renderers[0].gameObject;
            }
        }

        return lodObjects;
    }

    private static int? FindLowestAvailableLodIndex(GameObject?[] lodObjects)
    {
        for (int i = lodObjects.Length - 1; i >= 0; i--)
        {
            if (lodObjects[i] != null)
            {
                return i;
            }
        }

        return null;
    }
}

internal sealed class TileLoaderTreeOptimizer
{
    private readonly TreeOptimizationContext context;

    public TileLoaderTreeOptimizer(TreeOptimizationContext context)
    {
        this.context = context;
    }

    public void ApplyOptimizationToAll(System.Collections.Generic.IReadOnlyList<GeneratedTreeInstance> instances, TreeOptimizationTier tier)
    {
        for (int i = 0; i < instances.Count; i++)
        {
            ApplyOptimization(instances[i], tier);
        }
    }

    public TreeOptimizationTier DetermineTier(
        float sqrDistance,
        float fullDistanceSq,
        float reducedDistanceSq,
        float lowDetailDistanceSq)
    {
        float culledDistanceSq = context.CulledTreeDistance * context.CulledTreeDistance;
        if (sqrDistance <= fullDistanceSq)
        {
            return TreeOptimizationTier.Full;
        }

        if (sqrDistance <= reducedDistanceSq)
        {
            return TreeOptimizationTier.Reduced;
        }

        if (sqrDistance <= lowDetailDistanceSq)
        {
            return TreeOptimizationTier.LowDetail;
        }

        return sqrDistance <= culledDistanceSq
            ? TreeOptimizationTier.LowDetail
            : TreeOptimizationTier.Culled;
    }

    public void ApplyOptimization(GeneratedTreeInstance instance, TreeOptimizationTier tier)
    {
        if (instance.Root == null || instance.CurrentTier == tier)
        {
            return;
        }

        if (tier == TreeOptimizationTier.Culled)
        {
            instance.Root.SetActive(false);
            instance.CurrentTier = tier;
            return;
        }

        if (!instance.Root.activeSelf)
        {
            instance.Root.SetActive(true);
        }

        switch (tier)
        {
            case TreeOptimizationTier.Full:
                SetTreeLodObjects(instance, activeLodIndex: null);
                SetTreeLodGroupEnabled(instance, true);
                SetTreeCollidersEnabled(instance, true);
                RestoreTreeRendererState(instance);
                RestoreTreeDecalState(instance);
                break;
            case TreeOptimizationTier.Reduced:
                SetTreeLodObjects(instance, activeLodIndex: null);
                SetTreeLodGroupEnabled(instance, true);
                SetTreeCollidersEnabled(instance, !context.DisableDistantTreeColliders);
                if (context.DisableDistantTreeShadows)
                {
                    SetTreeShadowsEnabled(instance, false);
                }
                else
                {
                    RestoreTreeRendererState(instance);
                }

                if (context.DisableDistantTreeDecals)
                {
                    SetTreeDecalsEnabled(instance, false);
                }
                else
                {
                    RestoreTreeDecalState(instance);
                }

                break;
            case TreeOptimizationTier.LowDetail:
                SetTreeLodObjects(instance, activeLodIndex: instance.LowestAvailableLodIndex);
                SetTreeLodGroupEnabled(instance, false);
                SetTreeCollidersEnabled(instance, false);
                if (context.DisableDistantTreeShadows)
                {
                    SetTreeShadowsEnabled(instance, false);
                }
                else
                {
                    RestoreTreeRendererState(instance);
                }

                if (context.DisableDistantTreeDecals)
                {
                    SetTreeDecalsEnabled(instance, false);
                }
                else
                {
                    RestoreTreeDecalState(instance);
                }

                break;
        }

        instance.CurrentTier = tier;
    }

    public static bool TryFindSceneTransformWithComponent(string componentTypeName, out Transform? result)
    {
        Transform[] transforms = Object.FindObjectsByType<Transform>(FindObjectsSortMode.None);
        for (int i = 0; i < transforms.Length; i++)
        {
            Transform transform = transforms[i];
            if (transform == null || !transform.gameObject.scene.IsValid())
            {
                continue;
            }

            if (transform.GetComponent(componentTypeName) != null)
            {
                result = transform;
                return true;
            }
        }

        result = null;
        return false;
    }

    public static bool TryFindSceneTransformWithTag(string tagName, out Transform? result)
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

    private static void SetTreeLodGroupEnabled(GeneratedTreeInstance instance, bool enabled)
    {
        if (instance.LodGroup != null)
        {
            instance.LodGroup.enabled = enabled;
        }
    }

    private static void SetTreeCollidersEnabled(GeneratedTreeInstance instance, bool enabled)
    {
        for (int i = 0; i < instance.Colliders.Length; i++)
        {
            Collider collider = instance.Colliders[i];
            if (collider != null)
            {
                collider.enabled = enabled;
            }
        }
    }

    private static void SetTreeLodObjects(GeneratedTreeInstance instance, int? activeLodIndex)
    {
        GameObject?[] lodObjects = instance.LodObjects;
        if (lodObjects.Length == 0)
        {
            return;
        }

        for (int i = 0; i < lodObjects.Length; i++)
        {
            GameObject? lodObject = lodObjects[i];
            if (lodObject == null)
            {
                continue;
            }

            bool shouldBeActive = !activeLodIndex.HasValue || i == activeLodIndex.Value;
            if (lodObject.activeSelf != shouldBeActive)
            {
                lodObject.SetActive(shouldBeActive);
            }
        }
    }

    private static void SetTreeShadowsEnabled(GeneratedTreeInstance instance, bool enabled)
    {
        for (int i = 0; i < instance.Renderers.Length; i++)
        {
            Renderer renderer = instance.Renderers[i];
            if (renderer == null)
            {
                continue;
            }

            renderer.shadowCastingMode = enabled
                ? instance.OriginalShadowCastingModes[i]
                : ShadowCastingMode.Off;
            renderer.receiveShadows = enabled && instance.OriginalReceiveShadows[i];
        }
    }

    private static void RestoreTreeRendererState(GeneratedTreeInstance instance)
    {
        for (int i = 0; i < instance.Renderers.Length; i++)
        {
            Renderer renderer = instance.Renderers[i];
            if (renderer == null)
            {
                continue;
            }

            renderer.shadowCastingMode = instance.OriginalShadowCastingModes[i];
            renderer.receiveShadows = instance.OriginalReceiveShadows[i];
        }
    }

    private static void SetTreeDecalsEnabled(GeneratedTreeInstance instance, bool enabled)
    {
        for (int i = 0; i < instance.DecalProjectors.Length; i++)
        {
            DecalProjector decalProjector = instance.DecalProjectors[i];
            if (decalProjector != null)
            {
                decalProjector.enabled = enabled;
            }
        }
    }

    private static void RestoreTreeDecalState(GeneratedTreeInstance instance)
    {
        for (int i = 0; i < instance.DecalProjectors.Length; i++)
        {
            DecalProjector decalProjector = instance.DecalProjectors[i];
            if (decalProjector != null)
            {
                decalProjector.enabled = instance.OriginalDecalProjectorStates[i];
            }
        }
    }
}

internal sealed class TileLoaderTreeOptimizationController
{
    private readonly TileLoader owner;
    private readonly System.Collections.Generic.List<GeneratedTreeInstance> generatedTreeInstances = new();
    private bool treeOptimizationWasActive;
    private float nextTreeOptimizationTime;

    public TileLoaderTreeOptimizationController(TileLoader owner)
    {
        this.owner = owner;
    }

    public void ResetState()
    {
        generatedTreeInstances.Clear();
        treeOptimizationWasActive = false;
        nextTreeOptimizationTime = 0f;
    }

    public void RegisterGeneratedTree(GameObject instance)
    {
        if (instance == null)
        {
            return;
        }

        generatedTreeInstances.Add(new GeneratedTreeInstance(instance));
    }

    public void UpdateRuntimeOptimization(bool holdAtFull)
    {
        if (!owner.UsesLegacyVegetationObjectsInternal() || !owner.OptimizeTreesByDistanceInternal)
        {
            if (treeOptimizationWasActive)
            {
                ApplyOptimizationToAll(TreeOptimizationTier.Full);
                treeOptimizationWasActive = false;
            }

            return;
        }

        if (holdAtFull)
        {
            ApplyOptimizationToAll(TreeOptimizationTier.Full);
            treeOptimizationWasActive = false;
            nextTreeOptimizationTime = Time.unscaledTime + Mathf.Max(0.05f, owner.TreeOptimizationIntervalInternal);
            return;
        }

        treeOptimizationWasActive = true;
        if (Time.unscaledTime < nextTreeOptimizationTime)
        {
            return;
        }

        nextTreeOptimizationTime = Time.unscaledTime + Mathf.Max(0.05f, owner.TreeOptimizationIntervalInternal);
        UpdateOptimization(forceFullIfNoTarget: false);
    }

    public void UpdateOptimization(bool forceFullIfNoTarget = false)
    {
        PruneDestroyedTrees();
        if (generatedTreeInstances.Count == 0)
        {
            return;
        }

        Transform? target = ResolveOptimizationTarget();
        if (target == null)
        {
            if (forceFullIfNoTarget)
            {
                ApplyOptimizationToAll(TreeOptimizationTier.Full);
            }

            return;
        }

        TileLoaderTreeOptimizer optimizer = owner.CreateTreeOptimizerInternal();
        float fullDistanceSq = owner.FullTreeDistanceInternal * owner.FullTreeDistanceInternal;
        float reducedDistanceSq = owner.ReducedTreeDistanceInternal * owner.ReducedTreeDistanceInternal;
        float lowDetailDistanceSq = owner.LowDetailTreeDistanceInternal * owner.LowDetailTreeDistanceInternal;

        for (int i = 0; i < generatedTreeInstances.Count; i++)
        {
            GeneratedTreeInstance instance = generatedTreeInstances[i];
            float sqrDistance = (instance.Transform.position - target.position).sqrMagnitude;
            TreeOptimizationTier tier = optimizer.DetermineTier(
                sqrDistance,
                fullDistanceSq,
                reducedDistanceSq,
                lowDetailDistanceSq);
            optimizer.ApplyOptimization(instance, tier);
        }
    }

    public void ApplyOptimizationToAll(TreeOptimizationTier tier)
    {
        PruneDestroyedTrees();
        if (generatedTreeInstances.Count == 0)
        {
            return;
        }

        owner.CreateTreeOptimizerInternal().ApplyOptimizationToAll(generatedTreeInstances, tier);
    }

    private void PruneDestroyedTrees()
    {
        generatedTreeInstances.RemoveAll(instance => instance.Root == null);
    }

    private Transform? ResolveOptimizationTarget()
    {
        Transform? target = owner.TreeOptimizationTargetInternal;
        if (target != null && target.gameObject.scene.IsValid())
        {
            return target;
        }

        if (TileLoaderTreeOptimizer.TryFindSceneTransformWithComponent("UltimateCharacterLocomotion", out Transform? ultimateLocomotionTransform))
        {
            owner.TreeOptimizationTargetInternal = ultimateLocomotionTransform;
            return ultimateLocomotionTransform;
        }

        if (TileLoaderTreeOptimizer.TryFindSceneTransformWithComponent("CharacterLocomotion", out Transform? locomotionTransform))
        {
            owner.TreeOptimizationTargetInternal = locomotionTransform;
            return locomotionTransform;
        }

        if (TileLoaderTreeOptimizer.TryFindSceneTransformWithTag("Player", out Transform? taggedPlayerTransform))
        {
            owner.TreeOptimizationTargetInternal = taggedPlayerTransform;
            return taggedPlayerTransform;
        }

        return Camera.main != null ? Camera.main.transform : null;
    }
}

}
