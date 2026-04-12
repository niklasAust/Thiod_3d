using System;
using System.Collections.Generic;
using System.Globalization;
using Stopwatch = System.Diagnostics.Stopwatch;
using UnityEngine;
using WorldGen;
#if GRIFFIN
using Pinwheel.Griffin;
#endif

#nullable enable

public sealed partial class TileLoader : MonoBehaviour
{
    private List<PreparedVegetationPlacement> PrepareVegetationPlacementsForRequest(
        GeneratedTerrainBatchState batchState,
        Stopwatch totalStopwatch,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request)
    {
        var preparedPlacements = new List<PreparedVegetationPlacement>();
        var cappedPlacements = new Dictionary<int, List<PreparedVegetationPlacement>>();
        Vector2Int tileCoordinate = GetTileCoordinate(request);
        bool isCenterTile = tileCoordinate == new Vector2Int(batchState.CenterTileCoordinate.x, batchState.CenterTileCoordinate.y);
        VegetationTileStreamingStats tileStats = GetOrCreateVegetationTileStats(batchState, tileCoordinate, isCenterTile);
        IReadOnlyList<TileObjectPlacement> placedObjects = request.Layers.PlacedObjects ?? Array.Empty<TileObjectPlacement>();
        double hashPolicyMilliseconds = 0d;
        double distanceAdmissionMilliseconds = 0d;
        double capApplicationMilliseconds = 0d;
        double geometryFinalizeMilliseconds = 0d;
        double sortMilliseconds = 0d;
        var phaseStopwatch = new Stopwatch();

        for (int placementIndex = 0; placementIndex < placedObjects.Count; placementIndex++)
        {
            TileObjectPlacement placement = placedObjects[placementIndex];
            TileObjectStreamingTier streamingTier = placement.Definition.StreamingTier;
            if (ShouldUsePlayerCentricSurfaceVegetation() && IsPlayerCentricSurfaceTier(streamingTier))
            {
                continue;
            }

            string categoryName = GetPlacementCategoryName(placement);
            tileStats.RecordGenerated(categoryName);
            batchState.VegetationGeneratedPlacementCount++;

            string? vegetationCategory = placement.Definition.VegetationCategory;
            if (!placeTreeObjects && string.Equals(vegetationCategory, "tree", StringComparison.OrdinalIgnoreCase))
            {
                continue;
            }

            if (!placeSurfaceObjects &&
                !string.IsNullOrWhiteSpace(vegetationCategory) &&
                !string.Equals(vegetationCategory, "tree", StringComparison.OrdinalIgnoreCase))
            {
                continue;
            }

            phaseStopwatch.Restart();
            ulong stableHash = ComputeStablePlacementHash(request, placement);
            bool isTreePlacement = string.Equals(vegetationCategory, "tree", StringComparison.OrdinalIgnoreCase);
            hashPolicyMilliseconds += phaseStopwatch.Elapsed.TotalMilliseconds;
            phaseStopwatch.Restart();
            if (!TryBuildPreparedPlacementGeometry(
                    batchState,
                    tileStats,
                    terrain,
                    request,
                    placement,
                    isTreePlacement,
                    enforceCurrentStreamingDistance: true,
                    out PreparedPlacementGeometry geometry))
            {
                distanceAdmissionMilliseconds += phaseStopwatch.Elapsed.TotalMilliseconds;
                tileStats.RecordSkipped(categoryName);
                batchState.VegetationSkippedByDistanceCount++;
                continue;
            }
            distanceAdmissionMilliseconds += phaseStopwatch.Elapsed.TotalMilliseconds;

            phaseStopwatch.Restart();
            if (!ShouldKeepPlacementForTile(placement, geometry.DensityZone, stableHash))
            {
                hashPolicyMilliseconds += phaseStopwatch.Elapsed.TotalMilliseconds;
                tileStats.RecordSkipped(categoryName);
                batchState.VegetationSkippedByPolicyCount++;
                continue;
            }

            if (!ShouldKeepPlacementForDensityZone(placement, geometry.DensityZone, stableHash))
            {
                hashPolicyMilliseconds += phaseStopwatch.Elapsed.TotalMilliseconds;
                tileStats.RecordSkipped(categoryName);
                batchState.VegetationSkippedByPolicyCount++;
                continue;
            }
            hashPolicyMilliseconds += phaseStopwatch.Elapsed.TotalMilliseconds;

            bool nearPlayerPriority = geometry.DensityZone != VegetationDensityZone.Outer;
            var preparedPlacement = new PreparedVegetationPlacement(
                placement,
                stableHash,
                isCenterTile,
                DeterminePriorityBucket(isCenterTile, nearPlayerPriority, streamingTier),
                ShouldForceInstancingOnlyForPreparedPlacement(isCenterTile, nearPlayerPriority, streamingTier),
                geometry);

            int? maxPlacementsPerTile = placement.Definition.MaxPlacementsPerTile;
            if (maxPlacementsPerTile.HasValue)
            {
                if (!cappedPlacements.TryGetValue(placement.Definition.NumericId, out List<PreparedVegetationPlacement>? entries))
                {
                    entries = new List<PreparedVegetationPlacement>();
                    cappedPlacements[placement.Definition.NumericId] = entries;
                }

                entries.Add(preparedPlacement);
                continue;
            }

            tileStats.RecordKept(categoryName);
            batchState.VegetationKeptPlacementCount++;
            preparedPlacements.Add(preparedPlacement);
        }

        phaseStopwatch.Restart();
        foreach (KeyValuePair<int, List<PreparedVegetationPlacement>> entry in cappedPlacements)
        {
            List<PreparedVegetationPlacement> definitionPlacements = entry.Value;
            definitionPlacements.Sort((left, right) => left.StableHash.CompareTo(right.StableHash));
            int keepCount = definitionPlacements.Count == 0
                ? 0
                : Math.Min(
                    definitionPlacements[0].Placement.Definition.MaxPlacementsPerTile ?? definitionPlacements.Count,
                    definitionPlacements.Count);

            for (int i = 0; i < definitionPlacements.Count; i++)
            {
                PreparedVegetationPlacement preparedPlacement = definitionPlacements[i];
                string categoryName = GetPlacementCategoryName(preparedPlacement.Placement);
                if (i < keepCount)
                {
                    tileStats.RecordKept(categoryName);
                    batchState.VegetationKeptPlacementCount++;
                    preparedPlacements.Add(preparedPlacement);
                    continue;
                }

                tileStats.RecordSkipped(categoryName);
                batchState.VegetationSkippedByCapCount++;
            }
        }
        capApplicationMilliseconds += phaseStopwatch.Elapsed.TotalMilliseconds;

        phaseStopwatch.Restart();
        preparedPlacements.Sort(ComparePreparedVegetationPlacementOrder);
        sortMilliseconds += phaseStopwatch.Elapsed.TotalMilliseconds;

        phaseStopwatch.Restart();
        PopulatePreparedPlacementGeometryNormals(batchState, tileStats, request, preparedPlacements);
        geometryFinalizeMilliseconds += phaseStopwatch.Elapsed.TotalMilliseconds;

        double queuePrepCpuMilliseconds =
            hashPolicyMilliseconds +
            distanceAdmissionMilliseconds +
            capApplicationMilliseconds +
            geometryFinalizeMilliseconds +
            sortMilliseconds;
        batchState.VegetationQueuePrepCpuMilliseconds += queuePrepCpuMilliseconds;
        tileStats.RecordQueuePrep(queuePrepCpuMilliseconds, totalStopwatch.Elapsed.TotalMilliseconds);
        if (hashPolicyMilliseconds > 0d)
        {
            batchState.RecordPhaseTiming("vegetation queue prep/hash-policy", hashPolicyMilliseconds);
        }

        if (distanceAdmissionMilliseconds > 0d)
        {
            batchState.RecordPhaseTiming("vegetation queue prep/distance admission", distanceAdmissionMilliseconds);
        }

        if (capApplicationMilliseconds > 0d)
        {
            batchState.RecordPhaseTiming("vegetation queue prep/cap application", capApplicationMilliseconds);
        }

        if (sortMilliseconds > 0d)
        {
            batchState.RecordPhaseTiming("vegetation queue prep/sort", sortMilliseconds);
        }

        if (geometryFinalizeMilliseconds > 0d)
        {
            batchState.RecordPhaseTiming("vegetation queue prep/normal cache", geometryFinalizeMilliseconds);
        }

        return preparedPlacements;
    }

    private bool ProcessPreparedHybridVegetationPlacement(
        VegetationWorkItem workItem,
        PreparedVegetationPlacement preparedPlacement)
    {
        HybridVegetationBuildState buildState = workItem.BuildState;
        TileObjectPlacement placement = preparedPlacement.Placement;
        VegetationTileStreamingStats? tileStats = null;
        if (buildState.BatchState != null)
        {
            tileStats = GetOrCreateVegetationTileStats(
                buildState.BatchState,
                GetTileCoordinate(buildState.Request),
                preparedPlacement.IsCenterTile);
        }

        var phaseStopwatch = Stopwatch.StartNew();
        GameObject? prefab = LoadPrefabForPlacement(placement, buildState.BatchState);
        phaseStopwatch.Stop();
        RecordPlacementPhaseTiming(
            buildState.BatchState,
            tileStats,
            phaseStopwatch.Elapsed.TotalMilliseconds,
            VegetationPlacementPhase.PrefabResolve,
            workItem);
        if (prefab == null)
        {
            workItem.RecordMissingPrefab();
            tileStats?.RecordMissingPrefab();
            return false;
        }

        bool isTreeObject = IsTreePlacement(placement, prefab);
        if (isTreeObject && !placeTreeObjects)
        {
            return false;
        }

        if (!isTreeObject && !placeSurfaceObjects)
        {
            return false;
        }

        bool requiresInstancingOnly = preparedPlacement.ForceInstancingOnly || RequiresInstancingOnly(placement);
        bool supportsPromotion = !preparedPlacement.ForceInstancingOnly && SupportsHybridPromotion(placement);
        phaseStopwatch.Restart();
        TileLoaderInstancedVegetationPrototype? prototype = GetOrCreateVegetationPrototype(
            buildState.BatchState,
            placement,
            prefab,
            isTreeObject,
            supportsPromotion);
        phaseStopwatch.Stop();
        RecordPlacementPhaseTiming(
            buildState.BatchState,
            tileStats,
            phaseStopwatch.Elapsed.TotalMilliseconds,
            VegetationPlacementPhase.PrototypeResolve,
            workItem);
        if (prototype != null &&
            TryBuildInstancedPlacement(
                buildState,
                tileStats,
                workItem,
                preparedPlacement,
                prototype,
                out TileLoaderInstancedVegetationPlacement instancedPlacement))
        {
            buildState.VegetationContainer ??= GetOrCreateVegetationBuildContainer(buildState);
            if (!buildState.PrototypeIndices.TryGetValue(prototype.Key, out int prototypeIndex))
            {
                prototypeIndex = buildState.Prototypes.Count;
                buildState.PrototypeIndices[prototype.Key] = prototypeIndex;
                buildState.Prototypes.Add(prototype);
                workItem.NewPrototypeCount++;
            }

            buildState.Placements.Add(new TileLoaderInstancedVegetationPlacement(
                prototypeIndex,
                instancedPlacement.LocalPosition,
                instancedPlacement.LocalRotation,
                instancedPlacement.LocalScale,
                instancedPlacement.ConformToTerrainOnPromotion,
                instancedPlacement.SurfaceSampleLocalX,
                instancedPlacement.SurfaceSampleLocalZ,
                instancedPlacement.SurfaceVerticalOffset,
                instancedPlacement.SurfaceNormalOffset));
            workItem.RecordInstancedPlacement(preparedPlacement.ForceInstancingOnly);
            tileStats?.RecordInstancedPlacement(preparedPlacement.PriorityBucket, preparedPlacement.ForceInstancingOnly);
            if (buildState.BatchState != null)
            {
                buildState.BatchState.VegetationInstancedPlacementCount++;
                if (preparedPlacement.ForceInstancingOnly)
                {
                    buildState.BatchState.VegetationForcedInstancingOnlyCount++;
                }
            }
            return false;
        }

        if (vegetationLoadMode == VegetationLoadMode.InstancesOnly || requiresInstancingOnly)
        {
            return false;
        }

        buildState.VegetationContainer ??= GetOrCreateVegetationBuildContainer(buildState);
        bool instantiated = InstantiatePreparedLegacyPlacement(
            buildState,
            tileStats,
            workItem,
            preparedPlacement,
            prefab,
            isTreeObject,
            buildState.VegetationContainer);
        if (instantiated)
        {
            workItem.RecordLegacyPlacement();
            tileStats?.RecordLegacyPlacement(preparedPlacement.PriorityBucket);
            if (buildState.BatchState != null)
            {
                buildState.BatchState.VegetationLegacyPlacementCount++;
            }
        }

        return instantiated &&
               buildState.VegetationContainer != null &&
               buildState.VegetationContainer.gameObject.activeInHierarchy;
    }

    private VegetationTileStreamingStats GetOrCreateVegetationTileStats(
        GeneratedTerrainBatchState batchState,
        Vector2Int tileCoordinate,
        bool isCenterTile)
    {
        if (batchState.VegetationTileStats.TryGetValue(tileCoordinate, out VegetationTileStreamingStats? existing))
        {
            return existing;
        }

        var created = new VegetationTileStreamingStats(tileCoordinate, isCenterTile);
        batchState.VegetationTileStats[tileCoordinate] = created;
        return created;
    }

    private static string GetPlacementCategoryName(TileObjectPlacement placement)
    {
        if (!string.IsNullOrWhiteSpace(placement.Definition.VegetationCategory))
        {
            return placement.Definition.VegetationCategory!;
        }

        return placement.Definition.Category.ToString().ToLowerInvariant();
    }

    private static bool ShouldKeepPlacementForTile(
        TileObjectPlacement placement,
        VegetationDensityZone densityZone,
        ulong stableHash)
    {
        if (densityZone != VegetationDensityZone.Outer)
        {
            return true;
        }

        return placement.Definition.OuterTilePolicy switch
        {
            TileObjectOuterTilePolicy.Skip => false,
            TileObjectOuterTilePolicy.Reduced => StableHashToUnitInterval(stableHash) <= placement.Definition.OuterTileDensityScale,
            _ => true,
        };
    }

    private static int ComparePreparedVegetationPlacementOrder(
        PreparedVegetationPlacement left,
        PreparedVegetationPlacement right)
    {
        int bucketCompare = left.PriorityBucket.CompareTo(right.PriorityBucket);
        if (bucketCompare != 0)
        {
            return bucketCompare;
        }

        if (left.PriorityBucket == VegetationPriorityBucket.CenterCanopyAndLarge ||
            left.PriorityBucket == VegetationPriorityBucket.OuterCanopyAndLarge)
        {
            int distanceCompare = right.Geometry.DistanceToTargetSq.CompareTo(left.Geometry.DistanceToTargetSq);
            if (distanceCompare != 0)
            {
                return distanceCompare;
            }
        }

        return left.StableHash.CompareTo(right.StableHash);
    }

    private bool TryBuildPreparedPlacementGeometry(
        GeneratedTerrainBatchState batchState,
        VegetationTileStreamingStats? tileStats,
        GStylizedTerrain terrain,
        GeneratedTerrainRequest request,
        TileObjectPlacement placement,
        bool isTreePlacement,
        bool enforceCurrentStreamingDistance,
        out PreparedPlacementGeometry geometry)
    {
        geometry = default;
        double[,] heightmap = request.Layers.Heightmap;
        Vector3 localPosition = GetTerrainLocalPointFromHeightmapApprox(
            heightmap,
            placement.X,
            placement.Y,
            batchState.NormalizationMinHeight,
            batchState.NormalizationMaxHeight,
            isTreePlacement ? treeObjectVerticalOffset : surfaceObjectVerticalOffset);
        RecordVegetationSampleCounts(batchState, tileStats, 1, 0);

        Vector3 worldPosition = terrain.transform.TransformPoint(localPosition);
        float distanceToTargetSq = 0f;
        VegetationDensityZone densityZone = VegetationDensityZone.High;
        Vector3? targetWorldPosition = batchState.VegetationStreamingTargetWorldPosition;
        if (Application.isPlaying && targetWorldPosition.HasValue)
        {
            distanceToTargetSq = (worldPosition - targetWorldPosition.Value).sqrMagnitude;
            float? loadDistanceMeters = placement.Definition.LoadDistanceMeters;
            if (enforceCurrentStreamingDistance &&
                loadDistanceMeters.HasValue &&
                loadDistanceMeters.Value > 0f)
            {
                float maxDistanceSq = loadDistanceMeters.Value * loadDistanceMeters.Value;
                if (distanceToTargetSq > maxDistanceSq)
                {
                    return false;
                }
            }

            densityZone = enforceCurrentStreamingDistance
                ? ResolveVegetationDensityZone(distanceToTargetSq, placement.Definition.StreamingTier)
                : VegetationDensityZone.High;
        }

        bool useExactTerrainConformOnLoad =
            isTreePlacement ||
            ShouldUseExactTerrainConformOnLoad(distanceToTargetSq) ||
            IsSeamRiskPlacement(localPosition);
        bool useExactTerrainConformOnPromotion =
            SupportsHybridPromotion(placement);
        geometry = new PreparedPlacementGeometry(
            localPosition,
            Vector3.up,
            worldPosition,
            distanceToTargetSq,
            densityZone,
            IsSeamRiskPlacement(localPosition),
            useExactTerrainConformOnLoad,
            useExactTerrainConformOnPromotion);
        return true;
    }

    private void PopulatePreparedPlacementGeometryNormals(
        GeneratedTerrainBatchState batchState,
        VegetationTileStreamingStats? tileStats,
        GeneratedTerrainRequest request,
        List<PreparedVegetationPlacement> preparedPlacements)
    {
        if (preparedPlacements.Count == 0)
        {
            return;
        }

        double[,] heightmap = request.Layers.Heightmap;
        for (int placementIndex = 0; placementIndex < preparedPlacements.Count; placementIndex++)
        {
            PreparedVegetationPlacement preparedPlacement = preparedPlacements[placementIndex];
            if (string.Equals(
                    preparedPlacement.Placement.Definition.VegetationCategory,
                    "tree",
                    StringComparison.OrdinalIgnoreCase) ||
                preparedPlacement.Geometry.UseExactTerrainConformOnLoad)
            {
                continue;
            }

            Vector3 localNormal = GetTerrainLocalNormalFromHeightmapApprox(
                heightmap,
                preparedPlacement.Placement.X,
                preparedPlacement.Placement.Y,
                batchState.NormalizationMinHeight,
                batchState.NormalizationMaxHeight);
            RecordVegetationSampleCounts(batchState, tileStats, 4, 0);
            preparedPlacements[placementIndex] = preparedPlacement.WithGeometry(preparedPlacement.Geometry.WithLocalNormal(localNormal));
        }
    }

    private bool ShouldUseExactTerrainConformOnLoad(float distanceToTargetSq)
    {
        if (!Application.isPlaying)
        {
            return true;
        }

        float interactionRadius = Mathf.Max(0f, vegetationInteractionRadiusMeters);
        return interactionRadius <= 0f || distanceToTargetSq <= interactionRadius * interactionRadius;
    }

    private bool IsSeamRiskPlacement(Vector3 localPosition)
    {
        float seamRiskMargin = ResolveTerrainSeamRiskMarginMeters();
        if (seamRiskMargin <= 0f)
        {
            return false;
        }

        float maxX = Mathf.Max(0f, terrainWidth);
        float maxZ = Mathf.Max(0f, terrainLength);
        return localPosition.x <= seamRiskMargin ||
               localPosition.z <= seamRiskMargin ||
               localPosition.x >= maxX - seamRiskMargin ||
               localPosition.z >= maxZ - seamRiskMargin;
    }

    private float ResolveTerrainSeamRiskMarginMeters()
    {
        float terrainExtent = Mathf.Min(Mathf.Max(0f, terrainWidth), Mathf.Max(0f, terrainLength));
        if (terrainExtent <= 0f)
        {
            return 0f;
        }

        return Mathf.Clamp(terrainExtent * 0.08f, 2f, 12f);
    }

    private VegetationDensityZone ResolveVegetationDensityZone(
        float distanceToTargetSq,
        TileObjectStreamingTier streamingTier)
    {
        if (!Application.isPlaying)
        {
            return VegetationDensityZone.High;
        }

        float highRadius = Mathf.Max(0f, highDetailPlacementRadiusMeters);
        float midRadius = Mathf.Max(highRadius, midDetailPlacementRadiusMeters);
        float highRadiusSq = highRadius * highRadius;
        float midRadiusSq = midRadius * midRadius;
        if (distanceToTargetSq <= highRadiusSq)
        {
            return VegetationDensityZone.High;
        }

        if (distanceToTargetSq > midRadiusSq)
        {
            return VegetationDensityZone.Outer;
        }

        return streamingTier == TileObjectStreamingTier.Ground ||
               streamingTier == TileObjectStreamingTier.Clutter
            ? VegetationDensityZone.Outer
            : VegetationDensityZone.Mid;
    }

    private static bool ShouldKeepPlacementForDensityZone(
        TileObjectPlacement placement,
        VegetationDensityZone densityZone,
        ulong stableHash)
    {
        if (densityZone == VegetationDensityZone.High)
        {
            return true;
        }

        float keepProbability = placement.Definition.StreamingTier switch
        {
            TileObjectStreamingTier.Canopy => densityZone == VegetationDensityZone.Mid ? 0.85f : 0.6f,
            TileObjectStreamingTier.Large => densityZone == VegetationDensityZone.Mid ? 0.85f : 0.6f,
            TileObjectStreamingTier.Clutter => densityZone == VegetationDensityZone.Mid ? 0.35f : 0.1f,
            TileObjectStreamingTier.Ground => densityZone == VegetationDensityZone.Mid ? 0.15f : 0f,
            _ => 1f,
        };

        return StableHashToUnitInterval(stableHash) <= keepProbability;
    }

    private static void RecordVegetationSampleCounts(
        GeneratedTerrainBatchState? batchState,
        VegetationTileStreamingStats? tileStats,
        int heightmapSamples,
        int raycastSamples)
    {
        if (heightmapSamples > 0)
        {
            tileStats?.RecordHeightmapSamples(heightmapSamples);
            if (batchState != null)
            {
                batchState.VegetationHeightmapSampleCount += heightmapSamples;
            }
        }

        if (raycastSamples > 0)
        {
            tileStats?.RecordRaycastSamples(raycastSamples);
            if (batchState != null)
            {
                batchState.VegetationRaycastSampleCount += raycastSamples;
            }
        }
    }

    private void RecordPlacementPhaseTiming(
        GeneratedTerrainBatchState? batchState,
        VegetationTileStreamingStats? tileStats,
        double elapsedMilliseconds,
        VegetationPlacementPhase placementPhase,
        VegetationWorkItem? workItem = null)
    {
        if (elapsedMilliseconds <= 0d)
        {
            return;
        }

        tileStats?.RecordPlacementCpu(elapsedMilliseconds);
        tileStats?.RecordPlacementPhase(elapsedMilliseconds, placementPhase);
        workItem?.RecordPlacementPhase(elapsedMilliseconds, placementPhase);
        if (batchState == null)
        {
            return;
        }

        batchState.VegetationPlacementCpuMilliseconds += elapsedMilliseconds;
        switch (placementPhase)
        {
            case VegetationPlacementPhase.PrefabResolve:
                batchState.VegetationPrefabResolveMilliseconds += elapsedMilliseconds;
                break;
            case VegetationPlacementPhase.PrototypeResolve:
                batchState.VegetationPrototypeResolveMilliseconds += elapsedMilliseconds;
                break;
            case VegetationPlacementPhase.PositionBuild:
                batchState.VegetationPositionBuildMilliseconds += elapsedMilliseconds;
                break;
            case VegetationPlacementPhase.NormalBuild:
                batchState.VegetationNormalBuildMilliseconds += elapsedMilliseconds;
                break;
            case VegetationPlacementPhase.RendererFinalize:
                batchState.VegetationRendererFinalizeMilliseconds += elapsedMilliseconds;
                break;
        }
    }

    private VegetationPriorityBucket DeterminePriorityBucket(
        bool isCenterTile,
        bool nearPlayerPriority,
        TileObjectStreamingTier streamingTier)
    {
        bool treatAsCenterPriority = streamingTier == TileObjectStreamingTier.Canopy ||
                                     streamingTier == TileObjectStreamingTier.Large
            ? isCenterTile || nearPlayerPriority
            : nearPlayerPriority;
        if (streamingTier == TileObjectStreamingTier.Ground)
        {
            return treatAsCenterPriority
                ? VegetationPriorityBucket.CenterClutterAndGround
                : VegetationPriorityBucket.OuterGroundAndDebris;
        }

        if (streamingTier == TileObjectStreamingTier.Clutter)
        {
            if (!centerTileOnlyNonTreeBudgetFirst)
            {
                return treatAsCenterPriority
                    ? VegetationPriorityBucket.CenterClutterAndGround
                    : VegetationPriorityBucket.OuterClutter;
            }

            return treatAsCenterPriority
                ? VegetationPriorityBucket.CenterClutterAndGround
                : VegetationPriorityBucket.OuterClutter;
        }

        return treatAsCenterPriority
            ? VegetationPriorityBucket.CenterCanopyAndLarge
            : VegetationPriorityBucket.OuterCanopyAndLarge;
    }

    private static bool ShouldForceInstancingOnlyForPreparedPlacement(
        bool isCenterTile,
        bool nearPlayerPriority,
        TileObjectStreamingTier streamingTier)
    {
        return !nearPlayerPriority &&
               (streamingTier == TileObjectStreamingTier.Clutter || streamingTier == TileObjectStreamingTier.Ground);
    }

    private Vector3? ResolveVegetationStreamingTargetWorldPosition()
    {
        if (!Application.isPlaying)
        {
            return null;
        }

        Transform? target = ResolveVegetationStreamingTarget();
        return target != null ? target.position : null;
    }

    private static Transform? ResolveVegetationStreamingTarget()
    {
        if (TryFindSceneTransformWithTag("Player", out Transform? taggedPlayerTransform))
        {
            return taggedPlayerTransform;
        }

        return Camera.main != null ? Camera.main.transform : null;
    }

    private static ulong ComputeStablePlacementHash(GeneratedTerrainRequest request, TileObjectPlacement placement)
    {
        ulong hash = 1469598103934665603UL;
        AppendHash(ref hash, unchecked((ulong)request.UnityTileX));
        AppendHash(ref hash, unchecked((ulong)request.UnityTileY));
        AppendHash(ref hash, unchecked((ulong)placement.Definition.NumericId));
        AppendHash(ref hash, unchecked((ulong)BitConverter.DoubleToInt64Bits(Math.Round(placement.X, 4))));
        AppendHash(ref hash, unchecked((ulong)BitConverter.DoubleToInt64Bits(Math.Round(placement.Y, 4))));

        string? rawPath = placement.PrefabPath ?? placement.Definition.PrefabPath;
        if (!string.IsNullOrWhiteSpace(rawPath))
        {
            for (int i = 0; i < rawPath.Length; i++)
            {
                AppendHash(ref hash, rawPath[i]);
            }
        }

        return hash;
    }

    private static void AppendHash(ref ulong hash, ulong value)
    {
        hash ^= value + 0x9e3779b97f4a7c15UL + (hash << 6) + (hash >> 2);
    }

    private static double StableHashToUnitInterval(ulong stableHash)
    {
        return (stableHash & 0x00FFFFFFUL) / 16777215.0;
    }
}
