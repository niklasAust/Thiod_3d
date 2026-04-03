using System.IO;
using TheVisualEngine;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

public static class TVEFoliageBlendSetup
{
    private const string FallbackObjectName = "SM_Gen_Env_Bush_Part_05";
    private const string TemplateMaterialPath = "Assets/BOXOPHOBIC/The Visual Engine/Demo/Prefabs/Prefabs Data/Materials/RedBush (TVE Material).mat";
    private const string OutputFolder = "Assets/Materials/TVE";

    [MenuItem("Tools/Thiod/TVE/Setup Selected Foliage Blend")]
    private static void SetupSelectedFoliageBlend()
    {
        var target = Selection.activeGameObject;
        if (target == null)
        {
            target = GameObject.Find(FallbackObjectName);
        }

        if (target == null)
        {
            Debug.LogWarning("Select a foliage GameObject first.");
            return;
        }

        ApplyBlendSetup(target);
    }

    private static void ApplyBlendSetup(GameObject target)
    {
        var renderer = target.GetComponent<Renderer>();
        if (renderer == null)
        {
            Debug.LogError($"GameObject '{target.name}' does not have a Renderer.");
            return;
        }

        var sourceMaterial = renderer.sharedMaterial;
        if (sourceMaterial == null)
        {
            Debug.LogError($"GameObject '{target.name}' does not have a source material.");
            return;
        }

        var templateMaterial = AssetDatabase.LoadAssetAtPath<Material>(TemplateMaterialPath);
        if (templateMaterial == null)
        {
            Debug.LogError($"Missing TVE template material at '{TemplateMaterialPath}'.");
            return;
        }

        EnsureFolderExists(OutputFolder);

        var outputPath = $"{OutputFolder}/{SanitizeAssetName(target.name)}_TVE.mat";
        if (!File.Exists(outputPath))
        {
            AssetDatabase.CopyAsset(TemplateMaterialPath, outputPath);
        }

        var material = AssetDatabase.LoadAssetAtPath<Material>(outputPath);
        if (material == null)
        {
            Debug.LogError($"Failed to load or create material '{outputPath}'.");
            return;
        }

        Undo.RecordObject(renderer, "Setup TVE Foliage Blend");
        Undo.RecordObject(material, "Setup TVE Foliage Blend");

        CopySourceTextures(sourceMaterial, material);
        ConfigureTVEFoliageMaterial(material, target.transform.position);

        renderer.sharedMaterial = material;
        EditorUtility.SetDirty(renderer);
        EditorUtility.SetDirty(material);

        AssetDatabase.SaveAssets();
        EditorSceneManager.MarkSceneDirty(SceneManager.GetActiveScene());

        Debug.Log($"Configured '{target.name}' to use TVE foliage blending material '{outputPath}'.");
    }

    private static void CopySourceTextures(Material source, Material destination)
    {
        var albedo = GetTexture(source, "_Albedo_Map", "_BaseMap", "_MainTex");
        var normal = GetTexture(source, "_Normal_Map", "_BumpMap");

        SetTextureIfPresent(destination, albedo, "_AlbedoTex", "_BaseColorMap");
        SetTextureIfPresent(destination, normal, "_BumpMap");
    }

    private static void ConfigureTVEFoliageMaterial(Material material, Vector3 worldPosition)
    {
        material.name = Path.GetFileNameWithoutExtension(AssetDatabase.GetAssetPath(material));

        SetFloatIfPresent(material, 0.45f, "_TintingIntensityValue");
        SetFloatIfPresent(material, 1f, "_TintingBlendAlbedoValue");
        SetFloatIfPresent(material, 0f, "_TintingElementMode");
        SetFloatIfPresent(material, 0f, "_TintingMeshValue");
        SetFloatIfPresent(material, 0.55f, "_OcclusionIntensityValue");
        SetFloatIfPresent(material, 0.18f, "_FlattenIntensityValue");
        SetFloatIfPresent(material, 0.5f, "_Cutoff");

        material.EnableKeyword("TVE_TINTING");
        material.EnableKeyword("TVE_OCCLUSION");
        material.EnableKeyword("TVE_FLATTEN");

        var terrainColor = SampleTerrainTint(worldPosition);
        var tintColor = Color.Lerp(Color.white, terrainColor, 0.3f);
        var shadowColor = Color.Lerp(terrainColor * 0.4f, Color.black, 0.2f);

        SetColorIfPresent(material, tintColor, "_TintingColor");
        SetColorIfPresent(material, Color.white, "_OcclusionColorOne");
        SetColorIfPresent(material, shadowColor, "_OcclusionColorTwo");

        if (material.HasProperty("_BaseColor"))
        {
            material.SetColor("_BaseColor", Color.white);
        }

        if (material.HasProperty("_Color"))
        {
            material.SetColor("_Color", Color.white);
        }
    }

    private static Color SampleTerrainTint(Vector3 worldPosition)
    {
        var terrain = FindTerrainAt(worldPosition);
        if (terrain == null || terrain.terrainData == null || terrain.terrainData.alphamapLayers == 0)
        {
            return new Color(0.72f, 0.86f, 0.68f, 1f);
        }

        var terrainData = terrain.terrainData;
        var terrainPosition = terrain.transform.position;
        var localX = Mathf.InverseLerp(terrainPosition.x, terrainPosition.x + terrainData.size.x, worldPosition.x);
        var localZ = Mathf.InverseLerp(terrainPosition.z, terrainPosition.z + terrainData.size.z, worldPosition.z);

        var mapX = Mathf.Clamp(Mathf.RoundToInt(localX * (terrainData.alphamapWidth - 1)), 0, terrainData.alphamapWidth - 1);
        var mapZ = Mathf.Clamp(Mathf.RoundToInt(localZ * (terrainData.alphamapHeight - 1)), 0, terrainData.alphamapHeight - 1);
        var weights = terrainData.GetAlphamaps(mapX, mapZ, 1, 1);

        var color = Color.black;
        var layers = terrainData.terrainLayers;

        for (var i = 0; i < terrainData.alphamapLayers && i < layers.Length; i++)
        {
            color += GuessLayerColor(layers[i]) * weights[0, 0, i];
        }

        if (color.maxColorComponent <= 0.001f)
        {
            return new Color(0.72f, 0.86f, 0.68f, 1f);
        }

        color.a = 1f;
        return color;
    }

    private static Terrain FindTerrainAt(Vector3 worldPosition)
    {
        foreach (var terrain in Terrain.activeTerrains)
        {
            if (terrain == null || terrain.terrainData == null)
            {
                continue;
            }

            var pos = terrain.transform.position;
            var size = terrain.terrainData.size;
            if (worldPosition.x >= pos.x && worldPosition.x <= pos.x + size.x &&
                worldPosition.z >= pos.z && worldPosition.z <= pos.z + size.z)
            {
                return terrain;
            }
        }

        return Terrain.activeTerrain;
    }

    private static Color GuessLayerColor(TerrainLayer layer)
    {
        if (layer == null)
        {
            return Color.white;
        }

        var name = layer.name.ToLowerInvariant();
        if (name.Contains("snow"))
        {
            return new Color(0.95f, 0.97f, 1f, 1f);
        }

        if (name.Contains("cliff") || name.Contains("rock") || name.Contains("pebble"))
        {
            return new Color(0.68f, 0.69f, 0.67f, 1f);
        }

        if (name.Contains("moss"))
        {
            return new Color(0.56f, 0.7f, 0.46f, 1f);
        }

        if (name.Contains("mud"))
        {
            return new Color(0.5f, 0.4f, 0.3f, 1f);
        }

        if (name.Contains("sand") || name.Contains("beach"))
        {
            return new Color(0.82f, 0.74f, 0.56f, 1f);
        }

        return new Color(0.72f, 0.86f, 0.68f, 1f);
    }

    private static Texture GetTexture(Material material, params string[] propertyNames)
    {
        foreach (var propertyName in propertyNames)
        {
            if (material.HasProperty(propertyName))
            {
                var texture = material.GetTexture(propertyName);
                if (texture != null)
                {
                    return texture;
                }
            }
        }

        return null;
    }

    private static void SetTextureIfPresent(Material material, Texture texture, params string[] propertyNames)
    {
        if (texture == null)
        {
            return;
        }

        foreach (var propertyName in propertyNames)
        {
            if (material.HasProperty(propertyName))
            {
                material.SetTexture(propertyName, texture);
            }
        }
    }

    private static void SetFloatIfPresent(Material material, float value, params string[] propertyNames)
    {
        foreach (var propertyName in propertyNames)
        {
            if (material.HasProperty(propertyName))
            {
                material.SetFloat(propertyName, value);
            }
        }
    }

    private static void SetColorIfPresent(Material material, Color value, params string[] propertyNames)
    {
        foreach (var propertyName in propertyNames)
        {
            if (material.HasProperty(propertyName))
            {
                material.SetColor(propertyName, value);
            }
        }
    }

    private static void EnsureFolderExists(string assetFolder)
    {
        var parts = assetFolder.Split('/');
        var current = parts[0];

        for (var i = 1; i < parts.Length; i++)
        {
            var next = $"{current}/{parts[i]}";
            if (!AssetDatabase.IsValidFolder(next))
            {
                AssetDatabase.CreateFolder(current, parts[i]);
            }

            current = next;
        }
    }

    private static string SanitizeAssetName(string value)
    {
        foreach (var invalidChar in Path.GetInvalidFileNameChars())
        {
            value = value.Replace(invalidChar, '_');
        }

        return value.Replace(' ', '_');
    }
}
