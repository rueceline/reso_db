//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Particles/Standard Unlit" {
Properties {
_MainTex ("Albedo", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
_BumpScale ("Scale", Float) = 1
_BumpMap ("Normal Map", 2D) = "bump" { }
_EmissionColor ("Color", Color) = (0,0,0,1)
_EmissionMap ("Emission", 2D) = "white" { }
_DistortionStrength ("Strength", Float) = 1
_DistortionBlend ("Blend", Range(0, 1)) = 0.5
_SoftParticlesNearFadeDistance ("Soft Particles Near Fade", Float) = 0
_SoftParticlesFarFadeDistance ("Soft Particles Far Fade", Float) = 1
_CameraNearFadeDistance ("Camera Near Fade", Float) = 1
_CameraFarFadeDistance ("Camera Far Fade", Float) = 2
[HideInInspector] _Mode ("__mode", Float) = 0
[HideInInspector] _ColorMode ("__colormode", Float) = 0
[HideInInspector] _FlipbookMode ("__flipbookmode", Float) = 0
[HideInInspector] _LightingEnabled ("__lightingenabled", Float) = 0
[HideInInspector] _DistortionEnabled ("__distortionenabled", Float) = 0
[HideInInspector] _EmissionEnabled ("__emissionenabled", Float) = 0
[HideInInspector] _BlendOp ("__blendop", Float) = 0
[HideInInspector] _SrcBlend ("__src", Float) = 1
[HideInInspector] _DstBlend ("__dst", Float) = 0
[HideInInspector] _ZWrite ("__zw", Float) = 1
[HideInInspector] _Cull ("__cull", Float) = 2
[HideInInspector] _SoftParticlesEnabled ("__softparticlesenabled", Float) = 0
[HideInInspector] _CameraFadingEnabled ("__camerafadingenabled", Float) = 0
[HideInInspector] _SoftParticleFadeParams ("__softparticlefadeparams", Vector) = (0,0,0,0)
[HideInInspector] _CameraFadeParams ("__camerafadeparams", Vector) = (0,0,0,0)
[HideInInspector] _ColorAddSubDiff ("__coloraddsubdiff", Vector) = (0,0,0,0)
[HideInInspector] _DistortionStrengthScaled ("__distortionstrengthscaled", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PerformanceChecks" = "False" "PreviewType" = "Plane" "RenderType" = "Opaque" }
 GrabPass {
  "_GrabTexture"
}
 Pass {
  Name "ShadowCaster"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "SHADOWCASTER" "PerformanceChecks" = "False" "PreviewType" = "Plane" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ColorMask RGB 0
  Cull Off
  GpuProgramID 18548
Program "vp" {
SubProgram "d3d11 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"// hash: c9174ba48a629292
cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[7];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = dot(v1.xyz, cb2[4].xyz);
  r0.y = dot(v1.xyz, cb2[5].xyz);
  r0.z = dot(v1.xyz, cb2[6].xyz);
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r1.xyzw = cb2[1].xyzw * v0.yyyy;
  r1.xyzw = cb2[0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb2[2].xyzw * v0.zzzz + r1.xyzw;
  r1.xyzw = cb2[3].xyzw * v0.wwww + r1.xyzw;
  r2.xyz = -r1.xyz * cb0[0].www + cb0[0].xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r2.xyz * r0.www;
  r0.w = dot(r0.xyz, r2.xyz);
  r0.w = -r0.w * r0.w + 1;
  r0.w = sqrt(r0.w);
  r0.w = cb1[5].z * r0.w;
  r0.xyz = -r0.xyz * r0.www + r1.xyz;
  r0.w = cmp(cb1[5].z != 0.000000);
  r0.xyz = r0.www ? r0.xyz : r1.xyz;
  r2.xyzw = cb3[18].xyzw * r0.yyyy;
  r2.xyzw = cb3[17].xyzw * r0.xxxx + r2.xyzw;
  r0.xyzw = cb3[19].xyzw * r0.zzzz + r2.xyzw;
  r0.xyzw = cb3[20].xyzw * r1.wwww + r0.xyzw;
  r1.x = cb1[5].x / r0.w;
  r1.x = min(0, r1.x);
  r1.x = max(-1, r1.x);
  r0.z = r1.x + r0.z;
  r1.x = min(r0.z, r0.w);
  o0.xyw = r0.xyw;
  r0.x = r1.x + -r0.z;
  o0.z = cb1[5].y * r0.x + r0.z;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"// hash: c9174ba48a629292
cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[7];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = dot(v1.xyz, cb2[4].xyz);
  r0.y = dot(v1.xyz, cb2[5].xyz);
  r0.z = dot(v1.xyz, cb2[6].xyz);
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r1.xyzw = cb2[1].xyzw * v0.yyyy;
  r1.xyzw = cb2[0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb2[2].xyzw * v0.zzzz + r1.xyzw;
  r1.xyzw = cb2[3].xyzw * v0.wwww + r1.xyzw;
  r2.xyz = -r1.xyz * cb0[0].www + cb0[0].xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r2.xyz * r0.www;
  r0.w = dot(r0.xyz, r2.xyz);
  r0.w = -r0.w * r0.w + 1;
  r0.w = sqrt(r0.w);
  r0.w = cb1[5].z * r0.w;
  r0.xyz = -r0.xyz * r0.www + r1.xyz;
  r0.w = cmp(cb1[5].z != 0.000000);
  r0.xyz = r0.www ? r0.xyz : r1.xyz;
  r2.xyzw = cb3[18].xyzw * r0.yyyy;
  r2.xyzw = cb3[17].xyzw * r0.xxxx + r2.xyzw;
  r0.xyzw = cb3[19].xyzw * r0.zzzz + r2.xyzw;
  r0.xyzw = cb3[20].xyzw * r1.wwww + r0.xyzw;
  r1.x = cb1[5].x / r0.w;
  r1.x = min(0, r1.x);
  r1.x = max(-1, r1.x);
  r0.z = r1.x + r0.z;
  r1.x = min(r0.z, r0.w);
  o0.xyw = r0.xyw;
  r0.x = r1.x + -r0.z;
  o0.z = cb1[5].y * r0.x + r0.z;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"// hash: c9174ba48a629292
cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[7];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = dot(v1.xyz, cb2[4].xyz);
  r0.y = dot(v1.xyz, cb2[5].xyz);
  r0.z = dot(v1.xyz, cb2[6].xyz);
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r1.xyzw = cb2[1].xyzw * v0.yyyy;
  r1.xyzw = cb2[0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb2[2].xyzw * v0.zzzz + r1.xyzw;
  r1.xyzw = cb2[3].xyzw * v0.wwww + r1.xyzw;
  r2.xyz = -r1.xyz * cb0[0].www + cb0[0].xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r2.xyz * r0.www;
  r0.w = dot(r0.xyz, r2.xyz);
  r0.w = -r0.w * r0.w + 1;
  r0.w = sqrt(r0.w);
  r0.w = cb1[5].z * r0.w;
  r0.xyz = -r0.xyz * r0.www + r1.xyz;
  r0.w = cmp(cb1[5].z != 0.000000);
  r0.xyz = r0.www ? r0.xyz : r1.xyz;
  r2.xyzw = cb3[18].xyzw * r0.yyyy;
  r2.xyzw = cb3[17].xyzw * r0.xxxx + r2.xyzw;
  r0.xyzw = cb3[19].xyzw * r0.zzzz + r2.xyzw;
  r0.xyzw = cb3[20].xyzw * r1.wwww + r0.xyzw;
  r1.x = cb1[5].x / r0.w;
  r1.x = min(0, r1.x);
  r1.x = max(-1, r1.x);
  r0.z = r1.x + r0.z;
  r1.x = min(r0.z, r0.w);
  o0.xyw = r0.xyw;
  r0.x = r1.x + -r0.z;
  o0.z = cb1[5].y * r0.x + r0.z;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"// hash: 28c11e75d3d28c00
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"// hash: 28c11e75d3d28c00
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"// hash: 28c11e75d3d28c00
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: b897dbe2e0f9043
cbuffer cb4 : register(b4)
{
  float4 cb4[21];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[7];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[6];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[3];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : TEXCOORD1,
  out float4 o1 : TEXCOORD3,
  out float4 o2 : SV_POSITION0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  o0.xy = v3.xy * cb0[2].xy + cb0[2].zw;
  o1.xyzw = v2.xyzw;
  r0.x = dot(v1.xyz, cb3[4].xyz);
  r0.y = dot(v1.xyz, cb3[5].xyz);
  r0.z = dot(v1.xyz, cb3[6].xyz);
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r1.xyzw = cb3[1].xyzw * v0.yyyy;
  r1.xyzw = cb3[0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb3[2].xyzw * v0.zzzz + r1.xyzw;
  r1.xyzw = cb3[3].xyzw * v0.wwww + r1.xyzw;
  r2.xyz = -r1.xyz * cb1[0].www + cb1[0].xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r2.xyz * r0.www;
  r0.w = dot(r0.xyz, r2.xyz);
  r0.w = -r0.w * r0.w + 1;
  r0.w = sqrt(r0.w);
  r0.w = cb2[5].z * r0.w;
  r0.xyz = -r0.xyz * r0.www + r1.xyz;
  r0.w = cmp(cb2[5].z != 0.000000);
  r0.xyz = r0.www ? r0.xyz : r1.xyz;
  r2.xyzw = cb4[18].xyzw * r0.yyyy;
  r2.xyzw = cb4[17].xyzw * r0.xxxx + r2.xyzw;
  r0.xyzw = cb4[19].xyzw * r0.zzzz + r2.xyzw;
  r0.xyzw = cb4[20].xyzw * r1.wwww + r0.xyzw;
  r1.x = cb2[5].x / r0.w;
  r1.x = min(0, r1.x);
  r1.x = max(-1, r1.x);
  r0.z = r1.x + r0.z;
  r1.x = min(r0.z, r0.w);
  o2.xyw = r0.xyw;
  r0.x = r1.x + -r0.z;
  o2.z = cb2[5].y * r0.x + r0.z;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: b897dbe2e0f9043
cbuffer cb4 : register(b4)
{
  float4 cb4[21];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[7];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[6];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[3];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : TEXCOORD1,
  out float4 o1 : TEXCOORD3,
  out float4 o2 : SV_POSITION0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  o0.xy = v3.xy * cb0[2].xy + cb0[2].zw;
  o1.xyzw = v2.xyzw;
  r0.x = dot(v1.xyz, cb3[4].xyz);
  r0.y = dot(v1.xyz, cb3[5].xyz);
  r0.z = dot(v1.xyz, cb3[6].xyz);
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r1.xyzw = cb3[1].xyzw * v0.yyyy;
  r1.xyzw = cb3[0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb3[2].xyzw * v0.zzzz + r1.xyzw;
  r1.xyzw = cb3[3].xyzw * v0.wwww + r1.xyzw;
  r2.xyz = -r1.xyz * cb1[0].www + cb1[0].xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r2.xyz * r0.www;
  r0.w = dot(r0.xyz, r2.xyz);
  r0.w = -r0.w * r0.w + 1;
  r0.w = sqrt(r0.w);
  r0.w = cb2[5].z * r0.w;
  r0.xyz = -r0.xyz * r0.www + r1.xyz;
  r0.w = cmp(cb2[5].z != 0.000000);
  r0.xyz = r0.www ? r0.xyz : r1.xyz;
  r2.xyzw = cb4[18].xyzw * r0.yyyy;
  r2.xyzw = cb4[17].xyzw * r0.xxxx + r2.xyzw;
  r0.xyzw = cb4[19].xyzw * r0.zzzz + r2.xyzw;
  r0.xyzw = cb4[20].xyzw * r1.wwww + r0.xyzw;
  r1.x = cb2[5].x / r0.w;
  r1.x = min(0, r1.x);
  r1.x = max(-1, r1.x);
  r0.z = r1.x + r0.z;
  r1.x = min(r0.z, r0.w);
  o2.xyw = r0.xyw;
  r0.x = r1.x + -r0.z;
  o2.z = cb2[5].y * r0.x + r0.z;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: b897dbe2e0f9043
cbuffer cb4 : register(b4)
{
  float4 cb4[21];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[7];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[6];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[3];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : TEXCOORD1,
  out float4 o1 : TEXCOORD3,
  out float4 o2 : SV_POSITION0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  o0.xy = v3.xy * cb0[2].xy + cb0[2].zw;
  o1.xyzw = v2.xyzw;
  r0.x = dot(v1.xyz, cb3[4].xyz);
  r0.y = dot(v1.xyz, cb3[5].xyz);
  r0.z = dot(v1.xyz, cb3[6].xyz);
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r1.xyzw = cb3[1].xyzw * v0.yyyy;
  r1.xyzw = cb3[0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb3[2].xyzw * v0.zzzz + r1.xyzw;
  r1.xyzw = cb3[3].xyzw * v0.wwww + r1.xyzw;
  r2.xyz = -r1.xyz * cb1[0].www + cb1[0].xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r2.xyz * r0.www;
  r0.w = dot(r0.xyz, r2.xyz);
  r0.w = -r0.w * r0.w + 1;
  r0.w = sqrt(r0.w);
  r0.w = cb2[5].z * r0.w;
  r0.xyz = -r0.xyz * r0.www + r1.xyz;
  r0.w = cmp(cb2[5].z != 0.000000);
  r0.xyz = r0.www ? r0.xyz : r1.xyz;
  r2.xyzw = cb4[18].xyzw * r0.yyyy;
  r2.xyzw = cb4[17].xyzw * r0.xxxx + r2.xyzw;
  r0.xyzw = cb4[19].xyzw * r0.zzzz + r2.xyzw;
  r0.xyzw = cb4[20].xyzw * r1.wwww + r0.xyzw;
  r1.x = cb2[5].x / r0.w;
  r1.x = min(0, r1.x);
  r1.x = max(-1, r1.x);
  r0.z = r1.x + r0.z;
  r1.x = min(r0.z, r0.w);
  o2.xyw = r0.xyw;
  r0.x = r1.x + -r0.z;
  o2.z = cb2[5].y * r0.x + r0.z;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: d4c46098da835f60
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat0 * vs_TEXCOORD3.w + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: d4c46098da835f60
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat0 * vs_TEXCOORD3.w + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: d4c46098da835f60
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat0 * vs_TEXCOORD3.w + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
"// hash: 2deff391763d0677
cbuffer cb4 : register(b4)
{
  float4 cb4[15];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb3[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb4[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb4[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb4[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r1.xyzw = cb4[r0.x+3].xyzw * v0.wwww + r1.xyzw;
  r0.y = cmp(cb1[5].z != 0.000000);
  if (r0.y != 0) {
    r2.x = dot(v1.xyz, cb4[r0.x+4].xyz);
    r2.y = dot(v1.xyz, cb4[r0.x+5].xyz);
    r2.z = dot(v1.xyz, cb4[r0.x+6].xyz);
    r0.x = dot(r2.xyz, r2.xyz);
    r0.x = rsqrt(r0.x);
    r0.xyz = r2.xyz * r0.xxx;
    r2.xyz = -r1.xyz * cb0[0].www + cb0[0].xyz;
    r0.w = dot(r2.xyz, r2.xyz);
    r0.w = rsqrt(r0.w);
    r2.xyz = r2.xyz * r0.www;
    r0.w = dot(r0.xyz, r2.xyz);
    r0.w = -r0.w * r0.w + 1;
    r0.w = sqrt(r0.w);
    r0.w = cb1[5].z * r0.w;
    r1.xyz = -r0.xyz * r0.www + r1.xyz;
  }
  r0.xyzw = cb2[18].xyzw * r1.yyyy;
  r0.xyzw = cb2[17].xyzw * r1.xxxx + r0.xyzw;
  r0.xyzw = cb2[19].xyzw * r1.zzzz + r0.xyzw;
  r0.xyzw = cb2[20].xyzw * r1.wwww + r0.xyzw;
  r1.x = cb1[5].x / r0.w;
  r1.x = min(0, r1.x);
  r1.x = max(-1, r1.x);
  r0.z = r1.x + r0.z;
  r1.x = min(r0.z, r0.w);
  r1.x = r1.x + -r0.z;
  o0.z = cb1[5].y * r1.x + r0.z;
  o0.xyw = r0.xyw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
"// hash: 2deff391763d0677
cbuffer cb4 : register(b4)
{
  float4 cb4[15];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb3[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb4[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb4[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb4[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r1.xyzw = cb4[r0.x+3].xyzw * v0.wwww + r1.xyzw;
  r0.y = cmp(cb1[5].z != 0.000000);
  if (r0.y != 0) {
    r2.x = dot(v1.xyz, cb4[r0.x+4].xyz);
    r2.y = dot(v1.xyz, cb4[r0.x+5].xyz);
    r2.z = dot(v1.xyz, cb4[r0.x+6].xyz);
    r0.x = dot(r2.xyz, r2.xyz);
    r0.x = rsqrt(r0.x);
    r0.xyz = r2.xyz * r0.xxx;
    r2.xyz = -r1.xyz * cb0[0].www + cb0[0].xyz;
    r0.w = dot(r2.xyz, r2.xyz);
    r0.w = rsqrt(r0.w);
    r2.xyz = r2.xyz * r0.www;
    r0.w = dot(r0.xyz, r2.xyz);
    r0.w = -r0.w * r0.w + 1;
    r0.w = sqrt(r0.w);
    r0.w = cb1[5].z * r0.w;
    r1.xyz = -r0.xyz * r0.www + r1.xyz;
  }
  r0.xyzw = cb2[18].xyzw * r1.yyyy;
  r0.xyzw = cb2[17].xyzw * r1.xxxx + r0.xyzw;
  r0.xyzw = cb2[19].xyzw * r1.zzzz + r0.xyzw;
  r0.xyzw = cb2[20].xyzw * r1.wwww + r0.xyzw;
  r1.x = cb1[5].x / r0.w;
  r1.x = min(0, r1.x);
  r1.x = max(-1, r1.x);
  r0.z = r1.x + r0.z;
  r1.x = min(r0.z, r0.w);
  r1.x = r1.x + -r0.z;
  o0.z = cb1[5].y * r1.x + r0.z;
  o0.xyw = r0.xyw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
"// hash: 2deff391763d0677
cbuffer cb4 : register(b4)
{
  float4 cb4[15];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb3[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb4[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb4[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb4[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r1.xyzw = cb4[r0.x+3].xyzw * v0.wwww + r1.xyzw;
  r0.y = cmp(cb1[5].z != 0.000000);
  if (r0.y != 0) {
    r2.x = dot(v1.xyz, cb4[r0.x+4].xyz);
    r2.y = dot(v1.xyz, cb4[r0.x+5].xyz);
    r2.z = dot(v1.xyz, cb4[r0.x+6].xyz);
    r0.x = dot(r2.xyz, r2.xyz);
    r0.x = rsqrt(r0.x);
    r0.xyz = r2.xyz * r0.xxx;
    r2.xyz = -r1.xyz * cb0[0].www + cb0[0].xyz;
    r0.w = dot(r2.xyz, r2.xyz);
    r0.w = rsqrt(r0.w);
    r2.xyz = r2.xyz * r0.www;
    r0.w = dot(r0.xyz, r2.xyz);
    r0.w = -r0.w * r0.w + 1;
    r0.w = sqrt(r0.w);
    r0.w = cb1[5].z * r0.w;
    r1.xyz = -r0.xyz * r0.www + r1.xyz;
  }
  r0.xyzw = cb2[18].xyzw * r1.yyyy;
  r0.xyzw = cb2[17].xyzw * r1.xxxx + r0.xyzw;
  r0.xyzw = cb2[19].xyzw * r1.zzzz + r0.xyzw;
  r0.xyzw = cb2[20].xyzw * r1.wwww + r0.xyzw;
  r1.x = cb1[5].x / r0.w;
  r1.x = min(0, r1.x);
  r1.x = max(-1, r1.x);
  r0.z = r1.x + r0.z;
  r1.x = min(r0.z, r0.w);
  r1.x = r1.x + -r0.z;
  o0.z = cb1[5].y * r1.x + r0.z;
  o0.xyw = r0.xyw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
"// hash: 37695e5b8cab1cb0
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb3 = unity_LightShadowBias.z!=0.0;
#endif
    if(u_xlatb3){
        u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
        u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
        u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
        u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
        u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat9 = inversesqrt(u_xlat9);
        u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
        u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
        u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
        u_xlat9 = sqrt(u_xlat9);
        u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
        u_xlat1.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
    }
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    u_xlat1.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat6;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
"// hash: 37695e5b8cab1cb0
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb3 = unity_LightShadowBias.z!=0.0;
#endif
    if(u_xlatb3){
        u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
        u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
        u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
        u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
        u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat9 = inversesqrt(u_xlat9);
        u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
        u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
        u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
        u_xlat9 = sqrt(u_xlat9);
        u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
        u_xlat1.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
    }
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    u_xlat1.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat6;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
"// hash: 37695e5b8cab1cb0
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb3 = unity_LightShadowBias.z!=0.0;
#endif
    if(u_xlatb3){
        u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
        u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
        u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
        u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
        u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat9 = inversesqrt(u_xlat9);
        u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
        u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
        u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
        u_xlat9 = sqrt(u_xlat9);
        u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
        u_xlat1.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
    }
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    u_xlat1.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat6;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: e492118c5c69f977
cbuffer cb5 : register(b5)
{
  float4 cb5[15];
}

cbuffer cb4 : register(b4)
{
  float4 cb4[1];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[6];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[3];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : TEXCOORD1,
  out float4 o1 : TEXCOORD3,
  out float4 o2 : SV_POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb4[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb5[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb5[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb5[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r1.xyzw = cb5[r0.x+3].xyzw * v0.wwww + r1.xyzw;
  r0.y = cmp(cb2[5].z != 0.000000);
  if (r0.y != 0) {
    r2.x = dot(v1.xyz, cb5[r0.x+4].xyz);
    r2.y = dot(v1.xyz, cb5[r0.x+5].xyz);
    r2.z = dot(v1.xyz, cb5[r0.x+6].xyz);
    r0.x = dot(r2.xyz, r2.xyz);
    r0.x = rsqrt(r0.x);
    r0.xyz = r2.xyz * r0.xxx;
    r2.xyz = -r1.xyz * cb1[0].www + cb1[0].xyz;
    r0.w = dot(r2.xyz, r2.xyz);
    r0.w = rsqrt(r0.w);
    r2.xyz = r2.xyz * r0.www;
    r0.w = dot(r0.xyz, r2.xyz);
    r0.w = -r0.w * r0.w + 1;
    r0.w = sqrt(r0.w);
    r0.w = cb2[5].z * r0.w;
    r1.xyz = -r0.xyz * r0.www + r1.xyz;
  }
  r0.xyzw = cb3[18].xyzw * r1.yyyy;
  r0.xyzw = cb3[17].xyzw * r1.xxxx + r0.xyzw;
  r0.xyzw = cb3[19].xyzw * r1.zzzz + r0.xyzw;
  r0.xyzw = cb3[20].xyzw * r1.wwww + r0.xyzw;
  r1.x = cb2[5].x / r0.w;
  r1.x = min(0, r1.x);
  r1.x = max(-1, r1.x);
  r0.z = r1.x + r0.z;
  r1.x = min(r0.z, r0.w);
  r1.x = r1.x + -r0.z;
  o2.z = cb2[5].y * r1.x + r0.z;
  o0.xy = v3.xy * cb0[2].xy + cb0[2].zw;
  o1.xyzw = v2.xyzw;
  o2.xyw = r0.xyw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: e492118c5c69f977
cbuffer cb5 : register(b5)
{
  float4 cb5[15];
}

cbuffer cb4 : register(b4)
{
  float4 cb4[1];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[6];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[3];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : TEXCOORD1,
  out float4 o1 : TEXCOORD3,
  out float4 o2 : SV_POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb4[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb5[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb5[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb5[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r1.xyzw = cb5[r0.x+3].xyzw * v0.wwww + r1.xyzw;
  r0.y = cmp(cb2[5].z != 0.000000);
  if (r0.y != 0) {
    r2.x = dot(v1.xyz, cb5[r0.x+4].xyz);
    r2.y = dot(v1.xyz, cb5[r0.x+5].xyz);
    r2.z = dot(v1.xyz, cb5[r0.x+6].xyz);
    r0.x = dot(r2.xyz, r2.xyz);
    r0.x = rsqrt(r0.x);
    r0.xyz = r2.xyz * r0.xxx;
    r2.xyz = -r1.xyz * cb1[0].www + cb1[0].xyz;
    r0.w = dot(r2.xyz, r2.xyz);
    r0.w = rsqrt(r0.w);
    r2.xyz = r2.xyz * r0.www;
    r0.w = dot(r0.xyz, r2.xyz);
    r0.w = -r0.w * r0.w + 1;
    r0.w = sqrt(r0.w);
    r0.w = cb2[5].z * r0.w;
    r1.xyz = -r0.xyz * r0.www + r1.xyz;
  }
  r0.xyzw = cb3[18].xyzw * r1.yyyy;
  r0.xyzw = cb3[17].xyzw * r1.xxxx + r0.xyzw;
  r0.xyzw = cb3[19].xyzw * r1.zzzz + r0.xyzw;
  r0.xyzw = cb3[20].xyzw * r1.wwww + r0.xyzw;
  r1.x = cb2[5].x / r0.w;
  r1.x = min(0, r1.x);
  r1.x = max(-1, r1.x);
  r0.z = r1.x + r0.z;
  r1.x = min(r0.z, r0.w);
  r1.x = r1.x + -r0.z;
  o2.z = cb2[5].y * r1.x + r0.z;
  o0.xy = v3.xy * cb0[2].xy + cb0[2].zw;
  o1.xyzw = v2.xyzw;
  o2.xyw = r0.xyw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: e492118c5c69f977
cbuffer cb5 : register(b5)
{
  float4 cb5[15];
}

cbuffer cb4 : register(b4)
{
  float4 cb4[1];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[6];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[3];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : TEXCOORD1,
  out float4 o1 : TEXCOORD3,
  out float4 o2 : SV_POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb4[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb5[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb5[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb5[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r1.xyzw = cb5[r0.x+3].xyzw * v0.wwww + r1.xyzw;
  r0.y = cmp(cb2[5].z != 0.000000);
  if (r0.y != 0) {
    r2.x = dot(v1.xyz, cb5[r0.x+4].xyz);
    r2.y = dot(v1.xyz, cb5[r0.x+5].xyz);
    r2.z = dot(v1.xyz, cb5[r0.x+6].xyz);
    r0.x = dot(r2.xyz, r2.xyz);
    r0.x = rsqrt(r0.x);
    r0.xyz = r2.xyz * r0.xxx;
    r2.xyz = -r1.xyz * cb1[0].www + cb1[0].xyz;
    r0.w = dot(r2.xyz, r2.xyz);
    r0.w = rsqrt(r0.w);
    r2.xyz = r2.xyz * r0.www;
    r0.w = dot(r0.xyz, r2.xyz);
    r0.w = -r0.w * r0.w + 1;
    r0.w = sqrt(r0.w);
    r0.w = cb2[5].z * r0.w;
    r1.xyz = -r0.xyz * r0.www + r1.xyz;
  }
  r0.xyzw = cb3[18].xyzw * r1.yyyy;
  r0.xyzw = cb3[17].xyzw * r1.xxxx + r0.xyzw;
  r0.xyzw = cb3[19].xyzw * r1.zzzz + r0.xyzw;
  r0.xyzw = cb3[20].xyzw * r1.wwww + r0.xyzw;
  r1.x = cb2[5].x / r0.w;
  r1.x = min(0, r1.x);
  r1.x = max(-1, r1.x);
  r0.z = r1.x + r0.z;
  r1.x = min(r0.z, r0.w);
  r1.x = r1.x + -r0.z;
  o2.z = cb2[5].y * r1.x + r0.z;
  o0.xy = v3.xy * cb0[2].xy + cb0[2].zw;
  o1.xyzw = v2.xyzw;
  o2.xyw = r0.xyw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 38023e4303535f63
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb3 = unity_LightShadowBias.z!=0.0;
#endif
    if(u_xlatb3){
        u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
        u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
        u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
        u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
        u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat9 = inversesqrt(u_xlat9);
        u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
        u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
        u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
        u_xlat9 = sqrt(u_xlat9);
        u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
        u_xlat1.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
    }
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    u_xlat1.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3 = in_COLOR0;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler3D _DitherMaskLOD;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
mediump float u_xlat16_7;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat0 * vs_TEXCOORD3.w;
    u_xlat16_7 = u_xlat16_1 * 0.9375;
    u_xlat1.z = u_xlat16_7;
    u_xlat1.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
    u_xlat0 = texture(_DitherMaskLOD, u_xlat1.xyz).w;
    u_xlat16_2 = u_xlat0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_2<0.0);
#else
    u_xlatb0 = u_xlat16_2<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 38023e4303535f63
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb3 = unity_LightShadowBias.z!=0.0;
#endif
    if(u_xlatb3){
        u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
        u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
        u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
        u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
        u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat9 = inversesqrt(u_xlat9);
        u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
        u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
        u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
        u_xlat9 = sqrt(u_xlat9);
        u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
        u_xlat1.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
    }
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    u_xlat1.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3 = in_COLOR0;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler3D _DitherMaskLOD;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
mediump float u_xlat16_7;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat0 * vs_TEXCOORD3.w;
    u_xlat16_7 = u_xlat16_1 * 0.9375;
    u_xlat1.z = u_xlat16_7;
    u_xlat1.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
    u_xlat0 = texture(_DitherMaskLOD, u_xlat1.xyz).w;
    u_xlat16_2 = u_xlat0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_2<0.0);
#else
    u_xlatb0 = u_xlat16_2<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 38023e4303535f63
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb3 = unity_LightShadowBias.z!=0.0;
#endif
    if(u_xlatb3){
        u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
        u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
        u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
        u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
        u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat9 = inversesqrt(u_xlat9);
        u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
        u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
        u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
        u_xlat9 = sqrt(u_xlat9);
        u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
        u_xlat1.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
    }
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    u_xlat1.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat6;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3 = in_COLOR0;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler3D _DitherMaskLOD;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
mediump float u_xlat16_7;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat0 * vs_TEXCOORD3.w;
    u_xlat16_7 = u_xlat16_1 * 0.9375;
    u_xlat1.z = u_xlat16_7;
    u_xlat1.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
    u_xlat0 = texture(_DitherMaskLOD, u_xlat1.xyz).w;
    u_xlat16_2 = u_xlat0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_2<0.0);
#else
    u_xlatb0 = u_xlat16_2<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
"// hash: 61ea48c1c2620714
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb3[0].x);
  r1.x = t0[r0.x].val[24/4+1];
  r1.y = t0[r0.x].val[24/4+2];
  r1.z = t0[r0.x].val[24/4];
  r2.z = r1.y;
  r3.x = t0[r0.x].val[0/4+1];
  r3.y = t0[r0.x].val[0/4];
  r3.z = t0[r0.x].val[0/4+2];
  r2.x = r3.z;
  r0.y = t0[r0.x].val[12/4];
  r0.z = t0[r0.x].val[12/4+1];
  r0.w = t0[r0.x].val[12/4+2];
  r4.x = t0[r0.x].val[36/4];
  r4.y = t0[r0.x].val[36/4+1];
  r4.z = t0[r0.x].val[36/4+2];
  r2.y = r0.w;
  r3.z = r1.x;
  r1.x = r3.y;
  r1.y = r0.y;
  r3.y = r0.z;
  r0.xyz = r1.yzx * r2.zxy;
  r0.xyz = r1.zxy * r2.yzx + -r0.xyz;
  r5.xyz = r3.zxy * r2.yzx;
  r5.xyz = r3.yzx * r2.zxy + -r5.xyz;
  r0.w = dot(r1.xyz, r5.xyz);
  r0.w = rcp(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r0.y = dot(v1.xyz, r0.xyz);
  r6.xyz = r3.yzx * r1.zxy;
  r6.xyz = r1.yzx * r3.zxy + -r6.xyz;
  r6.xyz = r6.xyz * r0.www;
  r5.xyz = r5.xyz * r0.www;
  r0.x = dot(v1.xyz, r5.xyz);
  r0.z = dot(v1.xyz, r6.xyz);
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r1.w = r4.x;
  r1.x = dot(r1.xyzw, v0.xyzw);
  r3.w = r4.y;
  r2.w = r4.z;
  r1.z = dot(r2.xyzw, v0.xyzw);
  r1.y = dot(r3.xyzw, v0.xyzw);
  r2.xyz = -r1.xyz * cb0[0].www + cb0[0].xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r2.xyz * r0.www;
  r0.w = dot(r0.xyz, r2.xyz);
  r0.w = -r0.w * r0.w + 1;
  r0.w = sqrt(r0.w);
  r0.w = cb1[5].z * r0.w;
  r0.xyz = -r0.xyz * r0.www + r1.xyz;
  r0.w = cmp(cb1[5].z != 0.000000);
  r0.xyz = r0.www ? r0.xyz : r1.xyz;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r0.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  r0.xyzw = cb2[20].xyzw * v0.wwww + r0.xyzw;
  r1.x = cb1[5].x / r0.w;
  r1.x = min(0, r1.x);
  r1.x = max(-1, r1.x);
  r0.z = r1.x + r0.z;
  r1.x = min(r0.z, r0.w);
  o0.xyw = r0.xyw;
  r0.x = r1.x + -r0.z;
  o0.z = cb1[5].y * r0.x + r0.z;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
"// hash: 61ea48c1c2620714
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb3[0].x);
  r1.x = t0[r0.x].val[24/4+1];
  r1.y = t0[r0.x].val[24/4+2];
  r1.z = t0[r0.x].val[24/4];
  r2.z = r1.y;
  r3.x = t0[r0.x].val[0/4+1];
  r3.y = t0[r0.x].val[0/4];
  r3.z = t0[r0.x].val[0/4+2];
  r2.x = r3.z;
  r0.y = t0[r0.x].val[12/4];
  r0.z = t0[r0.x].val[12/4+1];
  r0.w = t0[r0.x].val[12/4+2];
  r4.x = t0[r0.x].val[36/4];
  r4.y = t0[r0.x].val[36/4+1];
  r4.z = t0[r0.x].val[36/4+2];
  r2.y = r0.w;
  r3.z = r1.x;
  r1.x = r3.y;
  r1.y = r0.y;
  r3.y = r0.z;
  r0.xyz = r1.yzx * r2.zxy;
  r0.xyz = r1.zxy * r2.yzx + -r0.xyz;
  r5.xyz = r3.zxy * r2.yzx;
  r5.xyz = r3.yzx * r2.zxy + -r5.xyz;
  r0.w = dot(r1.xyz, r5.xyz);
  r0.w = rcp(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r0.y = dot(v1.xyz, r0.xyz);
  r6.xyz = r3.yzx * r1.zxy;
  r6.xyz = r1.yzx * r3.zxy + -r6.xyz;
  r6.xyz = r6.xyz * r0.www;
  r5.xyz = r5.xyz * r0.www;
  r0.x = dot(v1.xyz, r5.xyz);
  r0.z = dot(v1.xyz, r6.xyz);
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r1.w = r4.x;
  r1.x = dot(r1.xyzw, v0.xyzw);
  r3.w = r4.y;
  r2.w = r4.z;
  r1.z = dot(r2.xyzw, v0.xyzw);
  r1.y = dot(r3.xyzw, v0.xyzw);
  r2.xyz = -r1.xyz * cb0[0].www + cb0[0].xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r2.xyz * r0.www;
  r0.w = dot(r0.xyz, r2.xyz);
  r0.w = -r0.w * r0.w + 1;
  r0.w = sqrt(r0.w);
  r0.w = cb1[5].z * r0.w;
  r0.xyz = -r0.xyz * r0.www + r1.xyz;
  r0.w = cmp(cb1[5].z != 0.000000);
  r0.xyz = r0.www ? r0.xyz : r1.xyz;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r0.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  r0.xyzw = cb2[20].xyzw * v0.wwww + r0.xyzw;
  r1.x = cb1[5].x / r0.w;
  r1.x = min(0, r1.x);
  r1.x = max(-1, r1.x);
  r0.z = r1.x + r0.z;
  r1.x = min(r0.z, r0.w);
  o0.xyw = r0.xyw;
  r0.x = r1.x + -r0.z;
  o0.z = cb1[5].y * r0.x + r0.z;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
"// hash: 61ea48c1c2620714
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb3[0].x);
  r1.x = t0[r0.x].val[24/4+1];
  r1.y = t0[r0.x].val[24/4+2];
  r1.z = t0[r0.x].val[24/4];
  r2.z = r1.y;
  r3.x = t0[r0.x].val[0/4+1];
  r3.y = t0[r0.x].val[0/4];
  r3.z = t0[r0.x].val[0/4+2];
  r2.x = r3.z;
  r0.y = t0[r0.x].val[12/4];
  r0.z = t0[r0.x].val[12/4+1];
  r0.w = t0[r0.x].val[12/4+2];
  r4.x = t0[r0.x].val[36/4];
  r4.y = t0[r0.x].val[36/4+1];
  r4.z = t0[r0.x].val[36/4+2];
  r2.y = r0.w;
  r3.z = r1.x;
  r1.x = r3.y;
  r1.y = r0.y;
  r3.y = r0.z;
  r0.xyz = r1.yzx * r2.zxy;
  r0.xyz = r1.zxy * r2.yzx + -r0.xyz;
  r5.xyz = r3.zxy * r2.yzx;
  r5.xyz = r3.yzx * r2.zxy + -r5.xyz;
  r0.w = dot(r1.xyz, r5.xyz);
  r0.w = rcp(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r0.y = dot(v1.xyz, r0.xyz);
  r6.xyz = r3.yzx * r1.zxy;
  r6.xyz = r1.yzx * r3.zxy + -r6.xyz;
  r6.xyz = r6.xyz * r0.www;
  r5.xyz = r5.xyz * r0.www;
  r0.x = dot(v1.xyz, r5.xyz);
  r0.z = dot(v1.xyz, r6.xyz);
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r1.w = r4.x;
  r1.x = dot(r1.xyzw, v0.xyzw);
  r3.w = r4.y;
  r2.w = r4.z;
  r1.z = dot(r2.xyzw, v0.xyzw);
  r1.y = dot(r3.xyzw, v0.xyzw);
  r2.xyz = -r1.xyz * cb0[0].www + cb0[0].xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r2.xyz * r0.www;
  r0.w = dot(r0.xyz, r2.xyz);
  r0.w = -r0.w * r0.w + 1;
  r0.w = sqrt(r0.w);
  r0.w = cb1[5].z * r0.w;
  r0.xyz = -r0.xyz * r0.www + r1.xyz;
  r0.w = cmp(cb1[5].z != 0.000000);
  r0.xyz = r0.www ? r0.xyz : r1.xyz;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r0.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  r0.xyzw = cb2[20].xyzw * v0.wwww + r0.xyzw;
  r1.x = cb1[5].x / r0.w;
  r1.x = min(0, r1.x);
  r1.x = max(-1, r1.x);
  r0.z = r1.x + r0.z;
  r1.x = min(r0.z, r0.w);
  o0.xyw = r0.xyw;
  r0.x = r1.x + -r0.z;
  o0.z = cb1[5].y * r0.x + r0.z;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
"// hash: 6bec01f967961d48
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat1.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 0]));
    u_xlat2.z = u_xlat1.y;
    u_xlat3.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 2]));
    u_xlat2.x = u_xlat3.z;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 2]));
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 2]));
    u_xlat2.y = u_xlat7.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat1.x = u_xlat3.y;
    u_xlat1.y = u_xlat7.x;
    u_xlat3.y = u_xlat7.y;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat0.xyz);
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat5.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat21 = float(1.0) / float(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.zxy * u_xlat3.yzx;
    u_xlat6.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat6.xyz);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat5.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat6.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.w = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1, in_POSITION0);
    u_xlat3.w = u_xlat4.y;
    u_xlat2.w = u_xlat4.z;
    u_xlat1.z = dot(u_xlat2, in_POSITION0);
    u_xlat1.y = dot(u_xlat3, in_POSITION0);
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlatb21 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat14 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat14);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat14) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat14;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
"// hash: 6bec01f967961d48
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat1.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 0]));
    u_xlat2.z = u_xlat1.y;
    u_xlat3.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 2]));
    u_xlat2.x = u_xlat3.z;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 2]));
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 2]));
    u_xlat2.y = u_xlat7.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat1.x = u_xlat3.y;
    u_xlat1.y = u_xlat7.x;
    u_xlat3.y = u_xlat7.y;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat0.xyz);
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat5.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat21 = float(1.0) / float(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.zxy * u_xlat3.yzx;
    u_xlat6.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat6.xyz);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat5.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat6.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.w = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1, in_POSITION0);
    u_xlat3.w = u_xlat4.y;
    u_xlat2.w = u_xlat4.z;
    u_xlat1.z = dot(u_xlat2, in_POSITION0);
    u_xlat1.y = dot(u_xlat3, in_POSITION0);
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlatb21 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat14 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat14);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat14) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat14;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
"// hash: 6bec01f967961d48
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat1.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 0]));
    u_xlat2.z = u_xlat1.y;
    u_xlat3.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 2]));
    u_xlat2.x = u_xlat3.z;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 2]));
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 2]));
    u_xlat2.y = u_xlat7.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat1.x = u_xlat3.y;
    u_xlat1.y = u_xlat7.x;
    u_xlat3.y = u_xlat7.y;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat0.xyz);
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat5.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat21 = float(1.0) / float(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.zxy * u_xlat3.yzx;
    u_xlat6.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat6.xyz);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat5.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat6.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.w = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1, in_POSITION0);
    u_xlat3.w = u_xlat4.y;
    u_xlat2.w = u_xlat4.z;
    u_xlat1.z = dot(u_xlat2, in_POSITION0);
    u_xlat1.y = dot(u_xlat3, in_POSITION0);
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlatb21 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat14 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat14);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat14) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat14;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 8dfbdf3272e70b6a
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb4 : register(b4)
{
  float4 cb4[1];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[6];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : TEXCOORD1,
  out float4 o1 : TEXCOORD3,
  out float4 o2 : SV_POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb4[0].x);
  r0.y = t0[r0.x].val[52/4];
  r0.y = floor(r0.y);
  r0.z = r0.y / cb0[2].y;
  r0.z = floor(r0.z);
  r0.y = -r0.z * cb0[2].y + r0.y;
  r0.y = floor(r0.y);
  r1.x = cb0[2].z * r0.y;
  r0.y = 1 + -cb0[2].w;
  r1.y = -r0.z * cb0[2].w + r0.y;
  r0.yz = v3.xy * cb0[2].zw + r1.xy;
  r0.w = cmp(cb0[2].x != 0.000000);
  r0.yz = r0.ww ? r0.yz : v3.xy;
  o0.xy = r0.yz * cb0[4].xy + cb0[4].zw;
  o1.xyzw = v2.xyzw;
  r1.x = t0[r0.x].val[24/4+1];
  r1.y = t0[r0.x].val[24/4+2];
  r1.z = t0[r0.x].val[24/4];
  r2.z = r1.y;
  r3.x = t0[r0.x].val[0/4+1];
  r3.y = t0[r0.x].val[0/4];
  r3.z = t0[r0.x].val[0/4+2];
  r2.x = r3.z;
  r0.y = t0[r0.x].val[12/4];
  r0.z = t0[r0.x].val[12/4+1];
  r0.w = t0[r0.x].val[12/4+2];
  r4.x = t0[r0.x].val[36/4];
  r4.y = t0[r0.x].val[36/4+1];
  r4.z = t0[r0.x].val[36/4+2];
  r2.y = r0.w;
  r3.z = r1.x;
  r1.x = r3.y;
  r1.y = r0.y;
  r3.y = r0.z;
  r0.xyz = r1.yzx * r2.zxy;
  r0.xyz = r1.zxy * r2.yzx + -r0.xyz;
  r5.xyz = r3.zxy * r2.yzx;
  r5.xyz = r3.yzx * r2.zxy + -r5.xyz;
  r0.w = dot(r1.xyz, r5.xyz);
  r0.w = rcp(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r0.y = dot(v1.xyz, r0.xyz);
  r6.xyz = r3.yzx * r1.zxy;
  r6.xyz = r1.yzx * r3.zxy + -r6.xyz;
  r6.xyz = r6.xyz * r0.www;
  r5.xyz = r5.xyz * r0.www;
  r0.x = dot(v1.xyz, r5.xyz);
  r0.z = dot(v1.xyz, r6.xyz);
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r1.w = r4.x;
  r1.x = dot(r1.xyzw, v0.xyzw);
  r3.w = r4.y;
  r2.w = r4.z;
  r1.z = dot(r2.xyzw, v0.xyzw);
  r1.y = dot(r3.xyzw, v0.xyzw);
  r2.xyz = -r1.xyz * cb1[0].www + cb1[0].xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r2.xyz * r0.www;
  r0.w = dot(r0.xyz, r2.xyz);
  r0.w = -r0.w * r0.w + 1;
  r0.w = sqrt(r0.w);
  r0.w = cb2[5].z * r0.w;
  r0.xyz = -r0.xyz * r0.www + r1.xyz;
  r0.w = cmp(cb2[5].z != 0.000000);
  r0.xyz = r0.www ? r0.xyz : r1.xyz;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r0.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r0.xyzw = cb3[20].xyzw * v0.wwww + r0.xyzw;
  r1.x = cb2[5].x / r0.w;
  r1.x = min(0, r1.x);
  r1.x = max(-1, r1.x);
  r0.z = r1.x + r0.z;
  r1.x = min(r0.z, r0.w);
  o2.xyw = r0.xyw;
  r0.x = r1.x + -r0.z;
  o2.z = cb2[5].y * r0.x + r0.z;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 8dfbdf3272e70b6a
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb4 : register(b4)
{
  float4 cb4[1];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[6];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : TEXCOORD1,
  out float4 o1 : TEXCOORD3,
  out float4 o2 : SV_POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb4[0].x);
  r0.y = t0[r0.x].val[52/4];
  r0.y = floor(r0.y);
  r0.z = r0.y / cb0[2].y;
  r0.z = floor(r0.z);
  r0.y = -r0.z * cb0[2].y + r0.y;
  r0.y = floor(r0.y);
  r1.x = cb0[2].z * r0.y;
  r0.y = 1 + -cb0[2].w;
  r1.y = -r0.z * cb0[2].w + r0.y;
  r0.yz = v3.xy * cb0[2].zw + r1.xy;
  r0.w = cmp(cb0[2].x != 0.000000);
  r0.yz = r0.ww ? r0.yz : v3.xy;
  o0.xy = r0.yz * cb0[4].xy + cb0[4].zw;
  o1.xyzw = v2.xyzw;
  r1.x = t0[r0.x].val[24/4+1];
  r1.y = t0[r0.x].val[24/4+2];
  r1.z = t0[r0.x].val[24/4];
  r2.z = r1.y;
  r3.x = t0[r0.x].val[0/4+1];
  r3.y = t0[r0.x].val[0/4];
  r3.z = t0[r0.x].val[0/4+2];
  r2.x = r3.z;
  r0.y = t0[r0.x].val[12/4];
  r0.z = t0[r0.x].val[12/4+1];
  r0.w = t0[r0.x].val[12/4+2];
  r4.x = t0[r0.x].val[36/4];
  r4.y = t0[r0.x].val[36/4+1];
  r4.z = t0[r0.x].val[36/4+2];
  r2.y = r0.w;
  r3.z = r1.x;
  r1.x = r3.y;
  r1.y = r0.y;
  r3.y = r0.z;
  r0.xyz = r1.yzx * r2.zxy;
  r0.xyz = r1.zxy * r2.yzx + -r0.xyz;
  r5.xyz = r3.zxy * r2.yzx;
  r5.xyz = r3.yzx * r2.zxy + -r5.xyz;
  r0.w = dot(r1.xyz, r5.xyz);
  r0.w = rcp(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r0.y = dot(v1.xyz, r0.xyz);
  r6.xyz = r3.yzx * r1.zxy;
  r6.xyz = r1.yzx * r3.zxy + -r6.xyz;
  r6.xyz = r6.xyz * r0.www;
  r5.xyz = r5.xyz * r0.www;
  r0.x = dot(v1.xyz, r5.xyz);
  r0.z = dot(v1.xyz, r6.xyz);
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r1.w = r4.x;
  r1.x = dot(r1.xyzw, v0.xyzw);
  r3.w = r4.y;
  r2.w = r4.z;
  r1.z = dot(r2.xyzw, v0.xyzw);
  r1.y = dot(r3.xyzw, v0.xyzw);
  r2.xyz = -r1.xyz * cb1[0].www + cb1[0].xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r2.xyz * r0.www;
  r0.w = dot(r0.xyz, r2.xyz);
  r0.w = -r0.w * r0.w + 1;
  r0.w = sqrt(r0.w);
  r0.w = cb2[5].z * r0.w;
  r0.xyz = -r0.xyz * r0.www + r1.xyz;
  r0.w = cmp(cb2[5].z != 0.000000);
  r0.xyz = r0.www ? r0.xyz : r1.xyz;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r0.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r0.xyzw = cb3[20].xyzw * v0.wwww + r0.xyzw;
  r1.x = cb2[5].x / r0.w;
  r1.x = min(0, r1.x);
  r1.x = max(-1, r1.x);
  r0.z = r1.x + r0.z;
  r1.x = min(r0.z, r0.w);
  o2.xyw = r0.xyw;
  r0.x = r1.x + -r0.z;
  o2.z = cb2[5].y * r0.x + r0.z;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 8dfbdf3272e70b6a
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb4 : register(b4)
{
  float4 cb4[1];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[6];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : TEXCOORD1,
  out float4 o1 : TEXCOORD3,
  out float4 o2 : SV_POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb4[0].x);
  r0.y = t0[r0.x].val[52/4];
  r0.y = floor(r0.y);
  r0.z = r0.y / cb0[2].y;
  r0.z = floor(r0.z);
  r0.y = -r0.z * cb0[2].y + r0.y;
  r0.y = floor(r0.y);
  r1.x = cb0[2].z * r0.y;
  r0.y = 1 + -cb0[2].w;
  r1.y = -r0.z * cb0[2].w + r0.y;
  r0.yz = v3.xy * cb0[2].zw + r1.xy;
  r0.w = cmp(cb0[2].x != 0.000000);
  r0.yz = r0.ww ? r0.yz : v3.xy;
  o0.xy = r0.yz * cb0[4].xy + cb0[4].zw;
  o1.xyzw = v2.xyzw;
  r1.x = t0[r0.x].val[24/4+1];
  r1.y = t0[r0.x].val[24/4+2];
  r1.z = t0[r0.x].val[24/4];
  r2.z = r1.y;
  r3.x = t0[r0.x].val[0/4+1];
  r3.y = t0[r0.x].val[0/4];
  r3.z = t0[r0.x].val[0/4+2];
  r2.x = r3.z;
  r0.y = t0[r0.x].val[12/4];
  r0.z = t0[r0.x].val[12/4+1];
  r0.w = t0[r0.x].val[12/4+2];
  r4.x = t0[r0.x].val[36/4];
  r4.y = t0[r0.x].val[36/4+1];
  r4.z = t0[r0.x].val[36/4+2];
  r2.y = r0.w;
  r3.z = r1.x;
  r1.x = r3.y;
  r1.y = r0.y;
  r3.y = r0.z;
  r0.xyz = r1.yzx * r2.zxy;
  r0.xyz = r1.zxy * r2.yzx + -r0.xyz;
  r5.xyz = r3.zxy * r2.yzx;
  r5.xyz = r3.yzx * r2.zxy + -r5.xyz;
  r0.w = dot(r1.xyz, r5.xyz);
  r0.w = rcp(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r0.y = dot(v1.xyz, r0.xyz);
  r6.xyz = r3.yzx * r1.zxy;
  r6.xyz = r1.yzx * r3.zxy + -r6.xyz;
  r6.xyz = r6.xyz * r0.www;
  r5.xyz = r5.xyz * r0.www;
  r0.x = dot(v1.xyz, r5.xyz);
  r0.z = dot(v1.xyz, r6.xyz);
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r1.w = r4.x;
  r1.x = dot(r1.xyzw, v0.xyzw);
  r3.w = r4.y;
  r2.w = r4.z;
  r1.z = dot(r2.xyzw, v0.xyzw);
  r1.y = dot(r3.xyzw, v0.xyzw);
  r2.xyz = -r1.xyz * cb1[0].www + cb1[0].xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r2.xyz * r0.www;
  r0.w = dot(r0.xyz, r2.xyz);
  r0.w = -r0.w * r0.w + 1;
  r0.w = sqrt(r0.w);
  r0.w = cb2[5].z * r0.w;
  r0.xyz = -r0.xyz * r0.www + r1.xyz;
  r0.w = cmp(cb2[5].z != 0.000000);
  r0.xyz = r0.www ? r0.xyz : r1.xyz;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r0.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r0.xyzw = cb3[20].xyzw * v0.wwww + r0.xyzw;
  r1.x = cb2[5].x / r0.w;
  r1.x = min(0, r1.x);
  r1.x = max(-1, r1.x);
  r0.z = r1.x + r0.z;
  r1.x = min(r0.z, r0.w);
  o2.xyw = r0.xyw;
  r0.x = r1.x + -r0.z;
  o2.z = cb2[5].y * r0.x + r0.z;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: d1a684b1c82a6b10
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec2 vs_TEXCOORD1;
layout(location = 1) out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat7.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(52 >> 2) + 0]);
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat14 = u_xlat7.x / unity_ParticleUVShiftData.y;
    u_xlat14 = floor(u_xlat14);
    u_xlat7.x = (-u_xlat14) * unity_ParticleUVShiftData.y + u_xlat7.x;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = u_xlat7.x * unity_ParticleUVShiftData.z;
    u_xlat7.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat14) * unity_ParticleUVShiftData.w + u_xlat7.x;
    u_xlat7.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb21 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat7.xy = (bool(u_xlatb21)) ? u_xlat7.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat7.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat1.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 0]));
    u_xlat2.z = u_xlat1.y;
    u_xlat3.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 2]));
    u_xlat2.x = u_xlat3.z;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 2]));
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 2]));
    u_xlat2.y = u_xlat7.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat1.x = u_xlat3.y;
    u_xlat1.y = u_xlat7.x;
    u_xlat3.y = u_xlat7.y;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat0.xyz);
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat5.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat21 = float(1.0) / float(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.zxy * u_xlat3.yzx;
    u_xlat6.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat6.xyz);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat5.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat6.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.w = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1, in_POSITION0);
    u_xlat3.w = u_xlat4.y;
    u_xlat2.w = u_xlat4.z;
    u_xlat1.z = dot(u_xlat2, in_POSITION0);
    u_xlat1.y = dot(u_xlat3, in_POSITION0);
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlatb21 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat14 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat14);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat14) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat14;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler3D _DitherMaskLOD;
layout(location = 0) in highp vec2 vs_TEXCOORD1;
layout(location = 1) in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
mediump float u_xlat16_7;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat0 * vs_TEXCOORD3.w;
    u_xlat16_7 = u_xlat16_1 * 0.9375;
    u_xlat1.z = u_xlat16_7;
    u_xlat1.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
    u_xlat0 = texture(_DitherMaskLOD, u_xlat1.xyz).w;
    u_xlat16_2 = u_xlat0 + -0.00999999978;
    u_xlatb0 = u_xlat16_2<0.0;
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: d1a684b1c82a6b10
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec2 vs_TEXCOORD1;
layout(location = 1) out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat7.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(52 >> 2) + 0]);
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat14 = u_xlat7.x / unity_ParticleUVShiftData.y;
    u_xlat14 = floor(u_xlat14);
    u_xlat7.x = (-u_xlat14) * unity_ParticleUVShiftData.y + u_xlat7.x;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = u_xlat7.x * unity_ParticleUVShiftData.z;
    u_xlat7.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat14) * unity_ParticleUVShiftData.w + u_xlat7.x;
    u_xlat7.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb21 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat7.xy = (bool(u_xlatb21)) ? u_xlat7.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat7.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat1.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 0]));
    u_xlat2.z = u_xlat1.y;
    u_xlat3.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 2]));
    u_xlat2.x = u_xlat3.z;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 2]));
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 2]));
    u_xlat2.y = u_xlat7.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat1.x = u_xlat3.y;
    u_xlat1.y = u_xlat7.x;
    u_xlat3.y = u_xlat7.y;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat0.xyz);
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat5.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat21 = float(1.0) / float(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.zxy * u_xlat3.yzx;
    u_xlat6.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat6.xyz);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat5.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat6.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.w = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1, in_POSITION0);
    u_xlat3.w = u_xlat4.y;
    u_xlat2.w = u_xlat4.z;
    u_xlat1.z = dot(u_xlat2, in_POSITION0);
    u_xlat1.y = dot(u_xlat3, in_POSITION0);
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlatb21 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat14 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat14);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat14) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat14;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler3D _DitherMaskLOD;
layout(location = 0) in highp vec2 vs_TEXCOORD1;
layout(location = 1) in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
mediump float u_xlat16_7;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat0 * vs_TEXCOORD3.w;
    u_xlat16_7 = u_xlat16_1 * 0.9375;
    u_xlat1.z = u_xlat16_7;
    u_xlat1.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
    u_xlat0 = texture(_DitherMaskLOD, u_xlat1.xyz).w;
    u_xlat16_2 = u_xlat0 + -0.00999999978;
    u_xlatb0 = u_xlat16_2<0.0;
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: d1a684b1c82a6b10
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec2 vs_TEXCOORD1;
layout(location = 1) out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat7.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(52 >> 2) + 0]);
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat14 = u_xlat7.x / unity_ParticleUVShiftData.y;
    u_xlat14 = floor(u_xlat14);
    u_xlat7.x = (-u_xlat14) * unity_ParticleUVShiftData.y + u_xlat7.x;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = u_xlat7.x * unity_ParticleUVShiftData.z;
    u_xlat7.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat14) * unity_ParticleUVShiftData.w + u_xlat7.x;
    u_xlat7.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb21 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat7.xy = (bool(u_xlatb21)) ? u_xlat7.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat7.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat1.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 0]));
    u_xlat2.z = u_xlat1.y;
    u_xlat3.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 2]));
    u_xlat2.x = u_xlat3.z;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 2]));
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 2]));
    u_xlat2.y = u_xlat7.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat1.x = u_xlat3.y;
    u_xlat1.y = u_xlat7.x;
    u_xlat3.y = u_xlat7.y;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat0.xyz);
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat5.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat21 = float(1.0) / float(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.zxy * u_xlat3.yzx;
    u_xlat6.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat6.xyz);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat5.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat6.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.w = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1, in_POSITION0);
    u_xlat3.w = u_xlat4.y;
    u_xlat2.w = u_xlat4.z;
    u_xlat1.z = dot(u_xlat2, in_POSITION0);
    u_xlat1.y = dot(u_xlat3, in_POSITION0);
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlatb21 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat14 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat14);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat14) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat14;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler3D _DitherMaskLOD;
layout(location = 0) in highp vec2 vs_TEXCOORD1;
layout(location = 1) in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
mediump float u_xlat16_7;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat0 * vs_TEXCOORD3.w;
    u_xlat16_7 = u_xlat16_1 * 0.9375;
    u_xlat1.z = u_xlat16_7;
    u_xlat1.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
    u_xlat0 = texture(_DitherMaskLOD, u_xlat1.xyz).w;
    u_xlat16_2 = u_xlat0 + -0.00999999978;
    u_xlatb0 = u_xlat16_2<0.0;
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "d3d11 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"// hash: 2b1e982392fa63ca



// 3Dmigoto declarations
#define cmp -


void main(
  out float4 o0 : SV_Target0)
{
  o0.xyzw = float4(0,0,0,0);
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"// hash: 2b1e982392fa63ca



// 3Dmigoto declarations
#define cmp -


void main(
  out float4 o0 : SV_Target0)
{
  o0.xyzw = float4(0,0,0,0);
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"// hash: 2b1e982392fa63ca



// 3Dmigoto declarations
#define cmp -


void main(
  out float4 o0 : SV_Target0)
{
  o0.xyzw = float4(0,0,0,0);
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 8a77084a1fabf49f
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD1,
  float4 v1 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v0.xy).xyzw;
  r0.x = r0.w * v1.w + -0.5;
  r0.x = cmp(r0.x < 0);
  if (r0.x != 0) discard;
  o0.xyzw = float4(0,0,0,0);
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 8a77084a1fabf49f
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD1,
  float4 v1 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v0.xy).xyzw;
  r0.x = r0.w * v1.w + -0.5;
  r0.x = cmp(r0.x < 0);
  if (r0.x != 0) discard;
  o0.xyzw = float4(0,0,0,0);
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 8a77084a1fabf49f
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD1,
  float4 v1 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v0.xy).xyzw;
  r0.x = r0.w * v1.w + -0.5;
  r0.x = cmp(r0.x < 0);
  if (r0.x != 0) discard;
  o0.xyzw = float4(0,0,0,0);
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
"// hash: 2b1e982392fa63ca



// 3Dmigoto declarations
#define cmp -


void main(
  out float4 o0 : SV_Target0)
{
  o0.xyzw = float4(0,0,0,0);
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
"// hash: 2b1e982392fa63ca



// 3Dmigoto declarations
#define cmp -


void main(
  out float4 o0 : SV_Target0)
{
  o0.xyzw = float4(0,0,0,0);
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
"// hash: 2b1e982392fa63ca



// 3Dmigoto declarations
#define cmp -


void main(
  out float4 o0 : SV_Target0)
{
  o0.xyzw = float4(0,0,0,0);
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: ee95cc00d6df1f4a
Texture3D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD1,
  float4 v1 : TEXCOORD3,
  float4 v2 : SV_Position0,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v0.xy).xyzw;
  r0.x = v1.w * r0.w;
  r0.z = 0.9375 * r0.x;
  r0.xy = float2(0.25,0.25) * v2.xy;
  r0.xyzw = t1.Sample(s1_s, r0.xyz).xyzw;
  r0.x = -0.00999999978 + r0.w;
  r0.x = cmp(r0.x < 0);
  if (r0.x != 0) discard;
  o0.xyzw = float4(0,0,0,0);
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: ee95cc00d6df1f4a
Texture3D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD1,
  float4 v1 : TEXCOORD3,
  float4 v2 : SV_Position0,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v0.xy).xyzw;
  r0.x = v1.w * r0.w;
  r0.z = 0.9375 * r0.x;
  r0.xy = float2(0.25,0.25) * v2.xy;
  r0.xyzw = t1.Sample(s1_s, r0.xyz).xyzw;
  r0.x = -0.00999999978 + r0.w;
  r0.x = cmp(r0.x < 0);
  if (r0.x != 0) discard;
  o0.xyzw = float4(0,0,0,0);
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: ee95cc00d6df1f4a
Texture3D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD1,
  float4 v1 : TEXCOORD3,
  float4 v2 : SV_Position0,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v0.xy).xyzw;
  r0.x = v1.w * r0.w;
  r0.z = 0.9375 * r0.x;
  r0.xy = float2(0.25,0.25) * v2.xy;
  r0.xyzw = t1.Sample(s1_s, r0.xyz).xyzw;
  r0.x = -0.00999999978 + r0.w;
  r0.x = cmp(r0.x < 0);
  if (r0.x != 0) discard;
  o0.xyzw = float4(0,0,0,0);
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
"// hash: 129e657d0aa4dac4



// 3Dmigoto declarations
#define cmp -


void main(
  out float4 o0 : SV_Target0)
{
  o0.xyzw = float4(0,0,0,0);
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
"// hash: 129e657d0aa4dac4



// 3Dmigoto declarations
#define cmp -


void main(
  out float4 o0 : SV_Target0)
{
  o0.xyzw = float4(0,0,0,0);
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
"// hash: 129e657d0aa4dac4



// 3Dmigoto declarations
#define cmp -


void main(
  out float4 o0 : SV_Target0)
{
  o0.xyzw = float4(0,0,0,0);
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 79ee1b0eb7eeadd7
Texture3D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD1,
  float4 v1 : TEXCOORD3,
  float4 v2 : SV_Position0,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = t0.Sample(s0_s, v0.xy).w;
  r0.x = v1.w * r0.x;
  r0.z = 0.9375 * r0.x;
  r0.xy = float2(0.25,0.25) * v2.xy;
  r0.x = t1.Sample(s1_s, r0.xyz).w;
  r0.x = -0.00999999978 + r0.x;
  r0.x = cmp(r0.x < 0);
  if (r0.x != 0) discard;
  o0.xyzw = float4(0,0,0,0);
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 79ee1b0eb7eeadd7
Texture3D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD1,
  float4 v1 : TEXCOORD3,
  float4 v2 : SV_Position0,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = t0.Sample(s0_s, v0.xy).w;
  r0.x = v1.w * r0.x;
  r0.z = 0.9375 * r0.x;
  r0.xy = float2(0.25,0.25) * v2.xy;
  r0.x = t1.Sample(s1_s, r0.xyz).w;
  r0.x = -0.00999999978 + r0.x;
  r0.x = cmp(r0.x < 0);
  if (r0.x != 0) discard;
  o0.xyzw = float4(0,0,0,0);
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 79ee1b0eb7eeadd7
Texture3D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD1,
  float4 v1 : TEXCOORD3,
  float4 v2 : SV_Position0,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = t0.Sample(s0_s, v0.xy).w;
  r0.x = v1.w * r0.x;
  r0.z = 0.9375 * r0.x;
  r0.xy = float2(0.25,0.25) * v2.xy;
  r0.x = t1.Sample(s1_s, r0.xyz).w;
  r0.x = -0.00999999978 + r0.x;
  r0.x = cmp(r0.x < 0);
  if (r0.x != 0) discard;
  o0.xyzw = float4(0,0,0,0);
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
}
}
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "PreviewType" = "Plane" "RenderType" = "Opaque" }
  Blend Zero Zero, Zero Zero
  ColorMask RGB 0
  ZWrite Off
  Cull Off
  GpuProgramID 253844
Program "vp" {
SubProgram "d3d11 hw_tier00 " {
"// hash: 30cc3a24d1d4a6ed
cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[4];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float2 o2 : TEXCOORD1)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb1[1].xyzw * v0.yyyy;
  r0.xyzw = cb1[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb1[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb1[3].xyzw + r0.xyzw;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  o0.xyzw = cb2[20].xyzw * r0.wwww + r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
"// hash: 30cc3a24d1d4a6ed
cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[4];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float2 o2 : TEXCOORD1)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb1[1].xyzw * v0.yyyy;
  r0.xyzw = cb1[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb1[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb1[3].xyzw + r0.xyzw;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  o0.xyzw = cb2[20].xyzw * r0.wwww + r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
"// hash: 30cc3a24d1d4a6ed
cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[4];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float2 o2 : TEXCOORD1)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb1[1].xyzw * v0.yyyy;
  r0.xyzw = cb1[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb1[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb1[3].xyzw + r0.xyzw;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  o0.xyzw = cb2[20].xyzw * r0.wwww + r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
"// hash: acba3b225609f9ae
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"// hash: acba3b225609f9ae
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"// hash: acba3b225609f9ae
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 30cc3a24d1d4a6ed
cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[4];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float2 o2 : TEXCOORD1)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb1[1].xyzw * v0.yyyy;
  r0.xyzw = cb1[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb1[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb1[3].xyzw + r0.xyzw;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  o0.xyzw = cb2[20].xyzw * r0.wwww + r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 30cc3a24d1d4a6ed
cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[4];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float2 o2 : TEXCOORD1)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb1[1].xyzw * v0.yyyy;
  r0.xyzw = cb1[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb1[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb1[3].xyzw + r0.xyzw;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  o0.xyzw = cb2[20].xyzw * r0.wwww + r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 30cc3a24d1d4a6ed
cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[4];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float2 o2 : TEXCOORD1)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb1[1].xyzw * v0.yyyy;
  r0.xyzw = cb1[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb1[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb1[3].xyzw + r0.xyzw;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  o0.xyzw = cb2[20].xyzw * r0.wwww + r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 3acbc15ece38a3f8
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 3acbc15ece38a3f8
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 3acbc15ece38a3f8
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "INSTANCING_ON" }
"// hash: b58815f13706954d
cbuffer cb3 : register(b3)
{
  float4 cb3[12];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float2 o2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb2[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb3[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb3[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb3[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb3[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb1[18].xyzw * r0.yyyy;
  r1.xyzw = cb1[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb1[19].xyzw * r0.zzzz + r1.xyzw;
  o0.xyzw = cb1[20].xyzw * r0.wwww + r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "INSTANCING_ON" }
"// hash: b58815f13706954d
cbuffer cb3 : register(b3)
{
  float4 cb3[12];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float2 o2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb2[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb3[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb3[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb3[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb3[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb1[18].xyzw * r0.yyyy;
  r1.xyzw = cb1[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb1[19].xyzw * r0.zzzz + r1.xyzw;
  o0.xyzw = cb1[20].xyzw * r0.wwww + r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "INSTANCING_ON" }
"// hash: b58815f13706954d
cbuffer cb3 : register(b3)
{
  float4 cb3[12];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float2 o2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb2[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb3[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb3[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb3[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb3[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb1[18].xyzw * r0.yyyy;
  r1.xyzw = cb1[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb1[19].xyzw * r0.zzzz + r1.xyzw;
  o0.xyzw = cb1[20].xyzw * r0.wwww + r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
"// hash: f0a74573dba1a1f
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
"// hash: f0a74573dba1a1f
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
"// hash: f0a74573dba1a1f
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: b58815f13706954d
cbuffer cb3 : register(b3)
{
  float4 cb3[12];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float2 o2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb2[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb3[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb3[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb3[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb3[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb1[18].xyzw * r0.yyyy;
  r1.xyzw = cb1[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb1[19].xyzw * r0.zzzz + r1.xyzw;
  o0.xyzw = cb1[20].xyzw * r0.wwww + r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: b58815f13706954d
cbuffer cb3 : register(b3)
{
  float4 cb3[12];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float2 o2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb2[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb3[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb3[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb3[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb3[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb1[18].xyzw * r0.yyyy;
  r1.xyzw = cb1[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb1[19].xyzw * r0.zzzz + r1.xyzw;
  o0.xyzw = cb1[20].xyzw * r0.wwww + r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: b58815f13706954d
cbuffer cb3 : register(b3)
{
  float4 cb3[12];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float2 o2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb2[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb3[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb3[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb3[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb3[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb1[18].xyzw * r0.yyyy;
  r1.xyzw = cb1[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb1[19].xyzw * r0.zzzz + r1.xyzw;
  o0.xyzw = cb1[20].xyzw * r0.wwww + r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: b51fa2a396c59fc5
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: b51fa2a396c59fc5
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: b51fa2a396c59fc5
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
"// hash: 5871c67439f4e0c5
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float2 o2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb2[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb1[18].xyzw * r1.zzzz;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb1[17].xyzw * r1.yyyy + r3.xyzw;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r0.xyzw = cb1[19].xyzw * r0.xxxx + r3.xyzw;
  o0.xyzw = cb1[20].xyzw + r0.xyzw;
  r0.x = (int)r5.w & 255;
  r0.x = (uint)r0.x;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r1.w = (uint)r5.w >> 24;
  r0.yzw = (uint3)r1.yzw;
  r0.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r0.xyzw;
  r2.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r2.xyzw = cb0[5].xxxx * r2.xyzw + float4(1,1,1,1);
  o1.xyzw = r2.xyzw * r0.xyzw;
  r0.x = r1.x / cb0[4].y;
  r0.x = floor(r0.x);
  r0.y = -r0.x * cb0[4].y + r1.x;
  r0.y = floor(r0.y);
  r1.x = cb0[4].z * r0.y;
  r0.y = 1 + -cb0[4].w;
  r1.y = -r0.x * cb0[4].w + r0.y;
  r0.xy = v3.xy * cb0[4].zw + r1.xy;
  r0.z = cmp(cb0[4].x != 0.000000);
  r0.xy = r0.zz ? r0.xy : v3.xy;
  o2.xy = r0.xy * cb0[6].xy + cb0[6].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
"// hash: 5871c67439f4e0c5
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float2 o2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb2[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb1[18].xyzw * r1.zzzz;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb1[17].xyzw * r1.yyyy + r3.xyzw;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r0.xyzw = cb1[19].xyzw * r0.xxxx + r3.xyzw;
  o0.xyzw = cb1[20].xyzw + r0.xyzw;
  r0.x = (int)r5.w & 255;
  r0.x = (uint)r0.x;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r1.w = (uint)r5.w >> 24;
  r0.yzw = (uint3)r1.yzw;
  r0.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r0.xyzw;
  r2.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r2.xyzw = cb0[5].xxxx * r2.xyzw + float4(1,1,1,1);
  o1.xyzw = r2.xyzw * r0.xyzw;
  r0.x = r1.x / cb0[4].y;
  r0.x = floor(r0.x);
  r0.y = -r0.x * cb0[4].y + r1.x;
  r0.y = floor(r0.y);
  r1.x = cb0[4].z * r0.y;
  r0.y = 1 + -cb0[4].w;
  r1.y = -r0.x * cb0[4].w + r0.y;
  r0.xy = v3.xy * cb0[4].zw + r1.xy;
  r0.z = cmp(cb0[4].x != 0.000000);
  r0.xy = r0.zz ? r0.xy : v3.xy;
  o2.xy = r0.xy * cb0[6].xy + cb0[6].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
"// hash: 5871c67439f4e0c5
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float2 o2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb2[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb1[18].xyzw * r1.zzzz;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb1[17].xyzw * r1.yyyy + r3.xyzw;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r0.xyzw = cb1[19].xyzw * r0.xxxx + r3.xyzw;
  o0.xyzw = cb1[20].xyzw + r0.xyzw;
  r0.x = (int)r5.w & 255;
  r0.x = (uint)r0.x;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r1.w = (uint)r5.w >> 24;
  r0.yzw = (uint3)r1.yzw;
  r0.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r0.xyzw;
  r2.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r2.xyzw = cb0[5].xxxx * r2.xyzw + float4(1,1,1,1);
  o1.xyzw = r2.xyzw * r0.xyzw;
  r0.x = r1.x / cb0[4].y;
  r0.x = floor(r0.x);
  r0.y = -r0.x * cb0[4].y + r1.x;
  r0.y = floor(r0.y);
  r1.x = cb0[4].z * r0.y;
  r0.y = 1 + -cb0[4].w;
  r1.y = -r0.x * cb0[4].w + r0.y;
  r0.xy = v3.xy * cb0[4].zw + r1.xy;
  r0.z = cmp(cb0[4].x != 0.000000);
  r0.xy = r0.zz ? r0.xy : v3.xy;
  o2.xy = r0.xy * cb0[6].xy + cb0[6].zw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
"// hash: 37d3aab34f3f2769
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec2 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6 = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.x = u_xlat6 * unity_ParticleUVShiftData.z;
    u_xlat6 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat6;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
"// hash: 37d3aab34f3f2769
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec2 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6 = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.x = u_xlat6 * unity_ParticleUVShiftData.z;
    u_xlat6 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat6;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
"// hash: 37d3aab34f3f2769
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec2 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6 = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.x = u_xlat6 * unity_ParticleUVShiftData.z;
    u_xlat6 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat6;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 5871c67439f4e0c5
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float2 o2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb2[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb1[18].xyzw * r1.zzzz;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb1[17].xyzw * r1.yyyy + r3.xyzw;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r0.xyzw = cb1[19].xyzw * r0.xxxx + r3.xyzw;
  o0.xyzw = cb1[20].xyzw + r0.xyzw;
  r0.x = (int)r5.w & 255;
  r0.x = (uint)r0.x;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r1.w = (uint)r5.w >> 24;
  r0.yzw = (uint3)r1.yzw;
  r0.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r0.xyzw;
  r2.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r2.xyzw = cb0[5].xxxx * r2.xyzw + float4(1,1,1,1);
  o1.xyzw = r2.xyzw * r0.xyzw;
  r0.x = r1.x / cb0[4].y;
  r0.x = floor(r0.x);
  r0.y = -r0.x * cb0[4].y + r1.x;
  r0.y = floor(r0.y);
  r1.x = cb0[4].z * r0.y;
  r0.y = 1 + -cb0[4].w;
  r1.y = -r0.x * cb0[4].w + r0.y;
  r0.xy = v3.xy * cb0[4].zw + r1.xy;
  r0.z = cmp(cb0[4].x != 0.000000);
  r0.xy = r0.zz ? r0.xy : v3.xy;
  o2.xy = r0.xy * cb0[6].xy + cb0[6].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 5871c67439f4e0c5
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float2 o2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb2[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb1[18].xyzw * r1.zzzz;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb1[17].xyzw * r1.yyyy + r3.xyzw;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r0.xyzw = cb1[19].xyzw * r0.xxxx + r3.xyzw;
  o0.xyzw = cb1[20].xyzw + r0.xyzw;
  r0.x = (int)r5.w & 255;
  r0.x = (uint)r0.x;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r1.w = (uint)r5.w >> 24;
  r0.yzw = (uint3)r1.yzw;
  r0.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r0.xyzw;
  r2.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r2.xyzw = cb0[5].xxxx * r2.xyzw + float4(1,1,1,1);
  o1.xyzw = r2.xyzw * r0.xyzw;
  r0.x = r1.x / cb0[4].y;
  r0.x = floor(r0.x);
  r0.y = -r0.x * cb0[4].y + r1.x;
  r0.y = floor(r0.y);
  r1.x = cb0[4].z * r0.y;
  r0.y = 1 + -cb0[4].w;
  r1.y = -r0.x * cb0[4].w + r0.y;
  r0.xy = v3.xy * cb0[4].zw + r1.xy;
  r0.z = cmp(cb0[4].x != 0.000000);
  r0.xy = r0.zz ? r0.xy : v3.xy;
  o2.xy = r0.xy * cb0[6].xy + cb0[6].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 5871c67439f4e0c5
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float2 o2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb2[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb1[18].xyzw * r1.zzzz;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb1[17].xyzw * r1.yyyy + r3.xyzw;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r0.xyzw = cb1[19].xyzw * r0.xxxx + r3.xyzw;
  o0.xyzw = cb1[20].xyzw + r0.xyzw;
  r0.x = (int)r5.w & 255;
  r0.x = (uint)r0.x;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r1.w = (uint)r5.w >> 24;
  r0.yzw = (uint3)r1.yzw;
  r0.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r0.xyzw;
  r2.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r2.xyzw = cb0[5].xxxx * r2.xyzw + float4(1,1,1,1);
  o1.xyzw = r2.xyzw * r0.xyzw;
  r0.x = r1.x / cb0[4].y;
  r0.x = floor(r0.x);
  r0.y = -r0.x * cb0[4].y + r1.x;
  r0.y = floor(r0.y);
  r1.x = cb0[4].z * r0.y;
  r0.y = 1 + -cb0[4].w;
  r1.y = -r0.x * cb0[4].w + r0.y;
  r0.xy = v3.xy * cb0[4].zw + r1.xy;
  r0.z = cmp(cb0[4].x != 0.000000);
  r0.xy = r0.zz ? r0.xy : v3.xy;
  o2.xy = r0.xy * cb0[6].xy + cb0[6].zw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 61770eff369709c7
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec2 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6 = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.x = u_xlat6 * unity_ParticleUVShiftData.z;
    u_xlat6 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat6;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 61770eff369709c7
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec2 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6 = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.x = u_xlat6 * unity_ParticleUVShiftData.z;
    u_xlat6 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat6;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 61770eff369709c7
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec2 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6 = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.x = u_xlat6 * unity_ParticleUVShiftData.z;
    u_xlat6 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat6;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" }
"// hash: 4c75ad9dc910210d
cbuffer cb4 : register(b4)
{
  float4 cb4[2];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[4];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb2[1].xyzw * v0.yyyy;
  r0.xyzw = cb2[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb2[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb2[3].xyzw + r0.xyzw;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r0.xyzw = cb3[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r0.xyzw;
  r0.x = r0.z / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb4[1].y * r0.x;
  o2.x = exp2(-r0.x);
  o1.xyzw = v2.xyzw;
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" }
"// hash: 4c75ad9dc910210d
cbuffer cb4 : register(b4)
{
  float4 cb4[2];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[4];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb2[1].xyzw * v0.yyyy;
  r0.xyzw = cb2[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb2[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb2[3].xyzw + r0.xyzw;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r0.xyzw = cb3[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r0.xyzw;
  r0.x = r0.z / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb4[1].y * r0.x;
  o2.x = exp2(-r0.x);
  o1.xyzw = v2.xyzw;
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" }
"// hash: 4c75ad9dc910210d
cbuffer cb4 : register(b4)
{
  float4 cb4[2];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[4];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb2[1].xyzw * v0.yyyy;
  r0.xyzw = cb2[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb2[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb2[3].xyzw + r0.xyzw;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r0.xyzw = cb3[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r0.xyzw;
  r0.x = r0.z / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb4[1].y * r0.x;
  o2.x = exp2(-r0.x);
  o1.xyzw = v2.xyzw;
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" }
"// hash: 98398c26cc78f814
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
    vs_TEXCOORD0 = exp2((-u_xlat0.x));
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" }
"// hash: 98398c26cc78f814
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
    vs_TEXCOORD0 = exp2((-u_xlat0.x));
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" }
"// hash: 98398c26cc78f814
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
    vs_TEXCOORD0 = exp2((-u_xlat0.x));
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 4c75ad9dc910210d
cbuffer cb4 : register(b4)
{
  float4 cb4[2];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[4];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb2[1].xyzw * v0.yyyy;
  r0.xyzw = cb2[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb2[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb2[3].xyzw + r0.xyzw;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r0.xyzw = cb3[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r0.xyzw;
  r0.x = r0.z / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb4[1].y * r0.x;
  o2.x = exp2(-r0.x);
  o1.xyzw = v2.xyzw;
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 4c75ad9dc910210d
cbuffer cb4 : register(b4)
{
  float4 cb4[2];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[4];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb2[1].xyzw * v0.yyyy;
  r0.xyzw = cb2[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb2[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb2[3].xyzw + r0.xyzw;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r0.xyzw = cb3[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r0.xyzw;
  r0.x = r0.z / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb4[1].y * r0.x;
  o2.x = exp2(-r0.x);
  o1.xyzw = v2.xyzw;
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 4c75ad9dc910210d
cbuffer cb4 : register(b4)
{
  float4 cb4[2];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[4];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb2[1].xyzw * v0.yyyy;
  r0.xyzw = cb2[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb2[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb2[3].xyzw + r0.xyzw;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r0.xyzw = cb3[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r0.xyzw;
  r0.x = r0.z / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb4[1].y * r0.x;
  o2.x = exp2(-r0.x);
  o1.xyzw = v2.xyzw;
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 1dfb1a1a45c431f2
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
    vs_TEXCOORD0 = exp2((-u_xlat0.x));
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DstBlend==1);
#else
    u_xlatb0 = _DstBlend==1;
#endif
    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.x = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xxx;
    SV_Target0.w = u_xlat1.w;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 1dfb1a1a45c431f2
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
    vs_TEXCOORD0 = exp2((-u_xlat0.x));
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DstBlend==1);
#else
    u_xlatb0 = _DstBlend==1;
#endif
    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.x = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xxx;
    SV_Target0.w = u_xlat1.w;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 1dfb1a1a45c431f2
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
    vs_TEXCOORD0 = exp2((-u_xlat0.x));
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DstBlend==1);
#else
    u_xlatb0 = _DstBlend==1;
#endif
    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.x = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xxx;
    SV_Target0.w = u_xlat1.w;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
"// hash: 3af3322abffc411e
cbuffer cb3 : register(b3)
{
  float4 cb3[12];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb2[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb3[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb3[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb3[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb3[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb1[18].xyzw * r0.yyyy;
  r1.xyzw = cb1[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb1[19].xyzw * r0.zzzz + r1.xyzw;
  r0.xyzw = cb1[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r0.xyzw;
  o2.x = r0.z;
  o1.xyzw = v2.xyzw;
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
"// hash: 3af3322abffc411e
cbuffer cb3 : register(b3)
{
  float4 cb3[12];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb2[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb3[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb3[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb3[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb3[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb1[18].xyzw * r0.yyyy;
  r1.xyzw = cb1[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb1[19].xyzw * r0.zzzz + r1.xyzw;
  r0.xyzw = cb1[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r0.xyzw;
  o2.x = r0.z;
  o1.xyzw = v2.xyzw;
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
"// hash: 3af3322abffc411e
cbuffer cb3 : register(b3)
{
  float4 cb3[12];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb2[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb3[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb3[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb3[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb3[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb1[18].xyzw * r0.yyyy;
  r1.xyzw = cb1[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb1[19].xyzw * r0.zzzz + r1.xyzw;
  r0.xyzw = cb1[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r0.xyzw;
  o2.x = r0.z;
  o1.xyzw = v2.xyzw;
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
"// hash: 8d27c7f10a63e369
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0.x = exp2((-u_xlat0.x));
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _Color.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
"// hash: 8d27c7f10a63e369
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0.x = exp2((-u_xlat0.x));
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _Color.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
"// hash: 8d27c7f10a63e369
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0.x = exp2((-u_xlat0.x));
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _Color.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 3af3322abffc411e
cbuffer cb3 : register(b3)
{
  float4 cb3[12];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb2[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb3[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb3[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb3[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb3[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb1[18].xyzw * r0.yyyy;
  r1.xyzw = cb1[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb1[19].xyzw * r0.zzzz + r1.xyzw;
  r0.xyzw = cb1[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r0.xyzw;
  o2.x = r0.z;
  o1.xyzw = v2.xyzw;
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 3af3322abffc411e
cbuffer cb3 : register(b3)
{
  float4 cb3[12];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb2[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb3[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb3[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb3[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb3[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb1[18].xyzw * r0.yyyy;
  r1.xyzw = cb1[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb1[19].xyzw * r0.zzzz + r1.xyzw;
  r0.xyzw = cb1[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r0.xyzw;
  o2.x = r0.z;
  o1.xyzw = v2.xyzw;
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 3af3322abffc411e
cbuffer cb3 : register(b3)
{
  float4 cb3[12];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb2[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb3[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb3[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb3[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb3[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb1[18].xyzw * r0.yyyy;
  r1.xyzw = cb1[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb1[19].xyzw * r0.zzzz + r1.xyzw;
  r0.xyzw = cb1[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r0.xyzw;
  o2.x = r0.z;
  o1.xyzw = v2.xyzw;
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 4a14b6a15d011a4
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0 = exp2((-u_xlat0));
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DstBlend==1);
#else
    u_xlatb0 = _DstBlend==1;
#endif
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 4a14b6a15d011a4
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0 = exp2((-u_xlat0));
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DstBlend==1);
#else
    u_xlatb0 = _DstBlend==1;
#endif
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 4a14b6a15d011a4
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0 = exp2((-u_xlat0));
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DstBlend==1);
#else
    u_xlatb0 = _DstBlend==1;
#endif
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
"// hash: 5e8225b014d46f2b
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb2[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb1[18].xyzw * r1.zzzz;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb1[17].xyzw * r1.yyyy + r3.xyzw;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r0.xyzw = cb1[19].xyzw * r0.xxxx + r3.xyzw;
  r0.xyzw = cb1[20].xyzw + r0.xyzw;
  o0.xyzw = r0.xyzw;
  o2.x = r0.z;
  r0.x = (int)r5.w & 255;
  r0.x = (uint)r0.x;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r1.w = (uint)r5.w >> 24;
  r0.yzw = (uint3)r1.yzw;
  r0.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r0.xyzw;
  r2.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r2.xyzw = cb0[5].xxxx * r2.xyzw + float4(1,1,1,1);
  o1.xyzw = r2.xyzw * r0.xyzw;
  r0.x = r1.x / cb0[4].y;
  r0.x = floor(r0.x);
  r0.y = -r0.x * cb0[4].y + r1.x;
  r0.y = floor(r0.y);
  r0.y = cb0[4].z * r0.y;
  r0.w = 1 + -cb0[4].w;
  r0.z = -r0.x * cb0[4].w + r0.w;
  r0.xy = v3.xy * cb0[4].zw + r0.yz;
  r0.z = cmp(cb0[4].x != 0.000000);
  r0.xy = r0.zz ? r0.xy : v3.xy;
  p2.xy = r0.xy * cb0[6].xy + cb0[6].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
"// hash: 5e8225b014d46f2b
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb2[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb1[18].xyzw * r1.zzzz;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb1[17].xyzw * r1.yyyy + r3.xyzw;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r0.xyzw = cb1[19].xyzw * r0.xxxx + r3.xyzw;
  r0.xyzw = cb1[20].xyzw + r0.xyzw;
  o0.xyzw = r0.xyzw;
  o2.x = r0.z;
  r0.x = (int)r5.w & 255;
  r0.x = (uint)r0.x;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r1.w = (uint)r5.w >> 24;
  r0.yzw = (uint3)r1.yzw;
  r0.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r0.xyzw;
  r2.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r2.xyzw = cb0[5].xxxx * r2.xyzw + float4(1,1,1,1);
  o1.xyzw = r2.xyzw * r0.xyzw;
  r0.x = r1.x / cb0[4].y;
  r0.x = floor(r0.x);
  r0.y = -r0.x * cb0[4].y + r1.x;
  r0.y = floor(r0.y);
  r0.y = cb0[4].z * r0.y;
  r0.w = 1 + -cb0[4].w;
  r0.z = -r0.x * cb0[4].w + r0.w;
  r0.xy = v3.xy * cb0[4].zw + r0.yz;
  r0.z = cmp(cb0[4].x != 0.000000);
  r0.xy = r0.zz ? r0.xy : v3.xy;
  p2.xy = r0.xy * cb0[6].xy + cb0[6].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
"// hash: 5e8225b014d46f2b
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb2[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb1[18].xyzw * r1.zzzz;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb1[17].xyzw * r1.yyyy + r3.xyzw;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r0.xyzw = cb1[19].xyzw * r0.xxxx + r3.xyzw;
  r0.xyzw = cb1[20].xyzw + r0.xyzw;
  o0.xyzw = r0.xyzw;
  o2.x = r0.z;
  r0.x = (int)r5.w & 255;
  r0.x = (uint)r0.x;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r1.w = (uint)r5.w >> 24;
  r0.yzw = (uint3)r1.yzw;
  r0.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r0.xyzw;
  r2.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r2.xyzw = cb0[5].xxxx * r2.xyzw + float4(1,1,1,1);
  o1.xyzw = r2.xyzw * r0.xyzw;
  r0.x = r1.x / cb0[4].y;
  r0.x = floor(r0.x);
  r0.y = -r0.x * cb0[4].y + r1.x;
  r0.y = floor(r0.y);
  r0.y = cb0[4].z * r0.y;
  r0.w = 1 + -cb0[4].w;
  r0.z = -r0.x * cb0[4].w + r0.w;
  r0.xy = v3.xy * cb0[4].zw + r0.yz;
  r0.z = cmp(cb0[4].x != 0.000000);
  r0.xy = r0.zz ? r0.xy : v3.xy;
  p2.xy = r0.xy * cb0[6].xy + cb0[6].zw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
"// hash: 562a47fc66941fe3
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp float vs_TEXCOORD0;
layout(location = 2) out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
float u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec2 u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
bool u_xlatb12;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1 = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1 = floor(u_xlat1);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0.z;
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1 / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6.x = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * unity_ParticleUVShiftData.z;
    u_xlat18 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat6.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat18;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat6.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp float vs_TEXCOORD0;
layout(location = 2) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0.x = exp2((-u_xlat0.x));
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _Color.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
"// hash: 562a47fc66941fe3
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp float vs_TEXCOORD0;
layout(location = 2) out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
float u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec2 u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
bool u_xlatb12;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1 = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1 = floor(u_xlat1);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0.z;
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1 / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6.x = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * unity_ParticleUVShiftData.z;
    u_xlat18 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat6.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat18;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat6.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp float vs_TEXCOORD0;
layout(location = 2) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0.x = exp2((-u_xlat0.x));
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _Color.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
"// hash: 562a47fc66941fe3
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp float vs_TEXCOORD0;
layout(location = 2) out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
float u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec2 u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
bool u_xlatb12;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1 = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1 = floor(u_xlat1);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0.z;
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1 / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6.x = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * unity_ParticleUVShiftData.z;
    u_xlat18 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat6.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat18;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat6.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp float vs_TEXCOORD0;
layout(location = 2) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0.x = exp2((-u_xlat0.x));
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _Color.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 5e8225b014d46f2b
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb2[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb1[18].xyzw * r1.zzzz;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb1[17].xyzw * r1.yyyy + r3.xyzw;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r0.xyzw = cb1[19].xyzw * r0.xxxx + r3.xyzw;
  r0.xyzw = cb1[20].xyzw + r0.xyzw;
  o0.xyzw = r0.xyzw;
  o2.x = r0.z;
  r0.x = (int)r5.w & 255;
  r0.x = (uint)r0.x;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r1.w = (uint)r5.w >> 24;
  r0.yzw = (uint3)r1.yzw;
  r0.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r0.xyzw;
  r2.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r2.xyzw = cb0[5].xxxx * r2.xyzw + float4(1,1,1,1);
  o1.xyzw = r2.xyzw * r0.xyzw;
  r0.x = r1.x / cb0[4].y;
  r0.x = floor(r0.x);
  r0.y = -r0.x * cb0[4].y + r1.x;
  r0.y = floor(r0.y);
  r0.y = cb0[4].z * r0.y;
  r0.w = 1 + -cb0[4].w;
  r0.z = -r0.x * cb0[4].w + r0.w;
  r0.xy = v3.xy * cb0[4].zw + r0.yz;
  r0.z = cmp(cb0[4].x != 0.000000);
  r0.xy = r0.zz ? r0.xy : v3.xy;
  p2.xy = r0.xy * cb0[6].xy + cb0[6].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 5e8225b014d46f2b
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb2[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb1[18].xyzw * r1.zzzz;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb1[17].xyzw * r1.yyyy + r3.xyzw;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r0.xyzw = cb1[19].xyzw * r0.xxxx + r3.xyzw;
  r0.xyzw = cb1[20].xyzw + r0.xyzw;
  o0.xyzw = r0.xyzw;
  o2.x = r0.z;
  r0.x = (int)r5.w & 255;
  r0.x = (uint)r0.x;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r1.w = (uint)r5.w >> 24;
  r0.yzw = (uint3)r1.yzw;
  r0.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r0.xyzw;
  r2.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r2.xyzw = cb0[5].xxxx * r2.xyzw + float4(1,1,1,1);
  o1.xyzw = r2.xyzw * r0.xyzw;
  r0.x = r1.x / cb0[4].y;
  r0.x = floor(r0.x);
  r0.y = -r0.x * cb0[4].y + r1.x;
  r0.y = floor(r0.y);
  r0.y = cb0[4].z * r0.y;
  r0.w = 1 + -cb0[4].w;
  r0.z = -r0.x * cb0[4].w + r0.w;
  r0.xy = v3.xy * cb0[4].zw + r0.yz;
  r0.z = cmp(cb0[4].x != 0.000000);
  r0.xy = r0.zz ? r0.xy : v3.xy;
  p2.xy = r0.xy * cb0[6].xy + cb0[6].zw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 5e8225b014d46f2b
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[21];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb2[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb1[18].xyzw * r1.zzzz;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb1[17].xyzw * r1.yyyy + r3.xyzw;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r0.xyzw = cb1[19].xyzw * r0.xxxx + r3.xyzw;
  r0.xyzw = cb1[20].xyzw + r0.xyzw;
  o0.xyzw = r0.xyzw;
  o2.x = r0.z;
  r0.x = (int)r5.w & 255;
  r0.x = (uint)r0.x;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r1.w = (uint)r5.w >> 24;
  r0.yzw = (uint3)r1.yzw;
  r0.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r0.xyzw;
  r2.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r2.xyzw = cb0[5].xxxx * r2.xyzw + float4(1,1,1,1);
  o1.xyzw = r2.xyzw * r0.xyzw;
  r0.x = r1.x / cb0[4].y;
  r0.x = floor(r0.x);
  r0.y = -r0.x * cb0[4].y + r1.x;
  r0.y = floor(r0.y);
  r0.y = cb0[4].z * r0.y;
  r0.w = 1 + -cb0[4].w;
  r0.z = -r0.x * cb0[4].w + r0.w;
  r0.xy = v3.xy * cb0[4].zw + r0.yz;
  r0.z = cmp(cb0[4].x != 0.000000);
  r0.xy = r0.zz ? r0.xy : v3.xy;
  p2.xy = r0.xy * cb0[6].xy + cb0[6].zw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 16196ce31ab87f01
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp float vs_TEXCOORD0;
layout(location = 2) out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
float u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec2 u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
bool u_xlatb12;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1 = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1 = floor(u_xlat1);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0.z;
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1 / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6.x = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * unity_ParticleUVShiftData.z;
    u_xlat18 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat6.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat18;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat6.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp float vs_TEXCOORD0;
layout(location = 2) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0 = exp2((-u_xlat0));
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
    u_xlatb0 = _DstBlend==1;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 16196ce31ab87f01
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp float vs_TEXCOORD0;
layout(location = 2) out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
float u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec2 u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
bool u_xlatb12;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1 = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1 = floor(u_xlat1);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0.z;
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1 / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6.x = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * unity_ParticleUVShiftData.z;
    u_xlat18 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat6.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat18;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat6.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp float vs_TEXCOORD0;
layout(location = 2) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0 = exp2((-u_xlat0));
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
    u_xlatb0 = _DstBlend==1;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 16196ce31ab87f01
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp float vs_TEXCOORD0;
layout(location = 2) out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
float u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec2 u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
bool u_xlatb12;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1 = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1 = floor(u_xlat1);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0.z;
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1 / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6.x = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * unity_ParticleUVShiftData.z;
    u_xlat18 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat6.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat18;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat6.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp float vs_TEXCOORD0;
layout(location = 2) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0 = exp2((-u_xlat0));
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
    u_xlatb0 = _DstBlend==1;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"// hash: 5fbb1502cfa443b7
cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[4];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb2[1].xyzw * v0.yyyy;
  r0.xyzw = cb2[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb2[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb2[3].xyzw + r0.xyzw;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb3[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  r0.y = cb3[10].z * r0.y;
  r0.x = cb3[9].z * r0.x + r0.y;
  r0.x = cb3[11].z * r0.z + r0.x;
  r0.x = cb3[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"// hash: 5fbb1502cfa443b7
cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[4];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb2[1].xyzw * v0.yyyy;
  r0.xyzw = cb2[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb2[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb2[3].xyzw + r0.xyzw;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb3[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  r0.y = cb3[10].z * r0.y;
  r0.x = cb3[9].z * r0.x + r0.y;
  r0.x = cb3[11].z * r0.z + r0.x;
  r0.x = cb3[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"// hash: 5fbb1502cfa443b7
cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[4];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb2[1].xyzw * v0.yyyy;
  r0.xyzw = cb2[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb2[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb2[3].xyzw + r0.xyzw;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb3[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  r0.y = cb3[10].z * r0.y;
  r0.x = cb3[9].z * r0.x + r0.y;
  r0.x = cb3[11].z * r0.z + r0.x;
  r0.x = cb3[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"// hash: 8c89f017143b5a9e
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"// hash: 8c89f017143b5a9e
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"// hash: 8c89f017143b5a9e
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 5fbb1502cfa443b7
cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[4];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb2[1].xyzw * v0.yyyy;
  r0.xyzw = cb2[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb2[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb2[3].xyzw + r0.xyzw;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb3[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  r0.y = cb3[10].z * r0.y;
  r0.x = cb3[9].z * r0.x + r0.y;
  r0.x = cb3[11].z * r0.z + r0.x;
  r0.x = cb3[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 5fbb1502cfa443b7
cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[4];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb2[1].xyzw * v0.yyyy;
  r0.xyzw = cb2[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb2[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb2[3].xyzw + r0.xyzw;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb3[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  r0.y = cb3[10].z * r0.y;
  r0.x = cb3[9].z * r0.x + r0.y;
  r0.x = cb3[11].z * r0.z + r0.x;
  r0.x = cb3[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 5fbb1502cfa443b7
cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[4];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb2[1].xyzw * v0.yyyy;
  r0.xyzw = cb2[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb2[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb2[3].xyzw + r0.xyzw;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb3[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  r0.y = cb3[10].z * r0.y;
  r0.x = cb3[9].z * r0.x + r0.y;
  r0.x = cb3[11].z * r0.z + r0.x;
  r0.x = cb3[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 49c6934e27c84c28
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 49c6934e27c84c28
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 49c6934e27c84c28
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: b8d7627aef9801fa
cbuffer cb4 : register(b4)
{
  float4 cb4[12];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb3[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb4[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb4[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb4[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb4[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb2[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  r0.y = cb2[10].z * r0.y;
  r0.x = cb2[9].z * r0.x + r0.y;
  r0.x = cb2[11].z * r0.z + r0.x;
  r0.x = cb2[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: b8d7627aef9801fa
cbuffer cb4 : register(b4)
{
  float4 cb4[12];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb3[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb4[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb4[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb4[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb4[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb2[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  r0.y = cb2[10].z * r0.y;
  r0.x = cb2[9].z * r0.x + r0.y;
  r0.x = cb2[11].z * r0.z + r0.x;
  r0.x = cb2[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: b8d7627aef9801fa
cbuffer cb4 : register(b4)
{
  float4 cb4[12];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb3[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb4[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb4[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb4[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb4[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb2[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  r0.y = cb2[10].z * r0.y;
  r0.x = cb2[9].z * r0.x + r0.y;
  r0.x = cb2[11].z * r0.z + r0.x;
  r0.x = cb2[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: a84cf533277776b
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: a84cf533277776b
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: a84cf533277776b
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: b8d7627aef9801fa
cbuffer cb4 : register(b4)
{
  float4 cb4[12];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb3[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb4[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb4[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb4[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb4[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb2[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  r0.y = cb2[10].z * r0.y;
  r0.x = cb2[9].z * r0.x + r0.y;
  r0.x = cb2[11].z * r0.z + r0.x;
  r0.x = cb2[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: b8d7627aef9801fa
cbuffer cb4 : register(b4)
{
  float4 cb4[12];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb3[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb4[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb4[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb4[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb4[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb2[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  r0.y = cb2[10].z * r0.y;
  r0.x = cb2[9].z * r0.x + r0.y;
  r0.x = cb2[11].z * r0.z + r0.x;
  r0.x = cb2[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: b8d7627aef9801fa
cbuffer cb4 : register(b4)
{
  float4 cb4[12];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb3[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb4[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb4[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb4[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb4[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb2[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  o2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  r0.y = cb2[10].z * r0.y;
  r0.x = cb2[9].z * r0.x + r0.y;
  r0.x = cb2[11].z * r0.z + r0.x;
  r0.x = cb2[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 602fc0038272a5a1
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 602fc0038272a5a1
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 602fc0038272a5a1
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 5a0e3c58ce8b4581
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb3[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb2[18].xyzw * r1.zzzz;
  r1.z = cb2[10].z * r1.z;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb2[17].xyzw * r1.yyyy + r3.xyzw;
  r1.y = cb2[9].z * r1.y + r1.z;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r2.xyzw = cb2[19].xyzw * r0.xxxx + r3.xyzw;
  r0.x = cb2[11].z * r0.x + r1.y;
  r0.x = cb2[12].z + r0.x;
  o3.z = -r0.x;
  r0.xyzw = cb2[20].xyzw + r2.xyzw;
  o0.xyzw = r0.xyzw;
  r0.z = (int)r5.w & 255;
  r2.x = (uint)r0.z;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r0.z = (uint)r5.w >> 24;
  r2.w = (uint)r0.z;
  r2.yz = (uint2)r1.yz;
  r2.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r2.xyzw;
  r3.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r3.xyzw = cb0[5].xxxx * r3.xyzw + float4(1,1,1,1);
  o1.xyzw = r3.xyzw * r2.xyzw;
  r0.z = r1.x / cb0[4].y;
  r0.z = floor(r0.z);
  r1.x = -r0.z * cb0[4].y + r1.x;
  r1.x = floor(r1.x);
  r1.x = cb0[4].z * r1.x;
  r1.z = 1 + -cb0[4].w;
  r1.y = -r0.z * cb0[4].w + r1.z;
  r1.xy = v3.xy * cb0[4].zw + r1.xy;
  r0.z = cmp(cb0[4].x != 0.000000);
  r1.xy = r0.zz ? r1.xy : v3.xy;
  o2.xy = r1.xy * cb0[6].xy + cb0[6].zw;
  r0.y = cb1[5].x * r0.y;
  r1.xzw = float3(0.5,0.5,0.5) * r0.xwy;
  o3.w = r0.w;
  o3.xy = r1.xw + r1.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 5a0e3c58ce8b4581
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb3[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb2[18].xyzw * r1.zzzz;
  r1.z = cb2[10].z * r1.z;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb2[17].xyzw * r1.yyyy + r3.xyzw;
  r1.y = cb2[9].z * r1.y + r1.z;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r2.xyzw = cb2[19].xyzw * r0.xxxx + r3.xyzw;
  r0.x = cb2[11].z * r0.x + r1.y;
  r0.x = cb2[12].z + r0.x;
  o3.z = -r0.x;
  r0.xyzw = cb2[20].xyzw + r2.xyzw;
  o0.xyzw = r0.xyzw;
  r0.z = (int)r5.w & 255;
  r2.x = (uint)r0.z;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r0.z = (uint)r5.w >> 24;
  r2.w = (uint)r0.z;
  r2.yz = (uint2)r1.yz;
  r2.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r2.xyzw;
  r3.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r3.xyzw = cb0[5].xxxx * r3.xyzw + float4(1,1,1,1);
  o1.xyzw = r3.xyzw * r2.xyzw;
  r0.z = r1.x / cb0[4].y;
  r0.z = floor(r0.z);
  r1.x = -r0.z * cb0[4].y + r1.x;
  r1.x = floor(r1.x);
  r1.x = cb0[4].z * r1.x;
  r1.z = 1 + -cb0[4].w;
  r1.y = -r0.z * cb0[4].w + r1.z;
  r1.xy = v3.xy * cb0[4].zw + r1.xy;
  r0.z = cmp(cb0[4].x != 0.000000);
  r1.xy = r0.zz ? r1.xy : v3.xy;
  o2.xy = r1.xy * cb0[6].xy + cb0[6].zw;
  r0.y = cb1[5].x * r0.y;
  r1.xzw = float3(0.5,0.5,0.5) * r0.xwy;
  o3.w = r0.w;
  o3.xy = r1.xw + r1.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 5a0e3c58ce8b4581
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb3[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb2[18].xyzw * r1.zzzz;
  r1.z = cb2[10].z * r1.z;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb2[17].xyzw * r1.yyyy + r3.xyzw;
  r1.y = cb2[9].z * r1.y + r1.z;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r2.xyzw = cb2[19].xyzw * r0.xxxx + r3.xyzw;
  r0.x = cb2[11].z * r0.x + r1.y;
  r0.x = cb2[12].z + r0.x;
  o3.z = -r0.x;
  r0.xyzw = cb2[20].xyzw + r2.xyzw;
  o0.xyzw = r0.xyzw;
  r0.z = (int)r5.w & 255;
  r2.x = (uint)r0.z;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r0.z = (uint)r5.w >> 24;
  r2.w = (uint)r0.z;
  r2.yz = (uint2)r1.yz;
  r2.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r2.xyzw;
  r3.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r3.xyzw = cb0[5].xxxx * r3.xyzw + float4(1,1,1,1);
  o1.xyzw = r3.xyzw * r2.xyzw;
  r0.z = r1.x / cb0[4].y;
  r0.z = floor(r0.z);
  r1.x = -r0.z * cb0[4].y + r1.x;
  r1.x = floor(r1.x);
  r1.x = cb0[4].z * r1.x;
  r1.z = 1 + -cb0[4].w;
  r1.y = -r0.z * cb0[4].w + r1.z;
  r1.xy = v3.xy * cb0[4].zw + r1.xy;
  r0.z = cmp(cb0[4].x != 0.000000);
  r1.xy = r0.zz ? r1.xy : v3.xy;
  o2.xy = r1.xy * cb0[6].xy + cb0[6].zw;
  r0.y = cb1[5].x * r0.y;
  r1.xzw = float3(0.5,0.5,0.5) * r0.xwy;
  o3.w = r0.w;
  o3.xy = r1.xw + r1.zz;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 1979985965e5026a
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
layout(location = 2) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec2 u_xlatu7;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu12 = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu12);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu12 = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.w = float(u_xlatu12);
    u_xlat3.yz = vec2(u_xlatu7.xy);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat12 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.x = (-u_xlat12) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat13 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat12) * unity_ParticleUVShiftData.w + u_xlat13;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 1979985965e5026a
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
layout(location = 2) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec2 u_xlatu7;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu12 = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu12);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu12 = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.w = float(u_xlatu12);
    u_xlat3.yz = vec2(u_xlatu7.xy);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat12 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.x = (-u_xlat12) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat13 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat12) * unity_ParticleUVShiftData.w + u_xlat13;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 1979985965e5026a
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
layout(location = 2) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec2 u_xlatu7;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu12 = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu12);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu12 = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.w = float(u_xlatu12);
    u_xlat3.yz = vec2(u_xlatu7.xy);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat12 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.x = (-u_xlat12) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat13 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat12) * unity_ParticleUVShiftData.w + u_xlat13;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 5a0e3c58ce8b4581
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb3[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb2[18].xyzw * r1.zzzz;
  r1.z = cb2[10].z * r1.z;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb2[17].xyzw * r1.yyyy + r3.xyzw;
  r1.y = cb2[9].z * r1.y + r1.z;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r2.xyzw = cb2[19].xyzw * r0.xxxx + r3.xyzw;
  r0.x = cb2[11].z * r0.x + r1.y;
  r0.x = cb2[12].z + r0.x;
  o3.z = -r0.x;
  r0.xyzw = cb2[20].xyzw + r2.xyzw;
  o0.xyzw = r0.xyzw;
  r0.z = (int)r5.w & 255;
  r2.x = (uint)r0.z;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r0.z = (uint)r5.w >> 24;
  r2.w = (uint)r0.z;
  r2.yz = (uint2)r1.yz;
  r2.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r2.xyzw;
  r3.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r3.xyzw = cb0[5].xxxx * r3.xyzw + float4(1,1,1,1);
  o1.xyzw = r3.xyzw * r2.xyzw;
  r0.z = r1.x / cb0[4].y;
  r0.z = floor(r0.z);
  r1.x = -r0.z * cb0[4].y + r1.x;
  r1.x = floor(r1.x);
  r1.x = cb0[4].z * r1.x;
  r1.z = 1 + -cb0[4].w;
  r1.y = -r0.z * cb0[4].w + r1.z;
  r1.xy = v3.xy * cb0[4].zw + r1.xy;
  r0.z = cmp(cb0[4].x != 0.000000);
  r1.xy = r0.zz ? r1.xy : v3.xy;
  o2.xy = r1.xy * cb0[6].xy + cb0[6].zw;
  r0.y = cb1[5].x * r0.y;
  r1.xzw = float3(0.5,0.5,0.5) * r0.xwy;
  o3.w = r0.w;
  o3.xy = r1.xw + r1.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 5a0e3c58ce8b4581
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb3[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb2[18].xyzw * r1.zzzz;
  r1.z = cb2[10].z * r1.z;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb2[17].xyzw * r1.yyyy + r3.xyzw;
  r1.y = cb2[9].z * r1.y + r1.z;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r2.xyzw = cb2[19].xyzw * r0.xxxx + r3.xyzw;
  r0.x = cb2[11].z * r0.x + r1.y;
  r0.x = cb2[12].z + r0.x;
  o3.z = -r0.x;
  r0.xyzw = cb2[20].xyzw + r2.xyzw;
  o0.xyzw = r0.xyzw;
  r0.z = (int)r5.w & 255;
  r2.x = (uint)r0.z;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r0.z = (uint)r5.w >> 24;
  r2.w = (uint)r0.z;
  r2.yz = (uint2)r1.yz;
  r2.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r2.xyzw;
  r3.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r3.xyzw = cb0[5].xxxx * r3.xyzw + float4(1,1,1,1);
  o1.xyzw = r3.xyzw * r2.xyzw;
  r0.z = r1.x / cb0[4].y;
  r0.z = floor(r0.z);
  r1.x = -r0.z * cb0[4].y + r1.x;
  r1.x = floor(r1.x);
  r1.x = cb0[4].z * r1.x;
  r1.z = 1 + -cb0[4].w;
  r1.y = -r0.z * cb0[4].w + r1.z;
  r1.xy = v3.xy * cb0[4].zw + r1.xy;
  r0.z = cmp(cb0[4].x != 0.000000);
  r1.xy = r0.zz ? r1.xy : v3.xy;
  o2.xy = r1.xy * cb0[6].xy + cb0[6].zw;
  r0.y = cb1[5].x * r0.y;
  r1.xzw = float3(0.5,0.5,0.5) * r0.xwy;
  o3.w = r0.w;
  o3.xy = r1.xw + r1.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 5a0e3c58ce8b4581
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb3[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb2[18].xyzw * r1.zzzz;
  r1.z = cb2[10].z * r1.z;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb2[17].xyzw * r1.yyyy + r3.xyzw;
  r1.y = cb2[9].z * r1.y + r1.z;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r2.xyzw = cb2[19].xyzw * r0.xxxx + r3.xyzw;
  r0.x = cb2[11].z * r0.x + r1.y;
  r0.x = cb2[12].z + r0.x;
  o3.z = -r0.x;
  r0.xyzw = cb2[20].xyzw + r2.xyzw;
  o0.xyzw = r0.xyzw;
  r0.z = (int)r5.w & 255;
  r2.x = (uint)r0.z;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r0.z = (uint)r5.w >> 24;
  r2.w = (uint)r0.z;
  r2.yz = (uint2)r1.yz;
  r2.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r2.xyzw;
  r3.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r3.xyzw = cb0[5].xxxx * r3.xyzw + float4(1,1,1,1);
  o1.xyzw = r3.xyzw * r2.xyzw;
  r0.z = r1.x / cb0[4].y;
  r0.z = floor(r0.z);
  r1.x = -r0.z * cb0[4].y + r1.x;
  r1.x = floor(r1.x);
  r1.x = cb0[4].z * r1.x;
  r1.z = 1 + -cb0[4].w;
  r1.y = -r0.z * cb0[4].w + r1.z;
  r1.xy = v3.xy * cb0[4].zw + r1.xy;
  r0.z = cmp(cb0[4].x != 0.000000);
  r1.xy = r0.zz ? r1.xy : v3.xy;
  o2.xy = r1.xy * cb0[6].xy + cb0[6].zw;
  r0.y = cb1[5].x * r0.y;
  r1.xzw = float3(0.5,0.5,0.5) * r0.xwy;
  o3.w = r0.w;
  o3.xy = r1.xw + r1.zz;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: d3fcef63527d2204
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
layout(location = 2) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec2 u_xlatu7;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu12 = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu12);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu12 = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.w = float(u_xlatu12);
    u_xlat3.yz = vec2(u_xlatu7.xy);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat12 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.x = (-u_xlat12) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat13 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat12) * unity_ParticleUVShiftData.w + u_xlat13;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: d3fcef63527d2204
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
layout(location = 2) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec2 u_xlatu7;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu12 = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu12);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu12 = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.w = float(u_xlatu12);
    u_xlat3.yz = vec2(u_xlatu7.xy);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat12 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.x = (-u_xlat12) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat13 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat12) * unity_ParticleUVShiftData.w + u_xlat13;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: d3fcef63527d2204
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
layout(location = 2) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec2 u_xlatu7;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu12 = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu12);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu12 = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.w = float(u_xlatu12);
    u_xlat3.yz = vec2(u_xlatu7.xy);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat12 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.x = (-u_xlat12) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat13 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat12) * unity_ParticleUVShiftData.w + u_xlat13;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
"// hash: 13a6ed454eee0357
cbuffer cb4 : register(b4)
{
  float4 cb4[2];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[4];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb2[1].xyzw * v0.yyyy;
  r0.xyzw = cb2[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb2[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb2[3].xyzw + r0.xyzw;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb3[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  r1.z = r1.z / cb1[5].y;
  r1.z = 1 + -r1.z;
  r1.z = cb1[5].z * r1.z;
  r1.z = max(0, r1.z);
  r1.z = cb4[1].y * r1.z;
  o2.x = exp2(-r1.z);
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  r0.y = cb3[10].z * r0.y;
  r0.x = cb3[9].z * r0.x + r0.y;
  r0.x = cb3[11].z * r0.z + r0.x;
  r0.x = cb3[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
"// hash: 13a6ed454eee0357
cbuffer cb4 : register(b4)
{
  float4 cb4[2];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[4];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb2[1].xyzw * v0.yyyy;
  r0.xyzw = cb2[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb2[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb2[3].xyzw + r0.xyzw;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb3[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  r1.z = r1.z / cb1[5].y;
  r1.z = 1 + -r1.z;
  r1.z = cb1[5].z * r1.z;
  r1.z = max(0, r1.z);
  r1.z = cb4[1].y * r1.z;
  o2.x = exp2(-r1.z);
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  r0.y = cb3[10].z * r0.y;
  r0.x = cb3[9].z * r0.x + r0.y;
  r0.x = cb3[11].z * r0.z + r0.x;
  r0.x = cb3[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
"// hash: 13a6ed454eee0357
cbuffer cb4 : register(b4)
{
  float4 cb4[2];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[4];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb2[1].xyzw * v0.yyyy;
  r0.xyzw = cb2[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb2[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb2[3].xyzw + r0.xyzw;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb3[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  r1.z = r1.z / cb1[5].y;
  r1.z = 1 + -r1.z;
  r1.z = cb1[5].z * r1.z;
  r1.z = max(0, r1.z);
  r1.z = cb4[1].y * r1.z;
  o2.x = exp2(-r1.z);
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  r0.y = cb3[10].z * r0.y;
  r0.x = cb3[9].z * r0.x + r0.y;
  r0.x = cb3[11].z * r0.z + r0.x;
  r0.x = cb3[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
"// hash: 3104ec5b8e93b342
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat5;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat5 = u_xlat1.z * unity_FogParams.y;
    vs_TEXCOORD0 = exp2((-u_xlat5));
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
"// hash: 3104ec5b8e93b342
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat5;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat5 = u_xlat1.z * unity_FogParams.y;
    vs_TEXCOORD0 = exp2((-u_xlat5));
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
"// hash: 3104ec5b8e93b342
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat5;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat5 = u_xlat1.z * unity_FogParams.y;
    vs_TEXCOORD0 = exp2((-u_xlat5));
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 13a6ed454eee0357
cbuffer cb4 : register(b4)
{
  float4 cb4[2];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[4];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb2[1].xyzw * v0.yyyy;
  r0.xyzw = cb2[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb2[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb2[3].xyzw + r0.xyzw;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb3[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  r1.z = r1.z / cb1[5].y;
  r1.z = 1 + -r1.z;
  r1.z = cb1[5].z * r1.z;
  r1.z = max(0, r1.z);
  r1.z = cb4[1].y * r1.z;
  o2.x = exp2(-r1.z);
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  r0.y = cb3[10].z * r0.y;
  r0.x = cb3[9].z * r0.x + r0.y;
  r0.x = cb3[11].z * r0.z + r0.x;
  r0.x = cb3[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 13a6ed454eee0357
cbuffer cb4 : register(b4)
{
  float4 cb4[2];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[4];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb2[1].xyzw * v0.yyyy;
  r0.xyzw = cb2[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb2[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb2[3].xyzw + r0.xyzw;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb3[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  r1.z = r1.z / cb1[5].y;
  r1.z = 1 + -r1.z;
  r1.z = cb1[5].z * r1.z;
  r1.z = max(0, r1.z);
  r1.z = cb4[1].y * r1.z;
  o2.x = exp2(-r1.z);
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  r0.y = cb3[10].z * r0.y;
  r0.x = cb3[9].z * r0.x + r0.y;
  r0.x = cb3[11].z * r0.z + r0.x;
  r0.x = cb3[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 13a6ed454eee0357
cbuffer cb4 : register(b4)
{
  float4 cb4[2];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[4];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb2[1].xyzw * v0.yyyy;
  r0.xyzw = cb2[0].xyzw * v0.xxxx + r0.xyzw;
  r0.xyzw = cb2[2].xyzw * v0.zzzz + r0.xyzw;
  r0.xyzw = cb2[3].xyzw + r0.xyzw;
  r1.xyzw = cb3[18].xyzw * r0.yyyy;
  r1.xyzw = cb3[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb3[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb3[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  r1.z = r1.z / cb1[5].y;
  r1.z = 1 + -r1.z;
  r1.z = cb1[5].z * r1.z;
  r1.z = max(0, r1.z);
  r1.z = cb4[1].y * r1.z;
  o2.x = exp2(-r1.z);
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  r0.y = cb3[10].z * r0.y;
  r0.x = cb3[9].z * r0.x + r0.y;
  r0.x = cb3[11].z * r0.z + r0.x;
  r0.x = cb3[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 247b04758cfb61c
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat5;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat5 = u_xlat1.z * unity_FogParams.y;
    vs_TEXCOORD0 = exp2((-u_xlat5));
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DstBlend==1);
#else
    u_xlatb0 = _DstBlend==1;
#endif
    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.x = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xxx;
    SV_Target0.w = u_xlat1.w;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 247b04758cfb61c
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat5;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat5 = u_xlat1.z * unity_FogParams.y;
    vs_TEXCOORD0 = exp2((-u_xlat5));
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DstBlend==1);
#else
    u_xlatb0 = _DstBlend==1;
#endif
    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.x = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xxx;
    SV_Target0.w = u_xlat1.w;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 247b04758cfb61c
#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat5;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat5 = u_xlat1.z * unity_FogParams.y;
    vs_TEXCOORD0 = exp2((-u_xlat5));
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DstBlend==1);
#else
    u_xlatb0 = _DstBlend==1;
#endif
    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.x = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xxx;
    SV_Target0.w = u_xlat1.w;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 9c33b8ea7afd4d71
cbuffer cb4 : register(b4)
{
  float4 cb4[12];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb3[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb4[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb4[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb4[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb4[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb2[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  o2.x = r1.z;
  r0.y = cb2[10].z * r0.y;
  r0.x = cb2[9].z * r0.x + r0.y;
  r0.x = cb2[11].z * r0.z + r0.x;
  r0.x = cb2[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 9c33b8ea7afd4d71
cbuffer cb4 : register(b4)
{
  float4 cb4[12];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb3[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb4[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb4[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb4[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb4[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb2[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  o2.x = r1.z;
  r0.y = cb2[10].z * r0.y;
  r0.x = cb2[9].z * r0.x + r0.y;
  r0.x = cb2[11].z * r0.z + r0.x;
  r0.x = cb2[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 9c33b8ea7afd4d71
cbuffer cb4 : register(b4)
{
  float4 cb4[12];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb3[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb4[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb4[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb4[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb4[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb2[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  o2.x = r1.z;
  r0.y = cb2[10].z * r0.y;
  r0.x = cb2[9].z * r0.x + r0.y;
  r0.x = cb2[11].z * r0.z + r0.x;
  r0.x = cb2[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 9e3fa194cb1c05f2
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0 = u_xlat1.z;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0.x = exp2((-u_xlat0.x));
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _Color.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 9e3fa194cb1c05f2
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0 = u_xlat1.z;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0.x = exp2((-u_xlat0.x));
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _Color.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 9e3fa194cb1c05f2
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0 = u_xlat1.z;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0.x = exp2((-u_xlat0.x));
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _Color.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 9c33b8ea7afd4d71
cbuffer cb4 : register(b4)
{
  float4 cb4[12];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb3[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb4[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb4[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb4[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb4[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb2[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  o2.x = r1.z;
  r0.y = cb2[10].z * r0.y;
  r0.x = cb2[9].z * r0.x + r0.y;
  r0.x = cb2[11].z * r0.z + r0.x;
  r0.x = cb2[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 9c33b8ea7afd4d71
cbuffer cb4 : register(b4)
{
  float4 cb4[12];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb3[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb4[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb4[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb4[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb4[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb2[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  o2.x = r1.z;
  r0.y = cb2[10].z * r0.y;
  r0.x = cb2[9].z * r0.x + r0.y;
  r0.x = cb2[11].z * r0.z + r0.x;
  r0.x = cb2[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 9c33b8ea7afd4d71
cbuffer cb4 : register(b4)
{
  float4 cb4[12];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (int)v4.x + asint(cb3[0].x);
  r0.x = (uint)r0.x << 3;
  r1.xyzw = cb4[r0.x+1].xyzw * v0.yyyy;
  r1.xyzw = cb4[r0.x+0].xyzw * v0.xxxx + r1.xyzw;
  r1.xyzw = cb4[r0.x+2].xyzw * v0.zzzz + r1.xyzw;
  r0.xyzw = cb4[r0.x+3].xyzw + r1.xyzw;
  r1.xyzw = cb2[18].xyzw * r0.yyyy;
  r1.xyzw = cb2[17].xyzw * r0.xxxx + r1.xyzw;
  r1.xyzw = cb2[19].xyzw * r0.zzzz + r1.xyzw;
  r1.xyzw = cb2[20].xyzw * r0.wwww + r1.xyzw;
  o0.xyzw = r1.xyzw;
  o1.xyzw = v2.xyzw;
  p2.xy = v3.xy * cb0[4].xy + cb0[4].zw;
  o2.x = r1.z;
  r0.y = cb2[10].z * r0.y;
  r0.x = cb2[9].z * r0.x + r0.y;
  r0.x = cb2[11].z * r0.z + r0.x;
  r0.x = cb2[12].z * r0.w + r0.x;
  o3.z = -r0.x;
  r0.x = cb1[5].x * r1.y;
  r0.w = 0.5 * r0.x;
  r0.xz = float2(0.5,0.5) * r1.xw;
  o3.w = r1.w;
  o3.xy = r0.xw + r0.zz;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: a16cf1573749dd6d
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0 = u_xlat1.z;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0 = exp2((-u_xlat0));
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DstBlend==1);
#else
    u_xlatb0 = _DstBlend==1;
#endif
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: a16cf1573749dd6d
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0 = u_xlat1.z;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0 = exp2((-u_xlat0));
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DstBlend==1);
#else
    u_xlatb0 = _DstBlend==1;
#endif
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: a16cf1573749dd6d
#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0 = u_xlat1.z;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0 = exp2((-u_xlat0));
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DstBlend==1);
#else
    u_xlatb0 = _DstBlend==1;
#endif
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 17c0e0d9782a1479
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb3[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb2[18].xyzw * r1.zzzz;
  r1.z = cb2[10].z * r1.z;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb2[17].xyzw * r1.yyyy + r3.xyzw;
  r1.y = cb2[9].z * r1.y + r1.z;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r2.xyzw = cb2[19].xyzw * r0.xxxx + r3.xyzw;
  r0.x = cb2[11].z * r0.x + r1.y;
  r0.x = cb2[12].z + r0.x;
  o3.z = -r0.x;
  r0.xyzw = cb2[20].xyzw + r2.xyzw;
  o0.xyzw = r0.xyzw;
  r1.y = (int)r5.w & 255;
  r2.x = (uint)r1.y;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r1.w = (uint)r5.w >> 24;
  r2.yzw = (uint3)r1.yzw;
  r2.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r2.xyzw;
  r3.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r3.xyzw = cb0[5].xxxx * r3.xyzw + float4(1,1,1,1);
  o1.xyzw = r3.xyzw * r2.xyzw;
  r1.y = r1.x / cb0[4].y;
  r1.y = floor(r1.y);
  r1.x = -r1.y * cb0[4].y + r1.x;
  r1.x = floor(r1.x);
  r2.y = cb0[4].z * r1.x;
  r1.x = 1 + -cb0[4].w;
  r2.z = -r1.y * cb0[4].w + r1.x;
  r1.xy = v3.xy * cb0[4].zw + r2.yz;
  r1.z = cmp(cb0[4].x != 0.000000);
  r1.xy = r1.zz ? r1.xy : v3.xy;
  p2.xy = r1.xy * cb0[6].xy + cb0[6].zw;
  o2.x = r0.z;
  r0.y = cb1[5].x * r0.y;
  r1.xzw = float3(0.5,0.5,0.5) * r0.xwy;
  o3.w = r0.w;
  o3.xy = r1.xw + r1.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 17c0e0d9782a1479
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb3[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb2[18].xyzw * r1.zzzz;
  r1.z = cb2[10].z * r1.z;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb2[17].xyzw * r1.yyyy + r3.xyzw;
  r1.y = cb2[9].z * r1.y + r1.z;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r2.xyzw = cb2[19].xyzw * r0.xxxx + r3.xyzw;
  r0.x = cb2[11].z * r0.x + r1.y;
  r0.x = cb2[12].z + r0.x;
  o3.z = -r0.x;
  r0.xyzw = cb2[20].xyzw + r2.xyzw;
  o0.xyzw = r0.xyzw;
  r1.y = (int)r5.w & 255;
  r2.x = (uint)r1.y;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r1.w = (uint)r5.w >> 24;
  r2.yzw = (uint3)r1.yzw;
  r2.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r2.xyzw;
  r3.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r3.xyzw = cb0[5].xxxx * r3.xyzw + float4(1,1,1,1);
  o1.xyzw = r3.xyzw * r2.xyzw;
  r1.y = r1.x / cb0[4].y;
  r1.y = floor(r1.y);
  r1.x = -r1.y * cb0[4].y + r1.x;
  r1.x = floor(r1.x);
  r2.y = cb0[4].z * r1.x;
  r1.x = 1 + -cb0[4].w;
  r2.z = -r1.y * cb0[4].w + r1.x;
  r1.xy = v3.xy * cb0[4].zw + r2.yz;
  r1.z = cmp(cb0[4].x != 0.000000);
  r1.xy = r1.zz ? r1.xy : v3.xy;
  p2.xy = r1.xy * cb0[6].xy + cb0[6].zw;
  o2.x = r0.z;
  r0.y = cb1[5].x * r0.y;
  r1.xzw = float3(0.5,0.5,0.5) * r0.xwy;
  o3.w = r0.w;
  o3.xy = r1.xw + r1.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 17c0e0d9782a1479
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb3[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb2[18].xyzw * r1.zzzz;
  r1.z = cb2[10].z * r1.z;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb2[17].xyzw * r1.yyyy + r3.xyzw;
  r1.y = cb2[9].z * r1.y + r1.z;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r2.xyzw = cb2[19].xyzw * r0.xxxx + r3.xyzw;
  r0.x = cb2[11].z * r0.x + r1.y;
  r0.x = cb2[12].z + r0.x;
  o3.z = -r0.x;
  r0.xyzw = cb2[20].xyzw + r2.xyzw;
  o0.xyzw = r0.xyzw;
  r1.y = (int)r5.w & 255;
  r2.x = (uint)r1.y;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r1.w = (uint)r5.w >> 24;
  r2.yzw = (uint3)r1.yzw;
  r2.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r2.xyzw;
  r3.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r3.xyzw = cb0[5].xxxx * r3.xyzw + float4(1,1,1,1);
  o1.xyzw = r3.xyzw * r2.xyzw;
  r1.y = r1.x / cb0[4].y;
  r1.y = floor(r1.y);
  r1.x = -r1.y * cb0[4].y + r1.x;
  r1.x = floor(r1.x);
  r2.y = cb0[4].z * r1.x;
  r1.x = 1 + -cb0[4].w;
  r2.z = -r1.y * cb0[4].w + r1.x;
  r1.xy = v3.xy * cb0[4].zw + r2.yz;
  r1.z = cmp(cb0[4].x != 0.000000);
  r1.xy = r1.zz ? r1.xy : v3.xy;
  p2.xy = r1.xy * cb0[6].xy + cb0[6].zw;
  o2.x = r0.z;
  r0.y = cb1[5].x * r0.y;
  r1.xzw = float3(0.5,0.5,0.5) * r0.xwy;
  o3.w = r0.w;
  o3.xy = r1.xw + r1.zz;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: be72eadeb6f75468
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp float vs_TEXCOORD0;
layout(location = 2) out highp vec2 vs_TEXCOORD1;
layout(location = 3) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec3 u_xlatu7;
vec2 u_xlat8;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.yzw = vec3(u_xlatu7.xyz);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat7.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = (-u_xlat7.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat8.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat1.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat8.y = (-u_xlat7.x) * unity_ParticleUVShiftData.w + u_xlat1.x;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat8.xy;
    u_xlatb13 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb13)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0 = u_xlat0.z;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp float vs_TEXCOORD0;
layout(location = 2) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0.x = exp2((-u_xlat0.x));
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _Color.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: be72eadeb6f75468
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp float vs_TEXCOORD0;
layout(location = 2) out highp vec2 vs_TEXCOORD1;
layout(location = 3) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec3 u_xlatu7;
vec2 u_xlat8;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.yzw = vec3(u_xlatu7.xyz);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat7.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = (-u_xlat7.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat8.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat1.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat8.y = (-u_xlat7.x) * unity_ParticleUVShiftData.w + u_xlat1.x;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat8.xy;
    u_xlatb13 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb13)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0 = u_xlat0.z;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp float vs_TEXCOORD0;
layout(location = 2) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0.x = exp2((-u_xlat0.x));
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _Color.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: be72eadeb6f75468
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp float vs_TEXCOORD0;
layout(location = 2) out highp vec2 vs_TEXCOORD1;
layout(location = 3) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec3 u_xlatu7;
vec2 u_xlat8;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.yzw = vec3(u_xlatu7.xyz);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat7.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = (-u_xlat7.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat8.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat1.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat8.y = (-u_xlat7.x) * unity_ParticleUVShiftData.w + u_xlat1.x;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat8.xy;
    u_xlatb13 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb13)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0 = u_xlat0.z;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp float vs_TEXCOORD0;
layout(location = 2) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0.x = exp2((-u_xlat0.x));
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * _Color.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 17c0e0d9782a1479
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb3[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb2[18].xyzw * r1.zzzz;
  r1.z = cb2[10].z * r1.z;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb2[17].xyzw * r1.yyyy + r3.xyzw;
  r1.y = cb2[9].z * r1.y + r1.z;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r2.xyzw = cb2[19].xyzw * r0.xxxx + r3.xyzw;
  r0.x = cb2[11].z * r0.x + r1.y;
  r0.x = cb2[12].z + r0.x;
  o3.z = -r0.x;
  r0.xyzw = cb2[20].xyzw + r2.xyzw;
  o0.xyzw = r0.xyzw;
  r1.y = (int)r5.w & 255;
  r2.x = (uint)r1.y;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r1.w = (uint)r5.w >> 24;
  r2.yzw = (uint3)r1.yzw;
  r2.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r2.xyzw;
  r3.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r3.xyzw = cb0[5].xxxx * r3.xyzw + float4(1,1,1,1);
  o1.xyzw = r3.xyzw * r2.xyzw;
  r1.y = r1.x / cb0[4].y;
  r1.y = floor(r1.y);
  r1.x = -r1.y * cb0[4].y + r1.x;
  r1.x = floor(r1.x);
  r2.y = cb0[4].z * r1.x;
  r1.x = 1 + -cb0[4].w;
  r2.z = -r1.y * cb0[4].w + r1.x;
  r1.xy = v3.xy * cb0[4].zw + r2.yz;
  r1.z = cmp(cb0[4].x != 0.000000);
  r1.xy = r1.zz ? r1.xy : v3.xy;
  p2.xy = r1.xy * cb0[6].xy + cb0[6].zw;
  o2.x = r0.z;
  r0.y = cb1[5].x * r0.y;
  r1.xzw = float3(0.5,0.5,0.5) * r0.xwy;
  o3.w = r0.w;
  o3.xy = r1.xw + r1.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 17c0e0d9782a1479
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb3[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb2[18].xyzw * r1.zzzz;
  r1.z = cb2[10].z * r1.z;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb2[17].xyzw * r1.yyyy + r3.xyzw;
  r1.y = cb2[9].z * r1.y + r1.z;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r2.xyzw = cb2[19].xyzw * r0.xxxx + r3.xyzw;
  r0.x = cb2[11].z * r0.x + r1.y;
  r0.x = cb2[12].z + r0.x;
  o3.z = -r0.x;
  r0.xyzw = cb2[20].xyzw + r2.xyzw;
  o0.xyzw = r0.xyzw;
  r1.y = (int)r5.w & 255;
  r2.x = (uint)r1.y;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r1.w = (uint)r5.w >> 24;
  r2.yzw = (uint3)r1.yzw;
  r2.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r2.xyzw;
  r3.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r3.xyzw = cb0[5].xxxx * r3.xyzw + float4(1,1,1,1);
  o1.xyzw = r3.xyzw * r2.xyzw;
  r1.y = r1.x / cb0[4].y;
  r1.y = floor(r1.y);
  r1.x = -r1.y * cb0[4].y + r1.x;
  r1.x = floor(r1.x);
  r2.y = cb0[4].z * r1.x;
  r1.x = 1 + -cb0[4].w;
  r2.z = -r1.y * cb0[4].w + r1.x;
  r1.xy = v3.xy * cb0[4].zw + r2.yz;
  r1.z = cmp(cb0[4].x != 0.000000);
  r1.xy = r1.zz ? r1.xy : v3.xy;
  p2.xy = r1.xy * cb0[6].xy + cb0[6].zw;
  o2.x = r0.z;
  r0.y = cb1[5].x * r0.y;
  r1.xzw = float3(0.5,0.5,0.5) * r0.xwy;
  o3.w = r0.w;
  o3.xy = r1.xw + r1.zz;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 17c0e0d9782a1479
struct t0_t {
  float val[14];
};
StructuredBuffer<t0_t> t0 : register(t0);

cbuffer cb3 : register(b3)
{
  float4 cb3[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float o2 : TEXCOORD0,
  out float2 p2 : TEXCOORD1,
  out float4 o3 : TEXCOORD3)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v4.x, instance_id
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = v0.xyz;
  r0.w = 1;
  r1.x = (int)v4.x + asint(cb3[0].x);
  r2.x = t0[r1.x].val[0/4+2];
  r2.y = t0[r1.x].val[0/4];
  r2.z = t0[r1.x].val[0/4+1];
  r3.x = r2.z;
  r4.x = t0[r1.x].val[12/4+1];
  r4.y = t0[r1.x].val[12/4];
  r4.z = t0[r1.x].val[12/4+2];
  r3.y = r4.x;
  r1.y = t0[r1.x].val[24/4];
  r1.z = t0[r1.x].val[24/4+1];
  r1.w = t0[r1.x].val[24/4+2];
  r3.z = r1.z;
  r5.x = t0[r1.x].val[36/4];
  r5.y = t0[r1.x].val[36/4+1];
  r5.z = t0[r1.x].val[36/4+2];
  r5.w = t0[r1.x].val[36/4+3];
  r1.x = t0[r1.x].val[52/4];
  r1.x = floor(r1.x);
  r3.w = r5.y;
  r1.z = dot(r3.xyzw, r0.xyzw);
  r3.xyzw = cb2[18].xyzw * r1.zzzz;
  r1.z = cb2[10].z * r1.z;
  r4.x = r2.y;
  r2.y = r4.z;
  r4.z = r1.y;
  r2.z = r1.w;
  r4.w = r5.x;
  r1.y = dot(r4.xyzw, r0.xyzw);
  r3.xyzw = cb2[17].xyzw * r1.yyyy + r3.xyzw;
  r1.y = cb2[9].z * r1.y + r1.z;
  r2.w = r5.z;
  r0.x = dot(r2.xyzw, r0.xyzw);
  r2.xyzw = cb2[19].xyzw * r0.xxxx + r3.xyzw;
  r0.x = cb2[11].z * r0.x + r1.y;
  r0.x = cb2[12].z + r0.x;
  o3.z = -r0.x;
  r0.xyzw = cb2[20].xyzw + r2.xyzw;
  o0.xyzw = r0.xyzw;
  r1.y = (int)r5.w & 255;
  r2.x = (uint)r1.y;
  if (8 == 0) r1.y = 0; else if (8+8 < 32) {   r1.y = (uint)r5.w << (32-(8 + 8)); r1.y = (uint)r1.y >> (32-8);  } else r1.y = (uint)r5.w >> 8;
  if (8 == 0) r1.z = 0; else if (8+16 < 32) {   r1.z = (uint)r5.w << (32-(8 + 16)); r1.z = (uint)r1.z >> (32-8);  } else r1.z = (uint)r5.w >> 16;
  r1.w = (uint)r5.w >> 24;
  r2.yzw = (uint3)r1.yzw;
  r2.xyzw = float4(0.00392156886,0.00392156886,0.00392156886,0.00392156886) * r2.xyzw;
  r3.xyzw = float4(-1,-1,-1,-1) + v2.xyzw;
  r3.xyzw = cb0[5].xxxx * r3.xyzw + float4(1,1,1,1);
  o1.xyzw = r3.xyzw * r2.xyzw;
  r1.y = r1.x / cb0[4].y;
  r1.y = floor(r1.y);
  r1.x = -r1.y * cb0[4].y + r1.x;
  r1.x = floor(r1.x);
  r2.y = cb0[4].z * r1.x;
  r1.x = 1 + -cb0[4].w;
  r2.z = -r1.y * cb0[4].w + r1.x;
  r1.xy = v3.xy * cb0[4].zw + r2.yz;
  r1.z = cmp(cb0[4].x != 0.000000);
  r1.xy = r1.zz ? r1.xy : v3.xy;
  p2.xy = r1.xy * cb0[6].xy + cb0[6].zw;
  o2.x = r0.z;
  r0.y = cb1[5].x * r0.y;
  r1.xzw = float3(0.5,0.5,0.5) * r0.xwy;
  o3.w = r0.w;
  o3.xy = r1.xw + r1.zz;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: ff6353140149d560
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp float vs_TEXCOORD0;
layout(location = 2) out highp vec2 vs_TEXCOORD1;
layout(location = 3) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec3 u_xlatu7;
vec2 u_xlat8;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.yzw = vec3(u_xlatu7.xyz);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat7.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = (-u_xlat7.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat8.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat1.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat8.y = (-u_xlat7.x) * unity_ParticleUVShiftData.w + u_xlat1.x;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat8.xy;
    u_xlatb13 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb13)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0 = u_xlat0.z;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp float vs_TEXCOORD0;
layout(location = 2) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0 = exp2((-u_xlat0));
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
    u_xlatb0 = _DstBlend==1;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: ff6353140149d560
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp float vs_TEXCOORD0;
layout(location = 2) out highp vec2 vs_TEXCOORD1;
layout(location = 3) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec3 u_xlatu7;
vec2 u_xlat8;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.yzw = vec3(u_xlatu7.xyz);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat7.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = (-u_xlat7.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat8.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat1.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat8.y = (-u_xlat7.x) * unity_ParticleUVShiftData.w + u_xlat1.x;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat8.xy;
    u_xlatb13 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb13)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0 = u_xlat0.z;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp float vs_TEXCOORD0;
layout(location = 2) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0 = exp2((-u_xlat0));
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
    u_xlatb0 = _DstBlend==1;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: ff6353140149d560
#ifdef VERTEX
#version 310 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp float vs_TEXCOORD0;
layout(location = 2) out highp vec2 vs_TEXCOORD1;
layout(location = 3) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec3 u_xlatu7;
vec2 u_xlat8;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.yzw = vec3(u_xlatu7.xyz);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat7.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = (-u_xlat7.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat8.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat1.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat8.y = (-u_xlat7.x) * unity_ParticleUVShiftData.w + u_xlat1.x;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat8.xy;
    u_xlatb13 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb13)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0 = u_xlat0.z;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp float vs_TEXCOORD0;
layout(location = 2) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = vs_TEXCOORD0 * unity_FogParams.y;
    u_xlat0 = exp2((-u_xlat0));
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
    u_xlatb0 = _DstBlend==1;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "d3d11 hw_tier00 " {
"// hash: e050ff6b951566be
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyz = cb0[5].xyz * r0.xyz;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
"// hash: e050ff6b951566be
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyz = cb0[5].xyz * r0.xyz;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
"// hash: e050ff6b951566be
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyz = cb0[5].xyz * r0.xyz;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
SubProgram "d3d11 hw_tier00 " {
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 6e6796142634387c
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[5].xyzw * r0.xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 6e6796142634387c
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[5].xyzw * r0.xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 6e6796142634387c
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[5].xyzw * r0.xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "INSTANCING_ON" }
"// hash: e050ff6b951566be
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyz = cb0[5].xyz * r0.xyz;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "INSTANCING_ON" }
"// hash: e050ff6b951566be
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyz = cb0[5].xyz * r0.xyz;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "INSTANCING_ON" }
"// hash: e050ff6b951566be
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyz = cb0[5].xyz * r0.xyz;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 6e6796142634387c
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[5].xyzw * r0.xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 6e6796142634387c
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[5].xyzw * r0.xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 6e6796142634387c
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[5].xyzw * r0.xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
"// hash: 9c3f76323df08445
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = t0.Sample(s0_s, v2.xy).xyz;
  r0.xyz = cb0[7].xyz * r0.xyz;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
"// hash: 9c3f76323df08445
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = t0.Sample(s0_s, v2.xy).xyz;
  r0.xyz = cb0[7].xyz * r0.xyz;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
"// hash: 9c3f76323df08445
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = t0.Sample(s0_s, v2.xy).xyz;
  r0.xyz = cb0[7].xyz * r0.xyz;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 61a7c9a0061fcb6b
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[7].xyzw * r0.xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 61a7c9a0061fcb6b
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[7].xyzw * r0.xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 61a7c9a0061fcb6b
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[7].xyzw * r0.xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" }
"// hash: 1e730b290911a91d
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r0.xyz = cb0[5].xyz * r0.xyz;
  r0.xyz = r0.xyz * v1.xyz + -cb1[0].xyz;
  r0.w = saturate(v2.x);
  o0.xyz = r0.www * r0.xyz + cb1[0].xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" }
"// hash: 1e730b290911a91d
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r0.xyz = cb0[5].xyz * r0.xyz;
  r0.xyz = r0.xyz * v1.xyz + -cb1[0].xyz;
  r0.w = saturate(v2.x);
  o0.xyz = r0.www * r0.xyz + cb1[0].xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" }
"// hash: 1e730b290911a91d
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r0.xyz = cb0[5].xyz * r0.xyz;
  r0.xyz = r0.xyz * v1.xyz + -cb1[0].xyz;
  r0.w = saturate(v2.x);
  o0.xyz = r0.www * r0.xyz + cb1[0].xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 111bf27100036abc
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[11];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cmp(asint(cb0[10].y) == 1);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = cb0[5].xyzw * r1.xyzw;
  r0.yzw = r1.xyz * v1.xyz + -cb1[0].xyz;
  r1.xyzw = v1.xyzw * r1.xyzw;
  r2.x = saturate(v2.x);
  r0.yzw = r2.xxx * r0.yzw + cb1[0].xyz;
  r1.xyz = r2.xxx * r1.xyz;
  o0.w = r1.w;
  o0.xyz = r0.xxx ? r1.xyz : r0.yzw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 111bf27100036abc
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[11];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cmp(asint(cb0[10].y) == 1);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = cb0[5].xyzw * r1.xyzw;
  r0.yzw = r1.xyz * v1.xyz + -cb1[0].xyz;
  r1.xyzw = v1.xyzw * r1.xyzw;
  r2.x = saturate(v2.x);
  r0.yzw = r2.xxx * r0.yzw + cb1[0].xyz;
  r1.xyz = r2.xxx * r1.xyz;
  o0.w = r1.w;
  o0.xyz = r0.xxx ? r1.xyz : r0.yzw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 111bf27100036abc
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[11];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cmp(asint(cb0[10].y) == 1);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = cb0[5].xyzw * r1.xyzw;
  r0.yzw = r1.xyz * v1.xyz + -cb1[0].xyz;
  r1.xyzw = v1.xyzw * r1.xyzw;
  r2.x = saturate(v2.x);
  r0.yzw = r2.xxx * r0.yzw + cb1[0].xyz;
  r1.xyz = r2.xxx * r1.xyz;
  o0.w = r1.w;
  o0.xyz = r0.xxx ? r1.xyz : r0.yzw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
"// hash: a49e71fd9b6dbf14
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r0.yzw = cb0[5].xyz * r1.xyz;
  r0.yzw = r0.yzw * v1.xyz + -cb2[0].xyz;
  o0.xyz = r0.xxx * r0.yzw + cb2[0].xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
"// hash: a49e71fd9b6dbf14
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r0.yzw = cb0[5].xyz * r1.xyz;
  r0.yzw = r0.yzw * v1.xyz + -cb2[0].xyz;
  o0.xyz = r0.xxx * r0.yzw + cb2[0].xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
"// hash: a49e71fd9b6dbf14
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r0.yzw = cb0[5].xyz * r1.xyz;
  r0.yzw = r0.yzw * v1.xyz + -cb2[0].xyz;
  o0.xyz = r0.xxx * r0.yzw + cb2[0].xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 14c690d0796519fb
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[11];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = cb0[5].xyzw * r1.xyzw;
  r0.yzw = r1.xyz * v1.xyz + -cb2[0].xyz;
  r1.xyzw = v1.xyzw * r1.xyzw;
  r0.yzw = r0.xxx * r0.yzw + cb2[0].xyz;
  r1.xyz = r1.xyz * r0.xxx;
  o0.w = r1.w;
  r0.x = cmp(asint(cb0[10].y) == 1);
  o0.xyz = r0.xxx ? r1.xyz : r0.yzw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 14c690d0796519fb
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[11];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = cb0[5].xyzw * r1.xyzw;
  r0.yzw = r1.xyz * v1.xyz + -cb2[0].xyz;
  r1.xyzw = v1.xyzw * r1.xyzw;
  r0.yzw = r0.xxx * r0.yzw + cb2[0].xyz;
  r1.xyz = r1.xyz * r0.xxx;
  o0.w = r1.w;
  r0.x = cmp(asint(cb0[10].y) == 1);
  o0.xyz = r0.xxx ? r1.xyz : r0.yzw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 14c690d0796519fb
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[11];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = cb0[5].xyzw * r1.xyzw;
  r0.yzw = r1.xyz * v1.xyz + -cb2[0].xyz;
  r1.xyzw = v1.xyzw * r1.xyzw;
  r0.yzw = r0.xxx * r0.yzw + cb2[0].xyz;
  r1.xyz = r1.xyz * r0.xxx;
  o0.w = r1.w;
  r0.x = cmp(asint(cb0[10].y) == 1);
  o0.xyz = r0.xxx ? r1.xyz : r0.yzw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
"// hash: e37ee8c1d7b34f8
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r0.yzw = t0.Sample(s0_s, w2.xy).xyz;
  r0.yzw = cb0[7].xyz * r0.yzw;
  r0.yzw = r0.yzw * v1.xyz + -cb2[0].xyz;
  o0.xyz = r0.xxx * r0.yzw + cb2[0].xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
"// hash: e37ee8c1d7b34f8
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r0.yzw = t0.Sample(s0_s, w2.xy).xyz;
  r0.yzw = cb0[7].xyz * r0.yzw;
  r0.yzw = r0.yzw * v1.xyz + -cb2[0].xyz;
  o0.xyz = r0.xxx * r0.yzw + cb2[0].xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
"// hash: e37ee8c1d7b34f8
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r0.yzw = t0.Sample(s0_s, w2.xy).xyz;
  r0.yzw = cb0[7].xyz * r0.yzw;
  r0.yzw = r0.yzw * v1.xyz + -cb2[0].xyz;
  o0.xyz = r0.xxx * r0.yzw + cb2[0].xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: c0173516c0da78f2
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[13];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = cb0[7].xyzw * r1.xyzw;
  r0.yzw = r1.xyz * v1.xyz + -cb2[0].xyz;
  r1.xyzw = v1.xyzw * r1.xyzw;
  r0.yzw = r0.xxx * r0.yzw + cb2[0].xyz;
  r1.xyz = r1.xyz * r0.xxx;
  o0.w = r1.w;
  r0.x = cmp(asint(cb0[12].y) == 1);
  o0.xyz = r0.xxx ? r1.xyz : r0.yzw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: c0173516c0da78f2
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[13];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = cb0[7].xyzw * r1.xyzw;
  r0.yzw = r1.xyz * v1.xyz + -cb2[0].xyz;
  r1.xyzw = v1.xyzw * r1.xyzw;
  r0.yzw = r0.xxx * r0.yzw + cb2[0].xyz;
  r1.xyz = r1.xyz * r0.xxx;
  o0.w = r1.w;
  r0.x = cmp(asint(cb0[12].y) == 1);
  o0.xyz = r0.xxx ? r1.xyz : r0.yzw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: c0173516c0da78f2
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[13];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = cb0[7].xyzw * r1.xyzw;
  r0.yzw = r1.xyz * v1.xyz + -cb2[0].xyz;
  r1.xyzw = v1.xyzw * r1.xyzw;
  r0.yzw = r0.xxx * r0.yzw + cb2[0].xyz;
  r1.xyz = r1.xyz * r0.xxx;
  o0.w = r1.w;
  r0.x = cmp(asint(cb0[12].y) == 1);
  o0.xyz = r0.xxx ? r1.xyz : r0.yzw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"// hash: 1e4723eb07354d7e
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyz = cb0[5].xyz * r0.xyz;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"// hash: 1e4723eb07354d7e
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyz = cb0[5].xyz * r0.xyz;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"// hash: 1e4723eb07354d7e
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyz = cb0[5].xyz * r0.xyz;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: d57db55776072cfa
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[5].xyzw * r0.xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: d57db55776072cfa
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[5].xyzw * r0.xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: d57db55776072cfa
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[5].xyzw * r0.xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 1e4723eb07354d7e
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyz = cb0[5].xyz * r0.xyz;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 1e4723eb07354d7e
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyz = cb0[5].xyz * r0.xyz;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 1e4723eb07354d7e
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyz = cb0[5].xyz * r0.xyz;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: d57db55776072cfa
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[5].xyzw * r0.xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: d57db55776072cfa
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[5].xyzw * r0.xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: d57db55776072cfa
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[5].xyzw * r0.xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: fd02a9bd0a301a5b
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = t0.Sample(s0_s, v2.xy).xyz;
  r0.xyz = cb0[7].xyz * r0.xyz;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: fd02a9bd0a301a5b
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = t0.Sample(s0_s, v2.xy).xyz;
  r0.xyz = cb0[7].xyz * r0.xyz;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: fd02a9bd0a301a5b
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = t0.Sample(s0_s, v2.xy).xyz;
  r0.xyz = cb0[7].xyz * r0.xyz;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: b49d7c51dfa4c40
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[7].xyzw * r0.xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: b49d7c51dfa4c40
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[7].xyzw * r0.xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: b49d7c51dfa4c40
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[7].xyzw * r0.xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
"// hash: ef40b3650e30a166
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r0.xyz = cb0[5].xyz * r0.xyz;
  r0.xyz = r0.xyz * v1.xyz + -cb1[0].xyz;
  r0.w = saturate(v2.x);
  o0.xyz = r0.www * r0.xyz + cb1[0].xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
"// hash: ef40b3650e30a166
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r0.xyz = cb0[5].xyz * r0.xyz;
  r0.xyz = r0.xyz * v1.xyz + -cb1[0].xyz;
  r0.w = saturate(v2.x);
  o0.xyz = r0.www * r0.xyz + cb1[0].xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
"// hash: ef40b3650e30a166
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r0.xyz = cb0[5].xyz * r0.xyz;
  r0.xyz = r0.xyz * v1.xyz + -cb1[0].xyz;
  r0.w = saturate(v2.x);
  o0.xyz = r0.www * r0.xyz + cb1[0].xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 9c6d8b2d2979aa8d
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[11];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cmp(asint(cb0[10].y) == 1);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = cb0[5].xyzw * r1.xyzw;
  r0.yzw = r1.xyz * v1.xyz + -cb1[0].xyz;
  r1.xyzw = v1.xyzw * r1.xyzw;
  r2.x = saturate(v2.x);
  r0.yzw = r2.xxx * r0.yzw + cb1[0].xyz;
  r1.xyz = r2.xxx * r1.xyz;
  o0.w = r1.w;
  o0.xyz = r0.xxx ? r1.xyz : r0.yzw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 9c6d8b2d2979aa8d
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[11];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cmp(asint(cb0[10].y) == 1);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = cb0[5].xyzw * r1.xyzw;
  r0.yzw = r1.xyz * v1.xyz + -cb1[0].xyz;
  r1.xyzw = v1.xyzw * r1.xyzw;
  r2.x = saturate(v2.x);
  r0.yzw = r2.xxx * r0.yzw + cb1[0].xyz;
  r1.xyz = r2.xxx * r1.xyz;
  o0.w = r1.w;
  o0.xyz = r0.xxx ? r1.xyz : r0.yzw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 9c6d8b2d2979aa8d
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[11];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cmp(asint(cb0[10].y) == 1);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = cb0[5].xyzw * r1.xyzw;
  r0.yzw = r1.xyz * v1.xyz + -cb1[0].xyz;
  r1.xyzw = v1.xyzw * r1.xyzw;
  r2.x = saturate(v2.x);
  r0.yzw = r2.xxx * r0.yzw + cb1[0].xyz;
  r1.xyz = r2.xxx * r1.xyz;
  o0.w = r1.w;
  o0.xyz = r0.xxx ? r1.xyz : r0.yzw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 22d8c20d581519f8
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r0.yzw = cb0[5].xyz * r1.xyz;
  r0.yzw = r0.yzw * v1.xyz + -cb2[0].xyz;
  o0.xyz = r0.xxx * r0.yzw + cb2[0].xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 22d8c20d581519f8
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r0.yzw = cb0[5].xyz * r1.xyz;
  r0.yzw = r0.yzw * v1.xyz + -cb2[0].xyz;
  o0.xyz = r0.xxx * r0.yzw + cb2[0].xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: 22d8c20d581519f8
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r0.yzw = cb0[5].xyz * r1.xyz;
  r0.yzw = r0.yzw * v1.xyz + -cb2[0].xyz;
  o0.xyz = r0.xxx * r0.yzw + cb2[0].xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 6bd95aa2585f49e1
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[11];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = cb0[5].xyzw * r1.xyzw;
  r0.yzw = r1.xyz * v1.xyz + -cb2[0].xyz;
  r1.xyzw = v1.xyzw * r1.xyzw;
  r0.yzw = r0.xxx * r0.yzw + cb2[0].xyz;
  r1.xyz = r1.xyz * r0.xxx;
  o0.w = r1.w;
  r0.x = cmp(asint(cb0[10].y) == 1);
  o0.xyz = r0.xxx ? r1.xyz : r0.yzw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 6bd95aa2585f49e1
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[11];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = cb0[5].xyzw * r1.xyzw;
  r0.yzw = r1.xyz * v1.xyz + -cb2[0].xyz;
  r1.xyzw = v1.xyzw * r1.xyzw;
  r0.yzw = r0.xxx * r0.yzw + cb2[0].xyz;
  r1.xyz = r1.xyz * r0.xxx;
  o0.w = r1.w;
  r0.x = cmp(asint(cb0[10].y) == 1);
  o0.xyz = r0.xxx ? r1.xyz : r0.yzw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: 6bd95aa2585f49e1
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[11];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = cb0[5].xyzw * r1.xyzw;
  r0.yzw = r1.xyz * v1.xyz + -cb2[0].xyz;
  r1.xyzw = v1.xyzw * r1.xyzw;
  r0.yzw = r0.xxx * r0.yzw + cb2[0].xyz;
  r1.xyz = r1.xyz * r0.xxx;
  o0.w = r1.w;
  r0.x = cmp(asint(cb0[10].y) == 1);
  o0.xyz = r0.xxx ? r1.xyz : r0.yzw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: cfc359f9dd76bc91
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r0.yzw = t0.Sample(s0_s, w2.xy).xyz;
  r0.yzw = cb0[7].xyz * r0.yzw;
  r0.yzw = r0.yzw * v1.xyz + -cb2[0].xyz;
  o0.xyz = r0.xxx * r0.yzw + cb2[0].xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: cfc359f9dd76bc91
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r0.yzw = t0.Sample(s0_s, w2.xy).xyz;
  r0.yzw = cb0[7].xyz * r0.yzw;
  r0.yzw = r0.yzw * v1.xyz + -cb2[0].xyz;
  o0.xyz = r0.xxx * r0.yzw + cb2[0].xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"// hash: cfc359f9dd76bc91
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r0.yzw = t0.Sample(s0_s, w2.xy).xyz;
  r0.yzw = cb0[7].xyz * r0.yzw;
  r0.yzw = r0.yzw * v1.xyz + -cb2[0].xyz;
  o0.xyz = r0.xxx * r0.yzw + cb2[0].xyz;
  o0.w = 1;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
""
}
SubProgram "d3d11 hw_tier00 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: d0609c8470ab36b5
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[13];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = cb0[7].xyzw * r1.xyzw;
  r0.yzw = r1.xyz * v1.xyz + -cb2[0].xyz;
  r1.xyzw = v1.xyzw * r1.xyzw;
  r0.yzw = r0.xxx * r0.yzw + cb2[0].xyz;
  r1.xyz = r1.xyz * r0.xxx;
  o0.w = r1.w;
  r0.x = cmp(asint(cb0[12].y) == 1);
  o0.xyz = r0.xxx ? r1.xyz : r0.yzw;
  return;
}"
}
SubProgram "d3d11 hw_tier01 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: d0609c8470ab36b5
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[13];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = cb0[7].xyzw * r1.xyzw;
  r0.yzw = r1.xyz * v1.xyz + -cb2[0].xyz;
  r1.xyzw = v1.xyzw * r1.xyzw;
  r0.yzw = r0.xxx * r0.yzw + cb2[0].xyz;
  r1.xyz = r1.xyz * r0.xxx;
  o0.w = r1.w;
  r0.x = cmp(asint(cb0[12].y) == 1);
  o0.xyz = r0.xxx ? r1.xyz : r0.yzw;
  return;
}"
}
SubProgram "d3d11 hw_tier02 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"// hash: d0609c8470ab36b5
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[2];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[13];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = v2.x / cb1[5].y;
  r0.x = 1 + -r0.x;
  r0.x = cb1[5].z * r0.x;
  r0.x = max(0, r0.x);
  r0.x = cb2[1].y * r0.x;
  r0.x = exp2(-r0.x);
  r0.x = min(1, r0.x);
  r1.xyzw = t0.Sample(s0_s, w2.xy).xyzw;
  r1.xyzw = cb0[7].xyzw * r1.xyzw;
  r0.yzw = r1.xyz * v1.xyz + -cb2[0].xyz;
  r1.xyzw = v1.xyzw * r1.xyzw;
  r0.yzw = r0.xxx * r0.yzw + cb2[0].xyz;
  r1.xyz = r1.xyz * r0.xxx;
  o0.w = r1.w;
  r0.x = cmp(asint(cb0[12].y) == 1);
  o0.xyz = r0.xxx ? r1.xyz : r0.yzw;
  return;
}"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_EXP" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
}
}
}
Fallback "VertexLit"
CustomEditor "StandardParticlesShaderGUI"
}