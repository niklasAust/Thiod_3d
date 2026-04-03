using UnityEngine;

[ExecuteAlways]
public class GlobalSnowController : MonoBehaviour
{
    private static readonly int GlobalSnowEnabledId = Shader.PropertyToID("_GlobalSnowEnabled");
    private static readonly int GlobalSnowAmountId = Shader.PropertyToID("_GlobalSnowAmount");
    private static readonly int GlobalSnowColorId = Shader.PropertyToID("_GlobalSnowColor");
    private static readonly int GlobalSnowDirectionId = Shader.PropertyToID("_GlobalSnowDirection");
    private static readonly int GlobalSnowHeightOffsetId = Shader.PropertyToID("_GlobalSnowHeightOffset");
    private static readonly int GlobalSnowEmissionMultiplierId = Shader.PropertyToID("_GlobalSnowEmissionMultiplier");

    [SerializeField] private bool m_SnowEnabled = true;
    [SerializeField, Range(0f, 1f)] private float m_SnowAmount = 1f;
    [SerializeField] private Color m_SnowColor = new Color(0.94f, 0.97f, 1f, 1f);
    [SerializeField] private Vector3 m_SnowDirection = Vector3.up;
    [SerializeField] private float m_SnowHeightOffset = 0f;
    [SerializeField, Min(0f)] private float m_SnowEmissionMultiplier = 1f;

    private void OnEnable()
    {
        Apply();
    }

    private void OnValidate()
    {
        Apply();
    }

    private void Update()
    {
        if (!Application.isPlaying)
        {
            Apply();
        }
    }

    private void OnDisable()
    {
        Shader.SetGlobalFloat(GlobalSnowEnabledId, 0f);
        Shader.SetGlobalFloat(GlobalSnowAmountId, 0f);
    }

    [ContextMenu("Apply Global Snow")]
    public void Apply()
    {
        var direction = m_SnowDirection.sqrMagnitude > 0.0001f ? m_SnowDirection.normalized : Vector3.up;

        Shader.SetGlobalFloat(GlobalSnowEnabledId, m_SnowEnabled ? 1f : 0f);
        Shader.SetGlobalFloat(GlobalSnowAmountId, m_SnowAmount);
        Shader.SetGlobalColor(GlobalSnowColorId, m_SnowColor);
        Shader.SetGlobalVector(GlobalSnowDirectionId, new Vector4(direction.x, direction.y, direction.z, 0f));
        Shader.SetGlobalFloat(GlobalSnowHeightOffsetId, m_SnowHeightOffset);
        Shader.SetGlobalFloat(GlobalSnowEmissionMultiplierId, m_SnowEmissionMultiplier);
    }

    public void SetWeatherDrivenSnow(float amount)
    {
        m_SnowAmount = Mathf.Clamp01(amount);
        m_SnowEnabled = m_SnowAmount > 0.001f;
        Apply();
    }
}
