using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class onClickBehavior : MonoBehaviour
{
    public GameObject test;
    
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnMouseDown() {
        Debug.Log(this.gameObject.name);
        GetComponent<Animator>().SetTrigger("beginAnim");
    }
}
