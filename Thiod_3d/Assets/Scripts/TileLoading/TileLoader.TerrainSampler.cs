using UnityEngine;
using WorldGen;
#if GRIFFIN
using Pinwheel.Griffin;
using Pinwheel.Griffin.API;
#endif

#nullable enable

namespace Thiod.TileLoading.Runtime
{

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
        float clampedLocalX = Mathf.Clamp(localX, 0f, context.TerrainWidth);
        float clampedLocalZ = Mathf.Clamp(localZ, 0f, context.TerrainLength);
        Vector3 worldOrigin = terrain.transform.TransformPoint(new Vector3(clampedLocalX, context.TerrainHeight + 32f, clampedLocalZ));
        if (!terrain.Raycast(new Ray(worldOrigin, Vector3.down), out RaycastHit hit, context.TerrainHeight + 96f))
        {
            return false;
        }

        Vector3 hitLocalPoint = terrain.transform.InverseTransformPoint(hit.point);
        Vector3 hitLocalNormal = terrain.transform.InverseTransformDirection(hit.normal).normalized;
        if (hitLocalNormal.sqrMagnitude <= 0.0001f)
        {
            hitLocalNormal = Vector3.up;
        }
        else if (hitLocalNormal.y < 0f)
        {
            hitLocalNormal = -hitLocalNormal;
        }

        localPoint = new Vector3(clampedLocalX, hitLocalPoint.y + verticalOffset, clampedLocalZ);
        localNormal = hitLocalNormal;
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

    private float SampleGeneratedTerrainHeight(Texture2D heightTexture, float localX, float localZ)
    {
        float sampleX = GetGeneratedTerrainSampleX(heightTexture, localX);
        float sampleY = GetGeneratedTerrainSampleY(heightTexture, localZ);
        float height01 = SampleGeneratedTerrainHeight01(heightTexture, sampleX, sampleY);
        return height01 * context.TerrainHeight;
    }

    private Vector3 SampleGeneratedTerrainLocalNormal(Texture2D heightTexture, float localX, float localZ)
    {
        float stepX = Mathf.Max(0.5f, context.TerrainWidth / Mathf.Max(1f, heightTexture.width - 1f));
        float stepZ = Mathf.Max(0.5f, context.TerrainLength / Mathf.Max(1f, heightTexture.height - 1f));
        float leftX = Mathf.Clamp(localX - stepX, 0f, context.TerrainWidth);
        float rightX = Mathf.Clamp(localX + stepX, 0f, context.TerrainWidth);
        float backZ = Mathf.Clamp(localZ - stepZ, 0f, context.TerrainLength);
        float forwardZ = Mathf.Clamp(localZ + stepZ, 0f, context.TerrainLength);
        Vector3 pointLeft = new(leftX, SampleGeneratedTerrainHeight(heightTexture, leftX, localZ), localZ);
        Vector3 pointRight = new(rightX, SampleGeneratedTerrainHeight(heightTexture, rightX, localZ), localZ);
        Vector3 pointBack = new(localX, SampleGeneratedTerrainHeight(heightTexture, localX, backZ), backZ);
        Vector3 pointForward = new(localX, SampleGeneratedTerrainHeight(heightTexture, localX, forwardZ), forwardZ);
        Vector3 tangentX = pointRight - pointLeft;
        Vector3 tangentZ = pointForward - pointBack;
        Vector3 normal = Vector3.Cross(tangentX, tangentZ);
        if (normal.sqrMagnitude <= 0.0001f)
        {
            return Vector3.up;
        }

        normal = normal.normalized;
        return normal.y < 0f ? -normal : normal;
    }

    private float GetGeneratedTerrainSampleX(Texture2D heightTexture, float localX)
    {
        float normalizedX = context.TerrainWidth > 0f
            ? Mathf.Clamp01(localX / context.TerrainWidth)
            : 0f;
        return normalizedX * Mathf.Max(0, heightTexture.width - 1);
    }

    private float GetGeneratedTerrainSampleY(Texture2D heightTexture, float localZ)
    {
        float normalizedY = context.TerrainLength > 0f
            ? 1f - Mathf.Clamp01(localZ / context.TerrainLength)
            : 0f;
        return normalizedY * Mathf.Max(0, heightTexture.height - 1);
    }

    private static float SampleGeneratedTerrainHeight01(Texture2D heightTexture, float sampleX, float sampleY)
    {
        int x0 = Mathf.Clamp(Mathf.FloorToInt(sampleX), 0, heightTexture.width - 1);
        int x1 = Mathf.Clamp(x0 + 1, 0, heightTexture.width - 1);
        int y0 = Mathf.Clamp(Mathf.FloorToInt(sampleY), 0, heightTexture.height - 1);
        int y1 = Mathf.Clamp(y0 + 1, 0, heightTexture.height - 1);
        float tx = Mathf.Clamp01(sampleX - x0);
        float ty = Mathf.Clamp01(sampleY - y0);
        float h00 = DecodeGeneratedTerrainHeight01(heightTexture, x0, y0);
        float h10 = DecodeGeneratedTerrainHeight01(heightTexture, x1, y0);
        float h01 = DecodeGeneratedTerrainHeight01(heightTexture, x0, y1);
        float h11 = DecodeGeneratedTerrainHeight01(heightTexture, x1, y1);
        float hx0 = Mathf.Lerp(h00, h10, tx);
        float hx1 = Mathf.Lerp(h01, h11, tx);
        return Mathf.Lerp(hx0, hx1, ty);
    }

    private static float DecodeGeneratedTerrainHeight01(Texture2D heightTexture, int logicalX, int logicalY)
    {
        int clampedX = Mathf.Clamp(logicalX, 0, heightTexture.width - 1);
        int clampedY = Mathf.Clamp(logicalY, 0, heightTexture.height - 1);
        int flippedY = heightTexture.height - 1 - clampedY;
        Color sample = heightTexture.GetPixel(clampedX, flippedY);
        float height01 = 0f;
        float subdiv01 = 0f;
        float visibility01 = 0f;
        Polaris.DecodeHeightMapSample(sample, ref height01, ref subdiv01, ref visibility01);
        return height01;
    }
}

}
