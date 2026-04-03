Shader "Custom/SnowCoverURP"
{
    Properties
    {
        [MainTexture] _BaseMap("Base Map", 2D) = "white" {}
        [MainColor] _BaseColor("Base Color", Color) = (1,1,1,1)
        [NoScaleOffset] _BumpMap("Normal Map", 2D) = "bump" {}
        _BumpScale("Normal Strength", Range(0, 2)) = 1
        [NoScaleOffset] _OcclusionMap("Occlusion", 2D) = "white" {}
        _OcclusionStrength("Occlusion Strength", Range(0, 1)) = 1
        _Smoothness("Smoothness", Range(0, 1)) = 0.2
        _Metallic("Metallic", Range(0, 1)) = 0

        [Toggle(_ALPHATEST_ON)] _AlphaClip("Alpha Clip", Float) = 0
        _Cutoff("Alpha Cutoff", Range(0, 1)) = 0.5

        [Header(Snow)]
        [Toggle(_SNOW_ON)] _SnowEnabled("Enable Snow", Float) = 1
        [Toggle(_USE_GLOBAL_SNOW)] _UseGlobalSnow("Use Global Snow", Float) = 1
        _SnowColor("Snow Color", Color) = (1,1,1,1)
        _SnowMap("Snow Detail", 2D) = "white" {}
        _SnowTiling("Snow Tiling", Float) = 1
        _SnowCoverage("Slope Coverage", Range(0, 1)) = 0.68
        _SnowBlend("Slope Blend", Range(0.001, 0.5)) = 0.12
        _SnowDirection("Snow Direction", Vector) = (0,1,0,0)
        _SnowHeightStart("Height Start", Float) = -1000
        _SnowHeightBlend("Height Blend", Float) = 1
        _SnowTextureInfluence("Texture Influence", Range(0, 1)) = 0.2
        _SnowNoiseScale("Noise Scale", Range(0.001, 1)) = 0.06
        _SnowNoiseStrength("Noise Strength", Range(0, 1)) = 0.12
        _SnowNormalFlatten("Normal Flatten", Range(0, 1)) = 0.65
        _SnowSmoothness("Snow Smoothness", Range(0, 1)) = 0.7
        _SnowEmissionColor("Snow Emission Color", Color) = (0.75,0.85,1,1)
        _SnowEmissionStrength("Snow Emission Strength", Range(0, 1)) = 0.02

        [Toggle(_SNOW_DISPLACE_ON)] _SnowDisplace("Displace Vertices", Float) = 0
        _SnowDisplaceAmount("Displace Amount", Range(0, 0.25)) = 0.025
    }

    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
            "RenderPipeline"="UniversalPipeline"
            "Queue"="Geometry"
        }
        LOD 300

        Pass
        {
            Name "ForwardLit"
            Tags { "LightMode"="UniversalForward" }

            HLSLPROGRAM
            #pragma target 3.0
            #pragma vertex vert
            #pragma fragment frag

            #pragma shader_feature_local_fragment _ALPHATEST_ON

            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
            #pragma multi_compile_fog
            #pragma multi_compile_fragment _ _LIGHT_LAYERS
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
            #pragma multi_compile_fragment _ _CLUSTER_LIGHT_LOOP

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SurfaceData.hlsl"

            CBUFFER_START(UnityPerMaterial)
                float4 _BaseColor;
                float4 _BaseMap_ST;
                float _BumpScale;
                float _OcclusionStrength;
                float _Smoothness;
                float _Metallic;
                float _AlphaClip;
                float _Cutoff;

                float _SnowEnabled;
                float _UseGlobalSnow;
                float4 _SnowColor;
                float4 _SnowDirection;
                float4 _SnowEmissionColor;
                float _SnowTiling;
                float _SnowCoverage;
                float _SnowBlend;
                float _SnowHeightStart;
                float _SnowHeightBlend;
                float _SnowTextureInfluence;
                float _SnowNoiseScale;
                float _SnowNoiseStrength;
                float _SnowNormalFlatten;
                float _SnowSmoothness;
                float _SnowEmissionStrength;
                float _SnowDisplace;
                float _SnowDisplaceAmount;
            CBUFFER_END

            float4 _GlobalSnowColor;
            float4 _GlobalSnowDirection;
            float _GlobalSnowEnabled;
            float _GlobalSnowAmount;
            float _GlobalSnowHeightOffset;
            float _GlobalSnowEmissionMultiplier;

            TEXTURE2D(_BaseMap);
            SAMPLER(sampler_BaseMap);
            TEXTURE2D(_BumpMap);
            SAMPLER(sampler_BumpMap);
            TEXTURE2D(_OcclusionMap);
            SAMPLER(sampler_OcclusionMap);
            TEXTURE2D(_SnowMap);
            SAMPLER(sampler_SnowMap);

            struct Attributes
            {
                float4 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                float2 uv : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 positionWS : TEXCOORD1;
                half3 normalWS : TEXCOORD2;
                half4 tangentWS : TEXCOORD3;
                half fogFactor : TEXCOORD4;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };

            float Hash11(float2 p)
            {
                float3 p3 = frac(float3(p.xyx) * 0.1031);
                p3 += dot(p3, p3.yzx + 33.33);
                return frac((p3.x + p3.y) * p3.z);
            }

            struct SnowSettings
            {
                float enabled;
                float amount;
                float3 directionWS;
                float4 color;
                float heightStart;
                float emissionMultiplier;
            };

            SnowSettings GetSnowSettings()
            {
                SnowSettings settings;
                settings.enabled = 1.0;
                settings.amount = 1.0;
                settings.directionWS = SafeNormalize(_SnowDirection.xyz);
                settings.color = _SnowColor;
                settings.heightStart = _SnowHeightStart;
                settings.emissionMultiplier = 1.0;

                if (_SnowEnabled < 0.5)
                {
                    settings.enabled = 0.0;
                    return settings;
                }

                if (_UseGlobalSnow > 0.5)
                {
                    settings.enabled = _GlobalSnowEnabled;
                    settings.amount = saturate(_GlobalSnowAmount);
                    settings.directionWS = length(_GlobalSnowDirection.xyz) > 0.0001 ? SafeNormalize(_GlobalSnowDirection.xyz) : settings.directionWS;
                    settings.color = _GlobalSnowColor;
                    settings.heightStart = _SnowHeightStart + _GlobalSnowHeightOffset;
                    settings.emissionMultiplier = max(0.0, _GlobalSnowEmissionMultiplier);
                }

                return settings;
            }

            float ComputeSnowMask(float3 positionWS, float3 normalWS, float2 uv, SnowSettings settings)
            {
                if (_SnowEnabled < 0.5)
                {
                    return 0;
                }

                if (settings.enabled < 0.5 || settings.amount <= 0.0001)
                {
                    return 0;
                }

                float3 snowDirWS = settings.directionWS;
                float threshold = saturate(1.0 - _SnowCoverage);
                float slope = saturate(dot(SafeNormalize(normalWS), snowDirWS));
                float slopeMask = smoothstep(threshold - _SnowBlend, threshold + _SnowBlend, slope);
                float heightMask = smoothstep(settings.heightStart - _SnowHeightBlend, settings.heightStart + _SnowHeightBlend, positionWS.y);
                float snowTex = SAMPLE_TEXTURE2D_LOD(_SnowMap, sampler_SnowMap, uv * _SnowTiling, 0).r;
                float textureMask = lerp(1.0, snowTex, _SnowTextureInfluence);
                float noise = lerp(1.0, Hash11(positionWS.xz * _SnowNoiseScale), _SnowNoiseStrength);
                return saturate(slopeMask * heightMask * textureMask * noise) * settings.amount;
            }

            Varyings vert(Attributes IN)
            {
                Varyings OUT;
                UNITY_SETUP_INSTANCE_ID(IN);
                UNITY_TRANSFER_INSTANCE_ID(IN, OUT);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);

                float3 positionWS = TransformObjectToWorld(IN.positionOS.xyz);
                half3 normalWS = TransformObjectToWorldNormal(IN.normalOS);
                SnowSettings snowSettings = GetSnowSettings();

                if (_SnowDisplace > 0.5)
                {
                    float snowMask = ComputeSnowMask(positionWS, normalWS, TRANSFORM_TEX(IN.uv, _BaseMap), snowSettings);
                    positionWS += SafeNormalize(normalWS) * (_SnowDisplaceAmount * snowMask);
                }

                OUT.positionWS = positionWS;
                OUT.positionCS = TransformWorldToHClip(positionWS);
                OUT.uv = TRANSFORM_TEX(IN.uv, _BaseMap);
                OUT.normalWS = normalWS;
                OUT.tangentWS = half4(TransformObjectToWorldDir(IN.tangentOS.xyz), IN.tangentOS.w);
                OUT.fogFactor = ComputeFogFactor(OUT.positionCS.z);
                return OUT;
            }

            half4 frag(Varyings IN) : SV_Target
            {
                UNITY_SETUP_INSTANCE_ID(IN);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

                half4 baseSample = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, IN.uv) * _BaseColor;
                #if defined(_ALPHATEST_ON)
                clip(baseSample.a - _Cutoff);
                #endif

                half3 normalTS = UnpackNormalScale(SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, IN.uv), _BumpScale);
                SnowSettings snowSettings = GetSnowSettings();
                float snowMask = ComputeSnowMask(IN.positionWS, IN.normalWS, IN.uv, snowSettings);
                normalTS = normalize(lerp(normalTS, half3(0, 0, 1), snowMask * _SnowNormalFlatten));

                half3 bitangentWS = IN.tangentWS.w * cross(IN.normalWS, IN.tangentWS.xyz);
                half3 normalWS = TransformTangentToWorld(normalTS, half3x3(IN.tangentWS.xyz, bitangentWS, IN.normalWS));
                normalWS = NormalizeNormalPerPixel(normalWS);

                half4 snowSample = SAMPLE_TEXTURE2D(_SnowMap, sampler_SnowMap, IN.uv * _SnowTiling) * snowSettings.color;
                half3 albedo = lerp(baseSample.rgb, snowSample.rgb, snowMask);
                half occlusion = lerp(1.0h, SAMPLE_TEXTURE2D(_OcclusionMap, sampler_OcclusionMap, IN.uv).g, _OcclusionStrength);
                half smoothness = lerp(_Smoothness, _SnowSmoothness, snowMask);
                half3 emission = _SnowEmissionColor.rgb * (_SnowEmissionStrength * snowSettings.emissionMultiplier * snowMask);

                SurfaceData surfaceData = (SurfaceData)0;
                surfaceData.albedo = albedo;
                surfaceData.alpha = baseSample.a;
                surfaceData.normalTS = normalTS;
                surfaceData.metallic = _Metallic;
                surfaceData.specular = half3(0, 0, 0);
                surfaceData.smoothness = smoothness;
                surfaceData.occlusion = occlusion;
                surfaceData.emission = emission;
                surfaceData.clearCoatMask = 0;
                surfaceData.clearCoatSmoothness = 0;

                InputData inputData = (InputData)0;
                inputData.positionWS = IN.positionWS;
                inputData.normalWS = normalWS;
                inputData.viewDirectionWS = SafeNormalize(GetWorldSpaceViewDir(IN.positionWS));
                inputData.shadowCoord = TransformWorldToShadowCoord(IN.positionWS);
                inputData.fogCoord = IN.fogFactor;
                inputData.vertexLighting = VertexLighting(IN.positionWS, normalWS);
                inputData.bakedGI = SampleSH(normalWS);
                inputData.normalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(IN.positionCS);
                inputData.shadowMask = half4(1, 1, 1, 1);

                half4 color = UniversalFragmentPBR(inputData, surfaceData);
                color.rgb = MixFog(color.rgb, IN.fogFactor);
                return color;
            }
            ENDHLSL
        }

        UsePass "Universal Render Pipeline/Lit/ShadowCaster"
        UsePass "Universal Render Pipeline/Lit/DepthOnly"
        UsePass "Universal Render Pipeline/Lit/Meta"
    }
}
