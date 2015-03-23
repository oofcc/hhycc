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


var _mainDeclare =function() {
	!this.attr && (this.attr={
		'cookieAttr':{
					'name':'xq3_su'
					,'path':'/'
					,'addtimetype':'d'
					,'addtimelength':120
					,'nameAttr':{
						'userkeystr':['K',2]
						,'usernames':['Um',2]
						,'usersort':['uS',2]
					}
				}
		,'isUserSginCheck':0	// 0 初始化  1 已经运行过一次登录检测
		,'userCheckValue':0	// 0 guest  1 user , ,,404 拒绝服务
	});
	this._ini_();
	this.cookie=codecoke.fn.newFnCookie([
		this.attr.cookieAttr
	])
};
_mainDeclare.prototype._ini_=function() {
};
_mainDeclare.prototype._getUserSession=function() {


};

_mainDeclare.prototype._checkUserSign=function() {
	/*
	先检测session，再检测cookie，


	*/
	 if (this.attr.isUserSginCheck) {return this.attr.isUserSginCheck;};




	 return this.attr.userCheckValue;
};

_mainDeclare.prototype.go =function() {
	Response.Write(this._checkUserSign()+'hello world!')

};


var _main = new _mainDeclare();
_main.go();


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