using TheVisualEngine;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

public static class TVETerrainBiomePainter
{
    private const string GrassLayerPath = "Assets/BOXOPHOBIC/The Visual Engine/Demo/Terrain/Terrain Layer Grass.terrainlayer";
    private const string MossLayerPath = "Assets/BOXOPHOBIC/The Visual Engine/Demo/Terrain/Terrain Layer Moss.terrainlayer";
    private const string CliffsLayerPath = "Assets/BOXOPHOBIC/The Visual Engine/Demo/Terrain/Terrain Layer Cliffs.terrainlayer";
    private const string SnowLayerPath = "Assets/BOXOPHOBIC/The Visual Engine/Demo/Terrain/Terrain Layer Snow.terrainlayer";

    [MenuItem("Tools/Thiod/TVE/Auto Paint Selected Terrain")]
    private static void AutoPaintSelectedTerrain()
    {
        var terrain = Selection.activeGameObject != null ? Selection.activeGameObject.GetComponent<Terrain>() : null;
        if (terrain == null)
        {
            Debug.LogWarning("Select a Terrain GameObject first.");
            return;
        }

        PaintTerrain(terrain);
    }

    [MenuItem("Tools/Thiod/TVE/Auto Paint All TVE Terrains")]
    private static void AutoPaintAllTVETerrains()
    {
        var terrains = Object.FindObjectsByType<Terrain>(FindObjectsInactive.Exclude, FindObjectsSortMode.None);
        var paintedAny = false;

        foreach (var terrain in terrains)
        {
            if (terrain.GetComponent<TVETerrain>() == null)
            {
                continue;
            }

            PaintTerrain(terrain);
            paintedAny = true;
        }

        if (!paintedAny)
        {
            Debug.LogWarning("No active terrains with TVETerrain were found.");
        }
    }

    private static void PaintTerrain(Terrain terrain)
    {
        var terrainData = terrain.terrainData;
        if (terrainData == null)
        {
            Debug.LogError($"Terrain '{terrain.name}' has no TerrainData.");
            return;
        }

        var layers = new[]
        {
            LoadLayer(GrassLayerPath),
            LoadLayer(MossLayerPath),
            LoadLayer(CliffsLayerPath),
            LoadLayer(SnowLayerPath),
        };

        for (var i = 0; i < layers.Length; i++)
        {
            if (layers[i] == null)
            {
                Debug.LogError($"Missing terrain layer at expected path: {GetLayerPathForIndex(i)}");
                return;
            }
        }

        Undo.RegisterCompleteObjectUndo(terrainData, "Auto Paint TVE Terrain");

        terrainData.terrainLayers = layers;

        var alphaWidth = terrainData.alphamapWidth;
        var alphaHeight = terrainData.alphamapHeight;
        var alphamaps = new float[alphaHeight, alphaWidth, layers.Length];

        for (var y = 0; y < alphaHeight; y++)
        {
            for (var x = 0; x < alphaWidth; x++)
            {
                var normalizedX = x / (float)(alphaWidth - 1);
                var normalizedY = y / (float)(alphaHeight - 1);

                var height01 = terrainData.GetInterpolatedHeight(normalizedX, normalizedY) / terrainData.size.y;
                var slope01 = terrainData.GetSteepness(normalizedX, normalizedY) / 90f;

                var valleyGrass = Mathf.Clamp01((1f - SmoothStep(0.18f, 0.52f, height01)) * (1f - slope01 * 1.6f));
                var midMoss = Mathf.Clamp01(Band(height01, 0.18f, 0.36f, 0.62f, 0.78f) * (1f - slope01 * 1.25f));
                var rockySlopes = Mathf.Clamp01(SmoothStep(0.22f, 0.58f, slope01) * (1f - SmoothStep(0.82f, 0.98f, height01) * 0.35f));
                var highSnow = Mathf.Clamp01(Mathf.Max(
                    SmoothStep(0.62f, 0.9f, height01) * (0.7f + (1f - slope01) * 0.3f),
                    SmoothStep(0.8f, 0.96f, height01) * SmoothStep(0.18f, 0.5f, slope01) * 0.45f));

                var sum = valleyGrass + midMoss + rockySlopes + highSnow;
                if (sum <= 0.0001f)
                {
                    valleyGrass = 1f;
                    sum = 1f;
                }

                alphamaps[y, x, 0] = valleyGrass / sum;
                alphamaps[y, x, 1] = midMoss / sum;
                alphamaps[y, x, 2] = rockySlopes / sum;
                alphamaps[y, x, 3] = highSnow / sum;
            }
        }

        terrainData.SetAlphamaps(0, 0, alphamaps);
        EditorUtility.SetDirty(terrainData);

        var tveTerrain = terrain.GetComponent<TVETerrain>();
        if (tveTerrain != null)
        {
            tveTerrain.InitializeTerrain();
            tveTerrain.DestroyProxyTextures();
            tveTerrain.TryGetProxyTextures();
            tveTerrain.CreateProxyTextures(true);
            tveTerrain.UpdateProxySettings();
            EditorUtility.SetDirty(tveTerrain);
        }

        EditorSceneManager.MarkSceneDirty(SceneManager.GetActiveScene());
        AssetDatabase.SaveAssets();

        Debug.Log($"Auto-painted terrain '{terrain.name}' with TVE demo biome layers.");
    }

    private static TerrainLayer LoadLayer(string path)
    {
        return AssetDatabase.LoadAssetAtPath<TerrainLayer>(path);
    }

    private static string GetLayerPathForIndex(int index)
    {
        return index switch
        {
            0 => GrassLayerPath,
            1 => MossLayerPath,
            2 => CliffsLayerPath,
            3 => SnowLayerPath,
            _ => string.Empty,
        };
    }

    private static float SmoothStep(float min, float max, float value)
    {
        return Mathf.SmoothStep(0f, 1f, Mathf.InverseLerp(min, max, value));
    }

    private static float Band(float value, float start, float riseEnd, float fallStart, float end)
    {
        var rise = SmoothStep(start, riseEnd, value);
        var fall = 1f - SmoothStep(fallStart, end, value);
        return Mathf.Clamp01(rise * fall);
    }
}
