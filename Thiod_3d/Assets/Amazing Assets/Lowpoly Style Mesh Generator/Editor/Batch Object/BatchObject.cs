// Lowpoly Style Mesh Generator <https://u3d.as/2z0X>
// Copyright (c) Amazing Assets <https://amazingassets.world>
 
using System.IO;
using System.Linq;
using System.Collections.Generic;

using UnityEngine;
using UnityEditor;


namespace AmazingAssets.LowpolyStyleMeshGenerator.Editor
{
    internal class BatchObject : BatchObjectBase
    {
        public enum OptionsState { Yes, No, Mixed }


        public List<BatchObjectMeshInfo> meshInfo;

        public OptionsState isMeshAssetFormat;

        public string submeshCount;
        public int vertexCountOfOriginalMesh;
        public string vertexAndTriangleCountOfOriginalMesh;
        public string vertexCountOfLowpolyMesh;

        public UnityEngine.Rendering.IndexFormat indexFormat;

        public OptionsState hasUV0;
        public OptionsState hasUV1;
        public OptionsState hasUV2;
        public OptionsState hasUV3;
        public OptionsState hasUV4;
        public OptionsState hasUV5;
        public OptionsState hasUV6;
        public OptionsState hasUV7;
        public OptionsState hasNormal;
        public OptionsState hasTangent;
        public OptionsState hasVertexColor;

        public bool hasMeshProblems;

        public BatchObject(UnityEngine.Object unityObject, bool expanded)
            : base(unityObject, expanded)
        {

            meshInfo = new List<BatchObjectMeshInfo>();


            MeshFilter[] meshFilters = gameObject.GetComponentsInChildren<MeshFilter>(true);
            if (meshFilters != null && meshFilters.Length > 0)
            {
                for (int i = 0; i < meshFilters.Length; i++)
                {
                    if (meshFilters[i] != null && meshFilters[i].sharedMesh != null)
                    {
                        meshInfo.Add(new BatchObjectMeshInfo(meshFilters[i], null, meshFilters[i].gameObject.GetComponent<Renderer>()));
                    }
                }
            }

            SkinnedMeshRenderer[] skinnedMeshRenderer = gameObject.GetComponentsInChildren<SkinnedMeshRenderer>(true);
            if (skinnedMeshRenderer != null && skinnedMeshRenderer.Length > 0)
            {
                for (int i = 0; i < skinnedMeshRenderer.Length; i++)
                {
                    if (skinnedMeshRenderer[i] != null && skinnedMeshRenderer[i].sharedMesh != null)
                    {
                        meshInfo.Add(new BatchObjectMeshInfo(null, skinnedMeshRenderer[i], skinnedMeshRenderer[i]));
                    }
                }
            }

            hasMeshProblems = meshInfo.Any(c => c.invalidMeshData);


            vertexCountOfOriginalMesh = 0;
            if (meshInfo.Count > 0)
            {
                int submeshCountMin = meshInfo.Min(c => c.mesh.subMeshCount);
                int submeshCountMax = meshInfo.Max(c => c.mesh.subMeshCount);
                submeshCount = submeshCountMin == submeshCountMax ? submeshCountMin.ToString() : string.Format("{0} - {1}", submeshCountMin, submeshCountMax);


                vertexCountOfOriginalMesh = Mathf.Max(0, meshInfo.Sum(c => c.mesh.vertexCount));
                int trianglesSum = meshInfo.Sum(c => c.mesh.GetTrianglesCount());

                vertexAndTriangleCountOfOriginalMesh = $"{vertexCountOfOriginalMesh.ToString("N0")} / {(trianglesSum / 3).ToString("N0")}";
                int vertexCountIncreasePersaentage = vertexCountOfOriginalMesh == 0 ? 0 : ((int)(((float)trianglesSum - vertexCountOfOriginalMesh) / vertexCountOfOriginalMesh * 100));
                vertexCountOfLowpolyMesh = trianglesSum.ToString("N0") + $"  ({vertexCountIncreasePersaentage}%)";

                indexFormat = trianglesSum > LowpolyStyleMeshGeneratorConstants.vertexLimitIn16BitsIndexBuffer ? UnityEngine.Rendering.IndexFormat.UInt32 : UnityEngine.Rendering.IndexFormat.UInt16;

                isMeshAssetFormat = OptionsState.Mixed;
                if (meshInfo.All(c => c.isMeshAssetFormat)) isMeshAssetFormat = OptionsState.Yes;
                else if (meshInfo.All(c => c.isMeshAssetFormat == false)) isMeshAssetFormat = OptionsState.No;

                hasUV0 = OptionsState.Mixed;
                if (meshInfo.All(c => c.hasUV0)) hasUV0 = OptionsState.Yes;
                else if (meshInfo.All(c => c.hasUV0 == false)) hasUV0 = OptionsState.No;

                hasUV1 = OptionsState.Mixed;
                if (meshInfo.All(c => c.hasUV1)) hasUV1 = OptionsState.Yes;
                else if (meshInfo.All(c => c.hasUV1 == false)) hasUV1 = OptionsState.No;

                hasUV2 = OptionsState.Mixed;
                if (meshInfo.All(c => c.hasUV2)) hasUV2 = OptionsState.Yes;
                else if (meshInfo.All(c => c.hasUV2 == false)) hasUV2 = OptionsState.No;

                hasUV3 = OptionsState.Mixed;
                if (meshInfo.All(c => c.hasUV3)) hasUV3 = OptionsState.Yes;
                else if (meshInfo.All(c => c.hasUV3 == false)) hasUV3 = OptionsState.No;

                hasUV4 = OptionsState.Mixed;
                if (meshInfo.All(c => c.hasUV4)) hasUV4 = OptionsState.Yes;
                else if (meshInfo.All(c => c.hasUV4 == false)) hasUV4 = OptionsState.No;

                hasUV5 = OptionsState.Mixed;
                if (meshInfo.All(c => c.hasUV5)) hasUV5 = OptionsState.Yes;
                else if (meshInfo.All(c => c.hasUV5 == false)) hasUV5 = OptionsState.No;

                hasUV6 = OptionsState.Mixed;
                if (meshInfo.All(c => c.hasUV6)) hasUV6 = OptionsState.Yes;
                else if (meshInfo.All(c => c.hasUV6 == false)) hasUV6 = OptionsState.No;

                hasUV7 = OptionsState.Mixed;
                if (meshInfo.All(c => c.hasUV7)) hasUV7 = OptionsState.Yes;
                else if (meshInfo.All(c => c.hasUV7 == false)) hasUV7 = OptionsState.No;

                hasNormal = OptionsState.Mixed;
                if (meshInfo.All(c => c.hasNormal)) hasNormal = OptionsState.Yes;
                else if (meshInfo.All(c => c.hasNormal == false)) hasNormal = OptionsState.No;

                hasTangent = OptionsState.Mixed;
                if (meshInfo.All(c => c.hasTangent)) hasTangent = OptionsState.Yes;
                else if (meshInfo.All(c => c.hasTangent == false)) hasTangent = OptionsState.No;

                hasVertexColor = OptionsState.Mixed;
                if (meshInfo.All(c => c.hasVertexColor)) hasVertexColor = OptionsState.Yes;
                else if (meshInfo.All(c => c.hasVertexColor == false)) hasVertexColor = OptionsState.No;
            }
        }

        public BatchObjectMeshInfo.PropertyState GetMaterialTexturePropertyState(string property1, string property2, string property3)
        {
            return GetMaterialPropertyState(property1, property2, property3, false);
        }
        public BatchObjectMeshInfo.PropertyState GetMaterialColorPropertyState(string property1, string property2, string property3)
        {
            return GetMaterialPropertyState(property1, property2, property3, true);
        }
        BatchObjectMeshInfo.PropertyState GetMaterialPropertyState(string property1, string property2, string property3, bool checkingColor)
        {
            if (string.IsNullOrEmpty(property1))
                return BatchObjectMeshInfo.PropertyState.NotAvailable;


            bool available = false;
            bool availableButEmpty = false;
            bool notAvailable = false;
            bool noMaterial = false;
            bool mixed = false;

            for (int i = 0; i < meshInfo.Count; i++)
            {
                if (checkingColor)
                {
                    switch (meshInfo[i].GetMaterialColorPropertyState(property1, property2, property3))
                    {
                        case BatchObjectMeshInfo.PropertyState.Available: available = true; break;
                        case BatchObjectMeshInfo.PropertyState.NotAvailable: notAvailable = true; break;
                        case BatchObjectMeshInfo.PropertyState.NoMaterial: noMaterial = true; break;
                        case BatchObjectMeshInfo.PropertyState.Mixed: mixed = true; break;
                    }
                }
                else
                {
                    switch (meshInfo[i].GetMaterialTexturePropertyState(property1, property2, property3))
                    {
                        case BatchObjectMeshInfo.PropertyState.Available: available = true; break;
                        case BatchObjectMeshInfo.PropertyState.AvailableButEmpty: availableButEmpty = true; break;
                        case BatchObjectMeshInfo.PropertyState.NotAvailable: notAvailable = true; break;
                        case BatchObjectMeshInfo.PropertyState.NoMaterial: noMaterial = true; break;
                        case BatchObjectMeshInfo.PropertyState.Mixed: mixed = true; break;
                    }
                }
            }


            if (noMaterial)
                return BatchObjectMeshInfo.PropertyState.NoMaterial;


            int weight = (available ? 1 : 0) + (availableButEmpty ? 2 : 0) + (notAvailable ? 4 : 0) + (mixed ? 8 : 0);

            switch (weight)
            {
                case 1: return BatchObjectMeshInfo.PropertyState.Available;

                case 2: return BatchObjectMeshInfo.PropertyState.AvailableButEmpty;

                case 4: return BatchObjectMeshInfo.PropertyState.NotAvailable;

                default: return BatchObjectMeshInfo.PropertyState.Mixed;
            }
        }
    }

    internal class BatchObjectMeshInfo : BatchObjectMeshInfoBase
    {
        public enum PropertyState { Available, AvailableButEmpty, NotAvailable, NoMaterial, Mixed }

        public bool isMeshAssetFormat;

        public string vertexAndTriangleCountOfOriginalMesh;
        public string vertexCountForLowpolyMesh;
        public UnityEngine.Rendering.IndexFormat indexFormat;

        public bool hasUV0;
        public bool hasUV1;
        public bool hasUV2;
        public bool hasUV3;
        public bool hasUV4;
        public bool hasUV5;
        public bool hasUV6;
        public bool hasUV7;
        public bool hasNormal;
        public bool hasTangent;
        public bool hasVertexColor;


        public MaterialProperties[] materialproperties;

        public bool expanded;


        public BatchObjectMeshInfo(MeshFilter meshFilter, SkinnedMeshRenderer skinnedMeshRenderer, Renderer renderer)
            : base(meshFilter, skinnedMeshRenderer)
        {

            if (renderer != null && renderer.sharedMaterials != null)
            {
                materialproperties = new MaterialProperties[renderer.sharedMaterials.Length];
                for (int i = 0; i < renderer.sharedMaterials.Length; i++)
                {
                    materialproperties[i] = new MaterialProperties(renderer.sharedMaterials[i]);
                }
            }


            vertexAndTriangleCountOfOriginalMesh = string.Format("{0} / {1}", mesh.vertexCount.ToString("N0"), (mesh.GetTrianglesCount() / 3).ToString("N0"));
            int vertexCountIncreasePersentage = mesh.vertexCount == 0 ? 0 : (int)(((float)mesh.GetTrianglesCount() - mesh.vertexCount) / mesh.vertexCount * 100);
            vertexCountForLowpolyMesh = mesh.GetTrianglesCount().ToString("N0") + $"  ({vertexCountIncreasePersentage}%)";

            indexFormat = mesh.vertexCount >= LowpolyStyleMeshGeneratorConstants.vertexLimitIn16BitsIndexBuffer ? UnityEngine.Rendering.IndexFormat.UInt32 : UnityEngine.Rendering.IndexFormat.UInt16;

            isMeshAssetFormat = Path.GetExtension(UnityEditor.AssetDatabase.GetAssetPath(mesh)).Contains(".asset");


            UnityEngine.Rendering.VertexAttributeDescriptor[] vertexAttributeDescriptor = mesh.GetVertexAttributes();
            for (int i = 0; i < vertexAttributeDescriptor.Length; i++)
            {
                switch (vertexAttributeDescriptor[i].attribute)
                {
                    case UnityEngine.Rendering.VertexAttribute.TexCoord0: hasUV0 = true; break;
                    case UnityEngine.Rendering.VertexAttribute.TexCoord1: hasUV1 = true; break;
                    case UnityEngine.Rendering.VertexAttribute.TexCoord2: hasUV2 = true; break;
                    case UnityEngine.Rendering.VertexAttribute.TexCoord3: hasUV3 = true; break;
                    case UnityEngine.Rendering.VertexAttribute.TexCoord4: hasUV4 = true; break;
                    case UnityEngine.Rendering.VertexAttribute.TexCoord5: hasUV5 = true; break;
                    case UnityEngine.Rendering.VertexAttribute.TexCoord6: hasUV6 = true; break;
                    case UnityEngine.Rendering.VertexAttribute.TexCoord7: hasUV7 = true; break;
                    case UnityEngine.Rendering.VertexAttribute.Normal: hasNormal = true; break;
                    case UnityEngine.Rendering.VertexAttribute.Tangent: hasTangent = true; break;
                    case UnityEngine.Rendering.VertexAttribute.Color: hasVertexColor = true; break;

                    default: break;
                }
            }
        }


        public PropertyState GetMaterialTexturePropertyState(string property1, string property2, string property3)
        {
            return GetMaterialPropertyState(property1, property2, property3, false);    //Texture ID
        }
        public PropertyState GetMaterialColorPropertyState(string property1, string property2, string property3)
        {
            return GetMaterialPropertyState(property1, property2, property3, true);    //Color ID
        }
        PropertyState GetMaterialPropertyState(string property1, string property2, string property3, bool checkingColor)
        {
            if (materialproperties == null || materialproperties.Length == 0 || materialproperties.All(c => c.material == null))
                return PropertyState.NoMaterial;


            if (string.IsNullOrWhiteSpace(property1) && string.IsNullOrWhiteSpace(property2) && string.IsNullOrWhiteSpace(property3))
                return PropertyState.NotAvailable;


            //GUIContent[] matProperties = materialproperties.Where(c => checkingColor ? c.colorProperties != null : c.textureProperties != null).SelectMany(c => checkingColor ? c.colorProperties : c.textureProperties).ToArray();

            int count1 = 0;
            int count2 = 0;
            int count3 = 0;
            if (checkingColor)
            {
                count1 = string.IsNullOrWhiteSpace(property1) ? 0 : materialproperties.Count(c => c.HasColor(property1));
                count2 = string.IsNullOrWhiteSpace(property2) ? 0 : materialproperties.Count(c => c.HasColor(property2));
                count3 = string.IsNullOrWhiteSpace(property3) ? 0 : materialproperties.Count(c => c.HasColor(property3));
            }
            else
            {
                count1 = string.IsNullOrWhiteSpace(property1) ? 0 : materialproperties.Count(c => c.HasTexture(property1));
                count2 = string.IsNullOrWhiteSpace(property2) ? 0 : materialproperties.Count(c => c.HasTexture(property2));
                count3 = string.IsNullOrWhiteSpace(property3) ? 0 : materialproperties.Count(c => c.HasTexture(property3));
            }



            if (count1 == 0 && count2 == 0 && count3 == 0)
                return PropertyState.NotAvailable;
            else
            {
                if (count1 == materialproperties.Length || count2 == materialproperties.Length || count3 == materialproperties.Length || (count1 + count2 + count3 == materialproperties.Length))
                {
                    if (checkingColor)
                    {
                        return PropertyState.Available;
                    }
                    else
                    {
                        if (checkingColor)
                        {

                        }
                        else
                        {
                            if (count1 > 0) count1 = materialproperties.Sum(c => c.IsTextureInUse(property1) ? 1 : 0);
                            if (count2 > 0) count2 = materialproperties.Sum(c => c.IsTextureInUse(property2) ? 1 : 0);
                            if (count3 > 0) count3 = materialproperties.Sum(c => c.IsTextureInUse(property3) ? 1 : 0);
                        }

                        if (count1 == materialproperties.Length || count2 == materialproperties.Length || count3 == materialproperties.Length || (count1 + count2 + count3 == materialproperties.Length))
                            return PropertyState.Available;
                        else
                            return PropertyState.AvailableButEmpty;
                    }
                }
                else
                    return PropertyState.Mixed;
            }
        }
    }


    internal class MaterialProperties
    {
        static Dictionary<Shader, MaterialProperties> dictionaryMaterialProperties = new Dictionary<Shader, MaterialProperties>();


        public Material material;
        public Dictionary<string, ShaderProperty> dictionaryShaderPropties;


        public MaterialProperties(Material material)
        {
            this.material = material;

            if (material != null && material.shader != null)
            {
                if (dictionaryShaderPropties == null)
                    dictionaryShaderPropties = new Dictionary<string, ShaderProperty>();


                if (dictionaryMaterialProperties.ContainsKey(material.shader))
                {
                    dictionaryShaderPropties = dictionaryMaterialProperties[material.shader].dictionaryShaderPropties;
                }
                else
                {

#if UNITY_6000_3_OR_NEWER
                    int propCount = material.shader.GetPropertyCount();
                    for (int i = 0; i < propCount; i++)
                    {
                        if (material.shader.GetPropertyType(i) == UnityEngine.Rendering.ShaderPropertyType.Texture &&
                            material.shader.GetPropertyTextureDimension(i) == UnityEngine.Rendering.TextureDimension.Tex2D)
                        {
                            string propertyName = material.shader.GetPropertyName(i);
                            string propertyDescription = material.shader.GetPropertyDescription(i);

                            dictionaryShaderPropties.Add(propertyName, new ShaderProperty(propertyDescription, true, material.GetTexture(propertyName) == null ? false : true));
                        }

                        if (material.shader.GetPropertyType(i) == UnityEngine.Rendering.ShaderPropertyType.Color)
                        {
                            string propertyName = material.shader.GetPropertyName(i);
                            string propertyDescription = material.shader.GetPropertyDescription(i);

                            dictionaryShaderPropties.Add(propertyName, new ShaderProperty(propertyDescription, false, true));
                        }
                    }
#else
                    int propCount = ShaderUtil.GetPropertyCount(material.shader);
                    for (int i = 0; i < propCount; i++)
                    {
                        if (ShaderUtil.GetPropertyType(material.shader, i) == ShaderUtil.ShaderPropertyType.TexEnv &&
                            ShaderUtil.GetTexDim(material.shader, i) == UnityEngine.Rendering.TextureDimension.Tex2D)
                        {
                            string propertyName = ShaderUtil.GetPropertyName(material.shader, i);
                            string propertyDescription = ShaderUtil.GetPropertyDescription(material.shader, i);

                            dictionaryShaderPropties.Add(propertyName, new ShaderProperty(propertyDescription, true, material.GetTexture(propertyName) == null ? false : true));
                        }

                        if (ShaderUtil.GetPropertyType(material.shader, i) == ShaderUtil.ShaderPropertyType.Color)
                        {
                            string propertyName = ShaderUtil.GetPropertyName(material.shader, i);
                            string propertyDescription = ShaderUtil.GetPropertyDescription(material.shader, i);

                            dictionaryShaderPropties.Add(propertyName, new ShaderProperty(propertyDescription, false, true));
                        }
                    }
#endif

                    dictionaryMaterialProperties.Add(material.shader, this);
                }
            }
        }

        public bool HasTexture(string propertyName)
        {
            if (string.IsNullOrWhiteSpace(propertyName) || dictionaryShaderPropties == null || dictionaryShaderPropties.ContainsKey(propertyName) == false)
                return false;

            return dictionaryShaderPropties[propertyName].isTexture;
        }
        public bool IsTextureInUse(string propertyName)
        {
            if (string.IsNullOrWhiteSpace(propertyName) || dictionaryShaderPropties == null || dictionaryShaderPropties.ContainsKey(propertyName) == false)
                return false;

            ShaderProperty shaderProeprty = dictionaryShaderPropties[propertyName];

            return shaderProeprty.isTexture && shaderProeprty.isTextureAssigned;
        }
        public bool HasColor(string propertyName)
        {
            if (string.IsNullOrWhiteSpace(propertyName) || dictionaryShaderPropties == null || dictionaryShaderPropties.ContainsKey(propertyName) == false)
                return false;

            return dictionaryShaderPropties[propertyName].isTexture ? false : true;
        }

        static public List<GUIContent> GetShaderProperties(Shader shader, bool needColor)
        {
            List<GUIContent> properties = new List<GUIContent>();

            if (dictionaryMaterialProperties != null && dictionaryMaterialProperties.ContainsKey(shader))
            {
                foreach (var shaderProperty in dictionaryMaterialProperties[shader].dictionaryShaderPropties)
                {
                    if (needColor)
                    {
                        if (shaderProperty.Value.isTexture == false)
                            properties.Add(new GUIContent(shaderProperty.Key, shaderProperty.Value.propertyDescription));
                    }
                    else
                    {
                        if (shaderProperty.Value.isTexture == true)
                            properties.Add(new GUIContent(shaderProperty.Key, shaderProperty.Value.propertyDescription));
                    }
                }
            }

            return properties;
        }
    }

    internal class ShaderProperty
    {
        public string propertyDescription;

        public bool isTexture;
        public bool isTextureAssigned;

        public ShaderProperty(string propertyDescription, bool isTexture, bool isTextureAssigned)
        {
            this.propertyDescription = propertyDescription;
            this.isTexture = isTexture;
            this.isTextureAssigned = isTextureAssigned;
        }
    }
}