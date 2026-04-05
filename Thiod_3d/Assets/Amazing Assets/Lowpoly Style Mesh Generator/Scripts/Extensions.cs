// Lowpoly Style Mesh Generator <https://u3d.as/2z0X>
// Copyright (c) Amazing Assets <https://amazingassets.world>
 
using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

using UnityEngine;


[assembly: InternalsVisibleTo("AmazingAssets.LowpolyStyleMeshGenerator.Editor")]
[assembly: InternalsVisibleTo("AmazingAssets.LowpolyStyleMeshGeneratorEditor")]
namespace AmazingAssets.LowpolyStyleMeshGenerator
{
    static internal class ExtensionsForMesh
    {
        public static int GetTrianglesCount(this Mesh mesh)
        {
            if (mesh == null)
                return 0;

            return (int)(mesh.GetIndexStart(mesh.subMeshCount - 1) + mesh.GetIndexCount(mesh.subMeshCount - 1));
        }
    }
    static internal class ExtensionsForArray
    {
        public static void Populate<T>(this T[] arr, T value)
        {
            for (int i = 0; i < arr.Length; i++)
            {
                arr[i] = value;
            }
        }
        public static void Populate<T>(this List<T> list, int count, T value)
        {
            list.Clear();
            for (int i = 0; i < count; i++)
            {
                list.Add(value);
            }
        }
    }

    static internal class ExtensionsForTexture2D
    {
        public static Texture2D GetReadableCopy(this Texture2D texture)
        {
            int width = Mathf.Clamp(texture.width, 4, SystemInfo.maxTextureSize);
            int height = Mathf.Clamp(texture.height, 4, SystemInfo.maxTextureSize);


            RenderTexture tempRT = RenderTexture.GetTemporary(width, height);
            tempRT.Create();

            RenderTexture currentRT = RenderTexture.active;
            RenderTexture.active = tempRT;


            Graphics.Blit(texture, tempRT);


            Texture2D readableTexture = new Texture2D(width, height, TextureFormat.RGBA32, false);
            readableTexture.name = texture.name;
            readableTexture.wrapMode = texture.wrapMode;
            readableTexture.ReadPixels(new Rect(0, 0, width, height), 0, 0);
            readableTexture.Apply(false);


            //Restore active RenderTexture
            RenderTexture.active = Application.isPlaying ? currentRT : null;

            //Clean up
            RenderTexture.ReleaseTemporary(tempRT);


            return readableTexture;
        }
    }

    static internal class ExtensionForString
    {
        public static string RemoveWhiteSpace(this string str)
        {
            return string.Join("", str.Split(default(string[]), StringSplitOptions.RemoveEmptyEntries));
        }
    }
}