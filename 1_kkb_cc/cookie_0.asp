<!--#include virtual='/codecoke_com/func/G_codecoke_0.asp' -->
<!--#include virtual='/codecoke_com/func/G_codecoke_fn_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_fns_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_cookie_action_0.asp' -->
<%
 var G_localsetting={};

codecoke.fn.newFunIn(GC,[['JSON','C_server_JSON']
	,['quest','C_server_request']
	,['query','C_server_querystring']
	,['iEscape','C_server_iEscape',codecoke.runnerSetting.f62,codecoke.runnerSetting.iEscapePublicKey]
]);
codecoke.fn.newFunIn(GC,'serverobj','C_server_serverobject');
//codecoke.fn.newFunIn(GC,'file','C_server_file');


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

var _t1=codecoke.fn.newFnCookie([
		_cookiesetting.lukasu_sS.attr
	]);

//_t1.readstr();

_t1.set([
		['userkeystr',codecoke.get.guiden()+'.'+codecoke.get.guiden()]
		,['usernames','w@codecoke.com|||莫 &!& 非 2']
		,['usersort','levels:999.9.1|||other:o_ther']
	]);

Response.Write('<br/>userkeystr: '+_t1.get('userkeystr')+'<br/>'+_t1._cookiesValuesString+'<br/>')
Response.Write('<br/>userkeystr: '+_t1.get('usernames')+'<br/>')
Response.Write('<br/>iEscapeCookiekey: '+_t1.attr.iEscapeCookiekey+'<br/>')
Response.Write(_t1.icookie.attr.name+'<hr/>')



/*
GC.insiteapi.test1=function() {
		//Response.Contenttype='text/css';
		Response.AddHeader('pragma','public');
		Response.AddHeader('Cache-Control','public');
		//Response.Write('111')
		//Response.Redirect('/1.asp')
		Response.Write(
			'<br>--questData--<br>'+'<pre>'+GC.JSON.stringify(GC.quest.attr.questData,'',' ')+'</pre>'
			+'<br>--questO--<br>'+'<pre>'+GC.JSON.stringify(GC.quest.attr.questO,'',' ')+'</pre>'
			+'<br>--SCRIPT_NAME--<br>'+Request.ServerVariables.Item('SCRIPT_NAME').Item()+'</pre>'
		)

}
*/



//GC.insiteapi.go(GC.insiteapi.test1);
//GC.insiteapi.r404();
// codecoke.fn.r404();

			//return false;

/**/


//Response.Write('<pre>'+GC.JSON.stringify(GC.quest.attr.questData,'',' ')+'</pre>')






/*
 //codecoke.fn.newFunIn(GC,'ado','C_server_ado');var _r =GC.ado.connAccExe('select top 10 * from [lks_pdorder_1] order by [pd_creatTime] desc','rowsarr','/db/lks_0.accdb');Response.Write('<br/>----订单测试记录-----<br/>'+(_r.err || _r.rows.join('<br/>')));


var _ds = GC.file.getdriversarr();
Response.Write('<br/>'+_ds +'<br/>_'+GC.file.isfolderhas('/')+'_'
	+'_'+GC.file.isfilehas('/t2.asp')+'_'
	+'_exists_'+GC.file.exists('/codecoke_com/func/c_json_0.asp')+'_'
)


Response.Write('<br/>'+Request.ServerVariables.Item('Path_Info').Item())
Response.Write('<br/>'+Request.ServerVariables.Item('Path_Translated').Item())
Response.Write('<br/>'+new Date('Sat, 30 Apr 2011 07:44:50 GMT'))
Response.Write(GC.quest.Q('web_dir'))
Response.Write('<pre>'+GC.JSON.stringify(GC.quest.attr.questData,'',' ')+'</pre>')


//codecoke.fn.newFunIn(GC,'xhr','_server_xhr');var _r1 = GC.xhr.loadtxtO('http://news.163.com/special/00011K6L/rss_newstop.xml');Response.Write(_r1.err||_r1.txt)

var _t1=codecoke.fn.newFnCookie([{
		'attr':{
			'name':'Ss'
			,'path':'/'
			,'addtimetype':'d'
			,'addtimelength':120
		}
		,'nameAttr':{
			'userkeystr':'K'
			,'username':'Um'
			,'usersort':'uS'
			,'usermail':'mil'
			,'ban':'Ba'
		}
		,'keyAttr':{
			'userkeystr':2
			,'username':2
		}
	}]);

//_t1.set('userkeystr','1hshdf 莫非啊莫非  cncnc!&');

Response.Write('<br/>'+_t1.get('userkeystr')+'<br/>'+_t1._cookiesValuesString+'<br/>')
Response.Write('<br/>iEscapeCookiekey: '+_t1.attr.iEscapeCookiekey+'<br/>')
Response.Write(_t1.icookie.attr.name+'<hr/>')

*/



/*

Response.Write(GC.quest.Q('web_dir'))



Response.Write('<pre>'+GC.JSON.stringify(GC.quest.attr.questData,'',' ')+'</pre>')

Response.Write('<br/>-----'+Request.ServerVariables.Item('HTTP_codecoke-client')+'<br/>'+Request.QueryString.Count+'---<br>')
Response.Write('<br/>-----'+GC.query.str('n1')+'---<br>')


Response.Write('<br/>-----'+(''== Request.Cookies.Item('test').Item()))
Response.Write('<br/>-----'+(undefined== Request.ServerVariables.Item('HTTP_codecoke-client').Item()))
Response.Write('<br/>-----'+(undefined=== Request.QueryString.Item('HTTP_codecoke-client').Item()))
*/




%>