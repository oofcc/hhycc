<!--#include virtual='/codecoke_com/func/G_codecoke_0.asp' -->
<!--#include virtual='/codecoke_com/func/G_codecoke_fn_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_fns_0.asp' -->
<%
 var G_localsetting={};

codecoke.fn.newFunIn(GC,[['JSON','C_server_JSON']
	,['quest','C_server_request']
	,['query','C_server_querystring']
	,['iEscape','C_server_iEscape',codecoke.runnerSetting.f62,codecoke.runnerSetting.iEscapePublicKey]
]);
codecoke.fn.newFunIn(GC,'serverobj','C_server_serverobject');
//codecoke.fn.newFunIn(GC,'file','C_server_file');



G_localsetting.inSiteApi={};

G_localsetting.inSiteApiSetting={
	'files':{
		'attr':{
			'headarr':['text/css',[['Pragma','public']],'.css']
			,'isallowpath':1
		}
		,'data_ico':{
			'filename':'ico'
			,'path':'/codecoke_com/agent/i/'
		}
		,'data_css':{
			'filename':'css'
			,'path':'/codecoke_com/agent/c/'
			//,'headarr':['text/css',[['Pragma','public']],'.css']
		}
		,'data_js':{
			'filename':'js'
			,'path':'/codecoke_com/agent/j/'
			//'headarr':['application/x-javascript',[['Pragma','public']],'.js']
		}
	}
	,'_js':{
		'go2file':{
			'script^doc@hex_md5':'/codecoke_com/agent/j/doc_hex_0.js'
		}
		,'key2file':[
			[
				'script^doc@hex'
				,'/codecoke_com/agent/j/doc_hex_0.js'
			]
			,[
				['script^doc@demo','script^doc@demo_d2']
				,'/codecoke_com/agent/j/doc_hex_0.js'
			]
			,[
				['script^$sev@localsetting','json^$sev@localsetting']
				,'/gt_LocalSettingInfo.asp'
			]

		]
	}
	,'_service':{

	}

};


codecoke.fn.declareClass({
	'_basic_':{
		'name':'C_server_insiteapi'
		,'fn':function() {
			this._sett={	};
			this.r404 = codecoke.fn.r404;
			this.r302 = codecoke.fn.r302;
			this.qstr={
				'v':GC.query.str('v','n_0')
				,'type':GC.query.str('gt','noblank','lower')
				,'file':GC.query.str('f','noblank')
			};
			//this.t1='t1'
		}
	}
	,'go':function(_f) {
		if (!GC.quest.Q('agent_domain')) {return this.r404();}
		if (_f ) {
			if (codecoke.is.Func(_f)) {
				return _f.apply(this,Array.prototype.slice.call(arguments,1));
			}
			if (codecoke.is.Str(_f) && this['_gt_'+_f] ) {
				return this['_gt_'+_f].apply(this,Array.prototype.slice.call(arguments,1));
				//return this['_gt_'+_f]();
			}
		}
		return this.r404();
	}
	,'_getRedirUrlByfileKeywords':function(_kArr,_k) {
		if (!_k) {return ''};
		var _x=_kArr.length, _url='',_a,_b;
		for (var _i=0; _i<_x; _i++) {
			if (!_kArr[_i][0] || !_kArr[_i][1]) {continue;}
			if (codecoke.is.Arr(_kArr[_i][0])) {
				for (var _a=0,_b=_kArr[_i][0].length; _a<_b; _a++) {
					if ( _k.indexOf(_kArr[_i][0][_a])==0) {_url =  _kArr[_i][1];break;}
				}
			}else if (_k.indexOf(''+_kArr[_i][0])==0) {
				_url =  _kArr[_i][1];
			}
			if (_url) {break;}
		}
		return _url;
	}

});
codecoke.fn.newFunIn(GC,'insiteapi','C_server_insiteapi');

GC.insiteapi._gt_Redirect=function(_settO) {
	if (!GC.quest.Q('agent_domain') || !this.qstr.type || !this.qstr.file) {return this.r404();}
	var _url ='';
	if(_settO.files['data_'+this.qstr.type]) {
			_url =(this.qstr.file.indexOf('/')==0 ? this.qstr.file : _settO.files['data_'+this.qstr.type].path)
			+(
				this.qstr.file.indexOf('.',1)>0? (this.qstr.file.indexOf('/')==0 ? '' : this.qstr.file)
				: this.qstr.file+'_'+this.qstr.v+'.'+_settO.files['data_'+this.qstr.type].filename
			)
			;
			return this.r302(_url);
	}
	if (this.qstr.type.indexOf('_')==0 && _settO[this.qstr.type]) {
			_url = _settO[this.qstr.type] && _settO[this.qstr.type]['go2file'] && _settO[this.qstr.type]['go2file'][this.qstr.file]
				? _settO[this.qstr.type]['go2file'][this.qstr.file]
				: this._getRedirUrlByfileKeywords(_settO[this.qstr.type]['key2file'],this.qstr.file)
			;
			if (_url) {
				if (_url.length > 4 && (_url.lastIndexOf('.asp')+4)==_url.length) {
					Server.Transfer(_url);return ;
				}else {
					return this.r302(_url);
				}
			}
	}


	//Response.Write(this.qstr.type +' '+this.qstr.file);

	//Response.Write(this.qstr.type)

	return this.r404();
	//Response.Write(_settO.t11)
}



GC.insiteapi.go('Redirect',G_localsetting.inSiteApiSetting);



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