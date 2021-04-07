using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class animateOnClick : MonoBehaviour
{
    public GameObject[] toBeAnimated;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnMouseDown() {
        foreach(GameObject tba in toBeAnimated)
        {
            tba.GetComponent<Animator>().SetTrigger("beginAnimation");
        }
    }
}
