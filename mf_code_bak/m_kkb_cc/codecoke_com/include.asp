<% @ LANGUAGE=JScript CODEPAGE=65001 %>

<%
//Session.CodePage=65001;
Server.ScriptTimeout=10000;
Response.Charset='utf-8';
Response.Buffer = true;

if(!this.codecoke) {
	codecoke= {
		'softcreatebyurl':'http://www.codecoke.com/','_BasicFuncObject':{}
		,'runnerSetting':{
			'iEscapePublicKey':'z1R5JCOhsGkFBYoPQxrgNH9KLe6j0AZM4pDqnSUadTV2XctIwu8lW7y3mfviEb'
			,'iEscapeCookiekey':'tI7s2pwo0SLEmGdfh8bNBquaeW1ZgilMyjrOHQv6Vz4Tc3n5U9RXJCPYFDkKAx'
			,'f62':'Az0yBx1wCv2uD3rEt4sFqGpHoInJmKiLlMkNjOgPhQfRdSbcTaU9V8W7X6Y5Ze'
			,'f10':'0123456789'
			,'f10E':'ABCDEFGHIJK'
			,'classFuncBasicName':'_BasicFuncClassObject_'

		}
	};
}
if (!this.GC) {var GC={};}
if (!this.G_localsetting) {var G_localsetting={};}
%>
<!--#include virtual='/codecoke_com/1/source/G_codecoke_1.asp' -->
<!--#include virtual='/codecoke_com/1/source/G_codecoke_fn_0.asp' -->
<!--#include virtual='/codecoke_com/1/source/C_server_fns_0.asp' -->
<!--#include virtual='/codecoke_com/1/source/C_server_cookie_action_0.asp' -->
<!--#include virtual='/codecoke_com/1/source/C_server_file_0.asp' -->
<!--#include virtual='/codecoke_com/1/source/C_server_xhr_0.asp' -->
<!--#include virtual='/codecoke_com/1/source/C_server_ado_1.asp' -->
<!--#include virtual='/codecoke_com/1/source/C_server_hex_0.asp' -->
