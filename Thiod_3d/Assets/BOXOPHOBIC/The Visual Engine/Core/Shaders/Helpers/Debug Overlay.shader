// Made with Amplify Shader Editor v1.9.9.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Overlay"
{
	Properties
	{
		_RenderClip( "_RenderClip", Float ) = 0
		_IsElementShader( "_IsElementShader", Float ) = 0
		_IsHelperShader( "_IsHelperShader", Float ) = 0
		_OverlayIntensityValue( "Overlay Intensity", Range( 0, 1 ) ) = 0
		[Enum(Off,0,On,1)] _OverlayTextureMode( "Overlay Maps", Float ) = 0
		[Space(10)] _OverlayGlitterIntensityValue( "Overlay Glitter Intensity", Range( 0, 1 ) ) = 0
		_OverlayGlobalValue( "Overlay Atmo Mask", Range( 0, 1 ) ) = 1
		_OverlayLumaValue( "Overlay Luma Mask", Range( 0, 1 ) ) = 1
		[StyledRemapSlider] _OverlayLumaRemap( "Overlay Luma Mask", Vector ) = ( 0, 1, 0, 0 )
		_OverlayProjValue( "Overlay ProjY Mask", Range( 0, 1 ) ) = 0.5
		[StyledRemapSlider] _OverlayProjRemap( "Overlay ProjY Mask", Vector ) = ( 0, 1, 0, 0 )
		_OverlayMeshValue( "Overlay Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _OverlayMeshMode( "Overlay Mesh Mask", Float ) = 1
		[StyledRemapSlider] _OverlayMeshRemap( "Overlay Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _OverlayBlendRemap( "Overlay Blend Mask", Vector ) = ( 0.1, 0.2, 0, 0 )
		[Space(10)][StyledToggle] _OverlayElementMode( "Use Atmo Elements", Float ) = 0
		[StyledCategory(Object Settings, true, Use the Legacy Model mode only for meshes converted using the old Vegetation Engine asset.NEWNEWUse the Z Up Axis mode when the mesh rotation is set as MIN90 on the X axis.NEWNEWUse the Phase Mask to select which vertex color is used for perMINbranch or perMINleaf variation for Motion or Perspective phase offset.NEWNEWUse the Height and Radius values to normalize the procedural Height and Capsule masks used for Motion. In URP and HDRP__ the mesh renderer bounds can be used to remap the values automaticalyEXC, 0, 10)] _ObjectCategory( "[ Object Category ]", Float ) = 1
		[Enum(Legacy,0,Default,1)] _ObjectModelMode( "Object Model Mode", Float ) = 1
		[Enum(Single,0,Baked,1,Procedural,2)] _ObjectPivotMode( "Object Pivots Mode", Float ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _ObjectPhaseMode( "Object Phase Mask", Float ) = 0
		_ObjectHeightValue( "Object Height Value", Range( 0, 40 ) ) = 1
		_ObjectRadiusValue( "Object Radius Value", Range( 0, 40 ) ) = 1
		[StyledSpace(10)] _ObjectEnd( "[ Object End ]", Float ) = 1
		_IsShaderType( "_IsShaderType", Float ) = 0
		[HideInInspector] _IsTVEShader( "_IsTVEShader", Float ) = 0
		[StyledCategory(Global Settings, true, Use the Pivots sliders to control if the global texture is sampled in world space or at pivot position or pivots positions when baked pivots are used or when available.,0, 10)] _GlobalCategory( "[ Global Category ]", Float ) = 1
		[StyledEnum(Coat Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _GlobalCoatLayerValue( "Global Coat Layer", Float ) = 0
		[StyledEnum(Paint Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _GlobalPaintLayerValue( "Global Paint Layer", Float ) = 0
		[StyledEnum(Atmo Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _GlobalAtmoLayerValue( "Global Atmo Layer", Float ) = 0
		[StyledEnum(Glow Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _GlobalGlowLayerValue( "Global Glow Layer", Float ) = 0
		[StyledEnum(Form Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _GlobalFormLayerValue( "Global Form Layer", Float ) = 0
		[StyledEnum(Push Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _GlobalFlowLayerValue( "Global Flow Layer", Float ) = 0
		_GlobalCoatPivotValue( "Global Coat Pivots", Range( 0, 1 ) ) = 0
		_GlobalPaintPivotValue( "Global Paint Pivots", Range( 0, 1 ) ) = 0
		_GlobalAtmoPivotValue( "Global Atmo Pivots", Range( 0, 1 ) ) = 0
		_GlobalGlowPivotValue( "Global Glow Pivots", Range( 0, 1 ) ) = 0
		_GlobalFormPivotValue( "Global Form Pivots", Range( 0, 1 ) ) = 0
		_GlobalFlowPivotValue( "Global Flow Pivots", Range( 0, 1 ) ) = 0
		[StyledSpace(10)] _GlobalEnd( "[ Global End ]", Float ) = 1
		[StyledCategory(Main Settings, true, Use the Shader texture blue channel as a leaves mask when using dual colors or for global coloring effects. Control if the mask is used OPAwhen availableCPA for the following features via the Multi Mask remap sliders.NEWNEWUse the Shader texture blue channel as a height mask for bark and props. In this case__ the next layers can use the height mask via the Base Mask sliders., 0, 10)] _MainCategory( "[Main Category ]", Float ) = 1
		[MainTexture][StyledTextureSingleLine(Albedo RGB Alpha A)] _MainAlbedoTex( "Main Albedo", 2D ) = "white" {}
		[StyledTextureSingleLine(NormalXY AG)] _MainNormalTex( "Main Normal", 2D ) = "linearGrey" {}
		[StyledTextureSingleLine(Metallic R Occlusion G BaseMask and MultiMask B Smoothness A)] _MainShaderTex( "Main Shader", 2D ) = "white" {}
		[Enum(Main UV,0,Extra UV,1,Planar,2,Triplanar,3,Stochastic,4,Stochastic Triplanar,5)][Space(10)] _MainSampleMode( "Main Sampling", Float ) = 0
		[Enum(Tilling And Offset,0,Scale And Offset,1)] _MainCoordMode( "Main UV Mode", Float ) = 0
		[StyledVector(9)] _MainCoordValue( "Main UV Value", Vector ) = ( 1, 1, 0, 0 )
		[Enum(Constant,0,Dual Colors,1)] _MainColorMode( "Main Color", Float ) = 0
		[HDR][Gamma][MainColor] _MainColor( "Main Color", Color ) = ( 1, 1, 1, 1 )
		[HDR][Gamma] _MainColorTwo( "Main Color B", Color ) = ( 1, 1, 1, 1 )
		_MainAlphaClipValue( "Main Alpha", Range( 0, 1 ) ) = 0.5
		_MainAlbedoValue( "Main Albedo", Range( 0, 1 ) ) = 1
		_MainNormalValue( "Main Normal", Range( -8, 8 ) ) = 1
		_MainMetallicValue( "Main Metallic", Range( 0, 1 ) ) = 0
		_MainOcclusionValue( "Main Occlusion", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _MainOcclusionRemap( "Main Occlusion", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _MainMultiRemap( "Main Multi Mask", Vector ) = ( 0, 1, 0, 0 )
		_MainSmoothnessValue( "Main Smoothness", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _MainSmoothnessRemap( "Main Smoothness", Vector ) = ( 0, 1, 0, 0 )
		[HideInInspector] _main_coord_value( "_main_coord_value", Vector ) = ( 1, 1, 0, 0 )
		[StyledSpace(10)] _MainEnd( "[Main End ]", Float ) = 1
		[StyledCategory(Conform Settings, true, Use the Conform feature to project the vertices to the terrain or mesh surfaces__ similar to how decals work__ but for 3D objects. The most common usage is with big patches of grass__ groups of rocks or QUOplanarQUO ground covers which would not work properly on curved surfaces. Please note__ the projection only works from top down view and the effect it is only visual OPAcollider is not affectedCPAEXC, _ConformIntensityValue, FF0000, 0, 10)] _ConformCategory( "[ Conform Category ]", Float ) = 0
		[StyledMessage(Info, The Conform position features require elements to work. Use Form Surface or Form Height elements for conforming  the objects to terrain surfaces. Please note__ the conform effect is only visual and it does not affect the object collider and bounds., 0, 10)] _ConformInfo( "_ConformInfo", Float ) = 0
		_ConformIntensityValue( "Conform Intensity", Range( 0, 1 ) ) = 0
		[Enum(Freeform Object Position,0,Lock Position With Conform,1)] _ConformMode( "Conform Mode", Float ) = 1
		_ConformOffsetValue( "Conform Offset", Float ) = 0
		[Space(10)] _ConformMeshValue( "Conform Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _ConformMeshMode( "Conform Mesh Mask", Float ) = 3
		[StyledRemapSlider] _ConformMeshRemap( "Conform Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[StyledSpace(10)] _ConformEnd( "[ Conform End ]", Float ) = 1


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
				#define ASE_ABSOLUTE_VERTEX_POS 1
				#pragma multi_compile_instancing
				#define _SPECULAR_SETUP 1
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

				#define ASE_NEEDS_VERT_POSITION
				#define ASE_NEEDS_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_VERT_TANGENT
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_SCREEN_POSITION_NORMALIZED
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_COLOR
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
				#pragma shader_feature_local_fragment TVE_OVERLAY_ELEMENT
				#if defined (TVE_CLIPPING) //Render Clip
					#define TVE_ALPHA_CLIP //Render Clip
				#endif //Render Clip
				  
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
				#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY(tex,samplertex,coord) tex2DArray(tex,coord)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
				#endif//ASE Sampling Macros
				


				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					float4 texcoord : TEXCOORD0;
					float4 texcoord1 : TEXCOORD1;
					float4 texcoord2 : TEXCOORD2;
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_color : COLOR;
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
					float4 ase_color : COLOR;
					float4 ase_texcoord9 : TEXCOORD9;
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

				uniform half _IsTVEShader;
				uniform half TVE_DEBUG_Filter;
				uniform half TVE_DEBUG_Clip;
				uniform half TVE_DEBUG_Min;
				uniform half TVE_DEBUG_Max;
				uniform half TVE_DEBUG_Index;
				uniform half TVE_DEBUG_Shading;
				uniform half _ObjectCategory;
				uniform half _ObjectEnd;
				uniform half _ObjectModelMode;
				uniform half _ObjectPivotMode;
				uniform float3 TVE_WorldOrigin;
				uniform half _ObjectHeightValue;
				uniform half _ObjectRadiusValue;
				uniform half _ObjectPhaseMode;
				uniform float _IsShaderType;
				uniform half _ConformCategory;
				uniform half _ConformEnd;
				uniform half _ConformInfo;
				uniform half _GlobalCategory;
				uniform half _GlobalEnd;
				uniform half4 TVE_CoatParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatBaseTex);
				uniform float4 TVE_CoatBaseCoord;
				uniform half _GlobalCoatPivotValue;
				uniform half _GlobalCoatLayerValue;
				SamplerState sampler_Linear_Clamp;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatNearTex);
				uniform float4 TVE_CoatNearCoord;
				SamplerState sampler_Linear_Repeat;
				uniform float4 TVE_RenderNearPositionR;
				uniform half TVE_RenderNearFadeValue;
				uniform float TVE_CoatLayers[10];
				uniform half4 TVE_PaintParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintBaseTex);
				uniform float4 TVE_PaintBaseCoord;
				uniform half _GlobalPaintPivotValue;
				uniform half _GlobalPaintLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintNearTex);
				uniform float4 TVE_PaintNearCoord;
				uniform float TVE_PaintLayers[10];
				uniform half4 TVE_AtmoParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoBaseTex);
				uniform float4 TVE_AtmoBaseCoord;
				uniform half _GlobalAtmoPivotValue;
				uniform half _GlobalAtmoLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoNearTex);
				uniform float4 TVE_AtmoNearCoord;
				uniform float TVE_AtmoLayers[10];
				uniform half4 TVE_GlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowBaseTex);
				uniform float4 TVE_GlowBaseCoord;
				uniform half _GlobalGlowPivotValue;
				uniform half _GlobalGlowLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowNearTex);
				uniform float4 TVE_GlowNearCoord;
				uniform float TVE_GlowLayers[10];
				uniform half4 TVE_FormParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormBaseTex);
				uniform float4 TVE_FormBaseCoord;
				uniform half _GlobalFormPivotValue;
				uniform half _GlobalFormLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormNearTex);
				uniform float4 TVE_FormNearCoord;
				uniform float TVE_FormLayers[10];
				uniform half4 TVE_FlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowBaseTex);
				uniform float4 TVE_FlowBaseCoord;
				uniform half _GlobalFlowPivotValue;
				uniform half _GlobalFlowLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowNearTex);
				uniform float4 TVE_FlowNearCoord;
				uniform float TVE_FlowLayers[10];
				uniform half _ConformMode;
				uniform half _ConformOffsetValue;
				uniform half _ConformIntensityValue;
				uniform half _ConformMeshMode;
				uniform half4 _ConformMeshRemap;
				uniform half _ConformMeshValue;
				uniform half TVE_IsEnabled;
				uniform half _OverlayIntensityValue;
				uniform half _OverlayTextureMode;
				uniform half _OverlayGlitterIntensityValue;
				uniform half _OverlayElementMode;
				uniform half _MainCategory;
				uniform half _MainEnd;
				uniform half _MainSampleMode;
				uniform half _MainCoordMode;
				uniform half4 _MainCoordValue;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainAlbedoTex);
				SamplerState sampler_Linear_Repeat_Aniso8;
				SamplerState sampler_Point_Repeat;
				uniform half4 _main_coord_value;
				uniform half _MainAlbedoValue;
				uniform half4 _MainColorTwo;
				uniform half4 _MainColor;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainShaderTex);
				uniform half _MainMetallicValue;
				uniform half4 _MainOcclusionRemap;
				uniform half _MainOcclusionValue;
				uniform half4 _MainSmoothnessRemap;
				uniform half _MainSmoothnessValue;
				uniform half4 _MainMultiRemap;
				uniform half _MainColorMode;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainNormalTex);
				uniform half _MainNormalValue;
				uniform half _MainAlphaClipValue;
				uniform half4 _OverlayLumaRemap;
				uniform half _OverlayLumaValue;
				uniform half _OverlayMeshMode;
				uniform half4 _OverlayMeshRemap;
				uniform half _OverlayMeshValue;
				uniform half4 _OverlayProjRemap;
				uniform half _OverlayProjValue;
				uniform half4 _OverlayBlendRemap;
				uniform half _OverlayGlobalValue;
				uniform half TVE_DEBUG_Global;
				uniform float _RenderClip;
				uniform float _IsElementShader;
				uniform float _IsHelperShader;


				half CapsuleMaskYUp( half3 Position, half Height, half Radius )
				{
					    float3 a = float3(0, Height, 0);
					    float3 ba = -a;
					    float3 pa = Position - a;
					    
					    float baDot = dot(ba, ba);
					    float h = saturate(dot(pa, ba) / baDot);
					    
					    float3 q = pa - ba * h;
					    return length(q) / Radius;
				}
				
				half CapsuleMaskZUp( half3 Position, half Height, half Radius )
				{
					    float3 a = float3(0, 0, Height);
					    float3 ba = -a;
					    float3 pa = Position - a;
					    
					    float baDot = dot(ba, ba);
					    float h = saturate(dot(pa, ba) / baDot);
					    
					    float3 q = pa - ba * h;
					    return length(q) / Radius;
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
				
				void BuildModelVertData( inout TVEModelData Data, half In_Dummy, float3 In_PositionOS, float3 In_PositionWS, float3 In_PositionWO, float3 In_PositionRawOS, float3 In_PivotOS, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalOS, half3 In_NormalWS, half3 In_NormalRawOS, half4 In_TangentOS, half3 In_TangentWS, half3 In_BitangentWS, half3 In_ViewDirWS, float4 In_CoordsData, float4 In_VertexData, half4 In_MasksData, half4 In_PhaseData, half4 In_TransformData, half4 In_RotationData, float4 In_InterpolatorA )
				{
					Data.Dummy = In_Dummy;
					Data.PositionOS = In_PositionOS;
					Data.PositionWS = In_PositionWS;
					Data.PositionWO = In_PositionWO;
					Data.PositionRawOS = In_PositionRawOS;
					Data.PivotOS = In_PivotOS;
					Data.PivotWS = In_PivotWS;
					Data.PivotWO = In_PivotWO;
					Data.NormalOS = In_NormalOS;
					Data.NormalWS = In_NormalWS;
					Data.NormalRawOS = In_NormalRawOS;
					Data.TangentOS = In_TangentOS;
					Data.TangentWS = In_TangentWS;
					Data.BitangentWS = In_BitangentWS;
					Data.ViewDirWS = In_ViewDirWS;
					Data.CoordsData = In_CoordsData;
					Data.VertexData = In_VertexData;
					Data.MasksData = In_MasksData;
					Data.PhaseData = In_PhaseData;
					Data.TransformData = In_TransformData;
					Data.RotationData = In_RotationData;
					Data.InterpolatorA = In_InterpolatorA ;
					return;
				}
				
				void BreakModelVertData( inout TVEModelData Data, out half Out_Dummy, out half3 Out_PositionOS, out half3 Out_PositionWS, out half3 Out_PositionWO, out half3 Out_PositionRawOS, out half3 Out_PivotOS, out half3 Out_PivotWS, out half3 Out_PivotWO, out half3 Out_NormalOS, out half3 Out_NormalWS, out half3 Out_NormalRawOS, out half4 Out_TangentOS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_MasksData, out half4 Out_PhaseData, out half4 Out_TransformData, out half4 Out_RotationData, out half4 Out_InterpolatorA )
				{
					Out_Dummy = Data.Dummy;
					Out_PositionOS = Data.PositionOS;
					Out_PositionWS = Data.PositionWS;
					Out_PositionWO = Data.PositionWO;
					Out_PositionRawOS = Data.PositionRawOS;
					Out_PivotOS = Data.PivotOS;
					Out_PivotWS = Data.PivotWS;
					Out_PivotWO = Data.PivotWO;
					Out_NormalOS = Data.NormalOS;
					Out_NormalWS = Data.NormalWS;
					Out_NormalRawOS = Data.NormalRawOS;
					Out_TangentOS = Data.TangentOS;
					Out_TangentWS = Data.TangentWS;
					Out_BitangentWS = Data.BitangentWS;
					Out_ViewDirWS = Data.ViewDirWS;
					Out_CoordsData = Data.CoordsData;
					Out_VertexData = Data.VertexData;
					Out_MasksData = Data.MasksData;
					Out_PhaseData = Data.PhaseData;
					Out_TransformData = Data.TransformData;
					Out_RotationData = Data.RotationData;
					Out_InterpolatorA = Data.InterpolatorA;
					return;
				}
				
				half3 ComputeTriplanarWeights( half3 NormalWS )
				{
					half3 powNormal = abs( NormalWS );
					half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
					tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
					return tempWeights;
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
				
				void BuildGlobalData( out TVEGlobalData Data, half In_Dummy, half4 In_CoatParams, half4 In_CoatTexture, half4 In_PaintParams, half4 In_PaintTexture, half4 In_AtmoParams, half4 In_AtmoTexture, half4 In_GlowParams, half4 In_GlowTexture, float4 In_FormParams, float4 In_FormTexture, half4 In_FlowParams, float4 In_FlowTexture )
				{
					Data = (TVEGlobalData)0;
					Data.Dummy = In_Dummy;
					Data.CoatParams= In_CoatParams;
					Data.CoatTexture = In_CoatTexture;
					Data.PaintParams = In_PaintParams;
					Data.PaintTexture = In_PaintTexture;
					Data.AtmoParams= In_AtmoParams;
					Data.AtmoTexture= In_AtmoTexture;
					Data.GlowParams= In_GlowParams;
					Data.GlowTexture= In_GlowTexture;
					Data.FormParams= In_FormParams;
					Data.FormTexture= In_FormTexture;
					Data.FlowParams= In_FlowParams;
					Data.FlowTexture= In_FlowTexture;
					return;
				}
				
				void BreakData( inout TVEGlobalData Data, out half Out_Dummy, out half4 Out_CoatParams, out half4 Out_CoatTexture, out half4 Out_PaintParams, out half4 Out_PaintTexture, out half4 Out_AtmoParams, out half4 Out_AtmoTexture, out half4 Out_GlowParams, out half4 Out_GlowTexture, out float4 Out_FormParams, out float4 Out_FormTexture, out half4 Out_FlowParams, out half4 Out_FlowTexture )
				{
					Out_Dummy = Data.Dummy;
					Out_CoatParams = Data.CoatParams;
					Out_CoatTexture = Data.CoatTexture;
					Out_PaintParams = Data.PaintParams;
					Out_PaintTexture = Data.PaintTexture;
					Out_AtmoParams= Data.AtmoParams;
					Out_AtmoTexture= Data.AtmoTexture;
					Out_GlowParams= Data.GlowParams;
					Out_GlowTexture= Data.GlowTexture;
					Out_FormParams= Data.FormParams;
					Out_FormTexture = Data.FormTexture;
					Out_FlowParams = Data.FlowParams;
					Out_FlowTexture = Data.FlowTexture;
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
				
				half4 SampleCoord( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, half2 UV, half Bias, out half2 Normal )
				{
					half4 tex = SAMPLE_TEXTURE2D_BIAS( Texture, Sampler, UV, Bias);
					Normal = tex.wy * 2.0 - 1.0;
					return tex;
				}
				
				half4 SamplePlanar2D( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, float2 XZ, half Bias, half3 NormalWS, out half3 Normal )
				{
					half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
					half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
					normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
					Normal = normal_Y;
					return tex_Y;
				}
				
				half4 SamplePlanar3D( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, float2 ZY, float2 XZ, float2 XY, half Bias, half3 Triplanar, half3 NormalWS, out half3 Normal )
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
				
				half4 SampleStochastic2D( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, half Bias, half3 Weights_2, half3 NormalWS, out half3 Normal )
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
				
				half4 SampleStochastic3D( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, float2 ZY, float2 ZY_1, float2 ZY_2, float2 ZY_3, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, float2 XY, float2 XY_1, float2 XY_2, float2 XY_3, half Bias, half3 Weights_1, half3 Weights_2, half3 Weights_3, half3 Triplanar, half3 NormalWS, out half3 Normal )
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
				

				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float localIfModelDataByShader26_g251540 = ( 0.0 );
					TVEModelData Data26_g251540 = (TVEModelData)0;
					TVEModelData Data16_g241385 =(TVEModelData)0;
					half Dummy207_g241375 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g241385 = Dummy207_g241375;
					float In_Dummy16_g241385 = temp_output_14_0_g241385;
					float3 PositionOS131_g241375 = v.vertex.xyz;
					float3 temp_output_4_0_g241385 = PositionOS131_g241375;
					float3 In_PositionOS16_g241385 = temp_output_4_0_g241385;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g241375 = ase_positionWS;
					float3 vertexToFrag73_g241375 = temp_output_104_7_g241375;
					float3 PositionWS122_g241375 = vertexToFrag73_g241375;
					float3 In_PositionWS16_g241385 = PositionWS122_g241375;
					float4x4 break19_g241378 = unity_ObjectToWorld;
					float3 appendResult20_g241378 = (float3(break19_g241378[ 0 ][ 3 ] , break19_g241378[ 1 ][ 3 ] , break19_g241378[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241375 = appendResult20_g241378;
					float4x4 break19_g241380 = unity_ObjectToWorld;
					float3 appendResult20_g241380 = (float3(break19_g241380[ 0 ][ 3 ] , break19_g241380[ 1 ][ 3 ] , break19_g241380[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g241376 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g241375 = PositionOS131_g241375;
					float3 appendResult234_g241375 = (float3(break233_g241375.x , 0.0 , break233_g241375.z));
					float3 break413_g241375 = PositionOS131_g241375;
					float3 appendResult414_g241375 = (float3(break413_g241375.x , break413_g241375.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g241382 = appendResult414_g241375;
					#else
					float3 staticSwitch65_g241382 = appendResult234_g241375;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g241375 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g241375 = appendResult60_g241376;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g241375 = staticSwitch65_g241382;
					#else
					float3 staticSwitch229_g241375 = _Vector0;
					#endif
					float3 PivotOS149_g241375 = staticSwitch229_g241375;
					float3 temp_output_122_0_g241380 = PivotOS149_g241375;
					float3 PivotsOnlyWS105_g241380 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g241380 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g241375 = ( appendResult20_g241380 + PivotsOnlyWS105_g241380 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g241375 = temp_output_340_7_g241375;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g241375 = temp_output_341_7_g241375;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g241375 = temp_output_341_7_g241375;
					#else
					float3 staticSwitch236_g241375 = temp_output_340_7_g241375;
					#endif
					float3 vertexToFrag76_g241375 = staticSwitch236_g241375;
					float3 PivotWS121_g241375 = vertexToFrag76_g241375;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241375 = ( PositionWS122_g241375 - PivotWS121_g241375 );
					#else
					float3 staticSwitch204_g241375 = PositionWS122_g241375;
					#endif
					float3 PositionWO132_g241375 = ( staticSwitch204_g241375 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241385 = PositionWO132_g241375;
					float3 In_PositionRawOS16_g241385 = PositionOS131_g241375;
					float3 In_PivotOS16_g241385 = PivotOS149_g241375;
					float3 In_PivotWS16_g241385 = PivotWS121_g241375;
					float3 PivotWO133_g241375 = ( PivotWS121_g241375 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241385 = PivotWO133_g241375;
					half3 NormalOS134_g241375 = v.normal;
					float3 temp_output_21_0_g241385 = NormalOS134_g241375;
					float3 In_NormalOS16_g241385 = temp_output_21_0_g241385;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g241375 = normalizedWorldNormal;
					float3 In_NormalWS16_g241385 = NormalWS95_g241375;
					float3 In_NormalRawOS16_g241385 = NormalOS134_g241375;
					half4 TangentlOS153_g241375 = v.tangent;
					float4 temp_output_6_0_g241385 = TangentlOS153_g241375;
					float4 In_TangentOS16_g241385 = temp_output_6_0_g241385;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g241375 = ase_tangentWS;
					float3 In_TangentWS16_g241385 = TangentWS136_g241375;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g241375 = ase_bitangentWS;
					float3 In_BitangentWS16_g241385 = BiangentWS421_g241375;
					float3 normalizeResult296_g241375 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241375 ) );
					half3 ViewDirWS169_g241375 = normalizeResult296_g241375;
					float3 In_ViewDirWS16_g241385 = ViewDirWS169_g241375;
					float4 appendResult397_g241375 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g241375 = appendResult397_g241375;
					float4 In_CoordsData16_g241385 = CoordsData398_g241375;
					half4 VertexMasks171_g241375 = v.ase_color;
					float4 In_VertexData16_g241385 = VertexMasks171_g241375;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241388 = (PositionOS131_g241375).z;
					#else
					float staticSwitch65_g241388 = (PositionOS131_g241375).y;
					#endif
					half Object_HeightValue267_g241375 = _ObjectHeightValue;
					half Bounds_HeightMask274_g241375 = saturate( ( staticSwitch65_g241388 / Object_HeightValue267_g241375 ) );
					half3 Position387_g241375 = PositionOS131_g241375;
					half Height387_g241375 = Object_HeightValue267_g241375;
					half Object_RadiusValue268_g241375 = _ObjectRadiusValue;
					half Radius387_g241375 = Object_RadiusValue268_g241375;
					half localCapsuleMaskYUp387_g241375 = CapsuleMaskYUp( Position387_g241375 , Height387_g241375 , Radius387_g241375 );
					half3 Position408_g241375 = PositionOS131_g241375;
					half Height408_g241375 = Object_HeightValue267_g241375;
					half Radius408_g241375 = Object_RadiusValue268_g241375;
					half localCapsuleMaskZUp408_g241375 = CapsuleMaskZUp( Position408_g241375 , Height408_g241375 , Radius408_g241375 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241393 = saturate( localCapsuleMaskZUp408_g241375 );
					#else
					float staticSwitch65_g241393 = saturate( localCapsuleMaskYUp387_g241375 );
					#endif
					half Bounds_SphereMask282_g241375 = staticSwitch65_g241393;
					float4 appendResult253_g241375 = (float4(Bounds_HeightMask274_g241375 , Bounds_SphereMask282_g241375 , 1.0 , 1.0));
					half4 MasksData254_g241375 = appendResult253_g241375;
					float4 In_MasksData16_g241385 = MasksData254_g241375;
					float temp_output_17_0_g241387 = _ObjectPhaseMode;
					float Option70_g241387 = temp_output_17_0_g241387;
					float4 temp_output_3_0_g241387 = v.ase_color;
					float4 Channel70_g241387 = temp_output_3_0_g241387;
					float localSwitchChannel470_g241387 = SwitchChannel4( Option70_g241387 , Channel70_g241387 );
					half Phase_Value372_g241375 = localSwitchChannel470_g241387;
					float3 break319_g241375 = PivotWO133_g241375;
					half Pivot_Position322_g241375 = ( break319_g241375.x + break319_g241375.z );
					half Phase_Position357_g241375 = ( Phase_Value372_g241375 + Pivot_Position322_g241375 );
					float temp_output_248_0_g241375 = frac( Phase_Position357_g241375 );
					float4 appendResult177_g241375 = (float4(( (frac( ( Phase_Position357_g241375 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g241375));
					half4 Phase_Data176_g241375 = appendResult177_g241375;
					float4 In_PhaseData16_g241385 = Phase_Data176_g241375;
					float4 In_TransformData16_g241385 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g241385 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g241385 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g241385 , In_Dummy16_g241385 , In_PositionOS16_g241385 , In_PositionWS16_g241385 , In_PositionWO16_g241385 , In_PositionRawOS16_g241385 , In_PivotOS16_g241385 , In_PivotWS16_g241385 , In_PivotWO16_g241385 , In_NormalOS16_g241385 , In_NormalWS16_g241385 , In_NormalRawOS16_g241385 , In_TangentOS16_g241385 , In_TangentWS16_g241385 , In_BitangentWS16_g241385 , In_ViewDirWS16_g241385 , In_CoordsData16_g241385 , In_VertexData16_g241385 , In_MasksData16_g241385 , In_PhaseData16_g241385 , In_TransformData16_g241385 , In_RotationData16_g241385 , In_InterpolatorA16_g241385 );
					TVEModelData DataDefault26_g251540 = Data16_g241385;
					TVEModelData DataGeneral26_g251540 = Data16_g241385;
					TVEModelData DataBlanket26_g251540 = Data16_g241385;
					TVEModelData DataImpostor26_g251540 = Data16_g241385;
					TVEModelData Data16_g241365 =(TVEModelData)0;
					half Dummy207_g241355 = 0.0;
					float temp_output_14_0_g241365 = Dummy207_g241355;
					float In_Dummy16_g241365 = temp_output_14_0_g241365;
					float3 PositionOS131_g241355 = v.vertex.xyz;
					float3 temp_output_4_0_g241365 = PositionOS131_g241355;
					float3 In_PositionOS16_g241365 = temp_output_4_0_g241365;
					float3 temp_output_104_7_g241355 = ase_positionWS;
					float3 PositionWS122_g241355 = temp_output_104_7_g241355;
					float3 In_PositionWS16_g241365 = PositionWS122_g241355;
					float4x4 break19_g241358 = unity_ObjectToWorld;
					float3 appendResult20_g241358 = (float3(break19_g241358[ 0 ][ 3 ] , break19_g241358[ 1 ][ 3 ] , break19_g241358[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241355 = appendResult20_g241358;
					float3 PivotWS121_g241355 = temp_output_340_7_g241355;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241355 = ( PositionWS122_g241355 - PivotWS121_g241355 );
					#else
					float3 staticSwitch204_g241355 = PositionWS122_g241355;
					#endif
					float3 PositionWO132_g241355 = ( staticSwitch204_g241355 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241365 = PositionWO132_g241355;
					float3 In_PositionRawOS16_g241365 = PositionOS131_g241355;
					float3 PivotOS149_g241355 = _Vector0;
					float3 In_PivotOS16_g241365 = PivotOS149_g241355;
					float3 In_PivotWS16_g241365 = PivotWS121_g241355;
					float3 PivotWO133_g241355 = ( PivotWS121_g241355 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241365 = PivotWO133_g241355;
					half3 NormalOS134_g241355 = v.normal;
					float3 temp_output_21_0_g241365 = NormalOS134_g241355;
					float3 In_NormalOS16_g241365 = temp_output_21_0_g241365;
					half3 NormalWS95_g241355 = normalizedWorldNormal;
					float3 In_NormalWS16_g241365 = NormalWS95_g241355;
					float3 In_NormalRawOS16_g241365 = NormalOS134_g241355;
					half4 TangentlOS153_g241355 = v.tangent;
					float4 temp_output_6_0_g241365 = TangentlOS153_g241355;
					float4 In_TangentOS16_g241365 = temp_output_6_0_g241365;
					half3 TangentWS136_g241355 = ase_tangentWS;
					float3 In_TangentWS16_g241365 = TangentWS136_g241355;
					half3 BiangentWS421_g241355 = ase_bitangentWS;
					float3 In_BitangentWS16_g241365 = BiangentWS421_g241355;
					float3 normalizeResult296_g241355 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241355 ) );
					half3 ViewDirWS169_g241355 = normalizeResult296_g241355;
					float3 In_ViewDirWS16_g241365 = ViewDirWS169_g241355;
					float4 appendResult397_g241355 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g241355 = appendResult397_g241355;
					float4 In_CoordsData16_g241365 = CoordsData398_g241355;
					half4 VertexMasks171_g241355 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241365 = VertexMasks171_g241355;
					half4 MasksData254_g241355 = float4( 0,0,0,0 );
					float4 In_MasksData16_g241365 = MasksData254_g241355;
					half4 Phase_Data176_g241355 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241365 = Phase_Data176_g241355;
					float4 In_TransformData16_g241365 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g241365 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g241365 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g241365 , In_Dummy16_g241365 , In_PositionOS16_g241365 , In_PositionWS16_g241365 , In_PositionWO16_g241365 , In_PositionRawOS16_g241365 , In_PivotOS16_g241365 , In_PivotWS16_g241365 , In_PivotWO16_g241365 , In_NormalOS16_g241365 , In_NormalWS16_g241365 , In_NormalRawOS16_g241365 , In_TangentOS16_g241365 , In_TangentWS16_g241365 , In_BitangentWS16_g241365 , In_ViewDirWS16_g241365 , In_CoordsData16_g241365 , In_VertexData16_g241365 , In_MasksData16_g241365 , In_PhaseData16_g241365 , In_TransformData16_g241365 , In_RotationData16_g241365 , In_InterpolatorA16_g241365 );
					TVEModelData DataTerrain26_g251540 = Data16_g241365;
					half IsShaderType2672 = _IsShaderType;
					float Type26_g251540 = IsShaderType2672;
					{
					if (Type26_g251540 == 0 )
					{
					Data26_g251540 = DataDefault26_g251540;
					}
					else if (Type26_g251540 == 1 )
					{
					Data26_g251540 = DataGeneral26_g251540;
					}
					else if (Type26_g251540 == 2 )
					{
					Data26_g251540 = DataBlanket26_g251540;
					}
					else if (Type26_g251540 == 3 )
					{
					Data26_g251540 = DataImpostor26_g251540;
					}
					else if (Type26_g251540 == 4 )
					{
					Data26_g251540 = DataTerrain26_g251540;
					}
					}
					TVEModelData Data15_g251552 =(TVEModelData)Data26_g251540;
					float Out_Dummy15_g251552 = 0.0;
					float3 Out_PositionOS15_g251552 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251552 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251552 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251552 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251552 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251552 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251552 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251552 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251552 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251552 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251552 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251552 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251552 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251552 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251552 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251552 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251552 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251552 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251552 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251552 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251552 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251552 , Out_Dummy15_g251552 , Out_PositionOS15_g251552 , Out_PositionWS15_g251552 , Out_PositionWO15_g251552 , Out_PositionRawOS15_g251552 , Out_PivotOS15_g251552 , Out_PivotWS15_g251552 , Out_PivotWO15_g251552 , Out_NormalOS15_g251552 , Out_NormalWS15_g251552 , Out_NormalRawOS15_g251552 , Out_TangentOS15_g251552 , Out_TangentWS15_g251552 , Out_BitangentWS15_g251552 , Out_ViewDirWS15_g251552 , Out_CoordsData15_g251552 , Out_VertexData15_g251552 , Out_MasksData15_g251552 , Out_PhaseData15_g251552 , Out_TransformData15_g251552 , Out_RotationData15_g251552 , Out_InterpolatorA15_g251552 );
					TVEModelData Data16_g251554 =(TVEModelData)Data15_g251552;
					float temp_output_14_0_g251554 = 0.0;
					float In_Dummy16_g251554 = temp_output_14_0_g251554;
					float3 temp_output_219_24_g251551 = Out_PivotOS15_g251552;
					float3 temp_output_215_0_g251551 = ( Out_PositionOS15_g251552 - temp_output_219_24_g251551 );
					float3 temp_output_4_0_g251554 = temp_output_215_0_g251551;
					float3 In_PositionOS16_g251554 = temp_output_4_0_g251554;
					float3 In_PositionWS16_g251554 = Out_PositionWS15_g251552;
					float3 In_PositionWO16_g251554 = Out_PositionWO15_g251552;
					float3 In_PositionRawOS16_g251554 = Out_PositionRawOS15_g251552;
					float3 In_PivotOS16_g251554 = temp_output_219_24_g251551;
					float3 In_PivotWS16_g251554 = Out_PivotWS15_g251552;
					float3 In_PivotWO16_g251554 = Out_PivotWO15_g251552;
					float3 temp_output_21_0_g251554 = Out_NormalOS15_g251552;
					float3 In_NormalOS16_g251554 = temp_output_21_0_g251554;
					float3 In_NormalWS16_g251554 = Out_NormalWS15_g251552;
					float3 In_NormalRawOS16_g251554 = Out_NormalRawOS15_g251552;
					float4 temp_output_6_0_g251554 = Out_TangentOS15_g251552;
					float4 In_TangentOS16_g251554 = temp_output_6_0_g251554;
					float3 In_TangentWS16_g251554 = Out_TangentWS15_g251552;
					float3 In_BitangentWS16_g251554 = Out_BitangentWS15_g251552;
					float3 In_ViewDirWS16_g251554 = Out_ViewDirWS15_g251552;
					float4 In_CoordsData16_g251554 = Out_CoordsData15_g251552;
					float4 In_VertexData16_g251554 = Out_VertexData15_g251552;
					float4 In_MasksData16_g251554 = Out_MasksData15_g251552;
					float4 In_PhaseData16_g251554 = Out_PhaseData15_g251552;
					float4 In_TransformData16_g251554 = Out_TransformData15_g251552;
					float4 In_RotationData16_g251554 = Out_RotationData15_g251552;
					float4 In_InterpolatorA16_g251554 = Out_InterpolatorA15_g251552;
					BuildModelVertData( Data16_g251554 , In_Dummy16_g251554 , In_PositionOS16_g251554 , In_PositionWS16_g251554 , In_PositionWO16_g251554 , In_PositionRawOS16_g251554 , In_PivotOS16_g251554 , In_PivotWS16_g251554 , In_PivotWO16_g251554 , In_NormalOS16_g251554 , In_NormalWS16_g251554 , In_NormalRawOS16_g251554 , In_TangentOS16_g251554 , In_TangentWS16_g251554 , In_BitangentWS16_g251554 , In_ViewDirWS16_g251554 , In_CoordsData16_g251554 , In_VertexData16_g251554 , In_MasksData16_g251554 , In_PhaseData16_g251554 , In_TransformData16_g251554 , In_RotationData16_g251554 , In_InterpolatorA16_g251554 );
					TVEModelData Data15_g251556 =(TVEModelData)Data16_g251554;
					float Out_Dummy15_g251556 = 0.0;
					float3 Out_PositionOS15_g251556 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251556 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251556 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251556 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251556 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251556 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251556 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251556 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251556 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251556 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251556 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251556 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251556 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251556 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251556 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251556 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251556 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251556 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251556 , Out_Dummy15_g251556 , Out_PositionOS15_g251556 , Out_PositionWS15_g251556 , Out_PositionWO15_g251556 , Out_PositionRawOS15_g251556 , Out_PivotOS15_g251556 , Out_PivotWS15_g251556 , Out_PivotWO15_g251556 , Out_NormalOS15_g251556 , Out_NormalWS15_g251556 , Out_NormalRawOS15_g251556 , Out_TangentOS15_g251556 , Out_TangentWS15_g251556 , Out_BitangentWS15_g251556 , Out_ViewDirWS15_g251556 , Out_CoordsData15_g251556 , Out_VertexData15_g251556 , Out_MasksData15_g251556 , Out_PhaseData15_g251556 , Out_TransformData15_g251556 , Out_RotationData15_g251556 , Out_InterpolatorA15_g251556 );
					TVEModelData Data16_g251557 =(TVEModelData)Data15_g251556;
					half Dummy317_g251555 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g251557 = Dummy317_g251555;
					float In_Dummy16_g251557 = temp_output_14_0_g251557;
					float3 temp_output_4_0_g251557 = Out_PositionOS15_g251556;
					float3 In_PositionOS16_g251557 = temp_output_4_0_g251557;
					float3 In_PositionWS16_g251557 = Out_PositionWS15_g251556;
					float3 temp_output_314_17_g251555 = Out_PositionWO15_g251556;
					float3 In_PositionWO16_g251557 = temp_output_314_17_g251555;
					float3 In_PositionRawOS16_g251557 = Out_PositionRawOS15_g251556;
					float3 In_PivotOS16_g251557 = Out_PivotOS15_g251556;
					float3 In_PivotWS16_g251557 = Out_PivotWS15_g251556;
					float3 temp_output_314_19_g251555 = Out_PivotWO15_g251556;
					float3 In_PivotWO16_g251557 = temp_output_314_19_g251555;
					float3 temp_output_21_0_g251557 = Out_NormalOS15_g251556;
					float3 In_NormalOS16_g251557 = temp_output_21_0_g251557;
					float3 In_NormalWS16_g251557 = Out_NormalWS15_g251556;
					float3 In_NormalRawOS16_g251557 = Out_NormalRawOS15_g251556;
					float4 temp_output_6_0_g251557 = Out_TangentOS15_g251556;
					float4 In_TangentOS16_g251557 = temp_output_6_0_g251557;
					float3 In_TangentWS16_g251557 = Out_TangentWS15_g251556;
					float3 In_BitangentWS16_g251557 = Out_BitangentWS15_g251556;
					float3 In_ViewDirWS16_g251557 = Out_ViewDirWS15_g251556;
					float4 In_CoordsData16_g251557 = Out_CoordsData15_g251556;
					float4 temp_output_314_29_g251555 = Out_VertexData15_g251556;
					float4 In_VertexData16_g251557 = temp_output_314_29_g251555;
					float4 In_MasksData16_g251557 = Out_MasksData15_g251556;
					float4 In_PhaseData16_g251557 = Out_PhaseData15_g251556;
					half4 Model_TransformData356_g251555 = Out_TransformData15_g251556;
					float localBuildGlobalData204_g251357 = ( 0.0 );
					TVEGlobalData Data204_g251357 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251357 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251357 = Dummy211_g251357;
					float4 temp_output_589_164_g251357 = TVE_CoatParams;
					half4 Coat_Params596_g251357 = temp_output_589_164_g251357;
					float4 In_CoatParams204_g251357 = Coat_Params596_g251357;
					float4 temp_output_203_0_g251377 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g241395 = ( 0.0 );
					TVEModelData Data26_g241395 = (TVEModelData)0;
					TVEModelData Data16_g241383 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241383 = 0.0;
					float3 In_PositionWS16_g241383 = PositionWS122_g241375;
					float3 In_PositionWO16_g241383 = PositionWO132_g241375;
					float3 In_PivotWS16_g241383 = PivotWS121_g241375;
					float3 In_PivotWO16_g241383 = PivotWO133_g241375;
					float3 In_NormalWS16_g241383 = NormalWS95_g241375;
					float3 In_TangentWS16_g241383 = TangentWS136_g241375;
					float3 In_BitangentWS16_g241383 = BiangentWS421_g241375;
					half3 NormalWS427_g241375 = NormalWS95_g241375;
					half3 localComputeTriplanarWeights427_g241375 = ComputeTriplanarWeights( NormalWS427_g241375 );
					half3 TriplanarWeights429_g241375 = localComputeTriplanarWeights427_g241375;
					float3 In_TriplanarWeights16_g241383 = TriplanarWeights429_g241375;
					float3 In_ViewDirWS16_g241383 = ViewDirWS169_g241375;
					float4 In_CoordsData16_g241383 = CoordsData398_g241375;
					float4 In_VertexData16_g241383 = VertexMasks171_g241375;
					float4 In_PhaseData16_g241383 = Phase_Data176_g241375;
					BuildModelFragData( Data16_g241383 , In_Dummy16_g241383 , In_PositionWS16_g241383 , In_PositionWO16_g241383 , In_PivotWS16_g241383 , In_PivotWO16_g241383 , In_NormalWS16_g241383 , In_TangentWS16_g241383 , In_BitangentWS16_g241383 , In_TriplanarWeights16_g241383 , In_ViewDirWS16_g241383 , In_CoordsData16_g241383 , In_VertexData16_g241383 , In_PhaseData16_g241383 );
					TVEModelData DataDefault26_g241395 = Data16_g241383;
					TVEModelData DataGeneral26_g241395 = Data16_g241383;
					TVEModelData DataBlanket26_g241395 = Data16_g241383;
					TVEModelData DataImpostor26_g241395 = Data16_g241383;
					TVEModelData Data16_g241363 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241363 = 0.0;
					float3 In_PositionWS16_g241363 = PositionWS122_g241355;
					float3 In_PositionWO16_g241363 = PositionWO132_g241355;
					float3 In_PivotWS16_g241363 = PivotWS121_g241355;
					float3 In_PivotWO16_g241363 = PivotWO133_g241355;
					float3 In_NormalWS16_g241363 = NormalWS95_g241355;
					float3 In_TangentWS16_g241363 = TangentWS136_g241355;
					float3 In_BitangentWS16_g241363 = BiangentWS421_g241355;
					half3 NormalWS427_g241355 = NormalWS95_g241355;
					half3 localComputeTriplanarWeights427_g241355 = ComputeTriplanarWeights( NormalWS427_g241355 );
					half3 TriplanarWeights429_g241355 = localComputeTriplanarWeights427_g241355;
					float3 In_TriplanarWeights16_g241363 = TriplanarWeights429_g241355;
					float3 In_ViewDirWS16_g241363 = ViewDirWS169_g241355;
					float4 In_CoordsData16_g241363 = CoordsData398_g241355;
					float4 In_VertexData16_g241363 = VertexMasks171_g241355;
					float4 In_PhaseData16_g241363 = Phase_Data176_g241355;
					BuildModelFragData( Data16_g241363 , In_Dummy16_g241363 , In_PositionWS16_g241363 , In_PositionWO16_g241363 , In_PivotWS16_g241363 , In_PivotWO16_g241363 , In_NormalWS16_g241363 , In_TangentWS16_g241363 , In_BitangentWS16_g241363 , In_TriplanarWeights16_g241363 , In_ViewDirWS16_g241363 , In_CoordsData16_g241363 , In_VertexData16_g241363 , In_PhaseData16_g241363 );
					TVEModelData DataTerrain26_g241395 = Data16_g241363;
					float Type26_g241395 = IsShaderType2672;
					{
					if (Type26_g241395 == 0 )
					{
					Data26_g241395 = DataDefault26_g241395;
					}
					else if (Type26_g241395 == 1 )
					{
					Data26_g241395 = DataGeneral26_g241395;
					}
					else if (Type26_g241395 == 2 )
					{
					Data26_g241395 = DataBlanket26_g241395;
					}
					else if (Type26_g241395 == 3 )
					{
					Data26_g241395 = DataImpostor26_g241395;
					}
					else if (Type26_g241395 == 4 )
					{
					Data26_g241395 = DataTerrain26_g241395;
					}
					}
					TVEModelData Data15_g251433 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g251433 = 0.0;
					float3 Out_PositionWS15_g251433 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251433 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251433 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251433 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251433 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251433 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251433 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251433 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251433 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251433 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251433 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251433 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251433 , Out_Dummy15_g251433 , Out_PositionWS15_g251433 , Out_PositionWO15_g251433 , Out_PivotWS15_g251433 , Out_PivotWO15_g251433 , Out_NormalWS15_g251433 , Out_TangentWS15_g251433 , Out_BitangentWS15_g251433 , Out_TriplanarWeights15_g251433 , Out_ViewDirWS15_g251433 , Out_CoordsData15_g251433 , Out_VertexData15_g251433 , Out_PhaseData15_g251433 );
					float3 Model_PositionWS497_g251357 = Out_PositionWS15_g251433;
					float2 Model_PositionWS_XZ143_g251357 = (Model_PositionWS497_g251357).xz;
					float3 Model_PivotWS498_g251357 = Out_PivotWS15_g251433;
					float2 Model_PivotWS_XZ145_g251357 = (Model_PivotWS498_g251357).xz;
					float2 lerpResult300_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251377 = lerpResult300_g251357;
					float temp_output_82_0_g251375 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251377 = temp_output_82_0_g251375;
					float4 tex2DArrayNode83_g251377 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251377).zw + ( (temp_output_203_0_g251377).xy * temp_output_81_0_g251377 ) ),temp_output_82_0_g251377), 0.0 );
					float4 appendResult210_g251377 = (float4(tex2DArrayNode83_g251377.rgb , saturate( tex2DArrayNode83_g251377.a )));
					float4 temp_output_204_0_g251377 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251377 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251377).zw + ( (temp_output_204_0_g251377).xy * temp_output_81_0_g251377 ) ),temp_output_82_0_g251377), 0.0 );
					float4 appendResult212_g251377 = (float4(tex2DArrayNode122_g251377.rgb , saturate( tex2DArrayNode122_g251377.a )));
					float4 TVE_RenderNearPositionR628_g251357 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251357 = saturate( ( distance( Model_PositionWS497_g251357 , (TVE_RenderNearPositionR628_g251357).xyz ) / (TVE_RenderNearPositionR628_g251357).w ) );
					float temp_output_7_0_g251358 = 1.0;
					float temp_output_9_0_g251358 = ( temp_output_507_0_g251357 - temp_output_7_0_g251358 );
					half TVE_RenderNearFadeValue635_g251357 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251357 = saturate( ( temp_output_9_0_g251358 / ( ( TVE_RenderNearFadeValue635_g251357 - temp_output_7_0_g251358 ) + 0.0001 ) ) );
					float4 lerpResult131_g251377 = lerp( appendResult210_g251377 , appendResult212_g251377 , Global_TexBlend509_g251357);
					float4 temp_output_159_109_g251375 = lerpResult131_g251377;
					float4 lerpResult168_g251375 = lerp( TVE_CoatParams , temp_output_159_109_g251375 , TVE_CoatLayers[(int)temp_output_82_0_g251375]);
					float4 temp_output_589_109_g251357 = lerpResult168_g251375;
					half4 Coat_Texture302_g251357 = temp_output_589_109_g251357;
					float4 In_CoatTexture204_g251357 = Coat_Texture302_g251357;
					float4 temp_output_595_164_g251357 = TVE_PaintParams;
					half4 Paint_Params575_g251357 = temp_output_595_164_g251357;
					float4 In_PaintParams204_g251357 = Paint_Params575_g251357;
					float4 temp_output_203_0_g251426 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251426 = lerpResult85_g251357;
					float temp_output_82_0_g251423 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251426 = temp_output_82_0_g251423;
					float4 tex2DArrayNode83_g251426 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251426).zw + ( (temp_output_203_0_g251426).xy * temp_output_81_0_g251426 ) ),temp_output_82_0_g251426), 0.0 );
					float4 appendResult210_g251426 = (float4(tex2DArrayNode83_g251426.rgb , saturate( tex2DArrayNode83_g251426.a )));
					float4 temp_output_204_0_g251426 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251426 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251426).zw + ( (temp_output_204_0_g251426).xy * temp_output_81_0_g251426 ) ),temp_output_82_0_g251426), 0.0 );
					float4 appendResult212_g251426 = (float4(tex2DArrayNode122_g251426.rgb , saturate( tex2DArrayNode122_g251426.a )));
					float4 lerpResult131_g251426 = lerp( appendResult210_g251426 , appendResult212_g251426 , Global_TexBlend509_g251357);
					float4 temp_output_171_109_g251423 = lerpResult131_g251426;
					float4 lerpResult174_g251423 = lerp( TVE_PaintParams , temp_output_171_109_g251423 , TVE_PaintLayers[(int)temp_output_82_0_g251423]);
					float4 temp_output_595_109_g251357 = lerpResult174_g251423;
					half4 Paint_Texture71_g251357 = temp_output_595_109_g251357;
					float4 In_PaintTexture204_g251357 = Paint_Texture71_g251357;
					float4 temp_output_590_141_g251357 = TVE_AtmoParams;
					half4 Atmo_Params601_g251357 = temp_output_590_141_g251357;
					float4 In_AtmoParams204_g251357 = Atmo_Params601_g251357;
					float4 temp_output_203_0_g251385 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251385 = lerpResult104_g251357;
					float temp_output_132_0_g251383 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251385 = temp_output_132_0_g251383;
					float4 tex2DArrayNode83_g251385 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251385).zw + ( (temp_output_203_0_g251385).xy * temp_output_81_0_g251385 ) ),temp_output_82_0_g251385), 0.0 );
					float4 appendResult210_g251385 = (float4(tex2DArrayNode83_g251385.rgb , saturate( tex2DArrayNode83_g251385.a )));
					float4 temp_output_204_0_g251385 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251385 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251385).zw + ( (temp_output_204_0_g251385).xy * temp_output_81_0_g251385 ) ),temp_output_82_0_g251385), 0.0 );
					float4 appendResult212_g251385 = (float4(tex2DArrayNode122_g251385.rgb , saturate( tex2DArrayNode122_g251385.a )));
					float4 lerpResult131_g251385 = lerp( appendResult210_g251385 , appendResult212_g251385 , Global_TexBlend509_g251357);
					float4 temp_output_137_109_g251383 = lerpResult131_g251385;
					float4 lerpResult145_g251383 = lerp( TVE_AtmoParams , temp_output_137_109_g251383 , TVE_AtmoLayers[(int)temp_output_132_0_g251383]);
					float4 temp_output_590_110_g251357 = lerpResult145_g251383;
					half4 Atmo_Texture80_g251357 = temp_output_590_110_g251357;
					float4 In_AtmoTexture204_g251357 = Atmo_Texture80_g251357;
					float4 temp_output_593_163_g251357 = TVE_GlowParams;
					half4 Glow_Params609_g251357 = temp_output_593_163_g251357;
					float4 In_GlowParams204_g251357 = Glow_Params609_g251357;
					float4 temp_output_203_0_g251401 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251401 = lerpResult247_g251357;
					float temp_output_82_0_g251399 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251401 = temp_output_82_0_g251399;
					float4 tex2DArrayNode83_g251401 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251401).zw + ( (temp_output_203_0_g251401).xy * temp_output_81_0_g251401 ) ),temp_output_82_0_g251401), 0.0 );
					float4 appendResult210_g251401 = (float4(tex2DArrayNode83_g251401.rgb , saturate( tex2DArrayNode83_g251401.a )));
					float4 temp_output_204_0_g251401 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251401 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251401).zw + ( (temp_output_204_0_g251401).xy * temp_output_81_0_g251401 ) ),temp_output_82_0_g251401), 0.0 );
					float4 appendResult212_g251401 = (float4(tex2DArrayNode122_g251401.rgb , saturate( tex2DArrayNode122_g251401.a )));
					float4 lerpResult131_g251401 = lerp( appendResult210_g251401 , appendResult212_g251401 , Global_TexBlend509_g251357);
					float4 temp_output_159_109_g251399 = lerpResult131_g251401;
					float4 lerpResult167_g251399 = lerp( TVE_GlowParams , temp_output_159_109_g251399 , TVE_GlowLayers[(int)temp_output_82_0_g251399]);
					float4 temp_output_593_109_g251357 = lerpResult167_g251399;
					half4 Glow_Texture248_g251357 = temp_output_593_109_g251357;
					float4 In_GlowTexture204_g251357 = Glow_Texture248_g251357;
					float4 temp_output_592_139_g251357 = TVE_FormParams;
					float4 Form_Params606_g251357 = temp_output_592_139_g251357;
					float4 In_FormParams204_g251357 = Form_Params606_g251357;
					float4 temp_output_203_0_g251417 = TVE_FormBaseCoord;
					float2 lerpResult168_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251417 = lerpResult168_g251357;
					float temp_output_130_0_g251415 = _GlobalFormLayerValue;
					float temp_output_82_0_g251417 = temp_output_130_0_g251415;
					float4 tex2DArrayNode83_g251417 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251417).zw + ( (temp_output_203_0_g251417).xy * temp_output_81_0_g251417 ) ),temp_output_82_0_g251417), 0.0 );
					float4 appendResult210_g251417 = (float4(tex2DArrayNode83_g251417.rgb , saturate( tex2DArrayNode83_g251417.a )));
					float4 temp_output_204_0_g251417 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251417 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251417).zw + ( (temp_output_204_0_g251417).xy * temp_output_81_0_g251417 ) ),temp_output_82_0_g251417), 0.0 );
					float4 appendResult212_g251417 = (float4(tex2DArrayNode122_g251417.rgb , saturate( tex2DArrayNode122_g251417.a )));
					float4 lerpResult131_g251417 = lerp( appendResult210_g251417 , appendResult212_g251417 , Global_TexBlend509_g251357);
					float4 temp_output_135_109_g251415 = lerpResult131_g251417;
					float4 lerpResult143_g251415 = lerp( TVE_FormParams , temp_output_135_109_g251415 , TVE_FormLayers[(int)temp_output_130_0_g251415]);
					float4 temp_output_592_0_g251357 = lerpResult143_g251415;
					float4 Form_Texture112_g251357 = temp_output_592_0_g251357;
					float4 In_FormTexture204_g251357 = Form_Texture112_g251357;
					float4 temp_output_594_145_g251357 = TVE_FlowParams;
					half4 Flow_Params612_g251357 = temp_output_594_145_g251357;
					float4 In_FlowParams204_g251357 = Flow_Params612_g251357;
					float4 temp_output_203_0_g251409 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251409 = lerpResult400_g251357;
					float temp_output_136_0_g251407 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251409 = temp_output_136_0_g251407;
					float4 tex2DArrayNode83_g251409 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251409).zw + ( (temp_output_203_0_g251409).xy * temp_output_81_0_g251409 ) ),temp_output_82_0_g251409), 0.0 );
					float4 appendResult210_g251409 = (float4(tex2DArrayNode83_g251409.rgb , saturate( tex2DArrayNode83_g251409.a )));
					float4 temp_output_204_0_g251409 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251409 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251409).zw + ( (temp_output_204_0_g251409).xy * temp_output_81_0_g251409 ) ),temp_output_82_0_g251409), 0.0 );
					float4 appendResult212_g251409 = (float4(tex2DArrayNode122_g251409.rgb , saturate( tex2DArrayNode122_g251409.a )));
					float4 lerpResult131_g251409 = lerp( appendResult210_g251409 , appendResult212_g251409 , Global_TexBlend509_g251357);
					float4 temp_output_141_109_g251407 = lerpResult131_g251409;
					float4 lerpResult149_g251407 = lerp( TVE_FlowParams , temp_output_141_109_g251407 , TVE_FlowLayers[(int)temp_output_136_0_g251407]);
					half4 Flow_Texture405_g251357 = lerpResult149_g251407;
					float4 In_FlowTexture204_g251357 = Flow_Texture405_g251357;
					BuildGlobalData( Data204_g251357 , In_Dummy204_g251357 , In_CoatParams204_g251357 , In_CoatTexture204_g251357 , In_PaintParams204_g251357 , In_PaintTexture204_g251357 , In_AtmoParams204_g251357 , In_AtmoTexture204_g251357 , In_GlowParams204_g251357 , In_GlowTexture204_g251357 , In_FormParams204_g251357 , In_FormTexture204_g251357 , In_FlowParams204_g251357 , In_FlowTexture204_g251357 );
					TVEGlobalData Data15_g251558 =(TVEGlobalData)Data204_g251357;
					float Out_Dummy15_g251558 = 0.0;
					float4 Out_CoatParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251558 = float4( 0,0,0,0 );
					BreakData( Data15_g251558 , Out_Dummy15_g251558 , Out_CoatParams15_g251558 , Out_CoatTexture15_g251558 , Out_PaintParams15_g251558 , Out_PaintTexture15_g251558 , Out_AtmoParams15_g251558 , Out_AtmoTexture15_g251558 , Out_GlowParams15_g251558 , Out_GlowTexture15_g251558 , Out_FormParams15_g251558 , Out_FormTexture15_g251558 , Out_FlowParams15_g251558 , Out_FlowTexture15_g251558 );
					float4 Global_FormTexture351_g251555 = Out_FormTexture15_g251558;
					float3 Model_PivotWO353_g251555 = temp_output_314_19_g251555;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251564 = _ConformMeshMode;
					float Option70_g251564 = temp_output_17_0_g251564;
					half4 Model_VertexData357_g251555 = temp_output_314_29_g251555;
					float4 temp_output_3_0_g251564 = Model_VertexData357_g251555;
					float4 Channel70_g251564 = temp_output_3_0_g251564;
					float localSwitchChannel470_g251564 = SwitchChannel4( Option70_g251564 , Channel70_g251564 );
					float temp_output_390_0_g251555 = localSwitchChannel470_g251564;
					float temp_output_7_0_g251561 = _ConformMeshRemap.x;
					float temp_output_9_0_g251561 = ( temp_output_390_0_g251555 - temp_output_7_0_g251561 );
					float lerpResult374_g251555 = lerp( 1.0 , saturate( ( temp_output_9_0_g251561 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251555 = lerpResult374_g251555;
					float temp_output_328_0_g251555 = ( Blend_VertMask379_g251555 * TVE_IsEnabled );
					half Conform_Mask366_g251555 = temp_output_328_0_g251555;
					float temp_output_322_0_g251555 = ( ( ( ( (Global_FormTexture351_g251555).z - ( (Model_PivotWO353_g251555).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251555 ) );
					float3 appendResult329_g251555 = (float3(0.0 , temp_output_322_0_g251555 , 0.0));
					float3 appendResult387_g251555 = (float3(0.0 , 0.0 , temp_output_322_0_g251555));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251562 = appendResult387_g251555;
					#else
					float3 staticSwitch65_g251562 = appendResult329_g251555;
					#endif
					float3 Blanket_Conform368_g251555 = staticSwitch65_g251562;
					float4 appendResult312_g251555 = (float4(Blanket_Conform368_g251555 , 0.0));
					float4 temp_output_310_0_g251555 = ( Model_TransformData356_g251555 + appendResult312_g251555 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251555 = temp_output_310_0_g251555;
					#else
					float4 staticSwitch364_g251555 = Model_TransformData356_g251555;
					#endif
					half4 Final_TransformData365_g251555 = staticSwitch364_g251555;
					float4 In_TransformData16_g251557 = Final_TransformData365_g251555;
					float4 In_RotationData16_g251557 = Out_RotationData15_g251556;
					float4 In_InterpolatorA16_g251557 = Out_InterpolatorA15_g251556;
					BuildModelVertData( Data16_g251557 , In_Dummy16_g251557 , In_PositionOS16_g251557 , In_PositionWS16_g251557 , In_PositionWO16_g251557 , In_PositionRawOS16_g251557 , In_PivotOS16_g251557 , In_PivotWS16_g251557 , In_PivotWO16_g251557 , In_NormalOS16_g251557 , In_NormalWS16_g251557 , In_NormalRawOS16_g251557 , In_TangentOS16_g251557 , In_TangentWS16_g251557 , In_BitangentWS16_g251557 , In_ViewDirWS16_g251557 , In_CoordsData16_g251557 , In_VertexData16_g251557 , In_MasksData16_g251557 , In_PhaseData16_g251557 , In_TransformData16_g251557 , In_RotationData16_g251557 , In_InterpolatorA16_g251557 );
					TVEModelData Data15_g251571 =(TVEModelData)Data16_g251557;
					float Out_Dummy15_g251571 = 0.0;
					float3 Out_PositionOS15_g251571 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251571 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251571 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251571 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251571 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251571 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251571 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251571 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251571 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251571 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251571 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251571 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251571 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251571 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251571 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251571 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251571 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251571 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251571 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251571 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251571 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251571 , Out_Dummy15_g251571 , Out_PositionOS15_g251571 , Out_PositionWS15_g251571 , Out_PositionWO15_g251571 , Out_PositionRawOS15_g251571 , Out_PivotOS15_g251571 , Out_PivotWS15_g251571 , Out_PivotWO15_g251571 , Out_NormalOS15_g251571 , Out_NormalWS15_g251571 , Out_NormalRawOS15_g251571 , Out_TangentOS15_g251571 , Out_TangentWS15_g251571 , Out_BitangentWS15_g251571 , Out_ViewDirWS15_g251571 , Out_CoordsData15_g251571 , Out_VertexData15_g251571 , Out_MasksData15_g251571 , Out_PhaseData15_g251571 , Out_TransformData15_g251571 , Out_RotationData15_g251571 , Out_InterpolatorA15_g251571 );
					TVEModelData Data16_g251572 =(TVEModelData)Data15_g251571;
					float temp_output_14_0_g251572 = 0.0;
					float In_Dummy16_g251572 = temp_output_14_0_g251572;
					float3 Model_PositionOS147_g251570 = Out_PositionOS15_g251571;
					half3 VertexPos40_g251576 = Model_PositionOS147_g251570;
					float4 temp_output_1567_33_g251570 = Out_RotationData15_g251571;
					half4 Model_RotationData1569_g251570 = temp_output_1567_33_g251570;
					float2 break1582_g251570 = (Model_RotationData1569_g251570).xy;
					half Angle44_g251576 = break1582_g251570.y;
					half CosAngle89_g251576 = cos( Angle44_g251576 );
					half SinAngle93_g251576 = sin( Angle44_g251576 );
					float3 appendResult95_g251576 = (float3((VertexPos40_g251576).x , ( ( (VertexPos40_g251576).y * CosAngle89_g251576 ) - ( (VertexPos40_g251576).z * SinAngle93_g251576 ) ) , ( ( (VertexPos40_g251576).y * SinAngle93_g251576 ) + ( (VertexPos40_g251576).z * CosAngle89_g251576 ) )));
					half3 VertexPos40_g251577 = appendResult95_g251576;
					half Angle44_g251577 = -break1582_g251570.x;
					half CosAngle94_g251577 = cos( Angle44_g251577 );
					half SinAngle95_g251577 = sin( Angle44_g251577 );
					float3 appendResult98_g251577 = (float3(( ( (VertexPos40_g251577).x * CosAngle94_g251577 ) - ( (VertexPos40_g251577).y * SinAngle95_g251577 ) ) , ( ( (VertexPos40_g251577).x * SinAngle95_g251577 ) + ( (VertexPos40_g251577).y * CosAngle94_g251577 ) ) , (VertexPos40_g251577).z));
					half3 VertexPos40_g251575 = Model_PositionOS147_g251570;
					half Angle44_g251575 = break1582_g251570.y;
					half CosAngle89_g251575 = cos( Angle44_g251575 );
					half SinAngle93_g251575 = sin( Angle44_g251575 );
					float3 appendResult95_g251575 = (float3((VertexPos40_g251575).x , ( ( (VertexPos40_g251575).y * CosAngle89_g251575 ) - ( (VertexPos40_g251575).z * SinAngle93_g251575 ) ) , ( ( (VertexPos40_g251575).y * SinAngle93_g251575 ) + ( (VertexPos40_g251575).z * CosAngle89_g251575 ) )));
					half3 VertexPos40_g251580 = appendResult95_g251575;
					half Angle44_g251580 = break1582_g251570.x;
					half CosAngle91_g251580 = cos( Angle44_g251580 );
					half SinAngle92_g251580 = sin( Angle44_g251580 );
					float3 appendResult93_g251580 = (float3(( ( (VertexPos40_g251580).x * CosAngle91_g251580 ) + ( (VertexPos40_g251580).z * SinAngle92_g251580 ) ) , (VertexPos40_g251580).y , ( ( -(VertexPos40_g251580).x * SinAngle92_g251580 ) + ( (VertexPos40_g251580).z * CosAngle91_g251580 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251578 = appendResult93_g251580;
					#else
					float3 staticSwitch65_g251578 = appendResult98_g251577;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251573 = staticSwitch65_g251578;
					#else
					float3 staticSwitch65_g251573 = Model_PositionOS147_g251570;
					#endif
					float3 temp_output_1608_0_g251570 = staticSwitch65_g251573;
					half3 VertexPos40_g251579 = temp_output_1608_0_g251570;
					half Angle44_g251579 = (Model_RotationData1569_g251570).z;
					half CosAngle91_g251579 = cos( Angle44_g251579 );
					half SinAngle92_g251579 = sin( Angle44_g251579 );
					float3 appendResult93_g251579 = (float3(( ( (VertexPos40_g251579).x * CosAngle91_g251579 ) + ( (VertexPos40_g251579).z * SinAngle92_g251579 ) ) , (VertexPos40_g251579).y , ( ( -(VertexPos40_g251579).x * SinAngle92_g251579 ) + ( (VertexPos40_g251579).z * CosAngle91_g251579 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251574 = appendResult93_g251579;
					#else
					float3 staticSwitch65_g251574 = temp_output_1608_0_g251570;
					#endif
					float4 temp_output_1567_31_g251570 = Out_TransformData15_g251571;
					half4 Model_TransformData1568_g251570 = temp_output_1567_31_g251570;
					half3 Final_PositionOS178_g251570 = ( ( staticSwitch65_g251574 * (Model_TransformData1568_g251570).w ) + (Model_TransformData1568_g251570).xyz );
					float3 temp_output_4_0_g251572 = Final_PositionOS178_g251570;
					float3 In_PositionOS16_g251572 = temp_output_4_0_g251572;
					float3 In_PositionWS16_g251572 = Out_PositionWS15_g251571;
					float3 In_PositionWO16_g251572 = Out_PositionWO15_g251571;
					float3 In_PositionRawOS16_g251572 = Out_PositionRawOS15_g251571;
					float3 In_PivotOS16_g251572 = Out_PivotOS15_g251571;
					float3 In_PivotWS16_g251572 = Out_PivotWS15_g251571;
					float3 In_PivotWO16_g251572 = Out_PivotWO15_g251571;
					float3 temp_output_21_0_g251572 = Out_NormalOS15_g251571;
					float3 In_NormalOS16_g251572 = temp_output_21_0_g251572;
					float3 In_NormalWS16_g251572 = Out_NormalWS15_g251571;
					float3 In_NormalRawOS16_g251572 = Out_NormalRawOS15_g251571;
					float4 temp_output_6_0_g251572 = Out_TangentOS15_g251571;
					float4 In_TangentOS16_g251572 = temp_output_6_0_g251572;
					float3 In_TangentWS16_g251572 = Out_TangentWS15_g251571;
					float3 In_BitangentWS16_g251572 = Out_BitangentWS15_g251571;
					float3 In_ViewDirWS16_g251572 = Out_ViewDirWS15_g251571;
					float4 In_CoordsData16_g251572 = Out_CoordsData15_g251571;
					float4 In_VertexData16_g251572 = Out_VertexData15_g251571;
					float4 In_MasksData16_g251572 = Out_MasksData15_g251571;
					float4 In_PhaseData16_g251572 = Out_PhaseData15_g251571;
					float4 In_TransformData16_g251572 = temp_output_1567_31_g251570;
					float4 In_RotationData16_g251572 = temp_output_1567_33_g251570;
					float4 In_InterpolatorA16_g251572 = Out_InterpolatorA15_g251571;
					BuildModelVertData( Data16_g251572 , In_Dummy16_g251572 , In_PositionOS16_g251572 , In_PositionWS16_g251572 , In_PositionWO16_g251572 , In_PositionRawOS16_g251572 , In_PivotOS16_g251572 , In_PivotWS16_g251572 , In_PivotWO16_g251572 , In_NormalOS16_g251572 , In_NormalWS16_g251572 , In_NormalRawOS16_g251572 , In_TangentOS16_g251572 , In_TangentWS16_g251572 , In_BitangentWS16_g251572 , In_ViewDirWS16_g251572 , In_CoordsData16_g251572 , In_VertexData16_g251572 , In_MasksData16_g251572 , In_PhaseData16_g251572 , In_TransformData16_g251572 , In_RotationData16_g251572 , In_InterpolatorA16_g251572 );
					TVEModelData Data15_g251582 =(TVEModelData)Data16_g251572;
					float Out_Dummy15_g251582 = 0.0;
					float3 Out_PositionOS15_g251582 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251582 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251582 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251582 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251582 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251582 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251582 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251582 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251582 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251582 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251582 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251582 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251582 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251582 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251582 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251582 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251582 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251582 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251582 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251582 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251582 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251582 , Out_Dummy15_g251582 , Out_PositionOS15_g251582 , Out_PositionWS15_g251582 , Out_PositionWO15_g251582 , Out_PositionRawOS15_g251582 , Out_PivotOS15_g251582 , Out_PivotWS15_g251582 , Out_PivotWO15_g251582 , Out_NormalOS15_g251582 , Out_NormalWS15_g251582 , Out_NormalRawOS15_g251582 , Out_TangentOS15_g251582 , Out_TangentWS15_g251582 , Out_BitangentWS15_g251582 , Out_ViewDirWS15_g251582 , Out_CoordsData15_g251582 , Out_VertexData15_g251582 , Out_MasksData15_g251582 , Out_PhaseData15_g251582 , Out_TransformData15_g251582 , Out_RotationData15_g251582 , Out_InterpolatorA15_g251582 );
					TVEModelData Data16_g251583 =(TVEModelData)Data15_g251582;
					float temp_output_14_0_g251583 = 0.0;
					float In_Dummy16_g251583 = temp_output_14_0_g251583;
					float3 temp_output_217_24_g251581 = Out_PivotOS15_g251582;
					float3 temp_output_216_0_g251581 = ( Out_PositionOS15_g251582 + temp_output_217_24_g251581 );
					float3 temp_output_4_0_g251583 = temp_output_216_0_g251581;
					float3 In_PositionOS16_g251583 = temp_output_4_0_g251583;
					float3 In_PositionWS16_g251583 = Out_PositionWS15_g251582;
					float3 In_PositionWO16_g251583 = Out_PositionWO15_g251582;
					float3 In_PositionRawOS16_g251583 = Out_PositionRawOS15_g251582;
					float3 In_PivotOS16_g251583 = temp_output_217_24_g251581;
					float3 In_PivotWS16_g251583 = Out_PivotWS15_g251582;
					float3 In_PivotWO16_g251583 = Out_PivotWO15_g251582;
					float3 temp_output_21_0_g251583 = Out_NormalOS15_g251582;
					float3 In_NormalOS16_g251583 = temp_output_21_0_g251583;
					float3 In_NormalWS16_g251583 = Out_NormalWS15_g251582;
					float3 In_NormalRawOS16_g251583 = Out_NormalRawOS15_g251582;
					float4 temp_output_6_0_g251583 = Out_TangentOS15_g251582;
					float4 In_TangentOS16_g251583 = temp_output_6_0_g251583;
					float3 In_TangentWS16_g251583 = Out_TangentWS15_g251582;
					float3 In_BitangentWS16_g251583 = Out_BitangentWS15_g251582;
					float3 In_ViewDirWS16_g251583 = Out_ViewDirWS15_g251582;
					float4 In_CoordsData16_g251583 = Out_CoordsData15_g251582;
					float4 In_VertexData16_g251583 = Out_VertexData15_g251582;
					float4 In_MasksData16_g251583 = Out_MasksData15_g251582;
					float4 In_PhaseData16_g251583 = Out_PhaseData15_g251582;
					float4 In_TransformData16_g251583 = Out_TransformData15_g251582;
					float4 In_RotationData16_g251583 = Out_RotationData15_g251582;
					float4 In_InterpolatorA16_g251583 = Out_InterpolatorA15_g251582;
					BuildModelVertData( Data16_g251583 , In_Dummy16_g251583 , In_PositionOS16_g251583 , In_PositionWS16_g251583 , In_PositionWO16_g251583 , In_PositionRawOS16_g251583 , In_PivotOS16_g251583 , In_PivotWS16_g251583 , In_PivotWO16_g251583 , In_NormalOS16_g251583 , In_NormalWS16_g251583 , In_NormalRawOS16_g251583 , In_TangentOS16_g251583 , In_TangentWS16_g251583 , In_BitangentWS16_g251583 , In_ViewDirWS16_g251583 , In_CoordsData16_g251583 , In_VertexData16_g251583 , In_MasksData16_g251583 , In_PhaseData16_g251583 , In_TransformData16_g251583 , In_RotationData16_g251583 , In_InterpolatorA16_g251583 );
					TVEModelData Data15_g251592 =(TVEModelData)Data16_g251583;
					float Out_Dummy15_g251592 = 0.0;
					float3 Out_PositionOS15_g251592 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251592 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251592 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251592 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251592 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251592 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251592 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251592 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251592 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251592 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251592 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251592 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251592 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251592 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251592 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251592 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251592 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251592 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251592 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251592 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251592 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251592 , Out_Dummy15_g251592 , Out_PositionOS15_g251592 , Out_PositionWS15_g251592 , Out_PositionWO15_g251592 , Out_PositionRawOS15_g251592 , Out_PivotOS15_g251592 , Out_PivotWS15_g251592 , Out_PivotWO15_g251592 , Out_NormalOS15_g251592 , Out_NormalWS15_g251592 , Out_NormalRawOS15_g251592 , Out_TangentOS15_g251592 , Out_TangentWS15_g251592 , Out_BitangentWS15_g251592 , Out_ViewDirWS15_g251592 , Out_CoordsData15_g251592 , Out_VertexData15_g251592 , Out_MasksData15_g251592 , Out_PhaseData15_g251592 , Out_TransformData15_g251592 , Out_RotationData15_g251592 , Out_InterpolatorA15_g251592 );
					
					o.ase_texcoord6.xyz = vertexToFrag73_g241375;
					o.ase_texcoord7.xyz = vertexToFrag76_g241375;
					float3 vertexPos57_g251586 = v.vertex.xyz;
					float4 ase_positionCS57_g251586 = UnityObjectToClipPos( vertexPos57_g251586 );
					o.ase_texcoord9 = ase_positionCS57_g251586;
					
					o.ase_texcoord8.xy = v.texcoord.xyzw.xy;
					o.ase_texcoord8.zw = v.texcoord2.xyzw.xy;
					o.ase_color = v.ase_color;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord6.w = 0;
					o.ase_texcoord7.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251592;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251592;
					v.tangent = Out_TangentOS15_g251592;

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
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_color : COLOR;

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
					o.ase_texcoord3 = v.ase_texcoord3;
					o.ase_color = v.ase_color;
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
					o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
					o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
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

					float temp_output_2664_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2664_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2664_114).xxx;
					
					float3 color130_g251586 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g251586 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g251588 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g251587 = ( temp_cast_4 * ( 0.5 + appendResult128_g251588 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g251587 = (float4(ddx( FinalUV13_g251587 ) , ddy( FinalUV13_g251587 )));
					float4 UVDerivatives17_g251587 = appendResult16_g251587;
					float4 break28_g251587 = UVDerivatives17_g251587;
					float2 appendResult19_g251587 = (float2(break28_g251587.x , break28_g251587.z));
					float2 appendResult20_g251587 = (float2(break28_g251587.x , break28_g251587.z));
					float dotResult24_g251587 = dot( appendResult19_g251587 , appendResult20_g251587 );
					float2 appendResult21_g251587 = (float2(break28_g251587.y , break28_g251587.w));
					float2 appendResult22_g251587 = (float2(break28_g251587.y , break28_g251587.w));
					float dotResult23_g251587 = dot( appendResult21_g251587 , appendResult22_g251587 );
					float2 appendResult25_g251587 = (float2(dotResult24_g251587 , dotResult23_g251587));
					float2 derivativesLength29_g251587 = sqrt( appendResult25_g251587 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g251587 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g251587 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g251587 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g251587 = clampResult57_g251587;
					float2 break55_g251587 = derivativesLength29_g251587;
					float4 lerpResult73_g251587 = lerp( float4( color130_g251586 , 0.0 ) , float4( color81_g251586 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g251587.x * break71_g251587.y * sqrt( saturate( ( 1.1 - max( break55_g251587.x, break55_g251587.y ) ) ) ) ) ) ));
					float3 color107_g251543 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251543 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float localBreakData4_g251542 = ( 0.0 );
					float localIfMasksData25_g251541 = ( 0.0 );
					TVEMasksData Data25_g251541 = (TVEMasksData)0;
					float localBuildMasksData3_g251483 = ( 0.0 );
					TVEMasksData Data3_g251483 = (TVEMasksData)0;
					half Feature_Intensity1107_g251434 = _OverlayIntensityValue;
					float ifLocalVar18_g251479 = 0;
					if( Feature_Intensity1107_g251434 <= 0.0 )
					ifLocalVar18_g251479 = 0.0;
					else
					ifLocalVar18_g251479 = 1.0;
					half Feature_Maps1112_g251434 = _OverlayTextureMode;
					float ifLocalVar18_g251480 = 0;
					if( Feature_Maps1112_g251434 <= 0.0 )
					ifLocalVar18_g251480 = 0.0;
					else
					ifLocalVar18_g251480 = 1.0;
					half Feature_Glitter1108_g251434 = _OverlayGlitterIntensityValue;
					float ifLocalVar18_g251481 = 0;
					if( Feature_Glitter1108_g251434 <= 0.0 )
					ifLocalVar18_g251481 = 0.0;
					else
					ifLocalVar18_g251481 = 1.0;
					half Feature_Element1085_g251434 = _OverlayElementMode;
					float ifLocalVar18_g251478 = 0;
					if( Feature_Element1085_g251434 <= 0.0 )
					ifLocalVar18_g251478 = 0.0;
					else
					ifLocalVar18_g251478 = 1.0;
					float4 appendResult1117_g251434 = (float4(ifLocalVar18_g251479 , ifLocalVar18_g251480 , ifLocalVar18_g251481 , ifLocalVar18_g251478));
					float4 In_MaskA3_g251483 = appendResult1117_g251434;
					half Blend_TexMask908_g251434 = 1.0;
					float localBreakVisualData4_g251475 = ( 0.0 );
					float localBuildVisualData3_g251315 = ( 0.0 );
					TVEVisualData Data3_g251315 =(TVEVisualData)0;
					half4 Dummy130_g241396 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) );
					float temp_output_14_0_g251315 = Dummy130_g241396.x;
					float In_Dummy3_g251315 = temp_output_14_0_g251315;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251356) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g251351 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g251351 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g251351 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g251351 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g251351 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g251351 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g251356 = staticSwitch36_g251351;
					float localBreakTextureData456_g251356 = ( 0.0 );
					float localBuildTextureData431_g251346 = ( 0.0 );
					TVEMasksData Data431_g251346 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g251346 = ( 0.0 );
					half4 Local_Coords180_g241396 = _main_coord_value;
					float4 Coords444_g251346 = Local_Coords180_g241396;
					float localIfModelDataByShader26_g241395 = ( 0.0 );
					TVEModelData Data26_g241395 = (TVEModelData)0;
					TVEModelData Data16_g241383 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241383 = 0.0;
					float3 vertexToFrag73_g241375 = IN.ase_texcoord6.xyz;
					float3 PositionWS122_g241375 = vertexToFrag73_g241375;
					float3 In_PositionWS16_g241383 = PositionWS122_g241375;
					float3 vertexToFrag76_g241375 = IN.ase_texcoord7.xyz;
					float3 PivotWS121_g241375 = vertexToFrag76_g241375;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241375 = ( PositionWS122_g241375 - PivotWS121_g241375 );
					#else
					float3 staticSwitch204_g241375 = PositionWS122_g241375;
					#endif
					float3 PositionWO132_g241375 = ( staticSwitch204_g241375 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241383 = PositionWO132_g241375;
					float3 In_PivotWS16_g241383 = PivotWS121_g241375;
					float3 PivotWO133_g241375 = ( PivotWS121_g241375 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241383 = PivotWO133_g241375;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g241375 = normalizedWorldNormal;
					float3 In_NormalWS16_g241383 = NormalWS95_g241375;
					half3 TangentWS136_g241375 = TangentWS;
					float3 In_TangentWS16_g241383 = TangentWS136_g241375;
					half3 BiangentWS421_g241375 = BitangentWS;
					float3 In_BitangentWS16_g241383 = BiangentWS421_g241375;
					half3 NormalWS427_g241375 = NormalWS95_g241375;
					half3 localComputeTriplanarWeights427_g241375 = ComputeTriplanarWeights( NormalWS427_g241375 );
					half3 TriplanarWeights429_g241375 = localComputeTriplanarWeights427_g241375;
					float3 In_TriplanarWeights16_g241383 = TriplanarWeights429_g241375;
					float3 normalizeResult296_g241375 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241375 ) );
					half3 ViewDirWS169_g241375 = normalizeResult296_g241375;
					float3 In_ViewDirWS16_g241383 = ViewDirWS169_g241375;
					float4 appendResult397_g241375 = (float4(IN.ase_texcoord8.xy , IN.ase_texcoord8.zw));
					float4 CoordsData398_g241375 = appendResult397_g241375;
					float4 In_CoordsData16_g241383 = CoordsData398_g241375;
					half4 VertexMasks171_g241375 = IN.ase_color;
					float4 In_VertexData16_g241383 = VertexMasks171_g241375;
					float temp_output_17_0_g241387 = _ObjectPhaseMode;
					float Option70_g241387 = temp_output_17_0_g241387;
					float4 temp_output_3_0_g241387 = IN.ase_color;
					float4 Channel70_g241387 = temp_output_3_0_g241387;
					float localSwitchChannel470_g241387 = SwitchChannel4( Option70_g241387 , Channel70_g241387 );
					half Phase_Value372_g241375 = localSwitchChannel470_g241387;
					float3 break319_g241375 = PivotWO133_g241375;
					half Pivot_Position322_g241375 = ( break319_g241375.x + break319_g241375.z );
					half Phase_Position357_g241375 = ( Phase_Value372_g241375 + Pivot_Position322_g241375 );
					float temp_output_248_0_g241375 = frac( Phase_Position357_g241375 );
					float4 appendResult177_g241375 = (float4(( (frac( ( Phase_Position357_g241375 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g241375));
					half4 Phase_Data176_g241375 = appendResult177_g241375;
					float4 In_PhaseData16_g241383 = Phase_Data176_g241375;
					BuildModelFragData( Data16_g241383 , In_Dummy16_g241383 , In_PositionWS16_g241383 , In_PositionWO16_g241383 , In_PivotWS16_g241383 , In_PivotWO16_g241383 , In_NormalWS16_g241383 , In_TangentWS16_g241383 , In_BitangentWS16_g241383 , In_TriplanarWeights16_g241383 , In_ViewDirWS16_g241383 , In_CoordsData16_g241383 , In_VertexData16_g241383 , In_PhaseData16_g241383 );
					TVEModelData DataDefault26_g241395 = Data16_g241383;
					TVEModelData DataGeneral26_g241395 = Data16_g241383;
					TVEModelData DataBlanket26_g241395 = Data16_g241383;
					TVEModelData DataImpostor26_g241395 = Data16_g241383;
					TVEModelData Data16_g241363 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241363 = 0.0;
					float3 temp_output_104_7_g241355 = PositionWS;
					float3 PositionWS122_g241355 = temp_output_104_7_g241355;
					float3 In_PositionWS16_g241363 = PositionWS122_g241355;
					float4x4 break19_g241358 = unity_ObjectToWorld;
					float3 appendResult20_g241358 = (float3(break19_g241358[ 0 ][ 3 ] , break19_g241358[ 1 ][ 3 ] , break19_g241358[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241355 = appendResult20_g241358;
					float3 PivotWS121_g241355 = temp_output_340_7_g241355;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241355 = ( PositionWS122_g241355 - PivotWS121_g241355 );
					#else
					float3 staticSwitch204_g241355 = PositionWS122_g241355;
					#endif
					float3 PositionWO132_g241355 = ( staticSwitch204_g241355 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241363 = PositionWO132_g241355;
					float3 In_PivotWS16_g241363 = PivotWS121_g241355;
					float3 PivotWO133_g241355 = ( PivotWS121_g241355 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241363 = PivotWO133_g241355;
					half3 NormalWS95_g241355 = normalizedWorldNormal;
					float3 In_NormalWS16_g241363 = NormalWS95_g241355;
					half3 TangentWS136_g241355 = TangentWS;
					float3 In_TangentWS16_g241363 = TangentWS136_g241355;
					half3 BiangentWS421_g241355 = BitangentWS;
					float3 In_BitangentWS16_g241363 = BiangentWS421_g241355;
					half3 NormalWS427_g241355 = NormalWS95_g241355;
					half3 localComputeTriplanarWeights427_g241355 = ComputeTriplanarWeights( NormalWS427_g241355 );
					half3 TriplanarWeights429_g241355 = localComputeTriplanarWeights427_g241355;
					float3 In_TriplanarWeights16_g241363 = TriplanarWeights429_g241355;
					float3 normalizeResult296_g241355 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241355 ) );
					half3 ViewDirWS169_g241355 = normalizeResult296_g241355;
					float3 In_ViewDirWS16_g241363 = ViewDirWS169_g241355;
					float4 appendResult397_g241355 = (float4(IN.ase_texcoord8.xy , IN.ase_texcoord8.zw));
					float4 CoordsData398_g241355 = appendResult397_g241355;
					float4 In_CoordsData16_g241363 = CoordsData398_g241355;
					half4 VertexMasks171_g241355 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241363 = VertexMasks171_g241355;
					half4 Phase_Data176_g241355 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241363 = Phase_Data176_g241355;
					BuildModelFragData( Data16_g241363 , In_Dummy16_g241363 , In_PositionWS16_g241363 , In_PositionWO16_g241363 , In_PivotWS16_g241363 , In_PivotWO16_g241363 , In_NormalWS16_g241363 , In_TangentWS16_g241363 , In_BitangentWS16_g241363 , In_TriplanarWeights16_g241363 , In_ViewDirWS16_g241363 , In_CoordsData16_g241363 , In_VertexData16_g241363 , In_PhaseData16_g241363 );
					TVEModelData DataTerrain26_g241395 = Data16_g241363;
					half IsShaderType2672 = _IsShaderType;
					float Type26_g241395 = IsShaderType2672;
					{
					if (Type26_g241395 == 0 )
					{
					Data26_g241395 = DataDefault26_g241395;
					}
					else if (Type26_g241395 == 1 )
					{
					Data26_g241395 = DataGeneral26_g241395;
					}
					else if (Type26_g241395 == 2 )
					{
					Data26_g241395 = DataBlanket26_g241395;
					}
					else if (Type26_g241395 == 3 )
					{
					Data26_g241395 = DataImpostor26_g241395;
					}
					else if (Type26_g241395 == 4 )
					{
					Data26_g241395 = DataTerrain26_g241395;
					}
					}
					TVEModelData Data15_g251330 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g251330 = 0.0;
					float3 Out_PositionWS15_g251330 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251330 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251330 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251330 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251330 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251330 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251330 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251330 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251330 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251330 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251330 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251330 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251330 , Out_Dummy15_g251330 , Out_PositionWS15_g251330 , Out_PositionWO15_g251330 , Out_PivotWS15_g251330 , Out_PivotWO15_g251330 , Out_NormalWS15_g251330 , Out_TangentWS15_g251330 , Out_BitangentWS15_g251330 , Out_TriplanarWeights15_g251330 , Out_ViewDirWS15_g251330 , Out_CoordsData15_g251330 , Out_VertexData15_g251330 , Out_PhaseData15_g251330 );
					float4 Model_CoordsData324_g241396 = Out_CoordsData15_g251330;
					float4 MeshCoords444_g251346 = Model_CoordsData324_g241396;
					float2 UV0444_g251346 = float2( 0,0 );
					float2 UV3444_g251346 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g251346 , MeshCoords444_g251346 , UV0444_g251346 , UV3444_g251346 );
					float4 appendResult430_g251346 = (float4(UV0444_g251346 , UV3444_g251346));
					float4 In_MaskA431_g251346 = appendResult430_g251346;
					float localComputeWorldCoords315_g251346 = ( 0.0 );
					float4 Coords315_g251346 = Local_Coords180_g241396;
					float3 Model_PositionWO222_g241396 = Out_PositionWO15_g251330;
					float3 PositionWS315_g251346 = Model_PositionWO222_g241396;
					float2 ZY315_g251346 = float2( 0,0 );
					float2 XZ315_g251346 = float2( 0,0 );
					float2 XY315_g251346 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g251346 , PositionWS315_g251346 , ZY315_g251346 , XZ315_g251346 , XY315_g251346 );
					float2 ZY402_g251346 = ZY315_g251346;
					float2 XZ403_g251346 = XZ315_g251346;
					float4 appendResult432_g251346 = (float4(ZY402_g251346 , XZ403_g251346));
					float4 In_MaskB431_g251346 = appendResult432_g251346;
					float2 XY404_g251346 = XY315_g251346;
					float localComputeStochasticCoords409_g251346 = ( 0.0 );
					float2 UV409_g251346 = ZY402_g251346;
					float2 UV1409_g251346 = float2( 0,0 );
					float2 UV2409_g251346 = float2( 0,0 );
					float2 UV3409_g251346 = float2( 0,0 );
					float3 Weights409_g251346 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g251346 , UV1409_g251346 , UV2409_g251346 , UV3409_g251346 , Weights409_g251346 );
					float4 appendResult433_g251346 = (float4(XY404_g251346 , UV1409_g251346));
					float4 In_MaskC431_g251346 = appendResult433_g251346;
					float4 appendResult434_g251346 = (float4(UV2409_g251346 , UV3409_g251346));
					float4 In_MaskD431_g251346 = appendResult434_g251346;
					float localComputeStochasticCoords422_g251346 = ( 0.0 );
					float2 UV422_g251346 = XZ403_g251346;
					float2 UV1422_g251346 = float2( 0,0 );
					float2 UV2422_g251346 = float2( 0,0 );
					float2 UV3422_g251346 = float2( 0,0 );
					float3 Weights422_g251346 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g251346 , UV1422_g251346 , UV2422_g251346 , UV3422_g251346 , Weights422_g251346 );
					float4 appendResult435_g251346 = (float4(UV1422_g251346 , UV2422_g251346));
					float4 In_MaskE431_g251346 = appendResult435_g251346;
					float localComputeStochasticCoords423_g251346 = ( 0.0 );
					float2 UV423_g251346 = XY404_g251346;
					float2 UV1423_g251346 = float2( 0,0 );
					float2 UV2423_g251346 = float2( 0,0 );
					float2 UV3423_g251346 = float2( 0,0 );
					float3 Weights423_g251346 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g251346 , UV1423_g251346 , UV2423_g251346 , UV3423_g251346 , Weights423_g251346 );
					float4 appendResult436_g251346 = (float4(UV3422_g251346 , UV1423_g251346));
					float4 In_MaskF431_g251346 = appendResult436_g251346;
					float4 appendResult437_g251346 = (float4(UV2423_g251346 , UV3423_g251346));
					float4 In_MaskG431_g251346 = appendResult437_g251346;
					float4 In_MaskH431_g251346 = float4( Weights409_g251346 , 0.0 );
					float4 In_MaskI431_g251346 = float4( Weights422_g251346 , 0.0 );
					float4 In_MaskJ431_g251346 = float4( Weights423_g251346 , 0.0 );
					half3 Model_NormalWS226_g241396 = Out_NormalWS15_g251330;
					float3 temp_output_449_0_g251346 = Model_NormalWS226_g241396;
					float4 In_MaskK431_g251346 = float4( temp_output_449_0_g251346 , 0.0 );
					half3 Model_TangentWS366_g241396 = Out_TangentWS15_g251330;
					float3 temp_output_450_0_g251346 = Model_TangentWS366_g241396;
					float4 In_MaskL431_g251346 = float4( temp_output_450_0_g251346 , 0.0 );
					half3 Model_BitangentWS367_g241396 = Out_BitangentWS15_g251330;
					float3 temp_output_451_0_g251346 = Model_BitangentWS367_g241396;
					float4 In_MaskM431_g251346 = float4( temp_output_451_0_g251346 , 0.0 );
					half3 Model_TriplanarWeights368_g241396 = Out_TriplanarWeights15_g251330;
					float3 temp_output_445_0_g251346 = Model_TriplanarWeights368_g241396;
					float4 In_MaskN431_g251346 = float4( temp_output_445_0_g251346 , 0.0 );
					BuildTextureData( Data431_g251346 , In_MaskA431_g251346 , In_MaskB431_g251346 , In_MaskC431_g251346 , In_MaskD431_g251346 , In_MaskE431_g251346 , In_MaskF431_g251346 , In_MaskG431_g251346 , In_MaskH431_g251346 , In_MaskI431_g251346 , In_MaskJ431_g251346 , In_MaskK431_g251346 , In_MaskL431_g251346 , In_MaskM431_g251346 , In_MaskN431_g251346 );
					TVEMasksData Data456_g251356 =(TVEMasksData)Data431_g251346;
					float4 Out_MaskA456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251356 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251356 , Out_MaskA456_g251356 , Out_MaskB456_g251356 , Out_MaskC456_g251356 , Out_MaskD456_g251356 , Out_MaskE456_g251356 , Out_MaskF456_g251356 , Out_MaskG456_g251356 , Out_MaskH456_g251356 , Out_MaskI456_g251356 , Out_MaskJ456_g251356 , Out_MaskK456_g251356 , Out_MaskL456_g251356 , Out_MaskM456_g251356 , Out_MaskN456_g251356 );
					half2 UV276_g251356 = (Out_MaskA456_g251356).xy;
					float temp_output_504_0_g251356 = 0.0;
					half Bias276_g251356 = temp_output_504_0_g251356;
					half2 Normal276_g251356 = float2( 0,0 );
					half4 localSampleCoord276_g251356 = SampleCoord( Texture276_g251356 , Sampler276_g251356 , UV276_g251356 , Bias276_g251356 , Normal276_g251356 );
					float4 temp_output_407_277_g241396 = localSampleCoord276_g251356;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251356) = _MainAlbedoTex;
					SamplerState Sampler502_g251356 = staticSwitch36_g251351;
					half2 UV502_g251356 = (Out_MaskA456_g251356).zw;
					half Bias502_g251356 = temp_output_504_0_g251356;
					half2 Normal502_g251356 = float2( 0,0 );
					half4 localSampleCoord502_g251356 = SampleCoord( Texture502_g251356 , Sampler502_g251356 , UV502_g251356 , Bias502_g251356 , Normal502_g251356 );
					float4 temp_output_407_278_g241396 = localSampleCoord502_g251356;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251356) = _MainAlbedoTex;
					SamplerState Sampler496_g251356 = staticSwitch36_g251351;
					float2 temp_output_463_0_g251356 = (Out_MaskB456_g251356).zw;
					half2 XZ496_g251356 = temp_output_463_0_g251356;
					half Bias496_g251356 = temp_output_504_0_g251356;
					float3 temp_output_483_0_g251356 = (Out_MaskK456_g251356).xyz;
					half3 NormalWS496_g251356 = temp_output_483_0_g251356;
					half3 Normal496_g251356 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251356 = SamplePlanar2D( Texture496_g251356 , Sampler496_g251356 , XZ496_g251356 , Bias496_g251356 , NormalWS496_g251356 , Normal496_g251356 );
					float4 temp_output_407_0_g241396 = localSamplePlanar2D496_g251356;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251356) = _MainAlbedoTex;
					SamplerState Sampler490_g251356 = staticSwitch36_g251351;
					float2 temp_output_462_0_g251356 = (Out_MaskB456_g251356).xy;
					half2 ZY490_g251356 = temp_output_462_0_g251356;
					half2 XZ490_g251356 = temp_output_463_0_g251356;
					float2 temp_output_464_0_g251356 = (Out_MaskC456_g251356).xy;
					half2 XY490_g251356 = temp_output_464_0_g251356;
					half Bias490_g251356 = temp_output_504_0_g251356;
					float3 temp_output_482_0_g251356 = (Out_MaskN456_g251356).xyz;
					half3 Triplanar490_g251356 = temp_output_482_0_g251356;
					half3 NormalWS490_g251356 = temp_output_483_0_g251356;
					half3 Normal490_g251356 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251356 = SamplePlanar3D( Texture490_g251356 , Sampler490_g251356 , ZY490_g251356 , XZ490_g251356 , XY490_g251356 , Bias490_g251356 , Triplanar490_g251356 , NormalWS490_g251356 , Normal490_g251356 );
					float4 temp_output_407_201_g241396 = localSamplePlanar3D490_g251356;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251356) = _MainAlbedoTex;
					SamplerState Sampler498_g251356 = staticSwitch36_g251351;
					half2 XZ498_g251356 = temp_output_463_0_g251356;
					float2 temp_output_473_0_g251356 = (Out_MaskE456_g251356).xy;
					half2 XZ_1498_g251356 = temp_output_473_0_g251356;
					float2 temp_output_474_0_g251356 = (Out_MaskE456_g251356).zw;
					half2 XZ_2498_g251356 = temp_output_474_0_g251356;
					float2 temp_output_475_0_g251356 = (Out_MaskF456_g251356).xy;
					half2 XZ_3498_g251356 = temp_output_475_0_g251356;
					float temp_output_510_0_g251356 = exp2( temp_output_504_0_g251356 );
					half Bias498_g251356 = temp_output_510_0_g251356;
					float3 temp_output_480_0_g251356 = (Out_MaskI456_g251356).xyz;
					half3 Weights_2498_g251356 = temp_output_480_0_g251356;
					half3 NormalWS498_g251356 = temp_output_483_0_g251356;
					half3 Normal498_g251356 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251356 = SampleStochastic2D( Texture498_g251356 , Sampler498_g251356 , XZ498_g251356 , XZ_1498_g251356 , XZ_2498_g251356 , XZ_3498_g251356 , Bias498_g251356 , Weights_2498_g251356 , NormalWS498_g251356 , Normal498_g251356 );
					float4 temp_output_407_202_g241396 = localSampleStochastic2D498_g251356;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251356) = _MainAlbedoTex;
					SamplerState Sampler500_g251356 = staticSwitch36_g251351;
					half2 ZY500_g251356 = temp_output_462_0_g251356;
					half2 ZY_1500_g251356 = (Out_MaskC456_g251356).zw;
					half2 ZY_2500_g251356 = (Out_MaskD456_g251356).xy;
					half2 ZY_3500_g251356 = (Out_MaskD456_g251356).zw;
					half2 XZ500_g251356 = temp_output_463_0_g251356;
					half2 XZ_1500_g251356 = temp_output_473_0_g251356;
					half2 XZ_2500_g251356 = temp_output_474_0_g251356;
					half2 XZ_3500_g251356 = temp_output_475_0_g251356;
					half2 XY500_g251356 = temp_output_464_0_g251356;
					half2 XY_1500_g251356 = (Out_MaskF456_g251356).zw;
					half2 XY_2500_g251356 = (Out_MaskG456_g251356).xy;
					half2 XY_3500_g251356 = (Out_MaskG456_g251356).zw;
					half Bias500_g251356 = temp_output_510_0_g251356;
					half3 Weights_1500_g251356 = (Out_MaskH456_g251356).xyz;
					half3 Weights_2500_g251356 = temp_output_480_0_g251356;
					half3 Weights_3500_g251356 = (Out_MaskJ456_g251356).xyz;
					half3 Triplanar500_g251356 = temp_output_482_0_g251356;
					half3 NormalWS500_g251356 = temp_output_483_0_g251356;
					half3 Normal500_g251356 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251356 = SampleStochastic3D( Texture500_g251356 , Sampler500_g251356 , ZY500_g251356 , ZY_1500_g251356 , ZY_2500_g251356 , ZY_3500_g251356 , XZ500_g251356 , XZ_1500_g251356 , XZ_2500_g251356 , XZ_3500_g251356 , XY500_g251356 , XY_1500_g251356 , XY_2500_g251356 , XY_3500_g251356 , Bias500_g251356 , Weights_1500_g251356 , Weights_2500_g251356 , Weights_3500_g251356 , Triplanar500_g251356 , NormalWS500_g251356 , Normal500_g251356 );
					float4 temp_output_407_203_g241396 = localSampleStochastic3D500_g251356;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g241396 = temp_output_407_277_g241396;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g241396 = temp_output_407_278_g241396;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g241396 = temp_output_407_0_g241396;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g241396 = temp_output_407_201_g241396;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g241396 = temp_output_407_202_g241396;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g241396 = temp_output_407_203_g241396;
					#else
					float4 staticSwitch184_g241396 = temp_output_407_277_g241396;
					#endif
					half4 Local_AlbedoSample185_g241396 = staticSwitch184_g241396;
					float3 lerpResult53_g241396 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g241396).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g241396 = lerpResult53_g241396;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251354) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g251353 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g251353 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g251353 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g251353 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g251353 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g251353 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251354 = staticSwitch38_g251353;
					float localBreakTextureData456_g251354 = ( 0.0 );
					TVEMasksData Data456_g251354 =(TVEMasksData)Data431_g251346;
					float4 Out_MaskA456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251354 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251354 , Out_MaskA456_g251354 , Out_MaskB456_g251354 , Out_MaskC456_g251354 , Out_MaskD456_g251354 , Out_MaskE456_g251354 , Out_MaskF456_g251354 , Out_MaskG456_g251354 , Out_MaskH456_g251354 , Out_MaskI456_g251354 , Out_MaskJ456_g251354 , Out_MaskK456_g251354 , Out_MaskL456_g251354 , Out_MaskM456_g251354 , Out_MaskN456_g251354 );
					half2 UV276_g251354 = (Out_MaskA456_g251354).xy;
					float temp_output_504_0_g251354 = 0.0;
					half Bias276_g251354 = temp_output_504_0_g251354;
					half2 Normal276_g251354 = float2( 0,0 );
					half4 localSampleCoord276_g251354 = SampleCoord( Texture276_g251354 , Sampler276_g251354 , UV276_g251354 , Bias276_g251354 , Normal276_g251354 );
					float4 temp_output_405_277_g241396 = localSampleCoord276_g251354;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251354) = _MainShaderTex;
					SamplerState Sampler502_g251354 = staticSwitch38_g251353;
					half2 UV502_g251354 = (Out_MaskA456_g251354).zw;
					half Bias502_g251354 = temp_output_504_0_g251354;
					half2 Normal502_g251354 = float2( 0,0 );
					half4 localSampleCoord502_g251354 = SampleCoord( Texture502_g251354 , Sampler502_g251354 , UV502_g251354 , Bias502_g251354 , Normal502_g251354 );
					float4 temp_output_405_278_g241396 = localSampleCoord502_g251354;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251354) = _MainShaderTex;
					SamplerState Sampler496_g251354 = staticSwitch38_g251353;
					float2 temp_output_463_0_g251354 = (Out_MaskB456_g251354).zw;
					half2 XZ496_g251354 = temp_output_463_0_g251354;
					half Bias496_g251354 = temp_output_504_0_g251354;
					float3 temp_output_483_0_g251354 = (Out_MaskK456_g251354).xyz;
					half3 NormalWS496_g251354 = temp_output_483_0_g251354;
					half3 Normal496_g251354 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251354 = SamplePlanar2D( Texture496_g251354 , Sampler496_g251354 , XZ496_g251354 , Bias496_g251354 , NormalWS496_g251354 , Normal496_g251354 );
					float4 temp_output_405_0_g241396 = localSamplePlanar2D496_g251354;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251354) = _MainShaderTex;
					SamplerState Sampler490_g251354 = staticSwitch38_g251353;
					float2 temp_output_462_0_g251354 = (Out_MaskB456_g251354).xy;
					half2 ZY490_g251354 = temp_output_462_0_g251354;
					half2 XZ490_g251354 = temp_output_463_0_g251354;
					float2 temp_output_464_0_g251354 = (Out_MaskC456_g251354).xy;
					half2 XY490_g251354 = temp_output_464_0_g251354;
					half Bias490_g251354 = temp_output_504_0_g251354;
					float3 temp_output_482_0_g251354 = (Out_MaskN456_g251354).xyz;
					half3 Triplanar490_g251354 = temp_output_482_0_g251354;
					half3 NormalWS490_g251354 = temp_output_483_0_g251354;
					half3 Normal490_g251354 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251354 = SamplePlanar3D( Texture490_g251354 , Sampler490_g251354 , ZY490_g251354 , XZ490_g251354 , XY490_g251354 , Bias490_g251354 , Triplanar490_g251354 , NormalWS490_g251354 , Normal490_g251354 );
					float4 temp_output_405_201_g241396 = localSamplePlanar3D490_g251354;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251354) = _MainShaderTex;
					SamplerState Sampler498_g251354 = staticSwitch38_g251353;
					half2 XZ498_g251354 = temp_output_463_0_g251354;
					float2 temp_output_473_0_g251354 = (Out_MaskE456_g251354).xy;
					half2 XZ_1498_g251354 = temp_output_473_0_g251354;
					float2 temp_output_474_0_g251354 = (Out_MaskE456_g251354).zw;
					half2 XZ_2498_g251354 = temp_output_474_0_g251354;
					float2 temp_output_475_0_g251354 = (Out_MaskF456_g251354).xy;
					half2 XZ_3498_g251354 = temp_output_475_0_g251354;
					float temp_output_510_0_g251354 = exp2( temp_output_504_0_g251354 );
					half Bias498_g251354 = temp_output_510_0_g251354;
					float3 temp_output_480_0_g251354 = (Out_MaskI456_g251354).xyz;
					half3 Weights_2498_g251354 = temp_output_480_0_g251354;
					half3 NormalWS498_g251354 = temp_output_483_0_g251354;
					half3 Normal498_g251354 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251354 = SampleStochastic2D( Texture498_g251354 , Sampler498_g251354 , XZ498_g251354 , XZ_1498_g251354 , XZ_2498_g251354 , XZ_3498_g251354 , Bias498_g251354 , Weights_2498_g251354 , NormalWS498_g251354 , Normal498_g251354 );
					float4 temp_output_405_202_g241396 = localSampleStochastic2D498_g251354;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251354) = _MainShaderTex;
					SamplerState Sampler500_g251354 = staticSwitch38_g251353;
					half2 ZY500_g251354 = temp_output_462_0_g251354;
					half2 ZY_1500_g251354 = (Out_MaskC456_g251354).zw;
					half2 ZY_2500_g251354 = (Out_MaskD456_g251354).xy;
					half2 ZY_3500_g251354 = (Out_MaskD456_g251354).zw;
					half2 XZ500_g251354 = temp_output_463_0_g251354;
					half2 XZ_1500_g251354 = temp_output_473_0_g251354;
					half2 XZ_2500_g251354 = temp_output_474_0_g251354;
					half2 XZ_3500_g251354 = temp_output_475_0_g251354;
					half2 XY500_g251354 = temp_output_464_0_g251354;
					half2 XY_1500_g251354 = (Out_MaskF456_g251354).zw;
					half2 XY_2500_g251354 = (Out_MaskG456_g251354).xy;
					half2 XY_3500_g251354 = (Out_MaskG456_g251354).zw;
					half Bias500_g251354 = temp_output_510_0_g251354;
					half3 Weights_1500_g251354 = (Out_MaskH456_g251354).xyz;
					half3 Weights_2500_g251354 = temp_output_480_0_g251354;
					half3 Weights_3500_g251354 = (Out_MaskJ456_g251354).xyz;
					half3 Triplanar500_g251354 = temp_output_482_0_g251354;
					half3 NormalWS500_g251354 = temp_output_483_0_g251354;
					half3 Normal500_g251354 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251354 = SampleStochastic3D( Texture500_g251354 , Sampler500_g251354 , ZY500_g251354 , ZY_1500_g251354 , ZY_2500_g251354 , ZY_3500_g251354 , XZ500_g251354 , XZ_1500_g251354 , XZ_2500_g251354 , XZ_3500_g251354 , XY500_g251354 , XY_1500_g251354 , XY_2500_g251354 , XY_3500_g251354 , Bias500_g251354 , Weights_1500_g251354 , Weights_2500_g251354 , Weights_3500_g251354 , Triplanar500_g251354 , NormalWS500_g251354 , Normal500_g251354 );
					float4 temp_output_405_203_g241396 = localSampleStochastic3D500_g251354;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g241396 = temp_output_405_277_g241396;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g241396 = temp_output_405_278_g241396;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g241396 = temp_output_405_0_g241396;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g241396 = temp_output_405_201_g241396;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g241396 = temp_output_405_202_g241396;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g241396 = temp_output_405_203_g241396;
					#else
					float4 staticSwitch198_g241396 = temp_output_405_277_g241396;
					#endif
					half4 Local_ShaderSample199_g241396 = staticSwitch198_g241396;
					float temp_output_209_0_g241396 = (Local_ShaderSample199_g241396).y;
					float temp_output_7_0_g251323 = _MainOcclusionRemap.x;
					float temp_output_9_0_g251323 = ( temp_output_209_0_g241396 - temp_output_7_0_g251323 );
					float lerpResult23_g241396 = lerp( 1.0 , saturate( ( temp_output_9_0_g251323 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g241396 = lerpResult23_g241396;
					float temp_output_213_0_g241396 = (Local_ShaderSample199_g241396).w;
					float temp_output_7_0_g251327 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g251327 = ( temp_output_213_0_g241396 - temp_output_7_0_g251327 );
					half Local_Smoothness317_g241396 = ( saturate( ( temp_output_9_0_g251327 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g241396 = (float4(( (Local_ShaderSample199_g241396).x * _MainMetallicValue ) , Local_Occlusion313_g241396 , (Local_ShaderSample199_g241396).z , Local_Smoothness317_g241396));
					half4 Local_Masks109_g241396 = appendResult73_g241396;
					float temp_output_135_0_g241396 = (Local_Masks109_g241396).z;
					float temp_output_7_0_g251322 = _MainMultiRemap.x;
					float temp_output_9_0_g251322 = ( temp_output_135_0_g241396 - temp_output_7_0_g251322 );
					float temp_output_42_0_g241396 = saturate( ( temp_output_9_0_g251322 * _MainMultiRemap.z ) );
					half Local_MultiMask78_g241396 = temp_output_42_0_g241396;
					float lerpResult58_g241396 = lerp( 1.0 , Local_MultiMask78_g241396 , _MainColorMode);
					float4 lerpResult62_g241396 = lerp( _MainColorTwo , _MainColor , lerpResult58_g241396);
					half3 Local_ColorRGB93_g241396 = (lerpResult62_g241396).rgb;
					half3 Local_Albedo139_g241396 = ( Local_AlbedoRGB107_g241396 * Local_ColorRGB93_g241396 );
					float3 temp_output_4_0_g251315 = Local_Albedo139_g241396;
					float3 In_Albedo3_g251315 = temp_output_4_0_g251315;
					float3 temp_output_44_0_g251315 = Local_Albedo139_g241396;
					float3 In_AlbedoBase3_g251315 = temp_output_44_0_g251315;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251355) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g251352 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g251352 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g251352 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g251352 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g251352 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g251352 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251355 = staticSwitch37_g251352;
					float localBreakTextureData456_g251355 = ( 0.0 );
					TVEMasksData Data456_g251355 =(TVEMasksData)Data431_g251346;
					float4 Out_MaskA456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251355 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251355 , Out_MaskA456_g251355 , Out_MaskB456_g251355 , Out_MaskC456_g251355 , Out_MaskD456_g251355 , Out_MaskE456_g251355 , Out_MaskF456_g251355 , Out_MaskG456_g251355 , Out_MaskH456_g251355 , Out_MaskI456_g251355 , Out_MaskJ456_g251355 , Out_MaskK456_g251355 , Out_MaskL456_g251355 , Out_MaskM456_g251355 , Out_MaskN456_g251355 );
					half2 UV276_g251355 = (Out_MaskA456_g251355).xy;
					float temp_output_504_0_g251355 = 0.0;
					half Bias276_g251355 = temp_output_504_0_g251355;
					half2 Normal276_g251355 = float2( 0,0 );
					half4 localSampleCoord276_g251355 = SampleCoord( Texture276_g251355 , Sampler276_g251355 , UV276_g251355 , Bias276_g251355 , Normal276_g251355 );
					float2 temp_output_406_394_g241396 = Normal276_g251355;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251355) = _MainNormalTex;
					SamplerState Sampler502_g251355 = staticSwitch37_g251352;
					half2 UV502_g251355 = (Out_MaskA456_g251355).zw;
					half Bias502_g251355 = temp_output_504_0_g251355;
					half2 Normal502_g251355 = float2( 0,0 );
					half4 localSampleCoord502_g251355 = SampleCoord( Texture502_g251355 , Sampler502_g251355 , UV502_g251355 , Bias502_g251355 , Normal502_g251355 );
					float2 temp_output_406_397_g241396 = Normal502_g251355;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251355) = _MainNormalTex;
					SamplerState Sampler496_g251355 = staticSwitch37_g251352;
					float2 temp_output_463_0_g251355 = (Out_MaskB456_g251355).zw;
					half2 XZ496_g251355 = temp_output_463_0_g251355;
					half Bias496_g251355 = temp_output_504_0_g251355;
					float3 temp_output_483_0_g251355 = (Out_MaskK456_g251355).xyz;
					half3 NormalWS496_g251355 = temp_output_483_0_g251355;
					half3 Normal496_g251355 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251355 = SamplePlanar2D( Texture496_g251355 , Sampler496_g251355 , XZ496_g251355 , Bias496_g251355 , NormalWS496_g251355 , Normal496_g251355 );
					float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
					float3 worldToTangentDir408_g251355 = normalize( mul( ase_worldToTangent, Normal496_g251355 ) );
					float2 temp_output_406_375_g241396 = (worldToTangentDir408_g251355).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251355) = _MainNormalTex;
					SamplerState Sampler490_g251355 = staticSwitch37_g251352;
					float2 temp_output_462_0_g251355 = (Out_MaskB456_g251355).xy;
					half2 ZY490_g251355 = temp_output_462_0_g251355;
					half2 XZ490_g251355 = temp_output_463_0_g251355;
					float2 temp_output_464_0_g251355 = (Out_MaskC456_g251355).xy;
					half2 XY490_g251355 = temp_output_464_0_g251355;
					half Bias490_g251355 = temp_output_504_0_g251355;
					float3 temp_output_482_0_g251355 = (Out_MaskN456_g251355).xyz;
					half3 Triplanar490_g251355 = temp_output_482_0_g251355;
					half3 NormalWS490_g251355 = temp_output_483_0_g251355;
					half3 Normal490_g251355 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251355 = SamplePlanar3D( Texture490_g251355 , Sampler490_g251355 , ZY490_g251355 , XZ490_g251355 , XY490_g251355 , Bias490_g251355 , Triplanar490_g251355 , NormalWS490_g251355 , Normal490_g251355 );
					float3 worldToTangentDir399_g251355 = normalize( mul( ase_worldToTangent, Normal490_g251355 ) );
					float2 temp_output_406_353_g241396 = (worldToTangentDir399_g251355).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251355) = _MainNormalTex;
					SamplerState Sampler498_g251355 = staticSwitch37_g251352;
					half2 XZ498_g251355 = temp_output_463_0_g251355;
					float2 temp_output_473_0_g251355 = (Out_MaskE456_g251355).xy;
					half2 XZ_1498_g251355 = temp_output_473_0_g251355;
					float2 temp_output_474_0_g251355 = (Out_MaskE456_g251355).zw;
					half2 XZ_2498_g251355 = temp_output_474_0_g251355;
					float2 temp_output_475_0_g251355 = (Out_MaskF456_g251355).xy;
					half2 XZ_3498_g251355 = temp_output_475_0_g251355;
					float temp_output_510_0_g251355 = exp2( temp_output_504_0_g251355 );
					half Bias498_g251355 = temp_output_510_0_g251355;
					float3 temp_output_480_0_g251355 = (Out_MaskI456_g251355).xyz;
					half3 Weights_2498_g251355 = temp_output_480_0_g251355;
					half3 NormalWS498_g251355 = temp_output_483_0_g251355;
					half3 Normal498_g251355 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251355 = SampleStochastic2D( Texture498_g251355 , Sampler498_g251355 , XZ498_g251355 , XZ_1498_g251355 , XZ_2498_g251355 , XZ_3498_g251355 , Bias498_g251355 , Weights_2498_g251355 , NormalWS498_g251355 , Normal498_g251355 );
					float3 worldToTangentDir411_g251355 = normalize( mul( ase_worldToTangent, Normal498_g251355 ) );
					float2 temp_output_406_391_g241396 = (worldToTangentDir411_g251355).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251355) = _MainNormalTex;
					SamplerState Sampler500_g251355 = staticSwitch37_g251352;
					half2 ZY500_g251355 = temp_output_462_0_g251355;
					half2 ZY_1500_g251355 = (Out_MaskC456_g251355).zw;
					half2 ZY_2500_g251355 = (Out_MaskD456_g251355).xy;
					half2 ZY_3500_g251355 = (Out_MaskD456_g251355).zw;
					half2 XZ500_g251355 = temp_output_463_0_g251355;
					half2 XZ_1500_g251355 = temp_output_473_0_g251355;
					half2 XZ_2500_g251355 = temp_output_474_0_g251355;
					half2 XZ_3500_g251355 = temp_output_475_0_g251355;
					half2 XY500_g251355 = temp_output_464_0_g251355;
					half2 XY_1500_g251355 = (Out_MaskF456_g251355).zw;
					half2 XY_2500_g251355 = (Out_MaskG456_g251355).xy;
					half2 XY_3500_g251355 = (Out_MaskG456_g251355).zw;
					half Bias500_g251355 = temp_output_510_0_g251355;
					half3 Weights_1500_g251355 = (Out_MaskH456_g251355).xyz;
					half3 Weights_2500_g251355 = temp_output_480_0_g251355;
					half3 Weights_3500_g251355 = (Out_MaskJ456_g251355).xyz;
					half3 Triplanar500_g251355 = temp_output_482_0_g251355;
					half3 NormalWS500_g251355 = temp_output_483_0_g251355;
					half3 Normal500_g251355 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251355 = SampleStochastic3D( Texture500_g251355 , Sampler500_g251355 , ZY500_g251355 , ZY_1500_g251355 , ZY_2500_g251355 , ZY_3500_g251355 , XZ500_g251355 , XZ_1500_g251355 , XZ_2500_g251355 , XZ_3500_g251355 , XY500_g251355 , XY_1500_g251355 , XY_2500_g251355 , XY_3500_g251355 , Bias500_g251355 , Weights_1500_g251355 , Weights_2500_g251355 , Weights_3500_g251355 , Triplanar500_g251355 , NormalWS500_g251355 , Normal500_g251355 );
					float3 worldToTangentDir403_g251355 = normalize( mul( ase_worldToTangent, Normal500_g251355 ) );
					float2 temp_output_406_390_g241396 = (worldToTangentDir403_g251355).xy;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g241396 = temp_output_406_394_g241396;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g241396 = temp_output_406_397_g241396;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g241396 = temp_output_406_375_g241396;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g241396 = temp_output_406_353_g241396;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g241396 = temp_output_406_391_g241396;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g241396 = temp_output_406_390_g241396;
					#else
					float2 staticSwitch193_g241396 = temp_output_406_394_g241396;
					#endif
					half2 Local_NormaSample191_g241396 = staticSwitch193_g241396;
					half2 Local_NormalTS108_g241396 = ( Local_NormaSample191_g241396 * _MainNormalValue );
					float2 In_NormalTS3_g251315 = Local_NormalTS108_g241396;
					float3 appendResult68_g251329 = (float3(Local_NormalTS108_g241396 , 1.0));
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal74_g251329 = appendResult68_g251329;
					float3 worldNormal74_g251329 = normalize( float3( dot( tanToWorld0, tanNormal74_g251329 ), dot( tanToWorld1, tanNormal74_g251329 ), dot( tanToWorld2, tanNormal74_g251329 ) ) );
					half3 Local_NormalWS250_g241396 = worldNormal74_g251329;
					float3 In_NormalWS3_g251315 = Local_NormalWS250_g241396;
					float4 In_Shader3_g251315 = Local_Masks109_g241396;
					float4 In_Feature3_g251315 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251315 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251315 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g251326 = Local_Albedo139_g241396;
					float dotResult20_g251326 = dot( temp_output_3_0_g251326 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g241396 = dotResult20_g251326;
					float temp_output_12_0_g251315 = Local_Grayscale110_g241396;
					float In_Grayscale3_g251315 = temp_output_12_0_g251315;
					float clampResult27_g251328 = clamp( saturate( ( Local_Grayscale110_g241396 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g241396 = clampResult27_g251328;
					float temp_output_16_0_g251315 = Local_Luminosity145_g241396;
					float In_Luminosity3_g251315 = temp_output_16_0_g251315;
					float In_MultiMask3_g251315 = Local_MultiMask78_g241396;
					float temp_output_187_0_g241396 = (Local_AlbedoSample185_g241396).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g241396 = ( temp_output_187_0_g241396 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g241396 = temp_output_187_0_g241396;
					#endif
					half Local_AlphaClip111_g241396 = staticSwitch236_g241396;
					float In_AlphaClip3_g251315 = Local_AlphaClip111_g241396;
					half Local_AlphaFade246_g241396 = (lerpResult62_g241396).a;
					float In_AlphaFade3_g251315 = Local_AlphaFade246_g241396;
					float3 temp_cast_19 = (1.0).xxx;
					float3 In_Translucency3_g251315 = temp_cast_19;
					float In_Transmission3_g251315 = 1.0;
					float In_Thickness3_g251315 = 0.0;
					float In_Diffusion3_g251315 = 0.0;
					float In_Depth3_g251315 = 0.0;
					BuildVisualData( Data3_g251315 , In_Dummy3_g251315 , In_Albedo3_g251315 , In_AlbedoBase3_g251315 , In_NormalTS3_g251315 , In_NormalWS3_g251315 , In_Shader3_g251315 , In_Feature3_g251315 , In_Season3_g251315 , In_Emissive3_g251315 , In_Grayscale3_g251315 , In_Luminosity3_g251315 , In_MultiMask3_g251315 , In_AlphaClip3_g251315 , In_AlphaFade3_g251315 , In_Translucency3_g251315 , In_Transmission3_g251315 , In_Thickness3_g251315 , In_Diffusion3_g251315 , In_Depth3_g251315 );
					TVEVisualData Data4_g251475 =(TVEVisualData)Data3_g251315;
					float Out_Dummy4_g251475 = 0.0;
					float3 Out_Albedo4_g251475 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251475 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251475 = float2( 0,0 );
					float3 Out_NormalWS4_g251475 = float3( 0,0,0 );
					float4 Out_Shader4_g251475 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251475 = float4( 0,0,0,0 );
					float4 Out_Season4_g251475 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251475 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251475 = 0.0;
					float Out_Grayscale4_g251475 = 0.0;
					float Out_Luminosity4_g251475 = 0.0;
					float Out_AlphaClip4_g251475 = 0.0;
					float Out_AlphaFade4_g251475 = 0.0;
					float3 Out_Translucency4_g251475 = float3( 0,0,0 );
					float Out_Transmission4_g251475 = 0.0;
					float Out_Thickness4_g251475 = 0.0;
					float Out_Diffusion4_g251475 = 0.0;
					float Out_Depth4_g251475 = 0.0;
					BreakVisualData( Data4_g251475 , Out_Dummy4_g251475 , Out_Albedo4_g251475 , Out_AlbedoBase4_g251475 , Out_NormalTS4_g251475 , Out_NormalWS4_g251475 , Out_Shader4_g251475 , Out_Feature4_g251475 , Out_Season4_g251475 , Out_Emissive4_g251475 , Out_MultiMask4_g251475 , Out_Grayscale4_g251475 , Out_Luminosity4_g251475 , Out_AlphaClip4_g251475 , Out_AlphaFade4_g251475 , Out_Translucency4_g251475 , Out_Transmission4_g251475 , Out_Thickness4_g251475 , Out_Diffusion4_g251475 , Out_Depth4_g251475 );
					float temp_output_739_15_g251434 = Out_Luminosity4_g251475;
					half Visual_Luminosity654_g251434 = temp_output_739_15_g251434;
					float temp_output_7_0_g251446 = _OverlayLumaRemap.x;
					float temp_output_9_0_g251446 = ( Visual_Luminosity654_g251434 - temp_output_7_0_g251446 );
					float lerpResult587_g251434 = lerp( 1.0 , saturate( ( temp_output_9_0_g251446 * _OverlayLumaRemap.z ) ) , _OverlayLumaValue);
					half Blend_LumaMask438_g251434 = lerpResult587_g251434;
					float temp_output_17_0_g251464 = _OverlayMeshMode;
					float Option70_g251464 = temp_output_17_0_g251464;
					TVEModelData Data15_g251477 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g251477 = 0.0;
					float3 Out_PositionWS15_g251477 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251477 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251477 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251477 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251477 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251477 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251477 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251477 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251477 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251477 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251477 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251477 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251477 , Out_Dummy15_g251477 , Out_PositionWS15_g251477 , Out_PositionWO15_g251477 , Out_PivotWS15_g251477 , Out_PivotWO15_g251477 , Out_NormalWS15_g251477 , Out_TangentWS15_g251477 , Out_BitangentWS15_g251477 , Out_TriplanarWeights15_g251477 , Out_ViewDirWS15_g251477 , Out_CoordsData15_g251477 , Out_VertexData15_g251477 , Out_PhaseData15_g251477 );
					half4 Model_VertexData791_g251434 = Out_VertexData15_g251477;
					float4 temp_output_3_0_g251464 = Model_VertexData791_g251434;
					float4 Channel70_g251464 = temp_output_3_0_g251464;
					float localSwitchChannel470_g251464 = SwitchChannel4( Option70_g251464 , Channel70_g251464 );
					float temp_output_1142_0_g251434 = localSwitchChannel470_g251464;
					float temp_output_7_0_g251444 = _OverlayMeshRemap.x;
					float temp_output_9_0_g251444 = ( temp_output_1142_0_g251434 - temp_output_7_0_g251444 );
					float lerpResult881_g251434 = lerp( 1.0 , saturate( ( temp_output_9_0_g251444 * _OverlayMeshRemap.z ) ) , _OverlayMeshValue);
					half Blend_VertMask801_g251434 = lerpResult881_g251434;
					float3 temp_output_739_21_g251434 = Out_NormalWS4_g251475;
					half3 Visual_NormalWS749_g251434 = temp_output_739_21_g251434;
					float temp_output_505_0_g251434 = saturate( (Visual_NormalWS749_g251434).y );
					float temp_output_7_0_g251449 = _OverlayProjRemap.x;
					float temp_output_9_0_g251449 = ( temp_output_505_0_g251434 - temp_output_7_0_g251449 );
					float lerpResult842_g251434 = lerp( 1.0 , saturate( ( temp_output_9_0_g251449 * _OverlayProjRemap.z ) ) , _OverlayProjValue);
					half Blend_ProjMask457_g251434 = lerpResult842_g251434;
					half Blend_NoiseMask427_g251434 = 1.0;
					half Blend_UserMask646_g251434 = 1.0;
					half Blend_FormMask_Mul958_g251434 = 1.0;
					half Blend_GlobalMask429_g251434 = 1.0;
					half Blend_FormMask_Add957_g251434 = 0.0;
					float temp_output_970_0_g251434 = ( saturate( ( ( Blend_TexMask908_g251434 * Blend_LumaMask438_g251434 * Blend_VertMask801_g251434 * Blend_ProjMask457_g251434 * Blend_NoiseMask427_g251434 * Blend_UserMask646_g251434 * Blend_FormMask_Mul958_g251434 * Blend_GlobalMask429_g251434 ) + Blend_FormMask_Add957_g251434 ) ) * _OverlayIntensityValue );
					float temp_output_7_0_g251452 = _OverlayBlendRemap.x;
					float temp_output_9_0_g251452 = ( temp_output_970_0_g251434 - temp_output_7_0_g251452 );
					half Blend_Mask494_g251434 = saturate( ( temp_output_9_0_g251452 * _OverlayBlendRemap.z ) );
					half Blend_BakerMask998_g251434 = ( Blend_TexMask908_g251434 * Blend_LumaMask438_g251434 * Blend_VertMask801_g251434 );
					float4 appendResult993_g251434 = (float4(Blend_Mask494_g251434 , 0.0 , 0.0 , Blend_BakerMask998_g251434));
					float4 temp_cast_20 = (0.0).xxxx;
					float4 temp_cast_21 = (0.0).xxxx;
					float4 ifLocalVar18_g251482 = 0;
					if( Feature_Intensity1107_g251434 <= 0.0 )
					ifLocalVar18_g251482 = temp_cast_21;
					else
					ifLocalVar18_g251482 = appendResult993_g251434;
					float4 In_MaskB3_g251483 = ifLocalVar18_g251482;
					float4 temp_cast_22 = (0.0).xxxx;
					float4 In_MaskC3_g251483 = temp_cast_22;
					float4 temp_cast_23 = (0.0).xxxx;
					float4 In_MaskD3_g251483 = temp_cast_23;
					float4 temp_cast_24 = (0.0).xxxx;
					float4 In_MaskE3_g251483 = temp_cast_24;
					float4 temp_cast_25 = (0.0).xxxx;
					float4 In_MaskF3_g251483 = temp_cast_25;
					float4 temp_cast_26 = (0.0).xxxx;
					float4 In_MaskG3_g251483 = temp_cast_26;
					float4 temp_cast_27 = (0.0).xxxx;
					float4 In_MaskH3_g251483 = temp_cast_27;
					float4 temp_cast_28 = (0.0).xxxx;
					float4 In_MaskI3_g251483 = temp_cast_28;
					float4 temp_cast_29 = (0.0).xxxx;
					float4 In_MaskJ3_g251483 = temp_cast_29;
					float4 temp_cast_30 = (0.0).xxxx;
					float4 In_MaskK3_g251483 = temp_cast_30;
					float4 temp_cast_31 = (0.0).xxxx;
					float4 In_MaskL3_g251483 = temp_cast_31;
					{
					Data3_g251483.MaskA = In_MaskA3_g251483;
					Data3_g251483.MaskB = In_MaskB3_g251483;
					Data3_g251483.MaskC = In_MaskC3_g251483;
					Data3_g251483.MaskD = In_MaskD3_g251483;
					Data3_g251483.MaskE = In_MaskE3_g251483;
					Data3_g251483.MaskF = In_MaskF3_g251483;
					Data3_g251483.MaskG = In_MaskG3_g251483;
					Data3_g251483.MaskH = In_MaskH3_g251483;
					Data3_g251483.MaskI = In_MaskI3_g251483;
					Data3_g251483.MaskJ= In_MaskJ3_g251483;
					Data3_g251483.MaskK= In_MaskK3_g251483;
					Data3_g251483.MaskL = In_MaskL3_g251483;
					}
					TVEMasksData DataA25_g251541 = Data3_g251483;
					float localBuildMasksData3_g251536 = ( 0.0 );
					TVEMasksData Data3_g251536 = (TVEMasksData)0;
					half Feature_Intensity1107_g251487 = _OverlayIntensityValue;
					float ifLocalVar18_g251532 = 0;
					if( Feature_Intensity1107_g251487 <= 0.0 )
					ifLocalVar18_g251532 = 0.0;
					else
					ifLocalVar18_g251532 = 1.0;
					half Feature_Maps1112_g251487 = _OverlayTextureMode;
					float ifLocalVar18_g251533 = 0;
					if( Feature_Maps1112_g251487 <= 0.0 )
					ifLocalVar18_g251533 = 0.0;
					else
					ifLocalVar18_g251533 = 1.0;
					half Feature_Glitter1108_g251487 = _OverlayGlitterIntensityValue;
					float ifLocalVar18_g251534 = 0;
					if( Feature_Glitter1108_g251487 <= 0.0 )
					ifLocalVar18_g251534 = 0.0;
					else
					ifLocalVar18_g251534 = 1.0;
					half Feature_Element1085_g251487 = _OverlayElementMode;
					float ifLocalVar18_g251531 = 0;
					if( Feature_Element1085_g251487 <= 0.0 )
					ifLocalVar18_g251531 = 0.0;
					else
					ifLocalVar18_g251531 = 1.0;
					float4 appendResult1117_g251487 = (float4(ifLocalVar18_g251532 , ifLocalVar18_g251533 , ifLocalVar18_g251534 , ifLocalVar18_g251531));
					float4 In_MaskA3_g251536 = appendResult1117_g251487;
					half Blend_TexMask908_g251487 = 1.0;
					float localBreakVisualData4_g251528 = ( 0.0 );
					TVEVisualData Data4_g251528 =(TVEVisualData)Data3_g251315;
					float Out_Dummy4_g251528 = 0.0;
					float3 Out_Albedo4_g251528 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251528 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251528 = float2( 0,0 );
					float3 Out_NormalWS4_g251528 = float3( 0,0,0 );
					float4 Out_Shader4_g251528 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251528 = float4( 0,0,0,0 );
					float4 Out_Season4_g251528 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251528 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251528 = 0.0;
					float Out_Grayscale4_g251528 = 0.0;
					float Out_Luminosity4_g251528 = 0.0;
					float Out_AlphaClip4_g251528 = 0.0;
					float Out_AlphaFade4_g251528 = 0.0;
					float3 Out_Translucency4_g251528 = float3( 0,0,0 );
					float Out_Transmission4_g251528 = 0.0;
					float Out_Thickness4_g251528 = 0.0;
					float Out_Diffusion4_g251528 = 0.0;
					float Out_Depth4_g251528 = 0.0;
					BreakVisualData( Data4_g251528 , Out_Dummy4_g251528 , Out_Albedo4_g251528 , Out_AlbedoBase4_g251528 , Out_NormalTS4_g251528 , Out_NormalWS4_g251528 , Out_Shader4_g251528 , Out_Feature4_g251528 , Out_Season4_g251528 , Out_Emissive4_g251528 , Out_MultiMask4_g251528 , Out_Grayscale4_g251528 , Out_Luminosity4_g251528 , Out_AlphaClip4_g251528 , Out_AlphaFade4_g251528 , Out_Translucency4_g251528 , Out_Transmission4_g251528 , Out_Thickness4_g251528 , Out_Diffusion4_g251528 , Out_Depth4_g251528 );
					float temp_output_739_15_g251487 = Out_Luminosity4_g251528;
					half Visual_Luminosity654_g251487 = temp_output_739_15_g251487;
					float temp_output_7_0_g251499 = _OverlayLumaRemap.x;
					float temp_output_9_0_g251499 = ( Visual_Luminosity654_g251487 - temp_output_7_0_g251499 );
					float lerpResult587_g251487 = lerp( 1.0 , saturate( ( temp_output_9_0_g251499 * _OverlayLumaRemap.z ) ) , _OverlayLumaValue);
					half Blend_LumaMask438_g251487 = lerpResult587_g251487;
					float temp_output_17_0_g251517 = _OverlayMeshMode;
					float Option70_g251517 = temp_output_17_0_g251517;
					TVEModelData Data15_g251530 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g251530 = 0.0;
					float3 Out_PositionWS15_g251530 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251530 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251530 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251530 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251530 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251530 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251530 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251530 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251530 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251530 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251530 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251530 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251530 , Out_Dummy15_g251530 , Out_PositionWS15_g251530 , Out_PositionWO15_g251530 , Out_PivotWS15_g251530 , Out_PivotWO15_g251530 , Out_NormalWS15_g251530 , Out_TangentWS15_g251530 , Out_BitangentWS15_g251530 , Out_TriplanarWeights15_g251530 , Out_ViewDirWS15_g251530 , Out_CoordsData15_g251530 , Out_VertexData15_g251530 , Out_PhaseData15_g251530 );
					half4 Model_VertexData791_g251487 = Out_VertexData15_g251530;
					float4 temp_output_3_0_g251517 = Model_VertexData791_g251487;
					float4 Channel70_g251517 = temp_output_3_0_g251517;
					float localSwitchChannel470_g251517 = SwitchChannel4( Option70_g251517 , Channel70_g251517 );
					float temp_output_1142_0_g251487 = localSwitchChannel470_g251517;
					float temp_output_7_0_g251497 = _OverlayMeshRemap.x;
					float temp_output_9_0_g251497 = ( temp_output_1142_0_g251487 - temp_output_7_0_g251497 );
					float lerpResult881_g251487 = lerp( 1.0 , saturate( ( temp_output_9_0_g251497 * _OverlayMeshRemap.z ) ) , _OverlayMeshValue);
					half Blend_VertMask801_g251487 = lerpResult881_g251487;
					float3 temp_output_739_21_g251487 = Out_NormalWS4_g251528;
					half3 Visual_NormalWS749_g251487 = temp_output_739_21_g251487;
					float temp_output_505_0_g251487 = saturate( (Visual_NormalWS749_g251487).y );
					float temp_output_7_0_g251502 = _OverlayProjRemap.x;
					float temp_output_9_0_g251502 = ( temp_output_505_0_g251487 - temp_output_7_0_g251502 );
					float lerpResult842_g251487 = lerp( 1.0 , saturate( ( temp_output_9_0_g251502 * _OverlayProjRemap.z ) ) , _OverlayProjValue);
					half Blend_ProjMask457_g251487 = lerpResult842_g251487;
					half Blend_NoiseMask427_g251487 = 1.0;
					half Blend_UserMask646_g251487 = 1.0;
					half Blend_FormMask_Mul958_g251487 = 1.0;
					float localBuildGlobalData204_g251357 = ( 0.0 );
					TVEGlobalData Data204_g251357 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251357 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251357 = Dummy211_g251357;
					float4 temp_output_589_164_g251357 = TVE_CoatParams;
					half4 Coat_Params596_g251357 = temp_output_589_164_g251357;
					float4 In_CoatParams204_g251357 = Coat_Params596_g251357;
					float4 temp_output_203_0_g251377 = TVE_CoatBaseCoord;
					TVEModelData Data15_g251433 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g251433 = 0.0;
					float3 Out_PositionWS15_g251433 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251433 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251433 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251433 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251433 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251433 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251433 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251433 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251433 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251433 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251433 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251433 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251433 , Out_Dummy15_g251433 , Out_PositionWS15_g251433 , Out_PositionWO15_g251433 , Out_PivotWS15_g251433 , Out_PivotWO15_g251433 , Out_NormalWS15_g251433 , Out_TangentWS15_g251433 , Out_BitangentWS15_g251433 , Out_TriplanarWeights15_g251433 , Out_ViewDirWS15_g251433 , Out_CoordsData15_g251433 , Out_VertexData15_g251433 , Out_PhaseData15_g251433 );
					float3 Model_PositionWS497_g251357 = Out_PositionWS15_g251433;
					float2 Model_PositionWS_XZ143_g251357 = (Model_PositionWS497_g251357).xz;
					float3 Model_PivotWS498_g251357 = Out_PivotWS15_g251433;
					float2 Model_PivotWS_XZ145_g251357 = (Model_PivotWS498_g251357).xz;
					float2 lerpResult300_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251377 = lerpResult300_g251357;
					float temp_output_82_0_g251375 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251377 = temp_output_82_0_g251375;
					float4 tex2DArrayNode83_g251377 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251377).zw + ( (temp_output_203_0_g251377).xy * temp_output_81_0_g251377 ) ),temp_output_82_0_g251377) );
					float4 appendResult210_g251377 = (float4(tex2DArrayNode83_g251377.rgb , saturate( tex2DArrayNode83_g251377.a )));
					float4 temp_output_204_0_g251377 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251377 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251377).zw + ( (temp_output_204_0_g251377).xy * temp_output_81_0_g251377 ) ),temp_output_82_0_g251377) );
					float4 appendResult212_g251377 = (float4(tex2DArrayNode122_g251377.rgb , saturate( tex2DArrayNode122_g251377.a )));
					float4 TVE_RenderNearPositionR628_g251357 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251357 = saturate( ( distance( Model_PositionWS497_g251357 , (TVE_RenderNearPositionR628_g251357).xyz ) / (TVE_RenderNearPositionR628_g251357).w ) );
					float temp_output_7_0_g251358 = 1.0;
					float temp_output_9_0_g251358 = ( temp_output_507_0_g251357 - temp_output_7_0_g251358 );
					half TVE_RenderNearFadeValue635_g251357 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251357 = saturate( ( temp_output_9_0_g251358 / ( ( TVE_RenderNearFadeValue635_g251357 - temp_output_7_0_g251358 ) + 0.0001 ) ) );
					float4 lerpResult131_g251377 = lerp( appendResult210_g251377 , appendResult212_g251377 , Global_TexBlend509_g251357);
					float4 temp_output_159_109_g251375 = lerpResult131_g251377;
					float4 lerpResult168_g251375 = lerp( TVE_CoatParams , temp_output_159_109_g251375 , TVE_CoatLayers[(int)temp_output_82_0_g251375]);
					float4 temp_output_589_109_g251357 = lerpResult168_g251375;
					half4 Coat_Texture302_g251357 = temp_output_589_109_g251357;
					float4 In_CoatTexture204_g251357 = Coat_Texture302_g251357;
					float4 temp_output_595_164_g251357 = TVE_PaintParams;
					half4 Paint_Params575_g251357 = temp_output_595_164_g251357;
					float4 In_PaintParams204_g251357 = Paint_Params575_g251357;
					float4 temp_output_203_0_g251426 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251426 = lerpResult85_g251357;
					float temp_output_82_0_g251423 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251426 = temp_output_82_0_g251423;
					float4 tex2DArrayNode83_g251426 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251426).zw + ( (temp_output_203_0_g251426).xy * temp_output_81_0_g251426 ) ),temp_output_82_0_g251426) );
					float4 appendResult210_g251426 = (float4(tex2DArrayNode83_g251426.rgb , saturate( tex2DArrayNode83_g251426.a )));
					float4 temp_output_204_0_g251426 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251426 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251426).zw + ( (temp_output_204_0_g251426).xy * temp_output_81_0_g251426 ) ),temp_output_82_0_g251426) );
					float4 appendResult212_g251426 = (float4(tex2DArrayNode122_g251426.rgb , saturate( tex2DArrayNode122_g251426.a )));
					float4 lerpResult131_g251426 = lerp( appendResult210_g251426 , appendResult212_g251426 , Global_TexBlend509_g251357);
					float4 temp_output_171_109_g251423 = lerpResult131_g251426;
					float4 lerpResult174_g251423 = lerp( TVE_PaintParams , temp_output_171_109_g251423 , TVE_PaintLayers[(int)temp_output_82_0_g251423]);
					float4 temp_output_595_109_g251357 = lerpResult174_g251423;
					half4 Paint_Texture71_g251357 = temp_output_595_109_g251357;
					float4 In_PaintTexture204_g251357 = Paint_Texture71_g251357;
					float4 temp_output_590_141_g251357 = TVE_AtmoParams;
					half4 Atmo_Params601_g251357 = temp_output_590_141_g251357;
					float4 In_AtmoParams204_g251357 = Atmo_Params601_g251357;
					float4 temp_output_203_0_g251385 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251385 = lerpResult104_g251357;
					float temp_output_132_0_g251383 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251385 = temp_output_132_0_g251383;
					float4 tex2DArrayNode83_g251385 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251385).zw + ( (temp_output_203_0_g251385).xy * temp_output_81_0_g251385 ) ),temp_output_82_0_g251385) );
					float4 appendResult210_g251385 = (float4(tex2DArrayNode83_g251385.rgb , saturate( tex2DArrayNode83_g251385.a )));
					float4 temp_output_204_0_g251385 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251385 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251385).zw + ( (temp_output_204_0_g251385).xy * temp_output_81_0_g251385 ) ),temp_output_82_0_g251385) );
					float4 appendResult212_g251385 = (float4(tex2DArrayNode122_g251385.rgb , saturate( tex2DArrayNode122_g251385.a )));
					float4 lerpResult131_g251385 = lerp( appendResult210_g251385 , appendResult212_g251385 , Global_TexBlend509_g251357);
					float4 temp_output_137_109_g251383 = lerpResult131_g251385;
					float4 lerpResult145_g251383 = lerp( TVE_AtmoParams , temp_output_137_109_g251383 , TVE_AtmoLayers[(int)temp_output_132_0_g251383]);
					float4 temp_output_590_110_g251357 = lerpResult145_g251383;
					half4 Atmo_Texture80_g251357 = temp_output_590_110_g251357;
					float4 In_AtmoTexture204_g251357 = Atmo_Texture80_g251357;
					float4 temp_output_593_163_g251357 = TVE_GlowParams;
					half4 Glow_Params609_g251357 = temp_output_593_163_g251357;
					float4 In_GlowParams204_g251357 = Glow_Params609_g251357;
					float4 temp_output_203_0_g251401 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251401 = lerpResult247_g251357;
					float temp_output_82_0_g251399 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251401 = temp_output_82_0_g251399;
					float4 tex2DArrayNode83_g251401 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251401).zw + ( (temp_output_203_0_g251401).xy * temp_output_81_0_g251401 ) ),temp_output_82_0_g251401) );
					float4 appendResult210_g251401 = (float4(tex2DArrayNode83_g251401.rgb , saturate( tex2DArrayNode83_g251401.a )));
					float4 temp_output_204_0_g251401 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251401 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251401).zw + ( (temp_output_204_0_g251401).xy * temp_output_81_0_g251401 ) ),temp_output_82_0_g251401) );
					float4 appendResult212_g251401 = (float4(tex2DArrayNode122_g251401.rgb , saturate( tex2DArrayNode122_g251401.a )));
					float4 lerpResult131_g251401 = lerp( appendResult210_g251401 , appendResult212_g251401 , Global_TexBlend509_g251357);
					float4 temp_output_159_109_g251399 = lerpResult131_g251401;
					float4 lerpResult167_g251399 = lerp( TVE_GlowParams , temp_output_159_109_g251399 , TVE_GlowLayers[(int)temp_output_82_0_g251399]);
					float4 temp_output_593_109_g251357 = lerpResult167_g251399;
					half4 Glow_Texture248_g251357 = temp_output_593_109_g251357;
					float4 In_GlowTexture204_g251357 = Glow_Texture248_g251357;
					float4 temp_output_592_139_g251357 = TVE_FormParams;
					float4 Form_Params606_g251357 = temp_output_592_139_g251357;
					float4 In_FormParams204_g251357 = Form_Params606_g251357;
					float4 temp_output_203_0_g251417 = TVE_FormBaseCoord;
					float2 lerpResult168_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251417 = lerpResult168_g251357;
					float temp_output_130_0_g251415 = _GlobalFormLayerValue;
					float temp_output_82_0_g251417 = temp_output_130_0_g251415;
					float4 tex2DArrayNode83_g251417 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251417).zw + ( (temp_output_203_0_g251417).xy * temp_output_81_0_g251417 ) ),temp_output_82_0_g251417) );
					float4 appendResult210_g251417 = (float4(tex2DArrayNode83_g251417.rgb , saturate( tex2DArrayNode83_g251417.a )));
					float4 temp_output_204_0_g251417 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251417 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251417).zw + ( (temp_output_204_0_g251417).xy * temp_output_81_0_g251417 ) ),temp_output_82_0_g251417) );
					float4 appendResult212_g251417 = (float4(tex2DArrayNode122_g251417.rgb , saturate( tex2DArrayNode122_g251417.a )));
					float4 lerpResult131_g251417 = lerp( appendResult210_g251417 , appendResult212_g251417 , Global_TexBlend509_g251357);
					float4 temp_output_135_109_g251415 = lerpResult131_g251417;
					float4 lerpResult143_g251415 = lerp( TVE_FormParams , temp_output_135_109_g251415 , TVE_FormLayers[(int)temp_output_130_0_g251415]);
					float4 temp_output_592_0_g251357 = lerpResult143_g251415;
					float4 Form_Texture112_g251357 = temp_output_592_0_g251357;
					float4 In_FormTexture204_g251357 = Form_Texture112_g251357;
					float4 temp_output_594_145_g251357 = TVE_FlowParams;
					half4 Flow_Params612_g251357 = temp_output_594_145_g251357;
					float4 In_FlowParams204_g251357 = Flow_Params612_g251357;
					float4 temp_output_203_0_g251409 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251409 = lerpResult400_g251357;
					float temp_output_136_0_g251407 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251409 = temp_output_136_0_g251407;
					float4 tex2DArrayNode83_g251409 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251409).zw + ( (temp_output_203_0_g251409).xy * temp_output_81_0_g251409 ) ),temp_output_82_0_g251409) );
					float4 appendResult210_g251409 = (float4(tex2DArrayNode83_g251409.rgb , saturate( tex2DArrayNode83_g251409.a )));
					float4 temp_output_204_0_g251409 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251409 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251409).zw + ( (temp_output_204_0_g251409).xy * temp_output_81_0_g251409 ) ),temp_output_82_0_g251409) );
					float4 appendResult212_g251409 = (float4(tex2DArrayNode122_g251409.rgb , saturate( tex2DArrayNode122_g251409.a )));
					float4 lerpResult131_g251409 = lerp( appendResult210_g251409 , appendResult212_g251409 , Global_TexBlend509_g251357);
					float4 temp_output_141_109_g251407 = lerpResult131_g251409;
					float4 lerpResult149_g251407 = lerp( TVE_FlowParams , temp_output_141_109_g251407 , TVE_FlowLayers[(int)temp_output_136_0_g251407]);
					half4 Flow_Texture405_g251357 = lerpResult149_g251407;
					float4 In_FlowTexture204_g251357 = Flow_Texture405_g251357;
					BuildGlobalData( Data204_g251357 , In_Dummy204_g251357 , In_CoatParams204_g251357 , In_CoatTexture204_g251357 , In_PaintParams204_g251357 , In_PaintTexture204_g251357 , In_AtmoParams204_g251357 , In_AtmoTexture204_g251357 , In_GlowParams204_g251357 , In_GlowTexture204_g251357 , In_FormParams204_g251357 , In_FormTexture204_g251357 , In_FlowParams204_g251357 , In_FlowTexture204_g251357 );
					TVEGlobalData Data15_g251488 =(TVEGlobalData)Data204_g251357;
					float Out_Dummy15_g251488 = 0.0;
					float4 Out_CoatParams15_g251488 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251488 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251488 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251488 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251488 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251488 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251488 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251488 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251488 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251488 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251488 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251488 = float4( 0,0,0,0 );
					BreakData( Data15_g251488 , Out_Dummy15_g251488 , Out_CoatParams15_g251488 , Out_CoatTexture15_g251488 , Out_PaintParams15_g251488 , Out_PaintTexture15_g251488 , Out_AtmoParams15_g251488 , Out_AtmoTexture15_g251488 , Out_GlowParams15_g251488 , Out_GlowTexture15_g251488 , Out_FormParams15_g251488 , Out_FormTexture15_g251488 , Out_FlowParams15_g251488 , Out_FlowTexture15_g251488 );
					half4 Global_AtmoParams1143_g251487 = Out_AtmoParams15_g251488;
					float temp_output_1146_0_g251487 = (Global_AtmoParams1143_g251487).y;
					half4 Global_AtmoTexture516_g251487 = Out_AtmoTexture15_g251488;
					float temp_output_6_0_g251518 = (Global_AtmoTexture516_g251487).y;
					float temp_output_7_0_g251518 = _OverlayElementMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g251518 = ( temp_output_6_0_g251518 + temp_output_7_0_g251518 );
					#else
					float staticSwitch14_g251518 = temp_output_6_0_g251518;
					#endif
					float temp_output_939_0_g251487 = staticSwitch14_g251518;
					#ifdef TVE_OVERLAY_ELEMENT
					float staticSwitch705_g251487 = temp_output_939_0_g251487;
					#else
					float staticSwitch705_g251487 = temp_output_1146_0_g251487;
					#endif
					float lerpResult937_g251487 = lerp( 1.0 , ( staticSwitch705_g251487 * TVE_IsEnabled ) , _OverlayGlobalValue);
					half Blend_GlobalMask429_g251487 = lerpResult937_g251487;
					half Blend_FormMask_Add957_g251487 = 0.0;
					float temp_output_970_0_g251487 = ( saturate( ( ( Blend_TexMask908_g251487 * Blend_LumaMask438_g251487 * Blend_VertMask801_g251487 * Blend_ProjMask457_g251487 * Blend_NoiseMask427_g251487 * Blend_UserMask646_g251487 * Blend_FormMask_Mul958_g251487 * Blend_GlobalMask429_g251487 ) + Blend_FormMask_Add957_g251487 ) ) * _OverlayIntensityValue );
					float temp_output_7_0_g251505 = _OverlayBlendRemap.x;
					float temp_output_9_0_g251505 = ( temp_output_970_0_g251487 - temp_output_7_0_g251505 );
					half Blend_Mask494_g251487 = saturate( ( temp_output_9_0_g251505 * _OverlayBlendRemap.z ) );
					half Blend_BakerMask998_g251487 = ( Blend_TexMask908_g251487 * Blend_LumaMask438_g251487 * Blend_VertMask801_g251487 );
					float4 appendResult993_g251487 = (float4(Blend_Mask494_g251487 , 0.0 , 0.0 , Blend_BakerMask998_g251487));
					float4 temp_cast_38 = (0.0).xxxx;
					float4 temp_cast_39 = (0.0).xxxx;
					float4 ifLocalVar18_g251535 = 0;
					if( Feature_Intensity1107_g251487 <= 0.0 )
					ifLocalVar18_g251535 = temp_cast_39;
					else
					ifLocalVar18_g251535 = appendResult993_g251487;
					float4 In_MaskB3_g251536 = ifLocalVar18_g251535;
					float4 temp_cast_40 = (0.0).xxxx;
					float4 In_MaskC3_g251536 = temp_cast_40;
					float4 temp_cast_41 = (0.0).xxxx;
					float4 In_MaskD3_g251536 = temp_cast_41;
					float4 temp_cast_42 = (0.0).xxxx;
					float4 In_MaskE3_g251536 = temp_cast_42;
					float4 temp_cast_43 = (0.0).xxxx;
					float4 In_MaskF3_g251536 = temp_cast_43;
					float4 temp_cast_44 = (0.0).xxxx;
					float4 In_MaskG3_g251536 = temp_cast_44;
					float4 temp_cast_45 = (0.0).xxxx;
					float4 In_MaskH3_g251536 = temp_cast_45;
					float4 temp_cast_46 = (0.0).xxxx;
					float4 In_MaskI3_g251536 = temp_cast_46;
					float4 temp_cast_47 = (0.0).xxxx;
					float4 In_MaskJ3_g251536 = temp_cast_47;
					float4 temp_cast_48 = (0.0).xxxx;
					float4 In_MaskK3_g251536 = temp_cast_48;
					float4 temp_cast_49 = (0.0).xxxx;
					float4 In_MaskL3_g251536 = temp_cast_49;
					{
					Data3_g251536.MaskA = In_MaskA3_g251536;
					Data3_g251536.MaskB = In_MaskB3_g251536;
					Data3_g251536.MaskC = In_MaskC3_g251536;
					Data3_g251536.MaskD = In_MaskD3_g251536;
					Data3_g251536.MaskE = In_MaskE3_g251536;
					Data3_g251536.MaskF = In_MaskF3_g251536;
					Data3_g251536.MaskG = In_MaskG3_g251536;
					Data3_g251536.MaskH = In_MaskH3_g251536;
					Data3_g251536.MaskI = In_MaskI3_g251536;
					Data3_g251536.MaskJ= In_MaskJ3_g251536;
					Data3_g251536.MaskK= In_MaskK3_g251536;
					Data3_g251536.MaskL = In_MaskL3_g251536;
					}
					TVEMasksData DataB25_g251541 = Data3_g251536;
					float Alpha25_g251541 = TVE_DEBUG_Global;
					{
					if (Alpha25_g251541 < 0.5 )
					{
					Data25_g251541 = DataA25_g251541;
					}
					else
					{
					Data25_g251541 = DataB25_g251541;
					}
					}
					TVEMasksData Data4_g251542 = Data25_g251541;
					float4 Out_MaskA4_g251542 = float4( 0,0,0,0 );
					float4 Out_MaskB4_g251542 = float4( 0,0,0,0 );
					float4 Out_MaskC4_g251542 = float4( 0,0,0,0 );
					float4 Out_MaskD4_g251542 = float4( 0,0,0,0 );
					float4 Out_MaskE4_g251542 = float4( 0,0,0,0 );
					float4 Out_MaskF4_g251542 = float4( 0,0,0,0 );
					float4 Out_MaskG4_g251542 = float4( 0,0,0,0 );
					float4 Out_MaskH4_g251542 = float4( 0,0,0,0 );
					{
					Out_MaskA4_g251542 = Data4_g251542.MaskA;
					Out_MaskB4_g251542 = Data4_g251542.MaskB;
					Out_MaskC4_g251542 = Data4_g251542.MaskC;
					Out_MaskD4_g251542 = Data4_g251542.MaskD;
					Out_MaskE4_g251542 = Data4_g251542.MaskE;
					Out_MaskF4_g251542 = Data4_g251542.MaskF;
					Out_MaskG4_g251542 = Data4_g251542.MaskG;
					Out_MaskH4_g251542 = Data4_g251542.MaskH;
					}
					float4 temp_output_2509_14 = Out_MaskA4_g251542;
					float3 lerpResult2568 = lerp( color107_g251543 , color106_g251543 , (temp_output_2509_14).x);
					float3 ifLocalVar40_g251565 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g251565 = lerpResult2568;
					float3 color107_g251545 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251545 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2571 = lerp( color107_g251545 , color106_g251545 , (temp_output_2509_14).y);
					float3 ifLocalVar40_g251566 = 0;
					if( TVE_DEBUG_Index == 1.0 )
					ifLocalVar40_g251566 = lerpResult2571;
					float3 color107_g251547 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251547 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2603 = lerp( color107_g251547 , color106_g251547 , (temp_output_2509_14).z);
					float3 ifLocalVar40_g251567 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g251567 = lerpResult2603;
					float3 ifLocalVar40_g251569 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g251569 = (Out_MaskB4_g251542).xxx;
					float3 color107_g251549 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251549 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2607 = lerp( color107_g251549 , color106_g251549 , (temp_output_2509_14).w);
					float3 ifLocalVar40_g251568 = 0;
					if( TVE_DEBUG_Index == 6.0 )
					ifLocalVar40_g251568 = lerpResult2607;
					half3 Final_Debug2399 = ( ifLocalVar40_g251565 + ifLocalVar40_g251566 + ifLocalVar40_g251567 + ifLocalVar40_g251569 + ifLocalVar40_g251568 );
					float temp_output_7_0_g251594 = TVE_DEBUG_Min;
					float3 temp_cast_50 = (temp_output_7_0_g251594).xxx;
					float3 temp_output_9_0_g251594 = ( Final_Debug2399 - temp_cast_50 );
					float lerpResult76_g251586 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g251586 = lerpResult76_g251586;
					float3 lerpResult72_g251586 = lerp( (lerpResult73_g251587).rgb , saturate( ( temp_output_9_0_g251594 / ( ( TVE_DEBUG_Max - temp_output_7_0_g251594 ) + 0.0001 ) ) ) , Filter152_g251586);
					float dotResult61_g251586 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g251586 = ( 1.0 - saturate( dotResult61_g251586 ) );
					float Shading_Fresnel59_g251586 = (( 1.0 - ( temp_output_65_0_g251586 * temp_output_65_0_g251586 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g251586 = IN.ase_texcoord9;
					float depthLinearEye57_g251586 = LinearEyeDepth( ase_positionCS57_g251586.z / ase_positionCS57_g251586.w );
					float temp_output_69_0_g251586 = saturate(  (0.0 + ( depthLinearEye57_g251586 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g251586 = (( temp_output_69_0_g251586 * temp_output_69_0_g251586 )*0.5 + 0.5);
					float lerpResult84_g251586 = lerp( 1.0 , Shading_Fresnel59_g251586 , ( Shading_Distance58_g251586 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g251591 = ( 0.0 );
					TVEVisualData Data4_g251591 =(TVEVisualData)Data3_g251315;
					float Out_Dummy4_g251591 = 0.0;
					float3 Out_Albedo4_g251591 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251591 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251591 = float2( 0,0 );
					float3 Out_NormalWS4_g251591 = float3( 0,0,0 );
					float4 Out_Shader4_g251591 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251591 = float4( 0,0,0,0 );
					float4 Out_Season4_g251591 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251591 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251591 = 0.0;
					float Out_Grayscale4_g251591 = 0.0;
					float Out_Luminosity4_g251591 = 0.0;
					float Out_AlphaClip4_g251591 = 0.0;
					float Out_AlphaFade4_g251591 = 0.0;
					float3 Out_Translucency4_g251591 = float3( 0,0,0 );
					float Out_Transmission4_g251591 = 0.0;
					float Out_Thickness4_g251591 = 0.0;
					float Out_Diffusion4_g251591 = 0.0;
					float Out_Depth4_g251591 = 0.0;
					BreakVisualData( Data4_g251591 , Out_Dummy4_g251591 , Out_Albedo4_g251591 , Out_AlbedoBase4_g251591 , Out_NormalTS4_g251591 , Out_NormalWS4_g251591 , Out_Shader4_g251591 , Out_Feature4_g251591 , Out_Season4_g251591 , Out_Emissive4_g251591 , Out_MultiMask4_g251591 , Out_Grayscale4_g251591 , Out_Luminosity4_g251591 , Out_AlphaClip4_g251591 , Out_AlphaFade4_g251591 , Out_Translucency4_g251591 , Out_Transmission4_g251591 , Out_Thickness4_g251591 , Out_Diffusion4_g251591 , Out_Depth4_g251591 );
					float Alpha109_g251586 = Out_AlphaClip4_g251591;
					float lerpResult91_g251586 = lerp( 1.0 , Alpha109_g251586 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g251586 = lerp( 1.0 , lerpResult91_g251586 , Filter152_g251586);
					clip( lerpResult154_g251586 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2664_114;
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

					o.Emission = ( lerpResult72_g251586 * lerpResult84_g251586 );
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
				#define ASE_ABSOLUTE_VERTEX_POS 1
				#pragma multi_compile_instancing
				#define _SPECULAR_SETUP 1
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

				#define ASE_NEEDS_VERT_POSITION
				#define ASE_NEEDS_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_VERT_TANGENT
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_SCREEN_POSITION_NORMALIZED
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_COLOR
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
				#pragma shader_feature_local_fragment TVE_OVERLAY_ELEMENT
				#if defined (TVE_CLIPPING) //Render Clip
					#define TVE_ALPHA_CLIP //Render Clip
				#endif //Render Clip
				  
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
				#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY(tex,samplertex,coord) tex2DArray(tex,coord)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
				#endif//ASE Sampling Macros
				


				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					float4 texcoord : TEXCOORD0;
					float4 texcoord1 : TEXCOORD1;
					float4 texcoord2 : TEXCOORD2;
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_color : COLOR;
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
					float4 ase_color : COLOR;
					float4 ase_texcoord7 : TEXCOORD7;
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

				uniform half _IsTVEShader;
				uniform half TVE_DEBUG_Filter;
				uniform half TVE_DEBUG_Clip;
				uniform half TVE_DEBUG_Min;
				uniform half TVE_DEBUG_Max;
				uniform half TVE_DEBUG_Index;
				uniform half TVE_DEBUG_Shading;
				uniform half _ObjectCategory;
				uniform half _ObjectEnd;
				uniform half _ObjectModelMode;
				uniform half _ObjectPivotMode;
				uniform float3 TVE_WorldOrigin;
				uniform half _ObjectHeightValue;
				uniform half _ObjectRadiusValue;
				uniform half _ObjectPhaseMode;
				uniform float _IsShaderType;
				uniform half _ConformCategory;
				uniform half _ConformEnd;
				uniform half _ConformInfo;
				uniform half _GlobalCategory;
				uniform half _GlobalEnd;
				uniform half4 TVE_CoatParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatBaseTex);
				uniform float4 TVE_CoatBaseCoord;
				uniform half _GlobalCoatPivotValue;
				uniform half _GlobalCoatLayerValue;
				SamplerState sampler_Linear_Clamp;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatNearTex);
				uniform float4 TVE_CoatNearCoord;
				SamplerState sampler_Linear_Repeat;
				uniform float4 TVE_RenderNearPositionR;
				uniform half TVE_RenderNearFadeValue;
				uniform float TVE_CoatLayers[10];
				uniform half4 TVE_PaintParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintBaseTex);
				uniform float4 TVE_PaintBaseCoord;
				uniform half _GlobalPaintPivotValue;
				uniform half _GlobalPaintLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintNearTex);
				uniform float4 TVE_PaintNearCoord;
				uniform float TVE_PaintLayers[10];
				uniform half4 TVE_AtmoParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoBaseTex);
				uniform float4 TVE_AtmoBaseCoord;
				uniform half _GlobalAtmoPivotValue;
				uniform half _GlobalAtmoLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoNearTex);
				uniform float4 TVE_AtmoNearCoord;
				uniform float TVE_AtmoLayers[10];
				uniform half4 TVE_GlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowBaseTex);
				uniform float4 TVE_GlowBaseCoord;
				uniform half _GlobalGlowPivotValue;
				uniform half _GlobalGlowLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowNearTex);
				uniform float4 TVE_GlowNearCoord;
				uniform float TVE_GlowLayers[10];
				uniform half4 TVE_FormParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormBaseTex);
				uniform float4 TVE_FormBaseCoord;
				uniform half _GlobalFormPivotValue;
				uniform half _GlobalFormLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormNearTex);
				uniform float4 TVE_FormNearCoord;
				uniform float TVE_FormLayers[10];
				uniform half4 TVE_FlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowBaseTex);
				uniform float4 TVE_FlowBaseCoord;
				uniform half _GlobalFlowPivotValue;
				uniform half _GlobalFlowLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowNearTex);
				uniform float4 TVE_FlowNearCoord;
				uniform float TVE_FlowLayers[10];
				uniform half _ConformMode;
				uniform half _ConformOffsetValue;
				uniform half _ConformIntensityValue;
				uniform half _ConformMeshMode;
				uniform half4 _ConformMeshRemap;
				uniform half _ConformMeshValue;
				uniform half TVE_IsEnabled;
				uniform half _OverlayIntensityValue;
				uniform half _OverlayTextureMode;
				uniform half _OverlayGlitterIntensityValue;
				uniform half _OverlayElementMode;
				uniform half _MainCategory;
				uniform half _MainEnd;
				uniform half _MainSampleMode;
				uniform half _MainCoordMode;
				uniform half4 _MainCoordValue;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainAlbedoTex);
				SamplerState sampler_Linear_Repeat_Aniso8;
				SamplerState sampler_Point_Repeat;
				uniform half4 _main_coord_value;
				uniform half _MainAlbedoValue;
				uniform half4 _MainColorTwo;
				uniform half4 _MainColor;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainShaderTex);
				uniform half _MainMetallicValue;
				uniform half4 _MainOcclusionRemap;
				uniform half _MainOcclusionValue;
				uniform half4 _MainSmoothnessRemap;
				uniform half _MainSmoothnessValue;
				uniform half4 _MainMultiRemap;
				uniform half _MainColorMode;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MainNormalTex);
				uniform half _MainNormalValue;
				uniform half _MainAlphaClipValue;
				uniform half4 _OverlayLumaRemap;
				uniform half _OverlayLumaValue;
				uniform half _OverlayMeshMode;
				uniform half4 _OverlayMeshRemap;
				uniform half _OverlayMeshValue;
				uniform half4 _OverlayProjRemap;
				uniform half _OverlayProjValue;
				uniform half4 _OverlayBlendRemap;
				uniform half _OverlayGlobalValue;
				uniform half TVE_DEBUG_Global;
				uniform float _RenderClip;
				uniform float _IsElementShader;
				uniform float _IsHelperShader;


				half CapsuleMaskYUp( half3 Position, half Height, half Radius )
				{
					    float3 a = float3(0, Height, 0);
					    float3 ba = -a;
					    float3 pa = Position - a;
					    
					    float baDot = dot(ba, ba);
					    float h = saturate(dot(pa, ba) / baDot);
					    
					    float3 q = pa - ba * h;
					    return length(q) / Radius;
				}
				
				half CapsuleMaskZUp( half3 Position, half Height, half Radius )
				{
					    float3 a = float3(0, 0, Height);
					    float3 ba = -a;
					    float3 pa = Position - a;
					    
					    float baDot = dot(ba, ba);
					    float h = saturate(dot(pa, ba) / baDot);
					    
					    float3 q = pa - ba * h;
					    return length(q) / Radius;
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
				
				void BuildModelVertData( inout TVEModelData Data, half In_Dummy, float3 In_PositionOS, float3 In_PositionWS, float3 In_PositionWO, float3 In_PositionRawOS, float3 In_PivotOS, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalOS, half3 In_NormalWS, half3 In_NormalRawOS, half4 In_TangentOS, half3 In_TangentWS, half3 In_BitangentWS, half3 In_ViewDirWS, float4 In_CoordsData, float4 In_VertexData, half4 In_MasksData, half4 In_PhaseData, half4 In_TransformData, half4 In_RotationData, float4 In_InterpolatorA )
				{
					Data.Dummy = In_Dummy;
					Data.PositionOS = In_PositionOS;
					Data.PositionWS = In_PositionWS;
					Data.PositionWO = In_PositionWO;
					Data.PositionRawOS = In_PositionRawOS;
					Data.PivotOS = In_PivotOS;
					Data.PivotWS = In_PivotWS;
					Data.PivotWO = In_PivotWO;
					Data.NormalOS = In_NormalOS;
					Data.NormalWS = In_NormalWS;
					Data.NormalRawOS = In_NormalRawOS;
					Data.TangentOS = In_TangentOS;
					Data.TangentWS = In_TangentWS;
					Data.BitangentWS = In_BitangentWS;
					Data.ViewDirWS = In_ViewDirWS;
					Data.CoordsData = In_CoordsData;
					Data.VertexData = In_VertexData;
					Data.MasksData = In_MasksData;
					Data.PhaseData = In_PhaseData;
					Data.TransformData = In_TransformData;
					Data.RotationData = In_RotationData;
					Data.InterpolatorA = In_InterpolatorA ;
					return;
				}
				
				void BreakModelVertData( inout TVEModelData Data, out half Out_Dummy, out half3 Out_PositionOS, out half3 Out_PositionWS, out half3 Out_PositionWO, out half3 Out_PositionRawOS, out half3 Out_PivotOS, out half3 Out_PivotWS, out half3 Out_PivotWO, out half3 Out_NormalOS, out half3 Out_NormalWS, out half3 Out_NormalRawOS, out half4 Out_TangentOS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_MasksData, out half4 Out_PhaseData, out half4 Out_TransformData, out half4 Out_RotationData, out half4 Out_InterpolatorA )
				{
					Out_Dummy = Data.Dummy;
					Out_PositionOS = Data.PositionOS;
					Out_PositionWS = Data.PositionWS;
					Out_PositionWO = Data.PositionWO;
					Out_PositionRawOS = Data.PositionRawOS;
					Out_PivotOS = Data.PivotOS;
					Out_PivotWS = Data.PivotWS;
					Out_PivotWO = Data.PivotWO;
					Out_NormalOS = Data.NormalOS;
					Out_NormalWS = Data.NormalWS;
					Out_NormalRawOS = Data.NormalRawOS;
					Out_TangentOS = Data.TangentOS;
					Out_TangentWS = Data.TangentWS;
					Out_BitangentWS = Data.BitangentWS;
					Out_ViewDirWS = Data.ViewDirWS;
					Out_CoordsData = Data.CoordsData;
					Out_VertexData = Data.VertexData;
					Out_MasksData = Data.MasksData;
					Out_PhaseData = Data.PhaseData;
					Out_TransformData = Data.TransformData;
					Out_RotationData = Data.RotationData;
					Out_InterpolatorA = Data.InterpolatorA;
					return;
				}
				
				half3 ComputeTriplanarWeights( half3 NormalWS )
				{
					half3 powNormal = abs( NormalWS );
					half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
					tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
					return tempWeights;
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
				
				void BuildGlobalData( out TVEGlobalData Data, half In_Dummy, half4 In_CoatParams, half4 In_CoatTexture, half4 In_PaintParams, half4 In_PaintTexture, half4 In_AtmoParams, half4 In_AtmoTexture, half4 In_GlowParams, half4 In_GlowTexture, float4 In_FormParams, float4 In_FormTexture, half4 In_FlowParams, float4 In_FlowTexture )
				{
					Data = (TVEGlobalData)0;
					Data.Dummy = In_Dummy;
					Data.CoatParams= In_CoatParams;
					Data.CoatTexture = In_CoatTexture;
					Data.PaintParams = In_PaintParams;
					Data.PaintTexture = In_PaintTexture;
					Data.AtmoParams= In_AtmoParams;
					Data.AtmoTexture= In_AtmoTexture;
					Data.GlowParams= In_GlowParams;
					Data.GlowTexture= In_GlowTexture;
					Data.FormParams= In_FormParams;
					Data.FormTexture= In_FormTexture;
					Data.FlowParams= In_FlowParams;
					Data.FlowTexture= In_FlowTexture;
					return;
				}
				
				void BreakData( inout TVEGlobalData Data, out half Out_Dummy, out half4 Out_CoatParams, out half4 Out_CoatTexture, out half4 Out_PaintParams, out half4 Out_PaintTexture, out half4 Out_AtmoParams, out half4 Out_AtmoTexture, out half4 Out_GlowParams, out half4 Out_GlowTexture, out float4 Out_FormParams, out float4 Out_FormTexture, out half4 Out_FlowParams, out half4 Out_FlowTexture )
				{
					Out_Dummy = Data.Dummy;
					Out_CoatParams = Data.CoatParams;
					Out_CoatTexture = Data.CoatTexture;
					Out_PaintParams = Data.PaintParams;
					Out_PaintTexture = Data.PaintTexture;
					Out_AtmoParams= Data.AtmoParams;
					Out_AtmoTexture= Data.AtmoTexture;
					Out_GlowParams= Data.GlowParams;
					Out_GlowTexture= Data.GlowTexture;
					Out_FormParams= Data.FormParams;
					Out_FormTexture = Data.FormTexture;
					Out_FlowParams = Data.FlowParams;
					Out_FlowTexture = Data.FlowTexture;
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
				
				half4 SampleCoord( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, half2 UV, half Bias, out half2 Normal )
				{
					half4 tex = SAMPLE_TEXTURE2D_BIAS( Texture, Sampler, UV, Bias);
					Normal = tex.wy * 2.0 - 1.0;
					return tex;
				}
				
				half4 SamplePlanar2D( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, float2 XZ, half Bias, half3 NormalWS, out half3 Normal )
				{
					half4 tex_Y = SAMPLE_TEXTURE2D_BIAS(Texture, Sampler, XZ, Bias);
					half3 normal_Y = half3(tex_Y.wy * 2.0 - 1.0, 1.0);
					normal_Y = half3(normal_Y.xy + NormalWS.xz, NormalWS.y).xzy;
					Normal = normal_Y;
					return tex_Y;
				}
				
				half4 SamplePlanar3D( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, float2 ZY, float2 XZ, float2 XY, half Bias, half3 Triplanar, half3 NormalWS, out half3 Normal )
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
				
				half4 SampleStochastic2D( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, half Bias, half3 Weights_2, half3 NormalWS, out half3 Normal )
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
				
				half4 SampleStochastic3D( UNITY_DECLARE_TEX2D_NOSAMPLER(Texture), SamplerState Sampler, float2 ZY, float2 ZY_1, float2 ZY_2, float2 ZY_3, float2 XZ, float2 XZ_1, float2 XZ_2, float2 XZ_3, float2 XY, float2 XY_1, float2 XY_2, float2 XY_3, half Bias, half3 Weights_1, half3 Weights_2, half3 Weights_3, half3 Triplanar, half3 NormalWS, out half3 Normal )
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
				

				v2f VertexFunction (appdata v  ) {
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float localIfModelDataByShader26_g251540 = ( 0.0 );
					TVEModelData Data26_g251540 = (TVEModelData)0;
					TVEModelData Data16_g241385 =(TVEModelData)0;
					half Dummy207_g241375 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g241385 = Dummy207_g241375;
					float In_Dummy16_g241385 = temp_output_14_0_g241385;
					float3 PositionOS131_g241375 = v.vertex.xyz;
					float3 temp_output_4_0_g241385 = PositionOS131_g241375;
					float3 In_PositionOS16_g241385 = temp_output_4_0_g241385;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g241375 = ase_positionWS;
					float3 vertexToFrag73_g241375 = temp_output_104_7_g241375;
					float3 PositionWS122_g241375 = vertexToFrag73_g241375;
					float3 In_PositionWS16_g241385 = PositionWS122_g241375;
					float4x4 break19_g241378 = unity_ObjectToWorld;
					float3 appendResult20_g241378 = (float3(break19_g241378[ 0 ][ 3 ] , break19_g241378[ 1 ][ 3 ] , break19_g241378[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241375 = appendResult20_g241378;
					float4x4 break19_g241380 = unity_ObjectToWorld;
					float3 appendResult20_g241380 = (float3(break19_g241380[ 0 ][ 3 ] , break19_g241380[ 1 ][ 3 ] , break19_g241380[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g241376 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g241375 = PositionOS131_g241375;
					float3 appendResult234_g241375 = (float3(break233_g241375.x , 0.0 , break233_g241375.z));
					float3 break413_g241375 = PositionOS131_g241375;
					float3 appendResult414_g241375 = (float3(break413_g241375.x , break413_g241375.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g241382 = appendResult414_g241375;
					#else
					float3 staticSwitch65_g241382 = appendResult234_g241375;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g241375 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g241375 = appendResult60_g241376;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g241375 = staticSwitch65_g241382;
					#else
					float3 staticSwitch229_g241375 = _Vector0;
					#endif
					float3 PivotOS149_g241375 = staticSwitch229_g241375;
					float3 temp_output_122_0_g241380 = PivotOS149_g241375;
					float3 PivotsOnlyWS105_g241380 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g241380 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g241375 = ( appendResult20_g241380 + PivotsOnlyWS105_g241380 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g241375 = temp_output_340_7_g241375;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g241375 = temp_output_341_7_g241375;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g241375 = temp_output_341_7_g241375;
					#else
					float3 staticSwitch236_g241375 = temp_output_340_7_g241375;
					#endif
					float3 vertexToFrag76_g241375 = staticSwitch236_g241375;
					float3 PivotWS121_g241375 = vertexToFrag76_g241375;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241375 = ( PositionWS122_g241375 - PivotWS121_g241375 );
					#else
					float3 staticSwitch204_g241375 = PositionWS122_g241375;
					#endif
					float3 PositionWO132_g241375 = ( staticSwitch204_g241375 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241385 = PositionWO132_g241375;
					float3 In_PositionRawOS16_g241385 = PositionOS131_g241375;
					float3 In_PivotOS16_g241385 = PivotOS149_g241375;
					float3 In_PivotWS16_g241385 = PivotWS121_g241375;
					float3 PivotWO133_g241375 = ( PivotWS121_g241375 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241385 = PivotWO133_g241375;
					half3 NormalOS134_g241375 = v.normal;
					float3 temp_output_21_0_g241385 = NormalOS134_g241375;
					float3 In_NormalOS16_g241385 = temp_output_21_0_g241385;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g241375 = normalizedWorldNormal;
					float3 In_NormalWS16_g241385 = NormalWS95_g241375;
					float3 In_NormalRawOS16_g241385 = NormalOS134_g241375;
					half4 TangentlOS153_g241375 = v.tangent;
					float4 temp_output_6_0_g241385 = TangentlOS153_g241375;
					float4 In_TangentOS16_g241385 = temp_output_6_0_g241385;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g241375 = ase_tangentWS;
					float3 In_TangentWS16_g241385 = TangentWS136_g241375;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g241375 = ase_bitangentWS;
					float3 In_BitangentWS16_g241385 = BiangentWS421_g241375;
					float3 normalizeResult296_g241375 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241375 ) );
					half3 ViewDirWS169_g241375 = normalizeResult296_g241375;
					float3 In_ViewDirWS16_g241385 = ViewDirWS169_g241375;
					float4 appendResult397_g241375 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g241375 = appendResult397_g241375;
					float4 In_CoordsData16_g241385 = CoordsData398_g241375;
					half4 VertexMasks171_g241375 = v.ase_color;
					float4 In_VertexData16_g241385 = VertexMasks171_g241375;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241388 = (PositionOS131_g241375).z;
					#else
					float staticSwitch65_g241388 = (PositionOS131_g241375).y;
					#endif
					half Object_HeightValue267_g241375 = _ObjectHeightValue;
					half Bounds_HeightMask274_g241375 = saturate( ( staticSwitch65_g241388 / Object_HeightValue267_g241375 ) );
					half3 Position387_g241375 = PositionOS131_g241375;
					half Height387_g241375 = Object_HeightValue267_g241375;
					half Object_RadiusValue268_g241375 = _ObjectRadiusValue;
					half Radius387_g241375 = Object_RadiusValue268_g241375;
					half localCapsuleMaskYUp387_g241375 = CapsuleMaskYUp( Position387_g241375 , Height387_g241375 , Radius387_g241375 );
					half3 Position408_g241375 = PositionOS131_g241375;
					half Height408_g241375 = Object_HeightValue267_g241375;
					half Radius408_g241375 = Object_RadiusValue268_g241375;
					half localCapsuleMaskZUp408_g241375 = CapsuleMaskZUp( Position408_g241375 , Height408_g241375 , Radius408_g241375 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241393 = saturate( localCapsuleMaskZUp408_g241375 );
					#else
					float staticSwitch65_g241393 = saturate( localCapsuleMaskYUp387_g241375 );
					#endif
					half Bounds_SphereMask282_g241375 = staticSwitch65_g241393;
					float4 appendResult253_g241375 = (float4(Bounds_HeightMask274_g241375 , Bounds_SphereMask282_g241375 , 1.0 , 1.0));
					half4 MasksData254_g241375 = appendResult253_g241375;
					float4 In_MasksData16_g241385 = MasksData254_g241375;
					float temp_output_17_0_g241387 = _ObjectPhaseMode;
					float Option70_g241387 = temp_output_17_0_g241387;
					float4 temp_output_3_0_g241387 = v.ase_color;
					float4 Channel70_g241387 = temp_output_3_0_g241387;
					float localSwitchChannel470_g241387 = SwitchChannel4( Option70_g241387 , Channel70_g241387 );
					half Phase_Value372_g241375 = localSwitchChannel470_g241387;
					float3 break319_g241375 = PivotWO133_g241375;
					half Pivot_Position322_g241375 = ( break319_g241375.x + break319_g241375.z );
					half Phase_Position357_g241375 = ( Phase_Value372_g241375 + Pivot_Position322_g241375 );
					float temp_output_248_0_g241375 = frac( Phase_Position357_g241375 );
					float4 appendResult177_g241375 = (float4(( (frac( ( Phase_Position357_g241375 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g241375));
					half4 Phase_Data176_g241375 = appendResult177_g241375;
					float4 In_PhaseData16_g241385 = Phase_Data176_g241375;
					float4 In_TransformData16_g241385 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g241385 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g241385 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g241385 , In_Dummy16_g241385 , In_PositionOS16_g241385 , In_PositionWS16_g241385 , In_PositionWO16_g241385 , In_PositionRawOS16_g241385 , In_PivotOS16_g241385 , In_PivotWS16_g241385 , In_PivotWO16_g241385 , In_NormalOS16_g241385 , In_NormalWS16_g241385 , In_NormalRawOS16_g241385 , In_TangentOS16_g241385 , In_TangentWS16_g241385 , In_BitangentWS16_g241385 , In_ViewDirWS16_g241385 , In_CoordsData16_g241385 , In_VertexData16_g241385 , In_MasksData16_g241385 , In_PhaseData16_g241385 , In_TransformData16_g241385 , In_RotationData16_g241385 , In_InterpolatorA16_g241385 );
					TVEModelData DataDefault26_g251540 = Data16_g241385;
					TVEModelData DataGeneral26_g251540 = Data16_g241385;
					TVEModelData DataBlanket26_g251540 = Data16_g241385;
					TVEModelData DataImpostor26_g251540 = Data16_g241385;
					TVEModelData Data16_g241365 =(TVEModelData)0;
					half Dummy207_g241355 = 0.0;
					float temp_output_14_0_g241365 = Dummy207_g241355;
					float In_Dummy16_g241365 = temp_output_14_0_g241365;
					float3 PositionOS131_g241355 = v.vertex.xyz;
					float3 temp_output_4_0_g241365 = PositionOS131_g241355;
					float3 In_PositionOS16_g241365 = temp_output_4_0_g241365;
					float3 temp_output_104_7_g241355 = ase_positionWS;
					float3 PositionWS122_g241355 = temp_output_104_7_g241355;
					float3 In_PositionWS16_g241365 = PositionWS122_g241355;
					float4x4 break19_g241358 = unity_ObjectToWorld;
					float3 appendResult20_g241358 = (float3(break19_g241358[ 0 ][ 3 ] , break19_g241358[ 1 ][ 3 ] , break19_g241358[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241355 = appendResult20_g241358;
					float3 PivotWS121_g241355 = temp_output_340_7_g241355;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241355 = ( PositionWS122_g241355 - PivotWS121_g241355 );
					#else
					float3 staticSwitch204_g241355 = PositionWS122_g241355;
					#endif
					float3 PositionWO132_g241355 = ( staticSwitch204_g241355 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241365 = PositionWO132_g241355;
					float3 In_PositionRawOS16_g241365 = PositionOS131_g241355;
					float3 PivotOS149_g241355 = _Vector0;
					float3 In_PivotOS16_g241365 = PivotOS149_g241355;
					float3 In_PivotWS16_g241365 = PivotWS121_g241355;
					float3 PivotWO133_g241355 = ( PivotWS121_g241355 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241365 = PivotWO133_g241355;
					half3 NormalOS134_g241355 = v.normal;
					float3 temp_output_21_0_g241365 = NormalOS134_g241355;
					float3 In_NormalOS16_g241365 = temp_output_21_0_g241365;
					half3 NormalWS95_g241355 = normalizedWorldNormal;
					float3 In_NormalWS16_g241365 = NormalWS95_g241355;
					float3 In_NormalRawOS16_g241365 = NormalOS134_g241355;
					half4 TangentlOS153_g241355 = v.tangent;
					float4 temp_output_6_0_g241365 = TangentlOS153_g241355;
					float4 In_TangentOS16_g241365 = temp_output_6_0_g241365;
					half3 TangentWS136_g241355 = ase_tangentWS;
					float3 In_TangentWS16_g241365 = TangentWS136_g241355;
					half3 BiangentWS421_g241355 = ase_bitangentWS;
					float3 In_BitangentWS16_g241365 = BiangentWS421_g241355;
					float3 normalizeResult296_g241355 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241355 ) );
					half3 ViewDirWS169_g241355 = normalizeResult296_g241355;
					float3 In_ViewDirWS16_g241365 = ViewDirWS169_g241355;
					float4 appendResult397_g241355 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g241355 = appendResult397_g241355;
					float4 In_CoordsData16_g241365 = CoordsData398_g241355;
					half4 VertexMasks171_g241355 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241365 = VertexMasks171_g241355;
					half4 MasksData254_g241355 = float4( 0,0,0,0 );
					float4 In_MasksData16_g241365 = MasksData254_g241355;
					half4 Phase_Data176_g241355 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241365 = Phase_Data176_g241355;
					float4 In_TransformData16_g241365 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g241365 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g241365 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g241365 , In_Dummy16_g241365 , In_PositionOS16_g241365 , In_PositionWS16_g241365 , In_PositionWO16_g241365 , In_PositionRawOS16_g241365 , In_PivotOS16_g241365 , In_PivotWS16_g241365 , In_PivotWO16_g241365 , In_NormalOS16_g241365 , In_NormalWS16_g241365 , In_NormalRawOS16_g241365 , In_TangentOS16_g241365 , In_TangentWS16_g241365 , In_BitangentWS16_g241365 , In_ViewDirWS16_g241365 , In_CoordsData16_g241365 , In_VertexData16_g241365 , In_MasksData16_g241365 , In_PhaseData16_g241365 , In_TransformData16_g241365 , In_RotationData16_g241365 , In_InterpolatorA16_g241365 );
					TVEModelData DataTerrain26_g251540 = Data16_g241365;
					half IsShaderType2672 = _IsShaderType;
					float Type26_g251540 = IsShaderType2672;
					{
					if (Type26_g251540 == 0 )
					{
					Data26_g251540 = DataDefault26_g251540;
					}
					else if (Type26_g251540 == 1 )
					{
					Data26_g251540 = DataGeneral26_g251540;
					}
					else if (Type26_g251540 == 2 )
					{
					Data26_g251540 = DataBlanket26_g251540;
					}
					else if (Type26_g251540 == 3 )
					{
					Data26_g251540 = DataImpostor26_g251540;
					}
					else if (Type26_g251540 == 4 )
					{
					Data26_g251540 = DataTerrain26_g251540;
					}
					}
					TVEModelData Data15_g251552 =(TVEModelData)Data26_g251540;
					float Out_Dummy15_g251552 = 0.0;
					float3 Out_PositionOS15_g251552 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251552 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251552 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251552 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251552 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251552 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251552 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251552 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251552 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251552 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251552 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251552 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251552 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251552 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251552 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251552 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251552 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251552 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251552 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251552 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251552 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251552 , Out_Dummy15_g251552 , Out_PositionOS15_g251552 , Out_PositionWS15_g251552 , Out_PositionWO15_g251552 , Out_PositionRawOS15_g251552 , Out_PivotOS15_g251552 , Out_PivotWS15_g251552 , Out_PivotWO15_g251552 , Out_NormalOS15_g251552 , Out_NormalWS15_g251552 , Out_NormalRawOS15_g251552 , Out_TangentOS15_g251552 , Out_TangentWS15_g251552 , Out_BitangentWS15_g251552 , Out_ViewDirWS15_g251552 , Out_CoordsData15_g251552 , Out_VertexData15_g251552 , Out_MasksData15_g251552 , Out_PhaseData15_g251552 , Out_TransformData15_g251552 , Out_RotationData15_g251552 , Out_InterpolatorA15_g251552 );
					TVEModelData Data16_g251554 =(TVEModelData)Data15_g251552;
					float temp_output_14_0_g251554 = 0.0;
					float In_Dummy16_g251554 = temp_output_14_0_g251554;
					float3 temp_output_219_24_g251551 = Out_PivotOS15_g251552;
					float3 temp_output_215_0_g251551 = ( Out_PositionOS15_g251552 - temp_output_219_24_g251551 );
					float3 temp_output_4_0_g251554 = temp_output_215_0_g251551;
					float3 In_PositionOS16_g251554 = temp_output_4_0_g251554;
					float3 In_PositionWS16_g251554 = Out_PositionWS15_g251552;
					float3 In_PositionWO16_g251554 = Out_PositionWO15_g251552;
					float3 In_PositionRawOS16_g251554 = Out_PositionRawOS15_g251552;
					float3 In_PivotOS16_g251554 = temp_output_219_24_g251551;
					float3 In_PivotWS16_g251554 = Out_PivotWS15_g251552;
					float3 In_PivotWO16_g251554 = Out_PivotWO15_g251552;
					float3 temp_output_21_0_g251554 = Out_NormalOS15_g251552;
					float3 In_NormalOS16_g251554 = temp_output_21_0_g251554;
					float3 In_NormalWS16_g251554 = Out_NormalWS15_g251552;
					float3 In_NormalRawOS16_g251554 = Out_NormalRawOS15_g251552;
					float4 temp_output_6_0_g251554 = Out_TangentOS15_g251552;
					float4 In_TangentOS16_g251554 = temp_output_6_0_g251554;
					float3 In_TangentWS16_g251554 = Out_TangentWS15_g251552;
					float3 In_BitangentWS16_g251554 = Out_BitangentWS15_g251552;
					float3 In_ViewDirWS16_g251554 = Out_ViewDirWS15_g251552;
					float4 In_CoordsData16_g251554 = Out_CoordsData15_g251552;
					float4 In_VertexData16_g251554 = Out_VertexData15_g251552;
					float4 In_MasksData16_g251554 = Out_MasksData15_g251552;
					float4 In_PhaseData16_g251554 = Out_PhaseData15_g251552;
					float4 In_TransformData16_g251554 = Out_TransformData15_g251552;
					float4 In_RotationData16_g251554 = Out_RotationData15_g251552;
					float4 In_InterpolatorA16_g251554 = Out_InterpolatorA15_g251552;
					BuildModelVertData( Data16_g251554 , In_Dummy16_g251554 , In_PositionOS16_g251554 , In_PositionWS16_g251554 , In_PositionWO16_g251554 , In_PositionRawOS16_g251554 , In_PivotOS16_g251554 , In_PivotWS16_g251554 , In_PivotWO16_g251554 , In_NormalOS16_g251554 , In_NormalWS16_g251554 , In_NormalRawOS16_g251554 , In_TangentOS16_g251554 , In_TangentWS16_g251554 , In_BitangentWS16_g251554 , In_ViewDirWS16_g251554 , In_CoordsData16_g251554 , In_VertexData16_g251554 , In_MasksData16_g251554 , In_PhaseData16_g251554 , In_TransformData16_g251554 , In_RotationData16_g251554 , In_InterpolatorA16_g251554 );
					TVEModelData Data15_g251556 =(TVEModelData)Data16_g251554;
					float Out_Dummy15_g251556 = 0.0;
					float3 Out_PositionOS15_g251556 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251556 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251556 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251556 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251556 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251556 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251556 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251556 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251556 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251556 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251556 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251556 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251556 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251556 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251556 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251556 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251556 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251556 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251556 , Out_Dummy15_g251556 , Out_PositionOS15_g251556 , Out_PositionWS15_g251556 , Out_PositionWO15_g251556 , Out_PositionRawOS15_g251556 , Out_PivotOS15_g251556 , Out_PivotWS15_g251556 , Out_PivotWO15_g251556 , Out_NormalOS15_g251556 , Out_NormalWS15_g251556 , Out_NormalRawOS15_g251556 , Out_TangentOS15_g251556 , Out_TangentWS15_g251556 , Out_BitangentWS15_g251556 , Out_ViewDirWS15_g251556 , Out_CoordsData15_g251556 , Out_VertexData15_g251556 , Out_MasksData15_g251556 , Out_PhaseData15_g251556 , Out_TransformData15_g251556 , Out_RotationData15_g251556 , Out_InterpolatorA15_g251556 );
					TVEModelData Data16_g251557 =(TVEModelData)Data15_g251556;
					half Dummy317_g251555 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g251557 = Dummy317_g251555;
					float In_Dummy16_g251557 = temp_output_14_0_g251557;
					float3 temp_output_4_0_g251557 = Out_PositionOS15_g251556;
					float3 In_PositionOS16_g251557 = temp_output_4_0_g251557;
					float3 In_PositionWS16_g251557 = Out_PositionWS15_g251556;
					float3 temp_output_314_17_g251555 = Out_PositionWO15_g251556;
					float3 In_PositionWO16_g251557 = temp_output_314_17_g251555;
					float3 In_PositionRawOS16_g251557 = Out_PositionRawOS15_g251556;
					float3 In_PivotOS16_g251557 = Out_PivotOS15_g251556;
					float3 In_PivotWS16_g251557 = Out_PivotWS15_g251556;
					float3 temp_output_314_19_g251555 = Out_PivotWO15_g251556;
					float3 In_PivotWO16_g251557 = temp_output_314_19_g251555;
					float3 temp_output_21_0_g251557 = Out_NormalOS15_g251556;
					float3 In_NormalOS16_g251557 = temp_output_21_0_g251557;
					float3 In_NormalWS16_g251557 = Out_NormalWS15_g251556;
					float3 In_NormalRawOS16_g251557 = Out_NormalRawOS15_g251556;
					float4 temp_output_6_0_g251557 = Out_TangentOS15_g251556;
					float4 In_TangentOS16_g251557 = temp_output_6_0_g251557;
					float3 In_TangentWS16_g251557 = Out_TangentWS15_g251556;
					float3 In_BitangentWS16_g251557 = Out_BitangentWS15_g251556;
					float3 In_ViewDirWS16_g251557 = Out_ViewDirWS15_g251556;
					float4 In_CoordsData16_g251557 = Out_CoordsData15_g251556;
					float4 temp_output_314_29_g251555 = Out_VertexData15_g251556;
					float4 In_VertexData16_g251557 = temp_output_314_29_g251555;
					float4 In_MasksData16_g251557 = Out_MasksData15_g251556;
					float4 In_PhaseData16_g251557 = Out_PhaseData15_g251556;
					half4 Model_TransformData356_g251555 = Out_TransformData15_g251556;
					float localBuildGlobalData204_g251357 = ( 0.0 );
					TVEGlobalData Data204_g251357 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251357 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251357 = Dummy211_g251357;
					float4 temp_output_589_164_g251357 = TVE_CoatParams;
					half4 Coat_Params596_g251357 = temp_output_589_164_g251357;
					float4 In_CoatParams204_g251357 = Coat_Params596_g251357;
					float4 temp_output_203_0_g251377 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g241395 = ( 0.0 );
					TVEModelData Data26_g241395 = (TVEModelData)0;
					TVEModelData Data16_g241383 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241383 = 0.0;
					float3 In_PositionWS16_g241383 = PositionWS122_g241375;
					float3 In_PositionWO16_g241383 = PositionWO132_g241375;
					float3 In_PivotWS16_g241383 = PivotWS121_g241375;
					float3 In_PivotWO16_g241383 = PivotWO133_g241375;
					float3 In_NormalWS16_g241383 = NormalWS95_g241375;
					float3 In_TangentWS16_g241383 = TangentWS136_g241375;
					float3 In_BitangentWS16_g241383 = BiangentWS421_g241375;
					half3 NormalWS427_g241375 = NormalWS95_g241375;
					half3 localComputeTriplanarWeights427_g241375 = ComputeTriplanarWeights( NormalWS427_g241375 );
					half3 TriplanarWeights429_g241375 = localComputeTriplanarWeights427_g241375;
					float3 In_TriplanarWeights16_g241383 = TriplanarWeights429_g241375;
					float3 In_ViewDirWS16_g241383 = ViewDirWS169_g241375;
					float4 In_CoordsData16_g241383 = CoordsData398_g241375;
					float4 In_VertexData16_g241383 = VertexMasks171_g241375;
					float4 In_PhaseData16_g241383 = Phase_Data176_g241375;
					BuildModelFragData( Data16_g241383 , In_Dummy16_g241383 , In_PositionWS16_g241383 , In_PositionWO16_g241383 , In_PivotWS16_g241383 , In_PivotWO16_g241383 , In_NormalWS16_g241383 , In_TangentWS16_g241383 , In_BitangentWS16_g241383 , In_TriplanarWeights16_g241383 , In_ViewDirWS16_g241383 , In_CoordsData16_g241383 , In_VertexData16_g241383 , In_PhaseData16_g241383 );
					TVEModelData DataDefault26_g241395 = Data16_g241383;
					TVEModelData DataGeneral26_g241395 = Data16_g241383;
					TVEModelData DataBlanket26_g241395 = Data16_g241383;
					TVEModelData DataImpostor26_g241395 = Data16_g241383;
					TVEModelData Data16_g241363 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241363 = 0.0;
					float3 In_PositionWS16_g241363 = PositionWS122_g241355;
					float3 In_PositionWO16_g241363 = PositionWO132_g241355;
					float3 In_PivotWS16_g241363 = PivotWS121_g241355;
					float3 In_PivotWO16_g241363 = PivotWO133_g241355;
					float3 In_NormalWS16_g241363 = NormalWS95_g241355;
					float3 In_TangentWS16_g241363 = TangentWS136_g241355;
					float3 In_BitangentWS16_g241363 = BiangentWS421_g241355;
					half3 NormalWS427_g241355 = NormalWS95_g241355;
					half3 localComputeTriplanarWeights427_g241355 = ComputeTriplanarWeights( NormalWS427_g241355 );
					half3 TriplanarWeights429_g241355 = localComputeTriplanarWeights427_g241355;
					float3 In_TriplanarWeights16_g241363 = TriplanarWeights429_g241355;
					float3 In_ViewDirWS16_g241363 = ViewDirWS169_g241355;
					float4 In_CoordsData16_g241363 = CoordsData398_g241355;
					float4 In_VertexData16_g241363 = VertexMasks171_g241355;
					float4 In_PhaseData16_g241363 = Phase_Data176_g241355;
					BuildModelFragData( Data16_g241363 , In_Dummy16_g241363 , In_PositionWS16_g241363 , In_PositionWO16_g241363 , In_PivotWS16_g241363 , In_PivotWO16_g241363 , In_NormalWS16_g241363 , In_TangentWS16_g241363 , In_BitangentWS16_g241363 , In_TriplanarWeights16_g241363 , In_ViewDirWS16_g241363 , In_CoordsData16_g241363 , In_VertexData16_g241363 , In_PhaseData16_g241363 );
					TVEModelData DataTerrain26_g241395 = Data16_g241363;
					float Type26_g241395 = IsShaderType2672;
					{
					if (Type26_g241395 == 0 )
					{
					Data26_g241395 = DataDefault26_g241395;
					}
					else if (Type26_g241395 == 1 )
					{
					Data26_g241395 = DataGeneral26_g241395;
					}
					else if (Type26_g241395 == 2 )
					{
					Data26_g241395 = DataBlanket26_g241395;
					}
					else if (Type26_g241395 == 3 )
					{
					Data26_g241395 = DataImpostor26_g241395;
					}
					else if (Type26_g241395 == 4 )
					{
					Data26_g241395 = DataTerrain26_g241395;
					}
					}
					TVEModelData Data15_g251433 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g251433 = 0.0;
					float3 Out_PositionWS15_g251433 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251433 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251433 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251433 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251433 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251433 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251433 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251433 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251433 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251433 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251433 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251433 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251433 , Out_Dummy15_g251433 , Out_PositionWS15_g251433 , Out_PositionWO15_g251433 , Out_PivotWS15_g251433 , Out_PivotWO15_g251433 , Out_NormalWS15_g251433 , Out_TangentWS15_g251433 , Out_BitangentWS15_g251433 , Out_TriplanarWeights15_g251433 , Out_ViewDirWS15_g251433 , Out_CoordsData15_g251433 , Out_VertexData15_g251433 , Out_PhaseData15_g251433 );
					float3 Model_PositionWS497_g251357 = Out_PositionWS15_g251433;
					float2 Model_PositionWS_XZ143_g251357 = (Model_PositionWS497_g251357).xz;
					float3 Model_PivotWS498_g251357 = Out_PivotWS15_g251433;
					float2 Model_PivotWS_XZ145_g251357 = (Model_PivotWS498_g251357).xz;
					float2 lerpResult300_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251377 = lerpResult300_g251357;
					float temp_output_82_0_g251375 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251377 = temp_output_82_0_g251375;
					float4 tex2DArrayNode83_g251377 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251377).zw + ( (temp_output_203_0_g251377).xy * temp_output_81_0_g251377 ) ),temp_output_82_0_g251377), 0.0 );
					float4 appendResult210_g251377 = (float4(tex2DArrayNode83_g251377.rgb , saturate( tex2DArrayNode83_g251377.a )));
					float4 temp_output_204_0_g251377 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251377 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251377).zw + ( (temp_output_204_0_g251377).xy * temp_output_81_0_g251377 ) ),temp_output_82_0_g251377), 0.0 );
					float4 appendResult212_g251377 = (float4(tex2DArrayNode122_g251377.rgb , saturate( tex2DArrayNode122_g251377.a )));
					float4 TVE_RenderNearPositionR628_g251357 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251357 = saturate( ( distance( Model_PositionWS497_g251357 , (TVE_RenderNearPositionR628_g251357).xyz ) / (TVE_RenderNearPositionR628_g251357).w ) );
					float temp_output_7_0_g251358 = 1.0;
					float temp_output_9_0_g251358 = ( temp_output_507_0_g251357 - temp_output_7_0_g251358 );
					half TVE_RenderNearFadeValue635_g251357 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251357 = saturate( ( temp_output_9_0_g251358 / ( ( TVE_RenderNearFadeValue635_g251357 - temp_output_7_0_g251358 ) + 0.0001 ) ) );
					float4 lerpResult131_g251377 = lerp( appendResult210_g251377 , appendResult212_g251377 , Global_TexBlend509_g251357);
					float4 temp_output_159_109_g251375 = lerpResult131_g251377;
					float4 lerpResult168_g251375 = lerp( TVE_CoatParams , temp_output_159_109_g251375 , TVE_CoatLayers[(int)temp_output_82_0_g251375]);
					float4 temp_output_589_109_g251357 = lerpResult168_g251375;
					half4 Coat_Texture302_g251357 = temp_output_589_109_g251357;
					float4 In_CoatTexture204_g251357 = Coat_Texture302_g251357;
					float4 temp_output_595_164_g251357 = TVE_PaintParams;
					half4 Paint_Params575_g251357 = temp_output_595_164_g251357;
					float4 In_PaintParams204_g251357 = Paint_Params575_g251357;
					float4 temp_output_203_0_g251426 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251426 = lerpResult85_g251357;
					float temp_output_82_0_g251423 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251426 = temp_output_82_0_g251423;
					float4 tex2DArrayNode83_g251426 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251426).zw + ( (temp_output_203_0_g251426).xy * temp_output_81_0_g251426 ) ),temp_output_82_0_g251426), 0.0 );
					float4 appendResult210_g251426 = (float4(tex2DArrayNode83_g251426.rgb , saturate( tex2DArrayNode83_g251426.a )));
					float4 temp_output_204_0_g251426 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251426 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251426).zw + ( (temp_output_204_0_g251426).xy * temp_output_81_0_g251426 ) ),temp_output_82_0_g251426), 0.0 );
					float4 appendResult212_g251426 = (float4(tex2DArrayNode122_g251426.rgb , saturate( tex2DArrayNode122_g251426.a )));
					float4 lerpResult131_g251426 = lerp( appendResult210_g251426 , appendResult212_g251426 , Global_TexBlend509_g251357);
					float4 temp_output_171_109_g251423 = lerpResult131_g251426;
					float4 lerpResult174_g251423 = lerp( TVE_PaintParams , temp_output_171_109_g251423 , TVE_PaintLayers[(int)temp_output_82_0_g251423]);
					float4 temp_output_595_109_g251357 = lerpResult174_g251423;
					half4 Paint_Texture71_g251357 = temp_output_595_109_g251357;
					float4 In_PaintTexture204_g251357 = Paint_Texture71_g251357;
					float4 temp_output_590_141_g251357 = TVE_AtmoParams;
					half4 Atmo_Params601_g251357 = temp_output_590_141_g251357;
					float4 In_AtmoParams204_g251357 = Atmo_Params601_g251357;
					float4 temp_output_203_0_g251385 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251385 = lerpResult104_g251357;
					float temp_output_132_0_g251383 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251385 = temp_output_132_0_g251383;
					float4 tex2DArrayNode83_g251385 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251385).zw + ( (temp_output_203_0_g251385).xy * temp_output_81_0_g251385 ) ),temp_output_82_0_g251385), 0.0 );
					float4 appendResult210_g251385 = (float4(tex2DArrayNode83_g251385.rgb , saturate( tex2DArrayNode83_g251385.a )));
					float4 temp_output_204_0_g251385 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251385 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251385).zw + ( (temp_output_204_0_g251385).xy * temp_output_81_0_g251385 ) ),temp_output_82_0_g251385), 0.0 );
					float4 appendResult212_g251385 = (float4(tex2DArrayNode122_g251385.rgb , saturate( tex2DArrayNode122_g251385.a )));
					float4 lerpResult131_g251385 = lerp( appendResult210_g251385 , appendResult212_g251385 , Global_TexBlend509_g251357);
					float4 temp_output_137_109_g251383 = lerpResult131_g251385;
					float4 lerpResult145_g251383 = lerp( TVE_AtmoParams , temp_output_137_109_g251383 , TVE_AtmoLayers[(int)temp_output_132_0_g251383]);
					float4 temp_output_590_110_g251357 = lerpResult145_g251383;
					half4 Atmo_Texture80_g251357 = temp_output_590_110_g251357;
					float4 In_AtmoTexture204_g251357 = Atmo_Texture80_g251357;
					float4 temp_output_593_163_g251357 = TVE_GlowParams;
					half4 Glow_Params609_g251357 = temp_output_593_163_g251357;
					float4 In_GlowParams204_g251357 = Glow_Params609_g251357;
					float4 temp_output_203_0_g251401 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251401 = lerpResult247_g251357;
					float temp_output_82_0_g251399 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251401 = temp_output_82_0_g251399;
					float4 tex2DArrayNode83_g251401 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251401).zw + ( (temp_output_203_0_g251401).xy * temp_output_81_0_g251401 ) ),temp_output_82_0_g251401), 0.0 );
					float4 appendResult210_g251401 = (float4(tex2DArrayNode83_g251401.rgb , saturate( tex2DArrayNode83_g251401.a )));
					float4 temp_output_204_0_g251401 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251401 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251401).zw + ( (temp_output_204_0_g251401).xy * temp_output_81_0_g251401 ) ),temp_output_82_0_g251401), 0.0 );
					float4 appendResult212_g251401 = (float4(tex2DArrayNode122_g251401.rgb , saturate( tex2DArrayNode122_g251401.a )));
					float4 lerpResult131_g251401 = lerp( appendResult210_g251401 , appendResult212_g251401 , Global_TexBlend509_g251357);
					float4 temp_output_159_109_g251399 = lerpResult131_g251401;
					float4 lerpResult167_g251399 = lerp( TVE_GlowParams , temp_output_159_109_g251399 , TVE_GlowLayers[(int)temp_output_82_0_g251399]);
					float4 temp_output_593_109_g251357 = lerpResult167_g251399;
					half4 Glow_Texture248_g251357 = temp_output_593_109_g251357;
					float4 In_GlowTexture204_g251357 = Glow_Texture248_g251357;
					float4 temp_output_592_139_g251357 = TVE_FormParams;
					float4 Form_Params606_g251357 = temp_output_592_139_g251357;
					float4 In_FormParams204_g251357 = Form_Params606_g251357;
					float4 temp_output_203_0_g251417 = TVE_FormBaseCoord;
					float2 lerpResult168_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251417 = lerpResult168_g251357;
					float temp_output_130_0_g251415 = _GlobalFormLayerValue;
					float temp_output_82_0_g251417 = temp_output_130_0_g251415;
					float4 tex2DArrayNode83_g251417 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251417).zw + ( (temp_output_203_0_g251417).xy * temp_output_81_0_g251417 ) ),temp_output_82_0_g251417), 0.0 );
					float4 appendResult210_g251417 = (float4(tex2DArrayNode83_g251417.rgb , saturate( tex2DArrayNode83_g251417.a )));
					float4 temp_output_204_0_g251417 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251417 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251417).zw + ( (temp_output_204_0_g251417).xy * temp_output_81_0_g251417 ) ),temp_output_82_0_g251417), 0.0 );
					float4 appendResult212_g251417 = (float4(tex2DArrayNode122_g251417.rgb , saturate( tex2DArrayNode122_g251417.a )));
					float4 lerpResult131_g251417 = lerp( appendResult210_g251417 , appendResult212_g251417 , Global_TexBlend509_g251357);
					float4 temp_output_135_109_g251415 = lerpResult131_g251417;
					float4 lerpResult143_g251415 = lerp( TVE_FormParams , temp_output_135_109_g251415 , TVE_FormLayers[(int)temp_output_130_0_g251415]);
					float4 temp_output_592_0_g251357 = lerpResult143_g251415;
					float4 Form_Texture112_g251357 = temp_output_592_0_g251357;
					float4 In_FormTexture204_g251357 = Form_Texture112_g251357;
					float4 temp_output_594_145_g251357 = TVE_FlowParams;
					half4 Flow_Params612_g251357 = temp_output_594_145_g251357;
					float4 In_FlowParams204_g251357 = Flow_Params612_g251357;
					float4 temp_output_203_0_g251409 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251409 = lerpResult400_g251357;
					float temp_output_136_0_g251407 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251409 = temp_output_136_0_g251407;
					float4 tex2DArrayNode83_g251409 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251409).zw + ( (temp_output_203_0_g251409).xy * temp_output_81_0_g251409 ) ),temp_output_82_0_g251409), 0.0 );
					float4 appendResult210_g251409 = (float4(tex2DArrayNode83_g251409.rgb , saturate( tex2DArrayNode83_g251409.a )));
					float4 temp_output_204_0_g251409 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251409 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251409).zw + ( (temp_output_204_0_g251409).xy * temp_output_81_0_g251409 ) ),temp_output_82_0_g251409), 0.0 );
					float4 appendResult212_g251409 = (float4(tex2DArrayNode122_g251409.rgb , saturate( tex2DArrayNode122_g251409.a )));
					float4 lerpResult131_g251409 = lerp( appendResult210_g251409 , appendResult212_g251409 , Global_TexBlend509_g251357);
					float4 temp_output_141_109_g251407 = lerpResult131_g251409;
					float4 lerpResult149_g251407 = lerp( TVE_FlowParams , temp_output_141_109_g251407 , TVE_FlowLayers[(int)temp_output_136_0_g251407]);
					half4 Flow_Texture405_g251357 = lerpResult149_g251407;
					float4 In_FlowTexture204_g251357 = Flow_Texture405_g251357;
					BuildGlobalData( Data204_g251357 , In_Dummy204_g251357 , In_CoatParams204_g251357 , In_CoatTexture204_g251357 , In_PaintParams204_g251357 , In_PaintTexture204_g251357 , In_AtmoParams204_g251357 , In_AtmoTexture204_g251357 , In_GlowParams204_g251357 , In_GlowTexture204_g251357 , In_FormParams204_g251357 , In_FormTexture204_g251357 , In_FlowParams204_g251357 , In_FlowTexture204_g251357 );
					TVEGlobalData Data15_g251558 =(TVEGlobalData)Data204_g251357;
					float Out_Dummy15_g251558 = 0.0;
					float4 Out_CoatParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251558 = float4( 0,0,0,0 );
					BreakData( Data15_g251558 , Out_Dummy15_g251558 , Out_CoatParams15_g251558 , Out_CoatTexture15_g251558 , Out_PaintParams15_g251558 , Out_PaintTexture15_g251558 , Out_AtmoParams15_g251558 , Out_AtmoTexture15_g251558 , Out_GlowParams15_g251558 , Out_GlowTexture15_g251558 , Out_FormParams15_g251558 , Out_FormTexture15_g251558 , Out_FlowParams15_g251558 , Out_FlowTexture15_g251558 );
					float4 Global_FormTexture351_g251555 = Out_FormTexture15_g251558;
					float3 Model_PivotWO353_g251555 = temp_output_314_19_g251555;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251564 = _ConformMeshMode;
					float Option70_g251564 = temp_output_17_0_g251564;
					half4 Model_VertexData357_g251555 = temp_output_314_29_g251555;
					float4 temp_output_3_0_g251564 = Model_VertexData357_g251555;
					float4 Channel70_g251564 = temp_output_3_0_g251564;
					float localSwitchChannel470_g251564 = SwitchChannel4( Option70_g251564 , Channel70_g251564 );
					float temp_output_390_0_g251555 = localSwitchChannel470_g251564;
					float temp_output_7_0_g251561 = _ConformMeshRemap.x;
					float temp_output_9_0_g251561 = ( temp_output_390_0_g251555 - temp_output_7_0_g251561 );
					float lerpResult374_g251555 = lerp( 1.0 , saturate( ( temp_output_9_0_g251561 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251555 = lerpResult374_g251555;
					float temp_output_328_0_g251555 = ( Blend_VertMask379_g251555 * TVE_IsEnabled );
					half Conform_Mask366_g251555 = temp_output_328_0_g251555;
					float temp_output_322_0_g251555 = ( ( ( ( (Global_FormTexture351_g251555).z - ( (Model_PivotWO353_g251555).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251555 ) );
					float3 appendResult329_g251555 = (float3(0.0 , temp_output_322_0_g251555 , 0.0));
					float3 appendResult387_g251555 = (float3(0.0 , 0.0 , temp_output_322_0_g251555));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251562 = appendResult387_g251555;
					#else
					float3 staticSwitch65_g251562 = appendResult329_g251555;
					#endif
					float3 Blanket_Conform368_g251555 = staticSwitch65_g251562;
					float4 appendResult312_g251555 = (float4(Blanket_Conform368_g251555 , 0.0));
					float4 temp_output_310_0_g251555 = ( Model_TransformData356_g251555 + appendResult312_g251555 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251555 = temp_output_310_0_g251555;
					#else
					float4 staticSwitch364_g251555 = Model_TransformData356_g251555;
					#endif
					half4 Final_TransformData365_g251555 = staticSwitch364_g251555;
					float4 In_TransformData16_g251557 = Final_TransformData365_g251555;
					float4 In_RotationData16_g251557 = Out_RotationData15_g251556;
					float4 In_InterpolatorA16_g251557 = Out_InterpolatorA15_g251556;
					BuildModelVertData( Data16_g251557 , In_Dummy16_g251557 , In_PositionOS16_g251557 , In_PositionWS16_g251557 , In_PositionWO16_g251557 , In_PositionRawOS16_g251557 , In_PivotOS16_g251557 , In_PivotWS16_g251557 , In_PivotWO16_g251557 , In_NormalOS16_g251557 , In_NormalWS16_g251557 , In_NormalRawOS16_g251557 , In_TangentOS16_g251557 , In_TangentWS16_g251557 , In_BitangentWS16_g251557 , In_ViewDirWS16_g251557 , In_CoordsData16_g251557 , In_VertexData16_g251557 , In_MasksData16_g251557 , In_PhaseData16_g251557 , In_TransformData16_g251557 , In_RotationData16_g251557 , In_InterpolatorA16_g251557 );
					TVEModelData Data15_g251571 =(TVEModelData)Data16_g251557;
					float Out_Dummy15_g251571 = 0.0;
					float3 Out_PositionOS15_g251571 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251571 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251571 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251571 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251571 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251571 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251571 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251571 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251571 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251571 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251571 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251571 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251571 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251571 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251571 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251571 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251571 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251571 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251571 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251571 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251571 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251571 , Out_Dummy15_g251571 , Out_PositionOS15_g251571 , Out_PositionWS15_g251571 , Out_PositionWO15_g251571 , Out_PositionRawOS15_g251571 , Out_PivotOS15_g251571 , Out_PivotWS15_g251571 , Out_PivotWO15_g251571 , Out_NormalOS15_g251571 , Out_NormalWS15_g251571 , Out_NormalRawOS15_g251571 , Out_TangentOS15_g251571 , Out_TangentWS15_g251571 , Out_BitangentWS15_g251571 , Out_ViewDirWS15_g251571 , Out_CoordsData15_g251571 , Out_VertexData15_g251571 , Out_MasksData15_g251571 , Out_PhaseData15_g251571 , Out_TransformData15_g251571 , Out_RotationData15_g251571 , Out_InterpolatorA15_g251571 );
					TVEModelData Data16_g251572 =(TVEModelData)Data15_g251571;
					float temp_output_14_0_g251572 = 0.0;
					float In_Dummy16_g251572 = temp_output_14_0_g251572;
					float3 Model_PositionOS147_g251570 = Out_PositionOS15_g251571;
					half3 VertexPos40_g251576 = Model_PositionOS147_g251570;
					float4 temp_output_1567_33_g251570 = Out_RotationData15_g251571;
					half4 Model_RotationData1569_g251570 = temp_output_1567_33_g251570;
					float2 break1582_g251570 = (Model_RotationData1569_g251570).xy;
					half Angle44_g251576 = break1582_g251570.y;
					half CosAngle89_g251576 = cos( Angle44_g251576 );
					half SinAngle93_g251576 = sin( Angle44_g251576 );
					float3 appendResult95_g251576 = (float3((VertexPos40_g251576).x , ( ( (VertexPos40_g251576).y * CosAngle89_g251576 ) - ( (VertexPos40_g251576).z * SinAngle93_g251576 ) ) , ( ( (VertexPos40_g251576).y * SinAngle93_g251576 ) + ( (VertexPos40_g251576).z * CosAngle89_g251576 ) )));
					half3 VertexPos40_g251577 = appendResult95_g251576;
					half Angle44_g251577 = -break1582_g251570.x;
					half CosAngle94_g251577 = cos( Angle44_g251577 );
					half SinAngle95_g251577 = sin( Angle44_g251577 );
					float3 appendResult98_g251577 = (float3(( ( (VertexPos40_g251577).x * CosAngle94_g251577 ) - ( (VertexPos40_g251577).y * SinAngle95_g251577 ) ) , ( ( (VertexPos40_g251577).x * SinAngle95_g251577 ) + ( (VertexPos40_g251577).y * CosAngle94_g251577 ) ) , (VertexPos40_g251577).z));
					half3 VertexPos40_g251575 = Model_PositionOS147_g251570;
					half Angle44_g251575 = break1582_g251570.y;
					half CosAngle89_g251575 = cos( Angle44_g251575 );
					half SinAngle93_g251575 = sin( Angle44_g251575 );
					float3 appendResult95_g251575 = (float3((VertexPos40_g251575).x , ( ( (VertexPos40_g251575).y * CosAngle89_g251575 ) - ( (VertexPos40_g251575).z * SinAngle93_g251575 ) ) , ( ( (VertexPos40_g251575).y * SinAngle93_g251575 ) + ( (VertexPos40_g251575).z * CosAngle89_g251575 ) )));
					half3 VertexPos40_g251580 = appendResult95_g251575;
					half Angle44_g251580 = break1582_g251570.x;
					half CosAngle91_g251580 = cos( Angle44_g251580 );
					half SinAngle92_g251580 = sin( Angle44_g251580 );
					float3 appendResult93_g251580 = (float3(( ( (VertexPos40_g251580).x * CosAngle91_g251580 ) + ( (VertexPos40_g251580).z * SinAngle92_g251580 ) ) , (VertexPos40_g251580).y , ( ( -(VertexPos40_g251580).x * SinAngle92_g251580 ) + ( (VertexPos40_g251580).z * CosAngle91_g251580 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251578 = appendResult93_g251580;
					#else
					float3 staticSwitch65_g251578 = appendResult98_g251577;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251573 = staticSwitch65_g251578;
					#else
					float3 staticSwitch65_g251573 = Model_PositionOS147_g251570;
					#endif
					float3 temp_output_1608_0_g251570 = staticSwitch65_g251573;
					half3 VertexPos40_g251579 = temp_output_1608_0_g251570;
					half Angle44_g251579 = (Model_RotationData1569_g251570).z;
					half CosAngle91_g251579 = cos( Angle44_g251579 );
					half SinAngle92_g251579 = sin( Angle44_g251579 );
					float3 appendResult93_g251579 = (float3(( ( (VertexPos40_g251579).x * CosAngle91_g251579 ) + ( (VertexPos40_g251579).z * SinAngle92_g251579 ) ) , (VertexPos40_g251579).y , ( ( -(VertexPos40_g251579).x * SinAngle92_g251579 ) + ( (VertexPos40_g251579).z * CosAngle91_g251579 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251574 = appendResult93_g251579;
					#else
					float3 staticSwitch65_g251574 = temp_output_1608_0_g251570;
					#endif
					float4 temp_output_1567_31_g251570 = Out_TransformData15_g251571;
					half4 Model_TransformData1568_g251570 = temp_output_1567_31_g251570;
					half3 Final_PositionOS178_g251570 = ( ( staticSwitch65_g251574 * (Model_TransformData1568_g251570).w ) + (Model_TransformData1568_g251570).xyz );
					float3 temp_output_4_0_g251572 = Final_PositionOS178_g251570;
					float3 In_PositionOS16_g251572 = temp_output_4_0_g251572;
					float3 In_PositionWS16_g251572 = Out_PositionWS15_g251571;
					float3 In_PositionWO16_g251572 = Out_PositionWO15_g251571;
					float3 In_PositionRawOS16_g251572 = Out_PositionRawOS15_g251571;
					float3 In_PivotOS16_g251572 = Out_PivotOS15_g251571;
					float3 In_PivotWS16_g251572 = Out_PivotWS15_g251571;
					float3 In_PivotWO16_g251572 = Out_PivotWO15_g251571;
					float3 temp_output_21_0_g251572 = Out_NormalOS15_g251571;
					float3 In_NormalOS16_g251572 = temp_output_21_0_g251572;
					float3 In_NormalWS16_g251572 = Out_NormalWS15_g251571;
					float3 In_NormalRawOS16_g251572 = Out_NormalRawOS15_g251571;
					float4 temp_output_6_0_g251572 = Out_TangentOS15_g251571;
					float4 In_TangentOS16_g251572 = temp_output_6_0_g251572;
					float3 In_TangentWS16_g251572 = Out_TangentWS15_g251571;
					float3 In_BitangentWS16_g251572 = Out_BitangentWS15_g251571;
					float3 In_ViewDirWS16_g251572 = Out_ViewDirWS15_g251571;
					float4 In_CoordsData16_g251572 = Out_CoordsData15_g251571;
					float4 In_VertexData16_g251572 = Out_VertexData15_g251571;
					float4 In_MasksData16_g251572 = Out_MasksData15_g251571;
					float4 In_PhaseData16_g251572 = Out_PhaseData15_g251571;
					float4 In_TransformData16_g251572 = temp_output_1567_31_g251570;
					float4 In_RotationData16_g251572 = temp_output_1567_33_g251570;
					float4 In_InterpolatorA16_g251572 = Out_InterpolatorA15_g251571;
					BuildModelVertData( Data16_g251572 , In_Dummy16_g251572 , In_PositionOS16_g251572 , In_PositionWS16_g251572 , In_PositionWO16_g251572 , In_PositionRawOS16_g251572 , In_PivotOS16_g251572 , In_PivotWS16_g251572 , In_PivotWO16_g251572 , In_NormalOS16_g251572 , In_NormalWS16_g251572 , In_NormalRawOS16_g251572 , In_TangentOS16_g251572 , In_TangentWS16_g251572 , In_BitangentWS16_g251572 , In_ViewDirWS16_g251572 , In_CoordsData16_g251572 , In_VertexData16_g251572 , In_MasksData16_g251572 , In_PhaseData16_g251572 , In_TransformData16_g251572 , In_RotationData16_g251572 , In_InterpolatorA16_g251572 );
					TVEModelData Data15_g251582 =(TVEModelData)Data16_g251572;
					float Out_Dummy15_g251582 = 0.0;
					float3 Out_PositionOS15_g251582 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251582 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251582 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251582 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251582 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251582 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251582 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251582 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251582 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251582 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251582 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251582 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251582 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251582 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251582 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251582 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251582 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251582 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251582 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251582 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251582 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251582 , Out_Dummy15_g251582 , Out_PositionOS15_g251582 , Out_PositionWS15_g251582 , Out_PositionWO15_g251582 , Out_PositionRawOS15_g251582 , Out_PivotOS15_g251582 , Out_PivotWS15_g251582 , Out_PivotWO15_g251582 , Out_NormalOS15_g251582 , Out_NormalWS15_g251582 , Out_NormalRawOS15_g251582 , Out_TangentOS15_g251582 , Out_TangentWS15_g251582 , Out_BitangentWS15_g251582 , Out_ViewDirWS15_g251582 , Out_CoordsData15_g251582 , Out_VertexData15_g251582 , Out_MasksData15_g251582 , Out_PhaseData15_g251582 , Out_TransformData15_g251582 , Out_RotationData15_g251582 , Out_InterpolatorA15_g251582 );
					TVEModelData Data16_g251583 =(TVEModelData)Data15_g251582;
					float temp_output_14_0_g251583 = 0.0;
					float In_Dummy16_g251583 = temp_output_14_0_g251583;
					float3 temp_output_217_24_g251581 = Out_PivotOS15_g251582;
					float3 temp_output_216_0_g251581 = ( Out_PositionOS15_g251582 + temp_output_217_24_g251581 );
					float3 temp_output_4_0_g251583 = temp_output_216_0_g251581;
					float3 In_PositionOS16_g251583 = temp_output_4_0_g251583;
					float3 In_PositionWS16_g251583 = Out_PositionWS15_g251582;
					float3 In_PositionWO16_g251583 = Out_PositionWO15_g251582;
					float3 In_PositionRawOS16_g251583 = Out_PositionRawOS15_g251582;
					float3 In_PivotOS16_g251583 = temp_output_217_24_g251581;
					float3 In_PivotWS16_g251583 = Out_PivotWS15_g251582;
					float3 In_PivotWO16_g251583 = Out_PivotWO15_g251582;
					float3 temp_output_21_0_g251583 = Out_NormalOS15_g251582;
					float3 In_NormalOS16_g251583 = temp_output_21_0_g251583;
					float3 In_NormalWS16_g251583 = Out_NormalWS15_g251582;
					float3 In_NormalRawOS16_g251583 = Out_NormalRawOS15_g251582;
					float4 temp_output_6_0_g251583 = Out_TangentOS15_g251582;
					float4 In_TangentOS16_g251583 = temp_output_6_0_g251583;
					float3 In_TangentWS16_g251583 = Out_TangentWS15_g251582;
					float3 In_BitangentWS16_g251583 = Out_BitangentWS15_g251582;
					float3 In_ViewDirWS16_g251583 = Out_ViewDirWS15_g251582;
					float4 In_CoordsData16_g251583 = Out_CoordsData15_g251582;
					float4 In_VertexData16_g251583 = Out_VertexData15_g251582;
					float4 In_MasksData16_g251583 = Out_MasksData15_g251582;
					float4 In_PhaseData16_g251583 = Out_PhaseData15_g251582;
					float4 In_TransformData16_g251583 = Out_TransformData15_g251582;
					float4 In_RotationData16_g251583 = Out_RotationData15_g251582;
					float4 In_InterpolatorA16_g251583 = Out_InterpolatorA15_g251582;
					BuildModelVertData( Data16_g251583 , In_Dummy16_g251583 , In_PositionOS16_g251583 , In_PositionWS16_g251583 , In_PositionWO16_g251583 , In_PositionRawOS16_g251583 , In_PivotOS16_g251583 , In_PivotWS16_g251583 , In_PivotWO16_g251583 , In_NormalOS16_g251583 , In_NormalWS16_g251583 , In_NormalRawOS16_g251583 , In_TangentOS16_g251583 , In_TangentWS16_g251583 , In_BitangentWS16_g251583 , In_ViewDirWS16_g251583 , In_CoordsData16_g251583 , In_VertexData16_g251583 , In_MasksData16_g251583 , In_PhaseData16_g251583 , In_TransformData16_g251583 , In_RotationData16_g251583 , In_InterpolatorA16_g251583 );
					TVEModelData Data15_g251592 =(TVEModelData)Data16_g251583;
					float Out_Dummy15_g251592 = 0.0;
					float3 Out_PositionOS15_g251592 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251592 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251592 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251592 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251592 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251592 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251592 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251592 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251592 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251592 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251592 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251592 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251592 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251592 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251592 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251592 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251592 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251592 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251592 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251592 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251592 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251592 , Out_Dummy15_g251592 , Out_PositionOS15_g251592 , Out_PositionWS15_g251592 , Out_PositionWO15_g251592 , Out_PositionRawOS15_g251592 , Out_PivotOS15_g251592 , Out_PivotWS15_g251592 , Out_PivotWO15_g251592 , Out_NormalOS15_g251592 , Out_NormalWS15_g251592 , Out_NormalRawOS15_g251592 , Out_TangentOS15_g251592 , Out_TangentWS15_g251592 , Out_BitangentWS15_g251592 , Out_ViewDirWS15_g251592 , Out_CoordsData15_g251592 , Out_VertexData15_g251592 , Out_MasksData15_g251592 , Out_PhaseData15_g251592 , Out_TransformData15_g251592 , Out_RotationData15_g251592 , Out_InterpolatorA15_g251592 );
					
					o.ase_texcoord4.xyz = vertexToFrag73_g241375;
					o.ase_texcoord5.xyz = vertexToFrag76_g241375;
					float3 vertexPos57_g251586 = v.vertex.xyz;
					float4 ase_positionCS57_g251586 = UnityObjectToClipPos( vertexPos57_g251586 );
					o.ase_texcoord7 = ase_positionCS57_g251586;
					
					o.ase_texcoord6.xy = v.texcoord.xyzw.xy;
					o.ase_texcoord6.zw = v.texcoord2.xyzw.xy;
					o.ase_color = v.ase_color;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord4.w = 0;
					o.ase_texcoord5.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251592;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251592;
					v.tangent = Out_TangentOS15_g251592;

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
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_color : COLOR;

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
					o.ase_texcoord3 = v.ase_texcoord3;
					o.ase_color = v.ase_color;
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
					o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
					o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
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

				void frag (v2f IN 
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

					float temp_output_2664_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2664_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2664_114).xxx;
					
					float3 color130_g251586 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g251586 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g251588 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g251587 = ( temp_cast_4 * ( 0.5 + appendResult128_g251588 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g251587 = (float4(ddx( FinalUV13_g251587 ) , ddy( FinalUV13_g251587 )));
					float4 UVDerivatives17_g251587 = appendResult16_g251587;
					float4 break28_g251587 = UVDerivatives17_g251587;
					float2 appendResult19_g251587 = (float2(break28_g251587.x , break28_g251587.z));
					float2 appendResult20_g251587 = (float2(break28_g251587.x , break28_g251587.z));
					float dotResult24_g251587 = dot( appendResult19_g251587 , appendResult20_g251587 );
					float2 appendResult21_g251587 = (float2(break28_g251587.y , break28_g251587.w));
					float2 appendResult22_g251587 = (float2(break28_g251587.y , break28_g251587.w));
					float dotResult23_g251587 = dot( appendResult21_g251587 , appendResult22_g251587 );
					float2 appendResult25_g251587 = (float2(dotResult24_g251587 , dotResult23_g251587));
					float2 derivativesLength29_g251587 = sqrt( appendResult25_g251587 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g251587 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g251587 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g251587 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g251587 = clampResult57_g251587;
					float2 break55_g251587 = derivativesLength29_g251587;
					float4 lerpResult73_g251587 = lerp( float4( color130_g251586 , 0.0 ) , float4( color81_g251586 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g251587.x * break71_g251587.y * sqrt( saturate( ( 1.1 - max( break55_g251587.x, break55_g251587.y ) ) ) ) ) ) ));
					float3 color107_g251543 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251543 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float localBreakData4_g251542 = ( 0.0 );
					float localIfMasksData25_g251541 = ( 0.0 );
					TVEMasksData Data25_g251541 = (TVEMasksData)0;
					float localBuildMasksData3_g251483 = ( 0.0 );
					TVEMasksData Data3_g251483 = (TVEMasksData)0;
					half Feature_Intensity1107_g251434 = _OverlayIntensityValue;
					float ifLocalVar18_g251479 = 0;
					if( Feature_Intensity1107_g251434 <= 0.0 )
					ifLocalVar18_g251479 = 0.0;
					else
					ifLocalVar18_g251479 = 1.0;
					half Feature_Maps1112_g251434 = _OverlayTextureMode;
					float ifLocalVar18_g251480 = 0;
					if( Feature_Maps1112_g251434 <= 0.0 )
					ifLocalVar18_g251480 = 0.0;
					else
					ifLocalVar18_g251480 = 1.0;
					half Feature_Glitter1108_g251434 = _OverlayGlitterIntensityValue;
					float ifLocalVar18_g251481 = 0;
					if( Feature_Glitter1108_g251434 <= 0.0 )
					ifLocalVar18_g251481 = 0.0;
					else
					ifLocalVar18_g251481 = 1.0;
					half Feature_Element1085_g251434 = _OverlayElementMode;
					float ifLocalVar18_g251478 = 0;
					if( Feature_Element1085_g251434 <= 0.0 )
					ifLocalVar18_g251478 = 0.0;
					else
					ifLocalVar18_g251478 = 1.0;
					float4 appendResult1117_g251434 = (float4(ifLocalVar18_g251479 , ifLocalVar18_g251480 , ifLocalVar18_g251481 , ifLocalVar18_g251478));
					float4 In_MaskA3_g251483 = appendResult1117_g251434;
					half Blend_TexMask908_g251434 = 1.0;
					float localBreakVisualData4_g251475 = ( 0.0 );
					float localBuildVisualData3_g251315 = ( 0.0 );
					TVEVisualData Data3_g251315 =(TVEVisualData)0;
					half4 Dummy130_g241396 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) );
					float temp_output_14_0_g251315 = Dummy130_g241396.x;
					float In_Dummy3_g251315 = temp_output_14_0_g251315;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251356) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g251351 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g251351 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g251351 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g251351 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g251351 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g251351 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g251356 = staticSwitch36_g251351;
					float localBreakTextureData456_g251356 = ( 0.0 );
					float localBuildTextureData431_g251346 = ( 0.0 );
					TVEMasksData Data431_g251346 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g251346 = ( 0.0 );
					half4 Local_Coords180_g241396 = _main_coord_value;
					float4 Coords444_g251346 = Local_Coords180_g241396;
					float localIfModelDataByShader26_g241395 = ( 0.0 );
					TVEModelData Data26_g241395 = (TVEModelData)0;
					TVEModelData Data16_g241383 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241383 = 0.0;
					float3 vertexToFrag73_g241375 = IN.ase_texcoord4.xyz;
					float3 PositionWS122_g241375 = vertexToFrag73_g241375;
					float3 In_PositionWS16_g241383 = PositionWS122_g241375;
					float3 vertexToFrag76_g241375 = IN.ase_texcoord5.xyz;
					float3 PivotWS121_g241375 = vertexToFrag76_g241375;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241375 = ( PositionWS122_g241375 - PivotWS121_g241375 );
					#else
					float3 staticSwitch204_g241375 = PositionWS122_g241375;
					#endif
					float3 PositionWO132_g241375 = ( staticSwitch204_g241375 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241383 = PositionWO132_g241375;
					float3 In_PivotWS16_g241383 = PivotWS121_g241375;
					float3 PivotWO133_g241375 = ( PivotWS121_g241375 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241383 = PivotWO133_g241375;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g241375 = normalizedWorldNormal;
					float3 In_NormalWS16_g241383 = NormalWS95_g241375;
					half3 TangentWS136_g241375 = TangentWS;
					float3 In_TangentWS16_g241383 = TangentWS136_g241375;
					half3 BiangentWS421_g241375 = BitangentWS;
					float3 In_BitangentWS16_g241383 = BiangentWS421_g241375;
					half3 NormalWS427_g241375 = NormalWS95_g241375;
					half3 localComputeTriplanarWeights427_g241375 = ComputeTriplanarWeights( NormalWS427_g241375 );
					half3 TriplanarWeights429_g241375 = localComputeTriplanarWeights427_g241375;
					float3 In_TriplanarWeights16_g241383 = TriplanarWeights429_g241375;
					float3 normalizeResult296_g241375 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241375 ) );
					half3 ViewDirWS169_g241375 = normalizeResult296_g241375;
					float3 In_ViewDirWS16_g241383 = ViewDirWS169_g241375;
					float4 appendResult397_g241375 = (float4(IN.ase_texcoord6.xy , IN.ase_texcoord6.zw));
					float4 CoordsData398_g241375 = appendResult397_g241375;
					float4 In_CoordsData16_g241383 = CoordsData398_g241375;
					half4 VertexMasks171_g241375 = IN.ase_color;
					float4 In_VertexData16_g241383 = VertexMasks171_g241375;
					float temp_output_17_0_g241387 = _ObjectPhaseMode;
					float Option70_g241387 = temp_output_17_0_g241387;
					float4 temp_output_3_0_g241387 = IN.ase_color;
					float4 Channel70_g241387 = temp_output_3_0_g241387;
					float localSwitchChannel470_g241387 = SwitchChannel4( Option70_g241387 , Channel70_g241387 );
					half Phase_Value372_g241375 = localSwitchChannel470_g241387;
					float3 break319_g241375 = PivotWO133_g241375;
					half Pivot_Position322_g241375 = ( break319_g241375.x + break319_g241375.z );
					half Phase_Position357_g241375 = ( Phase_Value372_g241375 + Pivot_Position322_g241375 );
					float temp_output_248_0_g241375 = frac( Phase_Position357_g241375 );
					float4 appendResult177_g241375 = (float4(( (frac( ( Phase_Position357_g241375 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g241375));
					half4 Phase_Data176_g241375 = appendResult177_g241375;
					float4 In_PhaseData16_g241383 = Phase_Data176_g241375;
					BuildModelFragData( Data16_g241383 , In_Dummy16_g241383 , In_PositionWS16_g241383 , In_PositionWO16_g241383 , In_PivotWS16_g241383 , In_PivotWO16_g241383 , In_NormalWS16_g241383 , In_TangentWS16_g241383 , In_BitangentWS16_g241383 , In_TriplanarWeights16_g241383 , In_ViewDirWS16_g241383 , In_CoordsData16_g241383 , In_VertexData16_g241383 , In_PhaseData16_g241383 );
					TVEModelData DataDefault26_g241395 = Data16_g241383;
					TVEModelData DataGeneral26_g241395 = Data16_g241383;
					TVEModelData DataBlanket26_g241395 = Data16_g241383;
					TVEModelData DataImpostor26_g241395 = Data16_g241383;
					TVEModelData Data16_g241363 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241363 = 0.0;
					float3 temp_output_104_7_g241355 = PositionWS;
					float3 PositionWS122_g241355 = temp_output_104_7_g241355;
					float3 In_PositionWS16_g241363 = PositionWS122_g241355;
					float4x4 break19_g241358 = unity_ObjectToWorld;
					float3 appendResult20_g241358 = (float3(break19_g241358[ 0 ][ 3 ] , break19_g241358[ 1 ][ 3 ] , break19_g241358[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241355 = appendResult20_g241358;
					float3 PivotWS121_g241355 = temp_output_340_7_g241355;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241355 = ( PositionWS122_g241355 - PivotWS121_g241355 );
					#else
					float3 staticSwitch204_g241355 = PositionWS122_g241355;
					#endif
					float3 PositionWO132_g241355 = ( staticSwitch204_g241355 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241363 = PositionWO132_g241355;
					float3 In_PivotWS16_g241363 = PivotWS121_g241355;
					float3 PivotWO133_g241355 = ( PivotWS121_g241355 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241363 = PivotWO133_g241355;
					half3 NormalWS95_g241355 = normalizedWorldNormal;
					float3 In_NormalWS16_g241363 = NormalWS95_g241355;
					half3 TangentWS136_g241355 = TangentWS;
					float3 In_TangentWS16_g241363 = TangentWS136_g241355;
					half3 BiangentWS421_g241355 = BitangentWS;
					float3 In_BitangentWS16_g241363 = BiangentWS421_g241355;
					half3 NormalWS427_g241355 = NormalWS95_g241355;
					half3 localComputeTriplanarWeights427_g241355 = ComputeTriplanarWeights( NormalWS427_g241355 );
					half3 TriplanarWeights429_g241355 = localComputeTriplanarWeights427_g241355;
					float3 In_TriplanarWeights16_g241363 = TriplanarWeights429_g241355;
					float3 normalizeResult296_g241355 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241355 ) );
					half3 ViewDirWS169_g241355 = normalizeResult296_g241355;
					float3 In_ViewDirWS16_g241363 = ViewDirWS169_g241355;
					float4 appendResult397_g241355 = (float4(IN.ase_texcoord6.xy , IN.ase_texcoord6.zw));
					float4 CoordsData398_g241355 = appendResult397_g241355;
					float4 In_CoordsData16_g241363 = CoordsData398_g241355;
					half4 VertexMasks171_g241355 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241363 = VertexMasks171_g241355;
					half4 Phase_Data176_g241355 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241363 = Phase_Data176_g241355;
					BuildModelFragData( Data16_g241363 , In_Dummy16_g241363 , In_PositionWS16_g241363 , In_PositionWO16_g241363 , In_PivotWS16_g241363 , In_PivotWO16_g241363 , In_NormalWS16_g241363 , In_TangentWS16_g241363 , In_BitangentWS16_g241363 , In_TriplanarWeights16_g241363 , In_ViewDirWS16_g241363 , In_CoordsData16_g241363 , In_VertexData16_g241363 , In_PhaseData16_g241363 );
					TVEModelData DataTerrain26_g241395 = Data16_g241363;
					half IsShaderType2672 = _IsShaderType;
					float Type26_g241395 = IsShaderType2672;
					{
					if (Type26_g241395 == 0 )
					{
					Data26_g241395 = DataDefault26_g241395;
					}
					else if (Type26_g241395 == 1 )
					{
					Data26_g241395 = DataGeneral26_g241395;
					}
					else if (Type26_g241395 == 2 )
					{
					Data26_g241395 = DataBlanket26_g241395;
					}
					else if (Type26_g241395 == 3 )
					{
					Data26_g241395 = DataImpostor26_g241395;
					}
					else if (Type26_g241395 == 4 )
					{
					Data26_g241395 = DataTerrain26_g241395;
					}
					}
					TVEModelData Data15_g251330 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g251330 = 0.0;
					float3 Out_PositionWS15_g251330 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251330 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251330 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251330 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251330 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251330 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251330 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251330 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251330 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251330 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251330 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251330 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251330 , Out_Dummy15_g251330 , Out_PositionWS15_g251330 , Out_PositionWO15_g251330 , Out_PivotWS15_g251330 , Out_PivotWO15_g251330 , Out_NormalWS15_g251330 , Out_TangentWS15_g251330 , Out_BitangentWS15_g251330 , Out_TriplanarWeights15_g251330 , Out_ViewDirWS15_g251330 , Out_CoordsData15_g251330 , Out_VertexData15_g251330 , Out_PhaseData15_g251330 );
					float4 Model_CoordsData324_g241396 = Out_CoordsData15_g251330;
					float4 MeshCoords444_g251346 = Model_CoordsData324_g241396;
					float2 UV0444_g251346 = float2( 0,0 );
					float2 UV3444_g251346 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g251346 , MeshCoords444_g251346 , UV0444_g251346 , UV3444_g251346 );
					float4 appendResult430_g251346 = (float4(UV0444_g251346 , UV3444_g251346));
					float4 In_MaskA431_g251346 = appendResult430_g251346;
					float localComputeWorldCoords315_g251346 = ( 0.0 );
					float4 Coords315_g251346 = Local_Coords180_g241396;
					float3 Model_PositionWO222_g241396 = Out_PositionWO15_g251330;
					float3 PositionWS315_g251346 = Model_PositionWO222_g241396;
					float2 ZY315_g251346 = float2( 0,0 );
					float2 XZ315_g251346 = float2( 0,0 );
					float2 XY315_g251346 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g251346 , PositionWS315_g251346 , ZY315_g251346 , XZ315_g251346 , XY315_g251346 );
					float2 ZY402_g251346 = ZY315_g251346;
					float2 XZ403_g251346 = XZ315_g251346;
					float4 appendResult432_g251346 = (float4(ZY402_g251346 , XZ403_g251346));
					float4 In_MaskB431_g251346 = appendResult432_g251346;
					float2 XY404_g251346 = XY315_g251346;
					float localComputeStochasticCoords409_g251346 = ( 0.0 );
					float2 UV409_g251346 = ZY402_g251346;
					float2 UV1409_g251346 = float2( 0,0 );
					float2 UV2409_g251346 = float2( 0,0 );
					float2 UV3409_g251346 = float2( 0,0 );
					float3 Weights409_g251346 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g251346 , UV1409_g251346 , UV2409_g251346 , UV3409_g251346 , Weights409_g251346 );
					float4 appendResult433_g251346 = (float4(XY404_g251346 , UV1409_g251346));
					float4 In_MaskC431_g251346 = appendResult433_g251346;
					float4 appendResult434_g251346 = (float4(UV2409_g251346 , UV3409_g251346));
					float4 In_MaskD431_g251346 = appendResult434_g251346;
					float localComputeStochasticCoords422_g251346 = ( 0.0 );
					float2 UV422_g251346 = XZ403_g251346;
					float2 UV1422_g251346 = float2( 0,0 );
					float2 UV2422_g251346 = float2( 0,0 );
					float2 UV3422_g251346 = float2( 0,0 );
					float3 Weights422_g251346 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g251346 , UV1422_g251346 , UV2422_g251346 , UV3422_g251346 , Weights422_g251346 );
					float4 appendResult435_g251346 = (float4(UV1422_g251346 , UV2422_g251346));
					float4 In_MaskE431_g251346 = appendResult435_g251346;
					float localComputeStochasticCoords423_g251346 = ( 0.0 );
					float2 UV423_g251346 = XY404_g251346;
					float2 UV1423_g251346 = float2( 0,0 );
					float2 UV2423_g251346 = float2( 0,0 );
					float2 UV3423_g251346 = float2( 0,0 );
					float3 Weights423_g251346 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g251346 , UV1423_g251346 , UV2423_g251346 , UV3423_g251346 , Weights423_g251346 );
					float4 appendResult436_g251346 = (float4(UV3422_g251346 , UV1423_g251346));
					float4 In_MaskF431_g251346 = appendResult436_g251346;
					float4 appendResult437_g251346 = (float4(UV2423_g251346 , UV3423_g251346));
					float4 In_MaskG431_g251346 = appendResult437_g251346;
					float4 In_MaskH431_g251346 = float4( Weights409_g251346 , 0.0 );
					float4 In_MaskI431_g251346 = float4( Weights422_g251346 , 0.0 );
					float4 In_MaskJ431_g251346 = float4( Weights423_g251346 , 0.0 );
					half3 Model_NormalWS226_g241396 = Out_NormalWS15_g251330;
					float3 temp_output_449_0_g251346 = Model_NormalWS226_g241396;
					float4 In_MaskK431_g251346 = float4( temp_output_449_0_g251346 , 0.0 );
					half3 Model_TangentWS366_g241396 = Out_TangentWS15_g251330;
					float3 temp_output_450_0_g251346 = Model_TangentWS366_g241396;
					float4 In_MaskL431_g251346 = float4( temp_output_450_0_g251346 , 0.0 );
					half3 Model_BitangentWS367_g241396 = Out_BitangentWS15_g251330;
					float3 temp_output_451_0_g251346 = Model_BitangentWS367_g241396;
					float4 In_MaskM431_g251346 = float4( temp_output_451_0_g251346 , 0.0 );
					half3 Model_TriplanarWeights368_g241396 = Out_TriplanarWeights15_g251330;
					float3 temp_output_445_0_g251346 = Model_TriplanarWeights368_g241396;
					float4 In_MaskN431_g251346 = float4( temp_output_445_0_g251346 , 0.0 );
					BuildTextureData( Data431_g251346 , In_MaskA431_g251346 , In_MaskB431_g251346 , In_MaskC431_g251346 , In_MaskD431_g251346 , In_MaskE431_g251346 , In_MaskF431_g251346 , In_MaskG431_g251346 , In_MaskH431_g251346 , In_MaskI431_g251346 , In_MaskJ431_g251346 , In_MaskK431_g251346 , In_MaskL431_g251346 , In_MaskM431_g251346 , In_MaskN431_g251346 );
					TVEMasksData Data456_g251356 =(TVEMasksData)Data431_g251346;
					float4 Out_MaskA456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251356 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251356 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251356 , Out_MaskA456_g251356 , Out_MaskB456_g251356 , Out_MaskC456_g251356 , Out_MaskD456_g251356 , Out_MaskE456_g251356 , Out_MaskF456_g251356 , Out_MaskG456_g251356 , Out_MaskH456_g251356 , Out_MaskI456_g251356 , Out_MaskJ456_g251356 , Out_MaskK456_g251356 , Out_MaskL456_g251356 , Out_MaskM456_g251356 , Out_MaskN456_g251356 );
					half2 UV276_g251356 = (Out_MaskA456_g251356).xy;
					float temp_output_504_0_g251356 = 0.0;
					half Bias276_g251356 = temp_output_504_0_g251356;
					half2 Normal276_g251356 = float2( 0,0 );
					half4 localSampleCoord276_g251356 = SampleCoord( Texture276_g251356 , Sampler276_g251356 , UV276_g251356 , Bias276_g251356 , Normal276_g251356 );
					float4 temp_output_407_277_g241396 = localSampleCoord276_g251356;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251356) = _MainAlbedoTex;
					SamplerState Sampler502_g251356 = staticSwitch36_g251351;
					half2 UV502_g251356 = (Out_MaskA456_g251356).zw;
					half Bias502_g251356 = temp_output_504_0_g251356;
					half2 Normal502_g251356 = float2( 0,0 );
					half4 localSampleCoord502_g251356 = SampleCoord( Texture502_g251356 , Sampler502_g251356 , UV502_g251356 , Bias502_g251356 , Normal502_g251356 );
					float4 temp_output_407_278_g241396 = localSampleCoord502_g251356;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251356) = _MainAlbedoTex;
					SamplerState Sampler496_g251356 = staticSwitch36_g251351;
					float2 temp_output_463_0_g251356 = (Out_MaskB456_g251356).zw;
					half2 XZ496_g251356 = temp_output_463_0_g251356;
					half Bias496_g251356 = temp_output_504_0_g251356;
					float3 temp_output_483_0_g251356 = (Out_MaskK456_g251356).xyz;
					half3 NormalWS496_g251356 = temp_output_483_0_g251356;
					half3 Normal496_g251356 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251356 = SamplePlanar2D( Texture496_g251356 , Sampler496_g251356 , XZ496_g251356 , Bias496_g251356 , NormalWS496_g251356 , Normal496_g251356 );
					float4 temp_output_407_0_g241396 = localSamplePlanar2D496_g251356;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251356) = _MainAlbedoTex;
					SamplerState Sampler490_g251356 = staticSwitch36_g251351;
					float2 temp_output_462_0_g251356 = (Out_MaskB456_g251356).xy;
					half2 ZY490_g251356 = temp_output_462_0_g251356;
					half2 XZ490_g251356 = temp_output_463_0_g251356;
					float2 temp_output_464_0_g251356 = (Out_MaskC456_g251356).xy;
					half2 XY490_g251356 = temp_output_464_0_g251356;
					half Bias490_g251356 = temp_output_504_0_g251356;
					float3 temp_output_482_0_g251356 = (Out_MaskN456_g251356).xyz;
					half3 Triplanar490_g251356 = temp_output_482_0_g251356;
					half3 NormalWS490_g251356 = temp_output_483_0_g251356;
					half3 Normal490_g251356 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251356 = SamplePlanar3D( Texture490_g251356 , Sampler490_g251356 , ZY490_g251356 , XZ490_g251356 , XY490_g251356 , Bias490_g251356 , Triplanar490_g251356 , NormalWS490_g251356 , Normal490_g251356 );
					float4 temp_output_407_201_g241396 = localSamplePlanar3D490_g251356;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251356) = _MainAlbedoTex;
					SamplerState Sampler498_g251356 = staticSwitch36_g251351;
					half2 XZ498_g251356 = temp_output_463_0_g251356;
					float2 temp_output_473_0_g251356 = (Out_MaskE456_g251356).xy;
					half2 XZ_1498_g251356 = temp_output_473_0_g251356;
					float2 temp_output_474_0_g251356 = (Out_MaskE456_g251356).zw;
					half2 XZ_2498_g251356 = temp_output_474_0_g251356;
					float2 temp_output_475_0_g251356 = (Out_MaskF456_g251356).xy;
					half2 XZ_3498_g251356 = temp_output_475_0_g251356;
					float temp_output_510_0_g251356 = exp2( temp_output_504_0_g251356 );
					half Bias498_g251356 = temp_output_510_0_g251356;
					float3 temp_output_480_0_g251356 = (Out_MaskI456_g251356).xyz;
					half3 Weights_2498_g251356 = temp_output_480_0_g251356;
					half3 NormalWS498_g251356 = temp_output_483_0_g251356;
					half3 Normal498_g251356 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251356 = SampleStochastic2D( Texture498_g251356 , Sampler498_g251356 , XZ498_g251356 , XZ_1498_g251356 , XZ_2498_g251356 , XZ_3498_g251356 , Bias498_g251356 , Weights_2498_g251356 , NormalWS498_g251356 , Normal498_g251356 );
					float4 temp_output_407_202_g241396 = localSampleStochastic2D498_g251356;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251356) = _MainAlbedoTex;
					SamplerState Sampler500_g251356 = staticSwitch36_g251351;
					half2 ZY500_g251356 = temp_output_462_0_g251356;
					half2 ZY_1500_g251356 = (Out_MaskC456_g251356).zw;
					half2 ZY_2500_g251356 = (Out_MaskD456_g251356).xy;
					half2 ZY_3500_g251356 = (Out_MaskD456_g251356).zw;
					half2 XZ500_g251356 = temp_output_463_0_g251356;
					half2 XZ_1500_g251356 = temp_output_473_0_g251356;
					half2 XZ_2500_g251356 = temp_output_474_0_g251356;
					half2 XZ_3500_g251356 = temp_output_475_0_g251356;
					half2 XY500_g251356 = temp_output_464_0_g251356;
					half2 XY_1500_g251356 = (Out_MaskF456_g251356).zw;
					half2 XY_2500_g251356 = (Out_MaskG456_g251356).xy;
					half2 XY_3500_g251356 = (Out_MaskG456_g251356).zw;
					half Bias500_g251356 = temp_output_510_0_g251356;
					half3 Weights_1500_g251356 = (Out_MaskH456_g251356).xyz;
					half3 Weights_2500_g251356 = temp_output_480_0_g251356;
					half3 Weights_3500_g251356 = (Out_MaskJ456_g251356).xyz;
					half3 Triplanar500_g251356 = temp_output_482_0_g251356;
					half3 NormalWS500_g251356 = temp_output_483_0_g251356;
					half3 Normal500_g251356 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251356 = SampleStochastic3D( Texture500_g251356 , Sampler500_g251356 , ZY500_g251356 , ZY_1500_g251356 , ZY_2500_g251356 , ZY_3500_g251356 , XZ500_g251356 , XZ_1500_g251356 , XZ_2500_g251356 , XZ_3500_g251356 , XY500_g251356 , XY_1500_g251356 , XY_2500_g251356 , XY_3500_g251356 , Bias500_g251356 , Weights_1500_g251356 , Weights_2500_g251356 , Weights_3500_g251356 , Triplanar500_g251356 , NormalWS500_g251356 , Normal500_g251356 );
					float4 temp_output_407_203_g241396 = localSampleStochastic3D500_g251356;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g241396 = temp_output_407_277_g241396;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g241396 = temp_output_407_278_g241396;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g241396 = temp_output_407_0_g241396;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g241396 = temp_output_407_201_g241396;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g241396 = temp_output_407_202_g241396;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g241396 = temp_output_407_203_g241396;
					#else
					float4 staticSwitch184_g241396 = temp_output_407_277_g241396;
					#endif
					half4 Local_AlbedoSample185_g241396 = staticSwitch184_g241396;
					float3 lerpResult53_g241396 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g241396).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g241396 = lerpResult53_g241396;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251354) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g251353 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g251353 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g251353 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g251353 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g251353 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g251353 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251354 = staticSwitch38_g251353;
					float localBreakTextureData456_g251354 = ( 0.0 );
					TVEMasksData Data456_g251354 =(TVEMasksData)Data431_g251346;
					float4 Out_MaskA456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251354 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251354 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251354 , Out_MaskA456_g251354 , Out_MaskB456_g251354 , Out_MaskC456_g251354 , Out_MaskD456_g251354 , Out_MaskE456_g251354 , Out_MaskF456_g251354 , Out_MaskG456_g251354 , Out_MaskH456_g251354 , Out_MaskI456_g251354 , Out_MaskJ456_g251354 , Out_MaskK456_g251354 , Out_MaskL456_g251354 , Out_MaskM456_g251354 , Out_MaskN456_g251354 );
					half2 UV276_g251354 = (Out_MaskA456_g251354).xy;
					float temp_output_504_0_g251354 = 0.0;
					half Bias276_g251354 = temp_output_504_0_g251354;
					half2 Normal276_g251354 = float2( 0,0 );
					half4 localSampleCoord276_g251354 = SampleCoord( Texture276_g251354 , Sampler276_g251354 , UV276_g251354 , Bias276_g251354 , Normal276_g251354 );
					float4 temp_output_405_277_g241396 = localSampleCoord276_g251354;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251354) = _MainShaderTex;
					SamplerState Sampler502_g251354 = staticSwitch38_g251353;
					half2 UV502_g251354 = (Out_MaskA456_g251354).zw;
					half Bias502_g251354 = temp_output_504_0_g251354;
					half2 Normal502_g251354 = float2( 0,0 );
					half4 localSampleCoord502_g251354 = SampleCoord( Texture502_g251354 , Sampler502_g251354 , UV502_g251354 , Bias502_g251354 , Normal502_g251354 );
					float4 temp_output_405_278_g241396 = localSampleCoord502_g251354;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251354) = _MainShaderTex;
					SamplerState Sampler496_g251354 = staticSwitch38_g251353;
					float2 temp_output_463_0_g251354 = (Out_MaskB456_g251354).zw;
					half2 XZ496_g251354 = temp_output_463_0_g251354;
					half Bias496_g251354 = temp_output_504_0_g251354;
					float3 temp_output_483_0_g251354 = (Out_MaskK456_g251354).xyz;
					half3 NormalWS496_g251354 = temp_output_483_0_g251354;
					half3 Normal496_g251354 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251354 = SamplePlanar2D( Texture496_g251354 , Sampler496_g251354 , XZ496_g251354 , Bias496_g251354 , NormalWS496_g251354 , Normal496_g251354 );
					float4 temp_output_405_0_g241396 = localSamplePlanar2D496_g251354;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251354) = _MainShaderTex;
					SamplerState Sampler490_g251354 = staticSwitch38_g251353;
					float2 temp_output_462_0_g251354 = (Out_MaskB456_g251354).xy;
					half2 ZY490_g251354 = temp_output_462_0_g251354;
					half2 XZ490_g251354 = temp_output_463_0_g251354;
					float2 temp_output_464_0_g251354 = (Out_MaskC456_g251354).xy;
					half2 XY490_g251354 = temp_output_464_0_g251354;
					half Bias490_g251354 = temp_output_504_0_g251354;
					float3 temp_output_482_0_g251354 = (Out_MaskN456_g251354).xyz;
					half3 Triplanar490_g251354 = temp_output_482_0_g251354;
					half3 NormalWS490_g251354 = temp_output_483_0_g251354;
					half3 Normal490_g251354 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251354 = SamplePlanar3D( Texture490_g251354 , Sampler490_g251354 , ZY490_g251354 , XZ490_g251354 , XY490_g251354 , Bias490_g251354 , Triplanar490_g251354 , NormalWS490_g251354 , Normal490_g251354 );
					float4 temp_output_405_201_g241396 = localSamplePlanar3D490_g251354;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251354) = _MainShaderTex;
					SamplerState Sampler498_g251354 = staticSwitch38_g251353;
					half2 XZ498_g251354 = temp_output_463_0_g251354;
					float2 temp_output_473_0_g251354 = (Out_MaskE456_g251354).xy;
					half2 XZ_1498_g251354 = temp_output_473_0_g251354;
					float2 temp_output_474_0_g251354 = (Out_MaskE456_g251354).zw;
					half2 XZ_2498_g251354 = temp_output_474_0_g251354;
					float2 temp_output_475_0_g251354 = (Out_MaskF456_g251354).xy;
					half2 XZ_3498_g251354 = temp_output_475_0_g251354;
					float temp_output_510_0_g251354 = exp2( temp_output_504_0_g251354 );
					half Bias498_g251354 = temp_output_510_0_g251354;
					float3 temp_output_480_0_g251354 = (Out_MaskI456_g251354).xyz;
					half3 Weights_2498_g251354 = temp_output_480_0_g251354;
					half3 NormalWS498_g251354 = temp_output_483_0_g251354;
					half3 Normal498_g251354 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251354 = SampleStochastic2D( Texture498_g251354 , Sampler498_g251354 , XZ498_g251354 , XZ_1498_g251354 , XZ_2498_g251354 , XZ_3498_g251354 , Bias498_g251354 , Weights_2498_g251354 , NormalWS498_g251354 , Normal498_g251354 );
					float4 temp_output_405_202_g241396 = localSampleStochastic2D498_g251354;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251354) = _MainShaderTex;
					SamplerState Sampler500_g251354 = staticSwitch38_g251353;
					half2 ZY500_g251354 = temp_output_462_0_g251354;
					half2 ZY_1500_g251354 = (Out_MaskC456_g251354).zw;
					half2 ZY_2500_g251354 = (Out_MaskD456_g251354).xy;
					half2 ZY_3500_g251354 = (Out_MaskD456_g251354).zw;
					half2 XZ500_g251354 = temp_output_463_0_g251354;
					half2 XZ_1500_g251354 = temp_output_473_0_g251354;
					half2 XZ_2500_g251354 = temp_output_474_0_g251354;
					half2 XZ_3500_g251354 = temp_output_475_0_g251354;
					half2 XY500_g251354 = temp_output_464_0_g251354;
					half2 XY_1500_g251354 = (Out_MaskF456_g251354).zw;
					half2 XY_2500_g251354 = (Out_MaskG456_g251354).xy;
					half2 XY_3500_g251354 = (Out_MaskG456_g251354).zw;
					half Bias500_g251354 = temp_output_510_0_g251354;
					half3 Weights_1500_g251354 = (Out_MaskH456_g251354).xyz;
					half3 Weights_2500_g251354 = temp_output_480_0_g251354;
					half3 Weights_3500_g251354 = (Out_MaskJ456_g251354).xyz;
					half3 Triplanar500_g251354 = temp_output_482_0_g251354;
					half3 NormalWS500_g251354 = temp_output_483_0_g251354;
					half3 Normal500_g251354 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251354 = SampleStochastic3D( Texture500_g251354 , Sampler500_g251354 , ZY500_g251354 , ZY_1500_g251354 , ZY_2500_g251354 , ZY_3500_g251354 , XZ500_g251354 , XZ_1500_g251354 , XZ_2500_g251354 , XZ_3500_g251354 , XY500_g251354 , XY_1500_g251354 , XY_2500_g251354 , XY_3500_g251354 , Bias500_g251354 , Weights_1500_g251354 , Weights_2500_g251354 , Weights_3500_g251354 , Triplanar500_g251354 , NormalWS500_g251354 , Normal500_g251354 );
					float4 temp_output_405_203_g241396 = localSampleStochastic3D500_g251354;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g241396 = temp_output_405_277_g241396;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g241396 = temp_output_405_278_g241396;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g241396 = temp_output_405_0_g241396;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g241396 = temp_output_405_201_g241396;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g241396 = temp_output_405_202_g241396;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g241396 = temp_output_405_203_g241396;
					#else
					float4 staticSwitch198_g241396 = temp_output_405_277_g241396;
					#endif
					half4 Local_ShaderSample199_g241396 = staticSwitch198_g241396;
					float temp_output_209_0_g241396 = (Local_ShaderSample199_g241396).y;
					float temp_output_7_0_g251323 = _MainOcclusionRemap.x;
					float temp_output_9_0_g251323 = ( temp_output_209_0_g241396 - temp_output_7_0_g251323 );
					float lerpResult23_g241396 = lerp( 1.0 , saturate( ( temp_output_9_0_g251323 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g241396 = lerpResult23_g241396;
					float temp_output_213_0_g241396 = (Local_ShaderSample199_g241396).w;
					float temp_output_7_0_g251327 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g251327 = ( temp_output_213_0_g241396 - temp_output_7_0_g251327 );
					half Local_Smoothness317_g241396 = ( saturate( ( temp_output_9_0_g251327 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g241396 = (float4(( (Local_ShaderSample199_g241396).x * _MainMetallicValue ) , Local_Occlusion313_g241396 , (Local_ShaderSample199_g241396).z , Local_Smoothness317_g241396));
					half4 Local_Masks109_g241396 = appendResult73_g241396;
					float temp_output_135_0_g241396 = (Local_Masks109_g241396).z;
					float temp_output_7_0_g251322 = _MainMultiRemap.x;
					float temp_output_9_0_g251322 = ( temp_output_135_0_g241396 - temp_output_7_0_g251322 );
					float temp_output_42_0_g241396 = saturate( ( temp_output_9_0_g251322 * _MainMultiRemap.z ) );
					half Local_MultiMask78_g241396 = temp_output_42_0_g241396;
					float lerpResult58_g241396 = lerp( 1.0 , Local_MultiMask78_g241396 , _MainColorMode);
					float4 lerpResult62_g241396 = lerp( _MainColorTwo , _MainColor , lerpResult58_g241396);
					half3 Local_ColorRGB93_g241396 = (lerpResult62_g241396).rgb;
					half3 Local_Albedo139_g241396 = ( Local_AlbedoRGB107_g241396 * Local_ColorRGB93_g241396 );
					float3 temp_output_4_0_g251315 = Local_Albedo139_g241396;
					float3 In_Albedo3_g251315 = temp_output_4_0_g251315;
					float3 temp_output_44_0_g251315 = Local_Albedo139_g241396;
					float3 In_AlbedoBase3_g251315 = temp_output_44_0_g251315;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251355) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g251352 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g251352 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g251352 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g251352 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g251352 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g251352 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251355 = staticSwitch37_g251352;
					float localBreakTextureData456_g251355 = ( 0.0 );
					TVEMasksData Data456_g251355 =(TVEMasksData)Data431_g251346;
					float4 Out_MaskA456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251355 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251355 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251355 , Out_MaskA456_g251355 , Out_MaskB456_g251355 , Out_MaskC456_g251355 , Out_MaskD456_g251355 , Out_MaskE456_g251355 , Out_MaskF456_g251355 , Out_MaskG456_g251355 , Out_MaskH456_g251355 , Out_MaskI456_g251355 , Out_MaskJ456_g251355 , Out_MaskK456_g251355 , Out_MaskL456_g251355 , Out_MaskM456_g251355 , Out_MaskN456_g251355 );
					half2 UV276_g251355 = (Out_MaskA456_g251355).xy;
					float temp_output_504_0_g251355 = 0.0;
					half Bias276_g251355 = temp_output_504_0_g251355;
					half2 Normal276_g251355 = float2( 0,0 );
					half4 localSampleCoord276_g251355 = SampleCoord( Texture276_g251355 , Sampler276_g251355 , UV276_g251355 , Bias276_g251355 , Normal276_g251355 );
					float2 temp_output_406_394_g241396 = Normal276_g251355;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251355) = _MainNormalTex;
					SamplerState Sampler502_g251355 = staticSwitch37_g251352;
					half2 UV502_g251355 = (Out_MaskA456_g251355).zw;
					half Bias502_g251355 = temp_output_504_0_g251355;
					half2 Normal502_g251355 = float2( 0,0 );
					half4 localSampleCoord502_g251355 = SampleCoord( Texture502_g251355 , Sampler502_g251355 , UV502_g251355 , Bias502_g251355 , Normal502_g251355 );
					float2 temp_output_406_397_g241396 = Normal502_g251355;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251355) = _MainNormalTex;
					SamplerState Sampler496_g251355 = staticSwitch37_g251352;
					float2 temp_output_463_0_g251355 = (Out_MaskB456_g251355).zw;
					half2 XZ496_g251355 = temp_output_463_0_g251355;
					half Bias496_g251355 = temp_output_504_0_g251355;
					float3 temp_output_483_0_g251355 = (Out_MaskK456_g251355).xyz;
					half3 NormalWS496_g251355 = temp_output_483_0_g251355;
					half3 Normal496_g251355 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251355 = SamplePlanar2D( Texture496_g251355 , Sampler496_g251355 , XZ496_g251355 , Bias496_g251355 , NormalWS496_g251355 , Normal496_g251355 );
					float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
					float3 worldToTangentDir408_g251355 = normalize( mul( ase_worldToTangent, Normal496_g251355 ) );
					float2 temp_output_406_375_g241396 = (worldToTangentDir408_g251355).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251355) = _MainNormalTex;
					SamplerState Sampler490_g251355 = staticSwitch37_g251352;
					float2 temp_output_462_0_g251355 = (Out_MaskB456_g251355).xy;
					half2 ZY490_g251355 = temp_output_462_0_g251355;
					half2 XZ490_g251355 = temp_output_463_0_g251355;
					float2 temp_output_464_0_g251355 = (Out_MaskC456_g251355).xy;
					half2 XY490_g251355 = temp_output_464_0_g251355;
					half Bias490_g251355 = temp_output_504_0_g251355;
					float3 temp_output_482_0_g251355 = (Out_MaskN456_g251355).xyz;
					half3 Triplanar490_g251355 = temp_output_482_0_g251355;
					half3 NormalWS490_g251355 = temp_output_483_0_g251355;
					half3 Normal490_g251355 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251355 = SamplePlanar3D( Texture490_g251355 , Sampler490_g251355 , ZY490_g251355 , XZ490_g251355 , XY490_g251355 , Bias490_g251355 , Triplanar490_g251355 , NormalWS490_g251355 , Normal490_g251355 );
					float3 worldToTangentDir399_g251355 = normalize( mul( ase_worldToTangent, Normal490_g251355 ) );
					float2 temp_output_406_353_g241396 = (worldToTangentDir399_g251355).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251355) = _MainNormalTex;
					SamplerState Sampler498_g251355 = staticSwitch37_g251352;
					half2 XZ498_g251355 = temp_output_463_0_g251355;
					float2 temp_output_473_0_g251355 = (Out_MaskE456_g251355).xy;
					half2 XZ_1498_g251355 = temp_output_473_0_g251355;
					float2 temp_output_474_0_g251355 = (Out_MaskE456_g251355).zw;
					half2 XZ_2498_g251355 = temp_output_474_0_g251355;
					float2 temp_output_475_0_g251355 = (Out_MaskF456_g251355).xy;
					half2 XZ_3498_g251355 = temp_output_475_0_g251355;
					float temp_output_510_0_g251355 = exp2( temp_output_504_0_g251355 );
					half Bias498_g251355 = temp_output_510_0_g251355;
					float3 temp_output_480_0_g251355 = (Out_MaskI456_g251355).xyz;
					half3 Weights_2498_g251355 = temp_output_480_0_g251355;
					half3 NormalWS498_g251355 = temp_output_483_0_g251355;
					half3 Normal498_g251355 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251355 = SampleStochastic2D( Texture498_g251355 , Sampler498_g251355 , XZ498_g251355 , XZ_1498_g251355 , XZ_2498_g251355 , XZ_3498_g251355 , Bias498_g251355 , Weights_2498_g251355 , NormalWS498_g251355 , Normal498_g251355 );
					float3 worldToTangentDir411_g251355 = normalize( mul( ase_worldToTangent, Normal498_g251355 ) );
					float2 temp_output_406_391_g241396 = (worldToTangentDir411_g251355).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251355) = _MainNormalTex;
					SamplerState Sampler500_g251355 = staticSwitch37_g251352;
					half2 ZY500_g251355 = temp_output_462_0_g251355;
					half2 ZY_1500_g251355 = (Out_MaskC456_g251355).zw;
					half2 ZY_2500_g251355 = (Out_MaskD456_g251355).xy;
					half2 ZY_3500_g251355 = (Out_MaskD456_g251355).zw;
					half2 XZ500_g251355 = temp_output_463_0_g251355;
					half2 XZ_1500_g251355 = temp_output_473_0_g251355;
					half2 XZ_2500_g251355 = temp_output_474_0_g251355;
					half2 XZ_3500_g251355 = temp_output_475_0_g251355;
					half2 XY500_g251355 = temp_output_464_0_g251355;
					half2 XY_1500_g251355 = (Out_MaskF456_g251355).zw;
					half2 XY_2500_g251355 = (Out_MaskG456_g251355).xy;
					half2 XY_3500_g251355 = (Out_MaskG456_g251355).zw;
					half Bias500_g251355 = temp_output_510_0_g251355;
					half3 Weights_1500_g251355 = (Out_MaskH456_g251355).xyz;
					half3 Weights_2500_g251355 = temp_output_480_0_g251355;
					half3 Weights_3500_g251355 = (Out_MaskJ456_g251355).xyz;
					half3 Triplanar500_g251355 = temp_output_482_0_g251355;
					half3 NormalWS500_g251355 = temp_output_483_0_g251355;
					half3 Normal500_g251355 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251355 = SampleStochastic3D( Texture500_g251355 , Sampler500_g251355 , ZY500_g251355 , ZY_1500_g251355 , ZY_2500_g251355 , ZY_3500_g251355 , XZ500_g251355 , XZ_1500_g251355 , XZ_2500_g251355 , XZ_3500_g251355 , XY500_g251355 , XY_1500_g251355 , XY_2500_g251355 , XY_3500_g251355 , Bias500_g251355 , Weights_1500_g251355 , Weights_2500_g251355 , Weights_3500_g251355 , Triplanar500_g251355 , NormalWS500_g251355 , Normal500_g251355 );
					float3 worldToTangentDir403_g251355 = normalize( mul( ase_worldToTangent, Normal500_g251355 ) );
					float2 temp_output_406_390_g241396 = (worldToTangentDir403_g251355).xy;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g241396 = temp_output_406_394_g241396;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g241396 = temp_output_406_397_g241396;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g241396 = temp_output_406_375_g241396;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g241396 = temp_output_406_353_g241396;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g241396 = temp_output_406_391_g241396;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g241396 = temp_output_406_390_g241396;
					#else
					float2 staticSwitch193_g241396 = temp_output_406_394_g241396;
					#endif
					half2 Local_NormaSample191_g241396 = staticSwitch193_g241396;
					half2 Local_NormalTS108_g241396 = ( Local_NormaSample191_g241396 * _MainNormalValue );
					float2 In_NormalTS3_g251315 = Local_NormalTS108_g241396;
					float3 appendResult68_g251329 = (float3(Local_NormalTS108_g241396 , 1.0));
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal74_g251329 = appendResult68_g251329;
					float3 worldNormal74_g251329 = normalize( float3( dot( tanToWorld0, tanNormal74_g251329 ), dot( tanToWorld1, tanNormal74_g251329 ), dot( tanToWorld2, tanNormal74_g251329 ) ) );
					half3 Local_NormalWS250_g241396 = worldNormal74_g251329;
					float3 In_NormalWS3_g251315 = Local_NormalWS250_g241396;
					float4 In_Shader3_g251315 = Local_Masks109_g241396;
					float4 In_Feature3_g251315 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251315 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251315 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g251326 = Local_Albedo139_g241396;
					float dotResult20_g251326 = dot( temp_output_3_0_g251326 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g241396 = dotResult20_g251326;
					float temp_output_12_0_g251315 = Local_Grayscale110_g241396;
					float In_Grayscale3_g251315 = temp_output_12_0_g251315;
					float clampResult27_g251328 = clamp( saturate( ( Local_Grayscale110_g241396 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g241396 = clampResult27_g251328;
					float temp_output_16_0_g251315 = Local_Luminosity145_g241396;
					float In_Luminosity3_g251315 = temp_output_16_0_g251315;
					float In_MultiMask3_g251315 = Local_MultiMask78_g241396;
					float temp_output_187_0_g241396 = (Local_AlbedoSample185_g241396).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g241396 = ( temp_output_187_0_g241396 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g241396 = temp_output_187_0_g241396;
					#endif
					half Local_AlphaClip111_g241396 = staticSwitch236_g241396;
					float In_AlphaClip3_g251315 = Local_AlphaClip111_g241396;
					half Local_AlphaFade246_g241396 = (lerpResult62_g241396).a;
					float In_AlphaFade3_g251315 = Local_AlphaFade246_g241396;
					float3 temp_cast_19 = (1.0).xxx;
					float3 In_Translucency3_g251315 = temp_cast_19;
					float In_Transmission3_g251315 = 1.0;
					float In_Thickness3_g251315 = 0.0;
					float In_Diffusion3_g251315 = 0.0;
					float In_Depth3_g251315 = 0.0;
					BuildVisualData( Data3_g251315 , In_Dummy3_g251315 , In_Albedo3_g251315 , In_AlbedoBase3_g251315 , In_NormalTS3_g251315 , In_NormalWS3_g251315 , In_Shader3_g251315 , In_Feature3_g251315 , In_Season3_g251315 , In_Emissive3_g251315 , In_Grayscale3_g251315 , In_Luminosity3_g251315 , In_MultiMask3_g251315 , In_AlphaClip3_g251315 , In_AlphaFade3_g251315 , In_Translucency3_g251315 , In_Transmission3_g251315 , In_Thickness3_g251315 , In_Diffusion3_g251315 , In_Depth3_g251315 );
					TVEVisualData Data4_g251475 =(TVEVisualData)Data3_g251315;
					float Out_Dummy4_g251475 = 0.0;
					float3 Out_Albedo4_g251475 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251475 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251475 = float2( 0,0 );
					float3 Out_NormalWS4_g251475 = float3( 0,0,0 );
					float4 Out_Shader4_g251475 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251475 = float4( 0,0,0,0 );
					float4 Out_Season4_g251475 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251475 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251475 = 0.0;
					float Out_Grayscale4_g251475 = 0.0;
					float Out_Luminosity4_g251475 = 0.0;
					float Out_AlphaClip4_g251475 = 0.0;
					float Out_AlphaFade4_g251475 = 0.0;
					float3 Out_Translucency4_g251475 = float3( 0,0,0 );
					float Out_Transmission4_g251475 = 0.0;
					float Out_Thickness4_g251475 = 0.0;
					float Out_Diffusion4_g251475 = 0.0;
					float Out_Depth4_g251475 = 0.0;
					BreakVisualData( Data4_g251475 , Out_Dummy4_g251475 , Out_Albedo4_g251475 , Out_AlbedoBase4_g251475 , Out_NormalTS4_g251475 , Out_NormalWS4_g251475 , Out_Shader4_g251475 , Out_Feature4_g251475 , Out_Season4_g251475 , Out_Emissive4_g251475 , Out_MultiMask4_g251475 , Out_Grayscale4_g251475 , Out_Luminosity4_g251475 , Out_AlphaClip4_g251475 , Out_AlphaFade4_g251475 , Out_Translucency4_g251475 , Out_Transmission4_g251475 , Out_Thickness4_g251475 , Out_Diffusion4_g251475 , Out_Depth4_g251475 );
					float temp_output_739_15_g251434 = Out_Luminosity4_g251475;
					half Visual_Luminosity654_g251434 = temp_output_739_15_g251434;
					float temp_output_7_0_g251446 = _OverlayLumaRemap.x;
					float temp_output_9_0_g251446 = ( Visual_Luminosity654_g251434 - temp_output_7_0_g251446 );
					float lerpResult587_g251434 = lerp( 1.0 , saturate( ( temp_output_9_0_g251446 * _OverlayLumaRemap.z ) ) , _OverlayLumaValue);
					half Blend_LumaMask438_g251434 = lerpResult587_g251434;
					float temp_output_17_0_g251464 = _OverlayMeshMode;
					float Option70_g251464 = temp_output_17_0_g251464;
					TVEModelData Data15_g251477 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g251477 = 0.0;
					float3 Out_PositionWS15_g251477 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251477 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251477 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251477 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251477 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251477 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251477 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251477 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251477 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251477 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251477 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251477 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251477 , Out_Dummy15_g251477 , Out_PositionWS15_g251477 , Out_PositionWO15_g251477 , Out_PivotWS15_g251477 , Out_PivotWO15_g251477 , Out_NormalWS15_g251477 , Out_TangentWS15_g251477 , Out_BitangentWS15_g251477 , Out_TriplanarWeights15_g251477 , Out_ViewDirWS15_g251477 , Out_CoordsData15_g251477 , Out_VertexData15_g251477 , Out_PhaseData15_g251477 );
					half4 Model_VertexData791_g251434 = Out_VertexData15_g251477;
					float4 temp_output_3_0_g251464 = Model_VertexData791_g251434;
					float4 Channel70_g251464 = temp_output_3_0_g251464;
					float localSwitchChannel470_g251464 = SwitchChannel4( Option70_g251464 , Channel70_g251464 );
					float temp_output_1142_0_g251434 = localSwitchChannel470_g251464;
					float temp_output_7_0_g251444 = _OverlayMeshRemap.x;
					float temp_output_9_0_g251444 = ( temp_output_1142_0_g251434 - temp_output_7_0_g251444 );
					float lerpResult881_g251434 = lerp( 1.0 , saturate( ( temp_output_9_0_g251444 * _OverlayMeshRemap.z ) ) , _OverlayMeshValue);
					half Blend_VertMask801_g251434 = lerpResult881_g251434;
					float3 temp_output_739_21_g251434 = Out_NormalWS4_g251475;
					half3 Visual_NormalWS749_g251434 = temp_output_739_21_g251434;
					float temp_output_505_0_g251434 = saturate( (Visual_NormalWS749_g251434).y );
					float temp_output_7_0_g251449 = _OverlayProjRemap.x;
					float temp_output_9_0_g251449 = ( temp_output_505_0_g251434 - temp_output_7_0_g251449 );
					float lerpResult842_g251434 = lerp( 1.0 , saturate( ( temp_output_9_0_g251449 * _OverlayProjRemap.z ) ) , _OverlayProjValue);
					half Blend_ProjMask457_g251434 = lerpResult842_g251434;
					half Blend_NoiseMask427_g251434 = 1.0;
					half Blend_UserMask646_g251434 = 1.0;
					half Blend_FormMask_Mul958_g251434 = 1.0;
					half Blend_GlobalMask429_g251434 = 1.0;
					half Blend_FormMask_Add957_g251434 = 0.0;
					float temp_output_970_0_g251434 = ( saturate( ( ( Blend_TexMask908_g251434 * Blend_LumaMask438_g251434 * Blend_VertMask801_g251434 * Blend_ProjMask457_g251434 * Blend_NoiseMask427_g251434 * Blend_UserMask646_g251434 * Blend_FormMask_Mul958_g251434 * Blend_GlobalMask429_g251434 ) + Blend_FormMask_Add957_g251434 ) ) * _OverlayIntensityValue );
					float temp_output_7_0_g251452 = _OverlayBlendRemap.x;
					float temp_output_9_0_g251452 = ( temp_output_970_0_g251434 - temp_output_7_0_g251452 );
					half Blend_Mask494_g251434 = saturate( ( temp_output_9_0_g251452 * _OverlayBlendRemap.z ) );
					half Blend_BakerMask998_g251434 = ( Blend_TexMask908_g251434 * Blend_LumaMask438_g251434 * Blend_VertMask801_g251434 );
					float4 appendResult993_g251434 = (float4(Blend_Mask494_g251434 , 0.0 , 0.0 , Blend_BakerMask998_g251434));
					float4 temp_cast_20 = (0.0).xxxx;
					float4 temp_cast_21 = (0.0).xxxx;
					float4 ifLocalVar18_g251482 = 0;
					if( Feature_Intensity1107_g251434 <= 0.0 )
					ifLocalVar18_g251482 = temp_cast_21;
					else
					ifLocalVar18_g251482 = appendResult993_g251434;
					float4 In_MaskB3_g251483 = ifLocalVar18_g251482;
					float4 temp_cast_22 = (0.0).xxxx;
					float4 In_MaskC3_g251483 = temp_cast_22;
					float4 temp_cast_23 = (0.0).xxxx;
					float4 In_MaskD3_g251483 = temp_cast_23;
					float4 temp_cast_24 = (0.0).xxxx;
					float4 In_MaskE3_g251483 = temp_cast_24;
					float4 temp_cast_25 = (0.0).xxxx;
					float4 In_MaskF3_g251483 = temp_cast_25;
					float4 temp_cast_26 = (0.0).xxxx;
					float4 In_MaskG3_g251483 = temp_cast_26;
					float4 temp_cast_27 = (0.0).xxxx;
					float4 In_MaskH3_g251483 = temp_cast_27;
					float4 temp_cast_28 = (0.0).xxxx;
					float4 In_MaskI3_g251483 = temp_cast_28;
					float4 temp_cast_29 = (0.0).xxxx;
					float4 In_MaskJ3_g251483 = temp_cast_29;
					float4 temp_cast_30 = (0.0).xxxx;
					float4 In_MaskK3_g251483 = temp_cast_30;
					float4 temp_cast_31 = (0.0).xxxx;
					float4 In_MaskL3_g251483 = temp_cast_31;
					{
					Data3_g251483.MaskA = In_MaskA3_g251483;
					Data3_g251483.MaskB = In_MaskB3_g251483;
					Data3_g251483.MaskC = In_MaskC3_g251483;
					Data3_g251483.MaskD = In_MaskD3_g251483;
					Data3_g251483.MaskE = In_MaskE3_g251483;
					Data3_g251483.MaskF = In_MaskF3_g251483;
					Data3_g251483.MaskG = In_MaskG3_g251483;
					Data3_g251483.MaskH = In_MaskH3_g251483;
					Data3_g251483.MaskI = In_MaskI3_g251483;
					Data3_g251483.MaskJ= In_MaskJ3_g251483;
					Data3_g251483.MaskK= In_MaskK3_g251483;
					Data3_g251483.MaskL = In_MaskL3_g251483;
					}
					TVEMasksData DataA25_g251541 = Data3_g251483;
					float localBuildMasksData3_g251536 = ( 0.0 );
					TVEMasksData Data3_g251536 = (TVEMasksData)0;
					half Feature_Intensity1107_g251487 = _OverlayIntensityValue;
					float ifLocalVar18_g251532 = 0;
					if( Feature_Intensity1107_g251487 <= 0.0 )
					ifLocalVar18_g251532 = 0.0;
					else
					ifLocalVar18_g251532 = 1.0;
					half Feature_Maps1112_g251487 = _OverlayTextureMode;
					float ifLocalVar18_g251533 = 0;
					if( Feature_Maps1112_g251487 <= 0.0 )
					ifLocalVar18_g251533 = 0.0;
					else
					ifLocalVar18_g251533 = 1.0;
					half Feature_Glitter1108_g251487 = _OverlayGlitterIntensityValue;
					float ifLocalVar18_g251534 = 0;
					if( Feature_Glitter1108_g251487 <= 0.0 )
					ifLocalVar18_g251534 = 0.0;
					else
					ifLocalVar18_g251534 = 1.0;
					half Feature_Element1085_g251487 = _OverlayElementMode;
					float ifLocalVar18_g251531 = 0;
					if( Feature_Element1085_g251487 <= 0.0 )
					ifLocalVar18_g251531 = 0.0;
					else
					ifLocalVar18_g251531 = 1.0;
					float4 appendResult1117_g251487 = (float4(ifLocalVar18_g251532 , ifLocalVar18_g251533 , ifLocalVar18_g251534 , ifLocalVar18_g251531));
					float4 In_MaskA3_g251536 = appendResult1117_g251487;
					half Blend_TexMask908_g251487 = 1.0;
					float localBreakVisualData4_g251528 = ( 0.0 );
					TVEVisualData Data4_g251528 =(TVEVisualData)Data3_g251315;
					float Out_Dummy4_g251528 = 0.0;
					float3 Out_Albedo4_g251528 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251528 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251528 = float2( 0,0 );
					float3 Out_NormalWS4_g251528 = float3( 0,0,0 );
					float4 Out_Shader4_g251528 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251528 = float4( 0,0,0,0 );
					float4 Out_Season4_g251528 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251528 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251528 = 0.0;
					float Out_Grayscale4_g251528 = 0.0;
					float Out_Luminosity4_g251528 = 0.0;
					float Out_AlphaClip4_g251528 = 0.0;
					float Out_AlphaFade4_g251528 = 0.0;
					float3 Out_Translucency4_g251528 = float3( 0,0,0 );
					float Out_Transmission4_g251528 = 0.0;
					float Out_Thickness4_g251528 = 0.0;
					float Out_Diffusion4_g251528 = 0.0;
					float Out_Depth4_g251528 = 0.0;
					BreakVisualData( Data4_g251528 , Out_Dummy4_g251528 , Out_Albedo4_g251528 , Out_AlbedoBase4_g251528 , Out_NormalTS4_g251528 , Out_NormalWS4_g251528 , Out_Shader4_g251528 , Out_Feature4_g251528 , Out_Season4_g251528 , Out_Emissive4_g251528 , Out_MultiMask4_g251528 , Out_Grayscale4_g251528 , Out_Luminosity4_g251528 , Out_AlphaClip4_g251528 , Out_AlphaFade4_g251528 , Out_Translucency4_g251528 , Out_Transmission4_g251528 , Out_Thickness4_g251528 , Out_Diffusion4_g251528 , Out_Depth4_g251528 );
					float temp_output_739_15_g251487 = Out_Luminosity4_g251528;
					half Visual_Luminosity654_g251487 = temp_output_739_15_g251487;
					float temp_output_7_0_g251499 = _OverlayLumaRemap.x;
					float temp_output_9_0_g251499 = ( Visual_Luminosity654_g251487 - temp_output_7_0_g251499 );
					float lerpResult587_g251487 = lerp( 1.0 , saturate( ( temp_output_9_0_g251499 * _OverlayLumaRemap.z ) ) , _OverlayLumaValue);
					half Blend_LumaMask438_g251487 = lerpResult587_g251487;
					float temp_output_17_0_g251517 = _OverlayMeshMode;
					float Option70_g251517 = temp_output_17_0_g251517;
					TVEModelData Data15_g251530 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g251530 = 0.0;
					float3 Out_PositionWS15_g251530 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251530 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251530 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251530 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251530 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251530 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251530 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251530 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251530 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251530 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251530 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251530 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251530 , Out_Dummy15_g251530 , Out_PositionWS15_g251530 , Out_PositionWO15_g251530 , Out_PivotWS15_g251530 , Out_PivotWO15_g251530 , Out_NormalWS15_g251530 , Out_TangentWS15_g251530 , Out_BitangentWS15_g251530 , Out_TriplanarWeights15_g251530 , Out_ViewDirWS15_g251530 , Out_CoordsData15_g251530 , Out_VertexData15_g251530 , Out_PhaseData15_g251530 );
					half4 Model_VertexData791_g251487 = Out_VertexData15_g251530;
					float4 temp_output_3_0_g251517 = Model_VertexData791_g251487;
					float4 Channel70_g251517 = temp_output_3_0_g251517;
					float localSwitchChannel470_g251517 = SwitchChannel4( Option70_g251517 , Channel70_g251517 );
					float temp_output_1142_0_g251487 = localSwitchChannel470_g251517;
					float temp_output_7_0_g251497 = _OverlayMeshRemap.x;
					float temp_output_9_0_g251497 = ( temp_output_1142_0_g251487 - temp_output_7_0_g251497 );
					float lerpResult881_g251487 = lerp( 1.0 , saturate( ( temp_output_9_0_g251497 * _OverlayMeshRemap.z ) ) , _OverlayMeshValue);
					half Blend_VertMask801_g251487 = lerpResult881_g251487;
					float3 temp_output_739_21_g251487 = Out_NormalWS4_g251528;
					half3 Visual_NormalWS749_g251487 = temp_output_739_21_g251487;
					float temp_output_505_0_g251487 = saturate( (Visual_NormalWS749_g251487).y );
					float temp_output_7_0_g251502 = _OverlayProjRemap.x;
					float temp_output_9_0_g251502 = ( temp_output_505_0_g251487 - temp_output_7_0_g251502 );
					float lerpResult842_g251487 = lerp( 1.0 , saturate( ( temp_output_9_0_g251502 * _OverlayProjRemap.z ) ) , _OverlayProjValue);
					half Blend_ProjMask457_g251487 = lerpResult842_g251487;
					half Blend_NoiseMask427_g251487 = 1.0;
					half Blend_UserMask646_g251487 = 1.0;
					half Blend_FormMask_Mul958_g251487 = 1.0;
					float localBuildGlobalData204_g251357 = ( 0.0 );
					TVEGlobalData Data204_g251357 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251357 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251357 = Dummy211_g251357;
					float4 temp_output_589_164_g251357 = TVE_CoatParams;
					half4 Coat_Params596_g251357 = temp_output_589_164_g251357;
					float4 In_CoatParams204_g251357 = Coat_Params596_g251357;
					float4 temp_output_203_0_g251377 = TVE_CoatBaseCoord;
					TVEModelData Data15_g251433 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g251433 = 0.0;
					float3 Out_PositionWS15_g251433 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251433 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251433 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251433 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251433 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251433 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251433 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251433 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251433 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251433 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251433 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251433 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251433 , Out_Dummy15_g251433 , Out_PositionWS15_g251433 , Out_PositionWO15_g251433 , Out_PivotWS15_g251433 , Out_PivotWO15_g251433 , Out_NormalWS15_g251433 , Out_TangentWS15_g251433 , Out_BitangentWS15_g251433 , Out_TriplanarWeights15_g251433 , Out_ViewDirWS15_g251433 , Out_CoordsData15_g251433 , Out_VertexData15_g251433 , Out_PhaseData15_g251433 );
					float3 Model_PositionWS497_g251357 = Out_PositionWS15_g251433;
					float2 Model_PositionWS_XZ143_g251357 = (Model_PositionWS497_g251357).xz;
					float3 Model_PivotWS498_g251357 = Out_PivotWS15_g251433;
					float2 Model_PivotWS_XZ145_g251357 = (Model_PivotWS498_g251357).xz;
					float2 lerpResult300_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251377 = lerpResult300_g251357;
					float temp_output_82_0_g251375 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251377 = temp_output_82_0_g251375;
					float4 tex2DArrayNode83_g251377 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251377).zw + ( (temp_output_203_0_g251377).xy * temp_output_81_0_g251377 ) ),temp_output_82_0_g251377) );
					float4 appendResult210_g251377 = (float4(tex2DArrayNode83_g251377.rgb , saturate( tex2DArrayNode83_g251377.a )));
					float4 temp_output_204_0_g251377 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251377 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251377).zw + ( (temp_output_204_0_g251377).xy * temp_output_81_0_g251377 ) ),temp_output_82_0_g251377) );
					float4 appendResult212_g251377 = (float4(tex2DArrayNode122_g251377.rgb , saturate( tex2DArrayNode122_g251377.a )));
					float4 TVE_RenderNearPositionR628_g251357 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251357 = saturate( ( distance( Model_PositionWS497_g251357 , (TVE_RenderNearPositionR628_g251357).xyz ) / (TVE_RenderNearPositionR628_g251357).w ) );
					float temp_output_7_0_g251358 = 1.0;
					float temp_output_9_0_g251358 = ( temp_output_507_0_g251357 - temp_output_7_0_g251358 );
					half TVE_RenderNearFadeValue635_g251357 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251357 = saturate( ( temp_output_9_0_g251358 / ( ( TVE_RenderNearFadeValue635_g251357 - temp_output_7_0_g251358 ) + 0.0001 ) ) );
					float4 lerpResult131_g251377 = lerp( appendResult210_g251377 , appendResult212_g251377 , Global_TexBlend509_g251357);
					float4 temp_output_159_109_g251375 = lerpResult131_g251377;
					float4 lerpResult168_g251375 = lerp( TVE_CoatParams , temp_output_159_109_g251375 , TVE_CoatLayers[(int)temp_output_82_0_g251375]);
					float4 temp_output_589_109_g251357 = lerpResult168_g251375;
					half4 Coat_Texture302_g251357 = temp_output_589_109_g251357;
					float4 In_CoatTexture204_g251357 = Coat_Texture302_g251357;
					float4 temp_output_595_164_g251357 = TVE_PaintParams;
					half4 Paint_Params575_g251357 = temp_output_595_164_g251357;
					float4 In_PaintParams204_g251357 = Paint_Params575_g251357;
					float4 temp_output_203_0_g251426 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251426 = lerpResult85_g251357;
					float temp_output_82_0_g251423 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251426 = temp_output_82_0_g251423;
					float4 tex2DArrayNode83_g251426 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251426).zw + ( (temp_output_203_0_g251426).xy * temp_output_81_0_g251426 ) ),temp_output_82_0_g251426) );
					float4 appendResult210_g251426 = (float4(tex2DArrayNode83_g251426.rgb , saturate( tex2DArrayNode83_g251426.a )));
					float4 temp_output_204_0_g251426 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251426 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251426).zw + ( (temp_output_204_0_g251426).xy * temp_output_81_0_g251426 ) ),temp_output_82_0_g251426) );
					float4 appendResult212_g251426 = (float4(tex2DArrayNode122_g251426.rgb , saturate( tex2DArrayNode122_g251426.a )));
					float4 lerpResult131_g251426 = lerp( appendResult210_g251426 , appendResult212_g251426 , Global_TexBlend509_g251357);
					float4 temp_output_171_109_g251423 = lerpResult131_g251426;
					float4 lerpResult174_g251423 = lerp( TVE_PaintParams , temp_output_171_109_g251423 , TVE_PaintLayers[(int)temp_output_82_0_g251423]);
					float4 temp_output_595_109_g251357 = lerpResult174_g251423;
					half4 Paint_Texture71_g251357 = temp_output_595_109_g251357;
					float4 In_PaintTexture204_g251357 = Paint_Texture71_g251357;
					float4 temp_output_590_141_g251357 = TVE_AtmoParams;
					half4 Atmo_Params601_g251357 = temp_output_590_141_g251357;
					float4 In_AtmoParams204_g251357 = Atmo_Params601_g251357;
					float4 temp_output_203_0_g251385 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251385 = lerpResult104_g251357;
					float temp_output_132_0_g251383 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251385 = temp_output_132_0_g251383;
					float4 tex2DArrayNode83_g251385 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251385).zw + ( (temp_output_203_0_g251385).xy * temp_output_81_0_g251385 ) ),temp_output_82_0_g251385) );
					float4 appendResult210_g251385 = (float4(tex2DArrayNode83_g251385.rgb , saturate( tex2DArrayNode83_g251385.a )));
					float4 temp_output_204_0_g251385 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251385 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251385).zw + ( (temp_output_204_0_g251385).xy * temp_output_81_0_g251385 ) ),temp_output_82_0_g251385) );
					float4 appendResult212_g251385 = (float4(tex2DArrayNode122_g251385.rgb , saturate( tex2DArrayNode122_g251385.a )));
					float4 lerpResult131_g251385 = lerp( appendResult210_g251385 , appendResult212_g251385 , Global_TexBlend509_g251357);
					float4 temp_output_137_109_g251383 = lerpResult131_g251385;
					float4 lerpResult145_g251383 = lerp( TVE_AtmoParams , temp_output_137_109_g251383 , TVE_AtmoLayers[(int)temp_output_132_0_g251383]);
					float4 temp_output_590_110_g251357 = lerpResult145_g251383;
					half4 Atmo_Texture80_g251357 = temp_output_590_110_g251357;
					float4 In_AtmoTexture204_g251357 = Atmo_Texture80_g251357;
					float4 temp_output_593_163_g251357 = TVE_GlowParams;
					half4 Glow_Params609_g251357 = temp_output_593_163_g251357;
					float4 In_GlowParams204_g251357 = Glow_Params609_g251357;
					float4 temp_output_203_0_g251401 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251401 = lerpResult247_g251357;
					float temp_output_82_0_g251399 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251401 = temp_output_82_0_g251399;
					float4 tex2DArrayNode83_g251401 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251401).zw + ( (temp_output_203_0_g251401).xy * temp_output_81_0_g251401 ) ),temp_output_82_0_g251401) );
					float4 appendResult210_g251401 = (float4(tex2DArrayNode83_g251401.rgb , saturate( tex2DArrayNode83_g251401.a )));
					float4 temp_output_204_0_g251401 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251401 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251401).zw + ( (temp_output_204_0_g251401).xy * temp_output_81_0_g251401 ) ),temp_output_82_0_g251401) );
					float4 appendResult212_g251401 = (float4(tex2DArrayNode122_g251401.rgb , saturate( tex2DArrayNode122_g251401.a )));
					float4 lerpResult131_g251401 = lerp( appendResult210_g251401 , appendResult212_g251401 , Global_TexBlend509_g251357);
					float4 temp_output_159_109_g251399 = lerpResult131_g251401;
					float4 lerpResult167_g251399 = lerp( TVE_GlowParams , temp_output_159_109_g251399 , TVE_GlowLayers[(int)temp_output_82_0_g251399]);
					float4 temp_output_593_109_g251357 = lerpResult167_g251399;
					half4 Glow_Texture248_g251357 = temp_output_593_109_g251357;
					float4 In_GlowTexture204_g251357 = Glow_Texture248_g251357;
					float4 temp_output_592_139_g251357 = TVE_FormParams;
					float4 Form_Params606_g251357 = temp_output_592_139_g251357;
					float4 In_FormParams204_g251357 = Form_Params606_g251357;
					float4 temp_output_203_0_g251417 = TVE_FormBaseCoord;
					float2 lerpResult168_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251417 = lerpResult168_g251357;
					float temp_output_130_0_g251415 = _GlobalFormLayerValue;
					float temp_output_82_0_g251417 = temp_output_130_0_g251415;
					float4 tex2DArrayNode83_g251417 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251417).zw + ( (temp_output_203_0_g251417).xy * temp_output_81_0_g251417 ) ),temp_output_82_0_g251417) );
					float4 appendResult210_g251417 = (float4(tex2DArrayNode83_g251417.rgb , saturate( tex2DArrayNode83_g251417.a )));
					float4 temp_output_204_0_g251417 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251417 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251417).zw + ( (temp_output_204_0_g251417).xy * temp_output_81_0_g251417 ) ),temp_output_82_0_g251417) );
					float4 appendResult212_g251417 = (float4(tex2DArrayNode122_g251417.rgb , saturate( tex2DArrayNode122_g251417.a )));
					float4 lerpResult131_g251417 = lerp( appendResult210_g251417 , appendResult212_g251417 , Global_TexBlend509_g251357);
					float4 temp_output_135_109_g251415 = lerpResult131_g251417;
					float4 lerpResult143_g251415 = lerp( TVE_FormParams , temp_output_135_109_g251415 , TVE_FormLayers[(int)temp_output_130_0_g251415]);
					float4 temp_output_592_0_g251357 = lerpResult143_g251415;
					float4 Form_Texture112_g251357 = temp_output_592_0_g251357;
					float4 In_FormTexture204_g251357 = Form_Texture112_g251357;
					float4 temp_output_594_145_g251357 = TVE_FlowParams;
					half4 Flow_Params612_g251357 = temp_output_594_145_g251357;
					float4 In_FlowParams204_g251357 = Flow_Params612_g251357;
					float4 temp_output_203_0_g251409 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251409 = lerpResult400_g251357;
					float temp_output_136_0_g251407 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251409 = temp_output_136_0_g251407;
					float4 tex2DArrayNode83_g251409 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251409).zw + ( (temp_output_203_0_g251409).xy * temp_output_81_0_g251409 ) ),temp_output_82_0_g251409) );
					float4 appendResult210_g251409 = (float4(tex2DArrayNode83_g251409.rgb , saturate( tex2DArrayNode83_g251409.a )));
					float4 temp_output_204_0_g251409 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251409 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251409).zw + ( (temp_output_204_0_g251409).xy * temp_output_81_0_g251409 ) ),temp_output_82_0_g251409) );
					float4 appendResult212_g251409 = (float4(tex2DArrayNode122_g251409.rgb , saturate( tex2DArrayNode122_g251409.a )));
					float4 lerpResult131_g251409 = lerp( appendResult210_g251409 , appendResult212_g251409 , Global_TexBlend509_g251357);
					float4 temp_output_141_109_g251407 = lerpResult131_g251409;
					float4 lerpResult149_g251407 = lerp( TVE_FlowParams , temp_output_141_109_g251407 , TVE_FlowLayers[(int)temp_output_136_0_g251407]);
					half4 Flow_Texture405_g251357 = lerpResult149_g251407;
					float4 In_FlowTexture204_g251357 = Flow_Texture405_g251357;
					BuildGlobalData( Data204_g251357 , In_Dummy204_g251357 , In_CoatParams204_g251357 , In_CoatTexture204_g251357 , In_PaintParams204_g251357 , In_PaintTexture204_g251357 , In_AtmoParams204_g251357 , In_AtmoTexture204_g251357 , In_GlowParams204_g251357 , In_GlowTexture204_g251357 , In_FormParams204_g251357 , In_FormTexture204_g251357 , In_FlowParams204_g251357 , In_FlowTexture204_g251357 );
					TVEGlobalData Data15_g251488 =(TVEGlobalData)Data204_g251357;
					float Out_Dummy15_g251488 = 0.0;
					float4 Out_CoatParams15_g251488 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251488 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251488 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251488 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251488 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251488 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251488 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251488 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251488 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251488 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251488 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251488 = float4( 0,0,0,0 );
					BreakData( Data15_g251488 , Out_Dummy15_g251488 , Out_CoatParams15_g251488 , Out_CoatTexture15_g251488 , Out_PaintParams15_g251488 , Out_PaintTexture15_g251488 , Out_AtmoParams15_g251488 , Out_AtmoTexture15_g251488 , Out_GlowParams15_g251488 , Out_GlowTexture15_g251488 , Out_FormParams15_g251488 , Out_FormTexture15_g251488 , Out_FlowParams15_g251488 , Out_FlowTexture15_g251488 );
					half4 Global_AtmoParams1143_g251487 = Out_AtmoParams15_g251488;
					float temp_output_1146_0_g251487 = (Global_AtmoParams1143_g251487).y;
					half4 Global_AtmoTexture516_g251487 = Out_AtmoTexture15_g251488;
					float temp_output_6_0_g251518 = (Global_AtmoTexture516_g251487).y;
					float temp_output_7_0_g251518 = _OverlayElementMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g251518 = ( temp_output_6_0_g251518 + temp_output_7_0_g251518 );
					#else
					float staticSwitch14_g251518 = temp_output_6_0_g251518;
					#endif
					float temp_output_939_0_g251487 = staticSwitch14_g251518;
					#ifdef TVE_OVERLAY_ELEMENT
					float staticSwitch705_g251487 = temp_output_939_0_g251487;
					#else
					float staticSwitch705_g251487 = temp_output_1146_0_g251487;
					#endif
					float lerpResult937_g251487 = lerp( 1.0 , ( staticSwitch705_g251487 * TVE_IsEnabled ) , _OverlayGlobalValue);
					half Blend_GlobalMask429_g251487 = lerpResult937_g251487;
					half Blend_FormMask_Add957_g251487 = 0.0;
					float temp_output_970_0_g251487 = ( saturate( ( ( Blend_TexMask908_g251487 * Blend_LumaMask438_g251487 * Blend_VertMask801_g251487 * Blend_ProjMask457_g251487 * Blend_NoiseMask427_g251487 * Blend_UserMask646_g251487 * Blend_FormMask_Mul958_g251487 * Blend_GlobalMask429_g251487 ) + Blend_FormMask_Add957_g251487 ) ) * _OverlayIntensityValue );
					float temp_output_7_0_g251505 = _OverlayBlendRemap.x;
					float temp_output_9_0_g251505 = ( temp_output_970_0_g251487 - temp_output_7_0_g251505 );
					half Blend_Mask494_g251487 = saturate( ( temp_output_9_0_g251505 * _OverlayBlendRemap.z ) );
					half Blend_BakerMask998_g251487 = ( Blend_TexMask908_g251487 * Blend_LumaMask438_g251487 * Blend_VertMask801_g251487 );
					float4 appendResult993_g251487 = (float4(Blend_Mask494_g251487 , 0.0 , 0.0 , Blend_BakerMask998_g251487));
					float4 temp_cast_38 = (0.0).xxxx;
					float4 temp_cast_39 = (0.0).xxxx;
					float4 ifLocalVar18_g251535 = 0;
					if( Feature_Intensity1107_g251487 <= 0.0 )
					ifLocalVar18_g251535 = temp_cast_39;
					else
					ifLocalVar18_g251535 = appendResult993_g251487;
					float4 In_MaskB3_g251536 = ifLocalVar18_g251535;
					float4 temp_cast_40 = (0.0).xxxx;
					float4 In_MaskC3_g251536 = temp_cast_40;
					float4 temp_cast_41 = (0.0).xxxx;
					float4 In_MaskD3_g251536 = temp_cast_41;
					float4 temp_cast_42 = (0.0).xxxx;
					float4 In_MaskE3_g251536 = temp_cast_42;
					float4 temp_cast_43 = (0.0).xxxx;
					float4 In_MaskF3_g251536 = temp_cast_43;
					float4 temp_cast_44 = (0.0).xxxx;
					float4 In_MaskG3_g251536 = temp_cast_44;
					float4 temp_cast_45 = (0.0).xxxx;
					float4 In_MaskH3_g251536 = temp_cast_45;
					float4 temp_cast_46 = (0.0).xxxx;
					float4 In_MaskI3_g251536 = temp_cast_46;
					float4 temp_cast_47 = (0.0).xxxx;
					float4 In_MaskJ3_g251536 = temp_cast_47;
					float4 temp_cast_48 = (0.0).xxxx;
					float4 In_MaskK3_g251536 = temp_cast_48;
					float4 temp_cast_49 = (0.0).xxxx;
					float4 In_MaskL3_g251536 = temp_cast_49;
					{
					Data3_g251536.MaskA = In_MaskA3_g251536;
					Data3_g251536.MaskB = In_MaskB3_g251536;
					Data3_g251536.MaskC = In_MaskC3_g251536;
					Data3_g251536.MaskD = In_MaskD3_g251536;
					Data3_g251536.MaskE = In_MaskE3_g251536;
					Data3_g251536.MaskF = In_MaskF3_g251536;
					Data3_g251536.MaskG = In_MaskG3_g251536;
					Data3_g251536.MaskH = In_MaskH3_g251536;
					Data3_g251536.MaskI = In_MaskI3_g251536;
					Data3_g251536.MaskJ= In_MaskJ3_g251536;
					Data3_g251536.MaskK= In_MaskK3_g251536;
					Data3_g251536.MaskL = In_MaskL3_g251536;
					}
					TVEMasksData DataB25_g251541 = Data3_g251536;
					float Alpha25_g251541 = TVE_DEBUG_Global;
					{
					if (Alpha25_g251541 < 0.5 )
					{
					Data25_g251541 = DataA25_g251541;
					}
					else
					{
					Data25_g251541 = DataB25_g251541;
					}
					}
					TVEMasksData Data4_g251542 = Data25_g251541;
					float4 Out_MaskA4_g251542 = float4( 0,0,0,0 );
					float4 Out_MaskB4_g251542 = float4( 0,0,0,0 );
					float4 Out_MaskC4_g251542 = float4( 0,0,0,0 );
					float4 Out_MaskD4_g251542 = float4( 0,0,0,0 );
					float4 Out_MaskE4_g251542 = float4( 0,0,0,0 );
					float4 Out_MaskF4_g251542 = float4( 0,0,0,0 );
					float4 Out_MaskG4_g251542 = float4( 0,0,0,0 );
					float4 Out_MaskH4_g251542 = float4( 0,0,0,0 );
					{
					Out_MaskA4_g251542 = Data4_g251542.MaskA;
					Out_MaskB4_g251542 = Data4_g251542.MaskB;
					Out_MaskC4_g251542 = Data4_g251542.MaskC;
					Out_MaskD4_g251542 = Data4_g251542.MaskD;
					Out_MaskE4_g251542 = Data4_g251542.MaskE;
					Out_MaskF4_g251542 = Data4_g251542.MaskF;
					Out_MaskG4_g251542 = Data4_g251542.MaskG;
					Out_MaskH4_g251542 = Data4_g251542.MaskH;
					}
					float4 temp_output_2509_14 = Out_MaskA4_g251542;
					float3 lerpResult2568 = lerp( color107_g251543 , color106_g251543 , (temp_output_2509_14).x);
					float3 ifLocalVar40_g251565 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g251565 = lerpResult2568;
					float3 color107_g251545 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251545 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2571 = lerp( color107_g251545 , color106_g251545 , (temp_output_2509_14).y);
					float3 ifLocalVar40_g251566 = 0;
					if( TVE_DEBUG_Index == 1.0 )
					ifLocalVar40_g251566 = lerpResult2571;
					float3 color107_g251547 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251547 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2603 = lerp( color107_g251547 , color106_g251547 , (temp_output_2509_14).z);
					float3 ifLocalVar40_g251567 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g251567 = lerpResult2603;
					float3 ifLocalVar40_g251569 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g251569 = (Out_MaskB4_g251542).xxx;
					float3 color107_g251549 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251549 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2607 = lerp( color107_g251549 , color106_g251549 , (temp_output_2509_14).w);
					float3 ifLocalVar40_g251568 = 0;
					if( TVE_DEBUG_Index == 6.0 )
					ifLocalVar40_g251568 = lerpResult2607;
					half3 Final_Debug2399 = ( ifLocalVar40_g251565 + ifLocalVar40_g251566 + ifLocalVar40_g251567 + ifLocalVar40_g251569 + ifLocalVar40_g251568 );
					float temp_output_7_0_g251594 = TVE_DEBUG_Min;
					float3 temp_cast_50 = (temp_output_7_0_g251594).xxx;
					float3 temp_output_9_0_g251594 = ( Final_Debug2399 - temp_cast_50 );
					float lerpResult76_g251586 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g251586 = lerpResult76_g251586;
					float3 lerpResult72_g251586 = lerp( (lerpResult73_g251587).rgb , saturate( ( temp_output_9_0_g251594 / ( ( TVE_DEBUG_Max - temp_output_7_0_g251594 ) + 0.0001 ) ) ) , Filter152_g251586);
					float dotResult61_g251586 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g251586 = ( 1.0 - saturate( dotResult61_g251586 ) );
					float Shading_Fresnel59_g251586 = (( 1.0 - ( temp_output_65_0_g251586 * temp_output_65_0_g251586 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g251586 = IN.ase_texcoord7;
					float depthLinearEye57_g251586 = LinearEyeDepth( ase_positionCS57_g251586.z / ase_positionCS57_g251586.w );
					float temp_output_69_0_g251586 = saturate(  (0.0 + ( depthLinearEye57_g251586 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g251586 = (( temp_output_69_0_g251586 * temp_output_69_0_g251586 )*0.5 + 0.5);
					float lerpResult84_g251586 = lerp( 1.0 , Shading_Fresnel59_g251586 , ( Shading_Distance58_g251586 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g251591 = ( 0.0 );
					TVEVisualData Data4_g251591 =(TVEVisualData)Data3_g251315;
					float Out_Dummy4_g251591 = 0.0;
					float3 Out_Albedo4_g251591 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251591 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251591 = float2( 0,0 );
					float3 Out_NormalWS4_g251591 = float3( 0,0,0 );
					float4 Out_Shader4_g251591 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251591 = float4( 0,0,0,0 );
					float4 Out_Season4_g251591 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251591 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251591 = 0.0;
					float Out_Grayscale4_g251591 = 0.0;
					float Out_Luminosity4_g251591 = 0.0;
					float Out_AlphaClip4_g251591 = 0.0;
					float Out_AlphaFade4_g251591 = 0.0;
					float3 Out_Translucency4_g251591 = float3( 0,0,0 );
					float Out_Transmission4_g251591 = 0.0;
					float Out_Thickness4_g251591 = 0.0;
					float Out_Diffusion4_g251591 = 0.0;
					float Out_Depth4_g251591 = 0.0;
					BreakVisualData( Data4_g251591 , Out_Dummy4_g251591 , Out_Albedo4_g251591 , Out_AlbedoBase4_g251591 , Out_NormalTS4_g251591 , Out_NormalWS4_g251591 , Out_Shader4_g251591 , Out_Feature4_g251591 , Out_Season4_g251591 , Out_Emissive4_g251591 , Out_MultiMask4_g251591 , Out_Grayscale4_g251591 , Out_Luminosity4_g251591 , Out_AlphaClip4_g251591 , Out_AlphaFade4_g251591 , Out_Translucency4_g251591 , Out_Transmission4_g251591 , Out_Thickness4_g251591 , Out_Diffusion4_g251591 , Out_Depth4_g251591 );
					float Alpha109_g251586 = Out_AlphaClip4_g251591;
					float lerpResult91_g251586 = lerp( 1.0 , Alpha109_g251586 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g251586 = lerp( 1.0 , lerpResult91_g251586 , Filter152_g251586);
					clip( lerpResult154_g251586 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2664_114;
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

					o.Emission = ( lerpResult72_g251586 * lerpResult84_g251586 );
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
				#define ASE_ABSOLUTE_VERTEX_POS 1
				#pragma multi_compile_instancing
				#define _SPECULAR_SETUP 1
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

				#define ASE_NEEDS_VERT_POSITION
				#define ASE_NEEDS_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_VERT_TANGENT
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES2
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_CONFORM
				#if defined (TVE_CLIPPING) //Render Clip
					#define TVE_ALPHA_CLIP //Render Clip
				#endif //Render Clip
				  
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
				#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
				#endif//ASE Sampling Macros
				


				int _ObjectId;
				int _PassValue;

				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_texcoord : TEXCOORD0;
					float4 ase_texcoord2 : TEXCOORD2;
					float4 ase_color : COLOR;
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

				uniform half _IsTVEShader;
				uniform half TVE_DEBUG_Filter;
				uniform half TVE_DEBUG_Clip;
				uniform half TVE_DEBUG_Min;
				uniform half TVE_DEBUG_Max;
				uniform half TVE_DEBUG_Index;
				uniform half TVE_DEBUG_Shading;
				uniform half _ObjectCategory;
				uniform half _ObjectEnd;
				uniform half _ObjectModelMode;
				uniform half _ObjectPivotMode;
				uniform float3 TVE_WorldOrigin;
				uniform half _ObjectHeightValue;
				uniform half _ObjectRadiusValue;
				uniform half _ObjectPhaseMode;
				uniform float _IsShaderType;
				uniform half _ConformCategory;
				uniform half _ConformEnd;
				uniform half _ConformInfo;
				uniform half _GlobalCategory;
				uniform half _GlobalEnd;
				uniform half4 TVE_CoatParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatBaseTex);
				uniform float4 TVE_CoatBaseCoord;
				uniform half _GlobalCoatPivotValue;
				uniform half _GlobalCoatLayerValue;
				SamplerState sampler_Linear_Clamp;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatNearTex);
				uniform float4 TVE_CoatNearCoord;
				SamplerState sampler_Linear_Repeat;
				uniform float4 TVE_RenderNearPositionR;
				uniform half TVE_RenderNearFadeValue;
				uniform float TVE_CoatLayers[10];
				uniform half4 TVE_PaintParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintBaseTex);
				uniform float4 TVE_PaintBaseCoord;
				uniform half _GlobalPaintPivotValue;
				uniform half _GlobalPaintLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintNearTex);
				uniform float4 TVE_PaintNearCoord;
				uniform float TVE_PaintLayers[10];
				uniform half4 TVE_AtmoParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoBaseTex);
				uniform float4 TVE_AtmoBaseCoord;
				uniform half _GlobalAtmoPivotValue;
				uniform half _GlobalAtmoLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoNearTex);
				uniform float4 TVE_AtmoNearCoord;
				uniform float TVE_AtmoLayers[10];
				uniform half4 TVE_GlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowBaseTex);
				uniform float4 TVE_GlowBaseCoord;
				uniform half _GlobalGlowPivotValue;
				uniform half _GlobalGlowLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowNearTex);
				uniform float4 TVE_GlowNearCoord;
				uniform float TVE_GlowLayers[10];
				uniform half4 TVE_FormParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormBaseTex);
				uniform float4 TVE_FormBaseCoord;
				uniform half _GlobalFormPivotValue;
				uniform half _GlobalFormLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormNearTex);
				uniform float4 TVE_FormNearCoord;
				uniform float TVE_FormLayers[10];
				uniform half4 TVE_FlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowBaseTex);
				uniform float4 TVE_FlowBaseCoord;
				uniform half _GlobalFlowPivotValue;
				uniform half _GlobalFlowLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowNearTex);
				uniform float4 TVE_FlowNearCoord;
				uniform float TVE_FlowLayers[10];
				uniform half _ConformMode;
				uniform half _ConformOffsetValue;
				uniform half _ConformIntensityValue;
				uniform half _ConformMeshMode;
				uniform half4 _ConformMeshRemap;
				uniform half _ConformMeshValue;
				uniform half TVE_IsEnabled;


				half CapsuleMaskYUp( half3 Position, half Height, half Radius )
				{
					    float3 a = float3(0, Height, 0);
					    float3 ba = -a;
					    float3 pa = Position - a;
					    
					    float baDot = dot(ba, ba);
					    float h = saturate(dot(pa, ba) / baDot);
					    
					    float3 q = pa - ba * h;
					    return length(q) / Radius;
				}
				
				half CapsuleMaskZUp( half3 Position, half Height, half Radius )
				{
					    float3 a = float3(0, 0, Height);
					    float3 ba = -a;
					    float3 pa = Position - a;
					    
					    float baDot = dot(ba, ba);
					    float h = saturate(dot(pa, ba) / baDot);
					    
					    float3 q = pa - ba * h;
					    return length(q) / Radius;
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
				
				void BuildModelVertData( inout TVEModelData Data, half In_Dummy, float3 In_PositionOS, float3 In_PositionWS, float3 In_PositionWO, float3 In_PositionRawOS, float3 In_PivotOS, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalOS, half3 In_NormalWS, half3 In_NormalRawOS, half4 In_TangentOS, half3 In_TangentWS, half3 In_BitangentWS, half3 In_ViewDirWS, float4 In_CoordsData, float4 In_VertexData, half4 In_MasksData, half4 In_PhaseData, half4 In_TransformData, half4 In_RotationData, float4 In_InterpolatorA )
				{
					Data.Dummy = In_Dummy;
					Data.PositionOS = In_PositionOS;
					Data.PositionWS = In_PositionWS;
					Data.PositionWO = In_PositionWO;
					Data.PositionRawOS = In_PositionRawOS;
					Data.PivotOS = In_PivotOS;
					Data.PivotWS = In_PivotWS;
					Data.PivotWO = In_PivotWO;
					Data.NormalOS = In_NormalOS;
					Data.NormalWS = In_NormalWS;
					Data.NormalRawOS = In_NormalRawOS;
					Data.TangentOS = In_TangentOS;
					Data.TangentWS = In_TangentWS;
					Data.BitangentWS = In_BitangentWS;
					Data.ViewDirWS = In_ViewDirWS;
					Data.CoordsData = In_CoordsData;
					Data.VertexData = In_VertexData;
					Data.MasksData = In_MasksData;
					Data.PhaseData = In_PhaseData;
					Data.TransformData = In_TransformData;
					Data.RotationData = In_RotationData;
					Data.InterpolatorA = In_InterpolatorA ;
					return;
				}
				
				void BreakModelVertData( inout TVEModelData Data, out half Out_Dummy, out half3 Out_PositionOS, out half3 Out_PositionWS, out half3 Out_PositionWO, out half3 Out_PositionRawOS, out half3 Out_PivotOS, out half3 Out_PivotWS, out half3 Out_PivotWO, out half3 Out_NormalOS, out half3 Out_NormalWS, out half3 Out_NormalRawOS, out half4 Out_TangentOS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_MasksData, out half4 Out_PhaseData, out half4 Out_TransformData, out half4 Out_RotationData, out half4 Out_InterpolatorA )
				{
					Out_Dummy = Data.Dummy;
					Out_PositionOS = Data.PositionOS;
					Out_PositionWS = Data.PositionWS;
					Out_PositionWO = Data.PositionWO;
					Out_PositionRawOS = Data.PositionRawOS;
					Out_PivotOS = Data.PivotOS;
					Out_PivotWS = Data.PivotWS;
					Out_PivotWO = Data.PivotWO;
					Out_NormalOS = Data.NormalOS;
					Out_NormalWS = Data.NormalWS;
					Out_NormalRawOS = Data.NormalRawOS;
					Out_TangentOS = Data.TangentOS;
					Out_TangentWS = Data.TangentWS;
					Out_BitangentWS = Data.BitangentWS;
					Out_ViewDirWS = Data.ViewDirWS;
					Out_CoordsData = Data.CoordsData;
					Out_VertexData = Data.VertexData;
					Out_MasksData = Data.MasksData;
					Out_PhaseData = Data.PhaseData;
					Out_TransformData = Data.TransformData;
					Out_RotationData = Data.RotationData;
					Out_InterpolatorA = Data.InterpolatorA;
					return;
				}
				
				half3 ComputeTriplanarWeights( half3 NormalWS )
				{
					half3 powNormal = abs( NormalWS );
					half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
					tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
					return tempWeights;
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
				
				void BuildGlobalData( out TVEGlobalData Data, half In_Dummy, half4 In_CoatParams, half4 In_CoatTexture, half4 In_PaintParams, half4 In_PaintTexture, half4 In_AtmoParams, half4 In_AtmoTexture, half4 In_GlowParams, half4 In_GlowTexture, float4 In_FormParams, float4 In_FormTexture, half4 In_FlowParams, float4 In_FlowTexture )
				{
					Data = (TVEGlobalData)0;
					Data.Dummy = In_Dummy;
					Data.CoatParams= In_CoatParams;
					Data.CoatTexture = In_CoatTexture;
					Data.PaintParams = In_PaintParams;
					Data.PaintTexture = In_PaintTexture;
					Data.AtmoParams= In_AtmoParams;
					Data.AtmoTexture= In_AtmoTexture;
					Data.GlowParams= In_GlowParams;
					Data.GlowTexture= In_GlowTexture;
					Data.FormParams= In_FormParams;
					Data.FormTexture= In_FormTexture;
					Data.FlowParams= In_FlowParams;
					Data.FlowTexture= In_FlowTexture;
					return;
				}
				
				void BreakData( inout TVEGlobalData Data, out half Out_Dummy, out half4 Out_CoatParams, out half4 Out_CoatTexture, out half4 Out_PaintParams, out half4 Out_PaintTexture, out half4 Out_AtmoParams, out half4 Out_AtmoTexture, out half4 Out_GlowParams, out half4 Out_GlowTexture, out float4 Out_FormParams, out float4 Out_FormTexture, out half4 Out_FlowParams, out half4 Out_FlowTexture )
				{
					Out_Dummy = Data.Dummy;
					Out_CoatParams = Data.CoatParams;
					Out_CoatTexture = Data.CoatTexture;
					Out_PaintParams = Data.PaintParams;
					Out_PaintTexture = Data.PaintTexture;
					Out_AtmoParams= Data.AtmoParams;
					Out_AtmoTexture= Data.AtmoTexture;
					Out_GlowParams= Data.GlowParams;
					Out_GlowTexture= Data.GlowTexture;
					Out_FormParams= Data.FormParams;
					Out_FormTexture = Data.FormTexture;
					Out_FlowParams = Data.FlowParams;
					Out_FlowTexture = Data.FlowTexture;
					return;
				}
				

				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float localIfModelDataByShader26_g251540 = ( 0.0 );
					TVEModelData Data26_g251540 = (TVEModelData)0;
					TVEModelData Data16_g241385 =(TVEModelData)0;
					half Dummy207_g241375 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g241385 = Dummy207_g241375;
					float In_Dummy16_g241385 = temp_output_14_0_g241385;
					float3 PositionOS131_g241375 = v.vertex.xyz;
					float3 temp_output_4_0_g241385 = PositionOS131_g241375;
					float3 In_PositionOS16_g241385 = temp_output_4_0_g241385;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g241375 = ase_positionWS;
					float3 vertexToFrag73_g241375 = temp_output_104_7_g241375;
					float3 PositionWS122_g241375 = vertexToFrag73_g241375;
					float3 In_PositionWS16_g241385 = PositionWS122_g241375;
					float4x4 break19_g241378 = unity_ObjectToWorld;
					float3 appendResult20_g241378 = (float3(break19_g241378[ 0 ][ 3 ] , break19_g241378[ 1 ][ 3 ] , break19_g241378[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241375 = appendResult20_g241378;
					float4x4 break19_g241380 = unity_ObjectToWorld;
					float3 appendResult20_g241380 = (float3(break19_g241380[ 0 ][ 3 ] , break19_g241380[ 1 ][ 3 ] , break19_g241380[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g241376 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g241375 = PositionOS131_g241375;
					float3 appendResult234_g241375 = (float3(break233_g241375.x , 0.0 , break233_g241375.z));
					float3 break413_g241375 = PositionOS131_g241375;
					float3 appendResult414_g241375 = (float3(break413_g241375.x , break413_g241375.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g241382 = appendResult414_g241375;
					#else
					float3 staticSwitch65_g241382 = appendResult234_g241375;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g241375 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g241375 = appendResult60_g241376;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g241375 = staticSwitch65_g241382;
					#else
					float3 staticSwitch229_g241375 = _Vector0;
					#endif
					float3 PivotOS149_g241375 = staticSwitch229_g241375;
					float3 temp_output_122_0_g241380 = PivotOS149_g241375;
					float3 PivotsOnlyWS105_g241380 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g241380 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g241375 = ( appendResult20_g241380 + PivotsOnlyWS105_g241380 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g241375 = temp_output_340_7_g241375;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g241375 = temp_output_341_7_g241375;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g241375 = temp_output_341_7_g241375;
					#else
					float3 staticSwitch236_g241375 = temp_output_340_7_g241375;
					#endif
					float3 vertexToFrag76_g241375 = staticSwitch236_g241375;
					float3 PivotWS121_g241375 = vertexToFrag76_g241375;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241375 = ( PositionWS122_g241375 - PivotWS121_g241375 );
					#else
					float3 staticSwitch204_g241375 = PositionWS122_g241375;
					#endif
					float3 PositionWO132_g241375 = ( staticSwitch204_g241375 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241385 = PositionWO132_g241375;
					float3 In_PositionRawOS16_g241385 = PositionOS131_g241375;
					float3 In_PivotOS16_g241385 = PivotOS149_g241375;
					float3 In_PivotWS16_g241385 = PivotWS121_g241375;
					float3 PivotWO133_g241375 = ( PivotWS121_g241375 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241385 = PivotWO133_g241375;
					half3 NormalOS134_g241375 = v.normal;
					float3 temp_output_21_0_g241385 = NormalOS134_g241375;
					float3 In_NormalOS16_g241385 = temp_output_21_0_g241385;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g241375 = normalizedWorldNormal;
					float3 In_NormalWS16_g241385 = NormalWS95_g241375;
					float3 In_NormalRawOS16_g241385 = NormalOS134_g241375;
					half4 TangentlOS153_g241375 = v.tangent;
					float4 temp_output_6_0_g241385 = TangentlOS153_g241375;
					float4 In_TangentOS16_g241385 = temp_output_6_0_g241385;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g241375 = ase_tangentWS;
					float3 In_TangentWS16_g241385 = TangentWS136_g241375;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g241375 = ase_bitangentWS;
					float3 In_BitangentWS16_g241385 = BiangentWS421_g241375;
					float3 normalizeResult296_g241375 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241375 ) );
					half3 ViewDirWS169_g241375 = normalizeResult296_g241375;
					float3 In_ViewDirWS16_g241385 = ViewDirWS169_g241375;
					float4 appendResult397_g241375 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g241375 = appendResult397_g241375;
					float4 In_CoordsData16_g241385 = CoordsData398_g241375;
					half4 VertexMasks171_g241375 = v.ase_color;
					float4 In_VertexData16_g241385 = VertexMasks171_g241375;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241388 = (PositionOS131_g241375).z;
					#else
					float staticSwitch65_g241388 = (PositionOS131_g241375).y;
					#endif
					half Object_HeightValue267_g241375 = _ObjectHeightValue;
					half Bounds_HeightMask274_g241375 = saturate( ( staticSwitch65_g241388 / Object_HeightValue267_g241375 ) );
					half3 Position387_g241375 = PositionOS131_g241375;
					half Height387_g241375 = Object_HeightValue267_g241375;
					half Object_RadiusValue268_g241375 = _ObjectRadiusValue;
					half Radius387_g241375 = Object_RadiusValue268_g241375;
					half localCapsuleMaskYUp387_g241375 = CapsuleMaskYUp( Position387_g241375 , Height387_g241375 , Radius387_g241375 );
					half3 Position408_g241375 = PositionOS131_g241375;
					half Height408_g241375 = Object_HeightValue267_g241375;
					half Radius408_g241375 = Object_RadiusValue268_g241375;
					half localCapsuleMaskZUp408_g241375 = CapsuleMaskZUp( Position408_g241375 , Height408_g241375 , Radius408_g241375 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241393 = saturate( localCapsuleMaskZUp408_g241375 );
					#else
					float staticSwitch65_g241393 = saturate( localCapsuleMaskYUp387_g241375 );
					#endif
					half Bounds_SphereMask282_g241375 = staticSwitch65_g241393;
					float4 appendResult253_g241375 = (float4(Bounds_HeightMask274_g241375 , Bounds_SphereMask282_g241375 , 1.0 , 1.0));
					half4 MasksData254_g241375 = appendResult253_g241375;
					float4 In_MasksData16_g241385 = MasksData254_g241375;
					float temp_output_17_0_g241387 = _ObjectPhaseMode;
					float Option70_g241387 = temp_output_17_0_g241387;
					float4 temp_output_3_0_g241387 = v.ase_color;
					float4 Channel70_g241387 = temp_output_3_0_g241387;
					float localSwitchChannel470_g241387 = SwitchChannel4( Option70_g241387 , Channel70_g241387 );
					half Phase_Value372_g241375 = localSwitchChannel470_g241387;
					float3 break319_g241375 = PivotWO133_g241375;
					half Pivot_Position322_g241375 = ( break319_g241375.x + break319_g241375.z );
					half Phase_Position357_g241375 = ( Phase_Value372_g241375 + Pivot_Position322_g241375 );
					float temp_output_248_0_g241375 = frac( Phase_Position357_g241375 );
					float4 appendResult177_g241375 = (float4(( (frac( ( Phase_Position357_g241375 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g241375));
					half4 Phase_Data176_g241375 = appendResult177_g241375;
					float4 In_PhaseData16_g241385 = Phase_Data176_g241375;
					float4 In_TransformData16_g241385 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g241385 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g241385 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g241385 , In_Dummy16_g241385 , In_PositionOS16_g241385 , In_PositionWS16_g241385 , In_PositionWO16_g241385 , In_PositionRawOS16_g241385 , In_PivotOS16_g241385 , In_PivotWS16_g241385 , In_PivotWO16_g241385 , In_NormalOS16_g241385 , In_NormalWS16_g241385 , In_NormalRawOS16_g241385 , In_TangentOS16_g241385 , In_TangentWS16_g241385 , In_BitangentWS16_g241385 , In_ViewDirWS16_g241385 , In_CoordsData16_g241385 , In_VertexData16_g241385 , In_MasksData16_g241385 , In_PhaseData16_g241385 , In_TransformData16_g241385 , In_RotationData16_g241385 , In_InterpolatorA16_g241385 );
					TVEModelData DataDefault26_g251540 = Data16_g241385;
					TVEModelData DataGeneral26_g251540 = Data16_g241385;
					TVEModelData DataBlanket26_g251540 = Data16_g241385;
					TVEModelData DataImpostor26_g251540 = Data16_g241385;
					TVEModelData Data16_g241365 =(TVEModelData)0;
					half Dummy207_g241355 = 0.0;
					float temp_output_14_0_g241365 = Dummy207_g241355;
					float In_Dummy16_g241365 = temp_output_14_0_g241365;
					float3 PositionOS131_g241355 = v.vertex.xyz;
					float3 temp_output_4_0_g241365 = PositionOS131_g241355;
					float3 In_PositionOS16_g241365 = temp_output_4_0_g241365;
					float3 temp_output_104_7_g241355 = ase_positionWS;
					float3 PositionWS122_g241355 = temp_output_104_7_g241355;
					float3 In_PositionWS16_g241365 = PositionWS122_g241355;
					float4x4 break19_g241358 = unity_ObjectToWorld;
					float3 appendResult20_g241358 = (float3(break19_g241358[ 0 ][ 3 ] , break19_g241358[ 1 ][ 3 ] , break19_g241358[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241355 = appendResult20_g241358;
					float3 PivotWS121_g241355 = temp_output_340_7_g241355;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241355 = ( PositionWS122_g241355 - PivotWS121_g241355 );
					#else
					float3 staticSwitch204_g241355 = PositionWS122_g241355;
					#endif
					float3 PositionWO132_g241355 = ( staticSwitch204_g241355 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241365 = PositionWO132_g241355;
					float3 In_PositionRawOS16_g241365 = PositionOS131_g241355;
					float3 PivotOS149_g241355 = _Vector0;
					float3 In_PivotOS16_g241365 = PivotOS149_g241355;
					float3 In_PivotWS16_g241365 = PivotWS121_g241355;
					float3 PivotWO133_g241355 = ( PivotWS121_g241355 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241365 = PivotWO133_g241355;
					half3 NormalOS134_g241355 = v.normal;
					float3 temp_output_21_0_g241365 = NormalOS134_g241355;
					float3 In_NormalOS16_g241365 = temp_output_21_0_g241365;
					half3 NormalWS95_g241355 = normalizedWorldNormal;
					float3 In_NormalWS16_g241365 = NormalWS95_g241355;
					float3 In_NormalRawOS16_g241365 = NormalOS134_g241355;
					half4 TangentlOS153_g241355 = v.tangent;
					float4 temp_output_6_0_g241365 = TangentlOS153_g241355;
					float4 In_TangentOS16_g241365 = temp_output_6_0_g241365;
					half3 TangentWS136_g241355 = ase_tangentWS;
					float3 In_TangentWS16_g241365 = TangentWS136_g241355;
					half3 BiangentWS421_g241355 = ase_bitangentWS;
					float3 In_BitangentWS16_g241365 = BiangentWS421_g241355;
					float3 normalizeResult296_g241355 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241355 ) );
					half3 ViewDirWS169_g241355 = normalizeResult296_g241355;
					float3 In_ViewDirWS16_g241365 = ViewDirWS169_g241355;
					float4 appendResult397_g241355 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g241355 = appendResult397_g241355;
					float4 In_CoordsData16_g241365 = CoordsData398_g241355;
					half4 VertexMasks171_g241355 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241365 = VertexMasks171_g241355;
					half4 MasksData254_g241355 = float4( 0,0,0,0 );
					float4 In_MasksData16_g241365 = MasksData254_g241355;
					half4 Phase_Data176_g241355 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241365 = Phase_Data176_g241355;
					float4 In_TransformData16_g241365 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g241365 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g241365 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g241365 , In_Dummy16_g241365 , In_PositionOS16_g241365 , In_PositionWS16_g241365 , In_PositionWO16_g241365 , In_PositionRawOS16_g241365 , In_PivotOS16_g241365 , In_PivotWS16_g241365 , In_PivotWO16_g241365 , In_NormalOS16_g241365 , In_NormalWS16_g241365 , In_NormalRawOS16_g241365 , In_TangentOS16_g241365 , In_TangentWS16_g241365 , In_BitangentWS16_g241365 , In_ViewDirWS16_g241365 , In_CoordsData16_g241365 , In_VertexData16_g241365 , In_MasksData16_g241365 , In_PhaseData16_g241365 , In_TransformData16_g241365 , In_RotationData16_g241365 , In_InterpolatorA16_g241365 );
					TVEModelData DataTerrain26_g251540 = Data16_g241365;
					half IsShaderType2672 = _IsShaderType;
					float Type26_g251540 = IsShaderType2672;
					{
					if (Type26_g251540 == 0 )
					{
					Data26_g251540 = DataDefault26_g251540;
					}
					else if (Type26_g251540 == 1 )
					{
					Data26_g251540 = DataGeneral26_g251540;
					}
					else if (Type26_g251540 == 2 )
					{
					Data26_g251540 = DataBlanket26_g251540;
					}
					else if (Type26_g251540 == 3 )
					{
					Data26_g251540 = DataImpostor26_g251540;
					}
					else if (Type26_g251540 == 4 )
					{
					Data26_g251540 = DataTerrain26_g251540;
					}
					}
					TVEModelData Data15_g251552 =(TVEModelData)Data26_g251540;
					float Out_Dummy15_g251552 = 0.0;
					float3 Out_PositionOS15_g251552 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251552 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251552 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251552 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251552 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251552 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251552 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251552 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251552 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251552 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251552 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251552 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251552 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251552 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251552 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251552 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251552 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251552 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251552 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251552 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251552 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251552 , Out_Dummy15_g251552 , Out_PositionOS15_g251552 , Out_PositionWS15_g251552 , Out_PositionWO15_g251552 , Out_PositionRawOS15_g251552 , Out_PivotOS15_g251552 , Out_PivotWS15_g251552 , Out_PivotWO15_g251552 , Out_NormalOS15_g251552 , Out_NormalWS15_g251552 , Out_NormalRawOS15_g251552 , Out_TangentOS15_g251552 , Out_TangentWS15_g251552 , Out_BitangentWS15_g251552 , Out_ViewDirWS15_g251552 , Out_CoordsData15_g251552 , Out_VertexData15_g251552 , Out_MasksData15_g251552 , Out_PhaseData15_g251552 , Out_TransformData15_g251552 , Out_RotationData15_g251552 , Out_InterpolatorA15_g251552 );
					TVEModelData Data16_g251554 =(TVEModelData)Data15_g251552;
					float temp_output_14_0_g251554 = 0.0;
					float In_Dummy16_g251554 = temp_output_14_0_g251554;
					float3 temp_output_219_24_g251551 = Out_PivotOS15_g251552;
					float3 temp_output_215_0_g251551 = ( Out_PositionOS15_g251552 - temp_output_219_24_g251551 );
					float3 temp_output_4_0_g251554 = temp_output_215_0_g251551;
					float3 In_PositionOS16_g251554 = temp_output_4_0_g251554;
					float3 In_PositionWS16_g251554 = Out_PositionWS15_g251552;
					float3 In_PositionWO16_g251554 = Out_PositionWO15_g251552;
					float3 In_PositionRawOS16_g251554 = Out_PositionRawOS15_g251552;
					float3 In_PivotOS16_g251554 = temp_output_219_24_g251551;
					float3 In_PivotWS16_g251554 = Out_PivotWS15_g251552;
					float3 In_PivotWO16_g251554 = Out_PivotWO15_g251552;
					float3 temp_output_21_0_g251554 = Out_NormalOS15_g251552;
					float3 In_NormalOS16_g251554 = temp_output_21_0_g251554;
					float3 In_NormalWS16_g251554 = Out_NormalWS15_g251552;
					float3 In_NormalRawOS16_g251554 = Out_NormalRawOS15_g251552;
					float4 temp_output_6_0_g251554 = Out_TangentOS15_g251552;
					float4 In_TangentOS16_g251554 = temp_output_6_0_g251554;
					float3 In_TangentWS16_g251554 = Out_TangentWS15_g251552;
					float3 In_BitangentWS16_g251554 = Out_BitangentWS15_g251552;
					float3 In_ViewDirWS16_g251554 = Out_ViewDirWS15_g251552;
					float4 In_CoordsData16_g251554 = Out_CoordsData15_g251552;
					float4 In_VertexData16_g251554 = Out_VertexData15_g251552;
					float4 In_MasksData16_g251554 = Out_MasksData15_g251552;
					float4 In_PhaseData16_g251554 = Out_PhaseData15_g251552;
					float4 In_TransformData16_g251554 = Out_TransformData15_g251552;
					float4 In_RotationData16_g251554 = Out_RotationData15_g251552;
					float4 In_InterpolatorA16_g251554 = Out_InterpolatorA15_g251552;
					BuildModelVertData( Data16_g251554 , In_Dummy16_g251554 , In_PositionOS16_g251554 , In_PositionWS16_g251554 , In_PositionWO16_g251554 , In_PositionRawOS16_g251554 , In_PivotOS16_g251554 , In_PivotWS16_g251554 , In_PivotWO16_g251554 , In_NormalOS16_g251554 , In_NormalWS16_g251554 , In_NormalRawOS16_g251554 , In_TangentOS16_g251554 , In_TangentWS16_g251554 , In_BitangentWS16_g251554 , In_ViewDirWS16_g251554 , In_CoordsData16_g251554 , In_VertexData16_g251554 , In_MasksData16_g251554 , In_PhaseData16_g251554 , In_TransformData16_g251554 , In_RotationData16_g251554 , In_InterpolatorA16_g251554 );
					TVEModelData Data15_g251556 =(TVEModelData)Data16_g251554;
					float Out_Dummy15_g251556 = 0.0;
					float3 Out_PositionOS15_g251556 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251556 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251556 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251556 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251556 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251556 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251556 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251556 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251556 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251556 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251556 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251556 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251556 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251556 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251556 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251556 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251556 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251556 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251556 , Out_Dummy15_g251556 , Out_PositionOS15_g251556 , Out_PositionWS15_g251556 , Out_PositionWO15_g251556 , Out_PositionRawOS15_g251556 , Out_PivotOS15_g251556 , Out_PivotWS15_g251556 , Out_PivotWO15_g251556 , Out_NormalOS15_g251556 , Out_NormalWS15_g251556 , Out_NormalRawOS15_g251556 , Out_TangentOS15_g251556 , Out_TangentWS15_g251556 , Out_BitangentWS15_g251556 , Out_ViewDirWS15_g251556 , Out_CoordsData15_g251556 , Out_VertexData15_g251556 , Out_MasksData15_g251556 , Out_PhaseData15_g251556 , Out_TransformData15_g251556 , Out_RotationData15_g251556 , Out_InterpolatorA15_g251556 );
					TVEModelData Data16_g251557 =(TVEModelData)Data15_g251556;
					half Dummy317_g251555 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g251557 = Dummy317_g251555;
					float In_Dummy16_g251557 = temp_output_14_0_g251557;
					float3 temp_output_4_0_g251557 = Out_PositionOS15_g251556;
					float3 In_PositionOS16_g251557 = temp_output_4_0_g251557;
					float3 In_PositionWS16_g251557 = Out_PositionWS15_g251556;
					float3 temp_output_314_17_g251555 = Out_PositionWO15_g251556;
					float3 In_PositionWO16_g251557 = temp_output_314_17_g251555;
					float3 In_PositionRawOS16_g251557 = Out_PositionRawOS15_g251556;
					float3 In_PivotOS16_g251557 = Out_PivotOS15_g251556;
					float3 In_PivotWS16_g251557 = Out_PivotWS15_g251556;
					float3 temp_output_314_19_g251555 = Out_PivotWO15_g251556;
					float3 In_PivotWO16_g251557 = temp_output_314_19_g251555;
					float3 temp_output_21_0_g251557 = Out_NormalOS15_g251556;
					float3 In_NormalOS16_g251557 = temp_output_21_0_g251557;
					float3 In_NormalWS16_g251557 = Out_NormalWS15_g251556;
					float3 In_NormalRawOS16_g251557 = Out_NormalRawOS15_g251556;
					float4 temp_output_6_0_g251557 = Out_TangentOS15_g251556;
					float4 In_TangentOS16_g251557 = temp_output_6_0_g251557;
					float3 In_TangentWS16_g251557 = Out_TangentWS15_g251556;
					float3 In_BitangentWS16_g251557 = Out_BitangentWS15_g251556;
					float3 In_ViewDirWS16_g251557 = Out_ViewDirWS15_g251556;
					float4 In_CoordsData16_g251557 = Out_CoordsData15_g251556;
					float4 temp_output_314_29_g251555 = Out_VertexData15_g251556;
					float4 In_VertexData16_g251557 = temp_output_314_29_g251555;
					float4 In_MasksData16_g251557 = Out_MasksData15_g251556;
					float4 In_PhaseData16_g251557 = Out_PhaseData15_g251556;
					half4 Model_TransformData356_g251555 = Out_TransformData15_g251556;
					float localBuildGlobalData204_g251357 = ( 0.0 );
					TVEGlobalData Data204_g251357 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251357 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251357 = Dummy211_g251357;
					float4 temp_output_589_164_g251357 = TVE_CoatParams;
					half4 Coat_Params596_g251357 = temp_output_589_164_g251357;
					float4 In_CoatParams204_g251357 = Coat_Params596_g251357;
					float4 temp_output_203_0_g251377 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g241395 = ( 0.0 );
					TVEModelData Data26_g241395 = (TVEModelData)0;
					TVEModelData Data16_g241383 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241383 = 0.0;
					float3 In_PositionWS16_g241383 = PositionWS122_g241375;
					float3 In_PositionWO16_g241383 = PositionWO132_g241375;
					float3 In_PivotWS16_g241383 = PivotWS121_g241375;
					float3 In_PivotWO16_g241383 = PivotWO133_g241375;
					float3 In_NormalWS16_g241383 = NormalWS95_g241375;
					float3 In_TangentWS16_g241383 = TangentWS136_g241375;
					float3 In_BitangentWS16_g241383 = BiangentWS421_g241375;
					half3 NormalWS427_g241375 = NormalWS95_g241375;
					half3 localComputeTriplanarWeights427_g241375 = ComputeTriplanarWeights( NormalWS427_g241375 );
					half3 TriplanarWeights429_g241375 = localComputeTriplanarWeights427_g241375;
					float3 In_TriplanarWeights16_g241383 = TriplanarWeights429_g241375;
					float3 In_ViewDirWS16_g241383 = ViewDirWS169_g241375;
					float4 In_CoordsData16_g241383 = CoordsData398_g241375;
					float4 In_VertexData16_g241383 = VertexMasks171_g241375;
					float4 In_PhaseData16_g241383 = Phase_Data176_g241375;
					BuildModelFragData( Data16_g241383 , In_Dummy16_g241383 , In_PositionWS16_g241383 , In_PositionWO16_g241383 , In_PivotWS16_g241383 , In_PivotWO16_g241383 , In_NormalWS16_g241383 , In_TangentWS16_g241383 , In_BitangentWS16_g241383 , In_TriplanarWeights16_g241383 , In_ViewDirWS16_g241383 , In_CoordsData16_g241383 , In_VertexData16_g241383 , In_PhaseData16_g241383 );
					TVEModelData DataDefault26_g241395 = Data16_g241383;
					TVEModelData DataGeneral26_g241395 = Data16_g241383;
					TVEModelData DataBlanket26_g241395 = Data16_g241383;
					TVEModelData DataImpostor26_g241395 = Data16_g241383;
					TVEModelData Data16_g241363 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241363 = 0.0;
					float3 In_PositionWS16_g241363 = PositionWS122_g241355;
					float3 In_PositionWO16_g241363 = PositionWO132_g241355;
					float3 In_PivotWS16_g241363 = PivotWS121_g241355;
					float3 In_PivotWO16_g241363 = PivotWO133_g241355;
					float3 In_NormalWS16_g241363 = NormalWS95_g241355;
					float3 In_TangentWS16_g241363 = TangentWS136_g241355;
					float3 In_BitangentWS16_g241363 = BiangentWS421_g241355;
					half3 NormalWS427_g241355 = NormalWS95_g241355;
					half3 localComputeTriplanarWeights427_g241355 = ComputeTriplanarWeights( NormalWS427_g241355 );
					half3 TriplanarWeights429_g241355 = localComputeTriplanarWeights427_g241355;
					float3 In_TriplanarWeights16_g241363 = TriplanarWeights429_g241355;
					float3 In_ViewDirWS16_g241363 = ViewDirWS169_g241355;
					float4 In_CoordsData16_g241363 = CoordsData398_g241355;
					float4 In_VertexData16_g241363 = VertexMasks171_g241355;
					float4 In_PhaseData16_g241363 = Phase_Data176_g241355;
					BuildModelFragData( Data16_g241363 , In_Dummy16_g241363 , In_PositionWS16_g241363 , In_PositionWO16_g241363 , In_PivotWS16_g241363 , In_PivotWO16_g241363 , In_NormalWS16_g241363 , In_TangentWS16_g241363 , In_BitangentWS16_g241363 , In_TriplanarWeights16_g241363 , In_ViewDirWS16_g241363 , In_CoordsData16_g241363 , In_VertexData16_g241363 , In_PhaseData16_g241363 );
					TVEModelData DataTerrain26_g241395 = Data16_g241363;
					float Type26_g241395 = IsShaderType2672;
					{
					if (Type26_g241395 == 0 )
					{
					Data26_g241395 = DataDefault26_g241395;
					}
					else if (Type26_g241395 == 1 )
					{
					Data26_g241395 = DataGeneral26_g241395;
					}
					else if (Type26_g241395 == 2 )
					{
					Data26_g241395 = DataBlanket26_g241395;
					}
					else if (Type26_g241395 == 3 )
					{
					Data26_g241395 = DataImpostor26_g241395;
					}
					else if (Type26_g241395 == 4 )
					{
					Data26_g241395 = DataTerrain26_g241395;
					}
					}
					TVEModelData Data15_g251433 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g251433 = 0.0;
					float3 Out_PositionWS15_g251433 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251433 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251433 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251433 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251433 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251433 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251433 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251433 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251433 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251433 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251433 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251433 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251433 , Out_Dummy15_g251433 , Out_PositionWS15_g251433 , Out_PositionWO15_g251433 , Out_PivotWS15_g251433 , Out_PivotWO15_g251433 , Out_NormalWS15_g251433 , Out_TangentWS15_g251433 , Out_BitangentWS15_g251433 , Out_TriplanarWeights15_g251433 , Out_ViewDirWS15_g251433 , Out_CoordsData15_g251433 , Out_VertexData15_g251433 , Out_PhaseData15_g251433 );
					float3 Model_PositionWS497_g251357 = Out_PositionWS15_g251433;
					float2 Model_PositionWS_XZ143_g251357 = (Model_PositionWS497_g251357).xz;
					float3 Model_PivotWS498_g251357 = Out_PivotWS15_g251433;
					float2 Model_PivotWS_XZ145_g251357 = (Model_PivotWS498_g251357).xz;
					float2 lerpResult300_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251377 = lerpResult300_g251357;
					float temp_output_82_0_g251375 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251377 = temp_output_82_0_g251375;
					float4 tex2DArrayNode83_g251377 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251377).zw + ( (temp_output_203_0_g251377).xy * temp_output_81_0_g251377 ) ),temp_output_82_0_g251377), 0.0 );
					float4 appendResult210_g251377 = (float4(tex2DArrayNode83_g251377.rgb , saturate( tex2DArrayNode83_g251377.a )));
					float4 temp_output_204_0_g251377 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251377 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251377).zw + ( (temp_output_204_0_g251377).xy * temp_output_81_0_g251377 ) ),temp_output_82_0_g251377), 0.0 );
					float4 appendResult212_g251377 = (float4(tex2DArrayNode122_g251377.rgb , saturate( tex2DArrayNode122_g251377.a )));
					float4 TVE_RenderNearPositionR628_g251357 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251357 = saturate( ( distance( Model_PositionWS497_g251357 , (TVE_RenderNearPositionR628_g251357).xyz ) / (TVE_RenderNearPositionR628_g251357).w ) );
					float temp_output_7_0_g251358 = 1.0;
					float temp_output_9_0_g251358 = ( temp_output_507_0_g251357 - temp_output_7_0_g251358 );
					half TVE_RenderNearFadeValue635_g251357 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251357 = saturate( ( temp_output_9_0_g251358 / ( ( TVE_RenderNearFadeValue635_g251357 - temp_output_7_0_g251358 ) + 0.0001 ) ) );
					float4 lerpResult131_g251377 = lerp( appendResult210_g251377 , appendResult212_g251377 , Global_TexBlend509_g251357);
					float4 temp_output_159_109_g251375 = lerpResult131_g251377;
					float4 lerpResult168_g251375 = lerp( TVE_CoatParams , temp_output_159_109_g251375 , TVE_CoatLayers[(int)temp_output_82_0_g251375]);
					float4 temp_output_589_109_g251357 = lerpResult168_g251375;
					half4 Coat_Texture302_g251357 = temp_output_589_109_g251357;
					float4 In_CoatTexture204_g251357 = Coat_Texture302_g251357;
					float4 temp_output_595_164_g251357 = TVE_PaintParams;
					half4 Paint_Params575_g251357 = temp_output_595_164_g251357;
					float4 In_PaintParams204_g251357 = Paint_Params575_g251357;
					float4 temp_output_203_0_g251426 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251426 = lerpResult85_g251357;
					float temp_output_82_0_g251423 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251426 = temp_output_82_0_g251423;
					float4 tex2DArrayNode83_g251426 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251426).zw + ( (temp_output_203_0_g251426).xy * temp_output_81_0_g251426 ) ),temp_output_82_0_g251426), 0.0 );
					float4 appendResult210_g251426 = (float4(tex2DArrayNode83_g251426.rgb , saturate( tex2DArrayNode83_g251426.a )));
					float4 temp_output_204_0_g251426 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251426 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251426).zw + ( (temp_output_204_0_g251426).xy * temp_output_81_0_g251426 ) ),temp_output_82_0_g251426), 0.0 );
					float4 appendResult212_g251426 = (float4(tex2DArrayNode122_g251426.rgb , saturate( tex2DArrayNode122_g251426.a )));
					float4 lerpResult131_g251426 = lerp( appendResult210_g251426 , appendResult212_g251426 , Global_TexBlend509_g251357);
					float4 temp_output_171_109_g251423 = lerpResult131_g251426;
					float4 lerpResult174_g251423 = lerp( TVE_PaintParams , temp_output_171_109_g251423 , TVE_PaintLayers[(int)temp_output_82_0_g251423]);
					float4 temp_output_595_109_g251357 = lerpResult174_g251423;
					half4 Paint_Texture71_g251357 = temp_output_595_109_g251357;
					float4 In_PaintTexture204_g251357 = Paint_Texture71_g251357;
					float4 temp_output_590_141_g251357 = TVE_AtmoParams;
					half4 Atmo_Params601_g251357 = temp_output_590_141_g251357;
					float4 In_AtmoParams204_g251357 = Atmo_Params601_g251357;
					float4 temp_output_203_0_g251385 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251385 = lerpResult104_g251357;
					float temp_output_132_0_g251383 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251385 = temp_output_132_0_g251383;
					float4 tex2DArrayNode83_g251385 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251385).zw + ( (temp_output_203_0_g251385).xy * temp_output_81_0_g251385 ) ),temp_output_82_0_g251385), 0.0 );
					float4 appendResult210_g251385 = (float4(tex2DArrayNode83_g251385.rgb , saturate( tex2DArrayNode83_g251385.a )));
					float4 temp_output_204_0_g251385 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251385 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251385).zw + ( (temp_output_204_0_g251385).xy * temp_output_81_0_g251385 ) ),temp_output_82_0_g251385), 0.0 );
					float4 appendResult212_g251385 = (float4(tex2DArrayNode122_g251385.rgb , saturate( tex2DArrayNode122_g251385.a )));
					float4 lerpResult131_g251385 = lerp( appendResult210_g251385 , appendResult212_g251385 , Global_TexBlend509_g251357);
					float4 temp_output_137_109_g251383 = lerpResult131_g251385;
					float4 lerpResult145_g251383 = lerp( TVE_AtmoParams , temp_output_137_109_g251383 , TVE_AtmoLayers[(int)temp_output_132_0_g251383]);
					float4 temp_output_590_110_g251357 = lerpResult145_g251383;
					half4 Atmo_Texture80_g251357 = temp_output_590_110_g251357;
					float4 In_AtmoTexture204_g251357 = Atmo_Texture80_g251357;
					float4 temp_output_593_163_g251357 = TVE_GlowParams;
					half4 Glow_Params609_g251357 = temp_output_593_163_g251357;
					float4 In_GlowParams204_g251357 = Glow_Params609_g251357;
					float4 temp_output_203_0_g251401 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251401 = lerpResult247_g251357;
					float temp_output_82_0_g251399 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251401 = temp_output_82_0_g251399;
					float4 tex2DArrayNode83_g251401 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251401).zw + ( (temp_output_203_0_g251401).xy * temp_output_81_0_g251401 ) ),temp_output_82_0_g251401), 0.0 );
					float4 appendResult210_g251401 = (float4(tex2DArrayNode83_g251401.rgb , saturate( tex2DArrayNode83_g251401.a )));
					float4 temp_output_204_0_g251401 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251401 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251401).zw + ( (temp_output_204_0_g251401).xy * temp_output_81_0_g251401 ) ),temp_output_82_0_g251401), 0.0 );
					float4 appendResult212_g251401 = (float4(tex2DArrayNode122_g251401.rgb , saturate( tex2DArrayNode122_g251401.a )));
					float4 lerpResult131_g251401 = lerp( appendResult210_g251401 , appendResult212_g251401 , Global_TexBlend509_g251357);
					float4 temp_output_159_109_g251399 = lerpResult131_g251401;
					float4 lerpResult167_g251399 = lerp( TVE_GlowParams , temp_output_159_109_g251399 , TVE_GlowLayers[(int)temp_output_82_0_g251399]);
					float4 temp_output_593_109_g251357 = lerpResult167_g251399;
					half4 Glow_Texture248_g251357 = temp_output_593_109_g251357;
					float4 In_GlowTexture204_g251357 = Glow_Texture248_g251357;
					float4 temp_output_592_139_g251357 = TVE_FormParams;
					float4 Form_Params606_g251357 = temp_output_592_139_g251357;
					float4 In_FormParams204_g251357 = Form_Params606_g251357;
					float4 temp_output_203_0_g251417 = TVE_FormBaseCoord;
					float2 lerpResult168_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251417 = lerpResult168_g251357;
					float temp_output_130_0_g251415 = _GlobalFormLayerValue;
					float temp_output_82_0_g251417 = temp_output_130_0_g251415;
					float4 tex2DArrayNode83_g251417 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251417).zw + ( (temp_output_203_0_g251417).xy * temp_output_81_0_g251417 ) ),temp_output_82_0_g251417), 0.0 );
					float4 appendResult210_g251417 = (float4(tex2DArrayNode83_g251417.rgb , saturate( tex2DArrayNode83_g251417.a )));
					float4 temp_output_204_0_g251417 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251417 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251417).zw + ( (temp_output_204_0_g251417).xy * temp_output_81_0_g251417 ) ),temp_output_82_0_g251417), 0.0 );
					float4 appendResult212_g251417 = (float4(tex2DArrayNode122_g251417.rgb , saturate( tex2DArrayNode122_g251417.a )));
					float4 lerpResult131_g251417 = lerp( appendResult210_g251417 , appendResult212_g251417 , Global_TexBlend509_g251357);
					float4 temp_output_135_109_g251415 = lerpResult131_g251417;
					float4 lerpResult143_g251415 = lerp( TVE_FormParams , temp_output_135_109_g251415 , TVE_FormLayers[(int)temp_output_130_0_g251415]);
					float4 temp_output_592_0_g251357 = lerpResult143_g251415;
					float4 Form_Texture112_g251357 = temp_output_592_0_g251357;
					float4 In_FormTexture204_g251357 = Form_Texture112_g251357;
					float4 temp_output_594_145_g251357 = TVE_FlowParams;
					half4 Flow_Params612_g251357 = temp_output_594_145_g251357;
					float4 In_FlowParams204_g251357 = Flow_Params612_g251357;
					float4 temp_output_203_0_g251409 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251409 = lerpResult400_g251357;
					float temp_output_136_0_g251407 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251409 = temp_output_136_0_g251407;
					float4 tex2DArrayNode83_g251409 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251409).zw + ( (temp_output_203_0_g251409).xy * temp_output_81_0_g251409 ) ),temp_output_82_0_g251409), 0.0 );
					float4 appendResult210_g251409 = (float4(tex2DArrayNode83_g251409.rgb , saturate( tex2DArrayNode83_g251409.a )));
					float4 temp_output_204_0_g251409 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251409 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251409).zw + ( (temp_output_204_0_g251409).xy * temp_output_81_0_g251409 ) ),temp_output_82_0_g251409), 0.0 );
					float4 appendResult212_g251409 = (float4(tex2DArrayNode122_g251409.rgb , saturate( tex2DArrayNode122_g251409.a )));
					float4 lerpResult131_g251409 = lerp( appendResult210_g251409 , appendResult212_g251409 , Global_TexBlend509_g251357);
					float4 temp_output_141_109_g251407 = lerpResult131_g251409;
					float4 lerpResult149_g251407 = lerp( TVE_FlowParams , temp_output_141_109_g251407 , TVE_FlowLayers[(int)temp_output_136_0_g251407]);
					half4 Flow_Texture405_g251357 = lerpResult149_g251407;
					float4 In_FlowTexture204_g251357 = Flow_Texture405_g251357;
					BuildGlobalData( Data204_g251357 , In_Dummy204_g251357 , In_CoatParams204_g251357 , In_CoatTexture204_g251357 , In_PaintParams204_g251357 , In_PaintTexture204_g251357 , In_AtmoParams204_g251357 , In_AtmoTexture204_g251357 , In_GlowParams204_g251357 , In_GlowTexture204_g251357 , In_FormParams204_g251357 , In_FormTexture204_g251357 , In_FlowParams204_g251357 , In_FlowTexture204_g251357 );
					TVEGlobalData Data15_g251558 =(TVEGlobalData)Data204_g251357;
					float Out_Dummy15_g251558 = 0.0;
					float4 Out_CoatParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251558 = float4( 0,0,0,0 );
					BreakData( Data15_g251558 , Out_Dummy15_g251558 , Out_CoatParams15_g251558 , Out_CoatTexture15_g251558 , Out_PaintParams15_g251558 , Out_PaintTexture15_g251558 , Out_AtmoParams15_g251558 , Out_AtmoTexture15_g251558 , Out_GlowParams15_g251558 , Out_GlowTexture15_g251558 , Out_FormParams15_g251558 , Out_FormTexture15_g251558 , Out_FlowParams15_g251558 , Out_FlowTexture15_g251558 );
					float4 Global_FormTexture351_g251555 = Out_FormTexture15_g251558;
					float3 Model_PivotWO353_g251555 = temp_output_314_19_g251555;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251564 = _ConformMeshMode;
					float Option70_g251564 = temp_output_17_0_g251564;
					half4 Model_VertexData357_g251555 = temp_output_314_29_g251555;
					float4 temp_output_3_0_g251564 = Model_VertexData357_g251555;
					float4 Channel70_g251564 = temp_output_3_0_g251564;
					float localSwitchChannel470_g251564 = SwitchChannel4( Option70_g251564 , Channel70_g251564 );
					float temp_output_390_0_g251555 = localSwitchChannel470_g251564;
					float temp_output_7_0_g251561 = _ConformMeshRemap.x;
					float temp_output_9_0_g251561 = ( temp_output_390_0_g251555 - temp_output_7_0_g251561 );
					float lerpResult374_g251555 = lerp( 1.0 , saturate( ( temp_output_9_0_g251561 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251555 = lerpResult374_g251555;
					float temp_output_328_0_g251555 = ( Blend_VertMask379_g251555 * TVE_IsEnabled );
					half Conform_Mask366_g251555 = temp_output_328_0_g251555;
					float temp_output_322_0_g251555 = ( ( ( ( (Global_FormTexture351_g251555).z - ( (Model_PivotWO353_g251555).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251555 ) );
					float3 appendResult329_g251555 = (float3(0.0 , temp_output_322_0_g251555 , 0.0));
					float3 appendResult387_g251555 = (float3(0.0 , 0.0 , temp_output_322_0_g251555));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251562 = appendResult387_g251555;
					#else
					float3 staticSwitch65_g251562 = appendResult329_g251555;
					#endif
					float3 Blanket_Conform368_g251555 = staticSwitch65_g251562;
					float4 appendResult312_g251555 = (float4(Blanket_Conform368_g251555 , 0.0));
					float4 temp_output_310_0_g251555 = ( Model_TransformData356_g251555 + appendResult312_g251555 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251555 = temp_output_310_0_g251555;
					#else
					float4 staticSwitch364_g251555 = Model_TransformData356_g251555;
					#endif
					half4 Final_TransformData365_g251555 = staticSwitch364_g251555;
					float4 In_TransformData16_g251557 = Final_TransformData365_g251555;
					float4 In_RotationData16_g251557 = Out_RotationData15_g251556;
					float4 In_InterpolatorA16_g251557 = Out_InterpolatorA15_g251556;
					BuildModelVertData( Data16_g251557 , In_Dummy16_g251557 , In_PositionOS16_g251557 , In_PositionWS16_g251557 , In_PositionWO16_g251557 , In_PositionRawOS16_g251557 , In_PivotOS16_g251557 , In_PivotWS16_g251557 , In_PivotWO16_g251557 , In_NormalOS16_g251557 , In_NormalWS16_g251557 , In_NormalRawOS16_g251557 , In_TangentOS16_g251557 , In_TangentWS16_g251557 , In_BitangentWS16_g251557 , In_ViewDirWS16_g251557 , In_CoordsData16_g251557 , In_VertexData16_g251557 , In_MasksData16_g251557 , In_PhaseData16_g251557 , In_TransformData16_g251557 , In_RotationData16_g251557 , In_InterpolatorA16_g251557 );
					TVEModelData Data15_g251571 =(TVEModelData)Data16_g251557;
					float Out_Dummy15_g251571 = 0.0;
					float3 Out_PositionOS15_g251571 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251571 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251571 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251571 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251571 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251571 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251571 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251571 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251571 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251571 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251571 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251571 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251571 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251571 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251571 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251571 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251571 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251571 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251571 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251571 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251571 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251571 , Out_Dummy15_g251571 , Out_PositionOS15_g251571 , Out_PositionWS15_g251571 , Out_PositionWO15_g251571 , Out_PositionRawOS15_g251571 , Out_PivotOS15_g251571 , Out_PivotWS15_g251571 , Out_PivotWO15_g251571 , Out_NormalOS15_g251571 , Out_NormalWS15_g251571 , Out_NormalRawOS15_g251571 , Out_TangentOS15_g251571 , Out_TangentWS15_g251571 , Out_BitangentWS15_g251571 , Out_ViewDirWS15_g251571 , Out_CoordsData15_g251571 , Out_VertexData15_g251571 , Out_MasksData15_g251571 , Out_PhaseData15_g251571 , Out_TransformData15_g251571 , Out_RotationData15_g251571 , Out_InterpolatorA15_g251571 );
					TVEModelData Data16_g251572 =(TVEModelData)Data15_g251571;
					float temp_output_14_0_g251572 = 0.0;
					float In_Dummy16_g251572 = temp_output_14_0_g251572;
					float3 Model_PositionOS147_g251570 = Out_PositionOS15_g251571;
					half3 VertexPos40_g251576 = Model_PositionOS147_g251570;
					float4 temp_output_1567_33_g251570 = Out_RotationData15_g251571;
					half4 Model_RotationData1569_g251570 = temp_output_1567_33_g251570;
					float2 break1582_g251570 = (Model_RotationData1569_g251570).xy;
					half Angle44_g251576 = break1582_g251570.y;
					half CosAngle89_g251576 = cos( Angle44_g251576 );
					half SinAngle93_g251576 = sin( Angle44_g251576 );
					float3 appendResult95_g251576 = (float3((VertexPos40_g251576).x , ( ( (VertexPos40_g251576).y * CosAngle89_g251576 ) - ( (VertexPos40_g251576).z * SinAngle93_g251576 ) ) , ( ( (VertexPos40_g251576).y * SinAngle93_g251576 ) + ( (VertexPos40_g251576).z * CosAngle89_g251576 ) )));
					half3 VertexPos40_g251577 = appendResult95_g251576;
					half Angle44_g251577 = -break1582_g251570.x;
					half CosAngle94_g251577 = cos( Angle44_g251577 );
					half SinAngle95_g251577 = sin( Angle44_g251577 );
					float3 appendResult98_g251577 = (float3(( ( (VertexPos40_g251577).x * CosAngle94_g251577 ) - ( (VertexPos40_g251577).y * SinAngle95_g251577 ) ) , ( ( (VertexPos40_g251577).x * SinAngle95_g251577 ) + ( (VertexPos40_g251577).y * CosAngle94_g251577 ) ) , (VertexPos40_g251577).z));
					half3 VertexPos40_g251575 = Model_PositionOS147_g251570;
					half Angle44_g251575 = break1582_g251570.y;
					half CosAngle89_g251575 = cos( Angle44_g251575 );
					half SinAngle93_g251575 = sin( Angle44_g251575 );
					float3 appendResult95_g251575 = (float3((VertexPos40_g251575).x , ( ( (VertexPos40_g251575).y * CosAngle89_g251575 ) - ( (VertexPos40_g251575).z * SinAngle93_g251575 ) ) , ( ( (VertexPos40_g251575).y * SinAngle93_g251575 ) + ( (VertexPos40_g251575).z * CosAngle89_g251575 ) )));
					half3 VertexPos40_g251580 = appendResult95_g251575;
					half Angle44_g251580 = break1582_g251570.x;
					half CosAngle91_g251580 = cos( Angle44_g251580 );
					half SinAngle92_g251580 = sin( Angle44_g251580 );
					float3 appendResult93_g251580 = (float3(( ( (VertexPos40_g251580).x * CosAngle91_g251580 ) + ( (VertexPos40_g251580).z * SinAngle92_g251580 ) ) , (VertexPos40_g251580).y , ( ( -(VertexPos40_g251580).x * SinAngle92_g251580 ) + ( (VertexPos40_g251580).z * CosAngle91_g251580 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251578 = appendResult93_g251580;
					#else
					float3 staticSwitch65_g251578 = appendResult98_g251577;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251573 = staticSwitch65_g251578;
					#else
					float3 staticSwitch65_g251573 = Model_PositionOS147_g251570;
					#endif
					float3 temp_output_1608_0_g251570 = staticSwitch65_g251573;
					half3 VertexPos40_g251579 = temp_output_1608_0_g251570;
					half Angle44_g251579 = (Model_RotationData1569_g251570).z;
					half CosAngle91_g251579 = cos( Angle44_g251579 );
					half SinAngle92_g251579 = sin( Angle44_g251579 );
					float3 appendResult93_g251579 = (float3(( ( (VertexPos40_g251579).x * CosAngle91_g251579 ) + ( (VertexPos40_g251579).z * SinAngle92_g251579 ) ) , (VertexPos40_g251579).y , ( ( -(VertexPos40_g251579).x * SinAngle92_g251579 ) + ( (VertexPos40_g251579).z * CosAngle91_g251579 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251574 = appendResult93_g251579;
					#else
					float3 staticSwitch65_g251574 = temp_output_1608_0_g251570;
					#endif
					float4 temp_output_1567_31_g251570 = Out_TransformData15_g251571;
					half4 Model_TransformData1568_g251570 = temp_output_1567_31_g251570;
					half3 Final_PositionOS178_g251570 = ( ( staticSwitch65_g251574 * (Model_TransformData1568_g251570).w ) + (Model_TransformData1568_g251570).xyz );
					float3 temp_output_4_0_g251572 = Final_PositionOS178_g251570;
					float3 In_PositionOS16_g251572 = temp_output_4_0_g251572;
					float3 In_PositionWS16_g251572 = Out_PositionWS15_g251571;
					float3 In_PositionWO16_g251572 = Out_PositionWO15_g251571;
					float3 In_PositionRawOS16_g251572 = Out_PositionRawOS15_g251571;
					float3 In_PivotOS16_g251572 = Out_PivotOS15_g251571;
					float3 In_PivotWS16_g251572 = Out_PivotWS15_g251571;
					float3 In_PivotWO16_g251572 = Out_PivotWO15_g251571;
					float3 temp_output_21_0_g251572 = Out_NormalOS15_g251571;
					float3 In_NormalOS16_g251572 = temp_output_21_0_g251572;
					float3 In_NormalWS16_g251572 = Out_NormalWS15_g251571;
					float3 In_NormalRawOS16_g251572 = Out_NormalRawOS15_g251571;
					float4 temp_output_6_0_g251572 = Out_TangentOS15_g251571;
					float4 In_TangentOS16_g251572 = temp_output_6_0_g251572;
					float3 In_TangentWS16_g251572 = Out_TangentWS15_g251571;
					float3 In_BitangentWS16_g251572 = Out_BitangentWS15_g251571;
					float3 In_ViewDirWS16_g251572 = Out_ViewDirWS15_g251571;
					float4 In_CoordsData16_g251572 = Out_CoordsData15_g251571;
					float4 In_VertexData16_g251572 = Out_VertexData15_g251571;
					float4 In_MasksData16_g251572 = Out_MasksData15_g251571;
					float4 In_PhaseData16_g251572 = Out_PhaseData15_g251571;
					float4 In_TransformData16_g251572 = temp_output_1567_31_g251570;
					float4 In_RotationData16_g251572 = temp_output_1567_33_g251570;
					float4 In_InterpolatorA16_g251572 = Out_InterpolatorA15_g251571;
					BuildModelVertData( Data16_g251572 , In_Dummy16_g251572 , In_PositionOS16_g251572 , In_PositionWS16_g251572 , In_PositionWO16_g251572 , In_PositionRawOS16_g251572 , In_PivotOS16_g251572 , In_PivotWS16_g251572 , In_PivotWO16_g251572 , In_NormalOS16_g251572 , In_NormalWS16_g251572 , In_NormalRawOS16_g251572 , In_TangentOS16_g251572 , In_TangentWS16_g251572 , In_BitangentWS16_g251572 , In_ViewDirWS16_g251572 , In_CoordsData16_g251572 , In_VertexData16_g251572 , In_MasksData16_g251572 , In_PhaseData16_g251572 , In_TransformData16_g251572 , In_RotationData16_g251572 , In_InterpolatorA16_g251572 );
					TVEModelData Data15_g251582 =(TVEModelData)Data16_g251572;
					float Out_Dummy15_g251582 = 0.0;
					float3 Out_PositionOS15_g251582 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251582 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251582 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251582 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251582 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251582 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251582 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251582 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251582 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251582 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251582 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251582 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251582 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251582 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251582 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251582 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251582 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251582 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251582 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251582 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251582 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251582 , Out_Dummy15_g251582 , Out_PositionOS15_g251582 , Out_PositionWS15_g251582 , Out_PositionWO15_g251582 , Out_PositionRawOS15_g251582 , Out_PivotOS15_g251582 , Out_PivotWS15_g251582 , Out_PivotWO15_g251582 , Out_NormalOS15_g251582 , Out_NormalWS15_g251582 , Out_NormalRawOS15_g251582 , Out_TangentOS15_g251582 , Out_TangentWS15_g251582 , Out_BitangentWS15_g251582 , Out_ViewDirWS15_g251582 , Out_CoordsData15_g251582 , Out_VertexData15_g251582 , Out_MasksData15_g251582 , Out_PhaseData15_g251582 , Out_TransformData15_g251582 , Out_RotationData15_g251582 , Out_InterpolatorA15_g251582 );
					TVEModelData Data16_g251583 =(TVEModelData)Data15_g251582;
					float temp_output_14_0_g251583 = 0.0;
					float In_Dummy16_g251583 = temp_output_14_0_g251583;
					float3 temp_output_217_24_g251581 = Out_PivotOS15_g251582;
					float3 temp_output_216_0_g251581 = ( Out_PositionOS15_g251582 + temp_output_217_24_g251581 );
					float3 temp_output_4_0_g251583 = temp_output_216_0_g251581;
					float3 In_PositionOS16_g251583 = temp_output_4_0_g251583;
					float3 In_PositionWS16_g251583 = Out_PositionWS15_g251582;
					float3 In_PositionWO16_g251583 = Out_PositionWO15_g251582;
					float3 In_PositionRawOS16_g251583 = Out_PositionRawOS15_g251582;
					float3 In_PivotOS16_g251583 = temp_output_217_24_g251581;
					float3 In_PivotWS16_g251583 = Out_PivotWS15_g251582;
					float3 In_PivotWO16_g251583 = Out_PivotWO15_g251582;
					float3 temp_output_21_0_g251583 = Out_NormalOS15_g251582;
					float3 In_NormalOS16_g251583 = temp_output_21_0_g251583;
					float3 In_NormalWS16_g251583 = Out_NormalWS15_g251582;
					float3 In_NormalRawOS16_g251583 = Out_NormalRawOS15_g251582;
					float4 temp_output_6_0_g251583 = Out_TangentOS15_g251582;
					float4 In_TangentOS16_g251583 = temp_output_6_0_g251583;
					float3 In_TangentWS16_g251583 = Out_TangentWS15_g251582;
					float3 In_BitangentWS16_g251583 = Out_BitangentWS15_g251582;
					float3 In_ViewDirWS16_g251583 = Out_ViewDirWS15_g251582;
					float4 In_CoordsData16_g251583 = Out_CoordsData15_g251582;
					float4 In_VertexData16_g251583 = Out_VertexData15_g251582;
					float4 In_MasksData16_g251583 = Out_MasksData15_g251582;
					float4 In_PhaseData16_g251583 = Out_PhaseData15_g251582;
					float4 In_TransformData16_g251583 = Out_TransformData15_g251582;
					float4 In_RotationData16_g251583 = Out_RotationData15_g251582;
					float4 In_InterpolatorA16_g251583 = Out_InterpolatorA15_g251582;
					BuildModelVertData( Data16_g251583 , In_Dummy16_g251583 , In_PositionOS16_g251583 , In_PositionWS16_g251583 , In_PositionWO16_g251583 , In_PositionRawOS16_g251583 , In_PivotOS16_g251583 , In_PivotWS16_g251583 , In_PivotWO16_g251583 , In_NormalOS16_g251583 , In_NormalWS16_g251583 , In_NormalRawOS16_g251583 , In_TangentOS16_g251583 , In_TangentWS16_g251583 , In_BitangentWS16_g251583 , In_ViewDirWS16_g251583 , In_CoordsData16_g251583 , In_VertexData16_g251583 , In_MasksData16_g251583 , In_PhaseData16_g251583 , In_TransformData16_g251583 , In_RotationData16_g251583 , In_InterpolatorA16_g251583 );
					TVEModelData Data15_g251592 =(TVEModelData)Data16_g251583;
					float Out_Dummy15_g251592 = 0.0;
					float3 Out_PositionOS15_g251592 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251592 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251592 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251592 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251592 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251592 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251592 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251592 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251592 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251592 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251592 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251592 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251592 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251592 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251592 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251592 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251592 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251592 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251592 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251592 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251592 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251592 , Out_Dummy15_g251592 , Out_PositionOS15_g251592 , Out_PositionWS15_g251592 , Out_PositionWO15_g251592 , Out_PositionRawOS15_g251592 , Out_PivotOS15_g251592 , Out_PivotWS15_g251592 , Out_PivotWO15_g251592 , Out_NormalOS15_g251592 , Out_NormalWS15_g251592 , Out_NormalRawOS15_g251592 , Out_TangentOS15_g251592 , Out_TangentWS15_g251592 , Out_BitangentWS15_g251592 , Out_ViewDirWS15_g251592 , Out_CoordsData15_g251592 , Out_VertexData15_g251592 , Out_MasksData15_g251592 , Out_PhaseData15_g251592 , Out_TransformData15_g251592 , Out_RotationData15_g251592 , Out_InterpolatorA15_g251592 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251592;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251592;
					v.tangent = Out_TangentOS15_g251592;

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

				VertexControl vert ( appdata v )
				{
					VertexControl o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_TRANSFER_INSTANCE_ID(v, o);
					o.vertex = v.vertex;
					o.normal = v.normal;
					o.ase_texcoord3 = v.ase_texcoord3;
					o.ase_texcoord = v.ase_texcoord;
					o.ase_texcoord2 = v.ase_texcoord2;
					o.ase_color = v.ase_color;
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
					o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
					o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
					o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
					o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
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
				#define ASE_ABSOLUTE_VERTEX_POS 1
				#pragma multi_compile_instancing
				#define _SPECULAR_SETUP 1
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

				#define ASE_NEEDS_VERT_POSITION
				#define ASE_NEEDS_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
				#define ASE_NEEDS_VERT_NORMAL
				#define ASE_NEEDS_VERT_TANGENT
				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES2
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES2
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_CONFORM
				#if defined (TVE_CLIPPING) //Render Clip
					#define TVE_ALPHA_CLIP //Render Clip
				#endif //Render Clip
				  
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
				#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
				#endif//ASE Sampling Macros
				


				float4 _SelectionID;

				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					half4 tangent : TANGENT;
					float4 ase_texcoord3 : TEXCOORD3;
					float4 ase_texcoord : TEXCOORD0;
					float4 ase_texcoord2 : TEXCOORD2;
					float4 ase_color : COLOR;
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

				uniform half _IsTVEShader;
				uniform half TVE_DEBUG_Filter;
				uniform half TVE_DEBUG_Clip;
				uniform half TVE_DEBUG_Min;
				uniform half TVE_DEBUG_Max;
				uniform half TVE_DEBUG_Index;
				uniform half TVE_DEBUG_Shading;
				uniform half _ObjectCategory;
				uniform half _ObjectEnd;
				uniform half _ObjectModelMode;
				uniform half _ObjectPivotMode;
				uniform float3 TVE_WorldOrigin;
				uniform half _ObjectHeightValue;
				uniform half _ObjectRadiusValue;
				uniform half _ObjectPhaseMode;
				uniform float _IsShaderType;
				uniform half _ConformCategory;
				uniform half _ConformEnd;
				uniform half _ConformInfo;
				uniform half _GlobalCategory;
				uniform half _GlobalEnd;
				uniform half4 TVE_CoatParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatBaseTex);
				uniform float4 TVE_CoatBaseCoord;
				uniform half _GlobalCoatPivotValue;
				uniform half _GlobalCoatLayerValue;
				SamplerState sampler_Linear_Clamp;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_CoatNearTex);
				uniform float4 TVE_CoatNearCoord;
				SamplerState sampler_Linear_Repeat;
				uniform float4 TVE_RenderNearPositionR;
				uniform half TVE_RenderNearFadeValue;
				uniform float TVE_CoatLayers[10];
				uniform half4 TVE_PaintParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintBaseTex);
				uniform float4 TVE_PaintBaseCoord;
				uniform half _GlobalPaintPivotValue;
				uniform half _GlobalPaintLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_PaintNearTex);
				uniform float4 TVE_PaintNearCoord;
				uniform float TVE_PaintLayers[10];
				uniform half4 TVE_AtmoParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoBaseTex);
				uniform float4 TVE_AtmoBaseCoord;
				uniform half _GlobalAtmoPivotValue;
				uniform half _GlobalAtmoLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_AtmoNearTex);
				uniform float4 TVE_AtmoNearCoord;
				uniform float TVE_AtmoLayers[10];
				uniform half4 TVE_GlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowBaseTex);
				uniform float4 TVE_GlowBaseCoord;
				uniform half _GlobalGlowPivotValue;
				uniform half _GlobalGlowLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_GlowNearTex);
				uniform float4 TVE_GlowNearCoord;
				uniform float TVE_GlowLayers[10];
				uniform half4 TVE_FormParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormBaseTex);
				uniform float4 TVE_FormBaseCoord;
				uniform half _GlobalFormPivotValue;
				uniform half _GlobalFormLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FormNearTex);
				uniform float4 TVE_FormNearCoord;
				uniform float TVE_FormLayers[10];
				uniform half4 TVE_FlowParams;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowBaseTex);
				uniform float4 TVE_FlowBaseCoord;
				uniform half _GlobalFlowPivotValue;
				uniform half _GlobalFlowLayerValue;
				UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_FlowNearTex);
				uniform float4 TVE_FlowNearCoord;
				uniform float TVE_FlowLayers[10];
				uniform half _ConformMode;
				uniform half _ConformOffsetValue;
				uniform half _ConformIntensityValue;
				uniform half _ConformMeshMode;
				uniform half4 _ConformMeshRemap;
				uniform half _ConformMeshValue;
				uniform half TVE_IsEnabled;


				half CapsuleMaskYUp( half3 Position, half Height, half Radius )
				{
					    float3 a = float3(0, Height, 0);
					    float3 ba = -a;
					    float3 pa = Position - a;
					    
					    float baDot = dot(ba, ba);
					    float h = saturate(dot(pa, ba) / baDot);
					    
					    float3 q = pa - ba * h;
					    return length(q) / Radius;
				}
				
				half CapsuleMaskZUp( half3 Position, half Height, half Radius )
				{
					    float3 a = float3(0, 0, Height);
					    float3 ba = -a;
					    float3 pa = Position - a;
					    
					    float baDot = dot(ba, ba);
					    float h = saturate(dot(pa, ba) / baDot);
					    
					    float3 q = pa - ba * h;
					    return length(q) / Radius;
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
				
				void BuildModelVertData( inout TVEModelData Data, half In_Dummy, float3 In_PositionOS, float3 In_PositionWS, float3 In_PositionWO, float3 In_PositionRawOS, float3 In_PivotOS, float3 In_PivotWS, float3 In_PivotWO, half3 In_NormalOS, half3 In_NormalWS, half3 In_NormalRawOS, half4 In_TangentOS, half3 In_TangentWS, half3 In_BitangentWS, half3 In_ViewDirWS, float4 In_CoordsData, float4 In_VertexData, half4 In_MasksData, half4 In_PhaseData, half4 In_TransformData, half4 In_RotationData, float4 In_InterpolatorA )
				{
					Data.Dummy = In_Dummy;
					Data.PositionOS = In_PositionOS;
					Data.PositionWS = In_PositionWS;
					Data.PositionWO = In_PositionWO;
					Data.PositionRawOS = In_PositionRawOS;
					Data.PivotOS = In_PivotOS;
					Data.PivotWS = In_PivotWS;
					Data.PivotWO = In_PivotWO;
					Data.NormalOS = In_NormalOS;
					Data.NormalWS = In_NormalWS;
					Data.NormalRawOS = In_NormalRawOS;
					Data.TangentOS = In_TangentOS;
					Data.TangentWS = In_TangentWS;
					Data.BitangentWS = In_BitangentWS;
					Data.ViewDirWS = In_ViewDirWS;
					Data.CoordsData = In_CoordsData;
					Data.VertexData = In_VertexData;
					Data.MasksData = In_MasksData;
					Data.PhaseData = In_PhaseData;
					Data.TransformData = In_TransformData;
					Data.RotationData = In_RotationData;
					Data.InterpolatorA = In_InterpolatorA ;
					return;
				}
				
				void BreakModelVertData( inout TVEModelData Data, out half Out_Dummy, out half3 Out_PositionOS, out half3 Out_PositionWS, out half3 Out_PositionWO, out half3 Out_PositionRawOS, out half3 Out_PivotOS, out half3 Out_PivotWS, out half3 Out_PivotWO, out half3 Out_NormalOS, out half3 Out_NormalWS, out half3 Out_NormalRawOS, out half4 Out_TangentOS, out half3 Out_TangentWS, out half3 Out_BitangentWS, out half3 Out_ViewDirWS, out float4 Out_CoordsData, out half4 Out_VertexData, out half4 Out_MasksData, out half4 Out_PhaseData, out half4 Out_TransformData, out half4 Out_RotationData, out half4 Out_InterpolatorA )
				{
					Out_Dummy = Data.Dummy;
					Out_PositionOS = Data.PositionOS;
					Out_PositionWS = Data.PositionWS;
					Out_PositionWO = Data.PositionWO;
					Out_PositionRawOS = Data.PositionRawOS;
					Out_PivotOS = Data.PivotOS;
					Out_PivotWS = Data.PivotWS;
					Out_PivotWO = Data.PivotWO;
					Out_NormalOS = Data.NormalOS;
					Out_NormalWS = Data.NormalWS;
					Out_NormalRawOS = Data.NormalRawOS;
					Out_TangentOS = Data.TangentOS;
					Out_TangentWS = Data.TangentWS;
					Out_BitangentWS = Data.BitangentWS;
					Out_ViewDirWS = Data.ViewDirWS;
					Out_CoordsData = Data.CoordsData;
					Out_VertexData = Data.VertexData;
					Out_MasksData = Data.MasksData;
					Out_PhaseData = Data.PhaseData;
					Out_TransformData = Data.TransformData;
					Out_RotationData = Data.RotationData;
					Out_InterpolatorA = Data.InterpolatorA;
					return;
				}
				
				half3 ComputeTriplanarWeights( half3 NormalWS )
				{
					half3 powNormal = abs( NormalWS );
					half3 tempWeights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.0001 );
					tempWeights /= ( tempWeights.x + tempWeights.y + tempWeights.z ).xxx;
					return tempWeights;
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
				
				void BuildGlobalData( out TVEGlobalData Data, half In_Dummy, half4 In_CoatParams, half4 In_CoatTexture, half4 In_PaintParams, half4 In_PaintTexture, half4 In_AtmoParams, half4 In_AtmoTexture, half4 In_GlowParams, half4 In_GlowTexture, float4 In_FormParams, float4 In_FormTexture, half4 In_FlowParams, float4 In_FlowTexture )
				{
					Data = (TVEGlobalData)0;
					Data.Dummy = In_Dummy;
					Data.CoatParams= In_CoatParams;
					Data.CoatTexture = In_CoatTexture;
					Data.PaintParams = In_PaintParams;
					Data.PaintTexture = In_PaintTexture;
					Data.AtmoParams= In_AtmoParams;
					Data.AtmoTexture= In_AtmoTexture;
					Data.GlowParams= In_GlowParams;
					Data.GlowTexture= In_GlowTexture;
					Data.FormParams= In_FormParams;
					Data.FormTexture= In_FormTexture;
					Data.FlowParams= In_FlowParams;
					Data.FlowTexture= In_FlowTexture;
					return;
				}
				
				void BreakData( inout TVEGlobalData Data, out half Out_Dummy, out half4 Out_CoatParams, out half4 Out_CoatTexture, out half4 Out_PaintParams, out half4 Out_PaintTexture, out half4 Out_AtmoParams, out half4 Out_AtmoTexture, out half4 Out_GlowParams, out half4 Out_GlowTexture, out float4 Out_FormParams, out float4 Out_FormTexture, out half4 Out_FlowParams, out half4 Out_FlowTexture )
				{
					Out_Dummy = Data.Dummy;
					Out_CoatParams = Data.CoatParams;
					Out_CoatTexture = Data.CoatTexture;
					Out_PaintParams = Data.PaintParams;
					Out_PaintTexture = Data.PaintTexture;
					Out_AtmoParams= Data.AtmoParams;
					Out_AtmoTexture= Data.AtmoTexture;
					Out_GlowParams= Data.GlowParams;
					Out_GlowTexture= Data.GlowTexture;
					Out_FormParams= Data.FormParams;
					Out_FormTexture = Data.FormTexture;
					Out_FlowParams = Data.FlowParams;
					Out_FlowTexture = Data.FlowTexture;
					return;
				}
				

				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float localIfModelDataByShader26_g251540 = ( 0.0 );
					TVEModelData Data26_g251540 = (TVEModelData)0;
					TVEModelData Data16_g241385 =(TVEModelData)0;
					half Dummy207_g241375 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g241385 = Dummy207_g241375;
					float In_Dummy16_g241385 = temp_output_14_0_g241385;
					float3 PositionOS131_g241375 = v.vertex.xyz;
					float3 temp_output_4_0_g241385 = PositionOS131_g241375;
					float3 In_PositionOS16_g241385 = temp_output_4_0_g241385;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g241375 = ase_positionWS;
					float3 vertexToFrag73_g241375 = temp_output_104_7_g241375;
					float3 PositionWS122_g241375 = vertexToFrag73_g241375;
					float3 In_PositionWS16_g241385 = PositionWS122_g241375;
					float4x4 break19_g241378 = unity_ObjectToWorld;
					float3 appendResult20_g241378 = (float3(break19_g241378[ 0 ][ 3 ] , break19_g241378[ 1 ][ 3 ] , break19_g241378[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241375 = appendResult20_g241378;
					float4x4 break19_g241380 = unity_ObjectToWorld;
					float3 appendResult20_g241380 = (float3(break19_g241380[ 0 ][ 3 ] , break19_g241380[ 1 ][ 3 ] , break19_g241380[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g241376 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g241375 = PositionOS131_g241375;
					float3 appendResult234_g241375 = (float3(break233_g241375.x , 0.0 , break233_g241375.z));
					float3 break413_g241375 = PositionOS131_g241375;
					float3 appendResult414_g241375 = (float3(break413_g241375.x , break413_g241375.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g241382 = appendResult414_g241375;
					#else
					float3 staticSwitch65_g241382 = appendResult234_g241375;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g241375 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g241375 = appendResult60_g241376;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g241375 = staticSwitch65_g241382;
					#else
					float3 staticSwitch229_g241375 = _Vector0;
					#endif
					float3 PivotOS149_g241375 = staticSwitch229_g241375;
					float3 temp_output_122_0_g241380 = PivotOS149_g241375;
					float3 PivotsOnlyWS105_g241380 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g241380 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g241375 = ( appendResult20_g241380 + PivotsOnlyWS105_g241380 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g241375 = temp_output_340_7_g241375;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g241375 = temp_output_341_7_g241375;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g241375 = temp_output_341_7_g241375;
					#else
					float3 staticSwitch236_g241375 = temp_output_340_7_g241375;
					#endif
					float3 vertexToFrag76_g241375 = staticSwitch236_g241375;
					float3 PivotWS121_g241375 = vertexToFrag76_g241375;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241375 = ( PositionWS122_g241375 - PivotWS121_g241375 );
					#else
					float3 staticSwitch204_g241375 = PositionWS122_g241375;
					#endif
					float3 PositionWO132_g241375 = ( staticSwitch204_g241375 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241385 = PositionWO132_g241375;
					float3 In_PositionRawOS16_g241385 = PositionOS131_g241375;
					float3 In_PivotOS16_g241385 = PivotOS149_g241375;
					float3 In_PivotWS16_g241385 = PivotWS121_g241375;
					float3 PivotWO133_g241375 = ( PivotWS121_g241375 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241385 = PivotWO133_g241375;
					half3 NormalOS134_g241375 = v.normal;
					float3 temp_output_21_0_g241385 = NormalOS134_g241375;
					float3 In_NormalOS16_g241385 = temp_output_21_0_g241385;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g241375 = normalizedWorldNormal;
					float3 In_NormalWS16_g241385 = NormalWS95_g241375;
					float3 In_NormalRawOS16_g241385 = NormalOS134_g241375;
					half4 TangentlOS153_g241375 = v.tangent;
					float4 temp_output_6_0_g241385 = TangentlOS153_g241375;
					float4 In_TangentOS16_g241385 = temp_output_6_0_g241385;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g241375 = ase_tangentWS;
					float3 In_TangentWS16_g241385 = TangentWS136_g241375;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g241375 = ase_bitangentWS;
					float3 In_BitangentWS16_g241385 = BiangentWS421_g241375;
					float3 normalizeResult296_g241375 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241375 ) );
					half3 ViewDirWS169_g241375 = normalizeResult296_g241375;
					float3 In_ViewDirWS16_g241385 = ViewDirWS169_g241375;
					float4 appendResult397_g241375 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g241375 = appendResult397_g241375;
					float4 In_CoordsData16_g241385 = CoordsData398_g241375;
					half4 VertexMasks171_g241375 = v.ase_color;
					float4 In_VertexData16_g241385 = VertexMasks171_g241375;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241388 = (PositionOS131_g241375).z;
					#else
					float staticSwitch65_g241388 = (PositionOS131_g241375).y;
					#endif
					half Object_HeightValue267_g241375 = _ObjectHeightValue;
					half Bounds_HeightMask274_g241375 = saturate( ( staticSwitch65_g241388 / Object_HeightValue267_g241375 ) );
					half3 Position387_g241375 = PositionOS131_g241375;
					half Height387_g241375 = Object_HeightValue267_g241375;
					half Object_RadiusValue268_g241375 = _ObjectRadiusValue;
					half Radius387_g241375 = Object_RadiusValue268_g241375;
					half localCapsuleMaskYUp387_g241375 = CapsuleMaskYUp( Position387_g241375 , Height387_g241375 , Radius387_g241375 );
					half3 Position408_g241375 = PositionOS131_g241375;
					half Height408_g241375 = Object_HeightValue267_g241375;
					half Radius408_g241375 = Object_RadiusValue268_g241375;
					half localCapsuleMaskZUp408_g241375 = CapsuleMaskZUp( Position408_g241375 , Height408_g241375 , Radius408_g241375 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241393 = saturate( localCapsuleMaskZUp408_g241375 );
					#else
					float staticSwitch65_g241393 = saturate( localCapsuleMaskYUp387_g241375 );
					#endif
					half Bounds_SphereMask282_g241375 = staticSwitch65_g241393;
					float4 appendResult253_g241375 = (float4(Bounds_HeightMask274_g241375 , Bounds_SphereMask282_g241375 , 1.0 , 1.0));
					half4 MasksData254_g241375 = appendResult253_g241375;
					float4 In_MasksData16_g241385 = MasksData254_g241375;
					float temp_output_17_0_g241387 = _ObjectPhaseMode;
					float Option70_g241387 = temp_output_17_0_g241387;
					float4 temp_output_3_0_g241387 = v.ase_color;
					float4 Channel70_g241387 = temp_output_3_0_g241387;
					float localSwitchChannel470_g241387 = SwitchChannel4( Option70_g241387 , Channel70_g241387 );
					half Phase_Value372_g241375 = localSwitchChannel470_g241387;
					float3 break319_g241375 = PivotWO133_g241375;
					half Pivot_Position322_g241375 = ( break319_g241375.x + break319_g241375.z );
					half Phase_Position357_g241375 = ( Phase_Value372_g241375 + Pivot_Position322_g241375 );
					float temp_output_248_0_g241375 = frac( Phase_Position357_g241375 );
					float4 appendResult177_g241375 = (float4(( (frac( ( Phase_Position357_g241375 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g241375));
					half4 Phase_Data176_g241375 = appendResult177_g241375;
					float4 In_PhaseData16_g241385 = Phase_Data176_g241375;
					float4 In_TransformData16_g241385 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g241385 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g241385 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g241385 , In_Dummy16_g241385 , In_PositionOS16_g241385 , In_PositionWS16_g241385 , In_PositionWO16_g241385 , In_PositionRawOS16_g241385 , In_PivotOS16_g241385 , In_PivotWS16_g241385 , In_PivotWO16_g241385 , In_NormalOS16_g241385 , In_NormalWS16_g241385 , In_NormalRawOS16_g241385 , In_TangentOS16_g241385 , In_TangentWS16_g241385 , In_BitangentWS16_g241385 , In_ViewDirWS16_g241385 , In_CoordsData16_g241385 , In_VertexData16_g241385 , In_MasksData16_g241385 , In_PhaseData16_g241385 , In_TransformData16_g241385 , In_RotationData16_g241385 , In_InterpolatorA16_g241385 );
					TVEModelData DataDefault26_g251540 = Data16_g241385;
					TVEModelData DataGeneral26_g251540 = Data16_g241385;
					TVEModelData DataBlanket26_g251540 = Data16_g241385;
					TVEModelData DataImpostor26_g251540 = Data16_g241385;
					TVEModelData Data16_g241365 =(TVEModelData)0;
					half Dummy207_g241355 = 0.0;
					float temp_output_14_0_g241365 = Dummy207_g241355;
					float In_Dummy16_g241365 = temp_output_14_0_g241365;
					float3 PositionOS131_g241355 = v.vertex.xyz;
					float3 temp_output_4_0_g241365 = PositionOS131_g241355;
					float3 In_PositionOS16_g241365 = temp_output_4_0_g241365;
					float3 temp_output_104_7_g241355 = ase_positionWS;
					float3 PositionWS122_g241355 = temp_output_104_7_g241355;
					float3 In_PositionWS16_g241365 = PositionWS122_g241355;
					float4x4 break19_g241358 = unity_ObjectToWorld;
					float3 appendResult20_g241358 = (float3(break19_g241358[ 0 ][ 3 ] , break19_g241358[ 1 ][ 3 ] , break19_g241358[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241355 = appendResult20_g241358;
					float3 PivotWS121_g241355 = temp_output_340_7_g241355;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241355 = ( PositionWS122_g241355 - PivotWS121_g241355 );
					#else
					float3 staticSwitch204_g241355 = PositionWS122_g241355;
					#endif
					float3 PositionWO132_g241355 = ( staticSwitch204_g241355 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241365 = PositionWO132_g241355;
					float3 In_PositionRawOS16_g241365 = PositionOS131_g241355;
					float3 PivotOS149_g241355 = _Vector0;
					float3 In_PivotOS16_g241365 = PivotOS149_g241355;
					float3 In_PivotWS16_g241365 = PivotWS121_g241355;
					float3 PivotWO133_g241355 = ( PivotWS121_g241355 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241365 = PivotWO133_g241355;
					half3 NormalOS134_g241355 = v.normal;
					float3 temp_output_21_0_g241365 = NormalOS134_g241355;
					float3 In_NormalOS16_g241365 = temp_output_21_0_g241365;
					half3 NormalWS95_g241355 = normalizedWorldNormal;
					float3 In_NormalWS16_g241365 = NormalWS95_g241355;
					float3 In_NormalRawOS16_g241365 = NormalOS134_g241355;
					half4 TangentlOS153_g241355 = v.tangent;
					float4 temp_output_6_0_g241365 = TangentlOS153_g241355;
					float4 In_TangentOS16_g241365 = temp_output_6_0_g241365;
					half3 TangentWS136_g241355 = ase_tangentWS;
					float3 In_TangentWS16_g241365 = TangentWS136_g241355;
					half3 BiangentWS421_g241355 = ase_bitangentWS;
					float3 In_BitangentWS16_g241365 = BiangentWS421_g241355;
					float3 normalizeResult296_g241355 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241355 ) );
					half3 ViewDirWS169_g241355 = normalizeResult296_g241355;
					float3 In_ViewDirWS16_g241365 = ViewDirWS169_g241355;
					float4 appendResult397_g241355 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g241355 = appendResult397_g241355;
					float4 In_CoordsData16_g241365 = CoordsData398_g241355;
					half4 VertexMasks171_g241355 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241365 = VertexMasks171_g241355;
					half4 MasksData254_g241355 = float4( 0,0,0,0 );
					float4 In_MasksData16_g241365 = MasksData254_g241355;
					half4 Phase_Data176_g241355 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241365 = Phase_Data176_g241355;
					float4 In_TransformData16_g241365 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g241365 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g241365 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g241365 , In_Dummy16_g241365 , In_PositionOS16_g241365 , In_PositionWS16_g241365 , In_PositionWO16_g241365 , In_PositionRawOS16_g241365 , In_PivotOS16_g241365 , In_PivotWS16_g241365 , In_PivotWO16_g241365 , In_NormalOS16_g241365 , In_NormalWS16_g241365 , In_NormalRawOS16_g241365 , In_TangentOS16_g241365 , In_TangentWS16_g241365 , In_BitangentWS16_g241365 , In_ViewDirWS16_g241365 , In_CoordsData16_g241365 , In_VertexData16_g241365 , In_MasksData16_g241365 , In_PhaseData16_g241365 , In_TransformData16_g241365 , In_RotationData16_g241365 , In_InterpolatorA16_g241365 );
					TVEModelData DataTerrain26_g251540 = Data16_g241365;
					half IsShaderType2672 = _IsShaderType;
					float Type26_g251540 = IsShaderType2672;
					{
					if (Type26_g251540 == 0 )
					{
					Data26_g251540 = DataDefault26_g251540;
					}
					else if (Type26_g251540 == 1 )
					{
					Data26_g251540 = DataGeneral26_g251540;
					}
					else if (Type26_g251540 == 2 )
					{
					Data26_g251540 = DataBlanket26_g251540;
					}
					else if (Type26_g251540 == 3 )
					{
					Data26_g251540 = DataImpostor26_g251540;
					}
					else if (Type26_g251540 == 4 )
					{
					Data26_g251540 = DataTerrain26_g251540;
					}
					}
					TVEModelData Data15_g251552 =(TVEModelData)Data26_g251540;
					float Out_Dummy15_g251552 = 0.0;
					float3 Out_PositionOS15_g251552 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251552 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251552 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251552 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251552 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251552 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251552 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251552 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251552 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251552 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251552 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251552 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251552 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251552 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251552 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251552 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251552 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251552 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251552 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251552 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251552 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251552 , Out_Dummy15_g251552 , Out_PositionOS15_g251552 , Out_PositionWS15_g251552 , Out_PositionWO15_g251552 , Out_PositionRawOS15_g251552 , Out_PivotOS15_g251552 , Out_PivotWS15_g251552 , Out_PivotWO15_g251552 , Out_NormalOS15_g251552 , Out_NormalWS15_g251552 , Out_NormalRawOS15_g251552 , Out_TangentOS15_g251552 , Out_TangentWS15_g251552 , Out_BitangentWS15_g251552 , Out_ViewDirWS15_g251552 , Out_CoordsData15_g251552 , Out_VertexData15_g251552 , Out_MasksData15_g251552 , Out_PhaseData15_g251552 , Out_TransformData15_g251552 , Out_RotationData15_g251552 , Out_InterpolatorA15_g251552 );
					TVEModelData Data16_g251554 =(TVEModelData)Data15_g251552;
					float temp_output_14_0_g251554 = 0.0;
					float In_Dummy16_g251554 = temp_output_14_0_g251554;
					float3 temp_output_219_24_g251551 = Out_PivotOS15_g251552;
					float3 temp_output_215_0_g251551 = ( Out_PositionOS15_g251552 - temp_output_219_24_g251551 );
					float3 temp_output_4_0_g251554 = temp_output_215_0_g251551;
					float3 In_PositionOS16_g251554 = temp_output_4_0_g251554;
					float3 In_PositionWS16_g251554 = Out_PositionWS15_g251552;
					float3 In_PositionWO16_g251554 = Out_PositionWO15_g251552;
					float3 In_PositionRawOS16_g251554 = Out_PositionRawOS15_g251552;
					float3 In_PivotOS16_g251554 = temp_output_219_24_g251551;
					float3 In_PivotWS16_g251554 = Out_PivotWS15_g251552;
					float3 In_PivotWO16_g251554 = Out_PivotWO15_g251552;
					float3 temp_output_21_0_g251554 = Out_NormalOS15_g251552;
					float3 In_NormalOS16_g251554 = temp_output_21_0_g251554;
					float3 In_NormalWS16_g251554 = Out_NormalWS15_g251552;
					float3 In_NormalRawOS16_g251554 = Out_NormalRawOS15_g251552;
					float4 temp_output_6_0_g251554 = Out_TangentOS15_g251552;
					float4 In_TangentOS16_g251554 = temp_output_6_0_g251554;
					float3 In_TangentWS16_g251554 = Out_TangentWS15_g251552;
					float3 In_BitangentWS16_g251554 = Out_BitangentWS15_g251552;
					float3 In_ViewDirWS16_g251554 = Out_ViewDirWS15_g251552;
					float4 In_CoordsData16_g251554 = Out_CoordsData15_g251552;
					float4 In_VertexData16_g251554 = Out_VertexData15_g251552;
					float4 In_MasksData16_g251554 = Out_MasksData15_g251552;
					float4 In_PhaseData16_g251554 = Out_PhaseData15_g251552;
					float4 In_TransformData16_g251554 = Out_TransformData15_g251552;
					float4 In_RotationData16_g251554 = Out_RotationData15_g251552;
					float4 In_InterpolatorA16_g251554 = Out_InterpolatorA15_g251552;
					BuildModelVertData( Data16_g251554 , In_Dummy16_g251554 , In_PositionOS16_g251554 , In_PositionWS16_g251554 , In_PositionWO16_g251554 , In_PositionRawOS16_g251554 , In_PivotOS16_g251554 , In_PivotWS16_g251554 , In_PivotWO16_g251554 , In_NormalOS16_g251554 , In_NormalWS16_g251554 , In_NormalRawOS16_g251554 , In_TangentOS16_g251554 , In_TangentWS16_g251554 , In_BitangentWS16_g251554 , In_ViewDirWS16_g251554 , In_CoordsData16_g251554 , In_VertexData16_g251554 , In_MasksData16_g251554 , In_PhaseData16_g251554 , In_TransformData16_g251554 , In_RotationData16_g251554 , In_InterpolatorA16_g251554 );
					TVEModelData Data15_g251556 =(TVEModelData)Data16_g251554;
					float Out_Dummy15_g251556 = 0.0;
					float3 Out_PositionOS15_g251556 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251556 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251556 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251556 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251556 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251556 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251556 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251556 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251556 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251556 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251556 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251556 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251556 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251556 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251556 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251556 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251556 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251556 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251556 , Out_Dummy15_g251556 , Out_PositionOS15_g251556 , Out_PositionWS15_g251556 , Out_PositionWO15_g251556 , Out_PositionRawOS15_g251556 , Out_PivotOS15_g251556 , Out_PivotWS15_g251556 , Out_PivotWO15_g251556 , Out_NormalOS15_g251556 , Out_NormalWS15_g251556 , Out_NormalRawOS15_g251556 , Out_TangentOS15_g251556 , Out_TangentWS15_g251556 , Out_BitangentWS15_g251556 , Out_ViewDirWS15_g251556 , Out_CoordsData15_g251556 , Out_VertexData15_g251556 , Out_MasksData15_g251556 , Out_PhaseData15_g251556 , Out_TransformData15_g251556 , Out_RotationData15_g251556 , Out_InterpolatorA15_g251556 );
					TVEModelData Data16_g251557 =(TVEModelData)Data15_g251556;
					half Dummy317_g251555 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g251557 = Dummy317_g251555;
					float In_Dummy16_g251557 = temp_output_14_0_g251557;
					float3 temp_output_4_0_g251557 = Out_PositionOS15_g251556;
					float3 In_PositionOS16_g251557 = temp_output_4_0_g251557;
					float3 In_PositionWS16_g251557 = Out_PositionWS15_g251556;
					float3 temp_output_314_17_g251555 = Out_PositionWO15_g251556;
					float3 In_PositionWO16_g251557 = temp_output_314_17_g251555;
					float3 In_PositionRawOS16_g251557 = Out_PositionRawOS15_g251556;
					float3 In_PivotOS16_g251557 = Out_PivotOS15_g251556;
					float3 In_PivotWS16_g251557 = Out_PivotWS15_g251556;
					float3 temp_output_314_19_g251555 = Out_PivotWO15_g251556;
					float3 In_PivotWO16_g251557 = temp_output_314_19_g251555;
					float3 temp_output_21_0_g251557 = Out_NormalOS15_g251556;
					float3 In_NormalOS16_g251557 = temp_output_21_0_g251557;
					float3 In_NormalWS16_g251557 = Out_NormalWS15_g251556;
					float3 In_NormalRawOS16_g251557 = Out_NormalRawOS15_g251556;
					float4 temp_output_6_0_g251557 = Out_TangentOS15_g251556;
					float4 In_TangentOS16_g251557 = temp_output_6_0_g251557;
					float3 In_TangentWS16_g251557 = Out_TangentWS15_g251556;
					float3 In_BitangentWS16_g251557 = Out_BitangentWS15_g251556;
					float3 In_ViewDirWS16_g251557 = Out_ViewDirWS15_g251556;
					float4 In_CoordsData16_g251557 = Out_CoordsData15_g251556;
					float4 temp_output_314_29_g251555 = Out_VertexData15_g251556;
					float4 In_VertexData16_g251557 = temp_output_314_29_g251555;
					float4 In_MasksData16_g251557 = Out_MasksData15_g251556;
					float4 In_PhaseData16_g251557 = Out_PhaseData15_g251556;
					half4 Model_TransformData356_g251555 = Out_TransformData15_g251556;
					float localBuildGlobalData204_g251357 = ( 0.0 );
					TVEGlobalData Data204_g251357 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251357 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251357 = Dummy211_g251357;
					float4 temp_output_589_164_g251357 = TVE_CoatParams;
					half4 Coat_Params596_g251357 = temp_output_589_164_g251357;
					float4 In_CoatParams204_g251357 = Coat_Params596_g251357;
					float4 temp_output_203_0_g251377 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g241395 = ( 0.0 );
					TVEModelData Data26_g241395 = (TVEModelData)0;
					TVEModelData Data16_g241383 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241383 = 0.0;
					float3 In_PositionWS16_g241383 = PositionWS122_g241375;
					float3 In_PositionWO16_g241383 = PositionWO132_g241375;
					float3 In_PivotWS16_g241383 = PivotWS121_g241375;
					float3 In_PivotWO16_g241383 = PivotWO133_g241375;
					float3 In_NormalWS16_g241383 = NormalWS95_g241375;
					float3 In_TangentWS16_g241383 = TangentWS136_g241375;
					float3 In_BitangentWS16_g241383 = BiangentWS421_g241375;
					half3 NormalWS427_g241375 = NormalWS95_g241375;
					half3 localComputeTriplanarWeights427_g241375 = ComputeTriplanarWeights( NormalWS427_g241375 );
					half3 TriplanarWeights429_g241375 = localComputeTriplanarWeights427_g241375;
					float3 In_TriplanarWeights16_g241383 = TriplanarWeights429_g241375;
					float3 In_ViewDirWS16_g241383 = ViewDirWS169_g241375;
					float4 In_CoordsData16_g241383 = CoordsData398_g241375;
					float4 In_VertexData16_g241383 = VertexMasks171_g241375;
					float4 In_PhaseData16_g241383 = Phase_Data176_g241375;
					BuildModelFragData( Data16_g241383 , In_Dummy16_g241383 , In_PositionWS16_g241383 , In_PositionWO16_g241383 , In_PivotWS16_g241383 , In_PivotWO16_g241383 , In_NormalWS16_g241383 , In_TangentWS16_g241383 , In_BitangentWS16_g241383 , In_TriplanarWeights16_g241383 , In_ViewDirWS16_g241383 , In_CoordsData16_g241383 , In_VertexData16_g241383 , In_PhaseData16_g241383 );
					TVEModelData DataDefault26_g241395 = Data16_g241383;
					TVEModelData DataGeneral26_g241395 = Data16_g241383;
					TVEModelData DataBlanket26_g241395 = Data16_g241383;
					TVEModelData DataImpostor26_g241395 = Data16_g241383;
					TVEModelData Data16_g241363 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241363 = 0.0;
					float3 In_PositionWS16_g241363 = PositionWS122_g241355;
					float3 In_PositionWO16_g241363 = PositionWO132_g241355;
					float3 In_PivotWS16_g241363 = PivotWS121_g241355;
					float3 In_PivotWO16_g241363 = PivotWO133_g241355;
					float3 In_NormalWS16_g241363 = NormalWS95_g241355;
					float3 In_TangentWS16_g241363 = TangentWS136_g241355;
					float3 In_BitangentWS16_g241363 = BiangentWS421_g241355;
					half3 NormalWS427_g241355 = NormalWS95_g241355;
					half3 localComputeTriplanarWeights427_g241355 = ComputeTriplanarWeights( NormalWS427_g241355 );
					half3 TriplanarWeights429_g241355 = localComputeTriplanarWeights427_g241355;
					float3 In_TriplanarWeights16_g241363 = TriplanarWeights429_g241355;
					float3 In_ViewDirWS16_g241363 = ViewDirWS169_g241355;
					float4 In_CoordsData16_g241363 = CoordsData398_g241355;
					float4 In_VertexData16_g241363 = VertexMasks171_g241355;
					float4 In_PhaseData16_g241363 = Phase_Data176_g241355;
					BuildModelFragData( Data16_g241363 , In_Dummy16_g241363 , In_PositionWS16_g241363 , In_PositionWO16_g241363 , In_PivotWS16_g241363 , In_PivotWO16_g241363 , In_NormalWS16_g241363 , In_TangentWS16_g241363 , In_BitangentWS16_g241363 , In_TriplanarWeights16_g241363 , In_ViewDirWS16_g241363 , In_CoordsData16_g241363 , In_VertexData16_g241363 , In_PhaseData16_g241363 );
					TVEModelData DataTerrain26_g241395 = Data16_g241363;
					float Type26_g241395 = IsShaderType2672;
					{
					if (Type26_g241395 == 0 )
					{
					Data26_g241395 = DataDefault26_g241395;
					}
					else if (Type26_g241395 == 1 )
					{
					Data26_g241395 = DataGeneral26_g241395;
					}
					else if (Type26_g241395 == 2 )
					{
					Data26_g241395 = DataBlanket26_g241395;
					}
					else if (Type26_g241395 == 3 )
					{
					Data26_g241395 = DataImpostor26_g241395;
					}
					else if (Type26_g241395 == 4 )
					{
					Data26_g241395 = DataTerrain26_g241395;
					}
					}
					TVEModelData Data15_g251433 =(TVEModelData)Data26_g241395;
					float Out_Dummy15_g251433 = 0.0;
					float3 Out_PositionWS15_g251433 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251433 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251433 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251433 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251433 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251433 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251433 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251433 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251433 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251433 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251433 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251433 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251433 , Out_Dummy15_g251433 , Out_PositionWS15_g251433 , Out_PositionWO15_g251433 , Out_PivotWS15_g251433 , Out_PivotWO15_g251433 , Out_NormalWS15_g251433 , Out_TangentWS15_g251433 , Out_BitangentWS15_g251433 , Out_TriplanarWeights15_g251433 , Out_ViewDirWS15_g251433 , Out_CoordsData15_g251433 , Out_VertexData15_g251433 , Out_PhaseData15_g251433 );
					float3 Model_PositionWS497_g251357 = Out_PositionWS15_g251433;
					float2 Model_PositionWS_XZ143_g251357 = (Model_PositionWS497_g251357).xz;
					float3 Model_PivotWS498_g251357 = Out_PivotWS15_g251433;
					float2 Model_PivotWS_XZ145_g251357 = (Model_PivotWS498_g251357).xz;
					float2 lerpResult300_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251377 = lerpResult300_g251357;
					float temp_output_82_0_g251375 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251377 = temp_output_82_0_g251375;
					float4 tex2DArrayNode83_g251377 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251377).zw + ( (temp_output_203_0_g251377).xy * temp_output_81_0_g251377 ) ),temp_output_82_0_g251377), 0.0 );
					float4 appendResult210_g251377 = (float4(tex2DArrayNode83_g251377.rgb , saturate( tex2DArrayNode83_g251377.a )));
					float4 temp_output_204_0_g251377 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251377 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251377).zw + ( (temp_output_204_0_g251377).xy * temp_output_81_0_g251377 ) ),temp_output_82_0_g251377), 0.0 );
					float4 appendResult212_g251377 = (float4(tex2DArrayNode122_g251377.rgb , saturate( tex2DArrayNode122_g251377.a )));
					float4 TVE_RenderNearPositionR628_g251357 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251357 = saturate( ( distance( Model_PositionWS497_g251357 , (TVE_RenderNearPositionR628_g251357).xyz ) / (TVE_RenderNearPositionR628_g251357).w ) );
					float temp_output_7_0_g251358 = 1.0;
					float temp_output_9_0_g251358 = ( temp_output_507_0_g251357 - temp_output_7_0_g251358 );
					half TVE_RenderNearFadeValue635_g251357 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251357 = saturate( ( temp_output_9_0_g251358 / ( ( TVE_RenderNearFadeValue635_g251357 - temp_output_7_0_g251358 ) + 0.0001 ) ) );
					float4 lerpResult131_g251377 = lerp( appendResult210_g251377 , appendResult212_g251377 , Global_TexBlend509_g251357);
					float4 temp_output_159_109_g251375 = lerpResult131_g251377;
					float4 lerpResult168_g251375 = lerp( TVE_CoatParams , temp_output_159_109_g251375 , TVE_CoatLayers[(int)temp_output_82_0_g251375]);
					float4 temp_output_589_109_g251357 = lerpResult168_g251375;
					half4 Coat_Texture302_g251357 = temp_output_589_109_g251357;
					float4 In_CoatTexture204_g251357 = Coat_Texture302_g251357;
					float4 temp_output_595_164_g251357 = TVE_PaintParams;
					half4 Paint_Params575_g251357 = temp_output_595_164_g251357;
					float4 In_PaintParams204_g251357 = Paint_Params575_g251357;
					float4 temp_output_203_0_g251426 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251426 = lerpResult85_g251357;
					float temp_output_82_0_g251423 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251426 = temp_output_82_0_g251423;
					float4 tex2DArrayNode83_g251426 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251426).zw + ( (temp_output_203_0_g251426).xy * temp_output_81_0_g251426 ) ),temp_output_82_0_g251426), 0.0 );
					float4 appendResult210_g251426 = (float4(tex2DArrayNode83_g251426.rgb , saturate( tex2DArrayNode83_g251426.a )));
					float4 temp_output_204_0_g251426 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251426 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251426).zw + ( (temp_output_204_0_g251426).xy * temp_output_81_0_g251426 ) ),temp_output_82_0_g251426), 0.0 );
					float4 appendResult212_g251426 = (float4(tex2DArrayNode122_g251426.rgb , saturate( tex2DArrayNode122_g251426.a )));
					float4 lerpResult131_g251426 = lerp( appendResult210_g251426 , appendResult212_g251426 , Global_TexBlend509_g251357);
					float4 temp_output_171_109_g251423 = lerpResult131_g251426;
					float4 lerpResult174_g251423 = lerp( TVE_PaintParams , temp_output_171_109_g251423 , TVE_PaintLayers[(int)temp_output_82_0_g251423]);
					float4 temp_output_595_109_g251357 = lerpResult174_g251423;
					half4 Paint_Texture71_g251357 = temp_output_595_109_g251357;
					float4 In_PaintTexture204_g251357 = Paint_Texture71_g251357;
					float4 temp_output_590_141_g251357 = TVE_AtmoParams;
					half4 Atmo_Params601_g251357 = temp_output_590_141_g251357;
					float4 In_AtmoParams204_g251357 = Atmo_Params601_g251357;
					float4 temp_output_203_0_g251385 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251385 = lerpResult104_g251357;
					float temp_output_132_0_g251383 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251385 = temp_output_132_0_g251383;
					float4 tex2DArrayNode83_g251385 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251385).zw + ( (temp_output_203_0_g251385).xy * temp_output_81_0_g251385 ) ),temp_output_82_0_g251385), 0.0 );
					float4 appendResult210_g251385 = (float4(tex2DArrayNode83_g251385.rgb , saturate( tex2DArrayNode83_g251385.a )));
					float4 temp_output_204_0_g251385 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251385 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251385).zw + ( (temp_output_204_0_g251385).xy * temp_output_81_0_g251385 ) ),temp_output_82_0_g251385), 0.0 );
					float4 appendResult212_g251385 = (float4(tex2DArrayNode122_g251385.rgb , saturate( tex2DArrayNode122_g251385.a )));
					float4 lerpResult131_g251385 = lerp( appendResult210_g251385 , appendResult212_g251385 , Global_TexBlend509_g251357);
					float4 temp_output_137_109_g251383 = lerpResult131_g251385;
					float4 lerpResult145_g251383 = lerp( TVE_AtmoParams , temp_output_137_109_g251383 , TVE_AtmoLayers[(int)temp_output_132_0_g251383]);
					float4 temp_output_590_110_g251357 = lerpResult145_g251383;
					half4 Atmo_Texture80_g251357 = temp_output_590_110_g251357;
					float4 In_AtmoTexture204_g251357 = Atmo_Texture80_g251357;
					float4 temp_output_593_163_g251357 = TVE_GlowParams;
					half4 Glow_Params609_g251357 = temp_output_593_163_g251357;
					float4 In_GlowParams204_g251357 = Glow_Params609_g251357;
					float4 temp_output_203_0_g251401 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251401 = lerpResult247_g251357;
					float temp_output_82_0_g251399 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251401 = temp_output_82_0_g251399;
					float4 tex2DArrayNode83_g251401 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251401).zw + ( (temp_output_203_0_g251401).xy * temp_output_81_0_g251401 ) ),temp_output_82_0_g251401), 0.0 );
					float4 appendResult210_g251401 = (float4(tex2DArrayNode83_g251401.rgb , saturate( tex2DArrayNode83_g251401.a )));
					float4 temp_output_204_0_g251401 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251401 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251401).zw + ( (temp_output_204_0_g251401).xy * temp_output_81_0_g251401 ) ),temp_output_82_0_g251401), 0.0 );
					float4 appendResult212_g251401 = (float4(tex2DArrayNode122_g251401.rgb , saturate( tex2DArrayNode122_g251401.a )));
					float4 lerpResult131_g251401 = lerp( appendResult210_g251401 , appendResult212_g251401 , Global_TexBlend509_g251357);
					float4 temp_output_159_109_g251399 = lerpResult131_g251401;
					float4 lerpResult167_g251399 = lerp( TVE_GlowParams , temp_output_159_109_g251399 , TVE_GlowLayers[(int)temp_output_82_0_g251399]);
					float4 temp_output_593_109_g251357 = lerpResult167_g251399;
					half4 Glow_Texture248_g251357 = temp_output_593_109_g251357;
					float4 In_GlowTexture204_g251357 = Glow_Texture248_g251357;
					float4 temp_output_592_139_g251357 = TVE_FormParams;
					float4 Form_Params606_g251357 = temp_output_592_139_g251357;
					float4 In_FormParams204_g251357 = Form_Params606_g251357;
					float4 temp_output_203_0_g251417 = TVE_FormBaseCoord;
					float2 lerpResult168_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251417 = lerpResult168_g251357;
					float temp_output_130_0_g251415 = _GlobalFormLayerValue;
					float temp_output_82_0_g251417 = temp_output_130_0_g251415;
					float4 tex2DArrayNode83_g251417 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251417).zw + ( (temp_output_203_0_g251417).xy * temp_output_81_0_g251417 ) ),temp_output_82_0_g251417), 0.0 );
					float4 appendResult210_g251417 = (float4(tex2DArrayNode83_g251417.rgb , saturate( tex2DArrayNode83_g251417.a )));
					float4 temp_output_204_0_g251417 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251417 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251417).zw + ( (temp_output_204_0_g251417).xy * temp_output_81_0_g251417 ) ),temp_output_82_0_g251417), 0.0 );
					float4 appendResult212_g251417 = (float4(tex2DArrayNode122_g251417.rgb , saturate( tex2DArrayNode122_g251417.a )));
					float4 lerpResult131_g251417 = lerp( appendResult210_g251417 , appendResult212_g251417 , Global_TexBlend509_g251357);
					float4 temp_output_135_109_g251415 = lerpResult131_g251417;
					float4 lerpResult143_g251415 = lerp( TVE_FormParams , temp_output_135_109_g251415 , TVE_FormLayers[(int)temp_output_130_0_g251415]);
					float4 temp_output_592_0_g251357 = lerpResult143_g251415;
					float4 Form_Texture112_g251357 = temp_output_592_0_g251357;
					float4 In_FormTexture204_g251357 = Form_Texture112_g251357;
					float4 temp_output_594_145_g251357 = TVE_FlowParams;
					half4 Flow_Params612_g251357 = temp_output_594_145_g251357;
					float4 In_FlowParams204_g251357 = Flow_Params612_g251357;
					float4 temp_output_203_0_g251409 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251357 = lerp( Model_PositionWS_XZ143_g251357 , Model_PivotWS_XZ145_g251357 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251409 = lerpResult400_g251357;
					float temp_output_136_0_g251407 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251409 = temp_output_136_0_g251407;
					float4 tex2DArrayNode83_g251409 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251409).zw + ( (temp_output_203_0_g251409).xy * temp_output_81_0_g251409 ) ),temp_output_82_0_g251409), 0.0 );
					float4 appendResult210_g251409 = (float4(tex2DArrayNode83_g251409.rgb , saturate( tex2DArrayNode83_g251409.a )));
					float4 temp_output_204_0_g251409 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251409 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251409).zw + ( (temp_output_204_0_g251409).xy * temp_output_81_0_g251409 ) ),temp_output_82_0_g251409), 0.0 );
					float4 appendResult212_g251409 = (float4(tex2DArrayNode122_g251409.rgb , saturate( tex2DArrayNode122_g251409.a )));
					float4 lerpResult131_g251409 = lerp( appendResult210_g251409 , appendResult212_g251409 , Global_TexBlend509_g251357);
					float4 temp_output_141_109_g251407 = lerpResult131_g251409;
					float4 lerpResult149_g251407 = lerp( TVE_FlowParams , temp_output_141_109_g251407 , TVE_FlowLayers[(int)temp_output_136_0_g251407]);
					half4 Flow_Texture405_g251357 = lerpResult149_g251407;
					float4 In_FlowTexture204_g251357 = Flow_Texture405_g251357;
					BuildGlobalData( Data204_g251357 , In_Dummy204_g251357 , In_CoatParams204_g251357 , In_CoatTexture204_g251357 , In_PaintParams204_g251357 , In_PaintTexture204_g251357 , In_AtmoParams204_g251357 , In_AtmoTexture204_g251357 , In_GlowParams204_g251357 , In_GlowTexture204_g251357 , In_FormParams204_g251357 , In_FormTexture204_g251357 , In_FlowParams204_g251357 , In_FlowTexture204_g251357 );
					TVEGlobalData Data15_g251558 =(TVEGlobalData)Data204_g251357;
					float Out_Dummy15_g251558 = 0.0;
					float4 Out_CoatParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251558 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251558 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251558 = float4( 0,0,0,0 );
					BreakData( Data15_g251558 , Out_Dummy15_g251558 , Out_CoatParams15_g251558 , Out_CoatTexture15_g251558 , Out_PaintParams15_g251558 , Out_PaintTexture15_g251558 , Out_AtmoParams15_g251558 , Out_AtmoTexture15_g251558 , Out_GlowParams15_g251558 , Out_GlowTexture15_g251558 , Out_FormParams15_g251558 , Out_FormTexture15_g251558 , Out_FlowParams15_g251558 , Out_FlowTexture15_g251558 );
					float4 Global_FormTexture351_g251555 = Out_FormTexture15_g251558;
					float3 Model_PivotWO353_g251555 = temp_output_314_19_g251555;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251564 = _ConformMeshMode;
					float Option70_g251564 = temp_output_17_0_g251564;
					half4 Model_VertexData357_g251555 = temp_output_314_29_g251555;
					float4 temp_output_3_0_g251564 = Model_VertexData357_g251555;
					float4 Channel70_g251564 = temp_output_3_0_g251564;
					float localSwitchChannel470_g251564 = SwitchChannel4( Option70_g251564 , Channel70_g251564 );
					float temp_output_390_0_g251555 = localSwitchChannel470_g251564;
					float temp_output_7_0_g251561 = _ConformMeshRemap.x;
					float temp_output_9_0_g251561 = ( temp_output_390_0_g251555 - temp_output_7_0_g251561 );
					float lerpResult374_g251555 = lerp( 1.0 , saturate( ( temp_output_9_0_g251561 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251555 = lerpResult374_g251555;
					float temp_output_328_0_g251555 = ( Blend_VertMask379_g251555 * TVE_IsEnabled );
					half Conform_Mask366_g251555 = temp_output_328_0_g251555;
					float temp_output_322_0_g251555 = ( ( ( ( (Global_FormTexture351_g251555).z - ( (Model_PivotWO353_g251555).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251555 ) );
					float3 appendResult329_g251555 = (float3(0.0 , temp_output_322_0_g251555 , 0.0));
					float3 appendResult387_g251555 = (float3(0.0 , 0.0 , temp_output_322_0_g251555));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251562 = appendResult387_g251555;
					#else
					float3 staticSwitch65_g251562 = appendResult329_g251555;
					#endif
					float3 Blanket_Conform368_g251555 = staticSwitch65_g251562;
					float4 appendResult312_g251555 = (float4(Blanket_Conform368_g251555 , 0.0));
					float4 temp_output_310_0_g251555 = ( Model_TransformData356_g251555 + appendResult312_g251555 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251555 = temp_output_310_0_g251555;
					#else
					float4 staticSwitch364_g251555 = Model_TransformData356_g251555;
					#endif
					half4 Final_TransformData365_g251555 = staticSwitch364_g251555;
					float4 In_TransformData16_g251557 = Final_TransformData365_g251555;
					float4 In_RotationData16_g251557 = Out_RotationData15_g251556;
					float4 In_InterpolatorA16_g251557 = Out_InterpolatorA15_g251556;
					BuildModelVertData( Data16_g251557 , In_Dummy16_g251557 , In_PositionOS16_g251557 , In_PositionWS16_g251557 , In_PositionWO16_g251557 , In_PositionRawOS16_g251557 , In_PivotOS16_g251557 , In_PivotWS16_g251557 , In_PivotWO16_g251557 , In_NormalOS16_g251557 , In_NormalWS16_g251557 , In_NormalRawOS16_g251557 , In_TangentOS16_g251557 , In_TangentWS16_g251557 , In_BitangentWS16_g251557 , In_ViewDirWS16_g251557 , In_CoordsData16_g251557 , In_VertexData16_g251557 , In_MasksData16_g251557 , In_PhaseData16_g251557 , In_TransformData16_g251557 , In_RotationData16_g251557 , In_InterpolatorA16_g251557 );
					TVEModelData Data15_g251571 =(TVEModelData)Data16_g251557;
					float Out_Dummy15_g251571 = 0.0;
					float3 Out_PositionOS15_g251571 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251571 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251571 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251571 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251571 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251571 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251571 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251571 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251571 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251571 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251571 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251571 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251571 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251571 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251571 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251571 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251571 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251571 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251571 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251571 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251571 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251571 , Out_Dummy15_g251571 , Out_PositionOS15_g251571 , Out_PositionWS15_g251571 , Out_PositionWO15_g251571 , Out_PositionRawOS15_g251571 , Out_PivotOS15_g251571 , Out_PivotWS15_g251571 , Out_PivotWO15_g251571 , Out_NormalOS15_g251571 , Out_NormalWS15_g251571 , Out_NormalRawOS15_g251571 , Out_TangentOS15_g251571 , Out_TangentWS15_g251571 , Out_BitangentWS15_g251571 , Out_ViewDirWS15_g251571 , Out_CoordsData15_g251571 , Out_VertexData15_g251571 , Out_MasksData15_g251571 , Out_PhaseData15_g251571 , Out_TransformData15_g251571 , Out_RotationData15_g251571 , Out_InterpolatorA15_g251571 );
					TVEModelData Data16_g251572 =(TVEModelData)Data15_g251571;
					float temp_output_14_0_g251572 = 0.0;
					float In_Dummy16_g251572 = temp_output_14_0_g251572;
					float3 Model_PositionOS147_g251570 = Out_PositionOS15_g251571;
					half3 VertexPos40_g251576 = Model_PositionOS147_g251570;
					float4 temp_output_1567_33_g251570 = Out_RotationData15_g251571;
					half4 Model_RotationData1569_g251570 = temp_output_1567_33_g251570;
					float2 break1582_g251570 = (Model_RotationData1569_g251570).xy;
					half Angle44_g251576 = break1582_g251570.y;
					half CosAngle89_g251576 = cos( Angle44_g251576 );
					half SinAngle93_g251576 = sin( Angle44_g251576 );
					float3 appendResult95_g251576 = (float3((VertexPos40_g251576).x , ( ( (VertexPos40_g251576).y * CosAngle89_g251576 ) - ( (VertexPos40_g251576).z * SinAngle93_g251576 ) ) , ( ( (VertexPos40_g251576).y * SinAngle93_g251576 ) + ( (VertexPos40_g251576).z * CosAngle89_g251576 ) )));
					half3 VertexPos40_g251577 = appendResult95_g251576;
					half Angle44_g251577 = -break1582_g251570.x;
					half CosAngle94_g251577 = cos( Angle44_g251577 );
					half SinAngle95_g251577 = sin( Angle44_g251577 );
					float3 appendResult98_g251577 = (float3(( ( (VertexPos40_g251577).x * CosAngle94_g251577 ) - ( (VertexPos40_g251577).y * SinAngle95_g251577 ) ) , ( ( (VertexPos40_g251577).x * SinAngle95_g251577 ) + ( (VertexPos40_g251577).y * CosAngle94_g251577 ) ) , (VertexPos40_g251577).z));
					half3 VertexPos40_g251575 = Model_PositionOS147_g251570;
					half Angle44_g251575 = break1582_g251570.y;
					half CosAngle89_g251575 = cos( Angle44_g251575 );
					half SinAngle93_g251575 = sin( Angle44_g251575 );
					float3 appendResult95_g251575 = (float3((VertexPos40_g251575).x , ( ( (VertexPos40_g251575).y * CosAngle89_g251575 ) - ( (VertexPos40_g251575).z * SinAngle93_g251575 ) ) , ( ( (VertexPos40_g251575).y * SinAngle93_g251575 ) + ( (VertexPos40_g251575).z * CosAngle89_g251575 ) )));
					half3 VertexPos40_g251580 = appendResult95_g251575;
					half Angle44_g251580 = break1582_g251570.x;
					half CosAngle91_g251580 = cos( Angle44_g251580 );
					half SinAngle92_g251580 = sin( Angle44_g251580 );
					float3 appendResult93_g251580 = (float3(( ( (VertexPos40_g251580).x * CosAngle91_g251580 ) + ( (VertexPos40_g251580).z * SinAngle92_g251580 ) ) , (VertexPos40_g251580).y , ( ( -(VertexPos40_g251580).x * SinAngle92_g251580 ) + ( (VertexPos40_g251580).z * CosAngle91_g251580 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251578 = appendResult93_g251580;
					#else
					float3 staticSwitch65_g251578 = appendResult98_g251577;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251573 = staticSwitch65_g251578;
					#else
					float3 staticSwitch65_g251573 = Model_PositionOS147_g251570;
					#endif
					float3 temp_output_1608_0_g251570 = staticSwitch65_g251573;
					half3 VertexPos40_g251579 = temp_output_1608_0_g251570;
					half Angle44_g251579 = (Model_RotationData1569_g251570).z;
					half CosAngle91_g251579 = cos( Angle44_g251579 );
					half SinAngle92_g251579 = sin( Angle44_g251579 );
					float3 appendResult93_g251579 = (float3(( ( (VertexPos40_g251579).x * CosAngle91_g251579 ) + ( (VertexPos40_g251579).z * SinAngle92_g251579 ) ) , (VertexPos40_g251579).y , ( ( -(VertexPos40_g251579).x * SinAngle92_g251579 ) + ( (VertexPos40_g251579).z * CosAngle91_g251579 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251574 = appendResult93_g251579;
					#else
					float3 staticSwitch65_g251574 = temp_output_1608_0_g251570;
					#endif
					float4 temp_output_1567_31_g251570 = Out_TransformData15_g251571;
					half4 Model_TransformData1568_g251570 = temp_output_1567_31_g251570;
					half3 Final_PositionOS178_g251570 = ( ( staticSwitch65_g251574 * (Model_TransformData1568_g251570).w ) + (Model_TransformData1568_g251570).xyz );
					float3 temp_output_4_0_g251572 = Final_PositionOS178_g251570;
					float3 In_PositionOS16_g251572 = temp_output_4_0_g251572;
					float3 In_PositionWS16_g251572 = Out_PositionWS15_g251571;
					float3 In_PositionWO16_g251572 = Out_PositionWO15_g251571;
					float3 In_PositionRawOS16_g251572 = Out_PositionRawOS15_g251571;
					float3 In_PivotOS16_g251572 = Out_PivotOS15_g251571;
					float3 In_PivotWS16_g251572 = Out_PivotWS15_g251571;
					float3 In_PivotWO16_g251572 = Out_PivotWO15_g251571;
					float3 temp_output_21_0_g251572 = Out_NormalOS15_g251571;
					float3 In_NormalOS16_g251572 = temp_output_21_0_g251572;
					float3 In_NormalWS16_g251572 = Out_NormalWS15_g251571;
					float3 In_NormalRawOS16_g251572 = Out_NormalRawOS15_g251571;
					float4 temp_output_6_0_g251572 = Out_TangentOS15_g251571;
					float4 In_TangentOS16_g251572 = temp_output_6_0_g251572;
					float3 In_TangentWS16_g251572 = Out_TangentWS15_g251571;
					float3 In_BitangentWS16_g251572 = Out_BitangentWS15_g251571;
					float3 In_ViewDirWS16_g251572 = Out_ViewDirWS15_g251571;
					float4 In_CoordsData16_g251572 = Out_CoordsData15_g251571;
					float4 In_VertexData16_g251572 = Out_VertexData15_g251571;
					float4 In_MasksData16_g251572 = Out_MasksData15_g251571;
					float4 In_PhaseData16_g251572 = Out_PhaseData15_g251571;
					float4 In_TransformData16_g251572 = temp_output_1567_31_g251570;
					float4 In_RotationData16_g251572 = temp_output_1567_33_g251570;
					float4 In_InterpolatorA16_g251572 = Out_InterpolatorA15_g251571;
					BuildModelVertData( Data16_g251572 , In_Dummy16_g251572 , In_PositionOS16_g251572 , In_PositionWS16_g251572 , In_PositionWO16_g251572 , In_PositionRawOS16_g251572 , In_PivotOS16_g251572 , In_PivotWS16_g251572 , In_PivotWO16_g251572 , In_NormalOS16_g251572 , In_NormalWS16_g251572 , In_NormalRawOS16_g251572 , In_TangentOS16_g251572 , In_TangentWS16_g251572 , In_BitangentWS16_g251572 , In_ViewDirWS16_g251572 , In_CoordsData16_g251572 , In_VertexData16_g251572 , In_MasksData16_g251572 , In_PhaseData16_g251572 , In_TransformData16_g251572 , In_RotationData16_g251572 , In_InterpolatorA16_g251572 );
					TVEModelData Data15_g251582 =(TVEModelData)Data16_g251572;
					float Out_Dummy15_g251582 = 0.0;
					float3 Out_PositionOS15_g251582 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251582 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251582 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251582 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251582 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251582 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251582 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251582 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251582 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251582 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251582 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251582 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251582 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251582 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251582 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251582 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251582 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251582 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251582 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251582 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251582 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251582 , Out_Dummy15_g251582 , Out_PositionOS15_g251582 , Out_PositionWS15_g251582 , Out_PositionWO15_g251582 , Out_PositionRawOS15_g251582 , Out_PivotOS15_g251582 , Out_PivotWS15_g251582 , Out_PivotWO15_g251582 , Out_NormalOS15_g251582 , Out_NormalWS15_g251582 , Out_NormalRawOS15_g251582 , Out_TangentOS15_g251582 , Out_TangentWS15_g251582 , Out_BitangentWS15_g251582 , Out_ViewDirWS15_g251582 , Out_CoordsData15_g251582 , Out_VertexData15_g251582 , Out_MasksData15_g251582 , Out_PhaseData15_g251582 , Out_TransformData15_g251582 , Out_RotationData15_g251582 , Out_InterpolatorA15_g251582 );
					TVEModelData Data16_g251583 =(TVEModelData)Data15_g251582;
					float temp_output_14_0_g251583 = 0.0;
					float In_Dummy16_g251583 = temp_output_14_0_g251583;
					float3 temp_output_217_24_g251581 = Out_PivotOS15_g251582;
					float3 temp_output_216_0_g251581 = ( Out_PositionOS15_g251582 + temp_output_217_24_g251581 );
					float3 temp_output_4_0_g251583 = temp_output_216_0_g251581;
					float3 In_PositionOS16_g251583 = temp_output_4_0_g251583;
					float3 In_PositionWS16_g251583 = Out_PositionWS15_g251582;
					float3 In_PositionWO16_g251583 = Out_PositionWO15_g251582;
					float3 In_PositionRawOS16_g251583 = Out_PositionRawOS15_g251582;
					float3 In_PivotOS16_g251583 = temp_output_217_24_g251581;
					float3 In_PivotWS16_g251583 = Out_PivotWS15_g251582;
					float3 In_PivotWO16_g251583 = Out_PivotWO15_g251582;
					float3 temp_output_21_0_g251583 = Out_NormalOS15_g251582;
					float3 In_NormalOS16_g251583 = temp_output_21_0_g251583;
					float3 In_NormalWS16_g251583 = Out_NormalWS15_g251582;
					float3 In_NormalRawOS16_g251583 = Out_NormalRawOS15_g251582;
					float4 temp_output_6_0_g251583 = Out_TangentOS15_g251582;
					float4 In_TangentOS16_g251583 = temp_output_6_0_g251583;
					float3 In_TangentWS16_g251583 = Out_TangentWS15_g251582;
					float3 In_BitangentWS16_g251583 = Out_BitangentWS15_g251582;
					float3 In_ViewDirWS16_g251583 = Out_ViewDirWS15_g251582;
					float4 In_CoordsData16_g251583 = Out_CoordsData15_g251582;
					float4 In_VertexData16_g251583 = Out_VertexData15_g251582;
					float4 In_MasksData16_g251583 = Out_MasksData15_g251582;
					float4 In_PhaseData16_g251583 = Out_PhaseData15_g251582;
					float4 In_TransformData16_g251583 = Out_TransformData15_g251582;
					float4 In_RotationData16_g251583 = Out_RotationData15_g251582;
					float4 In_InterpolatorA16_g251583 = Out_InterpolatorA15_g251582;
					BuildModelVertData( Data16_g251583 , In_Dummy16_g251583 , In_PositionOS16_g251583 , In_PositionWS16_g251583 , In_PositionWO16_g251583 , In_PositionRawOS16_g251583 , In_PivotOS16_g251583 , In_PivotWS16_g251583 , In_PivotWO16_g251583 , In_NormalOS16_g251583 , In_NormalWS16_g251583 , In_NormalRawOS16_g251583 , In_TangentOS16_g251583 , In_TangentWS16_g251583 , In_BitangentWS16_g251583 , In_ViewDirWS16_g251583 , In_CoordsData16_g251583 , In_VertexData16_g251583 , In_MasksData16_g251583 , In_PhaseData16_g251583 , In_TransformData16_g251583 , In_RotationData16_g251583 , In_InterpolatorA16_g251583 );
					TVEModelData Data15_g251592 =(TVEModelData)Data16_g251583;
					float Out_Dummy15_g251592 = 0.0;
					float3 Out_PositionOS15_g251592 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251592 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251592 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251592 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251592 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251592 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251592 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251592 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251592 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251592 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251592 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251592 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251592 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251592 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251592 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251592 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251592 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251592 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251592 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251592 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251592 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251592 , Out_Dummy15_g251592 , Out_PositionOS15_g251592 , Out_PositionWS15_g251592 , Out_PositionWO15_g251592 , Out_PositionRawOS15_g251592 , Out_PivotOS15_g251592 , Out_PivotWS15_g251592 , Out_PivotWO15_g251592 , Out_NormalOS15_g251592 , Out_NormalWS15_g251592 , Out_NormalRawOS15_g251592 , Out_TangentOS15_g251592 , Out_TangentWS15_g251592 , Out_BitangentWS15_g251592 , Out_ViewDirWS15_g251592 , Out_CoordsData15_g251592 , Out_VertexData15_g251592 , Out_MasksData15_g251592 , Out_PhaseData15_g251592 , Out_TransformData15_g251592 , Out_RotationData15_g251592 , Out_InterpolatorA15_g251592 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251592;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251592;
					v.tangent = Out_TangentOS15_g251592;

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

				VertexControl vert ( appdata v )
				{
					VertexControl o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_TRANSFER_INSTANCE_ID(v, o);
					o.vertex = v.vertex;
					o.normal = v.normal;
					o.ase_texcoord3 = v.ase_texcoord3;
					o.ase_texcoord = v.ase_texcoord;
					o.ase_texcoord2 = v.ase_texcoord2;
					o.ase_color = v.ase_color;
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
					o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
					o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
					o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
					o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
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
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2666;-7552,-5376;Inherit;False;Property;_IsShaderType;_IsShaderType;76;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2672;-7360,-5376;Half;False;IsShaderType;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2667;-7552,-4864;Inherit;False;Block Model;63;;241355;7ad7765e793a6714babedee0033c36e9;18,404,0,437,0,431,0,240,0,290,0,289,0,291,0,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0;11;102;FLOAT3;0,0,0;False;163;FLOAT3;0,0,0;False;186;FLOAT3;0,0,0;False;187;FLOAT3;0,0,0;False;166;FLOAT3;0,0,0;False;164;FLOAT3;0,0,0;False;301;FLOAT3;0,0,0;False;418;FLOAT3;0,0,0;False;167;FLOAT4;0,0,0,0;False;172;FLOAT4;0,0,0,0;False;175;FLOAT4;0,0,0,0;False;2;OBJECT;128;OBJECT;314
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2668;-7552,-4736;Inherit;False;2672;IsShaderType;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2669;-7552,-4992;Inherit;False;Block Model;63;;241375;7ad7765e793a6714babedee0033c36e9;18,404,1,437,1,431,1,240,1,290,1,289,1,291,1,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0;11;102;FLOAT3;0,0,0;False;163;FLOAT3;0,0,0;False;186;FLOAT3;0,0,0;False;187;FLOAT3;0,0,0;False;166;FLOAT3;0,0,0;False;164;FLOAT3;0,0,0;False;301;FLOAT3;0,0,0;False;418;FLOAT3;0,0,0;False;167;FLOAT4;0,0,0,0;False;172;FLOAT4;0,0,0,0;False;175;FLOAT4;0,0,0,0;False;2;OBJECT;128;OBJECT;314
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2670;-7168,-4736;Inherit;False;If Model Data;-1;;241395;d269c9c511ff160419055604aade1e70;1,32,1;9;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;33;OBJECT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2373;-6848,-4736;Half;False;Model Frag;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2379;-3200,-4992;Inherit;False;2373;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2374;-6400,-4992;Inherit;False;2373;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2380;-2944,-4992;Inherit;False;Block Main;141;;241396;b04cfed9a7b4c0841afdb49a38c282c5;12,65,1,136,1,41,1,133,1,40,1,329,1,344,0,347,0,342,0,345,0,346,0,343,0;1;225;OBJECT;0,0,0,0;False;1;OBJECT;106
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2375;-6144,-4992;Inherit;False;Block Global;82;;251357;212e17d4006dc88449d56ce0340cb5ff;32,308,1,560,1,276,1,285,1,402,1,385,1,283,1,282,1,396,1,417,1,484,0,485,0,486,0,487,0,561,0,482,0,488,0,483,0,315,1,598,0,311,1,578,0,317,1,603,0,604,0,607,0,421,1,321,1,398,1,413,0,557,1,404,1;1;206;OBJECT;0,0,0,0;False;1;OBJECT;151
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2454;-2624,-4992;Half;False;Visual Data;-1;True;1;0;OBJECT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2505;-5824,-4992;Half;False;Global Data;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2600;-1920,-4992;Inherit;False;2454;Visual Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2507;-1920,-4864;Inherit;False;2505;Global Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2508;-1920,-4928;Inherit;False;2373;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2620;-1600,-4736;Half;False;Global;TVE_DEBUG_Global;TVE_DEBUG_Global;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2654;-1664,-4992;Inherit;False;Block Overlay;7;;251434;8ae9c8285a7817844a51243251284d21;38,813,1,991,1,1061,1,987,1,992,1,819,1,821,1,1114,0,1111,0,1078,0,1066,0,1064,0,1067,0,1079,0,1065,0,1105,1,1104,0,1182,1,1101,0,1103,0,1097,0,1100,0,1102,0,942,0,940,0,1090,0,1089,0,944,0,826,1,828,1,823,1,1013,1,1018,0,1010,0,1034,0,1033,0,844,0,447,0;4;572;OBJECT;0,0,0,0;False;596;OBJECT;0,0,0,0;False;600;OBJECT;0,0,0,0;False;445;FLOAT;1;False;2;OBJECT;566;OBJECT;973
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2655;-1664,-4864;Inherit;False;Block Overlay;7;;251487;8ae9c8285a7817844a51243251284d21;38,813,1,991,1,1061,1,987,1,992,1,819,1,821,1,1114,0,1111,0,1078,0,1066,0,1064,0,1067,0,1079,0,1065,0,1105,1,1104,0,1182,1,1101,0,1103,0,1097,0,1100,0,1102,0,942,1,940,1,1090,0,1089,0,944,0,826,1,828,1,823,1,1013,1,1018,0,1010,0,1034,0,1033,0,844,0,447,0;4;572;OBJECT;0,0,0,0;False;596;OBJECT;0,0,0,0;False;600;OBJECT;0,0,0,0;False;445;FLOAT;1;False;2;OBJECT;566;OBJECT;973
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2671;-7168,-4992;Inherit;False;If Model Data;-1;;251540;d269c9c511ff160419055604aade1e70;1,32,1;9;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;33;OBJECT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2619;-1280,-4992;Inherit;False;If Masks Data;-1;;251541;8077f199aa3992c4b8c999410c1ede62;1,32,0;8;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;28;OBJECT;0;False;27;OBJECT;0;False;30;OBJECT;0;False;31;OBJECT;0;False;29;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2377;-6848,-4992;Half;False;Model Vert;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2509;-1024,-4992;Inherit;False;Break Masks Data;-1;;251542;23311522ecc97b54e8b77d849401069d;0;1;6;OBJECT;0;False;8;FLOAT4;14;FLOAT4;0;FLOAT4;23;FLOAT4;5;FLOAT4;24;FLOAT4;25;FLOAT4;26;FLOAT4;27
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2656;-5376,-4992;Inherit;False;2377;Model Vert;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2567;-256,-4864;Inherit;False;FLOAT;0;0;0;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2569;-256,-4608;Inherit;False;FLOAT;1;0;0;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2608;-256,-3696;Inherit;False;FLOAT;3;0;0;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2604;-256,-4352;Inherit;False;FLOAT;2;0;0;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2646;-256,-4992;Inherit;False;Tool Debug Active;77;;251543;0bb5baa3fd5a859489bbfc09acf77496;0;2;80;FLOAT3;0,0,0;False;102;FLOAT;0;False;2;FLOAT3;108;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2647;-256,-4736;Inherit;False;Tool Debug Active;77;;251545;0bb5baa3fd5a859489bbfc09acf77496;0;2;80;FLOAT3;0,0,0;False;102;FLOAT;0;False;2;FLOAT3;108;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2648;-256,-4480;Inherit;False;Tool Debug Active;77;;251547;0bb5baa3fd5a859489bbfc09acf77496;0;2;80;FLOAT3;0,0,0;False;102;FLOAT;0;False;2;FLOAT3;108;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2649;-256,-3824;Inherit;False;Tool Debug Active;77;;251549;0bb5baa3fd5a859489bbfc09acf77496;0;2;80;FLOAT3;0,0,0;False;102;FLOAT;0;False;2;FLOAT3;108;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2657;-5120,-4992;Inherit;False;Block Pivots Sub;-1;;251551;186f08b1bbe15894d9c677d50398679b;0;1;146;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2658;-5120,-4864;Inherit;False;2505;Global Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2568;0,-4992;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2571;0,-4736;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2603;0,-4480;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2607;0,-3824;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2610;-256,-4096;Inherit;False;FLOAT3;0;0;0;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2659;-4736,-4992;Inherit;False;Block Blanket Conform;166;;251555;3ce1684c4351aeb42b79a955aa483301;2,389,0,377,1;2;146;OBJECT;0,0,0,0;False;186;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2594;384,-4992;Inherit;False;Tool Debug Index;-1;;251565;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2592;384,-4736;Inherit;False;Tool Debug Index;-1;;251566;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2605;384,-4480;Inherit;False;Tool Debug Index;-1;;251567;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;2;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2609;384,-3824;Inherit;False;Tool Debug Index;-1;;251568;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;6;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2611;384,-4096;Inherit;False;Tool Debug Index;-1;;251569;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;4;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2665;-4352,-4992;Inherit;False;Block Transform;-1;;251570;5ac6202bdddd8b34a85c261af6b8de8b;0;1;146;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2550;768,-4992;Inherit;False;5;5;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2660;-3968,-4992;Inherit;False;Block Pivots Add;-1;;251581;016babe9e3e643242aa4d123a988150c;0;1;146;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2399;1088,-4992;Half;False;Final_Debug;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2661;-3648,-4992;Half;False;Model Data;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2400;2048,-4992;Inherit;False;2399;Final_Debug;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2563;2048,-4928;Inherit;False;2454;Visual Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2555;2048,-4864;Inherit;False;2661;Model Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.ConditionalIfNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1774;-880,2944;Inherit;False;True;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1803;-1344,2944;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1772;-1088,3072;Float;False;Constant;_Float3;Float 3;31;0;Create;True;0;0;0;False;0;False;24;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1843;-1632,2944;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1771;-1088,2944;Inherit;False;-1;;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1800;-1472,2944;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1804;-1792,2944;Inherit;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2203;2688,-5120;Inherit;False;Base Compile;-1;;251585;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2664;2304,-4992;Inherit;False;Tool Debug Color;0;;251586;d992d3ed4a7539141ba053d3e0c12277;0;3;80;FLOAT3;0,0,0;False;106;OBJECT;0,0,0;False;107;OBJECT;0,0,0;False;5;FLOAT;114;FLOAT3;0;FLOAT3;113;FLOAT3;148;FLOAT4;149
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2355;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2356;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2357;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2358;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2353;2304,-4992;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ExtraPrePass;0;0;ExtraPrePass;5;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2354;2688,-4992;Float;False;True;-1;3;;0;3;Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Overlay;28cd5599e02859647ae1798e4fcaef6c;True;ForwardBase;0;1;ForwardBase;15;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;40;Category;0;0;Workflow;0;638874882197810641;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;0;638874603607655403;Deferred Pass;1;0;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;638814711411603618;Receive Shadows;0;638814711415148256;Receive Specular;0;638814711419031593;GPU Instancing;1;638874881145939632;LOD CrossFade;0;638814711429956434;Built-in Fog;0;638814711441065168;Ambient Light;0;638814711449050123;Meta Pass;0;638814711456998358;Add Pass;0;638814711466594157;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;638874882298697380;Vertex Position;0;638874601191422915;0;8;False;True;False;True;False;False;True;True;False;;True;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2673;2688,-4932;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2674;2688,-4992;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ScenePickingPass;0;7;ScenePickingPass;1;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=ScenePickingPass;False;False;0;;0;0;Standard;0;False;0
WireConnection;2672;0;2666;0
WireConnection;2670;33;2669;314
WireConnection;2670;27;2669;314
WireConnection;2670;28;2669;314
WireConnection;2670;29;2669;314
WireConnection;2670;30;2667;314
WireConnection;2670;31;2668;0
WireConnection;2373;0;2670;0
WireConnection;2380;225;2379;0
WireConnection;2375;206;2374;0
WireConnection;2454;0;2380;106
WireConnection;2505;0;2375;151
WireConnection;2654;572;2600;0
WireConnection;2654;596;2508;0
WireConnection;2655;572;2600;0
WireConnection;2655;596;2508;0
WireConnection;2655;600;2507;0
WireConnection;2671;33;2669;128
WireConnection;2671;27;2669;128
WireConnection;2671;28;2669;128
WireConnection;2671;29;2669;128
WireConnection;2671;30;2667;128
WireConnection;2671;31;2668;0
WireConnection;2619;3;2654;973
WireConnection;2619;17;2655;973
WireConnection;2619;19;2620;0
WireConnection;2377;0;2671;0
WireConnection;2509;6;2619;0
WireConnection;2567;0;2509;14
WireConnection;2569;0;2509;14
WireConnection;2608;0;2509;14
WireConnection;2604;0;2509;14
WireConnection;2657;146;2656;0
WireConnection;2568;0;2646;108
WireConnection;2568;1;2646;0
WireConnection;2568;2;2567;0
WireConnection;2571;0;2647;108
WireConnection;2571;1;2647;0
WireConnection;2571;2;2569;0
WireConnection;2603;0;2648;108
WireConnection;2603;1;2648;0
WireConnection;2603;2;2604;0
WireConnection;2607;0;2649;108
WireConnection;2607;1;2649;0
WireConnection;2607;2;2608;0
WireConnection;2610;0;2509;0
WireConnection;2659;146;2657;128
WireConnection;2659;186;2658;0
WireConnection;2594;39;2568;0
WireConnection;2592;39;2571;0
WireConnection;2605;39;2603;0
WireConnection;2609;39;2607;0
WireConnection;2611;39;2610;0
WireConnection;2665;146;2659;128
WireConnection;2550;0;2594;0
WireConnection;2550;1;2592;0
WireConnection;2550;2;2605;0
WireConnection;2550;3;2611;0
WireConnection;2550;4;2609;0
WireConnection;2660;146;2665;128
WireConnection;2399;0;2550;0
WireConnection;2661;0;2660;128
WireConnection;1774;0;1771;0
WireConnection;1774;1;1772;0
WireConnection;1774;3;1803;0
WireConnection;1803;0;1800;0
WireConnection;1843;0;1804;0
WireConnection;1800;0;1843;0
WireConnection;2664;80;2400;0
WireConnection;2664;106;2563;0
WireConnection;2664;107;2555;0
WireConnection;2354;0;2664;114
WireConnection;2354;3;2664;114
WireConnection;2354;5;2664;114
WireConnection;2354;2;2664;0
WireConnection;2354;15;2664;113
WireConnection;2354;16;2664;148
WireConnection;2354;17;2664;149
ASEEND*/
//CHKSM=41276D3FD2427900904FF54AE103352A2A1154EA