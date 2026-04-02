using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(TileLoader))]
public sealed class TileLoaderEditor : Editor
{
    public override void OnInspectorGUI()
    {
        if (target == null || serializedObject == null || serializedObject.targetObject == null)
        {
            EditorGUILayout.HelpBox("TileLoader is not available yet.", MessageType.Info);
            return;
        }

        serializedObject.UpdateIfRequiredOrScript();

        SerializedProperty iterator = serializedObject.GetIterator();
        bool enterChildren = true;
        while (iterator.NextVisible(enterChildren))
        {
            if (iterator.propertyPath == "m_Script")
            {
                using (new EditorGUI.DisabledScope(true))
                {
                    EditorGUILayout.PropertyField(iterator, true);
                }
            }
            else
            {
                EditorGUILayout.PropertyField(iterator, true);
            }

            enterChildren = false;
        }

        serializedObject.ApplyModifiedProperties();

        EditorGUILayout.Space();

        TileLoader loader = (TileLoader)target;
        if (GUILayout.Button("Update"))
        {
            loader.UpdateTerrain();
            EditorUtility.SetDirty(loader);
        }
    }
}
