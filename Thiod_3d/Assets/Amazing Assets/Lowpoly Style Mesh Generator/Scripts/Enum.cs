// Lowpoly Style Mesh Generator <https://u3d.as/2z0X>
// Copyright (c) Amazing Assets <https://amazingassets.world>

namespace AmazingAssets.LowpolyStyleMeshGenerator
{
    public static class LowpolyStyleMeshGeneratorEnum
    {
        public enum RenderPipeline { Unknown, Builtin, Universal, HighDefinition }
        public enum Solver { AverageColor, CenterColor, FirstVertexColor }
        public enum AlphaType { DefaultValue, TextureAlpha, ColorAlpha, VertexColorAlpha, One, Zero }
        public enum LowpolyUV { None, XY, ZW }
        public enum VertexAttribute { None, UV0, UV1, UV2, UV3, UV4, UV5, UV6, UV7, Normal, Tangent, Color }
        public enum SourceVertexColor { None, Original, Lowpoly }
    }
}