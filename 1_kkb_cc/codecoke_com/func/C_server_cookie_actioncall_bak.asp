<%
codecoke.fn.declareClass({
	'_basic_':{
		'name':'C_server_icookie_actioncall'
		,'fn':function(_top) {
			this.attr={};
			//cooikeName_pk xxx_
			this.attr.name = (GC.quest.Q('web_rootdomain') || 'coc').substr(0,3)+'_'+_top.attr.name;
			this.attr.path = _top.attr.path || '/';
			//this.keyArr = _top.keyArr ||{};
			this.attr.addtimetype = _top.attr.addtimetype || 'n';
			this.attr.addtimelength = _top.attr.addtimelength || 60;
			this.ini(_top,this);

		}
	}
	,'ini':function(_tp,_this) {
		_tp.get =function() {return _this.child_get.apply(_tp,arguments);};
		_tp.set=function(_n,_v,_p,_l,_t) {return _this.child_set.apply(_tp,arguments);};
		_tp.readstr=function() {return _this.child_readstr.apply(_tp,arguments);};
		_tp.move=function() {return _this.child_move.apply(_tp,arguments);};
		_tp.clear=function() {_tp._cookiesValuesString='';_tp.d={};_this.write(_tp._cookiesValuesString,_tp.attr.path,-2);};

	}
	,'replaceCookieNameSpecialWords':function(_n) {
		return  _n.indexOf('-')>-1 ? _n.replace(/\-/g,'\\-')
			:(
				_n.indexOf('$')>-1 ? _n.replace(/\$/g,'\\$')
				:(
					_n.indexOf('^')>-1 ? _n.replace(/\^/g,'\\^')
					: (
						_n.indexOf('\\')>-1 ?_n.replace(/\\/g,'\\\\')
						: (
							_n.indexOf('&')>-1 ? _n.replace(/&/g,'＆'): _n
						)
					)
				)
			)
		;
	}
	,'getCookieTimeForWrite':function(_l,_t) {
		return codecoke.get.timeadd( (new Date()), ( _t || this.attr.addtimetype) ,_l).getVarDate();
	}
	,'read':function() {
		return Request.Cookies.Item(this.attr.name).Item();
	}
	,'write':function(_v,_p,_l,_t) {
		_v = _v && typeof (_v)=='string'  ? _v.replace(/\s+/g,' ').replace(/^&|;+|&$/g,'').replace(/^\s+|\s+$/g,'').replace(/&{2,}/g,'&'): '' ;
		Response.Cookies(this.attr.name)=_v;
		Response.Cookies(this.attr.name).path = _p || this.attr.path;
		Response.Cookies(this.attr.name).Expires=this.getCookieTimeForWrite( (_l || this.attr.addtimelength) , _t );
	}
	,'child_get':function(_n) {
		if (!_n || !this.readstr()) {return '';}
		var _n1 = this.nameAttr[_n] || this.icookie.replaceCookieNameSpecialWords(_n);
		if (!undefined===this.d['_'+_n1]) {return this.d['_'+_n1]}
		if ( (new RegExp('(?:^|&)'+_n1+'\=([^&]*?)(?:&|$)') ).test(this._cookiesValuesString)) {
			this.d['_'+_n1]= RegExp.$1 || '';
			this.d['_'+_n1] =this.d['_'+_n1] ?(this.keyAttr[_n]?(this.keyAttr[_n] ==1? GC.iEscape.uni(this.d['_'+_n1]):GC.iEscape.un(this.d['_'+_n1],this.attr.iEscapeCookiekey))
					: this.d['_'+_n1]=this.d['_'+_n1].replace(/＆/g,'&')): '';
		}else {
			this.d['_'+_n1]='';
		}
		return this.d['_'+_n1];
	}
	,'chile_setSingle':function(_n,_v,_notSetIndata) {
		if (codecoke.is.Nt(_v)) {return;}
		_n = _n.replace(/\s+/g,'');
		var _n1 = this.nameAttr[_n] || this.icookie.replaceCookieNameSpecialWords(_n);
		_v = (''+_v).replace(/\s+/g,' ').replace(/^\s+|\s+$|;+/g,'');
		if ( codecoke.is.Nt(_v) || this.d['_'+_n1]==_v ) {return ;}
		_v = this.keyAttr[_n]?(this.keyAttr[_n] ==1? GC.iEscape.dei(_v): GC.iEscape.de(_v,this.attr.iEscapeCookiekey)):_v.replace(/&+/g,'＆');
		var _newV = '='+_v;
		if (!this.readstr()){
			this._cookiesValuesString = _n1+_newV;
		}else {
			if (
				(new RegExp('(?:^|&)('+_n1+'\=[^&]*?)(?:&|$)')).test(this._cookiesValuesString)
				&& RegExp.$1
				&& RegExp.$1.length
			) {
				this._cookiesValuesString= this._cookiesValuesString.replace(''+ RegExp.$1,''+_n1+_newV)

			}else{
				this._cookiesValuesString +='&'+_n1+_newV;
			}

		}
		if (!_notSetIndata) {this.d['_'+_n1]=_v;}

	}
	,'child_set':function(_n,_v,_p,_l,_t) {
		if (codecoke.is.Arr(_n) && _n.length && _n[0] && codecoke.is.Arr(_n[0]) ) {
			for (var _i=0,_x=_n.length; _i<_x; _i++) {
				this.icookie.chile_setSingle.apply(this,[_n[_i][0],_n[_i][1]]);
			}
			this.icookie.write(this._cookiesValuesString,_v,_p,_l);

		}else {
			this.icookie.chile_setSingle.apply(this,[_n,_v]);
			this.icookie.write(this._cookiesValuesString,_p,_l,_t);
		}


	}
	,'child_readstr':function() {
		if (undefined===this._cookiesValuesString) {
			this._cookiesValuesString =this.icookie.read();
		}
		return this._cookiesValuesString;
	}
	,'chile_moveSingle':function(_n) {
		_n = this.nameAttr[_n] || this.icookie.replaceCookieNameSpecialWords(_n);
		if (!_n || ''==this.get(_n)) {return ;}
		if (
			(new RegExp('(?:^|&)('+_n+'\=[^&]*?)(?:&|$)')).test(this._cookiesValuesString)
			&& RegExp.$1
			&& RegExp.$1.length
		) {
			//_replacestr =''+RegExp.$1;
			this._cookiesValuesString = this._cookiesValuesString.replace(''+RegExp.$1,'')

		}
		this._cookiesValuesString = this._cookiesValuesString.indexOf('=')<1 ? '' : this._cookiesValuesString.replace(/&{2,}/g,'&');
		(undefined !== this.d['_'+_n] ) && (delete this.d['_'+_n]);
	}
	,'child_move':function(_n) {
		if (!_n) {return ;}
		if (codecoke.is.Arr(_n) && _n.length){
			for (var _i=0,_x=_n.length; _i<_x; _i++) {this.icookie.chile_moveSingle.apply(this,[_n[_i]]);}
		}else {
			this.icookie.chile_moveSingle.apply(this,[_n]);
		}
		if (this._cookiesValuesString.length<3) {
			this.clear();
		}else {
			this.icookie.write(this._cookiesValuesString);
		}
	}


});
%>