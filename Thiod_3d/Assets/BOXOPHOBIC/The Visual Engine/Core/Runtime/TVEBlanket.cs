// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;
using System.Collections.Generic;
using Boxophobic.Utility;

//#if UNITY_EDITOR
//using UnityEngine.SceneManagement;
//using UnityEditor.SceneManagement;
//#endif

namespace TheVisualEngine
{
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Visual Engine/TVE Blanket")]
    [DefaultExecutionOrder(3)]
    public class TVEBlanket : StyledMonoBehaviour
    {

        public TVEBalnketBlending blanketBlending = new TVEBalnketBlending();

        List<Renderer> prefabRenderers;

#if UNITY_EDITOR
        [System.NonSerialized]
        public bool isSelected = false;
#endif

        void OnEnable()
        {
            if (BoxoUtils.DisableServerExecution())
            {
                return;
            }

#if UNITY_EDITOR
            //EditorSceneManager.sceneSaved += OnSceneSaved;
            TVEEvents.TVEOnAssetsSaved += OnAssetsSaved;
#endif

            if (TVEManager.Instance == null)
            {
                return;
            }

            if (blanketBlending.blendMode == 1)
            {
                GetPrefabRenderers();
                UpdatePrefabBlending();
            }
        }

#if UNITY_EDITOR
        void OnDisable()
        {
            if (BoxoUtils.DisableServerExecution())
            {
                return;
            }

            TVEEvents.TVEOnAssetsSaved -= OnAssetsSaved;
        }

        void OnDestroy()
        {
            if (BoxoUtils.DisableServerExecution())
            {
                return;
            }

            TVEEvents.TVEOnAssetsSaved -= OnAssetsSaved;
        }

        void Update()
        {
            if (BoxoUtils.DisableServerExecution())
            {
                return;
            }

            if (isSelected)
            {
                if (blanketBlending.blendMode == 1)
                {
                    UpdatePrefabBlending();
                }
            }
        }
#endif

        void GetPrefabRenderers()
        {
            prefabRenderers = new();

            List<GameObject> gameObjectsInPrefab = new();
            gameObjectsInPrefab.Add(gameObject);

            TVEUtils.GetChildRecursive(gameObject, gameObjectsInPrefab);

            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                var gameObjectInPrefab = gameObjectsInPrefab[i];

                if (gameObjectInPrefab != null)
                {
                    var renderer = gameObjectInPrefab.GetComponent<Renderer>();

                    prefabRenderers.Add(renderer);
                }
            }
        }

        public void UpdatePrefabBlending()
        {
            if (TVEManager.Instance == null)
            {
                return;
            }

            var sceneTerrains = TVEManager.Instance.sceneTerrains;

            for (int i = 0; i < sceneTerrains.Count; i++)
            {
                var sceneTerrain = sceneTerrains[i];

                if (sceneTerrain == null)
                {
                    continue;
                }

                var terrainPosition = sceneTerrain.terrainPosition;
                var terrainSize = sceneTerrain.terrainSize;
                var terrainExtent = terrainPosition + terrainSize;

                if (transform.position.x > terrainPosition.x && transform.position.z > terrainPosition.z && transform.position.x < terrainExtent.x && transform.position.z < terrainExtent.z)
                {
                    //activeTerrain = sceneTerrain;

                    for (int r = 0; r < prefabRenderers.Count; r++)
                    {
                        var renderer = prefabRenderers[r];

                        TVEUtils.CopyTerrainDataToRenderer(sceneTerrain, renderer);
                    }
                }
            }
        }

#if UNITY_EDITOR
        //void OnSceneSaved(Scene scene)
        //{
        //    if (blanketBlending.blendMode == 1)
        //    {
        //        UpdatePrefabBlending();
        //    }
        //}

        void OnAssetsSaved()
        {
            if (blanketBlending.blendMode == 1)
            {
                UpdatePrefabBlending();
            }
        }

        void OnValidate()
        {
            if (blanketBlending.blendMode == 1)
            {
                GetPrefabRenderers();
                UpdatePrefabBlending();
            }
        }
#endif
    }
}





