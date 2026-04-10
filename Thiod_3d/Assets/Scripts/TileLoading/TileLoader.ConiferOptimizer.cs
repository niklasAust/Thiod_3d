using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

#nullable enable

internal sealed class TileLoaderConiferOptimizer
{
    private readonly ConiferOptimizationContext context;

    public TileLoaderConiferOptimizer(ConiferOptimizationContext context)
    {
        this.context = context;
    }

    public void ApplyOptimizationToAll(System.Collections.Generic.IReadOnlyList<GeneratedConiferInstance> instances, ConiferOptimizationTier tier)
    {
        for (int i = 0; i < instances.Count; i++)
        {
            ApplyOptimization(instances[i], tier);
        }
    }

    public ConiferOptimizationTier DetermineTier(
        float sqrDistance,
        float fullDistanceSq,
        float reducedDistanceSq,
        float lowDetailDistanceSq)
    {
        float culledDistanceSq = context.CulledConiferDistance * context.CulledConiferDistance;
        if (sqrDistance <= fullDistanceSq)
        {
            return ConiferOptimizationTier.Full;
        }

        if (sqrDistance <= reducedDistanceSq)
        {
            return ConiferOptimizationTier.Reduced;
        }

        if (sqrDistance <= lowDetailDistanceSq)
        {
            return ConiferOptimizationTier.LowDetail;
        }

        return sqrDistance <= culledDistanceSq
            ? ConiferOptimizationTier.LowDetail
            : ConiferOptimizationTier.Culled;
    }

    public void ApplyOptimization(GeneratedConiferInstance instance, ConiferOptimizationTier tier)
    {
        if (instance.Root == null || instance.CurrentTier == tier)
        {
            return;
        }

        if (tier == ConiferOptimizationTier.Culled)
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
            case ConiferOptimizationTier.Full:
                SetConiferLodObjects(instance, activeLodIndex: null);
                SetConiferLodGroupEnabled(instance, true);
                SetConiferCollidersEnabled(instance, true);
                RestoreConiferRendererState(instance);
                RestoreConiferDecalState(instance);
                break;
            case ConiferOptimizationTier.Reduced:
                SetConiferLodObjects(instance, activeLodIndex: null);
                SetConiferLodGroupEnabled(instance, true);
                SetConiferCollidersEnabled(instance, !context.DisableDistantConiferColliders);
                if (context.DisableDistantConiferShadows)
                {
                    SetConiferShadowsEnabled(instance, false);
                }
                else
                {
                    RestoreConiferRendererState(instance);
                }

                if (context.DisableDistantConiferDecals)
                {
                    SetConiferDecalsEnabled(instance, false);
                }
                else
                {
                    RestoreConiferDecalState(instance);
                }

                break;
            case ConiferOptimizationTier.LowDetail:
                SetConiferLodObjects(instance, activeLodIndex: instance.LowestAvailableLodIndex);
                SetConiferLodGroupEnabled(instance, false);
                SetConiferCollidersEnabled(instance, false);
                if (context.DisableDistantConiferShadows)
                {
                    SetConiferShadowsEnabled(instance, false);
                }
                else
                {
                    RestoreConiferRendererState(instance);
                }

                if (context.DisableDistantConiferDecals)
                {
                    SetConiferDecalsEnabled(instance, false);
                }
                else
                {
                    RestoreConiferDecalState(instance);
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

    private static void SetConiferLodGroupEnabled(GeneratedConiferInstance instance, bool enabled)
    {
        if (instance.LodGroup != null)
        {
            instance.LodGroup.enabled = enabled;
        }
    }

    private static void SetConiferCollidersEnabled(GeneratedConiferInstance instance, bool enabled)
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

    private static void SetConiferLodObjects(GeneratedConiferInstance instance, int? activeLodIndex)
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

    private static void SetConiferShadowsEnabled(GeneratedConiferInstance instance, bool enabled)
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

    private static void RestoreConiferRendererState(GeneratedConiferInstance instance)
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

    private static void SetConiferDecalsEnabled(GeneratedConiferInstance instance, bool enabled)
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

    private static void RestoreConiferDecalState(GeneratedConiferInstance instance)
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
