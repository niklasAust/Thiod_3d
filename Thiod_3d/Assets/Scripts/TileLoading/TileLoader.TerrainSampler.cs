using UnityEngine;
using WorldGen;
#if GRIFFIN
using Pinwheel.Griffin;
#endif

#nullable enable

internal sealed class TileLoaderTerrainSampler
{
    private readonly VegetationBuildContext context;

    public TileLoaderTerrainSampler(VegetationBuildContext context)
    {
        this.context = context;
    }

    public Vector3 GetPlacementLocalPosition(
        GStylizedTerrain? terrain,
        double[,] heightmap,
        TileObjectPlacement placement,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        float verticalOffset)
    {
        return GetTerrainLocalPoint(
            terrain,
            heightmap,
            placement.X,
            placement.Y,
            normalizationMinHeight,
            normalizationMaxHeight,
            verticalOffset);
    }

    public Vector3 GetTerrainLocalPoint(
        GStylizedTerrain? terrain,
        double[,] heightmap,
        double sampleX,
        double sampleY,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        float verticalOffset)
    {
        int heightResolution = heightmap.GetLength(0);
        int widthResolution = heightmap.GetLength(1);
        float normalizedX = widthResolution > 1
            ? Mathf.Clamp01((float)(sampleX / (widthResolution - 1)))
            : 0f;
        float normalizedY = heightResolution > 1
            ? Mathf.Clamp01((float)(sampleY / (heightResolution - 1)))
            : 0f;

        float localX = normalizedX * context.TerrainWidth;
        float localZ = (1f - normalizedY) * context.TerrainLength;
        if (TrySampleGeneratedTerrainLocalPoint(terrain, localX, localZ, verticalOffset, out Vector3 terrainPoint))
        {
            return terrainPoint;
        }

        float localY = SampleTerrainHeight(heightmap, sampleX, sampleY, normalizationMinHeight, normalizationMaxHeight) +
                       verticalOffset;
        return new Vector3(localX, localY, localZ);
    }

    public Vector3 GetTerrainLocalPointFromHeightmapApprox(
        double[,] heightmap,
        double sampleX,
        double sampleY,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        float verticalOffset)
    {
        int heightResolution = heightmap.GetLength(0);
        int widthResolution = heightmap.GetLength(1);
        float normalizedX = widthResolution > 1
            ? Mathf.Clamp01((float)(sampleX / (widthResolution - 1)))
            : 0f;
        float normalizedY = heightResolution > 1
            ? Mathf.Clamp01((float)(sampleY / (heightResolution - 1)))
            : 0f;
        float localX = normalizedX * context.TerrainWidth;
        float localZ = (1f - normalizedY) * context.TerrainLength;
        float localY = SampleTerrainHeight(heightmap, sampleX, sampleY, normalizationMinHeight, normalizationMaxHeight) +
                       verticalOffset;
        return new Vector3(localX, localY, localZ);
    }

    public Vector3 GetTerrainLocalNormal(
        GStylizedTerrain? terrain,
        double[,] heightmap,
        double sampleX,
        double sampleY,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        int heightResolution = heightmap.GetLength(0);
        int widthResolution = heightmap.GetLength(1);
        if (heightResolution <= 1 || widthResolution <= 1)
        {
            return Vector3.up;
        }

        Vector3 pointLeft = GetTerrainLocalPoint(terrain, heightmap, sampleX - 1d, sampleY, normalizationMinHeight, normalizationMaxHeight, 0f);
        Vector3 pointRight = GetTerrainLocalPoint(terrain, heightmap, sampleX + 1d, sampleY, normalizationMinHeight, normalizationMaxHeight, 0f);
        Vector3 pointBack = GetTerrainLocalPoint(terrain, heightmap, sampleX, sampleY - 1d, normalizationMinHeight, normalizationMaxHeight, 0f);
        Vector3 pointForward = GetTerrainLocalPoint(terrain, heightmap, sampleX, sampleY + 1d, normalizationMinHeight, normalizationMaxHeight, 0f);

        Vector3 tangentX = pointRight - pointLeft;
        Vector3 tangentY = pointForward - pointBack;
        Vector3 normal = Vector3.Cross(tangentX, tangentY);
        return normal.sqrMagnitude <= 0.0001f ? Vector3.up : normal.normalized;
    }

    public Vector3 GetTerrainLocalNormalFromHeightmapApprox(
        double[,] heightmap,
        double sampleX,
        double sampleY,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        int heightResolution = heightmap.GetLength(0);
        int widthResolution = heightmap.GetLength(1);
        if (heightResolution <= 1 || widthResolution <= 1)
        {
            return Vector3.up;
        }

        Vector3 pointLeft = GetTerrainLocalPointFromHeightmapApprox(heightmap, sampleX - 1d, sampleY, normalizationMinHeight, normalizationMaxHeight, 0f);
        Vector3 pointRight = GetTerrainLocalPointFromHeightmapApprox(heightmap, sampleX + 1d, sampleY, normalizationMinHeight, normalizationMaxHeight, 0f);
        Vector3 pointBack = GetTerrainLocalPointFromHeightmapApprox(heightmap, sampleX, sampleY - 1d, normalizationMinHeight, normalizationMaxHeight, 0f);
        Vector3 pointForward = GetTerrainLocalPointFromHeightmapApprox(heightmap, sampleX, sampleY + 1d, normalizationMinHeight, normalizationMaxHeight, 0f);

        Vector3 tangentX = pointRight - pointLeft;
        Vector3 tangentY = pointForward - pointBack;
        Vector3 normal = Vector3.Cross(tangentX, tangentY);
        return normal.sqrMagnitude <= 0.0001f ? Vector3.up : normal.normalized;
    }

    public float SampleTerrainHeight(
        double[,] heightmap,
        double sampleX,
        double sampleY,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        double rawHeight = TileLoaderTerrainMathUtility.SampleHeightmapBilinear(heightmap, sampleX, sampleY);
        float normalizedHeight = TileLoaderTerrainMathUtility.NormalizeHeightUnitsToTerrain(rawHeight, context.MaxTileHeightUnits);
        return normalizedHeight * context.TerrainHeight;
    }

    public void PlaceSurfaceObjectInstance(
        Transform surfaceObjectTransform,
        double[,] heightmap,
        TileObjectPlacement placement,
        double normalizationMinHeight,
        double normalizationMaxHeight)
    {
        if (surfaceObjectTransform == null)
        {
            return;
        }

        GStylizedTerrain terrain = surfaceObjectTransform.GetComponentInParent<GStylizedTerrain>();
        Vector3 localSurfacePoint = GetPlacementLocalPosition(
            terrain,
            heightmap,
            placement,
            normalizationMinHeight,
            normalizationMaxHeight,
            context.SurfaceObjectVerticalOffset);
        Vector3 localSurfaceNormal = GetTerrainLocalNormal(
            terrain,
            heightmap,
            placement.X,
            placement.Y,
            normalizationMinHeight,
            normalizationMaxHeight);
        Quaternion localRotation = Quaternion.FromToRotation(Vector3.up, localSurfaceNormal);
        surfaceObjectTransform.localRotation = localRotation;
        surfaceObjectTransform.localPosition =
            localSurfacePoint +
            localSurfaceNormal * GetSurfaceObjectOffset();
    }

    public void AlignExistingSurfaceObjectToTerrain(Transform surfaceObjectTransform)
    {
        if (surfaceObjectTransform == null || !TrySampleSurfaceObjectSurface(surfaceObjectTransform, out RaycastHit surfaceHit))
        {
            return;
        }

        Quaternion worldRotation = Quaternion.FromToRotation(Vector3.up, surfaceHit.normal);
        surfaceObjectTransform.rotation = worldRotation;
        surfaceObjectTransform.position =
            surfaceHit.point +
            Vector3.up * context.SurfaceObjectVerticalOffset +
            surfaceHit.normal * GetSurfaceObjectOffset();
    }

    public bool TrySampleGeneratedTerrainLocalPoint(
        GStylizedTerrain? terrain,
        float localX,
        float localZ,
        float verticalOffset,
        out Vector3 localPoint)
    {
        return TrySampleGeneratedTerrainSurface(
            terrain,
            localX,
            localZ,
            verticalOffset,
            out localPoint,
            out _);
    }

    public bool TrySampleGeneratedTerrainSurface(
        GStylizedTerrain? terrain,
        float localX,
        float localZ,
        float verticalOffset,
        out Vector3 localPoint,
        out Vector3 localNormal)
    {
        localPoint = default;
        localNormal = Vector3.up;
        if (terrain == null || !terrain.isActiveAndEnabled || terrain.TerrainData == null)
        {
            return false;
        }

        Vector3 worldOrigin = terrain.transform.TransformPoint(new Vector3(localX, context.TerrainHeight + 32f, localZ));
        if (!terrain.Raycast(new Ray(worldOrigin, Vector3.down), out RaycastHit terrainHit, context.TerrainHeight + 96f))
        {
            return false;
        }

        Vector3 worldPoint = terrainHit.point + terrain.transform.up * verticalOffset;
        localPoint = terrain.transform.InverseTransformPoint(worldPoint);
        localNormal = terrain.transform.InverseTransformDirection(terrainHit.normal).normalized;
        if (localNormal.sqrMagnitude <= 0.0001f)
        {
            localNormal = Vector3.up;
        }

        return true;
    }

    public bool TrySampleGeneratedTerrainLocalMinimumPoint3x3(
        GStylizedTerrain? terrain,
        float localX,
        float localZ,
        float sampleSpacingX,
        float sampleSpacingZ,
        out float minimumY)
    {
        minimumY = 0f;
        if (terrain == null || !terrain.isActiveAndEnabled || terrain.TerrainData == null)
        {
            return false;
        }

        if (!TrySampleGeneratedTerrainLocalPoint(
                terrain,
                Mathf.Clamp(localX, 0f, context.TerrainWidth),
                Mathf.Clamp(localZ, 0f, context.TerrainLength),
                0f,
                out Vector3 samplePoint))
        {
            return false;
        }

        minimumY = samplePoint.y;
        return true;
    }

    public static bool TrySampleSurfaceObjectSurface(Transform surfaceObjectTransform, out RaycastHit surfaceHit)
    {
        surfaceHit = default;
        if (surfaceObjectTransform == null)
        {
            return false;
        }

#if GRIFFIN
        GStylizedTerrain terrain = surfaceObjectTransform.GetComponentInParent<GStylizedTerrain>();
        if (terrain != null && terrain.isActiveAndEnabled && terrain.TerrainData != null)
        {
            Vector3 rayOrigin = surfaceObjectTransform.position + Vector3.up * 32f;
            if (terrain.Raycast(new Ray(rayOrigin, Vector3.down), out surfaceHit, 96f))
            {
                return true;
            }
        }
#endif

        RaycastHit[] hits = Physics.RaycastAll(
            surfaceObjectTransform.position + Vector3.up * 32f,
            Vector3.down,
            96f,
            ~0,
            QueryTriggerInteraction.Ignore);
        float closestDistance = float.PositiveInfinity;
        bool foundHit = false;
        for (int i = 0; i < hits.Length; i++)
        {
            RaycastHit hit = hits[i];
            if (hit.collider == null || hit.collider.transform.IsChildOf(surfaceObjectTransform))
            {
                continue;
            }

            if (hit.distance >= closestDistance)
            {
                continue;
            }

            closestDistance = hit.distance;
            surfaceHit = hit;
            foundHit = true;
        }

        return foundHit;
    }

    private float GetSurfaceObjectOffset()
    {
        return context.SurfaceObjectConformOffset;
    }
}
