// Made with Amplify Shader Editor v1.9.9.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Motion"
{
	Properties
	{
		_RenderClip( "_RenderClip", Float ) = 0
		_IsElementShader( "_IsElementShader", Float ) = 0
		_IsHelperShader( "_IsHelperShader", Float ) = 0
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
		[StyledCategory(Motion Settings, true, Use the Motion feature to add wind animation and interaction to foliage. The shaders support 3 layers of animation driven by vertex colors__ procedural masks or texture masksCOLNEWNEWUse the Primary Motion to add bending animation. The bending can work per instance for plants and trees or per baked pivots for grass so each blade is bending individually.NEWNEWUse the Second Motion to push the vertices in the wind direction. Perfect for tree cannopies__ palm or willow tree leaves.NEWNEWUse the Leaves Motion to add flutter to the leaves or leaf edges.NEWNEWUse the Ripples Motion to add a visual effect for the flowing wind texture.NEWNEWAll layers use flow maps for the wind animation. Use the Noise sliders to control how turbulent the motion is at high wind. Use the Pivots slider to control if the the flow map is sampled in world space or per pivotSLHpivots. Use the Phase slider to offset the animation based on the baked Object Phase Mode option. Use the Tiling and Speed values to control the overall flow map animation.NEWNEWUse the Details Limit value to fade out the flutter and ripples at high distances to avoid visual noise., _MotionIntensityValue, 03CC4E, 0, 10)] _MotionCategory( "[ Motion Category ]", Float ) = 0
		[StyledMessage(Info, The Interaction features require elements to work. Use Flow elements to add interaction and use the Interaction slider to control the intensity per motion layer., 0, 10)] _MotionPushInfo( "# Message Push", Float ) = 0
		[NoScaleOffset][StyledTextureSingleLine(Noise RGBA)] _MotionNoiseTex( "Motion Noise", 2D ) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine(PrimaryMask R SecondMask G LeavesMask B)] _MotionMaskTex( "Motion Masks", 2D ) = "white" {}
		[Space(10)] _MotionIntensityValue( "Motion Intensity", Range( 0, 1 ) ) = 0
		_MotionDistValue( "Motion Details Limit", Range( 0, 2000 ) ) = 100
		[Space(10)] _MotionBaseIntensityValue( "Motion Primary Intensity", Range( 0, 10 ) ) = 0
		_MotionBaseDelayValue( "Motion Primary Delay", Range( 0, 1 ) ) = 0
		_MotionBaseNoiseValue( "Motion Primary Noise", Range( 0, 1 ) ) = 0.5
		_MotionBasePivotValue( "Motion Primary Pivots", Range( 0, 1 ) ) = 0.8
		_MotionBasePhaseValue( "Motion Primary Phase", Range( 0, 1 ) ) = 0
		_MotionBaseTillingValue( "Motion Primary Tilling", Range( 0, 100 ) ) = 5
		_MotionBaseSpeedValue( "Motion Primary Speed", Range( 0, 50 ) ) = 5
		_MotionBasePushValue( "Motion Primary Interaction", Range( 0, 10 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3,Height,4,Capsule,5,Masks R,6)] _MotionBaseMaskMode( "Motion Primary Anim Mask", Float ) = 3
		[StyledRemapSlider] _MotionBaseMaskRemap( "Motion Primary Anim Mask", Vector ) = ( 0, 1, 0, 0 )
		[Space(10)] _MotionSmallIntensityValue( "Motion Second Intensity", Range( 0, 10 ) ) = 0
		_MotionSmallDelayValue( "Motion Second Delay", Range( 0, 1 ) ) = 0
		_MotionSmallNoiseValue( "Motion Second Noise", Range( 0, 1 ) ) = 0.5
		_MotionSmallPivotValue( "Motion Second Pivots", Range( 0, 1 ) ) = 0.2
		_MotionSmallPhaseValue( "Motion Second Phase", Range( 0, 1 ) ) = 0
		_MotionSmallTillingValue( "Motion Second Tilling", Range( 0, 100 ) ) = 5
		_MotionSmallSpeedValue( "Motion Second Speed", Range( 0, 50 ) ) = 5
		_MotionSmallPushValue( "Motion Second Interaction", Range( 0, 10 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3,Height,4,Capsule,5,Masks G,6)] _MotionSmallMaskMode( "Motion Second Anim Mask", Float ) = 1
		[StyledRemapSlider] _MotionSmallMaskRemap( "Motion Second Anim Mask", Vector ) = ( 0, 1, 0, 0 )
		[Space(10)] _MotionTinyIntensityValue( "Motion Leaves Intensity", Range( 0, 10 ) ) = 0
		_MotionTinyNoiseValue( "Motion Leaves Noise", Range( 0, 1 ) ) = 1
		_MotionTinyTillingValue( "Motion Leaves Tilling", Range( 0, 100 ) ) = 50
		_MotionTinySpeedValue( "Motion Leaves Speed", Range( 0, 50 ) ) = 10
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3,Height,4,Capsule,5,Masks B,6)] _MotionTinyMaskMode( "Motion Leaves Anim Mask", Float ) = 2
		[StyledRemapSlider] _MotionTinyMaskRemap( "Motion Leaves Anim Mask", Vector ) = ( 0, 1, 0, 0 )
		[Space(10)] _MotionHighlightValue( "Motion Ripples Intensity", Range( 0, 1 ) ) = 0
		[HDR][Gamma] _MotionHighlightColor( "Motion Ripples Color", Color ) = ( 1, 1, 1, 1 )
		[Space(10)][StyledToggle] _MotionElementMode( "Use Flow Elements", Float ) = 0
		[HideInInspector] _motion_small_mode( "_motion_small_mode", Float ) = 0
		[HideInInspector][NoScaleOffset] _NoiseTex3D( "Noise Mask 3D", 3D ) = "white" {}
		[StyledSpace(10)] _MotionEnd( "[ Motion End ]", Float ) = 1
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
				#pragma shader_feature_local_vertex TVE_MOTION
				#pragma shader_feature_local_vertex TVE_MOTION_ELEMENT
				#pragma shader_feature_local TVE_LEGACY
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
				#if defined (TVE_MOTION) //Motion
					#define TVE_ROTATION_BEND //Motion
				#endif //Motion
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
				#define SAMPLE_TEXTURE3D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE3D_LOD(tex,samplerTex,coord,lod) tex3Dlod(tex,float4(coord,lod))
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
					float4 ase_texcoord11 : TEXCOORD11;
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
				uniform half _MotionCategory;
				uniform half _MotionEnd;
				uniform half _MotionPushInfo;
				uniform half4 TVE_WindParams;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MotionNoiseTex);
				uniform half _MotionSmallPivotValue;
				uniform half _MotionSmallPhaseValue;
				uniform half _MotionSmallTillingValue;
				uniform half4 TVE_MotionTimeParams;
				uniform half _MotionSmallSpeedValue;
				uniform half _MotionSmallNoiseValue;
				uniform half _MotionElementMode;
				uniform half4 TVE_WindEditor;
				uniform half _MotionIntensityValue;
				uniform half _MotionSmallDelayValue;
				uniform half _MotionSmallIntensityValue;
				uniform half _MotionSmallPushValue;
				uniform half _MotionSmallMaskMode;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MotionMaskTex);
				SamplerState sampler_MotionMaskTex;
				uniform half4 _MotionSmallMaskRemap;
				uniform half4 TVE_MotionValueParams;
				uniform half _MotionTinyIntensityValue;
				uniform half _MotionDistValue;
				uniform half _MotionTinyMaskMode;
				uniform half4 _MotionTinyMaskRemap;
				uniform half _MotionTinyTillingValue;
				uniform half _MotionTinySpeedValue;
				uniform half _MotionTinyNoiseValue;
				UNITY_DECLARE_TEX3D_NOSAMPLER(_NoiseTex3D);
				uniform half _MotionBasePivotValue;
				uniform half _MotionBasePhaseValue;
				uniform half _MotionBaseTillingValue;
				uniform half _MotionBaseSpeedValue;
				uniform half _MotionBaseNoiseValue;
				uniform half _MotionBaseIntensityValue;
				uniform half _MotionBaseDelayValue;
				uniform half _MotionBasePushValue;
				uniform half _MotionBaseMaskMode;
				uniform half4 _MotionBaseMaskRemap;
				uniform half _MotionHighlightValue;
				uniform half _motion_small_mode;
				uniform half4 _MotionHighlightColor;
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
				
				float2 DecodeFloatToVector2( float enc )
				{
					float2 result ;
					result.y = enc % 2048;
					result.x = floor(enc / 2048);
					return result / (2048 - 1);
				}
				
				float3 HSVToRGB( float3 c )
				{
					float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
					float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
					return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
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

					float localIfModelDataByShader26_g241935 = ( 0.0 );
					TVEModelData Data26_g241935 = (TVEModelData)0;
					TVEModelData Data16_g241848 =(TVEModelData)0;
					half Dummy207_g241838 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g241848 = Dummy207_g241838;
					float In_Dummy16_g241848 = temp_output_14_0_g241848;
					float3 PositionOS131_g241838 = v.vertex.xyz;
					float3 temp_output_4_0_g241848 = PositionOS131_g241838;
					float3 In_PositionOS16_g241848 = temp_output_4_0_g241848;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g241838 = ase_positionWS;
					float3 vertexToFrag73_g241838 = temp_output_104_7_g241838;
					float3 PositionWS122_g241838 = vertexToFrag73_g241838;
					float3 In_PositionWS16_g241848 = PositionWS122_g241838;
					float4x4 break19_g241841 = unity_ObjectToWorld;
					float3 appendResult20_g241841 = (float3(break19_g241841[ 0 ][ 3 ] , break19_g241841[ 1 ][ 3 ] , break19_g241841[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241838 = appendResult20_g241841;
					float4x4 break19_g241843 = unity_ObjectToWorld;
					float3 appendResult20_g241843 = (float3(break19_g241843[ 0 ][ 3 ] , break19_g241843[ 1 ][ 3 ] , break19_g241843[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g241839 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g241838 = PositionOS131_g241838;
					float3 appendResult234_g241838 = (float3(break233_g241838.x , 0.0 , break233_g241838.z));
					float3 break413_g241838 = PositionOS131_g241838;
					float3 appendResult414_g241838 = (float3(break413_g241838.x , break413_g241838.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g241845 = appendResult414_g241838;
					#else
					float3 staticSwitch65_g241845 = appendResult234_g241838;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g241838 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g241838 = appendResult60_g241839;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g241838 = staticSwitch65_g241845;
					#else
					float3 staticSwitch229_g241838 = _Vector0;
					#endif
					float3 PivotOS149_g241838 = staticSwitch229_g241838;
					float3 temp_output_122_0_g241843 = PivotOS149_g241838;
					float3 PivotsOnlyWS105_g241843 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g241843 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g241838 = ( appendResult20_g241843 + PivotsOnlyWS105_g241843 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g241838 = temp_output_340_7_g241838;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g241838 = temp_output_341_7_g241838;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g241838 = temp_output_341_7_g241838;
					#else
					float3 staticSwitch236_g241838 = temp_output_340_7_g241838;
					#endif
					float3 vertexToFrag76_g241838 = staticSwitch236_g241838;
					float3 PivotWS121_g241838 = vertexToFrag76_g241838;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241838 = ( PositionWS122_g241838 - PivotWS121_g241838 );
					#else
					float3 staticSwitch204_g241838 = PositionWS122_g241838;
					#endif
					float3 PositionWO132_g241838 = ( staticSwitch204_g241838 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241848 = PositionWO132_g241838;
					float3 In_PositionRawOS16_g241848 = PositionOS131_g241838;
					float3 In_PivotOS16_g241848 = PivotOS149_g241838;
					float3 In_PivotWS16_g241848 = PivotWS121_g241838;
					float3 PivotWO133_g241838 = ( PivotWS121_g241838 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241848 = PivotWO133_g241838;
					half3 NormalOS134_g241838 = v.normal;
					float3 temp_output_21_0_g241848 = NormalOS134_g241838;
					float3 In_NormalOS16_g241848 = temp_output_21_0_g241848;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g241838 = normalizedWorldNormal;
					float3 In_NormalWS16_g241848 = NormalWS95_g241838;
					float3 In_NormalRawOS16_g241848 = NormalOS134_g241838;
					half4 TangentlOS153_g241838 = v.tangent;
					float4 temp_output_6_0_g241848 = TangentlOS153_g241838;
					float4 In_TangentOS16_g241848 = temp_output_6_0_g241848;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g241838 = ase_tangentWS;
					float3 In_TangentWS16_g241848 = TangentWS136_g241838;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g241838 = ase_bitangentWS;
					float3 In_BitangentWS16_g241848 = BiangentWS421_g241838;
					float3 normalizeResult296_g241838 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241838 ) );
					half3 ViewDirWS169_g241838 = normalizeResult296_g241838;
					float3 In_ViewDirWS16_g241848 = ViewDirWS169_g241838;
					float4 appendResult397_g241838 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g241838 = appendResult397_g241838;
					float4 In_CoordsData16_g241848 = CoordsData398_g241838;
					half4 VertexMasks171_g241838 = v.ase_color;
					float4 In_VertexData16_g241848 = VertexMasks171_g241838;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241851 = (PositionOS131_g241838).z;
					#else
					float staticSwitch65_g241851 = (PositionOS131_g241838).y;
					#endif
					half Object_HeightValue267_g241838 = _ObjectHeightValue;
					half Bounds_HeightMask274_g241838 = saturate( ( staticSwitch65_g241851 / Object_HeightValue267_g241838 ) );
					half3 Position387_g241838 = PositionOS131_g241838;
					half Height387_g241838 = Object_HeightValue267_g241838;
					half Object_RadiusValue268_g241838 = _ObjectRadiusValue;
					half Radius387_g241838 = Object_RadiusValue268_g241838;
					half localCapsuleMaskYUp387_g241838 = CapsuleMaskYUp( Position387_g241838 , Height387_g241838 , Radius387_g241838 );
					half3 Position408_g241838 = PositionOS131_g241838;
					half Height408_g241838 = Object_HeightValue267_g241838;
					half Radius408_g241838 = Object_RadiusValue268_g241838;
					half localCapsuleMaskZUp408_g241838 = CapsuleMaskZUp( Position408_g241838 , Height408_g241838 , Radius408_g241838 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241856 = saturate( localCapsuleMaskZUp408_g241838 );
					#else
					float staticSwitch65_g241856 = saturate( localCapsuleMaskYUp387_g241838 );
					#endif
					half Bounds_SphereMask282_g241838 = staticSwitch65_g241856;
					float4 appendResult253_g241838 = (float4(Bounds_HeightMask274_g241838 , Bounds_SphereMask282_g241838 , 1.0 , 1.0));
					half4 MasksData254_g241838 = appendResult253_g241838;
					float4 In_MasksData16_g241848 = MasksData254_g241838;
					float temp_output_17_0_g241850 = _ObjectPhaseMode;
					float Option70_g241850 = temp_output_17_0_g241850;
					float4 temp_output_3_0_g241850 = v.ase_color;
					float4 Channel70_g241850 = temp_output_3_0_g241850;
					float localSwitchChannel470_g241850 = SwitchChannel4( Option70_g241850 , Channel70_g241850 );
					half Phase_Value372_g241838 = localSwitchChannel470_g241850;
					float3 break319_g241838 = PivotWO133_g241838;
					half Pivot_Position322_g241838 = ( break319_g241838.x + break319_g241838.z );
					half Phase_Position357_g241838 = ( Phase_Value372_g241838 + Pivot_Position322_g241838 );
					float temp_output_248_0_g241838 = frac( Phase_Position357_g241838 );
					float4 appendResult177_g241838 = (float4(( (frac( ( Phase_Position357_g241838 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g241838));
					half4 Phase_Data176_g241838 = appendResult177_g241838;
					float4 In_PhaseData16_g241848 = Phase_Data176_g241838;
					float4 In_TransformData16_g241848 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g241848 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g241848 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g241848 , In_Dummy16_g241848 , In_PositionOS16_g241848 , In_PositionWS16_g241848 , In_PositionWO16_g241848 , In_PositionRawOS16_g241848 , In_PivotOS16_g241848 , In_PivotWS16_g241848 , In_PivotWO16_g241848 , In_NormalOS16_g241848 , In_NormalWS16_g241848 , In_NormalRawOS16_g241848 , In_TangentOS16_g241848 , In_TangentWS16_g241848 , In_BitangentWS16_g241848 , In_ViewDirWS16_g241848 , In_CoordsData16_g241848 , In_VertexData16_g241848 , In_MasksData16_g241848 , In_PhaseData16_g241848 , In_TransformData16_g241848 , In_RotationData16_g241848 , In_InterpolatorA16_g241848 );
					TVEModelData DataDefault26_g241935 = Data16_g241848;
					TVEModelData DataGeneral26_g241935 = Data16_g241848;
					TVEModelData DataBlanket26_g241935 = Data16_g241848;
					TVEModelData DataImpostor26_g241935 = Data16_g241848;
					TVEModelData Data16_g241828 =(TVEModelData)0;
					half Dummy207_g241818 = 0.0;
					float temp_output_14_0_g241828 = Dummy207_g241818;
					float In_Dummy16_g241828 = temp_output_14_0_g241828;
					float3 PositionOS131_g241818 = v.vertex.xyz;
					float3 temp_output_4_0_g241828 = PositionOS131_g241818;
					float3 In_PositionOS16_g241828 = temp_output_4_0_g241828;
					float3 temp_output_104_7_g241818 = ase_positionWS;
					float3 PositionWS122_g241818 = temp_output_104_7_g241818;
					float3 In_PositionWS16_g241828 = PositionWS122_g241818;
					float4x4 break19_g241821 = unity_ObjectToWorld;
					float3 appendResult20_g241821 = (float3(break19_g241821[ 0 ][ 3 ] , break19_g241821[ 1 ][ 3 ] , break19_g241821[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241818 = appendResult20_g241821;
					float3 PivotWS121_g241818 = temp_output_340_7_g241818;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241818 = ( PositionWS122_g241818 - PivotWS121_g241818 );
					#else
					float3 staticSwitch204_g241818 = PositionWS122_g241818;
					#endif
					float3 PositionWO132_g241818 = ( staticSwitch204_g241818 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241828 = PositionWO132_g241818;
					float3 In_PositionRawOS16_g241828 = PositionOS131_g241818;
					float3 PivotOS149_g241818 = _Vector0;
					float3 In_PivotOS16_g241828 = PivotOS149_g241818;
					float3 In_PivotWS16_g241828 = PivotWS121_g241818;
					float3 PivotWO133_g241818 = ( PivotWS121_g241818 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241828 = PivotWO133_g241818;
					half3 NormalOS134_g241818 = v.normal;
					float3 temp_output_21_0_g241828 = NormalOS134_g241818;
					float3 In_NormalOS16_g241828 = temp_output_21_0_g241828;
					half3 NormalWS95_g241818 = normalizedWorldNormal;
					float3 In_NormalWS16_g241828 = NormalWS95_g241818;
					float3 In_NormalRawOS16_g241828 = NormalOS134_g241818;
					half4 TangentlOS153_g241818 = v.tangent;
					float4 temp_output_6_0_g241828 = TangentlOS153_g241818;
					float4 In_TangentOS16_g241828 = temp_output_6_0_g241828;
					half3 TangentWS136_g241818 = ase_tangentWS;
					float3 In_TangentWS16_g241828 = TangentWS136_g241818;
					half3 BiangentWS421_g241818 = ase_bitangentWS;
					float3 In_BitangentWS16_g241828 = BiangentWS421_g241818;
					float3 normalizeResult296_g241818 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241818 ) );
					half3 ViewDirWS169_g241818 = normalizeResult296_g241818;
					float3 In_ViewDirWS16_g241828 = ViewDirWS169_g241818;
					float4 appendResult397_g241818 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g241818 = appendResult397_g241818;
					float4 In_CoordsData16_g241828 = CoordsData398_g241818;
					half4 VertexMasks171_g241818 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241828 = VertexMasks171_g241818;
					half4 MasksData254_g241818 = float4( 0,0,0,0 );
					float4 In_MasksData16_g241828 = MasksData254_g241818;
					half4 Phase_Data176_g241818 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241828 = Phase_Data176_g241818;
					float4 In_TransformData16_g241828 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g241828 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g241828 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g241828 , In_Dummy16_g241828 , In_PositionOS16_g241828 , In_PositionWS16_g241828 , In_PositionWO16_g241828 , In_PositionRawOS16_g241828 , In_PivotOS16_g241828 , In_PivotWS16_g241828 , In_PivotWO16_g241828 , In_NormalOS16_g241828 , In_NormalWS16_g241828 , In_NormalRawOS16_g241828 , In_TangentOS16_g241828 , In_TangentWS16_g241828 , In_BitangentWS16_g241828 , In_ViewDirWS16_g241828 , In_CoordsData16_g241828 , In_VertexData16_g241828 , In_MasksData16_g241828 , In_PhaseData16_g241828 , In_TransformData16_g241828 , In_RotationData16_g241828 , In_InterpolatorA16_g241828 );
					TVEModelData DataTerrain26_g241935 = Data16_g241828;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g241935 = IsShaderType2637;
					{
					if (Type26_g241935 == 0 )
					{
					Data26_g241935 = DataDefault26_g241935;
					}
					else if (Type26_g241935 == 1 )
					{
					Data26_g241935 = DataGeneral26_g241935;
					}
					else if (Type26_g241935 == 2 )
					{
					Data26_g241935 = DataBlanket26_g241935;
					}
					else if (Type26_g241935 == 3 )
					{
					Data26_g241935 = DataImpostor26_g241935;
					}
					else if (Type26_g241935 == 4 )
					{
					Data26_g241935 = DataTerrain26_g241935;
					}
					}
					TVEModelData Data15_g251335 =(TVEModelData)Data26_g241935;
					float Out_Dummy15_g251335 = 0.0;
					float3 Out_PositionOS15_g251335 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251335 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251335 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251335 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251335 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251335 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251335 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251335 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251335 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251335 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251335 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251335 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251335 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251335 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251335 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251335 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251335 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251335 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251335 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251335 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251335 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251335 , Out_Dummy15_g251335 , Out_PositionOS15_g251335 , Out_PositionWS15_g251335 , Out_PositionWO15_g251335 , Out_PositionRawOS15_g251335 , Out_PivotOS15_g251335 , Out_PivotWS15_g251335 , Out_PivotWO15_g251335 , Out_NormalOS15_g251335 , Out_NormalWS15_g251335 , Out_NormalRawOS15_g251335 , Out_TangentOS15_g251335 , Out_TangentWS15_g251335 , Out_BitangentWS15_g251335 , Out_ViewDirWS15_g251335 , Out_CoordsData15_g251335 , Out_VertexData15_g251335 , Out_MasksData15_g251335 , Out_PhaseData15_g251335 , Out_TransformData15_g251335 , Out_RotationData15_g251335 , Out_InterpolatorA15_g251335 );
					TVEModelData Data16_g251337 =(TVEModelData)Data15_g251335;
					float temp_output_14_0_g251337 = 0.0;
					float In_Dummy16_g251337 = temp_output_14_0_g251337;
					float3 temp_output_219_24_g251334 = Out_PivotOS15_g251335;
					float3 temp_output_215_0_g251334 = ( Out_PositionOS15_g251335 - temp_output_219_24_g251334 );
					float3 temp_output_4_0_g251337 = temp_output_215_0_g251334;
					float3 In_PositionOS16_g251337 = temp_output_4_0_g251337;
					float3 In_PositionWS16_g251337 = Out_PositionWS15_g251335;
					float3 In_PositionWO16_g251337 = Out_PositionWO15_g251335;
					float3 In_PositionRawOS16_g251337 = Out_PositionRawOS15_g251335;
					float3 In_PivotOS16_g251337 = temp_output_219_24_g251334;
					float3 In_PivotWS16_g251337 = Out_PivotWS15_g251335;
					float3 In_PivotWO16_g251337 = Out_PivotWO15_g251335;
					float3 temp_output_21_0_g251337 = Out_NormalOS15_g251335;
					float3 In_NormalOS16_g251337 = temp_output_21_0_g251337;
					float3 In_NormalWS16_g251337 = Out_NormalWS15_g251335;
					float3 In_NormalRawOS16_g251337 = Out_NormalRawOS15_g251335;
					float4 temp_output_6_0_g251337 = Out_TangentOS15_g251335;
					float4 In_TangentOS16_g251337 = temp_output_6_0_g251337;
					float3 In_TangentWS16_g251337 = Out_TangentWS15_g251335;
					float3 In_BitangentWS16_g251337 = Out_BitangentWS15_g251335;
					float3 In_ViewDirWS16_g251337 = Out_ViewDirWS15_g251335;
					float4 In_CoordsData16_g251337 = Out_CoordsData15_g251335;
					float4 In_VertexData16_g251337 = Out_VertexData15_g251335;
					float4 In_MasksData16_g251337 = Out_MasksData15_g251335;
					float4 In_PhaseData16_g251337 = Out_PhaseData15_g251335;
					float4 In_TransformData16_g251337 = Out_TransformData15_g251335;
					float4 In_RotationData16_g251337 = Out_RotationData15_g251335;
					float4 In_InterpolatorA16_g251337 = Out_InterpolatorA15_g251335;
					BuildModelVertData( Data16_g251337 , In_Dummy16_g251337 , In_PositionOS16_g251337 , In_PositionWS16_g251337 , In_PositionWO16_g251337 , In_PositionRawOS16_g251337 , In_PivotOS16_g251337 , In_PivotWS16_g251337 , In_PivotWO16_g251337 , In_NormalOS16_g251337 , In_NormalWS16_g251337 , In_NormalRawOS16_g251337 , In_TangentOS16_g251337 , In_TangentWS16_g251337 , In_BitangentWS16_g251337 , In_ViewDirWS16_g251337 , In_CoordsData16_g251337 , In_VertexData16_g251337 , In_MasksData16_g251337 , In_PhaseData16_g251337 , In_TransformData16_g251337 , In_RotationData16_g251337 , In_InterpolatorA16_g251337 );
					TVEModelData Data15_g251366 =(TVEModelData)Data16_g251337;
					float Out_Dummy15_g251366 = 0.0;
					float3 Out_PositionOS15_g251366 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251366 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251366 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251366 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251366 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251366 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251366 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251366 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251366 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251366 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251366 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251366 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251366 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251366 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251366 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251366 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251366 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251366 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251366 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251366 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251366 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251366 , Out_Dummy15_g251366 , Out_PositionOS15_g251366 , Out_PositionWS15_g251366 , Out_PositionWO15_g251366 , Out_PositionRawOS15_g251366 , Out_PivotOS15_g251366 , Out_PivotWS15_g251366 , Out_PivotWO15_g251366 , Out_NormalOS15_g251366 , Out_NormalWS15_g251366 , Out_NormalRawOS15_g251366 , Out_TangentOS15_g251366 , Out_TangentWS15_g251366 , Out_BitangentWS15_g251366 , Out_ViewDirWS15_g251366 , Out_CoordsData15_g251366 , Out_VertexData15_g251366 , Out_MasksData15_g251366 , Out_PhaseData15_g251366 , Out_TransformData15_g251366 , Out_RotationData15_g251366 , Out_InterpolatorA15_g251366 );
					TVEModelData Data16_g251367 =(TVEModelData)Data15_g251366;
					half Dummy317_g251365 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g251367 = Dummy317_g251365;
					float In_Dummy16_g251367 = temp_output_14_0_g251367;
					float3 temp_output_4_0_g251367 = Out_PositionOS15_g251366;
					float3 In_PositionOS16_g251367 = temp_output_4_0_g251367;
					float3 In_PositionWS16_g251367 = Out_PositionWS15_g251366;
					float3 temp_output_314_17_g251365 = Out_PositionWO15_g251366;
					float3 In_PositionWO16_g251367 = temp_output_314_17_g251365;
					float3 In_PositionRawOS16_g251367 = Out_PositionRawOS15_g251366;
					float3 In_PivotOS16_g251367 = Out_PivotOS15_g251366;
					float3 In_PivotWS16_g251367 = Out_PivotWS15_g251366;
					float3 temp_output_314_19_g251365 = Out_PivotWO15_g251366;
					float3 In_PivotWO16_g251367 = temp_output_314_19_g251365;
					float3 temp_output_21_0_g251367 = Out_NormalOS15_g251366;
					float3 In_NormalOS16_g251367 = temp_output_21_0_g251367;
					float3 In_NormalWS16_g251367 = Out_NormalWS15_g251366;
					float3 In_NormalRawOS16_g251367 = Out_NormalRawOS15_g251366;
					float4 temp_output_6_0_g251367 = Out_TangentOS15_g251366;
					float4 In_TangentOS16_g251367 = temp_output_6_0_g251367;
					float3 In_TangentWS16_g251367 = Out_TangentWS15_g251366;
					float3 In_BitangentWS16_g251367 = Out_BitangentWS15_g251366;
					float3 In_ViewDirWS16_g251367 = Out_ViewDirWS15_g251366;
					float4 In_CoordsData16_g251367 = Out_CoordsData15_g251366;
					float4 temp_output_314_29_g251365 = Out_VertexData15_g251366;
					float4 In_VertexData16_g251367 = temp_output_314_29_g251365;
					float4 In_MasksData16_g251367 = Out_MasksData15_g251366;
					float4 In_PhaseData16_g251367 = Out_PhaseData15_g251366;
					half4 Model_TransformData356_g251365 = Out_TransformData15_g251366;
					float localBuildGlobalData204_g241858 = ( 0.0 );
					TVEGlobalData Data204_g241858 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g241858 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g241858 = Dummy211_g241858;
					float4 temp_output_589_164_g241858 = TVE_CoatParams;
					half4 Coat_Params596_g241858 = temp_output_589_164_g241858;
					float4 In_CoatParams204_g241858 = Coat_Params596_g241858;
					float4 temp_output_203_0_g241878 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g241817 = ( 0.0 );
					TVEModelData Data26_g241817 = (TVEModelData)0;
					TVEModelData Data16_g241846 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241846 = 0.0;
					float3 In_PositionWS16_g241846 = PositionWS122_g241838;
					float3 In_PositionWO16_g241846 = PositionWO132_g241838;
					float3 In_PivotWS16_g241846 = PivotWS121_g241838;
					float3 In_PivotWO16_g241846 = PivotWO133_g241838;
					float3 In_NormalWS16_g241846 = NormalWS95_g241838;
					float3 In_TangentWS16_g241846 = TangentWS136_g241838;
					float3 In_BitangentWS16_g241846 = BiangentWS421_g241838;
					half3 NormalWS427_g241838 = NormalWS95_g241838;
					half3 localComputeTriplanarWeights427_g241838 = ComputeTriplanarWeights( NormalWS427_g241838 );
					half3 TriplanarWeights429_g241838 = localComputeTriplanarWeights427_g241838;
					float3 In_TriplanarWeights16_g241846 = TriplanarWeights429_g241838;
					float3 In_ViewDirWS16_g241846 = ViewDirWS169_g241838;
					float4 In_CoordsData16_g241846 = CoordsData398_g241838;
					float4 In_VertexData16_g241846 = VertexMasks171_g241838;
					float4 In_PhaseData16_g241846 = Phase_Data176_g241838;
					BuildModelFragData( Data16_g241846 , In_Dummy16_g241846 , In_PositionWS16_g241846 , In_PositionWO16_g241846 , In_PivotWS16_g241846 , In_PivotWO16_g241846 , In_NormalWS16_g241846 , In_TangentWS16_g241846 , In_BitangentWS16_g241846 , In_TriplanarWeights16_g241846 , In_ViewDirWS16_g241846 , In_CoordsData16_g241846 , In_VertexData16_g241846 , In_PhaseData16_g241846 );
					TVEModelData DataDefault26_g241817 = Data16_g241846;
					TVEModelData DataGeneral26_g241817 = Data16_g241846;
					TVEModelData DataBlanket26_g241817 = Data16_g241846;
					TVEModelData DataImpostor26_g241817 = Data16_g241846;
					TVEModelData Data16_g241826 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241826 = 0.0;
					float3 In_PositionWS16_g241826 = PositionWS122_g241818;
					float3 In_PositionWO16_g241826 = PositionWO132_g241818;
					float3 In_PivotWS16_g241826 = PivotWS121_g241818;
					float3 In_PivotWO16_g241826 = PivotWO133_g241818;
					float3 In_NormalWS16_g241826 = NormalWS95_g241818;
					float3 In_TangentWS16_g241826 = TangentWS136_g241818;
					float3 In_BitangentWS16_g241826 = BiangentWS421_g241818;
					half3 NormalWS427_g241818 = NormalWS95_g241818;
					half3 localComputeTriplanarWeights427_g241818 = ComputeTriplanarWeights( NormalWS427_g241818 );
					half3 TriplanarWeights429_g241818 = localComputeTriplanarWeights427_g241818;
					float3 In_TriplanarWeights16_g241826 = TriplanarWeights429_g241818;
					float3 In_ViewDirWS16_g241826 = ViewDirWS169_g241818;
					float4 In_CoordsData16_g241826 = CoordsData398_g241818;
					float4 In_VertexData16_g241826 = VertexMasks171_g241818;
					float4 In_PhaseData16_g241826 = Phase_Data176_g241818;
					BuildModelFragData( Data16_g241826 , In_Dummy16_g241826 , In_PositionWS16_g241826 , In_PositionWO16_g241826 , In_PivotWS16_g241826 , In_PivotWO16_g241826 , In_NormalWS16_g241826 , In_TangentWS16_g241826 , In_BitangentWS16_g241826 , In_TriplanarWeights16_g241826 , In_ViewDirWS16_g241826 , In_CoordsData16_g241826 , In_VertexData16_g241826 , In_PhaseData16_g241826 );
					TVEModelData DataTerrain26_g241817 = Data16_g241826;
					float Type26_g241817 = IsShaderType2637;
					{
					if (Type26_g241817 == 0 )
					{
					Data26_g241817 = DataDefault26_g241817;
					}
					else if (Type26_g241817 == 1 )
					{
					Data26_g241817 = DataGeneral26_g241817;
					}
					else if (Type26_g241817 == 2 )
					{
					Data26_g241817 = DataBlanket26_g241817;
					}
					else if (Type26_g241817 == 3 )
					{
					Data26_g241817 = DataImpostor26_g241817;
					}
					else if (Type26_g241817 == 4 )
					{
					Data26_g241817 = DataTerrain26_g241817;
					}
					}
					TVEModelData Data15_g241934 =(TVEModelData)Data26_g241817;
					float Out_Dummy15_g241934 = 0.0;
					float3 Out_PositionWS15_g241934 = float3( 0,0,0 );
					float3 Out_PositionWO15_g241934 = float3( 0,0,0 );
					float3 Out_PivotWS15_g241934 = float3( 0,0,0 );
					float3 Out_PivotWO15_g241934 = float3( 0,0,0 );
					float3 Out_NormalWS15_g241934 = float3( 0,0,0 );
					float3 Out_TangentWS15_g241934 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g241934 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g241934 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g241934 = float3( 0,0,0 );
					float4 Out_CoordsData15_g241934 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g241934 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g241934 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g241934 , Out_Dummy15_g241934 , Out_PositionWS15_g241934 , Out_PositionWO15_g241934 , Out_PivotWS15_g241934 , Out_PivotWO15_g241934 , Out_NormalWS15_g241934 , Out_TangentWS15_g241934 , Out_BitangentWS15_g241934 , Out_TriplanarWeights15_g241934 , Out_ViewDirWS15_g241934 , Out_CoordsData15_g241934 , Out_VertexData15_g241934 , Out_PhaseData15_g241934 );
					float3 Model_PositionWS497_g241858 = Out_PositionWS15_g241934;
					float2 Model_PositionWS_XZ143_g241858 = (Model_PositionWS497_g241858).xz;
					float3 Model_PivotWS498_g241858 = Out_PivotWS15_g241934;
					float2 Model_PivotWS_XZ145_g241858 = (Model_PivotWS498_g241858).xz;
					float2 lerpResult300_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g241878 = lerpResult300_g241858;
					float temp_output_82_0_g241876 = _GlobalCoatLayerValue;
					float temp_output_82_0_g241878 = temp_output_82_0_g241876;
					float4 tex2DArrayNode83_g241878 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241878).zw + ( (temp_output_203_0_g241878).xy * temp_output_81_0_g241878 ) ),temp_output_82_0_g241878), 0.0 );
					float4 appendResult210_g241878 = (float4(tex2DArrayNode83_g241878.rgb , saturate( tex2DArrayNode83_g241878.a )));
					float4 temp_output_204_0_g241878 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g241878 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241878).zw + ( (temp_output_204_0_g241878).xy * temp_output_81_0_g241878 ) ),temp_output_82_0_g241878), 0.0 );
					float4 appendResult212_g241878 = (float4(tex2DArrayNode122_g241878.rgb , saturate( tex2DArrayNode122_g241878.a )));
					float4 TVE_RenderNearPositionR628_g241858 = TVE_RenderNearPositionR;
					float temp_output_507_0_g241858 = saturate( ( distance( Model_PositionWS497_g241858 , (TVE_RenderNearPositionR628_g241858).xyz ) / (TVE_RenderNearPositionR628_g241858).w ) );
					float temp_output_7_0_g241859 = 1.0;
					float temp_output_9_0_g241859 = ( temp_output_507_0_g241858 - temp_output_7_0_g241859 );
					half TVE_RenderNearFadeValue635_g241858 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g241858 = saturate( ( temp_output_9_0_g241859 / ( ( TVE_RenderNearFadeValue635_g241858 - temp_output_7_0_g241859 ) + 0.0001 ) ) );
					float4 lerpResult131_g241878 = lerp( appendResult210_g241878 , appendResult212_g241878 , Global_TexBlend509_g241858);
					float4 temp_output_159_109_g241876 = lerpResult131_g241878;
					float4 lerpResult168_g241876 = lerp( TVE_CoatParams , temp_output_159_109_g241876 , TVE_CoatLayers[(int)temp_output_82_0_g241876]);
					float4 temp_output_589_109_g241858 = lerpResult168_g241876;
					half4 Coat_Texture302_g241858 = temp_output_589_109_g241858;
					float4 In_CoatTexture204_g241858 = Coat_Texture302_g241858;
					float4 temp_output_595_164_g241858 = TVE_PaintParams;
					half4 Paint_Params575_g241858 = temp_output_595_164_g241858;
					float4 In_PaintParams204_g241858 = Paint_Params575_g241858;
					float4 temp_output_203_0_g241927 = TVE_PaintBaseCoord;
					float2 lerpResult85_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g241927 = lerpResult85_g241858;
					float temp_output_82_0_g241924 = _GlobalPaintLayerValue;
					float temp_output_82_0_g241927 = temp_output_82_0_g241924;
					float4 tex2DArrayNode83_g241927 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241927).zw + ( (temp_output_203_0_g241927).xy * temp_output_81_0_g241927 ) ),temp_output_82_0_g241927), 0.0 );
					float4 appendResult210_g241927 = (float4(tex2DArrayNode83_g241927.rgb , saturate( tex2DArrayNode83_g241927.a )));
					float4 temp_output_204_0_g241927 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g241927 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241927).zw + ( (temp_output_204_0_g241927).xy * temp_output_81_0_g241927 ) ),temp_output_82_0_g241927), 0.0 );
					float4 appendResult212_g241927 = (float4(tex2DArrayNode122_g241927.rgb , saturate( tex2DArrayNode122_g241927.a )));
					float4 lerpResult131_g241927 = lerp( appendResult210_g241927 , appendResult212_g241927 , Global_TexBlend509_g241858);
					float4 temp_output_171_109_g241924 = lerpResult131_g241927;
					float4 lerpResult174_g241924 = lerp( TVE_PaintParams , temp_output_171_109_g241924 , TVE_PaintLayers[(int)temp_output_82_0_g241924]);
					float4 temp_output_595_109_g241858 = lerpResult174_g241924;
					half4 Paint_Texture71_g241858 = temp_output_595_109_g241858;
					float4 In_PaintTexture204_g241858 = Paint_Texture71_g241858;
					float4 temp_output_590_141_g241858 = TVE_AtmoParams;
					half4 Atmo_Params601_g241858 = temp_output_590_141_g241858;
					float4 In_AtmoParams204_g241858 = Atmo_Params601_g241858;
					float4 temp_output_203_0_g241886 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g241886 = lerpResult104_g241858;
					float temp_output_132_0_g241884 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g241886 = temp_output_132_0_g241884;
					float4 tex2DArrayNode83_g241886 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241886).zw + ( (temp_output_203_0_g241886).xy * temp_output_81_0_g241886 ) ),temp_output_82_0_g241886), 0.0 );
					float4 appendResult210_g241886 = (float4(tex2DArrayNode83_g241886.rgb , saturate( tex2DArrayNode83_g241886.a )));
					float4 temp_output_204_0_g241886 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g241886 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241886).zw + ( (temp_output_204_0_g241886).xy * temp_output_81_0_g241886 ) ),temp_output_82_0_g241886), 0.0 );
					float4 appendResult212_g241886 = (float4(tex2DArrayNode122_g241886.rgb , saturate( tex2DArrayNode122_g241886.a )));
					float4 lerpResult131_g241886 = lerp( appendResult210_g241886 , appendResult212_g241886 , Global_TexBlend509_g241858);
					float4 temp_output_137_109_g241884 = lerpResult131_g241886;
					float4 lerpResult145_g241884 = lerp( TVE_AtmoParams , temp_output_137_109_g241884 , TVE_AtmoLayers[(int)temp_output_132_0_g241884]);
					float4 temp_output_590_110_g241858 = lerpResult145_g241884;
					half4 Atmo_Texture80_g241858 = temp_output_590_110_g241858;
					float4 In_AtmoTexture204_g241858 = Atmo_Texture80_g241858;
					float4 temp_output_593_163_g241858 = TVE_GlowParams;
					half4 Glow_Params609_g241858 = temp_output_593_163_g241858;
					float4 In_GlowParams204_g241858 = Glow_Params609_g241858;
					float4 temp_output_203_0_g241902 = TVE_GlowBaseCoord;
					float2 lerpResult247_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g241902 = lerpResult247_g241858;
					float temp_output_82_0_g241900 = _GlobalGlowLayerValue;
					float temp_output_82_0_g241902 = temp_output_82_0_g241900;
					float4 tex2DArrayNode83_g241902 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241902).zw + ( (temp_output_203_0_g241902).xy * temp_output_81_0_g241902 ) ),temp_output_82_0_g241902), 0.0 );
					float4 appendResult210_g241902 = (float4(tex2DArrayNode83_g241902.rgb , saturate( tex2DArrayNode83_g241902.a )));
					float4 temp_output_204_0_g241902 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g241902 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241902).zw + ( (temp_output_204_0_g241902).xy * temp_output_81_0_g241902 ) ),temp_output_82_0_g241902), 0.0 );
					float4 appendResult212_g241902 = (float4(tex2DArrayNode122_g241902.rgb , saturate( tex2DArrayNode122_g241902.a )));
					float4 lerpResult131_g241902 = lerp( appendResult210_g241902 , appendResult212_g241902 , Global_TexBlend509_g241858);
					float4 temp_output_159_109_g241900 = lerpResult131_g241902;
					float4 lerpResult167_g241900 = lerp( TVE_GlowParams , temp_output_159_109_g241900 , TVE_GlowLayers[(int)temp_output_82_0_g241900]);
					float4 temp_output_593_109_g241858 = lerpResult167_g241900;
					half4 Glow_Texture248_g241858 = temp_output_593_109_g241858;
					float4 In_GlowTexture204_g241858 = Glow_Texture248_g241858;
					float4 temp_output_592_139_g241858 = TVE_FormParams;
					float4 Form_Params606_g241858 = temp_output_592_139_g241858;
					float4 In_FormParams204_g241858 = Form_Params606_g241858;
					float4 temp_output_203_0_g241918 = TVE_FormBaseCoord;
					float2 lerpResult168_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g241918 = lerpResult168_g241858;
					float temp_output_130_0_g241916 = _GlobalFormLayerValue;
					float temp_output_82_0_g241918 = temp_output_130_0_g241916;
					float4 tex2DArrayNode83_g241918 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241918).zw + ( (temp_output_203_0_g241918).xy * temp_output_81_0_g241918 ) ),temp_output_82_0_g241918), 0.0 );
					float4 appendResult210_g241918 = (float4(tex2DArrayNode83_g241918.rgb , saturate( tex2DArrayNode83_g241918.a )));
					float4 temp_output_204_0_g241918 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g241918 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241918).zw + ( (temp_output_204_0_g241918).xy * temp_output_81_0_g241918 ) ),temp_output_82_0_g241918), 0.0 );
					float4 appendResult212_g241918 = (float4(tex2DArrayNode122_g241918.rgb , saturate( tex2DArrayNode122_g241918.a )));
					float4 lerpResult131_g241918 = lerp( appendResult210_g241918 , appendResult212_g241918 , Global_TexBlend509_g241858);
					float4 temp_output_135_109_g241916 = lerpResult131_g241918;
					float4 lerpResult143_g241916 = lerp( TVE_FormParams , temp_output_135_109_g241916 , TVE_FormLayers[(int)temp_output_130_0_g241916]);
					float4 temp_output_592_0_g241858 = lerpResult143_g241916;
					float4 Form_Texture112_g241858 = temp_output_592_0_g241858;
					float4 In_FormTexture204_g241858 = Form_Texture112_g241858;
					float4 temp_output_594_145_g241858 = TVE_FlowParams;
					half4 Flow_Params612_g241858 = temp_output_594_145_g241858;
					float4 In_FlowParams204_g241858 = Flow_Params612_g241858;
					float4 temp_output_203_0_g241910 = TVE_FlowBaseCoord;
					float2 lerpResult400_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g241910 = lerpResult400_g241858;
					float temp_output_136_0_g241908 = _GlobalFlowLayerValue;
					float temp_output_82_0_g241910 = temp_output_136_0_g241908;
					float4 tex2DArrayNode83_g241910 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241910).zw + ( (temp_output_203_0_g241910).xy * temp_output_81_0_g241910 ) ),temp_output_82_0_g241910), 0.0 );
					float4 appendResult210_g241910 = (float4(tex2DArrayNode83_g241910.rgb , saturate( tex2DArrayNode83_g241910.a )));
					float4 temp_output_204_0_g241910 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g241910 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241910).zw + ( (temp_output_204_0_g241910).xy * temp_output_81_0_g241910 ) ),temp_output_82_0_g241910), 0.0 );
					float4 appendResult212_g241910 = (float4(tex2DArrayNode122_g241910.rgb , saturate( tex2DArrayNode122_g241910.a )));
					float4 lerpResult131_g241910 = lerp( appendResult210_g241910 , appendResult212_g241910 , Global_TexBlend509_g241858);
					float4 temp_output_141_109_g241908 = lerpResult131_g241910;
					float4 lerpResult149_g241908 = lerp( TVE_FlowParams , temp_output_141_109_g241908 , TVE_FlowLayers[(int)temp_output_136_0_g241908]);
					half4 Flow_Texture405_g241858 = lerpResult149_g241908;
					float4 In_FlowTexture204_g241858 = Flow_Texture405_g241858;
					BuildGlobalData( Data204_g241858 , In_Dummy204_g241858 , In_CoatParams204_g241858 , In_CoatTexture204_g241858 , In_PaintParams204_g241858 , In_PaintTexture204_g241858 , In_AtmoParams204_g241858 , In_AtmoTexture204_g241858 , In_GlowParams204_g241858 , In_GlowTexture204_g241858 , In_FormParams204_g241858 , In_FormTexture204_g241858 , In_FlowParams204_g241858 , In_FlowTexture204_g241858 );
					TVEGlobalData Data15_g251368 =(TVEGlobalData)Data204_g241858;
					float Out_Dummy15_g251368 = 0.0;
					float4 Out_CoatParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251368 = float4( 0,0,0,0 );
					BreakData( Data15_g251368 , Out_Dummy15_g251368 , Out_CoatParams15_g251368 , Out_CoatTexture15_g251368 , Out_PaintParams15_g251368 , Out_PaintTexture15_g251368 , Out_AtmoParams15_g251368 , Out_AtmoTexture15_g251368 , Out_GlowParams15_g251368 , Out_GlowTexture15_g251368 , Out_FormParams15_g251368 , Out_FormTexture15_g251368 , Out_FlowParams15_g251368 , Out_FlowTexture15_g251368 );
					float4 Global_FormTexture351_g251365 = Out_FormTexture15_g251368;
					float3 Model_PivotWO353_g251365 = temp_output_314_19_g251365;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251374 = _ConformMeshMode;
					float Option70_g251374 = temp_output_17_0_g251374;
					half4 Model_VertexData357_g251365 = temp_output_314_29_g251365;
					float4 temp_output_3_0_g251374 = Model_VertexData357_g251365;
					float4 Channel70_g251374 = temp_output_3_0_g251374;
					float localSwitchChannel470_g251374 = SwitchChannel4( Option70_g251374 , Channel70_g251374 );
					float temp_output_390_0_g251365 = localSwitchChannel470_g251374;
					float temp_output_7_0_g251371 = _ConformMeshRemap.x;
					float temp_output_9_0_g251371 = ( temp_output_390_0_g251365 - temp_output_7_0_g251371 );
					float lerpResult374_g251365 = lerp( 1.0 , saturate( ( temp_output_9_0_g251371 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251365 = lerpResult374_g251365;
					float temp_output_328_0_g251365 = ( Blend_VertMask379_g251365 * TVE_IsEnabled );
					half Conform_Mask366_g251365 = temp_output_328_0_g251365;
					float temp_output_322_0_g251365 = ( ( ( ( (Global_FormTexture351_g251365).z - ( (Model_PivotWO353_g251365).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251365 ) );
					float3 appendResult329_g251365 = (float3(0.0 , temp_output_322_0_g251365 , 0.0));
					float3 appendResult387_g251365 = (float3(0.0 , 0.0 , temp_output_322_0_g251365));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251372 = appendResult387_g251365;
					#else
					float3 staticSwitch65_g251372 = appendResult329_g251365;
					#endif
					float3 Blanket_Conform368_g251365 = staticSwitch65_g251372;
					float4 appendResult312_g251365 = (float4(Blanket_Conform368_g251365 , 0.0));
					float4 temp_output_310_0_g251365 = ( Model_TransformData356_g251365 + appendResult312_g251365 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251365 = temp_output_310_0_g251365;
					#else
					float4 staticSwitch364_g251365 = Model_TransformData356_g251365;
					#endif
					half4 Final_TransformData365_g251365 = staticSwitch364_g251365;
					float4 In_TransformData16_g251367 = Final_TransformData365_g251365;
					float4 In_RotationData16_g251367 = Out_RotationData15_g251366;
					float4 In_InterpolatorA16_g251367 = Out_InterpolatorA15_g251366;
					BuildModelVertData( Data16_g251367 , In_Dummy16_g251367 , In_PositionOS16_g251367 , In_PositionWS16_g251367 , In_PositionWO16_g251367 , In_PositionRawOS16_g251367 , In_PivotOS16_g251367 , In_PivotWS16_g251367 , In_PivotWO16_g251367 , In_NormalOS16_g251367 , In_NormalWS16_g251367 , In_NormalRawOS16_g251367 , In_TangentOS16_g251367 , In_TangentWS16_g251367 , In_BitangentWS16_g251367 , In_ViewDirWS16_g251367 , In_CoordsData16_g251367 , In_VertexData16_g251367 , In_MasksData16_g251367 , In_PhaseData16_g251367 , In_TransformData16_g251367 , In_RotationData16_g251367 , In_InterpolatorA16_g251367 );
					TVEModelData Data15_g251424 =(TVEModelData)Data16_g251367;
					float Out_Dummy15_g251424 = 0.0;
					float3 Out_PositionOS15_g251424 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251424 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251424 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251424 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251424 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251424 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251424 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251424 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251424 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251424 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251424 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251424 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251424 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251424 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251424 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251424 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251424 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251424 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251424 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251424 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251424 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251424 , Out_Dummy15_g251424 , Out_PositionOS15_g251424 , Out_PositionWS15_g251424 , Out_PositionWO15_g251424 , Out_PositionRawOS15_g251424 , Out_PivotOS15_g251424 , Out_PivotWS15_g251424 , Out_PivotWO15_g251424 , Out_NormalOS15_g251424 , Out_NormalWS15_g251424 , Out_NormalRawOS15_g251424 , Out_TangentOS15_g251424 , Out_TangentWS15_g251424 , Out_BitangentWS15_g251424 , Out_ViewDirWS15_g251424 , Out_CoordsData15_g251424 , Out_VertexData15_g251424 , Out_MasksData15_g251424 , Out_PhaseData15_g251424 , Out_TransformData15_g251424 , Out_RotationData15_g251424 , Out_InterpolatorA15_g251424 );
					TVEModelData Data16_g251423 =(TVEModelData)Data15_g251424;
					half Dummy181_g251422 = ( ( _MotionCategory + _MotionEnd ) + _MotionPushInfo );
					float temp_output_14_0_g251423 = Dummy181_g251422;
					float In_Dummy16_g251423 = temp_output_14_0_g251423;
					float3 temp_output_2772_0_g251422 = Out_PositionOS15_g251424;
					float3 temp_output_4_0_g251423 = temp_output_2772_0_g251422;
					float3 In_PositionOS16_g251423 = temp_output_4_0_g251423;
					float3 temp_output_2772_16_g251422 = Out_PositionWS15_g251424;
					float3 In_PositionWS16_g251423 = temp_output_2772_16_g251422;
					float3 temp_output_2772_17_g251422 = Out_PositionWO15_g251424;
					float3 In_PositionWO16_g251423 = temp_output_2772_17_g251422;
					float3 In_PositionRawOS16_g251423 = Out_PositionRawOS15_g251424;
					float3 temp_output_2772_24_g251422 = Out_PivotOS15_g251424;
					float3 In_PivotOS16_g251423 = temp_output_2772_24_g251422;
					float3 In_PivotWS16_g251423 = Out_PivotWS15_g251424;
					float3 temp_output_2772_19_g251422 = Out_PivotWO15_g251424;
					float3 In_PivotWO16_g251423 = temp_output_2772_19_g251422;
					float3 temp_output_2772_20_g251422 = Out_NormalOS15_g251424;
					float3 temp_output_21_0_g251423 = temp_output_2772_20_g251422;
					float3 In_NormalOS16_g251423 = temp_output_21_0_g251423;
					float3 In_NormalWS16_g251423 = Out_NormalWS15_g251424;
					float3 In_NormalRawOS16_g251423 = Out_NormalRawOS15_g251424;
					float4 temp_output_6_0_g251423 = Out_TangentOS15_g251424;
					float4 In_TangentOS16_g251423 = temp_output_6_0_g251423;
					float3 In_TangentWS16_g251423 = Out_TangentWS15_g251424;
					float3 In_BitangentWS16_g251423 = Out_BitangentWS15_g251424;
					float3 In_ViewDirWS16_g251423 = Out_ViewDirWS15_g251424;
					float4 In_CoordsData16_g251423 = Out_CoordsData15_g251424;
					float4 temp_output_2772_29_g251422 = Out_VertexData15_g251424;
					float4 In_VertexData16_g251423 = temp_output_2772_29_g251422;
					float4 temp_output_2772_30_g251422 = Out_MasksData15_g251424;
					float4 In_MasksData16_g251423 = temp_output_2772_30_g251422;
					float4 temp_output_2772_27_g251422 = Out_PhaseData15_g251424;
					float4 In_PhaseData16_g251423 = temp_output_2772_27_g251422;
					half4 Model_TransformData2743_g251422 = Out_TransformData15_g251424;
					float3 temp_cast_11 = (0.0).xxx;
					float2 lerpResult3113_g251422 = lerp( (half4( 0, 1, 0.5, 1 )).xy , (TVE_WindParams).xy , TVE_IsEnabled);
					float2 Global_WindDirWS2542_g251422 = lerpResult3113_g251422;
					half2 Input_WindDirWS803_g251473 = Global_WindDirWS2542_g251422;
					float3 Model_PositionWO162_g251422 = temp_output_2772_17_g251422;
					half3 Input_ModelPositionWO761_g251426 = Model_PositionWO162_g251422;
					float3 Model_PivotWO402_g251422 = temp_output_2772_19_g251422;
					half3 Input_ModelPivotsWO419_g251426 = Model_PivotWO402_g251422;
					half Input_MotionPivots629_g251426 = _MotionSmallPivotValue;
					float3 lerpResult771_g251426 = lerp( Input_ModelPositionWO761_g251426 , Input_ModelPivotsWO419_g251426 , Input_MotionPivots629_g251426);
					half4 Model_PhaseData489_g251422 = temp_output_2772_27_g251422;
					half4 Input_ModelMotionData763_g251426 = Model_PhaseData489_g251422;
					half Input_MotionPhase764_g251426 = _MotionSmallPhaseValue;
					float temp_output_770_0_g251426 = ( (Input_ModelMotionData763_g251426).x * Input_MotionPhase764_g251426 );
					half3 Small_Position1421_g251422 = ( lerpResult771_g251426 + temp_output_770_0_g251426 );
					half3 Input_PositionWO419_g251473 = Small_Position1421_g251422;
					half Input_MotionTilling321_g251473 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g251473 = ( -(Input_PositionWO419_g251473).xz * Input_MotionTilling321_g251473 * 0.005 );
					float2 temp_output_3_0_g251474 = Noise_Coord979_g251473;
					float2 temp_output_21_0_g251474 = Input_WindDirWS803_g251473;
					float mulTime113_g251477 = _Time.y * 0.02;
					float lerpResult128_g251477 = lerp( mulTime113_g251477 , ( ( mulTime113_g251477 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g251473 = _MotionSmallSpeedValue;
					half Noise_Speed980_g251473 = ( lerpResult128_g251477 * Input_MotionSpeed62_g251473 );
					float temp_output_15_0_g251474 = Noise_Speed980_g251473;
					float temp_output_23_0_g251474 = frac( temp_output_15_0_g251474 );
					float4 lerpResult39_g251474 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g251474 + ( temp_output_21_0_g251474 * temp_output_23_0_g251474 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g251474 + ( temp_output_21_0_g251474 * frac( ( temp_output_15_0_g251474 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g251474 - 0.5 ) ) / 0.5 ));
					float4 temp_output_991_0_g251473 = lerpResult39_g251474;
					half2 Noise_DirWS858_g251473 = ((temp_output_991_0_g251473).rg*2.0 + -1.0);
					half Input_MotionNoise552_g251473 = _MotionSmallNoiseValue;
					TVEGlobalData Data15_g251436 =(TVEGlobalData)Data204_g241858;
					float Out_Dummy15_g251436 = 0.0;
					float4 Out_CoatParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251436 = float4( 0,0,0,0 );
					BreakData( Data15_g251436 , Out_Dummy15_g251436 , Out_CoatParams15_g251436 , Out_CoatTexture15_g251436 , Out_PaintParams15_g251436 , Out_PaintTexture15_g251436 , Out_AtmoParams15_g251436 , Out_AtmoTexture15_g251436 , Out_GlowParams15_g251436 , Out_GlowTexture15_g251436 , Out_FormParams15_g251436 , Out_FormTexture15_g251436 , Out_FlowParams15_g251436 , Out_FlowTexture15_g251436 );
					half4 Global_FlowParams3052_g251422 = Out_FlowParams15_g251436;
					half4 Global_FlowTexture2668_g251422 = Out_FlowTexture15_g251436;
					#ifdef TVE_MOTION_ELEMENT
					float4 staticSwitch3075_g251422 = Global_FlowTexture2668_g251422;
					#else
					float4 staticSwitch3075_g251422 = Global_FlowParams3052_g251422;
					#endif
					float4 temp_output_6_0_g251438 = staticSwitch3075_g251422;
					float temp_output_7_0_g251438 = _MotionElementMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251438 = ( temp_output_6_0_g251438 + temp_output_7_0_g251438 );
					#else
					float4 staticSwitch14_g251438 = temp_output_6_0_g251438;
					#endif
					float4 lerpResult3121_g251422 = lerp( half4( 0, 0, 0, 1 ) , staticSwitch14_g251438 , TVE_IsEnabled);
					float temp_output_630_0_g251451 = saturate( (lerpResult3121_g251422).w );
					float lerpResult853_g251451 = lerp( temp_output_630_0_g251451 , saturate( (temp_output_630_0_g251451*TVE_WindEditor.x + TVE_WindEditor.y) ) , TVE_WindEditor.w);
					half Global_WindValue1855_g251422 = ( lerpResult853_g251451 * _MotionIntensityValue );
					half Input_WindValue881_g251473 = Global_WindValue1855_g251422;
					float temp_output_6_0_g251479 = Input_WindValue881_g251473;
					float lerpResult701_g251473 = lerp( 1.0 , Input_MotionNoise552_g251473 , ( temp_output_6_0_g251479 * temp_output_6_0_g251479 ));
					float2 lerpResult646_g251473 = lerp( Input_WindDirWS803_g251473 , Noise_DirWS858_g251473 , lerpResult701_g251473);
					half2 Small_DirWS817_g251473 = lerpResult646_g251473;
					float2 break823_g251473 = Small_DirWS817_g251473;
					half4 Noise_Params685_g251473 = temp_output_991_0_g251473;
					half Wind_Sinus820_g251473 = ( ((Noise_Params685_g251473).b*2.0 + -1.0) * 0.6 );
					float3 appendResult824_g251473 = (float3(break823_g251473.x , Wind_Sinus820_g251473 , break823_g251473.y));
					half3 Small_Dir918_g251473 = appendResult824_g251473;
					float temp_output_20_0_g251478 = ( 1.0 - Input_WindValue881_g251473 );
					float3 appendResult1006_g251473 = (float3(Input_WindValue881_g251473 , ( 1.0 - ( temp_output_20_0_g251478 * temp_output_20_0_g251478 ) ) , Input_WindValue881_g251473));
					half Input_MotionDelay753_g251473 = _MotionSmallDelayValue;
					float lerpResult756_g251473 = lerp( 1.0 , ( Input_WindValue881_g251473 * Input_WindValue881_g251473 ) , Input_MotionDelay753_g251473);
					half Wind_Delay815_g251473 = lerpResult756_g251473;
					half Input_MotionValue905_g251473 = _MotionSmallIntensityValue;
					float3 temp_output_883_0_g251473 = ( Small_Dir918_g251473 * appendResult1006_g251473 * Wind_Delay815_g251473 * Input_MotionValue905_g251473 );
					float2 break857_g251473 = Noise_DirWS858_g251473;
					float3 appendResult833_g251473 = (float3(break857_g251473.x , Wind_Sinus820_g251473 , break857_g251473.y));
					half3 Push_Dir919_g251473 = appendResult833_g251473;
					half Input_MotionReact924_g251473 = _MotionSmallPushValue;
					float2 temp_output_3126_0_g251422 = ((lerpResult3121_g251422).xy*2.0 + -1.0);
					half Global_PushAlpha1504_g251422 = length( temp_output_3126_0_g251422 );
					half Input_PushAlpha806_g251473 = Global_PushAlpha1504_g251422;
					half Global_PushNoise2675_g251422 = (lerpResult3121_g251422).z;
					half Input_PushNoise890_g251473 = Global_PushNoise2675_g251422;
					half Push_Mask914_g251473 = saturate( ( Input_PushAlpha806_g251473 * Input_PushNoise890_g251473 * Input_MotionReact924_g251473 ) );
					float3 lerpResult840_g251473 = lerp( temp_output_883_0_g251473 , ( Push_Dir919_g251473 * Input_MotionReact924_g251473 ) , Push_Mask914_g251473);
					#ifdef TVE_MOTION_ELEMENT
					float3 staticSwitch829_g251473 = lerpResult840_g251473;
					#else
					float3 staticSwitch829_g251473 = temp_output_883_0_g251473;
					#endif
					float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
					half3 Small_Squash1489_g251422 = ( mul( unity_WorldToObject, float4( staticSwitch829_g251473 , 0.0 ) ).xyz * ase_parentObjectScale );
					float temp_output_17_0_g251461 = _MotionSmallMaskMode;
					float Option83_g251461 = temp_output_17_0_g251461;
					half4 Model_VertexMasks518_g251422 = temp_output_2772_29_g251422;
					float4 ChannelA83_g251461 = Model_VertexMasks518_g251422;
					half4 Model_MasksData1322_g251422 = temp_output_2772_30_g251422;
					float2 uv_MotionMaskTex2818_g251422 = v.texcoord.xyzw.xy;
					half4 Motion_MaskTex2819_g251422 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g251422, 0.0 );
					float4 appendResult3227_g251422 = (float4((Model_MasksData1322_g251422).xy , (Motion_MaskTex2819_g251422).g , 0.0));
					float4 ChannelB83_g251461 = appendResult3227_g251422;
					float localSwitchChannel883_g251461 = SwitchChannel8( Option83_g251461 , ChannelA83_g251461 , ChannelB83_g251461 );
					float enc1805_g251422 = v.texcoord.xyzw.z;
					float2 localDecodeFloatToVector21805_g251422 = DecodeFloatToVector2( enc1805_g251422 );
					float2 break1804_g251422 = localDecodeFloatToVector21805_g251422;
					half Small_Mask_Legacy1806_g251422 = break1804_g251422.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g251422 = Small_Mask_Legacy1806_g251422;
					#else
					float staticSwitch1800_g251422 = localSwitchChannel883_g251461;
					#endif
					float clampResult17_g251427 = clamp( staticSwitch1800_g251422 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251428 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g251428 = ( clampResult17_g251427 - temp_output_7_0_g251428 );
					half Small_Mask640_g251422 = saturate( ( temp_output_9_0_g251428 * _MotionSmallMaskRemap.z ) );
					float3 lerpResult3022_g251422 = lerp( float3( 1,1,1 ) , (TVE_MotionValueParams).xyz , TVE_MotionValueParams.w);
					half3 Global_MotionParams3013_g251422 = lerpResult3022_g251422;
					half3 Small_Motion789_g251422 = ( Small_Squash1489_g251422 * Small_Mask640_g251422 * (Global_MotionParams3013_g251422).y );
					#ifdef TVE_MOTION
					float3 staticSwitch495_g251422 = Small_Motion789_g251422;
					#else
					float3 staticSwitch495_g251422 = temp_cast_11;
					#endif
					float3 temp_cast_14 = (0.0).xxx;
					float3 Model_PositionWS1819_g251422 = temp_output_2772_16_g251422;
					half Global_DistMask1820_g251422 = ( 1.0 - saturate( ( distance( _WorldSpaceCameraPos , Model_PositionWS1819_g251422 ) / _MotionDistValue ) ) );
					float temp_output_17_0_g251462 = _MotionTinyMaskMode;
					float Option83_g251462 = temp_output_17_0_g251462;
					float4 ChannelA83_g251462 = Model_VertexMasks518_g251422;
					float4 appendResult3234_g251422 = (float4((Model_MasksData1322_g251422).xy , (Motion_MaskTex2819_g251422).b , 0.0));
					float4 ChannelB83_g251462 = appendResult3234_g251422;
					float localSwitchChannel883_g251462 = SwitchChannel8( Option83_g251462 , ChannelA83_g251462 , ChannelB83_g251462 );
					half Tiny_Mask_Legacy1807_g251422 = break1804_g251422.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g251422 = Tiny_Mask_Legacy1807_g251422;
					#else
					float staticSwitch1810_g251422 = localSwitchChannel883_g251462;
					#endif
					float clampResult17_g251429 = clamp( staticSwitch1810_g251422 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251430 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g251430 = ( clampResult17_g251429 - temp_output_7_0_g251430 );
					half Tiny_Mask218_g251422 = saturate( ( temp_output_9_0_g251430 * _MotionTinyMaskRemap.z ) );
					half3 Model_NormalOS554_g251422 = temp_output_2772_20_g251422;
					half3 Input_NormalOS533_g251444 = Model_NormalOS554_g251422;
					half3 Tiny_Position2469_g251422 = Model_PositionWO162_g251422;
					half3 Input_PositionWO500_g251444 = Tiny_Position2469_g251422;
					half Input_MotionTilling321_g251444 = ( _MotionTinyTillingValue + 0.1 );
					float lerpResult128_g251449 = lerp( _Time.y , ( ( _Time.y * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g251444 = _MotionTinySpeedValue;
					float4 tex2DNode514_g251444 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( ( (Input_PositionWO500_g251444).xz * Input_MotionTilling321_g251444 * 0.005 ) + ( lerpResult128_g251449 * Input_MotionSpeed62_g251444 * 0.02 ) ), 0.0 );
					half3 Flutter_Noise535_g251444 = (tex2DNode514_g251444.rgb*2.0 + -1.0);
					half Input_MotionNoise542_g251444 = _MotionTinyNoiseValue;
					float3 lerpResult537_g251444 = lerp( ( Input_NormalOS533_g251444 * Flutter_Noise535_g251444 ) , Flutter_Noise535_g251444 , Input_MotionNoise542_g251444);
					float mulTime113_g251450 = _Time.y * 2.0;
					float lerpResult128_g251450 = lerp( mulTime113_g251450 , ( ( mulTime113_g251450 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					float temp_output_578_0_g251444 = SAMPLE_TEXTURE3D_LOD( _NoiseTex3D, sampler_Linear_Repeat, ( ( Input_PositionWO500_g251444 + lerpResult128_g251450 ) * ( 1.0 * 0.01 ) ), 0.0 ).r;
					half Input_GlobalWind471_g251444 = Global_WindValue1855_g251422;
					float lerpResult579_g251444 = lerp( ( temp_output_578_0_g251444 * temp_output_578_0_g251444 * temp_output_578_0_g251444 * temp_output_578_0_g251444 ) , temp_output_578_0_g251444 , ( Input_GlobalWind471_g251444 * Input_GlobalWind471_g251444 ));
					float temp_output_20_0_g251448 = ( 1.0 - Input_GlobalWind471_g251444 );
					half Wind_Gust589_g251444 = ( ( lerpResult579_g251444 * ( 1.0 - ( temp_output_20_0_g251448 * temp_output_20_0_g251448 * temp_output_20_0_g251448 * temp_output_20_0_g251448 ) ) ) * 0.5 );
					half3 Tiny_Squash859_g251422 = ( lerpResult537_g251444 * Wind_Gust589_g251444 );
					half3 Tiny_Flutter1451_g251422 = ( _MotionTinyIntensityValue * Global_DistMask1820_g251422 * Tiny_Mask218_g251422 * Tiny_Squash859_g251422 * (Global_MotionParams3013_g251422).z );
					#ifdef TVE_MOTION
					float3 staticSwitch414_g251422 = Tiny_Flutter1451_g251422;
					#else
					float3 staticSwitch414_g251422 = temp_cast_14;
					#endif
					float4 appendResult2783_g251422 = (float4(( staticSwitch495_g251422 + staticSwitch414_g251422 ) , 0.0));
					half4 Final_TransformData1569_g251422 = ( Model_TransformData2743_g251422 + appendResult2783_g251422 );
					float4 In_TransformData16_g251423 = Final_TransformData1569_g251422;
					half4 Model_RotationData2740_g251422 = Out_RotationData15_g251424;
					half2 Input_WindDirWS803_g251463 = Global_WindDirWS2542_g251422;
					half3 Input_ModelPositionWO761_g251425 = Model_PositionWO162_g251422;
					half3 Input_ModelPivotsWO419_g251425 = Model_PivotWO402_g251422;
					half Input_MotionPivots629_g251425 = _MotionBasePivotValue;
					float3 lerpResult771_g251425 = lerp( Input_ModelPositionWO761_g251425 , Input_ModelPivotsWO419_g251425 , Input_MotionPivots629_g251425);
					half4 Input_ModelMotionData763_g251425 = Model_PhaseData489_g251422;
					half Input_MotionPhase764_g251425 = _MotionBasePhaseValue;
					float temp_output_770_0_g251425 = ( (Input_ModelMotionData763_g251425).x * Input_MotionPhase764_g251425 );
					half3 Base_Position1394_g251422 = ( lerpResult771_g251425 + temp_output_770_0_g251425 );
					half3 Input_PositionWO419_g251463 = Base_Position1394_g251422;
					half Input_MotionTilling321_g251463 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g251463 = ( -(Input_PositionWO419_g251463).xz * Input_MotionTilling321_g251463 * 0.005 );
					float2 temp_output_3_0_g251470 = Noise_Coord515_g251463;
					float2 temp_output_21_0_g251470 = Input_WindDirWS803_g251463;
					float mulTime113_g251464 = _Time.y * 0.02;
					float lerpResult128_g251464 = lerp( mulTime113_g251464 , ( ( mulTime113_g251464 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g251463 = _MotionBaseSpeedValue;
					half Noise_Speed516_g251463 = ( lerpResult128_g251464 * Input_MotionSpeed62_g251463 );
					float temp_output_15_0_g251470 = Noise_Speed516_g251463;
					float temp_output_23_0_g251470 = frac( temp_output_15_0_g251470 );
					float4 lerpResult39_g251470 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g251470 + ( temp_output_21_0_g251470 * temp_output_23_0_g251470 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g251470 + ( temp_output_21_0_g251470 * frac( ( temp_output_15_0_g251470 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g251470 - 0.5 ) ) / 0.5 ));
					float4 temp_output_635_0_g251463 = lerpResult39_g251470;
					half2 Noise_DirWS825_g251463 = ((temp_output_635_0_g251463).rg*2.0 + -1.0);
					half Input_MotionNoise552_g251463 = _MotionBaseNoiseValue;
					half Input_WindValue853_g251463 = Global_WindValue1855_g251422;
					float temp_output_6_0_g251467 = Input_WindValue853_g251463;
					float lerpResult701_g251463 = lerp( 1.0 , Input_MotionNoise552_g251463 , ( temp_output_6_0_g251467 * temp_output_6_0_g251467 ));
					half Input_PushNoise858_g251463 = Global_PushNoise2675_g251422;
					float2 lerpResult646_g251463 = lerp( Input_WindDirWS803_g251463 , Noise_DirWS825_g251463 , saturate( ( lerpResult701_g251463 + Input_PushNoise858_g251463 ) ));
					half2 Bend_Dir859_g251463 = lerpResult646_g251463;
					half Input_MotionValue871_g251463 = _MotionBaseIntensityValue;
					half Input_MotionDelay753_g251463 = _MotionBaseDelayValue;
					float lerpResult756_g251463 = lerp( 1.0 , ( Input_WindValue853_g251463 * Input_WindValue853_g251463 ) , Input_MotionDelay753_g251463);
					half Wind_Delay815_g251463 = lerpResult756_g251463;
					float2 temp_output_875_0_g251463 = ( Bend_Dir859_g251463 * Input_WindValue853_g251463 * Input_MotionValue871_g251463 * Wind_Delay815_g251463 );
					float2 Global_PushDirWS1972_g251422 = temp_output_3126_0_g251422;
					half2 Input_PushDirWS807_g251463 = Global_PushDirWS1972_g251422;
					half Input_ReactValue888_g251463 = _MotionBasePushValue;
					half Input_PushAlpha806_g251463 = Global_PushAlpha1504_g251422;
					half Push_Mask883_g251463 = saturate( ( Input_PushAlpha806_g251463 * Input_ReactValue888_g251463 ) );
					float2 lerpResult811_g251463 = lerp( temp_output_875_0_g251463 , ( Input_PushDirWS807_g251463 * Input_ReactValue888_g251463 ) , Push_Mask883_g251463);
					#ifdef TVE_MOTION_ELEMENT
					float2 staticSwitch808_g251463 = lerpResult811_g251463;
					#else
					float2 staticSwitch808_g251463 = temp_output_875_0_g251463;
					#endif
					float2 temp_output_38_0_g251468 = staticSwitch808_g251463;
					float2 break83_g251468 = temp_output_38_0_g251468;
					float3 appendResult79_g251468 = (float3(break83_g251468.x , 0.0 , break83_g251468.y));
					half2 Base_Bending893_g251422 = (( mul( unity_WorldToObject, float4( appendResult79_g251468 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
					float temp_output_17_0_g251460 = _MotionBaseMaskMode;
					float Option83_g251460 = temp_output_17_0_g251460;
					float4 ChannelA83_g251460 = Model_VertexMasks518_g251422;
					float4 appendResult3220_g251422 = (float4((Model_MasksData1322_g251422).xy , (Motion_MaskTex2819_g251422).r , 0.0));
					float4 ChannelB83_g251460 = appendResult3220_g251422;
					float localSwitchChannel883_g251460 = SwitchChannel8( Option83_g251460 , ChannelA83_g251460 , ChannelB83_g251460 );
					float clampResult17_g251432 = clamp( localSwitchChannel883_g251460 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251431 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g251431 = ( clampResult17_g251432 - temp_output_7_0_g251431 );
					half Base_Mask217_g251422 = saturate( ( temp_output_9_0_g251431 * _MotionBaseMaskRemap.z ) );
					half2 Base_Motion1440_g251422 = ( Base_Bending893_g251422 * Base_Mask217_g251422 * (Global_MotionParams3013_g251422).x );
					#ifdef TVE_MOTION
					float2 staticSwitch2384_g251422 = Base_Motion1440_g251422;
					#else
					float2 staticSwitch2384_g251422 = float2( 0,0 );
					#endif
					float4 appendResult2023_g251422 = (float4(staticSwitch2384_g251422 , 0.0 , 0.0));
					half4 Final_RotationData1570_g251422 = ( Model_RotationData2740_g251422 + appendResult2023_g251422 );
					float4 In_RotationData16_g251423 = Final_RotationData1570_g251422;
					half4 Model_Interpolator02773_g251422 = Out_InterpolatorA15_g251424;
					half4 Noise_Params685_g251463 = temp_output_635_0_g251463;
					float temp_output_6_0_g251466 = (Noise_Params685_g251463).a;
					float temp_output_913_0_g251463 = ( ( temp_output_6_0_g251466 * temp_output_6_0_g251466 * temp_output_6_0_g251466 * temp_output_6_0_g251466 ) * ( Input_WindValue853_g251463 * Wind_Delay815_g251463 ) );
					float temp_output_6_0_g251465 = length( Input_PushDirWS807_g251463 );
					float lerpResult902_g251463 = lerp( temp_output_913_0_g251463 , ( ( temp_output_6_0_g251465 * temp_output_6_0_g251465 ) * Input_PushNoise858_g251463 ) , Push_Mask883_g251463);
					#ifdef TVE_MOTION_ELEMENT
					float staticSwitch903_g251463 = lerpResult902_g251463;
					#else
					float staticSwitch903_g251463 = temp_output_913_0_g251463;
					#endif
					half Base_Wave1159_g251422 = staticSwitch903_g251463;
					float temp_output_6_0_g251480 = (Noise_Params685_g251473).a;
					float temp_output_955_0_g251473 = ( temp_output_6_0_g251480 * temp_output_6_0_g251480 * temp_output_6_0_g251480 * temp_output_6_0_g251480 );
					float temp_output_944_0_g251473 = ( temp_output_955_0_g251473 * ( Input_WindValue881_g251473 * Wind_Delay815_g251473 ) );
					float lerpResult936_g251473 = lerp( temp_output_944_0_g251473 , ( temp_output_955_0_g251473 * Input_PushNoise890_g251473 ) , Push_Mask914_g251473);
					#ifdef TVE_MOTION_ELEMENT
					float staticSwitch939_g251473 = lerpResult936_g251473;
					#else
					float staticSwitch939_g251473 = temp_output_944_0_g251473;
					#endif
					half Small_Wave1427_g251422 = staticSwitch939_g251473;
					float lerpResult2422_g251422 = lerp( Base_Wave1159_g251422 , Small_Wave1427_g251422 , _motion_small_mode);
					half Global_Wave1475_g251422 = saturate( lerpResult2422_g251422 );
					float temp_output_6_0_g251433 = ( _MotionHighlightValue * Global_DistMask1820_g251422 * ( Tiny_Mask218_g251422 * Tiny_Mask218_g251422 ) * Global_Wave1475_g251422 );
					float temp_output_7_0_g251433 = _MotionHighlightColor.r;
					#ifdef TVE_DUMMY
					float staticSwitch14_g251433 = ( temp_output_6_0_g251433 + temp_output_7_0_g251433 );
					#else
					float staticSwitch14_g251433 = temp_output_6_0_g251433;
					#endif
					#ifdef TVE_MOTION
					float staticSwitch2866_g251422 = staticSwitch14_g251433;
					#else
					float staticSwitch2866_g251422 = 0.0;
					#endif
					float4 appendResult2775_g251422 = (float4((Model_Interpolator02773_g251422).xyz , staticSwitch2866_g251422));
					half4 Final_Interpolator02774_g251422 = appendResult2775_g251422;
					float4 In_InterpolatorA16_g251423 = Final_Interpolator02774_g251422;
					BuildModelVertData( Data16_g251423 , In_Dummy16_g251423 , In_PositionOS16_g251423 , In_PositionWS16_g251423 , In_PositionWO16_g251423 , In_PositionRawOS16_g251423 , In_PivotOS16_g251423 , In_PivotWS16_g251423 , In_PivotWO16_g251423 , In_NormalOS16_g251423 , In_NormalWS16_g251423 , In_NormalRawOS16_g251423 , In_TangentOS16_g251423 , In_TangentWS16_g251423 , In_BitangentWS16_g251423 , In_ViewDirWS16_g251423 , In_CoordsData16_g251423 , In_VertexData16_g251423 , In_MasksData16_g251423 , In_PhaseData16_g251423 , In_TransformData16_g251423 , In_RotationData16_g251423 , In_InterpolatorA16_g251423 );
					TVEModelData Data15_g251482 =(TVEModelData)Data16_g251423;
					float Out_Dummy15_g251482 = 0.0;
					float3 Out_PositionOS15_g251482 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251482 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251482 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251482 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251482 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251482 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251482 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251482 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251482 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251482 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251482 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251482 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251482 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251482 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251482 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251482 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251482 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251482 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251482 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251482 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251482 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251482 , Out_Dummy15_g251482 , Out_PositionOS15_g251482 , Out_PositionWS15_g251482 , Out_PositionWO15_g251482 , Out_PositionRawOS15_g251482 , Out_PivotOS15_g251482 , Out_PivotWS15_g251482 , Out_PivotWO15_g251482 , Out_NormalOS15_g251482 , Out_NormalWS15_g251482 , Out_NormalRawOS15_g251482 , Out_TangentOS15_g251482 , Out_TangentWS15_g251482 , Out_BitangentWS15_g251482 , Out_ViewDirWS15_g251482 , Out_CoordsData15_g251482 , Out_VertexData15_g251482 , Out_MasksData15_g251482 , Out_PhaseData15_g251482 , Out_TransformData15_g251482 , Out_RotationData15_g251482 , Out_InterpolatorA15_g251482 );
					TVEModelData Data16_g251483 =(TVEModelData)Data15_g251482;
					float temp_output_14_0_g251483 = 0.0;
					float In_Dummy16_g251483 = temp_output_14_0_g251483;
					float3 Model_PositionOS147_g251481 = Out_PositionOS15_g251482;
					half3 VertexPos40_g251487 = Model_PositionOS147_g251481;
					float4 temp_output_1567_33_g251481 = Out_RotationData15_g251482;
					half4 Model_RotationData1569_g251481 = temp_output_1567_33_g251481;
					float2 break1582_g251481 = (Model_RotationData1569_g251481).xy;
					half Angle44_g251487 = break1582_g251481.y;
					half CosAngle89_g251487 = cos( Angle44_g251487 );
					half SinAngle93_g251487 = sin( Angle44_g251487 );
					float3 appendResult95_g251487 = (float3((VertexPos40_g251487).x , ( ( (VertexPos40_g251487).y * CosAngle89_g251487 ) - ( (VertexPos40_g251487).z * SinAngle93_g251487 ) ) , ( ( (VertexPos40_g251487).y * SinAngle93_g251487 ) + ( (VertexPos40_g251487).z * CosAngle89_g251487 ) )));
					half3 VertexPos40_g251488 = appendResult95_g251487;
					half Angle44_g251488 = -break1582_g251481.x;
					half CosAngle94_g251488 = cos( Angle44_g251488 );
					half SinAngle95_g251488 = sin( Angle44_g251488 );
					float3 appendResult98_g251488 = (float3(( ( (VertexPos40_g251488).x * CosAngle94_g251488 ) - ( (VertexPos40_g251488).y * SinAngle95_g251488 ) ) , ( ( (VertexPos40_g251488).x * SinAngle95_g251488 ) + ( (VertexPos40_g251488).y * CosAngle94_g251488 ) ) , (VertexPos40_g251488).z));
					half3 VertexPos40_g251486 = Model_PositionOS147_g251481;
					half Angle44_g251486 = break1582_g251481.y;
					half CosAngle89_g251486 = cos( Angle44_g251486 );
					half SinAngle93_g251486 = sin( Angle44_g251486 );
					float3 appendResult95_g251486 = (float3((VertexPos40_g251486).x , ( ( (VertexPos40_g251486).y * CosAngle89_g251486 ) - ( (VertexPos40_g251486).z * SinAngle93_g251486 ) ) , ( ( (VertexPos40_g251486).y * SinAngle93_g251486 ) + ( (VertexPos40_g251486).z * CosAngle89_g251486 ) )));
					half3 VertexPos40_g251491 = appendResult95_g251486;
					half Angle44_g251491 = break1582_g251481.x;
					half CosAngle91_g251491 = cos( Angle44_g251491 );
					half SinAngle92_g251491 = sin( Angle44_g251491 );
					float3 appendResult93_g251491 = (float3(( ( (VertexPos40_g251491).x * CosAngle91_g251491 ) + ( (VertexPos40_g251491).z * SinAngle92_g251491 ) ) , (VertexPos40_g251491).y , ( ( -(VertexPos40_g251491).x * SinAngle92_g251491 ) + ( (VertexPos40_g251491).z * CosAngle91_g251491 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251489 = appendResult93_g251491;
					#else
					float3 staticSwitch65_g251489 = appendResult98_g251488;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251484 = staticSwitch65_g251489;
					#else
					float3 staticSwitch65_g251484 = Model_PositionOS147_g251481;
					#endif
					float3 temp_output_1608_0_g251481 = staticSwitch65_g251484;
					half3 VertexPos40_g251490 = temp_output_1608_0_g251481;
					half Angle44_g251490 = (Model_RotationData1569_g251481).z;
					half CosAngle91_g251490 = cos( Angle44_g251490 );
					half SinAngle92_g251490 = sin( Angle44_g251490 );
					float3 appendResult93_g251490 = (float3(( ( (VertexPos40_g251490).x * CosAngle91_g251490 ) + ( (VertexPos40_g251490).z * SinAngle92_g251490 ) ) , (VertexPos40_g251490).y , ( ( -(VertexPos40_g251490).x * SinAngle92_g251490 ) + ( (VertexPos40_g251490).z * CosAngle91_g251490 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251485 = appendResult93_g251490;
					#else
					float3 staticSwitch65_g251485 = temp_output_1608_0_g251481;
					#endif
					float4 temp_output_1567_31_g251481 = Out_TransformData15_g251482;
					half4 Model_TransformData1568_g251481 = temp_output_1567_31_g251481;
					half3 Final_PositionOS178_g251481 = ( ( staticSwitch65_g251485 * (Model_TransformData1568_g251481).w ) + (Model_TransformData1568_g251481).xyz );
					float3 temp_output_4_0_g251483 = Final_PositionOS178_g251481;
					float3 In_PositionOS16_g251483 = temp_output_4_0_g251483;
					float3 In_PositionWS16_g251483 = Out_PositionWS15_g251482;
					float3 In_PositionWO16_g251483 = Out_PositionWO15_g251482;
					float3 In_PositionRawOS16_g251483 = Out_PositionRawOS15_g251482;
					float3 In_PivotOS16_g251483 = Out_PivotOS15_g251482;
					float3 In_PivotWS16_g251483 = Out_PivotWS15_g251482;
					float3 In_PivotWO16_g251483 = Out_PivotWO15_g251482;
					float3 temp_output_21_0_g251483 = Out_NormalOS15_g251482;
					float3 In_NormalOS16_g251483 = temp_output_21_0_g251483;
					float3 In_NormalWS16_g251483 = Out_NormalWS15_g251482;
					float3 In_NormalRawOS16_g251483 = Out_NormalRawOS15_g251482;
					float4 temp_output_6_0_g251483 = Out_TangentOS15_g251482;
					float4 In_TangentOS16_g251483 = temp_output_6_0_g251483;
					float3 In_TangentWS16_g251483 = Out_TangentWS15_g251482;
					float3 In_BitangentWS16_g251483 = Out_BitangentWS15_g251482;
					float3 In_ViewDirWS16_g251483 = Out_ViewDirWS15_g251482;
					float4 In_CoordsData16_g251483 = Out_CoordsData15_g251482;
					float4 In_VertexData16_g251483 = Out_VertexData15_g251482;
					float4 In_MasksData16_g251483 = Out_MasksData15_g251482;
					float4 In_PhaseData16_g251483 = Out_PhaseData15_g251482;
					float4 In_TransformData16_g251483 = temp_output_1567_31_g251481;
					float4 In_RotationData16_g251483 = temp_output_1567_33_g251481;
					float4 In_InterpolatorA16_g251483 = Out_InterpolatorA15_g251482;
					BuildModelVertData( Data16_g251483 , In_Dummy16_g251483 , In_PositionOS16_g251483 , In_PositionWS16_g251483 , In_PositionWO16_g251483 , In_PositionRawOS16_g251483 , In_PivotOS16_g251483 , In_PivotWS16_g251483 , In_PivotWO16_g251483 , In_NormalOS16_g251483 , In_NormalWS16_g251483 , In_NormalRawOS16_g251483 , In_TangentOS16_g251483 , In_TangentWS16_g251483 , In_BitangentWS16_g251483 , In_ViewDirWS16_g251483 , In_CoordsData16_g251483 , In_VertexData16_g251483 , In_MasksData16_g251483 , In_PhaseData16_g251483 , In_TransformData16_g251483 , In_RotationData16_g251483 , In_InterpolatorA16_g251483 );
					TVEModelData Data15_g251514 =(TVEModelData)Data16_g251483;
					float Out_Dummy15_g251514 = 0.0;
					float3 Out_PositionOS15_g251514 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251514 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251514 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251514 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251514 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251514 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251514 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251514 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251514 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251514 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251514 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251514 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251514 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251514 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251514 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251514 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251514 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251514 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251514 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251514 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251514 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251514 , Out_Dummy15_g251514 , Out_PositionOS15_g251514 , Out_PositionWS15_g251514 , Out_PositionWO15_g251514 , Out_PositionRawOS15_g251514 , Out_PivotOS15_g251514 , Out_PivotWS15_g251514 , Out_PivotWO15_g251514 , Out_NormalOS15_g251514 , Out_NormalWS15_g251514 , Out_NormalRawOS15_g251514 , Out_TangentOS15_g251514 , Out_TangentWS15_g251514 , Out_BitangentWS15_g251514 , Out_ViewDirWS15_g251514 , Out_CoordsData15_g251514 , Out_VertexData15_g251514 , Out_MasksData15_g251514 , Out_PhaseData15_g251514 , Out_TransformData15_g251514 , Out_RotationData15_g251514 , Out_InterpolatorA15_g251514 );
					TVEModelData Data16_g251515 =(TVEModelData)Data15_g251514;
					float temp_output_14_0_g251515 = 0.0;
					float In_Dummy16_g251515 = temp_output_14_0_g251515;
					float3 temp_output_217_24_g251513 = Out_PivotOS15_g251514;
					float3 temp_output_216_0_g251513 = ( Out_PositionOS15_g251514 + temp_output_217_24_g251513 );
					float3 temp_output_4_0_g251515 = temp_output_216_0_g251513;
					float3 In_PositionOS16_g251515 = temp_output_4_0_g251515;
					float3 In_PositionWS16_g251515 = Out_PositionWS15_g251514;
					float3 In_PositionWO16_g251515 = Out_PositionWO15_g251514;
					float3 In_PositionRawOS16_g251515 = Out_PositionRawOS15_g251514;
					float3 In_PivotOS16_g251515 = temp_output_217_24_g251513;
					float3 In_PivotWS16_g251515 = Out_PivotWS15_g251514;
					float3 In_PivotWO16_g251515 = Out_PivotWO15_g251514;
					float3 temp_output_21_0_g251515 = Out_NormalOS15_g251514;
					float3 In_NormalOS16_g251515 = temp_output_21_0_g251515;
					float3 In_NormalWS16_g251515 = Out_NormalWS15_g251514;
					float3 In_NormalRawOS16_g251515 = Out_NormalRawOS15_g251514;
					float4 temp_output_6_0_g251515 = Out_TangentOS15_g251514;
					float4 In_TangentOS16_g251515 = temp_output_6_0_g251515;
					float3 In_TangentWS16_g251515 = Out_TangentWS15_g251514;
					float3 In_BitangentWS16_g251515 = Out_BitangentWS15_g251514;
					float3 In_ViewDirWS16_g251515 = Out_ViewDirWS15_g251514;
					float4 In_CoordsData16_g251515 = Out_CoordsData15_g251514;
					float4 In_VertexData16_g251515 = Out_VertexData15_g251514;
					float4 In_MasksData16_g251515 = Out_MasksData15_g251514;
					float4 In_PhaseData16_g251515 = Out_PhaseData15_g251514;
					float4 In_TransformData16_g251515 = Out_TransformData15_g251514;
					float4 In_RotationData16_g251515 = Out_RotationData15_g251514;
					float4 In_InterpolatorA16_g251515 = Out_InterpolatorA15_g251514;
					BuildModelVertData( Data16_g251515 , In_Dummy16_g251515 , In_PositionOS16_g251515 , In_PositionWS16_g251515 , In_PositionWO16_g251515 , In_PositionRawOS16_g251515 , In_PivotOS16_g251515 , In_PivotWS16_g251515 , In_PivotWO16_g251515 , In_NormalOS16_g251515 , In_NormalWS16_g251515 , In_NormalRawOS16_g251515 , In_TangentOS16_g251515 , In_TangentWS16_g251515 , In_BitangentWS16_g251515 , In_ViewDirWS16_g251515 , In_CoordsData16_g251515 , In_VertexData16_g251515 , In_MasksData16_g251515 , In_PhaseData16_g251515 , In_TransformData16_g251515 , In_RotationData16_g251515 , In_InterpolatorA16_g251515 );
					TVEModelData Data15_g251524 =(TVEModelData)Data16_g251515;
					float Out_Dummy15_g251524 = 0.0;
					float3 Out_PositionOS15_g251524 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251524 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251524 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251524 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251524 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251524 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251524 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251524 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251524 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251524 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251524 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251524 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251524 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251524 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251524 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251524 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251524 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251524 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251524 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251524 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251524 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251524 , Out_Dummy15_g251524 , Out_PositionOS15_g251524 , Out_PositionWS15_g251524 , Out_PositionWO15_g251524 , Out_PositionRawOS15_g251524 , Out_PivotOS15_g251524 , Out_PivotWS15_g251524 , Out_PivotWO15_g251524 , Out_NormalOS15_g251524 , Out_NormalWS15_g251524 , Out_NormalRawOS15_g251524 , Out_TangentOS15_g251524 , Out_TangentWS15_g251524 , Out_BitangentWS15_g251524 , Out_ViewDirWS15_g251524 , Out_CoordsData15_g251524 , Out_VertexData15_g251524 , Out_MasksData15_g251524 , Out_PhaseData15_g251524 , Out_TransformData15_g251524 , Out_RotationData15_g251524 , Out_InterpolatorA15_g251524 );
					
					float3 color107_g251314 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251314 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float localBreakData4_g251313 = ( 0.0 );
					float localBuildMasksData3_g241966 = ( 0.0 );
					TVEMasksData Data3_g241966 = (TVEMasksData)0;
					half Feature_Intensity3187_g241936 = _MotionIntensityValue;
					float ifLocalVar18_g241970 = 0;
					if( Feature_Intensity3187_g241936 <= 0.0 )
					ifLocalVar18_g241970 = 0.0;
					else
					ifLocalVar18_g241970 = 1.0;
					half Feature_Element3188_g241936 = _MotionElementMode;
					float ifLocalVar18_g241972 = 0;
					if( Feature_Element3188_g241936 <= 0.0 )
					ifLocalVar18_g241972 = 0.0;
					else
					ifLocalVar18_g241972 = 1.0;
					float4 appendResult2992_g241936 = (float4(ifLocalVar18_g241970 , 0.0 , 0.0 , ifLocalVar18_g241972));
					float4 In_MaskA3_g241966 = appendResult2992_g241936;
					float temp_output_17_0_g241974 = _MotionBaseMaskMode;
					float Option83_g241974 = temp_output_17_0_g241974;
					TVEModelData Data15_g241938 =(TVEModelData)Data26_g241935;
					float Out_Dummy15_g241938 = 0.0;
					float3 Out_PositionOS15_g241938 = float3( 0,0,0 );
					float3 Out_PositionWS15_g241938 = float3( 0,0,0 );
					float3 Out_PositionWO15_g241938 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g241938 = float3( 0,0,0 );
					float3 Out_PivotOS15_g241938 = float3( 0,0,0 );
					float3 Out_PivotWS15_g241938 = float3( 0,0,0 );
					float3 Out_PivotWO15_g241938 = float3( 0,0,0 );
					float3 Out_NormalOS15_g241938 = float3( 0,0,0 );
					float3 Out_NormalWS15_g241938 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g241938 = float3( 0,0,0 );
					float4 Out_TangentOS15_g241938 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g241938 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g241938 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g241938 = float3( 0,0,0 );
					float4 Out_CoordsData15_g241938 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g241938 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g241938 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g241938 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g241938 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g241938 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g241938 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g241938 , Out_Dummy15_g241938 , Out_PositionOS15_g241938 , Out_PositionWS15_g241938 , Out_PositionWO15_g241938 , Out_PositionRawOS15_g241938 , Out_PivotOS15_g241938 , Out_PivotWS15_g241938 , Out_PivotWO15_g241938 , Out_NormalOS15_g241938 , Out_NormalWS15_g241938 , Out_NormalRawOS15_g241938 , Out_TangentOS15_g241938 , Out_TangentWS15_g241938 , Out_BitangentWS15_g241938 , Out_ViewDirWS15_g241938 , Out_CoordsData15_g241938 , Out_VertexData15_g241938 , Out_MasksData15_g241938 , Out_PhaseData15_g241938 , Out_TransformData15_g241938 , Out_RotationData15_g241938 , Out_InterpolatorA15_g241938 );
					float4 temp_output_2772_29_g241936 = Out_VertexData15_g241938;
					half4 Model_VertexMasks518_g241936 = temp_output_2772_29_g241936;
					float4 ChannelA83_g241974 = Model_VertexMasks518_g241936;
					float4 temp_output_2772_30_g241936 = Out_MasksData15_g241938;
					half4 Model_MasksData1322_g241936 = temp_output_2772_30_g241936;
					float2 uv_MotionMaskTex2818_g241936 = v.texcoord.xyzw.xy;
					half4 Motion_MaskTex2819_g241936 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g241936, 0.0 );
					float4 appendResult3220_g241936 = (float4((Model_MasksData1322_g241936).xy , (Motion_MaskTex2819_g241936).r , 0.0));
					float4 ChannelB83_g241974 = appendResult3220_g241936;
					float localSwitchChannel883_g241974 = SwitchChannel8( Option83_g241974 , ChannelA83_g241974 , ChannelB83_g241974 );
					float clampResult17_g241946 = clamp( localSwitchChannel883_g241974 , 0.0001 , 0.9999 );
					float temp_output_7_0_g241945 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g241945 = ( clampResult17_g241946 - temp_output_7_0_g241945 );
					half Base_Mask217_g241936 = saturate( ( temp_output_9_0_g241945 * _MotionBaseMaskRemap.z ) );
					float3 temp_output_2772_17_g241936 = Out_PositionWO15_g241938;
					float3 Model_PositionWO162_g241936 = temp_output_2772_17_g241936;
					half3 Input_ModelPositionWO761_g241939 = Model_PositionWO162_g241936;
					float3 temp_output_2772_19_g241936 = Out_PivotWO15_g241938;
					float3 Model_PivotWO402_g241936 = temp_output_2772_19_g241936;
					half3 Input_ModelPivotsWO419_g241939 = Model_PivotWO402_g241936;
					half Input_MotionPivots629_g241939 = _MotionBasePivotValue;
					float3 lerpResult771_g241939 = lerp( Input_ModelPositionWO761_g241939 , Input_ModelPivotsWO419_g241939 , Input_MotionPivots629_g241939);
					float4 temp_output_2772_27_g241936 = Out_PhaseData15_g241938;
					half4 Model_PhaseData489_g241936 = temp_output_2772_27_g241936;
					half4 Input_ModelMotionData763_g241939 = Model_PhaseData489_g241936;
					half Input_MotionPhase764_g241939 = _MotionBasePhaseValue;
					float temp_output_770_0_g241939 = ( (Input_ModelMotionData763_g241939).x * Input_MotionPhase764_g241939 );
					half3 Base_Position1394_g241936 = ( lerpResult771_g241939 + temp_output_770_0_g241939 );
					half3 Input_PositionWO419_g241977 = Base_Position1394_g241936;
					half Input_MotionTilling321_g241977 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g241977 = ( -(Input_PositionWO419_g241977).xz * Input_MotionTilling321_g241977 * 0.005 );
					float2 temp_output_3_0_g241984 = Noise_Coord515_g241977;
					float2 lerpResult3113_g241936 = lerp( (half4( 0, 1, 0.5, 1 )).xy , (TVE_WindParams).xy , TVE_IsEnabled);
					float2 Global_WindDirWS2542_g241936 = lerpResult3113_g241936;
					half2 Input_WindDirWS803_g241977 = Global_WindDirWS2542_g241936;
					float2 temp_output_21_0_g241984 = Input_WindDirWS803_g241977;
					float mulTime113_g241978 = _Time.y * 0.02;
					float lerpResult128_g241978 = lerp( mulTime113_g241978 , ( ( mulTime113_g241978 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g241977 = _MotionBaseSpeedValue;
					half Noise_Speed516_g241977 = ( lerpResult128_g241978 * Input_MotionSpeed62_g241977 );
					float temp_output_15_0_g241984 = Noise_Speed516_g241977;
					float temp_output_23_0_g241984 = frac( temp_output_15_0_g241984 );
					float4 lerpResult39_g241984 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g241984 + ( temp_output_21_0_g241984 * temp_output_23_0_g241984 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g241984 + ( temp_output_21_0_g241984 * frac( ( temp_output_15_0_g241984 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g241984 - 0.5 ) ) / 0.5 ));
					float4 temp_output_635_0_g241977 = lerpResult39_g241984;
					half4 Noise_Params685_g241977 = temp_output_635_0_g241977;
					half Base_Noise2949_g241936 = (Noise_Params685_g241977).g;
					half Base_Phase2971_g241936 = frac( temp_output_770_0_g241939 );
					TVEGlobalData Data15_g241950 =(TVEGlobalData)Data204_g241858;
					float Out_Dummy15_g241950 = 0.0;
					float4 Out_CoatParams15_g241950 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g241950 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g241950 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g241950 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g241950 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g241950 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g241950 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g241950 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g241950 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g241950 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g241950 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g241950 = float4( 0,0,0,0 );
					BreakData( Data15_g241950 , Out_Dummy15_g241950 , Out_CoatParams15_g241950 , Out_CoatTexture15_g241950 , Out_PaintParams15_g241950 , Out_PaintTexture15_g241950 , Out_AtmoParams15_g241950 , Out_AtmoTexture15_g241950 , Out_GlowParams15_g241950 , Out_GlowTexture15_g241950 , Out_FormParams15_g241950 , Out_FormTexture15_g241950 , Out_FlowParams15_g241950 , Out_FlowTexture15_g241950 );
					half4 Global_FlowParams3052_g241936 = Out_FlowParams15_g241950;
					half4 Global_FlowTexture2668_g241936 = Out_FlowTexture15_g241950;
					#ifdef TVE_MOTION_ELEMENT
					float4 staticSwitch3075_g241936 = Global_FlowTexture2668_g241936;
					#else
					float4 staticSwitch3075_g241936 = Global_FlowParams3052_g241936;
					#endif
					float4 temp_output_6_0_g241952 = staticSwitch3075_g241936;
					float temp_output_7_0_g241952 = _MotionElementMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g241952 = ( temp_output_6_0_g241952 + temp_output_7_0_g241952 );
					#else
					float4 staticSwitch14_g241952 = temp_output_6_0_g241952;
					#endif
					float4 lerpResult3121_g241936 = lerp( half4( 0, 0, 0, 1 ) , staticSwitch14_g241952 , TVE_IsEnabled);
					float2 temp_output_3126_0_g241936 = ((lerpResult3121_g241936).xy*2.0 + -1.0);
					half Global_PushAlpha1504_g241936 = length( temp_output_3126_0_g241936 );
					half Input_PushAlpha806_g241977 = Global_PushAlpha1504_g241936;
					half Input_ReactValue888_g241977 = _MotionBasePushValue;
					half Push_Mask883_g241977 = saturate( ( Input_PushAlpha806_g241977 * Input_ReactValue888_g241977 ) );
					half Base_React3000_g241936 = Push_Mask883_g241977;
					float ifLocalVar18_g241971 = 0;
					if( Feature_Element3188_g241936 <= 0.0 )
					ifLocalVar18_g241971 = 0.0;
					else
					ifLocalVar18_g241971 = Base_React3000_g241936;
					float4 appendResult2956_g241936 = (float4(Base_Mask217_g241936 , Base_Noise2949_g241936 , Base_Phase2971_g241936 , ifLocalVar18_g241971));
					float4 temp_cast_17 = (0.0).xxxx;
					float4 temp_cast_18 = (0.0).xxxx;
					float4 ifLocalVar18_g241969 = 0;
					if( Feature_Intensity3187_g241936 <= 0.0 )
					ifLocalVar18_g241969 = temp_cast_18;
					else
					ifLocalVar18_g241969 = appendResult2956_g241936;
					float4 In_MaskB3_g241966 = ifLocalVar18_g241969;
					float temp_output_17_0_g241975 = _MotionSmallMaskMode;
					float Option83_g241975 = temp_output_17_0_g241975;
					float4 ChannelA83_g241975 = Model_VertexMasks518_g241936;
					float4 appendResult3227_g241936 = (float4((Model_MasksData1322_g241936).xy , (Motion_MaskTex2819_g241936).g , 0.0));
					float4 ChannelB83_g241975 = appendResult3227_g241936;
					float localSwitchChannel883_g241975 = SwitchChannel8( Option83_g241975 , ChannelA83_g241975 , ChannelB83_g241975 );
					float enc1805_g241936 = v.texcoord.xyzw.z;
					float2 localDecodeFloatToVector21805_g241936 = DecodeFloatToVector2( enc1805_g241936 );
					float2 break1804_g241936 = localDecodeFloatToVector21805_g241936;
					half Small_Mask_Legacy1806_g241936 = break1804_g241936.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g241936 = Small_Mask_Legacy1806_g241936;
					#else
					float staticSwitch1800_g241936 = localSwitchChannel883_g241975;
					#endif
					float clampResult17_g241941 = clamp( staticSwitch1800_g241936 , 0.0001 , 0.9999 );
					float temp_output_7_0_g241942 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g241942 = ( clampResult17_g241941 - temp_output_7_0_g241942 );
					half Small_Mask640_g241936 = saturate( ( temp_output_9_0_g241942 * _MotionSmallMaskRemap.z ) );
					half3 Input_ModelPositionWO761_g241940 = Model_PositionWO162_g241936;
					half3 Input_ModelPivotsWO419_g241940 = Model_PivotWO402_g241936;
					half Input_MotionPivots629_g241940 = _MotionSmallPivotValue;
					float3 lerpResult771_g241940 = lerp( Input_ModelPositionWO761_g241940 , Input_ModelPivotsWO419_g241940 , Input_MotionPivots629_g241940);
					half4 Input_ModelMotionData763_g241940 = Model_PhaseData489_g241936;
					half Input_MotionPhase764_g241940 = _MotionSmallPhaseValue;
					float temp_output_770_0_g241940 = ( (Input_ModelMotionData763_g241940).x * Input_MotionPhase764_g241940 );
					half3 Small_Position1421_g241936 = ( lerpResult771_g241940 + temp_output_770_0_g241940 );
					half3 Input_PositionWO419_g241987 = Small_Position1421_g241936;
					half Input_MotionTilling321_g241987 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g241987 = ( -(Input_PositionWO419_g241987).xz * Input_MotionTilling321_g241987 * 0.005 );
					float2 temp_output_3_0_g241988 = Noise_Coord979_g241987;
					half2 Input_WindDirWS803_g241987 = Global_WindDirWS2542_g241936;
					float2 temp_output_21_0_g241988 = Input_WindDirWS803_g241987;
					float mulTime113_g241991 = _Time.y * 0.02;
					float lerpResult128_g241991 = lerp( mulTime113_g241991 , ( ( mulTime113_g241991 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g241987 = _MotionSmallSpeedValue;
					half Noise_Speed980_g241987 = ( lerpResult128_g241991 * Input_MotionSpeed62_g241987 );
					float temp_output_15_0_g241988 = Noise_Speed980_g241987;
					float temp_output_23_0_g241988 = frac( temp_output_15_0_g241988 );
					float4 lerpResult39_g241988 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g241988 + ( temp_output_21_0_g241988 * temp_output_23_0_g241988 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g241988 + ( temp_output_21_0_g241988 * frac( ( temp_output_15_0_g241988 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g241988 - 0.5 ) ) / 0.5 ));
					float4 temp_output_991_0_g241987 = lerpResult39_g241988;
					half4 Noise_Params685_g241987 = temp_output_991_0_g241987;
					half Small_Noise2950_g241936 = (Noise_Params685_g241987).g;
					half Small_Phase2972_g241936 = frac( temp_output_770_0_g241940 );
					half Input_PushAlpha806_g241987 = Global_PushAlpha1504_g241936;
					half Global_PushNoise2675_g241936 = (lerpResult3121_g241936).z;
					half Input_PushNoise890_g241987 = Global_PushNoise2675_g241936;
					half Input_MotionReact924_g241987 = _MotionSmallPushValue;
					half Push_Mask914_g241987 = saturate( ( Input_PushAlpha806_g241987 * Input_PushNoise890_g241987 * Input_MotionReact924_g241987 ) );
					half Small_React3002_g241936 = Push_Mask914_g241987;
					float ifLocalVar18_g241973 = 0;
					if( Feature_Element3188_g241936 <= 0.0 )
					ifLocalVar18_g241973 = 0.0;
					else
					ifLocalVar18_g241973 = Small_React3002_g241936;
					float4 appendResult2954_g241936 = (float4(Small_Mask640_g241936 , Small_Noise2950_g241936 , Small_Phase2972_g241936 , ifLocalVar18_g241973));
					float4 temp_cast_19 = (0.0).xxxx;
					float4 temp_cast_20 = (0.0).xxxx;
					float4 ifLocalVar18_g241967 = 0;
					if( Feature_Intensity3187_g241936 <= 0.0 )
					ifLocalVar18_g241967 = temp_cast_20;
					else
					ifLocalVar18_g241967 = appendResult2954_g241936;
					float4 In_MaskC3_g241966 = ifLocalVar18_g241967;
					float temp_output_17_0_g241976 = _MotionTinyMaskMode;
					float Option83_g241976 = temp_output_17_0_g241976;
					float4 ChannelA83_g241976 = Model_VertexMasks518_g241936;
					float4 appendResult3234_g241936 = (float4((Model_MasksData1322_g241936).xy , (Motion_MaskTex2819_g241936).b , 0.0));
					float4 ChannelB83_g241976 = appendResult3234_g241936;
					float localSwitchChannel883_g241976 = SwitchChannel8( Option83_g241976 , ChannelA83_g241976 , ChannelB83_g241976 );
					half Tiny_Mask_Legacy1807_g241936 = break1804_g241936.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g241936 = Tiny_Mask_Legacy1807_g241936;
					#else
					float staticSwitch1810_g241936 = localSwitchChannel883_g241976;
					#endif
					float clampResult17_g241943 = clamp( staticSwitch1810_g241936 , 0.0001 , 0.9999 );
					float temp_output_7_0_g241944 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g241944 = ( clampResult17_g241943 - temp_output_7_0_g241944 );
					half Tiny_Mask218_g241936 = saturate( ( temp_output_9_0_g241944 * _MotionTinyMaskRemap.z ) );
					half3 Tiny_Position2469_g241936 = Model_PositionWO162_g241936;
					half3 Input_PositionWO500_g241958 = Tiny_Position2469_g241936;
					half Input_MotionTilling321_g241958 = ( _MotionTinyTillingValue + 0.1 );
					float lerpResult128_g241963 = lerp( _Time.y , ( ( _Time.y * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g241958 = _MotionTinySpeedValue;
					float4 tex2DNode514_g241958 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( ( (Input_PositionWO500_g241958).xz * Input_MotionTilling321_g241958 * 0.005 ) + ( lerpResult128_g241963 * Input_MotionSpeed62_g241958 * 0.02 ) ), 0.0 );
					half Tiny_Noise2967_g241936 = tex2DNode514_g241958.g;
					float4 appendResult2975_g241936 = (float4(Tiny_Mask218_g241936 , Tiny_Noise2967_g241936 , 0.0 , 0.0));
					float4 temp_cast_21 = (0.0).xxxx;
					float4 temp_cast_22 = (0.0).xxxx;
					float4 ifLocalVar18_g241968 = 0;
					if( Feature_Intensity3187_g241936 <= 0.0 )
					ifLocalVar18_g241968 = temp_cast_22;
					else
					ifLocalVar18_g241968 = appendResult2975_g241936;
					float4 In_MaskD3_g241966 = ifLocalVar18_g241968;
					float4 temp_cast_23 = (0.0).xxxx;
					float4 In_MaskE3_g241966 = temp_cast_23;
					float4 temp_cast_24 = (0.0).xxxx;
					float4 In_MaskF3_g241966 = temp_cast_24;
					float4 temp_cast_25 = (0.0).xxxx;
					float4 In_MaskG3_g241966 = temp_cast_25;
					float4 temp_cast_26 = (0.0).xxxx;
					float4 In_MaskH3_g241966 = temp_cast_26;
					float4 temp_cast_27 = (0.0).xxxx;
					float4 In_MaskI3_g241966 = temp_cast_27;
					float4 temp_cast_28 = (0.0).xxxx;
					float4 In_MaskJ3_g241966 = temp_cast_28;
					float4 temp_cast_29 = (0.0).xxxx;
					float4 In_MaskK3_g241966 = temp_cast_29;
					float4 temp_cast_30 = (0.0).xxxx;
					float4 In_MaskL3_g241966 = temp_cast_30;
					{
					Data3_g241966.MaskA = In_MaskA3_g241966;
					Data3_g241966.MaskB = In_MaskB3_g241966;
					Data3_g241966.MaskC = In_MaskC3_g241966;
					Data3_g241966.MaskD = In_MaskD3_g241966;
					Data3_g241966.MaskE = In_MaskE3_g241966;
					Data3_g241966.MaskF = In_MaskF3_g241966;
					Data3_g241966.MaskG = In_MaskG3_g241966;
					Data3_g241966.MaskH = In_MaskH3_g241966;
					Data3_g241966.MaskI = In_MaskI3_g241966;
					Data3_g241966.MaskJ= In_MaskJ3_g241966;
					Data3_g241966.MaskK= In_MaskK3_g241966;
					Data3_g241966.MaskL = In_MaskL3_g241966;
					}
					TVEMasksData Data4_g251313 = Data3_g241966;
					float4 Out_MaskA4_g251313 = float4( 0,0,0,0 );
					float4 Out_MaskB4_g251313 = float4( 0,0,0,0 );
					float4 Out_MaskC4_g251313 = float4( 0,0,0,0 );
					float4 Out_MaskD4_g251313 = float4( 0,0,0,0 );
					float4 Out_MaskE4_g251313 = float4( 0,0,0,0 );
					float4 Out_MaskF4_g251313 = float4( 0,0,0,0 );
					float4 Out_MaskG4_g251313 = float4( 0,0,0,0 );
					float4 Out_MaskH4_g251313 = float4( 0,0,0,0 );
					{
					Out_MaskA4_g251313 = Data4_g251313.MaskA;
					Out_MaskB4_g251313 = Data4_g251313.MaskB;
					Out_MaskC4_g251313 = Data4_g251313.MaskC;
					Out_MaskD4_g251313 = Data4_g251313.MaskD;
					Out_MaskE4_g251313 = Data4_g251313.MaskE;
					Out_MaskF4_g251313 = Data4_g251313.MaskF;
					Out_MaskG4_g251313 = Data4_g251313.MaskG;
					Out_MaskH4_g251313 = Data4_g251313.MaskH;
					}
					float4 temp_output_2509_14 = Out_MaskA4_g251313;
					float3 lerpResult2568 = lerp( color107_g251314 , color106_g251314 , (temp_output_2509_14).x);
					float3 ifLocalVar40_g251375 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g251375 = lerpResult2568;
					float4 temp_output_2509_0 = Out_MaskB4_g251313;
					float3 ifLocalVar40_g251338 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g251338 = (temp_output_2509_0).xxx;
					float3 ifLocalVar40_g251339 = 0;
					if( TVE_DEBUG_Index == 3.0 )
					ifLocalVar40_g251339 = (temp_output_2509_0).yyy;
					float3 ifLocalVar40_g251347 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g251347 = (temp_output_2509_0).zzz;
					float3 hsvTorgb2613 = HSVToRGB( float3((temp_output_2509_0).z,1.0,1.0) );
					float3 gammaToLinear2614 = GammaToLinearSpace( hsvTorgb2613 );
					float3 ifLocalVar40_g251348 = 0;
					if( TVE_DEBUG_Index == 5.0 )
					ifLocalVar40_g251348 = gammaToLinear2614;
					float3 ifLocalVar40_g251349 = 0;
					if( TVE_DEBUG_Index == 6.0 )
					ifLocalVar40_g251349 = (temp_output_2509_0).www;
					float4 temp_output_2509_23 = Out_MaskC4_g251313;
					float3 ifLocalVar40_g251340 = 0;
					if( TVE_DEBUG_Index == 8.0 )
					ifLocalVar40_g251340 = (temp_output_2509_23).xxx;
					float3 ifLocalVar40_g251341 = 0;
					if( TVE_DEBUG_Index == 9.0 )
					ifLocalVar40_g251341 = (temp_output_2509_23).yyy;
					float3 ifLocalVar40_g251342 = 0;
					if( TVE_DEBUG_Index == 10.0 )
					ifLocalVar40_g251342 = (temp_output_2509_23).zzz;
					float3 hsvTorgb2618 = HSVToRGB( float3((temp_output_2509_23).z,1.0,1.0) );
					float3 gammaToLinear2619 = GammaToLinearSpace( hsvTorgb2618 );
					float3 ifLocalVar40_g251343 = 0;
					if( TVE_DEBUG_Index == 11.0 )
					ifLocalVar40_g251343 = gammaToLinear2619;
					float3 ifLocalVar40_g251344 = 0;
					if( TVE_DEBUG_Index == 12.0 )
					ifLocalVar40_g251344 = (temp_output_2509_23).www;
					float4 temp_output_2509_5 = Out_MaskD4_g251313;
					float3 ifLocalVar40_g251345 = 0;
					if( TVE_DEBUG_Index == 14.0 )
					ifLocalVar40_g251345 = (temp_output_2509_5).xxx;
					float3 ifLocalVar40_g251346 = 0;
					if( TVE_DEBUG_Index == 15.0 )
					ifLocalVar40_g251346 = (temp_output_2509_5).yyy;
					float3 color107_g241995 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g241995 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2571 = lerp( color107_g241995 , color106_g241995 , (temp_output_2509_14).z);
					float3 ifLocalVar40_g251350 = 0;
					if( TVE_DEBUG_Index == 17.0 )
					ifLocalVar40_g251350 = lerpResult2571;
					float3 color107_g251311 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251311 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2641 = lerp( color107_g251311 , color106_g251311 , (temp_output_2509_14).w);
					float3 ifLocalVar40_g251351 = 0;
					if( TVE_DEBUG_Index == 18.0 )
					ifLocalVar40_g251351 = lerpResult2641;
					float3 vertexToFrag2524 = ( ifLocalVar40_g251375 + ( ifLocalVar40_g251338 + ifLocalVar40_g251339 + ifLocalVar40_g251347 + ifLocalVar40_g251348 + ifLocalVar40_g251349 ) + ( ifLocalVar40_g251340 + ifLocalVar40_g251341 + ifLocalVar40_g251342 + ifLocalVar40_g251343 + ifLocalVar40_g251344 ) + ( ifLocalVar40_g251345 + ifLocalVar40_g251346 + ifLocalVar40_g251350 + ifLocalVar40_g251351 ) );
					o.ase_texcoord6.xyz = vertexToFrag2524;
					float3 vertexPos57_g251518 = v.vertex.xyz;
					float4 ase_positionCS57_g251518 = UnityObjectToClipPos( vertexPos57_g251518 );
					o.ase_texcoord7 = ase_positionCS57_g251518;
					o.ase_texcoord8.xyz = vertexToFrag73_g241838;
					o.ase_texcoord9.xyz = vertexToFrag76_g241838;
					
					o.ase_texcoord10 = v.texcoord.xyzw;
					o.ase_texcoord11.xy = v.texcoord2.xyzw.xy;
					o.ase_color = v.ase_color;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord6.w = 0;
					o.ase_texcoord8.w = 0;
					o.ase_texcoord9.w = 0;
					o.ase_texcoord11.zw = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251524;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251524;
					v.tangent = Out_TangentOS15_g251524;

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
					
					float3 color130_g251518 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g251518 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g251520 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g251519 = ( temp_cast_4 * ( 0.5 + appendResult128_g251520 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g251519 = (float4(ddx( FinalUV13_g251519 ) , ddy( FinalUV13_g251519 )));
					float4 UVDerivatives17_g251519 = appendResult16_g251519;
					float4 break28_g251519 = UVDerivatives17_g251519;
					float2 appendResult19_g251519 = (float2(break28_g251519.x , break28_g251519.z));
					float2 appendResult20_g251519 = (float2(break28_g251519.x , break28_g251519.z));
					float dotResult24_g251519 = dot( appendResult19_g251519 , appendResult20_g251519 );
					float2 appendResult21_g251519 = (float2(break28_g251519.y , break28_g251519.w));
					float2 appendResult22_g251519 = (float2(break28_g251519.y , break28_g251519.w));
					float dotResult23_g251519 = dot( appendResult21_g251519 , appendResult22_g251519 );
					float2 appendResult25_g251519 = (float2(dotResult24_g251519 , dotResult23_g251519));
					float2 derivativesLength29_g251519 = sqrt( appendResult25_g251519 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g251519 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g251519 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g251519 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g251519 = clampResult57_g251519;
					float2 break55_g251519 = derivativesLength29_g251519;
					float4 lerpResult73_g251519 = lerp( float4( color130_g251518 , 0.0 ) , float4( color81_g251518 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g251519.x * break71_g251519.y * sqrt( saturate( ( 1.1 - max( break55_g251519.x, break55_g251519.y ) ) ) ) ) ) ));
					float3 vertexToFrag2524 = IN.ase_texcoord6.xyz;
					half3 Final_Debug2399 = vertexToFrag2524;
					float temp_output_7_0_g251526 = TVE_DEBUG_Min;
					float3 temp_cast_9 = (temp_output_7_0_g251526).xxx;
					float3 temp_output_9_0_g251526 = ( Final_Debug2399 - temp_cast_9 );
					float lerpResult76_g251518 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g251518 = lerpResult76_g251518;
					float3 lerpResult72_g251518 = lerp( (lerpResult73_g251519).rgb , saturate( ( temp_output_9_0_g251526 / ( ( TVE_DEBUG_Max - temp_output_7_0_g251526 ) + 0.0001 ) ) ) , Filter152_g251518);
					float dotResult61_g251518 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g251518 = ( 1.0 - saturate( dotResult61_g251518 ) );
					float Shading_Fresnel59_g251518 = (( 1.0 - ( temp_output_65_0_g251518 * temp_output_65_0_g251518 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g251518 = IN.ase_texcoord7;
					float depthLinearEye57_g251518 = LinearEyeDepth( ase_positionCS57_g251518.z / ase_positionCS57_g251518.w );
					float temp_output_69_0_g251518 = saturate(  (0.0 + ( depthLinearEye57_g251518 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g251518 = (( temp_output_69_0_g251518 * temp_output_69_0_g251518 )*0.5 + 0.5);
					float lerpResult84_g251518 = lerp( 1.0 , Shading_Fresnel59_g251518 , ( Shading_Distance58_g251518 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g251523 = ( 0.0 );
					float localBuildVisualData3_g251493 = ( 0.0 );
					TVEVisualData Data3_g251493 =(TVEVisualData)0;
					half4 Dummy130_g251492 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) );
					float temp_output_14_0_g251493 = Dummy130_g251492.x;
					float In_Dummy3_g251493 = temp_output_14_0_g251493;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251512) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g251507 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g251507 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g251507 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g251507 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g251507 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g251507 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g251512 = staticSwitch36_g251507;
					float localBreakTextureData456_g251512 = ( 0.0 );
					float localBuildTextureData431_g251506 = ( 0.0 );
					TVEMasksData Data431_g251506 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g251506 = ( 0.0 );
					half4 Local_Coords180_g251492 = _main_coord_value;
					float4 Coords444_g251506 = Local_Coords180_g251492;
					float localIfModelDataByShader26_g241817 = ( 0.0 );
					TVEModelData Data26_g241817 = (TVEModelData)0;
					TVEModelData Data16_g241846 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241846 = 0.0;
					float3 vertexToFrag73_g241838 = IN.ase_texcoord8.xyz;
					float3 PositionWS122_g241838 = vertexToFrag73_g241838;
					float3 In_PositionWS16_g241846 = PositionWS122_g241838;
					float3 vertexToFrag76_g241838 = IN.ase_texcoord9.xyz;
					float3 PivotWS121_g241838 = vertexToFrag76_g241838;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241838 = ( PositionWS122_g241838 - PivotWS121_g241838 );
					#else
					float3 staticSwitch204_g241838 = PositionWS122_g241838;
					#endif
					float3 PositionWO132_g241838 = ( staticSwitch204_g241838 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241846 = PositionWO132_g241838;
					float3 In_PivotWS16_g241846 = PivotWS121_g241838;
					float3 PivotWO133_g241838 = ( PivotWS121_g241838 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241846 = PivotWO133_g241838;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g241838 = normalizedWorldNormal;
					float3 In_NormalWS16_g241846 = NormalWS95_g241838;
					half3 TangentWS136_g241838 = TangentWS;
					float3 In_TangentWS16_g241846 = TangentWS136_g241838;
					half3 BiangentWS421_g241838 = BitangentWS;
					float3 In_BitangentWS16_g241846 = BiangentWS421_g241838;
					half3 NormalWS427_g241838 = NormalWS95_g241838;
					half3 localComputeTriplanarWeights427_g241838 = ComputeTriplanarWeights( NormalWS427_g241838 );
					half3 TriplanarWeights429_g241838 = localComputeTriplanarWeights427_g241838;
					float3 In_TriplanarWeights16_g241846 = TriplanarWeights429_g241838;
					float3 normalizeResult296_g241838 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241838 ) );
					half3 ViewDirWS169_g241838 = normalizeResult296_g241838;
					float3 In_ViewDirWS16_g241846 = ViewDirWS169_g241838;
					float4 appendResult397_g241838 = (float4(IN.ase_texcoord10.xy , IN.ase_texcoord11.xy));
					float4 CoordsData398_g241838 = appendResult397_g241838;
					float4 In_CoordsData16_g241846 = CoordsData398_g241838;
					half4 VertexMasks171_g241838 = IN.ase_color;
					float4 In_VertexData16_g241846 = VertexMasks171_g241838;
					float temp_output_17_0_g241850 = _ObjectPhaseMode;
					float Option70_g241850 = temp_output_17_0_g241850;
					float4 temp_output_3_0_g241850 = IN.ase_color;
					float4 Channel70_g241850 = temp_output_3_0_g241850;
					float localSwitchChannel470_g241850 = SwitchChannel4( Option70_g241850 , Channel70_g241850 );
					half Phase_Value372_g241838 = localSwitchChannel470_g241850;
					float3 break319_g241838 = PivotWO133_g241838;
					half Pivot_Position322_g241838 = ( break319_g241838.x + break319_g241838.z );
					half Phase_Position357_g241838 = ( Phase_Value372_g241838 + Pivot_Position322_g241838 );
					float temp_output_248_0_g241838 = frac( Phase_Position357_g241838 );
					float4 appendResult177_g241838 = (float4(( (frac( ( Phase_Position357_g241838 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g241838));
					half4 Phase_Data176_g241838 = appendResult177_g241838;
					float4 In_PhaseData16_g241846 = Phase_Data176_g241838;
					BuildModelFragData( Data16_g241846 , In_Dummy16_g241846 , In_PositionWS16_g241846 , In_PositionWO16_g241846 , In_PivotWS16_g241846 , In_PivotWO16_g241846 , In_NormalWS16_g241846 , In_TangentWS16_g241846 , In_BitangentWS16_g241846 , In_TriplanarWeights16_g241846 , In_ViewDirWS16_g241846 , In_CoordsData16_g241846 , In_VertexData16_g241846 , In_PhaseData16_g241846 );
					TVEModelData DataDefault26_g241817 = Data16_g241846;
					TVEModelData DataGeneral26_g241817 = Data16_g241846;
					TVEModelData DataBlanket26_g241817 = Data16_g241846;
					TVEModelData DataImpostor26_g241817 = Data16_g241846;
					TVEModelData Data16_g241826 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241826 = 0.0;
					float3 temp_output_104_7_g241818 = PositionWS;
					float3 PositionWS122_g241818 = temp_output_104_7_g241818;
					float3 In_PositionWS16_g241826 = PositionWS122_g241818;
					float4x4 break19_g241821 = unity_ObjectToWorld;
					float3 appendResult20_g241821 = (float3(break19_g241821[ 0 ][ 3 ] , break19_g241821[ 1 ][ 3 ] , break19_g241821[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241818 = appendResult20_g241821;
					float3 PivotWS121_g241818 = temp_output_340_7_g241818;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241818 = ( PositionWS122_g241818 - PivotWS121_g241818 );
					#else
					float3 staticSwitch204_g241818 = PositionWS122_g241818;
					#endif
					float3 PositionWO132_g241818 = ( staticSwitch204_g241818 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241826 = PositionWO132_g241818;
					float3 In_PivotWS16_g241826 = PivotWS121_g241818;
					float3 PivotWO133_g241818 = ( PivotWS121_g241818 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241826 = PivotWO133_g241818;
					half3 NormalWS95_g241818 = normalizedWorldNormal;
					float3 In_NormalWS16_g241826 = NormalWS95_g241818;
					half3 TangentWS136_g241818 = TangentWS;
					float3 In_TangentWS16_g241826 = TangentWS136_g241818;
					half3 BiangentWS421_g241818 = BitangentWS;
					float3 In_BitangentWS16_g241826 = BiangentWS421_g241818;
					half3 NormalWS427_g241818 = NormalWS95_g241818;
					half3 localComputeTriplanarWeights427_g241818 = ComputeTriplanarWeights( NormalWS427_g241818 );
					half3 TriplanarWeights429_g241818 = localComputeTriplanarWeights427_g241818;
					float3 In_TriplanarWeights16_g241826 = TriplanarWeights429_g241818;
					float3 normalizeResult296_g241818 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241818 ) );
					half3 ViewDirWS169_g241818 = normalizeResult296_g241818;
					float3 In_ViewDirWS16_g241826 = ViewDirWS169_g241818;
					float4 appendResult397_g241818 = (float4(IN.ase_texcoord10.xy , IN.ase_texcoord11.xy));
					float4 CoordsData398_g241818 = appendResult397_g241818;
					float4 In_CoordsData16_g241826 = CoordsData398_g241818;
					half4 VertexMasks171_g241818 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241826 = VertexMasks171_g241818;
					half4 Phase_Data176_g241818 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241826 = Phase_Data176_g241818;
					BuildModelFragData( Data16_g241826 , In_Dummy16_g241826 , In_PositionWS16_g241826 , In_PositionWO16_g241826 , In_PivotWS16_g241826 , In_PivotWO16_g241826 , In_NormalWS16_g241826 , In_TangentWS16_g241826 , In_BitangentWS16_g241826 , In_TriplanarWeights16_g241826 , In_ViewDirWS16_g241826 , In_CoordsData16_g241826 , In_VertexData16_g241826 , In_PhaseData16_g241826 );
					TVEModelData DataTerrain26_g241817 = Data16_g241826;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g241817 = IsShaderType2637;
					{
					if (Type26_g241817 == 0 )
					{
					Data26_g241817 = DataDefault26_g241817;
					}
					else if (Type26_g241817 == 1 )
					{
					Data26_g241817 = DataGeneral26_g241817;
					}
					else if (Type26_g241817 == 2 )
					{
					Data26_g241817 = DataBlanket26_g241817;
					}
					else if (Type26_g241817 == 3 )
					{
					Data26_g241817 = DataImpostor26_g241817;
					}
					else if (Type26_g241817 == 4 )
					{
					Data26_g241817 = DataTerrain26_g241817;
					}
					}
					TVEModelData Data15_g251505 =(TVEModelData)Data26_g241817;
					float Out_Dummy15_g251505 = 0.0;
					float3 Out_PositionWS15_g251505 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251505 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251505 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251505 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251505 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251505 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251505 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251505 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251505 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251505 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251505 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251505 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251505 , Out_Dummy15_g251505 , Out_PositionWS15_g251505 , Out_PositionWO15_g251505 , Out_PivotWS15_g251505 , Out_PivotWO15_g251505 , Out_NormalWS15_g251505 , Out_TangentWS15_g251505 , Out_BitangentWS15_g251505 , Out_TriplanarWeights15_g251505 , Out_ViewDirWS15_g251505 , Out_CoordsData15_g251505 , Out_VertexData15_g251505 , Out_PhaseData15_g251505 );
					float4 Model_CoordsData324_g251492 = Out_CoordsData15_g251505;
					float4 MeshCoords444_g251506 = Model_CoordsData324_g251492;
					float2 UV0444_g251506 = float2( 0,0 );
					float2 UV3444_g251506 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g251506 , MeshCoords444_g251506 , UV0444_g251506 , UV3444_g251506 );
					float4 appendResult430_g251506 = (float4(UV0444_g251506 , UV3444_g251506));
					float4 In_MaskA431_g251506 = appendResult430_g251506;
					float localComputeWorldCoords315_g251506 = ( 0.0 );
					float4 Coords315_g251506 = Local_Coords180_g251492;
					float3 Model_PositionWO222_g251492 = Out_PositionWO15_g251505;
					float3 PositionWS315_g251506 = Model_PositionWO222_g251492;
					float2 ZY315_g251506 = float2( 0,0 );
					float2 XZ315_g251506 = float2( 0,0 );
					float2 XY315_g251506 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g251506 , PositionWS315_g251506 , ZY315_g251506 , XZ315_g251506 , XY315_g251506 );
					float2 ZY402_g251506 = ZY315_g251506;
					float2 XZ403_g251506 = XZ315_g251506;
					float4 appendResult432_g251506 = (float4(ZY402_g251506 , XZ403_g251506));
					float4 In_MaskB431_g251506 = appendResult432_g251506;
					float2 XY404_g251506 = XY315_g251506;
					float localComputeStochasticCoords409_g251506 = ( 0.0 );
					float2 UV409_g251506 = ZY402_g251506;
					float2 UV1409_g251506 = float2( 0,0 );
					float2 UV2409_g251506 = float2( 0,0 );
					float2 UV3409_g251506 = float2( 0,0 );
					float3 Weights409_g251506 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g251506 , UV1409_g251506 , UV2409_g251506 , UV3409_g251506 , Weights409_g251506 );
					float4 appendResult433_g251506 = (float4(XY404_g251506 , UV1409_g251506));
					float4 In_MaskC431_g251506 = appendResult433_g251506;
					float4 appendResult434_g251506 = (float4(UV2409_g251506 , UV3409_g251506));
					float4 In_MaskD431_g251506 = appendResult434_g251506;
					float localComputeStochasticCoords422_g251506 = ( 0.0 );
					float2 UV422_g251506 = XZ403_g251506;
					float2 UV1422_g251506 = float2( 0,0 );
					float2 UV2422_g251506 = float2( 0,0 );
					float2 UV3422_g251506 = float2( 0,0 );
					float3 Weights422_g251506 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g251506 , UV1422_g251506 , UV2422_g251506 , UV3422_g251506 , Weights422_g251506 );
					float4 appendResult435_g251506 = (float4(UV1422_g251506 , UV2422_g251506));
					float4 In_MaskE431_g251506 = appendResult435_g251506;
					float localComputeStochasticCoords423_g251506 = ( 0.0 );
					float2 UV423_g251506 = XY404_g251506;
					float2 UV1423_g251506 = float2( 0,0 );
					float2 UV2423_g251506 = float2( 0,0 );
					float2 UV3423_g251506 = float2( 0,0 );
					float3 Weights423_g251506 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g251506 , UV1423_g251506 , UV2423_g251506 , UV3423_g251506 , Weights423_g251506 );
					float4 appendResult436_g251506 = (float4(UV3422_g251506 , UV1423_g251506));
					float4 In_MaskF431_g251506 = appendResult436_g251506;
					float4 appendResult437_g251506 = (float4(UV2423_g251506 , UV3423_g251506));
					float4 In_MaskG431_g251506 = appendResult437_g251506;
					float4 In_MaskH431_g251506 = float4( Weights409_g251506 , 0.0 );
					float4 In_MaskI431_g251506 = float4( Weights422_g251506 , 0.0 );
					float4 In_MaskJ431_g251506 = float4( Weights423_g251506 , 0.0 );
					half3 Model_NormalWS226_g251492 = Out_NormalWS15_g251505;
					float3 temp_output_449_0_g251506 = Model_NormalWS226_g251492;
					float4 In_MaskK431_g251506 = float4( temp_output_449_0_g251506 , 0.0 );
					half3 Model_TangentWS366_g251492 = Out_TangentWS15_g251505;
					float3 temp_output_450_0_g251506 = Model_TangentWS366_g251492;
					float4 In_MaskL431_g251506 = float4( temp_output_450_0_g251506 , 0.0 );
					half3 Model_BitangentWS367_g251492 = Out_BitangentWS15_g251505;
					float3 temp_output_451_0_g251506 = Model_BitangentWS367_g251492;
					float4 In_MaskM431_g251506 = float4( temp_output_451_0_g251506 , 0.0 );
					half3 Model_TriplanarWeights368_g251492 = Out_TriplanarWeights15_g251505;
					float3 temp_output_445_0_g251506 = Model_TriplanarWeights368_g251492;
					float4 In_MaskN431_g251506 = float4( temp_output_445_0_g251506 , 0.0 );
					BuildTextureData( Data431_g251506 , In_MaskA431_g251506 , In_MaskB431_g251506 , In_MaskC431_g251506 , In_MaskD431_g251506 , In_MaskE431_g251506 , In_MaskF431_g251506 , In_MaskG431_g251506 , In_MaskH431_g251506 , In_MaskI431_g251506 , In_MaskJ431_g251506 , In_MaskK431_g251506 , In_MaskL431_g251506 , In_MaskM431_g251506 , In_MaskN431_g251506 );
					TVEMasksData Data456_g251512 =(TVEMasksData)Data431_g251506;
					float4 Out_MaskA456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251512 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251512 , Out_MaskA456_g251512 , Out_MaskB456_g251512 , Out_MaskC456_g251512 , Out_MaskD456_g251512 , Out_MaskE456_g251512 , Out_MaskF456_g251512 , Out_MaskG456_g251512 , Out_MaskH456_g251512 , Out_MaskI456_g251512 , Out_MaskJ456_g251512 , Out_MaskK456_g251512 , Out_MaskL456_g251512 , Out_MaskM456_g251512 , Out_MaskN456_g251512 );
					half2 UV276_g251512 = (Out_MaskA456_g251512).xy;
					float temp_output_504_0_g251512 = 0.0;
					half Bias276_g251512 = temp_output_504_0_g251512;
					half2 Normal276_g251512 = float2( 0,0 );
					half4 localSampleCoord276_g251512 = SampleCoord( Texture276_g251512 , Sampler276_g251512 , UV276_g251512 , Bias276_g251512 , Normal276_g251512 );
					float4 temp_output_407_277_g251492 = localSampleCoord276_g251512;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251512) = _MainAlbedoTex;
					SamplerState Sampler502_g251512 = staticSwitch36_g251507;
					half2 UV502_g251512 = (Out_MaskA456_g251512).zw;
					half Bias502_g251512 = temp_output_504_0_g251512;
					half2 Normal502_g251512 = float2( 0,0 );
					half4 localSampleCoord502_g251512 = SampleCoord( Texture502_g251512 , Sampler502_g251512 , UV502_g251512 , Bias502_g251512 , Normal502_g251512 );
					float4 temp_output_407_278_g251492 = localSampleCoord502_g251512;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251512) = _MainAlbedoTex;
					SamplerState Sampler496_g251512 = staticSwitch36_g251507;
					float2 temp_output_463_0_g251512 = (Out_MaskB456_g251512).zw;
					half2 XZ496_g251512 = temp_output_463_0_g251512;
					half Bias496_g251512 = temp_output_504_0_g251512;
					float3 temp_output_483_0_g251512 = (Out_MaskK456_g251512).xyz;
					half3 NormalWS496_g251512 = temp_output_483_0_g251512;
					half3 Normal496_g251512 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251512 = SamplePlanar2D( Texture496_g251512 , Sampler496_g251512 , XZ496_g251512 , Bias496_g251512 , NormalWS496_g251512 , Normal496_g251512 );
					float4 temp_output_407_0_g251492 = localSamplePlanar2D496_g251512;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251512) = _MainAlbedoTex;
					SamplerState Sampler490_g251512 = staticSwitch36_g251507;
					float2 temp_output_462_0_g251512 = (Out_MaskB456_g251512).xy;
					half2 ZY490_g251512 = temp_output_462_0_g251512;
					half2 XZ490_g251512 = temp_output_463_0_g251512;
					float2 temp_output_464_0_g251512 = (Out_MaskC456_g251512).xy;
					half2 XY490_g251512 = temp_output_464_0_g251512;
					half Bias490_g251512 = temp_output_504_0_g251512;
					float3 temp_output_482_0_g251512 = (Out_MaskN456_g251512).xyz;
					half3 Triplanar490_g251512 = temp_output_482_0_g251512;
					half3 NormalWS490_g251512 = temp_output_483_0_g251512;
					half3 Normal490_g251512 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251512 = SamplePlanar3D( Texture490_g251512 , Sampler490_g251512 , ZY490_g251512 , XZ490_g251512 , XY490_g251512 , Bias490_g251512 , Triplanar490_g251512 , NormalWS490_g251512 , Normal490_g251512 );
					float4 temp_output_407_201_g251492 = localSamplePlanar3D490_g251512;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251512) = _MainAlbedoTex;
					SamplerState Sampler498_g251512 = staticSwitch36_g251507;
					half2 XZ498_g251512 = temp_output_463_0_g251512;
					float2 temp_output_473_0_g251512 = (Out_MaskE456_g251512).xy;
					half2 XZ_1498_g251512 = temp_output_473_0_g251512;
					float2 temp_output_474_0_g251512 = (Out_MaskE456_g251512).zw;
					half2 XZ_2498_g251512 = temp_output_474_0_g251512;
					float2 temp_output_475_0_g251512 = (Out_MaskF456_g251512).xy;
					half2 XZ_3498_g251512 = temp_output_475_0_g251512;
					float temp_output_510_0_g251512 = exp2( temp_output_504_0_g251512 );
					half Bias498_g251512 = temp_output_510_0_g251512;
					float3 temp_output_480_0_g251512 = (Out_MaskI456_g251512).xyz;
					half3 Weights_2498_g251512 = temp_output_480_0_g251512;
					half3 NormalWS498_g251512 = temp_output_483_0_g251512;
					half3 Normal498_g251512 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251512 = SampleStochastic2D( Texture498_g251512 , Sampler498_g251512 , XZ498_g251512 , XZ_1498_g251512 , XZ_2498_g251512 , XZ_3498_g251512 , Bias498_g251512 , Weights_2498_g251512 , NormalWS498_g251512 , Normal498_g251512 );
					float4 temp_output_407_202_g251492 = localSampleStochastic2D498_g251512;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251512) = _MainAlbedoTex;
					SamplerState Sampler500_g251512 = staticSwitch36_g251507;
					half2 ZY500_g251512 = temp_output_462_0_g251512;
					half2 ZY_1500_g251512 = (Out_MaskC456_g251512).zw;
					half2 ZY_2500_g251512 = (Out_MaskD456_g251512).xy;
					half2 ZY_3500_g251512 = (Out_MaskD456_g251512).zw;
					half2 XZ500_g251512 = temp_output_463_0_g251512;
					half2 XZ_1500_g251512 = temp_output_473_0_g251512;
					half2 XZ_2500_g251512 = temp_output_474_0_g251512;
					half2 XZ_3500_g251512 = temp_output_475_0_g251512;
					half2 XY500_g251512 = temp_output_464_0_g251512;
					half2 XY_1500_g251512 = (Out_MaskF456_g251512).zw;
					half2 XY_2500_g251512 = (Out_MaskG456_g251512).xy;
					half2 XY_3500_g251512 = (Out_MaskG456_g251512).zw;
					half Bias500_g251512 = temp_output_510_0_g251512;
					half3 Weights_1500_g251512 = (Out_MaskH456_g251512).xyz;
					half3 Weights_2500_g251512 = temp_output_480_0_g251512;
					half3 Weights_3500_g251512 = (Out_MaskJ456_g251512).xyz;
					half3 Triplanar500_g251512 = temp_output_482_0_g251512;
					half3 NormalWS500_g251512 = temp_output_483_0_g251512;
					half3 Normal500_g251512 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251512 = SampleStochastic3D( Texture500_g251512 , Sampler500_g251512 , ZY500_g251512 , ZY_1500_g251512 , ZY_2500_g251512 , ZY_3500_g251512 , XZ500_g251512 , XZ_1500_g251512 , XZ_2500_g251512 , XZ_3500_g251512 , XY500_g251512 , XY_1500_g251512 , XY_2500_g251512 , XY_3500_g251512 , Bias500_g251512 , Weights_1500_g251512 , Weights_2500_g251512 , Weights_3500_g251512 , Triplanar500_g251512 , NormalWS500_g251512 , Normal500_g251512 );
					float4 temp_output_407_203_g251492 = localSampleStochastic3D500_g251512;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g251492 = temp_output_407_277_g251492;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g251492 = temp_output_407_278_g251492;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g251492 = temp_output_407_0_g251492;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g251492 = temp_output_407_201_g251492;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g251492 = temp_output_407_202_g251492;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g251492 = temp_output_407_203_g251492;
					#else
					float4 staticSwitch184_g251492 = temp_output_407_277_g251492;
					#endif
					half4 Local_AlbedoSample185_g251492 = staticSwitch184_g251492;
					float3 lerpResult53_g251492 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g251492).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g251492 = lerpResult53_g251492;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251510) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g251509 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g251509 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g251509 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g251509 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g251509 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g251509 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251510 = staticSwitch38_g251509;
					float localBreakTextureData456_g251510 = ( 0.0 );
					TVEMasksData Data456_g251510 =(TVEMasksData)Data431_g251506;
					float4 Out_MaskA456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251510 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251510 , Out_MaskA456_g251510 , Out_MaskB456_g251510 , Out_MaskC456_g251510 , Out_MaskD456_g251510 , Out_MaskE456_g251510 , Out_MaskF456_g251510 , Out_MaskG456_g251510 , Out_MaskH456_g251510 , Out_MaskI456_g251510 , Out_MaskJ456_g251510 , Out_MaskK456_g251510 , Out_MaskL456_g251510 , Out_MaskM456_g251510 , Out_MaskN456_g251510 );
					half2 UV276_g251510 = (Out_MaskA456_g251510).xy;
					float temp_output_504_0_g251510 = 0.0;
					half Bias276_g251510 = temp_output_504_0_g251510;
					half2 Normal276_g251510 = float2( 0,0 );
					half4 localSampleCoord276_g251510 = SampleCoord( Texture276_g251510 , Sampler276_g251510 , UV276_g251510 , Bias276_g251510 , Normal276_g251510 );
					float4 temp_output_405_277_g251492 = localSampleCoord276_g251510;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251510) = _MainShaderTex;
					SamplerState Sampler502_g251510 = staticSwitch38_g251509;
					half2 UV502_g251510 = (Out_MaskA456_g251510).zw;
					half Bias502_g251510 = temp_output_504_0_g251510;
					half2 Normal502_g251510 = float2( 0,0 );
					half4 localSampleCoord502_g251510 = SampleCoord( Texture502_g251510 , Sampler502_g251510 , UV502_g251510 , Bias502_g251510 , Normal502_g251510 );
					float4 temp_output_405_278_g251492 = localSampleCoord502_g251510;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251510) = _MainShaderTex;
					SamplerState Sampler496_g251510 = staticSwitch38_g251509;
					float2 temp_output_463_0_g251510 = (Out_MaskB456_g251510).zw;
					half2 XZ496_g251510 = temp_output_463_0_g251510;
					half Bias496_g251510 = temp_output_504_0_g251510;
					float3 temp_output_483_0_g251510 = (Out_MaskK456_g251510).xyz;
					half3 NormalWS496_g251510 = temp_output_483_0_g251510;
					half3 Normal496_g251510 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251510 = SamplePlanar2D( Texture496_g251510 , Sampler496_g251510 , XZ496_g251510 , Bias496_g251510 , NormalWS496_g251510 , Normal496_g251510 );
					float4 temp_output_405_0_g251492 = localSamplePlanar2D496_g251510;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251510) = _MainShaderTex;
					SamplerState Sampler490_g251510 = staticSwitch38_g251509;
					float2 temp_output_462_0_g251510 = (Out_MaskB456_g251510).xy;
					half2 ZY490_g251510 = temp_output_462_0_g251510;
					half2 XZ490_g251510 = temp_output_463_0_g251510;
					float2 temp_output_464_0_g251510 = (Out_MaskC456_g251510).xy;
					half2 XY490_g251510 = temp_output_464_0_g251510;
					half Bias490_g251510 = temp_output_504_0_g251510;
					float3 temp_output_482_0_g251510 = (Out_MaskN456_g251510).xyz;
					half3 Triplanar490_g251510 = temp_output_482_0_g251510;
					half3 NormalWS490_g251510 = temp_output_483_0_g251510;
					half3 Normal490_g251510 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251510 = SamplePlanar3D( Texture490_g251510 , Sampler490_g251510 , ZY490_g251510 , XZ490_g251510 , XY490_g251510 , Bias490_g251510 , Triplanar490_g251510 , NormalWS490_g251510 , Normal490_g251510 );
					float4 temp_output_405_201_g251492 = localSamplePlanar3D490_g251510;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251510) = _MainShaderTex;
					SamplerState Sampler498_g251510 = staticSwitch38_g251509;
					half2 XZ498_g251510 = temp_output_463_0_g251510;
					float2 temp_output_473_0_g251510 = (Out_MaskE456_g251510).xy;
					half2 XZ_1498_g251510 = temp_output_473_0_g251510;
					float2 temp_output_474_0_g251510 = (Out_MaskE456_g251510).zw;
					half2 XZ_2498_g251510 = temp_output_474_0_g251510;
					float2 temp_output_475_0_g251510 = (Out_MaskF456_g251510).xy;
					half2 XZ_3498_g251510 = temp_output_475_0_g251510;
					float temp_output_510_0_g251510 = exp2( temp_output_504_0_g251510 );
					half Bias498_g251510 = temp_output_510_0_g251510;
					float3 temp_output_480_0_g251510 = (Out_MaskI456_g251510).xyz;
					half3 Weights_2498_g251510 = temp_output_480_0_g251510;
					half3 NormalWS498_g251510 = temp_output_483_0_g251510;
					half3 Normal498_g251510 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251510 = SampleStochastic2D( Texture498_g251510 , Sampler498_g251510 , XZ498_g251510 , XZ_1498_g251510 , XZ_2498_g251510 , XZ_3498_g251510 , Bias498_g251510 , Weights_2498_g251510 , NormalWS498_g251510 , Normal498_g251510 );
					float4 temp_output_405_202_g251492 = localSampleStochastic2D498_g251510;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251510) = _MainShaderTex;
					SamplerState Sampler500_g251510 = staticSwitch38_g251509;
					half2 ZY500_g251510 = temp_output_462_0_g251510;
					half2 ZY_1500_g251510 = (Out_MaskC456_g251510).zw;
					half2 ZY_2500_g251510 = (Out_MaskD456_g251510).xy;
					half2 ZY_3500_g251510 = (Out_MaskD456_g251510).zw;
					half2 XZ500_g251510 = temp_output_463_0_g251510;
					half2 XZ_1500_g251510 = temp_output_473_0_g251510;
					half2 XZ_2500_g251510 = temp_output_474_0_g251510;
					half2 XZ_3500_g251510 = temp_output_475_0_g251510;
					half2 XY500_g251510 = temp_output_464_0_g251510;
					half2 XY_1500_g251510 = (Out_MaskF456_g251510).zw;
					half2 XY_2500_g251510 = (Out_MaskG456_g251510).xy;
					half2 XY_3500_g251510 = (Out_MaskG456_g251510).zw;
					half Bias500_g251510 = temp_output_510_0_g251510;
					half3 Weights_1500_g251510 = (Out_MaskH456_g251510).xyz;
					half3 Weights_2500_g251510 = temp_output_480_0_g251510;
					half3 Weights_3500_g251510 = (Out_MaskJ456_g251510).xyz;
					half3 Triplanar500_g251510 = temp_output_482_0_g251510;
					half3 NormalWS500_g251510 = temp_output_483_0_g251510;
					half3 Normal500_g251510 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251510 = SampleStochastic3D( Texture500_g251510 , Sampler500_g251510 , ZY500_g251510 , ZY_1500_g251510 , ZY_2500_g251510 , ZY_3500_g251510 , XZ500_g251510 , XZ_1500_g251510 , XZ_2500_g251510 , XZ_3500_g251510 , XY500_g251510 , XY_1500_g251510 , XY_2500_g251510 , XY_3500_g251510 , Bias500_g251510 , Weights_1500_g251510 , Weights_2500_g251510 , Weights_3500_g251510 , Triplanar500_g251510 , NormalWS500_g251510 , Normal500_g251510 );
					float4 temp_output_405_203_g251492 = localSampleStochastic3D500_g251510;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g251492 = temp_output_405_277_g251492;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g251492 = temp_output_405_278_g251492;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g251492 = temp_output_405_0_g251492;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g251492 = temp_output_405_201_g251492;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g251492 = temp_output_405_202_g251492;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g251492 = temp_output_405_203_g251492;
					#else
					float4 staticSwitch198_g251492 = temp_output_405_277_g251492;
					#endif
					half4 Local_ShaderSample199_g251492 = staticSwitch198_g251492;
					float temp_output_209_0_g251492 = (Local_ShaderSample199_g251492).y;
					float temp_output_7_0_g251498 = _MainOcclusionRemap.x;
					float temp_output_9_0_g251498 = ( temp_output_209_0_g251492 - temp_output_7_0_g251498 );
					float lerpResult23_g251492 = lerp( 1.0 , saturate( ( temp_output_9_0_g251498 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g251492 = lerpResult23_g251492;
					float temp_output_213_0_g251492 = (Local_ShaderSample199_g251492).w;
					float temp_output_7_0_g251502 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g251502 = ( temp_output_213_0_g251492 - temp_output_7_0_g251502 );
					half Local_Smoothness317_g251492 = ( saturate( ( temp_output_9_0_g251502 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g251492 = (float4(( (Local_ShaderSample199_g251492).x * _MainMetallicValue ) , Local_Occlusion313_g251492 , (Local_ShaderSample199_g251492).z , Local_Smoothness317_g251492));
					half4 Local_Masks109_g251492 = appendResult73_g251492;
					float temp_output_135_0_g251492 = (Local_Masks109_g251492).z;
					float temp_output_7_0_g251497 = _MainMultiRemap.x;
					float temp_output_9_0_g251497 = ( temp_output_135_0_g251492 - temp_output_7_0_g251497 );
					float temp_output_42_0_g251492 = saturate( ( temp_output_9_0_g251497 * _MainMultiRemap.z ) );
					half Local_MultiMask78_g251492 = temp_output_42_0_g251492;
					float lerpResult58_g251492 = lerp( 1.0 , Local_MultiMask78_g251492 , _MainColorMode);
					float4 lerpResult62_g251492 = lerp( _MainColorTwo , _MainColor , lerpResult58_g251492);
					half3 Local_ColorRGB93_g251492 = (lerpResult62_g251492).rgb;
					half3 Local_Albedo139_g251492 = ( Local_AlbedoRGB107_g251492 * Local_ColorRGB93_g251492 );
					float3 temp_output_4_0_g251493 = Local_Albedo139_g251492;
					float3 In_Albedo3_g251493 = temp_output_4_0_g251493;
					float3 temp_output_44_0_g251493 = Local_Albedo139_g251492;
					float3 In_AlbedoBase3_g251493 = temp_output_44_0_g251493;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251511) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g251508 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g251508 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g251508 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g251508 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g251508 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g251508 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251511 = staticSwitch37_g251508;
					float localBreakTextureData456_g251511 = ( 0.0 );
					TVEMasksData Data456_g251511 =(TVEMasksData)Data431_g251506;
					float4 Out_MaskA456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251511 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251511 , Out_MaskA456_g251511 , Out_MaskB456_g251511 , Out_MaskC456_g251511 , Out_MaskD456_g251511 , Out_MaskE456_g251511 , Out_MaskF456_g251511 , Out_MaskG456_g251511 , Out_MaskH456_g251511 , Out_MaskI456_g251511 , Out_MaskJ456_g251511 , Out_MaskK456_g251511 , Out_MaskL456_g251511 , Out_MaskM456_g251511 , Out_MaskN456_g251511 );
					half2 UV276_g251511 = (Out_MaskA456_g251511).xy;
					float temp_output_504_0_g251511 = 0.0;
					half Bias276_g251511 = temp_output_504_0_g251511;
					half2 Normal276_g251511 = float2( 0,0 );
					half4 localSampleCoord276_g251511 = SampleCoord( Texture276_g251511 , Sampler276_g251511 , UV276_g251511 , Bias276_g251511 , Normal276_g251511 );
					float2 temp_output_406_394_g251492 = Normal276_g251511;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251511) = _MainNormalTex;
					SamplerState Sampler502_g251511 = staticSwitch37_g251508;
					half2 UV502_g251511 = (Out_MaskA456_g251511).zw;
					half Bias502_g251511 = temp_output_504_0_g251511;
					half2 Normal502_g251511 = float2( 0,0 );
					half4 localSampleCoord502_g251511 = SampleCoord( Texture502_g251511 , Sampler502_g251511 , UV502_g251511 , Bias502_g251511 , Normal502_g251511 );
					float2 temp_output_406_397_g251492 = Normal502_g251511;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251511) = _MainNormalTex;
					SamplerState Sampler496_g251511 = staticSwitch37_g251508;
					float2 temp_output_463_0_g251511 = (Out_MaskB456_g251511).zw;
					half2 XZ496_g251511 = temp_output_463_0_g251511;
					half Bias496_g251511 = temp_output_504_0_g251511;
					float3 temp_output_483_0_g251511 = (Out_MaskK456_g251511).xyz;
					half3 NormalWS496_g251511 = temp_output_483_0_g251511;
					half3 Normal496_g251511 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251511 = SamplePlanar2D( Texture496_g251511 , Sampler496_g251511 , XZ496_g251511 , Bias496_g251511 , NormalWS496_g251511 , Normal496_g251511 );
					float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
					float3 worldToTangentDir408_g251511 = normalize( mul( ase_worldToTangent, Normal496_g251511 ) );
					float2 temp_output_406_375_g251492 = (worldToTangentDir408_g251511).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251511) = _MainNormalTex;
					SamplerState Sampler490_g251511 = staticSwitch37_g251508;
					float2 temp_output_462_0_g251511 = (Out_MaskB456_g251511).xy;
					half2 ZY490_g251511 = temp_output_462_0_g251511;
					half2 XZ490_g251511 = temp_output_463_0_g251511;
					float2 temp_output_464_0_g251511 = (Out_MaskC456_g251511).xy;
					half2 XY490_g251511 = temp_output_464_0_g251511;
					half Bias490_g251511 = temp_output_504_0_g251511;
					float3 temp_output_482_0_g251511 = (Out_MaskN456_g251511).xyz;
					half3 Triplanar490_g251511 = temp_output_482_0_g251511;
					half3 NormalWS490_g251511 = temp_output_483_0_g251511;
					half3 Normal490_g251511 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251511 = SamplePlanar3D( Texture490_g251511 , Sampler490_g251511 , ZY490_g251511 , XZ490_g251511 , XY490_g251511 , Bias490_g251511 , Triplanar490_g251511 , NormalWS490_g251511 , Normal490_g251511 );
					float3 worldToTangentDir399_g251511 = normalize( mul( ase_worldToTangent, Normal490_g251511 ) );
					float2 temp_output_406_353_g251492 = (worldToTangentDir399_g251511).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251511) = _MainNormalTex;
					SamplerState Sampler498_g251511 = staticSwitch37_g251508;
					half2 XZ498_g251511 = temp_output_463_0_g251511;
					float2 temp_output_473_0_g251511 = (Out_MaskE456_g251511).xy;
					half2 XZ_1498_g251511 = temp_output_473_0_g251511;
					float2 temp_output_474_0_g251511 = (Out_MaskE456_g251511).zw;
					half2 XZ_2498_g251511 = temp_output_474_0_g251511;
					float2 temp_output_475_0_g251511 = (Out_MaskF456_g251511).xy;
					half2 XZ_3498_g251511 = temp_output_475_0_g251511;
					float temp_output_510_0_g251511 = exp2( temp_output_504_0_g251511 );
					half Bias498_g251511 = temp_output_510_0_g251511;
					float3 temp_output_480_0_g251511 = (Out_MaskI456_g251511).xyz;
					half3 Weights_2498_g251511 = temp_output_480_0_g251511;
					half3 NormalWS498_g251511 = temp_output_483_0_g251511;
					half3 Normal498_g251511 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251511 = SampleStochastic2D( Texture498_g251511 , Sampler498_g251511 , XZ498_g251511 , XZ_1498_g251511 , XZ_2498_g251511 , XZ_3498_g251511 , Bias498_g251511 , Weights_2498_g251511 , NormalWS498_g251511 , Normal498_g251511 );
					float3 worldToTangentDir411_g251511 = normalize( mul( ase_worldToTangent, Normal498_g251511 ) );
					float2 temp_output_406_391_g251492 = (worldToTangentDir411_g251511).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251511) = _MainNormalTex;
					SamplerState Sampler500_g251511 = staticSwitch37_g251508;
					half2 ZY500_g251511 = temp_output_462_0_g251511;
					half2 ZY_1500_g251511 = (Out_MaskC456_g251511).zw;
					half2 ZY_2500_g251511 = (Out_MaskD456_g251511).xy;
					half2 ZY_3500_g251511 = (Out_MaskD456_g251511).zw;
					half2 XZ500_g251511 = temp_output_463_0_g251511;
					half2 XZ_1500_g251511 = temp_output_473_0_g251511;
					half2 XZ_2500_g251511 = temp_output_474_0_g251511;
					half2 XZ_3500_g251511 = temp_output_475_0_g251511;
					half2 XY500_g251511 = temp_output_464_0_g251511;
					half2 XY_1500_g251511 = (Out_MaskF456_g251511).zw;
					half2 XY_2500_g251511 = (Out_MaskG456_g251511).xy;
					half2 XY_3500_g251511 = (Out_MaskG456_g251511).zw;
					half Bias500_g251511 = temp_output_510_0_g251511;
					half3 Weights_1500_g251511 = (Out_MaskH456_g251511).xyz;
					half3 Weights_2500_g251511 = temp_output_480_0_g251511;
					half3 Weights_3500_g251511 = (Out_MaskJ456_g251511).xyz;
					half3 Triplanar500_g251511 = temp_output_482_0_g251511;
					half3 NormalWS500_g251511 = temp_output_483_0_g251511;
					half3 Normal500_g251511 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251511 = SampleStochastic3D( Texture500_g251511 , Sampler500_g251511 , ZY500_g251511 , ZY_1500_g251511 , ZY_2500_g251511 , ZY_3500_g251511 , XZ500_g251511 , XZ_1500_g251511 , XZ_2500_g251511 , XZ_3500_g251511 , XY500_g251511 , XY_1500_g251511 , XY_2500_g251511 , XY_3500_g251511 , Bias500_g251511 , Weights_1500_g251511 , Weights_2500_g251511 , Weights_3500_g251511 , Triplanar500_g251511 , NormalWS500_g251511 , Normal500_g251511 );
					float3 worldToTangentDir403_g251511 = normalize( mul( ase_worldToTangent, Normal500_g251511 ) );
					float2 temp_output_406_390_g251492 = (worldToTangentDir403_g251511).xy;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g251492 = temp_output_406_394_g251492;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g251492 = temp_output_406_397_g251492;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g251492 = temp_output_406_375_g251492;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g251492 = temp_output_406_353_g251492;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g251492 = temp_output_406_391_g251492;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g251492 = temp_output_406_390_g251492;
					#else
					float2 staticSwitch193_g251492 = temp_output_406_394_g251492;
					#endif
					half2 Local_NormaSample191_g251492 = staticSwitch193_g251492;
					half2 Local_NormalTS108_g251492 = ( Local_NormaSample191_g251492 * _MainNormalValue );
					float2 In_NormalTS3_g251493 = Local_NormalTS108_g251492;
					float3 appendResult68_g251504 = (float3(Local_NormalTS108_g251492 , 1.0));
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal74_g251504 = appendResult68_g251504;
					float3 worldNormal74_g251504 = normalize( float3( dot( tanToWorld0, tanNormal74_g251504 ), dot( tanToWorld1, tanNormal74_g251504 ), dot( tanToWorld2, tanNormal74_g251504 ) ) );
					half3 Local_NormalWS250_g251492 = worldNormal74_g251504;
					float3 In_NormalWS3_g251493 = Local_NormalWS250_g251492;
					float4 In_Shader3_g251493 = Local_Masks109_g251492;
					float4 In_Feature3_g251493 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251493 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251493 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g251501 = Local_Albedo139_g251492;
					float dotResult20_g251501 = dot( temp_output_3_0_g251501 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g251492 = dotResult20_g251501;
					float temp_output_12_0_g251493 = Local_Grayscale110_g251492;
					float In_Grayscale3_g251493 = temp_output_12_0_g251493;
					float clampResult27_g251503 = clamp( saturate( ( Local_Grayscale110_g251492 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g251492 = clampResult27_g251503;
					float temp_output_16_0_g251493 = Local_Luminosity145_g251492;
					float In_Luminosity3_g251493 = temp_output_16_0_g251493;
					float In_MultiMask3_g251493 = Local_MultiMask78_g251492;
					float temp_output_187_0_g251492 = (Local_AlbedoSample185_g251492).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g251492 = ( temp_output_187_0_g251492 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g251492 = temp_output_187_0_g251492;
					#endif
					half Local_AlphaClip111_g251492 = staticSwitch236_g251492;
					float In_AlphaClip3_g251493 = Local_AlphaClip111_g251492;
					half Local_AlphaFade246_g251492 = (lerpResult62_g251492).a;
					float In_AlphaFade3_g251493 = Local_AlphaFade246_g251492;
					float3 temp_cast_20 = (1.0).xxx;
					float3 In_Translucency3_g251493 = temp_cast_20;
					float In_Transmission3_g251493 = 1.0;
					float In_Thickness3_g251493 = 0.0;
					float In_Diffusion3_g251493 = 0.0;
					float In_Depth3_g251493 = 0.0;
					BuildVisualData( Data3_g251493 , In_Dummy3_g251493 , In_Albedo3_g251493 , In_AlbedoBase3_g251493 , In_NormalTS3_g251493 , In_NormalWS3_g251493 , In_Shader3_g251493 , In_Feature3_g251493 , In_Season3_g251493 , In_Emissive3_g251493 , In_Grayscale3_g251493 , In_Luminosity3_g251493 , In_MultiMask3_g251493 , In_AlphaClip3_g251493 , In_AlphaFade3_g251493 , In_Translucency3_g251493 , In_Transmission3_g251493 , In_Thickness3_g251493 , In_Diffusion3_g251493 , In_Depth3_g251493 );
					TVEVisualData Data4_g251523 =(TVEVisualData)Data3_g251493;
					float Out_Dummy4_g251523 = 0.0;
					float3 Out_Albedo4_g251523 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251523 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251523 = float2( 0,0 );
					float3 Out_NormalWS4_g251523 = float3( 0,0,0 );
					float4 Out_Shader4_g251523 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251523 = float4( 0,0,0,0 );
					float4 Out_Season4_g251523 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251523 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251523 = 0.0;
					float Out_Grayscale4_g251523 = 0.0;
					float Out_Luminosity4_g251523 = 0.0;
					float Out_AlphaClip4_g251523 = 0.0;
					float Out_AlphaFade4_g251523 = 0.0;
					float3 Out_Translucency4_g251523 = float3( 0,0,0 );
					float Out_Transmission4_g251523 = 0.0;
					float Out_Thickness4_g251523 = 0.0;
					float Out_Diffusion4_g251523 = 0.0;
					float Out_Depth4_g251523 = 0.0;
					BreakVisualData( Data4_g251523 , Out_Dummy4_g251523 , Out_Albedo4_g251523 , Out_AlbedoBase4_g251523 , Out_NormalTS4_g251523 , Out_NormalWS4_g251523 , Out_Shader4_g251523 , Out_Feature4_g251523 , Out_Season4_g251523 , Out_Emissive4_g251523 , Out_MultiMask4_g251523 , Out_Grayscale4_g251523 , Out_Luminosity4_g251523 , Out_AlphaClip4_g251523 , Out_AlphaFade4_g251523 , Out_Translucency4_g251523 , Out_Transmission4_g251523 , Out_Thickness4_g251523 , Out_Diffusion4_g251523 , Out_Depth4_g251523 );
					float Alpha109_g251518 = Out_AlphaClip4_g251523;
					float lerpResult91_g251518 = lerp( 1.0 , Alpha109_g251518 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g251518 = lerp( 1.0 , lerpResult91_g251518 , Filter152_g251518);
					clip( lerpResult154_g251518 );
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

					o.Emission = ( lerpResult72_g251518 * lerpResult84_g251518 );
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
				#pragma shader_feature_local_vertex TVE_MOTION
				#pragma shader_feature_local_vertex TVE_MOTION_ELEMENT
				#pragma shader_feature_local TVE_LEGACY
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
				#if defined (TVE_MOTION) //Motion
					#define TVE_ROTATION_BEND //Motion
				#endif //Motion
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
				#define SAMPLE_TEXTURE3D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE3D_LOD(tex,samplerTex,coord,lod) tex3Dlod(tex,float4(coord,lod))
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
					float4 ase_texcoord9 : TEXCOORD9;
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
				uniform half _MotionCategory;
				uniform half _MotionEnd;
				uniform half _MotionPushInfo;
				uniform half4 TVE_WindParams;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MotionNoiseTex);
				uniform half _MotionSmallPivotValue;
				uniform half _MotionSmallPhaseValue;
				uniform half _MotionSmallTillingValue;
				uniform half4 TVE_MotionTimeParams;
				uniform half _MotionSmallSpeedValue;
				uniform half _MotionSmallNoiseValue;
				uniform half _MotionElementMode;
				uniform half4 TVE_WindEditor;
				uniform half _MotionIntensityValue;
				uniform half _MotionSmallDelayValue;
				uniform half _MotionSmallIntensityValue;
				uniform half _MotionSmallPushValue;
				uniform half _MotionSmallMaskMode;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MotionMaskTex);
				SamplerState sampler_MotionMaskTex;
				uniform half4 _MotionSmallMaskRemap;
				uniform half4 TVE_MotionValueParams;
				uniform half _MotionTinyIntensityValue;
				uniform half _MotionDistValue;
				uniform half _MotionTinyMaskMode;
				uniform half4 _MotionTinyMaskRemap;
				uniform half _MotionTinyTillingValue;
				uniform half _MotionTinySpeedValue;
				uniform half _MotionTinyNoiseValue;
				UNITY_DECLARE_TEX3D_NOSAMPLER(_NoiseTex3D);
				uniform half _MotionBasePivotValue;
				uniform half _MotionBasePhaseValue;
				uniform half _MotionBaseTillingValue;
				uniform half _MotionBaseSpeedValue;
				uniform half _MotionBaseNoiseValue;
				uniform half _MotionBaseIntensityValue;
				uniform half _MotionBaseDelayValue;
				uniform half _MotionBasePushValue;
				uniform half _MotionBaseMaskMode;
				uniform half4 _MotionBaseMaskRemap;
				uniform half _MotionHighlightValue;
				uniform half _motion_small_mode;
				uniform half4 _MotionHighlightColor;
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
				
				float2 DecodeFloatToVector2( float enc )
				{
					float2 result ;
					result.y = enc % 2048;
					result.x = floor(enc / 2048);
					return result / (2048 - 1);
				}
				
				float3 HSVToRGB( float3 c )
				{
					float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
					float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
					return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
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

					float localIfModelDataByShader26_g241935 = ( 0.0 );
					TVEModelData Data26_g241935 = (TVEModelData)0;
					TVEModelData Data16_g241848 =(TVEModelData)0;
					half Dummy207_g241838 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g241848 = Dummy207_g241838;
					float In_Dummy16_g241848 = temp_output_14_0_g241848;
					float3 PositionOS131_g241838 = v.vertex.xyz;
					float3 temp_output_4_0_g241848 = PositionOS131_g241838;
					float3 In_PositionOS16_g241848 = temp_output_4_0_g241848;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g241838 = ase_positionWS;
					float3 vertexToFrag73_g241838 = temp_output_104_7_g241838;
					float3 PositionWS122_g241838 = vertexToFrag73_g241838;
					float3 In_PositionWS16_g241848 = PositionWS122_g241838;
					float4x4 break19_g241841 = unity_ObjectToWorld;
					float3 appendResult20_g241841 = (float3(break19_g241841[ 0 ][ 3 ] , break19_g241841[ 1 ][ 3 ] , break19_g241841[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241838 = appendResult20_g241841;
					float4x4 break19_g241843 = unity_ObjectToWorld;
					float3 appendResult20_g241843 = (float3(break19_g241843[ 0 ][ 3 ] , break19_g241843[ 1 ][ 3 ] , break19_g241843[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g241839 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g241838 = PositionOS131_g241838;
					float3 appendResult234_g241838 = (float3(break233_g241838.x , 0.0 , break233_g241838.z));
					float3 break413_g241838 = PositionOS131_g241838;
					float3 appendResult414_g241838 = (float3(break413_g241838.x , break413_g241838.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g241845 = appendResult414_g241838;
					#else
					float3 staticSwitch65_g241845 = appendResult234_g241838;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g241838 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g241838 = appendResult60_g241839;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g241838 = staticSwitch65_g241845;
					#else
					float3 staticSwitch229_g241838 = _Vector0;
					#endif
					float3 PivotOS149_g241838 = staticSwitch229_g241838;
					float3 temp_output_122_0_g241843 = PivotOS149_g241838;
					float3 PivotsOnlyWS105_g241843 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g241843 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g241838 = ( appendResult20_g241843 + PivotsOnlyWS105_g241843 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g241838 = temp_output_340_7_g241838;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g241838 = temp_output_341_7_g241838;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g241838 = temp_output_341_7_g241838;
					#else
					float3 staticSwitch236_g241838 = temp_output_340_7_g241838;
					#endif
					float3 vertexToFrag76_g241838 = staticSwitch236_g241838;
					float3 PivotWS121_g241838 = vertexToFrag76_g241838;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241838 = ( PositionWS122_g241838 - PivotWS121_g241838 );
					#else
					float3 staticSwitch204_g241838 = PositionWS122_g241838;
					#endif
					float3 PositionWO132_g241838 = ( staticSwitch204_g241838 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241848 = PositionWO132_g241838;
					float3 In_PositionRawOS16_g241848 = PositionOS131_g241838;
					float3 In_PivotOS16_g241848 = PivotOS149_g241838;
					float3 In_PivotWS16_g241848 = PivotWS121_g241838;
					float3 PivotWO133_g241838 = ( PivotWS121_g241838 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241848 = PivotWO133_g241838;
					half3 NormalOS134_g241838 = v.normal;
					float3 temp_output_21_0_g241848 = NormalOS134_g241838;
					float3 In_NormalOS16_g241848 = temp_output_21_0_g241848;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g241838 = normalizedWorldNormal;
					float3 In_NormalWS16_g241848 = NormalWS95_g241838;
					float3 In_NormalRawOS16_g241848 = NormalOS134_g241838;
					half4 TangentlOS153_g241838 = v.tangent;
					float4 temp_output_6_0_g241848 = TangentlOS153_g241838;
					float4 In_TangentOS16_g241848 = temp_output_6_0_g241848;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g241838 = ase_tangentWS;
					float3 In_TangentWS16_g241848 = TangentWS136_g241838;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g241838 = ase_bitangentWS;
					float3 In_BitangentWS16_g241848 = BiangentWS421_g241838;
					float3 normalizeResult296_g241838 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241838 ) );
					half3 ViewDirWS169_g241838 = normalizeResult296_g241838;
					float3 In_ViewDirWS16_g241848 = ViewDirWS169_g241838;
					float4 appendResult397_g241838 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g241838 = appendResult397_g241838;
					float4 In_CoordsData16_g241848 = CoordsData398_g241838;
					half4 VertexMasks171_g241838 = v.ase_color;
					float4 In_VertexData16_g241848 = VertexMasks171_g241838;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241851 = (PositionOS131_g241838).z;
					#else
					float staticSwitch65_g241851 = (PositionOS131_g241838).y;
					#endif
					half Object_HeightValue267_g241838 = _ObjectHeightValue;
					half Bounds_HeightMask274_g241838 = saturate( ( staticSwitch65_g241851 / Object_HeightValue267_g241838 ) );
					half3 Position387_g241838 = PositionOS131_g241838;
					half Height387_g241838 = Object_HeightValue267_g241838;
					half Object_RadiusValue268_g241838 = _ObjectRadiusValue;
					half Radius387_g241838 = Object_RadiusValue268_g241838;
					half localCapsuleMaskYUp387_g241838 = CapsuleMaskYUp( Position387_g241838 , Height387_g241838 , Radius387_g241838 );
					half3 Position408_g241838 = PositionOS131_g241838;
					half Height408_g241838 = Object_HeightValue267_g241838;
					half Radius408_g241838 = Object_RadiusValue268_g241838;
					half localCapsuleMaskZUp408_g241838 = CapsuleMaskZUp( Position408_g241838 , Height408_g241838 , Radius408_g241838 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241856 = saturate( localCapsuleMaskZUp408_g241838 );
					#else
					float staticSwitch65_g241856 = saturate( localCapsuleMaskYUp387_g241838 );
					#endif
					half Bounds_SphereMask282_g241838 = staticSwitch65_g241856;
					float4 appendResult253_g241838 = (float4(Bounds_HeightMask274_g241838 , Bounds_SphereMask282_g241838 , 1.0 , 1.0));
					half4 MasksData254_g241838 = appendResult253_g241838;
					float4 In_MasksData16_g241848 = MasksData254_g241838;
					float temp_output_17_0_g241850 = _ObjectPhaseMode;
					float Option70_g241850 = temp_output_17_0_g241850;
					float4 temp_output_3_0_g241850 = v.ase_color;
					float4 Channel70_g241850 = temp_output_3_0_g241850;
					float localSwitchChannel470_g241850 = SwitchChannel4( Option70_g241850 , Channel70_g241850 );
					half Phase_Value372_g241838 = localSwitchChannel470_g241850;
					float3 break319_g241838 = PivotWO133_g241838;
					half Pivot_Position322_g241838 = ( break319_g241838.x + break319_g241838.z );
					half Phase_Position357_g241838 = ( Phase_Value372_g241838 + Pivot_Position322_g241838 );
					float temp_output_248_0_g241838 = frac( Phase_Position357_g241838 );
					float4 appendResult177_g241838 = (float4(( (frac( ( Phase_Position357_g241838 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g241838));
					half4 Phase_Data176_g241838 = appendResult177_g241838;
					float4 In_PhaseData16_g241848 = Phase_Data176_g241838;
					float4 In_TransformData16_g241848 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g241848 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g241848 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g241848 , In_Dummy16_g241848 , In_PositionOS16_g241848 , In_PositionWS16_g241848 , In_PositionWO16_g241848 , In_PositionRawOS16_g241848 , In_PivotOS16_g241848 , In_PivotWS16_g241848 , In_PivotWO16_g241848 , In_NormalOS16_g241848 , In_NormalWS16_g241848 , In_NormalRawOS16_g241848 , In_TangentOS16_g241848 , In_TangentWS16_g241848 , In_BitangentWS16_g241848 , In_ViewDirWS16_g241848 , In_CoordsData16_g241848 , In_VertexData16_g241848 , In_MasksData16_g241848 , In_PhaseData16_g241848 , In_TransformData16_g241848 , In_RotationData16_g241848 , In_InterpolatorA16_g241848 );
					TVEModelData DataDefault26_g241935 = Data16_g241848;
					TVEModelData DataGeneral26_g241935 = Data16_g241848;
					TVEModelData DataBlanket26_g241935 = Data16_g241848;
					TVEModelData DataImpostor26_g241935 = Data16_g241848;
					TVEModelData Data16_g241828 =(TVEModelData)0;
					half Dummy207_g241818 = 0.0;
					float temp_output_14_0_g241828 = Dummy207_g241818;
					float In_Dummy16_g241828 = temp_output_14_0_g241828;
					float3 PositionOS131_g241818 = v.vertex.xyz;
					float3 temp_output_4_0_g241828 = PositionOS131_g241818;
					float3 In_PositionOS16_g241828 = temp_output_4_0_g241828;
					float3 temp_output_104_7_g241818 = ase_positionWS;
					float3 PositionWS122_g241818 = temp_output_104_7_g241818;
					float3 In_PositionWS16_g241828 = PositionWS122_g241818;
					float4x4 break19_g241821 = unity_ObjectToWorld;
					float3 appendResult20_g241821 = (float3(break19_g241821[ 0 ][ 3 ] , break19_g241821[ 1 ][ 3 ] , break19_g241821[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241818 = appendResult20_g241821;
					float3 PivotWS121_g241818 = temp_output_340_7_g241818;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241818 = ( PositionWS122_g241818 - PivotWS121_g241818 );
					#else
					float3 staticSwitch204_g241818 = PositionWS122_g241818;
					#endif
					float3 PositionWO132_g241818 = ( staticSwitch204_g241818 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241828 = PositionWO132_g241818;
					float3 In_PositionRawOS16_g241828 = PositionOS131_g241818;
					float3 PivotOS149_g241818 = _Vector0;
					float3 In_PivotOS16_g241828 = PivotOS149_g241818;
					float3 In_PivotWS16_g241828 = PivotWS121_g241818;
					float3 PivotWO133_g241818 = ( PivotWS121_g241818 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241828 = PivotWO133_g241818;
					half3 NormalOS134_g241818 = v.normal;
					float3 temp_output_21_0_g241828 = NormalOS134_g241818;
					float3 In_NormalOS16_g241828 = temp_output_21_0_g241828;
					half3 NormalWS95_g241818 = normalizedWorldNormal;
					float3 In_NormalWS16_g241828 = NormalWS95_g241818;
					float3 In_NormalRawOS16_g241828 = NormalOS134_g241818;
					half4 TangentlOS153_g241818 = v.tangent;
					float4 temp_output_6_0_g241828 = TangentlOS153_g241818;
					float4 In_TangentOS16_g241828 = temp_output_6_0_g241828;
					half3 TangentWS136_g241818 = ase_tangentWS;
					float3 In_TangentWS16_g241828 = TangentWS136_g241818;
					half3 BiangentWS421_g241818 = ase_bitangentWS;
					float3 In_BitangentWS16_g241828 = BiangentWS421_g241818;
					float3 normalizeResult296_g241818 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241818 ) );
					half3 ViewDirWS169_g241818 = normalizeResult296_g241818;
					float3 In_ViewDirWS16_g241828 = ViewDirWS169_g241818;
					float4 appendResult397_g241818 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g241818 = appendResult397_g241818;
					float4 In_CoordsData16_g241828 = CoordsData398_g241818;
					half4 VertexMasks171_g241818 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241828 = VertexMasks171_g241818;
					half4 MasksData254_g241818 = float4( 0,0,0,0 );
					float4 In_MasksData16_g241828 = MasksData254_g241818;
					half4 Phase_Data176_g241818 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241828 = Phase_Data176_g241818;
					float4 In_TransformData16_g241828 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g241828 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g241828 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g241828 , In_Dummy16_g241828 , In_PositionOS16_g241828 , In_PositionWS16_g241828 , In_PositionWO16_g241828 , In_PositionRawOS16_g241828 , In_PivotOS16_g241828 , In_PivotWS16_g241828 , In_PivotWO16_g241828 , In_NormalOS16_g241828 , In_NormalWS16_g241828 , In_NormalRawOS16_g241828 , In_TangentOS16_g241828 , In_TangentWS16_g241828 , In_BitangentWS16_g241828 , In_ViewDirWS16_g241828 , In_CoordsData16_g241828 , In_VertexData16_g241828 , In_MasksData16_g241828 , In_PhaseData16_g241828 , In_TransformData16_g241828 , In_RotationData16_g241828 , In_InterpolatorA16_g241828 );
					TVEModelData DataTerrain26_g241935 = Data16_g241828;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g241935 = IsShaderType2637;
					{
					if (Type26_g241935 == 0 )
					{
					Data26_g241935 = DataDefault26_g241935;
					}
					else if (Type26_g241935 == 1 )
					{
					Data26_g241935 = DataGeneral26_g241935;
					}
					else if (Type26_g241935 == 2 )
					{
					Data26_g241935 = DataBlanket26_g241935;
					}
					else if (Type26_g241935 == 3 )
					{
					Data26_g241935 = DataImpostor26_g241935;
					}
					else if (Type26_g241935 == 4 )
					{
					Data26_g241935 = DataTerrain26_g241935;
					}
					}
					TVEModelData Data15_g251335 =(TVEModelData)Data26_g241935;
					float Out_Dummy15_g251335 = 0.0;
					float3 Out_PositionOS15_g251335 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251335 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251335 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251335 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251335 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251335 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251335 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251335 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251335 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251335 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251335 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251335 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251335 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251335 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251335 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251335 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251335 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251335 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251335 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251335 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251335 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251335 , Out_Dummy15_g251335 , Out_PositionOS15_g251335 , Out_PositionWS15_g251335 , Out_PositionWO15_g251335 , Out_PositionRawOS15_g251335 , Out_PivotOS15_g251335 , Out_PivotWS15_g251335 , Out_PivotWO15_g251335 , Out_NormalOS15_g251335 , Out_NormalWS15_g251335 , Out_NormalRawOS15_g251335 , Out_TangentOS15_g251335 , Out_TangentWS15_g251335 , Out_BitangentWS15_g251335 , Out_ViewDirWS15_g251335 , Out_CoordsData15_g251335 , Out_VertexData15_g251335 , Out_MasksData15_g251335 , Out_PhaseData15_g251335 , Out_TransformData15_g251335 , Out_RotationData15_g251335 , Out_InterpolatorA15_g251335 );
					TVEModelData Data16_g251337 =(TVEModelData)Data15_g251335;
					float temp_output_14_0_g251337 = 0.0;
					float In_Dummy16_g251337 = temp_output_14_0_g251337;
					float3 temp_output_219_24_g251334 = Out_PivotOS15_g251335;
					float3 temp_output_215_0_g251334 = ( Out_PositionOS15_g251335 - temp_output_219_24_g251334 );
					float3 temp_output_4_0_g251337 = temp_output_215_0_g251334;
					float3 In_PositionOS16_g251337 = temp_output_4_0_g251337;
					float3 In_PositionWS16_g251337 = Out_PositionWS15_g251335;
					float3 In_PositionWO16_g251337 = Out_PositionWO15_g251335;
					float3 In_PositionRawOS16_g251337 = Out_PositionRawOS15_g251335;
					float3 In_PivotOS16_g251337 = temp_output_219_24_g251334;
					float3 In_PivotWS16_g251337 = Out_PivotWS15_g251335;
					float3 In_PivotWO16_g251337 = Out_PivotWO15_g251335;
					float3 temp_output_21_0_g251337 = Out_NormalOS15_g251335;
					float3 In_NormalOS16_g251337 = temp_output_21_0_g251337;
					float3 In_NormalWS16_g251337 = Out_NormalWS15_g251335;
					float3 In_NormalRawOS16_g251337 = Out_NormalRawOS15_g251335;
					float4 temp_output_6_0_g251337 = Out_TangentOS15_g251335;
					float4 In_TangentOS16_g251337 = temp_output_6_0_g251337;
					float3 In_TangentWS16_g251337 = Out_TangentWS15_g251335;
					float3 In_BitangentWS16_g251337 = Out_BitangentWS15_g251335;
					float3 In_ViewDirWS16_g251337 = Out_ViewDirWS15_g251335;
					float4 In_CoordsData16_g251337 = Out_CoordsData15_g251335;
					float4 In_VertexData16_g251337 = Out_VertexData15_g251335;
					float4 In_MasksData16_g251337 = Out_MasksData15_g251335;
					float4 In_PhaseData16_g251337 = Out_PhaseData15_g251335;
					float4 In_TransformData16_g251337 = Out_TransformData15_g251335;
					float4 In_RotationData16_g251337 = Out_RotationData15_g251335;
					float4 In_InterpolatorA16_g251337 = Out_InterpolatorA15_g251335;
					BuildModelVertData( Data16_g251337 , In_Dummy16_g251337 , In_PositionOS16_g251337 , In_PositionWS16_g251337 , In_PositionWO16_g251337 , In_PositionRawOS16_g251337 , In_PivotOS16_g251337 , In_PivotWS16_g251337 , In_PivotWO16_g251337 , In_NormalOS16_g251337 , In_NormalWS16_g251337 , In_NormalRawOS16_g251337 , In_TangentOS16_g251337 , In_TangentWS16_g251337 , In_BitangentWS16_g251337 , In_ViewDirWS16_g251337 , In_CoordsData16_g251337 , In_VertexData16_g251337 , In_MasksData16_g251337 , In_PhaseData16_g251337 , In_TransformData16_g251337 , In_RotationData16_g251337 , In_InterpolatorA16_g251337 );
					TVEModelData Data15_g251366 =(TVEModelData)Data16_g251337;
					float Out_Dummy15_g251366 = 0.0;
					float3 Out_PositionOS15_g251366 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251366 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251366 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251366 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251366 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251366 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251366 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251366 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251366 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251366 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251366 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251366 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251366 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251366 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251366 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251366 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251366 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251366 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251366 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251366 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251366 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251366 , Out_Dummy15_g251366 , Out_PositionOS15_g251366 , Out_PositionWS15_g251366 , Out_PositionWO15_g251366 , Out_PositionRawOS15_g251366 , Out_PivotOS15_g251366 , Out_PivotWS15_g251366 , Out_PivotWO15_g251366 , Out_NormalOS15_g251366 , Out_NormalWS15_g251366 , Out_NormalRawOS15_g251366 , Out_TangentOS15_g251366 , Out_TangentWS15_g251366 , Out_BitangentWS15_g251366 , Out_ViewDirWS15_g251366 , Out_CoordsData15_g251366 , Out_VertexData15_g251366 , Out_MasksData15_g251366 , Out_PhaseData15_g251366 , Out_TransformData15_g251366 , Out_RotationData15_g251366 , Out_InterpolatorA15_g251366 );
					TVEModelData Data16_g251367 =(TVEModelData)Data15_g251366;
					half Dummy317_g251365 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g251367 = Dummy317_g251365;
					float In_Dummy16_g251367 = temp_output_14_0_g251367;
					float3 temp_output_4_0_g251367 = Out_PositionOS15_g251366;
					float3 In_PositionOS16_g251367 = temp_output_4_0_g251367;
					float3 In_PositionWS16_g251367 = Out_PositionWS15_g251366;
					float3 temp_output_314_17_g251365 = Out_PositionWO15_g251366;
					float3 In_PositionWO16_g251367 = temp_output_314_17_g251365;
					float3 In_PositionRawOS16_g251367 = Out_PositionRawOS15_g251366;
					float3 In_PivotOS16_g251367 = Out_PivotOS15_g251366;
					float3 In_PivotWS16_g251367 = Out_PivotWS15_g251366;
					float3 temp_output_314_19_g251365 = Out_PivotWO15_g251366;
					float3 In_PivotWO16_g251367 = temp_output_314_19_g251365;
					float3 temp_output_21_0_g251367 = Out_NormalOS15_g251366;
					float3 In_NormalOS16_g251367 = temp_output_21_0_g251367;
					float3 In_NormalWS16_g251367 = Out_NormalWS15_g251366;
					float3 In_NormalRawOS16_g251367 = Out_NormalRawOS15_g251366;
					float4 temp_output_6_0_g251367 = Out_TangentOS15_g251366;
					float4 In_TangentOS16_g251367 = temp_output_6_0_g251367;
					float3 In_TangentWS16_g251367 = Out_TangentWS15_g251366;
					float3 In_BitangentWS16_g251367 = Out_BitangentWS15_g251366;
					float3 In_ViewDirWS16_g251367 = Out_ViewDirWS15_g251366;
					float4 In_CoordsData16_g251367 = Out_CoordsData15_g251366;
					float4 temp_output_314_29_g251365 = Out_VertexData15_g251366;
					float4 In_VertexData16_g251367 = temp_output_314_29_g251365;
					float4 In_MasksData16_g251367 = Out_MasksData15_g251366;
					float4 In_PhaseData16_g251367 = Out_PhaseData15_g251366;
					half4 Model_TransformData356_g251365 = Out_TransformData15_g251366;
					float localBuildGlobalData204_g241858 = ( 0.0 );
					TVEGlobalData Data204_g241858 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g241858 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g241858 = Dummy211_g241858;
					float4 temp_output_589_164_g241858 = TVE_CoatParams;
					half4 Coat_Params596_g241858 = temp_output_589_164_g241858;
					float4 In_CoatParams204_g241858 = Coat_Params596_g241858;
					float4 temp_output_203_0_g241878 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g241817 = ( 0.0 );
					TVEModelData Data26_g241817 = (TVEModelData)0;
					TVEModelData Data16_g241846 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241846 = 0.0;
					float3 In_PositionWS16_g241846 = PositionWS122_g241838;
					float3 In_PositionWO16_g241846 = PositionWO132_g241838;
					float3 In_PivotWS16_g241846 = PivotWS121_g241838;
					float3 In_PivotWO16_g241846 = PivotWO133_g241838;
					float3 In_NormalWS16_g241846 = NormalWS95_g241838;
					float3 In_TangentWS16_g241846 = TangentWS136_g241838;
					float3 In_BitangentWS16_g241846 = BiangentWS421_g241838;
					half3 NormalWS427_g241838 = NormalWS95_g241838;
					half3 localComputeTriplanarWeights427_g241838 = ComputeTriplanarWeights( NormalWS427_g241838 );
					half3 TriplanarWeights429_g241838 = localComputeTriplanarWeights427_g241838;
					float3 In_TriplanarWeights16_g241846 = TriplanarWeights429_g241838;
					float3 In_ViewDirWS16_g241846 = ViewDirWS169_g241838;
					float4 In_CoordsData16_g241846 = CoordsData398_g241838;
					float4 In_VertexData16_g241846 = VertexMasks171_g241838;
					float4 In_PhaseData16_g241846 = Phase_Data176_g241838;
					BuildModelFragData( Data16_g241846 , In_Dummy16_g241846 , In_PositionWS16_g241846 , In_PositionWO16_g241846 , In_PivotWS16_g241846 , In_PivotWO16_g241846 , In_NormalWS16_g241846 , In_TangentWS16_g241846 , In_BitangentWS16_g241846 , In_TriplanarWeights16_g241846 , In_ViewDirWS16_g241846 , In_CoordsData16_g241846 , In_VertexData16_g241846 , In_PhaseData16_g241846 );
					TVEModelData DataDefault26_g241817 = Data16_g241846;
					TVEModelData DataGeneral26_g241817 = Data16_g241846;
					TVEModelData DataBlanket26_g241817 = Data16_g241846;
					TVEModelData DataImpostor26_g241817 = Data16_g241846;
					TVEModelData Data16_g241826 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241826 = 0.0;
					float3 In_PositionWS16_g241826 = PositionWS122_g241818;
					float3 In_PositionWO16_g241826 = PositionWO132_g241818;
					float3 In_PivotWS16_g241826 = PivotWS121_g241818;
					float3 In_PivotWO16_g241826 = PivotWO133_g241818;
					float3 In_NormalWS16_g241826 = NormalWS95_g241818;
					float3 In_TangentWS16_g241826 = TangentWS136_g241818;
					float3 In_BitangentWS16_g241826 = BiangentWS421_g241818;
					half3 NormalWS427_g241818 = NormalWS95_g241818;
					half3 localComputeTriplanarWeights427_g241818 = ComputeTriplanarWeights( NormalWS427_g241818 );
					half3 TriplanarWeights429_g241818 = localComputeTriplanarWeights427_g241818;
					float3 In_TriplanarWeights16_g241826 = TriplanarWeights429_g241818;
					float3 In_ViewDirWS16_g241826 = ViewDirWS169_g241818;
					float4 In_CoordsData16_g241826 = CoordsData398_g241818;
					float4 In_VertexData16_g241826 = VertexMasks171_g241818;
					float4 In_PhaseData16_g241826 = Phase_Data176_g241818;
					BuildModelFragData( Data16_g241826 , In_Dummy16_g241826 , In_PositionWS16_g241826 , In_PositionWO16_g241826 , In_PivotWS16_g241826 , In_PivotWO16_g241826 , In_NormalWS16_g241826 , In_TangentWS16_g241826 , In_BitangentWS16_g241826 , In_TriplanarWeights16_g241826 , In_ViewDirWS16_g241826 , In_CoordsData16_g241826 , In_VertexData16_g241826 , In_PhaseData16_g241826 );
					TVEModelData DataTerrain26_g241817 = Data16_g241826;
					float Type26_g241817 = IsShaderType2637;
					{
					if (Type26_g241817 == 0 )
					{
					Data26_g241817 = DataDefault26_g241817;
					}
					else if (Type26_g241817 == 1 )
					{
					Data26_g241817 = DataGeneral26_g241817;
					}
					else if (Type26_g241817 == 2 )
					{
					Data26_g241817 = DataBlanket26_g241817;
					}
					else if (Type26_g241817 == 3 )
					{
					Data26_g241817 = DataImpostor26_g241817;
					}
					else if (Type26_g241817 == 4 )
					{
					Data26_g241817 = DataTerrain26_g241817;
					}
					}
					TVEModelData Data15_g241934 =(TVEModelData)Data26_g241817;
					float Out_Dummy15_g241934 = 0.0;
					float3 Out_PositionWS15_g241934 = float3( 0,0,0 );
					float3 Out_PositionWO15_g241934 = float3( 0,0,0 );
					float3 Out_PivotWS15_g241934 = float3( 0,0,0 );
					float3 Out_PivotWO15_g241934 = float3( 0,0,0 );
					float3 Out_NormalWS15_g241934 = float3( 0,0,0 );
					float3 Out_TangentWS15_g241934 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g241934 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g241934 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g241934 = float3( 0,0,0 );
					float4 Out_CoordsData15_g241934 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g241934 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g241934 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g241934 , Out_Dummy15_g241934 , Out_PositionWS15_g241934 , Out_PositionWO15_g241934 , Out_PivotWS15_g241934 , Out_PivotWO15_g241934 , Out_NormalWS15_g241934 , Out_TangentWS15_g241934 , Out_BitangentWS15_g241934 , Out_TriplanarWeights15_g241934 , Out_ViewDirWS15_g241934 , Out_CoordsData15_g241934 , Out_VertexData15_g241934 , Out_PhaseData15_g241934 );
					float3 Model_PositionWS497_g241858 = Out_PositionWS15_g241934;
					float2 Model_PositionWS_XZ143_g241858 = (Model_PositionWS497_g241858).xz;
					float3 Model_PivotWS498_g241858 = Out_PivotWS15_g241934;
					float2 Model_PivotWS_XZ145_g241858 = (Model_PivotWS498_g241858).xz;
					float2 lerpResult300_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g241878 = lerpResult300_g241858;
					float temp_output_82_0_g241876 = _GlobalCoatLayerValue;
					float temp_output_82_0_g241878 = temp_output_82_0_g241876;
					float4 tex2DArrayNode83_g241878 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241878).zw + ( (temp_output_203_0_g241878).xy * temp_output_81_0_g241878 ) ),temp_output_82_0_g241878), 0.0 );
					float4 appendResult210_g241878 = (float4(tex2DArrayNode83_g241878.rgb , saturate( tex2DArrayNode83_g241878.a )));
					float4 temp_output_204_0_g241878 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g241878 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241878).zw + ( (temp_output_204_0_g241878).xy * temp_output_81_0_g241878 ) ),temp_output_82_0_g241878), 0.0 );
					float4 appendResult212_g241878 = (float4(tex2DArrayNode122_g241878.rgb , saturate( tex2DArrayNode122_g241878.a )));
					float4 TVE_RenderNearPositionR628_g241858 = TVE_RenderNearPositionR;
					float temp_output_507_0_g241858 = saturate( ( distance( Model_PositionWS497_g241858 , (TVE_RenderNearPositionR628_g241858).xyz ) / (TVE_RenderNearPositionR628_g241858).w ) );
					float temp_output_7_0_g241859 = 1.0;
					float temp_output_9_0_g241859 = ( temp_output_507_0_g241858 - temp_output_7_0_g241859 );
					half TVE_RenderNearFadeValue635_g241858 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g241858 = saturate( ( temp_output_9_0_g241859 / ( ( TVE_RenderNearFadeValue635_g241858 - temp_output_7_0_g241859 ) + 0.0001 ) ) );
					float4 lerpResult131_g241878 = lerp( appendResult210_g241878 , appendResult212_g241878 , Global_TexBlend509_g241858);
					float4 temp_output_159_109_g241876 = lerpResult131_g241878;
					float4 lerpResult168_g241876 = lerp( TVE_CoatParams , temp_output_159_109_g241876 , TVE_CoatLayers[(int)temp_output_82_0_g241876]);
					float4 temp_output_589_109_g241858 = lerpResult168_g241876;
					half4 Coat_Texture302_g241858 = temp_output_589_109_g241858;
					float4 In_CoatTexture204_g241858 = Coat_Texture302_g241858;
					float4 temp_output_595_164_g241858 = TVE_PaintParams;
					half4 Paint_Params575_g241858 = temp_output_595_164_g241858;
					float4 In_PaintParams204_g241858 = Paint_Params575_g241858;
					float4 temp_output_203_0_g241927 = TVE_PaintBaseCoord;
					float2 lerpResult85_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g241927 = lerpResult85_g241858;
					float temp_output_82_0_g241924 = _GlobalPaintLayerValue;
					float temp_output_82_0_g241927 = temp_output_82_0_g241924;
					float4 tex2DArrayNode83_g241927 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241927).zw + ( (temp_output_203_0_g241927).xy * temp_output_81_0_g241927 ) ),temp_output_82_0_g241927), 0.0 );
					float4 appendResult210_g241927 = (float4(tex2DArrayNode83_g241927.rgb , saturate( tex2DArrayNode83_g241927.a )));
					float4 temp_output_204_0_g241927 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g241927 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241927).zw + ( (temp_output_204_0_g241927).xy * temp_output_81_0_g241927 ) ),temp_output_82_0_g241927), 0.0 );
					float4 appendResult212_g241927 = (float4(tex2DArrayNode122_g241927.rgb , saturate( tex2DArrayNode122_g241927.a )));
					float4 lerpResult131_g241927 = lerp( appendResult210_g241927 , appendResult212_g241927 , Global_TexBlend509_g241858);
					float4 temp_output_171_109_g241924 = lerpResult131_g241927;
					float4 lerpResult174_g241924 = lerp( TVE_PaintParams , temp_output_171_109_g241924 , TVE_PaintLayers[(int)temp_output_82_0_g241924]);
					float4 temp_output_595_109_g241858 = lerpResult174_g241924;
					half4 Paint_Texture71_g241858 = temp_output_595_109_g241858;
					float4 In_PaintTexture204_g241858 = Paint_Texture71_g241858;
					float4 temp_output_590_141_g241858 = TVE_AtmoParams;
					half4 Atmo_Params601_g241858 = temp_output_590_141_g241858;
					float4 In_AtmoParams204_g241858 = Atmo_Params601_g241858;
					float4 temp_output_203_0_g241886 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g241886 = lerpResult104_g241858;
					float temp_output_132_0_g241884 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g241886 = temp_output_132_0_g241884;
					float4 tex2DArrayNode83_g241886 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241886).zw + ( (temp_output_203_0_g241886).xy * temp_output_81_0_g241886 ) ),temp_output_82_0_g241886), 0.0 );
					float4 appendResult210_g241886 = (float4(tex2DArrayNode83_g241886.rgb , saturate( tex2DArrayNode83_g241886.a )));
					float4 temp_output_204_0_g241886 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g241886 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241886).zw + ( (temp_output_204_0_g241886).xy * temp_output_81_0_g241886 ) ),temp_output_82_0_g241886), 0.0 );
					float4 appendResult212_g241886 = (float4(tex2DArrayNode122_g241886.rgb , saturate( tex2DArrayNode122_g241886.a )));
					float4 lerpResult131_g241886 = lerp( appendResult210_g241886 , appendResult212_g241886 , Global_TexBlend509_g241858);
					float4 temp_output_137_109_g241884 = lerpResult131_g241886;
					float4 lerpResult145_g241884 = lerp( TVE_AtmoParams , temp_output_137_109_g241884 , TVE_AtmoLayers[(int)temp_output_132_0_g241884]);
					float4 temp_output_590_110_g241858 = lerpResult145_g241884;
					half4 Atmo_Texture80_g241858 = temp_output_590_110_g241858;
					float4 In_AtmoTexture204_g241858 = Atmo_Texture80_g241858;
					float4 temp_output_593_163_g241858 = TVE_GlowParams;
					half4 Glow_Params609_g241858 = temp_output_593_163_g241858;
					float4 In_GlowParams204_g241858 = Glow_Params609_g241858;
					float4 temp_output_203_0_g241902 = TVE_GlowBaseCoord;
					float2 lerpResult247_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g241902 = lerpResult247_g241858;
					float temp_output_82_0_g241900 = _GlobalGlowLayerValue;
					float temp_output_82_0_g241902 = temp_output_82_0_g241900;
					float4 tex2DArrayNode83_g241902 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241902).zw + ( (temp_output_203_0_g241902).xy * temp_output_81_0_g241902 ) ),temp_output_82_0_g241902), 0.0 );
					float4 appendResult210_g241902 = (float4(tex2DArrayNode83_g241902.rgb , saturate( tex2DArrayNode83_g241902.a )));
					float4 temp_output_204_0_g241902 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g241902 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241902).zw + ( (temp_output_204_0_g241902).xy * temp_output_81_0_g241902 ) ),temp_output_82_0_g241902), 0.0 );
					float4 appendResult212_g241902 = (float4(tex2DArrayNode122_g241902.rgb , saturate( tex2DArrayNode122_g241902.a )));
					float4 lerpResult131_g241902 = lerp( appendResult210_g241902 , appendResult212_g241902 , Global_TexBlend509_g241858);
					float4 temp_output_159_109_g241900 = lerpResult131_g241902;
					float4 lerpResult167_g241900 = lerp( TVE_GlowParams , temp_output_159_109_g241900 , TVE_GlowLayers[(int)temp_output_82_0_g241900]);
					float4 temp_output_593_109_g241858 = lerpResult167_g241900;
					half4 Glow_Texture248_g241858 = temp_output_593_109_g241858;
					float4 In_GlowTexture204_g241858 = Glow_Texture248_g241858;
					float4 temp_output_592_139_g241858 = TVE_FormParams;
					float4 Form_Params606_g241858 = temp_output_592_139_g241858;
					float4 In_FormParams204_g241858 = Form_Params606_g241858;
					float4 temp_output_203_0_g241918 = TVE_FormBaseCoord;
					float2 lerpResult168_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g241918 = lerpResult168_g241858;
					float temp_output_130_0_g241916 = _GlobalFormLayerValue;
					float temp_output_82_0_g241918 = temp_output_130_0_g241916;
					float4 tex2DArrayNode83_g241918 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241918).zw + ( (temp_output_203_0_g241918).xy * temp_output_81_0_g241918 ) ),temp_output_82_0_g241918), 0.0 );
					float4 appendResult210_g241918 = (float4(tex2DArrayNode83_g241918.rgb , saturate( tex2DArrayNode83_g241918.a )));
					float4 temp_output_204_0_g241918 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g241918 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241918).zw + ( (temp_output_204_0_g241918).xy * temp_output_81_0_g241918 ) ),temp_output_82_0_g241918), 0.0 );
					float4 appendResult212_g241918 = (float4(tex2DArrayNode122_g241918.rgb , saturate( tex2DArrayNode122_g241918.a )));
					float4 lerpResult131_g241918 = lerp( appendResult210_g241918 , appendResult212_g241918 , Global_TexBlend509_g241858);
					float4 temp_output_135_109_g241916 = lerpResult131_g241918;
					float4 lerpResult143_g241916 = lerp( TVE_FormParams , temp_output_135_109_g241916 , TVE_FormLayers[(int)temp_output_130_0_g241916]);
					float4 temp_output_592_0_g241858 = lerpResult143_g241916;
					float4 Form_Texture112_g241858 = temp_output_592_0_g241858;
					float4 In_FormTexture204_g241858 = Form_Texture112_g241858;
					float4 temp_output_594_145_g241858 = TVE_FlowParams;
					half4 Flow_Params612_g241858 = temp_output_594_145_g241858;
					float4 In_FlowParams204_g241858 = Flow_Params612_g241858;
					float4 temp_output_203_0_g241910 = TVE_FlowBaseCoord;
					float2 lerpResult400_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g241910 = lerpResult400_g241858;
					float temp_output_136_0_g241908 = _GlobalFlowLayerValue;
					float temp_output_82_0_g241910 = temp_output_136_0_g241908;
					float4 tex2DArrayNode83_g241910 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241910).zw + ( (temp_output_203_0_g241910).xy * temp_output_81_0_g241910 ) ),temp_output_82_0_g241910), 0.0 );
					float4 appendResult210_g241910 = (float4(tex2DArrayNode83_g241910.rgb , saturate( tex2DArrayNode83_g241910.a )));
					float4 temp_output_204_0_g241910 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g241910 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241910).zw + ( (temp_output_204_0_g241910).xy * temp_output_81_0_g241910 ) ),temp_output_82_0_g241910), 0.0 );
					float4 appendResult212_g241910 = (float4(tex2DArrayNode122_g241910.rgb , saturate( tex2DArrayNode122_g241910.a )));
					float4 lerpResult131_g241910 = lerp( appendResult210_g241910 , appendResult212_g241910 , Global_TexBlend509_g241858);
					float4 temp_output_141_109_g241908 = lerpResult131_g241910;
					float4 lerpResult149_g241908 = lerp( TVE_FlowParams , temp_output_141_109_g241908 , TVE_FlowLayers[(int)temp_output_136_0_g241908]);
					half4 Flow_Texture405_g241858 = lerpResult149_g241908;
					float4 In_FlowTexture204_g241858 = Flow_Texture405_g241858;
					BuildGlobalData( Data204_g241858 , In_Dummy204_g241858 , In_CoatParams204_g241858 , In_CoatTexture204_g241858 , In_PaintParams204_g241858 , In_PaintTexture204_g241858 , In_AtmoParams204_g241858 , In_AtmoTexture204_g241858 , In_GlowParams204_g241858 , In_GlowTexture204_g241858 , In_FormParams204_g241858 , In_FormTexture204_g241858 , In_FlowParams204_g241858 , In_FlowTexture204_g241858 );
					TVEGlobalData Data15_g251368 =(TVEGlobalData)Data204_g241858;
					float Out_Dummy15_g251368 = 0.0;
					float4 Out_CoatParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251368 = float4( 0,0,0,0 );
					BreakData( Data15_g251368 , Out_Dummy15_g251368 , Out_CoatParams15_g251368 , Out_CoatTexture15_g251368 , Out_PaintParams15_g251368 , Out_PaintTexture15_g251368 , Out_AtmoParams15_g251368 , Out_AtmoTexture15_g251368 , Out_GlowParams15_g251368 , Out_GlowTexture15_g251368 , Out_FormParams15_g251368 , Out_FormTexture15_g251368 , Out_FlowParams15_g251368 , Out_FlowTexture15_g251368 );
					float4 Global_FormTexture351_g251365 = Out_FormTexture15_g251368;
					float3 Model_PivotWO353_g251365 = temp_output_314_19_g251365;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251374 = _ConformMeshMode;
					float Option70_g251374 = temp_output_17_0_g251374;
					half4 Model_VertexData357_g251365 = temp_output_314_29_g251365;
					float4 temp_output_3_0_g251374 = Model_VertexData357_g251365;
					float4 Channel70_g251374 = temp_output_3_0_g251374;
					float localSwitchChannel470_g251374 = SwitchChannel4( Option70_g251374 , Channel70_g251374 );
					float temp_output_390_0_g251365 = localSwitchChannel470_g251374;
					float temp_output_7_0_g251371 = _ConformMeshRemap.x;
					float temp_output_9_0_g251371 = ( temp_output_390_0_g251365 - temp_output_7_0_g251371 );
					float lerpResult374_g251365 = lerp( 1.0 , saturate( ( temp_output_9_0_g251371 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251365 = lerpResult374_g251365;
					float temp_output_328_0_g251365 = ( Blend_VertMask379_g251365 * TVE_IsEnabled );
					half Conform_Mask366_g251365 = temp_output_328_0_g251365;
					float temp_output_322_0_g251365 = ( ( ( ( (Global_FormTexture351_g251365).z - ( (Model_PivotWO353_g251365).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251365 ) );
					float3 appendResult329_g251365 = (float3(0.0 , temp_output_322_0_g251365 , 0.0));
					float3 appendResult387_g251365 = (float3(0.0 , 0.0 , temp_output_322_0_g251365));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251372 = appendResult387_g251365;
					#else
					float3 staticSwitch65_g251372 = appendResult329_g251365;
					#endif
					float3 Blanket_Conform368_g251365 = staticSwitch65_g251372;
					float4 appendResult312_g251365 = (float4(Blanket_Conform368_g251365 , 0.0));
					float4 temp_output_310_0_g251365 = ( Model_TransformData356_g251365 + appendResult312_g251365 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251365 = temp_output_310_0_g251365;
					#else
					float4 staticSwitch364_g251365 = Model_TransformData356_g251365;
					#endif
					half4 Final_TransformData365_g251365 = staticSwitch364_g251365;
					float4 In_TransformData16_g251367 = Final_TransformData365_g251365;
					float4 In_RotationData16_g251367 = Out_RotationData15_g251366;
					float4 In_InterpolatorA16_g251367 = Out_InterpolatorA15_g251366;
					BuildModelVertData( Data16_g251367 , In_Dummy16_g251367 , In_PositionOS16_g251367 , In_PositionWS16_g251367 , In_PositionWO16_g251367 , In_PositionRawOS16_g251367 , In_PivotOS16_g251367 , In_PivotWS16_g251367 , In_PivotWO16_g251367 , In_NormalOS16_g251367 , In_NormalWS16_g251367 , In_NormalRawOS16_g251367 , In_TangentOS16_g251367 , In_TangentWS16_g251367 , In_BitangentWS16_g251367 , In_ViewDirWS16_g251367 , In_CoordsData16_g251367 , In_VertexData16_g251367 , In_MasksData16_g251367 , In_PhaseData16_g251367 , In_TransformData16_g251367 , In_RotationData16_g251367 , In_InterpolatorA16_g251367 );
					TVEModelData Data15_g251424 =(TVEModelData)Data16_g251367;
					float Out_Dummy15_g251424 = 0.0;
					float3 Out_PositionOS15_g251424 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251424 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251424 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251424 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251424 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251424 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251424 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251424 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251424 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251424 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251424 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251424 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251424 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251424 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251424 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251424 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251424 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251424 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251424 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251424 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251424 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251424 , Out_Dummy15_g251424 , Out_PositionOS15_g251424 , Out_PositionWS15_g251424 , Out_PositionWO15_g251424 , Out_PositionRawOS15_g251424 , Out_PivotOS15_g251424 , Out_PivotWS15_g251424 , Out_PivotWO15_g251424 , Out_NormalOS15_g251424 , Out_NormalWS15_g251424 , Out_NormalRawOS15_g251424 , Out_TangentOS15_g251424 , Out_TangentWS15_g251424 , Out_BitangentWS15_g251424 , Out_ViewDirWS15_g251424 , Out_CoordsData15_g251424 , Out_VertexData15_g251424 , Out_MasksData15_g251424 , Out_PhaseData15_g251424 , Out_TransformData15_g251424 , Out_RotationData15_g251424 , Out_InterpolatorA15_g251424 );
					TVEModelData Data16_g251423 =(TVEModelData)Data15_g251424;
					half Dummy181_g251422 = ( ( _MotionCategory + _MotionEnd ) + _MotionPushInfo );
					float temp_output_14_0_g251423 = Dummy181_g251422;
					float In_Dummy16_g251423 = temp_output_14_0_g251423;
					float3 temp_output_2772_0_g251422 = Out_PositionOS15_g251424;
					float3 temp_output_4_0_g251423 = temp_output_2772_0_g251422;
					float3 In_PositionOS16_g251423 = temp_output_4_0_g251423;
					float3 temp_output_2772_16_g251422 = Out_PositionWS15_g251424;
					float3 In_PositionWS16_g251423 = temp_output_2772_16_g251422;
					float3 temp_output_2772_17_g251422 = Out_PositionWO15_g251424;
					float3 In_PositionWO16_g251423 = temp_output_2772_17_g251422;
					float3 In_PositionRawOS16_g251423 = Out_PositionRawOS15_g251424;
					float3 temp_output_2772_24_g251422 = Out_PivotOS15_g251424;
					float3 In_PivotOS16_g251423 = temp_output_2772_24_g251422;
					float3 In_PivotWS16_g251423 = Out_PivotWS15_g251424;
					float3 temp_output_2772_19_g251422 = Out_PivotWO15_g251424;
					float3 In_PivotWO16_g251423 = temp_output_2772_19_g251422;
					float3 temp_output_2772_20_g251422 = Out_NormalOS15_g251424;
					float3 temp_output_21_0_g251423 = temp_output_2772_20_g251422;
					float3 In_NormalOS16_g251423 = temp_output_21_0_g251423;
					float3 In_NormalWS16_g251423 = Out_NormalWS15_g251424;
					float3 In_NormalRawOS16_g251423 = Out_NormalRawOS15_g251424;
					float4 temp_output_6_0_g251423 = Out_TangentOS15_g251424;
					float4 In_TangentOS16_g251423 = temp_output_6_0_g251423;
					float3 In_TangentWS16_g251423 = Out_TangentWS15_g251424;
					float3 In_BitangentWS16_g251423 = Out_BitangentWS15_g251424;
					float3 In_ViewDirWS16_g251423 = Out_ViewDirWS15_g251424;
					float4 In_CoordsData16_g251423 = Out_CoordsData15_g251424;
					float4 temp_output_2772_29_g251422 = Out_VertexData15_g251424;
					float4 In_VertexData16_g251423 = temp_output_2772_29_g251422;
					float4 temp_output_2772_30_g251422 = Out_MasksData15_g251424;
					float4 In_MasksData16_g251423 = temp_output_2772_30_g251422;
					float4 temp_output_2772_27_g251422 = Out_PhaseData15_g251424;
					float4 In_PhaseData16_g251423 = temp_output_2772_27_g251422;
					half4 Model_TransformData2743_g251422 = Out_TransformData15_g251424;
					float3 temp_cast_11 = (0.0).xxx;
					float2 lerpResult3113_g251422 = lerp( (half4( 0, 1, 0.5, 1 )).xy , (TVE_WindParams).xy , TVE_IsEnabled);
					float2 Global_WindDirWS2542_g251422 = lerpResult3113_g251422;
					half2 Input_WindDirWS803_g251473 = Global_WindDirWS2542_g251422;
					float3 Model_PositionWO162_g251422 = temp_output_2772_17_g251422;
					half3 Input_ModelPositionWO761_g251426 = Model_PositionWO162_g251422;
					float3 Model_PivotWO402_g251422 = temp_output_2772_19_g251422;
					half3 Input_ModelPivotsWO419_g251426 = Model_PivotWO402_g251422;
					half Input_MotionPivots629_g251426 = _MotionSmallPivotValue;
					float3 lerpResult771_g251426 = lerp( Input_ModelPositionWO761_g251426 , Input_ModelPivotsWO419_g251426 , Input_MotionPivots629_g251426);
					half4 Model_PhaseData489_g251422 = temp_output_2772_27_g251422;
					half4 Input_ModelMotionData763_g251426 = Model_PhaseData489_g251422;
					half Input_MotionPhase764_g251426 = _MotionSmallPhaseValue;
					float temp_output_770_0_g251426 = ( (Input_ModelMotionData763_g251426).x * Input_MotionPhase764_g251426 );
					half3 Small_Position1421_g251422 = ( lerpResult771_g251426 + temp_output_770_0_g251426 );
					half3 Input_PositionWO419_g251473 = Small_Position1421_g251422;
					half Input_MotionTilling321_g251473 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g251473 = ( -(Input_PositionWO419_g251473).xz * Input_MotionTilling321_g251473 * 0.005 );
					float2 temp_output_3_0_g251474 = Noise_Coord979_g251473;
					float2 temp_output_21_0_g251474 = Input_WindDirWS803_g251473;
					float mulTime113_g251477 = _Time.y * 0.02;
					float lerpResult128_g251477 = lerp( mulTime113_g251477 , ( ( mulTime113_g251477 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g251473 = _MotionSmallSpeedValue;
					half Noise_Speed980_g251473 = ( lerpResult128_g251477 * Input_MotionSpeed62_g251473 );
					float temp_output_15_0_g251474 = Noise_Speed980_g251473;
					float temp_output_23_0_g251474 = frac( temp_output_15_0_g251474 );
					float4 lerpResult39_g251474 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g251474 + ( temp_output_21_0_g251474 * temp_output_23_0_g251474 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g251474 + ( temp_output_21_0_g251474 * frac( ( temp_output_15_0_g251474 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g251474 - 0.5 ) ) / 0.5 ));
					float4 temp_output_991_0_g251473 = lerpResult39_g251474;
					half2 Noise_DirWS858_g251473 = ((temp_output_991_0_g251473).rg*2.0 + -1.0);
					half Input_MotionNoise552_g251473 = _MotionSmallNoiseValue;
					TVEGlobalData Data15_g251436 =(TVEGlobalData)Data204_g241858;
					float Out_Dummy15_g251436 = 0.0;
					float4 Out_CoatParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251436 = float4( 0,0,0,0 );
					BreakData( Data15_g251436 , Out_Dummy15_g251436 , Out_CoatParams15_g251436 , Out_CoatTexture15_g251436 , Out_PaintParams15_g251436 , Out_PaintTexture15_g251436 , Out_AtmoParams15_g251436 , Out_AtmoTexture15_g251436 , Out_GlowParams15_g251436 , Out_GlowTexture15_g251436 , Out_FormParams15_g251436 , Out_FormTexture15_g251436 , Out_FlowParams15_g251436 , Out_FlowTexture15_g251436 );
					half4 Global_FlowParams3052_g251422 = Out_FlowParams15_g251436;
					half4 Global_FlowTexture2668_g251422 = Out_FlowTexture15_g251436;
					#ifdef TVE_MOTION_ELEMENT
					float4 staticSwitch3075_g251422 = Global_FlowTexture2668_g251422;
					#else
					float4 staticSwitch3075_g251422 = Global_FlowParams3052_g251422;
					#endif
					float4 temp_output_6_0_g251438 = staticSwitch3075_g251422;
					float temp_output_7_0_g251438 = _MotionElementMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251438 = ( temp_output_6_0_g251438 + temp_output_7_0_g251438 );
					#else
					float4 staticSwitch14_g251438 = temp_output_6_0_g251438;
					#endif
					float4 lerpResult3121_g251422 = lerp( half4( 0, 0, 0, 1 ) , staticSwitch14_g251438 , TVE_IsEnabled);
					float temp_output_630_0_g251451 = saturate( (lerpResult3121_g251422).w );
					float lerpResult853_g251451 = lerp( temp_output_630_0_g251451 , saturate( (temp_output_630_0_g251451*TVE_WindEditor.x + TVE_WindEditor.y) ) , TVE_WindEditor.w);
					half Global_WindValue1855_g251422 = ( lerpResult853_g251451 * _MotionIntensityValue );
					half Input_WindValue881_g251473 = Global_WindValue1855_g251422;
					float temp_output_6_0_g251479 = Input_WindValue881_g251473;
					float lerpResult701_g251473 = lerp( 1.0 , Input_MotionNoise552_g251473 , ( temp_output_6_0_g251479 * temp_output_6_0_g251479 ));
					float2 lerpResult646_g251473 = lerp( Input_WindDirWS803_g251473 , Noise_DirWS858_g251473 , lerpResult701_g251473);
					half2 Small_DirWS817_g251473 = lerpResult646_g251473;
					float2 break823_g251473 = Small_DirWS817_g251473;
					half4 Noise_Params685_g251473 = temp_output_991_0_g251473;
					half Wind_Sinus820_g251473 = ( ((Noise_Params685_g251473).b*2.0 + -1.0) * 0.6 );
					float3 appendResult824_g251473 = (float3(break823_g251473.x , Wind_Sinus820_g251473 , break823_g251473.y));
					half3 Small_Dir918_g251473 = appendResult824_g251473;
					float temp_output_20_0_g251478 = ( 1.0 - Input_WindValue881_g251473 );
					float3 appendResult1006_g251473 = (float3(Input_WindValue881_g251473 , ( 1.0 - ( temp_output_20_0_g251478 * temp_output_20_0_g251478 ) ) , Input_WindValue881_g251473));
					half Input_MotionDelay753_g251473 = _MotionSmallDelayValue;
					float lerpResult756_g251473 = lerp( 1.0 , ( Input_WindValue881_g251473 * Input_WindValue881_g251473 ) , Input_MotionDelay753_g251473);
					half Wind_Delay815_g251473 = lerpResult756_g251473;
					half Input_MotionValue905_g251473 = _MotionSmallIntensityValue;
					float3 temp_output_883_0_g251473 = ( Small_Dir918_g251473 * appendResult1006_g251473 * Wind_Delay815_g251473 * Input_MotionValue905_g251473 );
					float2 break857_g251473 = Noise_DirWS858_g251473;
					float3 appendResult833_g251473 = (float3(break857_g251473.x , Wind_Sinus820_g251473 , break857_g251473.y));
					half3 Push_Dir919_g251473 = appendResult833_g251473;
					half Input_MotionReact924_g251473 = _MotionSmallPushValue;
					float2 temp_output_3126_0_g251422 = ((lerpResult3121_g251422).xy*2.0 + -1.0);
					half Global_PushAlpha1504_g251422 = length( temp_output_3126_0_g251422 );
					half Input_PushAlpha806_g251473 = Global_PushAlpha1504_g251422;
					half Global_PushNoise2675_g251422 = (lerpResult3121_g251422).z;
					half Input_PushNoise890_g251473 = Global_PushNoise2675_g251422;
					half Push_Mask914_g251473 = saturate( ( Input_PushAlpha806_g251473 * Input_PushNoise890_g251473 * Input_MotionReact924_g251473 ) );
					float3 lerpResult840_g251473 = lerp( temp_output_883_0_g251473 , ( Push_Dir919_g251473 * Input_MotionReact924_g251473 ) , Push_Mask914_g251473);
					#ifdef TVE_MOTION_ELEMENT
					float3 staticSwitch829_g251473 = lerpResult840_g251473;
					#else
					float3 staticSwitch829_g251473 = temp_output_883_0_g251473;
					#endif
					float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
					half3 Small_Squash1489_g251422 = ( mul( unity_WorldToObject, float4( staticSwitch829_g251473 , 0.0 ) ).xyz * ase_parentObjectScale );
					float temp_output_17_0_g251461 = _MotionSmallMaskMode;
					float Option83_g251461 = temp_output_17_0_g251461;
					half4 Model_VertexMasks518_g251422 = temp_output_2772_29_g251422;
					float4 ChannelA83_g251461 = Model_VertexMasks518_g251422;
					half4 Model_MasksData1322_g251422 = temp_output_2772_30_g251422;
					float2 uv_MotionMaskTex2818_g251422 = v.texcoord.xyzw.xy;
					half4 Motion_MaskTex2819_g251422 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g251422, 0.0 );
					float4 appendResult3227_g251422 = (float4((Model_MasksData1322_g251422).xy , (Motion_MaskTex2819_g251422).g , 0.0));
					float4 ChannelB83_g251461 = appendResult3227_g251422;
					float localSwitchChannel883_g251461 = SwitchChannel8( Option83_g251461 , ChannelA83_g251461 , ChannelB83_g251461 );
					float enc1805_g251422 = v.texcoord.xyzw.z;
					float2 localDecodeFloatToVector21805_g251422 = DecodeFloatToVector2( enc1805_g251422 );
					float2 break1804_g251422 = localDecodeFloatToVector21805_g251422;
					half Small_Mask_Legacy1806_g251422 = break1804_g251422.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g251422 = Small_Mask_Legacy1806_g251422;
					#else
					float staticSwitch1800_g251422 = localSwitchChannel883_g251461;
					#endif
					float clampResult17_g251427 = clamp( staticSwitch1800_g251422 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251428 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g251428 = ( clampResult17_g251427 - temp_output_7_0_g251428 );
					half Small_Mask640_g251422 = saturate( ( temp_output_9_0_g251428 * _MotionSmallMaskRemap.z ) );
					float3 lerpResult3022_g251422 = lerp( float3( 1,1,1 ) , (TVE_MotionValueParams).xyz , TVE_MotionValueParams.w);
					half3 Global_MotionParams3013_g251422 = lerpResult3022_g251422;
					half3 Small_Motion789_g251422 = ( Small_Squash1489_g251422 * Small_Mask640_g251422 * (Global_MotionParams3013_g251422).y );
					#ifdef TVE_MOTION
					float3 staticSwitch495_g251422 = Small_Motion789_g251422;
					#else
					float3 staticSwitch495_g251422 = temp_cast_11;
					#endif
					float3 temp_cast_14 = (0.0).xxx;
					float3 Model_PositionWS1819_g251422 = temp_output_2772_16_g251422;
					half Global_DistMask1820_g251422 = ( 1.0 - saturate( ( distance( _WorldSpaceCameraPos , Model_PositionWS1819_g251422 ) / _MotionDistValue ) ) );
					float temp_output_17_0_g251462 = _MotionTinyMaskMode;
					float Option83_g251462 = temp_output_17_0_g251462;
					float4 ChannelA83_g251462 = Model_VertexMasks518_g251422;
					float4 appendResult3234_g251422 = (float4((Model_MasksData1322_g251422).xy , (Motion_MaskTex2819_g251422).b , 0.0));
					float4 ChannelB83_g251462 = appendResult3234_g251422;
					float localSwitchChannel883_g251462 = SwitchChannel8( Option83_g251462 , ChannelA83_g251462 , ChannelB83_g251462 );
					half Tiny_Mask_Legacy1807_g251422 = break1804_g251422.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g251422 = Tiny_Mask_Legacy1807_g251422;
					#else
					float staticSwitch1810_g251422 = localSwitchChannel883_g251462;
					#endif
					float clampResult17_g251429 = clamp( staticSwitch1810_g251422 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251430 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g251430 = ( clampResult17_g251429 - temp_output_7_0_g251430 );
					half Tiny_Mask218_g251422 = saturate( ( temp_output_9_0_g251430 * _MotionTinyMaskRemap.z ) );
					half3 Model_NormalOS554_g251422 = temp_output_2772_20_g251422;
					half3 Input_NormalOS533_g251444 = Model_NormalOS554_g251422;
					half3 Tiny_Position2469_g251422 = Model_PositionWO162_g251422;
					half3 Input_PositionWO500_g251444 = Tiny_Position2469_g251422;
					half Input_MotionTilling321_g251444 = ( _MotionTinyTillingValue + 0.1 );
					float lerpResult128_g251449 = lerp( _Time.y , ( ( _Time.y * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g251444 = _MotionTinySpeedValue;
					float4 tex2DNode514_g251444 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( ( (Input_PositionWO500_g251444).xz * Input_MotionTilling321_g251444 * 0.005 ) + ( lerpResult128_g251449 * Input_MotionSpeed62_g251444 * 0.02 ) ), 0.0 );
					half3 Flutter_Noise535_g251444 = (tex2DNode514_g251444.rgb*2.0 + -1.0);
					half Input_MotionNoise542_g251444 = _MotionTinyNoiseValue;
					float3 lerpResult537_g251444 = lerp( ( Input_NormalOS533_g251444 * Flutter_Noise535_g251444 ) , Flutter_Noise535_g251444 , Input_MotionNoise542_g251444);
					float mulTime113_g251450 = _Time.y * 2.0;
					float lerpResult128_g251450 = lerp( mulTime113_g251450 , ( ( mulTime113_g251450 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					float temp_output_578_0_g251444 = SAMPLE_TEXTURE3D_LOD( _NoiseTex3D, sampler_Linear_Repeat, ( ( Input_PositionWO500_g251444 + lerpResult128_g251450 ) * ( 1.0 * 0.01 ) ), 0.0 ).r;
					half Input_GlobalWind471_g251444 = Global_WindValue1855_g251422;
					float lerpResult579_g251444 = lerp( ( temp_output_578_0_g251444 * temp_output_578_0_g251444 * temp_output_578_0_g251444 * temp_output_578_0_g251444 ) , temp_output_578_0_g251444 , ( Input_GlobalWind471_g251444 * Input_GlobalWind471_g251444 ));
					float temp_output_20_0_g251448 = ( 1.0 - Input_GlobalWind471_g251444 );
					half Wind_Gust589_g251444 = ( ( lerpResult579_g251444 * ( 1.0 - ( temp_output_20_0_g251448 * temp_output_20_0_g251448 * temp_output_20_0_g251448 * temp_output_20_0_g251448 ) ) ) * 0.5 );
					half3 Tiny_Squash859_g251422 = ( lerpResult537_g251444 * Wind_Gust589_g251444 );
					half3 Tiny_Flutter1451_g251422 = ( _MotionTinyIntensityValue * Global_DistMask1820_g251422 * Tiny_Mask218_g251422 * Tiny_Squash859_g251422 * (Global_MotionParams3013_g251422).z );
					#ifdef TVE_MOTION
					float3 staticSwitch414_g251422 = Tiny_Flutter1451_g251422;
					#else
					float3 staticSwitch414_g251422 = temp_cast_14;
					#endif
					float4 appendResult2783_g251422 = (float4(( staticSwitch495_g251422 + staticSwitch414_g251422 ) , 0.0));
					half4 Final_TransformData1569_g251422 = ( Model_TransformData2743_g251422 + appendResult2783_g251422 );
					float4 In_TransformData16_g251423 = Final_TransformData1569_g251422;
					half4 Model_RotationData2740_g251422 = Out_RotationData15_g251424;
					half2 Input_WindDirWS803_g251463 = Global_WindDirWS2542_g251422;
					half3 Input_ModelPositionWO761_g251425 = Model_PositionWO162_g251422;
					half3 Input_ModelPivotsWO419_g251425 = Model_PivotWO402_g251422;
					half Input_MotionPivots629_g251425 = _MotionBasePivotValue;
					float3 lerpResult771_g251425 = lerp( Input_ModelPositionWO761_g251425 , Input_ModelPivotsWO419_g251425 , Input_MotionPivots629_g251425);
					half4 Input_ModelMotionData763_g251425 = Model_PhaseData489_g251422;
					half Input_MotionPhase764_g251425 = _MotionBasePhaseValue;
					float temp_output_770_0_g251425 = ( (Input_ModelMotionData763_g251425).x * Input_MotionPhase764_g251425 );
					half3 Base_Position1394_g251422 = ( lerpResult771_g251425 + temp_output_770_0_g251425 );
					half3 Input_PositionWO419_g251463 = Base_Position1394_g251422;
					half Input_MotionTilling321_g251463 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g251463 = ( -(Input_PositionWO419_g251463).xz * Input_MotionTilling321_g251463 * 0.005 );
					float2 temp_output_3_0_g251470 = Noise_Coord515_g251463;
					float2 temp_output_21_0_g251470 = Input_WindDirWS803_g251463;
					float mulTime113_g251464 = _Time.y * 0.02;
					float lerpResult128_g251464 = lerp( mulTime113_g251464 , ( ( mulTime113_g251464 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g251463 = _MotionBaseSpeedValue;
					half Noise_Speed516_g251463 = ( lerpResult128_g251464 * Input_MotionSpeed62_g251463 );
					float temp_output_15_0_g251470 = Noise_Speed516_g251463;
					float temp_output_23_0_g251470 = frac( temp_output_15_0_g251470 );
					float4 lerpResult39_g251470 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g251470 + ( temp_output_21_0_g251470 * temp_output_23_0_g251470 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g251470 + ( temp_output_21_0_g251470 * frac( ( temp_output_15_0_g251470 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g251470 - 0.5 ) ) / 0.5 ));
					float4 temp_output_635_0_g251463 = lerpResult39_g251470;
					half2 Noise_DirWS825_g251463 = ((temp_output_635_0_g251463).rg*2.0 + -1.0);
					half Input_MotionNoise552_g251463 = _MotionBaseNoiseValue;
					half Input_WindValue853_g251463 = Global_WindValue1855_g251422;
					float temp_output_6_0_g251467 = Input_WindValue853_g251463;
					float lerpResult701_g251463 = lerp( 1.0 , Input_MotionNoise552_g251463 , ( temp_output_6_0_g251467 * temp_output_6_0_g251467 ));
					half Input_PushNoise858_g251463 = Global_PushNoise2675_g251422;
					float2 lerpResult646_g251463 = lerp( Input_WindDirWS803_g251463 , Noise_DirWS825_g251463 , saturate( ( lerpResult701_g251463 + Input_PushNoise858_g251463 ) ));
					half2 Bend_Dir859_g251463 = lerpResult646_g251463;
					half Input_MotionValue871_g251463 = _MotionBaseIntensityValue;
					half Input_MotionDelay753_g251463 = _MotionBaseDelayValue;
					float lerpResult756_g251463 = lerp( 1.0 , ( Input_WindValue853_g251463 * Input_WindValue853_g251463 ) , Input_MotionDelay753_g251463);
					half Wind_Delay815_g251463 = lerpResult756_g251463;
					float2 temp_output_875_0_g251463 = ( Bend_Dir859_g251463 * Input_WindValue853_g251463 * Input_MotionValue871_g251463 * Wind_Delay815_g251463 );
					float2 Global_PushDirWS1972_g251422 = temp_output_3126_0_g251422;
					half2 Input_PushDirWS807_g251463 = Global_PushDirWS1972_g251422;
					half Input_ReactValue888_g251463 = _MotionBasePushValue;
					half Input_PushAlpha806_g251463 = Global_PushAlpha1504_g251422;
					half Push_Mask883_g251463 = saturate( ( Input_PushAlpha806_g251463 * Input_ReactValue888_g251463 ) );
					float2 lerpResult811_g251463 = lerp( temp_output_875_0_g251463 , ( Input_PushDirWS807_g251463 * Input_ReactValue888_g251463 ) , Push_Mask883_g251463);
					#ifdef TVE_MOTION_ELEMENT
					float2 staticSwitch808_g251463 = lerpResult811_g251463;
					#else
					float2 staticSwitch808_g251463 = temp_output_875_0_g251463;
					#endif
					float2 temp_output_38_0_g251468 = staticSwitch808_g251463;
					float2 break83_g251468 = temp_output_38_0_g251468;
					float3 appendResult79_g251468 = (float3(break83_g251468.x , 0.0 , break83_g251468.y));
					half2 Base_Bending893_g251422 = (( mul( unity_WorldToObject, float4( appendResult79_g251468 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
					float temp_output_17_0_g251460 = _MotionBaseMaskMode;
					float Option83_g251460 = temp_output_17_0_g251460;
					float4 ChannelA83_g251460 = Model_VertexMasks518_g251422;
					float4 appendResult3220_g251422 = (float4((Model_MasksData1322_g251422).xy , (Motion_MaskTex2819_g251422).r , 0.0));
					float4 ChannelB83_g251460 = appendResult3220_g251422;
					float localSwitchChannel883_g251460 = SwitchChannel8( Option83_g251460 , ChannelA83_g251460 , ChannelB83_g251460 );
					float clampResult17_g251432 = clamp( localSwitchChannel883_g251460 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251431 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g251431 = ( clampResult17_g251432 - temp_output_7_0_g251431 );
					half Base_Mask217_g251422 = saturate( ( temp_output_9_0_g251431 * _MotionBaseMaskRemap.z ) );
					half2 Base_Motion1440_g251422 = ( Base_Bending893_g251422 * Base_Mask217_g251422 * (Global_MotionParams3013_g251422).x );
					#ifdef TVE_MOTION
					float2 staticSwitch2384_g251422 = Base_Motion1440_g251422;
					#else
					float2 staticSwitch2384_g251422 = float2( 0,0 );
					#endif
					float4 appendResult2023_g251422 = (float4(staticSwitch2384_g251422 , 0.0 , 0.0));
					half4 Final_RotationData1570_g251422 = ( Model_RotationData2740_g251422 + appendResult2023_g251422 );
					float4 In_RotationData16_g251423 = Final_RotationData1570_g251422;
					half4 Model_Interpolator02773_g251422 = Out_InterpolatorA15_g251424;
					half4 Noise_Params685_g251463 = temp_output_635_0_g251463;
					float temp_output_6_0_g251466 = (Noise_Params685_g251463).a;
					float temp_output_913_0_g251463 = ( ( temp_output_6_0_g251466 * temp_output_6_0_g251466 * temp_output_6_0_g251466 * temp_output_6_0_g251466 ) * ( Input_WindValue853_g251463 * Wind_Delay815_g251463 ) );
					float temp_output_6_0_g251465 = length( Input_PushDirWS807_g251463 );
					float lerpResult902_g251463 = lerp( temp_output_913_0_g251463 , ( ( temp_output_6_0_g251465 * temp_output_6_0_g251465 ) * Input_PushNoise858_g251463 ) , Push_Mask883_g251463);
					#ifdef TVE_MOTION_ELEMENT
					float staticSwitch903_g251463 = lerpResult902_g251463;
					#else
					float staticSwitch903_g251463 = temp_output_913_0_g251463;
					#endif
					half Base_Wave1159_g251422 = staticSwitch903_g251463;
					float temp_output_6_0_g251480 = (Noise_Params685_g251473).a;
					float temp_output_955_0_g251473 = ( temp_output_6_0_g251480 * temp_output_6_0_g251480 * temp_output_6_0_g251480 * temp_output_6_0_g251480 );
					float temp_output_944_0_g251473 = ( temp_output_955_0_g251473 * ( Input_WindValue881_g251473 * Wind_Delay815_g251473 ) );
					float lerpResult936_g251473 = lerp( temp_output_944_0_g251473 , ( temp_output_955_0_g251473 * Input_PushNoise890_g251473 ) , Push_Mask914_g251473);
					#ifdef TVE_MOTION_ELEMENT
					float staticSwitch939_g251473 = lerpResult936_g251473;
					#else
					float staticSwitch939_g251473 = temp_output_944_0_g251473;
					#endif
					half Small_Wave1427_g251422 = staticSwitch939_g251473;
					float lerpResult2422_g251422 = lerp( Base_Wave1159_g251422 , Small_Wave1427_g251422 , _motion_small_mode);
					half Global_Wave1475_g251422 = saturate( lerpResult2422_g251422 );
					float temp_output_6_0_g251433 = ( _MotionHighlightValue * Global_DistMask1820_g251422 * ( Tiny_Mask218_g251422 * Tiny_Mask218_g251422 ) * Global_Wave1475_g251422 );
					float temp_output_7_0_g251433 = _MotionHighlightColor.r;
					#ifdef TVE_DUMMY
					float staticSwitch14_g251433 = ( temp_output_6_0_g251433 + temp_output_7_0_g251433 );
					#else
					float staticSwitch14_g251433 = temp_output_6_0_g251433;
					#endif
					#ifdef TVE_MOTION
					float staticSwitch2866_g251422 = staticSwitch14_g251433;
					#else
					float staticSwitch2866_g251422 = 0.0;
					#endif
					float4 appendResult2775_g251422 = (float4((Model_Interpolator02773_g251422).xyz , staticSwitch2866_g251422));
					half4 Final_Interpolator02774_g251422 = appendResult2775_g251422;
					float4 In_InterpolatorA16_g251423 = Final_Interpolator02774_g251422;
					BuildModelVertData( Data16_g251423 , In_Dummy16_g251423 , In_PositionOS16_g251423 , In_PositionWS16_g251423 , In_PositionWO16_g251423 , In_PositionRawOS16_g251423 , In_PivotOS16_g251423 , In_PivotWS16_g251423 , In_PivotWO16_g251423 , In_NormalOS16_g251423 , In_NormalWS16_g251423 , In_NormalRawOS16_g251423 , In_TangentOS16_g251423 , In_TangentWS16_g251423 , In_BitangentWS16_g251423 , In_ViewDirWS16_g251423 , In_CoordsData16_g251423 , In_VertexData16_g251423 , In_MasksData16_g251423 , In_PhaseData16_g251423 , In_TransformData16_g251423 , In_RotationData16_g251423 , In_InterpolatorA16_g251423 );
					TVEModelData Data15_g251482 =(TVEModelData)Data16_g251423;
					float Out_Dummy15_g251482 = 0.0;
					float3 Out_PositionOS15_g251482 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251482 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251482 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251482 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251482 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251482 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251482 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251482 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251482 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251482 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251482 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251482 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251482 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251482 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251482 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251482 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251482 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251482 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251482 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251482 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251482 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251482 , Out_Dummy15_g251482 , Out_PositionOS15_g251482 , Out_PositionWS15_g251482 , Out_PositionWO15_g251482 , Out_PositionRawOS15_g251482 , Out_PivotOS15_g251482 , Out_PivotWS15_g251482 , Out_PivotWO15_g251482 , Out_NormalOS15_g251482 , Out_NormalWS15_g251482 , Out_NormalRawOS15_g251482 , Out_TangentOS15_g251482 , Out_TangentWS15_g251482 , Out_BitangentWS15_g251482 , Out_ViewDirWS15_g251482 , Out_CoordsData15_g251482 , Out_VertexData15_g251482 , Out_MasksData15_g251482 , Out_PhaseData15_g251482 , Out_TransformData15_g251482 , Out_RotationData15_g251482 , Out_InterpolatorA15_g251482 );
					TVEModelData Data16_g251483 =(TVEModelData)Data15_g251482;
					float temp_output_14_0_g251483 = 0.0;
					float In_Dummy16_g251483 = temp_output_14_0_g251483;
					float3 Model_PositionOS147_g251481 = Out_PositionOS15_g251482;
					half3 VertexPos40_g251487 = Model_PositionOS147_g251481;
					float4 temp_output_1567_33_g251481 = Out_RotationData15_g251482;
					half4 Model_RotationData1569_g251481 = temp_output_1567_33_g251481;
					float2 break1582_g251481 = (Model_RotationData1569_g251481).xy;
					half Angle44_g251487 = break1582_g251481.y;
					half CosAngle89_g251487 = cos( Angle44_g251487 );
					half SinAngle93_g251487 = sin( Angle44_g251487 );
					float3 appendResult95_g251487 = (float3((VertexPos40_g251487).x , ( ( (VertexPos40_g251487).y * CosAngle89_g251487 ) - ( (VertexPos40_g251487).z * SinAngle93_g251487 ) ) , ( ( (VertexPos40_g251487).y * SinAngle93_g251487 ) + ( (VertexPos40_g251487).z * CosAngle89_g251487 ) )));
					half3 VertexPos40_g251488 = appendResult95_g251487;
					half Angle44_g251488 = -break1582_g251481.x;
					half CosAngle94_g251488 = cos( Angle44_g251488 );
					half SinAngle95_g251488 = sin( Angle44_g251488 );
					float3 appendResult98_g251488 = (float3(( ( (VertexPos40_g251488).x * CosAngle94_g251488 ) - ( (VertexPos40_g251488).y * SinAngle95_g251488 ) ) , ( ( (VertexPos40_g251488).x * SinAngle95_g251488 ) + ( (VertexPos40_g251488).y * CosAngle94_g251488 ) ) , (VertexPos40_g251488).z));
					half3 VertexPos40_g251486 = Model_PositionOS147_g251481;
					half Angle44_g251486 = break1582_g251481.y;
					half CosAngle89_g251486 = cos( Angle44_g251486 );
					half SinAngle93_g251486 = sin( Angle44_g251486 );
					float3 appendResult95_g251486 = (float3((VertexPos40_g251486).x , ( ( (VertexPos40_g251486).y * CosAngle89_g251486 ) - ( (VertexPos40_g251486).z * SinAngle93_g251486 ) ) , ( ( (VertexPos40_g251486).y * SinAngle93_g251486 ) + ( (VertexPos40_g251486).z * CosAngle89_g251486 ) )));
					half3 VertexPos40_g251491 = appendResult95_g251486;
					half Angle44_g251491 = break1582_g251481.x;
					half CosAngle91_g251491 = cos( Angle44_g251491 );
					half SinAngle92_g251491 = sin( Angle44_g251491 );
					float3 appendResult93_g251491 = (float3(( ( (VertexPos40_g251491).x * CosAngle91_g251491 ) + ( (VertexPos40_g251491).z * SinAngle92_g251491 ) ) , (VertexPos40_g251491).y , ( ( -(VertexPos40_g251491).x * SinAngle92_g251491 ) + ( (VertexPos40_g251491).z * CosAngle91_g251491 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251489 = appendResult93_g251491;
					#else
					float3 staticSwitch65_g251489 = appendResult98_g251488;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251484 = staticSwitch65_g251489;
					#else
					float3 staticSwitch65_g251484 = Model_PositionOS147_g251481;
					#endif
					float3 temp_output_1608_0_g251481 = staticSwitch65_g251484;
					half3 VertexPos40_g251490 = temp_output_1608_0_g251481;
					half Angle44_g251490 = (Model_RotationData1569_g251481).z;
					half CosAngle91_g251490 = cos( Angle44_g251490 );
					half SinAngle92_g251490 = sin( Angle44_g251490 );
					float3 appendResult93_g251490 = (float3(( ( (VertexPos40_g251490).x * CosAngle91_g251490 ) + ( (VertexPos40_g251490).z * SinAngle92_g251490 ) ) , (VertexPos40_g251490).y , ( ( -(VertexPos40_g251490).x * SinAngle92_g251490 ) + ( (VertexPos40_g251490).z * CosAngle91_g251490 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251485 = appendResult93_g251490;
					#else
					float3 staticSwitch65_g251485 = temp_output_1608_0_g251481;
					#endif
					float4 temp_output_1567_31_g251481 = Out_TransformData15_g251482;
					half4 Model_TransformData1568_g251481 = temp_output_1567_31_g251481;
					half3 Final_PositionOS178_g251481 = ( ( staticSwitch65_g251485 * (Model_TransformData1568_g251481).w ) + (Model_TransformData1568_g251481).xyz );
					float3 temp_output_4_0_g251483 = Final_PositionOS178_g251481;
					float3 In_PositionOS16_g251483 = temp_output_4_0_g251483;
					float3 In_PositionWS16_g251483 = Out_PositionWS15_g251482;
					float3 In_PositionWO16_g251483 = Out_PositionWO15_g251482;
					float3 In_PositionRawOS16_g251483 = Out_PositionRawOS15_g251482;
					float3 In_PivotOS16_g251483 = Out_PivotOS15_g251482;
					float3 In_PivotWS16_g251483 = Out_PivotWS15_g251482;
					float3 In_PivotWO16_g251483 = Out_PivotWO15_g251482;
					float3 temp_output_21_0_g251483 = Out_NormalOS15_g251482;
					float3 In_NormalOS16_g251483 = temp_output_21_0_g251483;
					float3 In_NormalWS16_g251483 = Out_NormalWS15_g251482;
					float3 In_NormalRawOS16_g251483 = Out_NormalRawOS15_g251482;
					float4 temp_output_6_0_g251483 = Out_TangentOS15_g251482;
					float4 In_TangentOS16_g251483 = temp_output_6_0_g251483;
					float3 In_TangentWS16_g251483 = Out_TangentWS15_g251482;
					float3 In_BitangentWS16_g251483 = Out_BitangentWS15_g251482;
					float3 In_ViewDirWS16_g251483 = Out_ViewDirWS15_g251482;
					float4 In_CoordsData16_g251483 = Out_CoordsData15_g251482;
					float4 In_VertexData16_g251483 = Out_VertexData15_g251482;
					float4 In_MasksData16_g251483 = Out_MasksData15_g251482;
					float4 In_PhaseData16_g251483 = Out_PhaseData15_g251482;
					float4 In_TransformData16_g251483 = temp_output_1567_31_g251481;
					float4 In_RotationData16_g251483 = temp_output_1567_33_g251481;
					float4 In_InterpolatorA16_g251483 = Out_InterpolatorA15_g251482;
					BuildModelVertData( Data16_g251483 , In_Dummy16_g251483 , In_PositionOS16_g251483 , In_PositionWS16_g251483 , In_PositionWO16_g251483 , In_PositionRawOS16_g251483 , In_PivotOS16_g251483 , In_PivotWS16_g251483 , In_PivotWO16_g251483 , In_NormalOS16_g251483 , In_NormalWS16_g251483 , In_NormalRawOS16_g251483 , In_TangentOS16_g251483 , In_TangentWS16_g251483 , In_BitangentWS16_g251483 , In_ViewDirWS16_g251483 , In_CoordsData16_g251483 , In_VertexData16_g251483 , In_MasksData16_g251483 , In_PhaseData16_g251483 , In_TransformData16_g251483 , In_RotationData16_g251483 , In_InterpolatorA16_g251483 );
					TVEModelData Data15_g251514 =(TVEModelData)Data16_g251483;
					float Out_Dummy15_g251514 = 0.0;
					float3 Out_PositionOS15_g251514 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251514 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251514 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251514 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251514 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251514 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251514 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251514 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251514 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251514 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251514 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251514 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251514 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251514 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251514 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251514 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251514 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251514 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251514 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251514 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251514 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251514 , Out_Dummy15_g251514 , Out_PositionOS15_g251514 , Out_PositionWS15_g251514 , Out_PositionWO15_g251514 , Out_PositionRawOS15_g251514 , Out_PivotOS15_g251514 , Out_PivotWS15_g251514 , Out_PivotWO15_g251514 , Out_NormalOS15_g251514 , Out_NormalWS15_g251514 , Out_NormalRawOS15_g251514 , Out_TangentOS15_g251514 , Out_TangentWS15_g251514 , Out_BitangentWS15_g251514 , Out_ViewDirWS15_g251514 , Out_CoordsData15_g251514 , Out_VertexData15_g251514 , Out_MasksData15_g251514 , Out_PhaseData15_g251514 , Out_TransformData15_g251514 , Out_RotationData15_g251514 , Out_InterpolatorA15_g251514 );
					TVEModelData Data16_g251515 =(TVEModelData)Data15_g251514;
					float temp_output_14_0_g251515 = 0.0;
					float In_Dummy16_g251515 = temp_output_14_0_g251515;
					float3 temp_output_217_24_g251513 = Out_PivotOS15_g251514;
					float3 temp_output_216_0_g251513 = ( Out_PositionOS15_g251514 + temp_output_217_24_g251513 );
					float3 temp_output_4_0_g251515 = temp_output_216_0_g251513;
					float3 In_PositionOS16_g251515 = temp_output_4_0_g251515;
					float3 In_PositionWS16_g251515 = Out_PositionWS15_g251514;
					float3 In_PositionWO16_g251515 = Out_PositionWO15_g251514;
					float3 In_PositionRawOS16_g251515 = Out_PositionRawOS15_g251514;
					float3 In_PivotOS16_g251515 = temp_output_217_24_g251513;
					float3 In_PivotWS16_g251515 = Out_PivotWS15_g251514;
					float3 In_PivotWO16_g251515 = Out_PivotWO15_g251514;
					float3 temp_output_21_0_g251515 = Out_NormalOS15_g251514;
					float3 In_NormalOS16_g251515 = temp_output_21_0_g251515;
					float3 In_NormalWS16_g251515 = Out_NormalWS15_g251514;
					float3 In_NormalRawOS16_g251515 = Out_NormalRawOS15_g251514;
					float4 temp_output_6_0_g251515 = Out_TangentOS15_g251514;
					float4 In_TangentOS16_g251515 = temp_output_6_0_g251515;
					float3 In_TangentWS16_g251515 = Out_TangentWS15_g251514;
					float3 In_BitangentWS16_g251515 = Out_BitangentWS15_g251514;
					float3 In_ViewDirWS16_g251515 = Out_ViewDirWS15_g251514;
					float4 In_CoordsData16_g251515 = Out_CoordsData15_g251514;
					float4 In_VertexData16_g251515 = Out_VertexData15_g251514;
					float4 In_MasksData16_g251515 = Out_MasksData15_g251514;
					float4 In_PhaseData16_g251515 = Out_PhaseData15_g251514;
					float4 In_TransformData16_g251515 = Out_TransformData15_g251514;
					float4 In_RotationData16_g251515 = Out_RotationData15_g251514;
					float4 In_InterpolatorA16_g251515 = Out_InterpolatorA15_g251514;
					BuildModelVertData( Data16_g251515 , In_Dummy16_g251515 , In_PositionOS16_g251515 , In_PositionWS16_g251515 , In_PositionWO16_g251515 , In_PositionRawOS16_g251515 , In_PivotOS16_g251515 , In_PivotWS16_g251515 , In_PivotWO16_g251515 , In_NormalOS16_g251515 , In_NormalWS16_g251515 , In_NormalRawOS16_g251515 , In_TangentOS16_g251515 , In_TangentWS16_g251515 , In_BitangentWS16_g251515 , In_ViewDirWS16_g251515 , In_CoordsData16_g251515 , In_VertexData16_g251515 , In_MasksData16_g251515 , In_PhaseData16_g251515 , In_TransformData16_g251515 , In_RotationData16_g251515 , In_InterpolatorA16_g251515 );
					TVEModelData Data15_g251524 =(TVEModelData)Data16_g251515;
					float Out_Dummy15_g251524 = 0.0;
					float3 Out_PositionOS15_g251524 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251524 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251524 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251524 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251524 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251524 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251524 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251524 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251524 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251524 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251524 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251524 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251524 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251524 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251524 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251524 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251524 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251524 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251524 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251524 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251524 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251524 , Out_Dummy15_g251524 , Out_PositionOS15_g251524 , Out_PositionWS15_g251524 , Out_PositionWO15_g251524 , Out_PositionRawOS15_g251524 , Out_PivotOS15_g251524 , Out_PivotWS15_g251524 , Out_PivotWO15_g251524 , Out_NormalOS15_g251524 , Out_NormalWS15_g251524 , Out_NormalRawOS15_g251524 , Out_TangentOS15_g251524 , Out_TangentWS15_g251524 , Out_BitangentWS15_g251524 , Out_ViewDirWS15_g251524 , Out_CoordsData15_g251524 , Out_VertexData15_g251524 , Out_MasksData15_g251524 , Out_PhaseData15_g251524 , Out_TransformData15_g251524 , Out_RotationData15_g251524 , Out_InterpolatorA15_g251524 );
					
					float3 color107_g251314 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251314 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float localBreakData4_g251313 = ( 0.0 );
					float localBuildMasksData3_g241966 = ( 0.0 );
					TVEMasksData Data3_g241966 = (TVEMasksData)0;
					half Feature_Intensity3187_g241936 = _MotionIntensityValue;
					float ifLocalVar18_g241970 = 0;
					if( Feature_Intensity3187_g241936 <= 0.0 )
					ifLocalVar18_g241970 = 0.0;
					else
					ifLocalVar18_g241970 = 1.0;
					half Feature_Element3188_g241936 = _MotionElementMode;
					float ifLocalVar18_g241972 = 0;
					if( Feature_Element3188_g241936 <= 0.0 )
					ifLocalVar18_g241972 = 0.0;
					else
					ifLocalVar18_g241972 = 1.0;
					float4 appendResult2992_g241936 = (float4(ifLocalVar18_g241970 , 0.0 , 0.0 , ifLocalVar18_g241972));
					float4 In_MaskA3_g241966 = appendResult2992_g241936;
					float temp_output_17_0_g241974 = _MotionBaseMaskMode;
					float Option83_g241974 = temp_output_17_0_g241974;
					TVEModelData Data15_g241938 =(TVEModelData)Data26_g241935;
					float Out_Dummy15_g241938 = 0.0;
					float3 Out_PositionOS15_g241938 = float3( 0,0,0 );
					float3 Out_PositionWS15_g241938 = float3( 0,0,0 );
					float3 Out_PositionWO15_g241938 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g241938 = float3( 0,0,0 );
					float3 Out_PivotOS15_g241938 = float3( 0,0,0 );
					float3 Out_PivotWS15_g241938 = float3( 0,0,0 );
					float3 Out_PivotWO15_g241938 = float3( 0,0,0 );
					float3 Out_NormalOS15_g241938 = float3( 0,0,0 );
					float3 Out_NormalWS15_g241938 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g241938 = float3( 0,0,0 );
					float4 Out_TangentOS15_g241938 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g241938 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g241938 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g241938 = float3( 0,0,0 );
					float4 Out_CoordsData15_g241938 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g241938 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g241938 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g241938 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g241938 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g241938 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g241938 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g241938 , Out_Dummy15_g241938 , Out_PositionOS15_g241938 , Out_PositionWS15_g241938 , Out_PositionWO15_g241938 , Out_PositionRawOS15_g241938 , Out_PivotOS15_g241938 , Out_PivotWS15_g241938 , Out_PivotWO15_g241938 , Out_NormalOS15_g241938 , Out_NormalWS15_g241938 , Out_NormalRawOS15_g241938 , Out_TangentOS15_g241938 , Out_TangentWS15_g241938 , Out_BitangentWS15_g241938 , Out_ViewDirWS15_g241938 , Out_CoordsData15_g241938 , Out_VertexData15_g241938 , Out_MasksData15_g241938 , Out_PhaseData15_g241938 , Out_TransformData15_g241938 , Out_RotationData15_g241938 , Out_InterpolatorA15_g241938 );
					float4 temp_output_2772_29_g241936 = Out_VertexData15_g241938;
					half4 Model_VertexMasks518_g241936 = temp_output_2772_29_g241936;
					float4 ChannelA83_g241974 = Model_VertexMasks518_g241936;
					float4 temp_output_2772_30_g241936 = Out_MasksData15_g241938;
					half4 Model_MasksData1322_g241936 = temp_output_2772_30_g241936;
					float2 uv_MotionMaskTex2818_g241936 = v.texcoord.xyzw.xy;
					half4 Motion_MaskTex2819_g241936 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g241936, 0.0 );
					float4 appendResult3220_g241936 = (float4((Model_MasksData1322_g241936).xy , (Motion_MaskTex2819_g241936).r , 0.0));
					float4 ChannelB83_g241974 = appendResult3220_g241936;
					float localSwitchChannel883_g241974 = SwitchChannel8( Option83_g241974 , ChannelA83_g241974 , ChannelB83_g241974 );
					float clampResult17_g241946 = clamp( localSwitchChannel883_g241974 , 0.0001 , 0.9999 );
					float temp_output_7_0_g241945 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g241945 = ( clampResult17_g241946 - temp_output_7_0_g241945 );
					half Base_Mask217_g241936 = saturate( ( temp_output_9_0_g241945 * _MotionBaseMaskRemap.z ) );
					float3 temp_output_2772_17_g241936 = Out_PositionWO15_g241938;
					float3 Model_PositionWO162_g241936 = temp_output_2772_17_g241936;
					half3 Input_ModelPositionWO761_g241939 = Model_PositionWO162_g241936;
					float3 temp_output_2772_19_g241936 = Out_PivotWO15_g241938;
					float3 Model_PivotWO402_g241936 = temp_output_2772_19_g241936;
					half3 Input_ModelPivotsWO419_g241939 = Model_PivotWO402_g241936;
					half Input_MotionPivots629_g241939 = _MotionBasePivotValue;
					float3 lerpResult771_g241939 = lerp( Input_ModelPositionWO761_g241939 , Input_ModelPivotsWO419_g241939 , Input_MotionPivots629_g241939);
					float4 temp_output_2772_27_g241936 = Out_PhaseData15_g241938;
					half4 Model_PhaseData489_g241936 = temp_output_2772_27_g241936;
					half4 Input_ModelMotionData763_g241939 = Model_PhaseData489_g241936;
					half Input_MotionPhase764_g241939 = _MotionBasePhaseValue;
					float temp_output_770_0_g241939 = ( (Input_ModelMotionData763_g241939).x * Input_MotionPhase764_g241939 );
					half3 Base_Position1394_g241936 = ( lerpResult771_g241939 + temp_output_770_0_g241939 );
					half3 Input_PositionWO419_g241977 = Base_Position1394_g241936;
					half Input_MotionTilling321_g241977 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g241977 = ( -(Input_PositionWO419_g241977).xz * Input_MotionTilling321_g241977 * 0.005 );
					float2 temp_output_3_0_g241984 = Noise_Coord515_g241977;
					float2 lerpResult3113_g241936 = lerp( (half4( 0, 1, 0.5, 1 )).xy , (TVE_WindParams).xy , TVE_IsEnabled);
					float2 Global_WindDirWS2542_g241936 = lerpResult3113_g241936;
					half2 Input_WindDirWS803_g241977 = Global_WindDirWS2542_g241936;
					float2 temp_output_21_0_g241984 = Input_WindDirWS803_g241977;
					float mulTime113_g241978 = _Time.y * 0.02;
					float lerpResult128_g241978 = lerp( mulTime113_g241978 , ( ( mulTime113_g241978 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g241977 = _MotionBaseSpeedValue;
					half Noise_Speed516_g241977 = ( lerpResult128_g241978 * Input_MotionSpeed62_g241977 );
					float temp_output_15_0_g241984 = Noise_Speed516_g241977;
					float temp_output_23_0_g241984 = frac( temp_output_15_0_g241984 );
					float4 lerpResult39_g241984 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g241984 + ( temp_output_21_0_g241984 * temp_output_23_0_g241984 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g241984 + ( temp_output_21_0_g241984 * frac( ( temp_output_15_0_g241984 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g241984 - 0.5 ) ) / 0.5 ));
					float4 temp_output_635_0_g241977 = lerpResult39_g241984;
					half4 Noise_Params685_g241977 = temp_output_635_0_g241977;
					half Base_Noise2949_g241936 = (Noise_Params685_g241977).g;
					half Base_Phase2971_g241936 = frac( temp_output_770_0_g241939 );
					TVEGlobalData Data15_g241950 =(TVEGlobalData)Data204_g241858;
					float Out_Dummy15_g241950 = 0.0;
					float4 Out_CoatParams15_g241950 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g241950 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g241950 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g241950 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g241950 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g241950 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g241950 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g241950 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g241950 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g241950 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g241950 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g241950 = float4( 0,0,0,0 );
					BreakData( Data15_g241950 , Out_Dummy15_g241950 , Out_CoatParams15_g241950 , Out_CoatTexture15_g241950 , Out_PaintParams15_g241950 , Out_PaintTexture15_g241950 , Out_AtmoParams15_g241950 , Out_AtmoTexture15_g241950 , Out_GlowParams15_g241950 , Out_GlowTexture15_g241950 , Out_FormParams15_g241950 , Out_FormTexture15_g241950 , Out_FlowParams15_g241950 , Out_FlowTexture15_g241950 );
					half4 Global_FlowParams3052_g241936 = Out_FlowParams15_g241950;
					half4 Global_FlowTexture2668_g241936 = Out_FlowTexture15_g241950;
					#ifdef TVE_MOTION_ELEMENT
					float4 staticSwitch3075_g241936 = Global_FlowTexture2668_g241936;
					#else
					float4 staticSwitch3075_g241936 = Global_FlowParams3052_g241936;
					#endif
					float4 temp_output_6_0_g241952 = staticSwitch3075_g241936;
					float temp_output_7_0_g241952 = _MotionElementMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g241952 = ( temp_output_6_0_g241952 + temp_output_7_0_g241952 );
					#else
					float4 staticSwitch14_g241952 = temp_output_6_0_g241952;
					#endif
					float4 lerpResult3121_g241936 = lerp( half4( 0, 0, 0, 1 ) , staticSwitch14_g241952 , TVE_IsEnabled);
					float2 temp_output_3126_0_g241936 = ((lerpResult3121_g241936).xy*2.0 + -1.0);
					half Global_PushAlpha1504_g241936 = length( temp_output_3126_0_g241936 );
					half Input_PushAlpha806_g241977 = Global_PushAlpha1504_g241936;
					half Input_ReactValue888_g241977 = _MotionBasePushValue;
					half Push_Mask883_g241977 = saturate( ( Input_PushAlpha806_g241977 * Input_ReactValue888_g241977 ) );
					half Base_React3000_g241936 = Push_Mask883_g241977;
					float ifLocalVar18_g241971 = 0;
					if( Feature_Element3188_g241936 <= 0.0 )
					ifLocalVar18_g241971 = 0.0;
					else
					ifLocalVar18_g241971 = Base_React3000_g241936;
					float4 appendResult2956_g241936 = (float4(Base_Mask217_g241936 , Base_Noise2949_g241936 , Base_Phase2971_g241936 , ifLocalVar18_g241971));
					float4 temp_cast_17 = (0.0).xxxx;
					float4 temp_cast_18 = (0.0).xxxx;
					float4 ifLocalVar18_g241969 = 0;
					if( Feature_Intensity3187_g241936 <= 0.0 )
					ifLocalVar18_g241969 = temp_cast_18;
					else
					ifLocalVar18_g241969 = appendResult2956_g241936;
					float4 In_MaskB3_g241966 = ifLocalVar18_g241969;
					float temp_output_17_0_g241975 = _MotionSmallMaskMode;
					float Option83_g241975 = temp_output_17_0_g241975;
					float4 ChannelA83_g241975 = Model_VertexMasks518_g241936;
					float4 appendResult3227_g241936 = (float4((Model_MasksData1322_g241936).xy , (Motion_MaskTex2819_g241936).g , 0.0));
					float4 ChannelB83_g241975 = appendResult3227_g241936;
					float localSwitchChannel883_g241975 = SwitchChannel8( Option83_g241975 , ChannelA83_g241975 , ChannelB83_g241975 );
					float enc1805_g241936 = v.texcoord.xyzw.z;
					float2 localDecodeFloatToVector21805_g241936 = DecodeFloatToVector2( enc1805_g241936 );
					float2 break1804_g241936 = localDecodeFloatToVector21805_g241936;
					half Small_Mask_Legacy1806_g241936 = break1804_g241936.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g241936 = Small_Mask_Legacy1806_g241936;
					#else
					float staticSwitch1800_g241936 = localSwitchChannel883_g241975;
					#endif
					float clampResult17_g241941 = clamp( staticSwitch1800_g241936 , 0.0001 , 0.9999 );
					float temp_output_7_0_g241942 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g241942 = ( clampResult17_g241941 - temp_output_7_0_g241942 );
					half Small_Mask640_g241936 = saturate( ( temp_output_9_0_g241942 * _MotionSmallMaskRemap.z ) );
					half3 Input_ModelPositionWO761_g241940 = Model_PositionWO162_g241936;
					half3 Input_ModelPivotsWO419_g241940 = Model_PivotWO402_g241936;
					half Input_MotionPivots629_g241940 = _MotionSmallPivotValue;
					float3 lerpResult771_g241940 = lerp( Input_ModelPositionWO761_g241940 , Input_ModelPivotsWO419_g241940 , Input_MotionPivots629_g241940);
					half4 Input_ModelMotionData763_g241940 = Model_PhaseData489_g241936;
					half Input_MotionPhase764_g241940 = _MotionSmallPhaseValue;
					float temp_output_770_0_g241940 = ( (Input_ModelMotionData763_g241940).x * Input_MotionPhase764_g241940 );
					half3 Small_Position1421_g241936 = ( lerpResult771_g241940 + temp_output_770_0_g241940 );
					half3 Input_PositionWO419_g241987 = Small_Position1421_g241936;
					half Input_MotionTilling321_g241987 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g241987 = ( -(Input_PositionWO419_g241987).xz * Input_MotionTilling321_g241987 * 0.005 );
					float2 temp_output_3_0_g241988 = Noise_Coord979_g241987;
					half2 Input_WindDirWS803_g241987 = Global_WindDirWS2542_g241936;
					float2 temp_output_21_0_g241988 = Input_WindDirWS803_g241987;
					float mulTime113_g241991 = _Time.y * 0.02;
					float lerpResult128_g241991 = lerp( mulTime113_g241991 , ( ( mulTime113_g241991 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g241987 = _MotionSmallSpeedValue;
					half Noise_Speed980_g241987 = ( lerpResult128_g241991 * Input_MotionSpeed62_g241987 );
					float temp_output_15_0_g241988 = Noise_Speed980_g241987;
					float temp_output_23_0_g241988 = frac( temp_output_15_0_g241988 );
					float4 lerpResult39_g241988 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g241988 + ( temp_output_21_0_g241988 * temp_output_23_0_g241988 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g241988 + ( temp_output_21_0_g241988 * frac( ( temp_output_15_0_g241988 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g241988 - 0.5 ) ) / 0.5 ));
					float4 temp_output_991_0_g241987 = lerpResult39_g241988;
					half4 Noise_Params685_g241987 = temp_output_991_0_g241987;
					half Small_Noise2950_g241936 = (Noise_Params685_g241987).g;
					half Small_Phase2972_g241936 = frac( temp_output_770_0_g241940 );
					half Input_PushAlpha806_g241987 = Global_PushAlpha1504_g241936;
					half Global_PushNoise2675_g241936 = (lerpResult3121_g241936).z;
					half Input_PushNoise890_g241987 = Global_PushNoise2675_g241936;
					half Input_MotionReact924_g241987 = _MotionSmallPushValue;
					half Push_Mask914_g241987 = saturate( ( Input_PushAlpha806_g241987 * Input_PushNoise890_g241987 * Input_MotionReact924_g241987 ) );
					half Small_React3002_g241936 = Push_Mask914_g241987;
					float ifLocalVar18_g241973 = 0;
					if( Feature_Element3188_g241936 <= 0.0 )
					ifLocalVar18_g241973 = 0.0;
					else
					ifLocalVar18_g241973 = Small_React3002_g241936;
					float4 appendResult2954_g241936 = (float4(Small_Mask640_g241936 , Small_Noise2950_g241936 , Small_Phase2972_g241936 , ifLocalVar18_g241973));
					float4 temp_cast_19 = (0.0).xxxx;
					float4 temp_cast_20 = (0.0).xxxx;
					float4 ifLocalVar18_g241967 = 0;
					if( Feature_Intensity3187_g241936 <= 0.0 )
					ifLocalVar18_g241967 = temp_cast_20;
					else
					ifLocalVar18_g241967 = appendResult2954_g241936;
					float4 In_MaskC3_g241966 = ifLocalVar18_g241967;
					float temp_output_17_0_g241976 = _MotionTinyMaskMode;
					float Option83_g241976 = temp_output_17_0_g241976;
					float4 ChannelA83_g241976 = Model_VertexMasks518_g241936;
					float4 appendResult3234_g241936 = (float4((Model_MasksData1322_g241936).xy , (Motion_MaskTex2819_g241936).b , 0.0));
					float4 ChannelB83_g241976 = appendResult3234_g241936;
					float localSwitchChannel883_g241976 = SwitchChannel8( Option83_g241976 , ChannelA83_g241976 , ChannelB83_g241976 );
					half Tiny_Mask_Legacy1807_g241936 = break1804_g241936.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g241936 = Tiny_Mask_Legacy1807_g241936;
					#else
					float staticSwitch1810_g241936 = localSwitchChannel883_g241976;
					#endif
					float clampResult17_g241943 = clamp( staticSwitch1810_g241936 , 0.0001 , 0.9999 );
					float temp_output_7_0_g241944 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g241944 = ( clampResult17_g241943 - temp_output_7_0_g241944 );
					half Tiny_Mask218_g241936 = saturate( ( temp_output_9_0_g241944 * _MotionTinyMaskRemap.z ) );
					half3 Tiny_Position2469_g241936 = Model_PositionWO162_g241936;
					half3 Input_PositionWO500_g241958 = Tiny_Position2469_g241936;
					half Input_MotionTilling321_g241958 = ( _MotionTinyTillingValue + 0.1 );
					float lerpResult128_g241963 = lerp( _Time.y , ( ( _Time.y * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g241958 = _MotionTinySpeedValue;
					float4 tex2DNode514_g241958 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( ( (Input_PositionWO500_g241958).xz * Input_MotionTilling321_g241958 * 0.005 ) + ( lerpResult128_g241963 * Input_MotionSpeed62_g241958 * 0.02 ) ), 0.0 );
					half Tiny_Noise2967_g241936 = tex2DNode514_g241958.g;
					float4 appendResult2975_g241936 = (float4(Tiny_Mask218_g241936 , Tiny_Noise2967_g241936 , 0.0 , 0.0));
					float4 temp_cast_21 = (0.0).xxxx;
					float4 temp_cast_22 = (0.0).xxxx;
					float4 ifLocalVar18_g241968 = 0;
					if( Feature_Intensity3187_g241936 <= 0.0 )
					ifLocalVar18_g241968 = temp_cast_22;
					else
					ifLocalVar18_g241968 = appendResult2975_g241936;
					float4 In_MaskD3_g241966 = ifLocalVar18_g241968;
					float4 temp_cast_23 = (0.0).xxxx;
					float4 In_MaskE3_g241966 = temp_cast_23;
					float4 temp_cast_24 = (0.0).xxxx;
					float4 In_MaskF3_g241966 = temp_cast_24;
					float4 temp_cast_25 = (0.0).xxxx;
					float4 In_MaskG3_g241966 = temp_cast_25;
					float4 temp_cast_26 = (0.0).xxxx;
					float4 In_MaskH3_g241966 = temp_cast_26;
					float4 temp_cast_27 = (0.0).xxxx;
					float4 In_MaskI3_g241966 = temp_cast_27;
					float4 temp_cast_28 = (0.0).xxxx;
					float4 In_MaskJ3_g241966 = temp_cast_28;
					float4 temp_cast_29 = (0.0).xxxx;
					float4 In_MaskK3_g241966 = temp_cast_29;
					float4 temp_cast_30 = (0.0).xxxx;
					float4 In_MaskL3_g241966 = temp_cast_30;
					{
					Data3_g241966.MaskA = In_MaskA3_g241966;
					Data3_g241966.MaskB = In_MaskB3_g241966;
					Data3_g241966.MaskC = In_MaskC3_g241966;
					Data3_g241966.MaskD = In_MaskD3_g241966;
					Data3_g241966.MaskE = In_MaskE3_g241966;
					Data3_g241966.MaskF = In_MaskF3_g241966;
					Data3_g241966.MaskG = In_MaskG3_g241966;
					Data3_g241966.MaskH = In_MaskH3_g241966;
					Data3_g241966.MaskI = In_MaskI3_g241966;
					Data3_g241966.MaskJ= In_MaskJ3_g241966;
					Data3_g241966.MaskK= In_MaskK3_g241966;
					Data3_g241966.MaskL = In_MaskL3_g241966;
					}
					TVEMasksData Data4_g251313 = Data3_g241966;
					float4 Out_MaskA4_g251313 = float4( 0,0,0,0 );
					float4 Out_MaskB4_g251313 = float4( 0,0,0,0 );
					float4 Out_MaskC4_g251313 = float4( 0,0,0,0 );
					float4 Out_MaskD4_g251313 = float4( 0,0,0,0 );
					float4 Out_MaskE4_g251313 = float4( 0,0,0,0 );
					float4 Out_MaskF4_g251313 = float4( 0,0,0,0 );
					float4 Out_MaskG4_g251313 = float4( 0,0,0,0 );
					float4 Out_MaskH4_g251313 = float4( 0,0,0,0 );
					{
					Out_MaskA4_g251313 = Data4_g251313.MaskA;
					Out_MaskB4_g251313 = Data4_g251313.MaskB;
					Out_MaskC4_g251313 = Data4_g251313.MaskC;
					Out_MaskD4_g251313 = Data4_g251313.MaskD;
					Out_MaskE4_g251313 = Data4_g251313.MaskE;
					Out_MaskF4_g251313 = Data4_g251313.MaskF;
					Out_MaskG4_g251313 = Data4_g251313.MaskG;
					Out_MaskH4_g251313 = Data4_g251313.MaskH;
					}
					float4 temp_output_2509_14 = Out_MaskA4_g251313;
					float3 lerpResult2568 = lerp( color107_g251314 , color106_g251314 , (temp_output_2509_14).x);
					float3 ifLocalVar40_g251375 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g251375 = lerpResult2568;
					float4 temp_output_2509_0 = Out_MaskB4_g251313;
					float3 ifLocalVar40_g251338 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g251338 = (temp_output_2509_0).xxx;
					float3 ifLocalVar40_g251339 = 0;
					if( TVE_DEBUG_Index == 3.0 )
					ifLocalVar40_g251339 = (temp_output_2509_0).yyy;
					float3 ifLocalVar40_g251347 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g251347 = (temp_output_2509_0).zzz;
					float3 hsvTorgb2613 = HSVToRGB( float3((temp_output_2509_0).z,1.0,1.0) );
					float3 gammaToLinear2614 = GammaToLinearSpace( hsvTorgb2613 );
					float3 ifLocalVar40_g251348 = 0;
					if( TVE_DEBUG_Index == 5.0 )
					ifLocalVar40_g251348 = gammaToLinear2614;
					float3 ifLocalVar40_g251349 = 0;
					if( TVE_DEBUG_Index == 6.0 )
					ifLocalVar40_g251349 = (temp_output_2509_0).www;
					float4 temp_output_2509_23 = Out_MaskC4_g251313;
					float3 ifLocalVar40_g251340 = 0;
					if( TVE_DEBUG_Index == 8.0 )
					ifLocalVar40_g251340 = (temp_output_2509_23).xxx;
					float3 ifLocalVar40_g251341 = 0;
					if( TVE_DEBUG_Index == 9.0 )
					ifLocalVar40_g251341 = (temp_output_2509_23).yyy;
					float3 ifLocalVar40_g251342 = 0;
					if( TVE_DEBUG_Index == 10.0 )
					ifLocalVar40_g251342 = (temp_output_2509_23).zzz;
					float3 hsvTorgb2618 = HSVToRGB( float3((temp_output_2509_23).z,1.0,1.0) );
					float3 gammaToLinear2619 = GammaToLinearSpace( hsvTorgb2618 );
					float3 ifLocalVar40_g251343 = 0;
					if( TVE_DEBUG_Index == 11.0 )
					ifLocalVar40_g251343 = gammaToLinear2619;
					float3 ifLocalVar40_g251344 = 0;
					if( TVE_DEBUG_Index == 12.0 )
					ifLocalVar40_g251344 = (temp_output_2509_23).www;
					float4 temp_output_2509_5 = Out_MaskD4_g251313;
					float3 ifLocalVar40_g251345 = 0;
					if( TVE_DEBUG_Index == 14.0 )
					ifLocalVar40_g251345 = (temp_output_2509_5).xxx;
					float3 ifLocalVar40_g251346 = 0;
					if( TVE_DEBUG_Index == 15.0 )
					ifLocalVar40_g251346 = (temp_output_2509_5).yyy;
					float3 color107_g241995 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g241995 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2571 = lerp( color107_g241995 , color106_g241995 , (temp_output_2509_14).z);
					float3 ifLocalVar40_g251350 = 0;
					if( TVE_DEBUG_Index == 17.0 )
					ifLocalVar40_g251350 = lerpResult2571;
					float3 color107_g251311 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251311 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2641 = lerp( color107_g251311 , color106_g251311 , (temp_output_2509_14).w);
					float3 ifLocalVar40_g251351 = 0;
					if( TVE_DEBUG_Index == 18.0 )
					ifLocalVar40_g251351 = lerpResult2641;
					float3 vertexToFrag2524 = ( ifLocalVar40_g251375 + ( ifLocalVar40_g251338 + ifLocalVar40_g251339 + ifLocalVar40_g251347 + ifLocalVar40_g251348 + ifLocalVar40_g251349 ) + ( ifLocalVar40_g251340 + ifLocalVar40_g251341 + ifLocalVar40_g251342 + ifLocalVar40_g251343 + ifLocalVar40_g251344 ) + ( ifLocalVar40_g251345 + ifLocalVar40_g251346 + ifLocalVar40_g251350 + ifLocalVar40_g251351 ) );
					o.ase_texcoord4.xyz = vertexToFrag2524;
					float3 vertexPos57_g251518 = v.vertex.xyz;
					float4 ase_positionCS57_g251518 = UnityObjectToClipPos( vertexPos57_g251518 );
					o.ase_texcoord5 = ase_positionCS57_g251518;
					o.ase_texcoord6.xyz = vertexToFrag73_g241838;
					o.ase_texcoord7.xyz = vertexToFrag76_g241838;
					
					o.ase_texcoord8 = v.texcoord.xyzw;
					o.ase_texcoord9.xy = v.texcoord2.xyzw.xy;
					o.ase_color = v.ase_color;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord4.w = 0;
					o.ase_texcoord6.w = 0;
					o.ase_texcoord7.w = 0;
					o.ase_texcoord9.zw = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251524;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251524;
					v.tangent = Out_TangentOS15_g251524;

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
					
					float3 color130_g251518 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g251518 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g251520 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g251519 = ( temp_cast_4 * ( 0.5 + appendResult128_g251520 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g251519 = (float4(ddx( FinalUV13_g251519 ) , ddy( FinalUV13_g251519 )));
					float4 UVDerivatives17_g251519 = appendResult16_g251519;
					float4 break28_g251519 = UVDerivatives17_g251519;
					float2 appendResult19_g251519 = (float2(break28_g251519.x , break28_g251519.z));
					float2 appendResult20_g251519 = (float2(break28_g251519.x , break28_g251519.z));
					float dotResult24_g251519 = dot( appendResult19_g251519 , appendResult20_g251519 );
					float2 appendResult21_g251519 = (float2(break28_g251519.y , break28_g251519.w));
					float2 appendResult22_g251519 = (float2(break28_g251519.y , break28_g251519.w));
					float dotResult23_g251519 = dot( appendResult21_g251519 , appendResult22_g251519 );
					float2 appendResult25_g251519 = (float2(dotResult24_g251519 , dotResult23_g251519));
					float2 derivativesLength29_g251519 = sqrt( appendResult25_g251519 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g251519 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g251519 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g251519 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g251519 = clampResult57_g251519;
					float2 break55_g251519 = derivativesLength29_g251519;
					float4 lerpResult73_g251519 = lerp( float4( color130_g251518 , 0.0 ) , float4( color81_g251518 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g251519.x * break71_g251519.y * sqrt( saturate( ( 1.1 - max( break55_g251519.x, break55_g251519.y ) ) ) ) ) ) ));
					float3 vertexToFrag2524 = IN.ase_texcoord4.xyz;
					half3 Final_Debug2399 = vertexToFrag2524;
					float temp_output_7_0_g251526 = TVE_DEBUG_Min;
					float3 temp_cast_9 = (temp_output_7_0_g251526).xxx;
					float3 temp_output_9_0_g251526 = ( Final_Debug2399 - temp_cast_9 );
					float lerpResult76_g251518 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g251518 = lerpResult76_g251518;
					float3 lerpResult72_g251518 = lerp( (lerpResult73_g251519).rgb , saturate( ( temp_output_9_0_g251526 / ( ( TVE_DEBUG_Max - temp_output_7_0_g251526 ) + 0.0001 ) ) ) , Filter152_g251518);
					float dotResult61_g251518 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g251518 = ( 1.0 - saturate( dotResult61_g251518 ) );
					float Shading_Fresnel59_g251518 = (( 1.0 - ( temp_output_65_0_g251518 * temp_output_65_0_g251518 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g251518 = IN.ase_texcoord5;
					float depthLinearEye57_g251518 = LinearEyeDepth( ase_positionCS57_g251518.z / ase_positionCS57_g251518.w );
					float temp_output_69_0_g251518 = saturate(  (0.0 + ( depthLinearEye57_g251518 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g251518 = (( temp_output_69_0_g251518 * temp_output_69_0_g251518 )*0.5 + 0.5);
					float lerpResult84_g251518 = lerp( 1.0 , Shading_Fresnel59_g251518 , ( Shading_Distance58_g251518 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g251523 = ( 0.0 );
					float localBuildVisualData3_g251493 = ( 0.0 );
					TVEVisualData Data3_g251493 =(TVEVisualData)0;
					half4 Dummy130_g251492 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) );
					float temp_output_14_0_g251493 = Dummy130_g251492.x;
					float In_Dummy3_g251493 = temp_output_14_0_g251493;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251512) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g251507 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g251507 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g251507 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g251507 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g251507 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g251507 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g251512 = staticSwitch36_g251507;
					float localBreakTextureData456_g251512 = ( 0.0 );
					float localBuildTextureData431_g251506 = ( 0.0 );
					TVEMasksData Data431_g251506 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g251506 = ( 0.0 );
					half4 Local_Coords180_g251492 = _main_coord_value;
					float4 Coords444_g251506 = Local_Coords180_g251492;
					float localIfModelDataByShader26_g241817 = ( 0.0 );
					TVEModelData Data26_g241817 = (TVEModelData)0;
					TVEModelData Data16_g241846 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241846 = 0.0;
					float3 vertexToFrag73_g241838 = IN.ase_texcoord6.xyz;
					float3 PositionWS122_g241838 = vertexToFrag73_g241838;
					float3 In_PositionWS16_g241846 = PositionWS122_g241838;
					float3 vertexToFrag76_g241838 = IN.ase_texcoord7.xyz;
					float3 PivotWS121_g241838 = vertexToFrag76_g241838;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241838 = ( PositionWS122_g241838 - PivotWS121_g241838 );
					#else
					float3 staticSwitch204_g241838 = PositionWS122_g241838;
					#endif
					float3 PositionWO132_g241838 = ( staticSwitch204_g241838 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241846 = PositionWO132_g241838;
					float3 In_PivotWS16_g241846 = PivotWS121_g241838;
					float3 PivotWO133_g241838 = ( PivotWS121_g241838 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241846 = PivotWO133_g241838;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g241838 = normalizedWorldNormal;
					float3 In_NormalWS16_g241846 = NormalWS95_g241838;
					half3 TangentWS136_g241838 = TangentWS;
					float3 In_TangentWS16_g241846 = TangentWS136_g241838;
					half3 BiangentWS421_g241838 = BitangentWS;
					float3 In_BitangentWS16_g241846 = BiangentWS421_g241838;
					half3 NormalWS427_g241838 = NormalWS95_g241838;
					half3 localComputeTriplanarWeights427_g241838 = ComputeTriplanarWeights( NormalWS427_g241838 );
					half3 TriplanarWeights429_g241838 = localComputeTriplanarWeights427_g241838;
					float3 In_TriplanarWeights16_g241846 = TriplanarWeights429_g241838;
					float3 normalizeResult296_g241838 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241838 ) );
					half3 ViewDirWS169_g241838 = normalizeResult296_g241838;
					float3 In_ViewDirWS16_g241846 = ViewDirWS169_g241838;
					float4 appendResult397_g241838 = (float4(IN.ase_texcoord8.xy , IN.ase_texcoord9.xy));
					float4 CoordsData398_g241838 = appendResult397_g241838;
					float4 In_CoordsData16_g241846 = CoordsData398_g241838;
					half4 VertexMasks171_g241838 = IN.ase_color;
					float4 In_VertexData16_g241846 = VertexMasks171_g241838;
					float temp_output_17_0_g241850 = _ObjectPhaseMode;
					float Option70_g241850 = temp_output_17_0_g241850;
					float4 temp_output_3_0_g241850 = IN.ase_color;
					float4 Channel70_g241850 = temp_output_3_0_g241850;
					float localSwitchChannel470_g241850 = SwitchChannel4( Option70_g241850 , Channel70_g241850 );
					half Phase_Value372_g241838 = localSwitchChannel470_g241850;
					float3 break319_g241838 = PivotWO133_g241838;
					half Pivot_Position322_g241838 = ( break319_g241838.x + break319_g241838.z );
					half Phase_Position357_g241838 = ( Phase_Value372_g241838 + Pivot_Position322_g241838 );
					float temp_output_248_0_g241838 = frac( Phase_Position357_g241838 );
					float4 appendResult177_g241838 = (float4(( (frac( ( Phase_Position357_g241838 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g241838));
					half4 Phase_Data176_g241838 = appendResult177_g241838;
					float4 In_PhaseData16_g241846 = Phase_Data176_g241838;
					BuildModelFragData( Data16_g241846 , In_Dummy16_g241846 , In_PositionWS16_g241846 , In_PositionWO16_g241846 , In_PivotWS16_g241846 , In_PivotWO16_g241846 , In_NormalWS16_g241846 , In_TangentWS16_g241846 , In_BitangentWS16_g241846 , In_TriplanarWeights16_g241846 , In_ViewDirWS16_g241846 , In_CoordsData16_g241846 , In_VertexData16_g241846 , In_PhaseData16_g241846 );
					TVEModelData DataDefault26_g241817 = Data16_g241846;
					TVEModelData DataGeneral26_g241817 = Data16_g241846;
					TVEModelData DataBlanket26_g241817 = Data16_g241846;
					TVEModelData DataImpostor26_g241817 = Data16_g241846;
					TVEModelData Data16_g241826 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241826 = 0.0;
					float3 temp_output_104_7_g241818 = PositionWS;
					float3 PositionWS122_g241818 = temp_output_104_7_g241818;
					float3 In_PositionWS16_g241826 = PositionWS122_g241818;
					float4x4 break19_g241821 = unity_ObjectToWorld;
					float3 appendResult20_g241821 = (float3(break19_g241821[ 0 ][ 3 ] , break19_g241821[ 1 ][ 3 ] , break19_g241821[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241818 = appendResult20_g241821;
					float3 PivotWS121_g241818 = temp_output_340_7_g241818;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241818 = ( PositionWS122_g241818 - PivotWS121_g241818 );
					#else
					float3 staticSwitch204_g241818 = PositionWS122_g241818;
					#endif
					float3 PositionWO132_g241818 = ( staticSwitch204_g241818 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241826 = PositionWO132_g241818;
					float3 In_PivotWS16_g241826 = PivotWS121_g241818;
					float3 PivotWO133_g241818 = ( PivotWS121_g241818 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241826 = PivotWO133_g241818;
					half3 NormalWS95_g241818 = normalizedWorldNormal;
					float3 In_NormalWS16_g241826 = NormalWS95_g241818;
					half3 TangentWS136_g241818 = TangentWS;
					float3 In_TangentWS16_g241826 = TangentWS136_g241818;
					half3 BiangentWS421_g241818 = BitangentWS;
					float3 In_BitangentWS16_g241826 = BiangentWS421_g241818;
					half3 NormalWS427_g241818 = NormalWS95_g241818;
					half3 localComputeTriplanarWeights427_g241818 = ComputeTriplanarWeights( NormalWS427_g241818 );
					half3 TriplanarWeights429_g241818 = localComputeTriplanarWeights427_g241818;
					float3 In_TriplanarWeights16_g241826 = TriplanarWeights429_g241818;
					float3 normalizeResult296_g241818 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241818 ) );
					half3 ViewDirWS169_g241818 = normalizeResult296_g241818;
					float3 In_ViewDirWS16_g241826 = ViewDirWS169_g241818;
					float4 appendResult397_g241818 = (float4(IN.ase_texcoord8.xy , IN.ase_texcoord9.xy));
					float4 CoordsData398_g241818 = appendResult397_g241818;
					float4 In_CoordsData16_g241826 = CoordsData398_g241818;
					half4 VertexMasks171_g241818 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241826 = VertexMasks171_g241818;
					half4 Phase_Data176_g241818 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241826 = Phase_Data176_g241818;
					BuildModelFragData( Data16_g241826 , In_Dummy16_g241826 , In_PositionWS16_g241826 , In_PositionWO16_g241826 , In_PivotWS16_g241826 , In_PivotWO16_g241826 , In_NormalWS16_g241826 , In_TangentWS16_g241826 , In_BitangentWS16_g241826 , In_TriplanarWeights16_g241826 , In_ViewDirWS16_g241826 , In_CoordsData16_g241826 , In_VertexData16_g241826 , In_PhaseData16_g241826 );
					TVEModelData DataTerrain26_g241817 = Data16_g241826;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g241817 = IsShaderType2637;
					{
					if (Type26_g241817 == 0 )
					{
					Data26_g241817 = DataDefault26_g241817;
					}
					else if (Type26_g241817 == 1 )
					{
					Data26_g241817 = DataGeneral26_g241817;
					}
					else if (Type26_g241817 == 2 )
					{
					Data26_g241817 = DataBlanket26_g241817;
					}
					else if (Type26_g241817 == 3 )
					{
					Data26_g241817 = DataImpostor26_g241817;
					}
					else if (Type26_g241817 == 4 )
					{
					Data26_g241817 = DataTerrain26_g241817;
					}
					}
					TVEModelData Data15_g251505 =(TVEModelData)Data26_g241817;
					float Out_Dummy15_g251505 = 0.0;
					float3 Out_PositionWS15_g251505 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251505 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251505 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251505 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251505 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251505 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251505 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251505 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251505 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251505 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251505 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251505 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251505 , Out_Dummy15_g251505 , Out_PositionWS15_g251505 , Out_PositionWO15_g251505 , Out_PivotWS15_g251505 , Out_PivotWO15_g251505 , Out_NormalWS15_g251505 , Out_TangentWS15_g251505 , Out_BitangentWS15_g251505 , Out_TriplanarWeights15_g251505 , Out_ViewDirWS15_g251505 , Out_CoordsData15_g251505 , Out_VertexData15_g251505 , Out_PhaseData15_g251505 );
					float4 Model_CoordsData324_g251492 = Out_CoordsData15_g251505;
					float4 MeshCoords444_g251506 = Model_CoordsData324_g251492;
					float2 UV0444_g251506 = float2( 0,0 );
					float2 UV3444_g251506 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g251506 , MeshCoords444_g251506 , UV0444_g251506 , UV3444_g251506 );
					float4 appendResult430_g251506 = (float4(UV0444_g251506 , UV3444_g251506));
					float4 In_MaskA431_g251506 = appendResult430_g251506;
					float localComputeWorldCoords315_g251506 = ( 0.0 );
					float4 Coords315_g251506 = Local_Coords180_g251492;
					float3 Model_PositionWO222_g251492 = Out_PositionWO15_g251505;
					float3 PositionWS315_g251506 = Model_PositionWO222_g251492;
					float2 ZY315_g251506 = float2( 0,0 );
					float2 XZ315_g251506 = float2( 0,0 );
					float2 XY315_g251506 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g251506 , PositionWS315_g251506 , ZY315_g251506 , XZ315_g251506 , XY315_g251506 );
					float2 ZY402_g251506 = ZY315_g251506;
					float2 XZ403_g251506 = XZ315_g251506;
					float4 appendResult432_g251506 = (float4(ZY402_g251506 , XZ403_g251506));
					float4 In_MaskB431_g251506 = appendResult432_g251506;
					float2 XY404_g251506 = XY315_g251506;
					float localComputeStochasticCoords409_g251506 = ( 0.0 );
					float2 UV409_g251506 = ZY402_g251506;
					float2 UV1409_g251506 = float2( 0,0 );
					float2 UV2409_g251506 = float2( 0,0 );
					float2 UV3409_g251506 = float2( 0,0 );
					float3 Weights409_g251506 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g251506 , UV1409_g251506 , UV2409_g251506 , UV3409_g251506 , Weights409_g251506 );
					float4 appendResult433_g251506 = (float4(XY404_g251506 , UV1409_g251506));
					float4 In_MaskC431_g251506 = appendResult433_g251506;
					float4 appendResult434_g251506 = (float4(UV2409_g251506 , UV3409_g251506));
					float4 In_MaskD431_g251506 = appendResult434_g251506;
					float localComputeStochasticCoords422_g251506 = ( 0.0 );
					float2 UV422_g251506 = XZ403_g251506;
					float2 UV1422_g251506 = float2( 0,0 );
					float2 UV2422_g251506 = float2( 0,0 );
					float2 UV3422_g251506 = float2( 0,0 );
					float3 Weights422_g251506 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g251506 , UV1422_g251506 , UV2422_g251506 , UV3422_g251506 , Weights422_g251506 );
					float4 appendResult435_g251506 = (float4(UV1422_g251506 , UV2422_g251506));
					float4 In_MaskE431_g251506 = appendResult435_g251506;
					float localComputeStochasticCoords423_g251506 = ( 0.0 );
					float2 UV423_g251506 = XY404_g251506;
					float2 UV1423_g251506 = float2( 0,0 );
					float2 UV2423_g251506 = float2( 0,0 );
					float2 UV3423_g251506 = float2( 0,0 );
					float3 Weights423_g251506 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g251506 , UV1423_g251506 , UV2423_g251506 , UV3423_g251506 , Weights423_g251506 );
					float4 appendResult436_g251506 = (float4(UV3422_g251506 , UV1423_g251506));
					float4 In_MaskF431_g251506 = appendResult436_g251506;
					float4 appendResult437_g251506 = (float4(UV2423_g251506 , UV3423_g251506));
					float4 In_MaskG431_g251506 = appendResult437_g251506;
					float4 In_MaskH431_g251506 = float4( Weights409_g251506 , 0.0 );
					float4 In_MaskI431_g251506 = float4( Weights422_g251506 , 0.0 );
					float4 In_MaskJ431_g251506 = float4( Weights423_g251506 , 0.0 );
					half3 Model_NormalWS226_g251492 = Out_NormalWS15_g251505;
					float3 temp_output_449_0_g251506 = Model_NormalWS226_g251492;
					float4 In_MaskK431_g251506 = float4( temp_output_449_0_g251506 , 0.0 );
					half3 Model_TangentWS366_g251492 = Out_TangentWS15_g251505;
					float3 temp_output_450_0_g251506 = Model_TangentWS366_g251492;
					float4 In_MaskL431_g251506 = float4( temp_output_450_0_g251506 , 0.0 );
					half3 Model_BitangentWS367_g251492 = Out_BitangentWS15_g251505;
					float3 temp_output_451_0_g251506 = Model_BitangentWS367_g251492;
					float4 In_MaskM431_g251506 = float4( temp_output_451_0_g251506 , 0.0 );
					half3 Model_TriplanarWeights368_g251492 = Out_TriplanarWeights15_g251505;
					float3 temp_output_445_0_g251506 = Model_TriplanarWeights368_g251492;
					float4 In_MaskN431_g251506 = float4( temp_output_445_0_g251506 , 0.0 );
					BuildTextureData( Data431_g251506 , In_MaskA431_g251506 , In_MaskB431_g251506 , In_MaskC431_g251506 , In_MaskD431_g251506 , In_MaskE431_g251506 , In_MaskF431_g251506 , In_MaskG431_g251506 , In_MaskH431_g251506 , In_MaskI431_g251506 , In_MaskJ431_g251506 , In_MaskK431_g251506 , In_MaskL431_g251506 , In_MaskM431_g251506 , In_MaskN431_g251506 );
					TVEMasksData Data456_g251512 =(TVEMasksData)Data431_g251506;
					float4 Out_MaskA456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251512 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251512 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251512 , Out_MaskA456_g251512 , Out_MaskB456_g251512 , Out_MaskC456_g251512 , Out_MaskD456_g251512 , Out_MaskE456_g251512 , Out_MaskF456_g251512 , Out_MaskG456_g251512 , Out_MaskH456_g251512 , Out_MaskI456_g251512 , Out_MaskJ456_g251512 , Out_MaskK456_g251512 , Out_MaskL456_g251512 , Out_MaskM456_g251512 , Out_MaskN456_g251512 );
					half2 UV276_g251512 = (Out_MaskA456_g251512).xy;
					float temp_output_504_0_g251512 = 0.0;
					half Bias276_g251512 = temp_output_504_0_g251512;
					half2 Normal276_g251512 = float2( 0,0 );
					half4 localSampleCoord276_g251512 = SampleCoord( Texture276_g251512 , Sampler276_g251512 , UV276_g251512 , Bias276_g251512 , Normal276_g251512 );
					float4 temp_output_407_277_g251492 = localSampleCoord276_g251512;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251512) = _MainAlbedoTex;
					SamplerState Sampler502_g251512 = staticSwitch36_g251507;
					half2 UV502_g251512 = (Out_MaskA456_g251512).zw;
					half Bias502_g251512 = temp_output_504_0_g251512;
					half2 Normal502_g251512 = float2( 0,0 );
					half4 localSampleCoord502_g251512 = SampleCoord( Texture502_g251512 , Sampler502_g251512 , UV502_g251512 , Bias502_g251512 , Normal502_g251512 );
					float4 temp_output_407_278_g251492 = localSampleCoord502_g251512;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251512) = _MainAlbedoTex;
					SamplerState Sampler496_g251512 = staticSwitch36_g251507;
					float2 temp_output_463_0_g251512 = (Out_MaskB456_g251512).zw;
					half2 XZ496_g251512 = temp_output_463_0_g251512;
					half Bias496_g251512 = temp_output_504_0_g251512;
					float3 temp_output_483_0_g251512 = (Out_MaskK456_g251512).xyz;
					half3 NormalWS496_g251512 = temp_output_483_0_g251512;
					half3 Normal496_g251512 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251512 = SamplePlanar2D( Texture496_g251512 , Sampler496_g251512 , XZ496_g251512 , Bias496_g251512 , NormalWS496_g251512 , Normal496_g251512 );
					float4 temp_output_407_0_g251492 = localSamplePlanar2D496_g251512;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251512) = _MainAlbedoTex;
					SamplerState Sampler490_g251512 = staticSwitch36_g251507;
					float2 temp_output_462_0_g251512 = (Out_MaskB456_g251512).xy;
					half2 ZY490_g251512 = temp_output_462_0_g251512;
					half2 XZ490_g251512 = temp_output_463_0_g251512;
					float2 temp_output_464_0_g251512 = (Out_MaskC456_g251512).xy;
					half2 XY490_g251512 = temp_output_464_0_g251512;
					half Bias490_g251512 = temp_output_504_0_g251512;
					float3 temp_output_482_0_g251512 = (Out_MaskN456_g251512).xyz;
					half3 Triplanar490_g251512 = temp_output_482_0_g251512;
					half3 NormalWS490_g251512 = temp_output_483_0_g251512;
					half3 Normal490_g251512 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251512 = SamplePlanar3D( Texture490_g251512 , Sampler490_g251512 , ZY490_g251512 , XZ490_g251512 , XY490_g251512 , Bias490_g251512 , Triplanar490_g251512 , NormalWS490_g251512 , Normal490_g251512 );
					float4 temp_output_407_201_g251492 = localSamplePlanar3D490_g251512;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251512) = _MainAlbedoTex;
					SamplerState Sampler498_g251512 = staticSwitch36_g251507;
					half2 XZ498_g251512 = temp_output_463_0_g251512;
					float2 temp_output_473_0_g251512 = (Out_MaskE456_g251512).xy;
					half2 XZ_1498_g251512 = temp_output_473_0_g251512;
					float2 temp_output_474_0_g251512 = (Out_MaskE456_g251512).zw;
					half2 XZ_2498_g251512 = temp_output_474_0_g251512;
					float2 temp_output_475_0_g251512 = (Out_MaskF456_g251512).xy;
					half2 XZ_3498_g251512 = temp_output_475_0_g251512;
					float temp_output_510_0_g251512 = exp2( temp_output_504_0_g251512 );
					half Bias498_g251512 = temp_output_510_0_g251512;
					float3 temp_output_480_0_g251512 = (Out_MaskI456_g251512).xyz;
					half3 Weights_2498_g251512 = temp_output_480_0_g251512;
					half3 NormalWS498_g251512 = temp_output_483_0_g251512;
					half3 Normal498_g251512 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251512 = SampleStochastic2D( Texture498_g251512 , Sampler498_g251512 , XZ498_g251512 , XZ_1498_g251512 , XZ_2498_g251512 , XZ_3498_g251512 , Bias498_g251512 , Weights_2498_g251512 , NormalWS498_g251512 , Normal498_g251512 );
					float4 temp_output_407_202_g251492 = localSampleStochastic2D498_g251512;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251512) = _MainAlbedoTex;
					SamplerState Sampler500_g251512 = staticSwitch36_g251507;
					half2 ZY500_g251512 = temp_output_462_0_g251512;
					half2 ZY_1500_g251512 = (Out_MaskC456_g251512).zw;
					half2 ZY_2500_g251512 = (Out_MaskD456_g251512).xy;
					half2 ZY_3500_g251512 = (Out_MaskD456_g251512).zw;
					half2 XZ500_g251512 = temp_output_463_0_g251512;
					half2 XZ_1500_g251512 = temp_output_473_0_g251512;
					half2 XZ_2500_g251512 = temp_output_474_0_g251512;
					half2 XZ_3500_g251512 = temp_output_475_0_g251512;
					half2 XY500_g251512 = temp_output_464_0_g251512;
					half2 XY_1500_g251512 = (Out_MaskF456_g251512).zw;
					half2 XY_2500_g251512 = (Out_MaskG456_g251512).xy;
					half2 XY_3500_g251512 = (Out_MaskG456_g251512).zw;
					half Bias500_g251512 = temp_output_510_0_g251512;
					half3 Weights_1500_g251512 = (Out_MaskH456_g251512).xyz;
					half3 Weights_2500_g251512 = temp_output_480_0_g251512;
					half3 Weights_3500_g251512 = (Out_MaskJ456_g251512).xyz;
					half3 Triplanar500_g251512 = temp_output_482_0_g251512;
					half3 NormalWS500_g251512 = temp_output_483_0_g251512;
					half3 Normal500_g251512 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251512 = SampleStochastic3D( Texture500_g251512 , Sampler500_g251512 , ZY500_g251512 , ZY_1500_g251512 , ZY_2500_g251512 , ZY_3500_g251512 , XZ500_g251512 , XZ_1500_g251512 , XZ_2500_g251512 , XZ_3500_g251512 , XY500_g251512 , XY_1500_g251512 , XY_2500_g251512 , XY_3500_g251512 , Bias500_g251512 , Weights_1500_g251512 , Weights_2500_g251512 , Weights_3500_g251512 , Triplanar500_g251512 , NormalWS500_g251512 , Normal500_g251512 );
					float4 temp_output_407_203_g251492 = localSampleStochastic3D500_g251512;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g251492 = temp_output_407_277_g251492;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g251492 = temp_output_407_278_g251492;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g251492 = temp_output_407_0_g251492;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g251492 = temp_output_407_201_g251492;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g251492 = temp_output_407_202_g251492;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g251492 = temp_output_407_203_g251492;
					#else
					float4 staticSwitch184_g251492 = temp_output_407_277_g251492;
					#endif
					half4 Local_AlbedoSample185_g251492 = staticSwitch184_g251492;
					float3 lerpResult53_g251492 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g251492).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g251492 = lerpResult53_g251492;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251510) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g251509 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g251509 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g251509 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g251509 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g251509 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g251509 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251510 = staticSwitch38_g251509;
					float localBreakTextureData456_g251510 = ( 0.0 );
					TVEMasksData Data456_g251510 =(TVEMasksData)Data431_g251506;
					float4 Out_MaskA456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251510 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251510 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251510 , Out_MaskA456_g251510 , Out_MaskB456_g251510 , Out_MaskC456_g251510 , Out_MaskD456_g251510 , Out_MaskE456_g251510 , Out_MaskF456_g251510 , Out_MaskG456_g251510 , Out_MaskH456_g251510 , Out_MaskI456_g251510 , Out_MaskJ456_g251510 , Out_MaskK456_g251510 , Out_MaskL456_g251510 , Out_MaskM456_g251510 , Out_MaskN456_g251510 );
					half2 UV276_g251510 = (Out_MaskA456_g251510).xy;
					float temp_output_504_0_g251510 = 0.0;
					half Bias276_g251510 = temp_output_504_0_g251510;
					half2 Normal276_g251510 = float2( 0,0 );
					half4 localSampleCoord276_g251510 = SampleCoord( Texture276_g251510 , Sampler276_g251510 , UV276_g251510 , Bias276_g251510 , Normal276_g251510 );
					float4 temp_output_405_277_g251492 = localSampleCoord276_g251510;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251510) = _MainShaderTex;
					SamplerState Sampler502_g251510 = staticSwitch38_g251509;
					half2 UV502_g251510 = (Out_MaskA456_g251510).zw;
					half Bias502_g251510 = temp_output_504_0_g251510;
					half2 Normal502_g251510 = float2( 0,0 );
					half4 localSampleCoord502_g251510 = SampleCoord( Texture502_g251510 , Sampler502_g251510 , UV502_g251510 , Bias502_g251510 , Normal502_g251510 );
					float4 temp_output_405_278_g251492 = localSampleCoord502_g251510;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251510) = _MainShaderTex;
					SamplerState Sampler496_g251510 = staticSwitch38_g251509;
					float2 temp_output_463_0_g251510 = (Out_MaskB456_g251510).zw;
					half2 XZ496_g251510 = temp_output_463_0_g251510;
					half Bias496_g251510 = temp_output_504_0_g251510;
					float3 temp_output_483_0_g251510 = (Out_MaskK456_g251510).xyz;
					half3 NormalWS496_g251510 = temp_output_483_0_g251510;
					half3 Normal496_g251510 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251510 = SamplePlanar2D( Texture496_g251510 , Sampler496_g251510 , XZ496_g251510 , Bias496_g251510 , NormalWS496_g251510 , Normal496_g251510 );
					float4 temp_output_405_0_g251492 = localSamplePlanar2D496_g251510;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251510) = _MainShaderTex;
					SamplerState Sampler490_g251510 = staticSwitch38_g251509;
					float2 temp_output_462_0_g251510 = (Out_MaskB456_g251510).xy;
					half2 ZY490_g251510 = temp_output_462_0_g251510;
					half2 XZ490_g251510 = temp_output_463_0_g251510;
					float2 temp_output_464_0_g251510 = (Out_MaskC456_g251510).xy;
					half2 XY490_g251510 = temp_output_464_0_g251510;
					half Bias490_g251510 = temp_output_504_0_g251510;
					float3 temp_output_482_0_g251510 = (Out_MaskN456_g251510).xyz;
					half3 Triplanar490_g251510 = temp_output_482_0_g251510;
					half3 NormalWS490_g251510 = temp_output_483_0_g251510;
					half3 Normal490_g251510 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251510 = SamplePlanar3D( Texture490_g251510 , Sampler490_g251510 , ZY490_g251510 , XZ490_g251510 , XY490_g251510 , Bias490_g251510 , Triplanar490_g251510 , NormalWS490_g251510 , Normal490_g251510 );
					float4 temp_output_405_201_g251492 = localSamplePlanar3D490_g251510;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251510) = _MainShaderTex;
					SamplerState Sampler498_g251510 = staticSwitch38_g251509;
					half2 XZ498_g251510 = temp_output_463_0_g251510;
					float2 temp_output_473_0_g251510 = (Out_MaskE456_g251510).xy;
					half2 XZ_1498_g251510 = temp_output_473_0_g251510;
					float2 temp_output_474_0_g251510 = (Out_MaskE456_g251510).zw;
					half2 XZ_2498_g251510 = temp_output_474_0_g251510;
					float2 temp_output_475_0_g251510 = (Out_MaskF456_g251510).xy;
					half2 XZ_3498_g251510 = temp_output_475_0_g251510;
					float temp_output_510_0_g251510 = exp2( temp_output_504_0_g251510 );
					half Bias498_g251510 = temp_output_510_0_g251510;
					float3 temp_output_480_0_g251510 = (Out_MaskI456_g251510).xyz;
					half3 Weights_2498_g251510 = temp_output_480_0_g251510;
					half3 NormalWS498_g251510 = temp_output_483_0_g251510;
					half3 Normal498_g251510 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251510 = SampleStochastic2D( Texture498_g251510 , Sampler498_g251510 , XZ498_g251510 , XZ_1498_g251510 , XZ_2498_g251510 , XZ_3498_g251510 , Bias498_g251510 , Weights_2498_g251510 , NormalWS498_g251510 , Normal498_g251510 );
					float4 temp_output_405_202_g251492 = localSampleStochastic2D498_g251510;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251510) = _MainShaderTex;
					SamplerState Sampler500_g251510 = staticSwitch38_g251509;
					half2 ZY500_g251510 = temp_output_462_0_g251510;
					half2 ZY_1500_g251510 = (Out_MaskC456_g251510).zw;
					half2 ZY_2500_g251510 = (Out_MaskD456_g251510).xy;
					half2 ZY_3500_g251510 = (Out_MaskD456_g251510).zw;
					half2 XZ500_g251510 = temp_output_463_0_g251510;
					half2 XZ_1500_g251510 = temp_output_473_0_g251510;
					half2 XZ_2500_g251510 = temp_output_474_0_g251510;
					half2 XZ_3500_g251510 = temp_output_475_0_g251510;
					half2 XY500_g251510 = temp_output_464_0_g251510;
					half2 XY_1500_g251510 = (Out_MaskF456_g251510).zw;
					half2 XY_2500_g251510 = (Out_MaskG456_g251510).xy;
					half2 XY_3500_g251510 = (Out_MaskG456_g251510).zw;
					half Bias500_g251510 = temp_output_510_0_g251510;
					half3 Weights_1500_g251510 = (Out_MaskH456_g251510).xyz;
					half3 Weights_2500_g251510 = temp_output_480_0_g251510;
					half3 Weights_3500_g251510 = (Out_MaskJ456_g251510).xyz;
					half3 Triplanar500_g251510 = temp_output_482_0_g251510;
					half3 NormalWS500_g251510 = temp_output_483_0_g251510;
					half3 Normal500_g251510 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251510 = SampleStochastic3D( Texture500_g251510 , Sampler500_g251510 , ZY500_g251510 , ZY_1500_g251510 , ZY_2500_g251510 , ZY_3500_g251510 , XZ500_g251510 , XZ_1500_g251510 , XZ_2500_g251510 , XZ_3500_g251510 , XY500_g251510 , XY_1500_g251510 , XY_2500_g251510 , XY_3500_g251510 , Bias500_g251510 , Weights_1500_g251510 , Weights_2500_g251510 , Weights_3500_g251510 , Triplanar500_g251510 , NormalWS500_g251510 , Normal500_g251510 );
					float4 temp_output_405_203_g251492 = localSampleStochastic3D500_g251510;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g251492 = temp_output_405_277_g251492;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g251492 = temp_output_405_278_g251492;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g251492 = temp_output_405_0_g251492;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g251492 = temp_output_405_201_g251492;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g251492 = temp_output_405_202_g251492;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g251492 = temp_output_405_203_g251492;
					#else
					float4 staticSwitch198_g251492 = temp_output_405_277_g251492;
					#endif
					half4 Local_ShaderSample199_g251492 = staticSwitch198_g251492;
					float temp_output_209_0_g251492 = (Local_ShaderSample199_g251492).y;
					float temp_output_7_0_g251498 = _MainOcclusionRemap.x;
					float temp_output_9_0_g251498 = ( temp_output_209_0_g251492 - temp_output_7_0_g251498 );
					float lerpResult23_g251492 = lerp( 1.0 , saturate( ( temp_output_9_0_g251498 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g251492 = lerpResult23_g251492;
					float temp_output_213_0_g251492 = (Local_ShaderSample199_g251492).w;
					float temp_output_7_0_g251502 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g251502 = ( temp_output_213_0_g251492 - temp_output_7_0_g251502 );
					half Local_Smoothness317_g251492 = ( saturate( ( temp_output_9_0_g251502 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g251492 = (float4(( (Local_ShaderSample199_g251492).x * _MainMetallicValue ) , Local_Occlusion313_g251492 , (Local_ShaderSample199_g251492).z , Local_Smoothness317_g251492));
					half4 Local_Masks109_g251492 = appendResult73_g251492;
					float temp_output_135_0_g251492 = (Local_Masks109_g251492).z;
					float temp_output_7_0_g251497 = _MainMultiRemap.x;
					float temp_output_9_0_g251497 = ( temp_output_135_0_g251492 - temp_output_7_0_g251497 );
					float temp_output_42_0_g251492 = saturate( ( temp_output_9_0_g251497 * _MainMultiRemap.z ) );
					half Local_MultiMask78_g251492 = temp_output_42_0_g251492;
					float lerpResult58_g251492 = lerp( 1.0 , Local_MultiMask78_g251492 , _MainColorMode);
					float4 lerpResult62_g251492 = lerp( _MainColorTwo , _MainColor , lerpResult58_g251492);
					half3 Local_ColorRGB93_g251492 = (lerpResult62_g251492).rgb;
					half3 Local_Albedo139_g251492 = ( Local_AlbedoRGB107_g251492 * Local_ColorRGB93_g251492 );
					float3 temp_output_4_0_g251493 = Local_Albedo139_g251492;
					float3 In_Albedo3_g251493 = temp_output_4_0_g251493;
					float3 temp_output_44_0_g251493 = Local_Albedo139_g251492;
					float3 In_AlbedoBase3_g251493 = temp_output_44_0_g251493;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251511) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g251508 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g251508 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g251508 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g251508 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g251508 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g251508 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251511 = staticSwitch37_g251508;
					float localBreakTextureData456_g251511 = ( 0.0 );
					TVEMasksData Data456_g251511 =(TVEMasksData)Data431_g251506;
					float4 Out_MaskA456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251511 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251511 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251511 , Out_MaskA456_g251511 , Out_MaskB456_g251511 , Out_MaskC456_g251511 , Out_MaskD456_g251511 , Out_MaskE456_g251511 , Out_MaskF456_g251511 , Out_MaskG456_g251511 , Out_MaskH456_g251511 , Out_MaskI456_g251511 , Out_MaskJ456_g251511 , Out_MaskK456_g251511 , Out_MaskL456_g251511 , Out_MaskM456_g251511 , Out_MaskN456_g251511 );
					half2 UV276_g251511 = (Out_MaskA456_g251511).xy;
					float temp_output_504_0_g251511 = 0.0;
					half Bias276_g251511 = temp_output_504_0_g251511;
					half2 Normal276_g251511 = float2( 0,0 );
					half4 localSampleCoord276_g251511 = SampleCoord( Texture276_g251511 , Sampler276_g251511 , UV276_g251511 , Bias276_g251511 , Normal276_g251511 );
					float2 temp_output_406_394_g251492 = Normal276_g251511;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251511) = _MainNormalTex;
					SamplerState Sampler502_g251511 = staticSwitch37_g251508;
					half2 UV502_g251511 = (Out_MaskA456_g251511).zw;
					half Bias502_g251511 = temp_output_504_0_g251511;
					half2 Normal502_g251511 = float2( 0,0 );
					half4 localSampleCoord502_g251511 = SampleCoord( Texture502_g251511 , Sampler502_g251511 , UV502_g251511 , Bias502_g251511 , Normal502_g251511 );
					float2 temp_output_406_397_g251492 = Normal502_g251511;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251511) = _MainNormalTex;
					SamplerState Sampler496_g251511 = staticSwitch37_g251508;
					float2 temp_output_463_0_g251511 = (Out_MaskB456_g251511).zw;
					half2 XZ496_g251511 = temp_output_463_0_g251511;
					half Bias496_g251511 = temp_output_504_0_g251511;
					float3 temp_output_483_0_g251511 = (Out_MaskK456_g251511).xyz;
					half3 NormalWS496_g251511 = temp_output_483_0_g251511;
					half3 Normal496_g251511 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251511 = SamplePlanar2D( Texture496_g251511 , Sampler496_g251511 , XZ496_g251511 , Bias496_g251511 , NormalWS496_g251511 , Normal496_g251511 );
					float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
					float3 worldToTangentDir408_g251511 = normalize( mul( ase_worldToTangent, Normal496_g251511 ) );
					float2 temp_output_406_375_g251492 = (worldToTangentDir408_g251511).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251511) = _MainNormalTex;
					SamplerState Sampler490_g251511 = staticSwitch37_g251508;
					float2 temp_output_462_0_g251511 = (Out_MaskB456_g251511).xy;
					half2 ZY490_g251511 = temp_output_462_0_g251511;
					half2 XZ490_g251511 = temp_output_463_0_g251511;
					float2 temp_output_464_0_g251511 = (Out_MaskC456_g251511).xy;
					half2 XY490_g251511 = temp_output_464_0_g251511;
					half Bias490_g251511 = temp_output_504_0_g251511;
					float3 temp_output_482_0_g251511 = (Out_MaskN456_g251511).xyz;
					half3 Triplanar490_g251511 = temp_output_482_0_g251511;
					half3 NormalWS490_g251511 = temp_output_483_0_g251511;
					half3 Normal490_g251511 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251511 = SamplePlanar3D( Texture490_g251511 , Sampler490_g251511 , ZY490_g251511 , XZ490_g251511 , XY490_g251511 , Bias490_g251511 , Triplanar490_g251511 , NormalWS490_g251511 , Normal490_g251511 );
					float3 worldToTangentDir399_g251511 = normalize( mul( ase_worldToTangent, Normal490_g251511 ) );
					float2 temp_output_406_353_g251492 = (worldToTangentDir399_g251511).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251511) = _MainNormalTex;
					SamplerState Sampler498_g251511 = staticSwitch37_g251508;
					half2 XZ498_g251511 = temp_output_463_0_g251511;
					float2 temp_output_473_0_g251511 = (Out_MaskE456_g251511).xy;
					half2 XZ_1498_g251511 = temp_output_473_0_g251511;
					float2 temp_output_474_0_g251511 = (Out_MaskE456_g251511).zw;
					half2 XZ_2498_g251511 = temp_output_474_0_g251511;
					float2 temp_output_475_0_g251511 = (Out_MaskF456_g251511).xy;
					half2 XZ_3498_g251511 = temp_output_475_0_g251511;
					float temp_output_510_0_g251511 = exp2( temp_output_504_0_g251511 );
					half Bias498_g251511 = temp_output_510_0_g251511;
					float3 temp_output_480_0_g251511 = (Out_MaskI456_g251511).xyz;
					half3 Weights_2498_g251511 = temp_output_480_0_g251511;
					half3 NormalWS498_g251511 = temp_output_483_0_g251511;
					half3 Normal498_g251511 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251511 = SampleStochastic2D( Texture498_g251511 , Sampler498_g251511 , XZ498_g251511 , XZ_1498_g251511 , XZ_2498_g251511 , XZ_3498_g251511 , Bias498_g251511 , Weights_2498_g251511 , NormalWS498_g251511 , Normal498_g251511 );
					float3 worldToTangentDir411_g251511 = normalize( mul( ase_worldToTangent, Normal498_g251511 ) );
					float2 temp_output_406_391_g251492 = (worldToTangentDir411_g251511).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251511) = _MainNormalTex;
					SamplerState Sampler500_g251511 = staticSwitch37_g251508;
					half2 ZY500_g251511 = temp_output_462_0_g251511;
					half2 ZY_1500_g251511 = (Out_MaskC456_g251511).zw;
					half2 ZY_2500_g251511 = (Out_MaskD456_g251511).xy;
					half2 ZY_3500_g251511 = (Out_MaskD456_g251511).zw;
					half2 XZ500_g251511 = temp_output_463_0_g251511;
					half2 XZ_1500_g251511 = temp_output_473_0_g251511;
					half2 XZ_2500_g251511 = temp_output_474_0_g251511;
					half2 XZ_3500_g251511 = temp_output_475_0_g251511;
					half2 XY500_g251511 = temp_output_464_0_g251511;
					half2 XY_1500_g251511 = (Out_MaskF456_g251511).zw;
					half2 XY_2500_g251511 = (Out_MaskG456_g251511).xy;
					half2 XY_3500_g251511 = (Out_MaskG456_g251511).zw;
					half Bias500_g251511 = temp_output_510_0_g251511;
					half3 Weights_1500_g251511 = (Out_MaskH456_g251511).xyz;
					half3 Weights_2500_g251511 = temp_output_480_0_g251511;
					half3 Weights_3500_g251511 = (Out_MaskJ456_g251511).xyz;
					half3 Triplanar500_g251511 = temp_output_482_0_g251511;
					half3 NormalWS500_g251511 = temp_output_483_0_g251511;
					half3 Normal500_g251511 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251511 = SampleStochastic3D( Texture500_g251511 , Sampler500_g251511 , ZY500_g251511 , ZY_1500_g251511 , ZY_2500_g251511 , ZY_3500_g251511 , XZ500_g251511 , XZ_1500_g251511 , XZ_2500_g251511 , XZ_3500_g251511 , XY500_g251511 , XY_1500_g251511 , XY_2500_g251511 , XY_3500_g251511 , Bias500_g251511 , Weights_1500_g251511 , Weights_2500_g251511 , Weights_3500_g251511 , Triplanar500_g251511 , NormalWS500_g251511 , Normal500_g251511 );
					float3 worldToTangentDir403_g251511 = normalize( mul( ase_worldToTangent, Normal500_g251511 ) );
					float2 temp_output_406_390_g251492 = (worldToTangentDir403_g251511).xy;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g251492 = temp_output_406_394_g251492;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g251492 = temp_output_406_397_g251492;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g251492 = temp_output_406_375_g251492;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g251492 = temp_output_406_353_g251492;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g251492 = temp_output_406_391_g251492;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g251492 = temp_output_406_390_g251492;
					#else
					float2 staticSwitch193_g251492 = temp_output_406_394_g251492;
					#endif
					half2 Local_NormaSample191_g251492 = staticSwitch193_g251492;
					half2 Local_NormalTS108_g251492 = ( Local_NormaSample191_g251492 * _MainNormalValue );
					float2 In_NormalTS3_g251493 = Local_NormalTS108_g251492;
					float3 appendResult68_g251504 = (float3(Local_NormalTS108_g251492 , 1.0));
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal74_g251504 = appendResult68_g251504;
					float3 worldNormal74_g251504 = normalize( float3( dot( tanToWorld0, tanNormal74_g251504 ), dot( tanToWorld1, tanNormal74_g251504 ), dot( tanToWorld2, tanNormal74_g251504 ) ) );
					half3 Local_NormalWS250_g251492 = worldNormal74_g251504;
					float3 In_NormalWS3_g251493 = Local_NormalWS250_g251492;
					float4 In_Shader3_g251493 = Local_Masks109_g251492;
					float4 In_Feature3_g251493 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251493 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251493 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g251501 = Local_Albedo139_g251492;
					float dotResult20_g251501 = dot( temp_output_3_0_g251501 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g251492 = dotResult20_g251501;
					float temp_output_12_0_g251493 = Local_Grayscale110_g251492;
					float In_Grayscale3_g251493 = temp_output_12_0_g251493;
					float clampResult27_g251503 = clamp( saturate( ( Local_Grayscale110_g251492 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g251492 = clampResult27_g251503;
					float temp_output_16_0_g251493 = Local_Luminosity145_g251492;
					float In_Luminosity3_g251493 = temp_output_16_0_g251493;
					float In_MultiMask3_g251493 = Local_MultiMask78_g251492;
					float temp_output_187_0_g251492 = (Local_AlbedoSample185_g251492).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g251492 = ( temp_output_187_0_g251492 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g251492 = temp_output_187_0_g251492;
					#endif
					half Local_AlphaClip111_g251492 = staticSwitch236_g251492;
					float In_AlphaClip3_g251493 = Local_AlphaClip111_g251492;
					half Local_AlphaFade246_g251492 = (lerpResult62_g251492).a;
					float In_AlphaFade3_g251493 = Local_AlphaFade246_g251492;
					float3 temp_cast_20 = (1.0).xxx;
					float3 In_Translucency3_g251493 = temp_cast_20;
					float In_Transmission3_g251493 = 1.0;
					float In_Thickness3_g251493 = 0.0;
					float In_Diffusion3_g251493 = 0.0;
					float In_Depth3_g251493 = 0.0;
					BuildVisualData( Data3_g251493 , In_Dummy3_g251493 , In_Albedo3_g251493 , In_AlbedoBase3_g251493 , In_NormalTS3_g251493 , In_NormalWS3_g251493 , In_Shader3_g251493 , In_Feature3_g251493 , In_Season3_g251493 , In_Emissive3_g251493 , In_Grayscale3_g251493 , In_Luminosity3_g251493 , In_MultiMask3_g251493 , In_AlphaClip3_g251493 , In_AlphaFade3_g251493 , In_Translucency3_g251493 , In_Transmission3_g251493 , In_Thickness3_g251493 , In_Diffusion3_g251493 , In_Depth3_g251493 );
					TVEVisualData Data4_g251523 =(TVEVisualData)Data3_g251493;
					float Out_Dummy4_g251523 = 0.0;
					float3 Out_Albedo4_g251523 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251523 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251523 = float2( 0,0 );
					float3 Out_NormalWS4_g251523 = float3( 0,0,0 );
					float4 Out_Shader4_g251523 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251523 = float4( 0,0,0,0 );
					float4 Out_Season4_g251523 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251523 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251523 = 0.0;
					float Out_Grayscale4_g251523 = 0.0;
					float Out_Luminosity4_g251523 = 0.0;
					float Out_AlphaClip4_g251523 = 0.0;
					float Out_AlphaFade4_g251523 = 0.0;
					float3 Out_Translucency4_g251523 = float3( 0,0,0 );
					float Out_Transmission4_g251523 = 0.0;
					float Out_Thickness4_g251523 = 0.0;
					float Out_Diffusion4_g251523 = 0.0;
					float Out_Depth4_g251523 = 0.0;
					BreakVisualData( Data4_g251523 , Out_Dummy4_g251523 , Out_Albedo4_g251523 , Out_AlbedoBase4_g251523 , Out_NormalTS4_g251523 , Out_NormalWS4_g251523 , Out_Shader4_g251523 , Out_Feature4_g251523 , Out_Season4_g251523 , Out_Emissive4_g251523 , Out_MultiMask4_g251523 , Out_Grayscale4_g251523 , Out_Luminosity4_g251523 , Out_AlphaClip4_g251523 , Out_AlphaFade4_g251523 , Out_Translucency4_g251523 , Out_Transmission4_g251523 , Out_Thickness4_g251523 , Out_Diffusion4_g251523 , Out_Depth4_g251523 );
					float Alpha109_g251518 = Out_AlphaClip4_g251523;
					float lerpResult91_g251518 = lerp( 1.0 , Alpha109_g251518 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g251518 = lerp( 1.0 , lerpResult91_g251518 , Filter152_g251518);
					clip( lerpResult154_g251518 );
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

					o.Emission = ( lerpResult72_g251518 * lerpResult84_g251518 );
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
				#pragma shader_feature_local_vertex TVE_MOTION
				#pragma shader_feature_local_vertex TVE_MOTION_ELEMENT
				#pragma shader_feature_local TVE_LEGACY
				#if defined (TVE_MOTION) //Motion
					#define TVE_ROTATION_BEND //Motion
				#endif //Motion
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
				#define SAMPLE_TEXTURE3D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE3D_LOD(tex,samplerTex,coord,lod) tex3Dlod(tex,float4(coord,lod))
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
				uniform half _MotionCategory;
				uniform half _MotionEnd;
				uniform half _MotionPushInfo;
				uniform half4 TVE_WindParams;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MotionNoiseTex);
				uniform half _MotionSmallPivotValue;
				uniform half _MotionSmallPhaseValue;
				uniform half _MotionSmallTillingValue;
				uniform half4 TVE_MotionTimeParams;
				uniform half _MotionSmallSpeedValue;
				uniform half _MotionSmallNoiseValue;
				uniform half _MotionElementMode;
				uniform half4 TVE_WindEditor;
				uniform half _MotionIntensityValue;
				uniform half _MotionSmallDelayValue;
				uniform half _MotionSmallIntensityValue;
				uniform half _MotionSmallPushValue;
				uniform half _MotionSmallMaskMode;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MotionMaskTex);
				SamplerState sampler_MotionMaskTex;
				uniform half4 _MotionSmallMaskRemap;
				uniform half4 TVE_MotionValueParams;
				uniform half _MotionTinyIntensityValue;
				uniform half _MotionDistValue;
				uniform half _MotionTinyMaskMode;
				uniform half4 _MotionTinyMaskRemap;
				uniform half _MotionTinyTillingValue;
				uniform half _MotionTinySpeedValue;
				uniform half _MotionTinyNoiseValue;
				UNITY_DECLARE_TEX3D_NOSAMPLER(_NoiseTex3D);
				uniform half _MotionBasePivotValue;
				uniform half _MotionBasePhaseValue;
				uniform half _MotionBaseTillingValue;
				uniform half _MotionBaseSpeedValue;
				uniform half _MotionBaseNoiseValue;
				uniform half _MotionBaseIntensityValue;
				uniform half _MotionBaseDelayValue;
				uniform half _MotionBasePushValue;
				uniform half _MotionBaseMaskMode;
				uniform half4 _MotionBaseMaskRemap;
				uniform half _MotionHighlightValue;
				uniform half _motion_small_mode;
				uniform half4 _MotionHighlightColor;


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

					float localIfModelDataByShader26_g241935 = ( 0.0 );
					TVEModelData Data26_g241935 = (TVEModelData)0;
					TVEModelData Data16_g241848 =(TVEModelData)0;
					half Dummy207_g241838 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g241848 = Dummy207_g241838;
					float In_Dummy16_g241848 = temp_output_14_0_g241848;
					float3 PositionOS131_g241838 = v.vertex.xyz;
					float3 temp_output_4_0_g241848 = PositionOS131_g241838;
					float3 In_PositionOS16_g241848 = temp_output_4_0_g241848;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g241838 = ase_positionWS;
					float3 vertexToFrag73_g241838 = temp_output_104_7_g241838;
					float3 PositionWS122_g241838 = vertexToFrag73_g241838;
					float3 In_PositionWS16_g241848 = PositionWS122_g241838;
					float4x4 break19_g241841 = unity_ObjectToWorld;
					float3 appendResult20_g241841 = (float3(break19_g241841[ 0 ][ 3 ] , break19_g241841[ 1 ][ 3 ] , break19_g241841[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241838 = appendResult20_g241841;
					float4x4 break19_g241843 = unity_ObjectToWorld;
					float3 appendResult20_g241843 = (float3(break19_g241843[ 0 ][ 3 ] , break19_g241843[ 1 ][ 3 ] , break19_g241843[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g241839 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g241838 = PositionOS131_g241838;
					float3 appendResult234_g241838 = (float3(break233_g241838.x , 0.0 , break233_g241838.z));
					float3 break413_g241838 = PositionOS131_g241838;
					float3 appendResult414_g241838 = (float3(break413_g241838.x , break413_g241838.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g241845 = appendResult414_g241838;
					#else
					float3 staticSwitch65_g241845 = appendResult234_g241838;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g241838 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g241838 = appendResult60_g241839;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g241838 = staticSwitch65_g241845;
					#else
					float3 staticSwitch229_g241838 = _Vector0;
					#endif
					float3 PivotOS149_g241838 = staticSwitch229_g241838;
					float3 temp_output_122_0_g241843 = PivotOS149_g241838;
					float3 PivotsOnlyWS105_g241843 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g241843 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g241838 = ( appendResult20_g241843 + PivotsOnlyWS105_g241843 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g241838 = temp_output_340_7_g241838;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g241838 = temp_output_341_7_g241838;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g241838 = temp_output_341_7_g241838;
					#else
					float3 staticSwitch236_g241838 = temp_output_340_7_g241838;
					#endif
					float3 vertexToFrag76_g241838 = staticSwitch236_g241838;
					float3 PivotWS121_g241838 = vertexToFrag76_g241838;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241838 = ( PositionWS122_g241838 - PivotWS121_g241838 );
					#else
					float3 staticSwitch204_g241838 = PositionWS122_g241838;
					#endif
					float3 PositionWO132_g241838 = ( staticSwitch204_g241838 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241848 = PositionWO132_g241838;
					float3 In_PositionRawOS16_g241848 = PositionOS131_g241838;
					float3 In_PivotOS16_g241848 = PivotOS149_g241838;
					float3 In_PivotWS16_g241848 = PivotWS121_g241838;
					float3 PivotWO133_g241838 = ( PivotWS121_g241838 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241848 = PivotWO133_g241838;
					half3 NormalOS134_g241838 = v.normal;
					float3 temp_output_21_0_g241848 = NormalOS134_g241838;
					float3 In_NormalOS16_g241848 = temp_output_21_0_g241848;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g241838 = normalizedWorldNormal;
					float3 In_NormalWS16_g241848 = NormalWS95_g241838;
					float3 In_NormalRawOS16_g241848 = NormalOS134_g241838;
					half4 TangentlOS153_g241838 = v.tangent;
					float4 temp_output_6_0_g241848 = TangentlOS153_g241838;
					float4 In_TangentOS16_g241848 = temp_output_6_0_g241848;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g241838 = ase_tangentWS;
					float3 In_TangentWS16_g241848 = TangentWS136_g241838;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g241838 = ase_bitangentWS;
					float3 In_BitangentWS16_g241848 = BiangentWS421_g241838;
					float3 normalizeResult296_g241838 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241838 ) );
					half3 ViewDirWS169_g241838 = normalizeResult296_g241838;
					float3 In_ViewDirWS16_g241848 = ViewDirWS169_g241838;
					float4 appendResult397_g241838 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g241838 = appendResult397_g241838;
					float4 In_CoordsData16_g241848 = CoordsData398_g241838;
					half4 VertexMasks171_g241838 = v.ase_color;
					float4 In_VertexData16_g241848 = VertexMasks171_g241838;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241851 = (PositionOS131_g241838).z;
					#else
					float staticSwitch65_g241851 = (PositionOS131_g241838).y;
					#endif
					half Object_HeightValue267_g241838 = _ObjectHeightValue;
					half Bounds_HeightMask274_g241838 = saturate( ( staticSwitch65_g241851 / Object_HeightValue267_g241838 ) );
					half3 Position387_g241838 = PositionOS131_g241838;
					half Height387_g241838 = Object_HeightValue267_g241838;
					half Object_RadiusValue268_g241838 = _ObjectRadiusValue;
					half Radius387_g241838 = Object_RadiusValue268_g241838;
					half localCapsuleMaskYUp387_g241838 = CapsuleMaskYUp( Position387_g241838 , Height387_g241838 , Radius387_g241838 );
					half3 Position408_g241838 = PositionOS131_g241838;
					half Height408_g241838 = Object_HeightValue267_g241838;
					half Radius408_g241838 = Object_RadiusValue268_g241838;
					half localCapsuleMaskZUp408_g241838 = CapsuleMaskZUp( Position408_g241838 , Height408_g241838 , Radius408_g241838 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241856 = saturate( localCapsuleMaskZUp408_g241838 );
					#else
					float staticSwitch65_g241856 = saturate( localCapsuleMaskYUp387_g241838 );
					#endif
					half Bounds_SphereMask282_g241838 = staticSwitch65_g241856;
					float4 appendResult253_g241838 = (float4(Bounds_HeightMask274_g241838 , Bounds_SphereMask282_g241838 , 1.0 , 1.0));
					half4 MasksData254_g241838 = appendResult253_g241838;
					float4 In_MasksData16_g241848 = MasksData254_g241838;
					float temp_output_17_0_g241850 = _ObjectPhaseMode;
					float Option70_g241850 = temp_output_17_0_g241850;
					float4 temp_output_3_0_g241850 = v.ase_color;
					float4 Channel70_g241850 = temp_output_3_0_g241850;
					float localSwitchChannel470_g241850 = SwitchChannel4( Option70_g241850 , Channel70_g241850 );
					half Phase_Value372_g241838 = localSwitchChannel470_g241850;
					float3 break319_g241838 = PivotWO133_g241838;
					half Pivot_Position322_g241838 = ( break319_g241838.x + break319_g241838.z );
					half Phase_Position357_g241838 = ( Phase_Value372_g241838 + Pivot_Position322_g241838 );
					float temp_output_248_0_g241838 = frac( Phase_Position357_g241838 );
					float4 appendResult177_g241838 = (float4(( (frac( ( Phase_Position357_g241838 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g241838));
					half4 Phase_Data176_g241838 = appendResult177_g241838;
					float4 In_PhaseData16_g241848 = Phase_Data176_g241838;
					float4 In_TransformData16_g241848 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g241848 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g241848 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g241848 , In_Dummy16_g241848 , In_PositionOS16_g241848 , In_PositionWS16_g241848 , In_PositionWO16_g241848 , In_PositionRawOS16_g241848 , In_PivotOS16_g241848 , In_PivotWS16_g241848 , In_PivotWO16_g241848 , In_NormalOS16_g241848 , In_NormalWS16_g241848 , In_NormalRawOS16_g241848 , In_TangentOS16_g241848 , In_TangentWS16_g241848 , In_BitangentWS16_g241848 , In_ViewDirWS16_g241848 , In_CoordsData16_g241848 , In_VertexData16_g241848 , In_MasksData16_g241848 , In_PhaseData16_g241848 , In_TransformData16_g241848 , In_RotationData16_g241848 , In_InterpolatorA16_g241848 );
					TVEModelData DataDefault26_g241935 = Data16_g241848;
					TVEModelData DataGeneral26_g241935 = Data16_g241848;
					TVEModelData DataBlanket26_g241935 = Data16_g241848;
					TVEModelData DataImpostor26_g241935 = Data16_g241848;
					TVEModelData Data16_g241828 =(TVEModelData)0;
					half Dummy207_g241818 = 0.0;
					float temp_output_14_0_g241828 = Dummy207_g241818;
					float In_Dummy16_g241828 = temp_output_14_0_g241828;
					float3 PositionOS131_g241818 = v.vertex.xyz;
					float3 temp_output_4_0_g241828 = PositionOS131_g241818;
					float3 In_PositionOS16_g241828 = temp_output_4_0_g241828;
					float3 temp_output_104_7_g241818 = ase_positionWS;
					float3 PositionWS122_g241818 = temp_output_104_7_g241818;
					float3 In_PositionWS16_g241828 = PositionWS122_g241818;
					float4x4 break19_g241821 = unity_ObjectToWorld;
					float3 appendResult20_g241821 = (float3(break19_g241821[ 0 ][ 3 ] , break19_g241821[ 1 ][ 3 ] , break19_g241821[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241818 = appendResult20_g241821;
					float3 PivotWS121_g241818 = temp_output_340_7_g241818;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241818 = ( PositionWS122_g241818 - PivotWS121_g241818 );
					#else
					float3 staticSwitch204_g241818 = PositionWS122_g241818;
					#endif
					float3 PositionWO132_g241818 = ( staticSwitch204_g241818 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241828 = PositionWO132_g241818;
					float3 In_PositionRawOS16_g241828 = PositionOS131_g241818;
					float3 PivotOS149_g241818 = _Vector0;
					float3 In_PivotOS16_g241828 = PivotOS149_g241818;
					float3 In_PivotWS16_g241828 = PivotWS121_g241818;
					float3 PivotWO133_g241818 = ( PivotWS121_g241818 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241828 = PivotWO133_g241818;
					half3 NormalOS134_g241818 = v.normal;
					float3 temp_output_21_0_g241828 = NormalOS134_g241818;
					float3 In_NormalOS16_g241828 = temp_output_21_0_g241828;
					half3 NormalWS95_g241818 = normalizedWorldNormal;
					float3 In_NormalWS16_g241828 = NormalWS95_g241818;
					float3 In_NormalRawOS16_g241828 = NormalOS134_g241818;
					half4 TangentlOS153_g241818 = v.tangent;
					float4 temp_output_6_0_g241828 = TangentlOS153_g241818;
					float4 In_TangentOS16_g241828 = temp_output_6_0_g241828;
					half3 TangentWS136_g241818 = ase_tangentWS;
					float3 In_TangentWS16_g241828 = TangentWS136_g241818;
					half3 BiangentWS421_g241818 = ase_bitangentWS;
					float3 In_BitangentWS16_g241828 = BiangentWS421_g241818;
					float3 normalizeResult296_g241818 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241818 ) );
					half3 ViewDirWS169_g241818 = normalizeResult296_g241818;
					float3 In_ViewDirWS16_g241828 = ViewDirWS169_g241818;
					float4 appendResult397_g241818 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g241818 = appendResult397_g241818;
					float4 In_CoordsData16_g241828 = CoordsData398_g241818;
					half4 VertexMasks171_g241818 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241828 = VertexMasks171_g241818;
					half4 MasksData254_g241818 = float4( 0,0,0,0 );
					float4 In_MasksData16_g241828 = MasksData254_g241818;
					half4 Phase_Data176_g241818 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241828 = Phase_Data176_g241818;
					float4 In_TransformData16_g241828 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g241828 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g241828 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g241828 , In_Dummy16_g241828 , In_PositionOS16_g241828 , In_PositionWS16_g241828 , In_PositionWO16_g241828 , In_PositionRawOS16_g241828 , In_PivotOS16_g241828 , In_PivotWS16_g241828 , In_PivotWO16_g241828 , In_NormalOS16_g241828 , In_NormalWS16_g241828 , In_NormalRawOS16_g241828 , In_TangentOS16_g241828 , In_TangentWS16_g241828 , In_BitangentWS16_g241828 , In_ViewDirWS16_g241828 , In_CoordsData16_g241828 , In_VertexData16_g241828 , In_MasksData16_g241828 , In_PhaseData16_g241828 , In_TransformData16_g241828 , In_RotationData16_g241828 , In_InterpolatorA16_g241828 );
					TVEModelData DataTerrain26_g241935 = Data16_g241828;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g241935 = IsShaderType2637;
					{
					if (Type26_g241935 == 0 )
					{
					Data26_g241935 = DataDefault26_g241935;
					}
					else if (Type26_g241935 == 1 )
					{
					Data26_g241935 = DataGeneral26_g241935;
					}
					else if (Type26_g241935 == 2 )
					{
					Data26_g241935 = DataBlanket26_g241935;
					}
					else if (Type26_g241935 == 3 )
					{
					Data26_g241935 = DataImpostor26_g241935;
					}
					else if (Type26_g241935 == 4 )
					{
					Data26_g241935 = DataTerrain26_g241935;
					}
					}
					TVEModelData Data15_g251335 =(TVEModelData)Data26_g241935;
					float Out_Dummy15_g251335 = 0.0;
					float3 Out_PositionOS15_g251335 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251335 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251335 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251335 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251335 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251335 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251335 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251335 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251335 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251335 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251335 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251335 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251335 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251335 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251335 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251335 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251335 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251335 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251335 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251335 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251335 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251335 , Out_Dummy15_g251335 , Out_PositionOS15_g251335 , Out_PositionWS15_g251335 , Out_PositionWO15_g251335 , Out_PositionRawOS15_g251335 , Out_PivotOS15_g251335 , Out_PivotWS15_g251335 , Out_PivotWO15_g251335 , Out_NormalOS15_g251335 , Out_NormalWS15_g251335 , Out_NormalRawOS15_g251335 , Out_TangentOS15_g251335 , Out_TangentWS15_g251335 , Out_BitangentWS15_g251335 , Out_ViewDirWS15_g251335 , Out_CoordsData15_g251335 , Out_VertexData15_g251335 , Out_MasksData15_g251335 , Out_PhaseData15_g251335 , Out_TransformData15_g251335 , Out_RotationData15_g251335 , Out_InterpolatorA15_g251335 );
					TVEModelData Data16_g251337 =(TVEModelData)Data15_g251335;
					float temp_output_14_0_g251337 = 0.0;
					float In_Dummy16_g251337 = temp_output_14_0_g251337;
					float3 temp_output_219_24_g251334 = Out_PivotOS15_g251335;
					float3 temp_output_215_0_g251334 = ( Out_PositionOS15_g251335 - temp_output_219_24_g251334 );
					float3 temp_output_4_0_g251337 = temp_output_215_0_g251334;
					float3 In_PositionOS16_g251337 = temp_output_4_0_g251337;
					float3 In_PositionWS16_g251337 = Out_PositionWS15_g251335;
					float3 In_PositionWO16_g251337 = Out_PositionWO15_g251335;
					float3 In_PositionRawOS16_g251337 = Out_PositionRawOS15_g251335;
					float3 In_PivotOS16_g251337 = temp_output_219_24_g251334;
					float3 In_PivotWS16_g251337 = Out_PivotWS15_g251335;
					float3 In_PivotWO16_g251337 = Out_PivotWO15_g251335;
					float3 temp_output_21_0_g251337 = Out_NormalOS15_g251335;
					float3 In_NormalOS16_g251337 = temp_output_21_0_g251337;
					float3 In_NormalWS16_g251337 = Out_NormalWS15_g251335;
					float3 In_NormalRawOS16_g251337 = Out_NormalRawOS15_g251335;
					float4 temp_output_6_0_g251337 = Out_TangentOS15_g251335;
					float4 In_TangentOS16_g251337 = temp_output_6_0_g251337;
					float3 In_TangentWS16_g251337 = Out_TangentWS15_g251335;
					float3 In_BitangentWS16_g251337 = Out_BitangentWS15_g251335;
					float3 In_ViewDirWS16_g251337 = Out_ViewDirWS15_g251335;
					float4 In_CoordsData16_g251337 = Out_CoordsData15_g251335;
					float4 In_VertexData16_g251337 = Out_VertexData15_g251335;
					float4 In_MasksData16_g251337 = Out_MasksData15_g251335;
					float4 In_PhaseData16_g251337 = Out_PhaseData15_g251335;
					float4 In_TransformData16_g251337 = Out_TransformData15_g251335;
					float4 In_RotationData16_g251337 = Out_RotationData15_g251335;
					float4 In_InterpolatorA16_g251337 = Out_InterpolatorA15_g251335;
					BuildModelVertData( Data16_g251337 , In_Dummy16_g251337 , In_PositionOS16_g251337 , In_PositionWS16_g251337 , In_PositionWO16_g251337 , In_PositionRawOS16_g251337 , In_PivotOS16_g251337 , In_PivotWS16_g251337 , In_PivotWO16_g251337 , In_NormalOS16_g251337 , In_NormalWS16_g251337 , In_NormalRawOS16_g251337 , In_TangentOS16_g251337 , In_TangentWS16_g251337 , In_BitangentWS16_g251337 , In_ViewDirWS16_g251337 , In_CoordsData16_g251337 , In_VertexData16_g251337 , In_MasksData16_g251337 , In_PhaseData16_g251337 , In_TransformData16_g251337 , In_RotationData16_g251337 , In_InterpolatorA16_g251337 );
					TVEModelData Data15_g251366 =(TVEModelData)Data16_g251337;
					float Out_Dummy15_g251366 = 0.0;
					float3 Out_PositionOS15_g251366 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251366 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251366 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251366 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251366 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251366 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251366 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251366 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251366 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251366 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251366 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251366 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251366 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251366 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251366 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251366 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251366 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251366 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251366 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251366 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251366 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251366 , Out_Dummy15_g251366 , Out_PositionOS15_g251366 , Out_PositionWS15_g251366 , Out_PositionWO15_g251366 , Out_PositionRawOS15_g251366 , Out_PivotOS15_g251366 , Out_PivotWS15_g251366 , Out_PivotWO15_g251366 , Out_NormalOS15_g251366 , Out_NormalWS15_g251366 , Out_NormalRawOS15_g251366 , Out_TangentOS15_g251366 , Out_TangentWS15_g251366 , Out_BitangentWS15_g251366 , Out_ViewDirWS15_g251366 , Out_CoordsData15_g251366 , Out_VertexData15_g251366 , Out_MasksData15_g251366 , Out_PhaseData15_g251366 , Out_TransformData15_g251366 , Out_RotationData15_g251366 , Out_InterpolatorA15_g251366 );
					TVEModelData Data16_g251367 =(TVEModelData)Data15_g251366;
					half Dummy317_g251365 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g251367 = Dummy317_g251365;
					float In_Dummy16_g251367 = temp_output_14_0_g251367;
					float3 temp_output_4_0_g251367 = Out_PositionOS15_g251366;
					float3 In_PositionOS16_g251367 = temp_output_4_0_g251367;
					float3 In_PositionWS16_g251367 = Out_PositionWS15_g251366;
					float3 temp_output_314_17_g251365 = Out_PositionWO15_g251366;
					float3 In_PositionWO16_g251367 = temp_output_314_17_g251365;
					float3 In_PositionRawOS16_g251367 = Out_PositionRawOS15_g251366;
					float3 In_PivotOS16_g251367 = Out_PivotOS15_g251366;
					float3 In_PivotWS16_g251367 = Out_PivotWS15_g251366;
					float3 temp_output_314_19_g251365 = Out_PivotWO15_g251366;
					float3 In_PivotWO16_g251367 = temp_output_314_19_g251365;
					float3 temp_output_21_0_g251367 = Out_NormalOS15_g251366;
					float3 In_NormalOS16_g251367 = temp_output_21_0_g251367;
					float3 In_NormalWS16_g251367 = Out_NormalWS15_g251366;
					float3 In_NormalRawOS16_g251367 = Out_NormalRawOS15_g251366;
					float4 temp_output_6_0_g251367 = Out_TangentOS15_g251366;
					float4 In_TangentOS16_g251367 = temp_output_6_0_g251367;
					float3 In_TangentWS16_g251367 = Out_TangentWS15_g251366;
					float3 In_BitangentWS16_g251367 = Out_BitangentWS15_g251366;
					float3 In_ViewDirWS16_g251367 = Out_ViewDirWS15_g251366;
					float4 In_CoordsData16_g251367 = Out_CoordsData15_g251366;
					float4 temp_output_314_29_g251365 = Out_VertexData15_g251366;
					float4 In_VertexData16_g251367 = temp_output_314_29_g251365;
					float4 In_MasksData16_g251367 = Out_MasksData15_g251366;
					float4 In_PhaseData16_g251367 = Out_PhaseData15_g251366;
					half4 Model_TransformData356_g251365 = Out_TransformData15_g251366;
					float localBuildGlobalData204_g241858 = ( 0.0 );
					TVEGlobalData Data204_g241858 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g241858 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g241858 = Dummy211_g241858;
					float4 temp_output_589_164_g241858 = TVE_CoatParams;
					half4 Coat_Params596_g241858 = temp_output_589_164_g241858;
					float4 In_CoatParams204_g241858 = Coat_Params596_g241858;
					float4 temp_output_203_0_g241878 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g241817 = ( 0.0 );
					TVEModelData Data26_g241817 = (TVEModelData)0;
					TVEModelData Data16_g241846 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241846 = 0.0;
					float3 In_PositionWS16_g241846 = PositionWS122_g241838;
					float3 In_PositionWO16_g241846 = PositionWO132_g241838;
					float3 In_PivotWS16_g241846 = PivotWS121_g241838;
					float3 In_PivotWO16_g241846 = PivotWO133_g241838;
					float3 In_NormalWS16_g241846 = NormalWS95_g241838;
					float3 In_TangentWS16_g241846 = TangentWS136_g241838;
					float3 In_BitangentWS16_g241846 = BiangentWS421_g241838;
					half3 NormalWS427_g241838 = NormalWS95_g241838;
					half3 localComputeTriplanarWeights427_g241838 = ComputeTriplanarWeights( NormalWS427_g241838 );
					half3 TriplanarWeights429_g241838 = localComputeTriplanarWeights427_g241838;
					float3 In_TriplanarWeights16_g241846 = TriplanarWeights429_g241838;
					float3 In_ViewDirWS16_g241846 = ViewDirWS169_g241838;
					float4 In_CoordsData16_g241846 = CoordsData398_g241838;
					float4 In_VertexData16_g241846 = VertexMasks171_g241838;
					float4 In_PhaseData16_g241846 = Phase_Data176_g241838;
					BuildModelFragData( Data16_g241846 , In_Dummy16_g241846 , In_PositionWS16_g241846 , In_PositionWO16_g241846 , In_PivotWS16_g241846 , In_PivotWO16_g241846 , In_NormalWS16_g241846 , In_TangentWS16_g241846 , In_BitangentWS16_g241846 , In_TriplanarWeights16_g241846 , In_ViewDirWS16_g241846 , In_CoordsData16_g241846 , In_VertexData16_g241846 , In_PhaseData16_g241846 );
					TVEModelData DataDefault26_g241817 = Data16_g241846;
					TVEModelData DataGeneral26_g241817 = Data16_g241846;
					TVEModelData DataBlanket26_g241817 = Data16_g241846;
					TVEModelData DataImpostor26_g241817 = Data16_g241846;
					TVEModelData Data16_g241826 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241826 = 0.0;
					float3 In_PositionWS16_g241826 = PositionWS122_g241818;
					float3 In_PositionWO16_g241826 = PositionWO132_g241818;
					float3 In_PivotWS16_g241826 = PivotWS121_g241818;
					float3 In_PivotWO16_g241826 = PivotWO133_g241818;
					float3 In_NormalWS16_g241826 = NormalWS95_g241818;
					float3 In_TangentWS16_g241826 = TangentWS136_g241818;
					float3 In_BitangentWS16_g241826 = BiangentWS421_g241818;
					half3 NormalWS427_g241818 = NormalWS95_g241818;
					half3 localComputeTriplanarWeights427_g241818 = ComputeTriplanarWeights( NormalWS427_g241818 );
					half3 TriplanarWeights429_g241818 = localComputeTriplanarWeights427_g241818;
					float3 In_TriplanarWeights16_g241826 = TriplanarWeights429_g241818;
					float3 In_ViewDirWS16_g241826 = ViewDirWS169_g241818;
					float4 In_CoordsData16_g241826 = CoordsData398_g241818;
					float4 In_VertexData16_g241826 = VertexMasks171_g241818;
					float4 In_PhaseData16_g241826 = Phase_Data176_g241818;
					BuildModelFragData( Data16_g241826 , In_Dummy16_g241826 , In_PositionWS16_g241826 , In_PositionWO16_g241826 , In_PivotWS16_g241826 , In_PivotWO16_g241826 , In_NormalWS16_g241826 , In_TangentWS16_g241826 , In_BitangentWS16_g241826 , In_TriplanarWeights16_g241826 , In_ViewDirWS16_g241826 , In_CoordsData16_g241826 , In_VertexData16_g241826 , In_PhaseData16_g241826 );
					TVEModelData DataTerrain26_g241817 = Data16_g241826;
					float Type26_g241817 = IsShaderType2637;
					{
					if (Type26_g241817 == 0 )
					{
					Data26_g241817 = DataDefault26_g241817;
					}
					else if (Type26_g241817 == 1 )
					{
					Data26_g241817 = DataGeneral26_g241817;
					}
					else if (Type26_g241817 == 2 )
					{
					Data26_g241817 = DataBlanket26_g241817;
					}
					else if (Type26_g241817 == 3 )
					{
					Data26_g241817 = DataImpostor26_g241817;
					}
					else if (Type26_g241817 == 4 )
					{
					Data26_g241817 = DataTerrain26_g241817;
					}
					}
					TVEModelData Data15_g241934 =(TVEModelData)Data26_g241817;
					float Out_Dummy15_g241934 = 0.0;
					float3 Out_PositionWS15_g241934 = float3( 0,0,0 );
					float3 Out_PositionWO15_g241934 = float3( 0,0,0 );
					float3 Out_PivotWS15_g241934 = float3( 0,0,0 );
					float3 Out_PivotWO15_g241934 = float3( 0,0,0 );
					float3 Out_NormalWS15_g241934 = float3( 0,0,0 );
					float3 Out_TangentWS15_g241934 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g241934 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g241934 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g241934 = float3( 0,0,0 );
					float4 Out_CoordsData15_g241934 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g241934 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g241934 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g241934 , Out_Dummy15_g241934 , Out_PositionWS15_g241934 , Out_PositionWO15_g241934 , Out_PivotWS15_g241934 , Out_PivotWO15_g241934 , Out_NormalWS15_g241934 , Out_TangentWS15_g241934 , Out_BitangentWS15_g241934 , Out_TriplanarWeights15_g241934 , Out_ViewDirWS15_g241934 , Out_CoordsData15_g241934 , Out_VertexData15_g241934 , Out_PhaseData15_g241934 );
					float3 Model_PositionWS497_g241858 = Out_PositionWS15_g241934;
					float2 Model_PositionWS_XZ143_g241858 = (Model_PositionWS497_g241858).xz;
					float3 Model_PivotWS498_g241858 = Out_PivotWS15_g241934;
					float2 Model_PivotWS_XZ145_g241858 = (Model_PivotWS498_g241858).xz;
					float2 lerpResult300_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g241878 = lerpResult300_g241858;
					float temp_output_82_0_g241876 = _GlobalCoatLayerValue;
					float temp_output_82_0_g241878 = temp_output_82_0_g241876;
					float4 tex2DArrayNode83_g241878 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241878).zw + ( (temp_output_203_0_g241878).xy * temp_output_81_0_g241878 ) ),temp_output_82_0_g241878), 0.0 );
					float4 appendResult210_g241878 = (float4(tex2DArrayNode83_g241878.rgb , saturate( tex2DArrayNode83_g241878.a )));
					float4 temp_output_204_0_g241878 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g241878 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241878).zw + ( (temp_output_204_0_g241878).xy * temp_output_81_0_g241878 ) ),temp_output_82_0_g241878), 0.0 );
					float4 appendResult212_g241878 = (float4(tex2DArrayNode122_g241878.rgb , saturate( tex2DArrayNode122_g241878.a )));
					float4 TVE_RenderNearPositionR628_g241858 = TVE_RenderNearPositionR;
					float temp_output_507_0_g241858 = saturate( ( distance( Model_PositionWS497_g241858 , (TVE_RenderNearPositionR628_g241858).xyz ) / (TVE_RenderNearPositionR628_g241858).w ) );
					float temp_output_7_0_g241859 = 1.0;
					float temp_output_9_0_g241859 = ( temp_output_507_0_g241858 - temp_output_7_0_g241859 );
					half TVE_RenderNearFadeValue635_g241858 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g241858 = saturate( ( temp_output_9_0_g241859 / ( ( TVE_RenderNearFadeValue635_g241858 - temp_output_7_0_g241859 ) + 0.0001 ) ) );
					float4 lerpResult131_g241878 = lerp( appendResult210_g241878 , appendResult212_g241878 , Global_TexBlend509_g241858);
					float4 temp_output_159_109_g241876 = lerpResult131_g241878;
					float4 lerpResult168_g241876 = lerp( TVE_CoatParams , temp_output_159_109_g241876 , TVE_CoatLayers[(int)temp_output_82_0_g241876]);
					float4 temp_output_589_109_g241858 = lerpResult168_g241876;
					half4 Coat_Texture302_g241858 = temp_output_589_109_g241858;
					float4 In_CoatTexture204_g241858 = Coat_Texture302_g241858;
					float4 temp_output_595_164_g241858 = TVE_PaintParams;
					half4 Paint_Params575_g241858 = temp_output_595_164_g241858;
					float4 In_PaintParams204_g241858 = Paint_Params575_g241858;
					float4 temp_output_203_0_g241927 = TVE_PaintBaseCoord;
					float2 lerpResult85_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g241927 = lerpResult85_g241858;
					float temp_output_82_0_g241924 = _GlobalPaintLayerValue;
					float temp_output_82_0_g241927 = temp_output_82_0_g241924;
					float4 tex2DArrayNode83_g241927 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241927).zw + ( (temp_output_203_0_g241927).xy * temp_output_81_0_g241927 ) ),temp_output_82_0_g241927), 0.0 );
					float4 appendResult210_g241927 = (float4(tex2DArrayNode83_g241927.rgb , saturate( tex2DArrayNode83_g241927.a )));
					float4 temp_output_204_0_g241927 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g241927 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241927).zw + ( (temp_output_204_0_g241927).xy * temp_output_81_0_g241927 ) ),temp_output_82_0_g241927), 0.0 );
					float4 appendResult212_g241927 = (float4(tex2DArrayNode122_g241927.rgb , saturate( tex2DArrayNode122_g241927.a )));
					float4 lerpResult131_g241927 = lerp( appendResult210_g241927 , appendResult212_g241927 , Global_TexBlend509_g241858);
					float4 temp_output_171_109_g241924 = lerpResult131_g241927;
					float4 lerpResult174_g241924 = lerp( TVE_PaintParams , temp_output_171_109_g241924 , TVE_PaintLayers[(int)temp_output_82_0_g241924]);
					float4 temp_output_595_109_g241858 = lerpResult174_g241924;
					half4 Paint_Texture71_g241858 = temp_output_595_109_g241858;
					float4 In_PaintTexture204_g241858 = Paint_Texture71_g241858;
					float4 temp_output_590_141_g241858 = TVE_AtmoParams;
					half4 Atmo_Params601_g241858 = temp_output_590_141_g241858;
					float4 In_AtmoParams204_g241858 = Atmo_Params601_g241858;
					float4 temp_output_203_0_g241886 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g241886 = lerpResult104_g241858;
					float temp_output_132_0_g241884 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g241886 = temp_output_132_0_g241884;
					float4 tex2DArrayNode83_g241886 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241886).zw + ( (temp_output_203_0_g241886).xy * temp_output_81_0_g241886 ) ),temp_output_82_0_g241886), 0.0 );
					float4 appendResult210_g241886 = (float4(tex2DArrayNode83_g241886.rgb , saturate( tex2DArrayNode83_g241886.a )));
					float4 temp_output_204_0_g241886 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g241886 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241886).zw + ( (temp_output_204_0_g241886).xy * temp_output_81_0_g241886 ) ),temp_output_82_0_g241886), 0.0 );
					float4 appendResult212_g241886 = (float4(tex2DArrayNode122_g241886.rgb , saturate( tex2DArrayNode122_g241886.a )));
					float4 lerpResult131_g241886 = lerp( appendResult210_g241886 , appendResult212_g241886 , Global_TexBlend509_g241858);
					float4 temp_output_137_109_g241884 = lerpResult131_g241886;
					float4 lerpResult145_g241884 = lerp( TVE_AtmoParams , temp_output_137_109_g241884 , TVE_AtmoLayers[(int)temp_output_132_0_g241884]);
					float4 temp_output_590_110_g241858 = lerpResult145_g241884;
					half4 Atmo_Texture80_g241858 = temp_output_590_110_g241858;
					float4 In_AtmoTexture204_g241858 = Atmo_Texture80_g241858;
					float4 temp_output_593_163_g241858 = TVE_GlowParams;
					half4 Glow_Params609_g241858 = temp_output_593_163_g241858;
					float4 In_GlowParams204_g241858 = Glow_Params609_g241858;
					float4 temp_output_203_0_g241902 = TVE_GlowBaseCoord;
					float2 lerpResult247_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g241902 = lerpResult247_g241858;
					float temp_output_82_0_g241900 = _GlobalGlowLayerValue;
					float temp_output_82_0_g241902 = temp_output_82_0_g241900;
					float4 tex2DArrayNode83_g241902 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241902).zw + ( (temp_output_203_0_g241902).xy * temp_output_81_0_g241902 ) ),temp_output_82_0_g241902), 0.0 );
					float4 appendResult210_g241902 = (float4(tex2DArrayNode83_g241902.rgb , saturate( tex2DArrayNode83_g241902.a )));
					float4 temp_output_204_0_g241902 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g241902 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241902).zw + ( (temp_output_204_0_g241902).xy * temp_output_81_0_g241902 ) ),temp_output_82_0_g241902), 0.0 );
					float4 appendResult212_g241902 = (float4(tex2DArrayNode122_g241902.rgb , saturate( tex2DArrayNode122_g241902.a )));
					float4 lerpResult131_g241902 = lerp( appendResult210_g241902 , appendResult212_g241902 , Global_TexBlend509_g241858);
					float4 temp_output_159_109_g241900 = lerpResult131_g241902;
					float4 lerpResult167_g241900 = lerp( TVE_GlowParams , temp_output_159_109_g241900 , TVE_GlowLayers[(int)temp_output_82_0_g241900]);
					float4 temp_output_593_109_g241858 = lerpResult167_g241900;
					half4 Glow_Texture248_g241858 = temp_output_593_109_g241858;
					float4 In_GlowTexture204_g241858 = Glow_Texture248_g241858;
					float4 temp_output_592_139_g241858 = TVE_FormParams;
					float4 Form_Params606_g241858 = temp_output_592_139_g241858;
					float4 In_FormParams204_g241858 = Form_Params606_g241858;
					float4 temp_output_203_0_g241918 = TVE_FormBaseCoord;
					float2 lerpResult168_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g241918 = lerpResult168_g241858;
					float temp_output_130_0_g241916 = _GlobalFormLayerValue;
					float temp_output_82_0_g241918 = temp_output_130_0_g241916;
					float4 tex2DArrayNode83_g241918 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241918).zw + ( (temp_output_203_0_g241918).xy * temp_output_81_0_g241918 ) ),temp_output_82_0_g241918), 0.0 );
					float4 appendResult210_g241918 = (float4(tex2DArrayNode83_g241918.rgb , saturate( tex2DArrayNode83_g241918.a )));
					float4 temp_output_204_0_g241918 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g241918 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241918).zw + ( (temp_output_204_0_g241918).xy * temp_output_81_0_g241918 ) ),temp_output_82_0_g241918), 0.0 );
					float4 appendResult212_g241918 = (float4(tex2DArrayNode122_g241918.rgb , saturate( tex2DArrayNode122_g241918.a )));
					float4 lerpResult131_g241918 = lerp( appendResult210_g241918 , appendResult212_g241918 , Global_TexBlend509_g241858);
					float4 temp_output_135_109_g241916 = lerpResult131_g241918;
					float4 lerpResult143_g241916 = lerp( TVE_FormParams , temp_output_135_109_g241916 , TVE_FormLayers[(int)temp_output_130_0_g241916]);
					float4 temp_output_592_0_g241858 = lerpResult143_g241916;
					float4 Form_Texture112_g241858 = temp_output_592_0_g241858;
					float4 In_FormTexture204_g241858 = Form_Texture112_g241858;
					float4 temp_output_594_145_g241858 = TVE_FlowParams;
					half4 Flow_Params612_g241858 = temp_output_594_145_g241858;
					float4 In_FlowParams204_g241858 = Flow_Params612_g241858;
					float4 temp_output_203_0_g241910 = TVE_FlowBaseCoord;
					float2 lerpResult400_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g241910 = lerpResult400_g241858;
					float temp_output_136_0_g241908 = _GlobalFlowLayerValue;
					float temp_output_82_0_g241910 = temp_output_136_0_g241908;
					float4 tex2DArrayNode83_g241910 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241910).zw + ( (temp_output_203_0_g241910).xy * temp_output_81_0_g241910 ) ),temp_output_82_0_g241910), 0.0 );
					float4 appendResult210_g241910 = (float4(tex2DArrayNode83_g241910.rgb , saturate( tex2DArrayNode83_g241910.a )));
					float4 temp_output_204_0_g241910 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g241910 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241910).zw + ( (temp_output_204_0_g241910).xy * temp_output_81_0_g241910 ) ),temp_output_82_0_g241910), 0.0 );
					float4 appendResult212_g241910 = (float4(tex2DArrayNode122_g241910.rgb , saturate( tex2DArrayNode122_g241910.a )));
					float4 lerpResult131_g241910 = lerp( appendResult210_g241910 , appendResult212_g241910 , Global_TexBlend509_g241858);
					float4 temp_output_141_109_g241908 = lerpResult131_g241910;
					float4 lerpResult149_g241908 = lerp( TVE_FlowParams , temp_output_141_109_g241908 , TVE_FlowLayers[(int)temp_output_136_0_g241908]);
					half4 Flow_Texture405_g241858 = lerpResult149_g241908;
					float4 In_FlowTexture204_g241858 = Flow_Texture405_g241858;
					BuildGlobalData( Data204_g241858 , In_Dummy204_g241858 , In_CoatParams204_g241858 , In_CoatTexture204_g241858 , In_PaintParams204_g241858 , In_PaintTexture204_g241858 , In_AtmoParams204_g241858 , In_AtmoTexture204_g241858 , In_GlowParams204_g241858 , In_GlowTexture204_g241858 , In_FormParams204_g241858 , In_FormTexture204_g241858 , In_FlowParams204_g241858 , In_FlowTexture204_g241858 );
					TVEGlobalData Data15_g251368 =(TVEGlobalData)Data204_g241858;
					float Out_Dummy15_g251368 = 0.0;
					float4 Out_CoatParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251368 = float4( 0,0,0,0 );
					BreakData( Data15_g251368 , Out_Dummy15_g251368 , Out_CoatParams15_g251368 , Out_CoatTexture15_g251368 , Out_PaintParams15_g251368 , Out_PaintTexture15_g251368 , Out_AtmoParams15_g251368 , Out_AtmoTexture15_g251368 , Out_GlowParams15_g251368 , Out_GlowTexture15_g251368 , Out_FormParams15_g251368 , Out_FormTexture15_g251368 , Out_FlowParams15_g251368 , Out_FlowTexture15_g251368 );
					float4 Global_FormTexture351_g251365 = Out_FormTexture15_g251368;
					float3 Model_PivotWO353_g251365 = temp_output_314_19_g251365;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251374 = _ConformMeshMode;
					float Option70_g251374 = temp_output_17_0_g251374;
					half4 Model_VertexData357_g251365 = temp_output_314_29_g251365;
					float4 temp_output_3_0_g251374 = Model_VertexData357_g251365;
					float4 Channel70_g251374 = temp_output_3_0_g251374;
					float localSwitchChannel470_g251374 = SwitchChannel4( Option70_g251374 , Channel70_g251374 );
					float temp_output_390_0_g251365 = localSwitchChannel470_g251374;
					float temp_output_7_0_g251371 = _ConformMeshRemap.x;
					float temp_output_9_0_g251371 = ( temp_output_390_0_g251365 - temp_output_7_0_g251371 );
					float lerpResult374_g251365 = lerp( 1.0 , saturate( ( temp_output_9_0_g251371 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251365 = lerpResult374_g251365;
					float temp_output_328_0_g251365 = ( Blend_VertMask379_g251365 * TVE_IsEnabled );
					half Conform_Mask366_g251365 = temp_output_328_0_g251365;
					float temp_output_322_0_g251365 = ( ( ( ( (Global_FormTexture351_g251365).z - ( (Model_PivotWO353_g251365).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251365 ) );
					float3 appendResult329_g251365 = (float3(0.0 , temp_output_322_0_g251365 , 0.0));
					float3 appendResult387_g251365 = (float3(0.0 , 0.0 , temp_output_322_0_g251365));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251372 = appendResult387_g251365;
					#else
					float3 staticSwitch65_g251372 = appendResult329_g251365;
					#endif
					float3 Blanket_Conform368_g251365 = staticSwitch65_g251372;
					float4 appendResult312_g251365 = (float4(Blanket_Conform368_g251365 , 0.0));
					float4 temp_output_310_0_g251365 = ( Model_TransformData356_g251365 + appendResult312_g251365 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251365 = temp_output_310_0_g251365;
					#else
					float4 staticSwitch364_g251365 = Model_TransformData356_g251365;
					#endif
					half4 Final_TransformData365_g251365 = staticSwitch364_g251365;
					float4 In_TransformData16_g251367 = Final_TransformData365_g251365;
					float4 In_RotationData16_g251367 = Out_RotationData15_g251366;
					float4 In_InterpolatorA16_g251367 = Out_InterpolatorA15_g251366;
					BuildModelVertData( Data16_g251367 , In_Dummy16_g251367 , In_PositionOS16_g251367 , In_PositionWS16_g251367 , In_PositionWO16_g251367 , In_PositionRawOS16_g251367 , In_PivotOS16_g251367 , In_PivotWS16_g251367 , In_PivotWO16_g251367 , In_NormalOS16_g251367 , In_NormalWS16_g251367 , In_NormalRawOS16_g251367 , In_TangentOS16_g251367 , In_TangentWS16_g251367 , In_BitangentWS16_g251367 , In_ViewDirWS16_g251367 , In_CoordsData16_g251367 , In_VertexData16_g251367 , In_MasksData16_g251367 , In_PhaseData16_g251367 , In_TransformData16_g251367 , In_RotationData16_g251367 , In_InterpolatorA16_g251367 );
					TVEModelData Data15_g251424 =(TVEModelData)Data16_g251367;
					float Out_Dummy15_g251424 = 0.0;
					float3 Out_PositionOS15_g251424 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251424 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251424 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251424 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251424 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251424 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251424 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251424 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251424 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251424 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251424 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251424 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251424 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251424 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251424 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251424 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251424 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251424 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251424 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251424 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251424 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251424 , Out_Dummy15_g251424 , Out_PositionOS15_g251424 , Out_PositionWS15_g251424 , Out_PositionWO15_g251424 , Out_PositionRawOS15_g251424 , Out_PivotOS15_g251424 , Out_PivotWS15_g251424 , Out_PivotWO15_g251424 , Out_NormalOS15_g251424 , Out_NormalWS15_g251424 , Out_NormalRawOS15_g251424 , Out_TangentOS15_g251424 , Out_TangentWS15_g251424 , Out_BitangentWS15_g251424 , Out_ViewDirWS15_g251424 , Out_CoordsData15_g251424 , Out_VertexData15_g251424 , Out_MasksData15_g251424 , Out_PhaseData15_g251424 , Out_TransformData15_g251424 , Out_RotationData15_g251424 , Out_InterpolatorA15_g251424 );
					TVEModelData Data16_g251423 =(TVEModelData)Data15_g251424;
					half Dummy181_g251422 = ( ( _MotionCategory + _MotionEnd ) + _MotionPushInfo );
					float temp_output_14_0_g251423 = Dummy181_g251422;
					float In_Dummy16_g251423 = temp_output_14_0_g251423;
					float3 temp_output_2772_0_g251422 = Out_PositionOS15_g251424;
					float3 temp_output_4_0_g251423 = temp_output_2772_0_g251422;
					float3 In_PositionOS16_g251423 = temp_output_4_0_g251423;
					float3 temp_output_2772_16_g251422 = Out_PositionWS15_g251424;
					float3 In_PositionWS16_g251423 = temp_output_2772_16_g251422;
					float3 temp_output_2772_17_g251422 = Out_PositionWO15_g251424;
					float3 In_PositionWO16_g251423 = temp_output_2772_17_g251422;
					float3 In_PositionRawOS16_g251423 = Out_PositionRawOS15_g251424;
					float3 temp_output_2772_24_g251422 = Out_PivotOS15_g251424;
					float3 In_PivotOS16_g251423 = temp_output_2772_24_g251422;
					float3 In_PivotWS16_g251423 = Out_PivotWS15_g251424;
					float3 temp_output_2772_19_g251422 = Out_PivotWO15_g251424;
					float3 In_PivotWO16_g251423 = temp_output_2772_19_g251422;
					float3 temp_output_2772_20_g251422 = Out_NormalOS15_g251424;
					float3 temp_output_21_0_g251423 = temp_output_2772_20_g251422;
					float3 In_NormalOS16_g251423 = temp_output_21_0_g251423;
					float3 In_NormalWS16_g251423 = Out_NormalWS15_g251424;
					float3 In_NormalRawOS16_g251423 = Out_NormalRawOS15_g251424;
					float4 temp_output_6_0_g251423 = Out_TangentOS15_g251424;
					float4 In_TangentOS16_g251423 = temp_output_6_0_g251423;
					float3 In_TangentWS16_g251423 = Out_TangentWS15_g251424;
					float3 In_BitangentWS16_g251423 = Out_BitangentWS15_g251424;
					float3 In_ViewDirWS16_g251423 = Out_ViewDirWS15_g251424;
					float4 In_CoordsData16_g251423 = Out_CoordsData15_g251424;
					float4 temp_output_2772_29_g251422 = Out_VertexData15_g251424;
					float4 In_VertexData16_g251423 = temp_output_2772_29_g251422;
					float4 temp_output_2772_30_g251422 = Out_MasksData15_g251424;
					float4 In_MasksData16_g251423 = temp_output_2772_30_g251422;
					float4 temp_output_2772_27_g251422 = Out_PhaseData15_g251424;
					float4 In_PhaseData16_g251423 = temp_output_2772_27_g251422;
					half4 Model_TransformData2743_g251422 = Out_TransformData15_g251424;
					float3 temp_cast_11 = (0.0).xxx;
					float2 lerpResult3113_g251422 = lerp( (half4( 0, 1, 0.5, 1 )).xy , (TVE_WindParams).xy , TVE_IsEnabled);
					float2 Global_WindDirWS2542_g251422 = lerpResult3113_g251422;
					half2 Input_WindDirWS803_g251473 = Global_WindDirWS2542_g251422;
					float3 Model_PositionWO162_g251422 = temp_output_2772_17_g251422;
					half3 Input_ModelPositionWO761_g251426 = Model_PositionWO162_g251422;
					float3 Model_PivotWO402_g251422 = temp_output_2772_19_g251422;
					half3 Input_ModelPivotsWO419_g251426 = Model_PivotWO402_g251422;
					half Input_MotionPivots629_g251426 = _MotionSmallPivotValue;
					float3 lerpResult771_g251426 = lerp( Input_ModelPositionWO761_g251426 , Input_ModelPivotsWO419_g251426 , Input_MotionPivots629_g251426);
					half4 Model_PhaseData489_g251422 = temp_output_2772_27_g251422;
					half4 Input_ModelMotionData763_g251426 = Model_PhaseData489_g251422;
					half Input_MotionPhase764_g251426 = _MotionSmallPhaseValue;
					float temp_output_770_0_g251426 = ( (Input_ModelMotionData763_g251426).x * Input_MotionPhase764_g251426 );
					half3 Small_Position1421_g251422 = ( lerpResult771_g251426 + temp_output_770_0_g251426 );
					half3 Input_PositionWO419_g251473 = Small_Position1421_g251422;
					half Input_MotionTilling321_g251473 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g251473 = ( -(Input_PositionWO419_g251473).xz * Input_MotionTilling321_g251473 * 0.005 );
					float2 temp_output_3_0_g251474 = Noise_Coord979_g251473;
					float2 temp_output_21_0_g251474 = Input_WindDirWS803_g251473;
					float mulTime113_g251477 = _Time.y * 0.02;
					float lerpResult128_g251477 = lerp( mulTime113_g251477 , ( ( mulTime113_g251477 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g251473 = _MotionSmallSpeedValue;
					half Noise_Speed980_g251473 = ( lerpResult128_g251477 * Input_MotionSpeed62_g251473 );
					float temp_output_15_0_g251474 = Noise_Speed980_g251473;
					float temp_output_23_0_g251474 = frac( temp_output_15_0_g251474 );
					float4 lerpResult39_g251474 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g251474 + ( temp_output_21_0_g251474 * temp_output_23_0_g251474 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g251474 + ( temp_output_21_0_g251474 * frac( ( temp_output_15_0_g251474 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g251474 - 0.5 ) ) / 0.5 ));
					float4 temp_output_991_0_g251473 = lerpResult39_g251474;
					half2 Noise_DirWS858_g251473 = ((temp_output_991_0_g251473).rg*2.0 + -1.0);
					half Input_MotionNoise552_g251473 = _MotionSmallNoiseValue;
					TVEGlobalData Data15_g251436 =(TVEGlobalData)Data204_g241858;
					float Out_Dummy15_g251436 = 0.0;
					float4 Out_CoatParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251436 = float4( 0,0,0,0 );
					BreakData( Data15_g251436 , Out_Dummy15_g251436 , Out_CoatParams15_g251436 , Out_CoatTexture15_g251436 , Out_PaintParams15_g251436 , Out_PaintTexture15_g251436 , Out_AtmoParams15_g251436 , Out_AtmoTexture15_g251436 , Out_GlowParams15_g251436 , Out_GlowTexture15_g251436 , Out_FormParams15_g251436 , Out_FormTexture15_g251436 , Out_FlowParams15_g251436 , Out_FlowTexture15_g251436 );
					half4 Global_FlowParams3052_g251422 = Out_FlowParams15_g251436;
					half4 Global_FlowTexture2668_g251422 = Out_FlowTexture15_g251436;
					#ifdef TVE_MOTION_ELEMENT
					float4 staticSwitch3075_g251422 = Global_FlowTexture2668_g251422;
					#else
					float4 staticSwitch3075_g251422 = Global_FlowParams3052_g251422;
					#endif
					float4 temp_output_6_0_g251438 = staticSwitch3075_g251422;
					float temp_output_7_0_g251438 = _MotionElementMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251438 = ( temp_output_6_0_g251438 + temp_output_7_0_g251438 );
					#else
					float4 staticSwitch14_g251438 = temp_output_6_0_g251438;
					#endif
					float4 lerpResult3121_g251422 = lerp( half4( 0, 0, 0, 1 ) , staticSwitch14_g251438 , TVE_IsEnabled);
					float temp_output_630_0_g251451 = saturate( (lerpResult3121_g251422).w );
					float lerpResult853_g251451 = lerp( temp_output_630_0_g251451 , saturate( (temp_output_630_0_g251451*TVE_WindEditor.x + TVE_WindEditor.y) ) , TVE_WindEditor.w);
					half Global_WindValue1855_g251422 = ( lerpResult853_g251451 * _MotionIntensityValue );
					half Input_WindValue881_g251473 = Global_WindValue1855_g251422;
					float temp_output_6_0_g251479 = Input_WindValue881_g251473;
					float lerpResult701_g251473 = lerp( 1.0 , Input_MotionNoise552_g251473 , ( temp_output_6_0_g251479 * temp_output_6_0_g251479 ));
					float2 lerpResult646_g251473 = lerp( Input_WindDirWS803_g251473 , Noise_DirWS858_g251473 , lerpResult701_g251473);
					half2 Small_DirWS817_g251473 = lerpResult646_g251473;
					float2 break823_g251473 = Small_DirWS817_g251473;
					half4 Noise_Params685_g251473 = temp_output_991_0_g251473;
					half Wind_Sinus820_g251473 = ( ((Noise_Params685_g251473).b*2.0 + -1.0) * 0.6 );
					float3 appendResult824_g251473 = (float3(break823_g251473.x , Wind_Sinus820_g251473 , break823_g251473.y));
					half3 Small_Dir918_g251473 = appendResult824_g251473;
					float temp_output_20_0_g251478 = ( 1.0 - Input_WindValue881_g251473 );
					float3 appendResult1006_g251473 = (float3(Input_WindValue881_g251473 , ( 1.0 - ( temp_output_20_0_g251478 * temp_output_20_0_g251478 ) ) , Input_WindValue881_g251473));
					half Input_MotionDelay753_g251473 = _MotionSmallDelayValue;
					float lerpResult756_g251473 = lerp( 1.0 , ( Input_WindValue881_g251473 * Input_WindValue881_g251473 ) , Input_MotionDelay753_g251473);
					half Wind_Delay815_g251473 = lerpResult756_g251473;
					half Input_MotionValue905_g251473 = _MotionSmallIntensityValue;
					float3 temp_output_883_0_g251473 = ( Small_Dir918_g251473 * appendResult1006_g251473 * Wind_Delay815_g251473 * Input_MotionValue905_g251473 );
					float2 break857_g251473 = Noise_DirWS858_g251473;
					float3 appendResult833_g251473 = (float3(break857_g251473.x , Wind_Sinus820_g251473 , break857_g251473.y));
					half3 Push_Dir919_g251473 = appendResult833_g251473;
					half Input_MotionReact924_g251473 = _MotionSmallPushValue;
					float2 temp_output_3126_0_g251422 = ((lerpResult3121_g251422).xy*2.0 + -1.0);
					half Global_PushAlpha1504_g251422 = length( temp_output_3126_0_g251422 );
					half Input_PushAlpha806_g251473 = Global_PushAlpha1504_g251422;
					half Global_PushNoise2675_g251422 = (lerpResult3121_g251422).z;
					half Input_PushNoise890_g251473 = Global_PushNoise2675_g251422;
					half Push_Mask914_g251473 = saturate( ( Input_PushAlpha806_g251473 * Input_PushNoise890_g251473 * Input_MotionReact924_g251473 ) );
					float3 lerpResult840_g251473 = lerp( temp_output_883_0_g251473 , ( Push_Dir919_g251473 * Input_MotionReact924_g251473 ) , Push_Mask914_g251473);
					#ifdef TVE_MOTION_ELEMENT
					float3 staticSwitch829_g251473 = lerpResult840_g251473;
					#else
					float3 staticSwitch829_g251473 = temp_output_883_0_g251473;
					#endif
					float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
					half3 Small_Squash1489_g251422 = ( mul( unity_WorldToObject, float4( staticSwitch829_g251473 , 0.0 ) ).xyz * ase_parentObjectScale );
					float temp_output_17_0_g251461 = _MotionSmallMaskMode;
					float Option83_g251461 = temp_output_17_0_g251461;
					half4 Model_VertexMasks518_g251422 = temp_output_2772_29_g251422;
					float4 ChannelA83_g251461 = Model_VertexMasks518_g251422;
					half4 Model_MasksData1322_g251422 = temp_output_2772_30_g251422;
					float2 uv_MotionMaskTex2818_g251422 = v.ase_texcoord.xy;
					half4 Motion_MaskTex2819_g251422 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g251422, 0.0 );
					float4 appendResult3227_g251422 = (float4((Model_MasksData1322_g251422).xy , (Motion_MaskTex2819_g251422).g , 0.0));
					float4 ChannelB83_g251461 = appendResult3227_g251422;
					float localSwitchChannel883_g251461 = SwitchChannel8( Option83_g251461 , ChannelA83_g251461 , ChannelB83_g251461 );
					float enc1805_g251422 = v.ase_texcoord.z;
					float2 localDecodeFloatToVector21805_g251422 = DecodeFloatToVector2( enc1805_g251422 );
					float2 break1804_g251422 = localDecodeFloatToVector21805_g251422;
					half Small_Mask_Legacy1806_g251422 = break1804_g251422.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g251422 = Small_Mask_Legacy1806_g251422;
					#else
					float staticSwitch1800_g251422 = localSwitchChannel883_g251461;
					#endif
					float clampResult17_g251427 = clamp( staticSwitch1800_g251422 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251428 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g251428 = ( clampResult17_g251427 - temp_output_7_0_g251428 );
					half Small_Mask640_g251422 = saturate( ( temp_output_9_0_g251428 * _MotionSmallMaskRemap.z ) );
					float3 lerpResult3022_g251422 = lerp( float3( 1,1,1 ) , (TVE_MotionValueParams).xyz , TVE_MotionValueParams.w);
					half3 Global_MotionParams3013_g251422 = lerpResult3022_g251422;
					half3 Small_Motion789_g251422 = ( Small_Squash1489_g251422 * Small_Mask640_g251422 * (Global_MotionParams3013_g251422).y );
					#ifdef TVE_MOTION
					float3 staticSwitch495_g251422 = Small_Motion789_g251422;
					#else
					float3 staticSwitch495_g251422 = temp_cast_11;
					#endif
					float3 temp_cast_14 = (0.0).xxx;
					float3 Model_PositionWS1819_g251422 = temp_output_2772_16_g251422;
					half Global_DistMask1820_g251422 = ( 1.0 - saturate( ( distance( _WorldSpaceCameraPos , Model_PositionWS1819_g251422 ) / _MotionDistValue ) ) );
					float temp_output_17_0_g251462 = _MotionTinyMaskMode;
					float Option83_g251462 = temp_output_17_0_g251462;
					float4 ChannelA83_g251462 = Model_VertexMasks518_g251422;
					float4 appendResult3234_g251422 = (float4((Model_MasksData1322_g251422).xy , (Motion_MaskTex2819_g251422).b , 0.0));
					float4 ChannelB83_g251462 = appendResult3234_g251422;
					float localSwitchChannel883_g251462 = SwitchChannel8( Option83_g251462 , ChannelA83_g251462 , ChannelB83_g251462 );
					half Tiny_Mask_Legacy1807_g251422 = break1804_g251422.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g251422 = Tiny_Mask_Legacy1807_g251422;
					#else
					float staticSwitch1810_g251422 = localSwitchChannel883_g251462;
					#endif
					float clampResult17_g251429 = clamp( staticSwitch1810_g251422 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251430 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g251430 = ( clampResult17_g251429 - temp_output_7_0_g251430 );
					half Tiny_Mask218_g251422 = saturate( ( temp_output_9_0_g251430 * _MotionTinyMaskRemap.z ) );
					half3 Model_NormalOS554_g251422 = temp_output_2772_20_g251422;
					half3 Input_NormalOS533_g251444 = Model_NormalOS554_g251422;
					half3 Tiny_Position2469_g251422 = Model_PositionWO162_g251422;
					half3 Input_PositionWO500_g251444 = Tiny_Position2469_g251422;
					half Input_MotionTilling321_g251444 = ( _MotionTinyTillingValue + 0.1 );
					float lerpResult128_g251449 = lerp( _Time.y , ( ( _Time.y * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g251444 = _MotionTinySpeedValue;
					float4 tex2DNode514_g251444 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( ( (Input_PositionWO500_g251444).xz * Input_MotionTilling321_g251444 * 0.005 ) + ( lerpResult128_g251449 * Input_MotionSpeed62_g251444 * 0.02 ) ), 0.0 );
					half3 Flutter_Noise535_g251444 = (tex2DNode514_g251444.rgb*2.0 + -1.0);
					half Input_MotionNoise542_g251444 = _MotionTinyNoiseValue;
					float3 lerpResult537_g251444 = lerp( ( Input_NormalOS533_g251444 * Flutter_Noise535_g251444 ) , Flutter_Noise535_g251444 , Input_MotionNoise542_g251444);
					float mulTime113_g251450 = _Time.y * 2.0;
					float lerpResult128_g251450 = lerp( mulTime113_g251450 , ( ( mulTime113_g251450 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					float temp_output_578_0_g251444 = SAMPLE_TEXTURE3D_LOD( _NoiseTex3D, sampler_Linear_Repeat, ( ( Input_PositionWO500_g251444 + lerpResult128_g251450 ) * ( 1.0 * 0.01 ) ), 0.0 ).r;
					half Input_GlobalWind471_g251444 = Global_WindValue1855_g251422;
					float lerpResult579_g251444 = lerp( ( temp_output_578_0_g251444 * temp_output_578_0_g251444 * temp_output_578_0_g251444 * temp_output_578_0_g251444 ) , temp_output_578_0_g251444 , ( Input_GlobalWind471_g251444 * Input_GlobalWind471_g251444 ));
					float temp_output_20_0_g251448 = ( 1.0 - Input_GlobalWind471_g251444 );
					half Wind_Gust589_g251444 = ( ( lerpResult579_g251444 * ( 1.0 - ( temp_output_20_0_g251448 * temp_output_20_0_g251448 * temp_output_20_0_g251448 * temp_output_20_0_g251448 ) ) ) * 0.5 );
					half3 Tiny_Squash859_g251422 = ( lerpResult537_g251444 * Wind_Gust589_g251444 );
					half3 Tiny_Flutter1451_g251422 = ( _MotionTinyIntensityValue * Global_DistMask1820_g251422 * Tiny_Mask218_g251422 * Tiny_Squash859_g251422 * (Global_MotionParams3013_g251422).z );
					#ifdef TVE_MOTION
					float3 staticSwitch414_g251422 = Tiny_Flutter1451_g251422;
					#else
					float3 staticSwitch414_g251422 = temp_cast_14;
					#endif
					float4 appendResult2783_g251422 = (float4(( staticSwitch495_g251422 + staticSwitch414_g251422 ) , 0.0));
					half4 Final_TransformData1569_g251422 = ( Model_TransformData2743_g251422 + appendResult2783_g251422 );
					float4 In_TransformData16_g251423 = Final_TransformData1569_g251422;
					half4 Model_RotationData2740_g251422 = Out_RotationData15_g251424;
					half2 Input_WindDirWS803_g251463 = Global_WindDirWS2542_g251422;
					half3 Input_ModelPositionWO761_g251425 = Model_PositionWO162_g251422;
					half3 Input_ModelPivotsWO419_g251425 = Model_PivotWO402_g251422;
					half Input_MotionPivots629_g251425 = _MotionBasePivotValue;
					float3 lerpResult771_g251425 = lerp( Input_ModelPositionWO761_g251425 , Input_ModelPivotsWO419_g251425 , Input_MotionPivots629_g251425);
					half4 Input_ModelMotionData763_g251425 = Model_PhaseData489_g251422;
					half Input_MotionPhase764_g251425 = _MotionBasePhaseValue;
					float temp_output_770_0_g251425 = ( (Input_ModelMotionData763_g251425).x * Input_MotionPhase764_g251425 );
					half3 Base_Position1394_g251422 = ( lerpResult771_g251425 + temp_output_770_0_g251425 );
					half3 Input_PositionWO419_g251463 = Base_Position1394_g251422;
					half Input_MotionTilling321_g251463 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g251463 = ( -(Input_PositionWO419_g251463).xz * Input_MotionTilling321_g251463 * 0.005 );
					float2 temp_output_3_0_g251470 = Noise_Coord515_g251463;
					float2 temp_output_21_0_g251470 = Input_WindDirWS803_g251463;
					float mulTime113_g251464 = _Time.y * 0.02;
					float lerpResult128_g251464 = lerp( mulTime113_g251464 , ( ( mulTime113_g251464 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g251463 = _MotionBaseSpeedValue;
					half Noise_Speed516_g251463 = ( lerpResult128_g251464 * Input_MotionSpeed62_g251463 );
					float temp_output_15_0_g251470 = Noise_Speed516_g251463;
					float temp_output_23_0_g251470 = frac( temp_output_15_0_g251470 );
					float4 lerpResult39_g251470 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g251470 + ( temp_output_21_0_g251470 * temp_output_23_0_g251470 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g251470 + ( temp_output_21_0_g251470 * frac( ( temp_output_15_0_g251470 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g251470 - 0.5 ) ) / 0.5 ));
					float4 temp_output_635_0_g251463 = lerpResult39_g251470;
					half2 Noise_DirWS825_g251463 = ((temp_output_635_0_g251463).rg*2.0 + -1.0);
					half Input_MotionNoise552_g251463 = _MotionBaseNoiseValue;
					half Input_WindValue853_g251463 = Global_WindValue1855_g251422;
					float temp_output_6_0_g251467 = Input_WindValue853_g251463;
					float lerpResult701_g251463 = lerp( 1.0 , Input_MotionNoise552_g251463 , ( temp_output_6_0_g251467 * temp_output_6_0_g251467 ));
					half Input_PushNoise858_g251463 = Global_PushNoise2675_g251422;
					float2 lerpResult646_g251463 = lerp( Input_WindDirWS803_g251463 , Noise_DirWS825_g251463 , saturate( ( lerpResult701_g251463 + Input_PushNoise858_g251463 ) ));
					half2 Bend_Dir859_g251463 = lerpResult646_g251463;
					half Input_MotionValue871_g251463 = _MotionBaseIntensityValue;
					half Input_MotionDelay753_g251463 = _MotionBaseDelayValue;
					float lerpResult756_g251463 = lerp( 1.0 , ( Input_WindValue853_g251463 * Input_WindValue853_g251463 ) , Input_MotionDelay753_g251463);
					half Wind_Delay815_g251463 = lerpResult756_g251463;
					float2 temp_output_875_0_g251463 = ( Bend_Dir859_g251463 * Input_WindValue853_g251463 * Input_MotionValue871_g251463 * Wind_Delay815_g251463 );
					float2 Global_PushDirWS1972_g251422 = temp_output_3126_0_g251422;
					half2 Input_PushDirWS807_g251463 = Global_PushDirWS1972_g251422;
					half Input_ReactValue888_g251463 = _MotionBasePushValue;
					half Input_PushAlpha806_g251463 = Global_PushAlpha1504_g251422;
					half Push_Mask883_g251463 = saturate( ( Input_PushAlpha806_g251463 * Input_ReactValue888_g251463 ) );
					float2 lerpResult811_g251463 = lerp( temp_output_875_0_g251463 , ( Input_PushDirWS807_g251463 * Input_ReactValue888_g251463 ) , Push_Mask883_g251463);
					#ifdef TVE_MOTION_ELEMENT
					float2 staticSwitch808_g251463 = lerpResult811_g251463;
					#else
					float2 staticSwitch808_g251463 = temp_output_875_0_g251463;
					#endif
					float2 temp_output_38_0_g251468 = staticSwitch808_g251463;
					float2 break83_g251468 = temp_output_38_0_g251468;
					float3 appendResult79_g251468 = (float3(break83_g251468.x , 0.0 , break83_g251468.y));
					half2 Base_Bending893_g251422 = (( mul( unity_WorldToObject, float4( appendResult79_g251468 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
					float temp_output_17_0_g251460 = _MotionBaseMaskMode;
					float Option83_g251460 = temp_output_17_0_g251460;
					float4 ChannelA83_g251460 = Model_VertexMasks518_g251422;
					float4 appendResult3220_g251422 = (float4((Model_MasksData1322_g251422).xy , (Motion_MaskTex2819_g251422).r , 0.0));
					float4 ChannelB83_g251460 = appendResult3220_g251422;
					float localSwitchChannel883_g251460 = SwitchChannel8( Option83_g251460 , ChannelA83_g251460 , ChannelB83_g251460 );
					float clampResult17_g251432 = clamp( localSwitchChannel883_g251460 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251431 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g251431 = ( clampResult17_g251432 - temp_output_7_0_g251431 );
					half Base_Mask217_g251422 = saturate( ( temp_output_9_0_g251431 * _MotionBaseMaskRemap.z ) );
					half2 Base_Motion1440_g251422 = ( Base_Bending893_g251422 * Base_Mask217_g251422 * (Global_MotionParams3013_g251422).x );
					#ifdef TVE_MOTION
					float2 staticSwitch2384_g251422 = Base_Motion1440_g251422;
					#else
					float2 staticSwitch2384_g251422 = float2( 0,0 );
					#endif
					float4 appendResult2023_g251422 = (float4(staticSwitch2384_g251422 , 0.0 , 0.0));
					half4 Final_RotationData1570_g251422 = ( Model_RotationData2740_g251422 + appendResult2023_g251422 );
					float4 In_RotationData16_g251423 = Final_RotationData1570_g251422;
					half4 Model_Interpolator02773_g251422 = Out_InterpolatorA15_g251424;
					half4 Noise_Params685_g251463 = temp_output_635_0_g251463;
					float temp_output_6_0_g251466 = (Noise_Params685_g251463).a;
					float temp_output_913_0_g251463 = ( ( temp_output_6_0_g251466 * temp_output_6_0_g251466 * temp_output_6_0_g251466 * temp_output_6_0_g251466 ) * ( Input_WindValue853_g251463 * Wind_Delay815_g251463 ) );
					float temp_output_6_0_g251465 = length( Input_PushDirWS807_g251463 );
					float lerpResult902_g251463 = lerp( temp_output_913_0_g251463 , ( ( temp_output_6_0_g251465 * temp_output_6_0_g251465 ) * Input_PushNoise858_g251463 ) , Push_Mask883_g251463);
					#ifdef TVE_MOTION_ELEMENT
					float staticSwitch903_g251463 = lerpResult902_g251463;
					#else
					float staticSwitch903_g251463 = temp_output_913_0_g251463;
					#endif
					half Base_Wave1159_g251422 = staticSwitch903_g251463;
					float temp_output_6_0_g251480 = (Noise_Params685_g251473).a;
					float temp_output_955_0_g251473 = ( temp_output_6_0_g251480 * temp_output_6_0_g251480 * temp_output_6_0_g251480 * temp_output_6_0_g251480 );
					float temp_output_944_0_g251473 = ( temp_output_955_0_g251473 * ( Input_WindValue881_g251473 * Wind_Delay815_g251473 ) );
					float lerpResult936_g251473 = lerp( temp_output_944_0_g251473 , ( temp_output_955_0_g251473 * Input_PushNoise890_g251473 ) , Push_Mask914_g251473);
					#ifdef TVE_MOTION_ELEMENT
					float staticSwitch939_g251473 = lerpResult936_g251473;
					#else
					float staticSwitch939_g251473 = temp_output_944_0_g251473;
					#endif
					half Small_Wave1427_g251422 = staticSwitch939_g251473;
					float lerpResult2422_g251422 = lerp( Base_Wave1159_g251422 , Small_Wave1427_g251422 , _motion_small_mode);
					half Global_Wave1475_g251422 = saturate( lerpResult2422_g251422 );
					float temp_output_6_0_g251433 = ( _MotionHighlightValue * Global_DistMask1820_g251422 * ( Tiny_Mask218_g251422 * Tiny_Mask218_g251422 ) * Global_Wave1475_g251422 );
					float temp_output_7_0_g251433 = _MotionHighlightColor.r;
					#ifdef TVE_DUMMY
					float staticSwitch14_g251433 = ( temp_output_6_0_g251433 + temp_output_7_0_g251433 );
					#else
					float staticSwitch14_g251433 = temp_output_6_0_g251433;
					#endif
					#ifdef TVE_MOTION
					float staticSwitch2866_g251422 = staticSwitch14_g251433;
					#else
					float staticSwitch2866_g251422 = 0.0;
					#endif
					float4 appendResult2775_g251422 = (float4((Model_Interpolator02773_g251422).xyz , staticSwitch2866_g251422));
					half4 Final_Interpolator02774_g251422 = appendResult2775_g251422;
					float4 In_InterpolatorA16_g251423 = Final_Interpolator02774_g251422;
					BuildModelVertData( Data16_g251423 , In_Dummy16_g251423 , In_PositionOS16_g251423 , In_PositionWS16_g251423 , In_PositionWO16_g251423 , In_PositionRawOS16_g251423 , In_PivotOS16_g251423 , In_PivotWS16_g251423 , In_PivotWO16_g251423 , In_NormalOS16_g251423 , In_NormalWS16_g251423 , In_NormalRawOS16_g251423 , In_TangentOS16_g251423 , In_TangentWS16_g251423 , In_BitangentWS16_g251423 , In_ViewDirWS16_g251423 , In_CoordsData16_g251423 , In_VertexData16_g251423 , In_MasksData16_g251423 , In_PhaseData16_g251423 , In_TransformData16_g251423 , In_RotationData16_g251423 , In_InterpolatorA16_g251423 );
					TVEModelData Data15_g251482 =(TVEModelData)Data16_g251423;
					float Out_Dummy15_g251482 = 0.0;
					float3 Out_PositionOS15_g251482 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251482 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251482 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251482 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251482 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251482 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251482 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251482 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251482 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251482 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251482 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251482 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251482 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251482 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251482 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251482 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251482 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251482 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251482 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251482 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251482 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251482 , Out_Dummy15_g251482 , Out_PositionOS15_g251482 , Out_PositionWS15_g251482 , Out_PositionWO15_g251482 , Out_PositionRawOS15_g251482 , Out_PivotOS15_g251482 , Out_PivotWS15_g251482 , Out_PivotWO15_g251482 , Out_NormalOS15_g251482 , Out_NormalWS15_g251482 , Out_NormalRawOS15_g251482 , Out_TangentOS15_g251482 , Out_TangentWS15_g251482 , Out_BitangentWS15_g251482 , Out_ViewDirWS15_g251482 , Out_CoordsData15_g251482 , Out_VertexData15_g251482 , Out_MasksData15_g251482 , Out_PhaseData15_g251482 , Out_TransformData15_g251482 , Out_RotationData15_g251482 , Out_InterpolatorA15_g251482 );
					TVEModelData Data16_g251483 =(TVEModelData)Data15_g251482;
					float temp_output_14_0_g251483 = 0.0;
					float In_Dummy16_g251483 = temp_output_14_0_g251483;
					float3 Model_PositionOS147_g251481 = Out_PositionOS15_g251482;
					half3 VertexPos40_g251487 = Model_PositionOS147_g251481;
					float4 temp_output_1567_33_g251481 = Out_RotationData15_g251482;
					half4 Model_RotationData1569_g251481 = temp_output_1567_33_g251481;
					float2 break1582_g251481 = (Model_RotationData1569_g251481).xy;
					half Angle44_g251487 = break1582_g251481.y;
					half CosAngle89_g251487 = cos( Angle44_g251487 );
					half SinAngle93_g251487 = sin( Angle44_g251487 );
					float3 appendResult95_g251487 = (float3((VertexPos40_g251487).x , ( ( (VertexPos40_g251487).y * CosAngle89_g251487 ) - ( (VertexPos40_g251487).z * SinAngle93_g251487 ) ) , ( ( (VertexPos40_g251487).y * SinAngle93_g251487 ) + ( (VertexPos40_g251487).z * CosAngle89_g251487 ) )));
					half3 VertexPos40_g251488 = appendResult95_g251487;
					half Angle44_g251488 = -break1582_g251481.x;
					half CosAngle94_g251488 = cos( Angle44_g251488 );
					half SinAngle95_g251488 = sin( Angle44_g251488 );
					float3 appendResult98_g251488 = (float3(( ( (VertexPos40_g251488).x * CosAngle94_g251488 ) - ( (VertexPos40_g251488).y * SinAngle95_g251488 ) ) , ( ( (VertexPos40_g251488).x * SinAngle95_g251488 ) + ( (VertexPos40_g251488).y * CosAngle94_g251488 ) ) , (VertexPos40_g251488).z));
					half3 VertexPos40_g251486 = Model_PositionOS147_g251481;
					half Angle44_g251486 = break1582_g251481.y;
					half CosAngle89_g251486 = cos( Angle44_g251486 );
					half SinAngle93_g251486 = sin( Angle44_g251486 );
					float3 appendResult95_g251486 = (float3((VertexPos40_g251486).x , ( ( (VertexPos40_g251486).y * CosAngle89_g251486 ) - ( (VertexPos40_g251486).z * SinAngle93_g251486 ) ) , ( ( (VertexPos40_g251486).y * SinAngle93_g251486 ) + ( (VertexPos40_g251486).z * CosAngle89_g251486 ) )));
					half3 VertexPos40_g251491 = appendResult95_g251486;
					half Angle44_g251491 = break1582_g251481.x;
					half CosAngle91_g251491 = cos( Angle44_g251491 );
					half SinAngle92_g251491 = sin( Angle44_g251491 );
					float3 appendResult93_g251491 = (float3(( ( (VertexPos40_g251491).x * CosAngle91_g251491 ) + ( (VertexPos40_g251491).z * SinAngle92_g251491 ) ) , (VertexPos40_g251491).y , ( ( -(VertexPos40_g251491).x * SinAngle92_g251491 ) + ( (VertexPos40_g251491).z * CosAngle91_g251491 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251489 = appendResult93_g251491;
					#else
					float3 staticSwitch65_g251489 = appendResult98_g251488;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251484 = staticSwitch65_g251489;
					#else
					float3 staticSwitch65_g251484 = Model_PositionOS147_g251481;
					#endif
					float3 temp_output_1608_0_g251481 = staticSwitch65_g251484;
					half3 VertexPos40_g251490 = temp_output_1608_0_g251481;
					half Angle44_g251490 = (Model_RotationData1569_g251481).z;
					half CosAngle91_g251490 = cos( Angle44_g251490 );
					half SinAngle92_g251490 = sin( Angle44_g251490 );
					float3 appendResult93_g251490 = (float3(( ( (VertexPos40_g251490).x * CosAngle91_g251490 ) + ( (VertexPos40_g251490).z * SinAngle92_g251490 ) ) , (VertexPos40_g251490).y , ( ( -(VertexPos40_g251490).x * SinAngle92_g251490 ) + ( (VertexPos40_g251490).z * CosAngle91_g251490 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251485 = appendResult93_g251490;
					#else
					float3 staticSwitch65_g251485 = temp_output_1608_0_g251481;
					#endif
					float4 temp_output_1567_31_g251481 = Out_TransformData15_g251482;
					half4 Model_TransformData1568_g251481 = temp_output_1567_31_g251481;
					half3 Final_PositionOS178_g251481 = ( ( staticSwitch65_g251485 * (Model_TransformData1568_g251481).w ) + (Model_TransformData1568_g251481).xyz );
					float3 temp_output_4_0_g251483 = Final_PositionOS178_g251481;
					float3 In_PositionOS16_g251483 = temp_output_4_0_g251483;
					float3 In_PositionWS16_g251483 = Out_PositionWS15_g251482;
					float3 In_PositionWO16_g251483 = Out_PositionWO15_g251482;
					float3 In_PositionRawOS16_g251483 = Out_PositionRawOS15_g251482;
					float3 In_PivotOS16_g251483 = Out_PivotOS15_g251482;
					float3 In_PivotWS16_g251483 = Out_PivotWS15_g251482;
					float3 In_PivotWO16_g251483 = Out_PivotWO15_g251482;
					float3 temp_output_21_0_g251483 = Out_NormalOS15_g251482;
					float3 In_NormalOS16_g251483 = temp_output_21_0_g251483;
					float3 In_NormalWS16_g251483 = Out_NormalWS15_g251482;
					float3 In_NormalRawOS16_g251483 = Out_NormalRawOS15_g251482;
					float4 temp_output_6_0_g251483 = Out_TangentOS15_g251482;
					float4 In_TangentOS16_g251483 = temp_output_6_0_g251483;
					float3 In_TangentWS16_g251483 = Out_TangentWS15_g251482;
					float3 In_BitangentWS16_g251483 = Out_BitangentWS15_g251482;
					float3 In_ViewDirWS16_g251483 = Out_ViewDirWS15_g251482;
					float4 In_CoordsData16_g251483 = Out_CoordsData15_g251482;
					float4 In_VertexData16_g251483 = Out_VertexData15_g251482;
					float4 In_MasksData16_g251483 = Out_MasksData15_g251482;
					float4 In_PhaseData16_g251483 = Out_PhaseData15_g251482;
					float4 In_TransformData16_g251483 = temp_output_1567_31_g251481;
					float4 In_RotationData16_g251483 = temp_output_1567_33_g251481;
					float4 In_InterpolatorA16_g251483 = Out_InterpolatorA15_g251482;
					BuildModelVertData( Data16_g251483 , In_Dummy16_g251483 , In_PositionOS16_g251483 , In_PositionWS16_g251483 , In_PositionWO16_g251483 , In_PositionRawOS16_g251483 , In_PivotOS16_g251483 , In_PivotWS16_g251483 , In_PivotWO16_g251483 , In_NormalOS16_g251483 , In_NormalWS16_g251483 , In_NormalRawOS16_g251483 , In_TangentOS16_g251483 , In_TangentWS16_g251483 , In_BitangentWS16_g251483 , In_ViewDirWS16_g251483 , In_CoordsData16_g251483 , In_VertexData16_g251483 , In_MasksData16_g251483 , In_PhaseData16_g251483 , In_TransformData16_g251483 , In_RotationData16_g251483 , In_InterpolatorA16_g251483 );
					TVEModelData Data15_g251514 =(TVEModelData)Data16_g251483;
					float Out_Dummy15_g251514 = 0.0;
					float3 Out_PositionOS15_g251514 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251514 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251514 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251514 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251514 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251514 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251514 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251514 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251514 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251514 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251514 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251514 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251514 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251514 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251514 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251514 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251514 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251514 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251514 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251514 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251514 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251514 , Out_Dummy15_g251514 , Out_PositionOS15_g251514 , Out_PositionWS15_g251514 , Out_PositionWO15_g251514 , Out_PositionRawOS15_g251514 , Out_PivotOS15_g251514 , Out_PivotWS15_g251514 , Out_PivotWO15_g251514 , Out_NormalOS15_g251514 , Out_NormalWS15_g251514 , Out_NormalRawOS15_g251514 , Out_TangentOS15_g251514 , Out_TangentWS15_g251514 , Out_BitangentWS15_g251514 , Out_ViewDirWS15_g251514 , Out_CoordsData15_g251514 , Out_VertexData15_g251514 , Out_MasksData15_g251514 , Out_PhaseData15_g251514 , Out_TransformData15_g251514 , Out_RotationData15_g251514 , Out_InterpolatorA15_g251514 );
					TVEModelData Data16_g251515 =(TVEModelData)Data15_g251514;
					float temp_output_14_0_g251515 = 0.0;
					float In_Dummy16_g251515 = temp_output_14_0_g251515;
					float3 temp_output_217_24_g251513 = Out_PivotOS15_g251514;
					float3 temp_output_216_0_g251513 = ( Out_PositionOS15_g251514 + temp_output_217_24_g251513 );
					float3 temp_output_4_0_g251515 = temp_output_216_0_g251513;
					float3 In_PositionOS16_g251515 = temp_output_4_0_g251515;
					float3 In_PositionWS16_g251515 = Out_PositionWS15_g251514;
					float3 In_PositionWO16_g251515 = Out_PositionWO15_g251514;
					float3 In_PositionRawOS16_g251515 = Out_PositionRawOS15_g251514;
					float3 In_PivotOS16_g251515 = temp_output_217_24_g251513;
					float3 In_PivotWS16_g251515 = Out_PivotWS15_g251514;
					float3 In_PivotWO16_g251515 = Out_PivotWO15_g251514;
					float3 temp_output_21_0_g251515 = Out_NormalOS15_g251514;
					float3 In_NormalOS16_g251515 = temp_output_21_0_g251515;
					float3 In_NormalWS16_g251515 = Out_NormalWS15_g251514;
					float3 In_NormalRawOS16_g251515 = Out_NormalRawOS15_g251514;
					float4 temp_output_6_0_g251515 = Out_TangentOS15_g251514;
					float4 In_TangentOS16_g251515 = temp_output_6_0_g251515;
					float3 In_TangentWS16_g251515 = Out_TangentWS15_g251514;
					float3 In_BitangentWS16_g251515 = Out_BitangentWS15_g251514;
					float3 In_ViewDirWS16_g251515 = Out_ViewDirWS15_g251514;
					float4 In_CoordsData16_g251515 = Out_CoordsData15_g251514;
					float4 In_VertexData16_g251515 = Out_VertexData15_g251514;
					float4 In_MasksData16_g251515 = Out_MasksData15_g251514;
					float4 In_PhaseData16_g251515 = Out_PhaseData15_g251514;
					float4 In_TransformData16_g251515 = Out_TransformData15_g251514;
					float4 In_RotationData16_g251515 = Out_RotationData15_g251514;
					float4 In_InterpolatorA16_g251515 = Out_InterpolatorA15_g251514;
					BuildModelVertData( Data16_g251515 , In_Dummy16_g251515 , In_PositionOS16_g251515 , In_PositionWS16_g251515 , In_PositionWO16_g251515 , In_PositionRawOS16_g251515 , In_PivotOS16_g251515 , In_PivotWS16_g251515 , In_PivotWO16_g251515 , In_NormalOS16_g251515 , In_NormalWS16_g251515 , In_NormalRawOS16_g251515 , In_TangentOS16_g251515 , In_TangentWS16_g251515 , In_BitangentWS16_g251515 , In_ViewDirWS16_g251515 , In_CoordsData16_g251515 , In_VertexData16_g251515 , In_MasksData16_g251515 , In_PhaseData16_g251515 , In_TransformData16_g251515 , In_RotationData16_g251515 , In_InterpolatorA16_g251515 );
					TVEModelData Data15_g251524 =(TVEModelData)Data16_g251515;
					float Out_Dummy15_g251524 = 0.0;
					float3 Out_PositionOS15_g251524 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251524 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251524 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251524 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251524 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251524 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251524 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251524 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251524 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251524 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251524 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251524 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251524 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251524 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251524 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251524 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251524 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251524 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251524 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251524 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251524 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251524 , Out_Dummy15_g251524 , Out_PositionOS15_g251524 , Out_PositionWS15_g251524 , Out_PositionWO15_g251524 , Out_PositionRawOS15_g251524 , Out_PivotOS15_g251524 , Out_PivotWS15_g251524 , Out_PivotWO15_g251524 , Out_NormalOS15_g251524 , Out_NormalWS15_g251524 , Out_NormalRawOS15_g251524 , Out_TangentOS15_g251524 , Out_TangentWS15_g251524 , Out_BitangentWS15_g251524 , Out_ViewDirWS15_g251524 , Out_CoordsData15_g251524 , Out_VertexData15_g251524 , Out_MasksData15_g251524 , Out_PhaseData15_g251524 , Out_TransformData15_g251524 , Out_RotationData15_g251524 , Out_InterpolatorA15_g251524 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251524;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251524;
					v.tangent = Out_TangentOS15_g251524;

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
				#pragma shader_feature_local_vertex TVE_MOTION
				#pragma shader_feature_local_vertex TVE_MOTION_ELEMENT
				#pragma shader_feature_local TVE_LEGACY
				#if defined (TVE_MOTION) //Motion
					#define TVE_ROTATION_BEND //Motion
				#endif //Motion
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
				#define SAMPLE_TEXTURE3D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE3D_LOD(tex,samplerTex,coord,lod) tex3Dlod(tex,float4(coord,lod))
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
				uniform half _MotionCategory;
				uniform half _MotionEnd;
				uniform half _MotionPushInfo;
				uniform half4 TVE_WindParams;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MotionNoiseTex);
				uniform half _MotionSmallPivotValue;
				uniform half _MotionSmallPhaseValue;
				uniform half _MotionSmallTillingValue;
				uniform half4 TVE_MotionTimeParams;
				uniform half _MotionSmallSpeedValue;
				uniform half _MotionSmallNoiseValue;
				uniform half _MotionElementMode;
				uniform half4 TVE_WindEditor;
				uniform half _MotionIntensityValue;
				uniform half _MotionSmallDelayValue;
				uniform half _MotionSmallIntensityValue;
				uniform half _MotionSmallPushValue;
				uniform half _MotionSmallMaskMode;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MotionMaskTex);
				SamplerState sampler_MotionMaskTex;
				uniform half4 _MotionSmallMaskRemap;
				uniform half4 TVE_MotionValueParams;
				uniform half _MotionTinyIntensityValue;
				uniform half _MotionDistValue;
				uniform half _MotionTinyMaskMode;
				uniform half4 _MotionTinyMaskRemap;
				uniform half _MotionTinyTillingValue;
				uniform half _MotionTinySpeedValue;
				uniform half _MotionTinyNoiseValue;
				UNITY_DECLARE_TEX3D_NOSAMPLER(_NoiseTex3D);
				uniform half _MotionBasePivotValue;
				uniform half _MotionBasePhaseValue;
				uniform half _MotionBaseTillingValue;
				uniform half _MotionBaseSpeedValue;
				uniform half _MotionBaseNoiseValue;
				uniform half _MotionBaseIntensityValue;
				uniform half _MotionBaseDelayValue;
				uniform half _MotionBasePushValue;
				uniform half _MotionBaseMaskMode;
				uniform half4 _MotionBaseMaskRemap;
				uniform half _MotionHighlightValue;
				uniform half _motion_small_mode;
				uniform half4 _MotionHighlightColor;


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

					float localIfModelDataByShader26_g241935 = ( 0.0 );
					TVEModelData Data26_g241935 = (TVEModelData)0;
					TVEModelData Data16_g241848 =(TVEModelData)0;
					half Dummy207_g241838 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g241848 = Dummy207_g241838;
					float In_Dummy16_g241848 = temp_output_14_0_g241848;
					float3 PositionOS131_g241838 = v.vertex.xyz;
					float3 temp_output_4_0_g241848 = PositionOS131_g241838;
					float3 In_PositionOS16_g241848 = temp_output_4_0_g241848;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g241838 = ase_positionWS;
					float3 vertexToFrag73_g241838 = temp_output_104_7_g241838;
					float3 PositionWS122_g241838 = vertexToFrag73_g241838;
					float3 In_PositionWS16_g241848 = PositionWS122_g241838;
					float4x4 break19_g241841 = unity_ObjectToWorld;
					float3 appendResult20_g241841 = (float3(break19_g241841[ 0 ][ 3 ] , break19_g241841[ 1 ][ 3 ] , break19_g241841[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241838 = appendResult20_g241841;
					float4x4 break19_g241843 = unity_ObjectToWorld;
					float3 appendResult20_g241843 = (float3(break19_g241843[ 0 ][ 3 ] , break19_g241843[ 1 ][ 3 ] , break19_g241843[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g241839 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g241838 = PositionOS131_g241838;
					float3 appendResult234_g241838 = (float3(break233_g241838.x , 0.0 , break233_g241838.z));
					float3 break413_g241838 = PositionOS131_g241838;
					float3 appendResult414_g241838 = (float3(break413_g241838.x , break413_g241838.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g241845 = appendResult414_g241838;
					#else
					float3 staticSwitch65_g241845 = appendResult234_g241838;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g241838 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g241838 = appendResult60_g241839;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g241838 = staticSwitch65_g241845;
					#else
					float3 staticSwitch229_g241838 = _Vector0;
					#endif
					float3 PivotOS149_g241838 = staticSwitch229_g241838;
					float3 temp_output_122_0_g241843 = PivotOS149_g241838;
					float3 PivotsOnlyWS105_g241843 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g241843 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g241838 = ( appendResult20_g241843 + PivotsOnlyWS105_g241843 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g241838 = temp_output_340_7_g241838;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g241838 = temp_output_341_7_g241838;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g241838 = temp_output_341_7_g241838;
					#else
					float3 staticSwitch236_g241838 = temp_output_340_7_g241838;
					#endif
					float3 vertexToFrag76_g241838 = staticSwitch236_g241838;
					float3 PivotWS121_g241838 = vertexToFrag76_g241838;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241838 = ( PositionWS122_g241838 - PivotWS121_g241838 );
					#else
					float3 staticSwitch204_g241838 = PositionWS122_g241838;
					#endif
					float3 PositionWO132_g241838 = ( staticSwitch204_g241838 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241848 = PositionWO132_g241838;
					float3 In_PositionRawOS16_g241848 = PositionOS131_g241838;
					float3 In_PivotOS16_g241848 = PivotOS149_g241838;
					float3 In_PivotWS16_g241848 = PivotWS121_g241838;
					float3 PivotWO133_g241838 = ( PivotWS121_g241838 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241848 = PivotWO133_g241838;
					half3 NormalOS134_g241838 = v.normal;
					float3 temp_output_21_0_g241848 = NormalOS134_g241838;
					float3 In_NormalOS16_g241848 = temp_output_21_0_g241848;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g241838 = normalizedWorldNormal;
					float3 In_NormalWS16_g241848 = NormalWS95_g241838;
					float3 In_NormalRawOS16_g241848 = NormalOS134_g241838;
					half4 TangentlOS153_g241838 = v.tangent;
					float4 temp_output_6_0_g241848 = TangentlOS153_g241838;
					float4 In_TangentOS16_g241848 = temp_output_6_0_g241848;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g241838 = ase_tangentWS;
					float3 In_TangentWS16_g241848 = TangentWS136_g241838;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g241838 = ase_bitangentWS;
					float3 In_BitangentWS16_g241848 = BiangentWS421_g241838;
					float3 normalizeResult296_g241838 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241838 ) );
					half3 ViewDirWS169_g241838 = normalizeResult296_g241838;
					float3 In_ViewDirWS16_g241848 = ViewDirWS169_g241838;
					float4 appendResult397_g241838 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g241838 = appendResult397_g241838;
					float4 In_CoordsData16_g241848 = CoordsData398_g241838;
					half4 VertexMasks171_g241838 = v.ase_color;
					float4 In_VertexData16_g241848 = VertexMasks171_g241838;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241851 = (PositionOS131_g241838).z;
					#else
					float staticSwitch65_g241851 = (PositionOS131_g241838).y;
					#endif
					half Object_HeightValue267_g241838 = _ObjectHeightValue;
					half Bounds_HeightMask274_g241838 = saturate( ( staticSwitch65_g241851 / Object_HeightValue267_g241838 ) );
					half3 Position387_g241838 = PositionOS131_g241838;
					half Height387_g241838 = Object_HeightValue267_g241838;
					half Object_RadiusValue268_g241838 = _ObjectRadiusValue;
					half Radius387_g241838 = Object_RadiusValue268_g241838;
					half localCapsuleMaskYUp387_g241838 = CapsuleMaskYUp( Position387_g241838 , Height387_g241838 , Radius387_g241838 );
					half3 Position408_g241838 = PositionOS131_g241838;
					half Height408_g241838 = Object_HeightValue267_g241838;
					half Radius408_g241838 = Object_RadiusValue268_g241838;
					half localCapsuleMaskZUp408_g241838 = CapsuleMaskZUp( Position408_g241838 , Height408_g241838 , Radius408_g241838 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241856 = saturate( localCapsuleMaskZUp408_g241838 );
					#else
					float staticSwitch65_g241856 = saturate( localCapsuleMaskYUp387_g241838 );
					#endif
					half Bounds_SphereMask282_g241838 = staticSwitch65_g241856;
					float4 appendResult253_g241838 = (float4(Bounds_HeightMask274_g241838 , Bounds_SphereMask282_g241838 , 1.0 , 1.0));
					half4 MasksData254_g241838 = appendResult253_g241838;
					float4 In_MasksData16_g241848 = MasksData254_g241838;
					float temp_output_17_0_g241850 = _ObjectPhaseMode;
					float Option70_g241850 = temp_output_17_0_g241850;
					float4 temp_output_3_0_g241850 = v.ase_color;
					float4 Channel70_g241850 = temp_output_3_0_g241850;
					float localSwitchChannel470_g241850 = SwitchChannel4( Option70_g241850 , Channel70_g241850 );
					half Phase_Value372_g241838 = localSwitchChannel470_g241850;
					float3 break319_g241838 = PivotWO133_g241838;
					half Pivot_Position322_g241838 = ( break319_g241838.x + break319_g241838.z );
					half Phase_Position357_g241838 = ( Phase_Value372_g241838 + Pivot_Position322_g241838 );
					float temp_output_248_0_g241838 = frac( Phase_Position357_g241838 );
					float4 appendResult177_g241838 = (float4(( (frac( ( Phase_Position357_g241838 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g241838));
					half4 Phase_Data176_g241838 = appendResult177_g241838;
					float4 In_PhaseData16_g241848 = Phase_Data176_g241838;
					float4 In_TransformData16_g241848 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g241848 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g241848 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g241848 , In_Dummy16_g241848 , In_PositionOS16_g241848 , In_PositionWS16_g241848 , In_PositionWO16_g241848 , In_PositionRawOS16_g241848 , In_PivotOS16_g241848 , In_PivotWS16_g241848 , In_PivotWO16_g241848 , In_NormalOS16_g241848 , In_NormalWS16_g241848 , In_NormalRawOS16_g241848 , In_TangentOS16_g241848 , In_TangentWS16_g241848 , In_BitangentWS16_g241848 , In_ViewDirWS16_g241848 , In_CoordsData16_g241848 , In_VertexData16_g241848 , In_MasksData16_g241848 , In_PhaseData16_g241848 , In_TransformData16_g241848 , In_RotationData16_g241848 , In_InterpolatorA16_g241848 );
					TVEModelData DataDefault26_g241935 = Data16_g241848;
					TVEModelData DataGeneral26_g241935 = Data16_g241848;
					TVEModelData DataBlanket26_g241935 = Data16_g241848;
					TVEModelData DataImpostor26_g241935 = Data16_g241848;
					TVEModelData Data16_g241828 =(TVEModelData)0;
					half Dummy207_g241818 = 0.0;
					float temp_output_14_0_g241828 = Dummy207_g241818;
					float In_Dummy16_g241828 = temp_output_14_0_g241828;
					float3 PositionOS131_g241818 = v.vertex.xyz;
					float3 temp_output_4_0_g241828 = PositionOS131_g241818;
					float3 In_PositionOS16_g241828 = temp_output_4_0_g241828;
					float3 temp_output_104_7_g241818 = ase_positionWS;
					float3 PositionWS122_g241818 = temp_output_104_7_g241818;
					float3 In_PositionWS16_g241828 = PositionWS122_g241818;
					float4x4 break19_g241821 = unity_ObjectToWorld;
					float3 appendResult20_g241821 = (float3(break19_g241821[ 0 ][ 3 ] , break19_g241821[ 1 ][ 3 ] , break19_g241821[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241818 = appendResult20_g241821;
					float3 PivotWS121_g241818 = temp_output_340_7_g241818;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241818 = ( PositionWS122_g241818 - PivotWS121_g241818 );
					#else
					float3 staticSwitch204_g241818 = PositionWS122_g241818;
					#endif
					float3 PositionWO132_g241818 = ( staticSwitch204_g241818 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241828 = PositionWO132_g241818;
					float3 In_PositionRawOS16_g241828 = PositionOS131_g241818;
					float3 PivotOS149_g241818 = _Vector0;
					float3 In_PivotOS16_g241828 = PivotOS149_g241818;
					float3 In_PivotWS16_g241828 = PivotWS121_g241818;
					float3 PivotWO133_g241818 = ( PivotWS121_g241818 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241828 = PivotWO133_g241818;
					half3 NormalOS134_g241818 = v.normal;
					float3 temp_output_21_0_g241828 = NormalOS134_g241818;
					float3 In_NormalOS16_g241828 = temp_output_21_0_g241828;
					half3 NormalWS95_g241818 = normalizedWorldNormal;
					float3 In_NormalWS16_g241828 = NormalWS95_g241818;
					float3 In_NormalRawOS16_g241828 = NormalOS134_g241818;
					half4 TangentlOS153_g241818 = v.tangent;
					float4 temp_output_6_0_g241828 = TangentlOS153_g241818;
					float4 In_TangentOS16_g241828 = temp_output_6_0_g241828;
					half3 TangentWS136_g241818 = ase_tangentWS;
					float3 In_TangentWS16_g241828 = TangentWS136_g241818;
					half3 BiangentWS421_g241818 = ase_bitangentWS;
					float3 In_BitangentWS16_g241828 = BiangentWS421_g241818;
					float3 normalizeResult296_g241818 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241818 ) );
					half3 ViewDirWS169_g241818 = normalizeResult296_g241818;
					float3 In_ViewDirWS16_g241828 = ViewDirWS169_g241818;
					float4 appendResult397_g241818 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g241818 = appendResult397_g241818;
					float4 In_CoordsData16_g241828 = CoordsData398_g241818;
					half4 VertexMasks171_g241818 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241828 = VertexMasks171_g241818;
					half4 MasksData254_g241818 = float4( 0,0,0,0 );
					float4 In_MasksData16_g241828 = MasksData254_g241818;
					half4 Phase_Data176_g241818 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241828 = Phase_Data176_g241818;
					float4 In_TransformData16_g241828 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g241828 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g241828 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g241828 , In_Dummy16_g241828 , In_PositionOS16_g241828 , In_PositionWS16_g241828 , In_PositionWO16_g241828 , In_PositionRawOS16_g241828 , In_PivotOS16_g241828 , In_PivotWS16_g241828 , In_PivotWO16_g241828 , In_NormalOS16_g241828 , In_NormalWS16_g241828 , In_NormalRawOS16_g241828 , In_TangentOS16_g241828 , In_TangentWS16_g241828 , In_BitangentWS16_g241828 , In_ViewDirWS16_g241828 , In_CoordsData16_g241828 , In_VertexData16_g241828 , In_MasksData16_g241828 , In_PhaseData16_g241828 , In_TransformData16_g241828 , In_RotationData16_g241828 , In_InterpolatorA16_g241828 );
					TVEModelData DataTerrain26_g241935 = Data16_g241828;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g241935 = IsShaderType2637;
					{
					if (Type26_g241935 == 0 )
					{
					Data26_g241935 = DataDefault26_g241935;
					}
					else if (Type26_g241935 == 1 )
					{
					Data26_g241935 = DataGeneral26_g241935;
					}
					else if (Type26_g241935 == 2 )
					{
					Data26_g241935 = DataBlanket26_g241935;
					}
					else if (Type26_g241935 == 3 )
					{
					Data26_g241935 = DataImpostor26_g241935;
					}
					else if (Type26_g241935 == 4 )
					{
					Data26_g241935 = DataTerrain26_g241935;
					}
					}
					TVEModelData Data15_g251335 =(TVEModelData)Data26_g241935;
					float Out_Dummy15_g251335 = 0.0;
					float3 Out_PositionOS15_g251335 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251335 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251335 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251335 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251335 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251335 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251335 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251335 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251335 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251335 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251335 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251335 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251335 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251335 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251335 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251335 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251335 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251335 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251335 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251335 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251335 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251335 , Out_Dummy15_g251335 , Out_PositionOS15_g251335 , Out_PositionWS15_g251335 , Out_PositionWO15_g251335 , Out_PositionRawOS15_g251335 , Out_PivotOS15_g251335 , Out_PivotWS15_g251335 , Out_PivotWO15_g251335 , Out_NormalOS15_g251335 , Out_NormalWS15_g251335 , Out_NormalRawOS15_g251335 , Out_TangentOS15_g251335 , Out_TangentWS15_g251335 , Out_BitangentWS15_g251335 , Out_ViewDirWS15_g251335 , Out_CoordsData15_g251335 , Out_VertexData15_g251335 , Out_MasksData15_g251335 , Out_PhaseData15_g251335 , Out_TransformData15_g251335 , Out_RotationData15_g251335 , Out_InterpolatorA15_g251335 );
					TVEModelData Data16_g251337 =(TVEModelData)Data15_g251335;
					float temp_output_14_0_g251337 = 0.0;
					float In_Dummy16_g251337 = temp_output_14_0_g251337;
					float3 temp_output_219_24_g251334 = Out_PivotOS15_g251335;
					float3 temp_output_215_0_g251334 = ( Out_PositionOS15_g251335 - temp_output_219_24_g251334 );
					float3 temp_output_4_0_g251337 = temp_output_215_0_g251334;
					float3 In_PositionOS16_g251337 = temp_output_4_0_g251337;
					float3 In_PositionWS16_g251337 = Out_PositionWS15_g251335;
					float3 In_PositionWO16_g251337 = Out_PositionWO15_g251335;
					float3 In_PositionRawOS16_g251337 = Out_PositionRawOS15_g251335;
					float3 In_PivotOS16_g251337 = temp_output_219_24_g251334;
					float3 In_PivotWS16_g251337 = Out_PivotWS15_g251335;
					float3 In_PivotWO16_g251337 = Out_PivotWO15_g251335;
					float3 temp_output_21_0_g251337 = Out_NormalOS15_g251335;
					float3 In_NormalOS16_g251337 = temp_output_21_0_g251337;
					float3 In_NormalWS16_g251337 = Out_NormalWS15_g251335;
					float3 In_NormalRawOS16_g251337 = Out_NormalRawOS15_g251335;
					float4 temp_output_6_0_g251337 = Out_TangentOS15_g251335;
					float4 In_TangentOS16_g251337 = temp_output_6_0_g251337;
					float3 In_TangentWS16_g251337 = Out_TangentWS15_g251335;
					float3 In_BitangentWS16_g251337 = Out_BitangentWS15_g251335;
					float3 In_ViewDirWS16_g251337 = Out_ViewDirWS15_g251335;
					float4 In_CoordsData16_g251337 = Out_CoordsData15_g251335;
					float4 In_VertexData16_g251337 = Out_VertexData15_g251335;
					float4 In_MasksData16_g251337 = Out_MasksData15_g251335;
					float4 In_PhaseData16_g251337 = Out_PhaseData15_g251335;
					float4 In_TransformData16_g251337 = Out_TransformData15_g251335;
					float4 In_RotationData16_g251337 = Out_RotationData15_g251335;
					float4 In_InterpolatorA16_g251337 = Out_InterpolatorA15_g251335;
					BuildModelVertData( Data16_g251337 , In_Dummy16_g251337 , In_PositionOS16_g251337 , In_PositionWS16_g251337 , In_PositionWO16_g251337 , In_PositionRawOS16_g251337 , In_PivotOS16_g251337 , In_PivotWS16_g251337 , In_PivotWO16_g251337 , In_NormalOS16_g251337 , In_NormalWS16_g251337 , In_NormalRawOS16_g251337 , In_TangentOS16_g251337 , In_TangentWS16_g251337 , In_BitangentWS16_g251337 , In_ViewDirWS16_g251337 , In_CoordsData16_g251337 , In_VertexData16_g251337 , In_MasksData16_g251337 , In_PhaseData16_g251337 , In_TransformData16_g251337 , In_RotationData16_g251337 , In_InterpolatorA16_g251337 );
					TVEModelData Data15_g251366 =(TVEModelData)Data16_g251337;
					float Out_Dummy15_g251366 = 0.0;
					float3 Out_PositionOS15_g251366 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251366 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251366 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251366 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251366 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251366 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251366 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251366 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251366 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251366 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251366 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251366 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251366 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251366 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251366 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251366 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251366 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251366 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251366 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251366 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251366 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251366 , Out_Dummy15_g251366 , Out_PositionOS15_g251366 , Out_PositionWS15_g251366 , Out_PositionWO15_g251366 , Out_PositionRawOS15_g251366 , Out_PivotOS15_g251366 , Out_PivotWS15_g251366 , Out_PivotWO15_g251366 , Out_NormalOS15_g251366 , Out_NormalWS15_g251366 , Out_NormalRawOS15_g251366 , Out_TangentOS15_g251366 , Out_TangentWS15_g251366 , Out_BitangentWS15_g251366 , Out_ViewDirWS15_g251366 , Out_CoordsData15_g251366 , Out_VertexData15_g251366 , Out_MasksData15_g251366 , Out_PhaseData15_g251366 , Out_TransformData15_g251366 , Out_RotationData15_g251366 , Out_InterpolatorA15_g251366 );
					TVEModelData Data16_g251367 =(TVEModelData)Data15_g251366;
					half Dummy317_g251365 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g251367 = Dummy317_g251365;
					float In_Dummy16_g251367 = temp_output_14_0_g251367;
					float3 temp_output_4_0_g251367 = Out_PositionOS15_g251366;
					float3 In_PositionOS16_g251367 = temp_output_4_0_g251367;
					float3 In_PositionWS16_g251367 = Out_PositionWS15_g251366;
					float3 temp_output_314_17_g251365 = Out_PositionWO15_g251366;
					float3 In_PositionWO16_g251367 = temp_output_314_17_g251365;
					float3 In_PositionRawOS16_g251367 = Out_PositionRawOS15_g251366;
					float3 In_PivotOS16_g251367 = Out_PivotOS15_g251366;
					float3 In_PivotWS16_g251367 = Out_PivotWS15_g251366;
					float3 temp_output_314_19_g251365 = Out_PivotWO15_g251366;
					float3 In_PivotWO16_g251367 = temp_output_314_19_g251365;
					float3 temp_output_21_0_g251367 = Out_NormalOS15_g251366;
					float3 In_NormalOS16_g251367 = temp_output_21_0_g251367;
					float3 In_NormalWS16_g251367 = Out_NormalWS15_g251366;
					float3 In_NormalRawOS16_g251367 = Out_NormalRawOS15_g251366;
					float4 temp_output_6_0_g251367 = Out_TangentOS15_g251366;
					float4 In_TangentOS16_g251367 = temp_output_6_0_g251367;
					float3 In_TangentWS16_g251367 = Out_TangentWS15_g251366;
					float3 In_BitangentWS16_g251367 = Out_BitangentWS15_g251366;
					float3 In_ViewDirWS16_g251367 = Out_ViewDirWS15_g251366;
					float4 In_CoordsData16_g251367 = Out_CoordsData15_g251366;
					float4 temp_output_314_29_g251365 = Out_VertexData15_g251366;
					float4 In_VertexData16_g251367 = temp_output_314_29_g251365;
					float4 In_MasksData16_g251367 = Out_MasksData15_g251366;
					float4 In_PhaseData16_g251367 = Out_PhaseData15_g251366;
					half4 Model_TransformData356_g251365 = Out_TransformData15_g251366;
					float localBuildGlobalData204_g241858 = ( 0.0 );
					TVEGlobalData Data204_g241858 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g241858 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g241858 = Dummy211_g241858;
					float4 temp_output_589_164_g241858 = TVE_CoatParams;
					half4 Coat_Params596_g241858 = temp_output_589_164_g241858;
					float4 In_CoatParams204_g241858 = Coat_Params596_g241858;
					float4 temp_output_203_0_g241878 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g241817 = ( 0.0 );
					TVEModelData Data26_g241817 = (TVEModelData)0;
					TVEModelData Data16_g241846 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241846 = 0.0;
					float3 In_PositionWS16_g241846 = PositionWS122_g241838;
					float3 In_PositionWO16_g241846 = PositionWO132_g241838;
					float3 In_PivotWS16_g241846 = PivotWS121_g241838;
					float3 In_PivotWO16_g241846 = PivotWO133_g241838;
					float3 In_NormalWS16_g241846 = NormalWS95_g241838;
					float3 In_TangentWS16_g241846 = TangentWS136_g241838;
					float3 In_BitangentWS16_g241846 = BiangentWS421_g241838;
					half3 NormalWS427_g241838 = NormalWS95_g241838;
					half3 localComputeTriplanarWeights427_g241838 = ComputeTriplanarWeights( NormalWS427_g241838 );
					half3 TriplanarWeights429_g241838 = localComputeTriplanarWeights427_g241838;
					float3 In_TriplanarWeights16_g241846 = TriplanarWeights429_g241838;
					float3 In_ViewDirWS16_g241846 = ViewDirWS169_g241838;
					float4 In_CoordsData16_g241846 = CoordsData398_g241838;
					float4 In_VertexData16_g241846 = VertexMasks171_g241838;
					float4 In_PhaseData16_g241846 = Phase_Data176_g241838;
					BuildModelFragData( Data16_g241846 , In_Dummy16_g241846 , In_PositionWS16_g241846 , In_PositionWO16_g241846 , In_PivotWS16_g241846 , In_PivotWO16_g241846 , In_NormalWS16_g241846 , In_TangentWS16_g241846 , In_BitangentWS16_g241846 , In_TriplanarWeights16_g241846 , In_ViewDirWS16_g241846 , In_CoordsData16_g241846 , In_VertexData16_g241846 , In_PhaseData16_g241846 );
					TVEModelData DataDefault26_g241817 = Data16_g241846;
					TVEModelData DataGeneral26_g241817 = Data16_g241846;
					TVEModelData DataBlanket26_g241817 = Data16_g241846;
					TVEModelData DataImpostor26_g241817 = Data16_g241846;
					TVEModelData Data16_g241826 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g241826 = 0.0;
					float3 In_PositionWS16_g241826 = PositionWS122_g241818;
					float3 In_PositionWO16_g241826 = PositionWO132_g241818;
					float3 In_PivotWS16_g241826 = PivotWS121_g241818;
					float3 In_PivotWO16_g241826 = PivotWO133_g241818;
					float3 In_NormalWS16_g241826 = NormalWS95_g241818;
					float3 In_TangentWS16_g241826 = TangentWS136_g241818;
					float3 In_BitangentWS16_g241826 = BiangentWS421_g241818;
					half3 NormalWS427_g241818 = NormalWS95_g241818;
					half3 localComputeTriplanarWeights427_g241818 = ComputeTriplanarWeights( NormalWS427_g241818 );
					half3 TriplanarWeights429_g241818 = localComputeTriplanarWeights427_g241818;
					float3 In_TriplanarWeights16_g241826 = TriplanarWeights429_g241818;
					float3 In_ViewDirWS16_g241826 = ViewDirWS169_g241818;
					float4 In_CoordsData16_g241826 = CoordsData398_g241818;
					float4 In_VertexData16_g241826 = VertexMasks171_g241818;
					float4 In_PhaseData16_g241826 = Phase_Data176_g241818;
					BuildModelFragData( Data16_g241826 , In_Dummy16_g241826 , In_PositionWS16_g241826 , In_PositionWO16_g241826 , In_PivotWS16_g241826 , In_PivotWO16_g241826 , In_NormalWS16_g241826 , In_TangentWS16_g241826 , In_BitangentWS16_g241826 , In_TriplanarWeights16_g241826 , In_ViewDirWS16_g241826 , In_CoordsData16_g241826 , In_VertexData16_g241826 , In_PhaseData16_g241826 );
					TVEModelData DataTerrain26_g241817 = Data16_g241826;
					float Type26_g241817 = IsShaderType2637;
					{
					if (Type26_g241817 == 0 )
					{
					Data26_g241817 = DataDefault26_g241817;
					}
					else if (Type26_g241817 == 1 )
					{
					Data26_g241817 = DataGeneral26_g241817;
					}
					else if (Type26_g241817 == 2 )
					{
					Data26_g241817 = DataBlanket26_g241817;
					}
					else if (Type26_g241817 == 3 )
					{
					Data26_g241817 = DataImpostor26_g241817;
					}
					else if (Type26_g241817 == 4 )
					{
					Data26_g241817 = DataTerrain26_g241817;
					}
					}
					TVEModelData Data15_g241934 =(TVEModelData)Data26_g241817;
					float Out_Dummy15_g241934 = 0.0;
					float3 Out_PositionWS15_g241934 = float3( 0,0,0 );
					float3 Out_PositionWO15_g241934 = float3( 0,0,0 );
					float3 Out_PivotWS15_g241934 = float3( 0,0,0 );
					float3 Out_PivotWO15_g241934 = float3( 0,0,0 );
					float3 Out_NormalWS15_g241934 = float3( 0,0,0 );
					float3 Out_TangentWS15_g241934 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g241934 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g241934 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g241934 = float3( 0,0,0 );
					float4 Out_CoordsData15_g241934 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g241934 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g241934 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g241934 , Out_Dummy15_g241934 , Out_PositionWS15_g241934 , Out_PositionWO15_g241934 , Out_PivotWS15_g241934 , Out_PivotWO15_g241934 , Out_NormalWS15_g241934 , Out_TangentWS15_g241934 , Out_BitangentWS15_g241934 , Out_TriplanarWeights15_g241934 , Out_ViewDirWS15_g241934 , Out_CoordsData15_g241934 , Out_VertexData15_g241934 , Out_PhaseData15_g241934 );
					float3 Model_PositionWS497_g241858 = Out_PositionWS15_g241934;
					float2 Model_PositionWS_XZ143_g241858 = (Model_PositionWS497_g241858).xz;
					float3 Model_PivotWS498_g241858 = Out_PivotWS15_g241934;
					float2 Model_PivotWS_XZ145_g241858 = (Model_PivotWS498_g241858).xz;
					float2 lerpResult300_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g241878 = lerpResult300_g241858;
					float temp_output_82_0_g241876 = _GlobalCoatLayerValue;
					float temp_output_82_0_g241878 = temp_output_82_0_g241876;
					float4 tex2DArrayNode83_g241878 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241878).zw + ( (temp_output_203_0_g241878).xy * temp_output_81_0_g241878 ) ),temp_output_82_0_g241878), 0.0 );
					float4 appendResult210_g241878 = (float4(tex2DArrayNode83_g241878.rgb , saturate( tex2DArrayNode83_g241878.a )));
					float4 temp_output_204_0_g241878 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g241878 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241878).zw + ( (temp_output_204_0_g241878).xy * temp_output_81_0_g241878 ) ),temp_output_82_0_g241878), 0.0 );
					float4 appendResult212_g241878 = (float4(tex2DArrayNode122_g241878.rgb , saturate( tex2DArrayNode122_g241878.a )));
					float4 TVE_RenderNearPositionR628_g241858 = TVE_RenderNearPositionR;
					float temp_output_507_0_g241858 = saturate( ( distance( Model_PositionWS497_g241858 , (TVE_RenderNearPositionR628_g241858).xyz ) / (TVE_RenderNearPositionR628_g241858).w ) );
					float temp_output_7_0_g241859 = 1.0;
					float temp_output_9_0_g241859 = ( temp_output_507_0_g241858 - temp_output_7_0_g241859 );
					half TVE_RenderNearFadeValue635_g241858 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g241858 = saturate( ( temp_output_9_0_g241859 / ( ( TVE_RenderNearFadeValue635_g241858 - temp_output_7_0_g241859 ) + 0.0001 ) ) );
					float4 lerpResult131_g241878 = lerp( appendResult210_g241878 , appendResult212_g241878 , Global_TexBlend509_g241858);
					float4 temp_output_159_109_g241876 = lerpResult131_g241878;
					float4 lerpResult168_g241876 = lerp( TVE_CoatParams , temp_output_159_109_g241876 , TVE_CoatLayers[(int)temp_output_82_0_g241876]);
					float4 temp_output_589_109_g241858 = lerpResult168_g241876;
					half4 Coat_Texture302_g241858 = temp_output_589_109_g241858;
					float4 In_CoatTexture204_g241858 = Coat_Texture302_g241858;
					float4 temp_output_595_164_g241858 = TVE_PaintParams;
					half4 Paint_Params575_g241858 = temp_output_595_164_g241858;
					float4 In_PaintParams204_g241858 = Paint_Params575_g241858;
					float4 temp_output_203_0_g241927 = TVE_PaintBaseCoord;
					float2 lerpResult85_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g241927 = lerpResult85_g241858;
					float temp_output_82_0_g241924 = _GlobalPaintLayerValue;
					float temp_output_82_0_g241927 = temp_output_82_0_g241924;
					float4 tex2DArrayNode83_g241927 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241927).zw + ( (temp_output_203_0_g241927).xy * temp_output_81_0_g241927 ) ),temp_output_82_0_g241927), 0.0 );
					float4 appendResult210_g241927 = (float4(tex2DArrayNode83_g241927.rgb , saturate( tex2DArrayNode83_g241927.a )));
					float4 temp_output_204_0_g241927 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g241927 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241927).zw + ( (temp_output_204_0_g241927).xy * temp_output_81_0_g241927 ) ),temp_output_82_0_g241927), 0.0 );
					float4 appendResult212_g241927 = (float4(tex2DArrayNode122_g241927.rgb , saturate( tex2DArrayNode122_g241927.a )));
					float4 lerpResult131_g241927 = lerp( appendResult210_g241927 , appendResult212_g241927 , Global_TexBlend509_g241858);
					float4 temp_output_171_109_g241924 = lerpResult131_g241927;
					float4 lerpResult174_g241924 = lerp( TVE_PaintParams , temp_output_171_109_g241924 , TVE_PaintLayers[(int)temp_output_82_0_g241924]);
					float4 temp_output_595_109_g241858 = lerpResult174_g241924;
					half4 Paint_Texture71_g241858 = temp_output_595_109_g241858;
					float4 In_PaintTexture204_g241858 = Paint_Texture71_g241858;
					float4 temp_output_590_141_g241858 = TVE_AtmoParams;
					half4 Atmo_Params601_g241858 = temp_output_590_141_g241858;
					float4 In_AtmoParams204_g241858 = Atmo_Params601_g241858;
					float4 temp_output_203_0_g241886 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g241886 = lerpResult104_g241858;
					float temp_output_132_0_g241884 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g241886 = temp_output_132_0_g241884;
					float4 tex2DArrayNode83_g241886 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241886).zw + ( (temp_output_203_0_g241886).xy * temp_output_81_0_g241886 ) ),temp_output_82_0_g241886), 0.0 );
					float4 appendResult210_g241886 = (float4(tex2DArrayNode83_g241886.rgb , saturate( tex2DArrayNode83_g241886.a )));
					float4 temp_output_204_0_g241886 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g241886 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241886).zw + ( (temp_output_204_0_g241886).xy * temp_output_81_0_g241886 ) ),temp_output_82_0_g241886), 0.0 );
					float4 appendResult212_g241886 = (float4(tex2DArrayNode122_g241886.rgb , saturate( tex2DArrayNode122_g241886.a )));
					float4 lerpResult131_g241886 = lerp( appendResult210_g241886 , appendResult212_g241886 , Global_TexBlend509_g241858);
					float4 temp_output_137_109_g241884 = lerpResult131_g241886;
					float4 lerpResult145_g241884 = lerp( TVE_AtmoParams , temp_output_137_109_g241884 , TVE_AtmoLayers[(int)temp_output_132_0_g241884]);
					float4 temp_output_590_110_g241858 = lerpResult145_g241884;
					half4 Atmo_Texture80_g241858 = temp_output_590_110_g241858;
					float4 In_AtmoTexture204_g241858 = Atmo_Texture80_g241858;
					float4 temp_output_593_163_g241858 = TVE_GlowParams;
					half4 Glow_Params609_g241858 = temp_output_593_163_g241858;
					float4 In_GlowParams204_g241858 = Glow_Params609_g241858;
					float4 temp_output_203_0_g241902 = TVE_GlowBaseCoord;
					float2 lerpResult247_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g241902 = lerpResult247_g241858;
					float temp_output_82_0_g241900 = _GlobalGlowLayerValue;
					float temp_output_82_0_g241902 = temp_output_82_0_g241900;
					float4 tex2DArrayNode83_g241902 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241902).zw + ( (temp_output_203_0_g241902).xy * temp_output_81_0_g241902 ) ),temp_output_82_0_g241902), 0.0 );
					float4 appendResult210_g241902 = (float4(tex2DArrayNode83_g241902.rgb , saturate( tex2DArrayNode83_g241902.a )));
					float4 temp_output_204_0_g241902 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g241902 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241902).zw + ( (temp_output_204_0_g241902).xy * temp_output_81_0_g241902 ) ),temp_output_82_0_g241902), 0.0 );
					float4 appendResult212_g241902 = (float4(tex2DArrayNode122_g241902.rgb , saturate( tex2DArrayNode122_g241902.a )));
					float4 lerpResult131_g241902 = lerp( appendResult210_g241902 , appendResult212_g241902 , Global_TexBlend509_g241858);
					float4 temp_output_159_109_g241900 = lerpResult131_g241902;
					float4 lerpResult167_g241900 = lerp( TVE_GlowParams , temp_output_159_109_g241900 , TVE_GlowLayers[(int)temp_output_82_0_g241900]);
					float4 temp_output_593_109_g241858 = lerpResult167_g241900;
					half4 Glow_Texture248_g241858 = temp_output_593_109_g241858;
					float4 In_GlowTexture204_g241858 = Glow_Texture248_g241858;
					float4 temp_output_592_139_g241858 = TVE_FormParams;
					float4 Form_Params606_g241858 = temp_output_592_139_g241858;
					float4 In_FormParams204_g241858 = Form_Params606_g241858;
					float4 temp_output_203_0_g241918 = TVE_FormBaseCoord;
					float2 lerpResult168_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g241918 = lerpResult168_g241858;
					float temp_output_130_0_g241916 = _GlobalFormLayerValue;
					float temp_output_82_0_g241918 = temp_output_130_0_g241916;
					float4 tex2DArrayNode83_g241918 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241918).zw + ( (temp_output_203_0_g241918).xy * temp_output_81_0_g241918 ) ),temp_output_82_0_g241918), 0.0 );
					float4 appendResult210_g241918 = (float4(tex2DArrayNode83_g241918.rgb , saturate( tex2DArrayNode83_g241918.a )));
					float4 temp_output_204_0_g241918 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g241918 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241918).zw + ( (temp_output_204_0_g241918).xy * temp_output_81_0_g241918 ) ),temp_output_82_0_g241918), 0.0 );
					float4 appendResult212_g241918 = (float4(tex2DArrayNode122_g241918.rgb , saturate( tex2DArrayNode122_g241918.a )));
					float4 lerpResult131_g241918 = lerp( appendResult210_g241918 , appendResult212_g241918 , Global_TexBlend509_g241858);
					float4 temp_output_135_109_g241916 = lerpResult131_g241918;
					float4 lerpResult143_g241916 = lerp( TVE_FormParams , temp_output_135_109_g241916 , TVE_FormLayers[(int)temp_output_130_0_g241916]);
					float4 temp_output_592_0_g241858 = lerpResult143_g241916;
					float4 Form_Texture112_g241858 = temp_output_592_0_g241858;
					float4 In_FormTexture204_g241858 = Form_Texture112_g241858;
					float4 temp_output_594_145_g241858 = TVE_FlowParams;
					half4 Flow_Params612_g241858 = temp_output_594_145_g241858;
					float4 In_FlowParams204_g241858 = Flow_Params612_g241858;
					float4 temp_output_203_0_g241910 = TVE_FlowBaseCoord;
					float2 lerpResult400_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g241910 = lerpResult400_g241858;
					float temp_output_136_0_g241908 = _GlobalFlowLayerValue;
					float temp_output_82_0_g241910 = temp_output_136_0_g241908;
					float4 tex2DArrayNode83_g241910 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241910).zw + ( (temp_output_203_0_g241910).xy * temp_output_81_0_g241910 ) ),temp_output_82_0_g241910), 0.0 );
					float4 appendResult210_g241910 = (float4(tex2DArrayNode83_g241910.rgb , saturate( tex2DArrayNode83_g241910.a )));
					float4 temp_output_204_0_g241910 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g241910 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241910).zw + ( (temp_output_204_0_g241910).xy * temp_output_81_0_g241910 ) ),temp_output_82_0_g241910), 0.0 );
					float4 appendResult212_g241910 = (float4(tex2DArrayNode122_g241910.rgb , saturate( tex2DArrayNode122_g241910.a )));
					float4 lerpResult131_g241910 = lerp( appendResult210_g241910 , appendResult212_g241910 , Global_TexBlend509_g241858);
					float4 temp_output_141_109_g241908 = lerpResult131_g241910;
					float4 lerpResult149_g241908 = lerp( TVE_FlowParams , temp_output_141_109_g241908 , TVE_FlowLayers[(int)temp_output_136_0_g241908]);
					half4 Flow_Texture405_g241858 = lerpResult149_g241908;
					float4 In_FlowTexture204_g241858 = Flow_Texture405_g241858;
					BuildGlobalData( Data204_g241858 , In_Dummy204_g241858 , In_CoatParams204_g241858 , In_CoatTexture204_g241858 , In_PaintParams204_g241858 , In_PaintTexture204_g241858 , In_AtmoParams204_g241858 , In_AtmoTexture204_g241858 , In_GlowParams204_g241858 , In_GlowTexture204_g241858 , In_FormParams204_g241858 , In_FormTexture204_g241858 , In_FlowParams204_g241858 , In_FlowTexture204_g241858 );
					TVEGlobalData Data15_g251368 =(TVEGlobalData)Data204_g241858;
					float Out_Dummy15_g251368 = 0.0;
					float4 Out_CoatParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251368 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251368 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251368 = float4( 0,0,0,0 );
					BreakData( Data15_g251368 , Out_Dummy15_g251368 , Out_CoatParams15_g251368 , Out_CoatTexture15_g251368 , Out_PaintParams15_g251368 , Out_PaintTexture15_g251368 , Out_AtmoParams15_g251368 , Out_AtmoTexture15_g251368 , Out_GlowParams15_g251368 , Out_GlowTexture15_g251368 , Out_FormParams15_g251368 , Out_FormTexture15_g251368 , Out_FlowParams15_g251368 , Out_FlowTexture15_g251368 );
					float4 Global_FormTexture351_g251365 = Out_FormTexture15_g251368;
					float3 Model_PivotWO353_g251365 = temp_output_314_19_g251365;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251374 = _ConformMeshMode;
					float Option70_g251374 = temp_output_17_0_g251374;
					half4 Model_VertexData357_g251365 = temp_output_314_29_g251365;
					float4 temp_output_3_0_g251374 = Model_VertexData357_g251365;
					float4 Channel70_g251374 = temp_output_3_0_g251374;
					float localSwitchChannel470_g251374 = SwitchChannel4( Option70_g251374 , Channel70_g251374 );
					float temp_output_390_0_g251365 = localSwitchChannel470_g251374;
					float temp_output_7_0_g251371 = _ConformMeshRemap.x;
					float temp_output_9_0_g251371 = ( temp_output_390_0_g251365 - temp_output_7_0_g251371 );
					float lerpResult374_g251365 = lerp( 1.0 , saturate( ( temp_output_9_0_g251371 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251365 = lerpResult374_g251365;
					float temp_output_328_0_g251365 = ( Blend_VertMask379_g251365 * TVE_IsEnabled );
					half Conform_Mask366_g251365 = temp_output_328_0_g251365;
					float temp_output_322_0_g251365 = ( ( ( ( (Global_FormTexture351_g251365).z - ( (Model_PivotWO353_g251365).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251365 ) );
					float3 appendResult329_g251365 = (float3(0.0 , temp_output_322_0_g251365 , 0.0));
					float3 appendResult387_g251365 = (float3(0.0 , 0.0 , temp_output_322_0_g251365));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251372 = appendResult387_g251365;
					#else
					float3 staticSwitch65_g251372 = appendResult329_g251365;
					#endif
					float3 Blanket_Conform368_g251365 = staticSwitch65_g251372;
					float4 appendResult312_g251365 = (float4(Blanket_Conform368_g251365 , 0.0));
					float4 temp_output_310_0_g251365 = ( Model_TransformData356_g251365 + appendResult312_g251365 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251365 = temp_output_310_0_g251365;
					#else
					float4 staticSwitch364_g251365 = Model_TransformData356_g251365;
					#endif
					half4 Final_TransformData365_g251365 = staticSwitch364_g251365;
					float4 In_TransformData16_g251367 = Final_TransformData365_g251365;
					float4 In_RotationData16_g251367 = Out_RotationData15_g251366;
					float4 In_InterpolatorA16_g251367 = Out_InterpolatorA15_g251366;
					BuildModelVertData( Data16_g251367 , In_Dummy16_g251367 , In_PositionOS16_g251367 , In_PositionWS16_g251367 , In_PositionWO16_g251367 , In_PositionRawOS16_g251367 , In_PivotOS16_g251367 , In_PivotWS16_g251367 , In_PivotWO16_g251367 , In_NormalOS16_g251367 , In_NormalWS16_g251367 , In_NormalRawOS16_g251367 , In_TangentOS16_g251367 , In_TangentWS16_g251367 , In_BitangentWS16_g251367 , In_ViewDirWS16_g251367 , In_CoordsData16_g251367 , In_VertexData16_g251367 , In_MasksData16_g251367 , In_PhaseData16_g251367 , In_TransformData16_g251367 , In_RotationData16_g251367 , In_InterpolatorA16_g251367 );
					TVEModelData Data15_g251424 =(TVEModelData)Data16_g251367;
					float Out_Dummy15_g251424 = 0.0;
					float3 Out_PositionOS15_g251424 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251424 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251424 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251424 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251424 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251424 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251424 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251424 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251424 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251424 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251424 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251424 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251424 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251424 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251424 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251424 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251424 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251424 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251424 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251424 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251424 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251424 , Out_Dummy15_g251424 , Out_PositionOS15_g251424 , Out_PositionWS15_g251424 , Out_PositionWO15_g251424 , Out_PositionRawOS15_g251424 , Out_PivotOS15_g251424 , Out_PivotWS15_g251424 , Out_PivotWO15_g251424 , Out_NormalOS15_g251424 , Out_NormalWS15_g251424 , Out_NormalRawOS15_g251424 , Out_TangentOS15_g251424 , Out_TangentWS15_g251424 , Out_BitangentWS15_g251424 , Out_ViewDirWS15_g251424 , Out_CoordsData15_g251424 , Out_VertexData15_g251424 , Out_MasksData15_g251424 , Out_PhaseData15_g251424 , Out_TransformData15_g251424 , Out_RotationData15_g251424 , Out_InterpolatorA15_g251424 );
					TVEModelData Data16_g251423 =(TVEModelData)Data15_g251424;
					half Dummy181_g251422 = ( ( _MotionCategory + _MotionEnd ) + _MotionPushInfo );
					float temp_output_14_0_g251423 = Dummy181_g251422;
					float In_Dummy16_g251423 = temp_output_14_0_g251423;
					float3 temp_output_2772_0_g251422 = Out_PositionOS15_g251424;
					float3 temp_output_4_0_g251423 = temp_output_2772_0_g251422;
					float3 In_PositionOS16_g251423 = temp_output_4_0_g251423;
					float3 temp_output_2772_16_g251422 = Out_PositionWS15_g251424;
					float3 In_PositionWS16_g251423 = temp_output_2772_16_g251422;
					float3 temp_output_2772_17_g251422 = Out_PositionWO15_g251424;
					float3 In_PositionWO16_g251423 = temp_output_2772_17_g251422;
					float3 In_PositionRawOS16_g251423 = Out_PositionRawOS15_g251424;
					float3 temp_output_2772_24_g251422 = Out_PivotOS15_g251424;
					float3 In_PivotOS16_g251423 = temp_output_2772_24_g251422;
					float3 In_PivotWS16_g251423 = Out_PivotWS15_g251424;
					float3 temp_output_2772_19_g251422 = Out_PivotWO15_g251424;
					float3 In_PivotWO16_g251423 = temp_output_2772_19_g251422;
					float3 temp_output_2772_20_g251422 = Out_NormalOS15_g251424;
					float3 temp_output_21_0_g251423 = temp_output_2772_20_g251422;
					float3 In_NormalOS16_g251423 = temp_output_21_0_g251423;
					float3 In_NormalWS16_g251423 = Out_NormalWS15_g251424;
					float3 In_NormalRawOS16_g251423 = Out_NormalRawOS15_g251424;
					float4 temp_output_6_0_g251423 = Out_TangentOS15_g251424;
					float4 In_TangentOS16_g251423 = temp_output_6_0_g251423;
					float3 In_TangentWS16_g251423 = Out_TangentWS15_g251424;
					float3 In_BitangentWS16_g251423 = Out_BitangentWS15_g251424;
					float3 In_ViewDirWS16_g251423 = Out_ViewDirWS15_g251424;
					float4 In_CoordsData16_g251423 = Out_CoordsData15_g251424;
					float4 temp_output_2772_29_g251422 = Out_VertexData15_g251424;
					float4 In_VertexData16_g251423 = temp_output_2772_29_g251422;
					float4 temp_output_2772_30_g251422 = Out_MasksData15_g251424;
					float4 In_MasksData16_g251423 = temp_output_2772_30_g251422;
					float4 temp_output_2772_27_g251422 = Out_PhaseData15_g251424;
					float4 In_PhaseData16_g251423 = temp_output_2772_27_g251422;
					half4 Model_TransformData2743_g251422 = Out_TransformData15_g251424;
					float3 temp_cast_11 = (0.0).xxx;
					float2 lerpResult3113_g251422 = lerp( (half4( 0, 1, 0.5, 1 )).xy , (TVE_WindParams).xy , TVE_IsEnabled);
					float2 Global_WindDirWS2542_g251422 = lerpResult3113_g251422;
					half2 Input_WindDirWS803_g251473 = Global_WindDirWS2542_g251422;
					float3 Model_PositionWO162_g251422 = temp_output_2772_17_g251422;
					half3 Input_ModelPositionWO761_g251426 = Model_PositionWO162_g251422;
					float3 Model_PivotWO402_g251422 = temp_output_2772_19_g251422;
					half3 Input_ModelPivotsWO419_g251426 = Model_PivotWO402_g251422;
					half Input_MotionPivots629_g251426 = _MotionSmallPivotValue;
					float3 lerpResult771_g251426 = lerp( Input_ModelPositionWO761_g251426 , Input_ModelPivotsWO419_g251426 , Input_MotionPivots629_g251426);
					half4 Model_PhaseData489_g251422 = temp_output_2772_27_g251422;
					half4 Input_ModelMotionData763_g251426 = Model_PhaseData489_g251422;
					half Input_MotionPhase764_g251426 = _MotionSmallPhaseValue;
					float temp_output_770_0_g251426 = ( (Input_ModelMotionData763_g251426).x * Input_MotionPhase764_g251426 );
					half3 Small_Position1421_g251422 = ( lerpResult771_g251426 + temp_output_770_0_g251426 );
					half3 Input_PositionWO419_g251473 = Small_Position1421_g251422;
					half Input_MotionTilling321_g251473 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g251473 = ( -(Input_PositionWO419_g251473).xz * Input_MotionTilling321_g251473 * 0.005 );
					float2 temp_output_3_0_g251474 = Noise_Coord979_g251473;
					float2 temp_output_21_0_g251474 = Input_WindDirWS803_g251473;
					float mulTime113_g251477 = _Time.y * 0.02;
					float lerpResult128_g251477 = lerp( mulTime113_g251477 , ( ( mulTime113_g251477 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g251473 = _MotionSmallSpeedValue;
					half Noise_Speed980_g251473 = ( lerpResult128_g251477 * Input_MotionSpeed62_g251473 );
					float temp_output_15_0_g251474 = Noise_Speed980_g251473;
					float temp_output_23_0_g251474 = frac( temp_output_15_0_g251474 );
					float4 lerpResult39_g251474 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g251474 + ( temp_output_21_0_g251474 * temp_output_23_0_g251474 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g251474 + ( temp_output_21_0_g251474 * frac( ( temp_output_15_0_g251474 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g251474 - 0.5 ) ) / 0.5 ));
					float4 temp_output_991_0_g251473 = lerpResult39_g251474;
					half2 Noise_DirWS858_g251473 = ((temp_output_991_0_g251473).rg*2.0 + -1.0);
					half Input_MotionNoise552_g251473 = _MotionSmallNoiseValue;
					TVEGlobalData Data15_g251436 =(TVEGlobalData)Data204_g241858;
					float Out_Dummy15_g251436 = 0.0;
					float4 Out_CoatParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251436 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g251436 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251436 = float4( 0,0,0,0 );
					BreakData( Data15_g251436 , Out_Dummy15_g251436 , Out_CoatParams15_g251436 , Out_CoatTexture15_g251436 , Out_PaintParams15_g251436 , Out_PaintTexture15_g251436 , Out_AtmoParams15_g251436 , Out_AtmoTexture15_g251436 , Out_GlowParams15_g251436 , Out_GlowTexture15_g251436 , Out_FormParams15_g251436 , Out_FormTexture15_g251436 , Out_FlowParams15_g251436 , Out_FlowTexture15_g251436 );
					half4 Global_FlowParams3052_g251422 = Out_FlowParams15_g251436;
					half4 Global_FlowTexture2668_g251422 = Out_FlowTexture15_g251436;
					#ifdef TVE_MOTION_ELEMENT
					float4 staticSwitch3075_g251422 = Global_FlowTexture2668_g251422;
					#else
					float4 staticSwitch3075_g251422 = Global_FlowParams3052_g251422;
					#endif
					float4 temp_output_6_0_g251438 = staticSwitch3075_g251422;
					float temp_output_7_0_g251438 = _MotionElementMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251438 = ( temp_output_6_0_g251438 + temp_output_7_0_g251438 );
					#else
					float4 staticSwitch14_g251438 = temp_output_6_0_g251438;
					#endif
					float4 lerpResult3121_g251422 = lerp( half4( 0, 0, 0, 1 ) , staticSwitch14_g251438 , TVE_IsEnabled);
					float temp_output_630_0_g251451 = saturate( (lerpResult3121_g251422).w );
					float lerpResult853_g251451 = lerp( temp_output_630_0_g251451 , saturate( (temp_output_630_0_g251451*TVE_WindEditor.x + TVE_WindEditor.y) ) , TVE_WindEditor.w);
					half Global_WindValue1855_g251422 = ( lerpResult853_g251451 * _MotionIntensityValue );
					half Input_WindValue881_g251473 = Global_WindValue1855_g251422;
					float temp_output_6_0_g251479 = Input_WindValue881_g251473;
					float lerpResult701_g251473 = lerp( 1.0 , Input_MotionNoise552_g251473 , ( temp_output_6_0_g251479 * temp_output_6_0_g251479 ));
					float2 lerpResult646_g251473 = lerp( Input_WindDirWS803_g251473 , Noise_DirWS858_g251473 , lerpResult701_g251473);
					half2 Small_DirWS817_g251473 = lerpResult646_g251473;
					float2 break823_g251473 = Small_DirWS817_g251473;
					half4 Noise_Params685_g251473 = temp_output_991_0_g251473;
					half Wind_Sinus820_g251473 = ( ((Noise_Params685_g251473).b*2.0 + -1.0) * 0.6 );
					float3 appendResult824_g251473 = (float3(break823_g251473.x , Wind_Sinus820_g251473 , break823_g251473.y));
					half3 Small_Dir918_g251473 = appendResult824_g251473;
					float temp_output_20_0_g251478 = ( 1.0 - Input_WindValue881_g251473 );
					float3 appendResult1006_g251473 = (float3(Input_WindValue881_g251473 , ( 1.0 - ( temp_output_20_0_g251478 * temp_output_20_0_g251478 ) ) , Input_WindValue881_g251473));
					half Input_MotionDelay753_g251473 = _MotionSmallDelayValue;
					float lerpResult756_g251473 = lerp( 1.0 , ( Input_WindValue881_g251473 * Input_WindValue881_g251473 ) , Input_MotionDelay753_g251473);
					half Wind_Delay815_g251473 = lerpResult756_g251473;
					half Input_MotionValue905_g251473 = _MotionSmallIntensityValue;
					float3 temp_output_883_0_g251473 = ( Small_Dir918_g251473 * appendResult1006_g251473 * Wind_Delay815_g251473 * Input_MotionValue905_g251473 );
					float2 break857_g251473 = Noise_DirWS858_g251473;
					float3 appendResult833_g251473 = (float3(break857_g251473.x , Wind_Sinus820_g251473 , break857_g251473.y));
					half3 Push_Dir919_g251473 = appendResult833_g251473;
					half Input_MotionReact924_g251473 = _MotionSmallPushValue;
					float2 temp_output_3126_0_g251422 = ((lerpResult3121_g251422).xy*2.0 + -1.0);
					half Global_PushAlpha1504_g251422 = length( temp_output_3126_0_g251422 );
					half Input_PushAlpha806_g251473 = Global_PushAlpha1504_g251422;
					half Global_PushNoise2675_g251422 = (lerpResult3121_g251422).z;
					half Input_PushNoise890_g251473 = Global_PushNoise2675_g251422;
					half Push_Mask914_g251473 = saturate( ( Input_PushAlpha806_g251473 * Input_PushNoise890_g251473 * Input_MotionReact924_g251473 ) );
					float3 lerpResult840_g251473 = lerp( temp_output_883_0_g251473 , ( Push_Dir919_g251473 * Input_MotionReact924_g251473 ) , Push_Mask914_g251473);
					#ifdef TVE_MOTION_ELEMENT
					float3 staticSwitch829_g251473 = lerpResult840_g251473;
					#else
					float3 staticSwitch829_g251473 = temp_output_883_0_g251473;
					#endif
					float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
					half3 Small_Squash1489_g251422 = ( mul( unity_WorldToObject, float4( staticSwitch829_g251473 , 0.0 ) ).xyz * ase_parentObjectScale );
					float temp_output_17_0_g251461 = _MotionSmallMaskMode;
					float Option83_g251461 = temp_output_17_0_g251461;
					half4 Model_VertexMasks518_g251422 = temp_output_2772_29_g251422;
					float4 ChannelA83_g251461 = Model_VertexMasks518_g251422;
					half4 Model_MasksData1322_g251422 = temp_output_2772_30_g251422;
					float2 uv_MotionMaskTex2818_g251422 = v.ase_texcoord.xy;
					half4 Motion_MaskTex2819_g251422 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g251422, 0.0 );
					float4 appendResult3227_g251422 = (float4((Model_MasksData1322_g251422).xy , (Motion_MaskTex2819_g251422).g , 0.0));
					float4 ChannelB83_g251461 = appendResult3227_g251422;
					float localSwitchChannel883_g251461 = SwitchChannel8( Option83_g251461 , ChannelA83_g251461 , ChannelB83_g251461 );
					float enc1805_g251422 = v.ase_texcoord.z;
					float2 localDecodeFloatToVector21805_g251422 = DecodeFloatToVector2( enc1805_g251422 );
					float2 break1804_g251422 = localDecodeFloatToVector21805_g251422;
					half Small_Mask_Legacy1806_g251422 = break1804_g251422.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g251422 = Small_Mask_Legacy1806_g251422;
					#else
					float staticSwitch1800_g251422 = localSwitchChannel883_g251461;
					#endif
					float clampResult17_g251427 = clamp( staticSwitch1800_g251422 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251428 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g251428 = ( clampResult17_g251427 - temp_output_7_0_g251428 );
					half Small_Mask640_g251422 = saturate( ( temp_output_9_0_g251428 * _MotionSmallMaskRemap.z ) );
					float3 lerpResult3022_g251422 = lerp( float3( 1,1,1 ) , (TVE_MotionValueParams).xyz , TVE_MotionValueParams.w);
					half3 Global_MotionParams3013_g251422 = lerpResult3022_g251422;
					half3 Small_Motion789_g251422 = ( Small_Squash1489_g251422 * Small_Mask640_g251422 * (Global_MotionParams3013_g251422).y );
					#ifdef TVE_MOTION
					float3 staticSwitch495_g251422 = Small_Motion789_g251422;
					#else
					float3 staticSwitch495_g251422 = temp_cast_11;
					#endif
					float3 temp_cast_14 = (0.0).xxx;
					float3 Model_PositionWS1819_g251422 = temp_output_2772_16_g251422;
					half Global_DistMask1820_g251422 = ( 1.0 - saturate( ( distance( _WorldSpaceCameraPos , Model_PositionWS1819_g251422 ) / _MotionDistValue ) ) );
					float temp_output_17_0_g251462 = _MotionTinyMaskMode;
					float Option83_g251462 = temp_output_17_0_g251462;
					float4 ChannelA83_g251462 = Model_VertexMasks518_g251422;
					float4 appendResult3234_g251422 = (float4((Model_MasksData1322_g251422).xy , (Motion_MaskTex2819_g251422).b , 0.0));
					float4 ChannelB83_g251462 = appendResult3234_g251422;
					float localSwitchChannel883_g251462 = SwitchChannel8( Option83_g251462 , ChannelA83_g251462 , ChannelB83_g251462 );
					half Tiny_Mask_Legacy1807_g251422 = break1804_g251422.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g251422 = Tiny_Mask_Legacy1807_g251422;
					#else
					float staticSwitch1810_g251422 = localSwitchChannel883_g251462;
					#endif
					float clampResult17_g251429 = clamp( staticSwitch1810_g251422 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251430 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g251430 = ( clampResult17_g251429 - temp_output_7_0_g251430 );
					half Tiny_Mask218_g251422 = saturate( ( temp_output_9_0_g251430 * _MotionTinyMaskRemap.z ) );
					half3 Model_NormalOS554_g251422 = temp_output_2772_20_g251422;
					half3 Input_NormalOS533_g251444 = Model_NormalOS554_g251422;
					half3 Tiny_Position2469_g251422 = Model_PositionWO162_g251422;
					half3 Input_PositionWO500_g251444 = Tiny_Position2469_g251422;
					half Input_MotionTilling321_g251444 = ( _MotionTinyTillingValue + 0.1 );
					float lerpResult128_g251449 = lerp( _Time.y , ( ( _Time.y * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g251444 = _MotionTinySpeedValue;
					float4 tex2DNode514_g251444 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( ( (Input_PositionWO500_g251444).xz * Input_MotionTilling321_g251444 * 0.005 ) + ( lerpResult128_g251449 * Input_MotionSpeed62_g251444 * 0.02 ) ), 0.0 );
					half3 Flutter_Noise535_g251444 = (tex2DNode514_g251444.rgb*2.0 + -1.0);
					half Input_MotionNoise542_g251444 = _MotionTinyNoiseValue;
					float3 lerpResult537_g251444 = lerp( ( Input_NormalOS533_g251444 * Flutter_Noise535_g251444 ) , Flutter_Noise535_g251444 , Input_MotionNoise542_g251444);
					float mulTime113_g251450 = _Time.y * 2.0;
					float lerpResult128_g251450 = lerp( mulTime113_g251450 , ( ( mulTime113_g251450 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					float temp_output_578_0_g251444 = SAMPLE_TEXTURE3D_LOD( _NoiseTex3D, sampler_Linear_Repeat, ( ( Input_PositionWO500_g251444 + lerpResult128_g251450 ) * ( 1.0 * 0.01 ) ), 0.0 ).r;
					half Input_GlobalWind471_g251444 = Global_WindValue1855_g251422;
					float lerpResult579_g251444 = lerp( ( temp_output_578_0_g251444 * temp_output_578_0_g251444 * temp_output_578_0_g251444 * temp_output_578_0_g251444 ) , temp_output_578_0_g251444 , ( Input_GlobalWind471_g251444 * Input_GlobalWind471_g251444 ));
					float temp_output_20_0_g251448 = ( 1.0 - Input_GlobalWind471_g251444 );
					half Wind_Gust589_g251444 = ( ( lerpResult579_g251444 * ( 1.0 - ( temp_output_20_0_g251448 * temp_output_20_0_g251448 * temp_output_20_0_g251448 * temp_output_20_0_g251448 ) ) ) * 0.5 );
					half3 Tiny_Squash859_g251422 = ( lerpResult537_g251444 * Wind_Gust589_g251444 );
					half3 Tiny_Flutter1451_g251422 = ( _MotionTinyIntensityValue * Global_DistMask1820_g251422 * Tiny_Mask218_g251422 * Tiny_Squash859_g251422 * (Global_MotionParams3013_g251422).z );
					#ifdef TVE_MOTION
					float3 staticSwitch414_g251422 = Tiny_Flutter1451_g251422;
					#else
					float3 staticSwitch414_g251422 = temp_cast_14;
					#endif
					float4 appendResult2783_g251422 = (float4(( staticSwitch495_g251422 + staticSwitch414_g251422 ) , 0.0));
					half4 Final_TransformData1569_g251422 = ( Model_TransformData2743_g251422 + appendResult2783_g251422 );
					float4 In_TransformData16_g251423 = Final_TransformData1569_g251422;
					half4 Model_RotationData2740_g251422 = Out_RotationData15_g251424;
					half2 Input_WindDirWS803_g251463 = Global_WindDirWS2542_g251422;
					half3 Input_ModelPositionWO761_g251425 = Model_PositionWO162_g251422;
					half3 Input_ModelPivotsWO419_g251425 = Model_PivotWO402_g251422;
					half Input_MotionPivots629_g251425 = _MotionBasePivotValue;
					float3 lerpResult771_g251425 = lerp( Input_ModelPositionWO761_g251425 , Input_ModelPivotsWO419_g251425 , Input_MotionPivots629_g251425);
					half4 Input_ModelMotionData763_g251425 = Model_PhaseData489_g251422;
					half Input_MotionPhase764_g251425 = _MotionBasePhaseValue;
					float temp_output_770_0_g251425 = ( (Input_ModelMotionData763_g251425).x * Input_MotionPhase764_g251425 );
					half3 Base_Position1394_g251422 = ( lerpResult771_g251425 + temp_output_770_0_g251425 );
					half3 Input_PositionWO419_g251463 = Base_Position1394_g251422;
					half Input_MotionTilling321_g251463 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g251463 = ( -(Input_PositionWO419_g251463).xz * Input_MotionTilling321_g251463 * 0.005 );
					float2 temp_output_3_0_g251470 = Noise_Coord515_g251463;
					float2 temp_output_21_0_g251470 = Input_WindDirWS803_g251463;
					float mulTime113_g251464 = _Time.y * 0.02;
					float lerpResult128_g251464 = lerp( mulTime113_g251464 , ( ( mulTime113_g251464 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g251463 = _MotionBaseSpeedValue;
					half Noise_Speed516_g251463 = ( lerpResult128_g251464 * Input_MotionSpeed62_g251463 );
					float temp_output_15_0_g251470 = Noise_Speed516_g251463;
					float temp_output_23_0_g251470 = frac( temp_output_15_0_g251470 );
					float4 lerpResult39_g251470 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g251470 + ( temp_output_21_0_g251470 * temp_output_23_0_g251470 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g251470 + ( temp_output_21_0_g251470 * frac( ( temp_output_15_0_g251470 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g251470 - 0.5 ) ) / 0.5 ));
					float4 temp_output_635_0_g251463 = lerpResult39_g251470;
					half2 Noise_DirWS825_g251463 = ((temp_output_635_0_g251463).rg*2.0 + -1.0);
					half Input_MotionNoise552_g251463 = _MotionBaseNoiseValue;
					half Input_WindValue853_g251463 = Global_WindValue1855_g251422;
					float temp_output_6_0_g251467 = Input_WindValue853_g251463;
					float lerpResult701_g251463 = lerp( 1.0 , Input_MotionNoise552_g251463 , ( temp_output_6_0_g251467 * temp_output_6_0_g251467 ));
					half Input_PushNoise858_g251463 = Global_PushNoise2675_g251422;
					float2 lerpResult646_g251463 = lerp( Input_WindDirWS803_g251463 , Noise_DirWS825_g251463 , saturate( ( lerpResult701_g251463 + Input_PushNoise858_g251463 ) ));
					half2 Bend_Dir859_g251463 = lerpResult646_g251463;
					half Input_MotionValue871_g251463 = _MotionBaseIntensityValue;
					half Input_MotionDelay753_g251463 = _MotionBaseDelayValue;
					float lerpResult756_g251463 = lerp( 1.0 , ( Input_WindValue853_g251463 * Input_WindValue853_g251463 ) , Input_MotionDelay753_g251463);
					half Wind_Delay815_g251463 = lerpResult756_g251463;
					float2 temp_output_875_0_g251463 = ( Bend_Dir859_g251463 * Input_WindValue853_g251463 * Input_MotionValue871_g251463 * Wind_Delay815_g251463 );
					float2 Global_PushDirWS1972_g251422 = temp_output_3126_0_g251422;
					half2 Input_PushDirWS807_g251463 = Global_PushDirWS1972_g251422;
					half Input_ReactValue888_g251463 = _MotionBasePushValue;
					half Input_PushAlpha806_g251463 = Global_PushAlpha1504_g251422;
					half Push_Mask883_g251463 = saturate( ( Input_PushAlpha806_g251463 * Input_ReactValue888_g251463 ) );
					float2 lerpResult811_g251463 = lerp( temp_output_875_0_g251463 , ( Input_PushDirWS807_g251463 * Input_ReactValue888_g251463 ) , Push_Mask883_g251463);
					#ifdef TVE_MOTION_ELEMENT
					float2 staticSwitch808_g251463 = lerpResult811_g251463;
					#else
					float2 staticSwitch808_g251463 = temp_output_875_0_g251463;
					#endif
					float2 temp_output_38_0_g251468 = staticSwitch808_g251463;
					float2 break83_g251468 = temp_output_38_0_g251468;
					float3 appendResult79_g251468 = (float3(break83_g251468.x , 0.0 , break83_g251468.y));
					half2 Base_Bending893_g251422 = (( mul( unity_WorldToObject, float4( appendResult79_g251468 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
					float temp_output_17_0_g251460 = _MotionBaseMaskMode;
					float Option83_g251460 = temp_output_17_0_g251460;
					float4 ChannelA83_g251460 = Model_VertexMasks518_g251422;
					float4 appendResult3220_g251422 = (float4((Model_MasksData1322_g251422).xy , (Motion_MaskTex2819_g251422).r , 0.0));
					float4 ChannelB83_g251460 = appendResult3220_g251422;
					float localSwitchChannel883_g251460 = SwitchChannel8( Option83_g251460 , ChannelA83_g251460 , ChannelB83_g251460 );
					float clampResult17_g251432 = clamp( localSwitchChannel883_g251460 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251431 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g251431 = ( clampResult17_g251432 - temp_output_7_0_g251431 );
					half Base_Mask217_g251422 = saturate( ( temp_output_9_0_g251431 * _MotionBaseMaskRemap.z ) );
					half2 Base_Motion1440_g251422 = ( Base_Bending893_g251422 * Base_Mask217_g251422 * (Global_MotionParams3013_g251422).x );
					#ifdef TVE_MOTION
					float2 staticSwitch2384_g251422 = Base_Motion1440_g251422;
					#else
					float2 staticSwitch2384_g251422 = float2( 0,0 );
					#endif
					float4 appendResult2023_g251422 = (float4(staticSwitch2384_g251422 , 0.0 , 0.0));
					half4 Final_RotationData1570_g251422 = ( Model_RotationData2740_g251422 + appendResult2023_g251422 );
					float4 In_RotationData16_g251423 = Final_RotationData1570_g251422;
					half4 Model_Interpolator02773_g251422 = Out_InterpolatorA15_g251424;
					half4 Noise_Params685_g251463 = temp_output_635_0_g251463;
					float temp_output_6_0_g251466 = (Noise_Params685_g251463).a;
					float temp_output_913_0_g251463 = ( ( temp_output_6_0_g251466 * temp_output_6_0_g251466 * temp_output_6_0_g251466 * temp_output_6_0_g251466 ) * ( Input_WindValue853_g251463 * Wind_Delay815_g251463 ) );
					float temp_output_6_0_g251465 = length( Input_PushDirWS807_g251463 );
					float lerpResult902_g251463 = lerp( temp_output_913_0_g251463 , ( ( temp_output_6_0_g251465 * temp_output_6_0_g251465 ) * Input_PushNoise858_g251463 ) , Push_Mask883_g251463);
					#ifdef TVE_MOTION_ELEMENT
					float staticSwitch903_g251463 = lerpResult902_g251463;
					#else
					float staticSwitch903_g251463 = temp_output_913_0_g251463;
					#endif
					half Base_Wave1159_g251422 = staticSwitch903_g251463;
					float temp_output_6_0_g251480 = (Noise_Params685_g251473).a;
					float temp_output_955_0_g251473 = ( temp_output_6_0_g251480 * temp_output_6_0_g251480 * temp_output_6_0_g251480 * temp_output_6_0_g251480 );
					float temp_output_944_0_g251473 = ( temp_output_955_0_g251473 * ( Input_WindValue881_g251473 * Wind_Delay815_g251473 ) );
					float lerpResult936_g251473 = lerp( temp_output_944_0_g251473 , ( temp_output_955_0_g251473 * Input_PushNoise890_g251473 ) , Push_Mask914_g251473);
					#ifdef TVE_MOTION_ELEMENT
					float staticSwitch939_g251473 = lerpResult936_g251473;
					#else
					float staticSwitch939_g251473 = temp_output_944_0_g251473;
					#endif
					half Small_Wave1427_g251422 = staticSwitch939_g251473;
					float lerpResult2422_g251422 = lerp( Base_Wave1159_g251422 , Small_Wave1427_g251422 , _motion_small_mode);
					half Global_Wave1475_g251422 = saturate( lerpResult2422_g251422 );
					float temp_output_6_0_g251433 = ( _MotionHighlightValue * Global_DistMask1820_g251422 * ( Tiny_Mask218_g251422 * Tiny_Mask218_g251422 ) * Global_Wave1475_g251422 );
					float temp_output_7_0_g251433 = _MotionHighlightColor.r;
					#ifdef TVE_DUMMY
					float staticSwitch14_g251433 = ( temp_output_6_0_g251433 + temp_output_7_0_g251433 );
					#else
					float staticSwitch14_g251433 = temp_output_6_0_g251433;
					#endif
					#ifdef TVE_MOTION
					float staticSwitch2866_g251422 = staticSwitch14_g251433;
					#else
					float staticSwitch2866_g251422 = 0.0;
					#endif
					float4 appendResult2775_g251422 = (float4((Model_Interpolator02773_g251422).xyz , staticSwitch2866_g251422));
					half4 Final_Interpolator02774_g251422 = appendResult2775_g251422;
					float4 In_InterpolatorA16_g251423 = Final_Interpolator02774_g251422;
					BuildModelVertData( Data16_g251423 , In_Dummy16_g251423 , In_PositionOS16_g251423 , In_PositionWS16_g251423 , In_PositionWO16_g251423 , In_PositionRawOS16_g251423 , In_PivotOS16_g251423 , In_PivotWS16_g251423 , In_PivotWO16_g251423 , In_NormalOS16_g251423 , In_NormalWS16_g251423 , In_NormalRawOS16_g251423 , In_TangentOS16_g251423 , In_TangentWS16_g251423 , In_BitangentWS16_g251423 , In_ViewDirWS16_g251423 , In_CoordsData16_g251423 , In_VertexData16_g251423 , In_MasksData16_g251423 , In_PhaseData16_g251423 , In_TransformData16_g251423 , In_RotationData16_g251423 , In_InterpolatorA16_g251423 );
					TVEModelData Data15_g251482 =(TVEModelData)Data16_g251423;
					float Out_Dummy15_g251482 = 0.0;
					float3 Out_PositionOS15_g251482 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251482 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251482 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251482 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251482 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251482 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251482 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251482 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251482 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251482 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251482 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251482 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251482 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251482 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251482 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251482 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251482 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251482 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251482 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251482 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251482 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251482 , Out_Dummy15_g251482 , Out_PositionOS15_g251482 , Out_PositionWS15_g251482 , Out_PositionWO15_g251482 , Out_PositionRawOS15_g251482 , Out_PivotOS15_g251482 , Out_PivotWS15_g251482 , Out_PivotWO15_g251482 , Out_NormalOS15_g251482 , Out_NormalWS15_g251482 , Out_NormalRawOS15_g251482 , Out_TangentOS15_g251482 , Out_TangentWS15_g251482 , Out_BitangentWS15_g251482 , Out_ViewDirWS15_g251482 , Out_CoordsData15_g251482 , Out_VertexData15_g251482 , Out_MasksData15_g251482 , Out_PhaseData15_g251482 , Out_TransformData15_g251482 , Out_RotationData15_g251482 , Out_InterpolatorA15_g251482 );
					TVEModelData Data16_g251483 =(TVEModelData)Data15_g251482;
					float temp_output_14_0_g251483 = 0.0;
					float In_Dummy16_g251483 = temp_output_14_0_g251483;
					float3 Model_PositionOS147_g251481 = Out_PositionOS15_g251482;
					half3 VertexPos40_g251487 = Model_PositionOS147_g251481;
					float4 temp_output_1567_33_g251481 = Out_RotationData15_g251482;
					half4 Model_RotationData1569_g251481 = temp_output_1567_33_g251481;
					float2 break1582_g251481 = (Model_RotationData1569_g251481).xy;
					half Angle44_g251487 = break1582_g251481.y;
					half CosAngle89_g251487 = cos( Angle44_g251487 );
					half SinAngle93_g251487 = sin( Angle44_g251487 );
					float3 appendResult95_g251487 = (float3((VertexPos40_g251487).x , ( ( (VertexPos40_g251487).y * CosAngle89_g251487 ) - ( (VertexPos40_g251487).z * SinAngle93_g251487 ) ) , ( ( (VertexPos40_g251487).y * SinAngle93_g251487 ) + ( (VertexPos40_g251487).z * CosAngle89_g251487 ) )));
					half3 VertexPos40_g251488 = appendResult95_g251487;
					half Angle44_g251488 = -break1582_g251481.x;
					half CosAngle94_g251488 = cos( Angle44_g251488 );
					half SinAngle95_g251488 = sin( Angle44_g251488 );
					float3 appendResult98_g251488 = (float3(( ( (VertexPos40_g251488).x * CosAngle94_g251488 ) - ( (VertexPos40_g251488).y * SinAngle95_g251488 ) ) , ( ( (VertexPos40_g251488).x * SinAngle95_g251488 ) + ( (VertexPos40_g251488).y * CosAngle94_g251488 ) ) , (VertexPos40_g251488).z));
					half3 VertexPos40_g251486 = Model_PositionOS147_g251481;
					half Angle44_g251486 = break1582_g251481.y;
					half CosAngle89_g251486 = cos( Angle44_g251486 );
					half SinAngle93_g251486 = sin( Angle44_g251486 );
					float3 appendResult95_g251486 = (float3((VertexPos40_g251486).x , ( ( (VertexPos40_g251486).y * CosAngle89_g251486 ) - ( (VertexPos40_g251486).z * SinAngle93_g251486 ) ) , ( ( (VertexPos40_g251486).y * SinAngle93_g251486 ) + ( (VertexPos40_g251486).z * CosAngle89_g251486 ) )));
					half3 VertexPos40_g251491 = appendResult95_g251486;
					half Angle44_g251491 = break1582_g251481.x;
					half CosAngle91_g251491 = cos( Angle44_g251491 );
					half SinAngle92_g251491 = sin( Angle44_g251491 );
					float3 appendResult93_g251491 = (float3(( ( (VertexPos40_g251491).x * CosAngle91_g251491 ) + ( (VertexPos40_g251491).z * SinAngle92_g251491 ) ) , (VertexPos40_g251491).y , ( ( -(VertexPos40_g251491).x * SinAngle92_g251491 ) + ( (VertexPos40_g251491).z * CosAngle91_g251491 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251489 = appendResult93_g251491;
					#else
					float3 staticSwitch65_g251489 = appendResult98_g251488;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251484 = staticSwitch65_g251489;
					#else
					float3 staticSwitch65_g251484 = Model_PositionOS147_g251481;
					#endif
					float3 temp_output_1608_0_g251481 = staticSwitch65_g251484;
					half3 VertexPos40_g251490 = temp_output_1608_0_g251481;
					half Angle44_g251490 = (Model_RotationData1569_g251481).z;
					half CosAngle91_g251490 = cos( Angle44_g251490 );
					half SinAngle92_g251490 = sin( Angle44_g251490 );
					float3 appendResult93_g251490 = (float3(( ( (VertexPos40_g251490).x * CosAngle91_g251490 ) + ( (VertexPos40_g251490).z * SinAngle92_g251490 ) ) , (VertexPos40_g251490).y , ( ( -(VertexPos40_g251490).x * SinAngle92_g251490 ) + ( (VertexPos40_g251490).z * CosAngle91_g251490 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251485 = appendResult93_g251490;
					#else
					float3 staticSwitch65_g251485 = temp_output_1608_0_g251481;
					#endif
					float4 temp_output_1567_31_g251481 = Out_TransformData15_g251482;
					half4 Model_TransformData1568_g251481 = temp_output_1567_31_g251481;
					half3 Final_PositionOS178_g251481 = ( ( staticSwitch65_g251485 * (Model_TransformData1568_g251481).w ) + (Model_TransformData1568_g251481).xyz );
					float3 temp_output_4_0_g251483 = Final_PositionOS178_g251481;
					float3 In_PositionOS16_g251483 = temp_output_4_0_g251483;
					float3 In_PositionWS16_g251483 = Out_PositionWS15_g251482;
					float3 In_PositionWO16_g251483 = Out_PositionWO15_g251482;
					float3 In_PositionRawOS16_g251483 = Out_PositionRawOS15_g251482;
					float3 In_PivotOS16_g251483 = Out_PivotOS15_g251482;
					float3 In_PivotWS16_g251483 = Out_PivotWS15_g251482;
					float3 In_PivotWO16_g251483 = Out_PivotWO15_g251482;
					float3 temp_output_21_0_g251483 = Out_NormalOS15_g251482;
					float3 In_NormalOS16_g251483 = temp_output_21_0_g251483;
					float3 In_NormalWS16_g251483 = Out_NormalWS15_g251482;
					float3 In_NormalRawOS16_g251483 = Out_NormalRawOS15_g251482;
					float4 temp_output_6_0_g251483 = Out_TangentOS15_g251482;
					float4 In_TangentOS16_g251483 = temp_output_6_0_g251483;
					float3 In_TangentWS16_g251483 = Out_TangentWS15_g251482;
					float3 In_BitangentWS16_g251483 = Out_BitangentWS15_g251482;
					float3 In_ViewDirWS16_g251483 = Out_ViewDirWS15_g251482;
					float4 In_CoordsData16_g251483 = Out_CoordsData15_g251482;
					float4 In_VertexData16_g251483 = Out_VertexData15_g251482;
					float4 In_MasksData16_g251483 = Out_MasksData15_g251482;
					float4 In_PhaseData16_g251483 = Out_PhaseData15_g251482;
					float4 In_TransformData16_g251483 = temp_output_1567_31_g251481;
					float4 In_RotationData16_g251483 = temp_output_1567_33_g251481;
					float4 In_InterpolatorA16_g251483 = Out_InterpolatorA15_g251482;
					BuildModelVertData( Data16_g251483 , In_Dummy16_g251483 , In_PositionOS16_g251483 , In_PositionWS16_g251483 , In_PositionWO16_g251483 , In_PositionRawOS16_g251483 , In_PivotOS16_g251483 , In_PivotWS16_g251483 , In_PivotWO16_g251483 , In_NormalOS16_g251483 , In_NormalWS16_g251483 , In_NormalRawOS16_g251483 , In_TangentOS16_g251483 , In_TangentWS16_g251483 , In_BitangentWS16_g251483 , In_ViewDirWS16_g251483 , In_CoordsData16_g251483 , In_VertexData16_g251483 , In_MasksData16_g251483 , In_PhaseData16_g251483 , In_TransformData16_g251483 , In_RotationData16_g251483 , In_InterpolatorA16_g251483 );
					TVEModelData Data15_g251514 =(TVEModelData)Data16_g251483;
					float Out_Dummy15_g251514 = 0.0;
					float3 Out_PositionOS15_g251514 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251514 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251514 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251514 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251514 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251514 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251514 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251514 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251514 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251514 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251514 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251514 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251514 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251514 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251514 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251514 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251514 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251514 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251514 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251514 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251514 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251514 , Out_Dummy15_g251514 , Out_PositionOS15_g251514 , Out_PositionWS15_g251514 , Out_PositionWO15_g251514 , Out_PositionRawOS15_g251514 , Out_PivotOS15_g251514 , Out_PivotWS15_g251514 , Out_PivotWO15_g251514 , Out_NormalOS15_g251514 , Out_NormalWS15_g251514 , Out_NormalRawOS15_g251514 , Out_TangentOS15_g251514 , Out_TangentWS15_g251514 , Out_BitangentWS15_g251514 , Out_ViewDirWS15_g251514 , Out_CoordsData15_g251514 , Out_VertexData15_g251514 , Out_MasksData15_g251514 , Out_PhaseData15_g251514 , Out_TransformData15_g251514 , Out_RotationData15_g251514 , Out_InterpolatorA15_g251514 );
					TVEModelData Data16_g251515 =(TVEModelData)Data15_g251514;
					float temp_output_14_0_g251515 = 0.0;
					float In_Dummy16_g251515 = temp_output_14_0_g251515;
					float3 temp_output_217_24_g251513 = Out_PivotOS15_g251514;
					float3 temp_output_216_0_g251513 = ( Out_PositionOS15_g251514 + temp_output_217_24_g251513 );
					float3 temp_output_4_0_g251515 = temp_output_216_0_g251513;
					float3 In_PositionOS16_g251515 = temp_output_4_0_g251515;
					float3 In_PositionWS16_g251515 = Out_PositionWS15_g251514;
					float3 In_PositionWO16_g251515 = Out_PositionWO15_g251514;
					float3 In_PositionRawOS16_g251515 = Out_PositionRawOS15_g251514;
					float3 In_PivotOS16_g251515 = temp_output_217_24_g251513;
					float3 In_PivotWS16_g251515 = Out_PivotWS15_g251514;
					float3 In_PivotWO16_g251515 = Out_PivotWO15_g251514;
					float3 temp_output_21_0_g251515 = Out_NormalOS15_g251514;
					float3 In_NormalOS16_g251515 = temp_output_21_0_g251515;
					float3 In_NormalWS16_g251515 = Out_NormalWS15_g251514;
					float3 In_NormalRawOS16_g251515 = Out_NormalRawOS15_g251514;
					float4 temp_output_6_0_g251515 = Out_TangentOS15_g251514;
					float4 In_TangentOS16_g251515 = temp_output_6_0_g251515;
					float3 In_TangentWS16_g251515 = Out_TangentWS15_g251514;
					float3 In_BitangentWS16_g251515 = Out_BitangentWS15_g251514;
					float3 In_ViewDirWS16_g251515 = Out_ViewDirWS15_g251514;
					float4 In_CoordsData16_g251515 = Out_CoordsData15_g251514;
					float4 In_VertexData16_g251515 = Out_VertexData15_g251514;
					float4 In_MasksData16_g251515 = Out_MasksData15_g251514;
					float4 In_PhaseData16_g251515 = Out_PhaseData15_g251514;
					float4 In_TransformData16_g251515 = Out_TransformData15_g251514;
					float4 In_RotationData16_g251515 = Out_RotationData15_g251514;
					float4 In_InterpolatorA16_g251515 = Out_InterpolatorA15_g251514;
					BuildModelVertData( Data16_g251515 , In_Dummy16_g251515 , In_PositionOS16_g251515 , In_PositionWS16_g251515 , In_PositionWO16_g251515 , In_PositionRawOS16_g251515 , In_PivotOS16_g251515 , In_PivotWS16_g251515 , In_PivotWO16_g251515 , In_NormalOS16_g251515 , In_NormalWS16_g251515 , In_NormalRawOS16_g251515 , In_TangentOS16_g251515 , In_TangentWS16_g251515 , In_BitangentWS16_g251515 , In_ViewDirWS16_g251515 , In_CoordsData16_g251515 , In_VertexData16_g251515 , In_MasksData16_g251515 , In_PhaseData16_g251515 , In_TransformData16_g251515 , In_RotationData16_g251515 , In_InterpolatorA16_g251515 );
					TVEModelData Data15_g251524 =(TVEModelData)Data16_g251515;
					float Out_Dummy15_g251524 = 0.0;
					float3 Out_PositionOS15_g251524 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251524 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251524 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251524 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251524 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251524 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251524 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251524 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251524 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251524 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251524 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251524 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251524 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251524 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251524 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251524 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251524 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251524 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251524 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251524 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g251524 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251524 , Out_Dummy15_g251524 , Out_PositionOS15_g251524 , Out_PositionWS15_g251524 , Out_PositionWO15_g251524 , Out_PositionRawOS15_g251524 , Out_PivotOS15_g251524 , Out_PivotWS15_g251524 , Out_PivotWO15_g251524 , Out_NormalOS15_g251524 , Out_NormalWS15_g251524 , Out_NormalRawOS15_g251524 , Out_TangentOS15_g251524 , Out_TangentWS15_g251524 , Out_BitangentWS15_g251524 , Out_ViewDirWS15_g251524 , Out_CoordsData15_g251524 , Out_VertexData15_g251524 , Out_MasksData15_g251524 , Out_PhaseData15_g251524 , Out_TransformData15_g251524 , Out_RotationData15_g251524 , Out_InterpolatorA15_g251524 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251524;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251524;
					v.tangent = Out_TangentOS15_g251524;

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
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2631;-7296,-5376;Inherit;False;Property;_IsShaderType;_IsShaderType;25;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2635;-6912,-4736;Inherit;False;If Model Data;-1;;241817;d269c9c511ff160419055604aade1e70;1,32,1;9;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;33;OBJECT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2373;-6592,-4736;Half;False;Model Frag;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2637;-7104,-5376;Half;False;IsShaderType;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2632;-7296,-4864;Inherit;False;Block Model;12;;241818;7ad7765e793a6714babedee0033c36e9;18,404,0,437,0,431,0,240,0,290,0,289,0,291,0,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0;11;102;FLOAT3;0,0,0;False;163;FLOAT3;0,0,0;False;186;FLOAT3;0,0,0;False;187;FLOAT3;0,0,0;False;166;FLOAT3;0,0,0;False;164;FLOAT3;0,0,0;False;301;FLOAT3;0,0,0;False;418;FLOAT3;0,0,0;False;167;FLOAT4;0,0,0,0;False;172;FLOAT4;0,0,0,0;False;175;FLOAT4;0,0,0,0;False;2;OBJECT;128;OBJECT;314
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2633;-7296,-4736;Inherit;False;2637;IsShaderType;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2634;-7296,-4992;Inherit;False;Block Model;12;;241838;7ad7765e793a6714babedee0033c36e9;18,404,1,437,1,431,1,240,1,290,1,289,1,291,1,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0;11;102;FLOAT3;0,0,0;False;163;FLOAT3;0,0,0;False;186;FLOAT3;0,0,0;False;187;FLOAT3;0,0,0;False;166;FLOAT3;0,0,0;False;164;FLOAT3;0,0,0;False;301;FLOAT3;0,0,0;False;418;FLOAT3;0,0,0;False;167;FLOAT4;0,0,0,0;False;172;FLOAT4;0,0,0,0;False;175;FLOAT4;0,0,0,0;False;2;OBJECT;128;OBJECT;314
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2374;-6144,-4992;Inherit;False;2373;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2375;-5888,-4992;Inherit;False;Block Global;26;;241858;212e17d4006dc88449d56ce0340cb5ff;32,308,1,560,1,276,1,285,1,402,1,385,1,283,1,282,1,396,1,417,1,484,0,485,0,486,0,487,0,561,0,482,0,488,0,483,0,315,1,598,0,311,1,578,0,317,1,603,0,604,0,607,0,421,1,321,1,398,1,413,0,557,1,404,1;1;206;OBJECT;0,0,0,0;False;1;OBJECT;151
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2636;-6912,-4992;Inherit;False;If Model Data;-1;;241935;d269c9c511ff160419055604aade1e70;1,32,1;9;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;33;OBJECT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2377;-6592,-4992;Half;False;Model Vert;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2505;-5568,-4992;Half;False;Global Data;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2508;-1280,-4992;Inherit;False;2377;Model Vert;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2507;-1280,-4928;Inherit;False;2505;Global Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2621;128,-3808;Inherit;False;FLOAT;2;2;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2611;128,-4448;Inherit;False;FLOAT;2;2;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2646;-1024,-4992;Inherit;False;Block Motion;110;;241936;d9ac7ad4f0387004fb72c16019bf8392;6,2748,1,2751,1,2753,1,2749,1,3080,1,3079,0;2;146;OBJECT;0,0,0,0;False;212;OBJECT;0,0,0,0;False;2;OBJECT;128;OBJECT;2951
Node;AmplifyShaderEditor.HSVToRGBNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2618;320,-3808;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.HSVToRGBNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2613;320,-4448;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2570;128,-3200;Inherit;False;Tool Debug Active;7;;241995;0bb5baa3fd5a859489bbfc09acf77496;0;2;80;FLOAT3;0,0,0;False;102;FLOAT;0;False;2;FLOAT3;108;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2569;128,-3072;Inherit;False;FLOAT;2;0;0;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2640;128,-2944;Inherit;False;Tool Debug Active;7;;251311;0bb5baa3fd5a859489bbfc09acf77496;0;2;80;FLOAT3;0,0,0;False;102;FLOAT;0;False;2;FLOAT3;108;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2643;128,-2816;Inherit;False;FLOAT;3;0;0;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2509;-640,-4864;Inherit;False;Break Masks Data;-1;;251313;23311522ecc97b54e8b77d849401069d;0;1;6;OBJECT;0;False;8;FLOAT4;14;FLOAT4;0;FLOAT4;23;FLOAT4;5;FLOAT4;24;FLOAT4;25;FLOAT4;26;FLOAT4;27
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2603;-5120,-4992;Inherit;False;2377;Model Vert;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2511;128,-4736;Inherit;False;FLOAT3;0;0;0;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2551;128,-4992;Inherit;False;Tool Debug Active;7;;251314;0bb5baa3fd5a859489bbfc09acf77496;0;2;80;FLOAT3;0,0,0;False;102;FLOAT;0;False;2;FLOAT3;108;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2567;128,-4864;Inherit;False;FLOAT;0;0;0;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2513;128,-4640;Inherit;False;FLOAT3;1;1;1;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2573;128,-4000;Inherit;False;FLOAT3;1;1;1;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2574;128,-3904;Inherit;False;FLOAT3;2;2;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2512;128,-4096;Inherit;False;FLOAT3;0;0;0;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2548;128,-3360;Inherit;False;FLOAT3;1;1;1;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2517;128,-3456;Inherit;False;FLOAT3;0;0;0;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2530;128,-4544;Inherit;False;FLOAT3;2;2;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GammaToLinearNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2619;528,-3808;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2623;128,-3648;Inherit;False;FLOAT3;3;3;3;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GammaToLinearNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2614;528,-4448;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2616;128,-4320;Inherit;False;FLOAT3;3;3;3;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2571;384,-3200;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2641;384,-2944;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2604;-4864,-4992;Inherit;False;Block Pivots Sub;-1;;251334;186f08b1bbe15894d9c677d50398679b;0;1;146;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2605;-4864,-4864;Inherit;False;2505;Global Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2568;384,-4992;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2585;768,-4736;Inherit;False;Tool Debug Index;-1;;251338;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;2;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2586;768,-4640;Inherit;False;Tool Debug Index;-1;;251339;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;3;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2587;768,-4096;Inherit;False;Tool Debug Index;-1;;251340;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;8;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2588;768,-4000;Inherit;False;Tool Debug Index;-1;;251341;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;9;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2589;768,-3904;Inherit;False;Tool Debug Index;-1;;251342;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;10;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2620;768,-3808;Inherit;False;Tool Debug Index;-1;;251343;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;11;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2622;768,-3648;Inherit;False;Tool Debug Index;-1;;251344;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;12;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2590;768,-3456;Inherit;False;Tool Debug Index;-1;;251345;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;14;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2591;768,-3360;Inherit;False;Tool Debug Index;-1;;251346;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;15;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2593;768,-4544;Inherit;False;Tool Debug Index;-1;;251347;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;4;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2612;768,-4448;Inherit;False;Tool Debug Index;-1;;251348;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2615;768,-4320;Inherit;False;Tool Debug Index;-1;;251349;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;6;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2592;768,-3200;Inherit;False;Tool Debug Index;-1;;251350;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;17;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2642;768,-2944;Inherit;False;Tool Debug Index;-1;;251351;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;18;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2645;-4480,-4992;Inherit;False;Block Blanket Conform;159;;251365;3ce1684c4351aeb42b79a955aa483301;2,389,0,377,1;2;146;OBJECT;0,0,0,0;False;186;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2648;-4480,-4864;Inherit;False;2505;Global Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2523;1152,-4736;Inherit;False;5;5;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2594;768,-4992;Inherit;False;Tool Debug Index;-1;;251375;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2545;1152,-4096;Inherit;False;5;5;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2549;1152,-3456;Inherit;False;4;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2647;-4096,-4992;Inherit;False;Block Motion;110;;251422;d9ac7ad4f0387004fb72c16019bf8392;6,2748,1,2751,1,2753,1,2749,1,3080,1,3079,0;2;146;OBJECT;0,0,0,0;False;212;OBJECT;0,0,0,0;False;2;OBJECT;128;OBJECT;2951
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2379;-2560,-4992;Inherit;False;2373;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2550;1408,-4992;Inherit;False;4;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2610;-3712,-4992;Inherit;False;Block Transform;-1;;251481;5ac6202bdddd8b34a85c261af6b8de8b;0;1;146;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2380;-2304,-4992;Inherit;False;Block Main;85;;251492;b04cfed9a7b4c0841afdb49a38c282c5;12,65,1,136,1,41,1,133,1,40,1,329,1,344,0,347,0,342,0,345,0,346,0,343,0;1;225;OBJECT;0,0,0,0;False;1;OBJECT;106
Node;AmplifyShaderEditor.VertexToFragmentNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2524;1536,-4992;Inherit;False;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2607;-3328,-4992;Inherit;False;Block Pivots Add;-1;;251513;016babe9e3e643242aa4d123a988150c;0;1;146;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2454;-1984,-4992;Half;False;Visual Data;-1;True;1;0;OBJECT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2399;1856,-4992;Half;False;Final_Debug;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2608;-3008,-4992;Half;False;Model Data;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2400;2432,-4992;Inherit;False;2399;Final_Debug;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2563;2432,-4928;Inherit;False;2454;Visual Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2555;2432,-4864;Inherit;False;2608;Model Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.ConditionalIfNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1774;-880,2944;Inherit;False;True;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1803;-1344,2944;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1772;-1088,3072;Float;False;Constant;_Float3;Float 3;31;0;Create;True;0;0;0;False;0;False;24;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1843;-1632,2944;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1771;-1088,2944;Inherit;False;-1;;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1800;-1472,2944;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1804;-1792,2944;Inherit;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2203;3072,-5120;Inherit;False;Base Compile;-1;;251517;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2609;2688,-4992;Inherit;False;Tool Debug Color;0;;251518;d992d3ed4a7539141ba053d3e0c12277;0;3;80;FLOAT3;0,0,0;False;106;OBJECT;0,0,0;False;107;OBJECT;0,0,0;False;5;FLOAT;114;FLOAT3;0;FLOAT3;113;FLOAT3;148;FLOAT4;149
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2355;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2356;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2357;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2358;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2353;2688,-4992;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ExtraPrePass;0;0;ExtraPrePass;5;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2354;3072,-4992;Float;False;True;-1;3;;0;3;Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Motion;28cd5599e02859647ae1798e4fcaef6c;True;ForwardBase;0;1;ForwardBase;15;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;40;Category;0;0;Workflow;0;638874882197810641;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;0;638874603607655403;Deferred Pass;1;0;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;638814711411603618;Receive Shadows;0;638814711415148256;Receive Specular;0;638814711419031593;GPU Instancing;1;638874881145939632;LOD CrossFade;0;638814711429956434;Built-in Fog;0;638814711441065168;Ambient Light;0;638814711449050123;Meta Pass;0;638814711456998358;Add Pass;0;638814711466594157;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;638874882298697380;Vertex Position;0;638874601191422915;0;8;False;True;False;True;False;False;True;True;False;;True;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2638;3072,-4932;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2639;3072,-4992;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ScenePickingPass;0;7;ScenePickingPass;1;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=ScenePickingPass;False;False;0;;0;0;Standard;0;False;0
WireConnection;2635;33;2634;314
WireConnection;2635;27;2634;314
WireConnection;2635;28;2634;314
WireConnection;2635;29;2634;314
WireConnection;2635;30;2632;314
WireConnection;2635;31;2633;0
WireConnection;2373;0;2635;0
WireConnection;2637;0;2631;0
WireConnection;2375;206;2374;0
WireConnection;2636;33;2634;128
WireConnection;2636;27;2634;128
WireConnection;2636;28;2634;128
WireConnection;2636;29;2634;128
WireConnection;2636;30;2632;128
WireConnection;2636;31;2633;0
WireConnection;2377;0;2636;0
WireConnection;2505;0;2375;151
WireConnection;2621;0;2509;23
WireConnection;2611;0;2509;0
WireConnection;2646;146;2508;0
WireConnection;2646;212;2507;0
WireConnection;2618;0;2621;0
WireConnection;2613;0;2611;0
WireConnection;2569;0;2509;14
WireConnection;2643;0;2509;14
WireConnection;2509;6;2646;2951
WireConnection;2511;0;2509;0
WireConnection;2567;0;2509;14
WireConnection;2513;0;2509;0
WireConnection;2573;0;2509;23
WireConnection;2574;0;2509;23
WireConnection;2512;0;2509;23
WireConnection;2548;0;2509;5
WireConnection;2517;0;2509;5
WireConnection;2530;0;2509;0
WireConnection;2619;0;2618;0
WireConnection;2623;0;2509;23
WireConnection;2614;0;2613;0
WireConnection;2616;0;2509;0
WireConnection;2571;0;2570;108
WireConnection;2571;1;2570;0
WireConnection;2571;2;2569;0
WireConnection;2641;0;2640;108
WireConnection;2641;1;2640;0
WireConnection;2641;2;2643;0
WireConnection;2604;146;2603;0
WireConnection;2568;0;2551;108
WireConnection;2568;1;2551;0
WireConnection;2568;2;2567;0
WireConnection;2585;39;2511;0
WireConnection;2586;39;2513;0
WireConnection;2587;39;2512;0
WireConnection;2588;39;2573;0
WireConnection;2589;39;2574;0
WireConnection;2620;39;2619;0
WireConnection;2622;39;2623;0
WireConnection;2590;39;2517;0
WireConnection;2591;39;2548;0
WireConnection;2593;39;2530;0
WireConnection;2612;39;2614;0
WireConnection;2615;39;2616;0
WireConnection;2592;39;2571;0
WireConnection;2642;39;2641;0
WireConnection;2645;146;2604;128
WireConnection;2645;186;2605;0
WireConnection;2523;0;2585;0
WireConnection;2523;1;2586;0
WireConnection;2523;2;2593;0
WireConnection;2523;3;2612;0
WireConnection;2523;4;2615;0
WireConnection;2594;39;2568;0
WireConnection;2545;0;2587;0
WireConnection;2545;1;2588;0
WireConnection;2545;2;2589;0
WireConnection;2545;3;2620;0
WireConnection;2545;4;2622;0
WireConnection;2549;0;2590;0
WireConnection;2549;1;2591;0
WireConnection;2549;2;2592;0
WireConnection;2549;3;2642;0
WireConnection;2647;146;2645;128
WireConnection;2647;212;2648;0
WireConnection;2550;0;2594;0
WireConnection;2550;1;2523;0
WireConnection;2550;2;2545;0
WireConnection;2550;3;2549;0
WireConnection;2610;146;2647;128
WireConnection;2380;225;2379;0
WireConnection;2524;0;2550;0
WireConnection;2607;146;2610;128
WireConnection;2454;0;2380;106
WireConnection;2399;0;2524;0
WireConnection;2608;0;2607;128
WireConnection;1774;0;1771;0
WireConnection;1774;1;1772;0
WireConnection;1774;3;1803;0
WireConnection;1803;0;1800;0
WireConnection;1843;0;1804;0
WireConnection;1800;0;1843;0
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
//CHKSM=4BEF359AF9A54DBB987A447E87F85695E29F55B0