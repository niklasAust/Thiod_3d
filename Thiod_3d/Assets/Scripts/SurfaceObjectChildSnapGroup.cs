using System;
using System.Collections.Generic;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif

[ExecuteAlways]
[DisallowMultipleComponent]
[AddComponentMenu("Environment/Surface Object Child Snap Group")]
public sealed class SurfaceObjectChildSnapGroup : MonoBehaviour
{
    private static int automaticRuntimeSnapSuppressionDepth;

    [SerializeField] private bool autoSnapOnEnable = true;
    [SerializeField] private bool includeInactiveChildren = true;
    [SerializeField] private bool alignToSurfaceNormal = true;
    [SerializeField] private float verticalOffset = 0f;
    [SerializeField] private float normalOffset = 0f;

    [NonSerialized] private readonly List<ChildState> childStates = new();

    public static IDisposable SuppressAutomaticRuntimeSnap()
    {
        automaticRuntimeSnapSuppressionDepth++;
        return new AutomaticRuntimeSnapSuppressionScope();
    }

    private void OnEnable()
    {
        if (ShouldSkip())
        {
            return;
        }

        EnsureChildStatesCaptured();

        if (!Application.isPlaying || !autoSnapOnEnable || automaticRuntimeSnapSuppressionDepth > 0)
        {
            return;
        }

        ApplyAtCurrentTransformAndFreeze();
    }

    private void OnValidate()
    {
        if (ShouldSkip())
        {
            return;
        }

        CaptureChildStates();
    }

    [ContextMenu("Snap Children Now")]
    public void SnapChildrenNow()
    {
        EnsureChildStatesCaptured();
        ResetChildren();
        SnapChildren();
    }

    [ContextMenu("Reset Children")]
    public void ResetChildren()
    {
        EnsureChildStatesCaptured();
        for (int i = 0; i < childStates.Count; i++)
        {
            ChildState state = childStates[i];
            if (state.Transform == null)
            {
                continue;
            }

            state.Transform.SetLocalPositionAndRotation(state.LocalPosition, state.LocalRotation);
            state.Transform.localScale = state.LocalScale;
        }
    }

    public bool ApplyAtCurrentTransformAndFreeze()
    {
        EnsureChildStatesCaptured();
        ResetChildren();
        bool snappedAnyChild = SnapChildren();
        autoSnapOnEnable = false;
        return snappedAnyChild;
    }

    private bool SnapChildren()
    {
        bool snappedAnyChild = false;
        for (int i = 0; i < childStates.Count; i++)
        {
            ChildState state = childStates[i];
            if (state.Transform == null)
            {
                continue;
            }

            if (!TileLoaderTerrainSampler.TrySampleSurfaceObjectSurface(state.Transform, out RaycastHit surfaceHit))
            {
                continue;
            }

            if (alignToSurfaceNormal)
            {
                Quaternion baselineWorldRotation = transform.rotation * state.LocalRotation;
                Quaternion alignment = Quaternion.FromToRotation(transform.up, surfaceHit.normal);
                state.Transform.rotation = alignment * baselineWorldRotation;
            }
            else
            {
                state.Transform.rotation = transform.rotation * state.LocalRotation;
            }

            state.Transform.position =
                surfaceHit.point +
                Vector3.up * verticalOffset +
                surfaceHit.normal * normalOffset;
            snappedAnyChild = true;
        }

        return snappedAnyChild;
    }

    private void CaptureChildStates()
    {
        childStates.Clear();

        for (int i = 0; i < transform.childCount; i++)
        {
            Transform child = transform.GetChild(i);
            if (child == null)
            {
                continue;
            }

            if (!includeInactiveChildren && !child.gameObject.activeSelf)
            {
                continue;
            }

            childStates.Add(new ChildState
            {
                Transform = child,
                LocalPosition = child.localPosition,
                LocalRotation = child.localRotation,
                LocalScale = child.localScale
            });
        }
    }

    private void EnsureChildStatesCaptured()
    {
        if (!NeedsChildStateRefresh())
        {
            return;
        }

        CaptureChildStates();
    }

    private bool NeedsChildStateRefresh()
    {
        int expectedChildCount = 0;
        for (int i = 0; i < transform.childCount; i++)
        {
            Transform child = transform.GetChild(i);
            if (child == null)
            {
                continue;
            }

            if (!includeInactiveChildren && !child.gameObject.activeSelf)
            {
                continue;
            }

            expectedChildCount++;
        }

        if (childStates.Count != expectedChildCount)
        {
            return true;
        }

        int stateIndex = 0;
        for (int i = 0; i < transform.childCount; i++)
        {
            Transform child = transform.GetChild(i);
            if (child == null)
            {
                continue;
            }

            if (!includeInactiveChildren && !child.gameObject.activeSelf)
            {
                continue;
            }

            if (stateIndex >= childStates.Count || childStates[stateIndex].Transform != child)
            {
                return true;
            }

            stateIndex++;
        }

        return false;
    }

    private bool ShouldSkip()
    {
        if (!isActiveAndEnabled)
        {
            return true;
        }

#if UNITY_EDITOR
        if (PrefabUtility.IsPartOfPrefabAsset(gameObject))
        {
            return true;
        }
#endif

        return false;
    }

    [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
    private static void ResetRuntimeState()
    {
        automaticRuntimeSnapSuppressionDepth = 0;
    }

    private sealed class AutomaticRuntimeSnapSuppressionScope : IDisposable
    {
        private bool disposed;

        public void Dispose()
        {
            if (disposed)
            {
                return;
            }

            disposed = true;
            automaticRuntimeSnapSuppressionDepth = Mathf.Max(0, automaticRuntimeSnapSuppressionDepth - 1);
        }
    }

    [Serializable]
    private sealed class ChildState
    {
        public Transform Transform;
        public Vector3 LocalPosition;
        public Quaternion LocalRotation;
        public Vector3 LocalScale;
    }
}
