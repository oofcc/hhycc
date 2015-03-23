<!--#include virtual='/codecoke_com/func/G_codecoke_0.asp' -->
<!--#include virtual='/codecoke_com/func/G_codecoke_fn_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_fns_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_insiteapi_0.asp' -->

<%
codecoke.fn.newFunIn(GC,[['JSON','C_server_JSON']
	,['quest','C_server_request']
	,['query','C_server_querystring']
	,['iEscape','C_server_iEscape',codecoke.runnerSetting.f62,codecoke.runnerSetting.iEscapePublicKey]
]);

codecoke.fn.newFunIn(GC,'insiteapi','C_server_insiteapi');


G_localsetting.siteinfo={
		'attr':{
			'domain':'1.codecoke.com'
			,'name':'codecoke 测试站2'
			,'name_pk':'me'
			,'miibeian':'京ICP备09077692号-1'
			,'createtime':'2006-1-2 8:0:0.0'
			,'ggSearchStr':'<form action="http://www.google.com.hk/cse" id="cse-search-box">	<div><input type="hidden" name="cx" value="partner-pub-4190233654185559:13u41v-pnts" /><input type="hidden" name="ie" value="UTF-8" /><span class="ggSearchTxt"><input type="text" name="q" size="45" /></span><span class="ggSearchBtn"><input type="submit" name="sa" value="&#x641c;&#x7d22;" /></span></div></form>'
			,'ggSearchSrc':'http://www.google.com.hk/cse/brand?form=cse-search-box&amp;lang=zh-Hans'
		}
		,'stop':{
			'all':0
		}
};




GC.insiteapi._gt_siteinfo=function() {
	var _q = this._getAttr_qstrfileO_by_qstr_file('siteinfo');
	_q.child= _q.child || 'siteinfo';
	//_r =this._get_localSetting_jsonValues(_q.child);
	_r =GC.JSON.stringify(codecoke.get.inofObj(G_localsetting.siteinfo,['attr','stop']));
	if (_q.readtype=='json') {
		Response.Contenttype='text/javascript';
		Response.Expires = -1;
		Response.AddHeader('Pragma','no-cache');
		Response.AddHeader('Cache-Control','no-cache');
		Response.Write(_r);
		Response.end();
		return false;
	}
	if (_q.readtype=='script') {
		Response.Contenttype='text/javascript';
		Response.Expires = -1;
		Response.AddHeader('Pragma','no-cache');
		Response.AddHeader('Cache-Control','no-cache');
		Response.Write('window.'+_q.parent+(_q.child =='siteinfo'? '.siteinfo' :'.siteinfo.'+_q.child)+'='+_r+';');
		Response.end();
		return false;

	}
};
GC.insiteapi.go('siteinfo');


%>