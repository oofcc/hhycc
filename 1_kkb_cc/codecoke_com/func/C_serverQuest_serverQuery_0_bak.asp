<%
codecoke.get.declareClassByArr([
{
	'_basic_':{
		'name':'_serverQuest'
		,'fn':function(_o) {
			if (!this._sett) {this._sett={};}
			if (codecoke.is.Obj(_o)) {this._sett.questO= _o.questO;}
		}
	}
	,'_questload':function() {
		this._questData={};
		if (this._sett.questO) {
			var _rqsv;
			for (var _a in this._sett.questO) {if( this._sett.questO.hasOwnProperty(_a)){
				if ('web_time'==_a) {
					this._questData['web_time']=(new Date()).getTime();
					continue;
				}
				if ('agent_ip'==_a) {
					var _ipreg =/((([0-9]{1,3})\.[0-9]{1,3})\.[0-9]{1,3})\.[0-9]{1,3}/;
					_rqsv=(
							(''+Request.ServerVariables.Item('REMOTE_ADDR')).match(_ipreg)
							||
							(''+Request.ServerVariables.Item('HTTP_X_FORWARDED_FOR')).match(_ipreg)
							||
							(''+Request.ServerVariables.Item('HTTP_VIA')).match(_ipreg)
						)
					;
					if(_rqsv && _rqsv.length && _rqsv.length==4) {
						this._questData['agent_ip']=_rqsv[0];
						this._questData['agent_ipC']=_rqsv[1];
						this._questData['agent_ipB']=_rqsv[2];
						this._questData['agent_ipA']=_rqsv[3];
					}
					continue;
				}
				_rqsv = codecoke.get.str(Request.ServerVariables.Item(''+this._sett.questO[_a]));
				if(!codecoke.is.Nt(_rqsv)) {
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
					this._questData[_a] = _rqsv;
				}
			}}
			if (this._questData['web_file']) {
				this._questData['web_path']
					=this._questData['web_file'].replace(/(?!\/)[^\/]*$/,'').toLowerCase();
				this._questData['web_file'] = this._questData['web_file'].match(/(?!\/)[^\/]*$/)[0];
			}
			if (this._questData['web_domain']) {
				this._questData['web_rootdomain']=this._questData['web_domain'].match(/(?:(?:[a-z0-9]{1,29}\-[a-z0-9]{1,29}|[a-z0-9]{1,26}\-[a-z0-9]{1,26}\-[a-z0-9]{1,26})|[a-z0-9]{1,32})\.(?:[a-z]{2,3}\.[a-z]{2,3}|[a-z]{2,4})$/)[0];
			}
		}
	}
	,'Q':function(_str) {
		if (!this._questData) {
			this._questload();
		}
		if (!_str) {
			return null;
		}
		if (this._questData[''+_str]) {
			return this._questData[_str];
		}else {
			var _v =codecoke.get.str(Request.ServerVariables.Item(''+_str),'oneblank');
			return codecoke.is.Nt(_v) ? null : _v;
		}
	}
}
,
{
	'_basic_':{
		'name':'_serverQuery'
		,'fn':function() {
			this._sett={};
		}
	}
	,'str':function(_k,_after,_trans) {
		if (codecoke.is.Nt(this._sett.qstrcount)) {
			this._sett.qstrcount= 0+Request.QueryString.Count;
		}
		if (!this._sett.qstrcount) {
			return 'n_0'==_after ? 0 : null;
		}
		var _v= Request.QueryString.Item(_k);
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
	,
	'isUrlComIn':function() {
		if (!codecoke.is.Nt(this._sett.isUrlComIn)) {
			return this._sett.isUrlComIn;
		}
		var _url =GC.quest.Q('agent_comurl');
		if (!_url) {
			this._sett.isUrlComIn=0;
			return 0;
		}else {
			_url=_url.toLowerCase();
		}
		var _allowdomains= G_localsetting.siteinfo._sett.allowdomains || null;
		if (!_allowdomains) {
			this._sett.isUrlComIn=0;
			return 0;
		}else {
			var _isin=0;
			_allowdomains = _allowdomains.toLowerCase().split('_');
			for (var _i=0,_x=_allowdomains.length; _i<_x; _i++) {
				if (_allowdomains[_i].length>1 && _url.indexOf(_allowdomains[_i]+'/')>-1) {
					_isin=1;
					break;
				}

			}
			this._sett.isUrlComIn=_isin;
			return _isin;
		}
	}
}
]);

codecoke.get.newFunIn(GC,[['quest','_serverQuest',{'questO':G_localsetting.questSettO}],['query','_serverQuery']]);

%>