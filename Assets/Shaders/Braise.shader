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

		// Functions

		float length2(float2 p) { return dot(p, p); }

		float noise(float2 p) {
			return frac(sin(frac(sin(p.x) * (4313.13311)) + p.y) * 3131.0011);
		}

		float worley(float2 p) {
			float d = 1e30;
			for (int xo = -1; xo <= 1; ++xo)
				for (int yo = -1; yo <= 1; ++yo) {
					float2 tp = floor(p) + float2(xo, yo);
					d = min(d, length2(p - tp - float2(noise(tp), noise(tp))));
				}
			return 3. * exp(-4. * abs(2. * d - 1.));
		}

		float fworley(float2 p) {
			return sqrt(sqrt(sqrt(
				pow(worley(p + iTime), 2.) *
				worley(p * 2. + 1.3 + iTime * .5) *
				worley(p * 4. + 2.3 + iTime * .25) *
				worley(p * 8. + 3.3 + iTime * .125) *
				worley(p * 32. + 4.3 + iTime * .125) *
				sqrt(worley(p * 64. + 5.3 + iTime * .0625)) *
				sqrt(sqrt(worley(p * 128. + 7.3))))));
		}


		ENDCG

		Pass
		{
			CGPROGRAM

			void mainImage(out float4 fragColor, float2 fragCoord)
			{
				float2 uv = fragCoord.xy / iResolution.xy;


				float t = fworley(uv * iResolution.xy / 600.);
				t *= exp(-length2(abs(2. * uv - 1.)));
				float r = length(abs(2. * uv - 1.) * iResolution.xy);
				float4 result = float4(t * float3(1.8, 1.8 * t, .1 + pow(t, 2. - t)), 1.);

				float4 vals = tex2D(_Texture, uv);
				float3 myColor = lerp(vals.rgb, _Color.rgb, _Color.a);

				fragColor = lerp(float4(vals) * float4(myColor, 1.), result, _Color.a);
			}

			ENDCG
		}
	}
}