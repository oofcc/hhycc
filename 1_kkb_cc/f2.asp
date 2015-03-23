<!--#include virtual='/codecoke_com/func/G_codecoke_0.asp' -->
<!--#include virtual='/codecoke_com/func/G_codecoke_fn_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_fns_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_cookie_action_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_file_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_xhr_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_ado_0.asp' -->
<%


codecoke.fn.newFunIn(GC,[['JSON','C_server_JSON']
	,['quest','C_server_request']
	,['query','C_server_querystring']
	,['iEscape','C_server_iEscape',codecoke.runnerSetting.f62,codecoke.runnerSetting.iEscapePublicKey]
]);
codecoke.fn.newFunIn(GC,'serverobj','C_server_serverobject');
//codecoke.fn.newFunIn(GC,'file','C_server_file');


var _urls=[
	'f1.asp?gt=css&f=sitehome'
	,'f1.asp?gt=ico&f=sitetoollogo&v=1'
	,'f1.asp?gt=js&f=jquery&v=152' //2
	,'f1.asp?gt=js&f=codecoke&v=0'
	,'f1.asp?gt=js&f=JSON&v=0'
	,'f1.asp?gt=_js&f=script^doc@hex&v=1 ' //5
	,'codecoke_com/insiteapi/?gt=_js&f=script^$sev@localsetting&sitename_pk=lukasu'
	,'codecoke_com/insiteapi/?gt=_js&f=script^$sev@siteinfo&sitename_pk=lukasu'
	,'codecoke_com/insiteapi/?gt=_js&f=json^$sev@siteinfo&sitename_pk=lukasu' //8
	,'codecoke_com/insiteapi/gt_siteinfo_lukasu_0.asp?f=script^$app@userbar_lukasu' //9
	,'/codecoke_com/insiteapi/gt_siteinfo_lukasu_0.asp?gt=_js&f=json^$app@userbar_lukasu.signoutValue'
	,'/codecoke_com/insiteapi/gt_siteinfo_lukasu_0.asp?gt=_js&f=json^$app@userbar_lukasu.signinValue' //11
]



codecoke.fn.newFunIn(GC,'xhr','C_server_xhr');
var _r1 = GC.xhr.loadtxtO(
	//'http://2.955.me/f1.asp?gt=css&f=sitehome'
	//'http://2.955.me/f1.asp?gt=ico&f=sitetoollogo&v=1'
	//'http://2.955.me/f1.asp?gt=js&f=jquery&v=152'
	//'http://2.955.me/f1.asp?gt=js&f=codecoke&v=0'
	//'http://2.955.me/f1.asp?gt=js&f=JSON&v=0'
	//'http://2.955.me/f1.asp?gt=_js&f=script^doc@hex&v=1 '
	'http://2.955.me/'+_urls[11]

	,[
		['Referer',GC.quest.Q('web_pathurl')]
	]
	,''
	,function(_xhr,_r) {
		_r.errhead =''+_xhr.getAllResponseHeaders().split('\r').join('<br/>');
		//xmlServerHttp.getResponseHeader("Server"));
		//Response.Write(_r)
	}

);




Response.Write(
	'<textarea cols="180" rows="8">'+(_r1.err||_r1.txt)+'</textarea>'
	+'<hr/><br>--rsw heads--<br>'+_r1.errhead
	//+'<hr/><br>--rsw heads--<br>'+(('/1.asp').lastIndexOf('.asp')+4)+' _ '+('/1.asp').length
);

// codecoke.fn.newFunIn(GC,'ado','C_server_ado');var _r =GC.ado.connAccExe('select top 10 * from [lks_pdorder_1] order by [pd_creatTime] desc','rowsarr','/db/lks_0.accdb');Response.Write('<br/>----订单测试记录-----<br/>'+(_r.err || _r.rows.join('<br/>')));







%>