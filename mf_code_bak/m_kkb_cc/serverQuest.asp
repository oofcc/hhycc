<!--#include virtual='/codecoke_com/include.asp' -->

<%

codecoke.fn.newFunIn(GC,[
	['JSON','C_server_JSON']
	,['quest','C_server_request']
	,['query','C_server_querystring']
	,['iEscape','C_server_iEscape',codecoke.runnerSetting.f62,codecoke.runnerSetting.iEscapePublicKey]
	,['serverobj','C_server_serverobject']
]);
//codecoke.fn.newFunIn(GC,'serverobj','C_server_serverobject');

var _getWebServerQuestInfo1=function() {
	var _t = GC.quest.Q('agent_ip');
	var _t1='<strong>webServerQuestInfo</strong><br/>';
	for (var _a in GC.quest.attr.questData) {if( GC.quest.attr.questData.hasOwnProperty(_a)){
		_t1+=_a+' :   '+GC.quest.attr.questData[_a]+'<br/>';
		//Response.Write(_a+' :   '+GC.quest.attr.questData[_a]+'<br/>');
	}}
	return _t1;
}

Response.Write(_getWebServerQuestInfo1())

//var aspjpg= Server.CreateObject("persits.jpeg");

//Response.Write(aspjpg.Expires)




//for (var _a in GC.quest.attr.questData) {if( GC.quest.attr.questData.hasOwnProperty(_a)){
//	Response.Write(_a+' :   '+GC.quest.attr.questData[_a]+'<br/>');
//}}





//Response.Write(_t+' serverQuest.asp')
%>