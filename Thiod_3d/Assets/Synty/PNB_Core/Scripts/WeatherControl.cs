using System.Collections.Generic;
using UnityEngine;

[ExecuteAlways]
public class WeatherControl : MonoBehaviour
{
    private static readonly int FrostingColorId = Shader.PropertyToID("_Frosting_Color");
    private static readonly int FrostingEnabledId = Shader.PropertyToID("_Enable_Frosting");
    private static readonly int FrostingSwitchId = Shader.PropertyToID("_FrostingSwitch");
    private static readonly int FrostingHeightId = Shader.PropertyToID("_Frosting_Height");
    private static readonly int FrostingHeightLegacyId = Shader.PropertyToID("_FrostingHeight");
    private static readonly int FrostingFalloffId = Shader.PropertyToID("_Frosting_Falloff");
    private static readonly int FrostingFalloffLegacyId = Shader.PropertyToID("_FrostingFalloff");
    private static readonly int FrostingUseWorldNormalsId = Shader.PropertyToID("_Frosting_Use_World_Normals");

    private readonly List<Renderer> sceneRenderers = new List<Renderer>();
    private MaterialPropertyBlock propertyBlock;

    [Range(0,1)]
    public float windIntensity;
    [Range(0,1)]
    public float weatherIntensity;
    [Header("Frosting")]
    [SerializeField] private bool controlSyntyFrosting = true;
    [SerializeField] private bool frostingEnabled = true;
    [SerializeField] private Color frostingColor = Color.white;
    [SerializeField, Min(0f)] private float frostingHeight = 1f;
    [SerializeField, Range(0f, 1f)] private float frostingFalloff = 1f;
    [SerializeField] private bool frostingUsesWorldNormals = true;
    [SerializeField] private bool initializeFrostingDefaults = true;
    
    private void OnEnable()
    {
        EnsureDefaults();
        ApplyWeather();
    }

    private void OnDisable()
    {
        ClearSceneFrostingOverrides();
    }

    private void OnValidate()
    {
        EnsureDefaults();
        ApplyWeather();
    }

    void Update()
    {
        ApplyWeather();
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawIcon(this.transform.position,"../Synty/PNB_Core/Textures/SyntyLogo.png", true);
        Gizmos.DrawLine(this.transform.position, this.transform.position + this.transform.forward * 4f);
        Gizmos.DrawLine(this.transform.position + this.transform.forward * 4f, this.transform.position + this.transform.forward * 3f + this.transform.right * 0.5f);
        Gizmos.DrawLine(this.transform.position + this.transform.forward * 4f, this.transform.position + this.transform.forward * 3f - this.transform.right * 0.5f);
        ApplyWeather();
    }

    [ContextMenu("Apply Weather")]
    public void ApplyWeather()
    {
        UpdateShaderGlobals();
        if (controlSyntyFrosting)
        {
            UpdateSceneFrosting();
        }
        else
        {
            ClearSceneFrostingOverrides();
        }
    }

    private void UpdateShaderGlobals()
    {
        Shader.SetGlobalVector("_WindDirection", transform.forward);
        Shader.SetGlobalFloat("_GaleStrength", weatherIntensity);
        Shader.SetGlobalFloat("_WindIntensity", windIntensity);
    }

    private void UpdateSceneFrosting()
    {
        propertyBlock ??= new MaterialPropertyBlock();
        CacheSceneRenderers();

        float enabledValue = frostingEnabled ? 1f : 0f;
        for (int rendererIndex = 0; rendererIndex < sceneRenderers.Count; rendererIndex++)
        {
            Renderer sceneRenderer = sceneRenderers[rendererIndex];
            if (sceneRenderer == null)
            {
                continue;
            }

            Material[] materials = sceneRenderer.sharedMaterials;
            for (int materialIndex = 0; materialIndex < materials.Length; materialIndex++)
            {
                Material material = materials[materialIndex];
                if (!SupportsFrosting(material))
                {
                    continue;
                }

                sceneRenderer.GetPropertyBlock(propertyBlock, materialIndex);
                ApplySyntyFrostingProperties(material, propertyBlock, enabledValue);
                sceneRenderer.SetPropertyBlock(propertyBlock, materialIndex);
            }
        }
    }

    [ContextMenu("Clear Frosting Overrides")]
    private void ClearSceneFrostingOverrides()
    {
        propertyBlock ??= new MaterialPropertyBlock();
        propertyBlock.Clear();
        CacheSceneRenderers();

        for (int rendererIndex = 0; rendererIndex < sceneRenderers.Count; rendererIndex++)
        {
            Renderer sceneRenderer = sceneRenderers[rendererIndex];
            if (sceneRenderer == null)
            {
                continue;
            }

            Material[] materials = sceneRenderer.sharedMaterials;
            for (int materialIndex = 0; materialIndex < materials.Length; materialIndex++)
            {
                Material material = materials[materialIndex];
                if (!SupportsFrosting(material))
                {
                    continue;
                }

                sceneRenderer.SetPropertyBlock(propertyBlock, materialIndex);
            }
        }
    }

    private void CacheSceneRenderers()
    {
        sceneRenderers.Clear();
        Renderer[] renderers = FindObjectsByType<Renderer>(FindObjectsInactive.Include, FindObjectsSortMode.None);
        for (int i = 0; i < renderers.Length; i++)
        {
            Renderer current = renderers[i];
            if (current == null || !current.gameObject.scene.IsValid())
            {
                continue;
            }

            sceneRenderers.Add(current);
        }
    }

    private void ApplySyntyFrostingProperties(Material material, MaterialPropertyBlock block, float enabledValue)
    {
        SetFloatIfPresent(material, block, FrostingEnabledId, "_Enable_Frosting", enabledValue);
        SetFloatIfPresent(material, block, FrostingSwitchId, "_FrostingSwitch", enabledValue);
        SetColorIfPresent(material, block, FrostingColorId, "_Frosting_Color", frostingColor);
        SetFloatIfPresent(material, block, FrostingHeightId, "_Frosting_Height", frostingHeight);
        SetFloatIfPresent(material, block, FrostingHeightLegacyId, "_FrostingHeight", frostingHeight);
        SetFloatIfPresent(material, block, FrostingFalloffId, "_Frosting_Falloff", frostingFalloff);
        SetFloatIfPresent(material, block, FrostingFalloffLegacyId, "_FrostingFalloff", frostingFalloff);
        SetFloatIfPresent(material, block, FrostingUseWorldNormalsId, "_Frosting_Use_World_Normals", frostingUsesWorldNormals ? 1f : 0f);
    }

    private static bool SupportsFrosting(Material material)
    {
        if (material == null)
        {
            return false;
        }

        return material.HasProperty("_Enable_Frosting") ||
               material.HasProperty("_FrostingSwitch") ||
               material.HasProperty("_Frosting_Height") ||
               material.HasProperty("_FrostingHeight");
    }

    private static void SetFloatIfPresent(Material material, MaterialPropertyBlock block, int propertyId, string propertyName, float value)
    {
        if (material.HasProperty(propertyName))
        {
            block.SetFloat(propertyId, value);
        }
    }

    private static void SetColorIfPresent(Material material, MaterialPropertyBlock block, int propertyId, string propertyName, Color value)
    {
        if (material.HasProperty(propertyName))
        {
            block.SetColor(propertyId, value);
        }
    }

    private void EnsureDefaults()
    {
        if (!initializeFrostingDefaults)
        {
            return;
        }

        controlSyntyFrosting = true;
        frostingEnabled = true;
        frostingColor = Color.white;
        frostingHeight = 1f;
        frostingFalloff = 1f;
        frostingUsesWorldNormals = true;
        initializeFrostingDefaults = false;
    }
}
