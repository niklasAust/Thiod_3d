// Made with Amplify Shader Editor v1.9.9.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Vertex"
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
		[StyledCategory(Rotation Settings, true, Use the Rotation feature to aligning the objects to the terrain or mesh surfaces., _RotationIntensityValue, FFFF00, 0, 10)] _RotationCategory( "[ Rotation Category ]", Float ) = 0
		[StyledMessage(Info, The Rotation features require elements to work. Use Form Surface or Form Normal elements for aligning the objects to terrain surfaces., 0, 10)] _RotationInfo( "_RotationInfo", Float ) = 0
		_RotationIntensityValue( "Rotation Intensity", Range( 0, 1 ) ) = 0
		[StyledSpace(10)] _RotationEnd( "[ Rotation End ]", Float ) = 1
		[StyledCategory(Perspective Settings, true, Use the Perspective feature to QUOhideQUO the mesh quads when grass models are viewed from the top. The effect will adapt to the camera projectionCOLNEWNEWWhen Perspective camera is used__ the vertices are pushed to the edges of the screen.NEWNEWWhen Orthographic camera is used__ the vertices are pushed forward based on the camera view., _PerspectiveIntensityValue, CD75FF, 0, 10)] _PerspectiveCategory( "[ Perspective Category ]", Float ) = 0
		_PerspectiveIntensityValue( "Perspective Intensity", Range( 0, 10 ) ) = 0
		_PerspectiveAngleValue( "Perspective Angle", Range( 0, 8 ) ) = 1
		_PerspectivePhaseValue( "Perspective Phase", Range( 0, 1 ) ) = 0
		[StyledSpace(10)] _PerspectiveEnd( "[ Perspective End ]", Float ) = 1
		[StyledCategory(Size Fade Settings, true, Use the Size Fade feature to fade out the size of the objects. The most common usage is to fade out grass on winter__ fade out grass based on distance or hide objects when placing building. Please note__ setting the size to zero might cut the perMINpixel rendering cost but it is best to not render the object at allEXC, _SizeFadeIntensityValue, 008BE6, 0, 10)] _SizeFadeCategory( "[ Size Fade Category ]", Float ) = 0
		_SizeFadeIntensityValue( "Size Fade Intensity", Range( 0, 1 ) ) = 0
		[Enum(All Axis,0,Up Axis,1)] _SizeFadeScaleMode( "Size Fade Mode", Float ) = 0
		_SizeFadeScaleValue( "Size Fade Value", Range( 0, 1 ) ) = 1
		_SizeFadeDistMinValue( "Size Fade Start", Range( 0, 2000 ) ) = 0
		_SizeFadeDistMaxValue( "Size Fade Limit", Range( 0, 2000 ) ) = 0
		[Space(10)] _SizeFadeGlobalValue( "Size Fade Form Mask", Range( 0, 1 ) ) = 1
		[Space(10)][StyledToggle] _SizeFadeElementMode( "Use Form Elements", Float ) = 0
		[StyledSpace(10)] _SizeFadeEnd( "[ Size Fade End ]", Float ) = 1
		[StyledCategory(Flatten Settings, true, Use the Flatten feature to flatten or spherify the vertex normals used for shading in the pixel stage. The most common usage is to give grass a more QUOlushQUO appearance or to spherify the shading for tree cannopies.NEWNEWUse the Baking option to preMINbake the shading to the impostor normal texture., _FlattenIntensityValue, 80FF00, 0, 10)] _FlattenCategory( "[ Flatten Category ]", Float ) = 0
		_FlattenIntensityValue( "Flatten Intensity", Range( 0, 1 ) ) = 0
		_FlattenSphereValue( "Flatten Spherical", Range( 0, 1 ) ) = 0
		[StyledVector(18)] _FlattenSphereOffsetValue( "Flatten Spherical Offset", Vector ) = ( 0, 0, 0, 0 )
		[Enum(Off,0,Bake Settings To Textures,1)] _FlattenBakeMode( "Flatten Baking", Float ) = 1
		[Space(10)] _FlattenMeshValue( "Flatten Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _FlattenMeshMode( "Flatten Mesh Mask", Float ) = 2
		[StyledRemapSlider] _FlattenMeshRemap( "Flatten Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[StyledSpace(10)] _FlattenEnd( "[ Flatten End ]", Float ) = 1
		[StyledCategory(Reshade Settings, true, Use the Reshade feature to reMINcalculate the vertex normals when Motion Primary Bending or Blanket Rotation features are used., _ReshadeIntensityValue, 8FC0FF, 0, 10)] _ReshadeCategory( "[ Reshade Category ]", Float ) = 0
		_ReshadeIntensityValue( "Reshade Intensity", Range( 0, 1 ) ) = 0
		[StyledSpace(10)] _ReshadeEnd( "[ Reshade End ]", Float ) = 1
		[StyledCategory(Transfer Settings, true, Use the Transfer feature to use the surface normals from terrain or meshes. The most common usage it to transfer the terrain normals to objects or grass models for seamless terrain blending. Please note__ different workflow can be used depending on the desired effectCOLNEWNEWFor grass to terrain blending__ use the Tinting feature with Paint Map elements. The Tranfer feature will ensure the same terrain shading is used for grass as well.NEWNEWFor object to terrain blending__ use the Terrain feature to support all terrain layers and settings. Transfer the terrain normals at the object to terrain intersection point only but keep the rest of the object shading untouched., _TransferIntensityValue, CCCC00, 0, 10)] _TransferCategory( "[ Transfer Category ]", Float ) = 0
		[StyledMessage(Info, The Transfer normal feature requires elements to work. Use Form Surface or Form Normal elements to send global normals to the shaders., 0, 10)] _TransferInfo( "_TransferInfo", Float ) = 0
		_TransferIntensityValue( "Transfer Intensity", Range( 0, 1 ) ) = 0
		[Enum(Per Vertex,0,Per Pixel,1)] _TransferPerPixelMode( "Transfer Mode", Float ) = 0
		[StyledSpace(10)] _TransferSpace( "[ Transfer Space ]", Float ) = 1
		_TransferProjValue( "Transfer ProjY Mask", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _TransferProjRemap( "Transfer ProjY Mask", Vector ) = ( 0, 1, 0, 0 )
		_TransferMeshValue( "Transfer Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _TransferMeshMode( "Transfer Mesh Mask", Float ) = 3
		[StyledRemapSlider] _TransferMeshRemap( "Transfer Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		_TransferFormValue( "Transfer Form Mask", Range( 0, 1 ) ) = 0
		[Enum(Additive,0,Multiply And Additive,1)] _TransferFormMode( "Transfer Form Mask", Float ) = 1
		_TransferFormOffsetValue( "Transfer Form Offset", Range( 0, 16 ) ) = 1
		[StyledSpace(10)] _TransferEnd( "[ Transfer End ]", Float ) = 1


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
				#define ASE_NEEDS_TEXTURE_COORDINATES1
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES1
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_COLOR
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_PERSPECTIVE
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_vertex TVE_ROTATION
				#pragma shader_feature_local_vertex TVE_SIZEFADE
				#pragma shader_feature_local_vertex TVE_SIZEFADE_ELEMENT
				#pragma shader_feature_local_vertex TVE_MOTION
				#pragma shader_feature_local_vertex TVE_MOTION_ELEMENT
				#pragma shader_feature_local TVE_LEGACY
				#pragma shader_feature_local_vertex TVE_FLATTEN
				#pragma shader_feature_local_vertex TVE_RESHADE
				#pragma shader_feature_local_vertex TVE_TRANSFER
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
				#if defined (TVE_CONFORM_ROTATION) //Conform Rotation
					#define TVE_ROTATION_BEND //Conform Rotation
				#endif //Conform Rotation
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
					float3 ase_normal : NORMAL;
					float4 ase_tangent : TANGENT;
					float4 ase_texcoord9 : TEXCOORD9;
					float4 ase_texcoord10 : TEXCOORD10;
					float4 ase_texcoord11 : TEXCOORD11;
					float4 ase_texcoord12 : TEXCOORD12;
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
				uniform half _PerspectiveCategory;
				uniform half _PerspectiveEnd;
				uniform half _PerspectivePhaseValue;
				uniform half _PerspectiveIntensityValue;
				uniform half _PerspectiveAngleValue;
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
				uniform half _RotationCategory;
				uniform half _RotationEnd;
				uniform half _RotationInfo;
				uniform half _RotationIntensityValue;
				uniform half _SizeFadeCategory;
				uniform half _SizeFadeEnd;
				uniform half4 TVE_SizeFadeParams;
				uniform float _SizeFadeDistMaxValue;
				uniform float _SizeFadeDistMinValue;
				uniform half _SizeFadeScaleValue;
				uniform half _SizeFadeElementMode;
				uniform half _SizeFadeGlobalValue;
				uniform half _SizeFadeScaleMode;
				uniform half _SizeFadeIntensityValue;
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
				uniform half _FlattenCategory;
				uniform half _FlattenEnd;
				uniform half _FlattenBakeMode;
				uniform half _FlattenIntensityValue;
				uniform half3 _FlattenSphereOffsetValue;
				uniform half _FlattenSphereValue;
				uniform half _FlattenMeshMode;
				uniform half4 _FlattenMeshRemap;
				uniform half _FlattenMeshValue;
				uniform half _ReshadeCategory;
				uniform half _ReshadeEnd;
				uniform half _ReshadeIntensityValue;
				uniform half _TransferCategory;
				uniform half _TransferEnd;
				uniform half _TransferSpace;
				uniform half _TransferIntensityValue;
				uniform half _TransferPerPixelMode;
				uniform half _TransferInfo;
				uniform half4 _TransferProjRemap;
				uniform half _TransferProjValue;
				uniform half _TransferMeshMode;
				uniform half4 _TransferMeshRemap;
				uniform half _TransferMeshValue;
				uniform half _TransferFormOffsetValue;
				uniform half _TransferFormValue;
				uniform half _TransferFormMode;
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

					float localIfModelDataByShader26_g262440 = ( 0.0 );
					TVEModelData Data26_g262440 = (TVEModelData)0;
					TVEModelData Data16_g262431 =(TVEModelData)0;
					half Dummy207_g262421 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g262431 = Dummy207_g262421;
					float In_Dummy16_g262431 = temp_output_14_0_g262431;
					float3 PositionOS131_g262421 = v.vertex.xyz;
					float3 temp_output_4_0_g262431 = PositionOS131_g262421;
					float3 In_PositionOS16_g262431 = temp_output_4_0_g262431;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g262421 = ase_positionWS;
					float3 vertexToFrag73_g262421 = temp_output_104_7_g262421;
					float3 PositionWS122_g262421 = vertexToFrag73_g262421;
					float3 In_PositionWS16_g262431 = PositionWS122_g262421;
					float4x4 break19_g262424 = unity_ObjectToWorld;
					float3 appendResult20_g262424 = (float3(break19_g262424[ 0 ][ 3 ] , break19_g262424[ 1 ][ 3 ] , break19_g262424[ 2 ][ 3 ]));
					float3 temp_output_340_7_g262421 = appendResult20_g262424;
					float4x4 break19_g262426 = unity_ObjectToWorld;
					float3 appendResult20_g262426 = (float3(break19_g262426[ 0 ][ 3 ] , break19_g262426[ 1 ][ 3 ] , break19_g262426[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g262422 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g262421 = PositionOS131_g262421;
					float3 appendResult234_g262421 = (float3(break233_g262421.x , 0.0 , break233_g262421.z));
					float3 break413_g262421 = PositionOS131_g262421;
					float3 appendResult414_g262421 = (float3(break413_g262421.x , break413_g262421.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262428 = appendResult414_g262421;
					#else
					float3 staticSwitch65_g262428 = appendResult234_g262421;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g262421 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g262421 = appendResult60_g262422;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g262421 = staticSwitch65_g262428;
					#else
					float3 staticSwitch229_g262421 = _Vector0;
					#endif
					float3 PivotOS149_g262421 = staticSwitch229_g262421;
					float3 temp_output_122_0_g262426 = PivotOS149_g262421;
					float3 PivotsOnlyWS105_g262426 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g262426 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g262421 = ( appendResult20_g262426 + PivotsOnlyWS105_g262426 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g262421 = temp_output_340_7_g262421;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g262421 = temp_output_341_7_g262421;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g262421 = temp_output_341_7_g262421;
					#else
					float3 staticSwitch236_g262421 = temp_output_340_7_g262421;
					#endif
					float3 vertexToFrag76_g262421 = staticSwitch236_g262421;
					float3 PivotWS121_g262421 = vertexToFrag76_g262421;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g262421 = ( PositionWS122_g262421 - PivotWS121_g262421 );
					#else
					float3 staticSwitch204_g262421 = PositionWS122_g262421;
					#endif
					float3 PositionWO132_g262421 = ( staticSwitch204_g262421 - TVE_WorldOrigin );
					float3 In_PositionWO16_g262431 = PositionWO132_g262421;
					float3 In_PositionRawOS16_g262431 = PositionOS131_g262421;
					float3 In_PivotOS16_g262431 = PivotOS149_g262421;
					float3 In_PivotWS16_g262431 = PivotWS121_g262421;
					float3 PivotWO133_g262421 = ( PivotWS121_g262421 - TVE_WorldOrigin );
					float3 In_PivotWO16_g262431 = PivotWO133_g262421;
					half3 NormalOS134_g262421 = v.normal;
					float3 temp_output_21_0_g262431 = NormalOS134_g262421;
					float3 In_NormalOS16_g262431 = temp_output_21_0_g262431;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g262421 = normalizedWorldNormal;
					float3 In_NormalWS16_g262431 = NormalWS95_g262421;
					float3 In_NormalRawOS16_g262431 = NormalOS134_g262421;
					half4 TangentlOS153_g262421 = v.tangent;
					float4 temp_output_6_0_g262431 = TangentlOS153_g262421;
					float4 In_TangentOS16_g262431 = temp_output_6_0_g262431;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g262421 = ase_tangentWS;
					float3 In_TangentWS16_g262431 = TangentWS136_g262421;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g262421 = ase_bitangentWS;
					float3 In_BitangentWS16_g262431 = BiangentWS421_g262421;
					float3 normalizeResult296_g262421 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g262421 ) );
					half3 ViewDirWS169_g262421 = normalizeResult296_g262421;
					float3 In_ViewDirWS16_g262431 = ViewDirWS169_g262421;
					float4 appendResult397_g262421 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g262421 = appendResult397_g262421;
					float4 In_CoordsData16_g262431 = CoordsData398_g262421;
					half4 VertexMasks171_g262421 = v.ase_color;
					float4 In_VertexData16_g262431 = VertexMasks171_g262421;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g262434 = (PositionOS131_g262421).z;
					#else
					float staticSwitch65_g262434 = (PositionOS131_g262421).y;
					#endif
					half Object_HeightValue267_g262421 = _ObjectHeightValue;
					half Bounds_HeightMask274_g262421 = saturate( ( staticSwitch65_g262434 / Object_HeightValue267_g262421 ) );
					half3 Position387_g262421 = PositionOS131_g262421;
					half Height387_g262421 = Object_HeightValue267_g262421;
					half Object_RadiusValue268_g262421 = _ObjectRadiusValue;
					half Radius387_g262421 = Object_RadiusValue268_g262421;
					half localCapsuleMaskYUp387_g262421 = CapsuleMaskYUp( Position387_g262421 , Height387_g262421 , Radius387_g262421 );
					half3 Position408_g262421 = PositionOS131_g262421;
					half Height408_g262421 = Object_HeightValue267_g262421;
					half Radius408_g262421 = Object_RadiusValue268_g262421;
					half localCapsuleMaskZUp408_g262421 = CapsuleMaskZUp( Position408_g262421 , Height408_g262421 , Radius408_g262421 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g262439 = saturate( localCapsuleMaskZUp408_g262421 );
					#else
					float staticSwitch65_g262439 = saturate( localCapsuleMaskYUp387_g262421 );
					#endif
					half Bounds_SphereMask282_g262421 = staticSwitch65_g262439;
					float4 appendResult253_g262421 = (float4(Bounds_HeightMask274_g262421 , Bounds_SphereMask282_g262421 , 1.0 , 1.0));
					half4 MasksData254_g262421 = appendResult253_g262421;
					float4 In_MasksData16_g262431 = MasksData254_g262421;
					float temp_output_17_0_g262433 = _ObjectPhaseMode;
					float Option70_g262433 = temp_output_17_0_g262433;
					float4 temp_output_3_0_g262433 = v.ase_color;
					float4 Channel70_g262433 = temp_output_3_0_g262433;
					float localSwitchChannel470_g262433 = SwitchChannel4( Option70_g262433 , Channel70_g262433 );
					half Phase_Value372_g262421 = localSwitchChannel470_g262433;
					float3 break319_g262421 = PivotWO133_g262421;
					half Pivot_Position322_g262421 = ( break319_g262421.x + break319_g262421.z );
					half Phase_Position357_g262421 = ( Phase_Value372_g262421 + Pivot_Position322_g262421 );
					float temp_output_248_0_g262421 = frac( Phase_Position357_g262421 );
					float4 appendResult177_g262421 = (float4(( (frac( ( Phase_Position357_g262421 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g262421));
					half4 Phase_Data176_g262421 = appendResult177_g262421;
					float4 In_PhaseData16_g262431 = Phase_Data176_g262421;
					float4 In_TransformData16_g262431 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g262431 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g262431 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g262431 , In_Dummy16_g262431 , In_PositionOS16_g262431 , In_PositionWS16_g262431 , In_PositionWO16_g262431 , In_PositionRawOS16_g262431 , In_PivotOS16_g262431 , In_PivotWS16_g262431 , In_PivotWO16_g262431 , In_NormalOS16_g262431 , In_NormalWS16_g262431 , In_NormalRawOS16_g262431 , In_TangentOS16_g262431 , In_TangentWS16_g262431 , In_BitangentWS16_g262431 , In_ViewDirWS16_g262431 , In_CoordsData16_g262431 , In_VertexData16_g262431 , In_MasksData16_g262431 , In_PhaseData16_g262431 , In_TransformData16_g262431 , In_RotationData16_g262431 , In_InterpolatorA16_g262431 );
					TVEModelData DataDefault26_g262440 = Data16_g262431;
					TVEModelData DataGeneral26_g262440 = Data16_g262431;
					TVEModelData DataBlanket26_g262440 = Data16_g262431;
					TVEModelData DataImpostor26_g262440 = Data16_g262431;
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
					TVEModelData DataTerrain26_g262440 = Data16_g241828;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g262440 = IsShaderType2637;
					{
					if (Type26_g262440 == 0 )
					{
					Data26_g262440 = DataDefault26_g262440;
					}
					else if (Type26_g262440 == 1 )
					{
					Data26_g262440 = DataGeneral26_g262440;
					}
					else if (Type26_g262440 == 2 )
					{
					Data26_g262440 = DataBlanket26_g262440;
					}
					else if (Type26_g262440 == 3 )
					{
					Data26_g262440 = DataImpostor26_g262440;
					}
					else if (Type26_g262440 == 4 )
					{
					Data26_g262440 = DataTerrain26_g262440;
					}
					}
					TVEModelData Data15_g262519 =(TVEModelData)Data26_g262440;
					float Out_Dummy15_g262519 = 0.0;
					float3 Out_PositionOS15_g262519 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262519 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262519 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262519 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262519 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262519 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262519 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262519 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262519 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262519 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262519 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262519 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262519 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262519 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262519 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262519 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262519 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262519 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262519 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262519 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262519 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262519 , Out_Dummy15_g262519 , Out_PositionOS15_g262519 , Out_PositionWS15_g262519 , Out_PositionWO15_g262519 , Out_PositionRawOS15_g262519 , Out_PivotOS15_g262519 , Out_PivotWS15_g262519 , Out_PivotWO15_g262519 , Out_NormalOS15_g262519 , Out_NormalWS15_g262519 , Out_NormalRawOS15_g262519 , Out_TangentOS15_g262519 , Out_TangentWS15_g262519 , Out_BitangentWS15_g262519 , Out_ViewDirWS15_g262519 , Out_CoordsData15_g262519 , Out_VertexData15_g262519 , Out_MasksData15_g262519 , Out_PhaseData15_g262519 , Out_TransformData15_g262519 , Out_RotationData15_g262519 , Out_InterpolatorA15_g262519 );
					TVEModelData Data16_g262521 =(TVEModelData)Data15_g262519;
					float temp_output_14_0_g262521 = 0.0;
					float In_Dummy16_g262521 = temp_output_14_0_g262521;
					float3 temp_output_219_24_g262518 = Out_PivotOS15_g262519;
					float3 temp_output_215_0_g262518 = ( Out_PositionOS15_g262519 - temp_output_219_24_g262518 );
					float3 temp_output_4_0_g262521 = temp_output_215_0_g262518;
					float3 In_PositionOS16_g262521 = temp_output_4_0_g262521;
					float3 In_PositionWS16_g262521 = Out_PositionWS15_g262519;
					float3 In_PositionWO16_g262521 = Out_PositionWO15_g262519;
					float3 In_PositionRawOS16_g262521 = Out_PositionRawOS15_g262519;
					float3 In_PivotOS16_g262521 = temp_output_219_24_g262518;
					float3 In_PivotWS16_g262521 = Out_PivotWS15_g262519;
					float3 In_PivotWO16_g262521 = Out_PivotWO15_g262519;
					float3 temp_output_21_0_g262521 = Out_NormalOS15_g262519;
					float3 In_NormalOS16_g262521 = temp_output_21_0_g262521;
					float3 In_NormalWS16_g262521 = Out_NormalWS15_g262519;
					float3 In_NormalRawOS16_g262521 = Out_NormalRawOS15_g262519;
					float4 temp_output_6_0_g262521 = Out_TangentOS15_g262519;
					float4 In_TangentOS16_g262521 = temp_output_6_0_g262521;
					float3 In_TangentWS16_g262521 = Out_TangentWS15_g262519;
					float3 In_BitangentWS16_g262521 = Out_BitangentWS15_g262519;
					float3 In_ViewDirWS16_g262521 = Out_ViewDirWS15_g262519;
					float4 In_CoordsData16_g262521 = Out_CoordsData15_g262519;
					float4 In_VertexData16_g262521 = Out_VertexData15_g262519;
					float4 In_MasksData16_g262521 = Out_MasksData15_g262519;
					float4 In_PhaseData16_g262521 = Out_PhaseData15_g262519;
					float4 In_TransformData16_g262521 = Out_TransformData15_g262519;
					float4 In_RotationData16_g262521 = Out_RotationData15_g262519;
					float4 In_InterpolatorA16_g262521 = Out_InterpolatorA15_g262519;
					BuildModelVertData( Data16_g262521 , In_Dummy16_g262521 , In_PositionOS16_g262521 , In_PositionWS16_g262521 , In_PositionWO16_g262521 , In_PositionRawOS16_g262521 , In_PivotOS16_g262521 , In_PivotWS16_g262521 , In_PivotWO16_g262521 , In_NormalOS16_g262521 , In_NormalWS16_g262521 , In_NormalRawOS16_g262521 , In_TangentOS16_g262521 , In_TangentWS16_g262521 , In_BitangentWS16_g262521 , In_ViewDirWS16_g262521 , In_CoordsData16_g262521 , In_VertexData16_g262521 , In_MasksData16_g262521 , In_PhaseData16_g262521 , In_TransformData16_g262521 , In_RotationData16_g262521 , In_InterpolatorA16_g262521 );
					TVEModelData Data15_g262525 =(TVEModelData)Data16_g262521;
					float Out_Dummy15_g262525 = 0.0;
					float3 Out_PositionOS15_g262525 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262525 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262525 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262525 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262525 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262525 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262525 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262525 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262525 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262525 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262525 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262525 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262525 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262525 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262525 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262525 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262525 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262525 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262525 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262525 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262525 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262525 , Out_Dummy15_g262525 , Out_PositionOS15_g262525 , Out_PositionWS15_g262525 , Out_PositionWO15_g262525 , Out_PositionRawOS15_g262525 , Out_PivotOS15_g262525 , Out_PivotWS15_g262525 , Out_PivotWO15_g262525 , Out_NormalOS15_g262525 , Out_NormalWS15_g262525 , Out_NormalRawOS15_g262525 , Out_TangentOS15_g262525 , Out_TangentWS15_g262525 , Out_BitangentWS15_g262525 , Out_ViewDirWS15_g262525 , Out_CoordsData15_g262525 , Out_VertexData15_g262525 , Out_MasksData15_g262525 , Out_PhaseData15_g262525 , Out_TransformData15_g262525 , Out_RotationData15_g262525 , Out_InterpolatorA15_g262525 );
					TVEModelData Data16_g262524 =(TVEModelData)Data15_g262525;
					half Dummy181_g262522 = ( _PerspectiveCategory + _PerspectiveEnd );
					float temp_output_14_0_g262524 = Dummy181_g262522;
					float In_Dummy16_g262524 = temp_output_14_0_g262524;
					half3 Model_PositionOS147_g262522 = Out_PositionOS15_g262525;
					float3 temp_output_228_35_g262522 = Out_ViewDirWS15_g262525;
					half3 Model_ViewDirWS237_g262522 = temp_output_228_35_g262522;
					float4x4 break117_g262523 = unity_CameraToWorld;
					float3 appendResult118_g262523 = (float3(break117_g262523[ 0 ][ 2 ] , break117_g262523[ 1 ][ 2 ] , break117_g262523[ 2 ][ 2 ]));
					float3 lerpResult209_g262522 = lerp( Model_ViewDirWS237_g262522 , -appendResult118_g262523 , unity_OrthoParams.w);
					float3 break201_g262522 = cross( lerpResult209_g262522 , half3( 0, 1, 0 ) );
					float3 appendResult196_g262522 = (float3(-break201_g262522.z , 0.0 , break201_g262522.x));
					float4 temp_output_228_27_g262522 = Out_PhaseData15_g262525;
					half4 Model_PhaseData218_g262522 = temp_output_228_27_g262522;
					float2 break226_g262522 = ( (Model_PhaseData218_g262522).xy * _PerspectivePhaseValue );
					float3 appendResult224_g262522 = (float3(break226_g262522.x , 0.0 , break226_g262522.y));
					float dotResult189_g262522 = dot( Model_ViewDirWS237_g262522 , float3( 0, 1, 0 ) );
					float saferPower192_g262522 = abs( dotResult189_g262522 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g262526 = (Model_PositionOS147_g262522).z;
					#else
					float staticSwitch65_g262526 = (Model_PositionOS147_g262522).y;
					#endif
					float3 temp_output_206_0_g262522 = ( Model_PositionOS147_g262522 + ( ( mul( unity_WorldToObject, float4( appendResult196_g262522 , 0.0 ) ).xyz + appendResult224_g262522 ) * _PerspectiveIntensityValue * pow( saferPower192_g262522 , _PerspectiveAngleValue ) * saturate( staticSwitch65_g262526 ) ) );
					#ifdef TVE_PERSPECTIVE
					float3 staticSwitch211_g262522 = temp_output_206_0_g262522;
					#else
					float3 staticSwitch211_g262522 = Model_PositionOS147_g262522;
					#endif
					float3 Final_Position178_g262522 = staticSwitch211_g262522;
					float3 temp_output_4_0_g262524 = Final_Position178_g262522;
					float3 In_PositionOS16_g262524 = temp_output_4_0_g262524;
					float3 In_PositionWS16_g262524 = Out_PositionWS15_g262525;
					float3 In_PositionWO16_g262524 = Out_PositionWO15_g262525;
					float3 In_PositionRawOS16_g262524 = Out_PositionRawOS15_g262525;
					float3 In_PivotOS16_g262524 = Out_PivotOS15_g262525;
					float3 In_PivotWS16_g262524 = Out_PivotWS15_g262525;
					float3 In_PivotWO16_g262524 = Out_PivotWO15_g262525;
					float3 temp_output_21_0_g262524 = Out_NormalOS15_g262525;
					float3 In_NormalOS16_g262524 = temp_output_21_0_g262524;
					float3 In_NormalWS16_g262524 = Out_NormalWS15_g262525;
					float3 In_NormalRawOS16_g262524 = Out_NormalRawOS15_g262525;
					float4 temp_output_6_0_g262524 = Out_TangentOS15_g262525;
					float4 In_TangentOS16_g262524 = temp_output_6_0_g262524;
					float3 In_TangentWS16_g262524 = Out_TangentWS15_g262525;
					float3 In_BitangentWS16_g262524 = Out_BitangentWS15_g262525;
					float3 In_ViewDirWS16_g262524 = temp_output_228_35_g262522;
					float4 In_CoordsData16_g262524 = Out_CoordsData15_g262525;
					float4 In_VertexData16_g262524 = Out_VertexData15_g262525;
					float4 In_MasksData16_g262524 = Out_MasksData15_g262525;
					float4 In_PhaseData16_g262524 = temp_output_228_27_g262522;
					float4 In_TransformData16_g262524 = Out_TransformData15_g262525;
					float4 temp_output_228_33_g262522 = Out_RotationData15_g262525;
					float4 In_RotationData16_g262524 = temp_output_228_33_g262522;
					float4 In_InterpolatorA16_g262524 = Out_InterpolatorA15_g262525;
					BuildModelVertData( Data16_g262524 , In_Dummy16_g262524 , In_PositionOS16_g262524 , In_PositionWS16_g262524 , In_PositionWO16_g262524 , In_PositionRawOS16_g262524 , In_PivotOS16_g262524 , In_PivotWS16_g262524 , In_PivotWO16_g262524 , In_NormalOS16_g262524 , In_NormalWS16_g262524 , In_NormalRawOS16_g262524 , In_TangentOS16_g262524 , In_TangentWS16_g262524 , In_BitangentWS16_g262524 , In_ViewDirWS16_g262524 , In_CoordsData16_g262524 , In_VertexData16_g262524 , In_MasksData16_g262524 , In_PhaseData16_g262524 , In_TransformData16_g262524 , In_RotationData16_g262524 , In_InterpolatorA16_g262524 );
					TVEModelData Data15_g262528 =(TVEModelData)Data16_g262524;
					float Out_Dummy15_g262528 = 0.0;
					float3 Out_PositionOS15_g262528 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262528 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262528 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262528 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262528 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262528 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262528 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262528 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262528 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262528 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262528 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262528 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262528 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262528 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262528 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262528 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262528 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262528 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262528 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262528 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262528 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262528 , Out_Dummy15_g262528 , Out_PositionOS15_g262528 , Out_PositionWS15_g262528 , Out_PositionWO15_g262528 , Out_PositionRawOS15_g262528 , Out_PivotOS15_g262528 , Out_PivotWS15_g262528 , Out_PivotWO15_g262528 , Out_NormalOS15_g262528 , Out_NormalWS15_g262528 , Out_NormalRawOS15_g262528 , Out_TangentOS15_g262528 , Out_TangentWS15_g262528 , Out_BitangentWS15_g262528 , Out_ViewDirWS15_g262528 , Out_CoordsData15_g262528 , Out_VertexData15_g262528 , Out_MasksData15_g262528 , Out_PhaseData15_g262528 , Out_TransformData15_g262528 , Out_RotationData15_g262528 , Out_InterpolatorA15_g262528 );
					TVEModelData Data16_g262529 =(TVEModelData)Data15_g262528;
					half Dummy317_g262527 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g262529 = Dummy317_g262527;
					float In_Dummy16_g262529 = temp_output_14_0_g262529;
					float3 temp_output_4_0_g262529 = Out_PositionOS15_g262528;
					float3 In_PositionOS16_g262529 = temp_output_4_0_g262529;
					float3 In_PositionWS16_g262529 = Out_PositionWS15_g262528;
					float3 temp_output_314_17_g262527 = Out_PositionWO15_g262528;
					float3 In_PositionWO16_g262529 = temp_output_314_17_g262527;
					float3 In_PositionRawOS16_g262529 = Out_PositionRawOS15_g262528;
					float3 In_PivotOS16_g262529 = Out_PivotOS15_g262528;
					float3 In_PivotWS16_g262529 = Out_PivotWS15_g262528;
					float3 temp_output_314_19_g262527 = Out_PivotWO15_g262528;
					float3 In_PivotWO16_g262529 = temp_output_314_19_g262527;
					float3 temp_output_21_0_g262529 = Out_NormalOS15_g262528;
					float3 In_NormalOS16_g262529 = temp_output_21_0_g262529;
					float3 In_NormalWS16_g262529 = Out_NormalWS15_g262528;
					float3 In_NormalRawOS16_g262529 = Out_NormalRawOS15_g262528;
					float4 temp_output_6_0_g262529 = Out_TangentOS15_g262528;
					float4 In_TangentOS16_g262529 = temp_output_6_0_g262529;
					float3 In_TangentWS16_g262529 = Out_TangentWS15_g262528;
					float3 In_BitangentWS16_g262529 = Out_BitangentWS15_g262528;
					float3 In_ViewDirWS16_g262529 = Out_ViewDirWS15_g262528;
					float4 In_CoordsData16_g262529 = Out_CoordsData15_g262528;
					float4 temp_output_314_29_g262527 = Out_VertexData15_g262528;
					float4 In_VertexData16_g262529 = temp_output_314_29_g262527;
					float4 In_MasksData16_g262529 = Out_MasksData15_g262528;
					float4 In_PhaseData16_g262529 = Out_PhaseData15_g262528;
					half4 Model_TransformData356_g262527 = Out_TransformData15_g262528;
					float localBuildGlobalData204_g262441 = ( 0.0 );
					TVEGlobalData Data204_g262441 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g262441 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g262441 = Dummy211_g262441;
					float4 temp_output_589_164_g262441 = TVE_CoatParams;
					half4 Coat_Params596_g262441 = temp_output_589_164_g262441;
					float4 In_CoatParams204_g262441 = Coat_Params596_g262441;
					float4 temp_output_203_0_g262461 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g262420 = ( 0.0 );
					TVEModelData Data26_g262420 = (TVEModelData)0;
					TVEModelData DataDefault26_g262420 = Data16_g241828;
					TVEModelData Data16_g262429 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g262429 = 0.0;
					float3 In_PositionWS16_g262429 = PositionWS122_g262421;
					float3 In_PositionWO16_g262429 = PositionWO132_g262421;
					float3 In_PivotWS16_g262429 = PivotWS121_g262421;
					float3 In_PivotWO16_g262429 = PivotWO133_g262421;
					float3 In_NormalWS16_g262429 = NormalWS95_g262421;
					float3 In_TangentWS16_g262429 = TangentWS136_g262421;
					float3 In_BitangentWS16_g262429 = BiangentWS421_g262421;
					half3 NormalWS427_g262421 = NormalWS95_g262421;
					half3 localComputeTriplanarWeights427_g262421 = ComputeTriplanarWeights( NormalWS427_g262421 );
					half3 TriplanarWeights429_g262421 = localComputeTriplanarWeights427_g262421;
					float3 In_TriplanarWeights16_g262429 = TriplanarWeights429_g262421;
					float3 In_ViewDirWS16_g262429 = ViewDirWS169_g262421;
					float4 In_CoordsData16_g262429 = CoordsData398_g262421;
					float4 In_VertexData16_g262429 = VertexMasks171_g262421;
					float4 In_PhaseData16_g262429 = Phase_Data176_g262421;
					BuildModelFragData( Data16_g262429 , In_Dummy16_g262429 , In_PositionWS16_g262429 , In_PositionWO16_g262429 , In_PivotWS16_g262429 , In_PivotWO16_g262429 , In_NormalWS16_g262429 , In_TangentWS16_g262429 , In_BitangentWS16_g262429 , In_TriplanarWeights16_g262429 , In_ViewDirWS16_g262429 , In_CoordsData16_g262429 , In_VertexData16_g262429 , In_PhaseData16_g262429 );
					TVEModelData DataGeneral26_g262420 = Data16_g262429;
					TVEModelData DataBlanket26_g262420 = Data16_g262429;
					TVEModelData DataImpostor26_g262420 = Data16_g262429;
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
					TVEModelData DataTerrain26_g262420 = Data16_g241826;
					float Type26_g262420 = IsShaderType2637;
					{
					if (Type26_g262420 == 0 )
					{
					Data26_g262420 = DataDefault26_g262420;
					}
					else if (Type26_g262420 == 1 )
					{
					Data26_g262420 = DataGeneral26_g262420;
					}
					else if (Type26_g262420 == 2 )
					{
					Data26_g262420 = DataBlanket26_g262420;
					}
					else if (Type26_g262420 == 3 )
					{
					Data26_g262420 = DataImpostor26_g262420;
					}
					else if (Type26_g262420 == 4 )
					{
					Data26_g262420 = DataTerrain26_g262420;
					}
					}
					TVEModelData Data15_g262517 =(TVEModelData)Data26_g262420;
					float Out_Dummy15_g262517 = 0.0;
					float3 Out_PositionWS15_g262517 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262517 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262517 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262517 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262517 = float3( 0,0,0 );
					float3 Out_TangentWS15_g262517 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262517 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g262517 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262517 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262517 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262517 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262517 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g262517 , Out_Dummy15_g262517 , Out_PositionWS15_g262517 , Out_PositionWO15_g262517 , Out_PivotWS15_g262517 , Out_PivotWO15_g262517 , Out_NormalWS15_g262517 , Out_TangentWS15_g262517 , Out_BitangentWS15_g262517 , Out_TriplanarWeights15_g262517 , Out_ViewDirWS15_g262517 , Out_CoordsData15_g262517 , Out_VertexData15_g262517 , Out_PhaseData15_g262517 );
					float3 Model_PositionWS497_g262441 = Out_PositionWS15_g262517;
					float2 Model_PositionWS_XZ143_g262441 = (Model_PositionWS497_g262441).xz;
					float3 Model_PivotWS498_g262441 = Out_PivotWS15_g262517;
					float2 Model_PivotWS_XZ145_g262441 = (Model_PivotWS498_g262441).xz;
					float2 lerpResult300_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g262461 = lerpResult300_g262441;
					float temp_output_82_0_g262459 = _GlobalCoatLayerValue;
					float temp_output_82_0_g262461 = temp_output_82_0_g262459;
					float4 tex2DArrayNode83_g262461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262461).zw + ( (temp_output_203_0_g262461).xy * temp_output_81_0_g262461 ) ),temp_output_82_0_g262461), 0.0 );
					float4 appendResult210_g262461 = (float4(tex2DArrayNode83_g262461.rgb , saturate( tex2DArrayNode83_g262461.a )));
					float4 temp_output_204_0_g262461 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g262461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262461).zw + ( (temp_output_204_0_g262461).xy * temp_output_81_0_g262461 ) ),temp_output_82_0_g262461), 0.0 );
					float4 appendResult212_g262461 = (float4(tex2DArrayNode122_g262461.rgb , saturate( tex2DArrayNode122_g262461.a )));
					float4 TVE_RenderNearPositionR628_g262441 = TVE_RenderNearPositionR;
					float temp_output_507_0_g262441 = saturate( ( distance( Model_PositionWS497_g262441 , (TVE_RenderNearPositionR628_g262441).xyz ) / (TVE_RenderNearPositionR628_g262441).w ) );
					float temp_output_7_0_g262442 = 1.0;
					float temp_output_9_0_g262442 = ( temp_output_507_0_g262441 - temp_output_7_0_g262442 );
					half TVE_RenderNearFadeValue635_g262441 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g262441 = saturate( ( temp_output_9_0_g262442 / ( ( TVE_RenderNearFadeValue635_g262441 - temp_output_7_0_g262442 ) + 0.0001 ) ) );
					float4 lerpResult131_g262461 = lerp( appendResult210_g262461 , appendResult212_g262461 , Global_TexBlend509_g262441);
					float4 temp_output_159_109_g262459 = lerpResult131_g262461;
					float4 lerpResult168_g262459 = lerp( TVE_CoatParams , temp_output_159_109_g262459 , TVE_CoatLayers[(int)temp_output_82_0_g262459]);
					float4 temp_output_589_109_g262441 = lerpResult168_g262459;
					half4 Coat_Texture302_g262441 = temp_output_589_109_g262441;
					float4 In_CoatTexture204_g262441 = Coat_Texture302_g262441;
					float4 temp_output_595_164_g262441 = TVE_PaintParams;
					half4 Paint_Params575_g262441 = temp_output_595_164_g262441;
					float4 In_PaintParams204_g262441 = Paint_Params575_g262441;
					float4 temp_output_203_0_g262510 = TVE_PaintBaseCoord;
					float2 lerpResult85_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g262510 = lerpResult85_g262441;
					float temp_output_82_0_g262507 = _GlobalPaintLayerValue;
					float temp_output_82_0_g262510 = temp_output_82_0_g262507;
					float4 tex2DArrayNode83_g262510 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262510).zw + ( (temp_output_203_0_g262510).xy * temp_output_81_0_g262510 ) ),temp_output_82_0_g262510), 0.0 );
					float4 appendResult210_g262510 = (float4(tex2DArrayNode83_g262510.rgb , saturate( tex2DArrayNode83_g262510.a )));
					float4 temp_output_204_0_g262510 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g262510 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262510).zw + ( (temp_output_204_0_g262510).xy * temp_output_81_0_g262510 ) ),temp_output_82_0_g262510), 0.0 );
					float4 appendResult212_g262510 = (float4(tex2DArrayNode122_g262510.rgb , saturate( tex2DArrayNode122_g262510.a )));
					float4 lerpResult131_g262510 = lerp( appendResult210_g262510 , appendResult212_g262510 , Global_TexBlend509_g262441);
					float4 temp_output_171_109_g262507 = lerpResult131_g262510;
					float4 lerpResult174_g262507 = lerp( TVE_PaintParams , temp_output_171_109_g262507 , TVE_PaintLayers[(int)temp_output_82_0_g262507]);
					float4 temp_output_595_109_g262441 = lerpResult174_g262507;
					half4 Paint_Texture71_g262441 = temp_output_595_109_g262441;
					float4 In_PaintTexture204_g262441 = Paint_Texture71_g262441;
					float4 temp_output_590_141_g262441 = TVE_AtmoParams;
					half4 Atmo_Params601_g262441 = temp_output_590_141_g262441;
					float4 In_AtmoParams204_g262441 = Atmo_Params601_g262441;
					float4 temp_output_203_0_g262469 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g262469 = lerpResult104_g262441;
					float temp_output_132_0_g262467 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g262469 = temp_output_132_0_g262467;
					float4 tex2DArrayNode83_g262469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262469).zw + ( (temp_output_203_0_g262469).xy * temp_output_81_0_g262469 ) ),temp_output_82_0_g262469), 0.0 );
					float4 appendResult210_g262469 = (float4(tex2DArrayNode83_g262469.rgb , saturate( tex2DArrayNode83_g262469.a )));
					float4 temp_output_204_0_g262469 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g262469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262469).zw + ( (temp_output_204_0_g262469).xy * temp_output_81_0_g262469 ) ),temp_output_82_0_g262469), 0.0 );
					float4 appendResult212_g262469 = (float4(tex2DArrayNode122_g262469.rgb , saturate( tex2DArrayNode122_g262469.a )));
					float4 lerpResult131_g262469 = lerp( appendResult210_g262469 , appendResult212_g262469 , Global_TexBlend509_g262441);
					float4 temp_output_137_109_g262467 = lerpResult131_g262469;
					float4 lerpResult145_g262467 = lerp( TVE_AtmoParams , temp_output_137_109_g262467 , TVE_AtmoLayers[(int)temp_output_132_0_g262467]);
					float4 temp_output_590_110_g262441 = lerpResult145_g262467;
					half4 Atmo_Texture80_g262441 = temp_output_590_110_g262441;
					float4 In_AtmoTexture204_g262441 = Atmo_Texture80_g262441;
					float4 temp_output_593_163_g262441 = TVE_GlowParams;
					half4 Glow_Params609_g262441 = temp_output_593_163_g262441;
					float4 In_GlowParams204_g262441 = Glow_Params609_g262441;
					float4 temp_output_203_0_g262485 = TVE_GlowBaseCoord;
					float2 lerpResult247_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g262485 = lerpResult247_g262441;
					float temp_output_82_0_g262483 = _GlobalGlowLayerValue;
					float temp_output_82_0_g262485 = temp_output_82_0_g262483;
					float4 tex2DArrayNode83_g262485 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262485).zw + ( (temp_output_203_0_g262485).xy * temp_output_81_0_g262485 ) ),temp_output_82_0_g262485), 0.0 );
					float4 appendResult210_g262485 = (float4(tex2DArrayNode83_g262485.rgb , saturate( tex2DArrayNode83_g262485.a )));
					float4 temp_output_204_0_g262485 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g262485 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262485).zw + ( (temp_output_204_0_g262485).xy * temp_output_81_0_g262485 ) ),temp_output_82_0_g262485), 0.0 );
					float4 appendResult212_g262485 = (float4(tex2DArrayNode122_g262485.rgb , saturate( tex2DArrayNode122_g262485.a )));
					float4 lerpResult131_g262485 = lerp( appendResult210_g262485 , appendResult212_g262485 , Global_TexBlend509_g262441);
					float4 temp_output_159_109_g262483 = lerpResult131_g262485;
					float4 lerpResult167_g262483 = lerp( TVE_GlowParams , temp_output_159_109_g262483 , TVE_GlowLayers[(int)temp_output_82_0_g262483]);
					float4 temp_output_593_109_g262441 = lerpResult167_g262483;
					half4 Glow_Texture248_g262441 = temp_output_593_109_g262441;
					float4 In_GlowTexture204_g262441 = Glow_Texture248_g262441;
					float4 temp_output_592_139_g262441 = TVE_FormParams;
					float4 Form_Params606_g262441 = temp_output_592_139_g262441;
					float4 In_FormParams204_g262441 = Form_Params606_g262441;
					float4 temp_output_203_0_g262501 = TVE_FormBaseCoord;
					float2 lerpResult168_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g262501 = lerpResult168_g262441;
					float temp_output_130_0_g262499 = _GlobalFormLayerValue;
					float temp_output_82_0_g262501 = temp_output_130_0_g262499;
					float4 tex2DArrayNode83_g262501 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262501).zw + ( (temp_output_203_0_g262501).xy * temp_output_81_0_g262501 ) ),temp_output_82_0_g262501), 0.0 );
					float4 appendResult210_g262501 = (float4(tex2DArrayNode83_g262501.rgb , saturate( tex2DArrayNode83_g262501.a )));
					float4 temp_output_204_0_g262501 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g262501 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262501).zw + ( (temp_output_204_0_g262501).xy * temp_output_81_0_g262501 ) ),temp_output_82_0_g262501), 0.0 );
					float4 appendResult212_g262501 = (float4(tex2DArrayNode122_g262501.rgb , saturate( tex2DArrayNode122_g262501.a )));
					float4 lerpResult131_g262501 = lerp( appendResult210_g262501 , appendResult212_g262501 , Global_TexBlend509_g262441);
					float4 temp_output_135_109_g262499 = lerpResult131_g262501;
					float4 lerpResult143_g262499 = lerp( TVE_FormParams , temp_output_135_109_g262499 , TVE_FormLayers[(int)temp_output_130_0_g262499]);
					float4 temp_output_592_0_g262441 = lerpResult143_g262499;
					float4 Form_Texture112_g262441 = temp_output_592_0_g262441;
					float4 In_FormTexture204_g262441 = Form_Texture112_g262441;
					float4 temp_output_594_145_g262441 = TVE_FlowParams;
					half4 Flow_Params612_g262441 = temp_output_594_145_g262441;
					float4 In_FlowParams204_g262441 = Flow_Params612_g262441;
					float4 temp_output_203_0_g262493 = TVE_FlowBaseCoord;
					float2 lerpResult400_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g262493 = lerpResult400_g262441;
					float temp_output_136_0_g262491 = _GlobalFlowLayerValue;
					float temp_output_82_0_g262493 = temp_output_136_0_g262491;
					float4 tex2DArrayNode83_g262493 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262493).zw + ( (temp_output_203_0_g262493).xy * temp_output_81_0_g262493 ) ),temp_output_82_0_g262493), 0.0 );
					float4 appendResult210_g262493 = (float4(tex2DArrayNode83_g262493.rgb , saturate( tex2DArrayNode83_g262493.a )));
					float4 temp_output_204_0_g262493 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g262493 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262493).zw + ( (temp_output_204_0_g262493).xy * temp_output_81_0_g262493 ) ),temp_output_82_0_g262493), 0.0 );
					float4 appendResult212_g262493 = (float4(tex2DArrayNode122_g262493.rgb , saturate( tex2DArrayNode122_g262493.a )));
					float4 lerpResult131_g262493 = lerp( appendResult210_g262493 , appendResult212_g262493 , Global_TexBlend509_g262441);
					float4 temp_output_141_109_g262491 = lerpResult131_g262493;
					float4 lerpResult149_g262491 = lerp( TVE_FlowParams , temp_output_141_109_g262491 , TVE_FlowLayers[(int)temp_output_136_0_g262491]);
					half4 Flow_Texture405_g262441 = lerpResult149_g262491;
					float4 In_FlowTexture204_g262441 = Flow_Texture405_g262441;
					BuildGlobalData( Data204_g262441 , In_Dummy204_g262441 , In_CoatParams204_g262441 , In_CoatTexture204_g262441 , In_PaintParams204_g262441 , In_PaintTexture204_g262441 , In_AtmoParams204_g262441 , In_AtmoTexture204_g262441 , In_GlowParams204_g262441 , In_GlowTexture204_g262441 , In_FormParams204_g262441 , In_FormTexture204_g262441 , In_FlowParams204_g262441 , In_FlowTexture204_g262441 );
					TVEGlobalData Data15_g262530 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262530 = 0.0;
					float4 Out_CoatParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262530 = float4( 0,0,0,0 );
					BreakData( Data15_g262530 , Out_Dummy15_g262530 , Out_CoatParams15_g262530 , Out_CoatTexture15_g262530 , Out_PaintParams15_g262530 , Out_PaintTexture15_g262530 , Out_AtmoParams15_g262530 , Out_AtmoTexture15_g262530 , Out_GlowParams15_g262530 , Out_GlowTexture15_g262530 , Out_FormParams15_g262530 , Out_FormTexture15_g262530 , Out_FlowParams15_g262530 , Out_FlowTexture15_g262530 );
					float4 Global_FormTexture351_g262527 = Out_FormTexture15_g262530;
					float3 Model_PivotWO353_g262527 = temp_output_314_19_g262527;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g262536 = _ConformMeshMode;
					float Option70_g262536 = temp_output_17_0_g262536;
					half4 Model_VertexData357_g262527 = temp_output_314_29_g262527;
					float4 temp_output_3_0_g262536 = Model_VertexData357_g262527;
					float4 Channel70_g262536 = temp_output_3_0_g262536;
					float localSwitchChannel470_g262536 = SwitchChannel4( Option70_g262536 , Channel70_g262536 );
					float temp_output_390_0_g262527 = localSwitchChannel470_g262536;
					float temp_output_7_0_g262533 = _ConformMeshRemap.x;
					float temp_output_9_0_g262533 = ( temp_output_390_0_g262527 - temp_output_7_0_g262533 );
					float lerpResult374_g262527 = lerp( 1.0 , saturate( ( temp_output_9_0_g262533 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g262527 = lerpResult374_g262527;
					float temp_output_328_0_g262527 = ( Blend_VertMask379_g262527 * TVE_IsEnabled );
					half Conform_Mask366_g262527 = temp_output_328_0_g262527;
					float temp_output_322_0_g262527 = ( ( ( ( (Global_FormTexture351_g262527).z - ( (Model_PivotWO353_g262527).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g262527 ) );
					float3 appendResult329_g262527 = (float3(0.0 , temp_output_322_0_g262527 , 0.0));
					float3 appendResult387_g262527 = (float3(0.0 , 0.0 , temp_output_322_0_g262527));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262534 = appendResult387_g262527;
					#else
					float3 staticSwitch65_g262534 = appendResult329_g262527;
					#endif
					float3 Blanket_Conform368_g262527 = staticSwitch65_g262534;
					float4 appendResult312_g262527 = (float4(Blanket_Conform368_g262527 , 0.0));
					float4 temp_output_310_0_g262527 = ( Model_TransformData356_g262527 + appendResult312_g262527 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g262527 = temp_output_310_0_g262527;
					#else
					float4 staticSwitch364_g262527 = Model_TransformData356_g262527;
					#endif
					half4 Final_TransformData365_g262527 = staticSwitch364_g262527;
					float4 In_TransformData16_g262529 = Final_TransformData365_g262527;
					float4 In_RotationData16_g262529 = Out_RotationData15_g262528;
					float4 In_InterpolatorA16_g262529 = Out_InterpolatorA15_g262528;
					BuildModelVertData( Data16_g262529 , In_Dummy16_g262529 , In_PositionOS16_g262529 , In_PositionWS16_g262529 , In_PositionWO16_g262529 , In_PositionRawOS16_g262529 , In_PivotOS16_g262529 , In_PivotWS16_g262529 , In_PivotWO16_g262529 , In_NormalOS16_g262529 , In_NormalWS16_g262529 , In_NormalRawOS16_g262529 , In_TangentOS16_g262529 , In_TangentWS16_g262529 , In_BitangentWS16_g262529 , In_ViewDirWS16_g262529 , In_CoordsData16_g262529 , In_VertexData16_g262529 , In_MasksData16_g262529 , In_PhaseData16_g262529 , In_TransformData16_g262529 , In_RotationData16_g262529 , In_InterpolatorA16_g262529 );
					TVEModelData Data15_g262542 =(TVEModelData)Data16_g262529;
					float Out_Dummy15_g262542 = 0.0;
					float3 Out_PositionOS15_g262542 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262542 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262542 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262542 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262542 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262542 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262542 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262542 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262542 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262542 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262542 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262542 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262542 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262542 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262542 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262542 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262542 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262542 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262542 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262542 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262542 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262542 , Out_Dummy15_g262542 , Out_PositionOS15_g262542 , Out_PositionWS15_g262542 , Out_PositionWO15_g262542 , Out_PositionRawOS15_g262542 , Out_PivotOS15_g262542 , Out_PivotWS15_g262542 , Out_PivotWO15_g262542 , Out_NormalOS15_g262542 , Out_NormalWS15_g262542 , Out_NormalRawOS15_g262542 , Out_TangentOS15_g262542 , Out_TangentWS15_g262542 , Out_BitangentWS15_g262542 , Out_ViewDirWS15_g262542 , Out_CoordsData15_g262542 , Out_VertexData15_g262542 , Out_MasksData15_g262542 , Out_PhaseData15_g262542 , Out_TransformData15_g262542 , Out_RotationData15_g262542 , Out_InterpolatorA15_g262542 );
					TVEModelData Data16_g262543 =(TVEModelData)Data15_g262542;
					half Dummy181_g262537 = ( _RotationCategory + _RotationEnd + _RotationInfo );
					float temp_output_14_0_g262543 = Dummy181_g262537;
					float In_Dummy16_g262543 = temp_output_14_0_g262543;
					float3 temp_output_4_0_g262543 = Out_PositionOS15_g262542;
					float3 In_PositionOS16_g262543 = temp_output_4_0_g262543;
					float3 In_PositionWS16_g262543 = Out_PositionWS15_g262542;
					float3 In_PositionWO16_g262543 = Out_PositionWO15_g262542;
					float3 In_PositionRawOS16_g262543 = Out_PositionRawOS15_g262542;
					float3 In_PivotOS16_g262543 = Out_PivotOS15_g262542;
					float3 In_PivotWS16_g262543 = Out_PivotWS15_g262542;
					float3 In_PivotWO16_g262543 = Out_PivotWO15_g262542;
					float3 temp_output_21_0_g262543 = Out_NormalOS15_g262542;
					float3 In_NormalOS16_g262543 = temp_output_21_0_g262543;
					float3 In_NormalWS16_g262543 = Out_NormalWS15_g262542;
					float3 In_NormalRawOS16_g262543 = Out_NormalRawOS15_g262542;
					float4 temp_output_6_0_g262543 = Out_TangentOS15_g262542;
					float4 In_TangentOS16_g262543 = temp_output_6_0_g262543;
					float3 In_TangentWS16_g262543 = Out_TangentWS15_g262542;
					float3 In_BitangentWS16_g262543 = Out_BitangentWS15_g262542;
					float3 In_ViewDirWS16_g262543 = Out_ViewDirWS15_g262542;
					float4 In_CoordsData16_g262543 = Out_CoordsData15_g262542;
					float4 In_VertexData16_g262543 = Out_VertexData15_g262542;
					float4 In_MasksData16_g262543 = Out_MasksData15_g262542;
					float4 In_PhaseData16_g262543 = Out_PhaseData15_g262542;
					float4 In_TransformData16_g262543 = Out_TransformData15_g262542;
					half4 Model_RotationData212_g262537 = Out_RotationData15_g262542;
					TVEGlobalData Data15_g262538 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262538 = 0.0;
					float4 Out_CoatParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262538 = float4( 0,0,0,0 );
					BreakData( Data15_g262538 , Out_Dummy15_g262538 , Out_CoatParams15_g262538 , Out_CoatTexture15_g262538 , Out_PaintParams15_g262538 , Out_PaintTexture15_g262538 , Out_AtmoParams15_g262538 , Out_AtmoTexture15_g262538 , Out_GlowParams15_g262538 , Out_GlowTexture15_g262538 , Out_FormParams15_g262538 , Out_FormTexture15_g262538 , Out_FlowParams15_g262538 , Out_FlowTexture15_g262538 );
					half4 Global_FormTexture188_g262537 = Out_FormTexture15_g262538;
					float2 temp_output_38_0_g262539 = ((Global_FormTexture188_g262537).xy*2.0 + -1.0);
					float2 break83_g262539 = temp_output_38_0_g262539;
					float3 appendResult79_g262539 = (float3(break83_g262539.x , 0.0 , break83_g262539.y));
					float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
					float2 lerpResult227_g262537 = lerp( float2( 0,0 ) , (( mul( unity_WorldToObject, float4( appendResult79_g262539 , 0.0 ) ).xyz * ase_parentObjectScale )).xz , ( _RotationIntensityValue * TVE_IsEnabled ));
					half2 Blanket_Orientation192_g262537 = lerpResult227_g262537;
					float4 appendResult222_g262537 = (float4(( (Model_RotationData212_g262537).xy + Blanket_Orientation192_g262537 ) , (Model_RotationData212_g262537).zw));
					#ifdef TVE_ROTATION
					float4 staticSwitch218_g262537 = appendResult222_g262537;
					#else
					float4 staticSwitch218_g262537 = Model_RotationData212_g262537;
					#endif
					half4 Final_RotationData225_g262537 = staticSwitch218_g262537;
					float4 In_RotationData16_g262543 = Final_RotationData225_g262537;
					float4 In_InterpolatorA16_g262543 = Out_InterpolatorA15_g262542;
					BuildModelVertData( Data16_g262543 , In_Dummy16_g262543 , In_PositionOS16_g262543 , In_PositionWS16_g262543 , In_PositionWO16_g262543 , In_PositionRawOS16_g262543 , In_PivotOS16_g262543 , In_PivotWS16_g262543 , In_PivotWO16_g262543 , In_NormalOS16_g262543 , In_NormalWS16_g262543 , In_NormalRawOS16_g262543 , In_TangentOS16_g262543 , In_TangentWS16_g262543 , In_BitangentWS16_g262543 , In_ViewDirWS16_g262543 , In_CoordsData16_g262543 , In_VertexData16_g262543 , In_MasksData16_g262543 , In_PhaseData16_g262543 , In_TransformData16_g262543 , In_RotationData16_g262543 , In_InterpolatorA16_g262543 );
					TVEModelData Data15_g262545 =(TVEModelData)Data16_g262543;
					float Out_Dummy15_g262545 = 0.0;
					float3 Out_PositionOS15_g262545 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262545 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262545 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262545 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262545 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262545 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262545 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262545 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262545 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262545 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262545 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262545 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262545 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262545 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262545 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262545 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262545 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262545 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262545 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262545 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262545 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262545 , Out_Dummy15_g262545 , Out_PositionOS15_g262545 , Out_PositionWS15_g262545 , Out_PositionWO15_g262545 , Out_PositionRawOS15_g262545 , Out_PivotOS15_g262545 , Out_PivotWS15_g262545 , Out_PivotWO15_g262545 , Out_NormalOS15_g262545 , Out_NormalWS15_g262545 , Out_NormalRawOS15_g262545 , Out_TangentOS15_g262545 , Out_TangentWS15_g262545 , Out_BitangentWS15_g262545 , Out_ViewDirWS15_g262545 , Out_CoordsData15_g262545 , Out_VertexData15_g262545 , Out_MasksData15_g262545 , Out_PhaseData15_g262545 , Out_TransformData15_g262545 , Out_RotationData15_g262545 , Out_InterpolatorA15_g262545 );
					TVEModelData Data16_g262546 =(TVEModelData)Data15_g262545;
					half Dummy181_g262544 = ( _SizeFadeCategory + _SizeFadeEnd );
					float temp_output_14_0_g262546 = Dummy181_g262544;
					float In_Dummy16_g262546 = temp_output_14_0_g262546;
					float3 Model_PositionOS147_g262544 = Out_PositionOS15_g262545;
					float3 temp_cast_15 = (1.0).xxx;
					float3 temp_output_210_18_g262544 = Out_PivotWS15_g262545;
					float3 Model_PivotWS162_g262544 = temp_output_210_18_g262544;
					float lerpResult216_g262544 = lerp( 1.0 , TVE_SizeFadeParams.z , TVE_SizeFadeParams.w);
					float temp_output_7_0_g262548 = _SizeFadeDistMaxValue;
					float temp_output_9_0_g262548 = ( ( distance( _WorldSpaceCameraPos , Model_PivotWS162_g262544 ) * lerpResult216_g262544 ) - temp_output_7_0_g262548 );
					TVEGlobalData Data15_g262553 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262553 = 0.0;
					float4 Out_CoatParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262553 = float4( 0,0,0,0 );
					BreakData( Data15_g262553 , Out_Dummy15_g262553 , Out_CoatParams15_g262553 , Out_CoatTexture15_g262553 , Out_PaintParams15_g262553 , Out_PaintTexture15_g262553 , Out_AtmoParams15_g262553 , Out_AtmoTexture15_g262553 , Out_GlowParams15_g262553 , Out_GlowTexture15_g262553 , Out_FormParams15_g262553 , Out_FormTexture15_g262553 , Out_FlowParams15_g262553 , Out_FlowTexture15_g262553 );
					half4 Global_FormParams243_g262544 = Out_FormParams15_g262553;
					float temp_output_245_0_g262544 = (Global_FormParams243_g262544).w;
					half4 Global_FormTexture188_g262544 = Out_FormTexture15_g262553;
					float temp_output_6_0_g262552 = (Global_FormTexture188_g262544).w;
					float temp_output_7_0_g262552 = _SizeFadeElementMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g262552 = ( temp_output_6_0_g262552 + temp_output_7_0_g262552 );
					#else
					float staticSwitch14_g262552 = temp_output_6_0_g262552;
					#endif
					float temp_output_223_0_g262544 = staticSwitch14_g262552;
					#ifdef TVE_SIZEFADE_ELEMENT
					float staticSwitch194_g262544 = temp_output_223_0_g262544;
					#else
					float staticSwitch194_g262544 = temp_output_245_0_g262544;
					#endif
					float lerpResult213_g262544 = lerp( 1.0 , staticSwitch194_g262544 , ( _SizeFadeGlobalValue * TVE_IsEnabled ));
					half Blend_GlobalMask192_g262544 = lerpResult213_g262544;
					half Blend_UserMask232_g262544 = 1.0;
					float temp_output_236_0_g262544 = ( Blend_GlobalMask192_g262544 * Blend_UserMask232_g262544 );
					half Blend_Mask240_g262544 = temp_output_236_0_g262544;
					float temp_output_189_0_g262544 = ( saturate( ( temp_output_9_0_g262548 / ( ( _SizeFadeDistMinValue - temp_output_7_0_g262548 ) + 0.0001 ) ) ) * _SizeFadeScaleValue * Blend_Mask240_g262544 );
					float3 appendResult200_g262544 = (float3(temp_output_189_0_g262544 , temp_output_189_0_g262544 , temp_output_189_0_g262544));
					float3 appendResult201_g262544 = (float3(1.0 , temp_output_189_0_g262544 , 1.0));
					float3 appendResult230_g262544 = (float3(1.0 , 1.0 , temp_output_189_0_g262544));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262549 = appendResult230_g262544;
					#else
					float3 staticSwitch65_g262549 = appendResult201_g262544;
					#endif
					float3 lerpResult202_g262544 = lerp( appendResult200_g262544 , staticSwitch65_g262549 , _SizeFadeScaleMode);
					float3 lerpResult184_g262544 = lerp( temp_cast_15 , lerpResult202_g262544 , _SizeFadeIntensityValue);
					float3 temp_output_167_0_g262544 = ( lerpResult184_g262544 * Model_PositionOS147_g262544 );
					#ifdef TVE_SIZEFADE
					float3 staticSwitch199_g262544 = temp_output_167_0_g262544;
					#else
					float3 staticSwitch199_g262544 = Model_PositionOS147_g262544;
					#endif
					float3 Final_Position178_g262544 = staticSwitch199_g262544;
					float3 temp_output_4_0_g262546 = Final_Position178_g262544;
					float3 In_PositionOS16_g262546 = temp_output_4_0_g262546;
					float3 In_PositionWS16_g262546 = Out_PositionWS15_g262545;
					float3 In_PositionWO16_g262546 = Out_PositionWO15_g262545;
					float3 In_PositionRawOS16_g262546 = Out_PositionRawOS15_g262545;
					float3 temp_output_210_24_g262544 = Out_PivotOS15_g262545;
					float3 In_PivotOS16_g262546 = temp_output_210_24_g262544;
					float3 In_PivotWS16_g262546 = temp_output_210_18_g262544;
					float3 In_PivotWO16_g262546 = Out_PivotWO15_g262545;
					float3 temp_output_21_0_g262546 = Out_NormalOS15_g262545;
					float3 In_NormalOS16_g262546 = temp_output_21_0_g262546;
					float3 In_NormalWS16_g262546 = Out_NormalWS15_g262545;
					float3 In_NormalRawOS16_g262546 = Out_NormalRawOS15_g262545;
					float4 temp_output_6_0_g262546 = Out_TangentOS15_g262545;
					float4 In_TangentOS16_g262546 = temp_output_6_0_g262546;
					float3 In_TangentWS16_g262546 = Out_TangentWS15_g262545;
					float3 In_BitangentWS16_g262546 = Out_BitangentWS15_g262545;
					float3 In_ViewDirWS16_g262546 = Out_ViewDirWS15_g262545;
					float4 In_CoordsData16_g262546 = Out_CoordsData15_g262545;
					float4 In_VertexData16_g262546 = Out_VertexData15_g262545;
					float4 In_MasksData16_g262546 = Out_MasksData15_g262545;
					float4 In_PhaseData16_g262546 = Out_PhaseData15_g262545;
					float4 In_TransformData16_g262546 = Out_TransformData15_g262545;
					float4 In_RotationData16_g262546 = Out_RotationData15_g262545;
					float4 In_InterpolatorA16_g262546 = Out_InterpolatorA15_g262545;
					BuildModelVertData( Data16_g262546 , In_Dummy16_g262546 , In_PositionOS16_g262546 , In_PositionWS16_g262546 , In_PositionWO16_g262546 , In_PositionRawOS16_g262546 , In_PivotOS16_g262546 , In_PivotWS16_g262546 , In_PivotWO16_g262546 , In_NormalOS16_g262546 , In_NormalWS16_g262546 , In_NormalRawOS16_g262546 , In_TangentOS16_g262546 , In_TangentWS16_g262546 , In_BitangentWS16_g262546 , In_ViewDirWS16_g262546 , In_CoordsData16_g262546 , In_VertexData16_g262546 , In_MasksData16_g262546 , In_PhaseData16_g262546 , In_TransformData16_g262546 , In_RotationData16_g262546 , In_InterpolatorA16_g262546 );
					TVEModelData Data15_g262556 =(TVEModelData)Data16_g262546;
					float Out_Dummy15_g262556 = 0.0;
					float3 Out_PositionOS15_g262556 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262556 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262556 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262556 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262556 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262556 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262556 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262556 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262556 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262556 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262556 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262556 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262556 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262556 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262556 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262556 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262556 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262556 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262556 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262556 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262556 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262556 , Out_Dummy15_g262556 , Out_PositionOS15_g262556 , Out_PositionWS15_g262556 , Out_PositionWO15_g262556 , Out_PositionRawOS15_g262556 , Out_PivotOS15_g262556 , Out_PivotWS15_g262556 , Out_PivotWO15_g262556 , Out_NormalOS15_g262556 , Out_NormalWS15_g262556 , Out_NormalRawOS15_g262556 , Out_TangentOS15_g262556 , Out_TangentWS15_g262556 , Out_BitangentWS15_g262556 , Out_ViewDirWS15_g262556 , Out_CoordsData15_g262556 , Out_VertexData15_g262556 , Out_MasksData15_g262556 , Out_PhaseData15_g262556 , Out_TransformData15_g262556 , Out_RotationData15_g262556 , Out_InterpolatorA15_g262556 );
					TVEModelData Data16_g262555 =(TVEModelData)Data15_g262556;
					half Dummy181_g262554 = ( ( _MotionCategory + _MotionEnd ) + _MotionPushInfo );
					float temp_output_14_0_g262555 = Dummy181_g262554;
					float In_Dummy16_g262555 = temp_output_14_0_g262555;
					float3 temp_output_2772_0_g262554 = Out_PositionOS15_g262556;
					float3 temp_output_4_0_g262555 = temp_output_2772_0_g262554;
					float3 In_PositionOS16_g262555 = temp_output_4_0_g262555;
					float3 temp_output_2772_16_g262554 = Out_PositionWS15_g262556;
					float3 In_PositionWS16_g262555 = temp_output_2772_16_g262554;
					float3 temp_output_2772_17_g262554 = Out_PositionWO15_g262556;
					float3 In_PositionWO16_g262555 = temp_output_2772_17_g262554;
					float3 In_PositionRawOS16_g262555 = Out_PositionRawOS15_g262556;
					float3 temp_output_2772_24_g262554 = Out_PivotOS15_g262556;
					float3 In_PivotOS16_g262555 = temp_output_2772_24_g262554;
					float3 In_PivotWS16_g262555 = Out_PivotWS15_g262556;
					float3 temp_output_2772_19_g262554 = Out_PivotWO15_g262556;
					float3 In_PivotWO16_g262555 = temp_output_2772_19_g262554;
					float3 temp_output_2772_20_g262554 = Out_NormalOS15_g262556;
					float3 temp_output_21_0_g262555 = temp_output_2772_20_g262554;
					float3 In_NormalOS16_g262555 = temp_output_21_0_g262555;
					float3 In_NormalWS16_g262555 = Out_NormalWS15_g262556;
					float3 In_NormalRawOS16_g262555 = Out_NormalRawOS15_g262556;
					float4 temp_output_6_0_g262555 = Out_TangentOS15_g262556;
					float4 In_TangentOS16_g262555 = temp_output_6_0_g262555;
					float3 In_TangentWS16_g262555 = Out_TangentWS15_g262556;
					float3 In_BitangentWS16_g262555 = Out_BitangentWS15_g262556;
					float3 In_ViewDirWS16_g262555 = Out_ViewDirWS15_g262556;
					float4 In_CoordsData16_g262555 = Out_CoordsData15_g262556;
					float4 temp_output_2772_29_g262554 = Out_VertexData15_g262556;
					float4 In_VertexData16_g262555 = temp_output_2772_29_g262554;
					float4 temp_output_2772_30_g262554 = Out_MasksData15_g262556;
					float4 In_MasksData16_g262555 = temp_output_2772_30_g262554;
					float4 temp_output_2772_27_g262554 = Out_PhaseData15_g262556;
					float4 In_PhaseData16_g262555 = temp_output_2772_27_g262554;
					half4 Model_TransformData2743_g262554 = Out_TransformData15_g262556;
					float3 temp_cast_16 = (0.0).xxx;
					float2 lerpResult3113_g262554 = lerp( (half4( 0, 1, 0.5, 1 )).xy , (TVE_WindParams).xy , TVE_IsEnabled);
					float2 Global_WindDirWS2542_g262554 = lerpResult3113_g262554;
					half2 Input_WindDirWS803_g262605 = Global_WindDirWS2542_g262554;
					float3 Model_PositionWO162_g262554 = temp_output_2772_17_g262554;
					half3 Input_ModelPositionWO761_g262558 = Model_PositionWO162_g262554;
					float3 Model_PivotWO402_g262554 = temp_output_2772_19_g262554;
					half3 Input_ModelPivotsWO419_g262558 = Model_PivotWO402_g262554;
					half Input_MotionPivots629_g262558 = _MotionSmallPivotValue;
					float3 lerpResult771_g262558 = lerp( Input_ModelPositionWO761_g262558 , Input_ModelPivotsWO419_g262558 , Input_MotionPivots629_g262558);
					half4 Model_PhaseData489_g262554 = temp_output_2772_27_g262554;
					half4 Input_ModelMotionData763_g262558 = Model_PhaseData489_g262554;
					half Input_MotionPhase764_g262558 = _MotionSmallPhaseValue;
					float temp_output_770_0_g262558 = ( (Input_ModelMotionData763_g262558).x * Input_MotionPhase764_g262558 );
					half3 Small_Position1421_g262554 = ( lerpResult771_g262558 + temp_output_770_0_g262558 );
					half3 Input_PositionWO419_g262605 = Small_Position1421_g262554;
					half Input_MotionTilling321_g262605 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g262605 = ( -(Input_PositionWO419_g262605).xz * Input_MotionTilling321_g262605 * 0.005 );
					float2 temp_output_3_0_g262606 = Noise_Coord979_g262605;
					float2 temp_output_21_0_g262606 = Input_WindDirWS803_g262605;
					float mulTime113_g262609 = _Time.y * 0.02;
					float lerpResult128_g262609 = lerp( mulTime113_g262609 , ( ( mulTime113_g262609 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g262605 = _MotionSmallSpeedValue;
					half Noise_Speed980_g262605 = ( lerpResult128_g262609 * Input_MotionSpeed62_g262605 );
					float temp_output_15_0_g262606 = Noise_Speed980_g262605;
					float temp_output_23_0_g262606 = frac( temp_output_15_0_g262606 );
					float4 lerpResult39_g262606 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g262606 + ( temp_output_21_0_g262606 * temp_output_23_0_g262606 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g262606 + ( temp_output_21_0_g262606 * frac( ( temp_output_15_0_g262606 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g262606 - 0.5 ) ) / 0.5 ));
					float4 temp_output_991_0_g262605 = lerpResult39_g262606;
					half2 Noise_DirWS858_g262605 = ((temp_output_991_0_g262605).rg*2.0 + -1.0);
					half Input_MotionNoise552_g262605 = _MotionSmallNoiseValue;
					TVEGlobalData Data15_g262568 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262568 = 0.0;
					float4 Out_CoatParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262568 = float4( 0,0,0,0 );
					BreakData( Data15_g262568 , Out_Dummy15_g262568 , Out_CoatParams15_g262568 , Out_CoatTexture15_g262568 , Out_PaintParams15_g262568 , Out_PaintTexture15_g262568 , Out_AtmoParams15_g262568 , Out_AtmoTexture15_g262568 , Out_GlowParams15_g262568 , Out_GlowTexture15_g262568 , Out_FormParams15_g262568 , Out_FormTexture15_g262568 , Out_FlowParams15_g262568 , Out_FlowTexture15_g262568 );
					half4 Global_FlowParams3052_g262554 = Out_FlowParams15_g262568;
					half4 Global_FlowTexture2668_g262554 = Out_FlowTexture15_g262568;
					#ifdef TVE_MOTION_ELEMENT
					float4 staticSwitch3075_g262554 = Global_FlowTexture2668_g262554;
					#else
					float4 staticSwitch3075_g262554 = Global_FlowParams3052_g262554;
					#endif
					float4 temp_output_6_0_g262570 = staticSwitch3075_g262554;
					float temp_output_7_0_g262570 = _MotionElementMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g262570 = ( temp_output_6_0_g262570 + temp_output_7_0_g262570 );
					#else
					float4 staticSwitch14_g262570 = temp_output_6_0_g262570;
					#endif
					float4 lerpResult3121_g262554 = lerp( half4( 0, 0, 0, 1 ) , staticSwitch14_g262570 , TVE_IsEnabled);
					float temp_output_630_0_g262583 = saturate( (lerpResult3121_g262554).w );
					float lerpResult853_g262583 = lerp( temp_output_630_0_g262583 , saturate( (temp_output_630_0_g262583*TVE_WindEditor.x + TVE_WindEditor.y) ) , TVE_WindEditor.w);
					half Global_WindValue1855_g262554 = ( lerpResult853_g262583 * _MotionIntensityValue );
					half Input_WindValue881_g262605 = Global_WindValue1855_g262554;
					float temp_output_6_0_g262611 = Input_WindValue881_g262605;
					float lerpResult701_g262605 = lerp( 1.0 , Input_MotionNoise552_g262605 , ( temp_output_6_0_g262611 * temp_output_6_0_g262611 ));
					float2 lerpResult646_g262605 = lerp( Input_WindDirWS803_g262605 , Noise_DirWS858_g262605 , lerpResult701_g262605);
					half2 Small_DirWS817_g262605 = lerpResult646_g262605;
					float2 break823_g262605 = Small_DirWS817_g262605;
					half4 Noise_Params685_g262605 = temp_output_991_0_g262605;
					half Wind_Sinus820_g262605 = ( ((Noise_Params685_g262605).b*2.0 + -1.0) * 0.6 );
					float3 appendResult824_g262605 = (float3(break823_g262605.x , Wind_Sinus820_g262605 , break823_g262605.y));
					half3 Small_Dir918_g262605 = appendResult824_g262605;
					float temp_output_20_0_g262610 = ( 1.0 - Input_WindValue881_g262605 );
					float3 appendResult1006_g262605 = (float3(Input_WindValue881_g262605 , ( 1.0 - ( temp_output_20_0_g262610 * temp_output_20_0_g262610 ) ) , Input_WindValue881_g262605));
					half Input_MotionDelay753_g262605 = _MotionSmallDelayValue;
					float lerpResult756_g262605 = lerp( 1.0 , ( Input_WindValue881_g262605 * Input_WindValue881_g262605 ) , Input_MotionDelay753_g262605);
					half Wind_Delay815_g262605 = lerpResult756_g262605;
					half Input_MotionValue905_g262605 = _MotionSmallIntensityValue;
					float3 temp_output_883_0_g262605 = ( Small_Dir918_g262605 * appendResult1006_g262605 * Wind_Delay815_g262605 * Input_MotionValue905_g262605 );
					float2 break857_g262605 = Noise_DirWS858_g262605;
					float3 appendResult833_g262605 = (float3(break857_g262605.x , Wind_Sinus820_g262605 , break857_g262605.y));
					half3 Push_Dir919_g262605 = appendResult833_g262605;
					half Input_MotionReact924_g262605 = _MotionSmallPushValue;
					float2 temp_output_3126_0_g262554 = ((lerpResult3121_g262554).xy*2.0 + -1.0);
					half Global_PushAlpha1504_g262554 = length( temp_output_3126_0_g262554 );
					half Input_PushAlpha806_g262605 = Global_PushAlpha1504_g262554;
					half Global_PushNoise2675_g262554 = (lerpResult3121_g262554).z;
					half Input_PushNoise890_g262605 = Global_PushNoise2675_g262554;
					half Push_Mask914_g262605 = saturate( ( Input_PushAlpha806_g262605 * Input_PushNoise890_g262605 * Input_MotionReact924_g262605 ) );
					float3 lerpResult840_g262605 = lerp( temp_output_883_0_g262605 , ( Push_Dir919_g262605 * Input_MotionReact924_g262605 ) , Push_Mask914_g262605);
					#ifdef TVE_MOTION_ELEMENT
					float3 staticSwitch829_g262605 = lerpResult840_g262605;
					#else
					float3 staticSwitch829_g262605 = temp_output_883_0_g262605;
					#endif
					half3 Small_Squash1489_g262554 = ( mul( unity_WorldToObject, float4( staticSwitch829_g262605 , 0.0 ) ).xyz * ase_parentObjectScale );
					float temp_output_17_0_g262593 = _MotionSmallMaskMode;
					float Option83_g262593 = temp_output_17_0_g262593;
					half4 Model_VertexMasks518_g262554 = temp_output_2772_29_g262554;
					float4 ChannelA83_g262593 = Model_VertexMasks518_g262554;
					half4 Model_MasksData1322_g262554 = temp_output_2772_30_g262554;
					float2 uv_MotionMaskTex2818_g262554 = v.texcoord.xyzw.xy;
					half4 Motion_MaskTex2819_g262554 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g262554, 0.0 );
					float4 appendResult3227_g262554 = (float4((Model_MasksData1322_g262554).xy , (Motion_MaskTex2819_g262554).g , 0.0));
					float4 ChannelB83_g262593 = appendResult3227_g262554;
					float localSwitchChannel883_g262593 = SwitchChannel8( Option83_g262593 , ChannelA83_g262593 , ChannelB83_g262593 );
					float enc1805_g262554 = v.texcoord.xyzw.z;
					float2 localDecodeFloatToVector21805_g262554 = DecodeFloatToVector2( enc1805_g262554 );
					float2 break1804_g262554 = localDecodeFloatToVector21805_g262554;
					half Small_Mask_Legacy1806_g262554 = break1804_g262554.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g262554 = Small_Mask_Legacy1806_g262554;
					#else
					float staticSwitch1800_g262554 = localSwitchChannel883_g262593;
					#endif
					float clampResult17_g262559 = clamp( staticSwitch1800_g262554 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262560 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g262560 = ( clampResult17_g262559 - temp_output_7_0_g262560 );
					half Small_Mask640_g262554 = saturate( ( temp_output_9_0_g262560 * _MotionSmallMaskRemap.z ) );
					float3 lerpResult3022_g262554 = lerp( float3( 1,1,1 ) , (TVE_MotionValueParams).xyz , TVE_MotionValueParams.w);
					half3 Global_MotionParams3013_g262554 = lerpResult3022_g262554;
					half3 Small_Motion789_g262554 = ( Small_Squash1489_g262554 * Small_Mask640_g262554 * (Global_MotionParams3013_g262554).y );
					#ifdef TVE_MOTION
					float3 staticSwitch495_g262554 = Small_Motion789_g262554;
					#else
					float3 staticSwitch495_g262554 = temp_cast_16;
					#endif
					float3 temp_cast_19 = (0.0).xxx;
					float3 Model_PositionWS1819_g262554 = temp_output_2772_16_g262554;
					half Global_DistMask1820_g262554 = ( 1.0 - saturate( ( distance( _WorldSpaceCameraPos , Model_PositionWS1819_g262554 ) / _MotionDistValue ) ) );
					float temp_output_17_0_g262594 = _MotionTinyMaskMode;
					float Option83_g262594 = temp_output_17_0_g262594;
					float4 ChannelA83_g262594 = Model_VertexMasks518_g262554;
					float4 appendResult3234_g262554 = (float4((Model_MasksData1322_g262554).xy , (Motion_MaskTex2819_g262554).b , 0.0));
					float4 ChannelB83_g262594 = appendResult3234_g262554;
					float localSwitchChannel883_g262594 = SwitchChannel8( Option83_g262594 , ChannelA83_g262594 , ChannelB83_g262594 );
					half Tiny_Mask_Legacy1807_g262554 = break1804_g262554.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g262554 = Tiny_Mask_Legacy1807_g262554;
					#else
					float staticSwitch1810_g262554 = localSwitchChannel883_g262594;
					#endif
					float clampResult17_g262561 = clamp( staticSwitch1810_g262554 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262562 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g262562 = ( clampResult17_g262561 - temp_output_7_0_g262562 );
					half Tiny_Mask218_g262554 = saturate( ( temp_output_9_0_g262562 * _MotionTinyMaskRemap.z ) );
					half3 Model_NormalOS554_g262554 = temp_output_2772_20_g262554;
					half3 Input_NormalOS533_g262576 = Model_NormalOS554_g262554;
					half3 Tiny_Position2469_g262554 = Model_PositionWO162_g262554;
					half3 Input_PositionWO500_g262576 = Tiny_Position2469_g262554;
					half Input_MotionTilling321_g262576 = ( _MotionTinyTillingValue + 0.1 );
					float lerpResult128_g262581 = lerp( _Time.y , ( ( _Time.y * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g262576 = _MotionTinySpeedValue;
					float4 tex2DNode514_g262576 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( ( (Input_PositionWO500_g262576).xz * Input_MotionTilling321_g262576 * 0.005 ) + ( lerpResult128_g262581 * Input_MotionSpeed62_g262576 * 0.02 ) ), 0.0 );
					half3 Flutter_Noise535_g262576 = (tex2DNode514_g262576.rgb*2.0 + -1.0);
					half Input_MotionNoise542_g262576 = _MotionTinyNoiseValue;
					float3 lerpResult537_g262576 = lerp( ( Input_NormalOS533_g262576 * Flutter_Noise535_g262576 ) , Flutter_Noise535_g262576 , Input_MotionNoise542_g262576);
					float mulTime113_g262582 = _Time.y * 2.0;
					float lerpResult128_g262582 = lerp( mulTime113_g262582 , ( ( mulTime113_g262582 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					float temp_output_578_0_g262576 = SAMPLE_TEXTURE3D_LOD( _NoiseTex3D, sampler_Linear_Repeat, ( ( Input_PositionWO500_g262576 + lerpResult128_g262582 ) * ( 1.0 * 0.01 ) ), 0.0 ).r;
					half Input_GlobalWind471_g262576 = Global_WindValue1855_g262554;
					float lerpResult579_g262576 = lerp( ( temp_output_578_0_g262576 * temp_output_578_0_g262576 * temp_output_578_0_g262576 * temp_output_578_0_g262576 ) , temp_output_578_0_g262576 , ( Input_GlobalWind471_g262576 * Input_GlobalWind471_g262576 ));
					float temp_output_20_0_g262580 = ( 1.0 - Input_GlobalWind471_g262576 );
					half Wind_Gust589_g262576 = ( ( lerpResult579_g262576 * ( 1.0 - ( temp_output_20_0_g262580 * temp_output_20_0_g262580 * temp_output_20_0_g262580 * temp_output_20_0_g262580 ) ) ) * 0.5 );
					half3 Tiny_Squash859_g262554 = ( lerpResult537_g262576 * Wind_Gust589_g262576 );
					half3 Tiny_Flutter1451_g262554 = ( _MotionTinyIntensityValue * Global_DistMask1820_g262554 * Tiny_Mask218_g262554 * Tiny_Squash859_g262554 * (Global_MotionParams3013_g262554).z );
					#ifdef TVE_MOTION
					float3 staticSwitch414_g262554 = Tiny_Flutter1451_g262554;
					#else
					float3 staticSwitch414_g262554 = temp_cast_19;
					#endif
					float4 appendResult2783_g262554 = (float4(( staticSwitch495_g262554 + staticSwitch414_g262554 ) , 0.0));
					half4 Final_TransformData1569_g262554 = ( Model_TransformData2743_g262554 + appendResult2783_g262554 );
					float4 In_TransformData16_g262555 = Final_TransformData1569_g262554;
					half4 Model_RotationData2740_g262554 = Out_RotationData15_g262556;
					half2 Input_WindDirWS803_g262595 = Global_WindDirWS2542_g262554;
					half3 Input_ModelPositionWO761_g262557 = Model_PositionWO162_g262554;
					half3 Input_ModelPivotsWO419_g262557 = Model_PivotWO402_g262554;
					half Input_MotionPivots629_g262557 = _MotionBasePivotValue;
					float3 lerpResult771_g262557 = lerp( Input_ModelPositionWO761_g262557 , Input_ModelPivotsWO419_g262557 , Input_MotionPivots629_g262557);
					half4 Input_ModelMotionData763_g262557 = Model_PhaseData489_g262554;
					half Input_MotionPhase764_g262557 = _MotionBasePhaseValue;
					float temp_output_770_0_g262557 = ( (Input_ModelMotionData763_g262557).x * Input_MotionPhase764_g262557 );
					half3 Base_Position1394_g262554 = ( lerpResult771_g262557 + temp_output_770_0_g262557 );
					half3 Input_PositionWO419_g262595 = Base_Position1394_g262554;
					half Input_MotionTilling321_g262595 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g262595 = ( -(Input_PositionWO419_g262595).xz * Input_MotionTilling321_g262595 * 0.005 );
					float2 temp_output_3_0_g262602 = Noise_Coord515_g262595;
					float2 temp_output_21_0_g262602 = Input_WindDirWS803_g262595;
					float mulTime113_g262596 = _Time.y * 0.02;
					float lerpResult128_g262596 = lerp( mulTime113_g262596 , ( ( mulTime113_g262596 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g262595 = _MotionBaseSpeedValue;
					half Noise_Speed516_g262595 = ( lerpResult128_g262596 * Input_MotionSpeed62_g262595 );
					float temp_output_15_0_g262602 = Noise_Speed516_g262595;
					float temp_output_23_0_g262602 = frac( temp_output_15_0_g262602 );
					float4 lerpResult39_g262602 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g262602 + ( temp_output_21_0_g262602 * temp_output_23_0_g262602 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g262602 + ( temp_output_21_0_g262602 * frac( ( temp_output_15_0_g262602 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g262602 - 0.5 ) ) / 0.5 ));
					float4 temp_output_635_0_g262595 = lerpResult39_g262602;
					half2 Noise_DirWS825_g262595 = ((temp_output_635_0_g262595).rg*2.0 + -1.0);
					half Input_MotionNoise552_g262595 = _MotionBaseNoiseValue;
					half Input_WindValue853_g262595 = Global_WindValue1855_g262554;
					float temp_output_6_0_g262599 = Input_WindValue853_g262595;
					float lerpResult701_g262595 = lerp( 1.0 , Input_MotionNoise552_g262595 , ( temp_output_6_0_g262599 * temp_output_6_0_g262599 ));
					half Input_PushNoise858_g262595 = Global_PushNoise2675_g262554;
					float2 lerpResult646_g262595 = lerp( Input_WindDirWS803_g262595 , Noise_DirWS825_g262595 , saturate( ( lerpResult701_g262595 + Input_PushNoise858_g262595 ) ));
					half2 Bend_Dir859_g262595 = lerpResult646_g262595;
					half Input_MotionValue871_g262595 = _MotionBaseIntensityValue;
					half Input_MotionDelay753_g262595 = _MotionBaseDelayValue;
					float lerpResult756_g262595 = lerp( 1.0 , ( Input_WindValue853_g262595 * Input_WindValue853_g262595 ) , Input_MotionDelay753_g262595);
					half Wind_Delay815_g262595 = lerpResult756_g262595;
					float2 temp_output_875_0_g262595 = ( Bend_Dir859_g262595 * Input_WindValue853_g262595 * Input_MotionValue871_g262595 * Wind_Delay815_g262595 );
					float2 Global_PushDirWS1972_g262554 = temp_output_3126_0_g262554;
					half2 Input_PushDirWS807_g262595 = Global_PushDirWS1972_g262554;
					half Input_ReactValue888_g262595 = _MotionBasePushValue;
					half Input_PushAlpha806_g262595 = Global_PushAlpha1504_g262554;
					half Push_Mask883_g262595 = saturate( ( Input_PushAlpha806_g262595 * Input_ReactValue888_g262595 ) );
					float2 lerpResult811_g262595 = lerp( temp_output_875_0_g262595 , ( Input_PushDirWS807_g262595 * Input_ReactValue888_g262595 ) , Push_Mask883_g262595);
					#ifdef TVE_MOTION_ELEMENT
					float2 staticSwitch808_g262595 = lerpResult811_g262595;
					#else
					float2 staticSwitch808_g262595 = temp_output_875_0_g262595;
					#endif
					float2 temp_output_38_0_g262600 = staticSwitch808_g262595;
					float2 break83_g262600 = temp_output_38_0_g262600;
					float3 appendResult79_g262600 = (float3(break83_g262600.x , 0.0 , break83_g262600.y));
					half2 Base_Bending893_g262554 = (( mul( unity_WorldToObject, float4( appendResult79_g262600 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
					float temp_output_17_0_g262592 = _MotionBaseMaskMode;
					float Option83_g262592 = temp_output_17_0_g262592;
					float4 ChannelA83_g262592 = Model_VertexMasks518_g262554;
					float4 appendResult3220_g262554 = (float4((Model_MasksData1322_g262554).xy , (Motion_MaskTex2819_g262554).r , 0.0));
					float4 ChannelB83_g262592 = appendResult3220_g262554;
					float localSwitchChannel883_g262592 = SwitchChannel8( Option83_g262592 , ChannelA83_g262592 , ChannelB83_g262592 );
					float clampResult17_g262564 = clamp( localSwitchChannel883_g262592 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262563 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g262563 = ( clampResult17_g262564 - temp_output_7_0_g262563 );
					half Base_Mask217_g262554 = saturate( ( temp_output_9_0_g262563 * _MotionBaseMaskRemap.z ) );
					half2 Base_Motion1440_g262554 = ( Base_Bending893_g262554 * Base_Mask217_g262554 * (Global_MotionParams3013_g262554).x );
					#ifdef TVE_MOTION
					float2 staticSwitch2384_g262554 = Base_Motion1440_g262554;
					#else
					float2 staticSwitch2384_g262554 = float2( 0,0 );
					#endif
					float4 appendResult2023_g262554 = (float4(staticSwitch2384_g262554 , 0.0 , 0.0));
					half4 Final_RotationData1570_g262554 = ( Model_RotationData2740_g262554 + appendResult2023_g262554 );
					float4 In_RotationData16_g262555 = Final_RotationData1570_g262554;
					half4 Model_Interpolator02773_g262554 = Out_InterpolatorA15_g262556;
					half4 Noise_Params685_g262595 = temp_output_635_0_g262595;
					float temp_output_6_0_g262598 = (Noise_Params685_g262595).a;
					float temp_output_913_0_g262595 = ( ( temp_output_6_0_g262598 * temp_output_6_0_g262598 * temp_output_6_0_g262598 * temp_output_6_0_g262598 ) * ( Input_WindValue853_g262595 * Wind_Delay815_g262595 ) );
					float temp_output_6_0_g262597 = length( Input_PushDirWS807_g262595 );
					float lerpResult902_g262595 = lerp( temp_output_913_0_g262595 , ( ( temp_output_6_0_g262597 * temp_output_6_0_g262597 ) * Input_PushNoise858_g262595 ) , Push_Mask883_g262595);
					#ifdef TVE_MOTION_ELEMENT
					float staticSwitch903_g262595 = lerpResult902_g262595;
					#else
					float staticSwitch903_g262595 = temp_output_913_0_g262595;
					#endif
					half Base_Wave1159_g262554 = staticSwitch903_g262595;
					float temp_output_6_0_g262612 = (Noise_Params685_g262605).a;
					float temp_output_955_0_g262605 = ( temp_output_6_0_g262612 * temp_output_6_0_g262612 * temp_output_6_0_g262612 * temp_output_6_0_g262612 );
					float temp_output_944_0_g262605 = ( temp_output_955_0_g262605 * ( Input_WindValue881_g262605 * Wind_Delay815_g262605 ) );
					float lerpResult936_g262605 = lerp( temp_output_944_0_g262605 , ( temp_output_955_0_g262605 * Input_PushNoise890_g262605 ) , Push_Mask914_g262605);
					#ifdef TVE_MOTION_ELEMENT
					float staticSwitch939_g262605 = lerpResult936_g262605;
					#else
					float staticSwitch939_g262605 = temp_output_944_0_g262605;
					#endif
					half Small_Wave1427_g262554 = staticSwitch939_g262605;
					float lerpResult2422_g262554 = lerp( Base_Wave1159_g262554 , Small_Wave1427_g262554 , _motion_small_mode);
					half Global_Wave1475_g262554 = saturate( lerpResult2422_g262554 );
					float temp_output_6_0_g262565 = ( _MotionHighlightValue * Global_DistMask1820_g262554 * ( Tiny_Mask218_g262554 * Tiny_Mask218_g262554 ) * Global_Wave1475_g262554 );
					float temp_output_7_0_g262565 = _MotionHighlightColor.r;
					#ifdef TVE_DUMMY
					float staticSwitch14_g262565 = ( temp_output_6_0_g262565 + temp_output_7_0_g262565 );
					#else
					float staticSwitch14_g262565 = temp_output_6_0_g262565;
					#endif
					#ifdef TVE_MOTION
					float staticSwitch2866_g262554 = staticSwitch14_g262565;
					#else
					float staticSwitch2866_g262554 = 0.0;
					#endif
					float4 appendResult2775_g262554 = (float4((Model_Interpolator02773_g262554).xyz , staticSwitch2866_g262554));
					half4 Final_Interpolator02774_g262554 = appendResult2775_g262554;
					float4 In_InterpolatorA16_g262555 = Final_Interpolator02774_g262554;
					BuildModelVertData( Data16_g262555 , In_Dummy16_g262555 , In_PositionOS16_g262555 , In_PositionWS16_g262555 , In_PositionWO16_g262555 , In_PositionRawOS16_g262555 , In_PivotOS16_g262555 , In_PivotWS16_g262555 , In_PivotWO16_g262555 , In_NormalOS16_g262555 , In_NormalWS16_g262555 , In_NormalRawOS16_g262555 , In_TangentOS16_g262555 , In_TangentWS16_g262555 , In_BitangentWS16_g262555 , In_ViewDirWS16_g262555 , In_CoordsData16_g262555 , In_VertexData16_g262555 , In_MasksData16_g262555 , In_PhaseData16_g262555 , In_TransformData16_g262555 , In_RotationData16_g262555 , In_InterpolatorA16_g262555 );
					TVEModelData Data15_g262614 =(TVEModelData)Data16_g262555;
					float Out_Dummy15_g262614 = 0.0;
					float3 Out_PositionOS15_g262614 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262614 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262614 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262614 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262614 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262614 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262614 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262614 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262614 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262614 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262614 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262614 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262614 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262614 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262614 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262614 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262614 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262614 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262614 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262614 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262614 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262614 , Out_Dummy15_g262614 , Out_PositionOS15_g262614 , Out_PositionWS15_g262614 , Out_PositionWO15_g262614 , Out_PositionRawOS15_g262614 , Out_PivotOS15_g262614 , Out_PivotWS15_g262614 , Out_PivotWO15_g262614 , Out_NormalOS15_g262614 , Out_NormalWS15_g262614 , Out_NormalRawOS15_g262614 , Out_TangentOS15_g262614 , Out_TangentWS15_g262614 , Out_BitangentWS15_g262614 , Out_ViewDirWS15_g262614 , Out_CoordsData15_g262614 , Out_VertexData15_g262614 , Out_MasksData15_g262614 , Out_PhaseData15_g262614 , Out_TransformData15_g262614 , Out_RotationData15_g262614 , Out_InterpolatorA15_g262614 );
					TVEModelData Data16_g262615 =(TVEModelData)Data15_g262614;
					float temp_output_14_0_g262615 = 0.0;
					float In_Dummy16_g262615 = temp_output_14_0_g262615;
					float3 Model_PositionOS147_g262613 = Out_PositionOS15_g262614;
					half3 VertexPos40_g262619 = Model_PositionOS147_g262613;
					float4 temp_output_1567_33_g262613 = Out_RotationData15_g262614;
					half4 Model_RotationData1569_g262613 = temp_output_1567_33_g262613;
					float2 break1582_g262613 = (Model_RotationData1569_g262613).xy;
					half Angle44_g262619 = break1582_g262613.y;
					half CosAngle89_g262619 = cos( Angle44_g262619 );
					half SinAngle93_g262619 = sin( Angle44_g262619 );
					float3 appendResult95_g262619 = (float3((VertexPos40_g262619).x , ( ( (VertexPos40_g262619).y * CosAngle89_g262619 ) - ( (VertexPos40_g262619).z * SinAngle93_g262619 ) ) , ( ( (VertexPos40_g262619).y * SinAngle93_g262619 ) + ( (VertexPos40_g262619).z * CosAngle89_g262619 ) )));
					half3 VertexPos40_g262620 = appendResult95_g262619;
					half Angle44_g262620 = -break1582_g262613.x;
					half CosAngle94_g262620 = cos( Angle44_g262620 );
					half SinAngle95_g262620 = sin( Angle44_g262620 );
					float3 appendResult98_g262620 = (float3(( ( (VertexPos40_g262620).x * CosAngle94_g262620 ) - ( (VertexPos40_g262620).y * SinAngle95_g262620 ) ) , ( ( (VertexPos40_g262620).x * SinAngle95_g262620 ) + ( (VertexPos40_g262620).y * CosAngle94_g262620 ) ) , (VertexPos40_g262620).z));
					half3 VertexPos40_g262618 = Model_PositionOS147_g262613;
					half Angle44_g262618 = break1582_g262613.y;
					half CosAngle89_g262618 = cos( Angle44_g262618 );
					half SinAngle93_g262618 = sin( Angle44_g262618 );
					float3 appendResult95_g262618 = (float3((VertexPos40_g262618).x , ( ( (VertexPos40_g262618).y * CosAngle89_g262618 ) - ( (VertexPos40_g262618).z * SinAngle93_g262618 ) ) , ( ( (VertexPos40_g262618).y * SinAngle93_g262618 ) + ( (VertexPos40_g262618).z * CosAngle89_g262618 ) )));
					half3 VertexPos40_g262623 = appendResult95_g262618;
					half Angle44_g262623 = break1582_g262613.x;
					half CosAngle91_g262623 = cos( Angle44_g262623 );
					half SinAngle92_g262623 = sin( Angle44_g262623 );
					float3 appendResult93_g262623 = (float3(( ( (VertexPos40_g262623).x * CosAngle91_g262623 ) + ( (VertexPos40_g262623).z * SinAngle92_g262623 ) ) , (VertexPos40_g262623).y , ( ( -(VertexPos40_g262623).x * SinAngle92_g262623 ) + ( (VertexPos40_g262623).z * CosAngle91_g262623 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262621 = appendResult93_g262623;
					#else
					float3 staticSwitch65_g262621 = appendResult98_g262620;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g262616 = staticSwitch65_g262621;
					#else
					float3 staticSwitch65_g262616 = Model_PositionOS147_g262613;
					#endif
					float3 temp_output_1608_0_g262613 = staticSwitch65_g262616;
					half3 VertexPos40_g262622 = temp_output_1608_0_g262613;
					half Angle44_g262622 = (Model_RotationData1569_g262613).z;
					half CosAngle91_g262622 = cos( Angle44_g262622 );
					half SinAngle92_g262622 = sin( Angle44_g262622 );
					float3 appendResult93_g262622 = (float3(( ( (VertexPos40_g262622).x * CosAngle91_g262622 ) + ( (VertexPos40_g262622).z * SinAngle92_g262622 ) ) , (VertexPos40_g262622).y , ( ( -(VertexPos40_g262622).x * SinAngle92_g262622 ) + ( (VertexPos40_g262622).z * CosAngle91_g262622 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g262617 = appendResult93_g262622;
					#else
					float3 staticSwitch65_g262617 = temp_output_1608_0_g262613;
					#endif
					float4 temp_output_1567_31_g262613 = Out_TransformData15_g262614;
					half4 Model_TransformData1568_g262613 = temp_output_1567_31_g262613;
					half3 Final_PositionOS178_g262613 = ( ( staticSwitch65_g262617 * (Model_TransformData1568_g262613).w ) + (Model_TransformData1568_g262613).xyz );
					float3 temp_output_4_0_g262615 = Final_PositionOS178_g262613;
					float3 In_PositionOS16_g262615 = temp_output_4_0_g262615;
					float3 In_PositionWS16_g262615 = Out_PositionWS15_g262614;
					float3 In_PositionWO16_g262615 = Out_PositionWO15_g262614;
					float3 In_PositionRawOS16_g262615 = Out_PositionRawOS15_g262614;
					float3 In_PivotOS16_g262615 = Out_PivotOS15_g262614;
					float3 In_PivotWS16_g262615 = Out_PivotWS15_g262614;
					float3 In_PivotWO16_g262615 = Out_PivotWO15_g262614;
					float3 temp_output_21_0_g262615 = Out_NormalOS15_g262614;
					float3 In_NormalOS16_g262615 = temp_output_21_0_g262615;
					float3 In_NormalWS16_g262615 = Out_NormalWS15_g262614;
					float3 In_NormalRawOS16_g262615 = Out_NormalRawOS15_g262614;
					float4 temp_output_6_0_g262615 = Out_TangentOS15_g262614;
					float4 In_TangentOS16_g262615 = temp_output_6_0_g262615;
					float3 In_TangentWS16_g262615 = Out_TangentWS15_g262614;
					float3 In_BitangentWS16_g262615 = Out_BitangentWS15_g262614;
					float3 In_ViewDirWS16_g262615 = Out_ViewDirWS15_g262614;
					float4 In_CoordsData16_g262615 = Out_CoordsData15_g262614;
					float4 In_VertexData16_g262615 = Out_VertexData15_g262614;
					float4 In_MasksData16_g262615 = Out_MasksData15_g262614;
					float4 In_PhaseData16_g262615 = Out_PhaseData15_g262614;
					float4 In_TransformData16_g262615 = temp_output_1567_31_g262613;
					float4 In_RotationData16_g262615 = temp_output_1567_33_g262613;
					float4 In_InterpolatorA16_g262615 = Out_InterpolatorA15_g262614;
					BuildModelVertData( Data16_g262615 , In_Dummy16_g262615 , In_PositionOS16_g262615 , In_PositionWS16_g262615 , In_PositionWO16_g262615 , In_PositionRawOS16_g262615 , In_PivotOS16_g262615 , In_PivotWS16_g262615 , In_PivotWO16_g262615 , In_NormalOS16_g262615 , In_NormalWS16_g262615 , In_NormalRawOS16_g262615 , In_TangentOS16_g262615 , In_TangentWS16_g262615 , In_BitangentWS16_g262615 , In_ViewDirWS16_g262615 , In_CoordsData16_g262615 , In_VertexData16_g262615 , In_MasksData16_g262615 , In_PhaseData16_g262615 , In_TransformData16_g262615 , In_RotationData16_g262615 , In_InterpolatorA16_g262615 );
					TVEModelData Data15_g262625 =(TVEModelData)Data16_g262615;
					float Out_Dummy15_g262625 = 0.0;
					float3 Out_PositionOS15_g262625 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262625 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262625 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262625 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262625 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262625 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262625 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262625 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262625 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262625 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262625 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262625 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262625 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262625 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262625 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262625 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262625 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262625 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262625 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262625 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262625 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262625 , Out_Dummy15_g262625 , Out_PositionOS15_g262625 , Out_PositionWS15_g262625 , Out_PositionWO15_g262625 , Out_PositionRawOS15_g262625 , Out_PivotOS15_g262625 , Out_PivotWS15_g262625 , Out_PivotWO15_g262625 , Out_NormalOS15_g262625 , Out_NormalWS15_g262625 , Out_NormalRawOS15_g262625 , Out_TangentOS15_g262625 , Out_TangentWS15_g262625 , Out_BitangentWS15_g262625 , Out_ViewDirWS15_g262625 , Out_CoordsData15_g262625 , Out_VertexData15_g262625 , Out_MasksData15_g262625 , Out_PhaseData15_g262625 , Out_TransformData15_g262625 , Out_RotationData15_g262625 , Out_InterpolatorA15_g262625 );
					TVEModelData Data16_g262627 =(TVEModelData)Data15_g262625;
					half Dummy1823_g262624 = ( _FlattenCategory + _FlattenEnd + _FlattenBakeMode );
					float temp_output_14_0_g262627 = Dummy1823_g262624;
					float In_Dummy16_g262627 = temp_output_14_0_g262627;
					float3 temp_output_4_0_g262627 = Out_PositionOS15_g262625;
					float3 In_PositionOS16_g262627 = temp_output_4_0_g262627;
					float3 In_PositionWS16_g262627 = Out_PositionWS15_g262625;
					float3 In_PositionWO16_g262627 = Out_PositionWO15_g262625;
					float3 temp_output_1810_26_g262624 = Out_PositionRawOS15_g262625;
					float3 In_PositionRawOS16_g262627 = temp_output_1810_26_g262624;
					float3 In_PivotOS16_g262627 = Out_PivotOS15_g262625;
					float3 In_PivotWS16_g262627 = Out_PivotWS15_g262625;
					float3 In_PivotWO16_g262627 = Out_PivotWO15_g262625;
					half3 Model_NormalOS1829_g262624 = Out_NormalOS15_g262625;
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262626 = half3( 0, 0, 1 );
					#else
					float3 staticSwitch65_g262626 = half3( 0, 1, 0 );
					#endif
					float3 lerpResult1820_g262624 = lerp( Model_NormalOS1829_g262624 , staticSwitch65_g262626 , _FlattenIntensityValue);
					float3 Model_PositionBaseOS1837_g262624 = temp_output_1810_26_g262624;
					float3 normalizeResult1816_g262624 = ASESafeNormalize( ( Model_PositionBaseOS1837_g262624 + _FlattenSphereOffsetValue ) );
					float3 lerpResult1813_g262624 = lerp( lerpResult1820_g262624 , normalizeResult1816_g262624 , _FlattenSphereValue);
					float temp_output_17_0_g262634 = _FlattenMeshMode;
					float Option70_g262634 = temp_output_17_0_g262634;
					float4 temp_output_1810_29_g262624 = Out_VertexData15_g262625;
					half4 Model_VertexData1826_g262624 = temp_output_1810_29_g262624;
					float4 temp_output_3_0_g262634 = Model_VertexData1826_g262624;
					float4 Channel70_g262634 = temp_output_3_0_g262634;
					float localSwitchChannel470_g262634 = SwitchChannel4( Option70_g262634 , Channel70_g262634 );
					float clampResult17_g262628 = clamp( localSwitchChannel470_g262634 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262629 = _FlattenMeshRemap.x;
					float temp_output_9_0_g262629 = ( clampResult17_g262628 - temp_output_7_0_g262629 );
					float lerpResult1841_g262624 = lerp( 1.0 , saturate( ( temp_output_9_0_g262629 * _FlattenMeshRemap.z ) ) , _FlattenMeshValue);
					half Normal_MeskMask1847_g262624 = lerpResult1841_g262624;
					half Normal_Mask1851_g262624 = Normal_MeskMask1847_g262624;
					float3 lerpResult1856_g262624 = lerp( Model_NormalOS1829_g262624 , lerpResult1813_g262624 , Normal_Mask1851_g262624);
					#ifdef TVE_FLATTEN
					float3 staticSwitch1857_g262624 = lerpResult1856_g262624;
					#else
					float3 staticSwitch1857_g262624 = Model_NormalOS1829_g262624;
					#endif
					half3 Final_NormalOS1853_g262624 = staticSwitch1857_g262624;
					float3 temp_output_21_0_g262627 = Final_NormalOS1853_g262624;
					float3 In_NormalOS16_g262627 = temp_output_21_0_g262627;
					float3 In_NormalWS16_g262627 = Out_NormalWS15_g262625;
					float3 In_NormalRawOS16_g262627 = Out_NormalRawOS15_g262625;
					float4 temp_output_6_0_g262627 = Out_TangentOS15_g262625;
					float4 In_TangentOS16_g262627 = temp_output_6_0_g262627;
					float3 In_TangentWS16_g262627 = Out_TangentWS15_g262625;
					float3 In_BitangentWS16_g262627 = Out_BitangentWS15_g262625;
					float3 In_ViewDirWS16_g262627 = Out_ViewDirWS15_g262625;
					float4 In_CoordsData16_g262627 = Out_CoordsData15_g262625;
					float4 In_VertexData16_g262627 = temp_output_1810_29_g262624;
					float4 In_MasksData16_g262627 = Out_MasksData15_g262625;
					float4 In_PhaseData16_g262627 = Out_PhaseData15_g262625;
					float4 In_TransformData16_g262627 = Out_TransformData15_g262625;
					float4 In_RotationData16_g262627 = Out_RotationData15_g262625;
					float4 In_InterpolatorA16_g262627 = Out_InterpolatorA15_g262625;
					BuildModelVertData( Data16_g262627 , In_Dummy16_g262627 , In_PositionOS16_g262627 , In_PositionWS16_g262627 , In_PositionWO16_g262627 , In_PositionRawOS16_g262627 , In_PivotOS16_g262627 , In_PivotWS16_g262627 , In_PivotWO16_g262627 , In_NormalOS16_g262627 , In_NormalWS16_g262627 , In_NormalRawOS16_g262627 , In_TangentOS16_g262627 , In_TangentWS16_g262627 , In_BitangentWS16_g262627 , In_ViewDirWS16_g262627 , In_CoordsData16_g262627 , In_VertexData16_g262627 , In_MasksData16_g262627 , In_PhaseData16_g262627 , In_TransformData16_g262627 , In_RotationData16_g262627 , In_InterpolatorA16_g262627 );
					TVEModelData Data15_g262641 =(TVEModelData)Data16_g262627;
					float Out_Dummy15_g262641 = 0.0;
					float3 Out_PositionOS15_g262641 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262641 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262641 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262641 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262641 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262641 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262641 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262641 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262641 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262641 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262641 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262641 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262641 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262641 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262641 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262641 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262641 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262641 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262641 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262641 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262641 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262641 , Out_Dummy15_g262641 , Out_PositionOS15_g262641 , Out_PositionWS15_g262641 , Out_PositionWO15_g262641 , Out_PositionRawOS15_g262641 , Out_PivotOS15_g262641 , Out_PivotWS15_g262641 , Out_PivotWO15_g262641 , Out_NormalOS15_g262641 , Out_NormalWS15_g262641 , Out_NormalRawOS15_g262641 , Out_TangentOS15_g262641 , Out_TangentWS15_g262641 , Out_BitangentWS15_g262641 , Out_ViewDirWS15_g262641 , Out_CoordsData15_g262641 , Out_VertexData15_g262641 , Out_MasksData15_g262641 , Out_PhaseData15_g262641 , Out_TransformData15_g262641 , Out_RotationData15_g262641 , Out_InterpolatorA15_g262641 );
					TVEModelData Data16_g262636 =(TVEModelData)Data15_g262641;
					half Dummy1575_g262635 = ( _ReshadeCategory + _ReshadeEnd );
					float temp_output_14_0_g262636 = Dummy1575_g262635;
					float In_Dummy16_g262636 = temp_output_14_0_g262636;
					float3 temp_output_4_0_g262636 = Out_PositionOS15_g262641;
					float3 In_PositionOS16_g262636 = temp_output_4_0_g262636;
					float3 In_PositionWS16_g262636 = Out_PositionWS15_g262641;
					float3 In_PositionWO16_g262636 = Out_PositionWO15_g262641;
					float3 In_PositionRawOS16_g262636 = Out_PositionRawOS15_g262641;
					float3 In_PivotOS16_g262636 = Out_PivotOS15_g262641;
					float3 In_PivotWS16_g262636 = Out_PivotWS15_g262641;
					float3 In_PivotWO16_g262636 = Out_PivotWO15_g262641;
					half3 Model_NormalOS1568_g262635 = Out_NormalOS15_g262641;
					half3 VertexPos40_g262638 = Model_NormalOS1568_g262635;
					half3 VertexPos40_g262639 = VertexPos40_g262638;
					float4 temp_output_1567_33_g262635 = Out_RotationData15_g262641;
					half4 Model_RotationData1583_g262635 = temp_output_1567_33_g262635;
					half2 Angle44_g262638 = Model_RotationData1583_g262635.xy;
					half Angle44_g262639 = (Angle44_g262638).y;
					half CosAngle89_g262639 = cos( Angle44_g262639 );
					half SinAngle93_g262639 = sin( Angle44_g262639 );
					float3 appendResult95_g262639 = (float3((VertexPos40_g262639).x , ( ( (VertexPos40_g262639).y * CosAngle89_g262639 ) - ( (VertexPos40_g262639).z * SinAngle93_g262639 ) ) , ( ( (VertexPos40_g262639).y * SinAngle93_g262639 ) + ( (VertexPos40_g262639).z * CosAngle89_g262639 ) )));
					half3 VertexPos40_g262640 = appendResult95_g262639;
					half Angle44_g262640 = -(Angle44_g262638).x;
					half CosAngle94_g262640 = cos( Angle44_g262640 );
					half SinAngle95_g262640 = sin( Angle44_g262640 );
					float3 appendResult98_g262640 = (float3(( ( (VertexPos40_g262640).x * CosAngle94_g262640 ) - ( (VertexPos40_g262640).y * SinAngle95_g262640 ) ) , ( ( (VertexPos40_g262640).x * SinAngle95_g262640 ) + ( (VertexPos40_g262640).y * CosAngle94_g262640 ) ) , (VertexPos40_g262640).z));
					float3 lerpResult1591_g262635 = lerp( Model_NormalOS1568_g262635 , appendResult98_g262640 , _ReshadeIntensityValue);
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g262637 = lerpResult1591_g262635;
					#else
					float3 staticSwitch65_g262637 = Model_NormalOS1568_g262635;
					#endif
					float3 temp_output_1732_0_g262635 = staticSwitch65_g262637;
					#ifdef TVE_RESHADE
					float3 staticSwitch1716_g262635 = temp_output_1732_0_g262635;
					#else
					float3 staticSwitch1716_g262635 = Model_NormalOS1568_g262635;
					#endif
					half3 Final_NormalOS178_g262635 = staticSwitch1716_g262635;
					float3 temp_output_21_0_g262636 = Final_NormalOS178_g262635;
					float3 In_NormalOS16_g262636 = temp_output_21_0_g262636;
					float3 In_NormalWS16_g262636 = Out_NormalWS15_g262641;
					float3 In_NormalRawOS16_g262636 = Out_NormalRawOS15_g262641;
					float4 temp_output_6_0_g262636 = Out_TangentOS15_g262641;
					float4 In_TangentOS16_g262636 = temp_output_6_0_g262636;
					float3 In_TangentWS16_g262636 = Out_TangentWS15_g262641;
					float3 In_BitangentWS16_g262636 = Out_BitangentWS15_g262641;
					float3 In_ViewDirWS16_g262636 = Out_ViewDirWS15_g262641;
					float4 In_CoordsData16_g262636 = Out_CoordsData15_g262641;
					float4 In_VertexData16_g262636 = Out_VertexData15_g262641;
					float4 In_MasksData16_g262636 = Out_MasksData15_g262641;
					float4 In_PhaseData16_g262636 = Out_PhaseData15_g262641;
					float4 In_TransformData16_g262636 = Out_TransformData15_g262641;
					float4 In_RotationData16_g262636 = temp_output_1567_33_g262635;
					float4 In_InterpolatorA16_g262636 = Out_InterpolatorA15_g262641;
					BuildModelVertData( Data16_g262636 , In_Dummy16_g262636 , In_PositionOS16_g262636 , In_PositionWS16_g262636 , In_PositionWO16_g262636 , In_PositionRawOS16_g262636 , In_PivotOS16_g262636 , In_PivotWS16_g262636 , In_PivotWO16_g262636 , In_NormalOS16_g262636 , In_NormalWS16_g262636 , In_NormalRawOS16_g262636 , In_TangentOS16_g262636 , In_TangentWS16_g262636 , In_BitangentWS16_g262636 , In_ViewDirWS16_g262636 , In_CoordsData16_g262636 , In_VertexData16_g262636 , In_MasksData16_g262636 , In_PhaseData16_g262636 , In_TransformData16_g262636 , In_RotationData16_g262636 , In_InterpolatorA16_g262636 );
					TVEModelData Data15_g262654 =(TVEModelData)Data16_g262636;
					float Out_Dummy15_g262654 = 0.0;
					float3 Out_PositionOS15_g262654 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262654 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262654 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262654 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262654 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262654 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262654 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262654 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262654 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262654 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262654 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262654 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262654 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262654 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262654 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262654 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262654 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262654 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262654 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262654 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262654 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262654 , Out_Dummy15_g262654 , Out_PositionOS15_g262654 , Out_PositionWS15_g262654 , Out_PositionWO15_g262654 , Out_PositionRawOS15_g262654 , Out_PivotOS15_g262654 , Out_PivotWS15_g262654 , Out_PivotWO15_g262654 , Out_NormalOS15_g262654 , Out_NormalWS15_g262654 , Out_NormalRawOS15_g262654 , Out_TangentOS15_g262654 , Out_TangentWS15_g262654 , Out_BitangentWS15_g262654 , Out_ViewDirWS15_g262654 , Out_CoordsData15_g262654 , Out_VertexData15_g262654 , Out_MasksData15_g262654 , Out_PhaseData15_g262654 , Out_TransformData15_g262654 , Out_RotationData15_g262654 , Out_InterpolatorA15_g262654 );
					TVEModelData Data16_g262655 =(TVEModelData)Data15_g262654;
					half Dummy1575_g262645 = ( _TransferCategory + _TransferEnd + _TransferSpace );
					float temp_output_14_0_g262655 = Dummy1575_g262645;
					float In_Dummy16_g262655 = temp_output_14_0_g262655;
					float3 temp_output_4_0_g262655 = Out_PositionOS15_g262654;
					float3 In_PositionOS16_g262655 = temp_output_4_0_g262655;
					float3 In_PositionWS16_g262655 = Out_PositionWS15_g262654;
					float3 temp_output_1567_17_g262645 = Out_PositionWO15_g262654;
					float3 In_PositionWO16_g262655 = temp_output_1567_17_g262645;
					float3 temp_output_1567_26_g262645 = Out_PositionRawOS15_g262654;
					float3 In_PositionRawOS16_g262655 = temp_output_1567_26_g262645;
					float3 In_PivotOS16_g262655 = Out_PivotOS15_g262654;
					float3 In_PivotWS16_g262655 = Out_PivotWS15_g262654;
					float3 In_PivotWO16_g262655 = Out_PivotWO15_g262654;
					half3 Model_NormalOS1568_g262645 = Out_NormalOS15_g262654;
					TVEGlobalData Data15_g262660 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262660 = 0.0;
					float4 Out_CoatParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262660 = float4( 0,0,0,0 );
					BreakData( Data15_g262660 , Out_Dummy15_g262660 , Out_CoatParams15_g262660 , Out_CoatTexture15_g262660 , Out_PaintParams15_g262660 , Out_PaintTexture15_g262660 , Out_AtmoParams15_g262660 , Out_AtmoTexture15_g262660 , Out_GlowParams15_g262660 , Out_GlowTexture15_g262660 , Out_FormParams15_g262660 , Out_FormTexture15_g262660 , Out_FlowParams15_g262660 , Out_FlowTexture15_g262660 );
					half4 Global_FormTexture1633_g262645 = Out_FormTexture15_g262660;
					float2 temp_output_1627_0_g262645 = ((Global_FormTexture1633_g262645).xy*2.0 + -1.0);
					float2 break1617_g262645 = temp_output_1627_0_g262645;
					float dotResult1619_g262645 = dot( temp_output_1627_0_g262645 , temp_output_1627_0_g262645 );
					float3 appendResult1618_g262645 = (float3(break1617_g262645.x , sqrt( ( 1.0 - saturate( dotResult1619_g262645 ) ) ) , break1617_g262645.y));
					float3 worldToObjDir1623_g262645 = mul( unity_WorldToObject, float4( appendResult1618_g262645, 0.0 ) ).xyz;
					half3 Conform_Normal1630_g262645 = worldToObjDir1623_g262645;
					float temp_output_6_0_g262646 = ( _TransferIntensityValue * TVE_IsEnabled );
					float temp_output_7_0_g262646 = ( _TransferPerPixelMode + _TransferInfo );
					#ifdef TVE_DUMMY
					float staticSwitch14_g262646 = ( temp_output_6_0_g262646 + temp_output_7_0_g262646 );
					#else
					float staticSwitch14_g262646 = temp_output_6_0_g262646;
					#endif
					half Conform_Value1742_g262645 = staticSwitch14_g262646;
					float3 temp_output_1567_21_g262645 = Out_NormalWS15_g262654;
					half3 Model_NormalWS1639_g262645 = temp_output_1567_21_g262645;
					float temp_output_1646_0_g262645 = (Model_NormalWS1639_g262645).y;
					float temp_output_7_0_g262649 = _TransferProjRemap.x;
					float temp_output_9_0_g262649 = ( saturate( temp_output_1646_0_g262645 ) - temp_output_7_0_g262649 );
					float lerpResult1669_g262645 = lerp( 1.0 , saturate( ( temp_output_9_0_g262649 * _TransferProjRemap.z ) ) , _TransferProjValue);
					half Normal_Proj_Mask1647_g262645 = lerpResult1669_g262645;
					float temp_output_17_0_g262653 = _TransferMeshMode;
					float Option70_g262653 = temp_output_17_0_g262653;
					float4 temp_output_1567_29_g262645 = Out_VertexData15_g262654;
					half4 Model_VertexData1608_g262645 = temp_output_1567_29_g262645;
					float4 temp_output_3_0_g262653 = Model_VertexData1608_g262645;
					float4 Channel70_g262653 = temp_output_3_0_g262653;
					float localSwitchChannel470_g262653 = SwitchChannel4( Option70_g262653 , Channel70_g262653 );
					float temp_output_1857_0_g262645 = localSwitchChannel470_g262653;
					float temp_output_7_0_g262651 = _TransferMeshRemap.x;
					float temp_output_9_0_g262651 = ( temp_output_1857_0_g262645 - temp_output_7_0_g262651 );
					float lerpResult1820_g262645 = lerp( 1.0 , saturate( ( temp_output_9_0_g262651 * _TransferMeshRemap.z ) ) , _TransferMeshValue);
					half Blend_VertMask1825_g262645 = lerpResult1820_g262645;
					float3 Model_PositionWO1640_g262645 = temp_output_1567_17_g262645;
					float temp_output_64_0_g262652 = saturate( ( ( (Global_FormTexture1633_g262645).z - (Model_PositionWO1640_g262645).y ) + _TransferFormOffsetValue ) );
					float temp_output_66_0_g262652 = _TransferFormValue;
					float lerpResult71_g262652 = lerp( 1.0 , temp_output_64_0_g262652 , ( temp_output_66_0_g262652 * _TransferFormMode ));
					half Normal_FormMask_Mul1708_g262645 = lerpResult71_g262652;
					half Normal_FormMask_Add1629_g262645 = ( temp_output_64_0_g262652 * temp_output_66_0_g262652 );
					half Normal_Mask1748_g262645 = saturate( ( ( Conform_Value1742_g262645 * Normal_Proj_Mask1647_g262645 * Blend_VertMask1825_g262645 * Normal_FormMask_Mul1708_g262645 ) + Normal_FormMask_Add1629_g262645 ) );
					float3 lerpResult1670_g262645 = lerp( Model_NormalOS1568_g262645 , Conform_Normal1630_g262645 , Normal_Mask1748_g262645);
					#ifdef TVE_TRANSFER
					float3 staticSwitch1716_g262645 = lerpResult1670_g262645;
					#else
					float3 staticSwitch1716_g262645 = Model_NormalOS1568_g262645;
					#endif
					half3 Final_NormalOS178_g262645 = staticSwitch1716_g262645;
					float3 temp_output_21_0_g262655 = Final_NormalOS178_g262645;
					float3 In_NormalOS16_g262655 = temp_output_21_0_g262655;
					float3 In_NormalWS16_g262655 = temp_output_1567_21_g262645;
					float3 In_NormalRawOS16_g262655 = Out_NormalRawOS15_g262654;
					half4 Model_TangentOS1749_g262645 = Out_TangentOS15_g262654;
					float4 appendResult1746_g262645 = (float4(cross( worldToObjDir1623_g262645 , float3( 0, 0, 1 ) ) , -1.0));
					half4 Conform_Tangent1747_g262645 = appendResult1746_g262645;
					float4 lerpResult1757_g262645 = lerp( Model_TangentOS1749_g262645 , Conform_Tangent1747_g262645 , Normal_Mask1748_g262645);
					#ifdef TVE_TRANSFER
					float4 staticSwitch1760_g262645 = lerpResult1757_g262645;
					#else
					float4 staticSwitch1760_g262645 = Model_TangentOS1749_g262645;
					#endif
					half4 Final_TangentOS1762_g262645 = staticSwitch1760_g262645;
					float4 temp_output_6_0_g262655 = Final_TangentOS1762_g262645;
					float4 In_TangentOS16_g262655 = temp_output_6_0_g262655;
					float3 In_TangentWS16_g262655 = Out_TangentWS15_g262654;
					float3 In_BitangentWS16_g262655 = Out_BitangentWS15_g262654;
					float3 In_ViewDirWS16_g262655 = Out_ViewDirWS15_g262654;
					float4 In_CoordsData16_g262655 = Out_CoordsData15_g262654;
					float4 In_VertexData16_g262655 = temp_output_1567_29_g262645;
					float4 In_MasksData16_g262655 = Out_MasksData15_g262654;
					float4 In_PhaseData16_g262655 = Out_PhaseData15_g262654;
					float4 In_TransformData16_g262655 = Out_TransformData15_g262654;
					float4 temp_output_1567_33_g262645 = Out_RotationData15_g262654;
					float4 In_RotationData16_g262655 = temp_output_1567_33_g262645;
					half4 Model_Interpolator01775_g262645 = Out_InterpolatorA15_g262654;
					float4 break1777_g262645 = Model_Interpolator01775_g262645;
					float4 appendResult1778_g262645 = (float4(break1777_g262645.x , break1777_g262645.y , Normal_Mask1748_g262645 , break1777_g262645.w));
					#ifdef TVE_TRANSFER
					float4 staticSwitch1779_g262645 = appendResult1778_g262645;
					#else
					float4 staticSwitch1779_g262645 = Model_Interpolator01775_g262645;
					#endif
					half4 Final_Interpolator01780_g262645 = staticSwitch1779_g262645;
					float4 In_InterpolatorA16_g262655 = Final_Interpolator01780_g262645;
					BuildModelVertData( Data16_g262655 , In_Dummy16_g262655 , In_PositionOS16_g262655 , In_PositionWS16_g262655 , In_PositionWO16_g262655 , In_PositionRawOS16_g262655 , In_PivotOS16_g262655 , In_PivotWS16_g262655 , In_PivotWO16_g262655 , In_NormalOS16_g262655 , In_NormalWS16_g262655 , In_NormalRawOS16_g262655 , In_TangentOS16_g262655 , In_TangentWS16_g262655 , In_BitangentWS16_g262655 , In_ViewDirWS16_g262655 , In_CoordsData16_g262655 , In_VertexData16_g262655 , In_MasksData16_g262655 , In_PhaseData16_g262655 , In_TransformData16_g262655 , In_RotationData16_g262655 , In_InterpolatorA16_g262655 );
					TVEModelData Data15_g262662 =(TVEModelData)Data16_g262655;
					float Out_Dummy15_g262662 = 0.0;
					float3 Out_PositionOS15_g262662 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262662 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262662 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262662 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262662 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262662 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262662 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262662 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262662 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262662 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262662 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262662 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262662 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262662 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262662 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262662 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262662 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262662 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262662 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262662 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262662 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262662 , Out_Dummy15_g262662 , Out_PositionOS15_g262662 , Out_PositionWS15_g262662 , Out_PositionWO15_g262662 , Out_PositionRawOS15_g262662 , Out_PivotOS15_g262662 , Out_PivotWS15_g262662 , Out_PivotWO15_g262662 , Out_NormalOS15_g262662 , Out_NormalWS15_g262662 , Out_NormalRawOS15_g262662 , Out_TangentOS15_g262662 , Out_TangentWS15_g262662 , Out_BitangentWS15_g262662 , Out_ViewDirWS15_g262662 , Out_CoordsData15_g262662 , Out_VertexData15_g262662 , Out_MasksData15_g262662 , Out_PhaseData15_g262662 , Out_TransformData15_g262662 , Out_RotationData15_g262662 , Out_InterpolatorA15_g262662 );
					TVEModelData Data16_g262663 =(TVEModelData)Data15_g262662;
					float temp_output_14_0_g262663 = 0.0;
					float In_Dummy16_g262663 = temp_output_14_0_g262663;
					float3 temp_output_217_24_g262661 = Out_PivotOS15_g262662;
					float3 temp_output_216_0_g262661 = ( Out_PositionOS15_g262662 + temp_output_217_24_g262661 );
					float3 temp_output_4_0_g262663 = temp_output_216_0_g262661;
					float3 In_PositionOS16_g262663 = temp_output_4_0_g262663;
					float3 In_PositionWS16_g262663 = Out_PositionWS15_g262662;
					float3 In_PositionWO16_g262663 = Out_PositionWO15_g262662;
					float3 In_PositionRawOS16_g262663 = Out_PositionRawOS15_g262662;
					float3 In_PivotOS16_g262663 = temp_output_217_24_g262661;
					float3 In_PivotWS16_g262663 = Out_PivotWS15_g262662;
					float3 In_PivotWO16_g262663 = Out_PivotWO15_g262662;
					float3 temp_output_21_0_g262663 = Out_NormalOS15_g262662;
					float3 In_NormalOS16_g262663 = temp_output_21_0_g262663;
					float3 In_NormalWS16_g262663 = Out_NormalWS15_g262662;
					float3 In_NormalRawOS16_g262663 = Out_NormalRawOS15_g262662;
					float4 temp_output_6_0_g262663 = Out_TangentOS15_g262662;
					float4 In_TangentOS16_g262663 = temp_output_6_0_g262663;
					float3 In_TangentWS16_g262663 = Out_TangentWS15_g262662;
					float3 In_BitangentWS16_g262663 = Out_BitangentWS15_g262662;
					float3 In_ViewDirWS16_g262663 = Out_ViewDirWS15_g262662;
					float4 In_CoordsData16_g262663 = Out_CoordsData15_g262662;
					float4 In_VertexData16_g262663 = Out_VertexData15_g262662;
					float4 In_MasksData16_g262663 = Out_MasksData15_g262662;
					float4 In_PhaseData16_g262663 = Out_PhaseData15_g262662;
					float4 In_TransformData16_g262663 = Out_TransformData15_g262662;
					float4 In_RotationData16_g262663 = Out_RotationData15_g262662;
					float4 In_InterpolatorA16_g262663 = Out_InterpolatorA15_g262662;
					BuildModelVertData( Data16_g262663 , In_Dummy16_g262663 , In_PositionOS16_g262663 , In_PositionWS16_g262663 , In_PositionWO16_g262663 , In_PositionRawOS16_g262663 , In_PivotOS16_g262663 , In_PivotWS16_g262663 , In_PivotWO16_g262663 , In_NormalOS16_g262663 , In_NormalWS16_g262663 , In_NormalRawOS16_g262663 , In_TangentOS16_g262663 , In_TangentWS16_g262663 , In_BitangentWS16_g262663 , In_ViewDirWS16_g262663 , In_CoordsData16_g262663 , In_VertexData16_g262663 , In_MasksData16_g262663 , In_PhaseData16_g262663 , In_TransformData16_g262663 , In_RotationData16_g262663 , In_InterpolatorA16_g262663 );
					TVEModelData Data15_g262710 =(TVEModelData)Data16_g262663;
					float Out_Dummy15_g262710 = 0.0;
					float3 Out_PositionOS15_g262710 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262710 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262710 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262710 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262710 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262710 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262710 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262710 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262710 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262710 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262710 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262710 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262710 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262710 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262710 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262710 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262710 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262710 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262710 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262710 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262710 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262710 , Out_Dummy15_g262710 , Out_PositionOS15_g262710 , Out_PositionWS15_g262710 , Out_PositionWO15_g262710 , Out_PositionRawOS15_g262710 , Out_PivotOS15_g262710 , Out_PivotWS15_g262710 , Out_PivotWO15_g262710 , Out_NormalOS15_g262710 , Out_NormalWS15_g262710 , Out_NormalRawOS15_g262710 , Out_TangentOS15_g262710 , Out_TangentWS15_g262710 , Out_BitangentWS15_g262710 , Out_ViewDirWS15_g262710 , Out_CoordsData15_g262710 , Out_VertexData15_g262710 , Out_MasksData15_g262710 , Out_PhaseData15_g262710 , Out_TransformData15_g262710 , Out_RotationData15_g262710 , Out_InterpolatorA15_g262710 );
					
					float3 ifLocalVar40_g262666 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g262666 = saturate( v.vertex.xyz );
					float3 ifLocalVar40_g262667 = 0;
					if( TVE_DEBUG_Index == 1.0 )
					ifLocalVar40_g262667 = saturate( v.normal );
					float3 ifLocalVar40_g262668 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g262668 = saturate( v.tangent.xyz );
					TVEModelData Data15_g262665 =(TVEModelData)Data16_g262663;
					float Out_Dummy15_g262665 = 0.0;
					float3 Out_PositionOS15_g262665 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262665 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262665 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262665 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262665 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262665 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262665 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262665 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262665 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262665 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262665 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262665 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262665 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262665 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262665 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262665 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262665 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262665 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262665 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262665 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262665 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262665 , Out_Dummy15_g262665 , Out_PositionOS15_g262665 , Out_PositionWS15_g262665 , Out_PositionWO15_g262665 , Out_PositionRawOS15_g262665 , Out_PivotOS15_g262665 , Out_PivotWS15_g262665 , Out_PivotWO15_g262665 , Out_NormalOS15_g262665 , Out_NormalWS15_g262665 , Out_NormalRawOS15_g262665 , Out_TangentOS15_g262665 , Out_TangentWS15_g262665 , Out_BitangentWS15_g262665 , Out_ViewDirWS15_g262665 , Out_CoordsData15_g262665 , Out_VertexData15_g262665 , Out_MasksData15_g262665 , Out_PhaseData15_g262665 , Out_TransformData15_g262665 , Out_RotationData15_g262665 , Out_InterpolatorA15_g262665 );
					float3 ifLocalVar40_g262681 = 0;
					if( TVE_DEBUG_Index == 3.0 )
					ifLocalVar40_g262681 = saturate( Out_PivotOS15_g262665 );
					float3 ifLocalVar40_g262669 = 0;
					if( TVE_DEBUG_Index == 5.0 )
					ifLocalVar40_g262669 = saturate( Out_PositionOS15_g262665 );
					float3 ifLocalVar40_g262671 = 0;
					if( TVE_DEBUG_Index == 6.0 )
					ifLocalVar40_g262671 = saturate( Out_NormalOS15_g262665 );
					float3 ifLocalVar40_g262670 = 0;
					if( TVE_DEBUG_Index == 7.0 )
					ifLocalVar40_g262670 = (Out_TangentOS15_g262665).xyz;
					float4 temp_output_2671_29 = Out_VertexData15_g262665;
					float3 ifLocalVar40_g262672 = 0;
					if( TVE_DEBUG_Index == 9.0 )
					ifLocalVar40_g262672 = (temp_output_2671_29).xxx;
					float3 ifLocalVar40_g262673 = 0;
					if( TVE_DEBUG_Index == 10.0 )
					ifLocalVar40_g262673 = (temp_output_2671_29).yyy;
					float3 ifLocalVar40_g262674 = 0;
					if( TVE_DEBUG_Index == 11.0 )
					ifLocalVar40_g262674 = (temp_output_2671_29).zzz;
					float3 ifLocalVar40_g262675 = 0;
					if( TVE_DEBUG_Index == 12.0 )
					ifLocalVar40_g262675 = (temp_output_2671_29).www;
					float4 temp_output_2671_30 = Out_MasksData15_g262665;
					float3 ifLocalVar40_g262676 = 0;
					if( TVE_DEBUG_Index == 14.0 )
					ifLocalVar40_g262676 = (temp_output_2671_30).xxx;
					float3 ifLocalVar40_g262677 = 0;
					if( TVE_DEBUG_Index == 15.0 )
					ifLocalVar40_g262677 = (temp_output_2671_30).yyy;
					float4 temp_output_2671_38 = Out_CoordsData15_g262665;
					float3 appendResult2701 = (float3((temp_output_2671_38).xy , 0.0));
					float3 ifLocalVar40_g262678 = 0;
					if( TVE_DEBUG_Index == 17.0 )
					ifLocalVar40_g262678 = appendResult2701;
					float3 appendResult2702 = (float3((v.texcoord1.xyzw.xy).xy , 0.0));
					float3 ifLocalVar40_g262679 = 0;
					if( TVE_DEBUG_Index == 18.0 )
					ifLocalVar40_g262679 = appendResult2702;
					float3 appendResult2706 = (float3((temp_output_2671_38).xy , 0.0));
					float3 ifLocalVar40_g262680 = 0;
					if( TVE_DEBUG_Index == 19.0 )
					ifLocalVar40_g262680 = appendResult2706;
					float3 vertexToFrag2524 = ( ( ifLocalVar40_g262666 + ifLocalVar40_g262667 + ifLocalVar40_g262668 + ifLocalVar40_g262681 ) + ( ifLocalVar40_g262669 + ifLocalVar40_g262671 + ifLocalVar40_g262670 ) + ( ifLocalVar40_g262672 + ifLocalVar40_g262673 + ifLocalVar40_g262674 + ifLocalVar40_g262675 ) + ( ifLocalVar40_g262676 + ifLocalVar40_g262677 ) + ( ifLocalVar40_g262678 + ifLocalVar40_g262679 + ifLocalVar40_g262680 ) );
					o.ase_texcoord6.xyz = vertexToFrag2524;
					float3 vertexPos57_g262704 = v.vertex.xyz;
					float4 ase_positionCS57_g262704 = UnityObjectToClipPos( vertexPos57_g262704 );
					o.ase_texcoord7 = ase_positionCS57_g262704;
					o.ase_texcoord11.xyz = vertexToFrag73_g262421;
					o.ase_texcoord12.xyz = vertexToFrag76_g262421;
					
					o.ase_texcoord8 = v.vertex;
					o.ase_normal = v.normal;
					o.ase_tangent = v.tangent;
					o.ase_texcoord9 = v.texcoord.xyzw;
					o.ase_texcoord10.xy = v.texcoord2.xyzw.xy;
					o.ase_color = v.ase_color;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord6.w = 0;
					o.ase_texcoord10.zw = 0;
					o.ase_texcoord11.w = 0;
					o.ase_texcoord12.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g262710;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g262710;
					v.tangent = Out_TangentOS15_g262710;

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

					float temp_output_2720_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2720_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2720_114).xxx;
					
					float3 color130_g262704 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g262704 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g262706 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g262705 = ( temp_cast_4 * ( 0.5 + appendResult128_g262706 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g262705 = (float4(ddx( FinalUV13_g262705 ) , ddy( FinalUV13_g262705 )));
					float4 UVDerivatives17_g262705 = appendResult16_g262705;
					float4 break28_g262705 = UVDerivatives17_g262705;
					float2 appendResult19_g262705 = (float2(break28_g262705.x , break28_g262705.z));
					float2 appendResult20_g262705 = (float2(break28_g262705.x , break28_g262705.z));
					float dotResult24_g262705 = dot( appendResult19_g262705 , appendResult20_g262705 );
					float2 appendResult21_g262705 = (float2(break28_g262705.y , break28_g262705.w));
					float2 appendResult22_g262705 = (float2(break28_g262705.y , break28_g262705.w));
					float dotResult23_g262705 = dot( appendResult21_g262705 , appendResult22_g262705 );
					float2 appendResult25_g262705 = (float2(dotResult24_g262705 , dotResult23_g262705));
					float2 derivativesLength29_g262705 = sqrt( appendResult25_g262705 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g262705 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g262705 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g262705 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g262705 = clampResult57_g262705;
					float2 break55_g262705 = derivativesLength29_g262705;
					float4 lerpResult73_g262705 = lerp( float4( color130_g262704 , 0.0 ) , float4( color81_g262704 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g262705.x * break71_g262705.y * sqrt( saturate( ( 1.1 - max( break55_g262705.x, break55_g262705.y ) ) ) ) ) ) ));
					float3 vertexToFrag2524 = IN.ase_texcoord6.xyz;
					half3 Final_Debug2399 = vertexToFrag2524;
					float temp_output_7_0_g262712 = TVE_DEBUG_Min;
					float3 temp_cast_9 = (temp_output_7_0_g262712).xxx;
					float3 temp_output_9_0_g262712 = ( Final_Debug2399 - temp_cast_9 );
					float lerpResult76_g262704 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g262704 = lerpResult76_g262704;
					float3 lerpResult72_g262704 = lerp( (lerpResult73_g262705).rgb , saturate( ( temp_output_9_0_g262712 / ( ( TVE_DEBUG_Max - temp_output_7_0_g262712 ) + 0.0001 ) ) ) , Filter152_g262704);
					float dotResult61_g262704 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g262704 = ( 1.0 - saturate( dotResult61_g262704 ) );
					float Shading_Fresnel59_g262704 = (( 1.0 - ( temp_output_65_0_g262704 * temp_output_65_0_g262704 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g262704 = IN.ase_texcoord7;
					float depthLinearEye57_g262704 = LinearEyeDepth( ase_positionCS57_g262704.z / ase_positionCS57_g262704.w );
					float temp_output_69_0_g262704 = saturate(  (0.0 + ( depthLinearEye57_g262704 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g262704 = (( temp_output_69_0_g262704 * temp_output_69_0_g262704 )*0.5 + 0.5);
					float lerpResult84_g262704 = lerp( 1.0 , Shading_Fresnel59_g262704 , ( Shading_Distance58_g262704 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g262709 = ( 0.0 );
					float localBuildVisualData3_g262683 = ( 0.0 );
					TVEVisualData Data3_g262683 =(TVEVisualData)0;
					half4 Dummy130_g262682 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) );
					float temp_output_14_0_g262683 = Dummy130_g262682.x;
					float In_Dummy3_g262683 = temp_output_14_0_g262683;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g262702) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g262697 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g262697 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g262697 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g262697 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g262697 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g262697 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g262702 = staticSwitch36_g262697;
					float localBreakTextureData456_g262702 = ( 0.0 );
					float localBuildTextureData431_g262696 = ( 0.0 );
					TVEMasksData Data431_g262696 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g262696 = ( 0.0 );
					half4 Local_Coords180_g262682 = _main_coord_value;
					float4 Coords444_g262696 = Local_Coords180_g262682;
					float localIfModelDataByShader26_g262420 = ( 0.0 );
					TVEModelData Data26_g262420 = (TVEModelData)0;
					TVEModelData Data16_g241828 =(TVEModelData)0;
					half Dummy207_g241818 = 0.0;
					float temp_output_14_0_g241828 = Dummy207_g241818;
					float In_Dummy16_g241828 = temp_output_14_0_g241828;
					float3 PositionOS131_g241818 = IN.ase_texcoord8.xyz;
					float3 temp_output_4_0_g241828 = PositionOS131_g241818;
					float3 In_PositionOS16_g241828 = temp_output_4_0_g241828;
					float3 temp_output_104_7_g241818 = PositionWS;
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
					float3 _Vector0 = float3(0,0,0);
					float3 PivotOS149_g241818 = _Vector0;
					float3 In_PivotOS16_g241828 = PivotOS149_g241818;
					float3 In_PivotWS16_g241828 = PivotWS121_g241818;
					float3 PivotWO133_g241818 = ( PivotWS121_g241818 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241828 = PivotWO133_g241818;
					half3 NormalOS134_g241818 = IN.ase_normal;
					float3 temp_output_21_0_g241828 = NormalOS134_g241818;
					float3 In_NormalOS16_g241828 = temp_output_21_0_g241828;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g241818 = normalizedWorldNormal;
					float3 In_NormalWS16_g241828 = NormalWS95_g241818;
					float3 In_NormalRawOS16_g241828 = NormalOS134_g241818;
					half4 TangentlOS153_g241818 = IN.ase_tangent;
					float4 temp_output_6_0_g241828 = TangentlOS153_g241818;
					float4 In_TangentOS16_g241828 = temp_output_6_0_g241828;
					half3 TangentWS136_g241818 = TangentWS;
					float3 In_TangentWS16_g241828 = TangentWS136_g241818;
					half3 BiangentWS421_g241818 = BitangentWS;
					float3 In_BitangentWS16_g241828 = BiangentWS421_g241818;
					float3 normalizeResult296_g241818 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241818 ) );
					half3 ViewDirWS169_g241818 = normalizeResult296_g241818;
					float3 In_ViewDirWS16_g241828 = ViewDirWS169_g241818;
					float4 appendResult397_g241818 = (float4(IN.ase_texcoord9.xy , IN.ase_texcoord10.xy));
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
					TVEModelData DataDefault26_g262420 = Data16_g241828;
					TVEModelData Data16_g262429 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g262429 = 0.0;
					float3 vertexToFrag73_g262421 = IN.ase_texcoord11.xyz;
					float3 PositionWS122_g262421 = vertexToFrag73_g262421;
					float3 In_PositionWS16_g262429 = PositionWS122_g262421;
					float3 vertexToFrag76_g262421 = IN.ase_texcoord12.xyz;
					float3 PivotWS121_g262421 = vertexToFrag76_g262421;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g262421 = ( PositionWS122_g262421 - PivotWS121_g262421 );
					#else
					float3 staticSwitch204_g262421 = PositionWS122_g262421;
					#endif
					float3 PositionWO132_g262421 = ( staticSwitch204_g262421 - TVE_WorldOrigin );
					float3 In_PositionWO16_g262429 = PositionWO132_g262421;
					float3 In_PivotWS16_g262429 = PivotWS121_g262421;
					float3 PivotWO133_g262421 = ( PivotWS121_g262421 - TVE_WorldOrigin );
					float3 In_PivotWO16_g262429 = PivotWO133_g262421;
					half3 NormalWS95_g262421 = normalizedWorldNormal;
					float3 In_NormalWS16_g262429 = NormalWS95_g262421;
					half3 TangentWS136_g262421 = TangentWS;
					float3 In_TangentWS16_g262429 = TangentWS136_g262421;
					half3 BiangentWS421_g262421 = BitangentWS;
					float3 In_BitangentWS16_g262429 = BiangentWS421_g262421;
					half3 NormalWS427_g262421 = NormalWS95_g262421;
					half3 localComputeTriplanarWeights427_g262421 = ComputeTriplanarWeights( NormalWS427_g262421 );
					half3 TriplanarWeights429_g262421 = localComputeTriplanarWeights427_g262421;
					float3 In_TriplanarWeights16_g262429 = TriplanarWeights429_g262421;
					float3 normalizeResult296_g262421 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g262421 ) );
					half3 ViewDirWS169_g262421 = normalizeResult296_g262421;
					float3 In_ViewDirWS16_g262429 = ViewDirWS169_g262421;
					float4 appendResult397_g262421 = (float4(IN.ase_texcoord9.xy , IN.ase_texcoord10.xy));
					float4 CoordsData398_g262421 = appendResult397_g262421;
					float4 In_CoordsData16_g262429 = CoordsData398_g262421;
					half4 VertexMasks171_g262421 = IN.ase_color;
					float4 In_VertexData16_g262429 = VertexMasks171_g262421;
					float temp_output_17_0_g262433 = _ObjectPhaseMode;
					float Option70_g262433 = temp_output_17_0_g262433;
					float4 temp_output_3_0_g262433 = IN.ase_color;
					float4 Channel70_g262433 = temp_output_3_0_g262433;
					float localSwitchChannel470_g262433 = SwitchChannel4( Option70_g262433 , Channel70_g262433 );
					half Phase_Value372_g262421 = localSwitchChannel470_g262433;
					float3 break319_g262421 = PivotWO133_g262421;
					half Pivot_Position322_g262421 = ( break319_g262421.x + break319_g262421.z );
					half Phase_Position357_g262421 = ( Phase_Value372_g262421 + Pivot_Position322_g262421 );
					float temp_output_248_0_g262421 = frac( Phase_Position357_g262421 );
					float4 appendResult177_g262421 = (float4(( (frac( ( Phase_Position357_g262421 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g262421));
					half4 Phase_Data176_g262421 = appendResult177_g262421;
					float4 In_PhaseData16_g262429 = Phase_Data176_g262421;
					BuildModelFragData( Data16_g262429 , In_Dummy16_g262429 , In_PositionWS16_g262429 , In_PositionWO16_g262429 , In_PivotWS16_g262429 , In_PivotWO16_g262429 , In_NormalWS16_g262429 , In_TangentWS16_g262429 , In_BitangentWS16_g262429 , In_TriplanarWeights16_g262429 , In_ViewDirWS16_g262429 , In_CoordsData16_g262429 , In_VertexData16_g262429 , In_PhaseData16_g262429 );
					TVEModelData DataGeneral26_g262420 = Data16_g262429;
					TVEModelData DataBlanket26_g262420 = Data16_g262429;
					TVEModelData DataImpostor26_g262420 = Data16_g262429;
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
					TVEModelData DataTerrain26_g262420 = Data16_g241826;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g262420 = IsShaderType2637;
					{
					if (Type26_g262420 == 0 )
					{
					Data26_g262420 = DataDefault26_g262420;
					}
					else if (Type26_g262420 == 1 )
					{
					Data26_g262420 = DataGeneral26_g262420;
					}
					else if (Type26_g262420 == 2 )
					{
					Data26_g262420 = DataBlanket26_g262420;
					}
					else if (Type26_g262420 == 3 )
					{
					Data26_g262420 = DataImpostor26_g262420;
					}
					else if (Type26_g262420 == 4 )
					{
					Data26_g262420 = DataTerrain26_g262420;
					}
					}
					TVEModelData Data15_g262695 =(TVEModelData)Data26_g262420;
					float Out_Dummy15_g262695 = 0.0;
					float3 Out_PositionWS15_g262695 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262695 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262695 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262695 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262695 = float3( 0,0,0 );
					float3 Out_TangentWS15_g262695 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262695 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g262695 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262695 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262695 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262695 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262695 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g262695 , Out_Dummy15_g262695 , Out_PositionWS15_g262695 , Out_PositionWO15_g262695 , Out_PivotWS15_g262695 , Out_PivotWO15_g262695 , Out_NormalWS15_g262695 , Out_TangentWS15_g262695 , Out_BitangentWS15_g262695 , Out_TriplanarWeights15_g262695 , Out_ViewDirWS15_g262695 , Out_CoordsData15_g262695 , Out_VertexData15_g262695 , Out_PhaseData15_g262695 );
					float4 Model_CoordsData324_g262682 = Out_CoordsData15_g262695;
					float4 MeshCoords444_g262696 = Model_CoordsData324_g262682;
					float2 UV0444_g262696 = float2( 0,0 );
					float2 UV3444_g262696 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g262696 , MeshCoords444_g262696 , UV0444_g262696 , UV3444_g262696 );
					float4 appendResult430_g262696 = (float4(UV0444_g262696 , UV3444_g262696));
					float4 In_MaskA431_g262696 = appendResult430_g262696;
					float localComputeWorldCoords315_g262696 = ( 0.0 );
					float4 Coords315_g262696 = Local_Coords180_g262682;
					float3 Model_PositionWO222_g262682 = Out_PositionWO15_g262695;
					float3 PositionWS315_g262696 = Model_PositionWO222_g262682;
					float2 ZY315_g262696 = float2( 0,0 );
					float2 XZ315_g262696 = float2( 0,0 );
					float2 XY315_g262696 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g262696 , PositionWS315_g262696 , ZY315_g262696 , XZ315_g262696 , XY315_g262696 );
					float2 ZY402_g262696 = ZY315_g262696;
					float2 XZ403_g262696 = XZ315_g262696;
					float4 appendResult432_g262696 = (float4(ZY402_g262696 , XZ403_g262696));
					float4 In_MaskB431_g262696 = appendResult432_g262696;
					float2 XY404_g262696 = XY315_g262696;
					float localComputeStochasticCoords409_g262696 = ( 0.0 );
					float2 UV409_g262696 = ZY402_g262696;
					float2 UV1409_g262696 = float2( 0,0 );
					float2 UV2409_g262696 = float2( 0,0 );
					float2 UV3409_g262696 = float2( 0,0 );
					float3 Weights409_g262696 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g262696 , UV1409_g262696 , UV2409_g262696 , UV3409_g262696 , Weights409_g262696 );
					float4 appendResult433_g262696 = (float4(XY404_g262696 , UV1409_g262696));
					float4 In_MaskC431_g262696 = appendResult433_g262696;
					float4 appendResult434_g262696 = (float4(UV2409_g262696 , UV3409_g262696));
					float4 In_MaskD431_g262696 = appendResult434_g262696;
					float localComputeStochasticCoords422_g262696 = ( 0.0 );
					float2 UV422_g262696 = XZ403_g262696;
					float2 UV1422_g262696 = float2( 0,0 );
					float2 UV2422_g262696 = float2( 0,0 );
					float2 UV3422_g262696 = float2( 0,0 );
					float3 Weights422_g262696 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g262696 , UV1422_g262696 , UV2422_g262696 , UV3422_g262696 , Weights422_g262696 );
					float4 appendResult435_g262696 = (float4(UV1422_g262696 , UV2422_g262696));
					float4 In_MaskE431_g262696 = appendResult435_g262696;
					float localComputeStochasticCoords423_g262696 = ( 0.0 );
					float2 UV423_g262696 = XY404_g262696;
					float2 UV1423_g262696 = float2( 0,0 );
					float2 UV2423_g262696 = float2( 0,0 );
					float2 UV3423_g262696 = float2( 0,0 );
					float3 Weights423_g262696 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g262696 , UV1423_g262696 , UV2423_g262696 , UV3423_g262696 , Weights423_g262696 );
					float4 appendResult436_g262696 = (float4(UV3422_g262696 , UV1423_g262696));
					float4 In_MaskF431_g262696 = appendResult436_g262696;
					float4 appendResult437_g262696 = (float4(UV2423_g262696 , UV3423_g262696));
					float4 In_MaskG431_g262696 = appendResult437_g262696;
					float4 In_MaskH431_g262696 = float4( Weights409_g262696 , 0.0 );
					float4 In_MaskI431_g262696 = float4( Weights422_g262696 , 0.0 );
					float4 In_MaskJ431_g262696 = float4( Weights423_g262696 , 0.0 );
					half3 Model_NormalWS226_g262682 = Out_NormalWS15_g262695;
					float3 temp_output_449_0_g262696 = Model_NormalWS226_g262682;
					float4 In_MaskK431_g262696 = float4( temp_output_449_0_g262696 , 0.0 );
					half3 Model_TangentWS366_g262682 = Out_TangentWS15_g262695;
					float3 temp_output_450_0_g262696 = Model_TangentWS366_g262682;
					float4 In_MaskL431_g262696 = float4( temp_output_450_0_g262696 , 0.0 );
					half3 Model_BitangentWS367_g262682 = Out_BitangentWS15_g262695;
					float3 temp_output_451_0_g262696 = Model_BitangentWS367_g262682;
					float4 In_MaskM431_g262696 = float4( temp_output_451_0_g262696 , 0.0 );
					half3 Model_TriplanarWeights368_g262682 = Out_TriplanarWeights15_g262695;
					float3 temp_output_445_0_g262696 = Model_TriplanarWeights368_g262682;
					float4 In_MaskN431_g262696 = float4( temp_output_445_0_g262696 , 0.0 );
					BuildTextureData( Data431_g262696 , In_MaskA431_g262696 , In_MaskB431_g262696 , In_MaskC431_g262696 , In_MaskD431_g262696 , In_MaskE431_g262696 , In_MaskF431_g262696 , In_MaskG431_g262696 , In_MaskH431_g262696 , In_MaskI431_g262696 , In_MaskJ431_g262696 , In_MaskK431_g262696 , In_MaskL431_g262696 , In_MaskM431_g262696 , In_MaskN431_g262696 );
					TVEMasksData Data456_g262702 =(TVEMasksData)Data431_g262696;
					float4 Out_MaskA456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g262702 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g262702 , Out_MaskA456_g262702 , Out_MaskB456_g262702 , Out_MaskC456_g262702 , Out_MaskD456_g262702 , Out_MaskE456_g262702 , Out_MaskF456_g262702 , Out_MaskG456_g262702 , Out_MaskH456_g262702 , Out_MaskI456_g262702 , Out_MaskJ456_g262702 , Out_MaskK456_g262702 , Out_MaskL456_g262702 , Out_MaskM456_g262702 , Out_MaskN456_g262702 );
					half2 UV276_g262702 = (Out_MaskA456_g262702).xy;
					float temp_output_504_0_g262702 = 0.0;
					half Bias276_g262702 = temp_output_504_0_g262702;
					half2 Normal276_g262702 = float2( 0,0 );
					half4 localSampleCoord276_g262702 = SampleCoord( Texture276_g262702 , Sampler276_g262702 , UV276_g262702 , Bias276_g262702 , Normal276_g262702 );
					float4 temp_output_407_277_g262682 = localSampleCoord276_g262702;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g262702) = _MainAlbedoTex;
					SamplerState Sampler502_g262702 = staticSwitch36_g262697;
					half2 UV502_g262702 = (Out_MaskA456_g262702).zw;
					half Bias502_g262702 = temp_output_504_0_g262702;
					half2 Normal502_g262702 = float2( 0,0 );
					half4 localSampleCoord502_g262702 = SampleCoord( Texture502_g262702 , Sampler502_g262702 , UV502_g262702 , Bias502_g262702 , Normal502_g262702 );
					float4 temp_output_407_278_g262682 = localSampleCoord502_g262702;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g262702) = _MainAlbedoTex;
					SamplerState Sampler496_g262702 = staticSwitch36_g262697;
					float2 temp_output_463_0_g262702 = (Out_MaskB456_g262702).zw;
					half2 XZ496_g262702 = temp_output_463_0_g262702;
					half Bias496_g262702 = temp_output_504_0_g262702;
					float3 temp_output_483_0_g262702 = (Out_MaskK456_g262702).xyz;
					half3 NormalWS496_g262702 = temp_output_483_0_g262702;
					half3 Normal496_g262702 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g262702 = SamplePlanar2D( Texture496_g262702 , Sampler496_g262702 , XZ496_g262702 , Bias496_g262702 , NormalWS496_g262702 , Normal496_g262702 );
					float4 temp_output_407_0_g262682 = localSamplePlanar2D496_g262702;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g262702) = _MainAlbedoTex;
					SamplerState Sampler490_g262702 = staticSwitch36_g262697;
					float2 temp_output_462_0_g262702 = (Out_MaskB456_g262702).xy;
					half2 ZY490_g262702 = temp_output_462_0_g262702;
					half2 XZ490_g262702 = temp_output_463_0_g262702;
					float2 temp_output_464_0_g262702 = (Out_MaskC456_g262702).xy;
					half2 XY490_g262702 = temp_output_464_0_g262702;
					half Bias490_g262702 = temp_output_504_0_g262702;
					float3 temp_output_482_0_g262702 = (Out_MaskN456_g262702).xyz;
					half3 Triplanar490_g262702 = temp_output_482_0_g262702;
					half3 NormalWS490_g262702 = temp_output_483_0_g262702;
					half3 Normal490_g262702 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g262702 = SamplePlanar3D( Texture490_g262702 , Sampler490_g262702 , ZY490_g262702 , XZ490_g262702 , XY490_g262702 , Bias490_g262702 , Triplanar490_g262702 , NormalWS490_g262702 , Normal490_g262702 );
					float4 temp_output_407_201_g262682 = localSamplePlanar3D490_g262702;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g262702) = _MainAlbedoTex;
					SamplerState Sampler498_g262702 = staticSwitch36_g262697;
					half2 XZ498_g262702 = temp_output_463_0_g262702;
					float2 temp_output_473_0_g262702 = (Out_MaskE456_g262702).xy;
					half2 XZ_1498_g262702 = temp_output_473_0_g262702;
					float2 temp_output_474_0_g262702 = (Out_MaskE456_g262702).zw;
					half2 XZ_2498_g262702 = temp_output_474_0_g262702;
					float2 temp_output_475_0_g262702 = (Out_MaskF456_g262702).xy;
					half2 XZ_3498_g262702 = temp_output_475_0_g262702;
					float temp_output_510_0_g262702 = exp2( temp_output_504_0_g262702 );
					half Bias498_g262702 = temp_output_510_0_g262702;
					float3 temp_output_480_0_g262702 = (Out_MaskI456_g262702).xyz;
					half3 Weights_2498_g262702 = temp_output_480_0_g262702;
					half3 NormalWS498_g262702 = temp_output_483_0_g262702;
					half3 Normal498_g262702 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g262702 = SampleStochastic2D( Texture498_g262702 , Sampler498_g262702 , XZ498_g262702 , XZ_1498_g262702 , XZ_2498_g262702 , XZ_3498_g262702 , Bias498_g262702 , Weights_2498_g262702 , NormalWS498_g262702 , Normal498_g262702 );
					float4 temp_output_407_202_g262682 = localSampleStochastic2D498_g262702;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g262702) = _MainAlbedoTex;
					SamplerState Sampler500_g262702 = staticSwitch36_g262697;
					half2 ZY500_g262702 = temp_output_462_0_g262702;
					half2 ZY_1500_g262702 = (Out_MaskC456_g262702).zw;
					half2 ZY_2500_g262702 = (Out_MaskD456_g262702).xy;
					half2 ZY_3500_g262702 = (Out_MaskD456_g262702).zw;
					half2 XZ500_g262702 = temp_output_463_0_g262702;
					half2 XZ_1500_g262702 = temp_output_473_0_g262702;
					half2 XZ_2500_g262702 = temp_output_474_0_g262702;
					half2 XZ_3500_g262702 = temp_output_475_0_g262702;
					half2 XY500_g262702 = temp_output_464_0_g262702;
					half2 XY_1500_g262702 = (Out_MaskF456_g262702).zw;
					half2 XY_2500_g262702 = (Out_MaskG456_g262702).xy;
					half2 XY_3500_g262702 = (Out_MaskG456_g262702).zw;
					half Bias500_g262702 = temp_output_510_0_g262702;
					half3 Weights_1500_g262702 = (Out_MaskH456_g262702).xyz;
					half3 Weights_2500_g262702 = temp_output_480_0_g262702;
					half3 Weights_3500_g262702 = (Out_MaskJ456_g262702).xyz;
					half3 Triplanar500_g262702 = temp_output_482_0_g262702;
					half3 NormalWS500_g262702 = temp_output_483_0_g262702;
					half3 Normal500_g262702 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g262702 = SampleStochastic3D( Texture500_g262702 , Sampler500_g262702 , ZY500_g262702 , ZY_1500_g262702 , ZY_2500_g262702 , ZY_3500_g262702 , XZ500_g262702 , XZ_1500_g262702 , XZ_2500_g262702 , XZ_3500_g262702 , XY500_g262702 , XY_1500_g262702 , XY_2500_g262702 , XY_3500_g262702 , Bias500_g262702 , Weights_1500_g262702 , Weights_2500_g262702 , Weights_3500_g262702 , Triplanar500_g262702 , NormalWS500_g262702 , Normal500_g262702 );
					float4 temp_output_407_203_g262682 = localSampleStochastic3D500_g262702;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g262682 = temp_output_407_277_g262682;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g262682 = temp_output_407_278_g262682;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g262682 = temp_output_407_0_g262682;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g262682 = temp_output_407_201_g262682;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g262682 = temp_output_407_202_g262682;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g262682 = temp_output_407_203_g262682;
					#else
					float4 staticSwitch184_g262682 = temp_output_407_277_g262682;
					#endif
					half4 Local_AlbedoSample185_g262682 = staticSwitch184_g262682;
					float3 lerpResult53_g262682 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g262682).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g262682 = lerpResult53_g262682;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g262700) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g262699 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g262699 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g262699 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g262699 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g262699 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g262699 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g262700 = staticSwitch38_g262699;
					float localBreakTextureData456_g262700 = ( 0.0 );
					TVEMasksData Data456_g262700 =(TVEMasksData)Data431_g262696;
					float4 Out_MaskA456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g262700 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g262700 , Out_MaskA456_g262700 , Out_MaskB456_g262700 , Out_MaskC456_g262700 , Out_MaskD456_g262700 , Out_MaskE456_g262700 , Out_MaskF456_g262700 , Out_MaskG456_g262700 , Out_MaskH456_g262700 , Out_MaskI456_g262700 , Out_MaskJ456_g262700 , Out_MaskK456_g262700 , Out_MaskL456_g262700 , Out_MaskM456_g262700 , Out_MaskN456_g262700 );
					half2 UV276_g262700 = (Out_MaskA456_g262700).xy;
					float temp_output_504_0_g262700 = 0.0;
					half Bias276_g262700 = temp_output_504_0_g262700;
					half2 Normal276_g262700 = float2( 0,0 );
					half4 localSampleCoord276_g262700 = SampleCoord( Texture276_g262700 , Sampler276_g262700 , UV276_g262700 , Bias276_g262700 , Normal276_g262700 );
					float4 temp_output_405_277_g262682 = localSampleCoord276_g262700;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g262700) = _MainShaderTex;
					SamplerState Sampler502_g262700 = staticSwitch38_g262699;
					half2 UV502_g262700 = (Out_MaskA456_g262700).zw;
					half Bias502_g262700 = temp_output_504_0_g262700;
					half2 Normal502_g262700 = float2( 0,0 );
					half4 localSampleCoord502_g262700 = SampleCoord( Texture502_g262700 , Sampler502_g262700 , UV502_g262700 , Bias502_g262700 , Normal502_g262700 );
					float4 temp_output_405_278_g262682 = localSampleCoord502_g262700;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g262700) = _MainShaderTex;
					SamplerState Sampler496_g262700 = staticSwitch38_g262699;
					float2 temp_output_463_0_g262700 = (Out_MaskB456_g262700).zw;
					half2 XZ496_g262700 = temp_output_463_0_g262700;
					half Bias496_g262700 = temp_output_504_0_g262700;
					float3 temp_output_483_0_g262700 = (Out_MaskK456_g262700).xyz;
					half3 NormalWS496_g262700 = temp_output_483_0_g262700;
					half3 Normal496_g262700 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g262700 = SamplePlanar2D( Texture496_g262700 , Sampler496_g262700 , XZ496_g262700 , Bias496_g262700 , NormalWS496_g262700 , Normal496_g262700 );
					float4 temp_output_405_0_g262682 = localSamplePlanar2D496_g262700;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g262700) = _MainShaderTex;
					SamplerState Sampler490_g262700 = staticSwitch38_g262699;
					float2 temp_output_462_0_g262700 = (Out_MaskB456_g262700).xy;
					half2 ZY490_g262700 = temp_output_462_0_g262700;
					half2 XZ490_g262700 = temp_output_463_0_g262700;
					float2 temp_output_464_0_g262700 = (Out_MaskC456_g262700).xy;
					half2 XY490_g262700 = temp_output_464_0_g262700;
					half Bias490_g262700 = temp_output_504_0_g262700;
					float3 temp_output_482_0_g262700 = (Out_MaskN456_g262700).xyz;
					half3 Triplanar490_g262700 = temp_output_482_0_g262700;
					half3 NormalWS490_g262700 = temp_output_483_0_g262700;
					half3 Normal490_g262700 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g262700 = SamplePlanar3D( Texture490_g262700 , Sampler490_g262700 , ZY490_g262700 , XZ490_g262700 , XY490_g262700 , Bias490_g262700 , Triplanar490_g262700 , NormalWS490_g262700 , Normal490_g262700 );
					float4 temp_output_405_201_g262682 = localSamplePlanar3D490_g262700;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g262700) = _MainShaderTex;
					SamplerState Sampler498_g262700 = staticSwitch38_g262699;
					half2 XZ498_g262700 = temp_output_463_0_g262700;
					float2 temp_output_473_0_g262700 = (Out_MaskE456_g262700).xy;
					half2 XZ_1498_g262700 = temp_output_473_0_g262700;
					float2 temp_output_474_0_g262700 = (Out_MaskE456_g262700).zw;
					half2 XZ_2498_g262700 = temp_output_474_0_g262700;
					float2 temp_output_475_0_g262700 = (Out_MaskF456_g262700).xy;
					half2 XZ_3498_g262700 = temp_output_475_0_g262700;
					float temp_output_510_0_g262700 = exp2( temp_output_504_0_g262700 );
					half Bias498_g262700 = temp_output_510_0_g262700;
					float3 temp_output_480_0_g262700 = (Out_MaskI456_g262700).xyz;
					half3 Weights_2498_g262700 = temp_output_480_0_g262700;
					half3 NormalWS498_g262700 = temp_output_483_0_g262700;
					half3 Normal498_g262700 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g262700 = SampleStochastic2D( Texture498_g262700 , Sampler498_g262700 , XZ498_g262700 , XZ_1498_g262700 , XZ_2498_g262700 , XZ_3498_g262700 , Bias498_g262700 , Weights_2498_g262700 , NormalWS498_g262700 , Normal498_g262700 );
					float4 temp_output_405_202_g262682 = localSampleStochastic2D498_g262700;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g262700) = _MainShaderTex;
					SamplerState Sampler500_g262700 = staticSwitch38_g262699;
					half2 ZY500_g262700 = temp_output_462_0_g262700;
					half2 ZY_1500_g262700 = (Out_MaskC456_g262700).zw;
					half2 ZY_2500_g262700 = (Out_MaskD456_g262700).xy;
					half2 ZY_3500_g262700 = (Out_MaskD456_g262700).zw;
					half2 XZ500_g262700 = temp_output_463_0_g262700;
					half2 XZ_1500_g262700 = temp_output_473_0_g262700;
					half2 XZ_2500_g262700 = temp_output_474_0_g262700;
					half2 XZ_3500_g262700 = temp_output_475_0_g262700;
					half2 XY500_g262700 = temp_output_464_0_g262700;
					half2 XY_1500_g262700 = (Out_MaskF456_g262700).zw;
					half2 XY_2500_g262700 = (Out_MaskG456_g262700).xy;
					half2 XY_3500_g262700 = (Out_MaskG456_g262700).zw;
					half Bias500_g262700 = temp_output_510_0_g262700;
					half3 Weights_1500_g262700 = (Out_MaskH456_g262700).xyz;
					half3 Weights_2500_g262700 = temp_output_480_0_g262700;
					half3 Weights_3500_g262700 = (Out_MaskJ456_g262700).xyz;
					half3 Triplanar500_g262700 = temp_output_482_0_g262700;
					half3 NormalWS500_g262700 = temp_output_483_0_g262700;
					half3 Normal500_g262700 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g262700 = SampleStochastic3D( Texture500_g262700 , Sampler500_g262700 , ZY500_g262700 , ZY_1500_g262700 , ZY_2500_g262700 , ZY_3500_g262700 , XZ500_g262700 , XZ_1500_g262700 , XZ_2500_g262700 , XZ_3500_g262700 , XY500_g262700 , XY_1500_g262700 , XY_2500_g262700 , XY_3500_g262700 , Bias500_g262700 , Weights_1500_g262700 , Weights_2500_g262700 , Weights_3500_g262700 , Triplanar500_g262700 , NormalWS500_g262700 , Normal500_g262700 );
					float4 temp_output_405_203_g262682 = localSampleStochastic3D500_g262700;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g262682 = temp_output_405_277_g262682;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g262682 = temp_output_405_278_g262682;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g262682 = temp_output_405_0_g262682;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g262682 = temp_output_405_201_g262682;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g262682 = temp_output_405_202_g262682;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g262682 = temp_output_405_203_g262682;
					#else
					float4 staticSwitch198_g262682 = temp_output_405_277_g262682;
					#endif
					half4 Local_ShaderSample199_g262682 = staticSwitch198_g262682;
					float temp_output_209_0_g262682 = (Local_ShaderSample199_g262682).y;
					float temp_output_7_0_g262688 = _MainOcclusionRemap.x;
					float temp_output_9_0_g262688 = ( temp_output_209_0_g262682 - temp_output_7_0_g262688 );
					float lerpResult23_g262682 = lerp( 1.0 , saturate( ( temp_output_9_0_g262688 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g262682 = lerpResult23_g262682;
					float temp_output_213_0_g262682 = (Local_ShaderSample199_g262682).w;
					float temp_output_7_0_g262692 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g262692 = ( temp_output_213_0_g262682 - temp_output_7_0_g262692 );
					half Local_Smoothness317_g262682 = ( saturate( ( temp_output_9_0_g262692 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g262682 = (float4(( (Local_ShaderSample199_g262682).x * _MainMetallicValue ) , Local_Occlusion313_g262682 , (Local_ShaderSample199_g262682).z , Local_Smoothness317_g262682));
					half4 Local_Masks109_g262682 = appendResult73_g262682;
					float temp_output_135_0_g262682 = (Local_Masks109_g262682).z;
					float temp_output_7_0_g262687 = _MainMultiRemap.x;
					float temp_output_9_0_g262687 = ( temp_output_135_0_g262682 - temp_output_7_0_g262687 );
					float temp_output_42_0_g262682 = saturate( ( temp_output_9_0_g262687 * _MainMultiRemap.z ) );
					half Local_MultiMask78_g262682 = temp_output_42_0_g262682;
					float lerpResult58_g262682 = lerp( 1.0 , Local_MultiMask78_g262682 , _MainColorMode);
					float4 lerpResult62_g262682 = lerp( _MainColorTwo , _MainColor , lerpResult58_g262682);
					half3 Local_ColorRGB93_g262682 = (lerpResult62_g262682).rgb;
					half3 Local_Albedo139_g262682 = ( Local_AlbedoRGB107_g262682 * Local_ColorRGB93_g262682 );
					float3 temp_output_4_0_g262683 = Local_Albedo139_g262682;
					float3 In_Albedo3_g262683 = temp_output_4_0_g262683;
					float3 temp_output_44_0_g262683 = Local_Albedo139_g262682;
					float3 In_AlbedoBase3_g262683 = temp_output_44_0_g262683;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g262701) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g262698 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g262698 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g262698 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g262698 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g262698 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g262698 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g262701 = staticSwitch37_g262698;
					float localBreakTextureData456_g262701 = ( 0.0 );
					TVEMasksData Data456_g262701 =(TVEMasksData)Data431_g262696;
					float4 Out_MaskA456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g262701 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g262701 , Out_MaskA456_g262701 , Out_MaskB456_g262701 , Out_MaskC456_g262701 , Out_MaskD456_g262701 , Out_MaskE456_g262701 , Out_MaskF456_g262701 , Out_MaskG456_g262701 , Out_MaskH456_g262701 , Out_MaskI456_g262701 , Out_MaskJ456_g262701 , Out_MaskK456_g262701 , Out_MaskL456_g262701 , Out_MaskM456_g262701 , Out_MaskN456_g262701 );
					half2 UV276_g262701 = (Out_MaskA456_g262701).xy;
					float temp_output_504_0_g262701 = 0.0;
					half Bias276_g262701 = temp_output_504_0_g262701;
					half2 Normal276_g262701 = float2( 0,0 );
					half4 localSampleCoord276_g262701 = SampleCoord( Texture276_g262701 , Sampler276_g262701 , UV276_g262701 , Bias276_g262701 , Normal276_g262701 );
					float2 temp_output_406_394_g262682 = Normal276_g262701;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g262701) = _MainNormalTex;
					SamplerState Sampler502_g262701 = staticSwitch37_g262698;
					half2 UV502_g262701 = (Out_MaskA456_g262701).zw;
					half Bias502_g262701 = temp_output_504_0_g262701;
					half2 Normal502_g262701 = float2( 0,0 );
					half4 localSampleCoord502_g262701 = SampleCoord( Texture502_g262701 , Sampler502_g262701 , UV502_g262701 , Bias502_g262701 , Normal502_g262701 );
					float2 temp_output_406_397_g262682 = Normal502_g262701;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g262701) = _MainNormalTex;
					SamplerState Sampler496_g262701 = staticSwitch37_g262698;
					float2 temp_output_463_0_g262701 = (Out_MaskB456_g262701).zw;
					half2 XZ496_g262701 = temp_output_463_0_g262701;
					half Bias496_g262701 = temp_output_504_0_g262701;
					float3 temp_output_483_0_g262701 = (Out_MaskK456_g262701).xyz;
					half3 NormalWS496_g262701 = temp_output_483_0_g262701;
					half3 Normal496_g262701 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g262701 = SamplePlanar2D( Texture496_g262701 , Sampler496_g262701 , XZ496_g262701 , Bias496_g262701 , NormalWS496_g262701 , Normal496_g262701 );
					float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
					float3 worldToTangentDir408_g262701 = normalize( mul( ase_worldToTangent, Normal496_g262701 ) );
					float2 temp_output_406_375_g262682 = (worldToTangentDir408_g262701).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g262701) = _MainNormalTex;
					SamplerState Sampler490_g262701 = staticSwitch37_g262698;
					float2 temp_output_462_0_g262701 = (Out_MaskB456_g262701).xy;
					half2 ZY490_g262701 = temp_output_462_0_g262701;
					half2 XZ490_g262701 = temp_output_463_0_g262701;
					float2 temp_output_464_0_g262701 = (Out_MaskC456_g262701).xy;
					half2 XY490_g262701 = temp_output_464_0_g262701;
					half Bias490_g262701 = temp_output_504_0_g262701;
					float3 temp_output_482_0_g262701 = (Out_MaskN456_g262701).xyz;
					half3 Triplanar490_g262701 = temp_output_482_0_g262701;
					half3 NormalWS490_g262701 = temp_output_483_0_g262701;
					half3 Normal490_g262701 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g262701 = SamplePlanar3D( Texture490_g262701 , Sampler490_g262701 , ZY490_g262701 , XZ490_g262701 , XY490_g262701 , Bias490_g262701 , Triplanar490_g262701 , NormalWS490_g262701 , Normal490_g262701 );
					float3 worldToTangentDir399_g262701 = normalize( mul( ase_worldToTangent, Normal490_g262701 ) );
					float2 temp_output_406_353_g262682 = (worldToTangentDir399_g262701).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g262701) = _MainNormalTex;
					SamplerState Sampler498_g262701 = staticSwitch37_g262698;
					half2 XZ498_g262701 = temp_output_463_0_g262701;
					float2 temp_output_473_0_g262701 = (Out_MaskE456_g262701).xy;
					half2 XZ_1498_g262701 = temp_output_473_0_g262701;
					float2 temp_output_474_0_g262701 = (Out_MaskE456_g262701).zw;
					half2 XZ_2498_g262701 = temp_output_474_0_g262701;
					float2 temp_output_475_0_g262701 = (Out_MaskF456_g262701).xy;
					half2 XZ_3498_g262701 = temp_output_475_0_g262701;
					float temp_output_510_0_g262701 = exp2( temp_output_504_0_g262701 );
					half Bias498_g262701 = temp_output_510_0_g262701;
					float3 temp_output_480_0_g262701 = (Out_MaskI456_g262701).xyz;
					half3 Weights_2498_g262701 = temp_output_480_0_g262701;
					half3 NormalWS498_g262701 = temp_output_483_0_g262701;
					half3 Normal498_g262701 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g262701 = SampleStochastic2D( Texture498_g262701 , Sampler498_g262701 , XZ498_g262701 , XZ_1498_g262701 , XZ_2498_g262701 , XZ_3498_g262701 , Bias498_g262701 , Weights_2498_g262701 , NormalWS498_g262701 , Normal498_g262701 );
					float3 worldToTangentDir411_g262701 = normalize( mul( ase_worldToTangent, Normal498_g262701 ) );
					float2 temp_output_406_391_g262682 = (worldToTangentDir411_g262701).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g262701) = _MainNormalTex;
					SamplerState Sampler500_g262701 = staticSwitch37_g262698;
					half2 ZY500_g262701 = temp_output_462_0_g262701;
					half2 ZY_1500_g262701 = (Out_MaskC456_g262701).zw;
					half2 ZY_2500_g262701 = (Out_MaskD456_g262701).xy;
					half2 ZY_3500_g262701 = (Out_MaskD456_g262701).zw;
					half2 XZ500_g262701 = temp_output_463_0_g262701;
					half2 XZ_1500_g262701 = temp_output_473_0_g262701;
					half2 XZ_2500_g262701 = temp_output_474_0_g262701;
					half2 XZ_3500_g262701 = temp_output_475_0_g262701;
					half2 XY500_g262701 = temp_output_464_0_g262701;
					half2 XY_1500_g262701 = (Out_MaskF456_g262701).zw;
					half2 XY_2500_g262701 = (Out_MaskG456_g262701).xy;
					half2 XY_3500_g262701 = (Out_MaskG456_g262701).zw;
					half Bias500_g262701 = temp_output_510_0_g262701;
					half3 Weights_1500_g262701 = (Out_MaskH456_g262701).xyz;
					half3 Weights_2500_g262701 = temp_output_480_0_g262701;
					half3 Weights_3500_g262701 = (Out_MaskJ456_g262701).xyz;
					half3 Triplanar500_g262701 = temp_output_482_0_g262701;
					half3 NormalWS500_g262701 = temp_output_483_0_g262701;
					half3 Normal500_g262701 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g262701 = SampleStochastic3D( Texture500_g262701 , Sampler500_g262701 , ZY500_g262701 , ZY_1500_g262701 , ZY_2500_g262701 , ZY_3500_g262701 , XZ500_g262701 , XZ_1500_g262701 , XZ_2500_g262701 , XZ_3500_g262701 , XY500_g262701 , XY_1500_g262701 , XY_2500_g262701 , XY_3500_g262701 , Bias500_g262701 , Weights_1500_g262701 , Weights_2500_g262701 , Weights_3500_g262701 , Triplanar500_g262701 , NormalWS500_g262701 , Normal500_g262701 );
					float3 worldToTangentDir403_g262701 = normalize( mul( ase_worldToTangent, Normal500_g262701 ) );
					float2 temp_output_406_390_g262682 = (worldToTangentDir403_g262701).xy;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g262682 = temp_output_406_394_g262682;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g262682 = temp_output_406_397_g262682;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g262682 = temp_output_406_375_g262682;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g262682 = temp_output_406_353_g262682;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g262682 = temp_output_406_391_g262682;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g262682 = temp_output_406_390_g262682;
					#else
					float2 staticSwitch193_g262682 = temp_output_406_394_g262682;
					#endif
					half2 Local_NormaSample191_g262682 = staticSwitch193_g262682;
					half2 Local_NormalTS108_g262682 = ( Local_NormaSample191_g262682 * _MainNormalValue );
					float2 In_NormalTS3_g262683 = Local_NormalTS108_g262682;
					float3 appendResult68_g262694 = (float3(Local_NormalTS108_g262682 , 1.0));
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal74_g262694 = appendResult68_g262694;
					float3 worldNormal74_g262694 = normalize( float3( dot( tanToWorld0, tanNormal74_g262694 ), dot( tanToWorld1, tanNormal74_g262694 ), dot( tanToWorld2, tanNormal74_g262694 ) ) );
					half3 Local_NormalWS250_g262682 = worldNormal74_g262694;
					float3 In_NormalWS3_g262683 = Local_NormalWS250_g262682;
					float4 In_Shader3_g262683 = Local_Masks109_g262682;
					float4 In_Feature3_g262683 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g262683 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g262683 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g262691 = Local_Albedo139_g262682;
					float dotResult20_g262691 = dot( temp_output_3_0_g262691 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g262682 = dotResult20_g262691;
					float temp_output_12_0_g262683 = Local_Grayscale110_g262682;
					float In_Grayscale3_g262683 = temp_output_12_0_g262683;
					float clampResult27_g262693 = clamp( saturate( ( Local_Grayscale110_g262682 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g262682 = clampResult27_g262693;
					float temp_output_16_0_g262683 = Local_Luminosity145_g262682;
					float In_Luminosity3_g262683 = temp_output_16_0_g262683;
					float In_MultiMask3_g262683 = Local_MultiMask78_g262682;
					float temp_output_187_0_g262682 = (Local_AlbedoSample185_g262682).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g262682 = ( temp_output_187_0_g262682 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g262682 = temp_output_187_0_g262682;
					#endif
					half Local_AlphaClip111_g262682 = staticSwitch236_g262682;
					float In_AlphaClip3_g262683 = Local_AlphaClip111_g262682;
					half Local_AlphaFade246_g262682 = (lerpResult62_g262682).a;
					float In_AlphaFade3_g262683 = Local_AlphaFade246_g262682;
					float3 temp_cast_20 = (1.0).xxx;
					float3 In_Translucency3_g262683 = temp_cast_20;
					float In_Transmission3_g262683 = 1.0;
					float In_Thickness3_g262683 = 0.0;
					float In_Diffusion3_g262683 = 0.0;
					float In_Depth3_g262683 = 0.0;
					BuildVisualData( Data3_g262683 , In_Dummy3_g262683 , In_Albedo3_g262683 , In_AlbedoBase3_g262683 , In_NormalTS3_g262683 , In_NormalWS3_g262683 , In_Shader3_g262683 , In_Feature3_g262683 , In_Season3_g262683 , In_Emissive3_g262683 , In_Grayscale3_g262683 , In_Luminosity3_g262683 , In_MultiMask3_g262683 , In_AlphaClip3_g262683 , In_AlphaFade3_g262683 , In_Translucency3_g262683 , In_Transmission3_g262683 , In_Thickness3_g262683 , In_Diffusion3_g262683 , In_Depth3_g262683 );
					TVEVisualData Data4_g262709 =(TVEVisualData)Data3_g262683;
					float Out_Dummy4_g262709 = 0.0;
					float3 Out_Albedo4_g262709 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g262709 = float3( 0,0,0 );
					float2 Out_NormalTS4_g262709 = float2( 0,0 );
					float3 Out_NormalWS4_g262709 = float3( 0,0,0 );
					float4 Out_Shader4_g262709 = float4( 0,0,0,0 );
					float4 Out_Feature4_g262709 = float4( 0,0,0,0 );
					float4 Out_Season4_g262709 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g262709 = float4( 0,0,0,0 );
					float Out_MultiMask4_g262709 = 0.0;
					float Out_Grayscale4_g262709 = 0.0;
					float Out_Luminosity4_g262709 = 0.0;
					float Out_AlphaClip4_g262709 = 0.0;
					float Out_AlphaFade4_g262709 = 0.0;
					float3 Out_Translucency4_g262709 = float3( 0,0,0 );
					float Out_Transmission4_g262709 = 0.0;
					float Out_Thickness4_g262709 = 0.0;
					float Out_Diffusion4_g262709 = 0.0;
					float Out_Depth4_g262709 = 0.0;
					BreakVisualData( Data4_g262709 , Out_Dummy4_g262709 , Out_Albedo4_g262709 , Out_AlbedoBase4_g262709 , Out_NormalTS4_g262709 , Out_NormalWS4_g262709 , Out_Shader4_g262709 , Out_Feature4_g262709 , Out_Season4_g262709 , Out_Emissive4_g262709 , Out_MultiMask4_g262709 , Out_Grayscale4_g262709 , Out_Luminosity4_g262709 , Out_AlphaClip4_g262709 , Out_AlphaFade4_g262709 , Out_Translucency4_g262709 , Out_Transmission4_g262709 , Out_Thickness4_g262709 , Out_Diffusion4_g262709 , Out_Depth4_g262709 );
					float Alpha109_g262704 = Out_AlphaClip4_g262709;
					float lerpResult91_g262704 = lerp( 1.0 , Alpha109_g262704 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g262704 = lerp( 1.0 , lerpResult91_g262704 , Filter152_g262704);
					clip( lerpResult154_g262704 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2720_114;
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

					o.Emission = ( lerpResult72_g262704 * lerpResult84_g262704 );
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
				#define ASE_NEEDS_TEXTURE_COORDINATES1
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES1
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_COLOR
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_PERSPECTIVE
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_vertex TVE_ROTATION
				#pragma shader_feature_local_vertex TVE_SIZEFADE
				#pragma shader_feature_local_vertex TVE_SIZEFADE_ELEMENT
				#pragma shader_feature_local_vertex TVE_MOTION
				#pragma shader_feature_local_vertex TVE_MOTION_ELEMENT
				#pragma shader_feature_local TVE_LEGACY
				#pragma shader_feature_local_vertex TVE_FLATTEN
				#pragma shader_feature_local_vertex TVE_RESHADE
				#pragma shader_feature_local_vertex TVE_TRANSFER
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
				#if defined (TVE_CONFORM_ROTATION) //Conform Rotation
					#define TVE_ROTATION_BEND //Conform Rotation
				#endif //Conform Rotation
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
					float3 ase_normal : NORMAL;
					float4 ase_tangent : TANGENT;
					float4 ase_texcoord7 : TEXCOORD7;
					float4 ase_texcoord8 : TEXCOORD8;
					float4 ase_texcoord9 : TEXCOORD9;
					float4 ase_texcoord10 : TEXCOORD10;
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
				uniform half _PerspectiveCategory;
				uniform half _PerspectiveEnd;
				uniform half _PerspectivePhaseValue;
				uniform half _PerspectiveIntensityValue;
				uniform half _PerspectiveAngleValue;
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
				uniform half _RotationCategory;
				uniform half _RotationEnd;
				uniform half _RotationInfo;
				uniform half _RotationIntensityValue;
				uniform half _SizeFadeCategory;
				uniform half _SizeFadeEnd;
				uniform half4 TVE_SizeFadeParams;
				uniform float _SizeFadeDistMaxValue;
				uniform float _SizeFadeDistMinValue;
				uniform half _SizeFadeScaleValue;
				uniform half _SizeFadeElementMode;
				uniform half _SizeFadeGlobalValue;
				uniform half _SizeFadeScaleMode;
				uniform half _SizeFadeIntensityValue;
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
				uniform half _FlattenCategory;
				uniform half _FlattenEnd;
				uniform half _FlattenBakeMode;
				uniform half _FlattenIntensityValue;
				uniform half3 _FlattenSphereOffsetValue;
				uniform half _FlattenSphereValue;
				uniform half _FlattenMeshMode;
				uniform half4 _FlattenMeshRemap;
				uniform half _FlattenMeshValue;
				uniform half _ReshadeCategory;
				uniform half _ReshadeEnd;
				uniform half _ReshadeIntensityValue;
				uniform half _TransferCategory;
				uniform half _TransferEnd;
				uniform half _TransferSpace;
				uniform half _TransferIntensityValue;
				uniform half _TransferPerPixelMode;
				uniform half _TransferInfo;
				uniform half4 _TransferProjRemap;
				uniform half _TransferProjValue;
				uniform half _TransferMeshMode;
				uniform half4 _TransferMeshRemap;
				uniform half _TransferMeshValue;
				uniform half _TransferFormOffsetValue;
				uniform half _TransferFormValue;
				uniform half _TransferFormMode;
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

					float localIfModelDataByShader26_g262440 = ( 0.0 );
					TVEModelData Data26_g262440 = (TVEModelData)0;
					TVEModelData Data16_g262431 =(TVEModelData)0;
					half Dummy207_g262421 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g262431 = Dummy207_g262421;
					float In_Dummy16_g262431 = temp_output_14_0_g262431;
					float3 PositionOS131_g262421 = v.vertex.xyz;
					float3 temp_output_4_0_g262431 = PositionOS131_g262421;
					float3 In_PositionOS16_g262431 = temp_output_4_0_g262431;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g262421 = ase_positionWS;
					float3 vertexToFrag73_g262421 = temp_output_104_7_g262421;
					float3 PositionWS122_g262421 = vertexToFrag73_g262421;
					float3 In_PositionWS16_g262431 = PositionWS122_g262421;
					float4x4 break19_g262424 = unity_ObjectToWorld;
					float3 appendResult20_g262424 = (float3(break19_g262424[ 0 ][ 3 ] , break19_g262424[ 1 ][ 3 ] , break19_g262424[ 2 ][ 3 ]));
					float3 temp_output_340_7_g262421 = appendResult20_g262424;
					float4x4 break19_g262426 = unity_ObjectToWorld;
					float3 appendResult20_g262426 = (float3(break19_g262426[ 0 ][ 3 ] , break19_g262426[ 1 ][ 3 ] , break19_g262426[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g262422 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g262421 = PositionOS131_g262421;
					float3 appendResult234_g262421 = (float3(break233_g262421.x , 0.0 , break233_g262421.z));
					float3 break413_g262421 = PositionOS131_g262421;
					float3 appendResult414_g262421 = (float3(break413_g262421.x , break413_g262421.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262428 = appendResult414_g262421;
					#else
					float3 staticSwitch65_g262428 = appendResult234_g262421;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g262421 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g262421 = appendResult60_g262422;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g262421 = staticSwitch65_g262428;
					#else
					float3 staticSwitch229_g262421 = _Vector0;
					#endif
					float3 PivotOS149_g262421 = staticSwitch229_g262421;
					float3 temp_output_122_0_g262426 = PivotOS149_g262421;
					float3 PivotsOnlyWS105_g262426 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g262426 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g262421 = ( appendResult20_g262426 + PivotsOnlyWS105_g262426 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g262421 = temp_output_340_7_g262421;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g262421 = temp_output_341_7_g262421;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g262421 = temp_output_341_7_g262421;
					#else
					float3 staticSwitch236_g262421 = temp_output_340_7_g262421;
					#endif
					float3 vertexToFrag76_g262421 = staticSwitch236_g262421;
					float3 PivotWS121_g262421 = vertexToFrag76_g262421;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g262421 = ( PositionWS122_g262421 - PivotWS121_g262421 );
					#else
					float3 staticSwitch204_g262421 = PositionWS122_g262421;
					#endif
					float3 PositionWO132_g262421 = ( staticSwitch204_g262421 - TVE_WorldOrigin );
					float3 In_PositionWO16_g262431 = PositionWO132_g262421;
					float3 In_PositionRawOS16_g262431 = PositionOS131_g262421;
					float3 In_PivotOS16_g262431 = PivotOS149_g262421;
					float3 In_PivotWS16_g262431 = PivotWS121_g262421;
					float3 PivotWO133_g262421 = ( PivotWS121_g262421 - TVE_WorldOrigin );
					float3 In_PivotWO16_g262431 = PivotWO133_g262421;
					half3 NormalOS134_g262421 = v.normal;
					float3 temp_output_21_0_g262431 = NormalOS134_g262421;
					float3 In_NormalOS16_g262431 = temp_output_21_0_g262431;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g262421 = normalizedWorldNormal;
					float3 In_NormalWS16_g262431 = NormalWS95_g262421;
					float3 In_NormalRawOS16_g262431 = NormalOS134_g262421;
					half4 TangentlOS153_g262421 = v.tangent;
					float4 temp_output_6_0_g262431 = TangentlOS153_g262421;
					float4 In_TangentOS16_g262431 = temp_output_6_0_g262431;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g262421 = ase_tangentWS;
					float3 In_TangentWS16_g262431 = TangentWS136_g262421;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g262421 = ase_bitangentWS;
					float3 In_BitangentWS16_g262431 = BiangentWS421_g262421;
					float3 normalizeResult296_g262421 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g262421 ) );
					half3 ViewDirWS169_g262421 = normalizeResult296_g262421;
					float3 In_ViewDirWS16_g262431 = ViewDirWS169_g262421;
					float4 appendResult397_g262421 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g262421 = appendResult397_g262421;
					float4 In_CoordsData16_g262431 = CoordsData398_g262421;
					half4 VertexMasks171_g262421 = v.ase_color;
					float4 In_VertexData16_g262431 = VertexMasks171_g262421;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g262434 = (PositionOS131_g262421).z;
					#else
					float staticSwitch65_g262434 = (PositionOS131_g262421).y;
					#endif
					half Object_HeightValue267_g262421 = _ObjectHeightValue;
					half Bounds_HeightMask274_g262421 = saturate( ( staticSwitch65_g262434 / Object_HeightValue267_g262421 ) );
					half3 Position387_g262421 = PositionOS131_g262421;
					half Height387_g262421 = Object_HeightValue267_g262421;
					half Object_RadiusValue268_g262421 = _ObjectRadiusValue;
					half Radius387_g262421 = Object_RadiusValue268_g262421;
					half localCapsuleMaskYUp387_g262421 = CapsuleMaskYUp( Position387_g262421 , Height387_g262421 , Radius387_g262421 );
					half3 Position408_g262421 = PositionOS131_g262421;
					half Height408_g262421 = Object_HeightValue267_g262421;
					half Radius408_g262421 = Object_RadiusValue268_g262421;
					half localCapsuleMaskZUp408_g262421 = CapsuleMaskZUp( Position408_g262421 , Height408_g262421 , Radius408_g262421 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g262439 = saturate( localCapsuleMaskZUp408_g262421 );
					#else
					float staticSwitch65_g262439 = saturate( localCapsuleMaskYUp387_g262421 );
					#endif
					half Bounds_SphereMask282_g262421 = staticSwitch65_g262439;
					float4 appendResult253_g262421 = (float4(Bounds_HeightMask274_g262421 , Bounds_SphereMask282_g262421 , 1.0 , 1.0));
					half4 MasksData254_g262421 = appendResult253_g262421;
					float4 In_MasksData16_g262431 = MasksData254_g262421;
					float temp_output_17_0_g262433 = _ObjectPhaseMode;
					float Option70_g262433 = temp_output_17_0_g262433;
					float4 temp_output_3_0_g262433 = v.ase_color;
					float4 Channel70_g262433 = temp_output_3_0_g262433;
					float localSwitchChannel470_g262433 = SwitchChannel4( Option70_g262433 , Channel70_g262433 );
					half Phase_Value372_g262421 = localSwitchChannel470_g262433;
					float3 break319_g262421 = PivotWO133_g262421;
					half Pivot_Position322_g262421 = ( break319_g262421.x + break319_g262421.z );
					half Phase_Position357_g262421 = ( Phase_Value372_g262421 + Pivot_Position322_g262421 );
					float temp_output_248_0_g262421 = frac( Phase_Position357_g262421 );
					float4 appendResult177_g262421 = (float4(( (frac( ( Phase_Position357_g262421 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g262421));
					half4 Phase_Data176_g262421 = appendResult177_g262421;
					float4 In_PhaseData16_g262431 = Phase_Data176_g262421;
					float4 In_TransformData16_g262431 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g262431 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g262431 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g262431 , In_Dummy16_g262431 , In_PositionOS16_g262431 , In_PositionWS16_g262431 , In_PositionWO16_g262431 , In_PositionRawOS16_g262431 , In_PivotOS16_g262431 , In_PivotWS16_g262431 , In_PivotWO16_g262431 , In_NormalOS16_g262431 , In_NormalWS16_g262431 , In_NormalRawOS16_g262431 , In_TangentOS16_g262431 , In_TangentWS16_g262431 , In_BitangentWS16_g262431 , In_ViewDirWS16_g262431 , In_CoordsData16_g262431 , In_VertexData16_g262431 , In_MasksData16_g262431 , In_PhaseData16_g262431 , In_TransformData16_g262431 , In_RotationData16_g262431 , In_InterpolatorA16_g262431 );
					TVEModelData DataDefault26_g262440 = Data16_g262431;
					TVEModelData DataGeneral26_g262440 = Data16_g262431;
					TVEModelData DataBlanket26_g262440 = Data16_g262431;
					TVEModelData DataImpostor26_g262440 = Data16_g262431;
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
					TVEModelData DataTerrain26_g262440 = Data16_g241828;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g262440 = IsShaderType2637;
					{
					if (Type26_g262440 == 0 )
					{
					Data26_g262440 = DataDefault26_g262440;
					}
					else if (Type26_g262440 == 1 )
					{
					Data26_g262440 = DataGeneral26_g262440;
					}
					else if (Type26_g262440 == 2 )
					{
					Data26_g262440 = DataBlanket26_g262440;
					}
					else if (Type26_g262440 == 3 )
					{
					Data26_g262440 = DataImpostor26_g262440;
					}
					else if (Type26_g262440 == 4 )
					{
					Data26_g262440 = DataTerrain26_g262440;
					}
					}
					TVEModelData Data15_g262519 =(TVEModelData)Data26_g262440;
					float Out_Dummy15_g262519 = 0.0;
					float3 Out_PositionOS15_g262519 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262519 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262519 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262519 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262519 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262519 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262519 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262519 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262519 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262519 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262519 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262519 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262519 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262519 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262519 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262519 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262519 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262519 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262519 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262519 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262519 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262519 , Out_Dummy15_g262519 , Out_PositionOS15_g262519 , Out_PositionWS15_g262519 , Out_PositionWO15_g262519 , Out_PositionRawOS15_g262519 , Out_PivotOS15_g262519 , Out_PivotWS15_g262519 , Out_PivotWO15_g262519 , Out_NormalOS15_g262519 , Out_NormalWS15_g262519 , Out_NormalRawOS15_g262519 , Out_TangentOS15_g262519 , Out_TangentWS15_g262519 , Out_BitangentWS15_g262519 , Out_ViewDirWS15_g262519 , Out_CoordsData15_g262519 , Out_VertexData15_g262519 , Out_MasksData15_g262519 , Out_PhaseData15_g262519 , Out_TransformData15_g262519 , Out_RotationData15_g262519 , Out_InterpolatorA15_g262519 );
					TVEModelData Data16_g262521 =(TVEModelData)Data15_g262519;
					float temp_output_14_0_g262521 = 0.0;
					float In_Dummy16_g262521 = temp_output_14_0_g262521;
					float3 temp_output_219_24_g262518 = Out_PivotOS15_g262519;
					float3 temp_output_215_0_g262518 = ( Out_PositionOS15_g262519 - temp_output_219_24_g262518 );
					float3 temp_output_4_0_g262521 = temp_output_215_0_g262518;
					float3 In_PositionOS16_g262521 = temp_output_4_0_g262521;
					float3 In_PositionWS16_g262521 = Out_PositionWS15_g262519;
					float3 In_PositionWO16_g262521 = Out_PositionWO15_g262519;
					float3 In_PositionRawOS16_g262521 = Out_PositionRawOS15_g262519;
					float3 In_PivotOS16_g262521 = temp_output_219_24_g262518;
					float3 In_PivotWS16_g262521 = Out_PivotWS15_g262519;
					float3 In_PivotWO16_g262521 = Out_PivotWO15_g262519;
					float3 temp_output_21_0_g262521 = Out_NormalOS15_g262519;
					float3 In_NormalOS16_g262521 = temp_output_21_0_g262521;
					float3 In_NormalWS16_g262521 = Out_NormalWS15_g262519;
					float3 In_NormalRawOS16_g262521 = Out_NormalRawOS15_g262519;
					float4 temp_output_6_0_g262521 = Out_TangentOS15_g262519;
					float4 In_TangentOS16_g262521 = temp_output_6_0_g262521;
					float3 In_TangentWS16_g262521 = Out_TangentWS15_g262519;
					float3 In_BitangentWS16_g262521 = Out_BitangentWS15_g262519;
					float3 In_ViewDirWS16_g262521 = Out_ViewDirWS15_g262519;
					float4 In_CoordsData16_g262521 = Out_CoordsData15_g262519;
					float4 In_VertexData16_g262521 = Out_VertexData15_g262519;
					float4 In_MasksData16_g262521 = Out_MasksData15_g262519;
					float4 In_PhaseData16_g262521 = Out_PhaseData15_g262519;
					float4 In_TransformData16_g262521 = Out_TransformData15_g262519;
					float4 In_RotationData16_g262521 = Out_RotationData15_g262519;
					float4 In_InterpolatorA16_g262521 = Out_InterpolatorA15_g262519;
					BuildModelVertData( Data16_g262521 , In_Dummy16_g262521 , In_PositionOS16_g262521 , In_PositionWS16_g262521 , In_PositionWO16_g262521 , In_PositionRawOS16_g262521 , In_PivotOS16_g262521 , In_PivotWS16_g262521 , In_PivotWO16_g262521 , In_NormalOS16_g262521 , In_NormalWS16_g262521 , In_NormalRawOS16_g262521 , In_TangentOS16_g262521 , In_TangentWS16_g262521 , In_BitangentWS16_g262521 , In_ViewDirWS16_g262521 , In_CoordsData16_g262521 , In_VertexData16_g262521 , In_MasksData16_g262521 , In_PhaseData16_g262521 , In_TransformData16_g262521 , In_RotationData16_g262521 , In_InterpolatorA16_g262521 );
					TVEModelData Data15_g262525 =(TVEModelData)Data16_g262521;
					float Out_Dummy15_g262525 = 0.0;
					float3 Out_PositionOS15_g262525 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262525 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262525 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262525 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262525 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262525 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262525 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262525 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262525 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262525 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262525 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262525 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262525 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262525 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262525 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262525 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262525 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262525 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262525 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262525 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262525 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262525 , Out_Dummy15_g262525 , Out_PositionOS15_g262525 , Out_PositionWS15_g262525 , Out_PositionWO15_g262525 , Out_PositionRawOS15_g262525 , Out_PivotOS15_g262525 , Out_PivotWS15_g262525 , Out_PivotWO15_g262525 , Out_NormalOS15_g262525 , Out_NormalWS15_g262525 , Out_NormalRawOS15_g262525 , Out_TangentOS15_g262525 , Out_TangentWS15_g262525 , Out_BitangentWS15_g262525 , Out_ViewDirWS15_g262525 , Out_CoordsData15_g262525 , Out_VertexData15_g262525 , Out_MasksData15_g262525 , Out_PhaseData15_g262525 , Out_TransformData15_g262525 , Out_RotationData15_g262525 , Out_InterpolatorA15_g262525 );
					TVEModelData Data16_g262524 =(TVEModelData)Data15_g262525;
					half Dummy181_g262522 = ( _PerspectiveCategory + _PerspectiveEnd );
					float temp_output_14_0_g262524 = Dummy181_g262522;
					float In_Dummy16_g262524 = temp_output_14_0_g262524;
					half3 Model_PositionOS147_g262522 = Out_PositionOS15_g262525;
					float3 temp_output_228_35_g262522 = Out_ViewDirWS15_g262525;
					half3 Model_ViewDirWS237_g262522 = temp_output_228_35_g262522;
					float4x4 break117_g262523 = unity_CameraToWorld;
					float3 appendResult118_g262523 = (float3(break117_g262523[ 0 ][ 2 ] , break117_g262523[ 1 ][ 2 ] , break117_g262523[ 2 ][ 2 ]));
					float3 lerpResult209_g262522 = lerp( Model_ViewDirWS237_g262522 , -appendResult118_g262523 , unity_OrthoParams.w);
					float3 break201_g262522 = cross( lerpResult209_g262522 , half3( 0, 1, 0 ) );
					float3 appendResult196_g262522 = (float3(-break201_g262522.z , 0.0 , break201_g262522.x));
					float4 temp_output_228_27_g262522 = Out_PhaseData15_g262525;
					half4 Model_PhaseData218_g262522 = temp_output_228_27_g262522;
					float2 break226_g262522 = ( (Model_PhaseData218_g262522).xy * _PerspectivePhaseValue );
					float3 appendResult224_g262522 = (float3(break226_g262522.x , 0.0 , break226_g262522.y));
					float dotResult189_g262522 = dot( Model_ViewDirWS237_g262522 , float3( 0, 1, 0 ) );
					float saferPower192_g262522 = abs( dotResult189_g262522 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g262526 = (Model_PositionOS147_g262522).z;
					#else
					float staticSwitch65_g262526 = (Model_PositionOS147_g262522).y;
					#endif
					float3 temp_output_206_0_g262522 = ( Model_PositionOS147_g262522 + ( ( mul( unity_WorldToObject, float4( appendResult196_g262522 , 0.0 ) ).xyz + appendResult224_g262522 ) * _PerspectiveIntensityValue * pow( saferPower192_g262522 , _PerspectiveAngleValue ) * saturate( staticSwitch65_g262526 ) ) );
					#ifdef TVE_PERSPECTIVE
					float3 staticSwitch211_g262522 = temp_output_206_0_g262522;
					#else
					float3 staticSwitch211_g262522 = Model_PositionOS147_g262522;
					#endif
					float3 Final_Position178_g262522 = staticSwitch211_g262522;
					float3 temp_output_4_0_g262524 = Final_Position178_g262522;
					float3 In_PositionOS16_g262524 = temp_output_4_0_g262524;
					float3 In_PositionWS16_g262524 = Out_PositionWS15_g262525;
					float3 In_PositionWO16_g262524 = Out_PositionWO15_g262525;
					float3 In_PositionRawOS16_g262524 = Out_PositionRawOS15_g262525;
					float3 In_PivotOS16_g262524 = Out_PivotOS15_g262525;
					float3 In_PivotWS16_g262524 = Out_PivotWS15_g262525;
					float3 In_PivotWO16_g262524 = Out_PivotWO15_g262525;
					float3 temp_output_21_0_g262524 = Out_NormalOS15_g262525;
					float3 In_NormalOS16_g262524 = temp_output_21_0_g262524;
					float3 In_NormalWS16_g262524 = Out_NormalWS15_g262525;
					float3 In_NormalRawOS16_g262524 = Out_NormalRawOS15_g262525;
					float4 temp_output_6_0_g262524 = Out_TangentOS15_g262525;
					float4 In_TangentOS16_g262524 = temp_output_6_0_g262524;
					float3 In_TangentWS16_g262524 = Out_TangentWS15_g262525;
					float3 In_BitangentWS16_g262524 = Out_BitangentWS15_g262525;
					float3 In_ViewDirWS16_g262524 = temp_output_228_35_g262522;
					float4 In_CoordsData16_g262524 = Out_CoordsData15_g262525;
					float4 In_VertexData16_g262524 = Out_VertexData15_g262525;
					float4 In_MasksData16_g262524 = Out_MasksData15_g262525;
					float4 In_PhaseData16_g262524 = temp_output_228_27_g262522;
					float4 In_TransformData16_g262524 = Out_TransformData15_g262525;
					float4 temp_output_228_33_g262522 = Out_RotationData15_g262525;
					float4 In_RotationData16_g262524 = temp_output_228_33_g262522;
					float4 In_InterpolatorA16_g262524 = Out_InterpolatorA15_g262525;
					BuildModelVertData( Data16_g262524 , In_Dummy16_g262524 , In_PositionOS16_g262524 , In_PositionWS16_g262524 , In_PositionWO16_g262524 , In_PositionRawOS16_g262524 , In_PivotOS16_g262524 , In_PivotWS16_g262524 , In_PivotWO16_g262524 , In_NormalOS16_g262524 , In_NormalWS16_g262524 , In_NormalRawOS16_g262524 , In_TangentOS16_g262524 , In_TangentWS16_g262524 , In_BitangentWS16_g262524 , In_ViewDirWS16_g262524 , In_CoordsData16_g262524 , In_VertexData16_g262524 , In_MasksData16_g262524 , In_PhaseData16_g262524 , In_TransformData16_g262524 , In_RotationData16_g262524 , In_InterpolatorA16_g262524 );
					TVEModelData Data15_g262528 =(TVEModelData)Data16_g262524;
					float Out_Dummy15_g262528 = 0.0;
					float3 Out_PositionOS15_g262528 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262528 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262528 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262528 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262528 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262528 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262528 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262528 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262528 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262528 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262528 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262528 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262528 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262528 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262528 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262528 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262528 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262528 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262528 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262528 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262528 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262528 , Out_Dummy15_g262528 , Out_PositionOS15_g262528 , Out_PositionWS15_g262528 , Out_PositionWO15_g262528 , Out_PositionRawOS15_g262528 , Out_PivotOS15_g262528 , Out_PivotWS15_g262528 , Out_PivotWO15_g262528 , Out_NormalOS15_g262528 , Out_NormalWS15_g262528 , Out_NormalRawOS15_g262528 , Out_TangentOS15_g262528 , Out_TangentWS15_g262528 , Out_BitangentWS15_g262528 , Out_ViewDirWS15_g262528 , Out_CoordsData15_g262528 , Out_VertexData15_g262528 , Out_MasksData15_g262528 , Out_PhaseData15_g262528 , Out_TransformData15_g262528 , Out_RotationData15_g262528 , Out_InterpolatorA15_g262528 );
					TVEModelData Data16_g262529 =(TVEModelData)Data15_g262528;
					half Dummy317_g262527 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g262529 = Dummy317_g262527;
					float In_Dummy16_g262529 = temp_output_14_0_g262529;
					float3 temp_output_4_0_g262529 = Out_PositionOS15_g262528;
					float3 In_PositionOS16_g262529 = temp_output_4_0_g262529;
					float3 In_PositionWS16_g262529 = Out_PositionWS15_g262528;
					float3 temp_output_314_17_g262527 = Out_PositionWO15_g262528;
					float3 In_PositionWO16_g262529 = temp_output_314_17_g262527;
					float3 In_PositionRawOS16_g262529 = Out_PositionRawOS15_g262528;
					float3 In_PivotOS16_g262529 = Out_PivotOS15_g262528;
					float3 In_PivotWS16_g262529 = Out_PivotWS15_g262528;
					float3 temp_output_314_19_g262527 = Out_PivotWO15_g262528;
					float3 In_PivotWO16_g262529 = temp_output_314_19_g262527;
					float3 temp_output_21_0_g262529 = Out_NormalOS15_g262528;
					float3 In_NormalOS16_g262529 = temp_output_21_0_g262529;
					float3 In_NormalWS16_g262529 = Out_NormalWS15_g262528;
					float3 In_NormalRawOS16_g262529 = Out_NormalRawOS15_g262528;
					float4 temp_output_6_0_g262529 = Out_TangentOS15_g262528;
					float4 In_TangentOS16_g262529 = temp_output_6_0_g262529;
					float3 In_TangentWS16_g262529 = Out_TangentWS15_g262528;
					float3 In_BitangentWS16_g262529 = Out_BitangentWS15_g262528;
					float3 In_ViewDirWS16_g262529 = Out_ViewDirWS15_g262528;
					float4 In_CoordsData16_g262529 = Out_CoordsData15_g262528;
					float4 temp_output_314_29_g262527 = Out_VertexData15_g262528;
					float4 In_VertexData16_g262529 = temp_output_314_29_g262527;
					float4 In_MasksData16_g262529 = Out_MasksData15_g262528;
					float4 In_PhaseData16_g262529 = Out_PhaseData15_g262528;
					half4 Model_TransformData356_g262527 = Out_TransformData15_g262528;
					float localBuildGlobalData204_g262441 = ( 0.0 );
					TVEGlobalData Data204_g262441 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g262441 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g262441 = Dummy211_g262441;
					float4 temp_output_589_164_g262441 = TVE_CoatParams;
					half4 Coat_Params596_g262441 = temp_output_589_164_g262441;
					float4 In_CoatParams204_g262441 = Coat_Params596_g262441;
					float4 temp_output_203_0_g262461 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g262420 = ( 0.0 );
					TVEModelData Data26_g262420 = (TVEModelData)0;
					TVEModelData DataDefault26_g262420 = Data16_g241828;
					TVEModelData Data16_g262429 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g262429 = 0.0;
					float3 In_PositionWS16_g262429 = PositionWS122_g262421;
					float3 In_PositionWO16_g262429 = PositionWO132_g262421;
					float3 In_PivotWS16_g262429 = PivotWS121_g262421;
					float3 In_PivotWO16_g262429 = PivotWO133_g262421;
					float3 In_NormalWS16_g262429 = NormalWS95_g262421;
					float3 In_TangentWS16_g262429 = TangentWS136_g262421;
					float3 In_BitangentWS16_g262429 = BiangentWS421_g262421;
					half3 NormalWS427_g262421 = NormalWS95_g262421;
					half3 localComputeTriplanarWeights427_g262421 = ComputeTriplanarWeights( NormalWS427_g262421 );
					half3 TriplanarWeights429_g262421 = localComputeTriplanarWeights427_g262421;
					float3 In_TriplanarWeights16_g262429 = TriplanarWeights429_g262421;
					float3 In_ViewDirWS16_g262429 = ViewDirWS169_g262421;
					float4 In_CoordsData16_g262429 = CoordsData398_g262421;
					float4 In_VertexData16_g262429 = VertexMasks171_g262421;
					float4 In_PhaseData16_g262429 = Phase_Data176_g262421;
					BuildModelFragData( Data16_g262429 , In_Dummy16_g262429 , In_PositionWS16_g262429 , In_PositionWO16_g262429 , In_PivotWS16_g262429 , In_PivotWO16_g262429 , In_NormalWS16_g262429 , In_TangentWS16_g262429 , In_BitangentWS16_g262429 , In_TriplanarWeights16_g262429 , In_ViewDirWS16_g262429 , In_CoordsData16_g262429 , In_VertexData16_g262429 , In_PhaseData16_g262429 );
					TVEModelData DataGeneral26_g262420 = Data16_g262429;
					TVEModelData DataBlanket26_g262420 = Data16_g262429;
					TVEModelData DataImpostor26_g262420 = Data16_g262429;
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
					TVEModelData DataTerrain26_g262420 = Data16_g241826;
					float Type26_g262420 = IsShaderType2637;
					{
					if (Type26_g262420 == 0 )
					{
					Data26_g262420 = DataDefault26_g262420;
					}
					else if (Type26_g262420 == 1 )
					{
					Data26_g262420 = DataGeneral26_g262420;
					}
					else if (Type26_g262420 == 2 )
					{
					Data26_g262420 = DataBlanket26_g262420;
					}
					else if (Type26_g262420 == 3 )
					{
					Data26_g262420 = DataImpostor26_g262420;
					}
					else if (Type26_g262420 == 4 )
					{
					Data26_g262420 = DataTerrain26_g262420;
					}
					}
					TVEModelData Data15_g262517 =(TVEModelData)Data26_g262420;
					float Out_Dummy15_g262517 = 0.0;
					float3 Out_PositionWS15_g262517 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262517 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262517 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262517 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262517 = float3( 0,0,0 );
					float3 Out_TangentWS15_g262517 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262517 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g262517 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262517 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262517 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262517 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262517 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g262517 , Out_Dummy15_g262517 , Out_PositionWS15_g262517 , Out_PositionWO15_g262517 , Out_PivotWS15_g262517 , Out_PivotWO15_g262517 , Out_NormalWS15_g262517 , Out_TangentWS15_g262517 , Out_BitangentWS15_g262517 , Out_TriplanarWeights15_g262517 , Out_ViewDirWS15_g262517 , Out_CoordsData15_g262517 , Out_VertexData15_g262517 , Out_PhaseData15_g262517 );
					float3 Model_PositionWS497_g262441 = Out_PositionWS15_g262517;
					float2 Model_PositionWS_XZ143_g262441 = (Model_PositionWS497_g262441).xz;
					float3 Model_PivotWS498_g262441 = Out_PivotWS15_g262517;
					float2 Model_PivotWS_XZ145_g262441 = (Model_PivotWS498_g262441).xz;
					float2 lerpResult300_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g262461 = lerpResult300_g262441;
					float temp_output_82_0_g262459 = _GlobalCoatLayerValue;
					float temp_output_82_0_g262461 = temp_output_82_0_g262459;
					float4 tex2DArrayNode83_g262461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262461).zw + ( (temp_output_203_0_g262461).xy * temp_output_81_0_g262461 ) ),temp_output_82_0_g262461), 0.0 );
					float4 appendResult210_g262461 = (float4(tex2DArrayNode83_g262461.rgb , saturate( tex2DArrayNode83_g262461.a )));
					float4 temp_output_204_0_g262461 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g262461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262461).zw + ( (temp_output_204_0_g262461).xy * temp_output_81_0_g262461 ) ),temp_output_82_0_g262461), 0.0 );
					float4 appendResult212_g262461 = (float4(tex2DArrayNode122_g262461.rgb , saturate( tex2DArrayNode122_g262461.a )));
					float4 TVE_RenderNearPositionR628_g262441 = TVE_RenderNearPositionR;
					float temp_output_507_0_g262441 = saturate( ( distance( Model_PositionWS497_g262441 , (TVE_RenderNearPositionR628_g262441).xyz ) / (TVE_RenderNearPositionR628_g262441).w ) );
					float temp_output_7_0_g262442 = 1.0;
					float temp_output_9_0_g262442 = ( temp_output_507_0_g262441 - temp_output_7_0_g262442 );
					half TVE_RenderNearFadeValue635_g262441 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g262441 = saturate( ( temp_output_9_0_g262442 / ( ( TVE_RenderNearFadeValue635_g262441 - temp_output_7_0_g262442 ) + 0.0001 ) ) );
					float4 lerpResult131_g262461 = lerp( appendResult210_g262461 , appendResult212_g262461 , Global_TexBlend509_g262441);
					float4 temp_output_159_109_g262459 = lerpResult131_g262461;
					float4 lerpResult168_g262459 = lerp( TVE_CoatParams , temp_output_159_109_g262459 , TVE_CoatLayers[(int)temp_output_82_0_g262459]);
					float4 temp_output_589_109_g262441 = lerpResult168_g262459;
					half4 Coat_Texture302_g262441 = temp_output_589_109_g262441;
					float4 In_CoatTexture204_g262441 = Coat_Texture302_g262441;
					float4 temp_output_595_164_g262441 = TVE_PaintParams;
					half4 Paint_Params575_g262441 = temp_output_595_164_g262441;
					float4 In_PaintParams204_g262441 = Paint_Params575_g262441;
					float4 temp_output_203_0_g262510 = TVE_PaintBaseCoord;
					float2 lerpResult85_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g262510 = lerpResult85_g262441;
					float temp_output_82_0_g262507 = _GlobalPaintLayerValue;
					float temp_output_82_0_g262510 = temp_output_82_0_g262507;
					float4 tex2DArrayNode83_g262510 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262510).zw + ( (temp_output_203_0_g262510).xy * temp_output_81_0_g262510 ) ),temp_output_82_0_g262510), 0.0 );
					float4 appendResult210_g262510 = (float4(tex2DArrayNode83_g262510.rgb , saturate( tex2DArrayNode83_g262510.a )));
					float4 temp_output_204_0_g262510 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g262510 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262510).zw + ( (temp_output_204_0_g262510).xy * temp_output_81_0_g262510 ) ),temp_output_82_0_g262510), 0.0 );
					float4 appendResult212_g262510 = (float4(tex2DArrayNode122_g262510.rgb , saturate( tex2DArrayNode122_g262510.a )));
					float4 lerpResult131_g262510 = lerp( appendResult210_g262510 , appendResult212_g262510 , Global_TexBlend509_g262441);
					float4 temp_output_171_109_g262507 = lerpResult131_g262510;
					float4 lerpResult174_g262507 = lerp( TVE_PaintParams , temp_output_171_109_g262507 , TVE_PaintLayers[(int)temp_output_82_0_g262507]);
					float4 temp_output_595_109_g262441 = lerpResult174_g262507;
					half4 Paint_Texture71_g262441 = temp_output_595_109_g262441;
					float4 In_PaintTexture204_g262441 = Paint_Texture71_g262441;
					float4 temp_output_590_141_g262441 = TVE_AtmoParams;
					half4 Atmo_Params601_g262441 = temp_output_590_141_g262441;
					float4 In_AtmoParams204_g262441 = Atmo_Params601_g262441;
					float4 temp_output_203_0_g262469 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g262469 = lerpResult104_g262441;
					float temp_output_132_0_g262467 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g262469 = temp_output_132_0_g262467;
					float4 tex2DArrayNode83_g262469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262469).zw + ( (temp_output_203_0_g262469).xy * temp_output_81_0_g262469 ) ),temp_output_82_0_g262469), 0.0 );
					float4 appendResult210_g262469 = (float4(tex2DArrayNode83_g262469.rgb , saturate( tex2DArrayNode83_g262469.a )));
					float4 temp_output_204_0_g262469 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g262469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262469).zw + ( (temp_output_204_0_g262469).xy * temp_output_81_0_g262469 ) ),temp_output_82_0_g262469), 0.0 );
					float4 appendResult212_g262469 = (float4(tex2DArrayNode122_g262469.rgb , saturate( tex2DArrayNode122_g262469.a )));
					float4 lerpResult131_g262469 = lerp( appendResult210_g262469 , appendResult212_g262469 , Global_TexBlend509_g262441);
					float4 temp_output_137_109_g262467 = lerpResult131_g262469;
					float4 lerpResult145_g262467 = lerp( TVE_AtmoParams , temp_output_137_109_g262467 , TVE_AtmoLayers[(int)temp_output_132_0_g262467]);
					float4 temp_output_590_110_g262441 = lerpResult145_g262467;
					half4 Atmo_Texture80_g262441 = temp_output_590_110_g262441;
					float4 In_AtmoTexture204_g262441 = Atmo_Texture80_g262441;
					float4 temp_output_593_163_g262441 = TVE_GlowParams;
					half4 Glow_Params609_g262441 = temp_output_593_163_g262441;
					float4 In_GlowParams204_g262441 = Glow_Params609_g262441;
					float4 temp_output_203_0_g262485 = TVE_GlowBaseCoord;
					float2 lerpResult247_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g262485 = lerpResult247_g262441;
					float temp_output_82_0_g262483 = _GlobalGlowLayerValue;
					float temp_output_82_0_g262485 = temp_output_82_0_g262483;
					float4 tex2DArrayNode83_g262485 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262485).zw + ( (temp_output_203_0_g262485).xy * temp_output_81_0_g262485 ) ),temp_output_82_0_g262485), 0.0 );
					float4 appendResult210_g262485 = (float4(tex2DArrayNode83_g262485.rgb , saturate( tex2DArrayNode83_g262485.a )));
					float4 temp_output_204_0_g262485 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g262485 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262485).zw + ( (temp_output_204_0_g262485).xy * temp_output_81_0_g262485 ) ),temp_output_82_0_g262485), 0.0 );
					float4 appendResult212_g262485 = (float4(tex2DArrayNode122_g262485.rgb , saturate( tex2DArrayNode122_g262485.a )));
					float4 lerpResult131_g262485 = lerp( appendResult210_g262485 , appendResult212_g262485 , Global_TexBlend509_g262441);
					float4 temp_output_159_109_g262483 = lerpResult131_g262485;
					float4 lerpResult167_g262483 = lerp( TVE_GlowParams , temp_output_159_109_g262483 , TVE_GlowLayers[(int)temp_output_82_0_g262483]);
					float4 temp_output_593_109_g262441 = lerpResult167_g262483;
					half4 Glow_Texture248_g262441 = temp_output_593_109_g262441;
					float4 In_GlowTexture204_g262441 = Glow_Texture248_g262441;
					float4 temp_output_592_139_g262441 = TVE_FormParams;
					float4 Form_Params606_g262441 = temp_output_592_139_g262441;
					float4 In_FormParams204_g262441 = Form_Params606_g262441;
					float4 temp_output_203_0_g262501 = TVE_FormBaseCoord;
					float2 lerpResult168_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g262501 = lerpResult168_g262441;
					float temp_output_130_0_g262499 = _GlobalFormLayerValue;
					float temp_output_82_0_g262501 = temp_output_130_0_g262499;
					float4 tex2DArrayNode83_g262501 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262501).zw + ( (temp_output_203_0_g262501).xy * temp_output_81_0_g262501 ) ),temp_output_82_0_g262501), 0.0 );
					float4 appendResult210_g262501 = (float4(tex2DArrayNode83_g262501.rgb , saturate( tex2DArrayNode83_g262501.a )));
					float4 temp_output_204_0_g262501 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g262501 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262501).zw + ( (temp_output_204_0_g262501).xy * temp_output_81_0_g262501 ) ),temp_output_82_0_g262501), 0.0 );
					float4 appendResult212_g262501 = (float4(tex2DArrayNode122_g262501.rgb , saturate( tex2DArrayNode122_g262501.a )));
					float4 lerpResult131_g262501 = lerp( appendResult210_g262501 , appendResult212_g262501 , Global_TexBlend509_g262441);
					float4 temp_output_135_109_g262499 = lerpResult131_g262501;
					float4 lerpResult143_g262499 = lerp( TVE_FormParams , temp_output_135_109_g262499 , TVE_FormLayers[(int)temp_output_130_0_g262499]);
					float4 temp_output_592_0_g262441 = lerpResult143_g262499;
					float4 Form_Texture112_g262441 = temp_output_592_0_g262441;
					float4 In_FormTexture204_g262441 = Form_Texture112_g262441;
					float4 temp_output_594_145_g262441 = TVE_FlowParams;
					half4 Flow_Params612_g262441 = temp_output_594_145_g262441;
					float4 In_FlowParams204_g262441 = Flow_Params612_g262441;
					float4 temp_output_203_0_g262493 = TVE_FlowBaseCoord;
					float2 lerpResult400_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g262493 = lerpResult400_g262441;
					float temp_output_136_0_g262491 = _GlobalFlowLayerValue;
					float temp_output_82_0_g262493 = temp_output_136_0_g262491;
					float4 tex2DArrayNode83_g262493 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262493).zw + ( (temp_output_203_0_g262493).xy * temp_output_81_0_g262493 ) ),temp_output_82_0_g262493), 0.0 );
					float4 appendResult210_g262493 = (float4(tex2DArrayNode83_g262493.rgb , saturate( tex2DArrayNode83_g262493.a )));
					float4 temp_output_204_0_g262493 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g262493 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262493).zw + ( (temp_output_204_0_g262493).xy * temp_output_81_0_g262493 ) ),temp_output_82_0_g262493), 0.0 );
					float4 appendResult212_g262493 = (float4(tex2DArrayNode122_g262493.rgb , saturate( tex2DArrayNode122_g262493.a )));
					float4 lerpResult131_g262493 = lerp( appendResult210_g262493 , appendResult212_g262493 , Global_TexBlend509_g262441);
					float4 temp_output_141_109_g262491 = lerpResult131_g262493;
					float4 lerpResult149_g262491 = lerp( TVE_FlowParams , temp_output_141_109_g262491 , TVE_FlowLayers[(int)temp_output_136_0_g262491]);
					half4 Flow_Texture405_g262441 = lerpResult149_g262491;
					float4 In_FlowTexture204_g262441 = Flow_Texture405_g262441;
					BuildGlobalData( Data204_g262441 , In_Dummy204_g262441 , In_CoatParams204_g262441 , In_CoatTexture204_g262441 , In_PaintParams204_g262441 , In_PaintTexture204_g262441 , In_AtmoParams204_g262441 , In_AtmoTexture204_g262441 , In_GlowParams204_g262441 , In_GlowTexture204_g262441 , In_FormParams204_g262441 , In_FormTexture204_g262441 , In_FlowParams204_g262441 , In_FlowTexture204_g262441 );
					TVEGlobalData Data15_g262530 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262530 = 0.0;
					float4 Out_CoatParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262530 = float4( 0,0,0,0 );
					BreakData( Data15_g262530 , Out_Dummy15_g262530 , Out_CoatParams15_g262530 , Out_CoatTexture15_g262530 , Out_PaintParams15_g262530 , Out_PaintTexture15_g262530 , Out_AtmoParams15_g262530 , Out_AtmoTexture15_g262530 , Out_GlowParams15_g262530 , Out_GlowTexture15_g262530 , Out_FormParams15_g262530 , Out_FormTexture15_g262530 , Out_FlowParams15_g262530 , Out_FlowTexture15_g262530 );
					float4 Global_FormTexture351_g262527 = Out_FormTexture15_g262530;
					float3 Model_PivotWO353_g262527 = temp_output_314_19_g262527;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g262536 = _ConformMeshMode;
					float Option70_g262536 = temp_output_17_0_g262536;
					half4 Model_VertexData357_g262527 = temp_output_314_29_g262527;
					float4 temp_output_3_0_g262536 = Model_VertexData357_g262527;
					float4 Channel70_g262536 = temp_output_3_0_g262536;
					float localSwitchChannel470_g262536 = SwitchChannel4( Option70_g262536 , Channel70_g262536 );
					float temp_output_390_0_g262527 = localSwitchChannel470_g262536;
					float temp_output_7_0_g262533 = _ConformMeshRemap.x;
					float temp_output_9_0_g262533 = ( temp_output_390_0_g262527 - temp_output_7_0_g262533 );
					float lerpResult374_g262527 = lerp( 1.0 , saturate( ( temp_output_9_0_g262533 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g262527 = lerpResult374_g262527;
					float temp_output_328_0_g262527 = ( Blend_VertMask379_g262527 * TVE_IsEnabled );
					half Conform_Mask366_g262527 = temp_output_328_0_g262527;
					float temp_output_322_0_g262527 = ( ( ( ( (Global_FormTexture351_g262527).z - ( (Model_PivotWO353_g262527).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g262527 ) );
					float3 appendResult329_g262527 = (float3(0.0 , temp_output_322_0_g262527 , 0.0));
					float3 appendResult387_g262527 = (float3(0.0 , 0.0 , temp_output_322_0_g262527));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262534 = appendResult387_g262527;
					#else
					float3 staticSwitch65_g262534 = appendResult329_g262527;
					#endif
					float3 Blanket_Conform368_g262527 = staticSwitch65_g262534;
					float4 appendResult312_g262527 = (float4(Blanket_Conform368_g262527 , 0.0));
					float4 temp_output_310_0_g262527 = ( Model_TransformData356_g262527 + appendResult312_g262527 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g262527 = temp_output_310_0_g262527;
					#else
					float4 staticSwitch364_g262527 = Model_TransformData356_g262527;
					#endif
					half4 Final_TransformData365_g262527 = staticSwitch364_g262527;
					float4 In_TransformData16_g262529 = Final_TransformData365_g262527;
					float4 In_RotationData16_g262529 = Out_RotationData15_g262528;
					float4 In_InterpolatorA16_g262529 = Out_InterpolatorA15_g262528;
					BuildModelVertData( Data16_g262529 , In_Dummy16_g262529 , In_PositionOS16_g262529 , In_PositionWS16_g262529 , In_PositionWO16_g262529 , In_PositionRawOS16_g262529 , In_PivotOS16_g262529 , In_PivotWS16_g262529 , In_PivotWO16_g262529 , In_NormalOS16_g262529 , In_NormalWS16_g262529 , In_NormalRawOS16_g262529 , In_TangentOS16_g262529 , In_TangentWS16_g262529 , In_BitangentWS16_g262529 , In_ViewDirWS16_g262529 , In_CoordsData16_g262529 , In_VertexData16_g262529 , In_MasksData16_g262529 , In_PhaseData16_g262529 , In_TransformData16_g262529 , In_RotationData16_g262529 , In_InterpolatorA16_g262529 );
					TVEModelData Data15_g262542 =(TVEModelData)Data16_g262529;
					float Out_Dummy15_g262542 = 0.0;
					float3 Out_PositionOS15_g262542 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262542 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262542 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262542 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262542 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262542 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262542 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262542 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262542 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262542 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262542 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262542 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262542 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262542 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262542 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262542 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262542 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262542 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262542 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262542 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262542 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262542 , Out_Dummy15_g262542 , Out_PositionOS15_g262542 , Out_PositionWS15_g262542 , Out_PositionWO15_g262542 , Out_PositionRawOS15_g262542 , Out_PivotOS15_g262542 , Out_PivotWS15_g262542 , Out_PivotWO15_g262542 , Out_NormalOS15_g262542 , Out_NormalWS15_g262542 , Out_NormalRawOS15_g262542 , Out_TangentOS15_g262542 , Out_TangentWS15_g262542 , Out_BitangentWS15_g262542 , Out_ViewDirWS15_g262542 , Out_CoordsData15_g262542 , Out_VertexData15_g262542 , Out_MasksData15_g262542 , Out_PhaseData15_g262542 , Out_TransformData15_g262542 , Out_RotationData15_g262542 , Out_InterpolatorA15_g262542 );
					TVEModelData Data16_g262543 =(TVEModelData)Data15_g262542;
					half Dummy181_g262537 = ( _RotationCategory + _RotationEnd + _RotationInfo );
					float temp_output_14_0_g262543 = Dummy181_g262537;
					float In_Dummy16_g262543 = temp_output_14_0_g262543;
					float3 temp_output_4_0_g262543 = Out_PositionOS15_g262542;
					float3 In_PositionOS16_g262543 = temp_output_4_0_g262543;
					float3 In_PositionWS16_g262543 = Out_PositionWS15_g262542;
					float3 In_PositionWO16_g262543 = Out_PositionWO15_g262542;
					float3 In_PositionRawOS16_g262543 = Out_PositionRawOS15_g262542;
					float3 In_PivotOS16_g262543 = Out_PivotOS15_g262542;
					float3 In_PivotWS16_g262543 = Out_PivotWS15_g262542;
					float3 In_PivotWO16_g262543 = Out_PivotWO15_g262542;
					float3 temp_output_21_0_g262543 = Out_NormalOS15_g262542;
					float3 In_NormalOS16_g262543 = temp_output_21_0_g262543;
					float3 In_NormalWS16_g262543 = Out_NormalWS15_g262542;
					float3 In_NormalRawOS16_g262543 = Out_NormalRawOS15_g262542;
					float4 temp_output_6_0_g262543 = Out_TangentOS15_g262542;
					float4 In_TangentOS16_g262543 = temp_output_6_0_g262543;
					float3 In_TangentWS16_g262543 = Out_TangentWS15_g262542;
					float3 In_BitangentWS16_g262543 = Out_BitangentWS15_g262542;
					float3 In_ViewDirWS16_g262543 = Out_ViewDirWS15_g262542;
					float4 In_CoordsData16_g262543 = Out_CoordsData15_g262542;
					float4 In_VertexData16_g262543 = Out_VertexData15_g262542;
					float4 In_MasksData16_g262543 = Out_MasksData15_g262542;
					float4 In_PhaseData16_g262543 = Out_PhaseData15_g262542;
					float4 In_TransformData16_g262543 = Out_TransformData15_g262542;
					half4 Model_RotationData212_g262537 = Out_RotationData15_g262542;
					TVEGlobalData Data15_g262538 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262538 = 0.0;
					float4 Out_CoatParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262538 = float4( 0,0,0,0 );
					BreakData( Data15_g262538 , Out_Dummy15_g262538 , Out_CoatParams15_g262538 , Out_CoatTexture15_g262538 , Out_PaintParams15_g262538 , Out_PaintTexture15_g262538 , Out_AtmoParams15_g262538 , Out_AtmoTexture15_g262538 , Out_GlowParams15_g262538 , Out_GlowTexture15_g262538 , Out_FormParams15_g262538 , Out_FormTexture15_g262538 , Out_FlowParams15_g262538 , Out_FlowTexture15_g262538 );
					half4 Global_FormTexture188_g262537 = Out_FormTexture15_g262538;
					float2 temp_output_38_0_g262539 = ((Global_FormTexture188_g262537).xy*2.0 + -1.0);
					float2 break83_g262539 = temp_output_38_0_g262539;
					float3 appendResult79_g262539 = (float3(break83_g262539.x , 0.0 , break83_g262539.y));
					float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
					float2 lerpResult227_g262537 = lerp( float2( 0,0 ) , (( mul( unity_WorldToObject, float4( appendResult79_g262539 , 0.0 ) ).xyz * ase_parentObjectScale )).xz , ( _RotationIntensityValue * TVE_IsEnabled ));
					half2 Blanket_Orientation192_g262537 = lerpResult227_g262537;
					float4 appendResult222_g262537 = (float4(( (Model_RotationData212_g262537).xy + Blanket_Orientation192_g262537 ) , (Model_RotationData212_g262537).zw));
					#ifdef TVE_ROTATION
					float4 staticSwitch218_g262537 = appendResult222_g262537;
					#else
					float4 staticSwitch218_g262537 = Model_RotationData212_g262537;
					#endif
					half4 Final_RotationData225_g262537 = staticSwitch218_g262537;
					float4 In_RotationData16_g262543 = Final_RotationData225_g262537;
					float4 In_InterpolatorA16_g262543 = Out_InterpolatorA15_g262542;
					BuildModelVertData( Data16_g262543 , In_Dummy16_g262543 , In_PositionOS16_g262543 , In_PositionWS16_g262543 , In_PositionWO16_g262543 , In_PositionRawOS16_g262543 , In_PivotOS16_g262543 , In_PivotWS16_g262543 , In_PivotWO16_g262543 , In_NormalOS16_g262543 , In_NormalWS16_g262543 , In_NormalRawOS16_g262543 , In_TangentOS16_g262543 , In_TangentWS16_g262543 , In_BitangentWS16_g262543 , In_ViewDirWS16_g262543 , In_CoordsData16_g262543 , In_VertexData16_g262543 , In_MasksData16_g262543 , In_PhaseData16_g262543 , In_TransformData16_g262543 , In_RotationData16_g262543 , In_InterpolatorA16_g262543 );
					TVEModelData Data15_g262545 =(TVEModelData)Data16_g262543;
					float Out_Dummy15_g262545 = 0.0;
					float3 Out_PositionOS15_g262545 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262545 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262545 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262545 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262545 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262545 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262545 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262545 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262545 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262545 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262545 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262545 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262545 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262545 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262545 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262545 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262545 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262545 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262545 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262545 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262545 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262545 , Out_Dummy15_g262545 , Out_PositionOS15_g262545 , Out_PositionWS15_g262545 , Out_PositionWO15_g262545 , Out_PositionRawOS15_g262545 , Out_PivotOS15_g262545 , Out_PivotWS15_g262545 , Out_PivotWO15_g262545 , Out_NormalOS15_g262545 , Out_NormalWS15_g262545 , Out_NormalRawOS15_g262545 , Out_TangentOS15_g262545 , Out_TangentWS15_g262545 , Out_BitangentWS15_g262545 , Out_ViewDirWS15_g262545 , Out_CoordsData15_g262545 , Out_VertexData15_g262545 , Out_MasksData15_g262545 , Out_PhaseData15_g262545 , Out_TransformData15_g262545 , Out_RotationData15_g262545 , Out_InterpolatorA15_g262545 );
					TVEModelData Data16_g262546 =(TVEModelData)Data15_g262545;
					half Dummy181_g262544 = ( _SizeFadeCategory + _SizeFadeEnd );
					float temp_output_14_0_g262546 = Dummy181_g262544;
					float In_Dummy16_g262546 = temp_output_14_0_g262546;
					float3 Model_PositionOS147_g262544 = Out_PositionOS15_g262545;
					float3 temp_cast_15 = (1.0).xxx;
					float3 temp_output_210_18_g262544 = Out_PivotWS15_g262545;
					float3 Model_PivotWS162_g262544 = temp_output_210_18_g262544;
					float lerpResult216_g262544 = lerp( 1.0 , TVE_SizeFadeParams.z , TVE_SizeFadeParams.w);
					float temp_output_7_0_g262548 = _SizeFadeDistMaxValue;
					float temp_output_9_0_g262548 = ( ( distance( _WorldSpaceCameraPos , Model_PivotWS162_g262544 ) * lerpResult216_g262544 ) - temp_output_7_0_g262548 );
					TVEGlobalData Data15_g262553 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262553 = 0.0;
					float4 Out_CoatParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262553 = float4( 0,0,0,0 );
					BreakData( Data15_g262553 , Out_Dummy15_g262553 , Out_CoatParams15_g262553 , Out_CoatTexture15_g262553 , Out_PaintParams15_g262553 , Out_PaintTexture15_g262553 , Out_AtmoParams15_g262553 , Out_AtmoTexture15_g262553 , Out_GlowParams15_g262553 , Out_GlowTexture15_g262553 , Out_FormParams15_g262553 , Out_FormTexture15_g262553 , Out_FlowParams15_g262553 , Out_FlowTexture15_g262553 );
					half4 Global_FormParams243_g262544 = Out_FormParams15_g262553;
					float temp_output_245_0_g262544 = (Global_FormParams243_g262544).w;
					half4 Global_FormTexture188_g262544 = Out_FormTexture15_g262553;
					float temp_output_6_0_g262552 = (Global_FormTexture188_g262544).w;
					float temp_output_7_0_g262552 = _SizeFadeElementMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g262552 = ( temp_output_6_0_g262552 + temp_output_7_0_g262552 );
					#else
					float staticSwitch14_g262552 = temp_output_6_0_g262552;
					#endif
					float temp_output_223_0_g262544 = staticSwitch14_g262552;
					#ifdef TVE_SIZEFADE_ELEMENT
					float staticSwitch194_g262544 = temp_output_223_0_g262544;
					#else
					float staticSwitch194_g262544 = temp_output_245_0_g262544;
					#endif
					float lerpResult213_g262544 = lerp( 1.0 , staticSwitch194_g262544 , ( _SizeFadeGlobalValue * TVE_IsEnabled ));
					half Blend_GlobalMask192_g262544 = lerpResult213_g262544;
					half Blend_UserMask232_g262544 = 1.0;
					float temp_output_236_0_g262544 = ( Blend_GlobalMask192_g262544 * Blend_UserMask232_g262544 );
					half Blend_Mask240_g262544 = temp_output_236_0_g262544;
					float temp_output_189_0_g262544 = ( saturate( ( temp_output_9_0_g262548 / ( ( _SizeFadeDistMinValue - temp_output_7_0_g262548 ) + 0.0001 ) ) ) * _SizeFadeScaleValue * Blend_Mask240_g262544 );
					float3 appendResult200_g262544 = (float3(temp_output_189_0_g262544 , temp_output_189_0_g262544 , temp_output_189_0_g262544));
					float3 appendResult201_g262544 = (float3(1.0 , temp_output_189_0_g262544 , 1.0));
					float3 appendResult230_g262544 = (float3(1.0 , 1.0 , temp_output_189_0_g262544));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262549 = appendResult230_g262544;
					#else
					float3 staticSwitch65_g262549 = appendResult201_g262544;
					#endif
					float3 lerpResult202_g262544 = lerp( appendResult200_g262544 , staticSwitch65_g262549 , _SizeFadeScaleMode);
					float3 lerpResult184_g262544 = lerp( temp_cast_15 , lerpResult202_g262544 , _SizeFadeIntensityValue);
					float3 temp_output_167_0_g262544 = ( lerpResult184_g262544 * Model_PositionOS147_g262544 );
					#ifdef TVE_SIZEFADE
					float3 staticSwitch199_g262544 = temp_output_167_0_g262544;
					#else
					float3 staticSwitch199_g262544 = Model_PositionOS147_g262544;
					#endif
					float3 Final_Position178_g262544 = staticSwitch199_g262544;
					float3 temp_output_4_0_g262546 = Final_Position178_g262544;
					float3 In_PositionOS16_g262546 = temp_output_4_0_g262546;
					float3 In_PositionWS16_g262546 = Out_PositionWS15_g262545;
					float3 In_PositionWO16_g262546 = Out_PositionWO15_g262545;
					float3 In_PositionRawOS16_g262546 = Out_PositionRawOS15_g262545;
					float3 temp_output_210_24_g262544 = Out_PivotOS15_g262545;
					float3 In_PivotOS16_g262546 = temp_output_210_24_g262544;
					float3 In_PivotWS16_g262546 = temp_output_210_18_g262544;
					float3 In_PivotWO16_g262546 = Out_PivotWO15_g262545;
					float3 temp_output_21_0_g262546 = Out_NormalOS15_g262545;
					float3 In_NormalOS16_g262546 = temp_output_21_0_g262546;
					float3 In_NormalWS16_g262546 = Out_NormalWS15_g262545;
					float3 In_NormalRawOS16_g262546 = Out_NormalRawOS15_g262545;
					float4 temp_output_6_0_g262546 = Out_TangentOS15_g262545;
					float4 In_TangentOS16_g262546 = temp_output_6_0_g262546;
					float3 In_TangentWS16_g262546 = Out_TangentWS15_g262545;
					float3 In_BitangentWS16_g262546 = Out_BitangentWS15_g262545;
					float3 In_ViewDirWS16_g262546 = Out_ViewDirWS15_g262545;
					float4 In_CoordsData16_g262546 = Out_CoordsData15_g262545;
					float4 In_VertexData16_g262546 = Out_VertexData15_g262545;
					float4 In_MasksData16_g262546 = Out_MasksData15_g262545;
					float4 In_PhaseData16_g262546 = Out_PhaseData15_g262545;
					float4 In_TransformData16_g262546 = Out_TransformData15_g262545;
					float4 In_RotationData16_g262546 = Out_RotationData15_g262545;
					float4 In_InterpolatorA16_g262546 = Out_InterpolatorA15_g262545;
					BuildModelVertData( Data16_g262546 , In_Dummy16_g262546 , In_PositionOS16_g262546 , In_PositionWS16_g262546 , In_PositionWO16_g262546 , In_PositionRawOS16_g262546 , In_PivotOS16_g262546 , In_PivotWS16_g262546 , In_PivotWO16_g262546 , In_NormalOS16_g262546 , In_NormalWS16_g262546 , In_NormalRawOS16_g262546 , In_TangentOS16_g262546 , In_TangentWS16_g262546 , In_BitangentWS16_g262546 , In_ViewDirWS16_g262546 , In_CoordsData16_g262546 , In_VertexData16_g262546 , In_MasksData16_g262546 , In_PhaseData16_g262546 , In_TransformData16_g262546 , In_RotationData16_g262546 , In_InterpolatorA16_g262546 );
					TVEModelData Data15_g262556 =(TVEModelData)Data16_g262546;
					float Out_Dummy15_g262556 = 0.0;
					float3 Out_PositionOS15_g262556 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262556 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262556 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262556 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262556 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262556 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262556 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262556 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262556 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262556 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262556 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262556 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262556 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262556 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262556 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262556 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262556 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262556 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262556 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262556 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262556 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262556 , Out_Dummy15_g262556 , Out_PositionOS15_g262556 , Out_PositionWS15_g262556 , Out_PositionWO15_g262556 , Out_PositionRawOS15_g262556 , Out_PivotOS15_g262556 , Out_PivotWS15_g262556 , Out_PivotWO15_g262556 , Out_NormalOS15_g262556 , Out_NormalWS15_g262556 , Out_NormalRawOS15_g262556 , Out_TangentOS15_g262556 , Out_TangentWS15_g262556 , Out_BitangentWS15_g262556 , Out_ViewDirWS15_g262556 , Out_CoordsData15_g262556 , Out_VertexData15_g262556 , Out_MasksData15_g262556 , Out_PhaseData15_g262556 , Out_TransformData15_g262556 , Out_RotationData15_g262556 , Out_InterpolatorA15_g262556 );
					TVEModelData Data16_g262555 =(TVEModelData)Data15_g262556;
					half Dummy181_g262554 = ( ( _MotionCategory + _MotionEnd ) + _MotionPushInfo );
					float temp_output_14_0_g262555 = Dummy181_g262554;
					float In_Dummy16_g262555 = temp_output_14_0_g262555;
					float3 temp_output_2772_0_g262554 = Out_PositionOS15_g262556;
					float3 temp_output_4_0_g262555 = temp_output_2772_0_g262554;
					float3 In_PositionOS16_g262555 = temp_output_4_0_g262555;
					float3 temp_output_2772_16_g262554 = Out_PositionWS15_g262556;
					float3 In_PositionWS16_g262555 = temp_output_2772_16_g262554;
					float3 temp_output_2772_17_g262554 = Out_PositionWO15_g262556;
					float3 In_PositionWO16_g262555 = temp_output_2772_17_g262554;
					float3 In_PositionRawOS16_g262555 = Out_PositionRawOS15_g262556;
					float3 temp_output_2772_24_g262554 = Out_PivotOS15_g262556;
					float3 In_PivotOS16_g262555 = temp_output_2772_24_g262554;
					float3 In_PivotWS16_g262555 = Out_PivotWS15_g262556;
					float3 temp_output_2772_19_g262554 = Out_PivotWO15_g262556;
					float3 In_PivotWO16_g262555 = temp_output_2772_19_g262554;
					float3 temp_output_2772_20_g262554 = Out_NormalOS15_g262556;
					float3 temp_output_21_0_g262555 = temp_output_2772_20_g262554;
					float3 In_NormalOS16_g262555 = temp_output_21_0_g262555;
					float3 In_NormalWS16_g262555 = Out_NormalWS15_g262556;
					float3 In_NormalRawOS16_g262555 = Out_NormalRawOS15_g262556;
					float4 temp_output_6_0_g262555 = Out_TangentOS15_g262556;
					float4 In_TangentOS16_g262555 = temp_output_6_0_g262555;
					float3 In_TangentWS16_g262555 = Out_TangentWS15_g262556;
					float3 In_BitangentWS16_g262555 = Out_BitangentWS15_g262556;
					float3 In_ViewDirWS16_g262555 = Out_ViewDirWS15_g262556;
					float4 In_CoordsData16_g262555 = Out_CoordsData15_g262556;
					float4 temp_output_2772_29_g262554 = Out_VertexData15_g262556;
					float4 In_VertexData16_g262555 = temp_output_2772_29_g262554;
					float4 temp_output_2772_30_g262554 = Out_MasksData15_g262556;
					float4 In_MasksData16_g262555 = temp_output_2772_30_g262554;
					float4 temp_output_2772_27_g262554 = Out_PhaseData15_g262556;
					float4 In_PhaseData16_g262555 = temp_output_2772_27_g262554;
					half4 Model_TransformData2743_g262554 = Out_TransformData15_g262556;
					float3 temp_cast_16 = (0.0).xxx;
					float2 lerpResult3113_g262554 = lerp( (half4( 0, 1, 0.5, 1 )).xy , (TVE_WindParams).xy , TVE_IsEnabled);
					float2 Global_WindDirWS2542_g262554 = lerpResult3113_g262554;
					half2 Input_WindDirWS803_g262605 = Global_WindDirWS2542_g262554;
					float3 Model_PositionWO162_g262554 = temp_output_2772_17_g262554;
					half3 Input_ModelPositionWO761_g262558 = Model_PositionWO162_g262554;
					float3 Model_PivotWO402_g262554 = temp_output_2772_19_g262554;
					half3 Input_ModelPivotsWO419_g262558 = Model_PivotWO402_g262554;
					half Input_MotionPivots629_g262558 = _MotionSmallPivotValue;
					float3 lerpResult771_g262558 = lerp( Input_ModelPositionWO761_g262558 , Input_ModelPivotsWO419_g262558 , Input_MotionPivots629_g262558);
					half4 Model_PhaseData489_g262554 = temp_output_2772_27_g262554;
					half4 Input_ModelMotionData763_g262558 = Model_PhaseData489_g262554;
					half Input_MotionPhase764_g262558 = _MotionSmallPhaseValue;
					float temp_output_770_0_g262558 = ( (Input_ModelMotionData763_g262558).x * Input_MotionPhase764_g262558 );
					half3 Small_Position1421_g262554 = ( lerpResult771_g262558 + temp_output_770_0_g262558 );
					half3 Input_PositionWO419_g262605 = Small_Position1421_g262554;
					half Input_MotionTilling321_g262605 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g262605 = ( -(Input_PositionWO419_g262605).xz * Input_MotionTilling321_g262605 * 0.005 );
					float2 temp_output_3_0_g262606 = Noise_Coord979_g262605;
					float2 temp_output_21_0_g262606 = Input_WindDirWS803_g262605;
					float mulTime113_g262609 = _Time.y * 0.02;
					float lerpResult128_g262609 = lerp( mulTime113_g262609 , ( ( mulTime113_g262609 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g262605 = _MotionSmallSpeedValue;
					half Noise_Speed980_g262605 = ( lerpResult128_g262609 * Input_MotionSpeed62_g262605 );
					float temp_output_15_0_g262606 = Noise_Speed980_g262605;
					float temp_output_23_0_g262606 = frac( temp_output_15_0_g262606 );
					float4 lerpResult39_g262606 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g262606 + ( temp_output_21_0_g262606 * temp_output_23_0_g262606 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g262606 + ( temp_output_21_0_g262606 * frac( ( temp_output_15_0_g262606 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g262606 - 0.5 ) ) / 0.5 ));
					float4 temp_output_991_0_g262605 = lerpResult39_g262606;
					half2 Noise_DirWS858_g262605 = ((temp_output_991_0_g262605).rg*2.0 + -1.0);
					half Input_MotionNoise552_g262605 = _MotionSmallNoiseValue;
					TVEGlobalData Data15_g262568 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262568 = 0.0;
					float4 Out_CoatParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262568 = float4( 0,0,0,0 );
					BreakData( Data15_g262568 , Out_Dummy15_g262568 , Out_CoatParams15_g262568 , Out_CoatTexture15_g262568 , Out_PaintParams15_g262568 , Out_PaintTexture15_g262568 , Out_AtmoParams15_g262568 , Out_AtmoTexture15_g262568 , Out_GlowParams15_g262568 , Out_GlowTexture15_g262568 , Out_FormParams15_g262568 , Out_FormTexture15_g262568 , Out_FlowParams15_g262568 , Out_FlowTexture15_g262568 );
					half4 Global_FlowParams3052_g262554 = Out_FlowParams15_g262568;
					half4 Global_FlowTexture2668_g262554 = Out_FlowTexture15_g262568;
					#ifdef TVE_MOTION_ELEMENT
					float4 staticSwitch3075_g262554 = Global_FlowTexture2668_g262554;
					#else
					float4 staticSwitch3075_g262554 = Global_FlowParams3052_g262554;
					#endif
					float4 temp_output_6_0_g262570 = staticSwitch3075_g262554;
					float temp_output_7_0_g262570 = _MotionElementMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g262570 = ( temp_output_6_0_g262570 + temp_output_7_0_g262570 );
					#else
					float4 staticSwitch14_g262570 = temp_output_6_0_g262570;
					#endif
					float4 lerpResult3121_g262554 = lerp( half4( 0, 0, 0, 1 ) , staticSwitch14_g262570 , TVE_IsEnabled);
					float temp_output_630_0_g262583 = saturate( (lerpResult3121_g262554).w );
					float lerpResult853_g262583 = lerp( temp_output_630_0_g262583 , saturate( (temp_output_630_0_g262583*TVE_WindEditor.x + TVE_WindEditor.y) ) , TVE_WindEditor.w);
					half Global_WindValue1855_g262554 = ( lerpResult853_g262583 * _MotionIntensityValue );
					half Input_WindValue881_g262605 = Global_WindValue1855_g262554;
					float temp_output_6_0_g262611 = Input_WindValue881_g262605;
					float lerpResult701_g262605 = lerp( 1.0 , Input_MotionNoise552_g262605 , ( temp_output_6_0_g262611 * temp_output_6_0_g262611 ));
					float2 lerpResult646_g262605 = lerp( Input_WindDirWS803_g262605 , Noise_DirWS858_g262605 , lerpResult701_g262605);
					half2 Small_DirWS817_g262605 = lerpResult646_g262605;
					float2 break823_g262605 = Small_DirWS817_g262605;
					half4 Noise_Params685_g262605 = temp_output_991_0_g262605;
					half Wind_Sinus820_g262605 = ( ((Noise_Params685_g262605).b*2.0 + -1.0) * 0.6 );
					float3 appendResult824_g262605 = (float3(break823_g262605.x , Wind_Sinus820_g262605 , break823_g262605.y));
					half3 Small_Dir918_g262605 = appendResult824_g262605;
					float temp_output_20_0_g262610 = ( 1.0 - Input_WindValue881_g262605 );
					float3 appendResult1006_g262605 = (float3(Input_WindValue881_g262605 , ( 1.0 - ( temp_output_20_0_g262610 * temp_output_20_0_g262610 ) ) , Input_WindValue881_g262605));
					half Input_MotionDelay753_g262605 = _MotionSmallDelayValue;
					float lerpResult756_g262605 = lerp( 1.0 , ( Input_WindValue881_g262605 * Input_WindValue881_g262605 ) , Input_MotionDelay753_g262605);
					half Wind_Delay815_g262605 = lerpResult756_g262605;
					half Input_MotionValue905_g262605 = _MotionSmallIntensityValue;
					float3 temp_output_883_0_g262605 = ( Small_Dir918_g262605 * appendResult1006_g262605 * Wind_Delay815_g262605 * Input_MotionValue905_g262605 );
					float2 break857_g262605 = Noise_DirWS858_g262605;
					float3 appendResult833_g262605 = (float3(break857_g262605.x , Wind_Sinus820_g262605 , break857_g262605.y));
					half3 Push_Dir919_g262605 = appendResult833_g262605;
					half Input_MotionReact924_g262605 = _MotionSmallPushValue;
					float2 temp_output_3126_0_g262554 = ((lerpResult3121_g262554).xy*2.0 + -1.0);
					half Global_PushAlpha1504_g262554 = length( temp_output_3126_0_g262554 );
					half Input_PushAlpha806_g262605 = Global_PushAlpha1504_g262554;
					half Global_PushNoise2675_g262554 = (lerpResult3121_g262554).z;
					half Input_PushNoise890_g262605 = Global_PushNoise2675_g262554;
					half Push_Mask914_g262605 = saturate( ( Input_PushAlpha806_g262605 * Input_PushNoise890_g262605 * Input_MotionReact924_g262605 ) );
					float3 lerpResult840_g262605 = lerp( temp_output_883_0_g262605 , ( Push_Dir919_g262605 * Input_MotionReact924_g262605 ) , Push_Mask914_g262605);
					#ifdef TVE_MOTION_ELEMENT
					float3 staticSwitch829_g262605 = lerpResult840_g262605;
					#else
					float3 staticSwitch829_g262605 = temp_output_883_0_g262605;
					#endif
					half3 Small_Squash1489_g262554 = ( mul( unity_WorldToObject, float4( staticSwitch829_g262605 , 0.0 ) ).xyz * ase_parentObjectScale );
					float temp_output_17_0_g262593 = _MotionSmallMaskMode;
					float Option83_g262593 = temp_output_17_0_g262593;
					half4 Model_VertexMasks518_g262554 = temp_output_2772_29_g262554;
					float4 ChannelA83_g262593 = Model_VertexMasks518_g262554;
					half4 Model_MasksData1322_g262554 = temp_output_2772_30_g262554;
					float2 uv_MotionMaskTex2818_g262554 = v.texcoord.xyzw.xy;
					half4 Motion_MaskTex2819_g262554 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g262554, 0.0 );
					float4 appendResult3227_g262554 = (float4((Model_MasksData1322_g262554).xy , (Motion_MaskTex2819_g262554).g , 0.0));
					float4 ChannelB83_g262593 = appendResult3227_g262554;
					float localSwitchChannel883_g262593 = SwitchChannel8( Option83_g262593 , ChannelA83_g262593 , ChannelB83_g262593 );
					float enc1805_g262554 = v.texcoord.xyzw.z;
					float2 localDecodeFloatToVector21805_g262554 = DecodeFloatToVector2( enc1805_g262554 );
					float2 break1804_g262554 = localDecodeFloatToVector21805_g262554;
					half Small_Mask_Legacy1806_g262554 = break1804_g262554.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g262554 = Small_Mask_Legacy1806_g262554;
					#else
					float staticSwitch1800_g262554 = localSwitchChannel883_g262593;
					#endif
					float clampResult17_g262559 = clamp( staticSwitch1800_g262554 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262560 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g262560 = ( clampResult17_g262559 - temp_output_7_0_g262560 );
					half Small_Mask640_g262554 = saturate( ( temp_output_9_0_g262560 * _MotionSmallMaskRemap.z ) );
					float3 lerpResult3022_g262554 = lerp( float3( 1,1,1 ) , (TVE_MotionValueParams).xyz , TVE_MotionValueParams.w);
					half3 Global_MotionParams3013_g262554 = lerpResult3022_g262554;
					half3 Small_Motion789_g262554 = ( Small_Squash1489_g262554 * Small_Mask640_g262554 * (Global_MotionParams3013_g262554).y );
					#ifdef TVE_MOTION
					float3 staticSwitch495_g262554 = Small_Motion789_g262554;
					#else
					float3 staticSwitch495_g262554 = temp_cast_16;
					#endif
					float3 temp_cast_19 = (0.0).xxx;
					float3 Model_PositionWS1819_g262554 = temp_output_2772_16_g262554;
					half Global_DistMask1820_g262554 = ( 1.0 - saturate( ( distance( _WorldSpaceCameraPos , Model_PositionWS1819_g262554 ) / _MotionDistValue ) ) );
					float temp_output_17_0_g262594 = _MotionTinyMaskMode;
					float Option83_g262594 = temp_output_17_0_g262594;
					float4 ChannelA83_g262594 = Model_VertexMasks518_g262554;
					float4 appendResult3234_g262554 = (float4((Model_MasksData1322_g262554).xy , (Motion_MaskTex2819_g262554).b , 0.0));
					float4 ChannelB83_g262594 = appendResult3234_g262554;
					float localSwitchChannel883_g262594 = SwitchChannel8( Option83_g262594 , ChannelA83_g262594 , ChannelB83_g262594 );
					half Tiny_Mask_Legacy1807_g262554 = break1804_g262554.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g262554 = Tiny_Mask_Legacy1807_g262554;
					#else
					float staticSwitch1810_g262554 = localSwitchChannel883_g262594;
					#endif
					float clampResult17_g262561 = clamp( staticSwitch1810_g262554 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262562 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g262562 = ( clampResult17_g262561 - temp_output_7_0_g262562 );
					half Tiny_Mask218_g262554 = saturate( ( temp_output_9_0_g262562 * _MotionTinyMaskRemap.z ) );
					half3 Model_NormalOS554_g262554 = temp_output_2772_20_g262554;
					half3 Input_NormalOS533_g262576 = Model_NormalOS554_g262554;
					half3 Tiny_Position2469_g262554 = Model_PositionWO162_g262554;
					half3 Input_PositionWO500_g262576 = Tiny_Position2469_g262554;
					half Input_MotionTilling321_g262576 = ( _MotionTinyTillingValue + 0.1 );
					float lerpResult128_g262581 = lerp( _Time.y , ( ( _Time.y * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g262576 = _MotionTinySpeedValue;
					float4 tex2DNode514_g262576 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( ( (Input_PositionWO500_g262576).xz * Input_MotionTilling321_g262576 * 0.005 ) + ( lerpResult128_g262581 * Input_MotionSpeed62_g262576 * 0.02 ) ), 0.0 );
					half3 Flutter_Noise535_g262576 = (tex2DNode514_g262576.rgb*2.0 + -1.0);
					half Input_MotionNoise542_g262576 = _MotionTinyNoiseValue;
					float3 lerpResult537_g262576 = lerp( ( Input_NormalOS533_g262576 * Flutter_Noise535_g262576 ) , Flutter_Noise535_g262576 , Input_MotionNoise542_g262576);
					float mulTime113_g262582 = _Time.y * 2.0;
					float lerpResult128_g262582 = lerp( mulTime113_g262582 , ( ( mulTime113_g262582 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					float temp_output_578_0_g262576 = SAMPLE_TEXTURE3D_LOD( _NoiseTex3D, sampler_Linear_Repeat, ( ( Input_PositionWO500_g262576 + lerpResult128_g262582 ) * ( 1.0 * 0.01 ) ), 0.0 ).r;
					half Input_GlobalWind471_g262576 = Global_WindValue1855_g262554;
					float lerpResult579_g262576 = lerp( ( temp_output_578_0_g262576 * temp_output_578_0_g262576 * temp_output_578_0_g262576 * temp_output_578_0_g262576 ) , temp_output_578_0_g262576 , ( Input_GlobalWind471_g262576 * Input_GlobalWind471_g262576 ));
					float temp_output_20_0_g262580 = ( 1.0 - Input_GlobalWind471_g262576 );
					half Wind_Gust589_g262576 = ( ( lerpResult579_g262576 * ( 1.0 - ( temp_output_20_0_g262580 * temp_output_20_0_g262580 * temp_output_20_0_g262580 * temp_output_20_0_g262580 ) ) ) * 0.5 );
					half3 Tiny_Squash859_g262554 = ( lerpResult537_g262576 * Wind_Gust589_g262576 );
					half3 Tiny_Flutter1451_g262554 = ( _MotionTinyIntensityValue * Global_DistMask1820_g262554 * Tiny_Mask218_g262554 * Tiny_Squash859_g262554 * (Global_MotionParams3013_g262554).z );
					#ifdef TVE_MOTION
					float3 staticSwitch414_g262554 = Tiny_Flutter1451_g262554;
					#else
					float3 staticSwitch414_g262554 = temp_cast_19;
					#endif
					float4 appendResult2783_g262554 = (float4(( staticSwitch495_g262554 + staticSwitch414_g262554 ) , 0.0));
					half4 Final_TransformData1569_g262554 = ( Model_TransformData2743_g262554 + appendResult2783_g262554 );
					float4 In_TransformData16_g262555 = Final_TransformData1569_g262554;
					half4 Model_RotationData2740_g262554 = Out_RotationData15_g262556;
					half2 Input_WindDirWS803_g262595 = Global_WindDirWS2542_g262554;
					half3 Input_ModelPositionWO761_g262557 = Model_PositionWO162_g262554;
					half3 Input_ModelPivotsWO419_g262557 = Model_PivotWO402_g262554;
					half Input_MotionPivots629_g262557 = _MotionBasePivotValue;
					float3 lerpResult771_g262557 = lerp( Input_ModelPositionWO761_g262557 , Input_ModelPivotsWO419_g262557 , Input_MotionPivots629_g262557);
					half4 Input_ModelMotionData763_g262557 = Model_PhaseData489_g262554;
					half Input_MotionPhase764_g262557 = _MotionBasePhaseValue;
					float temp_output_770_0_g262557 = ( (Input_ModelMotionData763_g262557).x * Input_MotionPhase764_g262557 );
					half3 Base_Position1394_g262554 = ( lerpResult771_g262557 + temp_output_770_0_g262557 );
					half3 Input_PositionWO419_g262595 = Base_Position1394_g262554;
					half Input_MotionTilling321_g262595 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g262595 = ( -(Input_PositionWO419_g262595).xz * Input_MotionTilling321_g262595 * 0.005 );
					float2 temp_output_3_0_g262602 = Noise_Coord515_g262595;
					float2 temp_output_21_0_g262602 = Input_WindDirWS803_g262595;
					float mulTime113_g262596 = _Time.y * 0.02;
					float lerpResult128_g262596 = lerp( mulTime113_g262596 , ( ( mulTime113_g262596 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g262595 = _MotionBaseSpeedValue;
					half Noise_Speed516_g262595 = ( lerpResult128_g262596 * Input_MotionSpeed62_g262595 );
					float temp_output_15_0_g262602 = Noise_Speed516_g262595;
					float temp_output_23_0_g262602 = frac( temp_output_15_0_g262602 );
					float4 lerpResult39_g262602 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g262602 + ( temp_output_21_0_g262602 * temp_output_23_0_g262602 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g262602 + ( temp_output_21_0_g262602 * frac( ( temp_output_15_0_g262602 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g262602 - 0.5 ) ) / 0.5 ));
					float4 temp_output_635_0_g262595 = lerpResult39_g262602;
					half2 Noise_DirWS825_g262595 = ((temp_output_635_0_g262595).rg*2.0 + -1.0);
					half Input_MotionNoise552_g262595 = _MotionBaseNoiseValue;
					half Input_WindValue853_g262595 = Global_WindValue1855_g262554;
					float temp_output_6_0_g262599 = Input_WindValue853_g262595;
					float lerpResult701_g262595 = lerp( 1.0 , Input_MotionNoise552_g262595 , ( temp_output_6_0_g262599 * temp_output_6_0_g262599 ));
					half Input_PushNoise858_g262595 = Global_PushNoise2675_g262554;
					float2 lerpResult646_g262595 = lerp( Input_WindDirWS803_g262595 , Noise_DirWS825_g262595 , saturate( ( lerpResult701_g262595 + Input_PushNoise858_g262595 ) ));
					half2 Bend_Dir859_g262595 = lerpResult646_g262595;
					half Input_MotionValue871_g262595 = _MotionBaseIntensityValue;
					half Input_MotionDelay753_g262595 = _MotionBaseDelayValue;
					float lerpResult756_g262595 = lerp( 1.0 , ( Input_WindValue853_g262595 * Input_WindValue853_g262595 ) , Input_MotionDelay753_g262595);
					half Wind_Delay815_g262595 = lerpResult756_g262595;
					float2 temp_output_875_0_g262595 = ( Bend_Dir859_g262595 * Input_WindValue853_g262595 * Input_MotionValue871_g262595 * Wind_Delay815_g262595 );
					float2 Global_PushDirWS1972_g262554 = temp_output_3126_0_g262554;
					half2 Input_PushDirWS807_g262595 = Global_PushDirWS1972_g262554;
					half Input_ReactValue888_g262595 = _MotionBasePushValue;
					half Input_PushAlpha806_g262595 = Global_PushAlpha1504_g262554;
					half Push_Mask883_g262595 = saturate( ( Input_PushAlpha806_g262595 * Input_ReactValue888_g262595 ) );
					float2 lerpResult811_g262595 = lerp( temp_output_875_0_g262595 , ( Input_PushDirWS807_g262595 * Input_ReactValue888_g262595 ) , Push_Mask883_g262595);
					#ifdef TVE_MOTION_ELEMENT
					float2 staticSwitch808_g262595 = lerpResult811_g262595;
					#else
					float2 staticSwitch808_g262595 = temp_output_875_0_g262595;
					#endif
					float2 temp_output_38_0_g262600 = staticSwitch808_g262595;
					float2 break83_g262600 = temp_output_38_0_g262600;
					float3 appendResult79_g262600 = (float3(break83_g262600.x , 0.0 , break83_g262600.y));
					half2 Base_Bending893_g262554 = (( mul( unity_WorldToObject, float4( appendResult79_g262600 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
					float temp_output_17_0_g262592 = _MotionBaseMaskMode;
					float Option83_g262592 = temp_output_17_0_g262592;
					float4 ChannelA83_g262592 = Model_VertexMasks518_g262554;
					float4 appendResult3220_g262554 = (float4((Model_MasksData1322_g262554).xy , (Motion_MaskTex2819_g262554).r , 0.0));
					float4 ChannelB83_g262592 = appendResult3220_g262554;
					float localSwitchChannel883_g262592 = SwitchChannel8( Option83_g262592 , ChannelA83_g262592 , ChannelB83_g262592 );
					float clampResult17_g262564 = clamp( localSwitchChannel883_g262592 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262563 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g262563 = ( clampResult17_g262564 - temp_output_7_0_g262563 );
					half Base_Mask217_g262554 = saturate( ( temp_output_9_0_g262563 * _MotionBaseMaskRemap.z ) );
					half2 Base_Motion1440_g262554 = ( Base_Bending893_g262554 * Base_Mask217_g262554 * (Global_MotionParams3013_g262554).x );
					#ifdef TVE_MOTION
					float2 staticSwitch2384_g262554 = Base_Motion1440_g262554;
					#else
					float2 staticSwitch2384_g262554 = float2( 0,0 );
					#endif
					float4 appendResult2023_g262554 = (float4(staticSwitch2384_g262554 , 0.0 , 0.0));
					half4 Final_RotationData1570_g262554 = ( Model_RotationData2740_g262554 + appendResult2023_g262554 );
					float4 In_RotationData16_g262555 = Final_RotationData1570_g262554;
					half4 Model_Interpolator02773_g262554 = Out_InterpolatorA15_g262556;
					half4 Noise_Params685_g262595 = temp_output_635_0_g262595;
					float temp_output_6_0_g262598 = (Noise_Params685_g262595).a;
					float temp_output_913_0_g262595 = ( ( temp_output_6_0_g262598 * temp_output_6_0_g262598 * temp_output_6_0_g262598 * temp_output_6_0_g262598 ) * ( Input_WindValue853_g262595 * Wind_Delay815_g262595 ) );
					float temp_output_6_0_g262597 = length( Input_PushDirWS807_g262595 );
					float lerpResult902_g262595 = lerp( temp_output_913_0_g262595 , ( ( temp_output_6_0_g262597 * temp_output_6_0_g262597 ) * Input_PushNoise858_g262595 ) , Push_Mask883_g262595);
					#ifdef TVE_MOTION_ELEMENT
					float staticSwitch903_g262595 = lerpResult902_g262595;
					#else
					float staticSwitch903_g262595 = temp_output_913_0_g262595;
					#endif
					half Base_Wave1159_g262554 = staticSwitch903_g262595;
					float temp_output_6_0_g262612 = (Noise_Params685_g262605).a;
					float temp_output_955_0_g262605 = ( temp_output_6_0_g262612 * temp_output_6_0_g262612 * temp_output_6_0_g262612 * temp_output_6_0_g262612 );
					float temp_output_944_0_g262605 = ( temp_output_955_0_g262605 * ( Input_WindValue881_g262605 * Wind_Delay815_g262605 ) );
					float lerpResult936_g262605 = lerp( temp_output_944_0_g262605 , ( temp_output_955_0_g262605 * Input_PushNoise890_g262605 ) , Push_Mask914_g262605);
					#ifdef TVE_MOTION_ELEMENT
					float staticSwitch939_g262605 = lerpResult936_g262605;
					#else
					float staticSwitch939_g262605 = temp_output_944_0_g262605;
					#endif
					half Small_Wave1427_g262554 = staticSwitch939_g262605;
					float lerpResult2422_g262554 = lerp( Base_Wave1159_g262554 , Small_Wave1427_g262554 , _motion_small_mode);
					half Global_Wave1475_g262554 = saturate( lerpResult2422_g262554 );
					float temp_output_6_0_g262565 = ( _MotionHighlightValue * Global_DistMask1820_g262554 * ( Tiny_Mask218_g262554 * Tiny_Mask218_g262554 ) * Global_Wave1475_g262554 );
					float temp_output_7_0_g262565 = _MotionHighlightColor.r;
					#ifdef TVE_DUMMY
					float staticSwitch14_g262565 = ( temp_output_6_0_g262565 + temp_output_7_0_g262565 );
					#else
					float staticSwitch14_g262565 = temp_output_6_0_g262565;
					#endif
					#ifdef TVE_MOTION
					float staticSwitch2866_g262554 = staticSwitch14_g262565;
					#else
					float staticSwitch2866_g262554 = 0.0;
					#endif
					float4 appendResult2775_g262554 = (float4((Model_Interpolator02773_g262554).xyz , staticSwitch2866_g262554));
					half4 Final_Interpolator02774_g262554 = appendResult2775_g262554;
					float4 In_InterpolatorA16_g262555 = Final_Interpolator02774_g262554;
					BuildModelVertData( Data16_g262555 , In_Dummy16_g262555 , In_PositionOS16_g262555 , In_PositionWS16_g262555 , In_PositionWO16_g262555 , In_PositionRawOS16_g262555 , In_PivotOS16_g262555 , In_PivotWS16_g262555 , In_PivotWO16_g262555 , In_NormalOS16_g262555 , In_NormalWS16_g262555 , In_NormalRawOS16_g262555 , In_TangentOS16_g262555 , In_TangentWS16_g262555 , In_BitangentWS16_g262555 , In_ViewDirWS16_g262555 , In_CoordsData16_g262555 , In_VertexData16_g262555 , In_MasksData16_g262555 , In_PhaseData16_g262555 , In_TransformData16_g262555 , In_RotationData16_g262555 , In_InterpolatorA16_g262555 );
					TVEModelData Data15_g262614 =(TVEModelData)Data16_g262555;
					float Out_Dummy15_g262614 = 0.0;
					float3 Out_PositionOS15_g262614 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262614 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262614 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262614 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262614 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262614 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262614 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262614 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262614 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262614 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262614 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262614 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262614 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262614 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262614 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262614 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262614 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262614 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262614 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262614 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262614 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262614 , Out_Dummy15_g262614 , Out_PositionOS15_g262614 , Out_PositionWS15_g262614 , Out_PositionWO15_g262614 , Out_PositionRawOS15_g262614 , Out_PivotOS15_g262614 , Out_PivotWS15_g262614 , Out_PivotWO15_g262614 , Out_NormalOS15_g262614 , Out_NormalWS15_g262614 , Out_NormalRawOS15_g262614 , Out_TangentOS15_g262614 , Out_TangentWS15_g262614 , Out_BitangentWS15_g262614 , Out_ViewDirWS15_g262614 , Out_CoordsData15_g262614 , Out_VertexData15_g262614 , Out_MasksData15_g262614 , Out_PhaseData15_g262614 , Out_TransformData15_g262614 , Out_RotationData15_g262614 , Out_InterpolatorA15_g262614 );
					TVEModelData Data16_g262615 =(TVEModelData)Data15_g262614;
					float temp_output_14_0_g262615 = 0.0;
					float In_Dummy16_g262615 = temp_output_14_0_g262615;
					float3 Model_PositionOS147_g262613 = Out_PositionOS15_g262614;
					half3 VertexPos40_g262619 = Model_PositionOS147_g262613;
					float4 temp_output_1567_33_g262613 = Out_RotationData15_g262614;
					half4 Model_RotationData1569_g262613 = temp_output_1567_33_g262613;
					float2 break1582_g262613 = (Model_RotationData1569_g262613).xy;
					half Angle44_g262619 = break1582_g262613.y;
					half CosAngle89_g262619 = cos( Angle44_g262619 );
					half SinAngle93_g262619 = sin( Angle44_g262619 );
					float3 appendResult95_g262619 = (float3((VertexPos40_g262619).x , ( ( (VertexPos40_g262619).y * CosAngle89_g262619 ) - ( (VertexPos40_g262619).z * SinAngle93_g262619 ) ) , ( ( (VertexPos40_g262619).y * SinAngle93_g262619 ) + ( (VertexPos40_g262619).z * CosAngle89_g262619 ) )));
					half3 VertexPos40_g262620 = appendResult95_g262619;
					half Angle44_g262620 = -break1582_g262613.x;
					half CosAngle94_g262620 = cos( Angle44_g262620 );
					half SinAngle95_g262620 = sin( Angle44_g262620 );
					float3 appendResult98_g262620 = (float3(( ( (VertexPos40_g262620).x * CosAngle94_g262620 ) - ( (VertexPos40_g262620).y * SinAngle95_g262620 ) ) , ( ( (VertexPos40_g262620).x * SinAngle95_g262620 ) + ( (VertexPos40_g262620).y * CosAngle94_g262620 ) ) , (VertexPos40_g262620).z));
					half3 VertexPos40_g262618 = Model_PositionOS147_g262613;
					half Angle44_g262618 = break1582_g262613.y;
					half CosAngle89_g262618 = cos( Angle44_g262618 );
					half SinAngle93_g262618 = sin( Angle44_g262618 );
					float3 appendResult95_g262618 = (float3((VertexPos40_g262618).x , ( ( (VertexPos40_g262618).y * CosAngle89_g262618 ) - ( (VertexPos40_g262618).z * SinAngle93_g262618 ) ) , ( ( (VertexPos40_g262618).y * SinAngle93_g262618 ) + ( (VertexPos40_g262618).z * CosAngle89_g262618 ) )));
					half3 VertexPos40_g262623 = appendResult95_g262618;
					half Angle44_g262623 = break1582_g262613.x;
					half CosAngle91_g262623 = cos( Angle44_g262623 );
					half SinAngle92_g262623 = sin( Angle44_g262623 );
					float3 appendResult93_g262623 = (float3(( ( (VertexPos40_g262623).x * CosAngle91_g262623 ) + ( (VertexPos40_g262623).z * SinAngle92_g262623 ) ) , (VertexPos40_g262623).y , ( ( -(VertexPos40_g262623).x * SinAngle92_g262623 ) + ( (VertexPos40_g262623).z * CosAngle91_g262623 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262621 = appendResult93_g262623;
					#else
					float3 staticSwitch65_g262621 = appendResult98_g262620;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g262616 = staticSwitch65_g262621;
					#else
					float3 staticSwitch65_g262616 = Model_PositionOS147_g262613;
					#endif
					float3 temp_output_1608_0_g262613 = staticSwitch65_g262616;
					half3 VertexPos40_g262622 = temp_output_1608_0_g262613;
					half Angle44_g262622 = (Model_RotationData1569_g262613).z;
					half CosAngle91_g262622 = cos( Angle44_g262622 );
					half SinAngle92_g262622 = sin( Angle44_g262622 );
					float3 appendResult93_g262622 = (float3(( ( (VertexPos40_g262622).x * CosAngle91_g262622 ) + ( (VertexPos40_g262622).z * SinAngle92_g262622 ) ) , (VertexPos40_g262622).y , ( ( -(VertexPos40_g262622).x * SinAngle92_g262622 ) + ( (VertexPos40_g262622).z * CosAngle91_g262622 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g262617 = appendResult93_g262622;
					#else
					float3 staticSwitch65_g262617 = temp_output_1608_0_g262613;
					#endif
					float4 temp_output_1567_31_g262613 = Out_TransformData15_g262614;
					half4 Model_TransformData1568_g262613 = temp_output_1567_31_g262613;
					half3 Final_PositionOS178_g262613 = ( ( staticSwitch65_g262617 * (Model_TransformData1568_g262613).w ) + (Model_TransformData1568_g262613).xyz );
					float3 temp_output_4_0_g262615 = Final_PositionOS178_g262613;
					float3 In_PositionOS16_g262615 = temp_output_4_0_g262615;
					float3 In_PositionWS16_g262615 = Out_PositionWS15_g262614;
					float3 In_PositionWO16_g262615 = Out_PositionWO15_g262614;
					float3 In_PositionRawOS16_g262615 = Out_PositionRawOS15_g262614;
					float3 In_PivotOS16_g262615 = Out_PivotOS15_g262614;
					float3 In_PivotWS16_g262615 = Out_PivotWS15_g262614;
					float3 In_PivotWO16_g262615 = Out_PivotWO15_g262614;
					float3 temp_output_21_0_g262615 = Out_NormalOS15_g262614;
					float3 In_NormalOS16_g262615 = temp_output_21_0_g262615;
					float3 In_NormalWS16_g262615 = Out_NormalWS15_g262614;
					float3 In_NormalRawOS16_g262615 = Out_NormalRawOS15_g262614;
					float4 temp_output_6_0_g262615 = Out_TangentOS15_g262614;
					float4 In_TangentOS16_g262615 = temp_output_6_0_g262615;
					float3 In_TangentWS16_g262615 = Out_TangentWS15_g262614;
					float3 In_BitangentWS16_g262615 = Out_BitangentWS15_g262614;
					float3 In_ViewDirWS16_g262615 = Out_ViewDirWS15_g262614;
					float4 In_CoordsData16_g262615 = Out_CoordsData15_g262614;
					float4 In_VertexData16_g262615 = Out_VertexData15_g262614;
					float4 In_MasksData16_g262615 = Out_MasksData15_g262614;
					float4 In_PhaseData16_g262615 = Out_PhaseData15_g262614;
					float4 In_TransformData16_g262615 = temp_output_1567_31_g262613;
					float4 In_RotationData16_g262615 = temp_output_1567_33_g262613;
					float4 In_InterpolatorA16_g262615 = Out_InterpolatorA15_g262614;
					BuildModelVertData( Data16_g262615 , In_Dummy16_g262615 , In_PositionOS16_g262615 , In_PositionWS16_g262615 , In_PositionWO16_g262615 , In_PositionRawOS16_g262615 , In_PivotOS16_g262615 , In_PivotWS16_g262615 , In_PivotWO16_g262615 , In_NormalOS16_g262615 , In_NormalWS16_g262615 , In_NormalRawOS16_g262615 , In_TangentOS16_g262615 , In_TangentWS16_g262615 , In_BitangentWS16_g262615 , In_ViewDirWS16_g262615 , In_CoordsData16_g262615 , In_VertexData16_g262615 , In_MasksData16_g262615 , In_PhaseData16_g262615 , In_TransformData16_g262615 , In_RotationData16_g262615 , In_InterpolatorA16_g262615 );
					TVEModelData Data15_g262625 =(TVEModelData)Data16_g262615;
					float Out_Dummy15_g262625 = 0.0;
					float3 Out_PositionOS15_g262625 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262625 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262625 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262625 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262625 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262625 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262625 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262625 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262625 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262625 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262625 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262625 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262625 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262625 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262625 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262625 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262625 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262625 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262625 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262625 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262625 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262625 , Out_Dummy15_g262625 , Out_PositionOS15_g262625 , Out_PositionWS15_g262625 , Out_PositionWO15_g262625 , Out_PositionRawOS15_g262625 , Out_PivotOS15_g262625 , Out_PivotWS15_g262625 , Out_PivotWO15_g262625 , Out_NormalOS15_g262625 , Out_NormalWS15_g262625 , Out_NormalRawOS15_g262625 , Out_TangentOS15_g262625 , Out_TangentWS15_g262625 , Out_BitangentWS15_g262625 , Out_ViewDirWS15_g262625 , Out_CoordsData15_g262625 , Out_VertexData15_g262625 , Out_MasksData15_g262625 , Out_PhaseData15_g262625 , Out_TransformData15_g262625 , Out_RotationData15_g262625 , Out_InterpolatorA15_g262625 );
					TVEModelData Data16_g262627 =(TVEModelData)Data15_g262625;
					half Dummy1823_g262624 = ( _FlattenCategory + _FlattenEnd + _FlattenBakeMode );
					float temp_output_14_0_g262627 = Dummy1823_g262624;
					float In_Dummy16_g262627 = temp_output_14_0_g262627;
					float3 temp_output_4_0_g262627 = Out_PositionOS15_g262625;
					float3 In_PositionOS16_g262627 = temp_output_4_0_g262627;
					float3 In_PositionWS16_g262627 = Out_PositionWS15_g262625;
					float3 In_PositionWO16_g262627 = Out_PositionWO15_g262625;
					float3 temp_output_1810_26_g262624 = Out_PositionRawOS15_g262625;
					float3 In_PositionRawOS16_g262627 = temp_output_1810_26_g262624;
					float3 In_PivotOS16_g262627 = Out_PivotOS15_g262625;
					float3 In_PivotWS16_g262627 = Out_PivotWS15_g262625;
					float3 In_PivotWO16_g262627 = Out_PivotWO15_g262625;
					half3 Model_NormalOS1829_g262624 = Out_NormalOS15_g262625;
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262626 = half3( 0, 0, 1 );
					#else
					float3 staticSwitch65_g262626 = half3( 0, 1, 0 );
					#endif
					float3 lerpResult1820_g262624 = lerp( Model_NormalOS1829_g262624 , staticSwitch65_g262626 , _FlattenIntensityValue);
					float3 Model_PositionBaseOS1837_g262624 = temp_output_1810_26_g262624;
					float3 normalizeResult1816_g262624 = ASESafeNormalize( ( Model_PositionBaseOS1837_g262624 + _FlattenSphereOffsetValue ) );
					float3 lerpResult1813_g262624 = lerp( lerpResult1820_g262624 , normalizeResult1816_g262624 , _FlattenSphereValue);
					float temp_output_17_0_g262634 = _FlattenMeshMode;
					float Option70_g262634 = temp_output_17_0_g262634;
					float4 temp_output_1810_29_g262624 = Out_VertexData15_g262625;
					half4 Model_VertexData1826_g262624 = temp_output_1810_29_g262624;
					float4 temp_output_3_0_g262634 = Model_VertexData1826_g262624;
					float4 Channel70_g262634 = temp_output_3_0_g262634;
					float localSwitchChannel470_g262634 = SwitchChannel4( Option70_g262634 , Channel70_g262634 );
					float clampResult17_g262628 = clamp( localSwitchChannel470_g262634 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262629 = _FlattenMeshRemap.x;
					float temp_output_9_0_g262629 = ( clampResult17_g262628 - temp_output_7_0_g262629 );
					float lerpResult1841_g262624 = lerp( 1.0 , saturate( ( temp_output_9_0_g262629 * _FlattenMeshRemap.z ) ) , _FlattenMeshValue);
					half Normal_MeskMask1847_g262624 = lerpResult1841_g262624;
					half Normal_Mask1851_g262624 = Normal_MeskMask1847_g262624;
					float3 lerpResult1856_g262624 = lerp( Model_NormalOS1829_g262624 , lerpResult1813_g262624 , Normal_Mask1851_g262624);
					#ifdef TVE_FLATTEN
					float3 staticSwitch1857_g262624 = lerpResult1856_g262624;
					#else
					float3 staticSwitch1857_g262624 = Model_NormalOS1829_g262624;
					#endif
					half3 Final_NormalOS1853_g262624 = staticSwitch1857_g262624;
					float3 temp_output_21_0_g262627 = Final_NormalOS1853_g262624;
					float3 In_NormalOS16_g262627 = temp_output_21_0_g262627;
					float3 In_NormalWS16_g262627 = Out_NormalWS15_g262625;
					float3 In_NormalRawOS16_g262627 = Out_NormalRawOS15_g262625;
					float4 temp_output_6_0_g262627 = Out_TangentOS15_g262625;
					float4 In_TangentOS16_g262627 = temp_output_6_0_g262627;
					float3 In_TangentWS16_g262627 = Out_TangentWS15_g262625;
					float3 In_BitangentWS16_g262627 = Out_BitangentWS15_g262625;
					float3 In_ViewDirWS16_g262627 = Out_ViewDirWS15_g262625;
					float4 In_CoordsData16_g262627 = Out_CoordsData15_g262625;
					float4 In_VertexData16_g262627 = temp_output_1810_29_g262624;
					float4 In_MasksData16_g262627 = Out_MasksData15_g262625;
					float4 In_PhaseData16_g262627 = Out_PhaseData15_g262625;
					float4 In_TransformData16_g262627 = Out_TransformData15_g262625;
					float4 In_RotationData16_g262627 = Out_RotationData15_g262625;
					float4 In_InterpolatorA16_g262627 = Out_InterpolatorA15_g262625;
					BuildModelVertData( Data16_g262627 , In_Dummy16_g262627 , In_PositionOS16_g262627 , In_PositionWS16_g262627 , In_PositionWO16_g262627 , In_PositionRawOS16_g262627 , In_PivotOS16_g262627 , In_PivotWS16_g262627 , In_PivotWO16_g262627 , In_NormalOS16_g262627 , In_NormalWS16_g262627 , In_NormalRawOS16_g262627 , In_TangentOS16_g262627 , In_TangentWS16_g262627 , In_BitangentWS16_g262627 , In_ViewDirWS16_g262627 , In_CoordsData16_g262627 , In_VertexData16_g262627 , In_MasksData16_g262627 , In_PhaseData16_g262627 , In_TransformData16_g262627 , In_RotationData16_g262627 , In_InterpolatorA16_g262627 );
					TVEModelData Data15_g262641 =(TVEModelData)Data16_g262627;
					float Out_Dummy15_g262641 = 0.0;
					float3 Out_PositionOS15_g262641 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262641 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262641 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262641 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262641 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262641 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262641 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262641 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262641 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262641 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262641 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262641 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262641 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262641 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262641 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262641 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262641 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262641 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262641 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262641 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262641 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262641 , Out_Dummy15_g262641 , Out_PositionOS15_g262641 , Out_PositionWS15_g262641 , Out_PositionWO15_g262641 , Out_PositionRawOS15_g262641 , Out_PivotOS15_g262641 , Out_PivotWS15_g262641 , Out_PivotWO15_g262641 , Out_NormalOS15_g262641 , Out_NormalWS15_g262641 , Out_NormalRawOS15_g262641 , Out_TangentOS15_g262641 , Out_TangentWS15_g262641 , Out_BitangentWS15_g262641 , Out_ViewDirWS15_g262641 , Out_CoordsData15_g262641 , Out_VertexData15_g262641 , Out_MasksData15_g262641 , Out_PhaseData15_g262641 , Out_TransformData15_g262641 , Out_RotationData15_g262641 , Out_InterpolatorA15_g262641 );
					TVEModelData Data16_g262636 =(TVEModelData)Data15_g262641;
					half Dummy1575_g262635 = ( _ReshadeCategory + _ReshadeEnd );
					float temp_output_14_0_g262636 = Dummy1575_g262635;
					float In_Dummy16_g262636 = temp_output_14_0_g262636;
					float3 temp_output_4_0_g262636 = Out_PositionOS15_g262641;
					float3 In_PositionOS16_g262636 = temp_output_4_0_g262636;
					float3 In_PositionWS16_g262636 = Out_PositionWS15_g262641;
					float3 In_PositionWO16_g262636 = Out_PositionWO15_g262641;
					float3 In_PositionRawOS16_g262636 = Out_PositionRawOS15_g262641;
					float3 In_PivotOS16_g262636 = Out_PivotOS15_g262641;
					float3 In_PivotWS16_g262636 = Out_PivotWS15_g262641;
					float3 In_PivotWO16_g262636 = Out_PivotWO15_g262641;
					half3 Model_NormalOS1568_g262635 = Out_NormalOS15_g262641;
					half3 VertexPos40_g262638 = Model_NormalOS1568_g262635;
					half3 VertexPos40_g262639 = VertexPos40_g262638;
					float4 temp_output_1567_33_g262635 = Out_RotationData15_g262641;
					half4 Model_RotationData1583_g262635 = temp_output_1567_33_g262635;
					half2 Angle44_g262638 = Model_RotationData1583_g262635.xy;
					half Angle44_g262639 = (Angle44_g262638).y;
					half CosAngle89_g262639 = cos( Angle44_g262639 );
					half SinAngle93_g262639 = sin( Angle44_g262639 );
					float3 appendResult95_g262639 = (float3((VertexPos40_g262639).x , ( ( (VertexPos40_g262639).y * CosAngle89_g262639 ) - ( (VertexPos40_g262639).z * SinAngle93_g262639 ) ) , ( ( (VertexPos40_g262639).y * SinAngle93_g262639 ) + ( (VertexPos40_g262639).z * CosAngle89_g262639 ) )));
					half3 VertexPos40_g262640 = appendResult95_g262639;
					half Angle44_g262640 = -(Angle44_g262638).x;
					half CosAngle94_g262640 = cos( Angle44_g262640 );
					half SinAngle95_g262640 = sin( Angle44_g262640 );
					float3 appendResult98_g262640 = (float3(( ( (VertexPos40_g262640).x * CosAngle94_g262640 ) - ( (VertexPos40_g262640).y * SinAngle95_g262640 ) ) , ( ( (VertexPos40_g262640).x * SinAngle95_g262640 ) + ( (VertexPos40_g262640).y * CosAngle94_g262640 ) ) , (VertexPos40_g262640).z));
					float3 lerpResult1591_g262635 = lerp( Model_NormalOS1568_g262635 , appendResult98_g262640 , _ReshadeIntensityValue);
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g262637 = lerpResult1591_g262635;
					#else
					float3 staticSwitch65_g262637 = Model_NormalOS1568_g262635;
					#endif
					float3 temp_output_1732_0_g262635 = staticSwitch65_g262637;
					#ifdef TVE_RESHADE
					float3 staticSwitch1716_g262635 = temp_output_1732_0_g262635;
					#else
					float3 staticSwitch1716_g262635 = Model_NormalOS1568_g262635;
					#endif
					half3 Final_NormalOS178_g262635 = staticSwitch1716_g262635;
					float3 temp_output_21_0_g262636 = Final_NormalOS178_g262635;
					float3 In_NormalOS16_g262636 = temp_output_21_0_g262636;
					float3 In_NormalWS16_g262636 = Out_NormalWS15_g262641;
					float3 In_NormalRawOS16_g262636 = Out_NormalRawOS15_g262641;
					float4 temp_output_6_0_g262636 = Out_TangentOS15_g262641;
					float4 In_TangentOS16_g262636 = temp_output_6_0_g262636;
					float3 In_TangentWS16_g262636 = Out_TangentWS15_g262641;
					float3 In_BitangentWS16_g262636 = Out_BitangentWS15_g262641;
					float3 In_ViewDirWS16_g262636 = Out_ViewDirWS15_g262641;
					float4 In_CoordsData16_g262636 = Out_CoordsData15_g262641;
					float4 In_VertexData16_g262636 = Out_VertexData15_g262641;
					float4 In_MasksData16_g262636 = Out_MasksData15_g262641;
					float4 In_PhaseData16_g262636 = Out_PhaseData15_g262641;
					float4 In_TransformData16_g262636 = Out_TransformData15_g262641;
					float4 In_RotationData16_g262636 = temp_output_1567_33_g262635;
					float4 In_InterpolatorA16_g262636 = Out_InterpolatorA15_g262641;
					BuildModelVertData( Data16_g262636 , In_Dummy16_g262636 , In_PositionOS16_g262636 , In_PositionWS16_g262636 , In_PositionWO16_g262636 , In_PositionRawOS16_g262636 , In_PivotOS16_g262636 , In_PivotWS16_g262636 , In_PivotWO16_g262636 , In_NormalOS16_g262636 , In_NormalWS16_g262636 , In_NormalRawOS16_g262636 , In_TangentOS16_g262636 , In_TangentWS16_g262636 , In_BitangentWS16_g262636 , In_ViewDirWS16_g262636 , In_CoordsData16_g262636 , In_VertexData16_g262636 , In_MasksData16_g262636 , In_PhaseData16_g262636 , In_TransformData16_g262636 , In_RotationData16_g262636 , In_InterpolatorA16_g262636 );
					TVEModelData Data15_g262654 =(TVEModelData)Data16_g262636;
					float Out_Dummy15_g262654 = 0.0;
					float3 Out_PositionOS15_g262654 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262654 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262654 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262654 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262654 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262654 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262654 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262654 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262654 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262654 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262654 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262654 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262654 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262654 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262654 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262654 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262654 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262654 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262654 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262654 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262654 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262654 , Out_Dummy15_g262654 , Out_PositionOS15_g262654 , Out_PositionWS15_g262654 , Out_PositionWO15_g262654 , Out_PositionRawOS15_g262654 , Out_PivotOS15_g262654 , Out_PivotWS15_g262654 , Out_PivotWO15_g262654 , Out_NormalOS15_g262654 , Out_NormalWS15_g262654 , Out_NormalRawOS15_g262654 , Out_TangentOS15_g262654 , Out_TangentWS15_g262654 , Out_BitangentWS15_g262654 , Out_ViewDirWS15_g262654 , Out_CoordsData15_g262654 , Out_VertexData15_g262654 , Out_MasksData15_g262654 , Out_PhaseData15_g262654 , Out_TransformData15_g262654 , Out_RotationData15_g262654 , Out_InterpolatorA15_g262654 );
					TVEModelData Data16_g262655 =(TVEModelData)Data15_g262654;
					half Dummy1575_g262645 = ( _TransferCategory + _TransferEnd + _TransferSpace );
					float temp_output_14_0_g262655 = Dummy1575_g262645;
					float In_Dummy16_g262655 = temp_output_14_0_g262655;
					float3 temp_output_4_0_g262655 = Out_PositionOS15_g262654;
					float3 In_PositionOS16_g262655 = temp_output_4_0_g262655;
					float3 In_PositionWS16_g262655 = Out_PositionWS15_g262654;
					float3 temp_output_1567_17_g262645 = Out_PositionWO15_g262654;
					float3 In_PositionWO16_g262655 = temp_output_1567_17_g262645;
					float3 temp_output_1567_26_g262645 = Out_PositionRawOS15_g262654;
					float3 In_PositionRawOS16_g262655 = temp_output_1567_26_g262645;
					float3 In_PivotOS16_g262655 = Out_PivotOS15_g262654;
					float3 In_PivotWS16_g262655 = Out_PivotWS15_g262654;
					float3 In_PivotWO16_g262655 = Out_PivotWO15_g262654;
					half3 Model_NormalOS1568_g262645 = Out_NormalOS15_g262654;
					TVEGlobalData Data15_g262660 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262660 = 0.0;
					float4 Out_CoatParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262660 = float4( 0,0,0,0 );
					BreakData( Data15_g262660 , Out_Dummy15_g262660 , Out_CoatParams15_g262660 , Out_CoatTexture15_g262660 , Out_PaintParams15_g262660 , Out_PaintTexture15_g262660 , Out_AtmoParams15_g262660 , Out_AtmoTexture15_g262660 , Out_GlowParams15_g262660 , Out_GlowTexture15_g262660 , Out_FormParams15_g262660 , Out_FormTexture15_g262660 , Out_FlowParams15_g262660 , Out_FlowTexture15_g262660 );
					half4 Global_FormTexture1633_g262645 = Out_FormTexture15_g262660;
					float2 temp_output_1627_0_g262645 = ((Global_FormTexture1633_g262645).xy*2.0 + -1.0);
					float2 break1617_g262645 = temp_output_1627_0_g262645;
					float dotResult1619_g262645 = dot( temp_output_1627_0_g262645 , temp_output_1627_0_g262645 );
					float3 appendResult1618_g262645 = (float3(break1617_g262645.x , sqrt( ( 1.0 - saturate( dotResult1619_g262645 ) ) ) , break1617_g262645.y));
					float3 worldToObjDir1623_g262645 = mul( unity_WorldToObject, float4( appendResult1618_g262645, 0.0 ) ).xyz;
					half3 Conform_Normal1630_g262645 = worldToObjDir1623_g262645;
					float temp_output_6_0_g262646 = ( _TransferIntensityValue * TVE_IsEnabled );
					float temp_output_7_0_g262646 = ( _TransferPerPixelMode + _TransferInfo );
					#ifdef TVE_DUMMY
					float staticSwitch14_g262646 = ( temp_output_6_0_g262646 + temp_output_7_0_g262646 );
					#else
					float staticSwitch14_g262646 = temp_output_6_0_g262646;
					#endif
					half Conform_Value1742_g262645 = staticSwitch14_g262646;
					float3 temp_output_1567_21_g262645 = Out_NormalWS15_g262654;
					half3 Model_NormalWS1639_g262645 = temp_output_1567_21_g262645;
					float temp_output_1646_0_g262645 = (Model_NormalWS1639_g262645).y;
					float temp_output_7_0_g262649 = _TransferProjRemap.x;
					float temp_output_9_0_g262649 = ( saturate( temp_output_1646_0_g262645 ) - temp_output_7_0_g262649 );
					float lerpResult1669_g262645 = lerp( 1.0 , saturate( ( temp_output_9_0_g262649 * _TransferProjRemap.z ) ) , _TransferProjValue);
					half Normal_Proj_Mask1647_g262645 = lerpResult1669_g262645;
					float temp_output_17_0_g262653 = _TransferMeshMode;
					float Option70_g262653 = temp_output_17_0_g262653;
					float4 temp_output_1567_29_g262645 = Out_VertexData15_g262654;
					half4 Model_VertexData1608_g262645 = temp_output_1567_29_g262645;
					float4 temp_output_3_0_g262653 = Model_VertexData1608_g262645;
					float4 Channel70_g262653 = temp_output_3_0_g262653;
					float localSwitchChannel470_g262653 = SwitchChannel4( Option70_g262653 , Channel70_g262653 );
					float temp_output_1857_0_g262645 = localSwitchChannel470_g262653;
					float temp_output_7_0_g262651 = _TransferMeshRemap.x;
					float temp_output_9_0_g262651 = ( temp_output_1857_0_g262645 - temp_output_7_0_g262651 );
					float lerpResult1820_g262645 = lerp( 1.0 , saturate( ( temp_output_9_0_g262651 * _TransferMeshRemap.z ) ) , _TransferMeshValue);
					half Blend_VertMask1825_g262645 = lerpResult1820_g262645;
					float3 Model_PositionWO1640_g262645 = temp_output_1567_17_g262645;
					float temp_output_64_0_g262652 = saturate( ( ( (Global_FormTexture1633_g262645).z - (Model_PositionWO1640_g262645).y ) + _TransferFormOffsetValue ) );
					float temp_output_66_0_g262652 = _TransferFormValue;
					float lerpResult71_g262652 = lerp( 1.0 , temp_output_64_0_g262652 , ( temp_output_66_0_g262652 * _TransferFormMode ));
					half Normal_FormMask_Mul1708_g262645 = lerpResult71_g262652;
					half Normal_FormMask_Add1629_g262645 = ( temp_output_64_0_g262652 * temp_output_66_0_g262652 );
					half Normal_Mask1748_g262645 = saturate( ( ( Conform_Value1742_g262645 * Normal_Proj_Mask1647_g262645 * Blend_VertMask1825_g262645 * Normal_FormMask_Mul1708_g262645 ) + Normal_FormMask_Add1629_g262645 ) );
					float3 lerpResult1670_g262645 = lerp( Model_NormalOS1568_g262645 , Conform_Normal1630_g262645 , Normal_Mask1748_g262645);
					#ifdef TVE_TRANSFER
					float3 staticSwitch1716_g262645 = lerpResult1670_g262645;
					#else
					float3 staticSwitch1716_g262645 = Model_NormalOS1568_g262645;
					#endif
					half3 Final_NormalOS178_g262645 = staticSwitch1716_g262645;
					float3 temp_output_21_0_g262655 = Final_NormalOS178_g262645;
					float3 In_NormalOS16_g262655 = temp_output_21_0_g262655;
					float3 In_NormalWS16_g262655 = temp_output_1567_21_g262645;
					float3 In_NormalRawOS16_g262655 = Out_NormalRawOS15_g262654;
					half4 Model_TangentOS1749_g262645 = Out_TangentOS15_g262654;
					float4 appendResult1746_g262645 = (float4(cross( worldToObjDir1623_g262645 , float3( 0, 0, 1 ) ) , -1.0));
					half4 Conform_Tangent1747_g262645 = appendResult1746_g262645;
					float4 lerpResult1757_g262645 = lerp( Model_TangentOS1749_g262645 , Conform_Tangent1747_g262645 , Normal_Mask1748_g262645);
					#ifdef TVE_TRANSFER
					float4 staticSwitch1760_g262645 = lerpResult1757_g262645;
					#else
					float4 staticSwitch1760_g262645 = Model_TangentOS1749_g262645;
					#endif
					half4 Final_TangentOS1762_g262645 = staticSwitch1760_g262645;
					float4 temp_output_6_0_g262655 = Final_TangentOS1762_g262645;
					float4 In_TangentOS16_g262655 = temp_output_6_0_g262655;
					float3 In_TangentWS16_g262655 = Out_TangentWS15_g262654;
					float3 In_BitangentWS16_g262655 = Out_BitangentWS15_g262654;
					float3 In_ViewDirWS16_g262655 = Out_ViewDirWS15_g262654;
					float4 In_CoordsData16_g262655 = Out_CoordsData15_g262654;
					float4 In_VertexData16_g262655 = temp_output_1567_29_g262645;
					float4 In_MasksData16_g262655 = Out_MasksData15_g262654;
					float4 In_PhaseData16_g262655 = Out_PhaseData15_g262654;
					float4 In_TransformData16_g262655 = Out_TransformData15_g262654;
					float4 temp_output_1567_33_g262645 = Out_RotationData15_g262654;
					float4 In_RotationData16_g262655 = temp_output_1567_33_g262645;
					half4 Model_Interpolator01775_g262645 = Out_InterpolatorA15_g262654;
					float4 break1777_g262645 = Model_Interpolator01775_g262645;
					float4 appendResult1778_g262645 = (float4(break1777_g262645.x , break1777_g262645.y , Normal_Mask1748_g262645 , break1777_g262645.w));
					#ifdef TVE_TRANSFER
					float4 staticSwitch1779_g262645 = appendResult1778_g262645;
					#else
					float4 staticSwitch1779_g262645 = Model_Interpolator01775_g262645;
					#endif
					half4 Final_Interpolator01780_g262645 = staticSwitch1779_g262645;
					float4 In_InterpolatorA16_g262655 = Final_Interpolator01780_g262645;
					BuildModelVertData( Data16_g262655 , In_Dummy16_g262655 , In_PositionOS16_g262655 , In_PositionWS16_g262655 , In_PositionWO16_g262655 , In_PositionRawOS16_g262655 , In_PivotOS16_g262655 , In_PivotWS16_g262655 , In_PivotWO16_g262655 , In_NormalOS16_g262655 , In_NormalWS16_g262655 , In_NormalRawOS16_g262655 , In_TangentOS16_g262655 , In_TangentWS16_g262655 , In_BitangentWS16_g262655 , In_ViewDirWS16_g262655 , In_CoordsData16_g262655 , In_VertexData16_g262655 , In_MasksData16_g262655 , In_PhaseData16_g262655 , In_TransformData16_g262655 , In_RotationData16_g262655 , In_InterpolatorA16_g262655 );
					TVEModelData Data15_g262662 =(TVEModelData)Data16_g262655;
					float Out_Dummy15_g262662 = 0.0;
					float3 Out_PositionOS15_g262662 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262662 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262662 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262662 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262662 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262662 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262662 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262662 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262662 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262662 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262662 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262662 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262662 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262662 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262662 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262662 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262662 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262662 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262662 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262662 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262662 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262662 , Out_Dummy15_g262662 , Out_PositionOS15_g262662 , Out_PositionWS15_g262662 , Out_PositionWO15_g262662 , Out_PositionRawOS15_g262662 , Out_PivotOS15_g262662 , Out_PivotWS15_g262662 , Out_PivotWO15_g262662 , Out_NormalOS15_g262662 , Out_NormalWS15_g262662 , Out_NormalRawOS15_g262662 , Out_TangentOS15_g262662 , Out_TangentWS15_g262662 , Out_BitangentWS15_g262662 , Out_ViewDirWS15_g262662 , Out_CoordsData15_g262662 , Out_VertexData15_g262662 , Out_MasksData15_g262662 , Out_PhaseData15_g262662 , Out_TransformData15_g262662 , Out_RotationData15_g262662 , Out_InterpolatorA15_g262662 );
					TVEModelData Data16_g262663 =(TVEModelData)Data15_g262662;
					float temp_output_14_0_g262663 = 0.0;
					float In_Dummy16_g262663 = temp_output_14_0_g262663;
					float3 temp_output_217_24_g262661 = Out_PivotOS15_g262662;
					float3 temp_output_216_0_g262661 = ( Out_PositionOS15_g262662 + temp_output_217_24_g262661 );
					float3 temp_output_4_0_g262663 = temp_output_216_0_g262661;
					float3 In_PositionOS16_g262663 = temp_output_4_0_g262663;
					float3 In_PositionWS16_g262663 = Out_PositionWS15_g262662;
					float3 In_PositionWO16_g262663 = Out_PositionWO15_g262662;
					float3 In_PositionRawOS16_g262663 = Out_PositionRawOS15_g262662;
					float3 In_PivotOS16_g262663 = temp_output_217_24_g262661;
					float3 In_PivotWS16_g262663 = Out_PivotWS15_g262662;
					float3 In_PivotWO16_g262663 = Out_PivotWO15_g262662;
					float3 temp_output_21_0_g262663 = Out_NormalOS15_g262662;
					float3 In_NormalOS16_g262663 = temp_output_21_0_g262663;
					float3 In_NormalWS16_g262663 = Out_NormalWS15_g262662;
					float3 In_NormalRawOS16_g262663 = Out_NormalRawOS15_g262662;
					float4 temp_output_6_0_g262663 = Out_TangentOS15_g262662;
					float4 In_TangentOS16_g262663 = temp_output_6_0_g262663;
					float3 In_TangentWS16_g262663 = Out_TangentWS15_g262662;
					float3 In_BitangentWS16_g262663 = Out_BitangentWS15_g262662;
					float3 In_ViewDirWS16_g262663 = Out_ViewDirWS15_g262662;
					float4 In_CoordsData16_g262663 = Out_CoordsData15_g262662;
					float4 In_VertexData16_g262663 = Out_VertexData15_g262662;
					float4 In_MasksData16_g262663 = Out_MasksData15_g262662;
					float4 In_PhaseData16_g262663 = Out_PhaseData15_g262662;
					float4 In_TransformData16_g262663 = Out_TransformData15_g262662;
					float4 In_RotationData16_g262663 = Out_RotationData15_g262662;
					float4 In_InterpolatorA16_g262663 = Out_InterpolatorA15_g262662;
					BuildModelVertData( Data16_g262663 , In_Dummy16_g262663 , In_PositionOS16_g262663 , In_PositionWS16_g262663 , In_PositionWO16_g262663 , In_PositionRawOS16_g262663 , In_PivotOS16_g262663 , In_PivotWS16_g262663 , In_PivotWO16_g262663 , In_NormalOS16_g262663 , In_NormalWS16_g262663 , In_NormalRawOS16_g262663 , In_TangentOS16_g262663 , In_TangentWS16_g262663 , In_BitangentWS16_g262663 , In_ViewDirWS16_g262663 , In_CoordsData16_g262663 , In_VertexData16_g262663 , In_MasksData16_g262663 , In_PhaseData16_g262663 , In_TransformData16_g262663 , In_RotationData16_g262663 , In_InterpolatorA16_g262663 );
					TVEModelData Data15_g262710 =(TVEModelData)Data16_g262663;
					float Out_Dummy15_g262710 = 0.0;
					float3 Out_PositionOS15_g262710 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262710 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262710 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262710 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262710 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262710 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262710 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262710 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262710 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262710 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262710 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262710 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262710 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262710 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262710 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262710 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262710 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262710 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262710 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262710 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262710 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262710 , Out_Dummy15_g262710 , Out_PositionOS15_g262710 , Out_PositionWS15_g262710 , Out_PositionWO15_g262710 , Out_PositionRawOS15_g262710 , Out_PivotOS15_g262710 , Out_PivotWS15_g262710 , Out_PivotWO15_g262710 , Out_NormalOS15_g262710 , Out_NormalWS15_g262710 , Out_NormalRawOS15_g262710 , Out_TangentOS15_g262710 , Out_TangentWS15_g262710 , Out_BitangentWS15_g262710 , Out_ViewDirWS15_g262710 , Out_CoordsData15_g262710 , Out_VertexData15_g262710 , Out_MasksData15_g262710 , Out_PhaseData15_g262710 , Out_TransformData15_g262710 , Out_RotationData15_g262710 , Out_InterpolatorA15_g262710 );
					
					float3 ifLocalVar40_g262666 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g262666 = saturate( v.vertex.xyz );
					float3 ifLocalVar40_g262667 = 0;
					if( TVE_DEBUG_Index == 1.0 )
					ifLocalVar40_g262667 = saturate( v.normal );
					float3 ifLocalVar40_g262668 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g262668 = saturate( v.tangent.xyz );
					TVEModelData Data15_g262665 =(TVEModelData)Data16_g262663;
					float Out_Dummy15_g262665 = 0.0;
					float3 Out_PositionOS15_g262665 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262665 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262665 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262665 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262665 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262665 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262665 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262665 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262665 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262665 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262665 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262665 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262665 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262665 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262665 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262665 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262665 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262665 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262665 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262665 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262665 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262665 , Out_Dummy15_g262665 , Out_PositionOS15_g262665 , Out_PositionWS15_g262665 , Out_PositionWO15_g262665 , Out_PositionRawOS15_g262665 , Out_PivotOS15_g262665 , Out_PivotWS15_g262665 , Out_PivotWO15_g262665 , Out_NormalOS15_g262665 , Out_NormalWS15_g262665 , Out_NormalRawOS15_g262665 , Out_TangentOS15_g262665 , Out_TangentWS15_g262665 , Out_BitangentWS15_g262665 , Out_ViewDirWS15_g262665 , Out_CoordsData15_g262665 , Out_VertexData15_g262665 , Out_MasksData15_g262665 , Out_PhaseData15_g262665 , Out_TransformData15_g262665 , Out_RotationData15_g262665 , Out_InterpolatorA15_g262665 );
					float3 ifLocalVar40_g262681 = 0;
					if( TVE_DEBUG_Index == 3.0 )
					ifLocalVar40_g262681 = saturate( Out_PivotOS15_g262665 );
					float3 ifLocalVar40_g262669 = 0;
					if( TVE_DEBUG_Index == 5.0 )
					ifLocalVar40_g262669 = saturate( Out_PositionOS15_g262665 );
					float3 ifLocalVar40_g262671 = 0;
					if( TVE_DEBUG_Index == 6.0 )
					ifLocalVar40_g262671 = saturate( Out_NormalOS15_g262665 );
					float3 ifLocalVar40_g262670 = 0;
					if( TVE_DEBUG_Index == 7.0 )
					ifLocalVar40_g262670 = (Out_TangentOS15_g262665).xyz;
					float4 temp_output_2671_29 = Out_VertexData15_g262665;
					float3 ifLocalVar40_g262672 = 0;
					if( TVE_DEBUG_Index == 9.0 )
					ifLocalVar40_g262672 = (temp_output_2671_29).xxx;
					float3 ifLocalVar40_g262673 = 0;
					if( TVE_DEBUG_Index == 10.0 )
					ifLocalVar40_g262673 = (temp_output_2671_29).yyy;
					float3 ifLocalVar40_g262674 = 0;
					if( TVE_DEBUG_Index == 11.0 )
					ifLocalVar40_g262674 = (temp_output_2671_29).zzz;
					float3 ifLocalVar40_g262675 = 0;
					if( TVE_DEBUG_Index == 12.0 )
					ifLocalVar40_g262675 = (temp_output_2671_29).www;
					float4 temp_output_2671_30 = Out_MasksData15_g262665;
					float3 ifLocalVar40_g262676 = 0;
					if( TVE_DEBUG_Index == 14.0 )
					ifLocalVar40_g262676 = (temp_output_2671_30).xxx;
					float3 ifLocalVar40_g262677 = 0;
					if( TVE_DEBUG_Index == 15.0 )
					ifLocalVar40_g262677 = (temp_output_2671_30).yyy;
					float4 temp_output_2671_38 = Out_CoordsData15_g262665;
					float3 appendResult2701 = (float3((temp_output_2671_38).xy , 0.0));
					float3 ifLocalVar40_g262678 = 0;
					if( TVE_DEBUG_Index == 17.0 )
					ifLocalVar40_g262678 = appendResult2701;
					float3 appendResult2702 = (float3((v.texcoord1.xyzw.xy).xy , 0.0));
					float3 ifLocalVar40_g262679 = 0;
					if( TVE_DEBUG_Index == 18.0 )
					ifLocalVar40_g262679 = appendResult2702;
					float3 appendResult2706 = (float3((temp_output_2671_38).xy , 0.0));
					float3 ifLocalVar40_g262680 = 0;
					if( TVE_DEBUG_Index == 19.0 )
					ifLocalVar40_g262680 = appendResult2706;
					float3 vertexToFrag2524 = ( ( ifLocalVar40_g262666 + ifLocalVar40_g262667 + ifLocalVar40_g262668 + ifLocalVar40_g262681 ) + ( ifLocalVar40_g262669 + ifLocalVar40_g262671 + ifLocalVar40_g262670 ) + ( ifLocalVar40_g262672 + ifLocalVar40_g262673 + ifLocalVar40_g262674 + ifLocalVar40_g262675 ) + ( ifLocalVar40_g262676 + ifLocalVar40_g262677 ) + ( ifLocalVar40_g262678 + ifLocalVar40_g262679 + ifLocalVar40_g262680 ) );
					o.ase_texcoord4.xyz = vertexToFrag2524;
					float3 vertexPos57_g262704 = v.vertex.xyz;
					float4 ase_positionCS57_g262704 = UnityObjectToClipPos( vertexPos57_g262704 );
					o.ase_texcoord5 = ase_positionCS57_g262704;
					o.ase_texcoord9.xyz = vertexToFrag73_g262421;
					o.ase_texcoord10.xyz = vertexToFrag76_g262421;
					
					o.ase_texcoord6 = v.vertex;
					o.ase_normal = v.normal;
					o.ase_tangent = v.tangent;
					o.ase_texcoord7 = v.texcoord.xyzw;
					o.ase_texcoord8.xy = v.texcoord2.xyzw.xy;
					o.ase_color = v.ase_color;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord4.w = 0;
					o.ase_texcoord8.zw = 0;
					o.ase_texcoord9.w = 0;
					o.ase_texcoord10.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g262710;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g262710;
					v.tangent = Out_TangentOS15_g262710;

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

					float temp_output_2720_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2720_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2720_114).xxx;
					
					float3 color130_g262704 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g262704 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g262706 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g262705 = ( temp_cast_4 * ( 0.5 + appendResult128_g262706 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g262705 = (float4(ddx( FinalUV13_g262705 ) , ddy( FinalUV13_g262705 )));
					float4 UVDerivatives17_g262705 = appendResult16_g262705;
					float4 break28_g262705 = UVDerivatives17_g262705;
					float2 appendResult19_g262705 = (float2(break28_g262705.x , break28_g262705.z));
					float2 appendResult20_g262705 = (float2(break28_g262705.x , break28_g262705.z));
					float dotResult24_g262705 = dot( appendResult19_g262705 , appendResult20_g262705 );
					float2 appendResult21_g262705 = (float2(break28_g262705.y , break28_g262705.w));
					float2 appendResult22_g262705 = (float2(break28_g262705.y , break28_g262705.w));
					float dotResult23_g262705 = dot( appendResult21_g262705 , appendResult22_g262705 );
					float2 appendResult25_g262705 = (float2(dotResult24_g262705 , dotResult23_g262705));
					float2 derivativesLength29_g262705 = sqrt( appendResult25_g262705 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g262705 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g262705 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g262705 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g262705 = clampResult57_g262705;
					float2 break55_g262705 = derivativesLength29_g262705;
					float4 lerpResult73_g262705 = lerp( float4( color130_g262704 , 0.0 ) , float4( color81_g262704 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g262705.x * break71_g262705.y * sqrt( saturate( ( 1.1 - max( break55_g262705.x, break55_g262705.y ) ) ) ) ) ) ));
					float3 vertexToFrag2524 = IN.ase_texcoord4.xyz;
					half3 Final_Debug2399 = vertexToFrag2524;
					float temp_output_7_0_g262712 = TVE_DEBUG_Min;
					float3 temp_cast_9 = (temp_output_7_0_g262712).xxx;
					float3 temp_output_9_0_g262712 = ( Final_Debug2399 - temp_cast_9 );
					float lerpResult76_g262704 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g262704 = lerpResult76_g262704;
					float3 lerpResult72_g262704 = lerp( (lerpResult73_g262705).rgb , saturate( ( temp_output_9_0_g262712 / ( ( TVE_DEBUG_Max - temp_output_7_0_g262712 ) + 0.0001 ) ) ) , Filter152_g262704);
					float dotResult61_g262704 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g262704 = ( 1.0 - saturate( dotResult61_g262704 ) );
					float Shading_Fresnel59_g262704 = (( 1.0 - ( temp_output_65_0_g262704 * temp_output_65_0_g262704 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g262704 = IN.ase_texcoord5;
					float depthLinearEye57_g262704 = LinearEyeDepth( ase_positionCS57_g262704.z / ase_positionCS57_g262704.w );
					float temp_output_69_0_g262704 = saturate(  (0.0 + ( depthLinearEye57_g262704 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g262704 = (( temp_output_69_0_g262704 * temp_output_69_0_g262704 )*0.5 + 0.5);
					float lerpResult84_g262704 = lerp( 1.0 , Shading_Fresnel59_g262704 , ( Shading_Distance58_g262704 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g262709 = ( 0.0 );
					float localBuildVisualData3_g262683 = ( 0.0 );
					TVEVisualData Data3_g262683 =(TVEVisualData)0;
					half4 Dummy130_g262682 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) );
					float temp_output_14_0_g262683 = Dummy130_g262682.x;
					float In_Dummy3_g262683 = temp_output_14_0_g262683;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g262702) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g262697 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g262697 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g262697 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g262697 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g262697 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g262697 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g262702 = staticSwitch36_g262697;
					float localBreakTextureData456_g262702 = ( 0.0 );
					float localBuildTextureData431_g262696 = ( 0.0 );
					TVEMasksData Data431_g262696 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g262696 = ( 0.0 );
					half4 Local_Coords180_g262682 = _main_coord_value;
					float4 Coords444_g262696 = Local_Coords180_g262682;
					float localIfModelDataByShader26_g262420 = ( 0.0 );
					TVEModelData Data26_g262420 = (TVEModelData)0;
					TVEModelData Data16_g241828 =(TVEModelData)0;
					half Dummy207_g241818 = 0.0;
					float temp_output_14_0_g241828 = Dummy207_g241818;
					float In_Dummy16_g241828 = temp_output_14_0_g241828;
					float3 PositionOS131_g241818 = IN.ase_texcoord6.xyz;
					float3 temp_output_4_0_g241828 = PositionOS131_g241818;
					float3 In_PositionOS16_g241828 = temp_output_4_0_g241828;
					float3 temp_output_104_7_g241818 = PositionWS;
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
					float3 _Vector0 = float3(0,0,0);
					float3 PivotOS149_g241818 = _Vector0;
					float3 In_PivotOS16_g241828 = PivotOS149_g241818;
					float3 In_PivotWS16_g241828 = PivotWS121_g241818;
					float3 PivotWO133_g241818 = ( PivotWS121_g241818 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241828 = PivotWO133_g241818;
					half3 NormalOS134_g241818 = IN.ase_normal;
					float3 temp_output_21_0_g241828 = NormalOS134_g241818;
					float3 In_NormalOS16_g241828 = temp_output_21_0_g241828;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g241818 = normalizedWorldNormal;
					float3 In_NormalWS16_g241828 = NormalWS95_g241818;
					float3 In_NormalRawOS16_g241828 = NormalOS134_g241818;
					half4 TangentlOS153_g241818 = IN.ase_tangent;
					float4 temp_output_6_0_g241828 = TangentlOS153_g241818;
					float4 In_TangentOS16_g241828 = temp_output_6_0_g241828;
					half3 TangentWS136_g241818 = TangentWS;
					float3 In_TangentWS16_g241828 = TangentWS136_g241818;
					half3 BiangentWS421_g241818 = BitangentWS;
					float3 In_BitangentWS16_g241828 = BiangentWS421_g241818;
					float3 normalizeResult296_g241818 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241818 ) );
					half3 ViewDirWS169_g241818 = normalizeResult296_g241818;
					float3 In_ViewDirWS16_g241828 = ViewDirWS169_g241818;
					float4 appendResult397_g241818 = (float4(IN.ase_texcoord7.xy , IN.ase_texcoord8.xy));
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
					TVEModelData DataDefault26_g262420 = Data16_g241828;
					TVEModelData Data16_g262429 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g262429 = 0.0;
					float3 vertexToFrag73_g262421 = IN.ase_texcoord9.xyz;
					float3 PositionWS122_g262421 = vertexToFrag73_g262421;
					float3 In_PositionWS16_g262429 = PositionWS122_g262421;
					float3 vertexToFrag76_g262421 = IN.ase_texcoord10.xyz;
					float3 PivotWS121_g262421 = vertexToFrag76_g262421;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g262421 = ( PositionWS122_g262421 - PivotWS121_g262421 );
					#else
					float3 staticSwitch204_g262421 = PositionWS122_g262421;
					#endif
					float3 PositionWO132_g262421 = ( staticSwitch204_g262421 - TVE_WorldOrigin );
					float3 In_PositionWO16_g262429 = PositionWO132_g262421;
					float3 In_PivotWS16_g262429 = PivotWS121_g262421;
					float3 PivotWO133_g262421 = ( PivotWS121_g262421 - TVE_WorldOrigin );
					float3 In_PivotWO16_g262429 = PivotWO133_g262421;
					half3 NormalWS95_g262421 = normalizedWorldNormal;
					float3 In_NormalWS16_g262429 = NormalWS95_g262421;
					half3 TangentWS136_g262421 = TangentWS;
					float3 In_TangentWS16_g262429 = TangentWS136_g262421;
					half3 BiangentWS421_g262421 = BitangentWS;
					float3 In_BitangentWS16_g262429 = BiangentWS421_g262421;
					half3 NormalWS427_g262421 = NormalWS95_g262421;
					half3 localComputeTriplanarWeights427_g262421 = ComputeTriplanarWeights( NormalWS427_g262421 );
					half3 TriplanarWeights429_g262421 = localComputeTriplanarWeights427_g262421;
					float3 In_TriplanarWeights16_g262429 = TriplanarWeights429_g262421;
					float3 normalizeResult296_g262421 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g262421 ) );
					half3 ViewDirWS169_g262421 = normalizeResult296_g262421;
					float3 In_ViewDirWS16_g262429 = ViewDirWS169_g262421;
					float4 appendResult397_g262421 = (float4(IN.ase_texcoord7.xy , IN.ase_texcoord8.xy));
					float4 CoordsData398_g262421 = appendResult397_g262421;
					float4 In_CoordsData16_g262429 = CoordsData398_g262421;
					half4 VertexMasks171_g262421 = IN.ase_color;
					float4 In_VertexData16_g262429 = VertexMasks171_g262421;
					float temp_output_17_0_g262433 = _ObjectPhaseMode;
					float Option70_g262433 = temp_output_17_0_g262433;
					float4 temp_output_3_0_g262433 = IN.ase_color;
					float4 Channel70_g262433 = temp_output_3_0_g262433;
					float localSwitchChannel470_g262433 = SwitchChannel4( Option70_g262433 , Channel70_g262433 );
					half Phase_Value372_g262421 = localSwitchChannel470_g262433;
					float3 break319_g262421 = PivotWO133_g262421;
					half Pivot_Position322_g262421 = ( break319_g262421.x + break319_g262421.z );
					half Phase_Position357_g262421 = ( Phase_Value372_g262421 + Pivot_Position322_g262421 );
					float temp_output_248_0_g262421 = frac( Phase_Position357_g262421 );
					float4 appendResult177_g262421 = (float4(( (frac( ( Phase_Position357_g262421 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g262421));
					half4 Phase_Data176_g262421 = appendResult177_g262421;
					float4 In_PhaseData16_g262429 = Phase_Data176_g262421;
					BuildModelFragData( Data16_g262429 , In_Dummy16_g262429 , In_PositionWS16_g262429 , In_PositionWO16_g262429 , In_PivotWS16_g262429 , In_PivotWO16_g262429 , In_NormalWS16_g262429 , In_TangentWS16_g262429 , In_BitangentWS16_g262429 , In_TriplanarWeights16_g262429 , In_ViewDirWS16_g262429 , In_CoordsData16_g262429 , In_VertexData16_g262429 , In_PhaseData16_g262429 );
					TVEModelData DataGeneral26_g262420 = Data16_g262429;
					TVEModelData DataBlanket26_g262420 = Data16_g262429;
					TVEModelData DataImpostor26_g262420 = Data16_g262429;
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
					TVEModelData DataTerrain26_g262420 = Data16_g241826;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g262420 = IsShaderType2637;
					{
					if (Type26_g262420 == 0 )
					{
					Data26_g262420 = DataDefault26_g262420;
					}
					else if (Type26_g262420 == 1 )
					{
					Data26_g262420 = DataGeneral26_g262420;
					}
					else if (Type26_g262420 == 2 )
					{
					Data26_g262420 = DataBlanket26_g262420;
					}
					else if (Type26_g262420 == 3 )
					{
					Data26_g262420 = DataImpostor26_g262420;
					}
					else if (Type26_g262420 == 4 )
					{
					Data26_g262420 = DataTerrain26_g262420;
					}
					}
					TVEModelData Data15_g262695 =(TVEModelData)Data26_g262420;
					float Out_Dummy15_g262695 = 0.0;
					float3 Out_PositionWS15_g262695 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262695 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262695 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262695 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262695 = float3( 0,0,0 );
					float3 Out_TangentWS15_g262695 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262695 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g262695 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262695 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262695 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262695 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262695 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g262695 , Out_Dummy15_g262695 , Out_PositionWS15_g262695 , Out_PositionWO15_g262695 , Out_PivotWS15_g262695 , Out_PivotWO15_g262695 , Out_NormalWS15_g262695 , Out_TangentWS15_g262695 , Out_BitangentWS15_g262695 , Out_TriplanarWeights15_g262695 , Out_ViewDirWS15_g262695 , Out_CoordsData15_g262695 , Out_VertexData15_g262695 , Out_PhaseData15_g262695 );
					float4 Model_CoordsData324_g262682 = Out_CoordsData15_g262695;
					float4 MeshCoords444_g262696 = Model_CoordsData324_g262682;
					float2 UV0444_g262696 = float2( 0,0 );
					float2 UV3444_g262696 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g262696 , MeshCoords444_g262696 , UV0444_g262696 , UV3444_g262696 );
					float4 appendResult430_g262696 = (float4(UV0444_g262696 , UV3444_g262696));
					float4 In_MaskA431_g262696 = appendResult430_g262696;
					float localComputeWorldCoords315_g262696 = ( 0.0 );
					float4 Coords315_g262696 = Local_Coords180_g262682;
					float3 Model_PositionWO222_g262682 = Out_PositionWO15_g262695;
					float3 PositionWS315_g262696 = Model_PositionWO222_g262682;
					float2 ZY315_g262696 = float2( 0,0 );
					float2 XZ315_g262696 = float2( 0,0 );
					float2 XY315_g262696 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g262696 , PositionWS315_g262696 , ZY315_g262696 , XZ315_g262696 , XY315_g262696 );
					float2 ZY402_g262696 = ZY315_g262696;
					float2 XZ403_g262696 = XZ315_g262696;
					float4 appendResult432_g262696 = (float4(ZY402_g262696 , XZ403_g262696));
					float4 In_MaskB431_g262696 = appendResult432_g262696;
					float2 XY404_g262696 = XY315_g262696;
					float localComputeStochasticCoords409_g262696 = ( 0.0 );
					float2 UV409_g262696 = ZY402_g262696;
					float2 UV1409_g262696 = float2( 0,0 );
					float2 UV2409_g262696 = float2( 0,0 );
					float2 UV3409_g262696 = float2( 0,0 );
					float3 Weights409_g262696 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g262696 , UV1409_g262696 , UV2409_g262696 , UV3409_g262696 , Weights409_g262696 );
					float4 appendResult433_g262696 = (float4(XY404_g262696 , UV1409_g262696));
					float4 In_MaskC431_g262696 = appendResult433_g262696;
					float4 appendResult434_g262696 = (float4(UV2409_g262696 , UV3409_g262696));
					float4 In_MaskD431_g262696 = appendResult434_g262696;
					float localComputeStochasticCoords422_g262696 = ( 0.0 );
					float2 UV422_g262696 = XZ403_g262696;
					float2 UV1422_g262696 = float2( 0,0 );
					float2 UV2422_g262696 = float2( 0,0 );
					float2 UV3422_g262696 = float2( 0,0 );
					float3 Weights422_g262696 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g262696 , UV1422_g262696 , UV2422_g262696 , UV3422_g262696 , Weights422_g262696 );
					float4 appendResult435_g262696 = (float4(UV1422_g262696 , UV2422_g262696));
					float4 In_MaskE431_g262696 = appendResult435_g262696;
					float localComputeStochasticCoords423_g262696 = ( 0.0 );
					float2 UV423_g262696 = XY404_g262696;
					float2 UV1423_g262696 = float2( 0,0 );
					float2 UV2423_g262696 = float2( 0,0 );
					float2 UV3423_g262696 = float2( 0,0 );
					float3 Weights423_g262696 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g262696 , UV1423_g262696 , UV2423_g262696 , UV3423_g262696 , Weights423_g262696 );
					float4 appendResult436_g262696 = (float4(UV3422_g262696 , UV1423_g262696));
					float4 In_MaskF431_g262696 = appendResult436_g262696;
					float4 appendResult437_g262696 = (float4(UV2423_g262696 , UV3423_g262696));
					float4 In_MaskG431_g262696 = appendResult437_g262696;
					float4 In_MaskH431_g262696 = float4( Weights409_g262696 , 0.0 );
					float4 In_MaskI431_g262696 = float4( Weights422_g262696 , 0.0 );
					float4 In_MaskJ431_g262696 = float4( Weights423_g262696 , 0.0 );
					half3 Model_NormalWS226_g262682 = Out_NormalWS15_g262695;
					float3 temp_output_449_0_g262696 = Model_NormalWS226_g262682;
					float4 In_MaskK431_g262696 = float4( temp_output_449_0_g262696 , 0.0 );
					half3 Model_TangentWS366_g262682 = Out_TangentWS15_g262695;
					float3 temp_output_450_0_g262696 = Model_TangentWS366_g262682;
					float4 In_MaskL431_g262696 = float4( temp_output_450_0_g262696 , 0.0 );
					half3 Model_BitangentWS367_g262682 = Out_BitangentWS15_g262695;
					float3 temp_output_451_0_g262696 = Model_BitangentWS367_g262682;
					float4 In_MaskM431_g262696 = float4( temp_output_451_0_g262696 , 0.0 );
					half3 Model_TriplanarWeights368_g262682 = Out_TriplanarWeights15_g262695;
					float3 temp_output_445_0_g262696 = Model_TriplanarWeights368_g262682;
					float4 In_MaskN431_g262696 = float4( temp_output_445_0_g262696 , 0.0 );
					BuildTextureData( Data431_g262696 , In_MaskA431_g262696 , In_MaskB431_g262696 , In_MaskC431_g262696 , In_MaskD431_g262696 , In_MaskE431_g262696 , In_MaskF431_g262696 , In_MaskG431_g262696 , In_MaskH431_g262696 , In_MaskI431_g262696 , In_MaskJ431_g262696 , In_MaskK431_g262696 , In_MaskL431_g262696 , In_MaskM431_g262696 , In_MaskN431_g262696 );
					TVEMasksData Data456_g262702 =(TVEMasksData)Data431_g262696;
					float4 Out_MaskA456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g262702 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g262702 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g262702 , Out_MaskA456_g262702 , Out_MaskB456_g262702 , Out_MaskC456_g262702 , Out_MaskD456_g262702 , Out_MaskE456_g262702 , Out_MaskF456_g262702 , Out_MaskG456_g262702 , Out_MaskH456_g262702 , Out_MaskI456_g262702 , Out_MaskJ456_g262702 , Out_MaskK456_g262702 , Out_MaskL456_g262702 , Out_MaskM456_g262702 , Out_MaskN456_g262702 );
					half2 UV276_g262702 = (Out_MaskA456_g262702).xy;
					float temp_output_504_0_g262702 = 0.0;
					half Bias276_g262702 = temp_output_504_0_g262702;
					half2 Normal276_g262702 = float2( 0,0 );
					half4 localSampleCoord276_g262702 = SampleCoord( Texture276_g262702 , Sampler276_g262702 , UV276_g262702 , Bias276_g262702 , Normal276_g262702 );
					float4 temp_output_407_277_g262682 = localSampleCoord276_g262702;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g262702) = _MainAlbedoTex;
					SamplerState Sampler502_g262702 = staticSwitch36_g262697;
					half2 UV502_g262702 = (Out_MaskA456_g262702).zw;
					half Bias502_g262702 = temp_output_504_0_g262702;
					half2 Normal502_g262702 = float2( 0,0 );
					half4 localSampleCoord502_g262702 = SampleCoord( Texture502_g262702 , Sampler502_g262702 , UV502_g262702 , Bias502_g262702 , Normal502_g262702 );
					float4 temp_output_407_278_g262682 = localSampleCoord502_g262702;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g262702) = _MainAlbedoTex;
					SamplerState Sampler496_g262702 = staticSwitch36_g262697;
					float2 temp_output_463_0_g262702 = (Out_MaskB456_g262702).zw;
					half2 XZ496_g262702 = temp_output_463_0_g262702;
					half Bias496_g262702 = temp_output_504_0_g262702;
					float3 temp_output_483_0_g262702 = (Out_MaskK456_g262702).xyz;
					half3 NormalWS496_g262702 = temp_output_483_0_g262702;
					half3 Normal496_g262702 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g262702 = SamplePlanar2D( Texture496_g262702 , Sampler496_g262702 , XZ496_g262702 , Bias496_g262702 , NormalWS496_g262702 , Normal496_g262702 );
					float4 temp_output_407_0_g262682 = localSamplePlanar2D496_g262702;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g262702) = _MainAlbedoTex;
					SamplerState Sampler490_g262702 = staticSwitch36_g262697;
					float2 temp_output_462_0_g262702 = (Out_MaskB456_g262702).xy;
					half2 ZY490_g262702 = temp_output_462_0_g262702;
					half2 XZ490_g262702 = temp_output_463_0_g262702;
					float2 temp_output_464_0_g262702 = (Out_MaskC456_g262702).xy;
					half2 XY490_g262702 = temp_output_464_0_g262702;
					half Bias490_g262702 = temp_output_504_0_g262702;
					float3 temp_output_482_0_g262702 = (Out_MaskN456_g262702).xyz;
					half3 Triplanar490_g262702 = temp_output_482_0_g262702;
					half3 NormalWS490_g262702 = temp_output_483_0_g262702;
					half3 Normal490_g262702 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g262702 = SamplePlanar3D( Texture490_g262702 , Sampler490_g262702 , ZY490_g262702 , XZ490_g262702 , XY490_g262702 , Bias490_g262702 , Triplanar490_g262702 , NormalWS490_g262702 , Normal490_g262702 );
					float4 temp_output_407_201_g262682 = localSamplePlanar3D490_g262702;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g262702) = _MainAlbedoTex;
					SamplerState Sampler498_g262702 = staticSwitch36_g262697;
					half2 XZ498_g262702 = temp_output_463_0_g262702;
					float2 temp_output_473_0_g262702 = (Out_MaskE456_g262702).xy;
					half2 XZ_1498_g262702 = temp_output_473_0_g262702;
					float2 temp_output_474_0_g262702 = (Out_MaskE456_g262702).zw;
					half2 XZ_2498_g262702 = temp_output_474_0_g262702;
					float2 temp_output_475_0_g262702 = (Out_MaskF456_g262702).xy;
					half2 XZ_3498_g262702 = temp_output_475_0_g262702;
					float temp_output_510_0_g262702 = exp2( temp_output_504_0_g262702 );
					half Bias498_g262702 = temp_output_510_0_g262702;
					float3 temp_output_480_0_g262702 = (Out_MaskI456_g262702).xyz;
					half3 Weights_2498_g262702 = temp_output_480_0_g262702;
					half3 NormalWS498_g262702 = temp_output_483_0_g262702;
					half3 Normal498_g262702 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g262702 = SampleStochastic2D( Texture498_g262702 , Sampler498_g262702 , XZ498_g262702 , XZ_1498_g262702 , XZ_2498_g262702 , XZ_3498_g262702 , Bias498_g262702 , Weights_2498_g262702 , NormalWS498_g262702 , Normal498_g262702 );
					float4 temp_output_407_202_g262682 = localSampleStochastic2D498_g262702;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g262702) = _MainAlbedoTex;
					SamplerState Sampler500_g262702 = staticSwitch36_g262697;
					half2 ZY500_g262702 = temp_output_462_0_g262702;
					half2 ZY_1500_g262702 = (Out_MaskC456_g262702).zw;
					half2 ZY_2500_g262702 = (Out_MaskD456_g262702).xy;
					half2 ZY_3500_g262702 = (Out_MaskD456_g262702).zw;
					half2 XZ500_g262702 = temp_output_463_0_g262702;
					half2 XZ_1500_g262702 = temp_output_473_0_g262702;
					half2 XZ_2500_g262702 = temp_output_474_0_g262702;
					half2 XZ_3500_g262702 = temp_output_475_0_g262702;
					half2 XY500_g262702 = temp_output_464_0_g262702;
					half2 XY_1500_g262702 = (Out_MaskF456_g262702).zw;
					half2 XY_2500_g262702 = (Out_MaskG456_g262702).xy;
					half2 XY_3500_g262702 = (Out_MaskG456_g262702).zw;
					half Bias500_g262702 = temp_output_510_0_g262702;
					half3 Weights_1500_g262702 = (Out_MaskH456_g262702).xyz;
					half3 Weights_2500_g262702 = temp_output_480_0_g262702;
					half3 Weights_3500_g262702 = (Out_MaskJ456_g262702).xyz;
					half3 Triplanar500_g262702 = temp_output_482_0_g262702;
					half3 NormalWS500_g262702 = temp_output_483_0_g262702;
					half3 Normal500_g262702 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g262702 = SampleStochastic3D( Texture500_g262702 , Sampler500_g262702 , ZY500_g262702 , ZY_1500_g262702 , ZY_2500_g262702 , ZY_3500_g262702 , XZ500_g262702 , XZ_1500_g262702 , XZ_2500_g262702 , XZ_3500_g262702 , XY500_g262702 , XY_1500_g262702 , XY_2500_g262702 , XY_3500_g262702 , Bias500_g262702 , Weights_1500_g262702 , Weights_2500_g262702 , Weights_3500_g262702 , Triplanar500_g262702 , NormalWS500_g262702 , Normal500_g262702 );
					float4 temp_output_407_203_g262682 = localSampleStochastic3D500_g262702;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g262682 = temp_output_407_277_g262682;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g262682 = temp_output_407_278_g262682;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g262682 = temp_output_407_0_g262682;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g262682 = temp_output_407_201_g262682;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g262682 = temp_output_407_202_g262682;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g262682 = temp_output_407_203_g262682;
					#else
					float4 staticSwitch184_g262682 = temp_output_407_277_g262682;
					#endif
					half4 Local_AlbedoSample185_g262682 = staticSwitch184_g262682;
					float3 lerpResult53_g262682 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g262682).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g262682 = lerpResult53_g262682;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g262700) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g262699 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g262699 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g262699 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g262699 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g262699 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g262699 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g262700 = staticSwitch38_g262699;
					float localBreakTextureData456_g262700 = ( 0.0 );
					TVEMasksData Data456_g262700 =(TVEMasksData)Data431_g262696;
					float4 Out_MaskA456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g262700 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g262700 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g262700 , Out_MaskA456_g262700 , Out_MaskB456_g262700 , Out_MaskC456_g262700 , Out_MaskD456_g262700 , Out_MaskE456_g262700 , Out_MaskF456_g262700 , Out_MaskG456_g262700 , Out_MaskH456_g262700 , Out_MaskI456_g262700 , Out_MaskJ456_g262700 , Out_MaskK456_g262700 , Out_MaskL456_g262700 , Out_MaskM456_g262700 , Out_MaskN456_g262700 );
					half2 UV276_g262700 = (Out_MaskA456_g262700).xy;
					float temp_output_504_0_g262700 = 0.0;
					half Bias276_g262700 = temp_output_504_0_g262700;
					half2 Normal276_g262700 = float2( 0,0 );
					half4 localSampleCoord276_g262700 = SampleCoord( Texture276_g262700 , Sampler276_g262700 , UV276_g262700 , Bias276_g262700 , Normal276_g262700 );
					float4 temp_output_405_277_g262682 = localSampleCoord276_g262700;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g262700) = _MainShaderTex;
					SamplerState Sampler502_g262700 = staticSwitch38_g262699;
					half2 UV502_g262700 = (Out_MaskA456_g262700).zw;
					half Bias502_g262700 = temp_output_504_0_g262700;
					half2 Normal502_g262700 = float2( 0,0 );
					half4 localSampleCoord502_g262700 = SampleCoord( Texture502_g262700 , Sampler502_g262700 , UV502_g262700 , Bias502_g262700 , Normal502_g262700 );
					float4 temp_output_405_278_g262682 = localSampleCoord502_g262700;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g262700) = _MainShaderTex;
					SamplerState Sampler496_g262700 = staticSwitch38_g262699;
					float2 temp_output_463_0_g262700 = (Out_MaskB456_g262700).zw;
					half2 XZ496_g262700 = temp_output_463_0_g262700;
					half Bias496_g262700 = temp_output_504_0_g262700;
					float3 temp_output_483_0_g262700 = (Out_MaskK456_g262700).xyz;
					half3 NormalWS496_g262700 = temp_output_483_0_g262700;
					half3 Normal496_g262700 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g262700 = SamplePlanar2D( Texture496_g262700 , Sampler496_g262700 , XZ496_g262700 , Bias496_g262700 , NormalWS496_g262700 , Normal496_g262700 );
					float4 temp_output_405_0_g262682 = localSamplePlanar2D496_g262700;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g262700) = _MainShaderTex;
					SamplerState Sampler490_g262700 = staticSwitch38_g262699;
					float2 temp_output_462_0_g262700 = (Out_MaskB456_g262700).xy;
					half2 ZY490_g262700 = temp_output_462_0_g262700;
					half2 XZ490_g262700 = temp_output_463_0_g262700;
					float2 temp_output_464_0_g262700 = (Out_MaskC456_g262700).xy;
					half2 XY490_g262700 = temp_output_464_0_g262700;
					half Bias490_g262700 = temp_output_504_0_g262700;
					float3 temp_output_482_0_g262700 = (Out_MaskN456_g262700).xyz;
					half3 Triplanar490_g262700 = temp_output_482_0_g262700;
					half3 NormalWS490_g262700 = temp_output_483_0_g262700;
					half3 Normal490_g262700 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g262700 = SamplePlanar3D( Texture490_g262700 , Sampler490_g262700 , ZY490_g262700 , XZ490_g262700 , XY490_g262700 , Bias490_g262700 , Triplanar490_g262700 , NormalWS490_g262700 , Normal490_g262700 );
					float4 temp_output_405_201_g262682 = localSamplePlanar3D490_g262700;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g262700) = _MainShaderTex;
					SamplerState Sampler498_g262700 = staticSwitch38_g262699;
					half2 XZ498_g262700 = temp_output_463_0_g262700;
					float2 temp_output_473_0_g262700 = (Out_MaskE456_g262700).xy;
					half2 XZ_1498_g262700 = temp_output_473_0_g262700;
					float2 temp_output_474_0_g262700 = (Out_MaskE456_g262700).zw;
					half2 XZ_2498_g262700 = temp_output_474_0_g262700;
					float2 temp_output_475_0_g262700 = (Out_MaskF456_g262700).xy;
					half2 XZ_3498_g262700 = temp_output_475_0_g262700;
					float temp_output_510_0_g262700 = exp2( temp_output_504_0_g262700 );
					half Bias498_g262700 = temp_output_510_0_g262700;
					float3 temp_output_480_0_g262700 = (Out_MaskI456_g262700).xyz;
					half3 Weights_2498_g262700 = temp_output_480_0_g262700;
					half3 NormalWS498_g262700 = temp_output_483_0_g262700;
					half3 Normal498_g262700 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g262700 = SampleStochastic2D( Texture498_g262700 , Sampler498_g262700 , XZ498_g262700 , XZ_1498_g262700 , XZ_2498_g262700 , XZ_3498_g262700 , Bias498_g262700 , Weights_2498_g262700 , NormalWS498_g262700 , Normal498_g262700 );
					float4 temp_output_405_202_g262682 = localSampleStochastic2D498_g262700;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g262700) = _MainShaderTex;
					SamplerState Sampler500_g262700 = staticSwitch38_g262699;
					half2 ZY500_g262700 = temp_output_462_0_g262700;
					half2 ZY_1500_g262700 = (Out_MaskC456_g262700).zw;
					half2 ZY_2500_g262700 = (Out_MaskD456_g262700).xy;
					half2 ZY_3500_g262700 = (Out_MaskD456_g262700).zw;
					half2 XZ500_g262700 = temp_output_463_0_g262700;
					half2 XZ_1500_g262700 = temp_output_473_0_g262700;
					half2 XZ_2500_g262700 = temp_output_474_0_g262700;
					half2 XZ_3500_g262700 = temp_output_475_0_g262700;
					half2 XY500_g262700 = temp_output_464_0_g262700;
					half2 XY_1500_g262700 = (Out_MaskF456_g262700).zw;
					half2 XY_2500_g262700 = (Out_MaskG456_g262700).xy;
					half2 XY_3500_g262700 = (Out_MaskG456_g262700).zw;
					half Bias500_g262700 = temp_output_510_0_g262700;
					half3 Weights_1500_g262700 = (Out_MaskH456_g262700).xyz;
					half3 Weights_2500_g262700 = temp_output_480_0_g262700;
					half3 Weights_3500_g262700 = (Out_MaskJ456_g262700).xyz;
					half3 Triplanar500_g262700 = temp_output_482_0_g262700;
					half3 NormalWS500_g262700 = temp_output_483_0_g262700;
					half3 Normal500_g262700 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g262700 = SampleStochastic3D( Texture500_g262700 , Sampler500_g262700 , ZY500_g262700 , ZY_1500_g262700 , ZY_2500_g262700 , ZY_3500_g262700 , XZ500_g262700 , XZ_1500_g262700 , XZ_2500_g262700 , XZ_3500_g262700 , XY500_g262700 , XY_1500_g262700 , XY_2500_g262700 , XY_3500_g262700 , Bias500_g262700 , Weights_1500_g262700 , Weights_2500_g262700 , Weights_3500_g262700 , Triplanar500_g262700 , NormalWS500_g262700 , Normal500_g262700 );
					float4 temp_output_405_203_g262682 = localSampleStochastic3D500_g262700;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g262682 = temp_output_405_277_g262682;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g262682 = temp_output_405_278_g262682;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g262682 = temp_output_405_0_g262682;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g262682 = temp_output_405_201_g262682;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g262682 = temp_output_405_202_g262682;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g262682 = temp_output_405_203_g262682;
					#else
					float4 staticSwitch198_g262682 = temp_output_405_277_g262682;
					#endif
					half4 Local_ShaderSample199_g262682 = staticSwitch198_g262682;
					float temp_output_209_0_g262682 = (Local_ShaderSample199_g262682).y;
					float temp_output_7_0_g262688 = _MainOcclusionRemap.x;
					float temp_output_9_0_g262688 = ( temp_output_209_0_g262682 - temp_output_7_0_g262688 );
					float lerpResult23_g262682 = lerp( 1.0 , saturate( ( temp_output_9_0_g262688 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g262682 = lerpResult23_g262682;
					float temp_output_213_0_g262682 = (Local_ShaderSample199_g262682).w;
					float temp_output_7_0_g262692 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g262692 = ( temp_output_213_0_g262682 - temp_output_7_0_g262692 );
					half Local_Smoothness317_g262682 = ( saturate( ( temp_output_9_0_g262692 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g262682 = (float4(( (Local_ShaderSample199_g262682).x * _MainMetallicValue ) , Local_Occlusion313_g262682 , (Local_ShaderSample199_g262682).z , Local_Smoothness317_g262682));
					half4 Local_Masks109_g262682 = appendResult73_g262682;
					float temp_output_135_0_g262682 = (Local_Masks109_g262682).z;
					float temp_output_7_0_g262687 = _MainMultiRemap.x;
					float temp_output_9_0_g262687 = ( temp_output_135_0_g262682 - temp_output_7_0_g262687 );
					float temp_output_42_0_g262682 = saturate( ( temp_output_9_0_g262687 * _MainMultiRemap.z ) );
					half Local_MultiMask78_g262682 = temp_output_42_0_g262682;
					float lerpResult58_g262682 = lerp( 1.0 , Local_MultiMask78_g262682 , _MainColorMode);
					float4 lerpResult62_g262682 = lerp( _MainColorTwo , _MainColor , lerpResult58_g262682);
					half3 Local_ColorRGB93_g262682 = (lerpResult62_g262682).rgb;
					half3 Local_Albedo139_g262682 = ( Local_AlbedoRGB107_g262682 * Local_ColorRGB93_g262682 );
					float3 temp_output_4_0_g262683 = Local_Albedo139_g262682;
					float3 In_Albedo3_g262683 = temp_output_4_0_g262683;
					float3 temp_output_44_0_g262683 = Local_Albedo139_g262682;
					float3 In_AlbedoBase3_g262683 = temp_output_44_0_g262683;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g262701) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g262698 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g262698 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g262698 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g262698 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g262698 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g262698 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g262701 = staticSwitch37_g262698;
					float localBreakTextureData456_g262701 = ( 0.0 );
					TVEMasksData Data456_g262701 =(TVEMasksData)Data431_g262696;
					float4 Out_MaskA456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g262701 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g262701 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g262701 , Out_MaskA456_g262701 , Out_MaskB456_g262701 , Out_MaskC456_g262701 , Out_MaskD456_g262701 , Out_MaskE456_g262701 , Out_MaskF456_g262701 , Out_MaskG456_g262701 , Out_MaskH456_g262701 , Out_MaskI456_g262701 , Out_MaskJ456_g262701 , Out_MaskK456_g262701 , Out_MaskL456_g262701 , Out_MaskM456_g262701 , Out_MaskN456_g262701 );
					half2 UV276_g262701 = (Out_MaskA456_g262701).xy;
					float temp_output_504_0_g262701 = 0.0;
					half Bias276_g262701 = temp_output_504_0_g262701;
					half2 Normal276_g262701 = float2( 0,0 );
					half4 localSampleCoord276_g262701 = SampleCoord( Texture276_g262701 , Sampler276_g262701 , UV276_g262701 , Bias276_g262701 , Normal276_g262701 );
					float2 temp_output_406_394_g262682 = Normal276_g262701;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g262701) = _MainNormalTex;
					SamplerState Sampler502_g262701 = staticSwitch37_g262698;
					half2 UV502_g262701 = (Out_MaskA456_g262701).zw;
					half Bias502_g262701 = temp_output_504_0_g262701;
					half2 Normal502_g262701 = float2( 0,0 );
					half4 localSampleCoord502_g262701 = SampleCoord( Texture502_g262701 , Sampler502_g262701 , UV502_g262701 , Bias502_g262701 , Normal502_g262701 );
					float2 temp_output_406_397_g262682 = Normal502_g262701;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g262701) = _MainNormalTex;
					SamplerState Sampler496_g262701 = staticSwitch37_g262698;
					float2 temp_output_463_0_g262701 = (Out_MaskB456_g262701).zw;
					half2 XZ496_g262701 = temp_output_463_0_g262701;
					half Bias496_g262701 = temp_output_504_0_g262701;
					float3 temp_output_483_0_g262701 = (Out_MaskK456_g262701).xyz;
					half3 NormalWS496_g262701 = temp_output_483_0_g262701;
					half3 Normal496_g262701 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g262701 = SamplePlanar2D( Texture496_g262701 , Sampler496_g262701 , XZ496_g262701 , Bias496_g262701 , NormalWS496_g262701 , Normal496_g262701 );
					float3x3 ase_worldToTangent = float3x3( TangentWS, BitangentWS, NormalWS );
					float3 worldToTangentDir408_g262701 = normalize( mul( ase_worldToTangent, Normal496_g262701 ) );
					float2 temp_output_406_375_g262682 = (worldToTangentDir408_g262701).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g262701) = _MainNormalTex;
					SamplerState Sampler490_g262701 = staticSwitch37_g262698;
					float2 temp_output_462_0_g262701 = (Out_MaskB456_g262701).xy;
					half2 ZY490_g262701 = temp_output_462_0_g262701;
					half2 XZ490_g262701 = temp_output_463_0_g262701;
					float2 temp_output_464_0_g262701 = (Out_MaskC456_g262701).xy;
					half2 XY490_g262701 = temp_output_464_0_g262701;
					half Bias490_g262701 = temp_output_504_0_g262701;
					float3 temp_output_482_0_g262701 = (Out_MaskN456_g262701).xyz;
					half3 Triplanar490_g262701 = temp_output_482_0_g262701;
					half3 NormalWS490_g262701 = temp_output_483_0_g262701;
					half3 Normal490_g262701 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g262701 = SamplePlanar3D( Texture490_g262701 , Sampler490_g262701 , ZY490_g262701 , XZ490_g262701 , XY490_g262701 , Bias490_g262701 , Triplanar490_g262701 , NormalWS490_g262701 , Normal490_g262701 );
					float3 worldToTangentDir399_g262701 = normalize( mul( ase_worldToTangent, Normal490_g262701 ) );
					float2 temp_output_406_353_g262682 = (worldToTangentDir399_g262701).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g262701) = _MainNormalTex;
					SamplerState Sampler498_g262701 = staticSwitch37_g262698;
					half2 XZ498_g262701 = temp_output_463_0_g262701;
					float2 temp_output_473_0_g262701 = (Out_MaskE456_g262701).xy;
					half2 XZ_1498_g262701 = temp_output_473_0_g262701;
					float2 temp_output_474_0_g262701 = (Out_MaskE456_g262701).zw;
					half2 XZ_2498_g262701 = temp_output_474_0_g262701;
					float2 temp_output_475_0_g262701 = (Out_MaskF456_g262701).xy;
					half2 XZ_3498_g262701 = temp_output_475_0_g262701;
					float temp_output_510_0_g262701 = exp2( temp_output_504_0_g262701 );
					half Bias498_g262701 = temp_output_510_0_g262701;
					float3 temp_output_480_0_g262701 = (Out_MaskI456_g262701).xyz;
					half3 Weights_2498_g262701 = temp_output_480_0_g262701;
					half3 NormalWS498_g262701 = temp_output_483_0_g262701;
					half3 Normal498_g262701 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g262701 = SampleStochastic2D( Texture498_g262701 , Sampler498_g262701 , XZ498_g262701 , XZ_1498_g262701 , XZ_2498_g262701 , XZ_3498_g262701 , Bias498_g262701 , Weights_2498_g262701 , NormalWS498_g262701 , Normal498_g262701 );
					float3 worldToTangentDir411_g262701 = normalize( mul( ase_worldToTangent, Normal498_g262701 ) );
					float2 temp_output_406_391_g262682 = (worldToTangentDir411_g262701).xy;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g262701) = _MainNormalTex;
					SamplerState Sampler500_g262701 = staticSwitch37_g262698;
					half2 ZY500_g262701 = temp_output_462_0_g262701;
					half2 ZY_1500_g262701 = (Out_MaskC456_g262701).zw;
					half2 ZY_2500_g262701 = (Out_MaskD456_g262701).xy;
					half2 ZY_3500_g262701 = (Out_MaskD456_g262701).zw;
					half2 XZ500_g262701 = temp_output_463_0_g262701;
					half2 XZ_1500_g262701 = temp_output_473_0_g262701;
					half2 XZ_2500_g262701 = temp_output_474_0_g262701;
					half2 XZ_3500_g262701 = temp_output_475_0_g262701;
					half2 XY500_g262701 = temp_output_464_0_g262701;
					half2 XY_1500_g262701 = (Out_MaskF456_g262701).zw;
					half2 XY_2500_g262701 = (Out_MaskG456_g262701).xy;
					half2 XY_3500_g262701 = (Out_MaskG456_g262701).zw;
					half Bias500_g262701 = temp_output_510_0_g262701;
					half3 Weights_1500_g262701 = (Out_MaskH456_g262701).xyz;
					half3 Weights_2500_g262701 = temp_output_480_0_g262701;
					half3 Weights_3500_g262701 = (Out_MaskJ456_g262701).xyz;
					half3 Triplanar500_g262701 = temp_output_482_0_g262701;
					half3 NormalWS500_g262701 = temp_output_483_0_g262701;
					half3 Normal500_g262701 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g262701 = SampleStochastic3D( Texture500_g262701 , Sampler500_g262701 , ZY500_g262701 , ZY_1500_g262701 , ZY_2500_g262701 , ZY_3500_g262701 , XZ500_g262701 , XZ_1500_g262701 , XZ_2500_g262701 , XZ_3500_g262701 , XY500_g262701 , XY_1500_g262701 , XY_2500_g262701 , XY_3500_g262701 , Bias500_g262701 , Weights_1500_g262701 , Weights_2500_g262701 , Weights_3500_g262701 , Triplanar500_g262701 , NormalWS500_g262701 , Normal500_g262701 );
					float3 worldToTangentDir403_g262701 = normalize( mul( ase_worldToTangent, Normal500_g262701 ) );
					float2 temp_output_406_390_g262682 = (worldToTangentDir403_g262701).xy;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g262682 = temp_output_406_394_g262682;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g262682 = temp_output_406_397_g262682;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g262682 = temp_output_406_375_g262682;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g262682 = temp_output_406_353_g262682;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g262682 = temp_output_406_391_g262682;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g262682 = temp_output_406_390_g262682;
					#else
					float2 staticSwitch193_g262682 = temp_output_406_394_g262682;
					#endif
					half2 Local_NormaSample191_g262682 = staticSwitch193_g262682;
					half2 Local_NormalTS108_g262682 = ( Local_NormaSample191_g262682 * _MainNormalValue );
					float2 In_NormalTS3_g262683 = Local_NormalTS108_g262682;
					float3 appendResult68_g262694 = (float3(Local_NormalTS108_g262682 , 1.0));
					float3 tanToWorld0 = float3( TangentWS.x, BitangentWS.x, NormalWS.x );
					float3 tanToWorld1 = float3( TangentWS.y, BitangentWS.y, NormalWS.y );
					float3 tanToWorld2 = float3( TangentWS.z, BitangentWS.z, NormalWS.z );
					float3 tanNormal74_g262694 = appendResult68_g262694;
					float3 worldNormal74_g262694 = normalize( float3( dot( tanToWorld0, tanNormal74_g262694 ), dot( tanToWorld1, tanNormal74_g262694 ), dot( tanToWorld2, tanNormal74_g262694 ) ) );
					half3 Local_NormalWS250_g262682 = worldNormal74_g262694;
					float3 In_NormalWS3_g262683 = Local_NormalWS250_g262682;
					float4 In_Shader3_g262683 = Local_Masks109_g262682;
					float4 In_Feature3_g262683 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g262683 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g262683 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g262691 = Local_Albedo139_g262682;
					float dotResult20_g262691 = dot( temp_output_3_0_g262691 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g262682 = dotResult20_g262691;
					float temp_output_12_0_g262683 = Local_Grayscale110_g262682;
					float In_Grayscale3_g262683 = temp_output_12_0_g262683;
					float clampResult27_g262693 = clamp( saturate( ( Local_Grayscale110_g262682 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g262682 = clampResult27_g262693;
					float temp_output_16_0_g262683 = Local_Luminosity145_g262682;
					float In_Luminosity3_g262683 = temp_output_16_0_g262683;
					float In_MultiMask3_g262683 = Local_MultiMask78_g262682;
					float temp_output_187_0_g262682 = (Local_AlbedoSample185_g262682).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g262682 = ( temp_output_187_0_g262682 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g262682 = temp_output_187_0_g262682;
					#endif
					half Local_AlphaClip111_g262682 = staticSwitch236_g262682;
					float In_AlphaClip3_g262683 = Local_AlphaClip111_g262682;
					half Local_AlphaFade246_g262682 = (lerpResult62_g262682).a;
					float In_AlphaFade3_g262683 = Local_AlphaFade246_g262682;
					float3 temp_cast_20 = (1.0).xxx;
					float3 In_Translucency3_g262683 = temp_cast_20;
					float In_Transmission3_g262683 = 1.0;
					float In_Thickness3_g262683 = 0.0;
					float In_Diffusion3_g262683 = 0.0;
					float In_Depth3_g262683 = 0.0;
					BuildVisualData( Data3_g262683 , In_Dummy3_g262683 , In_Albedo3_g262683 , In_AlbedoBase3_g262683 , In_NormalTS3_g262683 , In_NormalWS3_g262683 , In_Shader3_g262683 , In_Feature3_g262683 , In_Season3_g262683 , In_Emissive3_g262683 , In_Grayscale3_g262683 , In_Luminosity3_g262683 , In_MultiMask3_g262683 , In_AlphaClip3_g262683 , In_AlphaFade3_g262683 , In_Translucency3_g262683 , In_Transmission3_g262683 , In_Thickness3_g262683 , In_Diffusion3_g262683 , In_Depth3_g262683 );
					TVEVisualData Data4_g262709 =(TVEVisualData)Data3_g262683;
					float Out_Dummy4_g262709 = 0.0;
					float3 Out_Albedo4_g262709 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g262709 = float3( 0,0,0 );
					float2 Out_NormalTS4_g262709 = float2( 0,0 );
					float3 Out_NormalWS4_g262709 = float3( 0,0,0 );
					float4 Out_Shader4_g262709 = float4( 0,0,0,0 );
					float4 Out_Feature4_g262709 = float4( 0,0,0,0 );
					float4 Out_Season4_g262709 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g262709 = float4( 0,0,0,0 );
					float Out_MultiMask4_g262709 = 0.0;
					float Out_Grayscale4_g262709 = 0.0;
					float Out_Luminosity4_g262709 = 0.0;
					float Out_AlphaClip4_g262709 = 0.0;
					float Out_AlphaFade4_g262709 = 0.0;
					float3 Out_Translucency4_g262709 = float3( 0,0,0 );
					float Out_Transmission4_g262709 = 0.0;
					float Out_Thickness4_g262709 = 0.0;
					float Out_Diffusion4_g262709 = 0.0;
					float Out_Depth4_g262709 = 0.0;
					BreakVisualData( Data4_g262709 , Out_Dummy4_g262709 , Out_Albedo4_g262709 , Out_AlbedoBase4_g262709 , Out_NormalTS4_g262709 , Out_NormalWS4_g262709 , Out_Shader4_g262709 , Out_Feature4_g262709 , Out_Season4_g262709 , Out_Emissive4_g262709 , Out_MultiMask4_g262709 , Out_Grayscale4_g262709 , Out_Luminosity4_g262709 , Out_AlphaClip4_g262709 , Out_AlphaFade4_g262709 , Out_Translucency4_g262709 , Out_Transmission4_g262709 , Out_Thickness4_g262709 , Out_Diffusion4_g262709 , Out_Depth4_g262709 );
					float Alpha109_g262704 = Out_AlphaClip4_g262709;
					float lerpResult91_g262704 = lerp( 1.0 , Alpha109_g262704 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g262704 = lerp( 1.0 , lerpResult91_g262704 , Filter152_g262704);
					clip( lerpResult154_g262704 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2720_114;
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

					o.Emission = ( lerpResult72_g262704 * lerpResult84_g262704 );
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
				#pragma shader_feature_local_vertex TVE_PERSPECTIVE
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_vertex TVE_ROTATION
				#pragma shader_feature_local_vertex TVE_SIZEFADE
				#pragma shader_feature_local_vertex TVE_SIZEFADE_ELEMENT
				#pragma shader_feature_local_vertex TVE_MOTION
				#pragma shader_feature_local_vertex TVE_MOTION_ELEMENT
				#pragma shader_feature_local TVE_LEGACY
				#pragma shader_feature_local_vertex TVE_FLATTEN
				#pragma shader_feature_local_vertex TVE_RESHADE
				#pragma shader_feature_local_vertex TVE_TRANSFER
				#if defined (TVE_CONFORM_ROTATION) //Conform Rotation
					#define TVE_ROTATION_BEND //Conform Rotation
				#endif //Conform Rotation
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
				uniform half _PerspectiveCategory;
				uniform half _PerspectiveEnd;
				uniform half _PerspectivePhaseValue;
				uniform half _PerspectiveIntensityValue;
				uniform half _PerspectiveAngleValue;
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
				uniform half _RotationCategory;
				uniform half _RotationEnd;
				uniform half _RotationInfo;
				uniform half _RotationIntensityValue;
				uniform half _SizeFadeCategory;
				uniform half _SizeFadeEnd;
				uniform half4 TVE_SizeFadeParams;
				uniform float _SizeFadeDistMaxValue;
				uniform float _SizeFadeDistMinValue;
				uniform half _SizeFadeScaleValue;
				uniform half _SizeFadeElementMode;
				uniform half _SizeFadeGlobalValue;
				uniform half _SizeFadeScaleMode;
				uniform half _SizeFadeIntensityValue;
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
				uniform half _FlattenCategory;
				uniform half _FlattenEnd;
				uniform half _FlattenBakeMode;
				uniform half _FlattenIntensityValue;
				uniform half3 _FlattenSphereOffsetValue;
				uniform half _FlattenSphereValue;
				uniform half _FlattenMeshMode;
				uniform half4 _FlattenMeshRemap;
				uniform half _FlattenMeshValue;
				uniform half _ReshadeCategory;
				uniform half _ReshadeEnd;
				uniform half _ReshadeIntensityValue;
				uniform half _TransferCategory;
				uniform half _TransferEnd;
				uniform half _TransferSpace;
				uniform half _TransferIntensityValue;
				uniform half _TransferPerPixelMode;
				uniform half _TransferInfo;
				uniform half4 _TransferProjRemap;
				uniform half _TransferProjValue;
				uniform half _TransferMeshMode;
				uniform half4 _TransferMeshRemap;
				uniform half _TransferMeshValue;
				uniform half _TransferFormOffsetValue;
				uniform half _TransferFormValue;
				uniform half _TransferFormMode;


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
				
				float3 ASESafeNormalize(float3 inVec)
				{
					float dp3 = max(1.175494351e-38, dot(inVec, inVec));
					return inVec* rsqrt(dp3);
				}
				

				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float localIfModelDataByShader26_g262440 = ( 0.0 );
					TVEModelData Data26_g262440 = (TVEModelData)0;
					TVEModelData Data16_g262431 =(TVEModelData)0;
					half Dummy207_g262421 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g262431 = Dummy207_g262421;
					float In_Dummy16_g262431 = temp_output_14_0_g262431;
					float3 PositionOS131_g262421 = v.vertex.xyz;
					float3 temp_output_4_0_g262431 = PositionOS131_g262421;
					float3 In_PositionOS16_g262431 = temp_output_4_0_g262431;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g262421 = ase_positionWS;
					float3 vertexToFrag73_g262421 = temp_output_104_7_g262421;
					float3 PositionWS122_g262421 = vertexToFrag73_g262421;
					float3 In_PositionWS16_g262431 = PositionWS122_g262421;
					float4x4 break19_g262424 = unity_ObjectToWorld;
					float3 appendResult20_g262424 = (float3(break19_g262424[ 0 ][ 3 ] , break19_g262424[ 1 ][ 3 ] , break19_g262424[ 2 ][ 3 ]));
					float3 temp_output_340_7_g262421 = appendResult20_g262424;
					float4x4 break19_g262426 = unity_ObjectToWorld;
					float3 appendResult20_g262426 = (float3(break19_g262426[ 0 ][ 3 ] , break19_g262426[ 1 ][ 3 ] , break19_g262426[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g262422 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g262421 = PositionOS131_g262421;
					float3 appendResult234_g262421 = (float3(break233_g262421.x , 0.0 , break233_g262421.z));
					float3 break413_g262421 = PositionOS131_g262421;
					float3 appendResult414_g262421 = (float3(break413_g262421.x , break413_g262421.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262428 = appendResult414_g262421;
					#else
					float3 staticSwitch65_g262428 = appendResult234_g262421;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g262421 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g262421 = appendResult60_g262422;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g262421 = staticSwitch65_g262428;
					#else
					float3 staticSwitch229_g262421 = _Vector0;
					#endif
					float3 PivotOS149_g262421 = staticSwitch229_g262421;
					float3 temp_output_122_0_g262426 = PivotOS149_g262421;
					float3 PivotsOnlyWS105_g262426 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g262426 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g262421 = ( appendResult20_g262426 + PivotsOnlyWS105_g262426 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g262421 = temp_output_340_7_g262421;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g262421 = temp_output_341_7_g262421;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g262421 = temp_output_341_7_g262421;
					#else
					float3 staticSwitch236_g262421 = temp_output_340_7_g262421;
					#endif
					float3 vertexToFrag76_g262421 = staticSwitch236_g262421;
					float3 PivotWS121_g262421 = vertexToFrag76_g262421;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g262421 = ( PositionWS122_g262421 - PivotWS121_g262421 );
					#else
					float3 staticSwitch204_g262421 = PositionWS122_g262421;
					#endif
					float3 PositionWO132_g262421 = ( staticSwitch204_g262421 - TVE_WorldOrigin );
					float3 In_PositionWO16_g262431 = PositionWO132_g262421;
					float3 In_PositionRawOS16_g262431 = PositionOS131_g262421;
					float3 In_PivotOS16_g262431 = PivotOS149_g262421;
					float3 In_PivotWS16_g262431 = PivotWS121_g262421;
					float3 PivotWO133_g262421 = ( PivotWS121_g262421 - TVE_WorldOrigin );
					float3 In_PivotWO16_g262431 = PivotWO133_g262421;
					half3 NormalOS134_g262421 = v.normal;
					float3 temp_output_21_0_g262431 = NormalOS134_g262421;
					float3 In_NormalOS16_g262431 = temp_output_21_0_g262431;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g262421 = normalizedWorldNormal;
					float3 In_NormalWS16_g262431 = NormalWS95_g262421;
					float3 In_NormalRawOS16_g262431 = NormalOS134_g262421;
					half4 TangentlOS153_g262421 = v.tangent;
					float4 temp_output_6_0_g262431 = TangentlOS153_g262421;
					float4 In_TangentOS16_g262431 = temp_output_6_0_g262431;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g262421 = ase_tangentWS;
					float3 In_TangentWS16_g262431 = TangentWS136_g262421;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g262421 = ase_bitangentWS;
					float3 In_BitangentWS16_g262431 = BiangentWS421_g262421;
					float3 normalizeResult296_g262421 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g262421 ) );
					half3 ViewDirWS169_g262421 = normalizeResult296_g262421;
					float3 In_ViewDirWS16_g262431 = ViewDirWS169_g262421;
					float4 appendResult397_g262421 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g262421 = appendResult397_g262421;
					float4 In_CoordsData16_g262431 = CoordsData398_g262421;
					half4 VertexMasks171_g262421 = v.ase_color;
					float4 In_VertexData16_g262431 = VertexMasks171_g262421;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g262434 = (PositionOS131_g262421).z;
					#else
					float staticSwitch65_g262434 = (PositionOS131_g262421).y;
					#endif
					half Object_HeightValue267_g262421 = _ObjectHeightValue;
					half Bounds_HeightMask274_g262421 = saturate( ( staticSwitch65_g262434 / Object_HeightValue267_g262421 ) );
					half3 Position387_g262421 = PositionOS131_g262421;
					half Height387_g262421 = Object_HeightValue267_g262421;
					half Object_RadiusValue268_g262421 = _ObjectRadiusValue;
					half Radius387_g262421 = Object_RadiusValue268_g262421;
					half localCapsuleMaskYUp387_g262421 = CapsuleMaskYUp( Position387_g262421 , Height387_g262421 , Radius387_g262421 );
					half3 Position408_g262421 = PositionOS131_g262421;
					half Height408_g262421 = Object_HeightValue267_g262421;
					half Radius408_g262421 = Object_RadiusValue268_g262421;
					half localCapsuleMaskZUp408_g262421 = CapsuleMaskZUp( Position408_g262421 , Height408_g262421 , Radius408_g262421 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g262439 = saturate( localCapsuleMaskZUp408_g262421 );
					#else
					float staticSwitch65_g262439 = saturate( localCapsuleMaskYUp387_g262421 );
					#endif
					half Bounds_SphereMask282_g262421 = staticSwitch65_g262439;
					float4 appendResult253_g262421 = (float4(Bounds_HeightMask274_g262421 , Bounds_SphereMask282_g262421 , 1.0 , 1.0));
					half4 MasksData254_g262421 = appendResult253_g262421;
					float4 In_MasksData16_g262431 = MasksData254_g262421;
					float temp_output_17_0_g262433 = _ObjectPhaseMode;
					float Option70_g262433 = temp_output_17_0_g262433;
					float4 temp_output_3_0_g262433 = v.ase_color;
					float4 Channel70_g262433 = temp_output_3_0_g262433;
					float localSwitchChannel470_g262433 = SwitchChannel4( Option70_g262433 , Channel70_g262433 );
					half Phase_Value372_g262421 = localSwitchChannel470_g262433;
					float3 break319_g262421 = PivotWO133_g262421;
					half Pivot_Position322_g262421 = ( break319_g262421.x + break319_g262421.z );
					half Phase_Position357_g262421 = ( Phase_Value372_g262421 + Pivot_Position322_g262421 );
					float temp_output_248_0_g262421 = frac( Phase_Position357_g262421 );
					float4 appendResult177_g262421 = (float4(( (frac( ( Phase_Position357_g262421 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g262421));
					half4 Phase_Data176_g262421 = appendResult177_g262421;
					float4 In_PhaseData16_g262431 = Phase_Data176_g262421;
					float4 In_TransformData16_g262431 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g262431 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g262431 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g262431 , In_Dummy16_g262431 , In_PositionOS16_g262431 , In_PositionWS16_g262431 , In_PositionWO16_g262431 , In_PositionRawOS16_g262431 , In_PivotOS16_g262431 , In_PivotWS16_g262431 , In_PivotWO16_g262431 , In_NormalOS16_g262431 , In_NormalWS16_g262431 , In_NormalRawOS16_g262431 , In_TangentOS16_g262431 , In_TangentWS16_g262431 , In_BitangentWS16_g262431 , In_ViewDirWS16_g262431 , In_CoordsData16_g262431 , In_VertexData16_g262431 , In_MasksData16_g262431 , In_PhaseData16_g262431 , In_TransformData16_g262431 , In_RotationData16_g262431 , In_InterpolatorA16_g262431 );
					TVEModelData DataDefault26_g262440 = Data16_g262431;
					TVEModelData DataGeneral26_g262440 = Data16_g262431;
					TVEModelData DataBlanket26_g262440 = Data16_g262431;
					TVEModelData DataImpostor26_g262440 = Data16_g262431;
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
					TVEModelData DataTerrain26_g262440 = Data16_g241828;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g262440 = IsShaderType2637;
					{
					if (Type26_g262440 == 0 )
					{
					Data26_g262440 = DataDefault26_g262440;
					}
					else if (Type26_g262440 == 1 )
					{
					Data26_g262440 = DataGeneral26_g262440;
					}
					else if (Type26_g262440 == 2 )
					{
					Data26_g262440 = DataBlanket26_g262440;
					}
					else if (Type26_g262440 == 3 )
					{
					Data26_g262440 = DataImpostor26_g262440;
					}
					else if (Type26_g262440 == 4 )
					{
					Data26_g262440 = DataTerrain26_g262440;
					}
					}
					TVEModelData Data15_g262519 =(TVEModelData)Data26_g262440;
					float Out_Dummy15_g262519 = 0.0;
					float3 Out_PositionOS15_g262519 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262519 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262519 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262519 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262519 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262519 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262519 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262519 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262519 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262519 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262519 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262519 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262519 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262519 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262519 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262519 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262519 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262519 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262519 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262519 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262519 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262519 , Out_Dummy15_g262519 , Out_PositionOS15_g262519 , Out_PositionWS15_g262519 , Out_PositionWO15_g262519 , Out_PositionRawOS15_g262519 , Out_PivotOS15_g262519 , Out_PivotWS15_g262519 , Out_PivotWO15_g262519 , Out_NormalOS15_g262519 , Out_NormalWS15_g262519 , Out_NormalRawOS15_g262519 , Out_TangentOS15_g262519 , Out_TangentWS15_g262519 , Out_BitangentWS15_g262519 , Out_ViewDirWS15_g262519 , Out_CoordsData15_g262519 , Out_VertexData15_g262519 , Out_MasksData15_g262519 , Out_PhaseData15_g262519 , Out_TransformData15_g262519 , Out_RotationData15_g262519 , Out_InterpolatorA15_g262519 );
					TVEModelData Data16_g262521 =(TVEModelData)Data15_g262519;
					float temp_output_14_0_g262521 = 0.0;
					float In_Dummy16_g262521 = temp_output_14_0_g262521;
					float3 temp_output_219_24_g262518 = Out_PivotOS15_g262519;
					float3 temp_output_215_0_g262518 = ( Out_PositionOS15_g262519 - temp_output_219_24_g262518 );
					float3 temp_output_4_0_g262521 = temp_output_215_0_g262518;
					float3 In_PositionOS16_g262521 = temp_output_4_0_g262521;
					float3 In_PositionWS16_g262521 = Out_PositionWS15_g262519;
					float3 In_PositionWO16_g262521 = Out_PositionWO15_g262519;
					float3 In_PositionRawOS16_g262521 = Out_PositionRawOS15_g262519;
					float3 In_PivotOS16_g262521 = temp_output_219_24_g262518;
					float3 In_PivotWS16_g262521 = Out_PivotWS15_g262519;
					float3 In_PivotWO16_g262521 = Out_PivotWO15_g262519;
					float3 temp_output_21_0_g262521 = Out_NormalOS15_g262519;
					float3 In_NormalOS16_g262521 = temp_output_21_0_g262521;
					float3 In_NormalWS16_g262521 = Out_NormalWS15_g262519;
					float3 In_NormalRawOS16_g262521 = Out_NormalRawOS15_g262519;
					float4 temp_output_6_0_g262521 = Out_TangentOS15_g262519;
					float4 In_TangentOS16_g262521 = temp_output_6_0_g262521;
					float3 In_TangentWS16_g262521 = Out_TangentWS15_g262519;
					float3 In_BitangentWS16_g262521 = Out_BitangentWS15_g262519;
					float3 In_ViewDirWS16_g262521 = Out_ViewDirWS15_g262519;
					float4 In_CoordsData16_g262521 = Out_CoordsData15_g262519;
					float4 In_VertexData16_g262521 = Out_VertexData15_g262519;
					float4 In_MasksData16_g262521 = Out_MasksData15_g262519;
					float4 In_PhaseData16_g262521 = Out_PhaseData15_g262519;
					float4 In_TransformData16_g262521 = Out_TransformData15_g262519;
					float4 In_RotationData16_g262521 = Out_RotationData15_g262519;
					float4 In_InterpolatorA16_g262521 = Out_InterpolatorA15_g262519;
					BuildModelVertData( Data16_g262521 , In_Dummy16_g262521 , In_PositionOS16_g262521 , In_PositionWS16_g262521 , In_PositionWO16_g262521 , In_PositionRawOS16_g262521 , In_PivotOS16_g262521 , In_PivotWS16_g262521 , In_PivotWO16_g262521 , In_NormalOS16_g262521 , In_NormalWS16_g262521 , In_NormalRawOS16_g262521 , In_TangentOS16_g262521 , In_TangentWS16_g262521 , In_BitangentWS16_g262521 , In_ViewDirWS16_g262521 , In_CoordsData16_g262521 , In_VertexData16_g262521 , In_MasksData16_g262521 , In_PhaseData16_g262521 , In_TransformData16_g262521 , In_RotationData16_g262521 , In_InterpolatorA16_g262521 );
					TVEModelData Data15_g262525 =(TVEModelData)Data16_g262521;
					float Out_Dummy15_g262525 = 0.0;
					float3 Out_PositionOS15_g262525 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262525 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262525 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262525 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262525 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262525 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262525 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262525 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262525 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262525 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262525 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262525 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262525 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262525 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262525 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262525 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262525 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262525 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262525 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262525 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262525 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262525 , Out_Dummy15_g262525 , Out_PositionOS15_g262525 , Out_PositionWS15_g262525 , Out_PositionWO15_g262525 , Out_PositionRawOS15_g262525 , Out_PivotOS15_g262525 , Out_PivotWS15_g262525 , Out_PivotWO15_g262525 , Out_NormalOS15_g262525 , Out_NormalWS15_g262525 , Out_NormalRawOS15_g262525 , Out_TangentOS15_g262525 , Out_TangentWS15_g262525 , Out_BitangentWS15_g262525 , Out_ViewDirWS15_g262525 , Out_CoordsData15_g262525 , Out_VertexData15_g262525 , Out_MasksData15_g262525 , Out_PhaseData15_g262525 , Out_TransformData15_g262525 , Out_RotationData15_g262525 , Out_InterpolatorA15_g262525 );
					TVEModelData Data16_g262524 =(TVEModelData)Data15_g262525;
					half Dummy181_g262522 = ( _PerspectiveCategory + _PerspectiveEnd );
					float temp_output_14_0_g262524 = Dummy181_g262522;
					float In_Dummy16_g262524 = temp_output_14_0_g262524;
					half3 Model_PositionOS147_g262522 = Out_PositionOS15_g262525;
					float3 temp_output_228_35_g262522 = Out_ViewDirWS15_g262525;
					half3 Model_ViewDirWS237_g262522 = temp_output_228_35_g262522;
					float4x4 break117_g262523 = unity_CameraToWorld;
					float3 appendResult118_g262523 = (float3(break117_g262523[ 0 ][ 2 ] , break117_g262523[ 1 ][ 2 ] , break117_g262523[ 2 ][ 2 ]));
					float3 lerpResult209_g262522 = lerp( Model_ViewDirWS237_g262522 , -appendResult118_g262523 , unity_OrthoParams.w);
					float3 break201_g262522 = cross( lerpResult209_g262522 , half3( 0, 1, 0 ) );
					float3 appendResult196_g262522 = (float3(-break201_g262522.z , 0.0 , break201_g262522.x));
					float4 temp_output_228_27_g262522 = Out_PhaseData15_g262525;
					half4 Model_PhaseData218_g262522 = temp_output_228_27_g262522;
					float2 break226_g262522 = ( (Model_PhaseData218_g262522).xy * _PerspectivePhaseValue );
					float3 appendResult224_g262522 = (float3(break226_g262522.x , 0.0 , break226_g262522.y));
					float dotResult189_g262522 = dot( Model_ViewDirWS237_g262522 , float3( 0, 1, 0 ) );
					float saferPower192_g262522 = abs( dotResult189_g262522 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g262526 = (Model_PositionOS147_g262522).z;
					#else
					float staticSwitch65_g262526 = (Model_PositionOS147_g262522).y;
					#endif
					float3 temp_output_206_0_g262522 = ( Model_PositionOS147_g262522 + ( ( mul( unity_WorldToObject, float4( appendResult196_g262522 , 0.0 ) ).xyz + appendResult224_g262522 ) * _PerspectiveIntensityValue * pow( saferPower192_g262522 , _PerspectiveAngleValue ) * saturate( staticSwitch65_g262526 ) ) );
					#ifdef TVE_PERSPECTIVE
					float3 staticSwitch211_g262522 = temp_output_206_0_g262522;
					#else
					float3 staticSwitch211_g262522 = Model_PositionOS147_g262522;
					#endif
					float3 Final_Position178_g262522 = staticSwitch211_g262522;
					float3 temp_output_4_0_g262524 = Final_Position178_g262522;
					float3 In_PositionOS16_g262524 = temp_output_4_0_g262524;
					float3 In_PositionWS16_g262524 = Out_PositionWS15_g262525;
					float3 In_PositionWO16_g262524 = Out_PositionWO15_g262525;
					float3 In_PositionRawOS16_g262524 = Out_PositionRawOS15_g262525;
					float3 In_PivotOS16_g262524 = Out_PivotOS15_g262525;
					float3 In_PivotWS16_g262524 = Out_PivotWS15_g262525;
					float3 In_PivotWO16_g262524 = Out_PivotWO15_g262525;
					float3 temp_output_21_0_g262524 = Out_NormalOS15_g262525;
					float3 In_NormalOS16_g262524 = temp_output_21_0_g262524;
					float3 In_NormalWS16_g262524 = Out_NormalWS15_g262525;
					float3 In_NormalRawOS16_g262524 = Out_NormalRawOS15_g262525;
					float4 temp_output_6_0_g262524 = Out_TangentOS15_g262525;
					float4 In_TangentOS16_g262524 = temp_output_6_0_g262524;
					float3 In_TangentWS16_g262524 = Out_TangentWS15_g262525;
					float3 In_BitangentWS16_g262524 = Out_BitangentWS15_g262525;
					float3 In_ViewDirWS16_g262524 = temp_output_228_35_g262522;
					float4 In_CoordsData16_g262524 = Out_CoordsData15_g262525;
					float4 In_VertexData16_g262524 = Out_VertexData15_g262525;
					float4 In_MasksData16_g262524 = Out_MasksData15_g262525;
					float4 In_PhaseData16_g262524 = temp_output_228_27_g262522;
					float4 In_TransformData16_g262524 = Out_TransformData15_g262525;
					float4 temp_output_228_33_g262522 = Out_RotationData15_g262525;
					float4 In_RotationData16_g262524 = temp_output_228_33_g262522;
					float4 In_InterpolatorA16_g262524 = Out_InterpolatorA15_g262525;
					BuildModelVertData( Data16_g262524 , In_Dummy16_g262524 , In_PositionOS16_g262524 , In_PositionWS16_g262524 , In_PositionWO16_g262524 , In_PositionRawOS16_g262524 , In_PivotOS16_g262524 , In_PivotWS16_g262524 , In_PivotWO16_g262524 , In_NormalOS16_g262524 , In_NormalWS16_g262524 , In_NormalRawOS16_g262524 , In_TangentOS16_g262524 , In_TangentWS16_g262524 , In_BitangentWS16_g262524 , In_ViewDirWS16_g262524 , In_CoordsData16_g262524 , In_VertexData16_g262524 , In_MasksData16_g262524 , In_PhaseData16_g262524 , In_TransformData16_g262524 , In_RotationData16_g262524 , In_InterpolatorA16_g262524 );
					TVEModelData Data15_g262528 =(TVEModelData)Data16_g262524;
					float Out_Dummy15_g262528 = 0.0;
					float3 Out_PositionOS15_g262528 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262528 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262528 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262528 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262528 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262528 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262528 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262528 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262528 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262528 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262528 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262528 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262528 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262528 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262528 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262528 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262528 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262528 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262528 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262528 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262528 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262528 , Out_Dummy15_g262528 , Out_PositionOS15_g262528 , Out_PositionWS15_g262528 , Out_PositionWO15_g262528 , Out_PositionRawOS15_g262528 , Out_PivotOS15_g262528 , Out_PivotWS15_g262528 , Out_PivotWO15_g262528 , Out_NormalOS15_g262528 , Out_NormalWS15_g262528 , Out_NormalRawOS15_g262528 , Out_TangentOS15_g262528 , Out_TangentWS15_g262528 , Out_BitangentWS15_g262528 , Out_ViewDirWS15_g262528 , Out_CoordsData15_g262528 , Out_VertexData15_g262528 , Out_MasksData15_g262528 , Out_PhaseData15_g262528 , Out_TransformData15_g262528 , Out_RotationData15_g262528 , Out_InterpolatorA15_g262528 );
					TVEModelData Data16_g262529 =(TVEModelData)Data15_g262528;
					half Dummy317_g262527 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g262529 = Dummy317_g262527;
					float In_Dummy16_g262529 = temp_output_14_0_g262529;
					float3 temp_output_4_0_g262529 = Out_PositionOS15_g262528;
					float3 In_PositionOS16_g262529 = temp_output_4_0_g262529;
					float3 In_PositionWS16_g262529 = Out_PositionWS15_g262528;
					float3 temp_output_314_17_g262527 = Out_PositionWO15_g262528;
					float3 In_PositionWO16_g262529 = temp_output_314_17_g262527;
					float3 In_PositionRawOS16_g262529 = Out_PositionRawOS15_g262528;
					float3 In_PivotOS16_g262529 = Out_PivotOS15_g262528;
					float3 In_PivotWS16_g262529 = Out_PivotWS15_g262528;
					float3 temp_output_314_19_g262527 = Out_PivotWO15_g262528;
					float3 In_PivotWO16_g262529 = temp_output_314_19_g262527;
					float3 temp_output_21_0_g262529 = Out_NormalOS15_g262528;
					float3 In_NormalOS16_g262529 = temp_output_21_0_g262529;
					float3 In_NormalWS16_g262529 = Out_NormalWS15_g262528;
					float3 In_NormalRawOS16_g262529 = Out_NormalRawOS15_g262528;
					float4 temp_output_6_0_g262529 = Out_TangentOS15_g262528;
					float4 In_TangentOS16_g262529 = temp_output_6_0_g262529;
					float3 In_TangentWS16_g262529 = Out_TangentWS15_g262528;
					float3 In_BitangentWS16_g262529 = Out_BitangentWS15_g262528;
					float3 In_ViewDirWS16_g262529 = Out_ViewDirWS15_g262528;
					float4 In_CoordsData16_g262529 = Out_CoordsData15_g262528;
					float4 temp_output_314_29_g262527 = Out_VertexData15_g262528;
					float4 In_VertexData16_g262529 = temp_output_314_29_g262527;
					float4 In_MasksData16_g262529 = Out_MasksData15_g262528;
					float4 In_PhaseData16_g262529 = Out_PhaseData15_g262528;
					half4 Model_TransformData356_g262527 = Out_TransformData15_g262528;
					float localBuildGlobalData204_g262441 = ( 0.0 );
					TVEGlobalData Data204_g262441 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g262441 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g262441 = Dummy211_g262441;
					float4 temp_output_589_164_g262441 = TVE_CoatParams;
					half4 Coat_Params596_g262441 = temp_output_589_164_g262441;
					float4 In_CoatParams204_g262441 = Coat_Params596_g262441;
					float4 temp_output_203_0_g262461 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g262420 = ( 0.0 );
					TVEModelData Data26_g262420 = (TVEModelData)0;
					TVEModelData DataDefault26_g262420 = Data16_g241828;
					TVEModelData Data16_g262429 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g262429 = 0.0;
					float3 In_PositionWS16_g262429 = PositionWS122_g262421;
					float3 In_PositionWO16_g262429 = PositionWO132_g262421;
					float3 In_PivotWS16_g262429 = PivotWS121_g262421;
					float3 In_PivotWO16_g262429 = PivotWO133_g262421;
					float3 In_NormalWS16_g262429 = NormalWS95_g262421;
					float3 In_TangentWS16_g262429 = TangentWS136_g262421;
					float3 In_BitangentWS16_g262429 = BiangentWS421_g262421;
					half3 NormalWS427_g262421 = NormalWS95_g262421;
					half3 localComputeTriplanarWeights427_g262421 = ComputeTriplanarWeights( NormalWS427_g262421 );
					half3 TriplanarWeights429_g262421 = localComputeTriplanarWeights427_g262421;
					float3 In_TriplanarWeights16_g262429 = TriplanarWeights429_g262421;
					float3 In_ViewDirWS16_g262429 = ViewDirWS169_g262421;
					float4 In_CoordsData16_g262429 = CoordsData398_g262421;
					float4 In_VertexData16_g262429 = VertexMasks171_g262421;
					float4 In_PhaseData16_g262429 = Phase_Data176_g262421;
					BuildModelFragData( Data16_g262429 , In_Dummy16_g262429 , In_PositionWS16_g262429 , In_PositionWO16_g262429 , In_PivotWS16_g262429 , In_PivotWO16_g262429 , In_NormalWS16_g262429 , In_TangentWS16_g262429 , In_BitangentWS16_g262429 , In_TriplanarWeights16_g262429 , In_ViewDirWS16_g262429 , In_CoordsData16_g262429 , In_VertexData16_g262429 , In_PhaseData16_g262429 );
					TVEModelData DataGeneral26_g262420 = Data16_g262429;
					TVEModelData DataBlanket26_g262420 = Data16_g262429;
					TVEModelData DataImpostor26_g262420 = Data16_g262429;
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
					TVEModelData DataTerrain26_g262420 = Data16_g241826;
					float Type26_g262420 = IsShaderType2637;
					{
					if (Type26_g262420 == 0 )
					{
					Data26_g262420 = DataDefault26_g262420;
					}
					else if (Type26_g262420 == 1 )
					{
					Data26_g262420 = DataGeneral26_g262420;
					}
					else if (Type26_g262420 == 2 )
					{
					Data26_g262420 = DataBlanket26_g262420;
					}
					else if (Type26_g262420 == 3 )
					{
					Data26_g262420 = DataImpostor26_g262420;
					}
					else if (Type26_g262420 == 4 )
					{
					Data26_g262420 = DataTerrain26_g262420;
					}
					}
					TVEModelData Data15_g262517 =(TVEModelData)Data26_g262420;
					float Out_Dummy15_g262517 = 0.0;
					float3 Out_PositionWS15_g262517 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262517 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262517 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262517 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262517 = float3( 0,0,0 );
					float3 Out_TangentWS15_g262517 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262517 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g262517 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262517 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262517 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262517 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262517 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g262517 , Out_Dummy15_g262517 , Out_PositionWS15_g262517 , Out_PositionWO15_g262517 , Out_PivotWS15_g262517 , Out_PivotWO15_g262517 , Out_NormalWS15_g262517 , Out_TangentWS15_g262517 , Out_BitangentWS15_g262517 , Out_TriplanarWeights15_g262517 , Out_ViewDirWS15_g262517 , Out_CoordsData15_g262517 , Out_VertexData15_g262517 , Out_PhaseData15_g262517 );
					float3 Model_PositionWS497_g262441 = Out_PositionWS15_g262517;
					float2 Model_PositionWS_XZ143_g262441 = (Model_PositionWS497_g262441).xz;
					float3 Model_PivotWS498_g262441 = Out_PivotWS15_g262517;
					float2 Model_PivotWS_XZ145_g262441 = (Model_PivotWS498_g262441).xz;
					float2 lerpResult300_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g262461 = lerpResult300_g262441;
					float temp_output_82_0_g262459 = _GlobalCoatLayerValue;
					float temp_output_82_0_g262461 = temp_output_82_0_g262459;
					float4 tex2DArrayNode83_g262461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262461).zw + ( (temp_output_203_0_g262461).xy * temp_output_81_0_g262461 ) ),temp_output_82_0_g262461), 0.0 );
					float4 appendResult210_g262461 = (float4(tex2DArrayNode83_g262461.rgb , saturate( tex2DArrayNode83_g262461.a )));
					float4 temp_output_204_0_g262461 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g262461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262461).zw + ( (temp_output_204_0_g262461).xy * temp_output_81_0_g262461 ) ),temp_output_82_0_g262461), 0.0 );
					float4 appendResult212_g262461 = (float4(tex2DArrayNode122_g262461.rgb , saturate( tex2DArrayNode122_g262461.a )));
					float4 TVE_RenderNearPositionR628_g262441 = TVE_RenderNearPositionR;
					float temp_output_507_0_g262441 = saturate( ( distance( Model_PositionWS497_g262441 , (TVE_RenderNearPositionR628_g262441).xyz ) / (TVE_RenderNearPositionR628_g262441).w ) );
					float temp_output_7_0_g262442 = 1.0;
					float temp_output_9_0_g262442 = ( temp_output_507_0_g262441 - temp_output_7_0_g262442 );
					half TVE_RenderNearFadeValue635_g262441 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g262441 = saturate( ( temp_output_9_0_g262442 / ( ( TVE_RenderNearFadeValue635_g262441 - temp_output_7_0_g262442 ) + 0.0001 ) ) );
					float4 lerpResult131_g262461 = lerp( appendResult210_g262461 , appendResult212_g262461 , Global_TexBlend509_g262441);
					float4 temp_output_159_109_g262459 = lerpResult131_g262461;
					float4 lerpResult168_g262459 = lerp( TVE_CoatParams , temp_output_159_109_g262459 , TVE_CoatLayers[(int)temp_output_82_0_g262459]);
					float4 temp_output_589_109_g262441 = lerpResult168_g262459;
					half4 Coat_Texture302_g262441 = temp_output_589_109_g262441;
					float4 In_CoatTexture204_g262441 = Coat_Texture302_g262441;
					float4 temp_output_595_164_g262441 = TVE_PaintParams;
					half4 Paint_Params575_g262441 = temp_output_595_164_g262441;
					float4 In_PaintParams204_g262441 = Paint_Params575_g262441;
					float4 temp_output_203_0_g262510 = TVE_PaintBaseCoord;
					float2 lerpResult85_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g262510 = lerpResult85_g262441;
					float temp_output_82_0_g262507 = _GlobalPaintLayerValue;
					float temp_output_82_0_g262510 = temp_output_82_0_g262507;
					float4 tex2DArrayNode83_g262510 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262510).zw + ( (temp_output_203_0_g262510).xy * temp_output_81_0_g262510 ) ),temp_output_82_0_g262510), 0.0 );
					float4 appendResult210_g262510 = (float4(tex2DArrayNode83_g262510.rgb , saturate( tex2DArrayNode83_g262510.a )));
					float4 temp_output_204_0_g262510 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g262510 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262510).zw + ( (temp_output_204_0_g262510).xy * temp_output_81_0_g262510 ) ),temp_output_82_0_g262510), 0.0 );
					float4 appendResult212_g262510 = (float4(tex2DArrayNode122_g262510.rgb , saturate( tex2DArrayNode122_g262510.a )));
					float4 lerpResult131_g262510 = lerp( appendResult210_g262510 , appendResult212_g262510 , Global_TexBlend509_g262441);
					float4 temp_output_171_109_g262507 = lerpResult131_g262510;
					float4 lerpResult174_g262507 = lerp( TVE_PaintParams , temp_output_171_109_g262507 , TVE_PaintLayers[(int)temp_output_82_0_g262507]);
					float4 temp_output_595_109_g262441 = lerpResult174_g262507;
					half4 Paint_Texture71_g262441 = temp_output_595_109_g262441;
					float4 In_PaintTexture204_g262441 = Paint_Texture71_g262441;
					float4 temp_output_590_141_g262441 = TVE_AtmoParams;
					half4 Atmo_Params601_g262441 = temp_output_590_141_g262441;
					float4 In_AtmoParams204_g262441 = Atmo_Params601_g262441;
					float4 temp_output_203_0_g262469 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g262469 = lerpResult104_g262441;
					float temp_output_132_0_g262467 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g262469 = temp_output_132_0_g262467;
					float4 tex2DArrayNode83_g262469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262469).zw + ( (temp_output_203_0_g262469).xy * temp_output_81_0_g262469 ) ),temp_output_82_0_g262469), 0.0 );
					float4 appendResult210_g262469 = (float4(tex2DArrayNode83_g262469.rgb , saturate( tex2DArrayNode83_g262469.a )));
					float4 temp_output_204_0_g262469 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g262469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262469).zw + ( (temp_output_204_0_g262469).xy * temp_output_81_0_g262469 ) ),temp_output_82_0_g262469), 0.0 );
					float4 appendResult212_g262469 = (float4(tex2DArrayNode122_g262469.rgb , saturate( tex2DArrayNode122_g262469.a )));
					float4 lerpResult131_g262469 = lerp( appendResult210_g262469 , appendResult212_g262469 , Global_TexBlend509_g262441);
					float4 temp_output_137_109_g262467 = lerpResult131_g262469;
					float4 lerpResult145_g262467 = lerp( TVE_AtmoParams , temp_output_137_109_g262467 , TVE_AtmoLayers[(int)temp_output_132_0_g262467]);
					float4 temp_output_590_110_g262441 = lerpResult145_g262467;
					half4 Atmo_Texture80_g262441 = temp_output_590_110_g262441;
					float4 In_AtmoTexture204_g262441 = Atmo_Texture80_g262441;
					float4 temp_output_593_163_g262441 = TVE_GlowParams;
					half4 Glow_Params609_g262441 = temp_output_593_163_g262441;
					float4 In_GlowParams204_g262441 = Glow_Params609_g262441;
					float4 temp_output_203_0_g262485 = TVE_GlowBaseCoord;
					float2 lerpResult247_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g262485 = lerpResult247_g262441;
					float temp_output_82_0_g262483 = _GlobalGlowLayerValue;
					float temp_output_82_0_g262485 = temp_output_82_0_g262483;
					float4 tex2DArrayNode83_g262485 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262485).zw + ( (temp_output_203_0_g262485).xy * temp_output_81_0_g262485 ) ),temp_output_82_0_g262485), 0.0 );
					float4 appendResult210_g262485 = (float4(tex2DArrayNode83_g262485.rgb , saturate( tex2DArrayNode83_g262485.a )));
					float4 temp_output_204_0_g262485 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g262485 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262485).zw + ( (temp_output_204_0_g262485).xy * temp_output_81_0_g262485 ) ),temp_output_82_0_g262485), 0.0 );
					float4 appendResult212_g262485 = (float4(tex2DArrayNode122_g262485.rgb , saturate( tex2DArrayNode122_g262485.a )));
					float4 lerpResult131_g262485 = lerp( appendResult210_g262485 , appendResult212_g262485 , Global_TexBlend509_g262441);
					float4 temp_output_159_109_g262483 = lerpResult131_g262485;
					float4 lerpResult167_g262483 = lerp( TVE_GlowParams , temp_output_159_109_g262483 , TVE_GlowLayers[(int)temp_output_82_0_g262483]);
					float4 temp_output_593_109_g262441 = lerpResult167_g262483;
					half4 Glow_Texture248_g262441 = temp_output_593_109_g262441;
					float4 In_GlowTexture204_g262441 = Glow_Texture248_g262441;
					float4 temp_output_592_139_g262441 = TVE_FormParams;
					float4 Form_Params606_g262441 = temp_output_592_139_g262441;
					float4 In_FormParams204_g262441 = Form_Params606_g262441;
					float4 temp_output_203_0_g262501 = TVE_FormBaseCoord;
					float2 lerpResult168_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g262501 = lerpResult168_g262441;
					float temp_output_130_0_g262499 = _GlobalFormLayerValue;
					float temp_output_82_0_g262501 = temp_output_130_0_g262499;
					float4 tex2DArrayNode83_g262501 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262501).zw + ( (temp_output_203_0_g262501).xy * temp_output_81_0_g262501 ) ),temp_output_82_0_g262501), 0.0 );
					float4 appendResult210_g262501 = (float4(tex2DArrayNode83_g262501.rgb , saturate( tex2DArrayNode83_g262501.a )));
					float4 temp_output_204_0_g262501 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g262501 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262501).zw + ( (temp_output_204_0_g262501).xy * temp_output_81_0_g262501 ) ),temp_output_82_0_g262501), 0.0 );
					float4 appendResult212_g262501 = (float4(tex2DArrayNode122_g262501.rgb , saturate( tex2DArrayNode122_g262501.a )));
					float4 lerpResult131_g262501 = lerp( appendResult210_g262501 , appendResult212_g262501 , Global_TexBlend509_g262441);
					float4 temp_output_135_109_g262499 = lerpResult131_g262501;
					float4 lerpResult143_g262499 = lerp( TVE_FormParams , temp_output_135_109_g262499 , TVE_FormLayers[(int)temp_output_130_0_g262499]);
					float4 temp_output_592_0_g262441 = lerpResult143_g262499;
					float4 Form_Texture112_g262441 = temp_output_592_0_g262441;
					float4 In_FormTexture204_g262441 = Form_Texture112_g262441;
					float4 temp_output_594_145_g262441 = TVE_FlowParams;
					half4 Flow_Params612_g262441 = temp_output_594_145_g262441;
					float4 In_FlowParams204_g262441 = Flow_Params612_g262441;
					float4 temp_output_203_0_g262493 = TVE_FlowBaseCoord;
					float2 lerpResult400_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g262493 = lerpResult400_g262441;
					float temp_output_136_0_g262491 = _GlobalFlowLayerValue;
					float temp_output_82_0_g262493 = temp_output_136_0_g262491;
					float4 tex2DArrayNode83_g262493 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262493).zw + ( (temp_output_203_0_g262493).xy * temp_output_81_0_g262493 ) ),temp_output_82_0_g262493), 0.0 );
					float4 appendResult210_g262493 = (float4(tex2DArrayNode83_g262493.rgb , saturate( tex2DArrayNode83_g262493.a )));
					float4 temp_output_204_0_g262493 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g262493 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262493).zw + ( (temp_output_204_0_g262493).xy * temp_output_81_0_g262493 ) ),temp_output_82_0_g262493), 0.0 );
					float4 appendResult212_g262493 = (float4(tex2DArrayNode122_g262493.rgb , saturate( tex2DArrayNode122_g262493.a )));
					float4 lerpResult131_g262493 = lerp( appendResult210_g262493 , appendResult212_g262493 , Global_TexBlend509_g262441);
					float4 temp_output_141_109_g262491 = lerpResult131_g262493;
					float4 lerpResult149_g262491 = lerp( TVE_FlowParams , temp_output_141_109_g262491 , TVE_FlowLayers[(int)temp_output_136_0_g262491]);
					half4 Flow_Texture405_g262441 = lerpResult149_g262491;
					float4 In_FlowTexture204_g262441 = Flow_Texture405_g262441;
					BuildGlobalData( Data204_g262441 , In_Dummy204_g262441 , In_CoatParams204_g262441 , In_CoatTexture204_g262441 , In_PaintParams204_g262441 , In_PaintTexture204_g262441 , In_AtmoParams204_g262441 , In_AtmoTexture204_g262441 , In_GlowParams204_g262441 , In_GlowTexture204_g262441 , In_FormParams204_g262441 , In_FormTexture204_g262441 , In_FlowParams204_g262441 , In_FlowTexture204_g262441 );
					TVEGlobalData Data15_g262530 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262530 = 0.0;
					float4 Out_CoatParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262530 = float4( 0,0,0,0 );
					BreakData( Data15_g262530 , Out_Dummy15_g262530 , Out_CoatParams15_g262530 , Out_CoatTexture15_g262530 , Out_PaintParams15_g262530 , Out_PaintTexture15_g262530 , Out_AtmoParams15_g262530 , Out_AtmoTexture15_g262530 , Out_GlowParams15_g262530 , Out_GlowTexture15_g262530 , Out_FormParams15_g262530 , Out_FormTexture15_g262530 , Out_FlowParams15_g262530 , Out_FlowTexture15_g262530 );
					float4 Global_FormTexture351_g262527 = Out_FormTexture15_g262530;
					float3 Model_PivotWO353_g262527 = temp_output_314_19_g262527;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g262536 = _ConformMeshMode;
					float Option70_g262536 = temp_output_17_0_g262536;
					half4 Model_VertexData357_g262527 = temp_output_314_29_g262527;
					float4 temp_output_3_0_g262536 = Model_VertexData357_g262527;
					float4 Channel70_g262536 = temp_output_3_0_g262536;
					float localSwitchChannel470_g262536 = SwitchChannel4( Option70_g262536 , Channel70_g262536 );
					float temp_output_390_0_g262527 = localSwitchChannel470_g262536;
					float temp_output_7_0_g262533 = _ConformMeshRemap.x;
					float temp_output_9_0_g262533 = ( temp_output_390_0_g262527 - temp_output_7_0_g262533 );
					float lerpResult374_g262527 = lerp( 1.0 , saturate( ( temp_output_9_0_g262533 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g262527 = lerpResult374_g262527;
					float temp_output_328_0_g262527 = ( Blend_VertMask379_g262527 * TVE_IsEnabled );
					half Conform_Mask366_g262527 = temp_output_328_0_g262527;
					float temp_output_322_0_g262527 = ( ( ( ( (Global_FormTexture351_g262527).z - ( (Model_PivotWO353_g262527).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g262527 ) );
					float3 appendResult329_g262527 = (float3(0.0 , temp_output_322_0_g262527 , 0.0));
					float3 appendResult387_g262527 = (float3(0.0 , 0.0 , temp_output_322_0_g262527));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262534 = appendResult387_g262527;
					#else
					float3 staticSwitch65_g262534 = appendResult329_g262527;
					#endif
					float3 Blanket_Conform368_g262527 = staticSwitch65_g262534;
					float4 appendResult312_g262527 = (float4(Blanket_Conform368_g262527 , 0.0));
					float4 temp_output_310_0_g262527 = ( Model_TransformData356_g262527 + appendResult312_g262527 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g262527 = temp_output_310_0_g262527;
					#else
					float4 staticSwitch364_g262527 = Model_TransformData356_g262527;
					#endif
					half4 Final_TransformData365_g262527 = staticSwitch364_g262527;
					float4 In_TransformData16_g262529 = Final_TransformData365_g262527;
					float4 In_RotationData16_g262529 = Out_RotationData15_g262528;
					float4 In_InterpolatorA16_g262529 = Out_InterpolatorA15_g262528;
					BuildModelVertData( Data16_g262529 , In_Dummy16_g262529 , In_PositionOS16_g262529 , In_PositionWS16_g262529 , In_PositionWO16_g262529 , In_PositionRawOS16_g262529 , In_PivotOS16_g262529 , In_PivotWS16_g262529 , In_PivotWO16_g262529 , In_NormalOS16_g262529 , In_NormalWS16_g262529 , In_NormalRawOS16_g262529 , In_TangentOS16_g262529 , In_TangentWS16_g262529 , In_BitangentWS16_g262529 , In_ViewDirWS16_g262529 , In_CoordsData16_g262529 , In_VertexData16_g262529 , In_MasksData16_g262529 , In_PhaseData16_g262529 , In_TransformData16_g262529 , In_RotationData16_g262529 , In_InterpolatorA16_g262529 );
					TVEModelData Data15_g262542 =(TVEModelData)Data16_g262529;
					float Out_Dummy15_g262542 = 0.0;
					float3 Out_PositionOS15_g262542 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262542 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262542 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262542 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262542 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262542 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262542 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262542 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262542 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262542 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262542 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262542 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262542 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262542 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262542 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262542 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262542 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262542 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262542 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262542 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262542 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262542 , Out_Dummy15_g262542 , Out_PositionOS15_g262542 , Out_PositionWS15_g262542 , Out_PositionWO15_g262542 , Out_PositionRawOS15_g262542 , Out_PivotOS15_g262542 , Out_PivotWS15_g262542 , Out_PivotWO15_g262542 , Out_NormalOS15_g262542 , Out_NormalWS15_g262542 , Out_NormalRawOS15_g262542 , Out_TangentOS15_g262542 , Out_TangentWS15_g262542 , Out_BitangentWS15_g262542 , Out_ViewDirWS15_g262542 , Out_CoordsData15_g262542 , Out_VertexData15_g262542 , Out_MasksData15_g262542 , Out_PhaseData15_g262542 , Out_TransformData15_g262542 , Out_RotationData15_g262542 , Out_InterpolatorA15_g262542 );
					TVEModelData Data16_g262543 =(TVEModelData)Data15_g262542;
					half Dummy181_g262537 = ( _RotationCategory + _RotationEnd + _RotationInfo );
					float temp_output_14_0_g262543 = Dummy181_g262537;
					float In_Dummy16_g262543 = temp_output_14_0_g262543;
					float3 temp_output_4_0_g262543 = Out_PositionOS15_g262542;
					float3 In_PositionOS16_g262543 = temp_output_4_0_g262543;
					float3 In_PositionWS16_g262543 = Out_PositionWS15_g262542;
					float3 In_PositionWO16_g262543 = Out_PositionWO15_g262542;
					float3 In_PositionRawOS16_g262543 = Out_PositionRawOS15_g262542;
					float3 In_PivotOS16_g262543 = Out_PivotOS15_g262542;
					float3 In_PivotWS16_g262543 = Out_PivotWS15_g262542;
					float3 In_PivotWO16_g262543 = Out_PivotWO15_g262542;
					float3 temp_output_21_0_g262543 = Out_NormalOS15_g262542;
					float3 In_NormalOS16_g262543 = temp_output_21_0_g262543;
					float3 In_NormalWS16_g262543 = Out_NormalWS15_g262542;
					float3 In_NormalRawOS16_g262543 = Out_NormalRawOS15_g262542;
					float4 temp_output_6_0_g262543 = Out_TangentOS15_g262542;
					float4 In_TangentOS16_g262543 = temp_output_6_0_g262543;
					float3 In_TangentWS16_g262543 = Out_TangentWS15_g262542;
					float3 In_BitangentWS16_g262543 = Out_BitangentWS15_g262542;
					float3 In_ViewDirWS16_g262543 = Out_ViewDirWS15_g262542;
					float4 In_CoordsData16_g262543 = Out_CoordsData15_g262542;
					float4 In_VertexData16_g262543 = Out_VertexData15_g262542;
					float4 In_MasksData16_g262543 = Out_MasksData15_g262542;
					float4 In_PhaseData16_g262543 = Out_PhaseData15_g262542;
					float4 In_TransformData16_g262543 = Out_TransformData15_g262542;
					half4 Model_RotationData212_g262537 = Out_RotationData15_g262542;
					TVEGlobalData Data15_g262538 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262538 = 0.0;
					float4 Out_CoatParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262538 = float4( 0,0,0,0 );
					BreakData( Data15_g262538 , Out_Dummy15_g262538 , Out_CoatParams15_g262538 , Out_CoatTexture15_g262538 , Out_PaintParams15_g262538 , Out_PaintTexture15_g262538 , Out_AtmoParams15_g262538 , Out_AtmoTexture15_g262538 , Out_GlowParams15_g262538 , Out_GlowTexture15_g262538 , Out_FormParams15_g262538 , Out_FormTexture15_g262538 , Out_FlowParams15_g262538 , Out_FlowTexture15_g262538 );
					half4 Global_FormTexture188_g262537 = Out_FormTexture15_g262538;
					float2 temp_output_38_0_g262539 = ((Global_FormTexture188_g262537).xy*2.0 + -1.0);
					float2 break83_g262539 = temp_output_38_0_g262539;
					float3 appendResult79_g262539 = (float3(break83_g262539.x , 0.0 , break83_g262539.y));
					float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
					float2 lerpResult227_g262537 = lerp( float2( 0,0 ) , (( mul( unity_WorldToObject, float4( appendResult79_g262539 , 0.0 ) ).xyz * ase_parentObjectScale )).xz , ( _RotationIntensityValue * TVE_IsEnabled ));
					half2 Blanket_Orientation192_g262537 = lerpResult227_g262537;
					float4 appendResult222_g262537 = (float4(( (Model_RotationData212_g262537).xy + Blanket_Orientation192_g262537 ) , (Model_RotationData212_g262537).zw));
					#ifdef TVE_ROTATION
					float4 staticSwitch218_g262537 = appendResult222_g262537;
					#else
					float4 staticSwitch218_g262537 = Model_RotationData212_g262537;
					#endif
					half4 Final_RotationData225_g262537 = staticSwitch218_g262537;
					float4 In_RotationData16_g262543 = Final_RotationData225_g262537;
					float4 In_InterpolatorA16_g262543 = Out_InterpolatorA15_g262542;
					BuildModelVertData( Data16_g262543 , In_Dummy16_g262543 , In_PositionOS16_g262543 , In_PositionWS16_g262543 , In_PositionWO16_g262543 , In_PositionRawOS16_g262543 , In_PivotOS16_g262543 , In_PivotWS16_g262543 , In_PivotWO16_g262543 , In_NormalOS16_g262543 , In_NormalWS16_g262543 , In_NormalRawOS16_g262543 , In_TangentOS16_g262543 , In_TangentWS16_g262543 , In_BitangentWS16_g262543 , In_ViewDirWS16_g262543 , In_CoordsData16_g262543 , In_VertexData16_g262543 , In_MasksData16_g262543 , In_PhaseData16_g262543 , In_TransformData16_g262543 , In_RotationData16_g262543 , In_InterpolatorA16_g262543 );
					TVEModelData Data15_g262545 =(TVEModelData)Data16_g262543;
					float Out_Dummy15_g262545 = 0.0;
					float3 Out_PositionOS15_g262545 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262545 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262545 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262545 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262545 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262545 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262545 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262545 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262545 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262545 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262545 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262545 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262545 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262545 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262545 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262545 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262545 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262545 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262545 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262545 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262545 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262545 , Out_Dummy15_g262545 , Out_PositionOS15_g262545 , Out_PositionWS15_g262545 , Out_PositionWO15_g262545 , Out_PositionRawOS15_g262545 , Out_PivotOS15_g262545 , Out_PivotWS15_g262545 , Out_PivotWO15_g262545 , Out_NormalOS15_g262545 , Out_NormalWS15_g262545 , Out_NormalRawOS15_g262545 , Out_TangentOS15_g262545 , Out_TangentWS15_g262545 , Out_BitangentWS15_g262545 , Out_ViewDirWS15_g262545 , Out_CoordsData15_g262545 , Out_VertexData15_g262545 , Out_MasksData15_g262545 , Out_PhaseData15_g262545 , Out_TransformData15_g262545 , Out_RotationData15_g262545 , Out_InterpolatorA15_g262545 );
					TVEModelData Data16_g262546 =(TVEModelData)Data15_g262545;
					half Dummy181_g262544 = ( _SizeFadeCategory + _SizeFadeEnd );
					float temp_output_14_0_g262546 = Dummy181_g262544;
					float In_Dummy16_g262546 = temp_output_14_0_g262546;
					float3 Model_PositionOS147_g262544 = Out_PositionOS15_g262545;
					float3 temp_cast_15 = (1.0).xxx;
					float3 temp_output_210_18_g262544 = Out_PivotWS15_g262545;
					float3 Model_PivotWS162_g262544 = temp_output_210_18_g262544;
					float lerpResult216_g262544 = lerp( 1.0 , TVE_SizeFadeParams.z , TVE_SizeFadeParams.w);
					float temp_output_7_0_g262548 = _SizeFadeDistMaxValue;
					float temp_output_9_0_g262548 = ( ( distance( _WorldSpaceCameraPos , Model_PivotWS162_g262544 ) * lerpResult216_g262544 ) - temp_output_7_0_g262548 );
					TVEGlobalData Data15_g262553 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262553 = 0.0;
					float4 Out_CoatParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262553 = float4( 0,0,0,0 );
					BreakData( Data15_g262553 , Out_Dummy15_g262553 , Out_CoatParams15_g262553 , Out_CoatTexture15_g262553 , Out_PaintParams15_g262553 , Out_PaintTexture15_g262553 , Out_AtmoParams15_g262553 , Out_AtmoTexture15_g262553 , Out_GlowParams15_g262553 , Out_GlowTexture15_g262553 , Out_FormParams15_g262553 , Out_FormTexture15_g262553 , Out_FlowParams15_g262553 , Out_FlowTexture15_g262553 );
					half4 Global_FormParams243_g262544 = Out_FormParams15_g262553;
					float temp_output_245_0_g262544 = (Global_FormParams243_g262544).w;
					half4 Global_FormTexture188_g262544 = Out_FormTexture15_g262553;
					float temp_output_6_0_g262552 = (Global_FormTexture188_g262544).w;
					float temp_output_7_0_g262552 = _SizeFadeElementMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g262552 = ( temp_output_6_0_g262552 + temp_output_7_0_g262552 );
					#else
					float staticSwitch14_g262552 = temp_output_6_0_g262552;
					#endif
					float temp_output_223_0_g262544 = staticSwitch14_g262552;
					#ifdef TVE_SIZEFADE_ELEMENT
					float staticSwitch194_g262544 = temp_output_223_0_g262544;
					#else
					float staticSwitch194_g262544 = temp_output_245_0_g262544;
					#endif
					float lerpResult213_g262544 = lerp( 1.0 , staticSwitch194_g262544 , ( _SizeFadeGlobalValue * TVE_IsEnabled ));
					half Blend_GlobalMask192_g262544 = lerpResult213_g262544;
					half Blend_UserMask232_g262544 = 1.0;
					float temp_output_236_0_g262544 = ( Blend_GlobalMask192_g262544 * Blend_UserMask232_g262544 );
					half Blend_Mask240_g262544 = temp_output_236_0_g262544;
					float temp_output_189_0_g262544 = ( saturate( ( temp_output_9_0_g262548 / ( ( _SizeFadeDistMinValue - temp_output_7_0_g262548 ) + 0.0001 ) ) ) * _SizeFadeScaleValue * Blend_Mask240_g262544 );
					float3 appendResult200_g262544 = (float3(temp_output_189_0_g262544 , temp_output_189_0_g262544 , temp_output_189_0_g262544));
					float3 appendResult201_g262544 = (float3(1.0 , temp_output_189_0_g262544 , 1.0));
					float3 appendResult230_g262544 = (float3(1.0 , 1.0 , temp_output_189_0_g262544));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262549 = appendResult230_g262544;
					#else
					float3 staticSwitch65_g262549 = appendResult201_g262544;
					#endif
					float3 lerpResult202_g262544 = lerp( appendResult200_g262544 , staticSwitch65_g262549 , _SizeFadeScaleMode);
					float3 lerpResult184_g262544 = lerp( temp_cast_15 , lerpResult202_g262544 , _SizeFadeIntensityValue);
					float3 temp_output_167_0_g262544 = ( lerpResult184_g262544 * Model_PositionOS147_g262544 );
					#ifdef TVE_SIZEFADE
					float3 staticSwitch199_g262544 = temp_output_167_0_g262544;
					#else
					float3 staticSwitch199_g262544 = Model_PositionOS147_g262544;
					#endif
					float3 Final_Position178_g262544 = staticSwitch199_g262544;
					float3 temp_output_4_0_g262546 = Final_Position178_g262544;
					float3 In_PositionOS16_g262546 = temp_output_4_0_g262546;
					float3 In_PositionWS16_g262546 = Out_PositionWS15_g262545;
					float3 In_PositionWO16_g262546 = Out_PositionWO15_g262545;
					float3 In_PositionRawOS16_g262546 = Out_PositionRawOS15_g262545;
					float3 temp_output_210_24_g262544 = Out_PivotOS15_g262545;
					float3 In_PivotOS16_g262546 = temp_output_210_24_g262544;
					float3 In_PivotWS16_g262546 = temp_output_210_18_g262544;
					float3 In_PivotWO16_g262546 = Out_PivotWO15_g262545;
					float3 temp_output_21_0_g262546 = Out_NormalOS15_g262545;
					float3 In_NormalOS16_g262546 = temp_output_21_0_g262546;
					float3 In_NormalWS16_g262546 = Out_NormalWS15_g262545;
					float3 In_NormalRawOS16_g262546 = Out_NormalRawOS15_g262545;
					float4 temp_output_6_0_g262546 = Out_TangentOS15_g262545;
					float4 In_TangentOS16_g262546 = temp_output_6_0_g262546;
					float3 In_TangentWS16_g262546 = Out_TangentWS15_g262545;
					float3 In_BitangentWS16_g262546 = Out_BitangentWS15_g262545;
					float3 In_ViewDirWS16_g262546 = Out_ViewDirWS15_g262545;
					float4 In_CoordsData16_g262546 = Out_CoordsData15_g262545;
					float4 In_VertexData16_g262546 = Out_VertexData15_g262545;
					float4 In_MasksData16_g262546 = Out_MasksData15_g262545;
					float4 In_PhaseData16_g262546 = Out_PhaseData15_g262545;
					float4 In_TransformData16_g262546 = Out_TransformData15_g262545;
					float4 In_RotationData16_g262546 = Out_RotationData15_g262545;
					float4 In_InterpolatorA16_g262546 = Out_InterpolatorA15_g262545;
					BuildModelVertData( Data16_g262546 , In_Dummy16_g262546 , In_PositionOS16_g262546 , In_PositionWS16_g262546 , In_PositionWO16_g262546 , In_PositionRawOS16_g262546 , In_PivotOS16_g262546 , In_PivotWS16_g262546 , In_PivotWO16_g262546 , In_NormalOS16_g262546 , In_NormalWS16_g262546 , In_NormalRawOS16_g262546 , In_TangentOS16_g262546 , In_TangentWS16_g262546 , In_BitangentWS16_g262546 , In_ViewDirWS16_g262546 , In_CoordsData16_g262546 , In_VertexData16_g262546 , In_MasksData16_g262546 , In_PhaseData16_g262546 , In_TransformData16_g262546 , In_RotationData16_g262546 , In_InterpolatorA16_g262546 );
					TVEModelData Data15_g262556 =(TVEModelData)Data16_g262546;
					float Out_Dummy15_g262556 = 0.0;
					float3 Out_PositionOS15_g262556 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262556 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262556 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262556 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262556 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262556 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262556 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262556 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262556 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262556 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262556 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262556 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262556 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262556 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262556 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262556 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262556 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262556 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262556 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262556 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262556 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262556 , Out_Dummy15_g262556 , Out_PositionOS15_g262556 , Out_PositionWS15_g262556 , Out_PositionWO15_g262556 , Out_PositionRawOS15_g262556 , Out_PivotOS15_g262556 , Out_PivotWS15_g262556 , Out_PivotWO15_g262556 , Out_NormalOS15_g262556 , Out_NormalWS15_g262556 , Out_NormalRawOS15_g262556 , Out_TangentOS15_g262556 , Out_TangentWS15_g262556 , Out_BitangentWS15_g262556 , Out_ViewDirWS15_g262556 , Out_CoordsData15_g262556 , Out_VertexData15_g262556 , Out_MasksData15_g262556 , Out_PhaseData15_g262556 , Out_TransformData15_g262556 , Out_RotationData15_g262556 , Out_InterpolatorA15_g262556 );
					TVEModelData Data16_g262555 =(TVEModelData)Data15_g262556;
					half Dummy181_g262554 = ( ( _MotionCategory + _MotionEnd ) + _MotionPushInfo );
					float temp_output_14_0_g262555 = Dummy181_g262554;
					float In_Dummy16_g262555 = temp_output_14_0_g262555;
					float3 temp_output_2772_0_g262554 = Out_PositionOS15_g262556;
					float3 temp_output_4_0_g262555 = temp_output_2772_0_g262554;
					float3 In_PositionOS16_g262555 = temp_output_4_0_g262555;
					float3 temp_output_2772_16_g262554 = Out_PositionWS15_g262556;
					float3 In_PositionWS16_g262555 = temp_output_2772_16_g262554;
					float3 temp_output_2772_17_g262554 = Out_PositionWO15_g262556;
					float3 In_PositionWO16_g262555 = temp_output_2772_17_g262554;
					float3 In_PositionRawOS16_g262555 = Out_PositionRawOS15_g262556;
					float3 temp_output_2772_24_g262554 = Out_PivotOS15_g262556;
					float3 In_PivotOS16_g262555 = temp_output_2772_24_g262554;
					float3 In_PivotWS16_g262555 = Out_PivotWS15_g262556;
					float3 temp_output_2772_19_g262554 = Out_PivotWO15_g262556;
					float3 In_PivotWO16_g262555 = temp_output_2772_19_g262554;
					float3 temp_output_2772_20_g262554 = Out_NormalOS15_g262556;
					float3 temp_output_21_0_g262555 = temp_output_2772_20_g262554;
					float3 In_NormalOS16_g262555 = temp_output_21_0_g262555;
					float3 In_NormalWS16_g262555 = Out_NormalWS15_g262556;
					float3 In_NormalRawOS16_g262555 = Out_NormalRawOS15_g262556;
					float4 temp_output_6_0_g262555 = Out_TangentOS15_g262556;
					float4 In_TangentOS16_g262555 = temp_output_6_0_g262555;
					float3 In_TangentWS16_g262555 = Out_TangentWS15_g262556;
					float3 In_BitangentWS16_g262555 = Out_BitangentWS15_g262556;
					float3 In_ViewDirWS16_g262555 = Out_ViewDirWS15_g262556;
					float4 In_CoordsData16_g262555 = Out_CoordsData15_g262556;
					float4 temp_output_2772_29_g262554 = Out_VertexData15_g262556;
					float4 In_VertexData16_g262555 = temp_output_2772_29_g262554;
					float4 temp_output_2772_30_g262554 = Out_MasksData15_g262556;
					float4 In_MasksData16_g262555 = temp_output_2772_30_g262554;
					float4 temp_output_2772_27_g262554 = Out_PhaseData15_g262556;
					float4 In_PhaseData16_g262555 = temp_output_2772_27_g262554;
					half4 Model_TransformData2743_g262554 = Out_TransformData15_g262556;
					float3 temp_cast_16 = (0.0).xxx;
					float2 lerpResult3113_g262554 = lerp( (half4( 0, 1, 0.5, 1 )).xy , (TVE_WindParams).xy , TVE_IsEnabled);
					float2 Global_WindDirWS2542_g262554 = lerpResult3113_g262554;
					half2 Input_WindDirWS803_g262605 = Global_WindDirWS2542_g262554;
					float3 Model_PositionWO162_g262554 = temp_output_2772_17_g262554;
					half3 Input_ModelPositionWO761_g262558 = Model_PositionWO162_g262554;
					float3 Model_PivotWO402_g262554 = temp_output_2772_19_g262554;
					half3 Input_ModelPivotsWO419_g262558 = Model_PivotWO402_g262554;
					half Input_MotionPivots629_g262558 = _MotionSmallPivotValue;
					float3 lerpResult771_g262558 = lerp( Input_ModelPositionWO761_g262558 , Input_ModelPivotsWO419_g262558 , Input_MotionPivots629_g262558);
					half4 Model_PhaseData489_g262554 = temp_output_2772_27_g262554;
					half4 Input_ModelMotionData763_g262558 = Model_PhaseData489_g262554;
					half Input_MotionPhase764_g262558 = _MotionSmallPhaseValue;
					float temp_output_770_0_g262558 = ( (Input_ModelMotionData763_g262558).x * Input_MotionPhase764_g262558 );
					half3 Small_Position1421_g262554 = ( lerpResult771_g262558 + temp_output_770_0_g262558 );
					half3 Input_PositionWO419_g262605 = Small_Position1421_g262554;
					half Input_MotionTilling321_g262605 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g262605 = ( -(Input_PositionWO419_g262605).xz * Input_MotionTilling321_g262605 * 0.005 );
					float2 temp_output_3_0_g262606 = Noise_Coord979_g262605;
					float2 temp_output_21_0_g262606 = Input_WindDirWS803_g262605;
					float mulTime113_g262609 = _Time.y * 0.02;
					float lerpResult128_g262609 = lerp( mulTime113_g262609 , ( ( mulTime113_g262609 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g262605 = _MotionSmallSpeedValue;
					half Noise_Speed980_g262605 = ( lerpResult128_g262609 * Input_MotionSpeed62_g262605 );
					float temp_output_15_0_g262606 = Noise_Speed980_g262605;
					float temp_output_23_0_g262606 = frac( temp_output_15_0_g262606 );
					float4 lerpResult39_g262606 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g262606 + ( temp_output_21_0_g262606 * temp_output_23_0_g262606 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g262606 + ( temp_output_21_0_g262606 * frac( ( temp_output_15_0_g262606 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g262606 - 0.5 ) ) / 0.5 ));
					float4 temp_output_991_0_g262605 = lerpResult39_g262606;
					half2 Noise_DirWS858_g262605 = ((temp_output_991_0_g262605).rg*2.0 + -1.0);
					half Input_MotionNoise552_g262605 = _MotionSmallNoiseValue;
					TVEGlobalData Data15_g262568 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262568 = 0.0;
					float4 Out_CoatParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262568 = float4( 0,0,0,0 );
					BreakData( Data15_g262568 , Out_Dummy15_g262568 , Out_CoatParams15_g262568 , Out_CoatTexture15_g262568 , Out_PaintParams15_g262568 , Out_PaintTexture15_g262568 , Out_AtmoParams15_g262568 , Out_AtmoTexture15_g262568 , Out_GlowParams15_g262568 , Out_GlowTexture15_g262568 , Out_FormParams15_g262568 , Out_FormTexture15_g262568 , Out_FlowParams15_g262568 , Out_FlowTexture15_g262568 );
					half4 Global_FlowParams3052_g262554 = Out_FlowParams15_g262568;
					half4 Global_FlowTexture2668_g262554 = Out_FlowTexture15_g262568;
					#ifdef TVE_MOTION_ELEMENT
					float4 staticSwitch3075_g262554 = Global_FlowTexture2668_g262554;
					#else
					float4 staticSwitch3075_g262554 = Global_FlowParams3052_g262554;
					#endif
					float4 temp_output_6_0_g262570 = staticSwitch3075_g262554;
					float temp_output_7_0_g262570 = _MotionElementMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g262570 = ( temp_output_6_0_g262570 + temp_output_7_0_g262570 );
					#else
					float4 staticSwitch14_g262570 = temp_output_6_0_g262570;
					#endif
					float4 lerpResult3121_g262554 = lerp( half4( 0, 0, 0, 1 ) , staticSwitch14_g262570 , TVE_IsEnabled);
					float temp_output_630_0_g262583 = saturate( (lerpResult3121_g262554).w );
					float lerpResult853_g262583 = lerp( temp_output_630_0_g262583 , saturate( (temp_output_630_0_g262583*TVE_WindEditor.x + TVE_WindEditor.y) ) , TVE_WindEditor.w);
					half Global_WindValue1855_g262554 = ( lerpResult853_g262583 * _MotionIntensityValue );
					half Input_WindValue881_g262605 = Global_WindValue1855_g262554;
					float temp_output_6_0_g262611 = Input_WindValue881_g262605;
					float lerpResult701_g262605 = lerp( 1.0 , Input_MotionNoise552_g262605 , ( temp_output_6_0_g262611 * temp_output_6_0_g262611 ));
					float2 lerpResult646_g262605 = lerp( Input_WindDirWS803_g262605 , Noise_DirWS858_g262605 , lerpResult701_g262605);
					half2 Small_DirWS817_g262605 = lerpResult646_g262605;
					float2 break823_g262605 = Small_DirWS817_g262605;
					half4 Noise_Params685_g262605 = temp_output_991_0_g262605;
					half Wind_Sinus820_g262605 = ( ((Noise_Params685_g262605).b*2.0 + -1.0) * 0.6 );
					float3 appendResult824_g262605 = (float3(break823_g262605.x , Wind_Sinus820_g262605 , break823_g262605.y));
					half3 Small_Dir918_g262605 = appendResult824_g262605;
					float temp_output_20_0_g262610 = ( 1.0 - Input_WindValue881_g262605 );
					float3 appendResult1006_g262605 = (float3(Input_WindValue881_g262605 , ( 1.0 - ( temp_output_20_0_g262610 * temp_output_20_0_g262610 ) ) , Input_WindValue881_g262605));
					half Input_MotionDelay753_g262605 = _MotionSmallDelayValue;
					float lerpResult756_g262605 = lerp( 1.0 , ( Input_WindValue881_g262605 * Input_WindValue881_g262605 ) , Input_MotionDelay753_g262605);
					half Wind_Delay815_g262605 = lerpResult756_g262605;
					half Input_MotionValue905_g262605 = _MotionSmallIntensityValue;
					float3 temp_output_883_0_g262605 = ( Small_Dir918_g262605 * appendResult1006_g262605 * Wind_Delay815_g262605 * Input_MotionValue905_g262605 );
					float2 break857_g262605 = Noise_DirWS858_g262605;
					float3 appendResult833_g262605 = (float3(break857_g262605.x , Wind_Sinus820_g262605 , break857_g262605.y));
					half3 Push_Dir919_g262605 = appendResult833_g262605;
					half Input_MotionReact924_g262605 = _MotionSmallPushValue;
					float2 temp_output_3126_0_g262554 = ((lerpResult3121_g262554).xy*2.0 + -1.0);
					half Global_PushAlpha1504_g262554 = length( temp_output_3126_0_g262554 );
					half Input_PushAlpha806_g262605 = Global_PushAlpha1504_g262554;
					half Global_PushNoise2675_g262554 = (lerpResult3121_g262554).z;
					half Input_PushNoise890_g262605 = Global_PushNoise2675_g262554;
					half Push_Mask914_g262605 = saturate( ( Input_PushAlpha806_g262605 * Input_PushNoise890_g262605 * Input_MotionReact924_g262605 ) );
					float3 lerpResult840_g262605 = lerp( temp_output_883_0_g262605 , ( Push_Dir919_g262605 * Input_MotionReact924_g262605 ) , Push_Mask914_g262605);
					#ifdef TVE_MOTION_ELEMENT
					float3 staticSwitch829_g262605 = lerpResult840_g262605;
					#else
					float3 staticSwitch829_g262605 = temp_output_883_0_g262605;
					#endif
					half3 Small_Squash1489_g262554 = ( mul( unity_WorldToObject, float4( staticSwitch829_g262605 , 0.0 ) ).xyz * ase_parentObjectScale );
					float temp_output_17_0_g262593 = _MotionSmallMaskMode;
					float Option83_g262593 = temp_output_17_0_g262593;
					half4 Model_VertexMasks518_g262554 = temp_output_2772_29_g262554;
					float4 ChannelA83_g262593 = Model_VertexMasks518_g262554;
					half4 Model_MasksData1322_g262554 = temp_output_2772_30_g262554;
					float2 uv_MotionMaskTex2818_g262554 = v.ase_texcoord.xy;
					half4 Motion_MaskTex2819_g262554 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g262554, 0.0 );
					float4 appendResult3227_g262554 = (float4((Model_MasksData1322_g262554).xy , (Motion_MaskTex2819_g262554).g , 0.0));
					float4 ChannelB83_g262593 = appendResult3227_g262554;
					float localSwitchChannel883_g262593 = SwitchChannel8( Option83_g262593 , ChannelA83_g262593 , ChannelB83_g262593 );
					float enc1805_g262554 = v.ase_texcoord.z;
					float2 localDecodeFloatToVector21805_g262554 = DecodeFloatToVector2( enc1805_g262554 );
					float2 break1804_g262554 = localDecodeFloatToVector21805_g262554;
					half Small_Mask_Legacy1806_g262554 = break1804_g262554.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g262554 = Small_Mask_Legacy1806_g262554;
					#else
					float staticSwitch1800_g262554 = localSwitchChannel883_g262593;
					#endif
					float clampResult17_g262559 = clamp( staticSwitch1800_g262554 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262560 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g262560 = ( clampResult17_g262559 - temp_output_7_0_g262560 );
					half Small_Mask640_g262554 = saturate( ( temp_output_9_0_g262560 * _MotionSmallMaskRemap.z ) );
					float3 lerpResult3022_g262554 = lerp( float3( 1,1,1 ) , (TVE_MotionValueParams).xyz , TVE_MotionValueParams.w);
					half3 Global_MotionParams3013_g262554 = lerpResult3022_g262554;
					half3 Small_Motion789_g262554 = ( Small_Squash1489_g262554 * Small_Mask640_g262554 * (Global_MotionParams3013_g262554).y );
					#ifdef TVE_MOTION
					float3 staticSwitch495_g262554 = Small_Motion789_g262554;
					#else
					float3 staticSwitch495_g262554 = temp_cast_16;
					#endif
					float3 temp_cast_19 = (0.0).xxx;
					float3 Model_PositionWS1819_g262554 = temp_output_2772_16_g262554;
					half Global_DistMask1820_g262554 = ( 1.0 - saturate( ( distance( _WorldSpaceCameraPos , Model_PositionWS1819_g262554 ) / _MotionDistValue ) ) );
					float temp_output_17_0_g262594 = _MotionTinyMaskMode;
					float Option83_g262594 = temp_output_17_0_g262594;
					float4 ChannelA83_g262594 = Model_VertexMasks518_g262554;
					float4 appendResult3234_g262554 = (float4((Model_MasksData1322_g262554).xy , (Motion_MaskTex2819_g262554).b , 0.0));
					float4 ChannelB83_g262594 = appendResult3234_g262554;
					float localSwitchChannel883_g262594 = SwitchChannel8( Option83_g262594 , ChannelA83_g262594 , ChannelB83_g262594 );
					half Tiny_Mask_Legacy1807_g262554 = break1804_g262554.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g262554 = Tiny_Mask_Legacy1807_g262554;
					#else
					float staticSwitch1810_g262554 = localSwitchChannel883_g262594;
					#endif
					float clampResult17_g262561 = clamp( staticSwitch1810_g262554 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262562 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g262562 = ( clampResult17_g262561 - temp_output_7_0_g262562 );
					half Tiny_Mask218_g262554 = saturate( ( temp_output_9_0_g262562 * _MotionTinyMaskRemap.z ) );
					half3 Model_NormalOS554_g262554 = temp_output_2772_20_g262554;
					half3 Input_NormalOS533_g262576 = Model_NormalOS554_g262554;
					half3 Tiny_Position2469_g262554 = Model_PositionWO162_g262554;
					half3 Input_PositionWO500_g262576 = Tiny_Position2469_g262554;
					half Input_MotionTilling321_g262576 = ( _MotionTinyTillingValue + 0.1 );
					float lerpResult128_g262581 = lerp( _Time.y , ( ( _Time.y * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g262576 = _MotionTinySpeedValue;
					float4 tex2DNode514_g262576 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( ( (Input_PositionWO500_g262576).xz * Input_MotionTilling321_g262576 * 0.005 ) + ( lerpResult128_g262581 * Input_MotionSpeed62_g262576 * 0.02 ) ), 0.0 );
					half3 Flutter_Noise535_g262576 = (tex2DNode514_g262576.rgb*2.0 + -1.0);
					half Input_MotionNoise542_g262576 = _MotionTinyNoiseValue;
					float3 lerpResult537_g262576 = lerp( ( Input_NormalOS533_g262576 * Flutter_Noise535_g262576 ) , Flutter_Noise535_g262576 , Input_MotionNoise542_g262576);
					float mulTime113_g262582 = _Time.y * 2.0;
					float lerpResult128_g262582 = lerp( mulTime113_g262582 , ( ( mulTime113_g262582 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					float temp_output_578_0_g262576 = SAMPLE_TEXTURE3D_LOD( _NoiseTex3D, sampler_Linear_Repeat, ( ( Input_PositionWO500_g262576 + lerpResult128_g262582 ) * ( 1.0 * 0.01 ) ), 0.0 ).r;
					half Input_GlobalWind471_g262576 = Global_WindValue1855_g262554;
					float lerpResult579_g262576 = lerp( ( temp_output_578_0_g262576 * temp_output_578_0_g262576 * temp_output_578_0_g262576 * temp_output_578_0_g262576 ) , temp_output_578_0_g262576 , ( Input_GlobalWind471_g262576 * Input_GlobalWind471_g262576 ));
					float temp_output_20_0_g262580 = ( 1.0 - Input_GlobalWind471_g262576 );
					half Wind_Gust589_g262576 = ( ( lerpResult579_g262576 * ( 1.0 - ( temp_output_20_0_g262580 * temp_output_20_0_g262580 * temp_output_20_0_g262580 * temp_output_20_0_g262580 ) ) ) * 0.5 );
					half3 Tiny_Squash859_g262554 = ( lerpResult537_g262576 * Wind_Gust589_g262576 );
					half3 Tiny_Flutter1451_g262554 = ( _MotionTinyIntensityValue * Global_DistMask1820_g262554 * Tiny_Mask218_g262554 * Tiny_Squash859_g262554 * (Global_MotionParams3013_g262554).z );
					#ifdef TVE_MOTION
					float3 staticSwitch414_g262554 = Tiny_Flutter1451_g262554;
					#else
					float3 staticSwitch414_g262554 = temp_cast_19;
					#endif
					float4 appendResult2783_g262554 = (float4(( staticSwitch495_g262554 + staticSwitch414_g262554 ) , 0.0));
					half4 Final_TransformData1569_g262554 = ( Model_TransformData2743_g262554 + appendResult2783_g262554 );
					float4 In_TransformData16_g262555 = Final_TransformData1569_g262554;
					half4 Model_RotationData2740_g262554 = Out_RotationData15_g262556;
					half2 Input_WindDirWS803_g262595 = Global_WindDirWS2542_g262554;
					half3 Input_ModelPositionWO761_g262557 = Model_PositionWO162_g262554;
					half3 Input_ModelPivotsWO419_g262557 = Model_PivotWO402_g262554;
					half Input_MotionPivots629_g262557 = _MotionBasePivotValue;
					float3 lerpResult771_g262557 = lerp( Input_ModelPositionWO761_g262557 , Input_ModelPivotsWO419_g262557 , Input_MotionPivots629_g262557);
					half4 Input_ModelMotionData763_g262557 = Model_PhaseData489_g262554;
					half Input_MotionPhase764_g262557 = _MotionBasePhaseValue;
					float temp_output_770_0_g262557 = ( (Input_ModelMotionData763_g262557).x * Input_MotionPhase764_g262557 );
					half3 Base_Position1394_g262554 = ( lerpResult771_g262557 + temp_output_770_0_g262557 );
					half3 Input_PositionWO419_g262595 = Base_Position1394_g262554;
					half Input_MotionTilling321_g262595 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g262595 = ( -(Input_PositionWO419_g262595).xz * Input_MotionTilling321_g262595 * 0.005 );
					float2 temp_output_3_0_g262602 = Noise_Coord515_g262595;
					float2 temp_output_21_0_g262602 = Input_WindDirWS803_g262595;
					float mulTime113_g262596 = _Time.y * 0.02;
					float lerpResult128_g262596 = lerp( mulTime113_g262596 , ( ( mulTime113_g262596 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g262595 = _MotionBaseSpeedValue;
					half Noise_Speed516_g262595 = ( lerpResult128_g262596 * Input_MotionSpeed62_g262595 );
					float temp_output_15_0_g262602 = Noise_Speed516_g262595;
					float temp_output_23_0_g262602 = frac( temp_output_15_0_g262602 );
					float4 lerpResult39_g262602 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g262602 + ( temp_output_21_0_g262602 * temp_output_23_0_g262602 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g262602 + ( temp_output_21_0_g262602 * frac( ( temp_output_15_0_g262602 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g262602 - 0.5 ) ) / 0.5 ));
					float4 temp_output_635_0_g262595 = lerpResult39_g262602;
					half2 Noise_DirWS825_g262595 = ((temp_output_635_0_g262595).rg*2.0 + -1.0);
					half Input_MotionNoise552_g262595 = _MotionBaseNoiseValue;
					half Input_WindValue853_g262595 = Global_WindValue1855_g262554;
					float temp_output_6_0_g262599 = Input_WindValue853_g262595;
					float lerpResult701_g262595 = lerp( 1.0 , Input_MotionNoise552_g262595 , ( temp_output_6_0_g262599 * temp_output_6_0_g262599 ));
					half Input_PushNoise858_g262595 = Global_PushNoise2675_g262554;
					float2 lerpResult646_g262595 = lerp( Input_WindDirWS803_g262595 , Noise_DirWS825_g262595 , saturate( ( lerpResult701_g262595 + Input_PushNoise858_g262595 ) ));
					half2 Bend_Dir859_g262595 = lerpResult646_g262595;
					half Input_MotionValue871_g262595 = _MotionBaseIntensityValue;
					half Input_MotionDelay753_g262595 = _MotionBaseDelayValue;
					float lerpResult756_g262595 = lerp( 1.0 , ( Input_WindValue853_g262595 * Input_WindValue853_g262595 ) , Input_MotionDelay753_g262595);
					half Wind_Delay815_g262595 = lerpResult756_g262595;
					float2 temp_output_875_0_g262595 = ( Bend_Dir859_g262595 * Input_WindValue853_g262595 * Input_MotionValue871_g262595 * Wind_Delay815_g262595 );
					float2 Global_PushDirWS1972_g262554 = temp_output_3126_0_g262554;
					half2 Input_PushDirWS807_g262595 = Global_PushDirWS1972_g262554;
					half Input_ReactValue888_g262595 = _MotionBasePushValue;
					half Input_PushAlpha806_g262595 = Global_PushAlpha1504_g262554;
					half Push_Mask883_g262595 = saturate( ( Input_PushAlpha806_g262595 * Input_ReactValue888_g262595 ) );
					float2 lerpResult811_g262595 = lerp( temp_output_875_0_g262595 , ( Input_PushDirWS807_g262595 * Input_ReactValue888_g262595 ) , Push_Mask883_g262595);
					#ifdef TVE_MOTION_ELEMENT
					float2 staticSwitch808_g262595 = lerpResult811_g262595;
					#else
					float2 staticSwitch808_g262595 = temp_output_875_0_g262595;
					#endif
					float2 temp_output_38_0_g262600 = staticSwitch808_g262595;
					float2 break83_g262600 = temp_output_38_0_g262600;
					float3 appendResult79_g262600 = (float3(break83_g262600.x , 0.0 , break83_g262600.y));
					half2 Base_Bending893_g262554 = (( mul( unity_WorldToObject, float4( appendResult79_g262600 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
					float temp_output_17_0_g262592 = _MotionBaseMaskMode;
					float Option83_g262592 = temp_output_17_0_g262592;
					float4 ChannelA83_g262592 = Model_VertexMasks518_g262554;
					float4 appendResult3220_g262554 = (float4((Model_MasksData1322_g262554).xy , (Motion_MaskTex2819_g262554).r , 0.0));
					float4 ChannelB83_g262592 = appendResult3220_g262554;
					float localSwitchChannel883_g262592 = SwitchChannel8( Option83_g262592 , ChannelA83_g262592 , ChannelB83_g262592 );
					float clampResult17_g262564 = clamp( localSwitchChannel883_g262592 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262563 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g262563 = ( clampResult17_g262564 - temp_output_7_0_g262563 );
					half Base_Mask217_g262554 = saturate( ( temp_output_9_0_g262563 * _MotionBaseMaskRemap.z ) );
					half2 Base_Motion1440_g262554 = ( Base_Bending893_g262554 * Base_Mask217_g262554 * (Global_MotionParams3013_g262554).x );
					#ifdef TVE_MOTION
					float2 staticSwitch2384_g262554 = Base_Motion1440_g262554;
					#else
					float2 staticSwitch2384_g262554 = float2( 0,0 );
					#endif
					float4 appendResult2023_g262554 = (float4(staticSwitch2384_g262554 , 0.0 , 0.0));
					half4 Final_RotationData1570_g262554 = ( Model_RotationData2740_g262554 + appendResult2023_g262554 );
					float4 In_RotationData16_g262555 = Final_RotationData1570_g262554;
					half4 Model_Interpolator02773_g262554 = Out_InterpolatorA15_g262556;
					half4 Noise_Params685_g262595 = temp_output_635_0_g262595;
					float temp_output_6_0_g262598 = (Noise_Params685_g262595).a;
					float temp_output_913_0_g262595 = ( ( temp_output_6_0_g262598 * temp_output_6_0_g262598 * temp_output_6_0_g262598 * temp_output_6_0_g262598 ) * ( Input_WindValue853_g262595 * Wind_Delay815_g262595 ) );
					float temp_output_6_0_g262597 = length( Input_PushDirWS807_g262595 );
					float lerpResult902_g262595 = lerp( temp_output_913_0_g262595 , ( ( temp_output_6_0_g262597 * temp_output_6_0_g262597 ) * Input_PushNoise858_g262595 ) , Push_Mask883_g262595);
					#ifdef TVE_MOTION_ELEMENT
					float staticSwitch903_g262595 = lerpResult902_g262595;
					#else
					float staticSwitch903_g262595 = temp_output_913_0_g262595;
					#endif
					half Base_Wave1159_g262554 = staticSwitch903_g262595;
					float temp_output_6_0_g262612 = (Noise_Params685_g262605).a;
					float temp_output_955_0_g262605 = ( temp_output_6_0_g262612 * temp_output_6_0_g262612 * temp_output_6_0_g262612 * temp_output_6_0_g262612 );
					float temp_output_944_0_g262605 = ( temp_output_955_0_g262605 * ( Input_WindValue881_g262605 * Wind_Delay815_g262605 ) );
					float lerpResult936_g262605 = lerp( temp_output_944_0_g262605 , ( temp_output_955_0_g262605 * Input_PushNoise890_g262605 ) , Push_Mask914_g262605);
					#ifdef TVE_MOTION_ELEMENT
					float staticSwitch939_g262605 = lerpResult936_g262605;
					#else
					float staticSwitch939_g262605 = temp_output_944_0_g262605;
					#endif
					half Small_Wave1427_g262554 = staticSwitch939_g262605;
					float lerpResult2422_g262554 = lerp( Base_Wave1159_g262554 , Small_Wave1427_g262554 , _motion_small_mode);
					half Global_Wave1475_g262554 = saturate( lerpResult2422_g262554 );
					float temp_output_6_0_g262565 = ( _MotionHighlightValue * Global_DistMask1820_g262554 * ( Tiny_Mask218_g262554 * Tiny_Mask218_g262554 ) * Global_Wave1475_g262554 );
					float temp_output_7_0_g262565 = _MotionHighlightColor.r;
					#ifdef TVE_DUMMY
					float staticSwitch14_g262565 = ( temp_output_6_0_g262565 + temp_output_7_0_g262565 );
					#else
					float staticSwitch14_g262565 = temp_output_6_0_g262565;
					#endif
					#ifdef TVE_MOTION
					float staticSwitch2866_g262554 = staticSwitch14_g262565;
					#else
					float staticSwitch2866_g262554 = 0.0;
					#endif
					float4 appendResult2775_g262554 = (float4((Model_Interpolator02773_g262554).xyz , staticSwitch2866_g262554));
					half4 Final_Interpolator02774_g262554 = appendResult2775_g262554;
					float4 In_InterpolatorA16_g262555 = Final_Interpolator02774_g262554;
					BuildModelVertData( Data16_g262555 , In_Dummy16_g262555 , In_PositionOS16_g262555 , In_PositionWS16_g262555 , In_PositionWO16_g262555 , In_PositionRawOS16_g262555 , In_PivotOS16_g262555 , In_PivotWS16_g262555 , In_PivotWO16_g262555 , In_NormalOS16_g262555 , In_NormalWS16_g262555 , In_NormalRawOS16_g262555 , In_TangentOS16_g262555 , In_TangentWS16_g262555 , In_BitangentWS16_g262555 , In_ViewDirWS16_g262555 , In_CoordsData16_g262555 , In_VertexData16_g262555 , In_MasksData16_g262555 , In_PhaseData16_g262555 , In_TransformData16_g262555 , In_RotationData16_g262555 , In_InterpolatorA16_g262555 );
					TVEModelData Data15_g262614 =(TVEModelData)Data16_g262555;
					float Out_Dummy15_g262614 = 0.0;
					float3 Out_PositionOS15_g262614 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262614 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262614 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262614 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262614 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262614 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262614 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262614 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262614 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262614 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262614 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262614 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262614 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262614 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262614 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262614 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262614 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262614 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262614 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262614 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262614 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262614 , Out_Dummy15_g262614 , Out_PositionOS15_g262614 , Out_PositionWS15_g262614 , Out_PositionWO15_g262614 , Out_PositionRawOS15_g262614 , Out_PivotOS15_g262614 , Out_PivotWS15_g262614 , Out_PivotWO15_g262614 , Out_NormalOS15_g262614 , Out_NormalWS15_g262614 , Out_NormalRawOS15_g262614 , Out_TangentOS15_g262614 , Out_TangentWS15_g262614 , Out_BitangentWS15_g262614 , Out_ViewDirWS15_g262614 , Out_CoordsData15_g262614 , Out_VertexData15_g262614 , Out_MasksData15_g262614 , Out_PhaseData15_g262614 , Out_TransformData15_g262614 , Out_RotationData15_g262614 , Out_InterpolatorA15_g262614 );
					TVEModelData Data16_g262615 =(TVEModelData)Data15_g262614;
					float temp_output_14_0_g262615 = 0.0;
					float In_Dummy16_g262615 = temp_output_14_0_g262615;
					float3 Model_PositionOS147_g262613 = Out_PositionOS15_g262614;
					half3 VertexPos40_g262619 = Model_PositionOS147_g262613;
					float4 temp_output_1567_33_g262613 = Out_RotationData15_g262614;
					half4 Model_RotationData1569_g262613 = temp_output_1567_33_g262613;
					float2 break1582_g262613 = (Model_RotationData1569_g262613).xy;
					half Angle44_g262619 = break1582_g262613.y;
					half CosAngle89_g262619 = cos( Angle44_g262619 );
					half SinAngle93_g262619 = sin( Angle44_g262619 );
					float3 appendResult95_g262619 = (float3((VertexPos40_g262619).x , ( ( (VertexPos40_g262619).y * CosAngle89_g262619 ) - ( (VertexPos40_g262619).z * SinAngle93_g262619 ) ) , ( ( (VertexPos40_g262619).y * SinAngle93_g262619 ) + ( (VertexPos40_g262619).z * CosAngle89_g262619 ) )));
					half3 VertexPos40_g262620 = appendResult95_g262619;
					half Angle44_g262620 = -break1582_g262613.x;
					half CosAngle94_g262620 = cos( Angle44_g262620 );
					half SinAngle95_g262620 = sin( Angle44_g262620 );
					float3 appendResult98_g262620 = (float3(( ( (VertexPos40_g262620).x * CosAngle94_g262620 ) - ( (VertexPos40_g262620).y * SinAngle95_g262620 ) ) , ( ( (VertexPos40_g262620).x * SinAngle95_g262620 ) + ( (VertexPos40_g262620).y * CosAngle94_g262620 ) ) , (VertexPos40_g262620).z));
					half3 VertexPos40_g262618 = Model_PositionOS147_g262613;
					half Angle44_g262618 = break1582_g262613.y;
					half CosAngle89_g262618 = cos( Angle44_g262618 );
					half SinAngle93_g262618 = sin( Angle44_g262618 );
					float3 appendResult95_g262618 = (float3((VertexPos40_g262618).x , ( ( (VertexPos40_g262618).y * CosAngle89_g262618 ) - ( (VertexPos40_g262618).z * SinAngle93_g262618 ) ) , ( ( (VertexPos40_g262618).y * SinAngle93_g262618 ) + ( (VertexPos40_g262618).z * CosAngle89_g262618 ) )));
					half3 VertexPos40_g262623 = appendResult95_g262618;
					half Angle44_g262623 = break1582_g262613.x;
					half CosAngle91_g262623 = cos( Angle44_g262623 );
					half SinAngle92_g262623 = sin( Angle44_g262623 );
					float3 appendResult93_g262623 = (float3(( ( (VertexPos40_g262623).x * CosAngle91_g262623 ) + ( (VertexPos40_g262623).z * SinAngle92_g262623 ) ) , (VertexPos40_g262623).y , ( ( -(VertexPos40_g262623).x * SinAngle92_g262623 ) + ( (VertexPos40_g262623).z * CosAngle91_g262623 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262621 = appendResult93_g262623;
					#else
					float3 staticSwitch65_g262621 = appendResult98_g262620;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g262616 = staticSwitch65_g262621;
					#else
					float3 staticSwitch65_g262616 = Model_PositionOS147_g262613;
					#endif
					float3 temp_output_1608_0_g262613 = staticSwitch65_g262616;
					half3 VertexPos40_g262622 = temp_output_1608_0_g262613;
					half Angle44_g262622 = (Model_RotationData1569_g262613).z;
					half CosAngle91_g262622 = cos( Angle44_g262622 );
					half SinAngle92_g262622 = sin( Angle44_g262622 );
					float3 appendResult93_g262622 = (float3(( ( (VertexPos40_g262622).x * CosAngle91_g262622 ) + ( (VertexPos40_g262622).z * SinAngle92_g262622 ) ) , (VertexPos40_g262622).y , ( ( -(VertexPos40_g262622).x * SinAngle92_g262622 ) + ( (VertexPos40_g262622).z * CosAngle91_g262622 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g262617 = appendResult93_g262622;
					#else
					float3 staticSwitch65_g262617 = temp_output_1608_0_g262613;
					#endif
					float4 temp_output_1567_31_g262613 = Out_TransformData15_g262614;
					half4 Model_TransformData1568_g262613 = temp_output_1567_31_g262613;
					half3 Final_PositionOS178_g262613 = ( ( staticSwitch65_g262617 * (Model_TransformData1568_g262613).w ) + (Model_TransformData1568_g262613).xyz );
					float3 temp_output_4_0_g262615 = Final_PositionOS178_g262613;
					float3 In_PositionOS16_g262615 = temp_output_4_0_g262615;
					float3 In_PositionWS16_g262615 = Out_PositionWS15_g262614;
					float3 In_PositionWO16_g262615 = Out_PositionWO15_g262614;
					float3 In_PositionRawOS16_g262615 = Out_PositionRawOS15_g262614;
					float3 In_PivotOS16_g262615 = Out_PivotOS15_g262614;
					float3 In_PivotWS16_g262615 = Out_PivotWS15_g262614;
					float3 In_PivotWO16_g262615 = Out_PivotWO15_g262614;
					float3 temp_output_21_0_g262615 = Out_NormalOS15_g262614;
					float3 In_NormalOS16_g262615 = temp_output_21_0_g262615;
					float3 In_NormalWS16_g262615 = Out_NormalWS15_g262614;
					float3 In_NormalRawOS16_g262615 = Out_NormalRawOS15_g262614;
					float4 temp_output_6_0_g262615 = Out_TangentOS15_g262614;
					float4 In_TangentOS16_g262615 = temp_output_6_0_g262615;
					float3 In_TangentWS16_g262615 = Out_TangentWS15_g262614;
					float3 In_BitangentWS16_g262615 = Out_BitangentWS15_g262614;
					float3 In_ViewDirWS16_g262615 = Out_ViewDirWS15_g262614;
					float4 In_CoordsData16_g262615 = Out_CoordsData15_g262614;
					float4 In_VertexData16_g262615 = Out_VertexData15_g262614;
					float4 In_MasksData16_g262615 = Out_MasksData15_g262614;
					float4 In_PhaseData16_g262615 = Out_PhaseData15_g262614;
					float4 In_TransformData16_g262615 = temp_output_1567_31_g262613;
					float4 In_RotationData16_g262615 = temp_output_1567_33_g262613;
					float4 In_InterpolatorA16_g262615 = Out_InterpolatorA15_g262614;
					BuildModelVertData( Data16_g262615 , In_Dummy16_g262615 , In_PositionOS16_g262615 , In_PositionWS16_g262615 , In_PositionWO16_g262615 , In_PositionRawOS16_g262615 , In_PivotOS16_g262615 , In_PivotWS16_g262615 , In_PivotWO16_g262615 , In_NormalOS16_g262615 , In_NormalWS16_g262615 , In_NormalRawOS16_g262615 , In_TangentOS16_g262615 , In_TangentWS16_g262615 , In_BitangentWS16_g262615 , In_ViewDirWS16_g262615 , In_CoordsData16_g262615 , In_VertexData16_g262615 , In_MasksData16_g262615 , In_PhaseData16_g262615 , In_TransformData16_g262615 , In_RotationData16_g262615 , In_InterpolatorA16_g262615 );
					TVEModelData Data15_g262625 =(TVEModelData)Data16_g262615;
					float Out_Dummy15_g262625 = 0.0;
					float3 Out_PositionOS15_g262625 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262625 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262625 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262625 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262625 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262625 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262625 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262625 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262625 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262625 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262625 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262625 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262625 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262625 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262625 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262625 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262625 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262625 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262625 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262625 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262625 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262625 , Out_Dummy15_g262625 , Out_PositionOS15_g262625 , Out_PositionWS15_g262625 , Out_PositionWO15_g262625 , Out_PositionRawOS15_g262625 , Out_PivotOS15_g262625 , Out_PivotWS15_g262625 , Out_PivotWO15_g262625 , Out_NormalOS15_g262625 , Out_NormalWS15_g262625 , Out_NormalRawOS15_g262625 , Out_TangentOS15_g262625 , Out_TangentWS15_g262625 , Out_BitangentWS15_g262625 , Out_ViewDirWS15_g262625 , Out_CoordsData15_g262625 , Out_VertexData15_g262625 , Out_MasksData15_g262625 , Out_PhaseData15_g262625 , Out_TransformData15_g262625 , Out_RotationData15_g262625 , Out_InterpolatorA15_g262625 );
					TVEModelData Data16_g262627 =(TVEModelData)Data15_g262625;
					half Dummy1823_g262624 = ( _FlattenCategory + _FlattenEnd + _FlattenBakeMode );
					float temp_output_14_0_g262627 = Dummy1823_g262624;
					float In_Dummy16_g262627 = temp_output_14_0_g262627;
					float3 temp_output_4_0_g262627 = Out_PositionOS15_g262625;
					float3 In_PositionOS16_g262627 = temp_output_4_0_g262627;
					float3 In_PositionWS16_g262627 = Out_PositionWS15_g262625;
					float3 In_PositionWO16_g262627 = Out_PositionWO15_g262625;
					float3 temp_output_1810_26_g262624 = Out_PositionRawOS15_g262625;
					float3 In_PositionRawOS16_g262627 = temp_output_1810_26_g262624;
					float3 In_PivotOS16_g262627 = Out_PivotOS15_g262625;
					float3 In_PivotWS16_g262627 = Out_PivotWS15_g262625;
					float3 In_PivotWO16_g262627 = Out_PivotWO15_g262625;
					half3 Model_NormalOS1829_g262624 = Out_NormalOS15_g262625;
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262626 = half3( 0, 0, 1 );
					#else
					float3 staticSwitch65_g262626 = half3( 0, 1, 0 );
					#endif
					float3 lerpResult1820_g262624 = lerp( Model_NormalOS1829_g262624 , staticSwitch65_g262626 , _FlattenIntensityValue);
					float3 Model_PositionBaseOS1837_g262624 = temp_output_1810_26_g262624;
					float3 normalizeResult1816_g262624 = ASESafeNormalize( ( Model_PositionBaseOS1837_g262624 + _FlattenSphereOffsetValue ) );
					float3 lerpResult1813_g262624 = lerp( lerpResult1820_g262624 , normalizeResult1816_g262624 , _FlattenSphereValue);
					float temp_output_17_0_g262634 = _FlattenMeshMode;
					float Option70_g262634 = temp_output_17_0_g262634;
					float4 temp_output_1810_29_g262624 = Out_VertexData15_g262625;
					half4 Model_VertexData1826_g262624 = temp_output_1810_29_g262624;
					float4 temp_output_3_0_g262634 = Model_VertexData1826_g262624;
					float4 Channel70_g262634 = temp_output_3_0_g262634;
					float localSwitchChannel470_g262634 = SwitchChannel4( Option70_g262634 , Channel70_g262634 );
					float clampResult17_g262628 = clamp( localSwitchChannel470_g262634 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262629 = _FlattenMeshRemap.x;
					float temp_output_9_0_g262629 = ( clampResult17_g262628 - temp_output_7_0_g262629 );
					float lerpResult1841_g262624 = lerp( 1.0 , saturate( ( temp_output_9_0_g262629 * _FlattenMeshRemap.z ) ) , _FlattenMeshValue);
					half Normal_MeskMask1847_g262624 = lerpResult1841_g262624;
					half Normal_Mask1851_g262624 = Normal_MeskMask1847_g262624;
					float3 lerpResult1856_g262624 = lerp( Model_NormalOS1829_g262624 , lerpResult1813_g262624 , Normal_Mask1851_g262624);
					#ifdef TVE_FLATTEN
					float3 staticSwitch1857_g262624 = lerpResult1856_g262624;
					#else
					float3 staticSwitch1857_g262624 = Model_NormalOS1829_g262624;
					#endif
					half3 Final_NormalOS1853_g262624 = staticSwitch1857_g262624;
					float3 temp_output_21_0_g262627 = Final_NormalOS1853_g262624;
					float3 In_NormalOS16_g262627 = temp_output_21_0_g262627;
					float3 In_NormalWS16_g262627 = Out_NormalWS15_g262625;
					float3 In_NormalRawOS16_g262627 = Out_NormalRawOS15_g262625;
					float4 temp_output_6_0_g262627 = Out_TangentOS15_g262625;
					float4 In_TangentOS16_g262627 = temp_output_6_0_g262627;
					float3 In_TangentWS16_g262627 = Out_TangentWS15_g262625;
					float3 In_BitangentWS16_g262627 = Out_BitangentWS15_g262625;
					float3 In_ViewDirWS16_g262627 = Out_ViewDirWS15_g262625;
					float4 In_CoordsData16_g262627 = Out_CoordsData15_g262625;
					float4 In_VertexData16_g262627 = temp_output_1810_29_g262624;
					float4 In_MasksData16_g262627 = Out_MasksData15_g262625;
					float4 In_PhaseData16_g262627 = Out_PhaseData15_g262625;
					float4 In_TransformData16_g262627 = Out_TransformData15_g262625;
					float4 In_RotationData16_g262627 = Out_RotationData15_g262625;
					float4 In_InterpolatorA16_g262627 = Out_InterpolatorA15_g262625;
					BuildModelVertData( Data16_g262627 , In_Dummy16_g262627 , In_PositionOS16_g262627 , In_PositionWS16_g262627 , In_PositionWO16_g262627 , In_PositionRawOS16_g262627 , In_PivotOS16_g262627 , In_PivotWS16_g262627 , In_PivotWO16_g262627 , In_NormalOS16_g262627 , In_NormalWS16_g262627 , In_NormalRawOS16_g262627 , In_TangentOS16_g262627 , In_TangentWS16_g262627 , In_BitangentWS16_g262627 , In_ViewDirWS16_g262627 , In_CoordsData16_g262627 , In_VertexData16_g262627 , In_MasksData16_g262627 , In_PhaseData16_g262627 , In_TransformData16_g262627 , In_RotationData16_g262627 , In_InterpolatorA16_g262627 );
					TVEModelData Data15_g262641 =(TVEModelData)Data16_g262627;
					float Out_Dummy15_g262641 = 0.0;
					float3 Out_PositionOS15_g262641 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262641 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262641 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262641 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262641 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262641 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262641 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262641 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262641 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262641 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262641 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262641 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262641 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262641 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262641 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262641 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262641 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262641 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262641 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262641 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262641 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262641 , Out_Dummy15_g262641 , Out_PositionOS15_g262641 , Out_PositionWS15_g262641 , Out_PositionWO15_g262641 , Out_PositionRawOS15_g262641 , Out_PivotOS15_g262641 , Out_PivotWS15_g262641 , Out_PivotWO15_g262641 , Out_NormalOS15_g262641 , Out_NormalWS15_g262641 , Out_NormalRawOS15_g262641 , Out_TangentOS15_g262641 , Out_TangentWS15_g262641 , Out_BitangentWS15_g262641 , Out_ViewDirWS15_g262641 , Out_CoordsData15_g262641 , Out_VertexData15_g262641 , Out_MasksData15_g262641 , Out_PhaseData15_g262641 , Out_TransformData15_g262641 , Out_RotationData15_g262641 , Out_InterpolatorA15_g262641 );
					TVEModelData Data16_g262636 =(TVEModelData)Data15_g262641;
					half Dummy1575_g262635 = ( _ReshadeCategory + _ReshadeEnd );
					float temp_output_14_0_g262636 = Dummy1575_g262635;
					float In_Dummy16_g262636 = temp_output_14_0_g262636;
					float3 temp_output_4_0_g262636 = Out_PositionOS15_g262641;
					float3 In_PositionOS16_g262636 = temp_output_4_0_g262636;
					float3 In_PositionWS16_g262636 = Out_PositionWS15_g262641;
					float3 In_PositionWO16_g262636 = Out_PositionWO15_g262641;
					float3 In_PositionRawOS16_g262636 = Out_PositionRawOS15_g262641;
					float3 In_PivotOS16_g262636 = Out_PivotOS15_g262641;
					float3 In_PivotWS16_g262636 = Out_PivotWS15_g262641;
					float3 In_PivotWO16_g262636 = Out_PivotWO15_g262641;
					half3 Model_NormalOS1568_g262635 = Out_NormalOS15_g262641;
					half3 VertexPos40_g262638 = Model_NormalOS1568_g262635;
					half3 VertexPos40_g262639 = VertexPos40_g262638;
					float4 temp_output_1567_33_g262635 = Out_RotationData15_g262641;
					half4 Model_RotationData1583_g262635 = temp_output_1567_33_g262635;
					half2 Angle44_g262638 = Model_RotationData1583_g262635.xy;
					half Angle44_g262639 = (Angle44_g262638).y;
					half CosAngle89_g262639 = cos( Angle44_g262639 );
					half SinAngle93_g262639 = sin( Angle44_g262639 );
					float3 appendResult95_g262639 = (float3((VertexPos40_g262639).x , ( ( (VertexPos40_g262639).y * CosAngle89_g262639 ) - ( (VertexPos40_g262639).z * SinAngle93_g262639 ) ) , ( ( (VertexPos40_g262639).y * SinAngle93_g262639 ) + ( (VertexPos40_g262639).z * CosAngle89_g262639 ) )));
					half3 VertexPos40_g262640 = appendResult95_g262639;
					half Angle44_g262640 = -(Angle44_g262638).x;
					half CosAngle94_g262640 = cos( Angle44_g262640 );
					half SinAngle95_g262640 = sin( Angle44_g262640 );
					float3 appendResult98_g262640 = (float3(( ( (VertexPos40_g262640).x * CosAngle94_g262640 ) - ( (VertexPos40_g262640).y * SinAngle95_g262640 ) ) , ( ( (VertexPos40_g262640).x * SinAngle95_g262640 ) + ( (VertexPos40_g262640).y * CosAngle94_g262640 ) ) , (VertexPos40_g262640).z));
					float3 lerpResult1591_g262635 = lerp( Model_NormalOS1568_g262635 , appendResult98_g262640 , _ReshadeIntensityValue);
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g262637 = lerpResult1591_g262635;
					#else
					float3 staticSwitch65_g262637 = Model_NormalOS1568_g262635;
					#endif
					float3 temp_output_1732_0_g262635 = staticSwitch65_g262637;
					#ifdef TVE_RESHADE
					float3 staticSwitch1716_g262635 = temp_output_1732_0_g262635;
					#else
					float3 staticSwitch1716_g262635 = Model_NormalOS1568_g262635;
					#endif
					half3 Final_NormalOS178_g262635 = staticSwitch1716_g262635;
					float3 temp_output_21_0_g262636 = Final_NormalOS178_g262635;
					float3 In_NormalOS16_g262636 = temp_output_21_0_g262636;
					float3 In_NormalWS16_g262636 = Out_NormalWS15_g262641;
					float3 In_NormalRawOS16_g262636 = Out_NormalRawOS15_g262641;
					float4 temp_output_6_0_g262636 = Out_TangentOS15_g262641;
					float4 In_TangentOS16_g262636 = temp_output_6_0_g262636;
					float3 In_TangentWS16_g262636 = Out_TangentWS15_g262641;
					float3 In_BitangentWS16_g262636 = Out_BitangentWS15_g262641;
					float3 In_ViewDirWS16_g262636 = Out_ViewDirWS15_g262641;
					float4 In_CoordsData16_g262636 = Out_CoordsData15_g262641;
					float4 In_VertexData16_g262636 = Out_VertexData15_g262641;
					float4 In_MasksData16_g262636 = Out_MasksData15_g262641;
					float4 In_PhaseData16_g262636 = Out_PhaseData15_g262641;
					float4 In_TransformData16_g262636 = Out_TransformData15_g262641;
					float4 In_RotationData16_g262636 = temp_output_1567_33_g262635;
					float4 In_InterpolatorA16_g262636 = Out_InterpolatorA15_g262641;
					BuildModelVertData( Data16_g262636 , In_Dummy16_g262636 , In_PositionOS16_g262636 , In_PositionWS16_g262636 , In_PositionWO16_g262636 , In_PositionRawOS16_g262636 , In_PivotOS16_g262636 , In_PivotWS16_g262636 , In_PivotWO16_g262636 , In_NormalOS16_g262636 , In_NormalWS16_g262636 , In_NormalRawOS16_g262636 , In_TangentOS16_g262636 , In_TangentWS16_g262636 , In_BitangentWS16_g262636 , In_ViewDirWS16_g262636 , In_CoordsData16_g262636 , In_VertexData16_g262636 , In_MasksData16_g262636 , In_PhaseData16_g262636 , In_TransformData16_g262636 , In_RotationData16_g262636 , In_InterpolatorA16_g262636 );
					TVEModelData Data15_g262654 =(TVEModelData)Data16_g262636;
					float Out_Dummy15_g262654 = 0.0;
					float3 Out_PositionOS15_g262654 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262654 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262654 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262654 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262654 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262654 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262654 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262654 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262654 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262654 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262654 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262654 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262654 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262654 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262654 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262654 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262654 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262654 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262654 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262654 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262654 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262654 , Out_Dummy15_g262654 , Out_PositionOS15_g262654 , Out_PositionWS15_g262654 , Out_PositionWO15_g262654 , Out_PositionRawOS15_g262654 , Out_PivotOS15_g262654 , Out_PivotWS15_g262654 , Out_PivotWO15_g262654 , Out_NormalOS15_g262654 , Out_NormalWS15_g262654 , Out_NormalRawOS15_g262654 , Out_TangentOS15_g262654 , Out_TangentWS15_g262654 , Out_BitangentWS15_g262654 , Out_ViewDirWS15_g262654 , Out_CoordsData15_g262654 , Out_VertexData15_g262654 , Out_MasksData15_g262654 , Out_PhaseData15_g262654 , Out_TransformData15_g262654 , Out_RotationData15_g262654 , Out_InterpolatorA15_g262654 );
					TVEModelData Data16_g262655 =(TVEModelData)Data15_g262654;
					half Dummy1575_g262645 = ( _TransferCategory + _TransferEnd + _TransferSpace );
					float temp_output_14_0_g262655 = Dummy1575_g262645;
					float In_Dummy16_g262655 = temp_output_14_0_g262655;
					float3 temp_output_4_0_g262655 = Out_PositionOS15_g262654;
					float3 In_PositionOS16_g262655 = temp_output_4_0_g262655;
					float3 In_PositionWS16_g262655 = Out_PositionWS15_g262654;
					float3 temp_output_1567_17_g262645 = Out_PositionWO15_g262654;
					float3 In_PositionWO16_g262655 = temp_output_1567_17_g262645;
					float3 temp_output_1567_26_g262645 = Out_PositionRawOS15_g262654;
					float3 In_PositionRawOS16_g262655 = temp_output_1567_26_g262645;
					float3 In_PivotOS16_g262655 = Out_PivotOS15_g262654;
					float3 In_PivotWS16_g262655 = Out_PivotWS15_g262654;
					float3 In_PivotWO16_g262655 = Out_PivotWO15_g262654;
					half3 Model_NormalOS1568_g262645 = Out_NormalOS15_g262654;
					TVEGlobalData Data15_g262660 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262660 = 0.0;
					float4 Out_CoatParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262660 = float4( 0,0,0,0 );
					BreakData( Data15_g262660 , Out_Dummy15_g262660 , Out_CoatParams15_g262660 , Out_CoatTexture15_g262660 , Out_PaintParams15_g262660 , Out_PaintTexture15_g262660 , Out_AtmoParams15_g262660 , Out_AtmoTexture15_g262660 , Out_GlowParams15_g262660 , Out_GlowTexture15_g262660 , Out_FormParams15_g262660 , Out_FormTexture15_g262660 , Out_FlowParams15_g262660 , Out_FlowTexture15_g262660 );
					half4 Global_FormTexture1633_g262645 = Out_FormTexture15_g262660;
					float2 temp_output_1627_0_g262645 = ((Global_FormTexture1633_g262645).xy*2.0 + -1.0);
					float2 break1617_g262645 = temp_output_1627_0_g262645;
					float dotResult1619_g262645 = dot( temp_output_1627_0_g262645 , temp_output_1627_0_g262645 );
					float3 appendResult1618_g262645 = (float3(break1617_g262645.x , sqrt( ( 1.0 - saturate( dotResult1619_g262645 ) ) ) , break1617_g262645.y));
					float3 worldToObjDir1623_g262645 = mul( unity_WorldToObject, float4( appendResult1618_g262645, 0.0 ) ).xyz;
					half3 Conform_Normal1630_g262645 = worldToObjDir1623_g262645;
					float temp_output_6_0_g262646 = ( _TransferIntensityValue * TVE_IsEnabled );
					float temp_output_7_0_g262646 = ( _TransferPerPixelMode + _TransferInfo );
					#ifdef TVE_DUMMY
					float staticSwitch14_g262646 = ( temp_output_6_0_g262646 + temp_output_7_0_g262646 );
					#else
					float staticSwitch14_g262646 = temp_output_6_0_g262646;
					#endif
					half Conform_Value1742_g262645 = staticSwitch14_g262646;
					float3 temp_output_1567_21_g262645 = Out_NormalWS15_g262654;
					half3 Model_NormalWS1639_g262645 = temp_output_1567_21_g262645;
					float temp_output_1646_0_g262645 = (Model_NormalWS1639_g262645).y;
					float temp_output_7_0_g262649 = _TransferProjRemap.x;
					float temp_output_9_0_g262649 = ( saturate( temp_output_1646_0_g262645 ) - temp_output_7_0_g262649 );
					float lerpResult1669_g262645 = lerp( 1.0 , saturate( ( temp_output_9_0_g262649 * _TransferProjRemap.z ) ) , _TransferProjValue);
					half Normal_Proj_Mask1647_g262645 = lerpResult1669_g262645;
					float temp_output_17_0_g262653 = _TransferMeshMode;
					float Option70_g262653 = temp_output_17_0_g262653;
					float4 temp_output_1567_29_g262645 = Out_VertexData15_g262654;
					half4 Model_VertexData1608_g262645 = temp_output_1567_29_g262645;
					float4 temp_output_3_0_g262653 = Model_VertexData1608_g262645;
					float4 Channel70_g262653 = temp_output_3_0_g262653;
					float localSwitchChannel470_g262653 = SwitchChannel4( Option70_g262653 , Channel70_g262653 );
					float temp_output_1857_0_g262645 = localSwitchChannel470_g262653;
					float temp_output_7_0_g262651 = _TransferMeshRemap.x;
					float temp_output_9_0_g262651 = ( temp_output_1857_0_g262645 - temp_output_7_0_g262651 );
					float lerpResult1820_g262645 = lerp( 1.0 , saturate( ( temp_output_9_0_g262651 * _TransferMeshRemap.z ) ) , _TransferMeshValue);
					half Blend_VertMask1825_g262645 = lerpResult1820_g262645;
					float3 Model_PositionWO1640_g262645 = temp_output_1567_17_g262645;
					float temp_output_64_0_g262652 = saturate( ( ( (Global_FormTexture1633_g262645).z - (Model_PositionWO1640_g262645).y ) + _TransferFormOffsetValue ) );
					float temp_output_66_0_g262652 = _TransferFormValue;
					float lerpResult71_g262652 = lerp( 1.0 , temp_output_64_0_g262652 , ( temp_output_66_0_g262652 * _TransferFormMode ));
					half Normal_FormMask_Mul1708_g262645 = lerpResult71_g262652;
					half Normal_FormMask_Add1629_g262645 = ( temp_output_64_0_g262652 * temp_output_66_0_g262652 );
					half Normal_Mask1748_g262645 = saturate( ( ( Conform_Value1742_g262645 * Normal_Proj_Mask1647_g262645 * Blend_VertMask1825_g262645 * Normal_FormMask_Mul1708_g262645 ) + Normal_FormMask_Add1629_g262645 ) );
					float3 lerpResult1670_g262645 = lerp( Model_NormalOS1568_g262645 , Conform_Normal1630_g262645 , Normal_Mask1748_g262645);
					#ifdef TVE_TRANSFER
					float3 staticSwitch1716_g262645 = lerpResult1670_g262645;
					#else
					float3 staticSwitch1716_g262645 = Model_NormalOS1568_g262645;
					#endif
					half3 Final_NormalOS178_g262645 = staticSwitch1716_g262645;
					float3 temp_output_21_0_g262655 = Final_NormalOS178_g262645;
					float3 In_NormalOS16_g262655 = temp_output_21_0_g262655;
					float3 In_NormalWS16_g262655 = temp_output_1567_21_g262645;
					float3 In_NormalRawOS16_g262655 = Out_NormalRawOS15_g262654;
					half4 Model_TangentOS1749_g262645 = Out_TangentOS15_g262654;
					float4 appendResult1746_g262645 = (float4(cross( worldToObjDir1623_g262645 , float3( 0, 0, 1 ) ) , -1.0));
					half4 Conform_Tangent1747_g262645 = appendResult1746_g262645;
					float4 lerpResult1757_g262645 = lerp( Model_TangentOS1749_g262645 , Conform_Tangent1747_g262645 , Normal_Mask1748_g262645);
					#ifdef TVE_TRANSFER
					float4 staticSwitch1760_g262645 = lerpResult1757_g262645;
					#else
					float4 staticSwitch1760_g262645 = Model_TangentOS1749_g262645;
					#endif
					half4 Final_TangentOS1762_g262645 = staticSwitch1760_g262645;
					float4 temp_output_6_0_g262655 = Final_TangentOS1762_g262645;
					float4 In_TangentOS16_g262655 = temp_output_6_0_g262655;
					float3 In_TangentWS16_g262655 = Out_TangentWS15_g262654;
					float3 In_BitangentWS16_g262655 = Out_BitangentWS15_g262654;
					float3 In_ViewDirWS16_g262655 = Out_ViewDirWS15_g262654;
					float4 In_CoordsData16_g262655 = Out_CoordsData15_g262654;
					float4 In_VertexData16_g262655 = temp_output_1567_29_g262645;
					float4 In_MasksData16_g262655 = Out_MasksData15_g262654;
					float4 In_PhaseData16_g262655 = Out_PhaseData15_g262654;
					float4 In_TransformData16_g262655 = Out_TransformData15_g262654;
					float4 temp_output_1567_33_g262645 = Out_RotationData15_g262654;
					float4 In_RotationData16_g262655 = temp_output_1567_33_g262645;
					half4 Model_Interpolator01775_g262645 = Out_InterpolatorA15_g262654;
					float4 break1777_g262645 = Model_Interpolator01775_g262645;
					float4 appendResult1778_g262645 = (float4(break1777_g262645.x , break1777_g262645.y , Normal_Mask1748_g262645 , break1777_g262645.w));
					#ifdef TVE_TRANSFER
					float4 staticSwitch1779_g262645 = appendResult1778_g262645;
					#else
					float4 staticSwitch1779_g262645 = Model_Interpolator01775_g262645;
					#endif
					half4 Final_Interpolator01780_g262645 = staticSwitch1779_g262645;
					float4 In_InterpolatorA16_g262655 = Final_Interpolator01780_g262645;
					BuildModelVertData( Data16_g262655 , In_Dummy16_g262655 , In_PositionOS16_g262655 , In_PositionWS16_g262655 , In_PositionWO16_g262655 , In_PositionRawOS16_g262655 , In_PivotOS16_g262655 , In_PivotWS16_g262655 , In_PivotWO16_g262655 , In_NormalOS16_g262655 , In_NormalWS16_g262655 , In_NormalRawOS16_g262655 , In_TangentOS16_g262655 , In_TangentWS16_g262655 , In_BitangentWS16_g262655 , In_ViewDirWS16_g262655 , In_CoordsData16_g262655 , In_VertexData16_g262655 , In_MasksData16_g262655 , In_PhaseData16_g262655 , In_TransformData16_g262655 , In_RotationData16_g262655 , In_InterpolatorA16_g262655 );
					TVEModelData Data15_g262662 =(TVEModelData)Data16_g262655;
					float Out_Dummy15_g262662 = 0.0;
					float3 Out_PositionOS15_g262662 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262662 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262662 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262662 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262662 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262662 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262662 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262662 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262662 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262662 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262662 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262662 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262662 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262662 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262662 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262662 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262662 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262662 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262662 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262662 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262662 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262662 , Out_Dummy15_g262662 , Out_PositionOS15_g262662 , Out_PositionWS15_g262662 , Out_PositionWO15_g262662 , Out_PositionRawOS15_g262662 , Out_PivotOS15_g262662 , Out_PivotWS15_g262662 , Out_PivotWO15_g262662 , Out_NormalOS15_g262662 , Out_NormalWS15_g262662 , Out_NormalRawOS15_g262662 , Out_TangentOS15_g262662 , Out_TangentWS15_g262662 , Out_BitangentWS15_g262662 , Out_ViewDirWS15_g262662 , Out_CoordsData15_g262662 , Out_VertexData15_g262662 , Out_MasksData15_g262662 , Out_PhaseData15_g262662 , Out_TransformData15_g262662 , Out_RotationData15_g262662 , Out_InterpolatorA15_g262662 );
					TVEModelData Data16_g262663 =(TVEModelData)Data15_g262662;
					float temp_output_14_0_g262663 = 0.0;
					float In_Dummy16_g262663 = temp_output_14_0_g262663;
					float3 temp_output_217_24_g262661 = Out_PivotOS15_g262662;
					float3 temp_output_216_0_g262661 = ( Out_PositionOS15_g262662 + temp_output_217_24_g262661 );
					float3 temp_output_4_0_g262663 = temp_output_216_0_g262661;
					float3 In_PositionOS16_g262663 = temp_output_4_0_g262663;
					float3 In_PositionWS16_g262663 = Out_PositionWS15_g262662;
					float3 In_PositionWO16_g262663 = Out_PositionWO15_g262662;
					float3 In_PositionRawOS16_g262663 = Out_PositionRawOS15_g262662;
					float3 In_PivotOS16_g262663 = temp_output_217_24_g262661;
					float3 In_PivotWS16_g262663 = Out_PivotWS15_g262662;
					float3 In_PivotWO16_g262663 = Out_PivotWO15_g262662;
					float3 temp_output_21_0_g262663 = Out_NormalOS15_g262662;
					float3 In_NormalOS16_g262663 = temp_output_21_0_g262663;
					float3 In_NormalWS16_g262663 = Out_NormalWS15_g262662;
					float3 In_NormalRawOS16_g262663 = Out_NormalRawOS15_g262662;
					float4 temp_output_6_0_g262663 = Out_TangentOS15_g262662;
					float4 In_TangentOS16_g262663 = temp_output_6_0_g262663;
					float3 In_TangentWS16_g262663 = Out_TangentWS15_g262662;
					float3 In_BitangentWS16_g262663 = Out_BitangentWS15_g262662;
					float3 In_ViewDirWS16_g262663 = Out_ViewDirWS15_g262662;
					float4 In_CoordsData16_g262663 = Out_CoordsData15_g262662;
					float4 In_VertexData16_g262663 = Out_VertexData15_g262662;
					float4 In_MasksData16_g262663 = Out_MasksData15_g262662;
					float4 In_PhaseData16_g262663 = Out_PhaseData15_g262662;
					float4 In_TransformData16_g262663 = Out_TransformData15_g262662;
					float4 In_RotationData16_g262663 = Out_RotationData15_g262662;
					float4 In_InterpolatorA16_g262663 = Out_InterpolatorA15_g262662;
					BuildModelVertData( Data16_g262663 , In_Dummy16_g262663 , In_PositionOS16_g262663 , In_PositionWS16_g262663 , In_PositionWO16_g262663 , In_PositionRawOS16_g262663 , In_PivotOS16_g262663 , In_PivotWS16_g262663 , In_PivotWO16_g262663 , In_NormalOS16_g262663 , In_NormalWS16_g262663 , In_NormalRawOS16_g262663 , In_TangentOS16_g262663 , In_TangentWS16_g262663 , In_BitangentWS16_g262663 , In_ViewDirWS16_g262663 , In_CoordsData16_g262663 , In_VertexData16_g262663 , In_MasksData16_g262663 , In_PhaseData16_g262663 , In_TransformData16_g262663 , In_RotationData16_g262663 , In_InterpolatorA16_g262663 );
					TVEModelData Data15_g262710 =(TVEModelData)Data16_g262663;
					float Out_Dummy15_g262710 = 0.0;
					float3 Out_PositionOS15_g262710 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262710 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262710 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262710 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262710 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262710 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262710 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262710 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262710 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262710 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262710 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262710 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262710 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262710 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262710 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262710 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262710 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262710 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262710 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262710 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262710 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262710 , Out_Dummy15_g262710 , Out_PositionOS15_g262710 , Out_PositionWS15_g262710 , Out_PositionWO15_g262710 , Out_PositionRawOS15_g262710 , Out_PivotOS15_g262710 , Out_PivotWS15_g262710 , Out_PivotWO15_g262710 , Out_NormalOS15_g262710 , Out_NormalWS15_g262710 , Out_NormalRawOS15_g262710 , Out_TangentOS15_g262710 , Out_TangentWS15_g262710 , Out_BitangentWS15_g262710 , Out_ViewDirWS15_g262710 , Out_CoordsData15_g262710 , Out_VertexData15_g262710 , Out_MasksData15_g262710 , Out_PhaseData15_g262710 , Out_TransformData15_g262710 , Out_RotationData15_g262710 , Out_InterpolatorA15_g262710 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g262710;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g262710;
					v.tangent = Out_TangentOS15_g262710;

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
				#pragma shader_feature_local_vertex TVE_PERSPECTIVE
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_vertex TVE_ROTATION
				#pragma shader_feature_local_vertex TVE_SIZEFADE
				#pragma shader_feature_local_vertex TVE_SIZEFADE_ELEMENT
				#pragma shader_feature_local_vertex TVE_MOTION
				#pragma shader_feature_local_vertex TVE_MOTION_ELEMENT
				#pragma shader_feature_local TVE_LEGACY
				#pragma shader_feature_local_vertex TVE_FLATTEN
				#pragma shader_feature_local_vertex TVE_RESHADE
				#pragma shader_feature_local_vertex TVE_TRANSFER
				#if defined (TVE_CONFORM_ROTATION) //Conform Rotation
					#define TVE_ROTATION_BEND //Conform Rotation
				#endif //Conform Rotation
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
				uniform half _PerspectiveCategory;
				uniform half _PerspectiveEnd;
				uniform half _PerspectivePhaseValue;
				uniform half _PerspectiveIntensityValue;
				uniform half _PerspectiveAngleValue;
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
				uniform half _RotationCategory;
				uniform half _RotationEnd;
				uniform half _RotationInfo;
				uniform half _RotationIntensityValue;
				uniform half _SizeFadeCategory;
				uniform half _SizeFadeEnd;
				uniform half4 TVE_SizeFadeParams;
				uniform float _SizeFadeDistMaxValue;
				uniform float _SizeFadeDistMinValue;
				uniform half _SizeFadeScaleValue;
				uniform half _SizeFadeElementMode;
				uniform half _SizeFadeGlobalValue;
				uniform half _SizeFadeScaleMode;
				uniform half _SizeFadeIntensityValue;
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
				uniform half _FlattenCategory;
				uniform half _FlattenEnd;
				uniform half _FlattenBakeMode;
				uniform half _FlattenIntensityValue;
				uniform half3 _FlattenSphereOffsetValue;
				uniform half _FlattenSphereValue;
				uniform half _FlattenMeshMode;
				uniform half4 _FlattenMeshRemap;
				uniform half _FlattenMeshValue;
				uniform half _ReshadeCategory;
				uniform half _ReshadeEnd;
				uniform half _ReshadeIntensityValue;
				uniform half _TransferCategory;
				uniform half _TransferEnd;
				uniform half _TransferSpace;
				uniform half _TransferIntensityValue;
				uniform half _TransferPerPixelMode;
				uniform half _TransferInfo;
				uniform half4 _TransferProjRemap;
				uniform half _TransferProjValue;
				uniform half _TransferMeshMode;
				uniform half4 _TransferMeshRemap;
				uniform half _TransferMeshValue;
				uniform half _TransferFormOffsetValue;
				uniform half _TransferFormValue;
				uniform half _TransferFormMode;


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
				
				float3 ASESafeNormalize(float3 inVec)
				{
					float dp3 = max(1.175494351e-38, dot(inVec, inVec));
					return inVec* rsqrt(dp3);
				}
				

				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float localIfModelDataByShader26_g262440 = ( 0.0 );
					TVEModelData Data26_g262440 = (TVEModelData)0;
					TVEModelData Data16_g262431 =(TVEModelData)0;
					half Dummy207_g262421 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
					float temp_output_14_0_g262431 = Dummy207_g262421;
					float In_Dummy16_g262431 = temp_output_14_0_g262431;
					float3 PositionOS131_g262421 = v.vertex.xyz;
					float3 temp_output_4_0_g262431 = PositionOS131_g262421;
					float3 In_PositionOS16_g262431 = temp_output_4_0_g262431;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g262421 = ase_positionWS;
					float3 vertexToFrag73_g262421 = temp_output_104_7_g262421;
					float3 PositionWS122_g262421 = vertexToFrag73_g262421;
					float3 In_PositionWS16_g262431 = PositionWS122_g262421;
					float4x4 break19_g262424 = unity_ObjectToWorld;
					float3 appendResult20_g262424 = (float3(break19_g262424[ 0 ][ 3 ] , break19_g262424[ 1 ][ 3 ] , break19_g262424[ 2 ][ 3 ]));
					float3 temp_output_340_7_g262421 = appendResult20_g262424;
					float4x4 break19_g262426 = unity_ObjectToWorld;
					float3 appendResult20_g262426 = (float3(break19_g262426[ 0 ][ 3 ] , break19_g262426[ 1 ][ 3 ] , break19_g262426[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g262422 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g262421 = PositionOS131_g262421;
					float3 appendResult234_g262421 = (float3(break233_g262421.x , 0.0 , break233_g262421.z));
					float3 break413_g262421 = PositionOS131_g262421;
					float3 appendResult414_g262421 = (float3(break413_g262421.x , break413_g262421.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262428 = appendResult414_g262421;
					#else
					float3 staticSwitch65_g262428 = appendResult234_g262421;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g262421 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g262421 = appendResult60_g262422;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g262421 = staticSwitch65_g262428;
					#else
					float3 staticSwitch229_g262421 = _Vector0;
					#endif
					float3 PivotOS149_g262421 = staticSwitch229_g262421;
					float3 temp_output_122_0_g262426 = PivotOS149_g262421;
					float3 PivotsOnlyWS105_g262426 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g262426 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g262421 = ( appendResult20_g262426 + PivotsOnlyWS105_g262426 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g262421 = temp_output_340_7_g262421;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g262421 = temp_output_341_7_g262421;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g262421 = temp_output_341_7_g262421;
					#else
					float3 staticSwitch236_g262421 = temp_output_340_7_g262421;
					#endif
					float3 vertexToFrag76_g262421 = staticSwitch236_g262421;
					float3 PivotWS121_g262421 = vertexToFrag76_g262421;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g262421 = ( PositionWS122_g262421 - PivotWS121_g262421 );
					#else
					float3 staticSwitch204_g262421 = PositionWS122_g262421;
					#endif
					float3 PositionWO132_g262421 = ( staticSwitch204_g262421 - TVE_WorldOrigin );
					float3 In_PositionWO16_g262431 = PositionWO132_g262421;
					float3 In_PositionRawOS16_g262431 = PositionOS131_g262421;
					float3 In_PivotOS16_g262431 = PivotOS149_g262421;
					float3 In_PivotWS16_g262431 = PivotWS121_g262421;
					float3 PivotWO133_g262421 = ( PivotWS121_g262421 - TVE_WorldOrigin );
					float3 In_PivotWO16_g262431 = PivotWO133_g262421;
					half3 NormalOS134_g262421 = v.normal;
					float3 temp_output_21_0_g262431 = NormalOS134_g262421;
					float3 In_NormalOS16_g262431 = temp_output_21_0_g262431;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g262421 = normalizedWorldNormal;
					float3 In_NormalWS16_g262431 = NormalWS95_g262421;
					float3 In_NormalRawOS16_g262431 = NormalOS134_g262421;
					half4 TangentlOS153_g262421 = v.tangent;
					float4 temp_output_6_0_g262431 = TangentlOS153_g262421;
					float4 In_TangentOS16_g262431 = temp_output_6_0_g262431;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g262421 = ase_tangentWS;
					float3 In_TangentWS16_g262431 = TangentWS136_g262421;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g262421 = ase_bitangentWS;
					float3 In_BitangentWS16_g262431 = BiangentWS421_g262421;
					float3 normalizeResult296_g262421 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g262421 ) );
					half3 ViewDirWS169_g262421 = normalizeResult296_g262421;
					float3 In_ViewDirWS16_g262431 = ViewDirWS169_g262421;
					float4 appendResult397_g262421 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g262421 = appendResult397_g262421;
					float4 In_CoordsData16_g262431 = CoordsData398_g262421;
					half4 VertexMasks171_g262421 = v.ase_color;
					float4 In_VertexData16_g262431 = VertexMasks171_g262421;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g262434 = (PositionOS131_g262421).z;
					#else
					float staticSwitch65_g262434 = (PositionOS131_g262421).y;
					#endif
					half Object_HeightValue267_g262421 = _ObjectHeightValue;
					half Bounds_HeightMask274_g262421 = saturate( ( staticSwitch65_g262434 / Object_HeightValue267_g262421 ) );
					half3 Position387_g262421 = PositionOS131_g262421;
					half Height387_g262421 = Object_HeightValue267_g262421;
					half Object_RadiusValue268_g262421 = _ObjectRadiusValue;
					half Radius387_g262421 = Object_RadiusValue268_g262421;
					half localCapsuleMaskYUp387_g262421 = CapsuleMaskYUp( Position387_g262421 , Height387_g262421 , Radius387_g262421 );
					half3 Position408_g262421 = PositionOS131_g262421;
					half Height408_g262421 = Object_HeightValue267_g262421;
					half Radius408_g262421 = Object_RadiusValue268_g262421;
					half localCapsuleMaskZUp408_g262421 = CapsuleMaskZUp( Position408_g262421 , Height408_g262421 , Radius408_g262421 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g262439 = saturate( localCapsuleMaskZUp408_g262421 );
					#else
					float staticSwitch65_g262439 = saturate( localCapsuleMaskYUp387_g262421 );
					#endif
					half Bounds_SphereMask282_g262421 = staticSwitch65_g262439;
					float4 appendResult253_g262421 = (float4(Bounds_HeightMask274_g262421 , Bounds_SphereMask282_g262421 , 1.0 , 1.0));
					half4 MasksData254_g262421 = appendResult253_g262421;
					float4 In_MasksData16_g262431 = MasksData254_g262421;
					float temp_output_17_0_g262433 = _ObjectPhaseMode;
					float Option70_g262433 = temp_output_17_0_g262433;
					float4 temp_output_3_0_g262433 = v.ase_color;
					float4 Channel70_g262433 = temp_output_3_0_g262433;
					float localSwitchChannel470_g262433 = SwitchChannel4( Option70_g262433 , Channel70_g262433 );
					half Phase_Value372_g262421 = localSwitchChannel470_g262433;
					float3 break319_g262421 = PivotWO133_g262421;
					half Pivot_Position322_g262421 = ( break319_g262421.x + break319_g262421.z );
					half Phase_Position357_g262421 = ( Phase_Value372_g262421 + Pivot_Position322_g262421 );
					float temp_output_248_0_g262421 = frac( Phase_Position357_g262421 );
					float4 appendResult177_g262421 = (float4(( (frac( ( Phase_Position357_g262421 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g262421));
					half4 Phase_Data176_g262421 = appendResult177_g262421;
					float4 In_PhaseData16_g262431 = Phase_Data176_g262421;
					float4 In_TransformData16_g262431 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g262431 = float4( 0,0,0,0 );
					float4 In_InterpolatorA16_g262431 = float4( 0,0,0,0 );
					BuildModelVertData( Data16_g262431 , In_Dummy16_g262431 , In_PositionOS16_g262431 , In_PositionWS16_g262431 , In_PositionWO16_g262431 , In_PositionRawOS16_g262431 , In_PivotOS16_g262431 , In_PivotWS16_g262431 , In_PivotWO16_g262431 , In_NormalOS16_g262431 , In_NormalWS16_g262431 , In_NormalRawOS16_g262431 , In_TangentOS16_g262431 , In_TangentWS16_g262431 , In_BitangentWS16_g262431 , In_ViewDirWS16_g262431 , In_CoordsData16_g262431 , In_VertexData16_g262431 , In_MasksData16_g262431 , In_PhaseData16_g262431 , In_TransformData16_g262431 , In_RotationData16_g262431 , In_InterpolatorA16_g262431 );
					TVEModelData DataDefault26_g262440 = Data16_g262431;
					TVEModelData DataGeneral26_g262440 = Data16_g262431;
					TVEModelData DataBlanket26_g262440 = Data16_g262431;
					TVEModelData DataImpostor26_g262440 = Data16_g262431;
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
					TVEModelData DataTerrain26_g262440 = Data16_g241828;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g262440 = IsShaderType2637;
					{
					if (Type26_g262440 == 0 )
					{
					Data26_g262440 = DataDefault26_g262440;
					}
					else if (Type26_g262440 == 1 )
					{
					Data26_g262440 = DataGeneral26_g262440;
					}
					else if (Type26_g262440 == 2 )
					{
					Data26_g262440 = DataBlanket26_g262440;
					}
					else if (Type26_g262440 == 3 )
					{
					Data26_g262440 = DataImpostor26_g262440;
					}
					else if (Type26_g262440 == 4 )
					{
					Data26_g262440 = DataTerrain26_g262440;
					}
					}
					TVEModelData Data15_g262519 =(TVEModelData)Data26_g262440;
					float Out_Dummy15_g262519 = 0.0;
					float3 Out_PositionOS15_g262519 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262519 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262519 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262519 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262519 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262519 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262519 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262519 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262519 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262519 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262519 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262519 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262519 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262519 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262519 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262519 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262519 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262519 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262519 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262519 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262519 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262519 , Out_Dummy15_g262519 , Out_PositionOS15_g262519 , Out_PositionWS15_g262519 , Out_PositionWO15_g262519 , Out_PositionRawOS15_g262519 , Out_PivotOS15_g262519 , Out_PivotWS15_g262519 , Out_PivotWO15_g262519 , Out_NormalOS15_g262519 , Out_NormalWS15_g262519 , Out_NormalRawOS15_g262519 , Out_TangentOS15_g262519 , Out_TangentWS15_g262519 , Out_BitangentWS15_g262519 , Out_ViewDirWS15_g262519 , Out_CoordsData15_g262519 , Out_VertexData15_g262519 , Out_MasksData15_g262519 , Out_PhaseData15_g262519 , Out_TransformData15_g262519 , Out_RotationData15_g262519 , Out_InterpolatorA15_g262519 );
					TVEModelData Data16_g262521 =(TVEModelData)Data15_g262519;
					float temp_output_14_0_g262521 = 0.0;
					float In_Dummy16_g262521 = temp_output_14_0_g262521;
					float3 temp_output_219_24_g262518 = Out_PivotOS15_g262519;
					float3 temp_output_215_0_g262518 = ( Out_PositionOS15_g262519 - temp_output_219_24_g262518 );
					float3 temp_output_4_0_g262521 = temp_output_215_0_g262518;
					float3 In_PositionOS16_g262521 = temp_output_4_0_g262521;
					float3 In_PositionWS16_g262521 = Out_PositionWS15_g262519;
					float3 In_PositionWO16_g262521 = Out_PositionWO15_g262519;
					float3 In_PositionRawOS16_g262521 = Out_PositionRawOS15_g262519;
					float3 In_PivotOS16_g262521 = temp_output_219_24_g262518;
					float3 In_PivotWS16_g262521 = Out_PivotWS15_g262519;
					float3 In_PivotWO16_g262521 = Out_PivotWO15_g262519;
					float3 temp_output_21_0_g262521 = Out_NormalOS15_g262519;
					float3 In_NormalOS16_g262521 = temp_output_21_0_g262521;
					float3 In_NormalWS16_g262521 = Out_NormalWS15_g262519;
					float3 In_NormalRawOS16_g262521 = Out_NormalRawOS15_g262519;
					float4 temp_output_6_0_g262521 = Out_TangentOS15_g262519;
					float4 In_TangentOS16_g262521 = temp_output_6_0_g262521;
					float3 In_TangentWS16_g262521 = Out_TangentWS15_g262519;
					float3 In_BitangentWS16_g262521 = Out_BitangentWS15_g262519;
					float3 In_ViewDirWS16_g262521 = Out_ViewDirWS15_g262519;
					float4 In_CoordsData16_g262521 = Out_CoordsData15_g262519;
					float4 In_VertexData16_g262521 = Out_VertexData15_g262519;
					float4 In_MasksData16_g262521 = Out_MasksData15_g262519;
					float4 In_PhaseData16_g262521 = Out_PhaseData15_g262519;
					float4 In_TransformData16_g262521 = Out_TransformData15_g262519;
					float4 In_RotationData16_g262521 = Out_RotationData15_g262519;
					float4 In_InterpolatorA16_g262521 = Out_InterpolatorA15_g262519;
					BuildModelVertData( Data16_g262521 , In_Dummy16_g262521 , In_PositionOS16_g262521 , In_PositionWS16_g262521 , In_PositionWO16_g262521 , In_PositionRawOS16_g262521 , In_PivotOS16_g262521 , In_PivotWS16_g262521 , In_PivotWO16_g262521 , In_NormalOS16_g262521 , In_NormalWS16_g262521 , In_NormalRawOS16_g262521 , In_TangentOS16_g262521 , In_TangentWS16_g262521 , In_BitangentWS16_g262521 , In_ViewDirWS16_g262521 , In_CoordsData16_g262521 , In_VertexData16_g262521 , In_MasksData16_g262521 , In_PhaseData16_g262521 , In_TransformData16_g262521 , In_RotationData16_g262521 , In_InterpolatorA16_g262521 );
					TVEModelData Data15_g262525 =(TVEModelData)Data16_g262521;
					float Out_Dummy15_g262525 = 0.0;
					float3 Out_PositionOS15_g262525 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262525 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262525 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262525 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262525 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262525 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262525 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262525 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262525 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262525 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262525 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262525 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262525 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262525 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262525 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262525 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262525 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262525 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262525 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262525 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262525 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262525 , Out_Dummy15_g262525 , Out_PositionOS15_g262525 , Out_PositionWS15_g262525 , Out_PositionWO15_g262525 , Out_PositionRawOS15_g262525 , Out_PivotOS15_g262525 , Out_PivotWS15_g262525 , Out_PivotWO15_g262525 , Out_NormalOS15_g262525 , Out_NormalWS15_g262525 , Out_NormalRawOS15_g262525 , Out_TangentOS15_g262525 , Out_TangentWS15_g262525 , Out_BitangentWS15_g262525 , Out_ViewDirWS15_g262525 , Out_CoordsData15_g262525 , Out_VertexData15_g262525 , Out_MasksData15_g262525 , Out_PhaseData15_g262525 , Out_TransformData15_g262525 , Out_RotationData15_g262525 , Out_InterpolatorA15_g262525 );
					TVEModelData Data16_g262524 =(TVEModelData)Data15_g262525;
					half Dummy181_g262522 = ( _PerspectiveCategory + _PerspectiveEnd );
					float temp_output_14_0_g262524 = Dummy181_g262522;
					float In_Dummy16_g262524 = temp_output_14_0_g262524;
					half3 Model_PositionOS147_g262522 = Out_PositionOS15_g262525;
					float3 temp_output_228_35_g262522 = Out_ViewDirWS15_g262525;
					half3 Model_ViewDirWS237_g262522 = temp_output_228_35_g262522;
					float4x4 break117_g262523 = unity_CameraToWorld;
					float3 appendResult118_g262523 = (float3(break117_g262523[ 0 ][ 2 ] , break117_g262523[ 1 ][ 2 ] , break117_g262523[ 2 ][ 2 ]));
					float3 lerpResult209_g262522 = lerp( Model_ViewDirWS237_g262522 , -appendResult118_g262523 , unity_OrthoParams.w);
					float3 break201_g262522 = cross( lerpResult209_g262522 , half3( 0, 1, 0 ) );
					float3 appendResult196_g262522 = (float3(-break201_g262522.z , 0.0 , break201_g262522.x));
					float4 temp_output_228_27_g262522 = Out_PhaseData15_g262525;
					half4 Model_PhaseData218_g262522 = temp_output_228_27_g262522;
					float2 break226_g262522 = ( (Model_PhaseData218_g262522).xy * _PerspectivePhaseValue );
					float3 appendResult224_g262522 = (float3(break226_g262522.x , 0.0 , break226_g262522.y));
					float dotResult189_g262522 = dot( Model_ViewDirWS237_g262522 , float3( 0, 1, 0 ) );
					float saferPower192_g262522 = abs( dotResult189_g262522 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g262526 = (Model_PositionOS147_g262522).z;
					#else
					float staticSwitch65_g262526 = (Model_PositionOS147_g262522).y;
					#endif
					float3 temp_output_206_0_g262522 = ( Model_PositionOS147_g262522 + ( ( mul( unity_WorldToObject, float4( appendResult196_g262522 , 0.0 ) ).xyz + appendResult224_g262522 ) * _PerspectiveIntensityValue * pow( saferPower192_g262522 , _PerspectiveAngleValue ) * saturate( staticSwitch65_g262526 ) ) );
					#ifdef TVE_PERSPECTIVE
					float3 staticSwitch211_g262522 = temp_output_206_0_g262522;
					#else
					float3 staticSwitch211_g262522 = Model_PositionOS147_g262522;
					#endif
					float3 Final_Position178_g262522 = staticSwitch211_g262522;
					float3 temp_output_4_0_g262524 = Final_Position178_g262522;
					float3 In_PositionOS16_g262524 = temp_output_4_0_g262524;
					float3 In_PositionWS16_g262524 = Out_PositionWS15_g262525;
					float3 In_PositionWO16_g262524 = Out_PositionWO15_g262525;
					float3 In_PositionRawOS16_g262524 = Out_PositionRawOS15_g262525;
					float3 In_PivotOS16_g262524 = Out_PivotOS15_g262525;
					float3 In_PivotWS16_g262524 = Out_PivotWS15_g262525;
					float3 In_PivotWO16_g262524 = Out_PivotWO15_g262525;
					float3 temp_output_21_0_g262524 = Out_NormalOS15_g262525;
					float3 In_NormalOS16_g262524 = temp_output_21_0_g262524;
					float3 In_NormalWS16_g262524 = Out_NormalWS15_g262525;
					float3 In_NormalRawOS16_g262524 = Out_NormalRawOS15_g262525;
					float4 temp_output_6_0_g262524 = Out_TangentOS15_g262525;
					float4 In_TangentOS16_g262524 = temp_output_6_0_g262524;
					float3 In_TangentWS16_g262524 = Out_TangentWS15_g262525;
					float3 In_BitangentWS16_g262524 = Out_BitangentWS15_g262525;
					float3 In_ViewDirWS16_g262524 = temp_output_228_35_g262522;
					float4 In_CoordsData16_g262524 = Out_CoordsData15_g262525;
					float4 In_VertexData16_g262524 = Out_VertexData15_g262525;
					float4 In_MasksData16_g262524 = Out_MasksData15_g262525;
					float4 In_PhaseData16_g262524 = temp_output_228_27_g262522;
					float4 In_TransformData16_g262524 = Out_TransformData15_g262525;
					float4 temp_output_228_33_g262522 = Out_RotationData15_g262525;
					float4 In_RotationData16_g262524 = temp_output_228_33_g262522;
					float4 In_InterpolatorA16_g262524 = Out_InterpolatorA15_g262525;
					BuildModelVertData( Data16_g262524 , In_Dummy16_g262524 , In_PositionOS16_g262524 , In_PositionWS16_g262524 , In_PositionWO16_g262524 , In_PositionRawOS16_g262524 , In_PivotOS16_g262524 , In_PivotWS16_g262524 , In_PivotWO16_g262524 , In_NormalOS16_g262524 , In_NormalWS16_g262524 , In_NormalRawOS16_g262524 , In_TangentOS16_g262524 , In_TangentWS16_g262524 , In_BitangentWS16_g262524 , In_ViewDirWS16_g262524 , In_CoordsData16_g262524 , In_VertexData16_g262524 , In_MasksData16_g262524 , In_PhaseData16_g262524 , In_TransformData16_g262524 , In_RotationData16_g262524 , In_InterpolatorA16_g262524 );
					TVEModelData Data15_g262528 =(TVEModelData)Data16_g262524;
					float Out_Dummy15_g262528 = 0.0;
					float3 Out_PositionOS15_g262528 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262528 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262528 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262528 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262528 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262528 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262528 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262528 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262528 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262528 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262528 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262528 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262528 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262528 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262528 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262528 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262528 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262528 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262528 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262528 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262528 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262528 , Out_Dummy15_g262528 , Out_PositionOS15_g262528 , Out_PositionWS15_g262528 , Out_PositionWO15_g262528 , Out_PositionRawOS15_g262528 , Out_PivotOS15_g262528 , Out_PivotWS15_g262528 , Out_PivotWO15_g262528 , Out_NormalOS15_g262528 , Out_NormalWS15_g262528 , Out_NormalRawOS15_g262528 , Out_TangentOS15_g262528 , Out_TangentWS15_g262528 , Out_BitangentWS15_g262528 , Out_ViewDirWS15_g262528 , Out_CoordsData15_g262528 , Out_VertexData15_g262528 , Out_MasksData15_g262528 , Out_PhaseData15_g262528 , Out_TransformData15_g262528 , Out_RotationData15_g262528 , Out_InterpolatorA15_g262528 );
					TVEModelData Data16_g262529 =(TVEModelData)Data15_g262528;
					half Dummy317_g262527 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float temp_output_14_0_g262529 = Dummy317_g262527;
					float In_Dummy16_g262529 = temp_output_14_0_g262529;
					float3 temp_output_4_0_g262529 = Out_PositionOS15_g262528;
					float3 In_PositionOS16_g262529 = temp_output_4_0_g262529;
					float3 In_PositionWS16_g262529 = Out_PositionWS15_g262528;
					float3 temp_output_314_17_g262527 = Out_PositionWO15_g262528;
					float3 In_PositionWO16_g262529 = temp_output_314_17_g262527;
					float3 In_PositionRawOS16_g262529 = Out_PositionRawOS15_g262528;
					float3 In_PivotOS16_g262529 = Out_PivotOS15_g262528;
					float3 In_PivotWS16_g262529 = Out_PivotWS15_g262528;
					float3 temp_output_314_19_g262527 = Out_PivotWO15_g262528;
					float3 In_PivotWO16_g262529 = temp_output_314_19_g262527;
					float3 temp_output_21_0_g262529 = Out_NormalOS15_g262528;
					float3 In_NormalOS16_g262529 = temp_output_21_0_g262529;
					float3 In_NormalWS16_g262529 = Out_NormalWS15_g262528;
					float3 In_NormalRawOS16_g262529 = Out_NormalRawOS15_g262528;
					float4 temp_output_6_0_g262529 = Out_TangentOS15_g262528;
					float4 In_TangentOS16_g262529 = temp_output_6_0_g262529;
					float3 In_TangentWS16_g262529 = Out_TangentWS15_g262528;
					float3 In_BitangentWS16_g262529 = Out_BitangentWS15_g262528;
					float3 In_ViewDirWS16_g262529 = Out_ViewDirWS15_g262528;
					float4 In_CoordsData16_g262529 = Out_CoordsData15_g262528;
					float4 temp_output_314_29_g262527 = Out_VertexData15_g262528;
					float4 In_VertexData16_g262529 = temp_output_314_29_g262527;
					float4 In_MasksData16_g262529 = Out_MasksData15_g262528;
					float4 In_PhaseData16_g262529 = Out_PhaseData15_g262528;
					half4 Model_TransformData356_g262527 = Out_TransformData15_g262528;
					float localBuildGlobalData204_g262441 = ( 0.0 );
					TVEGlobalData Data204_g262441 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g262441 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g262441 = Dummy211_g262441;
					float4 temp_output_589_164_g262441 = TVE_CoatParams;
					half4 Coat_Params596_g262441 = temp_output_589_164_g262441;
					float4 In_CoatParams204_g262441 = Coat_Params596_g262441;
					float4 temp_output_203_0_g262461 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g262420 = ( 0.0 );
					TVEModelData Data26_g262420 = (TVEModelData)0;
					TVEModelData DataDefault26_g262420 = Data16_g241828;
					TVEModelData Data16_g262429 =(TVEModelData)(TVEModelData)0;
					float In_Dummy16_g262429 = 0.0;
					float3 In_PositionWS16_g262429 = PositionWS122_g262421;
					float3 In_PositionWO16_g262429 = PositionWO132_g262421;
					float3 In_PivotWS16_g262429 = PivotWS121_g262421;
					float3 In_PivotWO16_g262429 = PivotWO133_g262421;
					float3 In_NormalWS16_g262429 = NormalWS95_g262421;
					float3 In_TangentWS16_g262429 = TangentWS136_g262421;
					float3 In_BitangentWS16_g262429 = BiangentWS421_g262421;
					half3 NormalWS427_g262421 = NormalWS95_g262421;
					half3 localComputeTriplanarWeights427_g262421 = ComputeTriplanarWeights( NormalWS427_g262421 );
					half3 TriplanarWeights429_g262421 = localComputeTriplanarWeights427_g262421;
					float3 In_TriplanarWeights16_g262429 = TriplanarWeights429_g262421;
					float3 In_ViewDirWS16_g262429 = ViewDirWS169_g262421;
					float4 In_CoordsData16_g262429 = CoordsData398_g262421;
					float4 In_VertexData16_g262429 = VertexMasks171_g262421;
					float4 In_PhaseData16_g262429 = Phase_Data176_g262421;
					BuildModelFragData( Data16_g262429 , In_Dummy16_g262429 , In_PositionWS16_g262429 , In_PositionWO16_g262429 , In_PivotWS16_g262429 , In_PivotWO16_g262429 , In_NormalWS16_g262429 , In_TangentWS16_g262429 , In_BitangentWS16_g262429 , In_TriplanarWeights16_g262429 , In_ViewDirWS16_g262429 , In_CoordsData16_g262429 , In_VertexData16_g262429 , In_PhaseData16_g262429 );
					TVEModelData DataGeneral26_g262420 = Data16_g262429;
					TVEModelData DataBlanket26_g262420 = Data16_g262429;
					TVEModelData DataImpostor26_g262420 = Data16_g262429;
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
					TVEModelData DataTerrain26_g262420 = Data16_g241826;
					float Type26_g262420 = IsShaderType2637;
					{
					if (Type26_g262420 == 0 )
					{
					Data26_g262420 = DataDefault26_g262420;
					}
					else if (Type26_g262420 == 1 )
					{
					Data26_g262420 = DataGeneral26_g262420;
					}
					else if (Type26_g262420 == 2 )
					{
					Data26_g262420 = DataBlanket26_g262420;
					}
					else if (Type26_g262420 == 3 )
					{
					Data26_g262420 = DataImpostor26_g262420;
					}
					else if (Type26_g262420 == 4 )
					{
					Data26_g262420 = DataTerrain26_g262420;
					}
					}
					TVEModelData Data15_g262517 =(TVEModelData)Data26_g262420;
					float Out_Dummy15_g262517 = 0.0;
					float3 Out_PositionWS15_g262517 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262517 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262517 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262517 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262517 = float3( 0,0,0 );
					float3 Out_TangentWS15_g262517 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262517 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g262517 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262517 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262517 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262517 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262517 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g262517 , Out_Dummy15_g262517 , Out_PositionWS15_g262517 , Out_PositionWO15_g262517 , Out_PivotWS15_g262517 , Out_PivotWO15_g262517 , Out_NormalWS15_g262517 , Out_TangentWS15_g262517 , Out_BitangentWS15_g262517 , Out_TriplanarWeights15_g262517 , Out_ViewDirWS15_g262517 , Out_CoordsData15_g262517 , Out_VertexData15_g262517 , Out_PhaseData15_g262517 );
					float3 Model_PositionWS497_g262441 = Out_PositionWS15_g262517;
					float2 Model_PositionWS_XZ143_g262441 = (Model_PositionWS497_g262441).xz;
					float3 Model_PivotWS498_g262441 = Out_PivotWS15_g262517;
					float2 Model_PivotWS_XZ145_g262441 = (Model_PivotWS498_g262441).xz;
					float2 lerpResult300_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g262461 = lerpResult300_g262441;
					float temp_output_82_0_g262459 = _GlobalCoatLayerValue;
					float temp_output_82_0_g262461 = temp_output_82_0_g262459;
					float4 tex2DArrayNode83_g262461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262461).zw + ( (temp_output_203_0_g262461).xy * temp_output_81_0_g262461 ) ),temp_output_82_0_g262461), 0.0 );
					float4 appendResult210_g262461 = (float4(tex2DArrayNode83_g262461.rgb , saturate( tex2DArrayNode83_g262461.a )));
					float4 temp_output_204_0_g262461 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g262461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262461).zw + ( (temp_output_204_0_g262461).xy * temp_output_81_0_g262461 ) ),temp_output_82_0_g262461), 0.0 );
					float4 appendResult212_g262461 = (float4(tex2DArrayNode122_g262461.rgb , saturate( tex2DArrayNode122_g262461.a )));
					float4 TVE_RenderNearPositionR628_g262441 = TVE_RenderNearPositionR;
					float temp_output_507_0_g262441 = saturate( ( distance( Model_PositionWS497_g262441 , (TVE_RenderNearPositionR628_g262441).xyz ) / (TVE_RenderNearPositionR628_g262441).w ) );
					float temp_output_7_0_g262442 = 1.0;
					float temp_output_9_0_g262442 = ( temp_output_507_0_g262441 - temp_output_7_0_g262442 );
					half TVE_RenderNearFadeValue635_g262441 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g262441 = saturate( ( temp_output_9_0_g262442 / ( ( TVE_RenderNearFadeValue635_g262441 - temp_output_7_0_g262442 ) + 0.0001 ) ) );
					float4 lerpResult131_g262461 = lerp( appendResult210_g262461 , appendResult212_g262461 , Global_TexBlend509_g262441);
					float4 temp_output_159_109_g262459 = lerpResult131_g262461;
					float4 lerpResult168_g262459 = lerp( TVE_CoatParams , temp_output_159_109_g262459 , TVE_CoatLayers[(int)temp_output_82_0_g262459]);
					float4 temp_output_589_109_g262441 = lerpResult168_g262459;
					half4 Coat_Texture302_g262441 = temp_output_589_109_g262441;
					float4 In_CoatTexture204_g262441 = Coat_Texture302_g262441;
					float4 temp_output_595_164_g262441 = TVE_PaintParams;
					half4 Paint_Params575_g262441 = temp_output_595_164_g262441;
					float4 In_PaintParams204_g262441 = Paint_Params575_g262441;
					float4 temp_output_203_0_g262510 = TVE_PaintBaseCoord;
					float2 lerpResult85_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g262510 = lerpResult85_g262441;
					float temp_output_82_0_g262507 = _GlobalPaintLayerValue;
					float temp_output_82_0_g262510 = temp_output_82_0_g262507;
					float4 tex2DArrayNode83_g262510 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262510).zw + ( (temp_output_203_0_g262510).xy * temp_output_81_0_g262510 ) ),temp_output_82_0_g262510), 0.0 );
					float4 appendResult210_g262510 = (float4(tex2DArrayNode83_g262510.rgb , saturate( tex2DArrayNode83_g262510.a )));
					float4 temp_output_204_0_g262510 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g262510 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262510).zw + ( (temp_output_204_0_g262510).xy * temp_output_81_0_g262510 ) ),temp_output_82_0_g262510), 0.0 );
					float4 appendResult212_g262510 = (float4(tex2DArrayNode122_g262510.rgb , saturate( tex2DArrayNode122_g262510.a )));
					float4 lerpResult131_g262510 = lerp( appendResult210_g262510 , appendResult212_g262510 , Global_TexBlend509_g262441);
					float4 temp_output_171_109_g262507 = lerpResult131_g262510;
					float4 lerpResult174_g262507 = lerp( TVE_PaintParams , temp_output_171_109_g262507 , TVE_PaintLayers[(int)temp_output_82_0_g262507]);
					float4 temp_output_595_109_g262441 = lerpResult174_g262507;
					half4 Paint_Texture71_g262441 = temp_output_595_109_g262441;
					float4 In_PaintTexture204_g262441 = Paint_Texture71_g262441;
					float4 temp_output_590_141_g262441 = TVE_AtmoParams;
					half4 Atmo_Params601_g262441 = temp_output_590_141_g262441;
					float4 In_AtmoParams204_g262441 = Atmo_Params601_g262441;
					float4 temp_output_203_0_g262469 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g262469 = lerpResult104_g262441;
					float temp_output_132_0_g262467 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g262469 = temp_output_132_0_g262467;
					float4 tex2DArrayNode83_g262469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262469).zw + ( (temp_output_203_0_g262469).xy * temp_output_81_0_g262469 ) ),temp_output_82_0_g262469), 0.0 );
					float4 appendResult210_g262469 = (float4(tex2DArrayNode83_g262469.rgb , saturate( tex2DArrayNode83_g262469.a )));
					float4 temp_output_204_0_g262469 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g262469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262469).zw + ( (temp_output_204_0_g262469).xy * temp_output_81_0_g262469 ) ),temp_output_82_0_g262469), 0.0 );
					float4 appendResult212_g262469 = (float4(tex2DArrayNode122_g262469.rgb , saturate( tex2DArrayNode122_g262469.a )));
					float4 lerpResult131_g262469 = lerp( appendResult210_g262469 , appendResult212_g262469 , Global_TexBlend509_g262441);
					float4 temp_output_137_109_g262467 = lerpResult131_g262469;
					float4 lerpResult145_g262467 = lerp( TVE_AtmoParams , temp_output_137_109_g262467 , TVE_AtmoLayers[(int)temp_output_132_0_g262467]);
					float4 temp_output_590_110_g262441 = lerpResult145_g262467;
					half4 Atmo_Texture80_g262441 = temp_output_590_110_g262441;
					float4 In_AtmoTexture204_g262441 = Atmo_Texture80_g262441;
					float4 temp_output_593_163_g262441 = TVE_GlowParams;
					half4 Glow_Params609_g262441 = temp_output_593_163_g262441;
					float4 In_GlowParams204_g262441 = Glow_Params609_g262441;
					float4 temp_output_203_0_g262485 = TVE_GlowBaseCoord;
					float2 lerpResult247_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g262485 = lerpResult247_g262441;
					float temp_output_82_0_g262483 = _GlobalGlowLayerValue;
					float temp_output_82_0_g262485 = temp_output_82_0_g262483;
					float4 tex2DArrayNode83_g262485 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262485).zw + ( (temp_output_203_0_g262485).xy * temp_output_81_0_g262485 ) ),temp_output_82_0_g262485), 0.0 );
					float4 appendResult210_g262485 = (float4(tex2DArrayNode83_g262485.rgb , saturate( tex2DArrayNode83_g262485.a )));
					float4 temp_output_204_0_g262485 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g262485 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262485).zw + ( (temp_output_204_0_g262485).xy * temp_output_81_0_g262485 ) ),temp_output_82_0_g262485), 0.0 );
					float4 appendResult212_g262485 = (float4(tex2DArrayNode122_g262485.rgb , saturate( tex2DArrayNode122_g262485.a )));
					float4 lerpResult131_g262485 = lerp( appendResult210_g262485 , appendResult212_g262485 , Global_TexBlend509_g262441);
					float4 temp_output_159_109_g262483 = lerpResult131_g262485;
					float4 lerpResult167_g262483 = lerp( TVE_GlowParams , temp_output_159_109_g262483 , TVE_GlowLayers[(int)temp_output_82_0_g262483]);
					float4 temp_output_593_109_g262441 = lerpResult167_g262483;
					half4 Glow_Texture248_g262441 = temp_output_593_109_g262441;
					float4 In_GlowTexture204_g262441 = Glow_Texture248_g262441;
					float4 temp_output_592_139_g262441 = TVE_FormParams;
					float4 Form_Params606_g262441 = temp_output_592_139_g262441;
					float4 In_FormParams204_g262441 = Form_Params606_g262441;
					float4 temp_output_203_0_g262501 = TVE_FormBaseCoord;
					float2 lerpResult168_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g262501 = lerpResult168_g262441;
					float temp_output_130_0_g262499 = _GlobalFormLayerValue;
					float temp_output_82_0_g262501 = temp_output_130_0_g262499;
					float4 tex2DArrayNode83_g262501 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262501).zw + ( (temp_output_203_0_g262501).xy * temp_output_81_0_g262501 ) ),temp_output_82_0_g262501), 0.0 );
					float4 appendResult210_g262501 = (float4(tex2DArrayNode83_g262501.rgb , saturate( tex2DArrayNode83_g262501.a )));
					float4 temp_output_204_0_g262501 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g262501 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262501).zw + ( (temp_output_204_0_g262501).xy * temp_output_81_0_g262501 ) ),temp_output_82_0_g262501), 0.0 );
					float4 appendResult212_g262501 = (float4(tex2DArrayNode122_g262501.rgb , saturate( tex2DArrayNode122_g262501.a )));
					float4 lerpResult131_g262501 = lerp( appendResult210_g262501 , appendResult212_g262501 , Global_TexBlend509_g262441);
					float4 temp_output_135_109_g262499 = lerpResult131_g262501;
					float4 lerpResult143_g262499 = lerp( TVE_FormParams , temp_output_135_109_g262499 , TVE_FormLayers[(int)temp_output_130_0_g262499]);
					float4 temp_output_592_0_g262441 = lerpResult143_g262499;
					float4 Form_Texture112_g262441 = temp_output_592_0_g262441;
					float4 In_FormTexture204_g262441 = Form_Texture112_g262441;
					float4 temp_output_594_145_g262441 = TVE_FlowParams;
					half4 Flow_Params612_g262441 = temp_output_594_145_g262441;
					float4 In_FlowParams204_g262441 = Flow_Params612_g262441;
					float4 temp_output_203_0_g262493 = TVE_FlowBaseCoord;
					float2 lerpResult400_g262441 = lerp( Model_PositionWS_XZ143_g262441 , Model_PivotWS_XZ145_g262441 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g262493 = lerpResult400_g262441;
					float temp_output_136_0_g262491 = _GlobalFlowLayerValue;
					float temp_output_82_0_g262493 = temp_output_136_0_g262491;
					float4 tex2DArrayNode83_g262493 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262493).zw + ( (temp_output_203_0_g262493).xy * temp_output_81_0_g262493 ) ),temp_output_82_0_g262493), 0.0 );
					float4 appendResult210_g262493 = (float4(tex2DArrayNode83_g262493.rgb , saturate( tex2DArrayNode83_g262493.a )));
					float4 temp_output_204_0_g262493 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g262493 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262493).zw + ( (temp_output_204_0_g262493).xy * temp_output_81_0_g262493 ) ),temp_output_82_0_g262493), 0.0 );
					float4 appendResult212_g262493 = (float4(tex2DArrayNode122_g262493.rgb , saturate( tex2DArrayNode122_g262493.a )));
					float4 lerpResult131_g262493 = lerp( appendResult210_g262493 , appendResult212_g262493 , Global_TexBlend509_g262441);
					float4 temp_output_141_109_g262491 = lerpResult131_g262493;
					float4 lerpResult149_g262491 = lerp( TVE_FlowParams , temp_output_141_109_g262491 , TVE_FlowLayers[(int)temp_output_136_0_g262491]);
					half4 Flow_Texture405_g262441 = lerpResult149_g262491;
					float4 In_FlowTexture204_g262441 = Flow_Texture405_g262441;
					BuildGlobalData( Data204_g262441 , In_Dummy204_g262441 , In_CoatParams204_g262441 , In_CoatTexture204_g262441 , In_PaintParams204_g262441 , In_PaintTexture204_g262441 , In_AtmoParams204_g262441 , In_AtmoTexture204_g262441 , In_GlowParams204_g262441 , In_GlowTexture204_g262441 , In_FormParams204_g262441 , In_FormTexture204_g262441 , In_FlowParams204_g262441 , In_FlowTexture204_g262441 );
					TVEGlobalData Data15_g262530 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262530 = 0.0;
					float4 Out_CoatParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262530 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262530 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262530 = float4( 0,0,0,0 );
					BreakData( Data15_g262530 , Out_Dummy15_g262530 , Out_CoatParams15_g262530 , Out_CoatTexture15_g262530 , Out_PaintParams15_g262530 , Out_PaintTexture15_g262530 , Out_AtmoParams15_g262530 , Out_AtmoTexture15_g262530 , Out_GlowParams15_g262530 , Out_GlowTexture15_g262530 , Out_FormParams15_g262530 , Out_FormTexture15_g262530 , Out_FlowParams15_g262530 , Out_FlowTexture15_g262530 );
					float4 Global_FormTexture351_g262527 = Out_FormTexture15_g262530;
					float3 Model_PivotWO353_g262527 = temp_output_314_19_g262527;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g262536 = _ConformMeshMode;
					float Option70_g262536 = temp_output_17_0_g262536;
					half4 Model_VertexData357_g262527 = temp_output_314_29_g262527;
					float4 temp_output_3_0_g262536 = Model_VertexData357_g262527;
					float4 Channel70_g262536 = temp_output_3_0_g262536;
					float localSwitchChannel470_g262536 = SwitchChannel4( Option70_g262536 , Channel70_g262536 );
					float temp_output_390_0_g262527 = localSwitchChannel470_g262536;
					float temp_output_7_0_g262533 = _ConformMeshRemap.x;
					float temp_output_9_0_g262533 = ( temp_output_390_0_g262527 - temp_output_7_0_g262533 );
					float lerpResult374_g262527 = lerp( 1.0 , saturate( ( temp_output_9_0_g262533 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g262527 = lerpResult374_g262527;
					float temp_output_328_0_g262527 = ( Blend_VertMask379_g262527 * TVE_IsEnabled );
					half Conform_Mask366_g262527 = temp_output_328_0_g262527;
					float temp_output_322_0_g262527 = ( ( ( ( (Global_FormTexture351_g262527).z - ( (Model_PivotWO353_g262527).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g262527 ) );
					float3 appendResult329_g262527 = (float3(0.0 , temp_output_322_0_g262527 , 0.0));
					float3 appendResult387_g262527 = (float3(0.0 , 0.0 , temp_output_322_0_g262527));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262534 = appendResult387_g262527;
					#else
					float3 staticSwitch65_g262534 = appendResult329_g262527;
					#endif
					float3 Blanket_Conform368_g262527 = staticSwitch65_g262534;
					float4 appendResult312_g262527 = (float4(Blanket_Conform368_g262527 , 0.0));
					float4 temp_output_310_0_g262527 = ( Model_TransformData356_g262527 + appendResult312_g262527 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g262527 = temp_output_310_0_g262527;
					#else
					float4 staticSwitch364_g262527 = Model_TransformData356_g262527;
					#endif
					half4 Final_TransformData365_g262527 = staticSwitch364_g262527;
					float4 In_TransformData16_g262529 = Final_TransformData365_g262527;
					float4 In_RotationData16_g262529 = Out_RotationData15_g262528;
					float4 In_InterpolatorA16_g262529 = Out_InterpolatorA15_g262528;
					BuildModelVertData( Data16_g262529 , In_Dummy16_g262529 , In_PositionOS16_g262529 , In_PositionWS16_g262529 , In_PositionWO16_g262529 , In_PositionRawOS16_g262529 , In_PivotOS16_g262529 , In_PivotWS16_g262529 , In_PivotWO16_g262529 , In_NormalOS16_g262529 , In_NormalWS16_g262529 , In_NormalRawOS16_g262529 , In_TangentOS16_g262529 , In_TangentWS16_g262529 , In_BitangentWS16_g262529 , In_ViewDirWS16_g262529 , In_CoordsData16_g262529 , In_VertexData16_g262529 , In_MasksData16_g262529 , In_PhaseData16_g262529 , In_TransformData16_g262529 , In_RotationData16_g262529 , In_InterpolatorA16_g262529 );
					TVEModelData Data15_g262542 =(TVEModelData)Data16_g262529;
					float Out_Dummy15_g262542 = 0.0;
					float3 Out_PositionOS15_g262542 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262542 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262542 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262542 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262542 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262542 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262542 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262542 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262542 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262542 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262542 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262542 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262542 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262542 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262542 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262542 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262542 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262542 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262542 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262542 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262542 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262542 , Out_Dummy15_g262542 , Out_PositionOS15_g262542 , Out_PositionWS15_g262542 , Out_PositionWO15_g262542 , Out_PositionRawOS15_g262542 , Out_PivotOS15_g262542 , Out_PivotWS15_g262542 , Out_PivotWO15_g262542 , Out_NormalOS15_g262542 , Out_NormalWS15_g262542 , Out_NormalRawOS15_g262542 , Out_TangentOS15_g262542 , Out_TangentWS15_g262542 , Out_BitangentWS15_g262542 , Out_ViewDirWS15_g262542 , Out_CoordsData15_g262542 , Out_VertexData15_g262542 , Out_MasksData15_g262542 , Out_PhaseData15_g262542 , Out_TransformData15_g262542 , Out_RotationData15_g262542 , Out_InterpolatorA15_g262542 );
					TVEModelData Data16_g262543 =(TVEModelData)Data15_g262542;
					half Dummy181_g262537 = ( _RotationCategory + _RotationEnd + _RotationInfo );
					float temp_output_14_0_g262543 = Dummy181_g262537;
					float In_Dummy16_g262543 = temp_output_14_0_g262543;
					float3 temp_output_4_0_g262543 = Out_PositionOS15_g262542;
					float3 In_PositionOS16_g262543 = temp_output_4_0_g262543;
					float3 In_PositionWS16_g262543 = Out_PositionWS15_g262542;
					float3 In_PositionWO16_g262543 = Out_PositionWO15_g262542;
					float3 In_PositionRawOS16_g262543 = Out_PositionRawOS15_g262542;
					float3 In_PivotOS16_g262543 = Out_PivotOS15_g262542;
					float3 In_PivotWS16_g262543 = Out_PivotWS15_g262542;
					float3 In_PivotWO16_g262543 = Out_PivotWO15_g262542;
					float3 temp_output_21_0_g262543 = Out_NormalOS15_g262542;
					float3 In_NormalOS16_g262543 = temp_output_21_0_g262543;
					float3 In_NormalWS16_g262543 = Out_NormalWS15_g262542;
					float3 In_NormalRawOS16_g262543 = Out_NormalRawOS15_g262542;
					float4 temp_output_6_0_g262543 = Out_TangentOS15_g262542;
					float4 In_TangentOS16_g262543 = temp_output_6_0_g262543;
					float3 In_TangentWS16_g262543 = Out_TangentWS15_g262542;
					float3 In_BitangentWS16_g262543 = Out_BitangentWS15_g262542;
					float3 In_ViewDirWS16_g262543 = Out_ViewDirWS15_g262542;
					float4 In_CoordsData16_g262543 = Out_CoordsData15_g262542;
					float4 In_VertexData16_g262543 = Out_VertexData15_g262542;
					float4 In_MasksData16_g262543 = Out_MasksData15_g262542;
					float4 In_PhaseData16_g262543 = Out_PhaseData15_g262542;
					float4 In_TransformData16_g262543 = Out_TransformData15_g262542;
					half4 Model_RotationData212_g262537 = Out_RotationData15_g262542;
					TVEGlobalData Data15_g262538 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262538 = 0.0;
					float4 Out_CoatParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262538 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262538 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262538 = float4( 0,0,0,0 );
					BreakData( Data15_g262538 , Out_Dummy15_g262538 , Out_CoatParams15_g262538 , Out_CoatTexture15_g262538 , Out_PaintParams15_g262538 , Out_PaintTexture15_g262538 , Out_AtmoParams15_g262538 , Out_AtmoTexture15_g262538 , Out_GlowParams15_g262538 , Out_GlowTexture15_g262538 , Out_FormParams15_g262538 , Out_FormTexture15_g262538 , Out_FlowParams15_g262538 , Out_FlowTexture15_g262538 );
					half4 Global_FormTexture188_g262537 = Out_FormTexture15_g262538;
					float2 temp_output_38_0_g262539 = ((Global_FormTexture188_g262537).xy*2.0 + -1.0);
					float2 break83_g262539 = temp_output_38_0_g262539;
					float3 appendResult79_g262539 = (float3(break83_g262539.x , 0.0 , break83_g262539.y));
					float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
					float2 lerpResult227_g262537 = lerp( float2( 0,0 ) , (( mul( unity_WorldToObject, float4( appendResult79_g262539 , 0.0 ) ).xyz * ase_parentObjectScale )).xz , ( _RotationIntensityValue * TVE_IsEnabled ));
					half2 Blanket_Orientation192_g262537 = lerpResult227_g262537;
					float4 appendResult222_g262537 = (float4(( (Model_RotationData212_g262537).xy + Blanket_Orientation192_g262537 ) , (Model_RotationData212_g262537).zw));
					#ifdef TVE_ROTATION
					float4 staticSwitch218_g262537 = appendResult222_g262537;
					#else
					float4 staticSwitch218_g262537 = Model_RotationData212_g262537;
					#endif
					half4 Final_RotationData225_g262537 = staticSwitch218_g262537;
					float4 In_RotationData16_g262543 = Final_RotationData225_g262537;
					float4 In_InterpolatorA16_g262543 = Out_InterpolatorA15_g262542;
					BuildModelVertData( Data16_g262543 , In_Dummy16_g262543 , In_PositionOS16_g262543 , In_PositionWS16_g262543 , In_PositionWO16_g262543 , In_PositionRawOS16_g262543 , In_PivotOS16_g262543 , In_PivotWS16_g262543 , In_PivotWO16_g262543 , In_NormalOS16_g262543 , In_NormalWS16_g262543 , In_NormalRawOS16_g262543 , In_TangentOS16_g262543 , In_TangentWS16_g262543 , In_BitangentWS16_g262543 , In_ViewDirWS16_g262543 , In_CoordsData16_g262543 , In_VertexData16_g262543 , In_MasksData16_g262543 , In_PhaseData16_g262543 , In_TransformData16_g262543 , In_RotationData16_g262543 , In_InterpolatorA16_g262543 );
					TVEModelData Data15_g262545 =(TVEModelData)Data16_g262543;
					float Out_Dummy15_g262545 = 0.0;
					float3 Out_PositionOS15_g262545 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262545 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262545 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262545 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262545 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262545 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262545 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262545 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262545 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262545 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262545 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262545 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262545 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262545 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262545 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262545 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262545 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262545 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262545 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262545 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262545 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262545 , Out_Dummy15_g262545 , Out_PositionOS15_g262545 , Out_PositionWS15_g262545 , Out_PositionWO15_g262545 , Out_PositionRawOS15_g262545 , Out_PivotOS15_g262545 , Out_PivotWS15_g262545 , Out_PivotWO15_g262545 , Out_NormalOS15_g262545 , Out_NormalWS15_g262545 , Out_NormalRawOS15_g262545 , Out_TangentOS15_g262545 , Out_TangentWS15_g262545 , Out_BitangentWS15_g262545 , Out_ViewDirWS15_g262545 , Out_CoordsData15_g262545 , Out_VertexData15_g262545 , Out_MasksData15_g262545 , Out_PhaseData15_g262545 , Out_TransformData15_g262545 , Out_RotationData15_g262545 , Out_InterpolatorA15_g262545 );
					TVEModelData Data16_g262546 =(TVEModelData)Data15_g262545;
					half Dummy181_g262544 = ( _SizeFadeCategory + _SizeFadeEnd );
					float temp_output_14_0_g262546 = Dummy181_g262544;
					float In_Dummy16_g262546 = temp_output_14_0_g262546;
					float3 Model_PositionOS147_g262544 = Out_PositionOS15_g262545;
					float3 temp_cast_15 = (1.0).xxx;
					float3 temp_output_210_18_g262544 = Out_PivotWS15_g262545;
					float3 Model_PivotWS162_g262544 = temp_output_210_18_g262544;
					float lerpResult216_g262544 = lerp( 1.0 , TVE_SizeFadeParams.z , TVE_SizeFadeParams.w);
					float temp_output_7_0_g262548 = _SizeFadeDistMaxValue;
					float temp_output_9_0_g262548 = ( ( distance( _WorldSpaceCameraPos , Model_PivotWS162_g262544 ) * lerpResult216_g262544 ) - temp_output_7_0_g262548 );
					TVEGlobalData Data15_g262553 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262553 = 0.0;
					float4 Out_CoatParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262553 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262553 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262553 = float4( 0,0,0,0 );
					BreakData( Data15_g262553 , Out_Dummy15_g262553 , Out_CoatParams15_g262553 , Out_CoatTexture15_g262553 , Out_PaintParams15_g262553 , Out_PaintTexture15_g262553 , Out_AtmoParams15_g262553 , Out_AtmoTexture15_g262553 , Out_GlowParams15_g262553 , Out_GlowTexture15_g262553 , Out_FormParams15_g262553 , Out_FormTexture15_g262553 , Out_FlowParams15_g262553 , Out_FlowTexture15_g262553 );
					half4 Global_FormParams243_g262544 = Out_FormParams15_g262553;
					float temp_output_245_0_g262544 = (Global_FormParams243_g262544).w;
					half4 Global_FormTexture188_g262544 = Out_FormTexture15_g262553;
					float temp_output_6_0_g262552 = (Global_FormTexture188_g262544).w;
					float temp_output_7_0_g262552 = _SizeFadeElementMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g262552 = ( temp_output_6_0_g262552 + temp_output_7_0_g262552 );
					#else
					float staticSwitch14_g262552 = temp_output_6_0_g262552;
					#endif
					float temp_output_223_0_g262544 = staticSwitch14_g262552;
					#ifdef TVE_SIZEFADE_ELEMENT
					float staticSwitch194_g262544 = temp_output_223_0_g262544;
					#else
					float staticSwitch194_g262544 = temp_output_245_0_g262544;
					#endif
					float lerpResult213_g262544 = lerp( 1.0 , staticSwitch194_g262544 , ( _SizeFadeGlobalValue * TVE_IsEnabled ));
					half Blend_GlobalMask192_g262544 = lerpResult213_g262544;
					half Blend_UserMask232_g262544 = 1.0;
					float temp_output_236_0_g262544 = ( Blend_GlobalMask192_g262544 * Blend_UserMask232_g262544 );
					half Blend_Mask240_g262544 = temp_output_236_0_g262544;
					float temp_output_189_0_g262544 = ( saturate( ( temp_output_9_0_g262548 / ( ( _SizeFadeDistMinValue - temp_output_7_0_g262548 ) + 0.0001 ) ) ) * _SizeFadeScaleValue * Blend_Mask240_g262544 );
					float3 appendResult200_g262544 = (float3(temp_output_189_0_g262544 , temp_output_189_0_g262544 , temp_output_189_0_g262544));
					float3 appendResult201_g262544 = (float3(1.0 , temp_output_189_0_g262544 , 1.0));
					float3 appendResult230_g262544 = (float3(1.0 , 1.0 , temp_output_189_0_g262544));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262549 = appendResult230_g262544;
					#else
					float3 staticSwitch65_g262549 = appendResult201_g262544;
					#endif
					float3 lerpResult202_g262544 = lerp( appendResult200_g262544 , staticSwitch65_g262549 , _SizeFadeScaleMode);
					float3 lerpResult184_g262544 = lerp( temp_cast_15 , lerpResult202_g262544 , _SizeFadeIntensityValue);
					float3 temp_output_167_0_g262544 = ( lerpResult184_g262544 * Model_PositionOS147_g262544 );
					#ifdef TVE_SIZEFADE
					float3 staticSwitch199_g262544 = temp_output_167_0_g262544;
					#else
					float3 staticSwitch199_g262544 = Model_PositionOS147_g262544;
					#endif
					float3 Final_Position178_g262544 = staticSwitch199_g262544;
					float3 temp_output_4_0_g262546 = Final_Position178_g262544;
					float3 In_PositionOS16_g262546 = temp_output_4_0_g262546;
					float3 In_PositionWS16_g262546 = Out_PositionWS15_g262545;
					float3 In_PositionWO16_g262546 = Out_PositionWO15_g262545;
					float3 In_PositionRawOS16_g262546 = Out_PositionRawOS15_g262545;
					float3 temp_output_210_24_g262544 = Out_PivotOS15_g262545;
					float3 In_PivotOS16_g262546 = temp_output_210_24_g262544;
					float3 In_PivotWS16_g262546 = temp_output_210_18_g262544;
					float3 In_PivotWO16_g262546 = Out_PivotWO15_g262545;
					float3 temp_output_21_0_g262546 = Out_NormalOS15_g262545;
					float3 In_NormalOS16_g262546 = temp_output_21_0_g262546;
					float3 In_NormalWS16_g262546 = Out_NormalWS15_g262545;
					float3 In_NormalRawOS16_g262546 = Out_NormalRawOS15_g262545;
					float4 temp_output_6_0_g262546 = Out_TangentOS15_g262545;
					float4 In_TangentOS16_g262546 = temp_output_6_0_g262546;
					float3 In_TangentWS16_g262546 = Out_TangentWS15_g262545;
					float3 In_BitangentWS16_g262546 = Out_BitangentWS15_g262545;
					float3 In_ViewDirWS16_g262546 = Out_ViewDirWS15_g262545;
					float4 In_CoordsData16_g262546 = Out_CoordsData15_g262545;
					float4 In_VertexData16_g262546 = Out_VertexData15_g262545;
					float4 In_MasksData16_g262546 = Out_MasksData15_g262545;
					float4 In_PhaseData16_g262546 = Out_PhaseData15_g262545;
					float4 In_TransformData16_g262546 = Out_TransformData15_g262545;
					float4 In_RotationData16_g262546 = Out_RotationData15_g262545;
					float4 In_InterpolatorA16_g262546 = Out_InterpolatorA15_g262545;
					BuildModelVertData( Data16_g262546 , In_Dummy16_g262546 , In_PositionOS16_g262546 , In_PositionWS16_g262546 , In_PositionWO16_g262546 , In_PositionRawOS16_g262546 , In_PivotOS16_g262546 , In_PivotWS16_g262546 , In_PivotWO16_g262546 , In_NormalOS16_g262546 , In_NormalWS16_g262546 , In_NormalRawOS16_g262546 , In_TangentOS16_g262546 , In_TangentWS16_g262546 , In_BitangentWS16_g262546 , In_ViewDirWS16_g262546 , In_CoordsData16_g262546 , In_VertexData16_g262546 , In_MasksData16_g262546 , In_PhaseData16_g262546 , In_TransformData16_g262546 , In_RotationData16_g262546 , In_InterpolatorA16_g262546 );
					TVEModelData Data15_g262556 =(TVEModelData)Data16_g262546;
					float Out_Dummy15_g262556 = 0.0;
					float3 Out_PositionOS15_g262556 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262556 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262556 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262556 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262556 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262556 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262556 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262556 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262556 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262556 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262556 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262556 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262556 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262556 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262556 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262556 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262556 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262556 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262556 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262556 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262556 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262556 , Out_Dummy15_g262556 , Out_PositionOS15_g262556 , Out_PositionWS15_g262556 , Out_PositionWO15_g262556 , Out_PositionRawOS15_g262556 , Out_PivotOS15_g262556 , Out_PivotWS15_g262556 , Out_PivotWO15_g262556 , Out_NormalOS15_g262556 , Out_NormalWS15_g262556 , Out_NormalRawOS15_g262556 , Out_TangentOS15_g262556 , Out_TangentWS15_g262556 , Out_BitangentWS15_g262556 , Out_ViewDirWS15_g262556 , Out_CoordsData15_g262556 , Out_VertexData15_g262556 , Out_MasksData15_g262556 , Out_PhaseData15_g262556 , Out_TransformData15_g262556 , Out_RotationData15_g262556 , Out_InterpolatorA15_g262556 );
					TVEModelData Data16_g262555 =(TVEModelData)Data15_g262556;
					half Dummy181_g262554 = ( ( _MotionCategory + _MotionEnd ) + _MotionPushInfo );
					float temp_output_14_0_g262555 = Dummy181_g262554;
					float In_Dummy16_g262555 = temp_output_14_0_g262555;
					float3 temp_output_2772_0_g262554 = Out_PositionOS15_g262556;
					float3 temp_output_4_0_g262555 = temp_output_2772_0_g262554;
					float3 In_PositionOS16_g262555 = temp_output_4_0_g262555;
					float3 temp_output_2772_16_g262554 = Out_PositionWS15_g262556;
					float3 In_PositionWS16_g262555 = temp_output_2772_16_g262554;
					float3 temp_output_2772_17_g262554 = Out_PositionWO15_g262556;
					float3 In_PositionWO16_g262555 = temp_output_2772_17_g262554;
					float3 In_PositionRawOS16_g262555 = Out_PositionRawOS15_g262556;
					float3 temp_output_2772_24_g262554 = Out_PivotOS15_g262556;
					float3 In_PivotOS16_g262555 = temp_output_2772_24_g262554;
					float3 In_PivotWS16_g262555 = Out_PivotWS15_g262556;
					float3 temp_output_2772_19_g262554 = Out_PivotWO15_g262556;
					float3 In_PivotWO16_g262555 = temp_output_2772_19_g262554;
					float3 temp_output_2772_20_g262554 = Out_NormalOS15_g262556;
					float3 temp_output_21_0_g262555 = temp_output_2772_20_g262554;
					float3 In_NormalOS16_g262555 = temp_output_21_0_g262555;
					float3 In_NormalWS16_g262555 = Out_NormalWS15_g262556;
					float3 In_NormalRawOS16_g262555 = Out_NormalRawOS15_g262556;
					float4 temp_output_6_0_g262555 = Out_TangentOS15_g262556;
					float4 In_TangentOS16_g262555 = temp_output_6_0_g262555;
					float3 In_TangentWS16_g262555 = Out_TangentWS15_g262556;
					float3 In_BitangentWS16_g262555 = Out_BitangentWS15_g262556;
					float3 In_ViewDirWS16_g262555 = Out_ViewDirWS15_g262556;
					float4 In_CoordsData16_g262555 = Out_CoordsData15_g262556;
					float4 temp_output_2772_29_g262554 = Out_VertexData15_g262556;
					float4 In_VertexData16_g262555 = temp_output_2772_29_g262554;
					float4 temp_output_2772_30_g262554 = Out_MasksData15_g262556;
					float4 In_MasksData16_g262555 = temp_output_2772_30_g262554;
					float4 temp_output_2772_27_g262554 = Out_PhaseData15_g262556;
					float4 In_PhaseData16_g262555 = temp_output_2772_27_g262554;
					half4 Model_TransformData2743_g262554 = Out_TransformData15_g262556;
					float3 temp_cast_16 = (0.0).xxx;
					float2 lerpResult3113_g262554 = lerp( (half4( 0, 1, 0.5, 1 )).xy , (TVE_WindParams).xy , TVE_IsEnabled);
					float2 Global_WindDirWS2542_g262554 = lerpResult3113_g262554;
					half2 Input_WindDirWS803_g262605 = Global_WindDirWS2542_g262554;
					float3 Model_PositionWO162_g262554 = temp_output_2772_17_g262554;
					half3 Input_ModelPositionWO761_g262558 = Model_PositionWO162_g262554;
					float3 Model_PivotWO402_g262554 = temp_output_2772_19_g262554;
					half3 Input_ModelPivotsWO419_g262558 = Model_PivotWO402_g262554;
					half Input_MotionPivots629_g262558 = _MotionSmallPivotValue;
					float3 lerpResult771_g262558 = lerp( Input_ModelPositionWO761_g262558 , Input_ModelPivotsWO419_g262558 , Input_MotionPivots629_g262558);
					half4 Model_PhaseData489_g262554 = temp_output_2772_27_g262554;
					half4 Input_ModelMotionData763_g262558 = Model_PhaseData489_g262554;
					half Input_MotionPhase764_g262558 = _MotionSmallPhaseValue;
					float temp_output_770_0_g262558 = ( (Input_ModelMotionData763_g262558).x * Input_MotionPhase764_g262558 );
					half3 Small_Position1421_g262554 = ( lerpResult771_g262558 + temp_output_770_0_g262558 );
					half3 Input_PositionWO419_g262605 = Small_Position1421_g262554;
					half Input_MotionTilling321_g262605 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g262605 = ( -(Input_PositionWO419_g262605).xz * Input_MotionTilling321_g262605 * 0.005 );
					float2 temp_output_3_0_g262606 = Noise_Coord979_g262605;
					float2 temp_output_21_0_g262606 = Input_WindDirWS803_g262605;
					float mulTime113_g262609 = _Time.y * 0.02;
					float lerpResult128_g262609 = lerp( mulTime113_g262609 , ( ( mulTime113_g262609 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g262605 = _MotionSmallSpeedValue;
					half Noise_Speed980_g262605 = ( lerpResult128_g262609 * Input_MotionSpeed62_g262605 );
					float temp_output_15_0_g262606 = Noise_Speed980_g262605;
					float temp_output_23_0_g262606 = frac( temp_output_15_0_g262606 );
					float4 lerpResult39_g262606 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g262606 + ( temp_output_21_0_g262606 * temp_output_23_0_g262606 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g262606 + ( temp_output_21_0_g262606 * frac( ( temp_output_15_0_g262606 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g262606 - 0.5 ) ) / 0.5 ));
					float4 temp_output_991_0_g262605 = lerpResult39_g262606;
					half2 Noise_DirWS858_g262605 = ((temp_output_991_0_g262605).rg*2.0 + -1.0);
					half Input_MotionNoise552_g262605 = _MotionSmallNoiseValue;
					TVEGlobalData Data15_g262568 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262568 = 0.0;
					float4 Out_CoatParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262568 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262568 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262568 = float4( 0,0,0,0 );
					BreakData( Data15_g262568 , Out_Dummy15_g262568 , Out_CoatParams15_g262568 , Out_CoatTexture15_g262568 , Out_PaintParams15_g262568 , Out_PaintTexture15_g262568 , Out_AtmoParams15_g262568 , Out_AtmoTexture15_g262568 , Out_GlowParams15_g262568 , Out_GlowTexture15_g262568 , Out_FormParams15_g262568 , Out_FormTexture15_g262568 , Out_FlowParams15_g262568 , Out_FlowTexture15_g262568 );
					half4 Global_FlowParams3052_g262554 = Out_FlowParams15_g262568;
					half4 Global_FlowTexture2668_g262554 = Out_FlowTexture15_g262568;
					#ifdef TVE_MOTION_ELEMENT
					float4 staticSwitch3075_g262554 = Global_FlowTexture2668_g262554;
					#else
					float4 staticSwitch3075_g262554 = Global_FlowParams3052_g262554;
					#endif
					float4 temp_output_6_0_g262570 = staticSwitch3075_g262554;
					float temp_output_7_0_g262570 = _MotionElementMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g262570 = ( temp_output_6_0_g262570 + temp_output_7_0_g262570 );
					#else
					float4 staticSwitch14_g262570 = temp_output_6_0_g262570;
					#endif
					float4 lerpResult3121_g262554 = lerp( half4( 0, 0, 0, 1 ) , staticSwitch14_g262570 , TVE_IsEnabled);
					float temp_output_630_0_g262583 = saturate( (lerpResult3121_g262554).w );
					float lerpResult853_g262583 = lerp( temp_output_630_0_g262583 , saturate( (temp_output_630_0_g262583*TVE_WindEditor.x + TVE_WindEditor.y) ) , TVE_WindEditor.w);
					half Global_WindValue1855_g262554 = ( lerpResult853_g262583 * _MotionIntensityValue );
					half Input_WindValue881_g262605 = Global_WindValue1855_g262554;
					float temp_output_6_0_g262611 = Input_WindValue881_g262605;
					float lerpResult701_g262605 = lerp( 1.0 , Input_MotionNoise552_g262605 , ( temp_output_6_0_g262611 * temp_output_6_0_g262611 ));
					float2 lerpResult646_g262605 = lerp( Input_WindDirWS803_g262605 , Noise_DirWS858_g262605 , lerpResult701_g262605);
					half2 Small_DirWS817_g262605 = lerpResult646_g262605;
					float2 break823_g262605 = Small_DirWS817_g262605;
					half4 Noise_Params685_g262605 = temp_output_991_0_g262605;
					half Wind_Sinus820_g262605 = ( ((Noise_Params685_g262605).b*2.0 + -1.0) * 0.6 );
					float3 appendResult824_g262605 = (float3(break823_g262605.x , Wind_Sinus820_g262605 , break823_g262605.y));
					half3 Small_Dir918_g262605 = appendResult824_g262605;
					float temp_output_20_0_g262610 = ( 1.0 - Input_WindValue881_g262605 );
					float3 appendResult1006_g262605 = (float3(Input_WindValue881_g262605 , ( 1.0 - ( temp_output_20_0_g262610 * temp_output_20_0_g262610 ) ) , Input_WindValue881_g262605));
					half Input_MotionDelay753_g262605 = _MotionSmallDelayValue;
					float lerpResult756_g262605 = lerp( 1.0 , ( Input_WindValue881_g262605 * Input_WindValue881_g262605 ) , Input_MotionDelay753_g262605);
					half Wind_Delay815_g262605 = lerpResult756_g262605;
					half Input_MotionValue905_g262605 = _MotionSmallIntensityValue;
					float3 temp_output_883_0_g262605 = ( Small_Dir918_g262605 * appendResult1006_g262605 * Wind_Delay815_g262605 * Input_MotionValue905_g262605 );
					float2 break857_g262605 = Noise_DirWS858_g262605;
					float3 appendResult833_g262605 = (float3(break857_g262605.x , Wind_Sinus820_g262605 , break857_g262605.y));
					half3 Push_Dir919_g262605 = appendResult833_g262605;
					half Input_MotionReact924_g262605 = _MotionSmallPushValue;
					float2 temp_output_3126_0_g262554 = ((lerpResult3121_g262554).xy*2.0 + -1.0);
					half Global_PushAlpha1504_g262554 = length( temp_output_3126_0_g262554 );
					half Input_PushAlpha806_g262605 = Global_PushAlpha1504_g262554;
					half Global_PushNoise2675_g262554 = (lerpResult3121_g262554).z;
					half Input_PushNoise890_g262605 = Global_PushNoise2675_g262554;
					half Push_Mask914_g262605 = saturate( ( Input_PushAlpha806_g262605 * Input_PushNoise890_g262605 * Input_MotionReact924_g262605 ) );
					float3 lerpResult840_g262605 = lerp( temp_output_883_0_g262605 , ( Push_Dir919_g262605 * Input_MotionReact924_g262605 ) , Push_Mask914_g262605);
					#ifdef TVE_MOTION_ELEMENT
					float3 staticSwitch829_g262605 = lerpResult840_g262605;
					#else
					float3 staticSwitch829_g262605 = temp_output_883_0_g262605;
					#endif
					half3 Small_Squash1489_g262554 = ( mul( unity_WorldToObject, float4( staticSwitch829_g262605 , 0.0 ) ).xyz * ase_parentObjectScale );
					float temp_output_17_0_g262593 = _MotionSmallMaskMode;
					float Option83_g262593 = temp_output_17_0_g262593;
					half4 Model_VertexMasks518_g262554 = temp_output_2772_29_g262554;
					float4 ChannelA83_g262593 = Model_VertexMasks518_g262554;
					half4 Model_MasksData1322_g262554 = temp_output_2772_30_g262554;
					float2 uv_MotionMaskTex2818_g262554 = v.ase_texcoord.xy;
					half4 Motion_MaskTex2819_g262554 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g262554, 0.0 );
					float4 appendResult3227_g262554 = (float4((Model_MasksData1322_g262554).xy , (Motion_MaskTex2819_g262554).g , 0.0));
					float4 ChannelB83_g262593 = appendResult3227_g262554;
					float localSwitchChannel883_g262593 = SwitchChannel8( Option83_g262593 , ChannelA83_g262593 , ChannelB83_g262593 );
					float enc1805_g262554 = v.ase_texcoord.z;
					float2 localDecodeFloatToVector21805_g262554 = DecodeFloatToVector2( enc1805_g262554 );
					float2 break1804_g262554 = localDecodeFloatToVector21805_g262554;
					half Small_Mask_Legacy1806_g262554 = break1804_g262554.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g262554 = Small_Mask_Legacy1806_g262554;
					#else
					float staticSwitch1800_g262554 = localSwitchChannel883_g262593;
					#endif
					float clampResult17_g262559 = clamp( staticSwitch1800_g262554 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262560 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g262560 = ( clampResult17_g262559 - temp_output_7_0_g262560 );
					half Small_Mask640_g262554 = saturate( ( temp_output_9_0_g262560 * _MotionSmallMaskRemap.z ) );
					float3 lerpResult3022_g262554 = lerp( float3( 1,1,1 ) , (TVE_MotionValueParams).xyz , TVE_MotionValueParams.w);
					half3 Global_MotionParams3013_g262554 = lerpResult3022_g262554;
					half3 Small_Motion789_g262554 = ( Small_Squash1489_g262554 * Small_Mask640_g262554 * (Global_MotionParams3013_g262554).y );
					#ifdef TVE_MOTION
					float3 staticSwitch495_g262554 = Small_Motion789_g262554;
					#else
					float3 staticSwitch495_g262554 = temp_cast_16;
					#endif
					float3 temp_cast_19 = (0.0).xxx;
					float3 Model_PositionWS1819_g262554 = temp_output_2772_16_g262554;
					half Global_DistMask1820_g262554 = ( 1.0 - saturate( ( distance( _WorldSpaceCameraPos , Model_PositionWS1819_g262554 ) / _MotionDistValue ) ) );
					float temp_output_17_0_g262594 = _MotionTinyMaskMode;
					float Option83_g262594 = temp_output_17_0_g262594;
					float4 ChannelA83_g262594 = Model_VertexMasks518_g262554;
					float4 appendResult3234_g262554 = (float4((Model_MasksData1322_g262554).xy , (Motion_MaskTex2819_g262554).b , 0.0));
					float4 ChannelB83_g262594 = appendResult3234_g262554;
					float localSwitchChannel883_g262594 = SwitchChannel8( Option83_g262594 , ChannelA83_g262594 , ChannelB83_g262594 );
					half Tiny_Mask_Legacy1807_g262554 = break1804_g262554.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g262554 = Tiny_Mask_Legacy1807_g262554;
					#else
					float staticSwitch1810_g262554 = localSwitchChannel883_g262594;
					#endif
					float clampResult17_g262561 = clamp( staticSwitch1810_g262554 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262562 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g262562 = ( clampResult17_g262561 - temp_output_7_0_g262562 );
					half Tiny_Mask218_g262554 = saturate( ( temp_output_9_0_g262562 * _MotionTinyMaskRemap.z ) );
					half3 Model_NormalOS554_g262554 = temp_output_2772_20_g262554;
					half3 Input_NormalOS533_g262576 = Model_NormalOS554_g262554;
					half3 Tiny_Position2469_g262554 = Model_PositionWO162_g262554;
					half3 Input_PositionWO500_g262576 = Tiny_Position2469_g262554;
					half Input_MotionTilling321_g262576 = ( _MotionTinyTillingValue + 0.1 );
					float lerpResult128_g262581 = lerp( _Time.y , ( ( _Time.y * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g262576 = _MotionTinySpeedValue;
					float4 tex2DNode514_g262576 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( ( (Input_PositionWO500_g262576).xz * Input_MotionTilling321_g262576 * 0.005 ) + ( lerpResult128_g262581 * Input_MotionSpeed62_g262576 * 0.02 ) ), 0.0 );
					half3 Flutter_Noise535_g262576 = (tex2DNode514_g262576.rgb*2.0 + -1.0);
					half Input_MotionNoise542_g262576 = _MotionTinyNoiseValue;
					float3 lerpResult537_g262576 = lerp( ( Input_NormalOS533_g262576 * Flutter_Noise535_g262576 ) , Flutter_Noise535_g262576 , Input_MotionNoise542_g262576);
					float mulTime113_g262582 = _Time.y * 2.0;
					float lerpResult128_g262582 = lerp( mulTime113_g262582 , ( ( mulTime113_g262582 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					float temp_output_578_0_g262576 = SAMPLE_TEXTURE3D_LOD( _NoiseTex3D, sampler_Linear_Repeat, ( ( Input_PositionWO500_g262576 + lerpResult128_g262582 ) * ( 1.0 * 0.01 ) ), 0.0 ).r;
					half Input_GlobalWind471_g262576 = Global_WindValue1855_g262554;
					float lerpResult579_g262576 = lerp( ( temp_output_578_0_g262576 * temp_output_578_0_g262576 * temp_output_578_0_g262576 * temp_output_578_0_g262576 ) , temp_output_578_0_g262576 , ( Input_GlobalWind471_g262576 * Input_GlobalWind471_g262576 ));
					float temp_output_20_0_g262580 = ( 1.0 - Input_GlobalWind471_g262576 );
					half Wind_Gust589_g262576 = ( ( lerpResult579_g262576 * ( 1.0 - ( temp_output_20_0_g262580 * temp_output_20_0_g262580 * temp_output_20_0_g262580 * temp_output_20_0_g262580 ) ) ) * 0.5 );
					half3 Tiny_Squash859_g262554 = ( lerpResult537_g262576 * Wind_Gust589_g262576 );
					half3 Tiny_Flutter1451_g262554 = ( _MotionTinyIntensityValue * Global_DistMask1820_g262554 * Tiny_Mask218_g262554 * Tiny_Squash859_g262554 * (Global_MotionParams3013_g262554).z );
					#ifdef TVE_MOTION
					float3 staticSwitch414_g262554 = Tiny_Flutter1451_g262554;
					#else
					float3 staticSwitch414_g262554 = temp_cast_19;
					#endif
					float4 appendResult2783_g262554 = (float4(( staticSwitch495_g262554 + staticSwitch414_g262554 ) , 0.0));
					half4 Final_TransformData1569_g262554 = ( Model_TransformData2743_g262554 + appendResult2783_g262554 );
					float4 In_TransformData16_g262555 = Final_TransformData1569_g262554;
					half4 Model_RotationData2740_g262554 = Out_RotationData15_g262556;
					half2 Input_WindDirWS803_g262595 = Global_WindDirWS2542_g262554;
					half3 Input_ModelPositionWO761_g262557 = Model_PositionWO162_g262554;
					half3 Input_ModelPivotsWO419_g262557 = Model_PivotWO402_g262554;
					half Input_MotionPivots629_g262557 = _MotionBasePivotValue;
					float3 lerpResult771_g262557 = lerp( Input_ModelPositionWO761_g262557 , Input_ModelPivotsWO419_g262557 , Input_MotionPivots629_g262557);
					half4 Input_ModelMotionData763_g262557 = Model_PhaseData489_g262554;
					half Input_MotionPhase764_g262557 = _MotionBasePhaseValue;
					float temp_output_770_0_g262557 = ( (Input_ModelMotionData763_g262557).x * Input_MotionPhase764_g262557 );
					half3 Base_Position1394_g262554 = ( lerpResult771_g262557 + temp_output_770_0_g262557 );
					half3 Input_PositionWO419_g262595 = Base_Position1394_g262554;
					half Input_MotionTilling321_g262595 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g262595 = ( -(Input_PositionWO419_g262595).xz * Input_MotionTilling321_g262595 * 0.005 );
					float2 temp_output_3_0_g262602 = Noise_Coord515_g262595;
					float2 temp_output_21_0_g262602 = Input_WindDirWS803_g262595;
					float mulTime113_g262596 = _Time.y * 0.02;
					float lerpResult128_g262596 = lerp( mulTime113_g262596 , ( ( mulTime113_g262596 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					half Input_MotionSpeed62_g262595 = _MotionBaseSpeedValue;
					half Noise_Speed516_g262595 = ( lerpResult128_g262596 * Input_MotionSpeed62_g262595 );
					float temp_output_15_0_g262602 = Noise_Speed516_g262595;
					float temp_output_23_0_g262602 = frac( temp_output_15_0_g262602 );
					float4 lerpResult39_g262602 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g262602 + ( temp_output_21_0_g262602 * temp_output_23_0_g262602 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( temp_output_3_0_g262602 + ( temp_output_21_0_g262602 * frac( ( temp_output_15_0_g262602 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_23_0_g262602 - 0.5 ) ) / 0.5 ));
					float4 temp_output_635_0_g262595 = lerpResult39_g262602;
					half2 Noise_DirWS825_g262595 = ((temp_output_635_0_g262595).rg*2.0 + -1.0);
					half Input_MotionNoise552_g262595 = _MotionBaseNoiseValue;
					half Input_WindValue853_g262595 = Global_WindValue1855_g262554;
					float temp_output_6_0_g262599 = Input_WindValue853_g262595;
					float lerpResult701_g262595 = lerp( 1.0 , Input_MotionNoise552_g262595 , ( temp_output_6_0_g262599 * temp_output_6_0_g262599 ));
					half Input_PushNoise858_g262595 = Global_PushNoise2675_g262554;
					float2 lerpResult646_g262595 = lerp( Input_WindDirWS803_g262595 , Noise_DirWS825_g262595 , saturate( ( lerpResult701_g262595 + Input_PushNoise858_g262595 ) ));
					half2 Bend_Dir859_g262595 = lerpResult646_g262595;
					half Input_MotionValue871_g262595 = _MotionBaseIntensityValue;
					half Input_MotionDelay753_g262595 = _MotionBaseDelayValue;
					float lerpResult756_g262595 = lerp( 1.0 , ( Input_WindValue853_g262595 * Input_WindValue853_g262595 ) , Input_MotionDelay753_g262595);
					half Wind_Delay815_g262595 = lerpResult756_g262595;
					float2 temp_output_875_0_g262595 = ( Bend_Dir859_g262595 * Input_WindValue853_g262595 * Input_MotionValue871_g262595 * Wind_Delay815_g262595 );
					float2 Global_PushDirWS1972_g262554 = temp_output_3126_0_g262554;
					half2 Input_PushDirWS807_g262595 = Global_PushDirWS1972_g262554;
					half Input_ReactValue888_g262595 = _MotionBasePushValue;
					half Input_PushAlpha806_g262595 = Global_PushAlpha1504_g262554;
					half Push_Mask883_g262595 = saturate( ( Input_PushAlpha806_g262595 * Input_ReactValue888_g262595 ) );
					float2 lerpResult811_g262595 = lerp( temp_output_875_0_g262595 , ( Input_PushDirWS807_g262595 * Input_ReactValue888_g262595 ) , Push_Mask883_g262595);
					#ifdef TVE_MOTION_ELEMENT
					float2 staticSwitch808_g262595 = lerpResult811_g262595;
					#else
					float2 staticSwitch808_g262595 = temp_output_875_0_g262595;
					#endif
					float2 temp_output_38_0_g262600 = staticSwitch808_g262595;
					float2 break83_g262600 = temp_output_38_0_g262600;
					float3 appendResult79_g262600 = (float3(break83_g262600.x , 0.0 , break83_g262600.y));
					half2 Base_Bending893_g262554 = (( mul( unity_WorldToObject, float4( appendResult79_g262600 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
					float temp_output_17_0_g262592 = _MotionBaseMaskMode;
					float Option83_g262592 = temp_output_17_0_g262592;
					float4 ChannelA83_g262592 = Model_VertexMasks518_g262554;
					float4 appendResult3220_g262554 = (float4((Model_MasksData1322_g262554).xy , (Motion_MaskTex2819_g262554).r , 0.0));
					float4 ChannelB83_g262592 = appendResult3220_g262554;
					float localSwitchChannel883_g262592 = SwitchChannel8( Option83_g262592 , ChannelA83_g262592 , ChannelB83_g262592 );
					float clampResult17_g262564 = clamp( localSwitchChannel883_g262592 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262563 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g262563 = ( clampResult17_g262564 - temp_output_7_0_g262563 );
					half Base_Mask217_g262554 = saturate( ( temp_output_9_0_g262563 * _MotionBaseMaskRemap.z ) );
					half2 Base_Motion1440_g262554 = ( Base_Bending893_g262554 * Base_Mask217_g262554 * (Global_MotionParams3013_g262554).x );
					#ifdef TVE_MOTION
					float2 staticSwitch2384_g262554 = Base_Motion1440_g262554;
					#else
					float2 staticSwitch2384_g262554 = float2( 0,0 );
					#endif
					float4 appendResult2023_g262554 = (float4(staticSwitch2384_g262554 , 0.0 , 0.0));
					half4 Final_RotationData1570_g262554 = ( Model_RotationData2740_g262554 + appendResult2023_g262554 );
					float4 In_RotationData16_g262555 = Final_RotationData1570_g262554;
					half4 Model_Interpolator02773_g262554 = Out_InterpolatorA15_g262556;
					half4 Noise_Params685_g262595 = temp_output_635_0_g262595;
					float temp_output_6_0_g262598 = (Noise_Params685_g262595).a;
					float temp_output_913_0_g262595 = ( ( temp_output_6_0_g262598 * temp_output_6_0_g262598 * temp_output_6_0_g262598 * temp_output_6_0_g262598 ) * ( Input_WindValue853_g262595 * Wind_Delay815_g262595 ) );
					float temp_output_6_0_g262597 = length( Input_PushDirWS807_g262595 );
					float lerpResult902_g262595 = lerp( temp_output_913_0_g262595 , ( ( temp_output_6_0_g262597 * temp_output_6_0_g262597 ) * Input_PushNoise858_g262595 ) , Push_Mask883_g262595);
					#ifdef TVE_MOTION_ELEMENT
					float staticSwitch903_g262595 = lerpResult902_g262595;
					#else
					float staticSwitch903_g262595 = temp_output_913_0_g262595;
					#endif
					half Base_Wave1159_g262554 = staticSwitch903_g262595;
					float temp_output_6_0_g262612 = (Noise_Params685_g262605).a;
					float temp_output_955_0_g262605 = ( temp_output_6_0_g262612 * temp_output_6_0_g262612 * temp_output_6_0_g262612 * temp_output_6_0_g262612 );
					float temp_output_944_0_g262605 = ( temp_output_955_0_g262605 * ( Input_WindValue881_g262605 * Wind_Delay815_g262605 ) );
					float lerpResult936_g262605 = lerp( temp_output_944_0_g262605 , ( temp_output_955_0_g262605 * Input_PushNoise890_g262605 ) , Push_Mask914_g262605);
					#ifdef TVE_MOTION_ELEMENT
					float staticSwitch939_g262605 = lerpResult936_g262605;
					#else
					float staticSwitch939_g262605 = temp_output_944_0_g262605;
					#endif
					half Small_Wave1427_g262554 = staticSwitch939_g262605;
					float lerpResult2422_g262554 = lerp( Base_Wave1159_g262554 , Small_Wave1427_g262554 , _motion_small_mode);
					half Global_Wave1475_g262554 = saturate( lerpResult2422_g262554 );
					float temp_output_6_0_g262565 = ( _MotionHighlightValue * Global_DistMask1820_g262554 * ( Tiny_Mask218_g262554 * Tiny_Mask218_g262554 ) * Global_Wave1475_g262554 );
					float temp_output_7_0_g262565 = _MotionHighlightColor.r;
					#ifdef TVE_DUMMY
					float staticSwitch14_g262565 = ( temp_output_6_0_g262565 + temp_output_7_0_g262565 );
					#else
					float staticSwitch14_g262565 = temp_output_6_0_g262565;
					#endif
					#ifdef TVE_MOTION
					float staticSwitch2866_g262554 = staticSwitch14_g262565;
					#else
					float staticSwitch2866_g262554 = 0.0;
					#endif
					float4 appendResult2775_g262554 = (float4((Model_Interpolator02773_g262554).xyz , staticSwitch2866_g262554));
					half4 Final_Interpolator02774_g262554 = appendResult2775_g262554;
					float4 In_InterpolatorA16_g262555 = Final_Interpolator02774_g262554;
					BuildModelVertData( Data16_g262555 , In_Dummy16_g262555 , In_PositionOS16_g262555 , In_PositionWS16_g262555 , In_PositionWO16_g262555 , In_PositionRawOS16_g262555 , In_PivotOS16_g262555 , In_PivotWS16_g262555 , In_PivotWO16_g262555 , In_NormalOS16_g262555 , In_NormalWS16_g262555 , In_NormalRawOS16_g262555 , In_TangentOS16_g262555 , In_TangentWS16_g262555 , In_BitangentWS16_g262555 , In_ViewDirWS16_g262555 , In_CoordsData16_g262555 , In_VertexData16_g262555 , In_MasksData16_g262555 , In_PhaseData16_g262555 , In_TransformData16_g262555 , In_RotationData16_g262555 , In_InterpolatorA16_g262555 );
					TVEModelData Data15_g262614 =(TVEModelData)Data16_g262555;
					float Out_Dummy15_g262614 = 0.0;
					float3 Out_PositionOS15_g262614 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262614 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262614 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262614 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262614 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262614 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262614 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262614 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262614 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262614 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262614 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262614 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262614 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262614 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262614 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262614 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262614 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262614 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262614 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262614 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262614 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262614 , Out_Dummy15_g262614 , Out_PositionOS15_g262614 , Out_PositionWS15_g262614 , Out_PositionWO15_g262614 , Out_PositionRawOS15_g262614 , Out_PivotOS15_g262614 , Out_PivotWS15_g262614 , Out_PivotWO15_g262614 , Out_NormalOS15_g262614 , Out_NormalWS15_g262614 , Out_NormalRawOS15_g262614 , Out_TangentOS15_g262614 , Out_TangentWS15_g262614 , Out_BitangentWS15_g262614 , Out_ViewDirWS15_g262614 , Out_CoordsData15_g262614 , Out_VertexData15_g262614 , Out_MasksData15_g262614 , Out_PhaseData15_g262614 , Out_TransformData15_g262614 , Out_RotationData15_g262614 , Out_InterpolatorA15_g262614 );
					TVEModelData Data16_g262615 =(TVEModelData)Data15_g262614;
					float temp_output_14_0_g262615 = 0.0;
					float In_Dummy16_g262615 = temp_output_14_0_g262615;
					float3 Model_PositionOS147_g262613 = Out_PositionOS15_g262614;
					half3 VertexPos40_g262619 = Model_PositionOS147_g262613;
					float4 temp_output_1567_33_g262613 = Out_RotationData15_g262614;
					half4 Model_RotationData1569_g262613 = temp_output_1567_33_g262613;
					float2 break1582_g262613 = (Model_RotationData1569_g262613).xy;
					half Angle44_g262619 = break1582_g262613.y;
					half CosAngle89_g262619 = cos( Angle44_g262619 );
					half SinAngle93_g262619 = sin( Angle44_g262619 );
					float3 appendResult95_g262619 = (float3((VertexPos40_g262619).x , ( ( (VertexPos40_g262619).y * CosAngle89_g262619 ) - ( (VertexPos40_g262619).z * SinAngle93_g262619 ) ) , ( ( (VertexPos40_g262619).y * SinAngle93_g262619 ) + ( (VertexPos40_g262619).z * CosAngle89_g262619 ) )));
					half3 VertexPos40_g262620 = appendResult95_g262619;
					half Angle44_g262620 = -break1582_g262613.x;
					half CosAngle94_g262620 = cos( Angle44_g262620 );
					half SinAngle95_g262620 = sin( Angle44_g262620 );
					float3 appendResult98_g262620 = (float3(( ( (VertexPos40_g262620).x * CosAngle94_g262620 ) - ( (VertexPos40_g262620).y * SinAngle95_g262620 ) ) , ( ( (VertexPos40_g262620).x * SinAngle95_g262620 ) + ( (VertexPos40_g262620).y * CosAngle94_g262620 ) ) , (VertexPos40_g262620).z));
					half3 VertexPos40_g262618 = Model_PositionOS147_g262613;
					half Angle44_g262618 = break1582_g262613.y;
					half CosAngle89_g262618 = cos( Angle44_g262618 );
					half SinAngle93_g262618 = sin( Angle44_g262618 );
					float3 appendResult95_g262618 = (float3((VertexPos40_g262618).x , ( ( (VertexPos40_g262618).y * CosAngle89_g262618 ) - ( (VertexPos40_g262618).z * SinAngle93_g262618 ) ) , ( ( (VertexPos40_g262618).y * SinAngle93_g262618 ) + ( (VertexPos40_g262618).z * CosAngle89_g262618 ) )));
					half3 VertexPos40_g262623 = appendResult95_g262618;
					half Angle44_g262623 = break1582_g262613.x;
					half CosAngle91_g262623 = cos( Angle44_g262623 );
					half SinAngle92_g262623 = sin( Angle44_g262623 );
					float3 appendResult93_g262623 = (float3(( ( (VertexPos40_g262623).x * CosAngle91_g262623 ) + ( (VertexPos40_g262623).z * SinAngle92_g262623 ) ) , (VertexPos40_g262623).y , ( ( -(VertexPos40_g262623).x * SinAngle92_g262623 ) + ( (VertexPos40_g262623).z * CosAngle91_g262623 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262621 = appendResult93_g262623;
					#else
					float3 staticSwitch65_g262621 = appendResult98_g262620;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g262616 = staticSwitch65_g262621;
					#else
					float3 staticSwitch65_g262616 = Model_PositionOS147_g262613;
					#endif
					float3 temp_output_1608_0_g262613 = staticSwitch65_g262616;
					half3 VertexPos40_g262622 = temp_output_1608_0_g262613;
					half Angle44_g262622 = (Model_RotationData1569_g262613).z;
					half CosAngle91_g262622 = cos( Angle44_g262622 );
					half SinAngle92_g262622 = sin( Angle44_g262622 );
					float3 appendResult93_g262622 = (float3(( ( (VertexPos40_g262622).x * CosAngle91_g262622 ) + ( (VertexPos40_g262622).z * SinAngle92_g262622 ) ) , (VertexPos40_g262622).y , ( ( -(VertexPos40_g262622).x * SinAngle92_g262622 ) + ( (VertexPos40_g262622).z * CosAngle91_g262622 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g262617 = appendResult93_g262622;
					#else
					float3 staticSwitch65_g262617 = temp_output_1608_0_g262613;
					#endif
					float4 temp_output_1567_31_g262613 = Out_TransformData15_g262614;
					half4 Model_TransformData1568_g262613 = temp_output_1567_31_g262613;
					half3 Final_PositionOS178_g262613 = ( ( staticSwitch65_g262617 * (Model_TransformData1568_g262613).w ) + (Model_TransformData1568_g262613).xyz );
					float3 temp_output_4_0_g262615 = Final_PositionOS178_g262613;
					float3 In_PositionOS16_g262615 = temp_output_4_0_g262615;
					float3 In_PositionWS16_g262615 = Out_PositionWS15_g262614;
					float3 In_PositionWO16_g262615 = Out_PositionWO15_g262614;
					float3 In_PositionRawOS16_g262615 = Out_PositionRawOS15_g262614;
					float3 In_PivotOS16_g262615 = Out_PivotOS15_g262614;
					float3 In_PivotWS16_g262615 = Out_PivotWS15_g262614;
					float3 In_PivotWO16_g262615 = Out_PivotWO15_g262614;
					float3 temp_output_21_0_g262615 = Out_NormalOS15_g262614;
					float3 In_NormalOS16_g262615 = temp_output_21_0_g262615;
					float3 In_NormalWS16_g262615 = Out_NormalWS15_g262614;
					float3 In_NormalRawOS16_g262615 = Out_NormalRawOS15_g262614;
					float4 temp_output_6_0_g262615 = Out_TangentOS15_g262614;
					float4 In_TangentOS16_g262615 = temp_output_6_0_g262615;
					float3 In_TangentWS16_g262615 = Out_TangentWS15_g262614;
					float3 In_BitangentWS16_g262615 = Out_BitangentWS15_g262614;
					float3 In_ViewDirWS16_g262615 = Out_ViewDirWS15_g262614;
					float4 In_CoordsData16_g262615 = Out_CoordsData15_g262614;
					float4 In_VertexData16_g262615 = Out_VertexData15_g262614;
					float4 In_MasksData16_g262615 = Out_MasksData15_g262614;
					float4 In_PhaseData16_g262615 = Out_PhaseData15_g262614;
					float4 In_TransformData16_g262615 = temp_output_1567_31_g262613;
					float4 In_RotationData16_g262615 = temp_output_1567_33_g262613;
					float4 In_InterpolatorA16_g262615 = Out_InterpolatorA15_g262614;
					BuildModelVertData( Data16_g262615 , In_Dummy16_g262615 , In_PositionOS16_g262615 , In_PositionWS16_g262615 , In_PositionWO16_g262615 , In_PositionRawOS16_g262615 , In_PivotOS16_g262615 , In_PivotWS16_g262615 , In_PivotWO16_g262615 , In_NormalOS16_g262615 , In_NormalWS16_g262615 , In_NormalRawOS16_g262615 , In_TangentOS16_g262615 , In_TangentWS16_g262615 , In_BitangentWS16_g262615 , In_ViewDirWS16_g262615 , In_CoordsData16_g262615 , In_VertexData16_g262615 , In_MasksData16_g262615 , In_PhaseData16_g262615 , In_TransformData16_g262615 , In_RotationData16_g262615 , In_InterpolatorA16_g262615 );
					TVEModelData Data15_g262625 =(TVEModelData)Data16_g262615;
					float Out_Dummy15_g262625 = 0.0;
					float3 Out_PositionOS15_g262625 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262625 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262625 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262625 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262625 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262625 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262625 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262625 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262625 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262625 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262625 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262625 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262625 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262625 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262625 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262625 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262625 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262625 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262625 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262625 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262625 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262625 , Out_Dummy15_g262625 , Out_PositionOS15_g262625 , Out_PositionWS15_g262625 , Out_PositionWO15_g262625 , Out_PositionRawOS15_g262625 , Out_PivotOS15_g262625 , Out_PivotWS15_g262625 , Out_PivotWO15_g262625 , Out_NormalOS15_g262625 , Out_NormalWS15_g262625 , Out_NormalRawOS15_g262625 , Out_TangentOS15_g262625 , Out_TangentWS15_g262625 , Out_BitangentWS15_g262625 , Out_ViewDirWS15_g262625 , Out_CoordsData15_g262625 , Out_VertexData15_g262625 , Out_MasksData15_g262625 , Out_PhaseData15_g262625 , Out_TransformData15_g262625 , Out_RotationData15_g262625 , Out_InterpolatorA15_g262625 );
					TVEModelData Data16_g262627 =(TVEModelData)Data15_g262625;
					half Dummy1823_g262624 = ( _FlattenCategory + _FlattenEnd + _FlattenBakeMode );
					float temp_output_14_0_g262627 = Dummy1823_g262624;
					float In_Dummy16_g262627 = temp_output_14_0_g262627;
					float3 temp_output_4_0_g262627 = Out_PositionOS15_g262625;
					float3 In_PositionOS16_g262627 = temp_output_4_0_g262627;
					float3 In_PositionWS16_g262627 = Out_PositionWS15_g262625;
					float3 In_PositionWO16_g262627 = Out_PositionWO15_g262625;
					float3 temp_output_1810_26_g262624 = Out_PositionRawOS15_g262625;
					float3 In_PositionRawOS16_g262627 = temp_output_1810_26_g262624;
					float3 In_PivotOS16_g262627 = Out_PivotOS15_g262625;
					float3 In_PivotWS16_g262627 = Out_PivotWS15_g262625;
					float3 In_PivotWO16_g262627 = Out_PivotWO15_g262625;
					half3 Model_NormalOS1829_g262624 = Out_NormalOS15_g262625;
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262626 = half3( 0, 0, 1 );
					#else
					float3 staticSwitch65_g262626 = half3( 0, 1, 0 );
					#endif
					float3 lerpResult1820_g262624 = lerp( Model_NormalOS1829_g262624 , staticSwitch65_g262626 , _FlattenIntensityValue);
					float3 Model_PositionBaseOS1837_g262624 = temp_output_1810_26_g262624;
					float3 normalizeResult1816_g262624 = ASESafeNormalize( ( Model_PositionBaseOS1837_g262624 + _FlattenSphereOffsetValue ) );
					float3 lerpResult1813_g262624 = lerp( lerpResult1820_g262624 , normalizeResult1816_g262624 , _FlattenSphereValue);
					float temp_output_17_0_g262634 = _FlattenMeshMode;
					float Option70_g262634 = temp_output_17_0_g262634;
					float4 temp_output_1810_29_g262624 = Out_VertexData15_g262625;
					half4 Model_VertexData1826_g262624 = temp_output_1810_29_g262624;
					float4 temp_output_3_0_g262634 = Model_VertexData1826_g262624;
					float4 Channel70_g262634 = temp_output_3_0_g262634;
					float localSwitchChannel470_g262634 = SwitchChannel4( Option70_g262634 , Channel70_g262634 );
					float clampResult17_g262628 = clamp( localSwitchChannel470_g262634 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262629 = _FlattenMeshRemap.x;
					float temp_output_9_0_g262629 = ( clampResult17_g262628 - temp_output_7_0_g262629 );
					float lerpResult1841_g262624 = lerp( 1.0 , saturate( ( temp_output_9_0_g262629 * _FlattenMeshRemap.z ) ) , _FlattenMeshValue);
					half Normal_MeskMask1847_g262624 = lerpResult1841_g262624;
					half Normal_Mask1851_g262624 = Normal_MeskMask1847_g262624;
					float3 lerpResult1856_g262624 = lerp( Model_NormalOS1829_g262624 , lerpResult1813_g262624 , Normal_Mask1851_g262624);
					#ifdef TVE_FLATTEN
					float3 staticSwitch1857_g262624 = lerpResult1856_g262624;
					#else
					float3 staticSwitch1857_g262624 = Model_NormalOS1829_g262624;
					#endif
					half3 Final_NormalOS1853_g262624 = staticSwitch1857_g262624;
					float3 temp_output_21_0_g262627 = Final_NormalOS1853_g262624;
					float3 In_NormalOS16_g262627 = temp_output_21_0_g262627;
					float3 In_NormalWS16_g262627 = Out_NormalWS15_g262625;
					float3 In_NormalRawOS16_g262627 = Out_NormalRawOS15_g262625;
					float4 temp_output_6_0_g262627 = Out_TangentOS15_g262625;
					float4 In_TangentOS16_g262627 = temp_output_6_0_g262627;
					float3 In_TangentWS16_g262627 = Out_TangentWS15_g262625;
					float3 In_BitangentWS16_g262627 = Out_BitangentWS15_g262625;
					float3 In_ViewDirWS16_g262627 = Out_ViewDirWS15_g262625;
					float4 In_CoordsData16_g262627 = Out_CoordsData15_g262625;
					float4 In_VertexData16_g262627 = temp_output_1810_29_g262624;
					float4 In_MasksData16_g262627 = Out_MasksData15_g262625;
					float4 In_PhaseData16_g262627 = Out_PhaseData15_g262625;
					float4 In_TransformData16_g262627 = Out_TransformData15_g262625;
					float4 In_RotationData16_g262627 = Out_RotationData15_g262625;
					float4 In_InterpolatorA16_g262627 = Out_InterpolatorA15_g262625;
					BuildModelVertData( Data16_g262627 , In_Dummy16_g262627 , In_PositionOS16_g262627 , In_PositionWS16_g262627 , In_PositionWO16_g262627 , In_PositionRawOS16_g262627 , In_PivotOS16_g262627 , In_PivotWS16_g262627 , In_PivotWO16_g262627 , In_NormalOS16_g262627 , In_NormalWS16_g262627 , In_NormalRawOS16_g262627 , In_TangentOS16_g262627 , In_TangentWS16_g262627 , In_BitangentWS16_g262627 , In_ViewDirWS16_g262627 , In_CoordsData16_g262627 , In_VertexData16_g262627 , In_MasksData16_g262627 , In_PhaseData16_g262627 , In_TransformData16_g262627 , In_RotationData16_g262627 , In_InterpolatorA16_g262627 );
					TVEModelData Data15_g262641 =(TVEModelData)Data16_g262627;
					float Out_Dummy15_g262641 = 0.0;
					float3 Out_PositionOS15_g262641 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262641 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262641 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262641 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262641 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262641 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262641 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262641 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262641 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262641 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262641 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262641 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262641 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262641 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262641 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262641 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262641 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262641 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262641 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262641 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262641 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262641 , Out_Dummy15_g262641 , Out_PositionOS15_g262641 , Out_PositionWS15_g262641 , Out_PositionWO15_g262641 , Out_PositionRawOS15_g262641 , Out_PivotOS15_g262641 , Out_PivotWS15_g262641 , Out_PivotWO15_g262641 , Out_NormalOS15_g262641 , Out_NormalWS15_g262641 , Out_NormalRawOS15_g262641 , Out_TangentOS15_g262641 , Out_TangentWS15_g262641 , Out_BitangentWS15_g262641 , Out_ViewDirWS15_g262641 , Out_CoordsData15_g262641 , Out_VertexData15_g262641 , Out_MasksData15_g262641 , Out_PhaseData15_g262641 , Out_TransformData15_g262641 , Out_RotationData15_g262641 , Out_InterpolatorA15_g262641 );
					TVEModelData Data16_g262636 =(TVEModelData)Data15_g262641;
					half Dummy1575_g262635 = ( _ReshadeCategory + _ReshadeEnd );
					float temp_output_14_0_g262636 = Dummy1575_g262635;
					float In_Dummy16_g262636 = temp_output_14_0_g262636;
					float3 temp_output_4_0_g262636 = Out_PositionOS15_g262641;
					float3 In_PositionOS16_g262636 = temp_output_4_0_g262636;
					float3 In_PositionWS16_g262636 = Out_PositionWS15_g262641;
					float3 In_PositionWO16_g262636 = Out_PositionWO15_g262641;
					float3 In_PositionRawOS16_g262636 = Out_PositionRawOS15_g262641;
					float3 In_PivotOS16_g262636 = Out_PivotOS15_g262641;
					float3 In_PivotWS16_g262636 = Out_PivotWS15_g262641;
					float3 In_PivotWO16_g262636 = Out_PivotWO15_g262641;
					half3 Model_NormalOS1568_g262635 = Out_NormalOS15_g262641;
					half3 VertexPos40_g262638 = Model_NormalOS1568_g262635;
					half3 VertexPos40_g262639 = VertexPos40_g262638;
					float4 temp_output_1567_33_g262635 = Out_RotationData15_g262641;
					half4 Model_RotationData1583_g262635 = temp_output_1567_33_g262635;
					half2 Angle44_g262638 = Model_RotationData1583_g262635.xy;
					half Angle44_g262639 = (Angle44_g262638).y;
					half CosAngle89_g262639 = cos( Angle44_g262639 );
					half SinAngle93_g262639 = sin( Angle44_g262639 );
					float3 appendResult95_g262639 = (float3((VertexPos40_g262639).x , ( ( (VertexPos40_g262639).y * CosAngle89_g262639 ) - ( (VertexPos40_g262639).z * SinAngle93_g262639 ) ) , ( ( (VertexPos40_g262639).y * SinAngle93_g262639 ) + ( (VertexPos40_g262639).z * CosAngle89_g262639 ) )));
					half3 VertexPos40_g262640 = appendResult95_g262639;
					half Angle44_g262640 = -(Angle44_g262638).x;
					half CosAngle94_g262640 = cos( Angle44_g262640 );
					half SinAngle95_g262640 = sin( Angle44_g262640 );
					float3 appendResult98_g262640 = (float3(( ( (VertexPos40_g262640).x * CosAngle94_g262640 ) - ( (VertexPos40_g262640).y * SinAngle95_g262640 ) ) , ( ( (VertexPos40_g262640).x * SinAngle95_g262640 ) + ( (VertexPos40_g262640).y * CosAngle94_g262640 ) ) , (VertexPos40_g262640).z));
					float3 lerpResult1591_g262635 = lerp( Model_NormalOS1568_g262635 , appendResult98_g262640 , _ReshadeIntensityValue);
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g262637 = lerpResult1591_g262635;
					#else
					float3 staticSwitch65_g262637 = Model_NormalOS1568_g262635;
					#endif
					float3 temp_output_1732_0_g262635 = staticSwitch65_g262637;
					#ifdef TVE_RESHADE
					float3 staticSwitch1716_g262635 = temp_output_1732_0_g262635;
					#else
					float3 staticSwitch1716_g262635 = Model_NormalOS1568_g262635;
					#endif
					half3 Final_NormalOS178_g262635 = staticSwitch1716_g262635;
					float3 temp_output_21_0_g262636 = Final_NormalOS178_g262635;
					float3 In_NormalOS16_g262636 = temp_output_21_0_g262636;
					float3 In_NormalWS16_g262636 = Out_NormalWS15_g262641;
					float3 In_NormalRawOS16_g262636 = Out_NormalRawOS15_g262641;
					float4 temp_output_6_0_g262636 = Out_TangentOS15_g262641;
					float4 In_TangentOS16_g262636 = temp_output_6_0_g262636;
					float3 In_TangentWS16_g262636 = Out_TangentWS15_g262641;
					float3 In_BitangentWS16_g262636 = Out_BitangentWS15_g262641;
					float3 In_ViewDirWS16_g262636 = Out_ViewDirWS15_g262641;
					float4 In_CoordsData16_g262636 = Out_CoordsData15_g262641;
					float4 In_VertexData16_g262636 = Out_VertexData15_g262641;
					float4 In_MasksData16_g262636 = Out_MasksData15_g262641;
					float4 In_PhaseData16_g262636 = Out_PhaseData15_g262641;
					float4 In_TransformData16_g262636 = Out_TransformData15_g262641;
					float4 In_RotationData16_g262636 = temp_output_1567_33_g262635;
					float4 In_InterpolatorA16_g262636 = Out_InterpolatorA15_g262641;
					BuildModelVertData( Data16_g262636 , In_Dummy16_g262636 , In_PositionOS16_g262636 , In_PositionWS16_g262636 , In_PositionWO16_g262636 , In_PositionRawOS16_g262636 , In_PivotOS16_g262636 , In_PivotWS16_g262636 , In_PivotWO16_g262636 , In_NormalOS16_g262636 , In_NormalWS16_g262636 , In_NormalRawOS16_g262636 , In_TangentOS16_g262636 , In_TangentWS16_g262636 , In_BitangentWS16_g262636 , In_ViewDirWS16_g262636 , In_CoordsData16_g262636 , In_VertexData16_g262636 , In_MasksData16_g262636 , In_PhaseData16_g262636 , In_TransformData16_g262636 , In_RotationData16_g262636 , In_InterpolatorA16_g262636 );
					TVEModelData Data15_g262654 =(TVEModelData)Data16_g262636;
					float Out_Dummy15_g262654 = 0.0;
					float3 Out_PositionOS15_g262654 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262654 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262654 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262654 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262654 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262654 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262654 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262654 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262654 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262654 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262654 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262654 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262654 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262654 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262654 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262654 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262654 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262654 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262654 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262654 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262654 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262654 , Out_Dummy15_g262654 , Out_PositionOS15_g262654 , Out_PositionWS15_g262654 , Out_PositionWO15_g262654 , Out_PositionRawOS15_g262654 , Out_PivotOS15_g262654 , Out_PivotWS15_g262654 , Out_PivotWO15_g262654 , Out_NormalOS15_g262654 , Out_NormalWS15_g262654 , Out_NormalRawOS15_g262654 , Out_TangentOS15_g262654 , Out_TangentWS15_g262654 , Out_BitangentWS15_g262654 , Out_ViewDirWS15_g262654 , Out_CoordsData15_g262654 , Out_VertexData15_g262654 , Out_MasksData15_g262654 , Out_PhaseData15_g262654 , Out_TransformData15_g262654 , Out_RotationData15_g262654 , Out_InterpolatorA15_g262654 );
					TVEModelData Data16_g262655 =(TVEModelData)Data15_g262654;
					half Dummy1575_g262645 = ( _TransferCategory + _TransferEnd + _TransferSpace );
					float temp_output_14_0_g262655 = Dummy1575_g262645;
					float In_Dummy16_g262655 = temp_output_14_0_g262655;
					float3 temp_output_4_0_g262655 = Out_PositionOS15_g262654;
					float3 In_PositionOS16_g262655 = temp_output_4_0_g262655;
					float3 In_PositionWS16_g262655 = Out_PositionWS15_g262654;
					float3 temp_output_1567_17_g262645 = Out_PositionWO15_g262654;
					float3 In_PositionWO16_g262655 = temp_output_1567_17_g262645;
					float3 temp_output_1567_26_g262645 = Out_PositionRawOS15_g262654;
					float3 In_PositionRawOS16_g262655 = temp_output_1567_26_g262645;
					float3 In_PivotOS16_g262655 = Out_PivotOS15_g262654;
					float3 In_PivotWS16_g262655 = Out_PivotWS15_g262654;
					float3 In_PivotWO16_g262655 = Out_PivotWO15_g262654;
					half3 Model_NormalOS1568_g262645 = Out_NormalOS15_g262654;
					TVEGlobalData Data15_g262660 =(TVEGlobalData)Data204_g262441;
					float Out_Dummy15_g262660 = 0.0;
					float4 Out_CoatParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_CoatTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_PaintParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_AtmoParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_GlowParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_FormParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262660 = float4( 0,0,0,0 );
					float4 Out_FlowParams15_g262660 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262660 = float4( 0,0,0,0 );
					BreakData( Data15_g262660 , Out_Dummy15_g262660 , Out_CoatParams15_g262660 , Out_CoatTexture15_g262660 , Out_PaintParams15_g262660 , Out_PaintTexture15_g262660 , Out_AtmoParams15_g262660 , Out_AtmoTexture15_g262660 , Out_GlowParams15_g262660 , Out_GlowTexture15_g262660 , Out_FormParams15_g262660 , Out_FormTexture15_g262660 , Out_FlowParams15_g262660 , Out_FlowTexture15_g262660 );
					half4 Global_FormTexture1633_g262645 = Out_FormTexture15_g262660;
					float2 temp_output_1627_0_g262645 = ((Global_FormTexture1633_g262645).xy*2.0 + -1.0);
					float2 break1617_g262645 = temp_output_1627_0_g262645;
					float dotResult1619_g262645 = dot( temp_output_1627_0_g262645 , temp_output_1627_0_g262645 );
					float3 appendResult1618_g262645 = (float3(break1617_g262645.x , sqrt( ( 1.0 - saturate( dotResult1619_g262645 ) ) ) , break1617_g262645.y));
					float3 worldToObjDir1623_g262645 = mul( unity_WorldToObject, float4( appendResult1618_g262645, 0.0 ) ).xyz;
					half3 Conform_Normal1630_g262645 = worldToObjDir1623_g262645;
					float temp_output_6_0_g262646 = ( _TransferIntensityValue * TVE_IsEnabled );
					float temp_output_7_0_g262646 = ( _TransferPerPixelMode + _TransferInfo );
					#ifdef TVE_DUMMY
					float staticSwitch14_g262646 = ( temp_output_6_0_g262646 + temp_output_7_0_g262646 );
					#else
					float staticSwitch14_g262646 = temp_output_6_0_g262646;
					#endif
					half Conform_Value1742_g262645 = staticSwitch14_g262646;
					float3 temp_output_1567_21_g262645 = Out_NormalWS15_g262654;
					half3 Model_NormalWS1639_g262645 = temp_output_1567_21_g262645;
					float temp_output_1646_0_g262645 = (Model_NormalWS1639_g262645).y;
					float temp_output_7_0_g262649 = _TransferProjRemap.x;
					float temp_output_9_0_g262649 = ( saturate( temp_output_1646_0_g262645 ) - temp_output_7_0_g262649 );
					float lerpResult1669_g262645 = lerp( 1.0 , saturate( ( temp_output_9_0_g262649 * _TransferProjRemap.z ) ) , _TransferProjValue);
					half Normal_Proj_Mask1647_g262645 = lerpResult1669_g262645;
					float temp_output_17_0_g262653 = _TransferMeshMode;
					float Option70_g262653 = temp_output_17_0_g262653;
					float4 temp_output_1567_29_g262645 = Out_VertexData15_g262654;
					half4 Model_VertexData1608_g262645 = temp_output_1567_29_g262645;
					float4 temp_output_3_0_g262653 = Model_VertexData1608_g262645;
					float4 Channel70_g262653 = temp_output_3_0_g262653;
					float localSwitchChannel470_g262653 = SwitchChannel4( Option70_g262653 , Channel70_g262653 );
					float temp_output_1857_0_g262645 = localSwitchChannel470_g262653;
					float temp_output_7_0_g262651 = _TransferMeshRemap.x;
					float temp_output_9_0_g262651 = ( temp_output_1857_0_g262645 - temp_output_7_0_g262651 );
					float lerpResult1820_g262645 = lerp( 1.0 , saturate( ( temp_output_9_0_g262651 * _TransferMeshRemap.z ) ) , _TransferMeshValue);
					half Blend_VertMask1825_g262645 = lerpResult1820_g262645;
					float3 Model_PositionWO1640_g262645 = temp_output_1567_17_g262645;
					float temp_output_64_0_g262652 = saturate( ( ( (Global_FormTexture1633_g262645).z - (Model_PositionWO1640_g262645).y ) + _TransferFormOffsetValue ) );
					float temp_output_66_0_g262652 = _TransferFormValue;
					float lerpResult71_g262652 = lerp( 1.0 , temp_output_64_0_g262652 , ( temp_output_66_0_g262652 * _TransferFormMode ));
					half Normal_FormMask_Mul1708_g262645 = lerpResult71_g262652;
					half Normal_FormMask_Add1629_g262645 = ( temp_output_64_0_g262652 * temp_output_66_0_g262652 );
					half Normal_Mask1748_g262645 = saturate( ( ( Conform_Value1742_g262645 * Normal_Proj_Mask1647_g262645 * Blend_VertMask1825_g262645 * Normal_FormMask_Mul1708_g262645 ) + Normal_FormMask_Add1629_g262645 ) );
					float3 lerpResult1670_g262645 = lerp( Model_NormalOS1568_g262645 , Conform_Normal1630_g262645 , Normal_Mask1748_g262645);
					#ifdef TVE_TRANSFER
					float3 staticSwitch1716_g262645 = lerpResult1670_g262645;
					#else
					float3 staticSwitch1716_g262645 = Model_NormalOS1568_g262645;
					#endif
					half3 Final_NormalOS178_g262645 = staticSwitch1716_g262645;
					float3 temp_output_21_0_g262655 = Final_NormalOS178_g262645;
					float3 In_NormalOS16_g262655 = temp_output_21_0_g262655;
					float3 In_NormalWS16_g262655 = temp_output_1567_21_g262645;
					float3 In_NormalRawOS16_g262655 = Out_NormalRawOS15_g262654;
					half4 Model_TangentOS1749_g262645 = Out_TangentOS15_g262654;
					float4 appendResult1746_g262645 = (float4(cross( worldToObjDir1623_g262645 , float3( 0, 0, 1 ) ) , -1.0));
					half4 Conform_Tangent1747_g262645 = appendResult1746_g262645;
					float4 lerpResult1757_g262645 = lerp( Model_TangentOS1749_g262645 , Conform_Tangent1747_g262645 , Normal_Mask1748_g262645);
					#ifdef TVE_TRANSFER
					float4 staticSwitch1760_g262645 = lerpResult1757_g262645;
					#else
					float4 staticSwitch1760_g262645 = Model_TangentOS1749_g262645;
					#endif
					half4 Final_TangentOS1762_g262645 = staticSwitch1760_g262645;
					float4 temp_output_6_0_g262655 = Final_TangentOS1762_g262645;
					float4 In_TangentOS16_g262655 = temp_output_6_0_g262655;
					float3 In_TangentWS16_g262655 = Out_TangentWS15_g262654;
					float3 In_BitangentWS16_g262655 = Out_BitangentWS15_g262654;
					float3 In_ViewDirWS16_g262655 = Out_ViewDirWS15_g262654;
					float4 In_CoordsData16_g262655 = Out_CoordsData15_g262654;
					float4 In_VertexData16_g262655 = temp_output_1567_29_g262645;
					float4 In_MasksData16_g262655 = Out_MasksData15_g262654;
					float4 In_PhaseData16_g262655 = Out_PhaseData15_g262654;
					float4 In_TransformData16_g262655 = Out_TransformData15_g262654;
					float4 temp_output_1567_33_g262645 = Out_RotationData15_g262654;
					float4 In_RotationData16_g262655 = temp_output_1567_33_g262645;
					half4 Model_Interpolator01775_g262645 = Out_InterpolatorA15_g262654;
					float4 break1777_g262645 = Model_Interpolator01775_g262645;
					float4 appendResult1778_g262645 = (float4(break1777_g262645.x , break1777_g262645.y , Normal_Mask1748_g262645 , break1777_g262645.w));
					#ifdef TVE_TRANSFER
					float4 staticSwitch1779_g262645 = appendResult1778_g262645;
					#else
					float4 staticSwitch1779_g262645 = Model_Interpolator01775_g262645;
					#endif
					half4 Final_Interpolator01780_g262645 = staticSwitch1779_g262645;
					float4 In_InterpolatorA16_g262655 = Final_Interpolator01780_g262645;
					BuildModelVertData( Data16_g262655 , In_Dummy16_g262655 , In_PositionOS16_g262655 , In_PositionWS16_g262655 , In_PositionWO16_g262655 , In_PositionRawOS16_g262655 , In_PivotOS16_g262655 , In_PivotWS16_g262655 , In_PivotWO16_g262655 , In_NormalOS16_g262655 , In_NormalWS16_g262655 , In_NormalRawOS16_g262655 , In_TangentOS16_g262655 , In_TangentWS16_g262655 , In_BitangentWS16_g262655 , In_ViewDirWS16_g262655 , In_CoordsData16_g262655 , In_VertexData16_g262655 , In_MasksData16_g262655 , In_PhaseData16_g262655 , In_TransformData16_g262655 , In_RotationData16_g262655 , In_InterpolatorA16_g262655 );
					TVEModelData Data15_g262662 =(TVEModelData)Data16_g262655;
					float Out_Dummy15_g262662 = 0.0;
					float3 Out_PositionOS15_g262662 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262662 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262662 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262662 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262662 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262662 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262662 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262662 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262662 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262662 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262662 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262662 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262662 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262662 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262662 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262662 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262662 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262662 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262662 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262662 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262662 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262662 , Out_Dummy15_g262662 , Out_PositionOS15_g262662 , Out_PositionWS15_g262662 , Out_PositionWO15_g262662 , Out_PositionRawOS15_g262662 , Out_PivotOS15_g262662 , Out_PivotWS15_g262662 , Out_PivotWO15_g262662 , Out_NormalOS15_g262662 , Out_NormalWS15_g262662 , Out_NormalRawOS15_g262662 , Out_TangentOS15_g262662 , Out_TangentWS15_g262662 , Out_BitangentWS15_g262662 , Out_ViewDirWS15_g262662 , Out_CoordsData15_g262662 , Out_VertexData15_g262662 , Out_MasksData15_g262662 , Out_PhaseData15_g262662 , Out_TransformData15_g262662 , Out_RotationData15_g262662 , Out_InterpolatorA15_g262662 );
					TVEModelData Data16_g262663 =(TVEModelData)Data15_g262662;
					float temp_output_14_0_g262663 = 0.0;
					float In_Dummy16_g262663 = temp_output_14_0_g262663;
					float3 temp_output_217_24_g262661 = Out_PivotOS15_g262662;
					float3 temp_output_216_0_g262661 = ( Out_PositionOS15_g262662 + temp_output_217_24_g262661 );
					float3 temp_output_4_0_g262663 = temp_output_216_0_g262661;
					float3 In_PositionOS16_g262663 = temp_output_4_0_g262663;
					float3 In_PositionWS16_g262663 = Out_PositionWS15_g262662;
					float3 In_PositionWO16_g262663 = Out_PositionWO15_g262662;
					float3 In_PositionRawOS16_g262663 = Out_PositionRawOS15_g262662;
					float3 In_PivotOS16_g262663 = temp_output_217_24_g262661;
					float3 In_PivotWS16_g262663 = Out_PivotWS15_g262662;
					float3 In_PivotWO16_g262663 = Out_PivotWO15_g262662;
					float3 temp_output_21_0_g262663 = Out_NormalOS15_g262662;
					float3 In_NormalOS16_g262663 = temp_output_21_0_g262663;
					float3 In_NormalWS16_g262663 = Out_NormalWS15_g262662;
					float3 In_NormalRawOS16_g262663 = Out_NormalRawOS15_g262662;
					float4 temp_output_6_0_g262663 = Out_TangentOS15_g262662;
					float4 In_TangentOS16_g262663 = temp_output_6_0_g262663;
					float3 In_TangentWS16_g262663 = Out_TangentWS15_g262662;
					float3 In_BitangentWS16_g262663 = Out_BitangentWS15_g262662;
					float3 In_ViewDirWS16_g262663 = Out_ViewDirWS15_g262662;
					float4 In_CoordsData16_g262663 = Out_CoordsData15_g262662;
					float4 In_VertexData16_g262663 = Out_VertexData15_g262662;
					float4 In_MasksData16_g262663 = Out_MasksData15_g262662;
					float4 In_PhaseData16_g262663 = Out_PhaseData15_g262662;
					float4 In_TransformData16_g262663 = Out_TransformData15_g262662;
					float4 In_RotationData16_g262663 = Out_RotationData15_g262662;
					float4 In_InterpolatorA16_g262663 = Out_InterpolatorA15_g262662;
					BuildModelVertData( Data16_g262663 , In_Dummy16_g262663 , In_PositionOS16_g262663 , In_PositionWS16_g262663 , In_PositionWO16_g262663 , In_PositionRawOS16_g262663 , In_PivotOS16_g262663 , In_PivotWS16_g262663 , In_PivotWO16_g262663 , In_NormalOS16_g262663 , In_NormalWS16_g262663 , In_NormalRawOS16_g262663 , In_TangentOS16_g262663 , In_TangentWS16_g262663 , In_BitangentWS16_g262663 , In_ViewDirWS16_g262663 , In_CoordsData16_g262663 , In_VertexData16_g262663 , In_MasksData16_g262663 , In_PhaseData16_g262663 , In_TransformData16_g262663 , In_RotationData16_g262663 , In_InterpolatorA16_g262663 );
					TVEModelData Data15_g262710 =(TVEModelData)Data16_g262663;
					float Out_Dummy15_g262710 = 0.0;
					float3 Out_PositionOS15_g262710 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262710 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262710 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262710 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262710 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262710 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262710 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262710 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262710 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262710 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262710 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262710 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262710 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262710 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262710 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262710 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262710 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262710 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262710 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262710 = float4( 0,0,0,0 );
					float4 Out_InterpolatorA15_g262710 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262710 , Out_Dummy15_g262710 , Out_PositionOS15_g262710 , Out_PositionWS15_g262710 , Out_PositionWO15_g262710 , Out_PositionRawOS15_g262710 , Out_PivotOS15_g262710 , Out_PivotWS15_g262710 , Out_PivotWO15_g262710 , Out_NormalOS15_g262710 , Out_NormalWS15_g262710 , Out_NormalRawOS15_g262710 , Out_TangentOS15_g262710 , Out_TangentWS15_g262710 , Out_BitangentWS15_g262710 , Out_ViewDirWS15_g262710 , Out_CoordsData15_g262710 , Out_VertexData15_g262710 , Out_MasksData15_g262710 , Out_PhaseData15_g262710 , Out_TransformData15_g262710 , Out_RotationData15_g262710 , Out_InterpolatorA15_g262710 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g262710;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g262710;
					v.tangent = Out_TangentOS15_g262710;

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
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2631;-7296,-5376;Inherit;False;Property;_IsShaderType;_IsShaderType;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2637;-7104,-5376;Half;False;IsShaderType;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2632;-7296,-4864;Inherit;False;Block Model;7;;241818;7ad7765e793a6714babedee0033c36e9;18,404,0,437,0,431,0,240,0,290,0,289,0,291,0,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0;11;102;FLOAT3;0,0,0;False;163;FLOAT3;0,0,0;False;186;FLOAT3;0,0,0;False;187;FLOAT3;0,0,0;False;166;FLOAT3;0,0,0;False;164;FLOAT3;0,0,0;False;301;FLOAT3;0,0,0;False;418;FLOAT3;0,0,0;False;167;FLOAT4;0,0,0,0;False;172;FLOAT4;0,0,0,0;False;175;FLOAT4;0,0,0,0;False;2;OBJECT;128;OBJECT;314
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2633;-7296,-4736;Inherit;False;2637;IsShaderType;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2722;-6912,-4736;Inherit;False;If Model Data;-1;;262420;d269c9c511ff160419055604aade1e70;1,32,1;9;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;33;OBJECT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2634;-7296,-4992;Inherit;False;Block Model;7;;262421;7ad7765e793a6714babedee0033c36e9;18,404,1,437,1,431,1,240,1,290,1,289,1,291,1,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0;11;102;FLOAT3;0,0,0;False;163;FLOAT3;0,0,0;False;186;FLOAT3;0,0,0;False;187;FLOAT3;0,0,0;False;166;FLOAT3;0,0,0;False;164;FLOAT3;0,0,0;False;301;FLOAT3;0,0,0;False;418;FLOAT3;0,0,0;False;167;FLOAT4;0,0,0,0;False;172;FLOAT4;0,0,0,0;False;175;FLOAT4;0,0,0,0;False;2;OBJECT;128;OBJECT;314
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2373;-6592,-4736;Half;False;Model Frag;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2723;-6912,-4992;Inherit;False;If Model Data;-1;;262440;d269c9c511ff160419055604aade1e70;1,32,1;9;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;33;OBJECT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2374;-6144,-4992;Inherit;False;2373;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2377;-6592,-4992;Half;False;Model Vert;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2649;-5120,-4992;Inherit;False;2377;Model Vert;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2375;-5888,-4992;Inherit;False;Block Global;21;;262441;212e17d4006dc88449d56ce0340cb5ff;32,308,1,560,1,276,1,285,1,402,1,385,1,283,1,282,1,396,1,417,1,484,0,485,0,486,0,487,0,561,0,482,0,488,0,483,0,315,1,598,0,311,1,578,0,317,1,603,0,604,0,607,0,421,1,321,1,398,1,413,0,557,1,404,1;1;206;OBJECT;0,0,0,0;False;1;OBJECT;151
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2505;-5568,-4992;Half;False;Global Data;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2650;-4864,-4992;Inherit;False;Block Pivots Sub;-1;;262518;186f08b1bbe15894d9c677d50398679b;0;1;146;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2651;-4480,-4864;Inherit;False;2505;Global Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2652;-4480,-4992;Inherit;False;Block Perspective;173;;262522;df5d9c54e8e4098459ebd6b9eabbd8ca;1,243,0;1;146;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2653;-4096,-4864;Inherit;False;2505;Global Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2654;-4096,-4992;Inherit;False;Block Blanket Conform;154;;262527;3ce1684c4351aeb42b79a955aa483301;2,389,0,377,1;2;146;OBJECT;0,0,0,0;False;186;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2655;-3712,-4864;Inherit;False;2505;Global Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2656;-3712,-4992;Inherit;False;Block Blanket Rotation;168;;262537;397a14f11ff1a0449b911fedfcdf94e8;1,290,0;2;146;OBJECT;0,0,0,0;False;186;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2657;-3328,-4864;Inherit;False;2505;Global Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2658;-3328,-4992;Inherit;False;Block Size Fade;179;;262544;467c36a7402d0274b9ad844bbc95de33;6,242,0,228,1,225,1,246,0,249,0,233,0;3;146;OBJECT;0,0,0,0;False;186;OBJECT;0,0,0,0;False;231;FLOAT;1;False;1;OBJECT;128
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2659;-2944,-4992;Inherit;False;Block Motion;80;;262554;d9ac7ad4f0387004fb72c16019bf8392;6,2748,1,2751,1,2753,1,2749,1,3080,1,3079,0;2;146;OBJECT;0,0,0,0;False;212;OBJECT;0,0,0,0;False;2;OBJECT;128;OBJECT;2951
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2660;-2560,-4992;Inherit;False;Block Transform;-1;;262613;5ac6202bdddd8b34a85c261af6b8de8b;0;1;146;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2661;-2176,-4992;Inherit;False;Block Flatten;190;;262624;87f7defafe56dbf4b954caf5efc3f5ca;3,1825,1,1872,0,1843,1;1;146;OBJECT;0,0,0,0;False;2;OBJECT;128;OBJECT;1785
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2662;-1792,-4864;Inherit;False;2505;Global Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2663;-1792,-4992;Inherit;False;Block Reshade;201;;262635;dee2b99295f29df4eac008b19b98e555;1,1812,0;1;146;OBJECT;0,0,0,0;False;2;OBJECT;128;OBJECT;1785
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2664;-1408,-4992;Inherit;False;Block Blanket Transfer;206;;262645;5365f79dd4239a14b84872fad7ced1ab;5,1815,1,1843,0,1844,0,1845,0,1823,1;2;146;OBJECT;0,0,0,0;False;1631;OBJECT;0,0,0,0;False;2;OBJECT;128;OBJECT;1785
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2665;-1024,-4992;Inherit;False;Block Pivots Add;-1;;262661;016babe9e3e643242aa4d123a988150c;0;1;146;OBJECT;0,0,0,0;False;1;OBJECT;128
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2666;-704,-4992;Half;False;Model Data;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2670;768,-4992;Inherit;False;2666;Model Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2705;1152,-2816;Inherit;False;1;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2676;1408,-4864;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TangentVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2678;1408,-4736;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2671;1024,-4992;Inherit;False;Break Model Vert;-1;;262665;857ca65fcb9040b469951916ec700215;0;1;6;OBJECT;0;False;23;OBJECT;40;FLOAT;14;FLOAT3;0;FLOAT3;16;FLOAT3;17;FLOAT3;26;FLOAT3;24;FLOAT3;18;FLOAT3;19;FLOAT3;20;FLOAT3;21;FLOAT3;32;FLOAT4;25;FLOAT3;36;FLOAT3;39;FLOAT3;35;FLOAT4;38;FLOAT4;29;FLOAT4;30;FLOAT4;27;FLOAT4;31;FLOAT4;33;FLOAT4;37
Node;AmplifyShaderEditor.PosVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2675;1408,-4992;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2703;1408,-2816;Inherit;False;FLOAT2;0;1;3;3;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2699;1408,-2944;Inherit;False;FLOAT2;0;1;3;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2709;1408,-2688;Inherit;False;FLOAT2;0;1;3;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2689;1408,-4160;Inherit;False;FLOAT3;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2672;1600,-4992;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2687;1408,-4608;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2673;1408,-4416;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2691;1408,-3968;Inherit;False;FLOAT3;0;0;0;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2692;1408,-3840;Inherit;False;FLOAT3;1;1;1;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2694;1408,-3712;Inherit;False;FLOAT3;2;2;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2696;1408,-3584;Inherit;False;FLOAT3;3;3;3;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2711;1408,-3328;Inherit;False;FLOAT3;0;0;0;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2712;1408,-3200;Inherit;False;FLOAT3;1;1;1;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2701;1600,-2944;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2702;1600,-2816;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2706;1600,-2688;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2677;1824,-4864;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2679;1824,-4736;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2684;1392,-4288;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2594;2048,-4992;Inherit;False;Tool Debug Index;-1;;262666;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2674;2048,-4864;Inherit;False;Tool Debug Index;-1;;262667;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2680;2048,-4736;Inherit;False;Tool Debug Index;-1;;262668;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;2;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2682;2048,-4416;Inherit;False;Tool Debug Index;-1;;262669;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2685;2048,-4160;Inherit;False;Tool Debug Index;-1;;262670;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;7;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2683;2048,-4288;Inherit;False;Tool Debug Index;-1;;262671;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;6;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2690;2048,-3968;Inherit;False;Tool Debug Index;-1;;262672;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;9;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2693;2048,-3840;Inherit;False;Tool Debug Index;-1;;262673;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;10;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2695;2048,-3712;Inherit;False;Tool Debug Index;-1;;262674;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;11;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2697;2048,-3584;Inherit;False;Tool Debug Index;-1;;262675;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;12;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2713;2048,-3328;Inherit;False;Tool Debug Index;-1;;262676;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;14;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2714;2048,-3200;Inherit;False;Tool Debug Index;-1;;262677;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;15;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2700;2048,-2944;Inherit;False;Tool Debug Index;-1;;262678;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;17;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2704;2048,-2816;Inherit;False;Tool Debug Index;-1;;262679;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;18;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2708;2048,-2688;Inherit;False;Tool Debug Index;-1;;262680;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;19;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2688;2048,-4608;Inherit;False;Tool Debug Index;-1;;262681;db6ad3771e2815f4e84bed76b862e261;0;2;39;FLOAT3;0,0,0;False;36;FLOAT;3;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2681;2432,-4416;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2698;2432,-3968;Inherit;False;4;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2550;2432,-4992;Inherit;False;4;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2715;2432,-3328;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2710;2432,-2944;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2667;-256,-4992;Inherit;False;2373;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2716;2816,-4992;Inherit;False;5;5;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2668;0,-4992;Inherit;False;Block Main;129;;262682;b04cfed9a7b4c0841afdb49a38c282c5;12,65,1,136,1,41,1,133,1,40,1,329,1,344,0,347,0,342,0,345,0,346,0,343,0;1;225;OBJECT;0,0,0,0;False;1;OBJECT;106
Node;AmplifyShaderEditor.VertexToFragmentNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2524;3072,-4992;Inherit;False;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2669;320,-4992;Half;False;Visual Data;-1;True;1;0;OBJECT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2399;3392,-4992;Half;False;Final_Debug;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2400;4096,-4992;Inherit;False;2399;Final_Debug;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2563;4096,-4928;Inherit;False;2669;Visual Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2555;4096,-4864;Inherit;False;2666;Model Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2717;1600,-4864;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT;0.5;False;2;FLOAT;0.5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2718;1600,-4736;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT;0.5;False;2;FLOAT;0.5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ConditionalIfNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1774;-880,2944;Inherit;False;True;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1803;-1344,2944;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1772;-1088,3072;Float;False;Constant;_Float3;Float 3;31;0;Create;True;0;0;0;False;0;False;24;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1843;-1632,2944;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1771;-1088,2944;Inherit;False;-1;;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1800;-1472,2944;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1804;-1792,2944;Inherit;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2203;4736,-5120;Inherit;False;Base Compile;-1;;262703;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2721;4323.258,-4731.699;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2720;4352,-4992;Inherit;False;Tool Debug Color;0;;262704;d992d3ed4a7539141ba053d3e0c12277;0;3;80;FLOAT3;0,0,0;False;106;OBJECT;0,0,0;False;107;OBJECT;0,0,0;False;5;FLOAT;114;FLOAT3;0;FLOAT3;113;FLOAT3;148;FLOAT4;149
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2355;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;True;1;LightMode=ForwardAdd;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2356;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2357;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2358;-896,-5376;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2638;3072,-4932;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2353;4352,-4992;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ExtraPrePass;0;0;ExtraPrePass;5;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2354;4736,-4992;Float;False;True;-1;3;;0;3;Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Vertex;28cd5599e02859647ae1798e4fcaef6c;True;ForwardBase;0;1;ForwardBase;15;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;40;Category;0;0;Workflow;0;638874882197810641;Surface;0;0;  Blend;0;0;  Dither Shadows;1;0;Two Sided;0;638874603607655403;Deferred Pass;1;0;Normal Space;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;638814711411603618;Receive Shadows;0;638814711415148256;Receive Specular;0;638814711419031593;GPU Instancing;1;638874881145939632;LOD CrossFade;0;638814711429956434;Built-in Fog;0;638814711441065168;Ambient Light;0;638814711449050123;Meta Pass;0;638814711456998358;Add Pass;0;638814711466594157;Override Baked GI;0;0;Write Depth;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Disable Batching;0;638874882298697380;Vertex Position;0;638874601191422915;0;8;False;True;False;True;False;False;True;True;False;;True;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2639;4736,-4992;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;3;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ScenePickingPass;0;7;ScenePickingPass;1;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=ScenePickingPass;False;False;0;;0;0;Standard;0;False;0
WireConnection;2637;0;2631;0
WireConnection;2722;33;2632;128
WireConnection;2722;27;2634;314
WireConnection;2722;28;2634;314
WireConnection;2722;29;2634;314
WireConnection;2722;30;2632;314
WireConnection;2722;31;2633;0
WireConnection;2373;0;2722;0
WireConnection;2723;33;2634;128
WireConnection;2723;27;2634;128
WireConnection;2723;28;2634;128
WireConnection;2723;29;2634;128
WireConnection;2723;30;2632;128
WireConnection;2723;31;2633;0
WireConnection;2377;0;2723;0
WireConnection;2375;206;2374;0
WireConnection;2505;0;2375;151
WireConnection;2650;146;2649;0
WireConnection;2652;146;2650;128
WireConnection;2654;146;2652;128
WireConnection;2654;186;2651;0
WireConnection;2656;146;2654;128
WireConnection;2656;186;2653;0
WireConnection;2658;146;2656;128
WireConnection;2658;186;2655;0
WireConnection;2659;146;2658;128
WireConnection;2659;212;2657;0
WireConnection;2660;146;2659;128
WireConnection;2661;146;2660;128
WireConnection;2663;146;2661;128
WireConnection;2664;146;2663;128
WireConnection;2664;1631;2662;0
WireConnection;2665;146;2664;128
WireConnection;2666;0;2665;128
WireConnection;2671;6;2670;0
WireConnection;2703;0;2705;0
WireConnection;2699;0;2671;38
WireConnection;2709;0;2671;38
WireConnection;2689;0;2671;25
WireConnection;2672;0;2675;0
WireConnection;2687;0;2671;24
WireConnection;2673;0;2671;0
WireConnection;2691;0;2671;29
WireConnection;2692;0;2671;29
WireConnection;2694;0;2671;29
WireConnection;2696;0;2671;29
WireConnection;2711;0;2671;30
WireConnection;2712;0;2671;30
WireConnection;2701;0;2699;0
WireConnection;2702;0;2703;0
WireConnection;2706;0;2709;0
WireConnection;2677;0;2676;0
WireConnection;2679;0;2678;0
WireConnection;2684;0;2671;20
WireConnection;2594;39;2672;0
WireConnection;2674;39;2677;0
WireConnection;2680;39;2679;0
WireConnection;2682;39;2673;0
WireConnection;2685;39;2689;0
WireConnection;2683;39;2684;0
WireConnection;2690;39;2691;0
WireConnection;2693;39;2692;0
WireConnection;2695;39;2694;0
WireConnection;2697;39;2696;0
WireConnection;2713;39;2711;0
WireConnection;2714;39;2712;0
WireConnection;2700;39;2701;0
WireConnection;2704;39;2702;0
WireConnection;2708;39;2706;0
WireConnection;2688;39;2687;0
WireConnection;2681;0;2682;0
WireConnection;2681;1;2683;0
WireConnection;2681;2;2685;0
WireConnection;2698;0;2690;0
WireConnection;2698;1;2693;0
WireConnection;2698;2;2695;0
WireConnection;2698;3;2697;0
WireConnection;2550;0;2594;0
WireConnection;2550;1;2674;0
WireConnection;2550;2;2680;0
WireConnection;2550;3;2688;0
WireConnection;2715;0;2713;0
WireConnection;2715;1;2714;0
WireConnection;2710;0;2700;0
WireConnection;2710;1;2704;0
WireConnection;2710;2;2708;0
WireConnection;2716;0;2550;0
WireConnection;2716;1;2681;0
WireConnection;2716;2;2698;0
WireConnection;2716;3;2715;0
WireConnection;2716;4;2710;0
WireConnection;2668;225;2667;0
WireConnection;2524;0;2716;0
WireConnection;2669;0;2668;106
WireConnection;2399;0;2524;0
WireConnection;2717;0;2676;0
WireConnection;2718;0;2678;0
WireConnection;1774;0;1771;0
WireConnection;1774;1;1772;0
WireConnection;1774;3;1803;0
WireConnection;1803;0;1800;0
WireConnection;1843;0;1804;0
WireConnection;1800;0;1843;0
WireConnection;2720;80;2400;0
WireConnection;2720;106;2563;0
WireConnection;2720;107;2555;0
WireConnection;2354;0;2720;114
WireConnection;2354;3;2720;114
WireConnection;2354;5;2720;114
WireConnection;2354;2;2720;0
WireConnection;2354;15;2720;113
WireConnection;2354;16;2720;148
WireConnection;2354;17;2720;149
ASEEND*/
//CHKSM=2794649FC260699DA9459351AE17025FEAF47E9C