// Made with Amplify Shader Editor v1.9.9.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Impostors Baker"
{
	Properties
	{
		[StyledCategory(Dual Color Settings, true, _DualColorIntensityValue, FF844E, 0, 10)] _DualColorCategory( "[ Dual Color Category ]", Float ) = 1
		_DualColorIntensityValue( "Dual Color Intensity", Range( 0, 1 ) ) = 0
		[Enum(Off,0,Bake Settings To Textures,1)] _DualColorBakeMode( "Dual Color Baking", Float ) = 1
		_DualColorGrayValue( "Dual Color Gray", Range( 0, 1 ) ) = 0
		[HDR][Gamma] _DualColorOne( "Dual Color A", Color ) = ( 0.3835383, 0.5849056, 0.1407084, 1 )
		[HDR][Gamma] _DualColorTwo( "Dual Color B", Color ) = ( 0.9333333, 0.3534161, 0.1803921, 1 )
		[Space(10)] _DualColorBlendAlbedoValue( "Dual Blend Colors", Range( 0, 1 ) ) = 0
		[StyledSpace(10)] _DualColorEnd( "[ Dual Color End ]", Float ) = 1
		[StyledCategory(Flatten Settings, true, Use the Flatten feature to flatten or spherify the vertex normals used for shading in the pixel stage. The most common usage is to give grass a more QUOlushQUO appearance or to spherify the shading for tree cannopies.NEWNEWUse the Baking option to preMINbake the shading to the impostor normal texture., _FlattenIntensityValue, 80FF00, 0, 10)] _FlattenCategory( "[ Flatten Category ]", Float ) = 0
		_FlattenIntensityValue( "Flatten Intensity", Range( 0, 1 ) ) = 0
		_FlattenSphereValue( "Flatten Spherical", Range( 0, 1 ) ) = 0
		[StyledVector(18)] _FlattenSphereOffsetValue( "Flatten Spherical Offset", Vector ) = ( 0, 0, 0, 0 )
		[Enum(Off,0,Bake Settings To Textures,1)] _FlattenBakeMode( "Flatten Baking", Float ) = 1
		[Space(10)] _FlattenMeshValue( "Flatten Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _FlattenMeshMode( "Flatten Mesh Mask", Float ) = 2
		[StyledRemapSlider] _FlattenMeshRemap( "Flatten Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[StyledSpace(10)] _FlattenEnd( "[ Flatten End ]", Float ) = 1
		[StyledCategory(Emissive Settings, true, Use the Emissive feature to add glow to the objects. The effect works best when using Bloom and HDR rendering., _EmissiveIntensityValue, FFF700, 0, 10)] _EmissiveCategory( "[ Emissive Category ]", Float ) = 0
		_EmissiveIntensityValue( "Emissive Intensity", Range( 0, 1 ) ) = 0
		[Enum(None,0,Any,1,Baked,2,Realtime,3)] _EmissiveFlagMode( "Emissive GI Mode", Float ) = 0
		[Enum(Constant,0,Multiply With Base Albedo,1)] _EmissiveColorMode( "Emissive Color", Float ) = 0
		[HDR][Gamma] _EmissiveColor( "Emissive Color", Color ) = ( 1, 1, 1, 1 )
		[Enum(Nits,0,EV100,1)] _EmissivePowerMode( "Emissive Value", Float ) = 0
		_EmissivePowerValue( "Emissive Value", Float ) = 1
		[Space(10)][StyledTextureSingleLine(Mask R)] _EmissiveMaskTex( "Emissive Mask", 2D ) = "white" {}
		[Enum(Main UV,0,Extra UV,1)][Space(10)] _EmissiveSampleMode( "Mask Sampling", Float ) = 0
		[Enum(Tilling And Offset,0,Scale And Offset,1)] _EmissiveCoordMode( "Mask UV Mode", Float ) = 0
		[StyledVector(18)] _EmissiveCoordValue( "Mask UV Value", Vector ) = ( 1, 1, 0, 0 )
		_EmissiveMaskValue( "Emissive TexR Mask", Range( 0, 1 ) ) = 1
		[StyledRemapSlider] _EmissiveMaskRemap( "Emissive TexR Mask", Vector ) = ( 0, 1, 0, 0 )
		_EmissiveMeshValue( "Emissive Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _EmissiveMeshMode( "Emissive Mesh Mask", Float ) = 0
		[StyledRemapSlider] _EmissiveMeshRemap( "Emissive Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _EmissiveBlendRemap( "Emissive Blend Mask", Vector ) = ( 0, 1, 0, 0 )
		[Space(10)][StyledToggle] _EmissiveElementMode( "Use Glow Elements", Float ) = 0
		[HideInInspector] _emissive_power_value( "_emissive_power_value", Float ) = 1
		[HideInInspector] _emissive_coord_value( "_emissive_coord_value", Vector ) = ( 1, 1, 0, 0 )
		[StyledSpace(10)] _EmissiveEnd( "[ Emissive End ]", Float ) = 1
		[HideInInspector] _IsVersion( "_IsVersion", Float ) = 2150
		[HideInInspector] _render_normal( "_render_normal", Vector ) = ( 1, 1, 1, 0 )
		[StyledCategory(Object Settings, true, Use the Legacy Model mode only for meshes converted using the old Vegetation Engine asset.NEWNEWUse the Z Up Axis mode when the mesh rotation is set as MIN90 on the X axis.NEWNEWUse the Phase Mask to select which vertex color is used for perMINbranch or perMINleaf variation for Motion or Perspective phase offset.NEWNEWUse the Height and Radius values to normalize the procedural Height and Capsule masks used for Motion. In URP and HDRP__ the mesh renderer bounds can be used to remap the values automaticalyEXC, 0, 10)] _ObjectCategory( "[ Object Category ]", Float ) = 1
		[Enum(Legacy,0,Default,1)] _ObjectModelMode( "Object Model Mode", Float ) = 1
		[Enum(Single,0,Baked,1,Procedural,2)] _ObjectPivotMode( "Object Pivots Mode", Float ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _ObjectPhaseMode( "Object Phase Mask", Float ) = 0
		_ObjectHeightValue( "Object Height Value", Range( 0, 40 ) ) = 1
		_ObjectRadiusValue( "Object Radius Value", Range( 0, 40 ) ) = 1
		[StyledSpace(10)] _ObjectEnd( "[ Object End ]", Float ) = 1
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
		[StyledCategory(Layer Settings, true, Use the Layer feature to add an additional texture layer over the previous pass.NEWNEWUse the Shader texture blue channel as a leaves mask when using dual colors or for global coloring effects. Control if the mask is used OPAwhen availableCPA for the following features via the Multi Mask remap sliders.NEWNEWUse the Shader texture blue channel as a height mask for bark and props. In this case__ the next layers can use the height mask via the Base Mask sliders.NEWNEWUse the Baking option to keep the feature dynamic on impostors or preMINbake it to textures OPAwhen availableCPA., _SecondIntensityValue, FA4D29,  0, 10)] _SecondCategory( "[ Layer Category ]", Float ) = 1
		_SecondIntensityValue( "Layer Intensity", Range( 0, 1 ) ) = 0
		[Enum(Off,0,Bake Settings To Textures,1)] _SecondBakeMode( "Layer Baking", Float ) = 1
		[StyledSpace(10)] _SecondSpace0( "# SecondSpace0", Float ) = 0
		[StyledTextureSingleLine(Albedo RGB Alpha A)] _SecondAlbedoTex( "Layer Albedo", 2D ) = "white" {}
		[StyledTextureSingleLine(NormalXY AG)] _SecondNormalTex( "Layer Normal", 2D ) = "linearGrey" {}
		[StyledTextureSingleLine(Metallic R Occlusion G BaseMask and MultiMask B Smoothness A)] _SecondShaderTex( "Layer Shader", 2D ) = "white" {}
		[Enum(Main UV,0,Extra UV,1,Planar,2,Triplanar,3,Stochastic,4,Stochastic Triplanar,5)][Space(10)] _SecondSampleMode( "Layer Sampling", Float ) = 0
		[Enum(Tilling And Offset,0,Scale And Offset,1)] _SecondCoordMode( "Layer UV Mode", Float ) = 0
		[StyledVector(9)] _SecondCoordValue( "Layer UV Value", Vector ) = ( 1, 1, 0, 0 )
		[HDR][Gamma] _SecondColor( "Layer Color", Color ) = ( 1, 1, 1, 1 )
		_SecondAlphaClipValue( "Layer Alpha", Range( 0, 1 ) ) = 0.5
		_SecondAlbedoValue( "Layer Albedo", Range( 0, 1 ) ) = 1
		_SecondNormalValue( "Layer Normal", Range( -8, 8 ) ) = 1
		_SecondMetallicValue( "Layer Metallic", Range( 0, 1 ) ) = 0
		_SecondOcclusionValue( "Layer Occlusion", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _SecondOcclusionRemap( "Layer Occlusion", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _SecondMultiRemap( "Layer Multi Mask", Vector ) = ( 0, 1, 0, 0 )
		_SecondSmoothnessValue( "Layer Smoothness", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _SecondSmoothnessRemap( "Layer Smoothness", Vector ) = ( 0, 1, 0, 0 )
		[Space(10)] _SecondBlendIntensityValue( "Layer Blend Intensity", Range( 0, 1 ) ) = 1
		_SecondBlendAlbedoValue( "Layer Blend Albedos", Range( 0, 1 ) ) = 0
		_SecondBlendNormalValue( "Layer Blend Normals", Range( 0, 1 ) ) = 0
		_SecondBlendShaderValue( "Layer Blend Shaders", Range( 0, 1 ) ) = 0
		[Space(10)][StyledTextureSingleLine(Mask B)] _SecondMaskTex( "Layer Mask", 2D ) = "white" {}
		[Enum(Main UV,0,Extra UV,1,Planar,2,Triplanar,3)][Space(10)] _SecondMaskSampleMode( "Mask Sampling", Float ) = 0
		[Enum(Tilling And Offset,0,Scale And Offset,1)] _SecondMaskCoordMode( "Mask UV Mode", Float ) = 0
		[StyledVector(9)] _SecondMaskCoordValue( "Mask UV Value", Vector ) = ( 1, 1, 0, 0 )
		_SecondMaskValue( "Layer TexC Mask", Range( 0, 1 ) ) = 0
		[Enum(Mask R,0,Mask G,1,Mask B,2,Mask A,3)] _SecondMaskMode( "Layer TexC Mask", Float ) = 0
		[StyledRemapSlider] _SecondMaskRemap( "Layer TexC Mask", Vector ) = ( 0, 1, 0, 0 )
		_SecondBaseValue( "Layer Base Mask", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _SecondBaseRemap( "Layer Base Mask", Vector ) = ( 0, 1, 0, 0 )
		_SecondLumaValue( "Layer Luma Mask", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _SecondLumaRemap( "Layer Luma Mask", Vector ) = ( 0, 1, 0, 0 )
		_SecondProjValue( "Layer ProjY Mask", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _SecondProjRemap( "Layer ProjY Mask", Vector ) = ( 0, 1, 0, 0 )
		_SecondMeshValue( "Layer Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _SecondMeshMode( "Layer Mesh Mask", Float ) = 0
		[StyledRemapSlider] _SecondMeshRemap( "Layer Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _SecondBlendRemap( "Layer Blend Mask", Vector ) = ( 0, 1, 0, 0 )
		[Space(10)][StyledToggle] _SecondElementMode( "Use Coat Elements", Float ) = 0
		[HideInInspector] _second_coord_value( "_second_coord_value", Vector ) = ( 1, 1, 0, 0 )
		[HideInInspector] _second_mask_coord_value( "_second_mask_coord_value", Vector ) = ( 1, 1, 0, 0 )
		[StyledSpace(10)] _SecondEnd( "[ Layer End ]", Float ) = 1
		[StyledCategory(Detail Settings, true, Use the Detail feature to add an additional texture layer over the previous pass.NEWNEWUse the Shader texture blue channel as a leaves mask when using dual colors or for global coloring effects. Control if the mask is used OPAwhen availableCPA for the following features via the Multi Mask remap sliders.NEWNEWUse the Shader texture blue channel as a height mask for bark and props. In this case__ the next layers can use the height mask via the Base Mask sliders.NEWNEWUse the Baking option to keep the feature dynamic on impostors or preMINbake it to textures OPAwhen availableCPA., _ThirdIntensityValue, 7BBE1F,  0, 10)] _ThirdCategory( "[ Detail Category ]", Float ) = 0
		_ThirdIntensityValue( "Detail Intensity", Range( 0, 1 ) ) = 0
		[Enum(Off,0,Bake Settings To Textures,1)] _ThirdBakeMode( "Detail Baking", Float ) = 1
		[StyledSpace(10)] _ThirdSpace0( "# ThirdSpace0", Float ) = 0
		[StyledTextureSingleLine(Albedo RGB Alpha A)] _ThirdAlbedoTex( "Detail Albedo", 2D ) = "white" {}
		[StyledTextureSingleLine(NormalXY AG)] _ThirdNormalTex( "Detail Normal", 2D ) = "linearGrey" {}
		[StyledTextureSingleLine(Metallic R Occlusion G BaseMask and MultiMask B Smoothness A)] _ThirdShaderTex( "Detail Shader", 2D ) = "white" {}
		[Enum(Main UV,0,Extra UV,1,Planar,2,Triplanar,3,Stochastic,4,Stochastic Triplanar,5)][Space(10)] _ThirdSampleMode( "Detail Sampling", Float ) = 0
		[Enum(Tilling And Offset,0,Scale And Offset,1)] _ThirdCoordMode( "Detail UV Mode", Float ) = 0
		[StyledVector(9)] _ThirdCoordValue( "Detail UV Value", Vector ) = ( 1, 1, 0, 0 )
		[Enum(Constant,0,Dual Colors,1)] _ThirdColorMode( "Detail Color", Float ) = 0
		[HDR][Gamma] _ThirdColor( "Detail Color", Color ) = ( 1, 1, 1 )
		[HDR][Gamma] _ThirdColorTwo( "Detail ColorB", Color ) = ( 1, 1, 1 )
		_ThirdAlphaClipValue( "Detail Alpha", Range( 0, 1 ) ) = 0.5
		_ThirdAlbedoValue( "Detail Albedo", Range( 0, 1 ) ) = 1
		_ThirdNormalValue( "Detail Normal", Range( -8, 8 ) ) = 1
		_ThirdMetallicValue( "Detail Metallic", Range( 0, 1 ) ) = 0
		_ThirdOcclusionValue( "Detail Occlusion", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _ThirdOcclusionRemap( "Detail Occlusion", Vector ) = ( 0, 1, 0, 0 )
		_ThirdMultiValue( "Detail Multi Mask", Range( 0, 1 ) ) = 1
		[StyledRemapSlider] _ThirdMultiRemap( "Detail Multi Mask", Vector ) = ( 0, 1, 0, 0 )
		_ThirdSmoothnessValue( "Detail Smoothness", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _ThirdSmoothnessRemap( "Detail Smoothness", Vector ) = ( 0, 1, 0, 0 )
		[Space(10)] _ThirdBlendIntensityValue( "Detail Blend Intensity", Range( 0, 1 ) ) = 1
		_ThirdBlendAlbedoValue( "Detail Blend Albedos", Range( 0, 1 ) ) = 0
		_ThirdBlendNormalValue( "Detail Blend Normals", Range( 0, 1 ) ) = 0
		_ThirdBlendShaderValue( "Detail Blend Shaders", Range( 0, 1 ) ) = 0
		[Space(10)][StyledTextureSingleLine(Mask G)] _ThirdMaskTex( "Detail Mask", 2D ) = "white" {}
		[Enum(Main UV,0,Extra UV,1,Planar,2,Triplanar,3)][Space(10)] _ThirdMaskSampleMode( "Mask Sampling", Float ) = 0
		[Enum(Tilling And Offset,0,Scale And Offset,1)] _ThirdMaskCoordMode( "Mask UV Mode", Float ) = 0
		[StyledVector(9)] _ThirdMaskCoordValue( "Mask UV Value", Vector ) = ( 1, 1, 0, 0 )
		_ThirdMaskValue( "Detail TexC Mask", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _ThirdMaskRemap( "Detail TexC Mask", Vector ) = ( 0, 1, 0, 0 )
		[Enum(Mask R,0,Mask G,1,Mask B,2,Mask A,3)] _ThirdMaskMode( "Detail TexC Mask", Float ) = 1
		_ThirdBaseValue( "Detail Base Mask", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _ThirdBaseRemap( "Detail Base Mask", Vector ) = ( 0, 1, 0, 0 )
		_ThirdLumaValue( "Detail Luma Mask", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _ThirdLumaRemap( "Detail Luma Mask", Vector ) = ( 0, 1, 0, 0 )
		_ThirdProjValue( "Detail ProjY Mask", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _ThirdProjRemap( "Detail ProjY Mask", Vector ) = ( 0, 1, 0, 0 )
		_ThirdMeshValue( "Detail Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _ThirdMeshMode( "Detail Mesh Mask", Float ) = 1
		[StyledRemapSlider] _ThirdMeshRemap( "Detail Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _ThirdBlendRemap( "Detail Blend Mask", Vector ) = ( 0, 1, 0, 0 )
		[Space(10)][StyledToggle] _ThirdElementMode( "Use Coat Elements", Float ) = 0
		[HideInInspector] _third_coord_value( "_third_coord_value", Vector ) = ( 1, 1, 0, 0 )
		[HideInInspector] _third_mask_coord_value( "_third_mask_coord_value", Vector ) = ( 1, 1, 0, 0 )
		[StyledSpace(10)] _ThirdEnd( "[ Detail End ]", Float ) = 1
		[StyledCategory(Occlusion Settings, true, Use the Occlusion feature to blend two colors based on the selected vertex color. The most common usage is to darken the base of grass models or the inside part of tree canopies.NEWNEWUse the Baking option to keep the feature dynamic on impostors or preMINbake it to textures OPAwhen availableCPA., _OcclusionIntensityValue, 60E87F,  0, 10)] _OcclusionCategory( "[ Occlusion Category ]", Float ) = 0
		_OcclusionIntensityValue( "Occlusion Intensity", Range( 0, 1 ) ) = 0
		[Enum(Off,0,Bake Settings To Textures,1)] _OcclusionBakeMode( "Occlusion Baking", Float ) = 1
		[HDR][Gamma] _OcclusionColorOne( "Occlusion Color A", Color ) = ( 1, 1, 1, 1 )
		[HDR][Gamma] _OcclusionColorTwo( "Occlusion Color B", Color ) = ( 0.25, 0.25, 0.25, 1 )
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _OcclusionColorMeshMode( "Occlusion Mesh Mask", Float ) = 1
		[StyledRemapSlider] _OcclusionColorMeshRemap( "Occlusion Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[StyledSpace(10)] _OcclusionEnd( "[ Occlusion End ]", Float ) = 1
		[StyledCategory(Gradient Settings, true, Use the Gradient feature to blend two colors based on the selected vertex color. The most common usage is to add a top down gradient based on Vertex A.NEWNEWUse the Baking option to keep the feature dynamic on impostors or preMINbake it to textures OPAwhen availableCPA.,_GradientIntensityValue, FFBC5B, 0, 10)] _GradientCategory( "[ Gradient Category ]", Float ) = 0
		_GradientIntensityValue( "Gradient Intensity", Range( 0, 1 ) ) = 0
		[Enum(Off,0,Bake Settings To Textures,1)] _GradientBakeMode( "Gradient Baking", Float ) = 1
		_GradientGrayValue( "Gradient Gray", Range( 0, 1 ) ) = 0
		[HDR][Gamma] _GradientColorOne( "Gradient Color A", Color ) = ( 1, 0.6135602, 0, 1 )
		[HDR][Gamma] _GradientColorTwo( "Gradient Color B", Color ) = ( 0.754717, 0.0389044, 0.03203986, 1 )
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _GradientColorMeshMode( "Gradient Mesh Mask", Float ) = 3
		[StyledRemapSlider] _GradientColorMeshRemap( "Gradient Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[Space(10)] _GradientMultiValue( "Gradient Multi Mask", Range( 0, 1 ) ) = 1
		[StyledSpace(10)] _GradientEnd( "[ Gradient End ]", Float ) = 1
		[StyledCategory(Tinting Settings, true, Use the Tinting feature to color the objects using Paint elements. The most common usage is to create seasons or blend grass models with terrains.NEWNEWUse the Tinting Paint Mask to multiply the material colors with the global color when the mask is set to 0 or fade out the feature when the global color is mid gray and the mask is set to 1.NEWNEWUse the Baking option to keep the feature dynamic on impostors or preMINbake it to textures OPAwhen availableCPA., _TintingIntensityValue, FF613D, 0, 10)] _TintingCategory( "[ Tinting Category ]", Float ) = 0
		_TintingIntensityValue( "Tinting Intensity", Range( 0, 1 ) ) = 0
		[Enum(Off,0,Bake Settings To Textures,1)] _TintingBakeMode( "Tinting Baking", Float ) = 0
		_TintingGrayValue( "Tinting Gray", Range( 0, 1 ) ) = 1
		[HDR][Gamma] _TintingColor( "Tinting Color", Color ) = ( 2, 2, 2, 1 )
		[StyledSpace(10)] _TintingSpace( "[ Tinting Space ]", Float ) = 1
		_TintingMultiValue( "Tinting Multi Mask", Range( 0, 1 ) ) = 1
		_TintingLumaValue( "Tinting Luma Mask", Range( 0, 1 ) ) = 1
		[StyledRemapSlider] _TintingLumaRemap( "Tinting Luma Mask", Vector ) = ( 0, 1, 0, 0 )
		_TintingMeshValue( "Tinting Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _TintingMeshMode( "Tinting Mesh Mask", Float ) = 3
		[StyledRemapSlider] _TintingMeshRemap( "Tinting Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _TintingBlendRemap( "Tinting Blend Mask", Vector ) = ( 0.1, 0.2, 0, 0 )
		[Space(10)][StyledToggle] _TintingElementMode( "Use Paint Elements", Float ) = 0
		[StyledSpace(10)] _TintingEnd( "[ Tinting End]", Float ) = 1
		[StyledCategory(Dryness Settings, true, Use the Dryness feature to create automn scenaries. The main advantage of using the feature is local control over coloring__ smoothness and subsurface effects. Please note__ when using Dryness__ Overlay and Wetness with elements__ the same global textures are used__ making the rendering more optimized compared to using Tinting for seasonsEXCNEWNEWUse the Baking option to keep the feature dynamic on impostors or preMINbake it to textures OPAwhen availableCPA., _DrynessIntensityValue, FFBE71, 0, 10)] _DrynessCategory( "[ Dryness Category ]", Float ) = 0
		_DrynessIntensityValue( "Dryness Intensity", Range( 0, 1 ) ) = 0
		[Enum(Off,0,Bake Settings To Textures,1)] _DrynessBakeMode( "Dryness Baking", Float ) = 0
		_DrynessGrayValue( "Dryness Gray", Range( 0, 1 ) ) = 1
		[HDR][Gamma] _DrynessColor( "Dryness Color", Color ) = ( 2, 1.4, 1, 1 )
		_DrynessSubsurfaceValue( "Dryness Subsurface", Range( 0, 1 ) ) = 0.5
		_DrynessSmoothnessValue( "Dryness Smoothness", Range( 0, 1 ) ) = 0.5
		[StyledSpace(10)] _DrynessSpace( "[ Dryness Space ]", Float ) = 1
		_DrynessMultiValue( "Dryness Multi Mask", Range( 0, 1 ) ) = 1
		_DrynessLumaValue( "Dryness Luma Mask", Range( 0, 1 ) ) = 1
		[StyledRemapSlider] _DrynessLumaRemap( "Dryness Luma Mask", Vector ) = ( 0, 1, 0, 0 )
		_DrynessMeshValue( "Dryness Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _DrynessMeshMode( "Dryness Mesh Mask", Float ) = 3
		[StyledRemapSlider] _DrynessMeshRemap( "Dryness Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _DrynessBlendRemap( "Dryness Blend Mask", Vector ) = ( 0.1, 0.2, 0, 0 )
		[Space(10)][StyledToggle] _DrynessElementMode( "Use Atmo Elements", Float ) = 0
		[StyledSpace(10)] _DrynessEnd( "[ Dryness End ]", Float ) = 1
		_FlattenBakeMode( "_FlattenBakeMode", Float ) = 0
		[HideInInspector] _RenderNormal( "_RenderNormal", Float ) = 0
		[StyledCategory(Overlay Settings, true, Use the Overlay feature add snow for seasons or sand for desert scenaries with Glitter support.NEWNEWUse the Baking option to keep the feature dynamic on impostors or preMINbake it to textures OPAwhen availableCPA., _OverlayIntensityValue, 98C8FF, 0, 10)] _OverlayCategory( "[ Overlay Category ]", Float ) = 0
		_OverlayIntensityValue( "Overlay Intensity", Range( 0, 1 ) ) = 0
		[Enum(Off,0,Bake Settings To Textures,1)] _OverlayBakeMode( "Overlay Baking", Float ) = 0
		[Enum(Off,0,On,1)] _OverlayTextureMode( "Overlay Maps", Float ) = 0
		[Space(10)][StyledTextureSingleLine(Albedo RGB)] _OverlayAlbedoTex( "Overlay Albedo", 2D ) = "white" {}
		[StyledTextureSingleLine(NormalXY AG)] _OverlayNormalTex( "Overlay Normal", 2D ) = "linearGrey" {}
		[Enum(Planar,0,Triplanar,1,Stochastic,2,Stochastic Triplanar,3)][Space(10)] _OverlaySampleMode( "Overlay Sampling", Float ) = 0
		[Enum(Tilling And Offset,0,Scale And Offset,1)] _OverlayCoordMode( "Overlay UV Mode", Float ) = 0
		[StyledVector(9)] _OverlayCoordValue( "Overlay UV Value", Vector ) = ( 1, 1, 0, 0 )
		[HDR][Gamma] _OverlayColor( "Overlay Color", Color ) = ( 0.5686275, 0.6666667, 0.7607843, 1 )
		_OverlayNormalValue( "Overlay Normal", Range( -8, 8 ) ) = 1
		_OverlaySubsurfaceValue( "Overlay Subsurface", Range( 0, 1 ) ) = 0.5
		_OverlaySmoothnessValue( "Overlay Smoothness", Range( 0, 1 ) ) = 0.5
		[NoScaleOffset][Space(10)][StyledTextureSingleLine(Glitter R)] _OverlayGlitterTexRT( "Overlay Glitter RT", 2D ) = "black" {}
		[Space(10)] _OverlayGlitterIntensityValue( "Overlay Glitter Intensity", Range( 0, 1 ) ) = 0
		[HDR] _OverlayGlitterColor( "Overlay Glitter Color", Color ) = ( 0.7215686, 1.913725, 2.996078, 1 )
		_OverlayGlitterTillingValue( "Overlay Glitter Tilling", Range( 0, 8 ) ) = 4
		_OverlayGlitterDistValue( "Overlay Glitter Limit", Range( 0, 200 ) ) = 100
		_OverlayGlitterAttenValue( "Overlay Glitter Atten Mask", Range( 0, 1 ) ) = 0
		[StyledSpace(10)] _OverlaySpace( "[ Overlay Space ]", Float ) = 1
		_OverlayLumaValue( "Overlay Luma Mask", Range( 0, 1 ) ) = 1
		[StyledRemapSlider] _OverlayLumaRemap( "Overlay Luma Mask", Vector ) = ( 0, 1, 0, 0 )
		_OverlayProjValue( "Overlay ProjY Mask", Range( 0, 1 ) ) = 0.5
		[StyledRemapSlider] _OverlayProjRemap( "Overlay ProjY Mask", Vector ) = ( 0, 1, 0, 0 )
		_OverlayMeshValue( "Overlay Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _OverlayMeshMode( "Overlay Mesh Mask", Float ) = 1
		[StyledRemapSlider] _OverlayMeshRemap( "Overlay Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _OverlayBlendRemap( "Overlay Blend Mask", Vector ) = ( 0.1, 0.2, 0, 0 )
		[Space(10)][StyledToggle] _OverlayElementMode( "Use Atmo Elements", Float ) = 0
		[HideInInspector] _overlay_coord_value( "_overlay_coord_value", Vector ) = ( 1, 1, 0, 0 )
		[StyledSpace(10)] _OverlayEnd( "[ Overlay End ]", Float ) = 1
		[StyledCategory(Wetness Settings, true, Use the Wetnees feature to add simple wetness__ puddles and rainfall effects to the objects. Please note__ the Puddle feature is using the combined Base Mask OPAheight maskCPA from the previous passes stored in the Shader textures blue channelEXCNEWNEWUse the Baking option to keep the feature dynamic on impostors or preMINbake it to textures OPAwhen availableCPA., _WetnessIntensityValue, 00DB96, 0, 10)] _WetnessCategory( "[ Wetness Category ]", Float ) = 0
		_WetnessIntensityValue( "Wetness Intensity", Range( 0, 1 ) ) = 0
		[Enum(Off,0,Bake Settings To Textures,1)] _WetnessBakeMode( "Wetness Baking", Float ) = 0
		_WetnessContrastValue( "Wetness Contrast", Range( 0, 1 ) ) = 0.2
		_WetnessSmoothnessValue( "Wetness Smoothness", Range( 0, 1 ) ) = 0.8
		[Space(10)] _WetnessWaterIntensityValue( "Wetness Puddle Intensity", Range( 0, 1 ) ) = 0
		[HDR][Gamma] _WetnessWaterColor( "Wetness Puddle Color", Color ) = ( 0.5420078, 0.7924528, 0.6068289, 1 )
		_WetnessWaterSmoothnessValue( "Wetness Puddle Smoothness", Range( 0, 1 ) ) = 1
		_WetnessWaterBaseValue( "Wetness Puddle Base Mask", Range( 0, 1 ) ) = 1
		[StyledRemapSlider] _WetnessWaterBlendRemap( "Wetness Puddle Blend Mask", Vector ) = ( 0.1, 0.2, 0, 0 )
		[Space(10)] _WetnessRainIntensityValue( "Wetness Rainfall Intensity", Range( 0, 1 ) ) = 0
		[StyledSpace(10)] _WetnessEnd( "[ Wetness End ]", Float ) = 1
		[StyledCategory(Cutout Settings, true, Use the Cutout feature to cut the alpha of the objects or terrains. The most common usage is to create seasons__ fade out objects__ or cut dynamic holes on terrains OPAvisual onlyCPA.NEWNEWUse the Baking option to keep the feature dynamic on impostors or preMINbake it to textures OPAwhen availableCPA., _CutoutIntensityValue, FFBBBA, 0, 10)] _CutoutCategory( "[ Cutout Category ]", Float ) = 0
		_CutoutIntensityValue( "Cutout Intensity", Range( 0, 1 ) ) = 0
		[Enum(Off,0,Bake Settings To Textures,1)] _CutoutBakeMode( "Cutout Baking", Float ) = 0
		_CutoutAlphaValue( "Cutout Alpha Mask", Range( 0, 1 ) ) = 0
		_CutoutMeshValue( "Cutout Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _CutoutMeshMode( "Cutout Mesh Mask", Float ) = 0
		[StyledRemapSlider] _CutoutMeshRemap( "Cutout Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		_CutoutNoiseValue( "Cutout Noise Mask", Range( 0, 1 ) ) = 1
		_CutoutNoiseTillingValue( "Cutout Noise Tilling", Range( 0, 100 ) ) = 50
		[StyledSpace(10)] _CutoutSpace( "[ Cutout Space ]", Float ) = 1
		_CutoutMultiValue( "Cutout Multi Mask", Range( 0, 1 ) ) = 1
		[Space(10)][StyledToggle] _CutoutElementMode( "Use Paint Elements", Float ) = 0
		[HideInInspector][NoScaleOffset] _NoiseTex3D( "Noise Mask 3D", 3D ) = "white" {}
		[StyledSpace(10)] _CutoutEnd( "[ Cutout End ]", Float ) = 1
		_SecondBakeMode( "_SecondBakeMode", Float ) = 0
		_ThirdBakeMode( "_ThirdBakeMode", Float ) = 0
		_DualColorBakeMode( "_DualColorBakeMode", Float ) = 0
		_OcclusionBakeMode( "_OcclusionBakeMode", Float ) = 0
		_GradientBakeMode( "_GradientBakeMode", Float ) = 0
		_CutoutBakeMode( "_CutoutBakeMode", Float ) = 0
		_TintingBakeMode( "_TintingBakeMode", Float ) = 0
		_DrynessBakeMode( "_DrynessBakeMode", Float ) = 0
		_OverlayBakeMode( "_OverlayBakeMode", Float ) = 0
		_WetnessBakeMode( "_WetnessBakeMode", Float ) = 0
		[HideInInspector] _RenderCull( "_RenderCull", Float ) = 0

	}

	SubShader
	{
		Tags { "RenderType"="Opaque" }
	LOD 100
		CGINCLUDE
		#pragma target 4.5
		ENDCG
		Cull [_RenderCull]
		

		Pass
		{
			Name "Unlit"
			CGPROGRAM
			#define ASE_VERSION 19908
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#pragma multi_compile_fwdbase
			#include "UnityShaderVariables.cginc"
			#include "AutoLight.cginc"
			#define ASE_NEEDS_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES3
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_SHADOWS
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES2
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES3
			#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
			#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
			#pragma shader_feature_local_fragment TVE_CLIPPING
			#pragma shader_feature_local_fragment TVE_SECOND
			#pragma shader_feature_local_fragment TVE_SECOND_SAMPLE_MAIN_UV TVE_SECOND_SAMPLE_EXTRA_UV TVE_SECOND_SAMPLE_PLANAR_2D TVE_SECOND_SAMPLE_PLANAR_3D TVE_SECOND_SAMPLE_STOCHASTIC_2D TVE_SECOND_SAMPLE_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SECOND_MASK
			#pragma shader_feature_local_fragment TVE_SECOND_MASK_SAMPLE_MAIN_UV TVE_SECOND_MASK_SAMPLE_EXTRA_UV TVE_SECOND_MASK_SAMPLE_PLANAR_2D TVE_SECOND_MASK_SAMPLE_PLANAR_3D
			#pragma shader_feature_local_fragment TVE_THIRD
			#pragma shader_feature_local_fragment TVE_THIRD_SAMPLE_MAIN_UV TVE_THIRD_SAMPLE_EXTRA_UV TVE_THIRD_SAMPLE_PLANAR_2D TVE_THIRD_SAMPLE_PLANAR_3D TVE_THIRD_SAMPLE_STOCHASTIC_2D TVE_THIRD_SAMPLE_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_THIRD_MASK
			#pragma shader_feature_local_fragment TVE_THIRD_MASK_SAMPLE_MAIN_UV TVE_THIRD_MASK_SAMPLE_EXTRA_UV TVE_THIRD_MASK_SAMPLE_PLANAR_2D TVE_THIRD_MASK_SAMPLE_PLANAR_3D
			#pragma shader_feature_local_fragment TVE_OCCLUSION
			#pragma shader_feature_local_fragment TVE_DUAL_COLOR
			#pragma shader_feature_local_fragment TVE_GRADIENT
			#pragma shader_feature_local_fragment TVE_TINTING
			#pragma shader_feature_local_fragment TVE_DRYNESS
			#pragma shader_feature_local_fragment TVE_OVERLAY
			#pragma shader_feature_local_fragment TVE_OVERLAY_TEX
			#pragma shader_feature_local_fragment TVE_OVERLAY_SAMPLE_PLANAR_2D TVE_OVERLAY_SAMPLE_PLANAR_3D TVE_OVERLAY_SAMPLE_STOCHASTIC_2D TVE_OVERLAY_SAMPLE_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_OVERLAY_GLITTER
			#pragma shader_feature_local_fragment TVE_WETNESS
			#pragma shader_feature_local_fragment TVE_WETNESS_WATER
			#pragma shader_feature_local_fragment TVE_CUTOUT
			#pragma shader_feature_local_fragment TVE_EMISSIVE
			#pragma shader_feature_local_fragment TVE_EMISSIVE_SAMPLE_MAIN_UV TVE_EMISSIVE_SAMPLE_EXTRA_UV
			#pragma shader_feature_local_vertex TVE_FLATTEN
			#if defined (TVE_CLIPPING) //Render Clip
				#define TVE_ALPHA_CLIP //Render Clip
			#endif //Render Clip
			#if defined (TVE_CUTOUT) //Cutout
				#define TVE_ALPHA_CLIP //Cutout
			#endif //Cutout
			  
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
			#define SAMPLE_TEXTURE3D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
			#else//ASE Sampling Macros
			#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
			#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
			#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
			#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
			#define SAMPLE_TEXTURE3D(tex,samplerTex,coord) tex3D(tex,coord)
			#endif//ASE Sampling Macros
			


			struct appdata
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord3 : TEXCOORD3;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;
			};

			struct v2f
			{
				UNITY_POSITION(pos);
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_color : COLOR;
				UNITY_SHADOW_COORDS(7)
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_texcoord11 : TEXCOORD11;
				float4 ase_texcoord12 : TEXCOORD12;
				float4 ase_texcoord13 : TEXCOORD13;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
			};

			uniform half _RenderCull;
			uniform half _RenderNormal;
			uniform half _IsVersion;
			uniform half _MainCategory;
			uniform half _MainEnd;
			uniform half _MainSampleMode;
			uniform half _MainCoordMode;
			uniform half4 _MainCoordValue;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_MainAlbedoTex);
			SamplerState sampler_Linear_Repeat_Aniso8;
			SamplerState sampler_Point_Repeat;
			SamplerState sampler_Linear_Repeat;
			uniform half4 _main_coord_value;
			uniform float3 TVE_WorldOrigin;
			uniform half _ObjectPhaseMode;
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
			uniform half _SecondCategory;
			uniform half _SecondEnd;
			uniform half _SecondSpace0;
			uniform half _SecondBakeMode;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondAlbedoTex);
			uniform half4 _second_coord_value;
			uniform half _SecondSampleMode;
			uniform half _SecondCoordMode;
			uniform half4 _SecondCoordValue;
			uniform half _SecondAlbedoValue;
			uniform half4 _SecondColor;
			uniform half _SecondBlendAlbedoValue;
			uniform half _SecondIntensityValue;
			uniform half _SecondMaskMode;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondMaskTex);
			uniform half4 _second_mask_coord_value;
			uniform half _SecondMaskSampleMode;
			uniform half _SecondMaskCoordMode;
			uniform half4 _SecondMaskCoordValue;
			uniform half4 _SecondMaskRemap;
			uniform half _SecondMaskValue;
			uniform half4 _SecondBaseRemap;
			uniform half _SecondBaseValue;
			uniform half4 _SecondLumaRemap;
			uniform half _SecondLumaValue;
			uniform half _SecondMeshMode;
			uniform half4 _SecondMeshRemap;
			uniform half _SecondMeshValue;
			uniform half4 _SecondProjRemap;
			uniform half _SecondProjValue;
			uniform half4 _SecondBlendRemap;
			uniform half _SecondBlendIntensityValue;
			uniform half _SecondBlendNormalValue;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondNormalTex);
			uniform half _SecondNormalValue;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondShaderTex);
			uniform half _SecondMetallicValue;
			uniform half4 _SecondOcclusionRemap;
			uniform half _SecondOcclusionValue;
			uniform half4 _SecondSmoothnessRemap;
			uniform half _SecondSmoothnessValue;
			uniform half _SecondBlendShaderValue;
			uniform half4 _SecondMultiRemap;
			uniform half _SecondAlphaClipValue;
			uniform half _ThirdCategory;
			uniform half _ThirdEnd;
			uniform half _ThirdSpace0;
			uniform half _ThirdBakeMode;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_ThirdAlbedoTex);
			uniform half4 _third_coord_value;
			uniform half _ThirdSampleMode;
			uniform half _ThirdCoordMode;
			uniform half4 _ThirdCoordValue;
			uniform half _ThirdAlbedoValue;
			uniform half3 _ThirdColorTwo;
			uniform half3 _ThirdColor;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_ThirdShaderTex);
			uniform half4 _ThirdMultiRemap;
			uniform half _ThirdMultiValue;
			uniform half _ThirdColorMode;
			uniform half _ThirdBlendAlbedoValue;
			uniform half _ThirdIntensityValue;
			uniform half _ThirdMaskMode;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_ThirdMaskTex);
			uniform half4 _third_mask_coord_value;
			uniform half _ThirdMaskSampleMode;
			uniform half _ThirdMaskCoordMode;
			uniform half4 _ThirdMaskCoordValue;
			uniform half4 _ThirdMaskRemap;
			uniform half _ThirdMaskValue;
			uniform half4 _ThirdBaseRemap;
			uniform half _ThirdBaseValue;
			uniform half4 _ThirdLumaRemap;
			uniform half _ThirdLumaValue;
			uniform half _ThirdMeshMode;
			uniform half4 _ThirdMeshRemap;
			uniform half _ThirdMeshValue;
			uniform half4 _ThirdProjRemap;
			uniform half _ThirdProjValue;
			uniform half4 _ThirdBlendRemap;
			uniform half _ThirdBlendIntensityValue;
			uniform half _ThirdBlendNormalValue;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_ThirdNormalTex);
			uniform half _ThirdNormalValue;
			uniform half _ThirdMetallicValue;
			uniform half4 _ThirdOcclusionRemap;
			uniform half _ThirdOcclusionValue;
			uniform half4 _ThirdSmoothnessRemap;
			uniform half _ThirdSmoothnessValue;
			uniform half _ThirdBlendShaderValue;
			uniform half _ThirdAlphaClipValue;
			uniform half _OcclusionCategory;
			uniform half _OcclusionEnd;
			uniform half _OcclusionBakeMode;
			uniform half4 _OcclusionColorTwo;
			uniform half4 _OcclusionColorOne;
			uniform half _OcclusionColorMeshMode;
			uniform half4 _OcclusionColorMeshRemap;
			uniform half _OcclusionIntensityValue;
			uniform half _DualColorCategory;
			uniform half _DualColorEnd;
			uniform half _DualColorBakeMode;
			uniform half4 _DualColorTwo;
			uniform half4 _DualColorOne;
			uniform half _DualColorGrayValue;
			uniform half _DualColorBlendAlbedoValue;
			uniform half _DualColorIntensityValue;
			uniform half _GradientCategory;
			uniform half _GradientEnd;
			uniform half _GradientBakeMode;
			uniform half4 _GradientColorTwo;
			uniform half4 _GradientColorOne;
			uniform half _GradientColorMeshMode;
			uniform half4 _GradientColorMeshRemap;
			uniform half _GradientGrayValue;
			uniform half _GradientIntensityValue;
			uniform half _GradientMultiValue;
			uniform half _TintingCategory;
			uniform half _TintingEnd;
			uniform half _TintingSpace;
			uniform half _TintingBakeMode;
			uniform half _TintingGrayValue;
			uniform float4 _TintingColor;
			uniform half _TintingIntensityValue;
			uniform half _TintingMultiValue;
			uniform half4 _TintingLumaRemap;
			uniform half _TintingLumaValue;
			uniform half _TintingMeshMode;
			uniform half4 _TintingMeshRemap;
			uniform half _TintingMeshValue;
			uniform half4 _TintingBlendRemap;
			uniform half TVE_IsEnabled;
			uniform half _DrynessCategory;
			uniform half _DrynessEnd;
			uniform half _DrynessSpace;
			uniform half _DrynessBakeMode;
			uniform half _DrynessGrayValue;
			uniform float4 _DrynessColor;
			uniform half _DrynessIntensityValue;
			uniform half _DrynessMultiValue;
			uniform half4 _DrynessLumaRemap;
			uniform half _DrynessLumaValue;
			uniform half _DrynessMeshMode;
			uniform half4 _DrynessMeshRemap;
			uniform half _DrynessMeshValue;
			uniform half4 _DrynessBlendRemap;
			uniform half _DrynessSmoothnessValue;
			uniform half _DrynessSubsurfaceValue;
			uniform half _OverlayCategory;
			uniform half _OverlayEnd;
			uniform half _OverlaySpace;
			uniform half _OverlayBakeMode;
			uniform half4 _OverlayColor;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_OverlayAlbedoTex);
			uniform half4 _overlay_coord_value;
			uniform half _OverlaySampleMode;
			uniform half _OverlayCoordMode;
			uniform half4 _OverlayCoordValue;
			uniform half _OverlayTextureMode;
			uniform half _OverlayGlitterIntensityValue;
			uniform half4 _OverlayGlitterColor;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_OverlayGlitterTexRT);
			uniform half _OverlayGlitterTillingValue;
			uniform half _OverlayGlitterAttenValue;
			uniform half _OverlayGlitterDistValue;
			uniform half4 _OverlayLumaRemap;
			uniform half _OverlayLumaValue;
			uniform half _OverlayMeshMode;
			uniform half4 _OverlayMeshRemap;
			uniform half _OverlayMeshValue;
			uniform half4 _OverlayProjRemap;
			uniform half _OverlayProjValue;
			uniform half _OverlayIntensityValue;
			uniform half4 _OverlayBlendRemap;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_OverlayNormalTex);
			uniform half _OverlayNormalValue;
			uniform half _OverlaySmoothnessValue;
			uniform half _OverlaySubsurfaceValue;
			uniform half _WetnessCategory;
			uniform half _WetnessEnd;
			uniform half _WetnessBakeMode;
			uniform half4 _WetnessWaterColor;
			uniform half _WetnessWaterIntensityValue;
			uniform half _WetnessIntensityValue;
			uniform half _WetnessRainIntensityValue;
			uniform half _WetnessWaterBaseValue;
			uniform half4 _WetnessWaterBlendRemap;
			uniform half _WetnessContrastValue;
			uniform half _WetnessSmoothnessValue;
			uniform half _WetnessWaterSmoothnessValue;
			uniform half _CutoutCategory;
			uniform half _CutoutEnd;
			uniform half _CutoutSpace;
			uniform half _CutoutBakeMode;
			uniform half _CutoutIntensityValue;
			uniform half _CutoutAlphaValue;
			uniform half _CutoutMeshMode;
			uniform half4 _CutoutMeshRemap;
			uniform half _CutoutMeshValue;
			UNITY_DECLARE_TEX3D_NOSAMPLER(_NoiseTex3D);
			uniform half _CutoutNoiseTillingValue;
			uniform half _CutoutNoiseValue;
			uniform half _CutoutMultiValue;
			uniform half _EmissiveCategory;
			uniform half _EmissiveEnd;
			uniform half _EmissivePowerMode;
			uniform half _EmissivePowerValue;
			uniform half _EmissiveFlagMode;
			uniform half4 _EmissiveColor;
			uniform half _EmissiveColorMode;
			uniform half _EmissiveIntensityValue;
			uniform half _EmissiveMeshMode;
			uniform half4 _EmissiveMeshRemap;
			uniform half _EmissiveMeshValue;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_EmissiveMaskTex);
			uniform half4 _emissive_coord_value;
			uniform half _EmissiveSampleMode;
			uniform half _EmissiveCoordMode;
			uniform half4 _EmissiveCoordValue;
			uniform half4 _EmissiveMaskRemap;
			uniform half _EmissiveMaskValue;
			uniform half4 _EmissiveBlendRemap;
			uniform float _emissive_power_value;
			uniform half3 _render_normal;
			uniform half _ObjectCategory;
			uniform half _ObjectEnd;
			uniform half _ObjectModelMode;
			uniform half _ObjectPivotMode;
			uniform half _ObjectHeightValue;
			uniform half _ObjectRadiusValue;
			uniform half _FlattenCategory;
			uniform half _FlattenEnd;
			uniform half _FlattenBakeMode;
			uniform half _FlattenIntensityValue;
			uniform half3 _FlattenSphereOffsetValue;
			uniform half _FlattenSphereValue;
			uniform half _FlattenMeshMode;
			uniform half4 _FlattenMeshRemap;
			uniform half _FlattenMeshValue;
			uniform half _EmissiveElementMode;
			uniform half _SecondElementMode;
			uniform half _ThirdElementMode;
			uniform half _TintingElementMode;
			uniform half _OverlayElementMode;
			uniform half _DrynessElementMode;
			uniform half _CutoutElementMode;
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
			
			half3 LinearToGammaFloatFast( half3 linRGB )
			{
				return max(1.055h * pow(abs(linRGB), 0.416666667h) - 0.055h, 0.h);
			}
			
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
			
			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			


			v2f vert(appdata v )
			{
				v2f o = (v2f)0;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
				float3 temp_output_104_7_g76826 = ase_positionWS;
				float3 vertexToFrag73_g76826 = temp_output_104_7_g76826;
				o.ase_texcoord.xyz = vertexToFrag73_g76826;
				float4x4 break19_g128385 = unity_ObjectToWorld;
				float3 appendResult20_g128385 = (float3(break19_g128385[ 0 ][ 3 ] , break19_g128385[ 1 ][ 3 ] , break19_g128385[ 2 ][ 3 ]));
				float3 temp_output_340_7_g76826 = appendResult20_g128385;
				float4x4 break19_g128399 = unity_ObjectToWorld;
				float3 appendResult20_g128399 = (float3(break19_g128399[ 0 ][ 3 ] , break19_g128399[ 1 ][ 3 ] , break19_g128399[ 2 ][ 3 ]));
				float3 _Vector0 = float3(0,0,0);
				float3 appendResult60_g128353 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
				float3 PositionOS131_g76826 = v.vertex.xyz;
				float3 break233_g76826 = PositionOS131_g76826;
				float3 appendResult234_g76826 = (float3(break233_g76826.x , 0.0 , break233_g76826.z));
				float3 break413_g76826 = PositionOS131_g76826;
				float3 appendResult414_g76826 = (float3(break413_g76826.x , break413_g76826.y , 0.0));
				#ifdef TVE_COORD_ZUP
				float3 staticSwitch65_g128401 = appendResult414_g76826;
				#else
				float3 staticSwitch65_g128401 = appendResult234_g76826;
				#endif
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch229_g76826 = _Vector0;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch229_g76826 = appendResult60_g128353;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch229_g76826 = staticSwitch65_g128401;
				#else
				float3 staticSwitch229_g76826 = _Vector0;
				#endif
				float3 PivotOS149_g76826 = staticSwitch229_g76826;
				float3 temp_output_122_0_g128399 = PivotOS149_g76826;
				float3 PivotsOnlyWS105_g128399 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g128399 , 0.0 ) ).xyz;
				float3 temp_output_341_7_g76826 = ( appendResult20_g128399 + PivotsOnlyWS105_g128399 );
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch236_g76826 = temp_output_340_7_g76826;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch236_g76826 = temp_output_341_7_g76826;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch236_g76826 = temp_output_341_7_g76826;
				#else
				float3 staticSwitch236_g76826 = temp_output_340_7_g76826;
				#endif
				float3 vertexToFrag76_g76826 = staticSwitch236_g76826;
				o.ase_texcoord1.xyz = vertexToFrag76_g76826;
				float3 ase_normalWS = UnityObjectToWorldNormal( v.ase_normal );
				o.ase_texcoord2.xyz = ase_normalWS;
				float3 ase_tangentWS = UnityObjectToWorldDir( v.ase_tangent );
				o.ase_texcoord3.xyz = ase_tangentWS;
				float ase_tangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
				o.ase_texcoord4.xyz = ase_bitangentWS;
				o.ase_texcoord8.xyz = ase_positionWS;
				
				float localIfModelData25_g252282 = ( 0.0 );
				TVEModelData Data25_g252282 = (TVEModelData)0;
				TVEModelData Data16_g128410 =(TVEModelData)0;
				half Dummy207_g76826 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
				float temp_output_14_0_g128410 = Dummy207_g76826;
				float In_Dummy16_g128410 = temp_output_14_0_g128410;
				float3 temp_output_4_0_g128410 = PositionOS131_g76826;
				float3 In_PositionOS16_g128410 = temp_output_4_0_g128410;
				float3 PositionWS122_g76826 = vertexToFrag73_g76826;
				float3 In_PositionWS16_g128410 = PositionWS122_g76826;
				float3 PivotWS121_g76826 = vertexToFrag76_g76826;
				#ifdef TVE_SCOPE_DYNAMIC
				float3 staticSwitch204_g76826 = ( PositionWS122_g76826 - PivotWS121_g76826 );
				#else
				float3 staticSwitch204_g76826 = PositionWS122_g76826;
				#endif
				float3 PositionWO132_g76826 = ( staticSwitch204_g76826 - TVE_WorldOrigin );
				float3 In_PositionWO16_g128410 = PositionWO132_g76826;
				float3 In_PositionRawOS16_g128410 = PositionOS131_g76826;
				float3 In_PivotOS16_g128410 = PivotOS149_g76826;
				float3 In_PivotWS16_g128410 = PivotWS121_g76826;
				float3 PivotWO133_g76826 = ( PivotWS121_g76826 - TVE_WorldOrigin );
				float3 In_PivotWO16_g128410 = PivotWO133_g76826;
				half3 NormalOS134_g76826 = v.ase_normal;
				float3 temp_output_21_0_g128410 = NormalOS134_g76826;
				float3 In_NormalOS16_g128410 = temp_output_21_0_g128410;
				float3 normalizedWorldNormal = normalize( ase_normalWS );
				half3 NormalWS95_g76826 = normalizedWorldNormal;
				float3 In_NormalWS16_g128410 = NormalWS95_g76826;
				float3 In_NormalRawOS16_g128410 = NormalOS134_g76826;
				half4 TangentlOS153_g76826 = v.ase_tangent;
				float4 temp_output_6_0_g128410 = TangentlOS153_g76826;
				float4 In_TangentOS16_g128410 = temp_output_6_0_g128410;
				half3 TangentWS136_g76826 = ase_tangentWS;
				float3 In_TangentWS16_g128410 = TangentWS136_g76826;
				half3 BiangentWS421_g76826 = ase_bitangentWS;
				float3 In_BitangentWS16_g128410 = BiangentWS421_g76826;
				float3 normalizeResult296_g76826 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g76826 ) );
				half3 ViewDirWS169_g76826 = normalizeResult296_g76826;
				float3 In_ViewDirWS16_g128410 = ViewDirWS169_g76826;
				float4 appendResult397_g76826 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
				float4 CoordsData398_g76826 = appendResult397_g76826;
				float4 In_CoordsData16_g128410 = CoordsData398_g76826;
				half4 VertexMasks171_g76826 = v.ase_color;
				float4 In_VertexData16_g128410 = VertexMasks171_g76826;
				#ifdef TVE_COORD_ZUP
				float staticSwitch65_g128416 = (PositionOS131_g76826).z;
				#else
				float staticSwitch65_g128416 = (PositionOS131_g76826).y;
				#endif
				half Object_HeightValue267_g76826 = _ObjectHeightValue;
				half Bounds_HeightMask274_g76826 = saturate( ( staticSwitch65_g128416 / Object_HeightValue267_g76826 ) );
				half3 Position387_g76826 = PositionOS131_g76826;
				half Height387_g76826 = Object_HeightValue267_g76826;
				half Object_RadiusValue268_g76826 = _ObjectRadiusValue;
				half Radius387_g76826 = Object_RadiusValue268_g76826;
				half localCapsuleMaskYUp387_g76826 = CapsuleMaskYUp( Position387_g76826 , Height387_g76826 , Radius387_g76826 );
				half3 Position408_g76826 = PositionOS131_g76826;
				half Height408_g76826 = Object_HeightValue267_g76826;
				half Radius408_g76826 = Object_RadiusValue268_g76826;
				half localCapsuleMaskZUp408_g76826 = CapsuleMaskZUp( Position408_g76826 , Height408_g76826 , Radius408_g76826 );
				#ifdef TVE_COORD_ZUP
				float staticSwitch65_g128423 = saturate( localCapsuleMaskZUp408_g76826 );
				#else
				float staticSwitch65_g128423 = saturate( localCapsuleMaskYUp387_g76826 );
				#endif
				half Bounds_SphereMask282_g76826 = staticSwitch65_g128423;
				float4 appendResult253_g76826 = (float4(Bounds_HeightMask274_g76826 , Bounds_SphereMask282_g76826 , 1.0 , 1.0));
				half4 MasksData254_g76826 = appendResult253_g76826;
				float4 In_MasksData16_g128410 = MasksData254_g76826;
				float temp_output_17_0_g128415 = _ObjectPhaseMode;
				float Option70_g128415 = temp_output_17_0_g128415;
				float4 temp_output_3_0_g128415 = v.ase_color;
				float4 Channel70_g128415 = temp_output_3_0_g128415;
				float localSwitchChannel470_g128415 = SwitchChannel4( Option70_g128415 , Channel70_g128415 );
				half Phase_Value372_g76826 = localSwitchChannel470_g128415;
				float3 break319_g76826 = PivotWO133_g76826;
				half Pivot_Position322_g76826 = ( break319_g76826.x + break319_g76826.z );
				half Phase_Position357_g76826 = ( Phase_Value372_g76826 + Pivot_Position322_g76826 );
				float temp_output_248_0_g76826 = frac( Phase_Position357_g76826 );
				float4 appendResult177_g76826 = (float4(( (frac( ( Phase_Position357_g76826 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g76826));
				half4 Phase_Data176_g76826 = appendResult177_g76826;
				float4 In_PhaseData16_g128410 = Phase_Data176_g76826;
				float4 In_TransformData16_g128410 = half4( 0, 0, 0, 1 );
				float4 In_RotationData16_g128410 = float4( 0,0,0,0 );
				float4 In_InterpolatorA16_g128410 = float4( 0,0,0,0 );
				BuildModelVertData( Data16_g128410 , In_Dummy16_g128410 , In_PositionOS16_g128410 , In_PositionWS16_g128410 , In_PositionWO16_g128410 , In_PositionRawOS16_g128410 , In_PivotOS16_g128410 , In_PivotWS16_g128410 , In_PivotWO16_g128410 , In_NormalOS16_g128410 , In_NormalWS16_g128410 , In_NormalRawOS16_g128410 , In_TangentOS16_g128410 , In_TangentWS16_g128410 , In_BitangentWS16_g128410 , In_ViewDirWS16_g128410 , In_CoordsData16_g128410 , In_VertexData16_g128410 , In_MasksData16_g128410 , In_PhaseData16_g128410 , In_TransformData16_g128410 , In_RotationData16_g128410 , In_InterpolatorA16_g128410 );
				TVEModelData DataA25_g252282 = Data16_g128410;
				TVEModelData Data15_g252243 =(TVEModelData)Data16_g128410;
				float Out_Dummy15_g252243 = 0.0;
				float3 Out_PositionOS15_g252243 = float3( 0,0,0 );
				float3 Out_PositionWS15_g252243 = float3( 0,0,0 );
				float3 Out_PositionWO15_g252243 = float3( 0,0,0 );
				float3 Out_PositionRawOS15_g252243 = float3( 0,0,0 );
				float3 Out_PivotOS15_g252243 = float3( 0,0,0 );
				float3 Out_PivotWS15_g252243 = float3( 0,0,0 );
				float3 Out_PivotWO15_g252243 = float3( 0,0,0 );
				float3 Out_NormalOS15_g252243 = float3( 0,0,0 );
				float3 Out_NormalWS15_g252243 = float3( 0,0,0 );
				float3 Out_NormalRawOS15_g252243 = float3( 0,0,0 );
				float4 Out_TangentOS15_g252243 = float4( 0,0,0,0 );
				float3 Out_TangentWS15_g252243 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g252243 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g252243 = float3( 0,0,0 );
				float4 Out_CoordsData15_g252243 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g252243 = float4( 0,0,0,0 );
				float4 Out_MasksData15_g252243 = float4( 0,0,0,0 );
				float4 Out_PhaseData15_g252243 = float4( 0,0,0,0 );
				float4 Out_TransformData15_g252243 = float4( 0,0,0,0 );
				float4 Out_RotationData15_g252243 = float4( 0,0,0,0 );
				float4 Out_InterpolatorA15_g252243 = float4( 0,0,0,0 );
				BreakModelVertData( Data15_g252243 , Out_Dummy15_g252243 , Out_PositionOS15_g252243 , Out_PositionWS15_g252243 , Out_PositionWO15_g252243 , Out_PositionRawOS15_g252243 , Out_PivotOS15_g252243 , Out_PivotWS15_g252243 , Out_PivotWO15_g252243 , Out_NormalOS15_g252243 , Out_NormalWS15_g252243 , Out_NormalRawOS15_g252243 , Out_TangentOS15_g252243 , Out_TangentWS15_g252243 , Out_BitangentWS15_g252243 , Out_ViewDirWS15_g252243 , Out_CoordsData15_g252243 , Out_VertexData15_g252243 , Out_MasksData15_g252243 , Out_PhaseData15_g252243 , Out_TransformData15_g252243 , Out_RotationData15_g252243 , Out_InterpolatorA15_g252243 );
				TVEModelData Data16_g252245 =(TVEModelData)Data15_g252243;
				half Dummy1823_g252242 = ( _FlattenCategory + _FlattenEnd + _FlattenBakeMode );
				float temp_output_14_0_g252245 = Dummy1823_g252242;
				float In_Dummy16_g252245 = temp_output_14_0_g252245;
				float3 temp_output_4_0_g252245 = Out_PositionOS15_g252243;
				float3 In_PositionOS16_g252245 = temp_output_4_0_g252245;
				float3 In_PositionWS16_g252245 = Out_PositionWS15_g252243;
				float3 In_PositionWO16_g252245 = Out_PositionWO15_g252243;
				float3 temp_output_1810_26_g252242 = Out_PositionRawOS15_g252243;
				float3 In_PositionRawOS16_g252245 = temp_output_1810_26_g252242;
				float3 In_PivotOS16_g252245 = Out_PivotOS15_g252243;
				float3 In_PivotWS16_g252245 = Out_PivotWS15_g252243;
				float3 In_PivotWO16_g252245 = Out_PivotWO15_g252243;
				half3 Model_NormalOS1829_g252242 = Out_NormalOS15_g252243;
				#ifdef TVE_COORD_ZUP
				float3 staticSwitch65_g252244 = half3( 0, 0, 1 );
				#else
				float3 staticSwitch65_g252244 = half3( 0, 1, 0 );
				#endif
				float3 lerpResult1820_g252242 = lerp( Model_NormalOS1829_g252242 , staticSwitch65_g252244 , _FlattenIntensityValue);
				float3 Model_PositionBaseOS1837_g252242 = temp_output_1810_26_g252242;
				float3 normalizeResult1816_g252242 = ASESafeNormalize( ( Model_PositionBaseOS1837_g252242 + _FlattenSphereOffsetValue ) );
				float3 lerpResult1813_g252242 = lerp( lerpResult1820_g252242 , normalizeResult1816_g252242 , _FlattenSphereValue);
				float temp_output_17_0_g252252 = _FlattenMeshMode;
				float Option70_g252252 = temp_output_17_0_g252252;
				float4 temp_output_1810_29_g252242 = Out_VertexData15_g252243;
				half4 Model_VertexData1826_g252242 = temp_output_1810_29_g252242;
				float4 temp_output_3_0_g252252 = Model_VertexData1826_g252242;
				float4 Channel70_g252252 = temp_output_3_0_g252252;
				float localSwitchChannel470_g252252 = SwitchChannel4( Option70_g252252 , Channel70_g252252 );
				float clampResult17_g252246 = clamp( localSwitchChannel470_g252252 , 0.0001 , 0.9999 );
				float temp_output_7_0_g252247 = _FlattenMeshRemap.x;
				float temp_output_9_0_g252247 = ( clampResult17_g252246 - temp_output_7_0_g252247 );
				float lerpResult1841_g252242 = lerp( 1.0 , saturate( ( temp_output_9_0_g252247 * _FlattenMeshRemap.z ) ) , _FlattenMeshValue);
				half Normal_MeskMask1847_g252242 = lerpResult1841_g252242;
				half Normal_Mask1851_g252242 = Normal_MeskMask1847_g252242;
				float3 lerpResult1856_g252242 = lerp( Model_NormalOS1829_g252242 , lerpResult1813_g252242 , Normal_Mask1851_g252242);
				#ifdef TVE_FLATTEN
				float3 staticSwitch1857_g252242 = lerpResult1856_g252242;
				#else
				float3 staticSwitch1857_g252242 = Model_NormalOS1829_g252242;
				#endif
				half3 Final_NormalOS1853_g252242 = staticSwitch1857_g252242;
				float3 temp_output_21_0_g252245 = Final_NormalOS1853_g252242;
				float3 In_NormalOS16_g252245 = temp_output_21_0_g252245;
				float3 In_NormalWS16_g252245 = Out_NormalWS15_g252243;
				float3 In_NormalRawOS16_g252245 = Out_NormalRawOS15_g252243;
				float4 temp_output_6_0_g252245 = Out_TangentOS15_g252243;
				float4 In_TangentOS16_g252245 = temp_output_6_0_g252245;
				float3 In_TangentWS16_g252245 = Out_TangentWS15_g252243;
				float3 In_BitangentWS16_g252245 = Out_BitangentWS15_g252243;
				float3 In_ViewDirWS16_g252245 = Out_ViewDirWS15_g252243;
				float4 In_CoordsData16_g252245 = Out_CoordsData15_g252243;
				float4 In_VertexData16_g252245 = temp_output_1810_29_g252242;
				float4 In_MasksData16_g252245 = Out_MasksData15_g252243;
				float4 In_PhaseData16_g252245 = Out_PhaseData15_g252243;
				float4 In_TransformData16_g252245 = Out_TransformData15_g252243;
				float4 In_RotationData16_g252245 = Out_RotationData15_g252243;
				float4 In_InterpolatorA16_g252245 = Out_InterpolatorA15_g252243;
				BuildModelVertData( Data16_g252245 , In_Dummy16_g252245 , In_PositionOS16_g252245 , In_PositionWS16_g252245 , In_PositionWO16_g252245 , In_PositionRawOS16_g252245 , In_PivotOS16_g252245 , In_PivotWS16_g252245 , In_PivotWO16_g252245 , In_NormalOS16_g252245 , In_NormalWS16_g252245 , In_NormalRawOS16_g252245 , In_TangentOS16_g252245 , In_TangentWS16_g252245 , In_BitangentWS16_g252245 , In_ViewDirWS16_g252245 , In_CoordsData16_g252245 , In_VertexData16_g252245 , In_MasksData16_g252245 , In_PhaseData16_g252245 , In_TransformData16_g252245 , In_RotationData16_g252245 , In_InterpolatorA16_g252245 );
				TVEModelData DataB25_g252282 = Data16_g252245;
				float Alpha25_g252282 = _FlattenBakeMode;
				{
				if (Alpha25_g252282 < 0.5 )
				{
				Data25_g252282 = DataA25_g252282;
				}
				else
				{
				Data25_g252282 = DataB25_g252282;
				}
				}
				TVEModelData Data15_g252289 =(TVEModelData)Data25_g252282;
				float Out_Dummy15_g252289 = 0.0;
				float3 Out_PositionOS15_g252289 = float3( 0,0,0 );
				float3 Out_PositionWS15_g252289 = float3( 0,0,0 );
				float3 Out_PositionWO15_g252289 = float3( 0,0,0 );
				float3 Out_PositionRawOS15_g252289 = float3( 0,0,0 );
				float3 Out_PivotOS15_g252289 = float3( 0,0,0 );
				float3 Out_PivotWS15_g252289 = float3( 0,0,0 );
				float3 Out_PivotWO15_g252289 = float3( 0,0,0 );
				float3 Out_NormalOS15_g252289 = float3( 0,0,0 );
				float3 Out_NormalWS15_g252289 = float3( 0,0,0 );
				float3 Out_NormalRawOS15_g252289 = float3( 0,0,0 );
				float4 Out_TangentOS15_g252289 = float4( 0,0,0,0 );
				float3 Out_TangentWS15_g252289 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g252289 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g252289 = float3( 0,0,0 );
				float4 Out_CoordsData15_g252289 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g252289 = float4( 0,0,0,0 );
				float4 Out_MasksData15_g252289 = float4( 0,0,0,0 );
				float4 Out_PhaseData15_g252289 = float4( 0,0,0,0 );
				float4 Out_TransformData15_g252289 = float4( 0,0,0,0 );
				float4 Out_RotationData15_g252289 = float4( 0,0,0,0 );
				float4 Out_InterpolatorA15_g252289 = float4( 0,0,0,0 );
				BreakModelVertData( Data15_g252289 , Out_Dummy15_g252289 , Out_PositionOS15_g252289 , Out_PositionWS15_g252289 , Out_PositionWO15_g252289 , Out_PositionRawOS15_g252289 , Out_PivotOS15_g252289 , Out_PivotWS15_g252289 , Out_PivotWO15_g252289 , Out_NormalOS15_g252289 , Out_NormalWS15_g252289 , Out_NormalRawOS15_g252289 , Out_TangentOS15_g252289 , Out_TangentWS15_g252289 , Out_BitangentWS15_g252289 , Out_ViewDirWS15_g252289 , Out_CoordsData15_g252289 , Out_VertexData15_g252289 , Out_MasksData15_g252289 , Out_PhaseData15_g252289 , Out_TransformData15_g252289 , Out_RotationData15_g252289 , Out_InterpolatorA15_g252289 );
				float4 vertexToFrag140_g252284 = Out_TangentOS15_g252289;
				o.ase_texcoord9 = vertexToFrag140_g252284;
				o.ase_texcoord.w = ase_tangentSign;
				float3 vertexToFrag139_g252284 = Out_NormalOS15_g252289;
				o.ase_texcoord10.xyz = vertexToFrag139_g252284;
				float4 ase_positionCS = UnityObjectToClipPos( v.vertex );
				float4 screenPos = ComputeScreenPos( ase_positionCS );
				o.ase_texcoord11 = screenPos;
				
				o.ase_texcoord5.xyz = v.ase_texcoord.xyz;
				o.ase_texcoord6.xy = v.ase_texcoord2.xy;
				o.ase_color = v.ase_color;
				o.ase_texcoord12 = v.vertex;
				o.ase_texcoord13 = v.ase_texcoord3;
				o.ase_normal = v.ase_normal;
				o.ase_tangent = v.ase_tangent;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.w = 0;
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.w = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord5.w = 0;
				o.ase_texcoord6.zw = 0;
				o.ase_texcoord8.w = 0;
				o.ase_texcoord10.w = 0;

				v.vertex.xyz +=  float3(0,0,0) ;
				o.pos = UnityObjectToClipPos(v.vertex);
				return o;
			}


			void frag(v2f i , uint ase_vface : SV_IsFrontFace,
				out half4 outGBuffer0 : SV_Target0,
				out half4 outGBuffer1 : SV_Target1,
				out half4 outGBuffer2 : SV_Target2,
				out half4 outGBuffer3 : SV_Target3,
				out half4 outGBuffer4 : SV_Target4,
				out half4 outGBuffer5 : SV_Target5,
				out half4 outGBuffer6 : SV_Target6,
				out half4 outGBuffer7 : SV_Target7,
				out float outDepth : SV_Depth
			)
			{
				UNITY_SETUP_INSTANCE_ID( i );
				float localBreakVisualData4_g252285 = ( 0.0 );
				float localBuildVisualData3_g252277 = ( 0.0 );
				float localBreakVisualData4_g252256 = ( 0.0 );
				float localIfVisualData25_g252241 = ( 0.0 );
				TVEVisualData Data25_g252241 = (TVEVisualData)0;
				float localIfVisualData25_g252217 = ( 0.0 );
				TVEVisualData Data25_g252217 = (TVEVisualData)0;
				float localIfVisualData25_g252184 = ( 0.0 );
				TVEVisualData Data25_g252184 = (TVEVisualData)0;
				float localIfVisualData25_g252130 = ( 0.0 );
				TVEVisualData Data25_g252130 = (TVEVisualData)0;
				float localIfVisualData25_g252094 = ( 0.0 );
				TVEVisualData Data25_g252094 = (TVEVisualData)0;
				float localIfVisualData25_g251829 = ( 0.0 );
				TVEVisualData Data25_g251829 = (TVEVisualData)0;
				float localIfVisualData25_g251828 = ( 0.0 );
				TVEVisualData Data25_g251828 = (TVEVisualData)0;
				float localIfVisualData25_g251800 = ( 0.0 );
				TVEVisualData Data25_g251800 = (TVEVisualData)0;
				float localIfVisualData25_g251455 = ( 0.0 );
				TVEVisualData Data25_g251455 = (TVEVisualData)0;
				float localIfVisualData25_g251405 = ( 0.0 );
				TVEVisualData Data25_g251405 = (TVEVisualData)0;
				float localBuildVisualData3_g251315 = ( 0.0 );
				TVEVisualData Data3_g251315 =(TVEVisualData)0;
				half4 Dummy130_g139039 = ( _MainCategory + _MainEnd + ( _MainSampleMode + _MainCoordMode + _MainCoordValue ) );
				float temp_output_14_0_g251315 = Dummy130_g139039.x;
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
				half4 Local_Coords180_g139039 = _main_coord_value;
				float4 Coords444_g251346 = Local_Coords180_g139039;
				TVEModelData Data16_g128405 =(TVEModelData)(TVEModelData)0;
				float In_Dummy16_g128405 = 0.0;
				float3 vertexToFrag73_g76826 = i.ase_texcoord.xyz;
				float3 PositionWS122_g76826 = vertexToFrag73_g76826;
				float3 In_PositionWS16_g128405 = PositionWS122_g76826;
				float3 vertexToFrag76_g76826 = i.ase_texcoord1.xyz;
				float3 PivotWS121_g76826 = vertexToFrag76_g76826;
				#ifdef TVE_SCOPE_DYNAMIC
				float3 staticSwitch204_g76826 = ( PositionWS122_g76826 - PivotWS121_g76826 );
				#else
				float3 staticSwitch204_g76826 = PositionWS122_g76826;
				#endif
				float3 PositionWO132_g76826 = ( staticSwitch204_g76826 - TVE_WorldOrigin );
				float3 In_PositionWO16_g128405 = PositionWO132_g76826;
				float3 In_PivotWS16_g128405 = PivotWS121_g76826;
				float3 PivotWO133_g76826 = ( PivotWS121_g76826 - TVE_WorldOrigin );
				float3 In_PivotWO16_g128405 = PivotWO133_g76826;
				float3 ase_normalWS = i.ase_texcoord2.xyz;
				float3 normalizedWorldNormal = normalize( ase_normalWS );
				half3 NormalWS95_g76826 = normalizedWorldNormal;
				float3 In_NormalWS16_g128405 = NormalWS95_g76826;
				float3 ase_tangentWS = i.ase_texcoord3.xyz;
				half3 TangentWS136_g76826 = ase_tangentWS;
				float3 In_TangentWS16_g128405 = TangentWS136_g76826;
				float3 ase_bitangentWS = i.ase_texcoord4.xyz;
				half3 BiangentWS421_g76826 = ase_bitangentWS;
				float3 In_BitangentWS16_g128405 = BiangentWS421_g76826;
				half3 NormalWS427_g76826 = NormalWS95_g76826;
				half3 localComputeTriplanarWeights427_g76826 = ComputeTriplanarWeights( NormalWS427_g76826 );
				half3 TriplanarWeights429_g76826 = localComputeTriplanarWeights427_g76826;
				float3 In_TriplanarWeights16_g128405 = TriplanarWeights429_g76826;
				float3 normalizeResult296_g76826 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g76826 ) );
				half3 ViewDirWS169_g76826 = normalizeResult296_g76826;
				float3 In_ViewDirWS16_g128405 = ViewDirWS169_g76826;
				float4 appendResult397_g76826 = (float4(i.ase_texcoord5.xyz.xy , i.ase_texcoord6.xy));
				float4 CoordsData398_g76826 = appendResult397_g76826;
				float4 In_CoordsData16_g128405 = CoordsData398_g76826;
				half4 VertexMasks171_g76826 = i.ase_color;
				float4 In_VertexData16_g128405 = VertexMasks171_g76826;
				float temp_output_17_0_g128415 = _ObjectPhaseMode;
				float Option70_g128415 = temp_output_17_0_g128415;
				float4 temp_output_3_0_g128415 = i.ase_color;
				float4 Channel70_g128415 = temp_output_3_0_g128415;
				float localSwitchChannel470_g128415 = SwitchChannel4( Option70_g128415 , Channel70_g128415 );
				half Phase_Value372_g76826 = localSwitchChannel470_g128415;
				float3 break319_g76826 = PivotWO133_g76826;
				half Pivot_Position322_g76826 = ( break319_g76826.x + break319_g76826.z );
				half Phase_Position357_g76826 = ( Phase_Value372_g76826 + Pivot_Position322_g76826 );
				float temp_output_248_0_g76826 = frac( Phase_Position357_g76826 );
				float4 appendResult177_g76826 = (float4(( (frac( ( Phase_Position357_g76826 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) * 5.0 ) , temp_output_248_0_g76826));
				half4 Phase_Data176_g76826 = appendResult177_g76826;
				float4 In_PhaseData16_g128405 = Phase_Data176_g76826;
				BuildModelFragData( Data16_g128405 , In_Dummy16_g128405 , In_PositionWS16_g128405 , In_PositionWO16_g128405 , In_PivotWS16_g128405 , In_PivotWO16_g128405 , In_NormalWS16_g128405 , In_TangentWS16_g128405 , In_BitangentWS16_g128405 , In_TriplanarWeights16_g128405 , In_ViewDirWS16_g128405 , In_CoordsData16_g128405 , In_VertexData16_g128405 , In_PhaseData16_g128405 );
				TVEModelData Data15_g251330 =(TVEModelData)Data16_g128405;
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
				float4 Model_CoordsData324_g139039 = Out_CoordsData15_g251330;
				float4 MeshCoords444_g251346 = Model_CoordsData324_g139039;
				float2 UV0444_g251346 = float2( 0,0 );
				float2 UV3444_g251346 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g251346 , MeshCoords444_g251346 , UV0444_g251346 , UV3444_g251346 );
				float4 appendResult430_g251346 = (float4(UV0444_g251346 , UV3444_g251346));
				float4 In_MaskA431_g251346 = appendResult430_g251346;
				float localComputeWorldCoords315_g251346 = ( 0.0 );
				float4 Coords315_g251346 = Local_Coords180_g139039;
				float3 Model_PositionWO222_g139039 = Out_PositionWO15_g251330;
				float3 PositionWS315_g251346 = Model_PositionWO222_g139039;
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
				half3 Model_NormalWS226_g139039 = Out_NormalWS15_g251330;
				float3 temp_output_449_0_g251346 = Model_NormalWS226_g139039;
				float4 In_MaskK431_g251346 = float4( temp_output_449_0_g251346 , 0.0 );
				half3 Model_TangentWS366_g139039 = Out_TangentWS15_g251330;
				float3 temp_output_450_0_g251346 = Model_TangentWS366_g139039;
				float4 In_MaskL431_g251346 = float4( temp_output_450_0_g251346 , 0.0 );
				half3 Model_BitangentWS367_g139039 = Out_BitangentWS15_g251330;
				float3 temp_output_451_0_g251346 = Model_BitangentWS367_g139039;
				float4 In_MaskM431_g251346 = float4( temp_output_451_0_g251346 , 0.0 );
				half3 Model_TriplanarWeights368_g139039 = Out_TriplanarWeights15_g251330;
				float3 temp_output_445_0_g251346 = Model_TriplanarWeights368_g139039;
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
				float4 temp_output_407_277_g139039 = localSampleCoord276_g251356;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251356) = _MainAlbedoTex;
				SamplerState Sampler502_g251356 = staticSwitch36_g251351;
				half2 UV502_g251356 = (Out_MaskA456_g251356).zw;
				half Bias502_g251356 = temp_output_504_0_g251356;
				half2 Normal502_g251356 = float2( 0,0 );
				half4 localSampleCoord502_g251356 = SampleCoord( Texture502_g251356 , Sampler502_g251356 , UV502_g251356 , Bias502_g251356 , Normal502_g251356 );
				float4 temp_output_407_278_g139039 = localSampleCoord502_g251356;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251356) = _MainAlbedoTex;
				SamplerState Sampler496_g251356 = staticSwitch36_g251351;
				float2 temp_output_463_0_g251356 = (Out_MaskB456_g251356).zw;
				half2 XZ496_g251356 = temp_output_463_0_g251356;
				half Bias496_g251356 = temp_output_504_0_g251356;
				float3 temp_output_483_0_g251356 = (Out_MaskK456_g251356).xyz;
				half3 NormalWS496_g251356 = temp_output_483_0_g251356;
				half3 Normal496_g251356 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g251356 = SamplePlanar2D( Texture496_g251356 , Sampler496_g251356 , XZ496_g251356 , Bias496_g251356 , NormalWS496_g251356 , Normal496_g251356 );
				float4 temp_output_407_0_g139039 = localSamplePlanar2D496_g251356;
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
				float4 temp_output_407_201_g139039 = localSamplePlanar3D490_g251356;
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
				float4 temp_output_407_202_g139039 = localSampleStochastic2D498_g251356;
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
				float4 temp_output_407_203_g139039 = localSampleStochastic3D500_g251356;
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch184_g139039 = temp_output_407_277_g139039;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch184_g139039 = temp_output_407_278_g139039;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch184_g139039 = temp_output_407_0_g139039;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch184_g139039 = temp_output_407_201_g139039;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch184_g139039 = temp_output_407_202_g139039;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch184_g139039 = temp_output_407_203_g139039;
				#else
				float4 staticSwitch184_g139039 = temp_output_407_277_g139039;
				#endif
				half4 Local_AlbedoSample185_g139039 = staticSwitch184_g139039;
				float3 lerpResult53_g139039 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g139039).xyz , _MainAlbedoValue);
				half3 Local_AlbedoRGB107_g139039 = lerpResult53_g139039;
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
				float4 temp_output_405_277_g139039 = localSampleCoord276_g251354;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251354) = _MainShaderTex;
				SamplerState Sampler502_g251354 = staticSwitch38_g251353;
				half2 UV502_g251354 = (Out_MaskA456_g251354).zw;
				half Bias502_g251354 = temp_output_504_0_g251354;
				half2 Normal502_g251354 = float2( 0,0 );
				half4 localSampleCoord502_g251354 = SampleCoord( Texture502_g251354 , Sampler502_g251354 , UV502_g251354 , Bias502_g251354 , Normal502_g251354 );
				float4 temp_output_405_278_g139039 = localSampleCoord502_g251354;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251354) = _MainShaderTex;
				SamplerState Sampler496_g251354 = staticSwitch38_g251353;
				float2 temp_output_463_0_g251354 = (Out_MaskB456_g251354).zw;
				half2 XZ496_g251354 = temp_output_463_0_g251354;
				half Bias496_g251354 = temp_output_504_0_g251354;
				float3 temp_output_483_0_g251354 = (Out_MaskK456_g251354).xyz;
				half3 NormalWS496_g251354 = temp_output_483_0_g251354;
				half3 Normal496_g251354 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g251354 = SamplePlanar2D( Texture496_g251354 , Sampler496_g251354 , XZ496_g251354 , Bias496_g251354 , NormalWS496_g251354 , Normal496_g251354 );
				float4 temp_output_405_0_g139039 = localSamplePlanar2D496_g251354;
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
				float4 temp_output_405_201_g139039 = localSamplePlanar3D490_g251354;
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
				float4 temp_output_405_202_g139039 = localSampleStochastic2D498_g251354;
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
				float4 temp_output_405_203_g139039 = localSampleStochastic3D500_g251354;
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float4 staticSwitch198_g139039 = temp_output_405_277_g139039;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float4 staticSwitch198_g139039 = temp_output_405_278_g139039;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float4 staticSwitch198_g139039 = temp_output_405_0_g139039;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float4 staticSwitch198_g139039 = temp_output_405_201_g139039;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch198_g139039 = temp_output_405_202_g139039;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch198_g139039 = temp_output_405_203_g139039;
				#else
				float4 staticSwitch198_g139039 = temp_output_405_277_g139039;
				#endif
				half4 Local_ShaderSample199_g139039 = staticSwitch198_g139039;
				float temp_output_209_0_g139039 = (Local_ShaderSample199_g139039).y;
				float temp_output_7_0_g251323 = _MainOcclusionRemap.x;
				float temp_output_9_0_g251323 = ( temp_output_209_0_g139039 - temp_output_7_0_g251323 );
				float lerpResult23_g139039 = lerp( 1.0 , saturate( ( temp_output_9_0_g251323 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
				half Local_Occlusion313_g139039 = lerpResult23_g139039;
				float temp_output_213_0_g139039 = (Local_ShaderSample199_g139039).w;
				float temp_output_7_0_g251327 = _MainSmoothnessRemap.x;
				float temp_output_9_0_g251327 = ( temp_output_213_0_g139039 - temp_output_7_0_g251327 );
				half Local_Smoothness317_g139039 = ( saturate( ( temp_output_9_0_g251327 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
				float4 appendResult73_g139039 = (float4(( (Local_ShaderSample199_g139039).x * _MainMetallicValue ) , Local_Occlusion313_g139039 , (Local_ShaderSample199_g139039).z , Local_Smoothness317_g139039));
				half4 Local_Masks109_g139039 = appendResult73_g139039;
				float temp_output_135_0_g139039 = (Local_Masks109_g139039).z;
				float temp_output_7_0_g251322 = _MainMultiRemap.x;
				float temp_output_9_0_g251322 = ( temp_output_135_0_g139039 - temp_output_7_0_g251322 );
				float temp_output_42_0_g139039 = saturate( ( temp_output_9_0_g251322 * _MainMultiRemap.z ) );
				half Local_MultiMask78_g139039 = temp_output_42_0_g139039;
				float lerpResult58_g139039 = lerp( 1.0 , Local_MultiMask78_g139039 , _MainColorMode);
				float4 lerpResult62_g139039 = lerp( _MainColorTwo , _MainColor , lerpResult58_g139039);
				half3 Local_ColorRGB93_g139039 = (lerpResult62_g139039).rgb;
				half3 Local_Albedo139_g139039 = ( Local_AlbedoRGB107_g139039 * Local_ColorRGB93_g139039 );
				float3 temp_output_4_0_g251315 = Local_Albedo139_g139039;
				float3 In_Albedo3_g251315 = temp_output_4_0_g251315;
				float3 temp_output_44_0_g251315 = Local_Albedo139_g139039;
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
				float2 temp_output_406_394_g139039 = Normal276_g251355;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251355) = _MainNormalTex;
				SamplerState Sampler502_g251355 = staticSwitch37_g251352;
				half2 UV502_g251355 = (Out_MaskA456_g251355).zw;
				half Bias502_g251355 = temp_output_504_0_g251355;
				half2 Normal502_g251355 = float2( 0,0 );
				half4 localSampleCoord502_g251355 = SampleCoord( Texture502_g251355 , Sampler502_g251355 , UV502_g251355 , Bias502_g251355 , Normal502_g251355 );
				float2 temp_output_406_397_g139039 = Normal502_g251355;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251355) = _MainNormalTex;
				SamplerState Sampler496_g251355 = staticSwitch37_g251352;
				float2 temp_output_463_0_g251355 = (Out_MaskB456_g251355).zw;
				half2 XZ496_g251355 = temp_output_463_0_g251355;
				half Bias496_g251355 = temp_output_504_0_g251355;
				float3 temp_output_483_0_g251355 = (Out_MaskK456_g251355).xyz;
				half3 NormalWS496_g251355 = temp_output_483_0_g251355;
				half3 Normal496_g251355 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g251355 = SamplePlanar2D( Texture496_g251355 , Sampler496_g251355 , XZ496_g251355 , Bias496_g251355 , NormalWS496_g251355 , Normal496_g251355 );
				float3x3 ase_worldToTangent = float3x3( ase_tangentWS, ase_bitangentWS, ase_normalWS );
				float3 worldToTangentDir408_g251355 = normalize( mul( ase_worldToTangent, Normal496_g251355 ) );
				float2 temp_output_406_375_g139039 = (worldToTangentDir408_g251355).xy;
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
				float2 temp_output_406_353_g139039 = (worldToTangentDir399_g251355).xy;
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
				float2 temp_output_406_391_g139039 = (worldToTangentDir411_g251355).xy;
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
				float2 temp_output_406_390_g139039 = (worldToTangentDir403_g251355).xy;
				#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
				float2 staticSwitch193_g139039 = temp_output_406_394_g139039;
				#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
				float2 staticSwitch193_g139039 = temp_output_406_397_g139039;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
				float2 staticSwitch193_g139039 = temp_output_406_375_g139039;
				#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
				float2 staticSwitch193_g139039 = temp_output_406_353_g139039;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
				float2 staticSwitch193_g139039 = temp_output_406_391_g139039;
				#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
				float2 staticSwitch193_g139039 = temp_output_406_390_g139039;
				#else
				float2 staticSwitch193_g139039 = temp_output_406_394_g139039;
				#endif
				half2 Local_NormaSample191_g139039 = staticSwitch193_g139039;
				half2 Local_NormalTS108_g139039 = ( Local_NormaSample191_g139039 * _MainNormalValue );
				float2 In_NormalTS3_g251315 = Local_NormalTS108_g139039;
				float3 appendResult68_g251329 = (float3(Local_NormalTS108_g139039 , 1.0));
				float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
				float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
				float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
				float3 tanNormal74_g251329 = appendResult68_g251329;
				float3 worldNormal74_g251329 = normalize( float3( dot( tanToWorld0, tanNormal74_g251329 ), dot( tanToWorld1, tanNormal74_g251329 ), dot( tanToWorld2, tanNormal74_g251329 ) ) );
				half3 Local_NormalWS250_g139039 = worldNormal74_g251329;
				float3 In_NormalWS3_g251315 = Local_NormalWS250_g139039;
				float4 In_Shader3_g251315 = Local_Masks109_g139039;
				float4 In_Feature3_g251315 = half4( 1, 1, 1, 1 );
				float4 In_Season3_g251315 = half4( 1, 1, 1, 1 );
				float4 In_Emissive3_g251315 = half4( 1, 1, 1, 1 );
				float3 temp_output_3_0_g251326 = Local_Albedo139_g139039;
				float dotResult20_g251326 = dot( temp_output_3_0_g251326 , float3( 0.2126, 0.7152, 0.0722 ) );
				half Local_Grayscale110_g139039 = dotResult20_g251326;
				float temp_output_12_0_g251315 = Local_Grayscale110_g139039;
				float In_Grayscale3_g251315 = temp_output_12_0_g251315;
				float clampResult27_g251328 = clamp( saturate( ( Local_Grayscale110_g139039 * 5.0 ) ) , 0.2 , 1.0 );
				half Local_Luminosity145_g139039 = clampResult27_g251328;
				float temp_output_16_0_g251315 = Local_Luminosity145_g139039;
				float In_Luminosity3_g251315 = temp_output_16_0_g251315;
				float In_MultiMask3_g251315 = Local_MultiMask78_g139039;
				float temp_output_187_0_g139039 = (Local_AlbedoSample185_g139039).w;
				#ifdef TVE_CLIPPING
				float staticSwitch236_g139039 = ( temp_output_187_0_g139039 - _MainAlphaClipValue );
				#else
				float staticSwitch236_g139039 = temp_output_187_0_g139039;
				#endif
				half Local_AlphaClip111_g139039 = staticSwitch236_g139039;
				float In_AlphaClip3_g251315 = Local_AlphaClip111_g139039;
				half Local_AlphaFade246_g139039 = (lerpResult62_g139039).a;
				float In_AlphaFade3_g251315 = Local_AlphaFade246_g139039;
				float3 temp_cast_10 = (1.0).xxx;
				float3 In_Translucency3_g251315 = temp_cast_10;
				float In_Transmission3_g251315 = 1.0;
				float In_Thickness3_g251315 = 0.0;
				float In_Diffusion3_g251315 = 0.0;
				float In_Depth3_g251315 = 0.0;
				BuildVisualData( Data3_g251315 , In_Dummy3_g251315 , In_Albedo3_g251315 , In_AlbedoBase3_g251315 , In_NormalTS3_g251315 , In_NormalWS3_g251315 , In_Shader3_g251315 , In_Feature3_g251315 , In_Season3_g251315 , In_Emissive3_g251315 , In_Grayscale3_g251315 , In_Luminosity3_g251315 , In_MultiMask3_g251315 , In_AlphaClip3_g251315 , In_AlphaFade3_g251315 , In_Translucency3_g251315 , In_Transmission3_g251315 , In_Thickness3_g251315 , In_Diffusion3_g251315 , In_Depth3_g251315 );
				TVEVisualData DataA25_g251405 = Data3_g251315;
				float localBuildVisualData3_g251379 = ( 0.0 );
				float localBreakVisualData4_g251380 = ( 0.0 );
				TVEVisualData Data4_g251380 =(TVEVisualData)Data3_g251315;
				float Out_Dummy4_g251380 = 0.0;
				float3 Out_Albedo4_g251380 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g251380 = float3( 0,0,0 );
				float2 Out_NormalTS4_g251380 = float2( 0,0 );
				float3 Out_NormalWS4_g251380 = float3( 0,0,0 );
				float4 Out_Shader4_g251380 = float4( 0,0,0,0 );
				float4 Out_Feature4_g251380 = float4( 0,0,0,0 );
				float4 Out_Season4_g251380 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g251380 = float4( 0,0,0,0 );
				float Out_MultiMask4_g251380 = 0.0;
				float Out_Grayscale4_g251380 = 0.0;
				float Out_Luminosity4_g251380 = 0.0;
				float Out_AlphaClip4_g251380 = 0.0;
				float Out_AlphaFade4_g251380 = 0.0;
				float3 Out_Translucency4_g251380 = float3( 0,0,0 );
				float Out_Transmission4_g251380 = 0.0;
				float Out_Thickness4_g251380 = 0.0;
				float Out_Diffusion4_g251380 = 0.0;
				float Out_Depth4_g251380 = 0.0;
				BreakVisualData( Data4_g251380 , Out_Dummy4_g251380 , Out_Albedo4_g251380 , Out_AlbedoBase4_g251380 , Out_NormalTS4_g251380 , Out_NormalWS4_g251380 , Out_Shader4_g251380 , Out_Feature4_g251380 , Out_Season4_g251380 , Out_Emissive4_g251380 , Out_MultiMask4_g251380 , Out_Grayscale4_g251380 , Out_Luminosity4_g251380 , Out_AlphaClip4_g251380 , Out_AlphaFade4_g251380 , Out_Translucency4_g251380 , Out_Transmission4_g251380 , Out_Thickness4_g251380 , Out_Diffusion4_g251380 , Out_Depth4_g251380 );
				TVEVisualData Data3_g251379 =(TVEVisualData)Data4_g251380;
				half Dummy946_g251357 = ( ( _SecondCategory + _SecondEnd ) + _SecondSpace0 + _SecondBakeMode );
				float temp_output_14_0_g251379 = Dummy946_g251357;
				float In_Dummy3_g251379 = temp_output_14_0_g251379;
				half3 Visual_Albedo527_g251357 = Out_Albedo4_g251380;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251381) = _SecondAlbedoTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g251389 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g251389 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g251389 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g251389 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g251389 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g251389 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g251381 = staticSwitch36_g251389;
				float localBreakTextureData456_g251381 = ( 0.0 );
				float localBuildTextureData431_g251363 = ( 0.0 );
				TVEMasksData Data431_g251363 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g251363 = ( 0.0 );
				float4 temp_output_6_0_g251361 = _second_coord_value;
				float4 temp_output_7_0_g251361 = ( _SecondSampleMode + _SecondCoordMode + _SecondCoordValue );
				#ifdef TVE_DUMMY
				float4 staticSwitch14_g251361 = ( temp_output_6_0_g251361 + temp_output_7_0_g251361 );
				#else
				float4 staticSwitch14_g251361 = temp_output_6_0_g251361;
				#endif
				half4 Local_CoordValue790_g251357 = staticSwitch14_g251361;
				float4 Coords444_g251363 = Local_CoordValue790_g251357;
				TVEModelData Data15_g251360 =(TVEModelData)Data16_g128405;
				float Out_Dummy15_g251360 = 0.0;
				float3 Out_PositionWS15_g251360 = float3( 0,0,0 );
				float3 Out_PositionWO15_g251360 = float3( 0,0,0 );
				float3 Out_PivotWS15_g251360 = float3( 0,0,0 );
				float3 Out_PivotWO15_g251360 = float3( 0,0,0 );
				float3 Out_NormalWS15_g251360 = float3( 0,0,0 );
				float3 Out_TangentWS15_g251360 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g251360 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g251360 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g251360 = float3( 0,0,0 );
				float4 Out_CoordsData15_g251360 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g251360 = float4( 0,0,0,0 );
				float4 Out_PhaseData15_g251360 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g251360 , Out_Dummy15_g251360 , Out_PositionWS15_g251360 , Out_PositionWO15_g251360 , Out_PivotWS15_g251360 , Out_PivotWO15_g251360 , Out_NormalWS15_g251360 , Out_TangentWS15_g251360 , Out_BitangentWS15_g251360 , Out_TriplanarWeights15_g251360 , Out_ViewDirWS15_g251360 , Out_CoordsData15_g251360 , Out_VertexData15_g251360 , Out_PhaseData15_g251360 );
				float4 Model_CoordsData1099_g251357 = Out_CoordsData15_g251360;
				float4 MeshCoords444_g251363 = Model_CoordsData1099_g251357;
				float2 UV0444_g251363 = float2( 0,0 );
				float2 UV3444_g251363 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g251363 , MeshCoords444_g251363 , UV0444_g251363 , UV3444_g251363 );
				float4 appendResult430_g251363 = (float4(UV0444_g251363 , UV3444_g251363));
				float4 In_MaskA431_g251363 = appendResult430_g251363;
				float localComputeWorldCoords315_g251363 = ( 0.0 );
				float4 Coords315_g251363 = Local_CoordValue790_g251357;
				float3 Model_PositionWO636_g251357 = Out_PositionWO15_g251360;
				float3 PositionWS315_g251363 = Model_PositionWO636_g251357;
				float2 ZY315_g251363 = float2( 0,0 );
				float2 XZ315_g251363 = float2( 0,0 );
				float2 XY315_g251363 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g251363 , PositionWS315_g251363 , ZY315_g251363 , XZ315_g251363 , XY315_g251363 );
				float2 ZY402_g251363 = ZY315_g251363;
				float2 XZ403_g251363 = XZ315_g251363;
				float4 appendResult432_g251363 = (float4(ZY402_g251363 , XZ403_g251363));
				float4 In_MaskB431_g251363 = appendResult432_g251363;
				float2 XY404_g251363 = XY315_g251363;
				float localComputeStochasticCoords409_g251363 = ( 0.0 );
				float2 UV409_g251363 = ZY402_g251363;
				float2 UV1409_g251363 = float2( 0,0 );
				float2 UV2409_g251363 = float2( 0,0 );
				float2 UV3409_g251363 = float2( 0,0 );
				float3 Weights409_g251363 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g251363 , UV1409_g251363 , UV2409_g251363 , UV3409_g251363 , Weights409_g251363 );
				float4 appendResult433_g251363 = (float4(XY404_g251363 , UV1409_g251363));
				float4 In_MaskC431_g251363 = appendResult433_g251363;
				float4 appendResult434_g251363 = (float4(UV2409_g251363 , UV3409_g251363));
				float4 In_MaskD431_g251363 = appendResult434_g251363;
				float localComputeStochasticCoords422_g251363 = ( 0.0 );
				float2 UV422_g251363 = XZ403_g251363;
				float2 UV1422_g251363 = float2( 0,0 );
				float2 UV2422_g251363 = float2( 0,0 );
				float2 UV3422_g251363 = float2( 0,0 );
				float3 Weights422_g251363 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g251363 , UV1422_g251363 , UV2422_g251363 , UV3422_g251363 , Weights422_g251363 );
				float4 appendResult435_g251363 = (float4(UV1422_g251363 , UV2422_g251363));
				float4 In_MaskE431_g251363 = appendResult435_g251363;
				float localComputeStochasticCoords423_g251363 = ( 0.0 );
				float2 UV423_g251363 = XY404_g251363;
				float2 UV1423_g251363 = float2( 0,0 );
				float2 UV2423_g251363 = float2( 0,0 );
				float2 UV3423_g251363 = float2( 0,0 );
				float3 Weights423_g251363 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g251363 , UV1423_g251363 , UV2423_g251363 , UV3423_g251363 , Weights423_g251363 );
				float4 appendResult436_g251363 = (float4(UV3422_g251363 , UV1423_g251363));
				float4 In_MaskF431_g251363 = appendResult436_g251363;
				float4 appendResult437_g251363 = (float4(UV2423_g251363 , UV3423_g251363));
				float4 In_MaskG431_g251363 = appendResult437_g251363;
				float4 In_MaskH431_g251363 = float4( Weights409_g251363 , 0.0 );
				float4 In_MaskI431_g251363 = float4( Weights422_g251363 , 0.0 );
				float4 In_MaskJ431_g251363 = float4( Weights423_g251363 , 0.0 );
				half3 Model_NormalWS869_g251357 = Out_NormalWS15_g251360;
				float3 temp_output_449_0_g251363 = Model_NormalWS869_g251357;
				float4 In_MaskK431_g251363 = float4( temp_output_449_0_g251363 , 0.0 );
				half3 Model_TangentWS1215_g251357 = Out_TangentWS15_g251360;
				float3 temp_output_450_0_g251363 = Model_TangentWS1215_g251357;
				float4 In_MaskL431_g251363 = float4( temp_output_450_0_g251363 , 0.0 );
				half3 Model_BitangentWS1216_g251357 = Out_BitangentWS15_g251360;
				float3 temp_output_451_0_g251363 = Model_BitangentWS1216_g251357;
				float4 In_MaskM431_g251363 = float4( temp_output_451_0_g251363 , 0.0 );
				half3 Model_TriplanarWeights1217_g251357 = Out_TriplanarWeights15_g251360;
				float3 temp_output_445_0_g251363 = Model_TriplanarWeights1217_g251357;
				float4 In_MaskN431_g251363 = float4( temp_output_445_0_g251363 , 0.0 );
				BuildTextureData( Data431_g251363 , In_MaskA431_g251363 , In_MaskB431_g251363 , In_MaskC431_g251363 , In_MaskD431_g251363 , In_MaskE431_g251363 , In_MaskF431_g251363 , In_MaskG431_g251363 , In_MaskH431_g251363 , In_MaskI431_g251363 , In_MaskJ431_g251363 , In_MaskK431_g251363 , In_MaskL431_g251363 , In_MaskM431_g251363 , In_MaskN431_g251363 );
				TVEMasksData Data456_g251381 =(TVEMasksData)Data431_g251363;
				float4 Out_MaskA456_g251381 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g251381 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g251381 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g251381 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g251381 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g251381 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g251381 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g251381 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g251381 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g251381 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g251381 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g251381 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g251381 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g251381 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g251381 , Out_MaskA456_g251381 , Out_MaskB456_g251381 , Out_MaskC456_g251381 , Out_MaskD456_g251381 , Out_MaskE456_g251381 , Out_MaskF456_g251381 , Out_MaskG456_g251381 , Out_MaskH456_g251381 , Out_MaskI456_g251381 , Out_MaskJ456_g251381 , Out_MaskK456_g251381 , Out_MaskL456_g251381 , Out_MaskM456_g251381 , Out_MaskN456_g251381 );
				half2 UV276_g251381 = (Out_MaskA456_g251381).xy;
				float temp_output_504_0_g251381 = 0.0;
				half Bias276_g251381 = temp_output_504_0_g251381;
				half2 Normal276_g251381 = float2( 0,0 );
				half4 localSampleCoord276_g251381 = SampleCoord( Texture276_g251381 , Sampler276_g251381 , UV276_g251381 , Bias276_g251381 , Normal276_g251381 );
				float4 temp_output_865_277_g251357 = localSampleCoord276_g251381;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251381) = _SecondAlbedoTex;
				SamplerState Sampler502_g251381 = staticSwitch36_g251389;
				half2 UV502_g251381 = (Out_MaskA456_g251381).zw;
				half Bias502_g251381 = temp_output_504_0_g251381;
				half2 Normal502_g251381 = float2( 0,0 );
				half4 localSampleCoord502_g251381 = SampleCoord( Texture502_g251381 , Sampler502_g251381 , UV502_g251381 , Bias502_g251381 , Normal502_g251381 );
				float4 temp_output_865_278_g251357 = localSampleCoord502_g251381;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251381) = _SecondAlbedoTex;
				SamplerState Sampler496_g251381 = staticSwitch36_g251389;
				float2 temp_output_463_0_g251381 = (Out_MaskB456_g251381).zw;
				half2 XZ496_g251381 = temp_output_463_0_g251381;
				half Bias496_g251381 = temp_output_504_0_g251381;
				float3 temp_output_483_0_g251381 = (Out_MaskK456_g251381).xyz;
				half3 NormalWS496_g251381 = temp_output_483_0_g251381;
				half3 Normal496_g251381 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g251381 = SamplePlanar2D( Texture496_g251381 , Sampler496_g251381 , XZ496_g251381 , Bias496_g251381 , NormalWS496_g251381 , Normal496_g251381 );
				float4 temp_output_865_0_g251357 = localSamplePlanar2D496_g251381;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251381) = _SecondAlbedoTex;
				SamplerState Sampler490_g251381 = staticSwitch36_g251389;
				float2 temp_output_462_0_g251381 = (Out_MaskB456_g251381).xy;
				half2 ZY490_g251381 = temp_output_462_0_g251381;
				half2 XZ490_g251381 = temp_output_463_0_g251381;
				float2 temp_output_464_0_g251381 = (Out_MaskC456_g251381).xy;
				half2 XY490_g251381 = temp_output_464_0_g251381;
				half Bias490_g251381 = temp_output_504_0_g251381;
				float3 temp_output_482_0_g251381 = (Out_MaskN456_g251381).xyz;
				half3 Triplanar490_g251381 = temp_output_482_0_g251381;
				half3 NormalWS490_g251381 = temp_output_483_0_g251381;
				half3 Normal490_g251381 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g251381 = SamplePlanar3D( Texture490_g251381 , Sampler490_g251381 , ZY490_g251381 , XZ490_g251381 , XY490_g251381 , Bias490_g251381 , Triplanar490_g251381 , NormalWS490_g251381 , Normal490_g251381 );
				float4 temp_output_865_201_g251357 = localSamplePlanar3D490_g251381;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251381) = _SecondAlbedoTex;
				SamplerState Sampler498_g251381 = staticSwitch36_g251389;
				half2 XZ498_g251381 = temp_output_463_0_g251381;
				float2 temp_output_473_0_g251381 = (Out_MaskE456_g251381).xy;
				half2 XZ_1498_g251381 = temp_output_473_0_g251381;
				float2 temp_output_474_0_g251381 = (Out_MaskE456_g251381).zw;
				half2 XZ_2498_g251381 = temp_output_474_0_g251381;
				float2 temp_output_475_0_g251381 = (Out_MaskF456_g251381).xy;
				half2 XZ_3498_g251381 = temp_output_475_0_g251381;
				float temp_output_510_0_g251381 = exp2( temp_output_504_0_g251381 );
				half Bias498_g251381 = temp_output_510_0_g251381;
				float3 temp_output_480_0_g251381 = (Out_MaskI456_g251381).xyz;
				half3 Weights_2498_g251381 = temp_output_480_0_g251381;
				half3 NormalWS498_g251381 = temp_output_483_0_g251381;
				half3 Normal498_g251381 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g251381 = SampleStochastic2D( Texture498_g251381 , Sampler498_g251381 , XZ498_g251381 , XZ_1498_g251381 , XZ_2498_g251381 , XZ_3498_g251381 , Bias498_g251381 , Weights_2498_g251381 , NormalWS498_g251381 , Normal498_g251381 );
				float4 temp_output_865_202_g251357 = localSampleStochastic2D498_g251381;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251381) = _SecondAlbedoTex;
				SamplerState Sampler500_g251381 = staticSwitch36_g251389;
				half2 ZY500_g251381 = temp_output_462_0_g251381;
				half2 ZY_1500_g251381 = (Out_MaskC456_g251381).zw;
				half2 ZY_2500_g251381 = (Out_MaskD456_g251381).xy;
				half2 ZY_3500_g251381 = (Out_MaskD456_g251381).zw;
				half2 XZ500_g251381 = temp_output_463_0_g251381;
				half2 XZ_1500_g251381 = temp_output_473_0_g251381;
				half2 XZ_2500_g251381 = temp_output_474_0_g251381;
				half2 XZ_3500_g251381 = temp_output_475_0_g251381;
				half2 XY500_g251381 = temp_output_464_0_g251381;
				half2 XY_1500_g251381 = (Out_MaskF456_g251381).zw;
				half2 XY_2500_g251381 = (Out_MaskG456_g251381).xy;
				half2 XY_3500_g251381 = (Out_MaskG456_g251381).zw;
				half Bias500_g251381 = temp_output_510_0_g251381;
				half3 Weights_1500_g251381 = (Out_MaskH456_g251381).xyz;
				half3 Weights_2500_g251381 = temp_output_480_0_g251381;
				half3 Weights_3500_g251381 = (Out_MaskJ456_g251381).xyz;
				half3 Triplanar500_g251381 = temp_output_482_0_g251381;
				half3 NormalWS500_g251381 = temp_output_483_0_g251381;
				half3 Normal500_g251381 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g251381 = SampleStochastic3D( Texture500_g251381 , Sampler500_g251381 , ZY500_g251381 , ZY_1500_g251381 , ZY_2500_g251381 , ZY_3500_g251381 , XZ500_g251381 , XZ_1500_g251381 , XZ_2500_g251381 , XZ_3500_g251381 , XY500_g251381 , XY_1500_g251381 , XY_2500_g251381 , XY_3500_g251381 , Bias500_g251381 , Weights_1500_g251381 , Weights_2500_g251381 , Weights_3500_g251381 , Triplanar500_g251381 , NormalWS500_g251381 , Normal500_g251381 );
				float4 temp_output_865_203_g251357 = localSampleStochastic3D500_g251381;
				#if defined( TVE_SECOND_SAMPLE_MAIN_UV )
				float4 staticSwitch693_g251357 = temp_output_865_277_g251357;
				#elif defined( TVE_SECOND_SAMPLE_EXTRA_UV )
				float4 staticSwitch693_g251357 = temp_output_865_278_g251357;
				#elif defined( TVE_SECOND_SAMPLE_PLANAR_2D )
				float4 staticSwitch693_g251357 = temp_output_865_0_g251357;
				#elif defined( TVE_SECOND_SAMPLE_PLANAR_3D )
				float4 staticSwitch693_g251357 = temp_output_865_201_g251357;
				#elif defined( TVE_SECOND_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch693_g251357 = temp_output_865_202_g251357;
				#elif defined( TVE_SECOND_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch693_g251357 = temp_output_865_203_g251357;
				#else
				float4 staticSwitch693_g251357 = temp_output_865_277_g251357;
				#endif
				half4 Local_AlbedoSample777_g251357 = staticSwitch693_g251357;
				float3 lerpResult716_g251357 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample777_g251357).xyz , _SecondAlbedoValue);
				half3 Local_AlbedoRGB771_g251357 = lerpResult716_g251357;
				half3 Local_ColorRGB774_g251357 = (_SecondColor).rgb;
				half3 Local_Albedo768_g251357 = ( Local_AlbedoRGB771_g251357 * Local_ColorRGB774_g251357 );
				float3 lerpResult985_g251357 = lerp( Local_Albedo768_g251357 , ( Visual_Albedo527_g251357 * Local_Albedo768_g251357 ) , _SecondBlendAlbedoValue);
				float temp_output_17_0_g251393 = _SecondMaskMode;
				float Option70_g251393 = temp_output_17_0_g251393;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251383) = _SecondMaskTex;
				SamplerState Sampler276_g251383 = sampler_Linear_Repeat;
				float localBreakTextureData456_g251383 = ( 0.0 );
				float localBuildTextureData431_g251388 = ( 0.0 );
				TVEMasksData Data431_g251388 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g251388 = ( 0.0 );
				float4 temp_output_6_0_g251362 = _second_mask_coord_value;
				float4 temp_output_7_0_g251362 = ( _SecondMaskSampleMode + _SecondMaskCoordMode + _SecondMaskCoordValue );
				#ifdef TVE_DUMMY
				float4 staticSwitch14_g251362 = ( temp_output_6_0_g251362 + temp_output_7_0_g251362 );
				#else
				float4 staticSwitch14_g251362 = temp_output_6_0_g251362;
				#endif
				half4 Local_MaskCoordValue813_g251357 = staticSwitch14_g251362;
				float4 Coords444_g251388 = Local_MaskCoordValue813_g251357;
				float4 MeshCoords444_g251388 = Model_CoordsData1099_g251357;
				float2 UV0444_g251388 = float2( 0,0 );
				float2 UV3444_g251388 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g251388 , MeshCoords444_g251388 , UV0444_g251388 , UV3444_g251388 );
				float4 appendResult430_g251388 = (float4(UV0444_g251388 , UV3444_g251388));
				float4 In_MaskA431_g251388 = appendResult430_g251388;
				float localComputeWorldCoords315_g251388 = ( 0.0 );
				float4 Coords315_g251388 = Local_MaskCoordValue813_g251357;
				float3 PositionWS315_g251388 = Model_PositionWO636_g251357;
				float2 ZY315_g251388 = float2( 0,0 );
				float2 XZ315_g251388 = float2( 0,0 );
				float2 XY315_g251388 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g251388 , PositionWS315_g251388 , ZY315_g251388 , XZ315_g251388 , XY315_g251388 );
				float2 ZY402_g251388 = ZY315_g251388;
				float2 XZ403_g251388 = XZ315_g251388;
				float4 appendResult432_g251388 = (float4(ZY402_g251388 , XZ403_g251388));
				float4 In_MaskB431_g251388 = appendResult432_g251388;
				float2 XY404_g251388 = XY315_g251388;
				float localComputeStochasticCoords409_g251388 = ( 0.0 );
				float2 UV409_g251388 = ZY402_g251388;
				float2 UV1409_g251388 = float2( 0,0 );
				float2 UV2409_g251388 = float2( 0,0 );
				float2 UV3409_g251388 = float2( 0,0 );
				float3 Weights409_g251388 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g251388 , UV1409_g251388 , UV2409_g251388 , UV3409_g251388 , Weights409_g251388 );
				float4 appendResult433_g251388 = (float4(XY404_g251388 , UV1409_g251388));
				float4 In_MaskC431_g251388 = appendResult433_g251388;
				float4 appendResult434_g251388 = (float4(UV2409_g251388 , UV3409_g251388));
				float4 In_MaskD431_g251388 = appendResult434_g251388;
				float localComputeStochasticCoords422_g251388 = ( 0.0 );
				float2 UV422_g251388 = XZ403_g251388;
				float2 UV1422_g251388 = float2( 0,0 );
				float2 UV2422_g251388 = float2( 0,0 );
				float2 UV3422_g251388 = float2( 0,0 );
				float3 Weights422_g251388 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g251388 , UV1422_g251388 , UV2422_g251388 , UV3422_g251388 , Weights422_g251388 );
				float4 appendResult435_g251388 = (float4(UV1422_g251388 , UV2422_g251388));
				float4 In_MaskE431_g251388 = appendResult435_g251388;
				float localComputeStochasticCoords423_g251388 = ( 0.0 );
				float2 UV423_g251388 = XY404_g251388;
				float2 UV1423_g251388 = float2( 0,0 );
				float2 UV2423_g251388 = float2( 0,0 );
				float2 UV3423_g251388 = float2( 0,0 );
				float3 Weights423_g251388 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g251388 , UV1423_g251388 , UV2423_g251388 , UV3423_g251388 , Weights423_g251388 );
				float4 appendResult436_g251388 = (float4(UV3422_g251388 , UV1423_g251388));
				float4 In_MaskF431_g251388 = appendResult436_g251388;
				float4 appendResult437_g251388 = (float4(UV2423_g251388 , UV3423_g251388));
				float4 In_MaskG431_g251388 = appendResult437_g251388;
				float4 In_MaskH431_g251388 = float4( Weights409_g251388 , 0.0 );
				float4 In_MaskI431_g251388 = float4( Weights422_g251388 , 0.0 );
				float4 In_MaskJ431_g251388 = float4( Weights423_g251388 , 0.0 );
				float3 temp_output_449_0_g251388 = Model_NormalWS869_g251357;
				float4 In_MaskK431_g251388 = float4( temp_output_449_0_g251388 , 0.0 );
				float3 temp_output_450_0_g251388 = Model_TangentWS1215_g251357;
				float4 In_MaskL431_g251388 = float4( temp_output_450_0_g251388 , 0.0 );
				float3 temp_output_451_0_g251388 = Model_BitangentWS1216_g251357;
				float4 In_MaskM431_g251388 = float4( temp_output_451_0_g251388 , 0.0 );
				float3 temp_output_445_0_g251388 = Model_TriplanarWeights1217_g251357;
				float4 In_MaskN431_g251388 = float4( temp_output_445_0_g251388 , 0.0 );
				BuildTextureData( Data431_g251388 , In_MaskA431_g251388 , In_MaskB431_g251388 , In_MaskC431_g251388 , In_MaskD431_g251388 , In_MaskE431_g251388 , In_MaskF431_g251388 , In_MaskG431_g251388 , In_MaskH431_g251388 , In_MaskI431_g251388 , In_MaskJ431_g251388 , In_MaskK431_g251388 , In_MaskL431_g251388 , In_MaskM431_g251388 , In_MaskN431_g251388 );
				TVEMasksData Data456_g251383 =(TVEMasksData)Data431_g251388;
				float4 Out_MaskA456_g251383 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g251383 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g251383 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g251383 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g251383 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g251383 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g251383 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g251383 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g251383 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g251383 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g251383 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g251383 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g251383 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g251383 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g251383 , Out_MaskA456_g251383 , Out_MaskB456_g251383 , Out_MaskC456_g251383 , Out_MaskD456_g251383 , Out_MaskE456_g251383 , Out_MaskF456_g251383 , Out_MaskG456_g251383 , Out_MaskH456_g251383 , Out_MaskI456_g251383 , Out_MaskJ456_g251383 , Out_MaskK456_g251383 , Out_MaskL456_g251383 , Out_MaskM456_g251383 , Out_MaskN456_g251383 );
				half2 UV276_g251383 = (Out_MaskA456_g251383).xy;
				float temp_output_504_0_g251383 = 0.0;
				half Bias276_g251383 = temp_output_504_0_g251383;
				half2 Normal276_g251383 = float2( 0,0 );
				half4 localSampleCoord276_g251383 = SampleCoord( Texture276_g251383 , Sampler276_g251383 , UV276_g251383 , Bias276_g251383 , Normal276_g251383 );
				float4 temp_output_868_277_g251357 = localSampleCoord276_g251383;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251383) = _SecondMaskTex;
				SamplerState Sampler502_g251383 = sampler_Linear_Repeat;
				half2 UV502_g251383 = (Out_MaskA456_g251383).zw;
				half Bias502_g251383 = temp_output_504_0_g251383;
				half2 Normal502_g251383 = float2( 0,0 );
				half4 localSampleCoord502_g251383 = SampleCoord( Texture502_g251383 , Sampler502_g251383 , UV502_g251383 , Bias502_g251383 , Normal502_g251383 );
				float4 temp_output_868_278_g251357 = localSampleCoord502_g251383;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251383) = _SecondMaskTex;
				SamplerState Sampler496_g251383 = sampler_Linear_Repeat;
				float2 temp_output_463_0_g251383 = (Out_MaskB456_g251383).zw;
				half2 XZ496_g251383 = temp_output_463_0_g251383;
				half Bias496_g251383 = temp_output_504_0_g251383;
				float3 temp_output_483_0_g251383 = (Out_MaskK456_g251383).xyz;
				half3 NormalWS496_g251383 = temp_output_483_0_g251383;
				half3 Normal496_g251383 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g251383 = SamplePlanar2D( Texture496_g251383 , Sampler496_g251383 , XZ496_g251383 , Bias496_g251383 , NormalWS496_g251383 , Normal496_g251383 );
				float4 temp_output_868_0_g251357 = localSamplePlanar2D496_g251383;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251383) = _SecondMaskTex;
				SamplerState Sampler490_g251383 = sampler_Linear_Repeat;
				float2 temp_output_462_0_g251383 = (Out_MaskB456_g251383).xy;
				half2 ZY490_g251383 = temp_output_462_0_g251383;
				half2 XZ490_g251383 = temp_output_463_0_g251383;
				float2 temp_output_464_0_g251383 = (Out_MaskC456_g251383).xy;
				half2 XY490_g251383 = temp_output_464_0_g251383;
				half Bias490_g251383 = temp_output_504_0_g251383;
				float3 temp_output_482_0_g251383 = (Out_MaskN456_g251383).xyz;
				half3 Triplanar490_g251383 = temp_output_482_0_g251383;
				half3 NormalWS490_g251383 = temp_output_483_0_g251383;
				half3 Normal490_g251383 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g251383 = SamplePlanar3D( Texture490_g251383 , Sampler490_g251383 , ZY490_g251383 , XZ490_g251383 , XY490_g251383 , Bias490_g251383 , Triplanar490_g251383 , NormalWS490_g251383 , Normal490_g251383 );
				float4 temp_output_868_201_g251357 = localSamplePlanar3D490_g251383;
				#if defined( TVE_SECOND_MASK_SAMPLE_MAIN_UV )
				float4 staticSwitch817_g251357 = temp_output_868_277_g251357;
				#elif defined( TVE_SECOND_MASK_SAMPLE_EXTRA_UV )
				float4 staticSwitch817_g251357 = temp_output_868_278_g251357;
				#elif defined( TVE_SECOND_MASK_SAMPLE_PLANAR_2D )
				float4 staticSwitch817_g251357 = temp_output_868_0_g251357;
				#elif defined( TVE_SECOND_MASK_SAMPLE_PLANAR_3D )
				float4 staticSwitch817_g251357 = temp_output_868_201_g251357;
				#else
				float4 staticSwitch817_g251357 = temp_output_868_277_g251357;
				#endif
				half4 Local_MaskSample861_g251357 = staticSwitch817_g251357;
				float4 temp_output_3_0_g251393 = Local_MaskSample861_g251357;
				float4 Channel70_g251393 = temp_output_3_0_g251393;
				float localSwitchChannel470_g251393 = SwitchChannel4( Option70_g251393 , Channel70_g251393 );
				float temp_output_1226_0_g251357 = localSwitchChannel470_g251393;
				float temp_output_7_0_g251403 = _SecondMaskRemap.x;
				float temp_output_9_0_g251403 = ( temp_output_1226_0_g251357 - temp_output_7_0_g251403 );
				float lerpResult1015_g251357 = lerp( 1.0 , saturate( ( temp_output_9_0_g251403 * _SecondMaskRemap.z ) ) , _SecondMaskValue);
				#ifdef TVE_SECOND_MASK
				float staticSwitch1088_g251357 = lerpResult1015_g251357;
				#else
				float staticSwitch1088_g251357 = 1.0;
				#endif
				half Blend_TexMask429_g251357 = staticSwitch1088_g251357;
				half4 Visual_Shader531_g251357 = Out_Shader4_g251380;
				float temp_output_1079_0_g251357 = (Visual_Shader531_g251357).z;
				float temp_output_7_0_g251397 = _SecondBaseRemap.x;
				float temp_output_9_0_g251397 = ( temp_output_1079_0_g251357 - temp_output_7_0_g251397 );
				float lerpResult1081_g251357 = lerp( 1.0 , saturate( ( temp_output_9_0_g251397 * _SecondBaseRemap.z ) ) , _SecondBaseValue);
				half Blend_BaseMask1077_g251357 = lerpResult1081_g251357;
				half Visual_Luminosity1041_g251357 = Out_Luminosity4_g251380;
				float temp_output_7_0_g251402 = _SecondLumaRemap.x;
				float temp_output_9_0_g251402 = ( Visual_Luminosity1041_g251357 - temp_output_7_0_g251402 );
				float lerpResult1036_g251357 = lerp( 1.0 , saturate( ( temp_output_9_0_g251402 * _SecondLumaRemap.z ) ) , _SecondLumaValue);
				half Blend_LumaMask1033_g251357 = lerpResult1036_g251357;
				float temp_output_17_0_g251394 = _SecondMeshMode;
				float Option70_g251394 = temp_output_17_0_g251394;
				half4 Model_VertexData964_g251357 = Out_VertexData15_g251360;
				float4 temp_output_3_0_g251394 = Model_VertexData964_g251357;
				float4 Channel70_g251394 = temp_output_3_0_g251394;
				float localSwitchChannel470_g251394 = SwitchChannel4( Option70_g251394 , Channel70_g251394 );
				float temp_output_1227_0_g251357 = localSwitchChannel470_g251394;
				float temp_output_7_0_g251395 = _SecondMeshRemap.x;
				float temp_output_9_0_g251395 = ( temp_output_1227_0_g251357 - temp_output_7_0_g251395 );
				float lerpResult1017_g251357 = lerp( 1.0 , saturate( ( temp_output_9_0_g251395 * _SecondMeshRemap.z ) ) , _SecondMeshValue);
				half Blend_VertMask918_g251357 = lerpResult1017_g251357;
				half3 Visual_NormalWS951_g251357 = Out_NormalWS4_g251380;
				float temp_output_847_0_g251357 = saturate( (Visual_NormalWS951_g251357).y );
				float temp_output_7_0_g251398 = _SecondProjRemap.x;
				float temp_output_9_0_g251398 = ( temp_output_847_0_g251357 - temp_output_7_0_g251398 );
				float lerpResult996_g251357 = lerp( 1.0 , saturate( ( temp_output_9_0_g251398 * _SecondProjRemap.z ) ) , _SecondProjValue);
				half Blend_ProjMask434_g251357 = lerpResult996_g251357;
				half Blend_GlobalMask972_g251357 = 1.0;
				float temp_output_432_0_g251357 = ( _SecondIntensityValue * Blend_TexMask429_g251357 * Blend_BaseMask1077_g251357 * Blend_LumaMask1033_g251357 * Blend_VertMask918_g251357 * Blend_ProjMask434_g251357 * Blend_GlobalMask972_g251357 );
				float temp_output_7_0_g251396 = _SecondBlendRemap.x;
				float temp_output_9_0_g251396 = ( temp_output_432_0_g251357 - temp_output_7_0_g251396 );
				half Blend_Mask412_g251357 = ( saturate( ( temp_output_9_0_g251396 * _SecondBlendRemap.z ) ) * _SecondBlendIntensityValue );
				float3 lerpResult403_g251357 = lerp( Visual_Albedo527_g251357 , lerpResult985_g251357 , Blend_Mask412_g251357);
				#ifdef TVE_SECOND
				float3 staticSwitch415_g251357 = lerpResult403_g251357;
				#else
				float3 staticSwitch415_g251357 = Visual_Albedo527_g251357;
				#endif
				half3 Final_Albedo601_g251357 = staticSwitch415_g251357;
				float3 temp_output_4_0_g251379 = Final_Albedo601_g251357;
				float3 In_Albedo3_g251379 = temp_output_4_0_g251379;
				float3 temp_output_44_0_g251379 = Final_Albedo601_g251357;
				float3 In_AlbedoBase3_g251379 = temp_output_44_0_g251379;
				half2 Visual_NormalTS529_g251357 = Out_NormalTS4_g251380;
				float2 lerpResult40_g251359 = lerp( float2( 0,0 ) , Visual_NormalTS529_g251357 , _SecondBlendNormalValue);
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251387) = _SecondNormalTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch37_g251390 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch37_g251390 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch37_g251390 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch37_g251390 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch37_g251390 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch37_g251390 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g251387 = staticSwitch37_g251390;
				float localBreakTextureData456_g251387 = ( 0.0 );
				TVEMasksData Data456_g251387 =(TVEMasksData)Data431_g251363;
				float4 Out_MaskA456_g251387 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g251387 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g251387 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g251387 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g251387 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g251387 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g251387 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g251387 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g251387 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g251387 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g251387 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g251387 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g251387 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g251387 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g251387 , Out_MaskA456_g251387 , Out_MaskB456_g251387 , Out_MaskC456_g251387 , Out_MaskD456_g251387 , Out_MaskE456_g251387 , Out_MaskF456_g251387 , Out_MaskG456_g251387 , Out_MaskH456_g251387 , Out_MaskI456_g251387 , Out_MaskJ456_g251387 , Out_MaskK456_g251387 , Out_MaskL456_g251387 , Out_MaskM456_g251387 , Out_MaskN456_g251387 );
				half2 UV276_g251387 = (Out_MaskA456_g251387).xy;
				float temp_output_504_0_g251387 = 0.0;
				half Bias276_g251387 = temp_output_504_0_g251387;
				half2 Normal276_g251387 = float2( 0,0 );
				half4 localSampleCoord276_g251387 = SampleCoord( Texture276_g251387 , Sampler276_g251387 , UV276_g251387 , Bias276_g251387 , Normal276_g251387 );
				float2 temp_output_866_394_g251357 = Normal276_g251387;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251387) = _SecondNormalTex;
				SamplerState Sampler502_g251387 = staticSwitch37_g251390;
				half2 UV502_g251387 = (Out_MaskA456_g251387).zw;
				half Bias502_g251387 = temp_output_504_0_g251387;
				half2 Normal502_g251387 = float2( 0,0 );
				half4 localSampleCoord502_g251387 = SampleCoord( Texture502_g251387 , Sampler502_g251387 , UV502_g251387 , Bias502_g251387 , Normal502_g251387 );
				float2 temp_output_866_397_g251357 = Normal502_g251387;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251387) = _SecondNormalTex;
				SamplerState Sampler496_g251387 = staticSwitch37_g251390;
				float2 temp_output_463_0_g251387 = (Out_MaskB456_g251387).zw;
				half2 XZ496_g251387 = temp_output_463_0_g251387;
				half Bias496_g251387 = temp_output_504_0_g251387;
				float3 temp_output_483_0_g251387 = (Out_MaskK456_g251387).xyz;
				half3 NormalWS496_g251387 = temp_output_483_0_g251387;
				half3 Normal496_g251387 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g251387 = SamplePlanar2D( Texture496_g251387 , Sampler496_g251387 , XZ496_g251387 , Bias496_g251387 , NormalWS496_g251387 , Normal496_g251387 );
				float3 worldToTangentDir408_g251387 = normalize( mul( ase_worldToTangent, Normal496_g251387 ) );
				float2 temp_output_866_375_g251357 = (worldToTangentDir408_g251387).xy;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251387) = _SecondNormalTex;
				SamplerState Sampler490_g251387 = staticSwitch37_g251390;
				float2 temp_output_462_0_g251387 = (Out_MaskB456_g251387).xy;
				half2 ZY490_g251387 = temp_output_462_0_g251387;
				half2 XZ490_g251387 = temp_output_463_0_g251387;
				float2 temp_output_464_0_g251387 = (Out_MaskC456_g251387).xy;
				half2 XY490_g251387 = temp_output_464_0_g251387;
				half Bias490_g251387 = temp_output_504_0_g251387;
				float3 temp_output_482_0_g251387 = (Out_MaskN456_g251387).xyz;
				half3 Triplanar490_g251387 = temp_output_482_0_g251387;
				half3 NormalWS490_g251387 = temp_output_483_0_g251387;
				half3 Normal490_g251387 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g251387 = SamplePlanar3D( Texture490_g251387 , Sampler490_g251387 , ZY490_g251387 , XZ490_g251387 , XY490_g251387 , Bias490_g251387 , Triplanar490_g251387 , NormalWS490_g251387 , Normal490_g251387 );
				float3 worldToTangentDir399_g251387 = normalize( mul( ase_worldToTangent, Normal490_g251387 ) );
				float2 temp_output_866_353_g251357 = (worldToTangentDir399_g251387).xy;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251387) = _SecondNormalTex;
				SamplerState Sampler498_g251387 = staticSwitch37_g251390;
				half2 XZ498_g251387 = temp_output_463_0_g251387;
				float2 temp_output_473_0_g251387 = (Out_MaskE456_g251387).xy;
				half2 XZ_1498_g251387 = temp_output_473_0_g251387;
				float2 temp_output_474_0_g251387 = (Out_MaskE456_g251387).zw;
				half2 XZ_2498_g251387 = temp_output_474_0_g251387;
				float2 temp_output_475_0_g251387 = (Out_MaskF456_g251387).xy;
				half2 XZ_3498_g251387 = temp_output_475_0_g251387;
				float temp_output_510_0_g251387 = exp2( temp_output_504_0_g251387 );
				half Bias498_g251387 = temp_output_510_0_g251387;
				float3 temp_output_480_0_g251387 = (Out_MaskI456_g251387).xyz;
				half3 Weights_2498_g251387 = temp_output_480_0_g251387;
				half3 NormalWS498_g251387 = temp_output_483_0_g251387;
				half3 Normal498_g251387 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g251387 = SampleStochastic2D( Texture498_g251387 , Sampler498_g251387 , XZ498_g251387 , XZ_1498_g251387 , XZ_2498_g251387 , XZ_3498_g251387 , Bias498_g251387 , Weights_2498_g251387 , NormalWS498_g251387 , Normal498_g251387 );
				float3 worldToTangentDir411_g251387 = normalize( mul( ase_worldToTangent, Normal498_g251387 ) );
				float2 temp_output_866_391_g251357 = (worldToTangentDir411_g251387).xy;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251387) = _SecondNormalTex;
				SamplerState Sampler500_g251387 = staticSwitch37_g251390;
				half2 ZY500_g251387 = temp_output_462_0_g251387;
				half2 ZY_1500_g251387 = (Out_MaskC456_g251387).zw;
				half2 ZY_2500_g251387 = (Out_MaskD456_g251387).xy;
				half2 ZY_3500_g251387 = (Out_MaskD456_g251387).zw;
				half2 XZ500_g251387 = temp_output_463_0_g251387;
				half2 XZ_1500_g251387 = temp_output_473_0_g251387;
				half2 XZ_2500_g251387 = temp_output_474_0_g251387;
				half2 XZ_3500_g251387 = temp_output_475_0_g251387;
				half2 XY500_g251387 = temp_output_464_0_g251387;
				half2 XY_1500_g251387 = (Out_MaskF456_g251387).zw;
				half2 XY_2500_g251387 = (Out_MaskG456_g251387).xy;
				half2 XY_3500_g251387 = (Out_MaskG456_g251387).zw;
				half Bias500_g251387 = temp_output_510_0_g251387;
				half3 Weights_1500_g251387 = (Out_MaskH456_g251387).xyz;
				half3 Weights_2500_g251387 = temp_output_480_0_g251387;
				half3 Weights_3500_g251387 = (Out_MaskJ456_g251387).xyz;
				half3 Triplanar500_g251387 = temp_output_482_0_g251387;
				half3 NormalWS500_g251387 = temp_output_483_0_g251387;
				half3 Normal500_g251387 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g251387 = SampleStochastic3D( Texture500_g251387 , Sampler500_g251387 , ZY500_g251387 , ZY_1500_g251387 , ZY_2500_g251387 , ZY_3500_g251387 , XZ500_g251387 , XZ_1500_g251387 , XZ_2500_g251387 , XZ_3500_g251387 , XY500_g251387 , XY_1500_g251387 , XY_2500_g251387 , XY_3500_g251387 , Bias500_g251387 , Weights_1500_g251387 , Weights_2500_g251387 , Weights_3500_g251387 , Triplanar500_g251387 , NormalWS500_g251387 , Normal500_g251387 );
				float3 worldToTangentDir403_g251387 = normalize( mul( ase_worldToTangent, Normal500_g251387 ) );
				float2 temp_output_866_390_g251357 = (worldToTangentDir403_g251387).xy;
				#if defined( TVE_SECOND_SAMPLE_MAIN_UV )
				float2 staticSwitch698_g251357 = temp_output_866_394_g251357;
				#elif defined( TVE_SECOND_SAMPLE_EXTRA_UV )
				float2 staticSwitch698_g251357 = temp_output_866_397_g251357;
				#elif defined( TVE_SECOND_SAMPLE_PLANAR_2D )
				float2 staticSwitch698_g251357 = temp_output_866_375_g251357;
				#elif defined( TVE_SECOND_SAMPLE_PLANAR_3D )
				float2 staticSwitch698_g251357 = temp_output_866_353_g251357;
				#elif defined( TVE_SECOND_SAMPLE_STOCHASTIC_2D )
				float2 staticSwitch698_g251357 = temp_output_866_391_g251357;
				#elif defined( TVE_SECOND_SAMPLE_STOCHASTIC_3D )
				float2 staticSwitch698_g251357 = temp_output_866_390_g251357;
				#else
				float2 staticSwitch698_g251357 = temp_output_866_394_g251357;
				#endif
				half2 Local_NormalSample776_g251357 = staticSwitch698_g251357;
				half2 Local_NormalTS729_g251357 = ( Local_NormalSample776_g251357 * _SecondNormalValue );
				float2 temp_output_36_0_g251359 = ( lerpResult40_g251359 + Local_NormalTS729_g251357 );
				float2 lerpResult405_g251357 = lerp( Visual_NormalTS529_g251357 , temp_output_36_0_g251359 , Blend_Mask412_g251357);
				#ifdef TVE_SECOND
				float2 staticSwitch418_g251357 = lerpResult405_g251357;
				#else
				float2 staticSwitch418_g251357 = Visual_NormalTS529_g251357;
				#endif
				half2 Final_NormalTS612_g251357 = staticSwitch418_g251357;
				float2 In_NormalTS3_g251379 = Final_NormalTS612_g251357;
				float3 appendResult68_g251367 = (float3(Final_NormalTS612_g251357 , 1.0));
				float3 tanNormal74_g251367 = appendResult68_g251367;
				float3 worldNormal74_g251367 = normalize( float3( dot( tanToWorld0, tanNormal74_g251367 ), dot( tanToWorld1, tanNormal74_g251367 ), dot( tanToWorld2, tanNormal74_g251367 ) ) );
				float3 temp_output_949_0_g251357 = worldNormal74_g251367;
				#ifdef TVE_SECOND
				float3 staticSwitch1114_g251357 = temp_output_949_0_g251357;
				#else
				float3 staticSwitch1114_g251357 = Visual_NormalWS951_g251357;
				#endif
				half3 Final_NormalWS950_g251357 = staticSwitch1114_g251357;
				float3 In_NormalWS3_g251379 = Final_NormalWS950_g251357;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251382) = _SecondShaderTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g251391 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g251391 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g251391 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g251391 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g251391 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g251391 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g251382 = staticSwitch38_g251391;
				float localBreakTextureData456_g251382 = ( 0.0 );
				TVEMasksData Data456_g251382 =(TVEMasksData)Data431_g251363;
				float4 Out_MaskA456_g251382 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g251382 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g251382 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g251382 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g251382 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g251382 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g251382 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g251382 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g251382 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g251382 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g251382 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g251382 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g251382 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g251382 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g251382 , Out_MaskA456_g251382 , Out_MaskB456_g251382 , Out_MaskC456_g251382 , Out_MaskD456_g251382 , Out_MaskE456_g251382 , Out_MaskF456_g251382 , Out_MaskG456_g251382 , Out_MaskH456_g251382 , Out_MaskI456_g251382 , Out_MaskJ456_g251382 , Out_MaskK456_g251382 , Out_MaskL456_g251382 , Out_MaskM456_g251382 , Out_MaskN456_g251382 );
				half2 UV276_g251382 = (Out_MaskA456_g251382).xy;
				float temp_output_504_0_g251382 = 0.0;
				half Bias276_g251382 = temp_output_504_0_g251382;
				half2 Normal276_g251382 = float2( 0,0 );
				half4 localSampleCoord276_g251382 = SampleCoord( Texture276_g251382 , Sampler276_g251382 , UV276_g251382 , Bias276_g251382 , Normal276_g251382 );
				float4 temp_output_867_277_g251357 = localSampleCoord276_g251382;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251382) = _SecondShaderTex;
				SamplerState Sampler502_g251382 = staticSwitch38_g251391;
				half2 UV502_g251382 = (Out_MaskA456_g251382).zw;
				half Bias502_g251382 = temp_output_504_0_g251382;
				half2 Normal502_g251382 = float2( 0,0 );
				half4 localSampleCoord502_g251382 = SampleCoord( Texture502_g251382 , Sampler502_g251382 , UV502_g251382 , Bias502_g251382 , Normal502_g251382 );
				float4 temp_output_867_278_g251357 = localSampleCoord502_g251382;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251382) = _SecondShaderTex;
				SamplerState Sampler496_g251382 = staticSwitch38_g251391;
				float2 temp_output_463_0_g251382 = (Out_MaskB456_g251382).zw;
				half2 XZ496_g251382 = temp_output_463_0_g251382;
				half Bias496_g251382 = temp_output_504_0_g251382;
				float3 temp_output_483_0_g251382 = (Out_MaskK456_g251382).xyz;
				half3 NormalWS496_g251382 = temp_output_483_0_g251382;
				half3 Normal496_g251382 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g251382 = SamplePlanar2D( Texture496_g251382 , Sampler496_g251382 , XZ496_g251382 , Bias496_g251382 , NormalWS496_g251382 , Normal496_g251382 );
				float4 temp_output_867_0_g251357 = localSamplePlanar2D496_g251382;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251382) = _SecondShaderTex;
				SamplerState Sampler490_g251382 = staticSwitch38_g251391;
				float2 temp_output_462_0_g251382 = (Out_MaskB456_g251382).xy;
				half2 ZY490_g251382 = temp_output_462_0_g251382;
				half2 XZ490_g251382 = temp_output_463_0_g251382;
				float2 temp_output_464_0_g251382 = (Out_MaskC456_g251382).xy;
				half2 XY490_g251382 = temp_output_464_0_g251382;
				half Bias490_g251382 = temp_output_504_0_g251382;
				float3 temp_output_482_0_g251382 = (Out_MaskN456_g251382).xyz;
				half3 Triplanar490_g251382 = temp_output_482_0_g251382;
				half3 NormalWS490_g251382 = temp_output_483_0_g251382;
				half3 Normal490_g251382 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g251382 = SamplePlanar3D( Texture490_g251382 , Sampler490_g251382 , ZY490_g251382 , XZ490_g251382 , XY490_g251382 , Bias490_g251382 , Triplanar490_g251382 , NormalWS490_g251382 , Normal490_g251382 );
				float4 temp_output_867_201_g251357 = localSamplePlanar3D490_g251382;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251382) = _SecondShaderTex;
				SamplerState Sampler498_g251382 = staticSwitch38_g251391;
				half2 XZ498_g251382 = temp_output_463_0_g251382;
				float2 temp_output_473_0_g251382 = (Out_MaskE456_g251382).xy;
				half2 XZ_1498_g251382 = temp_output_473_0_g251382;
				float2 temp_output_474_0_g251382 = (Out_MaskE456_g251382).zw;
				half2 XZ_2498_g251382 = temp_output_474_0_g251382;
				float2 temp_output_475_0_g251382 = (Out_MaskF456_g251382).xy;
				half2 XZ_3498_g251382 = temp_output_475_0_g251382;
				float temp_output_510_0_g251382 = exp2( temp_output_504_0_g251382 );
				half Bias498_g251382 = temp_output_510_0_g251382;
				float3 temp_output_480_0_g251382 = (Out_MaskI456_g251382).xyz;
				half3 Weights_2498_g251382 = temp_output_480_0_g251382;
				half3 NormalWS498_g251382 = temp_output_483_0_g251382;
				half3 Normal498_g251382 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g251382 = SampleStochastic2D( Texture498_g251382 , Sampler498_g251382 , XZ498_g251382 , XZ_1498_g251382 , XZ_2498_g251382 , XZ_3498_g251382 , Bias498_g251382 , Weights_2498_g251382 , NormalWS498_g251382 , Normal498_g251382 );
				float4 temp_output_867_202_g251357 = localSampleStochastic2D498_g251382;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251382) = _SecondShaderTex;
				SamplerState Sampler500_g251382 = staticSwitch38_g251391;
				half2 ZY500_g251382 = temp_output_462_0_g251382;
				half2 ZY_1500_g251382 = (Out_MaskC456_g251382).zw;
				half2 ZY_2500_g251382 = (Out_MaskD456_g251382).xy;
				half2 ZY_3500_g251382 = (Out_MaskD456_g251382).zw;
				half2 XZ500_g251382 = temp_output_463_0_g251382;
				half2 XZ_1500_g251382 = temp_output_473_0_g251382;
				half2 XZ_2500_g251382 = temp_output_474_0_g251382;
				half2 XZ_3500_g251382 = temp_output_475_0_g251382;
				half2 XY500_g251382 = temp_output_464_0_g251382;
				half2 XY_1500_g251382 = (Out_MaskF456_g251382).zw;
				half2 XY_2500_g251382 = (Out_MaskG456_g251382).xy;
				half2 XY_3500_g251382 = (Out_MaskG456_g251382).zw;
				half Bias500_g251382 = temp_output_510_0_g251382;
				half3 Weights_1500_g251382 = (Out_MaskH456_g251382).xyz;
				half3 Weights_2500_g251382 = temp_output_480_0_g251382;
				half3 Weights_3500_g251382 = (Out_MaskJ456_g251382).xyz;
				half3 Triplanar500_g251382 = temp_output_482_0_g251382;
				half3 NormalWS500_g251382 = temp_output_483_0_g251382;
				half3 Normal500_g251382 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g251382 = SampleStochastic3D( Texture500_g251382 , Sampler500_g251382 , ZY500_g251382 , ZY_1500_g251382 , ZY_2500_g251382 , ZY_3500_g251382 , XZ500_g251382 , XZ_1500_g251382 , XZ_2500_g251382 , XZ_3500_g251382 , XY500_g251382 , XY_1500_g251382 , XY_2500_g251382 , XY_3500_g251382 , Bias500_g251382 , Weights_1500_g251382 , Weights_2500_g251382 , Weights_3500_g251382 , Triplanar500_g251382 , NormalWS500_g251382 , Normal500_g251382 );
				float4 temp_output_867_203_g251357 = localSampleStochastic3D500_g251382;
				#if defined( TVE_SECOND_SAMPLE_MAIN_UV )
				float4 staticSwitch722_g251357 = temp_output_867_277_g251357;
				#elif defined( TVE_SECOND_SAMPLE_EXTRA_UV )
				float4 staticSwitch722_g251357 = temp_output_867_278_g251357;
				#elif defined( TVE_SECOND_SAMPLE_PLANAR_2D )
				float4 staticSwitch722_g251357 = temp_output_867_0_g251357;
				#elif defined( TVE_SECOND_SAMPLE_PLANAR_3D )
				float4 staticSwitch722_g251357 = temp_output_867_201_g251357;
				#elif defined( TVE_SECOND_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch722_g251357 = temp_output_867_202_g251357;
				#elif defined( TVE_SECOND_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch722_g251357 = temp_output_867_203_g251357;
				#else
				float4 staticSwitch722_g251357 = temp_output_867_277_g251357;
				#endif
				half4 Local_ShaderSample775_g251357 = staticSwitch722_g251357;
				float clampResult17_g251384 = clamp( (Local_ShaderSample775_g251357).y , 0.0001 , 0.9999 );
				float temp_output_7_0_g251399 = _SecondOcclusionRemap.x;
				float temp_output_9_0_g251399 = ( clampResult17_g251384 - temp_output_7_0_g251399 );
				float lerpResult1058_g251357 = lerp( 1.0 , saturate( ( temp_output_9_0_g251399 * _SecondOcclusionRemap.z ) ) , _SecondOcclusionValue);
				half Local_Occlusion1067_g251357 = lerpResult1058_g251357;
				float clampResult17_g251385 = clamp( (Local_ShaderSample775_g251357).w , 0.0001 , 0.9999 );
				float temp_output_7_0_g251400 = _SecondSmoothnessRemap.x;
				float temp_output_9_0_g251400 = ( clampResult17_g251385 - temp_output_7_0_g251400 );
				half Local_Smoothness1068_g251357 = ( saturate( ( temp_output_9_0_g251400 * _SecondSmoothnessRemap.z ) ) * _SecondSmoothnessValue );
				float4 appendResult749_g251357 = (float4(( (Local_ShaderSample775_g251357).x * _SecondMetallicValue ) , Local_Occlusion1067_g251357 , (Local_ShaderSample775_g251357).z , Local_Smoothness1068_g251357));
				half4 Local_Shader750_g251357 = appendResult749_g251357;
				float4 lerpResult994_g251357 = lerp( Local_Shader750_g251357 , ( Visual_Shader531_g251357 * Local_Shader750_g251357 ) , _SecondBlendShaderValue);
				float4 lerpResult440_g251357 = lerp( Visual_Shader531_g251357 , lerpResult994_g251357 , Blend_Mask412_g251357);
				#ifdef TVE_SECOND
				float4 staticSwitch451_g251357 = lerpResult440_g251357;
				#else
				float4 staticSwitch451_g251357 = Visual_Shader531_g251357;
				#endif
				half4 Final_Shader613_g251357 = staticSwitch451_g251357;
				float4 In_Shader3_g251379 = Final_Shader613_g251357;
				float4 In_Feature3_g251379 = Out_Feature4_g251380;
				float4 In_Season3_g251379 = Out_Season4_g251380;
				float4 In_Emissive3_g251379 = Out_Emissive4_g251380;
				half Visual_Grayscale590_g251357 = Out_Grayscale4_g251380;
				float3 temp_output_3_0_g251366 = Final_Albedo601_g251357;
				float dotResult20_g251366 = dot( temp_output_3_0_g251366 , float3( 0.2126, 0.7152, 0.0722 ) );
				float temp_output_583_0_g251357 = dotResult20_g251366;
				#ifdef TVE_SECOND
				float staticSwitch1116_g251357 = temp_output_583_0_g251357;
				#else
				float staticSwitch1116_g251357 = Visual_Grayscale590_g251357;
				#endif
				half Final_Grayscale615_g251357 = staticSwitch1116_g251357;
				float temp_output_12_0_g251379 = Final_Grayscale615_g251357;
				float In_Grayscale3_g251379 = temp_output_12_0_g251379;
				float clampResult27_g251368 = clamp( saturate( ( Final_Grayscale615_g251357 * 5.0 ) ) , 0.2 , 1.0 );
				float temp_output_1180_0_g251357 = clampResult27_g251368;
				#ifdef TVE_SECOND
				float staticSwitch1117_g251357 = temp_output_1180_0_g251357;
				#else
				float staticSwitch1117_g251357 = Visual_Luminosity1041_g251357;
				#endif
				half Final_Luminosity652_g251357 = staticSwitch1117_g251357;
				float temp_output_16_0_g251379 = Final_Luminosity652_g251357;
				float In_Luminosity3_g251379 = temp_output_16_0_g251379;
				half Visual_MultiMask547_g251357 = Out_MultiMask4_g251380;
				float clampResult17_g251386 = clamp( (Local_ShaderSample775_g251357).z , 0.0001 , 0.9999 );
				float temp_output_7_0_g251401 = _SecondMultiRemap.x;
				float temp_output_9_0_g251401 = ( clampResult17_g251386 - temp_output_7_0_g251401 );
				float temp_output_1252_0_g251357 = saturate( ( temp_output_9_0_g251401 * _SecondMultiRemap.z ) );
				half Local_MultiMask767_g251357 = temp_output_1252_0_g251357;
				float lerpResult477_g251357 = lerp( Visual_MultiMask547_g251357 , Local_MultiMask767_g251357 , Blend_Mask412_g251357);
				#ifdef TVE_SECOND
				float staticSwitch482_g251357 = lerpResult477_g251357;
				#else
				float staticSwitch482_g251357 = Visual_MultiMask547_g251357;
				#endif
				half Final_MultiMask572_g251357 = staticSwitch482_g251357;
				float In_MultiMask3_g251379 = Final_MultiMask572_g251357;
				half Visual_AlphaClip559_g251357 = Out_AlphaClip4_g251380;
				float temp_output_718_0_g251357 = (Local_AlbedoSample777_g251357).w;
				#ifdef TVE_CLIPPING
				float staticSwitch932_g251357 = ( temp_output_718_0_g251357 - _SecondAlphaClipValue );
				#else
				float staticSwitch932_g251357 = temp_output_718_0_g251357;
				#endif
				half Local_AlphaClip772_g251357 = staticSwitch932_g251357;
				float lerpResult448_g251357 = lerp( Visual_AlphaClip559_g251357 , Local_AlphaClip772_g251357 , Blend_Mask412_g251357);
				#ifdef TVE_SECOND
				float staticSwitch564_g251357 = lerpResult448_g251357;
				#else
				float staticSwitch564_g251357 = Visual_AlphaClip559_g251357;
				#endif
				half Final_AlphaClip602_g251357 = staticSwitch564_g251357;
				float In_AlphaClip3_g251379 = Final_AlphaClip602_g251357;
				half Visual_AlphaFade588_g251357 = Out_AlphaFade4_g251380;
				half Local_AlphaFade773_g251357 = (_SecondColor).a;
				float lerpResult604_g251357 = lerp( Visual_AlphaFade588_g251357 , Local_AlphaFade773_g251357 , Blend_Mask412_g251357);
				#ifdef TVE_SECOND
				float staticSwitch608_g251357 = lerpResult604_g251357;
				#else
				float staticSwitch608_g251357 = Visual_AlphaFade588_g251357;
				#endif
				half Final_AlphaFade611_g251357 = staticSwitch608_g251357;
				float In_AlphaFade3_g251379 = Final_AlphaFade611_g251357;
				float3 In_Translucency3_g251379 = Out_Translucency4_g251380;
				float In_Transmission3_g251379 = Out_Transmission4_g251380;
				float In_Thickness3_g251379 = Out_Thickness4_g251380;
				float In_Diffusion3_g251379 = Out_Diffusion4_g251380;
				float In_Depth3_g251379 = Out_Depth4_g251380;
				BuildVisualData( Data3_g251379 , In_Dummy3_g251379 , In_Albedo3_g251379 , In_AlbedoBase3_g251379 , In_NormalTS3_g251379 , In_NormalWS3_g251379 , In_Shader3_g251379 , In_Feature3_g251379 , In_Season3_g251379 , In_Emissive3_g251379 , In_Grayscale3_g251379 , In_Luminosity3_g251379 , In_MultiMask3_g251379 , In_AlphaClip3_g251379 , In_AlphaFade3_g251379 , In_Translucency3_g251379 , In_Transmission3_g251379 , In_Thickness3_g251379 , In_Diffusion3_g251379 , In_Depth3_g251379 );
				TVEVisualData DataB25_g251405 = Data3_g251379;
				float Alpha25_g251405 = _SecondBakeMode;
				{
				if (Alpha25_g251405 < 0.5 )
				{
				Data25_g251405 = DataA25_g251405;
				}
				else
				{
				Data25_g251405 = DataB25_g251405;
				}
				}
				TVEVisualData DataA25_g251455 = Data25_g251405;
				float localBuildVisualData3_g251407 = ( 0.0 );
				float localBreakVisualData4_g251435 = ( 0.0 );
				TVEVisualData Data4_g251435 =(TVEVisualData)Data25_g251405;
				float Out_Dummy4_g251435 = 0.0;
				float3 Out_Albedo4_g251435 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g251435 = float3( 0,0,0 );
				float2 Out_NormalTS4_g251435 = float2( 0,0 );
				float3 Out_NormalWS4_g251435 = float3( 0,0,0 );
				float4 Out_Shader4_g251435 = float4( 0,0,0,0 );
				float4 Out_Feature4_g251435 = float4( 0,0,0,0 );
				float4 Out_Season4_g251435 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g251435 = float4( 0,0,0,0 );
				float Out_MultiMask4_g251435 = 0.0;
				float Out_Grayscale4_g251435 = 0.0;
				float Out_Luminosity4_g251435 = 0.0;
				float Out_AlphaClip4_g251435 = 0.0;
				float Out_AlphaFade4_g251435 = 0.0;
				float3 Out_Translucency4_g251435 = float3( 0,0,0 );
				float Out_Transmission4_g251435 = 0.0;
				float Out_Thickness4_g251435 = 0.0;
				float Out_Diffusion4_g251435 = 0.0;
				float Out_Depth4_g251435 = 0.0;
				BreakVisualData( Data4_g251435 , Out_Dummy4_g251435 , Out_Albedo4_g251435 , Out_AlbedoBase4_g251435 , Out_NormalTS4_g251435 , Out_NormalWS4_g251435 , Out_Shader4_g251435 , Out_Feature4_g251435 , Out_Season4_g251435 , Out_Emissive4_g251435 , Out_MultiMask4_g251435 , Out_Grayscale4_g251435 , Out_Luminosity4_g251435 , Out_AlphaClip4_g251435 , Out_AlphaFade4_g251435 , Out_Translucency4_g251435 , Out_Transmission4_g251435 , Out_Thickness4_g251435 , Out_Diffusion4_g251435 , Out_Depth4_g251435 );
				TVEVisualData Data3_g251407 =(TVEVisualData)Data4_g251435;
				half Dummy944_g251406 = ( ( _ThirdCategory + _ThirdEnd ) + _ThirdSpace0 + _ThirdBakeMode );
				float temp_output_14_0_g251407 = Dummy944_g251406;
				float In_Dummy3_g251407 = temp_output_14_0_g251407;
				half3 Visual_Albedo527_g251406 = Out_Albedo4_g251435;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251437) = _ThirdAlbedoTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g251448 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g251448 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g251448 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g251448 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g251448 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g251448 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler276_g251437 = staticSwitch36_g251448;
				float localBreakTextureData456_g251437 = ( 0.0 );
				float localBuildTextureData431_g251414 = ( 0.0 );
				TVEMasksData Data431_g251414 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g251414 = ( 0.0 );
				float4 temp_output_6_0_g251412 = _third_coord_value;
				float4 temp_output_7_0_g251412 = ( _ThirdSampleMode + _ThirdCoordMode + _ThirdCoordValue );
				#ifdef TVE_DUMMY
				float4 staticSwitch14_g251412 = ( temp_output_6_0_g251412 + temp_output_7_0_g251412 );
				#else
				float4 staticSwitch14_g251412 = temp_output_6_0_g251412;
				#endif
				half4 Local_CoordValue790_g251406 = staticSwitch14_g251412;
				float4 Coords444_g251414 = Local_CoordValue790_g251406;
				TVEModelData Data15_g251411 =(TVEModelData)Data16_g128405;
				float Out_Dummy15_g251411 = 0.0;
				float3 Out_PositionWS15_g251411 = float3( 0,0,0 );
				float3 Out_PositionWO15_g251411 = float3( 0,0,0 );
				float3 Out_PivotWS15_g251411 = float3( 0,0,0 );
				float3 Out_PivotWO15_g251411 = float3( 0,0,0 );
				float3 Out_NormalWS15_g251411 = float3( 0,0,0 );
				float3 Out_TangentWS15_g251411 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g251411 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g251411 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g251411 = float3( 0,0,0 );
				float4 Out_CoordsData15_g251411 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g251411 = float4( 0,0,0,0 );
				float4 Out_PhaseData15_g251411 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g251411 , Out_Dummy15_g251411 , Out_PositionWS15_g251411 , Out_PositionWO15_g251411 , Out_PivotWS15_g251411 , Out_PivotWO15_g251411 , Out_NormalWS15_g251411 , Out_TangentWS15_g251411 , Out_BitangentWS15_g251411 , Out_TriplanarWeights15_g251411 , Out_ViewDirWS15_g251411 , Out_CoordsData15_g251411 , Out_VertexData15_g251411 , Out_PhaseData15_g251411 );
				float4 Model_CoordsData1111_g251406 = Out_CoordsData15_g251411;
				float4 MeshCoords444_g251414 = Model_CoordsData1111_g251406;
				float2 UV0444_g251414 = float2( 0,0 );
				float2 UV3444_g251414 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g251414 , MeshCoords444_g251414 , UV0444_g251414 , UV3444_g251414 );
				float4 appendResult430_g251414 = (float4(UV0444_g251414 , UV3444_g251414));
				float4 In_MaskA431_g251414 = appendResult430_g251414;
				float localComputeWorldCoords315_g251414 = ( 0.0 );
				float4 Coords315_g251414 = Local_CoordValue790_g251406;
				float3 Model_PositionWO636_g251406 = Out_PositionWO15_g251411;
				float3 PositionWS315_g251414 = Model_PositionWO636_g251406;
				float2 ZY315_g251414 = float2( 0,0 );
				float2 XZ315_g251414 = float2( 0,0 );
				float2 XY315_g251414 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g251414 , PositionWS315_g251414 , ZY315_g251414 , XZ315_g251414 , XY315_g251414 );
				float2 ZY402_g251414 = ZY315_g251414;
				float2 XZ403_g251414 = XZ315_g251414;
				float4 appendResult432_g251414 = (float4(ZY402_g251414 , XZ403_g251414));
				float4 In_MaskB431_g251414 = appendResult432_g251414;
				float2 XY404_g251414 = XY315_g251414;
				float localComputeStochasticCoords409_g251414 = ( 0.0 );
				float2 UV409_g251414 = ZY402_g251414;
				float2 UV1409_g251414 = float2( 0,0 );
				float2 UV2409_g251414 = float2( 0,0 );
				float2 UV3409_g251414 = float2( 0,0 );
				float3 Weights409_g251414 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g251414 , UV1409_g251414 , UV2409_g251414 , UV3409_g251414 , Weights409_g251414 );
				float4 appendResult433_g251414 = (float4(XY404_g251414 , UV1409_g251414));
				float4 In_MaskC431_g251414 = appendResult433_g251414;
				float4 appendResult434_g251414 = (float4(UV2409_g251414 , UV3409_g251414));
				float4 In_MaskD431_g251414 = appendResult434_g251414;
				float localComputeStochasticCoords422_g251414 = ( 0.0 );
				float2 UV422_g251414 = XZ403_g251414;
				float2 UV1422_g251414 = float2( 0,0 );
				float2 UV2422_g251414 = float2( 0,0 );
				float2 UV3422_g251414 = float2( 0,0 );
				float3 Weights422_g251414 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g251414 , UV1422_g251414 , UV2422_g251414 , UV3422_g251414 , Weights422_g251414 );
				float4 appendResult435_g251414 = (float4(UV1422_g251414 , UV2422_g251414));
				float4 In_MaskE431_g251414 = appendResult435_g251414;
				float localComputeStochasticCoords423_g251414 = ( 0.0 );
				float2 UV423_g251414 = XY404_g251414;
				float2 UV1423_g251414 = float2( 0,0 );
				float2 UV2423_g251414 = float2( 0,0 );
				float2 UV3423_g251414 = float2( 0,0 );
				float3 Weights423_g251414 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g251414 , UV1423_g251414 , UV2423_g251414 , UV3423_g251414 , Weights423_g251414 );
				float4 appendResult436_g251414 = (float4(UV3422_g251414 , UV1423_g251414));
				float4 In_MaskF431_g251414 = appendResult436_g251414;
				float4 appendResult437_g251414 = (float4(UV2423_g251414 , UV3423_g251414));
				float4 In_MaskG431_g251414 = appendResult437_g251414;
				float4 In_MaskH431_g251414 = float4( Weights409_g251414 , 0.0 );
				float4 In_MaskI431_g251414 = float4( Weights422_g251414 , 0.0 );
				float4 In_MaskJ431_g251414 = float4( Weights423_g251414 , 0.0 );
				half3 Model_NormalWS869_g251406 = Out_NormalWS15_g251411;
				float3 temp_output_449_0_g251414 = Model_NormalWS869_g251406;
				float4 In_MaskK431_g251414 = float4( temp_output_449_0_g251414 , 0.0 );
				half3 Model_TangentWS1226_g251406 = Out_TangentWS15_g251411;
				float3 temp_output_450_0_g251414 = Model_TangentWS1226_g251406;
				float4 In_MaskL431_g251414 = float4( temp_output_450_0_g251414 , 0.0 );
				half3 Model_BitangentWS1227_g251406 = Out_BitangentWS15_g251411;
				float3 temp_output_451_0_g251414 = Model_BitangentWS1227_g251406;
				float4 In_MaskM431_g251414 = float4( temp_output_451_0_g251414 , 0.0 );
				half3 Model_TriplanarWeights1228_g251406 = Out_TriplanarWeights15_g251411;
				float3 temp_output_445_0_g251414 = Model_TriplanarWeights1228_g251406;
				float4 In_MaskN431_g251414 = float4( temp_output_445_0_g251414 , 0.0 );
				BuildTextureData( Data431_g251414 , In_MaskA431_g251414 , In_MaskB431_g251414 , In_MaskC431_g251414 , In_MaskD431_g251414 , In_MaskE431_g251414 , In_MaskF431_g251414 , In_MaskG431_g251414 , In_MaskH431_g251414 , In_MaskI431_g251414 , In_MaskJ431_g251414 , In_MaskK431_g251414 , In_MaskL431_g251414 , In_MaskM431_g251414 , In_MaskN431_g251414 );
				TVEMasksData Data456_g251437 =(TVEMasksData)Data431_g251414;
				float4 Out_MaskA456_g251437 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g251437 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g251437 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g251437 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g251437 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g251437 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g251437 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g251437 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g251437 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g251437 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g251437 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g251437 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g251437 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g251437 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g251437 , Out_MaskA456_g251437 , Out_MaskB456_g251437 , Out_MaskC456_g251437 , Out_MaskD456_g251437 , Out_MaskE456_g251437 , Out_MaskF456_g251437 , Out_MaskG456_g251437 , Out_MaskH456_g251437 , Out_MaskI456_g251437 , Out_MaskJ456_g251437 , Out_MaskK456_g251437 , Out_MaskL456_g251437 , Out_MaskM456_g251437 , Out_MaskN456_g251437 );
				half2 UV276_g251437 = (Out_MaskA456_g251437).xy;
				float temp_output_504_0_g251437 = 0.0;
				half Bias276_g251437 = temp_output_504_0_g251437;
				half2 Normal276_g251437 = float2( 0,0 );
				half4 localSampleCoord276_g251437 = SampleCoord( Texture276_g251437 , Sampler276_g251437 , UV276_g251437 , Bias276_g251437 , Normal276_g251437 );
				float4 temp_output_1115_277_g251406 = localSampleCoord276_g251437;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251437) = _ThirdAlbedoTex;
				SamplerState Sampler502_g251437 = staticSwitch36_g251448;
				half2 UV502_g251437 = (Out_MaskA456_g251437).zw;
				half Bias502_g251437 = temp_output_504_0_g251437;
				half2 Normal502_g251437 = float2( 0,0 );
				half4 localSampleCoord502_g251437 = SampleCoord( Texture502_g251437 , Sampler502_g251437 , UV502_g251437 , Bias502_g251437 , Normal502_g251437 );
				float4 temp_output_1115_278_g251406 = localSampleCoord502_g251437;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251437) = _ThirdAlbedoTex;
				SamplerState Sampler496_g251437 = staticSwitch36_g251448;
				float2 temp_output_463_0_g251437 = (Out_MaskB456_g251437).zw;
				half2 XZ496_g251437 = temp_output_463_0_g251437;
				half Bias496_g251437 = temp_output_504_0_g251437;
				float3 temp_output_483_0_g251437 = (Out_MaskK456_g251437).xyz;
				half3 NormalWS496_g251437 = temp_output_483_0_g251437;
				half3 Normal496_g251437 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g251437 = SamplePlanar2D( Texture496_g251437 , Sampler496_g251437 , XZ496_g251437 , Bias496_g251437 , NormalWS496_g251437 , Normal496_g251437 );
				float4 temp_output_1115_0_g251406 = localSamplePlanar2D496_g251437;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251437) = _ThirdAlbedoTex;
				SamplerState Sampler490_g251437 = staticSwitch36_g251448;
				float2 temp_output_462_0_g251437 = (Out_MaskB456_g251437).xy;
				half2 ZY490_g251437 = temp_output_462_0_g251437;
				half2 XZ490_g251437 = temp_output_463_0_g251437;
				float2 temp_output_464_0_g251437 = (Out_MaskC456_g251437).xy;
				half2 XY490_g251437 = temp_output_464_0_g251437;
				half Bias490_g251437 = temp_output_504_0_g251437;
				float3 temp_output_482_0_g251437 = (Out_MaskN456_g251437).xyz;
				half3 Triplanar490_g251437 = temp_output_482_0_g251437;
				half3 NormalWS490_g251437 = temp_output_483_0_g251437;
				half3 Normal490_g251437 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g251437 = SamplePlanar3D( Texture490_g251437 , Sampler490_g251437 , ZY490_g251437 , XZ490_g251437 , XY490_g251437 , Bias490_g251437 , Triplanar490_g251437 , NormalWS490_g251437 , Normal490_g251437 );
				float4 temp_output_1115_201_g251406 = localSamplePlanar3D490_g251437;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251437) = _ThirdAlbedoTex;
				SamplerState Sampler498_g251437 = staticSwitch36_g251448;
				half2 XZ498_g251437 = temp_output_463_0_g251437;
				float2 temp_output_473_0_g251437 = (Out_MaskE456_g251437).xy;
				half2 XZ_1498_g251437 = temp_output_473_0_g251437;
				float2 temp_output_474_0_g251437 = (Out_MaskE456_g251437).zw;
				half2 XZ_2498_g251437 = temp_output_474_0_g251437;
				float2 temp_output_475_0_g251437 = (Out_MaskF456_g251437).xy;
				half2 XZ_3498_g251437 = temp_output_475_0_g251437;
				float temp_output_510_0_g251437 = exp2( temp_output_504_0_g251437 );
				half Bias498_g251437 = temp_output_510_0_g251437;
				float3 temp_output_480_0_g251437 = (Out_MaskI456_g251437).xyz;
				half3 Weights_2498_g251437 = temp_output_480_0_g251437;
				half3 NormalWS498_g251437 = temp_output_483_0_g251437;
				half3 Normal498_g251437 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g251437 = SampleStochastic2D( Texture498_g251437 , Sampler498_g251437 , XZ498_g251437 , XZ_1498_g251437 , XZ_2498_g251437 , XZ_3498_g251437 , Bias498_g251437 , Weights_2498_g251437 , NormalWS498_g251437 , Normal498_g251437 );
				float4 temp_output_1115_202_g251406 = localSampleStochastic2D498_g251437;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251437) = _ThirdAlbedoTex;
				SamplerState Sampler500_g251437 = staticSwitch36_g251448;
				half2 ZY500_g251437 = temp_output_462_0_g251437;
				half2 ZY_1500_g251437 = (Out_MaskC456_g251437).zw;
				half2 ZY_2500_g251437 = (Out_MaskD456_g251437).xy;
				half2 ZY_3500_g251437 = (Out_MaskD456_g251437).zw;
				half2 XZ500_g251437 = temp_output_463_0_g251437;
				half2 XZ_1500_g251437 = temp_output_473_0_g251437;
				half2 XZ_2500_g251437 = temp_output_474_0_g251437;
				half2 XZ_3500_g251437 = temp_output_475_0_g251437;
				half2 XY500_g251437 = temp_output_464_0_g251437;
				half2 XY_1500_g251437 = (Out_MaskF456_g251437).zw;
				half2 XY_2500_g251437 = (Out_MaskG456_g251437).xy;
				half2 XY_3500_g251437 = (Out_MaskG456_g251437).zw;
				half Bias500_g251437 = temp_output_510_0_g251437;
				half3 Weights_1500_g251437 = (Out_MaskH456_g251437).xyz;
				half3 Weights_2500_g251437 = temp_output_480_0_g251437;
				half3 Weights_3500_g251437 = (Out_MaskJ456_g251437).xyz;
				half3 Triplanar500_g251437 = temp_output_482_0_g251437;
				half3 NormalWS500_g251437 = temp_output_483_0_g251437;
				half3 Normal500_g251437 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g251437 = SampleStochastic3D( Texture500_g251437 , Sampler500_g251437 , ZY500_g251437 , ZY_1500_g251437 , ZY_2500_g251437 , ZY_3500_g251437 , XZ500_g251437 , XZ_1500_g251437 , XZ_2500_g251437 , XZ_3500_g251437 , XY500_g251437 , XY_1500_g251437 , XY_2500_g251437 , XY_3500_g251437 , Bias500_g251437 , Weights_1500_g251437 , Weights_2500_g251437 , Weights_3500_g251437 , Triplanar500_g251437 , NormalWS500_g251437 , Normal500_g251437 );
				float4 temp_output_1115_203_g251406 = localSampleStochastic3D500_g251437;
				#if defined( TVE_THIRD_SAMPLE_MAIN_UV )
				float4 staticSwitch693_g251406 = temp_output_1115_277_g251406;
				#elif defined( TVE_THIRD_SAMPLE_EXTRA_UV )
				float4 staticSwitch693_g251406 = temp_output_1115_278_g251406;
				#elif defined( TVE_THIRD_SAMPLE_PLANAR_2D )
				float4 staticSwitch693_g251406 = temp_output_1115_0_g251406;
				#elif defined( TVE_THIRD_SAMPLE_PLANAR_3D )
				float4 staticSwitch693_g251406 = temp_output_1115_201_g251406;
				#elif defined( TVE_THIRD_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch693_g251406 = temp_output_1115_202_g251406;
				#elif defined( TVE_THIRD_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch693_g251406 = temp_output_1115_203_g251406;
				#else
				float4 staticSwitch693_g251406 = temp_output_1115_277_g251406;
				#endif
				half4 Local_AlbedoSample777_g251406 = staticSwitch693_g251406;
				float3 lerpResult716_g251406 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample777_g251406).xyz , _ThirdAlbedoValue);
				half3 Local_AlbedoRGB771_g251406 = lerpResult716_g251406;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251438) = _ThirdShaderTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch38_g251450 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch38_g251450 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch38_g251450 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch38_g251450 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch38_g251450 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch38_g251450 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g251438 = staticSwitch38_g251450;
				float localBreakTextureData456_g251438 = ( 0.0 );
				TVEMasksData Data456_g251438 =(TVEMasksData)Data431_g251414;
				float4 Out_MaskA456_g251438 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g251438 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g251438 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g251438 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g251438 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g251438 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g251438 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g251438 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g251438 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g251438 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g251438 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g251438 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g251438 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g251438 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g251438 , Out_MaskA456_g251438 , Out_MaskB456_g251438 , Out_MaskC456_g251438 , Out_MaskD456_g251438 , Out_MaskE456_g251438 , Out_MaskF456_g251438 , Out_MaskG456_g251438 , Out_MaskH456_g251438 , Out_MaskI456_g251438 , Out_MaskJ456_g251438 , Out_MaskK456_g251438 , Out_MaskL456_g251438 , Out_MaskM456_g251438 , Out_MaskN456_g251438 );
				half2 UV276_g251438 = (Out_MaskA456_g251438).xy;
				float temp_output_504_0_g251438 = 0.0;
				half Bias276_g251438 = temp_output_504_0_g251438;
				half2 Normal276_g251438 = float2( 0,0 );
				half4 localSampleCoord276_g251438 = SampleCoord( Texture276_g251438 , Sampler276_g251438 , UV276_g251438 , Bias276_g251438 , Normal276_g251438 );
				float4 temp_output_1113_277_g251406 = localSampleCoord276_g251438;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251438) = _ThirdShaderTex;
				SamplerState Sampler502_g251438 = staticSwitch38_g251450;
				half2 UV502_g251438 = (Out_MaskA456_g251438).zw;
				half Bias502_g251438 = temp_output_504_0_g251438;
				half2 Normal502_g251438 = float2( 0,0 );
				half4 localSampleCoord502_g251438 = SampleCoord( Texture502_g251438 , Sampler502_g251438 , UV502_g251438 , Bias502_g251438 , Normal502_g251438 );
				float4 temp_output_1113_278_g251406 = localSampleCoord502_g251438;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251438) = _ThirdShaderTex;
				SamplerState Sampler496_g251438 = staticSwitch38_g251450;
				float2 temp_output_463_0_g251438 = (Out_MaskB456_g251438).zw;
				half2 XZ496_g251438 = temp_output_463_0_g251438;
				half Bias496_g251438 = temp_output_504_0_g251438;
				float3 temp_output_483_0_g251438 = (Out_MaskK456_g251438).xyz;
				half3 NormalWS496_g251438 = temp_output_483_0_g251438;
				half3 Normal496_g251438 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g251438 = SamplePlanar2D( Texture496_g251438 , Sampler496_g251438 , XZ496_g251438 , Bias496_g251438 , NormalWS496_g251438 , Normal496_g251438 );
				float4 temp_output_1113_0_g251406 = localSamplePlanar2D496_g251438;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251438) = _ThirdShaderTex;
				SamplerState Sampler490_g251438 = staticSwitch38_g251450;
				float2 temp_output_462_0_g251438 = (Out_MaskB456_g251438).xy;
				half2 ZY490_g251438 = temp_output_462_0_g251438;
				half2 XZ490_g251438 = temp_output_463_0_g251438;
				float2 temp_output_464_0_g251438 = (Out_MaskC456_g251438).xy;
				half2 XY490_g251438 = temp_output_464_0_g251438;
				half Bias490_g251438 = temp_output_504_0_g251438;
				float3 temp_output_482_0_g251438 = (Out_MaskN456_g251438).xyz;
				half3 Triplanar490_g251438 = temp_output_482_0_g251438;
				half3 NormalWS490_g251438 = temp_output_483_0_g251438;
				half3 Normal490_g251438 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g251438 = SamplePlanar3D( Texture490_g251438 , Sampler490_g251438 , ZY490_g251438 , XZ490_g251438 , XY490_g251438 , Bias490_g251438 , Triplanar490_g251438 , NormalWS490_g251438 , Normal490_g251438 );
				float4 temp_output_1113_201_g251406 = localSamplePlanar3D490_g251438;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251438) = _ThirdShaderTex;
				SamplerState Sampler498_g251438 = staticSwitch38_g251450;
				half2 XZ498_g251438 = temp_output_463_0_g251438;
				float2 temp_output_473_0_g251438 = (Out_MaskE456_g251438).xy;
				half2 XZ_1498_g251438 = temp_output_473_0_g251438;
				float2 temp_output_474_0_g251438 = (Out_MaskE456_g251438).zw;
				half2 XZ_2498_g251438 = temp_output_474_0_g251438;
				float2 temp_output_475_0_g251438 = (Out_MaskF456_g251438).xy;
				half2 XZ_3498_g251438 = temp_output_475_0_g251438;
				float temp_output_510_0_g251438 = exp2( temp_output_504_0_g251438 );
				half Bias498_g251438 = temp_output_510_0_g251438;
				float3 temp_output_480_0_g251438 = (Out_MaskI456_g251438).xyz;
				half3 Weights_2498_g251438 = temp_output_480_0_g251438;
				half3 NormalWS498_g251438 = temp_output_483_0_g251438;
				half3 Normal498_g251438 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g251438 = SampleStochastic2D( Texture498_g251438 , Sampler498_g251438 , XZ498_g251438 , XZ_1498_g251438 , XZ_2498_g251438 , XZ_3498_g251438 , Bias498_g251438 , Weights_2498_g251438 , NormalWS498_g251438 , Normal498_g251438 );
				float4 temp_output_1113_202_g251406 = localSampleStochastic2D498_g251438;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251438) = _ThirdShaderTex;
				SamplerState Sampler500_g251438 = staticSwitch38_g251450;
				half2 ZY500_g251438 = temp_output_462_0_g251438;
				half2 ZY_1500_g251438 = (Out_MaskC456_g251438).zw;
				half2 ZY_2500_g251438 = (Out_MaskD456_g251438).xy;
				half2 ZY_3500_g251438 = (Out_MaskD456_g251438).zw;
				half2 XZ500_g251438 = temp_output_463_0_g251438;
				half2 XZ_1500_g251438 = temp_output_473_0_g251438;
				half2 XZ_2500_g251438 = temp_output_474_0_g251438;
				half2 XZ_3500_g251438 = temp_output_475_0_g251438;
				half2 XY500_g251438 = temp_output_464_0_g251438;
				half2 XY_1500_g251438 = (Out_MaskF456_g251438).zw;
				half2 XY_2500_g251438 = (Out_MaskG456_g251438).xy;
				half2 XY_3500_g251438 = (Out_MaskG456_g251438).zw;
				half Bias500_g251438 = temp_output_510_0_g251438;
				half3 Weights_1500_g251438 = (Out_MaskH456_g251438).xyz;
				half3 Weights_2500_g251438 = temp_output_480_0_g251438;
				half3 Weights_3500_g251438 = (Out_MaskJ456_g251438).xyz;
				half3 Triplanar500_g251438 = temp_output_482_0_g251438;
				half3 NormalWS500_g251438 = temp_output_483_0_g251438;
				half3 Normal500_g251438 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g251438 = SampleStochastic3D( Texture500_g251438 , Sampler500_g251438 , ZY500_g251438 , ZY_1500_g251438 , ZY_2500_g251438 , ZY_3500_g251438 , XZ500_g251438 , XZ_1500_g251438 , XZ_2500_g251438 , XZ_3500_g251438 , XY500_g251438 , XY_1500_g251438 , XY_2500_g251438 , XY_3500_g251438 , Bias500_g251438 , Weights_1500_g251438 , Weights_2500_g251438 , Weights_3500_g251438 , Triplanar500_g251438 , NormalWS500_g251438 , Normal500_g251438 );
				float4 temp_output_1113_203_g251406 = localSampleStochastic3D500_g251438;
				#if defined( TVE_THIRD_SAMPLE_MAIN_UV )
				float4 staticSwitch722_g251406 = temp_output_1113_277_g251406;
				#elif defined( TVE_THIRD_SAMPLE_EXTRA_UV )
				float4 staticSwitch722_g251406 = temp_output_1113_278_g251406;
				#elif defined( TVE_THIRD_SAMPLE_PLANAR_2D )
				float4 staticSwitch722_g251406 = temp_output_1113_0_g251406;
				#elif defined( TVE_THIRD_SAMPLE_PLANAR_3D )
				float4 staticSwitch722_g251406 = temp_output_1113_201_g251406;
				#elif defined( TVE_THIRD_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch722_g251406 = temp_output_1113_202_g251406;
				#elif defined( TVE_THIRD_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch722_g251406 = temp_output_1113_203_g251406;
				#else
				float4 staticSwitch722_g251406 = temp_output_1113_277_g251406;
				#endif
				half4 Local_ShaderSample775_g251406 = staticSwitch722_g251406;
				float temp_output_752_0_g251406 = (Local_ShaderSample775_g251406).z;
				float temp_output_7_0_g251444 = _ThirdMultiRemap.x;
				float temp_output_9_0_g251444 = ( temp_output_752_0_g251406 - temp_output_7_0_g251444 );
				half Local_MultiMask767_g251406 = ( saturate( ( temp_output_9_0_g251444 * _ThirdMultiRemap.z ) ) * _ThirdMultiValue );
				float lerpResult705_g251406 = lerp( 1.0 , Local_MultiMask767_g251406 , _ThirdColorMode);
				float3 lerpResult706_g251406 = lerp( _ThirdColorTwo , _ThirdColor , lerpResult705_g251406);
				half3 Local_ColorRGB774_g251406 = (lerpResult706_g251406).xyz;
				half3 Local_Albedo768_g251406 = ( Local_AlbedoRGB771_g251406 * Local_ColorRGB774_g251406 );
				float3 lerpResult985_g251406 = lerp( Local_Albedo768_g251406 , ( Visual_Albedo527_g251406 * Local_Albedo768_g251406 ) , _ThirdBlendAlbedoValue);
				float temp_output_17_0_g251453 = _ThirdMaskMode;
				float Option70_g251453 = temp_output_17_0_g251453;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251445) = _ThirdMaskTex;
				SamplerState Sampler276_g251445 = sampler_Linear_Repeat;
				float localBreakTextureData456_g251445 = ( 0.0 );
				float localBuildTextureData431_g251436 = ( 0.0 );
				TVEMasksData Data431_g251436 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g251436 = ( 0.0 );
				float4 temp_output_6_0_g251413 = _third_mask_coord_value;
				float4 temp_output_7_0_g251413 = ( _ThirdMaskSampleMode + _ThirdMaskCoordMode + _ThirdMaskCoordValue );
				#ifdef TVE_DUMMY
				float4 staticSwitch14_g251413 = ( temp_output_6_0_g251413 + temp_output_7_0_g251413 );
				#else
				float4 staticSwitch14_g251413 = temp_output_6_0_g251413;
				#endif
				half4 Local_MaskCoordValue813_g251406 = staticSwitch14_g251413;
				float4 Coords444_g251436 = Local_MaskCoordValue813_g251406;
				float4 MeshCoords444_g251436 = Model_CoordsData1111_g251406;
				float2 UV0444_g251436 = float2( 0,0 );
				float2 UV3444_g251436 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g251436 , MeshCoords444_g251436 , UV0444_g251436 , UV3444_g251436 );
				float4 appendResult430_g251436 = (float4(UV0444_g251436 , UV3444_g251436));
				float4 In_MaskA431_g251436 = appendResult430_g251436;
				float localComputeWorldCoords315_g251436 = ( 0.0 );
				float4 Coords315_g251436 = Local_MaskCoordValue813_g251406;
				float3 PositionWS315_g251436 = Model_PositionWO636_g251406;
				float2 ZY315_g251436 = float2( 0,0 );
				float2 XZ315_g251436 = float2( 0,0 );
				float2 XY315_g251436 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g251436 , PositionWS315_g251436 , ZY315_g251436 , XZ315_g251436 , XY315_g251436 );
				float2 ZY402_g251436 = ZY315_g251436;
				float2 XZ403_g251436 = XZ315_g251436;
				float4 appendResult432_g251436 = (float4(ZY402_g251436 , XZ403_g251436));
				float4 In_MaskB431_g251436 = appendResult432_g251436;
				float2 XY404_g251436 = XY315_g251436;
				float localComputeStochasticCoords409_g251436 = ( 0.0 );
				float2 UV409_g251436 = ZY402_g251436;
				float2 UV1409_g251436 = float2( 0,0 );
				float2 UV2409_g251436 = float2( 0,0 );
				float2 UV3409_g251436 = float2( 0,0 );
				float3 Weights409_g251436 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g251436 , UV1409_g251436 , UV2409_g251436 , UV3409_g251436 , Weights409_g251436 );
				float4 appendResult433_g251436 = (float4(XY404_g251436 , UV1409_g251436));
				float4 In_MaskC431_g251436 = appendResult433_g251436;
				float4 appendResult434_g251436 = (float4(UV2409_g251436 , UV3409_g251436));
				float4 In_MaskD431_g251436 = appendResult434_g251436;
				float localComputeStochasticCoords422_g251436 = ( 0.0 );
				float2 UV422_g251436 = XZ403_g251436;
				float2 UV1422_g251436 = float2( 0,0 );
				float2 UV2422_g251436 = float2( 0,0 );
				float2 UV3422_g251436 = float2( 0,0 );
				float3 Weights422_g251436 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g251436 , UV1422_g251436 , UV2422_g251436 , UV3422_g251436 , Weights422_g251436 );
				float4 appendResult435_g251436 = (float4(UV1422_g251436 , UV2422_g251436));
				float4 In_MaskE431_g251436 = appendResult435_g251436;
				float localComputeStochasticCoords423_g251436 = ( 0.0 );
				float2 UV423_g251436 = XY404_g251436;
				float2 UV1423_g251436 = float2( 0,0 );
				float2 UV2423_g251436 = float2( 0,0 );
				float2 UV3423_g251436 = float2( 0,0 );
				float3 Weights423_g251436 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g251436 , UV1423_g251436 , UV2423_g251436 , UV3423_g251436 , Weights423_g251436 );
				float4 appendResult436_g251436 = (float4(UV3422_g251436 , UV1423_g251436));
				float4 In_MaskF431_g251436 = appendResult436_g251436;
				float4 appendResult437_g251436 = (float4(UV2423_g251436 , UV3423_g251436));
				float4 In_MaskG431_g251436 = appendResult437_g251436;
				float4 In_MaskH431_g251436 = float4( Weights409_g251436 , 0.0 );
				float4 In_MaskI431_g251436 = float4( Weights422_g251436 , 0.0 );
				float4 In_MaskJ431_g251436 = float4( Weights423_g251436 , 0.0 );
				float3 temp_output_449_0_g251436 = Model_NormalWS869_g251406;
				float4 In_MaskK431_g251436 = float4( temp_output_449_0_g251436 , 0.0 );
				float3 temp_output_450_0_g251436 = Model_TangentWS1226_g251406;
				float4 In_MaskL431_g251436 = float4( temp_output_450_0_g251436 , 0.0 );
				float3 temp_output_451_0_g251436 = Model_BitangentWS1227_g251406;
				float4 In_MaskM431_g251436 = float4( temp_output_451_0_g251436 , 0.0 );
				float3 temp_output_445_0_g251436 = Model_TriplanarWeights1228_g251406;
				float4 In_MaskN431_g251436 = float4( temp_output_445_0_g251436 , 0.0 );
				BuildTextureData( Data431_g251436 , In_MaskA431_g251436 , In_MaskB431_g251436 , In_MaskC431_g251436 , In_MaskD431_g251436 , In_MaskE431_g251436 , In_MaskF431_g251436 , In_MaskG431_g251436 , In_MaskH431_g251436 , In_MaskI431_g251436 , In_MaskJ431_g251436 , In_MaskK431_g251436 , In_MaskL431_g251436 , In_MaskM431_g251436 , In_MaskN431_g251436 );
				TVEMasksData Data456_g251445 =(TVEMasksData)Data431_g251436;
				float4 Out_MaskA456_g251445 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g251445 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g251445 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g251445 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g251445 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g251445 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g251445 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g251445 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g251445 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g251445 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g251445 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g251445 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g251445 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g251445 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g251445 , Out_MaskA456_g251445 , Out_MaskB456_g251445 , Out_MaskC456_g251445 , Out_MaskD456_g251445 , Out_MaskE456_g251445 , Out_MaskF456_g251445 , Out_MaskG456_g251445 , Out_MaskH456_g251445 , Out_MaskI456_g251445 , Out_MaskJ456_g251445 , Out_MaskK456_g251445 , Out_MaskL456_g251445 , Out_MaskM456_g251445 , Out_MaskN456_g251445 );
				half2 UV276_g251445 = (Out_MaskA456_g251445).xy;
				float temp_output_504_0_g251445 = 0.0;
				half Bias276_g251445 = temp_output_504_0_g251445;
				half2 Normal276_g251445 = float2( 0,0 );
				half4 localSampleCoord276_g251445 = SampleCoord( Texture276_g251445 , Sampler276_g251445 , UV276_g251445 , Bias276_g251445 , Normal276_g251445 );
				float4 temp_output_1114_277_g251406 = localSampleCoord276_g251445;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251445) = _ThirdMaskTex;
				SamplerState Sampler502_g251445 = sampler_Linear_Repeat;
				half2 UV502_g251445 = (Out_MaskA456_g251445).zw;
				half Bias502_g251445 = temp_output_504_0_g251445;
				half2 Normal502_g251445 = float2( 0,0 );
				half4 localSampleCoord502_g251445 = SampleCoord( Texture502_g251445 , Sampler502_g251445 , UV502_g251445 , Bias502_g251445 , Normal502_g251445 );
				float4 temp_output_1114_278_g251406 = localSampleCoord502_g251445;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251445) = _ThirdMaskTex;
				SamplerState Sampler496_g251445 = sampler_Linear_Repeat;
				float2 temp_output_463_0_g251445 = (Out_MaskB456_g251445).zw;
				half2 XZ496_g251445 = temp_output_463_0_g251445;
				half Bias496_g251445 = temp_output_504_0_g251445;
				float3 temp_output_483_0_g251445 = (Out_MaskK456_g251445).xyz;
				half3 NormalWS496_g251445 = temp_output_483_0_g251445;
				half3 Normal496_g251445 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g251445 = SamplePlanar2D( Texture496_g251445 , Sampler496_g251445 , XZ496_g251445 , Bias496_g251445 , NormalWS496_g251445 , Normal496_g251445 );
				float4 temp_output_1114_0_g251406 = localSamplePlanar2D496_g251445;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251445) = _ThirdMaskTex;
				SamplerState Sampler490_g251445 = sampler_Linear_Repeat;
				float2 temp_output_462_0_g251445 = (Out_MaskB456_g251445).xy;
				half2 ZY490_g251445 = temp_output_462_0_g251445;
				half2 XZ490_g251445 = temp_output_463_0_g251445;
				float2 temp_output_464_0_g251445 = (Out_MaskC456_g251445).xy;
				half2 XY490_g251445 = temp_output_464_0_g251445;
				half Bias490_g251445 = temp_output_504_0_g251445;
				float3 temp_output_482_0_g251445 = (Out_MaskN456_g251445).xyz;
				half3 Triplanar490_g251445 = temp_output_482_0_g251445;
				half3 NormalWS490_g251445 = temp_output_483_0_g251445;
				half3 Normal490_g251445 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g251445 = SamplePlanar3D( Texture490_g251445 , Sampler490_g251445 , ZY490_g251445 , XZ490_g251445 , XY490_g251445 , Bias490_g251445 , Triplanar490_g251445 , NormalWS490_g251445 , Normal490_g251445 );
				float4 temp_output_1114_201_g251406 = localSamplePlanar3D490_g251445;
				#if defined( TVE_THIRD_MASK_SAMPLE_MAIN_UV )
				float4 staticSwitch817_g251406 = temp_output_1114_277_g251406;
				#elif defined( TVE_THIRD_MASK_SAMPLE_EXTRA_UV )
				float4 staticSwitch817_g251406 = temp_output_1114_278_g251406;
				#elif defined( TVE_THIRD_MASK_SAMPLE_PLANAR_2D )
				float4 staticSwitch817_g251406 = temp_output_1114_0_g251406;
				#elif defined( TVE_THIRD_MASK_SAMPLE_PLANAR_3D )
				float4 staticSwitch817_g251406 = temp_output_1114_201_g251406;
				#else
				float4 staticSwitch817_g251406 = temp_output_1114_277_g251406;
				#endif
				half4 Local_MaskSample861_g251406 = staticSwitch817_g251406;
				float4 temp_output_3_0_g251453 = Local_MaskSample861_g251406;
				float4 Channel70_g251453 = temp_output_3_0_g251453;
				float localSwitchChannel470_g251453 = SwitchChannel4( Option70_g251453 , Channel70_g251453 );
				float temp_output_1236_0_g251406 = localSwitchChannel470_g251453;
				float temp_output_7_0_g251426 = _ThirdMaskRemap.x;
				float temp_output_9_0_g251426 = ( temp_output_1236_0_g251406 - temp_output_7_0_g251426 );
				float lerpResult1028_g251406 = lerp( 1.0 , saturate( ( temp_output_9_0_g251426 * _ThirdMaskRemap.z ) ) , _ThirdMaskValue);
				#ifdef TVE_THIRD_MASK
				float staticSwitch1102_g251406 = lerpResult1028_g251406;
				#else
				float staticSwitch1102_g251406 = 1.0;
				#endif
				half Blend_TexMask429_g251406 = staticSwitch1102_g251406;
				half4 Visual_Shader531_g251406 = Out_Shader4_g251435;
				float temp_output_1092_0_g251406 = (Visual_Shader531_g251406).z;
				float temp_output_7_0_g251428 = _ThirdBaseRemap.x;
				float temp_output_9_0_g251428 = ( temp_output_1092_0_g251406 - temp_output_7_0_g251428 );
				float lerpResult1094_g251406 = lerp( 1.0 , saturate( ( temp_output_9_0_g251428 * _ThirdBaseRemap.z ) ) , _ThirdBaseValue);
				half Blend_BaseMask1098_g251406 = lerpResult1094_g251406;
				half Visual_Luminosity1049_g251406 = Out_Luminosity4_g251435;
				float temp_output_7_0_g251424 = _ThirdLumaRemap.x;
				float temp_output_9_0_g251424 = ( Visual_Luminosity1049_g251406 - temp_output_7_0_g251424 );
				float lerpResult1040_g251406 = lerp( 1.0 , saturate( ( temp_output_9_0_g251424 * _ThirdLumaRemap.z ) ) , _ThirdLumaValue);
				half Blend_LumaMask1046_g251406 = lerpResult1040_g251406;
				float temp_output_17_0_g251452 = _ThirdMeshMode;
				float Option70_g251452 = temp_output_17_0_g251452;
				half4 Model_VertexData960_g251406 = Out_VertexData15_g251411;
				float4 temp_output_3_0_g251452 = Model_VertexData960_g251406;
				float4 Channel70_g251452 = temp_output_3_0_g251452;
				float localSwitchChannel470_g251452 = SwitchChannel4( Option70_g251452 , Channel70_g251452 );
				float temp_output_1235_0_g251406 = localSwitchChannel470_g251452;
				float temp_output_7_0_g251420 = _ThirdMeshRemap.x;
				float temp_output_9_0_g251420 = ( temp_output_1235_0_g251406 - temp_output_7_0_g251420 );
				float lerpResult1026_g251406 = lerp( 1.0 , saturate( ( temp_output_9_0_g251420 * _ThirdMeshRemap.z ) ) , _ThirdMeshValue);
				half Blend_VertMask913_g251406 = lerpResult1026_g251406;
				half3 Visual_NormalWS953_g251406 = Out_NormalWS4_g251435;
				float temp_output_903_0_g251406 = saturate( (Visual_NormalWS953_g251406).y );
				float temp_output_7_0_g251430 = _ThirdProjRemap.x;
				float temp_output_9_0_g251430 = ( temp_output_903_0_g251406 - temp_output_7_0_g251430 );
				float lerpResult1004_g251406 = lerp( 1.0 , saturate( ( temp_output_9_0_g251430 * _ThirdProjRemap.z ) ) , _ThirdProjValue);
				half Blend_ProjMask912_g251406 = lerpResult1004_g251406;
				half Blend_GlobalMask968_g251406 = 1.0;
				float temp_output_432_0_g251406 = ( _ThirdIntensityValue * Blend_TexMask429_g251406 * Blend_BaseMask1098_g251406 * Blend_LumaMask1046_g251406 * Blend_VertMask913_g251406 * Blend_ProjMask912_g251406 * Blend_GlobalMask968_g251406 );
				float temp_output_7_0_g251422 = _ThirdBlendRemap.x;
				float temp_output_9_0_g251422 = ( temp_output_432_0_g251406 - temp_output_7_0_g251422 );
				half Blend_Mask412_g251406 = ( saturate( ( temp_output_9_0_g251422 * _ThirdBlendRemap.z ) ) * _ThirdBlendIntensityValue );
				float3 lerpResult989_g251406 = lerp( Visual_Albedo527_g251406 , lerpResult985_g251406 , Blend_Mask412_g251406);
				#ifdef TVE_THIRD
				float3 staticSwitch415_g251406 = lerpResult989_g251406;
				#else
				float3 staticSwitch415_g251406 = Visual_Albedo527_g251406;
				#endif
				half3 Final_Albedo601_g251406 = staticSwitch415_g251406;
				float3 temp_output_4_0_g251407 = Final_Albedo601_g251406;
				float3 In_Albedo3_g251407 = temp_output_4_0_g251407;
				float3 temp_output_44_0_g251407 = Final_Albedo601_g251406;
				float3 In_AlbedoBase3_g251407 = temp_output_44_0_g251407;
				half2 Visual_NormalTS529_g251406 = Out_NormalTS4_g251435;
				float2 lerpResult40_g251409 = lerp( float2( 0,0 ) , Visual_NormalTS529_g251406 , _ThirdBlendNormalValue);
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251446) = _ThirdNormalTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch37_g251449 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch37_g251449 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch37_g251449 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch37_g251449 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch37_g251449 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch37_g251449 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler276_g251446 = staticSwitch37_g251449;
				float localBreakTextureData456_g251446 = ( 0.0 );
				TVEMasksData Data456_g251446 =(TVEMasksData)Data431_g251414;
				float4 Out_MaskA456_g251446 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g251446 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g251446 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g251446 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g251446 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g251446 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g251446 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g251446 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g251446 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g251446 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g251446 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g251446 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g251446 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g251446 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g251446 , Out_MaskA456_g251446 , Out_MaskB456_g251446 , Out_MaskC456_g251446 , Out_MaskD456_g251446 , Out_MaskE456_g251446 , Out_MaskF456_g251446 , Out_MaskG456_g251446 , Out_MaskH456_g251446 , Out_MaskI456_g251446 , Out_MaskJ456_g251446 , Out_MaskK456_g251446 , Out_MaskL456_g251446 , Out_MaskM456_g251446 , Out_MaskN456_g251446 );
				half2 UV276_g251446 = (Out_MaskA456_g251446).xy;
				float temp_output_504_0_g251446 = 0.0;
				half Bias276_g251446 = temp_output_504_0_g251446;
				half2 Normal276_g251446 = float2( 0,0 );
				half4 localSampleCoord276_g251446 = SampleCoord( Texture276_g251446 , Sampler276_g251446 , UV276_g251446 , Bias276_g251446 , Normal276_g251446 );
				float2 temp_output_1112_394_g251406 = Normal276_g251446;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251446) = _ThirdNormalTex;
				SamplerState Sampler502_g251446 = staticSwitch37_g251449;
				half2 UV502_g251446 = (Out_MaskA456_g251446).zw;
				half Bias502_g251446 = temp_output_504_0_g251446;
				half2 Normal502_g251446 = float2( 0,0 );
				half4 localSampleCoord502_g251446 = SampleCoord( Texture502_g251446 , Sampler502_g251446 , UV502_g251446 , Bias502_g251446 , Normal502_g251446 );
				float2 temp_output_1112_397_g251406 = Normal502_g251446;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251446) = _ThirdNormalTex;
				SamplerState Sampler496_g251446 = staticSwitch37_g251449;
				float2 temp_output_463_0_g251446 = (Out_MaskB456_g251446).zw;
				half2 XZ496_g251446 = temp_output_463_0_g251446;
				half Bias496_g251446 = temp_output_504_0_g251446;
				float3 temp_output_483_0_g251446 = (Out_MaskK456_g251446).xyz;
				half3 NormalWS496_g251446 = temp_output_483_0_g251446;
				half3 Normal496_g251446 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g251446 = SamplePlanar2D( Texture496_g251446 , Sampler496_g251446 , XZ496_g251446 , Bias496_g251446 , NormalWS496_g251446 , Normal496_g251446 );
				float3 worldToTangentDir408_g251446 = normalize( mul( ase_worldToTangent, Normal496_g251446 ) );
				float2 temp_output_1112_375_g251406 = (worldToTangentDir408_g251446).xy;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251446) = _ThirdNormalTex;
				SamplerState Sampler490_g251446 = staticSwitch37_g251449;
				float2 temp_output_462_0_g251446 = (Out_MaskB456_g251446).xy;
				half2 ZY490_g251446 = temp_output_462_0_g251446;
				half2 XZ490_g251446 = temp_output_463_0_g251446;
				float2 temp_output_464_0_g251446 = (Out_MaskC456_g251446).xy;
				half2 XY490_g251446 = temp_output_464_0_g251446;
				half Bias490_g251446 = temp_output_504_0_g251446;
				float3 temp_output_482_0_g251446 = (Out_MaskN456_g251446).xyz;
				half3 Triplanar490_g251446 = temp_output_482_0_g251446;
				half3 NormalWS490_g251446 = temp_output_483_0_g251446;
				half3 Normal490_g251446 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g251446 = SamplePlanar3D( Texture490_g251446 , Sampler490_g251446 , ZY490_g251446 , XZ490_g251446 , XY490_g251446 , Bias490_g251446 , Triplanar490_g251446 , NormalWS490_g251446 , Normal490_g251446 );
				float3 worldToTangentDir399_g251446 = normalize( mul( ase_worldToTangent, Normal490_g251446 ) );
				float2 temp_output_1112_353_g251406 = (worldToTangentDir399_g251446).xy;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251446) = _ThirdNormalTex;
				SamplerState Sampler498_g251446 = staticSwitch37_g251449;
				half2 XZ498_g251446 = temp_output_463_0_g251446;
				float2 temp_output_473_0_g251446 = (Out_MaskE456_g251446).xy;
				half2 XZ_1498_g251446 = temp_output_473_0_g251446;
				float2 temp_output_474_0_g251446 = (Out_MaskE456_g251446).zw;
				half2 XZ_2498_g251446 = temp_output_474_0_g251446;
				float2 temp_output_475_0_g251446 = (Out_MaskF456_g251446).xy;
				half2 XZ_3498_g251446 = temp_output_475_0_g251446;
				float temp_output_510_0_g251446 = exp2( temp_output_504_0_g251446 );
				half Bias498_g251446 = temp_output_510_0_g251446;
				float3 temp_output_480_0_g251446 = (Out_MaskI456_g251446).xyz;
				half3 Weights_2498_g251446 = temp_output_480_0_g251446;
				half3 NormalWS498_g251446 = temp_output_483_0_g251446;
				half3 Normal498_g251446 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g251446 = SampleStochastic2D( Texture498_g251446 , Sampler498_g251446 , XZ498_g251446 , XZ_1498_g251446 , XZ_2498_g251446 , XZ_3498_g251446 , Bias498_g251446 , Weights_2498_g251446 , NormalWS498_g251446 , Normal498_g251446 );
				float3 worldToTangentDir411_g251446 = normalize( mul( ase_worldToTangent, Normal498_g251446 ) );
				float2 temp_output_1112_391_g251406 = (worldToTangentDir411_g251446).xy;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251446) = _ThirdNormalTex;
				SamplerState Sampler500_g251446 = staticSwitch37_g251449;
				half2 ZY500_g251446 = temp_output_462_0_g251446;
				half2 ZY_1500_g251446 = (Out_MaskC456_g251446).zw;
				half2 ZY_2500_g251446 = (Out_MaskD456_g251446).xy;
				half2 ZY_3500_g251446 = (Out_MaskD456_g251446).zw;
				half2 XZ500_g251446 = temp_output_463_0_g251446;
				half2 XZ_1500_g251446 = temp_output_473_0_g251446;
				half2 XZ_2500_g251446 = temp_output_474_0_g251446;
				half2 XZ_3500_g251446 = temp_output_475_0_g251446;
				half2 XY500_g251446 = temp_output_464_0_g251446;
				half2 XY_1500_g251446 = (Out_MaskF456_g251446).zw;
				half2 XY_2500_g251446 = (Out_MaskG456_g251446).xy;
				half2 XY_3500_g251446 = (Out_MaskG456_g251446).zw;
				half Bias500_g251446 = temp_output_510_0_g251446;
				half3 Weights_1500_g251446 = (Out_MaskH456_g251446).xyz;
				half3 Weights_2500_g251446 = temp_output_480_0_g251446;
				half3 Weights_3500_g251446 = (Out_MaskJ456_g251446).xyz;
				half3 Triplanar500_g251446 = temp_output_482_0_g251446;
				half3 NormalWS500_g251446 = temp_output_483_0_g251446;
				half3 Normal500_g251446 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g251446 = SampleStochastic3D( Texture500_g251446 , Sampler500_g251446 , ZY500_g251446 , ZY_1500_g251446 , ZY_2500_g251446 , ZY_3500_g251446 , XZ500_g251446 , XZ_1500_g251446 , XZ_2500_g251446 , XZ_3500_g251446 , XY500_g251446 , XY_1500_g251446 , XY_2500_g251446 , XY_3500_g251446 , Bias500_g251446 , Weights_1500_g251446 , Weights_2500_g251446 , Weights_3500_g251446 , Triplanar500_g251446 , NormalWS500_g251446 , Normal500_g251446 );
				float3 worldToTangentDir403_g251446 = normalize( mul( ase_worldToTangent, Normal500_g251446 ) );
				float2 temp_output_1112_390_g251406 = (worldToTangentDir403_g251446).xy;
				#if defined( TVE_THIRD_SAMPLE_MAIN_UV )
				float2 staticSwitch698_g251406 = temp_output_1112_394_g251406;
				#elif defined( TVE_THIRD_SAMPLE_EXTRA_UV )
				float2 staticSwitch698_g251406 = temp_output_1112_397_g251406;
				#elif defined( TVE_THIRD_SAMPLE_PLANAR_2D )
				float2 staticSwitch698_g251406 = temp_output_1112_375_g251406;
				#elif defined( TVE_THIRD_SAMPLE_PLANAR_3D )
				float2 staticSwitch698_g251406 = temp_output_1112_353_g251406;
				#elif defined( TVE_THIRD_SAMPLE_STOCHASTIC_2D )
				float2 staticSwitch698_g251406 = temp_output_1112_391_g251406;
				#elif defined( TVE_THIRD_SAMPLE_STOCHASTIC_3D )
				float2 staticSwitch698_g251406 = temp_output_1112_390_g251406;
				#else
				float2 staticSwitch698_g251406 = temp_output_1112_394_g251406;
				#endif
				half2 Local_NormalSample776_g251406 = staticSwitch698_g251406;
				half2 Local_NormalTS729_g251406 = ( Local_NormalSample776_g251406 * _ThirdNormalValue );
				float2 temp_output_36_0_g251409 = ( lerpResult40_g251409 + Local_NormalTS729_g251406 );
				float2 lerpResult405_g251406 = lerp( Visual_NormalTS529_g251406 , temp_output_36_0_g251409 , Blend_Mask412_g251406);
				#ifdef TVE_THIRD
				float2 staticSwitch418_g251406 = lerpResult405_g251406;
				#else
				float2 staticSwitch418_g251406 = Visual_NormalTS529_g251406;
				#endif
				half2 Final_NormalTS612_g251406 = staticSwitch418_g251406;
				float2 In_NormalTS3_g251407 = Final_NormalTS612_g251406;
				float3 appendResult68_g251416 = (float3(Final_NormalTS612_g251406 , 1.0));
				float3 tanNormal74_g251416 = appendResult68_g251416;
				float3 worldNormal74_g251416 = normalize( float3( dot( tanToWorld0, tanNormal74_g251416 ), dot( tanToWorld1, tanNormal74_g251416 ), dot( tanToWorld2, tanNormal74_g251416 ) ) );
				float3 temp_output_954_0_g251406 = worldNormal74_g251416;
				#ifdef TVE_THIRD
				float3 staticSwitch1128_g251406 = temp_output_954_0_g251406;
				#else
				float3 staticSwitch1128_g251406 = Visual_NormalWS953_g251406;
				#endif
				half3 Final_NormalWS956_g251406 = staticSwitch1128_g251406;
				float3 In_NormalWS3_g251407 = Final_NormalWS956_g251406;
				float temp_output_1070_0_g251406 = (Local_ShaderSample775_g251406).y;
				float temp_output_7_0_g251439 = _ThirdOcclusionRemap.x;
				float temp_output_9_0_g251439 = ( temp_output_1070_0_g251406 - temp_output_7_0_g251439 );
				float lerpResult1072_g251406 = lerp( 1.0 , saturate( ( temp_output_9_0_g251439 * _ThirdOcclusionRemap.z ) ) , _ThirdOcclusionValue);
				half Local_Occlusion1084_g251406 = lerpResult1072_g251406;
				float temp_output_1075_0_g251406 = (Local_ShaderSample775_g251406).w;
				float temp_output_7_0_g251441 = _ThirdSmoothnessRemap.x;
				float temp_output_9_0_g251441 = ( temp_output_1075_0_g251406 - temp_output_7_0_g251441 );
				half Local_Smoothness1085_g251406 = ( saturate( ( temp_output_9_0_g251441 * _ThirdSmoothnessRemap.z ) ) * _ThirdSmoothnessValue );
				float4 appendResult749_g251406 = (float4(( (Local_ShaderSample775_g251406).x * _ThirdMetallicValue ) , Local_Occlusion1084_g251406 , (Local_ShaderSample775_g251406).z , Local_Smoothness1085_g251406));
				half4 Local_Masks750_g251406 = appendResult749_g251406;
				float4 lerpResult1000_g251406 = lerp( Local_Masks750_g251406 , ( Visual_Shader531_g251406 * Local_Masks750_g251406 ) , _ThirdBlendShaderValue);
				float4 lerpResult998_g251406 = lerp( Visual_Shader531_g251406 , lerpResult1000_g251406 , Blend_Mask412_g251406);
				#ifdef TVE_THIRD
				float4 staticSwitch451_g251406 = lerpResult998_g251406;
				#else
				float4 staticSwitch451_g251406 = Visual_Shader531_g251406;
				#endif
				half4 Final_Masks613_g251406 = staticSwitch451_g251406;
				float4 In_Shader3_g251407 = Final_Masks613_g251406;
				float4 In_Feature3_g251407 = Out_Feature4_g251435;
				float4 In_Season3_g251407 = Out_Season4_g251435;
				float4 In_Emissive3_g251407 = Out_Emissive4_g251435;
				half Visual_Grayscale590_g251406 = Out_Grayscale4_g251435;
				float3 temp_output_3_0_g251417 = Final_Albedo601_g251406;
				float dotResult20_g251417 = dot( temp_output_3_0_g251417 , float3( 0.2126, 0.7152, 0.0722 ) );
				float temp_output_583_0_g251406 = dotResult20_g251417;
				#ifdef TVE_THIRD
				float staticSwitch1132_g251406 = temp_output_583_0_g251406;
				#else
				float staticSwitch1132_g251406 = Visual_Grayscale590_g251406;
				#endif
				half Final_Grayscale615_g251406 = staticSwitch1132_g251406;
				float temp_output_12_0_g251407 = Final_Grayscale615_g251406;
				float In_Grayscale3_g251407 = temp_output_12_0_g251407;
				float clampResult27_g251418 = clamp( saturate( ( Final_Grayscale615_g251406 * 5.0 ) ) , 0.2 , 1.0 );
				float temp_output_1209_0_g251406 = clampResult27_g251418;
				#ifdef TVE_THIRD
				float staticSwitch1134_g251406 = temp_output_1209_0_g251406;
				#else
				float staticSwitch1134_g251406 = Visual_Luminosity1049_g251406;
				#endif
				half Final_Luminosity652_g251406 = staticSwitch1134_g251406;
				float temp_output_16_0_g251407 = Final_Luminosity652_g251406;
				float In_Luminosity3_g251407 = temp_output_16_0_g251407;
				half Visual_MultiMask547_g251406 = Out_MultiMask4_g251435;
				float lerpResult477_g251406 = lerp( Visual_MultiMask547_g251406 , Local_MultiMask767_g251406 , Blend_Mask412_g251406);
				#ifdef TVE_THIRD
				float staticSwitch482_g251406 = lerpResult477_g251406;
				#else
				float staticSwitch482_g251406 = Visual_MultiMask547_g251406;
				#endif
				half Final_MultiMask572_g251406 = staticSwitch482_g251406;
				float In_MultiMask3_g251407 = Final_MultiMask572_g251406;
				half Visual_AlphaClip559_g251406 = Out_AlphaClip4_g251435;
				float temp_output_718_0_g251406 = (Local_AlbedoSample777_g251406).w;
				#ifdef TVE_CLIPPING
				float staticSwitch924_g251406 = ( temp_output_718_0_g251406 - _ThirdAlphaClipValue );
				#else
				float staticSwitch924_g251406 = temp_output_718_0_g251406;
				#endif
				half Local_AlphaClip772_g251406 = staticSwitch924_g251406;
				float lerpResult448_g251406 = lerp( Visual_AlphaClip559_g251406 , Local_AlphaClip772_g251406 , Blend_Mask412_g251406);
				#ifdef TVE_THIRD
				float staticSwitch564_g251406 = lerpResult448_g251406;
				#else
				float staticSwitch564_g251406 = Visual_AlphaClip559_g251406;
				#endif
				half Final_AlphaClip602_g251406 = staticSwitch564_g251406;
				float In_AlphaClip3_g251407 = Final_AlphaClip602_g251406;
				half Visual_AlphaFade588_g251406 = Out_AlphaFade4_g251435;
				half Local_AlphaFade773_g251406 = (lerpResult706_g251406).z;
				float lerpResult604_g251406 = lerp( Visual_AlphaFade588_g251406 , Local_AlphaFade773_g251406 , Blend_Mask412_g251406);
				#ifdef TVE_THIRD
				float staticSwitch608_g251406 = lerpResult604_g251406;
				#else
				float staticSwitch608_g251406 = Visual_AlphaFade588_g251406;
				#endif
				half Final_AlphaFade611_g251406 = staticSwitch608_g251406;
				float In_AlphaFade3_g251407 = Final_AlphaFade611_g251406;
				float3 In_Translucency3_g251407 = Out_Translucency4_g251435;
				float In_Transmission3_g251407 = Out_Transmission4_g251435;
				float In_Thickness3_g251407 = Out_Thickness4_g251435;
				float In_Diffusion3_g251407 = Out_Diffusion4_g251435;
				float In_Depth3_g251407 = Out_Depth4_g251435;
				BuildVisualData( Data3_g251407 , In_Dummy3_g251407 , In_Albedo3_g251407 , In_AlbedoBase3_g251407 , In_NormalTS3_g251407 , In_NormalWS3_g251407 , In_Shader3_g251407 , In_Feature3_g251407 , In_Season3_g251407 , In_Emissive3_g251407 , In_Grayscale3_g251407 , In_Luminosity3_g251407 , In_MultiMask3_g251407 , In_AlphaClip3_g251407 , In_AlphaFade3_g251407 , In_Translucency3_g251407 , In_Transmission3_g251407 , In_Thickness3_g251407 , In_Diffusion3_g251407 , In_Depth3_g251407 );
				TVEVisualData DataB25_g251455 = Data3_g251407;
				float Alpha25_g251455 = _ThirdBakeMode;
				{
				if (Alpha25_g251455 < 0.5 )
				{
				Data25_g251455 = DataA25_g251455;
				}
				else
				{
				Data25_g251455 = DataB25_g251455;
				}
				}
				TVEVisualData DataA25_g251800 = Data25_g251455;
				float localBuildVisualData3_g251458 = ( 0.0 );
				float localBreakVisualData4_g251457 = ( 0.0 );
				TVEVisualData Data4_g251457 =(TVEVisualData)Data25_g251455;
				float Out_Dummy4_g251457 = 0.0;
				float3 Out_Albedo4_g251457 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g251457 = float3( 0,0,0 );
				float2 Out_NormalTS4_g251457 = float2( 0,0 );
				float3 Out_NormalWS4_g251457 = float3( 0,0,0 );
				float4 Out_Shader4_g251457 = float4( 0,0,0,0 );
				float4 Out_Feature4_g251457 = float4( 0,0,0,0 );
				float4 Out_Season4_g251457 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g251457 = float4( 0,0,0,0 );
				float Out_MultiMask4_g251457 = 0.0;
				float Out_Grayscale4_g251457 = 0.0;
				float Out_Luminosity4_g251457 = 0.0;
				float Out_AlphaClip4_g251457 = 0.0;
				float Out_AlphaFade4_g251457 = 0.0;
				float3 Out_Translucency4_g251457 = float3( 0,0,0 );
				float Out_Transmission4_g251457 = 0.0;
				float Out_Thickness4_g251457 = 0.0;
				float Out_Diffusion4_g251457 = 0.0;
				float Out_Depth4_g251457 = 0.0;
				BreakVisualData( Data4_g251457 , Out_Dummy4_g251457 , Out_Albedo4_g251457 , Out_AlbedoBase4_g251457 , Out_NormalTS4_g251457 , Out_NormalWS4_g251457 , Out_Shader4_g251457 , Out_Feature4_g251457 , Out_Season4_g251457 , Out_Emissive4_g251457 , Out_MultiMask4_g251457 , Out_Grayscale4_g251457 , Out_Luminosity4_g251457 , Out_AlphaClip4_g251457 , Out_AlphaFade4_g251457 , Out_Translucency4_g251457 , Out_Transmission4_g251457 , Out_Thickness4_g251457 , Out_Diffusion4_g251457 , Out_Depth4_g251457 );
				TVEVisualData Data3_g251458 =(TVEVisualData)Data4_g251457;
				half Dummy202_g251456 = ( _OcclusionCategory + _OcclusionEnd + _OcclusionBakeMode );
				float temp_output_14_0_g251458 = Dummy202_g251456;
				float In_Dummy3_g251458 = temp_output_14_0_g251458;
				half3 Visual_Albedo127_g251456 = Out_Albedo4_g251457;
				float temp_output_17_0_g251464 = _OcclusionColorMeshMode;
				float Option70_g251464 = temp_output_17_0_g251464;
				TVEModelData Data15_g251460 =(TVEModelData)Data16_g128405;
				float Out_Dummy15_g251460 = 0.0;
				float3 Out_PositionWS15_g251460 = float3( 0,0,0 );
				float3 Out_PositionWO15_g251460 = float3( 0,0,0 );
				float3 Out_PivotWS15_g251460 = float3( 0,0,0 );
				float3 Out_PivotWO15_g251460 = float3( 0,0,0 );
				float3 Out_NormalWS15_g251460 = float3( 0,0,0 );
				float3 Out_TangentWS15_g251460 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g251460 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g251460 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g251460 = float3( 0,0,0 );
				float4 Out_CoordsData15_g251460 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g251460 = float4( 0,0,0,0 );
				float4 Out_PhaseData15_g251460 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g251460 , Out_Dummy15_g251460 , Out_PositionWS15_g251460 , Out_PositionWO15_g251460 , Out_PivotWS15_g251460 , Out_PivotWO15_g251460 , Out_NormalWS15_g251460 , Out_TangentWS15_g251460 , Out_BitangentWS15_g251460 , Out_TriplanarWeights15_g251460 , Out_ViewDirWS15_g251460 , Out_CoordsData15_g251460 , Out_VertexData15_g251460 , Out_PhaseData15_g251460 );
				half4 Model_VertexData206_g251456 = Out_VertexData15_g251460;
				float4 temp_output_3_0_g251464 = Model_VertexData206_g251456;
				float4 Channel70_g251464 = temp_output_3_0_g251464;
				float localSwitchChannel470_g251464 = SwitchChannel4( Option70_g251464 , Channel70_g251464 );
				float temp_output_235_0_g251456 = localSwitchChannel470_g251464;
				float temp_output_7_0_g251461 = _OcclusionColorMeshRemap.x;
				float temp_output_9_0_g251461 = ( temp_output_235_0_g251456 - temp_output_7_0_g251461 );
				half Occlusion_Mask82_g251456 = saturate( ( temp_output_9_0_g251461 * _OcclusionColorMeshRemap.z ) );
				float3 lerpResult75_g251456 = lerp( (_OcclusionColorTwo).rgb , (_OcclusionColorOne).rgb , Occlusion_Mask82_g251456);
				float3 lerpResult186_g251456 = lerp( Visual_Albedo127_g251456 , ( Visual_Albedo127_g251456 * lerpResult75_g251456 ) , _OcclusionIntensityValue);
				#ifdef TVE_OCCLUSION
				float3 staticSwitch171_g251456 = lerpResult186_g251456;
				#else
				float3 staticSwitch171_g251456 = Visual_Albedo127_g251456;
				#endif
				half3 Final_Albedo160_g251456 = staticSwitch171_g251456;
				float3 temp_output_4_0_g251458 = Final_Albedo160_g251456;
				float3 In_Albedo3_g251458 = temp_output_4_0_g251458;
				float3 temp_output_44_0_g251458 = Final_Albedo160_g251456;
				float3 In_AlbedoBase3_g251458 = temp_output_44_0_g251458;
				float2 In_NormalTS3_g251458 = Out_NormalTS4_g251457;
				float3 In_NormalWS3_g251458 = Out_NormalWS4_g251457;
				float4 In_Shader3_g251458 = Out_Shader4_g251457;
				float4 In_Feature3_g251458 = Out_Feature4_g251457;
				float4 In_Season3_g251458 = Out_Season4_g251457;
				float4 In_Emissive3_g251458 = Out_Emissive4_g251457;
				half Visual_Grayscale225_g251456 = Out_Grayscale4_g251457;
				float3 temp_output_3_0_g251462 = Final_Albedo160_g251456;
				float dotResult20_g251462 = dot( temp_output_3_0_g251462 , float3( 0.2126, 0.7152, 0.0722 ) );
				float temp_output_165_0_g251456 = dotResult20_g251462;
				#ifdef TVE_OCCLUSION
				float staticSwitch223_g251456 = temp_output_165_0_g251456;
				#else
				float staticSwitch223_g251456 = Visual_Grayscale225_g251456;
				#endif
				half Final_Grayscale164_g251456 = staticSwitch223_g251456;
				float temp_output_12_0_g251458 = Final_Grayscale164_g251456;
				float In_Grayscale3_g251458 = temp_output_12_0_g251458;
				half Visual_Luminosity226_g251456 = Out_Luminosity4_g251457;
				float clampResult27_g251463 = clamp( saturate( ( Final_Grayscale164_g251456 * 5.0 ) ) , 0.2 , 1.0 );
				float temp_output_229_0_g251456 = clampResult27_g251463;
				#ifdef TVE_OCCLUSION
				float staticSwitch227_g251456 = temp_output_229_0_g251456;
				#else
				float staticSwitch227_g251456 = Visual_Luminosity226_g251456;
				#endif
				half Final_Luminosity181_g251456 = staticSwitch227_g251456;
				float temp_output_16_0_g251458 = Final_Luminosity181_g251456;
				float In_Luminosity3_g251458 = temp_output_16_0_g251458;
				float In_MultiMask3_g251458 = Out_MultiMask4_g251457;
				float In_AlphaClip3_g251458 = Out_AlphaClip4_g251457;
				float In_AlphaFade3_g251458 = Out_AlphaFade4_g251457;
				float3 In_Translucency3_g251458 = Out_Translucency4_g251457;
				float In_Transmission3_g251458 = Out_Transmission4_g251457;
				float In_Thickness3_g251458 = Out_Thickness4_g251457;
				float In_Diffusion3_g251458 = Out_Diffusion4_g251457;
				float In_Depth3_g251458 = Out_Depth4_g251457;
				BuildVisualData( Data3_g251458 , In_Dummy3_g251458 , In_Albedo3_g251458 , In_AlbedoBase3_g251458 , In_NormalTS3_g251458 , In_NormalWS3_g251458 , In_Shader3_g251458 , In_Feature3_g251458 , In_Season3_g251458 , In_Emissive3_g251458 , In_Grayscale3_g251458 , In_Luminosity3_g251458 , In_MultiMask3_g251458 , In_AlphaClip3_g251458 , In_AlphaFade3_g251458 , In_Translucency3_g251458 , In_Transmission3_g251458 , In_Thickness3_g251458 , In_Diffusion3_g251458 , In_Depth3_g251458 );
				TVEVisualData DataB25_g251800 = Data3_g251458;
				float Alpha25_g251800 = _OcclusionBakeMode;
				{
				if (Alpha25_g251800 < 0.5 )
				{
				Data25_g251800 = DataA25_g251800;
				}
				else
				{
				Data25_g251800 = DataB25_g251800;
				}
				}
				TVEVisualData DataA25_g251828 = Data25_g251800;
				float localBuildVisualData3_g251804 = ( 0.0 );
				TVEVisualData Data3_g251804 =(TVEVisualData)0;
				half Dummy220_g251802 = ( _DualColorCategory + _DualColorEnd + _DualColorBakeMode );
				float temp_output_14_0_g251804 = Dummy220_g251802;
				float In_Dummy3_g251804 = temp_output_14_0_g251804;
				float localBreakVisualData4_g251803 = ( 0.0 );
				TVEVisualData Data4_g251803 =(TVEVisualData)Data25_g251800;
				float Out_Dummy4_g251803 = 0.0;
				float3 Out_Albedo4_g251803 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g251803 = float3( 0,0,0 );
				float2 Out_NormalTS4_g251803 = float2( 0,0 );
				float3 Out_NormalWS4_g251803 = float3( 0,0,0 );
				float4 Out_Shader4_g251803 = float4( 0,0,0,0 );
				float4 Out_Feature4_g251803 = float4( 0,0,0,0 );
				float4 Out_Season4_g251803 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g251803 = float4( 0,0,0,0 );
				float Out_MultiMask4_g251803 = 0.0;
				float Out_Grayscale4_g251803 = 0.0;
				float Out_Luminosity4_g251803 = 0.0;
				float Out_AlphaClip4_g251803 = 0.0;
				float Out_AlphaFade4_g251803 = 0.0;
				float3 Out_Translucency4_g251803 = float3( 0,0,0 );
				float Out_Transmission4_g251803 = 0.0;
				float Out_Thickness4_g251803 = 0.0;
				float Out_Diffusion4_g251803 = 0.0;
				float Out_Depth4_g251803 = 0.0;
				BreakVisualData( Data4_g251803 , Out_Dummy4_g251803 , Out_Albedo4_g251803 , Out_AlbedoBase4_g251803 , Out_NormalTS4_g251803 , Out_NormalWS4_g251803 , Out_Shader4_g251803 , Out_Feature4_g251803 , Out_Season4_g251803 , Out_Emissive4_g251803 , Out_MultiMask4_g251803 , Out_Grayscale4_g251803 , Out_Luminosity4_g251803 , Out_AlphaClip4_g251803 , Out_AlphaFade4_g251803 , Out_Translucency4_g251803 , Out_Transmission4_g251803 , Out_Thickness4_g251803 , Out_Diffusion4_g251803 , Out_Depth4_g251803 );
				half3 Visual_Albedo127_g251802 = Out_Albedo4_g251803;
				float temp_output_162_11_g251802 = Out_MultiMask4_g251803;
				half Visual_MultiMask196_g251802 = temp_output_162_11_g251802;
				float3 lerpResult75_g251802 = lerp( (_DualColorTwo).rgb , (_DualColorOne).rgb , Visual_MultiMask196_g251802);
				half Visual_Grayscale266_g251802 = Out_Grayscale4_g251803;
				float3 temp_cast_39 = (Visual_Grayscale266_g251802).xxx;
				float3 lerpResult281_g251802 = lerp( Visual_Albedo127_g251802 , temp_cast_39 , _DualColorGrayValue);
				#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g251806 = 2.0;
				#else
				float staticSwitch1_g251806 = 4.594794;
				#endif
				float lerpResult275_g251802 = lerp( 1.0 , staticSwitch1_g251806 , _DualColorBlendAlbedoValue);
				half Color_Double274_g251802 = lerpResult275_g251802;
				float3 lerpResult186_g251802 = lerp( Visual_Albedo127_g251802 , ( lerpResult75_g251802 * lerpResult281_g251802 * Color_Double274_g251802 ) , _DualColorIntensityValue);
				#ifdef TVE_DUAL_COLOR
				float3 staticSwitch171_g251802 = lerpResult186_g251802;
				#else
				float3 staticSwitch171_g251802 = Visual_Albedo127_g251802;
				#endif
				half3 Final_Albedo160_g251802 = staticSwitch171_g251802;
				float3 temp_output_4_0_g251804 = Final_Albedo160_g251802;
				float3 In_Albedo3_g251804 = temp_output_4_0_g251804;
				float3 temp_output_44_0_g251804 = Final_Albedo160_g251802;
				float3 In_AlbedoBase3_g251804 = temp_output_44_0_g251804;
				float2 In_NormalTS3_g251804 = Out_NormalTS4_g251803;
				float3 In_NormalWS3_g251804 = Out_NormalWS4_g251803;
				float4 In_Shader3_g251804 = Out_Shader4_g251803;
				float4 In_Feature3_g251804 = Out_Feature4_g251803;
				float4 In_Season3_g251804 = Out_Season4_g251803;
				float4 In_Emissive3_g251804 = Out_Emissive4_g251803;
				float3 temp_output_3_0_g251807 = Final_Albedo160_g251802;
				float dotResult20_g251807 = dot( temp_output_3_0_g251807 , float3( 0.2126, 0.7152, 0.0722 ) );
				#ifdef TVE_DUAL_COLOR
				float staticSwitch268_g251802 = dotResult20_g251807;
				#else
				float staticSwitch268_g251802 = Visual_Grayscale266_g251802;
				#endif
				half Final_Grayscale164_g251802 = staticSwitch268_g251802;
				float temp_output_12_0_g251804 = Final_Grayscale164_g251802;
				float In_Grayscale3_g251804 = temp_output_12_0_g251804;
				half Visual_Luminosity267_g251802 = Out_Luminosity4_g251803;
				float clampResult27_g251808 = clamp( saturate( ( Final_Grayscale164_g251802 * 5.0 ) ) , 0.2 , 1.0 );
				#ifdef TVE_DUAL_COLOR
				float staticSwitch269_g251802 = clampResult27_g251808;
				#else
				float staticSwitch269_g251802 = Visual_Luminosity267_g251802;
				#endif
				half Final_Luminosity181_g251802 = staticSwitch269_g251802;
				float temp_output_16_0_g251804 = Final_Luminosity181_g251802;
				float In_Luminosity3_g251804 = temp_output_16_0_g251804;
				float In_MultiMask3_g251804 = temp_output_162_11_g251802;
				float In_AlphaClip3_g251804 = Out_AlphaClip4_g251803;
				float In_AlphaFade3_g251804 = Out_AlphaFade4_g251803;
				float3 In_Translucency3_g251804 = Out_Translucency4_g251803;
				float In_Transmission3_g251804 = Out_Transmission4_g251803;
				float In_Thickness3_g251804 = Out_Thickness4_g251803;
				float In_Diffusion3_g251804 = Out_Diffusion4_g251803;
				float In_Depth3_g251804 = Out_Depth4_g251803;
				BuildVisualData( Data3_g251804 , In_Dummy3_g251804 , In_Albedo3_g251804 , In_AlbedoBase3_g251804 , In_NormalTS3_g251804 , In_NormalWS3_g251804 , In_Shader3_g251804 , In_Feature3_g251804 , In_Season3_g251804 , In_Emissive3_g251804 , In_Grayscale3_g251804 , In_Luminosity3_g251804 , In_MultiMask3_g251804 , In_AlphaClip3_g251804 , In_AlphaFade3_g251804 , In_Translucency3_g251804 , In_Transmission3_g251804 , In_Thickness3_g251804 , In_Diffusion3_g251804 , In_Depth3_g251804 );
				TVEVisualData DataB25_g251828 = Data3_g251804;
				float Alpha25_g251828 = _DualColorBakeMode;
				{
				if (Alpha25_g251828 < 0.5 )
				{
				Data25_g251828 = DataA25_g251828;
				}
				else
				{
				Data25_g251828 = DataB25_g251828;
				}
				}
				TVEVisualData DataA25_g251829 = Data25_g251828;
				float localBuildVisualData3_g251811 = ( 0.0 );
				float localBreakVisualData4_g251810 = ( 0.0 );
				TVEVisualData Data4_g251810 =(TVEVisualData)Data25_g251828;
				float Out_Dummy4_g251810 = 0.0;
				float3 Out_Albedo4_g251810 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g251810 = float3( 0,0,0 );
				float2 Out_NormalTS4_g251810 = float2( 0,0 );
				float3 Out_NormalWS4_g251810 = float3( 0,0,0 );
				float4 Out_Shader4_g251810 = float4( 0,0,0,0 );
				float4 Out_Feature4_g251810 = float4( 0,0,0,0 );
				float4 Out_Season4_g251810 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g251810 = float4( 0,0,0,0 );
				float Out_MultiMask4_g251810 = 0.0;
				float Out_Grayscale4_g251810 = 0.0;
				float Out_Luminosity4_g251810 = 0.0;
				float Out_AlphaClip4_g251810 = 0.0;
				float Out_AlphaFade4_g251810 = 0.0;
				float3 Out_Translucency4_g251810 = float3( 0,0,0 );
				float Out_Transmission4_g251810 = 0.0;
				float Out_Thickness4_g251810 = 0.0;
				float Out_Diffusion4_g251810 = 0.0;
				float Out_Depth4_g251810 = 0.0;
				BreakVisualData( Data4_g251810 , Out_Dummy4_g251810 , Out_Albedo4_g251810 , Out_AlbedoBase4_g251810 , Out_NormalTS4_g251810 , Out_NormalWS4_g251810 , Out_Shader4_g251810 , Out_Feature4_g251810 , Out_Season4_g251810 , Out_Emissive4_g251810 , Out_MultiMask4_g251810 , Out_Grayscale4_g251810 , Out_Luminosity4_g251810 , Out_AlphaClip4_g251810 , Out_AlphaFade4_g251810 , Out_Translucency4_g251810 , Out_Transmission4_g251810 , Out_Thickness4_g251810 , Out_Diffusion4_g251810 , Out_Depth4_g251810 );
				TVEVisualData Data3_g251811 =(TVEVisualData)Data4_g251810;
				half Dummy220_g251809 = ( _GradientCategory + _GradientEnd + _GradientBakeMode );
				float temp_output_14_0_g251811 = Dummy220_g251809;
				float In_Dummy3_g251811 = temp_output_14_0_g251811;
				half3 Visual_Albedo127_g251809 = Out_Albedo4_g251810;
				float temp_output_17_0_g251825 = _GradientColorMeshMode;
				float Option70_g251825 = temp_output_17_0_g251825;
				TVEModelData Data15_g251813 =(TVEModelData)Data16_g128405;
				float Out_Dummy15_g251813 = 0.0;
				float3 Out_PositionWS15_g251813 = float3( 0,0,0 );
				float3 Out_PositionWO15_g251813 = float3( 0,0,0 );
				float3 Out_PivotWS15_g251813 = float3( 0,0,0 );
				float3 Out_PivotWO15_g251813 = float3( 0,0,0 );
				float3 Out_NormalWS15_g251813 = float3( 0,0,0 );
				float3 Out_TangentWS15_g251813 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g251813 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g251813 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g251813 = float3( 0,0,0 );
				float4 Out_CoordsData15_g251813 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g251813 = float4( 0,0,0,0 );
				float4 Out_PhaseData15_g251813 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g251813 , Out_Dummy15_g251813 , Out_PositionWS15_g251813 , Out_PositionWO15_g251813 , Out_PivotWS15_g251813 , Out_PivotWO15_g251813 , Out_NormalWS15_g251813 , Out_TangentWS15_g251813 , Out_BitangentWS15_g251813 , Out_TriplanarWeights15_g251813 , Out_ViewDirWS15_g251813 , Out_CoordsData15_g251813 , Out_VertexData15_g251813 , Out_PhaseData15_g251813 );
				half4 Model_VertexData224_g251809 = Out_VertexData15_g251813;
				float4 temp_output_3_0_g251825 = Model_VertexData224_g251809;
				float4 Channel70_g251825 = temp_output_3_0_g251825;
				float localSwitchChannel470_g251825 = SwitchChannel4( Option70_g251825 , Channel70_g251825 );
				float temp_output_287_0_g251809 = localSwitchChannel470_g251825;
				float temp_output_7_0_g251814 = _GradientColorMeshRemap.x;
				float temp_output_9_0_g251814 = ( temp_output_287_0_g251809 - temp_output_7_0_g251814 );
				half Gradient_VertMask82_g251809 = saturate( ( temp_output_9_0_g251814 * _GradientColorMeshRemap.z ) );
				half Gradient_NoiseMask248_g251809 = 1.0;
				float temp_output_198_0_g251809 = ( Gradient_VertMask82_g251809 * Gradient_NoiseMask248_g251809 );
				half Gradient_Mask200_g251809 = temp_output_198_0_g251809;
				float3 lerpResult75_g251809 = lerp( (_GradientColorTwo).rgb , (_GradientColorOne).rgb , Gradient_Mask200_g251809);
				half Visual_Grayscale266_g251809 = Out_Grayscale4_g251810;
				float3 temp_cast_40 = (Visual_Grayscale266_g251809).xxx;
				float3 lerpResult281_g251809 = lerp( Visual_Albedo127_g251809 , temp_cast_40 , _GradientGrayValue);
				float temp_output_162_11_g251809 = Out_MultiMask4_g251810;
				half Visual_MultiMask196_g251809 = temp_output_162_11_g251809;
				float lerpResult190_g251809 = lerp( 1.0 , Visual_MultiMask196_g251809 , _GradientMultiValue);
				half Gradient_MultiMask194_g251809 = lerpResult190_g251809;
				float3 lerpResult186_g251809 = lerp( Visual_Albedo127_g251809 , ( lerpResult75_g251809 * lerpResult281_g251809 ) , ( _GradientIntensityValue * Gradient_MultiMask194_g251809 ));
				#ifdef TVE_GRADIENT
				float3 staticSwitch171_g251809 = lerpResult186_g251809;
				#else
				float3 staticSwitch171_g251809 = Visual_Albedo127_g251809;
				#endif
				half3 Final_Albedo160_g251809 = staticSwitch171_g251809;
				float3 temp_output_4_0_g251811 = Final_Albedo160_g251809;
				float3 In_Albedo3_g251811 = temp_output_4_0_g251811;
				float3 temp_output_44_0_g251811 = Final_Albedo160_g251809;
				float3 In_AlbedoBase3_g251811 = temp_output_44_0_g251811;
				float2 In_NormalTS3_g251811 = Out_NormalTS4_g251810;
				float3 In_NormalWS3_g251811 = Out_NormalWS4_g251810;
				float4 In_Shader3_g251811 = Out_Shader4_g251810;
				float4 In_Feature3_g251811 = Out_Feature4_g251810;
				float4 In_Season3_g251811 = Out_Season4_g251810;
				float4 In_Emissive3_g251811 = Out_Emissive4_g251810;
				float3 temp_output_3_0_g251823 = Final_Albedo160_g251809;
				float dotResult20_g251823 = dot( temp_output_3_0_g251823 , float3( 0.2126, 0.7152, 0.0722 ) );
				float temp_output_165_0_g251809 = dotResult20_g251823;
				#ifdef TVE_GRADIENT
				float staticSwitch268_g251809 = temp_output_165_0_g251809;
				#else
				float staticSwitch268_g251809 = Visual_Grayscale266_g251809;
				#endif
				half Final_Grayscale164_g251809 = staticSwitch268_g251809;
				float temp_output_12_0_g251811 = Final_Grayscale164_g251809;
				float In_Grayscale3_g251811 = temp_output_12_0_g251811;
				half Visual_Luminosity267_g251809 = Out_Luminosity4_g251810;
				float clampResult27_g251824 = clamp( saturate( ( Final_Grayscale164_g251809 * 5.0 ) ) , 0.2 , 1.0 );
				float temp_output_272_0_g251809 = clampResult27_g251824;
				#ifdef TVE_GRADIENT
				float staticSwitch269_g251809 = temp_output_272_0_g251809;
				#else
				float staticSwitch269_g251809 = Visual_Luminosity267_g251809;
				#endif
				half Final_Luminosity181_g251809 = staticSwitch269_g251809;
				float temp_output_16_0_g251811 = Final_Luminosity181_g251809;
				float In_Luminosity3_g251811 = temp_output_16_0_g251811;
				float In_MultiMask3_g251811 = temp_output_162_11_g251809;
				float In_AlphaClip3_g251811 = Out_AlphaClip4_g251810;
				float In_AlphaFade3_g251811 = Out_AlphaFade4_g251810;
				float3 In_Translucency3_g251811 = Out_Translucency4_g251810;
				float In_Transmission3_g251811 = Out_Transmission4_g251810;
				float In_Thickness3_g251811 = Out_Thickness4_g251810;
				float In_Diffusion3_g251811 = Out_Diffusion4_g251810;
				float In_Depth3_g251811 = Out_Depth4_g251810;
				BuildVisualData( Data3_g251811 , In_Dummy3_g251811 , In_Albedo3_g251811 , In_AlbedoBase3_g251811 , In_NormalTS3_g251811 , In_NormalWS3_g251811 , In_Shader3_g251811 , In_Feature3_g251811 , In_Season3_g251811 , In_Emissive3_g251811 , In_Grayscale3_g251811 , In_Luminosity3_g251811 , In_MultiMask3_g251811 , In_AlphaClip3_g251811 , In_AlphaFade3_g251811 , In_Translucency3_g251811 , In_Transmission3_g251811 , In_Thickness3_g251811 , In_Diffusion3_g251811 , In_Depth3_g251811 );
				TVEVisualData DataB25_g251829 = Data3_g251811;
				float Alpha25_g251829 = _GradientBakeMode;
				{
				if (Alpha25_g251829 < 0.5 )
				{
				Data25_g251829 = DataA25_g251829;
				}
				else
				{
				Data25_g251829 = DataB25_g251829;
				}
				}
				TVEVisualData DataA25_g252094 = Data25_g251829;
				float localBuildVisualData3_g252089 = ( 0.0 );
				float localBreakVisualData4_g252087 = ( 0.0 );
				TVEVisualData Data4_g252087 =(TVEVisualData)Data25_g251829;
				float Out_Dummy4_g252087 = 0.0;
				float3 Out_Albedo4_g252087 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g252087 = float3( 0,0,0 );
				float2 Out_NormalTS4_g252087 = float2( 0,0 );
				float3 Out_NormalWS4_g252087 = float3( 0,0,0 );
				float4 Out_Shader4_g252087 = float4( 0,0,0,0 );
				float4 Out_Feature4_g252087 = float4( 0,0,0,0 );
				float4 Out_Season4_g252087 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g252087 = float4( 0,0,0,0 );
				float Out_MultiMask4_g252087 = 0.0;
				float Out_Grayscale4_g252087 = 0.0;
				float Out_Luminosity4_g252087 = 0.0;
				float Out_AlphaClip4_g252087 = 0.0;
				float Out_AlphaFade4_g252087 = 0.0;
				float3 Out_Translucency4_g252087 = float3( 0,0,0 );
				float Out_Transmission4_g252087 = 0.0;
				float Out_Thickness4_g252087 = 0.0;
				float Out_Diffusion4_g252087 = 0.0;
				float Out_Depth4_g252087 = 0.0;
				BreakVisualData( Data4_g252087 , Out_Dummy4_g252087 , Out_Albedo4_g252087 , Out_AlbedoBase4_g252087 , Out_NormalTS4_g252087 , Out_NormalWS4_g252087 , Out_Shader4_g252087 , Out_Feature4_g252087 , Out_Season4_g252087 , Out_Emissive4_g252087 , Out_MultiMask4_g252087 , Out_Grayscale4_g252087 , Out_Luminosity4_g252087 , Out_AlphaClip4_g252087 , Out_AlphaFade4_g252087 , Out_Translucency4_g252087 , Out_Transmission4_g252087 , Out_Thickness4_g252087 , Out_Diffusion4_g252087 , Out_Depth4_g252087 );
				TVEVisualData Data3_g252089 =(TVEVisualData)Data4_g252087;
				half Dummy205_g252065 = ( _TintingCategory + _TintingEnd + _TintingSpace + _TintingBakeMode );
				float temp_output_14_0_g252089 = Dummy205_g252065;
				float In_Dummy3_g252089 = temp_output_14_0_g252089;
				half3 Visual_Albedo139_g252065 = Out_Albedo4_g252087;
				float temp_output_200_12_g252065 = Out_Grayscale4_g252087;
				half Visual_Grayscale150_g252065 = temp_output_200_12_g252065;
				float3 temp_cast_41 = (Visual_Grayscale150_g252065).xxx;
				half Blend_GlobalValue285_g252065 = 1.0;
				float3 lerpResult368_g252065 = lerp( Visual_Albedo139_g252065 , temp_cast_41 , ( Blend_GlobalValue285_g252065 * _TintingGrayValue ));
				half Blend_GlobalColor290_g252065 = 1.0;
				half Blend_TexMask385_g252065 = 1.0;
				float temp_output_200_11_g252065 = Out_MultiMask4_g252087;
				half Visual_MultiMask181_g252065 = temp_output_200_11_g252065;
				float lerpResult147_g252065 = lerp( 1.0 , Visual_MultiMask181_g252065 , _TintingMultiValue);
				half Blend_MutiMask121_g252065 = lerpResult147_g252065;
				float temp_output_200_15_g252065 = Out_Luminosity4_g252087;
				half Visual_Luminosity257_g252065 = temp_output_200_15_g252065;
				float temp_output_7_0_g252074 = _TintingLumaRemap.x;
				float temp_output_9_0_g252074 = ( Visual_Luminosity257_g252065 - temp_output_7_0_g252074 );
				float lerpResult228_g252065 = lerp( 1.0 , saturate( ( temp_output_9_0_g252074 * _TintingLumaRemap.z ) ) , _TintingLumaValue);
				half Blend_LumaMask153_g252065 = lerpResult228_g252065;
				float temp_output_17_0_g252084 = _TintingMeshMode;
				float Option70_g252084 = temp_output_17_0_g252084;
				TVEModelData Data15_g252088 =(TVEModelData)Data16_g128405;
				float Out_Dummy15_g252088 = 0.0;
				float3 Out_PositionWS15_g252088 = float3( 0,0,0 );
				float3 Out_PositionWO15_g252088 = float3( 0,0,0 );
				float3 Out_PivotWS15_g252088 = float3( 0,0,0 );
				float3 Out_PivotWO15_g252088 = float3( 0,0,0 );
				float3 Out_NormalWS15_g252088 = float3( 0,0,0 );
				float3 Out_TangentWS15_g252088 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g252088 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g252088 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g252088 = float3( 0,0,0 );
				float4 Out_CoordsData15_g252088 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g252088 = float4( 0,0,0,0 );
				float4 Out_PhaseData15_g252088 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g252088 , Out_Dummy15_g252088 , Out_PositionWS15_g252088 , Out_PositionWO15_g252088 , Out_PivotWS15_g252088 , Out_PivotWO15_g252088 , Out_NormalWS15_g252088 , Out_TangentWS15_g252088 , Out_BitangentWS15_g252088 , Out_TriplanarWeights15_g252088 , Out_ViewDirWS15_g252088 , Out_CoordsData15_g252088 , Out_VertexData15_g252088 , Out_PhaseData15_g252088 );
				half4 Model_VertexData307_g252065 = Out_VertexData15_g252088;
				float4 temp_output_3_0_g252084 = Model_VertexData307_g252065;
				float4 Channel70_g252084 = temp_output_3_0_g252084;
				float localSwitchChannel470_g252084 = SwitchChannel4( Option70_g252084 , Channel70_g252084 );
				float temp_output_521_0_g252065 = localSwitchChannel470_g252084;
				float temp_output_7_0_g252075 = _TintingMeshRemap.x;
				float temp_output_9_0_g252075 = ( temp_output_521_0_g252065 - temp_output_7_0_g252075 );
				float lerpResult370_g252065 = lerp( 1.0 , saturate( ( temp_output_9_0_g252075 * _TintingMeshRemap.z ) ) , _TintingMeshValue);
				half Blend_VertMask309_g252065 = lerpResult370_g252065;
				half Blend_NoiseMask213_g252065 = 1.0;
				half Blend_UserMask345_g252065 = 1.0;
				float temp_output_7_0_g252079 = _TintingBlendRemap.x;
				float temp_output_9_0_g252079 = ( ( _TintingIntensityValue * Blend_TexMask385_g252065 * Blend_MutiMask121_g252065 * Blend_LumaMask153_g252065 * Blend_VertMask309_g252065 * Blend_NoiseMask213_g252065 * Blend_UserMask345_g252065 * Blend_GlobalValue285_g252065 ) - temp_output_7_0_g252079 );
				float temp_output_301_0_g252065 = ( saturate( ( temp_output_9_0_g252079 * _TintingBlendRemap.z ) ) * TVE_IsEnabled );
				half Blend_Mask242_g252065 = temp_output_301_0_g252065;
				float3 lerpResult90_g252065 = lerp( Visual_Albedo139_g252065 , ( lerpResult368_g252065 * Blend_GlobalColor290_g252065 * _TintingColor.rgb ) , Blend_Mask242_g252065);
				#ifdef TVE_TINTING
				float3 staticSwitch286_g252065 = lerpResult90_g252065;
				#else
				float3 staticSwitch286_g252065 = Visual_Albedo139_g252065;
				#endif
				half3 Final_Albedo97_g252065 = staticSwitch286_g252065;
				float3 temp_output_4_0_g252089 = Final_Albedo97_g252065;
				float3 In_Albedo3_g252089 = temp_output_4_0_g252089;
				float3 temp_output_44_0_g252089 = Out_AlbedoBase4_g252087;
				float3 In_AlbedoBase3_g252089 = temp_output_44_0_g252089;
				float2 In_NormalTS3_g252089 = Out_NormalTS4_g252087;
				float3 In_NormalWS3_g252089 = Out_NormalWS4_g252087;
				float4 In_Shader3_g252089 = Out_Shader4_g252087;
				float4 In_Feature3_g252089 = Out_Feature4_g252087;
				float4 In_Season3_g252089 = Out_Season4_g252087;
				float4 In_Emissive3_g252089 = Out_Emissive4_g252087;
				float temp_output_12_0_g252089 = temp_output_200_12_g252065;
				float In_Grayscale3_g252089 = temp_output_12_0_g252089;
				float temp_output_16_0_g252089 = temp_output_200_15_g252065;
				float In_Luminosity3_g252089 = temp_output_16_0_g252089;
				float In_MultiMask3_g252089 = temp_output_200_11_g252065;
				float In_AlphaClip3_g252089 = Out_AlphaClip4_g252087;
				float In_AlphaFade3_g252089 = Out_AlphaFade4_g252087;
				float3 In_Translucency3_g252089 = Out_Translucency4_g252087;
				float In_Transmission3_g252089 = Out_Transmission4_g252087;
				float In_Thickness3_g252089 = Out_Thickness4_g252087;
				float In_Diffusion3_g252089 = Out_Diffusion4_g252087;
				float In_Depth3_g252089 = Out_Depth4_g252087;
				BuildVisualData( Data3_g252089 , In_Dummy3_g252089 , In_Albedo3_g252089 , In_AlbedoBase3_g252089 , In_NormalTS3_g252089 , In_NormalWS3_g252089 , In_Shader3_g252089 , In_Feature3_g252089 , In_Season3_g252089 , In_Emissive3_g252089 , In_Grayscale3_g252089 , In_Luminosity3_g252089 , In_MultiMask3_g252089 , In_AlphaClip3_g252089 , In_AlphaFade3_g252089 , In_Translucency3_g252089 , In_Transmission3_g252089 , In_Thickness3_g252089 , In_Diffusion3_g252089 , In_Depth3_g252089 );
				TVEVisualData DataB25_g252094 = Data3_g252089;
				float Alpha25_g252094 = _TintingBakeMode;
				{
				if (Alpha25_g252094 < 0.5 )
				{
				Data25_g252094 = DataA25_g252094;
				}
				else
				{
				Data25_g252094 = DataB25_g252094;
				}
				}
				TVEVisualData DataA25_g252130 = Data25_g252094;
				float localBuildVisualData3_g252124 = ( 0.0 );
				float localBreakVisualData4_g252123 = ( 0.0 );
				TVEVisualData Data4_g252123 =(TVEVisualData)Data25_g252094;
				float Out_Dummy4_g252123 = 0.0;
				float3 Out_Albedo4_g252123 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g252123 = float3( 0,0,0 );
				float2 Out_NormalTS4_g252123 = float2( 0,0 );
				float3 Out_NormalWS4_g252123 = float3( 0,0,0 );
				float4 Out_Shader4_g252123 = float4( 0,0,0,0 );
				float4 Out_Feature4_g252123 = float4( 0,0,0,0 );
				float4 Out_Season4_g252123 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g252123 = float4( 0,0,0,0 );
				float Out_MultiMask4_g252123 = 0.0;
				float Out_Grayscale4_g252123 = 0.0;
				float Out_Luminosity4_g252123 = 0.0;
				float Out_AlphaClip4_g252123 = 0.0;
				float Out_AlphaFade4_g252123 = 0.0;
				float3 Out_Translucency4_g252123 = float3( 0,0,0 );
				float Out_Transmission4_g252123 = 0.0;
				float Out_Thickness4_g252123 = 0.0;
				float Out_Diffusion4_g252123 = 0.0;
				float Out_Depth4_g252123 = 0.0;
				BreakVisualData( Data4_g252123 , Out_Dummy4_g252123 , Out_Albedo4_g252123 , Out_AlbedoBase4_g252123 , Out_NormalTS4_g252123 , Out_NormalWS4_g252123 , Out_Shader4_g252123 , Out_Feature4_g252123 , Out_Season4_g252123 , Out_Emissive4_g252123 , Out_MultiMask4_g252123 , Out_Grayscale4_g252123 , Out_Luminosity4_g252123 , Out_AlphaClip4_g252123 , Out_AlphaFade4_g252123 , Out_Translucency4_g252123 , Out_Transmission4_g252123 , Out_Thickness4_g252123 , Out_Diffusion4_g252123 , Out_Depth4_g252123 );
				TVEVisualData Data3_g252124 =(TVEVisualData)Data4_g252123;
				half Dummy205_g252095 = ( _DrynessCategory + _DrynessEnd + _DrynessSpace + _DrynessBakeMode );
				float temp_output_14_0_g252124 = Dummy205_g252095;
				float In_Dummy3_g252124 = temp_output_14_0_g252124;
				half3 Visual_Albedo292_g252095 = Out_Albedo4_g252123;
				float temp_output_280_12_g252095 = Out_Grayscale4_g252123;
				half Visual_Grayscale308_g252095 = temp_output_280_12_g252095;
				float3 temp_cast_42 = (Visual_Grayscale308_g252095).xxx;
				half Blend_GlobalValue352_g252095 = 1.0;
				float3 lerpResult485_g252095 = lerp( Visual_Albedo292_g252095 , temp_cast_42 , ( Blend_GlobalValue352_g252095 * _DrynessGrayValue ));
				half Blend_TexMask478_g252095 = 1.0;
				float temp_output_280_11_g252095 = Out_MultiMask4_g252123;
				half Visual_MultiMask310_g252095 = temp_output_280_11_g252095;
				float lerpResult283_g252095 = lerp( 1.0 , Visual_MultiMask310_g252095 , _DrynessMultiValue);
				half Blend_MultiMask302_g252095 = lerpResult283_g252095;
				float temp_output_280_15_g252095 = Out_Luminosity4_g252123;
				half Visual_Luminosity309_g252095 = temp_output_280_15_g252095;
				float temp_output_7_0_g252107 = _DrynessLumaRemap.x;
				float temp_output_9_0_g252107 = ( Visual_Luminosity309_g252095 - temp_output_7_0_g252107 );
				float lerpResult295_g252095 = lerp( 1.0 , saturate( ( temp_output_9_0_g252107 * _DrynessLumaRemap.z ) ) , _DrynessLumaValue);
				half Blend_LumaMask301_g252095 = lerpResult295_g252095;
				float temp_output_17_0_g252121 = _DrynessMeshMode;
				float Option70_g252121 = temp_output_17_0_g252121;
				TVEModelData Data15_g252125 =(TVEModelData)Data16_g128405;
				float Out_Dummy15_g252125 = 0.0;
				float3 Out_PositionWS15_g252125 = float3( 0,0,0 );
				float3 Out_PositionWO15_g252125 = float3( 0,0,0 );
				float3 Out_PivotWS15_g252125 = float3( 0,0,0 );
				float3 Out_PivotWO15_g252125 = float3( 0,0,0 );
				float3 Out_NormalWS15_g252125 = float3( 0,0,0 );
				float3 Out_TangentWS15_g252125 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g252125 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g252125 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g252125 = float3( 0,0,0 );
				float4 Out_CoordsData15_g252125 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g252125 = float4( 0,0,0,0 );
				float4 Out_PhaseData15_g252125 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g252125 , Out_Dummy15_g252125 , Out_PositionWS15_g252125 , Out_PositionWO15_g252125 , Out_PivotWS15_g252125 , Out_PivotWO15_g252125 , Out_NormalWS15_g252125 , Out_TangentWS15_g252125 , Out_BitangentWS15_g252125 , Out_TriplanarWeights15_g252125 , Out_ViewDirWS15_g252125 , Out_CoordsData15_g252125 , Out_VertexData15_g252125 , Out_PhaseData15_g252125 );
				half4 Model_VertexData386_g252095 = Out_VertexData15_g252125;
				float4 temp_output_3_0_g252121 = Model_VertexData386_g252095;
				float4 Channel70_g252121 = temp_output_3_0_g252121;
				float localSwitchChannel470_g252121 = SwitchChannel4( Option70_g252121 , Channel70_g252121 );
				float temp_output_580_0_g252095 = localSwitchChannel470_g252121;
				float temp_output_7_0_g252108 = _DrynessMeshRemap.x;
				float temp_output_9_0_g252108 = ( temp_output_580_0_g252095 - temp_output_7_0_g252108 );
				float lerpResult452_g252095 = lerp( 1.0 , saturate( ( temp_output_9_0_g252108 * _DrynessMeshRemap.z ) ) , _DrynessMeshValue);
				half Blend_VertMask378_g252095 = lerpResult452_g252095;
				half Blend_NoiseMask291_g252095 = 1.0;
				half Blend_UserMask411_g252095 = 1.0;
				float temp_output_7_0_g252116 = _DrynessBlendRemap.x;
				float temp_output_9_0_g252116 = ( ( _DrynessIntensityValue * Blend_TexMask478_g252095 * Blend_MultiMask302_g252095 * Blend_LumaMask301_g252095 * Blend_VertMask378_g252095 * Blend_NoiseMask291_g252095 * Blend_GlobalValue352_g252095 * Blend_UserMask411_g252095 ) - temp_output_7_0_g252116 );
				half Blend_Mask329_g252095 = saturate( ( temp_output_9_0_g252116 * _DrynessBlendRemap.z ) );
				float3 lerpResult336_g252095 = lerp( Visual_Albedo292_g252095 , ( lerpResult485_g252095 * _DrynessColor.rgb ) , Blend_Mask329_g252095);
				#ifdef TVE_DRYNESS
				float3 staticSwitch356_g252095 = lerpResult336_g252095;
				#else
				float3 staticSwitch356_g252095 = Visual_Albedo292_g252095;
				#endif
				half3 Final_Albedo331_g252095 = staticSwitch356_g252095;
				float3 temp_output_4_0_g252124 = Final_Albedo331_g252095;
				float3 In_Albedo3_g252124 = temp_output_4_0_g252124;
				float3 temp_output_44_0_g252124 = Out_AlbedoBase4_g252123;
				float3 In_AlbedoBase3_g252124 = temp_output_44_0_g252124;
				float2 In_NormalTS3_g252124 = Out_NormalTS4_g252123;
				float3 In_NormalWS3_g252124 = Out_NormalWS4_g252123;
				half4 Visual_Shader415_g252095 = Out_Shader4_g252123;
				float4 break438_g252095 = Visual_Shader415_g252095;
				float4 appendResult439_g252095 = (float4(break438_g252095.x , break438_g252095.y , break438_g252095.z , ( break438_g252095.w * _DrynessSmoothnessValue )));
				float4 lerpResult427_g252095 = lerp( Visual_Shader415_g252095 , appendResult439_g252095 , Blend_Mask329_g252095);
				#ifdef TVE_DRYNESS
				float4 staticSwitch426_g252095 = lerpResult427_g252095;
				#else
				float4 staticSwitch426_g252095 = Visual_Shader415_g252095;
				#endif
				half4 Final_Shader433_g252095 = staticSwitch426_g252095;
				float4 In_Shader3_g252124 = Final_Shader433_g252095;
				float4 In_Feature3_g252124 = Out_Feature4_g252123;
				float4 In_Season3_g252124 = Out_Season4_g252123;
				float4 In_Emissive3_g252124 = Out_Emissive4_g252123;
				float temp_output_12_0_g252124 = temp_output_280_12_g252095;
				float In_Grayscale3_g252124 = temp_output_12_0_g252124;
				float temp_output_16_0_g252124 = temp_output_280_15_g252095;
				float In_Luminosity3_g252124 = temp_output_16_0_g252124;
				float In_MultiMask3_g252124 = temp_output_280_11_g252095;
				float In_AlphaClip3_g252124 = Out_AlphaClip4_g252123;
				float In_AlphaFade3_g252124 = Out_AlphaFade4_g252123;
				float3 In_Translucency3_g252124 = Out_Translucency4_g252123;
				half Visual_Transmission416_g252095 = Out_Transmission4_g252123;
				float lerpResult421_g252095 = lerp( Visual_Transmission416_g252095 , ( Visual_Transmission416_g252095 * _DrynessSubsurfaceValue ) , Blend_Mask329_g252095);
				#ifdef TVE_DRYNESS
				float staticSwitch418_g252095 = lerpResult421_g252095;
				#else
				float staticSwitch418_g252095 = Visual_Transmission416_g252095;
				#endif
				half Final_Transmission425_g252095 = staticSwitch418_g252095;
				float In_Transmission3_g252124 = Final_Transmission425_g252095;
				float In_Thickness3_g252124 = Out_Thickness4_g252123;
				float In_Diffusion3_g252124 = Out_Diffusion4_g252123;
				float In_Depth3_g252124 = Out_Depth4_g252123;
				BuildVisualData( Data3_g252124 , In_Dummy3_g252124 , In_Albedo3_g252124 , In_AlbedoBase3_g252124 , In_NormalTS3_g252124 , In_NormalWS3_g252124 , In_Shader3_g252124 , In_Feature3_g252124 , In_Season3_g252124 , In_Emissive3_g252124 , In_Grayscale3_g252124 , In_Luminosity3_g252124 , In_MultiMask3_g252124 , In_AlphaClip3_g252124 , In_AlphaFade3_g252124 , In_Translucency3_g252124 , In_Transmission3_g252124 , In_Thickness3_g252124 , In_Diffusion3_g252124 , In_Depth3_g252124 );
				TVEVisualData DataB25_g252130 = Data3_g252124;
				float Alpha25_g252130 = _DrynessBakeMode;
				{
				if (Alpha25_g252130 < 0.5 )
				{
				Data25_g252130 = DataA25_g252130;
				}
				else
				{
				Data25_g252130 = DataB25_g252130;
				}
				}
				TVEVisualData DataA25_g252184 = Data25_g252130;
				float localBuildVisualData3_g252173 = ( 0.0 );
				float localBreakVisualData4_g252172 = ( 0.0 );
				TVEVisualData Data4_g252172 =(TVEVisualData)Data25_g252130;
				float Out_Dummy4_g252172 = 0.0;
				float3 Out_Albedo4_g252172 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g252172 = float3( 0,0,0 );
				float2 Out_NormalTS4_g252172 = float2( 0,0 );
				float3 Out_NormalWS4_g252172 = float3( 0,0,0 );
				float4 Out_Shader4_g252172 = float4( 0,0,0,0 );
				float4 Out_Feature4_g252172 = float4( 0,0,0,0 );
				float4 Out_Season4_g252172 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g252172 = float4( 0,0,0,0 );
				float Out_MultiMask4_g252172 = 0.0;
				float Out_Grayscale4_g252172 = 0.0;
				float Out_Luminosity4_g252172 = 0.0;
				float Out_AlphaClip4_g252172 = 0.0;
				float Out_AlphaFade4_g252172 = 0.0;
				float3 Out_Translucency4_g252172 = float3( 0,0,0 );
				float Out_Transmission4_g252172 = 0.0;
				float Out_Thickness4_g252172 = 0.0;
				float Out_Diffusion4_g252172 = 0.0;
				float Out_Depth4_g252172 = 0.0;
				BreakVisualData( Data4_g252172 , Out_Dummy4_g252172 , Out_Albedo4_g252172 , Out_AlbedoBase4_g252172 , Out_NormalTS4_g252172 , Out_NormalWS4_g252172 , Out_Shader4_g252172 , Out_Feature4_g252172 , Out_Season4_g252172 , Out_Emissive4_g252172 , Out_MultiMask4_g252172 , Out_Grayscale4_g252172 , Out_Luminosity4_g252172 , Out_AlphaClip4_g252172 , Out_AlphaFade4_g252172 , Out_Translucency4_g252172 , Out_Transmission4_g252172 , Out_Thickness4_g252172 , Out_Diffusion4_g252172 , Out_Depth4_g252172 );
				TVEVisualData Data3_g252173 =(TVEVisualData)Data4_g252172;
				half Dummy594_g252131 = ( _OverlayCategory + _OverlayEnd + _OverlaySpace + _OverlayBakeMode );
				float temp_output_14_0_g252173 = Dummy594_g252131;
				float In_Dummy3_g252173 = temp_output_14_0_g252173;
				half3 Visual_Albedo127_g252131 = Out_Albedo4_g252172;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252156) = _OverlayAlbedoTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch36_g252160 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch36_g252160 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch36_g252160 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch36_g252160 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch36_g252160 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch36_g252160 = sampler_Linear_Repeat_Aniso8;
				#endif
				SamplerState Sampler496_g252156 = staticSwitch36_g252160;
				float localBreakTextureData456_g252156 = ( 0.0 );
				float localBuildTextureData431_g252153 = ( 0.0 );
				TVEMasksData Data431_g252153 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g252153 = ( 0.0 );
				float4 temp_output_6_0_g252134 = _overlay_coord_value;
				float4 temp_output_7_0_g252134 = ( _OverlaySampleMode + _OverlayCoordMode + _OverlayCoordValue );
				#ifdef TVE_DUMMY
				float4 staticSwitch14_g252134 = ( temp_output_6_0_g252134 + temp_output_7_0_g252134 );
				#else
				float4 staticSwitch14_g252134 = temp_output_6_0_g252134;
				#endif
				half4 Local_CoordValue639_g252131 = staticSwitch14_g252134;
				float4 Coords444_g252153 = Local_CoordValue639_g252131;
				float4 MeshCoords444_g252153 = float4( 0,0,0,0 );
				float2 UV0444_g252153 = float2( 0,0 );
				float2 UV3444_g252153 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g252153 , MeshCoords444_g252153 , UV0444_g252153 , UV3444_g252153 );
				float4 appendResult430_g252153 = (float4(UV0444_g252153 , UV3444_g252153));
				float4 In_MaskA431_g252153 = appendResult430_g252153;
				float localComputeWorldCoords315_g252153 = ( 0.0 );
				float4 Coords315_g252153 = Local_CoordValue639_g252131;
				TVEModelData Data15_g252174 =(TVEModelData)Data16_g128405;
				float Out_Dummy15_g252174 = 0.0;
				float3 Out_PositionWS15_g252174 = float3( 0,0,0 );
				float3 Out_PositionWO15_g252174 = float3( 0,0,0 );
				float3 Out_PivotWS15_g252174 = float3( 0,0,0 );
				float3 Out_PivotWO15_g252174 = float3( 0,0,0 );
				float3 Out_NormalWS15_g252174 = float3( 0,0,0 );
				float3 Out_TangentWS15_g252174 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g252174 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g252174 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g252174 = float3( 0,0,0 );
				float4 Out_CoordsData15_g252174 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g252174 = float4( 0,0,0,0 );
				float4 Out_PhaseData15_g252174 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g252174 , Out_Dummy15_g252174 , Out_PositionWS15_g252174 , Out_PositionWO15_g252174 , Out_PivotWS15_g252174 , Out_PivotWO15_g252174 , Out_NormalWS15_g252174 , Out_TangentWS15_g252174 , Out_BitangentWS15_g252174 , Out_TriplanarWeights15_g252174 , Out_ViewDirWS15_g252174 , Out_CoordsData15_g252174 , Out_VertexData15_g252174 , Out_PhaseData15_g252174 );
				float3 Model_PositionWO602_g252131 = Out_PositionWO15_g252174;
				float3 PositionWS315_g252153 = Model_PositionWO602_g252131;
				float2 ZY315_g252153 = float2( 0,0 );
				float2 XZ315_g252153 = float2( 0,0 );
				float2 XY315_g252153 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g252153 , PositionWS315_g252153 , ZY315_g252153 , XZ315_g252153 , XY315_g252153 );
				float2 ZY402_g252153 = ZY315_g252153;
				float2 XZ403_g252153 = XZ315_g252153;
				float4 appendResult432_g252153 = (float4(ZY402_g252153 , XZ403_g252153));
				float4 In_MaskB431_g252153 = appendResult432_g252153;
				float2 XY404_g252153 = XY315_g252153;
				float localComputeStochasticCoords409_g252153 = ( 0.0 );
				float2 UV409_g252153 = ZY402_g252153;
				float2 UV1409_g252153 = float2( 0,0 );
				float2 UV2409_g252153 = float2( 0,0 );
				float2 UV3409_g252153 = float2( 0,0 );
				float3 Weights409_g252153 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g252153 , UV1409_g252153 , UV2409_g252153 , UV3409_g252153 , Weights409_g252153 );
				float4 appendResult433_g252153 = (float4(XY404_g252153 , UV1409_g252153));
				float4 In_MaskC431_g252153 = appendResult433_g252153;
				float4 appendResult434_g252153 = (float4(UV2409_g252153 , UV3409_g252153));
				float4 In_MaskD431_g252153 = appendResult434_g252153;
				float localComputeStochasticCoords422_g252153 = ( 0.0 );
				float2 UV422_g252153 = XZ403_g252153;
				float2 UV1422_g252153 = float2( 0,0 );
				float2 UV2422_g252153 = float2( 0,0 );
				float2 UV3422_g252153 = float2( 0,0 );
				float3 Weights422_g252153 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g252153 , UV1422_g252153 , UV2422_g252153 , UV3422_g252153 , Weights422_g252153 );
				float4 appendResult435_g252153 = (float4(UV1422_g252153 , UV2422_g252153));
				float4 In_MaskE431_g252153 = appendResult435_g252153;
				float localComputeStochasticCoords423_g252153 = ( 0.0 );
				float2 UV423_g252153 = XY404_g252153;
				float2 UV1423_g252153 = float2( 0,0 );
				float2 UV2423_g252153 = float2( 0,0 );
				float2 UV3423_g252153 = float2( 0,0 );
				float3 Weights423_g252153 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g252153 , UV1423_g252153 , UV2423_g252153 , UV3423_g252153 , Weights423_g252153 );
				float4 appendResult436_g252153 = (float4(UV3422_g252153 , UV1423_g252153));
				float4 In_MaskF431_g252153 = appendResult436_g252153;
				float4 appendResult437_g252153 = (float4(UV2423_g252153 , UV3423_g252153));
				float4 In_MaskG431_g252153 = appendResult437_g252153;
				float4 In_MaskH431_g252153 = float4( Weights409_g252153 , 0.0 );
				float4 In_MaskI431_g252153 = float4( Weights422_g252153 , 0.0 );
				float4 In_MaskJ431_g252153 = float4( Weights423_g252153 , 0.0 );
				half3 Model_NormalWS712_g252131 = Out_NormalWS15_g252174;
				float3 temp_output_449_0_g252153 = Model_NormalWS712_g252131;
				float4 In_MaskK431_g252153 = float4( temp_output_449_0_g252153 , 0.0 );
				half3 Model_TangentWS1134_g252131 = Out_TangentWS15_g252174;
				float3 temp_output_450_0_g252153 = Model_TangentWS1134_g252131;
				float4 In_MaskL431_g252153 = float4( temp_output_450_0_g252153 , 0.0 );
				half3 Model_BitangentWS1135_g252131 = Out_BitangentWS15_g252174;
				float3 temp_output_451_0_g252153 = Model_BitangentWS1135_g252131;
				float4 In_MaskM431_g252153 = float4( temp_output_451_0_g252153 , 0.0 );
				half3 Model_TriplanarWeights1136_g252131 = Out_TriplanarWeights15_g252174;
				float3 temp_output_445_0_g252153 = Model_TriplanarWeights1136_g252131;
				float4 In_MaskN431_g252153 = float4( temp_output_445_0_g252153 , 0.0 );
				BuildTextureData( Data431_g252153 , In_MaskA431_g252153 , In_MaskB431_g252153 , In_MaskC431_g252153 , In_MaskD431_g252153 , In_MaskE431_g252153 , In_MaskF431_g252153 , In_MaskG431_g252153 , In_MaskH431_g252153 , In_MaskI431_g252153 , In_MaskJ431_g252153 , In_MaskK431_g252153 , In_MaskL431_g252153 , In_MaskM431_g252153 , In_MaskN431_g252153 );
				TVEMasksData Data456_g252156 =(TVEMasksData)Data431_g252153;
				float4 Out_MaskA456_g252156 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g252156 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g252156 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g252156 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g252156 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g252156 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g252156 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g252156 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g252156 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g252156 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g252156 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g252156 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g252156 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g252156 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g252156 , Out_MaskA456_g252156 , Out_MaskB456_g252156 , Out_MaskC456_g252156 , Out_MaskD456_g252156 , Out_MaskE456_g252156 , Out_MaskF456_g252156 , Out_MaskG456_g252156 , Out_MaskH456_g252156 , Out_MaskI456_g252156 , Out_MaskJ456_g252156 , Out_MaskK456_g252156 , Out_MaskL456_g252156 , Out_MaskM456_g252156 , Out_MaskN456_g252156 );
				float2 temp_output_463_0_g252156 = (Out_MaskB456_g252156).zw;
				half2 XZ496_g252156 = temp_output_463_0_g252156;
				float temp_output_504_0_g252156 = 0.0;
				half Bias496_g252156 = temp_output_504_0_g252156;
				float3 temp_output_483_0_g252156 = (Out_MaskK456_g252156).xyz;
				half3 NormalWS496_g252156 = temp_output_483_0_g252156;
				half3 Normal496_g252156 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g252156 = SamplePlanar2D( Texture496_g252156 , Sampler496_g252156 , XZ496_g252156 , Bias496_g252156 , NormalWS496_g252156 , Normal496_g252156 );
				float4 temp_output_1130_0_g252131 = localSamplePlanar2D496_g252156;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252156) = _OverlayAlbedoTex;
				SamplerState Sampler490_g252156 = staticSwitch36_g252160;
				float2 temp_output_462_0_g252156 = (Out_MaskB456_g252156).xy;
				half2 ZY490_g252156 = temp_output_462_0_g252156;
				half2 XZ490_g252156 = temp_output_463_0_g252156;
				float2 temp_output_464_0_g252156 = (Out_MaskC456_g252156).xy;
				half2 XY490_g252156 = temp_output_464_0_g252156;
				half Bias490_g252156 = temp_output_504_0_g252156;
				float3 temp_output_482_0_g252156 = (Out_MaskN456_g252156).xyz;
				half3 Triplanar490_g252156 = temp_output_482_0_g252156;
				half3 NormalWS490_g252156 = temp_output_483_0_g252156;
				half3 Normal490_g252156 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g252156 = SamplePlanar3D( Texture490_g252156 , Sampler490_g252156 , ZY490_g252156 , XZ490_g252156 , XY490_g252156 , Bias490_g252156 , Triplanar490_g252156 , NormalWS490_g252156 , Normal490_g252156 );
				float4 temp_output_1130_201_g252131 = localSamplePlanar3D490_g252156;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252156) = _OverlayAlbedoTex;
				SamplerState Sampler498_g252156 = staticSwitch36_g252160;
				half2 XZ498_g252156 = temp_output_463_0_g252156;
				float2 temp_output_473_0_g252156 = (Out_MaskE456_g252156).xy;
				half2 XZ_1498_g252156 = temp_output_473_0_g252156;
				float2 temp_output_474_0_g252156 = (Out_MaskE456_g252156).zw;
				half2 XZ_2498_g252156 = temp_output_474_0_g252156;
				float2 temp_output_475_0_g252156 = (Out_MaskF456_g252156).xy;
				half2 XZ_3498_g252156 = temp_output_475_0_g252156;
				float temp_output_510_0_g252156 = exp2( temp_output_504_0_g252156 );
				half Bias498_g252156 = temp_output_510_0_g252156;
				float3 temp_output_480_0_g252156 = (Out_MaskI456_g252156).xyz;
				half3 Weights_2498_g252156 = temp_output_480_0_g252156;
				half3 NormalWS498_g252156 = temp_output_483_0_g252156;
				half3 Normal498_g252156 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g252156 = SampleStochastic2D( Texture498_g252156 , Sampler498_g252156 , XZ498_g252156 , XZ_1498_g252156 , XZ_2498_g252156 , XZ_3498_g252156 , Bias498_g252156 , Weights_2498_g252156 , NormalWS498_g252156 , Normal498_g252156 );
				float4 temp_output_1130_202_g252131 = localSampleStochastic2D498_g252156;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252156) = _OverlayAlbedoTex;
				SamplerState Sampler500_g252156 = staticSwitch36_g252160;
				half2 ZY500_g252156 = temp_output_462_0_g252156;
				half2 ZY_1500_g252156 = (Out_MaskC456_g252156).zw;
				half2 ZY_2500_g252156 = (Out_MaskD456_g252156).xy;
				half2 ZY_3500_g252156 = (Out_MaskD456_g252156).zw;
				half2 XZ500_g252156 = temp_output_463_0_g252156;
				half2 XZ_1500_g252156 = temp_output_473_0_g252156;
				half2 XZ_2500_g252156 = temp_output_474_0_g252156;
				half2 XZ_3500_g252156 = temp_output_475_0_g252156;
				half2 XY500_g252156 = temp_output_464_0_g252156;
				half2 XY_1500_g252156 = (Out_MaskF456_g252156).zw;
				half2 XY_2500_g252156 = (Out_MaskG456_g252156).xy;
				half2 XY_3500_g252156 = (Out_MaskG456_g252156).zw;
				half Bias500_g252156 = temp_output_510_0_g252156;
				half3 Weights_1500_g252156 = (Out_MaskH456_g252156).xyz;
				half3 Weights_2500_g252156 = temp_output_480_0_g252156;
				half3 Weights_3500_g252156 = (Out_MaskJ456_g252156).xyz;
				half3 Triplanar500_g252156 = temp_output_482_0_g252156;
				half3 NormalWS500_g252156 = temp_output_483_0_g252156;
				half3 Normal500_g252156 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g252156 = SampleStochastic3D( Texture500_g252156 , Sampler500_g252156 , ZY500_g252156 , ZY_1500_g252156 , ZY_2500_g252156 , ZY_3500_g252156 , XZ500_g252156 , XZ_1500_g252156 , XZ_2500_g252156 , XZ_3500_g252156 , XY500_g252156 , XY_1500_g252156 , XY_2500_g252156 , XY_3500_g252156 , Bias500_g252156 , Weights_1500_g252156 , Weights_2500_g252156 , Weights_3500_g252156 , Triplanar500_g252156 , NormalWS500_g252156 , Normal500_g252156 );
				float4 temp_output_1130_203_g252131 = localSampleStochastic3D500_g252156;
				#if defined( TVE_OVERLAY_SAMPLE_PLANAR_2D )
				float4 staticSwitch676_g252131 = temp_output_1130_0_g252131;
				#elif defined( TVE_OVERLAY_SAMPLE_PLANAR_3D )
				float4 staticSwitch676_g252131 = temp_output_1130_201_g252131;
				#elif defined( TVE_OVERLAY_SAMPLE_STOCHASTIC_2D )
				float4 staticSwitch676_g252131 = temp_output_1130_202_g252131;
				#elif defined( TVE_OVERLAY_SAMPLE_STOCHASTIC_3D )
				float4 staticSwitch676_g252131 = temp_output_1130_203_g252131;
				#else
				float4 staticSwitch676_g252131 = temp_output_1130_0_g252131;
				#endif
				half3 Local_AlbedoSample526_g252131 = (staticSwitch676_g252131).xyz;
				float3 temp_output_6_0_g252152 = Local_AlbedoSample526_g252131;
				float temp_output_7_0_g252152 = _OverlayTextureMode;
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g252152 = ( temp_output_6_0_g252152 + temp_output_7_0_g252152 );
				#else
				float3 staticSwitch14_g252152 = temp_output_6_0_g252152;
				#endif
				float3 temp_output_468_0_g252131 = ( _OverlayColor.rgb * staticSwitch14_g252152 );
				#ifdef TVE_OVERLAY_TEX
				float3 staticSwitch578_g252131 = temp_output_468_0_g252131;
				#else
				float3 staticSwitch578_g252131 = _OverlayColor.rgb;
				#endif
				float3 temp_cast_50 = (0.0).xxx;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252168) = _OverlayGlitterTexRT;
				SamplerState Sampler490_g252168 = sampler_Linear_Repeat;
				float localBreakTextureData456_g252168 = ( 0.0 );
				float localBuildTextureData431_g252157 = ( 0.0 );
				TVEMasksData Data431_g252157 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g252157 = ( 0.0 );
				float temp_output_442_0_g252157 = _OverlayGlitterTillingValue;
				float4 appendResult443_g252157 = (float4(temp_output_442_0_g252157 , temp_output_442_0_g252157 , 0.0 , 0.0));
				float4 Coords444_g252157 = appendResult443_g252157;
				float4 MeshCoords444_g252157 = float4( 0,0,0,0 );
				float2 UV0444_g252157 = float2( 0,0 );
				float2 UV3444_g252157 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g252157 , MeshCoords444_g252157 , UV0444_g252157 , UV3444_g252157 );
				float4 appendResult430_g252157 = (float4(UV0444_g252157 , UV3444_g252157));
				float4 In_MaskA431_g252157 = appendResult430_g252157;
				float localComputeWorldCoords315_g252157 = ( 0.0 );
				float4 Coords315_g252157 = appendResult443_g252157;
				float3 PositionWS315_g252157 = Model_PositionWO602_g252131;
				float2 ZY315_g252157 = float2( 0,0 );
				float2 XZ315_g252157 = float2( 0,0 );
				float2 XY315_g252157 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g252157 , PositionWS315_g252157 , ZY315_g252157 , XZ315_g252157 , XY315_g252157 );
				float2 ZY402_g252157 = ZY315_g252157;
				float2 XZ403_g252157 = XZ315_g252157;
				float4 appendResult432_g252157 = (float4(ZY402_g252157 , XZ403_g252157));
				float4 In_MaskB431_g252157 = appendResult432_g252157;
				float2 XY404_g252157 = XY315_g252157;
				float localComputeStochasticCoords409_g252157 = ( 0.0 );
				float2 UV409_g252157 = ZY402_g252157;
				float2 UV1409_g252157 = float2( 0,0 );
				float2 UV2409_g252157 = float2( 0,0 );
				float2 UV3409_g252157 = float2( 0,0 );
				float3 Weights409_g252157 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g252157 , UV1409_g252157 , UV2409_g252157 , UV3409_g252157 , Weights409_g252157 );
				float4 appendResult433_g252157 = (float4(XY404_g252157 , UV1409_g252157));
				float4 In_MaskC431_g252157 = appendResult433_g252157;
				float4 appendResult434_g252157 = (float4(UV2409_g252157 , UV3409_g252157));
				float4 In_MaskD431_g252157 = appendResult434_g252157;
				float localComputeStochasticCoords422_g252157 = ( 0.0 );
				float2 UV422_g252157 = XZ403_g252157;
				float2 UV1422_g252157 = float2( 0,0 );
				float2 UV2422_g252157 = float2( 0,0 );
				float2 UV3422_g252157 = float2( 0,0 );
				float3 Weights422_g252157 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g252157 , UV1422_g252157 , UV2422_g252157 , UV3422_g252157 , Weights422_g252157 );
				float4 appendResult435_g252157 = (float4(UV1422_g252157 , UV2422_g252157));
				float4 In_MaskE431_g252157 = appendResult435_g252157;
				float localComputeStochasticCoords423_g252157 = ( 0.0 );
				float2 UV423_g252157 = XY404_g252157;
				float2 UV1423_g252157 = float2( 0,0 );
				float2 UV2423_g252157 = float2( 0,0 );
				float2 UV3423_g252157 = float2( 0,0 );
				float3 Weights423_g252157 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g252157 , UV1423_g252157 , UV2423_g252157 , UV3423_g252157 , Weights423_g252157 );
				float4 appendResult436_g252157 = (float4(UV3422_g252157 , UV1423_g252157));
				float4 In_MaskF431_g252157 = appendResult436_g252157;
				float4 appendResult437_g252157 = (float4(UV2423_g252157 , UV3423_g252157));
				float4 In_MaskG431_g252157 = appendResult437_g252157;
				float4 In_MaskH431_g252157 = float4( Weights409_g252157 , 0.0 );
				float4 In_MaskI431_g252157 = float4( Weights422_g252157 , 0.0 );
				float4 In_MaskJ431_g252157 = float4( Weights423_g252157 , 0.0 );
				float3 temp_output_449_0_g252157 = Model_NormalWS712_g252131;
				float4 In_MaskK431_g252157 = float4( temp_output_449_0_g252157 , 0.0 );
				float3 temp_output_450_0_g252157 = float3( 0,0,0 );
				float4 In_MaskL431_g252157 = float4( temp_output_450_0_g252157 , 0.0 );
				float3 temp_output_451_0_g252157 = float3( 0,0,0 );
				float4 In_MaskM431_g252157 = float4( temp_output_451_0_g252157 , 0.0 );
				float3 temp_output_445_0_g252157 = Model_TriplanarWeights1136_g252131;
				float4 In_MaskN431_g252157 = float4( temp_output_445_0_g252157 , 0.0 );
				BuildTextureData( Data431_g252157 , In_MaskA431_g252157 , In_MaskB431_g252157 , In_MaskC431_g252157 , In_MaskD431_g252157 , In_MaskE431_g252157 , In_MaskF431_g252157 , In_MaskG431_g252157 , In_MaskH431_g252157 , In_MaskI431_g252157 , In_MaskJ431_g252157 , In_MaskK431_g252157 , In_MaskL431_g252157 , In_MaskM431_g252157 , In_MaskN431_g252157 );
				TVEMasksData Data456_g252168 =(TVEMasksData)Data431_g252157;
				float4 Out_MaskA456_g252168 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g252168 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g252168 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g252168 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g252168 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g252168 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g252168 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g252168 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g252168 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g252168 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g252168 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g252168 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g252168 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g252168 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g252168 , Out_MaskA456_g252168 , Out_MaskB456_g252168 , Out_MaskC456_g252168 , Out_MaskD456_g252168 , Out_MaskE456_g252168 , Out_MaskF456_g252168 , Out_MaskG456_g252168 , Out_MaskH456_g252168 , Out_MaskI456_g252168 , Out_MaskJ456_g252168 , Out_MaskK456_g252168 , Out_MaskL456_g252168 , Out_MaskM456_g252168 , Out_MaskN456_g252168 );
				float2 temp_output_462_0_g252168 = (Out_MaskB456_g252168).xy;
				half2 ZY490_g252168 = temp_output_462_0_g252168;
				float2 temp_output_463_0_g252168 = (Out_MaskB456_g252168).zw;
				half2 XZ490_g252168 = temp_output_463_0_g252168;
				float2 temp_output_464_0_g252168 = (Out_MaskC456_g252168).xy;
				half2 XY490_g252168 = temp_output_464_0_g252168;
				float temp_output_504_0_g252168 = 0.0;
				half Bias490_g252168 = temp_output_504_0_g252168;
				float3 temp_output_482_0_g252168 = (Out_MaskN456_g252168).xyz;
				half3 Triplanar490_g252168 = temp_output_482_0_g252168;
				float3 temp_output_483_0_g252168 = (Out_MaskK456_g252168).xyz;
				half3 NormalWS490_g252168 = temp_output_483_0_g252168;
				half3 Normal490_g252168 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g252168 = SamplePlanar3D( Texture490_g252168 , Sampler490_g252168 , ZY490_g252168 , XZ490_g252168 , XY490_g252168 , Bias490_g252168 , Triplanar490_g252168 , NormalWS490_g252168 , Normal490_g252168 );
				half Local_GlitterRT854_g252131 = (localSamplePlanar3D490_g252168).x;
				float3 ase_positionWS = i.ase_texcoord8.xyz;
				UNITY_LIGHT_ATTENUATION( ase_lightAtten, i, ase_positionWS )
				float lerpResult922_g252131 = lerp( 1.0 , ase_lightAtten , _OverlayGlitterAttenValue);
				float3 Model_PositionWS879_g252131 = Out_PositionWS15_g252174;
				float3 temp_output_858_0_g252131 = ( _OverlayGlitterIntensityValue * (_OverlayGlitterColor).rgb * Local_GlitterRT854_g252131 * lerpResult922_g252131 * ( 1.0 - saturate( ( distance( _WorldSpaceCameraPos , Model_PositionWS879_g252131 ) / _OverlayGlitterDistValue ) ) ) );
				#ifdef TVE_OVERLAY_GLITTER
				float3 staticSwitch868_g252131 = temp_output_858_0_g252131;
				#else
				float3 staticSwitch868_g252131 = temp_cast_50;
				#endif
				half3 Local_GlitterColor865_g252131 = staticSwitch868_g252131;
				half Blend_TexMask908_g252131 = 1.0;
				float temp_output_739_15_g252131 = Out_Luminosity4_g252172;
				half Visual_Luminosity654_g252131 = temp_output_739_15_g252131;
				float temp_output_7_0_g252143 = _OverlayLumaRemap.x;
				float temp_output_9_0_g252143 = ( Visual_Luminosity654_g252131 - temp_output_7_0_g252143 );
				float lerpResult587_g252131 = lerp( 1.0 , saturate( ( temp_output_9_0_g252143 * _OverlayLumaRemap.z ) ) , _OverlayLumaValue);
				half Blend_LumaMask438_g252131 = lerpResult587_g252131;
				float temp_output_17_0_g252161 = _OverlayMeshMode;
				float Option70_g252161 = temp_output_17_0_g252161;
				half4 Model_VertexData791_g252131 = Out_VertexData15_g252174;
				float4 temp_output_3_0_g252161 = Model_VertexData791_g252131;
				float4 Channel70_g252161 = temp_output_3_0_g252161;
				float localSwitchChannel470_g252161 = SwitchChannel4( Option70_g252161 , Channel70_g252161 );
				float temp_output_1142_0_g252131 = localSwitchChannel470_g252161;
				float temp_output_7_0_g252141 = _OverlayMeshRemap.x;
				float temp_output_9_0_g252141 = ( temp_output_1142_0_g252131 - temp_output_7_0_g252141 );
				float lerpResult881_g252131 = lerp( 1.0 , saturate( ( temp_output_9_0_g252141 * _OverlayMeshRemap.z ) ) , _OverlayMeshValue);
				half Blend_VertMask801_g252131 = lerpResult881_g252131;
				float3 temp_output_739_21_g252131 = Out_NormalWS4_g252172;
				half3 Visual_NormalWS749_g252131 = temp_output_739_21_g252131;
				float temp_output_505_0_g252131 = saturate( (Visual_NormalWS749_g252131).y );
				float temp_output_7_0_g252146 = _OverlayProjRemap.x;
				float temp_output_9_0_g252146 = ( temp_output_505_0_g252131 - temp_output_7_0_g252146 );
				float lerpResult842_g252131 = lerp( 1.0 , saturate( ( temp_output_9_0_g252146 * _OverlayProjRemap.z ) ) , _OverlayProjValue);
				half Blend_ProjMask457_g252131 = lerpResult842_g252131;
				half Blend_NoiseMask427_g252131 = 1.0;
				half Blend_UserMask646_g252131 = 1.0;
				half Blend_FormMask_Mul958_g252131 = 1.0;
				half Blend_GlobalMask429_g252131 = 1.0;
				half Blend_FormMask_Add957_g252131 = 0.0;
				float temp_output_970_0_g252131 = ( saturate( ( ( Blend_TexMask908_g252131 * Blend_LumaMask438_g252131 * Blend_VertMask801_g252131 * Blend_ProjMask457_g252131 * Blend_NoiseMask427_g252131 * Blend_UserMask646_g252131 * Blend_FormMask_Mul958_g252131 * Blend_GlobalMask429_g252131 ) + Blend_FormMask_Add957_g252131 ) ) * _OverlayIntensityValue );
				float temp_output_7_0_g252149 = _OverlayBlendRemap.x;
				float temp_output_9_0_g252149 = ( temp_output_970_0_g252131 - temp_output_7_0_g252149 );
				half Blend_Mask494_g252131 = saturate( ( temp_output_9_0_g252149 * _OverlayBlendRemap.z ) );
				float3 lerpResult467_g252131 = lerp( Visual_Albedo127_g252131 , ( staticSwitch578_g252131 + Local_GlitterColor865_g252131 ) , Blend_Mask494_g252131);
				#ifdef TVE_OVERLAY
				float3 staticSwitch577_g252131 = lerpResult467_g252131;
				#else
				float3 staticSwitch577_g252131 = Visual_Albedo127_g252131;
				#endif
				half3 Final_Albedo493_g252131 = staticSwitch577_g252131;
				float3 temp_output_4_0_g252173 = Final_Albedo493_g252131;
				float3 In_Albedo3_g252173 = temp_output_4_0_g252173;
				float3 temp_output_44_0_g252173 = Out_AlbedoBase4_g252172;
				float3 In_AlbedoBase3_g252173 = temp_output_44_0_g252173;
				half2 Visual_NormalTS535_g252131 = Out_NormalTS4_g252172;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252154) = _OverlayNormalTex;
				#if defined( TVE_FILTER_DEFAULT )
				SamplerState staticSwitch37_g252159 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_POINT )
				SamplerState staticSwitch37_g252159 = sampler_Point_Repeat;
				#elif defined( TVE_FILTER_LOW )
				SamplerState staticSwitch37_g252159 = sampler_Linear_Repeat;
				#elif defined( TVE_FILTER_MEDIUM )
				SamplerState staticSwitch37_g252159 = sampler_Linear_Repeat_Aniso8;
				#elif defined( TVE_FILTER_HIGH )
				SamplerState staticSwitch37_g252159 = sampler_Linear_Repeat_Aniso8;
				#else
				SamplerState staticSwitch37_g252159 = sampler_Linear_Repeat;
				#endif
				SamplerState Sampler496_g252154 = staticSwitch37_g252159;
				float localBreakTextureData456_g252154 = ( 0.0 );
				TVEMasksData Data456_g252154 =(TVEMasksData)Data431_g252153;
				float4 Out_MaskA456_g252154 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g252154 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g252154 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g252154 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g252154 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g252154 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g252154 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g252154 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g252154 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g252154 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g252154 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g252154 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g252154 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g252154 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g252154 , Out_MaskA456_g252154 , Out_MaskB456_g252154 , Out_MaskC456_g252154 , Out_MaskD456_g252154 , Out_MaskE456_g252154 , Out_MaskF456_g252154 , Out_MaskG456_g252154 , Out_MaskH456_g252154 , Out_MaskI456_g252154 , Out_MaskJ456_g252154 , Out_MaskK456_g252154 , Out_MaskL456_g252154 , Out_MaskM456_g252154 , Out_MaskN456_g252154 );
				float2 temp_output_463_0_g252154 = (Out_MaskB456_g252154).zw;
				half2 XZ496_g252154 = temp_output_463_0_g252154;
				float temp_output_504_0_g252154 = 0.0;
				half Bias496_g252154 = temp_output_504_0_g252154;
				float3 temp_output_483_0_g252154 = (Out_MaskK456_g252154).xyz;
				half3 NormalWS496_g252154 = temp_output_483_0_g252154;
				half3 Normal496_g252154 = float3( 0,0,0 );
				half4 localSamplePlanar2D496_g252154 = SamplePlanar2D( Texture496_g252154 , Sampler496_g252154 , XZ496_g252154 , Bias496_g252154 , NormalWS496_g252154 , Normal496_g252154 );
				float3 worldToTangentDir408_g252154 = normalize( mul( ase_worldToTangent, Normal496_g252154 ) );
				float2 temp_output_1126_375_g252131 = (worldToTangentDir408_g252154).xy;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252154) = _OverlayNormalTex;
				SamplerState Sampler490_g252154 = staticSwitch37_g252159;
				float2 temp_output_462_0_g252154 = (Out_MaskB456_g252154).xy;
				half2 ZY490_g252154 = temp_output_462_0_g252154;
				half2 XZ490_g252154 = temp_output_463_0_g252154;
				float2 temp_output_464_0_g252154 = (Out_MaskC456_g252154).xy;
				half2 XY490_g252154 = temp_output_464_0_g252154;
				half Bias490_g252154 = temp_output_504_0_g252154;
				float3 temp_output_482_0_g252154 = (Out_MaskN456_g252154).xyz;
				half3 Triplanar490_g252154 = temp_output_482_0_g252154;
				half3 NormalWS490_g252154 = temp_output_483_0_g252154;
				half3 Normal490_g252154 = float3( 0,0,0 );
				half4 localSamplePlanar3D490_g252154 = SamplePlanar3D( Texture490_g252154 , Sampler490_g252154 , ZY490_g252154 , XZ490_g252154 , XY490_g252154 , Bias490_g252154 , Triplanar490_g252154 , NormalWS490_g252154 , Normal490_g252154 );
				float3 worldToTangentDir399_g252154 = normalize( mul( ase_worldToTangent, Normal490_g252154 ) );
				float2 temp_output_1126_353_g252131 = (worldToTangentDir399_g252154).xy;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252154) = _OverlayNormalTex;
				SamplerState Sampler498_g252154 = staticSwitch37_g252159;
				half2 XZ498_g252154 = temp_output_463_0_g252154;
				float2 temp_output_473_0_g252154 = (Out_MaskE456_g252154).xy;
				half2 XZ_1498_g252154 = temp_output_473_0_g252154;
				float2 temp_output_474_0_g252154 = (Out_MaskE456_g252154).zw;
				half2 XZ_2498_g252154 = temp_output_474_0_g252154;
				float2 temp_output_475_0_g252154 = (Out_MaskF456_g252154).xy;
				half2 XZ_3498_g252154 = temp_output_475_0_g252154;
				float temp_output_510_0_g252154 = exp2( temp_output_504_0_g252154 );
				half Bias498_g252154 = temp_output_510_0_g252154;
				float3 temp_output_480_0_g252154 = (Out_MaskI456_g252154).xyz;
				half3 Weights_2498_g252154 = temp_output_480_0_g252154;
				half3 NormalWS498_g252154 = temp_output_483_0_g252154;
				half3 Normal498_g252154 = float3( 0,0,0 );
				half4 localSampleStochastic2D498_g252154 = SampleStochastic2D( Texture498_g252154 , Sampler498_g252154 , XZ498_g252154 , XZ_1498_g252154 , XZ_2498_g252154 , XZ_3498_g252154 , Bias498_g252154 , Weights_2498_g252154 , NormalWS498_g252154 , Normal498_g252154 );
				float3 worldToTangentDir411_g252154 = normalize( mul( ase_worldToTangent, Normal498_g252154 ) );
				float2 temp_output_1126_391_g252131 = (worldToTangentDir411_g252154).xy;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252154) = _OverlayNormalTex;
				SamplerState Sampler500_g252154 = staticSwitch37_g252159;
				half2 ZY500_g252154 = temp_output_462_0_g252154;
				half2 ZY_1500_g252154 = (Out_MaskC456_g252154).zw;
				half2 ZY_2500_g252154 = (Out_MaskD456_g252154).xy;
				half2 ZY_3500_g252154 = (Out_MaskD456_g252154).zw;
				half2 XZ500_g252154 = temp_output_463_0_g252154;
				half2 XZ_1500_g252154 = temp_output_473_0_g252154;
				half2 XZ_2500_g252154 = temp_output_474_0_g252154;
				half2 XZ_3500_g252154 = temp_output_475_0_g252154;
				half2 XY500_g252154 = temp_output_464_0_g252154;
				half2 XY_1500_g252154 = (Out_MaskF456_g252154).zw;
				half2 XY_2500_g252154 = (Out_MaskG456_g252154).xy;
				half2 XY_3500_g252154 = (Out_MaskG456_g252154).zw;
				half Bias500_g252154 = temp_output_510_0_g252154;
				half3 Weights_1500_g252154 = (Out_MaskH456_g252154).xyz;
				half3 Weights_2500_g252154 = temp_output_480_0_g252154;
				half3 Weights_3500_g252154 = (Out_MaskJ456_g252154).xyz;
				half3 Triplanar500_g252154 = temp_output_482_0_g252154;
				half3 NormalWS500_g252154 = temp_output_483_0_g252154;
				half3 Normal500_g252154 = float3( 0,0,0 );
				half4 localSampleStochastic3D500_g252154 = SampleStochastic3D( Texture500_g252154 , Sampler500_g252154 , ZY500_g252154 , ZY_1500_g252154 , ZY_2500_g252154 , ZY_3500_g252154 , XZ500_g252154 , XZ_1500_g252154 , XZ_2500_g252154 , XZ_3500_g252154 , XY500_g252154 , XY_1500_g252154 , XY_2500_g252154 , XY_3500_g252154 , Bias500_g252154 , Weights_1500_g252154 , Weights_2500_g252154 , Weights_3500_g252154 , Triplanar500_g252154 , NormalWS500_g252154 , Normal500_g252154 );
				float3 worldToTangentDir403_g252154 = normalize( mul( ase_worldToTangent, Normal500_g252154 ) );
				float2 temp_output_1126_390_g252131 = (worldToTangentDir403_g252154).xy;
				#if defined( TVE_OVERLAY_SAMPLE_PLANAR_2D )
				float2 staticSwitch686_g252131 = temp_output_1126_375_g252131;
				#elif defined( TVE_OVERLAY_SAMPLE_PLANAR_3D )
				float2 staticSwitch686_g252131 = temp_output_1126_353_g252131;
				#elif defined( TVE_OVERLAY_SAMPLE_STOCHASTIC_2D )
				float2 staticSwitch686_g252131 = temp_output_1126_391_g252131;
				#elif defined( TVE_OVERLAY_SAMPLE_STOCHASTIC_3D )
				float2 staticSwitch686_g252131 = temp_output_1126_390_g252131;
				#else
				float2 staticSwitch686_g252131 = temp_output_1126_375_g252131;
				#endif
				half2 Local_NormalSample528_g252131 = staticSwitch686_g252131;
				#ifdef TVE_OVERLAY_TEX
				float2 staticSwitch579_g252131 = Local_NormalSample528_g252131;
				#else
				float2 staticSwitch579_g252131 = Visual_NormalTS535_g252131;
				#endif
				float2 lerpResult551_g252131 = lerp( Visual_NormalTS535_g252131 , ( staticSwitch579_g252131 * _OverlayNormalValue ) , Blend_Mask494_g252131);
				#ifdef TVE_OVERLAY
				float2 staticSwitch583_g252131 = lerpResult551_g252131;
				#else
				float2 staticSwitch583_g252131 = Visual_NormalTS535_g252131;
				#endif
				half2 Final_NormalTS499_g252131 = staticSwitch583_g252131;
				float2 In_NormalTS3_g252173 = Final_NormalTS499_g252131;
				float3 In_NormalWS3_g252173 = temp_output_739_21_g252131;
				half4 Visual_Shader536_g252131 = Out_Shader4_g252172;
				float4 appendResult585_g252131 = (float4(0.0 , 1.0 , 1.0 , _OverlaySmoothnessValue));
				float4 lerpResult584_g252131 = lerp( Visual_Shader536_g252131 , appendResult585_g252131 , Blend_Mask494_g252131);
				#ifdef TVE_OVERLAY
				float4 staticSwitch586_g252131 = lerpResult584_g252131;
				#else
				float4 staticSwitch586_g252131 = Visual_Shader536_g252131;
				#endif
				half4 Final_Shader482_g252131 = staticSwitch586_g252131;
				float4 In_Shader3_g252173 = Final_Shader482_g252131;
				float4 In_Feature3_g252173 = Out_Feature4_g252172;
				float4 In_Season3_g252173 = Out_Season4_g252172;
				float4 In_Emissive3_g252173 = Out_Emissive4_g252172;
				float temp_output_739_12_g252131 = Out_Grayscale4_g252172;
				float temp_output_12_0_g252173 = temp_output_739_12_g252131;
				float In_Grayscale3_g252173 = temp_output_12_0_g252173;
				float temp_output_16_0_g252173 = temp_output_739_15_g252131;
				float In_Luminosity3_g252173 = temp_output_16_0_g252173;
				float In_MultiMask3_g252173 = Out_MultiMask4_g252172;
				float In_AlphaClip3_g252173 = Out_AlphaClip4_g252172;
				float In_AlphaFade3_g252173 = Out_AlphaFade4_g252172;
				float3 In_Translucency3_g252173 = Out_Translucency4_g252172;
				half Visual_Transmission699_g252131 = Out_Transmission4_g252172;
				float lerpResult746_g252131 = lerp( Visual_Transmission699_g252131 , ( Visual_Transmission699_g252131 * _OverlaySubsurfaceValue ) , ( Blend_VertMask801_g252131 * Blend_NoiseMask427_g252131 * Blend_GlobalMask429_g252131 ));
				#ifdef TVE_OVERLAY
				float staticSwitch703_g252131 = lerpResult746_g252131;
				#else
				float staticSwitch703_g252131 = Visual_Transmission699_g252131;
				#endif
				half Final_Transmission702_g252131 = staticSwitch703_g252131;
				float In_Transmission3_g252173 = Final_Transmission702_g252131;
				float In_Thickness3_g252173 = Out_Thickness4_g252172;
				float In_Diffusion3_g252173 = Out_Diffusion4_g252172;
				float In_Depth3_g252173 = Out_Depth4_g252172;
				BuildVisualData( Data3_g252173 , In_Dummy3_g252173 , In_Albedo3_g252173 , In_AlbedoBase3_g252173 , In_NormalTS3_g252173 , In_NormalWS3_g252173 , In_Shader3_g252173 , In_Feature3_g252173 , In_Season3_g252173 , In_Emissive3_g252173 , In_Grayscale3_g252173 , In_Luminosity3_g252173 , In_MultiMask3_g252173 , In_AlphaClip3_g252173 , In_AlphaFade3_g252173 , In_Translucency3_g252173 , In_Transmission3_g252173 , In_Thickness3_g252173 , In_Diffusion3_g252173 , In_Depth3_g252173 );
				TVEVisualData DataB25_g252184 = Data3_g252173;
				float Alpha25_g252184 = _OverlayBakeMode;
				{
				if (Alpha25_g252184 < 0.5 )
				{
				Data25_g252184 = DataA25_g252184;
				}
				else
				{
				Data25_g252184 = DataB25_g252184;
				}
				}
				TVEVisualData DataA25_g252217 = Data25_g252184;
				float localBuildVisualData3_g252187 = ( 0.0 );
				float localBreakVisualData4_g252186 = ( 0.0 );
				TVEVisualData Data4_g252186 =(TVEVisualData)Data25_g252184;
				float Out_Dummy4_g252186 = 0.0;
				float3 Out_Albedo4_g252186 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g252186 = float3( 0,0,0 );
				float2 Out_NormalTS4_g252186 = float2( 0,0 );
				float3 Out_NormalWS4_g252186 = float3( 0,0,0 );
				float4 Out_Shader4_g252186 = float4( 0,0,0,0 );
				float4 Out_Feature4_g252186 = float4( 0,0,0,0 );
				float4 Out_Season4_g252186 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g252186 = float4( 0,0,0,0 );
				float Out_MultiMask4_g252186 = 0.0;
				float Out_Grayscale4_g252186 = 0.0;
				float Out_Luminosity4_g252186 = 0.0;
				float Out_AlphaClip4_g252186 = 0.0;
				float Out_AlphaFade4_g252186 = 0.0;
				float3 Out_Translucency4_g252186 = float3( 0,0,0 );
				float Out_Transmission4_g252186 = 0.0;
				float Out_Thickness4_g252186 = 0.0;
				float Out_Diffusion4_g252186 = 0.0;
				float Out_Depth4_g252186 = 0.0;
				BreakVisualData( Data4_g252186 , Out_Dummy4_g252186 , Out_Albedo4_g252186 , Out_AlbedoBase4_g252186 , Out_NormalTS4_g252186 , Out_NormalWS4_g252186 , Out_Shader4_g252186 , Out_Feature4_g252186 , Out_Season4_g252186 , Out_Emissive4_g252186 , Out_MultiMask4_g252186 , Out_Grayscale4_g252186 , Out_Luminosity4_g252186 , Out_AlphaClip4_g252186 , Out_AlphaFade4_g252186 , Out_Translucency4_g252186 , Out_Transmission4_g252186 , Out_Thickness4_g252186 , Out_Diffusion4_g252186 , Out_Depth4_g252186 );
				TVEVisualData Data3_g252187 =(TVEVisualData)Data4_g252186;
				half Dummy594_g252185 = ( _WetnessCategory + _WetnessEnd + _WetnessBakeMode );
				float temp_output_14_0_g252187 = Dummy594_g252185;
				float In_Dummy3_g252187 = temp_output_14_0_g252187;
				half3 Visual_Albedo127_g252185 = Out_Albedo4_g252186;
				float2 break1123_g252185 = half2( 1,1 );
				half Global_Wetness429_g252185 = break1123_g252185.x;
				half Blend_VertMask1024_g252185 = 1.0;
				half Blend_FormMask_Mul1207_g252185 = 1.0;
				half Blend_FormMask_Add1205_g252185 = 0.0;
				half Wetness_Value1042_g252185 = ( saturate( ( ( Global_Wetness429_g252185 * Blend_VertMask1024_g252185 * Blend_FormMask_Mul1207_g252185 ) + Blend_FormMask_Add1205_g252185 ) ) * _WetnessIntensityValue );
				half Global_Rain955_g252185 = break1123_g252185.y;
				half Rain_VertMask1108_g252185 = 1.0;
				half Rain_Value1067_g252185 = ( _WetnessRainIntensityValue * Global_Rain955_g252185 * Rain_VertMask1108_g252185 );
				half Wetness_Mask866_g252185 = max( Wetness_Value1042_g252185, Rain_Value1067_g252185 );
				half Water_VertMask1094_g252185 = 1.0;
				half4 Visual_Shader536_g252185 = Out_Shader4_g252186;
				float temp_output_757_0_g252185 = (Visual_Shader536_g252185).z;
				half Water_HeightMask782_g252185 = ( temp_output_757_0_g252185 * _WetnessWaterBaseValue );
				float temp_output_758_0_g252185 = ( ( _WetnessWaterIntensityValue * Wetness_Mask866_g252185 * Water_VertMask1094_g252185 ) - Water_HeightMask782_g252185 );
				float temp_output_7_0_g252196 = _WetnessWaterBlendRemap.x;
				float temp_output_9_0_g252196 = ( temp_output_758_0_g252185 - temp_output_7_0_g252196 );
				float3 temp_output_794_21_g252185 = Out_NormalWS4_g252186;
				half3 Visual_NormalWS1146_g252185 = temp_output_794_21_g252185;
				float temp_output_786_0_g252185 = saturate( (Visual_NormalWS1146_g252185).y );
				half Blend_ProjMask790_g252185 = temp_output_786_0_g252185;
				half Water_Mask760_g252185 = ( saturate( ( temp_output_9_0_g252196 * _WetnessWaterBlendRemap.z ) ) * Blend_ProjMask790_g252185 );
				float3 lerpResult918_g252185 = lerp( Visual_Albedo127_g252185 , ( Visual_Albedo127_g252185 * (_WetnessWaterColor).rgb ) , Water_Mask760_g252185);
				#ifdef TVE_WETNESS_WATER
				float3 staticSwitch946_g252185 = lerpResult918_g252185;
				#else
				float3 staticSwitch946_g252185 = Visual_Albedo127_g252185;
				#endif
				float3 lerpResult768_g252185 = lerp( staticSwitch946_g252185 , ( staticSwitch946_g252185 * staticSwitch946_g252185 ) , _WetnessContrastValue);
				float3 lerpResult651_g252185 = lerp( Visual_Albedo127_g252185 , lerpResult768_g252185 , Wetness_Mask866_g252185);
				#ifdef TVE_WETNESS
				float3 staticSwitch577_g252185 = lerpResult651_g252185;
				#else
				float3 staticSwitch577_g252185 = Visual_Albedo127_g252185;
				#endif
				half3 Final_Albedo493_g252185 = staticSwitch577_g252185;
				float3 temp_output_4_0_g252187 = Final_Albedo493_g252185;
				float3 In_Albedo3_g252187 = temp_output_4_0_g252187;
				float3 temp_output_44_0_g252187 = Out_AlbedoBase4_g252186;
				float3 In_AlbedoBase3_g252187 = temp_output_44_0_g252187;
				half2 Visual_NormalTS535_g252185 = Out_NormalTS4_g252186;
				#ifdef TVE_WETNESS
				float2 staticSwitch774_g252185 = Visual_NormalTS535_g252185;
				#else
				float2 staticSwitch774_g252185 = Visual_NormalTS535_g252185;
				#endif
				half2 Final_NormalTS499_g252185 = staticSwitch774_g252185;
				float2 In_NormalTS3_g252187 = Final_NormalTS499_g252185;
				float3 In_NormalWS3_g252187 = temp_output_794_21_g252185;
				float4 break658_g252185 = Visual_Shader536_g252185;
				float temp_output_935_0_g252185 = ( Wetness_Mask866_g252185 * _WetnessSmoothnessValue );
				float lerpResult941_g252185 = lerp( temp_output_935_0_g252185 , _WetnessWaterSmoothnessValue , Water_Mask760_g252185);
				#ifdef TVE_WETNESS_WATER
				float staticSwitch959_g252185 = lerpResult941_g252185;
				#else
				float staticSwitch959_g252185 = temp_output_935_0_g252185;
				#endif
				float4 appendResult661_g252185 = (float4(break658_g252185.x , break658_g252185.y , break658_g252185.z , saturate( ( break658_g252185.w + staticSwitch959_g252185 ) )));
				#ifdef TVE_WETNESS
				float4 staticSwitch586_g252185 = appendResult661_g252185;
				#else
				float4 staticSwitch586_g252185 = Visual_Shader536_g252185;
				#endif
				half4 Final_Sjader482_g252185 = staticSwitch586_g252185;
				float4 In_Shader3_g252187 = Final_Sjader482_g252185;
				float4 In_Feature3_g252187 = Out_Feature4_g252186;
				float4 In_Season3_g252187 = Out_Season4_g252186;
				float4 In_Emissive3_g252187 = Out_Emissive4_g252186;
				float temp_output_12_0_g252187 = Out_Grayscale4_g252186;
				float In_Grayscale3_g252187 = temp_output_12_0_g252187;
				float temp_output_16_0_g252187 = Out_Luminosity4_g252186;
				float In_Luminosity3_g252187 = temp_output_16_0_g252187;
				float In_MultiMask3_g252187 = Out_MultiMask4_g252186;
				float In_AlphaClip3_g252187 = Out_AlphaClip4_g252186;
				float In_AlphaFade3_g252187 = Out_AlphaFade4_g252186;
				float3 In_Translucency3_g252187 = Out_Translucency4_g252186;
				float In_Transmission3_g252187 = Out_Transmission4_g252186;
				float In_Thickness3_g252187 = Out_Thickness4_g252186;
				float In_Diffusion3_g252187 = Out_Diffusion4_g252186;
				float In_Depth3_g252187 = Out_Depth4_g252186;
				BuildVisualData( Data3_g252187 , In_Dummy3_g252187 , In_Albedo3_g252187 , In_AlbedoBase3_g252187 , In_NormalTS3_g252187 , In_NormalWS3_g252187 , In_Shader3_g252187 , In_Feature3_g252187 , In_Season3_g252187 , In_Emissive3_g252187 , In_Grayscale3_g252187 , In_Luminosity3_g252187 , In_MultiMask3_g252187 , In_AlphaClip3_g252187 , In_AlphaFade3_g252187 , In_Translucency3_g252187 , In_Transmission3_g252187 , In_Thickness3_g252187 , In_Diffusion3_g252187 , In_Depth3_g252187 );
				TVEVisualData DataB25_g252217 = Data3_g252187;
				float Alpha25_g252217 = _WetnessBakeMode;
				{
				if (Alpha25_g252217 < 0.5 )
				{
				Data25_g252217 = DataA25_g252217;
				}
				else
				{
				Data25_g252217 = DataB25_g252217;
				}
				}
				TVEVisualData DataA25_g252241 = Data25_g252217;
				float localBuildVisualData3_g252221 = ( 0.0 );
				float localBreakVisualData4_g252222 = ( 0.0 );
				TVEVisualData Data4_g252222 =(TVEVisualData)Data25_g252217;
				float Out_Dummy4_g252222 = 0.0;
				float3 Out_Albedo4_g252222 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g252222 = float3( 0,0,0 );
				float2 Out_NormalTS4_g252222 = float2( 0,0 );
				float3 Out_NormalWS4_g252222 = float3( 0,0,0 );
				float4 Out_Shader4_g252222 = float4( 0,0,0,0 );
				float4 Out_Feature4_g252222 = float4( 0,0,0,0 );
				float4 Out_Season4_g252222 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g252222 = float4( 0,0,0,0 );
				float Out_MultiMask4_g252222 = 0.0;
				float Out_Grayscale4_g252222 = 0.0;
				float Out_Luminosity4_g252222 = 0.0;
				float Out_AlphaClip4_g252222 = 0.0;
				float Out_AlphaFade4_g252222 = 0.0;
				float3 Out_Translucency4_g252222 = float3( 0,0,0 );
				float Out_Transmission4_g252222 = 0.0;
				float Out_Thickness4_g252222 = 0.0;
				float Out_Diffusion4_g252222 = 0.0;
				float Out_Depth4_g252222 = 0.0;
				BreakVisualData( Data4_g252222 , Out_Dummy4_g252222 , Out_Albedo4_g252222 , Out_AlbedoBase4_g252222 , Out_NormalTS4_g252222 , Out_NormalWS4_g252222 , Out_Shader4_g252222 , Out_Feature4_g252222 , Out_Season4_g252222 , Out_Emissive4_g252222 , Out_MultiMask4_g252222 , Out_Grayscale4_g252222 , Out_Luminosity4_g252222 , Out_AlphaClip4_g252222 , Out_AlphaFade4_g252222 , Out_Translucency4_g252222 , Out_Transmission4_g252222 , Out_Thickness4_g252222 , Out_Diffusion4_g252222 , Out_Depth4_g252222 );
				TVEVisualData Data3_g252221 =(TVEVisualData)Data4_g252222;
				half Dummy594_g252218 = ( _CutoutCategory + _CutoutEnd + _CutoutSpace + _CutoutBakeMode );
				float temp_output_14_0_g252221 = Dummy594_g252218;
				float In_Dummy3_g252221 = temp_output_14_0_g252221;
				float3 temp_output_4_0_g252221 = Out_Albedo4_g252222;
				float3 In_Albedo3_g252221 = temp_output_4_0_g252221;
				float3 temp_output_44_0_g252221 = Out_AlbedoBase4_g252222;
				float3 In_AlbedoBase3_g252221 = temp_output_44_0_g252221;
				float2 In_NormalTS3_g252221 = Out_NormalTS4_g252222;
				float3 In_NormalWS3_g252221 = Out_NormalWS4_g252222;
				float4 In_Shader3_g252221 = Out_Shader4_g252222;
				float4 In_Feature3_g252221 = Out_Feature4_g252222;
				float4 In_Season3_g252221 = Out_Season4_g252222;
				float4 In_Emissive3_g252221 = Out_Emissive4_g252222;
				float temp_output_12_0_g252221 = Out_Grayscale4_g252222;
				float In_Grayscale3_g252221 = temp_output_12_0_g252221;
				float temp_output_16_0_g252221 = Out_Luminosity4_g252222;
				float In_Luminosity3_g252221 = temp_output_16_0_g252221;
				float temp_output_865_11_g252218 = Out_MultiMask4_g252222;
				float In_MultiMask3_g252221 = temp_output_865_11_g252218;
				half Visual_AlphaClip667_g252218 = Out_AlphaClip4_g252222;
				half Local_GlobalMask429_g252218 = 1.0;
				float lerpResult811_g252218 = lerp( 1.0 , Visual_AlphaClip667_g252218 , _CutoutAlphaValue);
				half Local_AlphaMask814_g252218 = lerpResult811_g252218;
				float temp_output_17_0_g252239 = _CutoutMeshMode;
				float Option70_g252239 = temp_output_17_0_g252239;
				TVEModelData Data15_g252220 =(TVEModelData)Data16_g128405;
				float Out_Dummy15_g252220 = 0.0;
				float3 Out_PositionWS15_g252220 = float3( 0,0,0 );
				float3 Out_PositionWO15_g252220 = float3( 0,0,0 );
				float3 Out_PivotWS15_g252220 = float3( 0,0,0 );
				float3 Out_PivotWO15_g252220 = float3( 0,0,0 );
				float3 Out_NormalWS15_g252220 = float3( 0,0,0 );
				float3 Out_TangentWS15_g252220 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g252220 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g252220 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g252220 = float3( 0,0,0 );
				float4 Out_CoordsData15_g252220 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g252220 = float4( 0,0,0,0 );
				float4 Out_PhaseData15_g252220 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g252220 , Out_Dummy15_g252220 , Out_PositionWS15_g252220 , Out_PositionWO15_g252220 , Out_PivotWS15_g252220 , Out_PivotWO15_g252220 , Out_NormalWS15_g252220 , Out_TangentWS15_g252220 , Out_BitangentWS15_g252220 , Out_TriplanarWeights15_g252220 , Out_ViewDirWS15_g252220 , Out_CoordsData15_g252220 , Out_VertexData15_g252220 , Out_PhaseData15_g252220 );
				half4 Model_VertexMasks752_g252218 = Out_VertexData15_g252220;
				float4 temp_output_3_0_g252239 = Model_VertexMasks752_g252218;
				float4 Channel70_g252239 = temp_output_3_0_g252239;
				float localSwitchChannel470_g252239 = SwitchChannel4( Option70_g252239 , Channel70_g252239 );
				float temp_output_891_0_g252218 = localSwitchChannel470_g252239;
				float temp_output_7_0_g252225 = _CutoutMeshRemap.x;
				float temp_output_9_0_g252225 = ( temp_output_891_0_g252218 - temp_output_7_0_g252225 );
				float lerpResult820_g252218 = lerp( 1.0 , saturate( ( temp_output_9_0_g252225 * _CutoutMeshRemap.z ) ) , _CutoutMeshValue);
				half Local_VertMask766_g252218 = lerpResult820_g252218;
				float3 Model_PositionWO602_g252218 = Out_PositionWO15_g252220;
				float lerpResult673_g252218 = lerp( 1.0 , SAMPLE_TEXTURE3D( _NoiseTex3D, sampler_Linear_Repeat, ( Model_PositionWO602_g252218 * ( _CutoutNoiseTillingValue * 0.01 ) ) ).r , _CutoutNoiseValue);
				half Local_NoiseMask678_g252218 = lerpResult673_g252218;
				half Visual_MultiMask671_g252218 = temp_output_865_11_g252218;
				float lerpResult683_g252218 = lerp( 1.0 , Visual_MultiMask671_g252218 , _CutoutMultiValue);
				half Local_MultiMask685_g252218 = lerpResult683_g252218;
				float lerpResult728_g252218 = lerp( Visual_AlphaClip667_g252218 , min( Visual_AlphaClip667_g252218, ( -0.001 - ( ( _CutoutIntensityValue * Local_GlobalMask429_g252218 ) - ( Local_AlphaMask814_g252218 * Local_VertMask766_g252218 * Local_NoiseMask678_g252218 ) ) ) ) , Local_MultiMask685_g252218);
				half Local_AlphaClip784_g252218 = lerpResult728_g252218;
				#ifdef TVE_CUTOUT
				float staticSwitch577_g252218 = Local_AlphaClip784_g252218;
				#else
				float staticSwitch577_g252218 = Visual_AlphaClip667_g252218;
				#endif
				half Final_AlphaClip795_g252218 = staticSwitch577_g252218;
				float In_AlphaClip3_g252221 = Final_AlphaClip795_g252218;
				float In_AlphaFade3_g252221 = Out_AlphaFade4_g252222;
				float3 In_Translucency3_g252221 = Out_Translucency4_g252222;
				float In_Transmission3_g252221 = Out_Transmission4_g252222;
				float In_Thickness3_g252221 = Out_Thickness4_g252222;
				float In_Diffusion3_g252221 = Out_Diffusion4_g252222;
				float In_Depth3_g252221 = Out_Depth4_g252222;
				BuildVisualData( Data3_g252221 , In_Dummy3_g252221 , In_Albedo3_g252221 , In_AlbedoBase3_g252221 , In_NormalTS3_g252221 , In_NormalWS3_g252221 , In_Shader3_g252221 , In_Feature3_g252221 , In_Season3_g252221 , In_Emissive3_g252221 , In_Grayscale3_g252221 , In_Luminosity3_g252221 , In_MultiMask3_g252221 , In_AlphaClip3_g252221 , In_AlphaFade3_g252221 , In_Translucency3_g252221 , In_Transmission3_g252221 , In_Thickness3_g252221 , In_Diffusion3_g252221 , In_Depth3_g252221 );
				TVEVisualData DataB25_g252241 = Data3_g252221;
				float Alpha25_g252241 = _CutoutBakeMode;
				{
				if (Alpha25_g252241 < 0.5 )
				{
				Data25_g252241 = DataA25_g252241;
				}
				else
				{
				Data25_g252241 = DataB25_g252241;
				}
				}
				TVEVisualData Data4_g252256 =(TVEVisualData)Data25_g252241;
				float Out_Dummy4_g252256 = 0.0;
				float3 Out_Albedo4_g252256 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g252256 = float3( 0,0,0 );
				float2 Out_NormalTS4_g252256 = float2( 0,0 );
				float3 Out_NormalWS4_g252256 = float3( 0,0,0 );
				float4 Out_Shader4_g252256 = float4( 0,0,0,0 );
				float4 Out_Feature4_g252256 = float4( 0,0,0,0 );
				float4 Out_Season4_g252256 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g252256 = float4( 0,0,0,0 );
				float Out_MultiMask4_g252256 = 0.0;
				float Out_Grayscale4_g252256 = 0.0;
				float Out_Luminosity4_g252256 = 0.0;
				float Out_AlphaClip4_g252256 = 0.0;
				float Out_AlphaFade4_g252256 = 0.0;
				float3 Out_Translucency4_g252256 = float3( 0,0,0 );
				float Out_Transmission4_g252256 = 0.0;
				float Out_Thickness4_g252256 = 0.0;
				float Out_Diffusion4_g252256 = 0.0;
				float Out_Depth4_g252256 = 0.0;
				BreakVisualData( Data4_g252256 , Out_Dummy4_g252256 , Out_Albedo4_g252256 , Out_AlbedoBase4_g252256 , Out_NormalTS4_g252256 , Out_NormalWS4_g252256 , Out_Shader4_g252256 , Out_Feature4_g252256 , Out_Season4_g252256 , Out_Emissive4_g252256 , Out_MultiMask4_g252256 , Out_Grayscale4_g252256 , Out_Luminosity4_g252256 , Out_AlphaClip4_g252256 , Out_AlphaFade4_g252256 , Out_Translucency4_g252256 , Out_Transmission4_g252256 , Out_Thickness4_g252256 , Out_Diffusion4_g252256 , Out_Depth4_g252256 );
				TVEVisualData Data3_g252277 =(TVEVisualData)Data4_g252256;
				half Dummy145_g252253 = ( _EmissiveCategory + _EmissiveEnd + ( _EmissivePowerMode + _EmissivePowerValue ) + _EmissiveFlagMode );
				float temp_output_14_0_g252277 = Dummy145_g252253;
				float In_Dummy3_g252277 = temp_output_14_0_g252277;
				float3 temp_output_297_0_g252253 = Out_Albedo4_g252256;
				float3 temp_output_4_0_g252277 = temp_output_297_0_g252253;
				float3 In_Albedo3_g252277 = temp_output_4_0_g252277;
				float3 temp_output_297_23_g252253 = Out_AlbedoBase4_g252256;
				float3 temp_output_44_0_g252277 = temp_output_297_23_g252253;
				float3 In_AlbedoBase3_g252277 = temp_output_44_0_g252277;
				float2 In_NormalTS3_g252277 = Out_NormalTS4_g252256;
				float3 In_NormalWS3_g252277 = Out_NormalWS4_g252256;
				float4 In_Shader3_g252277 = Out_Shader4_g252256;
				float4 In_Feature3_g252277 = Out_Feature4_g252256;
				float4 In_Season3_g252277 = Out_Season4_g252256;
				float4 temp_cast_58 = (0.0).xxxx;
				half3 Visual_AlbedoBase306_g252253 = temp_output_297_23_g252253;
				float3 lerpResult307_g252253 = lerp( float3( 1,1,1 ) , Visual_AlbedoBase306_g252253 , _EmissiveColorMode);
				half3 Emissive_GlobalColor248_g252253 = half3( 1, 1, 1 );
				half3 Local_EmissiveColor88_g252253 = ( (_EmissiveColor).rgb * lerpResult307_g252253 * Emissive_GlobalColor248_g252253 );
				float temp_output_17_0_g252279 = _EmissiveMeshMode;
				float Option70_g252279 = temp_output_17_0_g252279;
				TVEModelData Data15_g252257 =(TVEModelData)Data16_g128405;
				float Out_Dummy15_g252257 = 0.0;
				float3 Out_PositionWS15_g252257 = float3( 0,0,0 );
				float3 Out_PositionWO15_g252257 = float3( 0,0,0 );
				float3 Out_PivotWS15_g252257 = float3( 0,0,0 );
				float3 Out_PivotWO15_g252257 = float3( 0,0,0 );
				float3 Out_NormalWS15_g252257 = float3( 0,0,0 );
				float3 Out_TangentWS15_g252257 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g252257 = float3( 0,0,0 );
				float3 Out_TriplanarWeights15_g252257 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g252257 = float3( 0,0,0 );
				float4 Out_CoordsData15_g252257 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g252257 = float4( 0,0,0,0 );
				float4 Out_PhaseData15_g252257 = float4( 0,0,0,0 );
				BreakModelFragData( Data15_g252257 , Out_Dummy15_g252257 , Out_PositionWS15_g252257 , Out_PositionWO15_g252257 , Out_PivotWS15_g252257 , Out_PivotWO15_g252257 , Out_NormalWS15_g252257 , Out_TangentWS15_g252257 , Out_BitangentWS15_g252257 , Out_TriplanarWeights15_g252257 , Out_ViewDirWS15_g252257 , Out_CoordsData15_g252257 , Out_VertexData15_g252257 , Out_PhaseData15_g252257 );
				half4 Model_VertexData216_g252253 = Out_VertexData15_g252257;
				float4 temp_output_3_0_g252279 = Model_VertexData216_g252253;
				float4 Channel70_g252279 = temp_output_3_0_g252279;
				float localSwitchChannel470_g252279 = SwitchChannel4( Option70_g252279 , Channel70_g252279 );
				float temp_output_431_0_g252253 = localSwitchChannel470_g252279;
				float temp_output_7_0_g252265 = _EmissiveMeshRemap.x;
				float temp_output_9_0_g252265 = ( temp_output_431_0_g252253 - temp_output_7_0_g252265 );
				float lerpResult303_g252253 = lerp( 1.0 , saturate( ( temp_output_9_0_g252265 * _EmissiveMeshRemap.z ) ) , _EmissiveMeshValue);
				half Emissive_MeshMask221_g252253 = lerpResult303_g252253;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252275) = _EmissiveMaskTex;
				SamplerState Sampler276_g252275 = sampler_Linear_Repeat;
				float localBreakTextureData456_g252275 = ( 0.0 );
				float localBuildTextureData431_g252274 = ( 0.0 );
				TVEMasksData Data431_g252274 =(TVEMasksData)(TVEMasksData)0;
				float localComputeMeshCoords444_g252274 = ( 0.0 );
				float4 temp_output_6_0_g252255 = _emissive_coord_value;
				float4 temp_output_7_0_g252255 = ( _EmissiveSampleMode + _EmissiveCoordMode + _EmissiveCoordValue );
				#ifdef TVE_DUMMY
				float4 staticSwitch14_g252255 = ( temp_output_6_0_g252255 + temp_output_7_0_g252255 );
				#else
				float4 staticSwitch14_g252255 = temp_output_6_0_g252255;
				#endif
				half4 Local_CoordValue167_g252253 = staticSwitch14_g252255;
				float4 Coords444_g252274 = Local_CoordValue167_g252253;
				float4 Model_CoordsData334_g252253 = Out_CoordsData15_g252257;
				float4 MeshCoords444_g252274 = Model_CoordsData334_g252253;
				float2 UV0444_g252274 = float2( 0,0 );
				float2 UV3444_g252274 = float2( 0,0 );
				ComputeMeshCoords( Coords444_g252274 , MeshCoords444_g252274 , UV0444_g252274 , UV3444_g252274 );
				float4 appendResult430_g252274 = (float4(UV0444_g252274 , UV3444_g252274));
				float4 In_MaskA431_g252274 = appendResult430_g252274;
				float localComputeWorldCoords315_g252274 = ( 0.0 );
				float4 Coords315_g252274 = Local_CoordValue167_g252253;
				float3 Model_PositionWO147_g252253 = Out_PositionWO15_g252257;
				float3 PositionWS315_g252274 = Model_PositionWO147_g252253;
				float2 ZY315_g252274 = float2( 0,0 );
				float2 XZ315_g252274 = float2( 0,0 );
				float2 XY315_g252274 = float2( 0,0 );
				ComputeWorldCoords( Coords315_g252274 , PositionWS315_g252274 , ZY315_g252274 , XZ315_g252274 , XY315_g252274 );
				float2 ZY402_g252274 = ZY315_g252274;
				float2 XZ403_g252274 = XZ315_g252274;
				float4 appendResult432_g252274 = (float4(ZY402_g252274 , XZ403_g252274));
				float4 In_MaskB431_g252274 = appendResult432_g252274;
				float2 XY404_g252274 = XY315_g252274;
				float localComputeStochasticCoords409_g252274 = ( 0.0 );
				float2 UV409_g252274 = ZY402_g252274;
				float2 UV1409_g252274 = float2( 0,0 );
				float2 UV2409_g252274 = float2( 0,0 );
				float2 UV3409_g252274 = float2( 0,0 );
				float3 Weights409_g252274 = float3( 0,0,0 );
				ComputeStochasticCoords( UV409_g252274 , UV1409_g252274 , UV2409_g252274 , UV3409_g252274 , Weights409_g252274 );
				float4 appendResult433_g252274 = (float4(XY404_g252274 , UV1409_g252274));
				float4 In_MaskC431_g252274 = appendResult433_g252274;
				float4 appendResult434_g252274 = (float4(UV2409_g252274 , UV3409_g252274));
				float4 In_MaskD431_g252274 = appendResult434_g252274;
				float localComputeStochasticCoords422_g252274 = ( 0.0 );
				float2 UV422_g252274 = XZ403_g252274;
				float2 UV1422_g252274 = float2( 0,0 );
				float2 UV2422_g252274 = float2( 0,0 );
				float2 UV3422_g252274 = float2( 0,0 );
				float3 Weights422_g252274 = float3( 0,0,0 );
				ComputeStochasticCoords( UV422_g252274 , UV1422_g252274 , UV2422_g252274 , UV3422_g252274 , Weights422_g252274 );
				float4 appendResult435_g252274 = (float4(UV1422_g252274 , UV2422_g252274));
				float4 In_MaskE431_g252274 = appendResult435_g252274;
				float localComputeStochasticCoords423_g252274 = ( 0.0 );
				float2 UV423_g252274 = XY404_g252274;
				float2 UV1423_g252274 = float2( 0,0 );
				float2 UV2423_g252274 = float2( 0,0 );
				float2 UV3423_g252274 = float2( 0,0 );
				float3 Weights423_g252274 = float3( 0,0,0 );
				ComputeStochasticCoords( UV423_g252274 , UV1423_g252274 , UV2423_g252274 , UV3423_g252274 , Weights423_g252274 );
				float4 appendResult436_g252274 = (float4(UV3422_g252274 , UV1423_g252274));
				float4 In_MaskF431_g252274 = appendResult436_g252274;
				float4 appendResult437_g252274 = (float4(UV2423_g252274 , UV3423_g252274));
				float4 In_MaskG431_g252274 = appendResult437_g252274;
				float4 In_MaskH431_g252274 = float4( Weights409_g252274 , 0.0 );
				float4 In_MaskI431_g252274 = float4( Weights422_g252274 , 0.0 );
				float4 In_MaskJ431_g252274 = float4( Weights423_g252274 , 0.0 );
				half3 Model_NormalWS204_g252253 = Out_NormalWS15_g252257;
				float3 temp_output_449_0_g252274 = Model_NormalWS204_g252253;
				float4 In_MaskK431_g252274 = float4( temp_output_449_0_g252274 , 0.0 );
				float3 temp_output_450_0_g252274 = float3( 0,0,0 );
				float4 In_MaskL431_g252274 = float4( temp_output_450_0_g252274 , 0.0 );
				float3 temp_output_451_0_g252274 = float3( 0,0,0 );
				float4 In_MaskM431_g252274 = float4( temp_output_451_0_g252274 , 0.0 );
				float3 temp_output_445_0_g252274 = float3( 0,0,0 );
				float4 In_MaskN431_g252274 = float4( temp_output_445_0_g252274 , 0.0 );
				BuildTextureData( Data431_g252274 , In_MaskA431_g252274 , In_MaskB431_g252274 , In_MaskC431_g252274 , In_MaskD431_g252274 , In_MaskE431_g252274 , In_MaskF431_g252274 , In_MaskG431_g252274 , In_MaskH431_g252274 , In_MaskI431_g252274 , In_MaskJ431_g252274 , In_MaskK431_g252274 , In_MaskL431_g252274 , In_MaskM431_g252274 , In_MaskN431_g252274 );
				TVEMasksData Data456_g252275 =(TVEMasksData)Data431_g252274;
				float4 Out_MaskA456_g252275 = float4( 0,0,0,0 );
				float4 Out_MaskB456_g252275 = float4( 0,0,0,0 );
				float4 Out_MaskC456_g252275 = float4( 0,0,0,0 );
				float4 Out_MaskD456_g252275 = float4( 0,0,0,0 );
				float4 Out_MaskE456_g252275 = float4( 0,0,0,0 );
				float4 Out_MaskF456_g252275 = float4( 0,0,0,0 );
				float4 Out_MaskG456_g252275 = float4( 0,0,0,0 );
				float4 Out_MaskH456_g252275 = float4( 0,0,0,0 );
				float4 Out_MaskI456_g252275 = float4( 0,0,0,0 );
				float4 Out_MaskJ456_g252275 = float4( 0,0,0,0 );
				float4 Out_MaskK456_g252275 = float4( 0,0,0,0 );
				float4 Out_MaskL456_g252275 = float4( 0,0,0,0 );
				float4 Out_MaskM456_g252275 = float4( 0,0,0,0 );
				float4 Out_MaskN456_g252275 = float4( 0,0,0,0 );
				BreakTextureData( Data456_g252275 , Out_MaskA456_g252275 , Out_MaskB456_g252275 , Out_MaskC456_g252275 , Out_MaskD456_g252275 , Out_MaskE456_g252275 , Out_MaskF456_g252275 , Out_MaskG456_g252275 , Out_MaskH456_g252275 , Out_MaskI456_g252275 , Out_MaskJ456_g252275 , Out_MaskK456_g252275 , Out_MaskL456_g252275 , Out_MaskM456_g252275 , Out_MaskN456_g252275 );
				half2 UV276_g252275 = (Out_MaskA456_g252275).xy;
				float temp_output_504_0_g252275 = 0.0;
				half Bias276_g252275 = temp_output_504_0_g252275;
				half2 Normal276_g252275 = float2( 0,0 );
				half4 localSampleCoord276_g252275 = SampleCoord( Texture276_g252275 , Sampler276_g252275 , UV276_g252275 , Bias276_g252275 , Normal276_g252275 );
				float4 temp_output_429_277_g252253 = localSampleCoord276_g252275;
				UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252275) = _EmissiveMaskTex;
				SamplerState Sampler502_g252275 = sampler_Linear_Repeat;
				half2 UV502_g252275 = (Out_MaskA456_g252275).zw;
				half Bias502_g252275 = temp_output_504_0_g252275;
				half2 Normal502_g252275 = float2( 0,0 );
				half4 localSampleCoord502_g252275 = SampleCoord( Texture502_g252275 , Sampler502_g252275 , UV502_g252275 , Bias502_g252275 , Normal502_g252275 );
				float4 temp_output_429_278_g252253 = localSampleCoord502_g252275;
				#if defined( TVE_EMISSIVE_SAMPLE_MAIN_UV )
				float4 staticSwitch176_g252253 = temp_output_429_277_g252253;
				#elif defined( TVE_EMISSIVE_SAMPLE_EXTRA_UV )
				float4 staticSwitch176_g252253 = temp_output_429_278_g252253;
				#else
				float4 staticSwitch176_g252253 = temp_output_429_277_g252253;
				#endif
				half4 Emissive_MaskTex201_g252253 = staticSwitch176_g252253;
				float temp_output_104_0_g252253 = (Emissive_MaskTex201_g252253).x;
				float temp_output_7_0_g252266 = _EmissiveMaskRemap.x;
				float temp_output_9_0_g252266 = ( temp_output_104_0_g252253 - temp_output_7_0_g252266 );
				float lerpResult302_g252253 = lerp( 1.0 , saturate( ( temp_output_9_0_g252266 * _EmissiveMaskRemap.z ) ) , _EmissiveMaskValue);
				half Emissive_TexMask103_g252253 = lerpResult302_g252253;
				half Emissive_NoiseMask380_g252253 = 1.0;
				float3 temp_output_9_0_g252281 = Emissive_GlobalColor248_g252253;
				half3 linRGB23_g252281 = temp_output_9_0_g252281;
				half3 localLinearToGammaFloatFast23_g252281 = LinearToGammaFloatFast( linRGB23_g252281 );
				#ifdef UNITY_COLORSPACE_GAMMA
				float3 staticSwitch1_g252281 = temp_output_9_0_g252281;
				#else
				float3 staticSwitch1_g252281 = localLinearToGammaFloatFast23_g252281;
				#endif
				half Local_GlobalMask332_g252253 = saturate( length( staticSwitch1_g252281 ) );
				float temp_output_7_0_g252267 = _EmissiveBlendRemap.x;
				float temp_output_9_0_g252267 = ( ( _EmissiveIntensityValue * Emissive_MeshMask221_g252253 * Emissive_TexMask103_g252253 * Emissive_NoiseMask380_g252253 * Local_GlobalMask332_g252253 ) - temp_output_7_0_g252267 );
				float temp_output_326_0_g252253 = saturate( ( temp_output_9_0_g252267 * _EmissiveBlendRemap.z ) );
				half Local_EmissiveMask278_g252253 = temp_output_326_0_g252253;
				half4 Visual_Emissive255_g252253 = Out_Emissive4_g252256;
				half3 Local_EmissiveBlend260_g252253 = ( ( Local_EmissiveColor88_g252253 * Local_EmissiveMask278_g252253 ) * (Visual_Emissive255_g252253).xyz );
				float3 temp_output_3_0_g252276 = Local_EmissiveBlend260_g252253;
				float temp_output_15_0_g252276 = _emissive_power_value;
				float3 temp_output_23_0_g252276 = ( temp_output_3_0_g252276 * temp_output_15_0_g252276 );
				float4 appendResult295_g252253 = (float4(temp_output_23_0_g252276 , 1.0));
				#ifdef TVE_EMISSIVE
				float4 staticSwitch129_g252253 = appendResult295_g252253;
				#else
				float4 staticSwitch129_g252253 = temp_cast_58;
				#endif
				half4 Final_Emissive184_g252253 = staticSwitch129_g252253;
				float4 In_Emissive3_g252277 = Final_Emissive184_g252253;
				float temp_output_12_0_g252277 = Out_Grayscale4_g252256;
				float In_Grayscale3_g252277 = temp_output_12_0_g252277;
				float temp_output_16_0_g252277 = Out_Luminosity4_g252256;
				float In_Luminosity3_g252277 = temp_output_16_0_g252277;
				float temp_output_297_11_g252253 = Out_MultiMask4_g252256;
				float In_MultiMask3_g252277 = temp_output_297_11_g252253;
				float In_AlphaClip3_g252277 = Out_AlphaClip4_g252256;
				float In_AlphaFade3_g252277 = Out_AlphaFade4_g252256;
				float3 In_Translucency3_g252277 = Out_Translucency4_g252256;
				float In_Transmission3_g252277 = Out_Transmission4_g252256;
				float In_Thickness3_g252277 = Out_Thickness4_g252256;
				float In_Diffusion3_g252277 = Out_Diffusion4_g252256;
				float In_Depth3_g252277 = Out_Depth4_g252256;
				BuildVisualData( Data3_g252277 , In_Dummy3_g252277 , In_Albedo3_g252277 , In_AlbedoBase3_g252277 , In_NormalTS3_g252277 , In_NormalWS3_g252277 , In_Shader3_g252277 , In_Feature3_g252277 , In_Season3_g252277 , In_Emissive3_g252277 , In_Grayscale3_g252277 , In_Luminosity3_g252277 , In_MultiMask3_g252277 , In_AlphaClip3_g252277 , In_AlphaFade3_g252277 , In_Translucency3_g252277 , In_Transmission3_g252277 , In_Thickness3_g252277 , In_Diffusion3_g252277 , In_Depth3_g252277 );
				TVEVisualData Data4_g252285 =(TVEVisualData)Data3_g252277;
				float Out_Dummy4_g252285 = 0.0;
				float3 Out_Albedo4_g252285 = float3( 0,0,0 );
				float3 Out_AlbedoBase4_g252285 = float3( 0,0,0 );
				float2 Out_NormalTS4_g252285 = float2( 0,0 );
				float3 Out_NormalWS4_g252285 = float3( 0,0,0 );
				float4 Out_Shader4_g252285 = float4( 0,0,0,0 );
				float4 Out_Feature4_g252285 = float4( 0,0,0,0 );
				float4 Out_Season4_g252285 = float4( 0,0,0,0 );
				float4 Out_Emissive4_g252285 = float4( 0,0,0,0 );
				float Out_MultiMask4_g252285 = 0.0;
				float Out_Grayscale4_g252285 = 0.0;
				float Out_Luminosity4_g252285 = 0.0;
				float Out_AlphaClip4_g252285 = 0.0;
				float Out_AlphaFade4_g252285 = 0.0;
				float3 Out_Translucency4_g252285 = float3( 0,0,0 );
				float Out_Transmission4_g252285 = 0.0;
				float Out_Thickness4_g252285 = 0.0;
				float Out_Diffusion4_g252285 = 0.0;
				float Out_Depth4_g252285 = 0.0;
				BreakVisualData( Data4_g252285 , Out_Dummy4_g252285 , Out_Albedo4_g252285 , Out_AlbedoBase4_g252285 , Out_NormalTS4_g252285 , Out_NormalWS4_g252285 , Out_Shader4_g252285 , Out_Feature4_g252285 , Out_Season4_g252285 , Out_Emissive4_g252285 , Out_MultiMask4_g252285 , Out_Grayscale4_g252285 , Out_Luminosity4_g252285 , Out_AlphaClip4_g252285 , Out_AlphaFade4_g252285 , Out_Translucency4_g252285 , Out_Transmission4_g252285 , Out_Thickness4_g252285 , Out_Diffusion4_g252285 , Out_Depth4_g252285 );
				float4 appendResult92_g252284 = (float4(Out_Albedo4_g252285 , 1.0));
				
				half2 NormalTS154_g252284 = Out_NormalTS4_g252285;
				float3 appendResult123_g252284 = (float3(NormalTS154_g252284 , 1.0));
				float3 temp_output_13_0_g252292 = appendResult123_g252284;
				float3 temp_output_33_0_g252292 = ( temp_output_13_0_g252292 * _render_normal );
				float3 switchResult12_g252292 = (((ase_vface>0)?(temp_output_13_0_g252292):(temp_output_33_0_g252292)));
				float4 vertexToFrag140_g252284 = i.ase_texcoord9;
				float3 objToWorldDir58_g252291 = mul( unity_ObjectToWorld, float4( vertexToFrag140_g252284.xyz, 0.0 ) ).xyz;
				float ase_tangentSign = i.ase_texcoord.w;
				float3 vertexToFrag139_g252284 = i.ase_texcoord10.xyz;
				float3 objToWorldDir60_g252291 = mul( unity_ObjectToWorld, float4( vertexToFrag139_g252284, 0.0 ) ).xyz;
				float4 screenPos = i.ase_texcoord11;
				float ase_depthRaw = screenPos.z / screenPos.w;
				float4 appendResult94_g252284 = (float4((mul( switchResult12_g252292, float3x3( objToWorldDir58_g252291, ( ase_tangentSign * cross( objToWorldDir60_g252291 , objToWorldDir58_g252291 ) ), objToWorldDir60_g252291 ) )*0.5 + 0.5) , ase_depthRaw));
				
				float4 break98_g252284 = Out_Shader4_g252285;
				float4 appendResult99_g252284 = (float4(break98_g252284.x , break98_g252284.y , Out_MultiMask4_g252285 , break98_g252284.w));
				
				float4 appendResult118_g252284 = (float4(i.ase_color.r , i.ase_color.g , Out_MultiMask4_g252285 , break98_g252284.w));
				
				float localIfModelData25_g252282 = ( 0.0 );
				TVEModelData Data25_g252282 = (TVEModelData)0;
				TVEModelData Data16_g128410 =(TVEModelData)0;
				half Dummy207_g76826 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode );
				float temp_output_14_0_g128410 = Dummy207_g76826;
				float In_Dummy16_g128410 = temp_output_14_0_g128410;
				float3 PositionOS131_g76826 = i.ase_texcoord12.xyz;
				float3 temp_output_4_0_g128410 = PositionOS131_g76826;
				float3 In_PositionOS16_g128410 = temp_output_4_0_g128410;
				float3 In_PositionWS16_g128410 = PositionWS122_g76826;
				float3 In_PositionWO16_g128410 = PositionWO132_g76826;
				float3 In_PositionRawOS16_g128410 = PositionOS131_g76826;
				float3 _Vector0 = float3(0,0,0);
				float3 appendResult60_g128353 = (float3(i.ase_texcoord13.x , i.ase_texcoord13.z , i.ase_texcoord13.y));
				float3 break233_g76826 = PositionOS131_g76826;
				float3 appendResult234_g76826 = (float3(break233_g76826.x , 0.0 , break233_g76826.z));
				float3 break413_g76826 = PositionOS131_g76826;
				float3 appendResult414_g76826 = (float3(break413_g76826.x , break413_g76826.y , 0.0));
				#ifdef TVE_COORD_ZUP
				float3 staticSwitch65_g128401 = appendResult414_g76826;
				#else
				float3 staticSwitch65_g128401 = appendResult234_g76826;
				#endif
				#if defined( TVE_PIVOT_SINGLE )
				float3 staticSwitch229_g76826 = _Vector0;
				#elif defined( TVE_PIVOT_BAKED )
				float3 staticSwitch229_g76826 = appendResult60_g128353;
				#elif defined( TVE_PIVOT_PROC )
				float3 staticSwitch229_g76826 = staticSwitch65_g128401;
				#else
				float3 staticSwitch229_g76826 = _Vector0;
				#endif
				float3 PivotOS149_g76826 = staticSwitch229_g76826;
				float3 In_PivotOS16_g128410 = PivotOS149_g76826;
				float3 In_PivotWS16_g128410 = PivotWS121_g76826;
				float3 In_PivotWO16_g128410 = PivotWO133_g76826;
				half3 NormalOS134_g76826 = i.ase_normal;
				float3 temp_output_21_0_g128410 = NormalOS134_g76826;
				float3 In_NormalOS16_g128410 = temp_output_21_0_g128410;
				float3 In_NormalWS16_g128410 = NormalWS95_g76826;
				float3 In_NormalRawOS16_g128410 = NormalOS134_g76826;
				half4 TangentlOS153_g76826 = i.ase_tangent;
				float4 temp_output_6_0_g128410 = TangentlOS153_g76826;
				float4 In_TangentOS16_g128410 = temp_output_6_0_g128410;
				float3 In_TangentWS16_g128410 = TangentWS136_g76826;
				float3 In_BitangentWS16_g128410 = BiangentWS421_g76826;
				float3 In_ViewDirWS16_g128410 = ViewDirWS169_g76826;
				float4 In_CoordsData16_g128410 = CoordsData398_g76826;
				float4 In_VertexData16_g128410 = VertexMasks171_g76826;
				#ifdef TVE_COORD_ZUP
				float staticSwitch65_g128416 = (PositionOS131_g76826).z;
				#else
				float staticSwitch65_g128416 = (PositionOS131_g76826).y;
				#endif
				half Object_HeightValue267_g76826 = _ObjectHeightValue;
				half Bounds_HeightMask274_g76826 = saturate( ( staticSwitch65_g128416 / Object_HeightValue267_g76826 ) );
				half3 Position387_g76826 = PositionOS131_g76826;
				half Height387_g76826 = Object_HeightValue267_g76826;
				half Object_RadiusValue268_g76826 = _ObjectRadiusValue;
				half Radius387_g76826 = Object_RadiusValue268_g76826;
				half localCapsuleMaskYUp387_g76826 = CapsuleMaskYUp( Position387_g76826 , Height387_g76826 , Radius387_g76826 );
				half3 Position408_g76826 = PositionOS131_g76826;
				half Height408_g76826 = Object_HeightValue267_g76826;
				half Radius408_g76826 = Object_RadiusValue268_g76826;
				half localCapsuleMaskZUp408_g76826 = CapsuleMaskZUp( Position408_g76826 , Height408_g76826 , Radius408_g76826 );
				#ifdef TVE_COORD_ZUP
				float staticSwitch65_g128423 = saturate( localCapsuleMaskZUp408_g76826 );
				#else
				float staticSwitch65_g128423 = saturate( localCapsuleMaskYUp387_g76826 );
				#endif
				half Bounds_SphereMask282_g76826 = staticSwitch65_g128423;
				float4 appendResult253_g76826 = (float4(Bounds_HeightMask274_g76826 , Bounds_SphereMask282_g76826 , 1.0 , 1.0));
				half4 MasksData254_g76826 = appendResult253_g76826;
				float4 In_MasksData16_g128410 = MasksData254_g76826;
				float4 In_PhaseData16_g128410 = Phase_Data176_g76826;
				float4 In_TransformData16_g128410 = half4( 0, 0, 0, 1 );
				float4 In_RotationData16_g128410 = float4( 0,0,0,0 );
				float4 In_InterpolatorA16_g128410 = float4( 0,0,0,0 );
				BuildModelVertData( Data16_g128410 , In_Dummy16_g128410 , In_PositionOS16_g128410 , In_PositionWS16_g128410 , In_PositionWO16_g128410 , In_PositionRawOS16_g128410 , In_PivotOS16_g128410 , In_PivotWS16_g128410 , In_PivotWO16_g128410 , In_NormalOS16_g128410 , In_NormalWS16_g128410 , In_NormalRawOS16_g128410 , In_TangentOS16_g128410 , In_TangentWS16_g128410 , In_BitangentWS16_g128410 , In_ViewDirWS16_g128410 , In_CoordsData16_g128410 , In_VertexData16_g128410 , In_MasksData16_g128410 , In_PhaseData16_g128410 , In_TransformData16_g128410 , In_RotationData16_g128410 , In_InterpolatorA16_g128410 );
				TVEModelData DataA25_g252282 = Data16_g128410;
				TVEModelData Data15_g252243 =(TVEModelData)Data16_g128410;
				float Out_Dummy15_g252243 = 0.0;
				float3 Out_PositionOS15_g252243 = float3( 0,0,0 );
				float3 Out_PositionWS15_g252243 = float3( 0,0,0 );
				float3 Out_PositionWO15_g252243 = float3( 0,0,0 );
				float3 Out_PositionRawOS15_g252243 = float3( 0,0,0 );
				float3 Out_PivotOS15_g252243 = float3( 0,0,0 );
				float3 Out_PivotWS15_g252243 = float3( 0,0,0 );
				float3 Out_PivotWO15_g252243 = float3( 0,0,0 );
				float3 Out_NormalOS15_g252243 = float3( 0,0,0 );
				float3 Out_NormalWS15_g252243 = float3( 0,0,0 );
				float3 Out_NormalRawOS15_g252243 = float3( 0,0,0 );
				float4 Out_TangentOS15_g252243 = float4( 0,0,0,0 );
				float3 Out_TangentWS15_g252243 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g252243 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g252243 = float3( 0,0,0 );
				float4 Out_CoordsData15_g252243 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g252243 = float4( 0,0,0,0 );
				float4 Out_MasksData15_g252243 = float4( 0,0,0,0 );
				float4 Out_PhaseData15_g252243 = float4( 0,0,0,0 );
				float4 Out_TransformData15_g252243 = float4( 0,0,0,0 );
				float4 Out_RotationData15_g252243 = float4( 0,0,0,0 );
				float4 Out_InterpolatorA15_g252243 = float4( 0,0,0,0 );
				BreakModelVertData( Data15_g252243 , Out_Dummy15_g252243 , Out_PositionOS15_g252243 , Out_PositionWS15_g252243 , Out_PositionWO15_g252243 , Out_PositionRawOS15_g252243 , Out_PivotOS15_g252243 , Out_PivotWS15_g252243 , Out_PivotWO15_g252243 , Out_NormalOS15_g252243 , Out_NormalWS15_g252243 , Out_NormalRawOS15_g252243 , Out_TangentOS15_g252243 , Out_TangentWS15_g252243 , Out_BitangentWS15_g252243 , Out_ViewDirWS15_g252243 , Out_CoordsData15_g252243 , Out_VertexData15_g252243 , Out_MasksData15_g252243 , Out_PhaseData15_g252243 , Out_TransformData15_g252243 , Out_RotationData15_g252243 , Out_InterpolatorA15_g252243 );
				TVEModelData Data16_g252245 =(TVEModelData)Data15_g252243;
				half Dummy1823_g252242 = ( _FlattenCategory + _FlattenEnd + _FlattenBakeMode );
				float temp_output_14_0_g252245 = Dummy1823_g252242;
				float In_Dummy16_g252245 = temp_output_14_0_g252245;
				float3 temp_output_4_0_g252245 = Out_PositionOS15_g252243;
				float3 In_PositionOS16_g252245 = temp_output_4_0_g252245;
				float3 In_PositionWS16_g252245 = Out_PositionWS15_g252243;
				float3 In_PositionWO16_g252245 = Out_PositionWO15_g252243;
				float3 temp_output_1810_26_g252242 = Out_PositionRawOS15_g252243;
				float3 In_PositionRawOS16_g252245 = temp_output_1810_26_g252242;
				float3 In_PivotOS16_g252245 = Out_PivotOS15_g252243;
				float3 In_PivotWS16_g252245 = Out_PivotWS15_g252243;
				float3 In_PivotWO16_g252245 = Out_PivotWO15_g252243;
				half3 Model_NormalOS1829_g252242 = Out_NormalOS15_g252243;
				#ifdef TVE_COORD_ZUP
				float3 staticSwitch65_g252244 = half3( 0, 0, 1 );
				#else
				float3 staticSwitch65_g252244 = half3( 0, 1, 0 );
				#endif
				float3 lerpResult1820_g252242 = lerp( Model_NormalOS1829_g252242 , staticSwitch65_g252244 , _FlattenIntensityValue);
				float3 Model_PositionBaseOS1837_g252242 = temp_output_1810_26_g252242;
				float3 normalizeResult1816_g252242 = ASESafeNormalize( ( Model_PositionBaseOS1837_g252242 + _FlattenSphereOffsetValue ) );
				float3 lerpResult1813_g252242 = lerp( lerpResult1820_g252242 , normalizeResult1816_g252242 , _FlattenSphereValue);
				float temp_output_17_0_g252252 = _FlattenMeshMode;
				float Option70_g252252 = temp_output_17_0_g252252;
				float4 temp_output_1810_29_g252242 = Out_VertexData15_g252243;
				half4 Model_VertexData1826_g252242 = temp_output_1810_29_g252242;
				float4 temp_output_3_0_g252252 = Model_VertexData1826_g252242;
				float4 Channel70_g252252 = temp_output_3_0_g252252;
				float localSwitchChannel470_g252252 = SwitchChannel4( Option70_g252252 , Channel70_g252252 );
				float clampResult17_g252246 = clamp( localSwitchChannel470_g252252 , 0.0001 , 0.9999 );
				float temp_output_7_0_g252247 = _FlattenMeshRemap.x;
				float temp_output_9_0_g252247 = ( clampResult17_g252246 - temp_output_7_0_g252247 );
				float lerpResult1841_g252242 = lerp( 1.0 , saturate( ( temp_output_9_0_g252247 * _FlattenMeshRemap.z ) ) , _FlattenMeshValue);
				half Normal_MeskMask1847_g252242 = lerpResult1841_g252242;
				half Normal_Mask1851_g252242 = Normal_MeskMask1847_g252242;
				float3 lerpResult1856_g252242 = lerp( Model_NormalOS1829_g252242 , lerpResult1813_g252242 , Normal_Mask1851_g252242);
				#ifdef TVE_FLATTEN
				float3 staticSwitch1857_g252242 = lerpResult1856_g252242;
				#else
				float3 staticSwitch1857_g252242 = Model_NormalOS1829_g252242;
				#endif
				half3 Final_NormalOS1853_g252242 = staticSwitch1857_g252242;
				float3 temp_output_21_0_g252245 = Final_NormalOS1853_g252242;
				float3 In_NormalOS16_g252245 = temp_output_21_0_g252245;
				float3 In_NormalWS16_g252245 = Out_NormalWS15_g252243;
				float3 In_NormalRawOS16_g252245 = Out_NormalRawOS15_g252243;
				float4 temp_output_6_0_g252245 = Out_TangentOS15_g252243;
				float4 In_TangentOS16_g252245 = temp_output_6_0_g252245;
				float3 In_TangentWS16_g252245 = Out_TangentWS15_g252243;
				float3 In_BitangentWS16_g252245 = Out_BitangentWS15_g252243;
				float3 In_ViewDirWS16_g252245 = Out_ViewDirWS15_g252243;
				float4 In_CoordsData16_g252245 = Out_CoordsData15_g252243;
				float4 In_VertexData16_g252245 = temp_output_1810_29_g252242;
				float4 In_MasksData16_g252245 = Out_MasksData15_g252243;
				float4 In_PhaseData16_g252245 = Out_PhaseData15_g252243;
				float4 In_TransformData16_g252245 = Out_TransformData15_g252243;
				float4 In_RotationData16_g252245 = Out_RotationData15_g252243;
				float4 In_InterpolatorA16_g252245 = Out_InterpolatorA15_g252243;
				BuildModelVertData( Data16_g252245 , In_Dummy16_g252245 , In_PositionOS16_g252245 , In_PositionWS16_g252245 , In_PositionWO16_g252245 , In_PositionRawOS16_g252245 , In_PivotOS16_g252245 , In_PivotWS16_g252245 , In_PivotWO16_g252245 , In_NormalOS16_g252245 , In_NormalWS16_g252245 , In_NormalRawOS16_g252245 , In_TangentOS16_g252245 , In_TangentWS16_g252245 , In_BitangentWS16_g252245 , In_ViewDirWS16_g252245 , In_CoordsData16_g252245 , In_VertexData16_g252245 , In_MasksData16_g252245 , In_PhaseData16_g252245 , In_TransformData16_g252245 , In_RotationData16_g252245 , In_InterpolatorA16_g252245 );
				TVEModelData DataB25_g252282 = Data16_g252245;
				float Alpha25_g252282 = _FlattenBakeMode;
				{
				if (Alpha25_g252282 < 0.5 )
				{
				Data25_g252282 = DataA25_g252282;
				}
				else
				{
				Data25_g252282 = DataB25_g252282;
				}
				}
				TVEModelData Data15_g252289 =(TVEModelData)Data25_g252282;
				float Out_Dummy15_g252289 = 0.0;
				float3 Out_PositionOS15_g252289 = float3( 0,0,0 );
				float3 Out_PositionWS15_g252289 = float3( 0,0,0 );
				float3 Out_PositionWO15_g252289 = float3( 0,0,0 );
				float3 Out_PositionRawOS15_g252289 = float3( 0,0,0 );
				float3 Out_PivotOS15_g252289 = float3( 0,0,0 );
				float3 Out_PivotWS15_g252289 = float3( 0,0,0 );
				float3 Out_PivotWO15_g252289 = float3( 0,0,0 );
				float3 Out_NormalOS15_g252289 = float3( 0,0,0 );
				float3 Out_NormalWS15_g252289 = float3( 0,0,0 );
				float3 Out_NormalRawOS15_g252289 = float3( 0,0,0 );
				float4 Out_TangentOS15_g252289 = float4( 0,0,0,0 );
				float3 Out_TangentWS15_g252289 = float3( 0,0,0 );
				float3 Out_BitangentWS15_g252289 = float3( 0,0,0 );
				float3 Out_ViewDirWS15_g252289 = float3( 0,0,0 );
				float4 Out_CoordsData15_g252289 = float4( 0,0,0,0 );
				float4 Out_VertexData15_g252289 = float4( 0,0,0,0 );
				float4 Out_MasksData15_g252289 = float4( 0,0,0,0 );
				float4 Out_PhaseData15_g252289 = float4( 0,0,0,0 );
				float4 Out_TransformData15_g252289 = float4( 0,0,0,0 );
				float4 Out_RotationData15_g252289 = float4( 0,0,0,0 );
				float4 Out_InterpolatorA15_g252289 = float4( 0,0,0,0 );
				BreakModelVertData( Data15_g252289 , Out_Dummy15_g252289 , Out_PositionOS15_g252289 , Out_PositionWS15_g252289 , Out_PositionWO15_g252289 , Out_PositionRawOS15_g252289 , Out_PivotOS15_g252289 , Out_PivotWS15_g252289 , Out_PivotWO15_g252289 , Out_NormalOS15_g252289 , Out_NormalWS15_g252289 , Out_NormalRawOS15_g252289 , Out_TangentOS15_g252289 , Out_TangentWS15_g252289 , Out_BitangentWS15_g252289 , Out_ViewDirWS15_g252289 , Out_CoordsData15_g252289 , Out_VertexData15_g252289 , Out_MasksData15_g252289 , Out_PhaseData15_g252289 , Out_TransformData15_g252289 , Out_RotationData15_g252289 , Out_InterpolatorA15_g252289 );
				
				float localBreakData4_g252293 = ( 0.0 );
				float localBuildMasksData3_g252261 = ( 0.0 );
				TVEMasksData Data3_g252261 = (TVEMasksData)0;
				half Feature_Intensity417_g252253 = _EmissiveIntensityValue;
				float ifLocalVar18_g252259 = 0;
				if( Feature_Intensity417_g252253 <= 0.0 )
				ifLocalVar18_g252259 = 0.0;
				else
				ifLocalVar18_g252259 = 1.0;
				half Feature_Element414_g252253 = _EmissiveElementMode;
				float ifLocalVar18_g252258 = 0;
				if( Feature_Element414_g252253 <= 0.0 )
				ifLocalVar18_g252258 = 0.0;
				else
				ifLocalVar18_g252258 = 1.0;
				float4 appendResult422_g252253 = (float4(ifLocalVar18_g252259 , 0.0 , 0.0 , ifLocalVar18_g252258));
				float4 In_MaskA3_g252261 = appendResult422_g252253;
				float4 appendResult364_g252253 = (float4(Local_EmissiveMask278_g252253 , 0.0 , (Visual_Emissive255_g252253).w , ( Emissive_MeshMask221_g252253 * Emissive_TexMask103_g252253 )));
				float4 temp_cast_69 = (0.0).xxxx;
				float4 temp_cast_70 = (0.0).xxxx;
				float4 ifLocalVar18_g252260 = 0;
				if( Feature_Intensity417_g252253 <= 0.0 )
				ifLocalVar18_g252260 = temp_cast_70;
				else
				ifLocalVar18_g252260 = appendResult364_g252253;
				float4 In_MaskB3_g252261 = ifLocalVar18_g252260;
				float3 temp_cast_71 = (0.0).xxx;
				float3 temp_cast_72 = (0.0).xxx;
				float3 ifLocalVar18_g252262 = 0;
				if( Feature_Intensity417_g252253 <= 0.0 )
				ifLocalVar18_g252262 = temp_cast_72;
				else
				ifLocalVar18_g252262 = Local_EmissiveColor88_g252253;
				float4 In_MaskC3_g252261 = float4( ifLocalVar18_g252262 , 0.0 );
				float4 temp_cast_74 = (0.0).xxxx;
				float4 In_MaskD3_g252261 = temp_cast_74;
				float4 temp_cast_75 = (0.0).xxxx;
				float4 In_MaskE3_g252261 = temp_cast_75;
				float4 temp_cast_76 = (0.0).xxxx;
				float4 In_MaskF3_g252261 = temp_cast_76;
				float4 temp_cast_77 = (0.0).xxxx;
				float4 In_MaskG3_g252261 = temp_cast_77;
				float4 temp_cast_78 = (0.0).xxxx;
				float4 In_MaskH3_g252261 = temp_cast_78;
				float4 temp_cast_79 = (0.0).xxxx;
				float4 In_MaskI3_g252261 = temp_cast_79;
				float4 temp_cast_80 = (0.0).xxxx;
				float4 In_MaskJ3_g252261 = temp_cast_80;
				float4 temp_cast_81 = (0.0).xxxx;
				float4 In_MaskK3_g252261 = temp_cast_81;
				float4 temp_cast_82 = (0.0).xxxx;
				float4 In_MaskL3_g252261 = temp_cast_82;
				{
				Data3_g252261.MaskA = In_MaskA3_g252261;
				Data3_g252261.MaskB = In_MaskB3_g252261;
				Data3_g252261.MaskC = In_MaskC3_g252261;
				Data3_g252261.MaskD = In_MaskD3_g252261;
				Data3_g252261.MaskE = In_MaskE3_g252261;
				Data3_g252261.MaskF = In_MaskF3_g252261;
				Data3_g252261.MaskG = In_MaskG3_g252261;
				Data3_g252261.MaskH = In_MaskH3_g252261;
				Data3_g252261.MaskI = In_MaskI3_g252261;
				Data3_g252261.MaskJ= In_MaskJ3_g252261;
				Data3_g252261.MaskK= In_MaskK3_g252261;
				Data3_g252261.MaskL = In_MaskL3_g252261;
				}
				TVEMasksData Data4_g252293 = Data3_g252261;
				float4 Out_MaskA4_g252293 = float4( 0,0,0,0 );
				float4 Out_MaskB4_g252293 = float4( 0,0,0,0 );
				float4 Out_MaskC4_g252293 = float4( 0,0,0,0 );
				float4 Out_MaskD4_g252293 = float4( 0,0,0,0 );
				float4 Out_MaskE4_g252293 = float4( 0,0,0,0 );
				float4 Out_MaskF4_g252293 = float4( 0,0,0,0 );
				float4 Out_MaskG4_g252293 = float4( 0,0,0,0 );
				float4 Out_MaskH4_g252293 = float4( 0,0,0,0 );
				{
				Out_MaskA4_g252293 = Data4_g252293.MaskA;
				Out_MaskB4_g252293 = Data4_g252293.MaskB;
				Out_MaskC4_g252293 = Data4_g252293.MaskC;
				Out_MaskD4_g252293 = Data4_g252293.MaskD;
				Out_MaskE4_g252293 = Data4_g252293.MaskE;
				Out_MaskF4_g252293 = Data4_g252293.MaskF;
				Out_MaskG4_g252293 = Data4_g252293.MaskG;
				Out_MaskH4_g252293 = Data4_g252293.MaskH;
				}
				half EmissiveMask150_g252284 = (Out_MaskB4_g252293).w;
				half BaseMask152_g252284 = break98_g252284.z;
				float localBreakData4_g252294 = ( 0.0 );
				float localBuildMasksData3_g251375 = ( 0.0 );
				TVEMasksData Data3_g251375 = (TVEMasksData)0;
				half Feature_Intensity1204_g251357 = _SecondIntensityValue;
				float ifLocalVar18_g251376 = 0;
				if( Feature_Intensity1204_g251357 <= 0.0 )
				ifLocalVar18_g251376 = 0.0;
				else
				ifLocalVar18_g251376 = 1.0;
				half Feature_Element1203_g251357 = _SecondElementMode;
				float ifLocalVar18_g251377 = 0;
				if( Feature_Element1203_g251357 <= 0.0 )
				ifLocalVar18_g251377 = 0.0;
				else
				ifLocalVar18_g251377 = 1.0;
				float4 appendResult1090_g251357 = (float4(ifLocalVar18_g251376 , 0.0 , 0.0 , ifLocalVar18_g251377));
				float4 In_MaskA3_g251375 = appendResult1090_g251357;
				half Blend_BakeMask1132_g251357 = ( Blend_TexMask429_g251357 * Blend_BaseMask1077_g251357 * Blend_LumaMask1033_g251357 * Blend_VertMask918_g251357 );
				float4 appendResult1126_g251357 = (float4(Blend_Mask412_g251357 , 0.0 , 0.0 , Blend_BakeMask1132_g251357));
				float4 temp_cast_83 = (0.0).xxxx;
				float4 temp_cast_84 = (0.0).xxxx;
				float4 ifLocalVar18_g251378 = 0;
				if( Feature_Intensity1204_g251357 <= 0.0 )
				ifLocalVar18_g251378 = temp_cast_84;
				else
				ifLocalVar18_g251378 = appendResult1126_g251357;
				float4 In_MaskB3_g251375 = ifLocalVar18_g251378;
				float4 temp_cast_85 = (0.0).xxxx;
				float4 In_MaskC3_g251375 = temp_cast_85;
				float4 temp_cast_86 = (0.0).xxxx;
				float4 In_MaskD3_g251375 = temp_cast_86;
				float4 temp_cast_87 = (0.0).xxxx;
				float4 In_MaskE3_g251375 = temp_cast_87;
				float4 temp_cast_88 = (0.0).xxxx;
				float4 In_MaskF3_g251375 = temp_cast_88;
				float4 temp_cast_89 = (0.0).xxxx;
				float4 In_MaskG3_g251375 = temp_cast_89;
				float4 temp_cast_90 = (0.0).xxxx;
				float4 In_MaskH3_g251375 = temp_cast_90;
				float4 temp_cast_91 = (0.0).xxxx;
				float4 In_MaskI3_g251375 = temp_cast_91;
				float4 temp_cast_92 = (0.0).xxxx;
				float4 In_MaskJ3_g251375 = temp_cast_92;
				float4 temp_cast_93 = (0.0).xxxx;
				float4 In_MaskK3_g251375 = temp_cast_93;
				float4 temp_cast_94 = (0.0).xxxx;
				float4 In_MaskL3_g251375 = temp_cast_94;
				{
				Data3_g251375.MaskA = In_MaskA3_g251375;
				Data3_g251375.MaskB = In_MaskB3_g251375;
				Data3_g251375.MaskC = In_MaskC3_g251375;
				Data3_g251375.MaskD = In_MaskD3_g251375;
				Data3_g251375.MaskE = In_MaskE3_g251375;
				Data3_g251375.MaskF = In_MaskF3_g251375;
				Data3_g251375.MaskG = In_MaskG3_g251375;
				Data3_g251375.MaskH = In_MaskH3_g251375;
				Data3_g251375.MaskI = In_MaskI3_g251375;
				Data3_g251375.MaskJ= In_MaskJ3_g251375;
				Data3_g251375.MaskK= In_MaskK3_g251375;
				Data3_g251375.MaskL = In_MaskL3_g251375;
				}
				TVEMasksData Data4_g252294 = Data3_g251375;
				float4 Out_MaskA4_g252294 = float4( 0,0,0,0 );
				float4 Out_MaskB4_g252294 = float4( 0,0,0,0 );
				float4 Out_MaskC4_g252294 = float4( 0,0,0,0 );
				float4 Out_MaskD4_g252294 = float4( 0,0,0,0 );
				float4 Out_MaskE4_g252294 = float4( 0,0,0,0 );
				float4 Out_MaskF4_g252294 = float4( 0,0,0,0 );
				float4 Out_MaskG4_g252294 = float4( 0,0,0,0 );
				float4 Out_MaskH4_g252294 = float4( 0,0,0,0 );
				{
				Out_MaskA4_g252294 = Data4_g252294.MaskA;
				Out_MaskB4_g252294 = Data4_g252294.MaskB;
				Out_MaskC4_g252294 = Data4_g252294.MaskC;
				Out_MaskD4_g252294 = Data4_g252294.MaskD;
				Out_MaskE4_g252294 = Data4_g252294.MaskE;
				Out_MaskF4_g252294 = Data4_g252294.MaskF;
				Out_MaskG4_g252294 = Data4_g252294.MaskG;
				Out_MaskH4_g252294 = Data4_g252294.MaskH;
				}
				half LayerMask182_g252284 = (Out_MaskB4_g252294).w;
				float localBreakData4_g252295 = ( 0.0 );
				float localBuildMasksData3_g251434 = ( 0.0 );
				TVEMasksData Data3_g251434 = (TVEMasksData)0;
				half Feature_Intensity1215_g251406 = _ThirdIntensityValue;
				float ifLocalVar18_g251432 = 0;
				if( Feature_Intensity1215_g251406 <= 0.0 )
				ifLocalVar18_g251432 = 0.0;
				else
				ifLocalVar18_g251432 = 1.0;
				half Feature_Element1211_g251406 = _ThirdElementMode;
				float ifLocalVar18_g251431 = 0;
				if( Feature_Element1211_g251406 <= 0.0 )
				ifLocalVar18_g251431 = 0.0;
				else
				ifLocalVar18_g251431 = 1.0;
				float4 appendResult1216_g251406 = (float4(ifLocalVar18_g251432 , 0.0 , 0.0 , ifLocalVar18_g251431));
				float4 In_MaskA3_g251434 = appendResult1216_g251406;
				half Blend_BakeMask1144_g251406 = ( Blend_TexMask429_g251406 * Blend_BaseMask1098_g251406 * Blend_LumaMask1046_g251406 * Blend_VertMask913_g251406 );
				float4 appendResult1217_g251406 = (float4(Blend_Mask412_g251406 , 0.0 , 0.0 , Blend_BakeMask1144_g251406));
				float4 temp_cast_95 = (0.0).xxxx;
				float4 temp_cast_96 = (0.0).xxxx;
				float4 ifLocalVar18_g251433 = 0;
				if( Feature_Intensity1215_g251406 <= 0.0 )
				ifLocalVar18_g251433 = temp_cast_96;
				else
				ifLocalVar18_g251433 = appendResult1217_g251406;
				float4 In_MaskB3_g251434 = ifLocalVar18_g251433;
				float4 temp_cast_97 = (0.0).xxxx;
				float4 In_MaskC3_g251434 = temp_cast_97;
				float4 temp_cast_98 = (0.0).xxxx;
				float4 In_MaskD3_g251434 = temp_cast_98;
				float4 temp_cast_99 = (0.0).xxxx;
				float4 In_MaskE3_g251434 = temp_cast_99;
				float4 temp_cast_100 = (0.0).xxxx;
				float4 In_MaskF3_g251434 = temp_cast_100;
				float4 temp_cast_101 = (0.0).xxxx;
				float4 In_MaskG3_g251434 = temp_cast_101;
				float4 temp_cast_102 = (0.0).xxxx;
				float4 In_MaskH3_g251434 = temp_cast_102;
				float4 temp_cast_103 = (0.0).xxxx;
				float4 In_MaskI3_g251434 = temp_cast_103;
				float4 temp_cast_104 = (0.0).xxxx;
				float4 In_MaskJ3_g251434 = temp_cast_104;
				float4 temp_cast_105 = (0.0).xxxx;
				float4 In_MaskK3_g251434 = temp_cast_105;
				float4 temp_cast_106 = (0.0).xxxx;
				float4 In_MaskL3_g251434 = temp_cast_106;
				{
				Data3_g251434.MaskA = In_MaskA3_g251434;
				Data3_g251434.MaskB = In_MaskB3_g251434;
				Data3_g251434.MaskC = In_MaskC3_g251434;
				Data3_g251434.MaskD = In_MaskD3_g251434;
				Data3_g251434.MaskE = In_MaskE3_g251434;
				Data3_g251434.MaskF = In_MaskF3_g251434;
				Data3_g251434.MaskG = In_MaskG3_g251434;
				Data3_g251434.MaskH = In_MaskH3_g251434;
				Data3_g251434.MaskI = In_MaskI3_g251434;
				Data3_g251434.MaskJ= In_MaskJ3_g251434;
				Data3_g251434.MaskK= In_MaskK3_g251434;
				Data3_g251434.MaskL = In_MaskL3_g251434;
				}
				TVEMasksData Data4_g252295 = Data3_g251434;
				float4 Out_MaskA4_g252295 = float4( 0,0,0,0 );
				float4 Out_MaskB4_g252295 = float4( 0,0,0,0 );
				float4 Out_MaskC4_g252295 = float4( 0,0,0,0 );
				float4 Out_MaskD4_g252295 = float4( 0,0,0,0 );
				float4 Out_MaskE4_g252295 = float4( 0,0,0,0 );
				float4 Out_MaskF4_g252295 = float4( 0,0,0,0 );
				float4 Out_MaskG4_g252295 = float4( 0,0,0,0 );
				float4 Out_MaskH4_g252295 = float4( 0,0,0,0 );
				{
				Out_MaskA4_g252295 = Data4_g252295.MaskA;
				Out_MaskB4_g252295 = Data4_g252295.MaskB;
				Out_MaskC4_g252295 = Data4_g252295.MaskC;
				Out_MaskD4_g252295 = Data4_g252295.MaskD;
				Out_MaskE4_g252295 = Data4_g252295.MaskE;
				Out_MaskF4_g252295 = Data4_g252295.MaskF;
				Out_MaskG4_g252295 = Data4_g252295.MaskG;
				Out_MaskH4_g252295 = Data4_g252295.MaskH;
				}
				half DetailMask186_g252284 = (Out_MaskB4_g252295).w;
				float4 appendResult144_g252284 = (float4(EmissiveMask150_g252284 , BaseMask152_g252284 , LayerMask182_g252284 , DetailMask186_g252284));
				
				float localBreakData4_g252296 = ( 0.0 );
				float localBuildMasksData3_g252090 = ( 0.0 );
				TVEMasksData Data3_g252090 = (TVEMasksData)0;
				half Feature_Intensity508_g252065 = _TintingIntensityValue;
				float ifLocalVar18_g252091 = 0;
				if( Feature_Intensity508_g252065 <= 0.0 )
				ifLocalVar18_g252091 = 0.0;
				else
				ifLocalVar18_g252091 = 1.0;
				half Feature_Element505_g252065 = _TintingElementMode;
				float ifLocalVar18_g252092 = 0;
				if( Feature_Element505_g252065 <= 0.0 )
				ifLocalVar18_g252092 = 0.0;
				else
				ifLocalVar18_g252092 = 1.0;
				float4 appendResult517_g252065 = (float4(ifLocalVar18_g252091 , 0.0 , 0.0 , ifLocalVar18_g252092));
				float4 In_MaskA3_g252090 = appendResult517_g252065;
				half Blend_BakeMask433_g252065 = ( Blend_TexMask385_g252065 * Blend_MutiMask121_g252065 * Blend_LumaMask153_g252065 * Blend_VertMask309_g252065 );
				float4 appendResult513_g252065 = (float4(Blend_Mask242_g252065 , 0.0 , 0.0 , Blend_BakeMask433_g252065));
				float4 temp_cast_107 = (0.0).xxxx;
				float4 temp_cast_108 = (0.0).xxxx;
				float4 ifLocalVar18_g252093 = 0;
				if( Feature_Intensity508_g252065 <= 0.0 )
				ifLocalVar18_g252093 = temp_cast_108;
				else
				ifLocalVar18_g252093 = appendResult513_g252065;
				float4 In_MaskB3_g252090 = ifLocalVar18_g252093;
				float4 temp_cast_109 = (0.0).xxxx;
				float4 In_MaskC3_g252090 = temp_cast_109;
				float4 temp_cast_110 = (0.0).xxxx;
				float4 In_MaskD3_g252090 = temp_cast_110;
				float4 temp_cast_111 = (0.0).xxxx;
				float4 In_MaskE3_g252090 = temp_cast_111;
				float4 temp_cast_112 = (0.0).xxxx;
				float4 In_MaskF3_g252090 = temp_cast_112;
				float4 temp_cast_113 = (0.0).xxxx;
				float4 In_MaskG3_g252090 = temp_cast_113;
				float4 temp_cast_114 = (0.0).xxxx;
				float4 In_MaskH3_g252090 = temp_cast_114;
				float4 temp_cast_115 = (0.0).xxxx;
				float4 In_MaskI3_g252090 = temp_cast_115;
				float4 temp_cast_116 = (0.0).xxxx;
				float4 In_MaskJ3_g252090 = temp_cast_116;
				float4 temp_cast_117 = (0.0).xxxx;
				float4 In_MaskK3_g252090 = temp_cast_117;
				float4 temp_cast_118 = (0.0).xxxx;
				float4 In_MaskL3_g252090 = temp_cast_118;
				{
				Data3_g252090.MaskA = In_MaskA3_g252090;
				Data3_g252090.MaskB = In_MaskB3_g252090;
				Data3_g252090.MaskC = In_MaskC3_g252090;
				Data3_g252090.MaskD = In_MaskD3_g252090;
				Data3_g252090.MaskE = In_MaskE3_g252090;
				Data3_g252090.MaskF = In_MaskF3_g252090;
				Data3_g252090.MaskG = In_MaskG3_g252090;
				Data3_g252090.MaskH = In_MaskH3_g252090;
				Data3_g252090.MaskI = In_MaskI3_g252090;
				Data3_g252090.MaskJ= In_MaskJ3_g252090;
				Data3_g252090.MaskK= In_MaskK3_g252090;
				Data3_g252090.MaskL = In_MaskL3_g252090;
				}
				TVEMasksData Data4_g252296 = Data3_g252090;
				float4 Out_MaskA4_g252296 = float4( 0,0,0,0 );
				float4 Out_MaskB4_g252296 = float4( 0,0,0,0 );
				float4 Out_MaskC4_g252296 = float4( 0,0,0,0 );
				float4 Out_MaskD4_g252296 = float4( 0,0,0,0 );
				float4 Out_MaskE4_g252296 = float4( 0,0,0,0 );
				float4 Out_MaskF4_g252296 = float4( 0,0,0,0 );
				float4 Out_MaskG4_g252296 = float4( 0,0,0,0 );
				float4 Out_MaskH4_g252296 = float4( 0,0,0,0 );
				{
				Out_MaskA4_g252296 = Data4_g252296.MaskA;
				Out_MaskB4_g252296 = Data4_g252296.MaskB;
				Out_MaskC4_g252296 = Data4_g252296.MaskC;
				Out_MaskD4_g252296 = Data4_g252296.MaskD;
				Out_MaskE4_g252296 = Data4_g252296.MaskE;
				Out_MaskF4_g252296 = Data4_g252296.MaskF;
				Out_MaskG4_g252296 = Data4_g252296.MaskG;
				Out_MaskH4_g252296 = Data4_g252296.MaskH;
				}
				half TintingMask160_g252284 = (Out_MaskB4_g252296).w;
				float localBreakData4_g252297 = ( 0.0 );
				float localBuildMasksData3_g252180 = ( 0.0 );
				TVEMasksData Data3_g252180 = (TVEMasksData)0;
				half Feature_Intensity1107_g252131 = _OverlayIntensityValue;
				float ifLocalVar18_g252176 = 0;
				if( Feature_Intensity1107_g252131 <= 0.0 )
				ifLocalVar18_g252176 = 0.0;
				else
				ifLocalVar18_g252176 = 1.0;
				half Feature_Maps1112_g252131 = _OverlayTextureMode;
				float ifLocalVar18_g252177 = 0;
				if( Feature_Maps1112_g252131 <= 0.0 )
				ifLocalVar18_g252177 = 0.0;
				else
				ifLocalVar18_g252177 = 1.0;
				half Feature_Glitter1108_g252131 = _OverlayGlitterIntensityValue;
				float ifLocalVar18_g252178 = 0;
				if( Feature_Glitter1108_g252131 <= 0.0 )
				ifLocalVar18_g252178 = 0.0;
				else
				ifLocalVar18_g252178 = 1.0;
				half Feature_Element1085_g252131 = _OverlayElementMode;
				float ifLocalVar18_g252175 = 0;
				if( Feature_Element1085_g252131 <= 0.0 )
				ifLocalVar18_g252175 = 0.0;
				else
				ifLocalVar18_g252175 = 1.0;
				float4 appendResult1117_g252131 = (float4(ifLocalVar18_g252176 , ifLocalVar18_g252177 , ifLocalVar18_g252178 , ifLocalVar18_g252175));
				float4 In_MaskA3_g252180 = appendResult1117_g252131;
				half Blend_BakerMask998_g252131 = ( Blend_TexMask908_g252131 * Blend_LumaMask438_g252131 * Blend_VertMask801_g252131 );
				float4 appendResult993_g252131 = (float4(Blend_Mask494_g252131 , 0.0 , 0.0 , Blend_BakerMask998_g252131));
				float4 temp_cast_119 = (0.0).xxxx;
				float4 temp_cast_120 = (0.0).xxxx;
				float4 ifLocalVar18_g252179 = 0;
				if( Feature_Intensity1107_g252131 <= 0.0 )
				ifLocalVar18_g252179 = temp_cast_120;
				else
				ifLocalVar18_g252179 = appendResult993_g252131;
				float4 In_MaskB3_g252180 = ifLocalVar18_g252179;
				float4 temp_cast_121 = (0.0).xxxx;
				float4 In_MaskC3_g252180 = temp_cast_121;
				float4 temp_cast_122 = (0.0).xxxx;
				float4 In_MaskD3_g252180 = temp_cast_122;
				float4 temp_cast_123 = (0.0).xxxx;
				float4 In_MaskE3_g252180 = temp_cast_123;
				float4 temp_cast_124 = (0.0).xxxx;
				float4 In_MaskF3_g252180 = temp_cast_124;
				float4 temp_cast_125 = (0.0).xxxx;
				float4 In_MaskG3_g252180 = temp_cast_125;
				float4 temp_cast_126 = (0.0).xxxx;
				float4 In_MaskH3_g252180 = temp_cast_126;
				float4 temp_cast_127 = (0.0).xxxx;
				float4 In_MaskI3_g252180 = temp_cast_127;
				float4 temp_cast_128 = (0.0).xxxx;
				float4 In_MaskJ3_g252180 = temp_cast_128;
				float4 temp_cast_129 = (0.0).xxxx;
				float4 In_MaskK3_g252180 = temp_cast_129;
				float4 temp_cast_130 = (0.0).xxxx;
				float4 In_MaskL3_g252180 = temp_cast_130;
				{
				Data3_g252180.MaskA = In_MaskA3_g252180;
				Data3_g252180.MaskB = In_MaskB3_g252180;
				Data3_g252180.MaskC = In_MaskC3_g252180;
				Data3_g252180.MaskD = In_MaskD3_g252180;
				Data3_g252180.MaskE = In_MaskE3_g252180;
				Data3_g252180.MaskF = In_MaskF3_g252180;
				Data3_g252180.MaskG = In_MaskG3_g252180;
				Data3_g252180.MaskH = In_MaskH3_g252180;
				Data3_g252180.MaskI = In_MaskI3_g252180;
				Data3_g252180.MaskJ= In_MaskJ3_g252180;
				Data3_g252180.MaskK= In_MaskK3_g252180;
				Data3_g252180.MaskL = In_MaskL3_g252180;
				}
				TVEMasksData Data4_g252297 = Data3_g252180;
				float4 Out_MaskA4_g252297 = float4( 0,0,0,0 );
				float4 Out_MaskB4_g252297 = float4( 0,0,0,0 );
				float4 Out_MaskC4_g252297 = float4( 0,0,0,0 );
				float4 Out_MaskD4_g252297 = float4( 0,0,0,0 );
				float4 Out_MaskE4_g252297 = float4( 0,0,0,0 );
				float4 Out_MaskF4_g252297 = float4( 0,0,0,0 );
				float4 Out_MaskG4_g252297 = float4( 0,0,0,0 );
				float4 Out_MaskH4_g252297 = float4( 0,0,0,0 );
				{
				Out_MaskA4_g252297 = Data4_g252297.MaskA;
				Out_MaskB4_g252297 = Data4_g252297.MaskB;
				Out_MaskC4_g252297 = Data4_g252297.MaskC;
				Out_MaskD4_g252297 = Data4_g252297.MaskD;
				Out_MaskE4_g252297 = Data4_g252297.MaskE;
				Out_MaskF4_g252297 = Data4_g252297.MaskF;
				Out_MaskG4_g252297 = Data4_g252297.MaskG;
				Out_MaskH4_g252297 = Data4_g252297.MaskH;
				}
				half OverlayMask163_g252284 = (Out_MaskB4_g252297).w;
				float localBreakData4_g252298 = ( 0.0 );
				float localBuildMasksData3_g252126 = ( 0.0 );
				TVEMasksData Data3_g252126 = (TVEMasksData)0;
				half Feature_Intensity568_g252095 = _DrynessIntensityValue;
				float ifLocalVar18_g252127 = 0;
				if( Feature_Intensity568_g252095 <= 0.0 )
				ifLocalVar18_g252127 = 0.0;
				else
				ifLocalVar18_g252127 = 1.0;
				half Feature_Element566_g252095 = _DrynessElementMode;
				float ifLocalVar18_g252128 = 0;
				if( Feature_Element566_g252095 <= 0.0 )
				ifLocalVar18_g252128 = 0.0;
				else
				ifLocalVar18_g252128 = 1.0;
				float4 appendResult577_g252095 = (float4(ifLocalVar18_g252127 , 0.0 , 0.0 , ifLocalVar18_g252128));
				float4 In_MaskA3_g252126 = appendResult577_g252095;
				half Blend_BakeMask518_g252095 = ( Blend_TexMask478_g252095 * Blend_MultiMask302_g252095 * Blend_LumaMask301_g252095 * Blend_VertMask378_g252095 );
				float4 appendResult573_g252095 = (float4(Blend_Mask329_g252095 , 0.0 , 0.0 , Blend_BakeMask518_g252095));
				float4 temp_cast_131 = (0.0).xxxx;
				float4 temp_cast_132 = (0.0).xxxx;
				float4 ifLocalVar18_g252129 = 0;
				if( Feature_Intensity568_g252095 <= 0.0 )
				ifLocalVar18_g252129 = temp_cast_132;
				else
				ifLocalVar18_g252129 = appendResult573_g252095;
				float4 In_MaskB3_g252126 = ifLocalVar18_g252129;
				float4 temp_cast_133 = (0.0).xxxx;
				float4 In_MaskC3_g252126 = temp_cast_133;
				float4 temp_cast_134 = (0.0).xxxx;
				float4 In_MaskD3_g252126 = temp_cast_134;
				float4 temp_cast_135 = (0.0).xxxx;
				float4 In_MaskE3_g252126 = temp_cast_135;
				float4 temp_cast_136 = (0.0).xxxx;
				float4 In_MaskF3_g252126 = temp_cast_136;
				float4 temp_cast_137 = (0.0).xxxx;
				float4 In_MaskG3_g252126 = temp_cast_137;
				float4 temp_cast_138 = (0.0).xxxx;
				float4 In_MaskH3_g252126 = temp_cast_138;
				float4 temp_cast_139 = (0.0).xxxx;
				float4 In_MaskI3_g252126 = temp_cast_139;
				float4 temp_cast_140 = (0.0).xxxx;
				float4 In_MaskJ3_g252126 = temp_cast_140;
				float4 temp_cast_141 = (0.0).xxxx;
				float4 In_MaskK3_g252126 = temp_cast_141;
				float4 temp_cast_142 = (0.0).xxxx;
				float4 In_MaskL3_g252126 = temp_cast_142;
				{
				Data3_g252126.MaskA = In_MaskA3_g252126;
				Data3_g252126.MaskB = In_MaskB3_g252126;
				Data3_g252126.MaskC = In_MaskC3_g252126;
				Data3_g252126.MaskD = In_MaskD3_g252126;
				Data3_g252126.MaskE = In_MaskE3_g252126;
				Data3_g252126.MaskF = In_MaskF3_g252126;
				Data3_g252126.MaskG = In_MaskG3_g252126;
				Data3_g252126.MaskH = In_MaskH3_g252126;
				Data3_g252126.MaskI = In_MaskI3_g252126;
				Data3_g252126.MaskJ= In_MaskJ3_g252126;
				Data3_g252126.MaskK= In_MaskK3_g252126;
				Data3_g252126.MaskL = In_MaskL3_g252126;
				}
				TVEMasksData Data4_g252298 = Data3_g252126;
				float4 Out_MaskA4_g252298 = float4( 0,0,0,0 );
				float4 Out_MaskB4_g252298 = float4( 0,0,0,0 );
				float4 Out_MaskC4_g252298 = float4( 0,0,0,0 );
				float4 Out_MaskD4_g252298 = float4( 0,0,0,0 );
				float4 Out_MaskE4_g252298 = float4( 0,0,0,0 );
				float4 Out_MaskF4_g252298 = float4( 0,0,0,0 );
				float4 Out_MaskG4_g252298 = float4( 0,0,0,0 );
				float4 Out_MaskH4_g252298 = float4( 0,0,0,0 );
				{
				Out_MaskA4_g252298 = Data4_g252298.MaskA;
				Out_MaskB4_g252298 = Data4_g252298.MaskB;
				Out_MaskC4_g252298 = Data4_g252298.MaskC;
				Out_MaskD4_g252298 = Data4_g252298.MaskD;
				Out_MaskE4_g252298 = Data4_g252298.MaskE;
				Out_MaskF4_g252298 = Data4_g252298.MaskF;
				Out_MaskG4_g252298 = Data4_g252298.MaskG;
				Out_MaskH4_g252298 = Data4_g252298.MaskH;
				}
				half DrynessMask168_g252284 = (Out_MaskB4_g252298).w;
				float localBreakData4_g252299 = ( 0.0 );
				float localBuildMasksData3_g252237 = ( 0.0 );
				TVEMasksData Data3_g252237 = (TVEMasksData)0;
				half Feature_Intensity883_g252218 = _CutoutIntensityValue;
				float ifLocalVar18_g252235 = 0;
				if( Feature_Intensity883_g252218 <= 0.0 )
				ifLocalVar18_g252235 = 0.0;
				else
				ifLocalVar18_g252235 = 1.0;
				half Feature_Element881_g252218 = _CutoutElementMode;
				float ifLocalVar18_g252236 = 0;
				if( Feature_Element881_g252218 <= 0.0 )
				ifLocalVar18_g252236 = 0.0;
				else
				ifLocalVar18_g252236 = 1.0;
				float4 appendResult888_g252218 = (float4(ifLocalVar18_g252235 , 0.0 , 0.0 , ifLocalVar18_g252236));
				float4 In_MaskA3_g252237 = appendResult888_g252218;
				float4 appendResult861_g252218 = (float4(0.0 , 0.0 , 0.0 , ( Local_AlphaMask814_g252218 * Local_VertMask766_g252218 )));
				float4 temp_cast_143 = (0.0).xxxx;
				float4 temp_cast_144 = (0.0).xxxx;
				float4 ifLocalVar18_g252238 = 0;
				if( Feature_Intensity883_g252218 <= 0.0 )
				ifLocalVar18_g252238 = temp_cast_144;
				else
				ifLocalVar18_g252238 = appendResult861_g252218;
				float4 In_MaskB3_g252237 = ifLocalVar18_g252238;
				float4 temp_cast_145 = (0.0).xxxx;
				float4 In_MaskC3_g252237 = temp_cast_145;
				float4 temp_cast_146 = (0.0).xxxx;
				float4 In_MaskD3_g252237 = temp_cast_146;
				float4 temp_cast_147 = (0.0).xxxx;
				float4 In_MaskE3_g252237 = temp_cast_147;
				float4 temp_cast_148 = (0.0).xxxx;
				float4 In_MaskF3_g252237 = temp_cast_148;
				float4 temp_cast_149 = (0.0).xxxx;
				float4 In_MaskG3_g252237 = temp_cast_149;
				float4 temp_cast_150 = (0.0).xxxx;
				float4 In_MaskH3_g252237 = temp_cast_150;
				float4 temp_cast_151 = (0.0).xxxx;
				float4 In_MaskI3_g252237 = temp_cast_151;
				float4 temp_cast_152 = (0.0).xxxx;
				float4 In_MaskJ3_g252237 = temp_cast_152;
				float4 temp_cast_153 = (0.0).xxxx;
				float4 In_MaskK3_g252237 = temp_cast_153;
				float4 temp_cast_154 = (0.0).xxxx;
				float4 In_MaskL3_g252237 = temp_cast_154;
				{
				Data3_g252237.MaskA = In_MaskA3_g252237;
				Data3_g252237.MaskB = In_MaskB3_g252237;
				Data3_g252237.MaskC = In_MaskC3_g252237;
				Data3_g252237.MaskD = In_MaskD3_g252237;
				Data3_g252237.MaskE = In_MaskE3_g252237;
				Data3_g252237.MaskF = In_MaskF3_g252237;
				Data3_g252237.MaskG = In_MaskG3_g252237;
				Data3_g252237.MaskH = In_MaskH3_g252237;
				Data3_g252237.MaskI = In_MaskI3_g252237;
				Data3_g252237.MaskJ= In_MaskJ3_g252237;
				Data3_g252237.MaskK= In_MaskK3_g252237;
				Data3_g252237.MaskL = In_MaskL3_g252237;
				}
				TVEMasksData Data4_g252299 = Data3_g252237;
				float4 Out_MaskA4_g252299 = float4( 0,0,0,0 );
				float4 Out_MaskB4_g252299 = float4( 0,0,0,0 );
				float4 Out_MaskC4_g252299 = float4( 0,0,0,0 );
				float4 Out_MaskD4_g252299 = float4( 0,0,0,0 );
				float4 Out_MaskE4_g252299 = float4( 0,0,0,0 );
				float4 Out_MaskF4_g252299 = float4( 0,0,0,0 );
				float4 Out_MaskG4_g252299 = float4( 0,0,0,0 );
				float4 Out_MaskH4_g252299 = float4( 0,0,0,0 );
				{
				Out_MaskA4_g252299 = Data4_g252299.MaskA;
				Out_MaskB4_g252299 = Data4_g252299.MaskB;
				Out_MaskC4_g252299 = Data4_g252299.MaskC;
				Out_MaskD4_g252299 = Data4_g252299.MaskD;
				Out_MaskE4_g252299 = Data4_g252299.MaskE;
				Out_MaskF4_g252299 = Data4_g252299.MaskF;
				Out_MaskG4_g252299 = Data4_g252299.MaskG;
				Out_MaskH4_g252299 = Data4_g252299.MaskH;
				}
				half CutoutMask172_g252284 = (Out_MaskB4_g252299).w;
				float4 appendResult173_g252284 = (float4(TintingMask160_g252284 , OverlayMask163_g252284 , DrynessMask168_g252284 , CutoutMask172_g252284));
				

				outGBuffer0 = appendResult92_g252284;
				outGBuffer1 = appendResult94_g252284;
				outGBuffer2 = appendResult99_g252284;
				outGBuffer3 = appendResult118_g252284;
				outGBuffer4 = i.ase_color;
				outGBuffer5 = Out_CoordsData15_g252289;
				outGBuffer6 = appendResult144_g252284;
				outGBuffer7 = appendResult173_g252284;
				float alpha = Out_AlphaClip4_g252285;
				clip( alpha );
				outDepth = i.pos.z;
			}
			ENDCG
		}
	}
	
	
	Fallback Off
}
/*ASEBEGIN
Version=19908
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;323;-5760,0;Inherit;False;Block Model;65;;76826;7ad7765e793a6714babedee0033c36e9;18,404,1,437,1,431,1,240,1,290,1,289,1,291,1,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0;11;102;FLOAT3;0,0,0;False;163;FLOAT3;0,0,0;False;186;FLOAT3;0,0,0;False;187;FLOAT3;0,0,0;False;166;FLOAT3;0,0,0;False;164;FLOAT3;0,0,0;False;301;FLOAT3;0,0,0;False;418;FLOAT3;0,0,0;False;167;FLOAT4;0,0,0,0;False;172;FLOAT4;0,0,0,0;False;175;FLOAT4;0,0,0,0;False;2;OBJECT;128;OBJECT;314
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;334;-5440,64;Half;False;Model Frag;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;335;-3712,0;Inherit;False;334;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;336;-3456,128;Inherit;False;334;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;491;-3456,0;Inherit;False;Block Main;78;;139039;b04cfed9a7b4c0841afdb49a38c282c5;12,65,1,136,1,41,1,133,1,40,1,329,1,344,0,347,0,342,0,345,0,346,0,343,0;1;225;OBJECT;0,0,0,0;False;1;OBJECT;106
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;398;-3136,256;Half;False;Property;_SecondBakeMode;_SecondBakeMode;441;0;Fetch;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;338;-2816,128;Inherit;False;334;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;590;-3200,128;Inherit;False;Block Layer;103;;251357;5f6a6b9e0b5515744bf8e48a9ccead1b;43,986,1,1107,1,1105,1,1104,1,1162,0,1110,1,1109,1,1112,1,1111,1,1115,1,1172,1,748,1,1070,1,1066,1,1124,1,1195,0,1199,0,1198,0,1197,0,1200,0,1196,0,1170,0,1166,0,1174,0,1173,0,1171,0,1169,0,1168,0,1165,0,1167,0,1048,0,1045,1,1175,0,1207,0,1053,1,1177,0,1201,0,1202,0,1086,1,1035,1,1055,1,1136,1,1051,1;3;585;OBJECT;0,0,0,0;False;633;OBJECT;0,0,0,0;False;974;OBJECT;0,0,0,0;False;2;OBJECT;552;OBJECT;1098
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;409;-2816,0;Inherit;False;If Visual Data;-1;;251405;947a79bd19d4b8e46835240e033f082b;1,32,0;8;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;401;-2496,256;Half;False;Property;_ThirdBakeMode;_ThirdBakeMode;442;0;Fetch;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;343;-2176,128;Inherit;False;334;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;591;-2560,128;Inherit;False;Block Detail;157;;251406;a5b52fdec7b855a4fba859a90e837892;44,990,1,1137,1,1124,1,1136,1,709,1,1125,1,1126,1,1127,1,1130,1,1206,1,1131,1,748,1,1073,1,1083,1,1123,1,1195,0,1193,0,1191,0,1192,0,1194,0,1190,0,1204,0,1208,0,1210,0,1200,0,1201,0,1202,0,1205,0,1203,0,1207,0,1062,0,1057,1,1214,0,1198,0,1067,1,1199,0,1196,0,1197,0,1100,1,1048,1,1069,1,1153,1,1065,1,1013,0;3;585;OBJECT;0,0,0,0;False;633;OBJECT;0,0,0,0;False;971;OBJECT;0,0,0,0;False;2;OBJECT;552;OBJECT;1110
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;418;-2176,0;Inherit;False;If Visual Data;-1;;251455;947a79bd19d4b8e46835240e033f082b;1,32,0;8;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;432;-1888,256;Half;False;Property;_OcclusionBakeMode;_OcclusionBakeMode;444;0;Fetch;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;494;-1888,128;Inherit;False;Block Occlusion;212;;251456;ec16733ec52362048954a75640fbe560;4,210,1,230,0,231,0,232,0;2;144;OBJECT;0,0,0,0;False;204;OBJECT;0,0,0,0;False;1;OBJECT;116
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;597;-1536,0;Inherit;False;If Visual Data;-1;;251800;947a79bd19d4b8e46835240e033f082b;1,32,0;8;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;598;-1280,256;Half;False;Property;_DualColorBakeMode;_DualColorBakeMode;443;0;Fetch;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;393;-896,128;Inherit;False;334;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;600;-1280,128;Inherit;False;Block Dual Color;0;;251802;4db73a98c81f808448207c77f3b4bd86;1,228,1;2;144;OBJECT;0,0,0,0;False;222;OBJECT;0,0,0,0;False;1;OBJECT;116
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;434;-576,256;Half;False;Property;_GradientBakeMode;_GradientBakeMode;445;0;Fetch;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;495;-608,128;Inherit;False;Block Gradient;223;;251809;1f0cb348753541648acbe7a6adce694e;7,228,1,284,0,285,0,283,0,258,0,251,0,263,0;2;144;OBJECT;0,0,0,0;False;222;OBJECT;0,0,0,0;False;1;OBJECT;116
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;447;-256,128;Inherit;False;334;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;431;-896,0;Inherit;False;If Visual Data;-1;;251828;947a79bd19d4b8e46835240e033f082b;1,32,0;8;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;433;-256,0;Inherit;False;If Visual Data;-1;;251829;947a79bd19d4b8e46835240e033f082b;1,32,0;8;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;448;64,256;Half;False;Property;_TintingBakeMode;_TintingBakeMode;447;0;Fetch;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;451;384,128;Inherit;False;334;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;601;0,128;Inherit;False;Block Tinting;244;;252065;9f39e156ea8d89e4997ea2a1e194137e;13,352,1,503,0,414,0,416,0,407,1,507,0,502,0,400,0,334,1,336,1,339,1,355,0,344,0;4;198;OBJECT;0,0,0,0;False;223;OBJECT;0,0,0,0;False;207;OBJECT;0,0,0,0;False;346;FLOAT;1;False;2;OBJECT;204;OBJECT;472
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;446;384,0;Inherit;False;If Visual Data;-1;;252094;947a79bd19d4b8e46835240e033f082b;1,32,0;8;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;450;704,256;Half;False;Property;_DrynessBakeMode;_DrynessBakeMode;448;0;Fetch;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;455;1024,128;Inherit;False;334;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;511;640,128;Inherit;False;Block Dryness;278;;252095;f05795de23f951c45bb73c8b4321e4b7;20,398,1,528,1,529,1,530,1,537,0,510,0,561,0,562,0,563,0,560,0,507,0,504,1,565,0,559,0,482,0,400,1,403,1,405,1,442,0,410,0;4;279;OBJECT;0,0,0,0;False;297;OBJECT;0,0,0,0;False;281;OBJECT;0,0,0,0;False;409;FLOAT;1;False;2;OBJECT;346;OBJECT;527
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;449;1024,0;Inherit;False;If Visual Data;-1;;252130;947a79bd19d4b8e46835240e033f082b;1,32,0;8;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;454;1344,256;Half;False;Property;_OverlayBakeMode;_OverlayBakeMode;449;0;Fetch;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;512;1280,128;Inherit;False;Block Overlay;320;;252131;8ae9c8285a7817844a51243251284d21;38,813,1,991,1,1061,1,987,1,992,1,819,1,821,1,1114,0,1111,0,1078,0,1066,0,1064,0,1067,0,1079,0,1065,0,1105,1,1104,0,1182,1,1101,0,1103,0,1097,0,1100,0,1102,0,942,0,940,1,1090,0,1089,0,944,0,826,1,828,1,823,1,1013,1,1018,0,1010,0,1034,0,1033,0,844,0,447,0;4;572;OBJECT;0,0,0,0;False;596;OBJECT;0,0,0,0;False;600;OBJECT;0,0,0,0;False;445;FLOAT;1;False;2;OBJECT;566;OBJECT;973
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;453;1664,0;Inherit;False;If Visual Data;-1;;252184;947a79bd19d4b8e46835240e033f082b;1,32,0;8;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;458;1984,256;Half;False;Property;_WetnessBakeMode;_WetnessBakeMode;450;0;Fetch;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;513;1920,128;Inherit;False;Block Wetness;376;;252185;52c5a1f52507fc44e926833b126e7855;26,850,1,1160,1,1161,1,1265,1,1162,1,945,1,857,1,930,1,1287,0,1286,0,1092,0,851,0,1135,1,1107,0,1283,0,1284,0,1285,0,1282,0,1124,0,1120,1,1278,0,1280,0,1075,0,1237,0,1238,0,1226,0;3;572;OBJECT;0,0,0,0;False;596;OBJECT;0,0,0,0;False;600;OBJECT;0,0,0,0;False;1;OBJECT;566
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;463;2304,128;Inherit;False;334;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;457;2304,0;Inherit;False;If Visual Data;-1;;252217;947a79bd19d4b8e46835240e033f082b;1,32,0;8;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;461;2624,256;Half;False;Property;_CutoutBakeMode;_CutoutBakeMode;446;0;Fetch;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;514;2560,128;Inherit;False;Block Cutout;421;;252218;866b4a5fe67e7f34085520e1bb5be2b7;13,775,1,872,0,871,1,870,0,846,0,840,1,869,0,880,0,777,1,815,1,853,0,779,1,817,1;3;572;OBJECT;0,0,0,0;False;596;OBJECT;0,0,0,0;False;600;OBJECT;0,0,0,0;False;2;OBJECT;566;OBJECT;862
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;534;-5440,0;Half;False;Model Vert;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;536;-4992,0;Inherit;False;534;Model Vert;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;477;2944,128;Inherit;False;334;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;462;2944,0;Inherit;False;If Visual Data;-1;;252241;947a79bd19d4b8e46835240e033f082b;1,32,0;8;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;561;-4736,0;Inherit;False;534;Model Vert;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;571;-4736,128;Inherit;False;Block Flatten;10;;252242;87f7defafe56dbf4b954caf5efc3f5ca;3,1825,1,1872,0,1843,1;1;146;OBJECT;0,0,0,0;False;2;OBJECT;128;OBJECT;1785
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;563;-4736,256;Half;False;Property;_FlattenBakeMode;_FlattenBakeMode;318;0;Fetch;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;587;3328,0;Inherit;False;Block Emissive;21;;252253;64497f287b9096b43b688b52b4a0bf20;12,282,0,273,1,411,0,319,0,312,1,410,0,416,0,264,1,408,0,409,0,267,1,402,0;3;146;OBJECT;0,0,0,0;False;148;OBJECT;0,0,0,0;False;178;OBJECT;0,0,0,0;False;2;OBJECT;183;OBJECT;350
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;562;-4352,0;Inherit;False;If Model Data;-1;;252282;d269c9c511ff160419055604aade1e70;1,32,0;9;3;OBJECT;0;False;17;OBJECT;0;False;19;FLOAT;0;False;33;OBJECT;0;False;27;OBJECT;0;False;28;OBJECT;0;False;29;OBJECT;0;False;30;OBJECT;0;False;31;FLOAT;0;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;370;3648,0;Half;False;Visual Data;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;537;-4160,0;Half;False;Model Data;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;592;-2816,256;Half;False;Layer Mask;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;593;-2176,256;Half;False;Detail Mask;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;578;384,256;Half;False;Tinting Mask;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;580;1664,256;Half;False;Overlay Mask;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;579;1024,256;Half;False;Dryness Mask;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;581;2944,256;Half;False;Cutout Mask;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;576;3648,256;Half;False;Emissive Mask;-1;True;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;391;4608,0;Inherit;False;370;Visual Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;539;4608,64;Inherit;False;537;Model Data;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;595;4608,128;Inherit;False;592;Layer Mask;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;596;4608,192;Inherit;False;593;Detail Mask;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;584;4608,320;Inherit;False;580;Overlay Mask;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;583;4608,256;Inherit;False;578;Tinting Mask;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;585;4608,384;Inherit;False;579;Dryness Mask;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;586;4608,448;Inherit;False;581;Cutout Mask;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;582;4608,512;Inherit;False;576;Emissive Mask;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;459;1664,128;Inherit;False;334;Model Frag;1;0;OBJECT;;False;1;OBJECT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;268;4608,-128;Half;False;Property;_RenderCull;_RenderCull;451;1;[HideInInspector];Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;507;4800,-128;Half;False;Property;_RenderNormal;_RenderNormal;319;1;[HideInInspector];Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;286;5472,-128;Inherit;False;Base Compile;-1;;252283;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;594;4992,0;Inherit;False;Block Impostor Baker;53;;252284;5fadd80fe4bec3e42b1e9ce050e0c79b;0;9;17;OBJECT;;False;129;OBJECT;;False;179;OBJECT;;False;185;OBJECT;;False;157;OBJECT;;False;164;OBJECT;;False;167;OBJECT;;False;171;OBJECT;;False;147;OBJECT;;False;9;FLOAT4;90;FLOAT4;96;FLOAT4;97;FLOAT4;113;COLOR;117;FLOAT4;146;FLOAT4;143;FLOAT4;176;FLOAT;93
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;533;5472,0;Float;False;True;-1;3;;100;1;Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Impostors Baker;b7b0c094c5aa58c468ed57de8fb0ffda;True;Unlit;0;0;Unlit;10;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;0;True;_RenderCull;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;RenderType=Opaque=RenderType;True;5;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;0;0;1;True;False;;True;0
WireConnection;334;0;323;314
WireConnection;491;225;335;0
WireConnection;590;585;491;106
WireConnection;590;633;336;0
WireConnection;409;3;491;106
WireConnection;409;17;590;552
WireConnection;409;19;398;0
WireConnection;591;585;409;0
WireConnection;591;633;338;0
WireConnection;418;3;409;0
WireConnection;418;17;591;552
WireConnection;418;19;401;0
WireConnection;494;144;418;0
WireConnection;494;204;343;0
WireConnection;597;3;418;0
WireConnection;597;17;494;116
WireConnection;597;19;432;0
WireConnection;600;144;597;0
WireConnection;495;144;431;0
WireConnection;495;222;393;0
WireConnection;431;3;597;0
WireConnection;431;17;600;116
WireConnection;431;19;598;0
WireConnection;433;3;431;0
WireConnection;433;17;495;116
WireConnection;433;19;434;0
WireConnection;601;198;433;0
WireConnection;601;223;447;0
WireConnection;446;3;433;0
WireConnection;446;17;601;204
WireConnection;446;19;448;0
WireConnection;511;279;446;0
WireConnection;511;297;451;0
WireConnection;449;3;446;0
WireConnection;449;17;511;346
WireConnection;449;19;450;0
WireConnection;512;572;449;0
WireConnection;512;596;455;0
WireConnection;453;3;449;0
WireConnection;453;17;512;566
WireConnection;453;19;454;0
WireConnection;513;572;453;0
WireConnection;457;3;453;0
WireConnection;457;17;513;566
WireConnection;457;19;458;0
WireConnection;514;572;457;0
WireConnection;514;596;463;0
WireConnection;534;0;323;128
WireConnection;462;3;457;0
WireConnection;462;17;514;566
WireConnection;462;19;461;0
WireConnection;571;146;536;0
WireConnection;587;146;462;0
WireConnection;587;148;477;0
WireConnection;562;3;561;0
WireConnection;562;17;571;128
WireConnection;562;19;563;0
WireConnection;370;0;587;183
WireConnection;537;0;562;0
WireConnection;592;0;590;1098
WireConnection;593;0;591;1110
WireConnection;578;0;601;472
WireConnection;580;0;512;973
WireConnection;579;0;511;527
WireConnection;581;0;514;862
WireConnection;576;0;587;350
WireConnection;594;17;391;0
WireConnection;594;129;539;0
WireConnection;594;179;595;0
WireConnection;594;185;596;0
WireConnection;594;157;583;0
WireConnection;594;164;584;0
WireConnection;594;167;585;0
WireConnection;594;171;586;0
WireConnection;594;147;582;0
WireConnection;533;0;594;90
WireConnection;533;1;594;96
WireConnection;533;2;594;97
WireConnection;533;3;594;113
WireConnection;533;4;594;117
WireConnection;533;5;594;146
WireConnection;533;6;594;143
WireConnection;533;7;594;176
WireConnection;533;8;594;93
ASEEND*/
//CHKSM=AE5D197ECB961BFF0811296F8CEA5C46598D122F