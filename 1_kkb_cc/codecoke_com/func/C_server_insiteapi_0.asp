<%
codecoke.fn.declareClass({
	'_basic_':{
		'name':'C_server_insiteapi'
		,'fn':function() {
			this.r404 = codecoke.fn.r404;
			this.r302 = codecoke.fn.r302;
			this.attr={
				'qstr':{
					'v':GC.query.str('v','n_0')
					,'type':GC.query.str('gt','noblank','lower')
					,'file':GC.query.str('f','noblank')
				}
			};
		}
	}
	,'write':function(_str) {
		if (!_str) {return;}
		_str = codecoke.is.Obj(_str) ? GC.JSON.stringify(_str) :''+_str;
		Response.Write(_str);
		Response.End();
	}
	,'go':function(_f) {
		if (!GC.quest.Q('agent_domain')) {return this.r404();}
		if (_f ) {
			if (codecoke.is.Func(_f)) {
				return _f.apply(this,Array.prototype.slice.call(arguments,1));
			}
			if (codecoke.is.Str(_f) && this['_gt_'+_f] ) {
				return this['_gt_'+_f].apply(this,Array.prototype.slice.call(arguments,1));
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
	,'_getAttr_qstrfileO_by_qstr_file':function(_k) {
		if (!this.attr.qstr.file) {return this.r404();}
		if ( this.attr['qstrfileO']) {return  this.attr['qstrfileO']};
		var _q_i =this.attr.qstr.file.indexOf('^')
			//,_q_at =this.attr.qstr.file.indexOf('@'+_k)
			,_q_at =this.attr.qstr.file.indexOf('@')
			,_q_line=this.attr.qstr.file.lastIndexOf('.')
		;
		if ( _q_i<0 || _q_at<7) {return this.r404();} //script^$sev@local //json^1@
		 this.attr['qstrfileO']={
			'readtype':this.attr.qstr.file.substring(0,_q_i)
			,'itop':this.attr.qstr.file.substring(_q_i+1,_q_at) //$sev
			,'parent':_q_line > _q_at ? this.attr.qstr.file.substring(_q_at+1,_q_line):this.attr.qstr.file.substring(_q_at+1) //locasetting
			,'child': (_q_line > _q_at ? this.attr.qstr.file.substring(_q_line+1) :'') //_head
		};
		return   this.attr['qstrfileO'];

	}

});
%>