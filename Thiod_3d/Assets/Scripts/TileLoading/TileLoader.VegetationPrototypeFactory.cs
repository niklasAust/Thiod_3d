using System;
using System.Collections.Generic;
using UnityEngine;
using WorldGen;

#nullable enable

internal static class TileLoaderVegetationPrototypeFactory
{
    public static bool RequiresInstancingOnly(TileObjectPlacement placement)
    {
        return placement.Definition.InstancingMode == TileObjectInstancingMode.AlwaysGpuInstanced;
    }

    public static bool SupportsHybridPromotion(TileObjectPlacement placement)
    {
        return placement.Definition.InstancingMode != TileObjectInstancingMode.AlwaysGpuInstanced;
    }

    public static float GetInstancedRenderDistanceMeters(TileObjectPlacement placement)
    {
        return placement.Definition.LoadDistanceMeters ?? 0f;
    }

    public static Renderer[] ResolveInstancedPrototypeRenderers(GameObject prefab, bool isTreeObject)
    {
        if (prefab == null)
        {
            return Array.Empty<Renderer>();
        }

        LODGroup lodGroup = prefab.GetComponentInChildren<LODGroup>(true);
        if (isTreeObject && lodGroup != null && lodGroup.enabled)
        {
            LOD[] lods = lodGroup.GetLODs();
            for (int lodIndex = 0; lodIndex < lods.Length; lodIndex++)
            {
                Renderer[] lodRenderers = lods[lodIndex].renderers;
                Renderer[] validLodRenderers = FilterUsableInstancedRenderers(lodRenderers);
                if (validLodRenderers.Length > 0)
                {
                    return validLodRenderers;
                }
            }
        }

        return FilterUsableInstancedRenderers(prefab.GetComponentsInChildren<MeshRenderer>(true));
    }

    public static Renderer[] FilterUsableInstancedRenderers(Renderer[]? renderers)
    {
        if (renderers == null || renderers.Length == 0)
        {
            return Array.Empty<Renderer>();
        }

        var usableRenderers = new List<Renderer>(renderers.Length);
        for (int i = 0; i < renderers.Length; i++)
        {
            Renderer renderer = renderers[i];
            if (renderer == null ||
                !renderer.enabled ||
                renderer.gameObject == null ||
                !renderer.gameObject.activeSelf)
            {
                continue;
            }

            usableRenderers.Add(renderer);
        }

        return usableRenderers.Count == 0
            ? Array.Empty<Renderer>()
            : usableRenderers.ToArray();
    }

    public static string? NormalizeAssetPath(string rawPath)
    {
        if (string.IsNullOrWhiteSpace(rawPath))
        {
            return null;
        }

        string normalized = rawPath.Replace('\\', '/').Trim();
        if (!normalized.StartsWith("Assets/", StringComparison.OrdinalIgnoreCase))
        {
            return null;
        }

        if (!normalized.EndsWith(".prefab", StringComparison.OrdinalIgnoreCase))
        {
            normalized += ".prefab";
        }

        return normalized;
    }

    public static string? NormalizeResourcesPath(string rawPath)
    {
        if (string.IsNullOrWhiteSpace(rawPath))
        {
            return null;
        }

        string normalized = rawPath.Replace('\\', '/').Trim();
        if (normalized.EndsWith(".prefab", StringComparison.OrdinalIgnoreCase))
        {
            normalized = normalized[..^7];
        }

        const string resourcesPrefix = "Resources/";
        int resourcesIndex = normalized.IndexOf(resourcesPrefix, StringComparison.OrdinalIgnoreCase);
        if (resourcesIndex >= 0)
        {
            return normalized[(resourcesIndex + resourcesPrefix.Length)..];
        }

        return normalized.StartsWith("Assets/", StringComparison.OrdinalIgnoreCase) ? null : normalized;
    }
}
