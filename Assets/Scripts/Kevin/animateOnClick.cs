using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class AnimatedObjects
{
    public float beginAt = 0f;
    
    public GameObject[] objects;
    public string triggerName = "beginAnimation";
}

public class animateOnClick : MonoBehaviour
{
    
    public List<AnimatedObjects> animatedObjects;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnMouseDown() {
        foreach(AnimatedObjects animObj in animatedObjects)
        {
            StartCoroutine(playAfterDelay(animObj.beginAt, animObj.objects, animObj.triggerName));
        }
    }

    IEnumerator playAfterDelay(float beginAt, GameObject[] objects, string triggerName)
    {
        yield return new WaitForSeconds(beginAt);
        
        foreach(GameObject obj in objects)
        {
            obj.GetComponent<Animator>().SetTrigger(triggerName);
        }
    }
}
