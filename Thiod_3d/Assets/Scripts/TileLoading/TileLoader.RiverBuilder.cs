#if GRIFFIN
using System;
using System.Collections.Generic;
using System.Globalization;
using Unity.Mathematics;
using UnityEngine;
using Unity.Profiling;
using UnityEngine.Rendering;
using UnityEngine.Splines;
using Pinwheel.Griffin;
using WorldGen;
#if UNITY_EDITOR
using UnityEditor;
#endif

#nullable enable

internal sealed class TileLoaderRiverSettings
{
    public bool CreateRiverWater { get; set; }
    public bool CreateRiverDebugSplines { get; set; }
    public string GeneratedRiverWaterContainerName { get; set; } = string.Empty;
    public string GeneratedRiverSplineContainerName { get; set; } = string.Empty;
    public Material? RiverWaterMaterial { get; set; }
    public string RiverWaterMaterialAssetPath { get; set; } = string.Empty;
    public Material? CachedRiverWaterMaterial { get; set; }
    public string? CachedRiverWaterMaterialPath { get; set; }
    public float RiverWaterWidthMultiplier { get; set; }
    public float RiverWaterBedClearance { get; set; }
    public float RiverWaterMeshVerticalOffset { get; set; }
    public float RiverWaterMeshVerticalOffsetAtNinetyDegrees { get; set; }
    public float RiverWaterMinimumDownstreamDrop { get; set; }
    public int RiverWaterSampleStride { get; set; }
    public int RiverSplineSamplingStep { get; set; }
    public int RiverSplineAvgElements { get; set; }
    public float RiverWaterUvLengthScale { get; set; }
    public float RiverWaterUvWidthScale { get; set; }
    public float RiverWaterSpeedMultiplier { get; set; }
    public float RiverWaterMinSegmentLength { get; set; }
    public int RiverWaterTangentSmoothingRadius { get; set; }
    public float TerrainWidth { get; set; }
    public float TerrainLength { get; set; }
}

internal sealed class TileLoaderRiverBuilder
{
    private static readonly ProfilerMarker RiverPathMeshMarker = new("TileLoader.RiverWater.BuildPathMesh");
    private static readonly ProfilerMarker RiverCombinedMeshMarker = new("TileLoader.RiverWater.CombineMeshes");
    private readonly TileLoaderRiverSettings settings;
    private readonly TileLoaderTerrainSampler terrainSampler;
    private readonly string defaultRiverWaterMaterialAssetPath;

    public TileLoaderRiverBuilder(
        TileLoaderRiverSettings settings,
        TileLoaderTerrainSampler terrainSampler,
        string defaultRiverWaterMaterialAssetPath)
    {
        this.settings = settings;
        this.terrainSampler = terrainSampler;
        this.defaultRiverWaterMaterialAssetPath = defaultRiverWaterMaterialAssetPath;
    }

    public void PopulateRiverWater(
        IReadOnlyList<GeneratedTerrainRequest> terrainRequests,
        IReadOnlyList<GStylizedTerrain> terrains,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        Dictionary<string, Spline> riverSplineCache,
        UnityEngine.Object owner)
    {
        if (!settings.CreateRiverWater)
        {
            return;
        }

        var riverWaterSeams = new Dictionary<string, RiverWaterSeamCrossSection>(StringComparer.Ordinal);
        int terrainCount = Math.Min(terrainRequests.Count, terrains.Count);
        for (int i = 0; i < terrainCount; i++)
        {
            PopulateRiverWaterForTerrain(
                terrainRequests[i],
                terrains[i],
                normalizationMinHeight,
                normalizationMaxHeight,
                riverSplineCache,
                riverWaterSeams,
                owner);
        }
    }

    public bool PopulateRiverWaterForTerrain(
        GeneratedTerrainRequest request,
        GStylizedTerrain? terrain,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        Dictionary<string, Spline> riverSplineCache,
        IDictionary<string, RiverWaterSeamCrossSection> riverWaterSeams,
        UnityEngine.Object owner)
    {
        IReadOnlyList<RiverSurfacePath> riverPaths = request.Layers.RiverSurfacePaths;
        if (riverPaths.Count == 0 || terrain == null)
        {
            return false;
        }

        Material? waterMaterial = ResolveRiverWaterMaterial();
        if (waterMaterial == null)
        {
            Debug.LogWarning(
                $"TileLoader could not resolve the Stylized Water river material at '{GetRiverWaterMaterialAssetPath()}'. Generated river meshes were skipped.",
                owner);
            return false;
        }

        Transform riverContainer = CreateRiverWaterContainer(terrain.transform);
        Mesh? riverMesh = BuildRiverWaterMesh(
            terrain,
            request.Layers.RiverSurfaceHeightmap ?? request.Layers.Heightmap,
            request,
            riverPaths,
            request.Layers.RiverInfo,
            riverWaterSeams,
            request.Layers.RiverUsesProfile,
            riverSplineCache,
            normalizationMinHeight,
            normalizationMaxHeight);
        if (riverMesh == null)
        {
            return false;
        }

        var riverObject = new GameObject("RiverWater");
        riverObject.transform.SetParent(riverContainer, false);
        riverObject.transform.localPosition = Vector3.zero;
        riverObject.transform.localRotation = Quaternion.identity;
        riverObject.transform.localScale = Vector3.one;
        ApplyRiverWaterLayer(riverObject);

        MeshFilter meshFilter = riverObject.AddComponent<MeshFilter>();
        meshFilter.sharedMesh = riverMesh;

        MeshRenderer meshRenderer = riverObject.AddComponent<MeshRenderer>();
        meshRenderer.sharedMaterial = waterMaterial;
        ApplyRiverWaterMaterialOverrides(meshRenderer, waterMaterial);
        meshRenderer.shadowCastingMode = ShadowCastingMode.Off;
        meshRenderer.receiveShadows = false;
        return true;
    }

    public int GetRiverWaterPathCount(GeneratedTerrainRequest request, GStylizedTerrain? terrain)
    {
        if (!settings.CreateRiverWater || terrain == null)
        {
            return 0;
        }

        return request.Layers.RiverSurfacePaths.Count;
    }

    public bool PopulateRiverWaterForPath(
        GeneratedTerrainRequest request,
        GStylizedTerrain? terrain,
        int riverPathIndex,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        Dictionary<string, Spline> riverSplineCache,
        IDictionary<string, RiverWaterSeamCrossSection> riverWaterSeams,
        UnityEngine.Object owner)
    {
        if (!settings.CreateRiverWater || terrain == null)
        {
            return false;
        }

        IReadOnlyList<RiverSurfacePath> riverPaths = request.Layers.RiverSurfacePaths;
        if ((uint)riverPathIndex >= (uint)riverPaths.Count)
        {
            return false;
        }

        Material? waterMaterial = ResolveRiverWaterMaterial();
        if (waterMaterial == null)
        {
            Debug.LogWarning(
                $"TileLoader could not resolve the Stylized Water river material at '{GetRiverWaterMaterialAssetPath()}'. Generated river meshes were skipped.",
                owner);
            return false;
        }

        Mesh? riverMesh = BuildRiverWaterMesh(
            terrain,
            request.Layers.RiverSurfaceHeightmap ?? request.Layers.Heightmap,
            request,
            riverPaths[riverPathIndex],
            riverPathIndex,
            request.Layers.RiverInfo,
            riverWaterSeams,
            request.Layers.RiverUsesProfile,
            riverSplineCache,
            normalizationMinHeight,
            normalizationMaxHeight);
        if (riverMesh == null)
        {
            return false;
        }

        Transform riverContainer = CreateRiverWaterContainer(terrain.transform);
        var riverObject = new GameObject($"RiverWater_{riverPathIndex.ToString(CultureInfo.InvariantCulture)}");
        riverObject.transform.SetParent(riverContainer, false);
        riverObject.transform.localPosition = Vector3.zero;
        riverObject.transform.localRotation = Quaternion.identity;
        riverObject.transform.localScale = Vector3.one;
        ApplyRiverWaterLayer(riverObject);

        MeshFilter meshFilter = riverObject.AddComponent<MeshFilter>();
        meshFilter.sharedMesh = riverMesh;

        MeshRenderer meshRenderer = riverObject.AddComponent<MeshRenderer>();
        meshRenderer.sharedMaterial = waterMaterial;
        ApplyRiverWaterMaterialOverrides(meshRenderer, waterMaterial);
        meshRenderer.shadowCastingMode = ShadowCastingMode.Off;
        meshRenderer.receiveShadows = false;
        return true;
    }

    public void PopulateRiverDebugSplines(
        IReadOnlyList<GeneratedTerrainRequest> terrainRequests,
        IReadOnlyList<GStylizedTerrain> terrains,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        Dictionary<string, Spline> riverSplineCache)
    {
        if (!settings.CreateRiverDebugSplines)
        {
            return;
        }

        int terrainCount = Math.Min(terrainRequests.Count, terrains.Count);
        for (int i = 0; i < terrainCount; i++)
        {
            PopulateRiverDebugSplinesForTerrain(
                terrainRequests[i],
                terrains[i],
                normalizationMinHeight,
                normalizationMaxHeight,
                riverSplineCache);
        }
    }

    public bool PopulateRiverDebugSplinesForTerrain(
        GeneratedTerrainRequest request,
        GStylizedTerrain? terrain,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        Dictionary<string, Spline> riverSplineCache)
    {
        IReadOnlyList<RiverSurfacePath> riverPaths = request.Layers.RiverSurfacePaths;
        if (riverPaths.Count == 0 || terrain == null)
        {
            return false;
        }

        Transform riverContainer = CreateRiverWaterContainer(terrain.transform);
        SplineContainer splineContainer = CreateRiverDebugSplineContainer(riverContainer);
        IReadOnlyList<Spline> splines = BuildRiverDebugSplines(
            terrain,
            request.Layers.RiverSurfaceHeightmap ?? request.Layers.Heightmap,
            request,
            riverPaths,
            riverSplineCache,
            normalizationMinHeight,
            normalizationMaxHeight);
        splineContainer.Splines = splines;
        splineContainer.gameObject.SetActive(splines.Count > 0);
        return splines.Count > 0;
    }

    private void ApplyRiverWaterMaterialOverrides(MeshRenderer meshRenderer, Material waterMaterial)
    {
        float speedMultiplier = Mathf.Max(0f, settings.RiverWaterSpeedMultiplier);
        if (Mathf.Approximately(speedMultiplier, 1f))
        {
            return;
        }

        var propertyBlock = new MaterialPropertyBlock();
        meshRenderer.GetPropertyBlock(propertyBlock);
        ApplyScaledMaterialFloat(propertyBlock, waterMaterial, "_Speed", speedMultiplier);
        ApplyScaledMaterialFloat(propertyBlock, waterMaterial, "_NormalSpeed", speedMultiplier);
        ApplyScaledMaterialFloat(propertyBlock, waterMaterial, "_FoamSpeed", speedMultiplier);
        ApplyScaledMaterialFloat(propertyBlock, waterMaterial, "_FoamSubSpeed", speedMultiplier);
        ApplyScaledMaterialFloat(propertyBlock, waterMaterial, "_IntersectionSpeed", speedMultiplier);
        ApplyScaledMaterialFloat(propertyBlock, waterMaterial, "_WaveSpeed", speedMultiplier);
        ApplyScaledMaterialFloat(propertyBlock, waterMaterial, "_SlopeSpeed", speedMultiplier);
        meshRenderer.SetPropertyBlock(propertyBlock);
    }

    private static void ApplyScaledMaterialFloat(
        MaterialPropertyBlock propertyBlock,
        Material sourceMaterial,
        string propertyName,
        float multiplier)
    {
        if (!sourceMaterial.HasProperty(propertyName))
        {
            return;
        }

        propertyBlock.SetFloat(propertyName, sourceMaterial.GetFloat(propertyName) * multiplier);
    }

    private Mesh? BuildRiverWaterMesh(
        GStylizedTerrain? terrain,
        double[,] heightmap,
        GeneratedTerrainRequest request,
        IReadOnlyList<RiverSurfacePath> riverPaths,
        RiverInfo? riverInfo,
        IDictionary<string, RiverWaterSeamCrossSection> riverWaterSeams,
        bool usesRiverProfile,
        Dictionary<string, Spline> riverSplineCache,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        var combineInstances = new List<CombineInstance>();
        int vertexCount = 0;

        for (int i = 0; i < riverPaths.Count; i++)
        {
            Mesh? pathMesh = BuildRiverWaterMesh(
                terrain,
                heightmap,
                request,
                riverPaths[i],
                i,
                riverInfo,
                riverWaterSeams,
                usesRiverProfile,
                riverSplineCache,
                normalizationMinHeight,
                normalizationMaxHeight);
            if (pathMesh == null)
            {
                continue;
            }

            vertexCount += pathMesh.vertexCount;
            combineInstances.Add(new CombineInstance
            {
                mesh = pathMesh,
                transform = Matrix4x4.identity,
            });
        }

        if (combineInstances.Count == 0)
        {
            return null;
        }

        if (combineInstances.Count == 1)
        {
            combineInstances[0].mesh.name = "Generated River Water Mesh";
            return combineInstances[0].mesh;
        }

        using (RiverCombinedMeshMarker.Auto())
        {
            var combinedMesh = new Mesh
            {
                name = "Generated River Water Mesh"
            };
            if (vertexCount > ushort.MaxValue)
            {
                combinedMesh.indexFormat = IndexFormat.UInt32;
            }

            combinedMesh.CombineMeshes(combineInstances.ToArray(), true, false, false);
            combinedMesh.RecalculateBounds();
            combinedMesh.RecalculateNormals();
            combinedMesh.RecalculateTangents();
            return combinedMesh;
        }
    }

    private Mesh? BuildRiverWaterMesh(
        GStylizedTerrain? terrain,
        double[,] heightmap,
        GeneratedTerrainRequest request,
        RiverSurfacePath riverPath,
        int riverPathIndex,
        RiverInfo? riverInfo,
        IDictionary<string, RiverWaterSeamCrossSection> riverWaterSeams,
        bool usesRiverProfile,
        Dictionary<string, Spline> riverSplineCache,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        using (RiverPathMeshMarker.Auto())
        {
        IReadOnlyList<RiverSurfacePoint> pathPoints = riverPath.Points;
        if (pathPoints.Count < 2 || riverPath.HalfWidthPixels <= 0.0)
        {
            return null;
        }

        var centers = new List<Vector3>();
        var sampledPoints = new List<RiverSurfacePoint>();
        var sampleSeams = new List<(bool IsSeam, string? Direction, bool IsStart)>();
        int heightResolution = heightmap.GetLength(0);
        int widthResolution = heightmap.GetLength(1);
        float sampleSpacingX = widthResolution > 1 ? settings.TerrainWidth / (widthResolution - 1) : settings.TerrainWidth;
        float sampleSpacingZ = heightResolution > 1 ? settings.TerrainLength / (heightResolution - 1) : settings.TerrainLength;
        if (!TryBuildRiverWaterSplineSamples(
                terrain,
                heightmap,
                request,
                riverPath,
                riverPathIndex,
                pathPoints,
                sampleSpacingX,
                sampleSpacingZ,
                riverSplineCache,
                normalizationMinHeight,
                normalizationMaxHeight,
                centers,
                sampledPoints,
                sampleSeams))
        {
            return null;
        }

        ApplyRiverSplineAveraging();
        float[] riverSlopeDegrees = BuildRiverWaterSlopeDegrees(centers);
        float metersPerSample = Mathf.Max(0.001f, (sampleSpacingX + sampleSpacingZ) * 0.5f);
        float baseHalfWidth = Mathf.Max(
            0.05f,
            (float)riverPath.HalfWidthPixels * metersPerSample * Mathf.Max(0.05f, settings.RiverWaterWidthMultiplier));
        float uvLengthScale = Mathf.Max(0.1f, settings.RiverWaterUvLengthScale);
        float uvWidthScale = Mathf.Max(0.1f, settings.RiverWaterUvWidthScale);
        float fadeFraction = Mathf.Clamp01((float)riverPath.FadeFraction);
        int tangentSmoothingRadius = Math.Max(1, settings.RiverWaterTangentSmoothingRadius);

        ApplyRiverWaterSurfaceHeights();
        ApplyRiverWaterSeamCenterCache();
        SmoothRiverWaterSeamAdjacentHeights();

        var vertices = new List<Vector3>(centers.Count * 2);
        var uvs = new List<Vector2>(centers.Count * 2);
        var colors = new List<Color>(centers.Count * 2);
        var triangles = new List<int>(Mathf.Max(0, centers.Count - 1) * 6);
        float downstreamDistance = 0f;

        for (int i = 0; i < centers.Count; i++)
        {
            if (i > 0)
            {
                downstreamDistance += HorizontalDistance(centers[i - 1], centers[i]);
            }

            Vector3 tangent = GetRiverWaterTangent(centers, sampledPoints, i, tangentSmoothingRadius);
            var seam = GetTileEdgeSeamInfluence(i);
            bool isTileEdgeSeam = seam.IsSeam && seam.Weight >= 0.999f;
            if (seam.IsSeam &&
                TryGetRiverWaterSeamTangent(seam.Direction, seam.IsStart, out Vector3 seamTangent))
            {
                tangent = isTileEdgeSeam
                    ? seamTangent
                    : Vector3.Slerp(tangent, seamTangent, Mathf.Clamp01(seam.Weight)).normalized;
            }

            Vector3 right = new(tangent.z, 0f, -tangent.x);
            if (right.sqrMagnitude <= 0.0001f)
            {
                right = Vector3.right;
            }
            else
            {
                right.Normalize();
            }

            float branchT = centers.Count > 1 ? i / (float)(centers.Count - 1) : 0f;
            float widthFactor = 1f;
            if (fadeFraction > 0f)
            {
                widthFactor = 1f - Mathf.InverseLerp(1f - fadeFraction, 1f, branchT);
            }

            float halfWidth = isTileEdgeSeam
                ? GetRiverWaterSeamHalfWidth(seam.Direction, seam.IsStart, baseHalfWidth, metersPerSample)
                : baseHalfWidth * Mathf.Clamp01(widthFactor);
            Vector3 leftVertex = centers[i] - right * halfWidth;
            Vector3 rightVertex = centers[i] + right * halfWidth;
            if (isTileEdgeSeam)
            {
                ApplyRiverWaterSeamCache(terrain, centers[i], riverWaterSeams, ref leftVertex, ref rightVertex);
            }

            float uvY = -downstreamDistance / uvLengthScale;

            vertices.Add(leftVertex);
            vertices.Add(rightVertex);
            uvs.Add(new Vector2(0f, uvY));
            uvs.Add(new Vector2(uvWidthScale, uvY));
            colors.Add(Color.white);
            colors.Add(Color.white);

            if (i == 0)
            {
                continue;
            }

            int left0 = (i - 1) * 2;
            int right0 = left0 + 1;
            int left1 = i * 2;
            int right1 = left1 + 1;
            triangles.Add(left0);
            triangles.Add(left1);
            triangles.Add(right0);
            triangles.Add(right0);
            triangles.Add(left1);
            triangles.Add(right1);
        }

        var mesh = new Mesh
        {
            name = "Generated River Water Mesh"
        };
        if (vertices.Count > ushort.MaxValue)
        {
            mesh.indexFormat = IndexFormat.UInt32;
        }

        mesh.SetVertices(vertices);
        mesh.SetUVs(0, uvs);
        mesh.SetColors(colors);
        mesh.SetTriangles(triangles, 0);
        mesh.RecalculateBounds();
        mesh.RecalculateNormals();
        mesh.RecalculateTangents();
        return mesh;

        void ApplyRiverSplineAveraging()
        {
            int averagingElements = Math.Max(1, settings.RiverSplineAvgElements);
            if (averagingElements <= 1 || centers.Count <= 1)
            {
                return;
            }

            int halfBefore = (averagingElements - 1) / 2;
            int halfAfter = averagingElements / 2;
            var averagedY = new float[centers.Count];

            for (int i = 0; i < centers.Count; i++)
            {
                int start = Math.Max(0, i - halfBefore);
                int end = Math.Min(centers.Count - 1, i + halfAfter);
                float sum = 0f;
                int count = 0;
                for (int sampleIndex = start; sampleIndex <= end; sampleIndex++)
                {
                    sum += centers[sampleIndex].y;
                    count++;
                }

                averagedY[i] = count > 0 ? sum / count : centers[i].y;
            }

            for (int i = 0; i < centers.Count; i++)
            {
                Vector3 center = centers[i];
                centers[i] = new Vector3(center.x, averagedY[i], center.z);
            }
        }

        void ApplyRiverWaterSurfaceHeights()
        {
            float bedClearance = usesRiverProfile ? 0f : Mathf.Max(0f, settings.RiverWaterBedClearance);
            float profileInset = usesRiverProfile ? 0.01f : 0f;
            var centerBedHeights = new float[centers.Count];

            for (int i = 0; i < centers.Count; i++)
            {
                centerBedHeights[i] = centers[i].y;
                float meshVerticalOffset = EvaluateSlopeDrivenRiverValue(
                    settings.RiverWaterMeshVerticalOffset,
                    settings.RiverWaterMeshVerticalOffsetAtNinetyDegrees,
                    riverSlopeDegrees[i]);
                float surfaceY = centerBedHeights[i] + bedClearance + meshVerticalOffset - profileInset;
                centers[i] = new Vector3(centers[i].x, surfaceY, centers[i].z);
            }

            if (usesRiverProfile)
            {
                return;
            }

            float dropPerSegment = centers.Count > 1
                ? Mathf.Max(0f, settings.RiverWaterMinimumDownstreamDrop) / (centers.Count - 1)
                : 0f;
            for (int i = 1; i < centers.Count; i++)
            {
                if (GetTileEdgeSeam(i).IsSeam)
                {
                    continue;
                }

                float maxDownstreamSurfaceY = centers[i - 1].y - dropPerSegment;
                if (centers[i].y > maxDownstreamSurfaceY)
                {
                    centers[i] = new Vector3(centers[i].x, maxDownstreamSurfaceY, centers[i].z);
                }
            }
        }

        (bool IsSeam, string? Direction, bool IsStart) GetTileEdgeSeam(int sampleIndex)
        {
            if (sampleIndex < 0 || sampleIndex >= sampleSeams.Count)
            {
                return default;
            }

            return sampleSeams[sampleIndex];
        }

        float GetRiverWaterSeamHalfWidth(string? direction, bool isStart, float fallbackHalfWidth, float sampleMetersPerSample)
        {
            if (riverInfo != null &&
                TryGetRiverWaterEndpointFlow(riverInfo, direction, isStart, out double flow))
            {
                return Mathf.Max(
                    0.05f,
                    (float)MapRiverFlowToWaterWidthPixels(flow) *
                    sampleMetersPerSample *
                    Mathf.Max(0.05f, settings.RiverWaterWidthMultiplier));
            }

            return fallbackHalfWidth;
        }

        void ApplyRiverWaterSeamCenterCache()
        {
            if (terrain == null)
            {
                return;
            }

            Transform terrainTransform = terrain.transform;
            for (int i = 0; i < centers.Count; i++)
            {
                if (!GetTileEdgeSeam(i).IsSeam ||
                    !TryGetRiverWaterSeamKey(terrainTransform, centers[i], out string seamKey))
                {
                    continue;
                }

                if (riverWaterSeams.TryGetValue(seamKey, out RiverWaterSeamCrossSection seam))
                {
                    centers[i] = terrainTransform.InverseTransformPoint(seam.CenterWorld);
                    continue;
                }

                riverWaterSeams[seamKey] = new RiverWaterSeamCrossSection(
                    terrainTransform.TransformPoint(centers[i]));
            }
        }

        void SmoothRiverWaterSeamAdjacentHeights()
        {
            if (centers.Count < 3)
            {
                return;
            }

            if (GetTileEdgeSeam(0).IsSeam)
            {
                SmoothRiverWaterSeamAdjacentHeightsFrom(0, 1);
            }

            int lastIndex = centers.Count - 1;
            if (GetTileEdgeSeam(lastIndex).IsSeam)
            {
                SmoothRiverWaterSeamAdjacentHeightsFrom(lastIndex, -1);
            }
        }

        void SmoothRiverWaterSeamAdjacentHeightsFrom(int seamIndex, int direction)
        {
            int maxOffset = Math.Min(2, centers.Count - 1);
            for (int offset = 1; offset <= maxOffset; offset++)
            {
                int index = seamIndex + direction * offset;
                if (index < 0 || index >= centers.Count)
                {
                    break;
                }

                float weight = offset == 1 ? 0.65f : 0.35f;
                Vector3 center = centers[index];
                center.y = Mathf.Lerp(center.y, centers[seamIndex].y, weight);
                centers[index] = center;
            }
        }

        (bool IsSeam, string? Direction, bool IsStart, float Weight) GetTileEdgeSeamInfluence(int sampleIndex)
        {
            var seam = GetTileEdgeSeam(sampleIndex);
            if (seam.IsSeam)
            {
                return (true, seam.Direction, seam.IsStart, 1f);
            }

            if (sampleIndex <= 2)
            {
                var startSeam = GetTileEdgeSeam(0);
                if (startSeam.IsSeam)
                {
                    float weight = sampleIndex == 1 ? 0.85f : 0.45f;
                    return (true, startSeam.Direction, startSeam.IsStart, weight);
                }
            }

            int lastIndex = sampleSeams.Count - 1;
            int distanceFromEnd = lastIndex - sampleIndex;
            if (distanceFromEnd >= 1 && distanceFromEnd <= 2)
            {
                var endSeam = GetTileEdgeSeam(lastIndex);
                if (endSeam.IsSeam)
                {
                    float weight = distanceFromEnd == 1 ? 0.85f : 0.45f;
                    return (true, endSeam.Direction, endSeam.IsStart, weight);
                }
            }

            return default;
        }
        }
    }

    private Transform CreateRiverWaterContainer(Transform terrainTransform)
    {
        string containerName = string.IsNullOrWhiteSpace(settings.GeneratedRiverWaterContainerName)
            ? "Rivers"
            : settings.GeneratedRiverWaterContainerName.Trim();
        Transform existing = terrainTransform.Find(containerName);
        if (existing != null)
        {
            return existing;
        }

        var container = new GameObject(containerName);
        container.transform.SetParent(terrainTransform, false);
        container.transform.localPosition = Vector3.zero;
        container.transform.localRotation = Quaternion.identity;
        container.transform.localScale = Vector3.one;
        ApplyRiverWaterLayer(container);
        return container.transform;
    }

    private SplineContainer CreateRiverDebugSplineContainer(Transform riverContainer)
    {
        string containerName = string.IsNullOrWhiteSpace(settings.GeneratedRiverSplineContainerName)
            ? "RiverDebugSpline"
            : settings.GeneratedRiverSplineContainerName.Trim();
        Transform existing = riverContainer.Find(containerName);
        GameObject containerObject;
        if (existing != null)
        {
            containerObject = existing.gameObject;
        }
        else
        {
            containerObject = new GameObject(containerName);
            containerObject.transform.SetParent(riverContainer, false);
            containerObject.transform.localPosition = Vector3.zero;
            containerObject.transform.localRotation = Quaternion.identity;
            containerObject.transform.localScale = Vector3.one;
        }

        SplineContainer splineContainer = containerObject.GetComponent<SplineContainer>();
        if (splineContainer == null)
        {
            splineContainer = containerObject.AddComponent<SplineContainer>();
        }

        return splineContainer;
    }

    private IReadOnlyList<Spline> BuildRiverDebugSplines(
        GStylizedTerrain terrain,
        double[,] heightmap,
        GeneratedTerrainRequest request,
        IReadOnlyList<RiverSurfacePath> riverPaths,
        Dictionary<string, Spline> riverSplineCache,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        var splines = new List<Spline>(riverPaths.Count);
        int heightResolution = heightmap.GetLength(0);
        int widthResolution = heightmap.GetLength(1);
        float sampleSpacingX = widthResolution > 1 ? settings.TerrainWidth / (widthResolution - 1f) : settings.TerrainWidth;
        float sampleSpacingZ = heightResolution > 1 ? settings.TerrainLength / (heightResolution - 1f) : settings.TerrainLength;

        for (int i = 0; i < riverPaths.Count; i++)
        {
            Spline? spline = BuildRiverDebugSpline(
                terrain,
                heightmap,
                request,
                riverPaths[i],
                i,
                riverSplineCache,
                sampleSpacingX,
                sampleSpacingZ,
                normalizationMinHeight,
                normalizationMaxHeight);
            if (spline != null)
            {
                splines.Add(spline);
            }
        }

        return splines;
    }

    private Spline? BuildRiverDebugSpline(
        GStylizedTerrain terrain,
        double[,] heightmap,
        GeneratedTerrainRequest request,
        RiverSurfacePath riverPath,
        int riverPathIndex,
        Dictionary<string, Spline> riverSplineCache,
        float sampleSpacingX,
        float sampleSpacingZ,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        return GetOrBuildRiverTerrainConformedSpline(
            riverSplineCache,
            request,
            riverPathIndex,
            terrain,
            heightmap,
            riverPath,
            sampleSpacingX,
            sampleSpacingZ,
            normalizationMinHeight,
            normalizationMaxHeight,
            1,
            TangentMode.Linear);
    }

    private Spline? BuildRiverTerrainConformedSpline(
        GStylizedTerrain? terrain,
        double[,] heightmap,
        RiverSurfacePath riverPath,
        float sampleSpacingX,
        float sampleSpacingZ,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        int knotStep,
        TangentMode tangentMode)
    {
        IReadOnlyList<RiverSurfacePoint> pathPoints = riverPath.Points;
        if (pathPoints.Count < 2)
        {
            return null;
        }

        var spline = new Spline();
        int effectiveStep = Math.Max(1, knotStep);
        float terrainSampleSpacingX = Mathf.Max(0.05f, sampleSpacingX);
        float terrainSampleSpacingZ = Mathf.Max(0.05f, sampleSpacingZ);

        for (int i = 0; i < pathPoints.Count; i += effectiveStep)
        {
            AddRiverSplineKnot(i);
        }

        if ((pathPoints.Count - 1) % effectiveStep != 0)
        {
            AddRiverSplineKnot(pathPoints.Count - 1);
        }

        return spline.Count >= 2 ? spline : null;

        void AddRiverSplineKnot(int index)
        {
            RiverSurfacePoint pathPoint = pathPoints[index];
            Vector3 localPoint = terrainSampler.GetTerrainLocalPoint(
                terrain,
                heightmap,
                pathPoint.X,
                pathPoint.Y,
                normalizationMinHeight,
                normalizationMaxHeight,
                0f);

            if (terrain != null &&
                terrainSampler.TrySampleGeneratedTerrainLocalMinimumPoint3x3(
                    terrain,
                    localPoint.x,
                    localPoint.z,
                    terrainSampleSpacingX,
                    terrainSampleSpacingZ,
                    out float sampledMinY))
            {
                localPoint.y = sampledMinY;
            }

            spline.Add(new float3(localPoint.x, localPoint.y, localPoint.z), tangentMode);
        }
    }

    private Spline? GetOrBuildRiverTerrainConformedSpline(
        Dictionary<string, Spline> riverSplineCache,
        GeneratedTerrainRequest request,
        int riverPathIndex,
        GStylizedTerrain? terrain,
        double[,] heightmap,
        RiverSurfacePath riverPath,
        float sampleSpacingX,
        float sampleSpacingZ,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        int knotStep,
        TangentMode tangentMode)
    {
        string cacheKey = string.Join(
            "|",
            request.UnityTileX.ToString(CultureInfo.InvariantCulture),
            request.UnityTileY.ToString(CultureInfo.InvariantCulture),
            riverPathIndex.ToString(CultureInfo.InvariantCulture),
            knotStep.ToString(CultureInfo.InvariantCulture),
            ((int)tangentMode).ToString(CultureInfo.InvariantCulture),
            heightmap.GetLength(0).ToString(CultureInfo.InvariantCulture),
            heightmap.GetLength(1).ToString(CultureInfo.InvariantCulture));

        if (riverSplineCache.TryGetValue(cacheKey, out Spline cachedSpline))
        {
            return cachedSpline;
        }

        Spline? spline = BuildRiverTerrainConformedSpline(
            terrain,
            heightmap,
            riverPath,
            sampleSpacingX,
            sampleSpacingZ,
            normalizationMinHeight,
            normalizationMaxHeight,
            knotStep,
            tangentMode);
        if (spline != null)
        {
            riverSplineCache[cacheKey] = spline;
        }

        return spline;
    }

    private bool TryBuildRiverWaterSplineSamples(
        GStylizedTerrain? terrain,
        double[,] heightmap,
        GeneratedTerrainRequest request,
        RiverSurfacePath riverPath,
        int riverPathIndex,
        IReadOnlyList<RiverSurfacePoint> pathPoints,
        float sampleSpacingX,
        float sampleSpacingZ,
        Dictionary<string, Spline> riverSplineCache,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        List<Vector3> centers,
        List<RiverSurfacePoint> sampledPoints,
        List<(bool IsSeam, string? Direction, bool IsStart)> sampleSeams)
    {
        int splineStep = Math.Max(1, settings.RiverSplineSamplingStep);
        Spline? spline = GetOrBuildRiverTerrainConformedSpline(
            riverSplineCache,
            request,
            riverPathIndex,
            terrain,
            heightmap,
            riverPath,
            sampleSpacingX,
            sampleSpacingZ,
            normalizationMinHeight,
            normalizationMaxHeight,
            splineStep,
            TangentMode.AutoSmooth);

        if (spline == null)
        {
            return false;
        }

        var sourceSampleIndices = new List<int>();
        int meshStride = Math.Max(1, settings.RiverWaterSampleStride);
        for (int i = 0; i < pathPoints.Count; i += meshStride)
        {
            sourceSampleIndices.Add(i);
        }

        if (sourceSampleIndices.Count == 0 || sourceSampleIndices[^1] != pathPoints.Count - 1)
        {
            sourceSampleIndices.Add(pathPoints.Count - 1);
        }

        float minSegmentLength = Mathf.Max(0f, settings.RiverWaterMinSegmentLength);
        float minSegmentSqr = minSegmentLength * minSegmentLength;
        float denominator = Math.Max(1, pathPoints.Count - 1);

        for (int sampleIndex = 0; sampleIndex < sourceSampleIndices.Count; sampleIndex++)
        {
            int sourceIndex = sourceSampleIndices[sampleIndex];
            RiverSurfacePoint pathPoint = pathPoints[sourceIndex];
            float t = sourceIndex / denominator;
            float3 splinePosition = spline.EvaluatePosition(t);
            Vector3 localPoint = new(splinePosition.x, splinePosition.y, splinePosition.z);
            var seam = GetRiverWaterEndpointSeamForPathIndex(pathPoints, heightmap, sourceIndex, pathPoint);

            if (centers.Count > 0 && minSegmentLength > 0f)
            {
                if ((localPoint - centers[^1]).sqrMagnitude < minSegmentSqr)
                {
                    if (sampleIndex == sourceSampleIndices.Count - 1)
                    {
                        centers[^1] = localPoint;
                        sampledPoints[^1] = pathPoint;
                        sampleSeams[^1] = seam;
                    }

                    continue;
                }
            }

            centers.Add(localPoint);
            sampledPoints.Add(pathPoint);
            sampleSeams.Add(seam);
        }

        return centers.Count >= 2;
    }

    private Material? ResolveRiverWaterMaterial()
    {
        if (settings.RiverWaterMaterial != null)
        {
            return settings.RiverWaterMaterial;
        }

        string assetPath = GetRiverWaterMaterialAssetPath();
        if (settings.CachedRiverWaterMaterial != null &&
            string.Equals(settings.CachedRiverWaterMaterialPath, assetPath, StringComparison.OrdinalIgnoreCase))
        {
            return settings.CachedRiverWaterMaterial;
        }

#if UNITY_EDITOR
        Material material = AssetDatabase.LoadAssetAtPath<Material>(assetPath);
        if (material != null)
        {
            settings.CachedRiverWaterMaterial = material;
            settings.CachedRiverWaterMaterialPath = assetPath;
            return material;
        }
#endif

        return null;
    }

    private string GetRiverWaterMaterialAssetPath()
    {
        return string.IsNullOrWhiteSpace(settings.RiverWaterMaterialAssetPath)
            ? defaultRiverWaterMaterialAssetPath
            : settings.RiverWaterMaterialAssetPath.Replace('\\', '/').Trim();
    }

    private static Vector3 GetRiverWaterTangent(
        IReadOnlyList<Vector3> centers,
        IReadOnlyList<RiverSurfacePoint> sampledPoints,
        int index,
        int smoothingRadius)
    {
        int radius = Math.Max(1, smoothingRadius);
        int previousIndex = Math.Max(0, index - radius);
        int nextIndex = Math.Min(centers.Count - 1, index + radius);
        Vector3 tangent = centers[nextIndex] - centers[previousIndex];
        tangent.y = 0f;
        if (tangent.sqrMagnitude <= 0.0001f && sampledPoints.Count == centers.Count)
        {
            RiverSurfacePoint previous = sampledPoints[previousIndex];
            RiverSurfacePoint next = sampledPoints[nextIndex];
            tangent = new Vector3((float)(next.X - previous.X), 0f, (float)(previous.Y - next.Y));
        }

        if (tangent.sqrMagnitude <= 0.0001f)
        {
            return Vector3.forward;
        }

        return tangent.normalized;
    }

    private static float[] BuildRiverWaterSlopeDegrees(IReadOnlyList<Vector3> centers)
    {
        var slopeDegrees = new float[centers.Count];
        for (int i = 0; i < centers.Count; i++)
        {
            int previousIndex = Math.Max(0, i - 1);
            int nextIndex = Math.Min(centers.Count - 1, i + 1);
            if (previousIndex == nextIndex)
            {
                continue;
            }

            Vector3 delta = centers[nextIndex] - centers[previousIndex];
            float horizontalDistance = new Vector2(delta.x, delta.z).magnitude;
            if (horizontalDistance <= 0.0001f)
            {
                continue;
            }

            slopeDegrees[i] = Mathf.Clamp(Mathf.Atan2(Mathf.Abs(delta.y), horizontalDistance) * Mathf.Rad2Deg, 0f, 90f);
        }

        return slopeDegrees;
    }

    private static float EvaluateSlopeDrivenRiverValue(float flatValue, float steepValue, float slopeDegrees)
    {
        return Mathf.Lerp(flatValue, steepValue, Mathf.Clamp01(slopeDegrees / 90f));
    }

    private static bool TryGetRiverWaterSeamTangent(string? direction, bool isStartEndpoint, out Vector3 tangent)
    {
        tangent = direction switch
        {
            "N" => Vector3.forward,
            "S" => Vector3.back,
            "E" => Vector3.right,
            "W" => Vector3.left,
            _ => Vector3.zero
        };

        if (tangent.sqrMagnitude <= 0.0001f)
        {
            return false;
        }

        if (isStartEndpoint)
        {
            tangent = -tangent;
        }

        return true;
    }

    private static (bool IsSeam, string? Direction, bool IsStart) GetRiverWaterEndpointSeamForPathIndex(
        IReadOnlyList<RiverSurfacePoint> pathPoints,
        double[,] heightmap,
        int index,
        RiverSurfacePoint pathPoint)
    {
        bool isStart = index == 0;
        if (!isStart && index != pathPoints.Count - 1)
        {
            return default;
        }

        if (TryGetRiverWaterEndpointDirection(pathPoint, heightmap, out string? direction))
        {
            return (true, direction, isStart);
        }

        return default;
    }

    private static bool TryGetRiverWaterEndpointDirection(
        RiverSurfacePoint point,
        double[,] heightmap,
        out string? direction)
    {
        const double epsilon = 1e-4;
        double maxX = Math.Max(0, heightmap.GetLength(1) - 1);
        double maxY = Math.Max(0, heightmap.GetLength(0) - 1);
        if (point.X < -epsilon)
        {
            direction = "W";
            return true;
        }

        if (point.X > maxX + epsilon)
        {
            direction = "E";
            return true;
        }

        if (point.Y < -epsilon)
        {
            direction = "N";
            return true;
        }

        if (point.Y > maxY + epsilon)
        {
            direction = "S";
            return true;
        }

        direction = null;
        return false;
    }

    private static bool TryGetRiverWaterEndpointFlow(
        RiverInfo riverInfo,
        string? direction,
        bool isStartEndpoint,
        out double flow)
    {
        flow = 0.0;
        if (string.IsNullOrWhiteSpace(direction))
        {
            return false;
        }

        Dictionary<string, double> flows = isStartEndpoint
            ? riverInfo.Inputs
            : riverInfo.Outputs;
        return flows.TryGetValue(direction, out flow) && flow > 0.0;
    }

    private static double MapRiverFlowToWaterWidthPixels(double flow)
    {
        double[] flowPoints = { 0, 0.05, 0.4, 1.0, 2, 4, 8 };
        double[] widths = { 0, 1, 4, 7, 10, 14, 20 };

        if (flow <= flowPoints[0])
        {
            return widths[0];
        }

        if (flow >= flowPoints[^1])
        {
            return widths[^1];
        }

        for (int i = 1; i < flowPoints.Length; i++)
        {
            if (flow <= flowPoints[i])
            {
                double t = (flow - flowPoints[i - 1]) / (flowPoints[i] - flowPoints[i - 1]);
                return widths[i - 1] + t * (widths[i] - widths[i - 1]);
            }
        }

        return widths[^1];
    }

    private static void ApplyRiverWaterSeamCache(
        GStylizedTerrain? terrain,
        Vector3 localCenter,
        IDictionary<string, RiverWaterSeamCrossSection> riverWaterSeams,
        ref Vector3 leftVertex,
        ref Vector3 rightVertex)
    {
        Transform? terrainTransform = terrain != null ? terrain.transform : null;
        if (terrainTransform == null ||
            !TryGetRiverWaterSeamKey(terrainTransform, localCenter, out string seamKey))
        {
            return;
        }

        if (riverWaterSeams.TryGetValue(seamKey, out RiverWaterSeamCrossSection seam))
        {
            if (seam.HasVertices)
            {
                leftVertex = terrainTransform.InverseTransformPoint(seam.LeftWorld);
                rightVertex = terrainTransform.InverseTransformPoint(seam.RightWorld);
                return;
            }

            seam.SetVertices(
                terrainTransform.TransformPoint(leftVertex),
                terrainTransform.TransformPoint(rightVertex));
        }
        else
        {
            riverWaterSeams[seamKey] = new RiverWaterSeamCrossSection(
                terrainTransform.TransformPoint(localCenter),
                terrainTransform.TransformPoint(leftVertex),
                terrainTransform.TransformPoint(rightVertex));
        }
    }

    private static bool TryGetRiverWaterSeamKey(
        Transform terrainTransform,
        Vector3 localCenter,
        out string key)
    {
        Vector3 worldCenter = terrainTransform.TransformPoint(localCenter);
        string x = Math.Round(worldCenter.x, 3).ToString("F3", CultureInfo.InvariantCulture);
        string z = Math.Round(worldCenter.z, 3).ToString("F3", CultureInfo.InvariantCulture);
        key = x + ":" + z;
        return true;
    }

    private static float HorizontalDistance(Vector3 a, Vector3 b)
    {
        float dx = b.x - a.x;
        float dz = b.z - a.z;
        return Mathf.Sqrt(dx * dx + dz * dz);
    }

    private static void ApplyRiverWaterLayer(GameObject target)
    {
        int waterLayer = LayerMask.NameToLayer("Water");
        if (waterLayer >= 0)
        {
            target.layer = waterLayer;
        }
    }
}
#endif
