// Upgrade NOTE: upgraded instancing buffer 'BOXOPHOBICTheVisualEngineElementsCoatDetail' to new syntax.

// Made with Amplify Shader Editor v1.9.9.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Elements/Coat Detail"
{
	Properties
	{
		[StyledMessage(Info, Use the Coat Detail elements to control the Detail intensity. Element Texture A and Particle Color A are used as alpha masks., 0, 15)] _ElementMessage( "Element Message", Float ) = 0
		[HideInInspector] _IsVersion( "_IsVersion", Float ) = 2150
		[HideInInspector] _IsElementShader( "_IsElementShader", Float ) = 1
		[HideInInspector] _IsIdentifier( "_IsIdentifier", Float ) = 0
		[StyledCategory(Render Settings, true, 0, 10)] _RenderCategory( "[ Render Category ]", Float ) = 1
		_ElementIntensity( "Render Intensity", Range( 0, 1 ) ) = 1
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)] _ElementLayerMessage( "Render Layer Message", Float ) = 0
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)] _ElementLayerWarning( "Render Layer Warning", Float ) = 0
		[StyledMask(Coat Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _ElementLayerMask( "Render Layer", Float ) = 1
		[HideInInspector] _ElementParams( "Render Params", Vector ) = ( 1, 1, 1, 1 )
		[Enum(Constant,0,Seasons,1)] _ElementMode( "Render Mode", Float ) = 0
		[StyledSpace(10)] _RenderEnd( "[ Render End ]", Float ) = 0
		[StyledCategory(Element Settings, true, 0, 10)] _ElementCategory( "[ Element Category ]", Float ) = 1
		[NoScaleOffset][StyledTextureSingleLine] _MainTex( "Element Texture", 2D ) = "white" {}
		[StyledSpace(10)] _SpaceTexture( "#SpaceTexture", Float ) = 0
		[Enum(Main UV,0,Planar,1)] _ElementUVsMode( "Element Sampling", Float ) = 0
		[StyledVector(9)] _MainUVs( "Element UV Value", Vector ) = ( 1, 1, 0, 0 )
		[StyledRemapSlider] _MainTexColorRemap( "Element Value", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _MainTexAlphaRemap( "Element Alpha", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _MainTexFalloffRemap( "Element Falloff", Vector ) = ( 0, 0, 0, 0 )
		[Space(10)] _MainValue( "Element Value", Range( 0, 1 ) ) = 1
		[Space(10)] _AdditionalValue1( "Season Winter", Range( 0, 1 ) ) = 1
		_AdditionalValue2( "Season Spring", Range( 0, 1 ) ) = 1
		_AdditionalValue3( "Season Summer", Range( 0, 1 ) ) = 1
		_AdditionalValue4( "Season Autumn", Range( 0, 1 ) ) = 1
		[Space(10)][StyledRemapSlider] _SeasonRemap( "Season Curve", Vector ) = ( 0, 1, 0, 0 )
		[Space(10)] _SpeedTresholdValue( "Particle Speed Treshold", Float ) = 10
		[StyledSpace(10)] _ElementEnd( "[ Element End ]", Float ) = 0
		[StyledCategory(Masking Settings, true, 0, 10)] _MaskingCategory( "[ Masking Category ]", Float ) = 1
		[StyledMessage(Info, When the Terrain Data object is assigned__ the ProjY and PosY features use the terrain height and normal textures for masking. Make sure to set the Terrain Mask dropdown to Auto., 0, 10)] _MaskingTerrainInfo( "Masking Terrain Info", Float ) = 0
		[StyledMessage(Info, When the Terrain Data object is not assigned__ the ProjY and PosY features use the element mesh world space height and normal for masking., 0, 10)] _MaskingModelInfo( "Masking Model Info", Float ) = 0
		[HideInInspector] _TerrainPosition( "Terrain Position", Vector ) = ( 0, 0, 0, 0 )
		[HideInInspector] _TerrainSize( "Terrain Size", Vector ) = ( 0, 0, 0, 0 )
		[HideInInspector] _TerrainInputMode( "Terrain Input", Float ) = 0
		[NoScaleOffset][StyledTextureSingleLine] _ElementMaskTex( "Element Mask", 2D ) = "white" {}
		[StyledTextureSingleLine] _TerrainHeightTex( "Element Height", 2D ) = "white" {}
		[StyledTextureSingleLine] _TerrainNormalTex( "Element Normal", 2D ) = "linearGrey" {}
		[Enum(Main UV,0,Planar,1)][Space(10)] _ElementMaskCoordMode( "Mask Sampling", Float ) = 0
		[StyledVector(9)] _ElementMaskCoordValue( "Mask UV Value", Vector ) = ( 1, 1, 0, 0 )
		_ElementMaskValue( "Element TexC Mask", Range( 0, 1 ) ) = 0
		[Enum(Mask R,0,Mask A,1)] _ElementMaskMode( "Element TexC Mask", Float ) = 0
		[StyledRemapSlider] _ElementMaskRemap( "Element TexC Mask", Vector ) = ( 0, 1, 0, 0 )
		_ElementProjValue( "Element ProjY Mask", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _ElementProjRemap( "Element ProjY Mask", Vector ) = ( 0, 1, 0, 0 )
		_ElementPosValue( "Element PosY Mask", Range( 0, 1 ) ) = 0
		_ElementPosMinValue( "Element PosY Start", Float ) = 0
		_ElementPosMaxValue( "Element PosY Limit", Float ) = 0
		[StyledSpace(10)] _MaskingEnd( "[ Masking End ]", Float ) = 0
		[StyledCategory(Raycast Settings, true, 0, 10)] _RaycastCategory( "[ Raycast Category ]", Float ) = 1
		[HDR][Enum(Off,0,On,1)] _ElementRaycastMode( "Raycast Fade", Float ) = 0
		[StyledLayers()] _RaycastLayerMask( "Raycast Layer", Float ) = 1
		_RaycastDistanceMinValue( "Raycast Start", Float ) = 0
		_RaycastDistanceMaxValue( "Raycast Limit", Float ) = 2
		_RaycastDistanceCheckValue( "Raycast Max Distance", Float ) = 20
		[StyledSpace(10)] _RaycastEnd( "[ Raycast End ]", Float ) = 0
		[StyledCategory(Bounds Settings, true, 0, 10)] _BoundsCategory( "[ Bounds Category ]", Float ) = 1
		[Enum(Off,0,On,1)] _ElementVolumeFadeMode( "Bounds Fade", Float ) = 0
		_ElementVolumeFadeValue( "Bounds Fade Blend", Range( 0, 1 ) ) = 0.75
		[StyledSpace(10)] _BoundsEnd( "[ Bounds End ]", Float ) = 0

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Transparent" "Queue"="Transparent" "DisableBatching"="True" }
	LOD 100

		
		Pass
		{
			
			Name "VolumePass"
			Tags { "LightMode"="VolumePass" }
			
			CGINCLUDE
			#pragma target 3.0
			ENDCG
			Blend SrcAlpha OneMinusSrcAlpha
			AlphaToMask Off
			Cull Back
			ColorMask G
			ZWrite Off
			ZClip True
			ZTest LEqual
			
			CGPROGRAM

			#define ASE_VERSION 19908


			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				half3 ase_normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform half _IsVersion;
			uniform half _IsElementShader;
			uniform half _RenderCategory;
			uniform half _ElementLayerMessage;
			uniform half _ElementLayerWarning;
			uniform half _ElementLayerMask;
			uniform half _IsIdentifier;
			uniform float _SpeedTresholdValue;
			uniform half _ElementCategory;
			uniform half _ElementEnd;
			uniform half _RenderEnd;
			uniform half _ElementMessage;
			uniform half _MainValue;
			uniform half4 TVE_SeasonOption;
			uniform half _AdditionalValue1;
			uniform half _AdditionalValue2;
			uniform half TVE_SeasonLerp;
			uniform half4 _SeasonRemap;
			uniform half _AdditionalValue3;
			uniform half _AdditionalValue4;
			uniform half _ElementMode;
			uniform sampler2D _MainTex;
			uniform half _ElementUVsMode;
			uniform half4 _MainUVs;
			uniform half _SpaceTexture;
			uniform half4 _MainTexColorRemap;
			uniform half _ElementIntensity;
			uniform half4 _MainTexAlphaRemap;
			uniform half4 _MainTexFalloffRemap;
			uniform half4 TVE_RenderBasePositionR;
			uniform half _ElementVolumeFadeValue;
			uniform half _ElementVolumeFadeMode;
			uniform half _BoundsCategory;
			uniform half _BoundsEnd;
			uniform sampler2D _ElementMaskTex;
			uniform half _ElementMaskCoordMode;
			uniform half4 _ElementMaskCoordValue;
			uniform half _ElementMaskMode;
			uniform half4 _ElementMaskRemap;
			uniform half _ElementMaskValue;
			uniform sampler2D _TerrainNormalTex;
			uniform half3 _TerrainPosition;
			uniform half3 _TerrainSize;
			uniform half _TerrainInputMode;
			uniform half4 _ElementProjRemap;
			uniform half _ElementProjValue;
			uniform sampler2D _TerrainHeightTex;
			float4 _TerrainHeightTex_TexelSize;
			uniform half _ElementPosMaxValue;
			uniform half _ElementPosMinValue;
			uniform half _ElementPosValue;
			uniform half _MaskingCategory;
			uniform half _MaskingEnd;
			uniform half _MaskingTerrainInfo;
			uniform half _MaskingModelInfo;
			uniform half _RaycastCategory;
			uniform half _RaycastEnd;
			uniform half _ElementRaycastMode;
			uniform half _RaycastLayerMask;
			uniform half _RaycastDistanceMinValue;
			uniform half _RaycastDistanceMaxValue;
			uniform half _RaycastDistanceCheckValue;
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsCoatDetail)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsCoatDetail
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsCoatDetail)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				half TVE_SeasonOptions_X50_g77056 = TVE_SeasonOption.x;
				half Value_Winter158_g77056 = _AdditionalValue1;
				half Value_Spring159_g77056 = _AdditionalValue2;
				half temp_output_7_0_g77086 = _SeasonRemap.x;
				half temp_output_9_0_g77086 = ( TVE_SeasonLerp - temp_output_7_0_g77086 );
				half smoothstepResult2286_g77056 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g77086 * _SeasonRemap.z ) ));
				half SeasonLerp54_g77056 = smoothstepResult2286_g77056;
				half lerpResult168_g77056 = lerp( Value_Winter158_g77056 , Value_Spring159_g77056 , SeasonLerp54_g77056);
				half TVE_SeasonOptions_Y51_g77056 = TVE_SeasonOption.y;
				half Value_Summer160_g77056 = _AdditionalValue3;
				half lerpResult167_g77056 = lerp( Value_Spring159_g77056 , Value_Summer160_g77056 , SeasonLerp54_g77056);
				half TVE_SeasonOptions_Z52_g77056 = TVE_SeasonOption.z;
				half Value_Autumn161_g77056 = _AdditionalValue4;
				half lerpResult166_g77056 = lerp( Value_Summer160_g77056 , Value_Autumn161_g77056 , SeasonLerp54_g77056);
				half TVE_SeasonOptions_W53_g77056 = TVE_SeasonOption.w;
				half lerpResult165_g77056 = lerp( Value_Autumn161_g77056 , Value_Winter158_g77056 , SeasonLerp54_g77056);
				half temp_output_175_0_g77056 = ( ( TVE_SeasonOptions_X50_g77056 * lerpResult168_g77056 ) + ( TVE_SeasonOptions_Y51_g77056 * lerpResult167_g77056 ) + ( TVE_SeasonOptions_Z52_g77056 * lerpResult166_g77056 ) + ( TVE_SeasonOptions_W53_g77056 * lerpResult165_g77056 ) );
				half vertexToFrag11_g77080 = temp_output_175_0_g77056;
				o.ase_texcoord1.x = vertexToFrag11_g77080;
				float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
				half2 appendResult1900_g77056 = (half2(ase_positionWS.x , ase_positionWS.z));
				half2 lerpResult1899_g77056 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult1900_g77056 , _ElementUVsMode);
				half2 vertexToFrag11_g77089 = ( ( lerpResult1899_g77056 * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord1.yz = vertexToFrag11_g77089;
				half2 appendResult60_g77062 = (half2(ase_positionWS.x , ase_positionWS.z));
				half2 lerpResult58_g77062 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g77062 , _ElementMaskCoordMode);
				half2 vertexToFrag11_g77065 = ( ( lerpResult58_g77062 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
				o.ase_texcoord2.zw = vertexToFrag11_g77065;
				half3 ase_normalWS = UnityObjectToWorldNormal( v.ase_normal );
				o.ase_texcoord3.xyz = ase_normalWS;
				
				o.ase_color = v.color;
				o.ase_texcoord2.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.w = 0;
				o.ase_texcoord3.w = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				half Value_Main157_g77056 = _MainValue;
				half vertexToFrag11_g77080 = i.ase_texcoord1.x;
				half Value_Seasons1721_g77056 = vertexToFrag11_g77080;
				half Element_Mode55_g77056 = _ElementMode;
				half lerpResult181_g77056 = lerp( Value_Main157_g77056 , Value_Seasons1721_g77056 , Element_Mode55_g77056);
				half2 vertexToFrag11_g77089 = i.ase_texcoord1.yz;
				half4 MainTex_RGBA587_g77056 = tex2D( _MainTex, vertexToFrag11_g77089 );
				half3 temp_output_6_0_g77092 = (MainTex_RGBA587_g77056).rgb;
				half SpaceTexture2395_g77056 = _SpaceTexture;
				half temp_output_7_0_g77092 = SpaceTexture2395_g77056;
				#ifdef TVE_DUMMY
				half3 staticSwitch14_g77092 = ( temp_output_6_0_g77092 + temp_output_7_0_g77092 );
				#else
				half3 staticSwitch14_g77092 = temp_output_6_0_g77092;
				#endif
				half3 temp_cast_0 = (0.0001).xxx;
				half3 temp_cast_1 = (0.9999).xxx;
				half3 clampResult17_g77087 = clamp( staticSwitch14_g77092 , temp_cast_0 , temp_cast_1 );
				half temp_output_7_0_g77090 = _MainTexColorRemap.x;
				half3 temp_cast_2 = (temp_output_7_0_g77090).xxx;
				half3 temp_output_9_0_g77090 = ( clampResult17_g77087 - temp_cast_2 );
				half3 temp_output_1765_0_g77056 = saturate( ( temp_output_9_0_g77090 * _MainTexColorRemap.z ) );
				half Element_Remap_R73_g77056 = (temp_output_1765_0_g77056).x;
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half Element_Params_R1738_g77056 = _ElementParams_Instance.x;
				half Element_Value1744_g77056 = ( Element_Remap_R73_g77056 * Element_Params_R1738_g77056 * i.ase_color.r );
				half temp_output_468_0_g77056 = ( lerpResult181_g77056 * Element_Value1744_g77056 );
				half3 appendResult2402_g77056 = (half3(temp_output_468_0_g77056 , temp_output_468_0_g77056 , temp_output_468_0_g77056));
				half3 FInal_RGB213_g77056 = appendResult2402_g77056;
				half temp_output_6_0_g77093 = (MainTex_RGBA587_g77056).a;
				half temp_output_7_0_g77093 = SpaceTexture2395_g77056;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77093 = ( temp_output_6_0_g77093 + temp_output_7_0_g77093 );
				#else
				half staticSwitch14_g77093 = temp_output_6_0_g77093;
				#endif
				half clampResult17_g77088 = clamp( staticSwitch14_g77093 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77091 = _MainTexAlphaRemap.x;
				half temp_output_9_0_g77091 = ( clampResult17_g77088 - temp_output_7_0_g77091 );
				half Element_Remap_A74_g77056 = saturate( ( temp_output_9_0_g77091 * _MainTexAlphaRemap.z ) );
				half Element_Params_A1737_g77056 = _ElementParams_Instance.w;
				half temp_output_6_0_g77095 = saturate( ( 1.0 - distance( (i.ase_texcoord2.xy*2.0 + -1.0) , float2( 0,0 ) ) ) );
				half temp_output_7_0_g77095 = SpaceTexture2395_g77056;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77095 = ( temp_output_6_0_g77095 + temp_output_7_0_g77095 );
				#else
				half staticSwitch14_g77095 = temp_output_6_0_g77095;
				#endif
				half clampResult17_g77094 = clamp( staticSwitch14_g77095 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77085 = _MainTexFalloffRemap.x;
				half temp_output_9_0_g77085 = ( clampResult17_g77094 - temp_output_7_0_g77085 );
				half Element_Falloff1883_g77056 = saturate( ( temp_output_9_0_g77085 * _MainTexFalloffRemap.z ) );
				half temp_output_7_0_g77076 = 1.0;
				half temp_output_9_0_g77076 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g77076 );
				half lerpResult18_g77074 = lerp( 1.0 , saturate( ( temp_output_9_0_g77076 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g77076 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g77074 = lerpResult18_g77074;
				half temp_output_6_0_g77077 = Blend_Edge69_g77074;
				half Dummy72_g77074 = ( _BoundsCategory + _BoundsEnd );
				half temp_output_7_0_g77077 = Dummy72_g77074;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77077 = ( temp_output_6_0_g77077 + temp_output_7_0_g77077 );
				#else
				half staticSwitch14_g77077 = temp_output_6_0_g77077;
				#endif
				half2 vertexToFrag11_g77065 = i.ase_texcoord2.zw;
				half4 MainTex_RGBA53_g77062 = tex2D( _ElementMaskTex, vertexToFrag11_g77065 );
				half lerpResult148_g77062 = lerp( (MainTex_RGBA53_g77062).r , (MainTex_RGBA53_g77062).a , _ElementMaskMode);
				half clampResult17_g77071 = clamp( lerpResult148_g77062 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77072 = _ElementMaskRemap.x;
				half temp_output_9_0_g77072 = ( clampResult17_g77071 - temp_output_7_0_g77072 );
				half lerpResult73_g77062 = lerp( 1.0 , saturate( ( temp_output_9_0_g77072 * _ElementMaskRemap.z ) ) , _ElementMaskValue);
				half Blend_Mask45_g77062 = lerpResult73_g77062;
				half3 ase_normalWS = i.ase_texcoord3.xyz;
				half4 appendResult108_g77062 = (half4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
				half4 Terrain_Coords111_g77062 = appendResult108_g77062;
				half4 temp_output_35_0_g77070 = Terrain_Coords111_g77062;
				float2 InputScale48_g77070 = (temp_output_35_0_g77070).zw;
				half2 FinalScale53_g77070 = ( 1.0 / InputScale48_g77070 );
				float2 InputPosition52_g77070 = (temp_output_35_0_g77070).xy;
				half2 FinalPosition58_g77070 = -( FinalScale53_g77070 * InputPosition52_g77070 );
				half2 temp_output_65_0_g77070 = ( ( (WorldPosition).xz * FinalScale53_g77070 ) + FinalPosition58_g77070 );
				half Terrain_InputMode136_g77062 = _TerrainInputMode;
				half3 lerpResult141_g77062 = lerp( ase_normalWS , tex2D( _TerrainNormalTex, temp_output_65_0_g77070 ).rgb , Terrain_InputMode136_g77062);
				half3 Terrain_Normal107_g77062 = lerpResult141_g77062;
				half dotResult113_g77062 = dot( Terrain_Normal107_g77062 , half3( 0, 1, 0 ) );
				half clampResult17_g77067 = clamp( dotResult113_g77062 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77068 = _ElementProjRemap.x;
				half temp_output_9_0_g77068 = ( clampResult17_g77067 - temp_output_7_0_g77068 );
				half lerpResult123_g77062 = lerp( 1.0 , saturate( ( temp_output_9_0_g77068 * _ElementProjRemap.z ) ) , _ElementProjValue);
				half Blend_Proj117_g77062 = lerpResult123_g77062;
				half4 temp_output_35_0_g77063 = Terrain_Coords111_g77062;
				float2 InputScale48_g77063 = (temp_output_35_0_g77063).zw;
				half2 FinalScale53_g77063 = ( 1.0 / InputScale48_g77063 );
				float2 InputPosition52_g77063 = (temp_output_35_0_g77063).xy;
				half2 FinalPosition58_g77063 = -( FinalScale53_g77063 * InputPosition52_g77063 );
				half2 temp_output_65_0_g77063 = ( ( (WorldPosition).xz * FinalScale53_g77063 ) + FinalPosition58_g77063 );
				half4 temp_output_70_0_g77063 = _TerrainHeightTex_TexelSize;
				float2 InputTexelSize68_g77063 = (temp_output_70_0_g77063).zw;
				half2 temp_cast_3 = (1.0).xx;
				float2 InputTexelRecip69_g77063 = (temp_output_70_0_g77063).xy;
				float4 Terrain_Height_Raw104_g77062 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g77063 / ( 1.0 / ( InputTexelSize68_g77063 - temp_cast_3 ) ) ) + 0.5 ) * InputTexelRecip69_g77063 ) );
				half temp_output_90_0_g77062 = ( ( (Terrain_Height_Raw104_g77062).r + ( (Terrain_Height_Raw104_g77062).g * 256.0 ) ) / 257.0 );
				#ifdef SHADER_API_VULKAN
				half staticSwitch91_g77062 = temp_output_90_0_g77062;
				#else
				half staticSwitch91_g77062 = (Terrain_Height_Raw104_g77062).r;
				#endif
				#ifdef SHADER_API_GLES
				half staticSwitch92_g77062 = temp_output_90_0_g77062;
				#else
				half staticSwitch92_g77062 = staticSwitch91_g77062;
				#endif
				#ifdef SHADER_API_GLES3
				half staticSwitch93_g77062 = temp_output_90_0_g77062;
				#else
				half staticSwitch93_g77062 = staticSwitch92_g77062;
				#endif
				float Terrain_Height_Platform105_g77062 = staticSwitch93_g77062;
				half Terrain_SizeY109_g77062 = _TerrainSize.y;
				half Terrain_PosY110_g77062 = _TerrainPosition.y;
				half lerpResult137_g77062 = lerp( WorldPosition.y , ( ( Terrain_Height_Platform105_g77062 * Terrain_SizeY109_g77062 * 2.0 ) + Terrain_PosY110_g77062 ) , Terrain_InputMode136_g77062);
				float Terrain_Height106_g77062 = lerpResult137_g77062;
				half temp_output_7_0_g77069 = _ElementPosMaxValue;
				half temp_output_9_0_g77069 = ( Terrain_Height106_g77062 - temp_output_7_0_g77069 );
				half lerpResult129_g77062 = lerp( 1.0 , saturate( ( temp_output_9_0_g77069 / ( ( _ElementPosMinValue - temp_output_7_0_g77069 ) + 0.0001 ) ) ) , _ElementPosValue);
				half Blend_Pos131_g77062 = lerpResult129_g77062;
				half temp_output_6_0_g77073 = ( Blend_Mask45_g77062 * Blend_Proj117_g77062 * Blend_Pos131_g77062 );
				half Dummy144_g77062 = ( _MaskingCategory + _MaskingEnd + ( _MaskingTerrainInfo + _MaskingModelInfo ) );
				half temp_output_7_0_g77073 = Dummy144_g77062;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77073 = ( temp_output_6_0_g77073 + temp_output_7_0_g77073 );
				#else
				half staticSwitch14_g77073 = temp_output_6_0_g77073;
				#endif
				half temp_output_6_0_g77084 = 1.0;
				half temp_output_7_0_g77084 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				half staticSwitch14_g77084 = ( temp_output_6_0_g77084 + temp_output_7_0_g77084 );
				#else
				half staticSwitch14_g77084 = temp_output_6_0_g77084;
				#endif
				half Element_Alpha56_g77056 = ( _ElementIntensity * Element_Remap_A74_g77056 * Element_Params_A1737_g77056 * i.ase_color.a * Element_Falloff1883_g77056 * staticSwitch14_g77077 * staticSwitch14_g77073 * staticSwitch14_g77084 );
				half Final_A241_g77056 = Element_Alpha56_g77056;
				half4 appendResult882_g77056 = (half4(FInal_RGB213_g77056 , Final_A241_g77056));
				
				
				finalColor = appendResult882_g77056;
				return finalColor;
			}
			ENDCG
		}

		
		Pass
		{
			
			Name "VisualPass"
			
			CGINCLUDE
			#pragma target 3.0
			ENDCG
			Blend SrcAlpha OneMinusSrcAlpha
			AlphaToMask Off
			Cull Back
			ColorMask RGBA
			ZWrite Off
			ZClip True
			ZTest LEqual
			
			CGPROGRAM

			#define ASE_VERSION 19908


			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				half3 ase_normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform half _IsVersion;
			uniform half _IsElementShader;
			uniform half _RenderCategory;
			uniform half _ElementLayerMessage;
			uniform half _ElementLayerWarning;
			uniform half _ElementLayerMask;
			uniform half _IsIdentifier;
			uniform half _SpeedTresholdValue;
			uniform half _ElementCategory;
			uniform half _ElementEnd;
			uniform half _RenderEnd;
			uniform half _ElementMessage;
			uniform half _MainValue;
			uniform half4 TVE_SeasonOption;
			uniform half _AdditionalValue1;
			uniform half _AdditionalValue2;
			uniform half TVE_SeasonLerp;
			uniform half4 _SeasonRemap;
			uniform half _AdditionalValue3;
			uniform half _AdditionalValue4;
			uniform half _ElementMode;
			uniform sampler2D _MainTex;
			uniform half _ElementUVsMode;
			uniform half4 _MainUVs;
			uniform half _SpaceTexture;
			uniform half4 _MainTexColorRemap;
			uniform half _ElementIntensity;
			uniform half4 _MainTexAlphaRemap;
			uniform half4 _MainTexFalloffRemap;
			uniform half4 TVE_RenderBasePositionR;
			uniform half _ElementVolumeFadeValue;
			uniform half _ElementVolumeFadeMode;
			uniform half _BoundsCategory;
			uniform half _BoundsEnd;
			uniform sampler2D _ElementMaskTex;
			uniform half _ElementMaskCoordMode;
			uniform half4 _ElementMaskCoordValue;
			uniform half _ElementMaskMode;
			uniform half4 _ElementMaskRemap;
			uniform half _ElementMaskValue;
			uniform sampler2D _TerrainNormalTex;
			uniform half3 _TerrainPosition;
			uniform half3 _TerrainSize;
			uniform half _TerrainInputMode;
			uniform half4 _ElementProjRemap;
			uniform half _ElementProjValue;
			uniform sampler2D _TerrainHeightTex;
			float4 _TerrainHeightTex_TexelSize;
			uniform half _ElementPosMaxValue;
			uniform half _ElementPosMinValue;
			uniform half _ElementPosValue;
			uniform half _MaskingCategory;
			uniform half _MaskingEnd;
			uniform half _MaskingTerrainInfo;
			uniform half _MaskingModelInfo;
			uniform half _RaycastCategory;
			uniform half _RaycastEnd;
			uniform half _ElementRaycastMode;
			uniform half _RaycastLayerMask;
			uniform half _RaycastDistanceMinValue;
			uniform half _RaycastDistanceMaxValue;
			uniform half _RaycastDistanceCheckValue;
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsCoatDetail)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsCoatDetail
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsCoatDetail)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				half TVE_SeasonOptions_X50_g77056 = TVE_SeasonOption.x;
				half Value_Winter158_g77056 = _AdditionalValue1;
				half Value_Spring159_g77056 = _AdditionalValue2;
				half temp_output_7_0_g77086 = _SeasonRemap.x;
				half temp_output_9_0_g77086 = ( TVE_SeasonLerp - temp_output_7_0_g77086 );
				half smoothstepResult2286_g77056 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g77086 * _SeasonRemap.z ) ));
				half SeasonLerp54_g77056 = smoothstepResult2286_g77056;
				half lerpResult168_g77056 = lerp( Value_Winter158_g77056 , Value_Spring159_g77056 , SeasonLerp54_g77056);
				half TVE_SeasonOptions_Y51_g77056 = TVE_SeasonOption.y;
				half Value_Summer160_g77056 = _AdditionalValue3;
				half lerpResult167_g77056 = lerp( Value_Spring159_g77056 , Value_Summer160_g77056 , SeasonLerp54_g77056);
				half TVE_SeasonOptions_Z52_g77056 = TVE_SeasonOption.z;
				half Value_Autumn161_g77056 = _AdditionalValue4;
				half lerpResult166_g77056 = lerp( Value_Summer160_g77056 , Value_Autumn161_g77056 , SeasonLerp54_g77056);
				half TVE_SeasonOptions_W53_g77056 = TVE_SeasonOption.w;
				half lerpResult165_g77056 = lerp( Value_Autumn161_g77056 , Value_Winter158_g77056 , SeasonLerp54_g77056);
				half temp_output_175_0_g77056 = ( ( TVE_SeasonOptions_X50_g77056 * lerpResult168_g77056 ) + ( TVE_SeasonOptions_Y51_g77056 * lerpResult167_g77056 ) + ( TVE_SeasonOptions_Z52_g77056 * lerpResult166_g77056 ) + ( TVE_SeasonOptions_W53_g77056 * lerpResult165_g77056 ) );
				half vertexToFrag11_g77080 = temp_output_175_0_g77056;
				o.ase_texcoord1.x = vertexToFrag11_g77080;
				float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
				half2 appendResult1900_g77056 = (half2(ase_positionWS.x , ase_positionWS.z));
				half2 lerpResult1899_g77056 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult1900_g77056 , _ElementUVsMode);
				half2 vertexToFrag11_g77089 = ( ( lerpResult1899_g77056 * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord1.yz = vertexToFrag11_g77089;
				half2 appendResult60_g77062 = (half2(ase_positionWS.x , ase_positionWS.z));
				half2 lerpResult58_g77062 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g77062 , _ElementMaskCoordMode);
				half2 vertexToFrag11_g77065 = ( ( lerpResult58_g77062 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
				o.ase_texcoord2.zw = vertexToFrag11_g77065;
				half3 ase_normalWS = UnityObjectToWorldNormal( v.ase_normal );
				o.ase_texcoord3.xyz = ase_normalWS;
				
				o.ase_color = v.color;
				o.ase_texcoord2.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.w = 0;
				o.ase_texcoord3.w = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				half Value_Main157_g77056 = _MainValue;
				half vertexToFrag11_g77080 = i.ase_texcoord1.x;
				half Value_Seasons1721_g77056 = vertexToFrag11_g77080;
				half Element_Mode55_g77056 = _ElementMode;
				half lerpResult181_g77056 = lerp( Value_Main157_g77056 , Value_Seasons1721_g77056 , Element_Mode55_g77056);
				half2 vertexToFrag11_g77089 = i.ase_texcoord1.yz;
				half4 MainTex_RGBA587_g77056 = tex2D( _MainTex, vertexToFrag11_g77089 );
				half3 temp_output_6_0_g77092 = (MainTex_RGBA587_g77056).rgb;
				half SpaceTexture2395_g77056 = _SpaceTexture;
				half temp_output_7_0_g77092 = SpaceTexture2395_g77056;
				#ifdef TVE_DUMMY
				half3 staticSwitch14_g77092 = ( temp_output_6_0_g77092 + temp_output_7_0_g77092 );
				#else
				half3 staticSwitch14_g77092 = temp_output_6_0_g77092;
				#endif
				half3 temp_cast_0 = (0.0001).xxx;
				half3 temp_cast_1 = (0.9999).xxx;
				half3 clampResult17_g77087 = clamp( staticSwitch14_g77092 , temp_cast_0 , temp_cast_1 );
				half temp_output_7_0_g77090 = _MainTexColorRemap.x;
				half3 temp_cast_2 = (temp_output_7_0_g77090).xxx;
				half3 temp_output_9_0_g77090 = ( clampResult17_g77087 - temp_cast_2 );
				half3 temp_output_1765_0_g77056 = saturate( ( temp_output_9_0_g77090 * _MainTexColorRemap.z ) );
				half Element_Remap_R73_g77056 = (temp_output_1765_0_g77056).x;
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half Element_Params_R1738_g77056 = _ElementParams_Instance.x;
				half Element_Value1744_g77056 = ( Element_Remap_R73_g77056 * Element_Params_R1738_g77056 * i.ase_color.r );
				half temp_output_468_0_g77056 = ( lerpResult181_g77056 * Element_Value1744_g77056 );
				half3 appendResult2402_g77056 = (half3(temp_output_468_0_g77056 , temp_output_468_0_g77056 , temp_output_468_0_g77056));
				half3 FInal_RGB213_g77056 = appendResult2402_g77056;
				half temp_output_6_0_g77093 = (MainTex_RGBA587_g77056).a;
				half temp_output_7_0_g77093 = SpaceTexture2395_g77056;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77093 = ( temp_output_6_0_g77093 + temp_output_7_0_g77093 );
				#else
				half staticSwitch14_g77093 = temp_output_6_0_g77093;
				#endif
				half clampResult17_g77088 = clamp( staticSwitch14_g77093 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77091 = _MainTexAlphaRemap.x;
				half temp_output_9_0_g77091 = ( clampResult17_g77088 - temp_output_7_0_g77091 );
				half Element_Remap_A74_g77056 = saturate( ( temp_output_9_0_g77091 * _MainTexAlphaRemap.z ) );
				half Element_Params_A1737_g77056 = _ElementParams_Instance.w;
				half temp_output_6_0_g77095 = saturate( ( 1.0 - distance( (i.ase_texcoord2.xy*2.0 + -1.0) , float2( 0,0 ) ) ) );
				half temp_output_7_0_g77095 = SpaceTexture2395_g77056;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77095 = ( temp_output_6_0_g77095 + temp_output_7_0_g77095 );
				#else
				half staticSwitch14_g77095 = temp_output_6_0_g77095;
				#endif
				half clampResult17_g77094 = clamp( staticSwitch14_g77095 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77085 = _MainTexFalloffRemap.x;
				half temp_output_9_0_g77085 = ( clampResult17_g77094 - temp_output_7_0_g77085 );
				half Element_Falloff1883_g77056 = saturate( ( temp_output_9_0_g77085 * _MainTexFalloffRemap.z ) );
				half temp_output_7_0_g77076 = 1.0;
				half temp_output_9_0_g77076 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g77076 );
				half lerpResult18_g77074 = lerp( 1.0 , saturate( ( temp_output_9_0_g77076 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g77076 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g77074 = lerpResult18_g77074;
				half temp_output_6_0_g77077 = Blend_Edge69_g77074;
				half Dummy72_g77074 = ( _BoundsCategory + _BoundsEnd );
				half temp_output_7_0_g77077 = Dummy72_g77074;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77077 = ( temp_output_6_0_g77077 + temp_output_7_0_g77077 );
				#else
				half staticSwitch14_g77077 = temp_output_6_0_g77077;
				#endif
				half2 vertexToFrag11_g77065 = i.ase_texcoord2.zw;
				half4 MainTex_RGBA53_g77062 = tex2D( _ElementMaskTex, vertexToFrag11_g77065 );
				half lerpResult148_g77062 = lerp( (MainTex_RGBA53_g77062).r , (MainTex_RGBA53_g77062).a , _ElementMaskMode);
				half clampResult17_g77071 = clamp( lerpResult148_g77062 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77072 = _ElementMaskRemap.x;
				half temp_output_9_0_g77072 = ( clampResult17_g77071 - temp_output_7_0_g77072 );
				half lerpResult73_g77062 = lerp( 1.0 , saturate( ( temp_output_9_0_g77072 * _ElementMaskRemap.z ) ) , _ElementMaskValue);
				half Blend_Mask45_g77062 = lerpResult73_g77062;
				half3 ase_normalWS = i.ase_texcoord3.xyz;
				half4 appendResult108_g77062 = (half4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
				half4 Terrain_Coords111_g77062 = appendResult108_g77062;
				half4 temp_output_35_0_g77070 = Terrain_Coords111_g77062;
				float2 InputScale48_g77070 = (temp_output_35_0_g77070).zw;
				half2 FinalScale53_g77070 = ( 1.0 / InputScale48_g77070 );
				float2 InputPosition52_g77070 = (temp_output_35_0_g77070).xy;
				half2 FinalPosition58_g77070 = -( FinalScale53_g77070 * InputPosition52_g77070 );
				half2 temp_output_65_0_g77070 = ( ( (WorldPosition).xz * FinalScale53_g77070 ) + FinalPosition58_g77070 );
				half Terrain_InputMode136_g77062 = _TerrainInputMode;
				half3 lerpResult141_g77062 = lerp( ase_normalWS , tex2D( _TerrainNormalTex, temp_output_65_0_g77070 ).rgb , Terrain_InputMode136_g77062);
				half3 Terrain_Normal107_g77062 = lerpResult141_g77062;
				half dotResult113_g77062 = dot( Terrain_Normal107_g77062 , half3( 0, 1, 0 ) );
				half clampResult17_g77067 = clamp( dotResult113_g77062 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77068 = _ElementProjRemap.x;
				half temp_output_9_0_g77068 = ( clampResult17_g77067 - temp_output_7_0_g77068 );
				half lerpResult123_g77062 = lerp( 1.0 , saturate( ( temp_output_9_0_g77068 * _ElementProjRemap.z ) ) , _ElementProjValue);
				half Blend_Proj117_g77062 = lerpResult123_g77062;
				half4 temp_output_35_0_g77063 = Terrain_Coords111_g77062;
				float2 InputScale48_g77063 = (temp_output_35_0_g77063).zw;
				half2 FinalScale53_g77063 = ( 1.0 / InputScale48_g77063 );
				float2 InputPosition52_g77063 = (temp_output_35_0_g77063).xy;
				half2 FinalPosition58_g77063 = -( FinalScale53_g77063 * InputPosition52_g77063 );
				half2 temp_output_65_0_g77063 = ( ( (WorldPosition).xz * FinalScale53_g77063 ) + FinalPosition58_g77063 );
				half4 temp_output_70_0_g77063 = _TerrainHeightTex_TexelSize;
				float2 InputTexelSize68_g77063 = (temp_output_70_0_g77063).zw;
				half2 temp_cast_3 = (1.0).xx;
				float2 InputTexelRecip69_g77063 = (temp_output_70_0_g77063).xy;
				float4 Terrain_Height_Raw104_g77062 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g77063 / ( 1.0 / ( InputTexelSize68_g77063 - temp_cast_3 ) ) ) + 0.5 ) * InputTexelRecip69_g77063 ) );
				half temp_output_90_0_g77062 = ( ( (Terrain_Height_Raw104_g77062).r + ( (Terrain_Height_Raw104_g77062).g * 256.0 ) ) / 257.0 );
				#ifdef SHADER_API_VULKAN
				half staticSwitch91_g77062 = temp_output_90_0_g77062;
				#else
				half staticSwitch91_g77062 = (Terrain_Height_Raw104_g77062).r;
				#endif
				#ifdef SHADER_API_GLES
				half staticSwitch92_g77062 = temp_output_90_0_g77062;
				#else
				half staticSwitch92_g77062 = staticSwitch91_g77062;
				#endif
				#ifdef SHADER_API_GLES3
				half staticSwitch93_g77062 = temp_output_90_0_g77062;
				#else
				half staticSwitch93_g77062 = staticSwitch92_g77062;
				#endif
				float Terrain_Height_Platform105_g77062 = staticSwitch93_g77062;
				half Terrain_SizeY109_g77062 = _TerrainSize.y;
				half Terrain_PosY110_g77062 = _TerrainPosition.y;
				half lerpResult137_g77062 = lerp( WorldPosition.y , ( ( Terrain_Height_Platform105_g77062 * Terrain_SizeY109_g77062 * 2.0 ) + Terrain_PosY110_g77062 ) , Terrain_InputMode136_g77062);
				float Terrain_Height106_g77062 = lerpResult137_g77062;
				half temp_output_7_0_g77069 = _ElementPosMaxValue;
				half temp_output_9_0_g77069 = ( Terrain_Height106_g77062 - temp_output_7_0_g77069 );
				half lerpResult129_g77062 = lerp( 1.0 , saturate( ( temp_output_9_0_g77069 / ( ( _ElementPosMinValue - temp_output_7_0_g77069 ) + 0.0001 ) ) ) , _ElementPosValue);
				half Blend_Pos131_g77062 = lerpResult129_g77062;
				half temp_output_6_0_g77073 = ( Blend_Mask45_g77062 * Blend_Proj117_g77062 * Blend_Pos131_g77062 );
				half Dummy144_g77062 = ( _MaskingCategory + _MaskingEnd + ( _MaskingTerrainInfo + _MaskingModelInfo ) );
				half temp_output_7_0_g77073 = Dummy144_g77062;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77073 = ( temp_output_6_0_g77073 + temp_output_7_0_g77073 );
				#else
				half staticSwitch14_g77073 = temp_output_6_0_g77073;
				#endif
				half temp_output_6_0_g77084 = 1.0;
				half temp_output_7_0_g77084 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				half staticSwitch14_g77084 = ( temp_output_6_0_g77084 + temp_output_7_0_g77084 );
				#else
				half staticSwitch14_g77084 = temp_output_6_0_g77084;
				#endif
				half Element_Alpha56_g77056 = ( _ElementIntensity * Element_Remap_A74_g77056 * Element_Params_A1737_g77056 * i.ase_color.a * Element_Falloff1883_g77056 * staticSwitch14_g77077 * staticSwitch14_g77073 * staticSwitch14_g77084 );
				half Final_A241_g77056 = Element_Alpha56_g77056;
				half4 appendResult2468_g77056 = (half4(FInal_RGB213_g77056 , Final_A241_g77056));
				half4 Input_Visual94_g77102 = appendResult2468_g77056;
				half clampResult80_g77102 = clamp( (Input_Visual94_g77102).x , 0.1 , 10000.0 );
				half3 appendResult139_g77102 = (half3(clampResult80_g77102 , clampResult80_g77102 , clampResult80_g77102));
				half3 color174 = IsGammaSpace() ? half3( 0.4823529, 0.7450981, 0.1215686 ) : half3( 0.1980693, 0.5149179, 0.01370208 );
				half3 Input_Tint76_g77102 = color174;
				half3 Element_Color47_g77102 = saturate( ( appendResult139_g77102 * Input_Tint76_g77102 ) );
				half4 appendResult131_g77102 = (half4(Element_Color47_g77102 , (Input_Visual94_g77102).w));
				
				
				finalColor = appendResult131_g77102;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "TheVisualEngine.ElementGUI"
	
	Fallback Off
}
/*ASEBEGIN
Version=19908
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;170;-256,-1280;Inherit;False;Element Type Coat;1;;24056;4e3b30f5ed0011b43b960e98331fd8e6;0;0;1;FLOAT;4
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;174;0,-1152;Inherit;False;Constant;_Color11;Color 1;63;0;Create;True;0;0;0;False;0;False;0.4823529,0.7450981,0.1215686,1;0,0,0,0;True;False;0;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;177;0,-1280;Inherit;False;Element Shader;11;;77056;0e972c73cae2ee54ea51acc9738801d0;14,477,1,1778,1,478,0,1824,0,1814,0,145,0,481,0,1784,0,2346,1,1904,1,1907,1,2310,1,2377,1,2311,1;2;1974;FLOAT;0;False;2378;FLOAT;1;False;2;FLOAT4;0;FLOAT4;1779
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;120;-256,-1536;Half;False;Property;_ElementMessage;Element Message;0;0;Create;True;0;0;0;True;1;StyledMessage(Info, Use the Coat Detail elements to control the Detail intensity. Element Texture A and Particle Color A are used as alpha masks., 0, 15);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;141;448,-1536;Inherit;False;Element Compile;-1;;77101;5302407fc6d65554791e558e67d59358;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;176;256,-1152;Inherit;False;Element Visuals;-1;;77102;78cf0f00cfd72824e84597f2db54a76e;1,64,1;2;59;FLOAT4;0,0,0,0;False;77;FLOAT3;1,1,1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;171;320,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;100;1;New Amplify Shader;f4f273c3bb6262d4396be458405e60f9;True;VolumePass1;0;1;VolumePass1;2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;RenderType=Opaque=RenderType;False;False;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;1;LightMode=VolumePass1;True;2;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;172;320,-1280;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;100;1;New Amplify Shader;f4f273c3bb6262d4396be458405e60f9;True;VolumePass2;0;2;VolumePass2;2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;RenderType=Opaque=RenderType;False;False;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;1;LightMode=VolumePass2;True;2;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;142;448,-1280;Half;False;True;-1;2;TheVisualEngine.ElementGUI;100;2;BOXOPHOBIC/The Visual Engine/Elements/Coat Detail;f4f273c3bb6262d4396be458405e60f9;True;VolumePass;0;0;VolumePass;2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;DisableBatching=True=DisableBatching;False;False;0;True;True;2;5;False;;10;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;True;True;False;True;False;False;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;0;False;;True;False;0;False;;0;False;;True;1;False;;True;1;LightMode=VolumePass;True;2;False;0;;0;0;Standard;3;VolumePass1;0;0;VolumePass2;0;0;Vertex Position;1;0;0;4;True;False;False;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;143;448,-1152;Float;False;False;-1;2;AmplifyShaderEditor.MaterialInspector;100;2;New Amplify Shader;f4f273c3bb6262d4396be458405e60f9;True;VisualPass;0;3;VisualPass;2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;RenderType=Opaque=RenderType;False;False;0;True;True;2;5;False;;10;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;0;False;;True;False;0;False;;0;False;;True;1;False;;False;True;2;False;0;;0;0;Standard;0;False;0
WireConnection;177;1974;170;4
WireConnection;176;59;177;1779
WireConnection;176;77;174;0
WireConnection;142;0;177;0
WireConnection;143;0;176;0
ASEEND*/
//CHKSM=B8315AA51F86A17DBD777963214028FC6BC848E2