<!--#include virtual='/codecoke_com/func/G_codecoke_0.asp' -->
<!--#include virtual='/codecoke_com/func/G_codecoke_fn_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_fns_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_insiteapi_0.asp' -->

<!--#include virtual='/codecoke_com/vol/G_localsetting_basic_0.asp' -->
<%
codecoke.fn.newFunIn(GC,[['JSON','C_server_JSON']
	,['quest','C_server_request']
	,['query','C_server_querystring']
	,['iEscape','C_server_iEscape',codecoke.runnerSetting.f62,codecoke.runnerSetting.iEscapePublicKey]
]);

codecoke.fn.newFunIn(GC,'insiteapi','C_server_insiteapi');
GC.insiteapi._get_localSetting_jsonValues=function(_f) {
	if (_f=='head') {
		return '{'
				+'"web_timeInt":'+GC.quest.Q('web_timeInt')
				+',"web_rootdomain":"'+GC.quest.Q('web_rootdomain')+'"'
				+',"web_iisid":"'+GC.quest.Q('web_iisid')+'"'
				+',"web_ip":"'+GC.quest.Q('web_ip')+'"'
				+',"agent_ip":"'+GC.quest.Q('agent_ip')+'"'
				+(GC.quest.Q('agent_language') ? ',"agent_language":"'+GC.quest.Q('agent_language')+'"' :'')
			+'}'
		;
	}
	if (_f=='localsetting') {
		var _apiGo=GC.query.str('apiGo','noblank')
		,_apiNext=GC.query.str('apiNext','noblank')
		,_apiArgs=GC.query.str('apiArgs','noblank')
		,_apiCid=GC.query.str('apiCid','guid32')
		,_sitename_pk=GC.query.str('sitename_pk','noblank')
		;
		// arguments.callee.call
		return '{"head":'+arguments.callee.call(this,'head')
				+',"basic":'+GC.JSON.stringify(codecoke.get.inofObj(G_localsetting.basic,['gtpath','subkeys']))
				+( _apiGo ? ',"lapiGo":"'+_apiGo+'"':'' )
				+( _apiCid ? ',"lapiCid":"'+_apiCid+'"' :'' )
				+( _apiArgs ? ',"lapiArg":"'+_apiArgs+'"' :'' )
				+( _apiNext ? ',"lapiNext":"'+_apiNext+'"' :'' )
				+( _sitename_pk ? ',"sitename_pk":"'+_sitename_pk+'"' :'' )
			+'}'
		;
	}
};
GC.insiteapi._gt_localsettingInfo=function() {
	var _q = this._getAttr_qstrfileO_by_qstr_file('localsetting');
	_r =this._get_localSetting_jsonValues((_q.child || _q.parent));


	Response.Contenttype='text/javascript';
	Response.Expires = -1;
	Response.AddHeader('Pragma','no-cache');
	Response.AddHeader('Cache-Control','no-cache');
	Response.Write(
		_q.readtype=='json'
		? _r
		: 'window.'+_q.itop+'.localsetting'+(_q.child ? '.'+_q.child :'')+'='+_r+';'
	);
	Response.end();
	return false;

};
GC.insiteapi.go('localsettingInfo');


%>