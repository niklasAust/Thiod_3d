// Lowpoly Style Mesh Generator <https://u3d.as/2z0X>
// Copyright (c) Amazing Assets <https://amazingassets.world>
 
using System.Linq;
using System.Collections.Generic;

using UnityEngine;


namespace AmazingAssets.LowpolyStyleMeshGenerator
{
    static public class LowpolyStyleMeshGeneratorCore
    {
        static public LowpolyStyleMeshGenerator LowpolyStyleMeshGenerator(this Mesh mesh, bool keepResources = false)
        {
            return new LowpolyStyleMeshGenerator(mesh, keepResources);
        }
    }

    public class LowpolyStyleMeshGenerator
    {
        static Dictionary<Texture, Texture2D> dictionaryTextureReadableCopies;    //Key - source texture, Value - readable copy


        Mesh mesh;
        bool keepResources;


        public LowpolyStyleMeshGenerator(Mesh mesh, bool keepResources)
        {
            this.mesh = mesh;
            this.keepResources = keepResources;
        }

        public Mesh Generate(LowpolyStyleMeshGeneratorEnum.Solver solver,
                             Texture2D[] textures,
                             int uvIndex,
                             Vector4[] texturesTilingOffset,
                             Color[] colors,
                             LowpolyStyleMeshGeneratorEnum.SourceVertexColor sourceVertexColor = LowpolyStyleMeshGeneratorEnum.SourceVertexColor.None,
                             LowpolyStyleMeshGeneratorEnum.AlphaType alphaType = LowpolyStyleMeshGeneratorEnum.AlphaType.DefaultValue,
                             LowpolyStyleMeshGeneratorEnum.LowpolyUV lowpolyUV0 = LowpolyStyleMeshGeneratorEnum.LowpolyUV.None,
                             LowpolyStyleMeshGeneratorEnum.VertexAttribute saveFaceCenter = LowpolyStyleMeshGeneratorEnum.VertexAttribute.None)
        {
            #region Check
            if (LowpolyStyleMeshGeneratorUtilities.IsMeshValid(mesh, true) == false)
            {
                LowpolyStyleMeshGeneratorDebug.Log(LogType.Error, "Generating lowpoly style mesh has failed!\nMesh may be null, or vertex/triangle indexies are incorrect, or mesh is not readable.", null, mesh);
                return null;
            }

            if (mesh.GetTrianglesCount() * 3 >= LowpolyStyleMeshGeneratorConstants.vertexLimitIn16BitsIndexBuffer && SystemInfo.supports32bitsIndexBuffer == false)
            {
                LowpolyStyleMeshGeneratorDebug.Log(LogType.Error, "Generating lowpoly style mesh has failed!\nSystem does not support required 32 bits index buffer.", null, mesh);
                return null;
            }
            #endregion


            //Prepair textures
            bool bakeVertexColor = false;
            if (textures == null || textures.Length == 0)
            {
                //Textures are not baked
            }
            else if (textures.Length == 1 || textures.Length == mesh.subMeshCount)
            {
                if (textures.All(c => c == null))
                    textures = null;
                else
                    bakeVertexColor = true;
            }
            else
            {
                LowpolyStyleMeshGeneratorDebug.Log(LogType.Warning, "Bake textures array size and sub-meshes count are not equal.", null, mesh);
            }

            //Prepair colors
            if (colors == null || colors.Length == 0)
            {
                //Colors are not baked
            }
            else if (colors.Length == 1 || colors.Length == mesh.subMeshCount)
            {
                //Good
                bakeVertexColor = true;
            }
            else
            {
                LowpolyStyleMeshGeneratorDebug.Log(LogType.Warning, "Bake colors array size and sub-meshes count are not equal.", null, mesh);
            }



            //Prepair UVs           
            bool meshHasTextureBakeUV = true;
            List<Vector2> meshTextureBakeUVs = new List<Vector2>();

            uvIndex = Mathf.Clamp(uvIndex, 0, 8);
            mesh.GetUVs(uvIndex, meshTextureBakeUVs);

            if (meshTextureBakeUVs == null || meshTextureBakeUVs.Count != mesh.vertexCount)
            {
                LowpolyStyleMeshGeneratorDebug.Log(LogType.Warning, $"Mesh '{mesh.name}' has no UVs at {uvIndex} index.", null, mesh);
                meshHasTextureBakeUV = false;
            }
            else
                meshTextureBakeUVs.Clear();



            //We need textures to be readable, without it we can not read pixel color value from it
            if (dictionaryTextureReadableCopies == null)
                dictionaryTextureReadableCopies = new Dictionary<Texture, Texture2D>();

            if (textures != null && meshHasTextureBakeUV)
            {
                for (int i = 0; i < textures.Length; i++)
                {
                    if (textures[i] != null && dictionaryTextureReadableCopies.ContainsKey(textures[i]) == false)
                    {
                        if (textures[i].GetType() == typeof(Texture2D) || textures[i].GetType() == typeof(RenderTexture))
                            dictionaryTextureReadableCopies.Add(textures[i], textures[i].GetReadableCopy());
                        else
                            LowpolyStyleMeshGeneratorDebug.Log(LogType.Warning, "'" + textures[i].name + "' type (" + textures[i].GetType() + ") is not supported.", null, textures[i]);
                    }
                }
            }


            //Create flat shaded style mesh
            Mesh lowpolyMesh = ExplodeMesh(mesh);



            //Bake textures and colors
            if (bakeVertexColor)
            {
                //Texture bake UV
                List<Vector2> lowpolyMeshTextureBakeUV = new List<Vector2>();
                if (meshHasTextureBakeUV)
                    lowpolyMesh.GetUVs(uvIndex, lowpolyMeshTextureBakeUV);   //Read UVs from flat shaded style mesh


                //Vertex Color
                Color[] meshVertexColor = (lowpolyMesh.colors == null || lowpolyMesh.colors.Length != lowpolyMesh.vertexCount) ? null : lowpolyMesh.colors;


                //Save colors from texture
                Color[] lowpolyColors = new Color[lowpolyMesh.GetTrianglesCount()];

                for (int i = 0; i < lowpolyMesh.subMeshCount; i++)
                {
                    int[] mT = lowpolyMesh.GetTriangles(i);

                    for (int j = 0; j < mT.Length; j += 3)
                    {
                        int index1 = mT[j];
                        int index2 = mT[j + 1];
                        int index3 = mT[j + 2];


                        Vector2 uv1 = Vector2.zero;
                        Vector2 uv2 = Vector2.zero;
                        Vector2 uv3 = Vector2.zero;
                        if (meshHasTextureBakeUV)
                        {
                            uv1 = lowpolyMeshTextureBakeUV[index1];
                            uv2 = lowpolyMeshTextureBakeUV[index2];
                            uv3 = lowpolyMeshTextureBakeUV[index3];
                        }

                        //Texture////////////////////////////////////////////////////////////////////////
                        Texture2D bakeTexture = null;
                        if (textures != null && textures.Length > 0 && meshHasTextureBakeUV)
                        {
                            if (textures.Length == 1)
                                bakeTexture = dictionaryTextureReadableCopies[textures[0]];
                            else if (i < textures.Length)
                                bakeTexture = dictionaryTextureReadableCopies[textures[i]];


                            //Adjust tiling&Offset
                            Vector2 tiling = Vector2.one;
                            Vector2 offset = Vector2.zero;
                            if (texturesTilingOffset != null && texturesTilingOffset.Length > 0)
                            {
                                if (texturesTilingOffset.Length == 1)
                                {
                                    tiling.x = texturesTilingOffset[0].x; tiling.y = texturesTilingOffset[0].y;
                                    offset.x = texturesTilingOffset[0].z; offset.y = texturesTilingOffset[0].w;
                                }
                                else if (i < texturesTilingOffset.Length)
                                {
                                    tiling.x = texturesTilingOffset[i].x; tiling.y = texturesTilingOffset[i].y;
                                    offset.x = texturesTilingOffset[i].z; offset.y = texturesTilingOffset[i].w;
                                }
                            }

                            uv1 = uv1 * tiling + offset;
                            uv2 = uv2 * tiling + offset;
                            uv3 = uv3 * tiling + offset;
                        }

                        Color textureColor1 = Color.white;
                        Color textureColor2 = Color.white;
                        Color textureColor3 = Color.white;
                        if (meshHasTextureBakeUV)
                            GetSampledTexture(bakeTexture, uv1, uv2, uv3, solver, out textureColor1, out textureColor2, out textureColor3);


                        //Color///////////////////////////////////////////////////////////////////////////
                        Color color = Color.white;
                        if (colors != null && colors.Length > 0)
                        {
                            if (colors.Length == 1)
                                color = colors[0];
                            else if (i < colors.Length)
                                color = colors[i];
                        }

                        if (color == null)
                            color = Color.white;

                        Color generatedColor1 = textureColor1 * color;
                        Color generatedColor2 = textureColor2 * color;
                        Color generatedColor3 = textureColor3 * color;



                        //Vertex color/////////////////////////////////////////////////////////////////////
                        Color vertexColor1 = Color.white;
                        Color vertexColor2 = Color.white;
                        Color vertexColor3 = Color.white;

                        if ((sourceVertexColor == LowpolyStyleMeshGeneratorEnum.SourceVertexColor.Original || sourceVertexColor == LowpolyStyleMeshGeneratorEnum.SourceVertexColor.Lowpoly) && meshVertexColor != null)
                        {
                            if (sourceVertexColor == LowpolyStyleMeshGeneratorEnum.SourceVertexColor.Original)
                            {
                                vertexColor1 = meshVertexColor[index1];
                                vertexColor2 = meshVertexColor[index2];
                                vertexColor3 = meshVertexColor[index3];
                            }
                            else
                            {
                                Color sampledVertexColor = GetSampledVertexColor(meshVertexColor[index1], meshVertexColor[index2], meshVertexColor[index3], solver);

                                vertexColor1 = sampledVertexColor;
                                vertexColor2 = sampledVertexColor;
                                vertexColor3 = sampledVertexColor;
                            }

                            generatedColor1 *= vertexColor1;
                            generatedColor2 *= vertexColor2;
                            generatedColor3 *= vertexColor3;
                        }


                        //Alpha/////////////////////////////////////////////////////////////////////////////////
                        switch (alphaType)
                        {
                            case LowpolyStyleMeshGeneratorEnum.AlphaType.TextureAlpha:
                                {
                                    generatedColor1.a = textureColor1.a;
                                    generatedColor2.a = textureColor2.a;
                                    generatedColor3.a = textureColor3.a;
                                }
                                break;

                            case LowpolyStyleMeshGeneratorEnum.AlphaType.ColorAlpha:
                                {
                                    generatedColor1.a = color.a;
                                    generatedColor2.a = color.a;
                                    generatedColor3.a = color.a;
                                }
                                break;

                            case LowpolyStyleMeshGeneratorEnum.AlphaType.VertexColorAlpha:
                                {
                                    generatedColor1.a = vertexColor1.a;
                                    generatedColor2.a = vertexColor2.a;
                                    generatedColor3.a = vertexColor3.a;
                                }
                                break;

                            case LowpolyStyleMeshGeneratorEnum.AlphaType.One:
                                {
                                    generatedColor1.a = 1;
                                    generatedColor2.a = 1;
                                    generatedColor3.a = 1;
                                }
                                break;

                            case LowpolyStyleMeshGeneratorEnum.AlphaType.Zero:
                                {
                                    generatedColor1.a = 0;
                                    generatedColor2.a = 0;
                                    generatedColor3.a = 0;
                                }
                                break;

                            default:
                                break;
                        }


                        //Save/////////////////////////////////////////////////////////////////////////////////
                        lowpolyColors[index1] = generatedColor1;
                        lowpolyColors[index2] = generatedColor2;
                        lowpolyColors[index3] = generatedColor3;
                    }
                }


                //Save
                lowpolyMesh.colors = lowpolyColors;
            }


            //Cleanup
            if (keepResources == false)
                ReleaseResources();



            //Generate lowpoly UV0
            if (lowpolyUV0 != LowpolyStyleMeshGeneratorEnum.LowpolyUV.None)
            {
                List<Vector4> lowpolyMeshUV0 = new List<Vector4>();
                lowpolyMesh.GetUVs(0, lowpolyMeshUV0);

                if (lowpolyMeshUV0 == null || lowpolyMeshUV0.Count != lowpolyMesh.vertexCount)
                    LowpolyStyleMeshGeneratorDebug.Log(LogType.Warning, "Mesh '" + mesh.name + "' has no UV0.", null, mesh);
                else
                    lowpolyMesh.SetUVs(0, GenerateLowpolyUV(lowpolyMeshUV0, lowpolyUV0, solver));
            }


            //Generate face center
            if (saveFaceCenter != LowpolyStyleMeshGeneratorEnum.VertexAttribute.None)
            {
                Vector3[] originalPosition = lowpolyMesh.vertices;
                Vector4[] lowpolyPosition = new Vector4[lowpolyMesh.vertexCount];

                for (int i = 0; i < lowpolyMesh.vertexCount; i += 3)
                {
                    Vector4 middlePosiiton = (originalPosition[i] + originalPosition[i + 1] + originalPosition[i + 2]) / 3;

                    middlePosiiton.w = 1;   //For correct shader use, when multipling float4 with matrixes


                    lowpolyPosition[i] = middlePosiiton;
                    lowpolyPosition[i + 1] = middlePosiiton;
                    lowpolyPosition[i + 2] = middlePosiiton;
                }


                switch (saveFaceCenter)
                {
                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV0:
                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV1:
                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV2:
                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV3:
                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV4:
                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV5:
                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV6:
                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.UV7:
                        {
                            int uvID = (int)saveFaceCenter - 1;  //UV0 == 1 inside enum

                            lowpolyMesh.SetUVs(uvID, lowpolyPosition);
                        }
                        break;

                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.Color:
                        {
                            Color[] faceCenterColors = new Color[lowpolyMesh.vertexCount];
                            for (int i = 0; i < lowpolyMesh.vertexCount; i++)
                            {
                                faceCenterColors[i] = new Color(lowpolyPosition[i].x, lowpolyPosition[i].y, lowpolyPosition[i].z, 1);
                            }

                            lowpolyMesh.colors = faceCenterColors;
                        }
                        break;

                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.Normal:
                        {
                            Vector3[] faceCenterNormal = new Vector3[lowpolyMesh.vertexCount];
                            for (int i = 0; i < lowpolyMesh.vertexCount; i++)
                            {
                                faceCenterNormal[i] = new Vector3(lowpolyPosition[i].x, lowpolyPosition[i].y, lowpolyPosition[i].z);
                            }

                            lowpolyMesh.normals = faceCenterNormal;
                        }
                        break;

                    case LowpolyStyleMeshGeneratorEnum.VertexAttribute.Tangent:
                        {
                            lowpolyMesh.tangents = lowpolyPosition;
                        }
                        break;
                }
            }

            return lowpolyMesh;
        }


        static Mesh ExplodeMesh(Mesh sourceMesh)
        {
            Vector3[] mVertices = sourceMesh.vertices;
            List<Vector4> mUV0 = null;
            List<Vector4> mUV1 = null;
            List<Vector4> mUV2 = null;
            List<Vector4> mUV3 = null;
            List<Vector4> mUV4 = null;
            List<Vector4> mUV5 = null;
            List<Vector4> mUV6 = null;
            List<Vector4> mUV7 = null;
            Vector3[] mNormal = null;
            Vector4[] mTangent = null;
            Color[] mColor = null;
            BoneWeight[] mBW = null;


            List<Vector3> newVertices = new List<Vector3>();
            List<List<int>> subMeshIndeces = new List<List<int>>();
            List<Vector4> newUV0 = null;
            List<Vector4> newUV1 = null;
            List<Vector4> newUV2 = null;
            List<Vector4> newUV3 = null;
            List<Vector4> newUV4 = null;
            List<Vector4> newUV5 = null;
            List<Vector4> newUV6 = null;
            List<Vector4> newUV7 = null;
            List<Vector3> newNormal = null;
            List<Vector4> newTangent = null;
            List<Color> newColor = null;
            List<BoneWeight> newBW = null;


            bool hasUV0 = false;
            bool hasUV1 = false;
            bool hasUV2 = false;
            bool hasUV3 = false;
            bool hasUV4 = false;
            bool hasUV5 = false;
            bool hasUV6 = false;
            bool hasUV7 = false;
            bool hasNormal = false;
            bool hasTangent = false;
            bool hasVertexColor = false;
            bool hasSkin = false;


            UnityEngine.Rendering.VertexAttributeDescriptor[] vertexAttributeDescriptor = sourceMesh.GetVertexAttributes();
            for (int i = 0; i < vertexAttributeDescriptor.Length; i++)
            {
                switch (vertexAttributeDescriptor[i].attribute)
                {
                    case UnityEngine.Rendering.VertexAttribute.TexCoord0:
                        mUV0 = new List<Vector4>(); sourceMesh.GetUVs(0, mUV0);
                        newUV0 = new List<Vector4>();
                        hasUV0 = true; break;

                    case UnityEngine.Rendering.VertexAttribute.TexCoord1:
                        mUV1 = new List<Vector4>(); sourceMesh.GetUVs(1, mUV1);
                        newUV1 = new List<Vector4>();
                        hasUV1 = true; break;

                    case UnityEngine.Rendering.VertexAttribute.TexCoord2:
                        mUV2 = new List<Vector4>(); sourceMesh.GetUVs(2, mUV2);
                        newUV2 = new List<Vector4>();
                        hasUV2 = true; break;

                    case UnityEngine.Rendering.VertexAttribute.TexCoord3:
                        mUV3 = new List<Vector4>(); sourceMesh.GetUVs(3, mUV3);
                        newUV3 = new List<Vector4>();
                        hasUV3 = true; break;

                    case UnityEngine.Rendering.VertexAttribute.TexCoord4:
                        mUV4 = new List<Vector4>(); sourceMesh.GetUVs(4, mUV4);
                        newUV4 = new List<Vector4>();
                        hasUV4 = true; break;

                    case UnityEngine.Rendering.VertexAttribute.TexCoord5:
                        mUV5 = new List<Vector4>(); sourceMesh.GetUVs(5, mUV5);
                        newUV5 = new List<Vector4>();
                        hasUV5 = true; break;

                    case UnityEngine.Rendering.VertexAttribute.TexCoord6:
                        mUV6 = new List<Vector4>(); sourceMesh.GetUVs(6, mUV6);
                        newUV6 = new List<Vector4>();
                        hasUV6 = true; break;

                    case UnityEngine.Rendering.VertexAttribute.TexCoord7:
                        mUV7 = new List<Vector4>(); sourceMesh.GetUVs(7, mUV7);
                        newUV7 = new List<Vector4>();
                        hasUV7 = true; break;

                    case UnityEngine.Rendering.VertexAttribute.Normal:
                        mNormal = sourceMesh.normals;
                        newNormal = new List<Vector3>();
                        hasNormal = true; break;

                    case UnityEngine.Rendering.VertexAttribute.Tangent:
                        mTangent = sourceMesh.tangents;
                        newTangent = new List<Vector4>();
                        hasTangent = true; break;

                    case UnityEngine.Rendering.VertexAttribute.Color:
                        mColor = sourceMesh.colors;
                        newColor = new List<Color>();
                        hasVertexColor = true; break;

                    case UnityEngine.Rendering.VertexAttribute.BlendIndices:
                    case UnityEngine.Rendering.VertexAttribute.BlendWeight:
                        if (hasSkin == false)
                        {
                            mBW = sourceMesh.boneWeights;
                            newBW = new List<BoneWeight>();
                            hasSkin = true;
                        }
                        break;

                    default:
                        break;
                }
            }


            int tIndec = 0;
            for (int i = 0; i < sourceMesh.subMeshCount; i++)
            {
                int[] mT = sourceMesh.GetTriangles(i);

                subMeshIndeces.Add(new List<int>());

                for (int j = 0; j < mT.Length; j += 3)
                {
                    int index1 = mT[j];
                    int index2 = mT[j + 1];
                    int index3 = mT[j + 2];

                    //Indexes
                    subMeshIndeces[subMeshIndeces.Count - 1].Add(tIndec++);
                    subMeshIndeces[subMeshIndeces.Count - 1].Add(tIndec++);
                    subMeshIndeces[subMeshIndeces.Count - 1].Add(tIndec++);

                    //Add vertices
                    newVertices.Add(mVertices[index1]);
                    newVertices.Add(mVertices[index2]);
                    newVertices.Add(mVertices[index3]);

                    //UV0
                    if (hasUV0)
                    {
                        newUV0.Add(mUV0[index1]);
                        newUV0.Add(mUV0[index2]);
                        newUV0.Add(mUV0[index3]);
                    }
                    //UV1
                    if (hasUV1)
                    {
                        newUV1.Add(mUV1[index1]);
                        newUV1.Add(mUV1[index2]);
                        newUV1.Add(mUV1[index3]);
                    }

                    //UV2
                    if (hasUV2)
                    {
                        newUV2.Add(mUV2[index1]);
                        newUV2.Add(mUV2[index2]);
                        newUV2.Add(mUV2[index3]);
                    }
                    //UV3
                    if (hasUV3)
                    {
                        newUV3.Add(mUV3[index1]);
                        newUV3.Add(mUV3[index2]);
                        newUV3.Add(mUV3[index3]);
                    }
                    //UV4
                    if (hasUV4)
                    {
                        newUV4.Add(mUV4[index1]);
                        newUV4.Add(mUV4[index2]);
                        newUV4.Add(mUV4[index3]);
                    }
                    //UV5
                    if (hasUV5)
                    {
                        newUV5.Add(mUV5[index1]);
                        newUV5.Add(mUV5[index2]);
                        newUV5.Add(mUV5[index3]);
                    }
                    //UV6
                    if (hasUV6)
                    {
                        newUV6.Add(mUV6[index1]);
                        newUV6.Add(mUV6[index2]);
                        newUV6.Add(mUV6[index3]);
                    }
                    //UV7
                    if (hasUV7)
                    {
                        newUV7.Add(mUV7[index1]);
                        newUV7.Add(mUV7[index2]);
                        newUV7.Add(mUV7[index3]);
                    }

                    //Normal
                    if (hasNormal)
                    {
                        Vector3 normal = (mNormal[index1] + mNormal[index2] + mNormal[index3]) / 3.0f;
                        normal = normal.normalized;

                        newNormal.Add(normal);
                        newNormal.Add(normal);
                        newNormal.Add(normal);
                    }
                    //Tangent
                    if (hasTangent)
                    {
                        newTangent.Add(mTangent[index1]);
                        newTangent.Add(mTangent[index2]);
                        newTangent.Add(mTangent[index3]);
                    }
                    //Vertex Color
                    if (hasVertexColor)
                    {
                        newColor.Add(mColor[index1]);
                        newColor.Add(mColor[index2]);
                        newColor.Add(mColor[index3]);
                    }
                    //Skinn
                    if (hasSkin)
                    {
                        newBW.Add(mBW[index1]);
                        newBW.Add(mBW[index2]);
                        newBW.Add(mBW[index3]);
                    }
                }
            }



            Mesh explodeMesh = new Mesh();
            explodeMesh.name = string.IsNullOrEmpty(sourceMesh.name) ? sourceMesh.GetInstanceID().ToString() : sourceMesh.name;

            //Set indexFormat before subMeshCount!
            explodeMesh.indexFormat = newVertices.Count >= LowpolyStyleMeshGeneratorConstants.vertexLimitIn16BitsIndexBuffer ? UnityEngine.Rendering.IndexFormat.UInt32 : UnityEngine.Rendering.IndexFormat.UInt16;

            explodeMesh.subMeshCount = sourceMesh.subMeshCount;


            explodeMesh.vertices = newVertices.ToArray();
            for (int i = 0; i < subMeshIndeces.Count; i++)
                explodeMesh.SetTriangles(subMeshIndeces[i].ToArray(), i);

            if (hasUV0)
                explodeMesh.SetUVs(0, new List<Vector4>(newUV0));
            if (hasUV1)
                explodeMesh.SetUVs(1, new List<Vector4>(newUV1));
            if (hasUV2)
                explodeMesh.SetUVs(2, new List<Vector4>(newUV2));
            if (hasUV3)
                explodeMesh.SetUVs(3, new List<Vector4>(newUV3));
            if (hasUV4)
                explodeMesh.SetUVs(4, new List<Vector4>(newUV4));
            if (hasUV5)
                explodeMesh.SetUVs(5, new List<Vector4>(newUV5));
            if (hasUV6)
                explodeMesh.SetUVs(6, new List<Vector4>(newUV6));
            if (hasUV7)
                explodeMesh.SetUVs(7, new List<Vector4>(newUV7));

            if (hasNormal)
                explodeMesh.normals = newNormal.ToArray();
            if (hasTangent)
                explodeMesh.tangents = newTangent.ToArray();
            if (hasVertexColor)
                explodeMesh.colors = newColor.ToArray();

            if (hasSkin)
            {
                explodeMesh.boneWeights = newBW.ToArray();
                explodeMesh.bindposes = sourceMesh.bindposes;
            }



            #region BlendShape
            if (sourceMesh.blendShapeCount > 0)
            {
                Dictionary<int, int> blensShapesIndexMap = new Dictionary<int, int>();


                int dataIndex = -1;
                for (int i = 0; i < sourceMesh.subMeshCount; i++)
                {
                    int vCount = sourceMesh.GetTriangles(i).Length;

                    int[] mT = sourceMesh.GetTriangles(i);

                    for (int j = 0; j < vCount; j++)
                    {
                        int index = mT[j];

                        blensShapesIndexMap.Add(++dataIndex, index);
                    }
                }


                int dataCount = sourceMesh.GetTrianglesCount();


                var deltaVertices = new Vector3[sourceMesh.vertexCount];
                var deltaNormals = new Vector3[sourceMesh.vertexCount];
                var deltaTangents = new Vector3[sourceMesh.vertexCount];
                var newDeltaVertices = new Vector3[dataCount];
                var newDeltaNormals = new Vector3[dataCount];
                var newDeltaTangents = new Vector3[dataCount];
                for (int shapeIndex = 0; shapeIndex < sourceMesh.blendShapeCount; shapeIndex++)
                {
                    var shapeName = sourceMesh.GetBlendShapeName(shapeIndex);
                    var frameCount = sourceMesh.GetBlendShapeFrameCount(shapeIndex);

                    for (int frameIndex = 0; frameIndex < frameCount; frameIndex++)
                    {
                        var frameWeight = sourceMesh.GetBlendShapeFrameWeight(shapeIndex, frameIndex);
                        sourceMesh.GetBlendShapeFrameVertices(shapeIndex, frameIndex, deltaVertices, deltaNormals, deltaTangents);

                        for (int newIdx = 0; newIdx < dataCount; newIdx++)
                        {
                            int idx = blensShapesIndexMap[newIdx];
                            newDeltaVertices[newIdx] = deltaVertices[idx];
                            newDeltaNormals[newIdx] = deltaNormals[idx];
                            newDeltaTangents[newIdx] = deltaNormals[idx];
                        }

                        explodeMesh.AddBlendShapeFrame(shapeName, frameWeight, newDeltaVertices, newDeltaNormals, newDeltaTangents);
                    }
                }
            }
            #endregion


            return explodeMesh;
        }
        static void GetSampledTexture(Texture2D texture, Vector2 uv1, Vector2 uv2, Vector2 uv3, LowpolyStyleMeshGeneratorEnum.Solver solver, out Color color1, out Color color2, out Color color3)
        {
            Color lowpolyColor = Color.white;

            if (texture != null)
            {
                switch (solver)
                {
                    case LowpolyStyleMeshGeneratorEnum.Solver.AverageColor:
                        {
                            lowpolyColor = texture.GetPixelBilinear(uv1.x, uv1.y);
                            lowpolyColor += texture.GetPixelBilinear(uv2.x, uv2.y);
                            lowpolyColor += texture.GetPixelBilinear(uv3.x, uv3.y);
                            lowpolyColor /= 3.0f;
                        }
                        break;

                    case LowpolyStyleMeshGeneratorEnum.Solver.CenterColor:
                        {
                            Vector2 uv = (uv1 + uv2 + uv3) / 3.0f;
                            lowpolyColor = texture.GetPixelBilinear(uv.x, uv.y);
                        }
                        break;


                    case LowpolyStyleMeshGeneratorEnum.Solver.FirstVertexColor:
                        {
                            lowpolyColor = texture.GetPixelBilinear(uv1.x, uv1.y);
                        }
                        break;
                }


                if (QualitySettings.activeColorSpace == ColorSpace.Linear)
                    lowpolyColor = lowpolyColor.linear;
            }



            color1 = lowpolyColor;
            color2 = lowpolyColor;
            color3 = lowpolyColor;
        }
        static Color GetSampledVertexColor(Color color1, Color color2, Color color3, LowpolyStyleMeshGeneratorEnum.Solver solver)
        {
            switch (solver)
            {
                case LowpolyStyleMeshGeneratorEnum.Solver.FirstVertexColor: return color1;

                default:
                case LowpolyStyleMeshGeneratorEnum.Solver.AverageColor:
                case LowpolyStyleMeshGeneratorEnum.Solver.CenterColor: return ((color1 + color2 + color3) / 3.0f);
            }
        }
        static void GetLowpolyUV(ref Vector2 uv1, ref Vector2 uv2, ref Vector2 uv3, LowpolyStyleMeshGeneratorEnum.Solver solver)
        {
            switch (solver)
            {
                case LowpolyStyleMeshGeneratorEnum.Solver.AverageColor:
                case LowpolyStyleMeshGeneratorEnum.Solver.CenterColor:
                    {
                        uv1 = uv2 = uv3 = (uv1 + uv2 + uv3) / 3.0f;
                    }
                    break;

                case LowpolyStyleMeshGeneratorEnum.Solver.FirstVertexColor:
                    {
                        uv2 = uv3 = uv1;
                    }
                    break;
            }
        }
        static List<Vector4> GenerateLowpolyUV(List<Vector4> UVs, LowpolyStyleMeshGeneratorEnum.LowpolyUV uvSaveType, LowpolyStyleMeshGeneratorEnum.Solver solver)
        {
            for (int i = 0; i < UVs.Count; i += 3)
            {
                Vector2 uv0 = UVs[i];
                Vector2 uv1 = UVs[i + 1];
                Vector2 uv2 = UVs[i + 2];

                GetLowpolyUV(ref uv0, ref uv1, ref uv2, solver);

                if (uvSaveType == LowpolyStyleMeshGeneratorEnum.LowpolyUV.XY)
                {
                    UVs[i] = new Vector4(uv0.x, uv0.y, UVs[i].z, UVs[i].w);
                    UVs[i + 1] = new Vector4(uv1.x, uv1.y, UVs[i + 1].z, UVs[i + 1].w);
                    UVs[i + 2] = new Vector4(uv2.x, uv2.y, UVs[i + 2].z, UVs[i + 2].w);
                }
                else
                {
                    UVs[i] = new Vector4(UVs[i].x, UVs[i].y, uv0.x, uv0.y);
                    UVs[i + 1] = new Vector4(UVs[i + 1].x, UVs[i + 1].y, uv1.x, uv1.y);
                    UVs[i + 2] = new Vector4(UVs[i + 2].x, UVs[i + 2].y, uv2.x, uv2.y);
                }
            }

            return UVs;
        }

        static public void ReleaseResources()
        {
            if (dictionaryTextureReadableCopies != null)
            {
                foreach (var item in dictionaryTextureReadableCopies)
                {
                    LowpolyStyleMeshGeneratorUtilities.DestroyUnityObject(item.Value);
                }

                dictionaryTextureReadableCopies.Clear();
            }
        }
    }
}