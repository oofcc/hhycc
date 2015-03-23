<% @ LANGUAGE=JScript CODEPAGE=65001%>
<%
Response.Charset='utf-8';
Session.CodePage=65001;
	var myErr = Server.GetLastError();
	var myErrStr ='<div style="border:1px solid #000;padding:10px;width:500px;margin:10px auto;">'
		+'<h1>报告M，出错啦！</h1>'
		+'<p style="margin:10px 0;padding:0;text-align:center;border-bottom:1px dotted #aaa;">'+(new Date()).toLocaleString()+'</p>'
		+myErr.Category+'<br/>'
		+'错误号：'+myErr.Number+'<br/>'
		+'文件：'+myErr.File+'<br/>'
		+'__ '+Request.ServerVariables('PATH_TRANSLATED')+'<br/>'
		+'位置：<span style="color:green;margin-left:1em">'+myErr.Line+'行'+myErr.Column+'列</span><br/>'
		+'提示：<span style="color:red;margin-left:1em;">'+myErr.Description+'</span><br/>';
	if(myErr.Source) {
		myErrStr+='<p style="background-color:#eee;margin:3px;padding:5px;border:1px solid #bbb;">'
		+'<span style="color:blue;">'+Server.HTMLEncode(myErr.Source)+'</span><br/>';
		if(myErr.Column>0) {
			myErrStr+='<span style="color:green;">';
			for (var _i=0; _i<myErr.Column; _i++) {
				myErrStr += '-';
			}
			myErrStr+='^</span>';
		}
		myErrStr+='</p>';

	}
	if(myErr.ASPCode) {
		myErrStr+='Err.ASPCode:<br/><span style="color:blue;">'+Server.HTMLEncode(myErr.ASPCode)+'</span><br/>';
	}
	myErrStr+='<p style="margin:10px 0;padding:0;text-align:center;border-bottom:1px dotted #aaa;">浏览器信息</p>'
		+Server.HTMLEncode(Request.ServerVariables("HTTP_USER_AGENT"))+'<br/>'
		+'Microsoft ' +ScriptEngine()+' Version '+ScriptEngineMajorVersion()+' . '+ ScriptEngineMinorVersion()+' . '+ScriptEngineBuildVersion()+'<br/>'
		+'</div>';
	Response.status=500;
	Response.Write(myErrStr);
%>