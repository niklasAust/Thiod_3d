// Lowpoly Style Mesh Generator <https://u3d.as/2z0X>
// Copyright (c) Amazing Assets <https://amazingassets.world>

using System.Linq;
using System.Collections.Generic;

using UnityEngine;
using UnityEditor;


namespace AmazingAssets.LowpolyStyleMeshGenerator.Editor
{
    internal class EditorSettings : EditorSettingsBase
    {
        new public static class Enum
        {
            public enum MeshCombineType { Nothing, Submeshes, OneMeshWithSubmeshes, Everything }
            public enum MeshFormat { UnityAsset, UnityMesh }
            public enum AssetSaveType { Prefab, MeshOnly, OverwriteOriginalMesh }
            public enum MaterialType { UseOriginal, CreateNew, CreateDuplicate }
        }



        #region Solver
        public LowpolyStyleMeshGeneratorEnum.Solver solverType = LowpolyStyleMeshGeneratorEnum.Solver.AverageColor;

        public string solverTexture1PropertyName = string.Empty;
        public string solverTexture2PropertyName = string.Empty;
        public string solverTexture3PropertyName = string.Empty;
        public string solverColor1PropertyName = string.Empty;
        public string solverColor2PropertyName = string.Empty;
        public string solverColor3PropertyName = string.Empty;
        public LowpolyStyleMeshGeneratorEnum.SourceVertexColor solverVertexColor = LowpolyStyleMeshGeneratorEnum.SourceVertexColor.None;

        public LowpolyStyleMeshGeneratorEnum.LowpolyUV solverLowpolyUV0 = LowpolyStyleMeshGeneratorEnum.LowpolyUV.None;
        public LowpolyStyleMeshGeneratorEnum.VertexAttribute solverFaceCenter = LowpolyStyleMeshGeneratorEnum.VertexAttribute.None;

        public LowpolyStyleMeshGeneratorEnum.AlphaType solverAlphaValue = LowpolyStyleMeshGeneratorEnum.AlphaType.DefaultValue;


        public Enum.AssetSaveType generateAssetSaveType = Enum.AssetSaveType.Prefab;
        public Enum.MeshCombineType generateMeshCombineType = Enum.MeshCombineType.Nothing;
        public bool generateReplaceMeshColliders = false;
        public bool generateLightmapUVs = false;
        public Enum.MaterialType generateMaterialType = Enum.MaterialType.CreateNew;
        public Shader generateDefaultShader = Shader.Find(LowpolyStyleMeshGeneratorConstants.shaderPreview);

        public Enum.MeshFormat saveMeshFormat = Enum.MeshFormat.UnityAsset;
        public ModelImporterMeshCompression saveMeshCompression = ModelImporterMeshCompression.Low;
        public bool saveUseDefaultFlagsForVertexAttribute = true;
        public VertexAttributePopup.AttributeFlags saveVertexAttributeFlags = (VertexAttributePopup.AttributeFlags)~0;

        public bool saveUseStaticEditorFlags = false;
        public StaticEditorFlags saveStaticEditorFlags = 0;
        public bool saveUseStaticEditorFlagsForHierarchy = true;
        public bool saveUseTag = false;
        public string saveTag = "Untagged";
        public bool saveUseTagForHierarchy = true;
        public bool saveUseLayer = false;
        public int saveLayer;
        public bool saveUseLayerForHierarchy = true;
        #endregion


        #region Tabs
        public bool drawTabSolver = true;
        public bool drawTabGenerate = true;
        public bool drawTabSave = true;
        #endregion


        public EditorSettings()
            : base()
        {

        }
        public override string GetEditorPreferencesName()
        {
            return LowpolyStyleMeshGeneratorAbout.name.RemoveWhiteSpace() + "EditorSettings";
        }

        protected override void DrawCustomSettings(Rect collumnRect1, Rect collumnRect2, Rect collumnRect3, Rect collumnRect4)
        {
            List<BatchObject> listBatchObjects = EditorWindow.active.listBatchObjects;


            using (new EditorGUIHelper.EditorGUILayoutBeginVertical(EditorStyles.helpBox))
            {
                drawTabSolver = EditorGUILayout.Foldout(drawTabSolver, "Solver", false, EditorResources.GUIStyleFoldoutBold);

                if (drawTabSolver)
                {
                    using (new EditorGUIHelper.EditorGUILayoutBeginVertical(EditorStyles.helpBox))
                    {
                        Rect rect = AddRow(ref collumnRect1, ref collumnRect2, ref collumnRect3, ref collumnRect4);

                        solverType = (LowpolyStyleMeshGeneratorEnum.Solver)EditorGUI.EnumPopup(new Rect(collumnRect1.xMin, collumnRect1.yMin + 2, 120, collumnRect1.height), solverType, EditorStyles.toolbarPopup);


                        EditorGUI.LabelField(collumnRect2, "Texture #1");
                        if (GUI.Button(new Rect(collumnRect2.xMin + 77, collumnRect2.yMin, collumnRect2.width - 77, collumnRect2.height), string.IsNullOrEmpty(solverTexture1PropertyName) ? "None" : solverTexture1PropertyName, EditorStyles.miniPullDown))
                        {
                            List<GUIContent> properties = CollectMaterialsProperties(listBatchObjects, false);

                            MenuSelectionDropdown menuSelection = new MenuSelectionDropdown("Texture Property Name", properties, solverTexture1PropertyName, CallbackTexture1Property);
                            menuSelection.Show(new Rect(collumnRect2.xMin + 75, collumnRect2.yMin, collumnRect2.width - 75, collumnRect2.height));
                        }

                        if (string.IsNullOrWhiteSpace(solverTexture1PropertyName) == false)
                        {
                            EditorGUI.LabelField(collumnRect3, "Texture #2");
                            using (new EditorGUIHelper.GUIBackgroundColor(solverTexture1PropertyName == solverTexture2PropertyName ? Color.yellow : Color.white))
                            {
                                if (GUI.Button(new Rect(collumnRect3.xMin + 77, collumnRect3.yMin, collumnRect3.width - 77, collumnRect3.height), string.IsNullOrEmpty(solverTexture2PropertyName) ? "None" : solverTexture2PropertyName, EditorStyles.miniPullDown))
                                {
                                    List<GUIContent> properties = CollectMaterialsProperties(listBatchObjects, false);

                                    MenuSelectionDropdown menuSelection = new MenuSelectionDropdown("Texture Property Name", properties, solverTexture2PropertyName, CallbackTexture2Property);
                                    menuSelection.Show(new Rect(collumnRect3.xMin + 75, collumnRect3.yMin, collumnRect3.width - 75, collumnRect3.height));
                                }
                            }

                            if (string.IsNullOrWhiteSpace(solverTexture2PropertyName) == false && solverTexture1PropertyName != solverTexture2PropertyName)
                            {
                                using (new EditorGUIHelper.GUIBackgroundColor(solverTexture1PropertyName == solverTexture3PropertyName || solverTexture2PropertyName == solverTexture3PropertyName ? Color.yellow : Color.white))
                                {
                                    EditorGUI.LabelField(collumnRect4, "Texture #3");
                                    if (GUI.Button(new Rect(collumnRect4.xMin + 77, collumnRect4.yMin, collumnRect4.width - 77, collumnRect4.height), string.IsNullOrEmpty(solverTexture3PropertyName) ? "None" : solverTexture3PropertyName, EditorStyles.miniPullDown))
                                    {
                                        List<GUIContent> properties = CollectMaterialsProperties(listBatchObjects, false);

                                        MenuSelectionDropdown menuSelection = new MenuSelectionDropdown("Texture Property Name", properties, solverTexture3PropertyName, CallbackTexture3Property);
                                        menuSelection.Show(new Rect(collumnRect4.xMin + 100, collumnRect4.yMin, collumnRect4.width - 75, collumnRect4.height));
                                    }
                                }
                            }
                        }


                        rect = AddRow(ref collumnRect1, ref collumnRect2, ref collumnRect3, ref collumnRect4);

                        EditorGUI.LabelField(collumnRect2, "Color #1");
                        if (GUI.Button(new Rect(collumnRect2.xMin + 77, collumnRect2.yMin, collumnRect2.width - 77, collumnRect2.height), string.IsNullOrEmpty(solverColor1PropertyName) ? "None" : solverColor1PropertyName, EditorStyles.miniPullDown))
                        {
                            List<GUIContent> properties = CollectMaterialsProperties(listBatchObjects, true);

                            MenuSelectionDropdown menuSelection = new MenuSelectionDropdown("Color Property Name", properties, solverColor1PropertyName, CallbackColor1Property);
                            menuSelection.Show(new Rect(collumnRect2.xMin + 75, collumnRect2.yMin, collumnRect2.width - 75, collumnRect2.height));
                        }

                        if (string.IsNullOrWhiteSpace(solverColor1PropertyName) == false)
                        {
                            EditorGUI.LabelField(collumnRect3, "Color #2");
                            using (new EditorGUIHelper.GUIBackgroundColor(solverColor1PropertyName == solverColor2PropertyName ? Color.yellow : Color.white))
                            {
                                if (GUI.Button(new Rect(collumnRect3.xMin + 77, collumnRect3.yMin, collumnRect3.width - 77, collumnRect3.height), string.IsNullOrEmpty(solverColor2PropertyName) ? "None" : solverColor2PropertyName, EditorStyles.miniPullDown))
                                {
                                    List<GUIContent> properties = CollectMaterialsProperties(listBatchObjects, true);

                                    MenuSelectionDropdown menuSelection = new MenuSelectionDropdown("Color Property Name", properties, solverColor2PropertyName, CallbackColor2Property);
                                    menuSelection.Show(new Rect(collumnRect3.xMin + 75, collumnRect3.yMin, collumnRect3.width - 75, collumnRect3.height));
                                }
                            }

                            if (string.IsNullOrWhiteSpace(solverColor2PropertyName) == false && solverColor1PropertyName != solverColor2PropertyName)
                            {
                                EditorGUI.LabelField(collumnRect4, "Color #3");
                                using (new EditorGUIHelper.GUIBackgroundColor(solverColor1PropertyName == solverColor3PropertyName || solverColor2PropertyName == solverColor3PropertyName ? Color.yellow : Color.white))
                                {
                                    if (GUI.Button(new Rect(collumnRect4.xMin + 77, collumnRect4.yMin, collumnRect4.width - 77, collumnRect4.height), string.IsNullOrEmpty(solverColor3PropertyName) ? "None" : solverColor3PropertyName, EditorStyles.miniPullDown))
                                    {
                                        List<GUIContent> properties = CollectMaterialsProperties(listBatchObjects, true);

                                        MenuSelectionDropdown menuSelection = new MenuSelectionDropdown("Color Property Name", properties, solverColor3PropertyName, CallbackColor3Property);
                                        menuSelection.Show(new Rect(collumnRect4.xMin + 100, collumnRect4.yMin, collumnRect4.width - 75, collumnRect4.height));
                                    }
                                }
                            }
                        }

                        rect = AddRow(ref collumnRect1, ref collumnRect2, ref collumnRect3, ref collumnRect4);

                        if (solverType == LowpolyStyleMeshGeneratorEnum.Solver.CenterColor || solverType == LowpolyStyleMeshGeneratorEnum.Solver.FirstVertexColor)
                        {
                            using (new EditorGUIHelper.EditorGUIUtilityLabelWidth(75))
                            {
                                EditorGUI.LabelField(collumnRect2, new GUIContent("UV0", "Save lowpoly UV0?"));
                                using (new EditorGUIHelper.GUIBackgroundColor((solverLowpolyUV0 != LowpolyStyleMeshGeneratorEnum.LowpolyUV.None && solverFaceCenter == LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV0) ? Color.red : Color.white))
                                {
                                    if (GUI.Button(new Rect(collumnRect2.xMin + 77, collumnRect2.yMin, collumnRect2.width - 77, collumnRect2.height), solverLowpolyUV0.ToString(), EditorStyles.miniPullDown))
                                    {
                                        GenericMenu menu = new GenericMenu();

                                        menu.AddItem(new GUIContent("None"), solverLowpolyUV0 == LowpolyStyleMeshGeneratorEnum.LowpolyUV.None, CallbackLowpolyUV0, LowpolyStyleMeshGeneratorEnum.LowpolyUV.None);
                                        menu.AddSeparator(string.Empty);
                                        menu.AddItem(new GUIContent("XY"), solverLowpolyUV0 == LowpolyStyleMeshGeneratorEnum.LowpolyUV.XY, CallbackLowpolyUV0, LowpolyStyleMeshGeneratorEnum.LowpolyUV.XY);
                                        menu.AddItem(new GUIContent("ZW"), solverLowpolyUV0 == LowpolyStyleMeshGeneratorEnum.LowpolyUV.ZW, CallbackLowpolyUV0, LowpolyStyleMeshGeneratorEnum.LowpolyUV.ZW);

                                        menu.DropDown(new Rect(collumnRect2.xMin + 75, collumnRect2.yMin, collumnRect2.width - 75, collumnRect2.height));
                                    }
                                }
                            }
                        }
                        else
                        {
                            using (new EditorGUIHelper.GUIEnabled(false))
                            {
                                using (new EditorGUIHelper.EditorGUIUtilityLabelWidth(75))
                                {
                                    EditorGUI.LabelField(collumnRect2, "UV0", "None", EditorStyles.miniPullDown);
                                }
                            }
                        }

                        EditorGUI.LabelField(collumnRect3, "Face Center");
                        using (new EditorGUIHelper.GUIBackgroundColor((solverLowpolyUV0 != LowpolyStyleMeshGeneratorEnum.LowpolyUV.None && solverFaceCenter == LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV0) ? Color.red : Color.white))
                        {
                            if (GUI.Button(new Rect(collumnRect3.xMin + 77, collumnRect3.yMin, collumnRect3.width - 77, collumnRect3.height), solverFaceCenter.ToString(), EditorStyles.miniPullDown))
                            {
                                GenericMenu menu = new GenericMenu();

                                menu.AddItem(new GUIContent("None"), solverFaceCenter == LowpolyStyleMeshGeneratorEnum.VertexAttribute.None, CallbackLowpolyFaceCenter, LowpolyStyleMeshGeneratorEnum.VertexAttribute.None);
                                menu.AddSeparator(string.Empty);
                                menu.AddItem(new GUIContent("UV0"), solverFaceCenter == LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV0, CallbackLowpolyFaceCenter, LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV0);
                                menu.AddItem(new GUIContent("UV1"), solverFaceCenter == LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV1, CallbackLowpolyFaceCenter, LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV1);
                                menu.AddItem(new GUIContent("UV2"), solverFaceCenter == LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV2, CallbackLowpolyFaceCenter, LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV2);
                                menu.AddItem(new GUIContent("UV3"), solverFaceCenter == LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV3, CallbackLowpolyFaceCenter, LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV3);
                                menu.AddItem(new GUIContent("UV4"), solverFaceCenter == LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV4, CallbackLowpolyFaceCenter, LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV4);
                                menu.AddItem(new GUIContent("UV5"), solverFaceCenter == LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV5, CallbackLowpolyFaceCenter, LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV5);
                                menu.AddItem(new GUIContent("UV6"), solverFaceCenter == LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV6, CallbackLowpolyFaceCenter, LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV6);
                                menu.AddItem(new GUIContent("UV7"), solverFaceCenter == LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV7, CallbackLowpolyFaceCenter, LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV7);
                                menu.AddSeparator(string.Empty);
                                menu.AddItem(new GUIContent("Normal"), solverFaceCenter == LowpolyStyleMeshGeneratorEnum.VertexAttribute.Normal, CallbackLowpolyFaceCenter, LowpolyStyleMeshGeneratorEnum.VertexAttribute.Normal);
                                menu.AddItem(new GUIContent("Tangent"), solverFaceCenter == LowpolyStyleMeshGeneratorEnum.VertexAttribute.Tangent, CallbackLowpolyFaceCenter, LowpolyStyleMeshGeneratorEnum.VertexAttribute.Tangent);
                                menu.AddDisabledItem(new GUIContent("Color"));

                                menu.DropDown(new Rect(collumnRect3.xMin + 75, collumnRect3.yMin, collumnRect3.width - 75, collumnRect3.height));
                            }
                        }


                        rect = AddRow(ref collumnRect1, ref collumnRect2, ref collumnRect3, ref collumnRect4);

                        using (new EditorGUIHelper.EditorGUIUtilityLabelWidth(75))
                        {
                            solverVertexColor = (LowpolyStyleMeshGeneratorEnum.SourceVertexColor)EditorGUI.EnumPopup(collumnRect2, new GUIContent("Vertex Color", "Use source mesh vertex color?"), solverVertexColor);
                            solverAlphaValue = (LowpolyStyleMeshGeneratorEnum.AlphaType)EditorGUI.EnumPopup(collumnRect3, "Save Alpha", solverAlphaValue);
                        }
                    }
                }
            }


            DrawAdditionalSettings(collumnRect1, collumnRect2, collumnRect3, collumnRect4);
        }
        void DrawAdditionalSettings(Rect collumnRect1, Rect collumnRect2, Rect collumnRect3, Rect collumnRect4)
        {
            GUILayout.Space(5);
            using (new EditorGUIHelper.EditorGUILayoutBeginVertical(EditorStyles.helpBox))
            {
                drawTabGenerate = EditorGUILayout.Foldout(drawTabGenerate, "Generate", false, EditorResources.GUIStyleFoldoutBold);

                if (drawTabGenerate)
                {
                    using (new EditorGUIHelper.EditorGUILayoutBeginVertical(EditorStyles.helpBox))
                    {
                        Rect rect = AddRow(ref collumnRect1, ref collumnRect2, ref collumnRect3, ref collumnRect4);


                        using (new EditorGUIHelper.GUIBackgroundColor(generateAssetSaveType == Enum.AssetSaveType.OverwriteOriginalMesh ? Color.yellow : Color.white))
                        {
                            generateAssetSaveType = (Enum.AssetSaveType)EditorGUI.EnumPopup(new Rect(collumnRect1.xMin, collumnRect1.yMin, 120, collumnRect1.height), generateAssetSaveType, EditorStyles.toolbarPopup);
                        }

                        if (generateAssetSaveType == Enum.AssetSaveType.OverwriteOriginalMesh)
                        {
                            GUI.DrawTexture(new Rect(collumnRect2.xMin, collumnRect2.yMin, 20, 20), EditorResources.IconError);

                            EditorGUI.LabelField(new Rect(collumnRect2.xMin + 20, collumnRect2.yMin, (collumnRect4.xMax - collumnRect2.xMin), collumnRect2.height), "Only mesh files in .asset format will be overwritten and it cannot be Undo.");
                        }

                        if (generateAssetSaveType == Enum.AssetSaveType.Prefab || generateAssetSaveType == Enum.AssetSaveType.MeshOnly)
                        {
                            using (new EditorGUIHelper.EditorGUIUtilityLabelWidth(75))
                            {
                                generateMeshCombineType = (Enum.MeshCombineType)EditorGUI.EnumPopup(collumnRect2, "Combine", generateMeshCombineType);
                            }

                            if (generateMeshCombineType == Enum.MeshCombineType.OneMeshWithSubmeshes || generateMeshCombineType == Enum.MeshCombineType.Everything)
                                generateLightmapUVs = EditorGUIHelper.ToggleAsButton(collumnRect3, generateLightmapUVs, "Generate Lightmap UVs");
                        }

                        if (generateAssetSaveType == Enum.AssetSaveType.Prefab)
                        {
                            if (generateMeshCombineType == Enum.MeshCombineType.OneMeshWithSubmeshes || generateMeshCombineType == Enum.MeshCombineType.Everything)
                                generateReplaceMeshColliders = EditorGUIHelper.ToggleAsButton(collumnRect4, generateReplaceMeshColliders, "Add Mesh Collider");
                            else
                                generateReplaceMeshColliders = EditorGUIHelper.ToggleAsButton(collumnRect4, generateReplaceMeshColliders, "Replace Mesh Colliders");


                            rect = AddRow(ref collumnRect1, ref collumnRect2, ref collumnRect3, ref collumnRect4);

                            using (new EditorGUIHelper.EditorGUIUtilityLabelWidth(75))
                            {
                                generateMaterialType = (Enum.MaterialType)EditorGUI.EnumPopup(collumnRect2, "Material", generateMaterialType);
                            }


                            if (generateMaterialType == Enum.MaterialType.CreateNew || generateMeshCombineType == Enum.MeshCombineType.Everything)
                            {
                                using (new EditorGUIHelper.GUIBackgroundColor(generateDefaultShader == null ? Color.red : Color.white))
                                {
                                    generateDefaultShader = (Shader)EditorGUI.ObjectField(new Rect(collumnRect3.xMin, collumnRect3.yMin, collumnRect3.width - 30, collumnRect3.height), generateDefaultShader, typeof(Shader), true);
                                }

                                if (GUI.Button(new Rect(collumnRect3.xMin + (collumnRect3.width - 25), collumnRect3.yMin, 25, collumnRect3.height), "..."))
                                {
                                    ShaderSelectionDropdown shaderSelection = new ShaderSelectionDropdown(CallbackDefaultShaderSelection, generateDefaultShader == null ? string.Empty : generateDefaultShader.name);
                                    shaderSelection.Show(collumnRect3);
                                }
                            }
                        }
                    }
                }
            }

            GUILayout.Space(5);
            using (new EditorGUIHelper.EditorGUILayoutBeginVertical(EditorStyles.helpBox))
            {
                drawTabSave = EditorGUILayout.Foldout(drawTabSave, "Save", false, EditorResources.GUIStyleFoldoutBold);

                if (drawTabSave)
                {
                    using (new EditorGUIHelper.EditorGUILayoutBeginVertical(EditorStyles.helpBox))
                    {
                        Rect rect = AddRow(ref collumnRect1, ref collumnRect2, ref collumnRect3, ref collumnRect4);

                        EditorGUI.LabelField(collumnRect1, "Mesh");
                        using (new EditorGUIHelper.EditorGUIUtilityLabelWidth(75))
                        {
                            saveMeshFormat = (Enum.MeshFormat)EditorGUI.EnumPopup(collumnRect2, "Format", saveMeshFormat);
                        }

                        saveMeshCompression = (ModelImporterMeshCompression)EditorGUI.EnumPopup(collumnRect3, string.Empty, saveMeshCompression, GUIStyle.none);
                        EditorGUI.LabelField(collumnRect3, "Compression:  " + saveMeshCompression.ToString(), EditorStyles.popup);


                        EditorGUI.LabelField(collumnRect4, "Attributes");
                        {
                            VertexAttributePopup.AttributeFlags usedAttributes = GetRequiredVertexAttributes();

                            string buttonName = saveUseDefaultFlagsForVertexAttribute ? "Default" : VertexAttributePopup.GetLabelName(saveVertexAttributeFlags, usedAttributes);

                            if (GUI.Button(new Rect(collumnRect4.xMin + 77, collumnRect4.yMin, collumnRect4.width - 77, collumnRect4.height), buttonName, EditorStyles.popup))
                            {
                                PopupWindow.Show(new Rect(collumnRect4.xMin + 77, collumnRect4.yMin, collumnRect4.width - 77, collumnRect4.height), new VertexAttributePopup(usedAttributes));
                            }
                        }


                        if (generateAssetSaveType == Enum.AssetSaveType.Prefab)
                        {
                            rect = AddRow(ref collumnRect1, ref collumnRect2, ref collumnRect3, ref collumnRect4);

                            EditorGUI.LabelField(collumnRect1, "Prefab Flags");
                            using (new EditorGUIHelper.EditorGUIUtilityLabelWidth(75))
                            {
                                saveUseStaticEditorFlags = EditorGUI.ToggleLeft(new Rect(collumnRect2.xMin, collumnRect2.yMin, 55, collumnRect2.height), "Static", saveUseStaticEditorFlags);
                                using (new EditorGUIHelper.GUIEnabled(saveUseStaticEditorFlags))
                                {
                                    saveStaticEditorFlags = (StaticEditorFlags)EditorGUI.EnumFlagsField(new Rect(collumnRect2.xMin, collumnRect2.yMin, collumnRect2.width - (saveUseStaticEditorFlags ? 30 : 0), collumnRect2.height), " ", saveStaticEditorFlags);

                                    if (saveUseStaticEditorFlags)
                                    {
                                        using (new EditorGUIHelper.GUIBackgroundColor(EditorGUIHelper.GetToggleButtonColor(saveUseStaticEditorFlagsForHierarchy)))
                                        {
                                            saveUseStaticEditorFlagsForHierarchy = GUI.Toggle(new Rect(collumnRect2.xMin + (collumnRect2.width - 25), collumnRect2.yMin, 25, collumnRect2.height), saveUseStaticEditorFlagsForHierarchy, EditorResources.GUIContentPrefabFlags, "Button");
                                        }
                                    }
                                }


                                saveUseTag = EditorGUI.ToggleLeft(new Rect(collumnRect3.xMin, collumnRect3.yMin, 60, collumnRect3.height), "Tag", saveUseTag);
                                using (new EditorGUIHelper.GUIEnabled(saveUseTag))
                                {
                                    saveTag = EditorGUI.TagField(new Rect(collumnRect3.xMin, collumnRect3.yMin, collumnRect3.width - (saveUseTag ? 30 : 0), collumnRect3.height), " ", saveTag);

                                    if (saveUseTag)
                                    {
                                        using (new EditorGUIHelper.GUIBackgroundColor(EditorGUIHelper.GetToggleButtonColor(saveUseTagForHierarchy)))
                                        {
                                            saveUseTagForHierarchy = GUI.Toggle(new Rect(collumnRect3.xMin + (collumnRect3.width - 25), collumnRect3.yMin, 25, collumnRect3.height), saveUseTagForHierarchy, EditorResources.GUIContentPrefabFlags, "Button");
                                        }
                                    }
                                }


                                saveUseLayer = EditorGUI.ToggleLeft(new Rect(collumnRect4.xMin, collumnRect4.yMin, 60, collumnRect4.height), "Layer", saveUseLayer);
                                using (new EditorGUIHelper.GUIEnabled(saveUseLayer))
                                {
                                    saveLayer = EditorGUI.LayerField(new Rect(collumnRect4.xMin, collumnRect4.yMin, collumnRect4.width - (saveUseLayer ? 30 : 0), collumnRect4.height), " ", saveLayer);

                                    if (saveUseLayer)
                                    {
                                        using (new EditorGUIHelper.GUIBackgroundColor(EditorGUIHelper.GetToggleButtonColor(saveUseLayerForHierarchy)))
                                        {
                                            saveUseLayerForHierarchy = GUI.Toggle(new Rect(collumnRect4.xMin + (collumnRect4.width - 25), collumnRect4.yMin, 25, collumnRect4.height), saveUseLayerForHierarchy, EditorResources.GUIContentPrefabFlags, "Button");
                                        }
                                    }
                                }
                            }
                        }


                        if (generateAssetSaveType == Enum.AssetSaveType.Prefab || generateAssetSaveType == Enum.AssetSaveType.MeshOnly)
                        {
                            DrawSaveOptions(collumnRect1, collumnRect2, collumnRect3, collumnRect4, 75);
                        }
                    }
                }
            }
        }
        public override void Reset()
        {
            base.Reset();

            solverType = LowpolyStyleMeshGeneratorEnum.Solver.AverageColor;

            solverTexture1PropertyName = string.Empty;
            solverTexture2PropertyName = string.Empty;
            solverTexture3PropertyName = string.Empty;
            solverColor1PropertyName = string.Empty;
            solverColor2PropertyName = string.Empty;
            solverColor3PropertyName = string.Empty;
            solverVertexColor = LowpolyStyleMeshGeneratorEnum.SourceVertexColor.None;

            solverLowpolyUV0 = LowpolyStyleMeshGeneratorEnum.LowpolyUV.None;
            solverFaceCenter = LowpolyStyleMeshGeneratorEnum.VertexAttribute.None;

            solverAlphaValue = LowpolyStyleMeshGeneratorEnum.AlphaType.DefaultValue;


            generateAssetSaveType = Enum.AssetSaveType.Prefab;
            generateMeshCombineType = Enum.MeshCombineType.Nothing;
            generateReplaceMeshColliders = false;
            generateLightmapUVs = false;
            generateMaterialType = Enum.MaterialType.CreateNew;
            generateDefaultShader = Shader.Find(LowpolyStyleMeshGeneratorConstants.shaderPreview);

            saveUseStaticEditorFlags = false;
            saveStaticEditorFlags = 0;
            saveUseStaticEditorFlagsForHierarchy = true;
            saveUseTag = false;
            saveTag = "Untagged";
            saveUseTagForHierarchy = true;
            saveUseLayer = false;
            saveLayer = 0;
            saveUseLayerForHierarchy = true;

            saveMeshFormat = Enum.MeshFormat.UnityAsset;
            saveMeshCompression = ModelImporterMeshCompression.Low;
            saveUseDefaultFlagsForVertexAttribute = true;
            saveVertexAttributeFlags = (VertexAttributePopup.AttributeFlags)~0;
        }
        public override void LoadEditorData()
        {
            base.LoadEditorData();


            if (generateDefaultShader == null || generateDefaultShader.GetType().Equals(typeof(Shader)) == false)
                generateDefaultShader = Shader.Find(LowpolyStyleMeshGeneratorConstants.shaderPreview);
            else
            {
                int ID = generateDefaultShader.GetInstanceID();
                generateDefaultShader = EditorUtilities.InstanceIDToObject(ID) as Shader;

                if (generateDefaultShader == null)
                    generateDefaultShader = Shader.Find(LowpolyStyleMeshGeneratorConstants.shaderPreview);
            }
        }
        override public bool IsReady()
        {
            if (solverType == LowpolyStyleMeshGeneratorEnum.Solver.AverageColor &&
                string.IsNullOrEmpty(solverTexture1PropertyName) &&
                string.IsNullOrEmpty(solverColor1PropertyName) &&
                solverFaceCenter == LowpolyStyleMeshGeneratorEnum.VertexAttribute.None &&
                solverVertexColor == LowpolyStyleMeshGeneratorEnum.SourceVertexColor.None)
            {
                return false;
            }

            if (string.IsNullOrEmpty(solverTexture1PropertyName) &&
                string.IsNullOrEmpty(solverColor1PropertyName) &&
                solverLowpolyUV0 == LowpolyStyleMeshGeneratorEnum.LowpolyUV.None &&
                solverFaceCenter == LowpolyStyleMeshGeneratorEnum.VertexAttribute.None &&
                solverVertexColor == LowpolyStyleMeshGeneratorEnum.SourceVertexColor.None)
            {
                return false;
            }

            if ((string.IsNullOrWhiteSpace(solverTexture1PropertyName) == false || string.IsNullOrWhiteSpace(solverColor1PropertyName) == false) && solverFaceCenter == LowpolyStyleMeshGeneratorEnum.VertexAttribute.Color)
                return false;


            if (generateAssetSaveType == Enum.AssetSaveType.Prefab || generateAssetSaveType == Enum.AssetSaveType.MeshOnly)
            {
                if (base.IsReady() == false)
                    return false;

                if (generateAssetSaveType == Enum.AssetSaveType.Prefab)
                {
                    if (generateMaterialType == Enum.MaterialType.CreateNew && generateDefaultShader == null)
                        return false;
                }
            }

            if (generateAssetSaveType == Enum.AssetSaveType.OverwriteOriginalMesh)
            {
                if (EditorWindow.active.listBatchObjects.All(c => c.isMeshAssetFormat == BatchObject.OptionsState.No))
                    return false;
            }


            return true;
        }

        public VertexAttributePopup.AttributeFlags GetRequiredVertexAttributes()
        {
            VertexAttributePopup.AttributeFlags usedAttributes = 0;

            if (string.IsNullOrEmpty(solverTexture1PropertyName) == false || string.IsNullOrEmpty(solverColor1PropertyName) == false || solverVertexColor != LowpolyStyleMeshGeneratorEnum.SourceVertexColor.None)
                usedAttributes |= VertexAttributePopup.AttributeFlags.Color;

            if ((solverType == LowpolyStyleMeshGeneratorEnum.Solver.CenterColor || solverType == LowpolyStyleMeshGeneratorEnum.Solver.FirstVertexColor) && solverLowpolyUV0 != LowpolyStyleMeshGeneratorEnum.LowpolyUV.None)
                usedAttributes |= VertexAttributePopup.AttributeFlags.UV0;


            switch (solverFaceCenter)
            {
                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV0: usedAttributes |= VertexAttributePopup.AttributeFlags.UV0; break;
                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV1: usedAttributes |= VertexAttributePopup.AttributeFlags.UV1; break;
                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV2: usedAttributes |= VertexAttributePopup.AttributeFlags.UV2; break;
                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV3: usedAttributes |= VertexAttributePopup.AttributeFlags.UV3; break;
                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV4: usedAttributes |= VertexAttributePopup.AttributeFlags.UV4; break;
                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV5: usedAttributes |= VertexAttributePopup.AttributeFlags.UV5; break;
                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV6: usedAttributes |= VertexAttributePopup.AttributeFlags.UV6; break;
                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV7: usedAttributes |= VertexAttributePopup.AttributeFlags.UV7; break;
                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.Normal: usedAttributes |= VertexAttributePopup.AttributeFlags.Normal; break;
                case LowpolyStyleMeshGeneratorEnum.VertexAttribute.Tangent: usedAttributes |= VertexAttributePopup.AttributeFlags.Tangent; break;
                default:
                    break;
            }

            if (GeneratingLightmapUVs())
                usedAttributes |= VertexAttributePopup.AttributeFlags.UV1;


            return usedAttributes;
        }
        public bool GeneratingLightmapUVs()
        {
            if ((generateAssetSaveType == Enum.AssetSaveType.Prefab || generateAssetSaveType == Enum.AssetSaveType.MeshOnly) &&
                (generateMeshCombineType == Enum.MeshCombineType.OneMeshWithSubmeshes || generateMeshCombineType == Enum.MeshCombineType.Everything))
            {
                return generateLightmapUVs;
            }
            else
            {
                return false;
            }
        }
        List<GUIContent> CollectMaterialsProperties(List<BatchObject> objectsInfo, bool needColor)
        {
            List<GUIContent> properties = new List<GUIContent>();

            List<Shader> collectedShaders = new List<Shader>();

            if (objectsInfo != null)
            {
                for (int i = 0; i < objectsInfo.Count; i++)
                {
                    if (objectsInfo[i] != null)
                    {
                        foreach (var meshInfo in objectsInfo[i].meshInfo)
                        {
                            if (meshInfo != null && meshInfo.materialproperties != null)
                            {
                                foreach (var materialProperty in meshInfo.materialproperties)
                                {
                                    if (materialProperty != null && materialProperty.material != null && materialProperty.material.shader != null)
                                    {
                                        Shader shader = materialProperty.material.shader;

                                        if (collectedShaders.Contains(shader) == false)
                                        {
                                            collectedShaders.Add(shader);
                                            properties.AddRange(MaterialProperties.GetShaderProperties(shader, needColor));
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }


            return properties.GroupBy(x => x.text).Select(x => x.First()).OrderBy(c => c.text).ToList();
        }

        void CallbackTexture1Property(object obj)
        {
            GUIContent guiContent = obj as GUIContent;
            if (guiContent == null)
            {
                solverTexture1PropertyName = obj.ToString();
            }
            else
            {
                solverTexture1PropertyName = guiContent.text;
            }


            if (solverTexture1PropertyName == "None")
                solverTexture1PropertyName = string.Empty;
        }
        void CallbackTexture2Property(object obj)
        {
            GUIContent guiContent = obj as GUIContent;
            if (guiContent == null)
            {
                solverTexture2PropertyName = obj.ToString();
            }
            else
            {
                solverTexture2PropertyName = guiContent.text;
            }


            if (solverTexture2PropertyName == "None")
                solverTexture2PropertyName = string.Empty;
        }
        void CallbackTexture3Property(object obj)
        {
            GUIContent guiContent = obj as GUIContent;
            if (guiContent == null)
            {
                solverTexture3PropertyName = obj.ToString();
            }
            else
            {
                solverTexture3PropertyName = guiContent.text;
            }


            if (solverTexture3PropertyName == "None")
                solverTexture3PropertyName = string.Empty;
        }
        void CallbackColor1Property(object obj)
        {
            GUIContent guiContent = obj as GUIContent;
            if (guiContent == null)
            {
                solverColor1PropertyName = obj.ToString();
            }
            else
            {
                solverColor1PropertyName = guiContent.text;
            }


            if (solverColor1PropertyName == "None")
                solverColor1PropertyName = string.Empty;
        }
        void CallbackColor2Property(object obj)
        {
            GUIContent guiContent = obj as GUIContent;
            if (guiContent == null)
            {
                solverColor2PropertyName = obj.ToString();
            }
            else
            {
                solverColor2PropertyName = guiContent.text;
            }


            if (solverColor2PropertyName == "None")
                solverColor2PropertyName = string.Empty;
        }
        void CallbackColor3Property(object obj)
        {
            GUIContent guiContent = obj as GUIContent;
            if (guiContent == null)
            {
                solverColor3PropertyName = obj.ToString();
            }
            else
            {
                solverColor3PropertyName = guiContent.text;
            }


            if (solverColor3PropertyName == "None")
                solverColor3PropertyName = string.Empty;
        }
        void CallbackLowpolyUV0(object obj)
        {
            solverLowpolyUV0 = (LowpolyStyleMeshGeneratorEnum.LowpolyUV)obj;
        }
        void CallbackLowpolyFaceCenter(object obj)
        {
            solverFaceCenter = (LowpolyStyleMeshGeneratorEnum.VertexAttribute)obj;
        }
        void CallbackDefaultShaderSelection(object obj)
        {
            if (obj == null)
                return;

            string shaderName = obj.ToString();
            if (string.IsNullOrEmpty(shaderName))
                return;

            generateDefaultShader = Shader.Find(shaderName);
        }
    }
}