using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine;
using Thiod.TileLoading.Runtime;

#nullable enable

namespace Thiod.TileLoading.Tests
{

public sealed class TileLoaderUtilityTests
{
    [Test]
    public void BuildNormalizedHeights_UsesConfiguredMaxUnits()
    {
        double[,] source =
        {
            { 0d, 21d },
            { 42d, 10.5d }
        };

        Type utilityType = GetRuntimeType("Thiod.TileLoading.Runtime.TileLoaderTerrainMathUtility");
        MethodInfo buildNormalizedHeights = utilityType.GetMethod(
            "BuildNormalizedHeights",
            BindingFlags.Public | BindingFlags.Static)!;
        var normalized = (float[,])buildNormalizedHeights.Invoke(null, new object[] { source, 42d })!;

        Assert.That(normalized[0, 0], Is.EqualTo(0f).Within(0.0001f));
        Assert.That(normalized[0, 1], Is.EqualTo(0.5f).Within(0.0001f));
        Assert.That(normalized[1, 0], Is.EqualTo(1f).Within(0.0001f));
        Assert.That(normalized[1, 1], Is.EqualTo(0.25f).Within(0.0001f));
    }

    [Test]
    public void ResolveGenerationSettings_PrefersMetadataOverrides()
    {
        Type contextType = GetRuntimeType("Thiod.TileLoading.Runtime.TerrainBuildContext");
        object context = Activator.CreateInstance(
            contextType,
            BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic,
            binder: null,
            args: new object[]
            {
                "world.msgpack",
                true,
                128,
                64,
                1.25d,
                new Vector3Int(1, 2, 0),
                true,
                false,
                false,
                false,
                128f,
                128f,
                30f,
                16,
                "Terrain",
                1.5f,
                0.2f,
                1f,
                4f,
                10f,
                4f,
                10f,
                0.001f,
                6f,
                2f,
                1.25f,
                1.25f,
                16,
                0.35f,
                8,
                3,
                1f,
                8,
                6,
                0.2f,
                1.5f,
                3f,
                1,
                true,
                true
            },
            culture: null)!;

        var metadata = new Dictionary<string, object>
        {
            ["config"] = new Dictionary<string, object>
            {
                ["tile_size"] = 256,
                ["hill_spacing"] = 96,
                ["hill_strength"] = 3.5d,
            }
        };

        Type utilityType = GetRuntimeType("Thiod.TileLoading.Runtime.TileLoaderWorldDataUtility");
        MethodInfo resolveGenerationSettings = utilityType.GetMethod(
            "ResolveGenerationSettings",
            BindingFlags.Public | BindingFlags.Static)!;
        object settings = resolveGenerationSettings.Invoke(null, new object[] { context, metadata })!;

        Assert.That((int)settings.GetType().GetProperty("TileSize")!.GetValue(settings)!, Is.EqualTo(256));
        Assert.That((int)settings.GetType().GetProperty("HillSpacing")!.GetValue(settings)!, Is.EqualTo(96));
        Assert.That(
            Convert.ToDouble(settings.GetType().GetProperty("HillStrength")!.GetValue(settings)!),
            Is.EqualTo(3.5d).Within(0.0001d));
    }

    [Test]
    public void TreeOptimizationController_ResetClearsRegisteredTrees()
    {
        var loaderObject = new GameObject("TileLoaderTest");
        var treeObject = new GameObject("TreeRoot");

        try
        {
            TileLoader loader = loaderObject.AddComponent<TileLoader>();
            treeObject.AddComponent<LODGroup>();

            PropertyInfo controllerProperty = typeof(TileLoader).GetProperty(
                "TreeOptimizationController",
                BindingFlags.Instance | BindingFlags.NonPublic)!;
            object controller = controllerProperty.GetValue(loader)!;

            MethodInfo registerGeneratedTree = controller.GetType().GetMethod(
                "RegisterGeneratedTree",
                BindingFlags.Instance | BindingFlags.Public)!;
            MethodInfo resetState = controller.GetType().GetMethod(
                "ResetState",
                BindingFlags.Instance | BindingFlags.Public)!;
            FieldInfo generatedTreeInstances = controller.GetType().GetField(
                "generatedTreeInstances",
                BindingFlags.Instance | BindingFlags.NonPublic)!;

            registerGeneratedTree.Invoke(controller, new object?[] { treeObject });
            Assert.That(((System.Collections.ICollection)generatedTreeInstances.GetValue(controller)!).Count, Is.EqualTo(1));

            resetState.Invoke(controller, Array.Empty<object>());
            Assert.That(((System.Collections.ICollection)generatedTreeInstances.GetValue(controller)!).Count, Is.EqualTo(0));
        }
        finally
        {
            UnityEngine.Object.DestroyImmediate(treeObject);
            UnityEngine.Object.DestroyImmediate(loaderObject);
        }
    }

    [Test]
    public void TileGateMath_ClampsForwardMovementToBlockedTileBoundary()
    {
        Type utilityType = GetRuntimeType("Thiod.TileLoading.Runtime.TileLoaderTileGateMath");
        MethodInfo tryResolveClampedLocalPosition = utilityType.GetMethod(
            "TryResolveClampedLocalPosition",
            BindingFlags.Public | BindingFlags.Static)!;

        object[] args =
        {
            new Vector3(150f, 0f, 32f),
            new Vector2Int(0, 0),
            new Vector2Int(1, 0),
            128f,
            128f,
            0.1f,
            null!
        };

        bool didClamp = (bool)tryResolveClampedLocalPosition.Invoke(null, args)!;
        Vector3 clampedPosition = (Vector3)args[6];

        Assert.That(didClamp, Is.True);
        Assert.That(clampedPosition.x, Is.EqualTo(127.9f).Within(0.0001f));
        Assert.That(clampedPosition.z, Is.EqualTo(32f).Within(0.0001f));
    }

    [Test]
    public void TileGateMath_RejectsNonAdjacentBlockedTiles()
    {
        Type utilityType = GetRuntimeType("Thiod.TileLoading.Runtime.TileLoaderTileGateMath");
        MethodInfo tryResolveClampedLocalPosition = utilityType.GetMethod(
            "TryResolveClampedLocalPosition",
            BindingFlags.Public | BindingFlags.Static)!;

        object[] args =
        {
            new Vector3(150f, 0f, 32f),
            new Vector2Int(0, 0),
            new Vector2Int(2, 0),
            128f,
            128f,
            0.1f,
            null!
        };

        bool didClamp = (bool)tryResolveClampedLocalPosition.Invoke(null, args)!;
        Vector3 clampedPosition = (Vector3)args[6];

        Assert.That(didClamp, Is.False);
        Assert.That(clampedPosition, Is.EqualTo(new Vector3(150f, 0f, 32f)));
    }

    [Test]
    public void RiverUtility_ResolvesEastEndpointDirectionBeyondHeightmap()
    {
        Type utilityType = GetRuntimeType("Thiod.TileLoading.Runtime.TileLoaderRiverUtility");
        MethodInfo tryGetRiverWaterEndpointDirection = utilityType.GetMethod(
            "TryGetRiverWaterEndpointDirection",
            BindingFlags.Public | BindingFlags.Static)!;
        Type riverSurfacePointType = GetTypeByName("WorldGen.RiverSurfacePoint");
        object riverSurfacePoint = Activator.CreateInstance(riverSurfacePointType, 4.25, 1.5, 0d)!;

        double[,] heightmap = new double[4, 4];
        object[] args =
        {
            riverSurfacePoint,
            heightmap,
            null!
        };

        bool didResolve = (bool)tryGetRiverWaterEndpointDirection.Invoke(null, args)!;

        Assert.That(didResolve, Is.True);
        Assert.That(args[2], Is.EqualTo("E"));
    }

    [Test]
    public void RiverUtility_FlipsStartEndpointSeamTangent()
    {
        Type utilityType = GetRuntimeType("Thiod.TileLoading.Runtime.TileLoaderRiverUtility");
        MethodInfo tryGetRiverWaterSeamTangent = utilityType.GetMethod(
            "TryGetRiverWaterSeamTangent",
            BindingFlags.Public | BindingFlags.Static)!;

        object[] args =
        {
            "N",
            true,
            null!
        };

        bool didResolve = (bool)tryGetRiverWaterSeamTangent.Invoke(null, args)!;
        Vector3 tangent = (Vector3)args[2];

        Assert.That(didResolve, Is.True);
        Assert.That(tangent, Is.EqualTo(Vector3.back));
    }

    [Test]
    public void GeneratedTerrainBatchState_TracksWorkflowAndSettlementState()
    {
        Type batchStateType = GetRuntimeType("Thiod.TileLoading.Runtime.GeneratedTerrainBatchState");
        Type requestType = GetRuntimeType("Thiod.TileLoading.Runtime.GeneratedTerrainRequest");
        object batchState = Activator.CreateInstance(
            batchStateType,
            BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic,
            binder: null,
            args: new object[]
            {
                "cache",
                "signature",
                7,
                new Vector3Int(3, 4, 0),
                Vector3.zero,
                Array.CreateInstance(requestType, 0),
                Array.Empty<Vector2Int>(),
                0d,
                42d
            },
            culture: null)!;

        MethodInfo advanceDeferredPhase = batchStateType.GetMethod("AdvanceDeferredPhase", BindingFlags.Instance | BindingFlags.Public)!;
        MethodInfo tryPromoteTerrainStageVisible = batchStateType.GetMethod("TryPromoteTerrainStageVisible", BindingFlags.Instance | BindingFlags.Public)!;
        MethodInfo tryMarkVegetationCenterReady = batchStateType.GetMethod("TryMarkVegetationCenterReady", BindingFlags.Instance | BindingFlags.Public)!;
        MethodInfo markVegetationFullySettled = batchStateType.GetMethod("MarkVegetationFullySettled", BindingFlags.Instance | BindingFlags.Public)!;
        MethodInfo markDeferredWorkflowCompleted = batchStateType.GetMethod("MarkDeferredWorkflowCompleted", BindingFlags.Instance | BindingFlags.Public)!;

        Assert.That(advanceDeferredPhase.Invoke(batchState, Array.Empty<object>()), Is.EqualTo(Enum.Parse(GetRuntimeType("Thiod.TileLoading.Runtime.DeferredGenerationPhase"), "DebugSplines")));
        Assert.That(advanceDeferredPhase.Invoke(batchState, Array.Empty<object>()), Is.EqualTo(Enum.Parse(GetRuntimeType("Thiod.TileLoading.Runtime.DeferredGenerationPhase"), "Vegetation")));
        Assert.That((bool)tryPromoteTerrainStageVisible.Invoke(batchState, Array.Empty<object>())!, Is.True);
        Assert.That((bool)tryPromoteTerrainStageVisible.Invoke(batchState, Array.Empty<object>())!, Is.False);
        Assert.That((bool)tryMarkVegetationCenterReady.Invoke(batchState, new object[] { 12.5d })!, Is.True);
        Assert.That((bool)tryMarkVegetationCenterReady.Invoke(batchState, new object[] { 18.5d })!, Is.False);

        markVegetationFullySettled.Invoke(batchState, new object[] { 25d });
        markDeferredWorkflowCompleted.Invoke(batchState, Array.Empty<object>());

        Assert.That(batchStateType.GetProperty("VegetationCenterReadyMilliseconds")!.GetValue(batchState), Is.EqualTo(12.5d));
        Assert.That(batchStateType.GetProperty("VegetationFullSettledMilliseconds")!.GetValue(batchState), Is.EqualTo(25d));
        Assert.That(batchStateType.GetProperty("TerrainStageVisible")!.GetValue(batchState), Is.EqualTo(true));
        Assert.That(batchStateType.GetProperty("NextDeferredPhase")!.GetValue(batchState), Is.EqualTo(Enum.Parse(GetRuntimeType("Thiod.TileLoading.Runtime.DeferredGenerationPhase"), "Completed")));
    }

    [Test]
    public void TileLoaderRuntimeState_ResetMethodsClearExpectedRuntimeFields()
    {
        Type stateType = GetRuntimeType("Thiod.TileLoading.Runtime.TileLoaderRuntimeState");
        object state = Activator.CreateInstance(stateType)!;
        stateType.GetProperty("HasLoadedInCurrentEnableCycle")!.SetValue(state, true);
        stateType.GetProperty("PendingRuntimeSeamRebuild")!.SetValue(state, true);
        stateType.GetProperty("RuntimeSeamRebuildFrame")!.SetValue(state, 99);
        stateType.GetProperty("TerrainPhaseLoadInProgress")!.SetValue(state, true);
        stateType.GetProperty("ActiveRuntimeRequestedTileCoordinate")!.SetValue(state, new Vector3Int(8, 9, 0));
        stateType.GetProperty("LastCompletedRuntimeNeighborhoodCenterTileCoordinate")!.SetValue(state, new Vector3Int(1, 2, 0));
        stateType.GetProperty("LastVegetationStreamingTargetWorldPosition")!.SetValue(state, new Vector3(1f, 2f, 3f));

        object statusDictionary = stateType.GetProperty("RuntimeVegetationTileStatusByCoordinate")!.GetValue(state)!;
        MethodInfo addMethod = statusDictionary.GetType().GetMethod("Add")!;
        addMethod.Invoke(statusDictionary, new object[] { new Vector2Int(1, 1), Enum.Parse(GetRuntimeType("Thiod.TileLoading.Runtime.VegetationTileStreamingStatus"), "Pending") });

        stateType.GetMethod("ResetRuntimeLifecycle", BindingFlags.Instance | BindingFlags.Public)!.Invoke(state, Array.Empty<object>());
        Assert.That(stateType.GetProperty("HasLoadedInCurrentEnableCycle")!.GetValue(state), Is.EqualTo(false));
        Assert.That(stateType.GetProperty("PendingRuntimeSeamRebuild")!.GetValue(state), Is.EqualTo(false));
        Assert.That(stateType.GetProperty("RuntimeSeamRebuildFrame")!.GetValue(state), Is.EqualTo(0));
        Assert.That(((System.Collections.ICollection)statusDictionary).Count, Is.EqualTo(0));

        addMethod.Invoke(statusDictionary, new object[] { new Vector2Int(2, 2), Enum.Parse(GetRuntimeType("Thiod.TileLoading.Runtime.VegetationTileStreamingStatus"), "Pending") });
        stateType.GetMethod("ResetRuntimeStreaming", BindingFlags.Instance | BindingFlags.Public)!.Invoke(state, Array.Empty<object>());
        Assert.That(stateType.GetProperty("TerrainPhaseLoadInProgress")!.GetValue(state), Is.EqualTo(false));
        Assert.That(stateType.GetProperty("ActiveRuntimeRequestedTileCoordinate")!.GetValue(state), Is.Null);
        Assert.That(stateType.GetProperty("LastCompletedRuntimeNeighborhoodCenterTileCoordinate")!.GetValue(state), Is.Null);
        Assert.That(stateType.GetProperty("LastVegetationStreamingTargetWorldPosition")!.GetValue(state), Is.Null);
        Assert.That(((System.Collections.ICollection)statusDictionary).Count, Is.EqualTo(0));
    }

    [Test]
    public void ControllerConstructors_UseCapabilityPortsInsteadOfLegacyOwnerInterfaces()
    {
        Assembly runtimeAssembly = typeof(TileLoader).Assembly;

        Assert.That(runtimeAssembly.GetType("Thiod.TileLoading.Runtime.ITerrainStreamingPipelineOwner", throwOnError: false), Is.Null);
        Assert.That(runtimeAssembly.GetType("Thiod.TileLoading.Runtime.IPlayerCentricSurfaceControllerOwner", throwOnError: false), Is.Null);
        Assert.That(runtimeAssembly.GetType("Thiod.TileLoading.Runtime.IVegetationStreamingControllerOwner", throwOnError: false), Is.Null);

        ConstructorInfo terrainCtor = GetRuntimeType("Thiod.TileLoading.Runtime.TerrainStreamingPipeline").GetConstructors(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)[0];
        ConstructorInfo surfaceCtor = GetRuntimeType("Thiod.TileLoading.Runtime.PlayerCentricSurfaceController").GetConstructors(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)[0];
        ConstructorInfo vegetationCtor = GetRuntimeType("Thiod.TileLoading.Runtime.VegetationStreamingController").GetConstructors(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)[0];

        Assert.That(terrainCtor.GetParameters().Length, Is.GreaterThan(1));
        Assert.That(surfaceCtor.GetParameters().Length, Is.GreaterThan(1));
        Assert.That(vegetationCtor.GetParameters().Length, Is.GreaterThan(1));
    }

    private static Type GetRuntimeType(string fullName)
    {
        Type? type = typeof(TileLoader).Assembly.GetType(fullName, throwOnError: false);
        Assert.That(type, Is.Not.Null, $"Expected runtime type '{fullName}' to exist.");
        return type!;
    }

    private static Type GetTypeByName(string fullName)
    {
        foreach (Assembly assembly in AppDomain.CurrentDomain.GetAssemblies())
        {
            Type? type = assembly.GetType(fullName, throwOnError: false);
            if (type != null)
            {
                return type;
            }
        }

        Assert.Fail($"Expected type '{fullName}' to exist in the current AppDomain.");
        throw new InvalidOperationException();
    }
}

}
