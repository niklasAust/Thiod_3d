using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Reflection;
using UnityEditor;
using UnityEngine;
using Thiod.TileLoading.Runtime;
using WorldGen;

#nullable enable

public static class TileHeightmapExportUtility
{
    private const string OutputDirectory = "Assets/Screenshots/HeightmapExports";

    [MenuItem("Tools/Thiod/Export Current Tile Heightmaps")]
    public static void ExportCurrentTileHeightmaps()
    {
        TileLoader? tileLoader = UnityEngine.Object.FindFirstObjectByType<TileLoader>();
        if (tileLoader == null)
        {
            Debug.LogError("TileHeightmapExportUtility could not find a TileLoader in the active scene.");
            return;
        }

        try
        {
            TileLayers layers = GenerateTileLayersFromLoader(tileLoader);
            Directory.CreateDirectory(Path.GetFullPath(OutputDirectory));

            string timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss", CultureInfo.InvariantCulture);
            string baseName = $"tile_{layers.TileX}_{layers.TileY}_{timestamp}";

            string heightmapPath = Path.Combine(OutputDirectory, baseName + "_heightmap.png");
            string riverDepthPath = Path.Combine(OutputDirectory, baseName + "_river_depth.png");
            string riverMaskPath = Path.Combine(OutputDirectory, baseName + "_river_mask.png");
            string heightmapCsvPath = Path.Combine(OutputDirectory, baseName + "_heightmap.csv");
            string riverDepthCsvPath = Path.Combine(OutputDirectory, baseName + "_river_depth.csv");
            string riverMaskCsvPath = Path.Combine(OutputDirectory, baseName + "_river_mask.csv");
            string riverFlowXCsvPath = Path.Combine(OutputDirectory, baseName + "_river_flow_x.csv");
            string riverFlowYCsvPath = Path.Combine(OutputDirectory, baseName + "_river_flow_y.csv");
            string riverProgressCsvPath = Path.Combine(OutputDirectory, baseName + "_river_progress.csv");

            WriteHeightmapPng(layers.Heightmap, heightmapPath);
            WriteDoubleCsv(layers.Heightmap, heightmapCsvPath);
            if (layers.RiverHeightmap != null)
            {
                WriteGrayscalePng(layers.RiverHeightmap, riverDepthPath);
                WriteDoubleCsv(layers.RiverHeightmap, riverDepthCsvPath);
            }

            if (layers.RiverMask != null)
            {
                WriteMaskPng(layers.RiverMask, riverMaskPath);
                WriteMaskCsv(layers.RiverMask, riverMaskCsvPath);
            }

            if (layers.RiverFlowX != null && layers.RiverFlowY != null)
            {
                WriteDoubleCsv(layers.RiverFlowX, riverFlowXCsvPath);
                WriteDoubleCsv(layers.RiverFlowY, riverFlowYCsvPath);
            }

            if (layers.RiverProgressMap != null)
            {
                WriteDoubleCsv(layers.RiverProgressMap, riverProgressCsvPath);
            }

            AssetDatabase.Refresh();
            Debug.Log(
                $"Exported tile heightmaps to '{OutputDirectory}'. Heightmap: {heightmapPath}, RiverDepth: {riverDepthPath}, RiverMask: {riverMaskPath}",
                tileLoader);
        }
        catch (Exception ex)
        {
            Debug.LogException(ex, tileLoader);
        }
    }

    private static TileLayers GenerateTileLayersFromLoader(TileLoader tileLoader)
    {
        Type loaderType = typeof(TileLoader);
        string configuredPath = (string)(GetFieldValue(loaderType, tileLoader, "worldDataFile") ?? "test_map.msgpack");
        string filePath = (string)InvokeInstanceMethod(loaderType, tileLoader, "ResolveWorldDataFilePath", configuredPath)!;
        Dictionary<string, object> rawWorldData = WorldGenerator.LoadWorldDataBinary(filePath);

        object loadedWorldData = InvokeInstanceMethod(loaderType, tileLoader, "ReconstructWorldData", rawWorldData)!;
        object metadata = GetPropertyValue(loadedWorldData.GetType(), loadedWorldData, "Metadata")!;
        object settings = InvokeInstanceMethod(loaderType, tileLoader, "ResolveGenerationSettings", metadata)!;

        int tileSize = (int)GetPropertyValue(settings.GetType(), settings, "TileSize")!;
        int hillSpacing = (int)GetPropertyValue(settings.GetType(), settings, "HillSpacing")!;
        double hillStrength = Convert.ToDouble(
            GetPropertyValue(settings.GetType(), settings, "HillStrength")!,
            CultureInfo.InvariantCulture);

        var worldData = (Dictionary<string, object>)GetPropertyValue(loadedWorldData.GetType(), loadedWorldData, "WorldData")!;
        int seed = (int)GetPropertyValue(loadedWorldData.GetType(), loadedWorldData, "Seed")!;

        Vector3Int unityTileCoordinate = (Vector3Int)(GetFieldValue(loaderType, tileLoader, "unityTileCoordinate") ?? Vector3Int.zero);
        bool invertUnityYForWorldGen = (bool)(GetFieldValue(loaderType, tileLoader, "invertUnityYForWorldGen") ?? true);
        int worldTileY = invertUnityYForWorldGen ? -unityTileCoordinate.y : unityTileCoordinate.y;

        var tileGenerator = new TileGenerator(worldData, seed);
        InvokeInstanceMethod(loaderType, tileLoader, "ConfigureTileGenerator", tileGenerator);
        return tileGenerator.GenerateTileLayers(
            unityTileCoordinate.x,
            worldTileY,
            tileSize,
            hillSpacing,
            hillStrength);
    }

    private static void WriteHeightmapPng(double[,] heightmap, string assetPath)
    {
        int height = heightmap.GetLength(0);
        int width = heightmap.GetLength(1);
        double min = double.MaxValue;
        double max = double.MinValue;

        for (int y = 0; y < height; y++)
        {
            for (int x = 0; x < width; x++)
            {
                double value = heightmap[y, x];
                min = Math.Min(min, value);
                max = Math.Max(max, value);
            }
        }

        WritePng(heightmap, assetPath, min, max);
    }

    private static void WriteGrayscalePng(double[,] values, string assetPath)
    {
        int height = values.GetLength(0);
        int width = values.GetLength(1);
        double min = double.MaxValue;
        double max = double.MinValue;

        for (int y = 0; y < height; y++)
        {
            for (int x = 0; x < width; x++)
            {
                double value = values[y, x];
                min = Math.Min(min, value);
                max = Math.Max(max, value);
            }
        }

        WritePng(values, assetPath, min, max);
    }

    private static void WritePng(double[,] values, string assetPath, double min, double max)
    {
        int height = values.GetLength(0);
        int width = values.GetLength(1);
        double range = Math.Max(1e-6, max - min);
        var texture = new Texture2D(width, height, TextureFormat.RGBA32, false, true);
        var pixels = new Color32[width * height];

        for (int y = 0; y < height; y++)
        {
            for (int x = 0; x < width; x++)
            {
                double normalized = Math.Clamp((values[y, x] - min) / range, 0.0, 1.0);
                byte intensity = (byte)Math.Clamp(Math.Round(normalized * 255.0), 0, 255);
                int flippedY = height - 1 - y;
                pixels[flippedY * width + x] = new Color32(intensity, intensity, intensity, 255);
            }
        }

        texture.SetPixels32(pixels);
        texture.Apply(false, false);
        File.WriteAllBytes(Path.GetFullPath(assetPath), texture.EncodeToPNG());
        UnityEngine.Object.DestroyImmediate(texture);
    }

    private static void WriteMaskPng(bool[,] mask, string assetPath)
    {
        int height = mask.GetLength(0);
        int width = mask.GetLength(1);
        var texture = new Texture2D(width, height, TextureFormat.RGBA32, false, true);
        var pixels = new Color32[width * height];

        for (int y = 0; y < height; y++)
        {
            for (int x = 0; x < width; x++)
            {
                byte intensity = mask[y, x] ? (byte)255 : (byte)0;
                int flippedY = height - 1 - y;
                pixels[flippedY * width + x] = new Color32(intensity, intensity, intensity, 255);
            }
        }

        texture.SetPixels32(pixels);
        texture.Apply(false, false);
        File.WriteAllBytes(Path.GetFullPath(assetPath), texture.EncodeToPNG());
        UnityEngine.Object.DestroyImmediate(texture);
    }

    private static void WriteDoubleCsv(double[,] values, string assetPath)
    {
        int height = values.GetLength(0);
        int width = values.GetLength(1);
        using var writer = new StreamWriter(Path.GetFullPath(assetPath), false);

        for (int y = 0; y < height; y++)
        {
            for (int x = 0; x < width; x++)
            {
                if (x > 0)
                {
                    writer.Write(',');
                }

                writer.Write(values[y, x].ToString("G17", CultureInfo.InvariantCulture));
            }

            writer.WriteLine();
        }
    }

    private static void WriteMaskCsv(bool[,] mask, string assetPath)
    {
        int height = mask.GetLength(0);
        int width = mask.GetLength(1);
        using var writer = new StreamWriter(Path.GetFullPath(assetPath), false);

        for (int y = 0; y < height; y++)
        {
            for (int x = 0; x < width; x++)
            {
                if (x > 0)
                {
                    writer.Write(',');
                }

                writer.Write(mask[y, x] ? '1' : '0');
            }

            writer.WriteLine();
        }
    }

    private static object? GetFieldValue(Type type, object instance, string fieldName)
    {
        FieldInfo? field = type.GetField(fieldName, BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.Public);
        return field?.GetValue(instance);
    }

    private static object? GetPropertyValue(Type type, object instance, string propertyName)
    {
        PropertyInfo? property = type.GetProperty(propertyName, BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.Public);
        return property?.GetValue(instance);
    }

    private static object? InvokeInstanceMethod(Type type, object instance, string methodName, params object?[]? args)
    {
        MethodInfo? method = type.GetMethod(methodName, BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.Public);
        if (method == null)
        {
            throw new MissingMethodException(type.FullName, methodName);
        }

        return method.Invoke(instance, args);
    }
}
