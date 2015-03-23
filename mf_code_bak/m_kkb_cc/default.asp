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

//Response.Write(_getWebServerQuestInfo1())


var _tp = GC.query.str('tp') || 'home';


var _getHomeWrite=function(_tp) {
	var _home='hi '+GC.quest.Q('web_domain')
		,_nav ='<a href="/">home</a>'
			+' | <a href="?tp=serverQuest">serverQuestInfo</a>'
			+' | <a href="/cookie.asp">cookie</a>'
			+' | <a href="/ado.asp">ado</a>'
			+' | <a href="/adocmd.asp">ado cmd</a>'
			+' | <a href="xq3_sign.asp">xq3-sign</a>'
			+' | <a href="x3_sign2.asp">xq3-sign2</a>'
		,_foot ='<hr />'+codecoke.get.timeformat((new Date()),'yyyy-mm-dd hh.nn.sssss')
		;
	switch (_tp) {
		case('serverQuest') : _home=_getWebServerQuestInfo1();	break;
		default: _home='hi '+GC.quest.Q('web_domain');

	}

	return _nav
		+'<hr />'
		+_home
		+'<div style="text-align:center; border-top:1px solid #bbb;">'+_foot+'</div>'
		;
};




Response.Write(
	_getHomeWrite((GC.query.str('tp') || 'home'))
);


%>