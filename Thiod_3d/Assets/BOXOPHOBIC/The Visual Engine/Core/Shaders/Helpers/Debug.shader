// Made with Amplify Shader Editor v1.9.9.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug"
{
	Properties
	{
		[StyledBanner(Debug)] _Banner( "Banner", Float ) = 0
		[StyledEnum(NULL, Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3 Branch 4 Leaves 5 Height 6 Sphere 7 UV0_Y 8, 0, 0)] _MotionTinyMaskMode( "Motion 01 Anim Mask", Float ) = 4
		[StyledEnum(NULL, Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3 Branch 4 Leaves 5 Height 6 Sphere 7 UV0_Y 8, 0, 0)] _MotionBaseMaskMode( "Motion 01 Anim Mask", Float ) = 3
		[StyledEnum(NULL, Vertex_R 0 Vertex_G 1 Vertex_B 2 Vertex_A 3 Branch 4 Leaves 5 Height 6 Sphere 7 UV0_Y 8, 0, 0)] _MotionSmallMaskMode( "Motion 01 Anim Mask", Float ) = 4
		[StyledRemapSlider] _MotionTinyMaskRemap( "Motion 01 Anim Mask", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _MotionBaseMaskRemap( "Motion 01 Anim Mask", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _MotionSmallMaskRemap( "Motion 01 Anim Mask", Vector ) = ( 0, 1, 0, 0 )
		[HideInInspector] _motion_base_proc_mode( "_motion_base_proc_mode", Vector ) = ( 0, 0, 0, 0 )
		[HideInInspector] _motion_tiny_proc_mode( "_motion_tiny_proc_mode", Vector ) = ( 0, 0, 0, 0 )
		[HideInInspector] _motion_small_proc_mode( "_motion_small_proc_mode", Vector ) = ( 0, 0, 0, 0 )
		[HideInInspector] _motion_tiny_vert_mode( "_motion_tiny_vert_mode", Vector ) = ( 0, 0, 0, 0 )
		[HideInInspector] _motion_small_vert_mode( "_motion_small_vert_mode", Vector ) = ( 0, 0, 0, 0 )
		[HideInInspector] _motion_base_vert_mode( "_motion_base_vert_mode", Vector ) = ( 0, 0, 0, 0 )
		_ObjectRadiusValue( "Object Radius Value", Range( 0, 50 ) ) = 1
		_ObjectHeightValue( "Object Height Value", Range( 0, 50 ) ) = 1
		[HideInInspector] _object_phase_mode( "_object_phase_mode", Vector ) = ( 0, 0, 0, 0 )
		_IsVertexShader( "_IsVertexShader", Float ) = 0
		_IsSimpleShader( "_IsSimpleShader", Float ) = 0
		[HideInInspector] _IsTVEShader( "_IsTVEShader", Float ) = 0
		_IsStandardShader( "_IsStandardShader", Float ) = 0
		_IsSubsurfaceShader( "_IsSubsurfaceShader", Float ) = 0
		_IsImpostorShader( "_IsImpostorShader", Float ) = 0
		_IsCoreShader( "_IsCoreShader", Float ) = 0
		[NoScaleOffset] _MainNormalTex( "_MainNormalTex", 2D ) = "black" {}
		[NoScaleOffset] _EmissiveTex( "_EmissiveTex", 2D ) = "black" {}
		[NoScaleOffset] _SecondMaskTex( "_SecondMaskTex", 2D ) = "black" {}
		[NoScaleOffset] _SecondNormalTex( "_SecondNormalTex", 2D ) = "black" {}
		[NoScaleOffset] _SecondAlbedoTex( "_SecondAlbedoTex", 2D ) = "black" {}
		[NoScaleOffset] _MainAlbedoTex( "_MainAlbedoTex", 2D ) = "black" {}
		[NoScaleOffset] _MainMaskTex( "_MainMaskTex", 2D ) = "black" {}
		_RenderClip( "_RenderClip", Float ) = 0
		_IsElementShader( "_IsElementShader", Float ) = 0
		_IsHelperShader( "_IsHelperShader", Float ) = 0
		_MainAlphaClipValue( "_MainAlphaClipValue", Float ) = 0
		_DetailMode( "_DetailMode", Float ) = 0
		_EmissiveCat( "_EmissiveCat", Float ) = 0
		[HDR] _EmissiveColor( "_EmissiveColor", Color ) = ( 0, 0, 0, 0 )
		_IsBlanketShader( "_IsBlanketShader", Float ) = 0
		_IsPolygonalShader( "_IsPolygonalShader", Float ) = 0
		[Space(10)][StyledVector(9)] _main_coord_value( "_main_coord_value", Vector ) = ( 1, 1, 0, 0 )
		[Enum(UV 0,0,Baked,1)] _DetailCoordMode( "Detail Coord", Float ) = 0
		[Space(10)][StyledVector(9)] _SecondUVs( "Detail UVs", Vector ) = ( 1, 1, 0, 0 )
		[Space(10)][StyledVector(9)] _EmissiveUVs( "Emissive UVs", Vector ) = ( 1, 1, 0, 0 )
		_IsIdentifier( "_IsIdentifier", Float ) = 0
		_IsLiteShader( "_IsLiteShader", Float ) = 0
		_IsCustomShader( "_IsCustomShader", Float ) = 0
		_MotionMaskTex( "_MotionMaskTex", 2D ) = "white" {}
		[StyledMessage(Info, Use this shader to debug the original mesh or the converted mesh attributes., 0,0)] _Message( "Message", Float ) = 0


		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Trans Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Trans Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Trans Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Trans Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Trans Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Trans Shadow", Range( 0, 1 ) ) = 0.5

		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		//_SpecularHighlights("Specular Highlights", Float) = 1.0
		//_GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		

		

		Tags { "RenderType"="Opaque" "Queue"="Geometry" "DisableBatching"="False" }

	LOD 0

		Cull Off
		AlphaToMask Off
		ZWrite On
		ZTest LEqual
		ColorMask RGBA

		

		Blend Off
		

		CGINCLUDE
			#pragma target 4.5
			// ensure rendering platforms toggle list is visible

			float4 FixedTess( float tessValue )
			{
				return tessValue;
			}

			float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
			{
				float3 wpos = mul(o2w,vertex).xyz;
				float dist = distance (wpos, cameraPos);
				float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
				return f;
			}

			float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
			{
				float4 tess;
				tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
				tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
				tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
				tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
				return tess;
			}

			float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
			{
				float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
				float len = distance(wpos0, wpos1);
				float f = max(len * scParams.y / (edgeLen * dist), 1.0);
				return f;
			}

			float DistanceFromPlane (float3 pos, float4 plane)
			{
				float d = dot (float4(pos,1.0f), plane);
				return d;
			}

			bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
			{
				float4 planeTest;
				planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
				planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
				planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
				planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							  (( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
				return !all (planeTest);
			}

			float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
			{
				float3 f;
				f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
				f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
				f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

				return CalcTriEdgeTessFactors (f);
			}

			float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
			{
				float3 pos0 = mul(o2w,v0).xyz;
				float3 pos1 = mul(o2w,v1).xyz;
				float3 pos2 = mul(o2w,v2).xyz;
				float4 tess;
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
				return tess;
			}

			float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
			{
				float3 pos0 = mul(o2w,v0).xyz;
				float3 pos1 = mul(o2w,v1).xyz;
				float3 pos2 = mul(o2w,v2).xyz;
				float4 tess;

				if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
				{
					tess = 0.0f;
				}
				else
				{
					tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
					tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
					tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
					tess.w = (tess.x + tess.y + tess.z) / 3.0f;
				}
				return tess;
			}

			float4 ComputeClipSpacePosition( float2 screenPosNorm, float deviceDepth )
			{
				float4 positionCS = float4( screenPosNorm * 2.0 - 1.0, deviceDepth, 1.0 );
			#if UNITY_UV_STARTS_AT_TOP
				positionCS.y = -positionCS.y;
			#endif
				return positionCS;
			}
		ENDCG

		
		Pass
		{
			
			Name "ForwardBase"
			Tags { "LightMode"="ForwardBase" }

			Blend One Zero

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#define ASE_NO_AMBIENT 1
				#pragma multi_compile_instancing
				#define ASE_VERSION 19908
				#define ASE_USING_SAMPLING_MACROS 1

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_fwdbase
				#ifndef UNITY_PASS_FORWARDBASE
					#define UNITY_PASS_FORWARDBASE
				#endif
				#include "HLSLSupport.cginc"
				#if defined( ASE_GEOMETRY ) || defined( ASE_IMPOSTOR )
					#ifndef UNITY_INSTANCED_LOD_FADE
						#define UNITY_INSTANCED_LOD_FADE
					#endif
					#ifndef UNITY_INSTANCED_SH
						#define UNITY_INSTANCED_SH
					#endif
					#ifndef UNITY_INSTANCED_LIGHTMAPSTS
						#define UNITY_INSTANCED_LIGHTMAPSTS
					#endif
				#endif
				#include "UnityShaderVariables.cginc"
				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include "UnityPBSLighting.cginc"
				#include "AutoLight.cginc"

				#if defined( UNITY_INSTANCING_ENABLED ) && defined( ASE_INSTANCED_TERRAIN ) && ( defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL) || defined(_INSTANCEDTERRAINNORMALS_PIXEL) )
					#define ENABLE_TERRAIN_PERPIXEL_NORMAL
				#endif

				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES1
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#define ASE_NEEDS_VERT_POSITION
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_VERT_TANGENT
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES1
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES2
				#define ASE_NEEDS_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#pragma shader_feature_local TVE_LEGACY
				#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY(tex,samplertex,coord) tex2DArray(tex,coord)
				#endif//ASE Sampling Macros
				


				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					float4 texcoord : TEXCOORD0;
					float4 texcoord1 : TEXCOORD1;
					float4 texcoord2 : TEXCOORD2;
					float4 ase_color : COLOR;
					float4 ase_texcoord3 : TEXCOORD3;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float4 worldPos : TEXCOORD0; // xyz = positionWS, w = fogCoord
					half3 normalWS : TEXCOORD1;
					float4 tangentWS : TEXCOORD2; // holds terrainUV ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
					half4 ambientOrLightmapUV : TEXCOORD3;
					UNITY_LIGHTING_COORDS( 4, 5 )
					float4 ase_texcoord6 : TEXCOORD6;
					float4 ase_texcoord7 : TEXCOORD7;
					float4 ase_texcoord8 : TEXCOORD8;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				#ifdef ASE_TRANSMISSION
					float _TransmissionShadow;
				#endif
				#ifdef ASE_TRANSLUCENCY
					float _TransStrength;
					float _TransNormal;
					float _TransScattering;
					float _TransDirect;
					float _TransAmbient;
					float _TransShadow;
				#endif
				#ifdef ASE_TESSELLATION
					float _TessPhongStrength;
					float _TessValue;
					float _TessMin;
					float _TessMax;
					float _TessEdgeLength;
					float _TessMaxDisp;
				#endif

				uniform half _Banner;
				uniform half _Message;
				uniform float _IsSimpleShader;
				uniform float _IsVertexShader;
				uniform half _IsTVEShader;
				uniform half TVE_DEBUG_Type;
				uniform float _IsCoreShader;
				uniform float _IsBlanketShader;
				uniform float _IsImpostorShader;
				uniform float _IsPolygonalShader;
				uniform float _IsLiteShader;
				uniform float _IsStandardShader;
				uniform float _IsSubsurfaceShader;
				uniform float _IsCustomShader;
				uniform float _IsIdentifier;
				uniform half TVE_DEBUG_Index;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainAlbedoTex);
				uniform half4 _main_coord_value;
				SamplerState sampler_MainAlbedoTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainNormalTex);
				SamplerState sampler_MainNormalTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainMaskTex);
				SamplerState sampler_MainMaskTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondAlbedoTex);
				uniform half _DetailCoordMode;
				uniform half4 _SecondUVs;
				SamplerState sampler_SecondAlbedoTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondNormalTex);
				SamplerState sampler_SecondNormalTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondMaskTex);
				SamplerState sampler_SecondMaskTex;
				uniform float _DetailMode;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_EmissiveTex);
				uniform half4 _EmissiveUVs;
				SamplerState sampler_EmissiveTex;
				uniform float4 _EmissiveColor;
				uniform float _EmissiveCat;
				uniform half TVE_DEBUG_Min;
				uniform half TVE_DEBUG_Max;
				float4 _MainAlbedoTex_TexelSize;
				float4 _MainNormalTex_TexelSize;
				float4 _MainMaskTex_TexelSize;
				float4 _SecondAlbedoTex_TexelSize;
				float4 _SecondMaskTex_TexelSize;
				float4 _EmissiveTex_TexelSize;
				UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_DEBUG_MipTex);
				SamplerState samplerTVE_DEBUG_MipTex;
				uniform half4 TVE_CoatParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatBaseTex);
				uniform float4 TVE_CoatBaseCoord;
				uniform half TVE_DEBUG_Layer;
				SamplerState sampler_Linear_Clamp;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatNearTex);
				uniform float4 TVE_CoatNearCoord;
				SamplerState sampler_Linear_Repeat;
				uniform float TVE_CoatLayers[10];
				uniform half4 TVE_PaintParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintBaseTex);
				uniform float4 TVE_PaintBaseCoord;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintNearTex);
				uniform float4 TVE_PaintNearCoord;
				uniform float TVE_PaintLayers[10];
				uniform half4 TVE_GlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowBaseTex);
				uniform float4 TVE_GlowBaseCoord;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowNearTex);
				uniform float4 TVE_GlowNearCoord;
				uniform float TVE_GlowLayers[10];
				uniform half4 TVE_AtmoParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoBaseTex);
				uniform float4 TVE_AtmoBaseCoord;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoNearTex);
				uniform float4 TVE_AtmoNearCoord;
				uniform float TVE_AtmoLayers[10];
				uniform half4 TVE_FormParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormBaseTex);
				uniform float4 TVE_FormBaseCoord;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormNearTex);
				uniform float4 TVE_FormNearCoord;
				uniform float TVE_FormLayers[10];
				uniform half4 TVE_FlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowBaseTex);
				uniform float4 TVE_FlowBaseCoord;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowNearTex);
				uniform float4 TVE_FlowNearCoord;
				uniform float TVE_FlowLayers[10];
				uniform half4 _object_phase_mode;
				uniform half4 _motion_base_vert_mode;
				uniform half _ObjectHeightValue;
				uniform half4 _motion_base_proc_mode;
				uniform half _ObjectRadiusValue;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MotionMaskTex);
				uniform float4 _MotionMaskTex_ST;
				SamplerState sampler_MotionMaskTex;
				uniform half4 _MotionBaseMaskRemap;
				uniform half _MotionBaseMaskMode;
				uniform half4 _motion_small_vert_mode;
				uniform half4 _motion_small_proc_mode;
				uniform half4 _MotionSmallMaskRemap;
				uniform half _MotionSmallMaskMode;
				uniform half4 _motion_tiny_vert_mode;
				uniform half4 _motion_tiny_proc_mode;
				uniform half4 _MotionTinyMaskRemap;
				uniform half _MotionTinyMaskMode;
				uniform half TVE_DEBUG_Filter;
				uniform half TVE_DEBUG_Shading;
				uniform half TVE_DEBUG_Clip;
				uniform float _RenderClip;
				uniform float _MainAlphaClipValue;
				uniform float _IsElementShader;
				uniform float _IsHelperShader;


				float3 HSVToRGB( float3 c )
				{
					float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
					float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
					return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
				}
				
				float CapsuleMaskOptimized1914_g128148( float3 Position, half Height, half Radius )
				{
					    float3 a = float3(0, Height, 0);
					    float3 ba = -a;
					    float3 pa = Position - a;
					    
					    float baDot = dot(ba, ba);
					    float h = saturate(dot(pa, ba) / baDot);
					    
					    float3 q = pa - ba * h;
					    return length(q) / Radius;
				}
				
				float2 DecodeFloatToVector2( float enc )
				{
					float2 result ;
					result.y = enc % 2048;
					result.x = floor(enc / 2048);
					return result / (2048 - 1);
				}
				

				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float Debug_Index464_g128148 = TVE_DEBUG_Index;
					float3 ifLocalVar40_g128149 = 0;
					if( Debug_Index464_g128148 == 0.0 )
					ifLocalVar40_g128149 = saturate( v.vertex.xyz );
					float3 ifLocalVar40_g128156 = 0;
					if( Debug_Index464_g128148 == 1.0 )
					ifLocalVar40_g128156 = v.normal;
					float3 ifLocalVar40_g128162 = 0;
					if( Debug_Index464_g128148 == 2.0 )
					ifLocalVar40_g128162 = v.tangent.xyz;
					float ifLocalVar40_g128154 = 0;
					if( Debug_Index464_g128148 == 3.0 )
					ifLocalVar40_g128154 = saturate( v.tangent.w );
					float ifLocalVar40_g128198 = 0;
					if( Debug_Index464_g128148 == 5.0 )
					ifLocalVar40_g128198 = v.ase_color.r;
					float ifLocalVar40_g128199 = 0;
					if( Debug_Index464_g128148 == 6.0 )
					ifLocalVar40_g128199 = v.ase_color.g;
					float ifLocalVar40_g128200 = 0;
					if( Debug_Index464_g128148 == 7.0 )
					ifLocalVar40_g128200 = v.ase_color.b;
					float ifLocalVar40_g128201 = 0;
					if( Debug_Index464_g128148 == 8.0 )
					ifLocalVar40_g128201 = v.ase_color.a;
					float3 appendResult1147_g128148 = (float3(v.texcoord.xyzw.x , v.texcoord.xyzw.y , 0.0));
					float3 ifLocalVar40_g128202 = 0;
					if( Debug_Index464_g128148 == 9.0 )
					ifLocalVar40_g128202 = appendResult1147_g128148;
					float3 appendResult1148_g128148 = (float3(v.texcoord1.xyzw.x , v.texcoord1.xyzw.y , 0.0));
					float3 ifLocalVar40_g128203 = 0;
					if( Debug_Index464_g128148 == 10.0 )
					ifLocalVar40_g128203 = appendResult1148_g128148;
					float3 appendResult1149_g128148 = (float3(v.texcoord2.xyzw.x , v.texcoord2.xyzw.y , 0.0));
					float3 ifLocalVar40_g128223 = 0;
					if( Debug_Index464_g128148 == 11.0 )
					ifLocalVar40_g128223 = appendResult1149_g128148;
					float4 break33_g128221 = _object_phase_mode;
					float temp_output_30_0_g128221 = ( v.ase_color.r * break33_g128221.x );
					float temp_output_29_0_g128221 = ( v.ase_color.g * break33_g128221.y );
					float temp_output_31_0_g128221 = ( v.ase_color.b * break33_g128221.z );
					float temp_output_28_0_g128221 = ( temp_output_30_0_g128221 + temp_output_29_0_g128221 + temp_output_31_0_g128221 + ( v.ase_color.a * break33_g128221.w ) );
					half Motion_PhaseMask1725_g128148 = temp_output_28_0_g128221;
					float3 hsvTorgb260_g128148 = HSVToRGB( float3(Motion_PhaseMask1725_g128148,1.0,1.0) );
					float3 gammaToLinear266_g128148 = GammaToLinearSpace( hsvTorgb260_g128148 );
					float3 ifLocalVar40_g128224 = 0;
					if( Debug_Index464_g128148 == 12.0 )
					ifLocalVar40_g128224 = gammaToLinear266_g128148;
					float4 break1821_g128148 = v.ase_color;
					float4 break33_g128385 = _motion_base_vert_mode;
					float temp_output_30_0_g128385 = ( break1821_g128148.r * break33_g128385.x );
					float temp_output_29_0_g128385 = ( break1821_g128148.g * break33_g128385.y );
					float temp_output_31_0_g128385 = ( break1821_g128148.b * break33_g128385.z );
					float temp_output_28_0_g128385 = ( temp_output_30_0_g128385 + temp_output_29_0_g128385 + temp_output_31_0_g128385 + ( break1821_g128148.a * break33_g128385.w ) );
					half Bounds_Height1700_g128148 = _ObjectHeightValue;
					half Final_HeightMask1815_g128148 = saturate( ( v.vertex.xyz.y / Bounds_Height1700_g128148 ) );
					float4 break45_g128385 = _motion_base_proc_mode;
					float temp_output_48_0_g128385 = ( Final_HeightMask1815_g128148 * break45_g128385.x );
					float3 Position1914_g128148 = v.vertex.xyz;
					float Height1914_g128148 = Bounds_Height1700_g128148;
					half Bounds_Radius1702_g128148 = _ObjectRadiusValue;
					float Radius1914_g128148 = Bounds_Radius1702_g128148;
					float localCapsuleMaskOptimized1914_g128148 = CapsuleMaskOptimized1914_g128148( Position1914_g128148 , Height1914_g128148 , Radius1914_g128148 );
					half Final_SphereMask1816_g128148 = saturate( localCapsuleMaskOptimized1914_g128148 );
					float temp_output_47_0_g128385 = ( Final_SphereMask1816_g128148 * break45_g128385.y );
					float2 uv_MotionMaskTex = v.texcoord.xyzw.xy * _MotionMaskTex_ST.xy + _MotionMaskTex_ST.zw;
					float4 Motion_MaskTex1904_g128148 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex, 0.0 );
					float temp_output_49_0_g128385 = ( (Motion_MaskTex1904_g128148).r * break45_g128385.z );
					float clampResult17_g128376 = clamp( ( temp_output_28_0_g128385 + temp_output_48_0_g128385 + temp_output_47_0_g128385 + temp_output_49_0_g128385 ) , 0.0001 , 0.9999 );
					float temp_output_7_0_g128377 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g128377 = ( clampResult17_g128376 - temp_output_7_0_g128377 );
					float temp_output_6_0_g128378 = saturate( ( temp_output_9_0_g128377 / ( ( _MotionBaseMaskRemap.y - temp_output_7_0_g128377 ) + 0.0001 ) ) );
					float temp_output_7_0_g128378 = _MotionBaseMaskMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g128378 = ( temp_output_6_0_g128378 + temp_output_7_0_g128378 );
					#else
					float staticSwitch14_g128378 = temp_output_6_0_g128378;
					#endif
					half Motion_BaseMask1675_g128148 = staticSwitch14_g128378;
					float ifLocalVar40_g128225 = 0;
					if( Debug_Index464_g128148 == 13.0 )
					ifLocalVar40_g128225 = Motion_BaseMask1675_g128148;
					float4 break1855_g128148 = v.ase_color;
					float4 break33_g128386 = _motion_small_vert_mode;
					float temp_output_30_0_g128386 = ( break1855_g128148.r * break33_g128386.x );
					float temp_output_29_0_g128386 = ( break1855_g128148.g * break33_g128386.y );
					float temp_output_31_0_g128386 = ( break1855_g128148.b * break33_g128386.z );
					float temp_output_28_0_g128386 = ( temp_output_30_0_g128386 + temp_output_29_0_g128386 + temp_output_31_0_g128386 + ( break1855_g128148.a * break33_g128386.w ) );
					float4 break45_g128386 = _motion_small_proc_mode;
					float temp_output_48_0_g128386 = ( Final_HeightMask1815_g128148 * break45_g128386.x );
					float temp_output_47_0_g128386 = ( Final_SphereMask1816_g128148 * break45_g128386.y );
					float temp_output_49_0_g128386 = ( (Motion_MaskTex1904_g128148).g * break45_g128386.z );
					float enc1882_g128148 = v.texcoord.xyzw.z;
					float2 localDecodeFloatToVector21882_g128148 = DecodeFloatToVector2( enc1882_g128148 );
					float2 break1878_g128148 = localDecodeFloatToVector21882_g128148;
					half Small_Mask_Legacy1879_g128148 = break1878_g128148.x;
					#ifdef TVE_LEGACY
					float staticSwitch1883_g128148 = Small_Mask_Legacy1879_g128148;
					#else
					float staticSwitch1883_g128148 = ( temp_output_28_0_g128386 + temp_output_48_0_g128386 + temp_output_47_0_g128386 + temp_output_49_0_g128386 );
					#endif
					float clampResult17_g128379 = clamp( staticSwitch1883_g128148 , 0.0001 , 0.9999 );
					float temp_output_7_0_g128380 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g128380 = ( clampResult17_g128379 - temp_output_7_0_g128380 );
					float temp_output_6_0_g128381 = saturate( ( temp_output_9_0_g128380 / ( ( _MotionSmallMaskRemap.y - temp_output_7_0_g128380 ) + 0.0001 ) ) );
					float temp_output_7_0_g128381 = _MotionSmallMaskMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g128381 = ( temp_output_6_0_g128381 + temp_output_7_0_g128381 );
					#else
					float staticSwitch14_g128381 = temp_output_6_0_g128381;
					#endif
					half Motion_SmallMask1693_g128148 = staticSwitch14_g128381;
					float ifLocalVar40_g128226 = 0;
					if( Debug_Index464_g128148 == 14.0 )
					ifLocalVar40_g128226 = Motion_SmallMask1693_g128148;
					float4 break1867_g128148 = v.ase_color;
					float4 break33_g128387 = _motion_tiny_vert_mode;
					float temp_output_30_0_g128387 = ( break1867_g128148.r * break33_g128387.x );
					float temp_output_29_0_g128387 = ( break1867_g128148.g * break33_g128387.y );
					float temp_output_31_0_g128387 = ( break1867_g128148.b * break33_g128387.z );
					float temp_output_28_0_g128387 = ( temp_output_30_0_g128387 + temp_output_29_0_g128387 + temp_output_31_0_g128387 + ( break1867_g128148.a * break33_g128387.w ) );
					float4 break45_g128387 = _motion_tiny_proc_mode;
					float temp_output_48_0_g128387 = ( Final_HeightMask1815_g128148 * break45_g128387.x );
					float temp_output_47_0_g128387 = ( Final_SphereMask1816_g128148 * break45_g128387.y );
					float temp_output_49_0_g128387 = ( (Motion_MaskTex1904_g128148).b * break45_g128387.z );
					half Tiny_Mask_Legacy1880_g128148 = break1878_g128148.y;
					#ifdef TVE_LEGACY
					float staticSwitch1886_g128148 = Tiny_Mask_Legacy1880_g128148;
					#else
					float staticSwitch1886_g128148 = ( temp_output_28_0_g128387 + temp_output_48_0_g128387 + temp_output_47_0_g128387 + temp_output_49_0_g128387 );
					#endif
					float clampResult17_g128382 = clamp( staticSwitch1886_g128148 , 0.0001 , 0.9999 );
					float temp_output_7_0_g128383 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g128383 = ( clampResult17_g128382 - temp_output_7_0_g128383 );
					float temp_output_6_0_g128384 = saturate( ( temp_output_9_0_g128383 / ( ( _MotionTinyMaskRemap.y - temp_output_7_0_g128383 ) + 0.0001 ) ) );
					float temp_output_7_0_g128384 = _MotionTinyMaskMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g128384 = ( temp_output_6_0_g128384 + temp_output_7_0_g128384 );
					#else
					float staticSwitch14_g128384 = temp_output_6_0_g128384;
					#endif
					half Motion_TinyMask1717_g128148 = staticSwitch14_g128384;
					float ifLocalVar40_g128227 = 0;
					if( Debug_Index464_g128148 == 15.0 )
					ifLocalVar40_g128227 = Motion_TinyMask1717_g128148;
					float3 appendResult60_g128222 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 ifLocalVar40_g128228 = 0;
					if( Debug_Index464_g128148 == 16.0 )
					ifLocalVar40_g128228 = appendResult60_g128222;
					float3 vertexToFrag328_g128148 = ( ( ifLocalVar40_g128149 + ifLocalVar40_g128156 + ifLocalVar40_g128162 + ifLocalVar40_g128154 ) + ( ifLocalVar40_g128198 + ifLocalVar40_g128199 + ifLocalVar40_g128200 + ifLocalVar40_g128201 ) + ( ifLocalVar40_g128202 + ifLocalVar40_g128203 + ifLocalVar40_g128223 ) + ( ifLocalVar40_g128224 + ifLocalVar40_g128225 + ifLocalVar40_g128226 + ifLocalVar40_g128227 + ifLocalVar40_g128228 ) );
					o.ase_texcoord8.xyz = vertexToFrag328_g128148;
					
					o.ase_texcoord6 = v.texcoord.xyzw;
					o.ase_texcoord7 = v.texcoord1.xyzw;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord8.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = defaultVertexValue;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = v.normal;
					v.tangent = v.tangent;

					float3 positionWS = mul( unity_ObjectToWorld, v.vertex ).xyz;
					half3 normalWS = UnityObjectToWorldNormal( v.normal );
					half3 tangentWS = UnityObjectToWorldDir( v.tangent.xyz );

					o.pos = UnityObjectToClipPos( v.vertex );
					o.worldPos.xyz = positionWS;
					o.normalWS = normalWS;
					o.tangentWS = half4( tangentWS, v.tangent.w );

					o.ambientOrLightmapUV = 0;
					#ifdef LIGHTMAP_ON
						o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					#elif UNITY_SHOULD_SAMPLE_SH
						#ifdef VERTEXLIGHT_ON
							o.ambientOrLightmapUV.rgb += Shade4PointLights(
								unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
								unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
								unity_4LightAtten0, positionWS, normalWS );
						#endif
						o.ambientOrLightmapUV.rgb = ShadeSHPerVertex( normalWS, o.ambientOrLightmapUV.rgb );
					#endif
					#ifdef DYNAMICLIGHTMAP_ON
						o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					#endif

					#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
						o.tangentWS.zw = v.texcoord.xy;
						o.tangentWS.xy = v.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					#endif

					UNITY_TRANSFER_LIGHTING(o, v.texcoord1.xy);
					#if defined( ASE_FOG )
						UNITY_TRANSFER_FOG_COMBINED_WITH_WORLD_POS( o, o.pos );
					#endif
					return o;
				}

				#if defined(ASE_TESSELLATION)
				struct VertexControl
				{
					float4 vertex : INTERNALTESSPOS;
					half4 tangent : TANGENT;
					half3 normal : NORMAL;
					float4 texcoord : TEXCOORD0;
					float4 texcoord1 : TEXCOORD1;
					float4 texcoord2 : TEXCOORD2;
					float4 ase_color : COLOR;
					float4 ase_texcoord3 : TEXCOORD3;

					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct TessellationFactors
				{
					float edge[3] : SV_TessFactor;
					float inside : SV_InsideTessFactor;
				};

				VertexControl vert ( appdata v )
				{
					VertexControl o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_TRANSFER_INSTANCE_ID(v, o);
					o.vertex = v.vertex;
					o.tangent = v.tangent;
					o.normal = v.normal;
					o.texcoord = v.texcoord;
					o.texcoord1 = v.texcoord1;
					o.texcoord2 = v.texcoord2;
					o.texcoord = v.texcoord;
					o.ase_color = v.ase_color;
					o.ase_texcoord3 = v.ase_texcoord3;
					return o;
				}

				TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
				{
					TessellationFactors o;
					float4 tf = 1;
					float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
					float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
					#if defined(ASE_FIXED_TESSELLATION)
					tf = FixedTess( tessValue );
					#elif defined(ASE_DISTANCE_TESSELLATION)
					tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
					#elif defined(ASE_LENGTH_TESSELLATION)
					tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
					#elif defined(ASE_LENGTH_CULL_TESSELLATION)
					tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
					#endif
					o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
					return o;
				}

				[domain("tri")]
				[partitioning("fractional_odd")]
				[outputtopology("triangle_cw")]
				[patchconstantfunc("TessellationFunction")]
				[outputcontrolpoints(3)]
				VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
				{
				   return patch[id];
				}

				[domain("tri")]
				v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
				{
					appdata o = (appdata) 0;
					o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
					o.tangent = patch[0].tangent * bary.x + patch[1].tangent * bary.y + patch[2].tangent * bary.z;
					o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
					o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
					o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
					o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
					o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
					o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
					o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
					#if defined(ASE_PHONG_TESSELLATION)
					float3 pp[3];
					for (int i = 0; i < 3; ++i)
						pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
					float phongStrength = _TessPhongStrength;
					o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
					#endif
					UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
					return VertexFunction(o);
				}
				#else
				v2f vert ( appdata v )
				{
					return VertexFunction( v );
				}
				#endif

				half4 frag( v2f IN , uint ase_vface : SV_IsFrontFace
							#if defined( ASE_DEPTH_WRITE_ON )
								, out float outputDepth : SV_Depth
							#endif
							) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID(IN);

					#ifdef LOD_FADE_CROSSFADE
						UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
					#endif

					#if defined(ASE_LIGHTING_SIMPLE)
						SurfaceOutput o = (SurfaceOutput)0;
					#else
						#if defined(_SPECULAR_SETUP)
							SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
						#else
							SurfaceOutputStandard o = (SurfaceOutputStandard)0;
						#endif
					#endif

					half atten;
					{
						#if defined( ASE_RECEIVE_SHADOWS )
							UNITY_LIGHT_ATTENUATION( temp, IN, IN.worldPos.xyz )
							atten = temp;
						#else
							atten = 1;
						#endif
					}

					float3 PositionWS = IN.worldPos.xyz;
					half3 ViewDirWS = normalize( UnityWorldSpaceViewDir( PositionWS ) );
					float4 ScreenPosNorm = float4( IN.pos.xy * ( _ScreenParams.zw - 1.0 ), IN.pos.zw );
					float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, IN.pos.z ) * IN.pos.w;
					float4 ScreenPos = ComputeScreenPos( ClipPos );
					half3 NormalWS = IN.normalWS;
					half3 TangentWS = IN.tangentWS.xyz;
					half3 BitangentWS = cross( IN.normalWS, IN.tangentWS.xyz ) * IN.tangentWS.w * unity_WorldTransformParams.w;
					half3 LightAtten = atten;

					#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
						float2 sampleCoords = (IN.tangentWS.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
						NormalWS = UnityObjectToWorldNormal(normalize(tex2D(_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
						TangentWS = -cross(unity_ObjectToWorld._13_23_33, NormalWS);
						BitangentWS = cross(NormalWS, -TangentWS);
					#endif

					float3 temp_cast_0 = (0.0).xxx;
					
					float4 color690_g128148 = IsGammaSpace() ? float4( 0.1, 0.1, 0.1, 0 ) : float4( 0.01002283, 0.01002283, 0.01002283, 0 );
					float4 Shading_Inactive1492_g128148 = color690_g128148;
					float Debug_Type367_g128148 = TVE_DEBUG_Type;
					float4 color646_g128148 = IsGammaSpace() ? float4( 0.9245283, 0.7969696, 0.4142933, 1 ) : float4( 0.8368256, 0.5987038, 0.1431069, 1 );
					float4 Output_Converted717_g128148 = color646_g128148;
					float4 ifLocalVar40_g128209 = 0;
					if( Debug_Type367_g128148 == 0.0 )
					ifLocalVar40_g128209 = Output_Converted717_g128148;
					float4 color1529_g128148 = IsGammaSpace() ? float4( 0.9254902, 0.7960784, 0.4156863, 1 ) : float4( 0.8387991, 0.5972018, 0.1441285, 1 );
					float _IsCoreShader1551_g128148 = _IsCoreShader;
					float4 color1539_g128148 = IsGammaSpace() ? float4( 0.6196079, 0.7686275, 0.1490196, 0 ) : float4( 0.3419145, 0.5520116, 0.01938236, 0 );
					float _IsBlanketShader1554_g128148 = _IsBlanketShader;
					float4 color1542_g128148 = IsGammaSpace() ? float4( 0.9716981, 0.3162602, 0.4816265, 0 ) : float4( 0.9368213, 0.08154967, 0.1974273, 0 );
					float _IsImpostorShader1110_g128148 = _IsImpostorShader;
					float4 color1544_g128148 = IsGammaSpace() ? float4( 0.3254902, 0.6117647, 0.8117647, 0 ) : float4( 0.08650047, 0.3324516, 0.6239604, 0 );
					float _IsPolygonalShader1112_g128148 = _IsPolygonalShader;
					float4 color1649_g128148 = IsGammaSpace() ? float4( 0.6, 0.6, 0.6, 0 ) : float4( 0.3185468, 0.3185468, 0.3185468, 0 );
					float _IsLiteShader1648_g128148 = _IsLiteShader;
					float4 Output_Scope1531_g128148 = ( ( color1529_g128148 * _IsCoreShader1551_g128148 ) + ( color1539_g128148 * _IsBlanketShader1554_g128148 ) + ( color1542_g128148 * _IsImpostorShader1110_g128148 ) + ( color1544_g128148 * _IsPolygonalShader1112_g128148 ) + ( color1649_g128148 * _IsLiteShader1648_g128148 ) );
					float4 ifLocalVar40_g128211 = 0;
					if( Debug_Type367_g128148 == 2.0 )
					ifLocalVar40_g128211 = Output_Scope1531_g128148;
					float4 color529_g128148 = IsGammaSpace() ? float4( 0.62, 0.77, 0.15, 0 ) : float4( 0.3423916, 0.5542217, 0.01960665, 0 );
					float _IsVertexShader1158_g128148 = _IsVertexShader;
					float4 color544_g128148 = IsGammaSpace() ? float4( 0.3252937, 0.6122813, 0.8113208, 0 ) : float4( 0.08639329, 0.3330702, 0.6231937, 0 );
					float _IsSimpleShader359_g128148 = _IsSimpleShader;
					float4 color521_g128148 = IsGammaSpace() ? float4( 0.6566009, 0.3404236, 0.8490566, 0 ) : float4( 0.3886527, 0.09487338, 0.6903409, 0 );
					float _IsStandardShader344_g128148 = _IsStandardShader;
					float4 color1121_g128148 = IsGammaSpace() ? float4( 0.9716981, 0.88463, 0.1787558, 0 ) : float4( 0.9368213, 0.7573396, 0.02686729, 0 );
					float _IsSubsurfaceShader548_g128148 = _IsSubsurfaceShader;
					float4 Output_Lighting525_g128148 = ( ( color529_g128148 * _IsVertexShader1158_g128148 ) + ( color544_g128148 * _IsSimpleShader359_g128148 ) + ( color521_g128148 * _IsStandardShader344_g128148 ) + ( color1121_g128148 * _IsSubsurfaceShader548_g128148 ) );
					float4 ifLocalVar40_g128212 = 0;
					if( Debug_Type367_g128148 == 3.0 )
					ifLocalVar40_g128212 = Output_Lighting525_g128148;
					float4 color1559_g128148 = IsGammaSpace() ? float4( 0.9245283, 0.7969696, 0.4142933, 1 ) : float4( 0.8368256, 0.5987038, 0.1431069, 1 );
					float4 color1563_g128148 = IsGammaSpace() ? float4( 0.3053578, 0.8867924, 0.5362216, 0 ) : float4( 0.0759199, 0.7615293, 0.2491121, 0 );
					float _IsCustomShader1570_g128148 = _IsCustomShader;
					float4 lerpResult1561_g128148 = lerp( color1559_g128148 , color1563_g128148 , _IsCustomShader1570_g128148);
					float4 Output_Custom1560_g128148 = lerpResult1561_g128148;
					float4 ifLocalVar40_g128213 = 0;
					if( Debug_Type367_g128148 == 4.0 )
					ifLocalVar40_g128213 = Output_Custom1560_g128148;
					float3 hsvTorgb1452_g128148 = HSVToRGB( float3(( _IsIdentifier / 1000.0 ),1.0,1.0) );
					float3 gammaToLinear1453_g128148 = GammaToLinearSpace( hsvTorgb1452_g128148 );
					float4 appendResult1657_g128148 = (float4(gammaToLinear1453_g128148 , 1.0));
					float4 Output_Sharing1355_g128148 = appendResult1657_g128148;
					float4 ifLocalVar40_g128214 = 0;
					if( Debug_Type367_g128148 == 5.0 )
					ifLocalVar40_g128214 = Output_Sharing1355_g128148;
					float Debug_Index464_g128148 = TVE_DEBUG_Index;
					half2 Main_UVs1219_g128148 = ( ( IN.ase_texcoord6.xy * (_main_coord_value).xy ) + (_main_coord_value).zw );
					float4 tex2DNode586_g128148 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs1219_g128148 );
					float3 appendResult637_g128148 = (float3(tex2DNode586_g128148.r , tex2DNode586_g128148.g , tex2DNode586_g128148.b));
					float3 ifLocalVar40_g128155 = 0;
					if( Debug_Index464_g128148 == 0.0 )
					ifLocalVar40_g128155 = appendResult637_g128148;
					float ifLocalVar40_g128159 = 0;
					if( Debug_Index464_g128148 == 1.0 )
					ifLocalVar40_g128159 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs1219_g128148 ).a;
					float4 tex2DNode604_g128148 = SAMPLE_TEXTURE2D( _MainNormalTex, sampler_MainNormalTex, Main_UVs1219_g128148 );
					float3 appendResult876_g128148 = (float3(tex2DNode604_g128148.a , tex2DNode604_g128148.g , 1.0));
					float3 gammaToLinear878_g128148 = GammaToLinearSpace( appendResult876_g128148 );
					float3 ifLocalVar40_g128163 = 0;
					if( Debug_Index464_g128148 == 2.0 )
					ifLocalVar40_g128163 = gammaToLinear878_g128148;
					float ifLocalVar40_g128151 = 0;
					if( Debug_Index464_g128148 == 3.0 )
					ifLocalVar40_g128151 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g128148 ).r;
					float ifLocalVar40_g128169 = 0;
					if( Debug_Index464_g128148 == 4.0 )
					ifLocalVar40_g128169 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g128148 ).g;
					float ifLocalVar40_g128160 = 0;
					if( Debug_Index464_g128148 == 5.0 )
					ifLocalVar40_g128160 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g128148 ).b;
					float ifLocalVar40_g128150 = 0;
					if( Debug_Index464_g128148 == 6.0 )
					ifLocalVar40_g128150 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g128148 ).a;
					float2 appendResult1251_g128148 = (float2(IN.ase_texcoord7.z , IN.ase_texcoord7.w));
					float2 Mesh_DetailCoord1254_g128148 = appendResult1251_g128148;
					float2 lerpResult1231_g128148 = lerp( IN.ase_texcoord6.xy , Mesh_DetailCoord1254_g128148 , _DetailCoordMode);
					half2 Layer_02_UVs1234_g128148 = ( ( lerpResult1231_g128148 * (_SecondUVs).xy ) + (_SecondUVs).zw );
					float4 tex2DNode854_g128148 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Layer_02_UVs1234_g128148 );
					float3 appendResult839_g128148 = (float3(tex2DNode854_g128148.r , tex2DNode854_g128148.g , tex2DNode854_g128148.b));
					float3 ifLocalVar40_g128153 = 0;
					if( Debug_Index464_g128148 == 7.0 )
					ifLocalVar40_g128153 = appendResult839_g128148;
					float ifLocalVar40_g128161 = 0;
					if( Debug_Index464_g128148 == 8.0 )
					ifLocalVar40_g128161 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Layer_02_UVs1234_g128148 ).a;
					float4 tex2DNode841_g128148 = SAMPLE_TEXTURE2D( _SecondNormalTex, sampler_SecondNormalTex, Layer_02_UVs1234_g128148 );
					float3 appendResult880_g128148 = (float3(tex2DNode841_g128148.a , tex2DNode841_g128148.g , 1.0));
					float3 gammaToLinear879_g128148 = GammaToLinearSpace( appendResult880_g128148 );
					float3 ifLocalVar40_g128168 = 0;
					if( Debug_Index464_g128148 == 8.0 )
					ifLocalVar40_g128168 = gammaToLinear879_g128148;
					float ifLocalVar40_g128164 = 0;
					if( Debug_Index464_g128148 == 10.0 )
					ifLocalVar40_g128164 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Layer_02_UVs1234_g128148 ).r;
					float ifLocalVar40_g128158 = 0;
					if( Debug_Index464_g128148 == 11.0 )
					ifLocalVar40_g128158 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Layer_02_UVs1234_g128148 ).g;
					float ifLocalVar40_g128166 = 0;
					if( Debug_Index464_g128148 == 12.0 )
					ifLocalVar40_g128166 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Layer_02_UVs1234_g128148 ).b;
					float ifLocalVar40_g128167 = 0;
					if( Debug_Index464_g128148 == 13.0 )
					ifLocalVar40_g128167 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Layer_02_UVs1234_g128148 ).a;
					half2 Emissive_UVs1245_g128148 = ( ( IN.ase_texcoord6.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
					float4 tex2DNode858_g128148 = SAMPLE_TEXTURE2D( _EmissiveTex, sampler_EmissiveTex, Emissive_UVs1245_g128148 );
					float ifLocalVar40_g128157 = 0;
					if( Debug_Index464_g128148 == 14.0 )
					ifLocalVar40_g128157 = tex2DNode858_g128148.r;
					float Debug_Min721_g128148 = TVE_DEBUG_Min;
					float temp_output_7_0_g128165 = Debug_Min721_g128148;
					float4 temp_cast_4 = (temp_output_7_0_g128165).xxxx;
					float4 temp_output_9_0_g128165 = ( ( float4( ( ( ifLocalVar40_g128155 + ifLocalVar40_g128159 + ifLocalVar40_g128163 ) + ( ifLocalVar40_g128151 + ifLocalVar40_g128169 + ifLocalVar40_g128160 + ifLocalVar40_g128150 ) ) , 0.0 ) + float4( ( ( ( ifLocalVar40_g128153 + ifLocalVar40_g128161 + ifLocalVar40_g128168 ) + ( ifLocalVar40_g128164 + ifLocalVar40_g128158 + ifLocalVar40_g128166 + ifLocalVar40_g128167 ) ) * _DetailMode ) , 0.0 ) + ( ( ifLocalVar40_g128157 * _EmissiveColor ) * _EmissiveCat ) ) - temp_cast_4 );
					float Debug_Max723_g128148 = TVE_DEBUG_Max;
					float4 Output_Maps561_g128148 = saturate( ( temp_output_9_0_g128165 / ( ( Debug_Max723_g128148 - temp_output_7_0_g128165 ) + 0.0001 ) ) );
					float4 ifLocalVar40_g128215 = 0;
					if( Debug_Type367_g128148 == 6.0 )
					ifLocalVar40_g128215 = Output_Maps561_g128148;
					float Resolution44_g128186 = max( _MainAlbedoTex_TexelSize.z, _MainAlbedoTex_TexelSize.w );
					float4 color62_g128186 = IsGammaSpace() ? float4( 0.484069, 0.862666, 0.9245283, 0 ) : float4( 0.1995908, 0.7155456, 0.8368256, 0 );
					float4 ifLocalVar61_g128186 = 0;
					if( Resolution44_g128186 <= 256.0 )
					ifLocalVar61_g128186 = color62_g128186;
					float4 color55_g128186 = IsGammaSpace() ? float4( 0.1933962, 0.7383016, 1, 0 ) : float4( 0.03108436, 0.5044825, 1, 0 );
					float4 ifLocalVar56_g128186 = 0;
					if( Resolution44_g128186 == 512.0 )
					ifLocalVar56_g128186 = color55_g128186;
					float4 color42_g128186 = IsGammaSpace() ? float4( 0.4431373, 0.7921569, 0.1764706, 0 ) : float4( 0.1651322, 0.5906189, 0.02624122, 0 );
					float4 ifLocalVar40_g128186 = 0;
					if( Resolution44_g128186 == 1024.0 )
					ifLocalVar40_g128186 = color42_g128186;
					float4 color48_g128186 = IsGammaSpace() ? float4( 1, 0.6889491, 0.07075471, 0 ) : float4( 1, 0.4324122, 0.006068094, 0 );
					float4 ifLocalVar47_g128186 = 0;
					if( Resolution44_g128186 == 2048.0 )
					ifLocalVar47_g128186 = color48_g128186;
					float4 color51_g128186 = IsGammaSpace() ? float4( 1, 0.2066492, 0.0990566, 0 ) : float4( 1, 0.03521443, 0.009877041, 0 );
					float4 ifLocalVar52_g128186 = 0;
					if( Resolution44_g128186 >= 4096.0 )
					ifLocalVar52_g128186 = color51_g128186;
					float4 ifLocalVar40_g128172 = 0;
					if( Debug_Index464_g128148 == 0.0 )
					ifLocalVar40_g128172 = ( ifLocalVar61_g128186 + ifLocalVar56_g128186 + ifLocalVar40_g128186 + ifLocalVar47_g128186 + ifLocalVar52_g128186 );
					float Resolution44_g128185 = max( _MainNormalTex_TexelSize.z, _MainNormalTex_TexelSize.w );
					float4 color62_g128185 = IsGammaSpace() ? float4( 0.484069, 0.862666, 0.9245283, 0 ) : float4( 0.1995908, 0.7155456, 0.8368256, 0 );
					float4 ifLocalVar61_g128185 = 0;
					if( Resolution44_g128185 <= 256.0 )
					ifLocalVar61_g128185 = color62_g128185;
					float4 color55_g128185 = IsGammaSpace() ? float4( 0.1933962, 0.7383016, 1, 0 ) : float4( 0.03108436, 0.5044825, 1, 0 );
					float4 ifLocalVar56_g128185 = 0;
					if( Resolution44_g128185 == 512.0 )
					ifLocalVar56_g128185 = color55_g128185;
					float4 color42_g128185 = IsGammaSpace() ? float4( 0.4431373, 0.7921569, 0.1764706, 0 ) : float4( 0.1651322, 0.5906189, 0.02624122, 0 );
					float4 ifLocalVar40_g128185 = 0;
					if( Resolution44_g128185 == 1024.0 )
					ifLocalVar40_g128185 = color42_g128185;
					float4 color48_g128185 = IsGammaSpace() ? float4( 1, 0.6889491, 0.07075471, 0 ) : float4( 1, 0.4324122, 0.006068094, 0 );
					float4 ifLocalVar47_g128185 = 0;
					if( Resolution44_g128185 == 2048.0 )
					ifLocalVar47_g128185 = color48_g128185;
					float4 color51_g128185 = IsGammaSpace() ? float4( 1, 0.2066492, 0.0990566, 0 ) : float4( 1, 0.03521443, 0.009877041, 0 );
					float4 ifLocalVar52_g128185 = 0;
					if( Resolution44_g128185 >= 4096.0 )
					ifLocalVar52_g128185 = color51_g128185;
					float4 ifLocalVar40_g128170 = 0;
					if( Debug_Index464_g128148 == 1.0 )
					ifLocalVar40_g128170 = ( ifLocalVar61_g128185 + ifLocalVar56_g128185 + ifLocalVar40_g128185 + ifLocalVar47_g128185 + ifLocalVar52_g128185 );
					float Resolution44_g128184 = max( _MainMaskTex_TexelSize.z, _MainMaskTex_TexelSize.w );
					float4 color62_g128184 = IsGammaSpace() ? float4( 0.484069, 0.862666, 0.9245283, 0 ) : float4( 0.1995908, 0.7155456, 0.8368256, 0 );
					float4 ifLocalVar61_g128184 = 0;
					if( Resolution44_g128184 <= 256.0 )
					ifLocalVar61_g128184 = color62_g128184;
					float4 color55_g128184 = IsGammaSpace() ? float4( 0.1933962, 0.7383016, 1, 0 ) : float4( 0.03108436, 0.5044825, 1, 0 );
					float4 ifLocalVar56_g128184 = 0;
					if( Resolution44_g128184 == 512.0 )
					ifLocalVar56_g128184 = color55_g128184;
					float4 color42_g128184 = IsGammaSpace() ? float4( 0.4431373, 0.7921569, 0.1764706, 0 ) : float4( 0.1651322, 0.5906189, 0.02624122, 0 );
					float4 ifLocalVar40_g128184 = 0;
					if( Resolution44_g128184 == 1024.0 )
					ifLocalVar40_g128184 = color42_g128184;
					float4 color48_g128184 = IsGammaSpace() ? float4( 1, 0.6889491, 0.07075471, 0 ) : float4( 1, 0.4324122, 0.006068094, 0 );
					float4 ifLocalVar47_g128184 = 0;
					if( Resolution44_g128184 == 2048.0 )
					ifLocalVar47_g128184 = color48_g128184;
					float4 color51_g128184 = IsGammaSpace() ? float4( 1, 0.2066492, 0.0990566, 0 ) : float4( 1, 0.03521443, 0.009877041, 0 );
					float4 ifLocalVar52_g128184 = 0;
					if( Resolution44_g128184 >= 4096.0 )
					ifLocalVar52_g128184 = color51_g128184;
					float4 ifLocalVar40_g128171 = 0;
					if( Debug_Index464_g128148 == 2.0 )
					ifLocalVar40_g128171 = ( ifLocalVar61_g128184 + ifLocalVar56_g128184 + ifLocalVar40_g128184 + ifLocalVar47_g128184 + ifLocalVar52_g128184 );
					float Resolution44_g128191 = max( _SecondAlbedoTex_TexelSize.z, _SecondAlbedoTex_TexelSize.w );
					float4 color62_g128191 = IsGammaSpace() ? float4( 0.484069, 0.862666, 0.9245283, 0 ) : float4( 0.1995908, 0.7155456, 0.8368256, 0 );
					float4 ifLocalVar61_g128191 = 0;
					if( Resolution44_g128191 <= 256.0 )
					ifLocalVar61_g128191 = color62_g128191;
					float4 color55_g128191 = IsGammaSpace() ? float4( 0.1933962, 0.7383016, 1, 0 ) : float4( 0.03108436, 0.5044825, 1, 0 );
					float4 ifLocalVar56_g128191 = 0;
					if( Resolution44_g128191 == 512.0 )
					ifLocalVar56_g128191 = color55_g128191;
					float4 color42_g128191 = IsGammaSpace() ? float4( 0.4431373, 0.7921569, 0.1764706, 0 ) : float4( 0.1651322, 0.5906189, 0.02624122, 0 );
					float4 ifLocalVar40_g128191 = 0;
					if( Resolution44_g128191 == 1024.0 )
					ifLocalVar40_g128191 = color42_g128191;
					float4 color48_g128191 = IsGammaSpace() ? float4( 1, 0.6889491, 0.07075471, 0 ) : float4( 1, 0.4324122, 0.006068094, 0 );
					float4 ifLocalVar47_g128191 = 0;
					if( Resolution44_g128191 == 2048.0 )
					ifLocalVar47_g128191 = color48_g128191;
					float4 color51_g128191 = IsGammaSpace() ? float4( 1, 0.2066492, 0.0990566, 0 ) : float4( 1, 0.03521443, 0.009877041, 0 );
					float4 ifLocalVar52_g128191 = 0;
					if( Resolution44_g128191 >= 4096.0 )
					ifLocalVar52_g128191 = color51_g128191;
					float4 ifLocalVar40_g128178 = 0;
					if( Debug_Index464_g128148 == 3.0 )
					ifLocalVar40_g128178 = ( ifLocalVar61_g128191 + ifLocalVar56_g128191 + ifLocalVar40_g128191 + ifLocalVar47_g128191 + ifLocalVar52_g128191 );
					float Resolution44_g128190 = max( _SecondMaskTex_TexelSize.z, _SecondMaskTex_TexelSize.w );
					float4 color62_g128190 = IsGammaSpace() ? float4( 0.484069, 0.862666, 0.9245283, 0 ) : float4( 0.1995908, 0.7155456, 0.8368256, 0 );
					float4 ifLocalVar61_g128190 = 0;
					if( Resolution44_g128190 <= 256.0 )
					ifLocalVar61_g128190 = color62_g128190;
					float4 color55_g128190 = IsGammaSpace() ? float4( 0.1933962, 0.7383016, 1, 0 ) : float4( 0.03108436, 0.5044825, 1, 0 );
					float4 ifLocalVar56_g128190 = 0;
					if( Resolution44_g128190 == 512.0 )
					ifLocalVar56_g128190 = color55_g128190;
					float4 color42_g128190 = IsGammaSpace() ? float4( 0.4431373, 0.7921569, 0.1764706, 0 ) : float4( 0.1651322, 0.5906189, 0.02624122, 0 );
					float4 ifLocalVar40_g128190 = 0;
					if( Resolution44_g128190 == 1024.0 )
					ifLocalVar40_g128190 = color42_g128190;
					float4 color48_g128190 = IsGammaSpace() ? float4( 1, 0.6889491, 0.07075471, 0 ) : float4( 1, 0.4324122, 0.006068094, 0 );
					float4 ifLocalVar47_g128190 = 0;
					if( Resolution44_g128190 == 2048.0 )
					ifLocalVar47_g128190 = color48_g128190;
					float4 color51_g128190 = IsGammaSpace() ? float4( 1, 0.2066492, 0.0990566, 0 ) : float4( 1, 0.03521443, 0.009877041, 0 );
					float4 ifLocalVar52_g128190 = 0;
					if( Resolution44_g128190 >= 4096.0 )
					ifLocalVar52_g128190 = color51_g128190;
					float4 ifLocalVar40_g128176 = 0;
					if( Debug_Index464_g128148 == 4.0 )
					ifLocalVar40_g128176 = ( ifLocalVar61_g128190 + ifLocalVar56_g128190 + ifLocalVar40_g128190 + ifLocalVar47_g128190 + ifLocalVar52_g128190 );
					float Resolution44_g128192 = max( _SecondAlbedoTex_TexelSize.z, _SecondAlbedoTex_TexelSize.w );
					float4 color62_g128192 = IsGammaSpace() ? float4( 0.484069, 0.862666, 0.9245283, 0 ) : float4( 0.1995908, 0.7155456, 0.8368256, 0 );
					float4 ifLocalVar61_g128192 = 0;
					if( Resolution44_g128192 <= 256.0 )
					ifLocalVar61_g128192 = color62_g128192;
					float4 color55_g128192 = IsGammaSpace() ? float4( 0.1933962, 0.7383016, 1, 0 ) : float4( 0.03108436, 0.5044825, 1, 0 );
					float4 ifLocalVar56_g128192 = 0;
					if( Resolution44_g128192 == 512.0 )
					ifLocalVar56_g128192 = color55_g128192;
					float4 color42_g128192 = IsGammaSpace() ? float4( 0.4431373, 0.7921569, 0.1764706, 0 ) : float4( 0.1651322, 0.5906189, 0.02624122, 0 );
					float4 ifLocalVar40_g128192 = 0;
					if( Resolution44_g128192 == 1024.0 )
					ifLocalVar40_g128192 = color42_g128192;
					float4 color48_g128192 = IsGammaSpace() ? float4( 1, 0.6889491, 0.07075471, 0 ) : float4( 1, 0.4324122, 0.006068094, 0 );
					float4 ifLocalVar47_g128192 = 0;
					if( Resolution44_g128192 == 2048.0 )
					ifLocalVar47_g128192 = color48_g128192;
					float4 color51_g128192 = IsGammaSpace() ? float4( 1, 0.2066492, 0.0990566, 0 ) : float4( 1, 0.03521443, 0.009877041, 0 );
					float4 ifLocalVar52_g128192 = 0;
					if( Resolution44_g128192 >= 4096.0 )
					ifLocalVar52_g128192 = color51_g128192;
					float4 ifLocalVar40_g128177 = 0;
					if( Debug_Index464_g128148 == 5.0 )
					ifLocalVar40_g128177 = ( ifLocalVar61_g128192 + ifLocalVar56_g128192 + ifLocalVar40_g128192 + ifLocalVar47_g128192 + ifLocalVar52_g128192 );
					float Resolution44_g128189 = max( _EmissiveTex_TexelSize.z, _EmissiveTex_TexelSize.w );
					float4 color62_g128189 = IsGammaSpace() ? float4( 0.484069, 0.862666, 0.9245283, 0 ) : float4( 0.1995908, 0.7155456, 0.8368256, 0 );
					float4 ifLocalVar61_g128189 = 0;
					if( Resolution44_g128189 <= 256.0 )
					ifLocalVar61_g128189 = color62_g128189;
					float4 color55_g128189 = IsGammaSpace() ? float4( 0.1933962, 0.7383016, 1, 0 ) : float4( 0.03108436, 0.5044825, 1, 0 );
					float4 ifLocalVar56_g128189 = 0;
					if( Resolution44_g128189 == 512.0 )
					ifLocalVar56_g128189 = color55_g128189;
					float4 color42_g128189 = IsGammaSpace() ? float4( 0.4431373, 0.7921569, 0.1764706, 0 ) : float4( 0.1651322, 0.5906189, 0.02624122, 0 );
					float4 ifLocalVar40_g128189 = 0;
					if( Resolution44_g128189 == 1024.0 )
					ifLocalVar40_g128189 = color42_g128189;
					float4 color48_g128189 = IsGammaSpace() ? float4( 1, 0.6889491, 0.07075471, 0 ) : float4( 1, 0.4324122, 0.006068094, 0 );
					float4 ifLocalVar47_g128189 = 0;
					if( Resolution44_g128189 == 2048.0 )
					ifLocalVar47_g128189 = color48_g128189;
					float4 color51_g128189 = IsGammaSpace() ? float4( 1, 0.2066492, 0.0990566, 0 ) : float4( 1, 0.03521443, 0.009877041, 0 );
					float4 ifLocalVar52_g128189 = 0;
					if( Resolution44_g128189 >= 4096.0 )
					ifLocalVar52_g128189 = color51_g128189;
					float4 ifLocalVar40_g128179 = 0;
					if( Debug_Index464_g128148 == 6.0 )
					ifLocalVar40_g128179 = ( ifLocalVar61_g128189 + ifLocalVar56_g128189 + ifLocalVar40_g128189 + ifLocalVar47_g128189 + ifLocalVar52_g128189 );
					float4 Output_Resolution737_g128148 = ( ( ifLocalVar40_g128172 + ifLocalVar40_g128170 + ifLocalVar40_g128171 ) + ( ifLocalVar40_g128178 + ifLocalVar40_g128176 + ifLocalVar40_g128177 ) + ifLocalVar40_g128179 );
					float4 ifLocalVar40_g128216 = 0;
					if( Debug_Type367_g128148 == 7.0 )
					ifLocalVar40_g128216 = Output_Resolution737_g128148;
					float2 uv_MainAlbedoTex65_g128197 = IN.ase_texcoord6.xy;
					float2 UVs72_g128197 = Main_UVs1219_g128148;
					float Resolution44_g128197 = max( _MainAlbedoTex_TexelSize.z, _MainAlbedoTex_TexelSize.w );
					float4 tex2DNode77_g128197 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g128197 * ( Resolution44_g128197 / 8.0 ) ) );
					float4 lerpResult78_g128197 = lerp( SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, uv_MainAlbedoTex65_g128197 ) , tex2DNode77_g128197 , tex2DNode77_g128197.a);
					float4 ifLocalVar40_g128175 = 0;
					if( Debug_Index464_g128148 == 0.0 )
					ifLocalVar40_g128175 = lerpResult78_g128197;
					float2 uv_MainNormalTex65_g128188 = IN.ase_texcoord6.xy;
					float2 UVs72_g128188 = Main_UVs1219_g128148;
					float Resolution44_g128188 = max( _MainNormalTex_TexelSize.z, _MainNormalTex_TexelSize.w );
					float4 tex2DNode77_g128188 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g128188 * ( Resolution44_g128188 / 8.0 ) ) );
					float4 lerpResult78_g128188 = lerp( SAMPLE_TEXTURE2D( _MainNormalTex, sampler_MainNormalTex, uv_MainNormalTex65_g128188 ) , tex2DNode77_g128188 , tex2DNode77_g128188.a);
					float4 ifLocalVar40_g128173 = 0;
					if( Debug_Index464_g128148 == 1.0 )
					ifLocalVar40_g128173 = lerpResult78_g128188;
					float2 uv_MainMaskTex65_g128187 = IN.ase_texcoord6.xy;
					float2 UVs72_g128187 = Main_UVs1219_g128148;
					float Resolution44_g128187 = max( _MainMaskTex_TexelSize.z, _MainMaskTex_TexelSize.w );
					float4 tex2DNode77_g128187 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g128187 * ( Resolution44_g128187 / 8.0 ) ) );
					float4 lerpResult78_g128187 = lerp( SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, uv_MainMaskTex65_g128187 ) , tex2DNode77_g128187 , tex2DNode77_g128187.a);
					float4 ifLocalVar40_g128174 = 0;
					if( Debug_Index464_g128148 == 2.0 )
					ifLocalVar40_g128174 = lerpResult78_g128187;
					float2 uv_SecondAlbedoTex65_g128195 = IN.ase_texcoord6.xy;
					float2 UVs72_g128195 = Layer_02_UVs1234_g128148;
					float Resolution44_g128195 = max( _SecondAlbedoTex_TexelSize.z, _SecondAlbedoTex_TexelSize.w );
					float4 tex2DNode77_g128195 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g128195 * ( Resolution44_g128195 / 8.0 ) ) );
					float4 lerpResult78_g128195 = lerp( SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, uv_SecondAlbedoTex65_g128195 ) , tex2DNode77_g128195 , tex2DNode77_g128195.a);
					float4 ifLocalVar40_g128182 = 0;
					if( Debug_Index464_g128148 == 3.0 )
					ifLocalVar40_g128182 = lerpResult78_g128195;
					float2 uv_SecondMaskTex65_g128194 = IN.ase_texcoord6.xy;
					float2 UVs72_g128194 = Layer_02_UVs1234_g128148;
					float Resolution44_g128194 = max( _SecondMaskTex_TexelSize.z, _SecondMaskTex_TexelSize.w );
					float4 tex2DNode77_g128194 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g128194 * ( Resolution44_g128194 / 8.0 ) ) );
					float4 lerpResult78_g128194 = lerp( SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, uv_SecondMaskTex65_g128194 ) , tex2DNode77_g128194 , tex2DNode77_g128194.a);
					float4 ifLocalVar40_g128180 = 0;
					if( Debug_Index464_g128148 == 4.0 )
					ifLocalVar40_g128180 = lerpResult78_g128194;
					float2 uv_SecondAlbedoTex65_g128196 = IN.ase_texcoord6.xy;
					float2 UVs72_g128196 = Layer_02_UVs1234_g128148;
					float Resolution44_g128196 = max( _SecondAlbedoTex_TexelSize.z, _SecondAlbedoTex_TexelSize.w );
					float4 tex2DNode77_g128196 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g128196 * ( Resolution44_g128196 / 8.0 ) ) );
					float4 lerpResult78_g128196 = lerp( SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, uv_SecondAlbedoTex65_g128196 ) , tex2DNode77_g128196 , tex2DNode77_g128196.a);
					float4 ifLocalVar40_g128181 = 0;
					if( Debug_Index464_g128148 == 5.0 )
					ifLocalVar40_g128181 = lerpResult78_g128196;
					float2 uv_EmissiveTex65_g128193 = IN.ase_texcoord6.xy;
					float2 UVs72_g128193 = Emissive_UVs1245_g128148;
					float Resolution44_g128193 = max( _EmissiveTex_TexelSize.z, _EmissiveTex_TexelSize.w );
					float4 tex2DNode77_g128193 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g128193 * ( Resolution44_g128193 / 8.0 ) ) );
					float4 lerpResult78_g128193 = lerp( SAMPLE_TEXTURE2D( _EmissiveTex, sampler_EmissiveTex, uv_EmissiveTex65_g128193 ) , tex2DNode77_g128193 , tex2DNode77_g128193.a);
					float4 ifLocalVar40_g128183 = 0;
					if( Debug_Index464_g128148 == 6.0 )
					ifLocalVar40_g128183 = lerpResult78_g128193;
					float4 Output_MipLevel1284_g128148 = ( ( ifLocalVar40_g128175 + ifLocalVar40_g128173 + ifLocalVar40_g128174 ) + ( ifLocalVar40_g128182 + ifLocalVar40_g128180 + ifLocalVar40_g128181 ) + ifLocalVar40_g128183 );
					float4 ifLocalVar40_g128217 = 0;
					if( Debug_Type367_g128148 == 8.0 )
					ifLocalVar40_g128217 = Output_MipLevel1284_g128148;
					float ifLocalVar40_g128375 = 0;
					if( Debug_Index464_g128148 == 0.0 )
					ifLocalVar40_g128375 = (float3( 0,0,0 )).z;
					float4 temp_output_203_0_g128239 = TVE_CoatBaseCoord;
					float3 WorldPosition893_g128148 = PositionWS;
					float2 temp_output_81_0_g128239 = WorldPosition893_g128148.xy;
					float Debug_Layer885_g128148 = TVE_DEBUG_Layer;
					float temp_output_82_0_g128237 = Debug_Layer885_g128148;
					float temp_output_82_0_g128239 = temp_output_82_0_g128237;
					float4 tex2DArrayNode83_g128239 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128239).zw + ( (temp_output_203_0_g128239).xy * temp_output_81_0_g128239 ) ),temp_output_82_0_g128239) );
					float4 appendResult210_g128239 = (float4(tex2DArrayNode83_g128239.rgb , saturate( tex2DArrayNode83_g128239.a )));
					float4 temp_output_204_0_g128239 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g128239 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128239).zw + ( (temp_output_204_0_g128239).xy * temp_output_81_0_g128239 ) ),temp_output_82_0_g128239) );
					float4 appendResult212_g128239 = (float4(tex2DArrayNode122_g128239.rgb , saturate( tex2DArrayNode122_g128239.a )));
					float4 lerpResult131_g128239 = lerp( appendResult210_g128239 , appendResult212_g128239 , 0.0);
					float4 temp_output_159_109_g128237 = lerpResult131_g128239;
					float4 lerpResult168_g128237 = lerp( TVE_CoatParams , temp_output_159_109_g128237 , TVE_CoatLayers[(int)temp_output_82_0_g128237]);
					float ifLocalVar40_g128253 = 0;
					if( Debug_Index464_g128148 == 1.0 )
					ifLocalVar40_g128253 = (lerpResult168_g128237).y;
					float4 temp_output_203_0_g128247 = TVE_CoatBaseCoord;
					float2 temp_output_81_0_g128247 = WorldPosition893_g128148.xy;
					float temp_output_82_0_g128245 = Debug_Layer885_g128148;
					float temp_output_82_0_g128247 = temp_output_82_0_g128245;
					float4 tex2DArrayNode83_g128247 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128247).zw + ( (temp_output_203_0_g128247).xy * temp_output_81_0_g128247 ) ),temp_output_82_0_g128247) );
					float4 appendResult210_g128247 = (float4(tex2DArrayNode83_g128247.rgb , saturate( tex2DArrayNode83_g128247.a )));
					float4 temp_output_204_0_g128247 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g128247 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128247).zw + ( (temp_output_204_0_g128247).xy * temp_output_81_0_g128247 ) ),temp_output_82_0_g128247) );
					float4 appendResult212_g128247 = (float4(tex2DArrayNode122_g128247.rgb , saturate( tex2DArrayNode122_g128247.a )));
					float4 lerpResult131_g128247 = lerp( appendResult210_g128247 , appendResult212_g128247 , 0.0);
					float4 temp_output_159_109_g128245 = lerpResult131_g128247;
					float4 lerpResult168_g128245 = lerp( TVE_CoatParams , temp_output_159_109_g128245 , TVE_CoatLayers[(int)temp_output_82_0_g128245]);
					float ifLocalVar40_g128254 = 0;
					if( Debug_Index464_g128148 == 2.0 )
					ifLocalVar40_g128254 = (lerpResult168_g128245).z;
					float4 temp_output_203_0_g128266 = TVE_PaintBaseCoord;
					float2 temp_output_81_0_g128266 = WorldPosition893_g128148.xy;
					float temp_output_82_0_g128263 = Debug_Layer885_g128148;
					float temp_output_82_0_g128266 = temp_output_82_0_g128263;
					float4 tex2DArrayNode83_g128266 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128266).zw + ( (temp_output_203_0_g128266).xy * temp_output_81_0_g128266 ) ),temp_output_82_0_g128266) );
					float4 appendResult210_g128266 = (float4(tex2DArrayNode83_g128266.rgb , saturate( tex2DArrayNode83_g128266.a )));
					float4 temp_output_204_0_g128266 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g128266 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128266).zw + ( (temp_output_204_0_g128266).xy * temp_output_81_0_g128266 ) ),temp_output_82_0_g128266) );
					float4 appendResult212_g128266 = (float4(tex2DArrayNode122_g128266.rgb , saturate( tex2DArrayNode122_g128266.a )));
					float4 lerpResult131_g128266 = lerp( appendResult210_g128266 , appendResult212_g128266 , 0.0);
					float4 temp_output_171_109_g128263 = lerpResult131_g128266;
					float4 lerpResult174_g128263 = lerp( TVE_PaintParams , temp_output_171_109_g128263 , TVE_PaintLayers[(int)temp_output_82_0_g128263]);
					float3 ifLocalVar40_g128271 = 0;
					if( Debug_Index464_g128148 == 3.0 )
					ifLocalVar40_g128271 = (lerpResult174_g128263).xyz;
					float4 temp_output_203_0_g128258 = TVE_PaintBaseCoord;
					float2 temp_output_81_0_g128258 = WorldPosition893_g128148.xy;
					float temp_output_82_0_g128255 = Debug_Layer885_g128148;
					float temp_output_82_0_g128258 = temp_output_82_0_g128255;
					float4 tex2DArrayNode83_g128258 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128258).zw + ( (temp_output_203_0_g128258).xy * temp_output_81_0_g128258 ) ),temp_output_82_0_g128258) );
					float4 appendResult210_g128258 = (float4(tex2DArrayNode83_g128258.rgb , saturate( tex2DArrayNode83_g128258.a )));
					float4 temp_output_204_0_g128258 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g128258 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128258).zw + ( (temp_output_204_0_g128258).xy * temp_output_81_0_g128258 ) ),temp_output_82_0_g128258) );
					float4 appendResult212_g128258 = (float4(tex2DArrayNode122_g128258.rgb , saturate( tex2DArrayNode122_g128258.a )));
					float4 lerpResult131_g128258 = lerp( appendResult210_g128258 , appendResult212_g128258 , 0.0);
					float4 temp_output_171_109_g128255 = lerpResult131_g128258;
					float4 lerpResult174_g128255 = lerp( TVE_PaintParams , temp_output_171_109_g128255 , TVE_PaintLayers[(int)temp_output_82_0_g128255]);
					float ifLocalVar40_g128272 = 0;
					if( Debug_Index464_g128148 == 4.0 )
					ifLocalVar40_g128272 = saturate( (lerpResult174_g128255).w );
					float4 temp_output_203_0_g128275 = TVE_GlowBaseCoord;
					float2 temp_output_81_0_g128275 = WorldPosition893_g128148.xy;
					float temp_output_82_0_g128273 = Debug_Layer885_g128148;
					float temp_output_82_0_g128275 = temp_output_82_0_g128273;
					float4 tex2DArrayNode83_g128275 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128275).zw + ( (temp_output_203_0_g128275).xy * temp_output_81_0_g128275 ) ),temp_output_82_0_g128275) );
					float4 appendResult210_g128275 = (float4(tex2DArrayNode83_g128275.rgb , saturate( tex2DArrayNode83_g128275.a )));
					float4 temp_output_204_0_g128275 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g128275 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128275).zw + ( (temp_output_204_0_g128275).xy * temp_output_81_0_g128275 ) ),temp_output_82_0_g128275) );
					float4 appendResult212_g128275 = (float4(tex2DArrayNode122_g128275.rgb , saturate( tex2DArrayNode122_g128275.a )));
					float4 lerpResult131_g128275 = lerp( appendResult210_g128275 , appendResult212_g128275 , 0.0);
					float4 temp_output_159_109_g128273 = lerpResult131_g128275;
					float4 lerpResult167_g128273 = lerp( TVE_GlowParams , temp_output_159_109_g128273 , TVE_GlowLayers[(int)temp_output_82_0_g128273]);
					float3 ifLocalVar40_g128337 = 0;
					if( Debug_Index464_g128148 == 5.0 )
					ifLocalVar40_g128337 = (lerpResult167_g128273).xyz;
					float4 temp_output_203_0_g128331 = TVE_GlowBaseCoord;
					float2 temp_output_81_0_g128331 = WorldPosition893_g128148.xy;
					float temp_output_82_0_g128329 = Debug_Layer885_g128148;
					float temp_output_82_0_g128331 = temp_output_82_0_g128329;
					float4 tex2DArrayNode83_g128331 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128331).zw + ( (temp_output_203_0_g128331).xy * temp_output_81_0_g128331 ) ),temp_output_82_0_g128331) );
					float4 appendResult210_g128331 = (float4(tex2DArrayNode83_g128331.rgb , saturate( tex2DArrayNode83_g128331.a )));
					float4 temp_output_204_0_g128331 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g128331 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128331).zw + ( (temp_output_204_0_g128331).xy * temp_output_81_0_g128331 ) ),temp_output_82_0_g128331) );
					float4 appendResult212_g128331 = (float4(tex2DArrayNode122_g128331.rgb , saturate( tex2DArrayNode122_g128331.a )));
					float4 lerpResult131_g128331 = lerp( appendResult210_g128331 , appendResult212_g128331 , 0.0);
					float4 temp_output_159_109_g128329 = lerpResult131_g128331;
					float4 lerpResult167_g128329 = lerp( TVE_GlowParams , temp_output_159_109_g128329 , TVE_GlowLayers[(int)temp_output_82_0_g128329]);
					float ifLocalVar40_g128338 = 0;
					if( Debug_Index464_g128148 == 6.0 )
					ifLocalVar40_g128338 = saturate( (lerpResult167_g128329).w );
					float4 temp_output_203_0_g128307 = TVE_AtmoBaseCoord;
					float2 temp_output_81_0_g128307 = WorldPosition893_g128148.xy;
					float temp_output_132_0_g128305 = Debug_Layer885_g128148;
					float temp_output_82_0_g128307 = temp_output_132_0_g128305;
					float4 tex2DArrayNode83_g128307 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128307).zw + ( (temp_output_203_0_g128307).xy * temp_output_81_0_g128307 ) ),temp_output_82_0_g128307) );
					float4 appendResult210_g128307 = (float4(tex2DArrayNode83_g128307.rgb , saturate( tex2DArrayNode83_g128307.a )));
					float4 temp_output_204_0_g128307 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g128307 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128307).zw + ( (temp_output_204_0_g128307).xy * temp_output_81_0_g128307 ) ),temp_output_82_0_g128307) );
					float4 appendResult212_g128307 = (float4(tex2DArrayNode122_g128307.rgb , saturate( tex2DArrayNode122_g128307.a )));
					float4 lerpResult131_g128307 = lerp( appendResult210_g128307 , appendResult212_g128307 , 0.0);
					float4 temp_output_137_109_g128305 = lerpResult131_g128307;
					float4 lerpResult145_g128305 = lerp( TVE_AtmoParams , temp_output_137_109_g128305 , TVE_AtmoLayers[(int)temp_output_132_0_g128305]);
					float ifLocalVar40_g128339 = 0;
					if( Debug_Index464_g128148 == 7.0 )
					ifLocalVar40_g128339 = (lerpResult145_g128305).x;
					float4 temp_output_203_0_g128283 = TVE_AtmoBaseCoord;
					float2 temp_output_81_0_g128283 = WorldPosition893_g128148.xy;
					float temp_output_132_0_g128281 = Debug_Layer885_g128148;
					float temp_output_82_0_g128283 = temp_output_132_0_g128281;
					float4 tex2DArrayNode83_g128283 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128283).zw + ( (temp_output_203_0_g128283).xy * temp_output_81_0_g128283 ) ),temp_output_82_0_g128283) );
					float4 appendResult210_g128283 = (float4(tex2DArrayNode83_g128283.rgb , saturate( tex2DArrayNode83_g128283.a )));
					float4 temp_output_204_0_g128283 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g128283 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128283).zw + ( (temp_output_204_0_g128283).xy * temp_output_81_0_g128283 ) ),temp_output_82_0_g128283) );
					float4 appendResult212_g128283 = (float4(tex2DArrayNode122_g128283.rgb , saturate( tex2DArrayNode122_g128283.a )));
					float4 lerpResult131_g128283 = lerp( appendResult210_g128283 , appendResult212_g128283 , 0.0);
					float4 temp_output_137_109_g128281 = lerpResult131_g128283;
					float4 lerpResult145_g128281 = lerp( TVE_AtmoParams , temp_output_137_109_g128281 , TVE_AtmoLayers[(int)temp_output_132_0_g128281]);
					float ifLocalVar40_g128340 = 0;
					if( Debug_Index464_g128148 == 8.0 )
					ifLocalVar40_g128340 = (lerpResult145_g128281).y;
					float4 temp_output_203_0_g128291 = TVE_AtmoBaseCoord;
					float2 temp_output_81_0_g128291 = WorldPosition893_g128148.xy;
					float temp_output_132_0_g128289 = Debug_Layer885_g128148;
					float temp_output_82_0_g128291 = temp_output_132_0_g128289;
					float4 tex2DArrayNode83_g128291 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128291).zw + ( (temp_output_203_0_g128291).xy * temp_output_81_0_g128291 ) ),temp_output_82_0_g128291) );
					float4 appendResult210_g128291 = (float4(tex2DArrayNode83_g128291.rgb , saturate( tex2DArrayNode83_g128291.a )));
					float4 temp_output_204_0_g128291 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g128291 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128291).zw + ( (temp_output_204_0_g128291).xy * temp_output_81_0_g128291 ) ),temp_output_82_0_g128291) );
					float4 appendResult212_g128291 = (float4(tex2DArrayNode122_g128291.rgb , saturate( tex2DArrayNode122_g128291.a )));
					float4 lerpResult131_g128291 = lerp( appendResult210_g128291 , appendResult212_g128291 , 0.0);
					float4 temp_output_137_109_g128289 = lerpResult131_g128291;
					float4 lerpResult145_g128289 = lerp( TVE_AtmoParams , temp_output_137_109_g128289 , TVE_AtmoLayers[(int)temp_output_132_0_g128289]);
					float ifLocalVar40_g128341 = 0;
					if( Debug_Index464_g128148 == 9.0 )
					ifLocalVar40_g128341 = (lerpResult145_g128289).z;
					float4 temp_output_203_0_g128299 = TVE_AtmoBaseCoord;
					float2 temp_output_81_0_g128299 = WorldPosition893_g128148.xy;
					float temp_output_132_0_g128297 = Debug_Layer885_g128148;
					float temp_output_82_0_g128299 = temp_output_132_0_g128297;
					float4 tex2DArrayNode83_g128299 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128299).zw + ( (temp_output_203_0_g128299).xy * temp_output_81_0_g128299 ) ),temp_output_82_0_g128299) );
					float4 appendResult210_g128299 = (float4(tex2DArrayNode83_g128299.rgb , saturate( tex2DArrayNode83_g128299.a )));
					float4 temp_output_204_0_g128299 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g128299 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128299).zw + ( (temp_output_204_0_g128299).xy * temp_output_81_0_g128299 ) ),temp_output_82_0_g128299) );
					float4 appendResult212_g128299 = (float4(tex2DArrayNode122_g128299.rgb , saturate( tex2DArrayNode122_g128299.a )));
					float4 lerpResult131_g128299 = lerp( appendResult210_g128299 , appendResult212_g128299 , 0.0);
					float4 temp_output_137_109_g128297 = lerpResult131_g128299;
					float4 lerpResult145_g128297 = lerp( TVE_AtmoParams , temp_output_137_109_g128297 , TVE_AtmoLayers[(int)temp_output_132_0_g128297]);
					float ifLocalVar40_g128342 = 0;
					if( Debug_Index464_g128148 == 10.0 )
					ifLocalVar40_g128342 = saturate( (lerpResult145_g128297).w );
					float4 temp_output_203_0_g128323 = TVE_FormBaseCoord;
					float2 temp_output_81_0_g128323 = WorldPosition893_g128148.xy;
					float temp_output_130_0_g128321 = Debug_Layer885_g128148;
					float temp_output_82_0_g128323 = temp_output_130_0_g128321;
					float4 tex2DArrayNode83_g128323 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128323).zw + ( (temp_output_203_0_g128323).xy * temp_output_81_0_g128323 ) ),temp_output_82_0_g128323) );
					float4 appendResult210_g128323 = (float4(tex2DArrayNode83_g128323.rgb , saturate( tex2DArrayNode83_g128323.a )));
					float4 temp_output_204_0_g128323 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g128323 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128323).zw + ( (temp_output_204_0_g128323).xy * temp_output_81_0_g128323 ) ),temp_output_82_0_g128323) );
					float4 appendResult212_g128323 = (float4(tex2DArrayNode122_g128323.rgb , saturate( tex2DArrayNode122_g128323.a )));
					float4 lerpResult131_g128323 = lerp( appendResult210_g128323 , appendResult212_g128323 , 0.0);
					float4 temp_output_135_109_g128321 = lerpResult131_g128323;
					float4 lerpResult143_g128321 = lerp( TVE_FormParams , temp_output_135_109_g128321 , TVE_FormLayers[(int)temp_output_130_0_g128321]);
					float3 appendResult1013_g128148 = (float3((lerpResult143_g128321).xy , 0.0));
					float3 ifLocalVar40_g128343 = 0;
					if( Debug_Index464_g128148 == 11.0 )
					ifLocalVar40_g128343 = appendResult1013_g128148;
					float4 temp_output_203_0_g128315 = TVE_FormBaseCoord;
					float2 temp_output_81_0_g128315 = WorldPosition893_g128148.xy;
					float temp_output_130_0_g128313 = Debug_Layer885_g128148;
					float temp_output_82_0_g128315 = temp_output_130_0_g128313;
					float4 tex2DArrayNode83_g128315 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128315).zw + ( (temp_output_203_0_g128315).xy * temp_output_81_0_g128315 ) ),temp_output_82_0_g128315) );
					float4 appendResult210_g128315 = (float4(tex2DArrayNode83_g128315.rgb , saturate( tex2DArrayNode83_g128315.a )));
					float4 temp_output_204_0_g128315 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g128315 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128315).zw + ( (temp_output_204_0_g128315).xy * temp_output_81_0_g128315 ) ),temp_output_82_0_g128315) );
					float4 appendResult212_g128315 = (float4(tex2DArrayNode122_g128315.rgb , saturate( tex2DArrayNode122_g128315.a )));
					float4 lerpResult131_g128315 = lerp( appendResult210_g128315 , appendResult212_g128315 , 0.0);
					float4 temp_output_135_109_g128313 = lerpResult131_g128315;
					float4 lerpResult143_g128313 = lerp( TVE_FormParams , temp_output_135_109_g128313 , TVE_FormLayers[(int)temp_output_130_0_g128313]);
					float ifLocalVar40_g128344 = 0;
					if( Debug_Index464_g128148 == 12.0 )
					ifLocalVar40_g128344 = saturate( (lerpResult143_g128313).z );
					float4 temp_output_203_0_g128367 = TVE_FormBaseCoord;
					float2 temp_output_81_0_g128367 = WorldPosition893_g128148.xy;
					float temp_output_130_0_g128365 = Debug_Layer885_g128148;
					float temp_output_82_0_g128367 = temp_output_130_0_g128365;
					float4 tex2DArrayNode83_g128367 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128367).zw + ( (temp_output_203_0_g128367).xy * temp_output_81_0_g128367 ) ),temp_output_82_0_g128367) );
					float4 appendResult210_g128367 = (float4(tex2DArrayNode83_g128367.rgb , saturate( tex2DArrayNode83_g128367.a )));
					float4 temp_output_204_0_g128367 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g128367 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128367).zw + ( (temp_output_204_0_g128367).xy * temp_output_81_0_g128367 ) ),temp_output_82_0_g128367) );
					float4 appendResult212_g128367 = (float4(tex2DArrayNode122_g128367.rgb , saturate( tex2DArrayNode122_g128367.a )));
					float4 lerpResult131_g128367 = lerp( appendResult210_g128367 , appendResult212_g128367 , 0.0);
					float4 temp_output_135_109_g128365 = lerpResult131_g128367;
					float4 lerpResult143_g128365 = lerp( TVE_FormParams , temp_output_135_109_g128365 , TVE_FormLayers[(int)temp_output_130_0_g128365]);
					float ifLocalVar40_g128373 = 0;
					if( Debug_Index464_g128148 == 13.0 )
					ifLocalVar40_g128373 = saturate( (lerpResult143_g128365).w );
					float4 temp_output_203_0_g128347 = TVE_FlowBaseCoord;
					float2 temp_output_81_0_g128347 = WorldPosition893_g128148.xy;
					float temp_output_136_0_g128345 = Debug_Layer885_g128148;
					float temp_output_82_0_g128347 = temp_output_136_0_g128345;
					float4 tex2DArrayNode83_g128347 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128347).zw + ( (temp_output_203_0_g128347).xy * temp_output_81_0_g128347 ) ),temp_output_82_0_g128347) );
					float4 appendResult210_g128347 = (float4(tex2DArrayNode83_g128347.rgb , saturate( tex2DArrayNode83_g128347.a )));
					float4 temp_output_204_0_g128347 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g128347 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128347).zw + ( (temp_output_204_0_g128347).xy * temp_output_81_0_g128347 ) ),temp_output_82_0_g128347) );
					float4 appendResult212_g128347 = (float4(tex2DArrayNode122_g128347.rgb , saturate( tex2DArrayNode122_g128347.a )));
					float4 lerpResult131_g128347 = lerp( appendResult210_g128347 , appendResult212_g128347 , 0.0);
					float4 temp_output_141_109_g128345 = lerpResult131_g128347;
					float4 lerpResult149_g128345 = lerp( TVE_FlowParams , temp_output_141_109_g128345 , TVE_FlowLayers[(int)temp_output_136_0_g128345]);
					float3 appendResult1012_g128148 = (float3((lerpResult149_g128345).xy , 0.0));
					float3 ifLocalVar40_g128361 = 0;
					if( Debug_Index464_g128148 == 14.0 )
					ifLocalVar40_g128361 = appendResult1012_g128148;
					float4 temp_output_203_0_g128355 = TVE_FlowBaseCoord;
					float2 temp_output_81_0_g128355 = WorldPosition893_g128148.xy;
					float temp_output_136_0_g128353 = Debug_Layer885_g128148;
					float temp_output_82_0_g128355 = temp_output_136_0_g128353;
					float4 tex2DArrayNode83_g128355 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128355).zw + ( (temp_output_203_0_g128355).xy * temp_output_81_0_g128355 ) ),temp_output_82_0_g128355) );
					float4 appendResult210_g128355 = (float4(tex2DArrayNode83_g128355.rgb , saturate( tex2DArrayNode83_g128355.a )));
					float4 temp_output_204_0_g128355 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g128355 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128355).zw + ( (temp_output_204_0_g128355).xy * temp_output_81_0_g128355 ) ),temp_output_82_0_g128355) );
					float4 appendResult212_g128355 = (float4(tex2DArrayNode122_g128355.rgb , saturate( tex2DArrayNode122_g128355.a )));
					float4 lerpResult131_g128355 = lerp( appendResult210_g128355 , appendResult212_g128355 , 0.0);
					float4 temp_output_141_109_g128353 = lerpResult131_g128355;
					float4 lerpResult149_g128353 = lerp( TVE_FlowParams , temp_output_141_109_g128353 , TVE_FlowLayers[(int)temp_output_136_0_g128353]);
					float ifLocalVar40_g128362 = 0;
					if( Debug_Index464_g128148 == 15.0 )
					ifLocalVar40_g128362 = (lerpResult149_g128353).z;
					float3 appendResult1780_g128148 = (float3((float4( 0,0,0,0 )).rg , 0.0));
					float3 ifLocalVar40_g128363 = 0;
					if( Debug_Index464_g128148 == 16.0 )
					ifLocalVar40_g128363 = appendResult1780_g128148;
					float ifLocalVar40_g128364 = 0;
					if( Debug_Index464_g128148 == 17.0 )
					ifLocalVar40_g128364 = (float4( 0,0,0,0 )).b;
					float ifLocalVar40_g128374 = 0;
					if( Debug_Index464_g128148 == 18.0 )
					ifLocalVar40_g128374 = saturate( (float4( 0,0,0,0 )).a );
					float temp_output_7_0_g128388 = Debug_Min721_g128148;
					float3 temp_cast_35 = (temp_output_7_0_g128388).xxx;
					float3 temp_output_9_0_g128388 = ( ( ifLocalVar40_g128375 + ( ifLocalVar40_g128253 + ifLocalVar40_g128254 ) + ( ifLocalVar40_g128271 + ifLocalVar40_g128272 ) + ( ifLocalVar40_g128337 + ifLocalVar40_g128338 ) + ( ifLocalVar40_g128339 + ifLocalVar40_g128340 + ifLocalVar40_g128341 + ifLocalVar40_g128342 ) + ( ifLocalVar40_g128343 + ifLocalVar40_g128344 + ifLocalVar40_g128373 ) + ( ifLocalVar40_g128361 + ifLocalVar40_g128362 + ifLocalVar40_g128363 + ifLocalVar40_g128364 + ifLocalVar40_g128374 ) ) - temp_cast_35 );
					float4 appendResult1659_g128148 = (float4(saturate( ( temp_output_9_0_g128388 / ( ( Debug_Max723_g128148 - temp_output_7_0_g128388 ) + 0.0001 ) ) ) , 1.0));
					float4 Output_Globals888_g128148 = appendResult1659_g128148;
					float4 ifLocalVar40_g128218 = 0;
					if( Debug_Type367_g128148 == 9.0 )
					ifLocalVar40_g128218 = Output_Globals888_g128148;
					float3 vertexToFrag328_g128148 = IN.ase_texcoord8.xyz;
					float4 color1016_g128148 = IsGammaSpace() ? float4( 0.5831653, 0.6037736, 0.2135992, 0 ) : float4( 0.2992498, 0.3229691, 0.03750122, 0 );
					float4 color1017_g128148 = IsGammaSpace() ? float4( 0.8117647, 0.3488252, 0.2627451, 0 ) : float4( 0.6239604, 0.0997834, 0.05612849, 0 );
					float4 switchResult1015_g128148 = (((ase_vface>0)?(color1016_g128148):(color1017_g128148)));
					float3 ifLocalVar40_g128152 = 0;
					if( Debug_Index464_g128148 == 4.0 )
					ifLocalVar40_g128152 = (switchResult1015_g128148).rgb;
					float temp_output_7_0_g128208 = Debug_Min721_g128148;
					float3 temp_cast_36 = (temp_output_7_0_g128208).xxx;
					float3 temp_output_9_0_g128208 = ( ( vertexToFrag328_g128148 + ifLocalVar40_g128152 ) - temp_cast_36 );
					float4 appendResult1658_g128148 = (float4(saturate( ( temp_output_9_0_g128208 / ( ( Debug_Max723_g128148 - temp_output_7_0_g128208 ) + 0.0001 ) ) ) , 1.0));
					float4 Output_Mesh316_g128148 = appendResult1658_g128148;
					float4 ifLocalVar40_g128220 = 0;
					if( Debug_Type367_g128148 == 11.0 )
					ifLocalVar40_g128220 = Output_Mesh316_g128148;
					float _IsTVEShader647_g128148 = _IsTVEShader;
					float Debug_Filter322_g128148 = TVE_DEBUG_Filter;
					float lerpResult1524_g128148 = lerp( 1.0 , _IsTVEShader647_g128148 , Debug_Filter322_g128148);
					float4 lerpResult1517_g128148 = lerp( Shading_Inactive1492_g128148 , ( ( ifLocalVar40_g128209 + ifLocalVar40_g128211 + ifLocalVar40_g128212 + ifLocalVar40_g128213 + ifLocalVar40_g128214 ) + ( ifLocalVar40_g128215 + ifLocalVar40_g128216 + ifLocalVar40_g128217 ) + ( ifLocalVar40_g128218 + ifLocalVar40_g128220 ) ) , lerpResult1524_g128148);
					float dotResult1472_g128148 = dot( NormalWS , ViewDirWS );
					float temp_output_1526_0_g128148 = ( 1.0 - saturate( dotResult1472_g128148 ) );
					float Shading_Fresnel1469_g128148 = (( 1.0 - ( temp_output_1526_0_g128148 * temp_output_1526_0_g128148 ) )*0.3 + 0.7);
					float Debug_Shading1653_g128148 = TVE_DEBUG_Shading;
					float lerpResult1655_g128148 = lerp( 1.0 , Shading_Fresnel1469_g128148 , Debug_Shading1653_g128148);
					float2 uv_MainAlbedoTex728_g128148 = IN.ase_texcoord6.xy;
					float Debug_Clip623_g128148 = TVE_DEBUG_Clip;
					float lerpResult622_g128148 = lerp( 1.0 , SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, uv_MainAlbedoTex728_g128148 ).a , ( Debug_Clip623_g128148 * _RenderClip ));
					clip( lerpResult622_g128148 - _MainAlphaClipValue);
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = half3( 0, 0, 0 );
					half Metallic = 0.0;
					half Smoothness = 0.0;
					half Occlusion = 1;

					#if defined(ASE_LIGHTING_SIMPLE)
						o.Specular = Specular.x;
						o.Gloss = Smoothness;
					#else
						#if defined(_SPECULAR_SETUP)
							o.Specular = Specular;
						#else
							o.Metallic = Metallic;
						#endif
						o.Occlusion = Occlusion;
						o.Smoothness = Smoothness;
					#endif

					o.Emission = ( lerpResult1517_g128148 * lerpResult1655_g128148 ).rgb;
					o.Alpha = 1;
					half3 BakedGI = 0;
					half3 Transmission = 1;
					half3 Translucency = 1;

					#if defined( ASE_DEPTH_WRITE_ON )
						float DeviceDepth = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( o.Alpha - AlphaClipThreshold );
					#endif

					#if defined( ASE_CHANGES_WORLD_POS )
					{
						#if defined( ASE_RECEIVE_SHADOWS )
							UNITY_LIGHT_ATTENUATION( temp, IN, PositionWS )
							LightAtten = temp;
						#else
							LightAtten = 1;
						#endif
					}
					#endif

					#if ( ASE_FRAGMENT_NORMAL == 0 )
						o.Normal = normalize( o.Normal.x * TangentWS + o.Normal.y * BitangentWS + o.Normal.z * NormalWS );
					#elif ( ASE_FRAGMENT_NORMAL == 1 )
						o.Normal = UnityObjectToWorldNormal( o.Normal );
					#elif ( ASE_FRAGMENT_NORMAL == 2 )
						// @diogo: already in world-space; do nothing
					#endif

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = DeviceDepth;
					#endif

					#ifndef USING_DIRECTIONAL_LIGHT
						half3 lightDir = normalize( UnityWorldSpaceLightDir( PositionWS ) );
					#else
						half3 lightDir = _WorldSpaceLightPos0.xyz;
					#endif

					UnityGI gi;
					UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
					gi.indirect.diffuse = 0;
					gi.indirect.specular = 0;
					gi.light.color = _LightColor0.rgb;
					gi.light.dir = lightDir;

					UnityGIInput giInput;
					UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
					giInput.light = gi.light;
					giInput.worldPos = PositionWS;
					giInput.worldViewDir = ViewDirWS;
					giInput.atten = atten;
					#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
						giInput.lightmapUV = IN.ambientOrLightmapUV;
					#else
						giInput.lightmapUV = 0.0;
					#endif
					#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
						giInput.ambient = IN.ambientOrLightmapUV.rgb;
					#else
						giInput.ambient.rgb = 0.0;
					#endif
					giInput.probeHDR[0] = unity_SpecCube0_HDR;
					giInput.probeHDR[1] = unity_SpecCube1_HDR;
					#if defined(UNITY_SPECCUBE_BLENDING) || defined(UNITY_SPECCUBE_BOX_PROJECTION)
						giInput.boxMin[0] = unity_SpecCube0_BoxMin;
					#endif
					#ifdef UNITY_SPECCUBE_BOX_PROJECTION
						giInput.boxMax[0] = unity_SpecCube0_BoxMax;
						giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
						giInput.boxMax[1] = unity_SpecCube1_BoxMax;
						giInput.boxMin[1] = unity_SpecCube1_BoxMin;
						giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
					#endif

					#if defined(ASE_LIGHTING_SIMPLE)
						#if defined(_SPECULAR_SETUP)
							LightingBlinnPhong_GI(o, giInput, gi);
						#else
							LightingLambert_GI(o, giInput, gi);
						#endif
					#else
						#if defined(_SPECULAR_SETUP)
							LightingStandardSpecular_GI(o, giInput, gi);
						#else
							LightingStandard_GI(o, giInput, gi);
						#endif
					#endif

					#ifdef ASE_BAKEDGI
						gi.indirect.diffuse = BakedGI;
					#endif

					#if UNITY_SHOULD_SAMPLE_SH && !defined(LIGHTMAP_ON) && defined(ASE_NO_AMBIENT)
						gi.indirect.diffuse = 0;
					#endif

					half4 c = 0;
					#if defined(ASE_LIGHTING_SIMPLE)
						#if defined(_SPECULAR_SETUP)
							c += LightingBlinnPhong (o, ViewDirWS, gi);
						#else
							c += LightingLambert( o, gi );
						#endif
					#else
						#if defined(_SPECULAR_SETUP)
							c += LightingStandardSpecular (o, ViewDirWS, gi);
						#else
							c += LightingStandard(o, ViewDirWS, gi);
						#endif
					#endif

					#ifdef ASE_TRANSMISSION
					{
						half shadow = _TransmissionShadow;
						#ifdef DIRECTIONAL
							half3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, shadow );
						#else
							half3 lightAtten = gi.light.color;
						#endif
						half3 transmission = max(0 , -dot(o.Normal, gi.light.dir)) * lightAtten * Transmission;
						c.rgb += o.Albedo * transmission;
					}
					#endif

					#ifdef ASE_TRANSLUCENCY
					{
						half shadow = _TransShadow;
						half normal = _TransNormal;
						half scattering = _TransScattering;
						half direct = _TransDirect;
						half ambient = _TransAmbient;
						half strength = _TransStrength;

						#ifdef DIRECTIONAL
							half3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, shadow );
						#else
							half3 lightAtten = gi.light.color;
						#endif
						half3 lightDir = gi.light.dir + o.Normal * normal;
						half transVdotL = pow( saturate( dot( ViewDirWS, -lightDir ) ), scattering );
						half3 translucency = lightAtten * (transVdotL * direct + gi.indirect.diffuse * ambient) * Translucency;
						c.rgb += o.Albedo * translucency * strength;
					}
					#endif

					c.rgb += o.Emission;

					#if defined( ASE_FOG )
						UNITY_EXTRACT_FOG_FROM_WORLD_POS( IN );
						UNITY_APPLY_FOG(_unity_fogCoord, c.rgb);
					#endif
					return c;
				}
			ENDCG
		}

		
		Pass
		{
			
			Name "Deferred"
			Tags { "LightMode"="Deferred" }

			AlphaToMask Off

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#define ASE_NO_AMBIENT 1
				#pragma multi_compile_instancing
				#define ASE_VERSION 19908
				#define ASE_USING_SAMPLING_MACROS 1

				#pragma vertex vert
				#pragma fragment frag
				#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
				#pragma multi_compile_prepassfinal
				#ifndef UNITY_PASS_DEFERRED
					#define UNITY_PASS_DEFERRED
				#endif
				#include "HLSLSupport.cginc"
				#if defined( ASE_GEOMETRY ) || defined( ASE_IMPOSTOR )
					#ifndef UNITY_INSTANCED_LOD_FADE
						#define UNITY_INSTANCED_LOD_FADE
					#endif
					#ifndef UNITY_INSTANCED_SH
						#define UNITY_INSTANCED_SH
					#endif
					#ifndef UNITY_INSTANCED_LIGHTMAPSTS
						#define UNITY_INSTANCED_LIGHTMAPSTS
					#endif
				#endif
				#include "UnityShaderVariables.cginc"
				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include "UnityPBSLighting.cginc"

				#if defined( UNITY_INSTANCING_ENABLED ) && defined( ASE_INSTANCED_TERRAIN ) && ( defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL) || defined(_INSTANCEDTERRAINNORMALS_PIXEL) )
					#define ENABLE_TERRAIN_PERPIXEL_NORMAL
				#endif

				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES1
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#define ASE_NEEDS_VERT_POSITION
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_VERT_TANGENT
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES1
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES2
				#define ASE_NEEDS_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#pragma shader_feature_local TVE_LEGACY
				#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY(tex,samplertex,coord) tex2DArray(tex,coord)
				#endif//ASE Sampling Macros
				


				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					float4 texcoord : TEXCOORD0;
					float4 texcoord1 : TEXCOORD1;
					float4 texcoord2 : TEXCOORD2;
					float4 ase_color : COLOR;
					float4 ase_texcoord3 : TEXCOORD3;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float4 worldPos : TEXCOORD0; // xyz = positionWS, w = fogCoord
					half3 normalWS : TEXCOORD1;
					float4 tangentWS : TEXCOORD2; // holds terrainUV ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
					half4 ambientOrLightmapUV : TEXCOORD3;
					float4 ase_texcoord4 : TEXCOORD4;
					float4 ase_texcoord5 : TEXCOORD5;
					float4 ase_texcoord6 : TEXCOORD6;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				#ifdef LIGHTMAP_ON
				float4 unity_LightmapFade;
				#endif
				half4 unity_Ambient;
				#ifdef ASE_TESSELLATION
					float _TessPhongStrength;
					float _TessValue;
					float _TessMin;
					float _TessMax;
					float _TessEdgeLength;
					float _TessMaxDisp;
				#endif

				uniform half _Banner;
				uniform half _Message;
				uniform float _IsSimpleShader;
				uniform float _IsVertexShader;
				uniform half _IsTVEShader;
				uniform half TVE_DEBUG_Type;
				uniform float _IsCoreShader;
				uniform float _IsBlanketShader;
				uniform float _IsImpostorShader;
				uniform float _IsPolygonalShader;
				uniform float _IsLiteShader;
				uniform float _IsStandardShader;
				uniform float _IsSubsurfaceShader;
				uniform float _IsCustomShader;
				uniform float _IsIdentifier;
				uniform half TVE_DEBUG_Index;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainAlbedoTex);
				uniform half4 _main_coord_value;
				SamplerState sampler_MainAlbedoTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainNormalTex);
				SamplerState sampler_MainNormalTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainMaskTex);
				SamplerState sampler_MainMaskTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondAlbedoTex);
				uniform half _DetailCoordMode;
				uniform half4 _SecondUVs;
				SamplerState sampler_SecondAlbedoTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondNormalTex);
				SamplerState sampler_SecondNormalTex;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondMaskTex);
				SamplerState sampler_SecondMaskTex;
				uniform float _DetailMode;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_EmissiveTex);
				uniform half4 _EmissiveUVs;
				SamplerState sampler_EmissiveTex;
				uniform float4 _EmissiveColor;
				uniform float _EmissiveCat;
				uniform half TVE_DEBUG_Min;
				uniform half TVE_DEBUG_Max;
				float4 _MainAlbedoTex_TexelSize;
				float4 _MainNormalTex_TexelSize;
				float4 _MainMaskTex_TexelSize;
				float4 _SecondAlbedoTex_TexelSize;
				float4 _SecondMaskTex_TexelSize;
				float4 _EmissiveTex_TexelSize;
				UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_DEBUG_MipTex);
				SamplerState samplerTVE_DEBUG_MipTex;
				uniform half4 TVE_CoatParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatBaseTex);
				uniform float4 TVE_CoatBaseCoord;
				uniform half TVE_DEBUG_Layer;
				SamplerState sampler_Linear_Clamp;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatNearTex);
				uniform float4 TVE_CoatNearCoord;
				SamplerState sampler_Linear_Repeat;
				uniform float TVE_CoatLayers[10];
				uniform half4 TVE_PaintParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintBaseTex);
				uniform float4 TVE_PaintBaseCoord;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintNearTex);
				uniform float4 TVE_PaintNearCoord;
				uniform float TVE_PaintLayers[10];
				uniform half4 TVE_GlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowBaseTex);
				uniform float4 TVE_GlowBaseCoord;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowNearTex);
				uniform float4 TVE_GlowNearCoord;
				uniform float TVE_GlowLayers[10];
				uniform half4 TVE_AtmoParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoBaseTex);
				uniform float4 TVE_AtmoBaseCoord;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoNearTex);
				uniform float4 TVE_AtmoNearCoord;
				uniform float TVE_AtmoLayers[10];
				uniform half4 TVE_FormParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormBaseTex);
				uniform float4 TVE_FormBaseCoord;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormNearTex);
				uniform float4 TVE_FormNearCoord;
				uniform float TVE_FormLayers[10];
				uniform half4 TVE_FlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowBaseTex);
				uniform float4 TVE_FlowBaseCoord;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowNearTex);
				uniform float4 TVE_FlowNearCoord;
				uniform float TVE_FlowLayers[10];
				uniform half4 _object_phase_mode;
				uniform half4 _motion_base_vert_mode;
				uniform half _ObjectHeightValue;
				uniform half4 _motion_base_proc_mode;
				uniform half _ObjectRadiusValue;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MotionMaskTex);
				uniform float4 _MotionMaskTex_ST;
				SamplerState sampler_MotionMaskTex;
				uniform half4 _MotionBaseMaskRemap;
				uniform half _MotionBaseMaskMode;
				uniform half4 _motion_small_vert_mode;
				uniform half4 _motion_small_proc_mode;
				uniform half4 _MotionSmallMaskRemap;
				uniform half _MotionSmallMaskMode;
				uniform half4 _motion_tiny_vert_mode;
				uniform half4 _motion_tiny_proc_mode;
				uniform half4 _MotionTinyMaskRemap;
				uniform half _MotionTinyMaskMode;
				uniform half TVE_DEBUG_Filter;
				uniform half TVE_DEBUG_Shading;
				uniform half TVE_DEBUG_Clip;
				uniform float _RenderClip;
				uniform float _MainAlphaClipValue;
				uniform float _IsElementShader;
				uniform float _IsHelperShader;


				float3 HSVToRGB( float3 c )
				{
					float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
					float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
					return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
				}
				
				float CapsuleMaskOptimized1914_g128148( float3 Position, half Height, half Radius )
				{
					    float3 a = float3(0, Height, 0);
					    float3 ba = -a;
					    float3 pa = Position - a;
					    
					    float baDot = dot(ba, ba);
					    float h = saturate(dot(pa, ba) / baDot);
					    
					    float3 q = pa - ba * h;
					    return length(q) / Radius;
				}
				
				float2 DecodeFloatToVector2( float enc )
				{
					float2 result ;
					result.y = enc % 2048;
					result.x = floor(enc / 2048);
					return result / (2048 - 1);
				}
				

				v2f VertexFunction (appdata v  ) {
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float Debug_Index464_g128148 = TVE_DEBUG_Index;
					float3 ifLocalVar40_g128149 = 0;
					if( Debug_Index464_g128148 == 0.0 )
					ifLocalVar40_g128149 = saturate( v.vertex.xyz );
					float3 ifLocalVar40_g128156 = 0;
					if( Debug_Index464_g128148 == 1.0 )
					ifLocalVar40_g128156 = v.normal;
					float3 ifLocalVar40_g128162 = 0;
					if( Debug_Index464_g128148 == 2.0 )
					ifLocalVar40_g128162 = v.tangent.xyz;
					float ifLocalVar40_g128154 = 0;
					if( Debug_Index464_g128148 == 3.0 )
					ifLocalVar40_g128154 = saturate( v.tangent.w );
					float ifLocalVar40_g128198 = 0;
					if( Debug_Index464_g128148 == 5.0 )
					ifLocalVar40_g128198 = v.ase_color.r;
					float ifLocalVar40_g128199 = 0;
					if( Debug_Index464_g128148 == 6.0 )
					ifLocalVar40_g128199 = v.ase_color.g;
					float ifLocalVar40_g128200 = 0;
					if( Debug_Index464_g128148 == 7.0 )
					ifLocalVar40_g128200 = v.ase_color.b;
					float ifLocalVar40_g128201 = 0;
					if( Debug_Index464_g128148 == 8.0 )
					ifLocalVar40_g128201 = v.ase_color.a;
					float3 appendResult1147_g128148 = (float3(v.texcoord.xyzw.x , v.texcoord.xyzw.y , 0.0));
					float3 ifLocalVar40_g128202 = 0;
					if( Debug_Index464_g128148 == 9.0 )
					ifLocalVar40_g128202 = appendResult1147_g128148;
					float3 appendResult1148_g128148 = (float3(v.texcoord1.xyzw.x , v.texcoord1.xyzw.y , 0.0));
					float3 ifLocalVar40_g128203 = 0;
					if( Debug_Index464_g128148 == 10.0 )
					ifLocalVar40_g128203 = appendResult1148_g128148;
					float3 appendResult1149_g128148 = (float3(v.texcoord2.xyzw.x , v.texcoord2.xyzw.y , 0.0));
					float3 ifLocalVar40_g128223 = 0;
					if( Debug_Index464_g128148 == 11.0 )
					ifLocalVar40_g128223 = appendResult1149_g128148;
					float4 break33_g128221 = _object_phase_mode;
					float temp_output_30_0_g128221 = ( v.ase_color.r * break33_g128221.x );
					float temp_output_29_0_g128221 = ( v.ase_color.g * break33_g128221.y );
					float temp_output_31_0_g128221 = ( v.ase_color.b * break33_g128221.z );
					float temp_output_28_0_g128221 = ( temp_output_30_0_g128221 + temp_output_29_0_g128221 + temp_output_31_0_g128221 + ( v.ase_color.a * break33_g128221.w ) );
					half Motion_PhaseMask1725_g128148 = temp_output_28_0_g128221;
					float3 hsvTorgb260_g128148 = HSVToRGB( float3(Motion_PhaseMask1725_g128148,1.0,1.0) );
					float3 gammaToLinear266_g128148 = GammaToLinearSpace( hsvTorgb260_g128148 );
					float3 ifLocalVar40_g128224 = 0;
					if( Debug_Index464_g128148 == 12.0 )
					ifLocalVar40_g128224 = gammaToLinear266_g128148;
					float4 break1821_g128148 = v.ase_color;
					float4 break33_g128385 = _motion_base_vert_mode;
					float temp_output_30_0_g128385 = ( break1821_g128148.r * break33_g128385.x );
					float temp_output_29_0_g128385 = ( break1821_g128148.g * break33_g128385.y );
					float temp_output_31_0_g128385 = ( break1821_g128148.b * break33_g128385.z );
					float temp_output_28_0_g128385 = ( temp_output_30_0_g128385 + temp_output_29_0_g128385 + temp_output_31_0_g128385 + ( break1821_g128148.a * break33_g128385.w ) );
					half Bounds_Height1700_g128148 = _ObjectHeightValue;
					half Final_HeightMask1815_g128148 = saturate( ( v.vertex.xyz.y / Bounds_Height1700_g128148 ) );
					float4 break45_g128385 = _motion_base_proc_mode;
					float temp_output_48_0_g128385 = ( Final_HeightMask1815_g128148 * break45_g128385.x );
					float3 Position1914_g128148 = v.vertex.xyz;
					float Height1914_g128148 = Bounds_Height1700_g128148;
					half Bounds_Radius1702_g128148 = _ObjectRadiusValue;
					float Radius1914_g128148 = Bounds_Radius1702_g128148;
					float localCapsuleMaskOptimized1914_g128148 = CapsuleMaskOptimized1914_g128148( Position1914_g128148 , Height1914_g128148 , Radius1914_g128148 );
					half Final_SphereMask1816_g128148 = saturate( localCapsuleMaskOptimized1914_g128148 );
					float temp_output_47_0_g128385 = ( Final_SphereMask1816_g128148 * break45_g128385.y );
					float2 uv_MotionMaskTex = v.texcoord.xyzw.xy * _MotionMaskTex_ST.xy + _MotionMaskTex_ST.zw;
					float4 Motion_MaskTex1904_g128148 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex, 0.0 );
					float temp_output_49_0_g128385 = ( (Motion_MaskTex1904_g128148).r * break45_g128385.z );
					float clampResult17_g128376 = clamp( ( temp_output_28_0_g128385 + temp_output_48_0_g128385 + temp_output_47_0_g128385 + temp_output_49_0_g128385 ) , 0.0001 , 0.9999 );
					float temp_output_7_0_g128377 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g128377 = ( clampResult17_g128376 - temp_output_7_0_g128377 );
					float temp_output_6_0_g128378 = saturate( ( temp_output_9_0_g128377 / ( ( _MotionBaseMaskRemap.y - temp_output_7_0_g128377 ) + 0.0001 ) ) );
					float temp_output_7_0_g128378 = _MotionBaseMaskMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g128378 = ( temp_output_6_0_g128378 + temp_output_7_0_g128378 );
					#else
					float staticSwitch14_g128378 = temp_output_6_0_g128378;
					#endif
					half Motion_BaseMask1675_g128148 = staticSwitch14_g128378;
					float ifLocalVar40_g128225 = 0;
					if( Debug_Index464_g128148 == 13.0 )
					ifLocalVar40_g128225 = Motion_BaseMask1675_g128148;
					float4 break1855_g128148 = v.ase_color;
					float4 break33_g128386 = _motion_small_vert_mode;
					float temp_output_30_0_g128386 = ( break1855_g128148.r * break33_g128386.x );
					float temp_output_29_0_g128386 = ( break1855_g128148.g * break33_g128386.y );
					float temp_output_31_0_g128386 = ( break1855_g128148.b * break33_g128386.z );
					float temp_output_28_0_g128386 = ( temp_output_30_0_g128386 + temp_output_29_0_g128386 + temp_output_31_0_g128386 + ( break1855_g128148.a * break33_g128386.w ) );
					float4 break45_g128386 = _motion_small_proc_mode;
					float temp_output_48_0_g128386 = ( Final_HeightMask1815_g128148 * break45_g128386.x );
					float temp_output_47_0_g128386 = ( Final_SphereMask1816_g128148 * break45_g128386.y );
					float temp_output_49_0_g128386 = ( (Motion_MaskTex1904_g128148).g * break45_g128386.z );
					float enc1882_g128148 = v.texcoord.xyzw.z;
					float2 localDecodeFloatToVector21882_g128148 = DecodeFloatToVector2( enc1882_g128148 );
					float2 break1878_g128148 = localDecodeFloatToVector21882_g128148;
					half Small_Mask_Legacy1879_g128148 = break1878_g128148.x;
					#ifdef TVE_LEGACY
					float staticSwitch1883_g128148 = Small_Mask_Legacy1879_g128148;
					#else
					float staticSwitch1883_g128148 = ( temp_output_28_0_g128386 + temp_output_48_0_g128386 + temp_output_47_0_g128386 + temp_output_49_0_g128386 );
					#endif
					float clampResult17_g128379 = clamp( staticSwitch1883_g128148 , 0.0001 , 0.9999 );
					float temp_output_7_0_g128380 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g128380 = ( clampResult17_g128379 - temp_output_7_0_g128380 );
					float temp_output_6_0_g128381 = saturate( ( temp_output_9_0_g128380 / ( ( _MotionSmallMaskRemap.y - temp_output_7_0_g128380 ) + 0.0001 ) ) );
					float temp_output_7_0_g128381 = _MotionSmallMaskMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g128381 = ( temp_output_6_0_g128381 + temp_output_7_0_g128381 );
					#else
					float staticSwitch14_g128381 = temp_output_6_0_g128381;
					#endif
					half Motion_SmallMask1693_g128148 = staticSwitch14_g128381;
					float ifLocalVar40_g128226 = 0;
					if( Debug_Index464_g128148 == 14.0 )
					ifLocalVar40_g128226 = Motion_SmallMask1693_g128148;
					float4 break1867_g128148 = v.ase_color;
					float4 break33_g128387 = _motion_tiny_vert_mode;
					float temp_output_30_0_g128387 = ( break1867_g128148.r * break33_g128387.x );
					float temp_output_29_0_g128387 = ( break1867_g128148.g * break33_g128387.y );
					float temp_output_31_0_g128387 = ( break1867_g128148.b * break33_g128387.z );
					float temp_output_28_0_g128387 = ( temp_output_30_0_g128387 + temp_output_29_0_g128387 + temp_output_31_0_g128387 + ( break1867_g128148.a * break33_g128387.w ) );
					float4 break45_g128387 = _motion_tiny_proc_mode;
					float temp_output_48_0_g128387 = ( Final_HeightMask1815_g128148 * break45_g128387.x );
					float temp_output_47_0_g128387 = ( Final_SphereMask1816_g128148 * break45_g128387.y );
					float temp_output_49_0_g128387 = ( (Motion_MaskTex1904_g128148).b * break45_g128387.z );
					half Tiny_Mask_Legacy1880_g128148 = break1878_g128148.y;
					#ifdef TVE_LEGACY
					float staticSwitch1886_g128148 = Tiny_Mask_Legacy1880_g128148;
					#else
					float staticSwitch1886_g128148 = ( temp_output_28_0_g128387 + temp_output_48_0_g128387 + temp_output_47_0_g128387 + temp_output_49_0_g128387 );
					#endif
					float clampResult17_g128382 = clamp( staticSwitch1886_g128148 , 0.0001 , 0.9999 );
					float temp_output_7_0_g128383 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g128383 = ( clampResult17_g128382 - temp_output_7_0_g128383 );
					float temp_output_6_0_g128384 = saturate( ( temp_output_9_0_g128383 / ( ( _MotionTinyMaskRemap.y - temp_output_7_0_g128383 ) + 0.0001 ) ) );
					float temp_output_7_0_g128384 = _MotionTinyMaskMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g128384 = ( temp_output_6_0_g128384 + temp_output_7_0_g128384 );
					#else
					float staticSwitch14_g128384 = temp_output_6_0_g128384;
					#endif
					half Motion_TinyMask1717_g128148 = staticSwitch14_g128384;
					float ifLocalVar40_g128227 = 0;
					if( Debug_Index464_g128148 == 15.0 )
					ifLocalVar40_g128227 = Motion_TinyMask1717_g128148;
					float3 appendResult60_g128222 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 ifLocalVar40_g128228 = 0;
					if( Debug_Index464_g128148 == 16.0 )
					ifLocalVar40_g128228 = appendResult60_g128222;
					float3 vertexToFrag328_g128148 = ( ( ifLocalVar40_g128149 + ifLocalVar40_g128156 + ifLocalVar40_g128162 + ifLocalVar40_g128154 ) + ( ifLocalVar40_g128198 + ifLocalVar40_g128199 + ifLocalVar40_g128200 + ifLocalVar40_g128201 ) + ( ifLocalVar40_g128202 + ifLocalVar40_g128203 + ifLocalVar40_g128223 ) + ( ifLocalVar40_g128224 + ifLocalVar40_g128225 + ifLocalVar40_g128226 + ifLocalVar40_g128227 + ifLocalVar40_g128228 ) );
					o.ase_texcoord6.xyz = vertexToFrag328_g128148;
					
					o.ase_texcoord4 = v.texcoord.xyzw;
					o.ase_texcoord5 = v.texcoord1.xyzw;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord6.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = defaultVertexValue;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = v.normal;
					v.tangent = v.tangent;

					float3 positionWS = mul( unity_ObjectToWorld, v.vertex ).xyz;
					half3 normalWS = UnityObjectToWorldNormal( v.normal );
					half3 tangentWS = UnityObjectToWorldDir( v.tangent.xyz );

					o.pos = UnityObjectToClipPos( v.vertex );
					o.worldPos.xyz = positionWS;
					o.normalWS = normalWS;
					o.tangentWS = half4( tangentWS, v.tangent.w );

					o.ambientOrLightmapUV = 0;
					#ifdef LIGHTMAP_ON
						o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					#elif UNITY_SHOULD_SAMPLE_SH
						#ifdef VERTEXLIGHT_ON
							o.ambientOrLightmapUV.rgb += Shade4PointLights(
								unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
								unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
								unity_4LightAtten0, positionWS, normalWS );
						#endif
						o.ambientOrLightmapUV.rgb = ShadeSHPerVertex( normalWS, o.ambientOrLightmapUV.rgb );
					#endif
					#ifdef DYNAMICLIGHTMAP_ON
						o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					#endif

					#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
						o.tangentWS.zw = v.texcoord.xy;
						o.tangentWS.xy = v.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					#endif
					return o;
				}

				#if defined(ASE_TESSELLATION)
				struct VertexControl
				{
					float4 vertex : INTERNALTESSPOS;
					half4 tangent : TANGENT;
					half3 normal : NORMAL;
					float4 texcoord : TEXCOORD0;
					float4 texcoord1 : TEXCOORD1;
					float4 texcoord2 : TEXCOORD2;
					float4 ase_color : COLOR;
					float4 ase_texcoord3 : TEXCOORD3;

					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct TessellationFactors
				{
					float edge[3] : SV_TessFactor;
					float inside : SV_InsideTessFactor;
				};

				VertexControl vert ( appdata v )
				{
					VertexControl o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_TRANSFER_INSTANCE_ID(v, o);
					o.vertex = v.vertex;
					o.tangent = v.tangent;
					o.normal = v.normal;
					o.texcoord = v.texcoord;
					o.texcoord1 = v.texcoord1;
					o.texcoord2 = v.texcoord2;
					o.texcoord = v.texcoord;
					o.ase_color = v.ase_color;
					o.ase_texcoord3 = v.ase_texcoord3;
					return o;
				}

				TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
				{
					TessellationFactors o;
					float4 tf = 1;
					float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
					float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
					#if defined(ASE_FIXED_TESSELLATION)
					tf = FixedTess( tessValue );
					#elif defined(ASE_DISTANCE_TESSELLATION)
					tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
					#elif defined(ASE_LENGTH_TESSELLATION)
					tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
					#elif defined(ASE_LENGTH_CULL_TESSELLATION)
					tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
					#endif
					o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
					return o;
				}

				[domain("tri")]
				[partitioning("fractional_odd")]
				[outputtopology("triangle_cw")]
				[patchconstantfunc("TessellationFunction")]
				[outputcontrolpoints(3)]
				VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
				{
				   return patch[id];
				}

				[domain("tri")]
				v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
				{
					appdata o = (appdata) 0;
					o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
					o.tangent = patch[0].tangent * bary.x + patch[1].tangent * bary.y + patch[2].tangent * bary.z;
					o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
					o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
					o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
					o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
					o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
					o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
					o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
					#if defined(ASE_PHONG_TESSELLATION)
					float3 pp[3];
					for (int i = 0; i < 3; ++i)
						pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
					float phongStrength = _TessPhongStrength;
					o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
					#endif
					UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
					return VertexFunction(o);
				}
				#else
				v2f vert ( appdata v )
				{
					return VertexFunction( v );
				}
				#endif

				void frag (v2f IN , uint ase_vface : SV_IsFrontFace
					, out half4 outGBuffer0 : SV_Target0
					, out half4 outGBuffer1 : SV_Target1
					, out half4 outGBuffer2 : SV_Target2
					, out half4 outEmission : SV_Target3
					#if defined(SHADOWS_SHADOWMASK) && (UNITY_ALLOWED_MRT_COUNT > 4)
					, out half4 outShadowMask : SV_Target4
					#endif
					#if defined( ASE_DEPTH_WRITE_ON )
					, out float outputDepth : SV_Depth
					#endif
				)
				{
					UNITY_SETUP_INSTANCE_ID(IN);

					#ifdef LOD_FADE_CROSSFADE
						UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
					#endif

					#if defined(ASE_LIGHTING_SIMPLE)
						SurfaceOutput o = (SurfaceOutput)0;
					#else
						#if defined(_SPECULAR_SETUP)
							SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
						#else
							SurfaceOutputStandard o = (SurfaceOutputStandard)0;
						#endif
					#endif

					float3 PositionWS = IN.worldPos.xyz;
					half3 ViewDirWS = normalize( UnityWorldSpaceViewDir( PositionWS ) );
					float4 ScreenPosNorm = float4( IN.pos.xy * ( _ScreenParams.zw - 1.0 ), IN.pos.zw );
					float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, IN.pos.z ) * IN.pos.w;
					float4 ScreenPos = ComputeScreenPos( ClipPos );
					half3 NormalWS = IN.normalWS;
					half3 TangentWS = IN.tangentWS.xyz;
					half3 BitangentWS = cross( IN.normalWS, IN.tangentWS.xyz ) * IN.tangentWS.w * unity_WorldTransformParams.w;

					#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
						float2 sampleCoords = (IN.tangentWS.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
						NormalWS = UnityObjectToWorldNormal(normalize(tex2D(_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
						TangentWS = -cross(unity_ObjectToWorld._13_23_33, NormalWS);
						BitangentWS = cross(NormalWS, -TangentWS);
					#endif

					float3 temp_cast_0 = (0.0).xxx;
					
					float4 color690_g128148 = IsGammaSpace() ? float4( 0.1, 0.1, 0.1, 0 ) : float4( 0.01002283, 0.01002283, 0.01002283, 0 );
					float4 Shading_Inactive1492_g128148 = color690_g128148;
					float Debug_Type367_g128148 = TVE_DEBUG_Type;
					float4 color646_g128148 = IsGammaSpace() ? float4( 0.9245283, 0.7969696, 0.4142933, 1 ) : float4( 0.8368256, 0.5987038, 0.1431069, 1 );
					float4 Output_Converted717_g128148 = color646_g128148;
					float4 ifLocalVar40_g128209 = 0;
					if( Debug_Type367_g128148 == 0.0 )
					ifLocalVar40_g128209 = Output_Converted717_g128148;
					float4 color1529_g128148 = IsGammaSpace() ? float4( 0.9254902, 0.7960784, 0.4156863, 1 ) : float4( 0.8387991, 0.5972018, 0.1441285, 1 );
					float _IsCoreShader1551_g128148 = _IsCoreShader;
					float4 color1539_g128148 = IsGammaSpace() ? float4( 0.6196079, 0.7686275, 0.1490196, 0 ) : float4( 0.3419145, 0.5520116, 0.01938236, 0 );
					float _IsBlanketShader1554_g128148 = _IsBlanketShader;
					float4 color1542_g128148 = IsGammaSpace() ? float4( 0.9716981, 0.3162602, 0.4816265, 0 ) : float4( 0.9368213, 0.08154967, 0.1974273, 0 );
					float _IsImpostorShader1110_g128148 = _IsImpostorShader;
					float4 color1544_g128148 = IsGammaSpace() ? float4( 0.3254902, 0.6117647, 0.8117647, 0 ) : float4( 0.08650047, 0.3324516, 0.6239604, 0 );
					float _IsPolygonalShader1112_g128148 = _IsPolygonalShader;
					float4 color1649_g128148 = IsGammaSpace() ? float4( 0.6, 0.6, 0.6, 0 ) : float4( 0.3185468, 0.3185468, 0.3185468, 0 );
					float _IsLiteShader1648_g128148 = _IsLiteShader;
					float4 Output_Scope1531_g128148 = ( ( color1529_g128148 * _IsCoreShader1551_g128148 ) + ( color1539_g128148 * _IsBlanketShader1554_g128148 ) + ( color1542_g128148 * _IsImpostorShader1110_g128148 ) + ( color1544_g128148 * _IsPolygonalShader1112_g128148 ) + ( color1649_g128148 * _IsLiteShader1648_g128148 ) );
					float4 ifLocalVar40_g128211 = 0;
					if( Debug_Type367_g128148 == 2.0 )
					ifLocalVar40_g128211 = Output_Scope1531_g128148;
					float4 color529_g128148 = IsGammaSpace() ? float4( 0.62, 0.77, 0.15, 0 ) : float4( 0.3423916, 0.5542217, 0.01960665, 0 );
					float _IsVertexShader1158_g128148 = _IsVertexShader;
					float4 color544_g128148 = IsGammaSpace() ? float4( 0.3252937, 0.6122813, 0.8113208, 0 ) : float4( 0.08639329, 0.3330702, 0.6231937, 0 );
					float _IsSimpleShader359_g128148 = _IsSimpleShader;
					float4 color521_g128148 = IsGammaSpace() ? float4( 0.6566009, 0.3404236, 0.8490566, 0 ) : float4( 0.3886527, 0.09487338, 0.6903409, 0 );
					float _IsStandardShader344_g128148 = _IsStandardShader;
					float4 color1121_g128148 = IsGammaSpace() ? float4( 0.9716981, 0.88463, 0.1787558, 0 ) : float4( 0.9368213, 0.7573396, 0.02686729, 0 );
					float _IsSubsurfaceShader548_g128148 = _IsSubsurfaceShader;
					float4 Output_Lighting525_g128148 = ( ( color529_g128148 * _IsVertexShader1158_g128148 ) + ( color544_g128148 * _IsSimpleShader359_g128148 ) + ( color521_g128148 * _IsStandardShader344_g128148 ) + ( color1121_g128148 * _IsSubsurfaceShader548_g128148 ) );
					float4 ifLocalVar40_g128212 = 0;
					if( Debug_Type367_g128148 == 3.0 )
					ifLocalVar40_g128212 = Output_Lighting525_g128148;
					float4 color1559_g128148 = IsGammaSpace() ? float4( 0.9245283, 0.7969696, 0.4142933, 1 ) : float4( 0.8368256, 0.5987038, 0.1431069, 1 );
					float4 color1563_g128148 = IsGammaSpace() ? float4( 0.3053578, 0.8867924, 0.5362216, 0 ) : float4( 0.0759199, 0.7615293, 0.2491121, 0 );
					float _IsCustomShader1570_g128148 = _IsCustomShader;
					float4 lerpResult1561_g128148 = lerp( color1559_g128148 , color1563_g128148 , _IsCustomShader1570_g128148);
					float4 Output_Custom1560_g128148 = lerpResult1561_g128148;
					float4 ifLocalVar40_g128213 = 0;
					if( Debug_Type367_g128148 == 4.0 )
					ifLocalVar40_g128213 = Output_Custom1560_g128148;
					float3 hsvTorgb1452_g128148 = HSVToRGB( float3(( _IsIdentifier / 1000.0 ),1.0,1.0) );
					float3 gammaToLinear1453_g128148 = GammaToLinearSpace( hsvTorgb1452_g128148 );
					float4 appendResult1657_g128148 = (float4(gammaToLinear1453_g128148 , 1.0));
					float4 Output_Sharing1355_g128148 = appendResult1657_g128148;
					float4 ifLocalVar40_g128214 = 0;
					if( Debug_Type367_g128148 == 5.0 )
					ifLocalVar40_g128214 = Output_Sharing1355_g128148;
					float Debug_Index464_g128148 = TVE_DEBUG_Index;
					half2 Main_UVs1219_g128148 = ( ( IN.ase_texcoord4.xy * (_main_coord_value).xy ) + (_main_coord_value).zw );
					float4 tex2DNode586_g128148 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs1219_g128148 );
					float3 appendResult637_g128148 = (float3(tex2DNode586_g128148.r , tex2DNode586_g128148.g , tex2DNode586_g128148.b));
					float3 ifLocalVar40_g128155 = 0;
					if( Debug_Index464_g128148 == 0.0 )
					ifLocalVar40_g128155 = appendResult637_g128148;
					float ifLocalVar40_g128159 = 0;
					if( Debug_Index464_g128148 == 1.0 )
					ifLocalVar40_g128159 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs1219_g128148 ).a;
					float4 tex2DNode604_g128148 = SAMPLE_TEXTURE2D( _MainNormalTex, sampler_MainNormalTex, Main_UVs1219_g128148 );
					float3 appendResult876_g128148 = (float3(tex2DNode604_g128148.a , tex2DNode604_g128148.g , 1.0));
					float3 gammaToLinear878_g128148 = GammaToLinearSpace( appendResult876_g128148 );
					float3 ifLocalVar40_g128163 = 0;
					if( Debug_Index464_g128148 == 2.0 )
					ifLocalVar40_g128163 = gammaToLinear878_g128148;
					float ifLocalVar40_g128151 = 0;
					if( Debug_Index464_g128148 == 3.0 )
					ifLocalVar40_g128151 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g128148 ).r;
					float ifLocalVar40_g128169 = 0;
					if( Debug_Index464_g128148 == 4.0 )
					ifLocalVar40_g128169 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g128148 ).g;
					float ifLocalVar40_g128160 = 0;
					if( Debug_Index464_g128148 == 5.0 )
					ifLocalVar40_g128160 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g128148 ).b;
					float ifLocalVar40_g128150 = 0;
					if( Debug_Index464_g128148 == 6.0 )
					ifLocalVar40_g128150 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g128148 ).a;
					float2 appendResult1251_g128148 = (float2(IN.ase_texcoord5.z , IN.ase_texcoord5.w));
					float2 Mesh_DetailCoord1254_g128148 = appendResult1251_g128148;
					float2 lerpResult1231_g128148 = lerp( IN.ase_texcoord4.xy , Mesh_DetailCoord1254_g128148 , _DetailCoordMode);
					half2 Layer_02_UVs1234_g128148 = ( ( lerpResult1231_g128148 * (_SecondUVs).xy ) + (_SecondUVs).zw );
					float4 tex2DNode854_g128148 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Layer_02_UVs1234_g128148 );
					float3 appendResult839_g128148 = (float3(tex2DNode854_g128148.r , tex2DNode854_g128148.g , tex2DNode854_g128148.b));
					float3 ifLocalVar40_g128153 = 0;
					if( Debug_Index464_g128148 == 7.0 )
					ifLocalVar40_g128153 = appendResult839_g128148;
					float ifLocalVar40_g128161 = 0;
					if( Debug_Index464_g128148 == 8.0 )
					ifLocalVar40_g128161 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Layer_02_UVs1234_g128148 ).a;
					float4 tex2DNode841_g128148 = SAMPLE_TEXTURE2D( _SecondNormalTex, sampler_SecondNormalTex, Layer_02_UVs1234_g128148 );
					float3 appendResult880_g128148 = (float3(tex2DNode841_g128148.a , tex2DNode841_g128148.g , 1.0));
					float3 gammaToLinear879_g128148 = GammaToLinearSpace( appendResult880_g128148 );
					float3 ifLocalVar40_g128168 = 0;
					if( Debug_Index464_g128148 == 8.0 )
					ifLocalVar40_g128168 = gammaToLinear879_g128148;
					float ifLocalVar40_g128164 = 0;
					if( Debug_Index464_g128148 == 10.0 )
					ifLocalVar40_g128164 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Layer_02_UVs1234_g128148 ).r;
					float ifLocalVar40_g128158 = 0;
					if( Debug_Index464_g128148 == 11.0 )
					ifLocalVar40_g128158 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Layer_02_UVs1234_g128148 ).g;
					float ifLocalVar40_g128166 = 0;
					if( Debug_Index464_g128148 == 12.0 )
					ifLocalVar40_g128166 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Layer_02_UVs1234_g128148 ).b;
					float ifLocalVar40_g128167 = 0;
					if( Debug_Index464_g128148 == 13.0 )
					ifLocalVar40_g128167 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Layer_02_UVs1234_g128148 ).a;
					half2 Emissive_UVs1245_g128148 = ( ( IN.ase_texcoord4.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
					float4 tex2DNode858_g128148 = SAMPLE_TEXTURE2D( _EmissiveTex, sampler_EmissiveTex, Emissive_UVs1245_g128148 );
					float ifLocalVar40_g128157 = 0;
					if( Debug_Index464_g128148 == 14.0 )
					ifLocalVar40_g128157 = tex2DNode858_g128148.r;
					float Debug_Min721_g128148 = TVE_DEBUG_Min;
					float temp_output_7_0_g128165 = Debug_Min721_g128148;
					float4 temp_cast_4 = (temp_output_7_0_g128165).xxxx;
					float4 temp_output_9_0_g128165 = ( ( float4( ( ( ifLocalVar40_g128155 + ifLocalVar40_g128159 + ifLocalVar40_g128163 ) + ( ifLocalVar40_g128151 + ifLocalVar40_g128169 + ifLocalVar40_g128160 + ifLocalVar40_g128150 ) ) , 0.0 ) + float4( ( ( ( ifLocalVar40_g128153 + ifLocalVar40_g128161 + ifLocalVar40_g128168 ) + ( ifLocalVar40_g128164 + ifLocalVar40_g128158 + ifLocalVar40_g128166 + ifLocalVar40_g128167 ) ) * _DetailMode ) , 0.0 ) + ( ( ifLocalVar40_g128157 * _EmissiveColor ) * _EmissiveCat ) ) - temp_cast_4 );
					float Debug_Max723_g128148 = TVE_DEBUG_Max;
					float4 Output_Maps561_g128148 = saturate( ( temp_output_9_0_g128165 / ( ( Debug_Max723_g128148 - temp_output_7_0_g128165 ) + 0.0001 ) ) );
					float4 ifLocalVar40_g128215 = 0;
					if( Debug_Type367_g128148 == 6.0 )
					ifLocalVar40_g128215 = Output_Maps561_g128148;
					float Resolution44_g128186 = max( _MainAlbedoTex_TexelSize.z, _MainAlbedoTex_TexelSize.w );
					float4 color62_g128186 = IsGammaSpace() ? float4( 0.484069, 0.862666, 0.9245283, 0 ) : float4( 0.1995908, 0.7155456, 0.8368256, 0 );
					float4 ifLocalVar61_g128186 = 0;
					if( Resolution44_g128186 <= 256.0 )
					ifLocalVar61_g128186 = color62_g128186;
					float4 color55_g128186 = IsGammaSpace() ? float4( 0.1933962, 0.7383016, 1, 0 ) : float4( 0.03108436, 0.5044825, 1, 0 );
					float4 ifLocalVar56_g128186 = 0;
					if( Resolution44_g128186 == 512.0 )
					ifLocalVar56_g128186 = color55_g128186;
					float4 color42_g128186 = IsGammaSpace() ? float4( 0.4431373, 0.7921569, 0.1764706, 0 ) : float4( 0.1651322, 0.5906189, 0.02624122, 0 );
					float4 ifLocalVar40_g128186 = 0;
					if( Resolution44_g128186 == 1024.0 )
					ifLocalVar40_g128186 = color42_g128186;
					float4 color48_g128186 = IsGammaSpace() ? float4( 1, 0.6889491, 0.07075471, 0 ) : float4( 1, 0.4324122, 0.006068094, 0 );
					float4 ifLocalVar47_g128186 = 0;
					if( Resolution44_g128186 == 2048.0 )
					ifLocalVar47_g128186 = color48_g128186;
					float4 color51_g128186 = IsGammaSpace() ? float4( 1, 0.2066492, 0.0990566, 0 ) : float4( 1, 0.03521443, 0.009877041, 0 );
					float4 ifLocalVar52_g128186 = 0;
					if( Resolution44_g128186 >= 4096.0 )
					ifLocalVar52_g128186 = color51_g128186;
					float4 ifLocalVar40_g128172 = 0;
					if( Debug_Index464_g128148 == 0.0 )
					ifLocalVar40_g128172 = ( ifLocalVar61_g128186 + ifLocalVar56_g128186 + ifLocalVar40_g128186 + ifLocalVar47_g128186 + ifLocalVar52_g128186 );
					float Resolution44_g128185 = max( _MainNormalTex_TexelSize.z, _MainNormalTex_TexelSize.w );
					float4 color62_g128185 = IsGammaSpace() ? float4( 0.484069, 0.862666, 0.9245283, 0 ) : float4( 0.1995908, 0.7155456, 0.8368256, 0 );
					float4 ifLocalVar61_g128185 = 0;
					if( Resolution44_g128185 <= 256.0 )
					ifLocalVar61_g128185 = color62_g128185;
					float4 color55_g128185 = IsGammaSpace() ? float4( 0.1933962, 0.7383016, 1, 0 ) : float4( 0.03108436, 0.5044825, 1, 0 );
					float4 ifLocalVar56_g128185 = 0;
					if( Resolution44_g128185 == 512.0 )
					ifLocalVar56_g128185 = color55_g128185;
					float4 color42_g128185 = IsGammaSpace() ? float4( 0.4431373, 0.7921569, 0.1764706, 0 ) : float4( 0.1651322, 0.5906189, 0.02624122, 0 );
					float4 ifLocalVar40_g128185 = 0;
					if( Resolution44_g128185 == 1024.0 )
					ifLocalVar40_g128185 = color42_g128185;
					float4 color48_g128185 = IsGammaSpace() ? float4( 1, 0.6889491, 0.07075471, 0 ) : float4( 1, 0.4324122, 0.006068094, 0 );
					float4 ifLocalVar47_g128185 = 0;
					if( Resolution44_g128185 == 2048.0 )
					ifLocalVar47_g128185 = color48_g128185;
					float4 color51_g128185 = IsGammaSpace() ? float4( 1, 0.2066492, 0.0990566, 0 ) : float4( 1, 0.03521443, 0.009877041, 0 );
					float4 ifLocalVar52_g128185 = 0;
					if( Resolution44_g128185 >= 4096.0 )
					ifLocalVar52_g128185 = color51_g128185;
					float4 ifLocalVar40_g128170 = 0;
					if( Debug_Index464_g128148 == 1.0 )
					ifLocalVar40_g128170 = ( ifLocalVar61_g128185 + ifLocalVar56_g128185 + ifLocalVar40_g128185 + ifLocalVar47_g128185 + ifLocalVar52_g128185 );
					float Resolution44_g128184 = max( _MainMaskTex_TexelSize.z, _MainMaskTex_TexelSize.w );
					float4 color62_g128184 = IsGammaSpace() ? float4( 0.484069, 0.862666, 0.9245283, 0 ) : float4( 0.1995908, 0.7155456, 0.8368256, 0 );
					float4 ifLocalVar61_g128184 = 0;
					if( Resolution44_g128184 <= 256.0 )
					ifLocalVar61_g128184 = color62_g128184;
					float4 color55_g128184 = IsGammaSpace() ? float4( 0.1933962, 0.7383016, 1, 0 ) : float4( 0.03108436, 0.5044825, 1, 0 );
					float4 ifLocalVar56_g128184 = 0;
					if( Resolution44_g128184 == 512.0 )
					ifLocalVar56_g128184 = color55_g128184;
					float4 color42_g128184 = IsGammaSpace() ? float4( 0.4431373, 0.7921569, 0.1764706, 0 ) : float4( 0.1651322, 0.5906189, 0.02624122, 0 );
					float4 ifLocalVar40_g128184 = 0;
					if( Resolution44_g128184 == 1024.0 )
					ifLocalVar40_g128184 = color42_g128184;
					float4 color48_g128184 = IsGammaSpace() ? float4( 1, 0.6889491, 0.07075471, 0 ) : float4( 1, 0.4324122, 0.006068094, 0 );
					float4 ifLocalVar47_g128184 = 0;
					if( Resolution44_g128184 == 2048.0 )
					ifLocalVar47_g128184 = color48_g128184;
					float4 color51_g128184 = IsGammaSpace() ? float4( 1, 0.2066492, 0.0990566, 0 ) : float4( 1, 0.03521443, 0.009877041, 0 );
					float4 ifLocalVar52_g128184 = 0;
					if( Resolution44_g128184 >= 4096.0 )
					ifLocalVar52_g128184 = color51_g128184;
					float4 ifLocalVar40_g128171 = 0;
					if( Debug_Index464_g128148 == 2.0 )
					ifLocalVar40_g128171 = ( ifLocalVar61_g128184 + ifLocalVar56_g128184 + ifLocalVar40_g128184 + ifLocalVar47_g128184 + ifLocalVar52_g128184 );
					float Resolution44_g128191 = max( _SecondAlbedoTex_TexelSize.z, _SecondAlbedoTex_TexelSize.w );
					float4 color62_g128191 = IsGammaSpace() ? float4( 0.484069, 0.862666, 0.9245283, 0 ) : float4( 0.1995908, 0.7155456, 0.8368256, 0 );
					float4 ifLocalVar61_g128191 = 0;
					if( Resolution44_g128191 <= 256.0 )
					ifLocalVar61_g128191 = color62_g128191;
					float4 color55_g128191 = IsGammaSpace() ? float4( 0.1933962, 0.7383016, 1, 0 ) : float4( 0.03108436, 0.5044825, 1, 0 );
					float4 ifLocalVar56_g128191 = 0;
					if( Resolution44_g128191 == 512.0 )
					ifLocalVar56_g128191 = color55_g128191;
					float4 color42_g128191 = IsGammaSpace() ? float4( 0.4431373, 0.7921569, 0.1764706, 0 ) : float4( 0.1651322, 0.5906189, 0.02624122, 0 );
					float4 ifLocalVar40_g128191 = 0;
					if( Resolution44_g128191 == 1024.0 )
					ifLocalVar40_g128191 = color42_g128191;
					float4 color48_g128191 = IsGammaSpace() ? float4( 1, 0.6889491, 0.07075471, 0 ) : float4( 1, 0.4324122, 0.006068094, 0 );
					float4 ifLocalVar47_g128191 = 0;
					if( Resolution44_g128191 == 2048.0 )
					ifLocalVar47_g128191 = color48_g128191;
					float4 color51_g128191 = IsGammaSpace() ? float4( 1, 0.2066492, 0.0990566, 0 ) : float4( 1, 0.03521443, 0.009877041, 0 );
					float4 ifLocalVar52_g128191 = 0;
					if( Resolution44_g128191 >= 4096.0 )
					ifLocalVar52_g128191 = color51_g128191;
					float4 ifLocalVar40_g128178 = 0;
					if( Debug_Index464_g128148 == 3.0 )
					ifLocalVar40_g128178 = ( ifLocalVar61_g128191 + ifLocalVar56_g128191 + ifLocalVar40_g128191 + ifLocalVar47_g128191 + ifLocalVar52_g128191 );
					float Resolution44_g128190 = max( _SecondMaskTex_TexelSize.z, _SecondMaskTex_TexelSize.w );
					float4 color62_g128190 = IsGammaSpace() ? float4( 0.484069, 0.862666, 0.9245283, 0 ) : float4( 0.1995908, 0.7155456, 0.8368256, 0 );
					float4 ifLocalVar61_g128190 = 0;
					if( Resolution44_g128190 <= 256.0 )
					ifLocalVar61_g128190 = color62_g128190;
					float4 color55_g128190 = IsGammaSpace() ? float4( 0.1933962, 0.7383016, 1, 0 ) : float4( 0.03108436, 0.5044825, 1, 0 );
					float4 ifLocalVar56_g128190 = 0;
					if( Resolution44_g128190 == 512.0 )
					ifLocalVar56_g128190 = color55_g128190;
					float4 color42_g128190 = IsGammaSpace() ? float4( 0.4431373, 0.7921569, 0.1764706, 0 ) : float4( 0.1651322, 0.5906189, 0.02624122, 0 );
					float4 ifLocalVar40_g128190 = 0;
					if( Resolution44_g128190 == 1024.0 )
					ifLocalVar40_g128190 = color42_g128190;
					float4 color48_g128190 = IsGammaSpace() ? float4( 1, 0.6889491, 0.07075471, 0 ) : float4( 1, 0.4324122, 0.006068094, 0 );
					float4 ifLocalVar47_g128190 = 0;
					if( Resolution44_g128190 == 2048.0 )
					ifLocalVar47_g128190 = color48_g128190;
					float4 color51_g128190 = IsGammaSpace() ? float4( 1, 0.2066492, 0.0990566, 0 ) : float4( 1, 0.03521443, 0.009877041, 0 );
					float4 ifLocalVar52_g128190 = 0;
					if( Resolution44_g128190 >= 4096.0 )
					ifLocalVar52_g128190 = color51_g128190;
					float4 ifLocalVar40_g128176 = 0;
					if( Debug_Index464_g128148 == 4.0 )
					ifLocalVar40_g128176 = ( ifLocalVar61_g128190 + ifLocalVar56_g128190 + ifLocalVar40_g128190 + ifLocalVar47_g128190 + ifLocalVar52_g128190 );
					float Resolution44_g128192 = max( _SecondAlbedoTex_TexelSize.z, _SecondAlbedoTex_TexelSize.w );
					float4 color62_g128192 = IsGammaSpace() ? float4( 0.484069, 0.862666, 0.9245283, 0 ) : float4( 0.1995908, 0.7155456, 0.8368256, 0 );
					float4 ifLocalVar61_g128192 = 0;
					if( Resolution44_g128192 <= 256.0 )
					ifLocalVar61_g128192 = color62_g128192;
					float4 color55_g128192 = IsGammaSpace() ? float4( 0.1933962, 0.7383016, 1, 0 ) : float4( 0.03108436, 0.5044825, 1, 0 );
					float4 ifLocalVar56_g128192 = 0;
					if( Resolution44_g128192 == 512.0 )
					ifLocalVar56_g128192 = color55_g128192;
					float4 color42_g128192 = IsGammaSpace() ? float4( 0.4431373, 0.7921569, 0.1764706, 0 ) : float4( 0.1651322, 0.5906189, 0.02624122, 0 );
					float4 ifLocalVar40_g128192 = 0;
					if( Resolution44_g128192 == 1024.0 )
					ifLocalVar40_g128192 = color42_g128192;
					float4 color48_g128192 = IsGammaSpace() ? float4( 1, 0.6889491, 0.07075471, 0 ) : float4( 1, 0.4324122, 0.006068094, 0 );
					float4 ifLocalVar47_g128192 = 0;
					if( Resolution44_g128192 == 2048.0 )
					ifLocalVar47_g128192 = color48_g128192;
					float4 color51_g128192 = IsGammaSpace() ? float4( 1, 0.2066492, 0.0990566, 0 ) : float4( 1, 0.03521443, 0.009877041, 0 );
					float4 ifLocalVar52_g128192 = 0;
					if( Resolution44_g128192 >= 4096.0 )
					ifLocalVar52_g128192 = color51_g128192;
					float4 ifLocalVar40_g128177 = 0;
					if( Debug_Index464_g128148 == 5.0 )
					ifLocalVar40_g128177 = ( ifLocalVar61_g128192 + ifLocalVar56_g128192 + ifLocalVar40_g128192 + ifLocalVar47_g128192 + ifLocalVar52_g128192 );
					float Resolution44_g128189 = max( _EmissiveTex_TexelSize.z, _EmissiveTex_TexelSize.w );
					float4 color62_g128189 = IsGammaSpace() ? float4( 0.484069, 0.862666, 0.9245283, 0 ) : float4( 0.1995908, 0.7155456, 0.8368256, 0 );
					float4 ifLocalVar61_g128189 = 0;
					if( Resolution44_g128189 <= 256.0 )
					ifLocalVar61_g128189 = color62_g128189;
					float4 color55_g128189 = IsGammaSpace() ? float4( 0.1933962, 0.7383016, 1, 0 ) : float4( 0.03108436, 0.5044825, 1, 0 );
					float4 ifLocalVar56_g128189 = 0;
					if( Resolution44_g128189 == 512.0 )
					ifLocalVar56_g128189 = color55_g128189;
					float4 color42_g128189 = IsGammaSpace() ? float4( 0.4431373, 0.7921569, 0.1764706, 0 ) : float4( 0.1651322, 0.5906189, 0.02624122, 0 );
					float4 ifLocalVar40_g128189 = 0;
					if( Resolution44_g128189 == 1024.0 )
					ifLocalVar40_g128189 = color42_g128189;
					float4 color48_g128189 = IsGammaSpace() ? float4( 1, 0.6889491, 0.07075471, 0 ) : float4( 1, 0.4324122, 0.006068094, 0 );
					float4 ifLocalVar47_g128189 = 0;
					if( Resolution44_g128189 == 2048.0 )
					ifLocalVar47_g128189 = color48_g128189;
					float4 color51_g128189 = IsGammaSpace() ? float4( 1, 0.2066492, 0.0990566, 0 ) : float4( 1, 0.03521443, 0.009877041, 0 );
					float4 ifLocalVar52_g128189 = 0;
					if( Resolution44_g128189 >= 4096.0 )
					ifLocalVar52_g128189 = color51_g128189;
					float4 ifLocalVar40_g128179 = 0;
					if( Debug_Index464_g128148 == 6.0 )
					ifLocalVar40_g128179 = ( ifLocalVar61_g128189 + ifLocalVar56_g128189 + ifLocalVar40_g128189 + ifLocalVar47_g128189 + ifLocalVar52_g128189 );
					float4 Output_Resolution737_g128148 = ( ( ifLocalVar40_g128172 + ifLocalVar40_g128170 + ifLocalVar40_g128171 ) + ( ifLocalVar40_g128178 + ifLocalVar40_g128176 + ifLocalVar40_g128177 ) + ifLocalVar40_g128179 );
					float4 ifLocalVar40_g128216 = 0;
					if( Debug_Type367_g128148 == 7.0 )
					ifLocalVar40_g128216 = Output_Resolution737_g128148;
					float2 uv_MainAlbedoTex65_g128197 = IN.ase_texcoord4.xy;
					float2 UVs72_g128197 = Main_UVs1219_g128148;
					float Resolution44_g128197 = max( _MainAlbedoTex_TexelSize.z, _MainAlbedoTex_TexelSize.w );
					float4 tex2DNode77_g128197 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g128197 * ( Resolution44_g128197 / 8.0 ) ) );
					float4 lerpResult78_g128197 = lerp( SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, uv_MainAlbedoTex65_g128197 ) , tex2DNode77_g128197 , tex2DNode77_g128197.a);
					float4 ifLocalVar40_g128175 = 0;
					if( Debug_Index464_g128148 == 0.0 )
					ifLocalVar40_g128175 = lerpResult78_g128197;
					float2 uv_MainNormalTex65_g128188 = IN.ase_texcoord4.xy;
					float2 UVs72_g128188 = Main_UVs1219_g128148;
					float Resolution44_g128188 = max( _MainNormalTex_TexelSize.z, _MainNormalTex_TexelSize.w );
					float4 tex2DNode77_g128188 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g128188 * ( Resolution44_g128188 / 8.0 ) ) );
					float4 lerpResult78_g128188 = lerp( SAMPLE_TEXTURE2D( _MainNormalTex, sampler_MainNormalTex, uv_MainNormalTex65_g128188 ) , tex2DNode77_g128188 , tex2DNode77_g128188.a);
					float4 ifLocalVar40_g128173 = 0;
					if( Debug_Index464_g128148 == 1.0 )
					ifLocalVar40_g128173 = lerpResult78_g128188;
					float2 uv_MainMaskTex65_g128187 = IN.ase_texcoord4.xy;
					float2 UVs72_g128187 = Main_UVs1219_g128148;
					float Resolution44_g128187 = max( _MainMaskTex_TexelSize.z, _MainMaskTex_TexelSize.w );
					float4 tex2DNode77_g128187 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g128187 * ( Resolution44_g128187 / 8.0 ) ) );
					float4 lerpResult78_g128187 = lerp( SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, uv_MainMaskTex65_g128187 ) , tex2DNode77_g128187 , tex2DNode77_g128187.a);
					float4 ifLocalVar40_g128174 = 0;
					if( Debug_Index464_g128148 == 2.0 )
					ifLocalVar40_g128174 = lerpResult78_g128187;
					float2 uv_SecondAlbedoTex65_g128195 = IN.ase_texcoord4.xy;
					float2 UVs72_g128195 = Layer_02_UVs1234_g128148;
					float Resolution44_g128195 = max( _SecondAlbedoTex_TexelSize.z, _SecondAlbedoTex_TexelSize.w );
					float4 tex2DNode77_g128195 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g128195 * ( Resolution44_g128195 / 8.0 ) ) );
					float4 lerpResult78_g128195 = lerp( SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, uv_SecondAlbedoTex65_g128195 ) , tex2DNode77_g128195 , tex2DNode77_g128195.a);
					float4 ifLocalVar40_g128182 = 0;
					if( Debug_Index464_g128148 == 3.0 )
					ifLocalVar40_g128182 = lerpResult78_g128195;
					float2 uv_SecondMaskTex65_g128194 = IN.ase_texcoord4.xy;
					float2 UVs72_g128194 = Layer_02_UVs1234_g128148;
					float Resolution44_g128194 = max( _SecondMaskTex_TexelSize.z, _SecondMaskTex_TexelSize.w );
					float4 tex2DNode77_g128194 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g128194 * ( Resolution44_g128194 / 8.0 ) ) );
					float4 lerpResult78_g128194 = lerp( SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, uv_SecondMaskTex65_g128194 ) , tex2DNode77_g128194 , tex2DNode77_g128194.a);
					float4 ifLocalVar40_g128180 = 0;
					if( Debug_Index464_g128148 == 4.0 )
					ifLocalVar40_g128180 = lerpResult78_g128194;
					float2 uv_SecondAlbedoTex65_g128196 = IN.ase_texcoord4.xy;
					float2 UVs72_g128196 = Layer_02_UVs1234_g128148;
					float Resolution44_g128196 = max( _SecondAlbedoTex_TexelSize.z, _SecondAlbedoTex_TexelSize.w );
					float4 tex2DNode77_g128196 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g128196 * ( Resolution44_g128196 / 8.0 ) ) );
					float4 lerpResult78_g128196 = lerp( SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, uv_SecondAlbedoTex65_g128196 ) , tex2DNode77_g128196 , tex2DNode77_g128196.a);
					float4 ifLocalVar40_g128181 = 0;
					if( Debug_Index464_g128148 == 5.0 )
					ifLocalVar40_g128181 = lerpResult78_g128196;
					float2 uv_EmissiveTex65_g128193 = IN.ase_texcoord4.xy;
					float2 UVs72_g128193 = Emissive_UVs1245_g128148;
					float Resolution44_g128193 = max( _EmissiveTex_TexelSize.z, _EmissiveTex_TexelSize.w );
					float4 tex2DNode77_g128193 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g128193 * ( Resolution44_g128193 / 8.0 ) ) );
					float4 lerpResult78_g128193 = lerp( SAMPLE_TEXTURE2D( _EmissiveTex, sampler_EmissiveTex, uv_EmissiveTex65_g128193 ) , tex2DNode77_g128193 , tex2DNode77_g128193.a);
					float4 ifLocalVar40_g128183 = 0;
					if( Debug_Index464_g128148 == 6.0 )
					ifLocalVar40_g128183 = lerpResult78_g128193;
					float4 Output_MipLevel1284_g128148 = ( ( ifLocalVar40_g128175 + ifLocalVar40_g128173 + ifLocalVar40_g128174 ) + ( ifLocalVar40_g128182 + ifLocalVar40_g128180 + ifLocalVar40_g128181 ) + ifLocalVar40_g128183 );
					float4 ifLocalVar40_g128217 = 0;
					if( Debug_Type367_g128148 == 8.0 )
					ifLocalVar40_g128217 = Output_MipLevel1284_g128148;
					float ifLocalVar40_g128375 = 0;
					if( Debug_Index464_g128148 == 0.0 )
					ifLocalVar40_g128375 = (float3( 0,0,0 )).z;
					float4 temp_output_203_0_g128239 = TVE_CoatBaseCoord;
					float3 WorldPosition893_g128148 = PositionWS;
					float2 temp_output_81_0_g128239 = WorldPosition893_g128148.xy;
					float Debug_Layer885_g128148 = TVE_DEBUG_Layer;
					float temp_output_82_0_g128237 = Debug_Layer885_g128148;
					float temp_output_82_0_g128239 = temp_output_82_0_g128237;
					float4 tex2DArrayNode83_g128239 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128239).zw + ( (temp_output_203_0_g128239).xy * temp_output_81_0_g128239 ) ),temp_output_82_0_g128239) );
					float4 appendResult210_g128239 = (float4(tex2DArrayNode83_g128239.rgb , saturate( tex2DArrayNode83_g128239.a )));
					float4 temp_output_204_0_g128239 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g128239 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128239).zw + ( (temp_output_204_0_g128239).xy * temp_output_81_0_g128239 ) ),temp_output_82_0_g128239) );
					float4 appendResult212_g128239 = (float4(tex2DArrayNode122_g128239.rgb , saturate( tex2DArrayNode122_g128239.a )));
					float4 lerpResult131_g128239 = lerp( appendResult210_g128239 , appendResult212_g128239 , 0.0);
					float4 temp_output_159_109_g128237 = lerpResult131_g128239;
					float4 lerpResult168_g128237 = lerp( TVE_CoatParams , temp_output_159_109_g128237 , TVE_CoatLayers[(int)temp_output_82_0_g128237]);
					float ifLocalVar40_g128253 = 0;
					if( Debug_Index464_g128148 == 1.0 )
					ifLocalVar40_g128253 = (lerpResult168_g128237).y;
					float4 temp_output_203_0_g128247 = TVE_CoatBaseCoord;
					float2 temp_output_81_0_g128247 = WorldPosition893_g128148.xy;
					float temp_output_82_0_g128245 = Debug_Layer885_g128148;
					float temp_output_82_0_g128247 = temp_output_82_0_g128245;
					float4 tex2DArrayNode83_g128247 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128247).zw + ( (temp_output_203_0_g128247).xy * temp_output_81_0_g128247 ) ),temp_output_82_0_g128247) );
					float4 appendResult210_g128247 = (float4(tex2DArrayNode83_g128247.rgb , saturate( tex2DArrayNode83_g128247.a )));
					float4 temp_output_204_0_g128247 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g128247 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128247).zw + ( (temp_output_204_0_g128247).xy * temp_output_81_0_g128247 ) ),temp_output_82_0_g128247) );
					float4 appendResult212_g128247 = (float4(tex2DArrayNode122_g128247.rgb , saturate( tex2DArrayNode122_g128247.a )));
					float4 lerpResult131_g128247 = lerp( appendResult210_g128247 , appendResult212_g128247 , 0.0);
					float4 temp_output_159_109_g128245 = lerpResult131_g128247;
					float4 lerpResult168_g128245 = lerp( TVE_CoatParams , temp_output_159_109_g128245 , TVE_CoatLayers[(int)temp_output_82_0_g128245]);
					float ifLocalVar40_g128254 = 0;
					if( Debug_Index464_g128148 == 2.0 )
					ifLocalVar40_g128254 = (lerpResult168_g128245).z;
					float4 temp_output_203_0_g128266 = TVE_PaintBaseCoord;
					float2 temp_output_81_0_g128266 = WorldPosition893_g128148.xy;
					float temp_output_82_0_g128263 = Debug_Layer885_g128148;
					float temp_output_82_0_g128266 = temp_output_82_0_g128263;
					float4 tex2DArrayNode83_g128266 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128266).zw + ( (temp_output_203_0_g128266).xy * temp_output_81_0_g128266 ) ),temp_output_82_0_g128266) );
					float4 appendResult210_g128266 = (float4(tex2DArrayNode83_g128266.rgb , saturate( tex2DArrayNode83_g128266.a )));
					float4 temp_output_204_0_g128266 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g128266 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128266).zw + ( (temp_output_204_0_g128266).xy * temp_output_81_0_g128266 ) ),temp_output_82_0_g128266) );
					float4 appendResult212_g128266 = (float4(tex2DArrayNode122_g128266.rgb , saturate( tex2DArrayNode122_g128266.a )));
					float4 lerpResult131_g128266 = lerp( appendResult210_g128266 , appendResult212_g128266 , 0.0);
					float4 temp_output_171_109_g128263 = lerpResult131_g128266;
					float4 lerpResult174_g128263 = lerp( TVE_PaintParams , temp_output_171_109_g128263 , TVE_PaintLayers[(int)temp_output_82_0_g128263]);
					float3 ifLocalVar40_g128271 = 0;
					if( Debug_Index464_g128148 == 3.0 )
					ifLocalVar40_g128271 = (lerpResult174_g128263).xyz;
					float4 temp_output_203_0_g128258 = TVE_PaintBaseCoord;
					float2 temp_output_81_0_g128258 = WorldPosition893_g128148.xy;
					float temp_output_82_0_g128255 = Debug_Layer885_g128148;
					float temp_output_82_0_g128258 = temp_output_82_0_g128255;
					float4 tex2DArrayNode83_g128258 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128258).zw + ( (temp_output_203_0_g128258).xy * temp_output_81_0_g128258 ) ),temp_output_82_0_g128258) );
					float4 appendResult210_g128258 = (float4(tex2DArrayNode83_g128258.rgb , saturate( tex2DArrayNode83_g128258.a )));
					float4 temp_output_204_0_g128258 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g128258 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128258).zw + ( (temp_output_204_0_g128258).xy * temp_output_81_0_g128258 ) ),temp_output_82_0_g128258) );
					float4 appendResult212_g128258 = (float4(tex2DArrayNode122_g128258.rgb , saturate( tex2DArrayNode122_g128258.a )));
					float4 lerpResult131_g128258 = lerp( appendResult210_g128258 , appendResult212_g128258 , 0.0);
					float4 temp_output_171_109_g128255 = lerpResult131_g128258;
					float4 lerpResult174_g128255 = lerp( TVE_PaintParams , temp_output_171_109_g128255 , TVE_PaintLayers[(int)temp_output_82_0_g128255]);
					float ifLocalVar40_g128272 = 0;
					if( Debug_Index464_g128148 == 4.0 )
					ifLocalVar40_g128272 = saturate( (lerpResult174_g128255).w );
					float4 temp_output_203_0_g128275 = TVE_GlowBaseCoord;
					float2 temp_output_81_0_g128275 = WorldPosition893_g128148.xy;
					float temp_output_82_0_g128273 = Debug_Layer885_g128148;
					float temp_output_82_0_g128275 = temp_output_82_0_g128273;
					float4 tex2DArrayNode83_g128275 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128275).zw + ( (temp_output_203_0_g128275).xy * temp_output_81_0_g128275 ) ),temp_output_82_0_g128275) );
					float4 appendResult210_g128275 = (float4(tex2DArrayNode83_g128275.rgb , saturate( tex2DArrayNode83_g128275.a )));
					float4 temp_output_204_0_g128275 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g128275 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128275).zw + ( (temp_output_204_0_g128275).xy * temp_output_81_0_g128275 ) ),temp_output_82_0_g128275) );
					float4 appendResult212_g128275 = (float4(tex2DArrayNode122_g128275.rgb , saturate( tex2DArrayNode122_g128275.a )));
					float4 lerpResult131_g128275 = lerp( appendResult210_g128275 , appendResult212_g128275 , 0.0);
					float4 temp_output_159_109_g128273 = lerpResult131_g128275;
					float4 lerpResult167_g128273 = lerp( TVE_GlowParams , temp_output_159_109_g128273 , TVE_GlowLayers[(int)temp_output_82_0_g128273]);
					float3 ifLocalVar40_g128337 = 0;
					if( Debug_Index464_g128148 == 5.0 )
					ifLocalVar40_g128337 = (lerpResult167_g128273).xyz;
					float4 temp_output_203_0_g128331 = TVE_GlowBaseCoord;
					float2 temp_output_81_0_g128331 = WorldPosition893_g128148.xy;
					float temp_output_82_0_g128329 = Debug_Layer885_g128148;
					float temp_output_82_0_g128331 = temp_output_82_0_g128329;
					float4 tex2DArrayNode83_g128331 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128331).zw + ( (temp_output_203_0_g128331).xy * temp_output_81_0_g128331 ) ),temp_output_82_0_g128331) );
					float4 appendResult210_g128331 = (float4(tex2DArrayNode83_g128331.rgb , saturate( tex2DArrayNode83_g128331.a )));
					float4 temp_output_204_0_g128331 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g128331 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128331).zw + ( (temp_output_204_0_g128331).xy * temp_output_81_0_g128331 ) ),temp_output_82_0_g128331) );
					float4 appendResult212_g128331 = (float4(tex2DArrayNode122_g128331.rgb , saturate( tex2DArrayNode122_g128331.a )));
					float4 lerpResult131_g128331 = lerp( appendResult210_g128331 , appendResult212_g128331 , 0.0);
					float4 temp_output_159_109_g128329 = lerpResult131_g128331;
					float4 lerpResult167_g128329 = lerp( TVE_GlowParams , temp_output_159_109_g128329 , TVE_GlowLayers[(int)temp_output_82_0_g128329]);
					float ifLocalVar40_g128338 = 0;
					if( Debug_Index464_g128148 == 6.0 )
					ifLocalVar40_g128338 = saturate( (lerpResult167_g128329).w );
					float4 temp_output_203_0_g128307 = TVE_AtmoBaseCoord;
					float2 temp_output_81_0_g128307 = WorldPosition893_g128148.xy;
					float temp_output_132_0_g128305 = Debug_Layer885_g128148;
					float temp_output_82_0_g128307 = temp_output_132_0_g128305;
					float4 tex2DArrayNode83_g128307 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128307).zw + ( (temp_output_203_0_g128307).xy * temp_output_81_0_g128307 ) ),temp_output_82_0_g128307) );
					float4 appendResult210_g128307 = (float4(tex2DArrayNode83_g128307.rgb , saturate( tex2DArrayNode83_g128307.a )));
					float4 temp_output_204_0_g128307 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g128307 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128307).zw + ( (temp_output_204_0_g128307).xy * temp_output_81_0_g128307 ) ),temp_output_82_0_g128307) );
					float4 appendResult212_g128307 = (float4(tex2DArrayNode122_g128307.rgb , saturate( tex2DArrayNode122_g128307.a )));
					float4 lerpResult131_g128307 = lerp( appendResult210_g128307 , appendResult212_g128307 , 0.0);
					float4 temp_output_137_109_g128305 = lerpResult131_g128307;
					float4 lerpResult145_g128305 = lerp( TVE_AtmoParams , temp_output_137_109_g128305 , TVE_AtmoLayers[(int)temp_output_132_0_g128305]);
					float ifLocalVar40_g128339 = 0;
					if( Debug_Index464_g128148 == 7.0 )
					ifLocalVar40_g128339 = (lerpResult145_g128305).x;
					float4 temp_output_203_0_g128283 = TVE_AtmoBaseCoord;
					float2 temp_output_81_0_g128283 = WorldPosition893_g128148.xy;
					float temp_output_132_0_g128281 = Debug_Layer885_g128148;
					float temp_output_82_0_g128283 = temp_output_132_0_g128281;
					float4 tex2DArrayNode83_g128283 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128283).zw + ( (temp_output_203_0_g128283).xy * temp_output_81_0_g128283 ) ),temp_output_82_0_g128283) );
					float4 appendResult210_g128283 = (float4(tex2DArrayNode83_g128283.rgb , saturate( tex2DArrayNode83_g128283.a )));
					float4 temp_output_204_0_g128283 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g128283 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128283).zw + ( (temp_output_204_0_g128283).xy * temp_output_81_0_g128283 ) ),temp_output_82_0_g128283) );
					float4 appendResult212_g128283 = (float4(tex2DArrayNode122_g128283.rgb , saturate( tex2DArrayNode122_g128283.a )));
					float4 lerpResult131_g128283 = lerp( appendResult210_g128283 , appendResult212_g128283 , 0.0);
					float4 temp_output_137_109_g128281 = lerpResult131_g128283;
					float4 lerpResult145_g128281 = lerp( TVE_AtmoParams , temp_output_137_109_g128281 , TVE_AtmoLayers[(int)temp_output_132_0_g128281]);
					float ifLocalVar40_g128340 = 0;
					if( Debug_Index464_g128148 == 8.0 )
					ifLocalVar40_g128340 = (lerpResult145_g128281).y;
					float4 temp_output_203_0_g128291 = TVE_AtmoBaseCoord;
					float2 temp_output_81_0_g128291 = WorldPosition893_g128148.xy;
					float temp_output_132_0_g128289 = Debug_Layer885_g128148;
					float temp_output_82_0_g128291 = temp_output_132_0_g128289;
					float4 tex2DArrayNode83_g128291 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128291).zw + ( (temp_output_203_0_g128291).xy * temp_output_81_0_g128291 ) ),temp_output_82_0_g128291) );
					float4 appendResult210_g128291 = (float4(tex2DArrayNode83_g128291.rgb , saturate( tex2DArrayNode83_g128291.a )));
					float4 temp_output_204_0_g128291 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g128291 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128291).zw + ( (temp_output_204_0_g128291).xy * temp_output_81_0_g128291 ) ),temp_output_82_0_g128291) );
					float4 appendResult212_g128291 = (float4(tex2DArrayNode122_g128291.rgb , saturate( tex2DArrayNode122_g128291.a )));
					float4 lerpResult131_g128291 = lerp( appendResult210_g128291 , appendResult212_g128291 , 0.0);
					float4 temp_output_137_109_g128289 = lerpResult131_g128291;
					float4 lerpResult145_g128289 = lerp( TVE_AtmoParams , temp_output_137_109_g128289 , TVE_AtmoLayers[(int)temp_output_132_0_g128289]);
					float ifLocalVar40_g128341 = 0;
					if( Debug_Index464_g128148 == 9.0 )
					ifLocalVar40_g128341 = (lerpResult145_g128289).z;
					float4 temp_output_203_0_g128299 = TVE_AtmoBaseCoord;
					float2 temp_output_81_0_g128299 = WorldPosition893_g128148.xy;
					float temp_output_132_0_g128297 = Debug_Layer885_g128148;
					float temp_output_82_0_g128299 = temp_output_132_0_g128297;
					float4 tex2DArrayNode83_g128299 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128299).zw + ( (temp_output_203_0_g128299).xy * temp_output_81_0_g128299 ) ),temp_output_82_0_g128299) );
					float4 appendResult210_g128299 = (float4(tex2DArrayNode83_g128299.rgb , saturate( tex2DArrayNode83_g128299.a )));
					float4 temp_output_204_0_g128299 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g128299 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128299).zw + ( (temp_output_204_0_g128299).xy * temp_output_81_0_g128299 ) ),temp_output_82_0_g128299) );
					float4 appendResult212_g128299 = (float4(tex2DArrayNode122_g128299.rgb , saturate( tex2DArrayNode122_g128299.a )));
					float4 lerpResult131_g128299 = lerp( appendResult210_g128299 , appendResult212_g128299 , 0.0);
					float4 temp_output_137_109_g128297 = lerpResult131_g128299;
					float4 lerpResult145_g128297 = lerp( TVE_AtmoParams , temp_output_137_109_g128297 , TVE_AtmoLayers[(int)temp_output_132_0_g128297]);
					float ifLocalVar40_g128342 = 0;
					if( Debug_Index464_g128148 == 10.0 )
					ifLocalVar40_g128342 = saturate( (lerpResult145_g128297).w );
					float4 temp_output_203_0_g128323 = TVE_FormBaseCoord;
					float2 temp_output_81_0_g128323 = WorldPosition893_g128148.xy;
					float temp_output_130_0_g128321 = Debug_Layer885_g128148;
					float temp_output_82_0_g128323 = temp_output_130_0_g128321;
					float4 tex2DArrayNode83_g128323 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128323).zw + ( (temp_output_203_0_g128323).xy * temp_output_81_0_g128323 ) ),temp_output_82_0_g128323) );
					float4 appendResult210_g128323 = (float4(tex2DArrayNode83_g128323.rgb , saturate( tex2DArrayNode83_g128323.a )));
					float4 temp_output_204_0_g128323 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g128323 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128323).zw + ( (temp_output_204_0_g128323).xy * temp_output_81_0_g128323 ) ),temp_output_82_0_g128323) );
					float4 appendResult212_g128323 = (float4(tex2DArrayNode122_g128323.rgb , saturate( tex2DArrayNode122_g128323.a )));
					float4 lerpResult131_g128323 = lerp( appendResult210_g128323 , appendResult212_g128323 , 0.0);
					float4 temp_output_135_109_g128321 = lerpResult131_g128323;
					float4 lerpResult143_g128321 = lerp( TVE_FormParams , temp_output_135_109_g128321 , TVE_FormLayers[(int)temp_output_130_0_g128321]);
					float3 appendResult1013_g128148 = (float3((lerpResult143_g128321).xy , 0.0));
					float3 ifLocalVar40_g128343 = 0;
					if( Debug_Index464_g128148 == 11.0 )
					ifLocalVar40_g128343 = appendResult1013_g128148;
					float4 temp_output_203_0_g128315 = TVE_FormBaseCoord;
					float2 temp_output_81_0_g128315 = WorldPosition893_g128148.xy;
					float temp_output_130_0_g128313 = Debug_Layer885_g128148;
					float temp_output_82_0_g128315 = temp_output_130_0_g128313;
					float4 tex2DArrayNode83_g128315 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128315).zw + ( (temp_output_203_0_g128315).xy * temp_output_81_0_g128315 ) ),temp_output_82_0_g128315) );
					float4 appendResult210_g128315 = (float4(tex2DArrayNode83_g128315.rgb , saturate( tex2DArrayNode83_g128315.a )));
					float4 temp_output_204_0_g128315 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g128315 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128315).zw + ( (temp_output_204_0_g128315).xy * temp_output_81_0_g128315 ) ),temp_output_82_0_g128315) );
					float4 appendResult212_g128315 = (float4(tex2DArrayNode122_g128315.rgb , saturate( tex2DArrayNode122_g128315.a )));
					float4 lerpResult131_g128315 = lerp( appendResult210_g128315 , appendResult212_g128315 , 0.0);
					float4 temp_output_135_109_g128313 = lerpResult131_g128315;
					float4 lerpResult143_g128313 = lerp( TVE_FormParams , temp_output_135_109_g128313 , TVE_FormLayers[(int)temp_output_130_0_g128313]);
					float ifLocalVar40_g128344 = 0;
					if( Debug_Index464_g128148 == 12.0 )
					ifLocalVar40_g128344 = saturate( (lerpResult143_g128313).z );
					float4 temp_output_203_0_g128367 = TVE_FormBaseCoord;
					float2 temp_output_81_0_g128367 = WorldPosition893_g128148.xy;
					float temp_output_130_0_g128365 = Debug_Layer885_g128148;
					float temp_output_82_0_g128367 = temp_output_130_0_g128365;
					float4 tex2DArrayNode83_g128367 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128367).zw + ( (temp_output_203_0_g128367).xy * temp_output_81_0_g128367 ) ),temp_output_82_0_g128367) );
					float4 appendResult210_g128367 = (float4(tex2DArrayNode83_g128367.rgb , saturate( tex2DArrayNode83_g128367.a )));
					float4 temp_output_204_0_g128367 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g128367 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128367).zw + ( (temp_output_204_0_g128367).xy * temp_output_81_0_g128367 ) ),temp_output_82_0_g128367) );
					float4 appendResult212_g128367 = (float4(tex2DArrayNode122_g128367.rgb , saturate( tex2DArrayNode122_g128367.a )));
					float4 lerpResult131_g128367 = lerp( appendResult210_g128367 , appendResult212_g128367 , 0.0);
					float4 temp_output_135_109_g128365 = lerpResult131_g128367;
					float4 lerpResult143_g128365 = lerp( TVE_FormParams , temp_output_135_109_g128365 , TVE_FormLayers[(int)temp_output_130_0_g128365]);
					float ifLocalVar40_g128373 = 0;
					if( Debug_Index464_g128148 == 13.0 )
					ifLocalVar40_g128373 = saturate( (lerpResult143_g128365).w );
					float4 temp_output_203_0_g128347 = TVE_FlowBaseCoord;
					float2 temp_output_81_0_g128347 = WorldPosition893_g128148.xy;
					float temp_output_136_0_g128345 = Debug_Layer885_g128148;
					float temp_output_82_0_g128347 = temp_output_136_0_g128345;
					float4 tex2DArrayNode83_g128347 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128347).zw + ( (temp_output_203_0_g128347).xy * temp_output_81_0_g128347 ) ),temp_output_82_0_g128347) );
					float4 appendResult210_g128347 = (float4(tex2DArrayNode83_g128347.rgb , saturate( tex2DArrayNode83_g128347.a )));
					float4 temp_output_204_0_g128347 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g128347 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128347).zw + ( (temp_output_204_0_g128347).xy * temp_output_81_0_g128347 ) ),temp_output_82_0_g128347) );
					float4 appendResult212_g128347 = (float4(tex2DArrayNode122_g128347.rgb , saturate( tex2DArrayNode122_g128347.a )));
					float4 lerpResult131_g128347 = lerp( appendResult210_g128347 , appendResult212_g128347 , 0.0);
					float4 temp_output_141_109_g128345 = lerpResult131_g128347;
					float4 lerpResult149_g128345 = lerp( TVE_FlowParams , temp_output_141_109_g128345 , TVE_FlowLayers[(int)temp_output_136_0_g128345]);
					float3 appendResult1012_g128148 = (float3((lerpResult149_g128345).xy , 0.0));
					float3 ifLocalVar40_g128361 = 0;
					if( Debug_Index464_g128148 == 14.0 )
					ifLocalVar40_g128361 = appendResult1012_g128148;
					float4 temp_output_203_0_g128355 = TVE_FlowBaseCoord;
					float2 temp_output_81_0_g128355 = WorldPosition893_g128148.xy;
					float temp_output_136_0_g128353 = Debug_Layer885_g128148;
					float temp_output_82_0_g128355 = temp_output_136_0_g128353;
					float4 tex2DArrayNode83_g128355 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g128355).zw + ( (temp_output_203_0_g128355).xy * temp_output_81_0_g128355 ) ),temp_output_82_0_g128355) );
					float4 appendResult210_g128355 = (float4(tex2DArrayNode83_g128355.rgb , saturate( tex2DArrayNode83_g128355.a )));
					float4 temp_output_204_0_g128355 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g128355 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g128355).zw + ( (temp_output_204_0_g128355).xy * temp_output_81_0_g128355 ) ),temp_output_82_0_g128355) );
					float4 appendResult212_g128355 = (float4(tex2DArrayNode122_g128355.rgb , saturate( tex2DArrayNode122_g128355.a )));
					float4 lerpResult131_g128355 = lerp( appendResult210_g128355 , appendResult212_g128355 , 0.0);
					float4 temp_output_141_109_g128353 = lerpResult131_g128355;
					float4 lerpResult149_g128353 = lerp( TVE_FlowParams , temp_output_141_109_g128353 , TVE_FlowLayers[(int)temp_output_136_0_g128353]);
					float ifLocalVar40_g128362 = 0;
					if( Debug_Index464_g128148 == 15.0 )
					ifLocalVar40_g128362 = (lerpResult149_g128353).z;
					float3 appendResult1780_g128148 = (float3((float4( 0,0,0,0 )).rg , 0.0));
					float3 ifLocalVar40_g128363 = 0;
					if( Debug_Index464_g128148 == 16.0 )
					ifLocalVar40_g128363 = appendResult1780_g128148;
					float ifLocalVar40_g128364 = 0;
					if( Debug_Index464_g128148 == 17.0 )
					ifLocalVar40_g128364 = (float4( 0,0,0,0 )).b;
					float ifLocalVar40_g128374 = 0;
					if( Debug_Index464_g128148 == 18.0 )
					ifLocalVar40_g128374 = saturate( (float4( 0,0,0,0 )).a );
					float temp_output_7_0_g128388 = Debug_Min721_g128148;
					float3 temp_cast_35 = (temp_output_7_0_g128388).xxx;
					float3 temp_output_9_0_g128388 = ( ( ifLocalVar40_g128375 + ( ifLocalVar40_g128253 + ifLocalVar40_g128254 ) + ( ifLocalVar40_g128271 + ifLocalVar40_g128272 ) + ( ifLocalVar40_g128337 + ifLocalVar40_g128338 ) + ( ifLocalVar40_g128339 + ifLocalVar40_g128340 + ifLocalVar40_g128341 + ifLocalVar40_g128342 ) + ( ifLocalVar40_g128343 + ifLocalVar40_g128344 + ifLocalVar40_g128373 ) + ( ifLocalVar40_g128361 + ifLocalVar40_g128362 + ifLocalVar40_g128363 + ifLocalVar40_g128364 + ifLocalVar40_g128374 ) ) - temp_cast_35 );
					float4 appendResult1659_g128148 = (float4(saturate( ( temp_output_9_0_g128388 / ( ( Debug_Max723_g128148 - temp_output_7_0_g128388 ) + 0.0001 ) ) ) , 1.0));
					float4 Output_Globals888_g128148 = appendResult1659_g128148;
					float4 ifLocalVar40_g128218 = 0;
					if( Debug_Type367_g128148 == 9.0 )
					ifLocalVar40_g128218 = Output_Globals888_g128148;
					float3 vertexToFrag328_g128148 = IN.ase_texcoord6.xyz;
					float4 color1016_g128148 = IsGammaSpace() ? float4( 0.5831653, 0.6037736, 0.2135992, 0 ) : float4( 0.2992498, 0.3229691, 0.03750122, 0 );
					float4 color1017_g128148 = IsGammaSpace() ? float4( 0.8117647, 0.3488252, 0.2627451, 0 ) : float4( 0.6239604, 0.0997834, 0.05612849, 0 );
					float4 switchResult1015_g128148 = (((ase_vface>0)?(color1016_g128148):(color1017_g128148)));
					float3 ifLocalVar40_g128152 = 0;
					if( Debug_Index464_g128148 == 4.0 )
					ifLocalVar40_g128152 = (switchResult1015_g128148).rgb;
					float temp_output_7_0_g128208 = Debug_Min721_g128148;
					float3 temp_cast_36 = (temp_output_7_0_g128208).xxx;
					float3 temp_output_9_0_g128208 = ( ( vertexToFrag328_g128148 + ifLocalVar40_g128152 ) - temp_cast_36 );
					float4 appendResult1658_g128148 = (float4(saturate( ( temp_output_9_0_g128208 / ( ( Debug_Max723_g128148 - temp_output_7_0_g128208 ) + 0.0001 ) ) ) , 1.0));
					float4 Output_Mesh316_g128148 = appendResult1658_g128148;
					float4 ifLocalVar40_g128220 = 0;
					if( Debug_Type367_g128148 == 11.0 )
					ifLocalVar40_g128220 = Output_Mesh316_g128148;
					float _IsTVEShader647_g128148 = _IsTVEShader;
					float Debug_Filter322_g128148 = TVE_DEBUG_Filter;
					float lerpResult1524_g128148 = lerp( 1.0 , _IsTVEShader647_g128148 , Debug_Filter322_g128148);
					float4 lerpResult1517_g128148 = lerp( Shading_Inactive1492_g128148 , ( ( ifLocalVar40_g128209 + ifLocalVar40_g128211 + ifLocalVar40_g128212 + ifLocalVar40_g128213 + ifLocalVar40_g128214 ) + ( ifLocalVar40_g128215 + ifLocalVar40_g128216 + ifLocalVar40_g128217 ) + ( ifLocalVar40_g128218 + ifLocalVar40_g128220 ) ) , lerpResult1524_g128148);
					float dotResult1472_g128148 = dot( NormalWS , ViewDirWS );
					float temp_output_1526_0_g128148 = ( 1.0 - saturate( dotResult1472_g128148 ) );
					float Shading_Fresnel1469_g128148 = (( 1.0 - ( temp_output_1526_0_g128148 * temp_output_1526_0_g128148 ) )*0.3 + 0.7);
					float Debug_Shading1653_g128148 = TVE_DEBUG_Shading;
					float lerpResult1655_g128148 = lerp( 1.0 , Shading_Fresnel1469_g128148 , Debug_Shading1653_g128148);
					float2 uv_MainAlbedoTex728_g128148 = IN.ase_texcoord4.xy;
					float Debug_Clip623_g128148 = TVE_DEBUG_Clip;
					float lerpResult622_g128148 = lerp( 1.0 , SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, uv_MainAlbedoTex728_g128148 ).a , ( Debug_Clip623_g128148 * _RenderClip ));
					clip( lerpResult622_g128148 - _MainAlphaClipValue);
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = half3( 0, 0, 0 );
					half Metallic = 0.0;
					half Smoothness = 0.0;
					half Occlusion = 1;

					#if defined(ASE_LIGHTING_SIMPLE)
						o.Specular = Specular.x;
						o.Gloss = Smoothness;
					#else
						#if defined(_SPECULAR_SETUP)
							o.Specular = Specular;
						#else
							o.Metallic = Metallic;
						#endif
						o.Occlusion = Occlusion;
						o.Smoothness = Smoothness;
					#endif

					o.Emission = ( lerpResult1517_g128148 * lerpResult1655_g128148 ).rgb;
					o.Alpha = 1;

					half3 BakedGI = 0;

					#if defined( ASE_DEPTH_WRITE_ON )
						float DeviceDepth = IN.pos.z;
					#endif

					#if ( ASE_FRAGMENT_NORMAL == 0 )
						o.Normal = normalize( o.Normal.x * TangentWS + o.Normal.y * BitangentWS + o.Normal.z * NormalWS );
					#elif ( ASE_FRAGMENT_NORMAL == 1 )
						o.Normal = UnityObjectToWorldNormal( o.Normal );
					#elif ( ASE_FRAGMENT_NORMAL == 2 )
						// @diogo: already in world-space; do nothing
					#endif

					#ifdef _ALPHATEST_ON
						clip( o.Alpha - AlphaClipThreshold );
					#endif

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = DeviceDepth;
					#endif

					#ifndef USING_DIRECTIONAL_LIGHT
						half3 lightDir = normalize( UnityWorldSpaceLightDir( PositionWS ) );
					#else
						half3 lightDir = _WorldSpaceLightPos0.xyz;
					#endif

					UnityGI gi;
					UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
					gi.indirect.diffuse = 0;
					gi.indirect.specular = 0;
					gi.light.color = 0;
					gi.light.dir = half3( 0, 1, 0 );

					UnityGIInput giInput;
					UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
					giInput.light = gi.light;
					giInput.worldPos = PositionWS;
					giInput.worldViewDir = ViewDirWS;
					giInput.atten = 1;
					#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
						giInput.lightmapUV = IN.ambientOrLightmapUV;
					#else
						giInput.lightmapUV = 0.0;
					#endif
					#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
						giInput.ambient = IN.ambientOrLightmapUV.rgb;
					#else
						giInput.ambient.rgb = 0.0;
					#endif
					giInput.probeHDR[0] = unity_SpecCube0_HDR;
					giInput.probeHDR[1] = unity_SpecCube1_HDR;
					#if defined(UNITY_SPECCUBE_BLENDING) || defined(UNITY_SPECCUBE_BOX_PROJECTION)
						giInput.boxMin[0] = unity_SpecCube0_BoxMin;
					#endif
					#ifdef UNITY_SPECCUBE_BOX_PROJECTION
						giInput.boxMax[0] = unity_SpecCube0_BoxMax;
						giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
						giInput.boxMax[1] = unity_SpecCube1_BoxMax;
						giInput.boxMin[1] = unity_SpecCube1_BoxMin;
						giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
					#endif

					#if defined(ASE_LIGHTING_SIMPLE)
						#if defined(_SPECULAR_SETUP)
							LightingBlinnPhong_GI(o, giInput, gi);
						#else
							LightingLambert_GI(o, giInput, gi);
						#endif
					#else
						#if defined(_SPECULAR_SETUP)
							LightingStandardSpecular_GI(o, giInput, gi);
						#else
							LightingStandard_GI(o, giInput, gi);
						#endif
					#endif

					#ifdef ASE_BAKEDGI
						gi.indirect.diffuse = BakedGI;
					#endif

					#if UNITY_SHOULD_SAMPLE_SH && !defined(LIGHTMAP_ON) && defined(ASE_NO_AMBIENT)
						gi.indirect.diffuse = 0;
					#endif

					#if defined(ASE_LIGHTING_SIMPLE)
						#if defined(_SPECULAR_SETUP)
							outEmission = LightingBlinnPhong_Deferred( o, ViewDirWS, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
						#else
							outEmission = LightingLambert_Deferred( o, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
						#endif
					#else
						#if defined(_SPECULAR_SETUP)
							outEmission = LightingStandardSpecular_Deferred( o, ViewDirWS, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
						#else
							outEmission = LightingStandard_Deferred( o, ViewDirWS, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
						#endif
					#endif

					#if defined(SHADOWS_SHADOWMASK) && (UNITY_ALLOWED_MRT_COUNT > 4)
						outShadowMask = UnityGetRawBakedOcclusions( IN.ambientOrLightmapUV.xy, float3( 0, 0, 0 ) );
					#endif
					#ifndef UNITY_HDR_ON
						outEmission.rgb = exp2(-outEmission.rgb);
					#endif
				}
			ENDCG
		}

		
		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			ZWrite On

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#define ASE_NO_AMBIENT 1
				#pragma multi_compile_instancing
				#define ASE_VERSION 19908
				#define ASE_USING_SAMPLING_MACROS 1

				#pragma vertex vert
				#pragma fragment frag
				#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2

				#pragma multi_compile_fwdbase
				#ifndef UNITY_PASS_FORWARDBASE
					#define UNITY_PASS_FORWARDBASE
				#endif
				#include "HLSLSupport.cginc"
				#if defined( ASE_GEOMETRY ) || defined( ASE_IMPOSTOR )
					#ifndef UNITY_INSTANCED_LOD_FADE
						#define UNITY_INSTANCED_LOD_FADE
					#endif
					#ifndef UNITY_INSTANCED_SH
						#define UNITY_INSTANCED_SH
					#endif
					#ifndef UNITY_INSTANCED_LIGHTMAPSTS
						#define UNITY_INSTANCED_LIGHTMAPSTS
					#endif
				#endif
				#include "UnityShaderVariables.cginc"
				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include "UnityPBSLighting.cginc"
				#include "AutoLight.cginc"

				

				int _ObjectId;
				int _PassValue;

				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float4 worldPos : TEXCOORD0; // xyz = positionWS
					half3 normalWS : TEXCOORD1;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				#ifdef ASE_TESSELLATION
					float _TessPhongStrength;
					float _TessValue;
					float _TessMin;
					float _TessMax;
					float _TessEdgeLength;
					float _TessMaxDisp;
				#endif

				uniform half _Banner;
				uniform half _Message;
				uniform float _IsSimpleShader;
				uniform float _IsVertexShader;
				uniform half _IsTVEShader;


				
				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = defaultVertexValue;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = v.normal;
					v.tangent = v.tangent;

					float3 positionWS = mul( unity_ObjectToWorld, v.vertex ).xyz;
					half3 normalWS = UnityObjectToWorldNormal( v.normal );

					o.pos = UnityObjectToClipPos( v.vertex );
					o.worldPos.xyz = positionWS;
					o.normalWS = normalWS;
					return o;
				}

				#if defined(ASE_TESSELLATION)
				struct VertexControl
				{
					float4 vertex : INTERNALTESSPOS;
					half3 normal : NORMAL;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct TessellationFactors
				{
					float edge[3] : SV_TessFactor;
					float inside : SV_InsideTessFactor;
				};

				VertexControl vert ( appdata v )
				{
					VertexControl o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_TRANSFER_INSTANCE_ID(v, o);
					o.vertex = v.vertex;
					o.normal = v.normal;
					
					return o;
				}

				TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
				{
					TessellationFactors o;
					float4 tf = 1;
					float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
					float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
					#if defined(ASE_FIXED_TESSELLATION)
					tf = FixedTess( tessValue );
					#elif defined(ASE_DISTANCE_TESSELLATION)
					tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
					#elif defined(ASE_LENGTH_TESSELLATION)
					tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
					#elif defined(ASE_LENGTH_CULL_TESSELLATION)
					tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
					#endif
					o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
					return o;
				}

				[domain("tri")]
				[partitioning("fractional_odd")]
				[outputtopology("triangle_cw")]
				[patchconstantfunc("TessellationFunction")]
				[outputcontrolpoints(3)]
				VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
				{
				   return patch[id];
				}

				[domain("tri")]
				v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
				{
					appdata o = (appdata) 0;
					o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
					o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
					
					#if defined(ASE_PHONG_TESSELLATION)
					float3 pp[3];
					for (int i = 0; i < 3; ++i)
						pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
					float phongStrength = _TessPhongStrength;
					o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
					#endif
					UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
					return VertexFunction(o);
				}
				#else
				v2f vert ( appdata v )
				{
					return VertexFunction( v );
				}
				#endif

				half4 frag( v2f IN 
							#if defined( ASE_DEPTH_WRITE_ON )
								, out float outputDepth : SV_Depth
							#endif
							) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID(IN);

					#ifdef LOD_FADE_CROSSFADE
						UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
					#endif

					

					half Alpha = 1;
					half AlphaClipThreshold = 0.5;

					#if defined( ASE_DEPTH_WRITE_ON )
						float DeviceDepth = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = DeviceDepth;
					#endif

					return float4( _ObjectId, _PassValue, 1.0, 1.0 );
				}
			ENDCG
		}

		
		Pass
		{
			
			Name "ScenePickingPass"
			Tags { "LightMode"="ScenePickingPass" }

			ZWrite On

			CGPROGRAM
				#define ASE_GEOMETRY
				#define ASE_FRAGMENT_NORMAL 0
				#define ASE_NO_AMBIENT 1
				#pragma multi_compile_instancing
				#define ASE_VERSION 19908
				#define ASE_USING_SAMPLING_MACROS 1

				#pragma vertex vert
				#pragma fragment frag
				#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2

				#pragma multi_compile_fwdbase
				#ifndef UNITY_PASS_FORWARDBASE
					#define UNITY_PASS_FORWARDBASE
				#endif
				#include "HLSLSupport.cginc"
				#if defined( ASE_GEOMETRY ) || defined( ASE_IMPOSTOR )
					#ifndef UNITY_INSTANCED_LOD_FADE
						#define UNITY_INSTANCED_LOD_FADE
					#endif
					#ifndef UNITY_INSTANCED_SH
						#define UNITY_INSTANCED_SH
					#endif
					#ifndef UNITY_INSTANCED_LIGHTMAPSTS
						#define UNITY_INSTANCED_LIGHTMAPSTS
					#endif
				#endif
				#include "UnityShaderVariables.cginc"
				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include "UnityPBSLighting.cginc"
				#include "AutoLight.cginc"

				

				float4 _SelectionID;

				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float4 worldPos : TEXCOORD0; // xyz = positionWS
					half3 normalWS : TEXCOORD1;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				#ifdef ASE_TESSELLATION
					float _TessPhongStrength;
					float _TessValue;
					float _TessMin;
					float _TessMax;
					float _TessEdgeLength;
					float _TessMaxDisp;
				#endif

				uniform half _Banner;
				uniform half _Message;
				uniform float _IsSimpleShader;
				uniform float _IsVertexShader;
				uniform half _IsTVEShader;


				
				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = defaultVertexValue;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = v.normal;
					v.tangent = v.tangent;

					float3 positionWS = mul( unity_ObjectToWorld, v.vertex ).xyz;
					half3 normalWS = UnityObjectToWorldNormal( v.normal );

					o.pos = UnityObjectToClipPos( v.vertex );
					o.worldPos.xyz = positionWS;
					o.normalWS = normalWS;
					return o;
				}

				#if defined(ASE_TESSELLATION)
				struct VertexControl
				{
					float4 vertex : INTERNALTESSPOS;
					half3 normal : NORMAL;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct TessellationFactors
				{
					float edge[3] : SV_TessFactor;
					float inside : SV_InsideTessFactor;
				};

				VertexControl vert ( appdata v )
				{
					VertexControl o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_TRANSFER_INSTANCE_ID(v, o);
					o.vertex = v.vertex;
					o.normal = v.normal;
					
					return o;
				}

				TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
				{
					TessellationFactors o;
					float4 tf = 1;
					float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
					float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
					#if defined(ASE_FIXED_TESSELLATION)
					tf = FixedTess( tessValue );
					#elif defined(ASE_DISTANCE_TESSELLATION)
					tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
					#elif defined(ASE_LENGTH_TESSELLATION)
					tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
					#elif defined(ASE_LENGTH_CULL_TESSELLATION)
					tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
					#endif
					o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
					return o;
				}

				[domain("tri")]
				[partitioning("fractional_odd")]
				[outputtopology("triangle_cw")]
				[patchconstantfunc("TessellationFunction")]
				[outputcontrolpoints(3)]
				VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
				{
				   return patch[id];
				}

				[domain("tri")]
				v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
				{
					appdata o = (appdata) 0;
					o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
					o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
					
					#if defined(ASE_PHONG_TESSELLATION)
					float3 pp[3];
					for (int i = 0; i < 3; ++i)
						pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
					float phongStrength = _TessPhongStrength;
					o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
					#endif
					UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
					return VertexFunction(o);
				}
				#else
				v2f vert ( appdata v )
				{
					return VertexFunction( v );
				}
				#endif

				half4 frag( v2f IN 
							#if defined( ASE_DEPTH_WRITE_ON )
								, out float outputDepth : SV_Depth
							#endif
							) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID(IN);

					#ifdef LOD_FADE_CROSSFADE
						UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
					#endif

					

					half Alpha = 1;
					half AlphaClipThreshold = 0.5;

					#if defined( ASE_DEPTH_WRITE_ON )
						float DeviceDepth = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = DeviceDepth;
					#endif

					return _SelectionID;
				}
			ENDCG
		}
		
	}
	
	
	Fallback Off
}
/*ASEBEGIN
Version=19908
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2155;-1792,-5248;Half;False;Global;TVE_DEBUG_Layer;TVE_DEBUG_Layer;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2013;-1792,-5312;Half;False;Global;TVE_DEBUG_Index;TVE_DEBUG_Index;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1908;-1792,-5376;Half;False;Global;TVE_DEBUG_Type;TVE_DEBUG_Type;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2069;-1792,-4992;Half;False;Global;TVE_DEBUG_Min;TVE_DEBUG_Min;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2032;-1792,-5056;Half;False;Global;TVE_DEBUG_Clip;TVE_DEBUG_Clip;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2070;-1792,-4928;Half;False;Global;TVE_DEBUG_Max;TVE_DEBUG_Max;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1953;-1792,-5184;Half;False;Global;TVE_DEBUG_Filter;TVE_DEBUG_Filter;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2329;-1792,-5120;Half;False;Global;TVE_DEBUG_Shading;TVE_DEBUG_Shading;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1774;-880,2944;Inherit;False;True;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1803;-1344,2944;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1878;-1792,-5632;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;0;True;1;StyledBanner(Debug);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1772;-1088,3072;Float;False;Constant;_Float3;Float 3;31;0;Create;True;0;0;0;False;0;False;24;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1931;-1408,-5632;Half;False;Property;_DebugCategory;[ Debug Category ];128;0;Create;True;0;0;0;False;1;StyledCategory(Debug Settings, 5, 10);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1843;-1632,2944;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1771;-1088,2944;Inherit;False;-1;;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1800;-1472,2944;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1804;-1792,2944;Inherit;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1881;-1600,-5632;Half;False;Property;_Message;Message;129;0;Create;True;0;0;0;True;1;StyledMessage(Info, Use this shader to debug the original mesh or the converted mesh attributes., 0,0);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2203;-896,-5632;Inherit;False;Base Compile;-1;;73162;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2359;-1152,-5376;Inherit;False;Constant;_Float4;Float 4;36;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2362;-1408,-5376;Inherit;False;Tool Debug;1;;128148;d48cde928c5068141abea1713047719b;1,1236,0;8;336;FLOAT;0;False;465;FLOAT;0;False;884;FLOAT;0;False;337;FLOAT;0;False;1652;FLOAT;0;False;624;FLOAT;0;False;720;FLOAT;0;False;722;FLOAT;0;False;1;COLOR;338
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2353;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ExtraPrePass;0;0;ExtraPrePass;5;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2354;-896,-5376;Float;False;True;-1;3;;0;3;Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug;28cd5599e02859647ae1798e4fcaef6c;True;ForwardBase;0;1;ForwardBase;15;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;40;Category;0;0;Workflow;1;0;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;0;638807808135481458;Deferred Pass;1;0;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;638814711411603618;Receive Shadows;0;638814711415148256;Receive Specular;0;638814711419031593;GPU Instancing;1;638814711475283133;LOD CrossFade;0;638814711429956434;Built-in Fog;0;638814711441065168;Ambient Light;0;638814711449050123;Meta Pass;0;638814711456998358;Add Pass;0;638814711466594157;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;0;Vertex Position;1;0;0;8;False;True;False;True;False;False;True;True;False;;True;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2355;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2356;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2357;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2358;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2363;-896,-5316;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2364;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ScenePickingPass;0;7;ScenePickingPass;1;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=ScenePickingPass;False;False;0;;0;0;Standard;0;False;0
WireConnection;1774;0;1771;0
WireConnection;1774;1;1772;0
WireConnection;1774;3;1803;0
WireConnection;1803;0;1800;0
WireConnection;1843;0;1804;0
WireConnection;1800;0;1843;0
WireConnection;2362;336;1908;0
WireConnection;2362;465;2013;0
WireConnection;2362;884;2155;0
WireConnection;2362;337;1953;0
WireConnection;2362;1652;2329;0
WireConnection;2362;624;2032;0
WireConnection;2362;720;2069;0
WireConnection;2362;722;2070;0
WireConnection;2354;0;2359;0
WireConnection;2354;4;2359;0
WireConnection;2354;5;2359;0
WireConnection;2354;2;2362;338
ASEEND*/
//CHKSM=AB5DC4C1AAE5DDE2196EF887E219B0AE5704BD4A