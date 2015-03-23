<% @ LANGUAGE=JScript CODEPAGE=65001 %>
<%
Server.ScriptTimeout=10000;
Response.Charset='utf-8';
Response.Buffer = false;



var _hex=function(){this.attr={'hexcase':0,'b64pad':''};};_hex.prototype={'md5':function(s,l){return l?this.hex_md5(s).substr(8,16):this.hex_md5(s);},'md5go':function(s,l){alert(this.md5('hi'));},'hex_md5':function(s){return this.rstr2hex(this.rstr_md5(this.str2rstr_utf8(s)));},'rstr2hex':function(_str){var hex_tab=this.attr&&this.attr.hexcase?'0123456789ABCDEF':'0123456789abcdef';var output='';var x;var _z=_str.length;for(var i=0;i<_z;i++){x=_str.charCodeAt(i);output+=hex_tab.charAt((x>>>4)&0x0F)+hex_tab.charAt(x&0x0F);}return output;},'rstr_md5':function(s){return this.binl2rstr(this.binl_md5(this.rstr2binl(s),s.length*8));},'binl2rstr':function(_str){var output='';var i=0;var _z=_str.length*32;for(;i<_z;i+=8){output+=String.fromCharCode((_str[i>>5]>>>(i%32))&0xFF);}return output;},'rstr2binl':function(_str){var output=Array(_str.length>>2);for(var i=0;i<output.length;i++)output[i]=0;for(var i=0;i<_str.length*8;i+=8)output[i>>5]|=(_str.charCodeAt(i/8)&0xFF)<<(i%32);return output;},'str2rstr_utf8':function(_str){var _r='',i=-1,x,y,_z=_str.length;while(++i<_z){x=_str.charCodeAt(i);y=i+1<_str.length?_str.charCodeAt(i+1):0;if(0xD800<=x&&x<=0xDBFF&&0xDC00<=y&&y<=0xDFFF){x=0x10000+((x&0x03FF)<<10)+(y&0x03FF);i++;}if(x<=0x7F)_r+=String.fromCharCode(x);else if(x<=0x7FF)_r+=String.fromCharCode(0xC0|((x>>>6)&0x1F),0x80|(x&0x3F));else if(x<=0xFFFF)_r+=String.fromCharCode(0xE0|((x>>>12)&0x0F),0x80|((x>>>6)&0x3F),0x80|(x&0x3F));else if(x<=0x1FFFFF)_r+=String.fromCharCode(0xF0|((x>>>18)&0x07),0x80|((x>>>12)&0x3F),0x80|((x>>>6)&0x3F),0x80|(x&0x3F));}return _r;},'binl_md5':function(x,len){x[len>>5]|=0x80<<((len)%32);x[(((len+64)>>>9)<<4)+14]=len;var a=1732584193;var b=-271733879;var c=-1732584194;var d=271733878;for(var i=0;i<x.length;i+=16){var olda=a;var oldb=b;var oldc=c;var oldd=d;a=this.md5_ff(a,b,c,d,x[i+0],7,-680876936);d=this.md5_ff(d,a,b,c,x[i+1],12,-389564586);c=this.md5_ff(c,d,a,b,x[i+2],17,606105819);b=this.md5_ff(b,c,d,a,x[i+3],22,-1044525330);a=this.md5_ff(a,b,c,d,x[i+4],7,-176418897);d=this.md5_ff(d,a,b,c,x[i+5],12,1200080426);c=this.md5_ff(c,d,a,b,x[i+6],17,-1473231341);b=this.md5_ff(b,c,d,a,x[i+7],22,-45705983);a=this.md5_ff(a,b,c,d,x[i+8],7,1770035416);d=this.md5_ff(d,a,b,c,x[i+9],12,-1958414417);c=this.md5_ff(c,d,a,b,x[i+10],17,-42063);b=this.md5_ff(b,c,d,a,x[i+11],22,-1990404162);a=this.md5_ff(a,b,c,d,x[i+12],7,1804603682);d=this.md5_ff(d,a,b,c,x[i+13],12,-40341101);c=this.md5_ff(c,d,a,b,x[i+14],17,-1502002290);b=this.md5_ff(b,c,d,a,x[i+15],22,1236535329);a=this.md5_gg(a,b,c,d,x[i+1],5,-165796510);d=this.md5_gg(d,a,b,c,x[i+6],9,-1069501632);c=this.md5_gg(c,d,a,b,x[i+11],14,643717713);b=this.md5_gg(b,c,d,a,x[i+0],20,-373897302);a=this.md5_gg(a,b,c,d,x[i+5],5,-701558691);d=this.md5_gg(d,a,b,c,x[i+10],9,38016083);c=this.md5_gg(c,d,a,b,x[i+15],14,-660478335);b=this.md5_gg(b,c,d,a,x[i+4],20,-405537848);a=this.md5_gg(a,b,c,d,x[i+9],5,568446438);d=this.md5_gg(d,a,b,c,x[i+14],9,-1019803690);c=this.md5_gg(c,d,a,b,x[i+3],14,-187363961);b=this.md5_gg(b,c,d,a,x[i+8],20,1163531501);a=this.md5_gg(a,b,c,d,x[i+13],5,-1444681467);d=this.md5_gg(d,a,b,c,x[i+2],9,-51403784);c=this.md5_gg(c,d,a,b,x[i+7],14,1735328473);b=this.md5_gg(b,c,d,a,x[i+12],20,-1926607734);a=this.md5_hh(a,b,c,d,x[i+5],4,-378558);d=this.md5_hh(d,a,b,c,x[i+8],11,-2022574463);c=this.md5_hh(c,d,a,b,x[i+11],16,1839030562);b=this.md5_hh(b,c,d,a,x[i+14],23,-35309556);a=this.md5_hh(a,b,c,d,x[i+1],4,-1530992060);d=this.md5_hh(d,a,b,c,x[i+4],11,1272893353);c=this.md5_hh(c,d,a,b,x[i+7],16,-155497632);b=this.md5_hh(b,c,d,a,x[i+10],23,-1094730640);a=this.md5_hh(a,b,c,d,x[i+13],4,681279174);d=this.md5_hh(d,a,b,c,x[i+0],11,-358537222);c=this.md5_hh(c,d,a,b,x[i+3],16,-722521979);b=this.md5_hh(b,c,d,a,x[i+6],23,76029189);a=this.md5_hh(a,b,c,d,x[i+9],4,-640364487);d=this.md5_hh(d,a,b,c,x[i+12],11,-421815835);c=this.md5_hh(c,d,a,b,x[i+15],16,530742520);b=this.md5_hh(b,c,d,a,x[i+2],23,-995338651);a=this.md5_ii(a,b,c,d,x[i+0],6,-198630844);d=this.md5_ii(d,a,b,c,x[i+7],10,1126891415);c=this.md5_ii(c,d,a,b,x[i+14],15,-1416354905);b=this.md5_ii(b,c,d,a,x[i+5],21,-57434055);a=this.md5_ii(a,b,c,d,x[i+12],6,1700485571);d=this.md5_ii(d,a,b,c,x[i+3],10,-1894986606);c=this.md5_ii(c,d,a,b,x[i+10],15,-1051523);b=this.md5_ii(b,c,d,a,x[i+1],21,-2054922799);a=this.md5_ii(a,b,c,d,x[i+8],6,1873313359);d=this.md5_ii(d,a,b,c,x[i+15],10,-30611744);c=this.md5_ii(c,d,a,b,x[i+6],15,-1560198380);b=this.md5_ii(b,c,d,a,x[i+13],21,1309151649);a=this.md5_ii(a,b,c,d,x[i+4],6,-145523070);d=this.md5_ii(d,a,b,c,x[i+11],10,-1120210379);c=this.md5_ii(c,d,a,b,x[i+2],15,718787259);b=this.md5_ii(b,c,d,a,x[i+9],21,-343485551);a=this.safe_add(a,olda);b=this.safe_add(b,oldb);c=this.safe_add(c,oldc);d=this.safe_add(d,oldd);}return[a,b,c,d];},'md5_cmn':function(q,a,b,x,s,t){return this.safe_add(this.bit_rol(this.safe_add(this.safe_add(a,q),this.safe_add(x,t)),s),b);},'bit_rol':function(num,cnt){return(num<<cnt)|(num>>>(32-cnt));},'md5_ff':function(a,b,c,d,x,s,t){return this.md5_cmn((b&c)|((~b)&d),a,b,x,s,t);},'md5_gg':function(a,b,c,d,x,s,t){return this.md5_cmn((b&d)|(c&(~d)),a,b,x,s,t);},'md5_hh':function(a,b,c,d,x,s,t){return this.md5_cmn(b^c^d,a,b,x,s,t);},'md5_ii':function(a,b,c,d,x,s,t){return this.md5_cmn(c^(b|(~d)),a,b,x,s,t);},'safe_add':function(x,y){var lsw=(x&0xFFFF)+(y&0xFFFF);var msw=(x>>16)+(y>>16)+(lsw>>16);return(msw<<16)|(lsw&0xFFFF);}};


var _creatGuid=function(_o) {
			var _str ='',_sp =(_o && 35<_o)? '-' :'';
			for(var _i = 0; _i < 31; _i++) {
				_str +=''+ Math.floor(Math.random() * 0xF).toString(0xF) + (_i == 6 || _i == 10 || _i == 14 || _i == 18 ? _sp :'');
			}
			return (_sp && 37<_o)
				? '{'+['A','B','C','D','E','F','G','H','J','K'][Math.floor(Math.random() *10)] +_str.toUpperCase() +'}'
				: ['A','B','C','D','E','F','G','H','J','K'][Math.floor(Math.random() *10)]+''+ _str.toUpperCase()
				;
}




//7775757f5096fbd35b3e4df80cca1229 i23456



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
	// 。-2147467259
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
				_r.err='err_connExecute:_rows_'+e.description+'_'+e.number;
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
		_r.msg = 'ok!!'
	}catch (e) {
		_r.err ='err_connExecute:_ExeDo_'+e.description+'_'+e.number;
	}finally{
		this.close('conn');
	}

	return _r;
};





//new Error('heooo');

var ado = new _ado({
	'datalink':{
		'access':'/db/lks_0.accdb'
		,'mssql':'uid=sa;pwd=i23456;Database=j_orz_asia;addr={127.0.0.1,1433}'
	}

});
var _query=function(_n) {
	if (!_n || !Request.QueryString.Count ) {return null;}
	var _v =Request.QueryString.Item(_n).Item();
	if (undefined===_v) {return null}
	_v =(''+_v).replace(/^[\s\t ]+|[\s\t ]+$/g,'');
	return _v.length >0 ?  _v : null;
	//undefined==Request.QueryString.Item('f1').Item()

}
;


var _pd_insert =function(_qstr,_pdO,_insertO) {
	var _qstrArr =_qstr.split('|')
	,_sel = _query('pd_sel')
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

	//var _qstrO={};
	for (var _i=0,_x=_qstrArr.length; _i<_x; _i++) {
		_qstrArr[_i]=_qstrArr[_i].split(':') ;
		if (undefined!=_qstrArr[_i][1]) {
			_qstrO[_qstrArr[_i][0]]=(''+_qstrArr[_i][1]).replace(/\'+/g,'`');
		}
	};

	_insertSqlO={
		'pd_Id':_creatGuid()
		,'pd_sel':_sel
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
	};

	_insertSqlO.pd_buyPrice =_pdO.attr.pd_buyPrice;
	_insertSqlO.pd_songBuyPrice =_pdO.attr.pd_songBuyPrice;

	if (_insertO) {
		for (var _b in _insertO) {if( _insertO.hasOwnProperty(_b)){
			(undefined !=_insertO[_b]) &&(_insertSqlO[_b]=_insertO[_b]);

		}}

	}
	//_insertSqlO.pd_proxyIp ='192.168.0.1';
	//_insertSqlO.pd_proxyDomain ='1.we-mei.com';

	//var _insertNameArr=[],_insertValueArr=[];

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
			_insertValueArr.push('"'+_insertSqlO[_a]+'"');
		}
	}}

	_insertSqlStr ='INSERT INTO [lks_pdorder_1]'
	+' ('+_insertNameArr.join(',')+') '
	+'VALUES '
	+'('+_insertValueArr.join(',')+')'
	;
	Response.Write(_insertSqlStr);

};


/*
var _qstr='pd_addr:北京-朝阳区劲松3区恩123#|pd_user:摸飞|pd_tel:010-81898192|pd_htel:13501155503|pd_say:健康科普作家，畅销书《营养革命》系列丛书作者，露卡素有机生活首倡者。早年研习医学和数学，1994年在|pd_webdomain:1.lks.com|pd_userIp:127.0.0.1|pd_comedomain:1.lks.com'
;
var _pdO={
		'attr':{
			'pd_name':'露卡素左旋肉碱'
			,'pd_songName':'360左旋咖啡'
			//,'pd_price':218
			,'pd_buyPrice':7
			,'pd_songBuyPrice':8
		}
		,'pdArr':[
			{'pd_price':198 ,'pd_saleNum':1 ,'pd_songNum':0}
			,{'pd_price':288 ,'pd_saleNum':2 ,'pd_songNum':1}
			,{'pd_price':368 ,'pd_saleNum':4 ,'pd_songNum':1}
			,{'pd_price':568 ,'pd_saleNum':6 ,'pd_songNum':2}
			,{'pd_price':668 ,'pd_saleNum':8 ,'pd_songNum':2}
			,{'pd_price':768 ,'pd_saleNum':8 ,'pd_songNum':4}
		]
	}
	;

_pd_insert(_qstr,_pdO,{
	'pd_proxyIp':'192.168.0.1'
	,'pd_proxyDomain':'1.we-mei.com'
})

*/
//var _selectSql ='select top 10 [ID],[pd_Id],[pd_sel],[pd_price],[pd_type],[pd_songType],[pd_saleNum],[pd_songNum],[pd_userName],[pd_userTel],[pd_userHandTel],[pd_userAddr],[pd_userIp],[pd_userSay],[pd_webDomain],[pd_buyPrice],[pd_songBuyPrice],[pd_proxyIp],[pd_proxyDomain] from [lks_pdorder_1] order by [pd_creatTime] desc'
var _selectSql ='select top 10 * from [lks_pdorder_1] order by [pd_creatTime] desc'
;

var _selectpdlist =ado.connAccExe(_selectSql,'rowsarr');

Response.Write('<br/>----订单测试记录-----<br/>'+(_selectpdlist.err || _selectpdlist.rows.join('<br/>')));


//Response.Write(undefined===Session.Contents('t123'))

/*
Response.Write('<br/>---------<br/>'+(_in1.msg||_in1.err));
*/

//var _selectpdlist =ado.connAccExe('select top 10 [ID],'+_inNameArr.join(',')+',[pd_creatTime] from [lks_pdorder_1] order by [pd_creatTime] desc ','rowsarr');

//Response.Write('<br/>---------<br/>'+(_selectpdlist.err || _selectpdlist.rows.join('<br/>')))

/*
['pd_Id',_creatGuid()]



	,['pd_proxyIp','']
	,['pd_proxyDomain',12]




Response.Write('<br/>'+_qstr)












var _intoArr=[
	['pd_Id',_creatGuid()]
	,['pd_sel',0]
	,['pd_price',218]
	//['pd_type',1]
	//['pd_songType',1]
	,['pd_saleNum',1]
	,['pd_songNum',1]
	,['pd_userName','莫 非 0']
	,['pd_userTel','']
	,['pd_userHandTel','13501155503']
	,['pd_userAddr','劲松3区0']
	,['pd_userIp','127.0.0.1']
	,['pd_userQqIp','']
	,['pd_userQqAddr','']
	,['pd_proxyIp','']
	,['pd_proxyDomain',12]
	,['pd_webdomain','']
	,['pd_webInfo','']
	,['pd_userSay','健康科普作家，畅销书《营养革命》系列丛书作者，露卡素有机生活首倡者。早年研习医学和数学，1994年在']
	//['pd_buyPrice']
	//['pd_songBuyPrice']
	//['pd_orderType']
	//['pd_shunfeng']
	//['pd_creatTime']
	//['pd_overTime']
	//['pd_editGuid']
	//['pd_sengGuid']
	//['pd_die']

];
//return(typeof(a)==='number' && Object.prototype.toString.apply(a) === '[object Number]');

var _inNarr=[];
var _inVarr=[];

for (var _i=0,_x=_intoArr.length; _i<_x; _i++) {
	_inNarr.push(_intoArr[_i][0]);

	if (typeof(_intoArr[_i][1])==='number' && Object.prototype.toString.apply(_intoArr[_i][1]) === '[object Number]') {
		_inVarr.push(_intoArr[_i][1])
	}else {
		_inVarr.push('"'+_intoArr[_i][1]+'"');
	}
}

var insql ='INSERT INTO [lks_pdorder_1] (['+_inNarr.join('],[')+']) VALUES ('+_inVarr.join(',')+')';


Response.Write('<br/>INSERT INTO [lks_pdorder_1] (['+_inNarr.join('],[')+']) VALUES ('+_inVarr.join(',')+')');

//Response.Write('<br/>---------<br/>'+_inNarr.length+' '+_inVarr.length)

//var _in1 =ado.connAccExe(insql);

//Response.Write('<br/>---------<br/>'+(_in1.msg||_in1.err));

//Response.Write('<br/>---------<br/>'+ado.connAccExe('select ['+_inNarr.join('],[')+'] from [lks_pdorder_1] where ID="G62358BC65D7C93474C6A5952E4CBEB9"','rowsarr').rows.join('<br/>'))
var _selectpdlist =ado.connAccExe('select top 10 [ID],['+_inNarr.join('],[')+'],[pd_creatTime] from [lks_pdorder_1] order by [pd_creatTime] desc ','rowsarr');

Response.Write('<br/>---------<br/>'+(_selectpdlist.err || _selectpdlist.rows.join('<br/>')))
*/

/*
Response.Write(
	_inNarr.join(',')
	+'<br/>'
	+_inVarr.join(',')
);
*/


/*

Response.Write('<br/>conn:'+ado._getDateConnStr());
Response.Write('<br/>conn:'+ado._getDateConnStr('mssql'));
var _r = ado.connAccExe('select [pd_name] from lks_test','rowsarr');
Response.Write('<br/>---------<br/>'+(_r.err || _r.msg || _r.rows.join('<br/>')))


*/

/*
Response.Write('<br/>---------<br/>'+ado._connExecute({
	'sql':'select [pd_name] from lks_test'
	,'type':'rowsarr'
}).rows.join('<br/>'))

Response.Write('<br/>---------<br/>'+ado._connExecute({
	'sql':'select [pd_name] from lks_test'
	,'type':'rowsarr'
}).rows.join('<br/>'))

|        ID         |      pd_sel       |     pd_price      |      pd_type      |    pd_songType    |    pd_saleNum     |    pd_songNum     |    pd_userName    |    pd_userTel     |  pd_userHandTel   |    pd_userAddr    |     pd_userIp     |    pd_userQqIp    |   pd_userQqAddr   |    pd_proxyIp     |  pd_proxyDomain   |   pd_webdomain    |     pd_webIp      |    pd_userSay     |    pd_buyPrice    |  pd_songBuyPrice  |   pd_orderType    |    pd_shunfeng    |   pd_creatTime    |    pd_overTime    |    pd_editGuid    |    pd_sengGuid    |      pd_die       |




*/

/*

var _dbpath = Server.MapPath('/db/lks_0.accdb');
var _conn = Server.CreateObject('ADODB.Connection');
var _sql ='select * from lks_test';
_conn.Open('Provider=Microsoft.ACE.OLEDB.12.0; persist security info=false; data source='+_dbpath)

//_conn.Execute('INSERT INTO lks_test (pd_name, Pd_sel) VALUES ("测;&quot;试",5)')
_rcd.State

var _rcd = _conn.Execute(_sql,1,1);
var _jl ='记录<br/>'
//Response.Write(_rcd.State);

if(_rcd.State>0 && !_rcd.EOF) {
	_jl += _rcd.GetString(2,-1,'--','<br/>','null');

}
_rcd.Close();
_conn.Close();
_conn =null;

Response.Write(_jl+'<br/>')

Response.Write(_dbpath)
*/




//Response.Write('<br/>db test')



/*


var hex = new _hex();

Response.Write('<br/>'+hex.md5('123'));




*/

/*

|        ID         |      pd_sel       |     pd_price      |      pd_type      |    pd_songType
|    pd_saleNum     |    pd_songNum     |    pd_userName    |    pd_userTel     |  pd_userHandTel   |    pd_userAddr
|     pd_userIp     |    pd_userQqIp    |   pd_userQqAddr   |    pd_proxyIp     |  pd_proxyDomain   |   pd_webdomain
|     pd_webIp      |    pd_userSay     |    pd_buyPrice    |  pd_songBuyPrice  |   pd_orderType    |    pd_shunfeng
|   pd_creatTime    |    pd_overTime    |    pd_editGuid    |    pd_sengGuid    |      pd_die       |


Sub test()

Dim cmd As ADODB.Command
Set cmd = New ADODB.Command
cmd.ActiveConnection = CurrentProject.Connection

cmd.CommandText = "CREATE TABLE tbl1 (uid INTEGER PRIMARY KEY, foo
INTEGER)"
cmd.Execute , , adCmdText

cmd.CommandText = "INSERT INTO tbl1 (uid, foo) VALUES (1, 2)"
cmd.Execute , , adCmdText

cmd.CommandText = "CREATE TABLE tbl2 (uid INTEGER PRIMARY KEY, bar
INTEGER)"
cmd.Execute , , adCmdText

cmd.CommandText = "INSERT INTO tbl2 (uid, bar) VALUES (1, 3)"
cmd.Execute , , adCmdText

cmd.CommandText = "CREATE TABLE tbl3 AS (SELECT tbl1.[uid], tbl1.
[foo], tbl2.[bar] FROM tbl1 INNER JOIN tbl2 ON tbl1.[uid] = tbl2.
[uid])"
cmd.Execute , , adCmdText

End Sub



*/


%>