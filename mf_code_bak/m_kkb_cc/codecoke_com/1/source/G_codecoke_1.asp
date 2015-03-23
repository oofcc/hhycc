<%
/*codecoke*/
/*yyyy-mm-dd hh:nn:ss.S [object Boolean][object String][object Number][object Date]*/



codecoke.is={
		'Null':function(a){
			return a===null;
		}
		,'Undefined':function(a){
			return  (typeof a === 'undefined');
		}
		,'Nt':function(a){
			return (a==null || a==undefined || a===''|| ((''+a)==='') || ((''+a)=='null') || ((''+a)=='undefined'));
		}
		,'Func':function(a){
			return ((typeof(a)==='function')||(typeof(a)==='object' && Object.prototype.toString.apply(a) === '[object Function]'));
		}
		,'Str':function(a){
			return (typeof(a) === 'string'||(typeof(a)==='object' && Object.prototype.toString.apply(a) === '[object String]'))
		}
		,'Arr':function(a){
			return(a && typeof(a)==='object' && Object.prototype.toString.apply(a) === '[object Array]');
		}
		,'Boolean':function(a){
			return (typeof(a)==='boolean'||(typeof(a)==='object' && Object.prototype.toString.apply(a) === '[object Boolean]') )
		}
		,'Date':function(a){
			return (typeof(a)==='object' && Object.prototype.toString.apply(a) === '[object Date]');
		}
		,'Mail':function(a) {
			return (
				a && (typeof(a)==='string')	&& (a.indexOf('@')>0) &&
				/^[a-z0-9]{1,}(?:[\.\_\-]{0,1}[a-z0-9]{1,})?(?:[\.\_\-]{0,1}[a-z0-9]{1,})?\@[a-z0-9]{1,}(?:[a-z0-9]{0,8}[\-]{0,1}(?:[a-z0-9]{1,}\.[a-z0-9]{2,4})?[a-z0-9]{0,8})?\.[a-z]{2,4}$/i.test(a)
			);
		}
		,'Handphone':function(a) {
			return ( a && /^1[3|5|8][0-9]{9}$/.test((''+a)) );

		}
		,'Num':function(a){
			return(typeof(a)==='number' && Object.prototype.toString.apply(a) === '[object Number]');
		}
		,'Obj':function(a){
			return (typeof(a)==='object' && a !==null && Object.prototype.toString.apply(a) === '[object Object]');
		}
		,'EmptyObj':function(_o) {
			for (var _a in _o) {if(_o.hasOwnProperty(_a)){return false;}}
			return true;
		}
		,'Regexp':function(a){
			return (typeof(a)==='object' && Object.prototype.toString.apply(a) === '[object RegExp]');
		}
		,'TimeDir':function(a) {
			return a && a.length && a.length === 8 && /^(?:19|20)[0-9]{2}(?:[0][1-9]|1[012])(?:0[1-9]|[12][0-9]|3[01])$/.test(''+a);
		}
		,'InBadwords':function(a,_t) {
			if(!codecoke.is.Str(a)) return '只能字符';
			var _badwordsO=$sev && $sev.$badwords ? $sev.$badwords : null;
			if(!_badwordsO) {
				return false;
			}
			var _wl,_nr,_r=false;
			if(_t) {
				if(codecoke.is.Str(_t)&& _badwordsO[_t]) {
					_wl = $sev.badwords[_t].length;
					for (var _i=0; _i<_wl; _i++) {
						if((new RegExp(_badwordsO[_t][_i][0],'ig')).test(a)) {
							_r= _badwordsO[_t][_i][0];
							break;
						}
					}
				}else if (codecoke.is.Arr(_t)) {
					var _tl =_t.length;
					for (var _c=0; _c<_tl; _c++) {
						if(codecoke.is.Str(_t[_c]) && _badwordsO[_t[_c]]) {
							_wl = _badwordsO[_t[_c]].length;
							for (var _d=0; _d<_wl; _d++) {
								if((new RegExp(_badwordsO[_t[_c]][_d][0],'ig')).test(a)) {
									_r= _badwordsO[_t[_c]][_d][0];
									break;
								}
							}
							if(_r) {break;}
						}else{
							continue;
						}
					}
				}
				return _r;
			}else{
				for (var _a in _badwordsO) {
					if(_badwordsO.hasOwnProperty(_a)) {
						_wl = _badwordsO[_a].length;
						for (var _b=0; _b<_wl; _b++) {
							if((new RegExp(_badwordsO[_a][_b][0],'ig')).test(a)) {
								_r=_badwordsO[_a][_b][0];
								break;
							}
						}
						if(_r) {return _r;}
					}
				}
				return _r;
			}
		}
	}
	;

codecoke.get= {
		'trim':function(s) {
			return codecoke.is.Str(s) ? s.replace(/^[\s\t ]+|[\s\t ]+$/g,'') :null
		}
		,'strlen':function (s) {
			return codecoke.is.Str(s) ? ((/[^\x00-\xff]/g.test(s)) ? s.replace(/[^\x00-\xff]/g,'cc').length : s.length) :0;
		}
		,'bindFn':function (_o,_fn) {
			var _args=Array.prototype.slice.call(arguments,2);
			return function() {_fn.apply(_o,_args)};
		}
		,'_txt2obj_':function(_t,_fnName) {
			var _q1 = _t.indexOf("'"),_q2= _t.indexOf('"'),_q =(_q2>0 && _q2<_q1) ? 0 :1;
			try {_t= _q ? eval('('+_t+')') : eval("("+_t+")") ;}catch (e) {_t= (_fnName || 'codecoke')+'._txt2obj_:'+e.description;}
			return _t;
		}
		,'insertprototype':function(_fn,_prototype) {
			for (var _a in _prototype) {if( _prototype.hasOwnProperty(_a)){
				_fn.prototype[_a]=_prototype[_a];
			}}

		}
		,'insertObj':function(_o,_n) {
			if (!codecoke.is.Obj(_o)) {_o={};}
			for (var _a in _n) {if( _n.hasOwnProperty(_a)){
				if (!_o[_a]) {
					_o[_a]=codecoke.get.clone(_n[_a]);
				}else {
					if (codecoke.is.Obj(_n[_a])) {
						_o[_a]=codecoke.get.insertObj(_o[_a],_n[_a]);
					}else if (codecoke.is.Arr(_n[_a])) {
						_o[_a]=_n[_a].concat();
					}else {
						_o[_a]=_n[_a];
					}
				}

			}}
			return _o;
		}
		,'inofObj':function(_o,_nameO) {
			var _r={};
			if (codecoke.is.Arr(_nameO)) {
				for (var _i=0,_x=_nameO.length; _i<_x; _i++) {
					_r[_nameO[_i]]=(
						codecoke.is.Nt(_o[_nameO[_i]])
						? null
						:codecoke.get.clone(_o[_nameO[_i]])
					);
				}
			}else{
				for (var _a in _nameO) {if( _nameO.hasOwnProperty(_a)){
					if (codecoke.is.Nt(_o[_a])) {
						_r[_a]=codecoke.get.clone(_nameO[_a]);
					}else {
						_r[_a]=(
							codecoke.is.Obj(_nameO[_a])
							? codecoke.get.inofObj(_o[_a],_nameO[_a])
							: codecoke.get.clone(_o[_a])
						);
					}
				}}
			}
			return _r;
		}
		,'webPath' : function(_p,_tp) {
				if(codecoke.is.Nt(_p)) return null ;
				if (_p==='/') {
					return _tp ? '/' : '' ;
				}
				_p =codecoke.get.str( _p,'noblank','lower');
				if(!_p) return null ;
				_p.indexOf('.')>-1 &&(_p =_p.replace(/\/+[^/]*\.[^\/]*$/,'').replace(/\.+/g,''));
				if(!_p)  return null;
				_p =_p.replace(/[^\-\/\_0-9a-z]+/g,'_').replace(/\_+/g,'_');
				_p.indexOf('-')>-1 && ( _p=_p.replace(/\-{2,}/,'-') );
				if(_p.indexOf('/')>-1){_p= _p.replace(/^\/+/,'').replace(/\/+$/,'').replace(/\/{2,}/g,'/');}
				return _p ? (_tp? '/'+_p+'/' : _p) : null;
		}
		,
		'encodeUri': function (s) {
			if (s == null) {
			    return '';
			}
			s = encodeURIComponent(s.replace(/\s+/g,' '));
			// encodeURIComponent ignores: - _ . ! ~ * ' ( )
			// OAuth dictates the only ones you can ignore are: - _ . ~
			// Source: http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Functions:encodeURIComponent
			s = s.replace(/\!/g, '%21').replace(/\*/g, '%2A')	.replace(/\'/g, '%27').replace(/\(/g, '%28')	.replace(/\)/g, '%29');
			return s;
		}
		 ,
		'decodeUri': function (s) {
			if (s != null) {
			    s = s.replace(/\+/g, ' ')
			}
			return decodeURIComponent(s);
		}
		,'str' : function(_o,_after,_trans) {
			if ('n_0'==_after) {
				return codecoke.get.n_0(_o);
			}else {
				if(codecoke.is.Nt(_o)) {return null;}
				_o =codecoke.get.trim(''+_o);
			}
			//if(codecoke.is.Nt(_o)) {return null;}
			//_o =codecoke.get.trim(''+_o);
			if(_after) {
				_after = codecoke.get.trim(''+_after).toLowerCase();
				switch (_after) {
					case 'noblank' : _o = _o.replace(/\s+/g,''); break;
					case 'oneblank' : _o = _o.replace(/\s{2,}/g,' '); break;
					case 'mail':
						_o = _o.length< 6 ? null : _o.replace(/\s+/g,'').toLowerCase();
						_o = _o ? (codecoke.is.Mail(_o) ? _o : null) :null;
						break;
					case 'md5':
						_o =(_o && _o.length==32 && /^[a-z0-9]{32}$/.test(''+_o)) ? _o : null;
						break;
					//case 'clearbadtag':
					//	_o = _o.replace(/\s{2,}/g,' ');
					//	_o = codecoke.get.clear_tagbank(_o);
					//	break;
					case 'guid32': _o = _o ? codecoke.get.guid32(_o) : null; break;
					case 'guid36': _o = _o ? codecoke.get.guid36(_o) : null; break;
					case 'guid38': _o = _o ? codecoke.get.guid38(_o) : null; break;

				}
			}
			if(_trans && _o) {
				_trans = codecoke.get.trim(''+_trans).toLowerCase();
				switch (_trans) {
					case 'lower' : _o = _o.toLowerCase(); break;
					case 'upper':_o =_o.toUpperCase(); break;
				}
			}
			return _o;
		}
		,'md516':function(_o) {
			return (
				_o && !codecoke.is.Nt(_o) && /^[a-z0-9]{32}$/.test(''+_o)
				? (''+_o).substr(8,16)
				: null
			);

		}
		,'str2utf8':function (_str){
			var _r ='',i = -1,x, y,_z = _str.length;
			while(++i <_z){
				/* Decode utf-16 surrogate pairs */
				x = _str.charCodeAt(i);
				y = i + 1 < _str.length ? _str.charCodeAt(i + 1) : 0;
				if(0xD800 <= x && x <= 0xDBFF && 0xDC00 <= y && y <= 0xDFFF){
					x = 0x10000 + ((x & 0x03FF) << 10) + (y & 0x03FF);
					i++;
				}
				/* Encode output as utf-8 */
				if(x <= 0x7F)
				_r += String.fromCharCode(x);
				else if(x <= 0x7FF)
				_r += String.fromCharCode(0xC0 | ((x >>> 6 ) & 0x1F),
							    0x80 | ( x         & 0x3F));
				else if(x <= 0xFFFF)
				_r += String.fromCharCode(0xE0 | ((x >>> 12) & 0x0F),
							    0x80 | ((x >>> 6 ) & 0x3F),
							    0x80 | ( x         & 0x3F));
				else if(x <= 0x1FFFFF)
				_r += String.fromCharCode(0xF0 | ((x >>> 18) & 0x07),
							    0x80 | ((x >>> 12) & 0x3F),
							    0x80 | ((x >>> 6 ) & 0x3F),
							    0x80 | ( x         & 0x3F)
						);
			}
			return _r;
		}
		,'md532':function(_o) {

		}
		,'InBadwords':function(a,_t) {
			if(!codecoke.is.Str(a)) return '只能字符';
			var _badwordsO=$sev && $sev.$badwords ? $sev.$badwords : null;
			if(!_badwordsO) {
				return false;
			}
			var _wl,_nr,_r=false;
			if(_t) {
				if(codecoke.is.Str(_t)&& _badwordsO[_t]) {
					_wl = $sev.badwords[_t].length;
					for (var _i=0; _i<_wl; _i++) {
						if((new RegExp(_badwordsO[_t][_i][0],'ig')).test(a)) {
							_r= _badwordsO[_t][_i][0];
							break;
						}
					}
				}else if (codecoke.is.Arr(_t)) {
					var _tl =_t.length;
					for (var _c=0; _c<_tl; _c++) {
						if(codecoke.is.Str(_t[_c]) && _badwordsO[_t[_c]]) {
							_wl = _badwordsO[_t[_c]].length;
							for (var _d=0; _d<_wl; _d++) {
								if((new RegExp(_badwordsO[_t[_c]][_d][0],'ig')).test(a)) {
									_r= _badwordsO[_t[_c]][_d][0];
									break;
								}
							}
							if(_r) {break;}
						}else{
							continue;
						}
					}
				}
				return _r;
			}else{
				for (var _a in _badwordsO) {
					if(_badwordsO.hasOwnProperty(_a)) {
						_wl = _badwordsO[_a].length;
						for (var _b=0; _b<_wl; _b++) {
							if((new RegExp(_badwordsO[_a][_b][0],'ig')).test(a)) {
								_r=_badwordsO[_a][_b][0];
								break;
							}
						}
						if(_r) {return _r;}
					}
				}
				return _r;
			}
		}
		,'replaceBadwards':function (a,_t) {
			if(!codecoke.get.InBadwords(a,_t)) {return a;}
			var _badwordsO=$sev && $sev.$badwords ? $sev.$badwords : null;
			if(!_badwordsO) {
				return false;
			}
			var _wl,_nr,_r='';

			if(_t) {
				if(codecoke.is.Str(_t) && _badwordsO[_t]) {
					_wl = _badwordsO[_t].length;
					for (var _i=0; _i<_wl; _i++) {
						a=a.replace((new RegExp(_badwordsO[_t][_i][0],'ig')),(_badwordsO[_t][_i][1]||'_'));
					}
				}else if (codecoke.is.Arr(_t)) {
					var _tl =_t.length;
					for (var _c=0; _c<_tl; _c++) {
						if(codecoke.is.Str(_t[_c]) && _badwordsO[_t[_c]]) {
							_wl = _badwordsO[_t[_c]].length;
							for (var _d=0; _d<_wl; _d++) {
									a=a.replace((new RegExp(_badwordsO[_t[_c]][_d][0],'ig')),(_badwordsO[_t[_c]][_d][1] || '_'));
							}
						}else{continue;}
					}
				}
			}else {
				for (var _a in _badwordsO) {
					if(_badwordsO.hasOwnProperty(_a)) {
						_wl = _badwordsO[_a].length;
						for (var _b=0; _b<_wl; _b++) {
							a=a.replace((new RegExp(_badwordsO[_a][_b][0],'ig')),(_badwordsO[_a][_b][1]||'_'));
						}
					}
				}
			}
			return a;
		}
		,'indexInArr':function  (_arr,_v) {
			if(!codecoke.is.Arr(_arr) || !_v) {
				return -1;
			}else{
				var _al =_arr.length ,_r = -1;
				for (var _i=0; _i<_al; _i++) {if(_arr[_i]==_v) {_r=_i;break;}}
				return _r;
			}
		}
		,'n_0' : function(_o){if(!_o || codecoke.is.Nt(_o)) {return 0 ;}_o = parseInt(_o);return !isNaN(_o) ? _o : 0;}
		,'n_w' : function (_n) {
			if(_n>10000) {
				return (''+_n/10000).replace(/\.\d+$/,function(_m) {if(_m.substr(1,1)>0) {	return '.'+_m.substr(1,1)+'万';}else{return '万';}});
			}else{
				return ''+_n;
			}
		}
		,'n_rand':function (top,up){
			up = up ? parseInt(up) : 0;
			top = top? parseInt(top): 10;
			return parseInt(Math.random()*(top - up + 1) + up);
		}
		,'_guid':function (_o,_rl) {
			if(!codecoke.is.Str(_o))  return null;
			if(_o.indexOf('_') >0){_o=_o.substr(2);}
			_o =codecoke.get.trim(_o);
			var _l = _o.length;
			if((_l !=32) && (_l !=36) && (_l !=38)){ return null;}
			_o =_o.toUpperCase();
			var _ro =null;
			switch (_l) {
				case 36:
					if(/^[A-Z0-9]{8}\-[A-Z0-9]{4}\-[A-Z0-9]{4}\-[A-Z0-9]{4}\-[A-Z0-9]{12}$/.test(_o)) {
						switch (_rl) {
						case 32: _ro = _o.replace(/\-/g,'');break;
						case 36: _ro = _o;break;
						case 38:_ro ='{'+_o+'}'; break;
						}
					}
					break;
				case 38 :
					if(/^\{[A-Z0-9]{8}\-[A-Z0-9]{4}\-[A-Z0-9]{4}\-[A-Z0-9]{4}\-[A-Z0-9]{12}\}$/.test(_o)) {
						switch (_rl) {
						case 32:_ro = (_o.substr(1,36)).replace(/\-/g,'');break;
						case 36: _ro = _o.substr(1,36);break;
						case 38:_ro =_o; break;
						}
					}
					break;
				default:
					if(/^[A-Z0-9]{32}$/.test(_o)) {
						switch (_rl) {
						case 32: _ro = _o;break;
						case 36: _ro = _o.substr(0,8)+'-'+_o.substr(8,4)+'-'+_o.substr(12,4)+'-'+_o.substr(16,4)+'-'+_o.substr(20,12);break;
						case 38:_ro ='{'+_o.substr(0,8)+'-'+_o.substr(8,4)+'-'+_o.substr(12,4)+'-'+_o.substr(16,4)+'-'+_o.substr(20,12)+'}'; break;
						}
					}

			}
			return _ro;

		}
		,'guid32' :function(_o) {return _o ? codecoke.get._guid(_o,32) : null;}
		,'guid36' :function(_o) {return _o ? codecoke.get._guid(_o,36) : null;}
		,'guid38' :function (_o) {return _o ? codecoke.get._guid(_o,38) : null;}
		,'guidnew' : function(_o) {
			var _str ='',_sp =(_o && 35<_o)? '-' :'',_s1,_s2
			for(var _i = 0; _i < 32; _i++) {
				_str += Math.floor(Math.random() * 0xF).toString(0xF) + (_i == 7 || _i == 11 || _i == 15 || _i == 19 ? _sp :'');
			}

			//_str =  isNaN(_str.substr(0,1)+0)?_str : ['A','B','C','D','E','F','G','H','J','K'][_str.substr(0,1)]+_str.substring(1);

			//_str = _str.replace(/^[0-9]/,function(_n) {
			//	return ['A','B','C','D','E','F','G','H','J','K'][_n];
			//})
			return (37<_o) ? '{'+_str.toUpperCase() +'}': _str.toUpperCase();
		}
		,'guiden' : function(_o) {
			var _str ='',_sp =(_o && 35<_o)? '-' :'';
			for(var _i = 0; _i < 31; _i++) {
				_str +=''+ Math.floor(Math.random() * 0xF).toString(0xF) + (_i == 6 || _i == 10 || _i == 14 || _i == 18 ? _sp :'');
			}
			return (_sp && 37<_o)
				? '{'+['A','B','C','D','E','F','G','H','J','K'][Math.floor(Math.random() *10)] +_str.toUpperCase() +'}'
				: ['A','B','C','D','E','F','G','H','J','K'][Math.floor(Math.random() *10)]+''+ _str.toUpperCase()
				;
		}
		,'time': function(_o) {
			if((new Date(_o)) !='NaN') {
				return (new Date(_o));
			}else{
				_o =	codecoke.is.Num(_o) ? _o : parseFloat(_o);
				return codecoke.is.Num(_o) ? (new Date(_o)) : null;
			}
		}
		,'timediff':function(_d1,_d2,_t) {
			var _len = _d2.getTime() - _d1.getTime();
			switch(_t.toLowerCase()){
				case 'y': return parseInt(_d2.getFullYear() - _d1.getFullYear());
				case 'm': return parseInt((_d2.getFullYear() - _d1.getFullYear())*12 + (_d2.getMonth()-_d1.getMonth()));
				case 'd': return parseInt(_len/1000/60/60/24);
				case 'w': return parseInt(_len/1000/60/60/24/7);
				case 'h': return parseInt(_len/1000/60/60);
				case 'n': return parseInt(_len/1000/60);
				case 's': return parseInt(_len/1000);
				case 'l': return parseInt(_len);
			}

		}
		,'timeadd': function(_d,_t,_n) {
			//var _d = this;
			switch(_t.toLowerCase()){
				case 'y': return new Date(_d.setFullYear(_d.getFullYear()+_n));
				case 'm': return new Date(_d.setMonth(_d.getMonth()+_n));
				case 'd': return new Date(_d.setDate(_d.getDate()+_n));
				case 'w': return new Date(_d.setDate(_d.getDate()+7*_n));
				case 'h': return new Date(_d.setHours(_d.getHours()+_n));
				case 's': return new Date(_d.setSeconds(_d.getSeconds()+_n));
				case 'l': return new Date(_d.setMilliseconds(_d.getMilliseconds()+_n));
				// case 'n': return new Date(_d.setMinutes(_d.getMinutes()+_n));
				default: return new Date(_d.setMinutes(_d.getMinutes()+_n));
			}
		}
		,'timeformat' : function(_d,_inStr){
			var o = {
				'm+' : _d.getMonth()+1
				,'d+' : _d.getDate()
				,'h+' : _d.getHours()
				,'n+' : _d.getMinutes()
				,'s+' : _d.getSeconds(),
				'q+' : Math.floor((_d.getMonth()+3)/3)
				,'S' : _d.getMilliseconds()
			};
			if(/(y+)/.test(_inStr)) {_inStr=_inStr.replace(RegExp.$1,(_d.getFullYear()+'').substr(4 - RegExp.$1.length));}
			for(var k in o){if(new RegExp('('+ k +')').test(_inStr)){ _inStr = _inStr.replace(RegExp.$1,RegExp.$1.length==1 ? o[k] :('00'+ o[k]).substr((''+ o[k]).length));}}
			return _inStr;
		}
		,'time4Dir':function(_d,_t) {
			if (codecoke.is.Num(_d) || !_d) {
				_d= _d ? new Date(_d) : new Date();
			}
			var _d1=''+(_d.getMonth()+1),_d2=''+_d.getDate();
			if (_t) {
				return _d.getFullYear()+'-'+(_d1.length <2 ? '0'+_d1 :_d1)+'-'+(_d2.length <2 ? '0'+_d2 : _d2) ;
			}else {
				return _d.getFullYear()+''+(_d1.length <2 ? '0'+_d1 :_d1)+''+(_d2.length <2 ? '0'+_d2 : _d2) ;
			}
		}
		,'time4sql':function (_d) {
			//return 'cast(\''+_d.format('yyyy-mm-dd hh:nn:ss.S')+'\' as datetime2)';
			return 'cast(\''+codecoke.get.timeformat(_d,'yyyy-mm-dd hh:nn:ss.S')+'\' as datetime2)';

		}
		,'sqlTime' : function (_v,_t) {
			if(!_t) {
				var _mh =_v.match(/^(\d{4})-(\d{1,2})-(\d{1,2}) +(\d{1,2}):(\d{1,2}):(\d{1,2})\.(\d{1,9})/);
				return (new Date(_mh[1],_mh[2] -1,_mh[3],_mh[4],_mh[5],_mh[6],_mh[7])).getTime();
			}else{
				return 'cast(\''+(''+_v).trim().replace(/\.?[0]+$/,'')+'\' as datetime2)';
			}
		}
		,'clone' : function(_o) {
			var _ro;
			if(codecoke.is.Arr(_o)) {
				_ro =[];
				var _al =_o.length;
				for (var _i=0; _i<_al; _i++) {
					if(typeof (_o[_i])=='object' && _o.hasOwnProperty(_i)) {
						_ro[_i] = codecoke.get.clone(_o[_i]);
					}else{
						_ro.push(_o[_i])
						//ary.slice(0);
					}
				}
			}else if (codecoke.is.Obj(_o)) {
				_ro ={};
				for ( var _i in _o ){if(_o.hasOwnProperty(_i)) {
					if ( typeof(_o[_i]) == 'object')  {
						_ro[_i] = codecoke.get.clone(_o[_i]);
					}else {
						_ro[_i] = _o[_i];
					}
				}}
			}else {
				_ro=_o;

			}
			return _ro;
		}
		,
		'pagesNavStr':function(_o) {
			var _navStr='',
			_iCount =_o.iCount,
			_iPageCount =_o.iPageCount,
			_iPage =_o.iPage || 0,
			_iPageSize = _o.iPageSize,
			_navSize = _o.navSize || 10,
			_el = _o.tag || 'a',
			_attr =_o.attr || 'rel="_$n" ',
			_attrValue =_o.attrV ||'_$n'
			;
			_iPageCount = _iPageCount || (_iCount%_iPageSize==0 ? _iCount/_iPageSize : parseInt(_iCount/_iPageSize+1))	;
			_iPage =(_iPage<1)? 1 : _iPage

			if (_iPageCount>1) {
				if (_iPage>_iPageCount) {
					_iPage=_iPageCount;
				}
				var _navI= (_iPage%_navSize==0) ? _iPage/_navSize : (_iPage-_iPage % _navSize)/_navSize
				,_navN = _navI*_navSize
				,_navEnd=((_navN+_navSize)>_iPageCount) ? _iPageCount : (_navN+_navSize)
				;

				if(_o.iPage>0 && _o.pHome) {
					_navStr+=_o.pHome;
				}
				if(_iPage>=_navSize) {
					if(_o.pFirst) {
						_navStr += _o.pFirst;
					}else{
						_navStr +='<'+_el+' '+_attr.replace('_$N$_',1)+' title="首页">&lt;&lt;</'+_el+'>'
					}
				}
				if(_navN> 2){
						_navStr += '<'+_el+' '+_attr.replace('_$N$_',_navN-1)+' title="上'+(_navSize)+'页">&lt;</'+_el+'>';

				}
				for (var _i= _navN;_i<=_navEnd;_i++) {
					if(_i==0) {
						continue
					}else if(_iPage==_i && _o.iPage >0) {
						_navStr += '<strong class="navNow">'+_i+'<\/strong>';

					}else if(_i ==1 &&_o.pFirst && _o.iPage >0 ){
						_navStr += _o.pFirst;

					}else if(_i ==_iPageCount &&_o.pLast ){
						continue;
					}else {
						_navStr +='<'+_el+' '+_attr.replace('_$N$_',_i)+'>'+_i+'</'+_el+'>';
					}

				}
				if((_navN+_navSize+1)<_iPageCount) {
					_navStr +='<'+_el+' '+_attr.replace('_$N$_',(_navN+_navSize))+' title="下'+(_navSize)+'页">&gt;</'+_el+'>';
				}
				if(_iPage<_iPageCount) {
					if(_o.pLast) {
						_navStr +=_o.pLast;
					}else {
						_navStr +='<'+_el+' '+_attr.replace('_$N$_',_iPageCount)+' title="尾页">&gt;&gt;</'+_el+'>'
					}
				}
			}else{
				_navStr='&nbsp;'
			}
			return _navStr;
		}
	}
	;

//}


/*var global Object*/




%>