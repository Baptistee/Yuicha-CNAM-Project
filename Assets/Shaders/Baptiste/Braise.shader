Shader "Unlit/Braise"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_Texture("Albedo (RGB)", 2D) = "white" {}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
	}

	SubShader
	{
		CGINCLUDE
		#pragma vertex vert
		#pragma fragment frag

		#include "UnityCG.cginc"

		struct appdata
		{
			float4 vertex : POSITION;
			float2 uv : TEXCOORD0;
		};

		struct v2f
		{
			float2 uv : TEXCOORD0;
			float4 vertex : SV_POSITION;
		};

		// Properties
		sampler2D _Texture;
		fixed4 _Color;

		// External
		float2 _WCResolution;
		float2 _PlayerPos;
		float2 _QuadScale;
		int KEY_SPACE;

		// Shadertoys
		#define iTime _Time.y // float
		#define iResolution _ScreenParams // float3
		float4 iMouse;

		// Unity : https://docs.unity3d.com/Manual/SL-UnityShaderVariables.html
		#define _CameraPos _WorldSpaceCameraPos
		#define _CameraSize unity_OrthoParams

		void mainImage(out float4 fragColor, float2 fragCoord);

		v2f vert(appdata v)
		{
			v2f o;
			o.vertex = UnityObjectToClipPos(v.vertex);
			o.uv = v.uv * iResolution.xy;
			return o;
		}

		fixed4 frag(v2f i) : SV_Target
		{
			float4 fragColor;
			mainImage(fragColor, i.uv);
			return fragColor;
		}

		ENDCG

		Pass
		{
			CGPROGRAM

			void mainImage(out float4 fragColor, float2 fragCoord)
			{
				float2 uv = fragCoord.xy / iResolution.xy;
				float4 vals = tex2D(_Texture, uv);

				float3 myColor = float3(_Color.r * _Color.a, _Color.g * _Color.a, _Color.b * _Color.a);

				fragColor = float4(vals) * float4(myColor, 1.);
			}

			ENDCG
		}
	}
}