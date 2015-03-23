<% @ LANGUAGE=JScript CODEPAGE=65001 %>
<%
Server.ScriptTimeout=10000;
Response.Charset='utf-8';
Response.Buffer = true;

var _iEscape=function(_f62,_k){
	this.attr={'s':_f62,'k':_k,'ka':_f62.split('')};
	!this.attr.k &&(this.attr.k=this.gk());
}
;
_iEscape.prototype={
	'_Di':function(_n,_arr,K){_arr[_arr.length]=(K||this.attr.k).charAt(_n);}
	,'_Ui':function(_y,s,K){return(K||this.attr.k).indexOf(s.charAt(_y));}
	,'gk':function(){return this.attr.ka.sort(function(){return(Math.random()<0.5)?1:-1;}).join('');}
	,'de':function(_str,K){var nl=_str.length,_arr=[],a,b,c,x,N2=62*62,N5=62*5;for(x=0;x<nl;x++){a=_str.charCodeAt(x);a<N5?(this._Di(Math.floor(a/62),_arr,K),this._Di(a%62,_arr,K)):(this._Di(Math.floor(a/N2)+5,_arr,K),this._Di(Math.floor(a/62)%62,_arr,K),this._Di(a%62,_arr,K));}b=_arr.join('');c=b.length;return(String(c).length+String(c)+b);}
	,'dei':function(_str,_k){var K=_k||this.gk();return this.de(_str,K)+K;}
	,'un':function(_str,K){var c=_str.charAt(0)*1;if(isNaN(c)){return'';}c=_str.substr(1,c)*1;if(isNaN(c)){return'';}var nl=_str.length,_arr=[],a,f,b,x=String(c).length+1;if(nl!=x+c){return''}while(x<nl){a=this._Ui(x++,_str,K);f=(a<5)?(a*62+this._Ui(x,_str,K)):((a-5)*62*62+this._Ui(x,_str,K)*62+this._Ui(x+=1,_str,K));_arr[_arr.length]=String.fromCharCode(f);x++;}return _arr.join('');}
	,'uni':function(_str){if(!_str){return'';}var _l=_str.length-62;if(_l<1){return this.un(_str);}return this.un(_str.substring(0,_l),_str.substring(_l));}
}
;

var _ado =function(_o) {
	this.attr={
		'datalink_pk':{

			'mssql':'Driver={SQL Server};Provider=SQLNCLI10MarsConn=True;DataTypeCompatibility=80;' //;uid=sa;pwd=i23456;Database=j_orz_asia;addr={127.0.0.1,1433};
			,'access':'Provider=Microsoft.ACE.OLEDB.12.0; persist security info=false; data source=' //+Server.MapPath('data/data.mdb')
			//,'access':'Provider=Microsoft.Jet.OLEDB.4.0; persist security info=false; data source=' //+Server.MapPath('data/data.mdb')
		}
		,'rowssplitstr':'яЯ'
	}
	if (_o && _o.datalink) {
		_o.datalink.access && ( this.attr.datalink_access = this.attr.datalink_pk.access+Server.MapPath(_o.datalink.access));
		_o.datalink.mssql && ( this.attr.datalink_mssql = this.attr.datalink_pk.mssql+_o.datalink.mssql+';') ;

	}

};
_ado.prototype.creat=function(_oname) {


};
_ado.prototype.creatConn=function(_oname) {
	!this.conn && (this.conn= Server.CreateObject('ADODB.Connection'));

};
_ado.prototype.creatRcd=function(_oname) {
	!this.conn && (this.conn= Server.CreateObject('Adodb.Recordset'));
	//Adodb.Recordset

};

_ado.prototype.close=function (_ostr) {
	if('conn'==_ostr) {
		this.conn && this.conn.State && this.conn.State>0 && this.conn.Close();
		this.conn =null;
		return true;
	}else	if('cmd'==_ostr) {
		 this.cmd && this.cmd.State && this.cmd.State>0 && this.cmd.Close();
		this.cmd =null;
		return true;
	}else{
		if(this.conn && this.conn.State && this.conn.State>0) this.conn.Close();
		this.conn =null;
		if(this.cmd && this.cmd.State && this.cmd.State>0) this.cmd.Close();
		this.cmd =null;
		return true;
	}
};
_ado.prototype._getDateConnStr=function(_dtype,_dlink) {
	if (!_dtype) {return this.attr.datalink_access}
	if (!_dlink) { return 'access'==_dtype ? this.attr.datalink_access : this.attr.datalink_mssql;}
	return 'access'==_dtype ? this.attr.datalink_pk.access+Server.MapPath(_dlink) :  this.attr.datalink_pk.mssql + _dlink ;

}
;
_ado.prototype.connAccExe =function(_sql,_type,_datalink) {
	return this._connExecute({
		'sql':_sql
		,'type':_type
		,'datalink':_datalink
		,'datatype':'access'
	});
}
;
_ado.prototype._connExecute=function(_o) {
	if (!_o || !_o.sql) {return {'err':'err_connExecute:_need_o.sql_sql sucore_'};}
	var _r ={};
	var _connstr =this._getDateConnStr(_o.datatype,_o.datalink);
	if (!_connstr) {return {'err':'err_connExecute:_need_Connection_string_'};}
	// e.number 。_-2147467259 数据库不可写
	if (_o.type) {
		if ('rowsarr'==_o.type) {
			try {
				this.creatConn();this.conn.Open(_connstr);
				var _rcd = this.conn.Execute(_o.sql,1,1);
				if( _rcd.State>0 && !_rcd.EOF ) {
					_r.rows =_rcd.GetString(
						2,-1
						,this.attr.rowssplitstr+'\'\''+this.attr.rowssplitstr
						,this.attr.rowssplitstr+'\'\'\''+this.attr.rowssplitstr
						,'null'
					).split(this.attr.rowssplitstr+'\'\'\''+this.attr.rowssplitstr)
					;
					_r.icount=_r.rows.length = _r.rows.length-1
					for (var _i=0;_i<_r.icount;_i++){_r.rows[_i]=_r.rows[_i].split(this.attr.rowssplitstr+'\'\''+this.attr.rowssplitstr);}
				}else {
					_r.rows=[];
					_r.rcount=0;
				}
				 _rcd.close(); _rcd=null;

			}catch (e) {
				_r.err=('err_connExecute:_rows_'+e.description+'_'+(e.number||'')).replace(/\'/g,'\\\'');
			}finally{
				this.close('conn');
			}
			return _r;
		}
		_r.err='err_connExecute:_need_o.type_ExecuteType_';
		return _r;
	}
	try {
		this.creatConn();
		this.conn.Open(_connstr);
		this.conn.Execute(_o.sql,1,128);
		_r.msg = 'msg_ok!!'
	}catch (e) {
		_r.err =('err_connExecute:_ExeDo_'+e.description+'_'+(e.number||'')).replace(/\'/g,'\\\'');
	}finally{
		this.close('conn');
	}

	return _r;
}
;
var sev_fn={}
;
var _sevo =function(_o) {
	this.attr={
		'headkey':(_o && _o.quest && _o.quest.headkey? _o.quest.headkey :'lukasu520zxrj')
		,'headvalue':_o.quest.headvalue
	};
	this.settO = _o.settO;
	this.localsettO = _o.localsettO;
	this.iEscape = new _iEscape(_o.quest.f62);
	sev_fn.ado=new _ado({
		'datalink':this.localsettO.database.datalink

	})
	;
	this.getQuestO();

};
_sevo.prototype.creatGuid=function(_o) {
	var _str ='',_sp =(_o && 35<_o)? '-' :'';
	for(var _i = 0; _i < 31; _i++) {
		_str +=''+ Math.floor(Math.random() * 0xF).toString(0xF) + (_i == 6 || _i == 10 || _i == 14 || _i == 18 ? _sp :'');
	}
	return (_sp && 37<_o)
		? '{'+['A','B','C','D','E','F','G','H','J','K'][Math.floor(Math.random() *10)] +_str.toUpperCase() +'}'
		: ['A','B','C','D','E','F','G','H','J','K'][Math.floor(Math.random() *10)]+''+ _str.toUpperCase()
	;
}
;
_sevo.prototype.is=function(_n,_v) {
	if (!_n) {return false;}
	var _r =false;
	switch (_n) {
		case('fun') :
			_r = ((typeof(_v)==='function')||(typeof(_v)==='object' && Object.prototype.toString.apply(_v) === '[object Function]'));
		break;
		case('str') :
			_r = (typeof(_v) === 'string'||(typeof(_v)==='object' && Object.prototype.toString.apply(_v) === '[object String]'));
		break;
		case('null'):
			_r =(_v===null); break;
		case('undefined'):
			_r =(typeof _v === 'undefined'); break;
		case('arr'):
			_r =(_v && typeof(_v)==='object' && Object.prototype.toString.apply(_v) === '[object Array]');
		break;
		case('boolean'):
			_r =(typeof(_v)==='boolean'||(typeof(_v)==='object' && Object.prototype.toString.apply(_v) === '[object Boolean]') );
		break;
		case('date'):
			_r =(typeof(_v)==='object' && Object.prototype.toString.apply(_v) === '[object Date]');
		break;
		case('handphone'):
			_r =( _v && /^1[3|5|8][0-9]{9}$/.test((''+_v)) );
		break;
		case('obj'):
			_r =(typeof(_v)==='object' && _v !==null && Object.prototype.toString.apply(_v) === '[object Object]');
		break;
		case('regexp'):
			_r = (typeof(_v)==='object' && Object.prototype.toString.apply(_v) === '[object RegExp]');
		break;
		case('emptyobj'):
			for (var _a in _v) {
				if(_v.hasOwnProperty(_a)){
					_r=false;
					break;
				}
			}
			_r =true;
		break;
		case ('mail'):
			_r =(
				_v
				&& (typeof(_v)==='string')
				&& (_v.indexOf('@')>0)
				&&
				/^[a-z0-9]{1,}(?:[\.\_\-]{0,1}[a-z0-9]{1,})?(?:[\.\_\-]{0,1}[a-z0-9]{1,})?\@[a-z0-9]{1,}(?:[a-z0-9]{0,8}[\-]{0,1}(?:[a-z0-9]{1,}\.[a-z0-9]{2,4})?[a-z0-9]{0,8})?\.[a-z]{2,4}$/i.test(a)
			);
		break;


	}
	return _r;

};
_sevo.prototype.getQuestO=function() {
	if (!this.attr.quest) {this.attr.quest={};}


	var _questAttrO={
		'webdomain':'SERVER_NAME'
		,'comeurl':'HTTP_REFERER'
		,'method':'Request_Method'
		,'webdir':'APPL_PHYSICAL_PATH'
		//,'headvalue':'HTTP_'+this.attr.headkey
		//,'mamaHeadValue':'HTTP_'+this.settO.mamaHeadName+'zzz'
		,'mamaHeadKey':'HTTP_'+this.settO.mamaHeadName
		,'mamaHeadValue':'HTTP_'+this.settO.mamaHeadName+'2011'
		,'useragent':'HTTP_USER_AGENT'
	};
	for (var _a in _questAttrO) {if( _questAttrO.hasOwnProperty(_a)){
		var _v = Request.ServerVariables.Item(_questAttrO[_a]).Item();
		if (undefined !== _v) {this.attr.quest[_a]= _v;}
	}}
	//this.attr.quest.comeurl && (this.attr.quest.comeurl =(''+this.attr.quest.comeurl).toLowerCase());

	if (this.attr.quest.comeurl) {
		var _u =(''+this.attr.quest.comeurl).toLowerCase();
		this.attr.quest.comeurl =_u;
		if (_u.length>10 && _u.substring(0,7)=='http://') {
			_u = (_u.substring(7));
			_u =_u.indexOf('/')>0 ? _u.substr(0,_u.indexOf('/')) :_u ;
			this.attr.quest.comedomain=_u;
		}else {
			delete this.attr.quest.comeurl;
		}
	}
	this.attr.quest.ips =(
		Request.ServerVariables.Item('REMOTE_ADDR').Item()
		|| Request.ServerVariables.Item('HTTP_X_FORWARDED_FOR').Item()
		|| Request.ServerVariables.Item('HTTP_VIA').Item()
		|| '000.0.0.0'
	).match(/((([0-9]{1,3})\.[0-9]{1,3})\.[0-9]{1,3})\.[0-9]{1,3}/)
	;
	this.attr.quest.ip = this.attr.quest.ips[0];
	this.attr.quest.ipc = this.attr.quest.ips[1];
	this.attr.quest.ipb = this.attr.quest.ips[2];
	this.attr.quest.ipa = this.attr.quest.ips[3];
	this.attr.quest.q= this.query('q');
	this.attr.quest.v = this.query('v');
	this.attr.quest.v = (this.attr.quest.v && /^[0-9]{1,2}$/.test(''+this.attr.quest.v)) ? 1*this.attr.quest.v : 0;

/*
this._questData['web_rootdomain']=this._questData['web_domain'].match(/(?:(?:[a-z0-9]{1,29}\-[a-z0-9]{1,29}|[a-z0-9]{1,26}\-[a-z0-9]{1,26}\-[a-z0-9]{1,26})|[a-z0-9]{1,32})\.(?:[a-z]{2,3}\.[a-z]{2,3}|[a-z]{2,4})$/)[0];

*/

	//this.attr.quest.v && GC.is.Num(1*_v) && (this.attr.quest.v = 1*_v);
}
;

_sevo.prototype.query=function(_n) {
	if (!_n || !Request.QueryString.Count ) {return null;}
	var _v =Request.QueryString.Item(_n).Item();
	if (undefined===_v) {return null}
	_v =(''+_v).replace(/^[\s\t ]+|[\s\t ]+$/g,'');
	return _v.length >0 ?  _v : null;
	//undefined==Request.QueryString.Item('f1').Item()

}
;

_sevo.prototype.r404=function() {
	Response.status='404 page not fund';
	//Response.status=404;
	Response.Flush();
	Response.End();
	return false;
}
;
_sevo.prototype.pd_insert =function(_qstr,_pdO,_insertO) {
	var _qstrArr =_qstr.split('|')
	,_sel = this.query('pd_sel')
	,_selO
	,_qstrO={}
	,_insertSqlO
	,_insertNameArr=[]
	,_insertValueArr=[]
	,_insertSqlStr
	;
	_sel = _sel && /^[0-9]$/.test(''+_sel) ? _sel*1 :0;
	if (_pdO.pdArr[_sel]) {
		_selO = _pdO.pdArr[_sel];
	}else {
		_selO = _pdO.pdArr[0];
		_sel=0;
	}
	for (var _i=0,_x=_qstrArr.length; _i<_x; _i++) {
		_qstrArr[_i]=_qstrArr[_i].split(':') ;
		if (undefined!=_qstrArr[_i][1]) {
			_qstrO[_qstrArr[_i][0]]=(''+_qstrArr[_i][1]).replace(/\'+/g,'`');
		}
	}
	_insertSqlO={
		//'pd_Id':this.creatGuid()
		'pd_sel':_sel
		,'pd_price':_selO.pd_price
		,'pd_type':(_qstrO['pd_type'] || 1)*1
		,'pd_songType':(_qstrO['pd_songType'] || 1)*1
		,'pd_saleNum':_selO.pd_saleNum
		,'pd_songNum':_selO.pd_songNum
		,'pd_userName':_qstrO['pd_user']
		,'pd_userTel':_qstrO['pd_tel']
		,'pd_userHandTel':_qstrO['pd_htel']
		,'pd_userAddr':_qstrO['pd_addr']
		,'pd_userIp':_qstrO['pd_userIp']
		,'pd_userSay':_qstrO['pd_say']
		,'pd_userQqIp':_qstrO['pd_userQqIp']
		,'pd_userQqAddr':_qstrO['pd_userQqAddr']
		,'pd_webDomain':_qstrO['pd_webdomain']
		,'pd_webInfo':_qstrO['pd_webInfo']
		,'pd_sendUserGuid':_qstrO['pd_sendUserGuid']
		,'pd_sendUserName':_qstrO['pd_sendUserName']
	}
	;
	_insertSqlO.pd_buyPrice =_pdO.attr.pd_buyPrice;
	_insertSqlO.pd_songBuyPrice =_pdO.attr.pd_songBuyPrice;

	if (_insertO) {
		for (var _b in _insertO) {if( _insertO.hasOwnProperty(_b) && undefined !=_insertO[_b]){
			_insertSqlO[_b]=_insertO[_b];
		}}
	}
	for (var _a in _insertSqlO) {if( _insertSqlO.hasOwnProperty(_a)){
		if (undefined==_insertSqlO[_a]) {
			continue;
		}
		_insertNameArr.push('['+_a+']')
		if (
			typeof(_insertSqlO[_a])==='number'
			&& Object.prototype.toString.apply(_insertSqlO[_a]) === '[object Number]'
		){
			_insertValueArr.push(_insertSqlO[_a]);
		}else {
			_insertValueArr.push('"'+_insertSqlO[_a].substring(0,50)+'"');
		}
	}}
	//return _insertSqlStr;
	return sev_fn.ado.connAccExe(
		'INSERT INTO ['+this.localsettO.database.table.pdlist+'] ('+_insertNameArr.join(',')+') VALUES ('+_insertValueArr.join(',')+')'
	);
};

_sevo.prototype.q_sendOrder =function() {
	if (
		!this.attr.quest.mamaHeadKey
		|| !this.attr.quest.mamaHeadValue
		|| this.settO.mamaHeadValue !== this.iEscape.un(this.attr.quest.mamaHeadValue,this.attr.quest.mamaHeadKey)
	) {return this.r404();}
	var _pdV = this.query('pdVals'),_pd_listI =this.query('pd_listI'),_r;
	_pd_listI = _pd_listI && /^[0-9]$/.test(''+_pd_listI)
		&& this.localsettO.pdsettArr[_pd_listI] ? _pd_listI*1 : 0
	;
	_pdV &&(_pdV = this.iEscape.un(_pdV,this.attr.quest.mamaHeadKey));
	if (!_pdV) {return this.r404();}

	var _pd_guid =this.creatGuid();

	_r =this.pd_insert(
		_pdV
		,this.localsettO.pdsettArr[_pd_listI]
		,{
			'pd_Id':_pd_guid
			,'pd_proxyIp':this.attr.quest.ip
			,'pd_proxyDomain':Request.ServerVariables.Item('HTTP_pd_proxyDomain').Item()
			,'pd_listI':_pd_listI
		}
	)
	;
	Response.Write(_r.msg ? _r.msg+''+_pd_guid : _r.err);
	Response.End()

}

_sevo.prototype.Go=function(_n) {
	if (_n) {
		if (this.is('fun',_n)) {
			return _n();
		}
		if (this[_n] && this.is('fun',this[_n])) {
			return this[_n]();
		}
		return this.r404();
	}

	if (this.attr.quest.q && this['q_'+this.attr.quest.q] && this.is('fun',this['q_'+this.attr.quest.q]) ) {
		return this['q_'+this.attr.quest.q]();
	}

	return this.r404();
	//else {
	//	this.QueryGo();
	//}
	//this.debug();
}
;
_sevo.prototype.debug=function() {
	var _s='' ;
	for (var _a in this.attr.quest) {if( this.attr.quest.hasOwnProperty(_a)){
		_s += _a+': '+this.attr.quest[_a]+'<br/>';
	}}
	Response.Write(_s);

};

var _setting={
	'quest':{
		'headkey':'L1I-lukasu520zxrj'
		,'headvalue':'E599704108234556E310293468827A94'
		,'f62':'Az0yBx1wCv2uD3rEt4sFqGpHoInJmKiLlMkNjOgPhQfRdSbcTaU9V8W7X6Y5Ze'
	}
	,'settO':{
		'tel400':'400-123-8887'
		,'gaid':'UA-283516-23'
		,'kf53':'http://chat.53kf.com/kf.php?arg=zhongyian'
		,'public62k':'Yhey69xR8rA5lDTPWnEdH1s73JmkXqM4NvSQoKUcBag20uIfVOFGZptLCwbjiz'
		,'mamaHeadValue':'F4A6E0AAA425470EDB936BD093EDCB1D'
		,'mamaHeadName':'ma-lksF1I0O-2'
		,'sunHeadName':'L1I-lukasu520zxrj'
		,'pdlistArr':[
			'露卡素左旋肉碱__左旋360减肥咖啡__218__45__1----'
			+'A__轻松体验装__0__1__198__约15天量 适合想减8斤左右的人士__效果明显体现在腰腹部,再来就是臀部与大腿和手臂。'
			+'--'
			+'B__基础减肥装__1__2__288__约45天量 适合想减20斤左右的人士__效果明显体现在腰腹部、臀部、大腿，脸和手都有明显的效果，对于体重不是特别超标的人，体形缩小一个号。'
			+'--'
			+'C__减肥效果装__1__4__368__约2个月量 适合想减25斤左右的人士__效果特别明显，几乎所有人都可以减重达到25斤左右。'
			+'--'
			+'D__减肥加强装__2__6__568__约3个月量 适合想减30斤左右的人士__整体的效果都特别明显，视个体差异，体重超标越大此套餐减重越多，产品服完后就要开始换掉所有的衣服。'
			+'--'
			+'E__减肥巩固装__2__8__668__约4个月量 适合想减45斤左右的人士__效果特别明显，产品服完后就要开始换掉所有的衣服，强效巩固，效果非常完美。'
			+'--'
			+'F__强效巩固装__4__8__768__约4个月量 适合想减50斤左右的人士__整体的效果都特别明显，视个体差异，体重超标越大此套餐减重越多，产品服完后就要开始换掉所有的衣服。'
		]

	}
	,'localsettO':{
		'kf53query':'&style=3'
		,'database':{
			'datalink':{
				'access':'/db/lks_0.accdb'
				,'mssql':'uid=sa;pwd=i23456;Database=j_orz_asia;addr={127.0.0.1,1433}'
			}
			,'table':{
				'pdlist':'lks_pdorder_1'
			}
		}
		,'pdsettArr':[
			{
				'attr':{
					'pd_name':'露卡素左旋肉碱'
					,'pd_songName':'360左旋咖啡'
					,'pd_buyPrice':7
					,'pd_songBuyPrice':8
				}
				,'pdArr':[
					{'pd_price':198 ,'pd_saleNum':1 ,'pd_songNum':0,'pd_en':'A'}
					,{'pd_price':288 ,'pd_saleNum':2 ,'pd_songNum':1,'pd_en':'B'}
					,{'pd_price':368 ,'pd_saleNum':4 ,'pd_songNum':1,'pd_en':'C'}
					,{'pd_price':568 ,'pd_saleNum':6 ,'pd_songNum':2,'pd_en':'D'}
					,{'pd_price':668 ,'pd_saleNum':8 ,'pd_songNum':2,'pd_en':'E'}
					,{'pd_price':768 ,'pd_saleNum':8 ,'pd_songNum':4,'pd_en':'F'}
				]
			}
		]
	}
}
;
var _sev = new _sevo(_setting);
_sev.Go();






%>