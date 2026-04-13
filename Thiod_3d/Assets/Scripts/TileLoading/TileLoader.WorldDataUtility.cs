using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using UnityEngine;
using WorldGen;

#nullable enable

namespace Thiod.TileLoading.Runtime
{

internal static class TileLoaderWorldDataUtility
{
    public static GenerationSettings ResolveGenerationSettings(TerrainBuildContext context, IReadOnlyDictionary<string, object> metadata)
    {
        int tileSize = context.FallbackTileSize;
        int hillSpacing = context.FallbackHillSpacing;
        double hillStrength = context.FallbackHillStrength;

        if (context.UseMetadataGenerationSettings && metadata != null)
        {
            IReadOnlyDictionary<string, object> config = TryGetDictionary(metadata, "config");
            UpdateIntFromMetadata(metadata, config, "tile_size", "tileSize", ref tileSize);
            UpdateIntFromMetadata(metadata, config, "hill_spacing", "hillSpacing", ref hillSpacing);
            UpdateDoubleFromMetadata(metadata, config, "hill_strength", "hillStrength", ref hillStrength);
        }

        return new GenerationSettings(tileSize, hillSpacing, hillStrength);
    }

    public static LoadedWorldData ReconstructWorldData(Dictionary<string, object> raw)
    {
        IReadOnlyDictionary<string, object> metadata = TryGetDictionary(raw, "metadata");
        IReadOnlyDictionary<string, object> coordinateData = TryGetDictionary(raw, "data");

        int width = GetInt(metadata, "width", 200);
        int height = GetInt(metadata, "height", 200);
        int seed = GetInt(metadata, "seed", 0);
        double globalMinHeight = double.MaxValue;
        double globalMaxHeight = double.MinValue;

        double[][] elevation = CreateJagged<double>(height, width, 0d);
        int[][] biome = CreateJagged<int>(height, width, 0);
        double[][] temperature = CreateJagged<double>(height, width, 0d);
        double[][] humidity = CreateJagged<double>(height, width, 0d);
        double[][] tectonic = CreateJagged<double>(height, width, 0d);
        double[][] rivers = CreateJagged<double>(height, width, 0d);
        double[][] lakes = CreateJagged<double>(height, width, 0d);
        double[][] wind = CreateJagged<double>(height, width, 0d);
        RiverRasterization.RiverDirectionInfo?[][] riverDirection = CreateJagged<RiverRasterization.RiverDirectionInfo?>(height, width, null);
        double[][] seaCurrents = CreateJagged<double>(height, width, 0d);
        int[][] heightmapType = CreateJagged<int>(height, width, 0);
        string[][][] waterDirection = CreateJagged<string[]>(height, width, Array.Empty<string>());

        int halfWidth = width / 2;
        int halfHeight = height / 2;

        foreach ((string key, object value) in coordinateData)
        {
            IReadOnlyDictionary<string, object> pointData = TryGetDictionary(value);
            if (!TryParseCoordinates(key, halfWidth, halfHeight, out int x, out int y))
            {
                continue;
            }

            if (y >= height || x >= width)
            {
                continue;
            }

            elevation[y][x] = GetDouble(pointData, "elevation", 0d);
            biome[y][x] = GetInt(pointData, "biome", 0);
            temperature[y][x] = GetDouble(pointData, "temperature", 0d);
            humidity[y][x] = GetDouble(pointData, "humidity", 0d);
            tectonic[y][x] = GetDouble(pointData, "roughness", 0d);
            rivers[y][x] = GetDouble(pointData, "river", 0d);
            lakes[y][x] = GetDouble(pointData, "lake", 0d);
            wind[y][x] = GetDouble(pointData, "wind", 0d);

            globalMinHeight = Math.Min(globalMinHeight, elevation[y][x]);
            globalMaxHeight = Math.Max(globalMaxHeight, elevation[y][x]);

            if (TryGetObject(pointData, "river_direction", out object? riverObject))
            {
                IReadOnlyDictionary<string, object> riverData = TryGetDictionary(riverObject);
                riverDirection[y][x] = new RiverRasterization.RiverDirectionInfo
                {
                    Inputs = ToDoubleDictionary(GetValue(riverData, "inputs", null)),
                    Outputs = ToDoubleDictionary(GetValue(riverData, "outputs", null)),
                    SinkType = GetValue(riverData, "sink_type", string.Empty)?.ToString(),
                    SourceType = GetValue(riverData, "source_type", string.Empty)?.ToString(),
                };
            }

            if (TryGetObject(pointData, "sea_current", out object? seaCurrent))
            {
                seaCurrents[y][x] = ConvertToDouble(seaCurrent, 0d);
            }

            if (TryGetObject(pointData, "heightmap_type", out object? typeObject))
            {
                heightmapType[y][x] = ConvertToInt(typeObject, 0);
            }

            if (TryGetObject(pointData, "water_direction", out object? directionObject))
            {
                waterDirection[y][x] = ToStringArray(directionObject);
            }
        }

        var worldData = new Dictionary<string, object>(StringComparer.Ordinal)
        {
            ["elevation"] = elevation,
            ["biome"] = biome,
            ["temperature"] = temperature,
            ["humidity"] = humidity,
            ["tectonic"] = tectonic,
            ["rivers"] = rivers,
            ["lakes"] = lakes,
            ["wind"] = wind,
            ["config"] = TryGetDictionary(metadata, "config"),
        };

        if (riverDirection.Any(row => row.Any(cell => cell != null)))
        {
            worldData["river_direction"] = riverDirection;
        }

        if (seaCurrents.Any(row => row.Any(value => Math.Abs(value) > double.Epsilon)))
        {
            worldData["sea_currents"] = seaCurrents;
        }

        if (waterDirection.Any(row => row.Any(cell => cell != null && cell.Length > 0)))
        {
            worldData["water_direction"] = waterDirection;
        }

        if (heightmapType.Any(row => row.Any(value => value != 0)))
        {
            worldData["heightmap_type"] = heightmapType;
        }

        if (double.IsInfinity(globalMinHeight) || double.IsInfinity(globalMaxHeight))
        {
            globalMinHeight = 0d;
            globalMaxHeight = 1d;
        }

        return new LoadedWorldData(worldData, metadata, seed, globalMinHeight, globalMaxHeight);
    }

    public static string ResolveWorldDataFilePath(string configuredPath)
    {
        if (string.IsNullOrWhiteSpace(configuredPath))
        {
            return string.Empty;
        }

        if (Path.IsPathRooted(configuredPath))
        {
            return configuredPath;
        }

        string relativePath = configuredPath.TrimStart('.', Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar);
        string[] candidates =
        {
            Path.Combine(Application.dataPath, relativePath),
            Path.Combine(Application.streamingAssetsPath, relativePath),
            Path.Combine(Application.persistentDataPath, relativePath),
            Path.Combine(Application.dataPath, Path.GetFileName(relativePath)),
            Path.Combine(Application.streamingAssetsPath, Path.GetFileName(relativePath)),
        };

        foreach (string candidate in candidates)
        {
            if (File.Exists(candidate))
            {
                return candidate;
            }
        }

        return candidates[0];
    }

    private static void UpdateIntFromMetadata(
        IReadOnlyDictionary<string, object> metadata,
        IReadOnlyDictionary<string, object> config,
        string snakeCaseKey,
        string camelCaseKey,
        ref int value)
    {
        if (TryGetInt(metadata, snakeCaseKey, out int metadataValue) || TryGetInt(metadata, camelCaseKey, out metadataValue))
        {
            value = metadataValue;
            return;
        }

        if (TryGetInt(config, snakeCaseKey, out int configValue) || TryGetInt(config, camelCaseKey, out configValue))
        {
            value = configValue;
        }
    }

    private static void UpdateDoubleFromMetadata(
        IReadOnlyDictionary<string, object> metadata,
        IReadOnlyDictionary<string, object> config,
        string snakeCaseKey,
        string camelCaseKey,
        ref double value)
    {
        if (TryGetDouble(metadata, snakeCaseKey, out double metadataValue) || TryGetDouble(metadata, camelCaseKey, out metadataValue))
        {
            value = metadataValue;
            return;
        }

        if (TryGetDouble(config, snakeCaseKey, out double configValue) || TryGetDouble(config, camelCaseKey, out configValue))
        {
            value = configValue;
        }
    }

    private static bool TryParseCoordinates(string key, int halfWidth, int halfHeight, out int x, out int y)
    {
        x = 0;
        y = 0;

        if (string.IsNullOrWhiteSpace(key))
        {
            return false;
        }

        string trimmed = key.Trim('[', ']');
        string[] parts = trimmed.Split(',');
        if (parts.Length != 2)
        {
            return false;
        }

        if (!int.TryParse(parts[0], NumberStyles.Integer, CultureInfo.InvariantCulture, out int centeredX) ||
            !int.TryParse(parts[1], NumberStyles.Integer, CultureInfo.InvariantCulture, out int centeredY))
        {
            return false;
        }

        x = centeredX + halfWidth;
        y = centeredY + halfHeight;
        return x >= 0 && y >= 0;
    }

    private static T[][] CreateJagged<T>(int height, int width, T defaultValue)
    {
        var values = new T[height][];
        for (int y = 0; y < height; y++)
        {
            values[y] = Enumerable.Repeat(defaultValue, width).ToArray();
        }

        return values;
    }

    private static IReadOnlyDictionary<string, object> TryGetDictionary(IReadOnlyDictionary<string, object> source, string key)
    {
        if (source != null && source.TryGetValue(key, out object value))
        {
            return TryGetDictionary(value);
        }

        return new Dictionary<string, object>(StringComparer.Ordinal);
    }

    private static IReadOnlyDictionary<string, object> TryGetDictionary(object? value)
    {
        if (value is IReadOnlyDictionary<string, object> readOnlyStringDict)
        {
            return readOnlyStringDict;
        }

        if (value is Dictionary<string, object> stringDict)
        {
            return stringDict;
        }

        if (value is IReadOnlyDictionary<object, object> readOnlyObjectDict)
        {
            var converted = new Dictionary<string, object>(StringComparer.Ordinal);
            foreach ((object key, object itemValue) in readOnlyObjectDict)
            {
                converted[key?.ToString() ?? string.Empty] = itemValue;
            }

            return converted;
        }

        if (value is IDictionary<object, object> objectDict)
        {
            var converted = new Dictionary<string, object>(StringComparer.Ordinal);
            foreach ((object key, object itemValue) in objectDict)
            {
                converted[key?.ToString() ?? string.Empty] = itemValue;
            }

            return converted;
        }

        return new Dictionary<string, object>(StringComparer.Ordinal);
    }

    private static object? GetValue(IReadOnlyDictionary<string, object> source, string key, object? fallback)
    {
        return source != null && source.TryGetValue(key, out object value) ? value : fallback;
    }

    private static bool TryGetObject(IReadOnlyDictionary<string, object> source, string key, out object? value)
    {
        if (source != null && source.TryGetValue(key, out value))
        {
            return true;
        }

        value = null;
        return false;
    }

    private static int GetInt(IReadOnlyDictionary<string, object> source, string key, int fallback)
    {
        return source != null && source.TryGetValue(key, out object value) ? ConvertToInt(value, fallback) : fallback;
    }

    private static double GetDouble(IReadOnlyDictionary<string, object> source, string key, double fallback)
    {
        return source != null && source.TryGetValue(key, out object value) ? ConvertToDouble(value, fallback) : fallback;
    }

    private static bool TryGetInt(IReadOnlyDictionary<string, object> source, string key, out int value)
    {
        if (source != null && source.TryGetValue(key, out object raw))
        {
            value = ConvertToInt(raw, 0);
            return true;
        }

        value = 0;
        return false;
    }

    private static bool TryGetDouble(IReadOnlyDictionary<string, object> source, string key, out double value)
    {
        if (source != null && source.TryGetValue(key, out object raw))
        {
            value = ConvertToDouble(raw, 0d);
            return true;
        }

        value = 0d;
        return false;
    }

    private static int ConvertToInt(object? value, int fallback)
    {
        try
        {
            return Convert.ToInt32(value, CultureInfo.InvariantCulture);
        }
        catch
        {
            return fallback;
        }
    }

    private static double ConvertToDouble(object? value, double fallback)
    {
        try
        {
            return Convert.ToDouble(value, CultureInfo.InvariantCulture);
        }
        catch
        {
            return fallback;
        }
    }

    private static Dictionary<string, double> ToDoubleDictionary(object? value)
    {
        IReadOnlyDictionary<string, object> dictionary = TryGetDictionary(value);
        var result = new Dictionary<string, double>(StringComparer.Ordinal);
        foreach ((string key, object itemValue) in dictionary)
        {
            result[key] = ConvertToDouble(itemValue, 0d);
        }

        return result;
    }

    private static string[] ToStringArray(object? value)
    {
        if (value is string[] stringArray)
        {
            return stringArray;
        }

        if (value is IEnumerable<object> objectEnumerable)
        {
            return objectEnumerable.Select(item => item?.ToString() ?? string.Empty).ToArray();
        }

        if (value is IEnumerable<string> stringEnumerable)
        {
            return stringEnumerable.ToArray();
        }

        return Array.Empty<string>();
    }
}

}
