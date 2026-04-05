// Lowpoly Style Mesh Generator <https://u3d.as/2z0X>
// Copyright (c) Amazing Assets <https://amazingassets.world>
 
using System;
using System.IO;
using System.Linq;
using System.Collections.Generic;

using UnityEngine;
using UnityEditor;


namespace AmazingAssets.LowpolyStyleMeshGenerator.Editor
{
    internal class BatchObjectsDrawer
    {
        enum SortBy { None, ObjectData, MeshCount, AssetFormat, SubmeshCount, VertexAndTriangleCountOfOriginalMesh, VertexCountOfLowpolyMesh, IndexFormat, UV0, VertexColor, TextureProperty, ColorProperty, VertexAttribute }
        enum ScrollViewItemVisibility { Visible, AboveDrawArea, BelowDrawArea }


        static SortBy sortBy = SortBy.None;
        static Vector2 scrollBatchObjects;
        static bool sortByAscending = true;    //true - OrderBy, false - OrderByDescending


        static int singleLineHeight = 20;


        internal static void Draw()
        {
            CatchKeyboard();


            List<BatchObject> listBatchObjects = EditorWindow.active.listBatchObjects;
            EditorSettings editorSettings = EditorWindow.active.editorSettings;


            Rect rectObjectData = new Rect();
            Rect rectMeshCount = new Rect();
            Rect rectAssetFormat = new Rect(); bool needRectAssetFormat = false;
            Rect rectSubmeshCount = new Rect();
            Rect rectVertexAndTriangleCountOfOriginalMesh = new Rect();
            Rect rectVertexCountOfLowpolyMesh = new Rect();
            Rect rectIndexFormat = new Rect();
            Rect rectUV0 = new Rect();
            Rect rectVertexAttribute = new Rect(); bool needRectVertexAttribute = false;
            Rect rectVertexColor = new Rect();
            Rect rectTextureProperty = new Rect(); bool needRectTextureProperty = false;
            Rect rectColorProperty = new Rect(); bool needRectColorProperty = false;
            Rect rectRefresh = new Rect();


            bool needRepaint = false;
            Rect toolbarRect;


            int visibleBatchObjectsCount = 0;
            using (new EditorGUIHelper.EditorGUILayoutBeginVertical(EditorStyles.helpBox, GUILayout.MaxHeight(GetScrolViewHeight())))
            {
                toolbarRect = EditorGUILayout.GetControlRect(false, singleLineHeight);


                scrollBatchObjects = EditorGUILayout.BeginScrollView(scrollBatchObjects);
                {
                    for (int i = 0; i < listBatchObjects.Count; i++)
                    {
                        BatchObject currentBatchObject = listBatchObjects[i];

                        //Rect for current raw
                        Rect currentRowRect = EditorGUILayout.GetControlRect();


                        if (i == 0)
                            SplitControlRect(currentRowRect, out rectObjectData, out rectMeshCount,
                                             out needRectAssetFormat, out rectAssetFormat,
                                             out rectSubmeshCount,
                                             out rectVertexAndTriangleCountOfOriginalMesh,
                                             out rectVertexCountOfLowpolyMesh,
                                             out rectIndexFormat,
                                             out rectUV0,
                                             out needRectVertexAttribute, out rectVertexAttribute,
                                             out rectVertexColor,
                                             out needRectTextureProperty, out rectTextureProperty,
                                             out needRectColorProperty, out rectColorProperty,
                                             out rectRefresh);


                        if (currentBatchObject == null || currentBatchObject.gameObject == null || currentBatchObject.meshInfo == null || currentBatchObject.meshInfo.Count == 0)
                        {
                            using (new EditorGUIHelper.GUIBackgroundColor(Color.yellow))
                            {
                                EditorGUI.ObjectField(new Rect(rectObjectData.xMin + 16, currentRowRect.yMin, rectObjectData.width - 16, currentRowRect.height), null, typeof(GameObject), false);
                            }

                            needRepaint = true;
                        }
                        else
                        {
                            ScrollViewItemVisibility isRowVisible = IsRectVisibleInsideScrollView(toolbarRect, currentRowRect, scrollBatchObjects);
                            if (isRowVisible == ScrollViewItemVisibility.Visible)
                            {
                                visibleBatchObjectsCount += 1;


                                //Foldout
                                EditorGUI.BeginChangeCheck();
                                currentBatchObject.expanded = EditorGUI.Foldout(new Rect(rectObjectData.xMin + 18, currentRowRect.yMin, 18, currentRowRect.height), currentBatchObject.expanded, EditorResources.GUIContentFoldout);
                                if (EditorGUI.EndChangeCheck())
                                {
                                    if (Event.current.control)
                                    {
                                        currentBatchObject.meshInfo.ForEach(c => c.expanded = currentBatchObject.expanded);
                                    }

                                    if (Event.current.alt)
                                    {
                                        listBatchObjects.ForEach(c => c.expanded = currentBatchObject.expanded);
                                        listBatchObjects.ForEach(c => c.meshInfo.ForEach(p => p.expanded = currentBatchObject.expanded));
                                    }
                                }

                                //Higlight selected row
                                EditorGUI.BeginChangeCheck();
                                using (new EditorGUIHelper.GUIBackgroundColor(Color.clear))
                                {
                                    EditorGUI.Foldout(new Rect(rectObjectData.xMax, currentRowRect.yMin, rectRefresh.xMin - rectObjectData.xMax, currentRowRect.height), false, GUIContent.none, true);
                                }
                                if (EditorGUI.EndChangeCheck())
                                {
                                    if (EditorWindow.active.selectedBatchObjectIndex == i)
                                        EditorWindow.active.selectedBatchObjectIndex = -1;
                                    else
                                        EditorWindow.active.selectedBatchObjectIndex = i;
                                }

                                if (EditorWindow.active.selectedBatchObjectIndex == i)
                                    EditorGUI.DrawRect(new Rect(rectObjectData.xMax + 5, currentRowRect.yMin, rectRefresh.xMin - rectObjectData.xMax - 6, currentRowRect.height), Color.green * 0.2f);


                                //Visibility
                                if (currentBatchObject.gameObject.scene != null && currentBatchObject.gameObject.scene.isLoaded)
                                {
                                    bool visibility = currentBatchObject.gameObject.activeSelf;
                                    if (GUI.Button(new Rect(rectObjectData.xMin, currentRowRect.yMin + 2, 14, 14), visibility ? EditorResources.GUIContentVisibilityOn : EditorResources.GUIContentVisibilityOff, GUIStyle.none))
                                    {
                                        visibility = !visibility;

                                        currentBatchObject.gameObject.SetActive(visibility);

                                        if (Event.current.alt)
                                            listBatchObjects.ForEach(c => c.gameObject.SetActive(visibility));
                                    }
                                }
                                else
                                {
                                    using (new EditorGUIHelper.GUIEnabled(false))
                                    {
                                        GUI.Box(new Rect(rectObjectData.xMin, currentRowRect.yMin + 2, 14, 14), EditorResources.GUIContentVisibilityOff, GUIStyle.none);
                                    }
                                }

                                //GameObject or ProjectObject
                                Color backgroundColor = Color.white;
                                if (!(currentBatchObject.gameObject.scene != null && currentBatchObject.gameObject.scene.isLoaded))
                                    backgroundColor = EditorResources.projectRelatedPathColor;
                                if (EditorWindow.active.problematicBatchObject != null && EditorWindow.active.problematicBatchObject.gameObject == currentBatchObject.gameObject)
                                    backgroundColor = Color.red;
                                if (currentBatchObject.hasMeshProblems)
                                    backgroundColor = Color.red;


                                using (new EditorGUIHelper.GUIBackgroundColor(backgroundColor))
                                {
                                    EditorGUI.ObjectField(new Rect(rectObjectData.xMin + 34, currentRowRect.yMin, rectObjectData.width - 34, currentRowRect.height), currentBatchObject.gameObject, typeof(GameObject), false);
                                }


                                //Mesh count
                                EditorGUI.LabelField(new Rect(rectMeshCount.xMin, currentRowRect.yMin, rectMeshCount.width, currentRowRect.height), currentBatchObject.meshInfo.Count.ToString("N0"), EditorResources.GUIStyleCenteredGreyMiniLabel);


                                //.asset format
                                if (needRectAssetFormat)
                                {
                                    Rect assetFormatDrawRect = new Rect(rectAssetFormat.xMin + rectAssetFormat.width / 2 - 6, currentRowRect.yMin + 2, 12, 12);
                                    switch (currentBatchObject.isMeshAssetFormat)
                                    {
                                        case BatchObject.OptionsState.Yes: GUI.DrawTexture(assetFormatDrawRect, EditorResources.IconYes); break;
                                        case BatchObject.OptionsState.No: GUI.DrawTexture(assetFormatDrawRect, EditorResources.IconNo); break;
                                        case BatchObject.OptionsState.Mixed: EditorGUI.LabelField(assetFormatDrawRect, "-", EditorResources.GUIStyleCenteredGreyMiniLabel); break;
                                    }
                                }


                                //Submesh
                                EditorGUI.LabelField(new Rect(rectSubmeshCount.xMin, currentRowRect.yMin, rectSubmeshCount.width, currentRowRect.height), currentBatchObject.submeshCount, EditorResources.GUIStyleCenteredGreyMiniLabel);


                                //Vertex Count
                                EditorGUI.LabelField(new Rect(rectVertexAndTriangleCountOfOriginalMesh.xMin, currentRowRect.yMin, rectVertexAndTriangleCountOfOriginalMesh.width, currentRowRect.height), currentBatchObject.vertexAndTriangleCountOfOriginalMesh, EditorResources.GUIStyleCenteredGreyMiniLabel);
                                EditorGUI.LabelField(new Rect(rectVertexCountOfLowpolyMesh.xMin, currentRowRect.yMin, rectVertexCountOfLowpolyMesh.width, currentRowRect.height), currentBatchObject.vertexCountOfLowpolyMesh, EditorResources.GUIStyleCenteredGreyMiniLabel);


                                //Index Format
                                EditorGUI.DrawRect(new Rect(rectIndexFormat.xMin, currentRowRect.yMin + 3, rectIndexFormat.width, currentRowRect.height - 5), Color.gray * 0.1f);
                                EditorGUI.LabelField(new Rect(rectIndexFormat.xMin, currentRowRect.yMin + 3, rectIndexFormat.width, currentRowRect.height - 5), currentBatchObject.indexFormat == UnityEngine.Rendering.IndexFormat.UInt32 ? "32 Bits" : "16 Bits",
                                                                                                                                                                currentBatchObject.indexFormat == UnityEngine.Rendering.IndexFormat.UInt32 ? EditorResources.GUIStyleMeshIndex : EditorResources.GUIStyleCenteredGreyMiniLabel);

                                //UV0
                                {
                                    Rect uv0DrawRect = new Rect(rectUV0.xMin + rectUV0.width / 2 - 6, currentRowRect.yMin + 2, 12, 12);
                                    switch (currentBatchObject.hasUV0)
                                    {
                                        case BatchObject.OptionsState.Yes: GUI.DrawTexture(uv0DrawRect, EditorResources.IconYes); break;
                                        case BatchObject.OptionsState.No: GUI.DrawTexture(uv0DrawRect, EditorResources.IconNo); break;
                                        case BatchObject.OptionsState.Mixed: EditorGUI.LabelField(uv0DrawRect, "-", EditorResources.GUIStyleCenteredGreyMiniLabel); break;
                                    }
                                }

                                //Vertex Attribute
                                if (needRectVertexAttribute)
                                {
                                    Rect vertexAttributeDrawRect = new Rect(rectVertexAttribute.xMin + rectVertexAttribute.width / 2 - 6, currentRowRect.yMin + 2, 12, 12);
                                    switch (editorSettings.solverFaceCenter)
                                    {
                                        case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV0: /*Never used*/ break;

                                        case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV1:
                                            {
                                                switch (currentBatchObject.hasUV1)
                                                {
                                                    case BatchObject.OptionsState.Yes: GUI.DrawTexture(vertexAttributeDrawRect, EditorResources.IconYes); break;
                                                    case BatchObject.OptionsState.No: GUI.DrawTexture(vertexAttributeDrawRect, EditorResources.IconNo); break;
                                                    case BatchObject.OptionsState.Mixed: EditorGUI.LabelField(vertexAttributeDrawRect, "-", EditorResources.GUIStyleCenteredGreyMiniLabel); break;
                                                }
                                            }
                                            break;

                                        case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV2:
                                            {
                                                switch (currentBatchObject.hasUV2)
                                                {
                                                    case BatchObject.OptionsState.Yes: GUI.DrawTexture(vertexAttributeDrawRect, EditorResources.IconYes); break;
                                                    case BatchObject.OptionsState.No: GUI.DrawTexture(vertexAttributeDrawRect, EditorResources.IconNo); break;
                                                    case BatchObject.OptionsState.Mixed: EditorGUI.LabelField(vertexAttributeDrawRect, "-", EditorResources.GUIStyleCenteredGreyMiniLabel); break;
                                                }
                                            }
                                            break;

                                        case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV3:
                                            {
                                                switch (currentBatchObject.hasUV3)
                                                {
                                                    case BatchObject.OptionsState.Yes: GUI.DrawTexture(vertexAttributeDrawRect, EditorResources.IconYes); break;
                                                    case BatchObject.OptionsState.No: GUI.DrawTexture(vertexAttributeDrawRect, EditorResources.IconNo); break;
                                                    case BatchObject.OptionsState.Mixed: EditorGUI.LabelField(vertexAttributeDrawRect, "-", EditorResources.GUIStyleCenteredGreyMiniLabel); break;
                                                }
                                            }
                                            break;

                                        case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV4:
                                            {
                                                switch (currentBatchObject.hasUV4)
                                                {
                                                    case BatchObject.OptionsState.Yes: GUI.DrawTexture(vertexAttributeDrawRect, EditorResources.IconYes); break;
                                                    case BatchObject.OptionsState.No: GUI.DrawTexture(vertexAttributeDrawRect, EditorResources.IconNo); break;
                                                    case BatchObject.OptionsState.Mixed: EditorGUI.LabelField(vertexAttributeDrawRect, "-", EditorResources.GUIStyleCenteredGreyMiniLabel); break;
                                                }
                                            }
                                            break;

                                        case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV5:
                                            {
                                                switch (currentBatchObject.hasUV5)
                                                {
                                                    case BatchObject.OptionsState.Yes: GUI.DrawTexture(vertexAttributeDrawRect, EditorResources.IconYes); break;
                                                    case BatchObject.OptionsState.No: GUI.DrawTexture(vertexAttributeDrawRect, EditorResources.IconNo); break;
                                                    case BatchObject.OptionsState.Mixed: EditorGUI.LabelField(vertexAttributeDrawRect, "-", EditorResources.GUIStyleCenteredGreyMiniLabel); break;
                                                }
                                            }
                                            break;

                                        case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV6:
                                            {
                                                switch (currentBatchObject.hasUV6)
                                                {
                                                    case BatchObject.OptionsState.Yes: GUI.DrawTexture(vertexAttributeDrawRect, EditorResources.IconYes); break;
                                                    case BatchObject.OptionsState.No: GUI.DrawTexture(vertexAttributeDrawRect, EditorResources.IconNo); break;
                                                    case BatchObject.OptionsState.Mixed: EditorGUI.LabelField(vertexAttributeDrawRect, "-", EditorResources.GUIStyleCenteredGreyMiniLabel); break;
                                                }
                                            }
                                            break;

                                        case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV7:
                                            {
                                                switch (currentBatchObject.hasUV7)
                                                {
                                                    case BatchObject.OptionsState.Yes: GUI.DrawTexture(vertexAttributeDrawRect, EditorResources.IconYes); break;
                                                    case BatchObject.OptionsState.No: GUI.DrawTexture(vertexAttributeDrawRect, EditorResources.IconNo); break;
                                                    case BatchObject.OptionsState.Mixed: EditorGUI.LabelField(vertexAttributeDrawRect, "-", EditorResources.GUIStyleCenteredGreyMiniLabel); break;
                                                }
                                            }
                                            break;

                                        case LowpolyStyleMeshGeneratorEnum.VertexAttribute.Normal:
                                            {
                                                switch (currentBatchObject.hasNormal)
                                                {
                                                    case BatchObject.OptionsState.Yes: GUI.DrawTexture(vertexAttributeDrawRect, EditorResources.IconYes); break;
                                                    case BatchObject.OptionsState.No: GUI.DrawTexture(vertexAttributeDrawRect, EditorResources.IconNo); break;
                                                    case BatchObject.OptionsState.Mixed: EditorGUI.LabelField(vertexAttributeDrawRect, "-", EditorResources.GUIStyleCenteredGreyMiniLabel); break;
                                                }
                                            }
                                            break;

                                        case LowpolyStyleMeshGeneratorEnum.VertexAttribute.Tangent:
                                            {
                                                switch (currentBatchObject.hasTangent)
                                                {
                                                    case BatchObject.OptionsState.Yes: GUI.DrawTexture(vertexAttributeDrawRect, EditorResources.IconYes); break;
                                                    case BatchObject.OptionsState.No: GUI.DrawTexture(vertexAttributeDrawRect, EditorResources.IconNo); break;
                                                    case BatchObject.OptionsState.Mixed: EditorGUI.LabelField(vertexAttributeDrawRect, "-", EditorResources.GUIStyleCenteredGreyMiniLabel); break;
                                                }
                                            }
                                            break;

                                        case LowpolyStyleMeshGeneratorEnum.VertexAttribute.Color: /*Never used*/ break;


                                        default:
                                            break;
                                    }
                                }


                                //Vertex Color
                                {
                                    Rect vertexNormalDrawRect = new Rect(rectVertexColor.xMin + rectVertexColor.width / 2 - 6, currentRowRect.yMin + 2, 12, 12);
                                    switch (currentBatchObject.hasVertexColor)
                                    {
                                        case BatchObject.OptionsState.Yes: GUI.DrawTexture(vertexNormalDrawRect, EditorResources.IconYes); break;
                                        case BatchObject.OptionsState.No: GUI.DrawTexture(vertexNormalDrawRect, EditorResources.IconNo); break;
                                        case BatchObject.OptionsState.Mixed: EditorGUI.LabelField(vertexNormalDrawRect, "-", EditorResources.GUIStyleCenteredGreyMiniLabel); break;
                                    }
                                }

                                //Texture
                                if (needRectTextureProperty)
                                {
                                    Rect drawRect = new Rect(rectTextureProperty.xMin + rectTextureProperty.width / 2 - 6, currentRowRect.yMin + 2, 12, 12);

                                    switch (currentBatchObject.GetMaterialTexturePropertyState(editorSettings.solverTexture1PropertyName, editorSettings.solverTexture2PropertyName, editorSettings.solverTexture3PropertyName))
                                    {
                                        case BatchObjectMeshInfo.PropertyState.Available: GUI.DrawTexture(drawRect, EditorResources.IconYes); break;
                                        case BatchObjectMeshInfo.PropertyState.AvailableButEmpty: GUI.DrawTexture(drawRect, EditorResources.IconYesDisabled); break;
                                        case BatchObjectMeshInfo.PropertyState.NotAvailable: GUI.DrawTexture(drawRect, EditorResources.IconNo); break;
                                        case BatchObjectMeshInfo.PropertyState.NoMaterial: GUI.DrawTexture(drawRect, EditorResources.IconWarning); break;

                                        case BatchObjectMeshInfo.PropertyState.Mixed: EditorGUI.LabelField(drawRect, "-", EditorResources.GUIStyleCenteredGreyMiniLabel); break;
                                    }
                                }

                                //Color
                                if (needRectColorProperty)
                                {
                                    Rect drawRect = new Rect(rectColorProperty.xMin + rectColorProperty.width / 2 - 6, currentRowRect.yMin + 2, 12, 12);

                                    switch (currentBatchObject.GetMaterialColorPropertyState(editorSettings.solverColor1PropertyName, editorSettings.solverColor2PropertyName, editorSettings.solverColor3PropertyName))
                                    {
                                        case BatchObjectMeshInfo.PropertyState.Available: GUI.DrawTexture(drawRect, EditorResources.IconYes); break;
                                        case BatchObjectMeshInfo.PropertyState.AvailableButEmpty: GUI.DrawTexture(drawRect, EditorResources.IconYesDisabled); break;
                                        case BatchObjectMeshInfo.PropertyState.NotAvailable: GUI.DrawTexture(drawRect, EditorResources.IconNo); break;
                                        case BatchObjectMeshInfo.PropertyState.NoMaterial: GUI.DrawTexture(drawRect, EditorResources.IconWarning); break;

                                        case BatchObjectMeshInfo.PropertyState.Mixed: EditorGUI.LabelField(drawRect, "-", EditorResources.GUIStyleCenteredGreyMiniLabel); break;
                                    }
                                }


                                //Remove
                                if (GUI.Button(new Rect(rectRefresh.xMin, currentRowRect.yMin - 1, rectRefresh.width, currentRowRect.height - 1), EditorResources.GUIContentRemoveButton, EditorStyles.toolbarButton))
                                {
                                    if (Event.current.button == 1)
                                    {
                                        if (Event.current.control)
                                            RemoveAllElementsBelow(i);
                                        else
                                            RemoveAllBatchObjectsExceptSelected(i);
                                    }
                                    else
                                    {
                                        if (Event.current.control)
                                            RemoveAllElementsAbove(i);
                                        else
                                            RemoveSelectedBatchObject(i, false);
                                    }

                                    break;
                                }


                                //Draw line
                                if (!(i == listBatchObjects.Count - 1 && currentBatchObject.expanded == false))
                                    EditorGUI.DrawRect(new Rect(rectObjectData.xMax + 5, currentRowRect.yMax, rectRefresh.xMax - rectObjectData.xMax - 5, 1), Color.gray);
                            }
                            else if (isRowVisible == ScrollViewItemVisibility.BelowDrawArea)
                                break;


                            if (currentBatchObject.expanded)
                            {
                                for (int m = 0; m < currentBatchObject.meshInfo.Count; m++)
                                {
                                    BatchObjectMeshInfo meshInfo = currentBatchObject.meshInfo[m];

                                    currentRowRect = EditorGUILayout.GetControlRect();

                                    isRowVisible = IsRectVisibleInsideScrollView(toolbarRect, currentRowRect, scrollBatchObjects);
                                    if (isRowVisible == ScrollViewItemVisibility.Visible)
                                    {
                                        visibleBatchObjectsCount += 1;


                                        //Foldout
                                        EditorGUI.BeginChangeCheck();
                                        meshInfo.expanded = EditorGUI.Foldout(new Rect(rectObjectData.xMin + 34, currentRowRect.yMin, 18, currentRowRect.height), meshInfo.expanded, string.Empty);
                                        if (EditorGUI.EndChangeCheck())
                                        {
                                            if (Event.current.alt)
                                            {
                                                currentBatchObject.meshInfo.ForEach(c => c.expanded = meshInfo.expanded);
                                            }
                                        }

                                        //Higlight selected row
                                        EditorGUI.BeginChangeCheck();
                                        using (new EditorGUIHelper.GUIBackgroundColor(Color.clear))
                                        {
                                            EditorGUI.Foldout(new Rect(rectObjectData.xMax, currentRowRect.yMin, rectRefresh.xMin - rectObjectData.xMax, currentRowRect.height), false, GUIContent.none, true);
                                        }
                                        if (EditorGUI.EndChangeCheck())
                                        {
                                            if (EditorWindow.active.selectedBatchObjectIndex == i)
                                                EditorWindow.active.selectedBatchObjectIndex = -1;
                                            else
                                                EditorWindow.active.selectedBatchObjectIndex = i;
                                        }

                                        if (EditorWindow.active.selectedBatchObjectIndex == i)
                                            EditorGUI.DrawRect(new Rect(rectObjectData.xMax + 5, currentRowRect.yMin - 1, rectRefresh.xMin - rectObjectData.xMax - 6, currentRowRect.height + 1), EditorResources.groupHighLightColor);


                                        using (new EditorGUIHelper.GUIEnabled(false))
                                        {
                                            //MeshFilter / SkinnedMeshRenderer
                                            if (meshInfo.meshFilter != null)
                                                EditorGUI.ObjectField(new Rect(rectObjectData.xMin + 50, currentRowRect.yMin, (rectObjectData.width - 54) * 0.5f, currentRowRect.height), meshInfo.meshFilter, typeof(MeshFilter), false);
                                            else if (meshInfo.skinnedMeshRenderer != null)
                                                EditorGUI.ObjectField(new Rect(rectObjectData.xMin + 50, currentRowRect.yMin, (rectObjectData.width - 54) * 0.5f, currentRowRect.height), meshInfo.skinnedMeshRenderer, typeof(SkinnedMeshRenderer), false);
                                            else
                                            {
                                                needRepaint = true;

                                                break;
                                            }


                                            //Mesh
                                            using (new EditorGUIHelper.GUIBackgroundColor(meshInfo.invalidMeshData ? Color.red : Color.white))
                                            {
                                                EditorGUI.ObjectField(new Rect(rectObjectData.xMin + 50 + (rectObjectData.width - 50) * 0.5f, currentRowRect.yMin, (rectObjectData.width - 50) * 0.5f, currentRowRect.height), meshInfo.mesh, typeof(Mesh), false);
                                            }


                                            //.asset format
                                            if (needRectAssetFormat)
                                                GUI.DrawTexture(new Rect(rectAssetFormat.xMin + rectAssetFormat.width / 2 - 6, currentRowRect.yMin + 2, 12, 12), meshInfo.isMeshAssetFormat ? EditorResources.IconYes : EditorResources.IconNo);


                                            //Submesh
                                            if (meshInfo.mesh == null)
                                                EditorGUI.LabelField(new Rect(rectSubmeshCount.xMin, currentRowRect.yMin, rectSubmeshCount.width, currentRowRect.height), "0", EditorResources.GUIStyleCenteredGreyMiniLabel);
                                            else
                                                EditorGUI.LabelField(new Rect(rectSubmeshCount.xMin, currentRowRect.yMin, rectSubmeshCount.width, currentRowRect.height), meshInfo.mesh.subMeshCount.ToString(), EditorResources.GUIStyleCenteredGreyMiniLabel);


                                            //Vertex Count
                                            EditorGUI.LabelField(new Rect(rectVertexAndTriangleCountOfOriginalMesh.xMin, currentRowRect.yMin, rectVertexAndTriangleCountOfOriginalMesh.width, currentRowRect.height), meshInfo.vertexAndTriangleCountOfOriginalMesh, EditorResources.GUIStyleCenteredGreyMiniLabel);
                                            EditorGUI.LabelField(new Rect(rectVertexCountOfLowpolyMesh.xMin, currentRowRect.yMin, rectVertexCountOfLowpolyMesh.width, currentRowRect.height), meshInfo.vertexCountForLowpolyMesh, EditorResources.GUIStyleCenteredGreyMiniLabel);


                                            //Index Format 
                                            EditorGUI.DrawRect(new Rect(rectIndexFormat.xMin, currentRowRect.yMin + 3, rectIndexFormat.width, currentRowRect.height - 5), Color.gray * 0.1f);
                                            if (meshInfo.mesh == null)
                                                EditorGUI.LabelField(new Rect(rectIndexFormat.xMin, currentRowRect.yMin + 3, rectIndexFormat.width, currentRowRect.height - 5), "-", EditorResources.GUIStyleCenteredGreyMiniLabel);
                                            else
                                                EditorGUI.LabelField(new Rect(rectIndexFormat.xMin, currentRowRect.yMin + 3, rectIndexFormat.width, currentRowRect.height - 5), meshInfo.indexFormat == UnityEngine.Rendering.IndexFormat.UInt32 ? "32 Bits" : "16 Bits",
                                                                                                                                                                                meshInfo.indexFormat == UnityEngine.Rendering.IndexFormat.UInt32 ? EditorResources.GUIStyleMeshIndex : EditorResources.GUIStyleCenteredGreyMiniLabel);

                                            //UV0
                                            GUI.DrawTexture(new Rect(rectUV0.xMin + rectUV0.width / 2 - 6, currentRowRect.yMin + 2, 12, 12), meshInfo.hasUV0 ? EditorResources.IconYes : EditorResources.IconNo);

                                            //Vertex Attribute
                                            if (needRectVertexAttribute)
                                            {
                                                Rect textureRect = new Rect(rectVertexAttribute.xMin + rectVertexAttribute.width / 2 - 6, currentRowRect.yMin + 2, 12, 12);
                                                switch (editorSettings.solverFaceCenter)
                                                {
                                                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV0: /*Never used*/ break;
                                                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV1: GUI.DrawTexture(textureRect, meshInfo.hasUV1 ? EditorResources.IconYes : EditorResources.IconNo); break;
                                                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV2: GUI.DrawTexture(textureRect, meshInfo.hasUV2 ? EditorResources.IconYes : EditorResources.IconNo); break;
                                                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV3: GUI.DrawTexture(textureRect, meshInfo.hasUV3 ? EditorResources.IconYes : EditorResources.IconNo); break;
                                                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV4: GUI.DrawTexture(textureRect, meshInfo.hasUV4 ? EditorResources.IconYes : EditorResources.IconNo); break;
                                                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV5: GUI.DrawTexture(textureRect, meshInfo.hasUV5 ? EditorResources.IconYes : EditorResources.IconNo); break;
                                                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV6: GUI.DrawTexture(textureRect, meshInfo.hasUV6 ? EditorResources.IconYes : EditorResources.IconNo); break;
                                                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV7: GUI.DrawTexture(textureRect, meshInfo.hasUV7 ? EditorResources.IconYes : EditorResources.IconNo); break;
                                                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.Normal: GUI.DrawTexture(textureRect, meshInfo.hasNormal ? EditorResources.IconYes : EditorResources.IconNo); break;
                                                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.Tangent: GUI.DrawTexture(textureRect, meshInfo.hasTangent ? EditorResources.IconYes : EditorResources.IconNo); break;
                                                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.Color: /*Never used*/ break;
                                                }
                                            }


                                            //Vertex Color
                                            GUI.DrawTexture(new Rect(rectVertexColor.xMin + rectVertexColor.width / 2 - 6, currentRowRect.yMin + 2, 12, 12), meshInfo.hasVertexColor ? EditorResources.IconYes : EditorResources.IconNo);


                                            //Texture
                                            if (needRectTextureProperty)
                                            {
                                                Rect drawRect = new Rect(rectTextureProperty.xMin + rectTextureProperty.width / 2 - 6, currentRowRect.yMin + 2, 12, 12);

                                                switch (meshInfo.GetMaterialTexturePropertyState(editorSettings.solverTexture1PropertyName, editorSettings.solverTexture2PropertyName, editorSettings.solverTexture3PropertyName))
                                                {
                                                    case BatchObjectMeshInfo.PropertyState.Available: GUI.DrawTexture(drawRect, EditorResources.IconYes); break;
                                                    case BatchObjectMeshInfo.PropertyState.AvailableButEmpty: GUI.DrawTexture(drawRect, EditorResources.IconYesDisabled); break;
                                                    case BatchObjectMeshInfo.PropertyState.NotAvailable: GUI.DrawTexture(drawRect, EditorResources.IconNo); break;
                                                    case BatchObjectMeshInfo.PropertyState.NoMaterial: GUI.DrawTexture(drawRect, EditorResources.IconWarning); break;

                                                    case BatchObjectMeshInfo.PropertyState.Mixed: EditorGUI.LabelField(drawRect, "-", EditorResources.GUIStyleCenteredGreyMiniLabel); break;
                                                }
                                            }

                                            //Color
                                            if (needRectColorProperty)
                                            {
                                                Rect drawRect = new Rect(rectColorProperty.xMin + rectColorProperty.width / 2 - 6, currentRowRect.yMin + 2, 12, 12);

                                                switch (meshInfo.GetMaterialColorPropertyState(editorSettings.solverColor1PropertyName, editorSettings.solverColor2PropertyName, editorSettings.solverColor3PropertyName))
                                                {
                                                    case BatchObjectMeshInfo.PropertyState.Available: GUI.DrawTexture(drawRect, EditorResources.IconYes); break;
                                                    case BatchObjectMeshInfo.PropertyState.AvailableButEmpty: GUI.DrawTexture(drawRect, EditorResources.IconYesDisabled); break;
                                                    case BatchObjectMeshInfo.PropertyState.NotAvailable: GUI.DrawTexture(drawRect, EditorResources.IconNo); break;
                                                    case BatchObjectMeshInfo.PropertyState.NoMaterial: GUI.DrawTexture(drawRect, EditorResources.IconWarning); break;

                                                    case BatchObjectMeshInfo.PropertyState.Mixed: EditorGUI.LabelField(drawRect, "-", EditorResources.GUIStyleCenteredGreyMiniLabel); break;
                                                }
                                            }
                                        }


                                        //Draw line
                                        if (!(i == listBatchObjects.Count - 1 && m == currentBatchObject.meshInfo.Count - 1 && meshInfo.expanded == false))
                                            EditorGUI.DrawRect(new Rect(rectObjectData.xMax + 5, currentRowRect.yMax, rectRefresh.xMin - rectObjectData.xMax - 6, 1), Color.gray * (UnityEditor.EditorGUIUtility.isProSkin ? 0.8f : 0.2f));
                                    }
                                    else if (isRowVisible == ScrollViewItemVisibility.BelowDrawArea)
                                        break;

                                    if (meshInfo.expanded)
                                    {
                                        using (new EditorGUIHelper.GUIEnabled(false))
                                        {
                                            if (meshInfo.materialproperties == null || meshInfo.materialproperties.Length == 0)
                                            {
                                                currentRowRect = EditorGUILayout.GetControlRect();

                                                isRowVisible = IsRectVisibleInsideScrollView(toolbarRect, currentRowRect, scrollBatchObjects);
                                                if (isRowVisible == ScrollViewItemVisibility.Visible)
                                                {
                                                    visibleBatchObjectsCount += 1;


                                                    //Catch mouse click. Using 'Foldout' in this case is better than Event check that is not always detected.
                                                    EditorGUI.BeginChangeCheck();
                                                    using (new EditorGUIHelper.GUIBackgroundColor(Color.clear))
                                                    {
                                                        EditorGUI.Foldout(new Rect(rectObjectData.xMax, currentRowRect.yMin, rectRefresh.xMin - rectObjectData.xMax, currentRowRect.height), false, GUIContent.none, true);
                                                    }
                                                    if (EditorGUI.EndChangeCheck())
                                                    {
                                                        if (EditorWindow.active.selectedBatchObjectIndex == i)
                                                            EditorWindow.active.selectedBatchObjectIndex = -1;
                                                        else
                                                            EditorWindow.active.selectedBatchObjectIndex = i;
                                                    }

                                                    //Higlight selected row
                                                    if (EditorWindow.active.selectedBatchObjectIndex == i)
                                                        EditorGUI.DrawRect(new Rect(rectObjectData.xMax + 5, currentRowRect.yMin - 1, rectRefresh.xMin - rectObjectData.xMax - 6, currentRowRect.height + 1), EditorResources.groupHighLightColor);


                                                    using (new EditorGUIHelper.GUIBackgroundColor(Color.red))
                                                    {
                                                        EditorGUI.ObjectField(new Rect(rectObjectData.xMin + 50, currentRowRect.yMin, (rectObjectData.width - 54) * 0.5f, currentRowRect.height), null, typeof(Material), false);
                                                        EditorGUI.ObjectField(new Rect(rectObjectData.xMin + 50 + (rectObjectData.width - 50) * 0.5f, currentRowRect.yMin, (rectObjectData.width - 50) * 0.5f, currentRowRect.height), null, typeof(Shader), false);
                                                    }

                                                    if (needRectTextureProperty)
                                                        GUI.DrawTexture(new Rect(rectTextureProperty.xMin + rectTextureProperty.width / 2 - 6, currentRowRect.yMin + 2, 12, 12), EditorResources.IconWarning);

                                                    if (needRectColorProperty)
                                                        GUI.DrawTexture(new Rect(rectColorProperty.xMin + rectColorProperty.width / 2 - 6, currentRowRect.yMin + 2, 12, 12), EditorResources.IconWarning);


                                                    //Draw line
                                                    if (!(i == listBatchObjects.Count - 1 && m == currentBatchObject.meshInfo.Count - 1))
                                                        EditorGUI.DrawRect(new Rect(rectObjectData.xMax + 5, currentRowRect.yMax, rectRefresh.xMin - rectObjectData.xMax - 6, 1), Color.gray * (UnityEditor.EditorGUIUtility.isProSkin ? 0.8f : 0.2f));

                                                }
                                                else if (isRowVisible == ScrollViewItemVisibility.BelowDrawArea)
                                                    break;
                                            }
                                            else
                                            {
                                                for (int l = 0; l < meshInfo.materialproperties.Length; l++)
                                                {
                                                    currentRowRect = EditorGUILayout.GetControlRect();

                                                    isRowVisible = IsRectVisibleInsideScrollView(toolbarRect, currentRowRect, scrollBatchObjects);
                                                    if (isRowVisible == ScrollViewItemVisibility.Visible)
                                                    {
                                                        visibleBatchObjectsCount += 1;


                                                        //Catch mouse click. Using 'Foldout' in this case is better than Event check that is not always detected.
                                                        EditorGUI.BeginChangeCheck();
                                                        using (new EditorGUIHelper.GUIBackgroundColor(Color.clear))
                                                        {
                                                            EditorGUI.Foldout(new Rect(rectObjectData.xMax, currentRowRect.yMin, rectRefresh.xMin - rectObjectData.xMax, currentRowRect.height), false, GUIContent.none, true);
                                                        }
                                                        if (EditorGUI.EndChangeCheck())
                                                        {
                                                            if (EditorWindow.active.selectedBatchObjectIndex == i)
                                                                EditorWindow.active.selectedBatchObjectIndex = -1;
                                                            else
                                                                EditorWindow.active.selectedBatchObjectIndex = i;
                                                        }

                                                        //Higlight selected row
                                                        if (EditorWindow.active.selectedBatchObjectIndex == i)
                                                            EditorGUI.DrawRect(new Rect(rectObjectData.xMax + 5, currentRowRect.yMin - 1, rectRefresh.xMin - rectObjectData.xMax - 6, currentRowRect.height + 1), EditorResources.groupHighLightColor);


                                                        MaterialProperties currentMaterialProperty = meshInfo.materialproperties[l];

                                                        using (new EditorGUIHelper.GUIBackgroundColor((currentMaterialProperty.material == null || currentMaterialProperty.material.shader == null) ? Color.red : Color.white))
                                                        {
                                                            EditorGUI.ObjectField(new Rect(rectObjectData.xMin + 50, currentRowRect.yMin, (rectObjectData.width - 54) * 0.5f, currentRowRect.height), currentMaterialProperty.material, typeof(Material), false);

                                                            //Shader
                                                            if (currentMaterialProperty.material == null)
                                                                EditorGUI.ObjectField(new Rect(rectObjectData.xMin + 50 + (rectObjectData.width - 50) * 0.5f, currentRowRect.yMin, (rectObjectData.width - 50) * 0.5f, currentRowRect.height), null, typeof(Shader), false);
                                                            else
                                                                EditorGUI.ObjectField(new Rect(rectObjectData.xMin + 50 + (rectObjectData.width - 50) * 0.5f, currentRowRect.yMin, (rectObjectData.width - 50) * 0.5f, currentRowRect.height), currentMaterialProperty.material.shader, typeof(Shader), false);
                                                        }


                                                        //Texture
                                                        if (currentMaterialProperty.material == null)
                                                        {
                                                            if (needRectTextureProperty)
                                                                GUI.DrawTexture(new Rect(rectTextureProperty.xMin + rectTextureProperty.width / 2 - 6, currentRowRect.yMin, 14, 14), EditorResources.IconWarning);

                                                            if (needRectColorProperty)
                                                                GUI.DrawTexture(new Rect(rectColorProperty.xMin + rectColorProperty.width / 2 - 6, currentRowRect.yMin, 14, 14), EditorResources.IconWarning);
                                                        }
                                                        else
                                                        {
                                                            //Texture
                                                            if (needRectTextureProperty)
                                                            {
                                                                Rect drawRect = new Rect(rectTextureProperty.xMin + rectTextureProperty.width / 2 - 6, currentRowRect.yMin + 2, 12, 12);

                                                                if (currentMaterialProperty.HasTexture(editorSettings.solverTexture1PropertyName))
                                                                {
                                                                    if (currentMaterialProperty.IsTextureInUse(editorSettings.solverTexture1PropertyName))
                                                                        GUI.DrawTexture(drawRect, EditorResources.IconYes);
                                                                    else
                                                                        GUI.DrawTexture(drawRect, EditorResources.IconYesDisabled);
                                                                }
                                                                else if (string.IsNullOrEmpty(editorSettings.solverTexture2PropertyName) == false && currentMaterialProperty.HasTexture(editorSettings.solverTexture2PropertyName))
                                                                {
                                                                    if (currentMaterialProperty.IsTextureInUse(editorSettings.solverTexture2PropertyName))
                                                                        GUI.DrawTexture(drawRect, EditorResources.IconYes);
                                                                    else
                                                                        GUI.DrawTexture(drawRect, EditorResources.IconYesDisabled);
                                                                }
                                                                else if (string.IsNullOrEmpty(editorSettings.solverTexture2PropertyName) == false && string.IsNullOrEmpty(editorSettings.solverTexture3PropertyName) == false && currentMaterialProperty.HasTexture(editorSettings.solverTexture3PropertyName))
                                                                {
                                                                    if (currentMaterialProperty.IsTextureInUse(editorSettings.solverTexture3PropertyName))
                                                                        GUI.DrawTexture(drawRect, EditorResources.IconYes);
                                                                    else
                                                                        GUI.DrawTexture(drawRect, EditorResources.IconYesDisabled);
                                                                }
                                                                else
                                                                    GUI.DrawTexture(drawRect, EditorResources.IconNo);
                                                            }


                                                            //Color
                                                            if (needRectColorProperty)
                                                            {
                                                                Rect drawRect = new Rect(rectColorProperty.xMin + rectColorProperty.width / 2 - 6, currentRowRect.yMin + 2, 12, 12);

                                                                if (currentMaterialProperty.HasColor(editorSettings.solverColor1PropertyName))
                                                                {
                                                                    GUI.DrawTexture(drawRect, EditorResources.IconYes);
                                                                }
                                                                else if (string.IsNullOrEmpty(editorSettings.solverColor2PropertyName) == false && currentMaterialProperty.HasColor(editorSettings.solverColor2PropertyName))
                                                                {
                                                                    GUI.DrawTexture(drawRect, EditorResources.IconYes);
                                                                }
                                                                else if (string.IsNullOrEmpty(editorSettings.solverColor2PropertyName) == false && string.IsNullOrEmpty(editorSettings.solverColor3PropertyName) == false && currentMaterialProperty.HasColor(editorSettings.solverColor3PropertyName))
                                                                {
                                                                    GUI.DrawTexture(drawRect, EditorResources.IconYes);
                                                                }
                                                                else
                                                                    GUI.DrawTexture(drawRect, EditorResources.IconNo);
                                                            }
                                                        }


                                                        //Draw line
                                                        if (!(i == listBatchObjects.Count - 1 && m == currentBatchObject.meshInfo.Count - 1 && l == meshInfo.materialproperties.Length - 1))
                                                            EditorGUI.DrawRect(new Rect(rectObjectData.xMax + 5, currentRowRect.yMax, rectRefresh.xMin - rectObjectData.xMax - 6, 1), Color.gray * (UnityEditor.EditorGUIUtility.isProSkin ? 0.8f : 0.2f));

                                                    }
                                                    else if (isRowVisible == ScrollViewItemVisibility.BelowDrawArea)
                                                        break;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                EditorGUILayout.EndScrollView();
            }

            if (needRepaint)
            {
                listBatchObjects = listBatchObjects.Where(c => c.gameObject != null).ToList();
                EditorWindow.active.Repaint();
            }


            //Toolbar
            if (visibleBatchObjectsCount == 0)
            {
                EditorGUI.LabelField(toolbarRect, "Draw area is too small. Expand window size to see objects list.", EditorStyles.centeredGreyMiniLabel);
            }
            else
            {
                int offset = 7;

                GUI.Box(toolbarRect, string.Empty, EditorStyles.toolbar);


                DrawSortByButton(new Rect(rectObjectData.xMin + offset, toolbarRect.yMin, rectObjectData.width, singleLineHeight), "Target", SortBy.ObjectData);
                DrawSortByButton(new Rect(rectMeshCount.xMin + offset, toolbarRect.yMin, rectMeshCount.width, singleLineHeight), "Mesh", SortBy.MeshCount);

                if (needRectAssetFormat)
                    DrawSortByButton(new Rect(rectAssetFormat.xMin + offset, toolbarRect.yMin, rectAssetFormat.width, singleLineHeight), ".asset", SortBy.AssetFormat);

                DrawSortByButton(new Rect(rectSubmeshCount.xMin + offset, toolbarRect.yMin, rectSubmeshCount.width, singleLineHeight), "Submesh", SortBy.SubmeshCount);

                DrawSortByButton(new Rect(rectVertexAndTriangleCountOfOriginalMesh.xMin + offset, toolbarRect.yMin, rectVertexAndTriangleCountOfOriginalMesh.width, singleLineHeight), "Source", SortBy.VertexAndTriangleCountOfOriginalMesh);
                DrawSortByButton(new Rect(rectVertexCountOfLowpolyMesh.xMin + offset, toolbarRect.yMin, rectVertexCountOfLowpolyMesh.width, singleLineHeight), "Lowpoly", SortBy.VertexCountOfLowpolyMesh);
                DrawSortByButton(new Rect(rectIndexFormat.xMin + offset, toolbarRect.yMin, rectIndexFormat.width, singleLineHeight), "Index", SortBy.IndexFormat);
                DrawSortByButton(new Rect(rectUV0.xMin + offset, toolbarRect.yMin, rectUV0.width, singleLineHeight), "UV0", SortBy.UV0);
                DrawSortByButton(new Rect(rectVertexColor.xMin + offset, toolbarRect.yMin, rectVertexColor.width, singleLineHeight), "V. Color", SortBy.VertexColor);

                if (needRectTextureProperty)
                    DrawSortByButton(new Rect(rectTextureProperty.xMin + offset, toolbarRect.yMin, rectTextureProperty.width, singleLineHeight), "Texture", SortBy.TextureProperty);

                if (needRectColorProperty)
                    DrawSortByButton(new Rect(rectColorProperty.xMin + offset, toolbarRect.yMin, rectColorProperty.width, singleLineHeight), "Color", SortBy.ColorProperty);

                if (needRectVertexAttribute)
                    DrawSortByButton(new Rect(rectVertexAttribute.xMin + offset, toolbarRect.yMin, rectVertexAttribute.width, singleLineHeight), editorSettings.solverFaceCenter.ToString(), SortBy.VertexAttribute);


                if (GUI.Button(new Rect(rectRefresh.xMin + offset, toolbarRect.yMin, rectRefresh.width, singleLineHeight), " ", EditorStyles.toolbarButton))
                {
                    EditorWindow.active.CallbackContextMenu(EditorWindow.ContextMenuOption.Reload);
                }
                GUI.Label(new Rect(rectRefresh.xMin + offset, toolbarRect.yMin, rectRefresh.width, singleLineHeight), new GUIContent("↻", "Reload"), EditorResources.GUIStyleCenteredGreyMiniLabel);
            }
        }

        static int GetScrolViewHeight()
        {
            int renderObjectsCount = EditorWindow.active.listBatchObjects.Count + 1;
            for (int i = 0; i < EditorWindow.active.listBatchObjects.Count; i++)
            {
                if (EditorWindow.active.listBatchObjects[i].meshInfo != null && EditorWindow.active.listBatchObjects[i].meshInfo.Count > 0 && EditorWindow.active.listBatchObjects[i].expanded == true)
                {
                    renderObjectsCount += EditorWindow.active.listBatchObjects[i].meshInfo.Count + EditorWindow.active.listBatchObjects[i].meshInfo.Sum(c => c.expanded ? ((c.materialproperties == null || c.materialproperties.Length == 0) ? 1 : c.materialproperties.Length) : 0);
                }
            }

            return renderObjectsCount * singleLineHeight + 12;
        }
        internal static void SaveEditorData()
        {
            List<BatchObject> listBatchObjects = EditorWindow.active.listBatchObjects;


            if (listBatchObjects != null)
            {
                string batchObjectsData = $"{(int)sortBy},{(sortByAscending ? 1 : 0)}|";
                for (int i = 0; i < listBatchObjects.Count; i++)
                {
                    if (listBatchObjects[i] != null && listBatchObjects[i].gameObject != null)
                    {
                        string expanded = listBatchObjects[i].expanded ? "1" : "0";
                        if (listBatchObjects[i].meshInfo.All(c => c.expanded))
                            expanded += ".-1";
                        else
                        {
                            for (int m = 0; m < listBatchObjects[i].meshInfo.Count; m++)
                            {
                                if (listBatchObjects[i].meshInfo[m].expanded)
                                {
                                    if (listBatchObjects[i].meshInfo[m].meshFilter != null)
                                        expanded += "." + listBatchObjects[i].meshInfo[m].meshFilter.GetInstanceID();
                                    else if (listBatchObjects[i].meshInfo[m].skinnedMeshRenderer != null)
                                        expanded += "." + listBatchObjects[i].meshInfo[m].skinnedMeshRenderer.GetInstanceID();
                                }
                            }
                        }

                        batchObjectsData += expanded + ",";

                        batchObjectsData += listBatchObjects[i].gameObject.GetInstanceID() + ";";
                    }
                }

                EditorPrefs.SetString(GetEditorPreferencesPath(), batchObjectsData);
            }
        }
        internal static void LoadEditorData()
        {
            if (EditorWindow.active.listBatchObjects != null)
                EditorWindow.active.listBatchObjects.Clear();


            string editorPrefs = EditorPrefs.GetString(GetEditorPreferencesPath());
            if (string.IsNullOrEmpty(editorPrefs) == false)
            {
                string[] editorSettings = editorPrefs.Split('|');

                int iValue;
                if (editorSettings.Length == 2)
                {
                    //Sort
                    string[] data = editorSettings[0].Split(',');
                    if (data.Length == 2)
                    {
                        if (int.TryParse(data[0], out iValue))
                            sortBy = (SortBy)iValue;
                        if (int.TryParse(data[1], out iValue))
                            sortByAscending = iValue == 1;
                    }


                    //Batch objects 
                    data = editorSettings[1].Split(';');
                    for (int i = 0; i < data.Length; i++)
                    {
                        string[] batchObjectData = data[i].Split(',');

                        if (batchObjectData.Length == 2)
                        {
                            //Expanded                                    
                            bool mainExpand = batchObjectData[0][0] == '1';

                            string[] expanded = batchObjectData[0].Split('.');
                            bool allChildExpanded = false;
                            Dictionary<int, bool> childExpand = new Dictionary<int, bool>();
                            for (int c = 1; c < expanded.Length; c++)
                            {
                                if (int.TryParse(expanded[c], out iValue))
                                {
                                    if (iValue == -1)
                                    {
                                        allChildExpanded = true;
                                        break;
                                    }
                                    else
                                        childExpand.Add(iValue, true);
                                }
                            }


                            if (int.TryParse(batchObjectData[1], out iValue))
                            {
                                UnityEngine.Object uObject = EditorUtilities.InstanceIDToObject(iValue);
                                if (uObject != null)
                                {
                                    BatchObject batchObject = AddBatchObjectToArray(uObject as GameObject, mainExpand);

                                    if (batchObject != null)
                                    {
                                        if (allChildExpanded)
                                            batchObject.meshInfo.ForEach(c => c.expanded = true);
                                        else
                                        {
                                            foreach (var meshInfo in batchObject.meshInfo)
                                            {

                                                if (meshInfo.meshFilter != null && childExpand.ContainsKey(meshInfo.meshFilter.GetInstanceID()))
                                                    meshInfo.expanded = true;
                                                else if (meshInfo.skinnedMeshRenderer != null && childExpand.ContainsKey(meshInfo.skinnedMeshRenderer.GetInstanceID()))
                                                    meshInfo.expanded = true;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                SortBatchObjects();
            }
        }
        static string GetEditorPreferencesPath()
        {
            return LowpolyStyleMeshGeneratorAbout.name.RemoveWhiteSpace() + "ObjectsID_" + Application.dataPath.GetHashCode();
        }


        static void SplitControlRect(Rect controlRect, out Rect rectObjectData, out Rect rectMeshCount, out bool needRectAssetFormat, out Rect rectAssetFormat, out Rect rectSubmeshCount, out Rect rectVertexAndTrianglesCountForOriginalMesh, out Rect rectVertexCountForLowpolyMeshes, out Rect rectIndexFormat, out Rect rectUV0, out bool needRectVertexAttribute, out Rect rectVertexAttribute, out Rect rectVertexColor, out bool needRectTextureProperty, out Rect rectTextureProperty, out bool needRectColorProperty, out Rect rectColorProperty, out Rect rectRefresh)
        {
            EditorSettings editorSettings = EditorWindow.active.editorSettings;

            float controlWidth = controlRect.width - 20;    //20 is for refresh button

            rectRefresh = new Rect(controlRect);
            rectRefresh.xMin = controlRect.xMax - 20;
            rectRefresh.width = 20;


            float width;
            float xMin = controlWidth;

            rectColorProperty = new Rect(controlRect);
            needRectColorProperty = (string.IsNullOrWhiteSpace(editorSettings.solverColor1PropertyName) == false);
            if (needRectColorProperty)
            {
                width = Mathf.Min(controlWidth * 0.05f, 48);
                xMin -= width;
                {
                    rectColorProperty = new Rect(controlRect);
                    rectColorProperty.xMin = xMin;
                    rectColorProperty.width = width;
                }
            }

            rectTextureProperty = new Rect(controlRect);
            needRectTextureProperty = (string.IsNullOrWhiteSpace(editorSettings.solverTexture1PropertyName) == false);
            if (needRectTextureProperty)
            {
                width = Mathf.Min(controlWidth * 0.07f, 66);
                xMin -= width;
                {
                    rectTextureProperty = new Rect(controlRect);
                    rectTextureProperty.xMin = xMin;
                    rectTextureProperty.width = width;
                }
            }

            width = Mathf.Min(controlWidth * 0.068f, 65);
            xMin -= width;
            {
                rectVertexColor = new Rect(controlRect);
                rectVertexColor.xMin = xMin;
                rectVertexColor.width = width;
            }

            rectVertexAttribute = new Rect(controlRect);
            needRectVertexAttribute = (editorSettings.solverFaceCenter != LowpolyStyleMeshGeneratorEnum.VertexAttribute.None && editorSettings.solverFaceCenter != LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV0 && editorSettings.solverFaceCenter != LowpolyStyleMeshGeneratorEnum.VertexAttribute.Color);
            if (needRectVertexAttribute)
            {
                width = Mathf.Min(controlWidth * 0.07f, 66);
                xMin -= width;
                {
                    rectVertexAttribute.xMin = xMin;
                    rectVertexAttribute.width = width;
                }
            }

            width = Mathf.Min(controlWidth * 0.05f, 50);
            xMin -= width;
            {
                rectUV0 = new Rect(controlRect);
                rectUV0.xMin = xMin;
                rectUV0.width = width;
            }

            width = Mathf.Min(controlWidth * 0.06f, 58);
            xMin -= width;
            {
                rectIndexFormat = new Rect(controlRect);
                rectIndexFormat.xMin = xMin;
                rectIndexFormat.width = width;
            }

            width = Mathf.Min(controlWidth * 0.15f, 140);
            xMin -= width;
            {
                rectVertexCountForLowpolyMeshes = new Rect(controlRect);
                rectVertexCountForLowpolyMeshes.xMin = xMin;
                rectVertexCountForLowpolyMeshes.width = width;
            }

            width = Mathf.Min(controlWidth * 0.15f, 140);
            xMin -= width;
            {
                rectVertexAndTrianglesCountForOriginalMesh = new Rect(controlRect);
                rectVertexAndTrianglesCountForOriginalMesh.xMin = xMin;
                rectVertexAndTrianglesCountForOriginalMesh.width = width;
            }

            width = Mathf.Min(controlWidth * 0.08f, 80);
            xMin -= width;
            {
                rectSubmeshCount = new Rect(controlRect);
                rectSubmeshCount.xMin = xMin;
                rectSubmeshCount.width = width;
            }

            rectAssetFormat = new Rect(controlRect);
            needRectAssetFormat = (editorSettings.generateAssetSaveType == EditorSettings.Enum.AssetSaveType.OverwriteOriginalMesh);
            if (needRectAssetFormat)
            {
                width = Mathf.Min(controlWidth * 0.06f, 62);
                xMin -= width;
                {
                    rectAssetFormat.xMin = xMin;
                    rectAssetFormat.width = width;
                }
            }

            width = controlWidth * 0.06f;
            xMin -= width;
            {
                rectMeshCount = new Rect(controlRect);
                rectMeshCount.xMin = xMin;
                rectMeshCount.width = width;
            }

            rectObjectData = new Rect(controlRect);
            rectObjectData.width = xMin - controlRect.xMin;


            return;
        }
        static void DrawSortByButton(Rect rect, string label, SortBy sortByOnClickEvent)
        {
            using (new EditorGUIHelper.GUIColor(sortBy == sortByOnClickEvent ? Color.gray : Color.white))
            {
                if (GUI.Button(rect, label, sortBy == sortByOnClickEvent ? EditorResources.GUIStyleToolbarButtonMiddleCenterBold : EditorResources.GUIStyleToolbarButtonMiddleCenter))
                {
                    sortBy = sortByOnClickEvent;
                    sortByAscending = !sortByAscending;

                    SortBatchObjects();

                    SaveEditorData();

                    EditorWindow.active.Repaint();
                }
            }
        }
        internal static void ResetSort()
        {
            sortBy = SortBy.None;
        }
        internal static void SortBatchObjects()
        {
            string N0 = (1000).ToString("N0").Replace("1", string.Empty).Replace("0", string.Empty);


            switch (sortBy)
            {
                case SortBy.ObjectData: SortBatchObjects(r => r.gameObjectSortName, null, c => c.meshSortName, null); break;
                case SortBy.MeshCount: SortBatchObjects(r => r.meshInfo.Count, r => r.gameObjectSortName, c => c.meshSortName, null); break;
                case SortBy.AssetFormat: SortBatchObjects(r => r.isMeshAssetFormat, r => r.gameObjectSortName, c => c.isMeshAssetFormat, c => c.meshSortName); break;
                case SortBy.SubmeshCount: SortBatchObjects(r => r.submeshCount, r => r.gameObjectSortName, c => c.mesh.subMeshCount.ToString(), c => c.meshSortName); break;
                case SortBy.VertexAndTriangleCountOfOriginalMesh:
                    SortBatchObjects(r => EditorUtilities.PadNumbers(r.vertexAndTriangleCountOfOriginalMesh.Replace(N0, string.Empty)),
                                                                     r => r.gameObjectSortName,
                                                                     c => c.vertexAndTriangleCountOfOriginalMesh,
                                                                     c => c.meshSortName); break;

                case SortBy.VertexCountOfLowpolyMesh:
                    SortBatchObjects(r => EditorUtilities.PadNumbers(r.vertexCountOfLowpolyMesh.Replace(N0, string.Empty)),
                                                                     r => r.gameObjectSortName,
                                                                     c => c.vertexCountForLowpolyMesh,
                                                                     c => c.meshSortName); break;

                case SortBy.IndexFormat: SortBatchObjects(r => r.indexFormat, r => r.gameObjectSortName, c => c.mesh.indexFormat, c => c.meshSortName); break;
                case SortBy.UV0: SortBatchObjects(r => r.hasUV0, r => r.gameObjectSortName, c => c.hasUV0, c => c.meshSortName); break;
                case SortBy.VertexColor: SortBatchObjects(r => r.hasVertexColor, r => r.gameObjectSortName, c => c.hasVertexColor, c => c.meshSortName); break;

                case SortBy.TextureProperty: SortBatchObjects(r => r.GetMaterialTexturePropertyState(EditorWindow.active.editorSettings.solverTexture1PropertyName, EditorWindow.active.editorSettings.solverTexture2PropertyName, EditorWindow.active.editorSettings.solverTexture3PropertyName), r => r.gameObjectSortName, c => c.GetMaterialTexturePropertyState(EditorWindow.active.editorSettings.solverTexture1PropertyName, EditorWindow.active.editorSettings.solverTexture2PropertyName, EditorWindow.active.editorSettings.solverTexture3PropertyName), c => c.meshSortName); break;
                case SortBy.ColorProperty: SortBatchObjects(r => r.GetMaterialColorPropertyState(EditorWindow.active.editorSettings.solverColor1PropertyName, EditorWindow.active.editorSettings.solverColor2PropertyName, EditorWindow.active.editorSettings.solverColor3PropertyName), r => r.gameObjectSortName, c => c.GetMaterialColorPropertyState(EditorWindow.active.editorSettings.solverColor1PropertyName, EditorWindow.active.editorSettings.solverColor2PropertyName, EditorWindow.active.editorSettings.solverColor3PropertyName), c => c.meshSortName); break;

                case SortBy.VertexAttribute:
                    {
                        if (EditorWindow.active.editorSettings.solverFaceCenter != LowpolyStyleMeshGeneratorEnum.VertexAttribute.None &&
                            EditorWindow.active.editorSettings.solverFaceCenter != LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV0 &&
                            EditorWindow.active.editorSettings.solverFaceCenter != LowpolyStyleMeshGeneratorEnum.VertexAttribute.Color)
                        {
                            switch (EditorWindow.active.editorSettings.solverFaceCenter)
                            {
                                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV0: /*Never used*/ break;
                                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV1: SortBatchObjects(r => r.hasUV1, r => r.gameObjectSortName, c => c.hasUV1, c => c.meshSortName); break;
                                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV2: SortBatchObjects(r => r.hasUV2, r => r.gameObjectSortName, c => c.hasUV2, c => c.meshSortName); break;
                                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV3: SortBatchObjects(r => r.hasUV3, r => r.gameObjectSortName, c => c.hasUV3, c => c.meshSortName); break;
                                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV4: SortBatchObjects(r => r.hasUV4, r => r.gameObjectSortName, c => c.hasUV4, c => c.meshSortName); break;
                                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV5: SortBatchObjects(r => r.hasUV5, r => r.gameObjectSortName, c => c.hasUV5, c => c.meshSortName); break;
                                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV6: SortBatchObjects(r => r.hasUV6, r => r.gameObjectSortName, c => c.hasUV6, c => c.meshSortName); break;
                                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV7: SortBatchObjects(r => r.hasUV7, r => r.gameObjectSortName, c => c.hasUV7, c => c.meshSortName); break;
                                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.Normal: SortBatchObjects(r => r.hasNormal, r => r.gameObjectSortName, c => c.hasNormal, c => c.meshSortName); break;
                                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.Tangent: SortBatchObjects(r => r.hasTangent, r => r.gameObjectSortName, c => c.hasTangent, c => c.meshSortName); break;
                                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.Color: /*Never used*/ break;
                            }
                        }
                    }
                    break;

                default:
                    break;
            }
        }
        static void SortBatchObjects(Func<BatchObject, System.Object> orderRoot, Func<BatchObject, System.Object> orderRootThen, Func<BatchObjectMeshInfo, System.Object> orderChild, Func<BatchObjectMeshInfo, System.Object> orderChildThen)
        {
            if (EditorWindow.active.listBatchObjects == null)
                return;


            //Save batch object and reselect it after sorting;
            BatchObject selectedBatchObject = null;
            if (EditorWindow.active.selectedBatchObjectIndex > -1 && EditorWindow.active.listBatchObjects.Count > EditorWindow.active.selectedBatchObjectIndex)
                selectedBatchObject = EditorWindow.active.listBatchObjects[EditorWindow.active.selectedBatchObjectIndex];


            if (sortByAscending)
            {
                if (orderRoot != null)
                {
                    if (orderRootThen != null)
                        EditorWindow.active.listBatchObjects = EditorWindow.active.listBatchObjects.OrderBy(orderRoot).ThenBy(orderRootThen).ToList();
                    else
                        EditorWindow.active.listBatchObjects = EditorWindow.active.listBatchObjects.OrderBy(orderRoot).ToList();
                }

                if (orderChild != null)
                {
                    for (int i = 0; i < EditorWindow.active.listBatchObjects.Count; i++)
                    {
                        if (orderChildThen != null)
                            EditorWindow.active.listBatchObjects[i].meshInfo = EditorWindow.active.listBatchObjects[i].meshInfo.OrderBy(orderChild).ThenBy(orderChildThen).ToList();
                        else
                            EditorWindow.active.listBatchObjects[i].meshInfo = EditorWindow.active.listBatchObjects[i].meshInfo.OrderBy(orderChild).ToList();
                    }
                }
            }
            else
            {
                if (orderRoot != null)
                {
                    if (orderRootThen != null)
                        EditorWindow.active.listBatchObjects = EditorWindow.active.listBatchObjects.OrderByDescending(orderRoot).ThenBy(orderRootThen).ToList();
                    else
                        EditorWindow.active.listBatchObjects = EditorWindow.active.listBatchObjects.OrderByDescending(orderRoot).ToList();
                }

                if (orderChild != null)
                {
                    for (int i = 0; i < EditorWindow.active.listBatchObjects.Count; i++)
                    {
                        if (orderChildThen != null)
                            EditorWindow.active.listBatchObjects[i].meshInfo = EditorWindow.active.listBatchObjects[i].meshInfo.OrderByDescending(orderChild).ThenBy(orderChildThen).ToList();
                        else
                            EditorWindow.active.listBatchObjects[i].meshInfo = EditorWindow.active.listBatchObjects[i].meshInfo.OrderByDescending(orderChild).ToList();
                    }
                }
            }


            //Restore selection
            if (selectedBatchObject != null)
            {
                EditorWindow.active.selectedBatchObjectIndex = EditorWindow.active.listBatchObjects.IndexOf(selectedBatchObject);
            }
        }

        static ScrollViewItemVisibility IsRectVisibleInsideScrollView(Rect topMostRect, Rect localRect, Vector2 scrollPosition)
        {
            float windowSpacePositionY = topMostRect.y + localRect.y - scrollPosition.y;

            if (windowSpacePositionY < topMostRect.yMax - 40)
                return ScrollViewItemVisibility.AboveDrawArea;
            else if (windowSpacePositionY > EditorWindow.active.position.height - 110)
                return ScrollViewItemVisibility.BelowDrawArea;
            else
                return ScrollViewItemVisibility.Visible;
        }

        internal static void AddDrops(UnityEngine.Object[] drops, bool checkDirectory)
        {
            if (drops == null || drops.Length == 0)
                return;


            for (int i = 0; i < drops.Length; i++)
            {
                if (drops[i] == null)
                    continue;

                UnityEditor.EditorUtility.DisplayProgressBar("Hold On", drops[i].name, (float)i / drops.Length);


                string dropPath = AssetDatabase.GetAssetPath(drops[i]);
                string dropExtension = Path.GetExtension(dropPath).ToLowerInvariant();

                GameObject gameObject = drops[i] as GameObject;

                if (gameObject != null)
                {
                    AddBatchObjectToArray(gameObject, false);
                }
                else if (string.IsNullOrEmpty(dropExtension))
                {
                    //May be it is a folder ?
                    if (checkDirectory)
                        AddBatchObjectToArray(dropPath, false);
                }
            }


            SortBatchObjects();
            SaveEditorData();

            UnityEditor.EditorUtility.ClearProgressBar();
            EditorWindow.active.Repaint();
        }
        internal static BatchObject AddBatchObjectToArray(GameObject gameObject, bool expand)
        {
            if (EditorWindow.active == null)
                return null;


            if (EditorWindow.active.listBatchObjects == null)
                EditorWindow.active.listBatchObjects = new List<BatchObject>();

            if (EditorWindow.active.editorSettings == null)
                EditorWindow.active.editorSettings = new EditorSettings();



            if (gameObject != null && EditorWindow.active.listBatchObjects.Any(x => x.gameObject.GetInstanceID() == gameObject.GetInstanceID()) == false)
            {
                string assetName = EditorWindow.active.editorSettings.GetSaveAssetName(gameObject, true);
                string assetSaveDirectory = EditorWindow.active.editorSettings.GetAssetSaveDirectory(gameObject, true, true);
                string savePath = Path.Combine(assetSaveDirectory, assetName);


                if (string.IsNullOrEmpty(savePath) == true ||
                    EditorWindow.active.listBatchObjects.Any(x => x.savePath == savePath) == false)
                {
                    BatchObject batchObject = new BatchObject(gameObject, expand);

                    if (batchObject.meshInfo.Count > 0)
                    {
                        EditorWindow.active.listBatchObjects.Add(batchObject);

                        SceneView.RepaintAll();
                        return batchObject;
                    }
                }
            }

            return null;
        }
        internal static void AddBatchObjectToArray(string folderPath, bool sort)
        {
            string[] guids = AssetDatabase.FindAssets("t:Prefab t:Model", string.IsNullOrEmpty(folderPath) ? null : new string[] { folderPath });
            for (int i = 0; i < guids.Length; i++)
            {
                string path = AssetDatabase.GUIDToAssetPath(guids[i]);

                UnityEditor.EditorUtility.DisplayProgressBar("Hold On", path, (float)i / guids.Length);

                if (string.IsNullOrEmpty(path) == false && EditorUtilities.IsPathProjectRelative(path))
                    AddBatchObjectToArray((GameObject)AssetDatabase.LoadAssetAtPath(path, typeof(GameObject)), false);
            }

            if (sort)
                SortBatchObjects();

            SaveEditorData();

            UnityEditor.EditorUtility.ClearProgressBar();
        }
        internal static void RemoveSelectedBatchObject(int index, bool selectNext)
        {
            if (index >= 0 && index < EditorWindow.active.listBatchObjects.Count)
            {
                if (EditorWindow.active.problematicBatchObject != null && EditorWindow.active.problematicBatchObject == EditorWindow.active.listBatchObjects[index])
                    EditorWindow.active.problematicBatchObject = null;

                EditorWindow.active.listBatchObjects.Remove(EditorWindow.active.listBatchObjects[index]);

                if (selectNext)
                {
                    if (EditorWindow.active.listBatchObjects.Count > 0)
                        EditorWindow.active.selectedBatchObjectIndex = Mathf.Clamp(EditorWindow.active.selectedBatchObjectIndex, 0, EditorWindow.active.listBatchObjects.Count - 1);
                }
                else
                {
                    if (index == EditorWindow.active.selectedBatchObjectIndex)
                        EditorWindow.active.selectedBatchObjectIndex = -1;
                    else if (index <= EditorWindow.active.selectedBatchObjectIndex)
                        EditorWindow.active.selectedBatchObjectIndex -= 1;
                }

                if (EditorWindow.active.listBatchObjects.Count == 0)
                    EditorWindow.active.selectedBatchObjectIndex -= 1;


                EditorWindow.active.Repaint();
                SceneView.RepaintAll();
            }
        }
        internal static void RemoveAllBatchObjectsExceptSelected(int index)
        {
            BatchObject batchObject = EditorWindow.active.listBatchObjects[index];

            EditorWindow.active.listBatchObjects.Clear();
            EditorWindow.active.listBatchObjects.Add(batchObject);

            if (EditorWindow.active.selectedBatchObjectIndex == index)
                EditorWindow.active.selectedBatchObjectIndex = 0;


            EditorWindow.active.Repaint();
            SceneView.RepaintAll();
        }
        internal static void RemoveAllElementsAbove(int index)
        {
            if (index < 0 || index >= EditorWindow.active.listBatchObjects.Count)
                return;

            EditorWindow.active.listBatchObjects.RemoveRange(0, index);

            EditorWindow.active.Repaint();
            SceneView.RepaintAll();
        }
        internal static void RemoveAllElementsBelow(int index)
        {
            if (index < 0)
            {
                // If index is 0 or less, remove nothing
                return;
            }
            else if (index >= EditorWindow.active.listBatchObjects.Count)
            {
                // If index is out of range, remove all
                EditorWindow.active.listBatchObjects.Clear();
                return;
            }

            EditorWindow.active.listBatchObjects.RemoveRange(index + 1, EditorWindow.active.listBatchObjects.Count - (index + 1));

            EditorWindow.active.Repaint();
            SceneView.RepaintAll();
        }
        internal static void CatchDragAndDrop()
        {
            Rect drop_area = new Rect(0, 0, EditorWindow.active.position.width, EditorWindow.active.position.height);

            Event evt = Event.current;
            switch (evt.type)
            {
                case EventType.DragUpdated:
                case EventType.DragPerform:
                    if (!drop_area.Contains(evt.mousePosition))
                        return;

                    DragAndDrop.visualMode = DragAndDropVisualMode.Copy;

                    if (evt.type == EventType.DragPerform)
                    {
                        DragAndDrop.AcceptDrag();

                        AddDrops(DragAndDrop.objectReferences, true);

                        SaveEditorData();
                        EditorWindow.active.editorSettings.SaveEditorData();
                        UnityEditor.EditorUtility.ClearProgressBar();
                        EditorWindow.active.Repaint();
                    }
                    break;
            }
        }
        internal static void CatchKeyboard()
        {
            if (Event.current.type == EventType.KeyDown)
            {
                if (Event.current.keyCode == KeyCode.Home && Event.current.control)
                {
                    scrollBatchObjects.y = 0;
                    EditorWindow.active.Repaint();
                }

                if (Event.current.keyCode == KeyCode.End && Event.current.control)
                {
                    scrollBatchObjects.y = float.MaxValue;
                    EditorWindow.active.Repaint();
                }
            }
        }
    }
}