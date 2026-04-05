// Lowpoly Style Mesh Generator <https://u3d.as/2z0X>
// Copyright (c) Amazing Assets <https://amazingassets.world>
 
using System.Runtime.CompilerServices;


[assembly: InternalsVisibleTo("AmazingAssets.LowpolyStyleMeshGenerator.Editor")]
[assembly: InternalsVisibleTo("AmazingAssets.LowpolyStyleMeshGeneratorEditor")]
namespace AmazingAssets.LowpolyStyleMeshGenerator
{
    static internal class LowpolyStyleMeshGeneratorConstants
    {
        static readonly public int vertexLimitIn16BitsIndexBuffer = 65535;
        static readonly public int vertexLimitIn32BitsIndexBuffer = 500000000;  //500 million

        static readonly public string shaderPreview = "Amazing Assets/Lowpoly Style Mesh Generator/Preview";
    }
}