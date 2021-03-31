using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class InspectRaycast : MonoBehaviour
{
    [SerializeField] private int rayLength = 5;
    [SerializeField] private LayerMask layerMaskInteract;
    private ObjectController raycasterObj;

    [SerializeField] private Image crosshair;
    private bool isCrosshairActive;
    private bool doOnce;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        RaycastHit hit;
        Vector3 fwd = transform.TransformDirection(Vector3.forward);

        if(Physics.Raycast(transform.position, fwd, out hit, rayLength, layerMaskInteract.value))
        {
            if(hit.collider.CompareTag("InteractObject"))
            {
                if (!doOnce)
                {
                    raycasterObj = hit.collider.gameObject.GetComponent<ObjectController>();
                    raycasterObj.ShowObjectName();
                    CrosshairChange(true);
                }

                isCrosshairActive = true;
                doOnce = true;

                if(Input.GetMouseButtonDown(0))
                {
                    raycasterObj.ShowExtraInfo();
                }
            }
        }
        else
        {
            if (isCrosshairActive)
            {
                raycasterObj.HideObjectName();
                CrosshairChange(false);
                doOnce = false;
            }
        }
    }

    void CrosshairChange(bool on)
    {
        if(on && !doOnce)
        {
            crosshair.color = Color.red;
        }
        else
        {
            crosshair.color = Color.white;
            isCrosshairActive = false;
        }
    }
}
