<!--#include virtual='/codecoke_com/func/G_codecoke_0.asp' -->
<!--#include virtual='/codecoke_com/func/G_codecoke_fn_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_fns_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_insiteapi_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_cookie_action_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_ado_0.asp' -->



<%
codecoke.fn.newFunIn(GC,[['JSON','C_server_JSON']
	,['quest','C_server_request']
	,['query','C_server_querystring']
	,['iEscape','C_server_iEscape',codecoke.runnerSetting.f62,codecoke.runnerSetting.iEscapePublicKey]
]);

codecoke.fn.newFunIn(GC,'insiteapi','C_server_insiteapi');


G_localsetting.siteinfo={
		'attr':{
			'domain':'pds.955.me'
			,'name':'仙台营养中心'
			,'title':'仙台营养中心-订单系统'
			,'sitename_pk':'lukasu'
			,'miibeian':'京ICP备09077692号-1'
			,'createtime':'2010-1-2 8:0:0.0'
			,'ggSearchStr':'<form action="http://www.google.com.hk/cse" id="cse-search-box">	<div><input type="hidden" name="cx" value="partner-pub-4190233654185559:13u41v-pnts" /><input type="hidden" name="ie" value="UTF-8" /><span class="ggSearchTxt"><input type="text" name="q" size="45" /></span><span class="ggSearchBtn"><input type="submit" name="sa" value="&#x641c;&#x7d22;" /></span></div></form>'
			,'ggSearchSrc':'http://www.google.com.hk/cse/brand?form=cse-search-box&amp;lang=zh-Hans'
			,'lapiGo':'doc@ihead.setDocTitle||||doc@ihead.setDocLogo--/1.htm|在线订单管理||||$app@userbar_lukasu.go--headtop.write'
			,'iEscapeCookiekey':'tI7s2pwo0SLEmGdfh8bNBquaeW1ZgilMyjrOHQv6Vz4Tc3n5U9RXJCPYFDkKAx'
		}
		,'stop':{
			'all':0
		}
		,'cookiesetting':{
			'lukasu_sS':{
				'attr':{
					'name':'lukasu_Ss'
					,'path':'/'
					,'addtimetype':'d'
					,'addtimelength':120
					,'iEscapeCookiekey':'tI7s2pwo0SLEmGdfh8bNBquaeW1ZgilMyjrOHQv6Vz4Tc3n5U9RXJCPYFDkKAx'
					,'nameAttr':{
						'userkeystr':['K',2]
						,'usernames':['Um',2]
						,'usersort':['uS',2]
					}
				}
			}
		}
		,'gtpath':{
			'app':'/codecoke_com/insiteapi/apps_lukasu_0.asp'
		}
};

GC.insiteapi._get_siteinfo_values=function(_k) {
	if (_k=='siteinfo') {
		return GC.JSON.stringify(codecoke.get.inofObj(G_localsetting['siteinfo'],['attr','stop','cookiesetting','gtpath']));
	}

};

GC.insiteapi._get_siteinfo=function(_q) {
	var _r =this._get_siteinfo_values(_q.child||_q.parent);
	if (_q.readtype=='json') {
		Response.Contenttype='application/x-javascript';
		Response.Expires = -1;
		Response.AddHeader('Pragma','no-cache');
		Response.AddHeader('Cache-Control','no-cache');
		Response.Write(_r);
		Response.end();
		return false;
	}
	if (_q.readtype=='script') {
		Response.Contenttype='application/x-javascript';
		Response.Expires = -1;
		Response.AddHeader('Pragma','no-cache');
		Response.AddHeader('Cache-Control','no-cache');
		Response.Write('window.'+_q.itop+'.'+_q.parent+(_q.child ? '.'+_q.child :'')+'='+_r+';');
		Response.End();
		return false;

	}
};
GC.insiteapi._APP_userbar_lukasu_signoutValue=function() {
	!this.cookie && codecoke.fn.newFnCookie(this,'cookie',[G_localsetting.siteinfo.cookiesetting.lukasu_sS.attr]);
	this.cookie.clear();
	Response.Write('{"msg":"ok!!"}');
	Response.End();
	return;
};

GC.insiteapi._get_session_nameO=function() {
	if (!this.attr.sess) {
		this.attr.sess={
			'errName':G_localsetting.siteinfo.attr.sitename_pk+'_errcount'
			,'userName':G_localsetting.siteinfo.attr.sitename_pk+'_user'
			,'errMax':10
		}

	}

};

GC.insiteapi._APP_userbar_lukasu_signinValue=function() {
	//var _errSessionName =this.attr.serviceid+'_errcount';
	//var _userSessionName =this.attr.serviceid+'_user';
	this._get_session_nameO();
	var _errN =( Session.Contents(this.attr.sess.errName) || 0 )
		,_qsto ={ 'method':GC.quest.Q('agent_method') }
		,_sqlArr
		,_sql
		,_user={}
		,_r
	;

	if (_errN && _errN >= this.attr.sess.errMax) {
		return this.write('{"err":"!!登录尝试超过<strong class=\\"cBlack\\">'+this.attr.sess.errMax+'</strong> 次，拒绝请求。"}');
	}


	if (_qsto.method=='POST') {
		_qsto._name =Request.form.Item('_name').Item;
		_qsto._pwd = Request.form.Item('_pwd').Item;
	}else {
		_qsto._name = GC.query.str('_name')
		_qsto._pwd = GC.query.str('_pwd')
		//_qsto._pwd16 = GC.query.str('_pwd16')
	}

	if (!_qsto._name || _qsto._name.length<2 || _qsto._name.length>24) {
			return this.write('{"err":"#_name^邮箱 / 用户名错误！"}');
	}
	if (!_qsto._pwd || _qsto._pwd.length !==32 || !/^[a-z0-9]{32}$/.test(_qsto._pwd)) {
			return this.write('{"err":"#_pwd^密码错误！"}');

	}
	if (_qsto._name && _qsto._name.indexOf('@')>0) {
		if (!codecoke.is.Mail(_qsto._name)) {
			return this.write('{"err":"#_name^邮箱格式错误！"}');
		}else {
			_qsto._mail = ''+_qsto._name;
		}
	}

	!GC.ado &&  codecoke.fn.newFunIn(GC,'ado','C_server_ado',{
		'datalink':{
			'access':'/db/lks_0.accdb'
		}
	 });


	_sqlArr=[
			'userGuid','userName','userMail','userLevel','userLastSignTime','userAcPwd'
		]
		,_sql ='select top 1 ['+_sqlArr.join('],[')+'] from [lks_account_1] where [userPwd]=\''+_qsto._pwd+'\' and '
			+(
				_qsto._mail ? '[userMail]=\''+_qsto._mail+'\'' : '[userName]=\''+_qsto._name+'\''
		)
	;
	//var _user={};
	_r =GC.ado.connAccExe(_sql,'rowsarr');
	if (_r.icount) {
		_r.rows=_r.rows[0];
		_user.userGuid=_r.rows[0];
		_user.userName=_r.rows[1];
		_user.userMail=_r.rows[2];
		_user.userLevel=_r.rows[3]*1;
		_user.userLastSignTime=_r.rows[4];
		_user.userAcPwd=codecoke.get.guiden();
		//_user._r2 =
		GC.ado.connAccExe('UPDATE [lks_account_1] Set [userAcPwd]=\''+_user.userAcPwd+'\' , [userLastSignTime] =Now() Where [userGuid]=\''+_user.userGuid+'\'');

		!this.cookie && codecoke.fn.newFnCookie(this,'cookie',[G_localsetting.siteinfo.cookiesetting.lukasu_sS.attr]);
		this.cookie.set([
			['userkeystr',_user.userGuid+'.'+_user.userAcPwd]
			,['usernames',_user.userMail+'|||'+_user.userName]
			,['usersort','levels:'+_user.userLevel+'|||other:o_ther']
		]);
		_errN && Session.Contents.Remove(this.attr.sess.errName);
		Session.Contents(this.attr.sess.userName)={
			'userGuid':''+_user.userGuid
			,'userLevel':(_user.userLevel || 0 )*1
		};
		return this.write('{"msg":"ok!!"}');
	}
	_errN++;
	Session.Contents(this.attr.sess.errName)=_errN;
	return this.write('{"err":"账户及密码错误，请检查输入！你还可以尝试 <strong class=\\"cBlack\\">'+(this.attr.sess.errMax-_errN)+'</strong> 次！"}');


	/*
	7775757f5096fbd35b3e4df80cca1229 i23456
	|     userGuid      |       userCreatTime        |     userName      |     userMail      |      userPwd      |     userAcPwd     |     userLevel     |  userLastSignIp   |   userLockType    |     userAbout     |      userLog      | userLastSignTime  |

	UPDATE Person SET Address = 'Zhongshan 23', City = 'Nanjing'
WHERE LastName = 'Wilson'
	exec↓select↓drop↓alter↓exists↓union↓and↓or↓xor↓order↓mid↓asc↓execute↓xp_cmdshell↓insert↓update↓delete↓join↓declare↓char↓sp_oacreate↓wscript.shell↓xp_regwrite↓'↓;↓--↓/↓*"

	*/




	//this.cookie.clear();
	/*
	this.cookie.set([
		['userkeystr',codecoke.get.guiden()+'.'+codecoke.get.guiden()]
		,['usernames','w@codecoke.com|||莫 &!& 非 2']
		,['usersort','levels:999.9.1|||other:o_ther']
	]);
	*/
	//return this.write('{"err":"#_name^邮箱格式错误！"}');
	//return this.write(_user);

	//Response.Write(GC.JSON.stringify(_qsto))
	//Response.Write('{"msg":"ok!!"}');
	//Response.End();
	//return;
}
GC.insiteapi._APP_userbar_lukasu_signinValue2=function() {
	!this.cookie && codecoke.fn.newFnCookie(this,'cookie',[G_localsetting.siteinfo.cookiesetting.lukasu_sS.attr]);
	this.cookie.set([
		['userkeystr',codecoke.get.guiden()+'.'+codecoke.get.guiden()]
		,['usernames','w@codecoke.com|||莫 &!& 非 2']
		,['usersort','levels:999.9.1|||other:o_ther']
	]);
	return this.write('{"msg":"ok!!"}');



}
GC.insiteapi._get_apps=function(_q) {
	if (this.attr.qstr.file=='script^$app@userbar_lukasu.go') {
		return this.r302('/codecoke_com/agent/j/app_userbar_lukasu_0.js');
	}

	if (_q.child && _q.parent && this['_APP_'+_q.parent+'_'+_q.child]) {
		return this['_APP_'+_q.parent+'_'+_q.child](_q);
	}


	//Response.Write(GC.JSON.stringify(_q))


};



GC.insiteapi._gt_ckQuerystrFileOAndGo=function() {
	var _q = this._getAttr_qstrfileO_by_qstr_file();
	if (_q.itop=='$sev' && _q.parent =='siteinfo') {
		return this._get_siteinfo(_q)
	}
	if (_q.itop=='$app') {
		return this._get_apps(_q)
	}



};


GC.insiteapi.go('ckQuerystrFileOAndGo');


%>