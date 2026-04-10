using System;
using UnityEngine;
using WorldGen;

#nullable enable

internal static class TileLoaderTerrainMathUtility
{
    public static float[,] BuildNormalizedHeights(double[,] sourceHeightmap, double maxTileHeightUnits)
    {
        int resolutionY = sourceHeightmap.GetLength(0);
        int resolutionX = sourceHeightmap.GetLength(1);
        var normalized = new float[resolutionY, resolutionX];
        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                normalized[y, x] = NormalizeHeightUnitsToTerrain(sourceHeightmap[y, x], maxTileHeightUnits);
            }
        }

        return normalized;
    }

    public static float[,] BuildHeightMeters(double[,] sourceHeightmap, double metersPerTileHeightUnit)
    {
        int resolutionY = sourceHeightmap.GetLength(0);
        int resolutionX = sourceHeightmap.GetLength(1);
        var heightMeters = new float[resolutionY, resolutionX];
        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                heightMeters[y, x] = TileHeightUnitsToMeters(sourceHeightmap[y, x], metersPerTileHeightUnit);
            }
        }

        return heightMeters;
    }

    public static float[,] BuildHeightMetersFromNormalizedHeights(
        float[,] normalizedHeights,
        double minHeightUnits,
        double maxHeightUnits)
    {
        int resolutionY = normalizedHeights.GetLength(0);
        int resolutionX = normalizedHeights.GetLength(1);
        var heightMeters = new float[resolutionY, resolutionX];
        float heightRangeUnits = (float)Math.Max(0d, maxHeightUnits - minHeightUnits);
        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                heightMeters[y, x] = (float)minHeightUnits + normalizedHeights[y, x] * heightRangeUnits;
            }
        }

        return heightMeters;
    }

    public static float TileHeightUnitsToMeters(double heightUnits, double metersPerTileHeightUnit)
    {
        return (float)(heightUnits * metersPerTileHeightUnit);
    }

    public static float EstimateMaxHeightMeters(float[,] heightMeters)
    {
        int resolutionY = heightMeters.GetLength(0);
        int resolutionX = heightMeters.GetLength(1);
        float maxHeight = 0f;
        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                maxHeight = Mathf.Max(maxHeight, heightMeters[y, x]);
            }
        }

        return maxHeight;
    }

    public static float EstimateTileHilliness(float[,] heightMeters)
    {
        int centerY = heightMeters.GetLength(0) / 2;
        int centerX = heightMeters.GetLength(1) / 2;
        return (float)TerrainUtils.ElevationToHilliness(heightMeters[centerY, centerX]);
    }

    public static float NormalizeHeightUnitsToTerrain(double heightUnits, double maxTileHeightUnits)
    {
        return Mathf.Clamp01((float)(heightUnits / Math.Max(maxTileHeightUnits, 1e-6)));
    }

    public static void CalculateHeightRange(double[,] heightmap, out double minHeight, out double maxHeight)
    {
        int resolutionY = heightmap.GetLength(0);
        int resolutionX = heightmap.GetLength(1);
        minHeight = double.MaxValue;
        maxHeight = double.MinValue;

        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                double value = heightmap[y, x];
                if (value < minHeight)
                {
                    minHeight = value;
                }

                if (value > maxHeight)
                {
                    maxHeight = value;
                }
            }
        }

        if (double.IsInfinity(minHeight) || double.IsInfinity(maxHeight))
        {
            minHeight = 0d;
            maxHeight = 0d;
        }
    }

    public static double GetCenterTileHilliness(TileLayers layers, double metersPerTileHeightUnit)
    {
        if (layers.SurroundingHilliness.GetLength(0) > 1 && layers.SurroundingHilliness.GetLength(1) > 1)
        {
            return layers.SurroundingHilliness[1, 1];
        }

        int centerY = layers.Heightmap.GetLength(0) / 2;
        int centerX = layers.Heightmap.GetLength(1) / 2;
        return TerrainUtils.ElevationToHilliness(TileHeightUnitsToMeters(layers.Heightmap[centerY, centerX], metersPerTileHeightUnit));
    }

    public static double SampleHeightmapBilinear(double[,] heightmap, double sampleX, double sampleY)
    {
        int height = heightmap.GetLength(0);
        int width = heightmap.GetLength(1);
        if (height == 0 || width == 0)
        {
            return 0d;
        }

        double clampedX = Math.Clamp(sampleX, 0d, width - 1d);
        double clampedY = Math.Clamp(sampleY, 0d, height - 1d);
        int x0 = (int)Math.Floor(clampedX);
        int y0 = (int)Math.Floor(clampedY);
        int x1 = Math.Min(x0 + 1, width - 1);
        int y1 = Math.Min(y0 + 1, height - 1);
        double tx = clampedX - x0;
        double ty = clampedY - y0;

        double h00 = heightmap[y0, x0];
        double h10 = heightmap[y0, x1];
        double h01 = heightmap[y1, x0];
        double h11 = heightmap[y1, x1];
        double hx0 = Lerp(h00, h10, tx);
        double hx1 = Lerp(h01, h11, tx);
        return Lerp(hx0, hx1, ty);
    }

    public static double Lerp(double a, double b, double t)
    {
        return a + (b - a) * t;
    }
}
