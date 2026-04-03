// Made with Amplify Shader Editor v1.9.9.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Helpers/Custom Texture Packing"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _Cutoff("Alpha Cutoff", Range(0, 1)) = 0.5
		[HideInInspector] _IsVersion( "_IsVersion", Float ) = 2150
		[HideInInspector] _IsTVEShader( "_IsTVEShader", Float ) = 1
		[HideInInspector] _IsShaderType( "_IsShaderType", Float ) = 0
		[HideInInspector] _IsObjectType( "_IsObjectType", Float ) = 0
		[HideInInspector] _IsLightingType( "_IsLightingType", Float ) = 0
		[HideInInspector] _IsCustomShader( "_IsCustomShader", Float ) = 0
		[HideInInspector] _IsConverted( "_IsConverted", Float ) = 0
		[HideInInspector] _IsCollected( "_IsCollected", Float ) = 0
		[HideInInspector] _IsIdentifier( "_IsIdentifier", Float ) = 0
		[HideInInspector] _IsShared( "_IsShared", Float ) = 0
		[HideInInspector] _UseExternalSettings( "_UseExternalSettings", Float ) = 1
		[StyledCategory(Render Settings, true, Use the Faces option to control if the faces should be rendered as double sided.NEWNEWUse the Motion option to control if the shader writes Motion Vectors OPAwhen availableCPA.NEWNEWUse the GBuffer to option to control if the shader writes to GBuffer__ even if the shader is rendered in Forward path OPAwhen availableCPA.NEWNEWUse the Render Normals option to Flip or Mirror the normal map on the mesh backface. When the mesh normals are flattened__ use the Same option so the normals are the same on both sides.NEWNEWUse the Filtering options to control the texture filtering. The Default option keeps the Albedo filtering at higher quality__ and the Normal and Shader filtering at lower quality for better performance.NEWNEWUse the Render Clipping to enable alpha testing__ also know as alpha cutout., 0, 10)] _RenderCategory( "[ Render Category ]", Float ) = 1
		[Enum(Off,0,On,1)] _RenderZWrite( "Render ZWrite", Float ) = 1
		[Enum(Both,0,Back,1,Front,2)] _RenderCull( "Render Faces", Float ) = 2
		[HideInInspector] _RenderQueue( "Render Queue", Float ) = 0
		[HideInInspector] _RenderPriority( "Render Priority", Float ) = 0
		[HideInInspector] _RenderBakeGI( "Render BakeGI", Float ) = 0
		[Enum(Auto,0,Off,1,On,2)] _RenderMotion( "Render Motion", Float ) = 0
		[Enum(Auto,0,Off,1,On,2)] _RenderMotionXR( "Render Motion XR", Float ) = 0
		[Enum(Off,0,On,1)] _RenderGBuffer( "Render GBuffer", Float ) = 0
		[Enum(Flip,0,Mirror,1,Same,2)] _RenderNormal( "Render Normals", Float ) = 0
		[Enum(Off,0,On,1)] _RenderShadow( "Render Shadows", Float ) = 1
		[Enum(Off,0,On,1)] _RenderSpecular( "Render Specular", Float ) = 1
		[Enum(Default,0,Point ,1,Low,2,Medium,3,High,4)] _RenderFilter( "Render Filtering", Float ) = 0
		[Enum(Off,0,On,1)] _RenderClip( "Render Clipping", Float ) = 0
		[HideInInspector] _render_normal( "_render_normal", Vector ) = ( 1, 1, 1, 0 )
		[StyledSpace(10)] _RenderEnd( "[ Render End ]", Float ) = 1
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _ObjectPhaseMode( "Object Phase Mask", Float ) = 0
		[StyledCategory(Main Settings, true, 0, 10)] _MainCategory( "[Main Category ]", Float ) = 1
		[StyledMessage(Info, Use the Multi Mask as leaves mask for Dual Colors__ Global Effects and as Subsurface Mask. The mask is stored in the Shader texture blue channel and it can be in subsurface format or thickness format by inverting the Multi Mask remap slider. , 0, 0)] _MainMultiMaskInfo( "# MainMultiMaskInfo", Float ) = 0
		[StyledMessage(Info, The Smoothness mask is stored in the Shader texture alpha channel and it can be in smoothness format or roughness format by inverting the Smoothness remap slider. , 0, 10)] _MainSmoothnessInfo( "# MainSmoothnessInfo", Float ) = 0
		[StyledTextureSingleLine(Albedo RGB Alpha A)] _MainAlbedoTex( "Main Albedo", 2D ) = "white" {}
		[StyledTextureSingleLine(NormalXY AG)] _MainNormalTex( "Main Normal", 2D ) = "bump" {}
		[StyledTextureSingleLine(Metallic R Occlusion G BaseMask and MultiMask B Smoothness A)] _MainShaderTex( "Main Shader", 2D ) = "white" {}
		[Enum(Main UV,0,Extra UV,1,Planar,2,Triplanar,3,Stochastic,4,Stochastic Triplanar,5)][Space(10)] _MainSampleMode( "Main Sampling", Float ) = 0
		[Enum(Tilling And Offset,0,Scale And Offset,1)] _MainCoordMode( "Main UV Mode", Float ) = 0
		[StyledVector(9)] _MainCoordValue( "Main UV Value", Vector ) = ( 1, 1, 0, 0 )
		[HideInInspector] _main_coord_value( "_main_coord_value", Vector ) = ( 1, 1, 0, 0 )
		[Enum(Constant,0,Dual Colors,1)] _MainColorMode( "Main Color", Float ) = 0
		[HDR] _MainColor( "Main Color", Color ) = ( 1, 1, 1, 1 )
		[HDR] _MainColorTwo( "Main ColorB", Color ) = ( 1, 1, 1, 1 )
		_MainAlbedoValue( "Main Albedo", Range( 0, 1 ) ) = 1
		_MainNormalValue( "Main Normal", Range( -8, 8 ) ) = 1
		[Space(10)][StyledTextureSingleLine] _MainAlphaTex( "Main Alpha", 2D ) = "white" {}
		[Space(10)] _MainAlphaClipValue( "Main Alpha", Range( 0, 1 ) ) = 0.5
		[Enum(Default Albedo Texture A,0,Custom Texture,1)] _MainAlphaSourceMode( "Main Alpha Source", Float ) = 0
		[StyledEnum(NULL, Custom_Texture_R 0 Custom_Texture_G 1 Custom_Texture_B 2 Custom_Texture_A 3 Custom_Texture_R_Inverted 4 Custom_Texture_G_Inverted 5 Custom_Texture_B_Inverted 6 Custom_Texture_A_Inverted 7, 0, 0)] _MainAlphaChannelMode( "Main Alpha Channel", Float ) = 0
		[Space(10)][StyledTextureSingleLine] _MainMetallicTex( "Main Metallic", 2D ) = "white" {}
		[Space(10)] _MainMetallicValue( "Main Metallic", Range( 0, 1 ) ) = 0
		[Enum(Default Shader Texture R,0,Custom Texture,1)] _MainMetallicSourceMode( "Main Metallic Source", Float ) = 0
		[StyledEnum(NULL, Custom_Texture_R 0 Custom_Texture_G 1 Custom_Texture_B 2 Custom_Texture_A 3 Custom_Texture_R_Inverted 4 Custom_Texture_G_Inverted 5 Custom_Texture_B_Inverted 6 Custom_Texture_A_Inverted 7, 0, 0)] _MainMetallicChannelMode( "Main Metallic Channel", Float ) = 0
		[Space(10)][StyledTextureSingleLine] _MainOcclusionTex( "Main Occlusion", 2D ) = "white" {}
		[Space(10)] _MainOcclusionValue( "Main Occlusion", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _MainOcclusionRemap( "Main Occlusion", Vector ) = ( 0, 1, 0, 0 )
		[Enum(Default Shader Texture G,0,Custom Texture,1)] _MainOcclusionSourceMode( "Main Occlusion Source", Float ) = 0
		[StyledEnum(NULL, Custom_Texture_R 0 Custom_Texture_G 1 Custom_Texture_B 2 Custom_Texture_A 3 Custom_Texture_R_Inverted 4 Custom_Texture_G_Inverted 5 Custom_Texture_B_Inverted 6 Custom_Texture_A_Inverted 7, 0, 0)] _MainOcclusionChannelMode( "Main Occlusion Channel", Float ) = 0
		[Space(10)][StyledTextureSingleLine] _MainMultiTex( "Main Multi Mask", 2D ) = "white" {}
		[Space(10)] _MainMultiVlaue( "Main Multi Mask", Range( 0, 1 ) ) = 1
		[StyledRemapSlider] _MainMultiRemap( "Main Multi Mask", Vector ) = ( 0, 1, 0, 0 )
		[Enum(Default Shader Texture B,0,Custom Texture,1)] _MainMultiSourceMode( "Main Multi Mask Source", Float ) = 0
		[StyledEnum(NULL, Custom_Texture_R 0 Custom_Texture_G 1 Custom_Texture_B 2 Custom_Texture_A 3 Custom_Texture_R_Inverted 4 Custom_Texture_G_Inverted 5 Custom_Texture_B_Inverted 6 Custom_Texture_A_Inverted 7, 0, 0)] _MainMultiChannelMode( "Main Multi Mask Channel", Float ) = 0
		[Space(10)][StyledTextureSingleLine] _MainSmoothnessTex( "Main Smoothness", 2D ) = "white" {}
		[Space(10)] _MainSmoothnessValue( "Main Smoothness", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _MainSmoothnessRemap( "Main Smoothness", Vector ) = ( 0, 1, 0, 0 )
		[Enum(Default Shader Texture A,0,Custom Texture,1)] _MainSmoothnessSourceMode( "Main Smoothness Source", Float ) = 0
		[StyledEnum(NULL, Custom_Texture_R 0 Custom_Texture_G 1 Custom_Texture_B 2 Custom_Texture_A 3 Custom_Texture_R_Inverted 4 Custom_Texture_G_Inverted 5 Custom_Texture_B_Inverted 6 Custom_Texture_A_Inverted 7, 0, 0)] _MainSmoothnessChannelMode( "Main Smoothness Channel", Float ) = 0
		[StyledSpace(10)] _MainEnd( "[Main End ]", Float ) = 1
		[HideInInspector] _MainSmoothnessTexGammaMode( "_MainSmoothnessTexGammaMode", Float ) = 0
		[HideInInspector] _MainAlphaTexIsGamma( "_MainAlphaTexGammaMode", Float ) = 0
		[HideInInspector] _render_cull( "_render_cull", Float ) = 0
		[HideInInspector] _render_src( "_render_src", Float ) = 5
		[HideInInspector] _render_dst( "_render_dst", Float ) = 10
		[HideInInspector] _render_zw( "_render_zw", Float ) = 1
		[HideInInspector] _render_coverage( "_render_coverage", Float ) = 0
		[HideInInspector] _IsGeneralShader( "_IsGeneralShader", Float ) = 1
		[HideInInspector] _IsStandardShader( "_IsStandardShader", Float ) = 1


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

		[HideInInspector][ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[HideInInspector][ToggleOff] _EnvironmentReflections("Environment Reflections", Float) = 1.0
		[HideInInspector][ToggleOff] _ReceiveShadows("Receive Shadows", Float) = 1.0

		[HideInInspector] _QueueOffset("_QueueOffset", Float) = 0
        [HideInInspector] _QueueControl("_QueueControl", Float) = -1

        [HideInInspector][NoScaleOffset] unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}

		[HideInInspector][ToggleUI] _AddPrecomputedVelocity("Add Precomputed Velocity", Float) = 1

		[HideInInspector] _XRMotionVectorsPass("_XRMotionVectorsPass", Float) = 1
	}

	SubShader
	{
		LOD 0

		

		

		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" "UniversalMaterialType"="Lit" "AlwaysRenderMotionVectors"="false" }

		Cull [_render_cull]
		ZWrite [_render_zw]
		ZTest LEqual
		Offset 0 , 0
		AlphaToMask Off

		

		HLSLINCLUDE
		#pragma target 4.5
		#pragma prefer_hlslcc gles
		// ensure rendering platforms toggle list is visible

		#if ( SHADER_TARGET > 35 ) && defined( SHADER_API_GLES3 )
			#error For WebGL2/GLES3, please set your shader target to 3.5 via SubShader options. URP shaders in ASE use target 4.5 by default.
		#endif

		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Filtering.hlsl"

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
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
		#endif //ASE_TESS_FUNCS
		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }

			Blend One Zero, One Zero
			ZWrite [_render_zw]
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			

			HLSLPROGRAM

			#define ASE_GEOMETRY
			#define ASE_OPAQUE_KEEP_ALPHA
			#define _NORMAL_DROPOFF_TS 1
			#pragma shader_feature_local _RECEIVE_SHADOWS_OFF
			#pragma shader_feature_local_fragment _SPECULARHIGHLIGHTS_OFF
			#pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#define _NORMALMAP 1
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION 170300
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile _ EVALUATE_SH_MIXED EVALUATE_SH_VERTEX
			#pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_ATLAS
			#pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
			#pragma multi_compile_fragment _ _SCREEN_SPACE_IRRADIANCE
			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile _ _LIGHT_LAYERS
			#pragma multi_compile_fragment _ _LIGHT_COOKIES
			#pragma multi_compile _ _CLUSTER_LIGHT_LOOP

			#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile_fragment _ LIGHTMAP_BICUBIC_SAMPLING
			#pragma multi_compile_fragment _ REFLECTION_PROBE_ROTATION
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON
			#pragma multi_compile _ USE_LEGACY_LIGHTMAPS

			#pragma vertex vert
			#pragma fragment frag

			#if defined( _SPECULAR_SETUP ) && defined( ASE_LIGHTING_SIMPLE )
				#if defined( _SPECULARHIGHLIGHTS_OFF )
					#undef _SPECULAR_COLOR
				#else
					#define _SPECULAR_COLOR
				#endif
			#endif

			#define SHADERPASS SHADERPASS_FORWARD

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Fog.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ProbeVolumeVariants.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#if defined( UNITY_INSTANCING_ENABLED ) && defined( ASE_INSTANCED_TERRAIN ) && ( defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL) || defined(_INSTANCEDTERRAINNORMALS_PIXEL) )
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
			#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
			#pragma shader_feature_local_fragment TVE_CLIPPING
			#if defined (TVE_CLIPPING) //Render Clip
				#define TVE_ALPHA_CLIP //Render Clip
			#endif //Render Clip
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END
			  
			struct TVEVisualData
			{  
				half Dummy;  
				half3 Albedo;
				half3 AlbedoBase;
				half2 NormalTS;
				half3 NormalWS; 
				half4 Shader;
				half4 Feature;
				half4 Season;
				float4 Emissive;
				half AlphaClip;
				half AlphaFade;
				half MultiMask;
				half Grayscale;
				half Luminosity;
				float3 Translucency;
				half Transmission;
				half Thickness;
				float Diffusion;
				float Depth;
			};  
			    
			struct TVEModelData
			{    
				half Dummy;    
				float3 PositionOS;
				float3 PositionWS;
				float3 PositionWO;
				float3 PositionRawOS;
				float3 PivotOS;
				float3 PivotWS;
				float3 PivotWO;
				half3 NormalOS;
				half3 NormalWS;
				half3 NormalRawOS;
				half4 TangentOS;
				half3 TangentWS;
				half3 BitangentWS;
				half3 TriplanarWeights;
				half3 ViewDirWS;
				float4 CoordsData;
				half4 VertexData;
				half4 MasksData;   
				half4 PhaseData;
				half4 TransformData;
				half4 RotationData;
				float4 InterpolatorA;
			};    
			      
			struct TVEGlobalData
			{      
				half Dummy;      
				half4 CoatParams;
				half4 CoatTexture;
				half4 PaintParams;
				half4 PaintTexture;
				half4 AtmoParams;
				half4 AtmoTexture;
				half4 GlowParams;
				half4 GlowTexture;
				float4 FormParams;
				float4 FormTexture;
				half4 FlowParams;
				half4 FlowTexture;
			};      
			        
			struct TVEMasksData
			{        
				half4 MaskA;
				half4 MaskB;
				half4 MaskC;
				half4 MaskD;
				half4 MaskE;
				half4 MaskF;
				half4 MaskG;
				half4 MaskH;
				half4 MaskI;
				half4 MaskJ;
				half4 MaskK;
				half4 MaskL;
				half4 MaskM;
				half4 MaskN;
			};        
			#define TVE_GEOMETRY_SHADER


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				#if defined(LIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES1)
					float4 texcoord1 : TEXCOORD1;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES2)
					float4 texcoord2 : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				half3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2; // holds terrainUV ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
				float4 lightmapUVOrVertexSH : TEXCOORD3;
				#if defined(ASE_FOG) || defined(_ADDITIONAL_LIGHTS_VERTEX)
					half4 fogFactorAndVertexLight : TEXCOORD4;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
					float2 dynamicLightmapUV : TEXCOORD5;
				#endif
				#if defined(USE_APV_PROBE_OCCLUSION)
					float4 probeOcclusion : TEXCOORD6;
				#endif
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			half4 _MainOcclusionRemap;
			half4 _MainColor;
			half4 _MainColorTwo;
			half4 _MainMultiRemap;
			half4 _main_coord_value;
			half4 _MainSmoothnessRemap;
			half4 _MainCoordValue;
			half3 _render_normal;
			half _MainMultiVlaue;
			half _MainMultiSourceMode;
			half _MainMultiChannelMode;
			half _MainSmoothnessSourceMode;
			half _MainColorMode;
			float _MainSmoothnessTexGammaMode;
			half _MainSmoothnessChannelMode;
			half _MainOcclusionValue;
			half _MainSmoothnessValue;
			half _render_src;
			half _MainNormalValue;
			float _MainAlphaTexIsGamma;
			half _RenderMotion;
			half _RenderGBuffer;
			half _RenderMotionXR;
			half _RenderShadow;
			half _RenderClip;
			half _RenderFilter;
			half _MainAlphaChannelMode;
			half _RenderNormal;
			half _RenderPriority;
			half _RenderQueue;
			half _RenderZWrite;
			half _RenderCull;
			half _MainAlphaClipValue;
			half _MainAlphaSourceMode;
			half _RenderBakeGI;
			half _MainOcclusionSourceMode;
			half _MainMetallicSourceMode;
			half _MainMetallicValue;
			half _render_cull;
			half _render_dst;
			half _render_zw;
			half _render_coverage;
			half _IsGeneralShader;
			half _RenderEnd;
			half _IsVersion;
			half _IsTVEShader;
			half _IsLightingType;
			half _IsCustomShader;
			half _IsCollected;
			half _IsConverted;
			half _IsIdentifier;
			half _MainOcclusionChannelMode;
			half _IsShared;
			half _IsShaderType;
			half _IsObjectType;
			half _RenderCategory;
			half _IsStandardShader;
			half _MainCategory;
			half _MainEnd;
			half _MainSampleMode;
			half _MainCoordMode;
			half _MainMultiMaskInfo;
			half _MainSmoothnessInfo;
			half _ObjectPhaseMode;
			half _MainAlbedoValue;
			half _MainMetallicChannelMode;
			half _UseExternalSettings;
			half _RenderSpecular;
			float _AlphaClip;
			float _Cutoff;
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
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_Linear_Repeat_Aniso8);
			SAMPLER(sampler_Point_Repeat);
			SAMPLER(sampler_Linear_Repeat);
			float3 TVE_WorldOrigin;
			TEXTURE2D(_MainShaderTex);
			TEXTURE2D(_MainMetallicTex);
			TEXTURE2D(_MainOcclusionTex);
			TEXTURE2D(_MainSmoothnessTex);
			TEXTURE2D(_MainMultiTex);
			TEXTURE2D(_MainNormalTex);
			TEXTURE2D(_MainAlphaTex);
			half _DisableSRPBatcher;


			half3 ComputeTriplanarWeights( half3 NormalWS )
			{
				half3 powNormal = abs( NormalWS );
				half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
				tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
				return tempWeights;
			}
			
			float SwitchChannel4( half Option, half4 Channel )
			{
				switch (Option) {
					default:
				                case 0:
						return Channel.x;
					case 1:
						return Channel.y;
					case 2:
						return Channel.z;
					case 3:
						return Channel.w;
				}
			}
			
			void BuildModelFragData( out TVEModelData Data, half In_Dummy, float3 In_PositionWS, float3 In_PositionWO, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalWS, half3 In_TangentWS, half3 In_BitangentWS, half3 In_TriplanarWeights, half3 In_ViewDirWS, half4 In_CoordsData, half4 In_VertexData, half4 In_PhaseData )
			{
				Data = (TVEModelData)0;
				Data.Dummy = In_Dummy;
				Data.PositionWS = In_PositionWS;
				Data.PositionWO = In_PositionWO;
				Data.PivotWS = In_PivotWS;
				Data.PivotWO = In_PivotWO;
				Data.NormalWS = In_NormalWS;
				Data.TangentWS = In_TangentWS;
				Data.BitangentWS = In_BitangentWS;
				Data.TriplanarWeights = In_TriplanarWeights;
				Data.ViewDirWS = In_ViewDirWS;
				Data.CoordsData = In_CoordsData;
				Data.VertexData = In_VertexData;
				Data.PhaseData = In_PhaseData;
				return;
			}
			
			void BreakModelFragData( inout TVEModelData Data, out half Out_Dummy, out float3 Out_PositionWS, out float3 Out_PositionWO, out float3 Out_PivotWS, out float3 Out_PivotWO, out half3 Out_NormalWS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_TriplanarWeights, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_PhaseData )
			{
				Out_Dummy = Data.Dummy;
				Out_PositionWS = Data.PositionWS;
				Out_PositionWO = Data.PositionWO;
				Out_PivotWS = Data.PivotWS;
				Out_PivotWO = Data.PivotWO;
				Out_NormalWS = Data.NormalWS;
				Out_TangentWS = Data.TangentWS;
				Out_BitangentWS = Data.BitangentWS;
				Out_TriplanarWeights = Data.TriplanarWeights;
				Out_ViewDirWS = Data.ViewDirWS;
				Out_CoordsData = Data.CoordsData;
				Out_VertexData = Data.VertexData;
				Out_PhaseData = Data.PhaseData;
				return;
			}
			
			void ComputeMeshCoords( float4 Coords, float4 MeshCoords, out float2 UV0, out float2 UV3 )
			{
				UV0 = MeshCoords.xy * Coords.xy - Coords.zw; 
				UV3 = MeshCoords.zw * Coords.xy - Coords.zw; 
				return;
			}
			
			void ComputeWorldCoords( float4 Coords, float3 PositionWS, out float2 ZY, out float2 XZ, out float2 XY )
			{
				ZY = PositionWS.zy * Coords.xy - Coords.zw; 
				XZ = PositionWS.xz * Coords.xx - Coords.zz;
				XY = PositionWS.xy * Coords.xy - Coords.zw;
				return;
			}
			
			float2 ComputeStochasticHash22( float2 p )
			{
				float3 p3 = frac(float3(p.xyx) * float3(.1031, .1030, .0973));
				p3 += dot(p3, p3.yzx+33.33);
				return frac((p3.xx+p3.yz)*p3.zy);
			}
			
			void ComputeStochasticCoords( inout float2 UV, out float2 UV1, out float2 UV2, out float2 UV3, out float3 Weights )
			{
				half2 vertex1, vertex2, vertex3;
				// Scaling of the input
				half2 uv = UV * 3.464; // 2 * sqrt (3)
				// Skew input space into simplex triangle grid
				const float2x2 gridToSkewedGrid = float2x2( 1.0, 0.0, -0.57735027, 1.15470054 );
				half2 skewedCoord = mul( gridToSkewedGrid, uv );
				// Compute local triangle vertex IDs and local barycentric coordinates
				int2 baseId = int2( floor( skewedCoord ) );
				half3 temp = half3( frac( skewedCoord ), 0 );
				temp.z = 1.0 - temp.x - temp.y;
				if ( temp.z > 0.0 )
				{
					Weights.x = temp.z;
					Weights.y = temp.y;
					Weights.z = temp.x;
					vertex1 = baseId;
					vertex2 = baseId + int2( 0, 1 );
					vertex3 = baseId + int2( 1, 0 );
				}
				else
				{
					Weights.x = -temp.z;
					Weights.y = 1.0 - temp.y;
					Weights.z = 1.0 - temp.x;
					vertex1 = baseId + int2( 1, 1 );
					vertex2 = baseId + int2( 1, 0 );
					vertex3 = baseId + int2( 0, 1 );
				}
				UV1 = UV + ComputeStochasticHash22(vertex1);
				UV2 = UV + ComputeStochasticHash22(vertex2);
				UV3 = UV + ComputeStochasticHash22(vertex3);
				return;
			}
			
			void BuildTextureData( out TVEMasksData Data, float4 In_MaskA, float4 In_MaskB, float4 In_MaskC, float4 In_MaskD, float4 In_MaskE, float4 In_MaskF, float4 In_MaskG, half4 In_MaskH, half4 In_MaskI, half4 In_MaskJ, half4 In_MaskK, half4 In_MaskL, half4 In_MaskM, half4 In_MaskN )
			{
				Data.MaskA = In_MaskA;
				Data.MaskB = In_MaskB;
				Data.MaskC = In_MaskC;
				Data.MaskD = In_MaskD;
				Data.MaskE = In_MaskE;
				Data.MaskF = In_MaskF;
				Data.MaskG = In_MaskG;
				Data.MaskH = In_MaskH;
				Data.MaskI = In_MaskI;
				Data.MaskJ = In_MaskJ;
				Data.MaskK = In_MaskK;
				Data.MaskL = In_MaskL;
				Data.MaskM = In_MaskM;
				Data.MaskN = In_MaskN;
				return;
			}
			
			void BreakTextureData( TVEMasksData Data, out float4 Out_MaskA, out float4 Out_MaskB, out float4 Out_MaskC, out float4 Out_MaskD, out float4 Out_MaskE, out float4 Out_MaskF, out half4 Out_MaskG, out half4 Out_MaskH, out half4 Out_MaskI, out half4 Out_MaskJ, out half4 Out_MaskK, out half4 Out_MaskL, out half4 Out_MaskM, out half4 Out_MaskN )
			{
				Out_MaskA = Data.MaskA;
				Out_MaskB = Data.MaskB;
				Out_MaskC = Data.MaskC;
				Out_MaskD = Data.MaskD;
				Out_MaskE = Data.MaskE;
				Out_MaskF = Data.MaskF;
				Out_MaskG = Data.MaskG;
				Out_MaskH = Data.MaskH;
				Out_MaskI = Data.MaskI;
				Out_MaskJ = Data.MaskJ;
				Out_MaskK = Data.MaskK;
				Out_MaskL = Data.MaskL;
				Out_MaskM = Data.MaskM;
				Out_MaskN = Data.MaskN;
				return;
			}
			
			half4 SampleCoord( TEXTURE2D(Texture), SamplerState Sampler, half2 UV, half Bias, out half2 Normal )
			{
				half4 tex = SAMPLE_TEXTURE2D_BIAS( Texture, Sampler, UV, Bias);
				Normal = tex.wy * 2.0 - 1.0;
				return tex;
			}
			
			half4 SamplePlanar2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, half Bias, half3 NormalWS, out half3 Normal )
			{
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SamplePlanar3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 XZ, float2 XY, half Bias, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				half4 tex_X = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, ZY, Bias);
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half4 tex_Z = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XY, Bias);
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal =  normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			half4 SampleStochastic2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, half Bias, half3 Weights_2, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SampleStochastic3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 ZY_1, float2 ZY_2, float2 ZY_3, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, float2 XY, float2 XY_1, float2 XY_2, float2 XY_3, half Bias, half3 Weights_1, half3 Weights_2, half3 Weights_3, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_X = ddx(ZY) * Bias;
				float2 ddy_X= ddy(ZY) * Bias;
				half4 tex1_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_1, ddx_X, ddy_X);
				half4 tex2_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_2, ddx_X, ddy_X);
				half4 tex3_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_3, ddx_X, ddy_X);
				half4 tex_X = tex1_X * Weights_1.x + tex2_X * Weights_1.y + tex3_X * Weights_1.z;
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				float2 ddx_Z = ddx(XY) * Bias;
				float2 ddy_Z= ddy(XY) * Bias;
				half4 tex1_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_1, ddx_Z, ddy_Z);
				half4 tex2_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_2, ddx_Z, ddy_Z);
				half4 tex3_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_3, ddx_Z, ddy_Z);
				half4 tex_Z = tex1_Z * Weights_3.x + tex2_Z * Weights_3.y + tex3_Z * Weights_3.z;
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal = normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			float SwitchChannel8( half Option, half4 ChannelA, half4 ChannelB )
			{
				switch (Option) {
					default:
				                case 0:
						return ChannelA.x;
					case 1:
						return ChannelA.y;
					case 2:
						return ChannelA.z;
					case 3:
						return ChannelA.w;
				                case 4:
						return ChannelB.x;
					case 5:
						return ChannelB.y;
					case 6:
						return ChannelB.z;
					case 7:
						return ChannelB.w;
				}
			}
			
			half3 LinearToGammaFloatFast( half3 linRGB )
			{
				return max(1.055h * pow(abs(linRGB), 0.416666667h) - 0.055h, 0.h);
			}
			
			void BuildVisualData( inout TVEVisualData Data, float In_Dummy, half3 In_Albedo, half3 In_AlbedoBase, half2 In_NormalTS, half3 In_NormalWS, half4 In_Shader, half4 In_Feature, half4 In_Season, half4 In_Emissive, half In_Grayscale, half In_Luminosity, half In_MultiMask, half In_AlphaClip, half In_AlphaFade, half3 In_Translucency, half In_Transmission, half In_Thickness, float In_Diffusion, float In_Depth )
			{
				//Data = (TVEVisualData)0;
				Data.Dummy = In_Dummy;
				Data.Albedo = In_Albedo;
				Data.AlbedoBase = In_AlbedoBase;
				Data.NormalTS = In_NormalTS;
				Data.NormalWS = In_NormalWS;
				Data.Shader = In_Shader;
				Data.Feature = In_Feature;
				Data.Season= In_Season;
				Data.Emissive= In_Emissive;
				Data.MultiMask = In_MultiMask;
				Data.Grayscale = In_Grayscale;
				Data.Luminosity = In_Luminosity;
				Data.AlphaClip = In_AlphaClip;
				Data.AlphaFade = In_AlphaFade;
				Data.Translucency = In_Translucency;
				Data.Transmission = In_Transmission;
				Data.Thickness = In_Thickness;
				Data.Diffusion = In_Diffusion;
				Data.Depth = In_Depth;
				return;
			}
			
			void BreakVisualData( inout TVEVisualData Data, out half Out_Dummy, out half3 Out_Albedo, out half3 Out_AlbedoBase, out half2 Out_NormalTS, out half3 Out_NormalWS, out half4 Out_Shader, out half4 Out_Feature, out half4 Out_Season, out half4 Out_Emissive, out half Out_MultiMask, out half Out_Grayscale, out half Out_Luminosity, out half Out_AlphaClip, out half Out_AlphaFade, out half3 Out_Translucency, out half Out_Transmission, out half Out_Thickness, out half Out_Diffusion, out float Out_Depth )
			{
				Out_Dummy = Data.Dummy;
				Out_Albedo = Data.Albedo;
				Out_AlbedoBase = Data.AlbedoBase;
				Out_NormalTS = Data.NormalTS;
				Out_NormalWS = Data.NormalWS;
				Out_Shader = Data.Shader;
				Out_Feature = Data.Feature;
				Out_Season = Data.Season;
				Out_Emissive= Data.Emissive;
				Out_MultiMask = Data.MultiMask;
				Out_Grayscale = Data.Grayscale;
				Out_Luminosity= Data.Luminosity;
				Out_AlphaClip = Data.AlphaClip;
				Out_AlphaFade = Data.AlphaFade;
				Out_Translucency = Data.Translucency;
				Out_Transmission = Data.Transmission;
				Out_Thickness = Data.Thickness;
				Out_Diffusion = Data.Diffusion;
				Out_Depth= Data.Depth;
				return;
			}
			

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float3 ase_positionWS = TransformObjectToWorld( ( input.positionOS ).xyz );
				float3 temp_output_104_7_g205214 = ase_positionWS;
				float3 vertexToFrag73_g205214 = temp_output_104_7_g205214;
				output.ase_texcoord7.xyz = vertexToFrag73_g205214;
				float4x4 break19_g205217 = GetObjectToWorldMatrix();
				float3 appendResult20_g205217 = (float3(break19_g205217[ 0 ][ 3 ] , break19_g205217[ 1 ][ 3 ] , break19_g205217[ 2 ][ 3 ]));
				float3 temp_output_340_7_g205214 = appendResult20_g205217;
				float4x4 break19_g205219 = GetObjectToWorldMatrix();
				float3 appendResult20_g205219 = (float3(break19_g205219[ 0 ][ 3 ] , break19_g205219[ 1 ][ 3 ] , break19_g205219[ 2 ][ 3 ]));
				float3 _Vector0 = float3(0,0,0);
				float3 appendResult60_g205215 = (float3(input.ase_texcoord3.x , input.ase_texcoord3.z , input.ase_texcoord3.y));
				float3 PositionOS131_g205214 = input.positionOS.xyz;
				float3 break233_g205214 = PositionOS131_g205214;
				float3 appendResult234_g205214 = (float3(break233_g205214.x , 0.0 , break233_g205214.z));
				float3 break413_g205214 = PositionOS131_g205214;
				float3 appendResult414_g205214 = (float3(break413_g205214.x , break413_g205214.y , 0.0));
				#ifdef TVE_COORD_ZUP
				float3 staticSwitch65_g205221 = appendResult414_g205214;
				#else
				float3 staticSwitch65_g205221 = appendResult234_g205214;
				#endif
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch229_g205214 = _Vector0;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch229_g205214 = appendResult60_g205215;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch229_g205214 = staticSwitch65_g205221;
				#else
				float3 staticSwitch229_g205214 = _Vector0;
				#endif
				float3 PivotOS149_g205214 = staticSwitch229_g205214;
				float3 temp_output_122_0_g205219 = PivotOS149_g205214;
				float3 PivotsOnlyWS105_g205219 = mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g205219 , 0.0 ) ).xyz;
				float3 temp_output_341_7_g205214 = ( appendResult20_g205219 + PivotsOnlyWS105_g205219 );
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#else
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#endif
				float3 vertexToFrag76_g205214 = staticSwitch236_g205214;
				output.ase_texcoord8.xyz = vertexToFrag76_g205214;
				
				output.ase_texcoord9.xy = input.texcoord.xy;
				output.ase_texcoord9.zw = input.texcoord2.xy;
				output.ase_color = input.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord7.w = 0;
				output.ase_texcoord8.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif
				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );
				VertexNormalInputs normalInput = GetVertexNormalInputs( input.normalOS, input.tangentOS );

				OUTPUT_LIGHTMAP_UV(input.texcoord1, unity_LightmapST, output.lightmapUVOrVertexSH.xy);
				#if defined(DYNAMICLIGHTMAP_ON)
					output.dynamicLightmapUV.xy = input.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif
				OUTPUT_SH4(vertexInput.positionWS, normalInput.normalWS.xyz, GetWorldSpaceNormalizeViewDir(vertexInput.positionWS), output.lightmapUVOrVertexSH.xyz, output.probeOcclusion);

				#if defined(ASE_FOG) || defined(_ADDITIONAL_LIGHTS_VERTEX)
					output.fogFactorAndVertexLight = 0;
					#if defined(ASE_FOG) && !defined(_FOG_FRAGMENT)
						output.fogFactorAndVertexLight.x = ComputeFogFactor(vertexInput.positionCS.z);
					#endif
					#ifdef _ADDITIONAL_LIGHTS_VERTEX
						half3 vertexLight = VertexLighting( vertexInput.positionWS, normalInput.normalWS );
						output.fogFactorAndVertexLight.yzw = vertexLight;
					#endif
				#endif

				output.positionCS = vertexInput.positionCS;
				output.positionWS = vertexInput.positionWS;
				output.normalWS = normalInput.normalWS;
				output.tangentWS = float4( normalInput.tangentWS, ( input.tangentOS.w > 0.0 ? 1.0 : -1.0 ) * GetOddNegativeScale() );

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					output.tangentWS.zw = input.texcoord.xy;
					output.tangentWS.xy = input.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				#if defined(LIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES1)
					float4 texcoord1 : TEXCOORD1;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES2)
					float4 texcoord2 : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				output.texcoord = input.texcoord;
				#if defined(LIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES1)
					output.texcoord1 = input.texcoord1;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES2)
					output.texcoord2 = input.texcoord2;
				#endif
				output.texcoord = input.texcoord;
				output.ase_texcoord3 = input.ase_texcoord3;
				output.ase_color = input.ase_color;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
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
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				output.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				#if defined(LIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES1)
					output.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES2)
					output.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				#endif
				output.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				output.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag ( PackedVaryings input
						#if defined( ASE_DEPTH_WRITE_ON )
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						#ifdef _WRITE_RENDERING_LAYERS
						, out uint outRenderingLayers : SV_Target1
						#endif
						, uint ase_vface : SV_IsFrontFace ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);

				#if defined( _SURFACE_TYPE_TRANSPARENT )
					const bool isTransparent = true;
				#else
					const bool isTransparent = false;
				#endif

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					float4 shadowCoord = TransformWorldToShadowCoord( input.positionWS );
				#else
					float4 shadowCoord = float4(0, 0, 0, 0);
				#endif

				// @diogo: mikktspace compliant
				float renormFactor = 1.0 / max( FLT_MIN, length( input.normalWS ) );

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( PositionWS );
				float3 ViewDirWS = GetWorldSpaceNormalizeViewDir( PositionWS );
				float4 ShadowCoord = shadowCoord;
				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos );
				float3 TangentWS = input.tangentWS.xyz * renormFactor;
				float3 BitangentWS = cross( input.normalWS, input.tangentWS.xyz ) * input.tangentWS.w * renormFactor;
				float3 NormalWS = input.normalWS * renormFactor;

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					float2 sampleCoords = (input.tangentWS.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					NormalWS = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					TangentWS = -cross(GetObjectToWorldMatrix()._13_23_33, NormalWS);
					BitangentWS = cross(NormalWS, -TangentWS);
				#endif

				float localBreakVisualData4_g251314 = ( 0.0 );
				float localBuildVisualData3_g207088 = ( 0.0 );
				TVEVisualData Data3_g207088 =(TVEVisualData)0;
				half4 Dummy130_g207086 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) + _MainMultiMaskInfo + _MainSmoothnessInfo );
				float temp_output_14_0_g207088 = Dummy130_g207086.x;
				float In_Dummy3_g207088 = temp_output_14_0_g207088;
				TEXTURE2D(Texture276_g207093) = _MainAlbedoTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g207096 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g207093 = staticSwitch36_g207096;
				float localBreakTextureData456_g207093 = ( 0.0 );
				float localBuildTextureData431_g251292 = ( 0.0 );
				TVEMasksData Data431_g251292 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g251292 = ( 0.0 );
				half4 Local_Coords180_g207086 = _main_coord_value;
				float4 Coords444_g251292 = Local_Coords180_g207086;
				TVEModelData Data16_g205222 =(TVEModelData)(TVEModelData)0;
				float In_Dummy16_g205222 = 0.0;
				float3 vertexToFrag73_g205214 = input.ase_texcoord7.xyz;
				float3 PositionWS122_g205214 = vertexToFrag73_g205214;
				float3 In_PositionWS16_g205222 = PositionWS122_g205214;
				float3 vertexToFrag76_g205214 = input.ase_texcoord8.xyz;
				float3 PivotWS121_g205214 = vertexToFrag76_g205214;
				#ifdef TVE_SCOPE_DYNAMIC
				float3 staticSwitch204_g205214 = ( PositionWS122_g205214 - PivotWS121_g205214 );
				#else
				float3 staticSwitch204_g205214 = PositionWS122_g205214;
				#endif
				float3 PositionWO132_g205214 = ( staticSwitch204_g205214 - TVE_WorldOrigin );
				float3 In_PositionWO16_g205222 = PositionWO132_g205214;
				float3 In_PivotWS16_g205222 = PivotWS121_g205214;
				float3 PivotWO133_g205214 = ( PivotWS121_g205214 - TVE_WorldOrigin );
				float3 In_PivotWO16_g205222 = PivotWO133_g205214;
				float3 normalizedWorldNormal = normalize( NormalWS );
				half3 NormalWS95_g205214 = normalizedWorldNormal;
				float3 In_NormalWS16_g205222 = NormalWS95_g205214;
				half3 TangentWS136_g205214 = TangentWS;
				float3 In_TangentWS16_g205222 = TangentWS136_g205214;
				half3 BiangentWS421_g205214 = BitangentWS;
				float3 In_BitangentWS16_g205222 = BiangentWS421_g205214;
				half3 NormalWS427_g205214 = NormalWS95_g205214;
				half3 localComputeTriplanarWeights427_g205214 = ComputeTriplanarWeights( NormalWS427_g205214 );
				half3 TriplanarWeights429_g205214 = localComputeTriplanarWeights427_g205214;
				float3 In_TriplanarWeights16_g205222 = TriplanarWeights429_g205214;
				float3 normalizeResult296_g205214 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g205214 ) );
				half3 ViewDirWS169_g205214 = normalizeResult296_g205214;
				float3 In_ViewDirWS16_g205222 = ViewDirWS169_g205214;
				float4 appendResult397_g205214 = (float4(input.ase_texcoord9.xy , input.ase_texcoord9.zw));
				float4 CoordsData398_g205214 = appendResult397_g205214;
				float4 In_CoordsData16_g205222 = CoordsData398_g205214;
				half4 VertexMasks171_g205214 = input.ase_color;
				float4 In_VertexData16_g205222 = VertexMasks171_g205214;
				float temp_output_17_0_g205226 = _ObjectPhaseMode;
				float Option70_g205226 = temp_output_17_0_g205226;
				float4 temp_output_3_0_g205226 = input.ase_color;
				float4 Channel70_g205226 = temp_output_3_0_g205226;
				float localSwitchChannel470_g205226 = SwitchChannel4( Option70_g205226 , Channel70_g205226 );
				half Phase_Value372_g205214 = localSwitchChannel470_g205226;
				float3 break319_g205214 = PivotWO133_g205214;
				half Pivot_Position322_g205214 = ( break319_g205214.x + break319_g205214.z );
				half Phase_Position357_g205214 = ( Phase_Value372_g205214 + Pivot_Position322_g205214 );
				float temp_output_248_0_g205214 = frac( Phase_Position357_g205214 );
				float4 appendResult177_g205214 = (float4(( (frac( ( Phase_Position357_g205214 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g205214));
				half4 Phase_Data176_g205214 = appendResult177_g205214;
				float4 In_PhaseData16_g205222 = Phase_Data176_g205214;
				BuildModelFragData( Data16_g205222 , In_Dummy16_g205222 , In_PositionWS16_g205222 , In_PositionWO16_g205222 , In_PivotWS16_g205222 , In_PivotWO16_g205222 , In_NormalWS16_g205222 , In_TangentWS16_g205222 , In_BitangentWS16_g205222 , In_TriplanarWeights16_g205222 , In_ViewDirWS16_g205222 , In_CoordsData16_g205222 , In_VertexData16_g205222 , In_PhaseData16_g205222 );
				TVEModelData Data15_g207087 =(TVEModelData)Data16_g205222;
				float Out_Dummy15_g207087 = 0.0;
				float3 Out_PositionWS15_g207087 = float3( 0,0,0 );
				float3 Out_PositionWO15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWS15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWO15_g207087 = float3( 0,0,0 );
				float3 Out_NormalWS15_g207087 = float3( 0,0,0 );
				float3 Out_TangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g207087 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g207087 = float3( 0,0,0 );
				float4 Out_CoordsData15_g207087 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g207087 = float4( 0,0,0,0 );
				float4 Out_PhaseData15_g207087 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g207087 , Out_Dummy15_g207087 , Out_PositionWS15_g207087 , Out_PositionWO15_g207087 , Out_PivotWS15_g207087 , Out_PivotWO15_g207087 , Out_NormalWS15_g207087 , Out_TangentWS15_g207087 , Out_BitangentWS15_g207087 , Out_TriplanarWeights15_g207087 , Out_ViewDirWS15_g207087 , Out_CoordsData15_g207087 , Out_VertexData15_g207087 , Out_PhaseData15_g207087 );
				half4 Model_CoordsData412_g207086 = Out_CoordsData15_g207087;
				float4 MeshCoords444_g251292 = Model_CoordsData412_g207086;
				float2 UV0444_g251292 = float2( 0,0 );
				float2 UV3444_g251292 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g251292 , MeshCoords444_g251292 , UV0444_g251292 , UV3444_g251292 );
				float4 appendResult430_g251292 = (float4(UV0444_g251292 , UV3444_g251292));
				float4 In_MaskA431_g251292 = appendResult430_g251292;
				float localComputeWorldCoords315_g251292 = ( 0.0 );
				float4 Coords315_g251292 = Local_Coords180_g207086;
				half3 Model_PositionWO222_g207086 = Out_PositionWO15_g207087;
				float3 PositionWS315_g251292 = Model_PositionWO222_g207086;
				float2 ZY315_g251292 = float2( 0,0 );
				float2 XZ315_g251292 = float2( 0,0 );
				float2 XY315_g251292 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g251292 , PositionWS315_g251292 , ZY315_g251292 , XZ315_g251292 , XY315_g251292 );
				float2 ZY402_g251292 = ZY315_g251292;
				float2 XZ403_g251292 = XZ315_g251292;
				float4 appendResult432_g251292 = (float4(ZY402_g251292 , XZ403_g251292));
				float4 In_MaskB431_g251292 = appendResult432_g251292;
				float2 XY404_g251292 = XY315_g251292;
				float localComputeStochasticCoords409_g251292 = ( 0.0 );
				float2 UV409_g251292 = ZY402_g251292;
				float2 UV1409_g251292 = float2( 0,0 );
				float2 UV2409_g251292 = float2( 0,0 );
				float2 UV3409_g251292 = float2( 0,0 );
				float3 Weights409_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g251292 , UV1409_g251292 , UV2409_g251292 , UV3409_g251292 , Weights409_g251292 );
				float4 appendResult433_g251292 = (float4(XY404_g251292 , UV1409_g251292));
				float4 In_MaskC431_g251292 = appendResult433_g251292;
				float4 appendResult434_g251292 = (float4(UV2409_g251292 , UV3409_g251292));
				float4 In_MaskD431_g251292 = appendResult434_g251292;
				float localComputeStochasticCoords422_g251292 = ( 0.0 );
				float2 UV422_g251292 = XZ403_g251292;
				float2 UV1422_g251292 = float2( 0,0 );
				float2 UV2422_g251292 = float2( 0,0 );
				float2 UV3422_g251292 = float2( 0,0 );
				float3 Weights422_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g251292 , UV1422_g251292 , UV2422_g251292 , UV3422_g251292 , Weights422_g251292 );
				float4 appendResult435_g251292 = (float4(UV1422_g251292 , UV2422_g251292));
				float4 In_MaskE431_g251292 = appendResult435_g251292;
				float localComputeStochasticCoords423_g251292 = ( 0.0 );
				float2 UV423_g251292 = XY404_g251292;
				float2 UV1423_g251292 = float2( 0,0 );
				float2 UV2423_g251292 = float2( 0,0 );
				float2 UV3423_g251292 = float2( 0,0 );
				float3 Weights423_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g251292 , UV1423_g251292 , UV2423_g251292 , UV3423_g251292 , Weights423_g251292 );
				float4 appendResult436_g251292 = (float4(UV3422_g251292 , UV1423_g251292));
				float4 In_MaskF431_g251292 = appendResult436_g251292;
				float4 appendResult437_g251292 = (float4(UV2423_g251292 , UV3423_g251292));
				float4 In_MaskG431_g251292 = appendResult437_g251292;
				float4 In_MaskH431_g251292 = float4( Weights409_g251292 , 0.0 );
				float4 In_MaskI431_g251292 = float4( Weights422_g251292 , 0.0 );
				float4 In_MaskJ431_g251292 = float4( Weights423_g251292 , 0.0 );
				float3 temp_output_449_0_g251292 = float3( 0,0,0 );
				float4 In_MaskK431_g251292 = float4( temp_output_449_0_g251292 , 0.0 );
				float3 temp_output_450_0_g251292 = float3( 0,0,0 );
				float4 In_MaskL431_g251292 = float4( temp_output_450_0_g251292 , 0.0 );
				float3 temp_output_451_0_g251292 = float3( 0,0,0 );
				float4 In_MaskM431_g251292 = float4( temp_output_451_0_g251292 , 0.0 );
				float3 temp_output_445_0_g251292 = float3( 0,0,0 );
				float4 In_MaskN431_g251292 = float4( temp_output_445_0_g251292 , 0.0 );
				BuildTextureData( Data431_g251292 , In_MaskA431_g251292 , In_MaskB431_g251292 , In_MaskC431_g251292 , In_MaskD431_g251292 , In_MaskE431_g251292 , In_MaskF431_g251292 , In_MaskG431_g251292 , In_MaskH431_g251292 , In_MaskI431_g251292 , In_MaskJ431_g251292 , In_MaskK431_g251292 , In_MaskL431_g251292 , In_MaskM431_g251292 , In_MaskN431_g251292 );
				TVEMasksData Data456_g207093 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207093 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207093 , Out_MaskA456_g207093 , Out_MaskB456_g207093 , Out_MaskC456_g207093 , Out_MaskD456_g207093 , Out_MaskE456_g207093 , Out_MaskF456_g207093 , Out_MaskG456_g207093 , Out_MaskH456_g207093 , Out_MaskI456_g207093 , Out_MaskJ456_g207093 , Out_MaskK456_g207093 , Out_MaskL456_g207093 , Out_MaskM456_g207093 , Out_MaskN456_g207093 );
				half2 UV276_g207093 = (Out_MaskA456_g207093).xy;
				float temp_output_504_0_g207093 = 0.0;
				half Bias276_g207093 = temp_output_504_0_g207093;
				half2 Normal276_g207093 = float2( 0,0 );
				half4 localSampleCoord276_g207093 = SampleCoord( Texture276_g207093 , Sampler276_g207093 , UV276_g207093 , Bias276_g207093 , Normal276_g207093 );
				TEXTURE2D(Texture502_g207093) = _MainAlbedoTex;
				SamplerState Sampler502_g207093 = staticSwitch36_g207096;
				half2 UV502_g207093 = (Out_MaskA456_g207093).zw;
				half Bias502_g207093 = temp_output_504_0_g207093;
				half2 Normal502_g207093 = float2( 0,0 );
				half4 localSampleCoord502_g207093 = SampleCoord( Texture502_g207093 , Sampler502_g207093 , UV502_g207093 , Bias502_g207093 , Normal502_g207093 );
				TEXTURE2D(Texture496_g207093) = _MainAlbedoTex;
				SamplerState Sampler496_g207093 = staticSwitch36_g207096;
				float2 temp_output_463_0_g207093 = (Out_MaskB456_g207093).zw;
				half2 XZ496_g207093 = temp_output_463_0_g207093;
				half Bias496_g207093 = temp_output_504_0_g207093;
				float3 temp_output_483_0_g207093 = (Out_MaskK456_g207093).xyz;
				half3 NormalWS496_g207093 = temp_output_483_0_g207093;
				half3 Normal496_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207093 = SamplePlanar2D( Texture496_g207093 , Sampler496_g207093 , XZ496_g207093 , Bias496_g207093 , NormalWS496_g207093 , Normal496_g207093 );
				TEXTURE2D(Texture490_g207093) = _MainAlbedoTex;
				SamplerState Sampler490_g207093 = staticSwitch36_g207096;
				float2 temp_output_462_0_g207093 = (Out_MaskB456_g207093).xy;
				half2 ZY490_g207093 = temp_output_462_0_g207093;
				half2 XZ490_g207093 = temp_output_463_0_g207093;
				float2 temp_output_464_0_g207093 = (Out_MaskC456_g207093).xy;
				half2 XY490_g207093 = temp_output_464_0_g207093;
				half Bias490_g207093 = temp_output_504_0_g207093;
				float3 temp_output_482_0_g207093 = (Out_MaskN456_g207093).xyz;
				half3 Triplanar490_g207093 = temp_output_482_0_g207093;
				half3 NormalWS490_g207093 = temp_output_483_0_g207093;
				half3 Normal490_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207093 = SamplePlanar3D( Texture490_g207093 , Sampler490_g207093 , ZY490_g207093 , XZ490_g207093 , XY490_g207093 , Bias490_g207093 , Triplanar490_g207093 , NormalWS490_g207093 , Normal490_g207093 );
				TEXTURE2D(Texture498_g207093) = _MainAlbedoTex;
				SamplerState Sampler498_g207093 = staticSwitch36_g207096;
				half2 XZ498_g207093 = temp_output_463_0_g207093;
				float2 temp_output_473_0_g207093 = (Out_MaskE456_g207093).xy;
				half2 XZ_1498_g207093 = temp_output_473_0_g207093;
				float2 temp_output_474_0_g207093 = (Out_MaskE456_g207093).zw;
				half2 XZ_2498_g207093 = temp_output_474_0_g207093;
				float2 temp_output_475_0_g207093 = (Out_MaskF456_g207093).xy;
				half2 XZ_3498_g207093 = temp_output_475_0_g207093;
				float temp_output_510_0_g207093 = exp2( temp_output_504_0_g207093 );
				half Bias498_g207093 = temp_output_510_0_g207093;
				float3 temp_output_480_0_g207093 = (Out_MaskI456_g207093).xyz;
				half3 Weights_2498_g207093 = temp_output_480_0_g207093;
				half3 NormalWS498_g207093 = temp_output_483_0_g207093;
				half3 Normal498_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207093 = SampleStochastic2D( Texture498_g207093 , Sampler498_g207093 , XZ498_g207093 , XZ_1498_g207093 , XZ_2498_g207093 , XZ_3498_g207093 , Bias498_g207093 , Weights_2498_g207093 , NormalWS498_g207093 , Normal498_g207093 );
				TEXTURE2D(Texture500_g207093) = _MainAlbedoTex;
				SamplerState Sampler500_g207093 = staticSwitch36_g207096;
				half2 ZY500_g207093 = temp_output_462_0_g207093;
				half2 ZY_1500_g207093 = (Out_MaskC456_g207093).zw;
				half2 ZY_2500_g207093 = (Out_MaskD456_g207093).xy;
				half2 ZY_3500_g207093 = (Out_MaskD456_g207093).zw;
				half2 XZ500_g207093 = temp_output_463_0_g207093;
				half2 XZ_1500_g207093 = temp_output_473_0_g207093;
				half2 XZ_2500_g207093 = temp_output_474_0_g207093;
				half2 XZ_3500_g207093 = temp_output_475_0_g207093;
				half2 XY500_g207093 = temp_output_464_0_g207093;
				half2 XY_1500_g207093 = (Out_MaskF456_g207093).zw;
				half2 XY_2500_g207093 = (Out_MaskG456_g207093).xy;
				half2 XY_3500_g207093 = (Out_MaskG456_g207093).zw;
				half Bias500_g207093 = temp_output_510_0_g207093;
				half3 Weights_1500_g207093 = (Out_MaskH456_g207093).xyz;
				half3 Weights_2500_g207093 = temp_output_480_0_g207093;
				half3 Weights_3500_g207093 = (Out_MaskJ456_g207093).xyz;
				half3 Triplanar500_g207093 = temp_output_482_0_g207093;
				half3 NormalWS500_g207093 = temp_output_483_0_g207093;
				half3 Normal500_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207093 = SampleStochastic3D( Texture500_g207093 , Sampler500_g207093 , ZY500_g207093 , ZY_1500_g207093 , ZY_2500_g207093 , ZY_3500_g207093 , XZ500_g207093 , XZ_1500_g207093 , XZ_2500_g207093 , XZ_3500_g207093 , XY500_g207093 , XY_1500_g207093 , XY_2500_g207093 , XY_3500_g207093 , Bias500_g207093 , Weights_1500_g207093 , Weights_2500_g207093 , Weights_3500_g207093 , Triplanar500_g207093 , NormalWS500_g207093 , Normal500_g207093 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch184_g207086 = localSampleCoord502_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch184_g207086 = localSamplePlanar2D496_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch184_g207086 = localSamplePlanar3D490_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch184_g207086 = localSampleStochastic2D498_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch184_g207086 = localSampleStochastic3D500_g207093;
				#else
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#endif
				half4 Local_AlbedoTex185_g207086 = staticSwitch184_g207086;
				float3 lerpResult53_g207086 = lerp( float3( 1,1,1 ) , (Local_AlbedoTex185_g207086).xyz , _MainAlbedoValue);
				half3 Local_AlbedoRGB107_g207086 = lerpResult53_g207086;
				TEXTURE2D(Texture276_g207097) = _MainShaderTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207098 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207097 = staticSwitch38_g207098;
				float localBreakTextureData456_g207097 = ( 0.0 );
				TVEMasksData Data456_g207097 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207097 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207097 , Out_MaskA456_g207097 , Out_MaskB456_g207097 , Out_MaskC456_g207097 , Out_MaskD456_g207097 , Out_MaskE456_g207097 , Out_MaskF456_g207097 , Out_MaskG456_g207097 , Out_MaskH456_g207097 , Out_MaskI456_g207097 , Out_MaskJ456_g207097 , Out_MaskK456_g207097 , Out_MaskL456_g207097 , Out_MaskM456_g207097 , Out_MaskN456_g207097 );
				half2 UV276_g207097 = (Out_MaskA456_g207097).xy;
				float temp_output_504_0_g207097 = 0.0;
				half Bias276_g207097 = temp_output_504_0_g207097;
				half2 Normal276_g207097 = float2( 0,0 );
				half4 localSampleCoord276_g207097 = SampleCoord( Texture276_g207097 , Sampler276_g207097 , UV276_g207097 , Bias276_g207097 , Normal276_g207097 );
				TEXTURE2D(Texture502_g207097) = _MainShaderTex;
				SamplerState Sampler502_g207097 = staticSwitch38_g207098;
				half2 UV502_g207097 = (Out_MaskA456_g207097).zw;
				half Bias502_g207097 = temp_output_504_0_g207097;
				half2 Normal502_g207097 = float2( 0,0 );
				half4 localSampleCoord502_g207097 = SampleCoord( Texture502_g207097 , Sampler502_g207097 , UV502_g207097 , Bias502_g207097 , Normal502_g207097 );
				TEXTURE2D(Texture496_g207097) = _MainShaderTex;
				SamplerState Sampler496_g207097 = staticSwitch38_g207098;
				float2 temp_output_463_0_g207097 = (Out_MaskB456_g207097).zw;
				half2 XZ496_g207097 = temp_output_463_0_g207097;
				half Bias496_g207097 = temp_output_504_0_g207097;
				float3 temp_output_483_0_g207097 = (Out_MaskK456_g207097).xyz;
				half3 NormalWS496_g207097 = temp_output_483_0_g207097;
				half3 Normal496_g207097 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207097 = SamplePlanar2D( Texture496_g207097 , Sampler496_g207097 , XZ496_g207097 , Bias496_g207097 , NormalWS496_g207097 , Normal496_g207097 );
				TEXTURE2D(Texture490_g207097) = _MainShaderTex;
				SamplerState Sampler490_g207097 = staticSwitch38_g207098;
				float2 temp_output_462_0_g207097 = (Out_MaskB456_g207097).xy;
				half2 ZY490_g207097 = temp_output_462_0_g207097;
				half2 XZ490_g207097 = temp_output_463_0_g207097;
				float2 temp_output_464_0_g207097 = (Out_MaskC456_g207097).xy;
				half2 XY490_g207097 = temp_output_464_0_g207097;
				half Bias490_g207097 = temp_output_504_0_g207097;
				float3 temp_output_482_0_g207097 = (Out_MaskN456_g207097).xyz;
				half3 Triplanar490_g207097 = temp_output_482_0_g207097;
				half3 NormalWS490_g207097 = temp_output_483_0_g207097;
				half3 Normal490_g207097 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207097 = SamplePlanar3D( Texture490_g207097 , Sampler490_g207097 , ZY490_g207097 , XZ490_g207097 , XY490_g207097 , Bias490_g207097 , Triplanar490_g207097 , NormalWS490_g207097 , Normal490_g207097 );
				TEXTURE2D(Texture498_g207097) = _MainShaderTex;
				SamplerState Sampler498_g207097 = staticSwitch38_g207098;
				half2 XZ498_g207097 = temp_output_463_0_g207097;
				float2 temp_output_473_0_g207097 = (Out_MaskE456_g207097).xy;
				half2 XZ_1498_g207097 = temp_output_473_0_g207097;
				float2 temp_output_474_0_g207097 = (Out_MaskE456_g207097).zw;
				half2 XZ_2498_g207097 = temp_output_474_0_g207097;
				float2 temp_output_475_0_g207097 = (Out_MaskF456_g207097).xy;
				half2 XZ_3498_g207097 = temp_output_475_0_g207097;
				float temp_output_510_0_g207097 = exp2( temp_output_504_0_g207097 );
				half Bias498_g207097 = temp_output_510_0_g207097;
				float3 temp_output_480_0_g207097 = (Out_MaskI456_g207097).xyz;
				half3 Weights_2498_g207097 = temp_output_480_0_g207097;
				half3 NormalWS498_g207097 = temp_output_483_0_g207097;
				half3 Normal498_g207097 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207097 = SampleStochastic2D( Texture498_g207097 , Sampler498_g207097 , XZ498_g207097 , XZ_1498_g207097 , XZ_2498_g207097 , XZ_3498_g207097 , Bias498_g207097 , Weights_2498_g207097 , NormalWS498_g207097 , Normal498_g207097 );
				TEXTURE2D(Texture500_g207097) = _MainShaderTex;
				SamplerState Sampler500_g207097 = staticSwitch38_g207098;
				half2 ZY500_g207097 = temp_output_462_0_g207097;
				half2 ZY_1500_g207097 = (Out_MaskC456_g207097).zw;
				half2 ZY_2500_g207097 = (Out_MaskD456_g207097).xy;
				half2 ZY_3500_g207097 = (Out_MaskD456_g207097).zw;
				half2 XZ500_g207097 = temp_output_463_0_g207097;
				half2 XZ_1500_g207097 = temp_output_473_0_g207097;
				half2 XZ_2500_g207097 = temp_output_474_0_g207097;
				half2 XZ_3500_g207097 = temp_output_475_0_g207097;
				half2 XY500_g207097 = temp_output_464_0_g207097;
				half2 XY_1500_g207097 = (Out_MaskF456_g207097).zw;
				half2 XY_2500_g207097 = (Out_MaskG456_g207097).xy;
				half2 XY_3500_g207097 = (Out_MaskG456_g207097).zw;
				half Bias500_g207097 = temp_output_510_0_g207097;
				half3 Weights_1500_g207097 = (Out_MaskH456_g207097).xyz;
				half3 Weights_2500_g207097 = temp_output_480_0_g207097;
				half3 Weights_3500_g207097 = (Out_MaskJ456_g207097).xyz;
				half3 Triplanar500_g207097 = temp_output_482_0_g207097;
				half3 NormalWS500_g207097 = temp_output_483_0_g207097;
				half3 Normal500_g207097 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207097 = SampleStochastic3D( Texture500_g207097 , Sampler500_g207097 , ZY500_g207097 , ZY_1500_g207097 , ZY_2500_g207097 , ZY_3500_g207097 , XZ500_g207097 , XZ_1500_g207097 , XZ_2500_g207097 , XZ_3500_g207097 , XY500_g207097 , XY_1500_g207097 , XY_2500_g207097 , XY_3500_g207097 , Bias500_g207097 , Weights_1500_g207097 , Weights_2500_g207097 , Weights_3500_g207097 , Triplanar500_g207097 , NormalWS500_g207097 , Normal500_g207097 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch198_g207086 = localSampleCoord276_g207097;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch198_g207086 = localSampleCoord502_g207097;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch198_g207086 = localSamplePlanar2D496_g207097;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch198_g207086 = localSamplePlanar3D490_g207097;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch198_g207086 = localSampleStochastic2D498_g207097;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch198_g207086 = localSampleStochastic3D500_g207097;
				#else
				float4 staticSwitch198_g207086 = localSampleCoord276_g207097;
				#endif
				half4 Local_ShaderTex199_g207086 = staticSwitch198_g207086;
				float temp_output_17_0_g251298 = _MainMetallicChannelMode;
				float Option83_g251298 = temp_output_17_0_g251298;
				TEXTURE2D(Texture276_g207101) = _MainMetallicTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207102 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207101 = staticSwitch38_g207102;
				float localBreakTextureData456_g207101 = ( 0.0 );
				TVEMasksData Data456_g207101 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207101 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207101 , Out_MaskA456_g207101 , Out_MaskB456_g207101 , Out_MaskC456_g207101 , Out_MaskD456_g207101 , Out_MaskE456_g207101 , Out_MaskF456_g207101 , Out_MaskG456_g207101 , Out_MaskH456_g207101 , Out_MaskI456_g207101 , Out_MaskJ456_g207101 , Out_MaskK456_g207101 , Out_MaskL456_g207101 , Out_MaskM456_g207101 , Out_MaskN456_g207101 );
				half2 UV276_g207101 = (Out_MaskA456_g207101).xy;
				float temp_output_504_0_g207101 = 0.0;
				half Bias276_g207101 = temp_output_504_0_g207101;
				half2 Normal276_g207101 = float2( 0,0 );
				half4 localSampleCoord276_g207101 = SampleCoord( Texture276_g207101 , Sampler276_g207101 , UV276_g207101 , Bias276_g207101 , Normal276_g207101 );
				TEXTURE2D(Texture502_g207101) = _MainMetallicTex;
				SamplerState Sampler502_g207101 = staticSwitch38_g207102;
				half2 UV502_g207101 = (Out_MaskA456_g207101).zw;
				half Bias502_g207101 = temp_output_504_0_g207101;
				half2 Normal502_g207101 = float2( 0,0 );
				half4 localSampleCoord502_g207101 = SampleCoord( Texture502_g207101 , Sampler502_g207101 , UV502_g207101 , Bias502_g207101 , Normal502_g207101 );
				TEXTURE2D(Texture496_g207101) = _MainMetallicTex;
				SamplerState Sampler496_g207101 = staticSwitch38_g207102;
				float2 temp_output_463_0_g207101 = (Out_MaskB456_g207101).zw;
				half2 XZ496_g207101 = temp_output_463_0_g207101;
				half Bias496_g207101 = temp_output_504_0_g207101;
				float3 temp_output_483_0_g207101 = (Out_MaskK456_g207101).xyz;
				half3 NormalWS496_g207101 = temp_output_483_0_g207101;
				half3 Normal496_g207101 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207101 = SamplePlanar2D( Texture496_g207101 , Sampler496_g207101 , XZ496_g207101 , Bias496_g207101 , NormalWS496_g207101 , Normal496_g207101 );
				TEXTURE2D(Texture490_g207101) = _MainMetallicTex;
				SamplerState Sampler490_g207101 = staticSwitch38_g207102;
				float2 temp_output_462_0_g207101 = (Out_MaskB456_g207101).xy;
				half2 ZY490_g207101 = temp_output_462_0_g207101;
				half2 XZ490_g207101 = temp_output_463_0_g207101;
				float2 temp_output_464_0_g207101 = (Out_MaskC456_g207101).xy;
				half2 XY490_g207101 = temp_output_464_0_g207101;
				half Bias490_g207101 = temp_output_504_0_g207101;
				float3 temp_output_482_0_g207101 = (Out_MaskN456_g207101).xyz;
				half3 Triplanar490_g207101 = temp_output_482_0_g207101;
				half3 NormalWS490_g207101 = temp_output_483_0_g207101;
				half3 Normal490_g207101 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207101 = SamplePlanar3D( Texture490_g207101 , Sampler490_g207101 , ZY490_g207101 , XZ490_g207101 , XY490_g207101 , Bias490_g207101 , Triplanar490_g207101 , NormalWS490_g207101 , Normal490_g207101 );
				TEXTURE2D(Texture498_g207101) = _MainMetallicTex;
				SamplerState Sampler498_g207101 = staticSwitch38_g207102;
				half2 XZ498_g207101 = temp_output_463_0_g207101;
				float2 temp_output_473_0_g207101 = (Out_MaskE456_g207101).xy;
				half2 XZ_1498_g207101 = temp_output_473_0_g207101;
				float2 temp_output_474_0_g207101 = (Out_MaskE456_g207101).zw;
				half2 XZ_2498_g207101 = temp_output_474_0_g207101;
				float2 temp_output_475_0_g207101 = (Out_MaskF456_g207101).xy;
				half2 XZ_3498_g207101 = temp_output_475_0_g207101;
				float temp_output_510_0_g207101 = exp2( temp_output_504_0_g207101 );
				half Bias498_g207101 = temp_output_510_0_g207101;
				float3 temp_output_480_0_g207101 = (Out_MaskI456_g207101).xyz;
				half3 Weights_2498_g207101 = temp_output_480_0_g207101;
				half3 NormalWS498_g207101 = temp_output_483_0_g207101;
				half3 Normal498_g207101 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207101 = SampleStochastic2D( Texture498_g207101 , Sampler498_g207101 , XZ498_g207101 , XZ_1498_g207101 , XZ_2498_g207101 , XZ_3498_g207101 , Bias498_g207101 , Weights_2498_g207101 , NormalWS498_g207101 , Normal498_g207101 );
				TEXTURE2D(Texture500_g207101) = _MainMetallicTex;
				SamplerState Sampler500_g207101 = staticSwitch38_g207102;
				half2 ZY500_g207101 = temp_output_462_0_g207101;
				half2 ZY_1500_g207101 = (Out_MaskC456_g207101).zw;
				half2 ZY_2500_g207101 = (Out_MaskD456_g207101).xy;
				half2 ZY_3500_g207101 = (Out_MaskD456_g207101).zw;
				half2 XZ500_g207101 = temp_output_463_0_g207101;
				half2 XZ_1500_g207101 = temp_output_473_0_g207101;
				half2 XZ_2500_g207101 = temp_output_474_0_g207101;
				half2 XZ_3500_g207101 = temp_output_475_0_g207101;
				half2 XY500_g207101 = temp_output_464_0_g207101;
				half2 XY_1500_g207101 = (Out_MaskF456_g207101).zw;
				half2 XY_2500_g207101 = (Out_MaskG456_g207101).xy;
				half2 XY_3500_g207101 = (Out_MaskG456_g207101).zw;
				half Bias500_g207101 = temp_output_510_0_g207101;
				half3 Weights_1500_g207101 = (Out_MaskH456_g207101).xyz;
				half3 Weights_2500_g207101 = temp_output_480_0_g207101;
				half3 Weights_3500_g207101 = (Out_MaskJ456_g207101).xyz;
				half3 Triplanar500_g207101 = temp_output_482_0_g207101;
				half3 NormalWS500_g207101 = temp_output_483_0_g207101;
				half3 Normal500_g207101 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207101 = SampleStochastic3D( Texture500_g207101 , Sampler500_g207101 , ZY500_g207101 , ZY_1500_g207101 , ZY_2500_g207101 , ZY_3500_g207101 , XZ500_g207101 , XZ_1500_g207101 , XZ_2500_g207101 , XZ_3500_g207101 , XY500_g207101 , XY_1500_g207101 , XY_2500_g207101 , XY_3500_g207101 , Bias500_g207101 , Weights_1500_g207101 , Weights_2500_g207101 , Weights_3500_g207101 , Triplanar500_g207101 , NormalWS500_g207101 , Normal500_g207101 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch335_g207086 = localSampleCoord276_g207101;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch335_g207086 = localSampleCoord502_g207101;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch335_g207086 = localSamplePlanar2D496_g207101;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch335_g207086 = localSamplePlanar3D490_g207101;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch335_g207086 = localSampleStochastic2D498_g207101;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch335_g207086 = localSampleStochastic3D500_g207101;
				#else
				float4 staticSwitch335_g207086 = localSampleCoord276_g207101;
				#endif
				half4 Local_MetallicTex341_g207086 = staticSwitch335_g207086;
				float4 ChannelA83_g251298 = Local_MetallicTex341_g207086;
				float4 ChannelB83_g251298 = ( 1.0 - Local_MetallicTex341_g207086 );
				float localSwitchChannel883_g251298 = SwitchChannel8( Option83_g251298 , ChannelA83_g251298 , ChannelB83_g251298 );
				float lerpResult366_g207086 = lerp( (Local_ShaderTex199_g207086).x , localSwitchChannel883_g251298 , _MainMetallicSourceMode);
				half Local_Metallic322_g207086 = ( lerpResult366_g207086 * _MainMetallicValue );
				float temp_output_17_0_g251299 = _MainOcclusionChannelMode;
				float Option83_g251299 = temp_output_17_0_g251299;
				TEXTURE2D(Texture276_g207103) = _MainOcclusionTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207108 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207103 = staticSwitch38_g207108;
				float localBreakTextureData456_g207103 = ( 0.0 );
				TVEMasksData Data456_g207103 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207103 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207103 , Out_MaskA456_g207103 , Out_MaskB456_g207103 , Out_MaskC456_g207103 , Out_MaskD456_g207103 , Out_MaskE456_g207103 , Out_MaskF456_g207103 , Out_MaskG456_g207103 , Out_MaskH456_g207103 , Out_MaskI456_g207103 , Out_MaskJ456_g207103 , Out_MaskK456_g207103 , Out_MaskL456_g207103 , Out_MaskM456_g207103 , Out_MaskN456_g207103 );
				half2 UV276_g207103 = (Out_MaskA456_g207103).xy;
				float temp_output_504_0_g207103 = 0.0;
				half Bias276_g207103 = temp_output_504_0_g207103;
				half2 Normal276_g207103 = float2( 0,0 );
				half4 localSampleCoord276_g207103 = SampleCoord( Texture276_g207103 , Sampler276_g207103 , UV276_g207103 , Bias276_g207103 , Normal276_g207103 );
				TEXTURE2D(Texture502_g207103) = _MainOcclusionTex;
				SamplerState Sampler502_g207103 = staticSwitch38_g207108;
				half2 UV502_g207103 = (Out_MaskA456_g207103).zw;
				half Bias502_g207103 = temp_output_504_0_g207103;
				half2 Normal502_g207103 = float2( 0,0 );
				half4 localSampleCoord502_g207103 = SampleCoord( Texture502_g207103 , Sampler502_g207103 , UV502_g207103 , Bias502_g207103 , Normal502_g207103 );
				TEXTURE2D(Texture496_g207103) = _MainOcclusionTex;
				SamplerState Sampler496_g207103 = staticSwitch38_g207108;
				float2 temp_output_463_0_g207103 = (Out_MaskB456_g207103).zw;
				half2 XZ496_g207103 = temp_output_463_0_g207103;
				half Bias496_g207103 = temp_output_504_0_g207103;
				float3 temp_output_483_0_g207103 = (Out_MaskK456_g207103).xyz;
				half3 NormalWS496_g207103 = temp_output_483_0_g207103;
				half3 Normal496_g207103 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207103 = SamplePlanar2D( Texture496_g207103 , Sampler496_g207103 , XZ496_g207103 , Bias496_g207103 , NormalWS496_g207103 , Normal496_g207103 );
				TEXTURE2D(Texture490_g207103) = _MainOcclusionTex;
				SamplerState Sampler490_g207103 = staticSwitch38_g207108;
				float2 temp_output_462_0_g207103 = (Out_MaskB456_g207103).xy;
				half2 ZY490_g207103 = temp_output_462_0_g207103;
				half2 XZ490_g207103 = temp_output_463_0_g207103;
				float2 temp_output_464_0_g207103 = (Out_MaskC456_g207103).xy;
				half2 XY490_g207103 = temp_output_464_0_g207103;
				half Bias490_g207103 = temp_output_504_0_g207103;
				float3 temp_output_482_0_g207103 = (Out_MaskN456_g207103).xyz;
				half3 Triplanar490_g207103 = temp_output_482_0_g207103;
				half3 NormalWS490_g207103 = temp_output_483_0_g207103;
				half3 Normal490_g207103 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207103 = SamplePlanar3D( Texture490_g207103 , Sampler490_g207103 , ZY490_g207103 , XZ490_g207103 , XY490_g207103 , Bias490_g207103 , Triplanar490_g207103 , NormalWS490_g207103 , Normal490_g207103 );
				TEXTURE2D(Texture498_g207103) = _MainOcclusionTex;
				SamplerState Sampler498_g207103 = staticSwitch38_g207108;
				half2 XZ498_g207103 = temp_output_463_0_g207103;
				float2 temp_output_473_0_g207103 = (Out_MaskE456_g207103).xy;
				half2 XZ_1498_g207103 = temp_output_473_0_g207103;
				float2 temp_output_474_0_g207103 = (Out_MaskE456_g207103).zw;
				half2 XZ_2498_g207103 = temp_output_474_0_g207103;
				float2 temp_output_475_0_g207103 = (Out_MaskF456_g207103).xy;
				half2 XZ_3498_g207103 = temp_output_475_0_g207103;
				float temp_output_510_0_g207103 = exp2( temp_output_504_0_g207103 );
				half Bias498_g207103 = temp_output_510_0_g207103;
				float3 temp_output_480_0_g207103 = (Out_MaskI456_g207103).xyz;
				half3 Weights_2498_g207103 = temp_output_480_0_g207103;
				half3 NormalWS498_g207103 = temp_output_483_0_g207103;
				half3 Normal498_g207103 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207103 = SampleStochastic2D( Texture498_g207103 , Sampler498_g207103 , XZ498_g207103 , XZ_1498_g207103 , XZ_2498_g207103 , XZ_3498_g207103 , Bias498_g207103 , Weights_2498_g207103 , NormalWS498_g207103 , Normal498_g207103 );
				TEXTURE2D(Texture500_g207103) = _MainOcclusionTex;
				SamplerState Sampler500_g207103 = staticSwitch38_g207108;
				half2 ZY500_g207103 = temp_output_462_0_g207103;
				half2 ZY_1500_g207103 = (Out_MaskC456_g207103).zw;
				half2 ZY_2500_g207103 = (Out_MaskD456_g207103).xy;
				half2 ZY_3500_g207103 = (Out_MaskD456_g207103).zw;
				half2 XZ500_g207103 = temp_output_463_0_g207103;
				half2 XZ_1500_g207103 = temp_output_473_0_g207103;
				half2 XZ_2500_g207103 = temp_output_474_0_g207103;
				half2 XZ_3500_g207103 = temp_output_475_0_g207103;
				half2 XY500_g207103 = temp_output_464_0_g207103;
				half2 XY_1500_g207103 = (Out_MaskF456_g207103).zw;
				half2 XY_2500_g207103 = (Out_MaskG456_g207103).xy;
				half2 XY_3500_g207103 = (Out_MaskG456_g207103).zw;
				half Bias500_g207103 = temp_output_510_0_g207103;
				half3 Weights_1500_g207103 = (Out_MaskH456_g207103).xyz;
				half3 Weights_2500_g207103 = temp_output_480_0_g207103;
				half3 Weights_3500_g207103 = (Out_MaskJ456_g207103).xyz;
				half3 Triplanar500_g207103 = temp_output_482_0_g207103;
				half3 NormalWS500_g207103 = temp_output_483_0_g207103;
				half3 Normal500_g207103 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207103 = SampleStochastic3D( Texture500_g207103 , Sampler500_g207103 , ZY500_g207103 , ZY_1500_g207103 , ZY_2500_g207103 , ZY_3500_g207103 , XZ500_g207103 , XZ_1500_g207103 , XZ_2500_g207103 , XZ_3500_g207103 , XY500_g207103 , XY_1500_g207103 , XY_2500_g207103 , XY_3500_g207103 , Bias500_g207103 , Weights_1500_g207103 , Weights_2500_g207103 , Weights_3500_g207103 , Triplanar500_g207103 , NormalWS500_g207103 , Normal500_g207103 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch343_g207086 = localSampleCoord276_g207103;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch343_g207086 = localSampleCoord502_g207103;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch343_g207086 = localSamplePlanar2D496_g207103;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch343_g207086 = localSamplePlanar3D490_g207103;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch343_g207086 = localSampleStochastic2D498_g207103;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch343_g207086 = localSampleStochastic3D500_g207103;
				#else
				float4 staticSwitch343_g207086 = localSampleCoord276_g207103;
				#endif
				half4 Local_OcclusionTex349_g207086 = staticSwitch343_g207086;
				float4 ChannelA83_g251299 = Local_OcclusionTex349_g207086;
				float4 ChannelB83_g251299 = ( 1.0 - Local_OcclusionTex349_g207086 );
				float localSwitchChannel883_g251299 = SwitchChannel8( Option83_g251299 , ChannelA83_g251299 , ChannelB83_g251299 );
				float lerpResult373_g207086 = lerp( (Local_ShaderTex199_g207086).y , localSwitchChannel883_g251299 , _MainOcclusionSourceMode);
				float clampResult17_g251301 = clamp( lerpResult373_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251300 = _MainOcclusionRemap.x;
				float temp_output_9_0_g251300 = ( clampResult17_g251301 - temp_output_7_0_g251300 );
				float lerpResult23_g207086 = lerp( 1.0 , saturate( ( temp_output_9_0_g251300 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
				half Local_Occlusion313_g207086 = lerpResult23_g207086;
				float temp_output_17_0_g251307 = _MainSmoothnessChannelMode;
				float Option83_g251307 = temp_output_17_0_g251307;
				TEXTURE2D(Texture276_g207106) = _MainSmoothnessTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207107 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207106 = staticSwitch38_g207107;
				float localBreakTextureData456_g207106 = ( 0.0 );
				TVEMasksData Data456_g207106 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207106 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207106 , Out_MaskA456_g207106 , Out_MaskB456_g207106 , Out_MaskC456_g207106 , Out_MaskD456_g207106 , Out_MaskE456_g207106 , Out_MaskF456_g207106 , Out_MaskG456_g207106 , Out_MaskH456_g207106 , Out_MaskI456_g207106 , Out_MaskJ456_g207106 , Out_MaskK456_g207106 , Out_MaskL456_g207106 , Out_MaskM456_g207106 , Out_MaskN456_g207106 );
				half2 UV276_g207106 = (Out_MaskA456_g207106).xy;
				float temp_output_504_0_g207106 = 0.0;
				half Bias276_g207106 = temp_output_504_0_g207106;
				half2 Normal276_g207106 = float2( 0,0 );
				half4 localSampleCoord276_g207106 = SampleCoord( Texture276_g207106 , Sampler276_g207106 , UV276_g207106 , Bias276_g207106 , Normal276_g207106 );
				TEXTURE2D(Texture502_g207106) = _MainSmoothnessTex;
				SamplerState Sampler502_g207106 = staticSwitch38_g207107;
				half2 UV502_g207106 = (Out_MaskA456_g207106).zw;
				half Bias502_g207106 = temp_output_504_0_g207106;
				half2 Normal502_g207106 = float2( 0,0 );
				half4 localSampleCoord502_g207106 = SampleCoord( Texture502_g207106 , Sampler502_g207106 , UV502_g207106 , Bias502_g207106 , Normal502_g207106 );
				TEXTURE2D(Texture496_g207106) = _MainSmoothnessTex;
				SamplerState Sampler496_g207106 = staticSwitch38_g207107;
				float2 temp_output_463_0_g207106 = (Out_MaskB456_g207106).zw;
				half2 XZ496_g207106 = temp_output_463_0_g207106;
				half Bias496_g207106 = temp_output_504_0_g207106;
				float3 temp_output_483_0_g207106 = (Out_MaskK456_g207106).xyz;
				half3 NormalWS496_g207106 = temp_output_483_0_g207106;
				half3 Normal496_g207106 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207106 = SamplePlanar2D( Texture496_g207106 , Sampler496_g207106 , XZ496_g207106 , Bias496_g207106 , NormalWS496_g207106 , Normal496_g207106 );
				TEXTURE2D(Texture490_g207106) = _MainSmoothnessTex;
				SamplerState Sampler490_g207106 = staticSwitch38_g207107;
				float2 temp_output_462_0_g207106 = (Out_MaskB456_g207106).xy;
				half2 ZY490_g207106 = temp_output_462_0_g207106;
				half2 XZ490_g207106 = temp_output_463_0_g207106;
				float2 temp_output_464_0_g207106 = (Out_MaskC456_g207106).xy;
				half2 XY490_g207106 = temp_output_464_0_g207106;
				half Bias490_g207106 = temp_output_504_0_g207106;
				float3 temp_output_482_0_g207106 = (Out_MaskN456_g207106).xyz;
				half3 Triplanar490_g207106 = temp_output_482_0_g207106;
				half3 NormalWS490_g207106 = temp_output_483_0_g207106;
				half3 Normal490_g207106 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207106 = SamplePlanar3D( Texture490_g207106 , Sampler490_g207106 , ZY490_g207106 , XZ490_g207106 , XY490_g207106 , Bias490_g207106 , Triplanar490_g207106 , NormalWS490_g207106 , Normal490_g207106 );
				TEXTURE2D(Texture498_g207106) = _MainSmoothnessTex;
				SamplerState Sampler498_g207106 = staticSwitch38_g207107;
				half2 XZ498_g207106 = temp_output_463_0_g207106;
				float2 temp_output_473_0_g207106 = (Out_MaskE456_g207106).xy;
				half2 XZ_1498_g207106 = temp_output_473_0_g207106;
				float2 temp_output_474_0_g207106 = (Out_MaskE456_g207106).zw;
				half2 XZ_2498_g207106 = temp_output_474_0_g207106;
				float2 temp_output_475_0_g207106 = (Out_MaskF456_g207106).xy;
				half2 XZ_3498_g207106 = temp_output_475_0_g207106;
				float temp_output_510_0_g207106 = exp2( temp_output_504_0_g207106 );
				half Bias498_g207106 = temp_output_510_0_g207106;
				float3 temp_output_480_0_g207106 = (Out_MaskI456_g207106).xyz;
				half3 Weights_2498_g207106 = temp_output_480_0_g207106;
				half3 NormalWS498_g207106 = temp_output_483_0_g207106;
				half3 Normal498_g207106 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207106 = SampleStochastic2D( Texture498_g207106 , Sampler498_g207106 , XZ498_g207106 , XZ_1498_g207106 , XZ_2498_g207106 , XZ_3498_g207106 , Bias498_g207106 , Weights_2498_g207106 , NormalWS498_g207106 , Normal498_g207106 );
				TEXTURE2D(Texture500_g207106) = _MainSmoothnessTex;
				SamplerState Sampler500_g207106 = staticSwitch38_g207107;
				half2 ZY500_g207106 = temp_output_462_0_g207106;
				half2 ZY_1500_g207106 = (Out_MaskC456_g207106).zw;
				half2 ZY_2500_g207106 = (Out_MaskD456_g207106).xy;
				half2 ZY_3500_g207106 = (Out_MaskD456_g207106).zw;
				half2 XZ500_g207106 = temp_output_463_0_g207106;
				half2 XZ_1500_g207106 = temp_output_473_0_g207106;
				half2 XZ_2500_g207106 = temp_output_474_0_g207106;
				half2 XZ_3500_g207106 = temp_output_475_0_g207106;
				half2 XY500_g207106 = temp_output_464_0_g207106;
				half2 XY_1500_g207106 = (Out_MaskF456_g207106).zw;
				half2 XY_2500_g207106 = (Out_MaskG456_g207106).xy;
				half2 XY_3500_g207106 = (Out_MaskG456_g207106).zw;
				half Bias500_g207106 = temp_output_510_0_g207106;
				half3 Weights_1500_g207106 = (Out_MaskH456_g207106).xyz;
				half3 Weights_2500_g207106 = temp_output_480_0_g207106;
				half3 Weights_3500_g207106 = (Out_MaskJ456_g207106).xyz;
				half3 Triplanar500_g207106 = temp_output_482_0_g207106;
				half3 NormalWS500_g207106 = temp_output_483_0_g207106;
				half3 Normal500_g207106 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207106 = SampleStochastic3D( Texture500_g207106 , Sampler500_g207106 , ZY500_g207106 , ZY_1500_g207106 , ZY_2500_g207106 , ZY_3500_g207106 , XZ500_g207106 , XZ_1500_g207106 , XZ_2500_g207106 , XZ_3500_g207106 , XY500_g207106 , XY_1500_g207106 , XY_2500_g207106 , XY_3500_g207106 , Bias500_g207106 , Weights_1500_g207106 , Weights_2500_g207106 , Weights_3500_g207106 , Triplanar500_g207106 , NormalWS500_g207106 , Normal500_g207106 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch359_g207086 = localSampleCoord276_g207106;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch359_g207086 = localSampleCoord502_g207106;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch359_g207086 = localSamplePlanar2D496_g207106;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch359_g207086 = localSamplePlanar3D490_g207106;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch359_g207086 = localSampleStochastic2D498_g207106;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch359_g207086 = localSampleStochastic3D500_g207106;
				#else
				float4 staticSwitch359_g207086 = localSampleCoord276_g207106;
				#endif
				half4 Local_SmoothnessTex365_g207086 = staticSwitch359_g207086;
				float4 temp_output_28_0_g251309 = Local_SmoothnessTex365_g207086;
				float3 temp_output_29_0_g251309 = (temp_output_28_0_g251309).xyz;
				half3 linRGB27_g251309 = temp_output_29_0_g251309;
				half3 localLinearToGammaFloatFast27_g251309 = LinearToGammaFloatFast( linRGB27_g251309 );
				#ifdef UNITY_COLORSPACE_GAMMA
				float3 staticSwitch26_g251309 = temp_output_29_0_g251309;
				#else
				float3 staticSwitch26_g251309 = localLinearToGammaFloatFast27_g251309;
				#endif
				float4 appendResult31_g251309 = (float4(staticSwitch26_g251309 , (temp_output_28_0_g251309).w));
				float4 lerpResult439_g207086 = lerp( Local_SmoothnessTex365_g207086 , appendResult31_g251309 , _MainSmoothnessTexGammaMode);
				float4 ChannelA83_g251307 = lerpResult439_g207086;
				float4 ChannelB83_g251307 = ( 1.0 - lerpResult439_g207086 );
				float localSwitchChannel883_g251307 = SwitchChannel8( Option83_g251307 , ChannelA83_g251307 , ChannelB83_g251307 );
				float lerpResult374_g207086 = lerp( (Local_ShaderTex199_g207086).w , localSwitchChannel883_g251307 , _MainSmoothnessSourceMode);
				float clampResult17_g251306 = clamp( lerpResult374_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251305 = _MainSmoothnessRemap.x;
				float temp_output_9_0_g251305 = ( clampResult17_g251306 - temp_output_7_0_g251305 );
				half Local_Smoothness317_g207086 = ( saturate( ( temp_output_9_0_g251305 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
				float4 appendResult73_g207086 = (float4(Local_Metallic322_g207086 , Local_Occlusion313_g207086 , 0.0 , Local_Smoothness317_g207086));
				half4 Local_Masks109_g207086 = appendResult73_g207086;
				float temp_output_17_0_g251304 = _MainMultiChannelMode;
				float Option83_g251304 = temp_output_17_0_g251304;
				TEXTURE2D(Texture276_g207104) = _MainMultiTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207105 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207104 = staticSwitch38_g207105;
				float localBreakTextureData456_g207104 = ( 0.0 );
				TVEMasksData Data456_g207104 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207104 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207104 , Out_MaskA456_g207104 , Out_MaskB456_g207104 , Out_MaskC456_g207104 , Out_MaskD456_g207104 , Out_MaskE456_g207104 , Out_MaskF456_g207104 , Out_MaskG456_g207104 , Out_MaskH456_g207104 , Out_MaskI456_g207104 , Out_MaskJ456_g207104 , Out_MaskK456_g207104 , Out_MaskL456_g207104 , Out_MaskM456_g207104 , Out_MaskN456_g207104 );
				half2 UV276_g207104 = (Out_MaskA456_g207104).xy;
				float temp_output_504_0_g207104 = 0.0;
				half Bias276_g207104 = temp_output_504_0_g207104;
				half2 Normal276_g207104 = float2( 0,0 );
				half4 localSampleCoord276_g207104 = SampleCoord( Texture276_g207104 , Sampler276_g207104 , UV276_g207104 , Bias276_g207104 , Normal276_g207104 );
				TEXTURE2D(Texture502_g207104) = _MainMultiTex;
				SamplerState Sampler502_g207104 = staticSwitch38_g207105;
				half2 UV502_g207104 = (Out_MaskA456_g207104).zw;
				half Bias502_g207104 = temp_output_504_0_g207104;
				half2 Normal502_g207104 = float2( 0,0 );
				half4 localSampleCoord502_g207104 = SampleCoord( Texture502_g207104 , Sampler502_g207104 , UV502_g207104 , Bias502_g207104 , Normal502_g207104 );
				TEXTURE2D(Texture496_g207104) = _MainMultiTex;
				SamplerState Sampler496_g207104 = staticSwitch38_g207105;
				float2 temp_output_463_0_g207104 = (Out_MaskB456_g207104).zw;
				half2 XZ496_g207104 = temp_output_463_0_g207104;
				half Bias496_g207104 = temp_output_504_0_g207104;
				float3 temp_output_483_0_g207104 = (Out_MaskK456_g207104).xyz;
				half3 NormalWS496_g207104 = temp_output_483_0_g207104;
				half3 Normal496_g207104 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207104 = SamplePlanar2D( Texture496_g207104 , Sampler496_g207104 , XZ496_g207104 , Bias496_g207104 , NormalWS496_g207104 , Normal496_g207104 );
				TEXTURE2D(Texture490_g207104) = _MainMultiTex;
				SamplerState Sampler490_g207104 = staticSwitch38_g207105;
				float2 temp_output_462_0_g207104 = (Out_MaskB456_g207104).xy;
				half2 ZY490_g207104 = temp_output_462_0_g207104;
				half2 XZ490_g207104 = temp_output_463_0_g207104;
				float2 temp_output_464_0_g207104 = (Out_MaskC456_g207104).xy;
				half2 XY490_g207104 = temp_output_464_0_g207104;
				half Bias490_g207104 = temp_output_504_0_g207104;
				float3 temp_output_482_0_g207104 = (Out_MaskN456_g207104).xyz;
				half3 Triplanar490_g207104 = temp_output_482_0_g207104;
				half3 NormalWS490_g207104 = temp_output_483_0_g207104;
				half3 Normal490_g207104 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207104 = SamplePlanar3D( Texture490_g207104 , Sampler490_g207104 , ZY490_g207104 , XZ490_g207104 , XY490_g207104 , Bias490_g207104 , Triplanar490_g207104 , NormalWS490_g207104 , Normal490_g207104 );
				TEXTURE2D(Texture498_g207104) = _MainMultiTex;
				SamplerState Sampler498_g207104 = staticSwitch38_g207105;
				half2 XZ498_g207104 = temp_output_463_0_g207104;
				float2 temp_output_473_0_g207104 = (Out_MaskE456_g207104).xy;
				half2 XZ_1498_g207104 = temp_output_473_0_g207104;
				float2 temp_output_474_0_g207104 = (Out_MaskE456_g207104).zw;
				half2 XZ_2498_g207104 = temp_output_474_0_g207104;
				float2 temp_output_475_0_g207104 = (Out_MaskF456_g207104).xy;
				half2 XZ_3498_g207104 = temp_output_475_0_g207104;
				float temp_output_510_0_g207104 = exp2( temp_output_504_0_g207104 );
				half Bias498_g207104 = temp_output_510_0_g207104;
				float3 temp_output_480_0_g207104 = (Out_MaskI456_g207104).xyz;
				half3 Weights_2498_g207104 = temp_output_480_0_g207104;
				half3 NormalWS498_g207104 = temp_output_483_0_g207104;
				half3 Normal498_g207104 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207104 = SampleStochastic2D( Texture498_g207104 , Sampler498_g207104 , XZ498_g207104 , XZ_1498_g207104 , XZ_2498_g207104 , XZ_3498_g207104 , Bias498_g207104 , Weights_2498_g207104 , NormalWS498_g207104 , Normal498_g207104 );
				TEXTURE2D(Texture500_g207104) = _MainMultiTex;
				SamplerState Sampler500_g207104 = staticSwitch38_g207105;
				half2 ZY500_g207104 = temp_output_462_0_g207104;
				half2 ZY_1500_g207104 = (Out_MaskC456_g207104).zw;
				half2 ZY_2500_g207104 = (Out_MaskD456_g207104).xy;
				half2 ZY_3500_g207104 = (Out_MaskD456_g207104).zw;
				half2 XZ500_g207104 = temp_output_463_0_g207104;
				half2 XZ_1500_g207104 = temp_output_473_0_g207104;
				half2 XZ_2500_g207104 = temp_output_474_0_g207104;
				half2 XZ_3500_g207104 = temp_output_475_0_g207104;
				half2 XY500_g207104 = temp_output_464_0_g207104;
				half2 XY_1500_g207104 = (Out_MaskF456_g207104).zw;
				half2 XY_2500_g207104 = (Out_MaskG456_g207104).xy;
				half2 XY_3500_g207104 = (Out_MaskG456_g207104).zw;
				half Bias500_g207104 = temp_output_510_0_g207104;
				half3 Weights_1500_g207104 = (Out_MaskH456_g207104).xyz;
				half3 Weights_2500_g207104 = temp_output_480_0_g207104;
				half3 Weights_3500_g207104 = (Out_MaskJ456_g207104).xyz;
				half3 Triplanar500_g207104 = temp_output_482_0_g207104;
				half3 NormalWS500_g207104 = temp_output_483_0_g207104;
				half3 Normal500_g207104 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207104 = SampleStochastic3D( Texture500_g207104 , Sampler500_g207104 , ZY500_g207104 , ZY_1500_g207104 , ZY_2500_g207104 , ZY_3500_g207104 , XZ500_g207104 , XZ_1500_g207104 , XZ_2500_g207104 , XZ_3500_g207104 , XY500_g207104 , XY_1500_g207104 , XY_2500_g207104 , XY_3500_g207104 , Bias500_g207104 , Weights_1500_g207104 , Weights_2500_g207104 , Weights_3500_g207104 , Triplanar500_g207104 , NormalWS500_g207104 , Normal500_g207104 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch351_g207086 = localSampleCoord276_g207104;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch351_g207086 = localSampleCoord502_g207104;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch351_g207086 = localSamplePlanar2D496_g207104;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch351_g207086 = localSamplePlanar3D490_g207104;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch351_g207086 = localSampleStochastic2D498_g207104;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch351_g207086 = localSampleStochastic3D500_g207104;
				#else
				float4 staticSwitch351_g207086 = localSampleCoord276_g207104;
				#endif
				half4 Local_MultiTex357_g207086 = staticSwitch351_g207086;
				float4 ChannelA83_g251304 = Local_MultiTex357_g207086;
				float4 ChannelB83_g251304 = ( 1.0 - Local_MultiTex357_g207086 );
				float localSwitchChannel883_g251304 = SwitchChannel8( Option83_g251304 , ChannelA83_g251304 , ChannelB83_g251304 );
				float lerpResult378_g207086 = lerp( (Local_Masks109_g207086).z , localSwitchChannel883_g251304 , _MainMultiSourceMode);
				float clampResult17_g251302 = clamp( lerpResult378_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251303 = _MainMultiRemap.x;
				float temp_output_9_0_g251303 = ( clampResult17_g251302 - temp_output_7_0_g251303 );
				half Local_MultiMask78_g207086 = ( saturate( ( temp_output_9_0_g251303 * _MainMultiRemap.z ) ) * _MainMultiVlaue );
				float lerpResult58_g207086 = lerp( 1.0 , Local_MultiMask78_g207086 , _MainColorMode);
				float4 lerpResult62_g207086 = lerp( _MainColorTwo , _MainColor , lerpResult58_g207086);
				half3 Local_ColorRGB93_g207086 = (lerpResult62_g207086).rgb;
				half3 Local_Albedo139_g207086 = ( Local_AlbedoRGB107_g207086 * Local_ColorRGB93_g207086 );
				float3 temp_output_4_0_g207088 = Local_Albedo139_g207086;
				float3 In_Albedo3_g207088 = temp_output_4_0_g207088;
				float3 temp_output_44_0_g207088 = Local_Albedo139_g207086;
				float3 In_AlbedoBase3_g207088 = temp_output_44_0_g207088;
				TEXTURE2D(Texture276_g207094) = _MainNormalTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch37_g207095 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207094 = staticSwitch37_g207095;
				float localBreakTextureData456_g207094 = ( 0.0 );
				TVEMasksData Data456_g207094 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207094 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207094 , Out_MaskA456_g207094 , Out_MaskB456_g207094 , Out_MaskC456_g207094 , Out_MaskD456_g207094 , Out_MaskE456_g207094 , Out_MaskF456_g207094 , Out_MaskG456_g207094 , Out_MaskH456_g207094 , Out_MaskI456_g207094 , Out_MaskJ456_g207094 , Out_MaskK456_g207094 , Out_MaskL456_g207094 , Out_MaskM456_g207094 , Out_MaskN456_g207094 );
				half2 UV276_g207094 = (Out_MaskA456_g207094).xy;
				float temp_output_504_0_g207094 = 0.0;
				half Bias276_g207094 = temp_output_504_0_g207094;
				half2 Normal276_g207094 = float2( 0,0 );
				half4 localSampleCoord276_g207094 = SampleCoord( Texture276_g207094 , Sampler276_g207094 , UV276_g207094 , Bias276_g207094 , Normal276_g207094 );
				TEXTURE2D(Texture502_g207094) = _MainNormalTex;
				SamplerState Sampler502_g207094 = staticSwitch37_g207095;
				half2 UV502_g207094 = (Out_MaskA456_g207094).zw;
				half Bias502_g207094 = temp_output_504_0_g207094;
				half2 Normal502_g207094 = float2( 0,0 );
				half4 localSampleCoord502_g207094 = SampleCoord( Texture502_g207094 , Sampler502_g207094 , UV502_g207094 , Bias502_g207094 , Normal502_g207094 );
				TEXTURE2D(Texture496_g207094) = _MainNormalTex;
				SamplerState Sampler496_g207094 = staticSwitch37_g207095;
				float2 temp_output_463_0_g207094 = (Out_MaskB456_g207094).zw;
				half2 XZ496_g207094 = temp_output_463_0_g207094;
				half Bias496_g207094 = temp_output_504_0_g207094;
				float3 temp_output_483_0_g207094 = (Out_MaskK456_g207094).xyz;
				half3 NormalWS496_g207094 = temp_output_483_0_g207094;
				half3 Normal496_g207094 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207094 = SamplePlanar2D( Texture496_g207094 , Sampler496_g207094 , XZ496_g207094 , Bias496_g207094 , NormalWS496_g207094 , Normal496_g207094 );
				TEXTURE2D(Texture490_g207094) = _MainNormalTex;
				SamplerState Sampler490_g207094 = staticSwitch37_g207095;
				float2 temp_output_462_0_g207094 = (Out_MaskB456_g207094).xy;
				half2 ZY490_g207094 = temp_output_462_0_g207094;
				half2 XZ490_g207094 = temp_output_463_0_g207094;
				float2 temp_output_464_0_g207094 = (Out_MaskC456_g207094).xy;
				half2 XY490_g207094 = temp_output_464_0_g207094;
				half Bias490_g207094 = temp_output_504_0_g207094;
				float3 temp_output_482_0_g207094 = (Out_MaskN456_g207094).xyz;
				half3 Triplanar490_g207094 = temp_output_482_0_g207094;
				half3 NormalWS490_g207094 = temp_output_483_0_g207094;
				half3 Normal490_g207094 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207094 = SamplePlanar3D( Texture490_g207094 , Sampler490_g207094 , ZY490_g207094 , XZ490_g207094 , XY490_g207094 , Bias490_g207094 , Triplanar490_g207094 , NormalWS490_g207094 , Normal490_g207094 );
				TEXTURE2D(Texture498_g207094) = _MainNormalTex;
				SamplerState Sampler498_g207094 = staticSwitch37_g207095;
				half2 XZ498_g207094 = temp_output_463_0_g207094;
				float2 temp_output_473_0_g207094 = (Out_MaskE456_g207094).xy;
				half2 XZ_1498_g207094 = temp_output_473_0_g207094;
				float2 temp_output_474_0_g207094 = (Out_MaskE456_g207094).zw;
				half2 XZ_2498_g207094 = temp_output_474_0_g207094;
				float2 temp_output_475_0_g207094 = (Out_MaskF456_g207094).xy;
				half2 XZ_3498_g207094 = temp_output_475_0_g207094;
				float temp_output_510_0_g207094 = exp2( temp_output_504_0_g207094 );
				half Bias498_g207094 = temp_output_510_0_g207094;
				float3 temp_output_480_0_g207094 = (Out_MaskI456_g207094).xyz;
				half3 Weights_2498_g207094 = temp_output_480_0_g207094;
				half3 NormalWS498_g207094 = temp_output_483_0_g207094;
				half3 Normal498_g207094 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207094 = SampleStochastic2D( Texture498_g207094 , Sampler498_g207094 , XZ498_g207094 , XZ_1498_g207094 , XZ_2498_g207094 , XZ_3498_g207094 , Bias498_g207094 , Weights_2498_g207094 , NormalWS498_g207094 , Normal498_g207094 );
				TEXTURE2D(Texture500_g207094) = _MainNormalTex;
				SamplerState Sampler500_g207094 = staticSwitch37_g207095;
				half2 ZY500_g207094 = temp_output_462_0_g207094;
				half2 ZY_1500_g207094 = (Out_MaskC456_g207094).zw;
				half2 ZY_2500_g207094 = (Out_MaskD456_g207094).xy;
				half2 ZY_3500_g207094 = (Out_MaskD456_g207094).zw;
				half2 XZ500_g207094 = temp_output_463_0_g207094;
				half2 XZ_1500_g207094 = temp_output_473_0_g207094;
				half2 XZ_2500_g207094 = temp_output_474_0_g207094;
				half2 XZ_3500_g207094 = temp_output_475_0_g207094;
				half2 XY500_g207094 = temp_output_464_0_g207094;
				half2 XY_1500_g207094 = (Out_MaskF456_g207094).zw;
				half2 XY_2500_g207094 = (Out_MaskG456_g207094).xy;
				half2 XY_3500_g207094 = (Out_MaskG456_g207094).zw;
				half Bias500_g207094 = temp_output_510_0_g207094;
				half3 Weights_1500_g207094 = (Out_MaskH456_g207094).xyz;
				half3 Weights_2500_g207094 = temp_output_480_0_g207094;
				half3 Weights_3500_g207094 = (Out_MaskJ456_g207094).xyz;
				half3 Triplanar500_g207094 = temp_output_482_0_g207094;
				half3 NormalWS500_g207094 = temp_output_483_0_g207094;
				half3 Normal500_g207094 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207094 = SampleStochastic3D( Texture500_g207094 , Sampler500_g207094 , ZY500_g207094 , ZY_1500_g207094 , ZY_2500_g207094 , ZY_3500_g207094 , XZ500_g207094 , XZ_1500_g207094 , XZ_2500_g207094 , XZ_3500_g207094 , XY500_g207094 , XY_1500_g207094 , XY_2500_g207094 , XY_3500_g207094 , Bias500_g207094 , Weights_1500_g207094 , Weights_2500_g207094 , Weights_3500_g207094 , Triplanar500_g207094 , NormalWS500_g207094 , Normal500_g207094 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch193_g207086 = localSampleCoord276_g207094;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch193_g207086 = localSampleCoord502_g207094;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch193_g207086 = localSamplePlanar2D496_g207094;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch193_g207086 = localSamplePlanar3D490_g207094;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch193_g207086 = localSampleStochastic2D498_g207094;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch193_g207086 = localSampleStochastic3D500_g207094;
				#else
				float4 staticSwitch193_g207086 = localSampleCoord276_g207094;
				#endif
				half4 Local_NormaTex191_g207086 = staticSwitch193_g207086;
				half4 Normal_Packed45_g207089 = Local_NormaTex191_g207086;
				float2 appendResult58_g207089 = (float2(( (Normal_Packed45_g207089).x * (Normal_Packed45_g207089).w ) , (Normal_Packed45_g207089).y));
				half2 Normal_Default50_g207089 = appendResult58_g207089;
				half2 Normal_ASTC41_g207089 = (Normal_Packed45_g207089).xy;
				#ifdef UNITY_ASTC_NORMALMAP_ENCODING
				float2 staticSwitch38_g207089 = Normal_ASTC41_g207089;
				#else
				float2 staticSwitch38_g207089 = Normal_Default50_g207089;
				#endif
				half2 Normal_NO_DTX544_g207089 = (Normal_Packed45_g207089).wy;
				#ifdef UNITY_NO_DXT5nm
				float2 staticSwitch37_g207089 = Normal_NO_DTX544_g207089;
				#else
				float2 staticSwitch37_g207089 = staticSwitch38_g207089;
				#endif
				float2 temp_output_26_0_g207086 = ( (staticSwitch37_g207089*2.0 + -1.0) * _MainNormalValue );
				float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
				half2 Normal_Planar45_g207090 = temp_output_26_0_g207086;
				float2 break71_g207090 = Normal_Planar45_g207090;
				float3 appendResult72_g207090 = (float3(break71_g207090.x , 0.0 , break71_g207090.y));
				float2 temp_output_205_0_g207086 = (mul( ase_worldToTangent, appendResult72_g207090 )).xy;
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#else
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#endif
				half2 Local_NormalTS108_g207086 = staticSwitch204_g207086;
				float2 In_NormalTS3_g207088 = Local_NormalTS108_g207086;
				float3 appendResult68_g207091 = (float3(Local_NormalTS108_g207086 , 1.0));
				float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
				float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
				float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
				float3 tanNormal74_g207091 = appendResult68_g207091;
				float3 worldNormal74_g207091 = normalize( float3( dot( tanToWorld0, tanNormal74_g207091 ), dot( tanToWorld1, tanNormal74_g207091 ), dot( tanToWorld2, tanNormal74_g207091 ) ) );
				half3 Local_NormalWS250_g207086 = worldNormal74_g207091;
				float3 In_NormalWS3_g207088 = Local_NormalWS250_g207086;
				float4 In_Shader3_g207088 = Local_Masks109_g207086;
				float4 In_Feature3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Season3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Emissive3_g207088 = half4( 1, 1, 1, 1 );
				float3 temp_output_3_0_g207092 = Local_Albedo139_g207086;
				float dotResult20_g207092 = dot( temp_output_3_0_g207092 , float3( 0.2126, 0.7152, 0.0722 ) );
				half Local_Grayscale110_g207086 = dotResult20_g207092;
				float temp_output_12_0_g207088 = Local_Grayscale110_g207086;
				float In_Grayscale3_g207088 = temp_output_12_0_g207088;
				float clampResult144_g207086 = clamp( saturate( ( Local_Grayscale110_g207086 * 5.0 ) ) , 0.2 , 1.0 );
				half Local_Luminosity145_g207086 = clampResult144_g207086;
				float temp_output_16_0_g207088 = Local_Luminosity145_g207086;
				float In_Luminosity3_g207088 = temp_output_16_0_g207088;
				float In_MultiMask3_g207088 = Local_MultiMask78_g207086;
				float temp_output_17_0_g251310 = _MainAlphaChannelMode;
				float Option83_g251310 = temp_output_17_0_g251310;
				TEXTURE2D(Texture276_g207099) = _MainAlphaTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g207100 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g207099 = staticSwitch36_g207100;
				float localBreakTextureData456_g207099 = ( 0.0 );
				TVEMasksData Data456_g207099 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207099 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207099 , Out_MaskA456_g207099 , Out_MaskB456_g207099 , Out_MaskC456_g207099 , Out_MaskD456_g207099 , Out_MaskE456_g207099 , Out_MaskF456_g207099 , Out_MaskG456_g207099 , Out_MaskH456_g207099 , Out_MaskI456_g207099 , Out_MaskJ456_g207099 , Out_MaskK456_g207099 , Out_MaskL456_g207099 , Out_MaskM456_g207099 , Out_MaskN456_g207099 );
				half2 UV276_g207099 = (Out_MaskA456_g207099).xy;
				float temp_output_504_0_g207099 = 0.0;
				half Bias276_g207099 = temp_output_504_0_g207099;
				half2 Normal276_g207099 = float2( 0,0 );
				half4 localSampleCoord276_g207099 = SampleCoord( Texture276_g207099 , Sampler276_g207099 , UV276_g207099 , Bias276_g207099 , Normal276_g207099 );
				TEXTURE2D(Texture502_g207099) = _MainAlphaTex;
				SamplerState Sampler502_g207099 = staticSwitch36_g207100;
				half2 UV502_g207099 = (Out_MaskA456_g207099).zw;
				half Bias502_g207099 = temp_output_504_0_g207099;
				half2 Normal502_g207099 = float2( 0,0 );
				half4 localSampleCoord502_g207099 = SampleCoord( Texture502_g207099 , Sampler502_g207099 , UV502_g207099 , Bias502_g207099 , Normal502_g207099 );
				TEXTURE2D(Texture496_g207099) = _MainAlphaTex;
				SamplerState Sampler496_g207099 = staticSwitch36_g207100;
				float2 temp_output_463_0_g207099 = (Out_MaskB456_g207099).zw;
				half2 XZ496_g207099 = temp_output_463_0_g207099;
				half Bias496_g207099 = temp_output_504_0_g207099;
				float3 temp_output_483_0_g207099 = (Out_MaskK456_g207099).xyz;
				half3 NormalWS496_g207099 = temp_output_483_0_g207099;
				half3 Normal496_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207099 = SamplePlanar2D( Texture496_g207099 , Sampler496_g207099 , XZ496_g207099 , Bias496_g207099 , NormalWS496_g207099 , Normal496_g207099 );
				TEXTURE2D(Texture490_g207099) = _MainAlphaTex;
				SamplerState Sampler490_g207099 = staticSwitch36_g207100;
				float2 temp_output_462_0_g207099 = (Out_MaskB456_g207099).xy;
				half2 ZY490_g207099 = temp_output_462_0_g207099;
				half2 XZ490_g207099 = temp_output_463_0_g207099;
				float2 temp_output_464_0_g207099 = (Out_MaskC456_g207099).xy;
				half2 XY490_g207099 = temp_output_464_0_g207099;
				half Bias490_g207099 = temp_output_504_0_g207099;
				float3 temp_output_482_0_g207099 = (Out_MaskN456_g207099).xyz;
				half3 Triplanar490_g207099 = temp_output_482_0_g207099;
				half3 NormalWS490_g207099 = temp_output_483_0_g207099;
				half3 Normal490_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207099 = SamplePlanar3D( Texture490_g207099 , Sampler490_g207099 , ZY490_g207099 , XZ490_g207099 , XY490_g207099 , Bias490_g207099 , Triplanar490_g207099 , NormalWS490_g207099 , Normal490_g207099 );
				TEXTURE2D(Texture498_g207099) = _MainAlphaTex;
				SamplerState Sampler498_g207099 = staticSwitch36_g207100;
				half2 XZ498_g207099 = temp_output_463_0_g207099;
				float2 temp_output_473_0_g207099 = (Out_MaskE456_g207099).xy;
				half2 XZ_1498_g207099 = temp_output_473_0_g207099;
				float2 temp_output_474_0_g207099 = (Out_MaskE456_g207099).zw;
				half2 XZ_2498_g207099 = temp_output_474_0_g207099;
				float2 temp_output_475_0_g207099 = (Out_MaskF456_g207099).xy;
				half2 XZ_3498_g207099 = temp_output_475_0_g207099;
				float temp_output_510_0_g207099 = exp2( temp_output_504_0_g207099 );
				half Bias498_g207099 = temp_output_510_0_g207099;
				float3 temp_output_480_0_g207099 = (Out_MaskI456_g207099).xyz;
				half3 Weights_2498_g207099 = temp_output_480_0_g207099;
				half3 NormalWS498_g207099 = temp_output_483_0_g207099;
				half3 Normal498_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207099 = SampleStochastic2D( Texture498_g207099 , Sampler498_g207099 , XZ498_g207099 , XZ_1498_g207099 , XZ_2498_g207099 , XZ_3498_g207099 , Bias498_g207099 , Weights_2498_g207099 , NormalWS498_g207099 , Normal498_g207099 );
				TEXTURE2D(Texture500_g207099) = _MainAlphaTex;
				SamplerState Sampler500_g207099 = staticSwitch36_g207100;
				half2 ZY500_g207099 = temp_output_462_0_g207099;
				half2 ZY_1500_g207099 = (Out_MaskC456_g207099).zw;
				half2 ZY_2500_g207099 = (Out_MaskD456_g207099).xy;
				half2 ZY_3500_g207099 = (Out_MaskD456_g207099).zw;
				half2 XZ500_g207099 = temp_output_463_0_g207099;
				half2 XZ_1500_g207099 = temp_output_473_0_g207099;
				half2 XZ_2500_g207099 = temp_output_474_0_g207099;
				half2 XZ_3500_g207099 = temp_output_475_0_g207099;
				half2 XY500_g207099 = temp_output_464_0_g207099;
				half2 XY_1500_g207099 = (Out_MaskF456_g207099).zw;
				half2 XY_2500_g207099 = (Out_MaskG456_g207099).xy;
				half2 XY_3500_g207099 = (Out_MaskG456_g207099).zw;
				half Bias500_g207099 = temp_output_510_0_g207099;
				half3 Weights_1500_g207099 = (Out_MaskH456_g207099).xyz;
				half3 Weights_2500_g207099 = temp_output_480_0_g207099;
				half3 Weights_3500_g207099 = (Out_MaskJ456_g207099).xyz;
				half3 Triplanar500_g207099 = temp_output_482_0_g207099;
				half3 NormalWS500_g207099 = temp_output_483_0_g207099;
				half3 Normal500_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207099 = SampleStochastic3D( Texture500_g207099 , Sampler500_g207099 , ZY500_g207099 , ZY_1500_g207099 , ZY_2500_g207099 , ZY_3500_g207099 , XZ500_g207099 , XZ_1500_g207099 , XZ_2500_g207099 , XZ_3500_g207099 , XY500_g207099 , XY_1500_g207099 , XY_2500_g207099 , XY_3500_g207099 , Bias500_g207099 , Weights_1500_g207099 , Weights_2500_g207099 , Weights_3500_g207099 , Triplanar500_g207099 , NormalWS500_g207099 , Normal500_g207099 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch327_g207086 = localSampleCoord276_g207099;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch327_g207086 = localSampleCoord502_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch327_g207086 = localSamplePlanar2D496_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch327_g207086 = localSamplePlanar3D490_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch327_g207086 = localSampleStochastic2D498_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch327_g207086 = localSampleStochastic3D500_g207099;
				#else
				float4 staticSwitch327_g207086 = localSampleCoord276_g207099;
				#endif
				half4 Local_AlphaTex330_g207086 = staticSwitch327_g207086;
				float4 temp_output_28_0_g251311 = Local_AlphaTex330_g207086;
				float3 temp_output_29_0_g251311 = (temp_output_28_0_g251311).xyz;
				half3 linRGB27_g251311 = temp_output_29_0_g251311;
				half3 localLinearToGammaFloatFast27_g251311 = LinearToGammaFloatFast( linRGB27_g251311 );
				#ifdef UNITY_COLORSPACE_GAMMA
				float3 staticSwitch26_g251311 = temp_output_29_0_g251311;
				#else
				float3 staticSwitch26_g251311 = localLinearToGammaFloatFast27_g251311;
				#endif
				float4 appendResult31_g251311 = (float4(staticSwitch26_g251311 , (temp_output_28_0_g251311).w));
				float4 lerpResult442_g207086 = lerp( Local_AlphaTex330_g207086 , appendResult31_g251311 , _MainAlphaTexIsGamma);
				float4 ChannelA83_g251310 = lerpResult442_g207086;
				float4 ChannelB83_g251310 = ( 1.0 - lerpResult442_g207086 );
				float localSwitchChannel883_g251310 = SwitchChannel8( Option83_g251310 , ChannelA83_g251310 , ChannelB83_g251310 );
				float lerpResult385_g207086 = lerp( (Local_AlbedoTex185_g207086).w , localSwitchChannel883_g251310 , _MainAlphaSourceMode);
				#ifdef TVE_CLIPPING
				float staticSwitch236_g207086 = ( lerpResult385_g207086 - _MainAlphaClipValue );
				#else
				float staticSwitch236_g207086 = lerpResult385_g207086;
				#endif
				half Local_AlphaClip111_g207086 = staticSwitch236_g207086;
				float In_AlphaClip3_g207088 = Local_AlphaClip111_g207086;
				half Local_AlphaFade246_g207086 = (lerpResult62_g207086).a;
				float In_AlphaFade3_g207088 = Local_AlphaFade246_g207086;
				float3 temp_cast_10 = (1.0).xxx;
				float3 In_Translucency3_g207088 = temp_cast_10;
				float In_Transmission3_g207088 = 1.0;
				float In_Thickness3_g207088 = 0.0;
				float In_Diffusion3_g207088 = 0.0;
				float In_Depth3_g207088 = 0.0;
				BuildVisualData( Data3_g207088 , In_Dummy3_g207088 , In_Albedo3_g207088 , In_AlbedoBase3_g207088 , In_NormalTS3_g207088 , In_NormalWS3_g207088 , In_Shader3_g207088 , In_Feature3_g207088 , In_Season3_g207088 , In_Emissive3_g207088 , In_Grayscale3_g207088 , In_Luminosity3_g207088 , In_MultiMask3_g207088 , In_AlphaClip3_g207088 , In_AlphaFade3_g207088 , In_Translucency3_g207088 , In_Transmission3_g207088 , In_Thickness3_g207088 , In_Diffusion3_g207088 , In_Depth3_g207088 );
				TVEVisualData Data4_g251314 =(TVEVisualData)Data3_g207088;
				float Out_Dummy4_g251314 = 0.0;
				float3 Out_Albedo4_g251314 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g251314 = float3( 0,0,0 );
				float2 Out_NormalTS4_g251314 = float2( 0,0 );
				float3 Out_NormalWS4_g251314 = float3( 0,0,0 );
				float4 Out_Shader4_g251314 = float4( 0,0,0,0 );
				float4 Out_Feature4_g251314 = float4( 0,0,0,0 );
				float4 Out_Season4_g251314 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g251314 = float4( 0,0,0,0 );
				float Out_MultiMask4_g251314 = 0.0;
				float Out_Grayscale4_g251314 = 0.0;
				float Out_Luminosity4_g251314 = 0.0;
				float Out_AlphaClip4_g251314 = 0.0;
				float Out_AlphaFade4_g251314 = 0.0;
				float3 Out_Translucency4_g251314 = float3( 0,0,0 );
				float Out_Transmission4_g251314 = 0.0;
				float Out_Thickness4_g251314 = 0.0;
				float Out_Diffusion4_g251314 = 0.0;
				float Out_Depth4_g251314 = 0.0;
				BreakVisualData( Data4_g251314 , Out_Dummy4_g251314 , Out_Albedo4_g251314 , Out_AlbedoBase4_g251314 , Out_NormalTS4_g251314 , Out_NormalWS4_g251314 , Out_Shader4_g251314 , Out_Feature4_g251314 , Out_Season4_g251314 , Out_Emissive4_g251314 , Out_MultiMask4_g251314 , Out_Grayscale4_g251314 , Out_Luminosity4_g251314 , Out_AlphaClip4_g251314 , Out_AlphaFade4_g251314 , Out_Translucency4_g251314 , Out_Transmission4_g251314 , Out_Thickness4_g251314 , Out_Diffusion4_g251314 , Out_Depth4_g251314 );
				half3 Input_Albedo24_g251315 = Out_Albedo4_g251314;
				#ifdef UNITY_COLORSPACE_GAMMA
				float4 staticSwitch22_g251315 = half4( 0.2209163, 0.2209163, 0.2209163, 0.7790837 );
				#else
				float4 staticSwitch22_g251315 = half4( 0.04, 0.04, 0.04, 0.96 );
				#endif
				half4 ColorSpaceDielectricSpec23_g251315 = staticSwitch22_g251315;
				float4 break24_g251313 = Out_Shader4_g251314;
				half Metallic95_g251313 = break24_g251313.x;
				half Input_Metallic25_g251315 = Metallic95_g251313;
				half OneMinusReflectivity31_g251315 = ( (ColorSpaceDielectricSpec23_g251315).w - ( (ColorSpaceDielectricSpec23_g251315).w * Input_Metallic25_g251315 ) );
				float3 temp_output_6_0_g251331 = ( Input_Albedo24_g251315 * OneMinusReflectivity31_g251315 );
				half Render_Common200_g251313 = ( _RenderCull + _RenderZWrite + _RenderQueue + _RenderPriority + _RenderBakeGI + _RenderNormal + _RenderFilter + _RenderClip + _DisableSRPBatcher );
				half Render_Motion186_g251313 = _RenderMotion;
				half Render_URPOnly190_g251313 = ( _RenderShadow + _RenderMotionXR + _RenderGBuffer + Render_Motion186_g251313 );
				half Render_Pipeline184_g251313 = ( Render_Common200_g251313 + Render_URPOnly190_g251313 );
				float temp_output_7_0_g251331 = Render_Pipeline184_g251313;
				float temp_output_17_0_g251331 = ( temp_output_7_0_g251331 + 0.0 );
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g251331 = ( temp_output_6_0_g251331 + temp_output_17_0_g251331 );
				#else
				float3 staticSwitch14_g251331 = temp_output_6_0_g251331;
				#endif
				
				float3 appendResult23_g251313 = (float3(Out_NormalTS4_g251314 , 1.0));
				float3 temp_output_13_0_g251322 = appendResult23_g251313;
				float3 temp_output_33_0_g251322 = ( temp_output_13_0_g251322 * _render_normal );
				float3 switchResult12_g251322 = (((ase_vface>0)?(temp_output_13_0_g251322):(temp_output_33_0_g251322)));
				
				float3 lerpResult28_g251315 = lerp( (ColorSpaceDielectricSpec23_g251315).xyz , Input_Albedo24_g251315 , Input_Metallic25_g251315);
				half3 Specular160_g251313 = lerpResult28_g251315;
				half3 Input_Specular73_g251316 = Specular160_g251313;
				half Render_Spec102_g251313 = _RenderSpecular;
				half Input_RenderSpec58_g251316 = Render_Spec102_g251313;
				half localGBufferPassCheck35_g251317 = ( 0.0 );
				half Input_True57_g251317 = 0.04;
				half True35_g251317 = Input_True57_g251317;
				half Smoothness105_g251313 = break24_g251313.w;
				half Input_Smoothness43_g251316 = Smoothness105_g251313;
				float temp_output_46_0_g251316 = max( ( Input_Smoothness43_g251316 * Input_RenderSpec58_g251316 ), 0.001 );
				half Input_False58_g251317 = temp_output_46_0_g251316;
				half False35_g251317 = Input_False58_g251317;
				half Result35_g251317 = 0;
				{
				#if defined(SHADERPASS) && (SHADERPASS  == SHADERPASS_GBUFFER)
				Result35_g251317 = True35_g251317;
				#else
				Result35_g251317 = False35_g251317;
				#endif
				}
				float3 temp_cast_11 = (Result35_g251317).xxx;
				#ifdef ASE_LIGHTING_SIMPLE
				float3 staticSwitch75_g251316 = temp_cast_11;
				#else
				float3 staticSwitch75_g251316 = ( Input_Specular73_g251316 * Input_RenderSpec58_g251316 );
				#endif
				
				half localGBufferPassCheck35_g251319 = ( 0.0 );
				half Input_True57_g251319 = Input_Smoothness43_g251316;
				half True35_g251319 = Input_True57_g251319;
				half Input_False58_g251319 = temp_output_46_0_g251316;
				half False35_g251319 = Input_False58_g251319;
				half Result35_g251319 = 0;
				{
				#if defined(SHADERPASS) && (SHADERPASS  == SHADERPASS_GBUFFER)
				Result35_g251319 = True35_g251319;
				#else
				Result35_g251319 = False35_g251319;
				#endif
				}
				#ifdef ASE_LIGHTING_SIMPLE
				float staticSwitch79_g251316 = Result35_g251319;
				#else
				float staticSwitch79_g251316 = Input_Smoothness43_g251316;
				#endif
				

				float3 BaseColor = staticSwitch14_g251331;
				float3 Normal = switchResult12_g251322;
				float3 Specular = staticSwitch75_g251316;
				float Metallic = 0;
				float Smoothness = staticSwitch79_g251316;
				float Occlusion = break24_g251313.y;
				float3 Emission = 0;
				float Alpha = 1;
				#if defined( _ALPHATEST_ON )
					float AlphaClipThreshold = _Cutoff;
					float AlphaClipThresholdShadow = 0.5;
				#endif
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;

				#if defined( ASE_DEPTH_WRITE_ON )
					input.positionCS.z = input.positionCS.z;
				#endif

				#ifdef _CLEARCOAT
					float CoatMask = 0;
					float CoatSmoothness = 0;
				#endif

				#if defined( _ALPHATEST_ON )
					AlphaDiscard( Alpha, AlphaClipThreshold );
				#endif

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS) && defined(ASE_CHANGES_WORLD_POS)
					ShadowCoord = TransformWorldToShadowCoord( PositionWS );
				#endif

				InputData inputData = (InputData)0;
				inputData.positionWS = PositionWS;
				inputData.positionCS = input.positionCS;
				inputData.normalizedScreenSpaceUV = ScreenPosNorm.xy;
				inputData.viewDirectionWS = ViewDirWS;
				inputData.shadowCoord = ShadowCoord;

				#ifdef _NORMALMAP
						#if _NORMAL_DROPOFF_TS
							inputData.normalWS = TransformTangentToWorld(Normal, half3x3(TangentWS, BitangentWS, NormalWS));
						#elif _NORMAL_DROPOFF_OS
							inputData.normalWS = TransformObjectToWorldNormal(Normal);
						#elif _NORMAL_DROPOFF_WS
							inputData.normalWS = Normal;
						#endif
					inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				#else
					inputData.normalWS = NormalWS;
				#endif

				#ifdef ASE_FOG
					inputData.fogCoord = InitializeInputDataFog(float4(inputData.positionWS, 1.0), input.fogFactorAndVertexLight.x);
				#endif
				#ifdef _ADDITIONAL_LIGHTS_VERTEX
					inputData.vertexLighting = input.fogFactorAndVertexLight.yzw;
				#endif

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = input.lightmapUVOrVertexSH.xyz;
				#endif

				#if defined(_SCREEN_SPACE_IRRADIANCE)
					inputData.bakedGI = SAMPLE_GI(_ScreenSpaceIrradiance, input.positionCS.xy);
				#elif defined(DYNAMICLIGHTMAP_ON)
					inputData.bakedGI = SAMPLE_GI(input.lightmapUVOrVertexSH.xy, input.dynamicLightmapUV.xy, SH, inputData.normalWS);
					inputData.shadowMask = SAMPLE_SHADOWMASK(input.lightmapUVOrVertexSH.xy);
				#elif !defined(LIGHTMAP_ON) && (defined(PROBE_VOLUMES_L1) || defined(PROBE_VOLUMES_L2))
					inputData.bakedGI = SAMPLE_GI( SH, GetAbsolutePositionWS(inputData.positionWS),
						inputData.normalWS,
						inputData.viewDirectionWS,
						input.positionCS.xy,
						input.probeOcclusion,
						inputData.shadowMask );
				#else
					inputData.bakedGI = SAMPLE_GI(input.lightmapUVOrVertexSH.xy, SH, inputData.normalWS);
					inputData.shadowMask = SAMPLE_SHADOWMASK(input.lightmapUVOrVertexSH.xy);
				#endif

				#ifdef ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#endif

				#if defined(DEBUG_DISPLAY)
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.dynamicLightmapUV = input.dynamicLightmapUV.xy;
					#endif
					#if defined(LIGHTMAP_ON)
						inputData.staticLightmapUV = input.lightmapUVOrVertexSH.xy;
					#else
						inputData.vertexSH = SH;
					#endif
					#if defined(USE_APV_PROBE_OCCLUSION)
						inputData.probeOcclusion = input.probeOcclusion;
					#endif
				#endif

				SurfaceData surfaceData;
				surfaceData.albedo              = BaseColor;
				surfaceData.metallic            = saturate(Metallic);
				surfaceData.specular            = Specular;
				surfaceData.smoothness          = saturate(Smoothness),
				surfaceData.occlusion           = Occlusion,
				surfaceData.emission            = Emission,
				surfaceData.alpha               = saturate(Alpha);
				surfaceData.normalTS            = Normal;
				surfaceData.clearCoatMask       = 0;
				surfaceData.clearCoatSmoothness = 1;

				#ifdef _CLEARCOAT
					surfaceData.clearCoatMask       = saturate(CoatMask);
					surfaceData.clearCoatSmoothness = saturate(CoatSmoothness);
				#endif

				#if defined(_DBUFFER)
					ApplyDecalToSurfaceData(input.positionCS, surfaceData, inputData);
				#endif

				#ifdef ASE_LIGHTING_SIMPLE
					half4 color = UniversalFragmentBlinnPhong( inputData, surfaceData);
				#else
					half4 color = UniversalFragmentPBR( inputData, surfaceData);
				#endif

				#ifdef ASE_TRANSMISSION
				{
					float shadow = _TransmissionShadow;

					#define SUM_LIGHT_TRANSMISSION(Light)\
						float3 atten = Light.color * Light.distanceAttenuation;\
						atten = lerp( atten, atten * Light.shadowAttenuation, shadow );\
						half3 transmission = max( 0, -dot( inputData.normalWS, Light.direction ) ) * atten * Transmission;\
						color.rgb += BaseColor * transmission;

					SUM_LIGHT_TRANSMISSION( GetMainLight( inputData.shadowCoord ) );

					#if defined(_ADDITIONAL_LIGHTS)
						uint meshRenderingLayers = GetMeshRenderingLayer();
						uint pixelLightCount = GetAdditionalLightsCount();
						#if USE_CLUSTER_LIGHT_LOOP
							[loop] for (uint lightIndex = 0; lightIndex < min(URP_FP_DIRECTIONAL_LIGHTS_COUNT, MAX_VISIBLE_LIGHTS); lightIndex++)
							{
								CLUSTER_LIGHT_LOOP_SUBTRACTIVE_LIGHT_CHECK

								Light light = GetAdditionalLight(lightIndex, inputData.positionWS, inputData.shadowMask);
								#ifdef _LIGHT_LAYERS
								if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
								#endif
								{
									SUM_LIGHT_TRANSMISSION( light );
								}
							}
						#endif
						LIGHT_LOOP_BEGIN( pixelLightCount )
							Light light = GetAdditionalLight(lightIndex, inputData.positionWS, inputData.shadowMask);
							#ifdef _LIGHT_LAYERS
							if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
							#endif
							{
								SUM_LIGHT_TRANSMISSION( light );
							}
						LIGHT_LOOP_END
					#endif
				}
				#endif

				#ifdef ASE_TRANSLUCENCY
				{
					float shadow = _TransShadow;
					float normal = _TransNormal;
					float scattering = _TransScattering;
					float direct = _TransDirect;
					float ambient = _TransAmbient;
					float strength = _TransStrength;

					#define SUM_LIGHT_TRANSLUCENCY(Light)\
						float3 atten = Light.color * Light.distanceAttenuation;\
						atten = lerp( atten, atten * Light.shadowAttenuation, shadow );\
						half3 lightDir = Light.direction + inputData.normalWS * normal;\
						half VdotL = pow( saturate( dot( inputData.viewDirectionWS, -lightDir ) ), scattering );\
						half3 translucency = atten * ( VdotL * direct + inputData.bakedGI * ambient ) * Translucency;\
						color.rgb += BaseColor * translucency * strength;

					SUM_LIGHT_TRANSLUCENCY( GetMainLight( inputData.shadowCoord ) );

					#if defined(_ADDITIONAL_LIGHTS)
						uint meshRenderingLayers = GetMeshRenderingLayer();
						uint pixelLightCount = GetAdditionalLightsCount();
						#if USE_CLUSTER_LIGHT_LOOP
							[loop] for (uint lightIndex = 0; lightIndex < min(URP_FP_DIRECTIONAL_LIGHTS_COUNT, MAX_VISIBLE_LIGHTS); lightIndex++)
							{
								CLUSTER_LIGHT_LOOP_SUBTRACTIVE_LIGHT_CHECK

								Light light = GetAdditionalLight(lightIndex, inputData.positionWS, inputData.shadowMask);
								#ifdef _LIGHT_LAYERS
								if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
								#endif
								{
									SUM_LIGHT_TRANSLUCENCY( light );
								}
							}
						#endif
						LIGHT_LOOP_BEGIN( pixelLightCount )
							Light light = GetAdditionalLight(lightIndex, inputData.positionWS, inputData.shadowMask);
							#ifdef _LIGHT_LAYERS
							if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
							#endif
							{
								SUM_LIGHT_TRANSLUCENCY( light );
							}
						LIGHT_LOOP_END
					#endif
				}
				#endif

				#ifdef ASE_REFRACTION
					float4 projScreenPos = ScreenPos / ScreenPos.w;
					float3 refractionOffset = ( RefractionIndex - 1.0 ) * mul( UNITY_MATRIX_V, float4( NormalWS,0 ) ).xyz * ( 1.0 - dot( NormalWS, ViewDirWS ) );
					projScreenPos.xy += refractionOffset.xy;
					float3 refraction = SHADERGRAPH_SAMPLE_SCENE_COLOR( projScreenPos.xy ) * RefractionColor;
					color.rgb = lerp( refraction, color.rgb, color.a );
					color.a = 1;
				#endif

				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif

				#ifdef ASE_FOG
					#ifdef TERRAIN_SPLAT_ADDPASS
						color.rgb = MixFogColor(color.rgb, half3(0,0,0), inputData.fogCoord);
					#else
						color.rgb = MixFog(color.rgb, inputData.fogCoord);
					#endif
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = input.positionCS.z;
				#endif

				#ifdef _WRITE_RENDERING_LAYERS
					outRenderingLayers = EncodeMeshRenderingLayer();
				#endif

				#if defined( ASE_OPAQUE_KEEP_ALPHA )
					return half4( color.rgb, color.a );
				#else
					return half4( color.rgb, OutputAlpha( color.a, isTransparent ) );
				#endif
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			ZWrite On
			ZTest LEqual
			AlphaToMask Off
			ColorMask 0

			HLSLPROGRAM

			#define ASE_GEOMETRY
			#define ASE_OPAQUE_KEEP_ALPHA
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#define _NORMALMAP 1
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION 170300
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW

			#pragma vertex vert
			#pragma fragment frag

			#if defined( _SPECULAR_SETUP ) && defined( ASE_LIGHTING_SIMPLE )
				#if defined( _SPECULARHIGHLIGHTS_OFF )
					#undef _SPECULAR_COLOR
				#else
					#define _SPECULAR_COLOR
				#endif
			#endif

			#define SHADERPASS SHADERPASS_SHADOWCASTER

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#if defined (TVE_CLIPPING) //Render Clip
				#define TVE_ALPHA_CLIP //Render Clip
			#endif //Render Clip
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END
			  
			struct TVEVisualData
			{  
				half Dummy;  
				half3 Albedo;
				half3 AlbedoBase;
				half2 NormalTS;
				half3 NormalWS; 
				half4 Shader;
				half4 Feature;
				half4 Season;
				float4 Emissive;
				half AlphaClip;
				half AlphaFade;
				half MultiMask;
				half Grayscale;
				half Luminosity;
				float3 Translucency;
				half Transmission;
				half Thickness;
				float Diffusion;
				float Depth;
			};  
			    
			struct TVEModelData
			{    
				half Dummy;    
				float3 PositionOS;
				float3 PositionWS;
				float3 PositionWO;
				float3 PositionRawOS;
				float3 PivotOS;
				float3 PivotWS;
				float3 PivotWO;
				half3 NormalOS;
				half3 NormalWS;
				half3 NormalRawOS;
				half4 TangentOS;
				half3 TangentWS;
				half3 BitangentWS;
				half3 TriplanarWeights;
				half3 ViewDirWS;
				float4 CoordsData;
				half4 VertexData;
				half4 MasksData;   
				half4 PhaseData;
				half4 TransformData;
				half4 RotationData;
				float4 InterpolatorA;
			};    
			      
			struct TVEGlobalData
			{      
				half Dummy;      
				half4 CoatParams;
				half4 CoatTexture;
				half4 PaintParams;
				half4 PaintTexture;
				half4 AtmoParams;
				half4 AtmoTexture;
				half4 GlowParams;
				half4 GlowTexture;
				float4 FormParams;
				float4 FormTexture;
				half4 FlowParams;
				half4 FlowTexture;
			};      
			        
			struct TVEMasksData
			{        
				half4 MaskA;
				half4 MaskB;
				half4 MaskC;
				half4 MaskD;
				half4 MaskE;
				half4 MaskF;
				half4 MaskG;
				half4 MaskH;
				half4 MaskI;
				half4 MaskJ;
				half4 MaskK;
				half4 MaskL;
				half4 MaskM;
				half4 MaskN;
			};        
			#define TVE_GEOMETRY_SHADER


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			half4 _MainOcclusionRemap;
			half4 _MainColor;
			half4 _MainColorTwo;
			half4 _MainMultiRemap;
			half4 _main_coord_value;
			half4 _MainSmoothnessRemap;
			half4 _MainCoordValue;
			half3 _render_normal;
			half _MainMultiVlaue;
			half _MainMultiSourceMode;
			half _MainMultiChannelMode;
			half _MainSmoothnessSourceMode;
			half _MainColorMode;
			float _MainSmoothnessTexGammaMode;
			half _MainSmoothnessChannelMode;
			half _MainOcclusionValue;
			half _MainSmoothnessValue;
			half _render_src;
			half _MainNormalValue;
			float _MainAlphaTexIsGamma;
			half _RenderMotion;
			half _RenderGBuffer;
			half _RenderMotionXR;
			half _RenderShadow;
			half _RenderClip;
			half _RenderFilter;
			half _MainAlphaChannelMode;
			half _RenderNormal;
			half _RenderPriority;
			half _RenderQueue;
			half _RenderZWrite;
			half _RenderCull;
			half _MainAlphaClipValue;
			half _MainAlphaSourceMode;
			half _RenderBakeGI;
			half _MainOcclusionSourceMode;
			half _MainMetallicSourceMode;
			half _MainMetallicValue;
			half _render_cull;
			half _render_dst;
			half _render_zw;
			half _render_coverage;
			half _IsGeneralShader;
			half _RenderEnd;
			half _IsVersion;
			half _IsTVEShader;
			half _IsLightingType;
			half _IsCustomShader;
			half _IsCollected;
			half _IsConverted;
			half _IsIdentifier;
			half _MainOcclusionChannelMode;
			half _IsShared;
			half _IsShaderType;
			half _IsObjectType;
			half _RenderCategory;
			half _IsStandardShader;
			half _MainCategory;
			half _MainEnd;
			half _MainSampleMode;
			half _MainCoordMode;
			half _MainMultiMaskInfo;
			half _MainSmoothnessInfo;
			half _ObjectPhaseMode;
			half _MainAlbedoValue;
			half _MainMetallicChannelMode;
			half _UseExternalSettings;
			half _RenderSpecular;
			float _AlphaClip;
			float _Cutoff;
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
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			

			float3 _LightDirection;
			float3 _LightPosition;

			
			PackedVaryings VertexFunction( Attributes input )
			{
				PackedVaryings output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( output );

				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				float3 positionWS = TransformObjectToWorld( input.positionOS.xyz );
				float3 normalWS = TransformObjectToWorldDir(input.normalOS);

				#if _CASTING_PUNCTUAL_LIGHT_SHADOW
					float3 lightDirectionWS = normalize(_LightPosition - positionWS);
				#else
					float3 lightDirectionWS = _LightDirection;
				#endif

				float4 positionCS = TransformWorldToHClip(ApplyShadowBias(positionWS, normalWS, lightDirectionWS));

				//code for UNITY_REVERSED_Z is moved into Shadows.hlsl from 6000.0.22 and or higher
				positionCS = ApplyShadowClamping(positionCS);

				output.positionCS = positionCS;
				output.positionWS = positionWS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
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
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag(	PackedVaryings input
						#if defined( ASE_DEPTH_WRITE_ON )
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( input );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( input );

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord = TransformWorldToShadowCoord(input.positionWS);
				#else
					float4 shadowCoord = float4(0, 0, 0, 0);
				#endif

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( input.positionWS );
				float4 ShadowCoord = shadowCoord;
				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos );

				

				float Alpha = 1;
				#if defined( _ALPHATEST_ON )
					float AlphaClipThreshold = _Cutoff;
					float AlphaClipThresholdShadow = 0.5;
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					input.positionCS.z = input.positionCS.z;
				#endif

				#if defined( _ALPHATEST_ON )
					#if defined( _ALPHATEST_SHADOW_ON )
						AlphaDiscard( Alpha, AlphaClipThresholdShadow );
					#else
						AlphaDiscard( Alpha, AlphaClipThreshold );
					#endif
				#endif

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = input.positionCS.z;
				#endif

				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0
			AlphaToMask Off

			HLSLPROGRAM

			#define ASE_GEOMETRY
			#define ASE_OPAQUE_KEEP_ALPHA
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#define _NORMALMAP 1
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION 170300
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#if defined( _SPECULAR_SETUP ) && defined( ASE_LIGHTING_SIMPLE )
				#if defined( _SPECULARHIGHLIGHTS_OFF )
					#undef _SPECULAR_COLOR
				#else
					#define _SPECULAR_COLOR
				#endif
			#endif

			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#if defined (TVE_CLIPPING) //Render Clip
				#define TVE_ALPHA_CLIP //Render Clip
			#endif //Render Clip
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END
			  
			struct TVEVisualData
			{  
				half Dummy;  
				half3 Albedo;
				half3 AlbedoBase;
				half2 NormalTS;
				half3 NormalWS; 
				half4 Shader;
				half4 Feature;
				half4 Season;
				float4 Emissive;
				half AlphaClip;
				half AlphaFade;
				half MultiMask;
				half Grayscale;
				half Luminosity;
				float3 Translucency;
				half Transmission;
				half Thickness;
				float Diffusion;
				float Depth;
			};  
			    
			struct TVEModelData
			{    
				half Dummy;    
				float3 PositionOS;
				float3 PositionWS;
				float3 PositionWO;
				float3 PositionRawOS;
				float3 PivotOS;
				float3 PivotWS;
				float3 PivotWO;
				half3 NormalOS;
				half3 NormalWS;
				half3 NormalRawOS;
				half4 TangentOS;
				half3 TangentWS;
				half3 BitangentWS;
				half3 TriplanarWeights;
				half3 ViewDirWS;
				float4 CoordsData;
				half4 VertexData;
				half4 MasksData;   
				half4 PhaseData;
				half4 TransformData;
				half4 RotationData;
				float4 InterpolatorA;
			};    
			      
			struct TVEGlobalData
			{      
				half Dummy;      
				half4 CoatParams;
				half4 CoatTexture;
				half4 PaintParams;
				half4 PaintTexture;
				half4 AtmoParams;
				half4 AtmoTexture;
				half4 GlowParams;
				half4 GlowTexture;
				float4 FormParams;
				float4 FormTexture;
				half4 FlowParams;
				half4 FlowTexture;
			};      
			        
			struct TVEMasksData
			{        
				half4 MaskA;
				half4 MaskB;
				half4 MaskC;
				half4 MaskD;
				half4 MaskE;
				half4 MaskF;
				half4 MaskG;
				half4 MaskH;
				half4 MaskI;
				half4 MaskJ;
				half4 MaskK;
				half4 MaskL;
				half4 MaskM;
				half4 MaskN;
			};        
			#define TVE_GEOMETRY_SHADER


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			half4 _MainOcclusionRemap;
			half4 _MainColor;
			half4 _MainColorTwo;
			half4 _MainMultiRemap;
			half4 _main_coord_value;
			half4 _MainSmoothnessRemap;
			half4 _MainCoordValue;
			half3 _render_normal;
			half _MainMultiVlaue;
			half _MainMultiSourceMode;
			half _MainMultiChannelMode;
			half _MainSmoothnessSourceMode;
			half _MainColorMode;
			float _MainSmoothnessTexGammaMode;
			half _MainSmoothnessChannelMode;
			half _MainOcclusionValue;
			half _MainSmoothnessValue;
			half _render_src;
			half _MainNormalValue;
			float _MainAlphaTexIsGamma;
			half _RenderMotion;
			half _RenderGBuffer;
			half _RenderMotionXR;
			half _RenderShadow;
			half _RenderClip;
			half _RenderFilter;
			half _MainAlphaChannelMode;
			half _RenderNormal;
			half _RenderPriority;
			half _RenderQueue;
			half _RenderZWrite;
			half _RenderCull;
			half _MainAlphaClipValue;
			half _MainAlphaSourceMode;
			half _RenderBakeGI;
			half _MainOcclusionSourceMode;
			half _MainMetallicSourceMode;
			half _MainMetallicValue;
			half _render_cull;
			half _render_dst;
			half _render_zw;
			half _render_coverage;
			half _IsGeneralShader;
			half _RenderEnd;
			half _IsVersion;
			half _IsTVEShader;
			half _IsLightingType;
			half _IsCustomShader;
			half _IsCollected;
			half _IsConverted;
			half _IsIdentifier;
			half _MainOcclusionChannelMode;
			half _IsShared;
			half _IsShaderType;
			half _IsObjectType;
			half _RenderCategory;
			half _IsStandardShader;
			half _MainCategory;
			half _MainEnd;
			half _MainSampleMode;
			half _MainCoordMode;
			half _MainMultiMaskInfo;
			half _MainSmoothnessInfo;
			half _ObjectPhaseMode;
			half _MainAlbedoValue;
			half _MainMetallicChannelMode;
			half _UseExternalSettings;
			half _RenderSpecular;
			float _AlphaClip;
			float _Cutoff;
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
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			

			
			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );

				output.positionCS = vertexInput.positionCS;
				output.positionWS = vertexInput.positionWS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
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
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag(	PackedVaryings input
						#if defined( ASE_DEPTH_WRITE_ON )
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( input );

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord = TransformWorldToShadowCoord(input.positionWS);
				#else
					float4 shadowCoord = float4(0, 0, 0, 0);
				#endif

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( input.positionWS );
				float4 ShadowCoord = shadowCoord;
				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos );

				

				float Alpha = 1;
				float AlphaClipThreshold = _Cutoff;

				#if defined( ASE_DEPTH_WRITE_ON )
					input.positionCS.z = input.positionCS.z;
				#endif

				#if defined( _ALPHATEST_ON )
					AlphaDiscard( Alpha, AlphaClipThreshold );
				#endif

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = input.positionCS.z;
				#endif

				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Meta"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM
			#define ASE_GEOMETRY
			#define ASE_OPAQUE_KEEP_ALPHA
			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#define _NORMALMAP 1
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION 170300
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma shader_feature EDITOR_VISUALIZATION

			#pragma vertex vert
			#pragma fragment frag

			#if defined( _SPECULAR_SETUP ) && defined( ASE_LIGHTING_SIMPLE )
				#if defined( _SPECULARHIGHLIGHTS_OFF )
					#undef _SPECULAR_COLOR
				#else
					#define _SPECULAR_COLOR
				#endif
			#endif

			#define SHADERPASS SHADERPASS_META

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
			#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
			#pragma shader_feature_local_fragment TVE_CLIPPING
			#if defined (TVE_CLIPPING) //Render Clip
				#define TVE_ALPHA_CLIP //Render Clip
			#endif //Render Clip
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END
			  
			struct TVEVisualData
			{  
				half Dummy;  
				half3 Albedo;
				half3 AlbedoBase;
				half2 NormalTS;
				half3 NormalWS; 
				half4 Shader;
				half4 Feature;
				half4 Season;
				float4 Emissive;
				half AlphaClip;
				half AlphaFade;
				half MultiMask;
				half Grayscale;
				half Luminosity;
				float3 Translucency;
				half Transmission;
				half Thickness;
				float Diffusion;
				float Depth;
			};  
			    
			struct TVEModelData
			{    
				half Dummy;    
				float3 PositionOS;
				float3 PositionWS;
				float3 PositionWO;
				float3 PositionRawOS;
				float3 PivotOS;
				float3 PivotWS;
				float3 PivotWO;
				half3 NormalOS;
				half3 NormalWS;
				half3 NormalRawOS;
				half4 TangentOS;
				half3 TangentWS;
				half3 BitangentWS;
				half3 TriplanarWeights;
				half3 ViewDirWS;
				float4 CoordsData;
				half4 VertexData;
				half4 MasksData;   
				half4 PhaseData;
				half4 TransformData;
				half4 RotationData;
				float4 InterpolatorA;
			};    
			      
			struct TVEGlobalData
			{      
				half Dummy;      
				half4 CoatParams;
				half4 CoatTexture;
				half4 PaintParams;
				half4 PaintTexture;
				half4 AtmoParams;
				half4 AtmoTexture;
				half4 GlowParams;
				half4 GlowTexture;
				float4 FormParams;
				float4 FormTexture;
				half4 FlowParams;
				half4 FlowTexture;
			};      
			        
			struct TVEMasksData
			{        
				half4 MaskA;
				half4 MaskB;
				half4 MaskC;
				half4 MaskD;
				half4 MaskE;
				half4 MaskF;
				half4 MaskG;
				half4 MaskH;
				half4 MaskI;
				half4 MaskJ;
				half4 MaskK;
				half4 MaskL;
				half4 MaskM;
				half4 MaskN;
			};        
			#define TVE_GEOMETRY_SHADER


			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				#ifdef EDITOR_VISUALIZATION
					float4 VizUV : TEXCOORD1;
					float4 LightCoord : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			half4 _MainOcclusionRemap;
			half4 _MainColor;
			half4 _MainColorTwo;
			half4 _MainMultiRemap;
			half4 _main_coord_value;
			half4 _MainSmoothnessRemap;
			half4 _MainCoordValue;
			half3 _render_normal;
			half _MainMultiVlaue;
			half _MainMultiSourceMode;
			half _MainMultiChannelMode;
			half _MainSmoothnessSourceMode;
			half _MainColorMode;
			float _MainSmoothnessTexGammaMode;
			half _MainSmoothnessChannelMode;
			half _MainOcclusionValue;
			half _MainSmoothnessValue;
			half _render_src;
			half _MainNormalValue;
			float _MainAlphaTexIsGamma;
			half _RenderMotion;
			half _RenderGBuffer;
			half _RenderMotionXR;
			half _RenderShadow;
			half _RenderClip;
			half _RenderFilter;
			half _MainAlphaChannelMode;
			half _RenderNormal;
			half _RenderPriority;
			half _RenderQueue;
			half _RenderZWrite;
			half _RenderCull;
			half _MainAlphaClipValue;
			half _MainAlphaSourceMode;
			half _RenderBakeGI;
			half _MainOcclusionSourceMode;
			half _MainMetallicSourceMode;
			half _MainMetallicValue;
			half _render_cull;
			half _render_dst;
			half _render_zw;
			half _render_coverage;
			half _IsGeneralShader;
			half _RenderEnd;
			half _IsVersion;
			half _IsTVEShader;
			half _IsLightingType;
			half _IsCustomShader;
			half _IsCollected;
			half _IsConverted;
			half _IsIdentifier;
			half _MainOcclusionChannelMode;
			half _IsShared;
			half _IsShaderType;
			half _IsObjectType;
			half _RenderCategory;
			half _IsStandardShader;
			half _MainCategory;
			half _MainEnd;
			half _MainSampleMode;
			half _MainCoordMode;
			half _MainMultiMaskInfo;
			half _MainSmoothnessInfo;
			half _ObjectPhaseMode;
			half _MainAlbedoValue;
			half _MainMetallicChannelMode;
			half _UseExternalSettings;
			half _RenderSpecular;
			float _AlphaClip;
			float _Cutoff;
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
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_Linear_Repeat_Aniso8);
			SAMPLER(sampler_Point_Repeat);
			SAMPLER(sampler_Linear_Repeat);
			float3 TVE_WorldOrigin;
			TEXTURE2D(_MainShaderTex);
			TEXTURE2D(_MainMetallicTex);
			TEXTURE2D(_MainOcclusionTex);
			TEXTURE2D(_MainSmoothnessTex);
			TEXTURE2D(_MainMultiTex);
			TEXTURE2D(_MainNormalTex);
			TEXTURE2D(_MainAlphaTex);
			half _DisableSRPBatcher;


			half3 ComputeTriplanarWeights( half3 NormalWS )
			{
				half3 powNormal = abs( NormalWS );
				half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
				tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
				return tempWeights;
			}
			
			float SwitchChannel4( half Option, half4 Channel )
			{
				switch (Option) {
					default:
				                case 0:
						return Channel.x;
					case 1:
						return Channel.y;
					case 2:
						return Channel.z;
					case 3:
						return Channel.w;
				}
			}
			
			void BuildModelFragData( out TVEModelData Data, half In_Dummy, float3 In_PositionWS, float3 In_PositionWO, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalWS, half3 In_TangentWS, half3 In_BitangentWS, half3 In_TriplanarWeights, half3 In_ViewDirWS, half4 In_CoordsData, half4 In_VertexData, half4 In_PhaseData )
			{
				Data = (TVEModelData)0;
				Data.Dummy = In_Dummy;
				Data.PositionWS = In_PositionWS;
				Data.PositionWO = In_PositionWO;
				Data.PivotWS = In_PivotWS;
				Data.PivotWO = In_PivotWO;
				Data.NormalWS = In_NormalWS;
				Data.TangentWS = In_TangentWS;
				Data.BitangentWS = In_BitangentWS;
				Data.TriplanarWeights = In_TriplanarWeights;
				Data.ViewDirWS = In_ViewDirWS;
				Data.CoordsData = In_CoordsData;
				Data.VertexData = In_VertexData;
				Data.PhaseData = In_PhaseData;
				return;
			}
			
			void BreakModelFragData( inout TVEModelData Data, out half Out_Dummy, out float3 Out_PositionWS, out float3 Out_PositionWO, out float3 Out_PivotWS, out float3 Out_PivotWO, out half3 Out_NormalWS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_TriplanarWeights, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_PhaseData )
			{
				Out_Dummy = Data.Dummy;
				Out_PositionWS = Data.PositionWS;
				Out_PositionWO = Data.PositionWO;
				Out_PivotWS = Data.PivotWS;
				Out_PivotWO = Data.PivotWO;
				Out_NormalWS = Data.NormalWS;
				Out_TangentWS = Data.TangentWS;
				Out_BitangentWS = Data.BitangentWS;
				Out_TriplanarWeights = Data.TriplanarWeights;
				Out_ViewDirWS = Data.ViewDirWS;
				Out_CoordsData = Data.CoordsData;
				Out_VertexData = Data.VertexData;
				Out_PhaseData = Data.PhaseData;
				return;
			}
			
			void ComputeMeshCoords( float4 Coords, float4 MeshCoords, out float2 UV0, out float2 UV3 )
			{
				UV0 = MeshCoords.xy * Coords.xy - Coords.zw; 
				UV3 = MeshCoords.zw * Coords.xy - Coords.zw; 
				return;
			}
			
			void ComputeWorldCoords( float4 Coords, float3 PositionWS, out float2 ZY, out float2 XZ, out float2 XY )
			{
				ZY = PositionWS.zy * Coords.xy - Coords.zw; 
				XZ = PositionWS.xz * Coords.xx - Coords.zz;
				XY = PositionWS.xy * Coords.xy - Coords.zw;
				return;
			}
			
			float2 ComputeStochasticHash22( float2 p )
			{
				float3 p3 = frac(float3(p.xyx) * float3(.1031, .1030, .0973));
				p3 += dot(p3, p3.yzx+33.33);
				return frac((p3.xx+p3.yz)*p3.zy);
			}
			
			void ComputeStochasticCoords( inout float2 UV, out float2 UV1, out float2 UV2, out float2 UV3, out float3 Weights )
			{
				half2 vertex1, vertex2, vertex3;
				// Scaling of the input
				half2 uv = UV * 3.464; // 2 * sqrt (3)
				// Skew input space into simplex triangle grid
				const float2x2 gridToSkewedGrid = float2x2( 1.0, 0.0, -0.57735027, 1.15470054 );
				half2 skewedCoord = mul( gridToSkewedGrid, uv );
				// Compute local triangle vertex IDs and local barycentric coordinates
				int2 baseId = int2( floor( skewedCoord ) );
				half3 temp = half3( frac( skewedCoord ), 0 );
				temp.z = 1.0 - temp.x - temp.y;
				if ( temp.z > 0.0 )
				{
					Weights.x = temp.z;
					Weights.y = temp.y;
					Weights.z = temp.x;
					vertex1 = baseId;
					vertex2 = baseId + int2( 0, 1 );
					vertex3 = baseId + int2( 1, 0 );
				}
				else
				{
					Weights.x = -temp.z;
					Weights.y = 1.0 - temp.y;
					Weights.z = 1.0 - temp.x;
					vertex1 = baseId + int2( 1, 1 );
					vertex2 = baseId + int2( 1, 0 );
					vertex3 = baseId + int2( 0, 1 );
				}
				UV1 = UV + ComputeStochasticHash22(vertex1);
				UV2 = UV + ComputeStochasticHash22(vertex2);
				UV3 = UV + ComputeStochasticHash22(vertex3);
				return;
			}
			
			void BuildTextureData( out TVEMasksData Data, float4 In_MaskA, float4 In_MaskB, float4 In_MaskC, float4 In_MaskD, float4 In_MaskE, float4 In_MaskF, float4 In_MaskG, half4 In_MaskH, half4 In_MaskI, half4 In_MaskJ, half4 In_MaskK, half4 In_MaskL, half4 In_MaskM, half4 In_MaskN )
			{
				Data.MaskA = In_MaskA;
				Data.MaskB = In_MaskB;
				Data.MaskC = In_MaskC;
				Data.MaskD = In_MaskD;
				Data.MaskE = In_MaskE;
				Data.MaskF = In_MaskF;
				Data.MaskG = In_MaskG;
				Data.MaskH = In_MaskH;
				Data.MaskI = In_MaskI;
				Data.MaskJ = In_MaskJ;
				Data.MaskK = In_MaskK;
				Data.MaskL = In_MaskL;
				Data.MaskM = In_MaskM;
				Data.MaskN = In_MaskN;
				return;
			}
			
			void BreakTextureData( TVEMasksData Data, out float4 Out_MaskA, out float4 Out_MaskB, out float4 Out_MaskC, out float4 Out_MaskD, out float4 Out_MaskE, out float4 Out_MaskF, out half4 Out_MaskG, out half4 Out_MaskH, out half4 Out_MaskI, out half4 Out_MaskJ, out half4 Out_MaskK, out half4 Out_MaskL, out half4 Out_MaskM, out half4 Out_MaskN )
			{
				Out_MaskA = Data.MaskA;
				Out_MaskB = Data.MaskB;
				Out_MaskC = Data.MaskC;
				Out_MaskD = Data.MaskD;
				Out_MaskE = Data.MaskE;
				Out_MaskF = Data.MaskF;
				Out_MaskG = Data.MaskG;
				Out_MaskH = Data.MaskH;
				Out_MaskI = Data.MaskI;
				Out_MaskJ = Data.MaskJ;
				Out_MaskK = Data.MaskK;
				Out_MaskL = Data.MaskL;
				Out_MaskM = Data.MaskM;
				Out_MaskN = Data.MaskN;
				return;
			}
			
			half4 SampleCoord( TEXTURE2D(Texture), SamplerState Sampler, half2 UV, half Bias, out half2 Normal )
			{
				half4 tex = SAMPLE_TEXTURE2D_BIAS( Texture, Sampler, UV, Bias);
				Normal = tex.wy * 2.0 - 1.0;
				return tex;
			}
			
			half4 SamplePlanar2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, half Bias, half3 NormalWS, out half3 Normal )
			{
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SamplePlanar3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 XZ, float2 XY, half Bias, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				half4 tex_X = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, ZY, Bias);
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half4 tex_Z = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XY, Bias);
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal =  normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			half4 SampleStochastic2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, half Bias, half3 Weights_2, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SampleStochastic3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 ZY_1, float2 ZY_2, float2 ZY_3, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, float2 XY, float2 XY_1, float2 XY_2, float2 XY_3, half Bias, half3 Weights_1, half3 Weights_2, half3 Weights_3, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_X = ddx(ZY) * Bias;
				float2 ddy_X= ddy(ZY) * Bias;
				half4 tex1_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_1, ddx_X, ddy_X);
				half4 tex2_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_2, ddx_X, ddy_X);
				half4 tex3_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_3, ddx_X, ddy_X);
				half4 tex_X = tex1_X * Weights_1.x + tex2_X * Weights_1.y + tex3_X * Weights_1.z;
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				float2 ddx_Z = ddx(XY) * Bias;
				float2 ddy_Z= ddy(XY) * Bias;
				half4 tex1_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_1, ddx_Z, ddy_Z);
				half4 tex2_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_2, ddx_Z, ddy_Z);
				half4 tex3_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_3, ddx_Z, ddy_Z);
				half4 tex_Z = tex1_Z * Weights_3.x + tex2_Z * Weights_3.y + tex3_Z * Weights_3.z;
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal = normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			float SwitchChannel8( half Option, half4 ChannelA, half4 ChannelB )
			{
				switch (Option) {
					default:
				                case 0:
						return ChannelA.x;
					case 1:
						return ChannelA.y;
					case 2:
						return ChannelA.z;
					case 3:
						return ChannelA.w;
				                case 4:
						return ChannelB.x;
					case 5:
						return ChannelB.y;
					case 6:
						return ChannelB.z;
					case 7:
						return ChannelB.w;
				}
			}
			
			half3 LinearToGammaFloatFast( half3 linRGB )
			{
				return max(1.055h * pow(abs(linRGB), 0.416666667h) - 0.055h, 0.h);
			}
			
			void BuildVisualData( inout TVEVisualData Data, float In_Dummy, half3 In_Albedo, half3 In_AlbedoBase, half2 In_NormalTS, half3 In_NormalWS, half4 In_Shader, half4 In_Feature, half4 In_Season, half4 In_Emissive, half In_Grayscale, half In_Luminosity, half In_MultiMask, half In_AlphaClip, half In_AlphaFade, half3 In_Translucency, half In_Transmission, half In_Thickness, float In_Diffusion, float In_Depth )
			{
				//Data = (TVEVisualData)0;
				Data.Dummy = In_Dummy;
				Data.Albedo = In_Albedo;
				Data.AlbedoBase = In_AlbedoBase;
				Data.NormalTS = In_NormalTS;
				Data.NormalWS = In_NormalWS;
				Data.Shader = In_Shader;
				Data.Feature = In_Feature;
				Data.Season= In_Season;
				Data.Emissive= In_Emissive;
				Data.MultiMask = In_MultiMask;
				Data.Grayscale = In_Grayscale;
				Data.Luminosity = In_Luminosity;
				Data.AlphaClip = In_AlphaClip;
				Data.AlphaFade = In_AlphaFade;
				Data.Translucency = In_Translucency;
				Data.Transmission = In_Transmission;
				Data.Thickness = In_Thickness;
				Data.Diffusion = In_Diffusion;
				Data.Depth = In_Depth;
				return;
			}
			
			void BreakVisualData( inout TVEVisualData Data, out half Out_Dummy, out half3 Out_Albedo, out half3 Out_AlbedoBase, out half2 Out_NormalTS, out half3 Out_NormalWS, out half4 Out_Shader, out half4 Out_Feature, out half4 Out_Season, out half4 Out_Emissive, out half Out_MultiMask, out half Out_Grayscale, out half Out_Luminosity, out half Out_AlphaClip, out half Out_AlphaFade, out half3 Out_Translucency, out half Out_Transmission, out half Out_Thickness, out half Out_Diffusion, out float Out_Depth )
			{
				Out_Dummy = Data.Dummy;
				Out_Albedo = Data.Albedo;
				Out_AlbedoBase = Data.AlbedoBase;
				Out_NormalTS = Data.NormalTS;
				Out_NormalWS = Data.NormalWS;
				Out_Shader = Data.Shader;
				Out_Feature = Data.Feature;
				Out_Season = Data.Season;
				Out_Emissive= Data.Emissive;
				Out_MultiMask = Data.MultiMask;
				Out_Grayscale = Data.Grayscale;
				Out_Luminosity= Data.Luminosity;
				Out_AlphaClip = Data.AlphaClip;
				Out_AlphaFade = Data.AlphaFade;
				Out_Translucency = Data.Translucency;
				Out_Transmission = Data.Transmission;
				Out_Thickness = Data.Thickness;
				Out_Diffusion = Data.Diffusion;
				Out_Depth= Data.Depth;
				return;
			}
			

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float3 ase_positionWS = TransformObjectToWorld( ( input.positionOS ).xyz );
				float3 temp_output_104_7_g205214 = ase_positionWS;
				float3 vertexToFrag73_g205214 = temp_output_104_7_g205214;
				output.ase_texcoord3.xyz = vertexToFrag73_g205214;
				float4x4 break19_g205217 = GetObjectToWorldMatrix();
				float3 appendResult20_g205217 = (float3(break19_g205217[ 0 ][ 3 ] , break19_g205217[ 1 ][ 3 ] , break19_g205217[ 2 ][ 3 ]));
				float3 temp_output_340_7_g205214 = appendResult20_g205217;
				float4x4 break19_g205219 = GetObjectToWorldMatrix();
				float3 appendResult20_g205219 = (float3(break19_g205219[ 0 ][ 3 ] , break19_g205219[ 1 ][ 3 ] , break19_g205219[ 2 ][ 3 ]));
				float3 _Vector0 = float3(0,0,0);
				float3 appendResult60_g205215 = (float3(input.ase_texcoord3.x , input.ase_texcoord3.z , input.ase_texcoord3.y));
				float3 PositionOS131_g205214 = input.positionOS.xyz;
				float3 break233_g205214 = PositionOS131_g205214;
				float3 appendResult234_g205214 = (float3(break233_g205214.x , 0.0 , break233_g205214.z));
				float3 break413_g205214 = PositionOS131_g205214;
				float3 appendResult414_g205214 = (float3(break413_g205214.x , break413_g205214.y , 0.0));
				#ifdef TVE_COORD_ZUP
				float3 staticSwitch65_g205221 = appendResult414_g205214;
				#else
				float3 staticSwitch65_g205221 = appendResult234_g205214;
				#endif
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch229_g205214 = _Vector0;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch229_g205214 = appendResult60_g205215;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch229_g205214 = staticSwitch65_g205221;
				#else
				float3 staticSwitch229_g205214 = _Vector0;
				#endif
				float3 PivotOS149_g205214 = staticSwitch229_g205214;
				float3 temp_output_122_0_g205219 = PivotOS149_g205214;
				float3 PivotsOnlyWS105_g205219 = mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g205219 , 0.0 ) ).xyz;
				float3 temp_output_341_7_g205214 = ( appendResult20_g205219 + PivotsOnlyWS105_g205219 );
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#else
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#endif
				float3 vertexToFrag76_g205214 = staticSwitch236_g205214;
				output.ase_texcoord4.xyz = vertexToFrag76_g205214;
				float3 ase_normalWS = TransformObjectToWorldNormal( input.normalOS );
				output.ase_texcoord5.xyz = ase_normalWS;
				float3 ase_tangentWS = TransformObjectToWorldDir( input.tangentOS.xyz );
				output.ase_texcoord6.xyz = ase_tangentWS;
				float ase_tangentSign = input.tangentOS.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
				output.ase_texcoord7.xyz = ase_bitangentWS;
				
				output.ase_texcoord8.xy = input.texcoord.xy;
				output.ase_texcoord8.zw = input.texcoord2.xy;
				output.ase_color = input.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord3.w = 0;
				output.ase_texcoord4.w = 0;
				output.ase_texcoord5.w = 0;
				output.ase_texcoord6.w = 0;
				output.ase_texcoord7.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				#ifdef EDITOR_VISUALIZATION
					float2 VizUV = 0;
					float4 LightCoord = 0;
					UnityEditorVizData(input.positionOS.xyz, input.texcoord.xy, input.texcoord1.xy, input.texcoord2.xy, VizUV, LightCoord);
					output.VizUV = float4(VizUV, 0, 0);
					output.LightCoord = LightCoord;
				#endif

				output.positionCS = MetaVertexPosition( input.positionOS, input.texcoord1.xy, input.texcoord1.xy, unity_LightmapST, unity_DynamicLightmapST );
				output.positionWS = TransformObjectToWorld( input.positionOS.xyz );
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				output.texcoord = input.texcoord;
				output.texcoord1 = input.texcoord1;
				output.texcoord2 = input.texcoord2;
				output.texcoord = input.texcoord;
				output.ase_texcoord3 = input.ase_texcoord3;
				output.ase_color = input.ase_color;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
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
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				output.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				output.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				output.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				output.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				output.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag(PackedVaryings input  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( input );

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord = TransformWorldToShadowCoord(input.positionWS);
				#else
					float4 shadowCoord = float4(0, 0, 0, 0);
				#endif

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( input.positionWS );
				float4 ShadowCoord = shadowCoord;

				float localBreakVisualData4_g251314 = ( 0.0 );
				float localBuildVisualData3_g207088 = ( 0.0 );
				TVEVisualData Data3_g207088 =(TVEVisualData)0;
				half4 Dummy130_g207086 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) + _MainMultiMaskInfo + _MainSmoothnessInfo );
				float temp_output_14_0_g207088 = Dummy130_g207086.x;
				float In_Dummy3_g207088 = temp_output_14_0_g207088;
				TEXTURE2D(Texture276_g207093) = _MainAlbedoTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g207096 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g207093 = staticSwitch36_g207096;
				float localBreakTextureData456_g207093 = ( 0.0 );
				float localBuildTextureData431_g251292 = ( 0.0 );
				TVEMasksData Data431_g251292 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g251292 = ( 0.0 );
				half4 Local_Coords180_g207086 = _main_coord_value;
				float4 Coords444_g251292 = Local_Coords180_g207086;
				TVEModelData Data16_g205222 =(TVEModelData)(TVEModelData)0;
				float In_Dummy16_g205222 = 0.0;
				float3 vertexToFrag73_g205214 = input.ase_texcoord3.xyz;
				float3 PositionWS122_g205214 = vertexToFrag73_g205214;
				float3 In_PositionWS16_g205222 = PositionWS122_g205214;
				float3 vertexToFrag76_g205214 = input.ase_texcoord4.xyz;
				float3 PivotWS121_g205214 = vertexToFrag76_g205214;
				#ifdef TVE_SCOPE_DYNAMIC
				float3 staticSwitch204_g205214 = ( PositionWS122_g205214 - PivotWS121_g205214 );
				#else
				float3 staticSwitch204_g205214 = PositionWS122_g205214;
				#endif
				float3 PositionWO132_g205214 = ( staticSwitch204_g205214 - TVE_WorldOrigin );
				float3 In_PositionWO16_g205222 = PositionWO132_g205214;
				float3 In_PivotWS16_g205222 = PivotWS121_g205214;
				float3 PivotWO133_g205214 = ( PivotWS121_g205214 - TVE_WorldOrigin );
				float3 In_PivotWO16_g205222 = PivotWO133_g205214;
				float3 ase_normalWS = input.ase_texcoord5.xyz;
				float3 normalizedWorldNormal = normalize( ase_normalWS );
				half3 NormalWS95_g205214 = normalizedWorldNormal;
				float3 In_NormalWS16_g205222 = NormalWS95_g205214;
				float3 ase_tangentWS = input.ase_texcoord6.xyz;
				half3 TangentWS136_g205214 = ase_tangentWS;
				float3 In_TangentWS16_g205222 = TangentWS136_g205214;
				float3 ase_bitangentWS = input.ase_texcoord7.xyz;
				half3 BiangentWS421_g205214 = ase_bitangentWS;
				float3 In_BitangentWS16_g205222 = BiangentWS421_g205214;
				half3 NormalWS427_g205214 = NormalWS95_g205214;
				half3 localComputeTriplanarWeights427_g205214 = ComputeTriplanarWeights( NormalWS427_g205214 );
				half3 TriplanarWeights429_g205214 = localComputeTriplanarWeights427_g205214;
				float3 In_TriplanarWeights16_g205222 = TriplanarWeights429_g205214;
				float3 normalizeResult296_g205214 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g205214 ) );
				half3 ViewDirWS169_g205214 = normalizeResult296_g205214;
				float3 In_ViewDirWS16_g205222 = ViewDirWS169_g205214;
				float4 appendResult397_g205214 = (float4(input.ase_texcoord8.xy , input.ase_texcoord8.zw));
				float4 CoordsData398_g205214 = appendResult397_g205214;
				float4 In_CoordsData16_g205222 = CoordsData398_g205214;
				half4 VertexMasks171_g205214 = input.ase_color;
				float4 In_VertexData16_g205222 = VertexMasks171_g205214;
				float temp_output_17_0_g205226 = _ObjectPhaseMode;
				float Option70_g205226 = temp_output_17_0_g205226;
				float4 temp_output_3_0_g205226 = input.ase_color;
				float4 Channel70_g205226 = temp_output_3_0_g205226;
				float localSwitchChannel470_g205226 = SwitchChannel4( Option70_g205226 , Channel70_g205226 );
				half Phase_Value372_g205214 = localSwitchChannel470_g205226;
				float3 break319_g205214 = PivotWO133_g205214;
				half Pivot_Position322_g205214 = ( break319_g205214.x + break319_g205214.z );
				half Phase_Position357_g205214 = ( Phase_Value372_g205214 + Pivot_Position322_g205214 );
				float temp_output_248_0_g205214 = frac( Phase_Position357_g205214 );
				float4 appendResult177_g205214 = (float4(( (frac( ( Phase_Position357_g205214 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g205214));
				half4 Phase_Data176_g205214 = appendResult177_g205214;
				float4 In_PhaseData16_g205222 = Phase_Data176_g205214;
				BuildModelFragData( Data16_g205222 , In_Dummy16_g205222 , In_PositionWS16_g205222 , In_PositionWO16_g205222 , In_PivotWS16_g205222 , In_PivotWO16_g205222 , In_NormalWS16_g205222 , In_TangentWS16_g205222 , In_BitangentWS16_g205222 , In_TriplanarWeights16_g205222 , In_ViewDirWS16_g205222 , In_CoordsData16_g205222 , In_VertexData16_g205222 , In_PhaseData16_g205222 );
				TVEModelData Data15_g207087 =(TVEModelData)Data16_g205222;
				float Out_Dummy15_g207087 = 0.0;
				float3 Out_PositionWS15_g207087 = float3( 0,0,0 );
				float3 Out_PositionWO15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWS15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWO15_g207087 = float3( 0,0,0 );
				float3 Out_NormalWS15_g207087 = float3( 0,0,0 );
				float3 Out_TangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g207087 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g207087 = float3( 0,0,0 );
				float4 Out_CoordsData15_g207087 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g207087 = float4( 0,0,0,0 );
				float4 Out_PhaseData15_g207087 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g207087 , Out_Dummy15_g207087 , Out_PositionWS15_g207087 , Out_PositionWO15_g207087 , Out_PivotWS15_g207087 , Out_PivotWO15_g207087 , Out_NormalWS15_g207087 , Out_TangentWS15_g207087 , Out_BitangentWS15_g207087 , Out_TriplanarWeights15_g207087 , Out_ViewDirWS15_g207087 , Out_CoordsData15_g207087 , Out_VertexData15_g207087 , Out_PhaseData15_g207087 );
				half4 Model_CoordsData412_g207086 = Out_CoordsData15_g207087;
				float4 MeshCoords444_g251292 = Model_CoordsData412_g207086;
				float2 UV0444_g251292 = float2( 0,0 );
				float2 UV3444_g251292 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g251292 , MeshCoords444_g251292 , UV0444_g251292 , UV3444_g251292 );
				float4 appendResult430_g251292 = (float4(UV0444_g251292 , UV3444_g251292));
				float4 In_MaskA431_g251292 = appendResult430_g251292;
				float localComputeWorldCoords315_g251292 = ( 0.0 );
				float4 Coords315_g251292 = Local_Coords180_g207086;
				half3 Model_PositionWO222_g207086 = Out_PositionWO15_g207087;
				float3 PositionWS315_g251292 = Model_PositionWO222_g207086;
				float2 ZY315_g251292 = float2( 0,0 );
				float2 XZ315_g251292 = float2( 0,0 );
				float2 XY315_g251292 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g251292 , PositionWS315_g251292 , ZY315_g251292 , XZ315_g251292 , XY315_g251292 );
				float2 ZY402_g251292 = ZY315_g251292;
				float2 XZ403_g251292 = XZ315_g251292;
				float4 appendResult432_g251292 = (float4(ZY402_g251292 , XZ403_g251292));
				float4 In_MaskB431_g251292 = appendResult432_g251292;
				float2 XY404_g251292 = XY315_g251292;
				float localComputeStochasticCoords409_g251292 = ( 0.0 );
				float2 UV409_g251292 = ZY402_g251292;
				float2 UV1409_g251292 = float2( 0,0 );
				float2 UV2409_g251292 = float2( 0,0 );
				float2 UV3409_g251292 = float2( 0,0 );
				float3 Weights409_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g251292 , UV1409_g251292 , UV2409_g251292 , UV3409_g251292 , Weights409_g251292 );
				float4 appendResult433_g251292 = (float4(XY404_g251292 , UV1409_g251292));
				float4 In_MaskC431_g251292 = appendResult433_g251292;
				float4 appendResult434_g251292 = (float4(UV2409_g251292 , UV3409_g251292));
				float4 In_MaskD431_g251292 = appendResult434_g251292;
				float localComputeStochasticCoords422_g251292 = ( 0.0 );
				float2 UV422_g251292 = XZ403_g251292;
				float2 UV1422_g251292 = float2( 0,0 );
				float2 UV2422_g251292 = float2( 0,0 );
				float2 UV3422_g251292 = float2( 0,0 );
				float3 Weights422_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g251292 , UV1422_g251292 , UV2422_g251292 , UV3422_g251292 , Weights422_g251292 );
				float4 appendResult435_g251292 = (float4(UV1422_g251292 , UV2422_g251292));
				float4 In_MaskE431_g251292 = appendResult435_g251292;
				float localComputeStochasticCoords423_g251292 = ( 0.0 );
				float2 UV423_g251292 = XY404_g251292;
				float2 UV1423_g251292 = float2( 0,0 );
				float2 UV2423_g251292 = float2( 0,0 );
				float2 UV3423_g251292 = float2( 0,0 );
				float3 Weights423_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g251292 , UV1423_g251292 , UV2423_g251292 , UV3423_g251292 , Weights423_g251292 );
				float4 appendResult436_g251292 = (float4(UV3422_g251292 , UV1423_g251292));
				float4 In_MaskF431_g251292 = appendResult436_g251292;
				float4 appendResult437_g251292 = (float4(UV2423_g251292 , UV3423_g251292));
				float4 In_MaskG431_g251292 = appendResult437_g251292;
				float4 In_MaskH431_g251292 = float4( Weights409_g251292 , 0.0 );
				float4 In_MaskI431_g251292 = float4( Weights422_g251292 , 0.0 );
				float4 In_MaskJ431_g251292 = float4( Weights423_g251292 , 0.0 );
				float3 temp_output_449_0_g251292 = float3( 0,0,0 );
				float4 In_MaskK431_g251292 = float4( temp_output_449_0_g251292 , 0.0 );
				float3 temp_output_450_0_g251292 = float3( 0,0,0 );
				float4 In_MaskL431_g251292 = float4( temp_output_450_0_g251292 , 0.0 );
				float3 temp_output_451_0_g251292 = float3( 0,0,0 );
				float4 In_MaskM431_g251292 = float4( temp_output_451_0_g251292 , 0.0 );
				float3 temp_output_445_0_g251292 = float3( 0,0,0 );
				float4 In_MaskN431_g251292 = float4( temp_output_445_0_g251292 , 0.0 );
				BuildTextureData( Data431_g251292 , In_MaskA431_g251292 , In_MaskB431_g251292 , In_MaskC431_g251292 , In_MaskD431_g251292 , In_MaskE431_g251292 , In_MaskF431_g251292 , In_MaskG431_g251292 , In_MaskH431_g251292 , In_MaskI431_g251292 , In_MaskJ431_g251292 , In_MaskK431_g251292 , In_MaskL431_g251292 , In_MaskM431_g251292 , In_MaskN431_g251292 );
				TVEMasksData Data456_g207093 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207093 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207093 , Out_MaskA456_g207093 , Out_MaskB456_g207093 , Out_MaskC456_g207093 , Out_MaskD456_g207093 , Out_MaskE456_g207093 , Out_MaskF456_g207093 , Out_MaskG456_g207093 , Out_MaskH456_g207093 , Out_MaskI456_g207093 , Out_MaskJ456_g207093 , Out_MaskK456_g207093 , Out_MaskL456_g207093 , Out_MaskM456_g207093 , Out_MaskN456_g207093 );
				half2 UV276_g207093 = (Out_MaskA456_g207093).xy;
				float temp_output_504_0_g207093 = 0.0;
				half Bias276_g207093 = temp_output_504_0_g207093;
				half2 Normal276_g207093 = float2( 0,0 );
				half4 localSampleCoord276_g207093 = SampleCoord( Texture276_g207093 , Sampler276_g207093 , UV276_g207093 , Bias276_g207093 , Normal276_g207093 );
				TEXTURE2D(Texture502_g207093) = _MainAlbedoTex;
				SamplerState Sampler502_g207093 = staticSwitch36_g207096;
				half2 UV502_g207093 = (Out_MaskA456_g207093).zw;
				half Bias502_g207093 = temp_output_504_0_g207093;
				half2 Normal502_g207093 = float2( 0,0 );
				half4 localSampleCoord502_g207093 = SampleCoord( Texture502_g207093 , Sampler502_g207093 , UV502_g207093 , Bias502_g207093 , Normal502_g207093 );
				TEXTURE2D(Texture496_g207093) = _MainAlbedoTex;
				SamplerState Sampler496_g207093 = staticSwitch36_g207096;
				float2 temp_output_463_0_g207093 = (Out_MaskB456_g207093).zw;
				half2 XZ496_g207093 = temp_output_463_0_g207093;
				half Bias496_g207093 = temp_output_504_0_g207093;
				float3 temp_output_483_0_g207093 = (Out_MaskK456_g207093).xyz;
				half3 NormalWS496_g207093 = temp_output_483_0_g207093;
				half3 Normal496_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207093 = SamplePlanar2D( Texture496_g207093 , Sampler496_g207093 , XZ496_g207093 , Bias496_g207093 , NormalWS496_g207093 , Normal496_g207093 );
				TEXTURE2D(Texture490_g207093) = _MainAlbedoTex;
				SamplerState Sampler490_g207093 = staticSwitch36_g207096;
				float2 temp_output_462_0_g207093 = (Out_MaskB456_g207093).xy;
				half2 ZY490_g207093 = temp_output_462_0_g207093;
				half2 XZ490_g207093 = temp_output_463_0_g207093;
				float2 temp_output_464_0_g207093 = (Out_MaskC456_g207093).xy;
				half2 XY490_g207093 = temp_output_464_0_g207093;
				half Bias490_g207093 = temp_output_504_0_g207093;
				float3 temp_output_482_0_g207093 = (Out_MaskN456_g207093).xyz;
				half3 Triplanar490_g207093 = temp_output_482_0_g207093;
				half3 NormalWS490_g207093 = temp_output_483_0_g207093;
				half3 Normal490_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207093 = SamplePlanar3D( Texture490_g207093 , Sampler490_g207093 , ZY490_g207093 , XZ490_g207093 , XY490_g207093 , Bias490_g207093 , Triplanar490_g207093 , NormalWS490_g207093 , Normal490_g207093 );
				TEXTURE2D(Texture498_g207093) = _MainAlbedoTex;
				SamplerState Sampler498_g207093 = staticSwitch36_g207096;
				half2 XZ498_g207093 = temp_output_463_0_g207093;
				float2 temp_output_473_0_g207093 = (Out_MaskE456_g207093).xy;
				half2 XZ_1498_g207093 = temp_output_473_0_g207093;
				float2 temp_output_474_0_g207093 = (Out_MaskE456_g207093).zw;
				half2 XZ_2498_g207093 = temp_output_474_0_g207093;
				float2 temp_output_475_0_g207093 = (Out_MaskF456_g207093).xy;
				half2 XZ_3498_g207093 = temp_output_475_0_g207093;
				float temp_output_510_0_g207093 = exp2( temp_output_504_0_g207093 );
				half Bias498_g207093 = temp_output_510_0_g207093;
				float3 temp_output_480_0_g207093 = (Out_MaskI456_g207093).xyz;
				half3 Weights_2498_g207093 = temp_output_480_0_g207093;
				half3 NormalWS498_g207093 = temp_output_483_0_g207093;
				half3 Normal498_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207093 = SampleStochastic2D( Texture498_g207093 , Sampler498_g207093 , XZ498_g207093 , XZ_1498_g207093 , XZ_2498_g207093 , XZ_3498_g207093 , Bias498_g207093 , Weights_2498_g207093 , NormalWS498_g207093 , Normal498_g207093 );
				TEXTURE2D(Texture500_g207093) = _MainAlbedoTex;
				SamplerState Sampler500_g207093 = staticSwitch36_g207096;
				half2 ZY500_g207093 = temp_output_462_0_g207093;
				half2 ZY_1500_g207093 = (Out_MaskC456_g207093).zw;
				half2 ZY_2500_g207093 = (Out_MaskD456_g207093).xy;
				half2 ZY_3500_g207093 = (Out_MaskD456_g207093).zw;
				half2 XZ500_g207093 = temp_output_463_0_g207093;
				half2 XZ_1500_g207093 = temp_output_473_0_g207093;
				half2 XZ_2500_g207093 = temp_output_474_0_g207093;
				half2 XZ_3500_g207093 = temp_output_475_0_g207093;
				half2 XY500_g207093 = temp_output_464_0_g207093;
				half2 XY_1500_g207093 = (Out_MaskF456_g207093).zw;
				half2 XY_2500_g207093 = (Out_MaskG456_g207093).xy;
				half2 XY_3500_g207093 = (Out_MaskG456_g207093).zw;
				half Bias500_g207093 = temp_output_510_0_g207093;
				half3 Weights_1500_g207093 = (Out_MaskH456_g207093).xyz;
				half3 Weights_2500_g207093 = temp_output_480_0_g207093;
				half3 Weights_3500_g207093 = (Out_MaskJ456_g207093).xyz;
				half3 Triplanar500_g207093 = temp_output_482_0_g207093;
				half3 NormalWS500_g207093 = temp_output_483_0_g207093;
				half3 Normal500_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207093 = SampleStochastic3D( Texture500_g207093 , Sampler500_g207093 , ZY500_g207093 , ZY_1500_g207093 , ZY_2500_g207093 , ZY_3500_g207093 , XZ500_g207093 , XZ_1500_g207093 , XZ_2500_g207093 , XZ_3500_g207093 , XY500_g207093 , XY_1500_g207093 , XY_2500_g207093 , XY_3500_g207093 , Bias500_g207093 , Weights_1500_g207093 , Weights_2500_g207093 , Weights_3500_g207093 , Triplanar500_g207093 , NormalWS500_g207093 , Normal500_g207093 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch184_g207086 = localSampleCoord502_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch184_g207086 = localSamplePlanar2D496_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch184_g207086 = localSamplePlanar3D490_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch184_g207086 = localSampleStochastic2D498_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch184_g207086 = localSampleStochastic3D500_g207093;
				#else
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#endif
				half4 Local_AlbedoTex185_g207086 = staticSwitch184_g207086;
				float3 lerpResult53_g207086 = lerp( float3( 1,1,1 ) , (Local_AlbedoTex185_g207086).xyz , _MainAlbedoValue);
				half3 Local_AlbedoRGB107_g207086 = lerpResult53_g207086;
				TEXTURE2D(Texture276_g207097) = _MainShaderTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207098 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207097 = staticSwitch38_g207098;
				float localBreakTextureData456_g207097 = ( 0.0 );
				TVEMasksData Data456_g207097 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207097 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207097 , Out_MaskA456_g207097 , Out_MaskB456_g207097 , Out_MaskC456_g207097 , Out_MaskD456_g207097 , Out_MaskE456_g207097 , Out_MaskF456_g207097 , Out_MaskG456_g207097 , Out_MaskH456_g207097 , Out_MaskI456_g207097 , Out_MaskJ456_g207097 , Out_MaskK456_g207097 , Out_MaskL456_g207097 , Out_MaskM456_g207097 , Out_MaskN456_g207097 );
				half2 UV276_g207097 = (Out_MaskA456_g207097).xy;
				float temp_output_504_0_g207097 = 0.0;
				half Bias276_g207097 = temp_output_504_0_g207097;
				half2 Normal276_g207097 = float2( 0,0 );
				half4 localSampleCoord276_g207097 = SampleCoord( Texture276_g207097 , Sampler276_g207097 , UV276_g207097 , Bias276_g207097 , Normal276_g207097 );
				TEXTURE2D(Texture502_g207097) = _MainShaderTex;
				SamplerState Sampler502_g207097 = staticSwitch38_g207098;
				half2 UV502_g207097 = (Out_MaskA456_g207097).zw;
				half Bias502_g207097 = temp_output_504_0_g207097;
				half2 Normal502_g207097 = float2( 0,0 );
				half4 localSampleCoord502_g207097 = SampleCoord( Texture502_g207097 , Sampler502_g207097 , UV502_g207097 , Bias502_g207097 , Normal502_g207097 );
				TEXTURE2D(Texture496_g207097) = _MainShaderTex;
				SamplerState Sampler496_g207097 = staticSwitch38_g207098;
				float2 temp_output_463_0_g207097 = (Out_MaskB456_g207097).zw;
				half2 XZ496_g207097 = temp_output_463_0_g207097;
				half Bias496_g207097 = temp_output_504_0_g207097;
				float3 temp_output_483_0_g207097 = (Out_MaskK456_g207097).xyz;
				half3 NormalWS496_g207097 = temp_output_483_0_g207097;
				half3 Normal496_g207097 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207097 = SamplePlanar2D( Texture496_g207097 , Sampler496_g207097 , XZ496_g207097 , Bias496_g207097 , NormalWS496_g207097 , Normal496_g207097 );
				TEXTURE2D(Texture490_g207097) = _MainShaderTex;
				SamplerState Sampler490_g207097 = staticSwitch38_g207098;
				float2 temp_output_462_0_g207097 = (Out_MaskB456_g207097).xy;
				half2 ZY490_g207097 = temp_output_462_0_g207097;
				half2 XZ490_g207097 = temp_output_463_0_g207097;
				float2 temp_output_464_0_g207097 = (Out_MaskC456_g207097).xy;
				half2 XY490_g207097 = temp_output_464_0_g207097;
				half Bias490_g207097 = temp_output_504_0_g207097;
				float3 temp_output_482_0_g207097 = (Out_MaskN456_g207097).xyz;
				half3 Triplanar490_g207097 = temp_output_482_0_g207097;
				half3 NormalWS490_g207097 = temp_output_483_0_g207097;
				half3 Normal490_g207097 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207097 = SamplePlanar3D( Texture490_g207097 , Sampler490_g207097 , ZY490_g207097 , XZ490_g207097 , XY490_g207097 , Bias490_g207097 , Triplanar490_g207097 , NormalWS490_g207097 , Normal490_g207097 );
				TEXTURE2D(Texture498_g207097) = _MainShaderTex;
				SamplerState Sampler498_g207097 = staticSwitch38_g207098;
				half2 XZ498_g207097 = temp_output_463_0_g207097;
				float2 temp_output_473_0_g207097 = (Out_MaskE456_g207097).xy;
				half2 XZ_1498_g207097 = temp_output_473_0_g207097;
				float2 temp_output_474_0_g207097 = (Out_MaskE456_g207097).zw;
				half2 XZ_2498_g207097 = temp_output_474_0_g207097;
				float2 temp_output_475_0_g207097 = (Out_MaskF456_g207097).xy;
				half2 XZ_3498_g207097 = temp_output_475_0_g207097;
				float temp_output_510_0_g207097 = exp2( temp_output_504_0_g207097 );
				half Bias498_g207097 = temp_output_510_0_g207097;
				float3 temp_output_480_0_g207097 = (Out_MaskI456_g207097).xyz;
				half3 Weights_2498_g207097 = temp_output_480_0_g207097;
				half3 NormalWS498_g207097 = temp_output_483_0_g207097;
				half3 Normal498_g207097 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207097 = SampleStochastic2D( Texture498_g207097 , Sampler498_g207097 , XZ498_g207097 , XZ_1498_g207097 , XZ_2498_g207097 , XZ_3498_g207097 , Bias498_g207097 , Weights_2498_g207097 , NormalWS498_g207097 , Normal498_g207097 );
				TEXTURE2D(Texture500_g207097) = _MainShaderTex;
				SamplerState Sampler500_g207097 = staticSwitch38_g207098;
				half2 ZY500_g207097 = temp_output_462_0_g207097;
				half2 ZY_1500_g207097 = (Out_MaskC456_g207097).zw;
				half2 ZY_2500_g207097 = (Out_MaskD456_g207097).xy;
				half2 ZY_3500_g207097 = (Out_MaskD456_g207097).zw;
				half2 XZ500_g207097 = temp_output_463_0_g207097;
				half2 XZ_1500_g207097 = temp_output_473_0_g207097;
				half2 XZ_2500_g207097 = temp_output_474_0_g207097;
				half2 XZ_3500_g207097 = temp_output_475_0_g207097;
				half2 XY500_g207097 = temp_output_464_0_g207097;
				half2 XY_1500_g207097 = (Out_MaskF456_g207097).zw;
				half2 XY_2500_g207097 = (Out_MaskG456_g207097).xy;
				half2 XY_3500_g207097 = (Out_MaskG456_g207097).zw;
				half Bias500_g207097 = temp_output_510_0_g207097;
				half3 Weights_1500_g207097 = (Out_MaskH456_g207097).xyz;
				half3 Weights_2500_g207097 = temp_output_480_0_g207097;
				half3 Weights_3500_g207097 = (Out_MaskJ456_g207097).xyz;
				half3 Triplanar500_g207097 = temp_output_482_0_g207097;
				half3 NormalWS500_g207097 = temp_output_483_0_g207097;
				half3 Normal500_g207097 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207097 = SampleStochastic3D( Texture500_g207097 , Sampler500_g207097 , ZY500_g207097 , ZY_1500_g207097 , ZY_2500_g207097 , ZY_3500_g207097 , XZ500_g207097 , XZ_1500_g207097 , XZ_2500_g207097 , XZ_3500_g207097 , XY500_g207097 , XY_1500_g207097 , XY_2500_g207097 , XY_3500_g207097 , Bias500_g207097 , Weights_1500_g207097 , Weights_2500_g207097 , Weights_3500_g207097 , Triplanar500_g207097 , NormalWS500_g207097 , Normal500_g207097 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch198_g207086 = localSampleCoord276_g207097;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch198_g207086 = localSampleCoord502_g207097;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch198_g207086 = localSamplePlanar2D496_g207097;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch198_g207086 = localSamplePlanar3D490_g207097;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch198_g207086 = localSampleStochastic2D498_g207097;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch198_g207086 = localSampleStochastic3D500_g207097;
				#else
				float4 staticSwitch198_g207086 = localSampleCoord276_g207097;
				#endif
				half4 Local_ShaderTex199_g207086 = staticSwitch198_g207086;
				float temp_output_17_0_g251298 = _MainMetallicChannelMode;
				float Option83_g251298 = temp_output_17_0_g251298;
				TEXTURE2D(Texture276_g207101) = _MainMetallicTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207102 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207101 = staticSwitch38_g207102;
				float localBreakTextureData456_g207101 = ( 0.0 );
				TVEMasksData Data456_g207101 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207101 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207101 , Out_MaskA456_g207101 , Out_MaskB456_g207101 , Out_MaskC456_g207101 , Out_MaskD456_g207101 , Out_MaskE456_g207101 , Out_MaskF456_g207101 , Out_MaskG456_g207101 , Out_MaskH456_g207101 , Out_MaskI456_g207101 , Out_MaskJ456_g207101 , Out_MaskK456_g207101 , Out_MaskL456_g207101 , Out_MaskM456_g207101 , Out_MaskN456_g207101 );
				half2 UV276_g207101 = (Out_MaskA456_g207101).xy;
				float temp_output_504_0_g207101 = 0.0;
				half Bias276_g207101 = temp_output_504_0_g207101;
				half2 Normal276_g207101 = float2( 0,0 );
				half4 localSampleCoord276_g207101 = SampleCoord( Texture276_g207101 , Sampler276_g207101 , UV276_g207101 , Bias276_g207101 , Normal276_g207101 );
				TEXTURE2D(Texture502_g207101) = _MainMetallicTex;
				SamplerState Sampler502_g207101 = staticSwitch38_g207102;
				half2 UV502_g207101 = (Out_MaskA456_g207101).zw;
				half Bias502_g207101 = temp_output_504_0_g207101;
				half2 Normal502_g207101 = float2( 0,0 );
				half4 localSampleCoord502_g207101 = SampleCoord( Texture502_g207101 , Sampler502_g207101 , UV502_g207101 , Bias502_g207101 , Normal502_g207101 );
				TEXTURE2D(Texture496_g207101) = _MainMetallicTex;
				SamplerState Sampler496_g207101 = staticSwitch38_g207102;
				float2 temp_output_463_0_g207101 = (Out_MaskB456_g207101).zw;
				half2 XZ496_g207101 = temp_output_463_0_g207101;
				half Bias496_g207101 = temp_output_504_0_g207101;
				float3 temp_output_483_0_g207101 = (Out_MaskK456_g207101).xyz;
				half3 NormalWS496_g207101 = temp_output_483_0_g207101;
				half3 Normal496_g207101 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207101 = SamplePlanar2D( Texture496_g207101 , Sampler496_g207101 , XZ496_g207101 , Bias496_g207101 , NormalWS496_g207101 , Normal496_g207101 );
				TEXTURE2D(Texture490_g207101) = _MainMetallicTex;
				SamplerState Sampler490_g207101 = staticSwitch38_g207102;
				float2 temp_output_462_0_g207101 = (Out_MaskB456_g207101).xy;
				half2 ZY490_g207101 = temp_output_462_0_g207101;
				half2 XZ490_g207101 = temp_output_463_0_g207101;
				float2 temp_output_464_0_g207101 = (Out_MaskC456_g207101).xy;
				half2 XY490_g207101 = temp_output_464_0_g207101;
				half Bias490_g207101 = temp_output_504_0_g207101;
				float3 temp_output_482_0_g207101 = (Out_MaskN456_g207101).xyz;
				half3 Triplanar490_g207101 = temp_output_482_0_g207101;
				half3 NormalWS490_g207101 = temp_output_483_0_g207101;
				half3 Normal490_g207101 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207101 = SamplePlanar3D( Texture490_g207101 , Sampler490_g207101 , ZY490_g207101 , XZ490_g207101 , XY490_g207101 , Bias490_g207101 , Triplanar490_g207101 , NormalWS490_g207101 , Normal490_g207101 );
				TEXTURE2D(Texture498_g207101) = _MainMetallicTex;
				SamplerState Sampler498_g207101 = staticSwitch38_g207102;
				half2 XZ498_g207101 = temp_output_463_0_g207101;
				float2 temp_output_473_0_g207101 = (Out_MaskE456_g207101).xy;
				half2 XZ_1498_g207101 = temp_output_473_0_g207101;
				float2 temp_output_474_0_g207101 = (Out_MaskE456_g207101).zw;
				half2 XZ_2498_g207101 = temp_output_474_0_g207101;
				float2 temp_output_475_0_g207101 = (Out_MaskF456_g207101).xy;
				half2 XZ_3498_g207101 = temp_output_475_0_g207101;
				float temp_output_510_0_g207101 = exp2( temp_output_504_0_g207101 );
				half Bias498_g207101 = temp_output_510_0_g207101;
				float3 temp_output_480_0_g207101 = (Out_MaskI456_g207101).xyz;
				half3 Weights_2498_g207101 = temp_output_480_0_g207101;
				half3 NormalWS498_g207101 = temp_output_483_0_g207101;
				half3 Normal498_g207101 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207101 = SampleStochastic2D( Texture498_g207101 , Sampler498_g207101 , XZ498_g207101 , XZ_1498_g207101 , XZ_2498_g207101 , XZ_3498_g207101 , Bias498_g207101 , Weights_2498_g207101 , NormalWS498_g207101 , Normal498_g207101 );
				TEXTURE2D(Texture500_g207101) = _MainMetallicTex;
				SamplerState Sampler500_g207101 = staticSwitch38_g207102;
				half2 ZY500_g207101 = temp_output_462_0_g207101;
				half2 ZY_1500_g207101 = (Out_MaskC456_g207101).zw;
				half2 ZY_2500_g207101 = (Out_MaskD456_g207101).xy;
				half2 ZY_3500_g207101 = (Out_MaskD456_g207101).zw;
				half2 XZ500_g207101 = temp_output_463_0_g207101;
				half2 XZ_1500_g207101 = temp_output_473_0_g207101;
				half2 XZ_2500_g207101 = temp_output_474_0_g207101;
				half2 XZ_3500_g207101 = temp_output_475_0_g207101;
				half2 XY500_g207101 = temp_output_464_0_g207101;
				half2 XY_1500_g207101 = (Out_MaskF456_g207101).zw;
				half2 XY_2500_g207101 = (Out_MaskG456_g207101).xy;
				half2 XY_3500_g207101 = (Out_MaskG456_g207101).zw;
				half Bias500_g207101 = temp_output_510_0_g207101;
				half3 Weights_1500_g207101 = (Out_MaskH456_g207101).xyz;
				half3 Weights_2500_g207101 = temp_output_480_0_g207101;
				half3 Weights_3500_g207101 = (Out_MaskJ456_g207101).xyz;
				half3 Triplanar500_g207101 = temp_output_482_0_g207101;
				half3 NormalWS500_g207101 = temp_output_483_0_g207101;
				half3 Normal500_g207101 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207101 = SampleStochastic3D( Texture500_g207101 , Sampler500_g207101 , ZY500_g207101 , ZY_1500_g207101 , ZY_2500_g207101 , ZY_3500_g207101 , XZ500_g207101 , XZ_1500_g207101 , XZ_2500_g207101 , XZ_3500_g207101 , XY500_g207101 , XY_1500_g207101 , XY_2500_g207101 , XY_3500_g207101 , Bias500_g207101 , Weights_1500_g207101 , Weights_2500_g207101 , Weights_3500_g207101 , Triplanar500_g207101 , NormalWS500_g207101 , Normal500_g207101 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch335_g207086 = localSampleCoord276_g207101;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch335_g207086 = localSampleCoord502_g207101;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch335_g207086 = localSamplePlanar2D496_g207101;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch335_g207086 = localSamplePlanar3D490_g207101;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch335_g207086 = localSampleStochastic2D498_g207101;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch335_g207086 = localSampleStochastic3D500_g207101;
				#else
				float4 staticSwitch335_g207086 = localSampleCoord276_g207101;
				#endif
				half4 Local_MetallicTex341_g207086 = staticSwitch335_g207086;
				float4 ChannelA83_g251298 = Local_MetallicTex341_g207086;
				float4 ChannelB83_g251298 = ( 1.0 - Local_MetallicTex341_g207086 );
				float localSwitchChannel883_g251298 = SwitchChannel8( Option83_g251298 , ChannelA83_g251298 , ChannelB83_g251298 );
				float lerpResult366_g207086 = lerp( (Local_ShaderTex199_g207086).x , localSwitchChannel883_g251298 , _MainMetallicSourceMode);
				half Local_Metallic322_g207086 = ( lerpResult366_g207086 * _MainMetallicValue );
				float temp_output_17_0_g251299 = _MainOcclusionChannelMode;
				float Option83_g251299 = temp_output_17_0_g251299;
				TEXTURE2D(Texture276_g207103) = _MainOcclusionTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207108 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207103 = staticSwitch38_g207108;
				float localBreakTextureData456_g207103 = ( 0.0 );
				TVEMasksData Data456_g207103 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207103 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207103 , Out_MaskA456_g207103 , Out_MaskB456_g207103 , Out_MaskC456_g207103 , Out_MaskD456_g207103 , Out_MaskE456_g207103 , Out_MaskF456_g207103 , Out_MaskG456_g207103 , Out_MaskH456_g207103 , Out_MaskI456_g207103 , Out_MaskJ456_g207103 , Out_MaskK456_g207103 , Out_MaskL456_g207103 , Out_MaskM456_g207103 , Out_MaskN456_g207103 );
				half2 UV276_g207103 = (Out_MaskA456_g207103).xy;
				float temp_output_504_0_g207103 = 0.0;
				half Bias276_g207103 = temp_output_504_0_g207103;
				half2 Normal276_g207103 = float2( 0,0 );
				half4 localSampleCoord276_g207103 = SampleCoord( Texture276_g207103 , Sampler276_g207103 , UV276_g207103 , Bias276_g207103 , Normal276_g207103 );
				TEXTURE2D(Texture502_g207103) = _MainOcclusionTex;
				SamplerState Sampler502_g207103 = staticSwitch38_g207108;
				half2 UV502_g207103 = (Out_MaskA456_g207103).zw;
				half Bias502_g207103 = temp_output_504_0_g207103;
				half2 Normal502_g207103 = float2( 0,0 );
				half4 localSampleCoord502_g207103 = SampleCoord( Texture502_g207103 , Sampler502_g207103 , UV502_g207103 , Bias502_g207103 , Normal502_g207103 );
				TEXTURE2D(Texture496_g207103) = _MainOcclusionTex;
				SamplerState Sampler496_g207103 = staticSwitch38_g207108;
				float2 temp_output_463_0_g207103 = (Out_MaskB456_g207103).zw;
				half2 XZ496_g207103 = temp_output_463_0_g207103;
				half Bias496_g207103 = temp_output_504_0_g207103;
				float3 temp_output_483_0_g207103 = (Out_MaskK456_g207103).xyz;
				half3 NormalWS496_g207103 = temp_output_483_0_g207103;
				half3 Normal496_g207103 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207103 = SamplePlanar2D( Texture496_g207103 , Sampler496_g207103 , XZ496_g207103 , Bias496_g207103 , NormalWS496_g207103 , Normal496_g207103 );
				TEXTURE2D(Texture490_g207103) = _MainOcclusionTex;
				SamplerState Sampler490_g207103 = staticSwitch38_g207108;
				float2 temp_output_462_0_g207103 = (Out_MaskB456_g207103).xy;
				half2 ZY490_g207103 = temp_output_462_0_g207103;
				half2 XZ490_g207103 = temp_output_463_0_g207103;
				float2 temp_output_464_0_g207103 = (Out_MaskC456_g207103).xy;
				half2 XY490_g207103 = temp_output_464_0_g207103;
				half Bias490_g207103 = temp_output_504_0_g207103;
				float3 temp_output_482_0_g207103 = (Out_MaskN456_g207103).xyz;
				half3 Triplanar490_g207103 = temp_output_482_0_g207103;
				half3 NormalWS490_g207103 = temp_output_483_0_g207103;
				half3 Normal490_g207103 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207103 = SamplePlanar3D( Texture490_g207103 , Sampler490_g207103 , ZY490_g207103 , XZ490_g207103 , XY490_g207103 , Bias490_g207103 , Triplanar490_g207103 , NormalWS490_g207103 , Normal490_g207103 );
				TEXTURE2D(Texture498_g207103) = _MainOcclusionTex;
				SamplerState Sampler498_g207103 = staticSwitch38_g207108;
				half2 XZ498_g207103 = temp_output_463_0_g207103;
				float2 temp_output_473_0_g207103 = (Out_MaskE456_g207103).xy;
				half2 XZ_1498_g207103 = temp_output_473_0_g207103;
				float2 temp_output_474_0_g207103 = (Out_MaskE456_g207103).zw;
				half2 XZ_2498_g207103 = temp_output_474_0_g207103;
				float2 temp_output_475_0_g207103 = (Out_MaskF456_g207103).xy;
				half2 XZ_3498_g207103 = temp_output_475_0_g207103;
				float temp_output_510_0_g207103 = exp2( temp_output_504_0_g207103 );
				half Bias498_g207103 = temp_output_510_0_g207103;
				float3 temp_output_480_0_g207103 = (Out_MaskI456_g207103).xyz;
				half3 Weights_2498_g207103 = temp_output_480_0_g207103;
				half3 NormalWS498_g207103 = temp_output_483_0_g207103;
				half3 Normal498_g207103 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207103 = SampleStochastic2D( Texture498_g207103 , Sampler498_g207103 , XZ498_g207103 , XZ_1498_g207103 , XZ_2498_g207103 , XZ_3498_g207103 , Bias498_g207103 , Weights_2498_g207103 , NormalWS498_g207103 , Normal498_g207103 );
				TEXTURE2D(Texture500_g207103) = _MainOcclusionTex;
				SamplerState Sampler500_g207103 = staticSwitch38_g207108;
				half2 ZY500_g207103 = temp_output_462_0_g207103;
				half2 ZY_1500_g207103 = (Out_MaskC456_g207103).zw;
				half2 ZY_2500_g207103 = (Out_MaskD456_g207103).xy;
				half2 ZY_3500_g207103 = (Out_MaskD456_g207103).zw;
				half2 XZ500_g207103 = temp_output_463_0_g207103;
				half2 XZ_1500_g207103 = temp_output_473_0_g207103;
				half2 XZ_2500_g207103 = temp_output_474_0_g207103;
				half2 XZ_3500_g207103 = temp_output_475_0_g207103;
				half2 XY500_g207103 = temp_output_464_0_g207103;
				half2 XY_1500_g207103 = (Out_MaskF456_g207103).zw;
				half2 XY_2500_g207103 = (Out_MaskG456_g207103).xy;
				half2 XY_3500_g207103 = (Out_MaskG456_g207103).zw;
				half Bias500_g207103 = temp_output_510_0_g207103;
				half3 Weights_1500_g207103 = (Out_MaskH456_g207103).xyz;
				half3 Weights_2500_g207103 = temp_output_480_0_g207103;
				half3 Weights_3500_g207103 = (Out_MaskJ456_g207103).xyz;
				half3 Triplanar500_g207103 = temp_output_482_0_g207103;
				half3 NormalWS500_g207103 = temp_output_483_0_g207103;
				half3 Normal500_g207103 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207103 = SampleStochastic3D( Texture500_g207103 , Sampler500_g207103 , ZY500_g207103 , ZY_1500_g207103 , ZY_2500_g207103 , ZY_3500_g207103 , XZ500_g207103 , XZ_1500_g207103 , XZ_2500_g207103 , XZ_3500_g207103 , XY500_g207103 , XY_1500_g207103 , XY_2500_g207103 , XY_3500_g207103 , Bias500_g207103 , Weights_1500_g207103 , Weights_2500_g207103 , Weights_3500_g207103 , Triplanar500_g207103 , NormalWS500_g207103 , Normal500_g207103 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch343_g207086 = localSampleCoord276_g207103;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch343_g207086 = localSampleCoord502_g207103;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch343_g207086 = localSamplePlanar2D496_g207103;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch343_g207086 = localSamplePlanar3D490_g207103;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch343_g207086 = localSampleStochastic2D498_g207103;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch343_g207086 = localSampleStochastic3D500_g207103;
				#else
				float4 staticSwitch343_g207086 = localSampleCoord276_g207103;
				#endif
				half4 Local_OcclusionTex349_g207086 = staticSwitch343_g207086;
				float4 ChannelA83_g251299 = Local_OcclusionTex349_g207086;
				float4 ChannelB83_g251299 = ( 1.0 - Local_OcclusionTex349_g207086 );
				float localSwitchChannel883_g251299 = SwitchChannel8( Option83_g251299 , ChannelA83_g251299 , ChannelB83_g251299 );
				float lerpResult373_g207086 = lerp( (Local_ShaderTex199_g207086).y , localSwitchChannel883_g251299 , _MainOcclusionSourceMode);
				float clampResult17_g251301 = clamp( lerpResult373_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251300 = _MainOcclusionRemap.x;
				float temp_output_9_0_g251300 = ( clampResult17_g251301 - temp_output_7_0_g251300 );
				float lerpResult23_g207086 = lerp( 1.0 , saturate( ( temp_output_9_0_g251300 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
				half Local_Occlusion313_g207086 = lerpResult23_g207086;
				float temp_output_17_0_g251307 = _MainSmoothnessChannelMode;
				float Option83_g251307 = temp_output_17_0_g251307;
				TEXTURE2D(Texture276_g207106) = _MainSmoothnessTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207107 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207106 = staticSwitch38_g207107;
				float localBreakTextureData456_g207106 = ( 0.0 );
				TVEMasksData Data456_g207106 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207106 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207106 , Out_MaskA456_g207106 , Out_MaskB456_g207106 , Out_MaskC456_g207106 , Out_MaskD456_g207106 , Out_MaskE456_g207106 , Out_MaskF456_g207106 , Out_MaskG456_g207106 , Out_MaskH456_g207106 , Out_MaskI456_g207106 , Out_MaskJ456_g207106 , Out_MaskK456_g207106 , Out_MaskL456_g207106 , Out_MaskM456_g207106 , Out_MaskN456_g207106 );
				half2 UV276_g207106 = (Out_MaskA456_g207106).xy;
				float temp_output_504_0_g207106 = 0.0;
				half Bias276_g207106 = temp_output_504_0_g207106;
				half2 Normal276_g207106 = float2( 0,0 );
				half4 localSampleCoord276_g207106 = SampleCoord( Texture276_g207106 , Sampler276_g207106 , UV276_g207106 , Bias276_g207106 , Normal276_g207106 );
				TEXTURE2D(Texture502_g207106) = _MainSmoothnessTex;
				SamplerState Sampler502_g207106 = staticSwitch38_g207107;
				half2 UV502_g207106 = (Out_MaskA456_g207106).zw;
				half Bias502_g207106 = temp_output_504_0_g207106;
				half2 Normal502_g207106 = float2( 0,0 );
				half4 localSampleCoord502_g207106 = SampleCoord( Texture502_g207106 , Sampler502_g207106 , UV502_g207106 , Bias502_g207106 , Normal502_g207106 );
				TEXTURE2D(Texture496_g207106) = _MainSmoothnessTex;
				SamplerState Sampler496_g207106 = staticSwitch38_g207107;
				float2 temp_output_463_0_g207106 = (Out_MaskB456_g207106).zw;
				half2 XZ496_g207106 = temp_output_463_0_g207106;
				half Bias496_g207106 = temp_output_504_0_g207106;
				float3 temp_output_483_0_g207106 = (Out_MaskK456_g207106).xyz;
				half3 NormalWS496_g207106 = temp_output_483_0_g207106;
				half3 Normal496_g207106 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207106 = SamplePlanar2D( Texture496_g207106 , Sampler496_g207106 , XZ496_g207106 , Bias496_g207106 , NormalWS496_g207106 , Normal496_g207106 );
				TEXTURE2D(Texture490_g207106) = _MainSmoothnessTex;
				SamplerState Sampler490_g207106 = staticSwitch38_g207107;
				float2 temp_output_462_0_g207106 = (Out_MaskB456_g207106).xy;
				half2 ZY490_g207106 = temp_output_462_0_g207106;
				half2 XZ490_g207106 = temp_output_463_0_g207106;
				float2 temp_output_464_0_g207106 = (Out_MaskC456_g207106).xy;
				half2 XY490_g207106 = temp_output_464_0_g207106;
				half Bias490_g207106 = temp_output_504_0_g207106;
				float3 temp_output_482_0_g207106 = (Out_MaskN456_g207106).xyz;
				half3 Triplanar490_g207106 = temp_output_482_0_g207106;
				half3 NormalWS490_g207106 = temp_output_483_0_g207106;
				half3 Normal490_g207106 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207106 = SamplePlanar3D( Texture490_g207106 , Sampler490_g207106 , ZY490_g207106 , XZ490_g207106 , XY490_g207106 , Bias490_g207106 , Triplanar490_g207106 , NormalWS490_g207106 , Normal490_g207106 );
				TEXTURE2D(Texture498_g207106) = _MainSmoothnessTex;
				SamplerState Sampler498_g207106 = staticSwitch38_g207107;
				half2 XZ498_g207106 = temp_output_463_0_g207106;
				float2 temp_output_473_0_g207106 = (Out_MaskE456_g207106).xy;
				half2 XZ_1498_g207106 = temp_output_473_0_g207106;
				float2 temp_output_474_0_g207106 = (Out_MaskE456_g207106).zw;
				half2 XZ_2498_g207106 = temp_output_474_0_g207106;
				float2 temp_output_475_0_g207106 = (Out_MaskF456_g207106).xy;
				half2 XZ_3498_g207106 = temp_output_475_0_g207106;
				float temp_output_510_0_g207106 = exp2( temp_output_504_0_g207106 );
				half Bias498_g207106 = temp_output_510_0_g207106;
				float3 temp_output_480_0_g207106 = (Out_MaskI456_g207106).xyz;
				half3 Weights_2498_g207106 = temp_output_480_0_g207106;
				half3 NormalWS498_g207106 = temp_output_483_0_g207106;
				half3 Normal498_g207106 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207106 = SampleStochastic2D( Texture498_g207106 , Sampler498_g207106 , XZ498_g207106 , XZ_1498_g207106 , XZ_2498_g207106 , XZ_3498_g207106 , Bias498_g207106 , Weights_2498_g207106 , NormalWS498_g207106 , Normal498_g207106 );
				TEXTURE2D(Texture500_g207106) = _MainSmoothnessTex;
				SamplerState Sampler500_g207106 = staticSwitch38_g207107;
				half2 ZY500_g207106 = temp_output_462_0_g207106;
				half2 ZY_1500_g207106 = (Out_MaskC456_g207106).zw;
				half2 ZY_2500_g207106 = (Out_MaskD456_g207106).xy;
				half2 ZY_3500_g207106 = (Out_MaskD456_g207106).zw;
				half2 XZ500_g207106 = temp_output_463_0_g207106;
				half2 XZ_1500_g207106 = temp_output_473_0_g207106;
				half2 XZ_2500_g207106 = temp_output_474_0_g207106;
				half2 XZ_3500_g207106 = temp_output_475_0_g207106;
				half2 XY500_g207106 = temp_output_464_0_g207106;
				half2 XY_1500_g207106 = (Out_MaskF456_g207106).zw;
				half2 XY_2500_g207106 = (Out_MaskG456_g207106).xy;
				half2 XY_3500_g207106 = (Out_MaskG456_g207106).zw;
				half Bias500_g207106 = temp_output_510_0_g207106;
				half3 Weights_1500_g207106 = (Out_MaskH456_g207106).xyz;
				half3 Weights_2500_g207106 = temp_output_480_0_g207106;
				half3 Weights_3500_g207106 = (Out_MaskJ456_g207106).xyz;
				half3 Triplanar500_g207106 = temp_output_482_0_g207106;
				half3 NormalWS500_g207106 = temp_output_483_0_g207106;
				half3 Normal500_g207106 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207106 = SampleStochastic3D( Texture500_g207106 , Sampler500_g207106 , ZY500_g207106 , ZY_1500_g207106 , ZY_2500_g207106 , ZY_3500_g207106 , XZ500_g207106 , XZ_1500_g207106 , XZ_2500_g207106 , XZ_3500_g207106 , XY500_g207106 , XY_1500_g207106 , XY_2500_g207106 , XY_3500_g207106 , Bias500_g207106 , Weights_1500_g207106 , Weights_2500_g207106 , Weights_3500_g207106 , Triplanar500_g207106 , NormalWS500_g207106 , Normal500_g207106 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch359_g207086 = localSampleCoord276_g207106;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch359_g207086 = localSampleCoord502_g207106;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch359_g207086 = localSamplePlanar2D496_g207106;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch359_g207086 = localSamplePlanar3D490_g207106;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch359_g207086 = localSampleStochastic2D498_g207106;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch359_g207086 = localSampleStochastic3D500_g207106;
				#else
				float4 staticSwitch359_g207086 = localSampleCoord276_g207106;
				#endif
				half4 Local_SmoothnessTex365_g207086 = staticSwitch359_g207086;
				float4 temp_output_28_0_g251309 = Local_SmoothnessTex365_g207086;
				float3 temp_output_29_0_g251309 = (temp_output_28_0_g251309).xyz;
				half3 linRGB27_g251309 = temp_output_29_0_g251309;
				half3 localLinearToGammaFloatFast27_g251309 = LinearToGammaFloatFast( linRGB27_g251309 );
				#ifdef UNITY_COLORSPACE_GAMMA
				float3 staticSwitch26_g251309 = temp_output_29_0_g251309;
				#else
				float3 staticSwitch26_g251309 = localLinearToGammaFloatFast27_g251309;
				#endif
				float4 appendResult31_g251309 = (float4(staticSwitch26_g251309 , (temp_output_28_0_g251309).w));
				float4 lerpResult439_g207086 = lerp( Local_SmoothnessTex365_g207086 , appendResult31_g251309 , _MainSmoothnessTexGammaMode);
				float4 ChannelA83_g251307 = lerpResult439_g207086;
				float4 ChannelB83_g251307 = ( 1.0 - lerpResult439_g207086 );
				float localSwitchChannel883_g251307 = SwitchChannel8( Option83_g251307 , ChannelA83_g251307 , ChannelB83_g251307 );
				float lerpResult374_g207086 = lerp( (Local_ShaderTex199_g207086).w , localSwitchChannel883_g251307 , _MainSmoothnessSourceMode);
				float clampResult17_g251306 = clamp( lerpResult374_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251305 = _MainSmoothnessRemap.x;
				float temp_output_9_0_g251305 = ( clampResult17_g251306 - temp_output_7_0_g251305 );
				half Local_Smoothness317_g207086 = ( saturate( ( temp_output_9_0_g251305 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
				float4 appendResult73_g207086 = (float4(Local_Metallic322_g207086 , Local_Occlusion313_g207086 , 0.0 , Local_Smoothness317_g207086));
				half4 Local_Masks109_g207086 = appendResult73_g207086;
				float temp_output_17_0_g251304 = _MainMultiChannelMode;
				float Option83_g251304 = temp_output_17_0_g251304;
				TEXTURE2D(Texture276_g207104) = _MainMultiTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207105 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207104 = staticSwitch38_g207105;
				float localBreakTextureData456_g207104 = ( 0.0 );
				TVEMasksData Data456_g207104 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207104 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207104 , Out_MaskA456_g207104 , Out_MaskB456_g207104 , Out_MaskC456_g207104 , Out_MaskD456_g207104 , Out_MaskE456_g207104 , Out_MaskF456_g207104 , Out_MaskG456_g207104 , Out_MaskH456_g207104 , Out_MaskI456_g207104 , Out_MaskJ456_g207104 , Out_MaskK456_g207104 , Out_MaskL456_g207104 , Out_MaskM456_g207104 , Out_MaskN456_g207104 );
				half2 UV276_g207104 = (Out_MaskA456_g207104).xy;
				float temp_output_504_0_g207104 = 0.0;
				half Bias276_g207104 = temp_output_504_0_g207104;
				half2 Normal276_g207104 = float2( 0,0 );
				half4 localSampleCoord276_g207104 = SampleCoord( Texture276_g207104 , Sampler276_g207104 , UV276_g207104 , Bias276_g207104 , Normal276_g207104 );
				TEXTURE2D(Texture502_g207104) = _MainMultiTex;
				SamplerState Sampler502_g207104 = staticSwitch38_g207105;
				half2 UV502_g207104 = (Out_MaskA456_g207104).zw;
				half Bias502_g207104 = temp_output_504_0_g207104;
				half2 Normal502_g207104 = float2( 0,0 );
				half4 localSampleCoord502_g207104 = SampleCoord( Texture502_g207104 , Sampler502_g207104 , UV502_g207104 , Bias502_g207104 , Normal502_g207104 );
				TEXTURE2D(Texture496_g207104) = _MainMultiTex;
				SamplerState Sampler496_g207104 = staticSwitch38_g207105;
				float2 temp_output_463_0_g207104 = (Out_MaskB456_g207104).zw;
				half2 XZ496_g207104 = temp_output_463_0_g207104;
				half Bias496_g207104 = temp_output_504_0_g207104;
				float3 temp_output_483_0_g207104 = (Out_MaskK456_g207104).xyz;
				half3 NormalWS496_g207104 = temp_output_483_0_g207104;
				half3 Normal496_g207104 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207104 = SamplePlanar2D( Texture496_g207104 , Sampler496_g207104 , XZ496_g207104 , Bias496_g207104 , NormalWS496_g207104 , Normal496_g207104 );
				TEXTURE2D(Texture490_g207104) = _MainMultiTex;
				SamplerState Sampler490_g207104 = staticSwitch38_g207105;
				float2 temp_output_462_0_g207104 = (Out_MaskB456_g207104).xy;
				half2 ZY490_g207104 = temp_output_462_0_g207104;
				half2 XZ490_g207104 = temp_output_463_0_g207104;
				float2 temp_output_464_0_g207104 = (Out_MaskC456_g207104).xy;
				half2 XY490_g207104 = temp_output_464_0_g207104;
				half Bias490_g207104 = temp_output_504_0_g207104;
				float3 temp_output_482_0_g207104 = (Out_MaskN456_g207104).xyz;
				half3 Triplanar490_g207104 = temp_output_482_0_g207104;
				half3 NormalWS490_g207104 = temp_output_483_0_g207104;
				half3 Normal490_g207104 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207104 = SamplePlanar3D( Texture490_g207104 , Sampler490_g207104 , ZY490_g207104 , XZ490_g207104 , XY490_g207104 , Bias490_g207104 , Triplanar490_g207104 , NormalWS490_g207104 , Normal490_g207104 );
				TEXTURE2D(Texture498_g207104) = _MainMultiTex;
				SamplerState Sampler498_g207104 = staticSwitch38_g207105;
				half2 XZ498_g207104 = temp_output_463_0_g207104;
				float2 temp_output_473_0_g207104 = (Out_MaskE456_g207104).xy;
				half2 XZ_1498_g207104 = temp_output_473_0_g207104;
				float2 temp_output_474_0_g207104 = (Out_MaskE456_g207104).zw;
				half2 XZ_2498_g207104 = temp_output_474_0_g207104;
				float2 temp_output_475_0_g207104 = (Out_MaskF456_g207104).xy;
				half2 XZ_3498_g207104 = temp_output_475_0_g207104;
				float temp_output_510_0_g207104 = exp2( temp_output_504_0_g207104 );
				half Bias498_g207104 = temp_output_510_0_g207104;
				float3 temp_output_480_0_g207104 = (Out_MaskI456_g207104).xyz;
				half3 Weights_2498_g207104 = temp_output_480_0_g207104;
				half3 NormalWS498_g207104 = temp_output_483_0_g207104;
				half3 Normal498_g207104 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207104 = SampleStochastic2D( Texture498_g207104 , Sampler498_g207104 , XZ498_g207104 , XZ_1498_g207104 , XZ_2498_g207104 , XZ_3498_g207104 , Bias498_g207104 , Weights_2498_g207104 , NormalWS498_g207104 , Normal498_g207104 );
				TEXTURE2D(Texture500_g207104) = _MainMultiTex;
				SamplerState Sampler500_g207104 = staticSwitch38_g207105;
				half2 ZY500_g207104 = temp_output_462_0_g207104;
				half2 ZY_1500_g207104 = (Out_MaskC456_g207104).zw;
				half2 ZY_2500_g207104 = (Out_MaskD456_g207104).xy;
				half2 ZY_3500_g207104 = (Out_MaskD456_g207104).zw;
				half2 XZ500_g207104 = temp_output_463_0_g207104;
				half2 XZ_1500_g207104 = temp_output_473_0_g207104;
				half2 XZ_2500_g207104 = temp_output_474_0_g207104;
				half2 XZ_3500_g207104 = temp_output_475_0_g207104;
				half2 XY500_g207104 = temp_output_464_0_g207104;
				half2 XY_1500_g207104 = (Out_MaskF456_g207104).zw;
				half2 XY_2500_g207104 = (Out_MaskG456_g207104).xy;
				half2 XY_3500_g207104 = (Out_MaskG456_g207104).zw;
				half Bias500_g207104 = temp_output_510_0_g207104;
				half3 Weights_1500_g207104 = (Out_MaskH456_g207104).xyz;
				half3 Weights_2500_g207104 = temp_output_480_0_g207104;
				half3 Weights_3500_g207104 = (Out_MaskJ456_g207104).xyz;
				half3 Triplanar500_g207104 = temp_output_482_0_g207104;
				half3 NormalWS500_g207104 = temp_output_483_0_g207104;
				half3 Normal500_g207104 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207104 = SampleStochastic3D( Texture500_g207104 , Sampler500_g207104 , ZY500_g207104 , ZY_1500_g207104 , ZY_2500_g207104 , ZY_3500_g207104 , XZ500_g207104 , XZ_1500_g207104 , XZ_2500_g207104 , XZ_3500_g207104 , XY500_g207104 , XY_1500_g207104 , XY_2500_g207104 , XY_3500_g207104 , Bias500_g207104 , Weights_1500_g207104 , Weights_2500_g207104 , Weights_3500_g207104 , Triplanar500_g207104 , NormalWS500_g207104 , Normal500_g207104 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch351_g207086 = localSampleCoord276_g207104;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch351_g207086 = localSampleCoord502_g207104;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch351_g207086 = localSamplePlanar2D496_g207104;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch351_g207086 = localSamplePlanar3D490_g207104;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch351_g207086 = localSampleStochastic2D498_g207104;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch351_g207086 = localSampleStochastic3D500_g207104;
				#else
				float4 staticSwitch351_g207086 = localSampleCoord276_g207104;
				#endif
				half4 Local_MultiTex357_g207086 = staticSwitch351_g207086;
				float4 ChannelA83_g251304 = Local_MultiTex357_g207086;
				float4 ChannelB83_g251304 = ( 1.0 - Local_MultiTex357_g207086 );
				float localSwitchChannel883_g251304 = SwitchChannel8( Option83_g251304 , ChannelA83_g251304 , ChannelB83_g251304 );
				float lerpResult378_g207086 = lerp( (Local_Masks109_g207086).z , localSwitchChannel883_g251304 , _MainMultiSourceMode);
				float clampResult17_g251302 = clamp( lerpResult378_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251303 = _MainMultiRemap.x;
				float temp_output_9_0_g251303 = ( clampResult17_g251302 - temp_output_7_0_g251303 );
				half Local_MultiMask78_g207086 = ( saturate( ( temp_output_9_0_g251303 * _MainMultiRemap.z ) ) * _MainMultiVlaue );
				float lerpResult58_g207086 = lerp( 1.0 , Local_MultiMask78_g207086 , _MainColorMode);
				float4 lerpResult62_g207086 = lerp( _MainColorTwo , _MainColor , lerpResult58_g207086);
				half3 Local_ColorRGB93_g207086 = (lerpResult62_g207086).rgb;
				half3 Local_Albedo139_g207086 = ( Local_AlbedoRGB107_g207086 * Local_ColorRGB93_g207086 );
				float3 temp_output_4_0_g207088 = Local_Albedo139_g207086;
				float3 In_Albedo3_g207088 = temp_output_4_0_g207088;
				float3 temp_output_44_0_g207088 = Local_Albedo139_g207086;
				float3 In_AlbedoBase3_g207088 = temp_output_44_0_g207088;
				TEXTURE2D(Texture276_g207094) = _MainNormalTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch37_g207095 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207094 = staticSwitch37_g207095;
				float localBreakTextureData456_g207094 = ( 0.0 );
				TVEMasksData Data456_g207094 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207094 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207094 , Out_MaskA456_g207094 , Out_MaskB456_g207094 , Out_MaskC456_g207094 , Out_MaskD456_g207094 , Out_MaskE456_g207094 , Out_MaskF456_g207094 , Out_MaskG456_g207094 , Out_MaskH456_g207094 , Out_MaskI456_g207094 , Out_MaskJ456_g207094 , Out_MaskK456_g207094 , Out_MaskL456_g207094 , Out_MaskM456_g207094 , Out_MaskN456_g207094 );
				half2 UV276_g207094 = (Out_MaskA456_g207094).xy;
				float temp_output_504_0_g207094 = 0.0;
				half Bias276_g207094 = temp_output_504_0_g207094;
				half2 Normal276_g207094 = float2( 0,0 );
				half4 localSampleCoord276_g207094 = SampleCoord( Texture276_g207094 , Sampler276_g207094 , UV276_g207094 , Bias276_g207094 , Normal276_g207094 );
				TEXTURE2D(Texture502_g207094) = _MainNormalTex;
				SamplerState Sampler502_g207094 = staticSwitch37_g207095;
				half2 UV502_g207094 = (Out_MaskA456_g207094).zw;
				half Bias502_g207094 = temp_output_504_0_g207094;
				half2 Normal502_g207094 = float2( 0,0 );
				half4 localSampleCoord502_g207094 = SampleCoord( Texture502_g207094 , Sampler502_g207094 , UV502_g207094 , Bias502_g207094 , Normal502_g207094 );
				TEXTURE2D(Texture496_g207094) = _MainNormalTex;
				SamplerState Sampler496_g207094 = staticSwitch37_g207095;
				float2 temp_output_463_0_g207094 = (Out_MaskB456_g207094).zw;
				half2 XZ496_g207094 = temp_output_463_0_g207094;
				half Bias496_g207094 = temp_output_504_0_g207094;
				float3 temp_output_483_0_g207094 = (Out_MaskK456_g207094).xyz;
				half3 NormalWS496_g207094 = temp_output_483_0_g207094;
				half3 Normal496_g207094 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207094 = SamplePlanar2D( Texture496_g207094 , Sampler496_g207094 , XZ496_g207094 , Bias496_g207094 , NormalWS496_g207094 , Normal496_g207094 );
				TEXTURE2D(Texture490_g207094) = _MainNormalTex;
				SamplerState Sampler490_g207094 = staticSwitch37_g207095;
				float2 temp_output_462_0_g207094 = (Out_MaskB456_g207094).xy;
				half2 ZY490_g207094 = temp_output_462_0_g207094;
				half2 XZ490_g207094 = temp_output_463_0_g207094;
				float2 temp_output_464_0_g207094 = (Out_MaskC456_g207094).xy;
				half2 XY490_g207094 = temp_output_464_0_g207094;
				half Bias490_g207094 = temp_output_504_0_g207094;
				float3 temp_output_482_0_g207094 = (Out_MaskN456_g207094).xyz;
				half3 Triplanar490_g207094 = temp_output_482_0_g207094;
				half3 NormalWS490_g207094 = temp_output_483_0_g207094;
				half3 Normal490_g207094 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207094 = SamplePlanar3D( Texture490_g207094 , Sampler490_g207094 , ZY490_g207094 , XZ490_g207094 , XY490_g207094 , Bias490_g207094 , Triplanar490_g207094 , NormalWS490_g207094 , Normal490_g207094 );
				TEXTURE2D(Texture498_g207094) = _MainNormalTex;
				SamplerState Sampler498_g207094 = staticSwitch37_g207095;
				half2 XZ498_g207094 = temp_output_463_0_g207094;
				float2 temp_output_473_0_g207094 = (Out_MaskE456_g207094).xy;
				half2 XZ_1498_g207094 = temp_output_473_0_g207094;
				float2 temp_output_474_0_g207094 = (Out_MaskE456_g207094).zw;
				half2 XZ_2498_g207094 = temp_output_474_0_g207094;
				float2 temp_output_475_0_g207094 = (Out_MaskF456_g207094).xy;
				half2 XZ_3498_g207094 = temp_output_475_0_g207094;
				float temp_output_510_0_g207094 = exp2( temp_output_504_0_g207094 );
				half Bias498_g207094 = temp_output_510_0_g207094;
				float3 temp_output_480_0_g207094 = (Out_MaskI456_g207094).xyz;
				half3 Weights_2498_g207094 = temp_output_480_0_g207094;
				half3 NormalWS498_g207094 = temp_output_483_0_g207094;
				half3 Normal498_g207094 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207094 = SampleStochastic2D( Texture498_g207094 , Sampler498_g207094 , XZ498_g207094 , XZ_1498_g207094 , XZ_2498_g207094 , XZ_3498_g207094 , Bias498_g207094 , Weights_2498_g207094 , NormalWS498_g207094 , Normal498_g207094 );
				TEXTURE2D(Texture500_g207094) = _MainNormalTex;
				SamplerState Sampler500_g207094 = staticSwitch37_g207095;
				half2 ZY500_g207094 = temp_output_462_0_g207094;
				half2 ZY_1500_g207094 = (Out_MaskC456_g207094).zw;
				half2 ZY_2500_g207094 = (Out_MaskD456_g207094).xy;
				half2 ZY_3500_g207094 = (Out_MaskD456_g207094).zw;
				half2 XZ500_g207094 = temp_output_463_0_g207094;
				half2 XZ_1500_g207094 = temp_output_473_0_g207094;
				half2 XZ_2500_g207094 = temp_output_474_0_g207094;
				half2 XZ_3500_g207094 = temp_output_475_0_g207094;
				half2 XY500_g207094 = temp_output_464_0_g207094;
				half2 XY_1500_g207094 = (Out_MaskF456_g207094).zw;
				half2 XY_2500_g207094 = (Out_MaskG456_g207094).xy;
				half2 XY_3500_g207094 = (Out_MaskG456_g207094).zw;
				half Bias500_g207094 = temp_output_510_0_g207094;
				half3 Weights_1500_g207094 = (Out_MaskH456_g207094).xyz;
				half3 Weights_2500_g207094 = temp_output_480_0_g207094;
				half3 Weights_3500_g207094 = (Out_MaskJ456_g207094).xyz;
				half3 Triplanar500_g207094 = temp_output_482_0_g207094;
				half3 NormalWS500_g207094 = temp_output_483_0_g207094;
				half3 Normal500_g207094 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207094 = SampleStochastic3D( Texture500_g207094 , Sampler500_g207094 , ZY500_g207094 , ZY_1500_g207094 , ZY_2500_g207094 , ZY_3500_g207094 , XZ500_g207094 , XZ_1500_g207094 , XZ_2500_g207094 , XZ_3500_g207094 , XY500_g207094 , XY_1500_g207094 , XY_2500_g207094 , XY_3500_g207094 , Bias500_g207094 , Weights_1500_g207094 , Weights_2500_g207094 , Weights_3500_g207094 , Triplanar500_g207094 , NormalWS500_g207094 , Normal500_g207094 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch193_g207086 = localSampleCoord276_g207094;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch193_g207086 = localSampleCoord502_g207094;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch193_g207086 = localSamplePlanar2D496_g207094;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch193_g207086 = localSamplePlanar3D490_g207094;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch193_g207086 = localSampleStochastic2D498_g207094;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch193_g207086 = localSampleStochastic3D500_g207094;
				#else
				float4 staticSwitch193_g207086 = localSampleCoord276_g207094;
				#endif
				half4 Local_NormaTex191_g207086 = staticSwitch193_g207086;
				half4 Normal_Packed45_g207089 = Local_NormaTex191_g207086;
				float2 appendResult58_g207089 = (float2(( (Normal_Packed45_g207089).x * (Normal_Packed45_g207089).w ) , (Normal_Packed45_g207089).y));
				half2 Normal_Default50_g207089 = appendResult58_g207089;
				half2 Normal_ASTC41_g207089 = (Normal_Packed45_g207089).xy;
				#ifdef UNITY_ASTC_NORMALMAP_ENCODING
				float2 staticSwitch38_g207089 = Normal_ASTC41_g207089;
				#else
				float2 staticSwitch38_g207089 = Normal_Default50_g207089;
				#endif
				half2 Normal_NO_DTX544_g207089 = (Normal_Packed45_g207089).wy;
				#ifdef UNITY_NO_DXT5nm
				float2 staticSwitch37_g207089 = Normal_NO_DTX544_g207089;
				#else
				float2 staticSwitch37_g207089 = staticSwitch38_g207089;
				#endif
				float2 temp_output_26_0_g207086 = ( (staticSwitch37_g207089*2.0 + -1.0) * _MainNormalValue );
				float3x3 ase_worldToTangent = float3x3( ase_tangentWS, ase_bitangentWS, ase_normalWS );
				half2 Normal_Planar45_g207090 = temp_output_26_0_g207086;
				float2 break71_g207090 = Normal_Planar45_g207090;
				float3 appendResult72_g207090 = (float3(break71_g207090.x , 0.0 , break71_g207090.y));
				float2 temp_output_205_0_g207086 = (mul( ase_worldToTangent, appendResult72_g207090 )).xy;
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#else
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#endif
				half2 Local_NormalTS108_g207086 = staticSwitch204_g207086;
				float2 In_NormalTS3_g207088 = Local_NormalTS108_g207086;
				float3 appendResult68_g207091 = (float3(Local_NormalTS108_g207086 , 1.0));
				float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
				float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
				float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
				float3 tanNormal74_g207091 = appendResult68_g207091;
				float3 worldNormal74_g207091 = normalize( float3( dot( tanToWorld0, tanNormal74_g207091 ), dot( tanToWorld1, tanNormal74_g207091 ), dot( tanToWorld2, tanNormal74_g207091 ) ) );
				half3 Local_NormalWS250_g207086 = worldNormal74_g207091;
				float3 In_NormalWS3_g207088 = Local_NormalWS250_g207086;
				float4 In_Shader3_g207088 = Local_Masks109_g207086;
				float4 In_Feature3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Season3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Emissive3_g207088 = half4( 1, 1, 1, 1 );
				float3 temp_output_3_0_g207092 = Local_Albedo139_g207086;
				float dotResult20_g207092 = dot( temp_output_3_0_g207092 , float3( 0.2126, 0.7152, 0.0722 ) );
				half Local_Grayscale110_g207086 = dotResult20_g207092;
				float temp_output_12_0_g207088 = Local_Grayscale110_g207086;
				float In_Grayscale3_g207088 = temp_output_12_0_g207088;
				float clampResult144_g207086 = clamp( saturate( ( Local_Grayscale110_g207086 * 5.0 ) ) , 0.2 , 1.0 );
				half Local_Luminosity145_g207086 = clampResult144_g207086;
				float temp_output_16_0_g207088 = Local_Luminosity145_g207086;
				float In_Luminosity3_g207088 = temp_output_16_0_g207088;
				float In_MultiMask3_g207088 = Local_MultiMask78_g207086;
				float temp_output_17_0_g251310 = _MainAlphaChannelMode;
				float Option83_g251310 = temp_output_17_0_g251310;
				TEXTURE2D(Texture276_g207099) = _MainAlphaTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g207100 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g207099 = staticSwitch36_g207100;
				float localBreakTextureData456_g207099 = ( 0.0 );
				TVEMasksData Data456_g207099 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207099 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207099 , Out_MaskA456_g207099 , Out_MaskB456_g207099 , Out_MaskC456_g207099 , Out_MaskD456_g207099 , Out_MaskE456_g207099 , Out_MaskF456_g207099 , Out_MaskG456_g207099 , Out_MaskH456_g207099 , Out_MaskI456_g207099 , Out_MaskJ456_g207099 , Out_MaskK456_g207099 , Out_MaskL456_g207099 , Out_MaskM456_g207099 , Out_MaskN456_g207099 );
				half2 UV276_g207099 = (Out_MaskA456_g207099).xy;
				float temp_output_504_0_g207099 = 0.0;
				half Bias276_g207099 = temp_output_504_0_g207099;
				half2 Normal276_g207099 = float2( 0,0 );
				half4 localSampleCoord276_g207099 = SampleCoord( Texture276_g207099 , Sampler276_g207099 , UV276_g207099 , Bias276_g207099 , Normal276_g207099 );
				TEXTURE2D(Texture502_g207099) = _MainAlphaTex;
				SamplerState Sampler502_g207099 = staticSwitch36_g207100;
				half2 UV502_g207099 = (Out_MaskA456_g207099).zw;
				half Bias502_g207099 = temp_output_504_0_g207099;
				half2 Normal502_g207099 = float2( 0,0 );
				half4 localSampleCoord502_g207099 = SampleCoord( Texture502_g207099 , Sampler502_g207099 , UV502_g207099 , Bias502_g207099 , Normal502_g207099 );
				TEXTURE2D(Texture496_g207099) = _MainAlphaTex;
				SamplerState Sampler496_g207099 = staticSwitch36_g207100;
				float2 temp_output_463_0_g207099 = (Out_MaskB456_g207099).zw;
				half2 XZ496_g207099 = temp_output_463_0_g207099;
				half Bias496_g207099 = temp_output_504_0_g207099;
				float3 temp_output_483_0_g207099 = (Out_MaskK456_g207099).xyz;
				half3 NormalWS496_g207099 = temp_output_483_0_g207099;
				half3 Normal496_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207099 = SamplePlanar2D( Texture496_g207099 , Sampler496_g207099 , XZ496_g207099 , Bias496_g207099 , NormalWS496_g207099 , Normal496_g207099 );
				TEXTURE2D(Texture490_g207099) = _MainAlphaTex;
				SamplerState Sampler490_g207099 = staticSwitch36_g207100;
				float2 temp_output_462_0_g207099 = (Out_MaskB456_g207099).xy;
				half2 ZY490_g207099 = temp_output_462_0_g207099;
				half2 XZ490_g207099 = temp_output_463_0_g207099;
				float2 temp_output_464_0_g207099 = (Out_MaskC456_g207099).xy;
				half2 XY490_g207099 = temp_output_464_0_g207099;
				half Bias490_g207099 = temp_output_504_0_g207099;
				float3 temp_output_482_0_g207099 = (Out_MaskN456_g207099).xyz;
				half3 Triplanar490_g207099 = temp_output_482_0_g207099;
				half3 NormalWS490_g207099 = temp_output_483_0_g207099;
				half3 Normal490_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207099 = SamplePlanar3D( Texture490_g207099 , Sampler490_g207099 , ZY490_g207099 , XZ490_g207099 , XY490_g207099 , Bias490_g207099 , Triplanar490_g207099 , NormalWS490_g207099 , Normal490_g207099 );
				TEXTURE2D(Texture498_g207099) = _MainAlphaTex;
				SamplerState Sampler498_g207099 = staticSwitch36_g207100;
				half2 XZ498_g207099 = temp_output_463_0_g207099;
				float2 temp_output_473_0_g207099 = (Out_MaskE456_g207099).xy;
				half2 XZ_1498_g207099 = temp_output_473_0_g207099;
				float2 temp_output_474_0_g207099 = (Out_MaskE456_g207099).zw;
				half2 XZ_2498_g207099 = temp_output_474_0_g207099;
				float2 temp_output_475_0_g207099 = (Out_MaskF456_g207099).xy;
				half2 XZ_3498_g207099 = temp_output_475_0_g207099;
				float temp_output_510_0_g207099 = exp2( temp_output_504_0_g207099 );
				half Bias498_g207099 = temp_output_510_0_g207099;
				float3 temp_output_480_0_g207099 = (Out_MaskI456_g207099).xyz;
				half3 Weights_2498_g207099 = temp_output_480_0_g207099;
				half3 NormalWS498_g207099 = temp_output_483_0_g207099;
				half3 Normal498_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207099 = SampleStochastic2D( Texture498_g207099 , Sampler498_g207099 , XZ498_g207099 , XZ_1498_g207099 , XZ_2498_g207099 , XZ_3498_g207099 , Bias498_g207099 , Weights_2498_g207099 , NormalWS498_g207099 , Normal498_g207099 );
				TEXTURE2D(Texture500_g207099) = _MainAlphaTex;
				SamplerState Sampler500_g207099 = staticSwitch36_g207100;
				half2 ZY500_g207099 = temp_output_462_0_g207099;
				half2 ZY_1500_g207099 = (Out_MaskC456_g207099).zw;
				half2 ZY_2500_g207099 = (Out_MaskD456_g207099).xy;
				half2 ZY_3500_g207099 = (Out_MaskD456_g207099).zw;
				half2 XZ500_g207099 = temp_output_463_0_g207099;
				half2 XZ_1500_g207099 = temp_output_473_0_g207099;
				half2 XZ_2500_g207099 = temp_output_474_0_g207099;
				half2 XZ_3500_g207099 = temp_output_475_0_g207099;
				half2 XY500_g207099 = temp_output_464_0_g207099;
				half2 XY_1500_g207099 = (Out_MaskF456_g207099).zw;
				half2 XY_2500_g207099 = (Out_MaskG456_g207099).xy;
				half2 XY_3500_g207099 = (Out_MaskG456_g207099).zw;
				half Bias500_g207099 = temp_output_510_0_g207099;
				half3 Weights_1500_g207099 = (Out_MaskH456_g207099).xyz;
				half3 Weights_2500_g207099 = temp_output_480_0_g207099;
				half3 Weights_3500_g207099 = (Out_MaskJ456_g207099).xyz;
				half3 Triplanar500_g207099 = temp_output_482_0_g207099;
				half3 NormalWS500_g207099 = temp_output_483_0_g207099;
				half3 Normal500_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207099 = SampleStochastic3D( Texture500_g207099 , Sampler500_g207099 , ZY500_g207099 , ZY_1500_g207099 , ZY_2500_g207099 , ZY_3500_g207099 , XZ500_g207099 , XZ_1500_g207099 , XZ_2500_g207099 , XZ_3500_g207099 , XY500_g207099 , XY_1500_g207099 , XY_2500_g207099 , XY_3500_g207099 , Bias500_g207099 , Weights_1500_g207099 , Weights_2500_g207099 , Weights_3500_g207099 , Triplanar500_g207099 , NormalWS500_g207099 , Normal500_g207099 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch327_g207086 = localSampleCoord276_g207099;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch327_g207086 = localSampleCoord502_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch327_g207086 = localSamplePlanar2D496_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch327_g207086 = localSamplePlanar3D490_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch327_g207086 = localSampleStochastic2D498_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch327_g207086 = localSampleStochastic3D500_g207099;
				#else
				float4 staticSwitch327_g207086 = localSampleCoord276_g207099;
				#endif
				half4 Local_AlphaTex330_g207086 = staticSwitch327_g207086;
				float4 temp_output_28_0_g251311 = Local_AlphaTex330_g207086;
				float3 temp_output_29_0_g251311 = (temp_output_28_0_g251311).xyz;
				half3 linRGB27_g251311 = temp_output_29_0_g251311;
				half3 localLinearToGammaFloatFast27_g251311 = LinearToGammaFloatFast( linRGB27_g251311 );
				#ifdef UNITY_COLORSPACE_GAMMA
				float3 staticSwitch26_g251311 = temp_output_29_0_g251311;
				#else
				float3 staticSwitch26_g251311 = localLinearToGammaFloatFast27_g251311;
				#endif
				float4 appendResult31_g251311 = (float4(staticSwitch26_g251311 , (temp_output_28_0_g251311).w));
				float4 lerpResult442_g207086 = lerp( Local_AlphaTex330_g207086 , appendResult31_g251311 , _MainAlphaTexIsGamma);
				float4 ChannelA83_g251310 = lerpResult442_g207086;
				float4 ChannelB83_g251310 = ( 1.0 - lerpResult442_g207086 );
				float localSwitchChannel883_g251310 = SwitchChannel8( Option83_g251310 , ChannelA83_g251310 , ChannelB83_g251310 );
				float lerpResult385_g207086 = lerp( (Local_AlbedoTex185_g207086).w , localSwitchChannel883_g251310 , _MainAlphaSourceMode);
				#ifdef TVE_CLIPPING
				float staticSwitch236_g207086 = ( lerpResult385_g207086 - _MainAlphaClipValue );
				#else
				float staticSwitch236_g207086 = lerpResult385_g207086;
				#endif
				half Local_AlphaClip111_g207086 = staticSwitch236_g207086;
				float In_AlphaClip3_g207088 = Local_AlphaClip111_g207086;
				half Local_AlphaFade246_g207086 = (lerpResult62_g207086).a;
				float In_AlphaFade3_g207088 = Local_AlphaFade246_g207086;
				float3 temp_cast_10 = (1.0).xxx;
				float3 In_Translucency3_g207088 = temp_cast_10;
				float In_Transmission3_g207088 = 1.0;
				float In_Thickness3_g207088 = 0.0;
				float In_Diffusion3_g207088 = 0.0;
				float In_Depth3_g207088 = 0.0;
				BuildVisualData( Data3_g207088 , In_Dummy3_g207088 , In_Albedo3_g207088 , In_AlbedoBase3_g207088 , In_NormalTS3_g207088 , In_NormalWS3_g207088 , In_Shader3_g207088 , In_Feature3_g207088 , In_Season3_g207088 , In_Emissive3_g207088 , In_Grayscale3_g207088 , In_Luminosity3_g207088 , In_MultiMask3_g207088 , In_AlphaClip3_g207088 , In_AlphaFade3_g207088 , In_Translucency3_g207088 , In_Transmission3_g207088 , In_Thickness3_g207088 , In_Diffusion3_g207088 , In_Depth3_g207088 );
				TVEVisualData Data4_g251314 =(TVEVisualData)Data3_g207088;
				float Out_Dummy4_g251314 = 0.0;
				float3 Out_Albedo4_g251314 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g251314 = float3( 0,0,0 );
				float2 Out_NormalTS4_g251314 = float2( 0,0 );
				float3 Out_NormalWS4_g251314 = float3( 0,0,0 );
				float4 Out_Shader4_g251314 = float4( 0,0,0,0 );
				float4 Out_Feature4_g251314 = float4( 0,0,0,0 );
				float4 Out_Season4_g251314 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g251314 = float4( 0,0,0,0 );
				float Out_MultiMask4_g251314 = 0.0;
				float Out_Grayscale4_g251314 = 0.0;
				float Out_Luminosity4_g251314 = 0.0;
				float Out_AlphaClip4_g251314 = 0.0;
				float Out_AlphaFade4_g251314 = 0.0;
				float3 Out_Translucency4_g251314 = float3( 0,0,0 );
				float Out_Transmission4_g251314 = 0.0;
				float Out_Thickness4_g251314 = 0.0;
				float Out_Diffusion4_g251314 = 0.0;
				float Out_Depth4_g251314 = 0.0;
				BreakVisualData( Data4_g251314 , Out_Dummy4_g251314 , Out_Albedo4_g251314 , Out_AlbedoBase4_g251314 , Out_NormalTS4_g251314 , Out_NormalWS4_g251314 , Out_Shader4_g251314 , Out_Feature4_g251314 , Out_Season4_g251314 , Out_Emissive4_g251314 , Out_MultiMask4_g251314 , Out_Grayscale4_g251314 , Out_Luminosity4_g251314 , Out_AlphaClip4_g251314 , Out_AlphaFade4_g251314 , Out_Translucency4_g251314 , Out_Transmission4_g251314 , Out_Thickness4_g251314 , Out_Diffusion4_g251314 , Out_Depth4_g251314 );
				half3 Input_Albedo24_g251315 = Out_Albedo4_g251314;
				#ifdef UNITY_COLORSPACE_GAMMA
				float4 staticSwitch22_g251315 = half4( 0.2209163, 0.2209163, 0.2209163, 0.7790837 );
				#else
				float4 staticSwitch22_g251315 = half4( 0.04, 0.04, 0.04, 0.96 );
				#endif
				half4 ColorSpaceDielectricSpec23_g251315 = staticSwitch22_g251315;
				float4 break24_g251313 = Out_Shader4_g251314;
				half Metallic95_g251313 = break24_g251313.x;
				half Input_Metallic25_g251315 = Metallic95_g251313;
				half OneMinusReflectivity31_g251315 = ( (ColorSpaceDielectricSpec23_g251315).w - ( (ColorSpaceDielectricSpec23_g251315).w * Input_Metallic25_g251315 ) );
				float3 temp_output_6_0_g251331 = ( Input_Albedo24_g251315 * OneMinusReflectivity31_g251315 );
				half Render_Common200_g251313 = ( _RenderCull + _RenderZWrite + _RenderQueue + _RenderPriority + _RenderBakeGI + _RenderNormal + _RenderFilter + _RenderClip + _DisableSRPBatcher );
				half Render_Motion186_g251313 = _RenderMotion;
				half Render_URPOnly190_g251313 = ( _RenderShadow + _RenderMotionXR + _RenderGBuffer + Render_Motion186_g251313 );
				half Render_Pipeline184_g251313 = ( Render_Common200_g251313 + Render_URPOnly190_g251313 );
				float temp_output_7_0_g251331 = Render_Pipeline184_g251313;
				float temp_output_17_0_g251331 = ( temp_output_7_0_g251331 + 0.0 );
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g251331 = ( temp_output_6_0_g251331 + temp_output_17_0_g251331 );
				#else
				float3 staticSwitch14_g251331 = temp_output_6_0_g251331;
				#endif
				

				float3 BaseColor = staticSwitch14_g251331;
				float3 Emission = 0;
				float Alpha = 1;
				#if defined( _ALPHATEST_ON )
					float AlphaClipThreshold = _Cutoff;
				#endif

				#if defined( _ALPHATEST_ON )
					AlphaDiscard( Alpha, AlphaClipThreshold );
				#endif

				MetaInput metaInput = (MetaInput)0;
				metaInput.Albedo = BaseColor;
				metaInput.Emission = Emission;
				#ifdef EDITOR_VISUALIZATION
					metaInput.VizUV = input.VizUV.xy;
					metaInput.LightCoord = input.LightCoord;
				#endif

				return UnityMetaFragment(metaInput);
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Universal2D"
			Tags { "LightMode"="Universal2D" }

			Blend One Zero, One Zero
			ZWrite [_render_zw]
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			HLSLPROGRAM

			#define ASE_GEOMETRY
			#define ASE_OPAQUE_KEEP_ALPHA
			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#define _NORMALMAP 1
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION 170300
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#if defined( _SPECULAR_SETUP ) && defined( ASE_LIGHTING_SIMPLE )
				#if defined( _SPECULARHIGHLIGHTS_OFF )
					#undef _SPECULAR_COLOR
				#else
					#define _SPECULAR_COLOR
				#endif
			#endif

			#define SHADERPASS SHADERPASS_2D

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
			#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
			#pragma shader_feature_local_fragment TVE_CLIPPING
			#if defined (TVE_CLIPPING) //Render Clip
				#define TVE_ALPHA_CLIP //Render Clip
			#endif //Render Clip
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END
			  
			struct TVEVisualData
			{  
				half Dummy;  
				half3 Albedo;
				half3 AlbedoBase;
				half2 NormalTS;
				half3 NormalWS; 
				half4 Shader;
				half4 Feature;
				half4 Season;
				float4 Emissive;
				half AlphaClip;
				half AlphaFade;
				half MultiMask;
				half Grayscale;
				half Luminosity;
				float3 Translucency;
				half Transmission;
				half Thickness;
				float Diffusion;
				float Depth;
			};  
			    
			struct TVEModelData
			{    
				half Dummy;    
				float3 PositionOS;
				float3 PositionWS;
				float3 PositionWO;
				float3 PositionRawOS;
				float3 PivotOS;
				float3 PivotWS;
				float3 PivotWO;
				half3 NormalOS;
				half3 NormalWS;
				half3 NormalRawOS;
				half4 TangentOS;
				half3 TangentWS;
				half3 BitangentWS;
				half3 TriplanarWeights;
				half3 ViewDirWS;
				float4 CoordsData;
				half4 VertexData;
				half4 MasksData;   
				half4 PhaseData;
				half4 TransformData;
				half4 RotationData;
				float4 InterpolatorA;
			};    
			      
			struct TVEGlobalData
			{      
				half Dummy;      
				half4 CoatParams;
				half4 CoatTexture;
				half4 PaintParams;
				half4 PaintTexture;
				half4 AtmoParams;
				half4 AtmoTexture;
				half4 GlowParams;
				half4 GlowTexture;
				float4 FormParams;
				float4 FormTexture;
				half4 FlowParams;
				half4 FlowTexture;
			};      
			        
			struct TVEMasksData
			{        
				half4 MaskA;
				half4 MaskB;
				half4 MaskC;
				half4 MaskD;
				half4 MaskE;
				half4 MaskF;
				half4 MaskG;
				half4 MaskH;
				half4 MaskI;
				half4 MaskJ;
				half4 MaskK;
				half4 MaskL;
				half4 MaskM;
				half4 MaskN;
			};        
			#define TVE_GEOMETRY_SHADER


			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			half4 _MainOcclusionRemap;
			half4 _MainColor;
			half4 _MainColorTwo;
			half4 _MainMultiRemap;
			half4 _main_coord_value;
			half4 _MainSmoothnessRemap;
			half4 _MainCoordValue;
			half3 _render_normal;
			half _MainMultiVlaue;
			half _MainMultiSourceMode;
			half _MainMultiChannelMode;
			half _MainSmoothnessSourceMode;
			half _MainColorMode;
			float _MainSmoothnessTexGammaMode;
			half _MainSmoothnessChannelMode;
			half _MainOcclusionValue;
			half _MainSmoothnessValue;
			half _render_src;
			half _MainNormalValue;
			float _MainAlphaTexIsGamma;
			half _RenderMotion;
			half _RenderGBuffer;
			half _RenderMotionXR;
			half _RenderShadow;
			half _RenderClip;
			half _RenderFilter;
			half _MainAlphaChannelMode;
			half _RenderNormal;
			half _RenderPriority;
			half _RenderQueue;
			half _RenderZWrite;
			half _RenderCull;
			half _MainAlphaClipValue;
			half _MainAlphaSourceMode;
			half _RenderBakeGI;
			half _MainOcclusionSourceMode;
			half _MainMetallicSourceMode;
			half _MainMetallicValue;
			half _render_cull;
			half _render_dst;
			half _render_zw;
			half _render_coverage;
			half _IsGeneralShader;
			half _RenderEnd;
			half _IsVersion;
			half _IsTVEShader;
			half _IsLightingType;
			half _IsCustomShader;
			half _IsCollected;
			half _IsConverted;
			half _IsIdentifier;
			half _MainOcclusionChannelMode;
			half _IsShared;
			half _IsShaderType;
			half _IsObjectType;
			half _RenderCategory;
			half _IsStandardShader;
			half _MainCategory;
			half _MainEnd;
			half _MainSampleMode;
			half _MainCoordMode;
			half _MainMultiMaskInfo;
			half _MainSmoothnessInfo;
			half _ObjectPhaseMode;
			half _MainAlbedoValue;
			half _MainMetallicChannelMode;
			half _UseExternalSettings;
			half _RenderSpecular;
			float _AlphaClip;
			float _Cutoff;
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
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_Linear_Repeat_Aniso8);
			SAMPLER(sampler_Point_Repeat);
			SAMPLER(sampler_Linear_Repeat);
			float3 TVE_WorldOrigin;
			TEXTURE2D(_MainShaderTex);
			TEXTURE2D(_MainMetallicTex);
			TEXTURE2D(_MainOcclusionTex);
			TEXTURE2D(_MainSmoothnessTex);
			TEXTURE2D(_MainMultiTex);
			TEXTURE2D(_MainNormalTex);
			TEXTURE2D(_MainAlphaTex);
			half _DisableSRPBatcher;


			half3 ComputeTriplanarWeights( half3 NormalWS )
			{
				half3 powNormal = abs( NormalWS );
				half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
				tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
				return tempWeights;
			}
			
			float SwitchChannel4( half Option, half4 Channel )
			{
				switch (Option) {
					default:
				                case 0:
						return Channel.x;
					case 1:
						return Channel.y;
					case 2:
						return Channel.z;
					case 3:
						return Channel.w;
				}
			}
			
			void BuildModelFragData( out TVEModelData Data, half In_Dummy, float3 In_PositionWS, float3 In_PositionWO, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalWS, half3 In_TangentWS, half3 In_BitangentWS, half3 In_TriplanarWeights, half3 In_ViewDirWS, half4 In_CoordsData, half4 In_VertexData, half4 In_PhaseData )
			{
				Data = (TVEModelData)0;
				Data.Dummy = In_Dummy;
				Data.PositionWS = In_PositionWS;
				Data.PositionWO = In_PositionWO;
				Data.PivotWS = In_PivotWS;
				Data.PivotWO = In_PivotWO;
				Data.NormalWS = In_NormalWS;
				Data.TangentWS = In_TangentWS;
				Data.BitangentWS = In_BitangentWS;
				Data.TriplanarWeights = In_TriplanarWeights;
				Data.ViewDirWS = In_ViewDirWS;
				Data.CoordsData = In_CoordsData;
				Data.VertexData = In_VertexData;
				Data.PhaseData = In_PhaseData;
				return;
			}
			
			void BreakModelFragData( inout TVEModelData Data, out half Out_Dummy, out float3 Out_PositionWS, out float3 Out_PositionWO, out float3 Out_PivotWS, out float3 Out_PivotWO, out half3 Out_NormalWS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_TriplanarWeights, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_PhaseData )
			{
				Out_Dummy = Data.Dummy;
				Out_PositionWS = Data.PositionWS;
				Out_PositionWO = Data.PositionWO;
				Out_PivotWS = Data.PivotWS;
				Out_PivotWO = Data.PivotWO;
				Out_NormalWS = Data.NormalWS;
				Out_TangentWS = Data.TangentWS;
				Out_BitangentWS = Data.BitangentWS;
				Out_TriplanarWeights = Data.TriplanarWeights;
				Out_ViewDirWS = Data.ViewDirWS;
				Out_CoordsData = Data.CoordsData;
				Out_VertexData = Data.VertexData;
				Out_PhaseData = Data.PhaseData;
				return;
			}
			
			void ComputeMeshCoords( float4 Coords, float4 MeshCoords, out float2 UV0, out float2 UV3 )
			{
				UV0 = MeshCoords.xy * Coords.xy - Coords.zw; 
				UV3 = MeshCoords.zw * Coords.xy - Coords.zw; 
				return;
			}
			
			void ComputeWorldCoords( float4 Coords, float3 PositionWS, out float2 ZY, out float2 XZ, out float2 XY )
			{
				ZY = PositionWS.zy * Coords.xy - Coords.zw; 
				XZ = PositionWS.xz * Coords.xx - Coords.zz;
				XY = PositionWS.xy * Coords.xy - Coords.zw;
				return;
			}
			
			float2 ComputeStochasticHash22( float2 p )
			{
				float3 p3 = frac(float3(p.xyx) * float3(.1031, .1030, .0973));
				p3 += dot(p3, p3.yzx+33.33);
				return frac((p3.xx+p3.yz)*p3.zy);
			}
			
			void ComputeStochasticCoords( inout float2 UV, out float2 UV1, out float2 UV2, out float2 UV3, out float3 Weights )
			{
				half2 vertex1, vertex2, vertex3;
				// Scaling of the input
				half2 uv = UV * 3.464; // 2 * sqrt (3)
				// Skew input space into simplex triangle grid
				const float2x2 gridToSkewedGrid = float2x2( 1.0, 0.0, -0.57735027, 1.15470054 );
				half2 skewedCoord = mul( gridToSkewedGrid, uv );
				// Compute local triangle vertex IDs and local barycentric coordinates
				int2 baseId = int2( floor( skewedCoord ) );
				half3 temp = half3( frac( skewedCoord ), 0 );
				temp.z = 1.0 - temp.x - temp.y;
				if ( temp.z > 0.0 )
				{
					Weights.x = temp.z;
					Weights.y = temp.y;
					Weights.z = temp.x;
					vertex1 = baseId;
					vertex2 = baseId + int2( 0, 1 );
					vertex3 = baseId + int2( 1, 0 );
				}
				else
				{
					Weights.x = -temp.z;
					Weights.y = 1.0 - temp.y;
					Weights.z = 1.0 - temp.x;
					vertex1 = baseId + int2( 1, 1 );
					vertex2 = baseId + int2( 1, 0 );
					vertex3 = baseId + int2( 0, 1 );
				}
				UV1 = UV + ComputeStochasticHash22(vertex1);
				UV2 = UV + ComputeStochasticHash22(vertex2);
				UV3 = UV + ComputeStochasticHash22(vertex3);
				return;
			}
			
			void BuildTextureData( out TVEMasksData Data, float4 In_MaskA, float4 In_MaskB, float4 In_MaskC, float4 In_MaskD, float4 In_MaskE, float4 In_MaskF, float4 In_MaskG, half4 In_MaskH, half4 In_MaskI, half4 In_MaskJ, half4 In_MaskK, half4 In_MaskL, half4 In_MaskM, half4 In_MaskN )
			{
				Data.MaskA = In_MaskA;
				Data.MaskB = In_MaskB;
				Data.MaskC = In_MaskC;
				Data.MaskD = In_MaskD;
				Data.MaskE = In_MaskE;
				Data.MaskF = In_MaskF;
				Data.MaskG = In_MaskG;
				Data.MaskH = In_MaskH;
				Data.MaskI = In_MaskI;
				Data.MaskJ = In_MaskJ;
				Data.MaskK = In_MaskK;
				Data.MaskL = In_MaskL;
				Data.MaskM = In_MaskM;
				Data.MaskN = In_MaskN;
				return;
			}
			
			void BreakTextureData( TVEMasksData Data, out float4 Out_MaskA, out float4 Out_MaskB, out float4 Out_MaskC, out float4 Out_MaskD, out float4 Out_MaskE, out float4 Out_MaskF, out half4 Out_MaskG, out half4 Out_MaskH, out half4 Out_MaskI, out half4 Out_MaskJ, out half4 Out_MaskK, out half4 Out_MaskL, out half4 Out_MaskM, out half4 Out_MaskN )
			{
				Out_MaskA = Data.MaskA;
				Out_MaskB = Data.MaskB;
				Out_MaskC = Data.MaskC;
				Out_MaskD = Data.MaskD;
				Out_MaskE = Data.MaskE;
				Out_MaskF = Data.MaskF;
				Out_MaskG = Data.MaskG;
				Out_MaskH = Data.MaskH;
				Out_MaskI = Data.MaskI;
				Out_MaskJ = Data.MaskJ;
				Out_MaskK = Data.MaskK;
				Out_MaskL = Data.MaskL;
				Out_MaskM = Data.MaskM;
				Out_MaskN = Data.MaskN;
				return;
			}
			
			half4 SampleCoord( TEXTURE2D(Texture), SamplerState Sampler, half2 UV, half Bias, out half2 Normal )
			{
				half4 tex = SAMPLE_TEXTURE2D_BIAS( Texture, Sampler, UV, Bias);
				Normal = tex.wy * 2.0 - 1.0;
				return tex;
			}
			
			half4 SamplePlanar2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, half Bias, half3 NormalWS, out half3 Normal )
			{
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SamplePlanar3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 XZ, float2 XY, half Bias, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				half4 tex_X = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, ZY, Bias);
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half4 tex_Z = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XY, Bias);
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal =  normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			half4 SampleStochastic2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, half Bias, half3 Weights_2, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SampleStochastic3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 ZY_1, float2 ZY_2, float2 ZY_3, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, float2 XY, float2 XY_1, float2 XY_2, float2 XY_3, half Bias, half3 Weights_1, half3 Weights_2, half3 Weights_3, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_X = ddx(ZY) * Bias;
				float2 ddy_X= ddy(ZY) * Bias;
				half4 tex1_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_1, ddx_X, ddy_X);
				half4 tex2_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_2, ddx_X, ddy_X);
				half4 tex3_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_3, ddx_X, ddy_X);
				half4 tex_X = tex1_X * Weights_1.x + tex2_X * Weights_1.y + tex3_X * Weights_1.z;
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				float2 ddx_Z = ddx(XY) * Bias;
				float2 ddy_Z= ddy(XY) * Bias;
				half4 tex1_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_1, ddx_Z, ddy_Z);
				half4 tex2_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_2, ddx_Z, ddy_Z);
				half4 tex3_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_3, ddx_Z, ddy_Z);
				half4 tex_Z = tex1_Z * Weights_3.x + tex2_Z * Weights_3.y + tex3_Z * Weights_3.z;
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal = normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			float SwitchChannel8( half Option, half4 ChannelA, half4 ChannelB )
			{
				switch (Option) {
					default:
				                case 0:
						return ChannelA.x;
					case 1:
						return ChannelA.y;
					case 2:
						return ChannelA.z;
					case 3:
						return ChannelA.w;
				                case 4:
						return ChannelB.x;
					case 5:
						return ChannelB.y;
					case 6:
						return ChannelB.z;
					case 7:
						return ChannelB.w;
				}
			}
			
			half3 LinearToGammaFloatFast( half3 linRGB )
			{
				return max(1.055h * pow(abs(linRGB), 0.416666667h) - 0.055h, 0.h);
			}
			
			void BuildVisualData( inout TVEVisualData Data, float In_Dummy, half3 In_Albedo, half3 In_AlbedoBase, half2 In_NormalTS, half3 In_NormalWS, half4 In_Shader, half4 In_Feature, half4 In_Season, half4 In_Emissive, half In_Grayscale, half In_Luminosity, half In_MultiMask, half In_AlphaClip, half In_AlphaFade, half3 In_Translucency, half In_Transmission, half In_Thickness, float In_Diffusion, float In_Depth )
			{
				//Data = (TVEVisualData)0;
				Data.Dummy = In_Dummy;
				Data.Albedo = In_Albedo;
				Data.AlbedoBase = In_AlbedoBase;
				Data.NormalTS = In_NormalTS;
				Data.NormalWS = In_NormalWS;
				Data.Shader = In_Shader;
				Data.Feature = In_Feature;
				Data.Season= In_Season;
				Data.Emissive= In_Emissive;
				Data.MultiMask = In_MultiMask;
				Data.Grayscale = In_Grayscale;
				Data.Luminosity = In_Luminosity;
				Data.AlphaClip = In_AlphaClip;
				Data.AlphaFade = In_AlphaFade;
				Data.Translucency = In_Translucency;
				Data.Transmission = In_Transmission;
				Data.Thickness = In_Thickness;
				Data.Diffusion = In_Diffusion;
				Data.Depth = In_Depth;
				return;
			}
			
			void BreakVisualData( inout TVEVisualData Data, out half Out_Dummy, out half3 Out_Albedo, out half3 Out_AlbedoBase, out half2 Out_NormalTS, out half3 Out_NormalWS, out half4 Out_Shader, out half4 Out_Feature, out half4 Out_Season, out half4 Out_Emissive, out half Out_MultiMask, out half Out_Grayscale, out half Out_Luminosity, out half Out_AlphaClip, out half Out_AlphaFade, out half3 Out_Translucency, out half Out_Transmission, out half Out_Thickness, out half Out_Diffusion, out float Out_Depth )
			{
				Out_Dummy = Data.Dummy;
				Out_Albedo = Data.Albedo;
				Out_AlbedoBase = Data.AlbedoBase;
				Out_NormalTS = Data.NormalTS;
				Out_NormalWS = Data.NormalWS;
				Out_Shader = Data.Shader;
				Out_Feature = Data.Feature;
				Out_Season = Data.Season;
				Out_Emissive= Data.Emissive;
				Out_MultiMask = Data.MultiMask;
				Out_Grayscale = Data.Grayscale;
				Out_Luminosity= Data.Luminosity;
				Out_AlphaClip = Data.AlphaClip;
				Out_AlphaFade = Data.AlphaFade;
				Out_Translucency = Data.Translucency;
				Out_Transmission = Data.Transmission;
				Out_Thickness = Data.Thickness;
				Out_Diffusion = Data.Diffusion;
				Out_Depth= Data.Depth;
				return;
			}
			

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID( input );
				UNITY_TRANSFER_INSTANCE_ID( input, output );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( output );

				float3 ase_positionWS = TransformObjectToWorld( ( input.positionOS ).xyz );
				float3 temp_output_104_7_g205214 = ase_positionWS;
				float3 vertexToFrag73_g205214 = temp_output_104_7_g205214;
				output.ase_texcoord1.xyz = vertexToFrag73_g205214;
				float4x4 break19_g205217 = GetObjectToWorldMatrix();
				float3 appendResult20_g205217 = (float3(break19_g205217[ 0 ][ 3 ] , break19_g205217[ 1 ][ 3 ] , break19_g205217[ 2 ][ 3 ]));
				float3 temp_output_340_7_g205214 = appendResult20_g205217;
				float4x4 break19_g205219 = GetObjectToWorldMatrix();
				float3 appendResult20_g205219 = (float3(break19_g205219[ 0 ][ 3 ] , break19_g205219[ 1 ][ 3 ] , break19_g205219[ 2 ][ 3 ]));
				float3 _Vector0 = float3(0,0,0);
				float3 appendResult60_g205215 = (float3(input.ase_texcoord3.x , input.ase_texcoord3.z , input.ase_texcoord3.y));
				float3 PositionOS131_g205214 = input.positionOS.xyz;
				float3 break233_g205214 = PositionOS131_g205214;
				float3 appendResult234_g205214 = (float3(break233_g205214.x , 0.0 , break233_g205214.z));
				float3 break413_g205214 = PositionOS131_g205214;
				float3 appendResult414_g205214 = (float3(break413_g205214.x , break413_g205214.y , 0.0));
				#ifdef TVE_COORD_ZUP
				float3 staticSwitch65_g205221 = appendResult414_g205214;
				#else
				float3 staticSwitch65_g205221 = appendResult234_g205214;
				#endif
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch229_g205214 = _Vector0;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch229_g205214 = appendResult60_g205215;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch229_g205214 = staticSwitch65_g205221;
				#else
				float3 staticSwitch229_g205214 = _Vector0;
				#endif
				float3 PivotOS149_g205214 = staticSwitch229_g205214;
				float3 temp_output_122_0_g205219 = PivotOS149_g205214;
				float3 PivotsOnlyWS105_g205219 = mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g205219 , 0.0 ) ).xyz;
				float3 temp_output_341_7_g205214 = ( appendResult20_g205219 + PivotsOnlyWS105_g205219 );
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#else
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#endif
				float3 vertexToFrag76_g205214 = staticSwitch236_g205214;
				output.ase_texcoord2.xyz = vertexToFrag76_g205214;
				float3 ase_normalWS = TransformObjectToWorldNormal( input.normalOS );
				output.ase_texcoord3.xyz = ase_normalWS;
				float3 ase_tangentWS = TransformObjectToWorldDir( input.tangentOS.xyz );
				output.ase_texcoord4.xyz = ase_tangentWS;
				float ase_tangentSign = input.tangentOS.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
				output.ase_texcoord5.xyz = ase_bitangentWS;
				
				output.ase_texcoord6.xy = input.ase_texcoord.xy;
				output.ase_texcoord6.zw = input.ase_texcoord2.xy;
				output.ase_color = input.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord1.w = 0;
				output.ase_texcoord2.w = 0;
				output.ase_texcoord3.w = 0;
				output.ase_texcoord4.w = 0;
				output.ase_texcoord5.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );

				output.positionCS = vertexInput.positionCS;
				output.positionWS = vertexInput.positionWS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				output.ase_texcoord3 = input.ase_texcoord3;
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord2 = input.ase_texcoord2;
				output.ase_color = input.ase_color;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
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
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				output.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag(PackedVaryings input  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( input );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( input );

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord = TransformWorldToShadowCoord(input.positionWS);
				#else
					float4 shadowCoord = float4(0, 0, 0, 0);
				#endif

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( input.positionWS );
				float4 ShadowCoord = shadowCoord;

				float localBreakVisualData4_g251314 = ( 0.0 );
				float localBuildVisualData3_g207088 = ( 0.0 );
				TVEVisualData Data3_g207088 =(TVEVisualData)0;
				half4 Dummy130_g207086 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) + _MainMultiMaskInfo + _MainSmoothnessInfo );
				float temp_output_14_0_g207088 = Dummy130_g207086.x;
				float In_Dummy3_g207088 = temp_output_14_0_g207088;
				TEXTURE2D(Texture276_g207093) = _MainAlbedoTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g207096 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g207093 = staticSwitch36_g207096;
				float localBreakTextureData456_g207093 = ( 0.0 );
				float localBuildTextureData431_g251292 = ( 0.0 );
				TVEMasksData Data431_g251292 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g251292 = ( 0.0 );
				half4 Local_Coords180_g207086 = _main_coord_value;
				float4 Coords444_g251292 = Local_Coords180_g207086;
				TVEModelData Data16_g205222 =(TVEModelData)(TVEModelData)0;
				float In_Dummy16_g205222 = 0.0;
				float3 vertexToFrag73_g205214 = input.ase_texcoord1.xyz;
				float3 PositionWS122_g205214 = vertexToFrag73_g205214;
				float3 In_PositionWS16_g205222 = PositionWS122_g205214;
				float3 vertexToFrag76_g205214 = input.ase_texcoord2.xyz;
				float3 PivotWS121_g205214 = vertexToFrag76_g205214;
				#ifdef TVE_SCOPE_DYNAMIC
				float3 staticSwitch204_g205214 = ( PositionWS122_g205214 - PivotWS121_g205214 );
				#else
				float3 staticSwitch204_g205214 = PositionWS122_g205214;
				#endif
				float3 PositionWO132_g205214 = ( staticSwitch204_g205214 - TVE_WorldOrigin );
				float3 In_PositionWO16_g205222 = PositionWO132_g205214;
				float3 In_PivotWS16_g205222 = PivotWS121_g205214;
				float3 PivotWO133_g205214 = ( PivotWS121_g205214 - TVE_WorldOrigin );
				float3 In_PivotWO16_g205222 = PivotWO133_g205214;
				float3 ase_normalWS = input.ase_texcoord3.xyz;
				float3 normalizedWorldNormal = normalize( ase_normalWS );
				half3 NormalWS95_g205214 = normalizedWorldNormal;
				float3 In_NormalWS16_g205222 = NormalWS95_g205214;
				float3 ase_tangentWS = input.ase_texcoord4.xyz;
				half3 TangentWS136_g205214 = ase_tangentWS;
				float3 In_TangentWS16_g205222 = TangentWS136_g205214;
				float3 ase_bitangentWS = input.ase_texcoord5.xyz;
				half3 BiangentWS421_g205214 = ase_bitangentWS;
				float3 In_BitangentWS16_g205222 = BiangentWS421_g205214;
				half3 NormalWS427_g205214 = NormalWS95_g205214;
				half3 localComputeTriplanarWeights427_g205214 = ComputeTriplanarWeights( NormalWS427_g205214 );
				half3 TriplanarWeights429_g205214 = localComputeTriplanarWeights427_g205214;
				float3 In_TriplanarWeights16_g205222 = TriplanarWeights429_g205214;
				float3 normalizeResult296_g205214 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g205214 ) );
				half3 ViewDirWS169_g205214 = normalizeResult296_g205214;
				float3 In_ViewDirWS16_g205222 = ViewDirWS169_g205214;
				float4 appendResult397_g205214 = (float4(input.ase_texcoord6.xy , input.ase_texcoord6.zw));
				float4 CoordsData398_g205214 = appendResult397_g205214;
				float4 In_CoordsData16_g205222 = CoordsData398_g205214;
				half4 VertexMasks171_g205214 = input.ase_color;
				float4 In_VertexData16_g205222 = VertexMasks171_g205214;
				float temp_output_17_0_g205226 = _ObjectPhaseMode;
				float Option70_g205226 = temp_output_17_0_g205226;
				float4 temp_output_3_0_g205226 = input.ase_color;
				float4 Channel70_g205226 = temp_output_3_0_g205226;
				float localSwitchChannel470_g205226 = SwitchChannel4( Option70_g205226 , Channel70_g205226 );
				half Phase_Value372_g205214 = localSwitchChannel470_g205226;
				float3 break319_g205214 = PivotWO133_g205214;
				half Pivot_Position322_g205214 = ( break319_g205214.x + break319_g205214.z );
				half Phase_Position357_g205214 = ( Phase_Value372_g205214 + Pivot_Position322_g205214 );
				float temp_output_248_0_g205214 = frac( Phase_Position357_g205214 );
				float4 appendResult177_g205214 = (float4(( (frac( ( Phase_Position357_g205214 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g205214));
				half4 Phase_Data176_g205214 = appendResult177_g205214;
				float4 In_PhaseData16_g205222 = Phase_Data176_g205214;
				BuildModelFragData( Data16_g205222 , In_Dummy16_g205222 , In_PositionWS16_g205222 , In_PositionWO16_g205222 , In_PivotWS16_g205222 , In_PivotWO16_g205222 , In_NormalWS16_g205222 , In_TangentWS16_g205222 , In_BitangentWS16_g205222 , In_TriplanarWeights16_g205222 , In_ViewDirWS16_g205222 , In_CoordsData16_g205222 , In_VertexData16_g205222 , In_PhaseData16_g205222 );
				TVEModelData Data15_g207087 =(TVEModelData)Data16_g205222;
				float Out_Dummy15_g207087 = 0.0;
				float3 Out_PositionWS15_g207087 = float3( 0,0,0 );
				float3 Out_PositionWO15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWS15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWO15_g207087 = float3( 0,0,0 );
				float3 Out_NormalWS15_g207087 = float3( 0,0,0 );
				float3 Out_TangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g207087 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g207087 = float3( 0,0,0 );
				float4 Out_CoordsData15_g207087 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g207087 = float4( 0,0,0,0 );
				float4 Out_PhaseData15_g207087 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g207087 , Out_Dummy15_g207087 , Out_PositionWS15_g207087 , Out_PositionWO15_g207087 , Out_PivotWS15_g207087 , Out_PivotWO15_g207087 , Out_NormalWS15_g207087 , Out_TangentWS15_g207087 , Out_BitangentWS15_g207087 , Out_TriplanarWeights15_g207087 , Out_ViewDirWS15_g207087 , Out_CoordsData15_g207087 , Out_VertexData15_g207087 , Out_PhaseData15_g207087 );
				half4 Model_CoordsData412_g207086 = Out_CoordsData15_g207087;
				float4 MeshCoords444_g251292 = Model_CoordsData412_g207086;
				float2 UV0444_g251292 = float2( 0,0 );
				float2 UV3444_g251292 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g251292 , MeshCoords444_g251292 , UV0444_g251292 , UV3444_g251292 );
				float4 appendResult430_g251292 = (float4(UV0444_g251292 , UV3444_g251292));
				float4 In_MaskA431_g251292 = appendResult430_g251292;
				float localComputeWorldCoords315_g251292 = ( 0.0 );
				float4 Coords315_g251292 = Local_Coords180_g207086;
				half3 Model_PositionWO222_g207086 = Out_PositionWO15_g207087;
				float3 PositionWS315_g251292 = Model_PositionWO222_g207086;
				float2 ZY315_g251292 = float2( 0,0 );
				float2 XZ315_g251292 = float2( 0,0 );
				float2 XY315_g251292 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g251292 , PositionWS315_g251292 , ZY315_g251292 , XZ315_g251292 , XY315_g251292 );
				float2 ZY402_g251292 = ZY315_g251292;
				float2 XZ403_g251292 = XZ315_g251292;
				float4 appendResult432_g251292 = (float4(ZY402_g251292 , XZ403_g251292));
				float4 In_MaskB431_g251292 = appendResult432_g251292;
				float2 XY404_g251292 = XY315_g251292;
				float localComputeStochasticCoords409_g251292 = ( 0.0 );
				float2 UV409_g251292 = ZY402_g251292;
				float2 UV1409_g251292 = float2( 0,0 );
				float2 UV2409_g251292 = float2( 0,0 );
				float2 UV3409_g251292 = float2( 0,0 );
				float3 Weights409_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g251292 , UV1409_g251292 , UV2409_g251292 , UV3409_g251292 , Weights409_g251292 );
				float4 appendResult433_g251292 = (float4(XY404_g251292 , UV1409_g251292));
				float4 In_MaskC431_g251292 = appendResult433_g251292;
				float4 appendResult434_g251292 = (float4(UV2409_g251292 , UV3409_g251292));
				float4 In_MaskD431_g251292 = appendResult434_g251292;
				float localComputeStochasticCoords422_g251292 = ( 0.0 );
				float2 UV422_g251292 = XZ403_g251292;
				float2 UV1422_g251292 = float2( 0,0 );
				float2 UV2422_g251292 = float2( 0,0 );
				float2 UV3422_g251292 = float2( 0,0 );
				float3 Weights422_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g251292 , UV1422_g251292 , UV2422_g251292 , UV3422_g251292 , Weights422_g251292 );
				float4 appendResult435_g251292 = (float4(UV1422_g251292 , UV2422_g251292));
				float4 In_MaskE431_g251292 = appendResult435_g251292;
				float localComputeStochasticCoords423_g251292 = ( 0.0 );
				float2 UV423_g251292 = XY404_g251292;
				float2 UV1423_g251292 = float2( 0,0 );
				float2 UV2423_g251292 = float2( 0,0 );
				float2 UV3423_g251292 = float2( 0,0 );
				float3 Weights423_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g251292 , UV1423_g251292 , UV2423_g251292 , UV3423_g251292 , Weights423_g251292 );
				float4 appendResult436_g251292 = (float4(UV3422_g251292 , UV1423_g251292));
				float4 In_MaskF431_g251292 = appendResult436_g251292;
				float4 appendResult437_g251292 = (float4(UV2423_g251292 , UV3423_g251292));
				float4 In_MaskG431_g251292 = appendResult437_g251292;
				float4 In_MaskH431_g251292 = float4( Weights409_g251292 , 0.0 );
				float4 In_MaskI431_g251292 = float4( Weights422_g251292 , 0.0 );
				float4 In_MaskJ431_g251292 = float4( Weights423_g251292 , 0.0 );
				float3 temp_output_449_0_g251292 = float3( 0,0,0 );
				float4 In_MaskK431_g251292 = float4( temp_output_449_0_g251292 , 0.0 );
				float3 temp_output_450_0_g251292 = float3( 0,0,0 );
				float4 In_MaskL431_g251292 = float4( temp_output_450_0_g251292 , 0.0 );
				float3 temp_output_451_0_g251292 = float3( 0,0,0 );
				float4 In_MaskM431_g251292 = float4( temp_output_451_0_g251292 , 0.0 );
				float3 temp_output_445_0_g251292 = float3( 0,0,0 );
				float4 In_MaskN431_g251292 = float4( temp_output_445_0_g251292 , 0.0 );
				BuildTextureData( Data431_g251292 , In_MaskA431_g251292 , In_MaskB431_g251292 , In_MaskC431_g251292 , In_MaskD431_g251292 , In_MaskE431_g251292 , In_MaskF431_g251292 , In_MaskG431_g251292 , In_MaskH431_g251292 , In_MaskI431_g251292 , In_MaskJ431_g251292 , In_MaskK431_g251292 , In_MaskL431_g251292 , In_MaskM431_g251292 , In_MaskN431_g251292 );
				TVEMasksData Data456_g207093 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207093 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207093 , Out_MaskA456_g207093 , Out_MaskB456_g207093 , Out_MaskC456_g207093 , Out_MaskD456_g207093 , Out_MaskE456_g207093 , Out_MaskF456_g207093 , Out_MaskG456_g207093 , Out_MaskH456_g207093 , Out_MaskI456_g207093 , Out_MaskJ456_g207093 , Out_MaskK456_g207093 , Out_MaskL456_g207093 , Out_MaskM456_g207093 , Out_MaskN456_g207093 );
				half2 UV276_g207093 = (Out_MaskA456_g207093).xy;
				float temp_output_504_0_g207093 = 0.0;
				half Bias276_g207093 = temp_output_504_0_g207093;
				half2 Normal276_g207093 = float2( 0,0 );
				half4 localSampleCoord276_g207093 = SampleCoord( Texture276_g207093 , Sampler276_g207093 , UV276_g207093 , Bias276_g207093 , Normal276_g207093 );
				TEXTURE2D(Texture502_g207093) = _MainAlbedoTex;
				SamplerState Sampler502_g207093 = staticSwitch36_g207096;
				half2 UV502_g207093 = (Out_MaskA456_g207093).zw;
				half Bias502_g207093 = temp_output_504_0_g207093;
				half2 Normal502_g207093 = float2( 0,0 );
				half4 localSampleCoord502_g207093 = SampleCoord( Texture502_g207093 , Sampler502_g207093 , UV502_g207093 , Bias502_g207093 , Normal502_g207093 );
				TEXTURE2D(Texture496_g207093) = _MainAlbedoTex;
				SamplerState Sampler496_g207093 = staticSwitch36_g207096;
				float2 temp_output_463_0_g207093 = (Out_MaskB456_g207093).zw;
				half2 XZ496_g207093 = temp_output_463_0_g207093;
				half Bias496_g207093 = temp_output_504_0_g207093;
				float3 temp_output_483_0_g207093 = (Out_MaskK456_g207093).xyz;
				half3 NormalWS496_g207093 = temp_output_483_0_g207093;
				half3 Normal496_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207093 = SamplePlanar2D( Texture496_g207093 , Sampler496_g207093 , XZ496_g207093 , Bias496_g207093 , NormalWS496_g207093 , Normal496_g207093 );
				TEXTURE2D(Texture490_g207093) = _MainAlbedoTex;
				SamplerState Sampler490_g207093 = staticSwitch36_g207096;
				float2 temp_output_462_0_g207093 = (Out_MaskB456_g207093).xy;
				half2 ZY490_g207093 = temp_output_462_0_g207093;
				half2 XZ490_g207093 = temp_output_463_0_g207093;
				float2 temp_output_464_0_g207093 = (Out_MaskC456_g207093).xy;
				half2 XY490_g207093 = temp_output_464_0_g207093;
				half Bias490_g207093 = temp_output_504_0_g207093;
				float3 temp_output_482_0_g207093 = (Out_MaskN456_g207093).xyz;
				half3 Triplanar490_g207093 = temp_output_482_0_g207093;
				half3 NormalWS490_g207093 = temp_output_483_0_g207093;
				half3 Normal490_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207093 = SamplePlanar3D( Texture490_g207093 , Sampler490_g207093 , ZY490_g207093 , XZ490_g207093 , XY490_g207093 , Bias490_g207093 , Triplanar490_g207093 , NormalWS490_g207093 , Normal490_g207093 );
				TEXTURE2D(Texture498_g207093) = _MainAlbedoTex;
				SamplerState Sampler498_g207093 = staticSwitch36_g207096;
				half2 XZ498_g207093 = temp_output_463_0_g207093;
				float2 temp_output_473_0_g207093 = (Out_MaskE456_g207093).xy;
				half2 XZ_1498_g207093 = temp_output_473_0_g207093;
				float2 temp_output_474_0_g207093 = (Out_MaskE456_g207093).zw;
				half2 XZ_2498_g207093 = temp_output_474_0_g207093;
				float2 temp_output_475_0_g207093 = (Out_MaskF456_g207093).xy;
				half2 XZ_3498_g207093 = temp_output_475_0_g207093;
				float temp_output_510_0_g207093 = exp2( temp_output_504_0_g207093 );
				half Bias498_g207093 = temp_output_510_0_g207093;
				float3 temp_output_480_0_g207093 = (Out_MaskI456_g207093).xyz;
				half3 Weights_2498_g207093 = temp_output_480_0_g207093;
				half3 NormalWS498_g207093 = temp_output_483_0_g207093;
				half3 Normal498_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207093 = SampleStochastic2D( Texture498_g207093 , Sampler498_g207093 , XZ498_g207093 , XZ_1498_g207093 , XZ_2498_g207093 , XZ_3498_g207093 , Bias498_g207093 , Weights_2498_g207093 , NormalWS498_g207093 , Normal498_g207093 );
				TEXTURE2D(Texture500_g207093) = _MainAlbedoTex;
				SamplerState Sampler500_g207093 = staticSwitch36_g207096;
				half2 ZY500_g207093 = temp_output_462_0_g207093;
				half2 ZY_1500_g207093 = (Out_MaskC456_g207093).zw;
				half2 ZY_2500_g207093 = (Out_MaskD456_g207093).xy;
				half2 ZY_3500_g207093 = (Out_MaskD456_g207093).zw;
				half2 XZ500_g207093 = temp_output_463_0_g207093;
				half2 XZ_1500_g207093 = temp_output_473_0_g207093;
				half2 XZ_2500_g207093 = temp_output_474_0_g207093;
				half2 XZ_3500_g207093 = temp_output_475_0_g207093;
				half2 XY500_g207093 = temp_output_464_0_g207093;
				half2 XY_1500_g207093 = (Out_MaskF456_g207093).zw;
				half2 XY_2500_g207093 = (Out_MaskG456_g207093).xy;
				half2 XY_3500_g207093 = (Out_MaskG456_g207093).zw;
				half Bias500_g207093 = temp_output_510_0_g207093;
				half3 Weights_1500_g207093 = (Out_MaskH456_g207093).xyz;
				half3 Weights_2500_g207093 = temp_output_480_0_g207093;
				half3 Weights_3500_g207093 = (Out_MaskJ456_g207093).xyz;
				half3 Triplanar500_g207093 = temp_output_482_0_g207093;
				half3 NormalWS500_g207093 = temp_output_483_0_g207093;
				half3 Normal500_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207093 = SampleStochastic3D( Texture500_g207093 , Sampler500_g207093 , ZY500_g207093 , ZY_1500_g207093 , ZY_2500_g207093 , ZY_3500_g207093 , XZ500_g207093 , XZ_1500_g207093 , XZ_2500_g207093 , XZ_3500_g207093 , XY500_g207093 , XY_1500_g207093 , XY_2500_g207093 , XY_3500_g207093 , Bias500_g207093 , Weights_1500_g207093 , Weights_2500_g207093 , Weights_3500_g207093 , Triplanar500_g207093 , NormalWS500_g207093 , Normal500_g207093 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch184_g207086 = localSampleCoord502_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch184_g207086 = localSamplePlanar2D496_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch184_g207086 = localSamplePlanar3D490_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch184_g207086 = localSampleStochastic2D498_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch184_g207086 = localSampleStochastic3D500_g207093;
				#else
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#endif
				half4 Local_AlbedoTex185_g207086 = staticSwitch184_g207086;
				float3 lerpResult53_g207086 = lerp( float3( 1,1,1 ) , (Local_AlbedoTex185_g207086).xyz , _MainAlbedoValue);
				half3 Local_AlbedoRGB107_g207086 = lerpResult53_g207086;
				TEXTURE2D(Texture276_g207097) = _MainShaderTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207098 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207097 = staticSwitch38_g207098;
				float localBreakTextureData456_g207097 = ( 0.0 );
				TVEMasksData Data456_g207097 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207097 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207097 , Out_MaskA456_g207097 , Out_MaskB456_g207097 , Out_MaskC456_g207097 , Out_MaskD456_g207097 , Out_MaskE456_g207097 , Out_MaskF456_g207097 , Out_MaskG456_g207097 , Out_MaskH456_g207097 , Out_MaskI456_g207097 , Out_MaskJ456_g207097 , Out_MaskK456_g207097 , Out_MaskL456_g207097 , Out_MaskM456_g207097 , Out_MaskN456_g207097 );
				half2 UV276_g207097 = (Out_MaskA456_g207097).xy;
				float temp_output_504_0_g207097 = 0.0;
				half Bias276_g207097 = temp_output_504_0_g207097;
				half2 Normal276_g207097 = float2( 0,0 );
				half4 localSampleCoord276_g207097 = SampleCoord( Texture276_g207097 , Sampler276_g207097 , UV276_g207097 , Bias276_g207097 , Normal276_g207097 );
				TEXTURE2D(Texture502_g207097) = _MainShaderTex;
				SamplerState Sampler502_g207097 = staticSwitch38_g207098;
				half2 UV502_g207097 = (Out_MaskA456_g207097).zw;
				half Bias502_g207097 = temp_output_504_0_g207097;
				half2 Normal502_g207097 = float2( 0,0 );
				half4 localSampleCoord502_g207097 = SampleCoord( Texture502_g207097 , Sampler502_g207097 , UV502_g207097 , Bias502_g207097 , Normal502_g207097 );
				TEXTURE2D(Texture496_g207097) = _MainShaderTex;
				SamplerState Sampler496_g207097 = staticSwitch38_g207098;
				float2 temp_output_463_0_g207097 = (Out_MaskB456_g207097).zw;
				half2 XZ496_g207097 = temp_output_463_0_g207097;
				half Bias496_g207097 = temp_output_504_0_g207097;
				float3 temp_output_483_0_g207097 = (Out_MaskK456_g207097).xyz;
				half3 NormalWS496_g207097 = temp_output_483_0_g207097;
				half3 Normal496_g207097 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207097 = SamplePlanar2D( Texture496_g207097 , Sampler496_g207097 , XZ496_g207097 , Bias496_g207097 , NormalWS496_g207097 , Normal496_g207097 );
				TEXTURE2D(Texture490_g207097) = _MainShaderTex;
				SamplerState Sampler490_g207097 = staticSwitch38_g207098;
				float2 temp_output_462_0_g207097 = (Out_MaskB456_g207097).xy;
				half2 ZY490_g207097 = temp_output_462_0_g207097;
				half2 XZ490_g207097 = temp_output_463_0_g207097;
				float2 temp_output_464_0_g207097 = (Out_MaskC456_g207097).xy;
				half2 XY490_g207097 = temp_output_464_0_g207097;
				half Bias490_g207097 = temp_output_504_0_g207097;
				float3 temp_output_482_0_g207097 = (Out_MaskN456_g207097).xyz;
				half3 Triplanar490_g207097 = temp_output_482_0_g207097;
				half3 NormalWS490_g207097 = temp_output_483_0_g207097;
				half3 Normal490_g207097 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207097 = SamplePlanar3D( Texture490_g207097 , Sampler490_g207097 , ZY490_g207097 , XZ490_g207097 , XY490_g207097 , Bias490_g207097 , Triplanar490_g207097 , NormalWS490_g207097 , Normal490_g207097 );
				TEXTURE2D(Texture498_g207097) = _MainShaderTex;
				SamplerState Sampler498_g207097 = staticSwitch38_g207098;
				half2 XZ498_g207097 = temp_output_463_0_g207097;
				float2 temp_output_473_0_g207097 = (Out_MaskE456_g207097).xy;
				half2 XZ_1498_g207097 = temp_output_473_0_g207097;
				float2 temp_output_474_0_g207097 = (Out_MaskE456_g207097).zw;
				half2 XZ_2498_g207097 = temp_output_474_0_g207097;
				float2 temp_output_475_0_g207097 = (Out_MaskF456_g207097).xy;
				half2 XZ_3498_g207097 = temp_output_475_0_g207097;
				float temp_output_510_0_g207097 = exp2( temp_output_504_0_g207097 );
				half Bias498_g207097 = temp_output_510_0_g207097;
				float3 temp_output_480_0_g207097 = (Out_MaskI456_g207097).xyz;
				half3 Weights_2498_g207097 = temp_output_480_0_g207097;
				half3 NormalWS498_g207097 = temp_output_483_0_g207097;
				half3 Normal498_g207097 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207097 = SampleStochastic2D( Texture498_g207097 , Sampler498_g207097 , XZ498_g207097 , XZ_1498_g207097 , XZ_2498_g207097 , XZ_3498_g207097 , Bias498_g207097 , Weights_2498_g207097 , NormalWS498_g207097 , Normal498_g207097 );
				TEXTURE2D(Texture500_g207097) = _MainShaderTex;
				SamplerState Sampler500_g207097 = staticSwitch38_g207098;
				half2 ZY500_g207097 = temp_output_462_0_g207097;
				half2 ZY_1500_g207097 = (Out_MaskC456_g207097).zw;
				half2 ZY_2500_g207097 = (Out_MaskD456_g207097).xy;
				half2 ZY_3500_g207097 = (Out_MaskD456_g207097).zw;
				half2 XZ500_g207097 = temp_output_463_0_g207097;
				half2 XZ_1500_g207097 = temp_output_473_0_g207097;
				half2 XZ_2500_g207097 = temp_output_474_0_g207097;
				half2 XZ_3500_g207097 = temp_output_475_0_g207097;
				half2 XY500_g207097 = temp_output_464_0_g207097;
				half2 XY_1500_g207097 = (Out_MaskF456_g207097).zw;
				half2 XY_2500_g207097 = (Out_MaskG456_g207097).xy;
				half2 XY_3500_g207097 = (Out_MaskG456_g207097).zw;
				half Bias500_g207097 = temp_output_510_0_g207097;
				half3 Weights_1500_g207097 = (Out_MaskH456_g207097).xyz;
				half3 Weights_2500_g207097 = temp_output_480_0_g207097;
				half3 Weights_3500_g207097 = (Out_MaskJ456_g207097).xyz;
				half3 Triplanar500_g207097 = temp_output_482_0_g207097;
				half3 NormalWS500_g207097 = temp_output_483_0_g207097;
				half3 Normal500_g207097 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207097 = SampleStochastic3D( Texture500_g207097 , Sampler500_g207097 , ZY500_g207097 , ZY_1500_g207097 , ZY_2500_g207097 , ZY_3500_g207097 , XZ500_g207097 , XZ_1500_g207097 , XZ_2500_g207097 , XZ_3500_g207097 , XY500_g207097 , XY_1500_g207097 , XY_2500_g207097 , XY_3500_g207097 , Bias500_g207097 , Weights_1500_g207097 , Weights_2500_g207097 , Weights_3500_g207097 , Triplanar500_g207097 , NormalWS500_g207097 , Normal500_g207097 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch198_g207086 = localSampleCoord276_g207097;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch198_g207086 = localSampleCoord502_g207097;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch198_g207086 = localSamplePlanar2D496_g207097;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch198_g207086 = localSamplePlanar3D490_g207097;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch198_g207086 = localSampleStochastic2D498_g207097;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch198_g207086 = localSampleStochastic3D500_g207097;
				#else
				float4 staticSwitch198_g207086 = localSampleCoord276_g207097;
				#endif
				half4 Local_ShaderTex199_g207086 = staticSwitch198_g207086;
				float temp_output_17_0_g251298 = _MainMetallicChannelMode;
				float Option83_g251298 = temp_output_17_0_g251298;
				TEXTURE2D(Texture276_g207101) = _MainMetallicTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207102 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207101 = staticSwitch38_g207102;
				float localBreakTextureData456_g207101 = ( 0.0 );
				TVEMasksData Data456_g207101 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207101 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207101 , Out_MaskA456_g207101 , Out_MaskB456_g207101 , Out_MaskC456_g207101 , Out_MaskD456_g207101 , Out_MaskE456_g207101 , Out_MaskF456_g207101 , Out_MaskG456_g207101 , Out_MaskH456_g207101 , Out_MaskI456_g207101 , Out_MaskJ456_g207101 , Out_MaskK456_g207101 , Out_MaskL456_g207101 , Out_MaskM456_g207101 , Out_MaskN456_g207101 );
				half2 UV276_g207101 = (Out_MaskA456_g207101).xy;
				float temp_output_504_0_g207101 = 0.0;
				half Bias276_g207101 = temp_output_504_0_g207101;
				half2 Normal276_g207101 = float2( 0,0 );
				half4 localSampleCoord276_g207101 = SampleCoord( Texture276_g207101 , Sampler276_g207101 , UV276_g207101 , Bias276_g207101 , Normal276_g207101 );
				TEXTURE2D(Texture502_g207101) = _MainMetallicTex;
				SamplerState Sampler502_g207101 = staticSwitch38_g207102;
				half2 UV502_g207101 = (Out_MaskA456_g207101).zw;
				half Bias502_g207101 = temp_output_504_0_g207101;
				half2 Normal502_g207101 = float2( 0,0 );
				half4 localSampleCoord502_g207101 = SampleCoord( Texture502_g207101 , Sampler502_g207101 , UV502_g207101 , Bias502_g207101 , Normal502_g207101 );
				TEXTURE2D(Texture496_g207101) = _MainMetallicTex;
				SamplerState Sampler496_g207101 = staticSwitch38_g207102;
				float2 temp_output_463_0_g207101 = (Out_MaskB456_g207101).zw;
				half2 XZ496_g207101 = temp_output_463_0_g207101;
				half Bias496_g207101 = temp_output_504_0_g207101;
				float3 temp_output_483_0_g207101 = (Out_MaskK456_g207101).xyz;
				half3 NormalWS496_g207101 = temp_output_483_0_g207101;
				half3 Normal496_g207101 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207101 = SamplePlanar2D( Texture496_g207101 , Sampler496_g207101 , XZ496_g207101 , Bias496_g207101 , NormalWS496_g207101 , Normal496_g207101 );
				TEXTURE2D(Texture490_g207101) = _MainMetallicTex;
				SamplerState Sampler490_g207101 = staticSwitch38_g207102;
				float2 temp_output_462_0_g207101 = (Out_MaskB456_g207101).xy;
				half2 ZY490_g207101 = temp_output_462_0_g207101;
				half2 XZ490_g207101 = temp_output_463_0_g207101;
				float2 temp_output_464_0_g207101 = (Out_MaskC456_g207101).xy;
				half2 XY490_g207101 = temp_output_464_0_g207101;
				half Bias490_g207101 = temp_output_504_0_g207101;
				float3 temp_output_482_0_g207101 = (Out_MaskN456_g207101).xyz;
				half3 Triplanar490_g207101 = temp_output_482_0_g207101;
				half3 NormalWS490_g207101 = temp_output_483_0_g207101;
				half3 Normal490_g207101 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207101 = SamplePlanar3D( Texture490_g207101 , Sampler490_g207101 , ZY490_g207101 , XZ490_g207101 , XY490_g207101 , Bias490_g207101 , Triplanar490_g207101 , NormalWS490_g207101 , Normal490_g207101 );
				TEXTURE2D(Texture498_g207101) = _MainMetallicTex;
				SamplerState Sampler498_g207101 = staticSwitch38_g207102;
				half2 XZ498_g207101 = temp_output_463_0_g207101;
				float2 temp_output_473_0_g207101 = (Out_MaskE456_g207101).xy;
				half2 XZ_1498_g207101 = temp_output_473_0_g207101;
				float2 temp_output_474_0_g207101 = (Out_MaskE456_g207101).zw;
				half2 XZ_2498_g207101 = temp_output_474_0_g207101;
				float2 temp_output_475_0_g207101 = (Out_MaskF456_g207101).xy;
				half2 XZ_3498_g207101 = temp_output_475_0_g207101;
				float temp_output_510_0_g207101 = exp2( temp_output_504_0_g207101 );
				half Bias498_g207101 = temp_output_510_0_g207101;
				float3 temp_output_480_0_g207101 = (Out_MaskI456_g207101).xyz;
				half3 Weights_2498_g207101 = temp_output_480_0_g207101;
				half3 NormalWS498_g207101 = temp_output_483_0_g207101;
				half3 Normal498_g207101 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207101 = SampleStochastic2D( Texture498_g207101 , Sampler498_g207101 , XZ498_g207101 , XZ_1498_g207101 , XZ_2498_g207101 , XZ_3498_g207101 , Bias498_g207101 , Weights_2498_g207101 , NormalWS498_g207101 , Normal498_g207101 );
				TEXTURE2D(Texture500_g207101) = _MainMetallicTex;
				SamplerState Sampler500_g207101 = staticSwitch38_g207102;
				half2 ZY500_g207101 = temp_output_462_0_g207101;
				half2 ZY_1500_g207101 = (Out_MaskC456_g207101).zw;
				half2 ZY_2500_g207101 = (Out_MaskD456_g207101).xy;
				half2 ZY_3500_g207101 = (Out_MaskD456_g207101).zw;
				half2 XZ500_g207101 = temp_output_463_0_g207101;
				half2 XZ_1500_g207101 = temp_output_473_0_g207101;
				half2 XZ_2500_g207101 = temp_output_474_0_g207101;
				half2 XZ_3500_g207101 = temp_output_475_0_g207101;
				half2 XY500_g207101 = temp_output_464_0_g207101;
				half2 XY_1500_g207101 = (Out_MaskF456_g207101).zw;
				half2 XY_2500_g207101 = (Out_MaskG456_g207101).xy;
				half2 XY_3500_g207101 = (Out_MaskG456_g207101).zw;
				half Bias500_g207101 = temp_output_510_0_g207101;
				half3 Weights_1500_g207101 = (Out_MaskH456_g207101).xyz;
				half3 Weights_2500_g207101 = temp_output_480_0_g207101;
				half3 Weights_3500_g207101 = (Out_MaskJ456_g207101).xyz;
				half3 Triplanar500_g207101 = temp_output_482_0_g207101;
				half3 NormalWS500_g207101 = temp_output_483_0_g207101;
				half3 Normal500_g207101 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207101 = SampleStochastic3D( Texture500_g207101 , Sampler500_g207101 , ZY500_g207101 , ZY_1500_g207101 , ZY_2500_g207101 , ZY_3500_g207101 , XZ500_g207101 , XZ_1500_g207101 , XZ_2500_g207101 , XZ_3500_g207101 , XY500_g207101 , XY_1500_g207101 , XY_2500_g207101 , XY_3500_g207101 , Bias500_g207101 , Weights_1500_g207101 , Weights_2500_g207101 , Weights_3500_g207101 , Triplanar500_g207101 , NormalWS500_g207101 , Normal500_g207101 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch335_g207086 = localSampleCoord276_g207101;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch335_g207086 = localSampleCoord502_g207101;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch335_g207086 = localSamplePlanar2D496_g207101;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch335_g207086 = localSamplePlanar3D490_g207101;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch335_g207086 = localSampleStochastic2D498_g207101;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch335_g207086 = localSampleStochastic3D500_g207101;
				#else
				float4 staticSwitch335_g207086 = localSampleCoord276_g207101;
				#endif
				half4 Local_MetallicTex341_g207086 = staticSwitch335_g207086;
				float4 ChannelA83_g251298 = Local_MetallicTex341_g207086;
				float4 ChannelB83_g251298 = ( 1.0 - Local_MetallicTex341_g207086 );
				float localSwitchChannel883_g251298 = SwitchChannel8( Option83_g251298 , ChannelA83_g251298 , ChannelB83_g251298 );
				float lerpResult366_g207086 = lerp( (Local_ShaderTex199_g207086).x , localSwitchChannel883_g251298 , _MainMetallicSourceMode);
				half Local_Metallic322_g207086 = ( lerpResult366_g207086 * _MainMetallicValue );
				float temp_output_17_0_g251299 = _MainOcclusionChannelMode;
				float Option83_g251299 = temp_output_17_0_g251299;
				TEXTURE2D(Texture276_g207103) = _MainOcclusionTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207108 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207103 = staticSwitch38_g207108;
				float localBreakTextureData456_g207103 = ( 0.0 );
				TVEMasksData Data456_g207103 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207103 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207103 , Out_MaskA456_g207103 , Out_MaskB456_g207103 , Out_MaskC456_g207103 , Out_MaskD456_g207103 , Out_MaskE456_g207103 , Out_MaskF456_g207103 , Out_MaskG456_g207103 , Out_MaskH456_g207103 , Out_MaskI456_g207103 , Out_MaskJ456_g207103 , Out_MaskK456_g207103 , Out_MaskL456_g207103 , Out_MaskM456_g207103 , Out_MaskN456_g207103 );
				half2 UV276_g207103 = (Out_MaskA456_g207103).xy;
				float temp_output_504_0_g207103 = 0.0;
				half Bias276_g207103 = temp_output_504_0_g207103;
				half2 Normal276_g207103 = float2( 0,0 );
				half4 localSampleCoord276_g207103 = SampleCoord( Texture276_g207103 , Sampler276_g207103 , UV276_g207103 , Bias276_g207103 , Normal276_g207103 );
				TEXTURE2D(Texture502_g207103) = _MainOcclusionTex;
				SamplerState Sampler502_g207103 = staticSwitch38_g207108;
				half2 UV502_g207103 = (Out_MaskA456_g207103).zw;
				half Bias502_g207103 = temp_output_504_0_g207103;
				half2 Normal502_g207103 = float2( 0,0 );
				half4 localSampleCoord502_g207103 = SampleCoord( Texture502_g207103 , Sampler502_g207103 , UV502_g207103 , Bias502_g207103 , Normal502_g207103 );
				TEXTURE2D(Texture496_g207103) = _MainOcclusionTex;
				SamplerState Sampler496_g207103 = staticSwitch38_g207108;
				float2 temp_output_463_0_g207103 = (Out_MaskB456_g207103).zw;
				half2 XZ496_g207103 = temp_output_463_0_g207103;
				half Bias496_g207103 = temp_output_504_0_g207103;
				float3 temp_output_483_0_g207103 = (Out_MaskK456_g207103).xyz;
				half3 NormalWS496_g207103 = temp_output_483_0_g207103;
				half3 Normal496_g207103 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207103 = SamplePlanar2D( Texture496_g207103 , Sampler496_g207103 , XZ496_g207103 , Bias496_g207103 , NormalWS496_g207103 , Normal496_g207103 );
				TEXTURE2D(Texture490_g207103) = _MainOcclusionTex;
				SamplerState Sampler490_g207103 = staticSwitch38_g207108;
				float2 temp_output_462_0_g207103 = (Out_MaskB456_g207103).xy;
				half2 ZY490_g207103 = temp_output_462_0_g207103;
				half2 XZ490_g207103 = temp_output_463_0_g207103;
				float2 temp_output_464_0_g207103 = (Out_MaskC456_g207103).xy;
				half2 XY490_g207103 = temp_output_464_0_g207103;
				half Bias490_g207103 = temp_output_504_0_g207103;
				float3 temp_output_482_0_g207103 = (Out_MaskN456_g207103).xyz;
				half3 Triplanar490_g207103 = temp_output_482_0_g207103;
				half3 NormalWS490_g207103 = temp_output_483_0_g207103;
				half3 Normal490_g207103 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207103 = SamplePlanar3D( Texture490_g207103 , Sampler490_g207103 , ZY490_g207103 , XZ490_g207103 , XY490_g207103 , Bias490_g207103 , Triplanar490_g207103 , NormalWS490_g207103 , Normal490_g207103 );
				TEXTURE2D(Texture498_g207103) = _MainOcclusionTex;
				SamplerState Sampler498_g207103 = staticSwitch38_g207108;
				half2 XZ498_g207103 = temp_output_463_0_g207103;
				float2 temp_output_473_0_g207103 = (Out_MaskE456_g207103).xy;
				half2 XZ_1498_g207103 = temp_output_473_0_g207103;
				float2 temp_output_474_0_g207103 = (Out_MaskE456_g207103).zw;
				half2 XZ_2498_g207103 = temp_output_474_0_g207103;
				float2 temp_output_475_0_g207103 = (Out_MaskF456_g207103).xy;
				half2 XZ_3498_g207103 = temp_output_475_0_g207103;
				float temp_output_510_0_g207103 = exp2( temp_output_504_0_g207103 );
				half Bias498_g207103 = temp_output_510_0_g207103;
				float3 temp_output_480_0_g207103 = (Out_MaskI456_g207103).xyz;
				half3 Weights_2498_g207103 = temp_output_480_0_g207103;
				half3 NormalWS498_g207103 = temp_output_483_0_g207103;
				half3 Normal498_g207103 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207103 = SampleStochastic2D( Texture498_g207103 , Sampler498_g207103 , XZ498_g207103 , XZ_1498_g207103 , XZ_2498_g207103 , XZ_3498_g207103 , Bias498_g207103 , Weights_2498_g207103 , NormalWS498_g207103 , Normal498_g207103 );
				TEXTURE2D(Texture500_g207103) = _MainOcclusionTex;
				SamplerState Sampler500_g207103 = staticSwitch38_g207108;
				half2 ZY500_g207103 = temp_output_462_0_g207103;
				half2 ZY_1500_g207103 = (Out_MaskC456_g207103).zw;
				half2 ZY_2500_g207103 = (Out_MaskD456_g207103).xy;
				half2 ZY_3500_g207103 = (Out_MaskD456_g207103).zw;
				half2 XZ500_g207103 = temp_output_463_0_g207103;
				half2 XZ_1500_g207103 = temp_output_473_0_g207103;
				half2 XZ_2500_g207103 = temp_output_474_0_g207103;
				half2 XZ_3500_g207103 = temp_output_475_0_g207103;
				half2 XY500_g207103 = temp_output_464_0_g207103;
				half2 XY_1500_g207103 = (Out_MaskF456_g207103).zw;
				half2 XY_2500_g207103 = (Out_MaskG456_g207103).xy;
				half2 XY_3500_g207103 = (Out_MaskG456_g207103).zw;
				half Bias500_g207103 = temp_output_510_0_g207103;
				half3 Weights_1500_g207103 = (Out_MaskH456_g207103).xyz;
				half3 Weights_2500_g207103 = temp_output_480_0_g207103;
				half3 Weights_3500_g207103 = (Out_MaskJ456_g207103).xyz;
				half3 Triplanar500_g207103 = temp_output_482_0_g207103;
				half3 NormalWS500_g207103 = temp_output_483_0_g207103;
				half3 Normal500_g207103 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207103 = SampleStochastic3D( Texture500_g207103 , Sampler500_g207103 , ZY500_g207103 , ZY_1500_g207103 , ZY_2500_g207103 , ZY_3500_g207103 , XZ500_g207103 , XZ_1500_g207103 , XZ_2500_g207103 , XZ_3500_g207103 , XY500_g207103 , XY_1500_g207103 , XY_2500_g207103 , XY_3500_g207103 , Bias500_g207103 , Weights_1500_g207103 , Weights_2500_g207103 , Weights_3500_g207103 , Triplanar500_g207103 , NormalWS500_g207103 , Normal500_g207103 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch343_g207086 = localSampleCoord276_g207103;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch343_g207086 = localSampleCoord502_g207103;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch343_g207086 = localSamplePlanar2D496_g207103;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch343_g207086 = localSamplePlanar3D490_g207103;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch343_g207086 = localSampleStochastic2D498_g207103;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch343_g207086 = localSampleStochastic3D500_g207103;
				#else
				float4 staticSwitch343_g207086 = localSampleCoord276_g207103;
				#endif
				half4 Local_OcclusionTex349_g207086 = staticSwitch343_g207086;
				float4 ChannelA83_g251299 = Local_OcclusionTex349_g207086;
				float4 ChannelB83_g251299 = ( 1.0 - Local_OcclusionTex349_g207086 );
				float localSwitchChannel883_g251299 = SwitchChannel8( Option83_g251299 , ChannelA83_g251299 , ChannelB83_g251299 );
				float lerpResult373_g207086 = lerp( (Local_ShaderTex199_g207086).y , localSwitchChannel883_g251299 , _MainOcclusionSourceMode);
				float clampResult17_g251301 = clamp( lerpResult373_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251300 = _MainOcclusionRemap.x;
				float temp_output_9_0_g251300 = ( clampResult17_g251301 - temp_output_7_0_g251300 );
				float lerpResult23_g207086 = lerp( 1.0 , saturate( ( temp_output_9_0_g251300 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
				half Local_Occlusion313_g207086 = lerpResult23_g207086;
				float temp_output_17_0_g251307 = _MainSmoothnessChannelMode;
				float Option83_g251307 = temp_output_17_0_g251307;
				TEXTURE2D(Texture276_g207106) = _MainSmoothnessTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207107 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207106 = staticSwitch38_g207107;
				float localBreakTextureData456_g207106 = ( 0.0 );
				TVEMasksData Data456_g207106 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207106 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207106 , Out_MaskA456_g207106 , Out_MaskB456_g207106 , Out_MaskC456_g207106 , Out_MaskD456_g207106 , Out_MaskE456_g207106 , Out_MaskF456_g207106 , Out_MaskG456_g207106 , Out_MaskH456_g207106 , Out_MaskI456_g207106 , Out_MaskJ456_g207106 , Out_MaskK456_g207106 , Out_MaskL456_g207106 , Out_MaskM456_g207106 , Out_MaskN456_g207106 );
				half2 UV276_g207106 = (Out_MaskA456_g207106).xy;
				float temp_output_504_0_g207106 = 0.0;
				half Bias276_g207106 = temp_output_504_0_g207106;
				half2 Normal276_g207106 = float2( 0,0 );
				half4 localSampleCoord276_g207106 = SampleCoord( Texture276_g207106 , Sampler276_g207106 , UV276_g207106 , Bias276_g207106 , Normal276_g207106 );
				TEXTURE2D(Texture502_g207106) = _MainSmoothnessTex;
				SamplerState Sampler502_g207106 = staticSwitch38_g207107;
				half2 UV502_g207106 = (Out_MaskA456_g207106).zw;
				half Bias502_g207106 = temp_output_504_0_g207106;
				half2 Normal502_g207106 = float2( 0,0 );
				half4 localSampleCoord502_g207106 = SampleCoord( Texture502_g207106 , Sampler502_g207106 , UV502_g207106 , Bias502_g207106 , Normal502_g207106 );
				TEXTURE2D(Texture496_g207106) = _MainSmoothnessTex;
				SamplerState Sampler496_g207106 = staticSwitch38_g207107;
				float2 temp_output_463_0_g207106 = (Out_MaskB456_g207106).zw;
				half2 XZ496_g207106 = temp_output_463_0_g207106;
				half Bias496_g207106 = temp_output_504_0_g207106;
				float3 temp_output_483_0_g207106 = (Out_MaskK456_g207106).xyz;
				half3 NormalWS496_g207106 = temp_output_483_0_g207106;
				half3 Normal496_g207106 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207106 = SamplePlanar2D( Texture496_g207106 , Sampler496_g207106 , XZ496_g207106 , Bias496_g207106 , NormalWS496_g207106 , Normal496_g207106 );
				TEXTURE2D(Texture490_g207106) = _MainSmoothnessTex;
				SamplerState Sampler490_g207106 = staticSwitch38_g207107;
				float2 temp_output_462_0_g207106 = (Out_MaskB456_g207106).xy;
				half2 ZY490_g207106 = temp_output_462_0_g207106;
				half2 XZ490_g207106 = temp_output_463_0_g207106;
				float2 temp_output_464_0_g207106 = (Out_MaskC456_g207106).xy;
				half2 XY490_g207106 = temp_output_464_0_g207106;
				half Bias490_g207106 = temp_output_504_0_g207106;
				float3 temp_output_482_0_g207106 = (Out_MaskN456_g207106).xyz;
				half3 Triplanar490_g207106 = temp_output_482_0_g207106;
				half3 NormalWS490_g207106 = temp_output_483_0_g207106;
				half3 Normal490_g207106 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207106 = SamplePlanar3D( Texture490_g207106 , Sampler490_g207106 , ZY490_g207106 , XZ490_g207106 , XY490_g207106 , Bias490_g207106 , Triplanar490_g207106 , NormalWS490_g207106 , Normal490_g207106 );
				TEXTURE2D(Texture498_g207106) = _MainSmoothnessTex;
				SamplerState Sampler498_g207106 = staticSwitch38_g207107;
				half2 XZ498_g207106 = temp_output_463_0_g207106;
				float2 temp_output_473_0_g207106 = (Out_MaskE456_g207106).xy;
				half2 XZ_1498_g207106 = temp_output_473_0_g207106;
				float2 temp_output_474_0_g207106 = (Out_MaskE456_g207106).zw;
				half2 XZ_2498_g207106 = temp_output_474_0_g207106;
				float2 temp_output_475_0_g207106 = (Out_MaskF456_g207106).xy;
				half2 XZ_3498_g207106 = temp_output_475_0_g207106;
				float temp_output_510_0_g207106 = exp2( temp_output_504_0_g207106 );
				half Bias498_g207106 = temp_output_510_0_g207106;
				float3 temp_output_480_0_g207106 = (Out_MaskI456_g207106).xyz;
				half3 Weights_2498_g207106 = temp_output_480_0_g207106;
				half3 NormalWS498_g207106 = temp_output_483_0_g207106;
				half3 Normal498_g207106 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207106 = SampleStochastic2D( Texture498_g207106 , Sampler498_g207106 , XZ498_g207106 , XZ_1498_g207106 , XZ_2498_g207106 , XZ_3498_g207106 , Bias498_g207106 , Weights_2498_g207106 , NormalWS498_g207106 , Normal498_g207106 );
				TEXTURE2D(Texture500_g207106) = _MainSmoothnessTex;
				SamplerState Sampler500_g207106 = staticSwitch38_g207107;
				half2 ZY500_g207106 = temp_output_462_0_g207106;
				half2 ZY_1500_g207106 = (Out_MaskC456_g207106).zw;
				half2 ZY_2500_g207106 = (Out_MaskD456_g207106).xy;
				half2 ZY_3500_g207106 = (Out_MaskD456_g207106).zw;
				half2 XZ500_g207106 = temp_output_463_0_g207106;
				half2 XZ_1500_g207106 = temp_output_473_0_g207106;
				half2 XZ_2500_g207106 = temp_output_474_0_g207106;
				half2 XZ_3500_g207106 = temp_output_475_0_g207106;
				half2 XY500_g207106 = temp_output_464_0_g207106;
				half2 XY_1500_g207106 = (Out_MaskF456_g207106).zw;
				half2 XY_2500_g207106 = (Out_MaskG456_g207106).xy;
				half2 XY_3500_g207106 = (Out_MaskG456_g207106).zw;
				half Bias500_g207106 = temp_output_510_0_g207106;
				half3 Weights_1500_g207106 = (Out_MaskH456_g207106).xyz;
				half3 Weights_2500_g207106 = temp_output_480_0_g207106;
				half3 Weights_3500_g207106 = (Out_MaskJ456_g207106).xyz;
				half3 Triplanar500_g207106 = temp_output_482_0_g207106;
				half3 NormalWS500_g207106 = temp_output_483_0_g207106;
				half3 Normal500_g207106 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207106 = SampleStochastic3D( Texture500_g207106 , Sampler500_g207106 , ZY500_g207106 , ZY_1500_g207106 , ZY_2500_g207106 , ZY_3500_g207106 , XZ500_g207106 , XZ_1500_g207106 , XZ_2500_g207106 , XZ_3500_g207106 , XY500_g207106 , XY_1500_g207106 , XY_2500_g207106 , XY_3500_g207106 , Bias500_g207106 , Weights_1500_g207106 , Weights_2500_g207106 , Weights_3500_g207106 , Triplanar500_g207106 , NormalWS500_g207106 , Normal500_g207106 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch359_g207086 = localSampleCoord276_g207106;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch359_g207086 = localSampleCoord502_g207106;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch359_g207086 = localSamplePlanar2D496_g207106;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch359_g207086 = localSamplePlanar3D490_g207106;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch359_g207086 = localSampleStochastic2D498_g207106;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch359_g207086 = localSampleStochastic3D500_g207106;
				#else
				float4 staticSwitch359_g207086 = localSampleCoord276_g207106;
				#endif
				half4 Local_SmoothnessTex365_g207086 = staticSwitch359_g207086;
				float4 temp_output_28_0_g251309 = Local_SmoothnessTex365_g207086;
				float3 temp_output_29_0_g251309 = (temp_output_28_0_g251309).xyz;
				half3 linRGB27_g251309 = temp_output_29_0_g251309;
				half3 localLinearToGammaFloatFast27_g251309 = LinearToGammaFloatFast( linRGB27_g251309 );
				#ifdef UNITY_COLORSPACE_GAMMA
				float3 staticSwitch26_g251309 = temp_output_29_0_g251309;
				#else
				float3 staticSwitch26_g251309 = localLinearToGammaFloatFast27_g251309;
				#endif
				float4 appendResult31_g251309 = (float4(staticSwitch26_g251309 , (temp_output_28_0_g251309).w));
				float4 lerpResult439_g207086 = lerp( Local_SmoothnessTex365_g207086 , appendResult31_g251309 , _MainSmoothnessTexGammaMode);
				float4 ChannelA83_g251307 = lerpResult439_g207086;
				float4 ChannelB83_g251307 = ( 1.0 - lerpResult439_g207086 );
				float localSwitchChannel883_g251307 = SwitchChannel8( Option83_g251307 , ChannelA83_g251307 , ChannelB83_g251307 );
				float lerpResult374_g207086 = lerp( (Local_ShaderTex199_g207086).w , localSwitchChannel883_g251307 , _MainSmoothnessSourceMode);
				float clampResult17_g251306 = clamp( lerpResult374_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251305 = _MainSmoothnessRemap.x;
				float temp_output_9_0_g251305 = ( clampResult17_g251306 - temp_output_7_0_g251305 );
				half Local_Smoothness317_g207086 = ( saturate( ( temp_output_9_0_g251305 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
				float4 appendResult73_g207086 = (float4(Local_Metallic322_g207086 , Local_Occlusion313_g207086 , 0.0 , Local_Smoothness317_g207086));
				half4 Local_Masks109_g207086 = appendResult73_g207086;
				float temp_output_17_0_g251304 = _MainMultiChannelMode;
				float Option83_g251304 = temp_output_17_0_g251304;
				TEXTURE2D(Texture276_g207104) = _MainMultiTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207105 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207104 = staticSwitch38_g207105;
				float localBreakTextureData456_g207104 = ( 0.0 );
				TVEMasksData Data456_g207104 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207104 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207104 , Out_MaskA456_g207104 , Out_MaskB456_g207104 , Out_MaskC456_g207104 , Out_MaskD456_g207104 , Out_MaskE456_g207104 , Out_MaskF456_g207104 , Out_MaskG456_g207104 , Out_MaskH456_g207104 , Out_MaskI456_g207104 , Out_MaskJ456_g207104 , Out_MaskK456_g207104 , Out_MaskL456_g207104 , Out_MaskM456_g207104 , Out_MaskN456_g207104 );
				half2 UV276_g207104 = (Out_MaskA456_g207104).xy;
				float temp_output_504_0_g207104 = 0.0;
				half Bias276_g207104 = temp_output_504_0_g207104;
				half2 Normal276_g207104 = float2( 0,0 );
				half4 localSampleCoord276_g207104 = SampleCoord( Texture276_g207104 , Sampler276_g207104 , UV276_g207104 , Bias276_g207104 , Normal276_g207104 );
				TEXTURE2D(Texture502_g207104) = _MainMultiTex;
				SamplerState Sampler502_g207104 = staticSwitch38_g207105;
				half2 UV502_g207104 = (Out_MaskA456_g207104).zw;
				half Bias502_g207104 = temp_output_504_0_g207104;
				half2 Normal502_g207104 = float2( 0,0 );
				half4 localSampleCoord502_g207104 = SampleCoord( Texture502_g207104 , Sampler502_g207104 , UV502_g207104 , Bias502_g207104 , Normal502_g207104 );
				TEXTURE2D(Texture496_g207104) = _MainMultiTex;
				SamplerState Sampler496_g207104 = staticSwitch38_g207105;
				float2 temp_output_463_0_g207104 = (Out_MaskB456_g207104).zw;
				half2 XZ496_g207104 = temp_output_463_0_g207104;
				half Bias496_g207104 = temp_output_504_0_g207104;
				float3 temp_output_483_0_g207104 = (Out_MaskK456_g207104).xyz;
				half3 NormalWS496_g207104 = temp_output_483_0_g207104;
				half3 Normal496_g207104 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207104 = SamplePlanar2D( Texture496_g207104 , Sampler496_g207104 , XZ496_g207104 , Bias496_g207104 , NormalWS496_g207104 , Normal496_g207104 );
				TEXTURE2D(Texture490_g207104) = _MainMultiTex;
				SamplerState Sampler490_g207104 = staticSwitch38_g207105;
				float2 temp_output_462_0_g207104 = (Out_MaskB456_g207104).xy;
				half2 ZY490_g207104 = temp_output_462_0_g207104;
				half2 XZ490_g207104 = temp_output_463_0_g207104;
				float2 temp_output_464_0_g207104 = (Out_MaskC456_g207104).xy;
				half2 XY490_g207104 = temp_output_464_0_g207104;
				half Bias490_g207104 = temp_output_504_0_g207104;
				float3 temp_output_482_0_g207104 = (Out_MaskN456_g207104).xyz;
				half3 Triplanar490_g207104 = temp_output_482_0_g207104;
				half3 NormalWS490_g207104 = temp_output_483_0_g207104;
				half3 Normal490_g207104 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207104 = SamplePlanar3D( Texture490_g207104 , Sampler490_g207104 , ZY490_g207104 , XZ490_g207104 , XY490_g207104 , Bias490_g207104 , Triplanar490_g207104 , NormalWS490_g207104 , Normal490_g207104 );
				TEXTURE2D(Texture498_g207104) = _MainMultiTex;
				SamplerState Sampler498_g207104 = staticSwitch38_g207105;
				half2 XZ498_g207104 = temp_output_463_0_g207104;
				float2 temp_output_473_0_g207104 = (Out_MaskE456_g207104).xy;
				half2 XZ_1498_g207104 = temp_output_473_0_g207104;
				float2 temp_output_474_0_g207104 = (Out_MaskE456_g207104).zw;
				half2 XZ_2498_g207104 = temp_output_474_0_g207104;
				float2 temp_output_475_0_g207104 = (Out_MaskF456_g207104).xy;
				half2 XZ_3498_g207104 = temp_output_475_0_g207104;
				float temp_output_510_0_g207104 = exp2( temp_output_504_0_g207104 );
				half Bias498_g207104 = temp_output_510_0_g207104;
				float3 temp_output_480_0_g207104 = (Out_MaskI456_g207104).xyz;
				half3 Weights_2498_g207104 = temp_output_480_0_g207104;
				half3 NormalWS498_g207104 = temp_output_483_0_g207104;
				half3 Normal498_g207104 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207104 = SampleStochastic2D( Texture498_g207104 , Sampler498_g207104 , XZ498_g207104 , XZ_1498_g207104 , XZ_2498_g207104 , XZ_3498_g207104 , Bias498_g207104 , Weights_2498_g207104 , NormalWS498_g207104 , Normal498_g207104 );
				TEXTURE2D(Texture500_g207104) = _MainMultiTex;
				SamplerState Sampler500_g207104 = staticSwitch38_g207105;
				half2 ZY500_g207104 = temp_output_462_0_g207104;
				half2 ZY_1500_g207104 = (Out_MaskC456_g207104).zw;
				half2 ZY_2500_g207104 = (Out_MaskD456_g207104).xy;
				half2 ZY_3500_g207104 = (Out_MaskD456_g207104).zw;
				half2 XZ500_g207104 = temp_output_463_0_g207104;
				half2 XZ_1500_g207104 = temp_output_473_0_g207104;
				half2 XZ_2500_g207104 = temp_output_474_0_g207104;
				half2 XZ_3500_g207104 = temp_output_475_0_g207104;
				half2 XY500_g207104 = temp_output_464_0_g207104;
				half2 XY_1500_g207104 = (Out_MaskF456_g207104).zw;
				half2 XY_2500_g207104 = (Out_MaskG456_g207104).xy;
				half2 XY_3500_g207104 = (Out_MaskG456_g207104).zw;
				half Bias500_g207104 = temp_output_510_0_g207104;
				half3 Weights_1500_g207104 = (Out_MaskH456_g207104).xyz;
				half3 Weights_2500_g207104 = temp_output_480_0_g207104;
				half3 Weights_3500_g207104 = (Out_MaskJ456_g207104).xyz;
				half3 Triplanar500_g207104 = temp_output_482_0_g207104;
				half3 NormalWS500_g207104 = temp_output_483_0_g207104;
				half3 Normal500_g207104 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207104 = SampleStochastic3D( Texture500_g207104 , Sampler500_g207104 , ZY500_g207104 , ZY_1500_g207104 , ZY_2500_g207104 , ZY_3500_g207104 , XZ500_g207104 , XZ_1500_g207104 , XZ_2500_g207104 , XZ_3500_g207104 , XY500_g207104 , XY_1500_g207104 , XY_2500_g207104 , XY_3500_g207104 , Bias500_g207104 , Weights_1500_g207104 , Weights_2500_g207104 , Weights_3500_g207104 , Triplanar500_g207104 , NormalWS500_g207104 , Normal500_g207104 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch351_g207086 = localSampleCoord276_g207104;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch351_g207086 = localSampleCoord502_g207104;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch351_g207086 = localSamplePlanar2D496_g207104;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch351_g207086 = localSamplePlanar3D490_g207104;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch351_g207086 = localSampleStochastic2D498_g207104;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch351_g207086 = localSampleStochastic3D500_g207104;
				#else
				float4 staticSwitch351_g207086 = localSampleCoord276_g207104;
				#endif
				half4 Local_MultiTex357_g207086 = staticSwitch351_g207086;
				float4 ChannelA83_g251304 = Local_MultiTex357_g207086;
				float4 ChannelB83_g251304 = ( 1.0 - Local_MultiTex357_g207086 );
				float localSwitchChannel883_g251304 = SwitchChannel8( Option83_g251304 , ChannelA83_g251304 , ChannelB83_g251304 );
				float lerpResult378_g207086 = lerp( (Local_Masks109_g207086).z , localSwitchChannel883_g251304 , _MainMultiSourceMode);
				float clampResult17_g251302 = clamp( lerpResult378_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251303 = _MainMultiRemap.x;
				float temp_output_9_0_g251303 = ( clampResult17_g251302 - temp_output_7_0_g251303 );
				half Local_MultiMask78_g207086 = ( saturate( ( temp_output_9_0_g251303 * _MainMultiRemap.z ) ) * _MainMultiVlaue );
				float lerpResult58_g207086 = lerp( 1.0 , Local_MultiMask78_g207086 , _MainColorMode);
				float4 lerpResult62_g207086 = lerp( _MainColorTwo , _MainColor , lerpResult58_g207086);
				half3 Local_ColorRGB93_g207086 = (lerpResult62_g207086).rgb;
				half3 Local_Albedo139_g207086 = ( Local_AlbedoRGB107_g207086 * Local_ColorRGB93_g207086 );
				float3 temp_output_4_0_g207088 = Local_Albedo139_g207086;
				float3 In_Albedo3_g207088 = temp_output_4_0_g207088;
				float3 temp_output_44_0_g207088 = Local_Albedo139_g207086;
				float3 In_AlbedoBase3_g207088 = temp_output_44_0_g207088;
				TEXTURE2D(Texture276_g207094) = _MainNormalTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch37_g207095 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207094 = staticSwitch37_g207095;
				float localBreakTextureData456_g207094 = ( 0.0 );
				TVEMasksData Data456_g207094 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207094 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207094 , Out_MaskA456_g207094 , Out_MaskB456_g207094 , Out_MaskC456_g207094 , Out_MaskD456_g207094 , Out_MaskE456_g207094 , Out_MaskF456_g207094 , Out_MaskG456_g207094 , Out_MaskH456_g207094 , Out_MaskI456_g207094 , Out_MaskJ456_g207094 , Out_MaskK456_g207094 , Out_MaskL456_g207094 , Out_MaskM456_g207094 , Out_MaskN456_g207094 );
				half2 UV276_g207094 = (Out_MaskA456_g207094).xy;
				float temp_output_504_0_g207094 = 0.0;
				half Bias276_g207094 = temp_output_504_0_g207094;
				half2 Normal276_g207094 = float2( 0,0 );
				half4 localSampleCoord276_g207094 = SampleCoord( Texture276_g207094 , Sampler276_g207094 , UV276_g207094 , Bias276_g207094 , Normal276_g207094 );
				TEXTURE2D(Texture502_g207094) = _MainNormalTex;
				SamplerState Sampler502_g207094 = staticSwitch37_g207095;
				half2 UV502_g207094 = (Out_MaskA456_g207094).zw;
				half Bias502_g207094 = temp_output_504_0_g207094;
				half2 Normal502_g207094 = float2( 0,0 );
				half4 localSampleCoord502_g207094 = SampleCoord( Texture502_g207094 , Sampler502_g207094 , UV502_g207094 , Bias502_g207094 , Normal502_g207094 );
				TEXTURE2D(Texture496_g207094) = _MainNormalTex;
				SamplerState Sampler496_g207094 = staticSwitch37_g207095;
				float2 temp_output_463_0_g207094 = (Out_MaskB456_g207094).zw;
				half2 XZ496_g207094 = temp_output_463_0_g207094;
				half Bias496_g207094 = temp_output_504_0_g207094;
				float3 temp_output_483_0_g207094 = (Out_MaskK456_g207094).xyz;
				half3 NormalWS496_g207094 = temp_output_483_0_g207094;
				half3 Normal496_g207094 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207094 = SamplePlanar2D( Texture496_g207094 , Sampler496_g207094 , XZ496_g207094 , Bias496_g207094 , NormalWS496_g207094 , Normal496_g207094 );
				TEXTURE2D(Texture490_g207094) = _MainNormalTex;
				SamplerState Sampler490_g207094 = staticSwitch37_g207095;
				float2 temp_output_462_0_g207094 = (Out_MaskB456_g207094).xy;
				half2 ZY490_g207094 = temp_output_462_0_g207094;
				half2 XZ490_g207094 = temp_output_463_0_g207094;
				float2 temp_output_464_0_g207094 = (Out_MaskC456_g207094).xy;
				half2 XY490_g207094 = temp_output_464_0_g207094;
				half Bias490_g207094 = temp_output_504_0_g207094;
				float3 temp_output_482_0_g207094 = (Out_MaskN456_g207094).xyz;
				half3 Triplanar490_g207094 = temp_output_482_0_g207094;
				half3 NormalWS490_g207094 = temp_output_483_0_g207094;
				half3 Normal490_g207094 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207094 = SamplePlanar3D( Texture490_g207094 , Sampler490_g207094 , ZY490_g207094 , XZ490_g207094 , XY490_g207094 , Bias490_g207094 , Triplanar490_g207094 , NormalWS490_g207094 , Normal490_g207094 );
				TEXTURE2D(Texture498_g207094) = _MainNormalTex;
				SamplerState Sampler498_g207094 = staticSwitch37_g207095;
				half2 XZ498_g207094 = temp_output_463_0_g207094;
				float2 temp_output_473_0_g207094 = (Out_MaskE456_g207094).xy;
				half2 XZ_1498_g207094 = temp_output_473_0_g207094;
				float2 temp_output_474_0_g207094 = (Out_MaskE456_g207094).zw;
				half2 XZ_2498_g207094 = temp_output_474_0_g207094;
				float2 temp_output_475_0_g207094 = (Out_MaskF456_g207094).xy;
				half2 XZ_3498_g207094 = temp_output_475_0_g207094;
				float temp_output_510_0_g207094 = exp2( temp_output_504_0_g207094 );
				half Bias498_g207094 = temp_output_510_0_g207094;
				float3 temp_output_480_0_g207094 = (Out_MaskI456_g207094).xyz;
				half3 Weights_2498_g207094 = temp_output_480_0_g207094;
				half3 NormalWS498_g207094 = temp_output_483_0_g207094;
				half3 Normal498_g207094 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207094 = SampleStochastic2D( Texture498_g207094 , Sampler498_g207094 , XZ498_g207094 , XZ_1498_g207094 , XZ_2498_g207094 , XZ_3498_g207094 , Bias498_g207094 , Weights_2498_g207094 , NormalWS498_g207094 , Normal498_g207094 );
				TEXTURE2D(Texture500_g207094) = _MainNormalTex;
				SamplerState Sampler500_g207094 = staticSwitch37_g207095;
				half2 ZY500_g207094 = temp_output_462_0_g207094;
				half2 ZY_1500_g207094 = (Out_MaskC456_g207094).zw;
				half2 ZY_2500_g207094 = (Out_MaskD456_g207094).xy;
				half2 ZY_3500_g207094 = (Out_MaskD456_g207094).zw;
				half2 XZ500_g207094 = temp_output_463_0_g207094;
				half2 XZ_1500_g207094 = temp_output_473_0_g207094;
				half2 XZ_2500_g207094 = temp_output_474_0_g207094;
				half2 XZ_3500_g207094 = temp_output_475_0_g207094;
				half2 XY500_g207094 = temp_output_464_0_g207094;
				half2 XY_1500_g207094 = (Out_MaskF456_g207094).zw;
				half2 XY_2500_g207094 = (Out_MaskG456_g207094).xy;
				half2 XY_3500_g207094 = (Out_MaskG456_g207094).zw;
				half Bias500_g207094 = temp_output_510_0_g207094;
				half3 Weights_1500_g207094 = (Out_MaskH456_g207094).xyz;
				half3 Weights_2500_g207094 = temp_output_480_0_g207094;
				half3 Weights_3500_g207094 = (Out_MaskJ456_g207094).xyz;
				half3 Triplanar500_g207094 = temp_output_482_0_g207094;
				half3 NormalWS500_g207094 = temp_output_483_0_g207094;
				half3 Normal500_g207094 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207094 = SampleStochastic3D( Texture500_g207094 , Sampler500_g207094 , ZY500_g207094 , ZY_1500_g207094 , ZY_2500_g207094 , ZY_3500_g207094 , XZ500_g207094 , XZ_1500_g207094 , XZ_2500_g207094 , XZ_3500_g207094 , XY500_g207094 , XY_1500_g207094 , XY_2500_g207094 , XY_3500_g207094 , Bias500_g207094 , Weights_1500_g207094 , Weights_2500_g207094 , Weights_3500_g207094 , Triplanar500_g207094 , NormalWS500_g207094 , Normal500_g207094 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch193_g207086 = localSampleCoord276_g207094;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch193_g207086 = localSampleCoord502_g207094;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch193_g207086 = localSamplePlanar2D496_g207094;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch193_g207086 = localSamplePlanar3D490_g207094;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch193_g207086 = localSampleStochastic2D498_g207094;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch193_g207086 = localSampleStochastic3D500_g207094;
				#else
				float4 staticSwitch193_g207086 = localSampleCoord276_g207094;
				#endif
				half4 Local_NormaTex191_g207086 = staticSwitch193_g207086;
				half4 Normal_Packed45_g207089 = Local_NormaTex191_g207086;
				float2 appendResult58_g207089 = (float2(( (Normal_Packed45_g207089).x * (Normal_Packed45_g207089).w ) , (Normal_Packed45_g207089).y));
				half2 Normal_Default50_g207089 = appendResult58_g207089;
				half2 Normal_ASTC41_g207089 = (Normal_Packed45_g207089).xy;
				#ifdef UNITY_ASTC_NORMALMAP_ENCODING
				float2 staticSwitch38_g207089 = Normal_ASTC41_g207089;
				#else
				float2 staticSwitch38_g207089 = Normal_Default50_g207089;
				#endif
				half2 Normal_NO_DTX544_g207089 = (Normal_Packed45_g207089).wy;
				#ifdef UNITY_NO_DXT5nm
				float2 staticSwitch37_g207089 = Normal_NO_DTX544_g207089;
				#else
				float2 staticSwitch37_g207089 = staticSwitch38_g207089;
				#endif
				float2 temp_output_26_0_g207086 = ( (staticSwitch37_g207089*2.0 + -1.0) * _MainNormalValue );
				float3x3 ase_worldToTangent = float3x3( ase_tangentWS, ase_bitangentWS, ase_normalWS );
				half2 Normal_Planar45_g207090 = temp_output_26_0_g207086;
				float2 break71_g207090 = Normal_Planar45_g207090;
				float3 appendResult72_g207090 = (float3(break71_g207090.x , 0.0 , break71_g207090.y));
				float2 temp_output_205_0_g207086 = (mul( ase_worldToTangent, appendResult72_g207090 )).xy;
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#else
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#endif
				half2 Local_NormalTS108_g207086 = staticSwitch204_g207086;
				float2 In_NormalTS3_g207088 = Local_NormalTS108_g207086;
				float3 appendResult68_g207091 = (float3(Local_NormalTS108_g207086 , 1.0));
				float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
				float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
				float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
				float3 tanNormal74_g207091 = appendResult68_g207091;
				float3 worldNormal74_g207091 = normalize( float3( dot( tanToWorld0, tanNormal74_g207091 ), dot( tanToWorld1, tanNormal74_g207091 ), dot( tanToWorld2, tanNormal74_g207091 ) ) );
				half3 Local_NormalWS250_g207086 = worldNormal74_g207091;
				float3 In_NormalWS3_g207088 = Local_NormalWS250_g207086;
				float4 In_Shader3_g207088 = Local_Masks109_g207086;
				float4 In_Feature3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Season3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Emissive3_g207088 = half4( 1, 1, 1, 1 );
				float3 temp_output_3_0_g207092 = Local_Albedo139_g207086;
				float dotResult20_g207092 = dot( temp_output_3_0_g207092 , float3( 0.2126, 0.7152, 0.0722 ) );
				half Local_Grayscale110_g207086 = dotResult20_g207092;
				float temp_output_12_0_g207088 = Local_Grayscale110_g207086;
				float In_Grayscale3_g207088 = temp_output_12_0_g207088;
				float clampResult144_g207086 = clamp( saturate( ( Local_Grayscale110_g207086 * 5.0 ) ) , 0.2 , 1.0 );
				half Local_Luminosity145_g207086 = clampResult144_g207086;
				float temp_output_16_0_g207088 = Local_Luminosity145_g207086;
				float In_Luminosity3_g207088 = temp_output_16_0_g207088;
				float In_MultiMask3_g207088 = Local_MultiMask78_g207086;
				float temp_output_17_0_g251310 = _MainAlphaChannelMode;
				float Option83_g251310 = temp_output_17_0_g251310;
				TEXTURE2D(Texture276_g207099) = _MainAlphaTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g207100 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g207099 = staticSwitch36_g207100;
				float localBreakTextureData456_g207099 = ( 0.0 );
				TVEMasksData Data456_g207099 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207099 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207099 , Out_MaskA456_g207099 , Out_MaskB456_g207099 , Out_MaskC456_g207099 , Out_MaskD456_g207099 , Out_MaskE456_g207099 , Out_MaskF456_g207099 , Out_MaskG456_g207099 , Out_MaskH456_g207099 , Out_MaskI456_g207099 , Out_MaskJ456_g207099 , Out_MaskK456_g207099 , Out_MaskL456_g207099 , Out_MaskM456_g207099 , Out_MaskN456_g207099 );
				half2 UV276_g207099 = (Out_MaskA456_g207099).xy;
				float temp_output_504_0_g207099 = 0.0;
				half Bias276_g207099 = temp_output_504_0_g207099;
				half2 Normal276_g207099 = float2( 0,0 );
				half4 localSampleCoord276_g207099 = SampleCoord( Texture276_g207099 , Sampler276_g207099 , UV276_g207099 , Bias276_g207099 , Normal276_g207099 );
				TEXTURE2D(Texture502_g207099) = _MainAlphaTex;
				SamplerState Sampler502_g207099 = staticSwitch36_g207100;
				half2 UV502_g207099 = (Out_MaskA456_g207099).zw;
				half Bias502_g207099 = temp_output_504_0_g207099;
				half2 Normal502_g207099 = float2( 0,0 );
				half4 localSampleCoord502_g207099 = SampleCoord( Texture502_g207099 , Sampler502_g207099 , UV502_g207099 , Bias502_g207099 , Normal502_g207099 );
				TEXTURE2D(Texture496_g207099) = _MainAlphaTex;
				SamplerState Sampler496_g207099 = staticSwitch36_g207100;
				float2 temp_output_463_0_g207099 = (Out_MaskB456_g207099).zw;
				half2 XZ496_g207099 = temp_output_463_0_g207099;
				half Bias496_g207099 = temp_output_504_0_g207099;
				float3 temp_output_483_0_g207099 = (Out_MaskK456_g207099).xyz;
				half3 NormalWS496_g207099 = temp_output_483_0_g207099;
				half3 Normal496_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207099 = SamplePlanar2D( Texture496_g207099 , Sampler496_g207099 , XZ496_g207099 , Bias496_g207099 , NormalWS496_g207099 , Normal496_g207099 );
				TEXTURE2D(Texture490_g207099) = _MainAlphaTex;
				SamplerState Sampler490_g207099 = staticSwitch36_g207100;
				float2 temp_output_462_0_g207099 = (Out_MaskB456_g207099).xy;
				half2 ZY490_g207099 = temp_output_462_0_g207099;
				half2 XZ490_g207099 = temp_output_463_0_g207099;
				float2 temp_output_464_0_g207099 = (Out_MaskC456_g207099).xy;
				half2 XY490_g207099 = temp_output_464_0_g207099;
				half Bias490_g207099 = temp_output_504_0_g207099;
				float3 temp_output_482_0_g207099 = (Out_MaskN456_g207099).xyz;
				half3 Triplanar490_g207099 = temp_output_482_0_g207099;
				half3 NormalWS490_g207099 = temp_output_483_0_g207099;
				half3 Normal490_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207099 = SamplePlanar3D( Texture490_g207099 , Sampler490_g207099 , ZY490_g207099 , XZ490_g207099 , XY490_g207099 , Bias490_g207099 , Triplanar490_g207099 , NormalWS490_g207099 , Normal490_g207099 );
				TEXTURE2D(Texture498_g207099) = _MainAlphaTex;
				SamplerState Sampler498_g207099 = staticSwitch36_g207100;
				half2 XZ498_g207099 = temp_output_463_0_g207099;
				float2 temp_output_473_0_g207099 = (Out_MaskE456_g207099).xy;
				half2 XZ_1498_g207099 = temp_output_473_0_g207099;
				float2 temp_output_474_0_g207099 = (Out_MaskE456_g207099).zw;
				half2 XZ_2498_g207099 = temp_output_474_0_g207099;
				float2 temp_output_475_0_g207099 = (Out_MaskF456_g207099).xy;
				half2 XZ_3498_g207099 = temp_output_475_0_g207099;
				float temp_output_510_0_g207099 = exp2( temp_output_504_0_g207099 );
				half Bias498_g207099 = temp_output_510_0_g207099;
				float3 temp_output_480_0_g207099 = (Out_MaskI456_g207099).xyz;
				half3 Weights_2498_g207099 = temp_output_480_0_g207099;
				half3 NormalWS498_g207099 = temp_output_483_0_g207099;
				half3 Normal498_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207099 = SampleStochastic2D( Texture498_g207099 , Sampler498_g207099 , XZ498_g207099 , XZ_1498_g207099 , XZ_2498_g207099 , XZ_3498_g207099 , Bias498_g207099 , Weights_2498_g207099 , NormalWS498_g207099 , Normal498_g207099 );
				TEXTURE2D(Texture500_g207099) = _MainAlphaTex;
				SamplerState Sampler500_g207099 = staticSwitch36_g207100;
				half2 ZY500_g207099 = temp_output_462_0_g207099;
				half2 ZY_1500_g207099 = (Out_MaskC456_g207099).zw;
				half2 ZY_2500_g207099 = (Out_MaskD456_g207099).xy;
				half2 ZY_3500_g207099 = (Out_MaskD456_g207099).zw;
				half2 XZ500_g207099 = temp_output_463_0_g207099;
				half2 XZ_1500_g207099 = temp_output_473_0_g207099;
				half2 XZ_2500_g207099 = temp_output_474_0_g207099;
				half2 XZ_3500_g207099 = temp_output_475_0_g207099;
				half2 XY500_g207099 = temp_output_464_0_g207099;
				half2 XY_1500_g207099 = (Out_MaskF456_g207099).zw;
				half2 XY_2500_g207099 = (Out_MaskG456_g207099).xy;
				half2 XY_3500_g207099 = (Out_MaskG456_g207099).zw;
				half Bias500_g207099 = temp_output_510_0_g207099;
				half3 Weights_1500_g207099 = (Out_MaskH456_g207099).xyz;
				half3 Weights_2500_g207099 = temp_output_480_0_g207099;
				half3 Weights_3500_g207099 = (Out_MaskJ456_g207099).xyz;
				half3 Triplanar500_g207099 = temp_output_482_0_g207099;
				half3 NormalWS500_g207099 = temp_output_483_0_g207099;
				half3 Normal500_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207099 = SampleStochastic3D( Texture500_g207099 , Sampler500_g207099 , ZY500_g207099 , ZY_1500_g207099 , ZY_2500_g207099 , ZY_3500_g207099 , XZ500_g207099 , XZ_1500_g207099 , XZ_2500_g207099 , XZ_3500_g207099 , XY500_g207099 , XY_1500_g207099 , XY_2500_g207099 , XY_3500_g207099 , Bias500_g207099 , Weights_1500_g207099 , Weights_2500_g207099 , Weights_3500_g207099 , Triplanar500_g207099 , NormalWS500_g207099 , Normal500_g207099 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch327_g207086 = localSampleCoord276_g207099;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch327_g207086 = localSampleCoord502_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch327_g207086 = localSamplePlanar2D496_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch327_g207086 = localSamplePlanar3D490_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch327_g207086 = localSampleStochastic2D498_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch327_g207086 = localSampleStochastic3D500_g207099;
				#else
				float4 staticSwitch327_g207086 = localSampleCoord276_g207099;
				#endif
				half4 Local_AlphaTex330_g207086 = staticSwitch327_g207086;
				float4 temp_output_28_0_g251311 = Local_AlphaTex330_g207086;
				float3 temp_output_29_0_g251311 = (temp_output_28_0_g251311).xyz;
				half3 linRGB27_g251311 = temp_output_29_0_g251311;
				half3 localLinearToGammaFloatFast27_g251311 = LinearToGammaFloatFast( linRGB27_g251311 );
				#ifdef UNITY_COLORSPACE_GAMMA
				float3 staticSwitch26_g251311 = temp_output_29_0_g251311;
				#else
				float3 staticSwitch26_g251311 = localLinearToGammaFloatFast27_g251311;
				#endif
				float4 appendResult31_g251311 = (float4(staticSwitch26_g251311 , (temp_output_28_0_g251311).w));
				float4 lerpResult442_g207086 = lerp( Local_AlphaTex330_g207086 , appendResult31_g251311 , _MainAlphaTexIsGamma);
				float4 ChannelA83_g251310 = lerpResult442_g207086;
				float4 ChannelB83_g251310 = ( 1.0 - lerpResult442_g207086 );
				float localSwitchChannel883_g251310 = SwitchChannel8( Option83_g251310 , ChannelA83_g251310 , ChannelB83_g251310 );
				float lerpResult385_g207086 = lerp( (Local_AlbedoTex185_g207086).w , localSwitchChannel883_g251310 , _MainAlphaSourceMode);
				#ifdef TVE_CLIPPING
				float staticSwitch236_g207086 = ( lerpResult385_g207086 - _MainAlphaClipValue );
				#else
				float staticSwitch236_g207086 = lerpResult385_g207086;
				#endif
				half Local_AlphaClip111_g207086 = staticSwitch236_g207086;
				float In_AlphaClip3_g207088 = Local_AlphaClip111_g207086;
				half Local_AlphaFade246_g207086 = (lerpResult62_g207086).a;
				float In_AlphaFade3_g207088 = Local_AlphaFade246_g207086;
				float3 temp_cast_10 = (1.0).xxx;
				float3 In_Translucency3_g207088 = temp_cast_10;
				float In_Transmission3_g207088 = 1.0;
				float In_Thickness3_g207088 = 0.0;
				float In_Diffusion3_g207088 = 0.0;
				float In_Depth3_g207088 = 0.0;
				BuildVisualData( Data3_g207088 , In_Dummy3_g207088 , In_Albedo3_g207088 , In_AlbedoBase3_g207088 , In_NormalTS3_g207088 , In_NormalWS3_g207088 , In_Shader3_g207088 , In_Feature3_g207088 , In_Season3_g207088 , In_Emissive3_g207088 , In_Grayscale3_g207088 , In_Luminosity3_g207088 , In_MultiMask3_g207088 , In_AlphaClip3_g207088 , In_AlphaFade3_g207088 , In_Translucency3_g207088 , In_Transmission3_g207088 , In_Thickness3_g207088 , In_Diffusion3_g207088 , In_Depth3_g207088 );
				TVEVisualData Data4_g251314 =(TVEVisualData)Data3_g207088;
				float Out_Dummy4_g251314 = 0.0;
				float3 Out_Albedo4_g251314 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g251314 = float3( 0,0,0 );
				float2 Out_NormalTS4_g251314 = float2( 0,0 );
				float3 Out_NormalWS4_g251314 = float3( 0,0,0 );
				float4 Out_Shader4_g251314 = float4( 0,0,0,0 );
				float4 Out_Feature4_g251314 = float4( 0,0,0,0 );
				float4 Out_Season4_g251314 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g251314 = float4( 0,0,0,0 );
				float Out_MultiMask4_g251314 = 0.0;
				float Out_Grayscale4_g251314 = 0.0;
				float Out_Luminosity4_g251314 = 0.0;
				float Out_AlphaClip4_g251314 = 0.0;
				float Out_AlphaFade4_g251314 = 0.0;
				float3 Out_Translucency4_g251314 = float3( 0,0,0 );
				float Out_Transmission4_g251314 = 0.0;
				float Out_Thickness4_g251314 = 0.0;
				float Out_Diffusion4_g251314 = 0.0;
				float Out_Depth4_g251314 = 0.0;
				BreakVisualData( Data4_g251314 , Out_Dummy4_g251314 , Out_Albedo4_g251314 , Out_AlbedoBase4_g251314 , Out_NormalTS4_g251314 , Out_NormalWS4_g251314 , Out_Shader4_g251314 , Out_Feature4_g251314 , Out_Season4_g251314 , Out_Emissive4_g251314 , Out_MultiMask4_g251314 , Out_Grayscale4_g251314 , Out_Luminosity4_g251314 , Out_AlphaClip4_g251314 , Out_AlphaFade4_g251314 , Out_Translucency4_g251314 , Out_Transmission4_g251314 , Out_Thickness4_g251314 , Out_Diffusion4_g251314 , Out_Depth4_g251314 );
				half3 Input_Albedo24_g251315 = Out_Albedo4_g251314;
				#ifdef UNITY_COLORSPACE_GAMMA
				float4 staticSwitch22_g251315 = half4( 0.2209163, 0.2209163, 0.2209163, 0.7790837 );
				#else
				float4 staticSwitch22_g251315 = half4( 0.04, 0.04, 0.04, 0.96 );
				#endif
				half4 ColorSpaceDielectricSpec23_g251315 = staticSwitch22_g251315;
				float4 break24_g251313 = Out_Shader4_g251314;
				half Metallic95_g251313 = break24_g251313.x;
				half Input_Metallic25_g251315 = Metallic95_g251313;
				half OneMinusReflectivity31_g251315 = ( (ColorSpaceDielectricSpec23_g251315).w - ( (ColorSpaceDielectricSpec23_g251315).w * Input_Metallic25_g251315 ) );
				float3 temp_output_6_0_g251331 = ( Input_Albedo24_g251315 * OneMinusReflectivity31_g251315 );
				half Render_Common200_g251313 = ( _RenderCull + _RenderZWrite + _RenderQueue + _RenderPriority + _RenderBakeGI + _RenderNormal + _RenderFilter + _RenderClip + _DisableSRPBatcher );
				half Render_Motion186_g251313 = _RenderMotion;
				half Render_URPOnly190_g251313 = ( _RenderShadow + _RenderMotionXR + _RenderGBuffer + Render_Motion186_g251313 );
				half Render_Pipeline184_g251313 = ( Render_Common200_g251313 + Render_URPOnly190_g251313 );
				float temp_output_7_0_g251331 = Render_Pipeline184_g251313;
				float temp_output_17_0_g251331 = ( temp_output_7_0_g251331 + 0.0 );
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g251331 = ( temp_output_6_0_g251331 + temp_output_17_0_g251331 );
				#else
				float3 staticSwitch14_g251331 = temp_output_6_0_g251331;
				#endif
				

				float3 BaseColor = staticSwitch14_g251331;
				float Alpha = 1;
				#if defined( _ALPHATEST_ON )
					float AlphaClipThreshold = _Cutoff;
				#endif

				half4 color = half4(BaseColor, Alpha );

				#if defined( _ALPHATEST_ON )
					AlphaDiscard( Alpha, AlphaClipThreshold );
				#endif

				return color;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthNormals"
			Tags { "LightMode"="DepthNormals" }

			ZWrite On
			Blend One Zero
			ZTest LEqual
			ZWrite On

			HLSLPROGRAM

			#define ASE_GEOMETRY
			#define ASE_OPAQUE_KEEP_ALPHA
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#define _NORMALMAP 1
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION 170300
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#if defined( _SPECULAR_SETUP ) && defined( ASE_LIGHTING_SIMPLE )
				#if defined( _SPECULARHIGHLIGHTS_OFF )
					#undef _SPECULAR_COLOR
				#else
					#define _SPECULAR_COLOR
				#endif
			#endif

			#define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
			//#define SHADERPASS SHADERPASS_DEPTHNORMALS

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#if defined( UNITY_INSTANCING_ENABLED ) && defined( ASE_INSTANCED_TERRAIN ) && ( defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL) || defined(_INSTANCEDTERRAINNORMALS_PIXEL) )
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
			#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
			#pragma shader_feature_local_fragment TVE_CLIPPING
			#if defined (TVE_CLIPPING) //Render Clip
				#define TVE_ALPHA_CLIP //Render Clip
			#endif //Render Clip
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END
			  
			struct TVEVisualData
			{  
				half Dummy;  
				half3 Albedo;
				half3 AlbedoBase;
				half2 NormalTS;
				half3 NormalWS; 
				half4 Shader;
				half4 Feature;
				half4 Season;
				float4 Emissive;
				half AlphaClip;
				half AlphaFade;
				half MultiMask;
				half Grayscale;
				half Luminosity;
				float3 Translucency;
				half Transmission;
				half Thickness;
				float Diffusion;
				float Depth;
			};  
			    
			struct TVEModelData
			{    
				half Dummy;    
				float3 PositionOS;
				float3 PositionWS;
				float3 PositionWO;
				float3 PositionRawOS;
				float3 PivotOS;
				float3 PivotWS;
				float3 PivotWO;
				half3 NormalOS;
				half3 NormalWS;
				half3 NormalRawOS;
				half4 TangentOS;
				half3 TangentWS;
				half3 BitangentWS;
				half3 TriplanarWeights;
				half3 ViewDirWS;
				float4 CoordsData;
				half4 VertexData;
				half4 MasksData;   
				half4 PhaseData;
				half4 TransformData;
				half4 RotationData;
				float4 InterpolatorA;
			};    
			      
			struct TVEGlobalData
			{      
				half Dummy;      
				half4 CoatParams;
				half4 CoatTexture;
				half4 PaintParams;
				half4 PaintTexture;
				half4 AtmoParams;
				half4 AtmoTexture;
				half4 GlowParams;
				half4 GlowTexture;
				float4 FormParams;
				float4 FormTexture;
				half4 FlowParams;
				half4 FlowTexture;
			};      
			        
			struct TVEMasksData
			{        
				half4 MaskA;
				half4 MaskB;
				half4 MaskC;
				half4 MaskD;
				half4 MaskE;
				half4 MaskF;
				half4 MaskG;
				half4 MaskH;
				half4 MaskI;
				half4 MaskJ;
				half4 MaskK;
				half4 MaskL;
				half4 MaskM;
				half4 MaskN;
			};        
			#define TVE_GEOMETRY_SHADER


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				half4 texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				half3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2; // holds terrainUV ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			half4 _MainOcclusionRemap;
			half4 _MainColor;
			half4 _MainColorTwo;
			half4 _MainMultiRemap;
			half4 _main_coord_value;
			half4 _MainSmoothnessRemap;
			half4 _MainCoordValue;
			half3 _render_normal;
			half _MainMultiVlaue;
			half _MainMultiSourceMode;
			half _MainMultiChannelMode;
			half _MainSmoothnessSourceMode;
			half _MainColorMode;
			float _MainSmoothnessTexGammaMode;
			half _MainSmoothnessChannelMode;
			half _MainOcclusionValue;
			half _MainSmoothnessValue;
			half _render_src;
			half _MainNormalValue;
			float _MainAlphaTexIsGamma;
			half _RenderMotion;
			half _RenderGBuffer;
			half _RenderMotionXR;
			half _RenderShadow;
			half _RenderClip;
			half _RenderFilter;
			half _MainAlphaChannelMode;
			half _RenderNormal;
			half _RenderPriority;
			half _RenderQueue;
			half _RenderZWrite;
			half _RenderCull;
			half _MainAlphaClipValue;
			half _MainAlphaSourceMode;
			half _RenderBakeGI;
			half _MainOcclusionSourceMode;
			half _MainMetallicSourceMode;
			half _MainMetallicValue;
			half _render_cull;
			half _render_dst;
			half _render_zw;
			half _render_coverage;
			half _IsGeneralShader;
			half _RenderEnd;
			half _IsVersion;
			half _IsTVEShader;
			half _IsLightingType;
			half _IsCustomShader;
			half _IsCollected;
			half _IsConverted;
			half _IsIdentifier;
			half _MainOcclusionChannelMode;
			half _IsShared;
			half _IsShaderType;
			half _IsObjectType;
			half _RenderCategory;
			half _IsStandardShader;
			half _MainCategory;
			half _MainEnd;
			half _MainSampleMode;
			half _MainCoordMode;
			half _MainMultiMaskInfo;
			half _MainSmoothnessInfo;
			half _ObjectPhaseMode;
			half _MainAlbedoValue;
			half _MainMetallicChannelMode;
			half _UseExternalSettings;
			half _RenderSpecular;
			float _AlphaClip;
			float _Cutoff;
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
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_Linear_Repeat_Aniso8);
			SAMPLER(sampler_Point_Repeat);
			SAMPLER(sampler_Linear_Repeat);
			float3 TVE_WorldOrigin;
			TEXTURE2D(_MainShaderTex);
			TEXTURE2D(_MainMetallicTex);
			TEXTURE2D(_MainOcclusionTex);
			TEXTURE2D(_MainSmoothnessTex);
			TEXTURE2D(_MainMultiTex);
			TEXTURE2D(_MainNormalTex);
			TEXTURE2D(_MainAlphaTex);


			half3 ComputeTriplanarWeights( half3 NormalWS )
			{
				half3 powNormal = abs( NormalWS );
				half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
				tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
				return tempWeights;
			}
			
			float SwitchChannel4( half Option, half4 Channel )
			{
				switch (Option) {
					default:
				                case 0:
						return Channel.x;
					case 1:
						return Channel.y;
					case 2:
						return Channel.z;
					case 3:
						return Channel.w;
				}
			}
			
			void BuildModelFragData( out TVEModelData Data, half In_Dummy, float3 In_PositionWS, float3 In_PositionWO, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalWS, half3 In_TangentWS, half3 In_BitangentWS, half3 In_TriplanarWeights, half3 In_ViewDirWS, half4 In_CoordsData, half4 In_VertexData, half4 In_PhaseData )
			{
				Data = (TVEModelData)0;
				Data.Dummy = In_Dummy;
				Data.PositionWS = In_PositionWS;
				Data.PositionWO = In_PositionWO;
				Data.PivotWS = In_PivotWS;
				Data.PivotWO = In_PivotWO;
				Data.NormalWS = In_NormalWS;
				Data.TangentWS = In_TangentWS;
				Data.BitangentWS = In_BitangentWS;
				Data.TriplanarWeights = In_TriplanarWeights;
				Data.ViewDirWS = In_ViewDirWS;
				Data.CoordsData = In_CoordsData;
				Data.VertexData = In_VertexData;
				Data.PhaseData = In_PhaseData;
				return;
			}
			
			void BreakModelFragData( inout TVEModelData Data, out half Out_Dummy, out float3 Out_PositionWS, out float3 Out_PositionWO, out float3 Out_PivotWS, out float3 Out_PivotWO, out half3 Out_NormalWS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_TriplanarWeights, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_PhaseData )
			{
				Out_Dummy = Data.Dummy;
				Out_PositionWS = Data.PositionWS;
				Out_PositionWO = Data.PositionWO;
				Out_PivotWS = Data.PivotWS;
				Out_PivotWO = Data.PivotWO;
				Out_NormalWS = Data.NormalWS;
				Out_TangentWS = Data.TangentWS;
				Out_BitangentWS = Data.BitangentWS;
				Out_TriplanarWeights = Data.TriplanarWeights;
				Out_ViewDirWS = Data.ViewDirWS;
				Out_CoordsData = Data.CoordsData;
				Out_VertexData = Data.VertexData;
				Out_PhaseData = Data.PhaseData;
				return;
			}
			
			void ComputeMeshCoords( float4 Coords, float4 MeshCoords, out float2 UV0, out float2 UV3 )
			{
				UV0 = MeshCoords.xy * Coords.xy - Coords.zw; 
				UV3 = MeshCoords.zw * Coords.xy - Coords.zw; 
				return;
			}
			
			void ComputeWorldCoords( float4 Coords, float3 PositionWS, out float2 ZY, out float2 XZ, out float2 XY )
			{
				ZY = PositionWS.zy * Coords.xy - Coords.zw; 
				XZ = PositionWS.xz * Coords.xx - Coords.zz;
				XY = PositionWS.xy * Coords.xy - Coords.zw;
				return;
			}
			
			float2 ComputeStochasticHash22( float2 p )
			{
				float3 p3 = frac(float3(p.xyx) * float3(.1031, .1030, .0973));
				p3 += dot(p3, p3.yzx+33.33);
				return frac((p3.xx+p3.yz)*p3.zy);
			}
			
			void ComputeStochasticCoords( inout float2 UV, out float2 UV1, out float2 UV2, out float2 UV3, out float3 Weights )
			{
				half2 vertex1, vertex2, vertex3;
				// Scaling of the input
				half2 uv = UV * 3.464; // 2 * sqrt (3)
				// Skew input space into simplex triangle grid
				const float2x2 gridToSkewedGrid = float2x2( 1.0, 0.0, -0.57735027, 1.15470054 );
				half2 skewedCoord = mul( gridToSkewedGrid, uv );
				// Compute local triangle vertex IDs and local barycentric coordinates
				int2 baseId = int2( floor( skewedCoord ) );
				half3 temp = half3( frac( skewedCoord ), 0 );
				temp.z = 1.0 - temp.x - temp.y;
				if ( temp.z > 0.0 )
				{
					Weights.x = temp.z;
					Weights.y = temp.y;
					Weights.z = temp.x;
					vertex1 = baseId;
					vertex2 = baseId + int2( 0, 1 );
					vertex3 = baseId + int2( 1, 0 );
				}
				else
				{
					Weights.x = -temp.z;
					Weights.y = 1.0 - temp.y;
					Weights.z = 1.0 - temp.x;
					vertex1 = baseId + int2( 1, 1 );
					vertex2 = baseId + int2( 1, 0 );
					vertex3 = baseId + int2( 0, 1 );
				}
				UV1 = UV + ComputeStochasticHash22(vertex1);
				UV2 = UV + ComputeStochasticHash22(vertex2);
				UV3 = UV + ComputeStochasticHash22(vertex3);
				return;
			}
			
			void BuildTextureData( out TVEMasksData Data, float4 In_MaskA, float4 In_MaskB, float4 In_MaskC, float4 In_MaskD, float4 In_MaskE, float4 In_MaskF, float4 In_MaskG, half4 In_MaskH, half4 In_MaskI, half4 In_MaskJ, half4 In_MaskK, half4 In_MaskL, half4 In_MaskM, half4 In_MaskN )
			{
				Data.MaskA = In_MaskA;
				Data.MaskB = In_MaskB;
				Data.MaskC = In_MaskC;
				Data.MaskD = In_MaskD;
				Data.MaskE = In_MaskE;
				Data.MaskF = In_MaskF;
				Data.MaskG = In_MaskG;
				Data.MaskH = In_MaskH;
				Data.MaskI = In_MaskI;
				Data.MaskJ = In_MaskJ;
				Data.MaskK = In_MaskK;
				Data.MaskL = In_MaskL;
				Data.MaskM = In_MaskM;
				Data.MaskN = In_MaskN;
				return;
			}
			
			void BreakTextureData( TVEMasksData Data, out float4 Out_MaskA, out float4 Out_MaskB, out float4 Out_MaskC, out float4 Out_MaskD, out float4 Out_MaskE, out float4 Out_MaskF, out half4 Out_MaskG, out half4 Out_MaskH, out half4 Out_MaskI, out half4 Out_MaskJ, out half4 Out_MaskK, out half4 Out_MaskL, out half4 Out_MaskM, out half4 Out_MaskN )
			{
				Out_MaskA = Data.MaskA;
				Out_MaskB = Data.MaskB;
				Out_MaskC = Data.MaskC;
				Out_MaskD = Data.MaskD;
				Out_MaskE = Data.MaskE;
				Out_MaskF = Data.MaskF;
				Out_MaskG = Data.MaskG;
				Out_MaskH = Data.MaskH;
				Out_MaskI = Data.MaskI;
				Out_MaskJ = Data.MaskJ;
				Out_MaskK = Data.MaskK;
				Out_MaskL = Data.MaskL;
				Out_MaskM = Data.MaskM;
				Out_MaskN = Data.MaskN;
				return;
			}
			
			half4 SampleCoord( TEXTURE2D(Texture), SamplerState Sampler, half2 UV, half Bias, out half2 Normal )
			{
				half4 tex = SAMPLE_TEXTURE2D_BIAS( Texture, Sampler, UV, Bias);
				Normal = tex.wy * 2.0 - 1.0;
				return tex;
			}
			
			half4 SamplePlanar2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, half Bias, half3 NormalWS, out half3 Normal )
			{
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SamplePlanar3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 XZ, float2 XY, half Bias, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				half4 tex_X = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, ZY, Bias);
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half4 tex_Z = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XY, Bias);
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal =  normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			half4 SampleStochastic2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, half Bias, half3 Weights_2, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SampleStochastic3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 ZY_1, float2 ZY_2, float2 ZY_3, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, float2 XY, float2 XY_1, float2 XY_2, float2 XY_3, half Bias, half3 Weights_1, half3 Weights_2, half3 Weights_3, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_X = ddx(ZY) * Bias;
				float2 ddy_X= ddy(ZY) * Bias;
				half4 tex1_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_1, ddx_X, ddy_X);
				half4 tex2_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_2, ddx_X, ddy_X);
				half4 tex3_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_3, ddx_X, ddy_X);
				half4 tex_X = tex1_X * Weights_1.x + tex2_X * Weights_1.y + tex3_X * Weights_1.z;
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				float2 ddx_Z = ddx(XY) * Bias;
				float2 ddy_Z= ddy(XY) * Bias;
				half4 tex1_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_1, ddx_Z, ddy_Z);
				half4 tex2_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_2, ddx_Z, ddy_Z);
				half4 tex3_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_3, ddx_Z, ddy_Z);
				half4 tex_Z = tex1_Z * Weights_3.x + tex2_Z * Weights_3.y + tex3_Z * Weights_3.z;
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal = normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			float SwitchChannel8( half Option, half4 ChannelA, half4 ChannelB )
			{
				switch (Option) {
					default:
				                case 0:
						return ChannelA.x;
					case 1:
						return ChannelA.y;
					case 2:
						return ChannelA.z;
					case 3:
						return ChannelA.w;
				                case 4:
						return ChannelB.x;
					case 5:
						return ChannelB.y;
					case 6:
						return ChannelB.z;
					case 7:
						return ChannelB.w;
				}
			}
			
			half3 LinearToGammaFloatFast( half3 linRGB )
			{
				return max(1.055h * pow(abs(linRGB), 0.416666667h) - 0.055h, 0.h);
			}
			
			void BuildVisualData( inout TVEVisualData Data, float In_Dummy, half3 In_Albedo, half3 In_AlbedoBase, half2 In_NormalTS, half3 In_NormalWS, half4 In_Shader, half4 In_Feature, half4 In_Season, half4 In_Emissive, half In_Grayscale, half In_Luminosity, half In_MultiMask, half In_AlphaClip, half In_AlphaFade, half3 In_Translucency, half In_Transmission, half In_Thickness, float In_Diffusion, float In_Depth )
			{
				//Data = (TVEVisualData)0;
				Data.Dummy = In_Dummy;
				Data.Albedo = In_Albedo;
				Data.AlbedoBase = In_AlbedoBase;
				Data.NormalTS = In_NormalTS;
				Data.NormalWS = In_NormalWS;
				Data.Shader = In_Shader;
				Data.Feature = In_Feature;
				Data.Season= In_Season;
				Data.Emissive= In_Emissive;
				Data.MultiMask = In_MultiMask;
				Data.Grayscale = In_Grayscale;
				Data.Luminosity = In_Luminosity;
				Data.AlphaClip = In_AlphaClip;
				Data.AlphaFade = In_AlphaFade;
				Data.Translucency = In_Translucency;
				Data.Transmission = In_Transmission;
				Data.Thickness = In_Thickness;
				Data.Diffusion = In_Diffusion;
				Data.Depth = In_Depth;
				return;
			}
			
			void BreakVisualData( inout TVEVisualData Data, out half Out_Dummy, out half3 Out_Albedo, out half3 Out_AlbedoBase, out half2 Out_NormalTS, out half3 Out_NormalWS, out half4 Out_Shader, out half4 Out_Feature, out half4 Out_Season, out half4 Out_Emissive, out half Out_MultiMask, out half Out_Grayscale, out half Out_Luminosity, out half Out_AlphaClip, out half Out_AlphaFade, out half3 Out_Translucency, out half Out_Transmission, out half Out_Thickness, out half Out_Diffusion, out float Out_Depth )
			{
				Out_Dummy = Data.Dummy;
				Out_Albedo = Data.Albedo;
				Out_AlbedoBase = Data.AlbedoBase;
				Out_NormalTS = Data.NormalTS;
				Out_NormalWS = Data.NormalWS;
				Out_Shader = Data.Shader;
				Out_Feature = Data.Feature;
				Out_Season = Data.Season;
				Out_Emissive= Data.Emissive;
				Out_MultiMask = Data.MultiMask;
				Out_Grayscale = Data.Grayscale;
				Out_Luminosity= Data.Luminosity;
				Out_AlphaClip = Data.AlphaClip;
				Out_AlphaFade = Data.AlphaFade;
				Out_Translucency = Data.Translucency;
				Out_Transmission = Data.Transmission;
				Out_Thickness = Data.Thickness;
				Out_Diffusion = Data.Diffusion;
				Out_Depth= Data.Depth;
				return;
			}
			

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float3 ase_positionWS = TransformObjectToWorld( ( input.positionOS ).xyz );
				float3 temp_output_104_7_g205214 = ase_positionWS;
				float3 vertexToFrag73_g205214 = temp_output_104_7_g205214;
				output.ase_texcoord3.xyz = vertexToFrag73_g205214;
				float4x4 break19_g205217 = GetObjectToWorldMatrix();
				float3 appendResult20_g205217 = (float3(break19_g205217[ 0 ][ 3 ] , break19_g205217[ 1 ][ 3 ] , break19_g205217[ 2 ][ 3 ]));
				float3 temp_output_340_7_g205214 = appendResult20_g205217;
				float4x4 break19_g205219 = GetObjectToWorldMatrix();
				float3 appendResult20_g205219 = (float3(break19_g205219[ 0 ][ 3 ] , break19_g205219[ 1 ][ 3 ] , break19_g205219[ 2 ][ 3 ]));
				float3 _Vector0 = float3(0,0,0);
				float3 appendResult60_g205215 = (float3(input.ase_texcoord3.x , input.ase_texcoord3.z , input.ase_texcoord3.y));
				float3 PositionOS131_g205214 = input.positionOS.xyz;
				float3 break233_g205214 = PositionOS131_g205214;
				float3 appendResult234_g205214 = (float3(break233_g205214.x , 0.0 , break233_g205214.z));
				float3 break413_g205214 = PositionOS131_g205214;
				float3 appendResult414_g205214 = (float3(break413_g205214.x , break413_g205214.y , 0.0));
				#ifdef TVE_COORD_ZUP
				float3 staticSwitch65_g205221 = appendResult414_g205214;
				#else
				float3 staticSwitch65_g205221 = appendResult234_g205214;
				#endif
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch229_g205214 = _Vector0;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch229_g205214 = appendResult60_g205215;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch229_g205214 = staticSwitch65_g205221;
				#else
				float3 staticSwitch229_g205214 = _Vector0;
				#endif
				float3 PivotOS149_g205214 = staticSwitch229_g205214;
				float3 temp_output_122_0_g205219 = PivotOS149_g205214;
				float3 PivotsOnlyWS105_g205219 = mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g205219 , 0.0 ) ).xyz;
				float3 temp_output_341_7_g205214 = ( appendResult20_g205219 + PivotsOnlyWS105_g205219 );
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#else
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#endif
				float3 vertexToFrag76_g205214 = staticSwitch236_g205214;
				output.ase_texcoord4.xyz = vertexToFrag76_g205214;
				
				output.ase_texcoord5.xy = input.texcoord.xy;
				output.ase_texcoord5.zw = input.ase_texcoord2.xy;
				output.ase_color = input.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord3.w = 0;
				output.ase_texcoord4.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );
				VertexNormalInputs normalInput = GetVertexNormalInputs( input.normalOS, input.tangentOS );

				output.positionCS = vertexInput.positionCS;
				output.positionWS = vertexInput.positionWS;
				output.normalWS = normalInput.normalWS;
				output.tangentWS = float4( normalInput.tangentWS, ( input.tangentOS.w > 0.0 ? 1.0 : -1.0 ) * GetOddNegativeScale() );

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					output.tangentWS.zw = input.texcoord.xy;
					output.tangentWS.xy = input.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				output.texcoord = input.texcoord;
				output.texcoord = input.texcoord;
				output.ase_texcoord3 = input.ase_texcoord3;
				output.ase_texcoord2 = input.ase_texcoord2;
				output.ase_color = input.ase_color;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
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
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				output.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				output.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				output.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				output.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			void frag(	PackedVaryings input
						, out half4 outNormalWS : SV_Target0
						#if defined( ASE_DEPTH_WRITE_ON )
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						#ifdef _WRITE_RENDERING_LAYERS
						, out uint outRenderingLayers : SV_Target1
						#endif
						, uint ase_vface : SV_IsFrontFace )
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( input );

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord = TransformWorldToShadowCoord(input.positionWS);
				#else
					float4 shadowCoord = float4(0, 0, 0, 0);
				#endif

				// @diogo: mikktspace compliant
				float renormFactor = 1.0 / max( FLT_MIN, length( input.normalWS ) );

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( input.positionWS );
				float4 ShadowCoord = shadowCoord;
				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos );
				float3 TangentWS = input.tangentWS.xyz * renormFactor;
				float3 BitangentWS = cross( input.normalWS, input.tangentWS.xyz ) * input.tangentWS.w * renormFactor;
				float3 NormalWS = input.normalWS * renormFactor;

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					float2 sampleCoords = (input.tangentWS.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					NormalWS = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					TangentWS = -cross(GetObjectToWorldMatrix()._13_23_33, NormalWS);
					BitangentWS = cross(NormalWS, -TangentWS);
				#endif

				float localBreakVisualData4_g251314 = ( 0.0 );
				float localBuildVisualData3_g207088 = ( 0.0 );
				TVEVisualData Data3_g207088 =(TVEVisualData)0;
				half4 Dummy130_g207086 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) + _MainMultiMaskInfo + _MainSmoothnessInfo );
				float temp_output_14_0_g207088 = Dummy130_g207086.x;
				float In_Dummy3_g207088 = temp_output_14_0_g207088;
				TEXTURE2D(Texture276_g207093) = _MainAlbedoTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g207096 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g207093 = staticSwitch36_g207096;
				float localBreakTextureData456_g207093 = ( 0.0 );
				float localBuildTextureData431_g251292 = ( 0.0 );
				TVEMasksData Data431_g251292 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g251292 = ( 0.0 );
				half4 Local_Coords180_g207086 = _main_coord_value;
				float4 Coords444_g251292 = Local_Coords180_g207086;
				TVEModelData Data16_g205222 =(TVEModelData)(TVEModelData)0;
				float In_Dummy16_g205222 = 0.0;
				float3 vertexToFrag73_g205214 = input.ase_texcoord3.xyz;
				float3 PositionWS122_g205214 = vertexToFrag73_g205214;
				float3 In_PositionWS16_g205222 = PositionWS122_g205214;
				float3 vertexToFrag76_g205214 = input.ase_texcoord4.xyz;
				float3 PivotWS121_g205214 = vertexToFrag76_g205214;
				#ifdef TVE_SCOPE_DYNAMIC
				float3 staticSwitch204_g205214 = ( PositionWS122_g205214 - PivotWS121_g205214 );
				#else
				float3 staticSwitch204_g205214 = PositionWS122_g205214;
				#endif
				float3 PositionWO132_g205214 = ( staticSwitch204_g205214 - TVE_WorldOrigin );
				float3 In_PositionWO16_g205222 = PositionWO132_g205214;
				float3 In_PivotWS16_g205222 = PivotWS121_g205214;
				float3 PivotWO133_g205214 = ( PivotWS121_g205214 - TVE_WorldOrigin );
				float3 In_PivotWO16_g205222 = PivotWO133_g205214;
				float3 normalizedWorldNormal = normalize( NormalWS );
				half3 NormalWS95_g205214 = normalizedWorldNormal;
				float3 In_NormalWS16_g205222 = NormalWS95_g205214;
				half3 TangentWS136_g205214 = TangentWS;
				float3 In_TangentWS16_g205222 = TangentWS136_g205214;
				half3 BiangentWS421_g205214 = BitangentWS;
				float3 In_BitangentWS16_g205222 = BiangentWS421_g205214;
				half3 NormalWS427_g205214 = NormalWS95_g205214;
				half3 localComputeTriplanarWeights427_g205214 = ComputeTriplanarWeights( NormalWS427_g205214 );
				half3 TriplanarWeights429_g205214 = localComputeTriplanarWeights427_g205214;
				float3 In_TriplanarWeights16_g205222 = TriplanarWeights429_g205214;
				float3 normalizeResult296_g205214 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g205214 ) );
				half3 ViewDirWS169_g205214 = normalizeResult296_g205214;
				float3 In_ViewDirWS16_g205222 = ViewDirWS169_g205214;
				float4 appendResult397_g205214 = (float4(input.ase_texcoord5.xy , input.ase_texcoord5.zw));
				float4 CoordsData398_g205214 = appendResult397_g205214;
				float4 In_CoordsData16_g205222 = CoordsData398_g205214;
				half4 VertexMasks171_g205214 = input.ase_color;
				float4 In_VertexData16_g205222 = VertexMasks171_g205214;
				float temp_output_17_0_g205226 = _ObjectPhaseMode;
				float Option70_g205226 = temp_output_17_0_g205226;
				float4 temp_output_3_0_g205226 = input.ase_color;
				float4 Channel70_g205226 = temp_output_3_0_g205226;
				float localSwitchChannel470_g205226 = SwitchChannel4( Option70_g205226 , Channel70_g205226 );
				half Phase_Value372_g205214 = localSwitchChannel470_g205226;
				float3 break319_g205214 = PivotWO133_g205214;
				half Pivot_Position322_g205214 = ( break319_g205214.x + break319_g205214.z );
				half Phase_Position357_g205214 = ( Phase_Value372_g205214 + Pivot_Position322_g205214 );
				float temp_output_248_0_g205214 = frac( Phase_Position357_g205214 );
				float4 appendResult177_g205214 = (float4(( (frac( ( Phase_Position357_g205214 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g205214));
				half4 Phase_Data176_g205214 = appendResult177_g205214;
				float4 In_PhaseData16_g205222 = Phase_Data176_g205214;
				BuildModelFragData( Data16_g205222 , In_Dummy16_g205222 , In_PositionWS16_g205222 , In_PositionWO16_g205222 , In_PivotWS16_g205222 , In_PivotWO16_g205222 , In_NormalWS16_g205222 , In_TangentWS16_g205222 , In_BitangentWS16_g205222 , In_TriplanarWeights16_g205222 , In_ViewDirWS16_g205222 , In_CoordsData16_g205222 , In_VertexData16_g205222 , In_PhaseData16_g205222 );
				TVEModelData Data15_g207087 =(TVEModelData)Data16_g205222;
				float Out_Dummy15_g207087 = 0.0;
				float3 Out_PositionWS15_g207087 = float3( 0,0,0 );
				float3 Out_PositionWO15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWS15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWO15_g207087 = float3( 0,0,0 );
				float3 Out_NormalWS15_g207087 = float3( 0,0,0 );
				float3 Out_TangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g207087 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g207087 = float3( 0,0,0 );
				float4 Out_CoordsData15_g207087 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g207087 = float4( 0,0,0,0 );
				float4 Out_PhaseData15_g207087 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g207087 , Out_Dummy15_g207087 , Out_PositionWS15_g207087 , Out_PositionWO15_g207087 , Out_PivotWS15_g207087 , Out_PivotWO15_g207087 , Out_NormalWS15_g207087 , Out_TangentWS15_g207087 , Out_BitangentWS15_g207087 , Out_TriplanarWeights15_g207087 , Out_ViewDirWS15_g207087 , Out_CoordsData15_g207087 , Out_VertexData15_g207087 , Out_PhaseData15_g207087 );
				half4 Model_CoordsData412_g207086 = Out_CoordsData15_g207087;
				float4 MeshCoords444_g251292 = Model_CoordsData412_g207086;
				float2 UV0444_g251292 = float2( 0,0 );
				float2 UV3444_g251292 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g251292 , MeshCoords444_g251292 , UV0444_g251292 , UV3444_g251292 );
				float4 appendResult430_g251292 = (float4(UV0444_g251292 , UV3444_g251292));
				float4 In_MaskA431_g251292 = appendResult430_g251292;
				float localComputeWorldCoords315_g251292 = ( 0.0 );
				float4 Coords315_g251292 = Local_Coords180_g207086;
				half3 Model_PositionWO222_g207086 = Out_PositionWO15_g207087;
				float3 PositionWS315_g251292 = Model_PositionWO222_g207086;
				float2 ZY315_g251292 = float2( 0,0 );
				float2 XZ315_g251292 = float2( 0,0 );
				float2 XY315_g251292 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g251292 , PositionWS315_g251292 , ZY315_g251292 , XZ315_g251292 , XY315_g251292 );
				float2 ZY402_g251292 = ZY315_g251292;
				float2 XZ403_g251292 = XZ315_g251292;
				float4 appendResult432_g251292 = (float4(ZY402_g251292 , XZ403_g251292));
				float4 In_MaskB431_g251292 = appendResult432_g251292;
				float2 XY404_g251292 = XY315_g251292;
				float localComputeStochasticCoords409_g251292 = ( 0.0 );
				float2 UV409_g251292 = ZY402_g251292;
				float2 UV1409_g251292 = float2( 0,0 );
				float2 UV2409_g251292 = float2( 0,0 );
				float2 UV3409_g251292 = float2( 0,0 );
				float3 Weights409_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g251292 , UV1409_g251292 , UV2409_g251292 , UV3409_g251292 , Weights409_g251292 );
				float4 appendResult433_g251292 = (float4(XY404_g251292 , UV1409_g251292));
				float4 In_MaskC431_g251292 = appendResult433_g251292;
				float4 appendResult434_g251292 = (float4(UV2409_g251292 , UV3409_g251292));
				float4 In_MaskD431_g251292 = appendResult434_g251292;
				float localComputeStochasticCoords422_g251292 = ( 0.0 );
				float2 UV422_g251292 = XZ403_g251292;
				float2 UV1422_g251292 = float2( 0,0 );
				float2 UV2422_g251292 = float2( 0,0 );
				float2 UV3422_g251292 = float2( 0,0 );
				float3 Weights422_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g251292 , UV1422_g251292 , UV2422_g251292 , UV3422_g251292 , Weights422_g251292 );
				float4 appendResult435_g251292 = (float4(UV1422_g251292 , UV2422_g251292));
				float4 In_MaskE431_g251292 = appendResult435_g251292;
				float localComputeStochasticCoords423_g251292 = ( 0.0 );
				float2 UV423_g251292 = XY404_g251292;
				float2 UV1423_g251292 = float2( 0,0 );
				float2 UV2423_g251292 = float2( 0,0 );
				float2 UV3423_g251292 = float2( 0,0 );
				float3 Weights423_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g251292 , UV1423_g251292 , UV2423_g251292 , UV3423_g251292 , Weights423_g251292 );
				float4 appendResult436_g251292 = (float4(UV3422_g251292 , UV1423_g251292));
				float4 In_MaskF431_g251292 = appendResult436_g251292;
				float4 appendResult437_g251292 = (float4(UV2423_g251292 , UV3423_g251292));
				float4 In_MaskG431_g251292 = appendResult437_g251292;
				float4 In_MaskH431_g251292 = float4( Weights409_g251292 , 0.0 );
				float4 In_MaskI431_g251292 = float4( Weights422_g251292 , 0.0 );
				float4 In_MaskJ431_g251292 = float4( Weights423_g251292 , 0.0 );
				float3 temp_output_449_0_g251292 = float3( 0,0,0 );
				float4 In_MaskK431_g251292 = float4( temp_output_449_0_g251292 , 0.0 );
				float3 temp_output_450_0_g251292 = float3( 0,0,0 );
				float4 In_MaskL431_g251292 = float4( temp_output_450_0_g251292 , 0.0 );
				float3 temp_output_451_0_g251292 = float3( 0,0,0 );
				float4 In_MaskM431_g251292 = float4( temp_output_451_0_g251292 , 0.0 );
				float3 temp_output_445_0_g251292 = float3( 0,0,0 );
				float4 In_MaskN431_g251292 = float4( temp_output_445_0_g251292 , 0.0 );
				BuildTextureData( Data431_g251292 , In_MaskA431_g251292 , In_MaskB431_g251292 , In_MaskC431_g251292 , In_MaskD431_g251292 , In_MaskE431_g251292 , In_MaskF431_g251292 , In_MaskG431_g251292 , In_MaskH431_g251292 , In_MaskI431_g251292 , In_MaskJ431_g251292 , In_MaskK431_g251292 , In_MaskL431_g251292 , In_MaskM431_g251292 , In_MaskN431_g251292 );
				TVEMasksData Data456_g207093 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207093 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207093 , Out_MaskA456_g207093 , Out_MaskB456_g207093 , Out_MaskC456_g207093 , Out_MaskD456_g207093 , Out_MaskE456_g207093 , Out_MaskF456_g207093 , Out_MaskG456_g207093 , Out_MaskH456_g207093 , Out_MaskI456_g207093 , Out_MaskJ456_g207093 , Out_MaskK456_g207093 , Out_MaskL456_g207093 , Out_MaskM456_g207093 , Out_MaskN456_g207093 );
				half2 UV276_g207093 = (Out_MaskA456_g207093).xy;
				float temp_output_504_0_g207093 = 0.0;
				half Bias276_g207093 = temp_output_504_0_g207093;
				half2 Normal276_g207093 = float2( 0,0 );
				half4 localSampleCoord276_g207093 = SampleCoord( Texture276_g207093 , Sampler276_g207093 , UV276_g207093 , Bias276_g207093 , Normal276_g207093 );
				TEXTURE2D(Texture502_g207093) = _MainAlbedoTex;
				SamplerState Sampler502_g207093 = staticSwitch36_g207096;
				half2 UV502_g207093 = (Out_MaskA456_g207093).zw;
				half Bias502_g207093 = temp_output_504_0_g207093;
				half2 Normal502_g207093 = float2( 0,0 );
				half4 localSampleCoord502_g207093 = SampleCoord( Texture502_g207093 , Sampler502_g207093 , UV502_g207093 , Bias502_g207093 , Normal502_g207093 );
				TEXTURE2D(Texture496_g207093) = _MainAlbedoTex;
				SamplerState Sampler496_g207093 = staticSwitch36_g207096;
				float2 temp_output_463_0_g207093 = (Out_MaskB456_g207093).zw;
				half2 XZ496_g207093 = temp_output_463_0_g207093;
				half Bias496_g207093 = temp_output_504_0_g207093;
				float3 temp_output_483_0_g207093 = (Out_MaskK456_g207093).xyz;
				half3 NormalWS496_g207093 = temp_output_483_0_g207093;
				half3 Normal496_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207093 = SamplePlanar2D( Texture496_g207093 , Sampler496_g207093 , XZ496_g207093 , Bias496_g207093 , NormalWS496_g207093 , Normal496_g207093 );
				TEXTURE2D(Texture490_g207093) = _MainAlbedoTex;
				SamplerState Sampler490_g207093 = staticSwitch36_g207096;
				float2 temp_output_462_0_g207093 = (Out_MaskB456_g207093).xy;
				half2 ZY490_g207093 = temp_output_462_0_g207093;
				half2 XZ490_g207093 = temp_output_463_0_g207093;
				float2 temp_output_464_0_g207093 = (Out_MaskC456_g207093).xy;
				half2 XY490_g207093 = temp_output_464_0_g207093;
				half Bias490_g207093 = temp_output_504_0_g207093;
				float3 temp_output_482_0_g207093 = (Out_MaskN456_g207093).xyz;
				half3 Triplanar490_g207093 = temp_output_482_0_g207093;
				half3 NormalWS490_g207093 = temp_output_483_0_g207093;
				half3 Normal490_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207093 = SamplePlanar3D( Texture490_g207093 , Sampler490_g207093 , ZY490_g207093 , XZ490_g207093 , XY490_g207093 , Bias490_g207093 , Triplanar490_g207093 , NormalWS490_g207093 , Normal490_g207093 );
				TEXTURE2D(Texture498_g207093) = _MainAlbedoTex;
				SamplerState Sampler498_g207093 = staticSwitch36_g207096;
				half2 XZ498_g207093 = temp_output_463_0_g207093;
				float2 temp_output_473_0_g207093 = (Out_MaskE456_g207093).xy;
				half2 XZ_1498_g207093 = temp_output_473_0_g207093;
				float2 temp_output_474_0_g207093 = (Out_MaskE456_g207093).zw;
				half2 XZ_2498_g207093 = temp_output_474_0_g207093;
				float2 temp_output_475_0_g207093 = (Out_MaskF456_g207093).xy;
				half2 XZ_3498_g207093 = temp_output_475_0_g207093;
				float temp_output_510_0_g207093 = exp2( temp_output_504_0_g207093 );
				half Bias498_g207093 = temp_output_510_0_g207093;
				float3 temp_output_480_0_g207093 = (Out_MaskI456_g207093).xyz;
				half3 Weights_2498_g207093 = temp_output_480_0_g207093;
				half3 NormalWS498_g207093 = temp_output_483_0_g207093;
				half3 Normal498_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207093 = SampleStochastic2D( Texture498_g207093 , Sampler498_g207093 , XZ498_g207093 , XZ_1498_g207093 , XZ_2498_g207093 , XZ_3498_g207093 , Bias498_g207093 , Weights_2498_g207093 , NormalWS498_g207093 , Normal498_g207093 );
				TEXTURE2D(Texture500_g207093) = _MainAlbedoTex;
				SamplerState Sampler500_g207093 = staticSwitch36_g207096;
				half2 ZY500_g207093 = temp_output_462_0_g207093;
				half2 ZY_1500_g207093 = (Out_MaskC456_g207093).zw;
				half2 ZY_2500_g207093 = (Out_MaskD456_g207093).xy;
				half2 ZY_3500_g207093 = (Out_MaskD456_g207093).zw;
				half2 XZ500_g207093 = temp_output_463_0_g207093;
				half2 XZ_1500_g207093 = temp_output_473_0_g207093;
				half2 XZ_2500_g207093 = temp_output_474_0_g207093;
				half2 XZ_3500_g207093 = temp_output_475_0_g207093;
				half2 XY500_g207093 = temp_output_464_0_g207093;
				half2 XY_1500_g207093 = (Out_MaskF456_g207093).zw;
				half2 XY_2500_g207093 = (Out_MaskG456_g207093).xy;
				half2 XY_3500_g207093 = (Out_MaskG456_g207093).zw;
				half Bias500_g207093 = temp_output_510_0_g207093;
				half3 Weights_1500_g207093 = (Out_MaskH456_g207093).xyz;
				half3 Weights_2500_g207093 = temp_output_480_0_g207093;
				half3 Weights_3500_g207093 = (Out_MaskJ456_g207093).xyz;
				half3 Triplanar500_g207093 = temp_output_482_0_g207093;
				half3 NormalWS500_g207093 = temp_output_483_0_g207093;
				half3 Normal500_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207093 = SampleStochastic3D( Texture500_g207093 , Sampler500_g207093 , ZY500_g207093 , ZY_1500_g207093 , ZY_2500_g207093 , ZY_3500_g207093 , XZ500_g207093 , XZ_1500_g207093 , XZ_2500_g207093 , XZ_3500_g207093 , XY500_g207093 , XY_1500_g207093 , XY_2500_g207093 , XY_3500_g207093 , Bias500_g207093 , Weights_1500_g207093 , Weights_2500_g207093 , Weights_3500_g207093 , Triplanar500_g207093 , NormalWS500_g207093 , Normal500_g207093 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch184_g207086 = localSampleCoord502_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch184_g207086 = localSamplePlanar2D496_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch184_g207086 = localSamplePlanar3D490_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch184_g207086 = localSampleStochastic2D498_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch184_g207086 = localSampleStochastic3D500_g207093;
				#else
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#endif
				half4 Local_AlbedoTex185_g207086 = staticSwitch184_g207086;
				float3 lerpResult53_g207086 = lerp( float3( 1,1,1 ) , (Local_AlbedoTex185_g207086).xyz , _MainAlbedoValue);
				half3 Local_AlbedoRGB107_g207086 = lerpResult53_g207086;
				TEXTURE2D(Texture276_g207097) = _MainShaderTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207098 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207097 = staticSwitch38_g207098;
				float localBreakTextureData456_g207097 = ( 0.0 );
				TVEMasksData Data456_g207097 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207097 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207097 , Out_MaskA456_g207097 , Out_MaskB456_g207097 , Out_MaskC456_g207097 , Out_MaskD456_g207097 , Out_MaskE456_g207097 , Out_MaskF456_g207097 , Out_MaskG456_g207097 , Out_MaskH456_g207097 , Out_MaskI456_g207097 , Out_MaskJ456_g207097 , Out_MaskK456_g207097 , Out_MaskL456_g207097 , Out_MaskM456_g207097 , Out_MaskN456_g207097 );
				half2 UV276_g207097 = (Out_MaskA456_g207097).xy;
				float temp_output_504_0_g207097 = 0.0;
				half Bias276_g207097 = temp_output_504_0_g207097;
				half2 Normal276_g207097 = float2( 0,0 );
				half4 localSampleCoord276_g207097 = SampleCoord( Texture276_g207097 , Sampler276_g207097 , UV276_g207097 , Bias276_g207097 , Normal276_g207097 );
				TEXTURE2D(Texture502_g207097) = _MainShaderTex;
				SamplerState Sampler502_g207097 = staticSwitch38_g207098;
				half2 UV502_g207097 = (Out_MaskA456_g207097).zw;
				half Bias502_g207097 = temp_output_504_0_g207097;
				half2 Normal502_g207097 = float2( 0,0 );
				half4 localSampleCoord502_g207097 = SampleCoord( Texture502_g207097 , Sampler502_g207097 , UV502_g207097 , Bias502_g207097 , Normal502_g207097 );
				TEXTURE2D(Texture496_g207097) = _MainShaderTex;
				SamplerState Sampler496_g207097 = staticSwitch38_g207098;
				float2 temp_output_463_0_g207097 = (Out_MaskB456_g207097).zw;
				half2 XZ496_g207097 = temp_output_463_0_g207097;
				half Bias496_g207097 = temp_output_504_0_g207097;
				float3 temp_output_483_0_g207097 = (Out_MaskK456_g207097).xyz;
				half3 NormalWS496_g207097 = temp_output_483_0_g207097;
				half3 Normal496_g207097 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207097 = SamplePlanar2D( Texture496_g207097 , Sampler496_g207097 , XZ496_g207097 , Bias496_g207097 , NormalWS496_g207097 , Normal496_g207097 );
				TEXTURE2D(Texture490_g207097) = _MainShaderTex;
				SamplerState Sampler490_g207097 = staticSwitch38_g207098;
				float2 temp_output_462_0_g207097 = (Out_MaskB456_g207097).xy;
				half2 ZY490_g207097 = temp_output_462_0_g207097;
				half2 XZ490_g207097 = temp_output_463_0_g207097;
				float2 temp_output_464_0_g207097 = (Out_MaskC456_g207097).xy;
				half2 XY490_g207097 = temp_output_464_0_g207097;
				half Bias490_g207097 = temp_output_504_0_g207097;
				float3 temp_output_482_0_g207097 = (Out_MaskN456_g207097).xyz;
				half3 Triplanar490_g207097 = temp_output_482_0_g207097;
				half3 NormalWS490_g207097 = temp_output_483_0_g207097;
				half3 Normal490_g207097 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207097 = SamplePlanar3D( Texture490_g207097 , Sampler490_g207097 , ZY490_g207097 , XZ490_g207097 , XY490_g207097 , Bias490_g207097 , Triplanar490_g207097 , NormalWS490_g207097 , Normal490_g207097 );
				TEXTURE2D(Texture498_g207097) = _MainShaderTex;
				SamplerState Sampler498_g207097 = staticSwitch38_g207098;
				half2 XZ498_g207097 = temp_output_463_0_g207097;
				float2 temp_output_473_0_g207097 = (Out_MaskE456_g207097).xy;
				half2 XZ_1498_g207097 = temp_output_473_0_g207097;
				float2 temp_output_474_0_g207097 = (Out_MaskE456_g207097).zw;
				half2 XZ_2498_g207097 = temp_output_474_0_g207097;
				float2 temp_output_475_0_g207097 = (Out_MaskF456_g207097).xy;
				half2 XZ_3498_g207097 = temp_output_475_0_g207097;
				float temp_output_510_0_g207097 = exp2( temp_output_504_0_g207097 );
				half Bias498_g207097 = temp_output_510_0_g207097;
				float3 temp_output_480_0_g207097 = (Out_MaskI456_g207097).xyz;
				half3 Weights_2498_g207097 = temp_output_480_0_g207097;
				half3 NormalWS498_g207097 = temp_output_483_0_g207097;
				half3 Normal498_g207097 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207097 = SampleStochastic2D( Texture498_g207097 , Sampler498_g207097 , XZ498_g207097 , XZ_1498_g207097 , XZ_2498_g207097 , XZ_3498_g207097 , Bias498_g207097 , Weights_2498_g207097 , NormalWS498_g207097 , Normal498_g207097 );
				TEXTURE2D(Texture500_g207097) = _MainShaderTex;
				SamplerState Sampler500_g207097 = staticSwitch38_g207098;
				half2 ZY500_g207097 = temp_output_462_0_g207097;
				half2 ZY_1500_g207097 = (Out_MaskC456_g207097).zw;
				half2 ZY_2500_g207097 = (Out_MaskD456_g207097).xy;
				half2 ZY_3500_g207097 = (Out_MaskD456_g207097).zw;
				half2 XZ500_g207097 = temp_output_463_0_g207097;
				half2 XZ_1500_g207097 = temp_output_473_0_g207097;
				half2 XZ_2500_g207097 = temp_output_474_0_g207097;
				half2 XZ_3500_g207097 = temp_output_475_0_g207097;
				half2 XY500_g207097 = temp_output_464_0_g207097;
				half2 XY_1500_g207097 = (Out_MaskF456_g207097).zw;
				half2 XY_2500_g207097 = (Out_MaskG456_g207097).xy;
				half2 XY_3500_g207097 = (Out_MaskG456_g207097).zw;
				half Bias500_g207097 = temp_output_510_0_g207097;
				half3 Weights_1500_g207097 = (Out_MaskH456_g207097).xyz;
				half3 Weights_2500_g207097 = temp_output_480_0_g207097;
				half3 Weights_3500_g207097 = (Out_MaskJ456_g207097).xyz;
				half3 Triplanar500_g207097 = temp_output_482_0_g207097;
				half3 NormalWS500_g207097 = temp_output_483_0_g207097;
				half3 Normal500_g207097 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207097 = SampleStochastic3D( Texture500_g207097 , Sampler500_g207097 , ZY500_g207097 , ZY_1500_g207097 , ZY_2500_g207097 , ZY_3500_g207097 , XZ500_g207097 , XZ_1500_g207097 , XZ_2500_g207097 , XZ_3500_g207097 , XY500_g207097 , XY_1500_g207097 , XY_2500_g207097 , XY_3500_g207097 , Bias500_g207097 , Weights_1500_g207097 , Weights_2500_g207097 , Weights_3500_g207097 , Triplanar500_g207097 , NormalWS500_g207097 , Normal500_g207097 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch198_g207086 = localSampleCoord276_g207097;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch198_g207086 = localSampleCoord502_g207097;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch198_g207086 = localSamplePlanar2D496_g207097;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch198_g207086 = localSamplePlanar3D490_g207097;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch198_g207086 = localSampleStochastic2D498_g207097;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch198_g207086 = localSampleStochastic3D500_g207097;
				#else
				float4 staticSwitch198_g207086 = localSampleCoord276_g207097;
				#endif
				half4 Local_ShaderTex199_g207086 = staticSwitch198_g207086;
				float temp_output_17_0_g251298 = _MainMetallicChannelMode;
				float Option83_g251298 = temp_output_17_0_g251298;
				TEXTURE2D(Texture276_g207101) = _MainMetallicTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207102 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207101 = staticSwitch38_g207102;
				float localBreakTextureData456_g207101 = ( 0.0 );
				TVEMasksData Data456_g207101 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207101 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207101 , Out_MaskA456_g207101 , Out_MaskB456_g207101 , Out_MaskC456_g207101 , Out_MaskD456_g207101 , Out_MaskE456_g207101 , Out_MaskF456_g207101 , Out_MaskG456_g207101 , Out_MaskH456_g207101 , Out_MaskI456_g207101 , Out_MaskJ456_g207101 , Out_MaskK456_g207101 , Out_MaskL456_g207101 , Out_MaskM456_g207101 , Out_MaskN456_g207101 );
				half2 UV276_g207101 = (Out_MaskA456_g207101).xy;
				float temp_output_504_0_g207101 = 0.0;
				half Bias276_g207101 = temp_output_504_0_g207101;
				half2 Normal276_g207101 = float2( 0,0 );
				half4 localSampleCoord276_g207101 = SampleCoord( Texture276_g207101 , Sampler276_g207101 , UV276_g207101 , Bias276_g207101 , Normal276_g207101 );
				TEXTURE2D(Texture502_g207101) = _MainMetallicTex;
				SamplerState Sampler502_g207101 = staticSwitch38_g207102;
				half2 UV502_g207101 = (Out_MaskA456_g207101).zw;
				half Bias502_g207101 = temp_output_504_0_g207101;
				half2 Normal502_g207101 = float2( 0,0 );
				half4 localSampleCoord502_g207101 = SampleCoord( Texture502_g207101 , Sampler502_g207101 , UV502_g207101 , Bias502_g207101 , Normal502_g207101 );
				TEXTURE2D(Texture496_g207101) = _MainMetallicTex;
				SamplerState Sampler496_g207101 = staticSwitch38_g207102;
				float2 temp_output_463_0_g207101 = (Out_MaskB456_g207101).zw;
				half2 XZ496_g207101 = temp_output_463_0_g207101;
				half Bias496_g207101 = temp_output_504_0_g207101;
				float3 temp_output_483_0_g207101 = (Out_MaskK456_g207101).xyz;
				half3 NormalWS496_g207101 = temp_output_483_0_g207101;
				half3 Normal496_g207101 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207101 = SamplePlanar2D( Texture496_g207101 , Sampler496_g207101 , XZ496_g207101 , Bias496_g207101 , NormalWS496_g207101 , Normal496_g207101 );
				TEXTURE2D(Texture490_g207101) = _MainMetallicTex;
				SamplerState Sampler490_g207101 = staticSwitch38_g207102;
				float2 temp_output_462_0_g207101 = (Out_MaskB456_g207101).xy;
				half2 ZY490_g207101 = temp_output_462_0_g207101;
				half2 XZ490_g207101 = temp_output_463_0_g207101;
				float2 temp_output_464_0_g207101 = (Out_MaskC456_g207101).xy;
				half2 XY490_g207101 = temp_output_464_0_g207101;
				half Bias490_g207101 = temp_output_504_0_g207101;
				float3 temp_output_482_0_g207101 = (Out_MaskN456_g207101).xyz;
				half3 Triplanar490_g207101 = temp_output_482_0_g207101;
				half3 NormalWS490_g207101 = temp_output_483_0_g207101;
				half3 Normal490_g207101 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207101 = SamplePlanar3D( Texture490_g207101 , Sampler490_g207101 , ZY490_g207101 , XZ490_g207101 , XY490_g207101 , Bias490_g207101 , Triplanar490_g207101 , NormalWS490_g207101 , Normal490_g207101 );
				TEXTURE2D(Texture498_g207101) = _MainMetallicTex;
				SamplerState Sampler498_g207101 = staticSwitch38_g207102;
				half2 XZ498_g207101 = temp_output_463_0_g207101;
				float2 temp_output_473_0_g207101 = (Out_MaskE456_g207101).xy;
				half2 XZ_1498_g207101 = temp_output_473_0_g207101;
				float2 temp_output_474_0_g207101 = (Out_MaskE456_g207101).zw;
				half2 XZ_2498_g207101 = temp_output_474_0_g207101;
				float2 temp_output_475_0_g207101 = (Out_MaskF456_g207101).xy;
				half2 XZ_3498_g207101 = temp_output_475_0_g207101;
				float temp_output_510_0_g207101 = exp2( temp_output_504_0_g207101 );
				half Bias498_g207101 = temp_output_510_0_g207101;
				float3 temp_output_480_0_g207101 = (Out_MaskI456_g207101).xyz;
				half3 Weights_2498_g207101 = temp_output_480_0_g207101;
				half3 NormalWS498_g207101 = temp_output_483_0_g207101;
				half3 Normal498_g207101 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207101 = SampleStochastic2D( Texture498_g207101 , Sampler498_g207101 , XZ498_g207101 , XZ_1498_g207101 , XZ_2498_g207101 , XZ_3498_g207101 , Bias498_g207101 , Weights_2498_g207101 , NormalWS498_g207101 , Normal498_g207101 );
				TEXTURE2D(Texture500_g207101) = _MainMetallicTex;
				SamplerState Sampler500_g207101 = staticSwitch38_g207102;
				half2 ZY500_g207101 = temp_output_462_0_g207101;
				half2 ZY_1500_g207101 = (Out_MaskC456_g207101).zw;
				half2 ZY_2500_g207101 = (Out_MaskD456_g207101).xy;
				half2 ZY_3500_g207101 = (Out_MaskD456_g207101).zw;
				half2 XZ500_g207101 = temp_output_463_0_g207101;
				half2 XZ_1500_g207101 = temp_output_473_0_g207101;
				half2 XZ_2500_g207101 = temp_output_474_0_g207101;
				half2 XZ_3500_g207101 = temp_output_475_0_g207101;
				half2 XY500_g207101 = temp_output_464_0_g207101;
				half2 XY_1500_g207101 = (Out_MaskF456_g207101).zw;
				half2 XY_2500_g207101 = (Out_MaskG456_g207101).xy;
				half2 XY_3500_g207101 = (Out_MaskG456_g207101).zw;
				half Bias500_g207101 = temp_output_510_0_g207101;
				half3 Weights_1500_g207101 = (Out_MaskH456_g207101).xyz;
				half3 Weights_2500_g207101 = temp_output_480_0_g207101;
				half3 Weights_3500_g207101 = (Out_MaskJ456_g207101).xyz;
				half3 Triplanar500_g207101 = temp_output_482_0_g207101;
				half3 NormalWS500_g207101 = temp_output_483_0_g207101;
				half3 Normal500_g207101 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207101 = SampleStochastic3D( Texture500_g207101 , Sampler500_g207101 , ZY500_g207101 , ZY_1500_g207101 , ZY_2500_g207101 , ZY_3500_g207101 , XZ500_g207101 , XZ_1500_g207101 , XZ_2500_g207101 , XZ_3500_g207101 , XY500_g207101 , XY_1500_g207101 , XY_2500_g207101 , XY_3500_g207101 , Bias500_g207101 , Weights_1500_g207101 , Weights_2500_g207101 , Weights_3500_g207101 , Triplanar500_g207101 , NormalWS500_g207101 , Normal500_g207101 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch335_g207086 = localSampleCoord276_g207101;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch335_g207086 = localSampleCoord502_g207101;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch335_g207086 = localSamplePlanar2D496_g207101;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch335_g207086 = localSamplePlanar3D490_g207101;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch335_g207086 = localSampleStochastic2D498_g207101;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch335_g207086 = localSampleStochastic3D500_g207101;
				#else
				float4 staticSwitch335_g207086 = localSampleCoord276_g207101;
				#endif
				half4 Local_MetallicTex341_g207086 = staticSwitch335_g207086;
				float4 ChannelA83_g251298 = Local_MetallicTex341_g207086;
				float4 ChannelB83_g251298 = ( 1.0 - Local_MetallicTex341_g207086 );
				float localSwitchChannel883_g251298 = SwitchChannel8( Option83_g251298 , ChannelA83_g251298 , ChannelB83_g251298 );
				float lerpResult366_g207086 = lerp( (Local_ShaderTex199_g207086).x , localSwitchChannel883_g251298 , _MainMetallicSourceMode);
				half Local_Metallic322_g207086 = ( lerpResult366_g207086 * _MainMetallicValue );
				float temp_output_17_0_g251299 = _MainOcclusionChannelMode;
				float Option83_g251299 = temp_output_17_0_g251299;
				TEXTURE2D(Texture276_g207103) = _MainOcclusionTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207108 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207103 = staticSwitch38_g207108;
				float localBreakTextureData456_g207103 = ( 0.0 );
				TVEMasksData Data456_g207103 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207103 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207103 , Out_MaskA456_g207103 , Out_MaskB456_g207103 , Out_MaskC456_g207103 , Out_MaskD456_g207103 , Out_MaskE456_g207103 , Out_MaskF456_g207103 , Out_MaskG456_g207103 , Out_MaskH456_g207103 , Out_MaskI456_g207103 , Out_MaskJ456_g207103 , Out_MaskK456_g207103 , Out_MaskL456_g207103 , Out_MaskM456_g207103 , Out_MaskN456_g207103 );
				half2 UV276_g207103 = (Out_MaskA456_g207103).xy;
				float temp_output_504_0_g207103 = 0.0;
				half Bias276_g207103 = temp_output_504_0_g207103;
				half2 Normal276_g207103 = float2( 0,0 );
				half4 localSampleCoord276_g207103 = SampleCoord( Texture276_g207103 , Sampler276_g207103 , UV276_g207103 , Bias276_g207103 , Normal276_g207103 );
				TEXTURE2D(Texture502_g207103) = _MainOcclusionTex;
				SamplerState Sampler502_g207103 = staticSwitch38_g207108;
				half2 UV502_g207103 = (Out_MaskA456_g207103).zw;
				half Bias502_g207103 = temp_output_504_0_g207103;
				half2 Normal502_g207103 = float2( 0,0 );
				half4 localSampleCoord502_g207103 = SampleCoord( Texture502_g207103 , Sampler502_g207103 , UV502_g207103 , Bias502_g207103 , Normal502_g207103 );
				TEXTURE2D(Texture496_g207103) = _MainOcclusionTex;
				SamplerState Sampler496_g207103 = staticSwitch38_g207108;
				float2 temp_output_463_0_g207103 = (Out_MaskB456_g207103).zw;
				half2 XZ496_g207103 = temp_output_463_0_g207103;
				half Bias496_g207103 = temp_output_504_0_g207103;
				float3 temp_output_483_0_g207103 = (Out_MaskK456_g207103).xyz;
				half3 NormalWS496_g207103 = temp_output_483_0_g207103;
				half3 Normal496_g207103 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207103 = SamplePlanar2D( Texture496_g207103 , Sampler496_g207103 , XZ496_g207103 , Bias496_g207103 , NormalWS496_g207103 , Normal496_g207103 );
				TEXTURE2D(Texture490_g207103) = _MainOcclusionTex;
				SamplerState Sampler490_g207103 = staticSwitch38_g207108;
				float2 temp_output_462_0_g207103 = (Out_MaskB456_g207103).xy;
				half2 ZY490_g207103 = temp_output_462_0_g207103;
				half2 XZ490_g207103 = temp_output_463_0_g207103;
				float2 temp_output_464_0_g207103 = (Out_MaskC456_g207103).xy;
				half2 XY490_g207103 = temp_output_464_0_g207103;
				half Bias490_g207103 = temp_output_504_0_g207103;
				float3 temp_output_482_0_g207103 = (Out_MaskN456_g207103).xyz;
				half3 Triplanar490_g207103 = temp_output_482_0_g207103;
				half3 NormalWS490_g207103 = temp_output_483_0_g207103;
				half3 Normal490_g207103 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207103 = SamplePlanar3D( Texture490_g207103 , Sampler490_g207103 , ZY490_g207103 , XZ490_g207103 , XY490_g207103 , Bias490_g207103 , Triplanar490_g207103 , NormalWS490_g207103 , Normal490_g207103 );
				TEXTURE2D(Texture498_g207103) = _MainOcclusionTex;
				SamplerState Sampler498_g207103 = staticSwitch38_g207108;
				half2 XZ498_g207103 = temp_output_463_0_g207103;
				float2 temp_output_473_0_g207103 = (Out_MaskE456_g207103).xy;
				half2 XZ_1498_g207103 = temp_output_473_0_g207103;
				float2 temp_output_474_0_g207103 = (Out_MaskE456_g207103).zw;
				half2 XZ_2498_g207103 = temp_output_474_0_g207103;
				float2 temp_output_475_0_g207103 = (Out_MaskF456_g207103).xy;
				half2 XZ_3498_g207103 = temp_output_475_0_g207103;
				float temp_output_510_0_g207103 = exp2( temp_output_504_0_g207103 );
				half Bias498_g207103 = temp_output_510_0_g207103;
				float3 temp_output_480_0_g207103 = (Out_MaskI456_g207103).xyz;
				half3 Weights_2498_g207103 = temp_output_480_0_g207103;
				half3 NormalWS498_g207103 = temp_output_483_0_g207103;
				half3 Normal498_g207103 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207103 = SampleStochastic2D( Texture498_g207103 , Sampler498_g207103 , XZ498_g207103 , XZ_1498_g207103 , XZ_2498_g207103 , XZ_3498_g207103 , Bias498_g207103 , Weights_2498_g207103 , NormalWS498_g207103 , Normal498_g207103 );
				TEXTURE2D(Texture500_g207103) = _MainOcclusionTex;
				SamplerState Sampler500_g207103 = staticSwitch38_g207108;
				half2 ZY500_g207103 = temp_output_462_0_g207103;
				half2 ZY_1500_g207103 = (Out_MaskC456_g207103).zw;
				half2 ZY_2500_g207103 = (Out_MaskD456_g207103).xy;
				half2 ZY_3500_g207103 = (Out_MaskD456_g207103).zw;
				half2 XZ500_g207103 = temp_output_463_0_g207103;
				half2 XZ_1500_g207103 = temp_output_473_0_g207103;
				half2 XZ_2500_g207103 = temp_output_474_0_g207103;
				half2 XZ_3500_g207103 = temp_output_475_0_g207103;
				half2 XY500_g207103 = temp_output_464_0_g207103;
				half2 XY_1500_g207103 = (Out_MaskF456_g207103).zw;
				half2 XY_2500_g207103 = (Out_MaskG456_g207103).xy;
				half2 XY_3500_g207103 = (Out_MaskG456_g207103).zw;
				half Bias500_g207103 = temp_output_510_0_g207103;
				half3 Weights_1500_g207103 = (Out_MaskH456_g207103).xyz;
				half3 Weights_2500_g207103 = temp_output_480_0_g207103;
				half3 Weights_3500_g207103 = (Out_MaskJ456_g207103).xyz;
				half3 Triplanar500_g207103 = temp_output_482_0_g207103;
				half3 NormalWS500_g207103 = temp_output_483_0_g207103;
				half3 Normal500_g207103 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207103 = SampleStochastic3D( Texture500_g207103 , Sampler500_g207103 , ZY500_g207103 , ZY_1500_g207103 , ZY_2500_g207103 , ZY_3500_g207103 , XZ500_g207103 , XZ_1500_g207103 , XZ_2500_g207103 , XZ_3500_g207103 , XY500_g207103 , XY_1500_g207103 , XY_2500_g207103 , XY_3500_g207103 , Bias500_g207103 , Weights_1500_g207103 , Weights_2500_g207103 , Weights_3500_g207103 , Triplanar500_g207103 , NormalWS500_g207103 , Normal500_g207103 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch343_g207086 = localSampleCoord276_g207103;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch343_g207086 = localSampleCoord502_g207103;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch343_g207086 = localSamplePlanar2D496_g207103;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch343_g207086 = localSamplePlanar3D490_g207103;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch343_g207086 = localSampleStochastic2D498_g207103;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch343_g207086 = localSampleStochastic3D500_g207103;
				#else
				float4 staticSwitch343_g207086 = localSampleCoord276_g207103;
				#endif
				half4 Local_OcclusionTex349_g207086 = staticSwitch343_g207086;
				float4 ChannelA83_g251299 = Local_OcclusionTex349_g207086;
				float4 ChannelB83_g251299 = ( 1.0 - Local_OcclusionTex349_g207086 );
				float localSwitchChannel883_g251299 = SwitchChannel8( Option83_g251299 , ChannelA83_g251299 , ChannelB83_g251299 );
				float lerpResult373_g207086 = lerp( (Local_ShaderTex199_g207086).y , localSwitchChannel883_g251299 , _MainOcclusionSourceMode);
				float clampResult17_g251301 = clamp( lerpResult373_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251300 = _MainOcclusionRemap.x;
				float temp_output_9_0_g251300 = ( clampResult17_g251301 - temp_output_7_0_g251300 );
				float lerpResult23_g207086 = lerp( 1.0 , saturate( ( temp_output_9_0_g251300 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
				half Local_Occlusion313_g207086 = lerpResult23_g207086;
				float temp_output_17_0_g251307 = _MainSmoothnessChannelMode;
				float Option83_g251307 = temp_output_17_0_g251307;
				TEXTURE2D(Texture276_g207106) = _MainSmoothnessTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207107 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207106 = staticSwitch38_g207107;
				float localBreakTextureData456_g207106 = ( 0.0 );
				TVEMasksData Data456_g207106 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207106 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207106 , Out_MaskA456_g207106 , Out_MaskB456_g207106 , Out_MaskC456_g207106 , Out_MaskD456_g207106 , Out_MaskE456_g207106 , Out_MaskF456_g207106 , Out_MaskG456_g207106 , Out_MaskH456_g207106 , Out_MaskI456_g207106 , Out_MaskJ456_g207106 , Out_MaskK456_g207106 , Out_MaskL456_g207106 , Out_MaskM456_g207106 , Out_MaskN456_g207106 );
				half2 UV276_g207106 = (Out_MaskA456_g207106).xy;
				float temp_output_504_0_g207106 = 0.0;
				half Bias276_g207106 = temp_output_504_0_g207106;
				half2 Normal276_g207106 = float2( 0,0 );
				half4 localSampleCoord276_g207106 = SampleCoord( Texture276_g207106 , Sampler276_g207106 , UV276_g207106 , Bias276_g207106 , Normal276_g207106 );
				TEXTURE2D(Texture502_g207106) = _MainSmoothnessTex;
				SamplerState Sampler502_g207106 = staticSwitch38_g207107;
				half2 UV502_g207106 = (Out_MaskA456_g207106).zw;
				half Bias502_g207106 = temp_output_504_0_g207106;
				half2 Normal502_g207106 = float2( 0,0 );
				half4 localSampleCoord502_g207106 = SampleCoord( Texture502_g207106 , Sampler502_g207106 , UV502_g207106 , Bias502_g207106 , Normal502_g207106 );
				TEXTURE2D(Texture496_g207106) = _MainSmoothnessTex;
				SamplerState Sampler496_g207106 = staticSwitch38_g207107;
				float2 temp_output_463_0_g207106 = (Out_MaskB456_g207106).zw;
				half2 XZ496_g207106 = temp_output_463_0_g207106;
				half Bias496_g207106 = temp_output_504_0_g207106;
				float3 temp_output_483_0_g207106 = (Out_MaskK456_g207106).xyz;
				half3 NormalWS496_g207106 = temp_output_483_0_g207106;
				half3 Normal496_g207106 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207106 = SamplePlanar2D( Texture496_g207106 , Sampler496_g207106 , XZ496_g207106 , Bias496_g207106 , NormalWS496_g207106 , Normal496_g207106 );
				TEXTURE2D(Texture490_g207106) = _MainSmoothnessTex;
				SamplerState Sampler490_g207106 = staticSwitch38_g207107;
				float2 temp_output_462_0_g207106 = (Out_MaskB456_g207106).xy;
				half2 ZY490_g207106 = temp_output_462_0_g207106;
				half2 XZ490_g207106 = temp_output_463_0_g207106;
				float2 temp_output_464_0_g207106 = (Out_MaskC456_g207106).xy;
				half2 XY490_g207106 = temp_output_464_0_g207106;
				half Bias490_g207106 = temp_output_504_0_g207106;
				float3 temp_output_482_0_g207106 = (Out_MaskN456_g207106).xyz;
				half3 Triplanar490_g207106 = temp_output_482_0_g207106;
				half3 NormalWS490_g207106 = temp_output_483_0_g207106;
				half3 Normal490_g207106 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207106 = SamplePlanar3D( Texture490_g207106 , Sampler490_g207106 , ZY490_g207106 , XZ490_g207106 , XY490_g207106 , Bias490_g207106 , Triplanar490_g207106 , NormalWS490_g207106 , Normal490_g207106 );
				TEXTURE2D(Texture498_g207106) = _MainSmoothnessTex;
				SamplerState Sampler498_g207106 = staticSwitch38_g207107;
				half2 XZ498_g207106 = temp_output_463_0_g207106;
				float2 temp_output_473_0_g207106 = (Out_MaskE456_g207106).xy;
				half2 XZ_1498_g207106 = temp_output_473_0_g207106;
				float2 temp_output_474_0_g207106 = (Out_MaskE456_g207106).zw;
				half2 XZ_2498_g207106 = temp_output_474_0_g207106;
				float2 temp_output_475_0_g207106 = (Out_MaskF456_g207106).xy;
				half2 XZ_3498_g207106 = temp_output_475_0_g207106;
				float temp_output_510_0_g207106 = exp2( temp_output_504_0_g207106 );
				half Bias498_g207106 = temp_output_510_0_g207106;
				float3 temp_output_480_0_g207106 = (Out_MaskI456_g207106).xyz;
				half3 Weights_2498_g207106 = temp_output_480_0_g207106;
				half3 NormalWS498_g207106 = temp_output_483_0_g207106;
				half3 Normal498_g207106 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207106 = SampleStochastic2D( Texture498_g207106 , Sampler498_g207106 , XZ498_g207106 , XZ_1498_g207106 , XZ_2498_g207106 , XZ_3498_g207106 , Bias498_g207106 , Weights_2498_g207106 , NormalWS498_g207106 , Normal498_g207106 );
				TEXTURE2D(Texture500_g207106) = _MainSmoothnessTex;
				SamplerState Sampler500_g207106 = staticSwitch38_g207107;
				half2 ZY500_g207106 = temp_output_462_0_g207106;
				half2 ZY_1500_g207106 = (Out_MaskC456_g207106).zw;
				half2 ZY_2500_g207106 = (Out_MaskD456_g207106).xy;
				half2 ZY_3500_g207106 = (Out_MaskD456_g207106).zw;
				half2 XZ500_g207106 = temp_output_463_0_g207106;
				half2 XZ_1500_g207106 = temp_output_473_0_g207106;
				half2 XZ_2500_g207106 = temp_output_474_0_g207106;
				half2 XZ_3500_g207106 = temp_output_475_0_g207106;
				half2 XY500_g207106 = temp_output_464_0_g207106;
				half2 XY_1500_g207106 = (Out_MaskF456_g207106).zw;
				half2 XY_2500_g207106 = (Out_MaskG456_g207106).xy;
				half2 XY_3500_g207106 = (Out_MaskG456_g207106).zw;
				half Bias500_g207106 = temp_output_510_0_g207106;
				half3 Weights_1500_g207106 = (Out_MaskH456_g207106).xyz;
				half3 Weights_2500_g207106 = temp_output_480_0_g207106;
				half3 Weights_3500_g207106 = (Out_MaskJ456_g207106).xyz;
				half3 Triplanar500_g207106 = temp_output_482_0_g207106;
				half3 NormalWS500_g207106 = temp_output_483_0_g207106;
				half3 Normal500_g207106 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207106 = SampleStochastic3D( Texture500_g207106 , Sampler500_g207106 , ZY500_g207106 , ZY_1500_g207106 , ZY_2500_g207106 , ZY_3500_g207106 , XZ500_g207106 , XZ_1500_g207106 , XZ_2500_g207106 , XZ_3500_g207106 , XY500_g207106 , XY_1500_g207106 , XY_2500_g207106 , XY_3500_g207106 , Bias500_g207106 , Weights_1500_g207106 , Weights_2500_g207106 , Weights_3500_g207106 , Triplanar500_g207106 , NormalWS500_g207106 , Normal500_g207106 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch359_g207086 = localSampleCoord276_g207106;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch359_g207086 = localSampleCoord502_g207106;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch359_g207086 = localSamplePlanar2D496_g207106;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch359_g207086 = localSamplePlanar3D490_g207106;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch359_g207086 = localSampleStochastic2D498_g207106;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch359_g207086 = localSampleStochastic3D500_g207106;
				#else
				float4 staticSwitch359_g207086 = localSampleCoord276_g207106;
				#endif
				half4 Local_SmoothnessTex365_g207086 = staticSwitch359_g207086;
				float4 temp_output_28_0_g251309 = Local_SmoothnessTex365_g207086;
				float3 temp_output_29_0_g251309 = (temp_output_28_0_g251309).xyz;
				half3 linRGB27_g251309 = temp_output_29_0_g251309;
				half3 localLinearToGammaFloatFast27_g251309 = LinearToGammaFloatFast( linRGB27_g251309 );
				#ifdef UNITY_COLORSPACE_GAMMA
				float3 staticSwitch26_g251309 = temp_output_29_0_g251309;
				#else
				float3 staticSwitch26_g251309 = localLinearToGammaFloatFast27_g251309;
				#endif
				float4 appendResult31_g251309 = (float4(staticSwitch26_g251309 , (temp_output_28_0_g251309).w));
				float4 lerpResult439_g207086 = lerp( Local_SmoothnessTex365_g207086 , appendResult31_g251309 , _MainSmoothnessTexGammaMode);
				float4 ChannelA83_g251307 = lerpResult439_g207086;
				float4 ChannelB83_g251307 = ( 1.0 - lerpResult439_g207086 );
				float localSwitchChannel883_g251307 = SwitchChannel8( Option83_g251307 , ChannelA83_g251307 , ChannelB83_g251307 );
				float lerpResult374_g207086 = lerp( (Local_ShaderTex199_g207086).w , localSwitchChannel883_g251307 , _MainSmoothnessSourceMode);
				float clampResult17_g251306 = clamp( lerpResult374_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251305 = _MainSmoothnessRemap.x;
				float temp_output_9_0_g251305 = ( clampResult17_g251306 - temp_output_7_0_g251305 );
				half Local_Smoothness317_g207086 = ( saturate( ( temp_output_9_0_g251305 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
				float4 appendResult73_g207086 = (float4(Local_Metallic322_g207086 , Local_Occlusion313_g207086 , 0.0 , Local_Smoothness317_g207086));
				half4 Local_Masks109_g207086 = appendResult73_g207086;
				float temp_output_17_0_g251304 = _MainMultiChannelMode;
				float Option83_g251304 = temp_output_17_0_g251304;
				TEXTURE2D(Texture276_g207104) = _MainMultiTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207105 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207104 = staticSwitch38_g207105;
				float localBreakTextureData456_g207104 = ( 0.0 );
				TVEMasksData Data456_g207104 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207104 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207104 , Out_MaskA456_g207104 , Out_MaskB456_g207104 , Out_MaskC456_g207104 , Out_MaskD456_g207104 , Out_MaskE456_g207104 , Out_MaskF456_g207104 , Out_MaskG456_g207104 , Out_MaskH456_g207104 , Out_MaskI456_g207104 , Out_MaskJ456_g207104 , Out_MaskK456_g207104 , Out_MaskL456_g207104 , Out_MaskM456_g207104 , Out_MaskN456_g207104 );
				half2 UV276_g207104 = (Out_MaskA456_g207104).xy;
				float temp_output_504_0_g207104 = 0.0;
				half Bias276_g207104 = temp_output_504_0_g207104;
				half2 Normal276_g207104 = float2( 0,0 );
				half4 localSampleCoord276_g207104 = SampleCoord( Texture276_g207104 , Sampler276_g207104 , UV276_g207104 , Bias276_g207104 , Normal276_g207104 );
				TEXTURE2D(Texture502_g207104) = _MainMultiTex;
				SamplerState Sampler502_g207104 = staticSwitch38_g207105;
				half2 UV502_g207104 = (Out_MaskA456_g207104).zw;
				half Bias502_g207104 = temp_output_504_0_g207104;
				half2 Normal502_g207104 = float2( 0,0 );
				half4 localSampleCoord502_g207104 = SampleCoord( Texture502_g207104 , Sampler502_g207104 , UV502_g207104 , Bias502_g207104 , Normal502_g207104 );
				TEXTURE2D(Texture496_g207104) = _MainMultiTex;
				SamplerState Sampler496_g207104 = staticSwitch38_g207105;
				float2 temp_output_463_0_g207104 = (Out_MaskB456_g207104).zw;
				half2 XZ496_g207104 = temp_output_463_0_g207104;
				half Bias496_g207104 = temp_output_504_0_g207104;
				float3 temp_output_483_0_g207104 = (Out_MaskK456_g207104).xyz;
				half3 NormalWS496_g207104 = temp_output_483_0_g207104;
				half3 Normal496_g207104 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207104 = SamplePlanar2D( Texture496_g207104 , Sampler496_g207104 , XZ496_g207104 , Bias496_g207104 , NormalWS496_g207104 , Normal496_g207104 );
				TEXTURE2D(Texture490_g207104) = _MainMultiTex;
				SamplerState Sampler490_g207104 = staticSwitch38_g207105;
				float2 temp_output_462_0_g207104 = (Out_MaskB456_g207104).xy;
				half2 ZY490_g207104 = temp_output_462_0_g207104;
				half2 XZ490_g207104 = temp_output_463_0_g207104;
				float2 temp_output_464_0_g207104 = (Out_MaskC456_g207104).xy;
				half2 XY490_g207104 = temp_output_464_0_g207104;
				half Bias490_g207104 = temp_output_504_0_g207104;
				float3 temp_output_482_0_g207104 = (Out_MaskN456_g207104).xyz;
				half3 Triplanar490_g207104 = temp_output_482_0_g207104;
				half3 NormalWS490_g207104 = temp_output_483_0_g207104;
				half3 Normal490_g207104 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207104 = SamplePlanar3D( Texture490_g207104 , Sampler490_g207104 , ZY490_g207104 , XZ490_g207104 , XY490_g207104 , Bias490_g207104 , Triplanar490_g207104 , NormalWS490_g207104 , Normal490_g207104 );
				TEXTURE2D(Texture498_g207104) = _MainMultiTex;
				SamplerState Sampler498_g207104 = staticSwitch38_g207105;
				half2 XZ498_g207104 = temp_output_463_0_g207104;
				float2 temp_output_473_0_g207104 = (Out_MaskE456_g207104).xy;
				half2 XZ_1498_g207104 = temp_output_473_0_g207104;
				float2 temp_output_474_0_g207104 = (Out_MaskE456_g207104).zw;
				half2 XZ_2498_g207104 = temp_output_474_0_g207104;
				float2 temp_output_475_0_g207104 = (Out_MaskF456_g207104).xy;
				half2 XZ_3498_g207104 = temp_output_475_0_g207104;
				float temp_output_510_0_g207104 = exp2( temp_output_504_0_g207104 );
				half Bias498_g207104 = temp_output_510_0_g207104;
				float3 temp_output_480_0_g207104 = (Out_MaskI456_g207104).xyz;
				half3 Weights_2498_g207104 = temp_output_480_0_g207104;
				half3 NormalWS498_g207104 = temp_output_483_0_g207104;
				half3 Normal498_g207104 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207104 = SampleStochastic2D( Texture498_g207104 , Sampler498_g207104 , XZ498_g207104 , XZ_1498_g207104 , XZ_2498_g207104 , XZ_3498_g207104 , Bias498_g207104 , Weights_2498_g207104 , NormalWS498_g207104 , Normal498_g207104 );
				TEXTURE2D(Texture500_g207104) = _MainMultiTex;
				SamplerState Sampler500_g207104 = staticSwitch38_g207105;
				half2 ZY500_g207104 = temp_output_462_0_g207104;
				half2 ZY_1500_g207104 = (Out_MaskC456_g207104).zw;
				half2 ZY_2500_g207104 = (Out_MaskD456_g207104).xy;
				half2 ZY_3500_g207104 = (Out_MaskD456_g207104).zw;
				half2 XZ500_g207104 = temp_output_463_0_g207104;
				half2 XZ_1500_g207104 = temp_output_473_0_g207104;
				half2 XZ_2500_g207104 = temp_output_474_0_g207104;
				half2 XZ_3500_g207104 = temp_output_475_0_g207104;
				half2 XY500_g207104 = temp_output_464_0_g207104;
				half2 XY_1500_g207104 = (Out_MaskF456_g207104).zw;
				half2 XY_2500_g207104 = (Out_MaskG456_g207104).xy;
				half2 XY_3500_g207104 = (Out_MaskG456_g207104).zw;
				half Bias500_g207104 = temp_output_510_0_g207104;
				half3 Weights_1500_g207104 = (Out_MaskH456_g207104).xyz;
				half3 Weights_2500_g207104 = temp_output_480_0_g207104;
				half3 Weights_3500_g207104 = (Out_MaskJ456_g207104).xyz;
				half3 Triplanar500_g207104 = temp_output_482_0_g207104;
				half3 NormalWS500_g207104 = temp_output_483_0_g207104;
				half3 Normal500_g207104 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207104 = SampleStochastic3D( Texture500_g207104 , Sampler500_g207104 , ZY500_g207104 , ZY_1500_g207104 , ZY_2500_g207104 , ZY_3500_g207104 , XZ500_g207104 , XZ_1500_g207104 , XZ_2500_g207104 , XZ_3500_g207104 , XY500_g207104 , XY_1500_g207104 , XY_2500_g207104 , XY_3500_g207104 , Bias500_g207104 , Weights_1500_g207104 , Weights_2500_g207104 , Weights_3500_g207104 , Triplanar500_g207104 , NormalWS500_g207104 , Normal500_g207104 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch351_g207086 = localSampleCoord276_g207104;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch351_g207086 = localSampleCoord502_g207104;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch351_g207086 = localSamplePlanar2D496_g207104;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch351_g207086 = localSamplePlanar3D490_g207104;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch351_g207086 = localSampleStochastic2D498_g207104;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch351_g207086 = localSampleStochastic3D500_g207104;
				#else
				float4 staticSwitch351_g207086 = localSampleCoord276_g207104;
				#endif
				half4 Local_MultiTex357_g207086 = staticSwitch351_g207086;
				float4 ChannelA83_g251304 = Local_MultiTex357_g207086;
				float4 ChannelB83_g251304 = ( 1.0 - Local_MultiTex357_g207086 );
				float localSwitchChannel883_g251304 = SwitchChannel8( Option83_g251304 , ChannelA83_g251304 , ChannelB83_g251304 );
				float lerpResult378_g207086 = lerp( (Local_Masks109_g207086).z , localSwitchChannel883_g251304 , _MainMultiSourceMode);
				float clampResult17_g251302 = clamp( lerpResult378_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251303 = _MainMultiRemap.x;
				float temp_output_9_0_g251303 = ( clampResult17_g251302 - temp_output_7_0_g251303 );
				half Local_MultiMask78_g207086 = ( saturate( ( temp_output_9_0_g251303 * _MainMultiRemap.z ) ) * _MainMultiVlaue );
				float lerpResult58_g207086 = lerp( 1.0 , Local_MultiMask78_g207086 , _MainColorMode);
				float4 lerpResult62_g207086 = lerp( _MainColorTwo , _MainColor , lerpResult58_g207086);
				half3 Local_ColorRGB93_g207086 = (lerpResult62_g207086).rgb;
				half3 Local_Albedo139_g207086 = ( Local_AlbedoRGB107_g207086 * Local_ColorRGB93_g207086 );
				float3 temp_output_4_0_g207088 = Local_Albedo139_g207086;
				float3 In_Albedo3_g207088 = temp_output_4_0_g207088;
				float3 temp_output_44_0_g207088 = Local_Albedo139_g207086;
				float3 In_AlbedoBase3_g207088 = temp_output_44_0_g207088;
				TEXTURE2D(Texture276_g207094) = _MainNormalTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch37_g207095 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207094 = staticSwitch37_g207095;
				float localBreakTextureData456_g207094 = ( 0.0 );
				TVEMasksData Data456_g207094 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207094 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207094 , Out_MaskA456_g207094 , Out_MaskB456_g207094 , Out_MaskC456_g207094 , Out_MaskD456_g207094 , Out_MaskE456_g207094 , Out_MaskF456_g207094 , Out_MaskG456_g207094 , Out_MaskH456_g207094 , Out_MaskI456_g207094 , Out_MaskJ456_g207094 , Out_MaskK456_g207094 , Out_MaskL456_g207094 , Out_MaskM456_g207094 , Out_MaskN456_g207094 );
				half2 UV276_g207094 = (Out_MaskA456_g207094).xy;
				float temp_output_504_0_g207094 = 0.0;
				half Bias276_g207094 = temp_output_504_0_g207094;
				half2 Normal276_g207094 = float2( 0,0 );
				half4 localSampleCoord276_g207094 = SampleCoord( Texture276_g207094 , Sampler276_g207094 , UV276_g207094 , Bias276_g207094 , Normal276_g207094 );
				TEXTURE2D(Texture502_g207094) = _MainNormalTex;
				SamplerState Sampler502_g207094 = staticSwitch37_g207095;
				half2 UV502_g207094 = (Out_MaskA456_g207094).zw;
				half Bias502_g207094 = temp_output_504_0_g207094;
				half2 Normal502_g207094 = float2( 0,0 );
				half4 localSampleCoord502_g207094 = SampleCoord( Texture502_g207094 , Sampler502_g207094 , UV502_g207094 , Bias502_g207094 , Normal502_g207094 );
				TEXTURE2D(Texture496_g207094) = _MainNormalTex;
				SamplerState Sampler496_g207094 = staticSwitch37_g207095;
				float2 temp_output_463_0_g207094 = (Out_MaskB456_g207094).zw;
				half2 XZ496_g207094 = temp_output_463_0_g207094;
				half Bias496_g207094 = temp_output_504_0_g207094;
				float3 temp_output_483_0_g207094 = (Out_MaskK456_g207094).xyz;
				half3 NormalWS496_g207094 = temp_output_483_0_g207094;
				half3 Normal496_g207094 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207094 = SamplePlanar2D( Texture496_g207094 , Sampler496_g207094 , XZ496_g207094 , Bias496_g207094 , NormalWS496_g207094 , Normal496_g207094 );
				TEXTURE2D(Texture490_g207094) = _MainNormalTex;
				SamplerState Sampler490_g207094 = staticSwitch37_g207095;
				float2 temp_output_462_0_g207094 = (Out_MaskB456_g207094).xy;
				half2 ZY490_g207094 = temp_output_462_0_g207094;
				half2 XZ490_g207094 = temp_output_463_0_g207094;
				float2 temp_output_464_0_g207094 = (Out_MaskC456_g207094).xy;
				half2 XY490_g207094 = temp_output_464_0_g207094;
				half Bias490_g207094 = temp_output_504_0_g207094;
				float3 temp_output_482_0_g207094 = (Out_MaskN456_g207094).xyz;
				half3 Triplanar490_g207094 = temp_output_482_0_g207094;
				half3 NormalWS490_g207094 = temp_output_483_0_g207094;
				half3 Normal490_g207094 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207094 = SamplePlanar3D( Texture490_g207094 , Sampler490_g207094 , ZY490_g207094 , XZ490_g207094 , XY490_g207094 , Bias490_g207094 , Triplanar490_g207094 , NormalWS490_g207094 , Normal490_g207094 );
				TEXTURE2D(Texture498_g207094) = _MainNormalTex;
				SamplerState Sampler498_g207094 = staticSwitch37_g207095;
				half2 XZ498_g207094 = temp_output_463_0_g207094;
				float2 temp_output_473_0_g207094 = (Out_MaskE456_g207094).xy;
				half2 XZ_1498_g207094 = temp_output_473_0_g207094;
				float2 temp_output_474_0_g207094 = (Out_MaskE456_g207094).zw;
				half2 XZ_2498_g207094 = temp_output_474_0_g207094;
				float2 temp_output_475_0_g207094 = (Out_MaskF456_g207094).xy;
				half2 XZ_3498_g207094 = temp_output_475_0_g207094;
				float temp_output_510_0_g207094 = exp2( temp_output_504_0_g207094 );
				half Bias498_g207094 = temp_output_510_0_g207094;
				float3 temp_output_480_0_g207094 = (Out_MaskI456_g207094).xyz;
				half3 Weights_2498_g207094 = temp_output_480_0_g207094;
				half3 NormalWS498_g207094 = temp_output_483_0_g207094;
				half3 Normal498_g207094 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207094 = SampleStochastic2D( Texture498_g207094 , Sampler498_g207094 , XZ498_g207094 , XZ_1498_g207094 , XZ_2498_g207094 , XZ_3498_g207094 , Bias498_g207094 , Weights_2498_g207094 , NormalWS498_g207094 , Normal498_g207094 );
				TEXTURE2D(Texture500_g207094) = _MainNormalTex;
				SamplerState Sampler500_g207094 = staticSwitch37_g207095;
				half2 ZY500_g207094 = temp_output_462_0_g207094;
				half2 ZY_1500_g207094 = (Out_MaskC456_g207094).zw;
				half2 ZY_2500_g207094 = (Out_MaskD456_g207094).xy;
				half2 ZY_3500_g207094 = (Out_MaskD456_g207094).zw;
				half2 XZ500_g207094 = temp_output_463_0_g207094;
				half2 XZ_1500_g207094 = temp_output_473_0_g207094;
				half2 XZ_2500_g207094 = temp_output_474_0_g207094;
				half2 XZ_3500_g207094 = temp_output_475_0_g207094;
				half2 XY500_g207094 = temp_output_464_0_g207094;
				half2 XY_1500_g207094 = (Out_MaskF456_g207094).zw;
				half2 XY_2500_g207094 = (Out_MaskG456_g207094).xy;
				half2 XY_3500_g207094 = (Out_MaskG456_g207094).zw;
				half Bias500_g207094 = temp_output_510_0_g207094;
				half3 Weights_1500_g207094 = (Out_MaskH456_g207094).xyz;
				half3 Weights_2500_g207094 = temp_output_480_0_g207094;
				half3 Weights_3500_g207094 = (Out_MaskJ456_g207094).xyz;
				half3 Triplanar500_g207094 = temp_output_482_0_g207094;
				half3 NormalWS500_g207094 = temp_output_483_0_g207094;
				half3 Normal500_g207094 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207094 = SampleStochastic3D( Texture500_g207094 , Sampler500_g207094 , ZY500_g207094 , ZY_1500_g207094 , ZY_2500_g207094 , ZY_3500_g207094 , XZ500_g207094 , XZ_1500_g207094 , XZ_2500_g207094 , XZ_3500_g207094 , XY500_g207094 , XY_1500_g207094 , XY_2500_g207094 , XY_3500_g207094 , Bias500_g207094 , Weights_1500_g207094 , Weights_2500_g207094 , Weights_3500_g207094 , Triplanar500_g207094 , NormalWS500_g207094 , Normal500_g207094 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch193_g207086 = localSampleCoord276_g207094;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch193_g207086 = localSampleCoord502_g207094;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch193_g207086 = localSamplePlanar2D496_g207094;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch193_g207086 = localSamplePlanar3D490_g207094;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch193_g207086 = localSampleStochastic2D498_g207094;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch193_g207086 = localSampleStochastic3D500_g207094;
				#else
				float4 staticSwitch193_g207086 = localSampleCoord276_g207094;
				#endif
				half4 Local_NormaTex191_g207086 = staticSwitch193_g207086;
				half4 Normal_Packed45_g207089 = Local_NormaTex191_g207086;
				float2 appendResult58_g207089 = (float2(( (Normal_Packed45_g207089).x * (Normal_Packed45_g207089).w ) , (Normal_Packed45_g207089).y));
				half2 Normal_Default50_g207089 = appendResult58_g207089;
				half2 Normal_ASTC41_g207089 = (Normal_Packed45_g207089).xy;
				#ifdef UNITY_ASTC_NORMALMAP_ENCODING
				float2 staticSwitch38_g207089 = Normal_ASTC41_g207089;
				#else
				float2 staticSwitch38_g207089 = Normal_Default50_g207089;
				#endif
				half2 Normal_NO_DTX544_g207089 = (Normal_Packed45_g207089).wy;
				#ifdef UNITY_NO_DXT5nm
				float2 staticSwitch37_g207089 = Normal_NO_DTX544_g207089;
				#else
				float2 staticSwitch37_g207089 = staticSwitch38_g207089;
				#endif
				float2 temp_output_26_0_g207086 = ( (staticSwitch37_g207089*2.0 + -1.0) * _MainNormalValue );
				float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
				half2 Normal_Planar45_g207090 = temp_output_26_0_g207086;
				float2 break71_g207090 = Normal_Planar45_g207090;
				float3 appendResult72_g207090 = (float3(break71_g207090.x , 0.0 , break71_g207090.y));
				float2 temp_output_205_0_g207086 = (mul( ase_worldToTangent, appendResult72_g207090 )).xy;
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#else
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#endif
				half2 Local_NormalTS108_g207086 = staticSwitch204_g207086;
				float2 In_NormalTS3_g207088 = Local_NormalTS108_g207086;
				float3 appendResult68_g207091 = (float3(Local_NormalTS108_g207086 , 1.0));
				float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
				float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
				float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
				float3 tanNormal74_g207091 = appendResult68_g207091;
				float3 worldNormal74_g207091 = normalize( float3( dot( tanToWorld0, tanNormal74_g207091 ), dot( tanToWorld1, tanNormal74_g207091 ), dot( tanToWorld2, tanNormal74_g207091 ) ) );
				half3 Local_NormalWS250_g207086 = worldNormal74_g207091;
				float3 In_NormalWS3_g207088 = Local_NormalWS250_g207086;
				float4 In_Shader3_g207088 = Local_Masks109_g207086;
				float4 In_Feature3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Season3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Emissive3_g207088 = half4( 1, 1, 1, 1 );
				float3 temp_output_3_0_g207092 = Local_Albedo139_g207086;
				float dotResult20_g207092 = dot( temp_output_3_0_g207092 , float3( 0.2126, 0.7152, 0.0722 ) );
				half Local_Grayscale110_g207086 = dotResult20_g207092;
				float temp_output_12_0_g207088 = Local_Grayscale110_g207086;
				float In_Grayscale3_g207088 = temp_output_12_0_g207088;
				float clampResult144_g207086 = clamp( saturate( ( Local_Grayscale110_g207086 * 5.0 ) ) , 0.2 , 1.0 );
				half Local_Luminosity145_g207086 = clampResult144_g207086;
				float temp_output_16_0_g207088 = Local_Luminosity145_g207086;
				float In_Luminosity3_g207088 = temp_output_16_0_g207088;
				float In_MultiMask3_g207088 = Local_MultiMask78_g207086;
				float temp_output_17_0_g251310 = _MainAlphaChannelMode;
				float Option83_g251310 = temp_output_17_0_g251310;
				TEXTURE2D(Texture276_g207099) = _MainAlphaTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g207100 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g207099 = staticSwitch36_g207100;
				float localBreakTextureData456_g207099 = ( 0.0 );
				TVEMasksData Data456_g207099 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207099 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207099 , Out_MaskA456_g207099 , Out_MaskB456_g207099 , Out_MaskC456_g207099 , Out_MaskD456_g207099 , Out_MaskE456_g207099 , Out_MaskF456_g207099 , Out_MaskG456_g207099 , Out_MaskH456_g207099 , Out_MaskI456_g207099 , Out_MaskJ456_g207099 , Out_MaskK456_g207099 , Out_MaskL456_g207099 , Out_MaskM456_g207099 , Out_MaskN456_g207099 );
				half2 UV276_g207099 = (Out_MaskA456_g207099).xy;
				float temp_output_504_0_g207099 = 0.0;
				half Bias276_g207099 = temp_output_504_0_g207099;
				half2 Normal276_g207099 = float2( 0,0 );
				half4 localSampleCoord276_g207099 = SampleCoord( Texture276_g207099 , Sampler276_g207099 , UV276_g207099 , Bias276_g207099 , Normal276_g207099 );
				TEXTURE2D(Texture502_g207099) = _MainAlphaTex;
				SamplerState Sampler502_g207099 = staticSwitch36_g207100;
				half2 UV502_g207099 = (Out_MaskA456_g207099).zw;
				half Bias502_g207099 = temp_output_504_0_g207099;
				half2 Normal502_g207099 = float2( 0,0 );
				half4 localSampleCoord502_g207099 = SampleCoord( Texture502_g207099 , Sampler502_g207099 , UV502_g207099 , Bias502_g207099 , Normal502_g207099 );
				TEXTURE2D(Texture496_g207099) = _MainAlphaTex;
				SamplerState Sampler496_g207099 = staticSwitch36_g207100;
				float2 temp_output_463_0_g207099 = (Out_MaskB456_g207099).zw;
				half2 XZ496_g207099 = temp_output_463_0_g207099;
				half Bias496_g207099 = temp_output_504_0_g207099;
				float3 temp_output_483_0_g207099 = (Out_MaskK456_g207099).xyz;
				half3 NormalWS496_g207099 = temp_output_483_0_g207099;
				half3 Normal496_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207099 = SamplePlanar2D( Texture496_g207099 , Sampler496_g207099 , XZ496_g207099 , Bias496_g207099 , NormalWS496_g207099 , Normal496_g207099 );
				TEXTURE2D(Texture490_g207099) = _MainAlphaTex;
				SamplerState Sampler490_g207099 = staticSwitch36_g207100;
				float2 temp_output_462_0_g207099 = (Out_MaskB456_g207099).xy;
				half2 ZY490_g207099 = temp_output_462_0_g207099;
				half2 XZ490_g207099 = temp_output_463_0_g207099;
				float2 temp_output_464_0_g207099 = (Out_MaskC456_g207099).xy;
				half2 XY490_g207099 = temp_output_464_0_g207099;
				half Bias490_g207099 = temp_output_504_0_g207099;
				float3 temp_output_482_0_g207099 = (Out_MaskN456_g207099).xyz;
				half3 Triplanar490_g207099 = temp_output_482_0_g207099;
				half3 NormalWS490_g207099 = temp_output_483_0_g207099;
				half3 Normal490_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207099 = SamplePlanar3D( Texture490_g207099 , Sampler490_g207099 , ZY490_g207099 , XZ490_g207099 , XY490_g207099 , Bias490_g207099 , Triplanar490_g207099 , NormalWS490_g207099 , Normal490_g207099 );
				TEXTURE2D(Texture498_g207099) = _MainAlphaTex;
				SamplerState Sampler498_g207099 = staticSwitch36_g207100;
				half2 XZ498_g207099 = temp_output_463_0_g207099;
				float2 temp_output_473_0_g207099 = (Out_MaskE456_g207099).xy;
				half2 XZ_1498_g207099 = temp_output_473_0_g207099;
				float2 temp_output_474_0_g207099 = (Out_MaskE456_g207099).zw;
				half2 XZ_2498_g207099 = temp_output_474_0_g207099;
				float2 temp_output_475_0_g207099 = (Out_MaskF456_g207099).xy;
				half2 XZ_3498_g207099 = temp_output_475_0_g207099;
				float temp_output_510_0_g207099 = exp2( temp_output_504_0_g207099 );
				half Bias498_g207099 = temp_output_510_0_g207099;
				float3 temp_output_480_0_g207099 = (Out_MaskI456_g207099).xyz;
				half3 Weights_2498_g207099 = temp_output_480_0_g207099;
				half3 NormalWS498_g207099 = temp_output_483_0_g207099;
				half3 Normal498_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207099 = SampleStochastic2D( Texture498_g207099 , Sampler498_g207099 , XZ498_g207099 , XZ_1498_g207099 , XZ_2498_g207099 , XZ_3498_g207099 , Bias498_g207099 , Weights_2498_g207099 , NormalWS498_g207099 , Normal498_g207099 );
				TEXTURE2D(Texture500_g207099) = _MainAlphaTex;
				SamplerState Sampler500_g207099 = staticSwitch36_g207100;
				half2 ZY500_g207099 = temp_output_462_0_g207099;
				half2 ZY_1500_g207099 = (Out_MaskC456_g207099).zw;
				half2 ZY_2500_g207099 = (Out_MaskD456_g207099).xy;
				half2 ZY_3500_g207099 = (Out_MaskD456_g207099).zw;
				half2 XZ500_g207099 = temp_output_463_0_g207099;
				half2 XZ_1500_g207099 = temp_output_473_0_g207099;
				half2 XZ_2500_g207099 = temp_output_474_0_g207099;
				half2 XZ_3500_g207099 = temp_output_475_0_g207099;
				half2 XY500_g207099 = temp_output_464_0_g207099;
				half2 XY_1500_g207099 = (Out_MaskF456_g207099).zw;
				half2 XY_2500_g207099 = (Out_MaskG456_g207099).xy;
				half2 XY_3500_g207099 = (Out_MaskG456_g207099).zw;
				half Bias500_g207099 = temp_output_510_0_g207099;
				half3 Weights_1500_g207099 = (Out_MaskH456_g207099).xyz;
				half3 Weights_2500_g207099 = temp_output_480_0_g207099;
				half3 Weights_3500_g207099 = (Out_MaskJ456_g207099).xyz;
				half3 Triplanar500_g207099 = temp_output_482_0_g207099;
				half3 NormalWS500_g207099 = temp_output_483_0_g207099;
				half3 Normal500_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207099 = SampleStochastic3D( Texture500_g207099 , Sampler500_g207099 , ZY500_g207099 , ZY_1500_g207099 , ZY_2500_g207099 , ZY_3500_g207099 , XZ500_g207099 , XZ_1500_g207099 , XZ_2500_g207099 , XZ_3500_g207099 , XY500_g207099 , XY_1500_g207099 , XY_2500_g207099 , XY_3500_g207099 , Bias500_g207099 , Weights_1500_g207099 , Weights_2500_g207099 , Weights_3500_g207099 , Triplanar500_g207099 , NormalWS500_g207099 , Normal500_g207099 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch327_g207086 = localSampleCoord276_g207099;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch327_g207086 = localSampleCoord502_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch327_g207086 = localSamplePlanar2D496_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch327_g207086 = localSamplePlanar3D490_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch327_g207086 = localSampleStochastic2D498_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch327_g207086 = localSampleStochastic3D500_g207099;
				#else
				float4 staticSwitch327_g207086 = localSampleCoord276_g207099;
				#endif
				half4 Local_AlphaTex330_g207086 = staticSwitch327_g207086;
				float4 temp_output_28_0_g251311 = Local_AlphaTex330_g207086;
				float3 temp_output_29_0_g251311 = (temp_output_28_0_g251311).xyz;
				half3 linRGB27_g251311 = temp_output_29_0_g251311;
				half3 localLinearToGammaFloatFast27_g251311 = LinearToGammaFloatFast( linRGB27_g251311 );
				#ifdef UNITY_COLORSPACE_GAMMA
				float3 staticSwitch26_g251311 = temp_output_29_0_g251311;
				#else
				float3 staticSwitch26_g251311 = localLinearToGammaFloatFast27_g251311;
				#endif
				float4 appendResult31_g251311 = (float4(staticSwitch26_g251311 , (temp_output_28_0_g251311).w));
				float4 lerpResult442_g207086 = lerp( Local_AlphaTex330_g207086 , appendResult31_g251311 , _MainAlphaTexIsGamma);
				float4 ChannelA83_g251310 = lerpResult442_g207086;
				float4 ChannelB83_g251310 = ( 1.0 - lerpResult442_g207086 );
				float localSwitchChannel883_g251310 = SwitchChannel8( Option83_g251310 , ChannelA83_g251310 , ChannelB83_g251310 );
				float lerpResult385_g207086 = lerp( (Local_AlbedoTex185_g207086).w , localSwitchChannel883_g251310 , _MainAlphaSourceMode);
				#ifdef TVE_CLIPPING
				float staticSwitch236_g207086 = ( lerpResult385_g207086 - _MainAlphaClipValue );
				#else
				float staticSwitch236_g207086 = lerpResult385_g207086;
				#endif
				half Local_AlphaClip111_g207086 = staticSwitch236_g207086;
				float In_AlphaClip3_g207088 = Local_AlphaClip111_g207086;
				half Local_AlphaFade246_g207086 = (lerpResult62_g207086).a;
				float In_AlphaFade3_g207088 = Local_AlphaFade246_g207086;
				float3 temp_cast_10 = (1.0).xxx;
				float3 In_Translucency3_g207088 = temp_cast_10;
				float In_Transmission3_g207088 = 1.0;
				float In_Thickness3_g207088 = 0.0;
				float In_Diffusion3_g207088 = 0.0;
				float In_Depth3_g207088 = 0.0;
				BuildVisualData( Data3_g207088 , In_Dummy3_g207088 , In_Albedo3_g207088 , In_AlbedoBase3_g207088 , In_NormalTS3_g207088 , In_NormalWS3_g207088 , In_Shader3_g207088 , In_Feature3_g207088 , In_Season3_g207088 , In_Emissive3_g207088 , In_Grayscale3_g207088 , In_Luminosity3_g207088 , In_MultiMask3_g207088 , In_AlphaClip3_g207088 , In_AlphaFade3_g207088 , In_Translucency3_g207088 , In_Transmission3_g207088 , In_Thickness3_g207088 , In_Diffusion3_g207088 , In_Depth3_g207088 );
				TVEVisualData Data4_g251314 =(TVEVisualData)Data3_g207088;
				float Out_Dummy4_g251314 = 0.0;
				float3 Out_Albedo4_g251314 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g251314 = float3( 0,0,0 );
				float2 Out_NormalTS4_g251314 = float2( 0,0 );
				float3 Out_NormalWS4_g251314 = float3( 0,0,0 );
				float4 Out_Shader4_g251314 = float4( 0,0,0,0 );
				float4 Out_Feature4_g251314 = float4( 0,0,0,0 );
				float4 Out_Season4_g251314 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g251314 = float4( 0,0,0,0 );
				float Out_MultiMask4_g251314 = 0.0;
				float Out_Grayscale4_g251314 = 0.0;
				float Out_Luminosity4_g251314 = 0.0;
				float Out_AlphaClip4_g251314 = 0.0;
				float Out_AlphaFade4_g251314 = 0.0;
				float3 Out_Translucency4_g251314 = float3( 0,0,0 );
				float Out_Transmission4_g251314 = 0.0;
				float Out_Thickness4_g251314 = 0.0;
				float Out_Diffusion4_g251314 = 0.0;
				float Out_Depth4_g251314 = 0.0;
				BreakVisualData( Data4_g251314 , Out_Dummy4_g251314 , Out_Albedo4_g251314 , Out_AlbedoBase4_g251314 , Out_NormalTS4_g251314 , Out_NormalWS4_g251314 , Out_Shader4_g251314 , Out_Feature4_g251314 , Out_Season4_g251314 , Out_Emissive4_g251314 , Out_MultiMask4_g251314 , Out_Grayscale4_g251314 , Out_Luminosity4_g251314 , Out_AlphaClip4_g251314 , Out_AlphaFade4_g251314 , Out_Translucency4_g251314 , Out_Transmission4_g251314 , Out_Thickness4_g251314 , Out_Diffusion4_g251314 , Out_Depth4_g251314 );
				float3 appendResult23_g251313 = (float3(Out_NormalTS4_g251314 , 1.0));
				float3 temp_output_13_0_g251322 = appendResult23_g251313;
				float3 temp_output_33_0_g251322 = ( temp_output_13_0_g251322 * _render_normal );
				float3 switchResult12_g251322 = (((ase_vface>0)?(temp_output_13_0_g251322):(temp_output_33_0_g251322)));
				

				float3 Normal = switchResult12_g251322;
				float Alpha = 1;
				#if defined( _ALPHATEST_ON )
					float AlphaClipThreshold = _Cutoff;
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					input.positionCS.z = input.positionCS.z;
				#endif

				#if defined( _ALPHATEST_ON )
					AlphaDiscard( Alpha, AlphaClipThreshold );
				#endif

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = input.positionCS.z;
				#endif

				#if defined(_GBUFFER_NORMALS_OCT)
					float2 octNormalWS = PackNormalOctQuadEncode(NormalWS);
					float2 remappedOctNormalWS = saturate(octNormalWS * 0.5 + 0.5);
					half3 packedNormalWS = PackFloat2To888(remappedOctNormalWS);
					outNormalWS = half4(packedNormalWS, 0.0);
				#else
					#if defined(_NORMALMAP)
						#if _NORMAL_DROPOFF_TS
							float3 normalWS = TransformTangentToWorld(Normal, half3x3(TangentWS, BitangentWS, NormalWS));
						#elif _NORMAL_DROPOFF_OS
							float3 normalWS = TransformObjectToWorldNormal(Normal);
						#elif _NORMAL_DROPOFF_WS
							float3 normalWS = Normal;
						#endif
					#else
						float3 normalWS = NormalWS;
					#endif
					outNormalWS = half4(NormalizeNormalPerPixel(normalWS), 0.0);
				#endif

				#ifdef _WRITE_RENDERING_LAYERS
					outRenderingLayers = EncodeMeshRenderingLayer();
				#endif
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "GBuffer"
			Tags { "LightMode"="UniversalGBuffer" }

			Blend One Zero, One Zero
			ZWrite [_render_zw]
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA
			

			HLSLPROGRAM

			#define ASE_GEOMETRY
			#define ASE_OPAQUE_KEEP_ALPHA
			#define _NORMAL_DROPOFF_TS 1
			#pragma shader_feature_local _RECEIVE_SHADOWS_OFF
			#pragma shader_feature_local_fragment _SPECULARHIGHLIGHTS_OFF
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#define _NORMALMAP 1
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION 170300
			#define ASE_USING_SAMPLING_MACROS 1


			// Deferred Rendering Path does not support the OpenGL-based graphics API:
			// Desktop OpenGL, OpenGL ES 3.0, WebGL 2.0.
			#pragma exclude_renderers glcore gles3 webgpu 

			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
			#pragma multi_compile _ EVALUATE_SH_MIXED EVALUATE_SH_VERTEX
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
			#pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
			#pragma multi_compile_fragment _ _SCREEN_SPACE_IRRADIANCE
			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT
			#pragma multi_compile_fragment _ _RENDER_PASS_ENABLED
			#pragma multi_compile _ _CLUSTER_LIGHT_LOOP

			#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ USE_LEGACY_LIGHTMAPS
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile_fragment _ LIGHTMAP_BICUBIC_SAMPLING
			#pragma multi_compile_fragment _ REFLECTION_PROBE_ROTATION
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON

			#pragma vertex vert
			#pragma fragment frag

			#if defined( _SPECULAR_SETUP ) && defined( ASE_LIGHTING_SIMPLE )
				#if defined( _SPECULARHIGHLIGHTS_OFF )
					#undef _SPECULAR_COLOR
				#else
					#define _SPECULAR_COLOR
				#endif
			#endif

			#define SHADERPASS SHADERPASS_GBUFFER

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ProbeVolumeVariants.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#if defined( UNITY_INSTANCING_ENABLED ) && defined( ASE_INSTANCED_TERRAIN ) && ( defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL) || defined(_INSTANCEDTERRAINNORMALS_PIXEL) )
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
			#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
			#pragma shader_feature_local_fragment TVE_CLIPPING
			#if defined (TVE_CLIPPING) //Render Clip
				#define TVE_ALPHA_CLIP //Render Clip
			#endif //Render Clip
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END
			  
			struct TVEVisualData
			{  
				half Dummy;  
				half3 Albedo;
				half3 AlbedoBase;
				half2 NormalTS;
				half3 NormalWS; 
				half4 Shader;
				half4 Feature;
				half4 Season;
				float4 Emissive;
				half AlphaClip;
				half AlphaFade;
				half MultiMask;
				half Grayscale;
				half Luminosity;
				float3 Translucency;
				half Transmission;
				half Thickness;
				float Diffusion;
				float Depth;
			};  
			    
			struct TVEModelData
			{    
				half Dummy;    
				float3 PositionOS;
				float3 PositionWS;
				float3 PositionWO;
				float3 PositionRawOS;
				float3 PivotOS;
				float3 PivotWS;
				float3 PivotWO;
				half3 NormalOS;
				half3 NormalWS;
				half3 NormalRawOS;
				half4 TangentOS;
				half3 TangentWS;
				half3 BitangentWS;
				half3 TriplanarWeights;
				half3 ViewDirWS;
				float4 CoordsData;
				half4 VertexData;
				half4 MasksData;   
				half4 PhaseData;
				half4 TransformData;
				half4 RotationData;
				float4 InterpolatorA;
			};    
			      
			struct TVEGlobalData
			{      
				half Dummy;      
				half4 CoatParams;
				half4 CoatTexture;
				half4 PaintParams;
				half4 PaintTexture;
				half4 AtmoParams;
				half4 AtmoTexture;
				half4 GlowParams;
				half4 GlowTexture;
				float4 FormParams;
				float4 FormTexture;
				half4 FlowParams;
				half4 FlowTexture;
			};      
			        
			struct TVEMasksData
			{        
				half4 MaskA;
				half4 MaskB;
				half4 MaskC;
				half4 MaskD;
				half4 MaskE;
				half4 MaskF;
				half4 MaskG;
				half4 MaskH;
				half4 MaskI;
				half4 MaskJ;
				half4 MaskK;
				half4 MaskL;
				half4 MaskM;
				half4 MaskN;
			};        
			#define TVE_GEOMETRY_SHADER


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				#if defined(LIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES1)
					float4 texcoord1 : TEXCOORD1;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES2)
					float4 texcoord2 : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				half3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2; // holds terrainUV ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
				float4 lightmapUVOrVertexSH : TEXCOORD3;
				#if defined(ASE_FOG) || defined(_ADDITIONAL_LIGHTS_VERTEX)
					half4 fogFactorAndVertexLight : TEXCOORD4;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
					float2 dynamicLightmapUV : TEXCOORD5;
				#endif
				#if defined(USE_APV_PROBE_OCCLUSION)
					float4 probeOcclusion : TEXCOORD6;
				#endif
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			half4 _MainOcclusionRemap;
			half4 _MainColor;
			half4 _MainColorTwo;
			half4 _MainMultiRemap;
			half4 _main_coord_value;
			half4 _MainSmoothnessRemap;
			half4 _MainCoordValue;
			half3 _render_normal;
			half _MainMultiVlaue;
			half _MainMultiSourceMode;
			half _MainMultiChannelMode;
			half _MainSmoothnessSourceMode;
			half _MainColorMode;
			float _MainSmoothnessTexGammaMode;
			half _MainSmoothnessChannelMode;
			half _MainOcclusionValue;
			half _MainSmoothnessValue;
			half _render_src;
			half _MainNormalValue;
			float _MainAlphaTexIsGamma;
			half _RenderMotion;
			half _RenderGBuffer;
			half _RenderMotionXR;
			half _RenderShadow;
			half _RenderClip;
			half _RenderFilter;
			half _MainAlphaChannelMode;
			half _RenderNormal;
			half _RenderPriority;
			half _RenderQueue;
			half _RenderZWrite;
			half _RenderCull;
			half _MainAlphaClipValue;
			half _MainAlphaSourceMode;
			half _RenderBakeGI;
			half _MainOcclusionSourceMode;
			half _MainMetallicSourceMode;
			half _MainMetallicValue;
			half _render_cull;
			half _render_dst;
			half _render_zw;
			half _render_coverage;
			half _IsGeneralShader;
			half _RenderEnd;
			half _IsVersion;
			half _IsTVEShader;
			half _IsLightingType;
			half _IsCustomShader;
			half _IsCollected;
			half _IsConverted;
			half _IsIdentifier;
			half _MainOcclusionChannelMode;
			half _IsShared;
			half _IsShaderType;
			half _IsObjectType;
			half _RenderCategory;
			half _IsStandardShader;
			half _MainCategory;
			half _MainEnd;
			half _MainSampleMode;
			half _MainCoordMode;
			half _MainMultiMaskInfo;
			half _MainSmoothnessInfo;
			half _ObjectPhaseMode;
			half _MainAlbedoValue;
			half _MainMetallicChannelMode;
			half _UseExternalSettings;
			half _RenderSpecular;
			float _AlphaClip;
			float _Cutoff;
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
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_Linear_Repeat_Aniso8);
			SAMPLER(sampler_Point_Repeat);
			SAMPLER(sampler_Linear_Repeat);
			float3 TVE_WorldOrigin;
			TEXTURE2D(_MainShaderTex);
			TEXTURE2D(_MainMetallicTex);
			TEXTURE2D(_MainOcclusionTex);
			TEXTURE2D(_MainSmoothnessTex);
			TEXTURE2D(_MainMultiTex);
			TEXTURE2D(_MainNormalTex);
			TEXTURE2D(_MainAlphaTex);
			half _DisableSRPBatcher;


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/GBufferOutput.hlsl"

			half3 ComputeTriplanarWeights( half3 NormalWS )
			{
				half3 powNormal = abs( NormalWS );
				half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
				tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
				return tempWeights;
			}
			
			float SwitchChannel4( half Option, half4 Channel )
			{
				switch (Option) {
					default:
				                case 0:
						return Channel.x;
					case 1:
						return Channel.y;
					case 2:
						return Channel.z;
					case 3:
						return Channel.w;
				}
			}
			
			void BuildModelFragData( out TVEModelData Data, half In_Dummy, float3 In_PositionWS, float3 In_PositionWO, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalWS, half3 In_TangentWS, half3 In_BitangentWS, half3 In_TriplanarWeights, half3 In_ViewDirWS, half4 In_CoordsData, half4 In_VertexData, half4 In_PhaseData )
			{
				Data = (TVEModelData)0;
				Data.Dummy = In_Dummy;
				Data.PositionWS = In_PositionWS;
				Data.PositionWO = In_PositionWO;
				Data.PivotWS = In_PivotWS;
				Data.PivotWO = In_PivotWO;
				Data.NormalWS = In_NormalWS;
				Data.TangentWS = In_TangentWS;
				Data.BitangentWS = In_BitangentWS;
				Data.TriplanarWeights = In_TriplanarWeights;
				Data.ViewDirWS = In_ViewDirWS;
				Data.CoordsData = In_CoordsData;
				Data.VertexData = In_VertexData;
				Data.PhaseData = In_PhaseData;
				return;
			}
			
			void BreakModelFragData( inout TVEModelData Data, out half Out_Dummy, out float3 Out_PositionWS, out float3 Out_PositionWO, out float3 Out_PivotWS, out float3 Out_PivotWO, out half3 Out_NormalWS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_TriplanarWeights, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_PhaseData )
			{
				Out_Dummy = Data.Dummy;
				Out_PositionWS = Data.PositionWS;
				Out_PositionWO = Data.PositionWO;
				Out_PivotWS = Data.PivotWS;
				Out_PivotWO = Data.PivotWO;
				Out_NormalWS = Data.NormalWS;
				Out_TangentWS = Data.TangentWS;
				Out_BitangentWS = Data.BitangentWS;
				Out_TriplanarWeights = Data.TriplanarWeights;
				Out_ViewDirWS = Data.ViewDirWS;
				Out_CoordsData = Data.CoordsData;
				Out_VertexData = Data.VertexData;
				Out_PhaseData = Data.PhaseData;
				return;
			}
			
			void ComputeMeshCoords( float4 Coords, float4 MeshCoords, out float2 UV0, out float2 UV3 )
			{
				UV0 = MeshCoords.xy * Coords.xy - Coords.zw; 
				UV3 = MeshCoords.zw * Coords.xy - Coords.zw; 
				return;
			}
			
			void ComputeWorldCoords( float4 Coords, float3 PositionWS, out float2 ZY, out float2 XZ, out float2 XY )
			{
				ZY = PositionWS.zy * Coords.xy - Coords.zw; 
				XZ = PositionWS.xz * Coords.xx - Coords.zz;
				XY = PositionWS.xy * Coords.xy - Coords.zw;
				return;
			}
			
			float2 ComputeStochasticHash22( float2 p )
			{
				float3 p3 = frac(float3(p.xyx) * float3(.1031, .1030, .0973));
				p3 += dot(p3, p3.yzx+33.33);
				return frac((p3.xx+p3.yz)*p3.zy);
			}
			
			void ComputeStochasticCoords( inout float2 UV, out float2 UV1, out float2 UV2, out float2 UV3, out float3 Weights )
			{
				half2 vertex1, vertex2, vertex3;
				// Scaling of the input
				half2 uv = UV * 3.464; // 2 * sqrt (3)
				// Skew input space into simplex triangle grid
				const float2x2 gridToSkewedGrid = float2x2( 1.0, 0.0, -0.57735027, 1.15470054 );
				half2 skewedCoord = mul( gridToSkewedGrid, uv );
				// Compute local triangle vertex IDs and local barycentric coordinates
				int2 baseId = int2( floor( skewedCoord ) );
				half3 temp = half3( frac( skewedCoord ), 0 );
				temp.z = 1.0 - temp.x - temp.y;
				if ( temp.z > 0.0 )
				{
					Weights.x = temp.z;
					Weights.y = temp.y;
					Weights.z = temp.x;
					vertex1 = baseId;
					vertex2 = baseId + int2( 0, 1 );
					vertex3 = baseId + int2( 1, 0 );
				}
				else
				{
					Weights.x = -temp.z;
					Weights.y = 1.0 - temp.y;
					Weights.z = 1.0 - temp.x;
					vertex1 = baseId + int2( 1, 1 );
					vertex2 = baseId + int2( 1, 0 );
					vertex3 = baseId + int2( 0, 1 );
				}
				UV1 = UV + ComputeStochasticHash22(vertex1);
				UV2 = UV + ComputeStochasticHash22(vertex2);
				UV3 = UV + ComputeStochasticHash22(vertex3);
				return;
			}
			
			void BuildTextureData( out TVEMasksData Data, float4 In_MaskA, float4 In_MaskB, float4 In_MaskC, float4 In_MaskD, float4 In_MaskE, float4 In_MaskF, float4 In_MaskG, half4 In_MaskH, half4 In_MaskI, half4 In_MaskJ, half4 In_MaskK, half4 In_MaskL, half4 In_MaskM, half4 In_MaskN )
			{
				Data.MaskA = In_MaskA;
				Data.MaskB = In_MaskB;
				Data.MaskC = In_MaskC;
				Data.MaskD = In_MaskD;
				Data.MaskE = In_MaskE;
				Data.MaskF = In_MaskF;
				Data.MaskG = In_MaskG;
				Data.MaskH = In_MaskH;
				Data.MaskI = In_MaskI;
				Data.MaskJ = In_MaskJ;
				Data.MaskK = In_MaskK;
				Data.MaskL = In_MaskL;
				Data.MaskM = In_MaskM;
				Data.MaskN = In_MaskN;
				return;
			}
			
			void BreakTextureData( TVEMasksData Data, out float4 Out_MaskA, out float4 Out_MaskB, out float4 Out_MaskC, out float4 Out_MaskD, out float4 Out_MaskE, out float4 Out_MaskF, out half4 Out_MaskG, out half4 Out_MaskH, out half4 Out_MaskI, out half4 Out_MaskJ, out half4 Out_MaskK, out half4 Out_MaskL, out half4 Out_MaskM, out half4 Out_MaskN )
			{
				Out_MaskA = Data.MaskA;
				Out_MaskB = Data.MaskB;
				Out_MaskC = Data.MaskC;
				Out_MaskD = Data.MaskD;
				Out_MaskE = Data.MaskE;
				Out_MaskF = Data.MaskF;
				Out_MaskG = Data.MaskG;
				Out_MaskH = Data.MaskH;
				Out_MaskI = Data.MaskI;
				Out_MaskJ = Data.MaskJ;
				Out_MaskK = Data.MaskK;
				Out_MaskL = Data.MaskL;
				Out_MaskM = Data.MaskM;
				Out_MaskN = Data.MaskN;
				return;
			}
			
			half4 SampleCoord( TEXTURE2D(Texture), SamplerState Sampler, half2 UV, half Bias, out half2 Normal )
			{
				half4 tex = SAMPLE_TEXTURE2D_BIAS( Texture, Sampler, UV, Bias);
				Normal = tex.wy * 2.0 - 1.0;
				return tex;
			}
			
			half4 SamplePlanar2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, half Bias, half3 NormalWS, out half3 Normal )
			{
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SamplePlanar3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 XZ, float2 XY, half Bias, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				half4 tex_X = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, ZY, Bias);
				half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
				half4 tex_Z = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XY, Bias);
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal =  normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			half4 SampleStochastic2D( TEXTURE2D(Texture), SamplerState Sampler, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, half Bias, half3 Weights_2, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				Normal = normal_Y;
				return tex_Y;
			}
			
			half4 SampleStochastic3D( TEXTURE2D(Texture), SamplerState Sampler, float2 ZY, float2 ZY_1, float2 ZY_2, float2 ZY_3, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, float2 XY, float2 XY_1, float2 XY_2, float2 XY_3, half Bias, half3 Weights_1, half3 Weights_2, half3 Weights_3, half3 Triplanar, half3 NormalWS, out half3 Normal )
			{
				float2 ddx_X = ddx(ZY) * Bias;
				float2 ddy_X= ddy(ZY) * Bias;
				half4 tex1_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_1, ddx_X, ddy_X);
				half4 tex2_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_2, ddx_X, ddy_X);
				half4 tex3_X = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, ZY_3, ddx_X, ddy_X);
				half4 tex_X = tex1_X * Weights_1.x + tex2_X * Weights_1.y + tex3_X * Weights_1.z;
				float2 ddx_Y = ddx(XZ) * Bias;
				float2 ddy_Y= ddy(XZ) * Bias;
				half4 tex1_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_1, ddx_Y, ddy_Y);
				half4 tex2_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_2, ddx_Y, ddy_Y);
				half4 tex3_Y = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XZ_3, ddx_Y, ddy_Y);
				half4 tex_Y = tex1_Y * Weights_2.x + tex2_Y * Weights_2.y + tex3_Y * Weights_2.z;
				float2 ddx_Z = ddx(XY) * Bias;
				float2 ddy_Z= ddy(XY) * Bias;
				half4 tex1_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_1, ddx_Z, ddy_Z);
				half4 tex2_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_2, ddx_Z, ddy_Z);
				half4 tex3_Z = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, XY_3, ddx_Z, ddy_Z);
				half4 tex_Z = tex1_Z * Weights_3.x + tex2_Z * Weights_3.y + tex3_Z * Weights_3.z;
				half3 normal_X = half3(tex_X.wy * 2.0 - 1.0, 1.0);
				normal_X = half3(normal_X.xy + NormalWS.zy, NormalWS.x).zyx;
				half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
				normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
				half3 normal_Z = half3(tex_Z.wy * 2.0 - 1.0, 1.0);
				normal_Z = half3(normal_Z.xy + NormalWS.xy, NormalWS.z).xyz;
				Normal = normal_X * Triplanar.x + normal_Y * Triplanar.y + normal_Z * Triplanar.z;
				return tex_X * Triplanar.x + tex_Y * Triplanar.y + tex_Z * Triplanar.z;
			}
			
			float SwitchChannel8( half Option, half4 ChannelA, half4 ChannelB )
			{
				switch (Option) {
					default:
				                case 0:
						return ChannelA.x;
					case 1:
						return ChannelA.y;
					case 2:
						return ChannelA.z;
					case 3:
						return ChannelA.w;
				                case 4:
						return ChannelB.x;
					case 5:
						return ChannelB.y;
					case 6:
						return ChannelB.z;
					case 7:
						return ChannelB.w;
				}
			}
			
			half3 LinearToGammaFloatFast( half3 linRGB )
			{
				return max(1.055h * pow(abs(linRGB), 0.416666667h) - 0.055h, 0.h);
			}
			
			void BuildVisualData( inout TVEVisualData Data, float In_Dummy, half3 In_Albedo, half3 In_AlbedoBase, half2 In_NormalTS, half3 In_NormalWS, half4 In_Shader, half4 In_Feature, half4 In_Season, half4 In_Emissive, half In_Grayscale, half In_Luminosity, half In_MultiMask, half In_AlphaClip, half In_AlphaFade, half3 In_Translucency, half In_Transmission, half In_Thickness, float In_Diffusion, float In_Depth )
			{
				//Data = (TVEVisualData)0;
				Data.Dummy = In_Dummy;
				Data.Albedo = In_Albedo;
				Data.AlbedoBase = In_AlbedoBase;
				Data.NormalTS = In_NormalTS;
				Data.NormalWS = In_NormalWS;
				Data.Shader = In_Shader;
				Data.Feature = In_Feature;
				Data.Season= In_Season;
				Data.Emissive= In_Emissive;
				Data.MultiMask = In_MultiMask;
				Data.Grayscale = In_Grayscale;
				Data.Luminosity = In_Luminosity;
				Data.AlphaClip = In_AlphaClip;
				Data.AlphaFade = In_AlphaFade;
				Data.Translucency = In_Translucency;
				Data.Transmission = In_Transmission;
				Data.Thickness = In_Thickness;
				Data.Diffusion = In_Diffusion;
				Data.Depth = In_Depth;
				return;
			}
			
			void BreakVisualData( inout TVEVisualData Data, out half Out_Dummy, out half3 Out_Albedo, out half3 Out_AlbedoBase, out half2 Out_NormalTS, out half3 Out_NormalWS, out half4 Out_Shader, out half4 Out_Feature, out half4 Out_Season, out half4 Out_Emissive, out half Out_MultiMask, out half Out_Grayscale, out half Out_Luminosity, out half Out_AlphaClip, out half Out_AlphaFade, out half3 Out_Translucency, out half Out_Transmission, out half Out_Thickness, out half Out_Diffusion, out float Out_Depth )
			{
				Out_Dummy = Data.Dummy;
				Out_Albedo = Data.Albedo;
				Out_AlbedoBase = Data.AlbedoBase;
				Out_NormalTS = Data.NormalTS;
				Out_NormalWS = Data.NormalWS;
				Out_Shader = Data.Shader;
				Out_Feature = Data.Feature;
				Out_Season = Data.Season;
				Out_Emissive= Data.Emissive;
				Out_MultiMask = Data.MultiMask;
				Out_Grayscale = Data.Grayscale;
				Out_Luminosity= Data.Luminosity;
				Out_AlphaClip = Data.AlphaClip;
				Out_AlphaFade = Data.AlphaFade;
				Out_Translucency = Data.Translucency;
				Out_Transmission = Data.Transmission;
				Out_Thickness = Data.Thickness;
				Out_Diffusion = Data.Diffusion;
				Out_Depth= Data.Depth;
				return;
			}
			

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float3 ase_positionWS = TransformObjectToWorld( ( input.positionOS ).xyz );
				float3 temp_output_104_7_g205214 = ase_positionWS;
				float3 vertexToFrag73_g205214 = temp_output_104_7_g205214;
				output.ase_texcoord7.xyz = vertexToFrag73_g205214;
				float4x4 break19_g205217 = GetObjectToWorldMatrix();
				float3 appendResult20_g205217 = (float3(break19_g205217[ 0 ][ 3 ] , break19_g205217[ 1 ][ 3 ] , break19_g205217[ 2 ][ 3 ]));
				float3 temp_output_340_7_g205214 = appendResult20_g205217;
				float4x4 break19_g205219 = GetObjectToWorldMatrix();
				float3 appendResult20_g205219 = (float3(break19_g205219[ 0 ][ 3 ] , break19_g205219[ 1 ][ 3 ] , break19_g205219[ 2 ][ 3 ]));
				float3 _Vector0 = float3(0,0,0);
				float3 appendResult60_g205215 = (float3(input.ase_texcoord3.x , input.ase_texcoord3.z , input.ase_texcoord3.y));
				float3 PositionOS131_g205214 = input.positionOS.xyz;
				float3 break233_g205214 = PositionOS131_g205214;
				float3 appendResult234_g205214 = (float3(break233_g205214.x , 0.0 , break233_g205214.z));
				float3 break413_g205214 = PositionOS131_g205214;
				float3 appendResult414_g205214 = (float3(break413_g205214.x , break413_g205214.y , 0.0));
				#ifdef TVE_COORD_ZUP
				float3 staticSwitch65_g205221 = appendResult414_g205214;
				#else
				float3 staticSwitch65_g205221 = appendResult234_g205214;
				#endif
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch229_g205214 = _Vector0;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch229_g205214 = appendResult60_g205215;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch229_g205214 = staticSwitch65_g205221;
				#else
				float3 staticSwitch229_g205214 = _Vector0;
				#endif
				float3 PivotOS149_g205214 = staticSwitch229_g205214;
				float3 temp_output_122_0_g205219 = PivotOS149_g205214;
				float3 PivotsOnlyWS105_g205219 = mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g205219 , 0.0 ) ).xyz;
				float3 temp_output_341_7_g205214 = ( appendResult20_g205219 + PivotsOnlyWS105_g205219 );
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch236_g205214 = temp_output_341_7_g205214;
				#else
				float3 staticSwitch236_g205214 = temp_output_340_7_g205214;
				#endif
				float3 vertexToFrag76_g205214 = staticSwitch236_g205214;
				output.ase_texcoord8.xyz = vertexToFrag76_g205214;
				
				output.ase_texcoord9.xy = input.texcoord.xy;
				output.ase_texcoord9.zw = input.texcoord2.xy;
				output.ase_color = input.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord7.w = 0;
				output.ase_texcoord8.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );
				VertexNormalInputs normalInput = GetVertexNormalInputs( input.normalOS, input.tangentOS );

				OUTPUT_LIGHTMAP_UV(input.texcoord1, unity_LightmapST, output.lightmapUVOrVertexSH.xy);
				#if defined(DYNAMICLIGHTMAP_ON)
					output.dynamicLightmapUV.xy = input.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif
				OUTPUT_SH4(vertexInput.positionWS, normalInput.normalWS.xyz, GetWorldSpaceNormalizeViewDir(vertexInput.positionWS), output.lightmapUVOrVertexSH.xyz, output.probeOcclusion);

				#if defined(ASE_FOG) || defined(_ADDITIONAL_LIGHTS_VERTEX)
					output.fogFactorAndVertexLight = 0;
					#if defined(ASE_FOG) && !defined(_FOG_FRAGMENT)
						// @diogo: no fog applied in GBuffer
					#endif
					#ifdef _ADDITIONAL_LIGHTS_VERTEX
						half3 vertexLight = VertexLighting( vertexInput.positionWS, normalInput.normalWS );
						output.fogFactorAndVertexLight.yzw = vertexLight;
					#endif
				#endif

				output.positionCS = vertexInput.positionCS;
				output.positionWS = vertexInput.positionWS;
				output.normalWS = normalInput.normalWS;
				output.tangentWS = float4( normalInput.tangentWS, ( input.tangentOS.w > 0.0 ? 1.0 : -1.0 ) * GetOddNegativeScale() );

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					output.tangentWS.zw = input.texcoord.xy;
					output.tangentWS.xy = input.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				#if defined(LIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES1)
					float4 texcoord1 : TEXCOORD1;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES2)
					float4 texcoord2 : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				output.texcoord = input.texcoord;
				#if defined(LIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES1)
					output.texcoord1 = input.texcoord1;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES2)
					output.texcoord2 = input.texcoord2;
				#endif
				output.texcoord = input.texcoord;
				output.ase_texcoord3 = input.ase_texcoord3;
				output.ase_color = input.ase_color;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
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
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				output.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				#if defined(LIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES1)
					output.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON) || defined(ASE_NEEDS_TEXTURE_COORDINATES2)
					output.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				#endif
				output.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				output.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			GBufferFragOutput frag ( PackedVaryings input
								#if defined( ASE_DEPTH_WRITE_ON )
								,out float outputDepth : ASE_SV_DEPTH
								#endif
								, uint ase_vface : SV_IsFrontFace )
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					float4 shadowCoord = TransformWorldToShadowCoord( input.positionWS );
				#else
					float4 shadowCoord = float4(0, 0, 0, 0);
				#endif

				// @diogo: mikktspace compliant
				float renormFactor = 1.0 / max( FLT_MIN, length( input.normalWS ) );

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( PositionWS );
				float3 ViewDirWS = GetWorldSpaceNormalizeViewDir( PositionWS );
				float4 ShadowCoord = shadowCoord;
				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos );
				float3 TangentWS = input.tangentWS.xyz * renormFactor;
				float3 BitangentWS = cross( input.normalWS, input.tangentWS.xyz ) * input.tangentWS.w * renormFactor;
				float3 NormalWS = input.normalWS * renormFactor;

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					float2 sampleCoords = (input.tangentWS.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					NormalWS = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					TangentWS = -cross(GetObjectToWorldMatrix()._13_23_33, NormalWS);
					BitangentWS = cross(NormalWS, -TangentWS);
				#endif

				float localBreakVisualData4_g251314 = ( 0.0 );
				float localBuildVisualData3_g207088 = ( 0.0 );
				TVEVisualData Data3_g207088 =(TVEVisualData)0;
				half4 Dummy130_g207086 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) + _MainMultiMaskInfo + _MainSmoothnessInfo );
				float temp_output_14_0_g207088 = Dummy130_g207086.x;
				float In_Dummy3_g207088 = temp_output_14_0_g207088;
				TEXTURE2D(Texture276_g207093) = _MainAlbedoTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g207096 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g207096 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g207093 = staticSwitch36_g207096;
				float localBreakTextureData456_g207093 = ( 0.0 );
				float localBuildTextureData431_g251292 = ( 0.0 );
				TVEMasksData Data431_g251292 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g251292 = ( 0.0 );
				half4 Local_Coords180_g207086 = _main_coord_value;
				float4 Coords444_g251292 = Local_Coords180_g207086;
				TVEModelData Data16_g205222 =(TVEModelData)(TVEModelData)0;
				float In_Dummy16_g205222 = 0.0;
				float3 vertexToFrag73_g205214 = input.ase_texcoord7.xyz;
				float3 PositionWS122_g205214 = vertexToFrag73_g205214;
				float3 In_PositionWS16_g205222 = PositionWS122_g205214;
				float3 vertexToFrag76_g205214 = input.ase_texcoord8.xyz;
				float3 PivotWS121_g205214 = vertexToFrag76_g205214;
				#ifdef TVE_SCOPE_DYNAMIC
				float3 staticSwitch204_g205214 = ( PositionWS122_g205214 - PivotWS121_g205214 );
				#else
				float3 staticSwitch204_g205214 = PositionWS122_g205214;
				#endif
				float3 PositionWO132_g205214 = ( staticSwitch204_g205214 - TVE_WorldOrigin );
				float3 In_PositionWO16_g205222 = PositionWO132_g205214;
				float3 In_PivotWS16_g205222 = PivotWS121_g205214;
				float3 PivotWO133_g205214 = ( PivotWS121_g205214 - TVE_WorldOrigin );
				float3 In_PivotWO16_g205222 = PivotWO133_g205214;
				float3 normalizedWorldNormal = normalize( NormalWS );
				half3 NormalWS95_g205214 = normalizedWorldNormal;
				float3 In_NormalWS16_g205222 = NormalWS95_g205214;
				half3 TangentWS136_g205214 = TangentWS;
				float3 In_TangentWS16_g205222 = TangentWS136_g205214;
				half3 BiangentWS421_g205214 = BitangentWS;
				float3 In_BitangentWS16_g205222 = BiangentWS421_g205214;
				half3 NormalWS427_g205214 = NormalWS95_g205214;
				half3 localComputeTriplanarWeights427_g205214 = ComputeTriplanarWeights( NormalWS427_g205214 );
				half3 TriplanarWeights429_g205214 = localComputeTriplanarWeights427_g205214;
				float3 In_TriplanarWeights16_g205222 = TriplanarWeights429_g205214;
				float3 normalizeResult296_g205214 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g205214 ) );
				half3 ViewDirWS169_g205214 = normalizeResult296_g205214;
				float3 In_ViewDirWS16_g205222 = ViewDirWS169_g205214;
				float4 appendResult397_g205214 = (float4(input.ase_texcoord9.xy , input.ase_texcoord9.zw));
				float4 CoordsData398_g205214 = appendResult397_g205214;
				float4 In_CoordsData16_g205222 = CoordsData398_g205214;
				half4 VertexMasks171_g205214 = input.ase_color;
				float4 In_VertexData16_g205222 = VertexMasks171_g205214;
				float temp_output_17_0_g205226 = _ObjectPhaseMode;
				float Option70_g205226 = temp_output_17_0_g205226;
				float4 temp_output_3_0_g205226 = input.ase_color;
				float4 Channel70_g205226 = temp_output_3_0_g205226;
				float localSwitchChannel470_g205226 = SwitchChannel4( Option70_g205226 , Channel70_g205226 );
				half Phase_Value372_g205214 = localSwitchChannel470_g205226;
				float3 break319_g205214 = PivotWO133_g205214;
				half Pivot_Position322_g205214 = ( break319_g205214.x + break319_g205214.z );
				half Phase_Position357_g205214 = ( Phase_Value372_g205214 + Pivot_Position322_g205214 );
				float temp_output_248_0_g205214 = frac( Phase_Position357_g205214 );
				float4 appendResult177_g205214 = (float4(( (frac( ( Phase_Position357_g205214 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g205214));
				half4 Phase_Data176_g205214 = appendResult177_g205214;
				float4 In_PhaseData16_g205222 = Phase_Data176_g205214;
				BuildModelFragData( Data16_g205222 , In_Dummy16_g205222 , In_PositionWS16_g205222 , In_PositionWO16_g205222 , In_PivotWS16_g205222 , In_PivotWO16_g205222 , In_NormalWS16_g205222 , In_TangentWS16_g205222 , In_BitangentWS16_g205222 , In_TriplanarWeights16_g205222 , In_ViewDirWS16_g205222 , In_CoordsData16_g205222 , In_VertexData16_g205222 , In_PhaseData16_g205222 );
				TVEModelData Data15_g207087 =(TVEModelData)Data16_g205222;
				float Out_Dummy15_g207087 = 0.0;
				float3 Out_PositionWS15_g207087 = float3( 0,0,0 );
				float3 Out_PositionWO15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWS15_g207087 = float3( 0,0,0 );
				float3 Out_PivotWO15_g207087 = float3( 0,0,0 );
				float3 Out_NormalWS15_g207087 = float3( 0,0,0 );
				float3 Out_TangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g207087 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g207087 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g207087 = float3( 0,0,0 );
				float4 Out_CoordsData15_g207087 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g207087 = float4( 0,0,0,0 );
				float4 Out_PhaseData15_g207087 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g207087 , Out_Dummy15_g207087 , Out_PositionWS15_g207087 , Out_PositionWO15_g207087 , Out_PivotWS15_g207087 , Out_PivotWO15_g207087 , Out_NormalWS15_g207087 , Out_TangentWS15_g207087 , Out_BitangentWS15_g207087 , Out_TriplanarWeights15_g207087 , Out_ViewDirWS15_g207087 , Out_CoordsData15_g207087 , Out_VertexData15_g207087 , Out_PhaseData15_g207087 );
				half4 Model_CoordsData412_g207086 = Out_CoordsData15_g207087;
				float4 MeshCoords444_g251292 = Model_CoordsData412_g207086;
				float2 UV0444_g251292 = float2( 0,0 );
				float2 UV3444_g251292 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g251292 , MeshCoords444_g251292 , UV0444_g251292 , UV3444_g251292 );
				float4 appendResult430_g251292 = (float4(UV0444_g251292 , UV3444_g251292));
				float4 In_MaskA431_g251292 = appendResult430_g251292;
				float localComputeWorldCoords315_g251292 = ( 0.0 );
				float4 Coords315_g251292 = Local_Coords180_g207086;
				half3 Model_PositionWO222_g207086 = Out_PositionWO15_g207087;
				float3 PositionWS315_g251292 = Model_PositionWO222_g207086;
				float2 ZY315_g251292 = float2( 0,0 );
				float2 XZ315_g251292 = float2( 0,0 );
				float2 XY315_g251292 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g251292 , PositionWS315_g251292 , ZY315_g251292 , XZ315_g251292 , XY315_g251292 );
				float2 ZY402_g251292 = ZY315_g251292;
				float2 XZ403_g251292 = XZ315_g251292;
				float4 appendResult432_g251292 = (float4(ZY402_g251292 , XZ403_g251292));
				float4 In_MaskB431_g251292 = appendResult432_g251292;
				float2 XY404_g251292 = XY315_g251292;
				float localComputeStochasticCoords409_g251292 = ( 0.0 );
				float2 UV409_g251292 = ZY402_g251292;
				float2 UV1409_g251292 = float2( 0,0 );
				float2 UV2409_g251292 = float2( 0,0 );
				float2 UV3409_g251292 = float2( 0,0 );
				float3 Weights409_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g251292 , UV1409_g251292 , UV2409_g251292 , UV3409_g251292 , Weights409_g251292 );
				float4 appendResult433_g251292 = (float4(XY404_g251292 , UV1409_g251292));
				float4 In_MaskC431_g251292 = appendResult433_g251292;
				float4 appendResult434_g251292 = (float4(UV2409_g251292 , UV3409_g251292));
				float4 In_MaskD431_g251292 = appendResult434_g251292;
				float localComputeStochasticCoords422_g251292 = ( 0.0 );
				float2 UV422_g251292 = XZ403_g251292;
				float2 UV1422_g251292 = float2( 0,0 );
				float2 UV2422_g251292 = float2( 0,0 );
				float2 UV3422_g251292 = float2( 0,0 );
				float3 Weights422_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g251292 , UV1422_g251292 , UV2422_g251292 , UV3422_g251292 , Weights422_g251292 );
				float4 appendResult435_g251292 = (float4(UV1422_g251292 , UV2422_g251292));
				float4 In_MaskE431_g251292 = appendResult435_g251292;
				float localComputeStochasticCoords423_g251292 = ( 0.0 );
				float2 UV423_g251292 = XY404_g251292;
				float2 UV1423_g251292 = float2( 0,0 );
				float2 UV2423_g251292 = float2( 0,0 );
				float2 UV3423_g251292 = float2( 0,0 );
				float3 Weights423_g251292 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g251292 , UV1423_g251292 , UV2423_g251292 , UV3423_g251292 , Weights423_g251292 );
				float4 appendResult436_g251292 = (float4(UV3422_g251292 , UV1423_g251292));
				float4 In_MaskF431_g251292 = appendResult436_g251292;
				float4 appendResult437_g251292 = (float4(UV2423_g251292 , UV3423_g251292));
				float4 In_MaskG431_g251292 = appendResult437_g251292;
				float4 In_MaskH431_g251292 = float4( Weights409_g251292 , 0.0 );
				float4 In_MaskI431_g251292 = float4( Weights422_g251292 , 0.0 );
				float4 In_MaskJ431_g251292 = float4( Weights423_g251292 , 0.0 );
				float3 temp_output_449_0_g251292 = float3( 0,0,0 );
				float4 In_MaskK431_g251292 = float4( temp_output_449_0_g251292 , 0.0 );
				float3 temp_output_450_0_g251292 = float3( 0,0,0 );
				float4 In_MaskL431_g251292 = float4( temp_output_450_0_g251292 , 0.0 );
				float3 temp_output_451_0_g251292 = float3( 0,0,0 );
				float4 In_MaskM431_g251292 = float4( temp_output_451_0_g251292 , 0.0 );
				float3 temp_output_445_0_g251292 = float3( 0,0,0 );
				float4 In_MaskN431_g251292 = float4( temp_output_445_0_g251292 , 0.0 );
				BuildTextureData( Data431_g251292 , In_MaskA431_g251292 , In_MaskB431_g251292 , In_MaskC431_g251292 , In_MaskD431_g251292 , In_MaskE431_g251292 , In_MaskF431_g251292 , In_MaskG431_g251292 , In_MaskH431_g251292 , In_MaskI431_g251292 , In_MaskJ431_g251292 , In_MaskK431_g251292 , In_MaskL431_g251292 , In_MaskM431_g251292 , In_MaskN431_g251292 );
				TVEMasksData Data456_g207093 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207093 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207093 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207093 , Out_MaskA456_g207093 , Out_MaskB456_g207093 , Out_MaskC456_g207093 , Out_MaskD456_g207093 , Out_MaskE456_g207093 , Out_MaskF456_g207093 , Out_MaskG456_g207093 , Out_MaskH456_g207093 , Out_MaskI456_g207093 , Out_MaskJ456_g207093 , Out_MaskK456_g207093 , Out_MaskL456_g207093 , Out_MaskM456_g207093 , Out_MaskN456_g207093 );
				half2 UV276_g207093 = (Out_MaskA456_g207093).xy;
				float temp_output_504_0_g207093 = 0.0;
				half Bias276_g207093 = temp_output_504_0_g207093;
				half2 Normal276_g207093 = float2( 0,0 );
				half4 localSampleCoord276_g207093 = SampleCoord( Texture276_g207093 , Sampler276_g207093 , UV276_g207093 , Bias276_g207093 , Normal276_g207093 );
				TEXTURE2D(Texture502_g207093) = _MainAlbedoTex;
				SamplerState Sampler502_g207093 = staticSwitch36_g207096;
				half2 UV502_g207093 = (Out_MaskA456_g207093).zw;
				half Bias502_g207093 = temp_output_504_0_g207093;
				half2 Normal502_g207093 = float2( 0,0 );
				half4 localSampleCoord502_g207093 = SampleCoord( Texture502_g207093 , Sampler502_g207093 , UV502_g207093 , Bias502_g207093 , Normal502_g207093 );
				TEXTURE2D(Texture496_g207093) = _MainAlbedoTex;
				SamplerState Sampler496_g207093 = staticSwitch36_g207096;
				float2 temp_output_463_0_g207093 = (Out_MaskB456_g207093).zw;
				half2 XZ496_g207093 = temp_output_463_0_g207093;
				half Bias496_g207093 = temp_output_504_0_g207093;
				float3 temp_output_483_0_g207093 = (Out_MaskK456_g207093).xyz;
				half3 NormalWS496_g207093 = temp_output_483_0_g207093;
				half3 Normal496_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207093 = SamplePlanar2D( Texture496_g207093 , Sampler496_g207093 , XZ496_g207093 , Bias496_g207093 , NormalWS496_g207093 , Normal496_g207093 );
				TEXTURE2D(Texture490_g207093) = _MainAlbedoTex;
				SamplerState Sampler490_g207093 = staticSwitch36_g207096;
				float2 temp_output_462_0_g207093 = (Out_MaskB456_g207093).xy;
				half2 ZY490_g207093 = temp_output_462_0_g207093;
				half2 XZ490_g207093 = temp_output_463_0_g207093;
				float2 temp_output_464_0_g207093 = (Out_MaskC456_g207093).xy;
				half2 XY490_g207093 = temp_output_464_0_g207093;
				half Bias490_g207093 = temp_output_504_0_g207093;
				float3 temp_output_482_0_g207093 = (Out_MaskN456_g207093).xyz;
				half3 Triplanar490_g207093 = temp_output_482_0_g207093;
				half3 NormalWS490_g207093 = temp_output_483_0_g207093;
				half3 Normal490_g207093 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207093 = SamplePlanar3D( Texture490_g207093 , Sampler490_g207093 , ZY490_g207093 , XZ490_g207093 , XY490_g207093 , Bias490_g207093 , Triplanar490_g207093 , NormalWS490_g207093 , Normal490_g207093 );
				TEXTURE2D(Texture498_g207093) = _MainAlbedoTex;
				SamplerState Sampler498_g207093 = staticSwitch36_g207096;
				half2 XZ498_g207093 = temp_output_463_0_g207093;
				float2 temp_output_473_0_g207093 = (Out_MaskE456_g207093).xy;
				half2 XZ_1498_g207093 = temp_output_473_0_g207093;
				float2 temp_output_474_0_g207093 = (Out_MaskE456_g207093).zw;
				half2 XZ_2498_g207093 = temp_output_474_0_g207093;
				float2 temp_output_475_0_g207093 = (Out_MaskF456_g207093).xy;
				half2 XZ_3498_g207093 = temp_output_475_0_g207093;
				float temp_output_510_0_g207093 = exp2( temp_output_504_0_g207093 );
				half Bias498_g207093 = temp_output_510_0_g207093;
				float3 temp_output_480_0_g207093 = (Out_MaskI456_g207093).xyz;
				half3 Weights_2498_g207093 = temp_output_480_0_g207093;
				half3 NormalWS498_g207093 = temp_output_483_0_g207093;
				half3 Normal498_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207093 = SampleStochastic2D( Texture498_g207093 , Sampler498_g207093 , XZ498_g207093 , XZ_1498_g207093 , XZ_2498_g207093 , XZ_3498_g207093 , Bias498_g207093 , Weights_2498_g207093 , NormalWS498_g207093 , Normal498_g207093 );
				TEXTURE2D(Texture500_g207093) = _MainAlbedoTex;
				SamplerState Sampler500_g207093 = staticSwitch36_g207096;
				half2 ZY500_g207093 = temp_output_462_0_g207093;
				half2 ZY_1500_g207093 = (Out_MaskC456_g207093).zw;
				half2 ZY_2500_g207093 = (Out_MaskD456_g207093).xy;
				half2 ZY_3500_g207093 = (Out_MaskD456_g207093).zw;
				half2 XZ500_g207093 = temp_output_463_0_g207093;
				half2 XZ_1500_g207093 = temp_output_473_0_g207093;
				half2 XZ_2500_g207093 = temp_output_474_0_g207093;
				half2 XZ_3500_g207093 = temp_output_475_0_g207093;
				half2 XY500_g207093 = temp_output_464_0_g207093;
				half2 XY_1500_g207093 = (Out_MaskF456_g207093).zw;
				half2 XY_2500_g207093 = (Out_MaskG456_g207093).xy;
				half2 XY_3500_g207093 = (Out_MaskG456_g207093).zw;
				half Bias500_g207093 = temp_output_510_0_g207093;
				half3 Weights_1500_g207093 = (Out_MaskH456_g207093).xyz;
				half3 Weights_2500_g207093 = temp_output_480_0_g207093;
				half3 Weights_3500_g207093 = (Out_MaskJ456_g207093).xyz;
				half3 Triplanar500_g207093 = temp_output_482_0_g207093;
				half3 NormalWS500_g207093 = temp_output_483_0_g207093;
				half3 Normal500_g207093 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207093 = SampleStochastic3D( Texture500_g207093 , Sampler500_g207093 , ZY500_g207093 , ZY_1500_g207093 , ZY_2500_g207093 , ZY_3500_g207093 , XZ500_g207093 , XZ_1500_g207093 , XZ_2500_g207093 , XZ_3500_g207093 , XY500_g207093 , XY_1500_g207093 , XY_2500_g207093 , XY_3500_g207093 , Bias500_g207093 , Weights_1500_g207093 , Weights_2500_g207093 , Weights_3500_g207093 , Triplanar500_g207093 , NormalWS500_g207093 , Normal500_g207093 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch184_g207086 = localSampleCoord502_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch184_g207086 = localSamplePlanar2D496_g207093;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch184_g207086 = localSamplePlanar3D490_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch184_g207086 = localSampleStochastic2D498_g207093;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch184_g207086 = localSampleStochastic3D500_g207093;
				#else
				float4 staticSwitch184_g207086 = localSampleCoord276_g207093;
				#endif
				half4 Local_AlbedoTex185_g207086 = staticSwitch184_g207086;
				float3 lerpResult53_g207086 = lerp( float3( 1,1,1 ) , (Local_AlbedoTex185_g207086).xyz , _MainAlbedoValue);
				half3 Local_AlbedoRGB107_g207086 = lerpResult53_g207086;
				TEXTURE2D(Texture276_g207097) = _MainShaderTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207098 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207098 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207097 = staticSwitch38_g207098;
				float localBreakTextureData456_g207097 = ( 0.0 );
				TVEMasksData Data456_g207097 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207097 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207097 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207097 , Out_MaskA456_g207097 , Out_MaskB456_g207097 , Out_MaskC456_g207097 , Out_MaskD456_g207097 , Out_MaskE456_g207097 , Out_MaskF456_g207097 , Out_MaskG456_g207097 , Out_MaskH456_g207097 , Out_MaskI456_g207097 , Out_MaskJ456_g207097 , Out_MaskK456_g207097 , Out_MaskL456_g207097 , Out_MaskM456_g207097 , Out_MaskN456_g207097 );
				half2 UV276_g207097 = (Out_MaskA456_g207097).xy;
				float temp_output_504_0_g207097 = 0.0;
				half Bias276_g207097 = temp_output_504_0_g207097;
				half2 Normal276_g207097 = float2( 0,0 );
				half4 localSampleCoord276_g207097 = SampleCoord( Texture276_g207097 , Sampler276_g207097 , UV276_g207097 , Bias276_g207097 , Normal276_g207097 );
				TEXTURE2D(Texture502_g207097) = _MainShaderTex;
				SamplerState Sampler502_g207097 = staticSwitch38_g207098;
				half2 UV502_g207097 = (Out_MaskA456_g207097).zw;
				half Bias502_g207097 = temp_output_504_0_g207097;
				half2 Normal502_g207097 = float2( 0,0 );
				half4 localSampleCoord502_g207097 = SampleCoord( Texture502_g207097 , Sampler502_g207097 , UV502_g207097 , Bias502_g207097 , Normal502_g207097 );
				TEXTURE2D(Texture496_g207097) = _MainShaderTex;
				SamplerState Sampler496_g207097 = staticSwitch38_g207098;
				float2 temp_output_463_0_g207097 = (Out_MaskB456_g207097).zw;
				half2 XZ496_g207097 = temp_output_463_0_g207097;
				half Bias496_g207097 = temp_output_504_0_g207097;
				float3 temp_output_483_0_g207097 = (Out_MaskK456_g207097).xyz;
				half3 NormalWS496_g207097 = temp_output_483_0_g207097;
				half3 Normal496_g207097 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207097 = SamplePlanar2D( Texture496_g207097 , Sampler496_g207097 , XZ496_g207097 , Bias496_g207097 , NormalWS496_g207097 , Normal496_g207097 );
				TEXTURE2D(Texture490_g207097) = _MainShaderTex;
				SamplerState Sampler490_g207097 = staticSwitch38_g207098;
				float2 temp_output_462_0_g207097 = (Out_MaskB456_g207097).xy;
				half2 ZY490_g207097 = temp_output_462_0_g207097;
				half2 XZ490_g207097 = temp_output_463_0_g207097;
				float2 temp_output_464_0_g207097 = (Out_MaskC456_g207097).xy;
				half2 XY490_g207097 = temp_output_464_0_g207097;
				half Bias490_g207097 = temp_output_504_0_g207097;
				float3 temp_output_482_0_g207097 = (Out_MaskN456_g207097).xyz;
				half3 Triplanar490_g207097 = temp_output_482_0_g207097;
				half3 NormalWS490_g207097 = temp_output_483_0_g207097;
				half3 Normal490_g207097 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207097 = SamplePlanar3D( Texture490_g207097 , Sampler490_g207097 , ZY490_g207097 , XZ490_g207097 , XY490_g207097 , Bias490_g207097 , Triplanar490_g207097 , NormalWS490_g207097 , Normal490_g207097 );
				TEXTURE2D(Texture498_g207097) = _MainShaderTex;
				SamplerState Sampler498_g207097 = staticSwitch38_g207098;
				half2 XZ498_g207097 = temp_output_463_0_g207097;
				float2 temp_output_473_0_g207097 = (Out_MaskE456_g207097).xy;
				half2 XZ_1498_g207097 = temp_output_473_0_g207097;
				float2 temp_output_474_0_g207097 = (Out_MaskE456_g207097).zw;
				half2 XZ_2498_g207097 = temp_output_474_0_g207097;
				float2 temp_output_475_0_g207097 = (Out_MaskF456_g207097).xy;
				half2 XZ_3498_g207097 = temp_output_475_0_g207097;
				float temp_output_510_0_g207097 = exp2( temp_output_504_0_g207097 );
				half Bias498_g207097 = temp_output_510_0_g207097;
				float3 temp_output_480_0_g207097 = (Out_MaskI456_g207097).xyz;
				half3 Weights_2498_g207097 = temp_output_480_0_g207097;
				half3 NormalWS498_g207097 = temp_output_483_0_g207097;
				half3 Normal498_g207097 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207097 = SampleStochastic2D( Texture498_g207097 , Sampler498_g207097 , XZ498_g207097 , XZ_1498_g207097 , XZ_2498_g207097 , XZ_3498_g207097 , Bias498_g207097 , Weights_2498_g207097 , NormalWS498_g207097 , Normal498_g207097 );
				TEXTURE2D(Texture500_g207097) = _MainShaderTex;
				SamplerState Sampler500_g207097 = staticSwitch38_g207098;
				half2 ZY500_g207097 = temp_output_462_0_g207097;
				half2 ZY_1500_g207097 = (Out_MaskC456_g207097).zw;
				half2 ZY_2500_g207097 = (Out_MaskD456_g207097).xy;
				half2 ZY_3500_g207097 = (Out_MaskD456_g207097).zw;
				half2 XZ500_g207097 = temp_output_463_0_g207097;
				half2 XZ_1500_g207097 = temp_output_473_0_g207097;
				half2 XZ_2500_g207097 = temp_output_474_0_g207097;
				half2 XZ_3500_g207097 = temp_output_475_0_g207097;
				half2 XY500_g207097 = temp_output_464_0_g207097;
				half2 XY_1500_g207097 = (Out_MaskF456_g207097).zw;
				half2 XY_2500_g207097 = (Out_MaskG456_g207097).xy;
				half2 XY_3500_g207097 = (Out_MaskG456_g207097).zw;
				half Bias500_g207097 = temp_output_510_0_g207097;
				half3 Weights_1500_g207097 = (Out_MaskH456_g207097).xyz;
				half3 Weights_2500_g207097 = temp_output_480_0_g207097;
				half3 Weights_3500_g207097 = (Out_MaskJ456_g207097).xyz;
				half3 Triplanar500_g207097 = temp_output_482_0_g207097;
				half3 NormalWS500_g207097 = temp_output_483_0_g207097;
				half3 Normal500_g207097 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207097 = SampleStochastic3D( Texture500_g207097 , Sampler500_g207097 , ZY500_g207097 , ZY_1500_g207097 , ZY_2500_g207097 , ZY_3500_g207097 , XZ500_g207097 , XZ_1500_g207097 , XZ_2500_g207097 , XZ_3500_g207097 , XY500_g207097 , XY_1500_g207097 , XY_2500_g207097 , XY_3500_g207097 , Bias500_g207097 , Weights_1500_g207097 , Weights_2500_g207097 , Weights_3500_g207097 , Triplanar500_g207097 , NormalWS500_g207097 , Normal500_g207097 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch198_g207086 = localSampleCoord276_g207097;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch198_g207086 = localSampleCoord502_g207097;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch198_g207086 = localSamplePlanar2D496_g207097;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch198_g207086 = localSamplePlanar3D490_g207097;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch198_g207086 = localSampleStochastic2D498_g207097;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch198_g207086 = localSampleStochastic3D500_g207097;
				#else
				float4 staticSwitch198_g207086 = localSampleCoord276_g207097;
				#endif
				half4 Local_ShaderTex199_g207086 = staticSwitch198_g207086;
				float temp_output_17_0_g251298 = _MainMetallicChannelMode;
				float Option83_g251298 = temp_output_17_0_g251298;
				TEXTURE2D(Texture276_g207101) = _MainMetallicTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207102 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207102 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207101 = staticSwitch38_g207102;
				float localBreakTextureData456_g207101 = ( 0.0 );
				TVEMasksData Data456_g207101 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207101 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207101 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207101 , Out_MaskA456_g207101 , Out_MaskB456_g207101 , Out_MaskC456_g207101 , Out_MaskD456_g207101 , Out_MaskE456_g207101 , Out_MaskF456_g207101 , Out_MaskG456_g207101 , Out_MaskH456_g207101 , Out_MaskI456_g207101 , Out_MaskJ456_g207101 , Out_MaskK456_g207101 , Out_MaskL456_g207101 , Out_MaskM456_g207101 , Out_MaskN456_g207101 );
				half2 UV276_g207101 = (Out_MaskA456_g207101).xy;
				float temp_output_504_0_g207101 = 0.0;
				half Bias276_g207101 = temp_output_504_0_g207101;
				half2 Normal276_g207101 = float2( 0,0 );
				half4 localSampleCoord276_g207101 = SampleCoord( Texture276_g207101 , Sampler276_g207101 , UV276_g207101 , Bias276_g207101 , Normal276_g207101 );
				TEXTURE2D(Texture502_g207101) = _MainMetallicTex;
				SamplerState Sampler502_g207101 = staticSwitch38_g207102;
				half2 UV502_g207101 = (Out_MaskA456_g207101).zw;
				half Bias502_g207101 = temp_output_504_0_g207101;
				half2 Normal502_g207101 = float2( 0,0 );
				half4 localSampleCoord502_g207101 = SampleCoord( Texture502_g207101 , Sampler502_g207101 , UV502_g207101 , Bias502_g207101 , Normal502_g207101 );
				TEXTURE2D(Texture496_g207101) = _MainMetallicTex;
				SamplerState Sampler496_g207101 = staticSwitch38_g207102;
				float2 temp_output_463_0_g207101 = (Out_MaskB456_g207101).zw;
				half2 XZ496_g207101 = temp_output_463_0_g207101;
				half Bias496_g207101 = temp_output_504_0_g207101;
				float3 temp_output_483_0_g207101 = (Out_MaskK456_g207101).xyz;
				half3 NormalWS496_g207101 = temp_output_483_0_g207101;
				half3 Normal496_g207101 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207101 = SamplePlanar2D( Texture496_g207101 , Sampler496_g207101 , XZ496_g207101 , Bias496_g207101 , NormalWS496_g207101 , Normal496_g207101 );
				TEXTURE2D(Texture490_g207101) = _MainMetallicTex;
				SamplerState Sampler490_g207101 = staticSwitch38_g207102;
				float2 temp_output_462_0_g207101 = (Out_MaskB456_g207101).xy;
				half2 ZY490_g207101 = temp_output_462_0_g207101;
				half2 XZ490_g207101 = temp_output_463_0_g207101;
				float2 temp_output_464_0_g207101 = (Out_MaskC456_g207101).xy;
				half2 XY490_g207101 = temp_output_464_0_g207101;
				half Bias490_g207101 = temp_output_504_0_g207101;
				float3 temp_output_482_0_g207101 = (Out_MaskN456_g207101).xyz;
				half3 Triplanar490_g207101 = temp_output_482_0_g207101;
				half3 NormalWS490_g207101 = temp_output_483_0_g207101;
				half3 Normal490_g207101 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207101 = SamplePlanar3D( Texture490_g207101 , Sampler490_g207101 , ZY490_g207101 , XZ490_g207101 , XY490_g207101 , Bias490_g207101 , Triplanar490_g207101 , NormalWS490_g207101 , Normal490_g207101 );
				TEXTURE2D(Texture498_g207101) = _MainMetallicTex;
				SamplerState Sampler498_g207101 = staticSwitch38_g207102;
				half2 XZ498_g207101 = temp_output_463_0_g207101;
				float2 temp_output_473_0_g207101 = (Out_MaskE456_g207101).xy;
				half2 XZ_1498_g207101 = temp_output_473_0_g207101;
				float2 temp_output_474_0_g207101 = (Out_MaskE456_g207101).zw;
				half2 XZ_2498_g207101 = temp_output_474_0_g207101;
				float2 temp_output_475_0_g207101 = (Out_MaskF456_g207101).xy;
				half2 XZ_3498_g207101 = temp_output_475_0_g207101;
				float temp_output_510_0_g207101 = exp2( temp_output_504_0_g207101 );
				half Bias498_g207101 = temp_output_510_0_g207101;
				float3 temp_output_480_0_g207101 = (Out_MaskI456_g207101).xyz;
				half3 Weights_2498_g207101 = temp_output_480_0_g207101;
				half3 NormalWS498_g207101 = temp_output_483_0_g207101;
				half3 Normal498_g207101 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207101 = SampleStochastic2D( Texture498_g207101 , Sampler498_g207101 , XZ498_g207101 , XZ_1498_g207101 , XZ_2498_g207101 , XZ_3498_g207101 , Bias498_g207101 , Weights_2498_g207101 , NormalWS498_g207101 , Normal498_g207101 );
				TEXTURE2D(Texture500_g207101) = _MainMetallicTex;
				SamplerState Sampler500_g207101 = staticSwitch38_g207102;
				half2 ZY500_g207101 = temp_output_462_0_g207101;
				half2 ZY_1500_g207101 = (Out_MaskC456_g207101).zw;
				half2 ZY_2500_g207101 = (Out_MaskD456_g207101).xy;
				half2 ZY_3500_g207101 = (Out_MaskD456_g207101).zw;
				half2 XZ500_g207101 = temp_output_463_0_g207101;
				half2 XZ_1500_g207101 = temp_output_473_0_g207101;
				half2 XZ_2500_g207101 = temp_output_474_0_g207101;
				half2 XZ_3500_g207101 = temp_output_475_0_g207101;
				half2 XY500_g207101 = temp_output_464_0_g207101;
				half2 XY_1500_g207101 = (Out_MaskF456_g207101).zw;
				half2 XY_2500_g207101 = (Out_MaskG456_g207101).xy;
				half2 XY_3500_g207101 = (Out_MaskG456_g207101).zw;
				half Bias500_g207101 = temp_output_510_0_g207101;
				half3 Weights_1500_g207101 = (Out_MaskH456_g207101).xyz;
				half3 Weights_2500_g207101 = temp_output_480_0_g207101;
				half3 Weights_3500_g207101 = (Out_MaskJ456_g207101).xyz;
				half3 Triplanar500_g207101 = temp_output_482_0_g207101;
				half3 NormalWS500_g207101 = temp_output_483_0_g207101;
				half3 Normal500_g207101 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207101 = SampleStochastic3D( Texture500_g207101 , Sampler500_g207101 , ZY500_g207101 , ZY_1500_g207101 , ZY_2500_g207101 , ZY_3500_g207101 , XZ500_g207101 , XZ_1500_g207101 , XZ_2500_g207101 , XZ_3500_g207101 , XY500_g207101 , XY_1500_g207101 , XY_2500_g207101 , XY_3500_g207101 , Bias500_g207101 , Weights_1500_g207101 , Weights_2500_g207101 , Weights_3500_g207101 , Triplanar500_g207101 , NormalWS500_g207101 , Normal500_g207101 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch335_g207086 = localSampleCoord276_g207101;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch335_g207086 = localSampleCoord502_g207101;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch335_g207086 = localSamplePlanar2D496_g207101;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch335_g207086 = localSamplePlanar3D490_g207101;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch335_g207086 = localSampleStochastic2D498_g207101;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch335_g207086 = localSampleStochastic3D500_g207101;
				#else
				float4 staticSwitch335_g207086 = localSampleCoord276_g207101;
				#endif
				half4 Local_MetallicTex341_g207086 = staticSwitch335_g207086;
				float4 ChannelA83_g251298 = Local_MetallicTex341_g207086;
				float4 ChannelB83_g251298 = ( 1.0 - Local_MetallicTex341_g207086 );
				float localSwitchChannel883_g251298 = SwitchChannel8( Option83_g251298 , ChannelA83_g251298 , ChannelB83_g251298 );
				float lerpResult366_g207086 = lerp( (Local_ShaderTex199_g207086).x , localSwitchChannel883_g251298 , _MainMetallicSourceMode);
				half Local_Metallic322_g207086 = ( lerpResult366_g207086 * _MainMetallicValue );
				float temp_output_17_0_g251299 = _MainOcclusionChannelMode;
				float Option83_g251299 = temp_output_17_0_g251299;
				TEXTURE2D(Texture276_g207103) = _MainOcclusionTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207108 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207108 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207103 = staticSwitch38_g207108;
				float localBreakTextureData456_g207103 = ( 0.0 );
				TVEMasksData Data456_g207103 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207103 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207103 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207103 , Out_MaskA456_g207103 , Out_MaskB456_g207103 , Out_MaskC456_g207103 , Out_MaskD456_g207103 , Out_MaskE456_g207103 , Out_MaskF456_g207103 , Out_MaskG456_g207103 , Out_MaskH456_g207103 , Out_MaskI456_g207103 , Out_MaskJ456_g207103 , Out_MaskK456_g207103 , Out_MaskL456_g207103 , Out_MaskM456_g207103 , Out_MaskN456_g207103 );
				half2 UV276_g207103 = (Out_MaskA456_g207103).xy;
				float temp_output_504_0_g207103 = 0.0;
				half Bias276_g207103 = temp_output_504_0_g207103;
				half2 Normal276_g207103 = float2( 0,0 );
				half4 localSampleCoord276_g207103 = SampleCoord( Texture276_g207103 , Sampler276_g207103 , UV276_g207103 , Bias276_g207103 , Normal276_g207103 );
				TEXTURE2D(Texture502_g207103) = _MainOcclusionTex;
				SamplerState Sampler502_g207103 = staticSwitch38_g207108;
				half2 UV502_g207103 = (Out_MaskA456_g207103).zw;
				half Bias502_g207103 = temp_output_504_0_g207103;
				half2 Normal502_g207103 = float2( 0,0 );
				half4 localSampleCoord502_g207103 = SampleCoord( Texture502_g207103 , Sampler502_g207103 , UV502_g207103 , Bias502_g207103 , Normal502_g207103 );
				TEXTURE2D(Texture496_g207103) = _MainOcclusionTex;
				SamplerState Sampler496_g207103 = staticSwitch38_g207108;
				float2 temp_output_463_0_g207103 = (Out_MaskB456_g207103).zw;
				half2 XZ496_g207103 = temp_output_463_0_g207103;
				half Bias496_g207103 = temp_output_504_0_g207103;
				float3 temp_output_483_0_g207103 = (Out_MaskK456_g207103).xyz;
				half3 NormalWS496_g207103 = temp_output_483_0_g207103;
				half3 Normal496_g207103 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207103 = SamplePlanar2D( Texture496_g207103 , Sampler496_g207103 , XZ496_g207103 , Bias496_g207103 , NormalWS496_g207103 , Normal496_g207103 );
				TEXTURE2D(Texture490_g207103) = _MainOcclusionTex;
				SamplerState Sampler490_g207103 = staticSwitch38_g207108;
				float2 temp_output_462_0_g207103 = (Out_MaskB456_g207103).xy;
				half2 ZY490_g207103 = temp_output_462_0_g207103;
				half2 XZ490_g207103 = temp_output_463_0_g207103;
				float2 temp_output_464_0_g207103 = (Out_MaskC456_g207103).xy;
				half2 XY490_g207103 = temp_output_464_0_g207103;
				half Bias490_g207103 = temp_output_504_0_g207103;
				float3 temp_output_482_0_g207103 = (Out_MaskN456_g207103).xyz;
				half3 Triplanar490_g207103 = temp_output_482_0_g207103;
				half3 NormalWS490_g207103 = temp_output_483_0_g207103;
				half3 Normal490_g207103 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207103 = SamplePlanar3D( Texture490_g207103 , Sampler490_g207103 , ZY490_g207103 , XZ490_g207103 , XY490_g207103 , Bias490_g207103 , Triplanar490_g207103 , NormalWS490_g207103 , Normal490_g207103 );
				TEXTURE2D(Texture498_g207103) = _MainOcclusionTex;
				SamplerState Sampler498_g207103 = staticSwitch38_g207108;
				half2 XZ498_g207103 = temp_output_463_0_g207103;
				float2 temp_output_473_0_g207103 = (Out_MaskE456_g207103).xy;
				half2 XZ_1498_g207103 = temp_output_473_0_g207103;
				float2 temp_output_474_0_g207103 = (Out_MaskE456_g207103).zw;
				half2 XZ_2498_g207103 = temp_output_474_0_g207103;
				float2 temp_output_475_0_g207103 = (Out_MaskF456_g207103).xy;
				half2 XZ_3498_g207103 = temp_output_475_0_g207103;
				float temp_output_510_0_g207103 = exp2( temp_output_504_0_g207103 );
				half Bias498_g207103 = temp_output_510_0_g207103;
				float3 temp_output_480_0_g207103 = (Out_MaskI456_g207103).xyz;
				half3 Weights_2498_g207103 = temp_output_480_0_g207103;
				half3 NormalWS498_g207103 = temp_output_483_0_g207103;
				half3 Normal498_g207103 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207103 = SampleStochastic2D( Texture498_g207103 , Sampler498_g207103 , XZ498_g207103 , XZ_1498_g207103 , XZ_2498_g207103 , XZ_3498_g207103 , Bias498_g207103 , Weights_2498_g207103 , NormalWS498_g207103 , Normal498_g207103 );
				TEXTURE2D(Texture500_g207103) = _MainOcclusionTex;
				SamplerState Sampler500_g207103 = staticSwitch38_g207108;
				half2 ZY500_g207103 = temp_output_462_0_g207103;
				half2 ZY_1500_g207103 = (Out_MaskC456_g207103).zw;
				half2 ZY_2500_g207103 = (Out_MaskD456_g207103).xy;
				half2 ZY_3500_g207103 = (Out_MaskD456_g207103).zw;
				half2 XZ500_g207103 = temp_output_463_0_g207103;
				half2 XZ_1500_g207103 = temp_output_473_0_g207103;
				half2 XZ_2500_g207103 = temp_output_474_0_g207103;
				half2 XZ_3500_g207103 = temp_output_475_0_g207103;
				half2 XY500_g207103 = temp_output_464_0_g207103;
				half2 XY_1500_g207103 = (Out_MaskF456_g207103).zw;
				half2 XY_2500_g207103 = (Out_MaskG456_g207103).xy;
				half2 XY_3500_g207103 = (Out_MaskG456_g207103).zw;
				half Bias500_g207103 = temp_output_510_0_g207103;
				half3 Weights_1500_g207103 = (Out_MaskH456_g207103).xyz;
				half3 Weights_2500_g207103 = temp_output_480_0_g207103;
				half3 Weights_3500_g207103 = (Out_MaskJ456_g207103).xyz;
				half3 Triplanar500_g207103 = temp_output_482_0_g207103;
				half3 NormalWS500_g207103 = temp_output_483_0_g207103;
				half3 Normal500_g207103 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207103 = SampleStochastic3D( Texture500_g207103 , Sampler500_g207103 , ZY500_g207103 , ZY_1500_g207103 , ZY_2500_g207103 , ZY_3500_g207103 , XZ500_g207103 , XZ_1500_g207103 , XZ_2500_g207103 , XZ_3500_g207103 , XY500_g207103 , XY_1500_g207103 , XY_2500_g207103 , XY_3500_g207103 , Bias500_g207103 , Weights_1500_g207103 , Weights_2500_g207103 , Weights_3500_g207103 , Triplanar500_g207103 , NormalWS500_g207103 , Normal500_g207103 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch343_g207086 = localSampleCoord276_g207103;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch343_g207086 = localSampleCoord502_g207103;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch343_g207086 = localSamplePlanar2D496_g207103;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch343_g207086 = localSamplePlanar3D490_g207103;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch343_g207086 = localSampleStochastic2D498_g207103;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch343_g207086 = localSampleStochastic3D500_g207103;
				#else
				float4 staticSwitch343_g207086 = localSampleCoord276_g207103;
				#endif
				half4 Local_OcclusionTex349_g207086 = staticSwitch343_g207086;
				float4 ChannelA83_g251299 = Local_OcclusionTex349_g207086;
				float4 ChannelB83_g251299 = ( 1.0 - Local_OcclusionTex349_g207086 );
				float localSwitchChannel883_g251299 = SwitchChannel8( Option83_g251299 , ChannelA83_g251299 , ChannelB83_g251299 );
				float lerpResult373_g207086 = lerp( (Local_ShaderTex199_g207086).y , localSwitchChannel883_g251299 , _MainOcclusionSourceMode);
				float clampResult17_g251301 = clamp( lerpResult373_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251300 = _MainOcclusionRemap.x;
				float temp_output_9_0_g251300 = ( clampResult17_g251301 - temp_output_7_0_g251300 );
				float lerpResult23_g207086 = lerp( 1.0 , saturate( ( temp_output_9_0_g251300 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
				half Local_Occlusion313_g207086 = lerpResult23_g207086;
				float temp_output_17_0_g251307 = _MainSmoothnessChannelMode;
				float Option83_g251307 = temp_output_17_0_g251307;
				TEXTURE2D(Texture276_g207106) = _MainSmoothnessTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207107 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207107 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207106 = staticSwitch38_g207107;
				float localBreakTextureData456_g207106 = ( 0.0 );
				TVEMasksData Data456_g207106 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207106 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207106 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207106 , Out_MaskA456_g207106 , Out_MaskB456_g207106 , Out_MaskC456_g207106 , Out_MaskD456_g207106 , Out_MaskE456_g207106 , Out_MaskF456_g207106 , Out_MaskG456_g207106 , Out_MaskH456_g207106 , Out_MaskI456_g207106 , Out_MaskJ456_g207106 , Out_MaskK456_g207106 , Out_MaskL456_g207106 , Out_MaskM456_g207106 , Out_MaskN456_g207106 );
				half2 UV276_g207106 = (Out_MaskA456_g207106).xy;
				float temp_output_504_0_g207106 = 0.0;
				half Bias276_g207106 = temp_output_504_0_g207106;
				half2 Normal276_g207106 = float2( 0,0 );
				half4 localSampleCoord276_g207106 = SampleCoord( Texture276_g207106 , Sampler276_g207106 , UV276_g207106 , Bias276_g207106 , Normal276_g207106 );
				TEXTURE2D(Texture502_g207106) = _MainSmoothnessTex;
				SamplerState Sampler502_g207106 = staticSwitch38_g207107;
				half2 UV502_g207106 = (Out_MaskA456_g207106).zw;
				half Bias502_g207106 = temp_output_504_0_g207106;
				half2 Normal502_g207106 = float2( 0,0 );
				half4 localSampleCoord502_g207106 = SampleCoord( Texture502_g207106 , Sampler502_g207106 , UV502_g207106 , Bias502_g207106 , Normal502_g207106 );
				TEXTURE2D(Texture496_g207106) = _MainSmoothnessTex;
				SamplerState Sampler496_g207106 = staticSwitch38_g207107;
				float2 temp_output_463_0_g207106 = (Out_MaskB456_g207106).zw;
				half2 XZ496_g207106 = temp_output_463_0_g207106;
				half Bias496_g207106 = temp_output_504_0_g207106;
				float3 temp_output_483_0_g207106 = (Out_MaskK456_g207106).xyz;
				half3 NormalWS496_g207106 = temp_output_483_0_g207106;
				half3 Normal496_g207106 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207106 = SamplePlanar2D( Texture496_g207106 , Sampler496_g207106 , XZ496_g207106 , Bias496_g207106 , NormalWS496_g207106 , Normal496_g207106 );
				TEXTURE2D(Texture490_g207106) = _MainSmoothnessTex;
				SamplerState Sampler490_g207106 = staticSwitch38_g207107;
				float2 temp_output_462_0_g207106 = (Out_MaskB456_g207106).xy;
				half2 ZY490_g207106 = temp_output_462_0_g207106;
				half2 XZ490_g207106 = temp_output_463_0_g207106;
				float2 temp_output_464_0_g207106 = (Out_MaskC456_g207106).xy;
				half2 XY490_g207106 = temp_output_464_0_g207106;
				half Bias490_g207106 = temp_output_504_0_g207106;
				float3 temp_output_482_0_g207106 = (Out_MaskN456_g207106).xyz;
				half3 Triplanar490_g207106 = temp_output_482_0_g207106;
				half3 NormalWS490_g207106 = temp_output_483_0_g207106;
				half3 Normal490_g207106 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207106 = SamplePlanar3D( Texture490_g207106 , Sampler490_g207106 , ZY490_g207106 , XZ490_g207106 , XY490_g207106 , Bias490_g207106 , Triplanar490_g207106 , NormalWS490_g207106 , Normal490_g207106 );
				TEXTURE2D(Texture498_g207106) = _MainSmoothnessTex;
				SamplerState Sampler498_g207106 = staticSwitch38_g207107;
				half2 XZ498_g207106 = temp_output_463_0_g207106;
				float2 temp_output_473_0_g207106 = (Out_MaskE456_g207106).xy;
				half2 XZ_1498_g207106 = temp_output_473_0_g207106;
				float2 temp_output_474_0_g207106 = (Out_MaskE456_g207106).zw;
				half2 XZ_2498_g207106 = temp_output_474_0_g207106;
				float2 temp_output_475_0_g207106 = (Out_MaskF456_g207106).xy;
				half2 XZ_3498_g207106 = temp_output_475_0_g207106;
				float temp_output_510_0_g207106 = exp2( temp_output_504_0_g207106 );
				half Bias498_g207106 = temp_output_510_0_g207106;
				float3 temp_output_480_0_g207106 = (Out_MaskI456_g207106).xyz;
				half3 Weights_2498_g207106 = temp_output_480_0_g207106;
				half3 NormalWS498_g207106 = temp_output_483_0_g207106;
				half3 Normal498_g207106 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207106 = SampleStochastic2D( Texture498_g207106 , Sampler498_g207106 , XZ498_g207106 , XZ_1498_g207106 , XZ_2498_g207106 , XZ_3498_g207106 , Bias498_g207106 , Weights_2498_g207106 , NormalWS498_g207106 , Normal498_g207106 );
				TEXTURE2D(Texture500_g207106) = _MainSmoothnessTex;
				SamplerState Sampler500_g207106 = staticSwitch38_g207107;
				half2 ZY500_g207106 = temp_output_462_0_g207106;
				half2 ZY_1500_g207106 = (Out_MaskC456_g207106).zw;
				half2 ZY_2500_g207106 = (Out_MaskD456_g207106).xy;
				half2 ZY_3500_g207106 = (Out_MaskD456_g207106).zw;
				half2 XZ500_g207106 = temp_output_463_0_g207106;
				half2 XZ_1500_g207106 = temp_output_473_0_g207106;
				half2 XZ_2500_g207106 = temp_output_474_0_g207106;
				half2 XZ_3500_g207106 = temp_output_475_0_g207106;
				half2 XY500_g207106 = temp_output_464_0_g207106;
				half2 XY_1500_g207106 = (Out_MaskF456_g207106).zw;
				half2 XY_2500_g207106 = (Out_MaskG456_g207106).xy;
				half2 XY_3500_g207106 = (Out_MaskG456_g207106).zw;
				half Bias500_g207106 = temp_output_510_0_g207106;
				half3 Weights_1500_g207106 = (Out_MaskH456_g207106).xyz;
				half3 Weights_2500_g207106 = temp_output_480_0_g207106;
				half3 Weights_3500_g207106 = (Out_MaskJ456_g207106).xyz;
				half3 Triplanar500_g207106 = temp_output_482_0_g207106;
				half3 NormalWS500_g207106 = temp_output_483_0_g207106;
				half3 Normal500_g207106 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207106 = SampleStochastic3D( Texture500_g207106 , Sampler500_g207106 , ZY500_g207106 , ZY_1500_g207106 , ZY_2500_g207106 , ZY_3500_g207106 , XZ500_g207106 , XZ_1500_g207106 , XZ_2500_g207106 , XZ_3500_g207106 , XY500_g207106 , XY_1500_g207106 , XY_2500_g207106 , XY_3500_g207106 , Bias500_g207106 , Weights_1500_g207106 , Weights_2500_g207106 , Weights_3500_g207106 , Triplanar500_g207106 , NormalWS500_g207106 , Normal500_g207106 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch359_g207086 = localSampleCoord276_g207106;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch359_g207086 = localSampleCoord502_g207106;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch359_g207086 = localSamplePlanar2D496_g207106;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch359_g207086 = localSamplePlanar3D490_g207106;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch359_g207086 = localSampleStochastic2D498_g207106;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch359_g207086 = localSampleStochastic3D500_g207106;
				#else
				float4 staticSwitch359_g207086 = localSampleCoord276_g207106;
				#endif
				half4 Local_SmoothnessTex365_g207086 = staticSwitch359_g207086;
				float4 temp_output_28_0_g251309 = Local_SmoothnessTex365_g207086;
				float3 temp_output_29_0_g251309 = (temp_output_28_0_g251309).xyz;
				half3 linRGB27_g251309 = temp_output_29_0_g251309;
				half3 localLinearToGammaFloatFast27_g251309 = LinearToGammaFloatFast( linRGB27_g251309 );
				#ifdef UNITY_COLORSPACE_GAMMA
				float3 staticSwitch26_g251309 = temp_output_29_0_g251309;
				#else
				float3 staticSwitch26_g251309 = localLinearToGammaFloatFast27_g251309;
				#endif
				float4 appendResult31_g251309 = (float4(staticSwitch26_g251309 , (temp_output_28_0_g251309).w));
				float4 lerpResult439_g207086 = lerp( Local_SmoothnessTex365_g207086 , appendResult31_g251309 , _MainSmoothnessTexGammaMode);
				float4 ChannelA83_g251307 = lerpResult439_g207086;
				float4 ChannelB83_g251307 = ( 1.0 - lerpResult439_g207086 );
				float localSwitchChannel883_g251307 = SwitchChannel8( Option83_g251307 , ChannelA83_g251307 , ChannelB83_g251307 );
				float lerpResult374_g207086 = lerp( (Local_ShaderTex199_g207086).w , localSwitchChannel883_g251307 , _MainSmoothnessSourceMode);
				float clampResult17_g251306 = clamp( lerpResult374_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251305 = _MainSmoothnessRemap.x;
				float temp_output_9_0_g251305 = ( clampResult17_g251306 - temp_output_7_0_g251305 );
				half Local_Smoothness317_g207086 = ( saturate( ( temp_output_9_0_g251305 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
				float4 appendResult73_g207086 = (float4(Local_Metallic322_g207086 , Local_Occlusion313_g207086 , 0.0 , Local_Smoothness317_g207086));
				half4 Local_Masks109_g207086 = appendResult73_g207086;
				float temp_output_17_0_g251304 = _MainMultiChannelMode;
				float Option83_g251304 = temp_output_17_0_g251304;
				TEXTURE2D(Texture276_g207104) = _MainMultiTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g207105 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g207105 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207104 = staticSwitch38_g207105;
				float localBreakTextureData456_g207104 = ( 0.0 );
				TVEMasksData Data456_g207104 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207104 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207104 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207104 , Out_MaskA456_g207104 , Out_MaskB456_g207104 , Out_MaskC456_g207104 , Out_MaskD456_g207104 , Out_MaskE456_g207104 , Out_MaskF456_g207104 , Out_MaskG456_g207104 , Out_MaskH456_g207104 , Out_MaskI456_g207104 , Out_MaskJ456_g207104 , Out_MaskK456_g207104 , Out_MaskL456_g207104 , Out_MaskM456_g207104 , Out_MaskN456_g207104 );
				half2 UV276_g207104 = (Out_MaskA456_g207104).xy;
				float temp_output_504_0_g207104 = 0.0;
				half Bias276_g207104 = temp_output_504_0_g207104;
				half2 Normal276_g207104 = float2( 0,0 );
				half4 localSampleCoord276_g207104 = SampleCoord( Texture276_g207104 , Sampler276_g207104 , UV276_g207104 , Bias276_g207104 , Normal276_g207104 );
				TEXTURE2D(Texture502_g207104) = _MainMultiTex;
				SamplerState Sampler502_g207104 = staticSwitch38_g207105;
				half2 UV502_g207104 = (Out_MaskA456_g207104).zw;
				half Bias502_g207104 = temp_output_504_0_g207104;
				half2 Normal502_g207104 = float2( 0,0 );
				half4 localSampleCoord502_g207104 = SampleCoord( Texture502_g207104 , Sampler502_g207104 , UV502_g207104 , Bias502_g207104 , Normal502_g207104 );
				TEXTURE2D(Texture496_g207104) = _MainMultiTex;
				SamplerState Sampler496_g207104 = staticSwitch38_g207105;
				float2 temp_output_463_0_g207104 = (Out_MaskB456_g207104).zw;
				half2 XZ496_g207104 = temp_output_463_0_g207104;
				half Bias496_g207104 = temp_output_504_0_g207104;
				float3 temp_output_483_0_g207104 = (Out_MaskK456_g207104).xyz;
				half3 NormalWS496_g207104 = temp_output_483_0_g207104;
				half3 Normal496_g207104 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207104 = SamplePlanar2D( Texture496_g207104 , Sampler496_g207104 , XZ496_g207104 , Bias496_g207104 , NormalWS496_g207104 , Normal496_g207104 );
				TEXTURE2D(Texture490_g207104) = _MainMultiTex;
				SamplerState Sampler490_g207104 = staticSwitch38_g207105;
				float2 temp_output_462_0_g207104 = (Out_MaskB456_g207104).xy;
				half2 ZY490_g207104 = temp_output_462_0_g207104;
				half2 XZ490_g207104 = temp_output_463_0_g207104;
				float2 temp_output_464_0_g207104 = (Out_MaskC456_g207104).xy;
				half2 XY490_g207104 = temp_output_464_0_g207104;
				half Bias490_g207104 = temp_output_504_0_g207104;
				float3 temp_output_482_0_g207104 = (Out_MaskN456_g207104).xyz;
				half3 Triplanar490_g207104 = temp_output_482_0_g207104;
				half3 NormalWS490_g207104 = temp_output_483_0_g207104;
				half3 Normal490_g207104 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207104 = SamplePlanar3D( Texture490_g207104 , Sampler490_g207104 , ZY490_g207104 , XZ490_g207104 , XY490_g207104 , Bias490_g207104 , Triplanar490_g207104 , NormalWS490_g207104 , Normal490_g207104 );
				TEXTURE2D(Texture498_g207104) = _MainMultiTex;
				SamplerState Sampler498_g207104 = staticSwitch38_g207105;
				half2 XZ498_g207104 = temp_output_463_0_g207104;
				float2 temp_output_473_0_g207104 = (Out_MaskE456_g207104).xy;
				half2 XZ_1498_g207104 = temp_output_473_0_g207104;
				float2 temp_output_474_0_g207104 = (Out_MaskE456_g207104).zw;
				half2 XZ_2498_g207104 = temp_output_474_0_g207104;
				float2 temp_output_475_0_g207104 = (Out_MaskF456_g207104).xy;
				half2 XZ_3498_g207104 = temp_output_475_0_g207104;
				float temp_output_510_0_g207104 = exp2( temp_output_504_0_g207104 );
				half Bias498_g207104 = temp_output_510_0_g207104;
				float3 temp_output_480_0_g207104 = (Out_MaskI456_g207104).xyz;
				half3 Weights_2498_g207104 = temp_output_480_0_g207104;
				half3 NormalWS498_g207104 = temp_output_483_0_g207104;
				half3 Normal498_g207104 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207104 = SampleStochastic2D( Texture498_g207104 , Sampler498_g207104 , XZ498_g207104 , XZ_1498_g207104 , XZ_2498_g207104 , XZ_3498_g207104 , Bias498_g207104 , Weights_2498_g207104 , NormalWS498_g207104 , Normal498_g207104 );
				TEXTURE2D(Texture500_g207104) = _MainMultiTex;
				SamplerState Sampler500_g207104 = staticSwitch38_g207105;
				half2 ZY500_g207104 = temp_output_462_0_g207104;
				half2 ZY_1500_g207104 = (Out_MaskC456_g207104).zw;
				half2 ZY_2500_g207104 = (Out_MaskD456_g207104).xy;
				half2 ZY_3500_g207104 = (Out_MaskD456_g207104).zw;
				half2 XZ500_g207104 = temp_output_463_0_g207104;
				half2 XZ_1500_g207104 = temp_output_473_0_g207104;
				half2 XZ_2500_g207104 = temp_output_474_0_g207104;
				half2 XZ_3500_g207104 = temp_output_475_0_g207104;
				half2 XY500_g207104 = temp_output_464_0_g207104;
				half2 XY_1500_g207104 = (Out_MaskF456_g207104).zw;
				half2 XY_2500_g207104 = (Out_MaskG456_g207104).xy;
				half2 XY_3500_g207104 = (Out_MaskG456_g207104).zw;
				half Bias500_g207104 = temp_output_510_0_g207104;
				half3 Weights_1500_g207104 = (Out_MaskH456_g207104).xyz;
				half3 Weights_2500_g207104 = temp_output_480_0_g207104;
				half3 Weights_3500_g207104 = (Out_MaskJ456_g207104).xyz;
				half3 Triplanar500_g207104 = temp_output_482_0_g207104;
				half3 NormalWS500_g207104 = temp_output_483_0_g207104;
				half3 Normal500_g207104 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207104 = SampleStochastic3D( Texture500_g207104 , Sampler500_g207104 , ZY500_g207104 , ZY_1500_g207104 , ZY_2500_g207104 , ZY_3500_g207104 , XZ500_g207104 , XZ_1500_g207104 , XZ_2500_g207104 , XZ_3500_g207104 , XY500_g207104 , XY_1500_g207104 , XY_2500_g207104 , XY_3500_g207104 , Bias500_g207104 , Weights_1500_g207104 , Weights_2500_g207104 , Weights_3500_g207104 , Triplanar500_g207104 , NormalWS500_g207104 , Normal500_g207104 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch351_g207086 = localSampleCoord276_g207104;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch351_g207086 = localSampleCoord502_g207104;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch351_g207086 = localSamplePlanar2D496_g207104;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch351_g207086 = localSamplePlanar3D490_g207104;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch351_g207086 = localSampleStochastic2D498_g207104;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch351_g207086 = localSampleStochastic3D500_g207104;
				#else
				float4 staticSwitch351_g207086 = localSampleCoord276_g207104;
				#endif
				half4 Local_MultiTex357_g207086 = staticSwitch351_g207086;
				float4 ChannelA83_g251304 = Local_MultiTex357_g207086;
				float4 ChannelB83_g251304 = ( 1.0 - Local_MultiTex357_g207086 );
				float localSwitchChannel883_g251304 = SwitchChannel8( Option83_g251304 , ChannelA83_g251304 , ChannelB83_g251304 );
				float lerpResult378_g207086 = lerp( (Local_Masks109_g207086).z , localSwitchChannel883_g251304 , _MainMultiSourceMode);
				float clampResult17_g251302 = clamp( lerpResult378_g207086 , 0.0001 , 0.9999 );
				float temp_output_7_0_g251303 = _MainMultiRemap.x;
				float temp_output_9_0_g251303 = ( clampResult17_g251302 - temp_output_7_0_g251303 );
				half Local_MultiMask78_g207086 = ( saturate( ( temp_output_9_0_g251303 * _MainMultiRemap.z ) ) * _MainMultiVlaue );
				float lerpResult58_g207086 = lerp( 1.0 , Local_MultiMask78_g207086 , _MainColorMode);
				float4 lerpResult62_g207086 = lerp( _MainColorTwo , _MainColor , lerpResult58_g207086);
				half3 Local_ColorRGB93_g207086 = (lerpResult62_g207086).rgb;
				half3 Local_Albedo139_g207086 = ( Local_AlbedoRGB107_g207086 * Local_ColorRGB93_g207086 );
				float3 temp_output_4_0_g207088 = Local_Albedo139_g207086;
				float3 In_Albedo3_g207088 = temp_output_4_0_g207088;
				float3 temp_output_44_0_g207088 = Local_Albedo139_g207086;
				float3 In_AlbedoBase3_g207088 = temp_output_44_0_g207088;
				TEXTURE2D(Texture276_g207094) = _MainNormalTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch37_g207095 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch37_g207095 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g207094 = staticSwitch37_g207095;
				float localBreakTextureData456_g207094 = ( 0.0 );
				TVEMasksData Data456_g207094 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207094 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207094 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207094 , Out_MaskA456_g207094 , Out_MaskB456_g207094 , Out_MaskC456_g207094 , Out_MaskD456_g207094 , Out_MaskE456_g207094 , Out_MaskF456_g207094 , Out_MaskG456_g207094 , Out_MaskH456_g207094 , Out_MaskI456_g207094 , Out_MaskJ456_g207094 , Out_MaskK456_g207094 , Out_MaskL456_g207094 , Out_MaskM456_g207094 , Out_MaskN456_g207094 );
				half2 UV276_g207094 = (Out_MaskA456_g207094).xy;
				float temp_output_504_0_g207094 = 0.0;
				half Bias276_g207094 = temp_output_504_0_g207094;
				half2 Normal276_g207094 = float2( 0,0 );
				half4 localSampleCoord276_g207094 = SampleCoord( Texture276_g207094 , Sampler276_g207094 , UV276_g207094 , Bias276_g207094 , Normal276_g207094 );
				TEXTURE2D(Texture502_g207094) = _MainNormalTex;
				SamplerState Sampler502_g207094 = staticSwitch37_g207095;
				half2 UV502_g207094 = (Out_MaskA456_g207094).zw;
				half Bias502_g207094 = temp_output_504_0_g207094;
				half2 Normal502_g207094 = float2( 0,0 );
				half4 localSampleCoord502_g207094 = SampleCoord( Texture502_g207094 , Sampler502_g207094 , UV502_g207094 , Bias502_g207094 , Normal502_g207094 );
				TEXTURE2D(Texture496_g207094) = _MainNormalTex;
				SamplerState Sampler496_g207094 = staticSwitch37_g207095;
				float2 temp_output_463_0_g207094 = (Out_MaskB456_g207094).zw;
				half2 XZ496_g207094 = temp_output_463_0_g207094;
				half Bias496_g207094 = temp_output_504_0_g207094;
				float3 temp_output_483_0_g207094 = (Out_MaskK456_g207094).xyz;
				half3 NormalWS496_g207094 = temp_output_483_0_g207094;
				half3 Normal496_g207094 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207094 = SamplePlanar2D( Texture496_g207094 , Sampler496_g207094 , XZ496_g207094 , Bias496_g207094 , NormalWS496_g207094 , Normal496_g207094 );
				TEXTURE2D(Texture490_g207094) = _MainNormalTex;
				SamplerState Sampler490_g207094 = staticSwitch37_g207095;
				float2 temp_output_462_0_g207094 = (Out_MaskB456_g207094).xy;
				half2 ZY490_g207094 = temp_output_462_0_g207094;
				half2 XZ490_g207094 = temp_output_463_0_g207094;
				float2 temp_output_464_0_g207094 = (Out_MaskC456_g207094).xy;
				half2 XY490_g207094 = temp_output_464_0_g207094;
				half Bias490_g207094 = temp_output_504_0_g207094;
				float3 temp_output_482_0_g207094 = (Out_MaskN456_g207094).xyz;
				half3 Triplanar490_g207094 = temp_output_482_0_g207094;
				half3 NormalWS490_g207094 = temp_output_483_0_g207094;
				half3 Normal490_g207094 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207094 = SamplePlanar3D( Texture490_g207094 , Sampler490_g207094 , ZY490_g207094 , XZ490_g207094 , XY490_g207094 , Bias490_g207094 , Triplanar490_g207094 , NormalWS490_g207094 , Normal490_g207094 );
				TEXTURE2D(Texture498_g207094) = _MainNormalTex;
				SamplerState Sampler498_g207094 = staticSwitch37_g207095;
				half2 XZ498_g207094 = temp_output_463_0_g207094;
				float2 temp_output_473_0_g207094 = (Out_MaskE456_g207094).xy;
				half2 XZ_1498_g207094 = temp_output_473_0_g207094;
				float2 temp_output_474_0_g207094 = (Out_MaskE456_g207094).zw;
				half2 XZ_2498_g207094 = temp_output_474_0_g207094;
				float2 temp_output_475_0_g207094 = (Out_MaskF456_g207094).xy;
				half2 XZ_3498_g207094 = temp_output_475_0_g207094;
				float temp_output_510_0_g207094 = exp2( temp_output_504_0_g207094 );
				half Bias498_g207094 = temp_output_510_0_g207094;
				float3 temp_output_480_0_g207094 = (Out_MaskI456_g207094).xyz;
				half3 Weights_2498_g207094 = temp_output_480_0_g207094;
				half3 NormalWS498_g207094 = temp_output_483_0_g207094;
				half3 Normal498_g207094 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207094 = SampleStochastic2D( Texture498_g207094 , Sampler498_g207094 , XZ498_g207094 , XZ_1498_g207094 , XZ_2498_g207094 , XZ_3498_g207094 , Bias498_g207094 , Weights_2498_g207094 , NormalWS498_g207094 , Normal498_g207094 );
				TEXTURE2D(Texture500_g207094) = _MainNormalTex;
				SamplerState Sampler500_g207094 = staticSwitch37_g207095;
				half2 ZY500_g207094 = temp_output_462_0_g207094;
				half2 ZY_1500_g207094 = (Out_MaskC456_g207094).zw;
				half2 ZY_2500_g207094 = (Out_MaskD456_g207094).xy;
				half2 ZY_3500_g207094 = (Out_MaskD456_g207094).zw;
				half2 XZ500_g207094 = temp_output_463_0_g207094;
				half2 XZ_1500_g207094 = temp_output_473_0_g207094;
				half2 XZ_2500_g207094 = temp_output_474_0_g207094;
				half2 XZ_3500_g207094 = temp_output_475_0_g207094;
				half2 XY500_g207094 = temp_output_464_0_g207094;
				half2 XY_1500_g207094 = (Out_MaskF456_g207094).zw;
				half2 XY_2500_g207094 = (Out_MaskG456_g207094).xy;
				half2 XY_3500_g207094 = (Out_MaskG456_g207094).zw;
				half Bias500_g207094 = temp_output_510_0_g207094;
				half3 Weights_1500_g207094 = (Out_MaskH456_g207094).xyz;
				half3 Weights_2500_g207094 = temp_output_480_0_g207094;
				half3 Weights_3500_g207094 = (Out_MaskJ456_g207094).xyz;
				half3 Triplanar500_g207094 = temp_output_482_0_g207094;
				half3 NormalWS500_g207094 = temp_output_483_0_g207094;
				half3 Normal500_g207094 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207094 = SampleStochastic3D( Texture500_g207094 , Sampler500_g207094 , ZY500_g207094 , ZY_1500_g207094 , ZY_2500_g207094 , ZY_3500_g207094 , XZ500_g207094 , XZ_1500_g207094 , XZ_2500_g207094 , XZ_3500_g207094 , XY500_g207094 , XY_1500_g207094 , XY_2500_g207094 , XY_3500_g207094 , Bias500_g207094 , Weights_1500_g207094 , Weights_2500_g207094 , Weights_3500_g207094 , Triplanar500_g207094 , NormalWS500_g207094 , Normal500_g207094 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch193_g207086 = localSampleCoord276_g207094;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch193_g207086 = localSampleCoord502_g207094;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch193_g207086 = localSamplePlanar2D496_g207094;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch193_g207086 = localSamplePlanar3D490_g207094;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch193_g207086 = localSampleStochastic2D498_g207094;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch193_g207086 = localSampleStochastic3D500_g207094;
				#else
				float4 staticSwitch193_g207086 = localSampleCoord276_g207094;
				#endif
				half4 Local_NormaTex191_g207086 = staticSwitch193_g207086;
				half4 Normal_Packed45_g207089 = Local_NormaTex191_g207086;
				float2 appendResult58_g207089 = (float2(( (Normal_Packed45_g207089).x * (Normal_Packed45_g207089).w ) , (Normal_Packed45_g207089).y));
				half2 Normal_Default50_g207089 = appendResult58_g207089;
				half2 Normal_ASTC41_g207089 = (Normal_Packed45_g207089).xy;
				#ifdef UNITY_ASTC_NORMALMAP_ENCODING
				float2 staticSwitch38_g207089 = Normal_ASTC41_g207089;
				#else
				float2 staticSwitch38_g207089 = Normal_Default50_g207089;
				#endif
				half2 Normal_NO_DTX544_g207089 = (Normal_Packed45_g207089).wy;
				#ifdef UNITY_NO_DXT5nm
				float2 staticSwitch37_g207089 = Normal_NO_DTX544_g207089;
				#else
				float2 staticSwitch37_g207089 = staticSwitch38_g207089;
				#endif
				float2 temp_output_26_0_g207086 = ( (staticSwitch37_g207089*2.0 + -1.0) * _MainNormalValue );
				float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
				half2 Normal_Planar45_g207090 = temp_output_26_0_g207086;
				float2 break71_g207090 = Normal_Planar45_g207090;
				float3 appendResult72_g207090 = (float3(break71_g207090.x , 0.0 , break71_g207090.y));
				float2 temp_output_205_0_g207086 = (mul( ase_worldToTangent, appendResult72_g207090 )).xy;
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float2 staticSwitch204_g207086 = temp_output_205_0_g207086;
				#else
				float2 staticSwitch204_g207086 = temp_output_26_0_g207086;
				#endif
				half2 Local_NormalTS108_g207086 = staticSwitch204_g207086;
				float2 In_NormalTS3_g207088 = Local_NormalTS108_g207086;
				float3 appendResult68_g207091 = (float3(Local_NormalTS108_g207086 , 1.0));
				float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
				float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
				float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
				float3 tanNormal74_g207091 = appendResult68_g207091;
				float3 worldNormal74_g207091 = normalize( float3( dot( tanToWorld0, tanNormal74_g207091 ), dot( tanToWorld1, tanNormal74_g207091 ), dot( tanToWorld2, tanNormal74_g207091 ) ) );
				half3 Local_NormalWS250_g207086 = worldNormal74_g207091;
				float3 In_NormalWS3_g207088 = Local_NormalWS250_g207086;
				float4 In_Shader3_g207088 = Local_Masks109_g207086;
				float4 In_Feature3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Season3_g207088 = half4( 1, 1, 1, 1 );
				float4 In_Emissive3_g207088 = half4( 1, 1, 1, 1 );
				float3 temp_output_3_0_g207092 = Local_Albedo139_g207086;
				float dotResult20_g207092 = dot( temp_output_3_0_g207092 , float3( 0.2126, 0.7152, 0.0722 ) );
				half Local_Grayscale110_g207086 = dotResult20_g207092;
				float temp_output_12_0_g207088 = Local_Grayscale110_g207086;
				float In_Grayscale3_g207088 = temp_output_12_0_g207088;
				float clampResult144_g207086 = clamp( saturate( ( Local_Grayscale110_g207086 * 5.0 ) ) , 0.2 , 1.0 );
				half Local_Luminosity145_g207086 = clampResult144_g207086;
				float temp_output_16_0_g207088 = Local_Luminosity145_g207086;
				float In_Luminosity3_g207088 = temp_output_16_0_g207088;
				float In_MultiMask3_g207088 = Local_MultiMask78_g207086;
				float temp_output_17_0_g251310 = _MainAlphaChannelMode;
				float Option83_g251310 = temp_output_17_0_g251310;
				TEXTURE2D(Texture276_g207099) = _MainAlphaTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g207100 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g207100 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g207099 = staticSwitch36_g207100;
				float localBreakTextureData456_g207099 = ( 0.0 );
				TVEMasksData Data456_g207099 =(TVEMasksData)Data431_g251292;
				float4 Out_MaskA456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g207099 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g207099 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g207099 , Out_MaskA456_g207099 , Out_MaskB456_g207099 , Out_MaskC456_g207099 , Out_MaskD456_g207099 , Out_MaskE456_g207099 , Out_MaskF456_g207099 , Out_MaskG456_g207099 , Out_MaskH456_g207099 , Out_MaskI456_g207099 , Out_MaskJ456_g207099 , Out_MaskK456_g207099 , Out_MaskL456_g207099 , Out_MaskM456_g207099 , Out_MaskN456_g207099 );
				half2 UV276_g207099 = (Out_MaskA456_g207099).xy;
				float temp_output_504_0_g207099 = 0.0;
				half Bias276_g207099 = temp_output_504_0_g207099;
				half2 Normal276_g207099 = float2( 0,0 );
				half4 localSampleCoord276_g207099 = SampleCoord( Texture276_g207099 , Sampler276_g207099 , UV276_g207099 , Bias276_g207099 , Normal276_g207099 );
				TEXTURE2D(Texture502_g207099) = _MainAlphaTex;
				SamplerState Sampler502_g207099 = staticSwitch36_g207100;
				half2 UV502_g207099 = (Out_MaskA456_g207099).zw;
				half Bias502_g207099 = temp_output_504_0_g207099;
				half2 Normal502_g207099 = float2( 0,0 );
				half4 localSampleCoord502_g207099 = SampleCoord( Texture502_g207099 , Sampler502_g207099 , UV502_g207099 , Bias502_g207099 , Normal502_g207099 );
				TEXTURE2D(Texture496_g207099) = _MainAlphaTex;
				SamplerState Sampler496_g207099 = staticSwitch36_g207100;
				float2 temp_output_463_0_g207099 = (Out_MaskB456_g207099).zw;
				half2 XZ496_g207099 = temp_output_463_0_g207099;
				half Bias496_g207099 = temp_output_504_0_g207099;
				float3 temp_output_483_0_g207099 = (Out_MaskK456_g207099).xyz;
				half3 NormalWS496_g207099 = temp_output_483_0_g207099;
				half3 Normal496_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g207099 = SamplePlanar2D( Texture496_g207099 , Sampler496_g207099 , XZ496_g207099 , Bias496_g207099 , NormalWS496_g207099 , Normal496_g207099 );
				TEXTURE2D(Texture490_g207099) = _MainAlphaTex;
				SamplerState Sampler490_g207099 = staticSwitch36_g207100;
				float2 temp_output_462_0_g207099 = (Out_MaskB456_g207099).xy;
				half2 ZY490_g207099 = temp_output_462_0_g207099;
				half2 XZ490_g207099 = temp_output_463_0_g207099;
				float2 temp_output_464_0_g207099 = (Out_MaskC456_g207099).xy;
				half2 XY490_g207099 = temp_output_464_0_g207099;
				half Bias490_g207099 = temp_output_504_0_g207099;
				float3 temp_output_482_0_g207099 = (Out_MaskN456_g207099).xyz;
				half3 Triplanar490_g207099 = temp_output_482_0_g207099;
				half3 NormalWS490_g207099 = temp_output_483_0_g207099;
				half3 Normal490_g207099 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g207099 = SamplePlanar3D( Texture490_g207099 , Sampler490_g207099 , ZY490_g207099 , XZ490_g207099 , XY490_g207099 , Bias490_g207099 , Triplanar490_g207099 , NormalWS490_g207099 , Normal490_g207099 );
				TEXTURE2D(Texture498_g207099) = _MainAlphaTex;
				SamplerState Sampler498_g207099 = staticSwitch36_g207100;
				half2 XZ498_g207099 = temp_output_463_0_g207099;
				float2 temp_output_473_0_g207099 = (Out_MaskE456_g207099).xy;
				half2 XZ_1498_g207099 = temp_output_473_0_g207099;
				float2 temp_output_474_0_g207099 = (Out_MaskE456_g207099).zw;
				half2 XZ_2498_g207099 = temp_output_474_0_g207099;
				float2 temp_output_475_0_g207099 = (Out_MaskF456_g207099).xy;
				half2 XZ_3498_g207099 = temp_output_475_0_g207099;
				float temp_output_510_0_g207099 = exp2( temp_output_504_0_g207099 );
				half Bias498_g207099 = temp_output_510_0_g207099;
				float3 temp_output_480_0_g207099 = (Out_MaskI456_g207099).xyz;
				half3 Weights_2498_g207099 = temp_output_480_0_g207099;
				half3 NormalWS498_g207099 = temp_output_483_0_g207099;
				half3 Normal498_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g207099 = SampleStochastic2D( Texture498_g207099 , Sampler498_g207099 , XZ498_g207099 , XZ_1498_g207099 , XZ_2498_g207099 , XZ_3498_g207099 , Bias498_g207099 , Weights_2498_g207099 , NormalWS498_g207099 , Normal498_g207099 );
				TEXTURE2D(Texture500_g207099) = _MainAlphaTex;
				SamplerState Sampler500_g207099 = staticSwitch36_g207100;
				half2 ZY500_g207099 = temp_output_462_0_g207099;
				half2 ZY_1500_g207099 = (Out_MaskC456_g207099).zw;
				half2 ZY_2500_g207099 = (Out_MaskD456_g207099).xy;
				half2 ZY_3500_g207099 = (Out_MaskD456_g207099).zw;
				half2 XZ500_g207099 = temp_output_463_0_g207099;
				half2 XZ_1500_g207099 = temp_output_473_0_g207099;
				half2 XZ_2500_g207099 = temp_output_474_0_g207099;
				half2 XZ_3500_g207099 = temp_output_475_0_g207099;
				half2 XY500_g207099 = temp_output_464_0_g207099;
				half2 XY_1500_g207099 = (Out_MaskF456_g207099).zw;
				half2 XY_2500_g207099 = (Out_MaskG456_g207099).xy;
				half2 XY_3500_g207099 = (Out_MaskG456_g207099).zw;
				half Bias500_g207099 = temp_output_510_0_g207099;
				half3 Weights_1500_g207099 = (Out_MaskH456_g207099).xyz;
				half3 Weights_2500_g207099 = temp_output_480_0_g207099;
				half3 Weights_3500_g207099 = (Out_MaskJ456_g207099).xyz;
				half3 Triplanar500_g207099 = temp_output_482_0_g207099;
				half3 NormalWS500_g207099 = temp_output_483_0_g207099;
				half3 Normal500_g207099 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g207099 = SampleStochastic3D( Texture500_g207099 , Sampler500_g207099 , ZY500_g207099 , ZY_1500_g207099 , ZY_2500_g207099 , ZY_3500_g207099 , XZ500_g207099 , XZ_1500_g207099 , XZ_2500_g207099 , XZ_3500_g207099 , XY500_g207099 , XY_1500_g207099 , XY_2500_g207099 , XY_3500_g207099 , Bias500_g207099 , Weights_1500_g207099 , Weights_2500_g207099 , Weights_3500_g207099 , Triplanar500_g207099 , NormalWS500_g207099 , Normal500_g207099 );
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch327_g207086 = localSampleCoord276_g207099;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch327_g207086 = localSampleCoord502_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch327_g207086 = localSamplePlanar2D496_g207099;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch327_g207086 = localSamplePlanar3D490_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch327_g207086 = localSampleStochastic2D498_g207099;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch327_g207086 = localSampleStochastic3D500_g207099;
				#else
				float4 staticSwitch327_g207086 = localSampleCoord276_g207099;
				#endif
				half4 Local_AlphaTex330_g207086 = staticSwitch327_g207086;
				float4 temp_output_28_0_g251311 = Local_AlphaTex330_g207086;
				float3 temp_output_29_0_g251311 = (temp_output_28_0_g251311).xyz;
				half3 linRGB27_g251311 = temp_output_29_0_g251311;
				half3 localLinearToGammaFloatFast27_g251311 = LinearToGammaFloatFast( linRGB27_g251311 );
				#ifdef UNITY_COLORSPACE_GAMMA
				float3 staticSwitch26_g251311 = temp_output_29_0_g251311;
				#else
				float3 staticSwitch26_g251311 = localLinearToGammaFloatFast27_g251311;
				#endif
				float4 appendResult31_g251311 = (float4(staticSwitch26_g251311 , (temp_output_28_0_g251311).w));
				float4 lerpResult442_g207086 = lerp( Local_AlphaTex330_g207086 , appendResult31_g251311 , _MainAlphaTexIsGamma);
				float4 ChannelA83_g251310 = lerpResult442_g207086;
				float4 ChannelB83_g251310 = ( 1.0 - lerpResult442_g207086 );
				float localSwitchChannel883_g251310 = SwitchChannel8( Option83_g251310 , ChannelA83_g251310 , ChannelB83_g251310 );
				float lerpResult385_g207086 = lerp( (Local_AlbedoTex185_g207086).w , localSwitchChannel883_g251310 , _MainAlphaSourceMode);
				#ifdef TVE_CLIPPING
				float staticSwitch236_g207086 = ( lerpResult385_g207086 - _MainAlphaClipValue );
				#else
				float staticSwitch236_g207086 = lerpResult385_g207086;
				#endif
				half Local_AlphaClip111_g207086 = staticSwitch236_g207086;
				float In_AlphaClip3_g207088 = Local_AlphaClip111_g207086;
				half Local_AlphaFade246_g207086 = (lerpResult62_g207086).a;
				float In_AlphaFade3_g207088 = Local_AlphaFade246_g207086;
				float3 temp_cast_10 = (1.0).xxx;
				float3 In_Translucency3_g207088 = temp_cast_10;
				float In_Transmission3_g207088 = 1.0;
				float In_Thickness3_g207088 = 0.0;
				float In_Diffusion3_g207088 = 0.0;
				float In_Depth3_g207088 = 0.0;
				BuildVisualData( Data3_g207088 , In_Dummy3_g207088 , In_Albedo3_g207088 , In_AlbedoBase3_g207088 , In_NormalTS3_g207088 , In_NormalWS3_g207088 , In_Shader3_g207088 , In_Feature3_g207088 , In_Season3_g207088 , In_Emissive3_g207088 , In_Grayscale3_g207088 , In_Luminosity3_g207088 , In_MultiMask3_g207088 , In_AlphaClip3_g207088 , In_AlphaFade3_g207088 , In_Translucency3_g207088 , In_Transmission3_g207088 , In_Thickness3_g207088 , In_Diffusion3_g207088 , In_Depth3_g207088 );
				TVEVisualData Data4_g251314 =(TVEVisualData)Data3_g207088;
				float Out_Dummy4_g251314 = 0.0;
				float3 Out_Albedo4_g251314 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g251314 = float3( 0,0,0 );
				float2 Out_NormalTS4_g251314 = float2( 0,0 );
				float3 Out_NormalWS4_g251314 = float3( 0,0,0 );
				float4 Out_Shader4_g251314 = float4( 0,0,0,0 );
				float4 Out_Feature4_g251314 = float4( 0,0,0,0 );
				float4 Out_Season4_g251314 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g251314 = float4( 0,0,0,0 );
				float Out_MultiMask4_g251314 = 0.0;
				float Out_Grayscale4_g251314 = 0.0;
				float Out_Luminosity4_g251314 = 0.0;
				float Out_AlphaClip4_g251314 = 0.0;
				float Out_AlphaFade4_g251314 = 0.0;
				float3 Out_Translucency4_g251314 = float3( 0,0,0 );
				float Out_Transmission4_g251314 = 0.0;
				float Out_Thickness4_g251314 = 0.0;
				float Out_Diffusion4_g251314 = 0.0;
				float Out_Depth4_g251314 = 0.0;
				BreakVisualData( Data4_g251314 , Out_Dummy4_g251314 , Out_Albedo4_g251314 , Out_AlbedoBase4_g251314 , Out_NormalTS4_g251314 , Out_NormalWS4_g251314 , Out_Shader4_g251314 , Out_Feature4_g251314 , Out_Season4_g251314 , Out_Emissive4_g251314 , Out_MultiMask4_g251314 , Out_Grayscale4_g251314 , Out_Luminosity4_g251314 , Out_AlphaClip4_g251314 , Out_AlphaFade4_g251314 , Out_Translucency4_g251314 , Out_Transmission4_g251314 , Out_Thickness4_g251314 , Out_Diffusion4_g251314 , Out_Depth4_g251314 );
				half3 Input_Albedo24_g251315 = Out_Albedo4_g251314;
				#ifdef UNITY_COLORSPACE_GAMMA
				float4 staticSwitch22_g251315 = half4( 0.2209163, 0.2209163, 0.2209163, 0.7790837 );
				#else
				float4 staticSwitch22_g251315 = half4( 0.04, 0.04, 0.04, 0.96 );
				#endif
				half4 ColorSpaceDielectricSpec23_g251315 = staticSwitch22_g251315;
				float4 break24_g251313 = Out_Shader4_g251314;
				half Metallic95_g251313 = break24_g251313.x;
				half Input_Metallic25_g251315 = Metallic95_g251313;
				half OneMinusReflectivity31_g251315 = ( (ColorSpaceDielectricSpec23_g251315).w - ( (ColorSpaceDielectricSpec23_g251315).w * Input_Metallic25_g251315 ) );
				float3 temp_output_6_0_g251331 = ( Input_Albedo24_g251315 * OneMinusReflectivity31_g251315 );
				half Render_Common200_g251313 = ( _RenderCull + _RenderZWrite + _RenderQueue + _RenderPriority + _RenderBakeGI + _RenderNormal + _RenderFilter + _RenderClip + _DisableSRPBatcher );
				half Render_Motion186_g251313 = _RenderMotion;
				half Render_URPOnly190_g251313 = ( _RenderShadow + _RenderMotionXR + _RenderGBuffer + Render_Motion186_g251313 );
				half Render_Pipeline184_g251313 = ( Render_Common200_g251313 + Render_URPOnly190_g251313 );
				float temp_output_7_0_g251331 = Render_Pipeline184_g251313;
				float temp_output_17_0_g251331 = ( temp_output_7_0_g251331 + 0.0 );
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g251331 = ( temp_output_6_0_g251331 + temp_output_17_0_g251331 );
				#else
				float3 staticSwitch14_g251331 = temp_output_6_0_g251331;
				#endif
				
				float3 appendResult23_g251313 = (float3(Out_NormalTS4_g251314 , 1.0));
				float3 temp_output_13_0_g251322 = appendResult23_g251313;
				float3 temp_output_33_0_g251322 = ( temp_output_13_0_g251322 * _render_normal );
				float3 switchResult12_g251322 = (((ase_vface>0)?(temp_output_13_0_g251322):(temp_output_33_0_g251322)));
				
				float3 lerpResult28_g251315 = lerp( (ColorSpaceDielectricSpec23_g251315).xyz , Input_Albedo24_g251315 , Input_Metallic25_g251315);
				half3 Specular160_g251313 = lerpResult28_g251315;
				half3 Input_Specular73_g251316 = Specular160_g251313;
				half Render_Spec102_g251313 = _RenderSpecular;
				half Input_RenderSpec58_g251316 = Render_Spec102_g251313;
				half localGBufferPassCheck35_g251317 = ( 0.0 );
				half Input_True57_g251317 = 0.04;
				half True35_g251317 = Input_True57_g251317;
				half Smoothness105_g251313 = break24_g251313.w;
				half Input_Smoothness43_g251316 = Smoothness105_g251313;
				float temp_output_46_0_g251316 = max( ( Input_Smoothness43_g251316 * Input_RenderSpec58_g251316 ), 0.001 );
				half Input_False58_g251317 = temp_output_46_0_g251316;
				half False35_g251317 = Input_False58_g251317;
				half Result35_g251317 = 0;
				{
				#if defined(SHADERPASS) && (SHADERPASS  == SHADERPASS_GBUFFER)
				Result35_g251317 = True35_g251317;
				#else
				Result35_g251317 = False35_g251317;
				#endif
				}
				float3 temp_cast_11 = (Result35_g251317).xxx;
				#ifdef ASE_LIGHTING_SIMPLE
				float3 staticSwitch75_g251316 = temp_cast_11;
				#else
				float3 staticSwitch75_g251316 = ( Input_Specular73_g251316 * Input_RenderSpec58_g251316 );
				#endif
				
				half localGBufferPassCheck35_g251319 = ( 0.0 );
				half Input_True57_g251319 = Input_Smoothness43_g251316;
				half True35_g251319 = Input_True57_g251319;
				half Input_False58_g251319 = temp_output_46_0_g251316;
				half False35_g251319 = Input_False58_g251319;
				half Result35_g251319 = 0;
				{
				#if defined(SHADERPASS) && (SHADERPASS  == SHADERPASS_GBUFFER)
				Result35_g251319 = True35_g251319;
				#else
				Result35_g251319 = False35_g251319;
				#endif
				}
				#ifdef ASE_LIGHTING_SIMPLE
				float staticSwitch79_g251316 = Result35_g251319;
				#else
				float staticSwitch79_g251316 = Input_Smoothness43_g251316;
				#endif
				

				float3 BaseColor = staticSwitch14_g251331;
				float3 Normal = switchResult12_g251322;
				float3 Specular = staticSwitch75_g251316;
				float Metallic = 0;
				float Smoothness = staticSwitch79_g251316;
				float Occlusion = break24_g251313.y;
				float3 Emission = 0;
				float Alpha = 1;
				#if defined( _ALPHATEST_ON )
					float AlphaClipThreshold = _Cutoff;
					float AlphaClipThresholdShadow = 0.5;
				#endif
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;

				#if defined( ASE_DEPTH_WRITE_ON )
					input.positionCS.z = input.positionCS.z;
				#endif

				#if defined( _ALPHATEST_ON )
					AlphaDiscard( Alpha, AlphaClipThreshold );
				#endif

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS) && defined(ASE_CHANGES_WORLD_POS)
					ShadowCoord = TransformWorldToShadowCoord( PositionWS );
				#endif

				InputData inputData = (InputData)0;
				inputData.positionWS = PositionWS;
				inputData.positionCS = input.positionCS;
				inputData.normalizedScreenSpaceUV = ScreenPosNorm.xy;
				inputData.shadowCoord = ShadowCoord;

				#ifdef _NORMALMAP
					#if _NORMAL_DROPOFF_TS
						inputData.normalWS = TransformTangentToWorld(Normal, half3x3( TangentWS, BitangentWS, NormalWS ));
					#elif _NORMAL_DROPOFF_OS
						inputData.normalWS = TransformObjectToWorldNormal(Normal);
					#elif _NORMAL_DROPOFF_WS
						inputData.normalWS = Normal;
					#endif
				#else
					inputData.normalWS = NormalWS;
				#endif

				inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				inputData.viewDirectionWS = SafeNormalize( ViewDirWS );

				#ifdef ASE_FOG
					// @diogo: no fog applied in GBuffer
				#endif
				#ifdef _ADDITIONAL_LIGHTS_VERTEX
					inputData.vertexLighting = input.fogFactorAndVertexLight.yzw;
				#endif

				#if defined( ENABLE_TERRAIN_PERPIXEL_NORMAL )
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = input.lightmapUVOrVertexSH.xyz;
				#endif

				#if defined(_SCREEN_SPACE_IRRADIANCE)
					inputData.bakedGI = SAMPLE_GI(_ScreenSpaceIrradiance, input.positionCS.xy);
				#elif defined(DYNAMICLIGHTMAP_ON)
					inputData.bakedGI = SAMPLE_GI(input.lightmapUVOrVertexSH.xy, input.dynamicLightmapUV.xy, SH, inputData.normalWS);
					inputData.shadowMask = SAMPLE_SHADOWMASK(input.lightmapUVOrVertexSH.xy);
				#elif !defined(LIGHTMAP_ON) && (defined(PROBE_VOLUMES_L1) || defined(PROBE_VOLUMES_L2))
					inputData.bakedGI = SAMPLE_GI(SH,
						GetAbsolutePositionWS(inputData.positionWS),
						inputData.normalWS,
						inputData.viewDirectionWS,
						input.positionCS.xy,
						input.probeOcclusion,
						inputData.shadowMask);
				#else
					inputData.bakedGI = SAMPLE_GI(input.lightmapUVOrVertexSH.xy, SH, inputData.normalWS);
					inputData.shadowMask = SAMPLE_SHADOWMASK(input.lightmapUVOrVertexSH.xy);
				#endif

				#ifdef ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#endif

				#if defined(DEBUG_DISPLAY)
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.dynamicLightmapUV = input.dynamicLightmapUV.xy;
						#endif
					#if defined(LIGHTMAP_ON)
						inputData.staticLightmapUV = input.lightmapUVOrVertexSH.xy;
					#else
						inputData.vertexSH = SH;
					#endif
					#if defined(USE_APV_PROBE_OCCLUSION)
						inputData.probeOcclusion = input.probeOcclusion;
					#endif
				#endif

				#ifdef _DBUFFER
					ApplyDecal(input.positionCS,
						BaseColor,
						Specular,
						inputData.normalWS,
						Metallic,
						Occlusion,
						Smoothness);
				#endif

				BRDFData brdfData;
				InitializeBRDFData(BaseColor, Metallic, Specular, Smoothness, Alpha, brdfData);

				Light mainLight = GetMainLight(inputData.shadowCoord, inputData.positionWS, inputData.shadowMask);
				half4 color;
				MixRealtimeAndBakedGI(mainLight, inputData.normalWS, inputData.bakedGI, inputData.shadowMask);

				color.rgb = GlobalIllumination(brdfData, (BRDFData)0, 0,
                              inputData.bakedGI, Occlusion, inputData.positionWS,
                              inputData.normalWS, inputData.viewDirectionWS, inputData.normalizedScreenSpaceUV);

				color.a = Alpha;

				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = input.positionCS.z;
				#endif

				return PackGBuffersBRDFData(brdfData, inputData, Smoothness, Emission + color.rgb, Occlusion);
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			Cull Off
			AlphaToMask Off

			HLSLPROGRAM

			#define ASE_GEOMETRY
			#define ASE_OPAQUE_KEEP_ALPHA
			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#define _NORMALMAP 1
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION 170300
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#if defined( _SPECULAR_SETUP ) && defined( ASE_LIGHTING_SIMPLE )
				#if defined( _SPECULARHIGHLIGHTS_OFF )
					#undef _SPECULAR_COLOR
				#else
					#define _SPECULAR_COLOR
				#endif
			#endif

			#define SCENESELECTIONPASS 1

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined (TVE_CLIPPING) //Render Clip
				#define TVE_ALPHA_CLIP //Render Clip
			#endif //Render Clip
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END
			  
			struct TVEVisualData
			{  
				half Dummy;  
				half3 Albedo;
				half3 AlbedoBase;
				half2 NormalTS;
				half3 NormalWS; 
				half4 Shader;
				half4 Feature;
				half4 Season;
				float4 Emissive;
				half AlphaClip;
				half AlphaFade;
				half MultiMask;
				half Grayscale;
				half Luminosity;
				float3 Translucency;
				half Transmission;
				half Thickness;
				float Diffusion;
				float Depth;
			};  
			    
			struct TVEModelData
			{    
				half Dummy;    
				float3 PositionOS;
				float3 PositionWS;
				float3 PositionWO;
				float3 PositionRawOS;
				float3 PivotOS;
				float3 PivotWS;
				float3 PivotWO;
				half3 NormalOS;
				half3 NormalWS;
				half3 NormalRawOS;
				half4 TangentOS;
				half3 TangentWS;
				half3 BitangentWS;
				half3 TriplanarWeights;
				half3 ViewDirWS;
				float4 CoordsData;
				half4 VertexData;
				half4 MasksData;   
				half4 PhaseData;
				half4 TransformData;
				half4 RotationData;
				float4 InterpolatorA;
			};    
			      
			struct TVEGlobalData
			{      
				half Dummy;      
				half4 CoatParams;
				half4 CoatTexture;
				half4 PaintParams;
				half4 PaintTexture;
				half4 AtmoParams;
				half4 AtmoTexture;
				half4 GlowParams;
				half4 GlowTexture;
				float4 FormParams;
				float4 FormTexture;
				half4 FlowParams;
				half4 FlowTexture;
			};      
			        
			struct TVEMasksData
			{        
				half4 MaskA;
				half4 MaskB;
				half4 MaskC;
				half4 MaskD;
				half4 MaskE;
				half4 MaskF;
				half4 MaskG;
				half4 MaskH;
				half4 MaskI;
				half4 MaskJ;
				half4 MaskK;
				half4 MaskL;
				half4 MaskM;
				half4 MaskN;
			};        
			#define TVE_GEOMETRY_SHADER


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			half4 _MainOcclusionRemap;
			half4 _MainColor;
			half4 _MainColorTwo;
			half4 _MainMultiRemap;
			half4 _main_coord_value;
			half4 _MainSmoothnessRemap;
			half4 _MainCoordValue;
			half3 _render_normal;
			half _MainMultiVlaue;
			half _MainMultiSourceMode;
			half _MainMultiChannelMode;
			half _MainSmoothnessSourceMode;
			half _MainColorMode;
			float _MainSmoothnessTexGammaMode;
			half _MainSmoothnessChannelMode;
			half _MainOcclusionValue;
			half _MainSmoothnessValue;
			half _render_src;
			half _MainNormalValue;
			float _MainAlphaTexIsGamma;
			half _RenderMotion;
			half _RenderGBuffer;
			half _RenderMotionXR;
			half _RenderShadow;
			half _RenderClip;
			half _RenderFilter;
			half _MainAlphaChannelMode;
			half _RenderNormal;
			half _RenderPriority;
			half _RenderQueue;
			half _RenderZWrite;
			half _RenderCull;
			half _MainAlphaClipValue;
			half _MainAlphaSourceMode;
			half _RenderBakeGI;
			half _MainOcclusionSourceMode;
			half _MainMetallicSourceMode;
			half _MainMetallicValue;
			half _render_cull;
			half _render_dst;
			half _render_zw;
			half _render_coverage;
			half _IsGeneralShader;
			half _RenderEnd;
			half _IsVersion;
			half _IsTVEShader;
			half _IsLightingType;
			half _IsCustomShader;
			half _IsCollected;
			half _IsConverted;
			half _IsIdentifier;
			half _MainOcclusionChannelMode;
			half _IsShared;
			half _IsShaderType;
			half _IsObjectType;
			half _RenderCategory;
			half _IsStandardShader;
			half _MainCategory;
			half _MainEnd;
			half _MainSampleMode;
			half _MainCoordMode;
			half _MainMultiMaskInfo;
			half _MainSmoothnessInfo;
			half _ObjectPhaseMode;
			half _MainAlbedoValue;
			half _MainMetallicChannelMode;
			half _UseExternalSettings;
			half _RenderSpecular;
			float _AlphaClip;
			float _Cutoff;
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
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			

			
			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			PackedVaryings VertexFunction(Attributes input  )
			{
				PackedVaryings output;
				ZERO_INITIALIZE(PackedVaryings, output);

				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );

				output.positionCS = vertexInput.positionCS;
				output.positionWS = vertexInput.positionWS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
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
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag( PackedVaryings input
				#if defined( ASE_DEPTH_WRITE_ON )
				,out float outputDepth : ASE_SV_DEPTH
				#endif
				 ) : SV_Target
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( PositionWS );
				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;

				

				surfaceDescription.Alpha = 1;
				#if defined( _ALPHATEST_ON )
					surfaceDescription.AlphaClipThreshold = _Cutoff;
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					input.positionCS.z = input.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(surfaceDescription.Alpha - surfaceDescription.AlphaClipThreshold);
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = input.positionCS.z;
				#endif

				return half4( _ObjectId, _PassValue, 1.0, 1.0 );
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ScenePickingPass"
			Tags { "LightMode"="Picking" }

			AlphaToMask Off

			HLSLPROGRAM

			#define ASE_GEOMETRY
			#define ASE_OPAQUE_KEEP_ALPHA
			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _SPECULAR_SETUP 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#pragma multi_compile_fragment _ DEBUG_DISPLAY
			#define _NORMALMAP 1
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION 170300
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#if defined( _SPECULAR_SETUP ) && defined( ASE_LIGHTING_SIMPLE )
				#if defined( _SPECULARHIGHLIGHTS_OFF )
					#undef _SPECULAR_COLOR
				#else
					#define _SPECULAR_COLOR
				#endif
			#endif

		    #define SCENEPICKINGPASS 1

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined (TVE_CLIPPING) //Render Clip
				#define TVE_ALPHA_CLIP //Render Clip
			#endif //Render Clip
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END
			  
			struct TVEVisualData
			{  
				half Dummy;  
				half3 Albedo;
				half3 AlbedoBase;
				half2 NormalTS;
				half3 NormalWS; 
				half4 Shader;
				half4 Feature;
				half4 Season;
				float4 Emissive;
				half AlphaClip;
				half AlphaFade;
				half MultiMask;
				half Grayscale;
				half Luminosity;
				float3 Translucency;
				half Transmission;
				half Thickness;
				float Diffusion;
				float Depth;
			};  
			    
			struct TVEModelData
			{    
				half Dummy;    
				float3 PositionOS;
				float3 PositionWS;
				float3 PositionWO;
				float3 PositionRawOS;
				float3 PivotOS;
				float3 PivotWS;
				float3 PivotWO;
				half3 NormalOS;
				half3 NormalWS;
				half3 NormalRawOS;
				half4 TangentOS;
				half3 TangentWS;
				half3 BitangentWS;
				half3 TriplanarWeights;
				half3 ViewDirWS;
				float4 CoordsData;
				half4 VertexData;
				half4 MasksData;   
				half4 PhaseData;
				half4 TransformData;
				half4 RotationData;
				float4 InterpolatorA;
			};    
			      
			struct TVEGlobalData
			{      
				half Dummy;      
				half4 CoatParams;
				half4 CoatTexture;
				half4 PaintParams;
				half4 PaintTexture;
				half4 AtmoParams;
				half4 AtmoTexture;
				half4 GlowParams;
				half4 GlowTexture;
				float4 FormParams;
				float4 FormTexture;
				half4 FlowParams;
				half4 FlowTexture;
			};      
			        
			struct TVEMasksData
			{        
				half4 MaskA;
				half4 MaskB;
				half4 MaskC;
				half4 MaskD;
				half4 MaskE;
				half4 MaskF;
				half4 MaskG;
				half4 MaskH;
				half4 MaskI;
				half4 MaskJ;
				half4 MaskK;
				half4 MaskL;
				half4 MaskM;
				half4 MaskN;
			};        
			#define TVE_GEOMETRY_SHADER


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			half4 _MainOcclusionRemap;
			half4 _MainColor;
			half4 _MainColorTwo;
			half4 _MainMultiRemap;
			half4 _main_coord_value;
			half4 _MainSmoothnessRemap;
			half4 _MainCoordValue;
			half3 _render_normal;
			half _MainMultiVlaue;
			half _MainMultiSourceMode;
			half _MainMultiChannelMode;
			half _MainSmoothnessSourceMode;
			half _MainColorMode;
			float _MainSmoothnessTexGammaMode;
			half _MainSmoothnessChannelMode;
			half _MainOcclusionValue;
			half _MainSmoothnessValue;
			half _render_src;
			half _MainNormalValue;
			float _MainAlphaTexIsGamma;
			half _RenderMotion;
			half _RenderGBuffer;
			half _RenderMotionXR;
			half _RenderShadow;
			half _RenderClip;
			half _RenderFilter;
			half _MainAlphaChannelMode;
			half _RenderNormal;
			half _RenderPriority;
			half _RenderQueue;
			half _RenderZWrite;
			half _RenderCull;
			half _MainAlphaClipValue;
			half _MainAlphaSourceMode;
			half _RenderBakeGI;
			half _MainOcclusionSourceMode;
			half _MainMetallicSourceMode;
			half _MainMetallicValue;
			half _render_cull;
			half _render_dst;
			half _render_zw;
			half _render_coverage;
			half _IsGeneralShader;
			half _RenderEnd;
			half _IsVersion;
			half _IsTVEShader;
			half _IsLightingType;
			half _IsCustomShader;
			half _IsCollected;
			half _IsConverted;
			half _IsIdentifier;
			half _MainOcclusionChannelMode;
			half _IsShared;
			half _IsShaderType;
			half _IsObjectType;
			half _RenderCategory;
			half _IsStandardShader;
			half _MainCategory;
			half _MainEnd;
			half _MainSampleMode;
			half _MainCoordMode;
			half _MainMultiMaskInfo;
			half _MainSmoothnessInfo;
			half _ObjectPhaseMode;
			half _MainAlbedoValue;
			half _MainMetallicChannelMode;
			half _UseExternalSettings;
			half _RenderSpecular;
			float _AlphaClip;
			float _Cutoff;
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
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			

			
			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output;
				ZERO_INITIALIZE(PackedVaryings, output);

				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );

				output.positionCS = vertexInput.positionCS;
				output.positionWS = vertexInput.positionWS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
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
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag( PackedVaryings input
				#if defined( ASE_DEPTH_WRITE_ON )
				,out float outputDepth : ASE_SV_DEPTH
				#endif
				 ) : SV_Target
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( PositionWS );
				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;

				

				surfaceDescription.Alpha = 1;
				#if defined( _ALPHATEST_ON )
					surfaceDescription.AlphaClipThreshold = _Cutoff;
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					input.positionCS.z = input.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(surfaceDescription.Alpha - surfaceDescription.AlphaClipThreshold);
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = input.positionCS.z;
				#endif

				return unity_SelectionID;
			}
			ENDHLSL
		}

	
	}
	
	CustomEditor "TheVisualEngine.MaterialGUI"
	FallBack "Hidden/Shader Graph/FallbackError"
	
	Fallback Off
}

/*ASEBEGIN
Version=19908
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5246;640,-256;Inherit;False;Block Model;47;;205214;7ad7765e793a6714babedee0033c36e9;18,404,1,437,1,431,1,240,1,290,1,289,1,291,1,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0;11;102;FLOAT3;0,0,0;False;163;FLOAT3;0,0,0;False;186;FLOAT3;0,0,0;False;187;FLOAT3;0,0,0;False;166;FLOAT3;0,0,0;False;164;FLOAT3;0,0,0;False;301;FLOAT3;0,0,0;False;418;FLOAT3;0,0,0;False;167;FLOAT4;0,0,0,0;False;172;FLOAT4;0,0,0,0;False;175;FLOAT4;0,0,0,0;False;2;OBJECT;128;OBJECT;314
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;4641;960,-192;Half;False;Model Frag;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;4598;1408,-256;Inherit;False;4641;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5292;1664,-256;Inherit;False;Block Main Packer;60;;207086;6f902604bb216a2499087c243d45e11c;2,65,1,136,1;1;225;OBJECT;0,0,0,0;False;1;OBJECT;106
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;4635;1984,-256;Half;False;Visual Data;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2213;2432,-256;Inherit;False;4635;Visual Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;20;2608,-640;Half;False;Property;_render_src;_render_src;103;1;[HideInInspector];Create;True;0;0;0;True;0;False;5;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;10;2432,-640;Half;False;Property;_render_cull;_render_cull;102;1;[HideInInspector];Create;True;0;3;Both;0;Back;1;Front;2;0;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;7;2784,-640;Half;False;Property;_render_dst;_render_dst;104;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;17;2960,-640;Half;False;Property;_render_zw;_render_zw;105;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1355;3136,-640;Half;False;Property;_render_coverage;_render_coverage;106;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1087;3712,-640;Inherit;False;Base Compile;-1;;251312;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2267;2432,-768;Half;False;Property;_IsGeneralShader;_IsGeneralShader;107;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5267;2688,-256;Inherit;False;Block Render;0;;251313;a46c8f81ec84cc34b8c5bbba7c174e1d;0;3;17;OBJECT;;False;19;OBJECT;;False;125;FLOAT;0;False;18;FLOAT3;21;FLOAT3;22;FLOAT3;182;FLOAT3;77;FLOAT;27;FLOAT;26;FLOAT3;34;FLOAT;72;FLOAT;28;FLOAT;71;FLOAT3;65;FLOAT;66;FLOAT;67;FLOAT;68;FLOAT;73;FLOAT3;30;FLOAT3;32;FLOAT4;33
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;4645;960,-256;Half;False;Model Vert;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;4258;2656,-768;Half;False;Property;_IsStandardShader;_IsStandardShader;108;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5294;3232,-256;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ExtraPrePass;0;0;ExtraPrePass;6;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;AlwaysRenderMotionVectors=false;True;3;True;14;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;0;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5295;3232,-256;Float;False;True;-1;3;TheVisualEngine.MaterialGUI;0;1;BOXOPHOBIC/The Visual Engine/Helpers/Custom Texture Packing;28cd5599e02859647ae1798e4fcaef6c;True;Forward;0;1;Forward;21;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;2;True;_render_cull;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;1;True;_render_zw;True;0;False;;True;True;0;False;;0;False;;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;AlwaysRenderMotionVectors=false;True;5;True;14;all;0;False;True;1;1;False;_render_src;0;False;_render_dst;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;1;True;_render_zw;True;0;False;;True;True;0;False;;0;False;;False;True;1;LightMode=UniversalForward;False;False;0;;0;0;Standard;47;Category;0;0;Workflow;0;638742667611949458;Surface;0;0;  Keep Alpha;1;0;  Refraction Model;0;0;  Blend;0;0;Two Sided;0;638742667626996115;Fragment Normal Space;0;0;Forward Only;0;0;  Keep GBuffer;1;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;0;Receive Shadows;1;0;Receive Specular;1;0;Receive SSAO;1;0;Motion Vectors;0;638742671875143521;  Add Precomputed Velocity;0;0;  XR Motion Vectors;0;0;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;0;_FinalColorxAlpha;0;0;Meta Pass;1;0;Override Baked GI;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Write Depth;0;0;  Early Z;0;0;Vertex Position;0;638742667778187911;Debug Display;1;638742667833276391;Clear Coat;0;0;0;12;False;True;True;True;True;True;True;True;True;True;False;False;False;;True;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5296;3232,-256;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;AlwaysRenderMotionVectors=false;True;3;True;14;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5297;3232,-256;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;AlwaysRenderMotionVectors=false;True;3;True;14;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=DepthOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5298;3232,-256;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;AlwaysRenderMotionVectors=false;True;3;True;14;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5299;3232,-256;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Universal2D;0;5;Universal2D;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;AlwaysRenderMotionVectors=false;True;3;True;14;all;0;False;True;1;1;False;_render_src;0;False;_render_dst;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;False;False;True;1;True;;True;0;False;;True;True;0;False;;0;False;;False;True;1;LightMode=Universal2D;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5300;3232,-256;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;DepthNormals;0;6;DepthNormals;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;AlwaysRenderMotionVectors=false;True;3;True;14;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=DepthNormals;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5301;3232,-256;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;GBuffer;0;7;GBuffer;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;AlwaysRenderMotionVectors=false;True;3;True;14;all;0;False;True;1;1;False;_render_src;0;False;_render_dst;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;True;;True;0;False;;True;True;0;False;;0;False;;False;True;1;LightMode=UniversalGBuffer;False;True;11;d3d11;gles;metal;vulkan;xboxone;xboxseries;playstation;ps4;ps5;switch;switch2;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5302;3232,-256;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;SceneSelectionPass;0;8;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;AlwaysRenderMotionVectors=false;True;3;True;14;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5303;3232,-256;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ScenePickingPass;0;9;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;AlwaysRenderMotionVectors=false;True;3;True;14;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5304;3232,-156;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;MotionVectors;0;10;MotionVectors;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;AlwaysRenderMotionVectors=false;True;5;True;14;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;False;False;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=MotionVectors;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5305;3232,-146;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;XRMotionVectors;0;11;XRMotionVectors;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;AlwaysRenderMotionVectors=false;True;5;True;14;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;True;1;False;;255;False;;1;False;;7;False;;3;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;False;True;1;LightMode=XRMotionVectors;False;False;0;;0;0;Standard;0;False;0
WireConnection;4641;0;5246;314
WireConnection;5292;225;4598;0
WireConnection;4635;0;5292;106
WireConnection;5267;17;2213;0
WireConnection;4645;0;5246;128
WireConnection;5295;0;5267;21
WireConnection;5295;1;5267;22
WireConnection;5295;9;5267;77
WireConnection;5295;4;5267;27
WireConnection;5295;5;5267;26
ASEEND*/
//CHKSM=3CCF1BA94A5AB51E72F75388A7208540F7DC02F6