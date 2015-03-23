<!--#include virtual='/codecoke_com/func/G_codecoke_0.asp' -->
<!--#include virtual='/codecoke_com/func/G_codecoke_fn_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_fns_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_insiteapi_0.asp' -->
<%
 //var G_localsetting={};

codecoke.fn.newFunIn(GC,[['JSON','C_server_JSON']
	,['quest','C_server_request']
	,['query','C_server_querystring']
	,['iEscape','C_server_iEscape',codecoke.runnerSetting.f62,codecoke.runnerSetting.iEscapePublicKey]
]);
codecoke.fn.newFunIn(GC,'serverobj','C_server_serverobject');
//codecoke.fn.newFunIn(GC,'file','C_server_file');


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
		}
		,'data_js':{
			'filename':'js'
			,'path':'/codecoke_com/agent/j/'
		}
	}
	,'_js':{
		'go2file':{
			'script^doc@hex_md5':'/codecoke_com/agent/j/doc_hex_0.js'
		}
		,'key2file':[
			[
				['script^doc@hex','script^doc@hex.md5']
				,'/codecoke_com/agent/j/doc_hex_0.js'
			]
			,[
				['script^doc@demo','script^doc@demo_d2']
				,'/codecoke_com/agent/j/doc_hex_0.js'
			]
			,[
				['script^$sev@localsetting','json^$sev@localsetting']
				,['/codecoke_com/insiteapi/gt_localsetting','','$v','.asp']
			]
			,[
				['script^$sev@siteinfo','json^$sev@siteinfo']
				,['/codecoke_com/insiteapi/gt_siteinfo_','$sitename_pk','','','$v','.asp']

			]

		]
	}

	//,'_sevs':{
	//	'siteinfo':function() {
	//
	//	}

	//}

};



codecoke.fn.newFunIn(GC,'insiteapi','C_server_insiteapi');

GC.insiteapi._gt_Redirect=function(_settO) {
	if (!GC.quest.Q('agent_domain') || !this.attr.qstr.type || !this.attr.qstr.file) {return this.r404();}
	var _url ='';
	if(_settO.files['data_'+this.attr.qstr.type]) {
			_url =(this.attr.qstr.file.indexOf('/')==0 ? this.attr.qstr.file : _settO.files['data_'+this.attr.qstr.type].path)
			+(
				this.attr.qstr.file.indexOf('.',1)>0? (this.attr.qstr.file.indexOf('/')==0 ? '' : this.attr.qstr.file)
				: this.attr.qstr.file+'_'+this.attr.qstr.v+'.'+_settO.files['data_'+this.attr.qstr.type].filename
			)
			;
			return this.r302(_url);
	}
	if (this.attr.qstr.type.indexOf('_')==0 && _settO[this.attr.qstr.type]) {
		_url = _settO[this.attr.qstr.type] && _settO[this.attr.qstr.type]['go2file'] && _settO[this.attr.qstr.type]['go2file'][this.attr.qstr.file]
			? _settO[this.attr.qstr.type]['go2file'][this.attr.qstr.file]
			: this._getRedirUrlByfileKeywords(_settO[this.attr.qstr.type]['key2file'],this.attr.qstr.file)
		;
		if (_url) {
			if (codecoke.is.Str(_url)) {
				return this.r302(_url);
				//Response.Write(_url);
				//return ;
			}
			if (codecoke.is.Arr(_url)) {
				var _al = _url.length
					,_pkName =(_url[1] && _url[1].indexOf('$')==0 ? _url[1].substring(1) :'')
					,_pkValue = _pkName ? GC.query.str(_pkName,'noblank') :''
					,_replace_v =(
						_url[_al-2] && _url[_al-2].indexOf('$')==0 &&  (undefined != this.attr.qstr[_url[_al-2].substring(1)])
						? _url[_al-2].substring(1)
						:''
					)
				;
				_pkName && (_url[1]=''+(_pkValue||'me'));
				_replace_v  && (_url[_al-2] ='_'+this.attr.qstr[_replace_v]);

				if (_url[_al-1] && _url[_al-1]=='.asp' ) {
					Server.Transfer(_url.join(''));
					return ;
				}

			}
		}


	}
	return this.r404();
};

GC.insiteapi.go('Redirect',G_localsetting.inSiteApiSetting);

%>