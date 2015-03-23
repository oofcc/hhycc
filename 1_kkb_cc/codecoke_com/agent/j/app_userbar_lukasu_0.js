
codecoke.fn.newFnAt(
			'userbar'
			,$app
			,'userbar_lukasu'
			,[
				//function(_userBarAttr) {  //_arr
				{
					'cookieAttr':$sev.siteinfo.cookiesetting.lukasu_sS.attr
					,'doc':window['doc']
					,'attr':{
						'barFnName':'userbar_lukasu'
						//,'userData':{}
					}
					,'childAttr':{
						'headtop':{
							'tmpl_user_bar':'<div id="{ bar_id}" class="iTopUserBarInfo">'
								+'<span class="iuserFace"><img src="/codecoke_com/agent/i/noface_1.jpg" /></span>'
								+'<strong class="iuserName">{ username}</strong>'
								+'<a class="iR" href="javascript:void(0)"  C3_hexCall="script^$app@{ app_name}.signout">退出</a>'
								+'<div>'
							,'tmpl_guest_bar':'<div id="{ bar_id}" class="iTopUserBarInfo"><a class="iL" href="javascript:void(0)" C3_hexCall="script^$app@{ app_name}.signin">登录</a><a href="javascript:void(0)" class="iR" C3_hexCall="script^$app@{ app_name}.signout">退出</a>&nbsp;<div>'
							,'tmp_user_con':'<ul>'
									+'<li>邮件：{ usermail}</li>'
									+'<li>组别：{ userlevel_0}</li>'
									+'</ul>'
							,'_d':{
								'bar_id':'ibar_headtop_lukasu'
								,'con_id':'ibar_headtop_lukasuCon'
								,'app_name':'userbar_lukasu'
							}
						}
						,'sideright':{
							'tmp_sideright':'<dl id="{ side_r_id}" class="{ side_r_id} sidemenu"></dl>'
							,'_d':{
								'side_r_id':'ibar_side_right_lukasu'
							}
						}
						,'sidemax':{
							'tmp_sidemax':'<div id="{ side_m_id}" class="{ side_m_id} sidemax"></div>'
							,'_d':{
								'side_m_id':'ibar_side_max_lukasu'
							}
						}
					}
					,'iuserbarAttr':{
						'headtop':{
							'id':'ibar_headtop'
							,'p_id':'iHeadtopright'
							,'bar_id':'ibar_headtop_bar'
							,'con_id':'ibar_headtop_content'
							,'tool_id':'ibar_headtop_tool'
							,'tmpl':'<div id="{ id}" class="{ id} iTopUser">'
									+'<div id="{ bar_id}" class="{ bar_id} iTopUserBar">#$bar_id$</div>'
									+'<div id="{ con_id}" class="{ con_id} iTopUserContent iSkip">'
										+'<div id="{ tool_id}" class="{ tool_id} iTopUserTool"><a href="#">#{ tool_id}</a><a href="" class="navNow">navNow</a></div>'
										+'<!--div class="iTopUserContentZone">#{ tool_id} after</div-->'
									+'</div>'
								+'</div>'
						}
						,'sideright':{
							'id':'ibar_side_right'
							,'p_id':'iCon'
							,'tmpl':'<div id="{ id}" class="{ id}" iConSideRight></div>'

						}
						,'sideleft':{
								'id':'ibar_side_left'
								,'p_id':'iCon'
								,'tmpl':'<div id="{ id}" class="{ id}" iConSideLeft></div>'
						}
						,'sidemax':{
								'id':'ibar_side_max'
								,'p_id':'iCon'
								,'tmpl':'<div id="{ id}" class="{ id} iConMaxZone"><div class="iCF"></div></div>'
						}
					}
			}
		]
	);



$app.userbar_lukasu.ck_go=function(_1) {
	//alert(_1);
	this.sidemax.write();
	var _el
	;
	if (_1 ) {
			$('div.sidemaxZone',this.sidemax.attr.el).not('iSkip').addClass('iSkip');
			!$('#'+this.sidemax.attr._d.side_m_id+'_'+_1).length &&(
				this.sidemax.attr.el.append('<div id="'+this.sidemax.attr._d.side_m_id+'_'+_1+'" class="sidemaxZone">'+this.sidemax.attr._d.side_m_id+'_  '+_1+'</div>')
			)
			;
			_el=$('#'+this.sidemax.attr._d.side_m_id+'_'+_1);
			_el.hasClass('iSkip') && _el.removeClass('iSkip');
			//$('#'+this.sidemax.attr._d.side_m_id+'_'+_1 div.sidemaxZone',
		//alert(this.sidemax.attr._d.side_m_id+' '+_1);
	}


}
;



$app.userbar_lukasu.sidemax.write=function() {
	!this.mather.iuserbar.attr.sidemax.el && this.mather.iuserbar.sidemax_creat();
	!this.attr.el &&(
		this.mather.iuserbar.attr.sidemax.el.prepend( codecoke.fn.getTmplate(this.attr.tmp_sidemax,this.attr._d))
	) &&(
		this.attr.el = $('#'+this.attr._d.side_m_id)
	)
	;
}

$app.userbar_lukasu.sideright.write=function() {
		//this.attr.sideright.el #ibar_side_right
		//this.attr.sideright.p_el #icon
		!this.mather.iuserbar.attr.sideright.el && this.mather.iuserbar.sideright_creat();
		!this.attr.el &&(
			this.mather.iuserbar.attr.sideright.el.prepend( codecoke.fn.getTmplate(this.attr.tmp_sideright,this.attr._d))
		)&&(
			this.attr.el = $('#'+this.attr._d.side_r_id)
		)
		;
		!this.mather.attr.userData.userguid && this.mather.getUserData();

		var _this =this;

		if (this.mather.attr.userData.userguid) {
			if (!$('dt',this.attr.el).length) {
				this.attr.el.append('<dt>订单管理</dt>')
				.append('<dd><a href="#" C3_hexCall="$app@userbar_lukasu.ck_go--orderlist">订单查看</a><a href="#" C3_hexCall="$app@userbar_lukasu.ck_go--orderadd">订单提交</a></dd>')
				;

				this.attr.el.append('<dt>用户管理</dt>')
				.append('<dd><a href="#" C3_hexCall="$app@userbar_lukasu.ck_go--userlist">用户查看</a><a href="#" C3_hexCall="$app@userbar_lukasu.ck_go--useradd">添加帐号</a></dd>')
				;
				//this.attr.el.html('<dt></dt><dd><ul><li>订单查看</li><li>订单订单提交</li></ul></dd>')


			}
			this.attr.el.removeClass('iSkip');
		}else {
			this.attr.el.addClass('iSkip');
		}


		//alert('111'+this.mather.iuserbar.attr.sideright.el.html());


		//alert(this.attr.tmp_sideright)


}

$app.userbar_lukasu.headtop.write=function() {
		!this.mather.iuserbar.attr.headtop.el && this.mather.iuserbar.headtop_creat();
		this.mather.getUserData();
			var _barstr=''
				,_constr=''
			if (this.mather.attr.userData.userguid) {
					_barstr = codecoke.fn.getTmplate(this.attr.tmpl_user_bar,this.attr._d,this.mather.attr.userData);
					_constr =codecoke.fn.getTmplate(this.attr.tmp_user_con,this.attr._d,this.mather.attr.userData);
					if ($('#'+this.attr._d.con_id)[0] && $('#'+this.attr._d.con_id).closest($('#'+this.mather.iuserbar.attr.headtop.con_id))) {
						$('#'+this.attr._d.con_id).html(_constr);
						//alert(this.attr._d.con_id+'\n'+this.mather.iuserbar.attr.headtop.con_id);
					}else {
						this.mather.iuserbar.attr.headtop.el_con.append('<div id="'+this.attr._d.con_id+'" class="iTopUserContentZone">'+_constr+'</div>')
					}
					this.mather.iuserbar.attr.headtop.el_bar.html(_barstr);
			}else {
				_barstr = codecoke.fn.getTmplate(this.attr.tmpl_guest_bar,this.attr._d);
				this.mather.iuserbar.attr.headtop.el_bar.html(_barstr);
				this.mather.iuserbar.attr.headtop.el_tool.empty();
				this.mather.iuserbar.attr.headtop.el_con.addClass('iSkip');
				$('div.iTopUserContentZone',this.mather.iuserbar.attr.headtop.el_con).remove();
			}
			this.mather.sideright.write();

};

$app.userbar_lukasu.signout=function() {
		var _this = this;
		_this.doc.jsload.get('json^$app@userbar_lukasu.signoutValue',function(_d) {
				_this.signoutValue='ok!!';
				_this.signinValue &&(delete _this.signinValue);
				//_this.attr.userData.userguid &&(delete _this.attr.userData.userguid)
				_this.doc.attr.cookie_hadchange=1;
				_this.headtop.write();
				//alert('hello!');
		});
};



$app.userbar_lukasu.sign_SendForm=function(_next) {
	var _f = this.doc.iform.checkIformInputs.apply(this.attr.F);
	if (!_f) {return;}
	var _this=this;
		_f.v._name = _f.v._name.replace(/[ ]{2,}/g,' ').toLowerCase();
	if (_f.v._name.indexOf('@')>-1 && !codecoke.is.Mail(_f.v._name)) {
			_f.el.red_warning.removeClass('iSkip').html('错误提示：邮箱名不正确'+_f.v._name);
			_f.n._name.attr('class','input_err').val((''+_f.v._name).replace(/\s+/g,''));
			return false;
	}
	_this.doc.jsload.get('doc@hex.md5',function() {
			_f.v._pwd16 =doc.hex.md5(_f.v._pwd,16);
			_f.v._pwd = doc.hex.md5(_f.v._pwd);
			_this.doc.jsload.get({
						'kstr':'json^$app@userbar_lukasu.signinValue'
						,'sendtype':'POST'
						,'cache':false
						//,'url':'gt='+_this.attr.servicename+'&v=0'
						,'itop':$app
						,'p':'userbar_lukasu'
						,'c':'signinValue'
						,'data':_f.v
						,'error':function(_err) {
							_f.el.red_warning.removeClass('iSkip').html(_err);
							_f.el.btn.removeAttr('disabled').text('提交');
						}
						,'beforeSend':function(_xhr) {
							_f.el.btn.attr('disabled','disabled').text('提交请求，处理中…');
						}
						,'fn':function(_d) {
							if (_d.err) {
								var _Ni = _d.err.indexOf('^');
								if (_d.err.indexOf('!!')==0) {
									_f.el.red_warning.removeClass('iSkip').html('错误提示：'+_d.err);
									_this.signinValue=_d;
									_f.el.btn.removeAttr('disabled').text('提交');
									return ;
								}
								if (_d.err.indexOf('#')==0) {
									var _elname = _d.err.substring(1,_Ni);
									_f.n[_elname] && _f.n[_elname].attr('class','input_err');
									_f.el.red_warning.removeClass('iSkip').html(_d.err.substring(_Ni+1));
									_f.el.btn.removeAttr('disabled').text('提交');
									return ;
								}
								_f.el.red_warning.removeClass('iSkip').html('错误提示：'+_d.err);
								_f.el.btn.removeAttr('disabled').text('提交');
								return ;
							}
							//_f.el.red_warning.removeClass('iSkip').html(''+_f.v._pwd);
							_this.signoutValue &&(delete _this.signoutValue);
							_this.doc.attr.cookie_hadchange=1;
							//_this.headtop.write();
							_next && _next();
							_f.fn.reset();
							_this.doc.UI.paper.winhide(_f.id);
							_f.el.btn.removeAttr('disabled').text('提交');

							//$('#myt4').html($app.userbar_lukasu.cookie.get('userkeystr')
							//	+'<br/>'+$app.userbar_lukasu.cookie.get('usernames')
							//	+'<br/>'+$app.userbar_lukasu.cookie.get('usersort')
							//);
						}

					});

	});
}
;

$app.userbar_lukasu.signin=function(_next) {
		!this.attr.iformO &&(this.attr.iformO={
						'id':'f_lukasu_sitesign'
						,'_class':''
						,'yellow_warning':'<p>填写邮箱或者用户名，以及登录密码</p><p>1个汉字等于2字符。邮箱只能包含中杠“-”、下划线“_”、英文字母“a-Z”、以及半角符号“.”</p>'
						,'about':'网站用户登录'
						,'buttontxt':'登录'
						,'inputs':[
							'<strong>邮箱 / 用户名</strong><input type="text" name="_name" minlength="2" maxlength="28" value="w@codecoke.com" />'
							,'<strong>帐号密码</strong><input type="password" name="_pwd" minlength="6" maxlength="24" value="i23456" />'
						]
		});
		var _this = this;
		if (!this.attr.F) {
				this.attr.F = this.doc.iform.get(codecoke.get.clone(this.attr.iformO));
				this.attr.F.el.btn.bind(
					'click'
					,codecoke.fn.bindFn(this,this.sign_SendForm, function(){_this.headtop.write();} )
				);
		}
		this.doc.UI.paper.add(this.attr.F.iform,'barshow','1');
}
;


//$('#myt4').html($app.userbar_lukasu.cookie.get('userkeystr')
//					+'<br/>'+$app.userbar_lukasu.cookie.get('usernames')
//					+'<br/>'+$app.userbar_lukasu.cookie.get('usersort')
//);

