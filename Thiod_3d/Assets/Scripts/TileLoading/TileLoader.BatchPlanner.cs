using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using UnityEngine;
using WorldGen;

#nullable enable

internal sealed class TileLoaderBatchPlanner
{
    private readonly TerrainBuildContext context;
    private readonly double metersPerTileHeightUnit;

    public TileLoaderBatchPlanner(TerrainBuildContext context, double metersPerTileHeightUnit)
    {
        this.context = context;
        this.metersPerTileHeightUnit = metersPerTileHeightUnit;
    }

    public GeneratedTerrainBatchState BuildBatchState(
        TileGenerator tileGenerator,
        LoadedWorldData loadedWorldData,
        GenerationSettings settings,
        int pipelineId,
        ref GeneratedTerrainBatchCacheEntry? cachedTerrainBatch,
        Transform? activeGeneratedTerrainRoot,
        Vector3Int? activeLoadedUnityTileCoordinate,
        IReadOnlyDictionary<Vector2Int, GeneratedTerrainTileData> activeTerrainTileCache,
        string? activeTerrainTileCacheSignature)
    {
        string cacheSignature = BuildGeneratedTerrainCacheSignature(loadedWorldData, settings);
        if (ShouldUseIncrementalNeighborhoodRequestReuse(
                cacheSignature,
                activeGeneratedTerrainRoot,
                activeLoadedUnityTileCoordinate,
                activeTerrainTileCache,
                activeTerrainTileCacheSignature))
        {
            return BuildIncrementalGeneratedTerrainBatchState(
                tileGenerator,
                loadedWorldData,
                settings,
                pipelineId,
                cacheSignature,
                ref cachedTerrainBatch,
                activeTerrainTileCache);
        }

        string cacheKey = BuildGeneratedTerrainBatchCacheKey(cacheSignature);
        if (cachedTerrainBatch != null && cachedTerrainBatch.CacheKey == cacheKey)
        {
            return cachedTerrainBatch.CreateState(pipelineId);
        }

        var requests = new List<GeneratedTerrainRequest>();
        double batchMinHeight = double.MaxValue;
        double batchMaxHeight = double.MinValue;
        Vector3 batchRootLocalPosition = GetBatchRootLocalPosition(context.UnityTileCoordinate);

        if (context.UseBatchNeighborhoodLoading)
        {
            int centerWorldTileY = context.InvertUnityYForWorldGen ? -context.UnityTileCoordinate.y : context.UnityTileCoordinate.y;
            TileLayersBatch batch = tileGenerator.GenerateTileLayersBatch(
                context.UnityTileCoordinate.x,
                centerWorldTileY,
                1,
                settings.TileSize,
                settings.HillSpacing,
                settings.HillStrength);

            for (int i = 0; i < batch.Entries.Count; i++)
            {
                TileLayersBatchEntry entry = batch.Entries[i];
                int unityOffsetY = context.InvertUnityYForWorldGen ? -entry.OffsetY : entry.OffsetY;
                int unityTileX = context.UnityTileCoordinate.x + entry.OffsetX;
                int unityTileY = context.UnityTileCoordinate.y + unityOffsetY;
                Vector3 localPosition = new(entry.OffsetX * context.TerrainWidth, 0f, unityOffsetY * context.TerrainLength);
                string terrainObjectName = GetTerrainObjectName(entry.OffsetX, unityOffsetY, unityTileX, unityTileY);
                TileLoaderTerrainMathUtility.CalculateHeightRange(entry.Layers.Heightmap, out double tileMinHeight, out double tileMaxHeight);
                batchMinHeight = Math.Min(batchMinHeight, tileMinHeight);
                batchMaxHeight = Math.Max(batchMaxHeight, tileMaxHeight);
                requests.Add(new GeneratedTerrainRequest(
                    entry.Layers,
                    terrainObjectName,
                    localPosition,
                    unityTileX,
                    unityTileY,
                    tileMinHeight,
                    tileMaxHeight,
                    TileLoaderTerrainMathUtility.GetCenterTileHilliness(entry.Layers, metersPerTileHeightUnit)));
            }
        }
        else
        {
            int unityTileX = context.UnityTileCoordinate.x;
            int unityTileY = context.UnityTileCoordinate.y;
            int worldTileY = context.InvertUnityYForWorldGen ? -unityTileY : unityTileY;
            TileLayers layers = tileGenerator.GenerateTileLayers(
                unityTileX,
                worldTileY,
                settings.TileSize,
                settings.HillSpacing,
                settings.HillStrength);
            TileLoaderTerrainMathUtility.CalculateHeightRange(layers.Heightmap, out double tileMinHeight, out double tileMaxHeight);
            batchMinHeight = tileMinHeight;
            batchMaxHeight = tileMaxHeight;
            requests.Add(new GeneratedTerrainRequest(
                layers,
                context.GeneratedTerrainName,
                Vector3.zero,
                unityTileX,
                unityTileY,
                tileMinHeight,
                tileMaxHeight,
                TileLoaderTerrainMathUtility.GetCenterTileHilliness(layers, metersPerTileHeightUnit)));
        }

        string populatedCacheKey = BuildGeneratedTerrainBatchCacheKey(cacheSignature);
        SortTerrainRequests(requests, context.UnityTileCoordinate);
        Vector2Int[] orderedTileCoordinates = BuildOrderedTileCoordinates(requests);
        if (requests.Count == 0)
        {
            return new GeneratedTerrainBatchState(
                populatedCacheKey,
                cacheSignature,
                pipelineId,
                context.UnityTileCoordinate,
                batchRootLocalPosition,
                Array.Empty<GeneratedTerrainRequest>(),
                Array.Empty<Vector2Int>(),
                loadedWorldData.GlobalMinHeight,
                loadedWorldData.GlobalMaxHeight);
        }

        double normalizationMinHeight = Math.Min(loadedWorldData.GlobalMinHeight, batchMinHeight);
        double normalizationMaxHeight = Math.Max(loadedWorldData.GlobalMaxHeight, batchMaxHeight);
        cachedTerrainBatch = new GeneratedTerrainBatchCacheEntry(
            populatedCacheKey,
            cacheSignature,
            context.UnityTileCoordinate,
            batchRootLocalPosition,
            normalizationMinHeight,
            normalizationMaxHeight,
            requests,
            orderedTileCoordinates);

        return cachedTerrainBatch.CreateState(pipelineId);
    }

    private string BuildGeneratedTerrainCacheSignature(LoadedWorldData loadedWorldData, GenerationSettings settings)
    {
        string worldPath = TileLoaderWorldDataUtility.ResolveWorldDataFilePath(context.WorldDataFile);
        long worldTicks = File.Exists(worldPath) ? File.GetLastWriteTimeUtc(worldPath).Ticks : 0L;
        string vegetationObjectsPath = Path.Combine(Application.dataPath, "Resources", "VegetationConfig", "vegetation_objects.json");
        string vegetationRulesPath = Path.Combine(Application.dataPath, "..", "Packages", "com.niklasaust.worldgen", "VegetationConfig", "vegetation_biome_rules.json");
        long vegetationObjectsTicks = File.Exists(vegetationObjectsPath) ? File.GetLastWriteTimeUtc(vegetationObjectsPath).Ticks : 0L;
        long vegetationRulesTicks = File.Exists(vegetationRulesPath) ? File.GetLastWriteTimeUtc(vegetationRulesPath).Ticks : 0L;

        return string.Join(
            "|",
            Path.GetFullPath(worldPath),
            worldTicks.ToString(CultureInfo.InvariantCulture),
            vegetationObjectsTicks.ToString(CultureInfo.InvariantCulture),
            vegetationRulesTicks.ToString(CultureInfo.InvariantCulture),
            loadedWorldData.Seed.ToString(CultureInfo.InvariantCulture),
            context.InvertUnityYForWorldGen ? "invert" : "normal",
            context.UseBatchNeighborhoodLoading ? "3x3" : "single",
            settings.TileSize.ToString(CultureInfo.InvariantCulture),
            settings.HillSpacing.ToString(CultureInfo.InvariantCulture),
            settings.HillStrength.ToString("R", CultureInfo.InvariantCulture),
            context.TerrainWidth.ToString("R", CultureInfo.InvariantCulture),
            context.TerrainLength.ToString("R", CultureInfo.InvariantCulture),
            context.TerrainHeight.ToString("R", CultureInfo.InvariantCulture),
            context.TerrainGridSize.ToString(CultureInfo.InvariantCulture),
            context.RiverWidthMultiplier.ToString("R", CultureInfo.InvariantCulture),
            context.RiverDepthMultiplier.ToString("R", CultureInfo.InvariantCulture),
            context.RiverBankDepthMultiplier.ToString("R", CultureInfo.InvariantCulture),
            context.RiverCenterDepthMultiplier.ToString("R", CultureInfo.InvariantCulture),
            context.RiverCenterDepthMultiplierAtNinetyDegrees.ToString("R", CultureInfo.InvariantCulture),
            context.RiverCenterCarveWidthMultiplier.ToString("R", CultureInfo.InvariantCulture),
            context.RiverCenterCarveWidthMultiplierAtNinetyDegrees.ToString("R", CultureInfo.InvariantCulture),
            context.RiverProfileMinDropMetersPerTile.ToString("R", CultureInfo.InvariantCulture),
            context.RiverProfileMaxDropMetersPerTile.ToString("R", CultureInfo.InvariantCulture),
            context.RiverCorridorDepressionMeters.ToString("R", CultureInfo.InvariantCulture),
            context.RiverCorridorMaxSlopeMetersPerSample.ToString("R", CultureInfo.InvariantCulture),
            context.RiverCorridorRadiusMultiplier.ToString("R", CultureInfo.InvariantCulture),
            context.RiverCorridorMinRadiusSamples.ToString(CultureInfo.InvariantCulture),
            context.RiverCorridorSmoothingStrength.ToString("R", CultureInfo.InvariantCulture),
            context.RiverCorridorSmoothingKernelRadius.ToString(CultureInfo.InvariantCulture),
            context.RiverCorridorSmoothingPasses.ToString(CultureInfo.InvariantCulture),
            context.RiverFinalSmoothingStrength.ToString("R", CultureInfo.InvariantCulture),
            context.RiverFinalSmoothingKernelRadius.ToString(CultureInfo.InvariantCulture),
            context.RiverFinalSmoothingPasses.ToString(CultureInfo.InvariantCulture),
            context.RiverFinalSmoothingRetainedDepthFraction.ToString("R", CultureInfo.InvariantCulture),
            context.RiverWaterMeshVerticalOffset.ToString("R", CultureInfo.InvariantCulture),
            context.RiverWaterMeshVerticalOffsetAtNinetyDegrees.ToString("R", CultureInfo.InvariantCulture),
            context.VegetationStreamingPolicyVersion.ToString(CultureInfo.InvariantCulture),
            context.PlaceTreeObjects ? "trees" : "noTrees",
            context.PlaceSurfaceObjects ? "surface" : "noSurface");
    }

    private string BuildGeneratedTerrainBatchCacheKey(string cacheSignature)
    {
        return string.Join(
            "|",
            cacheSignature,
            context.UnityTileCoordinate.x.ToString(CultureInfo.InvariantCulture),
            context.UnityTileCoordinate.y.ToString(CultureInfo.InvariantCulture));
    }

    private bool ShouldUseIncrementalNeighborhoodRequestReuse(
        string cacheSignature,
        Transform? activeGeneratedTerrainRoot,
        Vector3Int? activeLoadedUnityTileCoordinate,
        IReadOnlyDictionary<Vector2Int, GeneratedTerrainTileData> activeTerrainTileCache,
        string? activeTerrainTileCacheSignature)
    {
        if (!Application.isPlaying ||
            !context.DynamicTileLoadingEnabled ||
            !context.ReuseOverlappingDynamicNeighborhoodTiles ||
            !context.UseBatchNeighborhoodLoading ||
            activeGeneratedTerrainRoot == null ||
            !activeLoadedUnityTileCoordinate.HasValue ||
            activeTerrainTileCache.Count == 0)
        {
            return false;
        }

        if (!string.Equals(activeTerrainTileCacheSignature, cacheSignature, StringComparison.Ordinal))
        {
            return false;
        }

        Vector3Int previousCenter = activeLoadedUnityTileCoordinate.Value;
        int deltaX = Math.Abs(context.UnityTileCoordinate.x - previousCenter.x);
        int deltaY = Math.Abs(context.UnityTileCoordinate.y - previousCenter.y);
        return deltaX <= 2 && deltaY <= 2;
    }

    private GeneratedTerrainBatchState BuildIncrementalGeneratedTerrainBatchState(
        TileGenerator tileGenerator,
        LoadedWorldData loadedWorldData,
        GenerationSettings settings,
        int pipelineId,
        string cacheSignature,
        ref GeneratedTerrainBatchCacheEntry? cachedTerrainBatch,
        IReadOnlyDictionary<Vector2Int, GeneratedTerrainTileData> activeTerrainTileCache)
    {
        string cacheKey = BuildGeneratedTerrainBatchCacheKey(cacheSignature);
        var requests = new List<GeneratedTerrainRequest>(9);
        double batchMinHeight = double.MaxValue;
        double batchMaxHeight = double.MinValue;
        int reusedRequestCount = 0;
        Vector3 batchRootLocalPosition = GetBatchRootLocalPosition(context.UnityTileCoordinate);

        for (int offsetY = -1; offsetY <= 1; offsetY++)
        {
            for (int offsetX = -1; offsetX <= 1; offsetX++)
            {
                int unityTileX = context.UnityTileCoordinate.x + offsetX;
                int unityTileY = context.UnityTileCoordinate.y + offsetY;
                Vector2Int tileCoordinate = new(unityTileX, unityTileY);
                GeneratedTerrainTileData tileData;
                if (!activeTerrainTileCache.TryGetValue(tileCoordinate, out tileData))
                {
                    tileData = BuildTerrainTileData(tileGenerator, settings, unityTileX, unityTileY);
                }
                else
                {
                    reusedRequestCount++;
                }

                batchMinHeight = Math.Min(batchMinHeight, tileData.LocalMinHeight);
                batchMaxHeight = Math.Max(batchMaxHeight, tileData.LocalMaxHeight);
                requests.Add(CreateTerrainRequest(tileData));
            }
        }

        SortTerrainRequests(requests, context.UnityTileCoordinate);
        Vector2Int[] orderedTileCoordinates = BuildOrderedTileCoordinates(requests);

        double normalizationMinHeight = Math.Min(loadedWorldData.GlobalMinHeight, batchMinHeight);
        double normalizationMaxHeight = Math.Max(loadedWorldData.GlobalMaxHeight, batchMaxHeight);
        cachedTerrainBatch = new GeneratedTerrainBatchCacheEntry(
            cacheKey,
            cacheSignature,
            context.UnityTileCoordinate,
            batchRootLocalPosition,
            normalizationMinHeight,
            normalizationMaxHeight,
            requests,
            orderedTileCoordinates);

        GeneratedTerrainBatchState batchState = cachedTerrainBatch.CreateState(pipelineId);
        batchState.ReusedRequestCount = reusedRequestCount;
        return batchState;
    }

    private GeneratedTerrainTileData BuildTerrainTileData(
        TileGenerator tileGenerator,
        GenerationSettings settings,
        int unityTileX,
        int unityTileY)
    {
        int worldTileY = context.InvertUnityYForWorldGen ? -unityTileY : unityTileY;
        TileLayers layers = tileGenerator.GenerateTileLayers(
            unityTileX,
            worldTileY,
            settings.TileSize,
            settings.HillSpacing,
            settings.HillStrength);
        TileLoaderTerrainMathUtility.CalculateHeightRange(layers.Heightmap, out double tileMinHeight, out double tileMaxHeight);
        return new GeneratedTerrainTileData(
            layers,
            unityTileX,
            unityTileY,
            tileMinHeight,
            tileMaxHeight,
            TileLoaderTerrainMathUtility.GetCenterTileHilliness(layers, metersPerTileHeightUnit));
    }

    private GeneratedTerrainRequest CreateTerrainRequest(GeneratedTerrainTileData tileData)
    {
        int offsetX = tileData.UnityTileX - context.UnityTileCoordinate.x;
        int offsetY = tileData.UnityTileY - context.UnityTileCoordinate.y;
        Vector3 localPosition = new(offsetX * context.TerrainWidth, 0f, offsetY * context.TerrainLength);
        string terrainObjectName = GetTerrainObjectName(offsetX, offsetY, tileData.UnityTileX, tileData.UnityTileY);
        return new GeneratedTerrainRequest(
            tileData.Layers,
            terrainObjectName,
            localPosition,
            tileData.UnityTileX,
            tileData.UnityTileY,
            tileData.LocalMinHeight,
            tileData.LocalMaxHeight,
            tileData.TileHilliness);
    }

    private string GetTerrainObjectName(int offsetX, int offsetY, int unityTileX, int unityTileY)
    {
        if (!context.UseBatchNeighborhoodLoading && offsetX == 0 && offsetY == 0)
        {
            return context.GeneratedTerrainName;
        }

        return $"{context.GeneratedTerrainName}_{unityTileX}_{unityTileY}";
    }

    private Vector3 GetBatchRootLocalPosition(Vector3Int centerTileCoordinate)
    {
        if (!Application.isPlaying || !context.DynamicTileLoadingEnabled)
        {
            return Vector3.zero;
        }

        return new Vector3(
            centerTileCoordinate.x * context.TerrainWidth,
            0f,
            centerTileCoordinate.y * context.TerrainLength);
    }

    private static Vector2Int[] BuildOrderedTileCoordinates(IReadOnlyList<GeneratedTerrainRequest> requests)
    {
        var orderedTileCoordinates = new Vector2Int[requests.Count];
        for (int i = 0; i < requests.Count; i++)
        {
            orderedTileCoordinates[i] = requests[i].TileCoordinate;
        }

        return orderedTileCoordinates;
    }

    private static void SortTerrainRequests(List<GeneratedTerrainRequest> requests, Vector3Int centerTileCoordinate)
    {
        requests.Sort((left, right) =>
            CompareTerrainRequestOrder(left, right, centerTileCoordinate));
    }

    private static int CompareTerrainRequestOrder(
        GeneratedTerrainRequest left,
        GeneratedTerrainRequest right,
        Vector3Int centerTileCoordinate)
    {
        int leftRank = GetNeighborhoodOrderRank(left.TileCoordinate, centerTileCoordinate);
        int rightRank = GetNeighborhoodOrderRank(right.TileCoordinate, centerTileCoordinate);
        if (leftRank != rightRank)
        {
            return leftRank.CompareTo(rightRank);
        }

        int yComparison = left.UnityTileY.CompareTo(right.UnityTileY);
        if (yComparison != 0)
        {
            return yComparison;
        }

        return left.UnityTileX.CompareTo(right.UnityTileX);
    }

    private static int GetNeighborhoodOrderRank(Vector2Int tileCoordinate, Vector3Int centerTileCoordinate)
    {
        int offsetX = tileCoordinate.x - centerTileCoordinate.x;
        int offsetY = tileCoordinate.y - centerTileCoordinate.y;
        bool insideNeighborhood =
            offsetX >= -1 && offsetX <= 1 &&
            offsetY >= -1 && offsetY <= 1;
        if (insideNeighborhood)
        {
            return (offsetY + 1) * 3 + (offsetX + 1);
        }

        return 100 + Math.Abs(offsetY) * 10 + Math.Abs(offsetX);
    }
}
