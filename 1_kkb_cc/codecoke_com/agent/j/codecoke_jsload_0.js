/**/
codecoke.fn.declareClassByArr([
{
	'_basic_':{
		'name':'_NS_doc_ajax_err'
		,'fn':function(_doc) {
			this.doc = _doc;
			this.ajaxErrO={
				'_parsererror':'返回JSON数据类型错误！'
				,'_400' :'请求格式错误!'
				,'_403' :'请求被拒绝!'
				,'_404' :'请求地址错误!'
				,'_405' :'跳转错误，无效的请求!'
				,'_500' :'服务器端脚本错误，请检查请求地址!'
				,'_timeout' :'服务器连接超时，请稍候尝试！'
				,'_408' :'服务器连接超时，请稍候尝试！'
				,'_unknow':'未知错误！'
			};

		}
	}
	,'str':function(_stat,_err,_acinfo) {
			var _err2=( _stat !=200) ? _stat : _err;
			_err2=('_'+codecoke.get.trim(''+_err2)).toLowerCase();
			return (_acinfo ||'')+'<span class="cGray mrR5"> msg</span>（'+_stat+' '+_err+'）：'+( this.ajaxErrO[_err2] || '未知错误！');
	}
}
,
{
	'_basic_':{
		'name':'_NS_doc_jsload'
		,'fn':function (_doc,_apipath) {
			//this.defaultDataType='script';
			this.doc=_doc;
			this.attr={
					'defaultDataType':'script'
					,'loadLive':{}
					,'errLive':{}
					,'defaultCache':false
					//,'ajaxDebug': this.doc.attr.ajaxDebug
					,'apipath':(_apipath ||'/f1.asp')
					,'kstrName_pk':'f'
					,'kstrValue_gt':'_js'
			}
			;
			codecoke.fn.newFunIn(this,'ajaxerr','_NS_doc_ajax_err',this.doc);
		}
	}
	/*keyStr url cache args fn*/
	,'getQueryObj':function() {
			var _n =arguments.length;
			if (!_n) {	return false;}
			var _o={},_k=arguments[0];

			if (_n>1) {
				var _last =arguments[_n-1];
				if (codecoke.is.Func(_last)) {
					_o.fn=_last;
				}else if (codecoke.is.Arr(_last)) {
					_o.args=_last;
				}else if ( codecoke.is.Boolean(_last) ) {
					_o.cache=_last
				}
				codecoke.is.Str(arguments[1]) &&( _o.url_path=arguments[1]);
				if (_n>2) {
					if (codecoke.is.Boolean(arguments[_n-2])) {
						_o.cache=arguments[_n-2];
					}else if (codecoke.is.Arr(arguments[_n-2])) {
						_o.args=arguments[_n-2];
					}
					_n>3 && undefined==_o.cache
						&& codecoke.is.Boolean(arguments[_n-3])
						&&(_o.cache=arguments[_n-3])
					;
				}
			}
			(undefined==_o.cache) &&(_o.cache=this.attr.defaultCache);
			_o.args=_o.args || [];


			var _n1,_n2,_n3,_n4,_n5
				,_n6
			;

			_n1 = _k.indexOf('--');
			if (_n1>0) {
				_o.args.unshift(_k.substring(_n1+2));
				_k= _k.substring(0,_n1);
			}else if (_n1==0) {
				_k=_k.replace(/^\-+/g,'');
			}

			_n6 = _k.indexOf('?');
			if (_n6>0) {
				_o.url_qstr=_k.substring(_n6+1);
				_k= _k.substring(0,_n6);
			}

			_n2 = _k.indexOf('&');
			if (_n2>0) {
				_o.url_qstr =  _k.substring(_n2+1);
				_k= _k.substring(0,_n2);
			}


			_n3 = _k.indexOf('^');
			if (_n3>0) {
				_o.dataType=_k.substring(0,_n3).toLowerCase();
				_k=_k.substring(_n3+1);
			}else {
				_o.dataType=this.attr.defaultDataType;
			}

			_n4 = _k.indexOf('@');
			if (_n4>0) {
				_o.itopk=_k.substring(0,_n4);
				_k=_k.substring(_n4+1);
				_o.kstr=_o.itopk+'@'+_k;
				if ( _o.itopk!=='win') {
					if (!codecoke.is.Nt(window[_o.itopk])) {
						_o.itop=window[_o.itopk];

					}
				}else {
					_o.itop=window;
				}
			}else {
				_o.itopk='win';
				_o.itop =window;
				_o.kstr=_o.itopk+'@'+_k;
			}
			_o.kstr=_o.dataType+'^'+_o.kstr ;

			_n5=_k.indexOf('.');
			if (_n5>0) {
				_o.p=_k.substring(0,_n5);
				_o.c=_k.substring(_n5+1);
				//_o.kstr=_o.kstr.replace(/\./g,'_');
			}else {
				_o.p=_k;
			}
			return _o;

	}
	,'errwrite':function(_err,_notIsKstr) {
		this.doc.ihead.msg.write((_notIsKstr ? _err : this.attr.errLive[_err]),'red','add')
	}
	,'get':function() {
			var _o;
			if (codecoke.is.Obj(arguments[0])) {
				_o =arguments[0];
				_o.args=_o.args || [];
				_o.itopk = _o.itopk	|| _o.kstr.substring(_o.kstr.indexOf('^')+1,_o.kstr.indexOf('@'))	;
				_o.itop = _o.itop || window[_o.itopk] || window;
				_o.p = _o.p || _o.kstr.substring(_o.kstr.indexOf('@')+1);
				if (_o.p.indexOf('.')>0) {
					_o.c =_o.c || _o.p.substring(_o.p.indexOf('.')+1);
					_o.p=_o.p.substring(0,_o.p.indexOf('.'));
				}
				_o.dataType = _o.dataType || _o.kstr.substring(0,_o.kstr.indexOf('^')) ;
			}else {
				_o = this.getQueryObj.apply(this,Array.prototype.slice.call(arguments,0));
			}

			//alert('kstr:'+_o.kstr+'\n _o.p: '+_o.p+'\n _o.itopk: '+_o.itopk+'\n_o.c:'+_o.c);
			if (this.attr.errLive[_o.kstr]) {
				_o.error	? _o.error(this.attr.errLive[_o.kstr]) :  this.errwrite(_o.kstr);
				return false;
			}

			this['_call_'+_o.dataType](_o);
	}
	,'_get_url_value':function(_o) {
			/*
				!url
				&a=1
				gt=
				/xxx/xxx.js
				http//xxx/xxxx/?gt=
				//_o.url_vstr
				//_o.url_qstr
				//_o.url_url
			*/

			if (_o.url) {return _o;}


			if (_o.url_qstr) {
					_o.url_qstr = _o.url_qstr.split(/&+/);
					var _had_f =0;
					for (var _i=0,_x=_o.url_qstr.length; _i<_x; _i++) {
						if (!_o.url_qstr[_i]) {
							_o.url_qstr.splice(_i,1);
						}else if (_o.url_qstr[_i].indexOf('gt=')==0) {
							_o.url_gt =''+_o.url_qstr[_i];
							_o.url_qstr.splice(_i,1);
						}else if (_o.url_qsre[_i].indexOf('/')==0) {
							_o.url_path=''+_o.url_qstr[_i];
							_o.url_qstr.splice(_i,1);
						}else if (_o.url_qstr[_i].indexOf('f=')==0) {
							_had_f=1;
						}
					}
					!_had_f &&(_o.url_qstr.push('f='+_o.kstr));
			}else {
				_o.url_qstr=['f='+_o.kstr];
				_o.url_gt='gt=_js';
			}

			if (!_o.url_path) {
				if (_o.kstr.indexOf('script^$app@userbar_')==0 || _o.kstr.indexOf('json^$app@userbar_')==0) {
					_o.url_path='/codecoke_com/insiteapi/gt_siteinfo_lukasu_0.asp'
				}
				!_o.url_path && (_o.url_path= this.attr.apipath);
			}

			_o.url_qstr.unshift(_o.url_gt);
			_o.url =_o.url_path +'?'+_o.url_qstr.join('&');
			return _o.url;
	}
	,'_loaditem':function(_o) {
			if (this.attr.errLive[_o.kstr]) {
					 this.errwrite(this.attr.errLive[_o.kstr],'red','add');
					return false;
			}
			//alert(this.attr.loadLive[_o.kstr]+'\nloadlive')
			if (undefined==this.attr.loadLive[_o.kstr]) {
				this.attr.loadLive[_o.kstr]=0;
				(!_o.url) && this._get_url_value(_o);

				/*
				if (!_o.url) {
					//_o.url='/codecoke_com/api/in/get_js/?f='+_o.kstr;
					_o.url=this.attr.apipath+'?gt='+this.attr.kstrValue_gt+'&'+this.attr.kstrName_pk+'='+_o.kstr;
				}else if (_o.url.indexOf('&')==0) {
					//_o.url ='/codecoke_com/api/in/get_js/?f='+_o.kstr+_o.url
					_o.url =this.attr.apipath+'?gt='+this.attr.kstrValue_gt+'&'+this.attr.kstrName_pk+'='+_o.kstr+_o.url
				}else if (_o.url.indexOf('gt=')==0) {
					_o.url =this.attr.apipath+'?'+_o.url+'&'+this.attr.kstrName_pk+'='+_o.kstr;
				}

				if (_o.url.indexOf('?')<0) {	_o.url +='?'+this.attr.kstrName_pk+'='+_o.kstr+'&_gt='+this.attr.kstrValue_gt}
				*/

				this.doc.attr.ajaxDebug
				&& (this.doc.ihead.msg.write('<span class="cGray mrR5">ajax:</span>'+_o.url+' <span class="cGray mrR5">cache</span>'+_o.cache,'blue','add'));
				var _this=this;
				//ajax
				$.ajax({
					'async':true ,'cache':_o.cache ,'url':_o.url ,'type':_o.sendtype || 'GET' ,'dataType':_o.dataType
					,'data':_o.data
					,'error':function  (_xhr,_err) {
						_this.attr.errLive[_o.kstr]= _this.ajaxerr.str(_xhr.status,_err,'err_jsload_ajaxError:loadLiveIndex_'+_this.attr.loadLive[_o.kstr]+'_【'+_o.kstr+'】 <span class="cGray mrR5">url</span>'+this.url);
						_o.error
							? _o.error(_this.attr.errLive[_o.kstr])
							:_this.errwrite(_o.kstr)
						;
					}
					,'beforeSend':_o.beforeSend
					,'success':function(_d,_stat){
						_d &&( _o.dataType=='json') &&(_o.args =[_d].concat(_o.args));
						//_this.attr.loadLive[_o.kstr] && (delete _this.attr.loadLive[_o.kstr]);
						_this['_callafterload_'+_o.dataType](_o,true);
					}
				});
			}else {
				this.attr.loadLive[_o.kstr]++;
				if (this.attr.loadLive[_o.kstr]>50) {
					alert('jsload allow max:'+this.attr.loadLive[_o.kstr])
				}else {
					setTimeout(	codecoke.fn.bindFn(this,this['_call_'+_o.dataType],_o)	,this.attr.loadLive[_o.kstr]*20);
				}

			}
	}
	,'_call_script':function(_o) {
		if (this.attr.errLive[_o.kstr]) {
				_o.error
				? _o.error(this.attr.errLive[_o.kstr])
				:  this.errwrite(_o.kstr)
				;
				return false;
		}
		if (!_o.itop || !_o.itop[_o.p] || (_o.c && !_o.itop[_o.p][_o.c] ) ) {
			this._loaditem(_o);
		}else {
			if (!_o.fn) {
						if (_o.c && codecoke.is.Func(_o.itop[_o.p][_o.c])) {
								_o.itop[_o.p][_o.c].apply( _o.itop[_o.p],_o.args);
						}else if (!_o.c && codecoke.is.Func(_o.itop[_o.p])) {
								_o.itop[_o.p].apply(_o.itop[_o.p],_o.args);
						}else {
								this.attr.errLive[_o.kstr]='err_jsload_hasLoad: 【'+_o.kstr+'】,but not find func【'+_o.p+'.'+(_o.c||'')+'】';
								 this.errwrite(_o.kstr);
								return false;
						}
			}else {

						_o.fn.apply(_o.fn,_o.args);
			}
		}
	}
	,'_callafterload_script':function(_o) {
		if (this.attr.errLive[_o.kstr]) {
				_o.error
				? _o.error(this.attr.errLive[_o.kstr])
				:  this.errwrite(_o.kstr)
				;
				return false;
		}
		(undefined != this.attr.loadLive[_o.kstr]) && (delete this.attr.loadLive[_o.kstr]);
		if (!_o.itop || !_o.itop[_o.p] || (_o.c && !_o.itop[_o.p][_o.c] ) ){
					this.attr.errLive[_o.kstr]='err_jsload_hasload:【'+_o.kstr+'】,but not find 【'+_o.itopk+(_o.p? '.'+_o.p:'')+(_o.c?'.'+_o.c:'')+'】';
					_o.error	? _o.error(this.attr.errLive[_o.kstr])	:  this.errwrite(_o.kstr)	;
					return false;
		}

		if (_o.fn) {
				_o.fn.apply(_o.fn,_o.args);
				return true;
		}
		if (_o.c && codecoke.is.Func(_o.itop[_o.p][_o.c])) {
				//_o.itop[_o.p][_o.c].apply( _o.itop[_o.p][_o.c],_o.args);
				_o.itop[_o.p][_o.c].apply( _o.itop[_o.p],_o.args);
				return true;
		}
		if (!_o.c && codecoke.is.Func(_o.itop[_o.p])) {
				_o.itop[_o.p].apply(_o.itop[_o.p],_o.args);
				return true;
		}

		if (codecoke.is.Func(_o.itop)) {
					_o.itop.apply(_o.itop,_o.args);
					return true;
		}else {
			this.attr.errLive[_o.kstr]='err_jsload_hasload:【'+_o.kstr+'】,but not find 【'+_o.itopk+'.'+_o.p+'.'+(_o.c||'')+'】';
			//this.doc.ihead.msg.write(this.attr.errLive[_o.kstr],'red','add');
			this.errwrite(_o.kstr);
			return false;
		}
	}
	,'_call_json':function(_o) {
				if (this.attr.errLive[_o.kstr] || !_o.fn) {
						var _errstr = this.attr.errLive[_o.kstr] || 'err_jsload:【'+_o.kstr+'】need fun for json';
						_o.error
							? _o.error(_errstr)
							:   this.errwrite(_errstr,'notIsKstr')
						;
						return false;
				}
				//alert('_call_json'+_o.url)
				if (!_o.itop || !_o.itop[_o.p] || (_o.c && !_o.itop[_o.p][_o.c] ) ) {
						//alert('_call_json_loaditem_:\n_o.url:'+_o.url+'\n _o.kstr:'+_o.kstr+'\n_o.itop'+_o.itop[_o.p])
						this._loaditem(_o);
				}else {
					!_o.args.length && _o.args.push((_o.c &&  _o.itop[_o.p][_o.c] ? _o.itop[_o.p][_o.c] :(_o.itop[_o.p] || _o.itop) ) );
					_o.fn.apply(_o.fn,_o.args);
				}

	}
	,'_callafterload_json':function(_o) {
			if (this.attr.errLive[_o.kstr] || !_o.fn) {
						var _errstr = this.attr.errLive[_o.kstr] || 'err_jsload:【'+_o.kstr+'】need fun for json';
						_o.error
							? _o.error(_errstr)
							:   this.errwrite(_errstr,'notIsKstr')
						;
						return false;
			}
			//alert('_callafterload_json'+_o.url)
			(undefined != this.attr.loadLive[_o.kstr]) && (delete this.attr.loadLive[_o.kstr]);
			_o.fn.apply(_o.fn,_o.args);
	}
}
]);