using Opsive.UltimateCharacterController.Camera;
using Opsive.UltimateCharacterController.Character;
using Opsive.UltimateCharacterController.Character.Identifiers;
using Opsive.UltimateCharacterController.Utility.Builders;
using UnityEditor;
using UnityEditorInternal;
using UnityEngine;

public static class OpsiveChiefCharacterSetup
{
    private const string CharacterRootName = "Atlas";
    private const string AtlasModelName = "Atlas";
    private const string ChiefSourceName = "SM_Chr_Chief_01_White";
    private const string ChiefModelName = "Chief";
    private const string DemoControllerPath = "Assets/Samples/Opsive Ultimate Character Controller/3.3.4/Demo/Animator/Characters/Demo.controller";
    private static readonly Vector3 ChiefLeftFootstepTriggerLocalPosition = new(0f, 0.012f, 0f);
    private static readonly Vector3 ChiefRightFootstepTriggerLocalPosition = new(0f, -0.012f, 0f);
    private const float ChiefFootstepTriggerRadius = 0.06f;

    [MenuItem("Tools/Opsive/Use Chief Model In SampleScene")]
    public static void UseChiefModelInSampleScene()
    {
        var characterRoot = GameObject.Find(CharacterRootName);
        if (characterRoot == null || characterRoot.GetComponent<UltimateCharacterLocomotion>() == null) {
            Debug.LogError("Could not find the live Opsive character root named 'Atlas'.");
            return;
        }

        var atlasModel = FindDirectChild(characterRoot.transform, AtlasModelName);
        if (atlasModel == null) {
            Debug.LogError("Could not find the Atlas model child under the Opsive character root.");
            return;
        }

        var chiefModel = FindDirectChild(characterRoot.transform, ChiefModelName);
        if (chiefModel == null) {
            var chiefSource = FindSceneObject(ChiefSourceName);
            if (chiefSource == null) {
                Debug.LogError("Could not find the Synty chief model in the scene.");
                return;
            }

            chiefModel = Object.Instantiate(chiefSource, characterRoot.transform);
            chiefModel.name = ChiefModelName;
        }

        Undo.RegisterFullObjectHierarchyUndo(characterRoot, "Configure chief model");

        chiefModel.transform.SetParent(characterRoot.transform, false);
        chiefModel.transform.localPosition = Vector3.zero;
        chiefModel.transform.localRotation = Quaternion.identity;
        chiefModel.transform.localScale = Vector3.one;
        chiefModel.SetActive(true);

        var chiefAnimator = chiefModel.GetComponent<Animator>();
        if (chiefAnimator == null) {
            chiefAnimator = chiefModel.AddComponent<Animator>();
        }

        var demoController = AssetDatabase.LoadAssetAtPath<RuntimeAnimatorController>(DemoControllerPath);
        if (demoController == null) {
            Debug.LogError($"Could not load Opsive demo animator controller at '{DemoControllerPath}'.");
            return;
        }

        chiefAnimator.runtimeAnimatorController = demoController;
        chiefAnimator.updateMode = AnimatorUpdateMode.Normal;
        chiefAnimator.cullingMode = AnimatorCullingMode.AlwaysAnimate;

        EnsureChiefColliders(chiefModel);

        CopyComponentIfMissing<CharacterFootEffects>(atlasModel, chiefModel);
        CopyComponentIfMissing<CharacterIK>(atlasModel, chiefModel);
        CopyComponentIfMissing<AnimatorMonitor>(atlasModel, chiefModel);
        CopyComponentIfMissing<Opsive.UltimateCharacterController.Objects.ObjectIdentifier>(atlasModel, chiefModel);

        var chiefFootEffects = chiefModel.GetComponent<CharacterFootEffects>();
        if (chiefFootEffects != null) {
            chiefFootEffects.enabled = true;
            EnsureChiefFootstepTriggers(chiefModel, chiefFootEffects);
        }

        var chiefIk = chiefModel.GetComponent<CharacterIK>();
        if (chiefIk != null) {
            chiefIk.enabled = true;
        }

        var chiefAnimatorMonitor = chiefModel.GetComponent<AnimatorMonitor>();
        if (chiefAnimatorMonitor != null) {
            chiefAnimatorMonitor.enabled = true;
        }

        var chiefObjectIdentifier = chiefModel.GetComponent<Opsive.UltimateCharacterController.Objects.ObjectIdentifier>();
        if (chiefObjectIdentifier != null) {
            chiefObjectIdentifier.enabled = true;
        }

        atlasModel.SetActive(false);

        var chiefSourceToHide = FindSceneObject(ChiefSourceName);
        if (chiefSourceToHide != null) {
            chiefSourceToHide.SetActive(false);
        }

        var modelManager = characterRoot.GetComponent<ModelManager>();
        if (modelManager != null) {
            SetAvailableModels(modelManager, chiefModel);
            SetActiveModel(modelManager, chiefModel);
        }

        var playerContainer = characterRoot.transform.parent;
        if (playerContainer != null) {
            var camera = playerContainer.GetComponentInChildren<CameraController>(true);
            if (camera != null) {
                camera.Character = characterRoot;
                camera.Anchor = characterRoot.transform;
            }
        }

        EditorUtility.SetDirty(characterRoot);
        EditorUtility.SetDirty(chiefModel);
        if (modelManager != null) {
            EditorUtility.SetDirty(modelManager);
        }

        Debug.Log("Configured the Opsive player to use the Synty chief model.");
    }

    private static GameObject FindDirectChild(Transform parent, string name)
    {
        for (int i = 0; i < parent.childCount; i++) {
            var child = parent.GetChild(i);
            if (child.name == name) {
                return child.gameObject;
            }
        }

        return null;
    }

    private static GameObject FindSceneObject(string name)
    {
        var objects = Resources.FindObjectsOfTypeAll<GameObject>();
        for (int i = 0; i < objects.Length; i++) {
            var candidate = objects[i];
            if (candidate.name != name || EditorUtility.IsPersistent(candidate)) {
                continue;
            }

            if (candidate.hideFlags != HideFlags.None) {
                continue;
            }

            return candidate;
        }

        return null;
    }

    private static void EnsureChiefColliders(GameObject chiefModel)
    {
        var colliderIdentifiers = chiefModel.GetComponentsInChildren<CharacterColliderBaseIdentifier>(true);
        for (int i = colliderIdentifiers.Length - 1; i >= 0; i--) {
            Undo.DestroyObjectImmediate(colliderIdentifiers[i].gameObject);
        }

        CharacterBuilder.AddCollider(chiefModel);
    }

    private static void EnsureChiefFootstepTriggers(GameObject chiefModel, CharacterFootEffects chiefFootEffects)
    {
        var existingTriggers = chiefModel.GetComponentsInChildren<FootstepTrigger>(true);
        for (int i = existingTriggers.Length - 1; i >= 0; i--) {
            Undo.DestroyObjectImmediate(existingTriggers[i].gameObject);
        }

        var animator = chiefModel.GetComponent<Animator>();
        if (animator == null || !animator.isHuman) {
            Debug.LogWarning("Chief model is not using a humanoid animator, so footstep triggers were not created.");
            return;
        }

        CreateFootstepTrigger(
            animator,
            HumanBodyBones.LeftToes,
            HumanBodyBones.LeftFoot,
            flipFootprint: true,
            localPosition: ChiefLeftFootstepTriggerLocalPosition);
        CreateFootstepTrigger(
            animator,
            HumanBodyBones.RightToes,
            HumanBodyBones.RightFoot,
            flipFootprint: false,
            localPosition: ChiefRightFootstepTriggerLocalPosition);

        // Ensure Opsive keeps using per-foot trigger mode after the swap.
        chiefFootEffects.FootstepMode = CharacterFootEffects.FootstepPlacementMode.Trigger;
    }

    private static void CreateFootstepTrigger(
        Animator animator,
        HumanBodyBones preferredBone,
        HumanBodyBones fallbackBone,
        bool flipFootprint,
        Vector3 localPosition)
    {
        var footBone = animator.GetBoneTransform(preferredBone);
        if (footBone == null) {
            footBone = animator.GetBoneTransform(fallbackBone);
        }

        if (footBone == null) {
            Debug.LogWarning($"Could not find a valid foot bone for {fallbackBone} on the chief model.");
            return;
        }

        var triggerObject = new GameObject("FootstepTrigger");
        Undo.RegisterCreatedObjectUndo(triggerObject, "Create chief footstep trigger");
        triggerObject.transform.SetParent(footBone, false);
        triggerObject.transform.localPosition = localPosition;
        triggerObject.transform.localRotation = Quaternion.identity;
        triggerObject.transform.localScale = Vector3.one;

        var trigger = triggerObject.AddComponent<FootstepTrigger>();
        trigger.FlipFootprint = flipFootprint;

        var audioSource = triggerObject.AddComponent<AudioSource>();
        audioSource.playOnAwake = false;

        var sphereCollider = triggerObject.AddComponent<SphereCollider>();
        sphereCollider.isTrigger = true;
        sphereCollider.radius = ChiefFootstepTriggerRadius;
    }

    private static void CopyComponentIfMissing<T>(GameObject source, GameObject destination) where T : Component
    {
        if (destination.GetComponent<T>() != null) {
            return;
        }

        var sourceComponent = source.GetComponent<T>();
        if (sourceComponent == null) {
            return;
        }

        ComponentUtility.CopyComponent(sourceComponent);
        ComponentUtility.PasteComponentAsNew(destination);
    }

    private static void SetAvailableModels(ModelManager modelManager, GameObject chiefModel)
    {
        var serializedObject = new SerializedObject(modelManager);
        var availableModels = serializedObject.FindProperty("m_AvailableModels");
        availableModels.arraySize = 1;
        availableModels.GetArrayElementAtIndex(0).objectReferenceValue = chiefModel;
        serializedObject.ApplyModifiedPropertiesWithoutUndo();
    }

    private static void SetActiveModel(ModelManager modelManager, GameObject chiefModel)
    {
        var serializedObject = new SerializedObject(modelManager);
        serializedObject.FindProperty("m_ActiveModel").objectReferenceValue = chiefModel;
        serializedObject.ApplyModifiedPropertiesWithoutUndo();
    }
}
