// Made with Amplify Shader Editor v1.9.9.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Flatten"
{
	Properties
	{
		_RenderClip( "_RenderClip", Float ) = 0
		_IsElementShader( "_IsElementShader", Float ) = 0
		_IsHelperShader( "_IsHelperShader", Float ) = 0
		_FlattenIntensityValue( "Flatten Intensity", Range( 0, 1 ) ) = 0
		_FlattenSphereValue( "Flatten Spherical", Range( 0, 1 ) ) = 0
		[StyledVector(18)] _FlattenSphereOffsetValue( "Flatten Spherical Offset", Vector ) = ( 0, 0, 0, 0 )
		[Space(10)] _FlattenMeshValue( "Flatten Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _FlattenMeshMode( "Flatten Mesh Mask", Float ) = 2
		[StyledRemapSlider] _FlattenMeshRemap( "Flatten Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[HideInInspector] _IsTVEShader( "_IsTVEShader", Float ) = 0
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
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_COLOR
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_vertex TVE_FLATTEN
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
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
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
					float4 ase_texcoord9 : TEXCOORD9;
					float4 ase_texcoord10 : TEXCOORD10;
					float4 ase_color : COLOR;
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
				uniform half _FlattenIntensityValue;
				uniform half _FlattenMeshMode;
				uniform half4 _FlattenMeshRemap;
				uniform half _FlattenMeshValue;
				uniform half3 _FlattenSphereOffsetValue;
				uniform half _FlattenSphereValue;
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
				
				float3 ASESafeNormalize(float3 inVec)
				{
					float dp3 = max(1.175494351e-38, dot(inVec, inVec));
					return inVec* rsqrt(dp3);
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

					float localIfModelDataByShader26_g242169 = ( 0.0 );
					TVEModelData Data26_g242169 = (TVEModelData)0;
					TVEModelData Data16_g242159 =(TVEModelData)0;
					half Dummy207_g242149 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g242159 = Dummy207_g242149;
					float In_Dummy16_g242159 = temp_output_14_0_g242159;
					float3 PositionOS131_g242149 = v.vertex.xyz;
					float3 temp_output_4_0_g242159 = PositionOS131_g242149;
					float3 In_PositionOS16_g242159 = temp_output_4_0_g242159;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g242149 = ase_positionWS;
					float3 vertexToFrag73_g242149 = temp_output_104_7_g242149;
					float3 PositionWS122_g242149 = vertexToFrag73_g242149;
					float3 In_PositionWS16_g242159 = PositionWS122_g242149;
					float4x4 break19_g242152 = unity_ObjectToWorld;
					float3 appendResult20_g242152 = (float3(break19_g242152[ 0 ][ 3 ] , break19_g242152[ 1 ][ 3 ] , break19_g242152[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242149 = appendResult20_g242152;
					float4x4 break19_g242154 = unity_ObjectToWorld;
					float3 appendResult20_g242154 = (float3(break19_g242154[ 0 ][ 3 ] , break19_g242154[ 1 ][ 3 ] , break19_g242154[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g242150 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g242149 = PositionOS131_g242149;
					float3 appendResult234_g242149 = (float3(break233_g242149.x , 0.0 , break233_g242149.z));
					float3 break413_g242149 = PositionOS131_g242149;
					float3 appendResult414_g242149 = (float3(break413_g242149.x , break413_g242149.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g242156 = appendResult414_g242149;
					#else
					float3 staticSwitch65_g242156 = appendResult234_g242149;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g242149 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g242149 = appendResult60_g242150;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g242149 = staticSwitch65_g242156;
					#else
					float3 staticSwitch229_g242149 = _Vector0;
					#endif
					float3 PivotOS149_g242149 = staticSwitch229_g242149;
					float3 temp_output_122_0_g242154 = PivotOS149_g242149;
					float3 PivotsOnlyWS105_g242154 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g242154 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g242149 = ( appendResult20_g242154 + PivotsOnlyWS105_g242154 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g242149 = temp_output_340_7_g242149;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g242149 = temp_output_341_7_g242149;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g242149 = temp_output_341_7_g242149;
					#else
					float3 staticSwitch236_g242149 = temp_output_340_7_g242149;
					#endif
					float3 vertexToFrag76_g242149 = staticSwitch236_g242149;
					float3 PivotWS121_g242149 = vertexToFrag76_g242149;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242149 = ( PositionWS122_g242149 - PivotWS121_g242149 );
					#else
					float3 staticSwitch204_g242149 = PositionWS122_g242149;
					#endif
					float3 PositionWO132_g242149 = ( staticSwitch204_g242149 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242159 = PositionWO132_g242149;
					float3 In_PositionRawOS16_g242159 = PositionOS131_g242149;
					float3 In_PivotOS16_g242159 = PivotOS149_g242149;
					float3 In_PivotWS16_g242159 = PivotWS121_g242149;
					float3 PivotWO133_g242149 = ( PivotWS121_g242149 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242159 = PivotWO133_g242149;
					half3 NormalOS134_g242149 = v.normal;
					float3 temp_output_21_0_g242159 = NormalOS134_g242149;
					float3 In_NormalOS16_g242159 = temp_output_21_0_g242159;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g242149 = normalizedWorldNormal;
					float3 In_NormalWS16_g242159 = NormalWS95_g242149;
					float3 In_NormalRawOS16_g242159 = NormalOS134_g242149;
					half4 TangentlOS153_g242149 = v.tangent;
					float4 temp_output_6_0_g242159 = TangentlOS153_g242149;
					float4 In_TangentOS16_g242159 = temp_output_6_0_g242159;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g242149 = ase_tangentWS;
					float3 In_TangentWS16_g242159 = TangentWS136_g242149;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g242149 = ase_bitangentWS;
					float3 In_BitangentWS16_g242159 = BiangentWS421_g242149;
					float3 normalizeResult296_g242149 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242149 ) );
					half3 ViewDirWS169_g242149 = normalizeResult296_g242149;
					float3 In_ViewDirWS16_g242159 = ViewDirWS169_g242149;
					float4 appendResult397_g242149 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g242149 = appendResult397_g242149;
					float4 In_CoordsData16_g242159 = CoordsData398_g242149;
					half4 VertexMasks171_g242149 = v.ase_color;
					float4 In_VertexData16_g242159 = VertexMasks171_g242149;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g242162 = (PositionOS131_g242149).z;
					#else
					float staticSwitch65_g242162 = (PositionOS131_g242149).y;
					#endif
					half Object_HeightValue267_g242149 = _ObjectHeightValue;
					half Bounds_HeightMask274_g242149 = saturate( ( staticSwitch65_g242162 / Object_HeightValue267_g242149 ) );
					half3 Position387_g242149 = PositionOS131_g242149;
					half Height387_g242149 = Object_HeightValue267_g242149;
					half Object_RadiusValue268_g242149 = _ObjectRadiusValue;
					half Radius387_g242149 = Object_RadiusValue268_g242149;
					half localCapsuleMaskYUp387_g242149 = CapsuleMaskYUp( Position387_g242149 , Height387_g242149 , Radius387_g242149 );
					half3 Position408_g242149 = PositionOS131_g242149;
					half Height408_g242149 = Object_HeightValue267_g242149;
					half Radius408_g242149 = Object_RadiusValue268_g242149;
					half localCapsuleMaskZUp408_g242149 = CapsuleMaskZUp( Position408_g242149 , Height408_g242149 , Radius408_g242149 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g242167 = saturate( localCapsuleMaskZUp408_g242149 );
					#else
					float staticSwitch65_g242167 = saturate( localCapsuleMaskYUp387_g242149 );
					#endif
					half Bounds_SphereMask282_g242149 = staticSwitch65_g242167;
					float4 appendResult253_g242149 = (float4(Bounds_HeightMask274_g242149 , Bounds_SphereMask282_g242149 , 1.0 , 1.0));
					half4 MasksData254_g242149 = appendResult253_g242149;
					float4 In_MasksData16_g242159 = MasksData254_g242149;
					float temp_output_17_0_g242161 = _ObjectPhaseMode;
					float Option70_g242161 = temp_output_17_0_g242161;
					float4 temp_output_3_0_g242161 = v.ase_color;
					float4 Channel70_g242161 = temp_output_3_0_g242161;
					float localSwitchChannel470_g242161 = SwitchChannel4( Option70_g242161 , Channel70_g242161 );
					half Phase_Value372_g242149 = localSwitchChannel470_g242161;
					float3 break319_g242149 = PivotWO133_g242149;
					half Pivot_Position322_g242149 = ( break319_g242149.x + break319_g242149.z );
					half Phase_Position357_g242149 = ( Phase_Value372_g242149 + Pivot_Position322_g242149 );
					float temp_output_248_0_g242149 = frac( Phase_Position357_g242149 );
					float4 appendResult177_g242149 = (float4(( (frac( ( Phase_Position357_g242149 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g242149));
					half4 Phase_Data176_g242149 = appendResult177_g242149;
					float4 In_PhaseData16_g242159 = Phase_Data176_g242149;
					float4 In_TransformData16_g242159 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g242159 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g242159 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g242159 , In_Dummy16_g242159 , In_PositionOS16_g242159 , In_PositionWS16_g242159 , In_PositionWO16_g242159 , In_PositionRawOS16_g242159 , In_PivotOS16_g242159 , In_PivotWS16_g242159 , In_PivotWO16_g242159 , In_NormalOS16_g242159 , In_NormalWS16_g242159 , In_NormalRawOS16_g242159 , In_TangentOS16_g242159 , In_TangentWS16_g242159 , In_BitangentWS16_g242159 , In_ViewDirWS16_g242159 , In_CoordsData16_g242159 , In_VertexData16_g242159 , In_MasksData16_g242159 , In_PhaseData16_g242159 , In_TransformData16_g242159 , In_RotationData16_g242159 , In_InterpolatorA16_g242159 );
					TVEModelData DataDefault26_g242169 = Data16_g242159;
					TVEModelData DataGeneral26_g242169 = Data16_g242159;
					TVEModelData DataBlanket26_g242169 = Data16_g242159;
					TVEModelData DataImpostor26_g242169 = Data16_g242159;
					TVEModelData Data16_g242139 =(TVEModelData)0;
					half Dummy207_g242129 = 0.0;
					float temp_output_14_0_g242139 = Dummy207_g242129;
					float In_Dummy16_g242139 = temp_output_14_0_g242139;
					float3 PositionOS131_g242129 = v.vertex.xyz;
					float3 temp_output_4_0_g242139 = PositionOS131_g242129;
					float3 In_PositionOS16_g242139 = temp_output_4_0_g242139;
					float3 temp_output_104_7_g242129 = ase_positionWS;
					float3 PositionWS122_g242129 = temp_output_104_7_g242129;
					float3 In_PositionWS16_g242139 = PositionWS122_g242129;
					float4x4 break19_g242132 = unity_ObjectToWorld;
					float3 appendResult20_g242132 = (float3(break19_g242132[ 0 ][ 3 ] , break19_g242132[ 1 ][ 3 ] , break19_g242132[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242129 = appendResult20_g242132;
					float3 PivotWS121_g242129 = temp_output_340_7_g242129;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242129 = ( PositionWS122_g242129 - PivotWS121_g242129 );
					#else
					float3 staticSwitch204_g242129 = PositionWS122_g242129;
					#endif
					float3 PositionWO132_g242129 = ( staticSwitch204_g242129 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242139 = PositionWO132_g242129;
					float3 In_PositionRawOS16_g242139 = PositionOS131_g242129;
					float3 PivotOS149_g242129 = _Vector0;
					float3 In_PivotOS16_g242139 = PivotOS149_g242129;
					float3 In_PivotWS16_g242139 = PivotWS121_g242129;
					float3 PivotWO133_g242129 = ( PivotWS121_g242129 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242139 = PivotWO133_g242129;
					half3 NormalOS134_g242129 = v.normal;
					float3 temp_output_21_0_g242139 = NormalOS134_g242129;
					float3 In_NormalOS16_g242139 = temp_output_21_0_g242139;
					half3 NormalWS95_g242129 = normalizedWorldNormal;
					float3 In_NormalWS16_g242139 = NormalWS95_g242129;
					float3 In_NormalRawOS16_g242139 = NormalOS134_g242129;
					half4 TangentlOS153_g242129 = v.tangent;
					float4 temp_output_6_0_g242139 = TangentlOS153_g242129;
					float4 In_TangentOS16_g242139 = temp_output_6_0_g242139;
					half3 TangentWS136_g242129 = ase_tangentWS;
					float3 In_TangentWS16_g242139 = TangentWS136_g242129;
					half3 BiangentWS421_g242129 = ase_bitangentWS;
					float3 In_BitangentWS16_g242139 = BiangentWS421_g242129;
					float3 normalizeResult296_g242129 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242129 ) );
					half3 ViewDirWS169_g242129 = normalizeResult296_g242129;
					float3 In_ViewDirWS16_g242139 = ViewDirWS169_g242129;
					float4 appendResult397_g242129 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g242129 = appendResult397_g242129;
					float4 In_CoordsData16_g242139 = CoordsData398_g242129;
					half4 VertexMasks171_g242129 = float4( 0,0,0,0 );
					float4 In_VertexData16_g242139 = VertexMasks171_g242129;
					half4 MasksData254_g242129 = float4( 0,0,0,0 );
					float4 In_MasksData16_g242139 = MasksData254_g242129;
					half4 Phase_Data176_g242129 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g242139 = Phase_Data176_g242129;
					float4 In_TransformData16_g242139 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g242139 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g242139 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g242139 , In_Dummy16_g242139 , In_PositionOS16_g242139 , In_PositionWS16_g242139 , In_PositionWO16_g242139 , In_PositionRawOS16_g242139 , In_PivotOS16_g242139 , In_PivotWS16_g242139 , In_PivotWO16_g242139 , In_NormalOS16_g242139 , In_NormalWS16_g242139 , In_NormalRawOS16_g242139 , In_TangentOS16_g242139 , In_TangentWS16_g242139 , In_BitangentWS16_g242139 , In_ViewDirWS16_g242139 , In_CoordsData16_g242139 , In_VertexData16_g242139 , In_MasksData16_g242139 , In_PhaseData16_g242139 , In_TransformData16_g242139 , In_RotationData16_g242139 , In_InterpolatorA16_g242139 );
					TVEModelData DataTerrain26_g242169 = Data16_g242139;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g242169 = IsShaderType2637;
					{
					if (Type26_g242169 == 0 )
					{
					Data26_g242169 = DataDefault26_g242169;
					}
					else if (Type26_g242169 == 1 )
					{
					Data26_g242169 = DataGeneral26_g242169;
					}
					else if (Type26_g242169 == 2 )
					{
					Data26_g242169 = DataBlanket26_g242169;
					}
					else if (Type26_g242169 == 3 )
					{
					Data26_g242169 = DataImpostor26_g242169;
					}
					else if (Type26_g242169 == 4 )
					{
					Data26_g242169 = DataTerrain26_g242169;
					}
					}
					TVEModelData Data15_g242422 =(TVEModelData)Data26_g242169;
					float Out_Dummy15_g242422 = 0.0;
					float3 Out_PositionOS15_g242422 = float3( 0,0,0 );
					float3 Out_PositionWS15_g242422 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242422 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g242422 = float3( 0,0,0 );
					float3 Out_PivotOS15_g242422 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242422 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242422 = float3( 0,0,0 );
					float3 Out_NormalOS15_g242422 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242422 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g242422 = float3( 0,0,0 );
					float4 Out_TangentOS15_g242422 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g242422 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242422 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242422 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242422 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242422 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g242422 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g242422 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g242422 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g242422 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g242422 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g242422 , Out_Dummy15_g242422 , Out_PositionOS15_g242422 , Out_PositionWS15_g242422 , Out_PositionWO15_g242422 , Out_PositionRawOS15_g242422 , Out_PivotOS15_g242422 , Out_PivotWS15_g242422 , Out_PivotWO15_g242422 , Out_NormalOS15_g242422 , Out_NormalWS15_g242422 , Out_NormalRawOS15_g242422 , Out_TangentOS15_g242422 , Out_TangentWS15_g242422 , Out_BitangentWS15_g242422 , Out_ViewDirWS15_g242422 , Out_CoordsData15_g242422 , Out_VertexData15_g242422 , Out_MasksData15_g242422 , Out_PhaseData15_g242422 , Out_TransformData15_g242422 , Out_RotationData15_g242422 , Out_InterpolatorA15_g242422 );
					TVEModelData Data16_g242424 =(TVEModelData)Data15_g242422;
					float temp_output_14_0_g242424 = 0.0;
					float In_Dummy16_g242424 = temp_output_14_0_g242424;
					float3 temp_output_219_24_g242421 = Out_PivotOS15_g242422;
					float3 temp_output_215_0_g242421 = ( Out_PositionOS15_g242422 - temp_output_219_24_g242421 );
					float3 temp_output_4_0_g242424 = temp_output_215_0_g242421;
					float3 In_PositionOS16_g242424 = temp_output_4_0_g242424;
					float3 In_PositionWS16_g242424 = Out_PositionWS15_g242422;
					float3 In_PositionWO16_g242424 = Out_PositionWO15_g242422;
					float3 In_PositionRawOS16_g242424 = Out_PositionRawOS15_g242422;
					float3 In_PivotOS16_g242424 = temp_output_219_24_g242421;
					float3 In_PivotWS16_g242424 = Out_PivotWS15_g242422;
					float3 In_PivotWO16_g242424 = Out_PivotWO15_g242422;
					float3 temp_output_21_0_g242424 = Out_NormalOS15_g242422;
					float3 In_NormalOS16_g242424 = temp_output_21_0_g242424;
					float3 In_NormalWS16_g242424 = Out_NormalWS15_g242422;
					float3 In_NormalRawOS16_g242424 = Out_NormalRawOS15_g242422;
					float4 temp_output_6_0_g242424 = Out_TangentOS15_g242422;
					float4 In_TangentOS16_g242424 = temp_output_6_0_g242424;
					float3 In_TangentWS16_g242424 = Out_TangentWS15_g242422;
					float3 In_BitangentWS16_g242424 = Out_BitangentWS15_g242422;
					float3 In_ViewDirWS16_g242424 = Out_ViewDirWS15_g242422;
					float4 In_CoordsData16_g242424 = Out_CoordsData15_g242422;
					float4 In_VertexData16_g242424 = Out_VertexData15_g242422;
					float4 In_MasksData16_g242424 = Out_MasksData15_g242422;
					float4 In_PhaseData16_g242424 = Out_PhaseData15_g242422;
					float4 In_TransformData16_g242424 = Out_TransformData15_g242422;
					float4 In_RotationData16_g242424 = Out_RotationData15_g242422;
					float4 In_InterpolatorA16_g242424 = Out_InterpolatorA15_g242422;
					BuildModelVertData( Data16_g242424 , In_Dummy16_g242424 , In_PositionOS16_g242424 , In_PositionWS16_g242424 , In_PositionWO16_g242424 , In_PositionRawOS16_g242424 , In_PivotOS16_g242424 , In_PivotWS16_g242424 , In_PivotWO16_g242424 , In_NormalOS16_g242424 , In_NormalWS16_g242424 , In_NormalRawOS16_g242424 , In_TangentOS16_g242424 , In_TangentWS16_g242424 , In_BitangentWS16_g242424 , In_ViewDirWS16_g242424 , In_CoordsData16_g242424 , In_VertexData16_g242424 , In_MasksData16_g242424 , In_PhaseData16_g242424 , In_TransformData16_g242424 , In_RotationData16_g242424 , In_InterpolatorA16_g242424 );
					TVEModelData Data15_g242428 =(TVEModelData)Data16_g242424;
					float Out_Dummy15_g242428 = 0.0;
					float3 Out_PositionOS15_g242428 = float3( 0,0,0 );
					float3 Out_PositionWS15_g242428 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242428 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g242428 = float3( 0,0,0 );
					float3 Out_PivotOS15_g242428 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242428 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242428 = float3( 0,0,0 );
					float3 Out_NormalOS15_g242428 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242428 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g242428 = float3( 0,0,0 );
					float4 Out_TangentOS15_g242428 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g242428 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242428 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242428 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242428 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242428 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g242428 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g242428 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g242428 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g242428 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g242428 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g242428 , Out_Dummy15_g242428 , Out_PositionOS15_g242428 , Out_PositionWS15_g242428 , Out_PositionWO15_g242428 , Out_PositionRawOS15_g242428 , Out_PivotOS15_g242428 , Out_PivotWS15_g242428 , Out_PivotWO15_g242428 , Out_NormalOS15_g242428 , Out_NormalWS15_g242428 , Out_NormalRawOS15_g242428 , Out_TangentOS15_g242428 , Out_TangentWS15_g242428 , Out_BitangentWS15_g242428 , Out_ViewDirWS15_g242428 , Out_CoordsData15_g242428 , Out_VertexData15_g242428 , Out_MasksData15_g242428 , Out_PhaseData15_g242428 , Out_TransformData15_g242428 , Out_RotationData15_g242428 , Out_InterpolatorA15_g242428 );
					TVEModelData Data16_g242429 =(TVEModelData)Data15_g242428;
					half Dummy317_g242427 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g242429 = Dummy317_g242427;
					float In_Dummy16_g242429 = temp_output_14_0_g242429;
					float3 temp_output_4_0_g242429 = Out_PositionOS15_g242428;
					float3 In_PositionOS16_g242429 = temp_output_4_0_g242429;
					float3 In_PositionWS16_g242429 = Out_PositionWS15_g242428;
					float3 temp_output_314_17_g242427 = Out_PositionWO15_g242428;
					float3 In_PositionWO16_g242429 = temp_output_314_17_g242427;
					float3 In_PositionRawOS16_g242429 = Out_PositionRawOS15_g242428;
					float3 In_PivotOS16_g242429 = Out_PivotOS15_g242428;
					float3 In_PivotWS16_g242429 = Out_PivotWS15_g242428;
					float3 temp_output_314_19_g242427 = Out_PivotWO15_g242428;
					float3 In_PivotWO16_g242429 = temp_output_314_19_g242427;
					float3 temp_output_21_0_g242429 = Out_NormalOS15_g242428;
					float3 In_NormalOS16_g242429 = temp_output_21_0_g242429;
					float3 In_NormalWS16_g242429 = Out_NormalWS15_g242428;
					float3 In_NormalRawOS16_g242429 = Out_NormalRawOS15_g242428;
					float4 temp_output_6_0_g242429 = Out_TangentOS15_g242428;
					float4 In_TangentOS16_g242429 = temp_output_6_0_g242429;
					float3 In_TangentWS16_g242429 = Out_TangentWS15_g242428;
					float3 In_BitangentWS16_g242429 = Out_BitangentWS15_g242428;
					float3 In_ViewDirWS16_g242429 = Out_ViewDirWS15_g242428;
					float4 In_CoordsData16_g242429 = Out_CoordsData15_g242428;
					float4 temp_output_314_29_g242427 = Out_VertexData15_g242428;
					float4 In_VertexData16_g242429 = temp_output_314_29_g242427;
					float4 In_MasksData16_g242429 = Out_MasksData15_g242428;
					float4 In_PhaseData16_g242429 = Out_PhaseData15_g242428;
					half4 Model_TransformData356_g242427 = Out_TransformData15_g242428;
					float localBuildGlobalData204_g242340 = ( 0.0 );
					TVEGlobalData Data204_g242340 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g242340 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g242340 = Dummy211_g242340;
					float4 temp_output_589_164_g242340 = TVE_CoatParams;
					half4 Coat_Params596_g242340 = temp_output_589_164_g242340;
					float4 In_CoatParams204_g242340 = Coat_Params596_g242340;
					float4 temp_output_203_0_g242360 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g242420 = ( 0.0 );
					TVEModelData Data26_g242420 = (TVEModelData)0;
					TVEModelData Data16_g242157 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g242157 = 0.0;
					float3 In_PositionWS16_g242157 = PositionWS122_g242149;
					float3 In_PositionWO16_g242157 = PositionWO132_g242149;
					float3 In_PivotWS16_g242157 = PivotWS121_g242149;
					float3 In_PivotWO16_g242157 = PivotWO133_g242149;
					float3 In_NormalWS16_g242157 = NormalWS95_g242149;
					float3 In_TangentWS16_g242157 = TangentWS136_g242149;
					float3 In_BitangentWS16_g242157 = BiangentWS421_g242149;
					half3 NormalWS427_g242149 = NormalWS95_g242149;
					half3 localComputeTriplanarWeights427_g242149 = ComputeTriplanarWeights( NormalWS427_g242149 );
					half3 TriplanarWeights429_g242149 = localComputeTriplanarWeights427_g242149;
					float3 In_TriplanarWeights16_g242157 = TriplanarWeights429_g242149;
					float3 In_ViewDirWS16_g242157 = ViewDirWS169_g242149;
					float4 In_CoordsData16_g242157 = CoordsData398_g242149;
					float4 In_VertexData16_g242157 = VertexMasks171_g242149;
					float4 In_PhaseData16_g242157 = Phase_Data176_g242149;
					BuildModelFragData( Data16_g242157 , In_Dummy16_g242157 , In_PositionWS16_g242157 , In_PositionWO16_g242157 , In_PivotWS16_g242157 , In_PivotWO16_g242157 , In_NormalWS16_g242157 , In_TangentWS16_g242157 , In_BitangentWS16_g242157 , In_TriplanarWeights16_g242157 , In_ViewDirWS16_g242157 , In_CoordsData16_g242157 , In_VertexData16_g242157 , In_PhaseData16_g242157 );
					TVEModelData DataDefault26_g242420 = Data16_g242157;
					TVEModelData DataGeneral26_g242420 = Data16_g242157;
					TVEModelData DataBlanket26_g242420 = Data16_g242157;
					TVEModelData DataImpostor26_g242420 = Data16_g242157;
					TVEModelData Data16_g242137 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g242137 = 0.0;
					float3 In_PositionWS16_g242137 = PositionWS122_g242129;
					float3 In_PositionWO16_g242137 = PositionWO132_g242129;
					float3 In_PivotWS16_g242137 = PivotWS121_g242129;
					float3 In_PivotWO16_g242137 = PivotWO133_g242129;
					float3 In_NormalWS16_g242137 = NormalWS95_g242129;
					float3 In_TangentWS16_g242137 = TangentWS136_g242129;
					float3 In_BitangentWS16_g242137 = BiangentWS421_g242129;
					half3 NormalWS427_g242129 = NormalWS95_g242129;
					half3 localComputeTriplanarWeights427_g242129 = ComputeTriplanarWeights( NormalWS427_g242129 );
					half3 TriplanarWeights429_g242129 = localComputeTriplanarWeights427_g242129;
					float3 In_TriplanarWeights16_g242137 = TriplanarWeights429_g242129;
					float3 In_ViewDirWS16_g242137 = ViewDirWS169_g242129;
					float4 In_CoordsData16_g242137 = CoordsData398_g242129;
					float4 In_VertexData16_g242137 = VertexMasks171_g242129;
					float4 In_PhaseData16_g242137 = Phase_Data176_g242129;
					BuildModelFragData( Data16_g242137 , In_Dummy16_g242137 , In_PositionWS16_g242137 , In_PositionWO16_g242137 , In_PivotWS16_g242137 , In_PivotWO16_g242137 , In_NormalWS16_g242137 , In_TangentWS16_g242137 , In_BitangentWS16_g242137 , In_TriplanarWeights16_g242137 , In_ViewDirWS16_g242137 , In_CoordsData16_g242137 , In_VertexData16_g242137 , In_PhaseData16_g242137 );
					TVEModelData DataTerrain26_g242420 = Data16_g242137;
					float Type26_g242420 = IsShaderType2637;
					{
					if (Type26_g242420 == 0 )
					{
					Data26_g242420 = DataDefault26_g242420;
					}
					else if (Type26_g242420 == 1 )
					{
					Data26_g242420 = DataGeneral26_g242420;
					}
					else if (Type26_g242420 == 2 )
					{
					Data26_g242420 = DataBlanket26_g242420;
					}
					else if (Type26_g242420 == 3 )
					{
					Data26_g242420 = DataImpostor26_g242420;
					}
					else if (Type26_g242420 == 4 )
					{
					Data26_g242420 = DataTerrain26_g242420;
					}
					}
					TVEModelData Data15_g242416 =(TVEModelData)Data26_g242420;
					float Out_Dummy15_g242416 = 0.0;
					float3 Out_PositionWS15_g242416 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242416 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242416 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242416 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242416 = float3( 0,0,0 );
					float3 Out_TangentWS15_g242416 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242416 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g242416 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242416 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242416 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242416 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g242416 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g242416 , Out_Dummy15_g242416 , Out_PositionWS15_g242416 , Out_PositionWO15_g242416 , Out_PivotWS15_g242416 , Out_PivotWO15_g242416 , Out_NormalWS15_g242416 , Out_TangentWS15_g242416 , Out_BitangentWS15_g242416 , Out_TriplanarWeights15_g242416 , Out_ViewDirWS15_g242416 , Out_CoordsData15_g242416 , Out_VertexData15_g242416 , Out_PhaseData15_g242416 );
					float3 Model_PositionWS497_g242340 = Out_PositionWS15_g242416;
					float2 Model_PositionWS_XZ143_g242340 = (Model_PositionWS497_g242340).xz;
					float3 Model_PivotWS498_g242340 = Out_PivotWS15_g242416;
					float2 Model_PivotWS_XZ145_g242340 = (Model_PivotWS498_g242340).xz;
					float2 lerpResult300_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g242360 = lerpResult300_g242340;
					float temp_output_82_0_g242358 = _GlobalCoatLayerValue;
					float temp_output_82_0_g242360 = temp_output_82_0_g242358;
					float4 tex2DArrayNode83_g242360 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242360).zw + ( (temp_output_203_0_g242360).xy * temp_output_81_0_g242360 ) ),temp_output_82_0_g242360), 0.0 );
					float4 appendResult210_g242360 = (float4(tex2DArrayNode83_g242360.rgb , saturate( tex2DArrayNode83_g242360.a )));
					float4 temp_output_204_0_g242360 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g242360 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242360).zw + ( (temp_output_204_0_g242360).xy * temp_output_81_0_g242360 ) ),temp_output_82_0_g242360), 0.0 );
					float4 appendResult212_g242360 = (float4(tex2DArrayNode122_g242360.rgb , saturate( tex2DArrayNode122_g242360.a )));
					float4 TVE_RenderNearPositionR628_g242340 = TVE_RenderNearPositionR;
					float temp_output_507_0_g242340 = saturate( ( distance( Model_PositionWS497_g242340 , (TVE_RenderNearPositionR628_g242340).xyz ) / (TVE_RenderNearPositionR628_g242340).w ) );
					float temp_output_7_0_g242341 = 1.0;
					float temp_output_9_0_g242341 = ( temp_output_507_0_g242340 - temp_output_7_0_g242341 );
					half TVE_RenderNearFadeValue635_g242340 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g242340 = saturate( ( temp_output_9_0_g242341 / ( ( TVE_RenderNearFadeValue635_g242340 - temp_output_7_0_g242341 ) + 0.0001 ) ) );
					float4 lerpResult131_g242360 = lerp( appendResult210_g242360 , appendResult212_g242360 , Global_TexBlend509_g242340);
					float4 temp_output_159_109_g242358 = lerpResult131_g242360;
					float4 lerpResult168_g242358 = lerp( TVE_CoatParams , temp_output_159_109_g242358 , TVE_CoatLayers[(int)temp_output_82_0_g242358]);
					float4 temp_output_589_109_g242340 = lerpResult168_g242358;
					half4 Coat_Texture302_g242340 = temp_output_589_109_g242340;
					float4 In_CoatTexture204_g242340 = Coat_Texture302_g242340;
					float4 temp_output_595_164_g242340 = TVE_PaintParams;
					half4 Paint_Params575_g242340 = temp_output_595_164_g242340;
					float4 In_PaintParams204_g242340 = Paint_Params575_g242340;
					float4 temp_output_203_0_g242409 = TVE_PaintBaseCoord;
					float2 lerpResult85_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g242409 = lerpResult85_g242340;
					float temp_output_82_0_g242406 = _GlobalPaintLayerValue;
					float temp_output_82_0_g242409 = temp_output_82_0_g242406;
					float4 tex2DArrayNode83_g242409 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242409).zw + ( (temp_output_203_0_g242409).xy * temp_output_81_0_g242409 ) ),temp_output_82_0_g242409), 0.0 );
					float4 appendResult210_g242409 = (float4(tex2DArrayNode83_g242409.rgb , saturate( tex2DArrayNode83_g242409.a )));
					float4 temp_output_204_0_g242409 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g242409 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242409).zw + ( (temp_output_204_0_g242409).xy * temp_output_81_0_g242409 ) ),temp_output_82_0_g242409), 0.0 );
					float4 appendResult212_g242409 = (float4(tex2DArrayNode122_g242409.rgb , saturate( tex2DArrayNode122_g242409.a )));
					float4 lerpResult131_g242409 = lerp( appendResult210_g242409 , appendResult212_g242409 , Global_TexBlend509_g242340);
					float4 temp_output_171_109_g242406 = lerpResult131_g242409;
					float4 lerpResult174_g242406 = lerp( TVE_PaintParams , temp_output_171_109_g242406 , TVE_PaintLayers[(int)temp_output_82_0_g242406]);
					float4 temp_output_595_109_g242340 = lerpResult174_g242406;
					half4 Paint_Texture71_g242340 = temp_output_595_109_g242340;
					float4 In_PaintTexture204_g242340 = Paint_Texture71_g242340;
					float4 temp_output_590_141_g242340 = TVE_AtmoParams;
					half4 Atmo_Params601_g242340 = temp_output_590_141_g242340;
					float4 In_AtmoParams204_g242340 = Atmo_Params601_g242340;
					float4 temp_output_203_0_g242368 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g242368 = lerpResult104_g242340;
					float temp_output_132_0_g242366 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g242368 = temp_output_132_0_g242366;
					float4 tex2DArrayNode83_g242368 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242368).zw + ( (temp_output_203_0_g242368).xy * temp_output_81_0_g242368 ) ),temp_output_82_0_g242368), 0.0 );
					float4 appendResult210_g242368 = (float4(tex2DArrayNode83_g242368.rgb , saturate( tex2DArrayNode83_g242368.a )));
					float4 temp_output_204_0_g242368 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g242368 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242368).zw + ( (temp_output_204_0_g242368).xy * temp_output_81_0_g242368 ) ),temp_output_82_0_g242368), 0.0 );
					float4 appendResult212_g242368 = (float4(tex2DArrayNode122_g242368.rgb , saturate( tex2DArrayNode122_g242368.a )));
					float4 lerpResult131_g242368 = lerp( appendResult210_g242368 , appendResult212_g242368 , Global_TexBlend509_g242340);
					float4 temp_output_137_109_g242366 = lerpResult131_g242368;
					float4 lerpResult145_g242366 = lerp( TVE_AtmoParams , temp_output_137_109_g242366 , TVE_AtmoLayers[(int)temp_output_132_0_g242366]);
					float4 temp_output_590_110_g242340 = lerpResult145_g242366;
					half4 Atmo_Texture80_g242340 = temp_output_590_110_g242340;
					float4 In_AtmoTexture204_g242340 = Atmo_Texture80_g242340;
					float4 temp_output_593_163_g242340 = TVE_GlowParams;
					half4 Glow_Params609_g242340 = temp_output_593_163_g242340;
					float4 In_GlowParams204_g242340 = Glow_Params609_g242340;
					float4 temp_output_203_0_g242384 = TVE_GlowBaseCoord;
					float2 lerpResult247_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g242384 = lerpResult247_g242340;
					float temp_output_82_0_g242382 = _GlobalGlowLayerValue;
					float temp_output_82_0_g242384 = temp_output_82_0_g242382;
					float4 tex2DArrayNode83_g242384 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242384).zw + ( (temp_output_203_0_g242384).xy * temp_output_81_0_g242384 ) ),temp_output_82_0_g242384), 0.0 );
					float4 appendResult210_g242384 = (float4(tex2DArrayNode83_g242384.rgb , saturate( tex2DArrayNode83_g242384.a )));
					float4 temp_output_204_0_g242384 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g242384 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242384).zw + ( (temp_output_204_0_g242384).xy * temp_output_81_0_g242384 ) ),temp_output_82_0_g242384), 0.0 );
					float4 appendResult212_g242384 = (float4(tex2DArrayNode122_g242384.rgb , saturate( tex2DArrayNode122_g242384.a )));
					float4 lerpResult131_g242384 = lerp( appendResult210_g242384 , appendResult212_g242384 , Global_TexBlend509_g242340);
					float4 temp_output_159_109_g242382 = lerpResult131_g242384;
					float4 lerpResult167_g242382 = lerp( TVE_GlowParams , temp_output_159_109_g242382 , TVE_GlowLayers[(int)temp_output_82_0_g242382]);
					float4 temp_output_593_109_g242340 = lerpResult167_g242382;
					half4 Glow_Texture248_g242340 = temp_output_593_109_g242340;
					float4 In_GlowTexture204_g242340 = Glow_Texture248_g242340;
					float4 temp_output_592_139_g242340 = TVE_FormParams;
					float4 Form_Params606_g242340 = temp_output_592_139_g242340;
					float4 In_FormParams204_g242340 = Form_Params606_g242340;
					float4 temp_output_203_0_g242400 = TVE_FormBaseCoord;
					float2 lerpResult168_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g242400 = lerpResult168_g242340;
					float temp_output_130_0_g242398 = _GlobalFormLayerValue;
					float temp_output_82_0_g242400 = temp_output_130_0_g242398;
					float4 tex2DArrayNode83_g242400 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242400).zw + ( (temp_output_203_0_g242400).xy * temp_output_81_0_g242400 ) ),temp_output_82_0_g242400), 0.0 );
					float4 appendResult210_g242400 = (float4(tex2DArrayNode83_g242400.rgb , saturate( tex2DArrayNode83_g242400.a )));
					float4 temp_output_204_0_g242400 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g242400 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242400).zw + ( (temp_output_204_0_g242400).xy * temp_output_81_0_g242400 ) ),temp_output_82_0_g242400), 0.0 );
					float4 appendResult212_g242400 = (float4(tex2DArrayNode122_g242400.rgb , saturate( tex2DArrayNode122_g242400.a )));
					float4 lerpResult131_g242400 = lerp( appendResult210_g242400 , appendResult212_g242400 , Global_TexBlend509_g242340);
					float4 temp_output_135_109_g242398 = lerpResult131_g242400;
					float4 lerpResult143_g242398 = lerp( TVE_FormParams , temp_output_135_109_g242398 , TVE_FormLayers[(int)temp_output_130_0_g242398]);
					float4 temp_output_592_0_g242340 = lerpResult143_g242398;
					float4 Form_Texture112_g242340 = temp_output_592_0_g242340;
					float4 In_FormTexture204_g242340 = Form_Texture112_g242340;
					float4 temp_output_594_145_g242340 = TVE_FlowParams;
					half4 Flow_Params612_g242340 = temp_output_594_145_g242340;
					float4 In_FlowParams204_g242340 = Flow_Params612_g242340;
					float4 temp_output_203_0_g242392 = TVE_FlowBaseCoord;
					float2 lerpResult400_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g242392 = lerpResult400_g242340;
					float temp_output_136_0_g242390 = _GlobalFlowLayerValue;
					float temp_output_82_0_g242392 = temp_output_136_0_g242390;
					float4 tex2DArrayNode83_g242392 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242392).zw + ( (temp_output_203_0_g242392).xy * temp_output_81_0_g242392 ) ),temp_output_82_0_g242392), 0.0 );
					float4 appendResult210_g242392 = (float4(tex2DArrayNode83_g242392.rgb , saturate( tex2DArrayNode83_g242392.a )));
					float4 temp_output_204_0_g242392 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g242392 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242392).zw + ( (temp_output_204_0_g242392).xy * temp_output_81_0_g242392 ) ),temp_output_82_0_g242392), 0.0 );
					float4 appendResult212_g242392 = (float4(tex2DArrayNode122_g242392.rgb , saturate( tex2DArrayNode122_g242392.a )));
					float4 lerpResult131_g242392 = lerp( appendResult210_g242392 , appendResult212_g242392 , Global_TexBlend509_g242340);
					float4 temp_output_141_109_g242390 = lerpResult131_g242392;
					float4 lerpResult149_g242390 = lerp( TVE_FlowParams , temp_output_141_109_g242390 , TVE_FlowLayers[(int)temp_output_136_0_g242390]);
					half4 Flow_Texture405_g242340 = lerpResult149_g242390;
					float4 In_FlowTexture204_g242340 = Flow_Texture405_g242340;
					BuildGlobalData( Data204_g242340 , In_Dummy204_g242340 , In_CoatParams204_g242340 , In_CoatTexture204_g242340 , In_PaintParams204_g242340 , In_PaintTexture204_g242340 , In_AtmoParams204_g242340 , In_AtmoTexture204_g242340 , In_GlowParams204_g242340 , In_GlowTexture204_g242340 , In_FormParams204_g242340 , In_FormTexture204_g242340 , In_FlowParams204_g242340 , In_FlowTexture204_g242340 );
					TVEGlobalData Data15_g242430 =(TVEGlobalData)Data204_g242340;
					float Out_Dummy15_g242430 = 0.0;
					float4 Out_CoatParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g242430 = float4( 0,0,0,0 );
					BreakData( Data15_g242430 , Out_Dummy15_g242430 , Out_CoatParams15_g242430 , Out_CoatTexture15_g242430 , Out_PaintParams15_g242430 , Out_PaintTexture15_g242430 , Out_AtmoParams15_g242430 , Out_AtmoTexture15_g242430 , Out_GlowParams15_g242430 , Out_GlowTexture15_g242430 , Out_FormParams15_g242430 , Out_FormTexture15_g242430 , Out_FlowParams15_g242430 , Out_FlowTexture15_g242430 );
					float4 Global_FormTexture351_g242427 = Out_FormTexture15_g242430;
					float3 Model_PivotWO353_g242427 = temp_output_314_19_g242427;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g242436 = _ConformMeshMode;
					float Option70_g242436 = temp_output_17_0_g242436;
					half4 Model_VertexData357_g242427 = temp_output_314_29_g242427;
					float4 temp_output_3_0_g242436 = Model_VertexData357_g242427;
					float4 Channel70_g242436 = temp_output_3_0_g242436;
					float localSwitchChannel470_g242436 = SwitchChannel4( Option70_g242436 , Channel70_g242436 );
					float temp_output_390_0_g242427 = localSwitchChannel470_g242436;
					float temp_output_7_0_g242433 = _ConformMeshRemap.x;
					float temp_output_9_0_g242433 = ( temp_output_390_0_g242427 - temp_output_7_0_g242433 );
					float lerpResult374_g242427 = lerp( 1.0 , saturate( ( temp_output_9_0_g242433 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g242427 = lerpResult374_g242427;
					float temp_output_328_0_g242427 = ( Blend_VertMask379_g242427 * TVE_IsEnabled );
					half Conform_Mask366_g242427 = temp_output_328_0_g242427;
					float temp_output_322_0_g242427 = ( ( ( ( (Global_FormTexture351_g242427).z - ( (Model_PivotWO353_g242427).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g242427 ) );
					float3 appendResult329_g242427 = (float3(0.0 , temp_output_322_0_g242427 , 0.0));
					float3 appendResult387_g242427 = (float3(0.0 , 0.0 , temp_output_322_0_g242427));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g242434 = appendResult387_g242427;
					#else
					float3 staticSwitch65_g242434 = appendResult329_g242427;
					#endif
					float3 Blanket_Conform368_g242427 = staticSwitch65_g242434;
					float4 appendResult312_g242427 = (float4(Blanket_Conform368_g242427 , 0.0));
					float4 temp_output_310_0_g242427 = ( Model_TransformData356_g242427 + appendResult312_g242427 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g242427 = temp_output_310_0_g242427;
					#else
					float4 staticSwitch364_g242427 = Model_TransformData356_g242427;
					#endif
					half4 Final_TransformData365_g242427 = staticSwitch364_g242427;
					float4 In_TransformData16_g242429 = Final_TransformData365_g242427;
					float4 In_RotationData16_g242429 = Out_RotationData15_g242428;
					float4 In_InterpolatorA16_g242429 = Out_InterpolatorA15_g242428;
					BuildModelVertData( Data16_g242429 , In_Dummy16_g242429 , In_PositionOS16_g242429 , In_PositionWS16_g242429 , In_PositionWO16_g242429 , In_PositionRawOS16_g242429 , In_PivotOS16_g242429 , In_PivotWS16_g242429 , In_PivotWO16_g242429 , In_NormalOS16_g242429 , In_NormalWS16_g242429 , In_NormalRawOS16_g242429 , In_TangentOS16_g242429 , In_TangentWS16_g242429 , In_BitangentWS16_g242429 , In_ViewDirWS16_g242429 , In_CoordsData16_g242429 , In_VertexData16_g242429 , In_MasksData16_g242429 , In_PhaseData16_g242429 , In_TransformData16_g242429 , In_RotationData16_g242429 , In_InterpolatorA16_g242429 );
					TVEModelData Data15_g242440 =(TVEModelData)Data16_g242429;
					float Out_Dummy15_g242440 = 0.0;
					float3 Out_PositionOS15_g242440 = float3( 0,0,0 );
					float3 Out_PositionWS15_g242440 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242440 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g242440 = float3( 0,0,0 );
					float3 Out_PivotOS15_g242440 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242440 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242440 = float3( 0,0,0 );
					float3 Out_NormalOS15_g242440 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242440 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g242440 = float3( 0,0,0 );
					float4 Out_TangentOS15_g242440 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g242440 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242440 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242440 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242440 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242440 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g242440 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g242440 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g242440 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g242440 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g242440 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g242440 , Out_Dummy15_g242440 , Out_PositionOS15_g242440 , Out_PositionWS15_g242440 , Out_PositionWO15_g242440 , Out_PositionRawOS15_g242440 , Out_PivotOS15_g242440 , Out_PivotWS15_g242440 , Out_PivotWO15_g242440 , Out_NormalOS15_g242440 , Out_NormalWS15_g242440 , Out_NormalRawOS15_g242440 , Out_TangentOS15_g242440 , Out_TangentWS15_g242440 , Out_BitangentWS15_g242440 , Out_ViewDirWS15_g242440 , Out_CoordsData15_g242440 , Out_VertexData15_g242440 , Out_MasksData15_g242440 , Out_PhaseData15_g242440 , Out_TransformData15_g242440 , Out_RotationData15_g242440 , Out_InterpolatorA15_g242440 );
					TVEModelData Data16_g242441 =(TVEModelData)Data15_g242440;
					float temp_output_14_0_g242441 = 0.0;
					float In_Dummy16_g242441 = temp_output_14_0_g242441;
					float3 Model_PositionOS147_g242439 = Out_PositionOS15_g242440;
					half3 VertexPos40_g242445 = Model_PositionOS147_g242439;
					float4 temp_output_1567_33_g242439 = Out_RotationData15_g242440;
					half4 Model_RotationData1569_g242439 = temp_output_1567_33_g242439;
					float2 break1582_g242439 = (Model_RotationData1569_g242439).xy;
					half Angle44_g242445 = break1582_g242439.y;
					half CosAngle89_g242445 = cos( Angle44_g242445 );
					half SinAngle93_g242445 = sin( Angle44_g242445 );
					float3 appendResult95_g242445 = (float3((VertexPos40_g242445).x , ( ( (VertexPos40_g242445).y * CosAngle89_g242445 ) - ( (VertexPos40_g242445).z * SinAngle93_g242445 ) ) , ( ( (VertexPos40_g242445).y * SinAngle93_g242445 ) + ( (VertexPos40_g242445).z * CosAngle89_g242445 ) )));
					half3 VertexPos40_g242446 = appendResult95_g242445;
					half Angle44_g242446 = -break1582_g242439.x;
					half CosAngle94_g242446 = cos( Angle44_g242446 );
					half SinAngle95_g242446 = sin( Angle44_g242446 );
					float3 appendResult98_g242446 = (float3(( ( (VertexPos40_g242446).x * CosAngle94_g242446 ) - ( (VertexPos40_g242446).y * SinAngle95_g242446 ) ) , ( ( (VertexPos40_g242446).x * SinAngle95_g242446 ) + ( (VertexPos40_g242446).y * CosAngle94_g242446 ) ) , (VertexPos40_g242446).z));
					half3 VertexPos40_g242444 = Model_PositionOS147_g242439;
					half Angle44_g242444 = break1582_g242439.y;
					half CosAngle89_g242444 = cos( Angle44_g242444 );
					half SinAngle93_g242444 = sin( Angle44_g242444 );
					float3 appendResult95_g242444 = (float3((VertexPos40_g242444).x , ( ( (VertexPos40_g242444).y * CosAngle89_g242444 ) - ( (VertexPos40_g242444).z * SinAngle93_g242444 ) ) , ( ( (VertexPos40_g242444).y * SinAngle93_g242444 ) + ( (VertexPos40_g242444).z * CosAngle89_g242444 ) )));
					half3 VertexPos40_g242449 = appendResult95_g242444;
					half Angle44_g242449 = break1582_g242439.x;
					half CosAngle91_g242449 = cos( Angle44_g242449 );
					half SinAngle92_g242449 = sin( Angle44_g242449 );
					float3 appendResult93_g242449 = (float3(( ( (VertexPos40_g242449).x * CosAngle91_g242449 ) + ( (VertexPos40_g242449).z * SinAngle92_g242449 ) ) , (VertexPos40_g242449).y , ( ( -(VertexPos40_g242449).x * SinAngle92_g242449 ) + ( (VertexPos40_g242449).z * CosAngle91_g242449 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g242447 = appendResult93_g242449;
					#else
					float3 staticSwitch65_g242447 = appendResult98_g242446;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g242442 = staticSwitch65_g242447;
					#else
					float3 staticSwitch65_g242442 = Model_PositionOS147_g242439;
					#endif
					float3 temp_output_1608_0_g242439 = staticSwitch65_g242442;
					half3 VertexPos40_g242448 = temp_output_1608_0_g242439;
					half Angle44_g242448 = (Model_RotationData1569_g242439).z;
					half CosAngle91_g242448 = cos( Angle44_g242448 );
					half SinAngle92_g242448 = sin( Angle44_g242448 );
					float3 appendResult93_g242448 = (float3(( ( (VertexPos40_g242448).x * CosAngle91_g242448 ) + ( (VertexPos40_g242448).z * SinAngle92_g242448 ) ) , (VertexPos40_g242448).y , ( ( -(VertexPos40_g242448).x * SinAngle92_g242448 ) + ( (VertexPos40_g242448).z * CosAngle91_g242448 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g242443 = appendResult93_g242448;
					#else
					float3 staticSwitch65_g242443 = temp_output_1608_0_g242439;
					#endif
					float4 temp_output_1567_31_g242439 = Out_TransformData15_g242440;
					half4 Model_TransformData1568_g242439 = temp_output_1567_31_g242439;
					half3 Final_PositionOS178_g242439 = ( ( staticSwitch65_g242443 * (Model_TransformData1568_g242439).w ) + (Model_TransformData1568_g242439).xyz );
					float3 temp_output_4_0_g242441 = Final_PositionOS178_g242439;
					float3 In_PositionOS16_g242441 = temp_output_4_0_g242441;
					float3 In_PositionWS16_g242441 = Out_PositionWS15_g242440;
					float3 In_PositionWO16_g242441 = Out_PositionWO15_g242440;
					float3 In_PositionRawOS16_g242441 = Out_PositionRawOS15_g242440;
					float3 In_PivotOS16_g242441 = Out_PivotOS15_g242440;
					float3 In_PivotWS16_g242441 = Out_PivotWS15_g242440;
					float3 In_PivotWO16_g242441 = Out_PivotWO15_g242440;
					float3 temp_output_21_0_g242441 = Out_NormalOS15_g242440;
					float3 In_NormalOS16_g242441 = temp_output_21_0_g242441;
					float3 In_NormalWS16_g242441 = Out_NormalWS15_g242440;
					float3 In_NormalRawOS16_g242441 = Out_NormalRawOS15_g242440;
					float4 temp_output_6_0_g242441 = Out_TangentOS15_g242440;
					float4 In_TangentOS16_g242441 = temp_output_6_0_g242441;
					float3 In_TangentWS16_g242441 = Out_TangentWS15_g242440;
					float3 In_BitangentWS16_g242441 = Out_BitangentWS15_g242440;
					float3 In_ViewDirWS16_g242441 = Out_ViewDirWS15_g242440;
					float4 In_CoordsData16_g242441 = Out_CoordsData15_g242440;
					float4 In_VertexData16_g242441 = Out_VertexData15_g242440;
					float4 In_MasksData16_g242441 = Out_MasksData15_g242440;
					float4 In_PhaseData16_g242441 = Out_PhaseData15_g242440;
					float4 In_TransformData16_g242441 = temp_output_1567_31_g242439;
					float4 In_RotationData16_g242441 = temp_output_1567_33_g242439;
					float4 In_InterpolatorA16_g242441 = Out_InterpolatorA15_g242440;
					BuildModelVertData( Data16_g242441 , In_Dummy16_g242441 , In_PositionOS16_g242441 , In_PositionWS16_g242441 , In_PositionWO16_g242441 , In_PositionRawOS16_g242441 , In_PivotOS16_g242441 , In_PivotWS16_g242441 , In_PivotWO16_g242441 , In_NormalOS16_g242441 , In_NormalWS16_g242441 , In_NormalRawOS16_g242441 , In_TangentOS16_g242441 , In_TangentWS16_g242441 , In_BitangentWS16_g242441 , In_ViewDirWS16_g242441 , In_CoordsData16_g242441 , In_VertexData16_g242441 , In_MasksData16_g242441 , In_PhaseData16_g242441 , In_TransformData16_g242441 , In_RotationData16_g242441 , In_InterpolatorA16_g242441 );
					TVEModelData Data15_g251358 =(TVEModelData)Data16_g242441;
					float Out_Dummy15_g251358 = 0.0;
					float3 Out_PositionOS15_g251358 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251358 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251358 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251358 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251358 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251358 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251358 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251358 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251358 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251358 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251358 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251358 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251358 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251358 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251358 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251358 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251358 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251358 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251358 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251358 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251358 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251358 , Out_Dummy15_g251358 , Out_PositionOS15_g251358 , Out_PositionWS15_g251358 , Out_PositionWO15_g251358 , Out_PositionRawOS15_g251358 , Out_PivotOS15_g251358 , Out_PivotWS15_g251358 , Out_PivotWO15_g251358 , Out_NormalOS15_g251358 , Out_NormalWS15_g251358 , Out_NormalRawOS15_g251358 , Out_TangentOS15_g251358 , Out_TangentWS15_g251358 , Out_BitangentWS15_g251358 , Out_ViewDirWS15_g251358 , Out_CoordsData15_g251358 , Out_VertexData15_g251358 , Out_MasksData15_g251358 , Out_PhaseData15_g251358 , Out_TransformData15_g251358 , Out_RotationData15_g251358 , Out_InterpolatorA15_g251358 );
					TVEModelData Data16_g251359 =(TVEModelData)Data15_g251358;
					float temp_output_14_0_g251359 = 0.0;
					float In_Dummy16_g251359 = temp_output_14_0_g251359;
					float3 temp_output_217_24_g251357 = Out_PivotOS15_g251358;
					float3 temp_output_216_0_g251357 = ( Out_PositionOS15_g251358 + temp_output_217_24_g251357 );
					float3 temp_output_4_0_g251359 = temp_output_216_0_g251357;
					float3 In_PositionOS16_g251359 = temp_output_4_0_g251359;
					float3 In_PositionWS16_g251359 = Out_PositionWS15_g251358;
					float3 In_PositionWO16_g251359 = Out_PositionWO15_g251358;
					float3 In_PositionRawOS16_g251359 = Out_PositionRawOS15_g251358;
					float3 In_PivotOS16_g251359 = temp_output_217_24_g251357;
					float3 In_PivotWS16_g251359 = Out_PivotWS15_g251358;
					float3 In_PivotWO16_g251359 = Out_PivotWO15_g251358;
					float3 temp_output_21_0_g251359 = Out_NormalOS15_g251358;
					float3 In_NormalOS16_g251359 = temp_output_21_0_g251359;
					float3 In_NormalWS16_g251359 = Out_NormalWS15_g251358;
					float3 In_NormalRawOS16_g251359 = Out_NormalRawOS15_g251358;
					float4 temp_output_6_0_g251359 = Out_TangentOS15_g251358;
					float4 In_TangentOS16_g251359 = temp_output_6_0_g251359;
					float3 In_TangentWS16_g251359 = Out_TangentWS15_g251358;
					float3 In_BitangentWS16_g251359 = Out_BitangentWS15_g251358;
					float3 In_ViewDirWS16_g251359 = Out_ViewDirWS15_g251358;
					float4 In_CoordsData16_g251359 = Out_CoordsData15_g251358;
					float4 In_VertexData16_g251359 = Out_VertexData15_g251358;
					float4 In_MasksData16_g251359 = Out_MasksData15_g251358;
					float4 In_PhaseData16_g251359 = Out_PhaseData15_g251358;
					float4 In_TransformData16_g251359 = Out_TransformData15_g251358;
					float4 In_RotationData16_g251359 = Out_RotationData15_g251358;
					float4 In_InterpolatorA16_g251359 = Out_InterpolatorA15_g251358;
					BuildModelVertData( Data16_g251359 , In_Dummy16_g251359 , In_PositionOS16_g251359 , In_PositionWS16_g251359 , In_PositionWO16_g251359 , In_PositionRawOS16_g251359 , In_PivotOS16_g251359 , In_PivotWS16_g251359 , In_PivotWO16_g251359 , In_NormalOS16_g251359 , In_NormalWS16_g251359 , In_NormalRawOS16_g251359 , In_TangentOS16_g251359 , In_TangentWS16_g251359 , In_BitangentWS16_g251359 , In_ViewDirWS16_g251359 , In_CoordsData16_g251359 , In_VertexData16_g251359 , In_MasksData16_g251359 , In_PhaseData16_g251359 , In_TransformData16_g251359 , In_RotationData16_g251359 , In_InterpolatorA16_g251359 );
					TVEModelData Data15_g251368 =(TVEModelData)Data16_g251359;
					float Out_Dummy15_g251368 = 0.0;
					float3 Out_PositionOS15_g251368 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251368 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251368 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251368 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251368 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251368 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251368 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251368 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251368 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251368 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251368 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251368 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251368 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251368 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251368 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251368 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251368 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251368 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251368 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251368 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251368 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251368 , Out_Dummy15_g251368 , Out_PositionOS15_g251368 , Out_PositionWS15_g251368 , Out_PositionWO15_g251368 , Out_PositionRawOS15_g251368 , Out_PivotOS15_g251368 , Out_PivotWS15_g251368 , Out_PivotWO15_g251368 , Out_NormalOS15_g251368 , Out_NormalWS15_g251368 , Out_NormalRawOS15_g251368 , Out_TangentOS15_g251368 , Out_TangentWS15_g251368 , Out_BitangentWS15_g251368 , Out_ViewDirWS15_g251368 , Out_CoordsData15_g251368 , Out_VertexData15_g251368 , Out_MasksData15_g251368 , Out_PhaseData15_g251368 , Out_TransformData15_g251368 , Out_RotationData15_g251368 , Out_InterpolatorA15_g251368 );
					
					float3 color107_g242418 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g242418 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float localBreakData4_g242417 = ( 0.0 );
					float localBuildMasksData3_g242335 = ( 0.0 );
					TVEMasksData Data3_g242335 = (TVEMasksData)0;
					half Feature_Intensity1873_g242329 = _FlattenIntensityValue;
					float ifLocalVar18_g242337 = 0;
					if( Feature_Intensity1873_g242329 <= 0.0 )
					ifLocalVar18_g242337 = 0.0;
					else
					ifLocalVar18_g242337 = 1.0;
					float4 appendResult1869_g242329 = (float4(ifLocalVar18_g242337 , 0.0 , 0.0 , 0.0));
					float4 In_MaskA3_g242335 = appendResult1869_g242329;
					float temp_output_17_0_g242339 = _FlattenMeshMode;
					float Option70_g242339 = temp_output_17_0_g242339;
					TVEModelData Data15_g242330 =(TVEModelData)Data26_g242169;
					float Out_Dummy15_g242330 = 0.0;
					float3 Out_PositionOS15_g242330 = float3( 0,0,0 );
					float3 Out_PositionWS15_g242330 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242330 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g242330 = float3( 0,0,0 );
					float3 Out_PivotOS15_g242330 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242330 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242330 = float3( 0,0,0 );
					float3 Out_NormalOS15_g242330 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242330 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g242330 = float3( 0,0,0 );
					float4 Out_TangentOS15_g242330 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g242330 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242330 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242330 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242330 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242330 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g242330 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g242330 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g242330 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g242330 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g242330 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g242330 , Out_Dummy15_g242330 , Out_PositionOS15_g242330 , Out_PositionWS15_g242330 , Out_PositionWO15_g242330 , Out_PositionRawOS15_g242330 , Out_PivotOS15_g242330 , Out_PivotWS15_g242330 , Out_PivotWO15_g242330 , Out_NormalOS15_g242330 , Out_NormalWS15_g242330 , Out_NormalRawOS15_g242330 , Out_TangentOS15_g242330 , Out_TangentWS15_g242330 , Out_BitangentWS15_g242330 , Out_ViewDirWS15_g242330 , Out_CoordsData15_g242330 , Out_VertexData15_g242330 , Out_MasksData15_g242330 , Out_PhaseData15_g242330 , Out_TransformData15_g242330 , Out_RotationData15_g242330 , Out_InterpolatorA15_g242330 );
					float4 temp_output_1810_29_g242329 = Out_VertexData15_g242330;
					half4 Model_VertexData1826_g242329 = temp_output_1810_29_g242329;
					float4 temp_output_3_0_g242339 = Model_VertexData1826_g242329;
					float4 Channel70_g242339 = temp_output_3_0_g242339;
					float localSwitchChannel470_g242339 = SwitchChannel4( Option70_g242339 , Channel70_g242339 );
					float clampResult17_g242333 = clamp( localSwitchChannel470_g242339 , 0.0001 , 0.9999 );
					float temp_output_7_0_g242334 = _FlattenMeshRemap.x;
					float temp_output_9_0_g242334 = ( clampResult17_g242333 - temp_output_7_0_g242334 );
					float lerpResult1841_g242329 = lerp( 1.0 , saturate( ( temp_output_9_0_g242334 * _FlattenMeshRemap.z ) ) , _FlattenMeshValue);
					half Normal_MeskMask1847_g242329 = lerpResult1841_g242329;
					half Normal_Mask1851_g242329 = Normal_MeskMask1847_g242329;
					float ifLocalVar18_g242336 = 0;
					if( Feature_Intensity1873_g242329 <= 0.0 )
					ifLocalVar18_g242336 = 0.0;
					else
					ifLocalVar18_g242336 = Normal_Mask1851_g242329;
					float4 appendResult1870_g242329 = (float4(ifLocalVar18_g242336 , 0.0 , 0.0 , 0.0));
					float4 In_MaskB3_g242335 = appendResult1870_g242329;
					half3 Model_NormalOS1829_g242329 = Out_NormalOS15_g242330;
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g242331 = half3( 0, 0, 1 );
					#else
					float3 staticSwitch65_g242331 = half3( 0, 1, 0 );
					#endif
					float3 lerpResult1820_g242329 = lerp( Model_NormalOS1829_g242329 , staticSwitch65_g242331 , _FlattenIntensityValue);
					float3 temp_output_1810_26_g242329 = Out_PositionRawOS15_g242330;
					float3 Model_PositionBaseOS1837_g242329 = temp_output_1810_26_g242329;
					float3 normalizeResult1816_g242329 = ASESafeNormalize( ( Model_PositionBaseOS1837_g242329 + _FlattenSphereOffsetValue ) );
					float3 lerpResult1813_g242329 = lerp( lerpResult1820_g242329 , normalizeResult1816_g242329 , _FlattenSphereValue);
					float3 lerpResult1856_g242329 = lerp( Model_NormalOS1829_g242329 , lerpResult1813_g242329 , Normal_Mask1851_g242329);
					#ifdef TVE_FLATTEN
					float3 staticSwitch1857_g242329 = lerpResult1856_g242329;
					#else
					float3 staticSwitch1857_g242329 = Model_NormalOS1829_g242329;
					#endif
					half3 Final_NormalOS1853_g242329 = staticSwitch1857_g242329;
					float3 ifLocalVar18_g242338 = 0;
					if( Feature_Intensity1873_g242329 <= 0.0 )
					ifLocalVar18_g242338 = Model_NormalOS1829_g242329;
					else
					ifLocalVar18_g242338 = Final_NormalOS1853_g242329;
					float4 appendResult1830_g242329 = (float4(ifLocalVar18_g242338 , 0.0));
					float4 In_MaskC3_g242335 = appendResult1830_g242329;
					float4 temp_cast_11 = (0.0).xxxx;
					float4 In_MaskD3_g242335 = temp_cast_11;
					float4 temp_cast_12 = (0.0).xxxx;
					float4 In_MaskE3_g242335 = temp_cast_12;
					float4 temp_cast_13 = (0.0).xxxx;
					float4 In_MaskF3_g242335 = temp_cast_13;
					float4 temp_cast_14 = (0.0).xxxx;
					float4 In_MaskG3_g242335 = temp_cast_14;
					float4 temp_cast_15 = (0.0).xxxx;
					float4 In_MaskH3_g242335 = temp_cast_15;
					float4 temp_cast_16 = (0.0).xxxx;
					float4 In_MaskI3_g242335 = temp_cast_16;
					float4 temp_cast_17 = (0.0).xxxx;
					float4 In_MaskJ3_g242335 = temp_cast_17;
					float4 temp_cast_18 = (0.0).xxxx;
					float4 In_MaskK3_g242335 = temp_cast_18;
					float4 temp_cast_19 = (0.0).xxxx;
					float4 In_MaskL3_g242335 = temp_cast_19;
					{
					Data3_g242335.MaskA = In_MaskA3_g242335;
					Data3_g242335.MaskB = In_MaskB3_g242335;
					Data3_g242335.MaskC = In_MaskC3_g242335;
					Data3_g242335.MaskD = In_MaskD3_g242335;
					Data3_g242335.MaskE = In_MaskE3_g242335;
					Data3_g242335.MaskF = In_MaskF3_g242335;
					Data3_g242335.MaskG = In_MaskG3_g242335;
					Data3_g242335.MaskH = In_MaskH3_g242335;
					Data3_g242335.MaskI = In_MaskI3_g242335;
					Data3_g242335.MaskJ= In_MaskJ3_g242335;
					Data3_g242335.MaskK= In_MaskK3_g242335;
					Data3_g242335.MaskL = In_MaskL3_g242335;
					}
					TVEMasksData Data4_g242417 = Data3_g242335;
					float4 Out_MaskA4_g242417 = float4( 0,0,0,0 );
					float4 Out_MaskB4_g242417 = float4( 0,0,0,0 );
					float4 Out_MaskC4_g242417 = float4( 0,0,0,0 );
					float4 Out_MaskD4_g242417 = float4( 0,0,0,0 );
					float4 Out_MaskE4_g242417 = float4( 0,0,0,0 );
					float4 Out_MaskF4_g242417 = float4( 0,0,0,0 );
					float4 Out_MaskG4_g242417 = float4( 0,0,0,0 );
					float4 Out_MaskH4_g242417 = float4( 0,0,0,0 );
					{
					Out_MaskA4_g242417 = Data4_g242417.MaskA;
					Out_MaskB4_g242417 = Data4_g242417.MaskB;
					Out_MaskC4_g242417 = Data4_g242417.MaskC;
					Out_MaskD4_g242417 = Data4_g242417.MaskD;
					Out_MaskE4_g242417 = Data4_g242417.MaskE;
					Out_MaskF4_g242417 = Data4_g242417.MaskF;
					Out_MaskG4_g242417 = Data4_g242417.MaskG;
					Out_MaskH4_g242417 = Data4_g242417.MaskH;
					}
					float3 lerpResult2568 = lerp( color107_g242418 , color106_g242418 , (Out_MaskA4_g242417).x);
					float3 ifLocalVar40_g242437 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g242437 = lerpResult2568;
					float3 ifLocalVar40_g242438 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g242438 = (Out_MaskB4_g242417).xxx;
					float3 temp_output_2511_0 = (Out_MaskC4_g242417).xyz;
					float3 ifLocalVar40_g242425 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g242425 = temp_output_2511_0;
					float3 objToWorldDir2643 = ASESafeNormalize( mul( unity_ObjectToWorld, float4( temp_output_2511_0, 0.0 ) ).xyz );
					float3 ifLocalVar40_g242426 = 0;
					if( TVE_DEBUG_Index == 5.0 )
					ifLocalVar40_g242426 = objToWorldDir2643;
					float3 vertexToFrag2524 = ( ifLocalVar40_g242437 + ifLocalVar40_g242438 + ( ifLocalVar40_g242425 + ifLocalVar40_g242426 ) );
					o.ase_texcoord6.xyz = vertexToFrag2524;
					float3 vertexPos57_g251362 = v.vertex.xyz;
					float4 ase_positionCS57_g251362 = UnityObjectToClipPos( vertexPos57_g251362 );
					o.ase_texcoord7 = ase_positionCS57_g251362;
					o.ase_texcoord8.xyz = vertexToFrag73_g242149;
					o.ase_texcoord9.xyz = vertexToFrag76_g242149;
					
					o.ase_texcoord10.xy = v.texcoord.xyzw.xy;
					o.ase_texcoord10.zw = v.texcoord2.xyzw.xy;
					o.ase_color = v.ase_color;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord6.w = 0;
					o.ase_texcoord8.w = 0;
					o.ase_texcoord9.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251368;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251368;
					v.tangent = Out_TangentOS15_g251368;

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

					float temp_output_2609_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2609_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2609_114).xxx;
					
					float3 color130_g251362 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g251362 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g251364 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g251363 = ( temp_cast_4 * ( 0.5 + appendResult128_g251364 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g251363 = (float4(ddx( FinalUV13_g251363 ) , ddy( FinalUV13_g251363 )));
					float4 UVDerivatives17_g251363 = appendResult16_g251363;
					float4 break28_g251363 = UVDerivatives17_g251363;
					float2 appendResult19_g251363 = (float2(break28_g251363.x , break28_g251363.z));
					float2 appendResult20_g251363 = (float2(break28_g251363.x , break28_g251363.z));
					float dotResult24_g251363 = dot( appendResult19_g251363 , appendResult20_g251363 );
					float2 appendResult21_g251363 = (float2(break28_g251363.y , break28_g251363.w));
					float2 appendResult22_g251363 = (float2(break28_g251363.y , break28_g251363.w));
					float dotResult23_g251363 = dot( appendResult21_g251363 , appendResult22_g251363 );
					float2 appendResult25_g251363 = (float2(dotResult24_g251363 , dotResult23_g251363));
					float2 derivativesLength29_g251363 = sqrt( appendResult25_g251363 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g251363 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g251363 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g251363 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g251363 = clampResult57_g251363;
					float2 break55_g251363 = derivativesLength29_g251363;
					float4 lerpResult73_g251363 = lerp( float4( color130_g251362 , 0.0 ) , float4( color81_g251362 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g251363.x * break71_g251363.y * sqrt( saturate( ( 1.1 - max( break55_g251363.x, break55_g251363.y ) ) ) ) ) ) ));
					float3 vertexToFrag2524 = IN.ase_texcoord6.xyz;
					half3 Final_Debug2399 = vertexToFrag2524;
					float temp_output_7_0_g251370 = TVE_DEBUG_Min;
					float3 temp_cast_9 = (temp_output_7_0_g251370).xxx;
					float3 temp_output_9_0_g251370 = ( Final_Debug2399 - temp_cast_9 );
					float lerpResult76_g251362 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g251362 = lerpResult76_g251362;
					float3 lerpResult72_g251362 = lerp( (lerpResult73_g251363).rgb , saturate( ( temp_output_9_0_g251370 / ( ( TVE_DEBUG_Max - temp_output_7_0_g251370 ) + 0.0001 ) ) ) , Filter152_g251362);
					float dotResult61_g251362 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g251362 = ( 1.0 - saturate( dotResult61_g251362 ) );
					float Shading_Fresnel59_g251362 = (( 1.0 - ( temp_output_65_0_g251362 * temp_output_65_0_g251362 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g251362 = IN.ase_texcoord7;
					float depthLinearEye57_g251362 = LinearEyeDepth( ase_positionCS57_g251362.z / ase_positionCS57_g251362.w );
					float temp_output_69_0_g251362 = saturate(  (0.0 + ( depthLinearEye57_g251362 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g251362 = (( temp_output_69_0_g251362 * temp_output_69_0_g251362 )*0.5 + 0.5);
					float lerpResult84_g251362 = lerp( 1.0 , Shading_Fresnel59_g251362 , ( Shading_Distance58_g251362 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g251367 = ( 0.0 );
					float localBuildVisualData3_g251315 = ( 0.0 );
					TVEVisualData Data3_g251315 =(TVEVisualData)0;
					half4 Dummy130_g242450 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) );
					float temp_output_14_0_g251315 = Dummy130_g242450.x;
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
					half4 Local_Coords180_g242450 = _main_coord_value;
					float4 Coords444_g251346 = Local_Coords180_g242450;
					float localIfModelDataByShader26_g242420 = ( 0.0 );
					TVEModelData Data26_g242420 = (TVEModelData)0;
					TVEModelData Data16_g242157 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g242157 = 0.0;
					float3 vertexToFrag73_g242149 = IN.ase_texcoord8.xyz;
					float3 PositionWS122_g242149 = vertexToFrag73_g242149;
					float3 In_PositionWS16_g242157 = PositionWS122_g242149;
					float3 vertexToFrag76_g242149 = IN.ase_texcoord9.xyz;
					float3 PivotWS121_g242149 = vertexToFrag76_g242149;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242149 = ( PositionWS122_g242149 - PivotWS121_g242149 );
					#else
					float3 staticSwitch204_g242149 = PositionWS122_g242149;
					#endif
					float3 PositionWO132_g242149 = ( staticSwitch204_g242149 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242157 = PositionWO132_g242149;
					float3 In_PivotWS16_g242157 = PivotWS121_g242149;
					float3 PivotWO133_g242149 = ( PivotWS121_g242149 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242157 = PivotWO133_g242149;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g242149 = normalizedWorldNormal;
					float3 In_NormalWS16_g242157 = NormalWS95_g242149;
					half3 TangentWS136_g242149 = TangentWS;
					float3 In_TangentWS16_g242157 = TangentWS136_g242149;
					half3 BiangentWS421_g242149 = BitangentWS;
					float3 In_BitangentWS16_g242157 = BiangentWS421_g242149;
					half3 NormalWS427_g242149 = NormalWS95_g242149;
					half3 localComputeTriplanarWeights427_g242149 = ComputeTriplanarWeights( NormalWS427_g242149 );
					half3 TriplanarWeights429_g242149 = localComputeTriplanarWeights427_g242149;
					float3 In_TriplanarWeights16_g242157 = TriplanarWeights429_g242149;
					float3 normalizeResult296_g242149 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242149 ) );
					half3 ViewDirWS169_g242149 = normalizeResult296_g242149;
					float3 In_ViewDirWS16_g242157 = ViewDirWS169_g242149;
					float4 appendResult397_g242149 = (float4(IN.ase_texcoord10.xy , IN.ase_texcoord10.zw));
					float4 CoordsData398_g242149 = appendResult397_g242149;
					float4 In_CoordsData16_g242157 = CoordsData398_g242149;
					half4 VertexMasks171_g242149 = IN.ase_color;
					float4 In_VertexData16_g242157 = VertexMasks171_g242149;
					float temp_output_17_0_g242161 = _ObjectPhaseMode;
					float Option70_g242161 = temp_output_17_0_g242161;
					float4 temp_output_3_0_g242161 = IN.ase_color;
					float4 Channel70_g242161 = temp_output_3_0_g242161;
					float localSwitchChannel470_g242161 = SwitchChannel4( Option70_g242161 , Channel70_g242161 );
					half Phase_Value372_g242149 = localSwitchChannel470_g242161;
					float3 break319_g242149 = PivotWO133_g242149;
					half Pivot_Position322_g242149 = ( break319_g242149.x + break319_g242149.z );
					half Phase_Position357_g242149 = ( Phase_Value372_g242149 + Pivot_Position322_g242149 );
					float temp_output_248_0_g242149 = frac( Phase_Position357_g242149 );
					float4 appendResult177_g242149 = (float4(( (frac( ( Phase_Position357_g242149 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g242149));
					half4 Phase_Data176_g242149 = appendResult177_g242149;
					float4 In_PhaseData16_g242157 = Phase_Data176_g242149;
					BuildModelFragData( Data16_g242157 , In_Dummy16_g242157 , In_PositionWS16_g242157 , In_PositionWO16_g242157 , In_PivotWS16_g242157 , In_PivotWO16_g242157 , In_NormalWS16_g242157 , In_TangentWS16_g242157 , In_BitangentWS16_g242157 , In_TriplanarWeights16_g242157 , In_ViewDirWS16_g242157 , In_CoordsData16_g242157 , In_VertexData16_g242157 , In_PhaseData16_g242157 );
					TVEModelData DataDefault26_g242420 = Data16_g242157;
					TVEModelData DataGeneral26_g242420 = Data16_g242157;
					TVEModelData DataBlanket26_g242420 = Data16_g242157;
					TVEModelData DataImpostor26_g242420 = Data16_g242157;
					TVEModelData Data16_g242137 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g242137 = 0.0;
					float3 temp_output_104_7_g242129 = PositionWS;
					float3 PositionWS122_g242129 = temp_output_104_7_g242129;
					float3 In_PositionWS16_g242137 = PositionWS122_g242129;
					float4x4 break19_g242132 = unity_ObjectToWorld;
					float3 appendResult20_g242132 = (float3(break19_g242132[ 0 ][ 3 ] , break19_g242132[ 1 ][ 3 ] , break19_g242132[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242129 = appendResult20_g242132;
					float3 PivotWS121_g242129 = temp_output_340_7_g242129;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242129 = ( PositionWS122_g242129 - PivotWS121_g242129 );
					#else
					float3 staticSwitch204_g242129 = PositionWS122_g242129;
					#endif
					float3 PositionWO132_g242129 = ( staticSwitch204_g242129 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242137 = PositionWO132_g242129;
					float3 In_PivotWS16_g242137 = PivotWS121_g242129;
					float3 PivotWO133_g242129 = ( PivotWS121_g242129 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242137 = PivotWO133_g242129;
					half3 NormalWS95_g242129 = normalizedWorldNormal;
					float3 In_NormalWS16_g242137 = NormalWS95_g242129;
					half3 TangentWS136_g242129 = TangentWS;
					float3 In_TangentWS16_g242137 = TangentWS136_g242129;
					half3 BiangentWS421_g242129 = BitangentWS;
					float3 In_BitangentWS16_g242137 = BiangentWS421_g242129;
					half3 NormalWS427_g242129 = NormalWS95_g242129;
					half3 localComputeTriplanarWeights427_g242129 = ComputeTriplanarWeights( NormalWS427_g242129 );
					half3 TriplanarWeights429_g242129 = localComputeTriplanarWeights427_g242129;
					float3 In_TriplanarWeights16_g242137 = TriplanarWeights429_g242129;
					float3 normalizeResult296_g242129 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242129 ) );
					half3 ViewDirWS169_g242129 = normalizeResult296_g242129;
					float3 In_ViewDirWS16_g242137 = ViewDirWS169_g242129;
					float4 appendResult397_g242129 = (float4(IN.ase_texcoord10.xy , IN.ase_texcoord10.zw));
					float4 CoordsData398_g242129 = appendResult397_g242129;
					float4 In_CoordsData16_g242137 = CoordsData398_g242129;
					half4 VertexMasks171_g242129 = float4( 0,0,0,0 );
					float4 In_VertexData16_g242137 = VertexMasks171_g242129;
					half4 Phase_Data176_g242129 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g242137 = Phase_Data176_g242129;
					BuildModelFragData( Data16_g242137 , In_Dummy16_g242137 , In_PositionWS16_g242137 , In_PositionWO16_g242137 , In_PivotWS16_g242137 , In_PivotWO16_g242137 , In_NormalWS16_g242137 , In_TangentWS16_g242137 , In_BitangentWS16_g242137 , In_TriplanarWeights16_g242137 , In_ViewDirWS16_g242137 , In_CoordsData16_g242137 , In_VertexData16_g242137 , In_PhaseData16_g242137 );
					TVEModelData DataTerrain26_g242420 = Data16_g242137;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g242420 = IsShaderType2637;
					{
					if (Type26_g242420 == 0 )
					{
					Data26_g242420 = DataDefault26_g242420;
					}
					else if (Type26_g242420 == 1 )
					{
					Data26_g242420 = DataGeneral26_g242420;
					}
					else if (Type26_g242420 == 2 )
					{
					Data26_g242420 = DataBlanket26_g242420;
					}
					else if (Type26_g242420 == 3 )
					{
					Data26_g242420 = DataImpostor26_g242420;
					}
					else if (Type26_g242420 == 4 )
					{
					Data26_g242420 = DataTerrain26_g242420;
					}
					}
					TVEModelData Data15_g251330 =(TVEModelData)Data26_g242420;
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
					float4 Model_CoordsData324_g242450 = Out_CoordsData15_g251330;
					float4 MeshCoords444_g251346 = Model_CoordsData324_g242450;
					float2 UV0444_g251346 = float2( 0,0 );
					float2 UV3444_g251346 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g251346 , MeshCoords444_g251346 , UV0444_g251346 , UV3444_g251346 );
					float4 appendResult430_g251346 = (float4(UV0444_g251346 , UV3444_g251346));
					float4 In_MaskA431_g251346 = appendResult430_g251346;
					float localComputeWorldCoords315_g251346 = ( 0.0 );
					float4 Coords315_g251346 = Local_Coords180_g242450;
					float3 Model_PositionWO222_g242450 = Out_PositionWO15_g251330;
					float3 PositionWS315_g251346 = Model_PositionWO222_g242450;
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
					half3 Model_NormalWS226_g242450 = Out_NormalWS15_g251330;
					float3 temp_output_449_0_g251346 = Model_NormalWS226_g242450;
					float4 In_MaskK431_g251346 = float4( temp_output_449_0_g251346 , 0.0 );
					half3 Model_TangentWS366_g242450 = Out_TangentWS15_g251330;
					float3 temp_output_450_0_g251346 = Model_TangentWS366_g242450;
					float4 In_MaskL431_g251346 = float4( temp_output_450_0_g251346 , 0.0 );
					half3 Model_BitangentWS367_g242450 = Out_BitangentWS15_g251330;
					float3 temp_output_451_0_g251346 = Model_BitangentWS367_g242450;
					float4 In_MaskM431_g251346 = float4( temp_output_451_0_g251346 , 0.0 );
					half3 Model_TriplanarWeights368_g242450 = Out_TriplanarWeights15_g251330;
					float3 temp_output_445_0_g251346 = Model_TriplanarWeights368_g242450;
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
					float4 temp_output_407_277_g242450 = localSampleCoord276_g251356;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251356) = _MainAlbedoTex;
					SamplerState Sampler502_g251356 = staticSwitch36_g251351;
					half2 UV502_g251356 = (Out_MaskA456_g251356).zw;
					half Bias502_g251356 = temp_output_504_0_g251356;
					half2 Normal502_g251356 = float2( 0,0 );
					half4 localSampleCoord502_g251356 = SampleCoord( Texture502_g251356 , Sampler502_g251356 , UV502_g251356 , Bias502_g251356 , Normal502_g251356 );
					float4 temp_output_407_278_g242450 = localSampleCoord502_g251356;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251356) = _MainAlbedoTex;
					SamplerState Sampler496_g251356 = staticSwitch36_g251351;
					float2 temp_output_463_0_g251356 = (Out_MaskB456_g251356).zw;
					half2 XZ496_g251356 = temp_output_463_0_g251356;
					half Bias496_g251356 = temp_output_504_0_g251356;
					float3 temp_output_483_0_g251356 = (Out_MaskK456_g251356).xyz;
					half3 NormalWS496_g251356 = temp_output_483_0_g251356;
					half3 Normal496_g251356 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251356 = SamplePlanar2D( Texture496_g251356 , Sampler496_g251356 , XZ496_g251356 , Bias496_g251356 , NormalWS496_g251356 , Normal496_g251356 );
					float4 temp_output_407_0_g242450 = localSamplePlanar2D496_g251356;
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
					float4 temp_output_407_201_g242450 = localSamplePlanar3D490_g251356;
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
					float4 temp_output_407_202_g242450 = localSampleStochastic2D498_g251356;
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
					float4 temp_output_407_203_g242450 = localSampleStochastic3D500_g251356;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g242450 = temp_output_407_277_g242450;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g242450 = temp_output_407_278_g242450;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g242450 = temp_output_407_0_g242450;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g242450 = temp_output_407_201_g242450;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g242450 = temp_output_407_202_g242450;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g242450 = temp_output_407_203_g242450;
					#else
					float4 staticSwitch184_g242450 = temp_output_407_277_g242450;
					#endif
					half4 Local_AlbedoSample185_g242450 = staticSwitch184_g242450;
					float3 lerpResult53_g242450 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g242450).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g242450 = lerpResult53_g242450;
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
					float4 temp_output_405_277_g242450 = localSampleCoord276_g251354;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251354) = _MainShaderTex;
					SamplerState Sampler502_g251354 = staticSwitch38_g251353;
					half2 UV502_g251354 = (Out_MaskA456_g251354).zw;
					half Bias502_g251354 = temp_output_504_0_g251354;
					half2 Normal502_g251354 = float2( 0,0 );
					half4 localSampleCoord502_g251354 = SampleCoord( Texture502_g251354 , Sampler502_g251354 , UV502_g251354 , Bias502_g251354 , Normal502_g251354 );
					float4 temp_output_405_278_g242450 = localSampleCoord502_g251354;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251354) = _MainShaderTex;
					SamplerState Sampler496_g251354 = staticSwitch38_g251353;
					float2 temp_output_463_0_g251354 = (Out_MaskB456_g251354).zw;
					half2 XZ496_g251354 = temp_output_463_0_g251354;
					half Bias496_g251354 = temp_output_504_0_g251354;
					float3 temp_output_483_0_g251354 = (Out_MaskK456_g251354).xyz;
					half3 NormalWS496_g251354 = temp_output_483_0_g251354;
					half3 Normal496_g251354 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251354 = SamplePlanar2D( Texture496_g251354 , Sampler496_g251354 , XZ496_g251354 , Bias496_g251354 , NormalWS496_g251354 , Normal496_g251354 );
					float4 temp_output_405_0_g242450 = localSamplePlanar2D496_g251354;
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
					float4 temp_output_405_201_g242450 = localSamplePlanar3D490_g251354;
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
					float4 temp_output_405_202_g242450 = localSampleStochastic2D498_g251354;
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
					float4 temp_output_405_203_g242450 = localSampleStochastic3D500_g251354;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g242450 = temp_output_405_277_g242450;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g242450 = temp_output_405_278_g242450;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g242450 = temp_output_405_0_g242450;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g242450 = temp_output_405_201_g242450;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g242450 = temp_output_405_202_g242450;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g242450 = temp_output_405_203_g242450;
					#else
					float4 staticSwitch198_g242450 = temp_output_405_277_g242450;
					#endif
					half4 Local_ShaderSample199_g242450 = staticSwitch198_g242450;
					float temp_output_209_0_g242450 = (Local_ShaderSample199_g242450).y;
					float temp_output_7_0_g251323 = _MainOcclusionRemap.x;
					float temp_output_9_0_g251323 = ( temp_output_209_0_g242450 - temp_output_7_0_g251323 );
					float lerpResult23_g242450 = lerp( 1.0 , saturate( ( temp_output_9_0_g251323 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g242450 = lerpResult23_g242450;
					float temp_output_213_0_g242450 = (Local_ShaderSample199_g242450).w;
					float temp_output_7_0_g251327 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g251327 = ( temp_output_213_0_g242450 - temp_output_7_0_g251327 );
					half Local_Smoothness317_g242450 = ( saturate( ( temp_output_9_0_g251327 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g242450 = (float4(( (Local_ShaderSample199_g242450).x * _MainMetallicValue ) , Local_Occlusion313_g242450 , (Local_ShaderSample199_g242450).z , Local_Smoothness317_g242450));
					half4 Local_Masks109_g242450 = appendResult73_g242450;
					float temp_output_135_0_g242450 = (Local_Masks109_g242450).z;
					float temp_output_7_0_g251322 = _MainMultiRemap.x;
					float temp_output_9_0_g251322 = ( temp_output_135_0_g242450 - temp_output_7_0_g251322 );
					float temp_output_42_0_g242450 = saturate( ( temp_output_9_0_g251322 * _MainMultiRemap.z ) );
					half Local_MultiMask78_g242450 = temp_output_42_0_g242450;
					float lerpResult58_g242450 = lerp( 1.0 , Local_MultiMask78_g242450 , _MainColorMode);
					float4 lerpResult62_g242450 = lerp( _MainColorTwo , _MainColor , lerpResult58_g242450);
					half3 Local_ColorRGB93_g242450 = (lerpResult62_g242450).rgb;
					half3 Local_Albedo139_g242450 = ( Local_AlbedoRGB107_g242450 * Local_ColorRGB93_g242450 );
					float3 temp_output_4_0_g251315 = Local_Albedo139_g242450;
					float3 In_Albedo3_g251315 = temp_output_4_0_g251315;
					float3 temp_output_44_0_g251315 = Local_Albedo139_g242450;
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
					float2 temp_output_406_394_g242450 = Normal276_g251355;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251355) = _MainNormalTex;
					SamplerState Sampler502_g251355 = staticSwitch37_g251352;
					half2 UV502_g251355 = (Out_MaskA456_g251355).zw;
					half Bias502_g251355 = temp_output_504_0_g251355;
					half2 Normal502_g251355 = float2( 0,0 );
					half4 localSampleCoord502_g251355 = SampleCoord( Texture502_g251355 , Sampler502_g251355 , UV502_g251355 , Bias502_g251355 , Normal502_g251355 );
					float2 temp_output_406_397_g242450 = Normal502_g251355;
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
					float2 temp_output_406_375_g242450 = (worldToTangentDir408_g251355).xy;
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
					float2 temp_output_406_353_g242450 = (worldToTangentDir399_g251355).xy;
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
					float2 temp_output_406_391_g242450 = (worldToTangentDir411_g251355).xy;
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
					float2 temp_output_406_390_g242450 = (worldToTangentDir403_g251355).xy;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g242450 = temp_output_406_394_g242450;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g242450 = temp_output_406_397_g242450;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g242450 = temp_output_406_375_g242450;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g242450 = temp_output_406_353_g242450;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g242450 = temp_output_406_391_g242450;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g242450 = temp_output_406_390_g242450;
					#else
					float2 staticSwitch193_g242450 = temp_output_406_394_g242450;
					#endif
					half2 Local_NormaSample191_g242450 = staticSwitch193_g242450;
					half2 Local_NormalTS108_g242450 = ( Local_NormaSample191_g242450 * _MainNormalValue );
					float2 In_NormalTS3_g251315 = Local_NormalTS108_g242450;
					float3 appendResult68_g251329 = (float3(Local_NormalTS108_g242450 , 1.0));
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal74_g251329 = appendResult68_g251329;
					float3 worldNormal74_g251329 = normalize( float3( dot( tanToWorld0, tanNormal74_g251329 ), dot( tanToWorld1, tanNormal74_g251329 ), dot( tanToWorld2, tanNormal74_g251329 ) ) );
					half3 Local_NormalWS250_g242450 = worldNormal74_g251329;
					float3 In_NormalWS3_g251315 = Local_NormalWS250_g242450;
					float4 In_Shader3_g251315 = Local_Masks109_g242450;
					float4 In_Feature3_g251315 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251315 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251315 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g251326 = Local_Albedo139_g242450;
					float dotResult20_g251326 = dot( temp_output_3_0_g251326 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g242450 = dotResult20_g251326;
					float temp_output_12_0_g251315 = Local_Grayscale110_g242450;
					float In_Grayscale3_g251315 = temp_output_12_0_g251315;
					float clampResult27_g251328 = clamp( saturate( ( Local_Grayscale110_g242450 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g242450 = clampResult27_g251328;
					float temp_output_16_0_g251315 = Local_Luminosity145_g242450;
					float In_Luminosity3_g251315 = temp_output_16_0_g251315;
					float In_MultiMask3_g251315 = Local_MultiMask78_g242450;
					float temp_output_187_0_g242450 = (Local_AlbedoSample185_g242450).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g242450 = ( temp_output_187_0_g242450 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g242450 = temp_output_187_0_g242450;
					#endif
					half Local_AlphaClip111_g242450 = staticSwitch236_g242450;
					float In_AlphaClip3_g251315 = Local_AlphaClip111_g242450;
					half Local_AlphaFade246_g242450 = (lerpResult62_g242450).a;
					float In_AlphaFade3_g251315 = Local_AlphaFade246_g242450;
					float3 temp_cast_20 = (1.0).xxx;
					float3 In_Translucency3_g251315 = temp_cast_20;
					float In_Transmission3_g251315 = 1.0;
					float In_Thickness3_g251315 = 0.0;
					float In_Diffusion3_g251315 = 0.0;
					float In_Depth3_g251315 = 0.0;
					BuildVisualData( Data3_g251315 , In_Dummy3_g251315 , In_Albedo3_g251315 , In_AlbedoBase3_g251315 , In_NormalTS3_g251315 , In_NormalWS3_g251315 , In_Shader3_g251315 , In_Feature3_g251315 , In_Season3_g251315 , In_Emissive3_g251315 , In_Grayscale3_g251315 , In_Luminosity3_g251315 , In_MultiMask3_g251315 , In_AlphaClip3_g251315 , In_AlphaFade3_g251315 , In_Translucency3_g251315 , In_Transmission3_g251315 , In_Thickness3_g251315 , In_Diffusion3_g251315 , In_Depth3_g251315 );
					TVEVisualData Data4_g251367 =(TVEVisualData)Data3_g251315;
					float Out_Dummy4_g251367 = 0.0;
					float3 Out_Albedo4_g251367 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251367 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251367 = float2( 0,0 );
					float3 Out_NormalWS4_g251367 = float3( 0,0,0 );
					float4 Out_Shader4_g251367 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251367 = float4( 0,0,0,0 );
					float4 Out_Season4_g251367 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251367 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251367 = 0.0;
					float Out_Grayscale4_g251367 = 0.0;
					float Out_Luminosity4_g251367 = 0.0;
					float Out_AlphaClip4_g251367 = 0.0;
					float Out_AlphaFade4_g251367 = 0.0;
					float3 Out_Translucency4_g251367 = float3( 0,0,0 );
					float Out_Transmission4_g251367 = 0.0;
					float Out_Thickness4_g251367 = 0.0;
					float Out_Diffusion4_g251367 = 0.0;
					float Out_Depth4_g251367 = 0.0;
					BreakVisualData( Data4_g251367 , Out_Dummy4_g251367 , Out_Albedo4_g251367 , Out_AlbedoBase4_g251367 , Out_NormalTS4_g251367 , Out_NormalWS4_g251367 , Out_Shader4_g251367 , Out_Feature4_g251367 , Out_Season4_g251367 , Out_Emissive4_g251367 , Out_MultiMask4_g251367 , Out_Grayscale4_g251367 , Out_Luminosity4_g251367 , Out_AlphaClip4_g251367 , Out_AlphaFade4_g251367 , Out_Translucency4_g251367 , Out_Transmission4_g251367 , Out_Thickness4_g251367 , Out_Diffusion4_g251367 , Out_Depth4_g251367 );
					float Alpha109_g251362 = Out_AlphaClip4_g251367;
					float lerpResult91_g251362 = lerp( 1.0 , Alpha109_g251362 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g251362 = lerp( 1.0 , lerpResult91_g251362 , Filter152_g251362);
					clip( lerpResult154_g251362 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2609_114;
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

					o.Emission = ( lerpResult72_g251362 * lerpResult84_g251362 );
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
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_COLOR
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_vertex TVE_FLATTEN
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
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
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
					float4 ase_texcoord7 : TEXCOORD7;
					float4 ase_texcoord8 : TEXCOORD8;
					float4 ase_color : COLOR;
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
				uniform half _FlattenIntensityValue;
				uniform half _FlattenMeshMode;
				uniform half4 _FlattenMeshRemap;
				uniform half _FlattenMeshValue;
				uniform half3 _FlattenSphereOffsetValue;
				uniform half _FlattenSphereValue;
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
				
				float3 ASESafeNormalize(float3 inVec)
				{
					float dp3 = max(1.175494351e-38, dot(inVec, inVec));
					return inVec* rsqrt(dp3);
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

					float localIfModelDataByShader26_g242169 = ( 0.0 );
					TVEModelData Data26_g242169 = (TVEModelData)0;
					TVEModelData Data16_g242159 =(TVEModelData)0;
					half Dummy207_g242149 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g242159 = Dummy207_g242149;
					float In_Dummy16_g242159 = temp_output_14_0_g242159;
					float3 PositionOS131_g242149 = v.vertex.xyz;
					float3 temp_output_4_0_g242159 = PositionOS131_g242149;
					float3 In_PositionOS16_g242159 = temp_output_4_0_g242159;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g242149 = ase_positionWS;
					float3 vertexToFrag73_g242149 = temp_output_104_7_g242149;
					float3 PositionWS122_g242149 = vertexToFrag73_g242149;
					float3 In_PositionWS16_g242159 = PositionWS122_g242149;
					float4x4 break19_g242152 = unity_ObjectToWorld;
					float3 appendResult20_g242152 = (float3(break19_g242152[ 0 ][ 3 ] , break19_g242152[ 1 ][ 3 ] , break19_g242152[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242149 = appendResult20_g242152;
					float4x4 break19_g242154 = unity_ObjectToWorld;
					float3 appendResult20_g242154 = (float3(break19_g242154[ 0 ][ 3 ] , break19_g242154[ 1 ][ 3 ] , break19_g242154[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g242150 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g242149 = PositionOS131_g242149;
					float3 appendResult234_g242149 = (float3(break233_g242149.x , 0.0 , break233_g242149.z));
					float3 break413_g242149 = PositionOS131_g242149;
					float3 appendResult414_g242149 = (float3(break413_g242149.x , break413_g242149.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g242156 = appendResult414_g242149;
					#else
					float3 staticSwitch65_g242156 = appendResult234_g242149;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g242149 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g242149 = appendResult60_g242150;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g242149 = staticSwitch65_g242156;
					#else
					float3 staticSwitch229_g242149 = _Vector0;
					#endif
					float3 PivotOS149_g242149 = staticSwitch229_g242149;
					float3 temp_output_122_0_g242154 = PivotOS149_g242149;
					float3 PivotsOnlyWS105_g242154 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g242154 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g242149 = ( appendResult20_g242154 + PivotsOnlyWS105_g242154 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g242149 = temp_output_340_7_g242149;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g242149 = temp_output_341_7_g242149;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g242149 = temp_output_341_7_g242149;
					#else
					float3 staticSwitch236_g242149 = temp_output_340_7_g242149;
					#endif
					float3 vertexToFrag76_g242149 = staticSwitch236_g242149;
					float3 PivotWS121_g242149 = vertexToFrag76_g242149;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242149 = ( PositionWS122_g242149 - PivotWS121_g242149 );
					#else
					float3 staticSwitch204_g242149 = PositionWS122_g242149;
					#endif
					float3 PositionWO132_g242149 = ( staticSwitch204_g242149 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242159 = PositionWO132_g242149;
					float3 In_PositionRawOS16_g242159 = PositionOS131_g242149;
					float3 In_PivotOS16_g242159 = PivotOS149_g242149;
					float3 In_PivotWS16_g242159 = PivotWS121_g242149;
					float3 PivotWO133_g242149 = ( PivotWS121_g242149 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242159 = PivotWO133_g242149;
					half3 NormalOS134_g242149 = v.normal;
					float3 temp_output_21_0_g242159 = NormalOS134_g242149;
					float3 In_NormalOS16_g242159 = temp_output_21_0_g242159;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g242149 = normalizedWorldNormal;
					float3 In_NormalWS16_g242159 = NormalWS95_g242149;
					float3 In_NormalRawOS16_g242159 = NormalOS134_g242149;
					half4 TangentlOS153_g242149 = v.tangent;
					float4 temp_output_6_0_g242159 = TangentlOS153_g242149;
					float4 In_TangentOS16_g242159 = temp_output_6_0_g242159;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g242149 = ase_tangentWS;
					float3 In_TangentWS16_g242159 = TangentWS136_g242149;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g242149 = ase_bitangentWS;
					float3 In_BitangentWS16_g242159 = BiangentWS421_g242149;
					float3 normalizeResult296_g242149 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242149 ) );
					half3 ViewDirWS169_g242149 = normalizeResult296_g242149;
					float3 In_ViewDirWS16_g242159 = ViewDirWS169_g242149;
					float4 appendResult397_g242149 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g242149 = appendResult397_g242149;
					float4 In_CoordsData16_g242159 = CoordsData398_g242149;
					half4 VertexMasks171_g242149 = v.ase_color;
					float4 In_VertexData16_g242159 = VertexMasks171_g242149;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g242162 = (PositionOS131_g242149).z;
					#else
					float staticSwitch65_g242162 = (PositionOS131_g242149).y;
					#endif
					half Object_HeightValue267_g242149 = _ObjectHeightValue;
					half Bounds_HeightMask274_g242149 = saturate( ( staticSwitch65_g242162 / Object_HeightValue267_g242149 ) );
					half3 Position387_g242149 = PositionOS131_g242149;
					half Height387_g242149 = Object_HeightValue267_g242149;
					half Object_RadiusValue268_g242149 = _ObjectRadiusValue;
					half Radius387_g242149 = Object_RadiusValue268_g242149;
					half localCapsuleMaskYUp387_g242149 = CapsuleMaskYUp( Position387_g242149 , Height387_g242149 , Radius387_g242149 );
					half3 Position408_g242149 = PositionOS131_g242149;
					half Height408_g242149 = Object_HeightValue267_g242149;
					half Radius408_g242149 = Object_RadiusValue268_g242149;
					half localCapsuleMaskZUp408_g242149 = CapsuleMaskZUp( Position408_g242149 , Height408_g242149 , Radius408_g242149 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g242167 = saturate( localCapsuleMaskZUp408_g242149 );
					#else
					float staticSwitch65_g242167 = saturate( localCapsuleMaskYUp387_g242149 );
					#endif
					half Bounds_SphereMask282_g242149 = staticSwitch65_g242167;
					float4 appendResult253_g242149 = (float4(Bounds_HeightMask274_g242149 , Bounds_SphereMask282_g242149 , 1.0 , 1.0));
					half4 MasksData254_g242149 = appendResult253_g242149;
					float4 In_MasksData16_g242159 = MasksData254_g242149;
					float temp_output_17_0_g242161 = _ObjectPhaseMode;
					float Option70_g242161 = temp_output_17_0_g242161;
					float4 temp_output_3_0_g242161 = v.ase_color;
					float4 Channel70_g242161 = temp_output_3_0_g242161;
					float localSwitchChannel470_g242161 = SwitchChannel4( Option70_g242161 , Channel70_g242161 );
					half Phase_Value372_g242149 = localSwitchChannel470_g242161;
					float3 break319_g242149 = PivotWO133_g242149;
					half Pivot_Position322_g242149 = ( break319_g242149.x + break319_g242149.z );
					half Phase_Position357_g242149 = ( Phase_Value372_g242149 + Pivot_Position322_g242149 );
					float temp_output_248_0_g242149 = frac( Phase_Position357_g242149 );
					float4 appendResult177_g242149 = (float4(( (frac( ( Phase_Position357_g242149 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g242149));
					half4 Phase_Data176_g242149 = appendResult177_g242149;
					float4 In_PhaseData16_g242159 = Phase_Data176_g242149;
					float4 In_TransformData16_g242159 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g242159 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g242159 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g242159 , In_Dummy16_g242159 , In_PositionOS16_g242159 , In_PositionWS16_g242159 , In_PositionWO16_g242159 , In_PositionRawOS16_g242159 , In_PivotOS16_g242159 , In_PivotWS16_g242159 , In_PivotWO16_g242159 , In_NormalOS16_g242159 , In_NormalWS16_g242159 , In_NormalRawOS16_g242159 , In_TangentOS16_g242159 , In_TangentWS16_g242159 , In_BitangentWS16_g242159 , In_ViewDirWS16_g242159 , In_CoordsData16_g242159 , In_VertexData16_g242159 , In_MasksData16_g242159 , In_PhaseData16_g242159 , In_TransformData16_g242159 , In_RotationData16_g242159 , In_InterpolatorA16_g242159 );
					TVEModelData DataDefault26_g242169 = Data16_g242159;
					TVEModelData DataGeneral26_g242169 = Data16_g242159;
					TVEModelData DataBlanket26_g242169 = Data16_g242159;
					TVEModelData DataImpostor26_g242169 = Data16_g242159;
					TVEModelData Data16_g242139 =(TVEModelData)0;
					half Dummy207_g242129 = 0.0;
					float temp_output_14_0_g242139 = Dummy207_g242129;
					float In_Dummy16_g242139 = temp_output_14_0_g242139;
					float3 PositionOS131_g242129 = v.vertex.xyz;
					float3 temp_output_4_0_g242139 = PositionOS131_g242129;
					float3 In_PositionOS16_g242139 = temp_output_4_0_g242139;
					float3 temp_output_104_7_g242129 = ase_positionWS;
					float3 PositionWS122_g242129 = temp_output_104_7_g242129;
					float3 In_PositionWS16_g242139 = PositionWS122_g242129;
					float4x4 break19_g242132 = unity_ObjectToWorld;
					float3 appendResult20_g242132 = (float3(break19_g242132[ 0 ][ 3 ] , break19_g242132[ 1 ][ 3 ] , break19_g242132[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242129 = appendResult20_g242132;
					float3 PivotWS121_g242129 = temp_output_340_7_g242129;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242129 = ( PositionWS122_g242129 - PivotWS121_g242129 );
					#else
					float3 staticSwitch204_g242129 = PositionWS122_g242129;
					#endif
					float3 PositionWO132_g242129 = ( staticSwitch204_g242129 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242139 = PositionWO132_g242129;
					float3 In_PositionRawOS16_g242139 = PositionOS131_g242129;
					float3 PivotOS149_g242129 = _Vector0;
					float3 In_PivotOS16_g242139 = PivotOS149_g242129;
					float3 In_PivotWS16_g242139 = PivotWS121_g242129;
					float3 PivotWO133_g242129 = ( PivotWS121_g242129 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242139 = PivotWO133_g242129;
					half3 NormalOS134_g242129 = v.normal;
					float3 temp_output_21_0_g242139 = NormalOS134_g242129;
					float3 In_NormalOS16_g242139 = temp_output_21_0_g242139;
					half3 NormalWS95_g242129 = normalizedWorldNormal;
					float3 In_NormalWS16_g242139 = NormalWS95_g242129;
					float3 In_NormalRawOS16_g242139 = NormalOS134_g242129;
					half4 TangentlOS153_g242129 = v.tangent;
					float4 temp_output_6_0_g242139 = TangentlOS153_g242129;
					float4 In_TangentOS16_g242139 = temp_output_6_0_g242139;
					half3 TangentWS136_g242129 = ase_tangentWS;
					float3 In_TangentWS16_g242139 = TangentWS136_g242129;
					half3 BiangentWS421_g242129 = ase_bitangentWS;
					float3 In_BitangentWS16_g242139 = BiangentWS421_g242129;
					float3 normalizeResult296_g242129 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242129 ) );
					half3 ViewDirWS169_g242129 = normalizeResult296_g242129;
					float3 In_ViewDirWS16_g242139 = ViewDirWS169_g242129;
					float4 appendResult397_g242129 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g242129 = appendResult397_g242129;
					float4 In_CoordsData16_g242139 = CoordsData398_g242129;
					half4 VertexMasks171_g242129 = float4( 0,0,0,0 );
					float4 In_VertexData16_g242139 = VertexMasks171_g242129;
					half4 MasksData254_g242129 = float4( 0,0,0,0 );
					float4 In_MasksData16_g242139 = MasksData254_g242129;
					half4 Phase_Data176_g242129 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g242139 = Phase_Data176_g242129;
					float4 In_TransformData16_g242139 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g242139 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g242139 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g242139 , In_Dummy16_g242139 , In_PositionOS16_g242139 , In_PositionWS16_g242139 , In_PositionWO16_g242139 , In_PositionRawOS16_g242139 , In_PivotOS16_g242139 , In_PivotWS16_g242139 , In_PivotWO16_g242139 , In_NormalOS16_g242139 , In_NormalWS16_g242139 , In_NormalRawOS16_g242139 , In_TangentOS16_g242139 , In_TangentWS16_g242139 , In_BitangentWS16_g242139 , In_ViewDirWS16_g242139 , In_CoordsData16_g242139 , In_VertexData16_g242139 , In_MasksData16_g242139 , In_PhaseData16_g242139 , In_TransformData16_g242139 , In_RotationData16_g242139 , In_InterpolatorA16_g242139 );
					TVEModelData DataTerrain26_g242169 = Data16_g242139;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g242169 = IsShaderType2637;
					{
					if (Type26_g242169 == 0 )
					{
					Data26_g242169 = DataDefault26_g242169;
					}
					else if (Type26_g242169 == 1 )
					{
					Data26_g242169 = DataGeneral26_g242169;
					}
					else if (Type26_g242169 == 2 )
					{
					Data26_g242169 = DataBlanket26_g242169;
					}
					else if (Type26_g242169 == 3 )
					{
					Data26_g242169 = DataImpostor26_g242169;
					}
					else if (Type26_g242169 == 4 )
					{
					Data26_g242169 = DataTerrain26_g242169;
					}
					}
					TVEModelData Data15_g242422 =(TVEModelData)Data26_g242169;
					float Out_Dummy15_g242422 = 0.0;
					float3 Out_PositionOS15_g242422 = float3( 0,0,0 );
					float3 Out_PositionWS15_g242422 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242422 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g242422 = float3( 0,0,0 );
					float3 Out_PivotOS15_g242422 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242422 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242422 = float3( 0,0,0 );
					float3 Out_NormalOS15_g242422 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242422 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g242422 = float3( 0,0,0 );
					float4 Out_TangentOS15_g242422 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g242422 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242422 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242422 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242422 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242422 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g242422 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g242422 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g242422 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g242422 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g242422 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g242422 , Out_Dummy15_g242422 , Out_PositionOS15_g242422 , Out_PositionWS15_g242422 , Out_PositionWO15_g242422 , Out_PositionRawOS15_g242422 , Out_PivotOS15_g242422 , Out_PivotWS15_g242422 , Out_PivotWO15_g242422 , Out_NormalOS15_g242422 , Out_NormalWS15_g242422 , Out_NormalRawOS15_g242422 , Out_TangentOS15_g242422 , Out_TangentWS15_g242422 , Out_BitangentWS15_g242422 , Out_ViewDirWS15_g242422 , Out_CoordsData15_g242422 , Out_VertexData15_g242422 , Out_MasksData15_g242422 , Out_PhaseData15_g242422 , Out_TransformData15_g242422 , Out_RotationData15_g242422 , Out_InterpolatorA15_g242422 );
					TVEModelData Data16_g242424 =(TVEModelData)Data15_g242422;
					float temp_output_14_0_g242424 = 0.0;
					float In_Dummy16_g242424 = temp_output_14_0_g242424;
					float3 temp_output_219_24_g242421 = Out_PivotOS15_g242422;
					float3 temp_output_215_0_g242421 = ( Out_PositionOS15_g242422 - temp_output_219_24_g242421 );
					float3 temp_output_4_0_g242424 = temp_output_215_0_g242421;
					float3 In_PositionOS16_g242424 = temp_output_4_0_g242424;
					float3 In_PositionWS16_g242424 = Out_PositionWS15_g242422;
					float3 In_PositionWO16_g242424 = Out_PositionWO15_g242422;
					float3 In_PositionRawOS16_g242424 = Out_PositionRawOS15_g242422;
					float3 In_PivotOS16_g242424 = temp_output_219_24_g242421;
					float3 In_PivotWS16_g242424 = Out_PivotWS15_g242422;
					float3 In_PivotWO16_g242424 = Out_PivotWO15_g242422;
					float3 temp_output_21_0_g242424 = Out_NormalOS15_g242422;
					float3 In_NormalOS16_g242424 = temp_output_21_0_g242424;
					float3 In_NormalWS16_g242424 = Out_NormalWS15_g242422;
					float3 In_NormalRawOS16_g242424 = Out_NormalRawOS15_g242422;
					float4 temp_output_6_0_g242424 = Out_TangentOS15_g242422;
					float4 In_TangentOS16_g242424 = temp_output_6_0_g242424;
					float3 In_TangentWS16_g242424 = Out_TangentWS15_g242422;
					float3 In_BitangentWS16_g242424 = Out_BitangentWS15_g242422;
					float3 In_ViewDirWS16_g242424 = Out_ViewDirWS15_g242422;
					float4 In_CoordsData16_g242424 = Out_CoordsData15_g242422;
					float4 In_VertexData16_g242424 = Out_VertexData15_g242422;
					float4 In_MasksData16_g242424 = Out_MasksData15_g242422;
					float4 In_PhaseData16_g242424 = Out_PhaseData15_g242422;
					float4 In_TransformData16_g242424 = Out_TransformData15_g242422;
					float4 In_RotationData16_g242424 = Out_RotationData15_g242422;
					float4 In_InterpolatorA16_g242424 = Out_InterpolatorA15_g242422;
					BuildModelVertData( Data16_g242424 , In_Dummy16_g242424 , In_PositionOS16_g242424 , In_PositionWS16_g242424 , In_PositionWO16_g242424 , In_PositionRawOS16_g242424 , In_PivotOS16_g242424 , In_PivotWS16_g242424 , In_PivotWO16_g242424 , In_NormalOS16_g242424 , In_NormalWS16_g242424 , In_NormalRawOS16_g242424 , In_TangentOS16_g242424 , In_TangentWS16_g242424 , In_BitangentWS16_g242424 , In_ViewDirWS16_g242424 , In_CoordsData16_g242424 , In_VertexData16_g242424 , In_MasksData16_g242424 , In_PhaseData16_g242424 , In_TransformData16_g242424 , In_RotationData16_g242424 , In_InterpolatorA16_g242424 );
					TVEModelData Data15_g242428 =(TVEModelData)Data16_g242424;
					float Out_Dummy15_g242428 = 0.0;
					float3 Out_PositionOS15_g242428 = float3( 0,0,0 );
					float3 Out_PositionWS15_g242428 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242428 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g242428 = float3( 0,0,0 );
					float3 Out_PivotOS15_g242428 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242428 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242428 = float3( 0,0,0 );
					float3 Out_NormalOS15_g242428 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242428 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g242428 = float3( 0,0,0 );
					float4 Out_TangentOS15_g242428 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g242428 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242428 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242428 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242428 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242428 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g242428 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g242428 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g242428 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g242428 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g242428 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g242428 , Out_Dummy15_g242428 , Out_PositionOS15_g242428 , Out_PositionWS15_g242428 , Out_PositionWO15_g242428 , Out_PositionRawOS15_g242428 , Out_PivotOS15_g242428 , Out_PivotWS15_g242428 , Out_PivotWO15_g242428 , Out_NormalOS15_g242428 , Out_NormalWS15_g242428 , Out_NormalRawOS15_g242428 , Out_TangentOS15_g242428 , Out_TangentWS15_g242428 , Out_BitangentWS15_g242428 , Out_ViewDirWS15_g242428 , Out_CoordsData15_g242428 , Out_VertexData15_g242428 , Out_MasksData15_g242428 , Out_PhaseData15_g242428 , Out_TransformData15_g242428 , Out_RotationData15_g242428 , Out_InterpolatorA15_g242428 );
					TVEModelData Data16_g242429 =(TVEModelData)Data15_g242428;
					half Dummy317_g242427 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g242429 = Dummy317_g242427;
					float In_Dummy16_g242429 = temp_output_14_0_g242429;
					float3 temp_output_4_0_g242429 = Out_PositionOS15_g242428;
					float3 In_PositionOS16_g242429 = temp_output_4_0_g242429;
					float3 In_PositionWS16_g242429 = Out_PositionWS15_g242428;
					float3 temp_output_314_17_g242427 = Out_PositionWO15_g242428;
					float3 In_PositionWO16_g242429 = temp_output_314_17_g242427;
					float3 In_PositionRawOS16_g242429 = Out_PositionRawOS15_g242428;
					float3 In_PivotOS16_g242429 = Out_PivotOS15_g242428;
					float3 In_PivotWS16_g242429 = Out_PivotWS15_g242428;
					float3 temp_output_314_19_g242427 = Out_PivotWO15_g242428;
					float3 In_PivotWO16_g242429 = temp_output_314_19_g242427;
					float3 temp_output_21_0_g242429 = Out_NormalOS15_g242428;
					float3 In_NormalOS16_g242429 = temp_output_21_0_g242429;
					float3 In_NormalWS16_g242429 = Out_NormalWS15_g242428;
					float3 In_NormalRawOS16_g242429 = Out_NormalRawOS15_g242428;
					float4 temp_output_6_0_g242429 = Out_TangentOS15_g242428;
					float4 In_TangentOS16_g242429 = temp_output_6_0_g242429;
					float3 In_TangentWS16_g242429 = Out_TangentWS15_g242428;
					float3 In_BitangentWS16_g242429 = Out_BitangentWS15_g242428;
					float3 In_ViewDirWS16_g242429 = Out_ViewDirWS15_g242428;
					float4 In_CoordsData16_g242429 = Out_CoordsData15_g242428;
					float4 temp_output_314_29_g242427 = Out_VertexData15_g242428;
					float4 In_VertexData16_g242429 = temp_output_314_29_g242427;
					float4 In_MasksData16_g242429 = Out_MasksData15_g242428;
					float4 In_PhaseData16_g242429 = Out_PhaseData15_g242428;
					half4 Model_TransformData356_g242427 = Out_TransformData15_g242428;
					float localBuildGlobalData204_g242340 = ( 0.0 );
					TVEGlobalData Data204_g242340 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g242340 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g242340 = Dummy211_g242340;
					float4 temp_output_589_164_g242340 = TVE_CoatParams;
					half4 Coat_Params596_g242340 = temp_output_589_164_g242340;
					float4 In_CoatParams204_g242340 = Coat_Params596_g242340;
					float4 temp_output_203_0_g242360 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g242420 = ( 0.0 );
					TVEModelData Data26_g242420 = (TVEModelData)0;
					TVEModelData Data16_g242157 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g242157 = 0.0;
					float3 In_PositionWS16_g242157 = PositionWS122_g242149;
					float3 In_PositionWO16_g242157 = PositionWO132_g242149;
					float3 In_PivotWS16_g242157 = PivotWS121_g242149;
					float3 In_PivotWO16_g242157 = PivotWO133_g242149;
					float3 In_NormalWS16_g242157 = NormalWS95_g242149;
					float3 In_TangentWS16_g242157 = TangentWS136_g242149;
					float3 In_BitangentWS16_g242157 = BiangentWS421_g242149;
					half3 NormalWS427_g242149 = NormalWS95_g242149;
					half3 localComputeTriplanarWeights427_g242149 = ComputeTriplanarWeights( NormalWS427_g242149 );
					half3 TriplanarWeights429_g242149 = localComputeTriplanarWeights427_g242149;
					float3 In_TriplanarWeights16_g242157 = TriplanarWeights429_g242149;
					float3 In_ViewDirWS16_g242157 = ViewDirWS169_g242149;
					float4 In_CoordsData16_g242157 = CoordsData398_g242149;
					float4 In_VertexData16_g242157 = VertexMasks171_g242149;
					float4 In_PhaseData16_g242157 = Phase_Data176_g242149;
					BuildModelFragData( Data16_g242157 , In_Dummy16_g242157 , In_PositionWS16_g242157 , In_PositionWO16_g242157 , In_PivotWS16_g242157 , In_PivotWO16_g242157 , In_NormalWS16_g242157 , In_TangentWS16_g242157 , In_BitangentWS16_g242157 , In_TriplanarWeights16_g242157 , In_ViewDirWS16_g242157 , In_CoordsData16_g242157 , In_VertexData16_g242157 , In_PhaseData16_g242157 );
					TVEModelData DataDefault26_g242420 = Data16_g242157;
					TVEModelData DataGeneral26_g242420 = Data16_g242157;
					TVEModelData DataBlanket26_g242420 = Data16_g242157;
					TVEModelData DataImpostor26_g242420 = Data16_g242157;
					TVEModelData Data16_g242137 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g242137 = 0.0;
					float3 In_PositionWS16_g242137 = PositionWS122_g242129;
					float3 In_PositionWO16_g242137 = PositionWO132_g242129;
					float3 In_PivotWS16_g242137 = PivotWS121_g242129;
					float3 In_PivotWO16_g242137 = PivotWO133_g242129;
					float3 In_NormalWS16_g242137 = NormalWS95_g242129;
					float3 In_TangentWS16_g242137 = TangentWS136_g242129;
					float3 In_BitangentWS16_g242137 = BiangentWS421_g242129;
					half3 NormalWS427_g242129 = NormalWS95_g242129;
					half3 localComputeTriplanarWeights427_g242129 = ComputeTriplanarWeights( NormalWS427_g242129 );
					half3 TriplanarWeights429_g242129 = localComputeTriplanarWeights427_g242129;
					float3 In_TriplanarWeights16_g242137 = TriplanarWeights429_g242129;
					float3 In_ViewDirWS16_g242137 = ViewDirWS169_g242129;
					float4 In_CoordsData16_g242137 = CoordsData398_g242129;
					float4 In_VertexData16_g242137 = VertexMasks171_g242129;
					float4 In_PhaseData16_g242137 = Phase_Data176_g242129;
					BuildModelFragData( Data16_g242137 , In_Dummy16_g242137 , In_PositionWS16_g242137 , In_PositionWO16_g242137 , In_PivotWS16_g242137 , In_PivotWO16_g242137 , In_NormalWS16_g242137 , In_TangentWS16_g242137 , In_BitangentWS16_g242137 , In_TriplanarWeights16_g242137 , In_ViewDirWS16_g242137 , In_CoordsData16_g242137 , In_VertexData16_g242137 , In_PhaseData16_g242137 );
					TVEModelData DataTerrain26_g242420 = Data16_g242137;
					float Type26_g242420 = IsShaderType2637;
					{
					if (Type26_g242420 == 0 )
					{
					Data26_g242420 = DataDefault26_g242420;
					}
					else if (Type26_g242420 == 1 )
					{
					Data26_g242420 = DataGeneral26_g242420;
					}
					else if (Type26_g242420 == 2 )
					{
					Data26_g242420 = DataBlanket26_g242420;
					}
					else if (Type26_g242420 == 3 )
					{
					Data26_g242420 = DataImpostor26_g242420;
					}
					else if (Type26_g242420 == 4 )
					{
					Data26_g242420 = DataTerrain26_g242420;
					}
					}
					TVEModelData Data15_g242416 =(TVEModelData)Data26_g242420;
					float Out_Dummy15_g242416 = 0.0;
					float3 Out_PositionWS15_g242416 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242416 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242416 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242416 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242416 = float3( 0,0,0 );
					float3 Out_TangentWS15_g242416 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242416 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g242416 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242416 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242416 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242416 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g242416 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g242416 , Out_Dummy15_g242416 , Out_PositionWS15_g242416 , Out_PositionWO15_g242416 , Out_PivotWS15_g242416 , Out_PivotWO15_g242416 , Out_NormalWS15_g242416 , Out_TangentWS15_g242416 , Out_BitangentWS15_g242416 , Out_TriplanarWeights15_g242416 , Out_ViewDirWS15_g242416 , Out_CoordsData15_g242416 , Out_VertexData15_g242416 , Out_PhaseData15_g242416 );
					float3 Model_PositionWS497_g242340 = Out_PositionWS15_g242416;
					float2 Model_PositionWS_XZ143_g242340 = (Model_PositionWS497_g242340).xz;
					float3 Model_PivotWS498_g242340 = Out_PivotWS15_g242416;
					float2 Model_PivotWS_XZ145_g242340 = (Model_PivotWS498_g242340).xz;
					float2 lerpResult300_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g242360 = lerpResult300_g242340;
					float temp_output_82_0_g242358 = _GlobalCoatLayerValue;
					float temp_output_82_0_g242360 = temp_output_82_0_g242358;
					float4 tex2DArrayNode83_g242360 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242360).zw + ( (temp_output_203_0_g242360).xy * temp_output_81_0_g242360 ) ),temp_output_82_0_g242360), 0.0 );
					float4 appendResult210_g242360 = (float4(tex2DArrayNode83_g242360.rgb , saturate( tex2DArrayNode83_g242360.a )));
					float4 temp_output_204_0_g242360 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g242360 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242360).zw + ( (temp_output_204_0_g242360).xy * temp_output_81_0_g242360 ) ),temp_output_82_0_g242360), 0.0 );
					float4 appendResult212_g242360 = (float4(tex2DArrayNode122_g242360.rgb , saturate( tex2DArrayNode122_g242360.a )));
					float4 TVE_RenderNearPositionR628_g242340 = TVE_RenderNearPositionR;
					float temp_output_507_0_g242340 = saturate( ( distance( Model_PositionWS497_g242340 , (TVE_RenderNearPositionR628_g242340).xyz ) / (TVE_RenderNearPositionR628_g242340).w ) );
					float temp_output_7_0_g242341 = 1.0;
					float temp_output_9_0_g242341 = ( temp_output_507_0_g242340 - temp_output_7_0_g242341 );
					half TVE_RenderNearFadeValue635_g242340 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g242340 = saturate( ( temp_output_9_0_g242341 / ( ( TVE_RenderNearFadeValue635_g242340 - temp_output_7_0_g242341 ) + 0.0001 ) ) );
					float4 lerpResult131_g242360 = lerp( appendResult210_g242360 , appendResult212_g242360 , Global_TexBlend509_g242340);
					float4 temp_output_159_109_g242358 = lerpResult131_g242360;
					float4 lerpResult168_g242358 = lerp( TVE_CoatParams , temp_output_159_109_g242358 , TVE_CoatLayers[(int)temp_output_82_0_g242358]);
					float4 temp_output_589_109_g242340 = lerpResult168_g242358;
					half4 Coat_Texture302_g242340 = temp_output_589_109_g242340;
					float4 In_CoatTexture204_g242340 = Coat_Texture302_g242340;
					float4 temp_output_595_164_g242340 = TVE_PaintParams;
					half4 Paint_Params575_g242340 = temp_output_595_164_g242340;
					float4 In_PaintParams204_g242340 = Paint_Params575_g242340;
					float4 temp_output_203_0_g242409 = TVE_PaintBaseCoord;
					float2 lerpResult85_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g242409 = lerpResult85_g242340;
					float temp_output_82_0_g242406 = _GlobalPaintLayerValue;
					float temp_output_82_0_g242409 = temp_output_82_0_g242406;
					float4 tex2DArrayNode83_g242409 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242409).zw + ( (temp_output_203_0_g242409).xy * temp_output_81_0_g242409 ) ),temp_output_82_0_g242409), 0.0 );
					float4 appendResult210_g242409 = (float4(tex2DArrayNode83_g242409.rgb , saturate( tex2DArrayNode83_g242409.a )));
					float4 temp_output_204_0_g242409 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g242409 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242409).zw + ( (temp_output_204_0_g242409).xy * temp_output_81_0_g242409 ) ),temp_output_82_0_g242409), 0.0 );
					float4 appendResult212_g242409 = (float4(tex2DArrayNode122_g242409.rgb , saturate( tex2DArrayNode122_g242409.a )));
					float4 lerpResult131_g242409 = lerp( appendResult210_g242409 , appendResult212_g242409 , Global_TexBlend509_g242340);
					float4 temp_output_171_109_g242406 = lerpResult131_g242409;
					float4 lerpResult174_g242406 = lerp( TVE_PaintParams , temp_output_171_109_g242406 , TVE_PaintLayers[(int)temp_output_82_0_g242406]);
					float4 temp_output_595_109_g242340 = lerpResult174_g242406;
					half4 Paint_Texture71_g242340 = temp_output_595_109_g242340;
					float4 In_PaintTexture204_g242340 = Paint_Texture71_g242340;
					float4 temp_output_590_141_g242340 = TVE_AtmoParams;
					half4 Atmo_Params601_g242340 = temp_output_590_141_g242340;
					float4 In_AtmoParams204_g242340 = Atmo_Params601_g242340;
					float4 temp_output_203_0_g242368 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g242368 = lerpResult104_g242340;
					float temp_output_132_0_g242366 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g242368 = temp_output_132_0_g242366;
					float4 tex2DArrayNode83_g242368 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242368).zw + ( (temp_output_203_0_g242368).xy * temp_output_81_0_g242368 ) ),temp_output_82_0_g242368), 0.0 );
					float4 appendResult210_g242368 = (float4(tex2DArrayNode83_g242368.rgb , saturate( tex2DArrayNode83_g242368.a )));
					float4 temp_output_204_0_g242368 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g242368 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242368).zw + ( (temp_output_204_0_g242368).xy * temp_output_81_0_g242368 ) ),temp_output_82_0_g242368), 0.0 );
					float4 appendResult212_g242368 = (float4(tex2DArrayNode122_g242368.rgb , saturate( tex2DArrayNode122_g242368.a )));
					float4 lerpResult131_g242368 = lerp( appendResult210_g242368 , appendResult212_g242368 , Global_TexBlend509_g242340);
					float4 temp_output_137_109_g242366 = lerpResult131_g242368;
					float4 lerpResult145_g242366 = lerp( TVE_AtmoParams , temp_output_137_109_g242366 , TVE_AtmoLayers[(int)temp_output_132_0_g242366]);
					float4 temp_output_590_110_g242340 = lerpResult145_g242366;
					half4 Atmo_Texture80_g242340 = temp_output_590_110_g242340;
					float4 In_AtmoTexture204_g242340 = Atmo_Texture80_g242340;
					float4 temp_output_593_163_g242340 = TVE_GlowParams;
					half4 Glow_Params609_g242340 = temp_output_593_163_g242340;
					float4 In_GlowParams204_g242340 = Glow_Params609_g242340;
					float4 temp_output_203_0_g242384 = TVE_GlowBaseCoord;
					float2 lerpResult247_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g242384 = lerpResult247_g242340;
					float temp_output_82_0_g242382 = _GlobalGlowLayerValue;
					float temp_output_82_0_g242384 = temp_output_82_0_g242382;
					float4 tex2DArrayNode83_g242384 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242384).zw + ( (temp_output_203_0_g242384).xy * temp_output_81_0_g242384 ) ),temp_output_82_0_g242384), 0.0 );
					float4 appendResult210_g242384 = (float4(tex2DArrayNode83_g242384.rgb , saturate( tex2DArrayNode83_g242384.a )));
					float4 temp_output_204_0_g242384 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g242384 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242384).zw + ( (temp_output_204_0_g242384).xy * temp_output_81_0_g242384 ) ),temp_output_82_0_g242384), 0.0 );
					float4 appendResult212_g242384 = (float4(tex2DArrayNode122_g242384.rgb , saturate( tex2DArrayNode122_g242384.a )));
					float4 lerpResult131_g242384 = lerp( appendResult210_g242384 , appendResult212_g242384 , Global_TexBlend509_g242340);
					float4 temp_output_159_109_g242382 = lerpResult131_g242384;
					float4 lerpResult167_g242382 = lerp( TVE_GlowParams , temp_output_159_109_g242382 , TVE_GlowLayers[(int)temp_output_82_0_g242382]);
					float4 temp_output_593_109_g242340 = lerpResult167_g242382;
					half4 Glow_Texture248_g242340 = temp_output_593_109_g242340;
					float4 In_GlowTexture204_g242340 = Glow_Texture248_g242340;
					float4 temp_output_592_139_g242340 = TVE_FormParams;
					float4 Form_Params606_g242340 = temp_output_592_139_g242340;
					float4 In_FormParams204_g242340 = Form_Params606_g242340;
					float4 temp_output_203_0_g242400 = TVE_FormBaseCoord;
					float2 lerpResult168_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g242400 = lerpResult168_g242340;
					float temp_output_130_0_g242398 = _GlobalFormLayerValue;
					float temp_output_82_0_g242400 = temp_output_130_0_g242398;
					float4 tex2DArrayNode83_g242400 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242400).zw + ( (temp_output_203_0_g242400).xy * temp_output_81_0_g242400 ) ),temp_output_82_0_g242400), 0.0 );
					float4 appendResult210_g242400 = (float4(tex2DArrayNode83_g242400.rgb , saturate( tex2DArrayNode83_g242400.a )));
					float4 temp_output_204_0_g242400 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g242400 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242400).zw + ( (temp_output_204_0_g242400).xy * temp_output_81_0_g242400 ) ),temp_output_82_0_g242400), 0.0 );
					float4 appendResult212_g242400 = (float4(tex2DArrayNode122_g242400.rgb , saturate( tex2DArrayNode122_g242400.a )));
					float4 lerpResult131_g242400 = lerp( appendResult210_g242400 , appendResult212_g242400 , Global_TexBlend509_g242340);
					float4 temp_output_135_109_g242398 = lerpResult131_g242400;
					float4 lerpResult143_g242398 = lerp( TVE_FormParams , temp_output_135_109_g242398 , TVE_FormLayers[(int)temp_output_130_0_g242398]);
					float4 temp_output_592_0_g242340 = lerpResult143_g242398;
					float4 Form_Texture112_g242340 = temp_output_592_0_g242340;
					float4 In_FormTexture204_g242340 = Form_Texture112_g242340;
					float4 temp_output_594_145_g242340 = TVE_FlowParams;
					half4 Flow_Params612_g242340 = temp_output_594_145_g242340;
					float4 In_FlowParams204_g242340 = Flow_Params612_g242340;
					float4 temp_output_203_0_g242392 = TVE_FlowBaseCoord;
					float2 lerpResult400_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g242392 = lerpResult400_g242340;
					float temp_output_136_0_g242390 = _GlobalFlowLayerValue;
					float temp_output_82_0_g242392 = temp_output_136_0_g242390;
					float4 tex2DArrayNode83_g242392 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242392).zw + ( (temp_output_203_0_g242392).xy * temp_output_81_0_g242392 ) ),temp_output_82_0_g242392), 0.0 );
					float4 appendResult210_g242392 = (float4(tex2DArrayNode83_g242392.rgb , saturate( tex2DArrayNode83_g242392.a )));
					float4 temp_output_204_0_g242392 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g242392 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242392).zw + ( (temp_output_204_0_g242392).xy * temp_output_81_0_g242392 ) ),temp_output_82_0_g242392), 0.0 );
					float4 appendResult212_g242392 = (float4(tex2DArrayNode122_g242392.rgb , saturate( tex2DArrayNode122_g242392.a )));
					float4 lerpResult131_g242392 = lerp( appendResult210_g242392 , appendResult212_g242392 , Global_TexBlend509_g242340);
					float4 temp_output_141_109_g242390 = lerpResult131_g242392;
					float4 lerpResult149_g242390 = lerp( TVE_FlowParams , temp_output_141_109_g242390 , TVE_FlowLayers[(int)temp_output_136_0_g242390]);
					half4 Flow_Texture405_g242340 = lerpResult149_g242390;
					float4 In_FlowTexture204_g242340 = Flow_Texture405_g242340;
					BuildGlobalData( Data204_g242340 , In_Dummy204_g242340 , In_CoatParams204_g242340 , In_CoatTexture204_g242340 , In_PaintParams204_g242340 , In_PaintTexture204_g242340 , In_AtmoParams204_g242340 , In_AtmoTexture204_g242340 , In_GlowParams204_g242340 , In_GlowTexture204_g242340 , In_FormParams204_g242340 , In_FormTexture204_g242340 , In_FlowParams204_g242340 , In_FlowTexture204_g242340 );
					TVEGlobalData Data15_g242430 =(TVEGlobalData)Data204_g242340;
					float Out_Dummy15_g242430 = 0.0;
					float4 Out_CoatParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g242430 = float4( 0,0,0,0 );
					BreakData( Data15_g242430 , Out_Dummy15_g242430 , Out_CoatParams15_g242430 , Out_CoatTexture15_g242430 , Out_PaintParams15_g242430 , Out_PaintTexture15_g242430 , Out_AtmoParams15_g242430 , Out_AtmoTexture15_g242430 , Out_GlowParams15_g242430 , Out_GlowTexture15_g242430 , Out_FormParams15_g242430 , Out_FormTexture15_g242430 , Out_FlowParams15_g242430 , Out_FlowTexture15_g242430 );
					float4 Global_FormTexture351_g242427 = Out_FormTexture15_g242430;
					float3 Model_PivotWO353_g242427 = temp_output_314_19_g242427;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g242436 = _ConformMeshMode;
					float Option70_g242436 = temp_output_17_0_g242436;
					half4 Model_VertexData357_g242427 = temp_output_314_29_g242427;
					float4 temp_output_3_0_g242436 = Model_VertexData357_g242427;
					float4 Channel70_g242436 = temp_output_3_0_g242436;
					float localSwitchChannel470_g242436 = SwitchChannel4( Option70_g242436 , Channel70_g242436 );
					float temp_output_390_0_g242427 = localSwitchChannel470_g242436;
					float temp_output_7_0_g242433 = _ConformMeshRemap.x;
					float temp_output_9_0_g242433 = ( temp_output_390_0_g242427 - temp_output_7_0_g242433 );
					float lerpResult374_g242427 = lerp( 1.0 , saturate( ( temp_output_9_0_g242433 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g242427 = lerpResult374_g242427;
					float temp_output_328_0_g242427 = ( Blend_VertMask379_g242427 * TVE_IsEnabled );
					half Conform_Mask366_g242427 = temp_output_328_0_g242427;
					float temp_output_322_0_g242427 = ( ( ( ( (Global_FormTexture351_g242427).z - ( (Model_PivotWO353_g242427).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g242427 ) );
					float3 appendResult329_g242427 = (float3(0.0 , temp_output_322_0_g242427 , 0.0));
					float3 appendResult387_g242427 = (float3(0.0 , 0.0 , temp_output_322_0_g242427));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g242434 = appendResult387_g242427;
					#else
					float3 staticSwitch65_g242434 = appendResult329_g242427;
					#endif
					float3 Blanket_Conform368_g242427 = staticSwitch65_g242434;
					float4 appendResult312_g242427 = (float4(Blanket_Conform368_g242427 , 0.0));
					float4 temp_output_310_0_g242427 = ( Model_TransformData356_g242427 + appendResult312_g242427 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g242427 = temp_output_310_0_g242427;
					#else
					float4 staticSwitch364_g242427 = Model_TransformData356_g242427;
					#endif
					half4 Final_TransformData365_g242427 = staticSwitch364_g242427;
					float4 In_TransformData16_g242429 = Final_TransformData365_g242427;
					float4 In_RotationData16_g242429 = Out_RotationData15_g242428;
					float4 In_InterpolatorA16_g242429 = Out_InterpolatorA15_g242428;
					BuildModelVertData( Data16_g242429 , In_Dummy16_g242429 , In_PositionOS16_g242429 , In_PositionWS16_g242429 , In_PositionWO16_g242429 , In_PositionRawOS16_g242429 , In_PivotOS16_g242429 , In_PivotWS16_g242429 , In_PivotWO16_g242429 , In_NormalOS16_g242429 , In_NormalWS16_g242429 , In_NormalRawOS16_g242429 , In_TangentOS16_g242429 , In_TangentWS16_g242429 , In_BitangentWS16_g242429 , In_ViewDirWS16_g242429 , In_CoordsData16_g242429 , In_VertexData16_g242429 , In_MasksData16_g242429 , In_PhaseData16_g242429 , In_TransformData16_g242429 , In_RotationData16_g242429 , In_InterpolatorA16_g242429 );
					TVEModelData Data15_g242440 =(TVEModelData)Data16_g242429;
					float Out_Dummy15_g242440 = 0.0;
					float3 Out_PositionOS15_g242440 = float3( 0,0,0 );
					float3 Out_PositionWS15_g242440 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242440 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g242440 = float3( 0,0,0 );
					float3 Out_PivotOS15_g242440 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242440 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242440 = float3( 0,0,0 );
					float3 Out_NormalOS15_g242440 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242440 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g242440 = float3( 0,0,0 );
					float4 Out_TangentOS15_g242440 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g242440 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242440 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242440 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242440 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242440 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g242440 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g242440 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g242440 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g242440 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g242440 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g242440 , Out_Dummy15_g242440 , Out_PositionOS15_g242440 , Out_PositionWS15_g242440 , Out_PositionWO15_g242440 , Out_PositionRawOS15_g242440 , Out_PivotOS15_g242440 , Out_PivotWS15_g242440 , Out_PivotWO15_g242440 , Out_NormalOS15_g242440 , Out_NormalWS15_g242440 , Out_NormalRawOS15_g242440 , Out_TangentOS15_g242440 , Out_TangentWS15_g242440 , Out_BitangentWS15_g242440 , Out_ViewDirWS15_g242440 , Out_CoordsData15_g242440 , Out_VertexData15_g242440 , Out_MasksData15_g242440 , Out_PhaseData15_g242440 , Out_TransformData15_g242440 , Out_RotationData15_g242440 , Out_InterpolatorA15_g242440 );
					TVEModelData Data16_g242441 =(TVEModelData)Data15_g242440;
					float temp_output_14_0_g242441 = 0.0;
					float In_Dummy16_g242441 = temp_output_14_0_g242441;
					float3 Model_PositionOS147_g242439 = Out_PositionOS15_g242440;
					half3 VertexPos40_g242445 = Model_PositionOS147_g242439;
					float4 temp_output_1567_33_g242439 = Out_RotationData15_g242440;
					half4 Model_RotationData1569_g242439 = temp_output_1567_33_g242439;
					float2 break1582_g242439 = (Model_RotationData1569_g242439).xy;
					half Angle44_g242445 = break1582_g242439.y;
					half CosAngle89_g242445 = cos( Angle44_g242445 );
					half SinAngle93_g242445 = sin( Angle44_g242445 );
					float3 appendResult95_g242445 = (float3((VertexPos40_g242445).x , ( ( (VertexPos40_g242445).y * CosAngle89_g242445 ) - ( (VertexPos40_g242445).z * SinAngle93_g242445 ) ) , ( ( (VertexPos40_g242445).y * SinAngle93_g242445 ) + ( (VertexPos40_g242445).z * CosAngle89_g242445 ) )));
					half3 VertexPos40_g242446 = appendResult95_g242445;
					half Angle44_g242446 = -break1582_g242439.x;
					half CosAngle94_g242446 = cos( Angle44_g242446 );
					half SinAngle95_g242446 = sin( Angle44_g242446 );
					float3 appendResult98_g242446 = (float3(( ( (VertexPos40_g242446).x * CosAngle94_g242446 ) - ( (VertexPos40_g242446).y * SinAngle95_g242446 ) ) , ( ( (VertexPos40_g242446).x * SinAngle95_g242446 ) + ( (VertexPos40_g242446).y * CosAngle94_g242446 ) ) , (VertexPos40_g242446).z));
					half3 VertexPos40_g242444 = Model_PositionOS147_g242439;
					half Angle44_g242444 = break1582_g242439.y;
					half CosAngle89_g242444 = cos( Angle44_g242444 );
					half SinAngle93_g242444 = sin( Angle44_g242444 );
					float3 appendResult95_g242444 = (float3((VertexPos40_g242444).x , ( ( (VertexPos40_g242444).y * CosAngle89_g242444 ) - ( (VertexPos40_g242444).z * SinAngle93_g242444 ) ) , ( ( (VertexPos40_g242444).y * SinAngle93_g242444 ) + ( (VertexPos40_g242444).z * CosAngle89_g242444 ) )));
					half3 VertexPos40_g242449 = appendResult95_g242444;
					half Angle44_g242449 = break1582_g242439.x;
					half CosAngle91_g242449 = cos( Angle44_g242449 );
					half SinAngle92_g242449 = sin( Angle44_g242449 );
					float3 appendResult93_g242449 = (float3(( ( (VertexPos40_g242449).x * CosAngle91_g242449 ) + ( (VertexPos40_g242449).z * SinAngle92_g242449 ) ) , (VertexPos40_g242449).y , ( ( -(VertexPos40_g242449).x * SinAngle92_g242449 ) + ( (VertexPos40_g242449).z * CosAngle91_g242449 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g242447 = appendResult93_g242449;
					#else
					float3 staticSwitch65_g242447 = appendResult98_g242446;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g242442 = staticSwitch65_g242447;
					#else
					float3 staticSwitch65_g242442 = Model_PositionOS147_g242439;
					#endif
					float3 temp_output_1608_0_g242439 = staticSwitch65_g242442;
					half3 VertexPos40_g242448 = temp_output_1608_0_g242439;
					half Angle44_g242448 = (Model_RotationData1569_g242439).z;
					half CosAngle91_g242448 = cos( Angle44_g242448 );
					half SinAngle92_g242448 = sin( Angle44_g242448 );
					float3 appendResult93_g242448 = (float3(( ( (VertexPos40_g242448).x * CosAngle91_g242448 ) + ( (VertexPos40_g242448).z * SinAngle92_g242448 ) ) , (VertexPos40_g242448).y , ( ( -(VertexPos40_g242448).x * SinAngle92_g242448 ) + ( (VertexPos40_g242448).z * CosAngle91_g242448 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g242443 = appendResult93_g242448;
					#else
					float3 staticSwitch65_g242443 = temp_output_1608_0_g242439;
					#endif
					float4 temp_output_1567_31_g242439 = Out_TransformData15_g242440;
					half4 Model_TransformData1568_g242439 = temp_output_1567_31_g242439;
					half3 Final_PositionOS178_g242439 = ( ( staticSwitch65_g242443 * (Model_TransformData1568_g242439).w ) + (Model_TransformData1568_g242439).xyz );
					float3 temp_output_4_0_g242441 = Final_PositionOS178_g242439;
					float3 In_PositionOS16_g242441 = temp_output_4_0_g242441;
					float3 In_PositionWS16_g242441 = Out_PositionWS15_g242440;
					float3 In_PositionWO16_g242441 = Out_PositionWO15_g242440;
					float3 In_PositionRawOS16_g242441 = Out_PositionRawOS15_g242440;
					float3 In_PivotOS16_g242441 = Out_PivotOS15_g242440;
					float3 In_PivotWS16_g242441 = Out_PivotWS15_g242440;
					float3 In_PivotWO16_g242441 = Out_PivotWO15_g242440;
					float3 temp_output_21_0_g242441 = Out_NormalOS15_g242440;
					float3 In_NormalOS16_g242441 = temp_output_21_0_g242441;
					float3 In_NormalWS16_g242441 = Out_NormalWS15_g242440;
					float3 In_NormalRawOS16_g242441 = Out_NormalRawOS15_g242440;
					float4 temp_output_6_0_g242441 = Out_TangentOS15_g242440;
					float4 In_TangentOS16_g242441 = temp_output_6_0_g242441;
					float3 In_TangentWS16_g242441 = Out_TangentWS15_g242440;
					float3 In_BitangentWS16_g242441 = Out_BitangentWS15_g242440;
					float3 In_ViewDirWS16_g242441 = Out_ViewDirWS15_g242440;
					float4 In_CoordsData16_g242441 = Out_CoordsData15_g242440;
					float4 In_VertexData16_g242441 = Out_VertexData15_g242440;
					float4 In_MasksData16_g242441 = Out_MasksData15_g242440;
					float4 In_PhaseData16_g242441 = Out_PhaseData15_g242440;
					float4 In_TransformData16_g242441 = temp_output_1567_31_g242439;
					float4 In_RotationData16_g242441 = temp_output_1567_33_g242439;
					float4 In_InterpolatorA16_g242441 = Out_InterpolatorA15_g242440;
					BuildModelVertData( Data16_g242441 , In_Dummy16_g242441 , In_PositionOS16_g242441 , In_PositionWS16_g242441 , In_PositionWO16_g242441 , In_PositionRawOS16_g242441 , In_PivotOS16_g242441 , In_PivotWS16_g242441 , In_PivotWO16_g242441 , In_NormalOS16_g242441 , In_NormalWS16_g242441 , In_NormalRawOS16_g242441 , In_TangentOS16_g242441 , In_TangentWS16_g242441 , In_BitangentWS16_g242441 , In_ViewDirWS16_g242441 , In_CoordsData16_g242441 , In_VertexData16_g242441 , In_MasksData16_g242441 , In_PhaseData16_g242441 , In_TransformData16_g242441 , In_RotationData16_g242441 , In_InterpolatorA16_g242441 );
					TVEModelData Data15_g251358 =(TVEModelData)Data16_g242441;
					float Out_Dummy15_g251358 = 0.0;
					float3 Out_PositionOS15_g251358 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251358 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251358 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251358 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251358 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251358 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251358 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251358 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251358 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251358 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251358 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251358 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251358 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251358 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251358 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251358 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251358 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251358 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251358 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251358 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251358 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251358 , Out_Dummy15_g251358 , Out_PositionOS15_g251358 , Out_PositionWS15_g251358 , Out_PositionWO15_g251358 , Out_PositionRawOS15_g251358 , Out_PivotOS15_g251358 , Out_PivotWS15_g251358 , Out_PivotWO15_g251358 , Out_NormalOS15_g251358 , Out_NormalWS15_g251358 , Out_NormalRawOS15_g251358 , Out_TangentOS15_g251358 , Out_TangentWS15_g251358 , Out_BitangentWS15_g251358 , Out_ViewDirWS15_g251358 , Out_CoordsData15_g251358 , Out_VertexData15_g251358 , Out_MasksData15_g251358 , Out_PhaseData15_g251358 , Out_TransformData15_g251358 , Out_RotationData15_g251358 , Out_InterpolatorA15_g251358 );
					TVEModelData Data16_g251359 =(TVEModelData)Data15_g251358;
					float temp_output_14_0_g251359 = 0.0;
					float In_Dummy16_g251359 = temp_output_14_0_g251359;
					float3 temp_output_217_24_g251357 = Out_PivotOS15_g251358;
					float3 temp_output_216_0_g251357 = ( Out_PositionOS15_g251358 + temp_output_217_24_g251357 );
					float3 temp_output_4_0_g251359 = temp_output_216_0_g251357;
					float3 In_PositionOS16_g251359 = temp_output_4_0_g251359;
					float3 In_PositionWS16_g251359 = Out_PositionWS15_g251358;
					float3 In_PositionWO16_g251359 = Out_PositionWO15_g251358;
					float3 In_PositionRawOS16_g251359 = Out_PositionRawOS15_g251358;
					float3 In_PivotOS16_g251359 = temp_output_217_24_g251357;
					float3 In_PivotWS16_g251359 = Out_PivotWS15_g251358;
					float3 In_PivotWO16_g251359 = Out_PivotWO15_g251358;
					float3 temp_output_21_0_g251359 = Out_NormalOS15_g251358;
					float3 In_NormalOS16_g251359 = temp_output_21_0_g251359;
					float3 In_NormalWS16_g251359 = Out_NormalWS15_g251358;
					float3 In_NormalRawOS16_g251359 = Out_NormalRawOS15_g251358;
					float4 temp_output_6_0_g251359 = Out_TangentOS15_g251358;
					float4 In_TangentOS16_g251359 = temp_output_6_0_g251359;
					float3 In_TangentWS16_g251359 = Out_TangentWS15_g251358;
					float3 In_BitangentWS16_g251359 = Out_BitangentWS15_g251358;
					float3 In_ViewDirWS16_g251359 = Out_ViewDirWS15_g251358;
					float4 In_CoordsData16_g251359 = Out_CoordsData15_g251358;
					float4 In_VertexData16_g251359 = Out_VertexData15_g251358;
					float4 In_MasksData16_g251359 = Out_MasksData15_g251358;
					float4 In_PhaseData16_g251359 = Out_PhaseData15_g251358;
					float4 In_TransformData16_g251359 = Out_TransformData15_g251358;
					float4 In_RotationData16_g251359 = Out_RotationData15_g251358;
					float4 In_InterpolatorA16_g251359 = Out_InterpolatorA15_g251358;
					BuildModelVertData( Data16_g251359 , In_Dummy16_g251359 , In_PositionOS16_g251359 , In_PositionWS16_g251359 , In_PositionWO16_g251359 , In_PositionRawOS16_g251359 , In_PivotOS16_g251359 , In_PivotWS16_g251359 , In_PivotWO16_g251359 , In_NormalOS16_g251359 , In_NormalWS16_g251359 , In_NormalRawOS16_g251359 , In_TangentOS16_g251359 , In_TangentWS16_g251359 , In_BitangentWS16_g251359 , In_ViewDirWS16_g251359 , In_CoordsData16_g251359 , In_VertexData16_g251359 , In_MasksData16_g251359 , In_PhaseData16_g251359 , In_TransformData16_g251359 , In_RotationData16_g251359 , In_InterpolatorA16_g251359 );
					TVEModelData Data15_g251368 =(TVEModelData)Data16_g251359;
					float Out_Dummy15_g251368 = 0.0;
					float3 Out_PositionOS15_g251368 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251368 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251368 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251368 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251368 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251368 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251368 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251368 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251368 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251368 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251368 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251368 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251368 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251368 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251368 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251368 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251368 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251368 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251368 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251368 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251368 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251368 , Out_Dummy15_g251368 , Out_PositionOS15_g251368 , Out_PositionWS15_g251368 , Out_PositionWO15_g251368 , Out_PositionRawOS15_g251368 , Out_PivotOS15_g251368 , Out_PivotWS15_g251368 , Out_PivotWO15_g251368 , Out_NormalOS15_g251368 , Out_NormalWS15_g251368 , Out_NormalRawOS15_g251368 , Out_TangentOS15_g251368 , Out_TangentWS15_g251368 , Out_BitangentWS15_g251368 , Out_ViewDirWS15_g251368 , Out_CoordsData15_g251368 , Out_VertexData15_g251368 , Out_MasksData15_g251368 , Out_PhaseData15_g251368 , Out_TransformData15_g251368 , Out_RotationData15_g251368 , Out_InterpolatorA15_g251368 );
					
					float3 color107_g242418 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g242418 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float localBreakData4_g242417 = ( 0.0 );
					float localBuildMasksData3_g242335 = ( 0.0 );
					TVEMasksData Data3_g242335 = (TVEMasksData)0;
					half Feature_Intensity1873_g242329 = _FlattenIntensityValue;
					float ifLocalVar18_g242337 = 0;
					if( Feature_Intensity1873_g242329 <= 0.0 )
					ifLocalVar18_g242337 = 0.0;
					else
					ifLocalVar18_g242337 = 1.0;
					float4 appendResult1869_g242329 = (float4(ifLocalVar18_g242337 , 0.0 , 0.0 , 0.0));
					float4 In_MaskA3_g242335 = appendResult1869_g242329;
					float temp_output_17_0_g242339 = _FlattenMeshMode;
					float Option70_g242339 = temp_output_17_0_g242339;
					TVEModelData Data15_g242330 =(TVEModelData)Data26_g242169;
					float Out_Dummy15_g242330 = 0.0;
					float3 Out_PositionOS15_g242330 = float3( 0,0,0 );
					float3 Out_PositionWS15_g242330 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242330 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g242330 = float3( 0,0,0 );
					float3 Out_PivotOS15_g242330 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242330 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242330 = float3( 0,0,0 );
					float3 Out_NormalOS15_g242330 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242330 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g242330 = float3( 0,0,0 );
					float4 Out_TangentOS15_g242330 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g242330 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242330 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242330 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242330 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242330 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g242330 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g242330 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g242330 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g242330 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g242330 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g242330 , Out_Dummy15_g242330 , Out_PositionOS15_g242330 , Out_PositionWS15_g242330 , Out_PositionWO15_g242330 , Out_PositionRawOS15_g242330 , Out_PivotOS15_g242330 , Out_PivotWS15_g242330 , Out_PivotWO15_g242330 , Out_NormalOS15_g242330 , Out_NormalWS15_g242330 , Out_NormalRawOS15_g242330 , Out_TangentOS15_g242330 , Out_TangentWS15_g242330 , Out_BitangentWS15_g242330 , Out_ViewDirWS15_g242330 , Out_CoordsData15_g242330 , Out_VertexData15_g242330 , Out_MasksData15_g242330 , Out_PhaseData15_g242330 , Out_TransformData15_g242330 , Out_RotationData15_g242330 , Out_InterpolatorA15_g242330 );
					float4 temp_output_1810_29_g242329 = Out_VertexData15_g242330;
					half4 Model_VertexData1826_g242329 = temp_output_1810_29_g242329;
					float4 temp_output_3_0_g242339 = Model_VertexData1826_g242329;
					float4 Channel70_g242339 = temp_output_3_0_g242339;
					float localSwitchChannel470_g242339 = SwitchChannel4( Option70_g242339 , Channel70_g242339 );
					float clampResult17_g242333 = clamp( localSwitchChannel470_g242339 , 0.0001 , 0.9999 );
					float temp_output_7_0_g242334 = _FlattenMeshRemap.x;
					float temp_output_9_0_g242334 = ( clampResult17_g242333 - temp_output_7_0_g242334 );
					float lerpResult1841_g242329 = lerp( 1.0 , saturate( ( temp_output_9_0_g242334 * _FlattenMeshRemap.z ) ) , _FlattenMeshValue);
					half Normal_MeskMask1847_g242329 = lerpResult1841_g242329;
					half Normal_Mask1851_g242329 = Normal_MeskMask1847_g242329;
					float ifLocalVar18_g242336 = 0;
					if( Feature_Intensity1873_g242329 <= 0.0 )
					ifLocalVar18_g242336 = 0.0;
					else
					ifLocalVar18_g242336 = Normal_Mask1851_g242329;
					float4 appendResult1870_g242329 = (float4(ifLocalVar18_g242336 , 0.0 , 0.0 , 0.0));
					float4 In_MaskB3_g242335 = appendResult1870_g242329;
					half3 Model_NormalOS1829_g242329 = Out_NormalOS15_g242330;
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g242331 = half3( 0, 0, 1 );
					#else
					float3 staticSwitch65_g242331 = half3( 0, 1, 0 );
					#endif
					float3 lerpResult1820_g242329 = lerp( Model_NormalOS1829_g242329 , staticSwitch65_g242331 , _FlattenIntensityValue);
					float3 temp_output_1810_26_g242329 = Out_PositionRawOS15_g242330;
					float3 Model_PositionBaseOS1837_g242329 = temp_output_1810_26_g242329;
					float3 normalizeResult1816_g242329 = ASESafeNormalize( ( Model_PositionBaseOS1837_g242329 + _FlattenSphereOffsetValue ) );
					float3 lerpResult1813_g242329 = lerp( lerpResult1820_g242329 , normalizeResult1816_g242329 , _FlattenSphereValue);
					float3 lerpResult1856_g242329 = lerp( Model_NormalOS1829_g242329 , lerpResult1813_g242329 , Normal_Mask1851_g242329);
					#ifdef TVE_FLATTEN
					float3 staticSwitch1857_g242329 = lerpResult1856_g242329;
					#else
					float3 staticSwitch1857_g242329 = Model_NormalOS1829_g242329;
					#endif
					half3 Final_NormalOS1853_g242329 = staticSwitch1857_g242329;
					float3 ifLocalVar18_g242338 = 0;
					if( Feature_Intensity1873_g242329 <= 0.0 )
					ifLocalVar18_g242338 = Model_NormalOS1829_g242329;
					else
					ifLocalVar18_g242338 = Final_NormalOS1853_g242329;
					float4 appendResult1830_g242329 = (float4(ifLocalVar18_g242338 , 0.0));
					float4 In_MaskC3_g242335 = appendResult1830_g242329;
					float4 temp_cast_11 = (0.0).xxxx;
					float4 In_MaskD3_g242335 = temp_cast_11;
					float4 temp_cast_12 = (0.0).xxxx;
					float4 In_MaskE3_g242335 = temp_cast_12;
					float4 temp_cast_13 = (0.0).xxxx;
					float4 In_MaskF3_g242335 = temp_cast_13;
					float4 temp_cast_14 = (0.0).xxxx;
					float4 In_MaskG3_g242335 = temp_cast_14;
					float4 temp_cast_15 = (0.0).xxxx;
					float4 In_MaskH3_g242335 = temp_cast_15;
					float4 temp_cast_16 = (0.0).xxxx;
					float4 In_MaskI3_g242335 = temp_cast_16;
					float4 temp_cast_17 = (0.0).xxxx;
					float4 In_MaskJ3_g242335 = temp_cast_17;
					float4 temp_cast_18 = (0.0).xxxx;
					float4 In_MaskK3_g242335 = temp_cast_18;
					float4 temp_cast_19 = (0.0).xxxx;
					float4 In_MaskL3_g242335 = temp_cast_19;
					{
					Data3_g242335.MaskA = In_MaskA3_g242335;
					Data3_g242335.MaskB = In_MaskB3_g242335;
					Data3_g242335.MaskC = In_MaskC3_g242335;
					Data3_g242335.MaskD = In_MaskD3_g242335;
					Data3_g242335.MaskE = In_MaskE3_g242335;
					Data3_g242335.MaskF = In_MaskF3_g242335;
					Data3_g242335.MaskG = In_MaskG3_g242335;
					Data3_g242335.MaskH = In_MaskH3_g242335;
					Data3_g242335.MaskI = In_MaskI3_g242335;
					Data3_g242335.MaskJ= In_MaskJ3_g242335;
					Data3_g242335.MaskK= In_MaskK3_g242335;
					Data3_g242335.MaskL = In_MaskL3_g242335;
					}
					TVEMasksData Data4_g242417 = Data3_g242335;
					float4 Out_MaskA4_g242417 = float4( 0,0,0,0 );
					float4 Out_MaskB4_g242417 = float4( 0,0,0,0 );
					float4 Out_MaskC4_g242417 = float4( 0,0,0,0 );
					float4 Out_MaskD4_g242417 = float4( 0,0,0,0 );
					float4 Out_MaskE4_g242417 = float4( 0,0,0,0 );
					float4 Out_MaskF4_g242417 = float4( 0,0,0,0 );
					float4 Out_MaskG4_g242417 = float4( 0,0,0,0 );
					float4 Out_MaskH4_g242417 = float4( 0,0,0,0 );
					{
					Out_MaskA4_g242417 = Data4_g242417.MaskA;
					Out_MaskB4_g242417 = Data4_g242417.MaskB;
					Out_MaskC4_g242417 = Data4_g242417.MaskC;
					Out_MaskD4_g242417 = Data4_g242417.MaskD;
					Out_MaskE4_g242417 = Data4_g242417.MaskE;
					Out_MaskF4_g242417 = Data4_g242417.MaskF;
					Out_MaskG4_g242417 = Data4_g242417.MaskG;
					Out_MaskH4_g242417 = Data4_g242417.MaskH;
					}
					float3 lerpResult2568 = lerp( color107_g242418 , color106_g242418 , (Out_MaskA4_g242417).x);
					float3 ifLocalVar40_g242437 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g242437 = lerpResult2568;
					float3 ifLocalVar40_g242438 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g242438 = (Out_MaskB4_g242417).xxx;
					float3 temp_output_2511_0 = (Out_MaskC4_g242417).xyz;
					float3 ifLocalVar40_g242425 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g242425 = temp_output_2511_0;
					float3 objToWorldDir2643 = ASESafeNormalize( mul( unity_ObjectToWorld, float4( temp_output_2511_0, 0.0 ) ).xyz );
					float3 ifLocalVar40_g242426 = 0;
					if( TVE_DEBUG_Index == 5.0 )
					ifLocalVar40_g242426 = objToWorldDir2643;
					float3 vertexToFrag2524 = ( ifLocalVar40_g242437 + ifLocalVar40_g242438 + ( ifLocalVar40_g242425 + ifLocalVar40_g242426 ) );
					o.ase_texcoord4.xyz = vertexToFrag2524;
					float3 vertexPos57_g251362 = v.vertex.xyz;
					float4 ase_positionCS57_g251362 = UnityObjectToClipPos( vertexPos57_g251362 );
					o.ase_texcoord5 = ase_positionCS57_g251362;
					o.ase_texcoord6.xyz = vertexToFrag73_g242149;
					o.ase_texcoord7.xyz = vertexToFrag76_g242149;
					
					o.ase_texcoord8.xy = v.texcoord.xyzw.xy;
					o.ase_texcoord8.zw = v.texcoord2.xyzw.xy;
					o.ase_color = v.ase_color;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord4.w = 0;
					o.ase_texcoord6.w = 0;
					o.ase_texcoord7.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251368;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251368;
					v.tangent = Out_TangentOS15_g251368;

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

					float temp_output_2609_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2609_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2609_114).xxx;
					
					float3 color130_g251362 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g251362 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g251364 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g251363 = ( temp_cast_4 * ( 0.5 + appendResult128_g251364 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g251363 = (float4(ddx( FinalUV13_g251363 ) , ddy( FinalUV13_g251363 )));
					float4 UVDerivatives17_g251363 = appendResult16_g251363;
					float4 break28_g251363 = UVDerivatives17_g251363;
					float2 appendResult19_g251363 = (float2(break28_g251363.x , break28_g251363.z));
					float2 appendResult20_g251363 = (float2(break28_g251363.x , break28_g251363.z));
					float dotResult24_g251363 = dot( appendResult19_g251363 , appendResult20_g251363 );
					float2 appendResult21_g251363 = (float2(break28_g251363.y , break28_g251363.w));
					float2 appendResult22_g251363 = (float2(break28_g251363.y , break28_g251363.w));
					float dotResult23_g251363 = dot( appendResult21_g251363 , appendResult22_g251363 );
					float2 appendResult25_g251363 = (float2(dotResult24_g251363 , dotResult23_g251363));
					float2 derivativesLength29_g251363 = sqrt( appendResult25_g251363 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g251363 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g251363 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g251363 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g251363 = clampResult57_g251363;
					float2 break55_g251363 = derivativesLength29_g251363;
					float4 lerpResult73_g251363 = lerp( float4( color130_g251362 , 0.0 ) , float4( color81_g251362 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g251363.x * break71_g251363.y * sqrt( saturate( ( 1.1 - max( break55_g251363.x, break55_g251363.y ) ) ) ) ) ) ));
					float3 vertexToFrag2524 = IN.ase_texcoord4.xyz;
					half3 Final_Debug2399 = vertexToFrag2524;
					float temp_output_7_0_g251370 = TVE_DEBUG_Min;
					float3 temp_cast_9 = (temp_output_7_0_g251370).xxx;
					float3 temp_output_9_0_g251370 = ( Final_Debug2399 - temp_cast_9 );
					float lerpResult76_g251362 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g251362 = lerpResult76_g251362;
					float3 lerpResult72_g251362 = lerp( (lerpResult73_g251363).rgb , saturate( ( temp_output_9_0_g251370 / ( ( TVE_DEBUG_Max - temp_output_7_0_g251370 ) + 0.0001 ) ) ) , Filter152_g251362);
					float dotResult61_g251362 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g251362 = ( 1.0 - saturate( dotResult61_g251362 ) );
					float Shading_Fresnel59_g251362 = (( 1.0 - ( temp_output_65_0_g251362 * temp_output_65_0_g251362 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g251362 = IN.ase_texcoord5;
					float depthLinearEye57_g251362 = LinearEyeDepth( ase_positionCS57_g251362.z / ase_positionCS57_g251362.w );
					float temp_output_69_0_g251362 = saturate(  (0.0 + ( depthLinearEye57_g251362 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g251362 = (( temp_output_69_0_g251362 * temp_output_69_0_g251362 )*0.5 + 0.5);
					float lerpResult84_g251362 = lerp( 1.0 , Shading_Fresnel59_g251362 , ( Shading_Distance58_g251362 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g251367 = ( 0.0 );
					float localBuildVisualData3_g251315 = ( 0.0 );
					TVEVisualData Data3_g251315 =(TVEVisualData)0;
					half4 Dummy130_g242450 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) );
					float temp_output_14_0_g251315 = Dummy130_g242450.x;
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
					half4 Local_Coords180_g242450 = _main_coord_value;
					float4 Coords444_g251346 = Local_Coords180_g242450;
					float localIfModelDataByShader26_g242420 = ( 0.0 );
					TVEModelData Data26_g242420 = (TVEModelData)0;
					TVEModelData Data16_g242157 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g242157 = 0.0;
					float3 vertexToFrag73_g242149 = IN.ase_texcoord6.xyz;
					float3 PositionWS122_g242149 = vertexToFrag73_g242149;
					float3 In_PositionWS16_g242157 = PositionWS122_g242149;
					float3 vertexToFrag76_g242149 = IN.ase_texcoord7.xyz;
					float3 PivotWS121_g242149 = vertexToFrag76_g242149;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242149 = ( PositionWS122_g242149 - PivotWS121_g242149 );
					#else
					float3 staticSwitch204_g242149 = PositionWS122_g242149;
					#endif
					float3 PositionWO132_g242149 = ( staticSwitch204_g242149 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242157 = PositionWO132_g242149;
					float3 In_PivotWS16_g242157 = PivotWS121_g242149;
					float3 PivotWO133_g242149 = ( PivotWS121_g242149 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242157 = PivotWO133_g242149;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g242149 = normalizedWorldNormal;
					float3 In_NormalWS16_g242157 = NormalWS95_g242149;
					half3 TangentWS136_g242149 = TangentWS;
					float3 In_TangentWS16_g242157 = TangentWS136_g242149;
					half3 BiangentWS421_g242149 = BitangentWS;
					float3 In_BitangentWS16_g242157 = BiangentWS421_g242149;
					half3 NormalWS427_g242149 = NormalWS95_g242149;
					half3 localComputeTriplanarWeights427_g242149 = ComputeTriplanarWeights( NormalWS427_g242149 );
					half3 TriplanarWeights429_g242149 = localComputeTriplanarWeights427_g242149;
					float3 In_TriplanarWeights16_g242157 = TriplanarWeights429_g242149;
					float3 normalizeResult296_g242149 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242149 ) );
					half3 ViewDirWS169_g242149 = normalizeResult296_g242149;
					float3 In_ViewDirWS16_g242157 = ViewDirWS169_g242149;
					float4 appendResult397_g242149 = (float4(IN.ase_texcoord8.xy , IN.ase_texcoord8.zw));
					float4 CoordsData398_g242149 = appendResult397_g242149;
					float4 In_CoordsData16_g242157 = CoordsData398_g242149;
					half4 VertexMasks171_g242149 = IN.ase_color;
					float4 In_VertexData16_g242157 = VertexMasks171_g242149;
					float temp_output_17_0_g242161 = _ObjectPhaseMode;
					float Option70_g242161 = temp_output_17_0_g242161;
					float4 temp_output_3_0_g242161 = IN.ase_color;
					float4 Channel70_g242161 = temp_output_3_0_g242161;
					float localSwitchChannel470_g242161 = SwitchChannel4( Option70_g242161 , Channel70_g242161 );
					half Phase_Value372_g242149 = localSwitchChannel470_g242161;
					float3 break319_g242149 = PivotWO133_g242149;
					half Pivot_Position322_g242149 = ( break319_g242149.x + break319_g242149.z );
					half Phase_Position357_g242149 = ( Phase_Value372_g242149 + Pivot_Position322_g242149 );
					float temp_output_248_0_g242149 = frac( Phase_Position357_g242149 );
					float4 appendResult177_g242149 = (float4(( (frac( ( Phase_Position357_g242149 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g242149));
					half4 Phase_Data176_g242149 = appendResult177_g242149;
					float4 In_PhaseData16_g242157 = Phase_Data176_g242149;
					BuildModelFragData( Data16_g242157 , In_Dummy16_g242157 , In_PositionWS16_g242157 , In_PositionWO16_g242157 , In_PivotWS16_g242157 , In_PivotWO16_g242157 , In_NormalWS16_g242157 , In_TangentWS16_g242157 , In_BitangentWS16_g242157 , In_TriplanarWeights16_g242157 , In_ViewDirWS16_g242157 , In_CoordsData16_g242157 , In_VertexData16_g242157 , In_PhaseData16_g242157 );
					TVEModelData DataDefault26_g242420 = Data16_g242157;
					TVEModelData DataGeneral26_g242420 = Data16_g242157;
					TVEModelData DataBlanket26_g242420 = Data16_g242157;
					TVEModelData DataImpostor26_g242420 = Data16_g242157;
					TVEModelData Data16_g242137 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g242137 = 0.0;
					float3 temp_output_104_7_g242129 = PositionWS;
					float3 PositionWS122_g242129 = temp_output_104_7_g242129;
					float3 In_PositionWS16_g242137 = PositionWS122_g242129;
					float4x4 break19_g242132 = unity_ObjectToWorld;
					float3 appendResult20_g242132 = (float3(break19_g242132[ 0 ][ 3 ] , break19_g242132[ 1 ][ 3 ] , break19_g242132[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242129 = appendResult20_g242132;
					float3 PivotWS121_g242129 = temp_output_340_7_g242129;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242129 = ( PositionWS122_g242129 - PivotWS121_g242129 );
					#else
					float3 staticSwitch204_g242129 = PositionWS122_g242129;
					#endif
					float3 PositionWO132_g242129 = ( staticSwitch204_g242129 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242137 = PositionWO132_g242129;
					float3 In_PivotWS16_g242137 = PivotWS121_g242129;
					float3 PivotWO133_g242129 = ( PivotWS121_g242129 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242137 = PivotWO133_g242129;
					half3 NormalWS95_g242129 = normalizedWorldNormal;
					float3 In_NormalWS16_g242137 = NormalWS95_g242129;
					half3 TangentWS136_g242129 = TangentWS;
					float3 In_TangentWS16_g242137 = TangentWS136_g242129;
					half3 BiangentWS421_g242129 = BitangentWS;
					float3 In_BitangentWS16_g242137 = BiangentWS421_g242129;
					half3 NormalWS427_g242129 = NormalWS95_g242129;
					half3 localComputeTriplanarWeights427_g242129 = ComputeTriplanarWeights( NormalWS427_g242129 );
					half3 TriplanarWeights429_g242129 = localComputeTriplanarWeights427_g242129;
					float3 In_TriplanarWeights16_g242137 = TriplanarWeights429_g242129;
					float3 normalizeResult296_g242129 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242129 ) );
					half3 ViewDirWS169_g242129 = normalizeResult296_g242129;
					float3 In_ViewDirWS16_g242137 = ViewDirWS169_g242129;
					float4 appendResult397_g242129 = (float4(IN.ase_texcoord8.xy , IN.ase_texcoord8.zw));
					float4 CoordsData398_g242129 = appendResult397_g242129;
					float4 In_CoordsData16_g242137 = CoordsData398_g242129;
					half4 VertexMasks171_g242129 = float4( 0,0,0,0 );
					float4 In_VertexData16_g242137 = VertexMasks171_g242129;
					half4 Phase_Data176_g242129 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g242137 = Phase_Data176_g242129;
					BuildModelFragData( Data16_g242137 , In_Dummy16_g242137 , In_PositionWS16_g242137 , In_PositionWO16_g242137 , In_PivotWS16_g242137 , In_PivotWO16_g242137 , In_NormalWS16_g242137 , In_TangentWS16_g242137 , In_BitangentWS16_g242137 , In_TriplanarWeights16_g242137 , In_ViewDirWS16_g242137 , In_CoordsData16_g242137 , In_VertexData16_g242137 , In_PhaseData16_g242137 );
					TVEModelData DataTerrain26_g242420 = Data16_g242137;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g242420 = IsShaderType2637;
					{
					if (Type26_g242420 == 0 )
					{
					Data26_g242420 = DataDefault26_g242420;
					}
					else if (Type26_g242420 == 1 )
					{
					Data26_g242420 = DataGeneral26_g242420;
					}
					else if (Type26_g242420 == 2 )
					{
					Data26_g242420 = DataBlanket26_g242420;
					}
					else if (Type26_g242420 == 3 )
					{
					Data26_g242420 = DataImpostor26_g242420;
					}
					else if (Type26_g242420 == 4 )
					{
					Data26_g242420 = DataTerrain26_g242420;
					}
					}
					TVEModelData Data15_g251330 =(TVEModelData)Data26_g242420;
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
					float4 Model_CoordsData324_g242450 = Out_CoordsData15_g251330;
					float4 MeshCoords444_g251346 = Model_CoordsData324_g242450;
					float2 UV0444_g251346 = float2( 0,0 );
					float2 UV3444_g251346 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g251346 , MeshCoords444_g251346 , UV0444_g251346 , UV3444_g251346 );
					float4 appendResult430_g251346 = (float4(UV0444_g251346 , UV3444_g251346));
					float4 In_MaskA431_g251346 = appendResult430_g251346;
					float localComputeWorldCoords315_g251346 = ( 0.0 );
					float4 Coords315_g251346 = Local_Coords180_g242450;
					float3 Model_PositionWO222_g242450 = Out_PositionWO15_g251330;
					float3 PositionWS315_g251346 = Model_PositionWO222_g242450;
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
					half3 Model_NormalWS226_g242450 = Out_NormalWS15_g251330;
					float3 temp_output_449_0_g251346 = Model_NormalWS226_g242450;
					float4 In_MaskK431_g251346 = float4( temp_output_449_0_g251346 , 0.0 );
					half3 Model_TangentWS366_g242450 = Out_TangentWS15_g251330;
					float3 temp_output_450_0_g251346 = Model_TangentWS366_g242450;
					float4 In_MaskL431_g251346 = float4( temp_output_450_0_g251346 , 0.0 );
					half3 Model_BitangentWS367_g242450 = Out_BitangentWS15_g251330;
					float3 temp_output_451_0_g251346 = Model_BitangentWS367_g242450;
					float4 In_MaskM431_g251346 = float4( temp_output_451_0_g251346 , 0.0 );
					half3 Model_TriplanarWeights368_g242450 = Out_TriplanarWeights15_g251330;
					float3 temp_output_445_0_g251346 = Model_TriplanarWeights368_g242450;
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
					float4 temp_output_407_277_g242450 = localSampleCoord276_g251356;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251356) = _MainAlbedoTex;
					SamplerState Sampler502_g251356 = staticSwitch36_g251351;
					half2 UV502_g251356 = (Out_MaskA456_g251356).zw;
					half Bias502_g251356 = temp_output_504_0_g251356;
					half2 Normal502_g251356 = float2( 0,0 );
					half4 localSampleCoord502_g251356 = SampleCoord( Texture502_g251356 , Sampler502_g251356 , UV502_g251356 , Bias502_g251356 , Normal502_g251356 );
					float4 temp_output_407_278_g242450 = localSampleCoord502_g251356;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251356) = _MainAlbedoTex;
					SamplerState Sampler496_g251356 = staticSwitch36_g251351;
					float2 temp_output_463_0_g251356 = (Out_MaskB456_g251356).zw;
					half2 XZ496_g251356 = temp_output_463_0_g251356;
					half Bias496_g251356 = temp_output_504_0_g251356;
					float3 temp_output_483_0_g251356 = (Out_MaskK456_g251356).xyz;
					half3 NormalWS496_g251356 = temp_output_483_0_g251356;
					half3 Normal496_g251356 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251356 = SamplePlanar2D( Texture496_g251356 , Sampler496_g251356 , XZ496_g251356 , Bias496_g251356 , NormalWS496_g251356 , Normal496_g251356 );
					float4 temp_output_407_0_g242450 = localSamplePlanar2D496_g251356;
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
					float4 temp_output_407_201_g242450 = localSamplePlanar3D490_g251356;
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
					float4 temp_output_407_202_g242450 = localSampleStochastic2D498_g251356;
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
					float4 temp_output_407_203_g242450 = localSampleStochastic3D500_g251356;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g242450 = temp_output_407_277_g242450;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g242450 = temp_output_407_278_g242450;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g242450 = temp_output_407_0_g242450;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g242450 = temp_output_407_201_g242450;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g242450 = temp_output_407_202_g242450;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g242450 = temp_output_407_203_g242450;
					#else
					float4 staticSwitch184_g242450 = temp_output_407_277_g242450;
					#endif
					half4 Local_AlbedoSample185_g242450 = staticSwitch184_g242450;
					float3 lerpResult53_g242450 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g242450).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g242450 = lerpResult53_g242450;
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
					float4 temp_output_405_277_g242450 = localSampleCoord276_g251354;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251354) = _MainShaderTex;
					SamplerState Sampler502_g251354 = staticSwitch38_g251353;
					half2 UV502_g251354 = (Out_MaskA456_g251354).zw;
					half Bias502_g251354 = temp_output_504_0_g251354;
					half2 Normal502_g251354 = float2( 0,0 );
					half4 localSampleCoord502_g251354 = SampleCoord( Texture502_g251354 , Sampler502_g251354 , UV502_g251354 , Bias502_g251354 , Normal502_g251354 );
					float4 temp_output_405_278_g242450 = localSampleCoord502_g251354;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251354) = _MainShaderTex;
					SamplerState Sampler496_g251354 = staticSwitch38_g251353;
					float2 temp_output_463_0_g251354 = (Out_MaskB456_g251354).zw;
					half2 XZ496_g251354 = temp_output_463_0_g251354;
					half Bias496_g251354 = temp_output_504_0_g251354;
					float3 temp_output_483_0_g251354 = (Out_MaskK456_g251354).xyz;
					half3 NormalWS496_g251354 = temp_output_483_0_g251354;
					half3 Normal496_g251354 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251354 = SamplePlanar2D( Texture496_g251354 , Sampler496_g251354 , XZ496_g251354 , Bias496_g251354 , NormalWS496_g251354 , Normal496_g251354 );
					float4 temp_output_405_0_g242450 = localSamplePlanar2D496_g251354;
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
					float4 temp_output_405_201_g242450 = localSamplePlanar3D490_g251354;
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
					float4 temp_output_405_202_g242450 = localSampleStochastic2D498_g251354;
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
					float4 temp_output_405_203_g242450 = localSampleStochastic3D500_g251354;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g242450 = temp_output_405_277_g242450;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g242450 = temp_output_405_278_g242450;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g242450 = temp_output_405_0_g242450;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g242450 = temp_output_405_201_g242450;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g242450 = temp_output_405_202_g242450;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g242450 = temp_output_405_203_g242450;
					#else
					float4 staticSwitch198_g242450 = temp_output_405_277_g242450;
					#endif
					half4 Local_ShaderSample199_g242450 = staticSwitch198_g242450;
					float temp_output_209_0_g242450 = (Local_ShaderSample199_g242450).y;
					float temp_output_7_0_g251323 = _MainOcclusionRemap.x;
					float temp_output_9_0_g251323 = ( temp_output_209_0_g242450 - temp_output_7_0_g251323 );
					float lerpResult23_g242450 = lerp( 1.0 , saturate( ( temp_output_9_0_g251323 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g242450 = lerpResult23_g242450;
					float temp_output_213_0_g242450 = (Local_ShaderSample199_g242450).w;
					float temp_output_7_0_g251327 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g251327 = ( temp_output_213_0_g242450 - temp_output_7_0_g251327 );
					half Local_Smoothness317_g242450 = ( saturate( ( temp_output_9_0_g251327 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g242450 = (float4(( (Local_ShaderSample199_g242450).x * _MainMetallicValue ) , Local_Occlusion313_g242450 , (Local_ShaderSample199_g242450).z , Local_Smoothness317_g242450));
					half4 Local_Masks109_g242450 = appendResult73_g242450;
					float temp_output_135_0_g242450 = (Local_Masks109_g242450).z;
					float temp_output_7_0_g251322 = _MainMultiRemap.x;
					float temp_output_9_0_g251322 = ( temp_output_135_0_g242450 - temp_output_7_0_g251322 );
					float temp_output_42_0_g242450 = saturate( ( temp_output_9_0_g251322 * _MainMultiRemap.z ) );
					half Local_MultiMask78_g242450 = temp_output_42_0_g242450;
					float lerpResult58_g242450 = lerp( 1.0 , Local_MultiMask78_g242450 , _MainColorMode);
					float4 lerpResult62_g242450 = lerp( _MainColorTwo , _MainColor , lerpResult58_g242450);
					half3 Local_ColorRGB93_g242450 = (lerpResult62_g242450).rgb;
					half3 Local_Albedo139_g242450 = ( Local_AlbedoRGB107_g242450 * Local_ColorRGB93_g242450 );
					float3 temp_output_4_0_g251315 = Local_Albedo139_g242450;
					float3 In_Albedo3_g251315 = temp_output_4_0_g251315;
					float3 temp_output_44_0_g251315 = Local_Albedo139_g242450;
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
					float2 temp_output_406_394_g242450 = Normal276_g251355;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251355) = _MainNormalTex;
					SamplerState Sampler502_g251355 = staticSwitch37_g251352;
					half2 UV502_g251355 = (Out_MaskA456_g251355).zw;
					half Bias502_g251355 = temp_output_504_0_g251355;
					half2 Normal502_g251355 = float2( 0,0 );
					half4 localSampleCoord502_g251355 = SampleCoord( Texture502_g251355 , Sampler502_g251355 , UV502_g251355 , Bias502_g251355 , Normal502_g251355 );
					float2 temp_output_406_397_g242450 = Normal502_g251355;
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
					float2 temp_output_406_375_g242450 = (worldToTangentDir408_g251355).xy;
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
					float2 temp_output_406_353_g242450 = (worldToTangentDir399_g251355).xy;
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
					float2 temp_output_406_391_g242450 = (worldToTangentDir411_g251355).xy;
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
					float2 temp_output_406_390_g242450 = (worldToTangentDir403_g251355).xy;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g242450 = temp_output_406_394_g242450;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g242450 = temp_output_406_397_g242450;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g242450 = temp_output_406_375_g242450;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g242450 = temp_output_406_353_g242450;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g242450 = temp_output_406_391_g242450;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g242450 = temp_output_406_390_g242450;
					#else
					float2 staticSwitch193_g242450 = temp_output_406_394_g242450;
					#endif
					half2 Local_NormaSample191_g242450 = staticSwitch193_g242450;
					half2 Local_NormalTS108_g242450 = ( Local_NormaSample191_g242450 * _MainNormalValue );
					float2 In_NormalTS3_g251315 = Local_NormalTS108_g242450;
					float3 appendResult68_g251329 = (float3(Local_NormalTS108_g242450 , 1.0));
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal74_g251329 = appendResult68_g251329;
					float3 worldNormal74_g251329 = normalize( float3( dot( tanToWorld0, tanNormal74_g251329 ), dot( tanToWorld1, tanNormal74_g251329 ), dot( tanToWorld2, tanNormal74_g251329 ) ) );
					half3 Local_NormalWS250_g242450 = worldNormal74_g251329;
					float3 In_NormalWS3_g251315 = Local_NormalWS250_g242450;
					float4 In_Shader3_g251315 = Local_Masks109_g242450;
					float4 In_Feature3_g251315 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251315 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251315 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g251326 = Local_Albedo139_g242450;
					float dotResult20_g251326 = dot( temp_output_3_0_g251326 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g242450 = dotResult20_g251326;
					float temp_output_12_0_g251315 = Local_Grayscale110_g242450;
					float In_Grayscale3_g251315 = temp_output_12_0_g251315;
					float clampResult27_g251328 = clamp( saturate( ( Local_Grayscale110_g242450 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g242450 = clampResult27_g251328;
					float temp_output_16_0_g251315 = Local_Luminosity145_g242450;
					float In_Luminosity3_g251315 = temp_output_16_0_g251315;
					float In_MultiMask3_g251315 = Local_MultiMask78_g242450;
					float temp_output_187_0_g242450 = (Local_AlbedoSample185_g242450).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g242450 = ( temp_output_187_0_g242450 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g242450 = temp_output_187_0_g242450;
					#endif
					half Local_AlphaClip111_g242450 = staticSwitch236_g242450;
					float In_AlphaClip3_g251315 = Local_AlphaClip111_g242450;
					half Local_AlphaFade246_g242450 = (lerpResult62_g242450).a;
					float In_AlphaFade3_g251315 = Local_AlphaFade246_g242450;
					float3 temp_cast_20 = (1.0).xxx;
					float3 In_Translucency3_g251315 = temp_cast_20;
					float In_Transmission3_g251315 = 1.0;
					float In_Thickness3_g251315 = 0.0;
					float In_Diffusion3_g251315 = 0.0;
					float In_Depth3_g251315 = 0.0;
					BuildVisualData( Data3_g251315 , In_Dummy3_g251315 , In_Albedo3_g251315 , In_AlbedoBase3_g251315 , In_NormalTS3_g251315 , In_NormalWS3_g251315 , In_Shader3_g251315 , In_Feature3_g251315 , In_Season3_g251315 , In_Emissive3_g251315 , In_Grayscale3_g251315 , In_Luminosity3_g251315 , In_MultiMask3_g251315 , In_AlphaClip3_g251315 , In_AlphaFade3_g251315 , In_Translucency3_g251315 , In_Transmission3_g251315 , In_Thickness3_g251315 , In_Diffusion3_g251315 , In_Depth3_g251315 );
					TVEVisualData Data4_g251367 =(TVEVisualData)Data3_g251315;
					float Out_Dummy4_g251367 = 0.0;
					float3 Out_Albedo4_g251367 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251367 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251367 = float2( 0,0 );
					float3 Out_NormalWS4_g251367 = float3( 0,0,0 );
					float4 Out_Shader4_g251367 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251367 = float4( 0,0,0,0 );
					float4 Out_Season4_g251367 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251367 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251367 = 0.0;
					float Out_Grayscale4_g251367 = 0.0;
					float Out_Luminosity4_g251367 = 0.0;
					float Out_AlphaClip4_g251367 = 0.0;
					float Out_AlphaFade4_g251367 = 0.0;
					float3 Out_Translucency4_g251367 = float3( 0,0,0 );
					float Out_Transmission4_g251367 = 0.0;
					float Out_Thickness4_g251367 = 0.0;
					float Out_Diffusion4_g251367 = 0.0;
					float Out_Depth4_g251367 = 0.0;
					BreakVisualData( Data4_g251367 , Out_Dummy4_g251367 , Out_Albedo4_g251367 , Out_AlbedoBase4_g251367 , Out_NormalTS4_g251367 , Out_NormalWS4_g251367 , Out_Shader4_g251367 , Out_Feature4_g251367 , Out_Season4_g251367 , Out_Emissive4_g251367 , Out_MultiMask4_g251367 , Out_Grayscale4_g251367 , Out_Luminosity4_g251367 , Out_AlphaClip4_g251367 , Out_AlphaFade4_g251367 , Out_Translucency4_g251367 , Out_Transmission4_g251367 , Out_Thickness4_g251367 , Out_Diffusion4_g251367 , Out_Depth4_g251367 );
					float Alpha109_g251362 = Out_AlphaClip4_g251367;
					float lerpResult91_g251362 = lerp( 1.0 , Alpha109_g251362 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g251362 = lerp( 1.0 , lerpResult91_g251362 , Filter152_g251362);
					clip( lerpResult154_g251362 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2609_114;
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

					o.Emission = ( lerpResult72_g251362 * lerpResult84_g251362 );
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

					float localIfModelDataByShader26_g242169 = ( 0.0 );
					TVEModelData Data26_g242169 = (TVEModelData)0;
					TVEModelData Data16_g242159 =(TVEModelData)0;
					half Dummy207_g242149 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g242159 = Dummy207_g242149;
					float In_Dummy16_g242159 = temp_output_14_0_g242159;
					float3 PositionOS131_g242149 = v.vertex.xyz;
					float3 temp_output_4_0_g242159 = PositionOS131_g242149;
					float3 In_PositionOS16_g242159 = temp_output_4_0_g242159;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g242149 = ase_positionWS;
					float3 vertexToFrag73_g242149 = temp_output_104_7_g242149;
					float3 PositionWS122_g242149 = vertexToFrag73_g242149;
					float3 In_PositionWS16_g242159 = PositionWS122_g242149;
					float4x4 break19_g242152 = unity_ObjectToWorld;
					float3 appendResult20_g242152 = (float3(break19_g242152[ 0 ][ 3 ] , break19_g242152[ 1 ][ 3 ] , break19_g242152[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242149 = appendResult20_g242152;
					float4x4 break19_g242154 = unity_ObjectToWorld;
					float3 appendResult20_g242154 = (float3(break19_g242154[ 0 ][ 3 ] , break19_g242154[ 1 ][ 3 ] , break19_g242154[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g242150 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g242149 = PositionOS131_g242149;
					float3 appendResult234_g242149 = (float3(break233_g242149.x , 0.0 , break233_g242149.z));
					float3 break413_g242149 = PositionOS131_g242149;
					float3 appendResult414_g242149 = (float3(break413_g242149.x , break413_g242149.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g242156 = appendResult414_g242149;
					#else
					float3 staticSwitch65_g242156 = appendResult234_g242149;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g242149 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g242149 = appendResult60_g242150;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g242149 = staticSwitch65_g242156;
					#else
					float3 staticSwitch229_g242149 = _Vector0;
					#endif
					float3 PivotOS149_g242149 = staticSwitch229_g242149;
					float3 temp_output_122_0_g242154 = PivotOS149_g242149;
					float3 PivotsOnlyWS105_g242154 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g242154 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g242149 = ( appendResult20_g242154 + PivotsOnlyWS105_g242154 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g242149 = temp_output_340_7_g242149;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g242149 = temp_output_341_7_g242149;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g242149 = temp_output_341_7_g242149;
					#else
					float3 staticSwitch236_g242149 = temp_output_340_7_g242149;
					#endif
					float3 vertexToFrag76_g242149 = staticSwitch236_g242149;
					float3 PivotWS121_g242149 = vertexToFrag76_g242149;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242149 = ( PositionWS122_g242149 - PivotWS121_g242149 );
					#else
					float3 staticSwitch204_g242149 = PositionWS122_g242149;
					#endif
					float3 PositionWO132_g242149 = ( staticSwitch204_g242149 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242159 = PositionWO132_g242149;
					float3 In_PositionRawOS16_g242159 = PositionOS131_g242149;
					float3 In_PivotOS16_g242159 = PivotOS149_g242149;
					float3 In_PivotWS16_g242159 = PivotWS121_g242149;
					float3 PivotWO133_g242149 = ( PivotWS121_g242149 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242159 = PivotWO133_g242149;
					half3 NormalOS134_g242149 = v.normal;
					float3 temp_output_21_0_g242159 = NormalOS134_g242149;
					float3 In_NormalOS16_g242159 = temp_output_21_0_g242159;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g242149 = normalizedWorldNormal;
					float3 In_NormalWS16_g242159 = NormalWS95_g242149;
					float3 In_NormalRawOS16_g242159 = NormalOS134_g242149;
					half4 TangentlOS153_g242149 = v.tangent;
					float4 temp_output_6_0_g242159 = TangentlOS153_g242149;
					float4 In_TangentOS16_g242159 = temp_output_6_0_g242159;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g242149 = ase_tangentWS;
					float3 In_TangentWS16_g242159 = TangentWS136_g242149;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g242149 = ase_bitangentWS;
					float3 In_BitangentWS16_g242159 = BiangentWS421_g242149;
					float3 normalizeResult296_g242149 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242149 ) );
					half3 ViewDirWS169_g242149 = normalizeResult296_g242149;
					float3 In_ViewDirWS16_g242159 = ViewDirWS169_g242149;
					float4 appendResult397_g242149 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g242149 = appendResult397_g242149;
					float4 In_CoordsData16_g242159 = CoordsData398_g242149;
					half4 VertexMasks171_g242149 = v.ase_color;
					float4 In_VertexData16_g242159 = VertexMasks171_g242149;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g242162 = (PositionOS131_g242149).z;
					#else
					float staticSwitch65_g242162 = (PositionOS131_g242149).y;
					#endif
					half Object_HeightValue267_g242149 = _ObjectHeightValue;
					half Bounds_HeightMask274_g242149 = saturate( ( staticSwitch65_g242162 / Object_HeightValue267_g242149 ) );
					half3 Position387_g242149 = PositionOS131_g242149;
					half Height387_g242149 = Object_HeightValue267_g242149;
					half Object_RadiusValue268_g242149 = _ObjectRadiusValue;
					half Radius387_g242149 = Object_RadiusValue268_g242149;
					half localCapsuleMaskYUp387_g242149 = CapsuleMaskYUp( Position387_g242149 , Height387_g242149 , Radius387_g242149 );
					half3 Position408_g242149 = PositionOS131_g242149;
					half Height408_g242149 = Object_HeightValue267_g242149;
					half Radius408_g242149 = Object_RadiusValue268_g242149;
					half localCapsuleMaskZUp408_g242149 = CapsuleMaskZUp( Position408_g242149 , Height408_g242149 , Radius408_g242149 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g242167 = saturate( localCapsuleMaskZUp408_g242149 );
					#else
					float staticSwitch65_g242167 = saturate( localCapsuleMaskYUp387_g242149 );
					#endif
					half Bounds_SphereMask282_g242149 = staticSwitch65_g242167;
					float4 appendResult253_g242149 = (float4(Bounds_HeightMask274_g242149 , Bounds_SphereMask282_g242149 , 1.0 , 1.0));
					half4 MasksData254_g242149 = appendResult253_g242149;
					float4 In_MasksData16_g242159 = MasksData254_g242149;
					float temp_output_17_0_g242161 = _ObjectPhaseMode;
					float Option70_g242161 = temp_output_17_0_g242161;
					float4 temp_output_3_0_g242161 = v.ase_color;
					float4 Channel70_g242161 = temp_output_3_0_g242161;
					float localSwitchChannel470_g242161 = SwitchChannel4( Option70_g242161 , Channel70_g242161 );
					half Phase_Value372_g242149 = localSwitchChannel470_g242161;
					float3 break319_g242149 = PivotWO133_g242149;
					half Pivot_Position322_g242149 = ( break319_g242149.x + break319_g242149.z );
					half Phase_Position357_g242149 = ( Phase_Value372_g242149 + Pivot_Position322_g242149 );
					float temp_output_248_0_g242149 = frac( Phase_Position357_g242149 );
					float4 appendResult177_g242149 = (float4(( (frac( ( Phase_Position357_g242149 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g242149));
					half4 Phase_Data176_g242149 = appendResult177_g242149;
					float4 In_PhaseData16_g242159 = Phase_Data176_g242149;
					float4 In_TransformData16_g242159 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g242159 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g242159 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g242159 , In_Dummy16_g242159 , In_PositionOS16_g242159 , In_PositionWS16_g242159 , In_PositionWO16_g242159 , In_PositionRawOS16_g242159 , In_PivotOS16_g242159 , In_PivotWS16_g242159 , In_PivotWO16_g242159 , In_NormalOS16_g242159 , In_NormalWS16_g242159 , In_NormalRawOS16_g242159 , In_TangentOS16_g242159 , In_TangentWS16_g242159 , In_BitangentWS16_g242159 , In_ViewDirWS16_g242159 , In_CoordsData16_g242159 , In_VertexData16_g242159 , In_MasksData16_g242159 , In_PhaseData16_g242159 , In_TransformData16_g242159 , In_RotationData16_g242159 , In_InterpolatorA16_g242159 );
					TVEModelData DataDefault26_g242169 = Data16_g242159;
					TVEModelData DataGeneral26_g242169 = Data16_g242159;
					TVEModelData DataBlanket26_g242169 = Data16_g242159;
					TVEModelData DataImpostor26_g242169 = Data16_g242159;
					TVEModelData Data16_g242139 =(TVEModelData)0;
					half Dummy207_g242129 = 0.0;
					float temp_output_14_0_g242139 = Dummy207_g242129;
					float In_Dummy16_g242139 = temp_output_14_0_g242139;
					float3 PositionOS131_g242129 = v.vertex.xyz;
					float3 temp_output_4_0_g242139 = PositionOS131_g242129;
					float3 In_PositionOS16_g242139 = temp_output_4_0_g242139;
					float3 temp_output_104_7_g242129 = ase_positionWS;
					float3 PositionWS122_g242129 = temp_output_104_7_g242129;
					float3 In_PositionWS16_g242139 = PositionWS122_g242129;
					float4x4 break19_g242132 = unity_ObjectToWorld;
					float3 appendResult20_g242132 = (float3(break19_g242132[ 0 ][ 3 ] , break19_g242132[ 1 ][ 3 ] , break19_g242132[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242129 = appendResult20_g242132;
					float3 PivotWS121_g242129 = temp_output_340_7_g242129;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242129 = ( PositionWS122_g242129 - PivotWS121_g242129 );
					#else
					float3 staticSwitch204_g242129 = PositionWS122_g242129;
					#endif
					float3 PositionWO132_g242129 = ( staticSwitch204_g242129 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242139 = PositionWO132_g242129;
					float3 In_PositionRawOS16_g242139 = PositionOS131_g242129;
					float3 PivotOS149_g242129 = _Vector0;
					float3 In_PivotOS16_g242139 = PivotOS149_g242129;
					float3 In_PivotWS16_g242139 = PivotWS121_g242129;
					float3 PivotWO133_g242129 = ( PivotWS121_g242129 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242139 = PivotWO133_g242129;
					half3 NormalOS134_g242129 = v.normal;
					float3 temp_output_21_0_g242139 = NormalOS134_g242129;
					float3 In_NormalOS16_g242139 = temp_output_21_0_g242139;
					half3 NormalWS95_g242129 = normalizedWorldNormal;
					float3 In_NormalWS16_g242139 = NormalWS95_g242129;
					float3 In_NormalRawOS16_g242139 = NormalOS134_g242129;
					half4 TangentlOS153_g242129 = v.tangent;
					float4 temp_output_6_0_g242139 = TangentlOS153_g242129;
					float4 In_TangentOS16_g242139 = temp_output_6_0_g242139;
					half3 TangentWS136_g242129 = ase_tangentWS;
					float3 In_TangentWS16_g242139 = TangentWS136_g242129;
					half3 BiangentWS421_g242129 = ase_bitangentWS;
					float3 In_BitangentWS16_g242139 = BiangentWS421_g242129;
					float3 normalizeResult296_g242129 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242129 ) );
					half3 ViewDirWS169_g242129 = normalizeResult296_g242129;
					float3 In_ViewDirWS16_g242139 = ViewDirWS169_g242129;
					float4 appendResult397_g242129 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g242129 = appendResult397_g242129;
					float4 In_CoordsData16_g242139 = CoordsData398_g242129;
					half4 VertexMasks171_g242129 = float4( 0,0,0,0 );
					float4 In_VertexData16_g242139 = VertexMasks171_g242129;
					half4 MasksData254_g242129 = float4( 0,0,0,0 );
					float4 In_MasksData16_g242139 = MasksData254_g242129;
					half4 Phase_Data176_g242129 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g242139 = Phase_Data176_g242129;
					float4 In_TransformData16_g242139 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g242139 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g242139 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g242139 , In_Dummy16_g242139 , In_PositionOS16_g242139 , In_PositionWS16_g242139 , In_PositionWO16_g242139 , In_PositionRawOS16_g242139 , In_PivotOS16_g242139 , In_PivotWS16_g242139 , In_PivotWO16_g242139 , In_NormalOS16_g242139 , In_NormalWS16_g242139 , In_NormalRawOS16_g242139 , In_TangentOS16_g242139 , In_TangentWS16_g242139 , In_BitangentWS16_g242139 , In_ViewDirWS16_g242139 , In_CoordsData16_g242139 , In_VertexData16_g242139 , In_MasksData16_g242139 , In_PhaseData16_g242139 , In_TransformData16_g242139 , In_RotationData16_g242139 , In_InterpolatorA16_g242139 );
					TVEModelData DataTerrain26_g242169 = Data16_g242139;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g242169 = IsShaderType2637;
					{
					if (Type26_g242169 == 0 )
					{
					Data26_g242169 = DataDefault26_g242169;
					}
					else if (Type26_g242169 == 1 )
					{
					Data26_g242169 = DataGeneral26_g242169;
					}
					else if (Type26_g242169 == 2 )
					{
					Data26_g242169 = DataBlanket26_g242169;
					}
					else if (Type26_g242169 == 3 )
					{
					Data26_g242169 = DataImpostor26_g242169;
					}
					else if (Type26_g242169 == 4 )
					{
					Data26_g242169 = DataTerrain26_g242169;
					}
					}
					TVEModelData Data15_g242422 =(TVEModelData)Data26_g242169;
					float Out_Dummy15_g242422 = 0.0;
					float3 Out_PositionOS15_g242422 = float3( 0,0,0 );
					float3 Out_PositionWS15_g242422 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242422 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g242422 = float3( 0,0,0 );
					float3 Out_PivotOS15_g242422 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242422 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242422 = float3( 0,0,0 );
					float3 Out_NormalOS15_g242422 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242422 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g242422 = float3( 0,0,0 );
					float4 Out_TangentOS15_g242422 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g242422 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242422 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242422 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242422 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242422 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g242422 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g242422 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g242422 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g242422 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g242422 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g242422 , Out_Dummy15_g242422 , Out_PositionOS15_g242422 , Out_PositionWS15_g242422 , Out_PositionWO15_g242422 , Out_PositionRawOS15_g242422 , Out_PivotOS15_g242422 , Out_PivotWS15_g242422 , Out_PivotWO15_g242422 , Out_NormalOS15_g242422 , Out_NormalWS15_g242422 , Out_NormalRawOS15_g242422 , Out_TangentOS15_g242422 , Out_TangentWS15_g242422 , Out_BitangentWS15_g242422 , Out_ViewDirWS15_g242422 , Out_CoordsData15_g242422 , Out_VertexData15_g242422 , Out_MasksData15_g242422 , Out_PhaseData15_g242422 , Out_TransformData15_g242422 , Out_RotationData15_g242422 , Out_InterpolatorA15_g242422 );
					TVEModelData Data16_g242424 =(TVEModelData)Data15_g242422;
					float temp_output_14_0_g242424 = 0.0;
					float In_Dummy16_g242424 = temp_output_14_0_g242424;
					float3 temp_output_219_24_g242421 = Out_PivotOS15_g242422;
					float3 temp_output_215_0_g242421 = ( Out_PositionOS15_g242422 - temp_output_219_24_g242421 );
					float3 temp_output_4_0_g242424 = temp_output_215_0_g242421;
					float3 In_PositionOS16_g242424 = temp_output_4_0_g242424;
					float3 In_PositionWS16_g242424 = Out_PositionWS15_g242422;
					float3 In_PositionWO16_g242424 = Out_PositionWO15_g242422;
					float3 In_PositionRawOS16_g242424 = Out_PositionRawOS15_g242422;
					float3 In_PivotOS16_g242424 = temp_output_219_24_g242421;
					float3 In_PivotWS16_g242424 = Out_PivotWS15_g242422;
					float3 In_PivotWO16_g242424 = Out_PivotWO15_g242422;
					float3 temp_output_21_0_g242424 = Out_NormalOS15_g242422;
					float3 In_NormalOS16_g242424 = temp_output_21_0_g242424;
					float3 In_NormalWS16_g242424 = Out_NormalWS15_g242422;
					float3 In_NormalRawOS16_g242424 = Out_NormalRawOS15_g242422;
					float4 temp_output_6_0_g242424 = Out_TangentOS15_g242422;
					float4 In_TangentOS16_g242424 = temp_output_6_0_g242424;
					float3 In_TangentWS16_g242424 = Out_TangentWS15_g242422;
					float3 In_BitangentWS16_g242424 = Out_BitangentWS15_g242422;
					float3 In_ViewDirWS16_g242424 = Out_ViewDirWS15_g242422;
					float4 In_CoordsData16_g242424 = Out_CoordsData15_g242422;
					float4 In_VertexData16_g242424 = Out_VertexData15_g242422;
					float4 In_MasksData16_g242424 = Out_MasksData15_g242422;
					float4 In_PhaseData16_g242424 = Out_PhaseData15_g242422;
					float4 In_TransformData16_g242424 = Out_TransformData15_g242422;
					float4 In_RotationData16_g242424 = Out_RotationData15_g242422;
					float4 In_InterpolatorA16_g242424 = Out_InterpolatorA15_g242422;
					BuildModelVertData( Data16_g242424 , In_Dummy16_g242424 , In_PositionOS16_g242424 , In_PositionWS16_g242424 , In_PositionWO16_g242424 , In_PositionRawOS16_g242424 , In_PivotOS16_g242424 , In_PivotWS16_g242424 , In_PivotWO16_g242424 , In_NormalOS16_g242424 , In_NormalWS16_g242424 , In_NormalRawOS16_g242424 , In_TangentOS16_g242424 , In_TangentWS16_g242424 , In_BitangentWS16_g242424 , In_ViewDirWS16_g242424 , In_CoordsData16_g242424 , In_VertexData16_g242424 , In_MasksData16_g242424 , In_PhaseData16_g242424 , In_TransformData16_g242424 , In_RotationData16_g242424 , In_InterpolatorA16_g242424 );
					TVEModelData Data15_g242428 =(TVEModelData)Data16_g242424;
					float Out_Dummy15_g242428 = 0.0;
					float3 Out_PositionOS15_g242428 = float3( 0,0,0 );
					float3 Out_PositionWS15_g242428 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242428 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g242428 = float3( 0,0,0 );
					float3 Out_PivotOS15_g242428 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242428 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242428 = float3( 0,0,0 );
					float3 Out_NormalOS15_g242428 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242428 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g242428 = float3( 0,0,0 );
					float4 Out_TangentOS15_g242428 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g242428 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242428 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242428 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242428 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242428 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g242428 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g242428 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g242428 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g242428 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g242428 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g242428 , Out_Dummy15_g242428 , Out_PositionOS15_g242428 , Out_PositionWS15_g242428 , Out_PositionWO15_g242428 , Out_PositionRawOS15_g242428 , Out_PivotOS15_g242428 , Out_PivotWS15_g242428 , Out_PivotWO15_g242428 , Out_NormalOS15_g242428 , Out_NormalWS15_g242428 , Out_NormalRawOS15_g242428 , Out_TangentOS15_g242428 , Out_TangentWS15_g242428 , Out_BitangentWS15_g242428 , Out_ViewDirWS15_g242428 , Out_CoordsData15_g242428 , Out_VertexData15_g242428 , Out_MasksData15_g242428 , Out_PhaseData15_g242428 , Out_TransformData15_g242428 , Out_RotationData15_g242428 , Out_InterpolatorA15_g242428 );
					TVEModelData Data16_g242429 =(TVEModelData)Data15_g242428;
					half Dummy317_g242427 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g242429 = Dummy317_g242427;
					float In_Dummy16_g242429 = temp_output_14_0_g242429;
					float3 temp_output_4_0_g242429 = Out_PositionOS15_g242428;
					float3 In_PositionOS16_g242429 = temp_output_4_0_g242429;
					float3 In_PositionWS16_g242429 = Out_PositionWS15_g242428;
					float3 temp_output_314_17_g242427 = Out_PositionWO15_g242428;
					float3 In_PositionWO16_g242429 = temp_output_314_17_g242427;
					float3 In_PositionRawOS16_g242429 = Out_PositionRawOS15_g242428;
					float3 In_PivotOS16_g242429 = Out_PivotOS15_g242428;
					float3 In_PivotWS16_g242429 = Out_PivotWS15_g242428;
					float3 temp_output_314_19_g242427 = Out_PivotWO15_g242428;
					float3 In_PivotWO16_g242429 = temp_output_314_19_g242427;
					float3 temp_output_21_0_g242429 = Out_NormalOS15_g242428;
					float3 In_NormalOS16_g242429 = temp_output_21_0_g242429;
					float3 In_NormalWS16_g242429 = Out_NormalWS15_g242428;
					float3 In_NormalRawOS16_g242429 = Out_NormalRawOS15_g242428;
					float4 temp_output_6_0_g242429 = Out_TangentOS15_g242428;
					float4 In_TangentOS16_g242429 = temp_output_6_0_g242429;
					float3 In_TangentWS16_g242429 = Out_TangentWS15_g242428;
					float3 In_BitangentWS16_g242429 = Out_BitangentWS15_g242428;
					float3 In_ViewDirWS16_g242429 = Out_ViewDirWS15_g242428;
					float4 In_CoordsData16_g242429 = Out_CoordsData15_g242428;
					float4 temp_output_314_29_g242427 = Out_VertexData15_g242428;
					float4 In_VertexData16_g242429 = temp_output_314_29_g242427;
					float4 In_MasksData16_g242429 = Out_MasksData15_g242428;
					float4 In_PhaseData16_g242429 = Out_PhaseData15_g242428;
					half4 Model_TransformData356_g242427 = Out_TransformData15_g242428;
					float localBuildGlobalData204_g242340 = ( 0.0 );
					TVEGlobalData Data204_g242340 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g242340 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g242340 = Dummy211_g242340;
					float4 temp_output_589_164_g242340 = TVE_CoatParams;
					half4 Coat_Params596_g242340 = temp_output_589_164_g242340;
					float4 In_CoatParams204_g242340 = Coat_Params596_g242340;
					float4 temp_output_203_0_g242360 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g242420 = ( 0.0 );
					TVEModelData Data26_g242420 = (TVEModelData)0;
					TVEModelData Data16_g242157 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g242157 = 0.0;
					float3 In_PositionWS16_g242157 = PositionWS122_g242149;
					float3 In_PositionWO16_g242157 = PositionWO132_g242149;
					float3 In_PivotWS16_g242157 = PivotWS121_g242149;
					float3 In_PivotWO16_g242157 = PivotWO133_g242149;
					float3 In_NormalWS16_g242157 = NormalWS95_g242149;
					float3 In_TangentWS16_g242157 = TangentWS136_g242149;
					float3 In_BitangentWS16_g242157 = BiangentWS421_g242149;
					half3 NormalWS427_g242149 = NormalWS95_g242149;
					half3 localComputeTriplanarWeights427_g242149 = ComputeTriplanarWeights( NormalWS427_g242149 );
					half3 TriplanarWeights429_g242149 = localComputeTriplanarWeights427_g242149;
					float3 In_TriplanarWeights16_g242157 = TriplanarWeights429_g242149;
					float3 In_ViewDirWS16_g242157 = ViewDirWS169_g242149;
					float4 In_CoordsData16_g242157 = CoordsData398_g242149;
					float4 In_VertexData16_g242157 = VertexMasks171_g242149;
					float4 In_PhaseData16_g242157 = Phase_Data176_g242149;
					BuildModelFragData( Data16_g242157 , In_Dummy16_g242157 , In_PositionWS16_g242157 , In_PositionWO16_g242157 , In_PivotWS16_g242157 , In_PivotWO16_g242157 , In_NormalWS16_g242157 , In_TangentWS16_g242157 , In_BitangentWS16_g242157 , In_TriplanarWeights16_g242157 , In_ViewDirWS16_g242157 , In_CoordsData16_g242157 , In_VertexData16_g242157 , In_PhaseData16_g242157 );
					TVEModelData DataDefault26_g242420 = Data16_g242157;
					TVEModelData DataGeneral26_g242420 = Data16_g242157;
					TVEModelData DataBlanket26_g242420 = Data16_g242157;
					TVEModelData DataImpostor26_g242420 = Data16_g242157;
					TVEModelData Data16_g242137 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g242137 = 0.0;
					float3 In_PositionWS16_g242137 = PositionWS122_g242129;
					float3 In_PositionWO16_g242137 = PositionWO132_g242129;
					float3 In_PivotWS16_g242137 = PivotWS121_g242129;
					float3 In_PivotWO16_g242137 = PivotWO133_g242129;
					float3 In_NormalWS16_g242137 = NormalWS95_g242129;
					float3 In_TangentWS16_g242137 = TangentWS136_g242129;
					float3 In_BitangentWS16_g242137 = BiangentWS421_g242129;
					half3 NormalWS427_g242129 = NormalWS95_g242129;
					half3 localComputeTriplanarWeights427_g242129 = ComputeTriplanarWeights( NormalWS427_g242129 );
					half3 TriplanarWeights429_g242129 = localComputeTriplanarWeights427_g242129;
					float3 In_TriplanarWeights16_g242137 = TriplanarWeights429_g242129;
					float3 In_ViewDirWS16_g242137 = ViewDirWS169_g242129;
					float4 In_CoordsData16_g242137 = CoordsData398_g242129;
					float4 In_VertexData16_g242137 = VertexMasks171_g242129;
					float4 In_PhaseData16_g242137 = Phase_Data176_g242129;
					BuildModelFragData( Data16_g242137 , In_Dummy16_g242137 , In_PositionWS16_g242137 , In_PositionWO16_g242137 , In_PivotWS16_g242137 , In_PivotWO16_g242137 , In_NormalWS16_g242137 , In_TangentWS16_g242137 , In_BitangentWS16_g242137 , In_TriplanarWeights16_g242137 , In_ViewDirWS16_g242137 , In_CoordsData16_g242137 , In_VertexData16_g242137 , In_PhaseData16_g242137 );
					TVEModelData DataTerrain26_g242420 = Data16_g242137;
					float Type26_g242420 = IsShaderType2637;
					{
					if (Type26_g242420 == 0 )
					{
					Data26_g242420 = DataDefault26_g242420;
					}
					else if (Type26_g242420 == 1 )
					{
					Data26_g242420 = DataGeneral26_g242420;
					}
					else if (Type26_g242420 == 2 )
					{
					Data26_g242420 = DataBlanket26_g242420;
					}
					else if (Type26_g242420 == 3 )
					{
					Data26_g242420 = DataImpostor26_g242420;
					}
					else if (Type26_g242420 == 4 )
					{
					Data26_g242420 = DataTerrain26_g242420;
					}
					}
					TVEModelData Data15_g242416 =(TVEModelData)Data26_g242420;
					float Out_Dummy15_g242416 = 0.0;
					float3 Out_PositionWS15_g242416 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242416 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242416 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242416 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242416 = float3( 0,0,0 );
					float3 Out_TangentWS15_g242416 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242416 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g242416 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242416 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242416 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242416 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g242416 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g242416 , Out_Dummy15_g242416 , Out_PositionWS15_g242416 , Out_PositionWO15_g242416 , Out_PivotWS15_g242416 , Out_PivotWO15_g242416 , Out_NormalWS15_g242416 , Out_TangentWS15_g242416 , Out_BitangentWS15_g242416 , Out_TriplanarWeights15_g242416 , Out_ViewDirWS15_g242416 , Out_CoordsData15_g242416 , Out_VertexData15_g242416 , Out_PhaseData15_g242416 );
					float3 Model_PositionWS497_g242340 = Out_PositionWS15_g242416;
					float2 Model_PositionWS_XZ143_g242340 = (Model_PositionWS497_g242340).xz;
					float3 Model_PivotWS498_g242340 = Out_PivotWS15_g242416;
					float2 Model_PivotWS_XZ145_g242340 = (Model_PivotWS498_g242340).xz;
					float2 lerpResult300_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g242360 = lerpResult300_g242340;
					float temp_output_82_0_g242358 = _GlobalCoatLayerValue;
					float temp_output_82_0_g242360 = temp_output_82_0_g242358;
					float4 tex2DArrayNode83_g242360 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242360).zw + ( (temp_output_203_0_g242360).xy * temp_output_81_0_g242360 ) ),temp_output_82_0_g242360), 0.0 );
					float4 appendResult210_g242360 = (float4(tex2DArrayNode83_g242360.rgb , saturate( tex2DArrayNode83_g242360.a )));
					float4 temp_output_204_0_g242360 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g242360 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242360).zw + ( (temp_output_204_0_g242360).xy * temp_output_81_0_g242360 ) ),temp_output_82_0_g242360), 0.0 );
					float4 appendResult212_g242360 = (float4(tex2DArrayNode122_g242360.rgb , saturate( tex2DArrayNode122_g242360.a )));
					float4 TVE_RenderNearPositionR628_g242340 = TVE_RenderNearPositionR;
					float temp_output_507_0_g242340 = saturate( ( distance( Model_PositionWS497_g242340 , (TVE_RenderNearPositionR628_g242340).xyz ) / (TVE_RenderNearPositionR628_g242340).w ) );
					float temp_output_7_0_g242341 = 1.0;
					float temp_output_9_0_g242341 = ( temp_output_507_0_g242340 - temp_output_7_0_g242341 );
					half TVE_RenderNearFadeValue635_g242340 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g242340 = saturate( ( temp_output_9_0_g242341 / ( ( TVE_RenderNearFadeValue635_g242340 - temp_output_7_0_g242341 ) + 0.0001 ) ) );
					float4 lerpResult131_g242360 = lerp( appendResult210_g242360 , appendResult212_g242360 , Global_TexBlend509_g242340);
					float4 temp_output_159_109_g242358 = lerpResult131_g242360;
					float4 lerpResult168_g242358 = lerp( TVE_CoatParams , temp_output_159_109_g242358 , TVE_CoatLayers[(int)temp_output_82_0_g242358]);
					float4 temp_output_589_109_g242340 = lerpResult168_g242358;
					half4 Coat_Texture302_g242340 = temp_output_589_109_g242340;
					float4 In_CoatTexture204_g242340 = Coat_Texture302_g242340;
					float4 temp_output_595_164_g242340 = TVE_PaintParams;
					half4 Paint_Params575_g242340 = temp_output_595_164_g242340;
					float4 In_PaintParams204_g242340 = Paint_Params575_g242340;
					float4 temp_output_203_0_g242409 = TVE_PaintBaseCoord;
					float2 lerpResult85_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g242409 = lerpResult85_g242340;
					float temp_output_82_0_g242406 = _GlobalPaintLayerValue;
					float temp_output_82_0_g242409 = temp_output_82_0_g242406;
					float4 tex2DArrayNode83_g242409 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242409).zw + ( (temp_output_203_0_g242409).xy * temp_output_81_0_g242409 ) ),temp_output_82_0_g242409), 0.0 );
					float4 appendResult210_g242409 = (float4(tex2DArrayNode83_g242409.rgb , saturate( tex2DArrayNode83_g242409.a )));
					float4 temp_output_204_0_g242409 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g242409 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242409).zw + ( (temp_output_204_0_g242409).xy * temp_output_81_0_g242409 ) ),temp_output_82_0_g242409), 0.0 );
					float4 appendResult212_g242409 = (float4(tex2DArrayNode122_g242409.rgb , saturate( tex2DArrayNode122_g242409.a )));
					float4 lerpResult131_g242409 = lerp( appendResult210_g242409 , appendResult212_g242409 , Global_TexBlend509_g242340);
					float4 temp_output_171_109_g242406 = lerpResult131_g242409;
					float4 lerpResult174_g242406 = lerp( TVE_PaintParams , temp_output_171_109_g242406 , TVE_PaintLayers[(int)temp_output_82_0_g242406]);
					float4 temp_output_595_109_g242340 = lerpResult174_g242406;
					half4 Paint_Texture71_g242340 = temp_output_595_109_g242340;
					float4 In_PaintTexture204_g242340 = Paint_Texture71_g242340;
					float4 temp_output_590_141_g242340 = TVE_AtmoParams;
					half4 Atmo_Params601_g242340 = temp_output_590_141_g242340;
					float4 In_AtmoParams204_g242340 = Atmo_Params601_g242340;
					float4 temp_output_203_0_g242368 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g242368 = lerpResult104_g242340;
					float temp_output_132_0_g242366 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g242368 = temp_output_132_0_g242366;
					float4 tex2DArrayNode83_g242368 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242368).zw + ( (temp_output_203_0_g242368).xy * temp_output_81_0_g242368 ) ),temp_output_82_0_g242368), 0.0 );
					float4 appendResult210_g242368 = (float4(tex2DArrayNode83_g242368.rgb , saturate( tex2DArrayNode83_g242368.a )));
					float4 temp_output_204_0_g242368 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g242368 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242368).zw + ( (temp_output_204_0_g242368).xy * temp_output_81_0_g242368 ) ),temp_output_82_0_g242368), 0.0 );
					float4 appendResult212_g242368 = (float4(tex2DArrayNode122_g242368.rgb , saturate( tex2DArrayNode122_g242368.a )));
					float4 lerpResult131_g242368 = lerp( appendResult210_g242368 , appendResult212_g242368 , Global_TexBlend509_g242340);
					float4 temp_output_137_109_g242366 = lerpResult131_g242368;
					float4 lerpResult145_g242366 = lerp( TVE_AtmoParams , temp_output_137_109_g242366 , TVE_AtmoLayers[(int)temp_output_132_0_g242366]);
					float4 temp_output_590_110_g242340 = lerpResult145_g242366;
					half4 Atmo_Texture80_g242340 = temp_output_590_110_g242340;
					float4 In_AtmoTexture204_g242340 = Atmo_Texture80_g242340;
					float4 temp_output_593_163_g242340 = TVE_GlowParams;
					half4 Glow_Params609_g242340 = temp_output_593_163_g242340;
					float4 In_GlowParams204_g242340 = Glow_Params609_g242340;
					float4 temp_output_203_0_g242384 = TVE_GlowBaseCoord;
					float2 lerpResult247_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g242384 = lerpResult247_g242340;
					float temp_output_82_0_g242382 = _GlobalGlowLayerValue;
					float temp_output_82_0_g242384 = temp_output_82_0_g242382;
					float4 tex2DArrayNode83_g242384 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242384).zw + ( (temp_output_203_0_g242384).xy * temp_output_81_0_g242384 ) ),temp_output_82_0_g242384), 0.0 );
					float4 appendResult210_g242384 = (float4(tex2DArrayNode83_g242384.rgb , saturate( tex2DArrayNode83_g242384.a )));
					float4 temp_output_204_0_g242384 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g242384 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242384).zw + ( (temp_output_204_0_g242384).xy * temp_output_81_0_g242384 ) ),temp_output_82_0_g242384), 0.0 );
					float4 appendResult212_g242384 = (float4(tex2DArrayNode122_g242384.rgb , saturate( tex2DArrayNode122_g242384.a )));
					float4 lerpResult131_g242384 = lerp( appendResult210_g242384 , appendResult212_g242384 , Global_TexBlend509_g242340);
					float4 temp_output_159_109_g242382 = lerpResult131_g242384;
					float4 lerpResult167_g242382 = lerp( TVE_GlowParams , temp_output_159_109_g242382 , TVE_GlowLayers[(int)temp_output_82_0_g242382]);
					float4 temp_output_593_109_g242340 = lerpResult167_g242382;
					half4 Glow_Texture248_g242340 = temp_output_593_109_g242340;
					float4 In_GlowTexture204_g242340 = Glow_Texture248_g242340;
					float4 temp_output_592_139_g242340 = TVE_FormParams;
					float4 Form_Params606_g242340 = temp_output_592_139_g242340;
					float4 In_FormParams204_g242340 = Form_Params606_g242340;
					float4 temp_output_203_0_g242400 = TVE_FormBaseCoord;
					float2 lerpResult168_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g242400 = lerpResult168_g242340;
					float temp_output_130_0_g242398 = _GlobalFormLayerValue;
					float temp_output_82_0_g242400 = temp_output_130_0_g242398;
					float4 tex2DArrayNode83_g242400 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242400).zw + ( (temp_output_203_0_g242400).xy * temp_output_81_0_g242400 ) ),temp_output_82_0_g242400), 0.0 );
					float4 appendResult210_g242400 = (float4(tex2DArrayNode83_g242400.rgb , saturate( tex2DArrayNode83_g242400.a )));
					float4 temp_output_204_0_g242400 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g242400 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242400).zw + ( (temp_output_204_0_g242400).xy * temp_output_81_0_g242400 ) ),temp_output_82_0_g242400), 0.0 );
					float4 appendResult212_g242400 = (float4(tex2DArrayNode122_g242400.rgb , saturate( tex2DArrayNode122_g242400.a )));
					float4 lerpResult131_g242400 = lerp( appendResult210_g242400 , appendResult212_g242400 , Global_TexBlend509_g242340);
					float4 temp_output_135_109_g242398 = lerpResult131_g242400;
					float4 lerpResult143_g242398 = lerp( TVE_FormParams , temp_output_135_109_g242398 , TVE_FormLayers[(int)temp_output_130_0_g242398]);
					float4 temp_output_592_0_g242340 = lerpResult143_g242398;
					float4 Form_Texture112_g242340 = temp_output_592_0_g242340;
					float4 In_FormTexture204_g242340 = Form_Texture112_g242340;
					float4 temp_output_594_145_g242340 = TVE_FlowParams;
					half4 Flow_Params612_g242340 = temp_output_594_145_g242340;
					float4 In_FlowParams204_g242340 = Flow_Params612_g242340;
					float4 temp_output_203_0_g242392 = TVE_FlowBaseCoord;
					float2 lerpResult400_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g242392 = lerpResult400_g242340;
					float temp_output_136_0_g242390 = _GlobalFlowLayerValue;
					float temp_output_82_0_g242392 = temp_output_136_0_g242390;
					float4 tex2DArrayNode83_g242392 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242392).zw + ( (temp_output_203_0_g242392).xy * temp_output_81_0_g242392 ) ),temp_output_82_0_g242392), 0.0 );
					float4 appendResult210_g242392 = (float4(tex2DArrayNode83_g242392.rgb , saturate( tex2DArrayNode83_g242392.a )));
					float4 temp_output_204_0_g242392 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g242392 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242392).zw + ( (temp_output_204_0_g242392).xy * temp_output_81_0_g242392 ) ),temp_output_82_0_g242392), 0.0 );
					float4 appendResult212_g242392 = (float4(tex2DArrayNode122_g242392.rgb , saturate( tex2DArrayNode122_g242392.a )));
					float4 lerpResult131_g242392 = lerp( appendResult210_g242392 , appendResult212_g242392 , Global_TexBlend509_g242340);
					float4 temp_output_141_109_g242390 = lerpResult131_g242392;
					float4 lerpResult149_g242390 = lerp( TVE_FlowParams , temp_output_141_109_g242390 , TVE_FlowLayers[(int)temp_output_136_0_g242390]);
					half4 Flow_Texture405_g242340 = lerpResult149_g242390;
					float4 In_FlowTexture204_g242340 = Flow_Texture405_g242340;
					BuildGlobalData( Data204_g242340 , In_Dummy204_g242340 , In_CoatParams204_g242340 , In_CoatTexture204_g242340 , In_PaintParams204_g242340 , In_PaintTexture204_g242340 , In_AtmoParams204_g242340 , In_AtmoTexture204_g242340 , In_GlowParams204_g242340 , In_GlowTexture204_g242340 , In_FormParams204_g242340 , In_FormTexture204_g242340 , In_FlowParams204_g242340 , In_FlowTexture204_g242340 );
					TVEGlobalData Data15_g242430 =(TVEGlobalData)Data204_g242340;
					float Out_Dummy15_g242430 = 0.0;
					float4 Out_CoatParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g242430 = float4( 0,0,0,0 );
					BreakData( Data15_g242430 , Out_Dummy15_g242430 , Out_CoatParams15_g242430 , Out_CoatTexture15_g242430 , Out_PaintParams15_g242430 , Out_PaintTexture15_g242430 , Out_AtmoParams15_g242430 , Out_AtmoTexture15_g242430 , Out_GlowParams15_g242430 , Out_GlowTexture15_g242430 , Out_FormParams15_g242430 , Out_FormTexture15_g242430 , Out_FlowParams15_g242430 , Out_FlowTexture15_g242430 );
					float4 Global_FormTexture351_g242427 = Out_FormTexture15_g242430;
					float3 Model_PivotWO353_g242427 = temp_output_314_19_g242427;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g242436 = _ConformMeshMode;
					float Option70_g242436 = temp_output_17_0_g242436;
					half4 Model_VertexData357_g242427 = temp_output_314_29_g242427;
					float4 temp_output_3_0_g242436 = Model_VertexData357_g242427;
					float4 Channel70_g242436 = temp_output_3_0_g242436;
					float localSwitchChannel470_g242436 = SwitchChannel4( Option70_g242436 , Channel70_g242436 );
					float temp_output_390_0_g242427 = localSwitchChannel470_g242436;
					float temp_output_7_0_g242433 = _ConformMeshRemap.x;
					float temp_output_9_0_g242433 = ( temp_output_390_0_g242427 - temp_output_7_0_g242433 );
					float lerpResult374_g242427 = lerp( 1.0 , saturate( ( temp_output_9_0_g242433 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g242427 = lerpResult374_g242427;
					float temp_output_328_0_g242427 = ( Blend_VertMask379_g242427 * TVE_IsEnabled );
					half Conform_Mask366_g242427 = temp_output_328_0_g242427;
					float temp_output_322_0_g242427 = ( ( ( ( (Global_FormTexture351_g242427).z - ( (Model_PivotWO353_g242427).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g242427 ) );
					float3 appendResult329_g242427 = (float3(0.0 , temp_output_322_0_g242427 , 0.0));
					float3 appendResult387_g242427 = (float3(0.0 , 0.0 , temp_output_322_0_g242427));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g242434 = appendResult387_g242427;
					#else
					float3 staticSwitch65_g242434 = appendResult329_g242427;
					#endif
					float3 Blanket_Conform368_g242427 = staticSwitch65_g242434;
					float4 appendResult312_g242427 = (float4(Blanket_Conform368_g242427 , 0.0));
					float4 temp_output_310_0_g242427 = ( Model_TransformData356_g242427 + appendResult312_g242427 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g242427 = temp_output_310_0_g242427;
					#else
					float4 staticSwitch364_g242427 = Model_TransformData356_g242427;
					#endif
					half4 Final_TransformData365_g242427 = staticSwitch364_g242427;
					float4 In_TransformData16_g242429 = Final_TransformData365_g242427;
					float4 In_RotationData16_g242429 = Out_RotationData15_g242428;
					float4 In_InterpolatorA16_g242429 = Out_InterpolatorA15_g242428;
					BuildModelVertData( Data16_g242429 , In_Dummy16_g242429 , In_PositionOS16_g242429 , In_PositionWS16_g242429 , In_PositionWO16_g242429 , In_PositionRawOS16_g242429 , In_PivotOS16_g242429 , In_PivotWS16_g242429 , In_PivotWO16_g242429 , In_NormalOS16_g242429 , In_NormalWS16_g242429 , In_NormalRawOS16_g242429 , In_TangentOS16_g242429 , In_TangentWS16_g242429 , In_BitangentWS16_g242429 , In_ViewDirWS16_g242429 , In_CoordsData16_g242429 , In_VertexData16_g242429 , In_MasksData16_g242429 , In_PhaseData16_g242429 , In_TransformData16_g242429 , In_RotationData16_g242429 , In_InterpolatorA16_g242429 );
					TVEModelData Data15_g242440 =(TVEModelData)Data16_g242429;
					float Out_Dummy15_g242440 = 0.0;
					float3 Out_PositionOS15_g242440 = float3( 0,0,0 );
					float3 Out_PositionWS15_g242440 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242440 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g242440 = float3( 0,0,0 );
					float3 Out_PivotOS15_g242440 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242440 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242440 = float3( 0,0,0 );
					float3 Out_NormalOS15_g242440 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242440 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g242440 = float3( 0,0,0 );
					float4 Out_TangentOS15_g242440 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g242440 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242440 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242440 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242440 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242440 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g242440 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g242440 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g242440 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g242440 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g242440 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g242440 , Out_Dummy15_g242440 , Out_PositionOS15_g242440 , Out_PositionWS15_g242440 , Out_PositionWO15_g242440 , Out_PositionRawOS15_g242440 , Out_PivotOS15_g242440 , Out_PivotWS15_g242440 , Out_PivotWO15_g242440 , Out_NormalOS15_g242440 , Out_NormalWS15_g242440 , Out_NormalRawOS15_g242440 , Out_TangentOS15_g242440 , Out_TangentWS15_g242440 , Out_BitangentWS15_g242440 , Out_ViewDirWS15_g242440 , Out_CoordsData15_g242440 , Out_VertexData15_g242440 , Out_MasksData15_g242440 , Out_PhaseData15_g242440 , Out_TransformData15_g242440 , Out_RotationData15_g242440 , Out_InterpolatorA15_g242440 );
					TVEModelData Data16_g242441 =(TVEModelData)Data15_g242440;
					float temp_output_14_0_g242441 = 0.0;
					float In_Dummy16_g242441 = temp_output_14_0_g242441;
					float3 Model_PositionOS147_g242439 = Out_PositionOS15_g242440;
					half3 VertexPos40_g242445 = Model_PositionOS147_g242439;
					float4 temp_output_1567_33_g242439 = Out_RotationData15_g242440;
					half4 Model_RotationData1569_g242439 = temp_output_1567_33_g242439;
					float2 break1582_g242439 = (Model_RotationData1569_g242439).xy;
					half Angle44_g242445 = break1582_g242439.y;
					half CosAngle89_g242445 = cos( Angle44_g242445 );
					half SinAngle93_g242445 = sin( Angle44_g242445 );
					float3 appendResult95_g242445 = (float3((VertexPos40_g242445).x , ( ( (VertexPos40_g242445).y * CosAngle89_g242445 ) - ( (VertexPos40_g242445).z * SinAngle93_g242445 ) ) , ( ( (VertexPos40_g242445).y * SinAngle93_g242445 ) + ( (VertexPos40_g242445).z * CosAngle89_g242445 ) )));
					half3 VertexPos40_g242446 = appendResult95_g242445;
					half Angle44_g242446 = -break1582_g242439.x;
					half CosAngle94_g242446 = cos( Angle44_g242446 );
					half SinAngle95_g242446 = sin( Angle44_g242446 );
					float3 appendResult98_g242446 = (float3(( ( (VertexPos40_g242446).x * CosAngle94_g242446 ) - ( (VertexPos40_g242446).y * SinAngle95_g242446 ) ) , ( ( (VertexPos40_g242446).x * SinAngle95_g242446 ) + ( (VertexPos40_g242446).y * CosAngle94_g242446 ) ) , (VertexPos40_g242446).z));
					half3 VertexPos40_g242444 = Model_PositionOS147_g242439;
					half Angle44_g242444 = break1582_g242439.y;
					half CosAngle89_g242444 = cos( Angle44_g242444 );
					half SinAngle93_g242444 = sin( Angle44_g242444 );
					float3 appendResult95_g242444 = (float3((VertexPos40_g242444).x , ( ( (VertexPos40_g242444).y * CosAngle89_g242444 ) - ( (VertexPos40_g242444).z * SinAngle93_g242444 ) ) , ( ( (VertexPos40_g242444).y * SinAngle93_g242444 ) + ( (VertexPos40_g242444).z * CosAngle89_g242444 ) )));
					half3 VertexPos40_g242449 = appendResult95_g242444;
					half Angle44_g242449 = break1582_g242439.x;
					half CosAngle91_g242449 = cos( Angle44_g242449 );
					half SinAngle92_g242449 = sin( Angle44_g242449 );
					float3 appendResult93_g242449 = (float3(( ( (VertexPos40_g242449).x * CosAngle91_g242449 ) + ( (VertexPos40_g242449).z * SinAngle92_g242449 ) ) , (VertexPos40_g242449).y , ( ( -(VertexPos40_g242449).x * SinAngle92_g242449 ) + ( (VertexPos40_g242449).z * CosAngle91_g242449 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g242447 = appendResult93_g242449;
					#else
					float3 staticSwitch65_g242447 = appendResult98_g242446;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g242442 = staticSwitch65_g242447;
					#else
					float3 staticSwitch65_g242442 = Model_PositionOS147_g242439;
					#endif
					float3 temp_output_1608_0_g242439 = staticSwitch65_g242442;
					half3 VertexPos40_g242448 = temp_output_1608_0_g242439;
					half Angle44_g242448 = (Model_RotationData1569_g242439).z;
					half CosAngle91_g242448 = cos( Angle44_g242448 );
					half SinAngle92_g242448 = sin( Angle44_g242448 );
					float3 appendResult93_g242448 = (float3(( ( (VertexPos40_g242448).x * CosAngle91_g242448 ) + ( (VertexPos40_g242448).z * SinAngle92_g242448 ) ) , (VertexPos40_g242448).y , ( ( -(VertexPos40_g242448).x * SinAngle92_g242448 ) + ( (VertexPos40_g242448).z * CosAngle91_g242448 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g242443 = appendResult93_g242448;
					#else
					float3 staticSwitch65_g242443 = temp_output_1608_0_g242439;
					#endif
					float4 temp_output_1567_31_g242439 = Out_TransformData15_g242440;
					half4 Model_TransformData1568_g242439 = temp_output_1567_31_g242439;
					half3 Final_PositionOS178_g242439 = ( ( staticSwitch65_g242443 * (Model_TransformData1568_g242439).w ) + (Model_TransformData1568_g242439).xyz );
					float3 temp_output_4_0_g242441 = Final_PositionOS178_g242439;
					float3 In_PositionOS16_g242441 = temp_output_4_0_g242441;
					float3 In_PositionWS16_g242441 = Out_PositionWS15_g242440;
					float3 In_PositionWO16_g242441 = Out_PositionWO15_g242440;
					float3 In_PositionRawOS16_g242441 = Out_PositionRawOS15_g242440;
					float3 In_PivotOS16_g242441 = Out_PivotOS15_g242440;
					float3 In_PivotWS16_g242441 = Out_PivotWS15_g242440;
					float3 In_PivotWO16_g242441 = Out_PivotWO15_g242440;
					float3 temp_output_21_0_g242441 = Out_NormalOS15_g242440;
					float3 In_NormalOS16_g242441 = temp_output_21_0_g242441;
					float3 In_NormalWS16_g242441 = Out_NormalWS15_g242440;
					float3 In_NormalRawOS16_g242441 = Out_NormalRawOS15_g242440;
					float4 temp_output_6_0_g242441 = Out_TangentOS15_g242440;
					float4 In_TangentOS16_g242441 = temp_output_6_0_g242441;
					float3 In_TangentWS16_g242441 = Out_TangentWS15_g242440;
					float3 In_BitangentWS16_g242441 = Out_BitangentWS15_g242440;
					float3 In_ViewDirWS16_g242441 = Out_ViewDirWS15_g242440;
					float4 In_CoordsData16_g242441 = Out_CoordsData15_g242440;
					float4 In_VertexData16_g242441 = Out_VertexData15_g242440;
					float4 In_MasksData16_g242441 = Out_MasksData15_g242440;
					float4 In_PhaseData16_g242441 = Out_PhaseData15_g242440;
					float4 In_TransformData16_g242441 = temp_output_1567_31_g242439;
					float4 In_RotationData16_g242441 = temp_output_1567_33_g242439;
					float4 In_InterpolatorA16_g242441 = Out_InterpolatorA15_g242440;
					BuildModelVertData( Data16_g242441 , In_Dummy16_g242441 , In_PositionOS16_g242441 , In_PositionWS16_g242441 , In_PositionWO16_g242441 , In_PositionRawOS16_g242441 , In_PivotOS16_g242441 , In_PivotWS16_g242441 , In_PivotWO16_g242441 , In_NormalOS16_g242441 , In_NormalWS16_g242441 , In_NormalRawOS16_g242441 , In_TangentOS16_g242441 , In_TangentWS16_g242441 , In_BitangentWS16_g242441 , In_ViewDirWS16_g242441 , In_CoordsData16_g242441 , In_VertexData16_g242441 , In_MasksData16_g242441 , In_PhaseData16_g242441 , In_TransformData16_g242441 , In_RotationData16_g242441 , In_InterpolatorA16_g242441 );
					TVEModelData Data15_g251358 =(TVEModelData)Data16_g242441;
					float Out_Dummy15_g251358 = 0.0;
					float3 Out_PositionOS15_g251358 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251358 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251358 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251358 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251358 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251358 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251358 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251358 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251358 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251358 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251358 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251358 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251358 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251358 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251358 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251358 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251358 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251358 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251358 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251358 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251358 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251358 , Out_Dummy15_g251358 , Out_PositionOS15_g251358 , Out_PositionWS15_g251358 , Out_PositionWO15_g251358 , Out_PositionRawOS15_g251358 , Out_PivotOS15_g251358 , Out_PivotWS15_g251358 , Out_PivotWO15_g251358 , Out_NormalOS15_g251358 , Out_NormalWS15_g251358 , Out_NormalRawOS15_g251358 , Out_TangentOS15_g251358 , Out_TangentWS15_g251358 , Out_BitangentWS15_g251358 , Out_ViewDirWS15_g251358 , Out_CoordsData15_g251358 , Out_VertexData15_g251358 , Out_MasksData15_g251358 , Out_PhaseData15_g251358 , Out_TransformData15_g251358 , Out_RotationData15_g251358 , Out_InterpolatorA15_g251358 );
					TVEModelData Data16_g251359 =(TVEModelData)Data15_g251358;
					float temp_output_14_0_g251359 = 0.0;
					float In_Dummy16_g251359 = temp_output_14_0_g251359;
					float3 temp_output_217_24_g251357 = Out_PivotOS15_g251358;
					float3 temp_output_216_0_g251357 = ( Out_PositionOS15_g251358 + temp_output_217_24_g251357 );
					float3 temp_output_4_0_g251359 = temp_output_216_0_g251357;
					float3 In_PositionOS16_g251359 = temp_output_4_0_g251359;
					float3 In_PositionWS16_g251359 = Out_PositionWS15_g251358;
					float3 In_PositionWO16_g251359 = Out_PositionWO15_g251358;
					float3 In_PositionRawOS16_g251359 = Out_PositionRawOS15_g251358;
					float3 In_PivotOS16_g251359 = temp_output_217_24_g251357;
					float3 In_PivotWS16_g251359 = Out_PivotWS15_g251358;
					float3 In_PivotWO16_g251359 = Out_PivotWO15_g251358;
					float3 temp_output_21_0_g251359 = Out_NormalOS15_g251358;
					float3 In_NormalOS16_g251359 = temp_output_21_0_g251359;
					float3 In_NormalWS16_g251359 = Out_NormalWS15_g251358;
					float3 In_NormalRawOS16_g251359 = Out_NormalRawOS15_g251358;
					float4 temp_output_6_0_g251359 = Out_TangentOS15_g251358;
					float4 In_TangentOS16_g251359 = temp_output_6_0_g251359;
					float3 In_TangentWS16_g251359 = Out_TangentWS15_g251358;
					float3 In_BitangentWS16_g251359 = Out_BitangentWS15_g251358;
					float3 In_ViewDirWS16_g251359 = Out_ViewDirWS15_g251358;
					float4 In_CoordsData16_g251359 = Out_CoordsData15_g251358;
					float4 In_VertexData16_g251359 = Out_VertexData15_g251358;
					float4 In_MasksData16_g251359 = Out_MasksData15_g251358;
					float4 In_PhaseData16_g251359 = Out_PhaseData15_g251358;
					float4 In_TransformData16_g251359 = Out_TransformData15_g251358;
					float4 In_RotationData16_g251359 = Out_RotationData15_g251358;
					float4 In_InterpolatorA16_g251359 = Out_InterpolatorA15_g251358;
					BuildModelVertData( Data16_g251359 , In_Dummy16_g251359 , In_PositionOS16_g251359 , In_PositionWS16_g251359 , In_PositionWO16_g251359 , In_PositionRawOS16_g251359 , In_PivotOS16_g251359 , In_PivotWS16_g251359 , In_PivotWO16_g251359 , In_NormalOS16_g251359 , In_NormalWS16_g251359 , In_NormalRawOS16_g251359 , In_TangentOS16_g251359 , In_TangentWS16_g251359 , In_BitangentWS16_g251359 , In_ViewDirWS16_g251359 , In_CoordsData16_g251359 , In_VertexData16_g251359 , In_MasksData16_g251359 , In_PhaseData16_g251359 , In_TransformData16_g251359 , In_RotationData16_g251359 , In_InterpolatorA16_g251359 );
					TVEModelData Data15_g251368 =(TVEModelData)Data16_g251359;
					float Out_Dummy15_g251368 = 0.0;
					float3 Out_PositionOS15_g251368 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251368 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251368 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251368 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251368 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251368 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251368 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251368 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251368 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251368 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251368 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251368 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251368 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251368 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251368 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251368 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251368 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251368 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251368 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251368 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251368 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251368 , Out_Dummy15_g251368 , Out_PositionOS15_g251368 , Out_PositionWS15_g251368 , Out_PositionWO15_g251368 , Out_PositionRawOS15_g251368 , Out_PivotOS15_g251368 , Out_PivotWS15_g251368 , Out_PivotWO15_g251368 , Out_NormalOS15_g251368 , Out_NormalWS15_g251368 , Out_NormalRawOS15_g251368 , Out_TangentOS15_g251368 , Out_TangentWS15_g251368 , Out_BitangentWS15_g251368 , Out_ViewDirWS15_g251368 , Out_CoordsData15_g251368 , Out_VertexData15_g251368 , Out_MasksData15_g251368 , Out_PhaseData15_g251368 , Out_TransformData15_g251368 , Out_RotationData15_g251368 , Out_InterpolatorA15_g251368 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251368;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251368;
					v.tangent = Out_TangentOS15_g251368;

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

					float localIfModelDataByShader26_g242169 = ( 0.0 );
					TVEModelData Data26_g242169 = (TVEModelData)0;
					TVEModelData Data16_g242159 =(TVEModelData)0;
					half Dummy207_g242149 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g242159 = Dummy207_g242149;
					float In_Dummy16_g242159 = temp_output_14_0_g242159;
					float3 PositionOS131_g242149 = v.vertex.xyz;
					float3 temp_output_4_0_g242159 = PositionOS131_g242149;
					float3 In_PositionOS16_g242159 = temp_output_4_0_g242159;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g242149 = ase_positionWS;
					float3 vertexToFrag73_g242149 = temp_output_104_7_g242149;
					float3 PositionWS122_g242149 = vertexToFrag73_g242149;
					float3 In_PositionWS16_g242159 = PositionWS122_g242149;
					float4x4 break19_g242152 = unity_ObjectToWorld;
					float3 appendResult20_g242152 = (float3(break19_g242152[ 0 ][ 3 ] , break19_g242152[ 1 ][ 3 ] , break19_g242152[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242149 = appendResult20_g242152;
					float4x4 break19_g242154 = unity_ObjectToWorld;
					float3 appendResult20_g242154 = (float3(break19_g242154[ 0 ][ 3 ] , break19_g242154[ 1 ][ 3 ] , break19_g242154[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g242150 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g242149 = PositionOS131_g242149;
					float3 appendResult234_g242149 = (float3(break233_g242149.x , 0.0 , break233_g242149.z));
					float3 break413_g242149 = PositionOS131_g242149;
					float3 appendResult414_g242149 = (float3(break413_g242149.x , break413_g242149.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g242156 = appendResult414_g242149;
					#else
					float3 staticSwitch65_g242156 = appendResult234_g242149;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g242149 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g242149 = appendResult60_g242150;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g242149 = staticSwitch65_g242156;
					#else
					float3 staticSwitch229_g242149 = _Vector0;
					#endif
					float3 PivotOS149_g242149 = staticSwitch229_g242149;
					float3 temp_output_122_0_g242154 = PivotOS149_g242149;
					float3 PivotsOnlyWS105_g242154 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g242154 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g242149 = ( appendResult20_g242154 + PivotsOnlyWS105_g242154 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g242149 = temp_output_340_7_g242149;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g242149 = temp_output_341_7_g242149;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g242149 = temp_output_341_7_g242149;
					#else
					float3 staticSwitch236_g242149 = temp_output_340_7_g242149;
					#endif
					float3 vertexToFrag76_g242149 = staticSwitch236_g242149;
					float3 PivotWS121_g242149 = vertexToFrag76_g242149;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242149 = ( PositionWS122_g242149 - PivotWS121_g242149 );
					#else
					float3 staticSwitch204_g242149 = PositionWS122_g242149;
					#endif
					float3 PositionWO132_g242149 = ( staticSwitch204_g242149 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242159 = PositionWO132_g242149;
					float3 In_PositionRawOS16_g242159 = PositionOS131_g242149;
					float3 In_PivotOS16_g242159 = PivotOS149_g242149;
					float3 In_PivotWS16_g242159 = PivotWS121_g242149;
					float3 PivotWO133_g242149 = ( PivotWS121_g242149 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242159 = PivotWO133_g242149;
					half3 NormalOS134_g242149 = v.normal;
					float3 temp_output_21_0_g242159 = NormalOS134_g242149;
					float3 In_NormalOS16_g242159 = temp_output_21_0_g242159;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g242149 = normalizedWorldNormal;
					float3 In_NormalWS16_g242159 = NormalWS95_g242149;
					float3 In_NormalRawOS16_g242159 = NormalOS134_g242149;
					half4 TangentlOS153_g242149 = v.tangent;
					float4 temp_output_6_0_g242159 = TangentlOS153_g242149;
					float4 In_TangentOS16_g242159 = temp_output_6_0_g242159;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g242149 = ase_tangentWS;
					float3 In_TangentWS16_g242159 = TangentWS136_g242149;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g242149 = ase_bitangentWS;
					float3 In_BitangentWS16_g242159 = BiangentWS421_g242149;
					float3 normalizeResult296_g242149 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242149 ) );
					half3 ViewDirWS169_g242149 = normalizeResult296_g242149;
					float3 In_ViewDirWS16_g242159 = ViewDirWS169_g242149;
					float4 appendResult397_g242149 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g242149 = appendResult397_g242149;
					float4 In_CoordsData16_g242159 = CoordsData398_g242149;
					half4 VertexMasks171_g242149 = v.ase_color;
					float4 In_VertexData16_g242159 = VertexMasks171_g242149;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g242162 = (PositionOS131_g242149).z;
					#else
					float staticSwitch65_g242162 = (PositionOS131_g242149).y;
					#endif
					half Object_HeightValue267_g242149 = _ObjectHeightValue;
					half Bounds_HeightMask274_g242149 = saturate( ( staticSwitch65_g242162 / Object_HeightValue267_g242149 ) );
					half3 Position387_g242149 = PositionOS131_g242149;
					half Height387_g242149 = Object_HeightValue267_g242149;
					half Object_RadiusValue268_g242149 = _ObjectRadiusValue;
					half Radius387_g242149 = Object_RadiusValue268_g242149;
					half localCapsuleMaskYUp387_g242149 = CapsuleMaskYUp( Position387_g242149 , Height387_g242149 , Radius387_g242149 );
					half3 Position408_g242149 = PositionOS131_g242149;
					half Height408_g242149 = Object_HeightValue267_g242149;
					half Radius408_g242149 = Object_RadiusValue268_g242149;
					half localCapsuleMaskZUp408_g242149 = CapsuleMaskZUp( Position408_g242149 , Height408_g242149 , Radius408_g242149 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g242167 = saturate( localCapsuleMaskZUp408_g242149 );
					#else
					float staticSwitch65_g242167 = saturate( localCapsuleMaskYUp387_g242149 );
					#endif
					half Bounds_SphereMask282_g242149 = staticSwitch65_g242167;
					float4 appendResult253_g242149 = (float4(Bounds_HeightMask274_g242149 , Bounds_SphereMask282_g242149 , 1.0 , 1.0));
					half4 MasksData254_g242149 = appendResult253_g242149;
					float4 In_MasksData16_g242159 = MasksData254_g242149;
					float temp_output_17_0_g242161 = _ObjectPhaseMode;
					float Option70_g242161 = temp_output_17_0_g242161;
					float4 temp_output_3_0_g242161 = v.ase_color;
					float4 Channel70_g242161 = temp_output_3_0_g242161;
					float localSwitchChannel470_g242161 = SwitchChannel4( Option70_g242161 , Channel70_g242161 );
					half Phase_Value372_g242149 = localSwitchChannel470_g242161;
					float3 break319_g242149 = PivotWO133_g242149;
					half Pivot_Position322_g242149 = ( break319_g242149.x + break319_g242149.z );
					half Phase_Position357_g242149 = ( Phase_Value372_g242149 + Pivot_Position322_g242149 );
					float temp_output_248_0_g242149 = frac( Phase_Position357_g242149 );
					float4 appendResult177_g242149 = (float4(( (frac( ( Phase_Position357_g242149 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g242149));
					half4 Phase_Data176_g242149 = appendResult177_g242149;
					float4 In_PhaseData16_g242159 = Phase_Data176_g242149;
					float4 In_TransformData16_g242159 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g242159 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g242159 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g242159 , In_Dummy16_g242159 , In_PositionOS16_g242159 , In_PositionWS16_g242159 , In_PositionWO16_g242159 , In_PositionRawOS16_g242159 , In_PivotOS16_g242159 , In_PivotWS16_g242159 , In_PivotWO16_g242159 , In_NormalOS16_g242159 , In_NormalWS16_g242159 , In_NormalRawOS16_g242159 , In_TangentOS16_g242159 , In_TangentWS16_g242159 , In_BitangentWS16_g242159 , In_ViewDirWS16_g242159 , In_CoordsData16_g242159 , In_VertexData16_g242159 , In_MasksData16_g242159 , In_PhaseData16_g242159 , In_TransformData16_g242159 , In_RotationData16_g242159 , In_InterpolatorA16_g242159 );
					TVEModelData DataDefault26_g242169 = Data16_g242159;
					TVEModelData DataGeneral26_g242169 = Data16_g242159;
					TVEModelData DataBlanket26_g242169 = Data16_g242159;
					TVEModelData DataImpostor26_g242169 = Data16_g242159;
					TVEModelData Data16_g242139 =(TVEModelData)0;
					half Dummy207_g242129 = 0.0;
					float temp_output_14_0_g242139 = Dummy207_g242129;
					float In_Dummy16_g242139 = temp_output_14_0_g242139;
					float3 PositionOS131_g242129 = v.vertex.xyz;
					float3 temp_output_4_0_g242139 = PositionOS131_g242129;
					float3 In_PositionOS16_g242139 = temp_output_4_0_g242139;
					float3 temp_output_104_7_g242129 = ase_positionWS;
					float3 PositionWS122_g242129 = temp_output_104_7_g242129;
					float3 In_PositionWS16_g242139 = PositionWS122_g242129;
					float4x4 break19_g242132 = unity_ObjectToWorld;
					float3 appendResult20_g242132 = (float3(break19_g242132[ 0 ][ 3 ] , break19_g242132[ 1 ][ 3 ] , break19_g242132[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242129 = appendResult20_g242132;
					float3 PivotWS121_g242129 = temp_output_340_7_g242129;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242129 = ( PositionWS122_g242129 - PivotWS121_g242129 );
					#else
					float3 staticSwitch204_g242129 = PositionWS122_g242129;
					#endif
					float3 PositionWO132_g242129 = ( staticSwitch204_g242129 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242139 = PositionWO132_g242129;
					float3 In_PositionRawOS16_g242139 = PositionOS131_g242129;
					float3 PivotOS149_g242129 = _Vector0;
					float3 In_PivotOS16_g242139 = PivotOS149_g242129;
					float3 In_PivotWS16_g242139 = PivotWS121_g242129;
					float3 PivotWO133_g242129 = ( PivotWS121_g242129 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242139 = PivotWO133_g242129;
					half3 NormalOS134_g242129 = v.normal;
					float3 temp_output_21_0_g242139 = NormalOS134_g242129;
					float3 In_NormalOS16_g242139 = temp_output_21_0_g242139;
					half3 NormalWS95_g242129 = normalizedWorldNormal;
					float3 In_NormalWS16_g242139 = NormalWS95_g242129;
					float3 In_NormalRawOS16_g242139 = NormalOS134_g242129;
					half4 TangentlOS153_g242129 = v.tangent;
					float4 temp_output_6_0_g242139 = TangentlOS153_g242129;
					float4 In_TangentOS16_g242139 = temp_output_6_0_g242139;
					half3 TangentWS136_g242129 = ase_tangentWS;
					float3 In_TangentWS16_g242139 = TangentWS136_g242129;
					half3 BiangentWS421_g242129 = ase_bitangentWS;
					float3 In_BitangentWS16_g242139 = BiangentWS421_g242129;
					float3 normalizeResult296_g242129 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242129 ) );
					half3 ViewDirWS169_g242129 = normalizeResult296_g242129;
					float3 In_ViewDirWS16_g242139 = ViewDirWS169_g242129;
					float4 appendResult397_g242129 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g242129 = appendResult397_g242129;
					float4 In_CoordsData16_g242139 = CoordsData398_g242129;
					half4 VertexMasks171_g242129 = float4( 0,0,0,0 );
					float4 In_VertexData16_g242139 = VertexMasks171_g242129;
					half4 MasksData254_g242129 = float4( 0,0,0,0 );
					float4 In_MasksData16_g242139 = MasksData254_g242129;
					half4 Phase_Data176_g242129 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g242139 = Phase_Data176_g242129;
					float4 In_TransformData16_g242139 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g242139 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g242139 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g242139 , In_Dummy16_g242139 , In_PositionOS16_g242139 , In_PositionWS16_g242139 , In_PositionWO16_g242139 , In_PositionRawOS16_g242139 , In_PivotOS16_g242139 , In_PivotWS16_g242139 , In_PivotWO16_g242139 , In_NormalOS16_g242139 , In_NormalWS16_g242139 , In_NormalRawOS16_g242139 , In_TangentOS16_g242139 , In_TangentWS16_g242139 , In_BitangentWS16_g242139 , In_ViewDirWS16_g242139 , In_CoordsData16_g242139 , In_VertexData16_g242139 , In_MasksData16_g242139 , In_PhaseData16_g242139 , In_TransformData16_g242139 , In_RotationData16_g242139 , In_InterpolatorA16_g242139 );
					TVEModelData DataTerrain26_g242169 = Data16_g242139;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g242169 = IsShaderType2637;
					{
					if (Type26_g242169 == 0 )
					{
					Data26_g242169 = DataDefault26_g242169;
					}
					else if (Type26_g242169 == 1 )
					{
					Data26_g242169 = DataGeneral26_g242169;
					}
					else if (Type26_g242169 == 2 )
					{
					Data26_g242169 = DataBlanket26_g242169;
					}
					else if (Type26_g242169 == 3 )
					{
					Data26_g242169 = DataImpostor26_g242169;
					}
					else if (Type26_g242169 == 4 )
					{
					Data26_g242169 = DataTerrain26_g242169;
					}
					}
					TVEModelData Data15_g242422 =(TVEModelData)Data26_g242169;
					float Out_Dummy15_g242422 = 0.0;
					float3 Out_PositionOS15_g242422 = float3( 0,0,0 );
					float3 Out_PositionWS15_g242422 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242422 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g242422 = float3( 0,0,0 );
					float3 Out_PivotOS15_g242422 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242422 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242422 = float3( 0,0,0 );
					float3 Out_NormalOS15_g242422 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242422 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g242422 = float3( 0,0,0 );
					float4 Out_TangentOS15_g242422 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g242422 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242422 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242422 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242422 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242422 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g242422 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g242422 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g242422 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g242422 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g242422 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g242422 , Out_Dummy15_g242422 , Out_PositionOS15_g242422 , Out_PositionWS15_g242422 , Out_PositionWO15_g242422 , Out_PositionRawOS15_g242422 , Out_PivotOS15_g242422 , Out_PivotWS15_g242422 , Out_PivotWO15_g242422 , Out_NormalOS15_g242422 , Out_NormalWS15_g242422 , Out_NormalRawOS15_g242422 , Out_TangentOS15_g242422 , Out_TangentWS15_g242422 , Out_BitangentWS15_g242422 , Out_ViewDirWS15_g242422 , Out_CoordsData15_g242422 , Out_VertexData15_g242422 , Out_MasksData15_g242422 , Out_PhaseData15_g242422 , Out_TransformData15_g242422 , Out_RotationData15_g242422 , Out_InterpolatorA15_g242422 );
					TVEModelData Data16_g242424 =(TVEModelData)Data15_g242422;
					float temp_output_14_0_g242424 = 0.0;
					float In_Dummy16_g242424 = temp_output_14_0_g242424;
					float3 temp_output_219_24_g242421 = Out_PivotOS15_g242422;
					float3 temp_output_215_0_g242421 = ( Out_PositionOS15_g242422 - temp_output_219_24_g242421 );
					float3 temp_output_4_0_g242424 = temp_output_215_0_g242421;
					float3 In_PositionOS16_g242424 = temp_output_4_0_g242424;
					float3 In_PositionWS16_g242424 = Out_PositionWS15_g242422;
					float3 In_PositionWO16_g242424 = Out_PositionWO15_g242422;
					float3 In_PositionRawOS16_g242424 = Out_PositionRawOS15_g242422;
					float3 In_PivotOS16_g242424 = temp_output_219_24_g242421;
					float3 In_PivotWS16_g242424 = Out_PivotWS15_g242422;
					float3 In_PivotWO16_g242424 = Out_PivotWO15_g242422;
					float3 temp_output_21_0_g242424 = Out_NormalOS15_g242422;
					float3 In_NormalOS16_g242424 = temp_output_21_0_g242424;
					float3 In_NormalWS16_g242424 = Out_NormalWS15_g242422;
					float3 In_NormalRawOS16_g242424 = Out_NormalRawOS15_g242422;
					float4 temp_output_6_0_g242424 = Out_TangentOS15_g242422;
					float4 In_TangentOS16_g242424 = temp_output_6_0_g242424;
					float3 In_TangentWS16_g242424 = Out_TangentWS15_g242422;
					float3 In_BitangentWS16_g242424 = Out_BitangentWS15_g242422;
					float3 In_ViewDirWS16_g242424 = Out_ViewDirWS15_g242422;
					float4 In_CoordsData16_g242424 = Out_CoordsData15_g242422;
					float4 In_VertexData16_g242424 = Out_VertexData15_g242422;
					float4 In_MasksData16_g242424 = Out_MasksData15_g242422;
					float4 In_PhaseData16_g242424 = Out_PhaseData15_g242422;
					float4 In_TransformData16_g242424 = Out_TransformData15_g242422;
					float4 In_RotationData16_g242424 = Out_RotationData15_g242422;
					float4 In_InterpolatorA16_g242424 = Out_InterpolatorA15_g242422;
					BuildModelVertData( Data16_g242424 , In_Dummy16_g242424 , In_PositionOS16_g242424 , In_PositionWS16_g242424 , In_PositionWO16_g242424 , In_PositionRawOS16_g242424 , In_PivotOS16_g242424 , In_PivotWS16_g242424 , In_PivotWO16_g242424 , In_NormalOS16_g242424 , In_NormalWS16_g242424 , In_NormalRawOS16_g242424 , In_TangentOS16_g242424 , In_TangentWS16_g242424 , In_BitangentWS16_g242424 , In_ViewDirWS16_g242424 , In_CoordsData16_g242424 , In_VertexData16_g242424 , In_MasksData16_g242424 , In_PhaseData16_g242424 , In_TransformData16_g242424 , In_RotationData16_g242424 , In_InterpolatorA16_g242424 );
					TVEModelData Data15_g242428 =(TVEModelData)Data16_g242424;
					float Out_Dummy15_g242428 = 0.0;
					float3 Out_PositionOS15_g242428 = float3( 0,0,0 );
					float3 Out_PositionWS15_g242428 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242428 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g242428 = float3( 0,0,0 );
					float3 Out_PivotOS15_g242428 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242428 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242428 = float3( 0,0,0 );
					float3 Out_NormalOS15_g242428 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242428 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g242428 = float3( 0,0,0 );
					float4 Out_TangentOS15_g242428 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g242428 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242428 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242428 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242428 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242428 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g242428 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g242428 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g242428 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g242428 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g242428 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g242428 , Out_Dummy15_g242428 , Out_PositionOS15_g242428 , Out_PositionWS15_g242428 , Out_PositionWO15_g242428 , Out_PositionRawOS15_g242428 , Out_PivotOS15_g242428 , Out_PivotWS15_g242428 , Out_PivotWO15_g242428 , Out_NormalOS15_g242428 , Out_NormalWS15_g242428 , Out_NormalRawOS15_g242428 , Out_TangentOS15_g242428 , Out_TangentWS15_g242428 , Out_BitangentWS15_g242428 , Out_ViewDirWS15_g242428 , Out_CoordsData15_g242428 , Out_VertexData15_g242428 , Out_MasksData15_g242428 , Out_PhaseData15_g242428 , Out_TransformData15_g242428 , Out_RotationData15_g242428 , Out_InterpolatorA15_g242428 );
					TVEModelData Data16_g242429 =(TVEModelData)Data15_g242428;
					half Dummy317_g242427 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g242429 = Dummy317_g242427;
					float In_Dummy16_g242429 = temp_output_14_0_g242429;
					float3 temp_output_4_0_g242429 = Out_PositionOS15_g242428;
					float3 In_PositionOS16_g242429 = temp_output_4_0_g242429;
					float3 In_PositionWS16_g242429 = Out_PositionWS15_g242428;
					float3 temp_output_314_17_g242427 = Out_PositionWO15_g242428;
					float3 In_PositionWO16_g242429 = temp_output_314_17_g242427;
					float3 In_PositionRawOS16_g242429 = Out_PositionRawOS15_g242428;
					float3 In_PivotOS16_g242429 = Out_PivotOS15_g242428;
					float3 In_PivotWS16_g242429 = Out_PivotWS15_g242428;
					float3 temp_output_314_19_g242427 = Out_PivotWO15_g242428;
					float3 In_PivotWO16_g242429 = temp_output_314_19_g242427;
					float3 temp_output_21_0_g242429 = Out_NormalOS15_g242428;
					float3 In_NormalOS16_g242429 = temp_output_21_0_g242429;
					float3 In_NormalWS16_g242429 = Out_NormalWS15_g242428;
					float3 In_NormalRawOS16_g242429 = Out_NormalRawOS15_g242428;
					float4 temp_output_6_0_g242429 = Out_TangentOS15_g242428;
					float4 In_TangentOS16_g242429 = temp_output_6_0_g242429;
					float3 In_TangentWS16_g242429 = Out_TangentWS15_g242428;
					float3 In_BitangentWS16_g242429 = Out_BitangentWS15_g242428;
					float3 In_ViewDirWS16_g242429 = Out_ViewDirWS15_g242428;
					float4 In_CoordsData16_g242429 = Out_CoordsData15_g242428;
					float4 temp_output_314_29_g242427 = Out_VertexData15_g242428;
					float4 In_VertexData16_g242429 = temp_output_314_29_g242427;
					float4 In_MasksData16_g242429 = Out_MasksData15_g242428;
					float4 In_PhaseData16_g242429 = Out_PhaseData15_g242428;
					half4 Model_TransformData356_g242427 = Out_TransformData15_g242428;
					float localBuildGlobalData204_g242340 = ( 0.0 );
					TVEGlobalData Data204_g242340 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g242340 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g242340 = Dummy211_g242340;
					float4 temp_output_589_164_g242340 = TVE_CoatParams;
					half4 Coat_Params596_g242340 = temp_output_589_164_g242340;
					float4 In_CoatParams204_g242340 = Coat_Params596_g242340;
					float4 temp_output_203_0_g242360 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g242420 = ( 0.0 );
					TVEModelData Data26_g242420 = (TVEModelData)0;
					TVEModelData Data16_g242157 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g242157 = 0.0;
					float3 In_PositionWS16_g242157 = PositionWS122_g242149;
					float3 In_PositionWO16_g242157 = PositionWO132_g242149;
					float3 In_PivotWS16_g242157 = PivotWS121_g242149;
					float3 In_PivotWO16_g242157 = PivotWO133_g242149;
					float3 In_NormalWS16_g242157 = NormalWS95_g242149;
					float3 In_TangentWS16_g242157 = TangentWS136_g242149;
					float3 In_BitangentWS16_g242157 = BiangentWS421_g242149;
					half3 NormalWS427_g242149 = NormalWS95_g242149;
					half3 localComputeTriplanarWeights427_g242149 = ComputeTriplanarWeights( NormalWS427_g242149 );
					half3 TriplanarWeights429_g242149 = localComputeTriplanarWeights427_g242149;
					float3 In_TriplanarWeights16_g242157 = TriplanarWeights429_g242149;
					float3 In_ViewDirWS16_g242157 = ViewDirWS169_g242149;
					float4 In_CoordsData16_g242157 = CoordsData398_g242149;
					float4 In_VertexData16_g242157 = VertexMasks171_g242149;
					float4 In_PhaseData16_g242157 = Phase_Data176_g242149;
					BuildModelFragData( Data16_g242157 , In_Dummy16_g242157 , In_PositionWS16_g242157 , In_PositionWO16_g242157 , In_PivotWS16_g242157 , In_PivotWO16_g242157 , In_NormalWS16_g242157 , In_TangentWS16_g242157 , In_BitangentWS16_g242157 , In_TriplanarWeights16_g242157 , In_ViewDirWS16_g242157 , In_CoordsData16_g242157 , In_VertexData16_g242157 , In_PhaseData16_g242157 );
					TVEModelData DataDefault26_g242420 = Data16_g242157;
					TVEModelData DataGeneral26_g242420 = Data16_g242157;
					TVEModelData DataBlanket26_g242420 = Data16_g242157;
					TVEModelData DataImpostor26_g242420 = Data16_g242157;
					TVEModelData Data16_g242137 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g242137 = 0.0;
					float3 In_PositionWS16_g242137 = PositionWS122_g242129;
					float3 In_PositionWO16_g242137 = PositionWO132_g242129;
					float3 In_PivotWS16_g242137 = PivotWS121_g242129;
					float3 In_PivotWO16_g242137 = PivotWO133_g242129;
					float3 In_NormalWS16_g242137 = NormalWS95_g242129;
					float3 In_TangentWS16_g242137 = TangentWS136_g242129;
					float3 In_BitangentWS16_g242137 = BiangentWS421_g242129;
					half3 NormalWS427_g242129 = NormalWS95_g242129;
					half3 localComputeTriplanarWeights427_g242129 = ComputeTriplanarWeights( NormalWS427_g242129 );
					half3 TriplanarWeights429_g242129 = localComputeTriplanarWeights427_g242129;
					float3 In_TriplanarWeights16_g242137 = TriplanarWeights429_g242129;
					float3 In_ViewDirWS16_g242137 = ViewDirWS169_g242129;
					float4 In_CoordsData16_g242137 = CoordsData398_g242129;
					float4 In_VertexData16_g242137 = VertexMasks171_g242129;
					float4 In_PhaseData16_g242137 = Phase_Data176_g242129;
					BuildModelFragData( Data16_g242137 , In_Dummy16_g242137 , In_PositionWS16_g242137 , In_PositionWO16_g242137 , In_PivotWS16_g242137 , In_PivotWO16_g242137 , In_NormalWS16_g242137 , In_TangentWS16_g242137 , In_BitangentWS16_g242137 , In_TriplanarWeights16_g242137 , In_ViewDirWS16_g242137 , In_CoordsData16_g242137 , In_VertexData16_g242137 , In_PhaseData16_g242137 );
					TVEModelData DataTerrain26_g242420 = Data16_g242137;
					float Type26_g242420 = IsShaderType2637;
					{
					if (Type26_g242420 == 0 )
					{
					Data26_g242420 = DataDefault26_g242420;
					}
					else if (Type26_g242420 == 1 )
					{
					Data26_g242420 = DataGeneral26_g242420;
					}
					else if (Type26_g242420 == 2 )
					{
					Data26_g242420 = DataBlanket26_g242420;
					}
					else if (Type26_g242420 == 3 )
					{
					Data26_g242420 = DataImpostor26_g242420;
					}
					else if (Type26_g242420 == 4 )
					{
					Data26_g242420 = DataTerrain26_g242420;
					}
					}
					TVEModelData Data15_g242416 =(TVEModelData)Data26_g242420;
					float Out_Dummy15_g242416 = 0.0;
					float3 Out_PositionWS15_g242416 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242416 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242416 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242416 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242416 = float3( 0,0,0 );
					float3 Out_TangentWS15_g242416 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242416 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g242416 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242416 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242416 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242416 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g242416 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g242416 , Out_Dummy15_g242416 , Out_PositionWS15_g242416 , Out_PositionWO15_g242416 , Out_PivotWS15_g242416 , Out_PivotWO15_g242416 , Out_NormalWS15_g242416 , Out_TangentWS15_g242416 , Out_BitangentWS15_g242416 , Out_TriplanarWeights15_g242416 , Out_ViewDirWS15_g242416 , Out_CoordsData15_g242416 , Out_VertexData15_g242416 , Out_PhaseData15_g242416 );
					float3 Model_PositionWS497_g242340 = Out_PositionWS15_g242416;
					float2 Model_PositionWS_XZ143_g242340 = (Model_PositionWS497_g242340).xz;
					float3 Model_PivotWS498_g242340 = Out_PivotWS15_g242416;
					float2 Model_PivotWS_XZ145_g242340 = (Model_PivotWS498_g242340).xz;
					float2 lerpResult300_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g242360 = lerpResult300_g242340;
					float temp_output_82_0_g242358 = _GlobalCoatLayerValue;
					float temp_output_82_0_g242360 = temp_output_82_0_g242358;
					float4 tex2DArrayNode83_g242360 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242360).zw + ( (temp_output_203_0_g242360).xy * temp_output_81_0_g242360 ) ),temp_output_82_0_g242360), 0.0 );
					float4 appendResult210_g242360 = (float4(tex2DArrayNode83_g242360.rgb , saturate( tex2DArrayNode83_g242360.a )));
					float4 temp_output_204_0_g242360 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g242360 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242360).zw + ( (temp_output_204_0_g242360).xy * temp_output_81_0_g242360 ) ),temp_output_82_0_g242360), 0.0 );
					float4 appendResult212_g242360 = (float4(tex2DArrayNode122_g242360.rgb , saturate( tex2DArrayNode122_g242360.a )));
					float4 TVE_RenderNearPositionR628_g242340 = TVE_RenderNearPositionR;
					float temp_output_507_0_g242340 = saturate( ( distance( Model_PositionWS497_g242340 , (TVE_RenderNearPositionR628_g242340).xyz ) / (TVE_RenderNearPositionR628_g242340).w ) );
					float temp_output_7_0_g242341 = 1.0;
					float temp_output_9_0_g242341 = ( temp_output_507_0_g242340 - temp_output_7_0_g242341 );
					half TVE_RenderNearFadeValue635_g242340 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g242340 = saturate( ( temp_output_9_0_g242341 / ( ( TVE_RenderNearFadeValue635_g242340 - temp_output_7_0_g242341 ) + 0.0001 ) ) );
					float4 lerpResult131_g242360 = lerp( appendResult210_g242360 , appendResult212_g242360 , Global_TexBlend509_g242340);
					float4 temp_output_159_109_g242358 = lerpResult131_g242360;
					float4 lerpResult168_g242358 = lerp( TVE_CoatParams , temp_output_159_109_g242358 , TVE_CoatLayers[(int)temp_output_82_0_g242358]);
					float4 temp_output_589_109_g242340 = lerpResult168_g242358;
					half4 Coat_Texture302_g242340 = temp_output_589_109_g242340;
					float4 In_CoatTexture204_g242340 = Coat_Texture302_g242340;
					float4 temp_output_595_164_g242340 = TVE_PaintParams;
					half4 Paint_Params575_g242340 = temp_output_595_164_g242340;
					float4 In_PaintParams204_g242340 = Paint_Params575_g242340;
					float4 temp_output_203_0_g242409 = TVE_PaintBaseCoord;
					float2 lerpResult85_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g242409 = lerpResult85_g242340;
					float temp_output_82_0_g242406 = _GlobalPaintLayerValue;
					float temp_output_82_0_g242409 = temp_output_82_0_g242406;
					float4 tex2DArrayNode83_g242409 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242409).zw + ( (temp_output_203_0_g242409).xy * temp_output_81_0_g242409 ) ),temp_output_82_0_g242409), 0.0 );
					float4 appendResult210_g242409 = (float4(tex2DArrayNode83_g242409.rgb , saturate( tex2DArrayNode83_g242409.a )));
					float4 temp_output_204_0_g242409 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g242409 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242409).zw + ( (temp_output_204_0_g242409).xy * temp_output_81_0_g242409 ) ),temp_output_82_0_g242409), 0.0 );
					float4 appendResult212_g242409 = (float4(tex2DArrayNode122_g242409.rgb , saturate( tex2DArrayNode122_g242409.a )));
					float4 lerpResult131_g242409 = lerp( appendResult210_g242409 , appendResult212_g242409 , Global_TexBlend509_g242340);
					float4 temp_output_171_109_g242406 = lerpResult131_g242409;
					float4 lerpResult174_g242406 = lerp( TVE_PaintParams , temp_output_171_109_g242406 , TVE_PaintLayers[(int)temp_output_82_0_g242406]);
					float4 temp_output_595_109_g242340 = lerpResult174_g242406;
					half4 Paint_Texture71_g242340 = temp_output_595_109_g242340;
					float4 In_PaintTexture204_g242340 = Paint_Texture71_g242340;
					float4 temp_output_590_141_g242340 = TVE_AtmoParams;
					half4 Atmo_Params601_g242340 = temp_output_590_141_g242340;
					float4 In_AtmoParams204_g242340 = Atmo_Params601_g242340;
					float4 temp_output_203_0_g242368 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g242368 = lerpResult104_g242340;
					float temp_output_132_0_g242366 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g242368 = temp_output_132_0_g242366;
					float4 tex2DArrayNode83_g242368 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242368).zw + ( (temp_output_203_0_g242368).xy * temp_output_81_0_g242368 ) ),temp_output_82_0_g242368), 0.0 );
					float4 appendResult210_g242368 = (float4(tex2DArrayNode83_g242368.rgb , saturate( tex2DArrayNode83_g242368.a )));
					float4 temp_output_204_0_g242368 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g242368 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242368).zw + ( (temp_output_204_0_g242368).xy * temp_output_81_0_g242368 ) ),temp_output_82_0_g242368), 0.0 );
					float4 appendResult212_g242368 = (float4(tex2DArrayNode122_g242368.rgb , saturate( tex2DArrayNode122_g242368.a )));
					float4 lerpResult131_g242368 = lerp( appendResult210_g242368 , appendResult212_g242368 , Global_TexBlend509_g242340);
					float4 temp_output_137_109_g242366 = lerpResult131_g242368;
					float4 lerpResult145_g242366 = lerp( TVE_AtmoParams , temp_output_137_109_g242366 , TVE_AtmoLayers[(int)temp_output_132_0_g242366]);
					float4 temp_output_590_110_g242340 = lerpResult145_g242366;
					half4 Atmo_Texture80_g242340 = temp_output_590_110_g242340;
					float4 In_AtmoTexture204_g242340 = Atmo_Texture80_g242340;
					float4 temp_output_593_163_g242340 = TVE_GlowParams;
					half4 Glow_Params609_g242340 = temp_output_593_163_g242340;
					float4 In_GlowParams204_g242340 = Glow_Params609_g242340;
					float4 temp_output_203_0_g242384 = TVE_GlowBaseCoord;
					float2 lerpResult247_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g242384 = lerpResult247_g242340;
					float temp_output_82_0_g242382 = _GlobalGlowLayerValue;
					float temp_output_82_0_g242384 = temp_output_82_0_g242382;
					float4 tex2DArrayNode83_g242384 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242384).zw + ( (temp_output_203_0_g242384).xy * temp_output_81_0_g242384 ) ),temp_output_82_0_g242384), 0.0 );
					float4 appendResult210_g242384 = (float4(tex2DArrayNode83_g242384.rgb , saturate( tex2DArrayNode83_g242384.a )));
					float4 temp_output_204_0_g242384 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g242384 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242384).zw + ( (temp_output_204_0_g242384).xy * temp_output_81_0_g242384 ) ),temp_output_82_0_g242384), 0.0 );
					float4 appendResult212_g242384 = (float4(tex2DArrayNode122_g242384.rgb , saturate( tex2DArrayNode122_g242384.a )));
					float4 lerpResult131_g242384 = lerp( appendResult210_g242384 , appendResult212_g242384 , Global_TexBlend509_g242340);
					float4 temp_output_159_109_g242382 = lerpResult131_g242384;
					float4 lerpResult167_g242382 = lerp( TVE_GlowParams , temp_output_159_109_g242382 , TVE_GlowLayers[(int)temp_output_82_0_g242382]);
					float4 temp_output_593_109_g242340 = lerpResult167_g242382;
					half4 Glow_Texture248_g242340 = temp_output_593_109_g242340;
					float4 In_GlowTexture204_g242340 = Glow_Texture248_g242340;
					float4 temp_output_592_139_g242340 = TVE_FormParams;
					float4 Form_Params606_g242340 = temp_output_592_139_g242340;
					float4 In_FormParams204_g242340 = Form_Params606_g242340;
					float4 temp_output_203_0_g242400 = TVE_FormBaseCoord;
					float2 lerpResult168_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g242400 = lerpResult168_g242340;
					float temp_output_130_0_g242398 = _GlobalFormLayerValue;
					float temp_output_82_0_g242400 = temp_output_130_0_g242398;
					float4 tex2DArrayNode83_g242400 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242400).zw + ( (temp_output_203_0_g242400).xy * temp_output_81_0_g242400 ) ),temp_output_82_0_g242400), 0.0 );
					float4 appendResult210_g242400 = (float4(tex2DArrayNode83_g242400.rgb , saturate( tex2DArrayNode83_g242400.a )));
					float4 temp_output_204_0_g242400 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g242400 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242400).zw + ( (temp_output_204_0_g242400).xy * temp_output_81_0_g242400 ) ),temp_output_82_0_g242400), 0.0 );
					float4 appendResult212_g242400 = (float4(tex2DArrayNode122_g242400.rgb , saturate( tex2DArrayNode122_g242400.a )));
					float4 lerpResult131_g242400 = lerp( appendResult210_g242400 , appendResult212_g242400 , Global_TexBlend509_g242340);
					float4 temp_output_135_109_g242398 = lerpResult131_g242400;
					float4 lerpResult143_g242398 = lerp( TVE_FormParams , temp_output_135_109_g242398 , TVE_FormLayers[(int)temp_output_130_0_g242398]);
					float4 temp_output_592_0_g242340 = lerpResult143_g242398;
					float4 Form_Texture112_g242340 = temp_output_592_0_g242340;
					float4 In_FormTexture204_g242340 = Form_Texture112_g242340;
					float4 temp_output_594_145_g242340 = TVE_FlowParams;
					half4 Flow_Params612_g242340 = temp_output_594_145_g242340;
					float4 In_FlowParams204_g242340 = Flow_Params612_g242340;
					float4 temp_output_203_0_g242392 = TVE_FlowBaseCoord;
					float2 lerpResult400_g242340 = lerp( Model_PositionWS_XZ143_g242340 , Model_PivotWS_XZ145_g242340 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g242392 = lerpResult400_g242340;
					float temp_output_136_0_g242390 = _GlobalFlowLayerValue;
					float temp_output_82_0_g242392 = temp_output_136_0_g242390;
					float4 tex2DArrayNode83_g242392 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242392).zw + ( (temp_output_203_0_g242392).xy * temp_output_81_0_g242392 ) ),temp_output_82_0_g242392), 0.0 );
					float4 appendResult210_g242392 = (float4(tex2DArrayNode83_g242392.rgb , saturate( tex2DArrayNode83_g242392.a )));
					float4 temp_output_204_0_g242392 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g242392 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242392).zw + ( (temp_output_204_0_g242392).xy * temp_output_81_0_g242392 ) ),temp_output_82_0_g242392), 0.0 );
					float4 appendResult212_g242392 = (float4(tex2DArrayNode122_g242392.rgb , saturate( tex2DArrayNode122_g242392.a )));
					float4 lerpResult131_g242392 = lerp( appendResult210_g242392 , appendResult212_g242392 , Global_TexBlend509_g242340);
					float4 temp_output_141_109_g242390 = lerpResult131_g242392;
					float4 lerpResult149_g242390 = lerp( TVE_FlowParams , temp_output_141_109_g242390 , TVE_FlowLayers[(int)temp_output_136_0_g242390]);
					half4 Flow_Texture405_g242340 = lerpResult149_g242390;
					float4 In_FlowTexture204_g242340 = Flow_Texture405_g242340;
					BuildGlobalData( Data204_g242340 , In_Dummy204_g242340 , In_CoatParams204_g242340 , In_CoatTexture204_g242340 , In_PaintParams204_g242340 , In_PaintTexture204_g242340 , In_AtmoParams204_g242340 , In_AtmoTexture204_g242340 , In_GlowParams204_g242340 , In_GlowTexture204_g242340 , In_FormParams204_g242340 , In_FormTexture204_g242340 , In_FlowParams204_g242340 , In_FlowTexture204_g242340 );
					TVEGlobalData Data15_g242430 =(TVEGlobalData)Data204_g242340;
					float Out_Dummy15_g242430 = 0.0;
					float4 Out_CoatParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g242430 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g242430 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g242430 = float4( 0,0,0,0 );
					BreakData( Data15_g242430 , Out_Dummy15_g242430 , Out_CoatParams15_g242430 , Out_CoatTexture15_g242430 , Out_PaintParams15_g242430 , Out_PaintTexture15_g242430 , Out_AtmoParams15_g242430 , Out_AtmoTexture15_g242430 , Out_GlowParams15_g242430 , Out_GlowTexture15_g242430 , Out_FormParams15_g242430 , Out_FormTexture15_g242430 , Out_FlowParams15_g242430 , Out_FlowTexture15_g242430 );
					float4 Global_FormTexture351_g242427 = Out_FormTexture15_g242430;
					float3 Model_PivotWO353_g242427 = temp_output_314_19_g242427;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g242436 = _ConformMeshMode;
					float Option70_g242436 = temp_output_17_0_g242436;
					half4 Model_VertexData357_g242427 = temp_output_314_29_g242427;
					float4 temp_output_3_0_g242436 = Model_VertexData357_g242427;
					float4 Channel70_g242436 = temp_output_3_0_g242436;
					float localSwitchChannel470_g242436 = SwitchChannel4( Option70_g242436 , Channel70_g242436 );
					float temp_output_390_0_g242427 = localSwitchChannel470_g242436;
					float temp_output_7_0_g242433 = _ConformMeshRemap.x;
					float temp_output_9_0_g242433 = ( temp_output_390_0_g242427 - temp_output_7_0_g242433 );
					float lerpResult374_g242427 = lerp( 1.0 , saturate( ( temp_output_9_0_g242433 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g242427 = lerpResult374_g242427;
					float temp_output_328_0_g242427 = ( Blend_VertMask379_g242427 * TVE_IsEnabled );
					half Conform_Mask366_g242427 = temp_output_328_0_g242427;
					float temp_output_322_0_g242427 = ( ( ( ( (Global_FormTexture351_g242427).z - ( (Model_PivotWO353_g242427).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g242427 ) );
					float3 appendResult329_g242427 = (float3(0.0 , temp_output_322_0_g242427 , 0.0));
					float3 appendResult387_g242427 = (float3(0.0 , 0.0 , temp_output_322_0_g242427));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g242434 = appendResult387_g242427;
					#else
					float3 staticSwitch65_g242434 = appendResult329_g242427;
					#endif
					float3 Blanket_Conform368_g242427 = staticSwitch65_g242434;
					float4 appendResult312_g242427 = (float4(Blanket_Conform368_g242427 , 0.0));
					float4 temp_output_310_0_g242427 = ( Model_TransformData356_g242427 + appendResult312_g242427 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g242427 = temp_output_310_0_g242427;
					#else
					float4 staticSwitch364_g242427 = Model_TransformData356_g242427;
					#endif
					half4 Final_TransformData365_g242427 = staticSwitch364_g242427;
					float4 In_TransformData16_g242429 = Final_TransformData365_g242427;
					float4 In_RotationData16_g242429 = Out_RotationData15_g242428;
					float4 In_InterpolatorA16_g242429 = Out_InterpolatorA15_g242428;
					BuildModelVertData( Data16_g242429 , In_Dummy16_g242429 , In_PositionOS16_g242429 , In_PositionWS16_g242429 , In_PositionWO16_g242429 , In_PositionRawOS16_g242429 , In_PivotOS16_g242429 , In_PivotWS16_g242429 , In_PivotWO16_g242429 , In_NormalOS16_g242429 , In_NormalWS16_g242429 , In_NormalRawOS16_g242429 , In_TangentOS16_g242429 , In_TangentWS16_g242429 , In_BitangentWS16_g242429 , In_ViewDirWS16_g242429 , In_CoordsData16_g242429 , In_VertexData16_g242429 , In_MasksData16_g242429 , In_PhaseData16_g242429 , In_TransformData16_g242429 , In_RotationData16_g242429 , In_InterpolatorA16_g242429 );
					TVEModelData Data15_g242440 =(TVEModelData)Data16_g242429;
					float Out_Dummy15_g242440 = 0.0;
					float3 Out_PositionOS15_g242440 = float3( 0,0,0 );
					float3 Out_PositionWS15_g242440 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242440 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g242440 = float3( 0,0,0 );
					float3 Out_PivotOS15_g242440 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242440 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242440 = float3( 0,0,0 );
					float3 Out_NormalOS15_g242440 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242440 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g242440 = float3( 0,0,0 );
					float4 Out_TangentOS15_g242440 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g242440 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242440 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242440 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242440 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242440 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g242440 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g242440 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g242440 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g242440 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g242440 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g242440 , Out_Dummy15_g242440 , Out_PositionOS15_g242440 , Out_PositionWS15_g242440 , Out_PositionWO15_g242440 , Out_PositionRawOS15_g242440 , Out_PivotOS15_g242440 , Out_PivotWS15_g242440 , Out_PivotWO15_g242440 , Out_NormalOS15_g242440 , Out_NormalWS15_g242440 , Out_NormalRawOS15_g242440 , Out_TangentOS15_g242440 , Out_TangentWS15_g242440 , Out_BitangentWS15_g242440 , Out_ViewDirWS15_g242440 , Out_CoordsData15_g242440 , Out_VertexData15_g242440 , Out_MasksData15_g242440 , Out_PhaseData15_g242440 , Out_TransformData15_g242440 , Out_RotationData15_g242440 , Out_InterpolatorA15_g242440 );
					TVEModelData Data16_g242441 =(TVEModelData)Data15_g242440;
					float temp_output_14_0_g242441 = 0.0;
					float In_Dummy16_g242441 = temp_output_14_0_g242441;
					float3 Model_PositionOS147_g242439 = Out_PositionOS15_g242440;
					half3 VertexPos40_g242445 = Model_PositionOS147_g242439;
					float4 temp_output_1567_33_g242439 = Out_RotationData15_g242440;
					half4 Model_RotationData1569_g242439 = temp_output_1567_33_g242439;
					float2 break1582_g242439 = (Model_RotationData1569_g242439).xy;
					half Angle44_g242445 = break1582_g242439.y;
					half CosAngle89_g242445 = cos( Angle44_g242445 );
					half SinAngle93_g242445 = sin( Angle44_g242445 );
					float3 appendResult95_g242445 = (float3((VertexPos40_g242445).x , ( ( (VertexPos40_g242445).y * CosAngle89_g242445 ) - ( (VertexPos40_g242445).z * SinAngle93_g242445 ) ) , ( ( (VertexPos40_g242445).y * SinAngle93_g242445 ) + ( (VertexPos40_g242445).z * CosAngle89_g242445 ) )));
					half3 VertexPos40_g242446 = appendResult95_g242445;
					half Angle44_g242446 = -break1582_g242439.x;
					half CosAngle94_g242446 = cos( Angle44_g242446 );
					half SinAngle95_g242446 = sin( Angle44_g242446 );
					float3 appendResult98_g242446 = (float3(( ( (VertexPos40_g242446).x * CosAngle94_g242446 ) - ( (VertexPos40_g242446).y * SinAngle95_g242446 ) ) , ( ( (VertexPos40_g242446).x * SinAngle95_g242446 ) + ( (VertexPos40_g242446).y * CosAngle94_g242446 ) ) , (VertexPos40_g242446).z));
					half3 VertexPos40_g242444 = Model_PositionOS147_g242439;
					half Angle44_g242444 = break1582_g242439.y;
					half CosAngle89_g242444 = cos( Angle44_g242444 );
					half SinAngle93_g242444 = sin( Angle44_g242444 );
					float3 appendResult95_g242444 = (float3((VertexPos40_g242444).x , ( ( (VertexPos40_g242444).y * CosAngle89_g242444 ) - ( (VertexPos40_g242444).z * SinAngle93_g242444 ) ) , ( ( (VertexPos40_g242444).y * SinAngle93_g242444 ) + ( (VertexPos40_g242444).z * CosAngle89_g242444 ) )));
					half3 VertexPos40_g242449 = appendResult95_g242444;
					half Angle44_g242449 = break1582_g242439.x;
					half CosAngle91_g242449 = cos( Angle44_g242449 );
					half SinAngle92_g242449 = sin( Angle44_g242449 );
					float3 appendResult93_g242449 = (float3(( ( (VertexPos40_g242449).x * CosAngle91_g242449 ) + ( (VertexPos40_g242449).z * SinAngle92_g242449 ) ) , (VertexPos40_g242449).y , ( ( -(VertexPos40_g242449).x * SinAngle92_g242449 ) + ( (VertexPos40_g242449).z * CosAngle91_g242449 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g242447 = appendResult93_g242449;
					#else
					float3 staticSwitch65_g242447 = appendResult98_g242446;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g242442 = staticSwitch65_g242447;
					#else
					float3 staticSwitch65_g242442 = Model_PositionOS147_g242439;
					#endif
					float3 temp_output_1608_0_g242439 = staticSwitch65_g242442;
					half3 VertexPos40_g242448 = temp_output_1608_0_g242439;
					half Angle44_g242448 = (Model_RotationData1569_g242439).z;
					half CosAngle91_g242448 = cos( Angle44_g242448 );
					half SinAngle92_g242448 = sin( Angle44_g242448 );
					float3 appendResult93_g242448 = (float3(( ( (VertexPos40_g242448).x * CosAngle91_g242448 ) + ( (VertexPos40_g242448).z * SinAngle92_g242448 ) ) , (VertexPos40_g242448).y , ( ( -(VertexPos40_g242448).x * SinAngle92_g242448 ) + ( (VertexPos40_g242448).z * CosAngle91_g242448 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g242443 = appendResult93_g242448;
					#else
					float3 staticSwitch65_g242443 = temp_output_1608_0_g242439;
					#endif
					float4 temp_output_1567_31_g242439 = Out_TransformData15_g242440;
					half4 Model_TransformData1568_g242439 = temp_output_1567_31_g242439;
					half3 Final_PositionOS178_g242439 = ( ( staticSwitch65_g242443 * (Model_TransformData1568_g242439).w ) + (Model_TransformData1568_g242439).xyz );
					float3 temp_output_4_0_g242441 = Final_PositionOS178_g242439;
					float3 In_PositionOS16_g242441 = temp_output_4_0_g242441;
					float3 In_PositionWS16_g242441 = Out_PositionWS15_g242440;
					float3 In_PositionWO16_g242441 = Out_PositionWO15_g242440;
					float3 In_PositionRawOS16_g242441 = Out_PositionRawOS15_g242440;
					float3 In_PivotOS16_g242441 = Out_PivotOS15_g242440;
					float3 In_PivotWS16_g242441 = Out_PivotWS15_g242440;
					float3 In_PivotWO16_g242441 = Out_PivotWO15_g242440;
					float3 temp_output_21_0_g242441 = Out_NormalOS15_g242440;
					float3 In_NormalOS16_g242441 = temp_output_21_0_g242441;
					float3 In_NormalWS16_g242441 = Out_NormalWS15_g242440;
					float3 In_NormalRawOS16_g242441 = Out_NormalRawOS15_g242440;
					float4 temp_output_6_0_g242441 = Out_TangentOS15_g242440;
					float4 In_TangentOS16_g242441 = temp_output_6_0_g242441;
					float3 In_TangentWS16_g242441 = Out_TangentWS15_g242440;
					float3 In_BitangentWS16_g242441 = Out_BitangentWS15_g242440;
					float3 In_ViewDirWS16_g242441 = Out_ViewDirWS15_g242440;
					float4 In_CoordsData16_g242441 = Out_CoordsData15_g242440;
					float4 In_VertexData16_g242441 = Out_VertexData15_g242440;
					float4 In_MasksData16_g242441 = Out_MasksData15_g242440;
					float4 In_PhaseData16_g242441 = Out_PhaseData15_g242440;
					float4 In_TransformData16_g242441 = temp_output_1567_31_g242439;
					float4 In_RotationData16_g242441 = temp_output_1567_33_g242439;
					float4 In_InterpolatorA16_g242441 = Out_InterpolatorA15_g242440;
					BuildModelVertData( Data16_g242441 , In_Dummy16_g242441 , In_PositionOS16_g242441 , In_PositionWS16_g242441 , In_PositionWO16_g242441 , In_PositionRawOS16_g242441 , In_PivotOS16_g242441 , In_PivotWS16_g242441 , In_PivotWO16_g242441 , In_NormalOS16_g242441 , In_NormalWS16_g242441 , In_NormalRawOS16_g242441 , In_TangentOS16_g242441 , In_TangentWS16_g242441 , In_BitangentWS16_g242441 , In_ViewDirWS16_g242441 , In_CoordsData16_g242441 , In_VertexData16_g242441 , In_MasksData16_g242441 , In_PhaseData16_g242441 , In_TransformData16_g242441 , In_RotationData16_g242441 , In_InterpolatorA16_g242441 );
					TVEModelData Data15_g251358 =(TVEModelData)Data16_g242441;
					float Out_Dummy15_g251358 = 0.0;
					float3 Out_PositionOS15_g251358 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251358 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251358 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251358 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251358 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251358 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251358 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251358 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251358 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251358 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251358 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251358 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251358 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251358 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251358 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251358 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251358 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251358 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251358 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251358 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251358 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251358 , Out_Dummy15_g251358 , Out_PositionOS15_g251358 , Out_PositionWS15_g251358 , Out_PositionWO15_g251358 , Out_PositionRawOS15_g251358 , Out_PivotOS15_g251358 , Out_PivotWS15_g251358 , Out_PivotWO15_g251358 , Out_NormalOS15_g251358 , Out_NormalWS15_g251358 , Out_NormalRawOS15_g251358 , Out_TangentOS15_g251358 , Out_TangentWS15_g251358 , Out_BitangentWS15_g251358 , Out_ViewDirWS15_g251358 , Out_CoordsData15_g251358 , Out_VertexData15_g251358 , Out_MasksData15_g251358 , Out_PhaseData15_g251358 , Out_TransformData15_g251358 , Out_RotationData15_g251358 , Out_InterpolatorA15_g251358 );
					TVEModelData Data16_g251359 =(TVEModelData)Data15_g251358;
					float temp_output_14_0_g251359 = 0.0;
					float In_Dummy16_g251359 = temp_output_14_0_g251359;
					float3 temp_output_217_24_g251357 = Out_PivotOS15_g251358;
					float3 temp_output_216_0_g251357 = ( Out_PositionOS15_g251358 + temp_output_217_24_g251357 );
					float3 temp_output_4_0_g251359 = temp_output_216_0_g251357;
					float3 In_PositionOS16_g251359 = temp_output_4_0_g251359;
					float3 In_PositionWS16_g251359 = Out_PositionWS15_g251358;
					float3 In_PositionWO16_g251359 = Out_PositionWO15_g251358;
					float3 In_PositionRawOS16_g251359 = Out_PositionRawOS15_g251358;
					float3 In_PivotOS16_g251359 = temp_output_217_24_g251357;
					float3 In_PivotWS16_g251359 = Out_PivotWS15_g251358;
					float3 In_PivotWO16_g251359 = Out_PivotWO15_g251358;
					float3 temp_output_21_0_g251359 = Out_NormalOS15_g251358;
					float3 In_NormalOS16_g251359 = temp_output_21_0_g251359;
					float3 In_NormalWS16_g251359 = Out_NormalWS15_g251358;
					float3 In_NormalRawOS16_g251359 = Out_NormalRawOS15_g251358;
					float4 temp_output_6_0_g251359 = Out_TangentOS15_g251358;
					float4 In_TangentOS16_g251359 = temp_output_6_0_g251359;
					float3 In_TangentWS16_g251359 = Out_TangentWS15_g251358;
					float3 In_BitangentWS16_g251359 = Out_BitangentWS15_g251358;
					float3 In_ViewDirWS16_g251359 = Out_ViewDirWS15_g251358;
					float4 In_CoordsData16_g251359 = Out_CoordsData15_g251358;
					float4 In_VertexData16_g251359 = Out_VertexData15_g251358;
					float4 In_MasksData16_g251359 = Out_MasksData15_g251358;
					float4 In_PhaseData16_g251359 = Out_PhaseData15_g251358;
					float4 In_TransformData16_g251359 = Out_TransformData15_g251358;
					float4 In_RotationData16_g251359 = Out_RotationData15_g251358;
					float4 In_InterpolatorA16_g251359 = Out_InterpolatorA15_g251358;
					BuildModelVertData( Data16_g251359 , In_Dummy16_g251359 , In_PositionOS16_g251359 , In_PositionWS16_g251359 , In_PositionWO16_g251359 , In_PositionRawOS16_g251359 , In_PivotOS16_g251359 , In_PivotWS16_g251359 , In_PivotWO16_g251359 , In_NormalOS16_g251359 , In_NormalWS16_g251359 , In_NormalRawOS16_g251359 , In_TangentOS16_g251359 , In_TangentWS16_g251359 , In_BitangentWS16_g251359 , In_ViewDirWS16_g251359 , In_CoordsData16_g251359 , In_VertexData16_g251359 , In_MasksData16_g251359 , In_PhaseData16_g251359 , In_TransformData16_g251359 , In_RotationData16_g251359 , In_InterpolatorA16_g251359 );
					TVEModelData Data15_g251368 =(TVEModelData)Data16_g251359;
					float Out_Dummy15_g251368 = 0.0;
					float3 Out_PositionOS15_g251368 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251368 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251368 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251368 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251368 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251368 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251368 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251368 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251368 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251368 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251368 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251368 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251368 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251368 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251368 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251368 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251368 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251368 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251368 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251368 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251368 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251368 , Out_Dummy15_g251368 , Out_PositionOS15_g251368 , Out_PositionWS15_g251368 , Out_PositionWO15_g251368 , Out_PositionRawOS15_g251368 , Out_PivotOS15_g251368 , Out_PivotWS15_g251368 , Out_PivotWO15_g251368 , Out_NormalOS15_g251368 , Out_NormalWS15_g251368 , Out_NormalRawOS15_g251368 , Out_TangentOS15_g251368 , Out_TangentWS15_g251368 , Out_BitangentWS15_g251368 , Out_ViewDirWS15_g251368 , Out_CoordsData15_g251368 , Out_VertexData15_g251368 , Out_MasksData15_g251368 , Out_PhaseData15_g251368 , Out_TransformData15_g251368 , Out_RotationData15_g251368 , Out_InterpolatorA15_g251368 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251368;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251368;
					v.tangent = Out_TangentOS15_g251368;

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
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2631;-6912,-5376;Inherit;False;Property;_IsShaderType;_IsShaderType;36;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2637;-6720,-5376;Half;False;IsShaderType;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2632;-6912,-4864;Inherit;False;Block Model;23;;242129;7ad7765e793a6714babedee0033c36e9;18,404,0,437,0,431,0,240,0,290,0,289,0,291,0,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0;11;102;FLOAT3;0,0,0;False;163;FLOAT3;0,0,0;False;186;FLOAT3;0,0,0;False;187;FLOAT3;0,0,0;False;166;FLOAT3;0,0,0;False;164;FLOAT3;0,0,0;False;301;FLOAT3;0,0,0;False;418;FLOAT3;0,0,0;False;167;FLOAT4;0,0,0,0;False;172;FLOAT4;0,0,0,0;False;175;FLOAT4;0,0,0,0;False;2;OBJECT;128;OBJECT;314
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2633;-6912,-4736;Inherit;False;2637;IsShaderType;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2634;-6912,-4992;Inherit;False;Block Model;23;;242149;7ad7765e793a6714babedee0033c36e9;18,404,1,437,1,431,1,240,1,290,1,289,1,291,1,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0;11;102;FLOAT3;0,0,0;False;163;FLOAT3;0,0,0;False;186;FLOAT3;0,0,0;False;187;FLOAT3;0,0,0;False;166;FLOAT3;0,0,0;False;164;FLOAT3;0,0,0;False;301;FLOAT3;0,0,0;False;418;FLOAT3;0,0,0;False;167;FLOAT4;0,0,0,0;False;172;FLOAT4;0,0,0,0;False;175;FLOAT4;0,0,0,0;False;2;OBJECT;128;OBJECT;314
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2636;-6528,-4992;Inherit;False;If Model Data;-1;;242169;d269c9c511ff160419055604aade1e70;1,32,1;9;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;33;OBJECT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2377;-6208,-4992;Half;False;Model Vert;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2508;-1280,-4992;Inherit;False;2377;Model Vert;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2374;-5760,-4992;Inherit;False;2373;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2646;-1024,-4992;Inherit;False;Block Flatten;7;;242329;87f7defafe56dbf4b954caf5efc3f5ca;3,1825,1,1872,0,1843,1;1;146;OBJECT;0,0,0,0;False;2;OBJECT;128;OBJECT;1785
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2375;-5504,-4992;Inherit;False;Block Global;37;;242340;212e17d4006dc88449d56ce0340cb5ff;32,308,1,560,1,276,1,285,1,402,1,385,1,283,1,282,1,396,1,417,1,484,0,485,0,486,0,487,0,561,0,482,0,488,0,483,0,315,1,598,0,311,1,578,0,317,1,603,0,604,0,607,0,421,1,321,1,398,1,413,0,557,1,404,1;1;206;OBJECT;0,0,0,0;False;1;OBJECT;151
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2509;-640,-4992;Inherit;False;Break Masks Data;-1;;242417;23311522ecc97b54e8b77d849401069d;0;1;6;OBJECT;0;False;8;FLOAT4;14;FLOAT4;0;FLOAT4;23;FLOAT4;5;FLOAT4;24;FLOAT4;25;FLOAT4;26;FLOAT4;27
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2505;-5184,-4992;Half;False;Global Data;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2551;128,-4992;Inherit;False;Tool Debug Active;18;;242418;0bb5baa3fd5a859489bbfc09acf77496;0;2;80;FLOAT3;0,0,0;False;102;FLOAT;0;False;2;FLOAT3;108;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2603;-4736,-4992;Inherit;False;2377;Model Vert;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2567;128,-4864;Inherit;False;FLOAT;0;0;0;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2511;128,-4480;Inherit;False;FLOAT3;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TransformDirectionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2643;384,-4352;Inherit;False;Object;World;True;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2635;-6528,-4736;Inherit;False;If Model Data;-1;;242420;d269c9c511ff160419055604aade1e70;1,32,1;9;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;33;OBJECT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2568;384,-4992;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2604;-4480,-4992;Inherit;False;Block Pivots Sub;-1;;242421;186f08b1bbe15894d9c677d50398679b;0;1;146;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2605;-4480,-4864;Inherit;False;2505;Global Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2513;128,-4736;Inherit;False;FLOAT3;0;0;0;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2585;768,-4480;Inherit;False;Tool Debug Index;-1;;242425;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;4;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2642;768,-4352;Inherit;False;Tool Debug Index;-1;;242426;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2373;-6208,-4736;Half;False;Model Frag;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2606;-4096,-4992;Inherit;False;Block Blanket Conform;121;;242427;3ce1684c4351aeb42b79a955aa483301;2,389,0,377,1;2;146;OBJECT;0,0,0,0;False;186;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2594;768,-4992;Inherit;False;Tool Debug Index;-1;;242437;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2523;1152,-4480;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2586;768,-4736;Inherit;False;Tool Debug Index;-1;;242438;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;2;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2379;-2560,-4992;Inherit;False;2373;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2550;1408,-4992;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2610;-3712,-4992;Inherit;False;Block Transform;-1;;242439;5ac6202bdddd8b34a85c261af6b8de8b;0;1;146;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2380;-2304,-4992;Inherit;False;Block Main;96;;242450;b04cfed9a7b4c0841afdb49a38c282c5;12,65,1,136,1,41,1,133,1,40,1,329,1,344,0,347,0,342,0,345,0,346,0,343,0;1;225;OBJECT;0,0,0,0;False;1;OBJECT;106
Node;AmplifyShaderEditor.VertexToFragmentNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2524;1536,-4992;Inherit;False;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2607;-3328,-4992;Inherit;False;Block Pivots Add;-1;;251357;016babe9e3e643242aa4d123a988150c;0;1;146;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2454;-1984,-4992;Half;False;Visual Data;-1;True;1;0;OBJECT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2399;1856,-4992;Half;False;Final_Debug;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2608;-3008,-4992;Half;False;Model Data;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2400;2432,-4992;Inherit;False;2399;Final_Debug;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2563;2432,-4928;Inherit;False;2454;Visual Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2555;2432,-4864;Inherit;False;2608;Model Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2507;-1280,-4928;Inherit;False;2505;Global Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2203;3072,-5120;Inherit;False;Base Compile;-1;;251361;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2609;2688,-4992;Inherit;False;Tool Debug Color;0;;251362;d992d3ed4a7539141ba053d3e0c12277;0;3;80;FLOAT3;0,0,0;False;106;OBJECT;0,0,0;False;107;OBJECT;0,0,0;False;5;FLOAT;114;FLOAT3;0;FLOAT3;113;FLOAT3;148;FLOAT4;149
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2355;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2356;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2357;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2358;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2353;2688,-4992;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ExtraPrePass;0;0;ExtraPrePass;5;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2354;3072,-4992;Float;False;True;-1;3;;0;3;Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Flatten;28cd5599e02859647ae1798e4fcaef6c;True;ForwardBase;0;1;ForwardBase;15;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;40;Category;0;0;Workflow;0;638874882197810641;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;0;638874603607655403;Deferred Pass;1;0;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;638814711411603618;Receive Shadows;0;638814711415148256;Receive Specular;0;638814711419031593;GPU Instancing;1;638874881145939632;LOD CrossFade;0;638814711429956434;Built-in Fog;0;638814711441065168;Ambient Light;0;638814711449050123;Meta Pass;0;638814711456998358;Add Pass;0;638814711466594157;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;638874882298697380;Vertex Position;0;638874601191422915;0;8;False;True;False;True;False;False;True;True;False;;True;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2638;3072,-4932;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2639;3072,-4992;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ScenePickingPass;0;7;ScenePickingPass;1;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=ScenePickingPass;False;False;0;;0;0;Standard;0;False;0
WireConnection;2637;0;2631;0
WireConnection;2636;33;2634;128
WireConnection;2636;27;2634;128
WireConnection;2636;28;2634;128
WireConnection;2636;29;2634;128
WireConnection;2636;30;2632;128
WireConnection;2636;31;2633;0
WireConnection;2377;0;2636;0
WireConnection;2646;146;2508;0
WireConnection;2375;206;2374;0
WireConnection;2509;6;2646;1785
WireConnection;2505;0;2375;151
WireConnection;2567;0;2509;14
WireConnection;2511;0;2509;23
WireConnection;2643;0;2511;0
WireConnection;2635;33;2634;314
WireConnection;2635;27;2634;314
WireConnection;2635;28;2634;314
WireConnection;2635;29;2634;314
WireConnection;2635;30;2632;314
WireConnection;2635;31;2633;0
WireConnection;2568;0;2551;108
WireConnection;2568;1;2551;0
WireConnection;2568;2;2567;0
WireConnection;2604;146;2603;0
WireConnection;2513;0;2509;0
WireConnection;2585;39;2511;0
WireConnection;2642;39;2643;0
WireConnection;2373;0;2635;0
WireConnection;2606;146;2604;128
WireConnection;2606;186;2605;0
WireConnection;2594;39;2568;0
WireConnection;2523;0;2585;0
WireConnection;2523;1;2642;0
WireConnection;2586;39;2513;0
WireConnection;2550;0;2594;0
WireConnection;2550;1;2586;0
WireConnection;2550;2;2523;0
WireConnection;2610;146;2606;128
WireConnection;2380;225;2379;0
WireConnection;2524;0;2550;0
WireConnection;2607;146;2610;128
WireConnection;2454;0;2380;106
WireConnection;2399;0;2524;0
WireConnection;2608;0;2607;128
WireConnection;2609;80;2400;0
WireConnection;2609;106;2563;0
WireConnection;2609;107;2555;0
WireConnection;2354;0;2609;114
WireConnection;2354;3;2609;114
WireConnection;2354;5;2609;114
WireConnection;2354;2;2609;0
WireConnection;2354;15;2609;113
WireConnection;2354;16;2609;148
WireConnection;2354;17;2609;149
ASEEND*/
//CHKSM=948A73829EBB05518A676C0D0C4F95BB5705F247