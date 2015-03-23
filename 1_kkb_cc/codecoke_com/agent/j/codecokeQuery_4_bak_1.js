


codecoke.debug=function(_o,_oName,_el,_tp) {
			if(codecoke.is.Nt(_el)) {_el='codecoke_debug_default';}
			if(codecoke.is.Str(_el)) {
					if(!$('#'+_el).length) { $('#iCon').append('<div id="'+_el+'"></div>'); }
					_el = $('#'+_el);
			}
			var _dstr='<h4>'+(_oName|| 'obj_Type')+'</h4><pre>'+codecoke.debug.str(_o)+'</pre>';

			if (!_tp) {
				if ($('.iDebug',_el).length) {
					$($('.iDebug',_el)[0]).html(_dstr);
				}else {
					_el.append($('<div class="blue_warning iDebug"></div>').html(_dstr));
				}
			}else {
				if (_tp=='add') {
					_el.append($('<div class="blue_warning iDebug"></div>').html(_dstr));
				}else {
					if (!$('.'+_tp,_el).filter('.iDebug').length) {
						_el.append($('<div class="blue_warning iDebug '+_tp+'"></div>').html(_dstr));
					}else {
						$($('.'+_tp,_el).filter('.iDebug')[0]).html(_dstr);
					}
				}
			}
}
;
codecoke.debug.str=function(_o) {
			var _str='';
			if(typeof (_o)==='object') {
				if(codecoke.is.Arr(_o)||(codecoke.is.Obj(_o) && _o.hasOwnProperty)) {
					_str=JSON.stringify(_o,null,'\t')
						.replace(/(\t{5,})\"([a-z0-9_\-\$]+)\"\:/gi,'$1<span class=\'cYellow\'>$2</span>\:')
						.replace(/(\t{4,})\"([a-z0-9_\-\$]+)\"\:/gi,'$1<span class=\'cGreen\'>$2</span>\:')
						.replace(/(\t{3})\"([a-z0-9_\-\$]+)\"\:/gi,'$1<span class=\'cPurple\'>$2</span>\:')
						.replace(/(\t{2})\"([a-z0-9_\-\$]+)\"\:/gi,'$1<span class=\'cBlue\'>$2</span>\:')
						.replace(/\t\"([a-z0-9_\-\$]+)\"\:/gi,'\t<span class=\'cRed\'>$1</span>\:')
						.replace(/\"([a-z0-9_\-\$]+)\"\:/gi,'<span class=\'cGreen\'>$1</span>\:')
						.replace(/\[[\t\n]+\"/gi,'[\"')
						.replace(/\"[\t\n]+\]/gi,'\"]')
						.replace(/\",[\t\n]+\"/gi,'\",\"')
						.replace(/([\{\}\[\]\,\:\"]{1,})/gi,'<span class=\'cGray\'>$1</span>')
						.replace(/\\u([a-z0-9]{4})/g,'&#x$1\;')
					;
				}else {
					for (var _a in _o) {
						_str+='<span class="cRed">'+_a+'</span>：<span class="cGreen">'+ _o[_a] +'</span><br />';
					}

				}
			}else {
					_str=''+_o;
			}
			return _str;
};
}
/*=======codecoke load end==============*/


,





codecoke.get.declareClass(
{
	'_basic_':{
		'name':'_doc_i_call'
		,'fn':function(_doc) {
			this.doc =_doc;
			this.attr={};
			this.Err='';
			this.fn={};
		}
	}
	,'go2jsload':function(_callname,_child) {
		if (!_callname) {return false;}
		var _gt ='_js'
		,_tp='script'
		,_tpIndex=_callname.indexOf(':')
		,_qIndex=_callname.indexOf('?')
		,_last
		,_argL = arguments.length;
		var _args;
		var _fn;
		var _isCahe =false;

		if (_qIndex>0) {
			_gt =_callname.substring(_qIndex+1);
			if (_tpIndex>0) {
				_tp=_callname.substring(_tpIndex+1);
				_gt = _gt.substr(0,_gt.indexOf(':'));
			}
			_callname=_callname.substr(0,_qIndex);
			//alert(_gt+'\n'+_callname+'\n'+_tp);
		}else if (_tpIndex>0) {
			_tp = _callname.substring(_tpIndex+1);
			_callname=_callname.substr(0,_tpIndex);
		}

		if (_child) {
				if(codecoke.is.Func(arguments[_argL-1])){
					_fn = arguments[_argL-1];
				}
				if(codecoke.is.Boolean(arguments[_argL-1])){
					_isCahe = arguments[_argL-1];
				}
				if (codecoke.is.Arr(arguments[_argL-1])) {
					_args =arguments[_argL-1];
				}
				if (_argL>3) {
					if(codecoke.is.Boolean(arguments[_argL-2])) {
						_isCahe = arguments[_argL-2];
					}
					if(codecoke.is.Arr(arguments[_argL-2])) {
						_args = arguments[_argL-2];
					}
					if (_argL>4 && codecoke.is.Boolean(arguments[_argL-3])) {
							_isCahe = arguments[_argL-3];
					}
				}
		}

		if ('json'==_tp && !_fn) {
			return  this.doc.ihead.msg.write('doc_icall_err_<strong>doc.'+_callname+(_child ? '.'+_child : '')+'</strong>: the json call need callback_fun!!','red','add');
		}
		if (this.doc[_callname]) {
				if (!_child) {
					return ('json'==_tp) ? _fn() : this.doc[_callname]();
				}
				if (codecoke.is.Func(_child)) {
					return _child();
				}
				if (this.doc[_callname][_child]) {
						return 'json'==_tp ? _fn() : this.doc[_callname][_child].apply(this.doc[_callname],Array.prototype.slice.call(arguments,2));
				}
		}
		return _fn
			? (
				_args
				?  this.doc.jsload.get(_tp+'^'+this.doc.attr.keyname+'@'+_callname+(_child? '.'+_child:''),'gt='+_gt,_isCahe,_args,_fn)
				: this.doc.jsload.get(_tp+'^'+this.doc.attr.keyname+'@'+_callname+(_child? '.'+_child:''),'gt='+_gt,_isCahe,_fn)
			)
			: (
				_args
				? this.doc.jsload.get(_tp+'^'+this.doc.attr.keyname+'@'+_callname+(_child? '.'+_child:''),'gt='+_gt,_isCahe,_args)
				:this.doc.jsload.get(_tp+'^'+this.doc.attr.keyname+'@'+_callname+(_child? '.'+_child:''),'gt='+_gt,_isCahe)
			)
		;

	}
	,'go':function(_callname) {
		if (!_callname) {return false;}
		//alert(this.doc.attr.keyname);

		if (codecoke.is.Str(_callname)) {
			return this.go2jsload.apply(this,arguments);
		}
		if (codecoke.is.Arr(_callname)) {
			for (var _i=0,_x=_callname.length; _i<_x; _i++) {
				codecoke.is.Arr(_callname[_i]) ? this.go2jsload.apply(this,_callname[_i]) :this.go2jsload(_callname[_i]);
			}
		}
	}
}
);


codecoke.get.declareClass(
{
	'_basic_':{
		'name':'_doc_iform'
		,'fn':function(_doc) {
				this.doc=_doc;
				this.creatformArr=[
					['<form', '','','','','>']
					,['<div class="yellow_warning',' iSkip','">','','</div>']
					,[] //about
					,[]//inputs
					,['<div class="red_warning iSkip">','','</div>'	]
					,[] //mintxt
					,[
						'<div class="iformBottom">'
						,''
						,'<button class="iformBtn" type="button">'
						,''
						,'</button>'
						,''
						,'</div>'
					]
					,[]//endtxt
					,['</form>']
				];


		}

	}
	,'checkIformInputs':function(_next) {
		var _err='',_min,_max,_v='',_before,_n;
		var _this =this;
		!this.el.red_warning.hasClass('iSkip') && this.el.red_warning.addClass('iSkip');
		this.el.inputs =$('input[name]',this.iform);
		if (this.el.inputs && this.el.inputs.length) {
			this.el.inputs.removeAttr('class');
			this.el.div_inputs.find('sup').text('  ');
			this.v={};
			this.el.inputs.each(function(_i) {
				_before = $(this).prev().text() || '输入框	';
				_n = $(this).attr('name');
				_v =$(this).val()||'';
				if (_v) {
					_v =_v.replace(/^\s+|\s+$/,'');
					$(this).val(_v);
					_this.v[_n]=_v;
				}				_min = $(this).attr('minlength') || 0;
				_max =$(this).attr('maxlength')||0;
				_max= _max>50000 ? 0 :_max;
				if (_min && _min>_v.length) {
					_err = '错误提示_<strong>'+_before+'</strong> 的输入内容不得少于 '+_min+' 字符';
					$(this).attr('class','input_err');
					$(this).next().text(' X ')
					return false;
				};
				if (_max && _v && (_v.length > _max || codecoke.get.strlen(_v)>_max) ) {
					_err = '错误提示_<strong>'+_before+'</strong> 的输入内容不得大于 '+_max+' 字符，一个中文算2字符。';
					$(this).attr('class','input_err');
					$(this).next().text(' X ');
					return false;
				}
				_v && ($(this).attr('className','input_ok') || $(this).next().text(' √ ') );
			});
		}

		if (_err) {
			this.el.red_warning.removeClass('iSkip').html(_err);
			return false;
		}
		if (_next && codecoke.is.Func(_next)) {
			_next(this);
		}else {
			return this;
		}
	}
	,'getIformElements':function(_r) {
			_r.el.btn =$('button.iformBtn',_r.iform);
			_r.el.red_warning = $('div.red_warning',_r.iform);
			_r.el.yellow_warning = $('div.yellow_warning',_r.iform);
			_r.el.inputs =$('input[name]',_r.iform);
			_r.el.div_inputs=$('div.iform_inputs',_r.iform);

			var _min,_max,_after,_size
			_r.el.inputs.length && _r.el.inputs.each(function(_i) {
				_size = $(this).attr('size');
				(!_size || _size==28 || _size==20 ) && $(this).attr('size',30);
				_min = $(this).attr('minlength') || 0;
				_max =$(this).attr('maxlength')||0;
				_max= _max>50000 ? 0 :_max;
				_after= _min && _max
						? '<span class="cRed">*</span><span>'+_min+' 到 '+_max+' 字符</span>'
						: (
							_min ? '<span class="cRed">*</span><span> 不少于 '+_min+' 字符</span>'
							: (
								_max ? '<span>不超过 '+_max+' 字符</span>' :'<span class="cGray">可不填</span>'
							)
						)
				;
				_after && $(this).after(_after).after('<sup>&nbsp;</sup>');
				_r.n[$(this).attr('name')]=$(this);}

			);
	}
	,'elementsReset':function(_f) {
		//if (!_f) {return ;}
		this.el.inputs && this.el.inputs.removeAttr('class').val('');
		this.el.red_warning && this.el.red_warning.addClass('iSkip').empty();
		this.el.btn && this.el.btn.removeAttr('disabled').text('提交');
	}
	,'get':function(_o) {
				var _arr = codecoke.get.clone(this.creatformArr);
				var _form_id =_arr[0][1] =' id="'+_o.id+'"';

				_arr[0][4] =' class="iform '+( _o._class||'')+'"' ;
				//_arr[4][1] = _o.red_warning ?  _o.red_warning :'';

				if (_o.yellow_warning) {
					_arr[1][1]=''; // del iSkip
					_arr[1][3]=_o.yellow_warning;
				}


				_arr[2]= _o.about ?(
						_o.about.indexOf('<div')==0 ? _o.about :'<div class="iform_about">'+_o.about+'</div>'
					) :'';
				_arr[3] = _o.inputs
						?(
							codecoke.is.Arr(_o.inputs)
							? '<div class="iform_inputs"><p>'+_o.inputs.join('</p><p>')+'</p></div>'
							: (_o.inputs.indexOf('<div')==0? _o.inputs : '<div class="iform_inputs">'+_o.inputs+'</div>')
						)
						:''
				;
				_arr[4][1] = _o.red_warning ?  _o.red_warning :'';
				_arr[6][3]= _o.buttontxt ||'提交';
				for (var _i=0,_x=_arr.length; _i<_x; _i++) {	_arr[_i].length && codecoke.is.Arr(_arr[_i]) && ( _arr[_i]= _arr[_i].join(''));	}
				var _r ={
					'iform':$(_arr.join('')).submit(function () {return false;})
					,'id':_o.id
					,'el':{}
					,'n':{}
					,'v':{}
					,'fn':{}
				};
				this.getIformElements(_r);
				_o.ck && _r.el.btn.bind('click',codecoke.get.bindFn(_r,this.checkIformInputs,_o.ck));
				_r.fn.reset= codecoke.get.bindFn(_r,this.elementsReset);
				return _r;

		}
}

);












codecoke.get.declareClass({
	'_basic_':{
		'name':'_win_doc_All'
		,'fn':function(_localSettingBasic,_kname) {
				this.localSettingBasic =_localSettingBasic;
				this.el_iwallpaper= $('#iWallpaper');
				this.el_ihead2clear =$('#ihead2Clear');
				this.attr={
					'keyname':_kname
				};
				this.ini();

		}
	}
	,'ini':function() {
		codecoke.get.newFunIn(this,'foot','_doc_foot',this);
		codecoke.get.newFunIn(this,'ihead','_doc_ihead',this);
		codecoke.get.newFunIn(this,'icontent','_doc_icontent',this);
		codecoke.get.newFunIn(this,'paper','_doc_paper',this);
		codecoke.get.newFunIn(this,'iform','_doc_iform',this);
		codecoke.get.newFunIn(this,'ajaxerr','_doc_ajax_err',this);
		codecoke.get.newFunIn(this,'jsload','_doc_jsload',this,this.localSettingBasic.gtPath.agent);
		codecoke.get.newFunIn(this,'icall','_doc_i_call',this);

		this.go2headerEl=$('<sup></sup>',{'text':'top ↑','class':'iR go2head','click':this.go2header});
		this.go2footerEl=$('<sup></sup>',{'text':'foot ↓','class':'iR go2footer','click':this.go2footer});

		this.whenPageFirstLoadSet();

	}
	,'go2header':function(){$(window).scrollTop(0);}
	,'go2footer':function() {$(window).scrollTop(99999);}
	,'whenPageFirstLoadSet':function() {
		this.el_ihead2clear.length && this.el_ihead2clear.before(this.ihead.el);

		this.foot.nav.prepend(this.go2headerEl.clone()).find('ul').append(
				$('<li></li>',{
					'id':'addFavorite'
					,'text':'\[+\] 收藏本页'
					,'class':'aLink'
					,'click':function() {
						var _u= window.location.href+'',_t= document.title+'';
						if (window.sidebar && window.sidebar.addPanel) {
								window.sidebar.addPanel(_t, _u,'');
						}else if (window.external) {
								window.external.AddFavorite(_u,_t);
						}else {
							alert('您的浏览器只能手动将添加到收藏夹');
						}

					}
				})
			)
		;
		$('div.acTag_dl_fl dl:has(dd)').bind({
				'mouseenter':function() {
					$('dl.iShow',$(this).parent()).removeClass('iShow');
					$(this).addClass('iShow');
				}
				,'mouseleave':function() {
					$('dl.iShow',$(this).parent()).removeClass('iShow');
				}
		})
		;
		$('#iHeadFoot').prepend(this.go2footerEl.clone());
	}
	,'afterSiteInfoLoad':function() {

		//this.attr.runerrUrl = $sev.$localSettingBasic
		//$localSettingBasic
		//this.afterSiteInfoCookie();
		codecoke.get.newFunIn(this,'cookie','_doc_cookies',this);
		codecoke.get.newFunIn(this,'user','_doc_user',this);

		this.foot.poweredEl.prepend(
				$('<a></a>',{
					'href':'http://www.miibeian.gov.cn/'
					,'text':$sev.$site.attr.miibeian
					,'target':'_blank'

				})
		)
		;
		if (!$('copyright').length) {
			this.foot.poweredEl.before(
					$('<div />',{
						'id':'copyright'
						,'html':'&#x00a9;&nbsp;'+($sev.$site.attr.createtime.substr(0,$sev.$site.attr.createtime.indexOf('-')))+'-'+(new Date()).getFullYear()+' <a href="/" id="copyrightUrl">'+$sev.$site.attr.domain+'</a>All Rights Reserved.'
					})
				)
		}
		$('div.ggSearch').html($sev.$site.attr.ggSearchStr).append(
				//$('<script>',{'src':$sev.$site.info.ggSearchSrc})
				//$('<script>alert(\'123\')</script>')
		)
		;
	}
	,'hand_C3_hashcall':function(_e) {
			var _this = _e.data._this;
			var _v = $(this).attr('C3_hashcall');
			_this.jsload.get(_v,false);


	}
	,'bindElementFnWithAttr':function() {
		//$('a[rel^='+this._sett._rel_pk+']').live('click',{'_this':this},this.imgHand);
		$('a[href][C3_hashcall*="@"]').live('click',{'_this':this},this.hand_C3_hashcall);


	}
	,'apiGo':function(_fn2) {
		var _this =this;
		var _fn ={
					'kstr':'json^$sev@$site'
					,'url':'gt=_siteinfo&v=2'
					,'cache':false
					,'fn':function(_d) {
						$sev.$site=_d;
						$('#iCon').append(
										$('<div>'+JSON.stringify($sev)+'</div>').text(JSON.stringify($sev)).prepend('<hr/>')
										.append('<hr/><div>Cookie:<br/>'+document.cookie+'</div>')
						)
						_this.afterSiteInfoLoad();
						_fn2 && _fn2();
						_this.bindElementFnWithAttr();
					}
		};
		this.jsload.get(_fn);

		/*
		if (this.localSettingBasic &&  this.localSettingBasic.$apiGo) {
			var _this =this;
			this.loadGo(
				function(_argFn2) {
						//doc.head.msg.write('$sev.$head.time:'+$sev.$head.time,'red',3);
						//doc.head.msg.hide();
						doc.jsload.get(_this.localSettingBasic.$apiGo,false);
						if (_argFn2 && codecoke.is.Func(_argFn2)) {
							_argFn2();
						}
						//alert(arguments[0]+'\n'+_args)
				}
				,_fn2
			);
		}else {
			this.loadGo(_fn2);
		}
		*/
	}
});

codecoke.get.declareClass({
	'_basic_':{
		'name':'_doc_cookies'
		,'fn':function(_doc) {
				this.doc =_doc;
				this.attr={
					'sett' :$sev.$site.sett.cooke
					,'name_pk': ( $sev.$head.web_rootdomain || (''+window.location.hostname).replace('.','_') ).substr(0,3)+'_'
					,'isCookieTrue' :!!(document.cookie && document.cookie.length>5)
				}
				this.d={};
				this.f={};
				this.ini();
		}
	}
	,'ini':function() {
		if (!this.attr.isCookieTrue && window.location.pathname.indexOf(this.doc.localSettingBasic.gtPath.runerr)==-1) {
			window.location.reload(this.doc.localSettingBasic.gtPath.runerr+'?errtp=cooke&errdata=notIsCookieTrue');
			return false;
		}
		this.attr.cookiestr=codecoke.get.decodeUri(''+document.cookie);
		//$('#myt').text(this.attr.cookiestr)
		var _this =this;
		if (this.attr.sett) {
			for (var _a in this.attr.sett) {if( this.attr.sett.hasOwnProperty(_a)){
					this.f[_a]={
						'attr':this.attr.sett[_a].attr
						,'nameAttr':this.attr.sett[_a].nameAttr
						,'d':{}
						,'icookie':this
						,'cookieName':this.attr.name_pk+this.attr.sett[_a].attr.name
						,'keyName':_a
					};
					//this.addCookieFn(_a);
					this.f[_a].read=function() {return _this.child_read.apply(_this.f[_a],Array.prototype.slice.call(arguments));}
					this.f[_a].get =function() {return _this.child_get.apply(_this.f[_a],Array.prototype.slice.call(arguments));}
					//this.f[_a].write =function() {return _this.child_write.apply(_this.f[_name],Array.prototype.slice.call(arguments));}
			}}
		}
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
	,'child_get':function(_n) {
			if (undefined ==this.d.cookiestr || this.icookie.doc.attr.cookiehadchange) {
				//this.icookie.doc.attr.cookiehadchange && (alert('cookie had change'));
				this.read();
			}
			if (''===this.d.cookiestr) {return '';}
			_n =this.nameAttr[_n] || _n;
			var _v ='';
			if (
				this.d.cookiestr.indexOf(_n+'=') != -1
				&& (new RegExp('(?:^|&)'+_n+'\=([^&]*?)(?:&|$)')).test(this.d.cookiestr)
				&& RegExp.$1
				&& RegExp.$1.length
			) {
				_v = ''+RegExp.$1;
				_v && (_v =_v.replace(/＆/g,'&'))
			}
			return _v;
	}
	,'child_read':function() {
		if (
			( new RegExp('(?:^|[ ]+)'+this.cookieName+'\=([^;]*?)(?:;|$)','g')).test(codecoke.get.decodeUri(''+document.cookie))
			&& RegExp.$1
			&& RegExp.$1.length
		) {
			this.d.cookiestr = ''+RegExp.$1;
			this.hascookie=true;
		}else {
			this.d.cookiestr='';
		}
		this.icookie.doc.attr.cookiehadchange && (delete this.icookie.doc.attr.cookiehadchange);
		//$('#myt2').append(this.cookieName+':------<br>'+this.d.cookiestr)
		return this.d.cookiestr;
	}
});


codecoke.get.declareClass({
	'_basic_':{
		'name':'_doc_user_bar'
		,'fn':function(_doc,_user) {
			this.doc =_doc;
			this.user = _user;
			this.el_parent = this.doc.ihead.el_topright;
			this.attr={
				'id':'iTopUser'
				,'bar_id':'iTopUserBar'
				,'tool_id':'iTopUserTool'
				,'con_id':'iTopUserContent'
				,'bar_signArr':[
						'<div class="iTopUserBarSign">'
						,'<a href="javascript:void(0);" C3_hashcall="doc@sitesign.writeform" >'
						,'登录'
						,'</a>'
						,'<a href="#doc@sitereg.readwarning" C3_hashcall="doc@sitesign.readwarning" >'
						,'注册'
						,'</a>'
						,'</div>'
					]
				,'bar_infoArr':[
						'<div class="iTopUserBarInfo">'
						,['<span class="iuserFace"><img src="','/codecoke_com/agent/i/noface.gif','" /></span>']
						,['<a class="iuserLogout" href="javascript:void(0);" C3_hashcall="doc@sitesign.logout" >','退出','</a>']
						,['<strong class="iuserName">','','</strong>']
						,'&nbsp;'
						,'</div>'
					]
				,'con_userinfoArr':[
						['<dt>资料</dt><dd><ul>','','','','','</ul></dd>']
						,[] //级别
						,''
				]
			};
			this.ini();
			//alert('hello');
		}
	}
	,'write':function() {
		var _uid = this.user.my.sitesign_id || this.user.get_sitesignUserInCookie();
		var _arr;
		if (!_uid) {
				//alert('doc_user_bar_write\nnot find _uid')
				this.el_bar.html(this.attr.bar_signArr.join(''));
				this.el_con.addClass('iSkip');
		}else {
				var _info_arr = codecoke.get.clone(this.attr.bar_infoArr);
				var _userinfo_arr =codecoke.get.clone(this.attr.con_userinfoArr);
				var _my =$sev.users['_'+_uid];
				var _sort;

				_info_arr[3][1]=_my.username;
				$.each(_info_arr,function(_i, _v) {codecoke.is.Arr(_v)&& (_info_arr[_i] = _v.join(''));	});
				this.el_bar.html(_info_arr.join(''));

				if (!$('dl.iTopUserContentInfo',this.el_con).length) {
					this.el_tool.after('<dl class="iTopUserContentInfo iTopUserContentZone"></dl>');
					this.el_con_userinfo =$('dl.iTopUserContentInfo',this.el_con);
				}
				_userinfo_arr[0][1]=
						'<li><strong>我的邮箱：</strong>'+_my.usermail+'</li>'
						+'<li><strong>最后登录：</strong>'+codecoke.get.timeformat((new Date(_my.lastsigntime)),'yyyy-mm-dd hh:nn:ss.S')+'</li>'
					;
				if (_my.usersort) {
					_sort =_my.usersort;
					_userinfo_arr[1]=['<dt>级别</dt><dd><ul>']
					_sort.sitelevel && _userinfo_arr[1].push('<li><strong>网站组：</strong>'+_sort.sitelevel+(_sort.sitepointcount ? ' <strong>积分：</strong>'+_sort.sitepointcount :'')+' </li>');
					_sort.bloglevel && _userinfo_arr[1].push('<li><strong>博客组：</strong>'+_sort.bloglevel+(_sort.blogcount?' <strong>博客：</strong>'+_sort.blogcount:'')+' </li>');
					_sort.viplevel && _userinfo_arr[1].push('<li><strong>VIP组：</strong>'+_sort.viplevel+(_sort.vipendtime? ' <strong>到期：</strong>'+codecoke.get.timeformat((new Date(_sort.vipendtime)),'yyyy-mm-dd hh:nn.ss.S'):'')+' </li>');
					_sort.editlevel && _userinfo_arr[1].push('<li><strong>编辑组：</strong>'+_sort.editlevel+' </li>');
					_sort.adminlevel && _userinfo_arr[1].push('<li><strong>管理组：</strong>'+_sort.adminlevel+' <a href="#" C3_hashcall="doc@adminset.ify--w123">网站管理</a></li>');

					_sort.dosetlevel && _userinfo_arr[1].push('<li><strong>设置组：</strong>'+_sort.dosetlevel+' <a href="javascript:void(0);" C3_hashcall="doc@doset.ify--w123">网站设置</a></li>');

					_userinfo_arr[1].push('</ul></dd>');

				}


				$.each(_userinfo_arr,function(_i, _v) {_v && codecoke.is.Arr(_v) && (_userinfo_arr[_i] = _v.join(''));});
				this.el_con_userinfo.html(_userinfo_arr.join(''));

		}
	}
	,'ini':function() {
			if (!this.el_parent.length) {
				this.doc.ihead.el_top.prepend('<div id="iHeadtopright"></div>');
				this.el_parent =this.doc.ihead.el_topright = $('#iHeadtopright');
			}
			//alert('doc_user_bar_ini');
			if (!this.el) {
					this.el_parent.prepend(
					'<div id ="'+this.attr.id+'" class="'+this.attr.id+'">'
						+'<div id ="'+this.attr.bar_id+'" class="'+this.attr.bar_id+'"></div>'
						+'<div id ="'+this.attr.con_id+'" class="'+this.attr.con_id+' iSkip">'
							+'<div id ="'+this.attr.tool_id+'" class="'+this.attr.tool_id+'">'
								+'<a  href="#" class="navNow">我的</a>'
								+'<a  href="#">搜藏</a>'
								+'&nbsp;'
							+'</div>'
						+'</div>'
					+'</div>'
				);
				this.el = $('#'+this.attr.id);
				this.el_bar =$('#'+this.attr.bar_id);
				this.el_con =$('#'+this.attr.con_id);
				this.el_tool =$('#'+this.attr.tool_id);
				this.el.bind({
					'mouseenter':function() {
						var _el =$('div.'+$(this).attr('id')+'Content',$(this));
						!$('div.iTopUserBarSign',$(this)).length
						? (_el.hasClass('iSkip') && _el.removeClass('iSkip'))
						:	(!_el.hasClass('iSkip') && _el.addClass('iSkip'))
						;
					}
					,'mouseleave':function() {
						var _el =$('div.'+$(this).attr('id')+'Content',$(this));
						!_el.hasClass('iSkip') && _el.addClass('iSkip');
					}
				});

			}

	}

});

codecoke.get.declareClass({
	'_basic_':{
		'name':'_doc_user'
		,'fn':function(_doc) {
			this.doc =_doc;
			//alert(this.doc.ihead.el_topright);
			this.attr={};
			this.d={};
			this.my={};
			codecoke.get.newFunIn(this,'bar','_doc_user_bar',this.doc,this);
			this.ini();
		}
	}
	,'get_sitesignUserSort':function(_sortstr) {
		//alert(_sortstr);
		if (!_sortstr || ''==_sortstr) {
			return {};
		}
		var _arr = _sortstr.split('|')
			,_vrr
			,_vl
			,_nrr
			,_r={}
			,_a
			,_x = _arr.length
		;
		for (var _i=0; _i<_x; _i++) {
			_vrr =_arr[_i].split('.');
			_vl =_vrr.length;
			_a =_vrr[0];
			if (_vl>1 && _a && $sev.$site && $sev.$site.sett && $sev.$site.sett.usersort[_a]) {
					_nrr =$sev.$site.sett.usersort[_a];
					for (var _c=1; _c<_vl; _c++) {
						if (undefined != _nrr[_c]) {_r[_nrr[0]+_nrr[_c]] = 1*_vrr[_c];}
					}
			}
		}
		$('#myt2').html(_sortstr);
		return _r;
	}
	,'get_sitesignUserInCookie':function() {
			!this.doc.cookie && codecoke.get.newFunIn(this.doc,'cookie','_doc_cookies',this.doc);
			var _userkeystr =this.doc.cookie.f.sitesign.get('userkeystr');

			if (!_userkeystr || _userkeystr.length!==80 || !/^[A-Z0-9]{80}$/.test(_userkeystr)) {
				//alert('doc_user_get_sitesignUserInCookie\n not find _userkeystr');
				return '';
			}

			var _sitesign_user ={
				'uid':_userkeystr.substring(0,32)
				,'pwd':(''+_userkeystr.substr(35,32)).toLowerCase()
				,'lastsigntime':1*_userkeystr.substring(67)
				,'userlevel':this.doc.cookie.f.sitesign.get('userlevel')
				,'username':this.doc.cookie.f.sitesign.get('username')
				,'usermail':this.doc.cookie.f.sitesign.get('usermail')
				,'usersort':this.get_sitesignUserSort(this.doc.cookie.f.sitesign.get('usersort'))
			};

			//if (_sitesign_user.usersortStr) {
			//		_sitesign_user.sort = this.get_sitesignUserSort(_sitesign_user.usersortStr);
			//}

			$sev.users['_'+_sitesign_user.uid]= codecoke.get.clone(_sitesign_user);
			this.my.sitesign_id = _sitesign_user.uid;
			$('#myt3').append(_userkeystr+'<br/>'+JSON.stringify($sev.users['_'+_sitesign_user.uid]));
			return this.my.sitesign_id;
	}
	,'get':function(_item) {


	}
	,'ini':function() {
		//this.bar.el_parent.text('hello');
	}

});





/*=======page load start========*/
if(!window.$sev) {window['$sev']={	'$sysZone':{},'users':{}};}
//if (!window.GC) {window['GC']={};}
jQuery(function($) {
	codecoke.get.newFunIn(window,'doc','_win_doc_All',$sev.$localSettingBasic,'doc');
	doc.attr.ajaxDebug=1;
	doc.apiGo(function() {
		//alert('apigo');
		//doc.user.get_sitesignUserInCookie();
		doc.user.bar.write();
		/*
		var _userkeystr =doc.cookie.f.sitesign.get('userkeystr')
		$('#myt3').append(
			'uid:'+(''+_userkeystr).substring(0,32)
			+'<br/>pwd:'+_userkeystr.substr(35,32).toLowerCase()
			+'<br>userkeystr:'+_userkeystr
			+'<br>userkeystr:'+_userkeystr.length
			+'<br/>lastsign:'+_userkeystr.substring(67)
			+'<br/>userlevel:'+doc.cookie.f.sitesign.get('userlevel')
			+'<br/>username:'+doc.cookie.f.sitesign.get('username')
			+'<br/>usermail:'+doc.cookie.f.sitesign.get('usermail')
			+'<br/>usersort:'+doc.cookie.f.sitesign.get('usersort')
		);
		*/
		//doc.cookie.f.sitesign.write();


	});


	doc.foot.nav.prepend(
		$('<span class="iL cHand">sitesign writeform</span>').click(function() {
			doc.icall.go('sitesign','writeform',false,['1111','2222']);
		})
	);


	//codecoke.get.newFunIn(doc,'cookie','_doc_cookies',doc);




	//alert('1111');




	//doc.icall.go('apiGo');
	//doc.icall.go('sitesign','writeform',false,['1111','2222']);


	//doc.paper.creatPaperWin();

/*
	var _s = doc.iform.get({
			'id':'f_test'
			,'_class':'f_class1'
			,'about':'网站登录'
			,'buttontxt':'登录'
			,'inputs':[
				'<strong>管理帐号</strong><input type="text" name="_name" minlength="2" maxlength="28" value="莫非" />'
				,'<strong>管理密码</strong><input type="password" name="_pwd" minlength="6" maxlength="24" value="123456" />'
			]
			,'ck':function() {
				alert('123');
			}
	})

//	doc.paper.el_box.append(_s.iform)


	var _s1 = doc.iform.get({
			'id':'f_test1'
			,'_class':'f_class1'
			,'about':'是不是我的十八岁，注定要为爱情流泪！'
			,'buttontxt':'登录'
			,'inputs':[
				'<strong>管理帐号</strong><input type="text" name="name"  minlength="2" maxlength="28" value="莫非" />'
				,'<strong>管理密码</strong><input type="password" name="pwd2" minlength="6" maxlength="24" value="123456" />'
			]
			,'ck':function() {
				//alert('345');
				alert(_s1.n.pwd2.attr('name')+':\n'+_s1.v.pwd2)
			}
	})
*/
/*
doc.icall.go([
	['paper','add',_s.iform,0,0]
	,['paper','add',_s1.iform,1]
	,['ttt1:json','t2']
	,['hex?_js:script','md5go']
]);

doc.icall.go([
	['sitesign','go',false]
	//,['hex?_js:script','md5',function() {
	//	alert('123:md5\n'+doc.hex.md5('123'));
	//}]
]);

*/




});