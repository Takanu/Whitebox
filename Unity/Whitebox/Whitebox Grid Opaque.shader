// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Whitebox/Grid Opaque"
{
	Properties
	{
		_BoundaryTexture("Boundary Texture", 2D) = "white" {}
		_BoundaryScale("Boundary Scale", Float) = 1
		_UnitBadgeTexture("Unit Badge Texture", 2D) = "white" {}
		_UnitBadgeScale("Unit Badge Scale", Float) = 1
		_GridTexture("Grid Texture", 2D) = "white" {}
		_GridScale("Grid Scale", Float) = 1
		_BackgroundColor("Background Color", Color) = (1,1,1,0)
		_BoundaryColorMix("Boundary Color Mix", Color) = (1,1,1,0)
		_BoundaryAlpha("Boundary Alpha", Range( 0 , 1)) = 1
		_BoundaryInvert("Boundary Invert", Range( 0 , 1)) = 0
		_UnitBadgeColorMix("Unit Badge Color Mix", Color) = (1,1,1,0)
		_UnitBadgeAlpha("Unit Badge Alpha", Range( 0 , 1)) = 1
		_UnitBadgeInvert("Unit Badge Invert", Range( 0 , 1)) = 0
		_GridColorMix("Grid Color Mix", Color) = (1,1,1,0)
		_GridAlpha("Grid Alpha", Range( 0 , 1)) = 0
		_GridInvert("Grid Invert", Range( 0 , 1)) = 0
		_TriPlanarFalloff("Tri-Planar Falloff", Range( 0.001 , 15)) = 10
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform float4 _BackgroundColor;
		uniform sampler2D _GridTexture;
		uniform float _GridScale;
		uniform float _TriPlanarFalloff;
		uniform float _GridInvert;
		uniform float4 _GridColorMix;
		uniform float _GridAlpha;
		uniform sampler2D _UnitBadgeTexture;
		uniform float _UnitBadgeScale;
		uniform float _UnitBadgeInvert;
		uniform float4 _UnitBadgeColorMix;
		uniform float _UnitBadgeAlpha;
		uniform sampler2D _BoundaryTexture;
		uniform float _BoundaryScale;
		uniform float _BoundaryInvert;
		uniform float4 _BoundaryColorMix;
		uniform float _BoundaryAlpha;


		inline float4 TriplanarSampling1_g3( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
			yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
			zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
			return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
		}


		inline float4 TriplanarSampling1_g4( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
			yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
			zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
			return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
		}


		inline float4 TriplanarSampling1_g5( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
			yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
			zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
			return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = float3(0,0,1);
			float2 temp_cast_1 = (( 1.0 / _GridScale )).xx;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float4 triplanar1_g3 = TriplanarSampling1_g3( _GridTexture, ase_worldPos, ase_worldNormal, _TriPlanarFalloff, temp_cast_1, 1.0, 0 );
			float4 lerpResult13_g3 = lerp( triplanar1_g3 , ( 1.0 - triplanar1_g3 ) , _GridInvert);
			float4 lerpResult48 = lerp( _BackgroundColor , ( lerpResult13_g3 * _GridColorMix ) , ( triplanar1_g3.a * _GridAlpha ));
			float2 temp_cast_3 = (( 1.0 / _UnitBadgeScale )).xx;
			float4 triplanar1_g4 = TriplanarSampling1_g4( _UnitBadgeTexture, ase_worldPos, ase_worldNormal, _TriPlanarFalloff, temp_cast_3, 1.0, 0 );
			float4 lerpResult13_g4 = lerp( triplanar1_g4 , ( 1.0 - triplanar1_g4 ) , _UnitBadgeInvert);
			float4 lerpResult47 = lerp( lerpResult48 , ( lerpResult13_g4 * _UnitBadgeColorMix ) , ( triplanar1_g4.a * _UnitBadgeAlpha ));
			float2 temp_cast_5 = (( 1.0 / _BoundaryScale )).xx;
			float4 triplanar1_g5 = TriplanarSampling1_g5( _BoundaryTexture, ase_worldPos, ase_worldNormal, _TriPlanarFalloff, temp_cast_5, 1.0, 0 );
			float4 lerpResult13_g5 = lerp( triplanar1_g5 , ( 1.0 - triplanar1_g5 ) , _BoundaryInvert);
			float4 lerpResult49 = lerp( lerpResult47 , ( lerpResult13_g5 * _BoundaryColorMix ) , ( triplanar1_g5.a * _BoundaryAlpha ));
			o.Albedo = lerpResult49.xyz;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 tSpace0 : TEXCOORD1;
				float4 tSpace1 : TEXCOORD2;
				float4 tSpace2 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18910
0;638;1920;353;4033.646;654.122;2.125261;True;True
Node;AmplifyShaderEditor.CommentaryNode;75;-2736,-16;Inherit;False;999.4186;454.4208;Comment;7;89;65;62;6;84;15;58;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;66;-3312,-112;Inherit;False;Property;_TriPlanarFalloff;Tri-Planar Falloff;16;0;Create;True;0;0;0;False;0;False;10;1;0.001;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;74;-2736,-544;Inherit;False;1003.236;460.5602;Comment;7;83;50;64;61;82;56;7;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-2432,112;Inherit;False;Property;_GridScale;Grid Scale;5;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;88;-2731.619,342.9492;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-2416,288;Inherit;False;Property;_GridAlpha;Grid Alpha;14;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;58;-2672,224;Inherit;False;Property;_GridColorMix;Grid Color Mix;13;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;6;-2688,32;Inherit;True;Property;_GridTexture;Grid Texture;4;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleDivideOpNode;65;-2272,112;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-2413.875,208;Inherit;False;Property;_GridInvert;Grid Invert;15;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;87;-2150.94,378.3752;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-2432,-416;Inherit;False;Property;_UnitBadgeScale;Unit Badge Scale;3;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;86;-2686.951,-123.7501;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;73;-2736,-1088;Inherit;False;1008.329;481.5505;Comment;9;79;78;81;53;80;77;63;60;5;Boundary Layer;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;64;-2240,-416;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;79;-2720.69,-642.7354;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;17;-1936,512;Inherit;False;Property;_BackgroundColor;Background Color;6;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;60;-2432,-944;Inherit;False;Property;_BoundaryScale;Boundary Scale;1;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;7;-2688,-496;Inherit;True;Property;_UnitBadgeTexture;Unit Badge Texture;2;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;50;-2400,-240;Inherit;False;Property;_UnitBadgeAlpha;Unit Badge Alpha;11;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;-2401.54,-317.8747;Inherit;False;Property;_UnitBadgeInvert;Unit Badge Invert;12;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;85;-2163.262,-146.854;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;84;-1968,48;Inherit;False;Whitebox Grid Sampler;-1;;3;1ca7364793c56b94698c10ff1ba35dc2;0;6;6;SAMPLER2D;0;False;7;FLOAT2;0,0;False;9;FLOAT;0;False;10;FLOAT4;0,0,0,0;False;14;FLOAT;0;False;15;FLOAT;0;False;2;FLOAT4;0;FLOAT;11
Node;AmplifyShaderEditor.ColorNode;56;-2688,-304;Inherit;False;Property;_UnitBadgeColorMix;Unit Badge Color Mix;10;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;5;-2683.568,-1038.46;Inherit;True;Property;_BoundaryTexture;Boundary Texture;0;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;53;-2384,-768;Inherit;False;Property;_BoundaryAlpha;Boundary Alpha;8;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;78;-2153.398,-697.4934;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;82;-1984,-480;Inherit;False;Whitebox Grid Sampler;-1;;4;1ca7364793c56b94698c10ff1ba35dc2;0;6;6;SAMPLER2D;0;False;7;FLOAT2;0,0;False;9;FLOAT;0;False;10;FLOAT4;0,0,0,0;False;14;FLOAT;0;False;15;FLOAT;0;False;2;FLOAT4;0;FLOAT;11
Node;AmplifyShaderEditor.SimpleDivideOpNode;63;-2240,-944;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;48;-1568,16;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-2384,-848;Inherit;False;Property;_BoundaryInvert;Boundary Invert;9;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;80;-2672,-848;Inherit;False;Property;_BoundaryColorMix;Boundary Color Mix;7;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;47;-1472,-496;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;77;-1984,-1024;Inherit;False;Whitebox Grid Sampler;-1;;5;1ca7364793c56b94698c10ff1ba35dc2;0;6;6;SAMPLER2D;0;False;7;FLOAT2;0,0;False;9;FLOAT;0;False;10;FLOAT4;0,0,0,0;False;14;FLOAT;0;False;15;FLOAT;0;False;2;FLOAT4;0;FLOAT;11
Node;AmplifyShaderEditor.LerpOp;49;-1280,-832;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RelayNode;18;-944,-848;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-688,-848;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Whitebox/Grid Opaque;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;16;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;88;0;66;0
WireConnection;65;1;62;0
WireConnection;87;0;88;0
WireConnection;86;0;66;0
WireConnection;64;1;61;0
WireConnection;79;0;66;0
WireConnection;85;0;86;0
WireConnection;84;6;6;0
WireConnection;84;7;65;0
WireConnection;84;9;87;0
WireConnection;84;10;58;0
WireConnection;84;14;89;0
WireConnection;84;15;15;0
WireConnection;78;0;79;0
WireConnection;82;6;7;0
WireConnection;82;7;64;0
WireConnection;82;9;85;0
WireConnection;82;10;56;0
WireConnection;82;14;83;0
WireConnection;82;15;50;0
WireConnection;63;1;60;0
WireConnection;48;0;17;0
WireConnection;48;1;84;0
WireConnection;48;2;84;11
WireConnection;47;0;48;0
WireConnection;47;1;82;0
WireConnection;47;2;82;11
WireConnection;77;6;5;0
WireConnection;77;7;63;0
WireConnection;77;9;78;0
WireConnection;77;10;80;0
WireConnection;77;14;81;0
WireConnection;77;15;53;0
WireConnection;49;0;47;0
WireConnection;49;1;77;0
WireConnection;49;2;77;11
WireConnection;18;0;49;0
WireConnection;0;0;18;0
ASEEND*/
//CHKSM=84F872FF37F120C19B823659623B2A44447B6294