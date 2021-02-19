using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UI_Teleport : MonoBehaviour
{
    public GameObject Target;

    public GameObject TPLoc1;
    public GameObject TPLoc2;
    public GameObject TPLoc3;
    

    public void Activity1()
    {
        Target.gameObject.transform.position = TPLoc1.gameObject.transform.position;
    }

    public void Activity2()
    {
        Target.gameObject.transform.position = TPLoc2.gameObject.transform.position;
    }
    public void Activity3()
    {
        Target.gameObject.transform.position = TPLoc3.gameObject.transform.position;
    }

    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
