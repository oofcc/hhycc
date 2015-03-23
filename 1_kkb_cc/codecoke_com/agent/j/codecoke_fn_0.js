if (!codecoke.fn){codecoke.fn=(function(_matherBasicName_) {
	var _classFunc =function(_n) {
		this.attr={};
		this.attrO=this.attr[_n]={};
	};
	_classFunc.prototype={
		'declareClass':function (_newO,_Parent) {
			var _top = _Parent || this.attrO;
			var name = _newO && _newO['_basic_']  && _newO['_basic_']['name']  ? ''+_newO['_basic_']['name'] :null;
			if (name && !_top[name]) {
				for (var _a in _newO) {if( _newO.hasOwnProperty(_a)){
					if ('_basic_'===_a) {
								!_top[name] && (_top[name] = _newO['_basic_']['fn']);
					}else {
								_top[name].prototype[_a]=_newO[_a];
					}

				}}
				_newO=null;
				return _top[name];
			}

		}
		,'declareClassByArr':function (_arr,_Parent) {
				if (codecoke.is.Arr(_arr) && _arr.length) {
					for (var _i=0,_x=_arr.length; _i<_x; _i++) {
						this.declareClass(_arr[_i],_Parent);
					}
				}else {
					return this.declareClass(_arr,_Parent)
				}

		}
		,'addClassProtypes':function(_className,_newO,_Parent) {
				var _top = _Parent || this.attrO;
				if (!_newO || !_top[_className] || !_top[_className].prototype) {
					return ;
				}
				for (var _a in _newO) {if( !_top[_className].prototype[_a] && _newO.hasOwnProperty(_a)){
					_top[_className].prototype[_a] =_newO[_a];
				}}

		}
		,'setClassProtypes':function(_className,_newO,_Parent) {
				var _top = _Parent || this.attrO;
				if (!_newO || !_top[_className] || !_top[_className].prototype) {
					return ;
				}
				for (var _a in _newO) {if(_newO.hasOwnProperty(_a)){
					_top[_className].prototype[_a] =_newO[_a];
				}}
		}
		,'newFunInClass':function() {
			var _p,_f
			if (codecoke.is.Arr(arguments[0])) {
				_p = arguments[0][0];
				_f = arguments[0][1];
			}else {
				_p = this.attrO
				_f = arguments[0];
			}
			if (_p[_f]) {
				return new _p[_f](
					arguments[1],arguments[2]
					,arguments[3],arguments[4]
					,arguments[5],arguments[6]
					,arguments[7],arguments[8]
					,arguments[9],arguments[10]
				);
			}
		}
		,'newFunIn':function(_parent,_name,_classname) {
			if (!_name) {return ;}
			if (codecoke.is.Arr(_name)) {
				for (var _i=0,_x=_name.length; _i<_x; _i++) {
					if (_name[_i].length>1 && !_parent[_name[_i][0]]) {
						_name[_i].unshift(_parent);
						this.newFunIn.apply(this,_name[_i]);
					}
				}
			}else{
				if (!_classname || _parent[_name]) {return ;}
				_parent[_name] = this.newFunInClass.apply(this,Array.prototype.slice.call(arguments,2));
			}
		}
		,'newFunWith':function() {
			var _f = function(){}
			,_al = arguments.length
			,_last =arguments[_al-1]
			,_ini = codecoke.is.Func(arguments[_al-1])
				? arguments[_al-1]
				: arguments[_al-2]  && codecoke.is.Func(arguments[_al-2])
					? arguments[_al-2]
					: null
			,_arr = _ini && codecoke.is.Arr(arguments[_al-1]) ? arguments[_al-1] :[]

			;
			if (_al >2) {
				if (arguments[0] && arguments[0][arguments[1]]) {return arguments[0][arguments[1]];}
				arguments[0][arguments[1]] = _f = function() {};
			}
			_ini && _ini.apply(_f,_arr);
			return _f;

		}
		,'newFnCookie':function(_p,_n,_arr) {
			var _f =function(_o,_doc) {
				this.doc = _doc;
				this.d={};
				this.attr=_o && codecoke.is.Obj(_o) ? _o:{};
				this.attr.name =(this.attr.name || 'A0'+Math.floor(Math.random() *10))
				/*
					//this.attr.iEscapeCookiekey = (this.attr.codekey || codecoke.runnerSetting.iEscapeCookiekey)
					this.attr.path = _top.attr.path || '/';
					this.attr.addtimetype = _top.attr.addtimetype || 'n';
					this.attr.addtimelength = _top.attr.addtimelength || 60;
				*/
				this.attr.iEscapeCookiekey = (
					this.attr.iEscapeCookiekey
					|| $sev.siteinfo.attr.iEscapeCookiekey
					|| $sev.localsetting.basic.subkeys.iEscapeCookiekey
					|| codecoke.attr.runnerSetting.iEscapeCookiekey
				);
				this.attr.nameAttr=this.attr.nameAttr||{};
				codecoke.fn.newFunIn(this,'icookie','_NS_doc_icookie_action',this);
			}
			if (arguments.length>2) {
				return this.newFunWith.call(this.newFunWith,_p,_n,_f,_arr);
			}else {
				return this.newFunWith.call(this.newFunWith,_f,_p);
			}
		}
		,'newFnAt':function(_fnKey,_parent,_fnName,_arr) {
			var _f={
					'icookie':function(_o,_doc) {
						this.doc = _doc;
						this.d={};
						this.attr=_o && codecoke.is.Obj(_o) ? _o:{};
						this.attr.name =(this.attr.name || 'A0'+Math.floor(Math.random() *10))
						/*
							this.attr.path = _top.attr.path || '/';
							this.attr.addtimetype = _top.attr.addtimetype || 'n';
							this.attr.addtimelength = _top.attr.addtimelength || 60;
						*/
						this.attr.iEscapeCookiekey = (
							this.attr.iEscapeCookiekey
							|| $sev.siteinfo.attr.iEscapeCookiekey
							|| $sev.localsetting.basic.subkeys.iEscapeCookiekey
							|| codecoke.attr.runnerSetting.iEscapeCookiekey
						);
						this.attr.nameAttr=this.attr.nameAttr||{};
						codecoke.fn.newFunIn(this,'icookie','_NS_doc_icookie_action',this);
					}

					,'userbar':function(_userBarAttrs) {  //_arr
						this.doc =_userBarAttrs.doc;
						this.attr = _userBarAttrs.attr ||{};
						codecoke.fn.newFunIn(
								this,'iuserbar','_NS_doc_userbar_action'
								,this
								,{
									'childAttr':_userBarAttrs.childAttr
									,'iuserbarAttr':_userBarAttrs.iuserbarAttr
								}
						);
						codecoke.fn.newFnAt('icookie',this,'cookie',[_userBarAttrs.cookieAttr,_userBarAttrs.doc]);
						this.getUserData=function() {

								if (!this.doc.attr.cookie_hadchange && this.attr.userData) {
										return this.attr.userData;
								}
								var _userkeystr = this.cookie.get('userkeystr')
									,_usernames
								;
								(!this.attr.userData || this.doc.attr.cookie_hadchange) && (this.attr.userData={});
								if (_userkeystr && _userkeystr.length==65) {
										this.attr.userData.userguid= _userkeystr.substring(0,32);
										this.attr.userData.userkeyid=_userkeystr.substr(33,32);
										_usernames= this.cookie.get('usernames');
										_usernames && (_usernames= _usernames.split('|||'));
										this.attr.userData.usermail=_usernames[0];
										this.attr.userData.username=_usernames[1];
										this.attr.userData.usersort=this.cookie.get('usersort');
								}else {
									this.attr.userData.userguid && (delete this.attr.userData.userguid);
								}
						}
						;
						this.go=function(_1,_2) {
								if (!_1) {return true;}
								_1 =_1.split('.');
								if (_1[1] && this[_1[0]] && this[_1[0]][_1[1]]) {return this[_1[0]][_1[1]]();}
								if (this[_1[0]] && _1[0]!=='go') {return this[_1[0]]();	}
						};

					}
			};
			//var _f = _fnListO[_fnKey];
			return this.newFunWith.call(this.newFunWith,_parent,_fnName,_f[_fnKey],_arr);

		}
		,'bindFn':function (_o,_fn) {
			var _args=Array.prototype.slice.call(arguments,2);
			return function() {_fn.apply(_o,_args)};
		}
		,'getTmplate':function(_str,_o,_o2,_o3,_o4) {
			if (!_str) {return '';}
			if (!_o) {return _str;}
			return _str
				? _str.replace(/\{\s+([^\}]*)?\}/g,function(_w) {
					var _w1 = (_w.replace(/^\{[\s ]*|[\s ]*\}$/g,''));
					//alert(_w1)
					return _w1 ?
								_o[_w1] ? _o[_w1]
									: _o2 && _o2[_w1] ?  _o2[_w1]
										: _o3 && _o3[_w1] ? _o3[_w1]
											: _o4 && _o4[_w1] ? _o4[_w1]
												:_w
							: _w
					;

					/*
					return  _w1 && _o[_w1] ? _o[_w1]
							: _w
					;
					*/
				})
				:''
			;

			//_kw=_kw.replace()

		}

	};
	return new _classFunc(_matherBasicName_);
}(codecoke.attr.classFuncBasicName));}