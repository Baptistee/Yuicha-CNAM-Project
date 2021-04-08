
Shader "Assets/ShaderToy/ShaderToy1"
{
	Properties
	{

	}

	SubShader
	{
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent" }

		Pass
		{
	ZWrite Off
	Blend SrcAlpha OneMinusSrcAlpha
	CGPROGRAM
	#pragma vertex vert
	#pragma fragment frag
	#include "UnityCG.cginc"

	struct VertexInput {
	float4 vertex : POSITION;
	float2 uv:TEXCOORD0;
	float4 tangent : TANGENT;
	float3 normal : NORMAL;
	//VertexInput
	};
	struct VertexOutput {
	float4 pos : SV_POSITION;
	float2 uv:TEXCOORD0;
	//VertexOutput
	};


	VertexOutput vert(VertexInput v)
	{
	VertexOutput o;
	o.pos = UnityObjectToClipPos(v.vertex);
	o.uv = v.uv;
	//VertexFactory
	return o;
	}

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
		pow(worley(p + _Time.y), 2.) *
		worley(p * 2. + 1.3 + _Time.y * .5) *
		worley(p * 4. + 2.3 + _Time.y * .25) *
		worley(p * 8. + 3.3 + _Time.y * .125) *
		worley(p * 32. + 4.3 + _Time.y * .125) *
		sqrt(worley(p * 64. + 5.3 + _Time.y * .0625)) *
		sqrt(sqrt(worley(p * 128. + 7.3))))));
}




	fixed4 frag(VertexOutput vertex_output) : SV_Target
	{

	float2 uv = vertex_output.uv / 1;
	float t = fworley(uv * 1 / 1.);
	t *= exp(-length2(abs(2. * uv - 1.)));
	float r = length(abs(2. * uv - 1.) * 1);
	return float4(t * float3(1.8, 1.8 * t, .1 + pow(t, 2. - t)), 1.);

	}
	ENDCG
	}
	}
}
