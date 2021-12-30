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
		_AlbedoTexture("Albedo Texture", 2D) = "white" {}
		_AlbedoScale("Albedo Scale", Vector) = (1,1,0,0)
		_BoundaryColorMix("Boundary Color Mix", Color) = (1,1,1,0)
		_BoundaryAlpha("Boundary Alpha", Range( 0 , 1)) = 1
		_BoundaryInvert("Boundary Invert", Range( 0 , 1)) = 0
		_UnitBadgeColorMix("Unit Badge Color Mix", Color) = (1,1,1,0)
		_UnitBadgeAlpha("Unit Badge Alpha", Range( 0 , 1)) = 1
		_UnitBadgeInvert("Unit Badge Invert", Range( 0 , 1)) = 0
		_GridColorMix("Grid Color Mix", Color) = (1,1,1,0)
		_GridAlpha("Grid Alpha", Range( 0 , 1)) = 0
		_GridInvert("Grid Invert", Range( 0 , 1)) = 0
		_AlbedoColorMix("Albedo Color Mix", Color) = (1,1,1,0)
		_BackgroundColor("Background Color", Color) = (0.9058824,0.9058824,0.9058824,0)
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
		uniform sampler2D _AlbedoTexture;
		uniform float2 _AlbedoScale;
		uniform float _TriPlanarFalloff;
		uniform float4 _AlbedoColorMix;
		uniform sampler2D _GridTexture;
		uniform float _GridScale;
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


		inline float4 TriplanarSampling1_g13( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
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


		inline float4 TriplanarSampling1_g14( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
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


		inline float4 TriplanarSampling1_g15( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
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


		inline float4 TriplanarSampling1_g16( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
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
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float4 triplanar1_g13 = TriplanarSampling1_g13( _AlbedoTexture, ase_worldPos, ase_worldNormal, _TriPlanarFalloff, ( float2( 1,1 ) / _AlbedoScale ), 1.0, 0 );
			float4 lerpResult13_g13 = lerp( triplanar1_g13 , ( 1.0 - triplanar1_g13 ) , 0.0);
			float4 lerpResult108 = lerp( _BackgroundColor , ( lerpResult13_g13 * _AlbedoColorMix ) , ( triplanar1_g13.a * 1.0 ));
			float2 temp_cast_2 = (( 1.0 / _GridScale )).xx;
			float4 triplanar1_g14 = TriplanarSampling1_g14( _GridTexture, ase_worldPos, ase_worldNormal, _TriPlanarFalloff, temp_cast_2, 1.0, 0 );
			float4 lerpResult13_g14 = lerp( triplanar1_g14 , ( 1.0 - triplanar1_g14 ) , _GridInvert);
			float4 lerpResult48 = lerp( lerpResult108 , ( lerpResult13_g14 * _GridColorMix ) , ( triplanar1_g14.a * _GridAlpha ));
			float2 temp_cast_4 = (( 1.0 / _UnitBadgeScale )).xx;
			float4 triplanar1_g15 = TriplanarSampling1_g15( _UnitBadgeTexture, ase_worldPos, ase_worldNormal, _TriPlanarFalloff, temp_cast_4, 1.0, 0 );
			float4 lerpResult13_g15 = lerp( triplanar1_g15 , ( 1.0 - triplanar1_g15 ) , _UnitBadgeInvert);
			float4 lerpResult47 = lerp( lerpResult48 , ( lerpResult13_g15 * _UnitBadgeColorMix ) , ( triplanar1_g15.a * _UnitBadgeAlpha ));
			float2 temp_cast_6 = (( 1.0 / _BoundaryScale )).xx;
			float4 triplanar1_g16 = TriplanarSampling1_g16( _BoundaryTexture, ase_worldPos, ase_worldNormal, _TriPlanarFalloff, temp_cast_6, 1.0, 0 );
			float4 lerpResult13_g16 = lerp( triplanar1_g16 , ( 1.0 - triplanar1_g16 ) , _BoundaryInvert);
			float4 lerpResult49 = lerp( lerpResult47 , ( lerpResult13_g16 * _BoundaryColorMix ) , ( triplanar1_g16.a * _BoundaryAlpha ));
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
Version=18930
0;400;1528;591;3178.54;-101.7904;1.997381;True;True
Node;AmplifyShaderEditor.RangedFloatNode;66;-3385.542,66.04404;Inherit;False;Property;_TriPlanarFalloff;Tri-Planar Falloff;19;0;Create;True;0;0;0;False;0;False;10;15;0.001;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;90;-2738.895,496;Inherit;False;1365.19;490.7841;Comment;9;107;96;101;102;95;94;100;103;109;Albedo Layer;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;75;-2736,-16;Inherit;False;999.4186;454.4208;Comment;8;89;65;62;6;15;58;87;88;Grid Layer;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;103;-2736.045,849.0325;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;100;-2418.895,642.139;Inherit;False;Property;_AlbedoScale;Albedo Scale;7;0;Create;True;0;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;88;-2731.619,342.9492;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-2432,112;Inherit;False;Property;_GridScale;Grid Scale;5;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;74;-2736,-544;Inherit;False;1003.236;460.5602;Comment;8;83;50;64;61;56;7;85;86;Unit Badge Layer;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;95;-2690.895,544;Inherit;True;Property;_AlbedoTexture;Albedo Texture;6;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;94;-2674.895,736;Inherit;False;Property;_AlbedoColorMix;Albedo Color Mix;17;0;Create;True;0;0;0;False;0;False;1,1,1,0;0.2358491,0.2358491,0.2358491,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;102;-2393.503,887.7375;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;101;-2432,800;Inherit;False;Constant;_AlbedoAlpha;Albedo Alpha;18;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;96;-2178.895,624;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;6;-2688,32;Inherit;True;Property;_GridTexture;Grid Texture;4;0;Create;True;0;0;0;False;0;False;None;2a77ecb5560237043a29407ed8125742;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;109;-1936,784;Inherit;False;Property;_BackgroundColor;Background Color;18;0;Create;True;0;0;0;False;0;False;0.9058824,0.9058824,0.9058824,0;0.2358491,0.2358491,0.2358491,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;61;-2432,-416;Inherit;False;Property;_UnitBadgeScale;Unit Badge Scale;3;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-2413.875,208;Inherit;False;Property;_GridInvert;Grid Invert;16;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;65;-2272,112;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;73;-2736,-1088;Inherit;False;1008.329;481.5505;Comment;8;79;78;81;53;80;63;60;5;Boundary Layer;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-2416,288;Inherit;False;Property;_GridAlpha;Grid Alpha;15;0;Create;True;0;0;0;False;0;False;0;0.708;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;58;-2672,224;Inherit;False;Property;_GridColorMix;Grid Color Mix;14;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;86;-2686.951,-123.7501;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;87;-2150.94,378.3752;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;107;-1968,560;Inherit;False;Whitebox Grid Sampler;-1;;13;1ca7364793c56b94698c10ff1ba35dc2;0;7;6;SAMPLER2D;0;False;16;FLOAT3;0,0,0;False;7;FLOAT2;0,0;False;9;FLOAT;0;False;10;FLOAT4;0,0,0,0;False;14;FLOAT;0;False;15;FLOAT;0;False;2;FLOAT4;0;FLOAT;11
Node;AmplifyShaderEditor.RangedFloatNode;50;-2400,-240;Inherit;False;Property;_UnitBadgeAlpha;Unit Badge Alpha;12;0;Create;True;0;0;0;False;0;False;1;0.468;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;64;-2240,-416;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;85;-2163.262,-146.854;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;56;-2688,-304;Inherit;False;Property;_UnitBadgeColorMix;Unit Badge Color Mix;11;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;108;-1556.667,619.1121;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexturePropertyNode;7;-2688,-496;Inherit;True;Property;_UnitBadgeTexture;Unit Badge Texture;2;0;Create;True;0;0;0;False;0;False;None;856b2bed4caa6764182567554c3830ab;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.WireNode;79;-2720.69,-642.7354;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-2432,-944;Inherit;False;Property;_BoundaryScale;Boundary Scale;1;0;Create;True;0;0;0;False;0;False;1;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;-2401.54,-317.8747;Inherit;False;Property;_UnitBadgeInvert;Unit Badge Invert;13;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;104;-1968,48;Inherit;False;Whitebox Grid Sampler;-1;;14;1ca7364793c56b94698c10ff1ba35dc2;0;7;6;SAMPLER2D;0;False;16;FLOAT3;0,0,0;False;7;FLOAT2;0,0;False;9;FLOAT;0;False;10;FLOAT4;0,0,0,0;False;14;FLOAT;0;False;15;FLOAT;0;False;2;FLOAT4;0;FLOAT;11
Node;AmplifyShaderEditor.RangedFloatNode;53;-2384,-768;Inherit;False;Property;_BoundaryAlpha;Boundary Alpha;9;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;5;-2683.568,-1038.46;Inherit;True;Property;_BoundaryTexture;Boundary Texture;0;0;Create;True;0;0;0;False;0;False;None;af4fe5b72cba57c49a9e405ec530b549;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;80;-2672,-848;Inherit;False;Property;_BoundaryColorMix;Boundary Color Mix;8;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;78;-2153.398,-697.4934;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;105;-1984,-480;Inherit;False;Whitebox Grid Sampler;-1;;15;1ca7364793c56b94698c10ff1ba35dc2;0;7;6;SAMPLER2D;0;False;16;FLOAT3;0,0,0;False;7;FLOAT2;0,0;False;9;FLOAT;0;False;10;FLOAT4;0,0,0,0;False;14;FLOAT;0;False;15;FLOAT;0;False;2;FLOAT4;0;FLOAT;11
Node;AmplifyShaderEditor.SimpleDivideOpNode;63;-2240,-944;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;48;-1264,32;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-2384,-848;Inherit;False;Property;_BoundaryInvert;Boundary Invert;10;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;106;-1984,-1024;Inherit;False;Whitebox Grid Sampler;-1;;16;1ca7364793c56b94698c10ff1ba35dc2;0;7;6;SAMPLER2D;0;False;16;FLOAT3;0,0,0;False;7;FLOAT2;0,0;False;9;FLOAT;0;False;10;FLOAT4;0,0,0,0;False;14;FLOAT;0;False;15;FLOAT;0;False;2;FLOAT4;0;FLOAT;11
Node;AmplifyShaderEditor.LerpOp;47;-1104,-496;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;49;-880,-1040;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RelayNode;18;-608,-1040;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-208,-1040;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Whitebox/Grid Opaque;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;103;0;66;0
WireConnection;88;0;66;0
WireConnection;102;0;103;0
WireConnection;96;1;100;0
WireConnection;65;1;62;0
WireConnection;86;0;66;0
WireConnection;87;0;88;0
WireConnection;107;6;95;0
WireConnection;107;7;96;0
WireConnection;107;9;102;0
WireConnection;107;10;94;0
WireConnection;107;15;101;0
WireConnection;64;1;61;0
WireConnection;85;0;86;0
WireConnection;108;0;109;0
WireConnection;108;1;107;0
WireConnection;108;2;107;11
WireConnection;79;0;66;0
WireConnection;104;6;6;0
WireConnection;104;7;65;0
WireConnection;104;9;87;0
WireConnection;104;10;58;0
WireConnection;104;14;89;0
WireConnection;104;15;15;0
WireConnection;78;0;79;0
WireConnection;105;6;7;0
WireConnection;105;7;64;0
WireConnection;105;9;85;0
WireConnection;105;10;56;0
WireConnection;105;14;83;0
WireConnection;105;15;50;0
WireConnection;63;1;60;0
WireConnection;48;0;108;0
WireConnection;48;1;104;0
WireConnection;48;2;104;11
WireConnection;106;6;5;0
WireConnection;106;7;63;0
WireConnection;106;9;78;0
WireConnection;106;10;80;0
WireConnection;106;14;81;0
WireConnection;106;15;53;0
WireConnection;47;0;48;0
WireConnection;47;1;105;0
WireConnection;47;2;105;11
WireConnection;49;0;47;0
WireConnection;49;1;106;0
WireConnection;49;2;106;11
WireConnection;18;0;49;0
WireConnection;0;0;18;0
ASEEND*/
//CHKSM=D9A90286EF86783A1DDABB417EFFF2902995021F