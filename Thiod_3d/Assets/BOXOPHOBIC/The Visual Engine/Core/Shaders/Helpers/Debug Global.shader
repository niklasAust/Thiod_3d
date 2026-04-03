// Made with Amplify Shader Editor v1.9.9.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Global"
{
	Properties
	{
		[HideInInspector] _IsTVEShader( "_IsTVEShader", Float ) = 0
		_RenderClip( "_RenderClip", Float ) = 0
		_IsElementShader( "_IsElementShader", Float ) = 0
		_IsHelperShader( "_IsHelperShader", Float ) = 0
		[StyledCategory(Object Settings, true, Use the Legacy Model mode only for meshes converted using the old Vegetation Engine asset.NEWNEWUse the Z Up Axis mode when the mesh rotation is set as MIN90 on the X axis.NEWNEWUse the Phase Mask to select which vertex color is used for perMINbranch or perMINleaf variation for Motion or Perspective phase offset.NEWNEWUse the Height and Radius values to normalize the procedural Height and Capsule masks used for Motion. In URP and HDRP__ the mesh renderer bounds can be used to remap the values automaticalyEXC, 0, 10)] _ObjectCategory( "[ Object Category ]", Float ) = 1
		[Enum(Legacy,0,Default,1)] _ObjectModelMode( "Object Model Mode", Float ) = 1
		[Enum(Single,0,Baked,1,Procedural,2)] _ObjectPivotMode( "Object Pivots Mode", Float ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _ObjectPhaseMode( "Object Phase Mask", Float ) = 0
		_ObjectHeightValue( "Object Height Value", Range( 0, 40 ) ) = 1
		_ObjectRadiusValue( "Object Radius Value", Range( 0, 40 ) ) = 1
		[StyledSpace(10)] _ObjectEnd( "[ Object End ]", Float ) = 1
		_IsShaderType( "_IsShaderType", Float ) = 0
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
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_COLOR
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
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

				uniform half TVE_DEBUG_Index;
				uniform half TVE_DEBUG_Clip;
				uniform half TVE_DEBUG_Min;
				uniform half TVE_DEBUG_Max;
				uniform half TVE_DEBUG_Shading;
				uniform half _IsTVEShader;
				uniform half TVE_DEBUG_Filter;
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
				uniform float4 TVE_RenderBasePositionR;
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

					float localIfModelDataByShader26_g251487 = ( 0.0 );
					TVEModelData Data26_g251487 = (TVEModelData)0;
					TVEModelData Data16_g251476 =(TVEModelData)0;
					half Dummy207_g251466 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g251476 = Dummy207_g251466;
					float In_Dummy16_g251476 = temp_output_14_0_g251476;
					float3 PositionOS131_g251466 = v.vertex.xyz;
					float3 temp_output_4_0_g251476 = PositionOS131_g251466;
					float3 In_PositionOS16_g251476 = temp_output_4_0_g251476;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g251466 = ase_positionWS;
					float3 vertexToFrag73_g251466 = temp_output_104_7_g251466;
					float3 PositionWS122_g251466 = vertexToFrag73_g251466;
					float3 In_PositionWS16_g251476 = PositionWS122_g251466;
					float4x4 break19_g251469 = unity_ObjectToWorld;
					float3 appendResult20_g251469 = (float3(break19_g251469[ 0 ][ 3 ] , break19_g251469[ 1 ][ 3 ] , break19_g251469[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251466 = appendResult20_g251469;
					float4x4 break19_g251471 = unity_ObjectToWorld;
					float3 appendResult20_g251471 = (float3(break19_g251471[ 0 ][ 3 ] , break19_g251471[ 1 ][ 3 ] , break19_g251471[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g251467 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g251466 = PositionOS131_g251466;
					float3 appendResult234_g251466 = (float3(break233_g251466.x , 0.0 , break233_g251466.z));
					float3 break413_g251466 = PositionOS131_g251466;
					float3 appendResult414_g251466 = (float3(break413_g251466.x , break413_g251466.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251473 = appendResult414_g251466;
					#else
					float3 staticSwitch65_g251473 = appendResult234_g251466;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g251466 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g251466 = appendResult60_g251467;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g251466 = staticSwitch65_g251473;
					#else
					float3 staticSwitch229_g251466 = _Vector0;
					#endif
					float3 PivotOS149_g251466 = staticSwitch229_g251466;
					float3 temp_output_122_0_g251471 = PivotOS149_g251466;
					float3 PivotsOnlyWS105_g251471 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g251471 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g251466 = ( appendResult20_g251471 + PivotsOnlyWS105_g251471 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g251466 = temp_output_340_7_g251466;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g251466 = temp_output_341_7_g251466;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g251466 = temp_output_341_7_g251466;
					#else
					float3 staticSwitch236_g251466 = temp_output_340_7_g251466;
					#endif
					float3 vertexToFrag76_g251466 = staticSwitch236_g251466;
					float3 PivotWS121_g251466 = vertexToFrag76_g251466;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251466 = ( PositionWS122_g251466 - PivotWS121_g251466 );
					#else
					float3 staticSwitch204_g251466 = PositionWS122_g251466;
					#endif
					float3 PositionWO132_g251466 = ( staticSwitch204_g251466 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251476 = PositionWO132_g251466;
					float3 In_PositionRawOS16_g251476 = PositionOS131_g251466;
					float3 In_PivotOS16_g251476 = PivotOS149_g251466;
					float3 In_PivotWS16_g251476 = PivotWS121_g251466;
					float3 PivotWO133_g251466 = ( PivotWS121_g251466 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251476 = PivotWO133_g251466;
					half3 NormalOS134_g251466 = v.normal;
					float3 temp_output_21_0_g251476 = NormalOS134_g251466;
					float3 In_NormalOS16_g251476 = temp_output_21_0_g251476;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g251466 = normalizedWorldNormal;
					float3 In_NormalWS16_g251476 = NormalWS95_g251466;
					float3 In_NormalRawOS16_g251476 = NormalOS134_g251466;
					half4 TangentlOS153_g251466 = v.tangent;
					float4 temp_output_6_0_g251476 = TangentlOS153_g251466;
					float4 In_TangentOS16_g251476 = temp_output_6_0_g251476;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g251466 = ase_tangentWS;
					float3 In_TangentWS16_g251476 = TangentWS136_g251466;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g251466 = ase_bitangentWS;
					float3 In_BitangentWS16_g251476 = BiangentWS421_g251466;
					float3 normalizeResult296_g251466 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251466 ) );
					half3 ViewDirWS169_g251466 = normalizeResult296_g251466;
					float3 In_ViewDirWS16_g251476 = ViewDirWS169_g251466;
					float4 appendResult397_g251466 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g251466 = appendResult397_g251466;
					float4 In_CoordsData16_g251476 = CoordsData398_g251466;
					half4 VertexMasks171_g251466 = v.ase_color;
					float4 In_VertexData16_g251476 = VertexMasks171_g251466;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251479 = (PositionOS131_g251466).z;
					#else
					float staticSwitch65_g251479 = (PositionOS131_g251466).y;
					#endif
					half Object_HeightValue267_g251466 = _ObjectHeightValue;
					half Bounds_HeightMask274_g251466 = saturate( ( staticSwitch65_g251479 / Object_HeightValue267_g251466 ) );
					half3 Position387_g251466 = PositionOS131_g251466;
					half Height387_g251466 = Object_HeightValue267_g251466;
					half Object_RadiusValue268_g251466 = _ObjectRadiusValue;
					half Radius387_g251466 = Object_RadiusValue268_g251466;
					half localCapsuleMaskYUp387_g251466 = CapsuleMaskYUp( Position387_g251466 , Height387_g251466 , Radius387_g251466 );
					half3 Position408_g251466 = PositionOS131_g251466;
					half Height408_g251466 = Object_HeightValue267_g251466;
					half Radius408_g251466 = Object_RadiusValue268_g251466;
					half localCapsuleMaskZUp408_g251466 = CapsuleMaskZUp( Position408_g251466 , Height408_g251466 , Radius408_g251466 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251484 = saturate( localCapsuleMaskZUp408_g251466 );
					#else
					float staticSwitch65_g251484 = saturate( localCapsuleMaskYUp387_g251466 );
					#endif
					half Bounds_SphereMask282_g251466 = staticSwitch65_g251484;
					float4 appendResult253_g251466 = (float4(Bounds_HeightMask274_g251466 , Bounds_SphereMask282_g251466 , 1.0 , 1.0));
					half4 MasksData254_g251466 = appendResult253_g251466;
					float4 In_MasksData16_g251476 = MasksData254_g251466;
					float temp_output_17_0_g251478 = _ObjectPhaseMode;
					float Option70_g251478 = temp_output_17_0_g251478;
					float4 temp_output_3_0_g251478 = v.ase_color;
					float4 Channel70_g251478 = temp_output_3_0_g251478;
					float localSwitchChannel470_g251478 = SwitchChannel4( Option70_g251478 , Channel70_g251478 );
					half Phase_Value372_g251466 = localSwitchChannel470_g251478;
					float3 break319_g251466 = PivotWO133_g251466;
					half Pivot_Position322_g251466 = ( break319_g251466.x + break319_g251466.z );
					half Phase_Position357_g251466 = ( Phase_Value372_g251466 + Pivot_Position322_g251466 );
					float temp_output_248_0_g251466 = frac( Phase_Position357_g251466 );
					float4 appendResult177_g251466 = (float4(( (frac( ( Phase_Position357_g251466 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g251466));
					half4 Phase_Data176_g251466 = appendResult177_g251466;
					float4 In_PhaseData16_g251476 = Phase_Data176_g251466;
					float4 In_TransformData16_g251476 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251476 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g251476 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g251476 , In_Dummy16_g251476 , In_PositionOS16_g251476 , In_PositionWS16_g251476 , In_PositionWO16_g251476 , In_PositionRawOS16_g251476 , In_PivotOS16_g251476 , In_PivotWS16_g251476 , In_PivotWO16_g251476 , In_NormalOS16_g251476 , In_NormalWS16_g251476 , In_NormalRawOS16_g251476 , In_TangentOS16_g251476 , In_TangentWS16_g251476 , In_BitangentWS16_g251476 , In_ViewDirWS16_g251476 , In_CoordsData16_g251476 , In_VertexData16_g251476 , In_MasksData16_g251476 , In_PhaseData16_g251476 , In_TransformData16_g251476 , In_RotationData16_g251476 , In_InterpolatorA16_g251476 );
					TVEModelData DataDefault26_g251487 = Data16_g251476;
					TVEModelData DataGeneral26_g251487 = Data16_g251476;
					TVEModelData DataBlanket26_g251487 = Data16_g251476;
					TVEModelData DataImpostor26_g251487 = Data16_g251476;
					TVEModelData Data16_g251456 =(TVEModelData)0;
					half Dummy207_g251446 = 0.0;
					float temp_output_14_0_g251456 = Dummy207_g251446;
					float In_Dummy16_g251456 = temp_output_14_0_g251456;
					float3 PositionOS131_g251446 = v.vertex.xyz;
					float3 temp_output_4_0_g251456 = PositionOS131_g251446;
					float3 In_PositionOS16_g251456 = temp_output_4_0_g251456;
					float3 temp_output_104_7_g251446 = ase_positionWS;
					float3 PositionWS122_g251446 = temp_output_104_7_g251446;
					float3 In_PositionWS16_g251456 = PositionWS122_g251446;
					float4x4 break19_g251449 = unity_ObjectToWorld;
					float3 appendResult20_g251449 = (float3(break19_g251449[ 0 ][ 3 ] , break19_g251449[ 1 ][ 3 ] , break19_g251449[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251446 = appendResult20_g251449;
					float3 PivotWS121_g251446 = temp_output_340_7_g251446;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251446 = ( PositionWS122_g251446 - PivotWS121_g251446 );
					#else
					float3 staticSwitch204_g251446 = PositionWS122_g251446;
					#endif
					float3 PositionWO132_g251446 = ( staticSwitch204_g251446 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251456 = PositionWO132_g251446;
					float3 In_PositionRawOS16_g251456 = PositionOS131_g251446;
					float3 PivotOS149_g251446 = _Vector0;
					float3 In_PivotOS16_g251456 = PivotOS149_g251446;
					float3 In_PivotWS16_g251456 = PivotWS121_g251446;
					float3 PivotWO133_g251446 = ( PivotWS121_g251446 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251456 = PivotWO133_g251446;
					half3 NormalOS134_g251446 = v.normal;
					float3 temp_output_21_0_g251456 = NormalOS134_g251446;
					float3 In_NormalOS16_g251456 = temp_output_21_0_g251456;
					half3 NormalWS95_g251446 = normalizedWorldNormal;
					float3 In_NormalWS16_g251456 = NormalWS95_g251446;
					float3 In_NormalRawOS16_g251456 = NormalOS134_g251446;
					half4 TangentlOS153_g251446 = v.tangent;
					float4 temp_output_6_0_g251456 = TangentlOS153_g251446;
					float4 In_TangentOS16_g251456 = temp_output_6_0_g251456;
					half3 TangentWS136_g251446 = ase_tangentWS;
					float3 In_TangentWS16_g251456 = TangentWS136_g251446;
					half3 BiangentWS421_g251446 = ase_bitangentWS;
					float3 In_BitangentWS16_g251456 = BiangentWS421_g251446;
					float3 normalizeResult296_g251446 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251446 ) );
					half3 ViewDirWS169_g251446 = normalizeResult296_g251446;
					float3 In_ViewDirWS16_g251456 = ViewDirWS169_g251446;
					float4 appendResult397_g251446 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g251446 = appendResult397_g251446;
					float4 In_CoordsData16_g251456 = CoordsData398_g251446;
					half4 VertexMasks171_g251446 = float4( 0,0,0,0 );
					float4 In_VertexData16_g251456 = VertexMasks171_g251446;
					half4 MasksData254_g251446 = float4( 0,0,0,0 );
					float4 In_MasksData16_g251456 = MasksData254_g251446;
					half4 Phase_Data176_g251446 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g251456 = Phase_Data176_g251446;
					float4 In_TransformData16_g251456 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251456 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g251456 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g251456 , In_Dummy16_g251456 , In_PositionOS16_g251456 , In_PositionWS16_g251456 , In_PositionWO16_g251456 , In_PositionRawOS16_g251456 , In_PivotOS16_g251456 , In_PivotWS16_g251456 , In_PivotWO16_g251456 , In_NormalOS16_g251456 , In_NormalWS16_g251456 , In_NormalRawOS16_g251456 , In_TangentOS16_g251456 , In_TangentWS16_g251456 , In_BitangentWS16_g251456 , In_ViewDirWS16_g251456 , In_CoordsData16_g251456 , In_VertexData16_g251456 , In_MasksData16_g251456 , In_PhaseData16_g251456 , In_TransformData16_g251456 , In_RotationData16_g251456 , In_InterpolatorA16_g251456 );
					TVEModelData DataTerrain26_g251487 = Data16_g251456;
					half IsShaderType2544 = _IsShaderType;
					float Type26_g251487 = IsShaderType2544;
					{
					if (Type26_g251487 == 0 )
					{
					Data26_g251487 = DataDefault26_g251487;
					}
					else if (Type26_g251487 == 1 )
					{
					Data26_g251487 = DataGeneral26_g251487;
					}
					else if (Type26_g251487 == 2 )
					{
					Data26_g251487 = DataBlanket26_g251487;
					}
					else if (Type26_g251487 == 3 )
					{
					Data26_g251487 = DataImpostor26_g251487;
					}
					else if (Type26_g251487 == 4 )
					{
					Data26_g251487 = DataTerrain26_g251487;
					}
					}
					TVEModelData Data15_g251646 =(TVEModelData)Data26_g251487;
					float Out_Dummy15_g251646 = 0.0;
					float3 Out_PositionOS15_g251646 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251646 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251646 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251646 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251646 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251646 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251646 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251646 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251646 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251646 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251646 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251646 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251646 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251646 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251646 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251646 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251646 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251646 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251646 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251646 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251646 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251646 , Out_Dummy15_g251646 , Out_PositionOS15_g251646 , Out_PositionWS15_g251646 , Out_PositionWO15_g251646 , Out_PositionRawOS15_g251646 , Out_PivotOS15_g251646 , Out_PivotWS15_g251646 , Out_PivotWO15_g251646 , Out_NormalOS15_g251646 , Out_NormalWS15_g251646 , Out_NormalRawOS15_g251646 , Out_TangentOS15_g251646 , Out_TangentWS15_g251646 , Out_BitangentWS15_g251646 , Out_ViewDirWS15_g251646 , Out_CoordsData15_g251646 , Out_VertexData15_g251646 , Out_MasksData15_g251646 , Out_PhaseData15_g251646 , Out_TransformData15_g251646 , Out_RotationData15_g251646 , Out_InterpolatorA15_g251646 );
					TVEModelData Data16_g251648 =(TVEModelData)Data15_g251646;
					float temp_output_14_0_g251648 = 0.0;
					float In_Dummy16_g251648 = temp_output_14_0_g251648;
					float3 temp_output_219_24_g251645 = Out_PivotOS15_g251646;
					float3 temp_output_215_0_g251645 = ( Out_PositionOS15_g251646 - temp_output_219_24_g251645 );
					float3 temp_output_4_0_g251648 = temp_output_215_0_g251645;
					float3 In_PositionOS16_g251648 = temp_output_4_0_g251648;
					float3 In_PositionWS16_g251648 = Out_PositionWS15_g251646;
					float3 In_PositionWO16_g251648 = Out_PositionWO15_g251646;
					float3 In_PositionRawOS16_g251648 = Out_PositionRawOS15_g251646;
					float3 In_PivotOS16_g251648 = temp_output_219_24_g251645;
					float3 In_PivotWS16_g251648 = Out_PivotWS15_g251646;
					float3 In_PivotWO16_g251648 = Out_PivotWO15_g251646;
					float3 temp_output_21_0_g251648 = Out_NormalOS15_g251646;
					float3 In_NormalOS16_g251648 = temp_output_21_0_g251648;
					float3 In_NormalWS16_g251648 = Out_NormalWS15_g251646;
					float3 In_NormalRawOS16_g251648 = Out_NormalRawOS15_g251646;
					float4 temp_output_6_0_g251648 = Out_TangentOS15_g251646;
					float4 In_TangentOS16_g251648 = temp_output_6_0_g251648;
					float3 In_TangentWS16_g251648 = Out_TangentWS15_g251646;
					float3 In_BitangentWS16_g251648 = Out_BitangentWS15_g251646;
					float3 In_ViewDirWS16_g251648 = Out_ViewDirWS15_g251646;
					float4 In_CoordsData16_g251648 = Out_CoordsData15_g251646;
					float4 In_VertexData16_g251648 = Out_VertexData15_g251646;
					float4 In_MasksData16_g251648 = Out_MasksData15_g251646;
					float4 In_PhaseData16_g251648 = Out_PhaseData15_g251646;
					float4 In_TransformData16_g251648 = Out_TransformData15_g251646;
					float4 In_RotationData16_g251648 = Out_RotationData15_g251646;
					float4 In_InterpolatorA16_g251648 = Out_InterpolatorA15_g251646;
					BuildModelVertData( Data16_g251648 , In_Dummy16_g251648 , In_PositionOS16_g251648 , In_PositionWS16_g251648 , In_PositionWO16_g251648 , In_PositionRawOS16_g251648 , In_PivotOS16_g251648 , In_PivotWS16_g251648 , In_PivotWO16_g251648 , In_NormalOS16_g251648 , In_NormalWS16_g251648 , In_NormalRawOS16_g251648 , In_TangentOS16_g251648 , In_TangentWS16_g251648 , In_BitangentWS16_g251648 , In_ViewDirWS16_g251648 , In_CoordsData16_g251648 , In_VertexData16_g251648 , In_MasksData16_g251648 , In_PhaseData16_g251648 , In_TransformData16_g251648 , In_RotationData16_g251648 , In_InterpolatorA16_g251648 );
					TVEModelData Data15_g251650 =(TVEModelData)Data16_g251648;
					float Out_Dummy15_g251650 = 0.0;
					float3 Out_PositionOS15_g251650 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251650 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251650 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251650 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251650 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251650 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251650 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251650 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251650 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251650 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251650 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251650 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251650 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251650 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251650 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251650 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251650 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251650 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251650 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251650 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251650 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251650 , Out_Dummy15_g251650 , Out_PositionOS15_g251650 , Out_PositionWS15_g251650 , Out_PositionWO15_g251650 , Out_PositionRawOS15_g251650 , Out_PivotOS15_g251650 , Out_PivotWS15_g251650 , Out_PivotWO15_g251650 , Out_NormalOS15_g251650 , Out_NormalWS15_g251650 , Out_NormalRawOS15_g251650 , Out_TangentOS15_g251650 , Out_TangentWS15_g251650 , Out_BitangentWS15_g251650 , Out_ViewDirWS15_g251650 , Out_CoordsData15_g251650 , Out_VertexData15_g251650 , Out_MasksData15_g251650 , Out_PhaseData15_g251650 , Out_TransformData15_g251650 , Out_RotationData15_g251650 , Out_InterpolatorA15_g251650 );
					TVEModelData Data16_g251651 =(TVEModelData)Data15_g251650;
					half Dummy317_g251649 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g251651 = Dummy317_g251649;
					float In_Dummy16_g251651 = temp_output_14_0_g251651;
					float3 temp_output_4_0_g251651 = Out_PositionOS15_g251650;
					float3 In_PositionOS16_g251651 = temp_output_4_0_g251651;
					float3 In_PositionWS16_g251651 = Out_PositionWS15_g251650;
					float3 temp_output_314_17_g251649 = Out_PositionWO15_g251650;
					float3 In_PositionWO16_g251651 = temp_output_314_17_g251649;
					float3 In_PositionRawOS16_g251651 = Out_PositionRawOS15_g251650;
					float3 In_PivotOS16_g251651 = Out_PivotOS15_g251650;
					float3 In_PivotWS16_g251651 = Out_PivotWS15_g251650;
					float3 temp_output_314_19_g251649 = Out_PivotWO15_g251650;
					float3 In_PivotWO16_g251651 = temp_output_314_19_g251649;
					float3 temp_output_21_0_g251651 = Out_NormalOS15_g251650;
					float3 In_NormalOS16_g251651 = temp_output_21_0_g251651;
					float3 In_NormalWS16_g251651 = Out_NormalWS15_g251650;
					float3 In_NormalRawOS16_g251651 = Out_NormalRawOS15_g251650;
					float4 temp_output_6_0_g251651 = Out_TangentOS15_g251650;
					float4 In_TangentOS16_g251651 = temp_output_6_0_g251651;
					float3 In_TangentWS16_g251651 = Out_TangentWS15_g251650;
					float3 In_BitangentWS16_g251651 = Out_BitangentWS15_g251650;
					float3 In_ViewDirWS16_g251651 = Out_ViewDirWS15_g251650;
					float4 In_CoordsData16_g251651 = Out_CoordsData15_g251650;
					float4 temp_output_314_29_g251649 = Out_VertexData15_g251650;
					float4 In_VertexData16_g251651 = temp_output_314_29_g251649;
					float4 In_MasksData16_g251651 = Out_MasksData15_g251650;
					float4 In_PhaseData16_g251651 = Out_PhaseData15_g251650;
					half4 Model_TransformData356_g251649 = Out_TransformData15_g251650;
					float localBuildGlobalData204_g251489 = ( 0.0 );
					TVEGlobalData Data204_g251489 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251489 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251489 = Dummy211_g251489;
					float4 temp_output_589_164_g251489 = TVE_CoatParams;
					half4 Coat_Params596_g251489 = temp_output_589_164_g251489;
					float4 In_CoatParams204_g251489 = Coat_Params596_g251489;
					float4 temp_output_203_0_g251509 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g251486 = ( 0.0 );
					TVEModelData Data26_g251486 = (TVEModelData)0;
					TVEModelData Data16_g251474 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g251474 = 0.0;
					float3 In_PositionWS16_g251474 = PositionWS122_g251466;
					float3 In_PositionWO16_g251474 = PositionWO132_g251466;
					float3 In_PivotWS16_g251474 = PivotWS121_g251466;
					float3 In_PivotWO16_g251474 = PivotWO133_g251466;
					float3 In_NormalWS16_g251474 = NormalWS95_g251466;
					float3 In_TangentWS16_g251474 = TangentWS136_g251466;
					float3 In_BitangentWS16_g251474 = BiangentWS421_g251466;
					half3 NormalWS427_g251466 = NormalWS95_g251466;
					half3 localComputeTriplanarWeights427_g251466 = ComputeTriplanarWeights( NormalWS427_g251466 );
					half3 TriplanarWeights429_g251466 = localComputeTriplanarWeights427_g251466;
					float3 In_TriplanarWeights16_g251474 = TriplanarWeights429_g251466;
					float3 In_ViewDirWS16_g251474 = ViewDirWS169_g251466;
					float4 In_CoordsData16_g251474 = CoordsData398_g251466;
					float4 In_VertexData16_g251474 = VertexMasks171_g251466;
					float4 In_PhaseData16_g251474 = Phase_Data176_g251466;
					BuildModelFragData( Data16_g251474 , In_Dummy16_g251474 , In_PositionWS16_g251474 , In_PositionWO16_g251474 , In_PivotWS16_g251474 , In_PivotWO16_g251474 , In_NormalWS16_g251474 , In_TangentWS16_g251474 , In_BitangentWS16_g251474 , In_TriplanarWeights16_g251474 , In_ViewDirWS16_g251474 , In_CoordsData16_g251474 , In_VertexData16_g251474 , In_PhaseData16_g251474 );
					TVEModelData DataDefault26_g251486 = Data16_g251474;
					TVEModelData DataGeneral26_g251486 = Data16_g251474;
					TVEModelData DataBlanket26_g251486 = Data16_g251474;
					TVEModelData DataImpostor26_g251486 = Data16_g251474;
					TVEModelData Data16_g251454 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g251454 = 0.0;
					float3 In_PositionWS16_g251454 = PositionWS122_g251446;
					float3 In_PositionWO16_g251454 = PositionWO132_g251446;
					float3 In_PivotWS16_g251454 = PivotWS121_g251446;
					float3 In_PivotWO16_g251454 = PivotWO133_g251446;
					float3 In_NormalWS16_g251454 = NormalWS95_g251446;
					float3 In_TangentWS16_g251454 = TangentWS136_g251446;
					float3 In_BitangentWS16_g251454 = BiangentWS421_g251446;
					half3 NormalWS427_g251446 = NormalWS95_g251446;
					half3 localComputeTriplanarWeights427_g251446 = ComputeTriplanarWeights( NormalWS427_g251446 );
					half3 TriplanarWeights429_g251446 = localComputeTriplanarWeights427_g251446;
					float3 In_TriplanarWeights16_g251454 = TriplanarWeights429_g251446;
					float3 In_ViewDirWS16_g251454 = ViewDirWS169_g251446;
					float4 In_CoordsData16_g251454 = CoordsData398_g251446;
					float4 In_VertexData16_g251454 = VertexMasks171_g251446;
					float4 In_PhaseData16_g251454 = Phase_Data176_g251446;
					BuildModelFragData( Data16_g251454 , In_Dummy16_g251454 , In_PositionWS16_g251454 , In_PositionWO16_g251454 , In_PivotWS16_g251454 , In_PivotWO16_g251454 , In_NormalWS16_g251454 , In_TangentWS16_g251454 , In_BitangentWS16_g251454 , In_TriplanarWeights16_g251454 , In_ViewDirWS16_g251454 , In_CoordsData16_g251454 , In_VertexData16_g251454 , In_PhaseData16_g251454 );
					TVEModelData DataTerrain26_g251486 = Data16_g251454;
					float Type26_g251486 = IsShaderType2544;
					{
					if (Type26_g251486 == 0 )
					{
					Data26_g251486 = DataDefault26_g251486;
					}
					else if (Type26_g251486 == 1 )
					{
					Data26_g251486 = DataGeneral26_g251486;
					}
					else if (Type26_g251486 == 2 )
					{
					Data26_g251486 = DataBlanket26_g251486;
					}
					else if (Type26_g251486 == 3 )
					{
					Data26_g251486 = DataImpostor26_g251486;
					}
					else if (Type26_g251486 == 4 )
					{
					Data26_g251486 = DataTerrain26_g251486;
					}
					}
					TVEModelData Data15_g251565 =(TVEModelData)Data26_g251486;
					float Out_Dummy15_g251565 = 0.0;
					float3 Out_PositionWS15_g251565 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251565 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251565 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251565 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251565 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251565 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251565 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251565 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251565 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251565 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251565 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251565 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251565 , Out_Dummy15_g251565 , Out_PositionWS15_g251565 , Out_PositionWO15_g251565 , Out_PivotWS15_g251565 , Out_PivotWO15_g251565 , Out_NormalWS15_g251565 , Out_TangentWS15_g251565 , Out_BitangentWS15_g251565 , Out_TriplanarWeights15_g251565 , Out_ViewDirWS15_g251565 , Out_CoordsData15_g251565 , Out_VertexData15_g251565 , Out_PhaseData15_g251565 );
					float3 Model_PositionWS497_g251489 = Out_PositionWS15_g251565;
					float2 Model_PositionWS_XZ143_g251489 = (Model_PositionWS497_g251489).xz;
					float3 Model_PivotWS498_g251489 = Out_PivotWS15_g251565;
					float2 Model_PivotWS_XZ145_g251489 = (Model_PivotWS498_g251489).xz;
					float2 lerpResult300_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251509 = lerpResult300_g251489;
					float temp_output_82_0_g251507 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251509 = temp_output_82_0_g251507;
					float4 tex2DArrayNode83_g251509 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251509).zw + ( (temp_output_203_0_g251509).xy * temp_output_81_0_g251509 ) ),temp_output_82_0_g251509), 0.0 );
					float4 appendResult210_g251509 = (float4(tex2DArrayNode83_g251509.rgb , saturate( tex2DArrayNode83_g251509.a )));
					float4 temp_output_204_0_g251509 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251509 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251509).zw + ( (temp_output_204_0_g251509).xy * temp_output_81_0_g251509 ) ),temp_output_82_0_g251509), 0.0 );
					float4 appendResult212_g251509 = (float4(tex2DArrayNode122_g251509.rgb , saturate( tex2DArrayNode122_g251509.a )));
					float4 TVE_RenderNearPositionR628_g251489 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251489 = saturate( ( distance( Model_PositionWS497_g251489 , (TVE_RenderNearPositionR628_g251489).xyz ) / (TVE_RenderNearPositionR628_g251489).w ) );
					float temp_output_7_0_g251490 = 1.0;
					float temp_output_9_0_g251490 = ( temp_output_507_0_g251489 - temp_output_7_0_g251490 );
					half TVE_RenderNearFadeValue635_g251489 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251489 = saturate( ( temp_output_9_0_g251490 / ( ( TVE_RenderNearFadeValue635_g251489 - temp_output_7_0_g251490 ) + 0.0001 ) ) );
					float4 lerpResult131_g251509 = lerp( appendResult210_g251509 , appendResult212_g251509 , Global_TexBlend509_g251489);
					float4 temp_output_159_109_g251507 = lerpResult131_g251509;
					float4 lerpResult168_g251507 = lerp( TVE_CoatParams , temp_output_159_109_g251507 , TVE_CoatLayers[(int)temp_output_82_0_g251507]);
					float4 temp_output_589_109_g251489 = lerpResult168_g251507;
					half4 Coat_Texture302_g251489 = temp_output_589_109_g251489;
					float4 In_CoatTexture204_g251489 = Coat_Texture302_g251489;
					float4 temp_output_595_164_g251489 = TVE_PaintParams;
					half4 Paint_Params575_g251489 = temp_output_595_164_g251489;
					float4 In_PaintParams204_g251489 = Paint_Params575_g251489;
					float4 temp_output_203_0_g251558 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251558 = lerpResult85_g251489;
					float temp_output_82_0_g251555 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251558 = temp_output_82_0_g251555;
					float4 tex2DArrayNode83_g251558 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251558).zw + ( (temp_output_203_0_g251558).xy * temp_output_81_0_g251558 ) ),temp_output_82_0_g251558), 0.0 );
					float4 appendResult210_g251558 = (float4(tex2DArrayNode83_g251558.rgb , saturate( tex2DArrayNode83_g251558.a )));
					float4 temp_output_204_0_g251558 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251558 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251558).zw + ( (temp_output_204_0_g251558).xy * temp_output_81_0_g251558 ) ),temp_output_82_0_g251558), 0.0 );
					float4 appendResult212_g251558 = (float4(tex2DArrayNode122_g251558.rgb , saturate( tex2DArrayNode122_g251558.a )));
					float4 lerpResult131_g251558 = lerp( appendResult210_g251558 , appendResult212_g251558 , Global_TexBlend509_g251489);
					float4 temp_output_171_109_g251555 = lerpResult131_g251558;
					float4 lerpResult174_g251555 = lerp( TVE_PaintParams , temp_output_171_109_g251555 , TVE_PaintLayers[(int)temp_output_82_0_g251555]);
					float4 temp_output_595_109_g251489 = lerpResult174_g251555;
					half4 Paint_Texture71_g251489 = temp_output_595_109_g251489;
					float4 In_PaintTexture204_g251489 = Paint_Texture71_g251489;
					float4 temp_output_590_141_g251489 = TVE_AtmoParams;
					half4 Atmo_Params601_g251489 = temp_output_590_141_g251489;
					float4 In_AtmoParams204_g251489 = Atmo_Params601_g251489;
					float4 temp_output_203_0_g251517 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251517 = lerpResult104_g251489;
					float temp_output_132_0_g251515 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251517 = temp_output_132_0_g251515;
					float4 tex2DArrayNode83_g251517 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251517).zw + ( (temp_output_203_0_g251517).xy * temp_output_81_0_g251517 ) ),temp_output_82_0_g251517), 0.0 );
					float4 appendResult210_g251517 = (float4(tex2DArrayNode83_g251517.rgb , saturate( tex2DArrayNode83_g251517.a )));
					float4 temp_output_204_0_g251517 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251517 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251517).zw + ( (temp_output_204_0_g251517).xy * temp_output_81_0_g251517 ) ),temp_output_82_0_g251517), 0.0 );
					float4 appendResult212_g251517 = (float4(tex2DArrayNode122_g251517.rgb , saturate( tex2DArrayNode122_g251517.a )));
					float4 lerpResult131_g251517 = lerp( appendResult210_g251517 , appendResult212_g251517 , Global_TexBlend509_g251489);
					float4 temp_output_137_109_g251515 = lerpResult131_g251517;
					float4 lerpResult145_g251515 = lerp( TVE_AtmoParams , temp_output_137_109_g251515 , TVE_AtmoLayers[(int)temp_output_132_0_g251515]);
					float4 temp_output_590_110_g251489 = lerpResult145_g251515;
					half4 Atmo_Texture80_g251489 = temp_output_590_110_g251489;
					float4 In_AtmoTexture204_g251489 = Atmo_Texture80_g251489;
					float4 temp_output_593_163_g251489 = TVE_GlowParams;
					half4 Glow_Params609_g251489 = temp_output_593_163_g251489;
					float4 In_GlowParams204_g251489 = Glow_Params609_g251489;
					float4 temp_output_203_0_g251533 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251533 = lerpResult247_g251489;
					float temp_output_82_0_g251531 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251533 = temp_output_82_0_g251531;
					float4 tex2DArrayNode83_g251533 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251533).zw + ( (temp_output_203_0_g251533).xy * temp_output_81_0_g251533 ) ),temp_output_82_0_g251533), 0.0 );
					float4 appendResult210_g251533 = (float4(tex2DArrayNode83_g251533.rgb , saturate( tex2DArrayNode83_g251533.a )));
					float4 temp_output_204_0_g251533 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251533 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251533).zw + ( (temp_output_204_0_g251533).xy * temp_output_81_0_g251533 ) ),temp_output_82_0_g251533), 0.0 );
					float4 appendResult212_g251533 = (float4(tex2DArrayNode122_g251533.rgb , saturate( tex2DArrayNode122_g251533.a )));
					float4 lerpResult131_g251533 = lerp( appendResult210_g251533 , appendResult212_g251533 , Global_TexBlend509_g251489);
					float4 temp_output_159_109_g251531 = lerpResult131_g251533;
					float4 lerpResult167_g251531 = lerp( TVE_GlowParams , temp_output_159_109_g251531 , TVE_GlowLayers[(int)temp_output_82_0_g251531]);
					float4 temp_output_593_109_g251489 = lerpResult167_g251531;
					half4 Glow_Texture248_g251489 = temp_output_593_109_g251489;
					float4 In_GlowTexture204_g251489 = Glow_Texture248_g251489;
					float4 temp_output_592_139_g251489 = TVE_FormParams;
					float4 Form_Params606_g251489 = temp_output_592_139_g251489;
					float4 In_FormParams204_g251489 = Form_Params606_g251489;
					float4 temp_output_203_0_g251549 = TVE_FormBaseCoord;
					float2 lerpResult168_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251549 = lerpResult168_g251489;
					float temp_output_130_0_g251547 = _GlobalFormLayerValue;
					float temp_output_82_0_g251549 = temp_output_130_0_g251547;
					float4 tex2DArrayNode83_g251549 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251549).zw + ( (temp_output_203_0_g251549).xy * temp_output_81_0_g251549 ) ),temp_output_82_0_g251549), 0.0 );
					float4 appendResult210_g251549 = (float4(tex2DArrayNode83_g251549.rgb , saturate( tex2DArrayNode83_g251549.a )));
					float4 temp_output_204_0_g251549 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251549 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251549).zw + ( (temp_output_204_0_g251549).xy * temp_output_81_0_g251549 ) ),temp_output_82_0_g251549), 0.0 );
					float4 appendResult212_g251549 = (float4(tex2DArrayNode122_g251549.rgb , saturate( tex2DArrayNode122_g251549.a )));
					float4 lerpResult131_g251549 = lerp( appendResult210_g251549 , appendResult212_g251549 , Global_TexBlend509_g251489);
					float4 temp_output_135_109_g251547 = lerpResult131_g251549;
					float4 lerpResult143_g251547 = lerp( TVE_FormParams , temp_output_135_109_g251547 , TVE_FormLayers[(int)temp_output_130_0_g251547]);
					float4 temp_output_592_0_g251489 = lerpResult143_g251547;
					float4 Form_Texture112_g251489 = temp_output_592_0_g251489;
					float4 In_FormTexture204_g251489 = Form_Texture112_g251489;
					float4 temp_output_594_145_g251489 = TVE_FlowParams;
					half4 Flow_Params612_g251489 = temp_output_594_145_g251489;
					float4 In_FlowParams204_g251489 = Flow_Params612_g251489;
					float4 temp_output_203_0_g251541 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251541 = lerpResult400_g251489;
					float temp_output_136_0_g251539 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251541 = temp_output_136_0_g251539;
					float4 tex2DArrayNode83_g251541 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251541).zw + ( (temp_output_203_0_g251541).xy * temp_output_81_0_g251541 ) ),temp_output_82_0_g251541), 0.0 );
					float4 appendResult210_g251541 = (float4(tex2DArrayNode83_g251541.rgb , saturate( tex2DArrayNode83_g251541.a )));
					float4 temp_output_204_0_g251541 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251541 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251541).zw + ( (temp_output_204_0_g251541).xy * temp_output_81_0_g251541 ) ),temp_output_82_0_g251541), 0.0 );
					float4 appendResult212_g251541 = (float4(tex2DArrayNode122_g251541.rgb , saturate( tex2DArrayNode122_g251541.a )));
					float4 lerpResult131_g251541 = lerp( appendResult210_g251541 , appendResult212_g251541 , Global_TexBlend509_g251489);
					float4 temp_output_141_109_g251539 = lerpResult131_g251541;
					float4 lerpResult149_g251539 = lerp( TVE_FlowParams , temp_output_141_109_g251539 , TVE_FlowLayers[(int)temp_output_136_0_g251539]);
					half4 Flow_Texture405_g251489 = lerpResult149_g251539;
					float4 In_FlowTexture204_g251489 = Flow_Texture405_g251489;
					BuildGlobalData( Data204_g251489 , In_Dummy204_g251489 , In_CoatParams204_g251489 , In_CoatTexture204_g251489 , In_PaintParams204_g251489 , In_PaintTexture204_g251489 , In_AtmoParams204_g251489 , In_AtmoTexture204_g251489 , In_GlowParams204_g251489 , In_GlowTexture204_g251489 , In_FormParams204_g251489 , In_FormTexture204_g251489 , In_FlowParams204_g251489 , In_FlowTexture204_g251489 );
					TVEGlobalData Data15_g251652 =(TVEGlobalData)Data204_g251489;
					float Out_Dummy15_g251652 = 0.0;
					float4 Out_CoatParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251652 = float4( 0,0,0,0 );
					BreakData( Data15_g251652 , Out_Dummy15_g251652 , Out_CoatParams15_g251652 , Out_CoatTexture15_g251652 , Out_PaintParams15_g251652 , Out_PaintTexture15_g251652 , Out_AtmoParams15_g251652 , Out_AtmoTexture15_g251652 , Out_GlowParams15_g251652 , Out_GlowTexture15_g251652 , Out_FormParams15_g251652 , Out_FormTexture15_g251652 , Out_FlowParams15_g251652 , Out_FlowTexture15_g251652 );
					float4 Global_FormTexture351_g251649 = Out_FormTexture15_g251652;
					float3 Model_PivotWO353_g251649 = temp_output_314_19_g251649;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251658 = _ConformMeshMode;
					float Option70_g251658 = temp_output_17_0_g251658;
					half4 Model_VertexData357_g251649 = temp_output_314_29_g251649;
					float4 temp_output_3_0_g251658 = Model_VertexData357_g251649;
					float4 Channel70_g251658 = temp_output_3_0_g251658;
					float localSwitchChannel470_g251658 = SwitchChannel4( Option70_g251658 , Channel70_g251658 );
					float temp_output_390_0_g251649 = localSwitchChannel470_g251658;
					float temp_output_7_0_g251655 = _ConformMeshRemap.x;
					float temp_output_9_0_g251655 = ( temp_output_390_0_g251649 - temp_output_7_0_g251655 );
					float lerpResult374_g251649 = lerp( 1.0 , saturate( ( temp_output_9_0_g251655 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251649 = lerpResult374_g251649;
					float temp_output_328_0_g251649 = ( Blend_VertMask379_g251649 * TVE_IsEnabled );
					half Conform_Mask366_g251649 = temp_output_328_0_g251649;
					float temp_output_322_0_g251649 = ( ( ( ( (Global_FormTexture351_g251649).z - ( (Model_PivotWO353_g251649).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251649 ) );
					float3 appendResult329_g251649 = (float3(0.0 , temp_output_322_0_g251649 , 0.0));
					float3 appendResult387_g251649 = (float3(0.0 , 0.0 , temp_output_322_0_g251649));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251656 = appendResult387_g251649;
					#else
					float3 staticSwitch65_g251656 = appendResult329_g251649;
					#endif
					float3 Blanket_Conform368_g251649 = staticSwitch65_g251656;
					float4 appendResult312_g251649 = (float4(Blanket_Conform368_g251649 , 0.0));
					float4 temp_output_310_0_g251649 = ( Model_TransformData356_g251649 + appendResult312_g251649 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251649 = temp_output_310_0_g251649;
					#else
					float4 staticSwitch364_g251649 = Model_TransformData356_g251649;
					#endif
					half4 Final_TransformData365_g251649 = staticSwitch364_g251649;
					float4 In_TransformData16_g251651 = Final_TransformData365_g251649;
					float4 In_RotationData16_g251651 = Out_RotationData15_g251650;
					float4 In_InterpolatorA16_g251651 = Out_InterpolatorA15_g251650;
					BuildModelVertData( Data16_g251651 , In_Dummy16_g251651 , In_PositionOS16_g251651 , In_PositionWS16_g251651 , In_PositionWO16_g251651 , In_PositionRawOS16_g251651 , In_PivotOS16_g251651 , In_PivotWS16_g251651 , In_PivotWO16_g251651 , In_NormalOS16_g251651 , In_NormalWS16_g251651 , In_NormalRawOS16_g251651 , In_TangentOS16_g251651 , In_TangentWS16_g251651 , In_BitangentWS16_g251651 , In_ViewDirWS16_g251651 , In_CoordsData16_g251651 , In_VertexData16_g251651 , In_MasksData16_g251651 , In_PhaseData16_g251651 , In_TransformData16_g251651 , In_RotationData16_g251651 , In_InterpolatorA16_g251651 );
					TVEModelData Data15_g251747 =(TVEModelData)Data16_g251651;
					float Out_Dummy15_g251747 = 0.0;
					float3 Out_PositionOS15_g251747 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251747 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251747 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251747 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251747 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251747 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251747 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251747 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251747 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251747 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251747 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251747 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251747 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251747 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251747 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251747 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251747 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251747 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251747 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251747 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251747 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251747 , Out_Dummy15_g251747 , Out_PositionOS15_g251747 , Out_PositionWS15_g251747 , Out_PositionWO15_g251747 , Out_PositionRawOS15_g251747 , Out_PivotOS15_g251747 , Out_PivotWS15_g251747 , Out_PivotWO15_g251747 , Out_NormalOS15_g251747 , Out_NormalWS15_g251747 , Out_NormalRawOS15_g251747 , Out_TangentOS15_g251747 , Out_TangentWS15_g251747 , Out_BitangentWS15_g251747 , Out_ViewDirWS15_g251747 , Out_CoordsData15_g251747 , Out_VertexData15_g251747 , Out_MasksData15_g251747 , Out_PhaseData15_g251747 , Out_TransformData15_g251747 , Out_RotationData15_g251747 , Out_InterpolatorA15_g251747 );
					TVEModelData Data16_g251748 =(TVEModelData)Data15_g251747;
					float temp_output_14_0_g251748 = 0.0;
					float In_Dummy16_g251748 = temp_output_14_0_g251748;
					float3 Model_PositionOS147_g251746 = Out_PositionOS15_g251747;
					half3 VertexPos40_g251752 = Model_PositionOS147_g251746;
					float4 temp_output_1567_33_g251746 = Out_RotationData15_g251747;
					half4 Model_RotationData1569_g251746 = temp_output_1567_33_g251746;
					float2 break1582_g251746 = (Model_RotationData1569_g251746).xy;
					half Angle44_g251752 = break1582_g251746.y;
					half CosAngle89_g251752 = cos( Angle44_g251752 );
					half SinAngle93_g251752 = sin( Angle44_g251752 );
					float3 appendResult95_g251752 = (float3((VertexPos40_g251752).x , ( ( (VertexPos40_g251752).y * CosAngle89_g251752 ) - ( (VertexPos40_g251752).z * SinAngle93_g251752 ) ) , ( ( (VertexPos40_g251752).y * SinAngle93_g251752 ) + ( (VertexPos40_g251752).z * CosAngle89_g251752 ) )));
					half3 VertexPos40_g251753 = appendResult95_g251752;
					half Angle44_g251753 = -break1582_g251746.x;
					half CosAngle94_g251753 = cos( Angle44_g251753 );
					half SinAngle95_g251753 = sin( Angle44_g251753 );
					float3 appendResult98_g251753 = (float3(( ( (VertexPos40_g251753).x * CosAngle94_g251753 ) - ( (VertexPos40_g251753).y * SinAngle95_g251753 ) ) , ( ( (VertexPos40_g251753).x * SinAngle95_g251753 ) + ( (VertexPos40_g251753).y * CosAngle94_g251753 ) ) , (VertexPos40_g251753).z));
					half3 VertexPos40_g251751 = Model_PositionOS147_g251746;
					half Angle44_g251751 = break1582_g251746.y;
					half CosAngle89_g251751 = cos( Angle44_g251751 );
					half SinAngle93_g251751 = sin( Angle44_g251751 );
					float3 appendResult95_g251751 = (float3((VertexPos40_g251751).x , ( ( (VertexPos40_g251751).y * CosAngle89_g251751 ) - ( (VertexPos40_g251751).z * SinAngle93_g251751 ) ) , ( ( (VertexPos40_g251751).y * SinAngle93_g251751 ) + ( (VertexPos40_g251751).z * CosAngle89_g251751 ) )));
					half3 VertexPos40_g251756 = appendResult95_g251751;
					half Angle44_g251756 = break1582_g251746.x;
					half CosAngle91_g251756 = cos( Angle44_g251756 );
					half SinAngle92_g251756 = sin( Angle44_g251756 );
					float3 appendResult93_g251756 = (float3(( ( (VertexPos40_g251756).x * CosAngle91_g251756 ) + ( (VertexPos40_g251756).z * SinAngle92_g251756 ) ) , (VertexPos40_g251756).y , ( ( -(VertexPos40_g251756).x * SinAngle92_g251756 ) + ( (VertexPos40_g251756).z * CosAngle91_g251756 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251754 = appendResult93_g251756;
					#else
					float3 staticSwitch65_g251754 = appendResult98_g251753;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251749 = staticSwitch65_g251754;
					#else
					float3 staticSwitch65_g251749 = Model_PositionOS147_g251746;
					#endif
					float3 temp_output_1608_0_g251746 = staticSwitch65_g251749;
					half3 VertexPos40_g251755 = temp_output_1608_0_g251746;
					half Angle44_g251755 = (Model_RotationData1569_g251746).z;
					half CosAngle91_g251755 = cos( Angle44_g251755 );
					half SinAngle92_g251755 = sin( Angle44_g251755 );
					float3 appendResult93_g251755 = (float3(( ( (VertexPos40_g251755).x * CosAngle91_g251755 ) + ( (VertexPos40_g251755).z * SinAngle92_g251755 ) ) , (VertexPos40_g251755).y , ( ( -(VertexPos40_g251755).x * SinAngle92_g251755 ) + ( (VertexPos40_g251755).z * CosAngle91_g251755 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251750 = appendResult93_g251755;
					#else
					float3 staticSwitch65_g251750 = temp_output_1608_0_g251746;
					#endif
					float4 temp_output_1567_31_g251746 = Out_TransformData15_g251747;
					half4 Model_TransformData1568_g251746 = temp_output_1567_31_g251746;
					half3 Final_PositionOS178_g251746 = ( ( staticSwitch65_g251750 * (Model_TransformData1568_g251746).w ) + (Model_TransformData1568_g251746).xyz );
					float3 temp_output_4_0_g251748 = Final_PositionOS178_g251746;
					float3 In_PositionOS16_g251748 = temp_output_4_0_g251748;
					float3 In_PositionWS16_g251748 = Out_PositionWS15_g251747;
					float3 In_PositionWO16_g251748 = Out_PositionWO15_g251747;
					float3 In_PositionRawOS16_g251748 = Out_PositionRawOS15_g251747;
					float3 In_PivotOS16_g251748 = Out_PivotOS15_g251747;
					float3 In_PivotWS16_g251748 = Out_PivotWS15_g251747;
					float3 In_PivotWO16_g251748 = Out_PivotWO15_g251747;
					float3 temp_output_21_0_g251748 = Out_NormalOS15_g251747;
					float3 In_NormalOS16_g251748 = temp_output_21_0_g251748;
					float3 In_NormalWS16_g251748 = Out_NormalWS15_g251747;
					float3 In_NormalRawOS16_g251748 = Out_NormalRawOS15_g251747;
					float4 temp_output_6_0_g251748 = Out_TangentOS15_g251747;
					float4 In_TangentOS16_g251748 = temp_output_6_0_g251748;
					float3 In_TangentWS16_g251748 = Out_TangentWS15_g251747;
					float3 In_BitangentWS16_g251748 = Out_BitangentWS15_g251747;
					float3 In_ViewDirWS16_g251748 = Out_ViewDirWS15_g251747;
					float4 In_CoordsData16_g251748 = Out_CoordsData15_g251747;
					float4 In_VertexData16_g251748 = Out_VertexData15_g251747;
					float4 In_MasksData16_g251748 = Out_MasksData15_g251747;
					float4 In_PhaseData16_g251748 = Out_PhaseData15_g251747;
					float4 In_TransformData16_g251748 = temp_output_1567_31_g251746;
					float4 In_RotationData16_g251748 = temp_output_1567_33_g251746;
					float4 In_InterpolatorA16_g251748 = Out_InterpolatorA15_g251747;
					BuildModelVertData( Data16_g251748 , In_Dummy16_g251748 , In_PositionOS16_g251748 , In_PositionWS16_g251748 , In_PositionWO16_g251748 , In_PositionRawOS16_g251748 , In_PivotOS16_g251748 , In_PivotWS16_g251748 , In_PivotWO16_g251748 , In_NormalOS16_g251748 , In_NormalWS16_g251748 , In_NormalRawOS16_g251748 , In_TangentOS16_g251748 , In_TangentWS16_g251748 , In_BitangentWS16_g251748 , In_ViewDirWS16_g251748 , In_CoordsData16_g251748 , In_VertexData16_g251748 , In_MasksData16_g251748 , In_PhaseData16_g251748 , In_TransformData16_g251748 , In_RotationData16_g251748 , In_InterpolatorA16_g251748 );
					TVEModelData Data15_g251759 =(TVEModelData)Data16_g251748;
					float Out_Dummy15_g251759 = 0.0;
					float3 Out_PositionOS15_g251759 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251759 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251759 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251759 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251759 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251759 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251759 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251759 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251759 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251759 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251759 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251759 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251759 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251759 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251759 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251759 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251759 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251759 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251759 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251759 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251759 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251759 , Out_Dummy15_g251759 , Out_PositionOS15_g251759 , Out_PositionWS15_g251759 , Out_PositionWO15_g251759 , Out_PositionRawOS15_g251759 , Out_PivotOS15_g251759 , Out_PivotWS15_g251759 , Out_PivotWO15_g251759 , Out_NormalOS15_g251759 , Out_NormalWS15_g251759 , Out_NormalRawOS15_g251759 , Out_TangentOS15_g251759 , Out_TangentWS15_g251759 , Out_BitangentWS15_g251759 , Out_ViewDirWS15_g251759 , Out_CoordsData15_g251759 , Out_VertexData15_g251759 , Out_MasksData15_g251759 , Out_PhaseData15_g251759 , Out_TransformData15_g251759 , Out_RotationData15_g251759 , Out_InterpolatorA15_g251759 );
					TVEModelData Data16_g251760 =(TVEModelData)Data15_g251759;
					float temp_output_14_0_g251760 = 0.0;
					float In_Dummy16_g251760 = temp_output_14_0_g251760;
					float3 temp_output_217_24_g251758 = Out_PivotOS15_g251759;
					float3 temp_output_216_0_g251758 = ( Out_PositionOS15_g251759 + temp_output_217_24_g251758 );
					float3 temp_output_4_0_g251760 = temp_output_216_0_g251758;
					float3 In_PositionOS16_g251760 = temp_output_4_0_g251760;
					float3 In_PositionWS16_g251760 = Out_PositionWS15_g251759;
					float3 In_PositionWO16_g251760 = Out_PositionWO15_g251759;
					float3 In_PositionRawOS16_g251760 = Out_PositionRawOS15_g251759;
					float3 In_PivotOS16_g251760 = temp_output_217_24_g251758;
					float3 In_PivotWS16_g251760 = Out_PivotWS15_g251759;
					float3 In_PivotWO16_g251760 = Out_PivotWO15_g251759;
					float3 temp_output_21_0_g251760 = Out_NormalOS15_g251759;
					float3 In_NormalOS16_g251760 = temp_output_21_0_g251760;
					float3 In_NormalWS16_g251760 = Out_NormalWS15_g251759;
					float3 In_NormalRawOS16_g251760 = Out_NormalRawOS15_g251759;
					float4 temp_output_6_0_g251760 = Out_TangentOS15_g251759;
					float4 In_TangentOS16_g251760 = temp_output_6_0_g251760;
					float3 In_TangentWS16_g251760 = Out_TangentWS15_g251759;
					float3 In_BitangentWS16_g251760 = Out_BitangentWS15_g251759;
					float3 In_ViewDirWS16_g251760 = Out_ViewDirWS15_g251759;
					float4 In_CoordsData16_g251760 = Out_CoordsData15_g251759;
					float4 In_VertexData16_g251760 = Out_VertexData15_g251759;
					float4 In_MasksData16_g251760 = Out_MasksData15_g251759;
					float4 In_PhaseData16_g251760 = Out_PhaseData15_g251759;
					float4 In_TransformData16_g251760 = Out_TransformData15_g251759;
					float4 In_RotationData16_g251760 = Out_RotationData15_g251759;
					float4 In_InterpolatorA16_g251760 = Out_InterpolatorA15_g251759;
					BuildModelVertData( Data16_g251760 , In_Dummy16_g251760 , In_PositionOS16_g251760 , In_PositionWS16_g251760 , In_PositionWO16_g251760 , In_PositionRawOS16_g251760 , In_PivotOS16_g251760 , In_PivotWS16_g251760 , In_PivotWO16_g251760 , In_NormalOS16_g251760 , In_NormalWS16_g251760 , In_NormalRawOS16_g251760 , In_TangentOS16_g251760 , In_TangentWS16_g251760 , In_BitangentWS16_g251760 , In_ViewDirWS16_g251760 , In_CoordsData16_g251760 , In_VertexData16_g251760 , In_MasksData16_g251760 , In_PhaseData16_g251760 , In_TransformData16_g251760 , In_RotationData16_g251760 , In_InterpolatorA16_g251760 );
					TVEModelData Data15_g251790 =(TVEModelData)Data16_g251760;
					float Out_Dummy15_g251790 = 0.0;
					float3 Out_PositionOS15_g251790 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251790 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251790 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251790 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251790 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251790 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251790 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251790 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251790 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251790 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251790 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251790 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251790 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251790 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251790 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251790 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251790 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251790 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251790 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251790 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251790 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251790 , Out_Dummy15_g251790 , Out_PositionOS15_g251790 , Out_PositionWS15_g251790 , Out_PositionWO15_g251790 , Out_PositionRawOS15_g251790 , Out_PivotOS15_g251790 , Out_PivotWS15_g251790 , Out_PivotWO15_g251790 , Out_NormalOS15_g251790 , Out_NormalWS15_g251790 , Out_NormalRawOS15_g251790 , Out_TangentOS15_g251790 , Out_TangentWS15_g251790 , Out_BitangentWS15_g251790 , Out_ViewDirWS15_g251790 , Out_CoordsData15_g251790 , Out_VertexData15_g251790 , Out_MasksData15_g251790 , Out_PhaseData15_g251790 , Out_TransformData15_g251790 , Out_RotationData15_g251790 , Out_InterpolatorA15_g251790 );
					
					o.ase_texcoord6.xyz = vertexToFrag73_g251466;
					o.ase_texcoord7.xyz = vertexToFrag76_g251466;
					float3 vertexPos57_g251784 = v.vertex.xyz;
					float4 ase_positionCS57_g251784 = UnityObjectToClipPos( vertexPos57_g251784 );
					o.ase_texcoord9 = ase_positionCS57_g251784;
					
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
					float3 vertexValue = Out_PositionOS15_g251790;
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

					float temp_output_2587_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2587_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2587_114).xxx;
					
					float3 color130_g251784 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g251784 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g251786 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g251785 = ( temp_cast_4 * ( 0.5 + appendResult128_g251786 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g251785 = (float4(ddx( FinalUV13_g251785 ) , ddy( FinalUV13_g251785 )));
					float4 UVDerivatives17_g251785 = appendResult16_g251785;
					float4 break28_g251785 = UVDerivatives17_g251785;
					float2 appendResult19_g251785 = (float2(break28_g251785.x , break28_g251785.z));
					float2 appendResult20_g251785 = (float2(break28_g251785.x , break28_g251785.z));
					float dotResult24_g251785 = dot( appendResult19_g251785 , appendResult20_g251785 );
					float2 appendResult21_g251785 = (float2(break28_g251785.y , break28_g251785.w));
					float2 appendResult22_g251785 = (float2(break28_g251785.y , break28_g251785.w));
					float dotResult23_g251785 = dot( appendResult21_g251785 , appendResult22_g251785 );
					float2 appendResult25_g251785 = (float2(dotResult24_g251785 , dotResult23_g251785));
					float2 derivativesLength29_g251785 = sqrt( appendResult25_g251785 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g251785 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g251785 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g251785 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g251785 = clampResult57_g251785;
					float2 break55_g251785 = derivativesLength29_g251785;
					float4 lerpResult73_g251785 = lerp( float4( color130_g251784 , 0.0 ) , float4( color81_g251784 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g251785.x * break71_g251785.y * sqrt( saturate( ( 1.1 - max( break55_g251785.x, break55_g251785.y ) ) ) ) ) ) ));
					float3 color2584 = IsGammaSpace() ? float3( 0.3867925, 0.3867925, 0.3867925 ) : float3( 0.1237993, 0.1237993, 0.1237993 );
					float3 color2564 = IsGammaSpace() ? float3( 1, 0, 0.3576326 ) : float3( 1, 0, 0.1050864 );
					float3 color2565 = IsGammaSpace() ? float3( 0, 0.5347826, 1 ) : float3( 0, 0.2476594, 1 );
					float4 temp_output_2563_145 = TVE_RenderNearPositionR;
					float temp_output_7_0_g251488 = 1.0;
					float temp_output_9_0_g251488 = ( saturate( ( distance( PositionWS , (temp_output_2563_145).xyz ) / (temp_output_2563_145).w ) ) - temp_output_7_0_g251488 );
					half Global_Blend2558 = saturate( ( temp_output_9_0_g251488 / ( ( TVE_RenderNearFadeValue - temp_output_7_0_g251488 ) + 0.0001 ) ) );
					float3 lerpResult2567 = lerp( color2564 , color2565 , Global_Blend2558);
					float4 temp_output_2582_148 = TVE_RenderBasePositionR;
					float temp_output_7_0_g251643 = 1.0;
					float temp_output_9_0_g251643 = ( saturate( ( distance( PositionWS , (temp_output_2582_148).xyz ) / (temp_output_2582_148).w ) ) - temp_output_7_0_g251643 );
					half Global_Edge2578 = saturate( ( temp_output_9_0_g251643 / ( ( 0.9999 - temp_output_7_0_g251643 ) + 0.0001 ) ) );
					float3 lerpResult2583 = lerp( color2584 , lerpResult2567 , Global_Edge2578);
					float3 ifLocalVar40_g251757 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g251757 = lerpResult2583;
					float localBuildGlobalData204_g251566 = ( 0.0 );
					TVEGlobalData Data204_g251566 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251566 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251566 = Dummy211_g251566;
					float4 temp_output_589_164_g251566 = TVE_CoatParams;
					half4 Coat_Params596_g251566 = temp_output_589_164_g251566;
					float4 In_CoatParams204_g251566 = Coat_Params596_g251566;
					float4 temp_output_203_0_g251586 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g251486 = ( 0.0 );
					TVEModelData Data26_g251486 = (TVEModelData)0;
					TVEModelData Data16_g251474 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g251474 = 0.0;
					float3 vertexToFrag73_g251466 = IN.ase_texcoord6.xyz;
					float3 PositionWS122_g251466 = vertexToFrag73_g251466;
					float3 In_PositionWS16_g251474 = PositionWS122_g251466;
					float3 vertexToFrag76_g251466 = IN.ase_texcoord7.xyz;
					float3 PivotWS121_g251466 = vertexToFrag76_g251466;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251466 = ( PositionWS122_g251466 - PivotWS121_g251466 );
					#else
					float3 staticSwitch204_g251466 = PositionWS122_g251466;
					#endif
					float3 PositionWO132_g251466 = ( staticSwitch204_g251466 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251474 = PositionWO132_g251466;
					float3 In_PivotWS16_g251474 = PivotWS121_g251466;
					float3 PivotWO133_g251466 = ( PivotWS121_g251466 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251474 = PivotWO133_g251466;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g251466 = normalizedWorldNormal;
					float3 In_NormalWS16_g251474 = NormalWS95_g251466;
					half3 TangentWS136_g251466 = TangentWS;
					float3 In_TangentWS16_g251474 = TangentWS136_g251466;
					half3 BiangentWS421_g251466 = BitangentWS;
					float3 In_BitangentWS16_g251474 = BiangentWS421_g251466;
					half3 NormalWS427_g251466 = NormalWS95_g251466;
					half3 localComputeTriplanarWeights427_g251466 = ComputeTriplanarWeights( NormalWS427_g251466 );
					half3 TriplanarWeights429_g251466 = localComputeTriplanarWeights427_g251466;
					float3 In_TriplanarWeights16_g251474 = TriplanarWeights429_g251466;
					float3 normalizeResult296_g251466 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251466 ) );
					half3 ViewDirWS169_g251466 = normalizeResult296_g251466;
					float3 In_ViewDirWS16_g251474 = ViewDirWS169_g251466;
					float4 appendResult397_g251466 = (float4(IN.ase_texcoord8.xy , IN.ase_texcoord8.zw));
					float4 CoordsData398_g251466 = appendResult397_g251466;
					float4 In_CoordsData16_g251474 = CoordsData398_g251466;
					half4 VertexMasks171_g251466 = IN.ase_color;
					float4 In_VertexData16_g251474 = VertexMasks171_g251466;
					float temp_output_17_0_g251478 = _ObjectPhaseMode;
					float Option70_g251478 = temp_output_17_0_g251478;
					float4 temp_output_3_0_g251478 = IN.ase_color;
					float4 Channel70_g251478 = temp_output_3_0_g251478;
					float localSwitchChannel470_g251478 = SwitchChannel4( Option70_g251478 , Channel70_g251478 );
					half Phase_Value372_g251466 = localSwitchChannel470_g251478;
					float3 break319_g251466 = PivotWO133_g251466;
					half Pivot_Position322_g251466 = ( break319_g251466.x + break319_g251466.z );
					half Phase_Position357_g251466 = ( Phase_Value372_g251466 + Pivot_Position322_g251466 );
					float temp_output_248_0_g251466 = frac( Phase_Position357_g251466 );
					float4 appendResult177_g251466 = (float4(( (frac( ( Phase_Position357_g251466 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g251466));
					half4 Phase_Data176_g251466 = appendResult177_g251466;
					float4 In_PhaseData16_g251474 = Phase_Data176_g251466;
					BuildModelFragData( Data16_g251474 , In_Dummy16_g251474 , In_PositionWS16_g251474 , In_PositionWO16_g251474 , In_PivotWS16_g251474 , In_PivotWO16_g251474 , In_NormalWS16_g251474 , In_TangentWS16_g251474 , In_BitangentWS16_g251474 , In_TriplanarWeights16_g251474 , In_ViewDirWS16_g251474 , In_CoordsData16_g251474 , In_VertexData16_g251474 , In_PhaseData16_g251474 );
					TVEModelData DataDefault26_g251486 = Data16_g251474;
					TVEModelData DataGeneral26_g251486 = Data16_g251474;
					TVEModelData DataBlanket26_g251486 = Data16_g251474;
					TVEModelData DataImpostor26_g251486 = Data16_g251474;
					TVEModelData Data16_g251454 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g251454 = 0.0;
					float3 temp_output_104_7_g251446 = PositionWS;
					float3 PositionWS122_g251446 = temp_output_104_7_g251446;
					float3 In_PositionWS16_g251454 = PositionWS122_g251446;
					float4x4 break19_g251449 = unity_ObjectToWorld;
					float3 appendResult20_g251449 = (float3(break19_g251449[ 0 ][ 3 ] , break19_g251449[ 1 ][ 3 ] , break19_g251449[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251446 = appendResult20_g251449;
					float3 PivotWS121_g251446 = temp_output_340_7_g251446;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251446 = ( PositionWS122_g251446 - PivotWS121_g251446 );
					#else
					float3 staticSwitch204_g251446 = PositionWS122_g251446;
					#endif
					float3 PositionWO132_g251446 = ( staticSwitch204_g251446 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251454 = PositionWO132_g251446;
					float3 In_PivotWS16_g251454 = PivotWS121_g251446;
					float3 PivotWO133_g251446 = ( PivotWS121_g251446 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251454 = PivotWO133_g251446;
					half3 NormalWS95_g251446 = normalizedWorldNormal;
					float3 In_NormalWS16_g251454 = NormalWS95_g251446;
					half3 TangentWS136_g251446 = TangentWS;
					float3 In_TangentWS16_g251454 = TangentWS136_g251446;
					half3 BiangentWS421_g251446 = BitangentWS;
					float3 In_BitangentWS16_g251454 = BiangentWS421_g251446;
					half3 NormalWS427_g251446 = NormalWS95_g251446;
					half3 localComputeTriplanarWeights427_g251446 = ComputeTriplanarWeights( NormalWS427_g251446 );
					half3 TriplanarWeights429_g251446 = localComputeTriplanarWeights427_g251446;
					float3 In_TriplanarWeights16_g251454 = TriplanarWeights429_g251446;
					float3 normalizeResult296_g251446 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251446 ) );
					half3 ViewDirWS169_g251446 = normalizeResult296_g251446;
					float3 In_ViewDirWS16_g251454 = ViewDirWS169_g251446;
					float4 appendResult397_g251446 = (float4(IN.ase_texcoord8.xy , IN.ase_texcoord8.zw));
					float4 CoordsData398_g251446 = appendResult397_g251446;
					float4 In_CoordsData16_g251454 = CoordsData398_g251446;
					half4 VertexMasks171_g251446 = float4( 0,0,0,0 );
					float4 In_VertexData16_g251454 = VertexMasks171_g251446;
					half4 Phase_Data176_g251446 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g251454 = Phase_Data176_g251446;
					BuildModelFragData( Data16_g251454 , In_Dummy16_g251454 , In_PositionWS16_g251454 , In_PositionWO16_g251454 , In_PivotWS16_g251454 , In_PivotWO16_g251454 , In_NormalWS16_g251454 , In_TangentWS16_g251454 , In_BitangentWS16_g251454 , In_TriplanarWeights16_g251454 , In_ViewDirWS16_g251454 , In_CoordsData16_g251454 , In_VertexData16_g251454 , In_PhaseData16_g251454 );
					TVEModelData DataTerrain26_g251486 = Data16_g251454;
					half IsShaderType2544 = _IsShaderType;
					float Type26_g251486 = IsShaderType2544;
					{
					if (Type26_g251486 == 0 )
					{
					Data26_g251486 = DataDefault26_g251486;
					}
					else if (Type26_g251486 == 1 )
					{
					Data26_g251486 = DataGeneral26_g251486;
					}
					else if (Type26_g251486 == 2 )
					{
					Data26_g251486 = DataBlanket26_g251486;
					}
					else if (Type26_g251486 == 3 )
					{
					Data26_g251486 = DataImpostor26_g251486;
					}
					else if (Type26_g251486 == 4 )
					{
					Data26_g251486 = DataTerrain26_g251486;
					}
					}
					TVEModelData Data15_g251642 =(TVEModelData)Data26_g251486;
					float Out_Dummy15_g251642 = 0.0;
					float3 Out_PositionWS15_g251642 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251642 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251642 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251642 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251642 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251642 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251642 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251642 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251642 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251642 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251642 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251642 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251642 , Out_Dummy15_g251642 , Out_PositionWS15_g251642 , Out_PositionWO15_g251642 , Out_PivotWS15_g251642 , Out_PivotWO15_g251642 , Out_NormalWS15_g251642 , Out_TangentWS15_g251642 , Out_BitangentWS15_g251642 , Out_TriplanarWeights15_g251642 , Out_ViewDirWS15_g251642 , Out_CoordsData15_g251642 , Out_VertexData15_g251642 , Out_PhaseData15_g251642 );
					float3 Model_PositionWS497_g251566 = Out_PositionWS15_g251642;
					float2 Model_PositionWS_XZ143_g251566 = (Model_PositionWS497_g251566).xz;
					float3 Model_PivotWS498_g251566 = Out_PivotWS15_g251642;
					float2 Model_PivotWS_XZ145_g251566 = (Model_PivotWS498_g251566).xz;
					float2 lerpResult300_g251566 = lerp( Model_PositionWS_XZ143_g251566 , Model_PivotWS_XZ145_g251566 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251586 = lerpResult300_g251566;
					float temp_output_82_0_g251584 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251586 = temp_output_82_0_g251584;
					float4 tex2DArrayNode83_g251586 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251586).zw + ( (temp_output_203_0_g251586).xy * temp_output_81_0_g251586 ) ),temp_output_82_0_g251586) );
					float4 appendResult210_g251586 = (float4(tex2DArrayNode83_g251586.rgb , saturate( tex2DArrayNode83_g251586.a )));
					float4 temp_output_204_0_g251586 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251586 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251586).zw + ( (temp_output_204_0_g251586).xy * temp_output_81_0_g251586 ) ),temp_output_82_0_g251586) );
					float4 appendResult212_g251586 = (float4(tex2DArrayNode122_g251586.rgb , saturate( tex2DArrayNode122_g251586.a )));
					float4 TVE_RenderNearPositionR628_g251566 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251566 = saturate( ( distance( Model_PositionWS497_g251566 , (TVE_RenderNearPositionR628_g251566).xyz ) / (TVE_RenderNearPositionR628_g251566).w ) );
					float temp_output_7_0_g251567 = 1.0;
					float temp_output_9_0_g251567 = ( temp_output_507_0_g251566 - temp_output_7_0_g251567 );
					half TVE_RenderNearFadeValue635_g251566 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251566 = saturate( ( temp_output_9_0_g251567 / ( ( TVE_RenderNearFadeValue635_g251566 - temp_output_7_0_g251567 ) + 0.0001 ) ) );
					float4 lerpResult131_g251586 = lerp( appendResult210_g251586 , appendResult212_g251586 , Global_TexBlend509_g251566);
					float4 temp_output_159_109_g251584 = lerpResult131_g251586;
					float4 lerpResult168_g251584 = lerp( TVE_CoatParams , temp_output_159_109_g251584 , TVE_CoatLayers[(int)temp_output_82_0_g251584]);
					float4 temp_output_589_109_g251566 = lerpResult168_g251584;
					half4 Coat_Texture302_g251566 = temp_output_589_109_g251566;
					float4 In_CoatTexture204_g251566 = Coat_Texture302_g251566;
					float4 temp_output_595_164_g251566 = TVE_PaintParams;
					half4 Paint_Params575_g251566 = temp_output_595_164_g251566;
					float4 In_PaintParams204_g251566 = Paint_Params575_g251566;
					float4 temp_output_203_0_g251635 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251566 = lerp( Model_PositionWS_XZ143_g251566 , Model_PivotWS_XZ145_g251566 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251635 = lerpResult85_g251566;
					float temp_output_82_0_g251632 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251635 = temp_output_82_0_g251632;
					float4 tex2DArrayNode83_g251635 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251635).zw + ( (temp_output_203_0_g251635).xy * temp_output_81_0_g251635 ) ),temp_output_82_0_g251635) );
					float4 appendResult210_g251635 = (float4(tex2DArrayNode83_g251635.rgb , saturate( tex2DArrayNode83_g251635.a )));
					float4 temp_output_204_0_g251635 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251635 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251635).zw + ( (temp_output_204_0_g251635).xy * temp_output_81_0_g251635 ) ),temp_output_82_0_g251635) );
					float4 appendResult212_g251635 = (float4(tex2DArrayNode122_g251635.rgb , saturate( tex2DArrayNode122_g251635.a )));
					float4 lerpResult131_g251635 = lerp( appendResult210_g251635 , appendResult212_g251635 , Global_TexBlend509_g251566);
					float4 temp_output_171_109_g251632 = lerpResult131_g251635;
					float4 lerpResult174_g251632 = lerp( TVE_PaintParams , temp_output_171_109_g251632 , TVE_PaintLayers[(int)temp_output_82_0_g251632]);
					float4 temp_output_595_109_g251566 = lerpResult174_g251632;
					half4 Paint_Texture71_g251566 = temp_output_595_109_g251566;
					float4 In_PaintTexture204_g251566 = Paint_Texture71_g251566;
					float4 temp_output_590_141_g251566 = TVE_AtmoParams;
					half4 Atmo_Params601_g251566 = temp_output_590_141_g251566;
					float4 In_AtmoParams204_g251566 = Atmo_Params601_g251566;
					float4 temp_output_203_0_g251594 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251566 = lerp( Model_PositionWS_XZ143_g251566 , Model_PivotWS_XZ145_g251566 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251594 = lerpResult104_g251566;
					float temp_output_132_0_g251592 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251594 = temp_output_132_0_g251592;
					float4 tex2DArrayNode83_g251594 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251594).zw + ( (temp_output_203_0_g251594).xy * temp_output_81_0_g251594 ) ),temp_output_82_0_g251594) );
					float4 appendResult210_g251594 = (float4(tex2DArrayNode83_g251594.rgb , saturate( tex2DArrayNode83_g251594.a )));
					float4 temp_output_204_0_g251594 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251594 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251594).zw + ( (temp_output_204_0_g251594).xy * temp_output_81_0_g251594 ) ),temp_output_82_0_g251594) );
					float4 appendResult212_g251594 = (float4(tex2DArrayNode122_g251594.rgb , saturate( tex2DArrayNode122_g251594.a )));
					float4 lerpResult131_g251594 = lerp( appendResult210_g251594 , appendResult212_g251594 , Global_TexBlend509_g251566);
					float4 temp_output_137_109_g251592 = lerpResult131_g251594;
					float4 lerpResult145_g251592 = lerp( TVE_AtmoParams , temp_output_137_109_g251592 , TVE_AtmoLayers[(int)temp_output_132_0_g251592]);
					float4 temp_output_590_110_g251566 = lerpResult145_g251592;
					half4 Atmo_Texture80_g251566 = temp_output_590_110_g251566;
					float4 In_AtmoTexture204_g251566 = Atmo_Texture80_g251566;
					float4 temp_output_593_163_g251566 = TVE_GlowParams;
					half4 Glow_Params609_g251566 = temp_output_593_163_g251566;
					float4 In_GlowParams204_g251566 = Glow_Params609_g251566;
					float4 temp_output_203_0_g251610 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251566 = lerp( Model_PositionWS_XZ143_g251566 , Model_PivotWS_XZ145_g251566 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251610 = lerpResult247_g251566;
					float temp_output_82_0_g251608 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251610 = temp_output_82_0_g251608;
					float4 tex2DArrayNode83_g251610 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251610).zw + ( (temp_output_203_0_g251610).xy * temp_output_81_0_g251610 ) ),temp_output_82_0_g251610) );
					float4 appendResult210_g251610 = (float4(tex2DArrayNode83_g251610.rgb , saturate( tex2DArrayNode83_g251610.a )));
					float4 temp_output_204_0_g251610 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251610 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251610).zw + ( (temp_output_204_0_g251610).xy * temp_output_81_0_g251610 ) ),temp_output_82_0_g251610) );
					float4 appendResult212_g251610 = (float4(tex2DArrayNode122_g251610.rgb , saturate( tex2DArrayNode122_g251610.a )));
					float4 lerpResult131_g251610 = lerp( appendResult210_g251610 , appendResult212_g251610 , Global_TexBlend509_g251566);
					float4 temp_output_159_109_g251608 = lerpResult131_g251610;
					float4 lerpResult167_g251608 = lerp( TVE_GlowParams , temp_output_159_109_g251608 , TVE_GlowLayers[(int)temp_output_82_0_g251608]);
					float4 temp_output_593_109_g251566 = lerpResult167_g251608;
					half4 Glow_Texture248_g251566 = temp_output_593_109_g251566;
					float4 In_GlowTexture204_g251566 = Glow_Texture248_g251566;
					float4 temp_output_592_139_g251566 = TVE_FormParams;
					float4 Form_Params606_g251566 = temp_output_592_139_g251566;
					float4 In_FormParams204_g251566 = Form_Params606_g251566;
					float4 temp_output_203_0_g251626 = TVE_FormBaseCoord;
					float2 lerpResult168_g251566 = lerp( Model_PositionWS_XZ143_g251566 , Model_PivotWS_XZ145_g251566 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251626 = lerpResult168_g251566;
					float temp_output_130_0_g251624 = _GlobalFormLayerValue;
					float temp_output_82_0_g251626 = temp_output_130_0_g251624;
					float4 tex2DArrayNode83_g251626 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251626).zw + ( (temp_output_203_0_g251626).xy * temp_output_81_0_g251626 ) ),temp_output_82_0_g251626) );
					float4 appendResult210_g251626 = (float4(tex2DArrayNode83_g251626.rgb , saturate( tex2DArrayNode83_g251626.a )));
					float4 temp_output_204_0_g251626 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251626 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251626).zw + ( (temp_output_204_0_g251626).xy * temp_output_81_0_g251626 ) ),temp_output_82_0_g251626) );
					float4 appendResult212_g251626 = (float4(tex2DArrayNode122_g251626.rgb , saturate( tex2DArrayNode122_g251626.a )));
					float4 lerpResult131_g251626 = lerp( appendResult210_g251626 , appendResult212_g251626 , Global_TexBlend509_g251566);
					float4 temp_output_135_109_g251624 = lerpResult131_g251626;
					float4 lerpResult143_g251624 = lerp( TVE_FormParams , temp_output_135_109_g251624 , TVE_FormLayers[(int)temp_output_130_0_g251624]);
					float4 temp_output_592_0_g251566 = lerpResult143_g251624;
					float4 Form_Texture112_g251566 = temp_output_592_0_g251566;
					float4 In_FormTexture204_g251566 = Form_Texture112_g251566;
					float4 temp_output_594_145_g251566 = TVE_FlowParams;
					half4 Flow_Params612_g251566 = temp_output_594_145_g251566;
					float4 In_FlowParams204_g251566 = Flow_Params612_g251566;
					float4 temp_output_203_0_g251618 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251566 = lerp( Model_PositionWS_XZ143_g251566 , Model_PivotWS_XZ145_g251566 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251618 = lerpResult400_g251566;
					float temp_output_136_0_g251616 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251618 = temp_output_136_0_g251616;
					float4 tex2DArrayNode83_g251618 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251618).zw + ( (temp_output_203_0_g251618).xy * temp_output_81_0_g251618 ) ),temp_output_82_0_g251618) );
					float4 appendResult210_g251618 = (float4(tex2DArrayNode83_g251618.rgb , saturate( tex2DArrayNode83_g251618.a )));
					float4 temp_output_204_0_g251618 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251618 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251618).zw + ( (temp_output_204_0_g251618).xy * temp_output_81_0_g251618 ) ),temp_output_82_0_g251618) );
					float4 appendResult212_g251618 = (float4(tex2DArrayNode122_g251618.rgb , saturate( tex2DArrayNode122_g251618.a )));
					float4 lerpResult131_g251618 = lerp( appendResult210_g251618 , appendResult212_g251618 , Global_TexBlend509_g251566);
					float4 temp_output_141_109_g251616 = lerpResult131_g251618;
					float4 lerpResult149_g251616 = lerp( TVE_FlowParams , temp_output_141_109_g251616 , TVE_FlowLayers[(int)temp_output_136_0_g251616]);
					half4 Flow_Texture405_g251566 = lerpResult149_g251616;
					float4 In_FlowTexture204_g251566 = Flow_Texture405_g251566;
					BuildGlobalData( Data204_g251566 , In_Dummy204_g251566 , In_CoatParams204_g251566 , In_CoatTexture204_g251566 , In_PaintParams204_g251566 , In_PaintTexture204_g251566 , In_AtmoParams204_g251566 , In_AtmoTexture204_g251566 , In_GlowParams204_g251566 , In_GlowTexture204_g251566 , In_FormParams204_g251566 , In_FormTexture204_g251566 , In_FlowParams204_g251566 , In_FlowTexture204_g251566 );
					TVEGlobalData Data15_g251644 =(TVEGlobalData)Data204_g251566;
					float Out_Dummy15_g251644 = 0.0;
					float4 Out_CoatParams15_g251644 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251644 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251644 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251644 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251644 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251644 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251644 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251644 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251644 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251644 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251644 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251644 = float4( 0,0,0,0 );
					BreakData( Data15_g251644 , Out_Dummy15_g251644 , Out_CoatParams15_g251644 , Out_CoatTexture15_g251644 , Out_PaintParams15_g251644 , Out_PaintTexture15_g251644 , Out_AtmoParams15_g251644 , Out_AtmoTexture15_g251644 , Out_GlowParams15_g251644 , Out_GlowTexture15_g251644 , Out_FormParams15_g251644 , Out_FormTexture15_g251644 , Out_FlowParams15_g251644 , Out_FlowTexture15_g251644 );
					float4 temp_output_2419_27 = Out_CoatTexture15_g251644;
					float3 ifLocalVar40_g251674 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g251674 = (temp_output_2419_27).xxx;
					float3 ifLocalVar40_g251675 = 0;
					if( TVE_DEBUG_Index == 3.0 )
					ifLocalVar40_g251675 = (temp_output_2419_27).yyy;
					float3 ifLocalVar40_g251731 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g251731 = (temp_output_2419_27).zzz;
					float4 temp_output_2419_0 = Out_PaintTexture15_g251644;
					float3 ifLocalVar40_g251732 = 0;
					if( TVE_DEBUG_Index == 6.0 )
					ifLocalVar40_g251732 = (temp_output_2419_0).xyz;
					float3 ifLocalVar40_g251733 = 0;
					if( TVE_DEBUG_Index == 7.0 )
					ifLocalVar40_g251733 = (temp_output_2419_0).www;
					float4 temp_output_2419_16 = Out_AtmoTexture15_g251644;
					float3 ifLocalVar40_g251734 = 0;
					if( TVE_DEBUG_Index == 9.0 )
					ifLocalVar40_g251734 = (temp_output_2419_16).xxx;
					float3 ifLocalVar40_g251735 = 0;
					if( TVE_DEBUG_Index == 10.0 )
					ifLocalVar40_g251735 = (temp_output_2419_16).yyy;
					float3 ifLocalVar40_g251736 = 0;
					if( TVE_DEBUG_Index == 11.0 )
					ifLocalVar40_g251736 = (temp_output_2419_16).zzz;
					float3 ifLocalVar40_g251737 = 0;
					if( TVE_DEBUG_Index == 12.0 )
					ifLocalVar40_g251737 = (temp_output_2419_16).www;
					float4 temp_output_2419_19 = Out_GlowTexture15_g251644;
					float3 ifLocalVar40_g251738 = 0;
					if( TVE_DEBUG_Index == 14.0 )
					ifLocalVar40_g251738 = (temp_output_2419_19).xyz;
					float3 ifLocalVar40_g251739 = 0;
					if( TVE_DEBUG_Index == 15.0 )
					ifLocalVar40_g251739 = (temp_output_2419_19).www;
					float4 temp_output_2419_18 = Out_FormTexture15_g251644;
					float3 appendResult2536 = (float3((temp_output_2419_18).xy , 0.0));
					float3 ifLocalVar40_g251740 = 0;
					if( TVE_DEBUG_Index == 17.0 )
					ifLocalVar40_g251740 = ( appendResult2536 * appendResult2536 );
					float3 temp_output_2537_0 = ( (temp_output_2419_18).zzz * 0.1 );
					float3 ifLocalVar40_g251741 = 0;
					if( TVE_DEBUG_Index == 18.0 )
					ifLocalVar40_g251741 = temp_output_2537_0;
					float3 ifLocalVar40_g251742 = 0;
					if( TVE_DEBUG_Index == 19.0 )
					ifLocalVar40_g251742 = (temp_output_2419_18).www;
					float4 temp_output_2419_24 = Out_FlowTexture15_g251644;
					float2 temp_output_2435_0 = (temp_output_2419_24).xy;
					float3 appendResult2501 = (float3(temp_output_2435_0 , 0.0));
					float3 ifLocalVar40_g251743 = 0;
					if( TVE_DEBUG_Index == 21.0 )
					ifLocalVar40_g251743 = ( appendResult2501 * appendResult2501 );
					float3 ifLocalVar40_g251744 = 0;
					if( TVE_DEBUG_Index == 22.0 )
					ifLocalVar40_g251744 = (temp_output_2419_24).zzz;
					float3 ifLocalVar40_g251745 = 0;
					if( TVE_DEBUG_Index == 23.0 )
					ifLocalVar40_g251745 = (temp_output_2419_24).www;
					half3 Final_Debug2399 = ( ifLocalVar40_g251757 + ( ifLocalVar40_g251674 + ifLocalVar40_g251675 + ifLocalVar40_g251731 ) + ( ifLocalVar40_g251732 + ifLocalVar40_g251733 ) + ( ifLocalVar40_g251734 + ifLocalVar40_g251735 + ifLocalVar40_g251736 + ifLocalVar40_g251737 ) + ( ifLocalVar40_g251738 + ifLocalVar40_g251739 ) + ( ifLocalVar40_g251740 + ifLocalVar40_g251741 + ifLocalVar40_g251742 ) + ( ifLocalVar40_g251743 + ifLocalVar40_g251744 + ifLocalVar40_g251745 ) );
					float temp_output_7_0_g251792 = TVE_DEBUG_Min;
					float3 temp_cast_17 = (temp_output_7_0_g251792).xxx;
					float3 temp_output_9_0_g251792 = ( Final_Debug2399 - temp_cast_17 );
					float lerpResult76_g251784 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g251784 = lerpResult76_g251784;
					float3 lerpResult72_g251784 = lerp( (lerpResult73_g251785).rgb , saturate( ( temp_output_9_0_g251792 / ( ( TVE_DEBUG_Max - temp_output_7_0_g251792 ) + 0.0001 ) ) ) , Filter152_g251784);
					float dotResult61_g251784 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g251784 = ( 1.0 - saturate( dotResult61_g251784 ) );
					float Shading_Fresnel59_g251784 = (( 1.0 - ( temp_output_65_0_g251784 * temp_output_65_0_g251784 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g251784 = IN.ase_texcoord9;
					float depthLinearEye57_g251784 = LinearEyeDepth( ase_positionCS57_g251784.z / ase_positionCS57_g251784.w );
					float temp_output_69_0_g251784 = saturate(  (0.0 + ( depthLinearEye57_g251784 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g251784 = (( temp_output_69_0_g251784 * temp_output_69_0_g251784 )*0.5 + 0.5);
					float lerpResult84_g251784 = lerp( 1.0 , Shading_Fresnel59_g251784 , ( Shading_Distance58_g251784 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g251789 = ( 0.0 );
					float localBuildVisualData3_g251763 = ( 0.0 );
					TVEVisualData Data3_g251763 =(TVEVisualData)0;
					half4 Dummy130_g251762 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) );
					float temp_output_14_0_g251763 = Dummy130_g251762.x;
					float In_Dummy3_g251763 = temp_output_14_0_g251763;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251782) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g251777 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g251777 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g251777 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g251777 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g251777 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g251777 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g251782 = staticSwitch36_g251777;
					float localBreakTextureData456_g251782 = ( 0.0 );
					float localBuildTextureData431_g251776 = ( 0.0 );
					TVEMasksData Data431_g251776 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g251776 = ( 0.0 );
					half4 Local_Coords180_g251762 = _main_coord_value;
					float4 Coords444_g251776 = Local_Coords180_g251762;
					TVEModelData Data15_g251775 =(TVEModelData)Data26_g251486;
					float Out_Dummy15_g251775 = 0.0;
					float3 Out_PositionWS15_g251775 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251775 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251775 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251775 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251775 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251775 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251775 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251775 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251775 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251775 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251775 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251775 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251775 , Out_Dummy15_g251775 , Out_PositionWS15_g251775 , Out_PositionWO15_g251775 , Out_PivotWS15_g251775 , Out_PivotWO15_g251775 , Out_NormalWS15_g251775 , Out_TangentWS15_g251775 , Out_BitangentWS15_g251775 , Out_TriplanarWeights15_g251775 , Out_ViewDirWS15_g251775 , Out_CoordsData15_g251775 , Out_VertexData15_g251775 , Out_PhaseData15_g251775 );
					float4 Model_CoordsData324_g251762 = Out_CoordsData15_g251775;
					float4 MeshCoords444_g251776 = Model_CoordsData324_g251762;
					float2 UV0444_g251776 = float2( 0,0 );
					float2 UV3444_g251776 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g251776 , MeshCoords444_g251776 , UV0444_g251776 , UV3444_g251776 );
					float4 appendResult430_g251776 = (float4(UV0444_g251776 , UV3444_g251776));
					float4 In_MaskA431_g251776 = appendResult430_g251776;
					float localComputeWorldCoords315_g251776 = ( 0.0 );
					float4 Coords315_g251776 = Local_Coords180_g251762;
					float3 Model_PositionWO222_g251762 = Out_PositionWO15_g251775;
					float3 PositionWS315_g251776 = Model_PositionWO222_g251762;
					float2 ZY315_g251776 = float2( 0,0 );
					float2 XZ315_g251776 = float2( 0,0 );
					float2 XY315_g251776 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g251776 , PositionWS315_g251776 , ZY315_g251776 , XZ315_g251776 , XY315_g251776 );
					float2 ZY402_g251776 = ZY315_g251776;
					float2 XZ403_g251776 = XZ315_g251776;
					float4 appendResult432_g251776 = (float4(ZY402_g251776 , XZ403_g251776));
					float4 In_MaskB431_g251776 = appendResult432_g251776;
					float2 XY404_g251776 = XY315_g251776;
					float localComputeStochasticCoords409_g251776 = ( 0.0 );
					float2 UV409_g251776 = ZY402_g251776;
					float2 UV1409_g251776 = float2( 0,0 );
					float2 UV2409_g251776 = float2( 0,0 );
					float2 UV3409_g251776 = float2( 0,0 );
					float3 Weights409_g251776 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g251776 , UV1409_g251776 , UV2409_g251776 , UV3409_g251776 , Weights409_g251776 );
					float4 appendResult433_g251776 = (float4(XY404_g251776 , UV1409_g251776));
					float4 In_MaskC431_g251776 = appendResult433_g251776;
					float4 appendResult434_g251776 = (float4(UV2409_g251776 , UV3409_g251776));
					float4 In_MaskD431_g251776 = appendResult434_g251776;
					float localComputeStochasticCoords422_g251776 = ( 0.0 );
					float2 UV422_g251776 = XZ403_g251776;
					float2 UV1422_g251776 = float2( 0,0 );
					float2 UV2422_g251776 = float2( 0,0 );
					float2 UV3422_g251776 = float2( 0,0 );
					float3 Weights422_g251776 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g251776 , UV1422_g251776 , UV2422_g251776 , UV3422_g251776 , Weights422_g251776 );
					float4 appendResult435_g251776 = (float4(UV1422_g251776 , UV2422_g251776));
					float4 In_MaskE431_g251776 = appendResult435_g251776;
					float localComputeStochasticCoords423_g251776 = ( 0.0 );
					float2 UV423_g251776 = XY404_g251776;
					float2 UV1423_g251776 = float2( 0,0 );
					float2 UV2423_g251776 = float2( 0,0 );
					float2 UV3423_g251776 = float2( 0,0 );
					float3 Weights423_g251776 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g251776 , UV1423_g251776 , UV2423_g251776 , UV3423_g251776 , Weights423_g251776 );
					float4 appendResult436_g251776 = (float4(UV3422_g251776 , UV1423_g251776));
					float4 In_MaskF431_g251776 = appendResult436_g251776;
					float4 appendResult437_g251776 = (float4(UV2423_g251776 , UV3423_g251776));
					float4 In_MaskG431_g251776 = appendResult437_g251776;
					float4 In_MaskH431_g251776 = float4( Weights409_g251776 , 0.0 );
					float4 In_MaskI431_g251776 = float4( Weights422_g251776 , 0.0 );
					float4 In_MaskJ431_g251776 = float4( Weights423_g251776 , 0.0 );
					half3 Model_NormalWS226_g251762 = Out_NormalWS15_g251775;
					float3 temp_output_449_0_g251776 = Model_NormalWS226_g251762;
					float4 In_MaskK431_g251776 = float4( temp_output_449_0_g251776 , 0.0 );
					half3 Model_TangentWS366_g251762 = Out_TangentWS15_g251775;
					float3 temp_output_450_0_g251776 = Model_TangentWS366_g251762;
					float4 In_MaskL431_g251776 = float4( temp_output_450_0_g251776 , 0.0 );
					half3 Model_BitangentWS367_g251762 = Out_BitangentWS15_g251775;
					float3 temp_output_451_0_g251776 = Model_BitangentWS367_g251762;
					float4 In_MaskM431_g251776 = float4( temp_output_451_0_g251776 , 0.0 );
					half3 Model_TriplanarWeights368_g251762 = Out_TriplanarWeights15_g251775;
					float3 temp_output_445_0_g251776 = Model_TriplanarWeights368_g251762;
					float4 In_MaskN431_g251776 = float4( temp_output_445_0_g251776 , 0.0 );
					BuildTextureData( Data431_g251776 , In_MaskA431_g251776 , In_MaskB431_g251776 , In_MaskC431_g251776 , In_MaskD431_g251776 , In_MaskE431_g251776 , In_MaskF431_g251776 , In_MaskG431_g251776 , In_MaskH431_g251776 , In_MaskI431_g251776 , In_MaskJ431_g251776 , In_MaskK431_g251776 , In_MaskL431_g251776 , In_MaskM431_g251776 , In_MaskN431_g251776 );
					TVEMasksData Data456_g251782 =(TVEMasksData)Data431_g251776;
					float4 Out_MaskA456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251782 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251782 , Out_MaskA456_g251782 , Out_MaskB456_g251782 , Out_MaskC456_g251782 , Out_MaskD456_g251782 , Out_MaskE456_g251782 , Out_MaskF456_g251782 , Out_MaskG456_g251782 , Out_MaskH456_g251782 , Out_MaskI456_g251782 , Out_MaskJ456_g251782 , Out_MaskK456_g251782 , Out_MaskL456_g251782 , Out_MaskM456_g251782 , Out_MaskN456_g251782 );
					half2 UV276_g251782 = (Out_MaskA456_g251782).xy;
					float temp_output_504_0_g251782 = 0.0;
					half Bias276_g251782 = temp_output_504_0_g251782;
					half2 Normal276_g251782 = float2( 0,0 );
					half4 localSampleCoord276_g251782 = SampleCoord( Texture276_g251782 , Sampler276_g251782 , UV276_g251782 , Bias276_g251782 , Normal276_g251782 );
					float4 temp_output_407_277_g251762 = localSampleCoord276_g251782;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251782) = _MainAlbedoTex;
					SamplerState Sampler502_g251782 = staticSwitch36_g251777;
					half2 UV502_g251782 = (Out_MaskA456_g251782).zw;
					half Bias502_g251782 = temp_output_504_0_g251782;
					half2 Normal502_g251782 = float2( 0,0 );
					half4 localSampleCoord502_g251782 = SampleCoord( Texture502_g251782 , Sampler502_g251782 , UV502_g251782 , Bias502_g251782 , Normal502_g251782 );
					float4 temp_output_407_278_g251762 = localSampleCoord502_g251782;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251782) = _MainAlbedoTex;
					SamplerState Sampler496_g251782 = staticSwitch36_g251777;
					float2 temp_output_463_0_g251782 = (Out_MaskB456_g251782).zw;
					half2 XZ496_g251782 = temp_output_463_0_g251782;
					half Bias496_g251782 = temp_output_504_0_g251782;
					float3 temp_output_483_0_g251782 = (Out_MaskK456_g251782).xyz;
					half3 NormalWS496_g251782 = temp_output_483_0_g251782;
					half3 Normal496_g251782 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251782 = SamplePlanar2D( Texture496_g251782 , Sampler496_g251782 , XZ496_g251782 , Bias496_g251782 , NormalWS496_g251782 , Normal496_g251782 );
					float4 temp_output_407_0_g251762 = localSamplePlanar2D496_g251782;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251782) = _MainAlbedoTex;
					SamplerState Sampler490_g251782 = staticSwitch36_g251777;
					float2 temp_output_462_0_g251782 = (Out_MaskB456_g251782).xy;
					half2 ZY490_g251782 = temp_output_462_0_g251782;
					half2 XZ490_g251782 = temp_output_463_0_g251782;
					float2 temp_output_464_0_g251782 = (Out_MaskC456_g251782).xy;
					half2 XY490_g251782 = temp_output_464_0_g251782;
					half Bias490_g251782 = temp_output_504_0_g251782;
					float3 temp_output_482_0_g251782 = (Out_MaskN456_g251782).xyz;
					half3 Triplanar490_g251782 = temp_output_482_0_g251782;
					half3 NormalWS490_g251782 = temp_output_483_0_g251782;
					half3 Normal490_g251782 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251782 = SamplePlanar3D( Texture490_g251782 , Sampler490_g251782 , ZY490_g251782 , XZ490_g251782 , XY490_g251782 , Bias490_g251782 , Triplanar490_g251782 , NormalWS490_g251782 , Normal490_g251782 );
					float4 temp_output_407_201_g251762 = localSamplePlanar3D490_g251782;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251782) = _MainAlbedoTex;
					SamplerState Sampler498_g251782 = staticSwitch36_g251777;
					half2 XZ498_g251782 = temp_output_463_0_g251782;
					float2 temp_output_473_0_g251782 = (Out_MaskE456_g251782).xy;
					half2 XZ_1498_g251782 = temp_output_473_0_g251782;
					float2 temp_output_474_0_g251782 = (Out_MaskE456_g251782).zw;
					half2 XZ_2498_g251782 = temp_output_474_0_g251782;
					float2 temp_output_475_0_g251782 = (Out_MaskF456_g251782).xy;
					half2 XZ_3498_g251782 = temp_output_475_0_g251782;
					float temp_output_510_0_g251782 = exp2( temp_output_504_0_g251782 );
					half Bias498_g251782 = temp_output_510_0_g251782;
					float3 temp_output_480_0_g251782 = (Out_MaskI456_g251782).xyz;
					half3 Weights_2498_g251782 = temp_output_480_0_g251782;
					half3 NormalWS498_g251782 = temp_output_483_0_g251782;
					half3 Normal498_g251782 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251782 = SampleStochastic2D( Texture498_g251782 , Sampler498_g251782 , XZ498_g251782 , XZ_1498_g251782 , XZ_2498_g251782 , XZ_3498_g251782 , Bias498_g251782 , Weights_2498_g251782 , NormalWS498_g251782 , Normal498_g251782 );
					float4 temp_output_407_202_g251762 = localSampleStochastic2D498_g251782;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251782) = _MainAlbedoTex;
					SamplerState Sampler500_g251782 = staticSwitch36_g251777;
					half2 ZY500_g251782 = temp_output_462_0_g251782;
					half2 ZY_1500_g251782 = (Out_MaskC456_g251782).zw;
					half2 ZY_2500_g251782 = (Out_MaskD456_g251782).xy;
					half2 ZY_3500_g251782 = (Out_MaskD456_g251782).zw;
					half2 XZ500_g251782 = temp_output_463_0_g251782;
					half2 XZ_1500_g251782 = temp_output_473_0_g251782;
					half2 XZ_2500_g251782 = temp_output_474_0_g251782;
					half2 XZ_3500_g251782 = temp_output_475_0_g251782;
					half2 XY500_g251782 = temp_output_464_0_g251782;
					half2 XY_1500_g251782 = (Out_MaskF456_g251782).zw;
					half2 XY_2500_g251782 = (Out_MaskG456_g251782).xy;
					half2 XY_3500_g251782 = (Out_MaskG456_g251782).zw;
					half Bias500_g251782 = temp_output_510_0_g251782;
					half3 Weights_1500_g251782 = (Out_MaskH456_g251782).xyz;
					half3 Weights_2500_g251782 = temp_output_480_0_g251782;
					half3 Weights_3500_g251782 = (Out_MaskJ456_g251782).xyz;
					half3 Triplanar500_g251782 = temp_output_482_0_g251782;
					half3 NormalWS500_g251782 = temp_output_483_0_g251782;
					half3 Normal500_g251782 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251782 = SampleStochastic3D( Texture500_g251782 , Sampler500_g251782 , ZY500_g251782 , ZY_1500_g251782 , ZY_2500_g251782 , ZY_3500_g251782 , XZ500_g251782 , XZ_1500_g251782 , XZ_2500_g251782 , XZ_3500_g251782 , XY500_g251782 , XY_1500_g251782 , XY_2500_g251782 , XY_3500_g251782 , Bias500_g251782 , Weights_1500_g251782 , Weights_2500_g251782 , Weights_3500_g251782 , Triplanar500_g251782 , NormalWS500_g251782 , Normal500_g251782 );
					float4 temp_output_407_203_g251762 = localSampleStochastic3D500_g251782;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g251762 = temp_output_407_277_g251762;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g251762 = temp_output_407_278_g251762;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g251762 = temp_output_407_0_g251762;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g251762 = temp_output_407_201_g251762;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g251762 = temp_output_407_202_g251762;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g251762 = temp_output_407_203_g251762;
					#else
					float4 staticSwitch184_g251762 = temp_output_407_277_g251762;
					#endif
					half4 Local_AlbedoSample185_g251762 = staticSwitch184_g251762;
					float3 lerpResult53_g251762 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g251762).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g251762 = lerpResult53_g251762;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251780) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g251779 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g251779 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g251779 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g251779 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g251779 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g251779 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251780 = staticSwitch38_g251779;
					float localBreakTextureData456_g251780 = ( 0.0 );
					TVEMasksData Data456_g251780 =(TVEMasksData)Data431_g251776;
					float4 Out_MaskA456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251780 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251780 , Out_MaskA456_g251780 , Out_MaskB456_g251780 , Out_MaskC456_g251780 , Out_MaskD456_g251780 , Out_MaskE456_g251780 , Out_MaskF456_g251780 , Out_MaskG456_g251780 , Out_MaskH456_g251780 , Out_MaskI456_g251780 , Out_MaskJ456_g251780 , Out_MaskK456_g251780 , Out_MaskL456_g251780 , Out_MaskM456_g251780 , Out_MaskN456_g251780 );
					half2 UV276_g251780 = (Out_MaskA456_g251780).xy;
					float temp_output_504_0_g251780 = 0.0;
					half Bias276_g251780 = temp_output_504_0_g251780;
					half2 Normal276_g251780 = float2( 0,0 );
					half4 localSampleCoord276_g251780 = SampleCoord( Texture276_g251780 , Sampler276_g251780 , UV276_g251780 , Bias276_g251780 , Normal276_g251780 );
					float4 temp_output_405_277_g251762 = localSampleCoord276_g251780;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251780) = _MainShaderTex;
					SamplerState Sampler502_g251780 = staticSwitch38_g251779;
					half2 UV502_g251780 = (Out_MaskA456_g251780).zw;
					half Bias502_g251780 = temp_output_504_0_g251780;
					half2 Normal502_g251780 = float2( 0,0 );
					half4 localSampleCoord502_g251780 = SampleCoord( Texture502_g251780 , Sampler502_g251780 , UV502_g251780 , Bias502_g251780 , Normal502_g251780 );
					float4 temp_output_405_278_g251762 = localSampleCoord502_g251780;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251780) = _MainShaderTex;
					SamplerState Sampler496_g251780 = staticSwitch38_g251779;
					float2 temp_output_463_0_g251780 = (Out_MaskB456_g251780).zw;
					half2 XZ496_g251780 = temp_output_463_0_g251780;
					half Bias496_g251780 = temp_output_504_0_g251780;
					float3 temp_output_483_0_g251780 = (Out_MaskK456_g251780).xyz;
					half3 NormalWS496_g251780 = temp_output_483_0_g251780;
					half3 Normal496_g251780 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251780 = SamplePlanar2D( Texture496_g251780 , Sampler496_g251780 , XZ496_g251780 , Bias496_g251780 , NormalWS496_g251780 , Normal496_g251780 );
					float4 temp_output_405_0_g251762 = localSamplePlanar2D496_g251780;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251780) = _MainShaderTex;
					SamplerState Sampler490_g251780 = staticSwitch38_g251779;
					float2 temp_output_462_0_g251780 = (Out_MaskB456_g251780).xy;
					half2 ZY490_g251780 = temp_output_462_0_g251780;
					half2 XZ490_g251780 = temp_output_463_0_g251780;
					float2 temp_output_464_0_g251780 = (Out_MaskC456_g251780).xy;
					half2 XY490_g251780 = temp_output_464_0_g251780;
					half Bias490_g251780 = temp_output_504_0_g251780;
					float3 temp_output_482_0_g251780 = (Out_MaskN456_g251780).xyz;
					half3 Triplanar490_g251780 = temp_output_482_0_g251780;
					half3 NormalWS490_g251780 = temp_output_483_0_g251780;
					half3 Normal490_g251780 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251780 = SamplePlanar3D( Texture490_g251780 , Sampler490_g251780 , ZY490_g251780 , XZ490_g251780 , XY490_g251780 , Bias490_g251780 , Triplanar490_g251780 , NormalWS490_g251780 , Normal490_g251780 );
					float4 temp_output_405_201_g251762 = localSamplePlanar3D490_g251780;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251780) = _MainShaderTex;
					SamplerState Sampler498_g251780 = staticSwitch38_g251779;
					half2 XZ498_g251780 = temp_output_463_0_g251780;
					float2 temp_output_473_0_g251780 = (Out_MaskE456_g251780).xy;
					half2 XZ_1498_g251780 = temp_output_473_0_g251780;
					float2 temp_output_474_0_g251780 = (Out_MaskE456_g251780).zw;
					half2 XZ_2498_g251780 = temp_output_474_0_g251780;
					float2 temp_output_475_0_g251780 = (Out_MaskF456_g251780).xy;
					half2 XZ_3498_g251780 = temp_output_475_0_g251780;
					float temp_output_510_0_g251780 = exp2( temp_output_504_0_g251780 );
					half Bias498_g251780 = temp_output_510_0_g251780;
					float3 temp_output_480_0_g251780 = (Out_MaskI456_g251780).xyz;
					half3 Weights_2498_g251780 = temp_output_480_0_g251780;
					half3 NormalWS498_g251780 = temp_output_483_0_g251780;
					half3 Normal498_g251780 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251780 = SampleStochastic2D( Texture498_g251780 , Sampler498_g251780 , XZ498_g251780 , XZ_1498_g251780 , XZ_2498_g251780 , XZ_3498_g251780 , Bias498_g251780 , Weights_2498_g251780 , NormalWS498_g251780 , Normal498_g251780 );
					float4 temp_output_405_202_g251762 = localSampleStochastic2D498_g251780;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251780) = _MainShaderTex;
					SamplerState Sampler500_g251780 = staticSwitch38_g251779;
					half2 ZY500_g251780 = temp_output_462_0_g251780;
					half2 ZY_1500_g251780 = (Out_MaskC456_g251780).zw;
					half2 ZY_2500_g251780 = (Out_MaskD456_g251780).xy;
					half2 ZY_3500_g251780 = (Out_MaskD456_g251780).zw;
					half2 XZ500_g251780 = temp_output_463_0_g251780;
					half2 XZ_1500_g251780 = temp_output_473_0_g251780;
					half2 XZ_2500_g251780 = temp_output_474_0_g251780;
					half2 XZ_3500_g251780 = temp_output_475_0_g251780;
					half2 XY500_g251780 = temp_output_464_0_g251780;
					half2 XY_1500_g251780 = (Out_MaskF456_g251780).zw;
					half2 XY_2500_g251780 = (Out_MaskG456_g251780).xy;
					half2 XY_3500_g251780 = (Out_MaskG456_g251780).zw;
					half Bias500_g251780 = temp_output_510_0_g251780;
					half3 Weights_1500_g251780 = (Out_MaskH456_g251780).xyz;
					half3 Weights_2500_g251780 = temp_output_480_0_g251780;
					half3 Weights_3500_g251780 = (Out_MaskJ456_g251780).xyz;
					half3 Triplanar500_g251780 = temp_output_482_0_g251780;
					half3 NormalWS500_g251780 = temp_output_483_0_g251780;
					half3 Normal500_g251780 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251780 = SampleStochastic3D( Texture500_g251780 , Sampler500_g251780 , ZY500_g251780 , ZY_1500_g251780 , ZY_2500_g251780 , ZY_3500_g251780 , XZ500_g251780 , XZ_1500_g251780 , XZ_2500_g251780 , XZ_3500_g251780 , XY500_g251780 , XY_1500_g251780 , XY_2500_g251780 , XY_3500_g251780 , Bias500_g251780 , Weights_1500_g251780 , Weights_2500_g251780 , Weights_3500_g251780 , Triplanar500_g251780 , NormalWS500_g251780 , Normal500_g251780 );
					float4 temp_output_405_203_g251762 = localSampleStochastic3D500_g251780;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g251762 = temp_output_405_277_g251762;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g251762 = temp_output_405_278_g251762;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g251762 = temp_output_405_0_g251762;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g251762 = temp_output_405_201_g251762;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g251762 = temp_output_405_202_g251762;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g251762 = temp_output_405_203_g251762;
					#else
					float4 staticSwitch198_g251762 = temp_output_405_277_g251762;
					#endif
					half4 Local_ShaderSample199_g251762 = staticSwitch198_g251762;
					float temp_output_209_0_g251762 = (Local_ShaderSample199_g251762).y;
					float temp_output_7_0_g251768 = _MainOcclusionRemap.x;
					float temp_output_9_0_g251768 = ( temp_output_209_0_g251762 - temp_output_7_0_g251768 );
					float lerpResult23_g251762 = lerp( 1.0 , saturate( ( temp_output_9_0_g251768 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g251762 = lerpResult23_g251762;
					float temp_output_213_0_g251762 = (Local_ShaderSample199_g251762).w;
					float temp_output_7_0_g251772 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g251772 = ( temp_output_213_0_g251762 - temp_output_7_0_g251772 );
					half Local_Smoothness317_g251762 = ( saturate( ( temp_output_9_0_g251772 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g251762 = (float4(( (Local_ShaderSample199_g251762).x * _MainMetallicValue ) , Local_Occlusion313_g251762 , (Local_ShaderSample199_g251762).z , Local_Smoothness317_g251762));
					half4 Local_Masks109_g251762 = appendResult73_g251762;
					float temp_output_135_0_g251762 = (Local_Masks109_g251762).z;
					float temp_output_7_0_g251767 = _MainMultiRemap.x;
					float temp_output_9_0_g251767 = ( temp_output_135_0_g251762 - temp_output_7_0_g251767 );
					float temp_output_42_0_g251762 = saturate( ( temp_output_9_0_g251767 * _MainMultiRemap.z ) );
					half Local_MultiMask78_g251762 = temp_output_42_0_g251762;
					float lerpResult58_g251762 = lerp( 1.0 , Local_MultiMask78_g251762 , _MainColorMode);
					float4 lerpResult62_g251762 = lerp( _MainColorTwo , _MainColor , lerpResult58_g251762);
					half3 Local_ColorRGB93_g251762 = (lerpResult62_g251762).rgb;
					half3 Local_Albedo139_g251762 = ( Local_AlbedoRGB107_g251762 * Local_ColorRGB93_g251762 );
					float3 temp_output_4_0_g251763 = Local_Albedo139_g251762;
					float3 In_Albedo3_g251763 = temp_output_4_0_g251763;
					float3 temp_output_44_0_g251763 = Local_Albedo139_g251762;
					float3 In_AlbedoBase3_g251763 = temp_output_44_0_g251763;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251781) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g251778 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g251778 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g251778 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g251778 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g251778 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g251778 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251781 = staticSwitch37_g251778;
					float localBreakTextureData456_g251781 = ( 0.0 );
					TVEMasksData Data456_g251781 =(TVEMasksData)Data431_g251776;
					float4 Out_MaskA456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251781 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251781 , Out_MaskA456_g251781 , Out_MaskB456_g251781 , Out_MaskC456_g251781 , Out_MaskD456_g251781 , Out_MaskE456_g251781 , Out_MaskF456_g251781 , Out_MaskG456_g251781 , Out_MaskH456_g251781 , Out_MaskI456_g251781 , Out_MaskJ456_g251781 , Out_MaskK456_g251781 , Out_MaskL456_g251781 , Out_MaskM456_g251781 , Out_MaskN456_g251781 );
					half2 UV276_g251781 = (Out_MaskA456_g251781).xy;
					float temp_output_504_0_g251781 = 0.0;
					half Bias276_g251781 = temp_output_504_0_g251781;
					half2 Normal276_g251781 = float2( 0,0 );
					half4 localSampleCoord276_g251781 = SampleCoord( Texture276_g251781 , Sampler276_g251781 , UV276_g251781 , Bias276_g251781 , Normal276_g251781 );
					float2 temp_output_406_394_g251762 = Normal276_g251781;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251781) = _MainNormalTex;
					SamplerState Sampler502_g251781 = staticSwitch37_g251778;
					half2 UV502_g251781 = (Out_MaskA456_g251781).zw;
					half Bias502_g251781 = temp_output_504_0_g251781;
					half2 Normal502_g251781 = float2( 0,0 );
					half4 localSampleCoord502_g251781 = SampleCoord( Texture502_g251781 , Sampler502_g251781 , UV502_g251781 , Bias502_g251781 , Normal502_g251781 );
					float2 temp_output_406_397_g251762 = Normal502_g251781;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251781) = _MainNormalTex;
					SamplerState Sampler496_g251781 = staticSwitch37_g251778;
					float2 temp_output_463_0_g251781 = (Out_MaskB456_g251781).zw;
					half2 XZ496_g251781 = temp_output_463_0_g251781;
					half Bias496_g251781 = temp_output_504_0_g251781;
					float3 temp_output_483_0_g251781 = (Out_MaskK456_g251781).xyz;
					half3 NormalWS496_g251781 = temp_output_483_0_g251781;
					half3 Normal496_g251781 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251781 = SamplePlanar2D( Texture496_g251781 , Sampler496_g251781 , XZ496_g251781 , Bias496_g251781 , NormalWS496_g251781 , Normal496_g251781 );
					float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
					float3 worldToTangentDir408_g251781 = normalize( mul( ase_worldToTangent, Normal496_g251781 ) );
					float2 temp_output_406_375_g251762 = (worldToTangentDir408_g251781).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251781) = _MainNormalTex;
					SamplerState Sampler490_g251781 = staticSwitch37_g251778;
					float2 temp_output_462_0_g251781 = (Out_MaskB456_g251781).xy;
					half2 ZY490_g251781 = temp_output_462_0_g251781;
					half2 XZ490_g251781 = temp_output_463_0_g251781;
					float2 temp_output_464_0_g251781 = (Out_MaskC456_g251781).xy;
					half2 XY490_g251781 = temp_output_464_0_g251781;
					half Bias490_g251781 = temp_output_504_0_g251781;
					float3 temp_output_482_0_g251781 = (Out_MaskN456_g251781).xyz;
					half3 Triplanar490_g251781 = temp_output_482_0_g251781;
					half3 NormalWS490_g251781 = temp_output_483_0_g251781;
					half3 Normal490_g251781 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251781 = SamplePlanar3D( Texture490_g251781 , Sampler490_g251781 , ZY490_g251781 , XZ490_g251781 , XY490_g251781 , Bias490_g251781 , Triplanar490_g251781 , NormalWS490_g251781 , Normal490_g251781 );
					float3 worldToTangentDir399_g251781 = normalize( mul( ase_worldToTangent, Normal490_g251781 ) );
					float2 temp_output_406_353_g251762 = (worldToTangentDir399_g251781).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251781) = _MainNormalTex;
					SamplerState Sampler498_g251781 = staticSwitch37_g251778;
					half2 XZ498_g251781 = temp_output_463_0_g251781;
					float2 temp_output_473_0_g251781 = (Out_MaskE456_g251781).xy;
					half2 XZ_1498_g251781 = temp_output_473_0_g251781;
					float2 temp_output_474_0_g251781 = (Out_MaskE456_g251781).zw;
					half2 XZ_2498_g251781 = temp_output_474_0_g251781;
					float2 temp_output_475_0_g251781 = (Out_MaskF456_g251781).xy;
					half2 XZ_3498_g251781 = temp_output_475_0_g251781;
					float temp_output_510_0_g251781 = exp2( temp_output_504_0_g251781 );
					half Bias498_g251781 = temp_output_510_0_g251781;
					float3 temp_output_480_0_g251781 = (Out_MaskI456_g251781).xyz;
					half3 Weights_2498_g251781 = temp_output_480_0_g251781;
					half3 NormalWS498_g251781 = temp_output_483_0_g251781;
					half3 Normal498_g251781 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251781 = SampleStochastic2D( Texture498_g251781 , Sampler498_g251781 , XZ498_g251781 , XZ_1498_g251781 , XZ_2498_g251781 , XZ_3498_g251781 , Bias498_g251781 , Weights_2498_g251781 , NormalWS498_g251781 , Normal498_g251781 );
					float3 worldToTangentDir411_g251781 = normalize( mul( ase_worldToTangent, Normal498_g251781 ) );
					float2 temp_output_406_391_g251762 = (worldToTangentDir411_g251781).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251781) = _MainNormalTex;
					SamplerState Sampler500_g251781 = staticSwitch37_g251778;
					half2 ZY500_g251781 = temp_output_462_0_g251781;
					half2 ZY_1500_g251781 = (Out_MaskC456_g251781).zw;
					half2 ZY_2500_g251781 = (Out_MaskD456_g251781).xy;
					half2 ZY_3500_g251781 = (Out_MaskD456_g251781).zw;
					half2 XZ500_g251781 = temp_output_463_0_g251781;
					half2 XZ_1500_g251781 = temp_output_473_0_g251781;
					half2 XZ_2500_g251781 = temp_output_474_0_g251781;
					half2 XZ_3500_g251781 = temp_output_475_0_g251781;
					half2 XY500_g251781 = temp_output_464_0_g251781;
					half2 XY_1500_g251781 = (Out_MaskF456_g251781).zw;
					half2 XY_2500_g251781 = (Out_MaskG456_g251781).xy;
					half2 XY_3500_g251781 = (Out_MaskG456_g251781).zw;
					half Bias500_g251781 = temp_output_510_0_g251781;
					half3 Weights_1500_g251781 = (Out_MaskH456_g251781).xyz;
					half3 Weights_2500_g251781 = temp_output_480_0_g251781;
					half3 Weights_3500_g251781 = (Out_MaskJ456_g251781).xyz;
					half3 Triplanar500_g251781 = temp_output_482_0_g251781;
					half3 NormalWS500_g251781 = temp_output_483_0_g251781;
					half3 Normal500_g251781 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251781 = SampleStochastic3D( Texture500_g251781 , Sampler500_g251781 , ZY500_g251781 , ZY_1500_g251781 , ZY_2500_g251781 , ZY_3500_g251781 , XZ500_g251781 , XZ_1500_g251781 , XZ_2500_g251781 , XZ_3500_g251781 , XY500_g251781 , XY_1500_g251781 , XY_2500_g251781 , XY_3500_g251781 , Bias500_g251781 , Weights_1500_g251781 , Weights_2500_g251781 , Weights_3500_g251781 , Triplanar500_g251781 , NormalWS500_g251781 , Normal500_g251781 );
					float3 worldToTangentDir403_g251781 = normalize( mul( ase_worldToTangent, Normal500_g251781 ) );
					float2 temp_output_406_390_g251762 = (worldToTangentDir403_g251781).xy;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g251762 = temp_output_406_394_g251762;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g251762 = temp_output_406_397_g251762;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g251762 = temp_output_406_375_g251762;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g251762 = temp_output_406_353_g251762;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g251762 = temp_output_406_391_g251762;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g251762 = temp_output_406_390_g251762;
					#else
					float2 staticSwitch193_g251762 = temp_output_406_394_g251762;
					#endif
					half2 Local_NormaSample191_g251762 = staticSwitch193_g251762;
					half2 Local_NormalTS108_g251762 = ( Local_NormaSample191_g251762 * _MainNormalValue );
					float2 In_NormalTS3_g251763 = Local_NormalTS108_g251762;
					float3 appendResult68_g251774 = (float3(Local_NormalTS108_g251762 , 1.0));
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal74_g251774 = appendResult68_g251774;
					float3 worldNormal74_g251774 = normalize( float3( dot( tanToWorld0, tanNormal74_g251774 ), dot( tanToWorld1, tanNormal74_g251774 ), dot( tanToWorld2, tanNormal74_g251774 ) ) );
					half3 Local_NormalWS250_g251762 = worldNormal74_g251774;
					float3 In_NormalWS3_g251763 = Local_NormalWS250_g251762;
					float4 In_Shader3_g251763 = Local_Masks109_g251762;
					float4 In_Feature3_g251763 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251763 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251763 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g251771 = Local_Albedo139_g251762;
					float dotResult20_g251771 = dot( temp_output_3_0_g251771 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g251762 = dotResult20_g251771;
					float temp_output_12_0_g251763 = Local_Grayscale110_g251762;
					float In_Grayscale3_g251763 = temp_output_12_0_g251763;
					float clampResult27_g251773 = clamp( saturate( ( Local_Grayscale110_g251762 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g251762 = clampResult27_g251773;
					float temp_output_16_0_g251763 = Local_Luminosity145_g251762;
					float In_Luminosity3_g251763 = temp_output_16_0_g251763;
					float In_MultiMask3_g251763 = Local_MultiMask78_g251762;
					float temp_output_187_0_g251762 = (Local_AlbedoSample185_g251762).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g251762 = ( temp_output_187_0_g251762 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g251762 = temp_output_187_0_g251762;
					#endif
					half Local_AlphaClip111_g251762 = staticSwitch236_g251762;
					float In_AlphaClip3_g251763 = Local_AlphaClip111_g251762;
					half Local_AlphaFade246_g251762 = (lerpResult62_g251762).a;
					float In_AlphaFade3_g251763 = Local_AlphaFade246_g251762;
					float3 temp_cast_26 = (1.0).xxx;
					float3 In_Translucency3_g251763 = temp_cast_26;
					float In_Transmission3_g251763 = 1.0;
					float In_Thickness3_g251763 = 0.0;
					float In_Diffusion3_g251763 = 0.0;
					float In_Depth3_g251763 = 0.0;
					BuildVisualData( Data3_g251763 , In_Dummy3_g251763 , In_Albedo3_g251763 , In_AlbedoBase3_g251763 , In_NormalTS3_g251763 , In_NormalWS3_g251763 , In_Shader3_g251763 , In_Feature3_g251763 , In_Season3_g251763 , In_Emissive3_g251763 , In_Grayscale3_g251763 , In_Luminosity3_g251763 , In_MultiMask3_g251763 , In_AlphaClip3_g251763 , In_AlphaFade3_g251763 , In_Translucency3_g251763 , In_Transmission3_g251763 , In_Thickness3_g251763 , In_Diffusion3_g251763 , In_Depth3_g251763 );
					TVEVisualData Data4_g251789 =(TVEVisualData)Data3_g251763;
					float Out_Dummy4_g251789 = 0.0;
					float3 Out_Albedo4_g251789 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251789 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251789 = float2( 0,0 );
					float3 Out_NormalWS4_g251789 = float3( 0,0,0 );
					float4 Out_Shader4_g251789 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251789 = float4( 0,0,0,0 );
					float4 Out_Season4_g251789 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251789 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251789 = 0.0;
					float Out_Grayscale4_g251789 = 0.0;
					float Out_Luminosity4_g251789 = 0.0;
					float Out_AlphaClip4_g251789 = 0.0;
					float Out_AlphaFade4_g251789 = 0.0;
					float3 Out_Translucency4_g251789 = float3( 0,0,0 );
					float Out_Transmission4_g251789 = 0.0;
					float Out_Thickness4_g251789 = 0.0;
					float Out_Diffusion4_g251789 = 0.0;
					float Out_Depth4_g251789 = 0.0;
					BreakVisualData( Data4_g251789 , Out_Dummy4_g251789 , Out_Albedo4_g251789 , Out_AlbedoBase4_g251789 , Out_NormalTS4_g251789 , Out_NormalWS4_g251789 , Out_Shader4_g251789 , Out_Feature4_g251789 , Out_Season4_g251789 , Out_Emissive4_g251789 , Out_MultiMask4_g251789 , Out_Grayscale4_g251789 , Out_Luminosity4_g251789 , Out_AlphaClip4_g251789 , Out_AlphaFade4_g251789 , Out_Translucency4_g251789 , Out_Transmission4_g251789 , Out_Thickness4_g251789 , Out_Diffusion4_g251789 , Out_Depth4_g251789 );
					float Alpha109_g251784 = Out_AlphaClip4_g251789;
					float lerpResult91_g251784 = lerp( 1.0 , Alpha109_g251784 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g251784 = lerp( 1.0 , lerpResult91_g251784 , Filter152_g251784);
					clip( lerpResult154_g251784 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2587_114;
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

					o.Emission = ( lerpResult72_g251784 * lerpResult84_g251784 );
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
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_COLOR
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
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

				uniform half TVE_DEBUG_Index;
				uniform half TVE_DEBUG_Clip;
				uniform half TVE_DEBUG_Min;
				uniform half TVE_DEBUG_Max;
				uniform half TVE_DEBUG_Shading;
				uniform half _IsTVEShader;
				uniform half TVE_DEBUG_Filter;
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
				uniform float4 TVE_RenderBasePositionR;
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

					float localIfModelDataByShader26_g251487 = ( 0.0 );
					TVEModelData Data26_g251487 = (TVEModelData)0;
					TVEModelData Data16_g251476 =(TVEModelData)0;
					half Dummy207_g251466 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g251476 = Dummy207_g251466;
					float In_Dummy16_g251476 = temp_output_14_0_g251476;
					float3 PositionOS131_g251466 = v.vertex.xyz;
					float3 temp_output_4_0_g251476 = PositionOS131_g251466;
					float3 In_PositionOS16_g251476 = temp_output_4_0_g251476;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g251466 = ase_positionWS;
					float3 vertexToFrag73_g251466 = temp_output_104_7_g251466;
					float3 PositionWS122_g251466 = vertexToFrag73_g251466;
					float3 In_PositionWS16_g251476 = PositionWS122_g251466;
					float4x4 break19_g251469 = unity_ObjectToWorld;
					float3 appendResult20_g251469 = (float3(break19_g251469[ 0 ][ 3 ] , break19_g251469[ 1 ][ 3 ] , break19_g251469[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251466 = appendResult20_g251469;
					float4x4 break19_g251471 = unity_ObjectToWorld;
					float3 appendResult20_g251471 = (float3(break19_g251471[ 0 ][ 3 ] , break19_g251471[ 1 ][ 3 ] , break19_g251471[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g251467 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g251466 = PositionOS131_g251466;
					float3 appendResult234_g251466 = (float3(break233_g251466.x , 0.0 , break233_g251466.z));
					float3 break413_g251466 = PositionOS131_g251466;
					float3 appendResult414_g251466 = (float3(break413_g251466.x , break413_g251466.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251473 = appendResult414_g251466;
					#else
					float3 staticSwitch65_g251473 = appendResult234_g251466;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g251466 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g251466 = appendResult60_g251467;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g251466 = staticSwitch65_g251473;
					#else
					float3 staticSwitch229_g251466 = _Vector0;
					#endif
					float3 PivotOS149_g251466 = staticSwitch229_g251466;
					float3 temp_output_122_0_g251471 = PivotOS149_g251466;
					float3 PivotsOnlyWS105_g251471 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g251471 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g251466 = ( appendResult20_g251471 + PivotsOnlyWS105_g251471 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g251466 = temp_output_340_7_g251466;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g251466 = temp_output_341_7_g251466;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g251466 = temp_output_341_7_g251466;
					#else
					float3 staticSwitch236_g251466 = temp_output_340_7_g251466;
					#endif
					float3 vertexToFrag76_g251466 = staticSwitch236_g251466;
					float3 PivotWS121_g251466 = vertexToFrag76_g251466;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251466 = ( PositionWS122_g251466 - PivotWS121_g251466 );
					#else
					float3 staticSwitch204_g251466 = PositionWS122_g251466;
					#endif
					float3 PositionWO132_g251466 = ( staticSwitch204_g251466 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251476 = PositionWO132_g251466;
					float3 In_PositionRawOS16_g251476 = PositionOS131_g251466;
					float3 In_PivotOS16_g251476 = PivotOS149_g251466;
					float3 In_PivotWS16_g251476 = PivotWS121_g251466;
					float3 PivotWO133_g251466 = ( PivotWS121_g251466 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251476 = PivotWO133_g251466;
					half3 NormalOS134_g251466 = v.normal;
					float3 temp_output_21_0_g251476 = NormalOS134_g251466;
					float3 In_NormalOS16_g251476 = temp_output_21_0_g251476;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g251466 = normalizedWorldNormal;
					float3 In_NormalWS16_g251476 = NormalWS95_g251466;
					float3 In_NormalRawOS16_g251476 = NormalOS134_g251466;
					half4 TangentlOS153_g251466 = v.tangent;
					float4 temp_output_6_0_g251476 = TangentlOS153_g251466;
					float4 In_TangentOS16_g251476 = temp_output_6_0_g251476;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g251466 = ase_tangentWS;
					float3 In_TangentWS16_g251476 = TangentWS136_g251466;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g251466 = ase_bitangentWS;
					float3 In_BitangentWS16_g251476 = BiangentWS421_g251466;
					float3 normalizeResult296_g251466 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251466 ) );
					half3 ViewDirWS169_g251466 = normalizeResult296_g251466;
					float3 In_ViewDirWS16_g251476 = ViewDirWS169_g251466;
					float4 appendResult397_g251466 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g251466 = appendResult397_g251466;
					float4 In_CoordsData16_g251476 = CoordsData398_g251466;
					half4 VertexMasks171_g251466 = v.ase_color;
					float4 In_VertexData16_g251476 = VertexMasks171_g251466;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251479 = (PositionOS131_g251466).z;
					#else
					float staticSwitch65_g251479 = (PositionOS131_g251466).y;
					#endif
					half Object_HeightValue267_g251466 = _ObjectHeightValue;
					half Bounds_HeightMask274_g251466 = saturate( ( staticSwitch65_g251479 / Object_HeightValue267_g251466 ) );
					half3 Position387_g251466 = PositionOS131_g251466;
					half Height387_g251466 = Object_HeightValue267_g251466;
					half Object_RadiusValue268_g251466 = _ObjectRadiusValue;
					half Radius387_g251466 = Object_RadiusValue268_g251466;
					half localCapsuleMaskYUp387_g251466 = CapsuleMaskYUp( Position387_g251466 , Height387_g251466 , Radius387_g251466 );
					half3 Position408_g251466 = PositionOS131_g251466;
					half Height408_g251466 = Object_HeightValue267_g251466;
					half Radius408_g251466 = Object_RadiusValue268_g251466;
					half localCapsuleMaskZUp408_g251466 = CapsuleMaskZUp( Position408_g251466 , Height408_g251466 , Radius408_g251466 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251484 = saturate( localCapsuleMaskZUp408_g251466 );
					#else
					float staticSwitch65_g251484 = saturate( localCapsuleMaskYUp387_g251466 );
					#endif
					half Bounds_SphereMask282_g251466 = staticSwitch65_g251484;
					float4 appendResult253_g251466 = (float4(Bounds_HeightMask274_g251466 , Bounds_SphereMask282_g251466 , 1.0 , 1.0));
					half4 MasksData254_g251466 = appendResult253_g251466;
					float4 In_MasksData16_g251476 = MasksData254_g251466;
					float temp_output_17_0_g251478 = _ObjectPhaseMode;
					float Option70_g251478 = temp_output_17_0_g251478;
					float4 temp_output_3_0_g251478 = v.ase_color;
					float4 Channel70_g251478 = temp_output_3_0_g251478;
					float localSwitchChannel470_g251478 = SwitchChannel4( Option70_g251478 , Channel70_g251478 );
					half Phase_Value372_g251466 = localSwitchChannel470_g251478;
					float3 break319_g251466 = PivotWO133_g251466;
					half Pivot_Position322_g251466 = ( break319_g251466.x + break319_g251466.z );
					half Phase_Position357_g251466 = ( Phase_Value372_g251466 + Pivot_Position322_g251466 );
					float temp_output_248_0_g251466 = frac( Phase_Position357_g251466 );
					float4 appendResult177_g251466 = (float4(( (frac( ( Phase_Position357_g251466 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g251466));
					half4 Phase_Data176_g251466 = appendResult177_g251466;
					float4 In_PhaseData16_g251476 = Phase_Data176_g251466;
					float4 In_TransformData16_g251476 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251476 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g251476 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g251476 , In_Dummy16_g251476 , In_PositionOS16_g251476 , In_PositionWS16_g251476 , In_PositionWO16_g251476 , In_PositionRawOS16_g251476 , In_PivotOS16_g251476 , In_PivotWS16_g251476 , In_PivotWO16_g251476 , In_NormalOS16_g251476 , In_NormalWS16_g251476 , In_NormalRawOS16_g251476 , In_TangentOS16_g251476 , In_TangentWS16_g251476 , In_BitangentWS16_g251476 , In_ViewDirWS16_g251476 , In_CoordsData16_g251476 , In_VertexData16_g251476 , In_MasksData16_g251476 , In_PhaseData16_g251476 , In_TransformData16_g251476 , In_RotationData16_g251476 , In_InterpolatorA16_g251476 );
					TVEModelData DataDefault26_g251487 = Data16_g251476;
					TVEModelData DataGeneral26_g251487 = Data16_g251476;
					TVEModelData DataBlanket26_g251487 = Data16_g251476;
					TVEModelData DataImpostor26_g251487 = Data16_g251476;
					TVEModelData Data16_g251456 =(TVEModelData)0;
					half Dummy207_g251446 = 0.0;
					float temp_output_14_0_g251456 = Dummy207_g251446;
					float In_Dummy16_g251456 = temp_output_14_0_g251456;
					float3 PositionOS131_g251446 = v.vertex.xyz;
					float3 temp_output_4_0_g251456 = PositionOS131_g251446;
					float3 In_PositionOS16_g251456 = temp_output_4_0_g251456;
					float3 temp_output_104_7_g251446 = ase_positionWS;
					float3 PositionWS122_g251446 = temp_output_104_7_g251446;
					float3 In_PositionWS16_g251456 = PositionWS122_g251446;
					float4x4 break19_g251449 = unity_ObjectToWorld;
					float3 appendResult20_g251449 = (float3(break19_g251449[ 0 ][ 3 ] , break19_g251449[ 1 ][ 3 ] , break19_g251449[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251446 = appendResult20_g251449;
					float3 PivotWS121_g251446 = temp_output_340_7_g251446;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251446 = ( PositionWS122_g251446 - PivotWS121_g251446 );
					#else
					float3 staticSwitch204_g251446 = PositionWS122_g251446;
					#endif
					float3 PositionWO132_g251446 = ( staticSwitch204_g251446 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251456 = PositionWO132_g251446;
					float3 In_PositionRawOS16_g251456 = PositionOS131_g251446;
					float3 PivotOS149_g251446 = _Vector0;
					float3 In_PivotOS16_g251456 = PivotOS149_g251446;
					float3 In_PivotWS16_g251456 = PivotWS121_g251446;
					float3 PivotWO133_g251446 = ( PivotWS121_g251446 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251456 = PivotWO133_g251446;
					half3 NormalOS134_g251446 = v.normal;
					float3 temp_output_21_0_g251456 = NormalOS134_g251446;
					float3 In_NormalOS16_g251456 = temp_output_21_0_g251456;
					half3 NormalWS95_g251446 = normalizedWorldNormal;
					float3 In_NormalWS16_g251456 = NormalWS95_g251446;
					float3 In_NormalRawOS16_g251456 = NormalOS134_g251446;
					half4 TangentlOS153_g251446 = v.tangent;
					float4 temp_output_6_0_g251456 = TangentlOS153_g251446;
					float4 In_TangentOS16_g251456 = temp_output_6_0_g251456;
					half3 TangentWS136_g251446 = ase_tangentWS;
					float3 In_TangentWS16_g251456 = TangentWS136_g251446;
					half3 BiangentWS421_g251446 = ase_bitangentWS;
					float3 In_BitangentWS16_g251456 = BiangentWS421_g251446;
					float3 normalizeResult296_g251446 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251446 ) );
					half3 ViewDirWS169_g251446 = normalizeResult296_g251446;
					float3 In_ViewDirWS16_g251456 = ViewDirWS169_g251446;
					float4 appendResult397_g251446 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g251446 = appendResult397_g251446;
					float4 In_CoordsData16_g251456 = CoordsData398_g251446;
					half4 VertexMasks171_g251446 = float4( 0,0,0,0 );
					float4 In_VertexData16_g251456 = VertexMasks171_g251446;
					half4 MasksData254_g251446 = float4( 0,0,0,0 );
					float4 In_MasksData16_g251456 = MasksData254_g251446;
					half4 Phase_Data176_g251446 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g251456 = Phase_Data176_g251446;
					float4 In_TransformData16_g251456 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251456 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g251456 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g251456 , In_Dummy16_g251456 , In_PositionOS16_g251456 , In_PositionWS16_g251456 , In_PositionWO16_g251456 , In_PositionRawOS16_g251456 , In_PivotOS16_g251456 , In_PivotWS16_g251456 , In_PivotWO16_g251456 , In_NormalOS16_g251456 , In_NormalWS16_g251456 , In_NormalRawOS16_g251456 , In_TangentOS16_g251456 , In_TangentWS16_g251456 , In_BitangentWS16_g251456 , In_ViewDirWS16_g251456 , In_CoordsData16_g251456 , In_VertexData16_g251456 , In_MasksData16_g251456 , In_PhaseData16_g251456 , In_TransformData16_g251456 , In_RotationData16_g251456 , In_InterpolatorA16_g251456 );
					TVEModelData DataTerrain26_g251487 = Data16_g251456;
					half IsShaderType2544 = _IsShaderType;
					float Type26_g251487 = IsShaderType2544;
					{
					if (Type26_g251487 == 0 )
					{
					Data26_g251487 = DataDefault26_g251487;
					}
					else if (Type26_g251487 == 1 )
					{
					Data26_g251487 = DataGeneral26_g251487;
					}
					else if (Type26_g251487 == 2 )
					{
					Data26_g251487 = DataBlanket26_g251487;
					}
					else if (Type26_g251487 == 3 )
					{
					Data26_g251487 = DataImpostor26_g251487;
					}
					else if (Type26_g251487 == 4 )
					{
					Data26_g251487 = DataTerrain26_g251487;
					}
					}
					TVEModelData Data15_g251646 =(TVEModelData)Data26_g251487;
					float Out_Dummy15_g251646 = 0.0;
					float3 Out_PositionOS15_g251646 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251646 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251646 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251646 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251646 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251646 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251646 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251646 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251646 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251646 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251646 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251646 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251646 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251646 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251646 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251646 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251646 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251646 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251646 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251646 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251646 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251646 , Out_Dummy15_g251646 , Out_PositionOS15_g251646 , Out_PositionWS15_g251646 , Out_PositionWO15_g251646 , Out_PositionRawOS15_g251646 , Out_PivotOS15_g251646 , Out_PivotWS15_g251646 , Out_PivotWO15_g251646 , Out_NormalOS15_g251646 , Out_NormalWS15_g251646 , Out_NormalRawOS15_g251646 , Out_TangentOS15_g251646 , Out_TangentWS15_g251646 , Out_BitangentWS15_g251646 , Out_ViewDirWS15_g251646 , Out_CoordsData15_g251646 , Out_VertexData15_g251646 , Out_MasksData15_g251646 , Out_PhaseData15_g251646 , Out_TransformData15_g251646 , Out_RotationData15_g251646 , Out_InterpolatorA15_g251646 );
					TVEModelData Data16_g251648 =(TVEModelData)Data15_g251646;
					float temp_output_14_0_g251648 = 0.0;
					float In_Dummy16_g251648 = temp_output_14_0_g251648;
					float3 temp_output_219_24_g251645 = Out_PivotOS15_g251646;
					float3 temp_output_215_0_g251645 = ( Out_PositionOS15_g251646 - temp_output_219_24_g251645 );
					float3 temp_output_4_0_g251648 = temp_output_215_0_g251645;
					float3 In_PositionOS16_g251648 = temp_output_4_0_g251648;
					float3 In_PositionWS16_g251648 = Out_PositionWS15_g251646;
					float3 In_PositionWO16_g251648 = Out_PositionWO15_g251646;
					float3 In_PositionRawOS16_g251648 = Out_PositionRawOS15_g251646;
					float3 In_PivotOS16_g251648 = temp_output_219_24_g251645;
					float3 In_PivotWS16_g251648 = Out_PivotWS15_g251646;
					float3 In_PivotWO16_g251648 = Out_PivotWO15_g251646;
					float3 temp_output_21_0_g251648 = Out_NormalOS15_g251646;
					float3 In_NormalOS16_g251648 = temp_output_21_0_g251648;
					float3 In_NormalWS16_g251648 = Out_NormalWS15_g251646;
					float3 In_NormalRawOS16_g251648 = Out_NormalRawOS15_g251646;
					float4 temp_output_6_0_g251648 = Out_TangentOS15_g251646;
					float4 In_TangentOS16_g251648 = temp_output_6_0_g251648;
					float3 In_TangentWS16_g251648 = Out_TangentWS15_g251646;
					float3 In_BitangentWS16_g251648 = Out_BitangentWS15_g251646;
					float3 In_ViewDirWS16_g251648 = Out_ViewDirWS15_g251646;
					float4 In_CoordsData16_g251648 = Out_CoordsData15_g251646;
					float4 In_VertexData16_g251648 = Out_VertexData15_g251646;
					float4 In_MasksData16_g251648 = Out_MasksData15_g251646;
					float4 In_PhaseData16_g251648 = Out_PhaseData15_g251646;
					float4 In_TransformData16_g251648 = Out_TransformData15_g251646;
					float4 In_RotationData16_g251648 = Out_RotationData15_g251646;
					float4 In_InterpolatorA16_g251648 = Out_InterpolatorA15_g251646;
					BuildModelVertData( Data16_g251648 , In_Dummy16_g251648 , In_PositionOS16_g251648 , In_PositionWS16_g251648 , In_PositionWO16_g251648 , In_PositionRawOS16_g251648 , In_PivotOS16_g251648 , In_PivotWS16_g251648 , In_PivotWO16_g251648 , In_NormalOS16_g251648 , In_NormalWS16_g251648 , In_NormalRawOS16_g251648 , In_TangentOS16_g251648 , In_TangentWS16_g251648 , In_BitangentWS16_g251648 , In_ViewDirWS16_g251648 , In_CoordsData16_g251648 , In_VertexData16_g251648 , In_MasksData16_g251648 , In_PhaseData16_g251648 , In_TransformData16_g251648 , In_RotationData16_g251648 , In_InterpolatorA16_g251648 );
					TVEModelData Data15_g251650 =(TVEModelData)Data16_g251648;
					float Out_Dummy15_g251650 = 0.0;
					float3 Out_PositionOS15_g251650 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251650 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251650 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251650 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251650 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251650 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251650 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251650 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251650 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251650 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251650 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251650 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251650 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251650 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251650 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251650 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251650 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251650 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251650 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251650 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251650 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251650 , Out_Dummy15_g251650 , Out_PositionOS15_g251650 , Out_PositionWS15_g251650 , Out_PositionWO15_g251650 , Out_PositionRawOS15_g251650 , Out_PivotOS15_g251650 , Out_PivotWS15_g251650 , Out_PivotWO15_g251650 , Out_NormalOS15_g251650 , Out_NormalWS15_g251650 , Out_NormalRawOS15_g251650 , Out_TangentOS15_g251650 , Out_TangentWS15_g251650 , Out_BitangentWS15_g251650 , Out_ViewDirWS15_g251650 , Out_CoordsData15_g251650 , Out_VertexData15_g251650 , Out_MasksData15_g251650 , Out_PhaseData15_g251650 , Out_TransformData15_g251650 , Out_RotationData15_g251650 , Out_InterpolatorA15_g251650 );
					TVEModelData Data16_g251651 =(TVEModelData)Data15_g251650;
					half Dummy317_g251649 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g251651 = Dummy317_g251649;
					float In_Dummy16_g251651 = temp_output_14_0_g251651;
					float3 temp_output_4_0_g251651 = Out_PositionOS15_g251650;
					float3 In_PositionOS16_g251651 = temp_output_4_0_g251651;
					float3 In_PositionWS16_g251651 = Out_PositionWS15_g251650;
					float3 temp_output_314_17_g251649 = Out_PositionWO15_g251650;
					float3 In_PositionWO16_g251651 = temp_output_314_17_g251649;
					float3 In_PositionRawOS16_g251651 = Out_PositionRawOS15_g251650;
					float3 In_PivotOS16_g251651 = Out_PivotOS15_g251650;
					float3 In_PivotWS16_g251651 = Out_PivotWS15_g251650;
					float3 temp_output_314_19_g251649 = Out_PivotWO15_g251650;
					float3 In_PivotWO16_g251651 = temp_output_314_19_g251649;
					float3 temp_output_21_0_g251651 = Out_NormalOS15_g251650;
					float3 In_NormalOS16_g251651 = temp_output_21_0_g251651;
					float3 In_NormalWS16_g251651 = Out_NormalWS15_g251650;
					float3 In_NormalRawOS16_g251651 = Out_NormalRawOS15_g251650;
					float4 temp_output_6_0_g251651 = Out_TangentOS15_g251650;
					float4 In_TangentOS16_g251651 = temp_output_6_0_g251651;
					float3 In_TangentWS16_g251651 = Out_TangentWS15_g251650;
					float3 In_BitangentWS16_g251651 = Out_BitangentWS15_g251650;
					float3 In_ViewDirWS16_g251651 = Out_ViewDirWS15_g251650;
					float4 In_CoordsData16_g251651 = Out_CoordsData15_g251650;
					float4 temp_output_314_29_g251649 = Out_VertexData15_g251650;
					float4 In_VertexData16_g251651 = temp_output_314_29_g251649;
					float4 In_MasksData16_g251651 = Out_MasksData15_g251650;
					float4 In_PhaseData16_g251651 = Out_PhaseData15_g251650;
					half4 Model_TransformData356_g251649 = Out_TransformData15_g251650;
					float localBuildGlobalData204_g251489 = ( 0.0 );
					TVEGlobalData Data204_g251489 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251489 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251489 = Dummy211_g251489;
					float4 temp_output_589_164_g251489 = TVE_CoatParams;
					half4 Coat_Params596_g251489 = temp_output_589_164_g251489;
					float4 In_CoatParams204_g251489 = Coat_Params596_g251489;
					float4 temp_output_203_0_g251509 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g251486 = ( 0.0 );
					TVEModelData Data26_g251486 = (TVEModelData)0;
					TVEModelData Data16_g251474 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g251474 = 0.0;
					float3 In_PositionWS16_g251474 = PositionWS122_g251466;
					float3 In_PositionWO16_g251474 = PositionWO132_g251466;
					float3 In_PivotWS16_g251474 = PivotWS121_g251466;
					float3 In_PivotWO16_g251474 = PivotWO133_g251466;
					float3 In_NormalWS16_g251474 = NormalWS95_g251466;
					float3 In_TangentWS16_g251474 = TangentWS136_g251466;
					float3 In_BitangentWS16_g251474 = BiangentWS421_g251466;
					half3 NormalWS427_g251466 = NormalWS95_g251466;
					half3 localComputeTriplanarWeights427_g251466 = ComputeTriplanarWeights( NormalWS427_g251466 );
					half3 TriplanarWeights429_g251466 = localComputeTriplanarWeights427_g251466;
					float3 In_TriplanarWeights16_g251474 = TriplanarWeights429_g251466;
					float3 In_ViewDirWS16_g251474 = ViewDirWS169_g251466;
					float4 In_CoordsData16_g251474 = CoordsData398_g251466;
					float4 In_VertexData16_g251474 = VertexMasks171_g251466;
					float4 In_PhaseData16_g251474 = Phase_Data176_g251466;
					BuildModelFragData( Data16_g251474 , In_Dummy16_g251474 , In_PositionWS16_g251474 , In_PositionWO16_g251474 , In_PivotWS16_g251474 , In_PivotWO16_g251474 , In_NormalWS16_g251474 , In_TangentWS16_g251474 , In_BitangentWS16_g251474 , In_TriplanarWeights16_g251474 , In_ViewDirWS16_g251474 , In_CoordsData16_g251474 , In_VertexData16_g251474 , In_PhaseData16_g251474 );
					TVEModelData DataDefault26_g251486 = Data16_g251474;
					TVEModelData DataGeneral26_g251486 = Data16_g251474;
					TVEModelData DataBlanket26_g251486 = Data16_g251474;
					TVEModelData DataImpostor26_g251486 = Data16_g251474;
					TVEModelData Data16_g251454 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g251454 = 0.0;
					float3 In_PositionWS16_g251454 = PositionWS122_g251446;
					float3 In_PositionWO16_g251454 = PositionWO132_g251446;
					float3 In_PivotWS16_g251454 = PivotWS121_g251446;
					float3 In_PivotWO16_g251454 = PivotWO133_g251446;
					float3 In_NormalWS16_g251454 = NormalWS95_g251446;
					float3 In_TangentWS16_g251454 = TangentWS136_g251446;
					float3 In_BitangentWS16_g251454 = BiangentWS421_g251446;
					half3 NormalWS427_g251446 = NormalWS95_g251446;
					half3 localComputeTriplanarWeights427_g251446 = ComputeTriplanarWeights( NormalWS427_g251446 );
					half3 TriplanarWeights429_g251446 = localComputeTriplanarWeights427_g251446;
					float3 In_TriplanarWeights16_g251454 = TriplanarWeights429_g251446;
					float3 In_ViewDirWS16_g251454 = ViewDirWS169_g251446;
					float4 In_CoordsData16_g251454 = CoordsData398_g251446;
					float4 In_VertexData16_g251454 = VertexMasks171_g251446;
					float4 In_PhaseData16_g251454 = Phase_Data176_g251446;
					BuildModelFragData( Data16_g251454 , In_Dummy16_g251454 , In_PositionWS16_g251454 , In_PositionWO16_g251454 , In_PivotWS16_g251454 , In_PivotWO16_g251454 , In_NormalWS16_g251454 , In_TangentWS16_g251454 , In_BitangentWS16_g251454 , In_TriplanarWeights16_g251454 , In_ViewDirWS16_g251454 , In_CoordsData16_g251454 , In_VertexData16_g251454 , In_PhaseData16_g251454 );
					TVEModelData DataTerrain26_g251486 = Data16_g251454;
					float Type26_g251486 = IsShaderType2544;
					{
					if (Type26_g251486 == 0 )
					{
					Data26_g251486 = DataDefault26_g251486;
					}
					else if (Type26_g251486 == 1 )
					{
					Data26_g251486 = DataGeneral26_g251486;
					}
					else if (Type26_g251486 == 2 )
					{
					Data26_g251486 = DataBlanket26_g251486;
					}
					else if (Type26_g251486 == 3 )
					{
					Data26_g251486 = DataImpostor26_g251486;
					}
					else if (Type26_g251486 == 4 )
					{
					Data26_g251486 = DataTerrain26_g251486;
					}
					}
					TVEModelData Data15_g251565 =(TVEModelData)Data26_g251486;
					float Out_Dummy15_g251565 = 0.0;
					float3 Out_PositionWS15_g251565 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251565 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251565 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251565 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251565 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251565 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251565 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251565 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251565 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251565 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251565 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251565 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251565 , Out_Dummy15_g251565 , Out_PositionWS15_g251565 , Out_PositionWO15_g251565 , Out_PivotWS15_g251565 , Out_PivotWO15_g251565 , Out_NormalWS15_g251565 , Out_TangentWS15_g251565 , Out_BitangentWS15_g251565 , Out_TriplanarWeights15_g251565 , Out_ViewDirWS15_g251565 , Out_CoordsData15_g251565 , Out_VertexData15_g251565 , Out_PhaseData15_g251565 );
					float3 Model_PositionWS497_g251489 = Out_PositionWS15_g251565;
					float2 Model_PositionWS_XZ143_g251489 = (Model_PositionWS497_g251489).xz;
					float3 Model_PivotWS498_g251489 = Out_PivotWS15_g251565;
					float2 Model_PivotWS_XZ145_g251489 = (Model_PivotWS498_g251489).xz;
					float2 lerpResult300_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251509 = lerpResult300_g251489;
					float temp_output_82_0_g251507 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251509 = temp_output_82_0_g251507;
					float4 tex2DArrayNode83_g251509 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251509).zw + ( (temp_output_203_0_g251509).xy * temp_output_81_0_g251509 ) ),temp_output_82_0_g251509), 0.0 );
					float4 appendResult210_g251509 = (float4(tex2DArrayNode83_g251509.rgb , saturate( tex2DArrayNode83_g251509.a )));
					float4 temp_output_204_0_g251509 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251509 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251509).zw + ( (temp_output_204_0_g251509).xy * temp_output_81_0_g251509 ) ),temp_output_82_0_g251509), 0.0 );
					float4 appendResult212_g251509 = (float4(tex2DArrayNode122_g251509.rgb , saturate( tex2DArrayNode122_g251509.a )));
					float4 TVE_RenderNearPositionR628_g251489 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251489 = saturate( ( distance( Model_PositionWS497_g251489 , (TVE_RenderNearPositionR628_g251489).xyz ) / (TVE_RenderNearPositionR628_g251489).w ) );
					float temp_output_7_0_g251490 = 1.0;
					float temp_output_9_0_g251490 = ( temp_output_507_0_g251489 - temp_output_7_0_g251490 );
					half TVE_RenderNearFadeValue635_g251489 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251489 = saturate( ( temp_output_9_0_g251490 / ( ( TVE_RenderNearFadeValue635_g251489 - temp_output_7_0_g251490 ) + 0.0001 ) ) );
					float4 lerpResult131_g251509 = lerp( appendResult210_g251509 , appendResult212_g251509 , Global_TexBlend509_g251489);
					float4 temp_output_159_109_g251507 = lerpResult131_g251509;
					float4 lerpResult168_g251507 = lerp( TVE_CoatParams , temp_output_159_109_g251507 , TVE_CoatLayers[(int)temp_output_82_0_g251507]);
					float4 temp_output_589_109_g251489 = lerpResult168_g251507;
					half4 Coat_Texture302_g251489 = temp_output_589_109_g251489;
					float4 In_CoatTexture204_g251489 = Coat_Texture302_g251489;
					float4 temp_output_595_164_g251489 = TVE_PaintParams;
					half4 Paint_Params575_g251489 = temp_output_595_164_g251489;
					float4 In_PaintParams204_g251489 = Paint_Params575_g251489;
					float4 temp_output_203_0_g251558 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251558 = lerpResult85_g251489;
					float temp_output_82_0_g251555 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251558 = temp_output_82_0_g251555;
					float4 tex2DArrayNode83_g251558 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251558).zw + ( (temp_output_203_0_g251558).xy * temp_output_81_0_g251558 ) ),temp_output_82_0_g251558), 0.0 );
					float4 appendResult210_g251558 = (float4(tex2DArrayNode83_g251558.rgb , saturate( tex2DArrayNode83_g251558.a )));
					float4 temp_output_204_0_g251558 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251558 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251558).zw + ( (temp_output_204_0_g251558).xy * temp_output_81_0_g251558 ) ),temp_output_82_0_g251558), 0.0 );
					float4 appendResult212_g251558 = (float4(tex2DArrayNode122_g251558.rgb , saturate( tex2DArrayNode122_g251558.a )));
					float4 lerpResult131_g251558 = lerp( appendResult210_g251558 , appendResult212_g251558 , Global_TexBlend509_g251489);
					float4 temp_output_171_109_g251555 = lerpResult131_g251558;
					float4 lerpResult174_g251555 = lerp( TVE_PaintParams , temp_output_171_109_g251555 , TVE_PaintLayers[(int)temp_output_82_0_g251555]);
					float4 temp_output_595_109_g251489 = lerpResult174_g251555;
					half4 Paint_Texture71_g251489 = temp_output_595_109_g251489;
					float4 In_PaintTexture204_g251489 = Paint_Texture71_g251489;
					float4 temp_output_590_141_g251489 = TVE_AtmoParams;
					half4 Atmo_Params601_g251489 = temp_output_590_141_g251489;
					float4 In_AtmoParams204_g251489 = Atmo_Params601_g251489;
					float4 temp_output_203_0_g251517 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251517 = lerpResult104_g251489;
					float temp_output_132_0_g251515 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251517 = temp_output_132_0_g251515;
					float4 tex2DArrayNode83_g251517 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251517).zw + ( (temp_output_203_0_g251517).xy * temp_output_81_0_g251517 ) ),temp_output_82_0_g251517), 0.0 );
					float4 appendResult210_g251517 = (float4(tex2DArrayNode83_g251517.rgb , saturate( tex2DArrayNode83_g251517.a )));
					float4 temp_output_204_0_g251517 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251517 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251517).zw + ( (temp_output_204_0_g251517).xy * temp_output_81_0_g251517 ) ),temp_output_82_0_g251517), 0.0 );
					float4 appendResult212_g251517 = (float4(tex2DArrayNode122_g251517.rgb , saturate( tex2DArrayNode122_g251517.a )));
					float4 lerpResult131_g251517 = lerp( appendResult210_g251517 , appendResult212_g251517 , Global_TexBlend509_g251489);
					float4 temp_output_137_109_g251515 = lerpResult131_g251517;
					float4 lerpResult145_g251515 = lerp( TVE_AtmoParams , temp_output_137_109_g251515 , TVE_AtmoLayers[(int)temp_output_132_0_g251515]);
					float4 temp_output_590_110_g251489 = lerpResult145_g251515;
					half4 Atmo_Texture80_g251489 = temp_output_590_110_g251489;
					float4 In_AtmoTexture204_g251489 = Atmo_Texture80_g251489;
					float4 temp_output_593_163_g251489 = TVE_GlowParams;
					half4 Glow_Params609_g251489 = temp_output_593_163_g251489;
					float4 In_GlowParams204_g251489 = Glow_Params609_g251489;
					float4 temp_output_203_0_g251533 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251533 = lerpResult247_g251489;
					float temp_output_82_0_g251531 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251533 = temp_output_82_0_g251531;
					float4 tex2DArrayNode83_g251533 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251533).zw + ( (temp_output_203_0_g251533).xy * temp_output_81_0_g251533 ) ),temp_output_82_0_g251533), 0.0 );
					float4 appendResult210_g251533 = (float4(tex2DArrayNode83_g251533.rgb , saturate( tex2DArrayNode83_g251533.a )));
					float4 temp_output_204_0_g251533 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251533 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251533).zw + ( (temp_output_204_0_g251533).xy * temp_output_81_0_g251533 ) ),temp_output_82_0_g251533), 0.0 );
					float4 appendResult212_g251533 = (float4(tex2DArrayNode122_g251533.rgb , saturate( tex2DArrayNode122_g251533.a )));
					float4 lerpResult131_g251533 = lerp( appendResult210_g251533 , appendResult212_g251533 , Global_TexBlend509_g251489);
					float4 temp_output_159_109_g251531 = lerpResult131_g251533;
					float4 lerpResult167_g251531 = lerp( TVE_GlowParams , temp_output_159_109_g251531 , TVE_GlowLayers[(int)temp_output_82_0_g251531]);
					float4 temp_output_593_109_g251489 = lerpResult167_g251531;
					half4 Glow_Texture248_g251489 = temp_output_593_109_g251489;
					float4 In_GlowTexture204_g251489 = Glow_Texture248_g251489;
					float4 temp_output_592_139_g251489 = TVE_FormParams;
					float4 Form_Params606_g251489 = temp_output_592_139_g251489;
					float4 In_FormParams204_g251489 = Form_Params606_g251489;
					float4 temp_output_203_0_g251549 = TVE_FormBaseCoord;
					float2 lerpResult168_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251549 = lerpResult168_g251489;
					float temp_output_130_0_g251547 = _GlobalFormLayerValue;
					float temp_output_82_0_g251549 = temp_output_130_0_g251547;
					float4 tex2DArrayNode83_g251549 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251549).zw + ( (temp_output_203_0_g251549).xy * temp_output_81_0_g251549 ) ),temp_output_82_0_g251549), 0.0 );
					float4 appendResult210_g251549 = (float4(tex2DArrayNode83_g251549.rgb , saturate( tex2DArrayNode83_g251549.a )));
					float4 temp_output_204_0_g251549 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251549 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251549).zw + ( (temp_output_204_0_g251549).xy * temp_output_81_0_g251549 ) ),temp_output_82_0_g251549), 0.0 );
					float4 appendResult212_g251549 = (float4(tex2DArrayNode122_g251549.rgb , saturate( tex2DArrayNode122_g251549.a )));
					float4 lerpResult131_g251549 = lerp( appendResult210_g251549 , appendResult212_g251549 , Global_TexBlend509_g251489);
					float4 temp_output_135_109_g251547 = lerpResult131_g251549;
					float4 lerpResult143_g251547 = lerp( TVE_FormParams , temp_output_135_109_g251547 , TVE_FormLayers[(int)temp_output_130_0_g251547]);
					float4 temp_output_592_0_g251489 = lerpResult143_g251547;
					float4 Form_Texture112_g251489 = temp_output_592_0_g251489;
					float4 In_FormTexture204_g251489 = Form_Texture112_g251489;
					float4 temp_output_594_145_g251489 = TVE_FlowParams;
					half4 Flow_Params612_g251489 = temp_output_594_145_g251489;
					float4 In_FlowParams204_g251489 = Flow_Params612_g251489;
					float4 temp_output_203_0_g251541 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251541 = lerpResult400_g251489;
					float temp_output_136_0_g251539 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251541 = temp_output_136_0_g251539;
					float4 tex2DArrayNode83_g251541 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251541).zw + ( (temp_output_203_0_g251541).xy * temp_output_81_0_g251541 ) ),temp_output_82_0_g251541), 0.0 );
					float4 appendResult210_g251541 = (float4(tex2DArrayNode83_g251541.rgb , saturate( tex2DArrayNode83_g251541.a )));
					float4 temp_output_204_0_g251541 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251541 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251541).zw + ( (temp_output_204_0_g251541).xy * temp_output_81_0_g251541 ) ),temp_output_82_0_g251541), 0.0 );
					float4 appendResult212_g251541 = (float4(tex2DArrayNode122_g251541.rgb , saturate( tex2DArrayNode122_g251541.a )));
					float4 lerpResult131_g251541 = lerp( appendResult210_g251541 , appendResult212_g251541 , Global_TexBlend509_g251489);
					float4 temp_output_141_109_g251539 = lerpResult131_g251541;
					float4 lerpResult149_g251539 = lerp( TVE_FlowParams , temp_output_141_109_g251539 , TVE_FlowLayers[(int)temp_output_136_0_g251539]);
					half4 Flow_Texture405_g251489 = lerpResult149_g251539;
					float4 In_FlowTexture204_g251489 = Flow_Texture405_g251489;
					BuildGlobalData( Data204_g251489 , In_Dummy204_g251489 , In_CoatParams204_g251489 , In_CoatTexture204_g251489 , In_PaintParams204_g251489 , In_PaintTexture204_g251489 , In_AtmoParams204_g251489 , In_AtmoTexture204_g251489 , In_GlowParams204_g251489 , In_GlowTexture204_g251489 , In_FormParams204_g251489 , In_FormTexture204_g251489 , In_FlowParams204_g251489 , In_FlowTexture204_g251489 );
					TVEGlobalData Data15_g251652 =(TVEGlobalData)Data204_g251489;
					float Out_Dummy15_g251652 = 0.0;
					float4 Out_CoatParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251652 = float4( 0,0,0,0 );
					BreakData( Data15_g251652 , Out_Dummy15_g251652 , Out_CoatParams15_g251652 , Out_CoatTexture15_g251652 , Out_PaintParams15_g251652 , Out_PaintTexture15_g251652 , Out_AtmoParams15_g251652 , Out_AtmoTexture15_g251652 , Out_GlowParams15_g251652 , Out_GlowTexture15_g251652 , Out_FormParams15_g251652 , Out_FormTexture15_g251652 , Out_FlowParams15_g251652 , Out_FlowTexture15_g251652 );
					float4 Global_FormTexture351_g251649 = Out_FormTexture15_g251652;
					float3 Model_PivotWO353_g251649 = temp_output_314_19_g251649;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251658 = _ConformMeshMode;
					float Option70_g251658 = temp_output_17_0_g251658;
					half4 Model_VertexData357_g251649 = temp_output_314_29_g251649;
					float4 temp_output_3_0_g251658 = Model_VertexData357_g251649;
					float4 Channel70_g251658 = temp_output_3_0_g251658;
					float localSwitchChannel470_g251658 = SwitchChannel4( Option70_g251658 , Channel70_g251658 );
					float temp_output_390_0_g251649 = localSwitchChannel470_g251658;
					float temp_output_7_0_g251655 = _ConformMeshRemap.x;
					float temp_output_9_0_g251655 = ( temp_output_390_0_g251649 - temp_output_7_0_g251655 );
					float lerpResult374_g251649 = lerp( 1.0 , saturate( ( temp_output_9_0_g251655 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251649 = lerpResult374_g251649;
					float temp_output_328_0_g251649 = ( Blend_VertMask379_g251649 * TVE_IsEnabled );
					half Conform_Mask366_g251649 = temp_output_328_0_g251649;
					float temp_output_322_0_g251649 = ( ( ( ( (Global_FormTexture351_g251649).z - ( (Model_PivotWO353_g251649).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251649 ) );
					float3 appendResult329_g251649 = (float3(0.0 , temp_output_322_0_g251649 , 0.0));
					float3 appendResult387_g251649 = (float3(0.0 , 0.0 , temp_output_322_0_g251649));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251656 = appendResult387_g251649;
					#else
					float3 staticSwitch65_g251656 = appendResult329_g251649;
					#endif
					float3 Blanket_Conform368_g251649 = staticSwitch65_g251656;
					float4 appendResult312_g251649 = (float4(Blanket_Conform368_g251649 , 0.0));
					float4 temp_output_310_0_g251649 = ( Model_TransformData356_g251649 + appendResult312_g251649 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251649 = temp_output_310_0_g251649;
					#else
					float4 staticSwitch364_g251649 = Model_TransformData356_g251649;
					#endif
					half4 Final_TransformData365_g251649 = staticSwitch364_g251649;
					float4 In_TransformData16_g251651 = Final_TransformData365_g251649;
					float4 In_RotationData16_g251651 = Out_RotationData15_g251650;
					float4 In_InterpolatorA16_g251651 = Out_InterpolatorA15_g251650;
					BuildModelVertData( Data16_g251651 , In_Dummy16_g251651 , In_PositionOS16_g251651 , In_PositionWS16_g251651 , In_PositionWO16_g251651 , In_PositionRawOS16_g251651 , In_PivotOS16_g251651 , In_PivotWS16_g251651 , In_PivotWO16_g251651 , In_NormalOS16_g251651 , In_NormalWS16_g251651 , In_NormalRawOS16_g251651 , In_TangentOS16_g251651 , In_TangentWS16_g251651 , In_BitangentWS16_g251651 , In_ViewDirWS16_g251651 , In_CoordsData16_g251651 , In_VertexData16_g251651 , In_MasksData16_g251651 , In_PhaseData16_g251651 , In_TransformData16_g251651 , In_RotationData16_g251651 , In_InterpolatorA16_g251651 );
					TVEModelData Data15_g251747 =(TVEModelData)Data16_g251651;
					float Out_Dummy15_g251747 = 0.0;
					float3 Out_PositionOS15_g251747 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251747 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251747 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251747 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251747 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251747 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251747 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251747 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251747 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251747 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251747 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251747 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251747 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251747 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251747 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251747 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251747 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251747 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251747 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251747 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251747 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251747 , Out_Dummy15_g251747 , Out_PositionOS15_g251747 , Out_PositionWS15_g251747 , Out_PositionWO15_g251747 , Out_PositionRawOS15_g251747 , Out_PivotOS15_g251747 , Out_PivotWS15_g251747 , Out_PivotWO15_g251747 , Out_NormalOS15_g251747 , Out_NormalWS15_g251747 , Out_NormalRawOS15_g251747 , Out_TangentOS15_g251747 , Out_TangentWS15_g251747 , Out_BitangentWS15_g251747 , Out_ViewDirWS15_g251747 , Out_CoordsData15_g251747 , Out_VertexData15_g251747 , Out_MasksData15_g251747 , Out_PhaseData15_g251747 , Out_TransformData15_g251747 , Out_RotationData15_g251747 , Out_InterpolatorA15_g251747 );
					TVEModelData Data16_g251748 =(TVEModelData)Data15_g251747;
					float temp_output_14_0_g251748 = 0.0;
					float In_Dummy16_g251748 = temp_output_14_0_g251748;
					float3 Model_PositionOS147_g251746 = Out_PositionOS15_g251747;
					half3 VertexPos40_g251752 = Model_PositionOS147_g251746;
					float4 temp_output_1567_33_g251746 = Out_RotationData15_g251747;
					half4 Model_RotationData1569_g251746 = temp_output_1567_33_g251746;
					float2 break1582_g251746 = (Model_RotationData1569_g251746).xy;
					half Angle44_g251752 = break1582_g251746.y;
					half CosAngle89_g251752 = cos( Angle44_g251752 );
					half SinAngle93_g251752 = sin( Angle44_g251752 );
					float3 appendResult95_g251752 = (float3((VertexPos40_g251752).x , ( ( (VertexPos40_g251752).y * CosAngle89_g251752 ) - ( (VertexPos40_g251752).z * SinAngle93_g251752 ) ) , ( ( (VertexPos40_g251752).y * SinAngle93_g251752 ) + ( (VertexPos40_g251752).z * CosAngle89_g251752 ) )));
					half3 VertexPos40_g251753 = appendResult95_g251752;
					half Angle44_g251753 = -break1582_g251746.x;
					half CosAngle94_g251753 = cos( Angle44_g251753 );
					half SinAngle95_g251753 = sin( Angle44_g251753 );
					float3 appendResult98_g251753 = (float3(( ( (VertexPos40_g251753).x * CosAngle94_g251753 ) - ( (VertexPos40_g251753).y * SinAngle95_g251753 ) ) , ( ( (VertexPos40_g251753).x * SinAngle95_g251753 ) + ( (VertexPos40_g251753).y * CosAngle94_g251753 ) ) , (VertexPos40_g251753).z));
					half3 VertexPos40_g251751 = Model_PositionOS147_g251746;
					half Angle44_g251751 = break1582_g251746.y;
					half CosAngle89_g251751 = cos( Angle44_g251751 );
					half SinAngle93_g251751 = sin( Angle44_g251751 );
					float3 appendResult95_g251751 = (float3((VertexPos40_g251751).x , ( ( (VertexPos40_g251751).y * CosAngle89_g251751 ) - ( (VertexPos40_g251751).z * SinAngle93_g251751 ) ) , ( ( (VertexPos40_g251751).y * SinAngle93_g251751 ) + ( (VertexPos40_g251751).z * CosAngle89_g251751 ) )));
					half3 VertexPos40_g251756 = appendResult95_g251751;
					half Angle44_g251756 = break1582_g251746.x;
					half CosAngle91_g251756 = cos( Angle44_g251756 );
					half SinAngle92_g251756 = sin( Angle44_g251756 );
					float3 appendResult93_g251756 = (float3(( ( (VertexPos40_g251756).x * CosAngle91_g251756 ) + ( (VertexPos40_g251756).z * SinAngle92_g251756 ) ) , (VertexPos40_g251756).y , ( ( -(VertexPos40_g251756).x * SinAngle92_g251756 ) + ( (VertexPos40_g251756).z * CosAngle91_g251756 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251754 = appendResult93_g251756;
					#else
					float3 staticSwitch65_g251754 = appendResult98_g251753;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251749 = staticSwitch65_g251754;
					#else
					float3 staticSwitch65_g251749 = Model_PositionOS147_g251746;
					#endif
					float3 temp_output_1608_0_g251746 = staticSwitch65_g251749;
					half3 VertexPos40_g251755 = temp_output_1608_0_g251746;
					half Angle44_g251755 = (Model_RotationData1569_g251746).z;
					half CosAngle91_g251755 = cos( Angle44_g251755 );
					half SinAngle92_g251755 = sin( Angle44_g251755 );
					float3 appendResult93_g251755 = (float3(( ( (VertexPos40_g251755).x * CosAngle91_g251755 ) + ( (VertexPos40_g251755).z * SinAngle92_g251755 ) ) , (VertexPos40_g251755).y , ( ( -(VertexPos40_g251755).x * SinAngle92_g251755 ) + ( (VertexPos40_g251755).z * CosAngle91_g251755 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251750 = appendResult93_g251755;
					#else
					float3 staticSwitch65_g251750 = temp_output_1608_0_g251746;
					#endif
					float4 temp_output_1567_31_g251746 = Out_TransformData15_g251747;
					half4 Model_TransformData1568_g251746 = temp_output_1567_31_g251746;
					half3 Final_PositionOS178_g251746 = ( ( staticSwitch65_g251750 * (Model_TransformData1568_g251746).w ) + (Model_TransformData1568_g251746).xyz );
					float3 temp_output_4_0_g251748 = Final_PositionOS178_g251746;
					float3 In_PositionOS16_g251748 = temp_output_4_0_g251748;
					float3 In_PositionWS16_g251748 = Out_PositionWS15_g251747;
					float3 In_PositionWO16_g251748 = Out_PositionWO15_g251747;
					float3 In_PositionRawOS16_g251748 = Out_PositionRawOS15_g251747;
					float3 In_PivotOS16_g251748 = Out_PivotOS15_g251747;
					float3 In_PivotWS16_g251748 = Out_PivotWS15_g251747;
					float3 In_PivotWO16_g251748 = Out_PivotWO15_g251747;
					float3 temp_output_21_0_g251748 = Out_NormalOS15_g251747;
					float3 In_NormalOS16_g251748 = temp_output_21_0_g251748;
					float3 In_NormalWS16_g251748 = Out_NormalWS15_g251747;
					float3 In_NormalRawOS16_g251748 = Out_NormalRawOS15_g251747;
					float4 temp_output_6_0_g251748 = Out_TangentOS15_g251747;
					float4 In_TangentOS16_g251748 = temp_output_6_0_g251748;
					float3 In_TangentWS16_g251748 = Out_TangentWS15_g251747;
					float3 In_BitangentWS16_g251748 = Out_BitangentWS15_g251747;
					float3 In_ViewDirWS16_g251748 = Out_ViewDirWS15_g251747;
					float4 In_CoordsData16_g251748 = Out_CoordsData15_g251747;
					float4 In_VertexData16_g251748 = Out_VertexData15_g251747;
					float4 In_MasksData16_g251748 = Out_MasksData15_g251747;
					float4 In_PhaseData16_g251748 = Out_PhaseData15_g251747;
					float4 In_TransformData16_g251748 = temp_output_1567_31_g251746;
					float4 In_RotationData16_g251748 = temp_output_1567_33_g251746;
					float4 In_InterpolatorA16_g251748 = Out_InterpolatorA15_g251747;
					BuildModelVertData( Data16_g251748 , In_Dummy16_g251748 , In_PositionOS16_g251748 , In_PositionWS16_g251748 , In_PositionWO16_g251748 , In_PositionRawOS16_g251748 , In_PivotOS16_g251748 , In_PivotWS16_g251748 , In_PivotWO16_g251748 , In_NormalOS16_g251748 , In_NormalWS16_g251748 , In_NormalRawOS16_g251748 , In_TangentOS16_g251748 , In_TangentWS16_g251748 , In_BitangentWS16_g251748 , In_ViewDirWS16_g251748 , In_CoordsData16_g251748 , In_VertexData16_g251748 , In_MasksData16_g251748 , In_PhaseData16_g251748 , In_TransformData16_g251748 , In_RotationData16_g251748 , In_InterpolatorA16_g251748 );
					TVEModelData Data15_g251759 =(TVEModelData)Data16_g251748;
					float Out_Dummy15_g251759 = 0.0;
					float3 Out_PositionOS15_g251759 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251759 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251759 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251759 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251759 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251759 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251759 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251759 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251759 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251759 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251759 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251759 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251759 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251759 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251759 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251759 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251759 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251759 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251759 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251759 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251759 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251759 , Out_Dummy15_g251759 , Out_PositionOS15_g251759 , Out_PositionWS15_g251759 , Out_PositionWO15_g251759 , Out_PositionRawOS15_g251759 , Out_PivotOS15_g251759 , Out_PivotWS15_g251759 , Out_PivotWO15_g251759 , Out_NormalOS15_g251759 , Out_NormalWS15_g251759 , Out_NormalRawOS15_g251759 , Out_TangentOS15_g251759 , Out_TangentWS15_g251759 , Out_BitangentWS15_g251759 , Out_ViewDirWS15_g251759 , Out_CoordsData15_g251759 , Out_VertexData15_g251759 , Out_MasksData15_g251759 , Out_PhaseData15_g251759 , Out_TransformData15_g251759 , Out_RotationData15_g251759 , Out_InterpolatorA15_g251759 );
					TVEModelData Data16_g251760 =(TVEModelData)Data15_g251759;
					float temp_output_14_0_g251760 = 0.0;
					float In_Dummy16_g251760 = temp_output_14_0_g251760;
					float3 temp_output_217_24_g251758 = Out_PivotOS15_g251759;
					float3 temp_output_216_0_g251758 = ( Out_PositionOS15_g251759 + temp_output_217_24_g251758 );
					float3 temp_output_4_0_g251760 = temp_output_216_0_g251758;
					float3 In_PositionOS16_g251760 = temp_output_4_0_g251760;
					float3 In_PositionWS16_g251760 = Out_PositionWS15_g251759;
					float3 In_PositionWO16_g251760 = Out_PositionWO15_g251759;
					float3 In_PositionRawOS16_g251760 = Out_PositionRawOS15_g251759;
					float3 In_PivotOS16_g251760 = temp_output_217_24_g251758;
					float3 In_PivotWS16_g251760 = Out_PivotWS15_g251759;
					float3 In_PivotWO16_g251760 = Out_PivotWO15_g251759;
					float3 temp_output_21_0_g251760 = Out_NormalOS15_g251759;
					float3 In_NormalOS16_g251760 = temp_output_21_0_g251760;
					float3 In_NormalWS16_g251760 = Out_NormalWS15_g251759;
					float3 In_NormalRawOS16_g251760 = Out_NormalRawOS15_g251759;
					float4 temp_output_6_0_g251760 = Out_TangentOS15_g251759;
					float4 In_TangentOS16_g251760 = temp_output_6_0_g251760;
					float3 In_TangentWS16_g251760 = Out_TangentWS15_g251759;
					float3 In_BitangentWS16_g251760 = Out_BitangentWS15_g251759;
					float3 In_ViewDirWS16_g251760 = Out_ViewDirWS15_g251759;
					float4 In_CoordsData16_g251760 = Out_CoordsData15_g251759;
					float4 In_VertexData16_g251760 = Out_VertexData15_g251759;
					float4 In_MasksData16_g251760 = Out_MasksData15_g251759;
					float4 In_PhaseData16_g251760 = Out_PhaseData15_g251759;
					float4 In_TransformData16_g251760 = Out_TransformData15_g251759;
					float4 In_RotationData16_g251760 = Out_RotationData15_g251759;
					float4 In_InterpolatorA16_g251760 = Out_InterpolatorA15_g251759;
					BuildModelVertData( Data16_g251760 , In_Dummy16_g251760 , In_PositionOS16_g251760 , In_PositionWS16_g251760 , In_PositionWO16_g251760 , In_PositionRawOS16_g251760 , In_PivotOS16_g251760 , In_PivotWS16_g251760 , In_PivotWO16_g251760 , In_NormalOS16_g251760 , In_NormalWS16_g251760 , In_NormalRawOS16_g251760 , In_TangentOS16_g251760 , In_TangentWS16_g251760 , In_BitangentWS16_g251760 , In_ViewDirWS16_g251760 , In_CoordsData16_g251760 , In_VertexData16_g251760 , In_MasksData16_g251760 , In_PhaseData16_g251760 , In_TransformData16_g251760 , In_RotationData16_g251760 , In_InterpolatorA16_g251760 );
					TVEModelData Data15_g251790 =(TVEModelData)Data16_g251760;
					float Out_Dummy15_g251790 = 0.0;
					float3 Out_PositionOS15_g251790 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251790 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251790 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251790 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251790 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251790 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251790 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251790 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251790 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251790 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251790 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251790 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251790 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251790 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251790 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251790 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251790 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251790 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251790 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251790 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251790 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251790 , Out_Dummy15_g251790 , Out_PositionOS15_g251790 , Out_PositionWS15_g251790 , Out_PositionWO15_g251790 , Out_PositionRawOS15_g251790 , Out_PivotOS15_g251790 , Out_PivotWS15_g251790 , Out_PivotWO15_g251790 , Out_NormalOS15_g251790 , Out_NormalWS15_g251790 , Out_NormalRawOS15_g251790 , Out_TangentOS15_g251790 , Out_TangentWS15_g251790 , Out_BitangentWS15_g251790 , Out_ViewDirWS15_g251790 , Out_CoordsData15_g251790 , Out_VertexData15_g251790 , Out_MasksData15_g251790 , Out_PhaseData15_g251790 , Out_TransformData15_g251790 , Out_RotationData15_g251790 , Out_InterpolatorA15_g251790 );
					
					o.ase_texcoord4.xyz = vertexToFrag73_g251466;
					o.ase_texcoord5.xyz = vertexToFrag76_g251466;
					float3 vertexPos57_g251784 = v.vertex.xyz;
					float4 ase_positionCS57_g251784 = UnityObjectToClipPos( vertexPos57_g251784 );
					o.ase_texcoord7 = ase_positionCS57_g251784;
					
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
					float3 vertexValue = Out_PositionOS15_g251790;
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

					float temp_output_2587_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2587_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2587_114).xxx;
					
					float3 color130_g251784 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g251784 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g251786 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g251785 = ( temp_cast_4 * ( 0.5 + appendResult128_g251786 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g251785 = (float4(ddx( FinalUV13_g251785 ) , ddy( FinalUV13_g251785 )));
					float4 UVDerivatives17_g251785 = appendResult16_g251785;
					float4 break28_g251785 = UVDerivatives17_g251785;
					float2 appendResult19_g251785 = (float2(break28_g251785.x , break28_g251785.z));
					float2 appendResult20_g251785 = (float2(break28_g251785.x , break28_g251785.z));
					float dotResult24_g251785 = dot( appendResult19_g251785 , appendResult20_g251785 );
					float2 appendResult21_g251785 = (float2(break28_g251785.y , break28_g251785.w));
					float2 appendResult22_g251785 = (float2(break28_g251785.y , break28_g251785.w));
					float dotResult23_g251785 = dot( appendResult21_g251785 , appendResult22_g251785 );
					float2 appendResult25_g251785 = (float2(dotResult24_g251785 , dotResult23_g251785));
					float2 derivativesLength29_g251785 = sqrt( appendResult25_g251785 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g251785 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g251785 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g251785 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g251785 = clampResult57_g251785;
					float2 break55_g251785 = derivativesLength29_g251785;
					float4 lerpResult73_g251785 = lerp( float4( color130_g251784 , 0.0 ) , float4( color81_g251784 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g251785.x * break71_g251785.y * sqrt( saturate( ( 1.1 - max( break55_g251785.x, break55_g251785.y ) ) ) ) ) ) ));
					float3 color2584 = IsGammaSpace() ? float3( 0.3867925, 0.3867925, 0.3867925 ) : float3( 0.1237993, 0.1237993, 0.1237993 );
					float3 color2564 = IsGammaSpace() ? float3( 1, 0, 0.3576326 ) : float3( 1, 0, 0.1050864 );
					float3 color2565 = IsGammaSpace() ? float3( 0, 0.5347826, 1 ) : float3( 0, 0.2476594, 1 );
					float4 temp_output_2563_145 = TVE_RenderNearPositionR;
					float temp_output_7_0_g251488 = 1.0;
					float temp_output_9_0_g251488 = ( saturate( ( distance( PositionWS , (temp_output_2563_145).xyz ) / (temp_output_2563_145).w ) ) - temp_output_7_0_g251488 );
					half Global_Blend2558 = saturate( ( temp_output_9_0_g251488 / ( ( TVE_RenderNearFadeValue - temp_output_7_0_g251488 ) + 0.0001 ) ) );
					float3 lerpResult2567 = lerp( color2564 , color2565 , Global_Blend2558);
					float4 temp_output_2582_148 = TVE_RenderBasePositionR;
					float temp_output_7_0_g251643 = 1.0;
					float temp_output_9_0_g251643 = ( saturate( ( distance( PositionWS , (temp_output_2582_148).xyz ) / (temp_output_2582_148).w ) ) - temp_output_7_0_g251643 );
					half Global_Edge2578 = saturate( ( temp_output_9_0_g251643 / ( ( 0.9999 - temp_output_7_0_g251643 ) + 0.0001 ) ) );
					float3 lerpResult2583 = lerp( color2584 , lerpResult2567 , Global_Edge2578);
					float3 ifLocalVar40_g251757 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g251757 = lerpResult2583;
					float localBuildGlobalData204_g251566 = ( 0.0 );
					TVEGlobalData Data204_g251566 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251566 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251566 = Dummy211_g251566;
					float4 temp_output_589_164_g251566 = TVE_CoatParams;
					half4 Coat_Params596_g251566 = temp_output_589_164_g251566;
					float4 In_CoatParams204_g251566 = Coat_Params596_g251566;
					float4 temp_output_203_0_g251586 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g251486 = ( 0.0 );
					TVEModelData Data26_g251486 = (TVEModelData)0;
					TVEModelData Data16_g251474 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g251474 = 0.0;
					float3 vertexToFrag73_g251466 = IN.ase_texcoord4.xyz;
					float3 PositionWS122_g251466 = vertexToFrag73_g251466;
					float3 In_PositionWS16_g251474 = PositionWS122_g251466;
					float3 vertexToFrag76_g251466 = IN.ase_texcoord5.xyz;
					float3 PivotWS121_g251466 = vertexToFrag76_g251466;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251466 = ( PositionWS122_g251466 - PivotWS121_g251466 );
					#else
					float3 staticSwitch204_g251466 = PositionWS122_g251466;
					#endif
					float3 PositionWO132_g251466 = ( staticSwitch204_g251466 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251474 = PositionWO132_g251466;
					float3 In_PivotWS16_g251474 = PivotWS121_g251466;
					float3 PivotWO133_g251466 = ( PivotWS121_g251466 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251474 = PivotWO133_g251466;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g251466 = normalizedWorldNormal;
					float3 In_NormalWS16_g251474 = NormalWS95_g251466;
					half3 TangentWS136_g251466 = TangentWS;
					float3 In_TangentWS16_g251474 = TangentWS136_g251466;
					half3 BiangentWS421_g251466 = BitangentWS;
					float3 In_BitangentWS16_g251474 = BiangentWS421_g251466;
					half3 NormalWS427_g251466 = NormalWS95_g251466;
					half3 localComputeTriplanarWeights427_g251466 = ComputeTriplanarWeights( NormalWS427_g251466 );
					half3 TriplanarWeights429_g251466 = localComputeTriplanarWeights427_g251466;
					float3 In_TriplanarWeights16_g251474 = TriplanarWeights429_g251466;
					float3 normalizeResult296_g251466 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251466 ) );
					half3 ViewDirWS169_g251466 = normalizeResult296_g251466;
					float3 In_ViewDirWS16_g251474 = ViewDirWS169_g251466;
					float4 appendResult397_g251466 = (float4(IN.ase_texcoord6.xy , IN.ase_texcoord6.zw));
					float4 CoordsData398_g251466 = appendResult397_g251466;
					float4 In_CoordsData16_g251474 = CoordsData398_g251466;
					half4 VertexMasks171_g251466 = IN.ase_color;
					float4 In_VertexData16_g251474 = VertexMasks171_g251466;
					float temp_output_17_0_g251478 = _ObjectPhaseMode;
					float Option70_g251478 = temp_output_17_0_g251478;
					float4 temp_output_3_0_g251478 = IN.ase_color;
					float4 Channel70_g251478 = temp_output_3_0_g251478;
					float localSwitchChannel470_g251478 = SwitchChannel4( Option70_g251478 , Channel70_g251478 );
					half Phase_Value372_g251466 = localSwitchChannel470_g251478;
					float3 break319_g251466 = PivotWO133_g251466;
					half Pivot_Position322_g251466 = ( break319_g251466.x + break319_g251466.z );
					half Phase_Position357_g251466 = ( Phase_Value372_g251466 + Pivot_Position322_g251466 );
					float temp_output_248_0_g251466 = frac( Phase_Position357_g251466 );
					float4 appendResult177_g251466 = (float4(( (frac( ( Phase_Position357_g251466 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g251466));
					half4 Phase_Data176_g251466 = appendResult177_g251466;
					float4 In_PhaseData16_g251474 = Phase_Data176_g251466;
					BuildModelFragData( Data16_g251474 , In_Dummy16_g251474 , In_PositionWS16_g251474 , In_PositionWO16_g251474 , In_PivotWS16_g251474 , In_PivotWO16_g251474 , In_NormalWS16_g251474 , In_TangentWS16_g251474 , In_BitangentWS16_g251474 , In_TriplanarWeights16_g251474 , In_ViewDirWS16_g251474 , In_CoordsData16_g251474 , In_VertexData16_g251474 , In_PhaseData16_g251474 );
					TVEModelData DataDefault26_g251486 = Data16_g251474;
					TVEModelData DataGeneral26_g251486 = Data16_g251474;
					TVEModelData DataBlanket26_g251486 = Data16_g251474;
					TVEModelData DataImpostor26_g251486 = Data16_g251474;
					TVEModelData Data16_g251454 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g251454 = 0.0;
					float3 temp_output_104_7_g251446 = PositionWS;
					float3 PositionWS122_g251446 = temp_output_104_7_g251446;
					float3 In_PositionWS16_g251454 = PositionWS122_g251446;
					float4x4 break19_g251449 = unity_ObjectToWorld;
					float3 appendResult20_g251449 = (float3(break19_g251449[ 0 ][ 3 ] , break19_g251449[ 1 ][ 3 ] , break19_g251449[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251446 = appendResult20_g251449;
					float3 PivotWS121_g251446 = temp_output_340_7_g251446;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251446 = ( PositionWS122_g251446 - PivotWS121_g251446 );
					#else
					float3 staticSwitch204_g251446 = PositionWS122_g251446;
					#endif
					float3 PositionWO132_g251446 = ( staticSwitch204_g251446 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251454 = PositionWO132_g251446;
					float3 In_PivotWS16_g251454 = PivotWS121_g251446;
					float3 PivotWO133_g251446 = ( PivotWS121_g251446 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251454 = PivotWO133_g251446;
					half3 NormalWS95_g251446 = normalizedWorldNormal;
					float3 In_NormalWS16_g251454 = NormalWS95_g251446;
					half3 TangentWS136_g251446 = TangentWS;
					float3 In_TangentWS16_g251454 = TangentWS136_g251446;
					half3 BiangentWS421_g251446 = BitangentWS;
					float3 In_BitangentWS16_g251454 = BiangentWS421_g251446;
					half3 NormalWS427_g251446 = NormalWS95_g251446;
					half3 localComputeTriplanarWeights427_g251446 = ComputeTriplanarWeights( NormalWS427_g251446 );
					half3 TriplanarWeights429_g251446 = localComputeTriplanarWeights427_g251446;
					float3 In_TriplanarWeights16_g251454 = TriplanarWeights429_g251446;
					float3 normalizeResult296_g251446 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251446 ) );
					half3 ViewDirWS169_g251446 = normalizeResult296_g251446;
					float3 In_ViewDirWS16_g251454 = ViewDirWS169_g251446;
					float4 appendResult397_g251446 = (float4(IN.ase_texcoord6.xy , IN.ase_texcoord6.zw));
					float4 CoordsData398_g251446 = appendResult397_g251446;
					float4 In_CoordsData16_g251454 = CoordsData398_g251446;
					half4 VertexMasks171_g251446 = float4( 0,0,0,0 );
					float4 In_VertexData16_g251454 = VertexMasks171_g251446;
					half4 Phase_Data176_g251446 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g251454 = Phase_Data176_g251446;
					BuildModelFragData( Data16_g251454 , In_Dummy16_g251454 , In_PositionWS16_g251454 , In_PositionWO16_g251454 , In_PivotWS16_g251454 , In_PivotWO16_g251454 , In_NormalWS16_g251454 , In_TangentWS16_g251454 , In_BitangentWS16_g251454 , In_TriplanarWeights16_g251454 , In_ViewDirWS16_g251454 , In_CoordsData16_g251454 , In_VertexData16_g251454 , In_PhaseData16_g251454 );
					TVEModelData DataTerrain26_g251486 = Data16_g251454;
					half IsShaderType2544 = _IsShaderType;
					float Type26_g251486 = IsShaderType2544;
					{
					if (Type26_g251486 == 0 )
					{
					Data26_g251486 = DataDefault26_g251486;
					}
					else if (Type26_g251486 == 1 )
					{
					Data26_g251486 = DataGeneral26_g251486;
					}
					else if (Type26_g251486 == 2 )
					{
					Data26_g251486 = DataBlanket26_g251486;
					}
					else if (Type26_g251486 == 3 )
					{
					Data26_g251486 = DataImpostor26_g251486;
					}
					else if (Type26_g251486 == 4 )
					{
					Data26_g251486 = DataTerrain26_g251486;
					}
					}
					TVEModelData Data15_g251642 =(TVEModelData)Data26_g251486;
					float Out_Dummy15_g251642 = 0.0;
					float3 Out_PositionWS15_g251642 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251642 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251642 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251642 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251642 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251642 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251642 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251642 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251642 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251642 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251642 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251642 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251642 , Out_Dummy15_g251642 , Out_PositionWS15_g251642 , Out_PositionWO15_g251642 , Out_PivotWS15_g251642 , Out_PivotWO15_g251642 , Out_NormalWS15_g251642 , Out_TangentWS15_g251642 , Out_BitangentWS15_g251642 , Out_TriplanarWeights15_g251642 , Out_ViewDirWS15_g251642 , Out_CoordsData15_g251642 , Out_VertexData15_g251642 , Out_PhaseData15_g251642 );
					float3 Model_PositionWS497_g251566 = Out_PositionWS15_g251642;
					float2 Model_PositionWS_XZ143_g251566 = (Model_PositionWS497_g251566).xz;
					float3 Model_PivotWS498_g251566 = Out_PivotWS15_g251642;
					float2 Model_PivotWS_XZ145_g251566 = (Model_PivotWS498_g251566).xz;
					float2 lerpResult300_g251566 = lerp( Model_PositionWS_XZ143_g251566 , Model_PivotWS_XZ145_g251566 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251586 = lerpResult300_g251566;
					float temp_output_82_0_g251584 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251586 = temp_output_82_0_g251584;
					float4 tex2DArrayNode83_g251586 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251586).zw + ( (temp_output_203_0_g251586).xy * temp_output_81_0_g251586 ) ),temp_output_82_0_g251586) );
					float4 appendResult210_g251586 = (float4(tex2DArrayNode83_g251586.rgb , saturate( tex2DArrayNode83_g251586.a )));
					float4 temp_output_204_0_g251586 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251586 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251586).zw + ( (temp_output_204_0_g251586).xy * temp_output_81_0_g251586 ) ),temp_output_82_0_g251586) );
					float4 appendResult212_g251586 = (float4(tex2DArrayNode122_g251586.rgb , saturate( tex2DArrayNode122_g251586.a )));
					float4 TVE_RenderNearPositionR628_g251566 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251566 = saturate( ( distance( Model_PositionWS497_g251566 , (TVE_RenderNearPositionR628_g251566).xyz ) / (TVE_RenderNearPositionR628_g251566).w ) );
					float temp_output_7_0_g251567 = 1.0;
					float temp_output_9_0_g251567 = ( temp_output_507_0_g251566 - temp_output_7_0_g251567 );
					half TVE_RenderNearFadeValue635_g251566 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251566 = saturate( ( temp_output_9_0_g251567 / ( ( TVE_RenderNearFadeValue635_g251566 - temp_output_7_0_g251567 ) + 0.0001 ) ) );
					float4 lerpResult131_g251586 = lerp( appendResult210_g251586 , appendResult212_g251586 , Global_TexBlend509_g251566);
					float4 temp_output_159_109_g251584 = lerpResult131_g251586;
					float4 lerpResult168_g251584 = lerp( TVE_CoatParams , temp_output_159_109_g251584 , TVE_CoatLayers[(int)temp_output_82_0_g251584]);
					float4 temp_output_589_109_g251566 = lerpResult168_g251584;
					half4 Coat_Texture302_g251566 = temp_output_589_109_g251566;
					float4 In_CoatTexture204_g251566 = Coat_Texture302_g251566;
					float4 temp_output_595_164_g251566 = TVE_PaintParams;
					half4 Paint_Params575_g251566 = temp_output_595_164_g251566;
					float4 In_PaintParams204_g251566 = Paint_Params575_g251566;
					float4 temp_output_203_0_g251635 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251566 = lerp( Model_PositionWS_XZ143_g251566 , Model_PivotWS_XZ145_g251566 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251635 = lerpResult85_g251566;
					float temp_output_82_0_g251632 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251635 = temp_output_82_0_g251632;
					float4 tex2DArrayNode83_g251635 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251635).zw + ( (temp_output_203_0_g251635).xy * temp_output_81_0_g251635 ) ),temp_output_82_0_g251635) );
					float4 appendResult210_g251635 = (float4(tex2DArrayNode83_g251635.rgb , saturate( tex2DArrayNode83_g251635.a )));
					float4 temp_output_204_0_g251635 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251635 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251635).zw + ( (temp_output_204_0_g251635).xy * temp_output_81_0_g251635 ) ),temp_output_82_0_g251635) );
					float4 appendResult212_g251635 = (float4(tex2DArrayNode122_g251635.rgb , saturate( tex2DArrayNode122_g251635.a )));
					float4 lerpResult131_g251635 = lerp( appendResult210_g251635 , appendResult212_g251635 , Global_TexBlend509_g251566);
					float4 temp_output_171_109_g251632 = lerpResult131_g251635;
					float4 lerpResult174_g251632 = lerp( TVE_PaintParams , temp_output_171_109_g251632 , TVE_PaintLayers[(int)temp_output_82_0_g251632]);
					float4 temp_output_595_109_g251566 = lerpResult174_g251632;
					half4 Paint_Texture71_g251566 = temp_output_595_109_g251566;
					float4 In_PaintTexture204_g251566 = Paint_Texture71_g251566;
					float4 temp_output_590_141_g251566 = TVE_AtmoParams;
					half4 Atmo_Params601_g251566 = temp_output_590_141_g251566;
					float4 In_AtmoParams204_g251566 = Atmo_Params601_g251566;
					float4 temp_output_203_0_g251594 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251566 = lerp( Model_PositionWS_XZ143_g251566 , Model_PivotWS_XZ145_g251566 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251594 = lerpResult104_g251566;
					float temp_output_132_0_g251592 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251594 = temp_output_132_0_g251592;
					float4 tex2DArrayNode83_g251594 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251594).zw + ( (temp_output_203_0_g251594).xy * temp_output_81_0_g251594 ) ),temp_output_82_0_g251594) );
					float4 appendResult210_g251594 = (float4(tex2DArrayNode83_g251594.rgb , saturate( tex2DArrayNode83_g251594.a )));
					float4 temp_output_204_0_g251594 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251594 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251594).zw + ( (temp_output_204_0_g251594).xy * temp_output_81_0_g251594 ) ),temp_output_82_0_g251594) );
					float4 appendResult212_g251594 = (float4(tex2DArrayNode122_g251594.rgb , saturate( tex2DArrayNode122_g251594.a )));
					float4 lerpResult131_g251594 = lerp( appendResult210_g251594 , appendResult212_g251594 , Global_TexBlend509_g251566);
					float4 temp_output_137_109_g251592 = lerpResult131_g251594;
					float4 lerpResult145_g251592 = lerp( TVE_AtmoParams , temp_output_137_109_g251592 , TVE_AtmoLayers[(int)temp_output_132_0_g251592]);
					float4 temp_output_590_110_g251566 = lerpResult145_g251592;
					half4 Atmo_Texture80_g251566 = temp_output_590_110_g251566;
					float4 In_AtmoTexture204_g251566 = Atmo_Texture80_g251566;
					float4 temp_output_593_163_g251566 = TVE_GlowParams;
					half4 Glow_Params609_g251566 = temp_output_593_163_g251566;
					float4 In_GlowParams204_g251566 = Glow_Params609_g251566;
					float4 temp_output_203_0_g251610 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251566 = lerp( Model_PositionWS_XZ143_g251566 , Model_PivotWS_XZ145_g251566 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251610 = lerpResult247_g251566;
					float temp_output_82_0_g251608 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251610 = temp_output_82_0_g251608;
					float4 tex2DArrayNode83_g251610 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251610).zw + ( (temp_output_203_0_g251610).xy * temp_output_81_0_g251610 ) ),temp_output_82_0_g251610) );
					float4 appendResult210_g251610 = (float4(tex2DArrayNode83_g251610.rgb , saturate( tex2DArrayNode83_g251610.a )));
					float4 temp_output_204_0_g251610 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251610 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251610).zw + ( (temp_output_204_0_g251610).xy * temp_output_81_0_g251610 ) ),temp_output_82_0_g251610) );
					float4 appendResult212_g251610 = (float4(tex2DArrayNode122_g251610.rgb , saturate( tex2DArrayNode122_g251610.a )));
					float4 lerpResult131_g251610 = lerp( appendResult210_g251610 , appendResult212_g251610 , Global_TexBlend509_g251566);
					float4 temp_output_159_109_g251608 = lerpResult131_g251610;
					float4 lerpResult167_g251608 = lerp( TVE_GlowParams , temp_output_159_109_g251608 , TVE_GlowLayers[(int)temp_output_82_0_g251608]);
					float4 temp_output_593_109_g251566 = lerpResult167_g251608;
					half4 Glow_Texture248_g251566 = temp_output_593_109_g251566;
					float4 In_GlowTexture204_g251566 = Glow_Texture248_g251566;
					float4 temp_output_592_139_g251566 = TVE_FormParams;
					float4 Form_Params606_g251566 = temp_output_592_139_g251566;
					float4 In_FormParams204_g251566 = Form_Params606_g251566;
					float4 temp_output_203_0_g251626 = TVE_FormBaseCoord;
					float2 lerpResult168_g251566 = lerp( Model_PositionWS_XZ143_g251566 , Model_PivotWS_XZ145_g251566 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251626 = lerpResult168_g251566;
					float temp_output_130_0_g251624 = _GlobalFormLayerValue;
					float temp_output_82_0_g251626 = temp_output_130_0_g251624;
					float4 tex2DArrayNode83_g251626 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251626).zw + ( (temp_output_203_0_g251626).xy * temp_output_81_0_g251626 ) ),temp_output_82_0_g251626) );
					float4 appendResult210_g251626 = (float4(tex2DArrayNode83_g251626.rgb , saturate( tex2DArrayNode83_g251626.a )));
					float4 temp_output_204_0_g251626 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251626 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251626).zw + ( (temp_output_204_0_g251626).xy * temp_output_81_0_g251626 ) ),temp_output_82_0_g251626) );
					float4 appendResult212_g251626 = (float4(tex2DArrayNode122_g251626.rgb , saturate( tex2DArrayNode122_g251626.a )));
					float4 lerpResult131_g251626 = lerp( appendResult210_g251626 , appendResult212_g251626 , Global_TexBlend509_g251566);
					float4 temp_output_135_109_g251624 = lerpResult131_g251626;
					float4 lerpResult143_g251624 = lerp( TVE_FormParams , temp_output_135_109_g251624 , TVE_FormLayers[(int)temp_output_130_0_g251624]);
					float4 temp_output_592_0_g251566 = lerpResult143_g251624;
					float4 Form_Texture112_g251566 = temp_output_592_0_g251566;
					float4 In_FormTexture204_g251566 = Form_Texture112_g251566;
					float4 temp_output_594_145_g251566 = TVE_FlowParams;
					half4 Flow_Params612_g251566 = temp_output_594_145_g251566;
					float4 In_FlowParams204_g251566 = Flow_Params612_g251566;
					float4 temp_output_203_0_g251618 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251566 = lerp( Model_PositionWS_XZ143_g251566 , Model_PivotWS_XZ145_g251566 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251618 = lerpResult400_g251566;
					float temp_output_136_0_g251616 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251618 = temp_output_136_0_g251616;
					float4 tex2DArrayNode83_g251618 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251618).zw + ( (temp_output_203_0_g251618).xy * temp_output_81_0_g251618 ) ),temp_output_82_0_g251618) );
					float4 appendResult210_g251618 = (float4(tex2DArrayNode83_g251618.rgb , saturate( tex2DArrayNode83_g251618.a )));
					float4 temp_output_204_0_g251618 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251618 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251618).zw + ( (temp_output_204_0_g251618).xy * temp_output_81_0_g251618 ) ),temp_output_82_0_g251618) );
					float4 appendResult212_g251618 = (float4(tex2DArrayNode122_g251618.rgb , saturate( tex2DArrayNode122_g251618.a )));
					float4 lerpResult131_g251618 = lerp( appendResult210_g251618 , appendResult212_g251618 , Global_TexBlend509_g251566);
					float4 temp_output_141_109_g251616 = lerpResult131_g251618;
					float4 lerpResult149_g251616 = lerp( TVE_FlowParams , temp_output_141_109_g251616 , TVE_FlowLayers[(int)temp_output_136_0_g251616]);
					half4 Flow_Texture405_g251566 = lerpResult149_g251616;
					float4 In_FlowTexture204_g251566 = Flow_Texture405_g251566;
					BuildGlobalData( Data204_g251566 , In_Dummy204_g251566 , In_CoatParams204_g251566 , In_CoatTexture204_g251566 , In_PaintParams204_g251566 , In_PaintTexture204_g251566 , In_AtmoParams204_g251566 , In_AtmoTexture204_g251566 , In_GlowParams204_g251566 , In_GlowTexture204_g251566 , In_FormParams204_g251566 , In_FormTexture204_g251566 , In_FlowParams204_g251566 , In_FlowTexture204_g251566 );
					TVEGlobalData Data15_g251644 =(TVEGlobalData)Data204_g251566;
					float Out_Dummy15_g251644 = 0.0;
					float4 Out_CoatParams15_g251644 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251644 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251644 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251644 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251644 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251644 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251644 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251644 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251644 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251644 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251644 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251644 = float4( 0,0,0,0 );
					BreakData( Data15_g251644 , Out_Dummy15_g251644 , Out_CoatParams15_g251644 , Out_CoatTexture15_g251644 , Out_PaintParams15_g251644 , Out_PaintTexture15_g251644 , Out_AtmoParams15_g251644 , Out_AtmoTexture15_g251644 , Out_GlowParams15_g251644 , Out_GlowTexture15_g251644 , Out_FormParams15_g251644 , Out_FormTexture15_g251644 , Out_FlowParams15_g251644 , Out_FlowTexture15_g251644 );
					float4 temp_output_2419_27 = Out_CoatTexture15_g251644;
					float3 ifLocalVar40_g251674 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g251674 = (temp_output_2419_27).xxx;
					float3 ifLocalVar40_g251675 = 0;
					if( TVE_DEBUG_Index == 3.0 )
					ifLocalVar40_g251675 = (temp_output_2419_27).yyy;
					float3 ifLocalVar40_g251731 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g251731 = (temp_output_2419_27).zzz;
					float4 temp_output_2419_0 = Out_PaintTexture15_g251644;
					float3 ifLocalVar40_g251732 = 0;
					if( TVE_DEBUG_Index == 6.0 )
					ifLocalVar40_g251732 = (temp_output_2419_0).xyz;
					float3 ifLocalVar40_g251733 = 0;
					if( TVE_DEBUG_Index == 7.0 )
					ifLocalVar40_g251733 = (temp_output_2419_0).www;
					float4 temp_output_2419_16 = Out_AtmoTexture15_g251644;
					float3 ifLocalVar40_g251734 = 0;
					if( TVE_DEBUG_Index == 9.0 )
					ifLocalVar40_g251734 = (temp_output_2419_16).xxx;
					float3 ifLocalVar40_g251735 = 0;
					if( TVE_DEBUG_Index == 10.0 )
					ifLocalVar40_g251735 = (temp_output_2419_16).yyy;
					float3 ifLocalVar40_g251736 = 0;
					if( TVE_DEBUG_Index == 11.0 )
					ifLocalVar40_g251736 = (temp_output_2419_16).zzz;
					float3 ifLocalVar40_g251737 = 0;
					if( TVE_DEBUG_Index == 12.0 )
					ifLocalVar40_g251737 = (temp_output_2419_16).www;
					float4 temp_output_2419_19 = Out_GlowTexture15_g251644;
					float3 ifLocalVar40_g251738 = 0;
					if( TVE_DEBUG_Index == 14.0 )
					ifLocalVar40_g251738 = (temp_output_2419_19).xyz;
					float3 ifLocalVar40_g251739 = 0;
					if( TVE_DEBUG_Index == 15.0 )
					ifLocalVar40_g251739 = (temp_output_2419_19).www;
					float4 temp_output_2419_18 = Out_FormTexture15_g251644;
					float3 appendResult2536 = (float3((temp_output_2419_18).xy , 0.0));
					float3 ifLocalVar40_g251740 = 0;
					if( TVE_DEBUG_Index == 17.0 )
					ifLocalVar40_g251740 = ( appendResult2536 * appendResult2536 );
					float3 temp_output_2537_0 = ( (temp_output_2419_18).zzz * 0.1 );
					float3 ifLocalVar40_g251741 = 0;
					if( TVE_DEBUG_Index == 18.0 )
					ifLocalVar40_g251741 = temp_output_2537_0;
					float3 ifLocalVar40_g251742 = 0;
					if( TVE_DEBUG_Index == 19.0 )
					ifLocalVar40_g251742 = (temp_output_2419_18).www;
					float4 temp_output_2419_24 = Out_FlowTexture15_g251644;
					float2 temp_output_2435_0 = (temp_output_2419_24).xy;
					float3 appendResult2501 = (float3(temp_output_2435_0 , 0.0));
					float3 ifLocalVar40_g251743 = 0;
					if( TVE_DEBUG_Index == 21.0 )
					ifLocalVar40_g251743 = ( appendResult2501 * appendResult2501 );
					float3 ifLocalVar40_g251744 = 0;
					if( TVE_DEBUG_Index == 22.0 )
					ifLocalVar40_g251744 = (temp_output_2419_24).zzz;
					float3 ifLocalVar40_g251745 = 0;
					if( TVE_DEBUG_Index == 23.0 )
					ifLocalVar40_g251745 = (temp_output_2419_24).www;
					half3 Final_Debug2399 = ( ifLocalVar40_g251757 + ( ifLocalVar40_g251674 + ifLocalVar40_g251675 + ifLocalVar40_g251731 ) + ( ifLocalVar40_g251732 + ifLocalVar40_g251733 ) + ( ifLocalVar40_g251734 + ifLocalVar40_g251735 + ifLocalVar40_g251736 + ifLocalVar40_g251737 ) + ( ifLocalVar40_g251738 + ifLocalVar40_g251739 ) + ( ifLocalVar40_g251740 + ifLocalVar40_g251741 + ifLocalVar40_g251742 ) + ( ifLocalVar40_g251743 + ifLocalVar40_g251744 + ifLocalVar40_g251745 ) );
					float temp_output_7_0_g251792 = TVE_DEBUG_Min;
					float3 temp_cast_17 = (temp_output_7_0_g251792).xxx;
					float3 temp_output_9_0_g251792 = ( Final_Debug2399 - temp_cast_17 );
					float lerpResult76_g251784 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g251784 = lerpResult76_g251784;
					float3 lerpResult72_g251784 = lerp( (lerpResult73_g251785).rgb , saturate( ( temp_output_9_0_g251792 / ( ( TVE_DEBUG_Max - temp_output_7_0_g251792 ) + 0.0001 ) ) ) , Filter152_g251784);
					float dotResult61_g251784 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g251784 = ( 1.0 - saturate( dotResult61_g251784 ) );
					float Shading_Fresnel59_g251784 = (( 1.0 - ( temp_output_65_0_g251784 * temp_output_65_0_g251784 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g251784 = IN.ase_texcoord7;
					float depthLinearEye57_g251784 = LinearEyeDepth( ase_positionCS57_g251784.z / ase_positionCS57_g251784.w );
					float temp_output_69_0_g251784 = saturate(  (0.0 + ( depthLinearEye57_g251784 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g251784 = (( temp_output_69_0_g251784 * temp_output_69_0_g251784 )*0.5 + 0.5);
					float lerpResult84_g251784 = lerp( 1.0 , Shading_Fresnel59_g251784 , ( Shading_Distance58_g251784 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g251789 = ( 0.0 );
					float localBuildVisualData3_g251763 = ( 0.0 );
					TVEVisualData Data3_g251763 =(TVEVisualData)0;
					half4 Dummy130_g251762 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) );
					float temp_output_14_0_g251763 = Dummy130_g251762.x;
					float In_Dummy3_g251763 = temp_output_14_0_g251763;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251782) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g251777 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g251777 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g251777 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g251777 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g251777 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g251777 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g251782 = staticSwitch36_g251777;
					float localBreakTextureData456_g251782 = ( 0.0 );
					float localBuildTextureData431_g251776 = ( 0.0 );
					TVEMasksData Data431_g251776 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g251776 = ( 0.0 );
					half4 Local_Coords180_g251762 = _main_coord_value;
					float4 Coords444_g251776 = Local_Coords180_g251762;
					TVEModelData Data15_g251775 =(TVEModelData)Data26_g251486;
					float Out_Dummy15_g251775 = 0.0;
					float3 Out_PositionWS15_g251775 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251775 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251775 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251775 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251775 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251775 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251775 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251775 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251775 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251775 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251775 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251775 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251775 , Out_Dummy15_g251775 , Out_PositionWS15_g251775 , Out_PositionWO15_g251775 , Out_PivotWS15_g251775 , Out_PivotWO15_g251775 , Out_NormalWS15_g251775 , Out_TangentWS15_g251775 , Out_BitangentWS15_g251775 , Out_TriplanarWeights15_g251775 , Out_ViewDirWS15_g251775 , Out_CoordsData15_g251775 , Out_VertexData15_g251775 , Out_PhaseData15_g251775 );
					float4 Model_CoordsData324_g251762 = Out_CoordsData15_g251775;
					float4 MeshCoords444_g251776 = Model_CoordsData324_g251762;
					float2 UV0444_g251776 = float2( 0,0 );
					float2 UV3444_g251776 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g251776 , MeshCoords444_g251776 , UV0444_g251776 , UV3444_g251776 );
					float4 appendResult430_g251776 = (float4(UV0444_g251776 , UV3444_g251776));
					float4 In_MaskA431_g251776 = appendResult430_g251776;
					float localComputeWorldCoords315_g251776 = ( 0.0 );
					float4 Coords315_g251776 = Local_Coords180_g251762;
					float3 Model_PositionWO222_g251762 = Out_PositionWO15_g251775;
					float3 PositionWS315_g251776 = Model_PositionWO222_g251762;
					float2 ZY315_g251776 = float2( 0,0 );
					float2 XZ315_g251776 = float2( 0,0 );
					float2 XY315_g251776 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g251776 , PositionWS315_g251776 , ZY315_g251776 , XZ315_g251776 , XY315_g251776 );
					float2 ZY402_g251776 = ZY315_g251776;
					float2 XZ403_g251776 = XZ315_g251776;
					float4 appendResult432_g251776 = (float4(ZY402_g251776 , XZ403_g251776));
					float4 In_MaskB431_g251776 = appendResult432_g251776;
					float2 XY404_g251776 = XY315_g251776;
					float localComputeStochasticCoords409_g251776 = ( 0.0 );
					float2 UV409_g251776 = ZY402_g251776;
					float2 UV1409_g251776 = float2( 0,0 );
					float2 UV2409_g251776 = float2( 0,0 );
					float2 UV3409_g251776 = float2( 0,0 );
					float3 Weights409_g251776 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g251776 , UV1409_g251776 , UV2409_g251776 , UV3409_g251776 , Weights409_g251776 );
					float4 appendResult433_g251776 = (float4(XY404_g251776 , UV1409_g251776));
					float4 In_MaskC431_g251776 = appendResult433_g251776;
					float4 appendResult434_g251776 = (float4(UV2409_g251776 , UV3409_g251776));
					float4 In_MaskD431_g251776 = appendResult434_g251776;
					float localComputeStochasticCoords422_g251776 = ( 0.0 );
					float2 UV422_g251776 = XZ403_g251776;
					float2 UV1422_g251776 = float2( 0,0 );
					float2 UV2422_g251776 = float2( 0,0 );
					float2 UV3422_g251776 = float2( 0,0 );
					float3 Weights422_g251776 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g251776 , UV1422_g251776 , UV2422_g251776 , UV3422_g251776 , Weights422_g251776 );
					float4 appendResult435_g251776 = (float4(UV1422_g251776 , UV2422_g251776));
					float4 In_MaskE431_g251776 = appendResult435_g251776;
					float localComputeStochasticCoords423_g251776 = ( 0.0 );
					float2 UV423_g251776 = XY404_g251776;
					float2 UV1423_g251776 = float2( 0,0 );
					float2 UV2423_g251776 = float2( 0,0 );
					float2 UV3423_g251776 = float2( 0,0 );
					float3 Weights423_g251776 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g251776 , UV1423_g251776 , UV2423_g251776 , UV3423_g251776 , Weights423_g251776 );
					float4 appendResult436_g251776 = (float4(UV3422_g251776 , UV1423_g251776));
					float4 In_MaskF431_g251776 = appendResult436_g251776;
					float4 appendResult437_g251776 = (float4(UV2423_g251776 , UV3423_g251776));
					float4 In_MaskG431_g251776 = appendResult437_g251776;
					float4 In_MaskH431_g251776 = float4( Weights409_g251776 , 0.0 );
					float4 In_MaskI431_g251776 = float4( Weights422_g251776 , 0.0 );
					float4 In_MaskJ431_g251776 = float4( Weights423_g251776 , 0.0 );
					half3 Model_NormalWS226_g251762 = Out_NormalWS15_g251775;
					float3 temp_output_449_0_g251776 = Model_NormalWS226_g251762;
					float4 In_MaskK431_g251776 = float4( temp_output_449_0_g251776 , 0.0 );
					half3 Model_TangentWS366_g251762 = Out_TangentWS15_g251775;
					float3 temp_output_450_0_g251776 = Model_TangentWS366_g251762;
					float4 In_MaskL431_g251776 = float4( temp_output_450_0_g251776 , 0.0 );
					half3 Model_BitangentWS367_g251762 = Out_BitangentWS15_g251775;
					float3 temp_output_451_0_g251776 = Model_BitangentWS367_g251762;
					float4 In_MaskM431_g251776 = float4( temp_output_451_0_g251776 , 0.0 );
					half3 Model_TriplanarWeights368_g251762 = Out_TriplanarWeights15_g251775;
					float3 temp_output_445_0_g251776 = Model_TriplanarWeights368_g251762;
					float4 In_MaskN431_g251776 = float4( temp_output_445_0_g251776 , 0.0 );
					BuildTextureData( Data431_g251776 , In_MaskA431_g251776 , In_MaskB431_g251776 , In_MaskC431_g251776 , In_MaskD431_g251776 , In_MaskE431_g251776 , In_MaskF431_g251776 , In_MaskG431_g251776 , In_MaskH431_g251776 , In_MaskI431_g251776 , In_MaskJ431_g251776 , In_MaskK431_g251776 , In_MaskL431_g251776 , In_MaskM431_g251776 , In_MaskN431_g251776 );
					TVEMasksData Data456_g251782 =(TVEMasksData)Data431_g251776;
					float4 Out_MaskA456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251782 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251782 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251782 , Out_MaskA456_g251782 , Out_MaskB456_g251782 , Out_MaskC456_g251782 , Out_MaskD456_g251782 , Out_MaskE456_g251782 , Out_MaskF456_g251782 , Out_MaskG456_g251782 , Out_MaskH456_g251782 , Out_MaskI456_g251782 , Out_MaskJ456_g251782 , Out_MaskK456_g251782 , Out_MaskL456_g251782 , Out_MaskM456_g251782 , Out_MaskN456_g251782 );
					half2 UV276_g251782 = (Out_MaskA456_g251782).xy;
					float temp_output_504_0_g251782 = 0.0;
					half Bias276_g251782 = temp_output_504_0_g251782;
					half2 Normal276_g251782 = float2( 0,0 );
					half4 localSampleCoord276_g251782 = SampleCoord( Texture276_g251782 , Sampler276_g251782 , UV276_g251782 , Bias276_g251782 , Normal276_g251782 );
					float4 temp_output_407_277_g251762 = localSampleCoord276_g251782;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251782) = _MainAlbedoTex;
					SamplerState Sampler502_g251782 = staticSwitch36_g251777;
					half2 UV502_g251782 = (Out_MaskA456_g251782).zw;
					half Bias502_g251782 = temp_output_504_0_g251782;
					half2 Normal502_g251782 = float2( 0,0 );
					half4 localSampleCoord502_g251782 = SampleCoord( Texture502_g251782 , Sampler502_g251782 , UV502_g251782 , Bias502_g251782 , Normal502_g251782 );
					float4 temp_output_407_278_g251762 = localSampleCoord502_g251782;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251782) = _MainAlbedoTex;
					SamplerState Sampler496_g251782 = staticSwitch36_g251777;
					float2 temp_output_463_0_g251782 = (Out_MaskB456_g251782).zw;
					half2 XZ496_g251782 = temp_output_463_0_g251782;
					half Bias496_g251782 = temp_output_504_0_g251782;
					float3 temp_output_483_0_g251782 = (Out_MaskK456_g251782).xyz;
					half3 NormalWS496_g251782 = temp_output_483_0_g251782;
					half3 Normal496_g251782 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251782 = SamplePlanar2D( Texture496_g251782 , Sampler496_g251782 , XZ496_g251782 , Bias496_g251782 , NormalWS496_g251782 , Normal496_g251782 );
					float4 temp_output_407_0_g251762 = localSamplePlanar2D496_g251782;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251782) = _MainAlbedoTex;
					SamplerState Sampler490_g251782 = staticSwitch36_g251777;
					float2 temp_output_462_0_g251782 = (Out_MaskB456_g251782).xy;
					half2 ZY490_g251782 = temp_output_462_0_g251782;
					half2 XZ490_g251782 = temp_output_463_0_g251782;
					float2 temp_output_464_0_g251782 = (Out_MaskC456_g251782).xy;
					half2 XY490_g251782 = temp_output_464_0_g251782;
					half Bias490_g251782 = temp_output_504_0_g251782;
					float3 temp_output_482_0_g251782 = (Out_MaskN456_g251782).xyz;
					half3 Triplanar490_g251782 = temp_output_482_0_g251782;
					half3 NormalWS490_g251782 = temp_output_483_0_g251782;
					half3 Normal490_g251782 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251782 = SamplePlanar3D( Texture490_g251782 , Sampler490_g251782 , ZY490_g251782 , XZ490_g251782 , XY490_g251782 , Bias490_g251782 , Triplanar490_g251782 , NormalWS490_g251782 , Normal490_g251782 );
					float4 temp_output_407_201_g251762 = localSamplePlanar3D490_g251782;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251782) = _MainAlbedoTex;
					SamplerState Sampler498_g251782 = staticSwitch36_g251777;
					half2 XZ498_g251782 = temp_output_463_0_g251782;
					float2 temp_output_473_0_g251782 = (Out_MaskE456_g251782).xy;
					half2 XZ_1498_g251782 = temp_output_473_0_g251782;
					float2 temp_output_474_0_g251782 = (Out_MaskE456_g251782).zw;
					half2 XZ_2498_g251782 = temp_output_474_0_g251782;
					float2 temp_output_475_0_g251782 = (Out_MaskF456_g251782).xy;
					half2 XZ_3498_g251782 = temp_output_475_0_g251782;
					float temp_output_510_0_g251782 = exp2( temp_output_504_0_g251782 );
					half Bias498_g251782 = temp_output_510_0_g251782;
					float3 temp_output_480_0_g251782 = (Out_MaskI456_g251782).xyz;
					half3 Weights_2498_g251782 = temp_output_480_0_g251782;
					half3 NormalWS498_g251782 = temp_output_483_0_g251782;
					half3 Normal498_g251782 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251782 = SampleStochastic2D( Texture498_g251782 , Sampler498_g251782 , XZ498_g251782 , XZ_1498_g251782 , XZ_2498_g251782 , XZ_3498_g251782 , Bias498_g251782 , Weights_2498_g251782 , NormalWS498_g251782 , Normal498_g251782 );
					float4 temp_output_407_202_g251762 = localSampleStochastic2D498_g251782;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251782) = _MainAlbedoTex;
					SamplerState Sampler500_g251782 = staticSwitch36_g251777;
					half2 ZY500_g251782 = temp_output_462_0_g251782;
					half2 ZY_1500_g251782 = (Out_MaskC456_g251782).zw;
					half2 ZY_2500_g251782 = (Out_MaskD456_g251782).xy;
					half2 ZY_3500_g251782 = (Out_MaskD456_g251782).zw;
					half2 XZ500_g251782 = temp_output_463_0_g251782;
					half2 XZ_1500_g251782 = temp_output_473_0_g251782;
					half2 XZ_2500_g251782 = temp_output_474_0_g251782;
					half2 XZ_3500_g251782 = temp_output_475_0_g251782;
					half2 XY500_g251782 = temp_output_464_0_g251782;
					half2 XY_1500_g251782 = (Out_MaskF456_g251782).zw;
					half2 XY_2500_g251782 = (Out_MaskG456_g251782).xy;
					half2 XY_3500_g251782 = (Out_MaskG456_g251782).zw;
					half Bias500_g251782 = temp_output_510_0_g251782;
					half3 Weights_1500_g251782 = (Out_MaskH456_g251782).xyz;
					half3 Weights_2500_g251782 = temp_output_480_0_g251782;
					half3 Weights_3500_g251782 = (Out_MaskJ456_g251782).xyz;
					half3 Triplanar500_g251782 = temp_output_482_0_g251782;
					half3 NormalWS500_g251782 = temp_output_483_0_g251782;
					half3 Normal500_g251782 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251782 = SampleStochastic3D( Texture500_g251782 , Sampler500_g251782 , ZY500_g251782 , ZY_1500_g251782 , ZY_2500_g251782 , ZY_3500_g251782 , XZ500_g251782 , XZ_1500_g251782 , XZ_2500_g251782 , XZ_3500_g251782 , XY500_g251782 , XY_1500_g251782 , XY_2500_g251782 , XY_3500_g251782 , Bias500_g251782 , Weights_1500_g251782 , Weights_2500_g251782 , Weights_3500_g251782 , Triplanar500_g251782 , NormalWS500_g251782 , Normal500_g251782 );
					float4 temp_output_407_203_g251762 = localSampleStochastic3D500_g251782;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g251762 = temp_output_407_277_g251762;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g251762 = temp_output_407_278_g251762;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g251762 = temp_output_407_0_g251762;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g251762 = temp_output_407_201_g251762;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g251762 = temp_output_407_202_g251762;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g251762 = temp_output_407_203_g251762;
					#else
					float4 staticSwitch184_g251762 = temp_output_407_277_g251762;
					#endif
					half4 Local_AlbedoSample185_g251762 = staticSwitch184_g251762;
					float3 lerpResult53_g251762 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g251762).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g251762 = lerpResult53_g251762;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251780) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g251779 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g251779 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g251779 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g251779 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g251779 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g251779 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251780 = staticSwitch38_g251779;
					float localBreakTextureData456_g251780 = ( 0.0 );
					TVEMasksData Data456_g251780 =(TVEMasksData)Data431_g251776;
					float4 Out_MaskA456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251780 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251780 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251780 , Out_MaskA456_g251780 , Out_MaskB456_g251780 , Out_MaskC456_g251780 , Out_MaskD456_g251780 , Out_MaskE456_g251780 , Out_MaskF456_g251780 , Out_MaskG456_g251780 , Out_MaskH456_g251780 , Out_MaskI456_g251780 , Out_MaskJ456_g251780 , Out_MaskK456_g251780 , Out_MaskL456_g251780 , Out_MaskM456_g251780 , Out_MaskN456_g251780 );
					half2 UV276_g251780 = (Out_MaskA456_g251780).xy;
					float temp_output_504_0_g251780 = 0.0;
					half Bias276_g251780 = temp_output_504_0_g251780;
					half2 Normal276_g251780 = float2( 0,0 );
					half4 localSampleCoord276_g251780 = SampleCoord( Texture276_g251780 , Sampler276_g251780 , UV276_g251780 , Bias276_g251780 , Normal276_g251780 );
					float4 temp_output_405_277_g251762 = localSampleCoord276_g251780;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251780) = _MainShaderTex;
					SamplerState Sampler502_g251780 = staticSwitch38_g251779;
					half2 UV502_g251780 = (Out_MaskA456_g251780).zw;
					half Bias502_g251780 = temp_output_504_0_g251780;
					half2 Normal502_g251780 = float2( 0,0 );
					half4 localSampleCoord502_g251780 = SampleCoord( Texture502_g251780 , Sampler502_g251780 , UV502_g251780 , Bias502_g251780 , Normal502_g251780 );
					float4 temp_output_405_278_g251762 = localSampleCoord502_g251780;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251780) = _MainShaderTex;
					SamplerState Sampler496_g251780 = staticSwitch38_g251779;
					float2 temp_output_463_0_g251780 = (Out_MaskB456_g251780).zw;
					half2 XZ496_g251780 = temp_output_463_0_g251780;
					half Bias496_g251780 = temp_output_504_0_g251780;
					float3 temp_output_483_0_g251780 = (Out_MaskK456_g251780).xyz;
					half3 NormalWS496_g251780 = temp_output_483_0_g251780;
					half3 Normal496_g251780 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251780 = SamplePlanar2D( Texture496_g251780 , Sampler496_g251780 , XZ496_g251780 , Bias496_g251780 , NormalWS496_g251780 , Normal496_g251780 );
					float4 temp_output_405_0_g251762 = localSamplePlanar2D496_g251780;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251780) = _MainShaderTex;
					SamplerState Sampler490_g251780 = staticSwitch38_g251779;
					float2 temp_output_462_0_g251780 = (Out_MaskB456_g251780).xy;
					half2 ZY490_g251780 = temp_output_462_0_g251780;
					half2 XZ490_g251780 = temp_output_463_0_g251780;
					float2 temp_output_464_0_g251780 = (Out_MaskC456_g251780).xy;
					half2 XY490_g251780 = temp_output_464_0_g251780;
					half Bias490_g251780 = temp_output_504_0_g251780;
					float3 temp_output_482_0_g251780 = (Out_MaskN456_g251780).xyz;
					half3 Triplanar490_g251780 = temp_output_482_0_g251780;
					half3 NormalWS490_g251780 = temp_output_483_0_g251780;
					half3 Normal490_g251780 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251780 = SamplePlanar3D( Texture490_g251780 , Sampler490_g251780 , ZY490_g251780 , XZ490_g251780 , XY490_g251780 , Bias490_g251780 , Triplanar490_g251780 , NormalWS490_g251780 , Normal490_g251780 );
					float4 temp_output_405_201_g251762 = localSamplePlanar3D490_g251780;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251780) = _MainShaderTex;
					SamplerState Sampler498_g251780 = staticSwitch38_g251779;
					half2 XZ498_g251780 = temp_output_463_0_g251780;
					float2 temp_output_473_0_g251780 = (Out_MaskE456_g251780).xy;
					half2 XZ_1498_g251780 = temp_output_473_0_g251780;
					float2 temp_output_474_0_g251780 = (Out_MaskE456_g251780).zw;
					half2 XZ_2498_g251780 = temp_output_474_0_g251780;
					float2 temp_output_475_0_g251780 = (Out_MaskF456_g251780).xy;
					half2 XZ_3498_g251780 = temp_output_475_0_g251780;
					float temp_output_510_0_g251780 = exp2( temp_output_504_0_g251780 );
					half Bias498_g251780 = temp_output_510_0_g251780;
					float3 temp_output_480_0_g251780 = (Out_MaskI456_g251780).xyz;
					half3 Weights_2498_g251780 = temp_output_480_0_g251780;
					half3 NormalWS498_g251780 = temp_output_483_0_g251780;
					half3 Normal498_g251780 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251780 = SampleStochastic2D( Texture498_g251780 , Sampler498_g251780 , XZ498_g251780 , XZ_1498_g251780 , XZ_2498_g251780 , XZ_3498_g251780 , Bias498_g251780 , Weights_2498_g251780 , NormalWS498_g251780 , Normal498_g251780 );
					float4 temp_output_405_202_g251762 = localSampleStochastic2D498_g251780;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251780) = _MainShaderTex;
					SamplerState Sampler500_g251780 = staticSwitch38_g251779;
					half2 ZY500_g251780 = temp_output_462_0_g251780;
					half2 ZY_1500_g251780 = (Out_MaskC456_g251780).zw;
					half2 ZY_2500_g251780 = (Out_MaskD456_g251780).xy;
					half2 ZY_3500_g251780 = (Out_MaskD456_g251780).zw;
					half2 XZ500_g251780 = temp_output_463_0_g251780;
					half2 XZ_1500_g251780 = temp_output_473_0_g251780;
					half2 XZ_2500_g251780 = temp_output_474_0_g251780;
					half2 XZ_3500_g251780 = temp_output_475_0_g251780;
					half2 XY500_g251780 = temp_output_464_0_g251780;
					half2 XY_1500_g251780 = (Out_MaskF456_g251780).zw;
					half2 XY_2500_g251780 = (Out_MaskG456_g251780).xy;
					half2 XY_3500_g251780 = (Out_MaskG456_g251780).zw;
					half Bias500_g251780 = temp_output_510_0_g251780;
					half3 Weights_1500_g251780 = (Out_MaskH456_g251780).xyz;
					half3 Weights_2500_g251780 = temp_output_480_0_g251780;
					half3 Weights_3500_g251780 = (Out_MaskJ456_g251780).xyz;
					half3 Triplanar500_g251780 = temp_output_482_0_g251780;
					half3 NormalWS500_g251780 = temp_output_483_0_g251780;
					half3 Normal500_g251780 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251780 = SampleStochastic3D( Texture500_g251780 , Sampler500_g251780 , ZY500_g251780 , ZY_1500_g251780 , ZY_2500_g251780 , ZY_3500_g251780 , XZ500_g251780 , XZ_1500_g251780 , XZ_2500_g251780 , XZ_3500_g251780 , XY500_g251780 , XY_1500_g251780 , XY_2500_g251780 , XY_3500_g251780 , Bias500_g251780 , Weights_1500_g251780 , Weights_2500_g251780 , Weights_3500_g251780 , Triplanar500_g251780 , NormalWS500_g251780 , Normal500_g251780 );
					float4 temp_output_405_203_g251762 = localSampleStochastic3D500_g251780;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g251762 = temp_output_405_277_g251762;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g251762 = temp_output_405_278_g251762;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g251762 = temp_output_405_0_g251762;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g251762 = temp_output_405_201_g251762;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g251762 = temp_output_405_202_g251762;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g251762 = temp_output_405_203_g251762;
					#else
					float4 staticSwitch198_g251762 = temp_output_405_277_g251762;
					#endif
					half4 Local_ShaderSample199_g251762 = staticSwitch198_g251762;
					float temp_output_209_0_g251762 = (Local_ShaderSample199_g251762).y;
					float temp_output_7_0_g251768 = _MainOcclusionRemap.x;
					float temp_output_9_0_g251768 = ( temp_output_209_0_g251762 - temp_output_7_0_g251768 );
					float lerpResult23_g251762 = lerp( 1.0 , saturate( ( temp_output_9_0_g251768 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g251762 = lerpResult23_g251762;
					float temp_output_213_0_g251762 = (Local_ShaderSample199_g251762).w;
					float temp_output_7_0_g251772 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g251772 = ( temp_output_213_0_g251762 - temp_output_7_0_g251772 );
					half Local_Smoothness317_g251762 = ( saturate( ( temp_output_9_0_g251772 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g251762 = (float4(( (Local_ShaderSample199_g251762).x * _MainMetallicValue ) , Local_Occlusion313_g251762 , (Local_ShaderSample199_g251762).z , Local_Smoothness317_g251762));
					half4 Local_Masks109_g251762 = appendResult73_g251762;
					float temp_output_135_0_g251762 = (Local_Masks109_g251762).z;
					float temp_output_7_0_g251767 = _MainMultiRemap.x;
					float temp_output_9_0_g251767 = ( temp_output_135_0_g251762 - temp_output_7_0_g251767 );
					float temp_output_42_0_g251762 = saturate( ( temp_output_9_0_g251767 * _MainMultiRemap.z ) );
					half Local_MultiMask78_g251762 = temp_output_42_0_g251762;
					float lerpResult58_g251762 = lerp( 1.0 , Local_MultiMask78_g251762 , _MainColorMode);
					float4 lerpResult62_g251762 = lerp( _MainColorTwo , _MainColor , lerpResult58_g251762);
					half3 Local_ColorRGB93_g251762 = (lerpResult62_g251762).rgb;
					half3 Local_Albedo139_g251762 = ( Local_AlbedoRGB107_g251762 * Local_ColorRGB93_g251762 );
					float3 temp_output_4_0_g251763 = Local_Albedo139_g251762;
					float3 In_Albedo3_g251763 = temp_output_4_0_g251763;
					float3 temp_output_44_0_g251763 = Local_Albedo139_g251762;
					float3 In_AlbedoBase3_g251763 = temp_output_44_0_g251763;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251781) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g251778 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g251778 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g251778 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g251778 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g251778 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g251778 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251781 = staticSwitch37_g251778;
					float localBreakTextureData456_g251781 = ( 0.0 );
					TVEMasksData Data456_g251781 =(TVEMasksData)Data431_g251776;
					float4 Out_MaskA456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251781 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251781 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251781 , Out_MaskA456_g251781 , Out_MaskB456_g251781 , Out_MaskC456_g251781 , Out_MaskD456_g251781 , Out_MaskE456_g251781 , Out_MaskF456_g251781 , Out_MaskG456_g251781 , Out_MaskH456_g251781 , Out_MaskI456_g251781 , Out_MaskJ456_g251781 , Out_MaskK456_g251781 , Out_MaskL456_g251781 , Out_MaskM456_g251781 , Out_MaskN456_g251781 );
					half2 UV276_g251781 = (Out_MaskA456_g251781).xy;
					float temp_output_504_0_g251781 = 0.0;
					half Bias276_g251781 = temp_output_504_0_g251781;
					half2 Normal276_g251781 = float2( 0,0 );
					half4 localSampleCoord276_g251781 = SampleCoord( Texture276_g251781 , Sampler276_g251781 , UV276_g251781 , Bias276_g251781 , Normal276_g251781 );
					float2 temp_output_406_394_g251762 = Normal276_g251781;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251781) = _MainNormalTex;
					SamplerState Sampler502_g251781 = staticSwitch37_g251778;
					half2 UV502_g251781 = (Out_MaskA456_g251781).zw;
					half Bias502_g251781 = temp_output_504_0_g251781;
					half2 Normal502_g251781 = float2( 0,0 );
					half4 localSampleCoord502_g251781 = SampleCoord( Texture502_g251781 , Sampler502_g251781 , UV502_g251781 , Bias502_g251781 , Normal502_g251781 );
					float2 temp_output_406_397_g251762 = Normal502_g251781;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251781) = _MainNormalTex;
					SamplerState Sampler496_g251781 = staticSwitch37_g251778;
					float2 temp_output_463_0_g251781 = (Out_MaskB456_g251781).zw;
					half2 XZ496_g251781 = temp_output_463_0_g251781;
					half Bias496_g251781 = temp_output_504_0_g251781;
					float3 temp_output_483_0_g251781 = (Out_MaskK456_g251781).xyz;
					half3 NormalWS496_g251781 = temp_output_483_0_g251781;
					half3 Normal496_g251781 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251781 = SamplePlanar2D( Texture496_g251781 , Sampler496_g251781 , XZ496_g251781 , Bias496_g251781 , NormalWS496_g251781 , Normal496_g251781 );
					float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
					float3 worldToTangentDir408_g251781 = normalize( mul( ase_worldToTangent, Normal496_g251781 ) );
					float2 temp_output_406_375_g251762 = (worldToTangentDir408_g251781).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251781) = _MainNormalTex;
					SamplerState Sampler490_g251781 = staticSwitch37_g251778;
					float2 temp_output_462_0_g251781 = (Out_MaskB456_g251781).xy;
					half2 ZY490_g251781 = temp_output_462_0_g251781;
					half2 XZ490_g251781 = temp_output_463_0_g251781;
					float2 temp_output_464_0_g251781 = (Out_MaskC456_g251781).xy;
					half2 XY490_g251781 = temp_output_464_0_g251781;
					half Bias490_g251781 = temp_output_504_0_g251781;
					float3 temp_output_482_0_g251781 = (Out_MaskN456_g251781).xyz;
					half3 Triplanar490_g251781 = temp_output_482_0_g251781;
					half3 NormalWS490_g251781 = temp_output_483_0_g251781;
					half3 Normal490_g251781 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251781 = SamplePlanar3D( Texture490_g251781 , Sampler490_g251781 , ZY490_g251781 , XZ490_g251781 , XY490_g251781 , Bias490_g251781 , Triplanar490_g251781 , NormalWS490_g251781 , Normal490_g251781 );
					float3 worldToTangentDir399_g251781 = normalize( mul( ase_worldToTangent, Normal490_g251781 ) );
					float2 temp_output_406_353_g251762 = (worldToTangentDir399_g251781).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251781) = _MainNormalTex;
					SamplerState Sampler498_g251781 = staticSwitch37_g251778;
					half2 XZ498_g251781 = temp_output_463_0_g251781;
					float2 temp_output_473_0_g251781 = (Out_MaskE456_g251781).xy;
					half2 XZ_1498_g251781 = temp_output_473_0_g251781;
					float2 temp_output_474_0_g251781 = (Out_MaskE456_g251781).zw;
					half2 XZ_2498_g251781 = temp_output_474_0_g251781;
					float2 temp_output_475_0_g251781 = (Out_MaskF456_g251781).xy;
					half2 XZ_3498_g251781 = temp_output_475_0_g251781;
					float temp_output_510_0_g251781 = exp2( temp_output_504_0_g251781 );
					half Bias498_g251781 = temp_output_510_0_g251781;
					float3 temp_output_480_0_g251781 = (Out_MaskI456_g251781).xyz;
					half3 Weights_2498_g251781 = temp_output_480_0_g251781;
					half3 NormalWS498_g251781 = temp_output_483_0_g251781;
					half3 Normal498_g251781 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251781 = SampleStochastic2D( Texture498_g251781 , Sampler498_g251781 , XZ498_g251781 , XZ_1498_g251781 , XZ_2498_g251781 , XZ_3498_g251781 , Bias498_g251781 , Weights_2498_g251781 , NormalWS498_g251781 , Normal498_g251781 );
					float3 worldToTangentDir411_g251781 = normalize( mul( ase_worldToTangent, Normal498_g251781 ) );
					float2 temp_output_406_391_g251762 = (worldToTangentDir411_g251781).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251781) = _MainNormalTex;
					SamplerState Sampler500_g251781 = staticSwitch37_g251778;
					half2 ZY500_g251781 = temp_output_462_0_g251781;
					half2 ZY_1500_g251781 = (Out_MaskC456_g251781).zw;
					half2 ZY_2500_g251781 = (Out_MaskD456_g251781).xy;
					half2 ZY_3500_g251781 = (Out_MaskD456_g251781).zw;
					half2 XZ500_g251781 = temp_output_463_0_g251781;
					half2 XZ_1500_g251781 = temp_output_473_0_g251781;
					half2 XZ_2500_g251781 = temp_output_474_0_g251781;
					half2 XZ_3500_g251781 = temp_output_475_0_g251781;
					half2 XY500_g251781 = temp_output_464_0_g251781;
					half2 XY_1500_g251781 = (Out_MaskF456_g251781).zw;
					half2 XY_2500_g251781 = (Out_MaskG456_g251781).xy;
					half2 XY_3500_g251781 = (Out_MaskG456_g251781).zw;
					half Bias500_g251781 = temp_output_510_0_g251781;
					half3 Weights_1500_g251781 = (Out_MaskH456_g251781).xyz;
					half3 Weights_2500_g251781 = temp_output_480_0_g251781;
					half3 Weights_3500_g251781 = (Out_MaskJ456_g251781).xyz;
					half3 Triplanar500_g251781 = temp_output_482_0_g251781;
					half3 NormalWS500_g251781 = temp_output_483_0_g251781;
					half3 Normal500_g251781 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251781 = SampleStochastic3D( Texture500_g251781 , Sampler500_g251781 , ZY500_g251781 , ZY_1500_g251781 , ZY_2500_g251781 , ZY_3500_g251781 , XZ500_g251781 , XZ_1500_g251781 , XZ_2500_g251781 , XZ_3500_g251781 , XY500_g251781 , XY_1500_g251781 , XY_2500_g251781 , XY_3500_g251781 , Bias500_g251781 , Weights_1500_g251781 , Weights_2500_g251781 , Weights_3500_g251781 , Triplanar500_g251781 , NormalWS500_g251781 , Normal500_g251781 );
					float3 worldToTangentDir403_g251781 = normalize( mul( ase_worldToTangent, Normal500_g251781 ) );
					float2 temp_output_406_390_g251762 = (worldToTangentDir403_g251781).xy;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g251762 = temp_output_406_394_g251762;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g251762 = temp_output_406_397_g251762;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g251762 = temp_output_406_375_g251762;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g251762 = temp_output_406_353_g251762;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g251762 = temp_output_406_391_g251762;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g251762 = temp_output_406_390_g251762;
					#else
					float2 staticSwitch193_g251762 = temp_output_406_394_g251762;
					#endif
					half2 Local_NormaSample191_g251762 = staticSwitch193_g251762;
					half2 Local_NormalTS108_g251762 = ( Local_NormaSample191_g251762 * _MainNormalValue );
					float2 In_NormalTS3_g251763 = Local_NormalTS108_g251762;
					float3 appendResult68_g251774 = (float3(Local_NormalTS108_g251762 , 1.0));
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal74_g251774 = appendResult68_g251774;
					float3 worldNormal74_g251774 = normalize( float3( dot( tanToWorld0, tanNormal74_g251774 ), dot( tanToWorld1, tanNormal74_g251774 ), dot( tanToWorld2, tanNormal74_g251774 ) ) );
					half3 Local_NormalWS250_g251762 = worldNormal74_g251774;
					float3 In_NormalWS3_g251763 = Local_NormalWS250_g251762;
					float4 In_Shader3_g251763 = Local_Masks109_g251762;
					float4 In_Feature3_g251763 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251763 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251763 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g251771 = Local_Albedo139_g251762;
					float dotResult20_g251771 = dot( temp_output_3_0_g251771 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g251762 = dotResult20_g251771;
					float temp_output_12_0_g251763 = Local_Grayscale110_g251762;
					float In_Grayscale3_g251763 = temp_output_12_0_g251763;
					float clampResult27_g251773 = clamp( saturate( ( Local_Grayscale110_g251762 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g251762 = clampResult27_g251773;
					float temp_output_16_0_g251763 = Local_Luminosity145_g251762;
					float In_Luminosity3_g251763 = temp_output_16_0_g251763;
					float In_MultiMask3_g251763 = Local_MultiMask78_g251762;
					float temp_output_187_0_g251762 = (Local_AlbedoSample185_g251762).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g251762 = ( temp_output_187_0_g251762 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g251762 = temp_output_187_0_g251762;
					#endif
					half Local_AlphaClip111_g251762 = staticSwitch236_g251762;
					float In_AlphaClip3_g251763 = Local_AlphaClip111_g251762;
					half Local_AlphaFade246_g251762 = (lerpResult62_g251762).a;
					float In_AlphaFade3_g251763 = Local_AlphaFade246_g251762;
					float3 temp_cast_26 = (1.0).xxx;
					float3 In_Translucency3_g251763 = temp_cast_26;
					float In_Transmission3_g251763 = 1.0;
					float In_Thickness3_g251763 = 0.0;
					float In_Diffusion3_g251763 = 0.0;
					float In_Depth3_g251763 = 0.0;
					BuildVisualData( Data3_g251763 , In_Dummy3_g251763 , In_Albedo3_g251763 , In_AlbedoBase3_g251763 , In_NormalTS3_g251763 , In_NormalWS3_g251763 , In_Shader3_g251763 , In_Feature3_g251763 , In_Season3_g251763 , In_Emissive3_g251763 , In_Grayscale3_g251763 , In_Luminosity3_g251763 , In_MultiMask3_g251763 , In_AlphaClip3_g251763 , In_AlphaFade3_g251763 , In_Translucency3_g251763 , In_Transmission3_g251763 , In_Thickness3_g251763 , In_Diffusion3_g251763 , In_Depth3_g251763 );
					TVEVisualData Data4_g251789 =(TVEVisualData)Data3_g251763;
					float Out_Dummy4_g251789 = 0.0;
					float3 Out_Albedo4_g251789 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251789 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251789 = float2( 0,0 );
					float3 Out_NormalWS4_g251789 = float3( 0,0,0 );
					float4 Out_Shader4_g251789 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251789 = float4( 0,0,0,0 );
					float4 Out_Season4_g251789 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251789 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251789 = 0.0;
					float Out_Grayscale4_g251789 = 0.0;
					float Out_Luminosity4_g251789 = 0.0;
					float Out_AlphaClip4_g251789 = 0.0;
					float Out_AlphaFade4_g251789 = 0.0;
					float3 Out_Translucency4_g251789 = float3( 0,0,0 );
					float Out_Transmission4_g251789 = 0.0;
					float Out_Thickness4_g251789 = 0.0;
					float Out_Diffusion4_g251789 = 0.0;
					float Out_Depth4_g251789 = 0.0;
					BreakVisualData( Data4_g251789 , Out_Dummy4_g251789 , Out_Albedo4_g251789 , Out_AlbedoBase4_g251789 , Out_NormalTS4_g251789 , Out_NormalWS4_g251789 , Out_Shader4_g251789 , Out_Feature4_g251789 , Out_Season4_g251789 , Out_Emissive4_g251789 , Out_MultiMask4_g251789 , Out_Grayscale4_g251789 , Out_Luminosity4_g251789 , Out_AlphaClip4_g251789 , Out_AlphaFade4_g251789 , Out_Translucency4_g251789 , Out_Transmission4_g251789 , Out_Thickness4_g251789 , Out_Diffusion4_g251789 , Out_Depth4_g251789 );
					float Alpha109_g251784 = Out_AlphaClip4_g251789;
					float lerpResult91_g251784 = lerp( 1.0 , Alpha109_g251784 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g251784 = lerp( 1.0 , lerpResult91_g251784 , Filter152_g251784);
					clip( lerpResult154_g251784 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2587_114;
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

					o.Emission = ( lerpResult72_g251784 * lerpResult84_g251784 );
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

				uniform half TVE_DEBUG_Index;
				uniform half TVE_DEBUG_Clip;
				uniform half TVE_DEBUG_Min;
				uniform half TVE_DEBUG_Max;
				uniform half TVE_DEBUG_Shading;
				uniform half _IsTVEShader;
				uniform half TVE_DEBUG_Filter;
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

					float localIfModelDataByShader26_g251487 = ( 0.0 );
					TVEModelData Data26_g251487 = (TVEModelData)0;
					TVEModelData Data16_g251476 =(TVEModelData)0;
					half Dummy207_g251466 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g251476 = Dummy207_g251466;
					float In_Dummy16_g251476 = temp_output_14_0_g251476;
					float3 PositionOS131_g251466 = v.vertex.xyz;
					float3 temp_output_4_0_g251476 = PositionOS131_g251466;
					float3 In_PositionOS16_g251476 = temp_output_4_0_g251476;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g251466 = ase_positionWS;
					float3 vertexToFrag73_g251466 = temp_output_104_7_g251466;
					float3 PositionWS122_g251466 = vertexToFrag73_g251466;
					float3 In_PositionWS16_g251476 = PositionWS122_g251466;
					float4x4 break19_g251469 = unity_ObjectToWorld;
					float3 appendResult20_g251469 = (float3(break19_g251469[ 0 ][ 3 ] , break19_g251469[ 1 ][ 3 ] , break19_g251469[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251466 = appendResult20_g251469;
					float4x4 break19_g251471 = unity_ObjectToWorld;
					float3 appendResult20_g251471 = (float3(break19_g251471[ 0 ][ 3 ] , break19_g251471[ 1 ][ 3 ] , break19_g251471[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g251467 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g251466 = PositionOS131_g251466;
					float3 appendResult234_g251466 = (float3(break233_g251466.x , 0.0 , break233_g251466.z));
					float3 break413_g251466 = PositionOS131_g251466;
					float3 appendResult414_g251466 = (float3(break413_g251466.x , break413_g251466.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251473 = appendResult414_g251466;
					#else
					float3 staticSwitch65_g251473 = appendResult234_g251466;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g251466 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g251466 = appendResult60_g251467;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g251466 = staticSwitch65_g251473;
					#else
					float3 staticSwitch229_g251466 = _Vector0;
					#endif
					float3 PivotOS149_g251466 = staticSwitch229_g251466;
					float3 temp_output_122_0_g251471 = PivotOS149_g251466;
					float3 PivotsOnlyWS105_g251471 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g251471 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g251466 = ( appendResult20_g251471 + PivotsOnlyWS105_g251471 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g251466 = temp_output_340_7_g251466;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g251466 = temp_output_341_7_g251466;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g251466 = temp_output_341_7_g251466;
					#else
					float3 staticSwitch236_g251466 = temp_output_340_7_g251466;
					#endif
					float3 vertexToFrag76_g251466 = staticSwitch236_g251466;
					float3 PivotWS121_g251466 = vertexToFrag76_g251466;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251466 = ( PositionWS122_g251466 - PivotWS121_g251466 );
					#else
					float3 staticSwitch204_g251466 = PositionWS122_g251466;
					#endif
					float3 PositionWO132_g251466 = ( staticSwitch204_g251466 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251476 = PositionWO132_g251466;
					float3 In_PositionRawOS16_g251476 = PositionOS131_g251466;
					float3 In_PivotOS16_g251476 = PivotOS149_g251466;
					float3 In_PivotWS16_g251476 = PivotWS121_g251466;
					float3 PivotWO133_g251466 = ( PivotWS121_g251466 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251476 = PivotWO133_g251466;
					half3 NormalOS134_g251466 = v.normal;
					float3 temp_output_21_0_g251476 = NormalOS134_g251466;
					float3 In_NormalOS16_g251476 = temp_output_21_0_g251476;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g251466 = normalizedWorldNormal;
					float3 In_NormalWS16_g251476 = NormalWS95_g251466;
					float3 In_NormalRawOS16_g251476 = NormalOS134_g251466;
					half4 TangentlOS153_g251466 = v.tangent;
					float4 temp_output_6_0_g251476 = TangentlOS153_g251466;
					float4 In_TangentOS16_g251476 = temp_output_6_0_g251476;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g251466 = ase_tangentWS;
					float3 In_TangentWS16_g251476 = TangentWS136_g251466;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g251466 = ase_bitangentWS;
					float3 In_BitangentWS16_g251476 = BiangentWS421_g251466;
					float3 normalizeResult296_g251466 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251466 ) );
					half3 ViewDirWS169_g251466 = normalizeResult296_g251466;
					float3 In_ViewDirWS16_g251476 = ViewDirWS169_g251466;
					float4 appendResult397_g251466 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g251466 = appendResult397_g251466;
					float4 In_CoordsData16_g251476 = CoordsData398_g251466;
					half4 VertexMasks171_g251466 = v.ase_color;
					float4 In_VertexData16_g251476 = VertexMasks171_g251466;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251479 = (PositionOS131_g251466).z;
					#else
					float staticSwitch65_g251479 = (PositionOS131_g251466).y;
					#endif
					half Object_HeightValue267_g251466 = _ObjectHeightValue;
					half Bounds_HeightMask274_g251466 = saturate( ( staticSwitch65_g251479 / Object_HeightValue267_g251466 ) );
					half3 Position387_g251466 = PositionOS131_g251466;
					half Height387_g251466 = Object_HeightValue267_g251466;
					half Object_RadiusValue268_g251466 = _ObjectRadiusValue;
					half Radius387_g251466 = Object_RadiusValue268_g251466;
					half localCapsuleMaskYUp387_g251466 = CapsuleMaskYUp( Position387_g251466 , Height387_g251466 , Radius387_g251466 );
					half3 Position408_g251466 = PositionOS131_g251466;
					half Height408_g251466 = Object_HeightValue267_g251466;
					half Radius408_g251466 = Object_RadiusValue268_g251466;
					half localCapsuleMaskZUp408_g251466 = CapsuleMaskZUp( Position408_g251466 , Height408_g251466 , Radius408_g251466 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251484 = saturate( localCapsuleMaskZUp408_g251466 );
					#else
					float staticSwitch65_g251484 = saturate( localCapsuleMaskYUp387_g251466 );
					#endif
					half Bounds_SphereMask282_g251466 = staticSwitch65_g251484;
					float4 appendResult253_g251466 = (float4(Bounds_HeightMask274_g251466 , Bounds_SphereMask282_g251466 , 1.0 , 1.0));
					half4 MasksData254_g251466 = appendResult253_g251466;
					float4 In_MasksData16_g251476 = MasksData254_g251466;
					float temp_output_17_0_g251478 = _ObjectPhaseMode;
					float Option70_g251478 = temp_output_17_0_g251478;
					float4 temp_output_3_0_g251478 = v.ase_color;
					float4 Channel70_g251478 = temp_output_3_0_g251478;
					float localSwitchChannel470_g251478 = SwitchChannel4( Option70_g251478 , Channel70_g251478 );
					half Phase_Value372_g251466 = localSwitchChannel470_g251478;
					float3 break319_g251466 = PivotWO133_g251466;
					half Pivot_Position322_g251466 = ( break319_g251466.x + break319_g251466.z );
					half Phase_Position357_g251466 = ( Phase_Value372_g251466 + Pivot_Position322_g251466 );
					float temp_output_248_0_g251466 = frac( Phase_Position357_g251466 );
					float4 appendResult177_g251466 = (float4(( (frac( ( Phase_Position357_g251466 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g251466));
					half4 Phase_Data176_g251466 = appendResult177_g251466;
					float4 In_PhaseData16_g251476 = Phase_Data176_g251466;
					float4 In_TransformData16_g251476 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251476 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g251476 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g251476 , In_Dummy16_g251476 , In_PositionOS16_g251476 , In_PositionWS16_g251476 , In_PositionWO16_g251476 , In_PositionRawOS16_g251476 , In_PivotOS16_g251476 , In_PivotWS16_g251476 , In_PivotWO16_g251476 , In_NormalOS16_g251476 , In_NormalWS16_g251476 , In_NormalRawOS16_g251476 , In_TangentOS16_g251476 , In_TangentWS16_g251476 , In_BitangentWS16_g251476 , In_ViewDirWS16_g251476 , In_CoordsData16_g251476 , In_VertexData16_g251476 , In_MasksData16_g251476 , In_PhaseData16_g251476 , In_TransformData16_g251476 , In_RotationData16_g251476 , In_InterpolatorA16_g251476 );
					TVEModelData DataDefault26_g251487 = Data16_g251476;
					TVEModelData DataGeneral26_g251487 = Data16_g251476;
					TVEModelData DataBlanket26_g251487 = Data16_g251476;
					TVEModelData DataImpostor26_g251487 = Data16_g251476;
					TVEModelData Data16_g251456 =(TVEModelData)0;
					half Dummy207_g251446 = 0.0;
					float temp_output_14_0_g251456 = Dummy207_g251446;
					float In_Dummy16_g251456 = temp_output_14_0_g251456;
					float3 PositionOS131_g251446 = v.vertex.xyz;
					float3 temp_output_4_0_g251456 = PositionOS131_g251446;
					float3 In_PositionOS16_g251456 = temp_output_4_0_g251456;
					float3 temp_output_104_7_g251446 = ase_positionWS;
					float3 PositionWS122_g251446 = temp_output_104_7_g251446;
					float3 In_PositionWS16_g251456 = PositionWS122_g251446;
					float4x4 break19_g251449 = unity_ObjectToWorld;
					float3 appendResult20_g251449 = (float3(break19_g251449[ 0 ][ 3 ] , break19_g251449[ 1 ][ 3 ] , break19_g251449[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251446 = appendResult20_g251449;
					float3 PivotWS121_g251446 = temp_output_340_7_g251446;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251446 = ( PositionWS122_g251446 - PivotWS121_g251446 );
					#else
					float3 staticSwitch204_g251446 = PositionWS122_g251446;
					#endif
					float3 PositionWO132_g251446 = ( staticSwitch204_g251446 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251456 = PositionWO132_g251446;
					float3 In_PositionRawOS16_g251456 = PositionOS131_g251446;
					float3 PivotOS149_g251446 = _Vector0;
					float3 In_PivotOS16_g251456 = PivotOS149_g251446;
					float3 In_PivotWS16_g251456 = PivotWS121_g251446;
					float3 PivotWO133_g251446 = ( PivotWS121_g251446 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251456 = PivotWO133_g251446;
					half3 NormalOS134_g251446 = v.normal;
					float3 temp_output_21_0_g251456 = NormalOS134_g251446;
					float3 In_NormalOS16_g251456 = temp_output_21_0_g251456;
					half3 NormalWS95_g251446 = normalizedWorldNormal;
					float3 In_NormalWS16_g251456 = NormalWS95_g251446;
					float3 In_NormalRawOS16_g251456 = NormalOS134_g251446;
					half4 TangentlOS153_g251446 = v.tangent;
					float4 temp_output_6_0_g251456 = TangentlOS153_g251446;
					float4 In_TangentOS16_g251456 = temp_output_6_0_g251456;
					half3 TangentWS136_g251446 = ase_tangentWS;
					float3 In_TangentWS16_g251456 = TangentWS136_g251446;
					half3 BiangentWS421_g251446 = ase_bitangentWS;
					float3 In_BitangentWS16_g251456 = BiangentWS421_g251446;
					float3 normalizeResult296_g251446 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251446 ) );
					half3 ViewDirWS169_g251446 = normalizeResult296_g251446;
					float3 In_ViewDirWS16_g251456 = ViewDirWS169_g251446;
					float4 appendResult397_g251446 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g251446 = appendResult397_g251446;
					float4 In_CoordsData16_g251456 = CoordsData398_g251446;
					half4 VertexMasks171_g251446 = float4( 0,0,0,0 );
					float4 In_VertexData16_g251456 = VertexMasks171_g251446;
					half4 MasksData254_g251446 = float4( 0,0,0,0 );
					float4 In_MasksData16_g251456 = MasksData254_g251446;
					half4 Phase_Data176_g251446 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g251456 = Phase_Data176_g251446;
					float4 In_TransformData16_g251456 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251456 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g251456 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g251456 , In_Dummy16_g251456 , In_PositionOS16_g251456 , In_PositionWS16_g251456 , In_PositionWO16_g251456 , In_PositionRawOS16_g251456 , In_PivotOS16_g251456 , In_PivotWS16_g251456 , In_PivotWO16_g251456 , In_NormalOS16_g251456 , In_NormalWS16_g251456 , In_NormalRawOS16_g251456 , In_TangentOS16_g251456 , In_TangentWS16_g251456 , In_BitangentWS16_g251456 , In_ViewDirWS16_g251456 , In_CoordsData16_g251456 , In_VertexData16_g251456 , In_MasksData16_g251456 , In_PhaseData16_g251456 , In_TransformData16_g251456 , In_RotationData16_g251456 , In_InterpolatorA16_g251456 );
					TVEModelData DataTerrain26_g251487 = Data16_g251456;
					half IsShaderType2544 = _IsShaderType;
					float Type26_g251487 = IsShaderType2544;
					{
					if (Type26_g251487 == 0 )
					{
					Data26_g251487 = DataDefault26_g251487;
					}
					else if (Type26_g251487 == 1 )
					{
					Data26_g251487 = DataGeneral26_g251487;
					}
					else if (Type26_g251487 == 2 )
					{
					Data26_g251487 = DataBlanket26_g251487;
					}
					else if (Type26_g251487 == 3 )
					{
					Data26_g251487 = DataImpostor26_g251487;
					}
					else if (Type26_g251487 == 4 )
					{
					Data26_g251487 = DataTerrain26_g251487;
					}
					}
					TVEModelData Data15_g251646 =(TVEModelData)Data26_g251487;
					float Out_Dummy15_g251646 = 0.0;
					float3 Out_PositionOS15_g251646 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251646 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251646 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251646 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251646 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251646 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251646 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251646 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251646 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251646 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251646 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251646 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251646 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251646 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251646 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251646 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251646 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251646 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251646 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251646 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251646 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251646 , Out_Dummy15_g251646 , Out_PositionOS15_g251646 , Out_PositionWS15_g251646 , Out_PositionWO15_g251646 , Out_PositionRawOS15_g251646 , Out_PivotOS15_g251646 , Out_PivotWS15_g251646 , Out_PivotWO15_g251646 , Out_NormalOS15_g251646 , Out_NormalWS15_g251646 , Out_NormalRawOS15_g251646 , Out_TangentOS15_g251646 , Out_TangentWS15_g251646 , Out_BitangentWS15_g251646 , Out_ViewDirWS15_g251646 , Out_CoordsData15_g251646 , Out_VertexData15_g251646 , Out_MasksData15_g251646 , Out_PhaseData15_g251646 , Out_TransformData15_g251646 , Out_RotationData15_g251646 , Out_InterpolatorA15_g251646 );
					TVEModelData Data16_g251648 =(TVEModelData)Data15_g251646;
					float temp_output_14_0_g251648 = 0.0;
					float In_Dummy16_g251648 = temp_output_14_0_g251648;
					float3 temp_output_219_24_g251645 = Out_PivotOS15_g251646;
					float3 temp_output_215_0_g251645 = ( Out_PositionOS15_g251646 - temp_output_219_24_g251645 );
					float3 temp_output_4_0_g251648 = temp_output_215_0_g251645;
					float3 In_PositionOS16_g251648 = temp_output_4_0_g251648;
					float3 In_PositionWS16_g251648 = Out_PositionWS15_g251646;
					float3 In_PositionWO16_g251648 = Out_PositionWO15_g251646;
					float3 In_PositionRawOS16_g251648 = Out_PositionRawOS15_g251646;
					float3 In_PivotOS16_g251648 = temp_output_219_24_g251645;
					float3 In_PivotWS16_g251648 = Out_PivotWS15_g251646;
					float3 In_PivotWO16_g251648 = Out_PivotWO15_g251646;
					float3 temp_output_21_0_g251648 = Out_NormalOS15_g251646;
					float3 In_NormalOS16_g251648 = temp_output_21_0_g251648;
					float3 In_NormalWS16_g251648 = Out_NormalWS15_g251646;
					float3 In_NormalRawOS16_g251648 = Out_NormalRawOS15_g251646;
					float4 temp_output_6_0_g251648 = Out_TangentOS15_g251646;
					float4 In_TangentOS16_g251648 = temp_output_6_0_g251648;
					float3 In_TangentWS16_g251648 = Out_TangentWS15_g251646;
					float3 In_BitangentWS16_g251648 = Out_BitangentWS15_g251646;
					float3 In_ViewDirWS16_g251648 = Out_ViewDirWS15_g251646;
					float4 In_CoordsData16_g251648 = Out_CoordsData15_g251646;
					float4 In_VertexData16_g251648 = Out_VertexData15_g251646;
					float4 In_MasksData16_g251648 = Out_MasksData15_g251646;
					float4 In_PhaseData16_g251648 = Out_PhaseData15_g251646;
					float4 In_TransformData16_g251648 = Out_TransformData15_g251646;
					float4 In_RotationData16_g251648 = Out_RotationData15_g251646;
					float4 In_InterpolatorA16_g251648 = Out_InterpolatorA15_g251646;
					BuildModelVertData( Data16_g251648 , In_Dummy16_g251648 , In_PositionOS16_g251648 , In_PositionWS16_g251648 , In_PositionWO16_g251648 , In_PositionRawOS16_g251648 , In_PivotOS16_g251648 , In_PivotWS16_g251648 , In_PivotWO16_g251648 , In_NormalOS16_g251648 , In_NormalWS16_g251648 , In_NormalRawOS16_g251648 , In_TangentOS16_g251648 , In_TangentWS16_g251648 , In_BitangentWS16_g251648 , In_ViewDirWS16_g251648 , In_CoordsData16_g251648 , In_VertexData16_g251648 , In_MasksData16_g251648 , In_PhaseData16_g251648 , In_TransformData16_g251648 , In_RotationData16_g251648 , In_InterpolatorA16_g251648 );
					TVEModelData Data15_g251650 =(TVEModelData)Data16_g251648;
					float Out_Dummy15_g251650 = 0.0;
					float3 Out_PositionOS15_g251650 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251650 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251650 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251650 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251650 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251650 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251650 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251650 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251650 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251650 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251650 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251650 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251650 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251650 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251650 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251650 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251650 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251650 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251650 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251650 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251650 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251650 , Out_Dummy15_g251650 , Out_PositionOS15_g251650 , Out_PositionWS15_g251650 , Out_PositionWO15_g251650 , Out_PositionRawOS15_g251650 , Out_PivotOS15_g251650 , Out_PivotWS15_g251650 , Out_PivotWO15_g251650 , Out_NormalOS15_g251650 , Out_NormalWS15_g251650 , Out_NormalRawOS15_g251650 , Out_TangentOS15_g251650 , Out_TangentWS15_g251650 , Out_BitangentWS15_g251650 , Out_ViewDirWS15_g251650 , Out_CoordsData15_g251650 , Out_VertexData15_g251650 , Out_MasksData15_g251650 , Out_PhaseData15_g251650 , Out_TransformData15_g251650 , Out_RotationData15_g251650 , Out_InterpolatorA15_g251650 );
					TVEModelData Data16_g251651 =(TVEModelData)Data15_g251650;
					half Dummy317_g251649 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g251651 = Dummy317_g251649;
					float In_Dummy16_g251651 = temp_output_14_0_g251651;
					float3 temp_output_4_0_g251651 = Out_PositionOS15_g251650;
					float3 In_PositionOS16_g251651 = temp_output_4_0_g251651;
					float3 In_PositionWS16_g251651 = Out_PositionWS15_g251650;
					float3 temp_output_314_17_g251649 = Out_PositionWO15_g251650;
					float3 In_PositionWO16_g251651 = temp_output_314_17_g251649;
					float3 In_PositionRawOS16_g251651 = Out_PositionRawOS15_g251650;
					float3 In_PivotOS16_g251651 = Out_PivotOS15_g251650;
					float3 In_PivotWS16_g251651 = Out_PivotWS15_g251650;
					float3 temp_output_314_19_g251649 = Out_PivotWO15_g251650;
					float3 In_PivotWO16_g251651 = temp_output_314_19_g251649;
					float3 temp_output_21_0_g251651 = Out_NormalOS15_g251650;
					float3 In_NormalOS16_g251651 = temp_output_21_0_g251651;
					float3 In_NormalWS16_g251651 = Out_NormalWS15_g251650;
					float3 In_NormalRawOS16_g251651 = Out_NormalRawOS15_g251650;
					float4 temp_output_6_0_g251651 = Out_TangentOS15_g251650;
					float4 In_TangentOS16_g251651 = temp_output_6_0_g251651;
					float3 In_TangentWS16_g251651 = Out_TangentWS15_g251650;
					float3 In_BitangentWS16_g251651 = Out_BitangentWS15_g251650;
					float3 In_ViewDirWS16_g251651 = Out_ViewDirWS15_g251650;
					float4 In_CoordsData16_g251651 = Out_CoordsData15_g251650;
					float4 temp_output_314_29_g251649 = Out_VertexData15_g251650;
					float4 In_VertexData16_g251651 = temp_output_314_29_g251649;
					float4 In_MasksData16_g251651 = Out_MasksData15_g251650;
					float4 In_PhaseData16_g251651 = Out_PhaseData15_g251650;
					half4 Model_TransformData356_g251649 = Out_TransformData15_g251650;
					float localBuildGlobalData204_g251489 = ( 0.0 );
					TVEGlobalData Data204_g251489 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251489 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251489 = Dummy211_g251489;
					float4 temp_output_589_164_g251489 = TVE_CoatParams;
					half4 Coat_Params596_g251489 = temp_output_589_164_g251489;
					float4 In_CoatParams204_g251489 = Coat_Params596_g251489;
					float4 temp_output_203_0_g251509 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g251486 = ( 0.0 );
					TVEModelData Data26_g251486 = (TVEModelData)0;
					TVEModelData Data16_g251474 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g251474 = 0.0;
					float3 In_PositionWS16_g251474 = PositionWS122_g251466;
					float3 In_PositionWO16_g251474 = PositionWO132_g251466;
					float3 In_PivotWS16_g251474 = PivotWS121_g251466;
					float3 In_PivotWO16_g251474 = PivotWO133_g251466;
					float3 In_NormalWS16_g251474 = NormalWS95_g251466;
					float3 In_TangentWS16_g251474 = TangentWS136_g251466;
					float3 In_BitangentWS16_g251474 = BiangentWS421_g251466;
					half3 NormalWS427_g251466 = NormalWS95_g251466;
					half3 localComputeTriplanarWeights427_g251466 = ComputeTriplanarWeights( NormalWS427_g251466 );
					half3 TriplanarWeights429_g251466 = localComputeTriplanarWeights427_g251466;
					float3 In_TriplanarWeights16_g251474 = TriplanarWeights429_g251466;
					float3 In_ViewDirWS16_g251474 = ViewDirWS169_g251466;
					float4 In_CoordsData16_g251474 = CoordsData398_g251466;
					float4 In_VertexData16_g251474 = VertexMasks171_g251466;
					float4 In_PhaseData16_g251474 = Phase_Data176_g251466;
					BuildModelFragData( Data16_g251474 , In_Dummy16_g251474 , In_PositionWS16_g251474 , In_PositionWO16_g251474 , In_PivotWS16_g251474 , In_PivotWO16_g251474 , In_NormalWS16_g251474 , In_TangentWS16_g251474 , In_BitangentWS16_g251474 , In_TriplanarWeights16_g251474 , In_ViewDirWS16_g251474 , In_CoordsData16_g251474 , In_VertexData16_g251474 , In_PhaseData16_g251474 );
					TVEModelData DataDefault26_g251486 = Data16_g251474;
					TVEModelData DataGeneral26_g251486 = Data16_g251474;
					TVEModelData DataBlanket26_g251486 = Data16_g251474;
					TVEModelData DataImpostor26_g251486 = Data16_g251474;
					TVEModelData Data16_g251454 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g251454 = 0.0;
					float3 In_PositionWS16_g251454 = PositionWS122_g251446;
					float3 In_PositionWO16_g251454 = PositionWO132_g251446;
					float3 In_PivotWS16_g251454 = PivotWS121_g251446;
					float3 In_PivotWO16_g251454 = PivotWO133_g251446;
					float3 In_NormalWS16_g251454 = NormalWS95_g251446;
					float3 In_TangentWS16_g251454 = TangentWS136_g251446;
					float3 In_BitangentWS16_g251454 = BiangentWS421_g251446;
					half3 NormalWS427_g251446 = NormalWS95_g251446;
					half3 localComputeTriplanarWeights427_g251446 = ComputeTriplanarWeights( NormalWS427_g251446 );
					half3 TriplanarWeights429_g251446 = localComputeTriplanarWeights427_g251446;
					float3 In_TriplanarWeights16_g251454 = TriplanarWeights429_g251446;
					float3 In_ViewDirWS16_g251454 = ViewDirWS169_g251446;
					float4 In_CoordsData16_g251454 = CoordsData398_g251446;
					float4 In_VertexData16_g251454 = VertexMasks171_g251446;
					float4 In_PhaseData16_g251454 = Phase_Data176_g251446;
					BuildModelFragData( Data16_g251454 , In_Dummy16_g251454 , In_PositionWS16_g251454 , In_PositionWO16_g251454 , In_PivotWS16_g251454 , In_PivotWO16_g251454 , In_NormalWS16_g251454 , In_TangentWS16_g251454 , In_BitangentWS16_g251454 , In_TriplanarWeights16_g251454 , In_ViewDirWS16_g251454 , In_CoordsData16_g251454 , In_VertexData16_g251454 , In_PhaseData16_g251454 );
					TVEModelData DataTerrain26_g251486 = Data16_g251454;
					float Type26_g251486 = IsShaderType2544;
					{
					if (Type26_g251486 == 0 )
					{
					Data26_g251486 = DataDefault26_g251486;
					}
					else if (Type26_g251486 == 1 )
					{
					Data26_g251486 = DataGeneral26_g251486;
					}
					else if (Type26_g251486 == 2 )
					{
					Data26_g251486 = DataBlanket26_g251486;
					}
					else if (Type26_g251486 == 3 )
					{
					Data26_g251486 = DataImpostor26_g251486;
					}
					else if (Type26_g251486 == 4 )
					{
					Data26_g251486 = DataTerrain26_g251486;
					}
					}
					TVEModelData Data15_g251565 =(TVEModelData)Data26_g251486;
					float Out_Dummy15_g251565 = 0.0;
					float3 Out_PositionWS15_g251565 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251565 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251565 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251565 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251565 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251565 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251565 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251565 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251565 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251565 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251565 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251565 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251565 , Out_Dummy15_g251565 , Out_PositionWS15_g251565 , Out_PositionWO15_g251565 , Out_PivotWS15_g251565 , Out_PivotWO15_g251565 , Out_NormalWS15_g251565 , Out_TangentWS15_g251565 , Out_BitangentWS15_g251565 , Out_TriplanarWeights15_g251565 , Out_ViewDirWS15_g251565 , Out_CoordsData15_g251565 , Out_VertexData15_g251565 , Out_PhaseData15_g251565 );
					float3 Model_PositionWS497_g251489 = Out_PositionWS15_g251565;
					float2 Model_PositionWS_XZ143_g251489 = (Model_PositionWS497_g251489).xz;
					float3 Model_PivotWS498_g251489 = Out_PivotWS15_g251565;
					float2 Model_PivotWS_XZ145_g251489 = (Model_PivotWS498_g251489).xz;
					float2 lerpResult300_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251509 = lerpResult300_g251489;
					float temp_output_82_0_g251507 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251509 = temp_output_82_0_g251507;
					float4 tex2DArrayNode83_g251509 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251509).zw + ( (temp_output_203_0_g251509).xy * temp_output_81_0_g251509 ) ),temp_output_82_0_g251509), 0.0 );
					float4 appendResult210_g251509 = (float4(tex2DArrayNode83_g251509.rgb , saturate( tex2DArrayNode83_g251509.a )));
					float4 temp_output_204_0_g251509 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251509 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251509).zw + ( (temp_output_204_0_g251509).xy * temp_output_81_0_g251509 ) ),temp_output_82_0_g251509), 0.0 );
					float4 appendResult212_g251509 = (float4(tex2DArrayNode122_g251509.rgb , saturate( tex2DArrayNode122_g251509.a )));
					float4 TVE_RenderNearPositionR628_g251489 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251489 = saturate( ( distance( Model_PositionWS497_g251489 , (TVE_RenderNearPositionR628_g251489).xyz ) / (TVE_RenderNearPositionR628_g251489).w ) );
					float temp_output_7_0_g251490 = 1.0;
					float temp_output_9_0_g251490 = ( temp_output_507_0_g251489 - temp_output_7_0_g251490 );
					half TVE_RenderNearFadeValue635_g251489 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251489 = saturate( ( temp_output_9_0_g251490 / ( ( TVE_RenderNearFadeValue635_g251489 - temp_output_7_0_g251490 ) + 0.0001 ) ) );
					float4 lerpResult131_g251509 = lerp( appendResult210_g251509 , appendResult212_g251509 , Global_TexBlend509_g251489);
					float4 temp_output_159_109_g251507 = lerpResult131_g251509;
					float4 lerpResult168_g251507 = lerp( TVE_CoatParams , temp_output_159_109_g251507 , TVE_CoatLayers[(int)temp_output_82_0_g251507]);
					float4 temp_output_589_109_g251489 = lerpResult168_g251507;
					half4 Coat_Texture302_g251489 = temp_output_589_109_g251489;
					float4 In_CoatTexture204_g251489 = Coat_Texture302_g251489;
					float4 temp_output_595_164_g251489 = TVE_PaintParams;
					half4 Paint_Params575_g251489 = temp_output_595_164_g251489;
					float4 In_PaintParams204_g251489 = Paint_Params575_g251489;
					float4 temp_output_203_0_g251558 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251558 = lerpResult85_g251489;
					float temp_output_82_0_g251555 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251558 = temp_output_82_0_g251555;
					float4 tex2DArrayNode83_g251558 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251558).zw + ( (temp_output_203_0_g251558).xy * temp_output_81_0_g251558 ) ),temp_output_82_0_g251558), 0.0 );
					float4 appendResult210_g251558 = (float4(tex2DArrayNode83_g251558.rgb , saturate( tex2DArrayNode83_g251558.a )));
					float4 temp_output_204_0_g251558 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251558 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251558).zw + ( (temp_output_204_0_g251558).xy * temp_output_81_0_g251558 ) ),temp_output_82_0_g251558), 0.0 );
					float4 appendResult212_g251558 = (float4(tex2DArrayNode122_g251558.rgb , saturate( tex2DArrayNode122_g251558.a )));
					float4 lerpResult131_g251558 = lerp( appendResult210_g251558 , appendResult212_g251558 , Global_TexBlend509_g251489);
					float4 temp_output_171_109_g251555 = lerpResult131_g251558;
					float4 lerpResult174_g251555 = lerp( TVE_PaintParams , temp_output_171_109_g251555 , TVE_PaintLayers[(int)temp_output_82_0_g251555]);
					float4 temp_output_595_109_g251489 = lerpResult174_g251555;
					half4 Paint_Texture71_g251489 = temp_output_595_109_g251489;
					float4 In_PaintTexture204_g251489 = Paint_Texture71_g251489;
					float4 temp_output_590_141_g251489 = TVE_AtmoParams;
					half4 Atmo_Params601_g251489 = temp_output_590_141_g251489;
					float4 In_AtmoParams204_g251489 = Atmo_Params601_g251489;
					float4 temp_output_203_0_g251517 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251517 = lerpResult104_g251489;
					float temp_output_132_0_g251515 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251517 = temp_output_132_0_g251515;
					float4 tex2DArrayNode83_g251517 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251517).zw + ( (temp_output_203_0_g251517).xy * temp_output_81_0_g251517 ) ),temp_output_82_0_g251517), 0.0 );
					float4 appendResult210_g251517 = (float4(tex2DArrayNode83_g251517.rgb , saturate( tex2DArrayNode83_g251517.a )));
					float4 temp_output_204_0_g251517 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251517 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251517).zw + ( (temp_output_204_0_g251517).xy * temp_output_81_0_g251517 ) ),temp_output_82_0_g251517), 0.0 );
					float4 appendResult212_g251517 = (float4(tex2DArrayNode122_g251517.rgb , saturate( tex2DArrayNode122_g251517.a )));
					float4 lerpResult131_g251517 = lerp( appendResult210_g251517 , appendResult212_g251517 , Global_TexBlend509_g251489);
					float4 temp_output_137_109_g251515 = lerpResult131_g251517;
					float4 lerpResult145_g251515 = lerp( TVE_AtmoParams , temp_output_137_109_g251515 , TVE_AtmoLayers[(int)temp_output_132_0_g251515]);
					float4 temp_output_590_110_g251489 = lerpResult145_g251515;
					half4 Atmo_Texture80_g251489 = temp_output_590_110_g251489;
					float4 In_AtmoTexture204_g251489 = Atmo_Texture80_g251489;
					float4 temp_output_593_163_g251489 = TVE_GlowParams;
					half4 Glow_Params609_g251489 = temp_output_593_163_g251489;
					float4 In_GlowParams204_g251489 = Glow_Params609_g251489;
					float4 temp_output_203_0_g251533 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251533 = lerpResult247_g251489;
					float temp_output_82_0_g251531 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251533 = temp_output_82_0_g251531;
					float4 tex2DArrayNode83_g251533 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251533).zw + ( (temp_output_203_0_g251533).xy * temp_output_81_0_g251533 ) ),temp_output_82_0_g251533), 0.0 );
					float4 appendResult210_g251533 = (float4(tex2DArrayNode83_g251533.rgb , saturate( tex2DArrayNode83_g251533.a )));
					float4 temp_output_204_0_g251533 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251533 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251533).zw + ( (temp_output_204_0_g251533).xy * temp_output_81_0_g251533 ) ),temp_output_82_0_g251533), 0.0 );
					float4 appendResult212_g251533 = (float4(tex2DArrayNode122_g251533.rgb , saturate( tex2DArrayNode122_g251533.a )));
					float4 lerpResult131_g251533 = lerp( appendResult210_g251533 , appendResult212_g251533 , Global_TexBlend509_g251489);
					float4 temp_output_159_109_g251531 = lerpResult131_g251533;
					float4 lerpResult167_g251531 = lerp( TVE_GlowParams , temp_output_159_109_g251531 , TVE_GlowLayers[(int)temp_output_82_0_g251531]);
					float4 temp_output_593_109_g251489 = lerpResult167_g251531;
					half4 Glow_Texture248_g251489 = temp_output_593_109_g251489;
					float4 In_GlowTexture204_g251489 = Glow_Texture248_g251489;
					float4 temp_output_592_139_g251489 = TVE_FormParams;
					float4 Form_Params606_g251489 = temp_output_592_139_g251489;
					float4 In_FormParams204_g251489 = Form_Params606_g251489;
					float4 temp_output_203_0_g251549 = TVE_FormBaseCoord;
					float2 lerpResult168_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251549 = lerpResult168_g251489;
					float temp_output_130_0_g251547 = _GlobalFormLayerValue;
					float temp_output_82_0_g251549 = temp_output_130_0_g251547;
					float4 tex2DArrayNode83_g251549 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251549).zw + ( (temp_output_203_0_g251549).xy * temp_output_81_0_g251549 ) ),temp_output_82_0_g251549), 0.0 );
					float4 appendResult210_g251549 = (float4(tex2DArrayNode83_g251549.rgb , saturate( tex2DArrayNode83_g251549.a )));
					float4 temp_output_204_0_g251549 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251549 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251549).zw + ( (temp_output_204_0_g251549).xy * temp_output_81_0_g251549 ) ),temp_output_82_0_g251549), 0.0 );
					float4 appendResult212_g251549 = (float4(tex2DArrayNode122_g251549.rgb , saturate( tex2DArrayNode122_g251549.a )));
					float4 lerpResult131_g251549 = lerp( appendResult210_g251549 , appendResult212_g251549 , Global_TexBlend509_g251489);
					float4 temp_output_135_109_g251547 = lerpResult131_g251549;
					float4 lerpResult143_g251547 = lerp( TVE_FormParams , temp_output_135_109_g251547 , TVE_FormLayers[(int)temp_output_130_0_g251547]);
					float4 temp_output_592_0_g251489 = lerpResult143_g251547;
					float4 Form_Texture112_g251489 = temp_output_592_0_g251489;
					float4 In_FormTexture204_g251489 = Form_Texture112_g251489;
					float4 temp_output_594_145_g251489 = TVE_FlowParams;
					half4 Flow_Params612_g251489 = temp_output_594_145_g251489;
					float4 In_FlowParams204_g251489 = Flow_Params612_g251489;
					float4 temp_output_203_0_g251541 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251541 = lerpResult400_g251489;
					float temp_output_136_0_g251539 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251541 = temp_output_136_0_g251539;
					float4 tex2DArrayNode83_g251541 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251541).zw + ( (temp_output_203_0_g251541).xy * temp_output_81_0_g251541 ) ),temp_output_82_0_g251541), 0.0 );
					float4 appendResult210_g251541 = (float4(tex2DArrayNode83_g251541.rgb , saturate( tex2DArrayNode83_g251541.a )));
					float4 temp_output_204_0_g251541 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251541 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251541).zw + ( (temp_output_204_0_g251541).xy * temp_output_81_0_g251541 ) ),temp_output_82_0_g251541), 0.0 );
					float4 appendResult212_g251541 = (float4(tex2DArrayNode122_g251541.rgb , saturate( tex2DArrayNode122_g251541.a )));
					float4 lerpResult131_g251541 = lerp( appendResult210_g251541 , appendResult212_g251541 , Global_TexBlend509_g251489);
					float4 temp_output_141_109_g251539 = lerpResult131_g251541;
					float4 lerpResult149_g251539 = lerp( TVE_FlowParams , temp_output_141_109_g251539 , TVE_FlowLayers[(int)temp_output_136_0_g251539]);
					half4 Flow_Texture405_g251489 = lerpResult149_g251539;
					float4 In_FlowTexture204_g251489 = Flow_Texture405_g251489;
					BuildGlobalData( Data204_g251489 , In_Dummy204_g251489 , In_CoatParams204_g251489 , In_CoatTexture204_g251489 , In_PaintParams204_g251489 , In_PaintTexture204_g251489 , In_AtmoParams204_g251489 , In_AtmoTexture204_g251489 , In_GlowParams204_g251489 , In_GlowTexture204_g251489 , In_FormParams204_g251489 , In_FormTexture204_g251489 , In_FlowParams204_g251489 , In_FlowTexture204_g251489 );
					TVEGlobalData Data15_g251652 =(TVEGlobalData)Data204_g251489;
					float Out_Dummy15_g251652 = 0.0;
					float4 Out_CoatParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251652 = float4( 0,0,0,0 );
					BreakData( Data15_g251652 , Out_Dummy15_g251652 , Out_CoatParams15_g251652 , Out_CoatTexture15_g251652 , Out_PaintParams15_g251652 , Out_PaintTexture15_g251652 , Out_AtmoParams15_g251652 , Out_AtmoTexture15_g251652 , Out_GlowParams15_g251652 , Out_GlowTexture15_g251652 , Out_FormParams15_g251652 , Out_FormTexture15_g251652 , Out_FlowParams15_g251652 , Out_FlowTexture15_g251652 );
					float4 Global_FormTexture351_g251649 = Out_FormTexture15_g251652;
					float3 Model_PivotWO353_g251649 = temp_output_314_19_g251649;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251658 = _ConformMeshMode;
					float Option70_g251658 = temp_output_17_0_g251658;
					half4 Model_VertexData357_g251649 = temp_output_314_29_g251649;
					float4 temp_output_3_0_g251658 = Model_VertexData357_g251649;
					float4 Channel70_g251658 = temp_output_3_0_g251658;
					float localSwitchChannel470_g251658 = SwitchChannel4( Option70_g251658 , Channel70_g251658 );
					float temp_output_390_0_g251649 = localSwitchChannel470_g251658;
					float temp_output_7_0_g251655 = _ConformMeshRemap.x;
					float temp_output_9_0_g251655 = ( temp_output_390_0_g251649 - temp_output_7_0_g251655 );
					float lerpResult374_g251649 = lerp( 1.0 , saturate( ( temp_output_9_0_g251655 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251649 = lerpResult374_g251649;
					float temp_output_328_0_g251649 = ( Blend_VertMask379_g251649 * TVE_IsEnabled );
					half Conform_Mask366_g251649 = temp_output_328_0_g251649;
					float temp_output_322_0_g251649 = ( ( ( ( (Global_FormTexture351_g251649).z - ( (Model_PivotWO353_g251649).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251649 ) );
					float3 appendResult329_g251649 = (float3(0.0 , temp_output_322_0_g251649 , 0.0));
					float3 appendResult387_g251649 = (float3(0.0 , 0.0 , temp_output_322_0_g251649));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251656 = appendResult387_g251649;
					#else
					float3 staticSwitch65_g251656 = appendResult329_g251649;
					#endif
					float3 Blanket_Conform368_g251649 = staticSwitch65_g251656;
					float4 appendResult312_g251649 = (float4(Blanket_Conform368_g251649 , 0.0));
					float4 temp_output_310_0_g251649 = ( Model_TransformData356_g251649 + appendResult312_g251649 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251649 = temp_output_310_0_g251649;
					#else
					float4 staticSwitch364_g251649 = Model_TransformData356_g251649;
					#endif
					half4 Final_TransformData365_g251649 = staticSwitch364_g251649;
					float4 In_TransformData16_g251651 = Final_TransformData365_g251649;
					float4 In_RotationData16_g251651 = Out_RotationData15_g251650;
					float4 In_InterpolatorA16_g251651 = Out_InterpolatorA15_g251650;
					BuildModelVertData( Data16_g251651 , In_Dummy16_g251651 , In_PositionOS16_g251651 , In_PositionWS16_g251651 , In_PositionWO16_g251651 , In_PositionRawOS16_g251651 , In_PivotOS16_g251651 , In_PivotWS16_g251651 , In_PivotWO16_g251651 , In_NormalOS16_g251651 , In_NormalWS16_g251651 , In_NormalRawOS16_g251651 , In_TangentOS16_g251651 , In_TangentWS16_g251651 , In_BitangentWS16_g251651 , In_ViewDirWS16_g251651 , In_CoordsData16_g251651 , In_VertexData16_g251651 , In_MasksData16_g251651 , In_PhaseData16_g251651 , In_TransformData16_g251651 , In_RotationData16_g251651 , In_InterpolatorA16_g251651 );
					TVEModelData Data15_g251747 =(TVEModelData)Data16_g251651;
					float Out_Dummy15_g251747 = 0.0;
					float3 Out_PositionOS15_g251747 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251747 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251747 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251747 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251747 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251747 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251747 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251747 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251747 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251747 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251747 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251747 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251747 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251747 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251747 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251747 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251747 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251747 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251747 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251747 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251747 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251747 , Out_Dummy15_g251747 , Out_PositionOS15_g251747 , Out_PositionWS15_g251747 , Out_PositionWO15_g251747 , Out_PositionRawOS15_g251747 , Out_PivotOS15_g251747 , Out_PivotWS15_g251747 , Out_PivotWO15_g251747 , Out_NormalOS15_g251747 , Out_NormalWS15_g251747 , Out_NormalRawOS15_g251747 , Out_TangentOS15_g251747 , Out_TangentWS15_g251747 , Out_BitangentWS15_g251747 , Out_ViewDirWS15_g251747 , Out_CoordsData15_g251747 , Out_VertexData15_g251747 , Out_MasksData15_g251747 , Out_PhaseData15_g251747 , Out_TransformData15_g251747 , Out_RotationData15_g251747 , Out_InterpolatorA15_g251747 );
					TVEModelData Data16_g251748 =(TVEModelData)Data15_g251747;
					float temp_output_14_0_g251748 = 0.0;
					float In_Dummy16_g251748 = temp_output_14_0_g251748;
					float3 Model_PositionOS147_g251746 = Out_PositionOS15_g251747;
					half3 VertexPos40_g251752 = Model_PositionOS147_g251746;
					float4 temp_output_1567_33_g251746 = Out_RotationData15_g251747;
					half4 Model_RotationData1569_g251746 = temp_output_1567_33_g251746;
					float2 break1582_g251746 = (Model_RotationData1569_g251746).xy;
					half Angle44_g251752 = break1582_g251746.y;
					half CosAngle89_g251752 = cos( Angle44_g251752 );
					half SinAngle93_g251752 = sin( Angle44_g251752 );
					float3 appendResult95_g251752 = (float3((VertexPos40_g251752).x , ( ( (VertexPos40_g251752).y * CosAngle89_g251752 ) - ( (VertexPos40_g251752).z * SinAngle93_g251752 ) ) , ( ( (VertexPos40_g251752).y * SinAngle93_g251752 ) + ( (VertexPos40_g251752).z * CosAngle89_g251752 ) )));
					half3 VertexPos40_g251753 = appendResult95_g251752;
					half Angle44_g251753 = -break1582_g251746.x;
					half CosAngle94_g251753 = cos( Angle44_g251753 );
					half SinAngle95_g251753 = sin( Angle44_g251753 );
					float3 appendResult98_g251753 = (float3(( ( (VertexPos40_g251753).x * CosAngle94_g251753 ) - ( (VertexPos40_g251753).y * SinAngle95_g251753 ) ) , ( ( (VertexPos40_g251753).x * SinAngle95_g251753 ) + ( (VertexPos40_g251753).y * CosAngle94_g251753 ) ) , (VertexPos40_g251753).z));
					half3 VertexPos40_g251751 = Model_PositionOS147_g251746;
					half Angle44_g251751 = break1582_g251746.y;
					half CosAngle89_g251751 = cos( Angle44_g251751 );
					half SinAngle93_g251751 = sin( Angle44_g251751 );
					float3 appendResult95_g251751 = (float3((VertexPos40_g251751).x , ( ( (VertexPos40_g251751).y * CosAngle89_g251751 ) - ( (VertexPos40_g251751).z * SinAngle93_g251751 ) ) , ( ( (VertexPos40_g251751).y * SinAngle93_g251751 ) + ( (VertexPos40_g251751).z * CosAngle89_g251751 ) )));
					half3 VertexPos40_g251756 = appendResult95_g251751;
					half Angle44_g251756 = break1582_g251746.x;
					half CosAngle91_g251756 = cos( Angle44_g251756 );
					half SinAngle92_g251756 = sin( Angle44_g251756 );
					float3 appendResult93_g251756 = (float3(( ( (VertexPos40_g251756).x * CosAngle91_g251756 ) + ( (VertexPos40_g251756).z * SinAngle92_g251756 ) ) , (VertexPos40_g251756).y , ( ( -(VertexPos40_g251756).x * SinAngle92_g251756 ) + ( (VertexPos40_g251756).z * CosAngle91_g251756 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251754 = appendResult93_g251756;
					#else
					float3 staticSwitch65_g251754 = appendResult98_g251753;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251749 = staticSwitch65_g251754;
					#else
					float3 staticSwitch65_g251749 = Model_PositionOS147_g251746;
					#endif
					float3 temp_output_1608_0_g251746 = staticSwitch65_g251749;
					half3 VertexPos40_g251755 = temp_output_1608_0_g251746;
					half Angle44_g251755 = (Model_RotationData1569_g251746).z;
					half CosAngle91_g251755 = cos( Angle44_g251755 );
					half SinAngle92_g251755 = sin( Angle44_g251755 );
					float3 appendResult93_g251755 = (float3(( ( (VertexPos40_g251755).x * CosAngle91_g251755 ) + ( (VertexPos40_g251755).z * SinAngle92_g251755 ) ) , (VertexPos40_g251755).y , ( ( -(VertexPos40_g251755).x * SinAngle92_g251755 ) + ( (VertexPos40_g251755).z * CosAngle91_g251755 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251750 = appendResult93_g251755;
					#else
					float3 staticSwitch65_g251750 = temp_output_1608_0_g251746;
					#endif
					float4 temp_output_1567_31_g251746 = Out_TransformData15_g251747;
					half4 Model_TransformData1568_g251746 = temp_output_1567_31_g251746;
					half3 Final_PositionOS178_g251746 = ( ( staticSwitch65_g251750 * (Model_TransformData1568_g251746).w ) + (Model_TransformData1568_g251746).xyz );
					float3 temp_output_4_0_g251748 = Final_PositionOS178_g251746;
					float3 In_PositionOS16_g251748 = temp_output_4_0_g251748;
					float3 In_PositionWS16_g251748 = Out_PositionWS15_g251747;
					float3 In_PositionWO16_g251748 = Out_PositionWO15_g251747;
					float3 In_PositionRawOS16_g251748 = Out_PositionRawOS15_g251747;
					float3 In_PivotOS16_g251748 = Out_PivotOS15_g251747;
					float3 In_PivotWS16_g251748 = Out_PivotWS15_g251747;
					float3 In_PivotWO16_g251748 = Out_PivotWO15_g251747;
					float3 temp_output_21_0_g251748 = Out_NormalOS15_g251747;
					float3 In_NormalOS16_g251748 = temp_output_21_0_g251748;
					float3 In_NormalWS16_g251748 = Out_NormalWS15_g251747;
					float3 In_NormalRawOS16_g251748 = Out_NormalRawOS15_g251747;
					float4 temp_output_6_0_g251748 = Out_TangentOS15_g251747;
					float4 In_TangentOS16_g251748 = temp_output_6_0_g251748;
					float3 In_TangentWS16_g251748 = Out_TangentWS15_g251747;
					float3 In_BitangentWS16_g251748 = Out_BitangentWS15_g251747;
					float3 In_ViewDirWS16_g251748 = Out_ViewDirWS15_g251747;
					float4 In_CoordsData16_g251748 = Out_CoordsData15_g251747;
					float4 In_VertexData16_g251748 = Out_VertexData15_g251747;
					float4 In_MasksData16_g251748 = Out_MasksData15_g251747;
					float4 In_PhaseData16_g251748 = Out_PhaseData15_g251747;
					float4 In_TransformData16_g251748 = temp_output_1567_31_g251746;
					float4 In_RotationData16_g251748 = temp_output_1567_33_g251746;
					float4 In_InterpolatorA16_g251748 = Out_InterpolatorA15_g251747;
					BuildModelVertData( Data16_g251748 , In_Dummy16_g251748 , In_PositionOS16_g251748 , In_PositionWS16_g251748 , In_PositionWO16_g251748 , In_PositionRawOS16_g251748 , In_PivotOS16_g251748 , In_PivotWS16_g251748 , In_PivotWO16_g251748 , In_NormalOS16_g251748 , In_NormalWS16_g251748 , In_NormalRawOS16_g251748 , In_TangentOS16_g251748 , In_TangentWS16_g251748 , In_BitangentWS16_g251748 , In_ViewDirWS16_g251748 , In_CoordsData16_g251748 , In_VertexData16_g251748 , In_MasksData16_g251748 , In_PhaseData16_g251748 , In_TransformData16_g251748 , In_RotationData16_g251748 , In_InterpolatorA16_g251748 );
					TVEModelData Data15_g251759 =(TVEModelData)Data16_g251748;
					float Out_Dummy15_g251759 = 0.0;
					float3 Out_PositionOS15_g251759 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251759 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251759 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251759 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251759 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251759 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251759 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251759 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251759 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251759 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251759 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251759 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251759 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251759 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251759 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251759 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251759 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251759 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251759 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251759 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251759 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251759 , Out_Dummy15_g251759 , Out_PositionOS15_g251759 , Out_PositionWS15_g251759 , Out_PositionWO15_g251759 , Out_PositionRawOS15_g251759 , Out_PivotOS15_g251759 , Out_PivotWS15_g251759 , Out_PivotWO15_g251759 , Out_NormalOS15_g251759 , Out_NormalWS15_g251759 , Out_NormalRawOS15_g251759 , Out_TangentOS15_g251759 , Out_TangentWS15_g251759 , Out_BitangentWS15_g251759 , Out_ViewDirWS15_g251759 , Out_CoordsData15_g251759 , Out_VertexData15_g251759 , Out_MasksData15_g251759 , Out_PhaseData15_g251759 , Out_TransformData15_g251759 , Out_RotationData15_g251759 , Out_InterpolatorA15_g251759 );
					TVEModelData Data16_g251760 =(TVEModelData)Data15_g251759;
					float temp_output_14_0_g251760 = 0.0;
					float In_Dummy16_g251760 = temp_output_14_0_g251760;
					float3 temp_output_217_24_g251758 = Out_PivotOS15_g251759;
					float3 temp_output_216_0_g251758 = ( Out_PositionOS15_g251759 + temp_output_217_24_g251758 );
					float3 temp_output_4_0_g251760 = temp_output_216_0_g251758;
					float3 In_PositionOS16_g251760 = temp_output_4_0_g251760;
					float3 In_PositionWS16_g251760 = Out_PositionWS15_g251759;
					float3 In_PositionWO16_g251760 = Out_PositionWO15_g251759;
					float3 In_PositionRawOS16_g251760 = Out_PositionRawOS15_g251759;
					float3 In_PivotOS16_g251760 = temp_output_217_24_g251758;
					float3 In_PivotWS16_g251760 = Out_PivotWS15_g251759;
					float3 In_PivotWO16_g251760 = Out_PivotWO15_g251759;
					float3 temp_output_21_0_g251760 = Out_NormalOS15_g251759;
					float3 In_NormalOS16_g251760 = temp_output_21_0_g251760;
					float3 In_NormalWS16_g251760 = Out_NormalWS15_g251759;
					float3 In_NormalRawOS16_g251760 = Out_NormalRawOS15_g251759;
					float4 temp_output_6_0_g251760 = Out_TangentOS15_g251759;
					float4 In_TangentOS16_g251760 = temp_output_6_0_g251760;
					float3 In_TangentWS16_g251760 = Out_TangentWS15_g251759;
					float3 In_BitangentWS16_g251760 = Out_BitangentWS15_g251759;
					float3 In_ViewDirWS16_g251760 = Out_ViewDirWS15_g251759;
					float4 In_CoordsData16_g251760 = Out_CoordsData15_g251759;
					float4 In_VertexData16_g251760 = Out_VertexData15_g251759;
					float4 In_MasksData16_g251760 = Out_MasksData15_g251759;
					float4 In_PhaseData16_g251760 = Out_PhaseData15_g251759;
					float4 In_TransformData16_g251760 = Out_TransformData15_g251759;
					float4 In_RotationData16_g251760 = Out_RotationData15_g251759;
					float4 In_InterpolatorA16_g251760 = Out_InterpolatorA15_g251759;
					BuildModelVertData( Data16_g251760 , In_Dummy16_g251760 , In_PositionOS16_g251760 , In_PositionWS16_g251760 , In_PositionWO16_g251760 , In_PositionRawOS16_g251760 , In_PivotOS16_g251760 , In_PivotWS16_g251760 , In_PivotWO16_g251760 , In_NormalOS16_g251760 , In_NormalWS16_g251760 , In_NormalRawOS16_g251760 , In_TangentOS16_g251760 , In_TangentWS16_g251760 , In_BitangentWS16_g251760 , In_ViewDirWS16_g251760 , In_CoordsData16_g251760 , In_VertexData16_g251760 , In_MasksData16_g251760 , In_PhaseData16_g251760 , In_TransformData16_g251760 , In_RotationData16_g251760 , In_InterpolatorA16_g251760 );
					TVEModelData Data15_g251790 =(TVEModelData)Data16_g251760;
					float Out_Dummy15_g251790 = 0.0;
					float3 Out_PositionOS15_g251790 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251790 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251790 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251790 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251790 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251790 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251790 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251790 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251790 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251790 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251790 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251790 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251790 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251790 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251790 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251790 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251790 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251790 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251790 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251790 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251790 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251790 , Out_Dummy15_g251790 , Out_PositionOS15_g251790 , Out_PositionWS15_g251790 , Out_PositionWO15_g251790 , Out_PositionRawOS15_g251790 , Out_PivotOS15_g251790 , Out_PivotWS15_g251790 , Out_PivotWO15_g251790 , Out_NormalOS15_g251790 , Out_NormalWS15_g251790 , Out_NormalRawOS15_g251790 , Out_TangentOS15_g251790 , Out_TangentWS15_g251790 , Out_BitangentWS15_g251790 , Out_ViewDirWS15_g251790 , Out_CoordsData15_g251790 , Out_VertexData15_g251790 , Out_MasksData15_g251790 , Out_PhaseData15_g251790 , Out_TransformData15_g251790 , Out_RotationData15_g251790 , Out_InterpolatorA15_g251790 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251790;
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

				uniform half TVE_DEBUG_Index;
				uniform half TVE_DEBUG_Clip;
				uniform half TVE_DEBUG_Min;
				uniform half TVE_DEBUG_Max;
				uniform half TVE_DEBUG_Shading;
				uniform half _IsTVEShader;
				uniform half TVE_DEBUG_Filter;
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

					float localIfModelDataByShader26_g251487 = ( 0.0 );
					TVEModelData Data26_g251487 = (TVEModelData)0;
					TVEModelData Data16_g251476 =(TVEModelData)0;
					half Dummy207_g251466 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g251476 = Dummy207_g251466;
					float In_Dummy16_g251476 = temp_output_14_0_g251476;
					float3 PositionOS131_g251466 = v.vertex.xyz;
					float3 temp_output_4_0_g251476 = PositionOS131_g251466;
					float3 In_PositionOS16_g251476 = temp_output_4_0_g251476;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g251466 = ase_positionWS;
					float3 vertexToFrag73_g251466 = temp_output_104_7_g251466;
					float3 PositionWS122_g251466 = vertexToFrag73_g251466;
					float3 In_PositionWS16_g251476 = PositionWS122_g251466;
					float4x4 break19_g251469 = unity_ObjectToWorld;
					float3 appendResult20_g251469 = (float3(break19_g251469[ 0 ][ 3 ] , break19_g251469[ 1 ][ 3 ] , break19_g251469[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251466 = appendResult20_g251469;
					float4x4 break19_g251471 = unity_ObjectToWorld;
					float3 appendResult20_g251471 = (float3(break19_g251471[ 0 ][ 3 ] , break19_g251471[ 1 ][ 3 ] , break19_g251471[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g251467 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g251466 = PositionOS131_g251466;
					float3 appendResult234_g251466 = (float3(break233_g251466.x , 0.0 , break233_g251466.z));
					float3 break413_g251466 = PositionOS131_g251466;
					float3 appendResult414_g251466 = (float3(break413_g251466.x , break413_g251466.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251473 = appendResult414_g251466;
					#else
					float3 staticSwitch65_g251473 = appendResult234_g251466;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g251466 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g251466 = appendResult60_g251467;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g251466 = staticSwitch65_g251473;
					#else
					float3 staticSwitch229_g251466 = _Vector0;
					#endif
					float3 PivotOS149_g251466 = staticSwitch229_g251466;
					float3 temp_output_122_0_g251471 = PivotOS149_g251466;
					float3 PivotsOnlyWS105_g251471 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g251471 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g251466 = ( appendResult20_g251471 + PivotsOnlyWS105_g251471 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g251466 = temp_output_340_7_g251466;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g251466 = temp_output_341_7_g251466;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g251466 = temp_output_341_7_g251466;
					#else
					float3 staticSwitch236_g251466 = temp_output_340_7_g251466;
					#endif
					float3 vertexToFrag76_g251466 = staticSwitch236_g251466;
					float3 PivotWS121_g251466 = vertexToFrag76_g251466;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251466 = ( PositionWS122_g251466 - PivotWS121_g251466 );
					#else
					float3 staticSwitch204_g251466 = PositionWS122_g251466;
					#endif
					float3 PositionWO132_g251466 = ( staticSwitch204_g251466 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251476 = PositionWO132_g251466;
					float3 In_PositionRawOS16_g251476 = PositionOS131_g251466;
					float3 In_PivotOS16_g251476 = PivotOS149_g251466;
					float3 In_PivotWS16_g251476 = PivotWS121_g251466;
					float3 PivotWO133_g251466 = ( PivotWS121_g251466 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251476 = PivotWO133_g251466;
					half3 NormalOS134_g251466 = v.normal;
					float3 temp_output_21_0_g251476 = NormalOS134_g251466;
					float3 In_NormalOS16_g251476 = temp_output_21_0_g251476;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g251466 = normalizedWorldNormal;
					float3 In_NormalWS16_g251476 = NormalWS95_g251466;
					float3 In_NormalRawOS16_g251476 = NormalOS134_g251466;
					half4 TangentlOS153_g251466 = v.tangent;
					float4 temp_output_6_0_g251476 = TangentlOS153_g251466;
					float4 In_TangentOS16_g251476 = temp_output_6_0_g251476;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g251466 = ase_tangentWS;
					float3 In_TangentWS16_g251476 = TangentWS136_g251466;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g251466 = ase_bitangentWS;
					float3 In_BitangentWS16_g251476 = BiangentWS421_g251466;
					float3 normalizeResult296_g251466 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251466 ) );
					half3 ViewDirWS169_g251466 = normalizeResult296_g251466;
					float3 In_ViewDirWS16_g251476 = ViewDirWS169_g251466;
					float4 appendResult397_g251466 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g251466 = appendResult397_g251466;
					float4 In_CoordsData16_g251476 = CoordsData398_g251466;
					half4 VertexMasks171_g251466 = v.ase_color;
					float4 In_VertexData16_g251476 = VertexMasks171_g251466;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251479 = (PositionOS131_g251466).z;
					#else
					float staticSwitch65_g251479 = (PositionOS131_g251466).y;
					#endif
					half Object_HeightValue267_g251466 = _ObjectHeightValue;
					half Bounds_HeightMask274_g251466 = saturate( ( staticSwitch65_g251479 / Object_HeightValue267_g251466 ) );
					half3 Position387_g251466 = PositionOS131_g251466;
					half Height387_g251466 = Object_HeightValue267_g251466;
					half Object_RadiusValue268_g251466 = _ObjectRadiusValue;
					half Radius387_g251466 = Object_RadiusValue268_g251466;
					half localCapsuleMaskYUp387_g251466 = CapsuleMaskYUp( Position387_g251466 , Height387_g251466 , Radius387_g251466 );
					half3 Position408_g251466 = PositionOS131_g251466;
					half Height408_g251466 = Object_HeightValue267_g251466;
					half Radius408_g251466 = Object_RadiusValue268_g251466;
					half localCapsuleMaskZUp408_g251466 = CapsuleMaskZUp( Position408_g251466 , Height408_g251466 , Radius408_g251466 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251484 = saturate( localCapsuleMaskZUp408_g251466 );
					#else
					float staticSwitch65_g251484 = saturate( localCapsuleMaskYUp387_g251466 );
					#endif
					half Bounds_SphereMask282_g251466 = staticSwitch65_g251484;
					float4 appendResult253_g251466 = (float4(Bounds_HeightMask274_g251466 , Bounds_SphereMask282_g251466 , 1.0 , 1.0));
					half4 MasksData254_g251466 = appendResult253_g251466;
					float4 In_MasksData16_g251476 = MasksData254_g251466;
					float temp_output_17_0_g251478 = _ObjectPhaseMode;
					float Option70_g251478 = temp_output_17_0_g251478;
					float4 temp_output_3_0_g251478 = v.ase_color;
					float4 Channel70_g251478 = temp_output_3_0_g251478;
					float localSwitchChannel470_g251478 = SwitchChannel4( Option70_g251478 , Channel70_g251478 );
					half Phase_Value372_g251466 = localSwitchChannel470_g251478;
					float3 break319_g251466 = PivotWO133_g251466;
					half Pivot_Position322_g251466 = ( break319_g251466.x + break319_g251466.z );
					half Phase_Position357_g251466 = ( Phase_Value372_g251466 + Pivot_Position322_g251466 );
					float temp_output_248_0_g251466 = frac( Phase_Position357_g251466 );
					float4 appendResult177_g251466 = (float4(( (frac( ( Phase_Position357_g251466 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g251466));
					half4 Phase_Data176_g251466 = appendResult177_g251466;
					float4 In_PhaseData16_g251476 = Phase_Data176_g251466;
					float4 In_TransformData16_g251476 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251476 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g251476 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g251476 , In_Dummy16_g251476 , In_PositionOS16_g251476 , In_PositionWS16_g251476 , In_PositionWO16_g251476 , In_PositionRawOS16_g251476 , In_PivotOS16_g251476 , In_PivotWS16_g251476 , In_PivotWO16_g251476 , In_NormalOS16_g251476 , In_NormalWS16_g251476 , In_NormalRawOS16_g251476 , In_TangentOS16_g251476 , In_TangentWS16_g251476 , In_BitangentWS16_g251476 , In_ViewDirWS16_g251476 , In_CoordsData16_g251476 , In_VertexData16_g251476 , In_MasksData16_g251476 , In_PhaseData16_g251476 , In_TransformData16_g251476 , In_RotationData16_g251476 , In_InterpolatorA16_g251476 );
					TVEModelData DataDefault26_g251487 = Data16_g251476;
					TVEModelData DataGeneral26_g251487 = Data16_g251476;
					TVEModelData DataBlanket26_g251487 = Data16_g251476;
					TVEModelData DataImpostor26_g251487 = Data16_g251476;
					TVEModelData Data16_g251456 =(TVEModelData)0;
					half Dummy207_g251446 = 0.0;
					float temp_output_14_0_g251456 = Dummy207_g251446;
					float In_Dummy16_g251456 = temp_output_14_0_g251456;
					float3 PositionOS131_g251446 = v.vertex.xyz;
					float3 temp_output_4_0_g251456 = PositionOS131_g251446;
					float3 In_PositionOS16_g251456 = temp_output_4_0_g251456;
					float3 temp_output_104_7_g251446 = ase_positionWS;
					float3 PositionWS122_g251446 = temp_output_104_7_g251446;
					float3 In_PositionWS16_g251456 = PositionWS122_g251446;
					float4x4 break19_g251449 = unity_ObjectToWorld;
					float3 appendResult20_g251449 = (float3(break19_g251449[ 0 ][ 3 ] , break19_g251449[ 1 ][ 3 ] , break19_g251449[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251446 = appendResult20_g251449;
					float3 PivotWS121_g251446 = temp_output_340_7_g251446;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251446 = ( PositionWS122_g251446 - PivotWS121_g251446 );
					#else
					float3 staticSwitch204_g251446 = PositionWS122_g251446;
					#endif
					float3 PositionWO132_g251446 = ( staticSwitch204_g251446 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251456 = PositionWO132_g251446;
					float3 In_PositionRawOS16_g251456 = PositionOS131_g251446;
					float3 PivotOS149_g251446 = _Vector0;
					float3 In_PivotOS16_g251456 = PivotOS149_g251446;
					float3 In_PivotWS16_g251456 = PivotWS121_g251446;
					float3 PivotWO133_g251446 = ( PivotWS121_g251446 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251456 = PivotWO133_g251446;
					half3 NormalOS134_g251446 = v.normal;
					float3 temp_output_21_0_g251456 = NormalOS134_g251446;
					float3 In_NormalOS16_g251456 = temp_output_21_0_g251456;
					half3 NormalWS95_g251446 = normalizedWorldNormal;
					float3 In_NormalWS16_g251456 = NormalWS95_g251446;
					float3 In_NormalRawOS16_g251456 = NormalOS134_g251446;
					half4 TangentlOS153_g251446 = v.tangent;
					float4 temp_output_6_0_g251456 = TangentlOS153_g251446;
					float4 In_TangentOS16_g251456 = temp_output_6_0_g251456;
					half3 TangentWS136_g251446 = ase_tangentWS;
					float3 In_TangentWS16_g251456 = TangentWS136_g251446;
					half3 BiangentWS421_g251446 = ase_bitangentWS;
					float3 In_BitangentWS16_g251456 = BiangentWS421_g251446;
					float3 normalizeResult296_g251446 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251446 ) );
					half3 ViewDirWS169_g251446 = normalizeResult296_g251446;
					float3 In_ViewDirWS16_g251456 = ViewDirWS169_g251446;
					float4 appendResult397_g251446 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g251446 = appendResult397_g251446;
					float4 In_CoordsData16_g251456 = CoordsData398_g251446;
					half4 VertexMasks171_g251446 = float4( 0,0,0,0 );
					float4 In_VertexData16_g251456 = VertexMasks171_g251446;
					half4 MasksData254_g251446 = float4( 0,0,0,0 );
					float4 In_MasksData16_g251456 = MasksData254_g251446;
					half4 Phase_Data176_g251446 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g251456 = Phase_Data176_g251446;
					float4 In_TransformData16_g251456 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251456 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g251456 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g251456 , In_Dummy16_g251456 , In_PositionOS16_g251456 , In_PositionWS16_g251456 , In_PositionWO16_g251456 , In_PositionRawOS16_g251456 , In_PivotOS16_g251456 , In_PivotWS16_g251456 , In_PivotWO16_g251456 , In_NormalOS16_g251456 , In_NormalWS16_g251456 , In_NormalRawOS16_g251456 , In_TangentOS16_g251456 , In_TangentWS16_g251456 , In_BitangentWS16_g251456 , In_ViewDirWS16_g251456 , In_CoordsData16_g251456 , In_VertexData16_g251456 , In_MasksData16_g251456 , In_PhaseData16_g251456 , In_TransformData16_g251456 , In_RotationData16_g251456 , In_InterpolatorA16_g251456 );
					TVEModelData DataTerrain26_g251487 = Data16_g251456;
					half IsShaderType2544 = _IsShaderType;
					float Type26_g251487 = IsShaderType2544;
					{
					if (Type26_g251487 == 0 )
					{
					Data26_g251487 = DataDefault26_g251487;
					}
					else if (Type26_g251487 == 1 )
					{
					Data26_g251487 = DataGeneral26_g251487;
					}
					else if (Type26_g251487 == 2 )
					{
					Data26_g251487 = DataBlanket26_g251487;
					}
					else if (Type26_g251487 == 3 )
					{
					Data26_g251487 = DataImpostor26_g251487;
					}
					else if (Type26_g251487 == 4 )
					{
					Data26_g251487 = DataTerrain26_g251487;
					}
					}
					TVEModelData Data15_g251646 =(TVEModelData)Data26_g251487;
					float Out_Dummy15_g251646 = 0.0;
					float3 Out_PositionOS15_g251646 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251646 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251646 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251646 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251646 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251646 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251646 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251646 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251646 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251646 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251646 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251646 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251646 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251646 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251646 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251646 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251646 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251646 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251646 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251646 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251646 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251646 , Out_Dummy15_g251646 , Out_PositionOS15_g251646 , Out_PositionWS15_g251646 , Out_PositionWO15_g251646 , Out_PositionRawOS15_g251646 , Out_PivotOS15_g251646 , Out_PivotWS15_g251646 , Out_PivotWO15_g251646 , Out_NormalOS15_g251646 , Out_NormalWS15_g251646 , Out_NormalRawOS15_g251646 , Out_TangentOS15_g251646 , Out_TangentWS15_g251646 , Out_BitangentWS15_g251646 , Out_ViewDirWS15_g251646 , Out_CoordsData15_g251646 , Out_VertexData15_g251646 , Out_MasksData15_g251646 , Out_PhaseData15_g251646 , Out_TransformData15_g251646 , Out_RotationData15_g251646 , Out_InterpolatorA15_g251646 );
					TVEModelData Data16_g251648 =(TVEModelData)Data15_g251646;
					float temp_output_14_0_g251648 = 0.0;
					float In_Dummy16_g251648 = temp_output_14_0_g251648;
					float3 temp_output_219_24_g251645 = Out_PivotOS15_g251646;
					float3 temp_output_215_0_g251645 = ( Out_PositionOS15_g251646 - temp_output_219_24_g251645 );
					float3 temp_output_4_0_g251648 = temp_output_215_0_g251645;
					float3 In_PositionOS16_g251648 = temp_output_4_0_g251648;
					float3 In_PositionWS16_g251648 = Out_PositionWS15_g251646;
					float3 In_PositionWO16_g251648 = Out_PositionWO15_g251646;
					float3 In_PositionRawOS16_g251648 = Out_PositionRawOS15_g251646;
					float3 In_PivotOS16_g251648 = temp_output_219_24_g251645;
					float3 In_PivotWS16_g251648 = Out_PivotWS15_g251646;
					float3 In_PivotWO16_g251648 = Out_PivotWO15_g251646;
					float3 temp_output_21_0_g251648 = Out_NormalOS15_g251646;
					float3 In_NormalOS16_g251648 = temp_output_21_0_g251648;
					float3 In_NormalWS16_g251648 = Out_NormalWS15_g251646;
					float3 In_NormalRawOS16_g251648 = Out_NormalRawOS15_g251646;
					float4 temp_output_6_0_g251648 = Out_TangentOS15_g251646;
					float4 In_TangentOS16_g251648 = temp_output_6_0_g251648;
					float3 In_TangentWS16_g251648 = Out_TangentWS15_g251646;
					float3 In_BitangentWS16_g251648 = Out_BitangentWS15_g251646;
					float3 In_ViewDirWS16_g251648 = Out_ViewDirWS15_g251646;
					float4 In_CoordsData16_g251648 = Out_CoordsData15_g251646;
					float4 In_VertexData16_g251648 = Out_VertexData15_g251646;
					float4 In_MasksData16_g251648 = Out_MasksData15_g251646;
					float4 In_PhaseData16_g251648 = Out_PhaseData15_g251646;
					float4 In_TransformData16_g251648 = Out_TransformData15_g251646;
					float4 In_RotationData16_g251648 = Out_RotationData15_g251646;
					float4 In_InterpolatorA16_g251648 = Out_InterpolatorA15_g251646;
					BuildModelVertData( Data16_g251648 , In_Dummy16_g251648 , In_PositionOS16_g251648 , In_PositionWS16_g251648 , In_PositionWO16_g251648 , In_PositionRawOS16_g251648 , In_PivotOS16_g251648 , In_PivotWS16_g251648 , In_PivotWO16_g251648 , In_NormalOS16_g251648 , In_NormalWS16_g251648 , In_NormalRawOS16_g251648 , In_TangentOS16_g251648 , In_TangentWS16_g251648 , In_BitangentWS16_g251648 , In_ViewDirWS16_g251648 , In_CoordsData16_g251648 , In_VertexData16_g251648 , In_MasksData16_g251648 , In_PhaseData16_g251648 , In_TransformData16_g251648 , In_RotationData16_g251648 , In_InterpolatorA16_g251648 );
					TVEModelData Data15_g251650 =(TVEModelData)Data16_g251648;
					float Out_Dummy15_g251650 = 0.0;
					float3 Out_PositionOS15_g251650 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251650 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251650 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251650 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251650 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251650 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251650 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251650 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251650 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251650 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251650 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251650 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251650 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251650 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251650 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251650 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251650 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251650 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251650 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251650 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251650 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251650 , Out_Dummy15_g251650 , Out_PositionOS15_g251650 , Out_PositionWS15_g251650 , Out_PositionWO15_g251650 , Out_PositionRawOS15_g251650 , Out_PivotOS15_g251650 , Out_PivotWS15_g251650 , Out_PivotWO15_g251650 , Out_NormalOS15_g251650 , Out_NormalWS15_g251650 , Out_NormalRawOS15_g251650 , Out_TangentOS15_g251650 , Out_TangentWS15_g251650 , Out_BitangentWS15_g251650 , Out_ViewDirWS15_g251650 , Out_CoordsData15_g251650 , Out_VertexData15_g251650 , Out_MasksData15_g251650 , Out_PhaseData15_g251650 , Out_TransformData15_g251650 , Out_RotationData15_g251650 , Out_InterpolatorA15_g251650 );
					TVEModelData Data16_g251651 =(TVEModelData)Data15_g251650;
					half Dummy317_g251649 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g251651 = Dummy317_g251649;
					float In_Dummy16_g251651 = temp_output_14_0_g251651;
					float3 temp_output_4_0_g251651 = Out_PositionOS15_g251650;
					float3 In_PositionOS16_g251651 = temp_output_4_0_g251651;
					float3 In_PositionWS16_g251651 = Out_PositionWS15_g251650;
					float3 temp_output_314_17_g251649 = Out_PositionWO15_g251650;
					float3 In_PositionWO16_g251651 = temp_output_314_17_g251649;
					float3 In_PositionRawOS16_g251651 = Out_PositionRawOS15_g251650;
					float3 In_PivotOS16_g251651 = Out_PivotOS15_g251650;
					float3 In_PivotWS16_g251651 = Out_PivotWS15_g251650;
					float3 temp_output_314_19_g251649 = Out_PivotWO15_g251650;
					float3 In_PivotWO16_g251651 = temp_output_314_19_g251649;
					float3 temp_output_21_0_g251651 = Out_NormalOS15_g251650;
					float3 In_NormalOS16_g251651 = temp_output_21_0_g251651;
					float3 In_NormalWS16_g251651 = Out_NormalWS15_g251650;
					float3 In_NormalRawOS16_g251651 = Out_NormalRawOS15_g251650;
					float4 temp_output_6_0_g251651 = Out_TangentOS15_g251650;
					float4 In_TangentOS16_g251651 = temp_output_6_0_g251651;
					float3 In_TangentWS16_g251651 = Out_TangentWS15_g251650;
					float3 In_BitangentWS16_g251651 = Out_BitangentWS15_g251650;
					float3 In_ViewDirWS16_g251651 = Out_ViewDirWS15_g251650;
					float4 In_CoordsData16_g251651 = Out_CoordsData15_g251650;
					float4 temp_output_314_29_g251649 = Out_VertexData15_g251650;
					float4 In_VertexData16_g251651 = temp_output_314_29_g251649;
					float4 In_MasksData16_g251651 = Out_MasksData15_g251650;
					float4 In_PhaseData16_g251651 = Out_PhaseData15_g251650;
					half4 Model_TransformData356_g251649 = Out_TransformData15_g251650;
					float localBuildGlobalData204_g251489 = ( 0.0 );
					TVEGlobalData Data204_g251489 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251489 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251489 = Dummy211_g251489;
					float4 temp_output_589_164_g251489 = TVE_CoatParams;
					half4 Coat_Params596_g251489 = temp_output_589_164_g251489;
					float4 In_CoatParams204_g251489 = Coat_Params596_g251489;
					float4 temp_output_203_0_g251509 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g251486 = ( 0.0 );
					TVEModelData Data26_g251486 = (TVEModelData)0;
					TVEModelData Data16_g251474 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g251474 = 0.0;
					float3 In_PositionWS16_g251474 = PositionWS122_g251466;
					float3 In_PositionWO16_g251474 = PositionWO132_g251466;
					float3 In_PivotWS16_g251474 = PivotWS121_g251466;
					float3 In_PivotWO16_g251474 = PivotWO133_g251466;
					float3 In_NormalWS16_g251474 = NormalWS95_g251466;
					float3 In_TangentWS16_g251474 = TangentWS136_g251466;
					float3 In_BitangentWS16_g251474 = BiangentWS421_g251466;
					half3 NormalWS427_g251466 = NormalWS95_g251466;
					half3 localComputeTriplanarWeights427_g251466 = ComputeTriplanarWeights( NormalWS427_g251466 );
					half3 TriplanarWeights429_g251466 = localComputeTriplanarWeights427_g251466;
					float3 In_TriplanarWeights16_g251474 = TriplanarWeights429_g251466;
					float3 In_ViewDirWS16_g251474 = ViewDirWS169_g251466;
					float4 In_CoordsData16_g251474 = CoordsData398_g251466;
					float4 In_VertexData16_g251474 = VertexMasks171_g251466;
					float4 In_PhaseData16_g251474 = Phase_Data176_g251466;
					BuildModelFragData( Data16_g251474 , In_Dummy16_g251474 , In_PositionWS16_g251474 , In_PositionWO16_g251474 , In_PivotWS16_g251474 , In_PivotWO16_g251474 , In_NormalWS16_g251474 , In_TangentWS16_g251474 , In_BitangentWS16_g251474 , In_TriplanarWeights16_g251474 , In_ViewDirWS16_g251474 , In_CoordsData16_g251474 , In_VertexData16_g251474 , In_PhaseData16_g251474 );
					TVEModelData DataDefault26_g251486 = Data16_g251474;
					TVEModelData DataGeneral26_g251486 = Data16_g251474;
					TVEModelData DataBlanket26_g251486 = Data16_g251474;
					TVEModelData DataImpostor26_g251486 = Data16_g251474;
					TVEModelData Data16_g251454 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g251454 = 0.0;
					float3 In_PositionWS16_g251454 = PositionWS122_g251446;
					float3 In_PositionWO16_g251454 = PositionWO132_g251446;
					float3 In_PivotWS16_g251454 = PivotWS121_g251446;
					float3 In_PivotWO16_g251454 = PivotWO133_g251446;
					float3 In_NormalWS16_g251454 = NormalWS95_g251446;
					float3 In_TangentWS16_g251454 = TangentWS136_g251446;
					float3 In_BitangentWS16_g251454 = BiangentWS421_g251446;
					half3 NormalWS427_g251446 = NormalWS95_g251446;
					half3 localComputeTriplanarWeights427_g251446 = ComputeTriplanarWeights( NormalWS427_g251446 );
					half3 TriplanarWeights429_g251446 = localComputeTriplanarWeights427_g251446;
					float3 In_TriplanarWeights16_g251454 = TriplanarWeights429_g251446;
					float3 In_ViewDirWS16_g251454 = ViewDirWS169_g251446;
					float4 In_CoordsData16_g251454 = CoordsData398_g251446;
					float4 In_VertexData16_g251454 = VertexMasks171_g251446;
					float4 In_PhaseData16_g251454 = Phase_Data176_g251446;
					BuildModelFragData( Data16_g251454 , In_Dummy16_g251454 , In_PositionWS16_g251454 , In_PositionWO16_g251454 , In_PivotWS16_g251454 , In_PivotWO16_g251454 , In_NormalWS16_g251454 , In_TangentWS16_g251454 , In_BitangentWS16_g251454 , In_TriplanarWeights16_g251454 , In_ViewDirWS16_g251454 , In_CoordsData16_g251454 , In_VertexData16_g251454 , In_PhaseData16_g251454 );
					TVEModelData DataTerrain26_g251486 = Data16_g251454;
					float Type26_g251486 = IsShaderType2544;
					{
					if (Type26_g251486 == 0 )
					{
					Data26_g251486 = DataDefault26_g251486;
					}
					else if (Type26_g251486 == 1 )
					{
					Data26_g251486 = DataGeneral26_g251486;
					}
					else if (Type26_g251486 == 2 )
					{
					Data26_g251486 = DataBlanket26_g251486;
					}
					else if (Type26_g251486 == 3 )
					{
					Data26_g251486 = DataImpostor26_g251486;
					}
					else if (Type26_g251486 == 4 )
					{
					Data26_g251486 = DataTerrain26_g251486;
					}
					}
					TVEModelData Data15_g251565 =(TVEModelData)Data26_g251486;
					float Out_Dummy15_g251565 = 0.0;
					float3 Out_PositionWS15_g251565 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251565 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251565 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251565 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251565 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251565 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251565 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251565 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251565 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251565 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251565 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251565 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251565 , Out_Dummy15_g251565 , Out_PositionWS15_g251565 , Out_PositionWO15_g251565 , Out_PivotWS15_g251565 , Out_PivotWO15_g251565 , Out_NormalWS15_g251565 , Out_TangentWS15_g251565 , Out_BitangentWS15_g251565 , Out_TriplanarWeights15_g251565 , Out_ViewDirWS15_g251565 , Out_CoordsData15_g251565 , Out_VertexData15_g251565 , Out_PhaseData15_g251565 );
					float3 Model_PositionWS497_g251489 = Out_PositionWS15_g251565;
					float2 Model_PositionWS_XZ143_g251489 = (Model_PositionWS497_g251489).xz;
					float3 Model_PivotWS498_g251489 = Out_PivotWS15_g251565;
					float2 Model_PivotWS_XZ145_g251489 = (Model_PivotWS498_g251489).xz;
					float2 lerpResult300_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251509 = lerpResult300_g251489;
					float temp_output_82_0_g251507 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251509 = temp_output_82_0_g251507;
					float4 tex2DArrayNode83_g251509 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251509).zw + ( (temp_output_203_0_g251509).xy * temp_output_81_0_g251509 ) ),temp_output_82_0_g251509), 0.0 );
					float4 appendResult210_g251509 = (float4(tex2DArrayNode83_g251509.rgb , saturate( tex2DArrayNode83_g251509.a )));
					float4 temp_output_204_0_g251509 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251509 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251509).zw + ( (temp_output_204_0_g251509).xy * temp_output_81_0_g251509 ) ),temp_output_82_0_g251509), 0.0 );
					float4 appendResult212_g251509 = (float4(tex2DArrayNode122_g251509.rgb , saturate( tex2DArrayNode122_g251509.a )));
					float4 TVE_RenderNearPositionR628_g251489 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251489 = saturate( ( distance( Model_PositionWS497_g251489 , (TVE_RenderNearPositionR628_g251489).xyz ) / (TVE_RenderNearPositionR628_g251489).w ) );
					float temp_output_7_0_g251490 = 1.0;
					float temp_output_9_0_g251490 = ( temp_output_507_0_g251489 - temp_output_7_0_g251490 );
					half TVE_RenderNearFadeValue635_g251489 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251489 = saturate( ( temp_output_9_0_g251490 / ( ( TVE_RenderNearFadeValue635_g251489 - temp_output_7_0_g251490 ) + 0.0001 ) ) );
					float4 lerpResult131_g251509 = lerp( appendResult210_g251509 , appendResult212_g251509 , Global_TexBlend509_g251489);
					float4 temp_output_159_109_g251507 = lerpResult131_g251509;
					float4 lerpResult168_g251507 = lerp( TVE_CoatParams , temp_output_159_109_g251507 , TVE_CoatLayers[(int)temp_output_82_0_g251507]);
					float4 temp_output_589_109_g251489 = lerpResult168_g251507;
					half4 Coat_Texture302_g251489 = temp_output_589_109_g251489;
					float4 In_CoatTexture204_g251489 = Coat_Texture302_g251489;
					float4 temp_output_595_164_g251489 = TVE_PaintParams;
					half4 Paint_Params575_g251489 = temp_output_595_164_g251489;
					float4 In_PaintParams204_g251489 = Paint_Params575_g251489;
					float4 temp_output_203_0_g251558 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251558 = lerpResult85_g251489;
					float temp_output_82_0_g251555 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251558 = temp_output_82_0_g251555;
					float4 tex2DArrayNode83_g251558 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251558).zw + ( (temp_output_203_0_g251558).xy * temp_output_81_0_g251558 ) ),temp_output_82_0_g251558), 0.0 );
					float4 appendResult210_g251558 = (float4(tex2DArrayNode83_g251558.rgb , saturate( tex2DArrayNode83_g251558.a )));
					float4 temp_output_204_0_g251558 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251558 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251558).zw + ( (temp_output_204_0_g251558).xy * temp_output_81_0_g251558 ) ),temp_output_82_0_g251558), 0.0 );
					float4 appendResult212_g251558 = (float4(tex2DArrayNode122_g251558.rgb , saturate( tex2DArrayNode122_g251558.a )));
					float4 lerpResult131_g251558 = lerp( appendResult210_g251558 , appendResult212_g251558 , Global_TexBlend509_g251489);
					float4 temp_output_171_109_g251555 = lerpResult131_g251558;
					float4 lerpResult174_g251555 = lerp( TVE_PaintParams , temp_output_171_109_g251555 , TVE_PaintLayers[(int)temp_output_82_0_g251555]);
					float4 temp_output_595_109_g251489 = lerpResult174_g251555;
					half4 Paint_Texture71_g251489 = temp_output_595_109_g251489;
					float4 In_PaintTexture204_g251489 = Paint_Texture71_g251489;
					float4 temp_output_590_141_g251489 = TVE_AtmoParams;
					half4 Atmo_Params601_g251489 = temp_output_590_141_g251489;
					float4 In_AtmoParams204_g251489 = Atmo_Params601_g251489;
					float4 temp_output_203_0_g251517 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251517 = lerpResult104_g251489;
					float temp_output_132_0_g251515 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251517 = temp_output_132_0_g251515;
					float4 tex2DArrayNode83_g251517 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251517).zw + ( (temp_output_203_0_g251517).xy * temp_output_81_0_g251517 ) ),temp_output_82_0_g251517), 0.0 );
					float4 appendResult210_g251517 = (float4(tex2DArrayNode83_g251517.rgb , saturate( tex2DArrayNode83_g251517.a )));
					float4 temp_output_204_0_g251517 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251517 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251517).zw + ( (temp_output_204_0_g251517).xy * temp_output_81_0_g251517 ) ),temp_output_82_0_g251517), 0.0 );
					float4 appendResult212_g251517 = (float4(tex2DArrayNode122_g251517.rgb , saturate( tex2DArrayNode122_g251517.a )));
					float4 lerpResult131_g251517 = lerp( appendResult210_g251517 , appendResult212_g251517 , Global_TexBlend509_g251489);
					float4 temp_output_137_109_g251515 = lerpResult131_g251517;
					float4 lerpResult145_g251515 = lerp( TVE_AtmoParams , temp_output_137_109_g251515 , TVE_AtmoLayers[(int)temp_output_132_0_g251515]);
					float4 temp_output_590_110_g251489 = lerpResult145_g251515;
					half4 Atmo_Texture80_g251489 = temp_output_590_110_g251489;
					float4 In_AtmoTexture204_g251489 = Atmo_Texture80_g251489;
					float4 temp_output_593_163_g251489 = TVE_GlowParams;
					half4 Glow_Params609_g251489 = temp_output_593_163_g251489;
					float4 In_GlowParams204_g251489 = Glow_Params609_g251489;
					float4 temp_output_203_0_g251533 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251533 = lerpResult247_g251489;
					float temp_output_82_0_g251531 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251533 = temp_output_82_0_g251531;
					float4 tex2DArrayNode83_g251533 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251533).zw + ( (temp_output_203_0_g251533).xy * temp_output_81_0_g251533 ) ),temp_output_82_0_g251533), 0.0 );
					float4 appendResult210_g251533 = (float4(tex2DArrayNode83_g251533.rgb , saturate( tex2DArrayNode83_g251533.a )));
					float4 temp_output_204_0_g251533 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251533 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251533).zw + ( (temp_output_204_0_g251533).xy * temp_output_81_0_g251533 ) ),temp_output_82_0_g251533), 0.0 );
					float4 appendResult212_g251533 = (float4(tex2DArrayNode122_g251533.rgb , saturate( tex2DArrayNode122_g251533.a )));
					float4 lerpResult131_g251533 = lerp( appendResult210_g251533 , appendResult212_g251533 , Global_TexBlend509_g251489);
					float4 temp_output_159_109_g251531 = lerpResult131_g251533;
					float4 lerpResult167_g251531 = lerp( TVE_GlowParams , temp_output_159_109_g251531 , TVE_GlowLayers[(int)temp_output_82_0_g251531]);
					float4 temp_output_593_109_g251489 = lerpResult167_g251531;
					half4 Glow_Texture248_g251489 = temp_output_593_109_g251489;
					float4 In_GlowTexture204_g251489 = Glow_Texture248_g251489;
					float4 temp_output_592_139_g251489 = TVE_FormParams;
					float4 Form_Params606_g251489 = temp_output_592_139_g251489;
					float4 In_FormParams204_g251489 = Form_Params606_g251489;
					float4 temp_output_203_0_g251549 = TVE_FormBaseCoord;
					float2 lerpResult168_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251549 = lerpResult168_g251489;
					float temp_output_130_0_g251547 = _GlobalFormLayerValue;
					float temp_output_82_0_g251549 = temp_output_130_0_g251547;
					float4 tex2DArrayNode83_g251549 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251549).zw + ( (temp_output_203_0_g251549).xy * temp_output_81_0_g251549 ) ),temp_output_82_0_g251549), 0.0 );
					float4 appendResult210_g251549 = (float4(tex2DArrayNode83_g251549.rgb , saturate( tex2DArrayNode83_g251549.a )));
					float4 temp_output_204_0_g251549 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251549 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251549).zw + ( (temp_output_204_0_g251549).xy * temp_output_81_0_g251549 ) ),temp_output_82_0_g251549), 0.0 );
					float4 appendResult212_g251549 = (float4(tex2DArrayNode122_g251549.rgb , saturate( tex2DArrayNode122_g251549.a )));
					float4 lerpResult131_g251549 = lerp( appendResult210_g251549 , appendResult212_g251549 , Global_TexBlend509_g251489);
					float4 temp_output_135_109_g251547 = lerpResult131_g251549;
					float4 lerpResult143_g251547 = lerp( TVE_FormParams , temp_output_135_109_g251547 , TVE_FormLayers[(int)temp_output_130_0_g251547]);
					float4 temp_output_592_0_g251489 = lerpResult143_g251547;
					float4 Form_Texture112_g251489 = temp_output_592_0_g251489;
					float4 In_FormTexture204_g251489 = Form_Texture112_g251489;
					float4 temp_output_594_145_g251489 = TVE_FlowParams;
					half4 Flow_Params612_g251489 = temp_output_594_145_g251489;
					float4 In_FlowParams204_g251489 = Flow_Params612_g251489;
					float4 temp_output_203_0_g251541 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251541 = lerpResult400_g251489;
					float temp_output_136_0_g251539 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251541 = temp_output_136_0_g251539;
					float4 tex2DArrayNode83_g251541 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251541).zw + ( (temp_output_203_0_g251541).xy * temp_output_81_0_g251541 ) ),temp_output_82_0_g251541), 0.0 );
					float4 appendResult210_g251541 = (float4(tex2DArrayNode83_g251541.rgb , saturate( tex2DArrayNode83_g251541.a )));
					float4 temp_output_204_0_g251541 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251541 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251541).zw + ( (temp_output_204_0_g251541).xy * temp_output_81_0_g251541 ) ),temp_output_82_0_g251541), 0.0 );
					float4 appendResult212_g251541 = (float4(tex2DArrayNode122_g251541.rgb , saturate( tex2DArrayNode122_g251541.a )));
					float4 lerpResult131_g251541 = lerp( appendResult210_g251541 , appendResult212_g251541 , Global_TexBlend509_g251489);
					float4 temp_output_141_109_g251539 = lerpResult131_g251541;
					float4 lerpResult149_g251539 = lerp( TVE_FlowParams , temp_output_141_109_g251539 , TVE_FlowLayers[(int)temp_output_136_0_g251539]);
					half4 Flow_Texture405_g251489 = lerpResult149_g251539;
					float4 In_FlowTexture204_g251489 = Flow_Texture405_g251489;
					BuildGlobalData( Data204_g251489 , In_Dummy204_g251489 , In_CoatParams204_g251489 , In_CoatTexture204_g251489 , In_PaintParams204_g251489 , In_PaintTexture204_g251489 , In_AtmoParams204_g251489 , In_AtmoTexture204_g251489 , In_GlowParams204_g251489 , In_GlowTexture204_g251489 , In_FormParams204_g251489 , In_FormTexture204_g251489 , In_FlowParams204_g251489 , In_FlowTexture204_g251489 );
					TVEGlobalData Data15_g251652 =(TVEGlobalData)Data204_g251489;
					float Out_Dummy15_g251652 = 0.0;
					float4 Out_CoatParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251652 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251652 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251652 = float4( 0,0,0,0 );
					BreakData( Data15_g251652 , Out_Dummy15_g251652 , Out_CoatParams15_g251652 , Out_CoatTexture15_g251652 , Out_PaintParams15_g251652 , Out_PaintTexture15_g251652 , Out_AtmoParams15_g251652 , Out_AtmoTexture15_g251652 , Out_GlowParams15_g251652 , Out_GlowTexture15_g251652 , Out_FormParams15_g251652 , Out_FormTexture15_g251652 , Out_FlowParams15_g251652 , Out_FlowTexture15_g251652 );
					float4 Global_FormTexture351_g251649 = Out_FormTexture15_g251652;
					float3 Model_PivotWO353_g251649 = temp_output_314_19_g251649;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251658 = _ConformMeshMode;
					float Option70_g251658 = temp_output_17_0_g251658;
					half4 Model_VertexData357_g251649 = temp_output_314_29_g251649;
					float4 temp_output_3_0_g251658 = Model_VertexData357_g251649;
					float4 Channel70_g251658 = temp_output_3_0_g251658;
					float localSwitchChannel470_g251658 = SwitchChannel4( Option70_g251658 , Channel70_g251658 );
					float temp_output_390_0_g251649 = localSwitchChannel470_g251658;
					float temp_output_7_0_g251655 = _ConformMeshRemap.x;
					float temp_output_9_0_g251655 = ( temp_output_390_0_g251649 - temp_output_7_0_g251655 );
					float lerpResult374_g251649 = lerp( 1.0 , saturate( ( temp_output_9_0_g251655 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251649 = lerpResult374_g251649;
					float temp_output_328_0_g251649 = ( Blend_VertMask379_g251649 * TVE_IsEnabled );
					half Conform_Mask366_g251649 = temp_output_328_0_g251649;
					float temp_output_322_0_g251649 = ( ( ( ( (Global_FormTexture351_g251649).z - ( (Model_PivotWO353_g251649).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251649 ) );
					float3 appendResult329_g251649 = (float3(0.0 , temp_output_322_0_g251649 , 0.0));
					float3 appendResult387_g251649 = (float3(0.0 , 0.0 , temp_output_322_0_g251649));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251656 = appendResult387_g251649;
					#else
					float3 staticSwitch65_g251656 = appendResult329_g251649;
					#endif
					float3 Blanket_Conform368_g251649 = staticSwitch65_g251656;
					float4 appendResult312_g251649 = (float4(Blanket_Conform368_g251649 , 0.0));
					float4 temp_output_310_0_g251649 = ( Model_TransformData356_g251649 + appendResult312_g251649 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251649 = temp_output_310_0_g251649;
					#else
					float4 staticSwitch364_g251649 = Model_TransformData356_g251649;
					#endif
					half4 Final_TransformData365_g251649 = staticSwitch364_g251649;
					float4 In_TransformData16_g251651 = Final_TransformData365_g251649;
					float4 In_RotationData16_g251651 = Out_RotationData15_g251650;
					float4 In_InterpolatorA16_g251651 = Out_InterpolatorA15_g251650;
					BuildModelVertData( Data16_g251651 , In_Dummy16_g251651 , In_PositionOS16_g251651 , In_PositionWS16_g251651 , In_PositionWO16_g251651 , In_PositionRawOS16_g251651 , In_PivotOS16_g251651 , In_PivotWS16_g251651 , In_PivotWO16_g251651 , In_NormalOS16_g251651 , In_NormalWS16_g251651 , In_NormalRawOS16_g251651 , In_TangentOS16_g251651 , In_TangentWS16_g251651 , In_BitangentWS16_g251651 , In_ViewDirWS16_g251651 , In_CoordsData16_g251651 , In_VertexData16_g251651 , In_MasksData16_g251651 , In_PhaseData16_g251651 , In_TransformData16_g251651 , In_RotationData16_g251651 , In_InterpolatorA16_g251651 );
					TVEModelData Data15_g251747 =(TVEModelData)Data16_g251651;
					float Out_Dummy15_g251747 = 0.0;
					float3 Out_PositionOS15_g251747 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251747 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251747 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251747 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251747 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251747 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251747 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251747 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251747 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251747 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251747 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251747 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251747 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251747 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251747 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251747 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251747 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251747 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251747 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251747 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251747 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251747 , Out_Dummy15_g251747 , Out_PositionOS15_g251747 , Out_PositionWS15_g251747 , Out_PositionWO15_g251747 , Out_PositionRawOS15_g251747 , Out_PivotOS15_g251747 , Out_PivotWS15_g251747 , Out_PivotWO15_g251747 , Out_NormalOS15_g251747 , Out_NormalWS15_g251747 , Out_NormalRawOS15_g251747 , Out_TangentOS15_g251747 , Out_TangentWS15_g251747 , Out_BitangentWS15_g251747 , Out_ViewDirWS15_g251747 , Out_CoordsData15_g251747 , Out_VertexData15_g251747 , Out_MasksData15_g251747 , Out_PhaseData15_g251747 , Out_TransformData15_g251747 , Out_RotationData15_g251747 , Out_InterpolatorA15_g251747 );
					TVEModelData Data16_g251748 =(TVEModelData)Data15_g251747;
					float temp_output_14_0_g251748 = 0.0;
					float In_Dummy16_g251748 = temp_output_14_0_g251748;
					float3 Model_PositionOS147_g251746 = Out_PositionOS15_g251747;
					half3 VertexPos40_g251752 = Model_PositionOS147_g251746;
					float4 temp_output_1567_33_g251746 = Out_RotationData15_g251747;
					half4 Model_RotationData1569_g251746 = temp_output_1567_33_g251746;
					float2 break1582_g251746 = (Model_RotationData1569_g251746).xy;
					half Angle44_g251752 = break1582_g251746.y;
					half CosAngle89_g251752 = cos( Angle44_g251752 );
					half SinAngle93_g251752 = sin( Angle44_g251752 );
					float3 appendResult95_g251752 = (float3((VertexPos40_g251752).x , ( ( (VertexPos40_g251752).y * CosAngle89_g251752 ) - ( (VertexPos40_g251752).z * SinAngle93_g251752 ) ) , ( ( (VertexPos40_g251752).y * SinAngle93_g251752 ) + ( (VertexPos40_g251752).z * CosAngle89_g251752 ) )));
					half3 VertexPos40_g251753 = appendResult95_g251752;
					half Angle44_g251753 = -break1582_g251746.x;
					half CosAngle94_g251753 = cos( Angle44_g251753 );
					half SinAngle95_g251753 = sin( Angle44_g251753 );
					float3 appendResult98_g251753 = (float3(( ( (VertexPos40_g251753).x * CosAngle94_g251753 ) - ( (VertexPos40_g251753).y * SinAngle95_g251753 ) ) , ( ( (VertexPos40_g251753).x * SinAngle95_g251753 ) + ( (VertexPos40_g251753).y * CosAngle94_g251753 ) ) , (VertexPos40_g251753).z));
					half3 VertexPos40_g251751 = Model_PositionOS147_g251746;
					half Angle44_g251751 = break1582_g251746.y;
					half CosAngle89_g251751 = cos( Angle44_g251751 );
					half SinAngle93_g251751 = sin( Angle44_g251751 );
					float3 appendResult95_g251751 = (float3((VertexPos40_g251751).x , ( ( (VertexPos40_g251751).y * CosAngle89_g251751 ) - ( (VertexPos40_g251751).z * SinAngle93_g251751 ) ) , ( ( (VertexPos40_g251751).y * SinAngle93_g251751 ) + ( (VertexPos40_g251751).z * CosAngle89_g251751 ) )));
					half3 VertexPos40_g251756 = appendResult95_g251751;
					half Angle44_g251756 = break1582_g251746.x;
					half CosAngle91_g251756 = cos( Angle44_g251756 );
					half SinAngle92_g251756 = sin( Angle44_g251756 );
					float3 appendResult93_g251756 = (float3(( ( (VertexPos40_g251756).x * CosAngle91_g251756 ) + ( (VertexPos40_g251756).z * SinAngle92_g251756 ) ) , (VertexPos40_g251756).y , ( ( -(VertexPos40_g251756).x * SinAngle92_g251756 ) + ( (VertexPos40_g251756).z * CosAngle91_g251756 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251754 = appendResult93_g251756;
					#else
					float3 staticSwitch65_g251754 = appendResult98_g251753;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251749 = staticSwitch65_g251754;
					#else
					float3 staticSwitch65_g251749 = Model_PositionOS147_g251746;
					#endif
					float3 temp_output_1608_0_g251746 = staticSwitch65_g251749;
					half3 VertexPos40_g251755 = temp_output_1608_0_g251746;
					half Angle44_g251755 = (Model_RotationData1569_g251746).z;
					half CosAngle91_g251755 = cos( Angle44_g251755 );
					half SinAngle92_g251755 = sin( Angle44_g251755 );
					float3 appendResult93_g251755 = (float3(( ( (VertexPos40_g251755).x * CosAngle91_g251755 ) + ( (VertexPos40_g251755).z * SinAngle92_g251755 ) ) , (VertexPos40_g251755).y , ( ( -(VertexPos40_g251755).x * SinAngle92_g251755 ) + ( (VertexPos40_g251755).z * CosAngle91_g251755 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251750 = appendResult93_g251755;
					#else
					float3 staticSwitch65_g251750 = temp_output_1608_0_g251746;
					#endif
					float4 temp_output_1567_31_g251746 = Out_TransformData15_g251747;
					half4 Model_TransformData1568_g251746 = temp_output_1567_31_g251746;
					half3 Final_PositionOS178_g251746 = ( ( staticSwitch65_g251750 * (Model_TransformData1568_g251746).w ) + (Model_TransformData1568_g251746).xyz );
					float3 temp_output_4_0_g251748 = Final_PositionOS178_g251746;
					float3 In_PositionOS16_g251748 = temp_output_4_0_g251748;
					float3 In_PositionWS16_g251748 = Out_PositionWS15_g251747;
					float3 In_PositionWO16_g251748 = Out_PositionWO15_g251747;
					float3 In_PositionRawOS16_g251748 = Out_PositionRawOS15_g251747;
					float3 In_PivotOS16_g251748 = Out_PivotOS15_g251747;
					float3 In_PivotWS16_g251748 = Out_PivotWS15_g251747;
					float3 In_PivotWO16_g251748 = Out_PivotWO15_g251747;
					float3 temp_output_21_0_g251748 = Out_NormalOS15_g251747;
					float3 In_NormalOS16_g251748 = temp_output_21_0_g251748;
					float3 In_NormalWS16_g251748 = Out_NormalWS15_g251747;
					float3 In_NormalRawOS16_g251748 = Out_NormalRawOS15_g251747;
					float4 temp_output_6_0_g251748 = Out_TangentOS15_g251747;
					float4 In_TangentOS16_g251748 = temp_output_6_0_g251748;
					float3 In_TangentWS16_g251748 = Out_TangentWS15_g251747;
					float3 In_BitangentWS16_g251748 = Out_BitangentWS15_g251747;
					float3 In_ViewDirWS16_g251748 = Out_ViewDirWS15_g251747;
					float4 In_CoordsData16_g251748 = Out_CoordsData15_g251747;
					float4 In_VertexData16_g251748 = Out_VertexData15_g251747;
					float4 In_MasksData16_g251748 = Out_MasksData15_g251747;
					float4 In_PhaseData16_g251748 = Out_PhaseData15_g251747;
					float4 In_TransformData16_g251748 = temp_output_1567_31_g251746;
					float4 In_RotationData16_g251748 = temp_output_1567_33_g251746;
					float4 In_InterpolatorA16_g251748 = Out_InterpolatorA15_g251747;
					BuildModelVertData( Data16_g251748 , In_Dummy16_g251748 , In_PositionOS16_g251748 , In_PositionWS16_g251748 , In_PositionWO16_g251748 , In_PositionRawOS16_g251748 , In_PivotOS16_g251748 , In_PivotWS16_g251748 , In_PivotWO16_g251748 , In_NormalOS16_g251748 , In_NormalWS16_g251748 , In_NormalRawOS16_g251748 , In_TangentOS16_g251748 , In_TangentWS16_g251748 , In_BitangentWS16_g251748 , In_ViewDirWS16_g251748 , In_CoordsData16_g251748 , In_VertexData16_g251748 , In_MasksData16_g251748 , In_PhaseData16_g251748 , In_TransformData16_g251748 , In_RotationData16_g251748 , In_InterpolatorA16_g251748 );
					TVEModelData Data15_g251759 =(TVEModelData)Data16_g251748;
					float Out_Dummy15_g251759 = 0.0;
					float3 Out_PositionOS15_g251759 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251759 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251759 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251759 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251759 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251759 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251759 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251759 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251759 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251759 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251759 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251759 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251759 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251759 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251759 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251759 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251759 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251759 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251759 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251759 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251759 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251759 , Out_Dummy15_g251759 , Out_PositionOS15_g251759 , Out_PositionWS15_g251759 , Out_PositionWO15_g251759 , Out_PositionRawOS15_g251759 , Out_PivotOS15_g251759 , Out_PivotWS15_g251759 , Out_PivotWO15_g251759 , Out_NormalOS15_g251759 , Out_NormalWS15_g251759 , Out_NormalRawOS15_g251759 , Out_TangentOS15_g251759 , Out_TangentWS15_g251759 , Out_BitangentWS15_g251759 , Out_ViewDirWS15_g251759 , Out_CoordsData15_g251759 , Out_VertexData15_g251759 , Out_MasksData15_g251759 , Out_PhaseData15_g251759 , Out_TransformData15_g251759 , Out_RotationData15_g251759 , Out_InterpolatorA15_g251759 );
					TVEModelData Data16_g251760 =(TVEModelData)Data15_g251759;
					float temp_output_14_0_g251760 = 0.0;
					float In_Dummy16_g251760 = temp_output_14_0_g251760;
					float3 temp_output_217_24_g251758 = Out_PivotOS15_g251759;
					float3 temp_output_216_0_g251758 = ( Out_PositionOS15_g251759 + temp_output_217_24_g251758 );
					float3 temp_output_4_0_g251760 = temp_output_216_0_g251758;
					float3 In_PositionOS16_g251760 = temp_output_4_0_g251760;
					float3 In_PositionWS16_g251760 = Out_PositionWS15_g251759;
					float3 In_PositionWO16_g251760 = Out_PositionWO15_g251759;
					float3 In_PositionRawOS16_g251760 = Out_PositionRawOS15_g251759;
					float3 In_PivotOS16_g251760 = temp_output_217_24_g251758;
					float3 In_PivotWS16_g251760 = Out_PivotWS15_g251759;
					float3 In_PivotWO16_g251760 = Out_PivotWO15_g251759;
					float3 temp_output_21_0_g251760 = Out_NormalOS15_g251759;
					float3 In_NormalOS16_g251760 = temp_output_21_0_g251760;
					float3 In_NormalWS16_g251760 = Out_NormalWS15_g251759;
					float3 In_NormalRawOS16_g251760 = Out_NormalRawOS15_g251759;
					float4 temp_output_6_0_g251760 = Out_TangentOS15_g251759;
					float4 In_TangentOS16_g251760 = temp_output_6_0_g251760;
					float3 In_TangentWS16_g251760 = Out_TangentWS15_g251759;
					float3 In_BitangentWS16_g251760 = Out_BitangentWS15_g251759;
					float3 In_ViewDirWS16_g251760 = Out_ViewDirWS15_g251759;
					float4 In_CoordsData16_g251760 = Out_CoordsData15_g251759;
					float4 In_VertexData16_g251760 = Out_VertexData15_g251759;
					float4 In_MasksData16_g251760 = Out_MasksData15_g251759;
					float4 In_PhaseData16_g251760 = Out_PhaseData15_g251759;
					float4 In_TransformData16_g251760 = Out_TransformData15_g251759;
					float4 In_RotationData16_g251760 = Out_RotationData15_g251759;
					float4 In_InterpolatorA16_g251760 = Out_InterpolatorA15_g251759;
					BuildModelVertData( Data16_g251760 , In_Dummy16_g251760 , In_PositionOS16_g251760 , In_PositionWS16_g251760 , In_PositionWO16_g251760 , In_PositionRawOS16_g251760 , In_PivotOS16_g251760 , In_PivotWS16_g251760 , In_PivotWO16_g251760 , In_NormalOS16_g251760 , In_NormalWS16_g251760 , In_NormalRawOS16_g251760 , In_TangentOS16_g251760 , In_TangentWS16_g251760 , In_BitangentWS16_g251760 , In_ViewDirWS16_g251760 , In_CoordsData16_g251760 , In_VertexData16_g251760 , In_MasksData16_g251760 , In_PhaseData16_g251760 , In_TransformData16_g251760 , In_RotationData16_g251760 , In_InterpolatorA16_g251760 );
					TVEModelData Data15_g251790 =(TVEModelData)Data16_g251760;
					float Out_Dummy15_g251790 = 0.0;
					float3 Out_PositionOS15_g251790 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251790 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251790 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251790 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251790 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251790 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251790 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251790 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251790 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251790 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251790 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251790 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251790 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251790 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251790 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251790 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251790 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251790 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251790 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251790 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251790 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251790 , Out_Dummy15_g251790 , Out_PositionOS15_g251790 , Out_PositionWS15_g251790 , Out_PositionWO15_g251790 , Out_PositionRawOS15_g251790 , Out_PivotOS15_g251790 , Out_PivotWS15_g251790 , Out_PivotWO15_g251790 , Out_NormalOS15_g251790 , Out_NormalWS15_g251790 , Out_NormalRawOS15_g251790 , Out_TangentOS15_g251790 , Out_TangentWS15_g251790 , Out_BitangentWS15_g251790 , Out_ViewDirWS15_g251790 , Out_CoordsData15_g251790 , Out_VertexData15_g251790 , Out_MasksData15_g251790 , Out_PhaseData15_g251790 , Out_TransformData15_g251790 , Out_RotationData15_g251790 , Out_InterpolatorA15_g251790 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251790;
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
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2543;-7936,-5374;Inherit;False;Property;_IsShaderType;_IsShaderType;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2563;-2048,-6256;Inherit;False;Get Global Volume;-1;;251442;f768f57f9fe20884881af88e78b0e3a0;0;0;3;FLOAT4;148;FLOAT4;145;FLOAT;150
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2544;-7744,-5374;Half;False;IsShaderType;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2549;-1792,-6336;Inherit;False;FLOAT3;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2559;-2048,-6400;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2582;-2048,-5824;Inherit;False;Get Global Volume;-1;;251445;f768f57f9fe20884881af88e78b0e3a0;0;0;3;FLOAT4;148;FLOAT4;145;FLOAT;150
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2492;-7936,-4862;Inherit;False;Block Model;7;;251446;7ad7765e793a6714babedee0033c36e9;18,404,0,437,0,431,0,240,0,290,0,289,0,291,0,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0;11;102;FLOAT3;0,0,0;False;163;FLOAT3;0,0,0;False;186;FLOAT3;0,0,0;False;187;FLOAT3;0,0,0;False;166;FLOAT3;0,0,0;False;164;FLOAT3;0,0,0;False;301;FLOAT3;0,0,0;False;418;FLOAT3;0,0,0;False;167;FLOAT4;0,0,0,0;False;172;FLOAT4;0,0,0,0;False;175;FLOAT4;0,0,0,0;False;2;OBJECT;128;OBJECT;314
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2497;-7936,-4734;Inherit;False;2544;IsShaderType;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2372;-7936,-4990;Inherit;False;Block Model;7;;251466;7ad7765e793a6714babedee0033c36e9;18,404,1,437,1,431,1,240,1,290,1,289,1,291,1,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0;11;102;FLOAT3;0,0,0;False;163;FLOAT3;0,0,0;False;186;FLOAT3;0,0,0;False;187;FLOAT3;0,0,0;False;166;FLOAT3;0,0,0;False;164;FLOAT3;0,0,0;False;301;FLOAT3;0,0,0;False;418;FLOAT3;0,0,0;False;167;FLOAT4;0,0,0,0;False;172;FLOAT4;0,0,0,0;False;175;FLOAT4;0,0,0,0;False;2;OBJECT;128;OBJECT;314
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2570;-1792,-5824;Inherit;False;FLOAT3;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2550;-1792,-6272;Inherit;False;FLOAT;3;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2581;-2048,-6016;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DistanceOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2552;-1536,-6400;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2545;-7552,-4734;Inherit;False;If Model Data;-1;;251486;d269c9c511ff160419055604aade1e70;1,32,1;9;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;33;OBJECT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.DistanceOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2568;-1536,-6016;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2571;-1792,-5760;Inherit;False;FLOAT;3;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2553;-1280,-6400;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2373;-7232,-4736;Half;False;Model Frag;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2577;-1280,-6016;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2554;-1152,-6400;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2374;-2048,-4992;Inherit;False;2373;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2519;-6784,-4992;Inherit;False;2373;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2491;-7552,-4990;Inherit;False;If Model Data;-1;;251487;d269c9c511ff160419055604aade1e70;1,32,1;9;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;33;OBJECT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2573;-1152,-6016;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2557;-896,-6400;Inherit;False;Math Remap;-1;;251488;5eda8a2bb94ebef4ab0e43d19291cd8b;3,18,0,14,1,21,1;4;6;FLOAT;0;False;7;FLOAT;1;False;8;FLOAT;1;False;19;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2377;-7232,-4992;Half;False;Model Vert;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2560;-6528,-4992;Inherit;False;Block Global;21;;251489;212e17d4006dc88449d56ce0340cb5ff;32,308,1,560,1,276,1,285,1,402,1,385,1,283,1,282,1,396,1,417,1,484,0,485,0,486,0,487,0,561,0,482,0,488,0,483,0,315,1,598,0,311,1,578,0,317,1,603,0,604,0,607,0,421,1,321,1,398,1,413,0,557,1,404,1;1;206;OBJECT;0,0,0,0;False;1;OBJECT;151
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2561;-1792,-4992;Inherit;False;Block Global;21;;251566;212e17d4006dc88449d56ce0340cb5ff;32,308,1,560,1,276,1,285,1,402,1,385,1,283,1,282,1,396,1,417,1,484,0,485,0,486,0,487,0,561,0,482,0,488,0,483,0,315,1,598,0,311,1,578,0,317,1,603,0,604,0,607,0,421,1,321,1,398,1,413,0,557,1,404,1;1;206;OBJECT;0,0,0,0;False;1;OBJECT;151
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2574;-896,-6016;Inherit;False;Math Remap;-1;;251643;5eda8a2bb94ebef4ab0e43d19291cd8b;3,18,0,14,1,21,1;4;6;FLOAT;0;False;7;FLOAT;1;False;8;FLOAT;0.9999;False;19;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2558;-576,-6400;Half;False;Global_Blend;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2435;-1024,-2656;Inherit;False;FLOAT2;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2427;-1024,-3136;Inherit;False;FLOAT2;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2521;-6208,-4992;Half;False;Global Data;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2522;-5760,-4992;Inherit;False;2377;Model Vert;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2419;-1408,-4992;Inherit;False;Break Global Data;-1;;251644;5f0a1052cfecd8a4da416d9b8f1dc3bc;0;1;6;OBJECT;0;False;14;OBJECT;26;FLOAT;14;FLOAT4;20;FLOAT4;27;FLOAT4;28;FLOAT4;0;FLOAT4;31;FLOAT4;16;FLOAT4;32;FLOAT4;19;FLOAT4;33;FLOAT4;18;FLOAT4;34;FLOAT4;24
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2564;-1024,-4992;Inherit;False;Constant;_Color2;Color 2;26;0;Create;True;0;0;0;False;0;False;1,0,0.3576326,0;0,0,0,0;True;False;0;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2565;-1024,-4848;Inherit;False;Constant;_Color3;Color 2;26;0;Create;True;0;0;0;False;0;False;0,0.5347826,1,0;0,0,0,0;True;False;0;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2566;-1024,-4704;Inherit;False;2558;Global_Blend;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2578;-576,-6016;Half;False;Global_Edge;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2428;-1024,-3008;Inherit;False;FLOAT3;2;2;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2539;-1024,-2944;Inherit;False;Constant;_Float16;Float 16;26;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2536;-768,-3136;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2501;-640,-2656;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2523;-5504,-4992;Inherit;False;Block Pivots Sub;-1;;251645;186f08b1bbe15894d9c677d50398679b;0;1;146;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2524;-5504,-4864;Inherit;False;2521;Global Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2567;-640,-4992;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2585;-640,-4736;Inherit;False;2578;Global_Edge;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2584;-640,-5184;Inherit;False;Constant;_Color4;Color 2;26;0;Create;True;0;0;0;False;0;False;0.3867925,0.3867925,0.3867925,0;0,0,0,0;True;False;0;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2406;-1024,-4608;Inherit;False;FLOAT3;0;0;0;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2537;-768,-3008;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2408;-1024,-4096;Inherit;False;FLOAT3;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2409;-1024,-4032;Inherit;False;FLOAT3;3;3;3;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2411;-1024,-3840;Inherit;False;FLOAT3;0;0;0;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2412;-1024,-3776;Inherit;False;FLOAT3;1;1;1;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2415;-1024,-3712;Inherit;False;FLOAT3;2;2;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2416;-1024,-3648;Inherit;False;FLOAT3;3;3;3;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2424;-1024,-3392;Inherit;False;FLOAT3;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2425;-1024,-3328;Inherit;False;FLOAT3;3;3;3;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2438;-1024,-2592;Inherit;False;FLOAT3;2;2;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2439;-1024,-2528;Inherit;False;FLOAT3;3;3;3;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2541;-384,-2656;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2433;-1024,-2848;Inherit;False;FLOAT3;3;3;3;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2542;-384,-3136;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2407;-1024,-4512;Inherit;False;FLOAT3;1;1;1;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2589;-1024,-4400;Inherit;False;FLOAT3;2;2;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2525;-5120,-4992;Inherit;False;Block Blanket Conform;105;;251649;3ce1684c4351aeb42b79a955aa483301;2,389,0,377,1;2;146;OBJECT;0,0,0,0;False;186;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2477;-128,-4608;Inherit;False;Tool Debug Index;-1;;251674;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;2;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2583;-384,-4992;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2478;-128,-4512;Inherit;False;Tool Debug Index;-1;;251675;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;3;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2588;-128,-4416;Inherit;False;Tool Debug Index;-1;;251731;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;4;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2486;-128,-4096;Inherit;False;Tool Debug Index;-1;;251732;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;6;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2487;-128,-4000;Inherit;False;Tool Debug Index;-1;;251733;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;7;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2479;-128,-3840;Inherit;False;Tool Debug Index;-1;;251734;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;9;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2480;-128,-3744;Inherit;False;Tool Debug Index;-1;;251735;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;10;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2481;-128,-3648;Inherit;False;Tool Debug Index;-1;;251736;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;11;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2482;-128,-3552;Inherit;False;Tool Debug Index;-1;;251737;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;12;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2488;-128,-3392;Inherit;False;Tool Debug Index;-1;;251738;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;14;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2489;-128,-3296;Inherit;False;Tool Debug Index;-1;;251739;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;15;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2483;-128,-3136;Inherit;False;Tool Debug Index;-1;;251740;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;17;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2484;-128,-3008;Inherit;False;Tool Debug Index;-1;;251741;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;18;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2485;-128,-2848;Inherit;False;Tool Debug Index;-1;;251742;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;19;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2474;-128,-2656;Inherit;False;Tool Debug Index;-1;;251743;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;21;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2475;-128,-2560;Inherit;False;Tool Debug Index;-1;;251744;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;22;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2476;-128,-2464;Inherit;False;Tool Debug Index;-1;;251745;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;23;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2526;-4736,-4992;Inherit;False;Block Transform;-1;;251746;5ac6202bdddd8b34a85c261af6b8de8b;0;1;146;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2397;256,-4608;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2586;-128,-4992;Inherit;False;Tool Debug Index;-1;;251757;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2379;-3584,-4992;Inherit;False;2373;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2421;256,-4096;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2420;256,-3840;Inherit;False;4;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2426;256,-3392;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2434;256,-3136;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2441;256,-2656;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2527;-4352,-4992;Inherit;False;Block Pivots Add;-1;;251758;016babe9e3e643242aa4d123a988150c;0;1;146;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2443;640,-4992;Inherit;False;7;7;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2380;-3328,-4992;Inherit;False;Block Main;80;;251762;b04cfed9a7b4c0841afdb49a38c282c5;12,65,1,136,1,41,1,133,1,40,1,329,1,344,0,347,0,342,0,345,0,346,0,343,0;1;225;OBJECT;0,0,0,0;False;1;OBJECT;106
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2528;-4032,-4992;Half;False;Model Data;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2399;832,-4992;Half;False;Final_Debug;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2505;-3008,-4992;Half;False;Visual Data;-1;True;1;0;OBJECT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2400;2048,-4992;Inherit;False;2399;Final_Debug;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2506;2048,-4864;Inherit;False;2528;Model Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2456;2048,-4928;Inherit;False;2505;Visual Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.ConditionalIfNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1774;-880,2944;Inherit;False;True;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1803;-1344,2944;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1772;-1088,3072;Float;False;Constant;_Float3;Float 3;31;0;Create;True;0;0;0;False;0;False;24;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1843;-1632,2944;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1771;-1088,2944;Inherit;False;-1;;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1800;-1472,2944;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1804;-1792,2944;Inherit;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2203;2688,-5120;Inherit;False;Base Compile;-1;;251783;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2587;2304,-4992;Inherit;False;Tool Debug Color;0;;251784;d992d3ed4a7539141ba053d3e0c12277;0;3;80;FLOAT3;0,0,0;False;106;OBJECT;0,0,0;False;107;OBJECT;0,0,0;False;5;FLOAT;114;FLOAT3;0;FLOAT3;113;FLOAT3;148;FLOAT4;149
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2442;-864,-2656;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;0.5;False;2;FLOAT;0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GammaToLinearNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2540;-384,-2976;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FractNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2529;-608,-3040;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2353;2304,-5008;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;15;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ExtraPrePass;0;0;ExtraPrePass;5;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2354;2688,-5008;Float;False;True;-1;3;;0;3;Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Global;28cd5599e02859647ae1798e4fcaef6c;True;ForwardBase;0;1;ForwardBase;15;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;40;Category;0;0;Workflow;0;638874882197810641;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;0;638874603607655403;Deferred Pass;1;0;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;638814711411603618;Receive Shadows;0;638814711415148256;Receive Specular;0;638814711419031593;GPU Instancing;1;638874881145939632;LOD CrossFade;0;638814711429956434;Built-in Fog;0;638814711441065168;Ambient Light;0;638814711449050123;Meta Pass;0;638814711456998358;Add Pass;0;638814711466594157;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;638874882298697380;Vertex Position;0;638874601191422915;0;8;False;True;False;True;False;False;True;True;False;;True;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2546;2688,-4948;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;15;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2547;2688,-5008;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;15;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ScenePickingPass;0;7;ScenePickingPass;1;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=ScenePickingPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2355;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;15;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2356;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;15;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2357;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;15;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2358;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;15;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
WireConnection;2544;0;2543;0
WireConnection;2549;0;2563;145
WireConnection;2570;0;2582;148
WireConnection;2550;0;2563;145
WireConnection;2552;0;2559;0
WireConnection;2552;1;2549;0
WireConnection;2545;33;2372;314
WireConnection;2545;27;2372;314
WireConnection;2545;28;2372;314
WireConnection;2545;29;2372;314
WireConnection;2545;30;2492;314
WireConnection;2545;31;2497;0
WireConnection;2568;0;2581;0
WireConnection;2568;1;2570;0
WireConnection;2571;0;2582;148
WireConnection;2553;0;2552;0
WireConnection;2553;1;2550;0
WireConnection;2373;0;2545;0
WireConnection;2577;0;2568;0
WireConnection;2577;1;2571;0
WireConnection;2554;0;2553;0
WireConnection;2491;33;2372;128
WireConnection;2491;27;2372;128
WireConnection;2491;28;2372;128
WireConnection;2491;29;2372;128
WireConnection;2491;30;2492;128
WireConnection;2491;31;2497;0
WireConnection;2573;0;2577;0
WireConnection;2557;6;2554;0
WireConnection;2557;8;2563;150
WireConnection;2377;0;2491;0
WireConnection;2560;206;2519;0
WireConnection;2561;206;2374;0
WireConnection;2574;6;2573;0
WireConnection;2558;0;2557;0
WireConnection;2435;0;2419;24
WireConnection;2427;0;2419;18
WireConnection;2521;0;2560;151
WireConnection;2419;6;2561;151
WireConnection;2578;0;2574;0
WireConnection;2428;0;2419;18
WireConnection;2536;0;2427;0
WireConnection;2501;0;2435;0
WireConnection;2523;146;2522;0
WireConnection;2567;0;2564;0
WireConnection;2567;1;2565;0
WireConnection;2567;2;2566;0
WireConnection;2406;0;2419;27
WireConnection;2537;0;2428;0
WireConnection;2537;1;2539;0
WireConnection;2408;0;2419;0
WireConnection;2409;0;2419;0
WireConnection;2411;0;2419;16
WireConnection;2412;0;2419;16
WireConnection;2415;0;2419;16
WireConnection;2416;0;2419;16
WireConnection;2424;0;2419;19
WireConnection;2425;0;2419;19
WireConnection;2438;0;2419;24
WireConnection;2439;0;2419;24
WireConnection;2541;0;2501;0
WireConnection;2541;1;2501;0
WireConnection;2433;0;2419;18
WireConnection;2542;0;2536;0
WireConnection;2542;1;2536;0
WireConnection;2407;0;2419;27
WireConnection;2589;0;2419;27
WireConnection;2525;146;2523;128
WireConnection;2525;186;2524;0
WireConnection;2477;39;2406;0
WireConnection;2583;0;2584;0
WireConnection;2583;1;2567;0
WireConnection;2583;2;2585;0
WireConnection;2478;39;2407;0
WireConnection;2588;39;2589;0
WireConnection;2486;39;2408;0
WireConnection;2487;39;2409;0
WireConnection;2479;39;2411;0
WireConnection;2480;39;2412;0
WireConnection;2481;39;2415;0
WireConnection;2482;39;2416;0
WireConnection;2488;39;2424;0
WireConnection;2489;39;2425;0
WireConnection;2483;39;2542;0
WireConnection;2484;39;2537;0
WireConnection;2485;39;2433;0
WireConnection;2474;39;2541;0
WireConnection;2475;39;2438;0
WireConnection;2476;39;2439;0
WireConnection;2526;146;2525;128
WireConnection;2397;0;2477;0
WireConnection;2397;1;2478;0
WireConnection;2397;2;2588;0
WireConnection;2586;39;2583;0
WireConnection;2421;0;2486;0
WireConnection;2421;1;2487;0
WireConnection;2420;0;2479;0
WireConnection;2420;1;2480;0
WireConnection;2420;2;2481;0
WireConnection;2420;3;2482;0
WireConnection;2426;0;2488;0
WireConnection;2426;1;2489;0
WireConnection;2434;0;2483;0
WireConnection;2434;1;2484;0
WireConnection;2434;2;2485;0
WireConnection;2441;0;2474;0
WireConnection;2441;1;2475;0
WireConnection;2441;2;2476;0
WireConnection;2527;146;2526;128
WireConnection;2443;0;2586;0
WireConnection;2443;1;2397;0
WireConnection;2443;2;2421;0
WireConnection;2443;3;2420;0
WireConnection;2443;4;2426;0
WireConnection;2443;5;2434;0
WireConnection;2443;6;2441;0
WireConnection;2380;225;2379;0
WireConnection;2528;0;2527;128
WireConnection;2399;0;2443;0
WireConnection;2505;0;2380;106
WireConnection;1774;0;1771;0
WireConnection;1774;1;1772;0
WireConnection;1774;3;1803;0
WireConnection;1803;0;1800;0
WireConnection;1843;0;1804;0
WireConnection;1800;0;1843;0
WireConnection;2587;80;2400;0
WireConnection;2587;106;2456;0
WireConnection;2587;107;2506;0
WireConnection;2442;0;2435;0
WireConnection;2540;0;2537;0
WireConnection;2529;0;2537;0
WireConnection;2354;0;2587;114
WireConnection;2354;3;2587;114
WireConnection;2354;5;2587;114
WireConnection;2354;2;2587;0
WireConnection;2354;15;2587;113
ASEEND*/
//CHKSM=1345E107A3F9E588B2420F08F2C5BADA988065CA