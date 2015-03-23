<!--#include virtual='/codecoke_com/include.asp' -->

<%

codecoke.fn.newFunIn(GC,[
	['JSON','C_server_JSON']
	,['quest','C_server_request']
	,['query','C_server_querystring']
	,['iEscape','C_server_iEscape',codecoke.runnerSetting.f62,codecoke.runnerSetting.iEscapePublicKey]
	,['serverobj','C_server_serverobject']
]);
//codecoke.fn.newFunIn(GC,'serverobj','C_server_serverobject');

codecoke.fn.declareClass({
	'_basic_':{
		'name':'C_server_x3_usersign'
		,'fn':function(_o) {
			!this.attr && (this.attr={
				'cookieAttr':{
							'name':'codecoke_1'
							,'path':'/'
							,'addtimetype':'d'
							,'addtimelength':120
							,'checkKey':'userkeystr'
							,'nameAttr':{
								'userkeystr':['K',2]
								,'usernames':['Um',2]
								,'usersort':['uS',2]
							}
						}
				,'hasSessSionValue':0
				,'isCheckCount':0	// 0 初始化  1 已经运行过一次登录检测
				,'isCheckValue':0	// 0  guest  2 user , ,,404 拒绝服务
			});
			if (_o && codecoke.is.Obj(_o)) {
				_o.hasSessionValue &&(this.attr.hasSessionValue=_o.hasSessionValue);
				_o.cookieAttr &&(this.attr.cookieAttr=_o.cookieAttr);
				//_o.fn_readInfo &&(this.readInfo = _o.fn_readInfo);
			}
			!this.attr.sessionName && (this.attr.sessionName=this.attr.cookieAttr.name+'_ss');
			this.cookie=codecoke.fn.newFnCookie([this.attr.cookieAttr]);
			this._ini_();
		}
	}
	,'_ini_':function() {}
	,'_readSignInfo':function() {
		if (undefined!==this.attr.info) {
			return {'isCheckValue':this.isCheckValue,'info':this.attr.info}
		}
		// read pc cookie--->不支持cookie，跳转

		//usersession:
		if (Session.Contents.Item(this.attr.sessionName)) {
			var _info =codecoke.get._txt2obj_(''+Session.Contents.Item(this.attr.sessionName));

			if (codecoke.is.Obj(_info)) {
				this.attr.info= _info;
				this.isCheckValue= this.isCheckValue || 1;
			//if user cookie
			// 检查cookie===session，
			//不等--> write usercookie retrun {checkvalue ,attr.info}
			//相等-->retrun {checkvalue ,attr.info}
			}
			Response.Write(''+_info);
			return ;
			//this.attr.info=
		}

		Response.Write('_readSignInfo')

		//usercookie
		if (this.cookie.get(this.attr.cookieAttr.checkKey)) {
			Response.Write('<br>find cookie:'+this.cookie.get(this.attr.cookieAttr.checkKey)+'<br>');
			//Response.Write(this.cookie.get(this.attr.cookieAttr.checkKey))

		//连数据库-->登录
		//成功 写入session return {checkvalue ,attr.info} retrun {checkvalue ,attr.info}
		//失败 删除cookie

			return ;
		}

		Response.Write('<br>not usercookie :'+this.cookie.get(this.attr.cookieAttr.checkKey)+'<br>')
		//no session
		this.attr.info={};
		this.isCheckValue=0;
		return {'isCheckValue':this.isCheckValue,'info':this.attr.info};
		//this.readInfo();
		//Response.Write('<br/>notSession_by fn readSignInfo()')
	}
	,'getIsCheckCount':function() {
		/*先检测session，再检测cookie*/
		 if (this.attr.isCheckCount) {
			this.attr.isCheckCount +=1;
			return this.attr.isCheckCount;
		 }
		this._readSignInfo();
		this.attr.isCheckCount +=1;
		return this.attr.isCheckCount;
	}


});





/*
var _Server_userSign =function(_o) {
	!this.attr && (this.attr={
		'cookieAttr':{
					'name':'codecoke_1'
					,'path':'/'
					,'addtimetype':'d'
					,'addtimelength':120
					,'nameAttr':{
						'userkeystr':['K',2]
						,'usernames':['Um',2]
						,'usersort':['uS',2]
					}
				}
		,'hasSessSionValue':0
		,'isCheckCount':0	// 0 初始化  1 已经运行过一次登录检测
		,'isCheckValue':0	// 0  guest  2 user , ,,404 拒绝服务
	});
	if (_o && codecoke.is.Obj(_o)) {
		_o.hasSessionValue &&(this.attr.hasSessionValue=_o.hasSessionValue);
		_o.cookieAttr &&(this.attr.cookieAttr=_o.cookieAttr);
		//_o.fn_readInfo &&(this.readInfo = _o.fn_readInfo);
	}
	!this.attr.sessionName && (this.attr.sessionName=this.attr.cookieAttr.name+'_ss');
	this.cookie=codecoke.fn.newFnCookie([this.attr.cookieAttr]);
	this._ini_();
};

_mainDeclare.prototype._ini_=function() {};

_mainDeclare.prototype._readSignInfo=function() {
	if (undefined!==this.attr.info) {
		return {'isCheckValue':this.isCheckValue,'info':this.attr.info}
	}
	// read pc cookie--->不支持cookie，跳转

	//usersession:
	if (Session.Contents.Item(this.attr.sessionName)) {
		var _info =codecoke.get._txt2obj_(''+Session.Contents.Item(this.attr.sessionName));

		if (codecoke.is.Obj(_info)) {
			this.attr.info= _info;
			this.isCheckValue= this.isCheckValue || 1;



			//if user cookie
			// 检查cookie===session，
			//不等--> write usercookie retrun {checkvalue ,attr.info}
			//相等-->retrun {checkvalue ,attr.info}

		}


		Response.Write(''+_info);
		return ;
		//this.attr.info=

	}

	Response.Write('_readSignInfo')
	//usercookie
	if (this.cookie.get('userkeystr')) {
		Response.Write(this.cookie.get('userkeystr'))

		//连数据库-->登录
		//成功 写入session return {checkvalue ,attr.info} retrun {checkvalue ,attr.info}
		//失败 删除cookie


	}

	this.attr.info={};
	this.isCheckValue=0;
	return {'isCheckValue':this.isCheckValue,'info':this.attr.info};


	/*

	if (Session.Contents.Item(this.attr.sessionName)) {
		//Response.Write('_readSignInfo')
		//this.readInfo('session',codecoke.get.clone(Session.Contents.Item(this.attr.sessionName)));

		//if (not cookie) {} set cookie
	}else {

		//if (not cookie) {} set hadCheckValue
	}
	*/


	//this.readInfo();
	//Response.Write('<br/>notSession_by fn readSignInfo()')

/*

};

_mainDeclare.prototype.;

_mainDeclare.prototype.go =function() {
	//Response.Write(undefined===Session.Contents.Item("Key"))
	//Response.Write(this.getIsCheckCount())
	//Response.Write(this.getIsCheckCount())
	Response.Write('getIsCheckCount :'+this.getIsCheckCount())

};
*/

var _o1 ={
	'cookieAttr':{
					'name':'xq3_su'
					,'path':'/'
					,'addtimetype':'d'
					,'addtimelength':120
					,'checkKey':'userkeystr'
					,'nameAttr':{
						'userkeystr':['K',2]
						,'usernames':['Um',2]
						,'usersort':['uS',2]
					}
	}
	,'fn_readInfo':function() {
		Response.Write('fn readinfo()'+this.attr.cookieAttr.name)
	}
}
;

var _main={};
var _nav ='<a href="/">home</a>'
			+' | <a href="/?tp=serverQuest">serverQuestInfo</a>'
			+' | <a href="/cookie.asp">cookie</a>'
			+' | <a href="/ado.asp">ado</a>'
			+' | <a href="xq3_sign.asp">xq3-sign</a>'
			+'<br/> xq3-sign :'
			+' | <a href="/xq3_sign.asp?tp=writecookie">writecookie</a>'
			+' | <a href="/xq3_sign.asp?tp=movecookie">movecookie</a>'
			+'<hr/>'
	;
var _tp = GC.query.str('tp');
codecoke.fn.newFunIn(_main,'x3_usersign','C_server_x3_usersign',_o1)

Response.Write(_nav);

if ('writecookie'==_tp) {
	Response.Write(_tp+'<br>')
	_main.x3_usersign.cookie.set([
		['userkeystr',codecoke.get.guiden()+'.'+codecoke.get.guiden()]
		,['usernames','w@codecoke.com|||莫 &!& 非 2']
		,['usersort','levels:999.9.1|||other:o_ther']
	]);
	Response.Write(_main.x3_usersign.cookie.get('userkeystr'));
}

if ('movecookie'==_tp) {
	_main.x3_usersign.cookie.clear();
}


//Response.Write(_main.x3_usersign.attr.isCheckCount)
Response.Write(_main.x3_usersign.getIsCheckCount())

//var _main = new _mainDeclare(_o1);



//_main.go();

//*/
 //Response.Write(_main.attr)


 /*

var _cookiesetting={
			'lukasu_sS':{
				'attr':{
					'name':'lukasu_Ss'
					,'path':'/'
					,'addtimetype':'d'
					,'addtimelength':120
					,'nameAttr':{
						'userkeystr':['K',2]
						,'usernames':['Um',2]
						,'usersort':['uS',2]
					}
				}
			}
};


//nameAttr : 数组[ cookieChildName,加密方式：==1？GC.iEscape.uni 其他 GC.iEscape.un
// GC.iEscape.uni 尾巴带key，un公用key

var _t1=codecoke.fn.newFnCookie([
		_cookiesetting.lukasu_sS.attr
	]);

//_t1.readstr();
_t1.set([
		['userkeystr',codecoke.get.guiden()+'.'+codecoke.get.guiden()]
		,['usernames','w@codecoke.com|||莫 &!& 非 2']
		,['usersort','levels:999.9.1|||other:o_ther']
	]);

Response.Write('<br/>userkeystr: '+_t1.get('userkeystr')+'<br/>'+_t1._cookiesValuesString+'<br/>')
Response.Write('<br/>usernames: '+_t1.get('usernames')+'<br/>')
Response.Write('<br/>iEscapeCookiekey: '+_t1.attr.iEscapeCookiekey+'<br/>')
Response.Write(_t1.icookie.attr.name+'<hr/>')
*/





%>