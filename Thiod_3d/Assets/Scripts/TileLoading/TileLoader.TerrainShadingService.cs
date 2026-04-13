using System;
using System.Collections.Generic;
using UnityEngine;
using Unity.Profiling;
using UnityEngine.Rendering;
#if UNITY_EDITOR
using UnityEditor;
#endif
using Pinwheel.Griffin;
using Pinwheel.Griffin.API;

#nullable enable

namespace Thiod.TileLoading.Runtime
{

[Flags]
internal enum TileLoaderTerrainSeamMask
{
    None = 0,
    Left = 1 << 0,
    Right = 1 << 1,
    Bottom = 1 << 2,
    Top = 1 << 3,
    All = Left | Right | Bottom | Top,
}

internal sealed class TerrainShadingSettings
{
    public TerrainShadingMode TerrainShadingMode { get; set; }
    public string TerrainDecalRenderingLayerName { get; set; } = string.Empty;
    public Material? LowlandTerrainMaterial { get; set; }
    public Material? LowlandTerrainMaterialVariant { get; set; }
    public Material? MidHeightTerrainMaterial { get; set; }
    public Material? SteepSlopeTerrainMaterial { get; set; }
    public Material? SteepSlopeTerrainMaterialVariant { get; set; }
    public Material? PeakTerrainMaterial { get; set; }
    public float LowlandTerrainTileSize { get; set; }
    public float MidHeightTerrainTileSize { get; set; }
    public float SteepSlopeTerrainTileSize { get; set; }
    public float PeakTerrainTileSize { get; set; }
    public float MacroVariationScale { get; set; }
    public float MacroVariationStrength { get; set; }
    public float SurfaceVariantScale { get; set; }
    public float SurfaceVariantStrength { get; set; }
    public float SurfaceVariantTransition { get; set; }
    public float SurfacePhaseOffsetStrength { get; set; }
    public float MacroTintScale { get; set; }
    public float MacroTintStrength { get; set; }
    public float MidHeightStartMeters { get; set; }
    public float MidHeightBlendMeters { get; set; }
    public float SteepSlopeStartDegrees { get; set; }
    public float SteepSlopeBlendDegrees { get; set; }
    public float FullSnowStartMeters { get; set; }
    public float FullSnowBlendMeters { get; set; }
    public float FullSnowRockSlopeStartDegrees { get; set; }
    public float FullSnowRockSlopeBlendDegrees { get; set; }
    public float RuggedSnowCapHillinessThreshold { get; set; }
    public float RuggedSnowCapHillinessBlend { get; set; }
    public float RuggedSnowCapBelowPeakMeters { get; set; }
    public float RuggedSnowCapMinStartMeters { get; set; }
    public float RuggedSnowCapBlendMeters { get; set; }
    public bool MirrorTerrainVariantTextures { get; set; }
    public bool HasWarnedMissingTerrainDecalRenderingLayer { get; set; }
    public float TerrainWidth { get; set; }
    public float TerrainLength { get; set; }
    public float TerrainHeight { get; set; }
    public double MaxTileHeightUnits { get; set; }
    public double MetersPerTileHeightUnit { get; set; }
    public List<GeneratedTerrainShadingMetadata> GeneratedTerrainShadingMetadata { get; set; } = new();
}

internal sealed class TileLoaderTerrainShadingService
{
    private static readonly ProfilerMarker SeamMeshUpdateMarker = new("TileLoader.TerrainSeams.MeshUpdate");
    private readonly TerrainShadingSettings settings;
    private readonly string defaultLowlandTerrainMaterialAssetPath;
    private readonly string defaultLowlandTerrainMaterialVariantAssetPath;
    private readonly string defaultMidHeightTerrainMaterialAssetPath;
    private readonly string defaultSteepSlopeTerrainMaterialAssetPath;
    private readonly string defaultSteepSlopeTerrainMaterialVariantAssetPath;
    private readonly string defaultPeakTerrainMaterialAssetPath;

    public TileLoaderTerrainShadingService(
        TerrainShadingSettings settings,
        string defaultLowlandTerrainMaterialAssetPath,
        string defaultLowlandTerrainMaterialVariantAssetPath,
        string defaultMidHeightTerrainMaterialAssetPath,
        string defaultSteepSlopeTerrainMaterialAssetPath,
        string defaultSteepSlopeTerrainMaterialVariantAssetPath,
        string defaultPeakTerrainMaterialAssetPath)
    {
        this.settings = settings;
        this.defaultLowlandTerrainMaterialAssetPath = defaultLowlandTerrainMaterialAssetPath;
        this.defaultLowlandTerrainMaterialVariantAssetPath = defaultLowlandTerrainMaterialVariantAssetPath;
        this.defaultMidHeightTerrainMaterialAssetPath = defaultMidHeightTerrainMaterialAssetPath;
        this.defaultSteepSlopeTerrainMaterialAssetPath = defaultSteepSlopeTerrainMaterialAssetPath;
        this.defaultSteepSlopeTerrainMaterialVariantAssetPath = defaultSteepSlopeTerrainMaterialVariantAssetPath;
        this.defaultPeakTerrainMaterialAssetPath = defaultPeakTerrainMaterialAssetPath;
    }

    public void EnsureShadingDefaults()
    {
        settings.LowlandTerrainMaterial ??= LoadDefaultMaterial(defaultLowlandTerrainMaterialAssetPath);
        settings.LowlandTerrainMaterialVariant ??= LoadDefaultMaterial(defaultLowlandTerrainMaterialVariantAssetPath);
        settings.MidHeightTerrainMaterial ??= LoadDefaultMaterial(defaultMidHeightTerrainMaterialAssetPath);
        settings.SteepSlopeTerrainMaterial ??= LoadDefaultMaterial(defaultSteepSlopeTerrainMaterialAssetPath);
        settings.SteepSlopeTerrainMaterialVariant ??= LoadDefaultMaterial(defaultSteepSlopeTerrainMaterialVariantAssetPath);
        settings.PeakTerrainMaterial ??= LoadDefaultMaterial(defaultPeakTerrainMaterialAssetPath);
        settings.LowlandTerrainTileSize = Mathf.Max(1f, settings.LowlandTerrainTileSize);
        settings.MidHeightTerrainTileSize = Mathf.Max(1f, settings.MidHeightTerrainTileSize);
        settings.SteepSlopeTerrainTileSize = Mathf.Max(1f, settings.SteepSlopeTerrainTileSize);
        settings.PeakTerrainTileSize = Mathf.Max(1f, settings.PeakTerrainTileSize);
        settings.MacroVariationScale = Mathf.Max(1f, settings.MacroVariationScale);
        settings.SurfaceVariantScale = Mathf.Max(1f, settings.SurfaceVariantScale);
        settings.SurfaceVariantTransition = Mathf.Clamp(settings.SurfaceVariantTransition, 0.01f, 0.49f);
        settings.SurfacePhaseOffsetStrength = Mathf.Clamp01(settings.SurfacePhaseOffsetStrength);
        settings.MacroTintScale = Mathf.Max(1f, settings.MacroTintScale);
        settings.MidHeightStartMeters = Mathf.Max(0f, settings.MidHeightStartMeters);
        settings.MidHeightBlendMeters = Mathf.Max(1f, settings.MidHeightBlendMeters);
        settings.SteepSlopeBlendDegrees = Mathf.Max(0.1f, settings.SteepSlopeBlendDegrees);
        settings.RuggedSnowCapHillinessThreshold = Mathf.Max(0f, settings.RuggedSnowCapHillinessThreshold);
        settings.RuggedSnowCapHillinessBlend = Mathf.Max(0.01f, settings.RuggedSnowCapHillinessBlend);
        settings.RuggedSnowCapBelowPeakMeters = Mathf.Max(0f, settings.RuggedSnowCapBelowPeakMeters);
        settings.RuggedSnowCapMinStartMeters = Mathf.Max(0f, settings.RuggedSnowCapMinStartMeters);
        settings.RuggedSnowCapBlendMeters = Mathf.Max(1f, settings.RuggedSnowCapBlendMeters);
        settings.FullSnowStartMeters = Mathf.Max(0f, settings.FullSnowStartMeters);
        settings.FullSnowBlendMeters = Mathf.Max(1f, settings.FullSnowBlendMeters);
        settings.FullSnowRockSlopeBlendDegrees = Mathf.Max(0.1f, settings.FullSnowRockSlopeBlendDegrees);
    }

    public GTexturingModel GetTexturingModel()
    {
        return settings.TerrainShadingMode == TerrainShadingMode.PolarisTextureBlend
            ? GTexturingModel.Splat
            : GTexturingModel.ColorMap;
    }

    public void ConfigureShading(
        GTerrainData terrainData,
        double[,] sourceHeightmap,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        double localMaxHeight,
        double tileHilliness,
        UnityEngine.Object owner)
    {
        Material material = CreateTerrainMaterial(GetTexturingModel(), owner);
        Polaris.SetTerrainMaterial(terrainData, material);
        ApplyTerrainShading(
            terrainData,
            sourceHeightmap,
            normalizationMinHeight,
            normalizationMaxHeight,
            localMaxHeight,
            tileHilliness);
    }

    public void ApplyTerrainShading(
        GTerrainData terrainData,
        double[,] sourceHeightmap,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        double localMaxHeight,
        double tileHilliness)
    {
        if (terrainData == null || terrainData.Shading == null)
        {
            return;
        }

        EnsureShadingDefaults();
        if (settings.TerrainShadingMode != TerrainShadingMode.PolarisTextureBlend)
        {
            return;
        }

        float[,] normalizedHeights = TileLoaderTerrainMathUtility.BuildNormalizedHeights(sourceHeightmap, settings.MaxTileHeightUnits);
        float[,] heightMeters = TileLoaderTerrainMathUtility.BuildHeightMeters(sourceHeightmap, settings.MetersPerTileHeightUnit);
        ApplyTextureBlendSettings(
            terrainData.Shading,
            terrainData,
            normalizedHeights,
            heightMeters,
            TileLoaderTerrainMathUtility.TileHeightUnitsToMeters(localMaxHeight, settings.MetersPerTileHeightUnit),
            (float)tileHilliness,
            null);
    }

    public void ApplyTerrainShading(IReadOnlyList<GStylizedTerrain> terrains, UnityEngine.Object owner)
    {
        for (int i = 0; i < terrains.Count; i++)
        {
            GStylizedTerrain terrain = terrains[i];
            if (terrain == null || terrain.TerrainData == null)
            {
                continue;
            }

            ApplyTerrainShading(terrain, owner);
            terrain.TerrainData.Shading.UpdateMaterials();
            ApplyWorldAlignedSplatMaterialOffsets(terrain);
            ApplyTerrainDecalRenderingLayer(terrain, owner);
        }
    }

    public void ApplyTerrainShading(GStylizedTerrain terrain, UnityEngine.Object owner)
    {
        if (terrain == null || terrain.TerrainData == null || terrain.TerrainData.Shading == null || settings.TerrainShadingMode != TerrainShadingMode.PolarisTextureBlend)
        {
            return;
        }

        EnsureShadingDefaults();
        Texture2D? heightTexture = terrain.TerrainData.Geometry?.HeightMap;
        if (heightTexture == null)
        {
            return;
        }

        float[,] normalizedHeights = DecodeNormalizedHeights(heightTexture);
        GeneratedTerrainShadingMetadata? shadingMetadata = GetTerrainShadingMetadata(terrain.name);
        float[,] heightMeters = TileLoaderTerrainMathUtility.BuildHeightMetersFromNormalizedHeights(
            normalizedHeights,
            0.0,
            settings.MaxTileHeightUnits);
        float localMaxHeightMeters = shadingMetadata.HasValue && shadingMetadata.Value.LocalMaxHeightMeters > 0f
            ? shadingMetadata.Value.LocalMaxHeightMeters
            : TileLoaderTerrainMathUtility.EstimateMaxHeightMeters(heightMeters);
        float tileHilliness = shadingMetadata.HasValue && shadingMetadata.Value.TileHilliness > 0.0
            ? (float)shadingMetadata.Value.TileHilliness
            : TileLoaderTerrainMathUtility.EstimateTileHilliness(heightMeters);
        if (!shadingMetadata.HasValue)
        {
            SetTerrainShadingMetadata(
                terrain.name,
                0.0,
                settings.MaxTileHeightUnits,
                localMaxHeightMeters,
                tileHilliness);
        }
        else if (shadingMetadata.Value.LocalMaxHeightMeters <= 0f || shadingMetadata.Value.TileHilliness <= 0.0)
        {
            SetTerrainShadingMetadata(
                terrain.name,
                shadingMetadata.Value.NormalizationMinHeight,
                shadingMetadata.Value.NormalizationMaxHeight,
                localMaxHeightMeters,
                tileHilliness);
        }

        ApplyTextureBlendSettings(
            terrain.TerrainData.Shading,
            terrain.TerrainData,
            normalizedHeights,
            heightMeters,
            localMaxHeightMeters,
            tileHilliness,
            terrain);
    }

    public void SetTerrainShadingMetadata(
        string terrainName,
        double normalizationMinHeight,
        double normalizationMaxHeight,
        float localMaxHeightMeters,
        double tileHilliness)
    {
        for (int i = 0; i < settings.GeneratedTerrainShadingMetadata.Count; i++)
        {
            if (string.Equals(settings.GeneratedTerrainShadingMetadata[i].TerrainName, terrainName, StringComparison.Ordinal))
            {
                settings.GeneratedTerrainShadingMetadata[i] = new GeneratedTerrainShadingMetadata(
                    terrainName,
                    normalizationMinHeight,
                    normalizationMaxHeight,
                    localMaxHeightMeters,
                    tileHilliness);
                return;
            }
        }

        settings.GeneratedTerrainShadingMetadata.Add(new GeneratedTerrainShadingMetadata(
            terrainName,
            normalizationMinHeight,
            normalizationMaxHeight,
            localMaxHeightMeters,
            tileHilliness));
    }

    public void ApplyWorldAlignedSplatMaterialOffsets(GStylizedTerrain terrain)
    {
        if (settings.TerrainShadingMode != TerrainShadingMode.PolarisTextureBlend || terrain?.TerrainData?.Shading?.CustomMaterial == null)
        {
            return;
        }

        Material material = terrain.TerrainData.Shading.CustomMaterial;
        Vector3 origin = terrain.transform.localPosition;
        ApplyWorldAlignedSplatOffset(material, "_Splat0", settings.LowlandTerrainTileSize, origin, 0);
        ApplyWorldAlignedSplatOffset(material, "_Splat1", settings.LowlandTerrainTileSize, origin, 1);
        ApplyWorldAlignedSplatOffset(material, "_Splat2", settings.MidHeightTerrainTileSize, origin, 2);
        ApplyWorldAlignedSplatOffset(material, "_Splat3", settings.SteepSlopeTerrainTileSize, origin, 3);
        ApplyWorldAlignedSplatOffset(material, "_Splat4", settings.SteepSlopeTerrainTileSize, origin, 4);
        ApplyWorldAlignedSplatOffset(material, "_Splat5", settings.PeakTerrainTileSize, origin, 5);
    }

    public void ApplyTerrainDecalRenderingLayer(GStylizedTerrain terrain, UnityEngine.Object owner)
    {
        if (terrain == null)
        {
            return;
        }

        uint terrainDecalRenderingLayerMask = GetTerrainDecalRenderingLayerMask(owner);
        if (terrainDecalRenderingLayerMask == 0u)
        {
            return;
        }

        GTerrainChunk[] chunks = terrain.GetChunks();
        for (int i = 0; i < chunks.Length; i++)
        {
            MeshRenderer? renderer = chunks[i]?.MeshRendererComponent;
            if (renderer == null)
            {
                continue;
            }

            renderer.renderingLayerMask |= terrainDecalRenderingLayerMask;
        }
    }

    public void RebuildTerrainSeams(List<GStylizedTerrain> terrains, UnityEngine.Object owner)
    {
        GStylizedTerrain.ConnectAdjacentTiles();

        Rect fullRegion = new Rect(0f, 0f, 1f, 1f);
        for (int i = 0; i < terrains.Count; i++)
        {
            GStylizedTerrain terrain = terrains[i];
            terrain.TerrainData.Geometry.SetRegionDirty(fullRegion);
            Polaris.UpdateTerrainMesh(terrain, new[] { fullRegion });
            terrain.TerrainData.Shading.UpdateMaterials();
            ApplyTerrainDecalRenderingLayer(terrain, owner);
        }
    }

    public void ConnectAdjacentTerrainTiles()
    {
        GStylizedTerrain.ConnectAdjacentTiles();
    }

    public void RebuildTerrainSeams(GStylizedTerrain terrain, TileLoaderTerrainSeamMask seamMask, UnityEngine.Object owner)
    {
        if (terrain == null || terrain.TerrainData?.Geometry == null)
        {
            return;
        }

        Rect[] dirtyRegions = BuildSeamDirtyRegions(terrain, seamMask);
        if (dirtyRegions.Length == 0)
        {
            return;
        }

        using (SeamMeshUpdateMarker.Auto())
        {
            for (int i = 0; i < dirtyRegions.Length; i++)
            {
                terrain.TerrainData.Geometry.SetRegionDirty(dirtyRegions[i]);
            }

            Polaris.UpdateTerrainMesh(terrain, dirtyRegions);
        }

        terrain.TerrainData.Shading.UpdateMaterials();
        ApplyTerrainDecalRenderingLayer(terrain, owner);
    }

    public static Color[] BuildHeightPixels(double[,] heightmap, double maxTileHeightUnits)
    {
        int resolutionY = heightmap.GetLength(0);
        int resolutionX = heightmap.GetLength(1);
        var pixels = new Color[resolutionX * resolutionY];

        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                float normalizedHeight = TileLoaderTerrainMathUtility.NormalizeHeightUnitsToTerrain(heightmap[y, x], maxTileHeightUnits);
                int flippedY = resolutionY - 1 - y;
                pixels[flippedY * resolutionX + x] = Polaris.EncodeHeightMapSample(normalizedHeight, 0f, 0f);
            }
        }

        return pixels;
    }

    private static Rect[] BuildSeamDirtyRegions(GStylizedTerrain terrain, TileLoaderTerrainSeamMask seamMask)
    {
        if (seamMask == TileLoaderTerrainSeamMask.None)
        {
            return Array.Empty<Rect>();
        }

        // Polaris stitches seams across the terrain's internal chunk grid during mesh regeneration.
        // Rebuilding only the outer edge strips can leave adjacent interior chunk boundaries stale,
        // which shows up as visible cracks between the smaller chunk meshes. Regenerate the full
        // terrain mesh here for correctness.
        return new[] { new Rect(0f, 0f, 1f, 1f) };
    }

    private Material CreateTerrainMaterial(GTexturingModel texturingModel, UnityEngine.Object owner)
    {
        if (settings.TerrainShadingMode == TerrainShadingMode.FallbackLit)
        {
            return CreateFallbackTerrainMaterial();
        }

        Shader baseShader =
            Shader.Find("Universal Render Pipeline/Lit") ??
            Shader.Find("Standard");

        if (baseShader == null)
        {
            throw new InvalidOperationException("TileLoader could not find a base shader to initialize a Polaris terrain material.");
        }

        var material = new Material(baseShader)
        {
            name = $"TileLoaderTerrainMaterial_{texturingModel}",
        };

        GSplatsModel splatsModel = settings.TerrainShadingMode == TerrainShadingMode.PolarisTextureBlend
            ? GSplatsModel.Splats8
            : GSplatsModel.Splats4;

        if (Polaris.InitTerrainMaterial(material, GLightingModel.PBR, texturingModel, splatsModel))
        {
            return material;
        }

        if (Application.isPlaying)
        {
            UnityEngine.Object.Destroy(material);
        }
        else
        {
            UnityEngine.Object.DestroyImmediate(material);
        }

        Debug.LogWarning($"TileLoader could not initialize a Polaris material for {texturingModel}; falling back to URP Lit.", owner);
        return CreateFallbackTerrainMaterial();
    }

    private void ApplyTextureBlendSettings(
        GShading shading,
        GTerrainData terrainData,
        float[,] normalizedHeights,
        float[,] heightMeters,
        float localMaxHeightMeters,
        float tileHilliness,
        GStylizedTerrain? terrain)
    {
        GSplatPrototypeGroup splatGroup = shading.Splats;
        if (splatGroup == null)
        {
            splatGroup = ScriptableObject.CreateInstance<GSplatPrototypeGroup>();
            splatGroup.name = "TileLoader Splat Prototype Group";
            GCommon.TryAddObjectToAsset(splatGroup, terrainData);
        }

        shading.Splats = splatGroup;
        splatGroup.Prototypes = new List<GSplatPrototype>
        {
            CreateSplatPrototype(settings.LowlandTerrainMaterial, settings.LowlandTerrainTileSize),
            CreateSplatPrototype(settings.LowlandTerrainMaterialVariant ?? settings.LowlandTerrainMaterial, settings.LowlandTerrainTileSize),
            CreateSplatPrototype(settings.MidHeightTerrainMaterial, settings.MidHeightTerrainTileSize),
            CreateSplatPrototype(settings.SteepSlopeTerrainMaterial, settings.SteepSlopeTerrainTileSize),
            CreateSplatPrototype(settings.SteepSlopeTerrainMaterialVariant ?? settings.SteepSlopeTerrainMaterial, settings.SteepSlopeTerrainTileSize),
            CreateSplatPrototype(settings.PeakTerrainMaterial, settings.PeakTerrainTileSize),
        };

        shading.SplatControlResolution = Mathf.Max(32, Mathf.Max(normalizedHeights.GetLength(0), normalizedHeights.GetLength(1)));
        shading.SetAlphamaps(BuildTextureBlendAlphamaps(normalizedHeights, heightMeters, localMaxHeightMeters, tileHilliness, terrain));
    }

    private float[,,] BuildTextureBlendAlphamaps(
        float[,] normalizedHeights,
        float[,] heightMeters,
        float localMaxHeightMeters,
        float tileHilliness,
        GStylizedTerrain? terrain)
    {
        int resolutionY = normalizedHeights.GetLength(0);
        int resolutionX = normalizedHeights.GetLength(1);
        const int layerCount = 6;
        var alphamaps = new float[resolutionY, resolutionX, layerCount];
        float sampleSpacingX = resolutionX > 1 ? settings.TerrainWidth / (resolutionX - 1f) : settings.TerrainWidth;
        float sampleSpacingZ = resolutionY > 1 ? settings.TerrainLength / (resolutionY - 1f) : settings.TerrainLength;
        Vector2 terrainOrigin = terrain != null
            ? new Vector2(terrain.transform.localPosition.x, terrain.transform.localPosition.z)
            : Vector2.zero;
        float ruggedSnowCapWeight = SmoothRange(tileHilliness, settings.RuggedSnowCapHillinessThreshold, settings.RuggedSnowCapHillinessBlend);
        float ruggedSnowCapStart = Mathf.Max(
            settings.RuggedSnowCapMinStartMeters,
            localMaxHeightMeters - settings.RuggedSnowCapBelowPeakMeters);
        float effectiveCapSnowBlend = Mathf.Lerp(settings.FullSnowBlendMeters, settings.RuggedSnowCapBlendMeters, ruggedSnowCapWeight);

        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                float worldX = terrainOrigin.x + x * sampleSpacingX;
                float worldZ = terrainOrigin.y + (resolutionY - 1 - y) * sampleSpacingZ;
                float absoluteHeightMeters = heightMeters[y, x];
                float macroBias = SampleSignedNoise(worldX, worldZ, settings.MacroVariationScale) * settings.MacroVariationStrength;
                float adjustedMidStart = Mathf.Max(0f, settings.MidHeightStartMeters + macroBias * 180f);
                float adjustedFullSnowStart = Mathf.Max(0f, settings.FullSnowStartMeters + macroBias * 220f);
                float adjustedSlopeStart = Mathf.Clamp(settings.SteepSlopeStartDegrees + macroBias * 18f, 0f, 90f);
                float adjustedFullSnowRockSlope = Mathf.Clamp(settings.FullSnowRockSlopeStartDegrees + macroBias * 6f, 0f, 90f);
                float slopeDegrees = terrain != null
                    ? SampleSlopeDegrees(terrain, normalizedHeights, x, y, sampleSpacingX, sampleSpacingZ)
                    : SampleSlopeDegrees(normalizedHeights, x, y, sampleSpacingX, sampleSpacingZ);
                float effectiveCapSnowStart = Mathf.Lerp(adjustedFullSnowStart, ruggedSnowCapStart, ruggedSnowCapWeight);
                float capSnowWeight = ruggedSnowCapWeight * SmoothRange(absoluteHeightMeters, effectiveCapSnowStart, effectiveCapSnowBlend);
                float highAltitudeSnowWeight = SmoothRange(absoluteHeightMeters, adjustedFullSnowStart, settings.FullSnowBlendMeters);
                float steepRockInSnowWeight = SmoothRange(slopeDegrees, adjustedFullSnowRockSlope, settings.FullSnowRockSlopeBlendDegrees);
                float snowWeight = Mathf.Max(capSnowWeight, highAltitudeSnowWeight);
                float peakWeight = snowWeight * (1f - steepRockInSnowWeight);
                float baseCliffWeight = SmoothRange(slopeDegrees, adjustedSlopeStart, settings.SteepSlopeBlendDegrees);
                float cliffWeight = Mathf.Max(baseCliffWeight * (1f - peakWeight * 0.25f), snowWeight * steepRockInSnowWeight);
                float midWeight = SmoothRange(absoluteHeightMeters, adjustedMidStart, settings.MidHeightBlendMeters) * (1f - peakWeight);
                float lowWeight = 1f - Mathf.Clamp01(midWeight + peakWeight);

                lowWeight *= 1f - cliffWeight;
                midWeight *= 1f - cliffWeight * 0.75f;

                float macroTintBias = SampleSignedNoise(worldX + 173.2f, worldZ - 91.7f, settings.MacroTintScale) * settings.MacroTintStrength;
                float lowlandVariantMix = SharpenVariantMix(
                    0.5f +
                    SampleSignedNoise(worldX - 47.3f, worldZ + 128.4f, settings.SurfaceVariantScale) * 0.5f * settings.SurfaceVariantStrength +
                    macroTintBias,
                    settings.SurfaceVariantTransition);
                float rockVariantMix = SharpenVariantMix(
                    0.5f +
                    SampleSignedNoise(worldX + 281.6f, worldZ + 54.1f, settings.SurfaceVariantScale * 0.85f) * 0.5f * settings.SurfaceVariantStrength +
                    macroTintBias * 0.75f,
                    settings.SurfaceVariantTransition);
                float lowWeightPrimary = lowWeight * (1f - lowlandVariantMix);
                float lowWeightVariant = lowWeight * lowlandVariantMix;
                float cliffWeightPrimary = cliffWeight * (1f - rockVariantMix);
                float cliffWeightVariant = cliffWeight * rockVariantMix;

                float total = lowWeightPrimary + lowWeightVariant + midWeight + cliffWeightPrimary + cliffWeightVariant + peakWeight;
                if (total <= 1e-5f)
                {
                    lowWeightPrimary = 1f;
                    lowWeightVariant = 0f;
                    midWeight = 0f;
                    cliffWeightPrimary = 0f;
                    cliffWeightVariant = 0f;
                    peakWeight = 0f;
                    total = 1f;
                }

                int flippedY = resolutionY - 1 - y;
                alphamaps[flippedY, x, 0] = lowWeightPrimary / total;
                alphamaps[flippedY, x, 1] = lowWeightVariant / total;
                alphamaps[flippedY, x, 2] = midWeight / total;
                alphamaps[flippedY, x, 3] = cliffWeightPrimary / total;
                alphamaps[flippedY, x, 4] = cliffWeightVariant / total;
                alphamaps[flippedY, x, 5] = peakWeight / total;
            }
        }

        return alphamaps;
    }

    private GSplatPrototype CreateSplatPrototype(Material? sourceMaterial, float tileSize)
    {
        return new GSplatPrototype
        {
            Texture = ExtractDiffuseTexture(sourceMaterial),
            NormalMap = ExtractNormalTexture(sourceMaterial),
            TileSize = new Vector2(Mathf.Max(1f, tileSize), Mathf.Max(1f, tileSize)),
            TileOffset = Vector2.zero,
            Metallic = ExtractFloat(sourceMaterial, "_Metallic", 0f),
            Smoothness = Mathf.Max(
                ExtractFloat(sourceMaterial, "_Smoothness", 0f),
                ExtractFloat(sourceMaterial, "_Glossiness", 0f)),
        };
    }

    private static Texture2D? ExtractDiffuseTexture(Material? sourceMaterial)
    {
        if (sourceMaterial == null)
        {
            return null;
        }

        return sourceMaterial.GetTexture("_BaseMap") as Texture2D ??
               sourceMaterial.GetTexture("_MainTex") as Texture2D;
    }

    private static Texture2D? ExtractNormalTexture(Material? sourceMaterial)
    {
        if (sourceMaterial == null)
        {
            return null;
        }

        return sourceMaterial.GetTexture("_BumpMap") as Texture2D ??
               sourceMaterial.GetTexture("_NormalMap") as Texture2D;
    }

    private static float ExtractFloat(Material? sourceMaterial, string propertyName, float fallback)
    {
        return sourceMaterial != null && sourceMaterial.HasProperty(propertyName)
            ? sourceMaterial.GetFloat(propertyName)
            : fallback;
    }

    private GeneratedTerrainShadingMetadata? GetTerrainShadingMetadata(string terrainName)
    {
        for (int i = 0; i < settings.GeneratedTerrainShadingMetadata.Count; i++)
        {
            if (string.Equals(settings.GeneratedTerrainShadingMetadata[i].TerrainName, terrainName, StringComparison.Ordinal))
            {
                return settings.GeneratedTerrainShadingMetadata[i];
            }
        }

        return null;
    }

    private float SampleSlopeDegrees(GStylizedTerrain terrain, float[,] normalizedHeights, int x, int y, float sampleSpacingX, float sampleSpacingZ)
    {
        int resolutionY = normalizedHeights.GetLength(0);
        int resolutionX = normalizedHeights.GetLength(1);
        float leftHeight = SampleNormalizedHeightWithNeighbors(terrain, normalizedHeights, x - 1, y, resolutionX, resolutionY) * settings.TerrainHeight;
        float rightHeight = SampleNormalizedHeightWithNeighbors(terrain, normalizedHeights, x + 1, y, resolutionX, resolutionY) * settings.TerrainHeight;
        float downHeight = SampleNormalizedHeightWithNeighbors(terrain, normalizedHeights, x, y - 1, resolutionX, resolutionY) * settings.TerrainHeight;
        float upHeight = SampleNormalizedHeightWithNeighbors(terrain, normalizedHeights, x, y + 1, resolutionX, resolutionY) * settings.TerrainHeight;

        float dHdX = (rightHeight - leftHeight) / (2f * Mathf.Max(sampleSpacingX, 1e-4f));
        float dHdZ = (upHeight - downHeight) / (2f * Mathf.Max(sampleSpacingZ, 1e-4f));
        return Mathf.Atan(Mathf.Sqrt(dHdX * dHdX + dHdZ * dHdZ)) * Mathf.Rad2Deg;
    }

    private static float[,] DecodeNormalizedHeights(Texture2D heightTexture)
    {
        int resolutionY = heightTexture.height;
        int resolutionX = heightTexture.width;
        var normalizedHeights = new float[resolutionY, resolutionX];
        Color[] pixels = heightTexture.GetPixels();

        for (int y = 0; y < resolutionY; y++)
        {
            for (int x = 0; x < resolutionX; x++)
            {
                int flippedY = resolutionY - 1 - y;
                Color sample = pixels[flippedY * resolutionX + x];
                float height01 = 0f;
                float subdiv01 = 0f;
                float visibility01 = 0f;
                Polaris.DecodeHeightMapSample(sample, ref height01, ref subdiv01, ref visibility01);
                normalizedHeights[y, x] = height01;
            }
        }

        return normalizedHeights;
    }

    private float SampleSlopeDegrees(float[,] normalizedHeights, int x, int y, float sampleSpacingX, float sampleSpacingZ)
    {
        int resolutionY = normalizedHeights.GetLength(0);
        int resolutionX = normalizedHeights.GetLength(1);
        int left = Mathf.Max(x - 1, 0);
        int right = Mathf.Min(x + 1, resolutionX - 1);
        int down = Mathf.Max(y - 1, 0);
        int up = Mathf.Min(y + 1, resolutionY - 1);

        float leftHeight = normalizedHeights[y, left] * settings.TerrainHeight;
        float rightHeight = normalizedHeights[y, right] * settings.TerrainHeight;
        float downHeight = normalizedHeights[down, x] * settings.TerrainHeight;
        float upHeight = normalizedHeights[up, x] * settings.TerrainHeight;

        float dHdX = right == left ? 0f : (rightHeight - leftHeight) / ((right - left) * Mathf.Max(sampleSpacingX, 1e-4f));
        float dHdZ = up == down ? 0f : (upHeight - downHeight) / ((up - down) * Mathf.Max(sampleSpacingZ, 1e-4f));
        return Mathf.Atan(Mathf.Sqrt(dHdX * dHdX + dHdZ * dHdZ)) * Mathf.Rad2Deg;
    }

    private static float SampleNormalizedHeightWithNeighbors(
        GStylizedTerrain terrain,
        float[,] normalizedHeights,
        int sampleX,
        int sampleY,
        int resolutionX,
        int resolutionY)
    {
        if (sampleX >= 0 && sampleX < resolutionX && sampleY >= 0 && sampleY < resolutionY)
        {
            return normalizedHeights[sampleY, sampleX];
        }

        if (sampleX < 0 && sampleY >= 0 && sampleY < resolutionY)
        {
            return SampleTerrainTextureHeight(terrain.LeftNeighbor, resolutionX - 1, sampleY, normalizedHeights[sampleY, 0]);
        }

        if (sampleX >= resolutionX && sampleY >= 0 && sampleY < resolutionY)
        {
            return SampleTerrainTextureHeight(terrain.RightNeighbor, 0, sampleY, normalizedHeights[sampleY, resolutionX - 1]);
        }

        if (sampleY < 0 && sampleX >= 0 && sampleX < resolutionX)
        {
            return SampleTerrainTextureHeight(terrain.TopNeighbor, sampleX, resolutionY - 1, normalizedHeights[0, sampleX]);
        }

        if (sampleY >= resolutionY && sampleX >= 0 && sampleX < resolutionX)
        {
            return SampleTerrainTextureHeight(terrain.BottomNeighbor, sampleX, 0, normalizedHeights[resolutionY - 1, sampleX]);
        }

        int clampedX = Mathf.Clamp(sampleX, 0, resolutionX - 1);
        int clampedY = Mathf.Clamp(sampleY, 0, resolutionY - 1);
        return normalizedHeights[clampedY, clampedX];
    }

    private static float SampleTerrainTextureHeight(GStylizedTerrain? terrain, int x, int y, float fallback)
    {
        Texture2D? heightTexture = terrain?.TerrainData?.Geometry?.HeightMap;
        if (heightTexture == null)
        {
            return fallback;
        }

        int clampedX = Mathf.Clamp(x, 0, heightTexture.width - 1);
        int clampedY = Mathf.Clamp(y, 0, heightTexture.height - 1);
        int flippedY = heightTexture.height - 1 - clampedY;
        Color sample = heightTexture.GetPixel(clampedX, flippedY);
        float height01 = 0f;
        float subdiv01 = 0f;
        float visibility01 = 0f;
        Polaris.DecodeHeightMapSample(sample, ref height01, ref subdiv01, ref visibility01);
        return height01;
    }

    private void ApplyWorldAlignedSplatOffset(Material material, string propertyName, float tileSize, Vector3 terrainOrigin, int variationSeed)
    {
        if (material == null || !material.HasProperty(propertyName))
        {
            return;
        }

        float safeTileSize = Mathf.Max(1f, tileSize);
        Vector2 sign = ComputeSplatScaleSign(variationSeed);
        Vector2 phaseOffset = ComputeSplatPhaseOffset(variationSeed);
        material.SetTextureScale(propertyName, new Vector2((settings.TerrainWidth / safeTileSize) * sign.x, (settings.TerrainLength / safeTileSize) * sign.y));
        material.SetTextureOffset(
            propertyName,
            new Vector2((terrainOrigin.x / safeTileSize) * sign.x, (terrainOrigin.z / safeTileSize) * sign.y) + phaseOffset);
    }

    private uint GetTerrainDecalRenderingLayerMask(UnityEngine.Object owner)
    {
        string layerName = string.IsNullOrWhiteSpace(settings.TerrainDecalRenderingLayerName)
            ? string.Empty
            : settings.TerrainDecalRenderingLayerName.Trim();
        if (string.IsNullOrEmpty(layerName))
        {
            return 0u;
        }

        uint mask = RenderingLayerMask.GetMask(layerName);
        if (mask == 0u && !settings.HasWarnedMissingTerrainDecalRenderingLayer)
        {
            settings.HasWarnedMissingTerrainDecalRenderingLayer = true;
            Debug.LogWarning(
                $"TileLoader could not find rendering layer '{layerName}'. Generated terrain chunks will not receive the ground decal rendering layer until it exists in URP Global Settings.",
                owner);
        }

        return mask;
    }

    private static float SmoothRange(float value, float start, float blend)
    {
        return Mathf.SmoothStep(0f, 1f, Mathf.Clamp01((value - start) / Mathf.Max(1e-4f, blend)));
    }

    private static float SampleSignedNoise(float worldX, float worldZ, float scale)
    {
        float safeScale = Mathf.Max(1f, scale);
        float noise =
            Mathf.PerlinNoise(worldX / safeScale + 11.37f, worldZ / safeScale + 29.51f) * 0.55f +
            Mathf.PerlinNoise(worldX / (safeScale * 0.47f) - 73.19f, worldZ / (safeScale * 0.47f) + 41.63f) * 0.3f +
            Mathf.PerlinNoise(worldX / (safeScale * 1.91f) + 101.8f, worldZ / (safeScale * 1.91f) - 17.24f) * 0.15f;
        return Mathf.Clamp01(noise) * 2f - 1f;
    }

    private static float SharpenVariantMix(float rawMix, float transition)
    {
        float clampedMix = Mathf.Clamp01(rawMix);
        float halfTransition = Mathf.Clamp(transition, 0.01f, 0.49f);
        float lowerBound = 0.5f - halfTransition;
        float upperBound = 0.5f + halfTransition;
        return Mathf.SmoothStep(0f, 1f, Mathf.InverseLerp(lowerBound, upperBound, clampedMix));
    }

    private Vector2 ComputeSplatScaleSign(int variationSeed)
    {
        if (!settings.MirrorTerrainVariantTextures)
        {
            return Vector2.one;
        }

        return new Vector2((variationSeed & 1) == 0 ? 1f : -1f, (variationSeed & 2) == 0 ? 1f : -1f);
    }

    private Vector2 ComputeSplatPhaseOffset(int variationSeed)
    {
        float strength = Mathf.Clamp01(settings.SurfacePhaseOffsetStrength);
        if (strength <= 0f)
        {
            return Vector2.zero;
        }

        float offsetX = (Hash01(variationSeed * 92821 + 17) * 2f - 1f) * strength;
        float offsetY = (Hash01(variationSeed * 68917 + 53) * 2f - 1f) * strength;
        return new Vector2(offsetX, offsetY);
    }

    private static float Hash01(int seed)
    {
        unchecked
        {
            uint value = (uint)seed;
            value ^= value >> 16;
            value *= 0x7FEB352Du;
            value ^= value >> 15;
            value *= 0x846CA68Bu;
            value ^= value >> 16;
            return (value & 0x00FFFFFFu) / 16777215f;
        }
    }

    private static Material? LoadDefaultMaterial(string assetPath)
    {
#if UNITY_EDITOR
        return AssetDatabase.LoadAssetAtPath<Material>(assetPath);
#else
        return null;
#endif
    }

    private static Material CreateFallbackTerrainMaterial()
    {
        Shader shader =
            Shader.Find("Universal Render Pipeline/Lit") ??
            Shader.Find("Standard");

        if (shader == null)
        {
            throw new InvalidOperationException("TileLoader could not find a fallback terrain shader.");
        }

        var material = new Material(shader)
        {
            name = "TileLoaderTerrainMaterial",
        };

        if (material.HasProperty("_BaseColor"))
        {
            material.SetColor("_BaseColor", new Color(0.42f, 0.66f, 0.38f, 1f));
        }

        if (material.HasProperty("_Color"))
        {
            material.SetColor("_Color", new Color(0.42f, 0.66f, 0.38f, 1f));
        }

        return material;
    }
}

}
