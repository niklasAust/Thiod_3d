// Made with Amplify Shader Editor v1.9.9.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Effects/CustomRT Drops"
{
    Properties
    {
		[StyledBanner(CustomRT Drops)] _BANNER( "[ BANNER ]", Float ) = 0
		[NoScaleOffset][StyledTextureSingleLine] _DropsTex( "Drops Texture", 2D ) = "white" {}
		[Space(10)] _RingsSpeedValue( "Rings Speed", Range( 0, 4 ) ) = 1
		_RingsNormalValue( "Rings Normal", Range( -8, 8 ) ) = 1
		[IntRange] _RingsSinMinValue( "Rings Sin Min", Range( 1, 20 ) ) = 1
		[IntRange] _RingsSinMaxValue( "Rings Sin Max", Range( 1, 20 ) ) = 2
		[Space(10)] _DropsSpeedValue( "Drops Speed", Range( 0, 4 ) ) = 1
		_DropsNormalValue( "Drops Normal", Range( -8, 8 ) ) = 1
		[IntRange] _DropsSinMinValue( "Drops Sin Min", Range( 1, 20 ) ) = 2
		[IntRange] _DropsSinMaxValue( "Drops Sin Max", Range( 1, 20 ) ) = 1
		[IntRange] _DropsTillingValue( "Drops Tilling", Range( 1, 10 ) ) = 6
		[Space(10)][StyledTextureSingleLine] _DropsMaskTex( "Drops Mask", 2D ) = "white" {}
		[Space(10)] _DropsMaskIntensityValue( "Drops Mask Intensity", Range( 0, 1 ) ) = 1
		_DropsMaskSpeedValue( "Drops Mask Speed", Range( 0, 2 ) ) = 1
		[IntRange] _DropsMaskTillingValue( "Drops Mask Tilling", Range( 1, 10 ) ) = 1
		[StyledRemapSlider] _DropsMaskRemap( "Drops Mask Remap", Vector ) = ( 0, 0, 0, 0 )
		[Space(10)][StyledTextureSingleLine] _WaterTex( "Water Texture", 2D ) = "white" {}
		[Space(10)] _WaterRipplesIntensityValue( "Water Ripples Intensity", Range( 0, 1 ) ) = 1
		[IntRange] _WaterRipplesTillingValue( "Water Ripples Tilling", Range( 0, 20 ) ) = 20
		_WaterRipplesSpeedValue( "Water Ripples Speed", Range( 0, 4 ) ) = 1
		[Space(10)] _WaterMotionIntensityValue( "Water Motion Intensity", Range( 0, 1 ) ) = 1
		[IntRange] _WaterMotionTillingValue( "Water Motion Tilling", Range( 1, 20 ) ) = 2
		_WaterMotionSpeedValue( "Water Motion Speed", Range( 0, 4 ) ) = 1

    }

	SubShader
	{
		LOD 0

		

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZClip True
		ZTest LEqual
		Offset 0 , 0
		

		
        Pass
        {
			Name "Custom RT Update"
            CGPROGRAM
            #define ASE_VERSION 19908
            #define ASE_USING_SAMPLING_MACROS 1

            #include "UnityCustomRenderTexture.cginc"
            #pragma vertex ASECustomRenderTextureVertexShader
            #pragma fragment frag
            #pragma target 3.0

			#include "UnityShaderVariables.cginc"
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
			#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
			#else//ASE Sampling Macros
			#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
			#endif//ASE Sampling Macros
			


			struct ase_appdata_customrendertexture
			{
				uint vertexID : SV_VertexID;
				
			};

			struct ase_v2f_customrendertexture
			{
				float4 vertex           : SV_POSITION;
				float3 localTexcoord    : TEXCOORD0;    // Texcoord local to the update zone (== globalTexcoord if no partial update zone is specified)
				float3 globalTexcoord   : TEXCOORD1;    // Texcoord relative to the complete custom texture
				uint primitiveID        : TEXCOORD2;    // Index of the update zone (correspond to the index in the updateZones of the Custom Texture)
				float3 position         : TEXCOORD3;    // For cube textures, position of the pixel being rendered in the cubemap
				
			};

			uniform float _BANNER;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_DropsTex);
			SamplerState sampler_DropsTex;
			uniform half4 TVE_TimeParams;
			uniform half _RingsSpeedValue;
			uniform half _RingsSinMinValue;
			uniform half _RingsSinMaxValue;
			uniform half _RingsNormalValue;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_WaterTex);
			uniform half _WaterRipplesTillingValue;
			uniform half _WaterRipplesSpeedValue;
			SamplerState sampler_Linear_Repeat;
			uniform float _WaterRipplesIntensityValue;
			uniform half _WaterMotionTillingValue;
			uniform half4 TVE_WindParams;
			uniform half TVE_IsEnabled;
			uniform half _WaterMotionSpeedValue;
			uniform half4 TVE_MotionTimeParams;
			uniform half4 TVE_WIndEditor;
			uniform float _WaterMotionIntensityValue;
			uniform half _DropsTillingValue;
			uniform half _DropsSpeedValue;
			uniform half _DropsSinMinValue;
			uniform half _DropsSinMaxValue;
			uniform half _DropsNormalValue;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_DropsMaskTex);
			uniform half _DropsMaskTillingValue;
			uniform half _DropsMaskSpeedValue;
			SamplerState sampler_DropsMaskTex;
			uniform half4 _DropsMaskRemap;
			uniform half _DropsMaskIntensityValue;


			float3 CustomRenderTextureComputeCubePosition( float2 globalTexcoord )
			{
				float2 xy = globalTexcoord * 2.0 - 1.0;
				float3 position;
				if ( _CustomRenderTextureCubeFace == 0.0 )
				{
					position = float3( 1.0, -xy.y, -xy.x );
				}
				else if ( _CustomRenderTextureCubeFace == 1.0 )
				{
					position = float3( -1.0, -xy.y, xy.x );
				}
				else if ( _CustomRenderTextureCubeFace == 2.0 )
				{
					position = float3( xy.x, 1.0, xy.y );
				}
				else if ( _CustomRenderTextureCubeFace == 3.0 )
				{
					position = float3( xy.x, -1.0, -xy.y );
				}
				else if ( _CustomRenderTextureCubeFace == 4.0 )
				{
					position = float3( xy.x, -xy.y, 1.0 );
				}
				else if ( _CustomRenderTextureCubeFace == 5.0 )
				{
					position = float3( -xy.x, -xy.y, -1.0 );
				}
				return position;
			}

			ase_v2f_customrendertexture ASECustomRenderTextureVertexShader( ase_appdata_customrendertexture IN  )
			{
				ase_v2f_customrendertexture OUT;

				

			#if UNITY_UV_STARTS_AT_TOP
				const float2 vertexPositions[6] =
				{
					{ -1.0f,  1.0f },
					{ -1.0f, -1.0f },
					{  1.0f, -1.0f },
					{  1.0f,  1.0f },
					{ -1.0f,  1.0f },
					{  1.0f, -1.0f }
				};

				const float2 texCoords[6] =
				{
					{ 0.0f, 0.0f },
					{ 0.0f, 1.0f },
					{ 1.0f, 1.0f },
					{ 1.0f, 0.0f },
					{ 0.0f, 0.0f },
					{ 1.0f, 1.0f }
				};
			#else
				const float2 vertexPositions[6] =
				{
					{  1.0f,  1.0f },
					{ -1.0f, -1.0f },
					{ -1.0f,  1.0f },
					{ -1.0f, -1.0f },
					{  1.0f,  1.0f },
					{  1.0f, -1.0f }
				};

				const float2 texCoords[6] =
				{
					{ 1.0f, 1.0f },
					{ 0.0f, 0.0f },
					{ 0.0f, 1.0f },
					{ 0.0f, 0.0f },
					{ 1.0f, 1.0f },
					{ 1.0f, 0.0f }
				};
			#endif

				uint primitiveID = IN.vertexID / 6;
				uint vertexID = IN.vertexID % 6;
				float3 updateZoneCenter = CustomRenderTextureCenters[primitiveID].xyz;
				float3 updateZoneSize = CustomRenderTextureSizesAndRotations[primitiveID].xyz;
				float rotation = CustomRenderTextureSizesAndRotations[primitiveID].w * UNITY_PI / 180.0f;

			#if !UNITY_UV_STARTS_AT_TOP
				rotation = -rotation;
			#endif

				// Normalize rect if needed
				if (CustomRenderTextureUpdateSpace > 0.0) // Pixel space
				{
					// Normalize xy because we need it in clip space.
					updateZoneCenter.xy /= _CustomRenderTextureInfo.xy;
					updateZoneSize.xy /= _CustomRenderTextureInfo.xy;
				}
				else // normalized space
				{
					// Un-normalize depth because we need actual slice index for culling
					updateZoneCenter.z *= _CustomRenderTextureInfo.z;
					updateZoneSize.z *= _CustomRenderTextureInfo.z;
				}

				// Compute rotation

				// Compute quad vertex position
				float2 clipSpaceCenter = updateZoneCenter.xy * 2.0 - 1.0;
				float2 pos = vertexPositions[vertexID] * updateZoneSize.xy;
				pos = CustomRenderTextureRotate2D(pos, rotation);
				pos.x += clipSpaceCenter.x;
			#if UNITY_UV_STARTS_AT_TOP
				pos.y += clipSpaceCenter.y;
			#else
				pos.y -= clipSpaceCenter.y;
			#endif

				// For 3D texture, cull quads outside of the update zone
				// This is neeeded in additional to the preliminary minSlice/maxSlice done on the CPU because update zones can be disjointed.
				// ie: slices [1..5] and [10..15] for two differents zones so we need to cull out slices 0 and [6..9]
				if (CustomRenderTextureIs3D > 0.0)
				{
					int minSlice = (int)(updateZoneCenter.z - updateZoneSize.z * 0.5);
					int maxSlice = minSlice + (int)updateZoneSize.z;
					if (_CustomRenderTexture3DSlice < minSlice || _CustomRenderTexture3DSlice >= maxSlice)
					{
						pos.xy = float2(1000.0, 1000.0); // Vertex outside of ncs
					}
				}

				OUT.vertex = float4(pos, UNITY_NEAR_CLIP_VALUE, 1.0);
				OUT.primitiveID = asuint(CustomRenderTexturePrimitiveIDs[primitiveID]);
				OUT.localTexcoord = float3(texCoords[vertexID], CustomRenderTexture3DTexcoordW);
				OUT.globalTexcoord = float3(pos.xy * 0.5 + 0.5, CustomRenderTexture3DTexcoordW);
			#if UNITY_UV_STARTS_AT_TOP
				OUT.globalTexcoord.y = 1.0 - OUT.globalTexcoord.y;
			#endif
				OUT.position = CustomRenderTextureComputeCubePosition( OUT.globalTexcoord.xy );
				return OUT;
			}

            float4 frag( ase_v2f_customrendertexture IN  ) : COLOR
            {
				half3 PositionWS = IN.position;
				half3 NormalWS = normalize( IN.position );

				half2 Rings_CoordA184 = IN.localTexcoord.xy;
				float4 tex2DNode57_g77174 = SAMPLE_TEXTURE2D( _DropsTex, sampler_DropsTex, Rings_CoordA184 );
				float temp_output_66_0_g77174 = (tex2DNode57_g77174).b;
				half Rain_RippleHeight68_g77174 = temp_output_66_0_g77174;
				half Rain_RippleVariation59_g77174 = (tex2DNode57_g77174).a;
				float lerpResult128_g77168 = lerp( _Time.y , ( ( _Time.y * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float temp_output_171_0 = ( lerpResult128_g77168 * _RingsSpeedValue );
				half Rings_SpeedA190 = temp_output_171_0;
				half Rain_RippleFrac67_g77174 = frac( ( Rain_RippleVariation59_g77174 + Rings_SpeedA190 ) );
				half Rain_TimeFrac74_g77174 = ( ( Rain_RippleFrac67_g77174 - 1.0 ) + Rain_RippleHeight68_g77174 );
				float clampResult79_g77174 = clamp( ( Rain_TimeFrac74_g77174 * _RingsSinMinValue ) , 0.0 , _RingsSinMaxValue );
				half Rain_RingsFactor88_g77174 = ( ( Rain_RippleHeight68_g77174 * Rain_RippleHeight68_g77174 * Rain_RippleHeight68_g77174 ) * sin( ( clampResult79_g77174 * UNITY_PI ) ) );
				float2 temp_output_85_0_g77174 = (tex2DNode57_g77174).rg;
				half2 Rain_RippleNormal87_g77174 = temp_output_85_0_g77174;
				half2 Wetness_Normal102_g77174 = ( Rain_RingsFactor88_g77174 * ( (Rain_RippleNormal87_g77174*2.0 + -1.0) * _RingsNormalValue ) );
				half2 Rings_CoordB186 = ( IN.localTexcoord.xy + float2( 0.6,0.6 ) );
				float4 tex2DNode57_g77176 = SAMPLE_TEXTURE2D( _DropsTex, sampler_DropsTex, Rings_CoordB186 );
				float temp_output_66_0_g77176 = (tex2DNode57_g77176).b;
				half Rain_RippleHeight68_g77176 = temp_output_66_0_g77176;
				half Rain_RippleVariation59_g77176 = (tex2DNode57_g77176).a;
				half Rings_SpeedB251 = ( temp_output_171_0 + 0.4567 );
				half Rain_RippleFrac67_g77176 = frac( ( Rain_RippleVariation59_g77176 + Rings_SpeedB251 ) );
				half Rain_TimeFrac74_g77176 = ( ( Rain_RippleFrac67_g77176 - 1.0 ) + Rain_RippleHeight68_g77176 );
				float clampResult79_g77176 = clamp( ( Rain_TimeFrac74_g77176 * _RingsSinMinValue ) , 0.0 , _RingsSinMaxValue );
				half Rain_RingsFactor88_g77176 = ( ( Rain_RippleHeight68_g77176 * Rain_RippleHeight68_g77176 * Rain_RippleHeight68_g77176 ) * sin( ( clampResult79_g77176 * UNITY_PI ) ) );
				float2 temp_output_85_0_g77176 = (tex2DNode57_g77176).rg;
				half2 Rain_RippleNormal87_g77176 = temp_output_85_0_g77176;
				half2 Wetness_Normal102_g77176 = ( Rain_RingsFactor88_g77176 * ( (Rain_RippleNormal87_g77176*2.0 + -1.0) * _RingsNormalValue ) );
				float2 temp_output_3_0_g77164 = ( IN.localTexcoord.xy * _WaterRipplesTillingValue );
				half2 Rings_Dir343 = ( (temp_output_85_0_g77174*2.0 + -1.0) + (temp_output_85_0_g77176*2.0 + -1.0) );
				float2 temp_output_21_0_g77164 = -Rings_Dir343;
				float mulTime113_g77162 = _Time.y * _WaterRipplesSpeedValue;
				float lerpResult128_g77162 = lerp( mulTime113_g77162 , ( ( mulTime113_g77162 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float temp_output_15_0_g77164 = lerpResult128_g77162;
				float temp_output_23_0_g77164 = frac( temp_output_15_0_g77164 );
				float4 lerpResult39_g77164 = lerp( SAMPLE_TEXTURE2D( _WaterTex, sampler_Linear_Repeat, ( temp_output_3_0_g77164 + ( temp_output_21_0_g77164 * temp_output_23_0_g77164 ) ) ) , SAMPLE_TEXTURE2D( _WaterTex, sampler_Linear_Repeat, ( temp_output_3_0_g77164 + ( temp_output_21_0_g77164 * frac( ( temp_output_15_0_g77164 + 0.5 ) ) ) ) ) , ( abs( ( temp_output_23_0_g77164 - 0.5 ) ) / 0.5 ));
				float2 temp_output_423_0 = ( ((lerpResult39_g77164).ag*2.0 + -1.0) * _WaterRipplesIntensityValue );
				float2 temp_output_3_0_g77156 = ( IN.localTexcoord.xy * _WaterMotionTillingValue );
				float4 lerpResult130_g77120 = lerp( half4( 0, 1, 1, 0 ) , TVE_WindParams , TVE_IsEnabled);
				float2 temp_output_132_0_g77120 = (lerpResult130_g77120).xy;
				half2 Wind_DirWS311 = -temp_output_132_0_g77120;
				float2 temp_output_21_0_g77156 = Wind_DirWS311;
				float mulTime113_g77155 = _Time.y * _WaterMotionSpeedValue;
				float lerpResult128_g77155 = lerp( mulTime113_g77155 , ( ( mulTime113_g77155 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
				float temp_output_15_0_g77156 = lerpResult128_g77155;
				float temp_output_23_0_g77156 = frac( temp_output_15_0_g77156 );
				float4 lerpResult39_g77156 = lerp( SAMPLE_TEXTURE2D( _WaterTex, sampler_Linear_Repeat, ( temp_output_3_0_g77156 + ( temp_output_21_0_g77156 * temp_output_23_0_g77156 ) ) ) , SAMPLE_TEXTURE2D( _WaterTex, sampler_Linear_Repeat, ( temp_output_3_0_g77156 + ( temp_output_21_0_g77156 * frac( ( temp_output_15_0_g77156 + 0.5 ) ) ) ) ) , ( abs( ( temp_output_23_0_g77156 - 0.5 ) ) / 0.5 ));
				float2 temp_output_3_0_g77159 = IN.localTexcoord.xy;
				float2 temp_output_21_0_g77159 = Wind_DirWS311;
				float mulTime113_g77122 = _Time.y * _WaterMotionSpeedValue;
				float lerpResult128_g77122 = lerp( mulTime113_g77122 , ( ( mulTime113_g77122 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float temp_output_15_0_g77159 = ( lerpResult128_g77122 * 0.2 );
				float temp_output_23_0_g77159 = frac( temp_output_15_0_g77159 );
				float4 lerpResult39_g77159 = lerp( SAMPLE_TEXTURE2D( _WaterTex, sampler_Linear_Repeat, ( temp_output_3_0_g77159 + ( temp_output_21_0_g77159 * temp_output_23_0_g77159 ) ) ) , SAMPLE_TEXTURE2D( _WaterTex, sampler_Linear_Repeat, ( temp_output_3_0_g77159 + ( temp_output_21_0_g77159 * frac( ( temp_output_15_0_g77159 + 0.5 ) ) ) ) ) , ( abs( ( temp_output_23_0_g77159 - 0.5 ) ) / 0.5 ));
				float temp_output_136_0_g77120 = (lerpResult130_g77120).w;
				float lerpResult149_g77120 = lerp( temp_output_136_0_g77120 , saturate( (temp_output_136_0_g77120*TVE_WIndEditor.x + TVE_WIndEditor.y) ) , TVE_WIndEditor.w);
				half WInd_Value310 = lerpResult149_g77120;
				float lerpResult432 = lerp( 0.2 , 1.0 , WInd_Value310);
				float2 temp_output_353_0 = ( max( ((lerpResult39_g77156).ag*2.0 + -1.0), ((lerpResult39_g77159).ag*2.0 + -1.0) ) * lerpResult432 * _WaterMotionIntensityValue );
				half2 WindNoise320 = ( temp_output_423_0 + temp_output_353_0 );
				half2 Rings_Final180 = (( Wetness_Normal102_g77174 + Wetness_Normal102_g77176 + WindNoise320 )*0.5 + 0.5);
				float2 temp_output_201_0 = ( IN.localTexcoord.xy * _DropsTillingValue );
				half2 Drops_CoordA248 = temp_output_201_0;
				float4 tex2DNode57_g77170 = SAMPLE_TEXTURE2D( _DropsTex, sampler_DropsTex, Drops_CoordA248 );
				float temp_output_66_0_g77170 = (tex2DNode57_g77170).b;
				half Rain_RippleHeight68_g77170 = temp_output_66_0_g77170;
				half Rain_RippleVariation59_g77170 = (tex2DNode57_g77170).a;
				float lerpResult128_g77167 = lerp( _Time.y , ( ( _Time.y * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float temp_output_203_0 = ( lerpResult128_g77167 * _DropsSpeedValue );
				half Drops_SpeedA246 = temp_output_203_0;
				half Rain_RippleFrac67_g77170 = frac( ( Rain_RippleVariation59_g77170 + Drops_SpeedA246 ) );
				half Rain_TimeFrac74_g77170 = ( ( Rain_RippleFrac67_g77170 - 1.0 ) + Rain_RippleHeight68_g77170 );
				float clampResult79_g77170 = clamp( ( Rain_TimeFrac74_g77170 * _DropsSinMinValue ) , 0.0 , _DropsSinMaxValue );
				half Rain_RingsFactor88_g77170 = ( ( Rain_RippleHeight68_g77170 * Rain_RippleHeight68_g77170 * Rain_RippleHeight68_g77170 ) * sin( ( clampResult79_g77170 * UNITY_PI ) ) );
				float2 temp_output_85_0_g77170 = (tex2DNode57_g77170).rg;
				half2 Rain_RippleNormal87_g77170 = temp_output_85_0_g77170;
				half2 Wetness_Normal102_g77170 = ( Rain_RingsFactor88_g77170 * ( (Rain_RippleNormal87_g77170*2.0 + -1.0) * _DropsNormalValue ) );
				half2 Drops_CoordB249 = ( temp_output_201_0 + float2( 0.6,0.6 ) );
				float4 tex2DNode57_g77172 = SAMPLE_TEXTURE2D( _DropsTex, sampler_DropsTex, Drops_CoordB249 );
				float temp_output_66_0_g77172 = (tex2DNode57_g77172).b;
				half Rain_RippleHeight68_g77172 = temp_output_66_0_g77172;
				half Rain_RippleVariation59_g77172 = (tex2DNode57_g77172).a;
				half Drops_SpeedB254 = ( temp_output_203_0 + 0.2 );
				half Rain_RippleFrac67_g77172 = frac( ( Rain_RippleVariation59_g77172 + Drops_SpeedB254 ) );
				half Rain_TimeFrac74_g77172 = ( ( Rain_RippleFrac67_g77172 - 1.0 ) + Rain_RippleHeight68_g77172 );
				float clampResult79_g77172 = clamp( ( Rain_TimeFrac74_g77172 * _DropsSinMinValue ) , 0.0 , _DropsSinMaxValue );
				half Rain_RingsFactor88_g77172 = ( ( Rain_RippleHeight68_g77172 * Rain_RippleHeight68_g77172 * Rain_RippleHeight68_g77172 ) * sin( ( clampResult79_g77172 * UNITY_PI ) ) );
				float2 temp_output_85_0_g77172 = (tex2DNode57_g77172).rg;
				half2 Rain_RippleNormal87_g77172 = temp_output_85_0_g77172;
				half2 Wetness_Normal102_g77172 = ( Rain_RingsFactor88_g77172 * ( (Rain_RippleNormal87_g77172*2.0 + -1.0) * _DropsNormalValue ) );
				float lerpResult128_g77163 = lerp( _Time.y , ( ( _Time.y * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float temp_output_7_0_g77169 = _DropsMaskRemap.x;
				float temp_output_9_0_g77169 = ( SAMPLE_TEXTURE2D( _DropsMaskTex, sampler_DropsMaskTex, ( ( IN.localTexcoord.xy * _DropsMaskTillingValue ) + ( lerpResult128_g77163 * _DropsMaskSpeedValue ) ) ).r - temp_output_7_0_g77169 );
				float lerpResult261 = lerp( 1.0 , saturate( ( temp_output_9_0_g77169 / ( ( _DropsMaskRemap.y - temp_output_7_0_g77169 ) + 0.0001 ) ) ) , _DropsMaskIntensityValue);
				half Drops_Mask270 = lerpResult261;
				half2 Drops_Final205 = (( ( Wetness_Normal102_g77170 + Wetness_Normal102_g77172 ) * Drops_Mask270 )*0.5 + 0.5);
				float4 appendResult139 = (float4(Rings_Final180 , Drops_Final205));
				

                float4 finalColor = appendResult139;

				return finalColor;
            }
            ENDCG
		}
    }
	
	CustomEditor "TheVisualEngine.HelperGUI"
	Fallback Off
}
/*ASEBEGIN
Version=19908
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;469;-1792,5504;Inherit;False;Get Global Wind;-1;;77120;bedd4b0cdedc6ee42aedeb9811b5fcae;0;0;2;FLOAT2;144;FLOAT;146
Node;AmplifyShaderEditor.NegateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;437;-1536,5504;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;463;640,2304;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;296;-1152,4992;Inherit;True;Property;_WaterTex;Water Texture;16;0;Create;False;0;0;0;False;2;Space(10);StyledTextureSingleLine;False;None;1dbdaff51ef624d4cabbecfcea3e75ca;True;white;Auto;Texture2D;False;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;311;-1392,5504;Half;False;Wind_DirWS;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;335;-512,6592;Half;False;Property;_WaterMotionSpeedValue;Water Motion Speed;25;0;Create;False;0;0;0;False;0;False;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;325;-512,6336;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;444;-160,7104;Inherit;False;Get Global Time;-1;;77122;2b2f842f8071fb945821b595284b5848;0;1;129;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;326;-512,6448;Half;False;Property;_WaterMotionTillingValue;Water Motion Tilling;24;1;[IntRange];Create;False;0;0;0;False;0;False;2;8;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;343;1024,2304;Half;False;Rings_Dir;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;438;-512,6848;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;436;-512,6272;Inherit;False;434;MotionTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;327;-128,6336;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;441;-512,6784;Inherit;False;434;MotionTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;446;32,7104;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;443;-512,7040;Inherit;False;311;Wind_DirWS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;312;-512,6528;Inherit;False;311;Wind_DirWS;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;299;-512,5056;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;334;-512,5376;Half;False;Property;_WaterRipplesSpeedValue;Water Ripples Speed;21;0;Create;False;0;0;0;False;0;False;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;300;-512,5168;Half;False;Property;_WaterRipplesTillingValue;Water Ripples Tilling;20;1;[IntRange];Create;False;0;0;0;False;0;False;20;20;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;346;-512,5248;Inherit;False;343;Rings_Dir;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;434;-896,4992;Half;False;MotionTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;494;-128,6592;Inherit;False;Get Global Motion Time;-1;;77155;da6e3b339ab8a0646b79248b6ff23cdd;0;1;129;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;324;128,6272;Inherit;False;Compute Flow Map;-1;;77156;47b4a92df17039e4d8b606acbee2f25e;1,66,0;5;20;SAMPLER2D;0,0;False;3;FLOAT2;0,0;False;21;FLOAT2;0,0;False;15;FLOAT;0.5;False;68;FLOAT2;0.5,0.5;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;445;128,6784;Inherit;False;Compute Flow Map;-1;;77159;47b4a92df17039e4d8b606acbee2f25e;1,66,0;5;20;SAMPLER2D;0,0;False;3;FLOAT2;0,0;False;21;FLOAT2;0,0;False;15;FLOAT;0.5;False;68;FLOAT2;0.5,0.5;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;301;-128,5056;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NegateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;347;-128,5248;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;323;-160,5376;Inherit;False;Get Global Time;-1;;77162;2b2f842f8071fb945821b595284b5848;0;1;129;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;435;-512,4992;Inherit;False;434;MotionTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;235;-512,3968;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;238;-512,4096;Half;False;Property;_DropsMaskTillingValue;Drops Mask Tilling;14;1;[IntRange];Create;False;0;0;0;False;0;False;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;240;-512,4224;Inherit;False;Get Global Time;-1;;77163;2b2f842f8071fb945821b595284b5848;0;1;129;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;241;-512,4288;Half;False;Property;_DropsMaskSpeedValue;Drops Mask Speed;13;0;Create;False;0;0;0;False;0;False;1;0.03;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;310;-1392,5568;Half;False;WInd_Value;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;329;384,6272;Inherit;False;FLOAT2;3;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;447;384,6784;Inherit;False;FLOAT2;3;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;298;128,4992;Inherit;False;Compute Flow Map;-1;;77164;47b4a92df17039e4d8b606acbee2f25e;1,66,0;5;20;SAMPLER2D;0,0;False;3;FLOAT2;0,0;False;21;FLOAT2;0,0;False;15;FLOAT;0.5;False;68;FLOAT2;0.5,0.5;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;243;-192,3968;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;242;-192,4224;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;330;640,6272;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;2;False;2;FLOAT;-1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;449;640,6784;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;2;False;2;FLOAT;-1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;318;1024,6528;Inherit;False;310;WInd_Value;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;315;384,4992;Inherit;False;FLOAT2;3;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;245;0,3968;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;202;-512,1152;Inherit;False;Get Global Time;-1;;77167;2b2f842f8071fb945821b595284b5848;0;1;129;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;199;-512,768;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;162;-512,896;Half;False;Property;_DropsTillingValue;Drops Tilling;10;1;[IntRange];Create;False;0;0;0;False;0;False;6;6;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;161;-512,1216;Half;False;Property;_DropsSpeedValue;Drops Speed;6;0;Create;False;0;0;0;False;1;Space(10);False;1;3;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;146;-512,384;Inherit;False;Get Global Time;-1;;77168;2b2f842f8071fb945821b595284b5848;0;1;129;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;169;-512,448;Half;False;Property;_RingsSpeedValue;Rings Speed;2;0;Create;False;0;0;0;False;1;Space(10);False;1;1.5;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;467;896,6272;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;432;1264,6528;Inherit;False;3;0;FLOAT;0.2;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;317;1152,6720;Inherit;False;Property;_WaterMotionIntensityValue;Water Motion Intensity;23;0;Create;False;0;0;0;False;1;Space(10);False;1;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;314;576,4992;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;2;False;2;FLOAT;-1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;424;576,5120;Inherit;False;Property;_WaterRipplesIntensityValue;Water Ripples Intensity;17;0;Create;False;0;0;0;False;1;Space(10);False;1;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;266;256,4224;Half;False;Property;_DropsMaskRemap;Drops Mask Remap;15;0;Create;False;0;0;0;False;1;StyledRemapSlider;False;0,0,0,0;0,0.25,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;234;256,3968;Inherit;True;Property;_DropsMaskTex;Drops Mask;11;0;Create;False;0;0;0;False;2;Space(10);StyledTextureSingleLine;False;-1;None;13cbbb9d5b1a07749b1fa6918940dfe3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;203;-192,1152;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;201;-192,768;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;252;128,896;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.6,0.6;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;253;128,1280;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;171;-192,384;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;106;-512,128;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;187;128,256;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.6,0.6;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;250;128,512;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.4567;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;104;-512,-128;Inherit;True;Property;_DropsTex;Drops Texture;1;1;[NoScaleOffset];Create;False;0;0;0;False;1;StyledTextureSingleLine;False;None;226a76398d819eb40b921c0023fa0af2;False;white;Auto;Texture2D;False;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;353;1616,6272;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;423;896,4992;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;268;640,3968;Inherit;False;Math Remap;-1;;77169;5eda8a2bb94ebef4ab0e43d19291cd8b;3,18,0,14,0,21,1;4;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;19;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;262;256,4416;Half;False;Property;_DropsMaskIntensityValue;Drops Mask Intensity;12;0;Create;False;0;0;0;False;1;Space(10);False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;246;320,1152;Half;False;Drops_SpeedA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;248;320,768;Half;False;Drops_CoordA;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;254;320,1280;Half;False;Drops_SpeedB;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;249;320,896;Half;False;Drops_CoordB;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;163;320,-128;Half;False;DropsTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;190;320,384;Half;False;Rings_SpeedA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;184;320,128;Half;False;Rings_CoordA;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;186;320,256;Half;False;Rings_CoordB;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;251;320,512;Half;False;Rings_SpeedB;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;332;1232,5248;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;261;896,3968;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;158;-512,3584;Half;False;Property;_DropsSinMinValue;Drops Sin Min;8;1;[IntRange];Create;False;0;0;0;False;0;False;2;3;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;159;-512,3648;Half;False;Property;_DropsSinMaxValue;Drops Sin Max;9;1;[IntRange];Create;False;0;0;0;False;0;False;1;1;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;198;-512,2944;Inherit;False;163;DropsTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;247;-512,3072;Inherit;False;246;Drops_SpeedA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;160;-512,3712;Half;False;Property;_DropsNormalValue;Drops Normal;7;0;Create;False;0;0;0;False;0;False;1;1;-8;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;255;-512,3008;Inherit;False;248;Drops_CoordA;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;257;-512,3200;Inherit;False;163;DropsTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;258;-512,3264;Inherit;False;249;Drops_CoordB;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;259;-512,3328;Inherit;False;254;Drops_SpeedB;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;168;-512,2624;Half;False;Property;_RingsSinMaxValue;Rings Sin Max;5;1;[IntRange];Create;False;0;0;0;False;0;False;2;2;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;179;-512,2688;Half;False;Property;_RingsNormalValue;Rings Normal;3;0;Create;False;0;0;0;False;0;False;1;0.5;-8;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;188;-512,2112;Inherit;False;184;Rings_CoordA;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;164;-512,2048;Inherit;False;163;DropsTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;192;-512,2176;Inherit;False;190;Rings_SpeedA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;167;-512,2560;Half;False;Property;_RingsSinMinValue;Rings Sin Min;4;1;[IntRange];Create;False;0;0;0;False;0;False;1;10;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;193;-512,2432;Inherit;False;251;Rings_SpeedB;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;195;-512,2368;Inherit;False;186;Rings_CoordB;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;191;-512,2304;Inherit;False;163;DropsTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;320;1504,5296;Half;False;WindNoise;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;270;1152,3968;Half;False;Drops_Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;460;256,2944;Inherit;False;Compute Rain Drops;-1;;77170;ab995bbff019b914ea1ee54bf23794b6;0;7;113;SAMPLER2D;0;False;114;FLOAT2;0,0;False;121;FLOAT;0;False;132;FLOAT;0;False;123;FLOAT;0;False;124;FLOAT;0;False;125;FLOAT;0;False;3;FLOAT2;0;FLOAT2;133;FLOAT;134
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;461;256,3200;Inherit;False;Compute Rain Drops;-1;;77172;ab995bbff019b914ea1ee54bf23794b6;0;7;113;SAMPLER2D;0;False;114;FLOAT2;0,0;False;121;FLOAT;0;False;132;FLOAT;0;False;123;FLOAT;0;False;124;FLOAT;0;False;125;FLOAT;0;False;3;FLOAT2;0;FLOAT2;133;FLOAT;134
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;271;576,3072;Inherit;False;270;Drops_Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;459;256,2048;Inherit;False;Compute Rain Drops;-1;;77174;ab995bbff019b914ea1ee54bf23794b6;0;7;113;SAMPLER2D;0;False;114;FLOAT2;0,0;False;121;FLOAT;0;False;132;FLOAT;0;False;123;FLOAT;0;False;124;FLOAT;0;False;125;FLOAT;0;False;3;FLOAT2;0;FLOAT2;133;FLOAT;134
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;462;256,2304;Inherit;False;Compute Rain Drops;-1;;77176;ab995bbff019b914ea1ee54bf23794b6;0;7;113;SAMPLER2D;0;False;114;FLOAT2;0,0;False;121;FLOAT;0;False;132;FLOAT;0;False;123;FLOAT;0;False;124;FLOAT;0;False;125;FLOAT;0;False;3;FLOAT2;0;FLOAT2;133;FLOAT;134
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;321;256,2560;Inherit;False;320;WindNoise;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;473;576,2944;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;233;768,2944;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;135;640,2048;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;138;1024,2048;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;0.5;False;2;FLOAT;0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;204;1280,2944;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;0.5;False;2;FLOAT;0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;180;1344,2048;Half;False;Rings_Final;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;205;1600,2944;Half;False;Drops_Final;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;196;2304,2048;Inherit;False;180;Rings_Final;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;206;2304,2112;Inherit;False;205;Drops_Final;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;470;1792,6272;Half;False;Noise_Wind;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;474;1152,4992;Half;False;Noise_Rings;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;475;-512,5696;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;487;-512,5888;Inherit;False;-1;;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;476;-512,5632;Inherit;False;434;MotionTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;477;-128,5696;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NegateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;478;-128,5888;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;479;-160,6016;Inherit;False;Get Global Time;-1;;77178;2b2f842f8071fb945821b595284b5848;0;1;129;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;480;128,5632;Inherit;False;Compute Flow Map;-1;;77179;47b4a92df17039e4d8b606acbee2f25e;1,66,0;5;20;SAMPLER2D;0,0;False;3;FLOAT2;0,0;False;21;FLOAT2;0,0;False;15;FLOAT;0.5;False;68;FLOAT2;0.5,0.5;False;1;COLOR;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;481;384,5632;Inherit;False;FLOAT2;3;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;482;576,5632;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;2;False;2;FLOAT;-1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;493;585.8488,5829.448;Inherit;False;Constant;_Float1;Float 1;26;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;483;896,5632;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;491;1152,5632;Half;False;Noise_Drops;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;108;-512,-256;Inherit;False;Property;_BANNER;[ BANNER ];0;0;Create;True;0;0;0;True;1;StyledBanner(CustomRT Drops);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;139;2560,2048;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;272;2816,1920;Inherit;False;Base Compile;-1;;77182;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;442;-128,6848;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;484;-512,6016;Half;False;Property;_WaterRipplesSpeedValue1;Water Ripples Speed;22;0;Create;False;0;0;0;False;0;False;1;6;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;485;-512,5808;Half;False;Property;_WaterRipplesTillingValue1;Water Ripples Tilling;19;1;[IntRange];Create;False;0;0;0;False;0;False;20;6;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;486;576,5760;Inherit;False;Property;_WaterRipplesIntensityValue1;Water Ripples Intensity;18;0;Create;False;0;0;0;False;1;Space(10);False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;0;2816,2048;Float;False;True;-1;2;TheVisualEngine.HelperGUI;0;16;BOXOPHOBIC/The Visual Engine/Effects/CustomRT Drops;32120270d1b3a8746af2aca8bc749736;True;Custom RT Update;0;0;Custom RT Update;1;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;0;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;0;;0;0;Standard;0;0;1;True;False;;True;0
WireConnection;437;0;469;144
WireConnection;463;0;459;133
WireConnection;463;1;462;133
WireConnection;311;0;437;0
WireConnection;444;129;335;0
WireConnection;343;0;463;0
WireConnection;327;0;325;0
WireConnection;327;1;326;0
WireConnection;446;0;444;0
WireConnection;434;0;296;0
WireConnection;494;129;335;0
WireConnection;324;20;436;0
WireConnection;324;3;327;0
WireConnection;324;21;312;0
WireConnection;324;15;494;0
WireConnection;445;20;441;0
WireConnection;445;3;438;0
WireConnection;445;21;443;0
WireConnection;445;15;446;0
WireConnection;301;0;299;0
WireConnection;301;1;300;0
WireConnection;347;0;346;0
WireConnection;323;129;334;0
WireConnection;310;0;469;146
WireConnection;329;0;324;0
WireConnection;447;0;445;0
WireConnection;298;20;435;0
WireConnection;298;3;301;0
WireConnection;298;21;347;0
WireConnection;298;15;323;0
WireConnection;243;0;235;0
WireConnection;243;1;238;0
WireConnection;242;0;240;0
WireConnection;242;1;241;0
WireConnection;330;0;329;0
WireConnection;449;0;447;0
WireConnection;315;0;298;0
WireConnection;245;0;243;0
WireConnection;245;1;242;0
WireConnection;467;0;330;0
WireConnection;467;1;449;0
WireConnection;432;2;318;0
WireConnection;314;0;315;0
WireConnection;234;1;245;0
WireConnection;203;0;202;0
WireConnection;203;1;161;0
WireConnection;201;0;199;0
WireConnection;201;1;162;0
WireConnection;252;0;201;0
WireConnection;253;0;203;0
WireConnection;171;0;146;0
WireConnection;171;1;169;0
WireConnection;187;0;106;0
WireConnection;250;0;171;0
WireConnection;353;0;467;0
WireConnection;353;1;432;0
WireConnection;353;2;317;0
WireConnection;423;0;314;0
WireConnection;423;1;424;0
WireConnection;268;6;234;1
WireConnection;268;7;266;1
WireConnection;268;8;266;2
WireConnection;246;0;203;0
WireConnection;248;0;201;0
WireConnection;254;0;253;0
WireConnection;249;0;252;0
WireConnection;163;0;104;0
WireConnection;190;0;171;0
WireConnection;184;0;106;0
WireConnection;186;0;187;0
WireConnection;251;0;250;0
WireConnection;332;0;423;0
WireConnection;332;1;353;0
WireConnection;261;1;268;0
WireConnection;261;2;262;0
WireConnection;320;0;332;0
WireConnection;270;0;261;0
WireConnection;460;113;198;0
WireConnection;460;114;255;0
WireConnection;460;121;247;0
WireConnection;460;123;158;0
WireConnection;460;124;159;0
WireConnection;460;125;160;0
WireConnection;461;113;257;0
WireConnection;461;114;258;0
WireConnection;461;121;259;0
WireConnection;461;123;158;0
WireConnection;461;124;159;0
WireConnection;461;125;160;0
WireConnection;459;113;164;0
WireConnection;459;114;188;0
WireConnection;459;121;192;0
WireConnection;459;123;167;0
WireConnection;459;124;168;0
WireConnection;459;125;179;0
WireConnection;462;113;191;0
WireConnection;462;114;195;0
WireConnection;462;121;193;0
WireConnection;462;123;167;0
WireConnection;462;124;168;0
WireConnection;462;125;179;0
WireConnection;473;0;460;0
WireConnection;473;1;461;0
WireConnection;233;0;473;0
WireConnection;233;1;271;0
WireConnection;135;0;459;0
WireConnection;135;1;462;0
WireConnection;135;2;321;0
WireConnection;138;0;135;0
WireConnection;204;0;233;0
WireConnection;180;0;138;0
WireConnection;205;0;204;0
WireConnection;470;0;353;0
WireConnection;474;0;423;0
WireConnection;477;0;475;0
WireConnection;477;1;300;0
WireConnection;478;0;487;0
WireConnection;479;129;334;0
WireConnection;480;20;476;0
WireConnection;480;3;477;0
WireConnection;480;21;478;0
WireConnection;480;15;479;0
WireConnection;481;0;480;0
WireConnection;482;0;481;0
WireConnection;483;0;482;0
WireConnection;483;1;493;0
WireConnection;491;0;483;0
WireConnection;139;0;196;0
WireConnection;139;2;206;0
WireConnection;442;0;438;0
WireConnection;0;0;139;0
ASEEND*/
//CHKSM=53DE273823A327D8ABF28BE297287A06283FEF3B