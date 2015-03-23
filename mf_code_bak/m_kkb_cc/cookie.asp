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




var _cookiesetting={
			'lukasu_sS':{
				'attr':{
					'name':'lukasu_Ss'
					,'path':'/'
					,'addtimetype':'d'
					,'addtimelength':120
					,'nameAttr':{
						'userkeystr':['K',2]
						,'usernames':['Um',2]
						,'usersort':['uS',2]
					}
				}
			}
};


//nameAttr : 数组[ cookieChildName,加密方式：==1？GC.iEscape.uni 其他 GC.iEscape.un
// GC.iEscape.uni 尾巴带key，un公用key

var _t1=codecoke.fn.newFnCookie([
		_cookiesetting.lukasu_sS.attr
	]);

//_t1.readstr();
/*
_t1.set([
		['userkeystr',codecoke.get.guiden()+'.'+codecoke.get.guiden()]
		,['usernames','w@codecoke.com|||莫 &!& 非 2']
		,['usersort','levels:999.9.1|||other:o_ther']
	]);
*/

Response.Write('<br/>userkeystr: '+_t1.get('userkeystr')+'<br/>'+_t1._cookiesValuesString+'<br/>')
Response.Write('<br/>usernames: '+_t1.get('usernames')+'<br/>')
Response.Write('<br/>iEscapeCookiekey: '+_t1.attr.iEscapeCookiekey+'<br/>')
Response.Write(_t1.icookie.attr.name+'<hr/>')





%>