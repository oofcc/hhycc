<%
/*=====member=========
 _server_JSON
,_server_request
,_server_querystring
,_server_iEscape
,_server_serverobject
=============*/

codecoke.fn.declareClassByArr([
{
	'_basic_':{
		'name':'C_server_JSON'
		,'fn':function() {
			this.attr={
			'escapable':/[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g
			,'meta':{'\b': '\\b','\t': '\\t','\n': '\\n','\f': '\\f','\r': '\\r','"' : '\\"','\\': '\\\\'}
			,'cx':/[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g

			};
			this._ini_();
		}
	}
	,'_ini_':function() {
		if(typeof Date.prototype.toJSON!=='function'){
			var _this =this;
			Date.prototype.toJSON=function(key){
				return isFinite(this.valueOf())?
					this.getUTCFullYear()+'-'+
					_this.x2_0x(this.getUTCMonth()+1)+'-'+
					_this.x2_0x(this.getUTCDate())+'T'+
					_this.x2_0x(this.getUTCHours())+':'+
					_this.x2_0x(this.getUTCMinutes())+':'+
					_this.x2_0x(this.getUTCSeconds())+'Z'
				:null
				;
			};
			String.prototype.toJSON=Number.prototype.toJSON=Boolean.prototype.toJSON=function(key){
				return this.valueOf();
			}
			;
		}
	}
	,'x2_0x':function(n){return n<10?'0'+n:n;}
	,'strUTC_2_time':function(_str) {
		var a;
		if (typeof _str === 'string') {
			a =/^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2}(?:\.\d*)?)Z$/.exec(_str);
			if (a) {
				return new Date(Date.UTC(+a[1], +a[2] - 1, +a[3], +a[4],+a[5], +a[6]));
			}
		}
		return _str;
	}
	,'str_quote':function (_str){
		var _this=this;
		_this.attr.escapable.lastIndex=0;
		return _this.attr.escapable.test(_str)
		?'"'+_str.replace(_this.attr.escapable,function(a){
			var c=_this.attr.meta[a];
			return typeof c==='string'
			?c
			:'\\u'+('0000'+a.charCodeAt(0).toString(16)).slice(-4);
		})+'"'
		:'"'+_str+'"'
		;
	}
	,'stringify':function(_v,replacer,space){
		var i,gap='',indent='';
		if(typeof space==='number'){
			for(i=0;i<space;i+=1){
				indent+=' ';
			}
		}else if(typeof space==='string'){
			indent=space;
		}
		rep=replacer;
		if(
			replacer
			&&typeof replacer!=='function'
			&&
			(
				typeof replacer!=='object'||
				typeof replacer.length!=='number'
			)
		){
				throw new Error('JSON.stringify');
		}
		return this._getStringIn('',{'':_v},gap,indent,rep);
	}
	,'_getStringIn':function(key,holder,gap,indent,rep){
		var i,k,v,length,partial
			,mind=gap
			,_vO=holder[key]
		;
		if(_vO&&typeof _vO==='object'&&typeof _vO.toJSON==='function'){
			_vO=_vO.toJSON(key);
		}
		if(typeof rep==='function'){
			_vO=rep.call(holder,key,_vO);
		}
		switch(typeof _vO){
			case'string':			return this.str_quote(_vO);
			case'number':		return isFinite(_vO) ? String(_vO): 'null';
			case'boolean':
			case'null':			return String(_vO);
			case'object':
				if(!_vO){return'null';}
				gap+=indent;
				partial=[];
				if(Object.prototype.toString.apply(_vO)==='[object Array]'){
					length=_vO.length;
					for(i=0;i<length;i+=1){
						partial[i]=this._getStringIn(i,_vO,gap,indent,rep)||'null';
					}
					v=partial.length===0
					?'[]'
					:gap
						? '[\n'+gap+partial.join('\n'+gap+',')+'\n'+mind+']'
						: '['+partial.join(',')+']'
					;
					gap=mind;
					return v;
				}
				if(rep&&typeof rep==='object'){
					length=rep.length;
					for(i=0;i<length;i+=1){
						k=rep[i];
						if(typeof k==='string'){
							v=this._getStringIn(k,_vO,gap,indent,rep);
							if(v){partial.push(this.str_quote(k)+(gap?': ':':')+v);}
						}
					}
				}else{
					for(k in _vO){if(Object.hasOwnProperty.call(_vO,k)){
						v=this._getStringIn(k,_vO,gap,indent,rep);
						if(v){	partial.push(this.str_quote(k)+(gap?': ':':')+v);}
					}}
				}
				v=partial.length===0
				?'{}'
				:gap
					?'{\n'+gap+partial.join('\n'+gap+',')+'\n'+mind+'}'
					:'{'+partial.join(',')+'}'
				;
				gap=mind;
				return v;
		}
	}
	,'_parse_walk':function(holder,key,reviver){
		var k,v,_vO=holder[key];
		if(_vO&&typeof _vO==='object'){
			for(k in _vO){if(Object.hasOwnProperty.call(_vO,k)){
				v=this.walk(_vO,k,reviver);
				if(v!==undefined){
					_vO[k]=v;
				}else{
					delete _vO[k];
				}
			}}
		}
		return reviver.call(holder,key,_vO);
	}
	,'parse':function(_str,reviver){
		var _ro ;
		_str=String(_str);
		this.attr.cx.lastIndex=0;
		if(this.attr.cx.test(_str)){
			_str=_str.replace(this.attr.cx,function(a){
				return'\\u'+
				('0000'+a.charCodeAt(0).toString(16)).slice(-4);
			});
		}
		if(/^[\],:{}\s]*$/
		.test(
			_str.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g,'@')
			.replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g,']')
			.replace(/(?:^|:|,)(?:\s*\[)+/g,''))
		){
			_ro=eval('('+_str+')');

			return typeof reviver==='function'
			?
				//walk({'':j},'')
				this._parse_walk({'':_ro},'',reviver)

			:_ro
			;
		}
	}

}
,
{
	'_basic_':{
		'name':'C_server_request'
		,'fn':function(_o) {
			if (!this.attr) {
				this.attr={'questO':(_o && _o.questO? _o.questO:{})};
				this._getAttrQuestObj();
				!this.attr.questData && this._questload();
			}
		}
	}
	,'_getAttrQuestObj':function() {
		var _defaultQuestO ={
			'agent_comurl' :'HTTP_REFERER'
			,'agent_ip' :'REMOTE_ADDR'
			,'agent_client' :'HTTP_USER_AGENT'
			,'agent_method' :'Request_Method'
			,'agent_ajaxhead':'HTTP_codecoke-client'
			,'agent_language' :'Http_Accept_Language'
			,'web_pathinfo' :'Path_Info'
			,'web_time' :'web_time_int'
			,'web_file' :'SCRIPT_NAME'
			,'web_dir' :'APPL_PHYSICAL_PATH'
			,'web_domain' :'SERVER_NAME'
			,'web_ip' :'LOCAL_ADDR'
			,'web_iisid' :'Instance_ID'
		};
		for (var _a in _defaultQuestO) {if( _defaultQuestO.hasOwnProperty(_a)){
			!this.attr.questO[_a] && (this.attr.questO[_a]=_defaultQuestO[_a]);
		}}
	}
	,'_questload':function() {
		this.attr.questData={};
		if (this.attr.questO) {
			var _rqsv;
			for (var _a in this.attr.questO) {if( this.attr.questO.hasOwnProperty(_a)){
				if ('web_time'==_a) {
					this.attr.questData['web_time']= new Date();
					this.attr.questData['web_timeInt']=this.attr.questData['web_time'].getTime();
					continue;
				}
				if ('agent_ip'==_a) {
					var _ipR =Request.ServerVariables.Item('REMOTE_ADDR').Item();
					var _proxyIP = (Request.ServerVariables.Item('HTTP_X_FORWARDED_FOR').Item() ||Request.ServerVariables.Item('HTTP_VIA').Item())

					var _ip = _ipR || _proxyIP;
					if (_ip) {
						var _ipreg =/((([0-9]{1,3})\.[0-9]{1,3})\.[0-9]{1,3})\.[0-9]{1,3}/;
						_rqsv= (''+_ip).match(_ipreg);
						if(_rqsv && _rqsv.length && _rqsv.length==4) {
							this.attr.questData['agent_ip']=_rqsv[0];
							this.attr.questData['agent_ipC']=_rqsv[1];
							this.attr.questData['agent_ipB']=_rqsv[2];
							this.attr.questData['agent_ipA']=_rqsv[3];
						}
						if (_proxyIP && _proxyIP !=_ipR  ) {
							var _pip = (''+_proxyIP).match(_ipreg)
							this.attr.questData['agent_pip']=_pip[0];
							this.attr.questData['agent_pipC']=_pip[1];
							this.attr.questData['agent_pipB']=_pip[2];
							this.attr.questData['agent_pipA']=_pip[3];
						}
						continue;
					}
					continue;
				}
				_rqsv = Request.ServerVariables.Item(''+this.attr.questO[_a]).Item();
				if(undefined != _rqsv ) {
					switch (true) {
						case('agent_client'==_a) :
							_rqsv =_rqsv.replace(/\s{2,}/g,' ');
							break;
						case('agent_language'==_a) :
							_rqsv=_rqsv.replace(/\s+/g,'').toLowerCase();
							break;
						case('web_file'==_a) :
							_rqsv=_rqsv.replace(/\s+/g,'').toLowerCase();
							break;
						case('web_domain'==_a) :
							_rqsv=_rqsv.replace(/\s+/g,'').toLowerCase();
							break;
						default:
							_rqsv=_rqsv.replace(/\s+/g,'')
						;

					}
					_rqsv && ('' != _rqsv) && (this.attr.questData[_a] = _rqsv);
				}
			}}
			if (this.attr.questData['web_file']) {
				this.attr.questData['web_path']=this.attr.questData['web_file'].replace(/(?!\/)[^\/]*$/,'').toLowerCase();
				this.attr.questData['web_file'] = this.attr.questData['web_file'].match(/(?!\/)[^\/]*$/)[0];
			}
			if (this.attr.questData['web_domain']) {
				//this.attr.questData['web_rootdomain']=this.attr.questData['web_domain'].match(/(?:(?:[a-z0-9]{1,29}\-[a-z0-9]{1,29}|[a-z0-9]{1,26}\-[a-z0-9]{1,26}\-[a-z0-9]{1,26})|[a-z0-9]{1,32})\.(?:[a-z]{2,3}\.[a-z]{2,3}|[a-z]{2,4})$/)[0];
				this.attr.questData['web_rootdomain']=this.attr.questData['web_domain'].match(/(?:[a-z]{1,29}\-[a-z]{1,29}|[a-z0-9]{3,32}|[a-z]{2,3})\.[a-z]{2,4}$/)[0];
				this.attr.questData['web_pathurl']='http://'+this.attr.questData['web_domain']+this.attr.questData['web_pathinfo'];
			}
			if (this.attr.questData['agent_comurl'] && this.attr.questData['agent_comurl'].indexOf('http://')==0) {
				var _qxi = this.attr.questData['agent_comurl'].indexOf('/',7);
				this.attr.questData['agent_domain'] =
				_qxi>0? this.attr.questData['agent_comurl'].substring(7,_qxi): this.attr.questData['agent_comurl'].substring(7)
				;
			}

		}
	}
	,'Q':function(_str) {
		if (!this.attr.questData) {
			this._questload();
		}
		if (!_str) {return '';}
		_str+='';
		if (this.attr.questData[_str]) {return this.attr.questData[_str];}
		var _v = Request.ServerVariables.Item(_str).Item();
		if (undefined !=_v) {return (''+_v).replace(/^[\s\t ]+|[\s\t ]+$/g,'').replace(/\s{2,}/g,' ');}
		return '';
	}
}
,
{
	'_basic_':{
		'name':'C_server_querystring'
		,'fn':function() {
			this.attr={};
		}
	}
	,'str':function(_k,_after,_trans) {
		if (undefined == this.attr.qstrcount) {
			this.attr.qstrcount= Request.QueryString.Count*1;
		}
		if (!this.attr.qstrcount) {
			return 'n_0'==_after ? 0 : null;
		}
		var _v= Request.QueryString.Item(_k).Item();
		if (codecoke.is.Nt(_v)) {
			return 'n_0'==_after ? 0 : null;
		}
		_v = codecoke.get.decodeUri(''+_v);

		if(_v.indexOf('.')>-1) {
			_v=_v.replace(/\.+/g,'.');
		}
		if(_v.indexOf(',')>-1) {
			_v=_v.replace(/,\s*|\s*,/g,',')
				.replace(/,{2,}/g,',')
				.replace(/^[,\s]*|[\,\s]*$/g,'');
		}
		if (codecoke.is.Nt(_v)) {
			return 'n_0'==_after ? 0 : null;
		}
		return codecoke.get.str(_v,_after,_trans);
	}
}
,{
	'_basic_':{
		'name':'C_server_iEscape'
		,'fn':function(_f62,_k){
			this.attr={'s':_f62,'k':_k,'ka':_f62.split('')};
			!this.attr.k &&(this.attr.k=this.gk());
		}
	}
	,'_Di':function(_n,_arr,K){_arr[_arr.length]=(K||this.attr.k).charAt(_n);}
	,'_Ui':function(_y,s,K){return(K||this.attr.k).indexOf(s.charAt(_y));}
	,'gk':function(){return this.attr.ka.sort(function(){return(Math.random()<0.5)?1:-1;}).join('');}
	,'de':function(_str,K){var nl=_str.length,_arr=[],a,b,c,x,N2=62*62,N5=62*5;for(x=0;x<nl;x++){a=_str.charCodeAt(x);a<N5?(this._Di(Math.floor(a/62),_arr,K),this._Di(a%62,_arr,K)):(this._Di(Math.floor(a/N2)+5,_arr,K),this._Di(Math.floor(a/62)%62,_arr,K),this._Di(a%62,_arr,K));}b=_arr.join('');c=b.length;return(String(c).length+String(c)+b);}
	,'dei':function(_str,_k){var K=_k||this.gk();return this.de(_str,K)+K;}
	,'un':function(_str,K){var c=_str.charAt(0)*1;if(isNaN(c)){return'';}c=_str.substr(1,c)*1;if(isNaN(c)){return'';}var nl=_str.length,_arr=[],a,f,b,x=String(c).length+1;if(nl!=x+c){return''}while(x<nl){a=this._Ui(x++,_str,K);f=(a<5)?(a*62+this._Ui(x,_str,K)):((a-5)*62*62+this._Ui(x,_str,K)*62+this._Ui(x+=1,_str,K));_arr[_arr.length]=String.fromCharCode(f);x++;}return _arr.join('');}
	,'uni':function(_str){if(!_str){return'';}var _l=_str.length-62;if(_l<1){return this.un(_str);}return this.un(_str.substring(0,_l),_str.substring(_l));}

}
]);

codecoke.fn.declareClass({
	'_basic_':{
		'name':'C_server_serverobject'
		,'fn':function() {this.attr={};}
	}
	,'creat':function(_n,_p) {
		if (!_n) {return ;}

		//if (_n && _p) {return this.creat_parent(_n,_p);}

		if (this.attr[_n]) {return this.attr[_n];}
		if (this['creat_'+_n]) {return this['creat_'+_n]();	}

		switch (_n) {
			case('conn') :
				!this.attr.conn && (this.attr.conn= Server.CreateObject('ADODB.Connection'));
			break;
			case('rcd') :
				!this.attr.rcd && (this.attr.conn= Server.CreateObject('Adodb.Recordset'));
			break;
			case 'fso':
				!this.attr.fso &&(this.attr.fso = Server.CreateObject('Scripting.FileSystemObject'));
			break;
			case 'adostr':
				!this.attr.adostr &&(this.attr.adostr = Server.CreateObject('ADODB.Stream'));
			break;

		}
		return this.attr[_n];
	}
	,'creat_cmd':function() {
		if (this.attr.cmd) {return this.attr.cmd;}
		//this.attr.cmd1='hadcreat'
		this.attr.cmd = Server.CreateObject('ADODB.Command');
		//this.attr.cmd.CommandType=4;
		this.attr.cmd.NamedParameters = true; //显式要求参数名
		this.attr.cmd.Prepared=true; //要求将SQL命令先行编译
		this.attr.cmd.Parameters.Append(this.attr.cmd.CreateParameter("@rNum",2,4));
		return this.attr.cmd;

	}
	,'creat_xhr':function() {
		if (this.attr.xhr) {return this.attr.xhr;}
		if (this.attr.xhrVasion) {	return Server.CreateObject(''+this.attr.xhrVasion);}
		try {
			this.attr.xhr= Server.CreateObject('WinHttp.WinHttpRequest.5.1');this.attr.xhrVasion='WinHttp.WinHttpRequest.5.1';
			//this.attr.xhrVasion='Msxml2.ServerXMLHTTP.6.0';
		}catch (e) {
			this.attr.xhr= Server.CreateObject('Msxml2.ServerXMLHTTP.3.0');this.attr.xhrVasion='Msxml2.ServerXMLHTTP.3.0';
			//	this.attr.xhr= Server.CreateObject('Microsoft.XMLHTTP');this.attr.xhrVasion='Microsoft.XMLHTTP';
		}
		//Response.Write(this.attr.xhrVasion)
		return this.attr.xhr;
	}
	,'close':function (_o,_p) {
		switch (_o) {
			case('adostr') :
				this.attr.adostr && this.attr.adostr.State && this.attr.adostr.State>0 && this.attr.adostr.Close();
				 this.attr.adostr =null;
			break;
			case('fso') :
				  this.attr.fso && (this.attr.fso=null);
			break;
			case('conn') :
				this.attr.conn && this.attr.conn.State && this.attr.conn.State>0 && this.attr.conn.Close();
				this.attr.conn =null;
			break;
			case('xhr'):
				this.attr.xhr && (delete this.attr.xhr);
			break;
			case ('cmd'):
				this.attr.cmd && this.attr.cmd.State && this.attr.cmd.State> 0 && this.attr.cmd.Close();
				this.attr.cmd=null;
			break;
			case ('cmd_rcd'):
				_p && _p.State && _p.State>0 && (_p.Close()|| (_p=null));
			break;

			case ('cmd_all'):
				this.attr.cmd && this.attr.cmd.State && this.attr.cmd.State> 0 && this.attr.cmd.Close();
				_p && _p.State && _p.State>0 &&(	_p.Close() || (_p=null));
				//this.attr.cmd_rcd && this.attr.cmd_rcd.State && this.attr.cmd_rcd.State> 0 && (
				//	this.attr.cmd_rcd.Close() || ( this.attr.cmd_rcd=null)
				//);
				//this.attr.cmd_rcd && this.attr.cmd_rcd=null;

				this.attr.cmd=null;
			break;


		}
	}

})
;





%>