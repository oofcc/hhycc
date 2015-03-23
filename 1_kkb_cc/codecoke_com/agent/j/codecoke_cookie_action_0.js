/*codecoke_query_0 w@codecoke.com 2011/5/9*/

codecoke.fn.declareClassByArr([
,
{
	'_basic_':{
		'name':'_NS_doc_icookie_action'
		,'fn':function(_top) {
				_top && this._ini_(_top,undefined);
		}
	}
	,'_ini_':function(_tp) {
		var _this =this;
		_tp.read=function() {return _this.child_read.apply(_tp,Array.prototype.slice.call(arguments));}
		_tp.get=function() {return _this.child_get.apply(_tp,Array.prototype.slice.call(arguments));}
		//_tp.move=function() {return _this.child_move.apply(_tp,arguments);};
		//_tp.clear=function() {_tp._cookiesValuesString='';_tp.d={};_this.write(_tp._cookiesValuesString,_tp.attr.path,-2);};

	}
	,'child_get':function(_n) {
			if (undefined ==this.d.cookiestr || this.doc.attr.cookie_hadchange) {
				this.read();
			}
			if (''===this.d.cookiestr) {return '';}
			var _n1,_k,_v=''
			if (this.attr.nameAttr[_n]) {
				_n1 = this.attr.nameAttr[_n][0];
				_k =this.attr.nameAttr[_n][1];
			}else {
				_n1 = _n;
			}
			if (
				this.d.cookiestr.indexOf(_n1+'=') != -1
				&& (new RegExp('(?:^|&)'+_n1+'\=([^&]*?)(?:&|$)')).test(this.d.cookiestr)
				&& RegExp.$1
				&& RegExp.$1.length
			) {
				_v = ''+RegExp.$1;
				_v = _v ?(_k ?	(_k ==1 ?  codecoke.get.iEscape.uni(_v): codecoke.get.iEscape.un(_v,this.attr.iEscapeCookiekey)):_v.replace(/＆/g,'&')):''	;

			}
			return _v;
	}
	,'child_read':function() {
		if (
			( new RegExp('(?:^|[ ]+)'+this.attr.name+'\=([^;]*?)(?:;|$)','g')).test(codecoke.get.decodeUri(''+document.cookie))
			&& RegExp.$1
			&& RegExp.$1.length
		) {
			this.d.cookiestr = ''+RegExp.$1;
			this.hascookie=true;
		}else {
			this.d.cookiestr='';
		}
		this.doc.attr.cookie_hadchange && (delete this.doc.attr.cookie_hadchange);
		return this.d.cookiestr;
	}
	,'child_write':function() {
		if (undefined ==this.d.cookiestr) {this.read();}
		if (''===this.d.cookiestr) {return '';}
		var _str =(codecoke.get.encodeUri(this.cookieName)+'='+codecoke.get.encodeUri(this.d.cookiestr)).replace(/\_/g,'%5F');
		var _d = codecoke.get.timeadd((new Date()),this.attr.addtimelength,this.attr.addtimetype);
		var _e = codecoke.get.timeformat(_d,'yyyy-mm-dd hh:nn:s S')
		$('#myt5').append(_str+'<br/>'+_d.toGMTString()+'<br/>'+_e);
		document.cookie = ''+_str+'; path=/; domain=codecoke.com; expire='+_d.toGMTString()+'';
	}
}

]);


/*===global var ===*/
/**/
codecoke.fn.newFunIn(codecoke.get,'iEscape','_NS_get_iEscape',codecoke.attr.runnerSetting.f62,codecoke.attr.runnerSetting.iEscapePublicKey);

!window['$sev'] && (window['$sev']={});
!window['$app'] && (window['$app']={});
