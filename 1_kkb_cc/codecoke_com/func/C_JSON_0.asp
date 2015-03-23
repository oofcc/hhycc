<%
codecoke.fn.declareClass({
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

});
%>