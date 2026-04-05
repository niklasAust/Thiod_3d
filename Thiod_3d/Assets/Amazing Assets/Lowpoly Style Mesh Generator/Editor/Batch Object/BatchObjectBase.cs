// Lowpoly Style Mesh Generator <https://u3d.as/2z0X>
// Copyright (c) Amazing Assets <https://amazingassets.world>
 
using System.IO;

using UnityEngine;


namespace AmazingAssets.LowpolyStyleMeshGenerator.Editor
{
    abstract public class BatchObjectBase
    {
        public GameObject gameObject;
        public string gameObjectSortName;

        public string savePath;

        public bool expanded;

        public string exception;


        public BatchObjectBase(UnityEngine.Object unityObject, bool expanded)
        {
            gameObject = (GameObject)unityObject;
            gameObjectSortName = EditorUtilities.PadNumbers(gameObject.name);

            string assetName = EditorWindow.active.editorSettings.GetSaveAssetName(gameObject, true);
            string assetSaveDirectory = EditorWindow.active.editorSettings.GetAssetSaveDirectory(gameObject, true, true);

            savePath = Path.Combine(assetSaveDirectory, assetName);

            this.expanded = expanded;
        }
    }


    abstract public class BatchObjectMeshInfoBase
    {
        public MeshFilter meshFilter;
        public SkinnedMeshRenderer skinnedMeshRenderer;
        public Renderer renderer;
        public Transform transform;

        public Mesh mesh;
        public string meshSortName;
        public bool isSkinnedMesh;

        public bool invalidMeshData;

        public BatchObjectMeshInfoBase(MeshFilter meshFilter, SkinnedMeshRenderer skinnedMeshRenderer)
        {
            if (meshFilter != null)
            {
                this.meshFilter = meshFilter;
                isSkinnedMesh = false;

                mesh = meshFilter.sharedMesh;
                transform = meshFilter.transform;
            }
            else
            {
                this.skinnedMeshRenderer = skinnedMeshRenderer;
                isSkinnedMesh = true;

                mesh = skinnedMeshRenderer.sharedMesh;
                transform = skinnedMeshRenderer.transform;
            }

            if (mesh != null)
                meshSortName = EditorUtilities.PadNumbers(mesh.name);

            invalidMeshData = LowpolyStyleMeshGeneratorUtilities.IsMeshValid(mesh, false) == false;

            this.renderer = transform.GetComponent<Renderer>();
        }
    }
}