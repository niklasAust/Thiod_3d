// Made with Amplify Shader Editor v1.9.9.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Effects/CustomRT Drips"
{
    Properties
    {
		[StyledBanner(CustomRT Drips)] _BANNER( "[ BANNER ]", Float ) = 0
		[Space(10)][StyledTextureSingleLine] _WaterTex( "Water Texture", 2D ) = "white" {}
		[Space(10)] _FlowAIntensityValue( "FlowA Intensity", Range( 0, 1 ) ) = 1
		[IntRange] _FlowATillingValue( "FlowA Tilling", Range( 0, 20 ) ) = 1
		_FlowASpeedValue( "FlowA Speed", Range( 0, 4 ) ) = 1
		[Space(10)] _FlowBIntensityValue( "FlowB Intensity", Range( 0, 1 ) ) = 1
		[IntRange] _FlowBTillingValue( "FlowB Tilling", Range( 0, 20 ) ) = 1
		_FlowBSpeedValue( "FlowB Speed", Range( 0, 4 ) ) = 1
		[Space(10)][StyledTextureSingleLine] _DropsMaskTex( "Mask", 2D ) = "white" {}
		[Space(10)] _FlowMaskIntensityValue( "Flow Mask Intensity", Range( 0, 1 ) ) = 1
		_FlowMaskSpeedValue( "Flow Mask Speed", Range( 0, 2 ) ) = 1
		[IntRange] _FlowMaskTillingValue( "Flow Mask Tilling", Range( 1, 10 ) ) = 1
		[StyledRemapSlider] _FlowMaskRemap( "Flow Mask Remap", Vector ) = ( 0, 0, 0, 0 )

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
			UNITY_DECLARE_TEX2D_NOSAMPLER(_WaterTex);
			uniform half _FlowATillingValue;
			uniform half _FlowASpeedValue;
			uniform half4 TVE_TimeParams;
			SamplerState sampler_Linear_Repeat;
			uniform float _FlowAIntensityValue;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_DropsMaskTex);
			uniform half _FlowMaskTillingValue;
			uniform half _FlowMaskSpeedValue;
			SamplerState sampler_DropsMaskTex;
			uniform half4 _FlowMaskRemap;
			uniform half _FlowMaskIntensityValue;
			uniform half _FlowBTillingValue;
			uniform half _FlowBSpeedValue;
			uniform float _FlowBIntensityValue;


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

				float2 temp_output_3_0_g77172 = ( IN.localTexcoord.xy * _FlowATillingValue );
				float mulTime113_g77165 = _Time.y * _FlowASpeedValue;
				float lerpResult128_g77165 = lerp( mulTime113_g77165 , ( ( mulTime113_g77165 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float2 appendResult487 = (float2(0.0 , lerpResult128_g77165));
				float mulTime113_g77164 = _Time.y * _FlowMaskSpeedValue;
				float lerpResult128_g77164 = lerp( mulTime113_g77164 , ( ( mulTime113_g77164 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float2 appendResult518 = (float2(0.0 , lerpResult128_g77164));
				float temp_output_7_0_g77171 = _FlowMaskRemap.x;
				float temp_output_9_0_g77171 = ( SAMPLE_TEXTURE2D( _DropsMaskTex, sampler_DropsMaskTex, ( ( IN.localTexcoord.xy * _FlowMaskTillingValue ) + appendResult518 ) ).r - temp_output_7_0_g77171 );
				float lerpResult514 = lerp( 1.0 , saturate( ( temp_output_9_0_g77171 / ( ( _FlowMaskRemap.y - temp_output_7_0_g77171 ) + 0.0001 ) ) ) , _FlowMaskIntensityValue);
				half Drips_Mask515 = lerpResult514;
				float2 temp_output_3_0_g77175 = ( IN.localTexcoord.xy * _FlowBTillingValue );
				float mulTime113_g77166 = _Time.y * _FlowBSpeedValue;
				float lerpResult128_g77166 = lerp( mulTime113_g77166 , ( ( mulTime113_g77166 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float2 appendResult498 = (float2(0.0 , lerpResult128_g77166));
				half2 WindNoise320 = ( ( ( ((SAMPLE_TEXTURE2D( _WaterTex, sampler_Linear_Repeat, ( temp_output_3_0_g77172 + appendResult487 ) )).ag*2.0 + -1.0) * _FlowAIntensityValue ) * Drips_Mask515 ) + ( ((SAMPLE_TEXTURE2D( _WaterTex, sampler_Linear_Repeat, ( temp_output_3_0_g77175 + appendResult498 ) )).ag*2.0 + -1.0) * _FlowBIntensityValue ) );
				

                float4 finalColor = float4( (WindNoise320*0.5 + 0.5), 0.0 , 0.0 );

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
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;506;-512,6400;Half;False;Property;_FlowMaskSpeedValue;Flow Mask Speed;10;0;Create;False;0;0;0;False;0;False;1;0.4;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;503;-512,6144;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;504;-512,6272;Half;False;Property;_FlowMaskTillingValue;Flow Mask Tilling;11;1;[IntRange];Create;False;0;0;0;False;0;False;1;4;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;505;-240,6400;Inherit;False;Get Global Time;-1;;77164;2b2f842f8071fb945821b595284b5848;0;1;129;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;507;-192,6144;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;296;-1152,4992;Inherit;True;Property;_WaterTex;Water Texture;1;0;Create;False;0;0;0;False;2;Space(10);StyledTextureSingleLine;False;None;1dbdaff51ef624d4cabbecfcea3e75ca;True;white;Auto;Texture2D;False;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;334;-512,5248;Half;False;Property;_FlowASpeedValue;FlowA Speed;4;0;Create;False;0;0;0;False;0;False;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;518;0,6400;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;434;-896,4992;Half;False;WaterTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;299;-512,5056;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;323;-240,5248;Inherit;False;Get Global Time;-1;;77165;2b2f842f8071fb945821b595284b5848;0;1;129;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;300;-512,5168;Half;False;Property;_FlowATillingValue;FlowA Tilling;3;1;[IntRange];Create;False;0;0;0;False;0;False;1;20;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;499;-512,5760;Half;False;Property;_FlowBSpeedValue;FlowB Speed;7;0;Create;False;0;0;0;False;0;False;1;0.5;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;509;256,6144;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;491;-512,5568;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;500;-240,5760;Inherit;False;Get Global Time;-1;;77166;2b2f842f8071fb945821b595284b5848;0;1;129;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;301;-128,5056;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;487;0,5248;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;435;-512,4992;Inherit;False;434;WaterTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;492;-512,5680;Half;False;Property;_FlowBTillingValue;FlowB Tilling;6;1;[IntRange];Create;False;0;0;0;False;0;False;1;4;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;511;512,6144;Inherit;True;Property;_DropsMaskTex;Mask;8;0;Create;False;0;0;0;False;2;Space(10);StyledTextureSingleLine;False;-1;None;56205abbbb6889542acc6fe5e5c4f1f3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.Vector4Node, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;510;512,6400;Half;False;Property;_FlowMaskRemap;Flow Mask Remap;12;0;Create;False;0;0;0;False;1;StyledRemapSlider;False;0,0,0,0;0.4,0.6,5,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;493;-128,5568;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;501;-512,5504;Inherit;False;434;WaterTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;498;0,5760;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;512;896,6144;Inherit;False;Math Remap;-1;;77171;5eda8a2bb94ebef4ab0e43d19291cd8b;3,18,0,14,0,21,1;4;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;19;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;513;512,6592;Half;False;Property;_FlowMaskIntensityValue;Flow Mask Intensity;9;0;Create;False;0;0;0;False;1;Space(10);False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;490;256,4992;Inherit;False;Compute Flow Map;-1;;77172;47b4a92df17039e4d8b606acbee2f25e;1,66,1;5;20;SAMPLER2D;0,0;False;3;FLOAT2;0,0;False;21;FLOAT2;0,0;False;15;FLOAT;0.5;False;68;FLOAT2;0.5,0.5;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;502;256,5504;Inherit;False;Compute Flow Map;-1;;77175;47b4a92df17039e4d8b606acbee2f25e;1,66,1;5;20;SAMPLER2D;0,0;False;3;FLOAT2;0,0;False;21;FLOAT2;0,0;False;15;FLOAT;0.5;False;68;FLOAT2;0.5,0.5;False;1;COLOR;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;315;640,4992;Inherit;False;FLOAT2;3;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;514;1152,6144;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;494;640,5504;Inherit;False;FLOAT2;3;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;314;832,4992;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;2;False;2;FLOAT;-1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;424;832,5120;Inherit;False;Property;_FlowAIntensityValue;FlowA Intensity;2;0;Create;False;0;0;0;False;1;Space(10);False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;515;1408,6144;Half;False;Drips_Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;495;832,5504;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;2;False;2;FLOAT;-1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;423;1152,4992;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;517;1152,5120;Inherit;False;515;Drips_Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;496;832,5632;Inherit;False;Property;_FlowBIntensityValue;FlowB Intensity;5;0;Create;False;0;0;0;False;1;Space(10);False;1;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;497;1152,5504;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;516;1408,4992;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;332;1664,4992;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;320;1920,4992;Half;False;WindNoise;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;321;2560,5248;Inherit;False;320;WindNoise;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;272;3200,5120;Inherit;False;Base Compile;-1;;77178;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;138;2864,5248;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;0.5;False;2;FLOAT;0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;108;-512,4480;Inherit;False;Property;_BANNER;[ BANNER ];0;0;Create;True;0;0;0;True;1;StyledBanner(CustomRT Drips);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;0;3200,5248;Float;False;True;-1;2;TheVisualEngine.HelperGUI;0;16;BOXOPHOBIC/The Visual Engine/Effects/CustomRT Drips;32120270d1b3a8746af2aca8bc749736;True;Custom RT Update;0;0;Custom RT Update;1;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;0;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;0;;0;0;Standard;0;0;1;True;False;;True;0
WireConnection;505;129;506;0
WireConnection;507;0;503;0
WireConnection;507;1;504;0
WireConnection;518;1;505;0
WireConnection;434;0;296;0
WireConnection;323;129;334;0
WireConnection;509;0;507;0
WireConnection;509;1;518;0
WireConnection;500;129;499;0
WireConnection;301;0;299;0
WireConnection;301;1;300;0
WireConnection;487;1;323;0
WireConnection;511;1;509;0
WireConnection;493;0;491;0
WireConnection;493;1;492;0
WireConnection;498;1;500;0
WireConnection;512;6;511;1
WireConnection;512;7;510;1
WireConnection;512;8;510;2
WireConnection;490;20;435;0
WireConnection;490;3;301;0
WireConnection;490;68;487;0
WireConnection;502;20;501;0
WireConnection;502;3;493;0
WireConnection;502;68;498;0
WireConnection;315;0;490;0
WireConnection;514;1;512;0
WireConnection;514;2;513;0
WireConnection;494;0;502;0
WireConnection;314;0;315;0
WireConnection;515;0;514;0
WireConnection;495;0;494;0
WireConnection;423;0;314;0
WireConnection;423;1;424;0
WireConnection;497;0;495;0
WireConnection;497;1;496;0
WireConnection;516;0;423;0
WireConnection;516;1;517;0
WireConnection;332;0;516;0
WireConnection;332;1;497;0
WireConnection;320;0;332;0
WireConnection;138;0;321;0
WireConnection;0;0;138;0
ASEEND*/
//CHKSM=DE037A00A020761A8F460488BD6D73809273717F