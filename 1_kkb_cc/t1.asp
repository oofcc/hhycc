<!--#include virtual='/codecoke_com/func/G_codecoke_0.asp' -->
<!--#include virtual='/codecoke_com/func/G_codecoke_fn_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_fns_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_cookie_action_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_file_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_xhr_0.asp' -->
<!--#include virtual='/codecoke_com/func/C_server_ado_0.asp' -->
<%
 var GC={};


codecoke.fn.newFunIn(GC,[['JSON','C_server_JSON']
	,['quest','C_server_request']
	,['query','C_server_querystring']
	,['iEscape','C_server_iEscape',codecoke.runnerSetting.f62,codecoke.runnerSetting.iEscapePublicKey]
]);
codecoke.fn.newFunIn(GC,'serverobj','C_server_serverobject');
 codecoke.fn.newFunIn(GC,'file','C_server_file');




 codecoke.fn.newFunIn(GC,'ado','C_server_ado');

 var _r =GC.ado.connAccExe('select top 10 * from [lks_pdorder_1] order by [pd_creatTime] desc','rowsarr','/db/lks_0.accdb');

 Response.Write('<br/>----订单测试记录-----<br/>'+(_r.err || _r.rows.join('<br/>')));
//'/db/lks_0.accdb'

/*

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

*/





















var _ds = GC.file.getdriversarr();



















Response.Write('<br/>'+_ds +'<br/>_'+GC.file.isfolderhas('/')+'_'
	+'_'+GC.file.isfilehas('/t2.asp')+'_'
	+'_exists_'+GC.file.exists('/codecoke_com/func/c_json_0.asp')+'_'
)


Response.Write('<br/>'+Request.ServerVariables.Item('Path_Info').Item())
Response.Write('<br/>'+Request.ServerVariables.Item('Path_Translated').Item())
Response.Write('<br/>'+new Date('Sat, 30 Apr 2011 07:44:50 GMT'))
Response.Write(GC.quest.Q('web_dir'))
Response.Write('<pre>'+GC.JSON.stringify(GC.quest.attr.questData,'',' ')+'</pre>')




//codecoke.fn.newFunIn(GC,'xhr','_server_xhr');var _r1 = GC.xhr.loadtxtO('http://news.163.com/special/00011K6L/rss_newstop.xml');Response.Write(_r1.err||_r1.txt)

var _t1=codecoke.fn.newFnCookie([{
		'attr':{
			'name':'Ss'
			,'path':'/'
			,'addtimetype':'d'
			,'addtimelength':120
		}
		,'nameAttr':{
			'userkeystr':'K'
			,'username':'Um'
			,'usersort':'uS'
			,'usermail':'mil'
			,'ban':'Ba'
		}
		,'keyAttr':{
			'userkeystr':2
			,'username':2
		}
	}]);

//_t1.readstr();

//_t1.set('userkeystr','1hshdf 莫非啊莫非  cncnc!&');

Response.Write('<br/>'+_t1.get('userkeystr')+'<br/>'+_t1._cookiesValuesString+'<br/>')
Response.Write('<br/>iEscapeCookiekey: '+_t1.attr.iEscapeCookiekey+'<br/>')
Response.Write(_t1.icookie.attr.name+'<hr/>')
/*

*/



/*

Response.Write(GC.quest.Q('web_dir'))



Response.Write('<pre>'+GC.JSON.stringify(GC.quest.attr.questData,'',' ')+'</pre>')

Response.Write('<br/>-----'+Request.ServerVariables.Item('HTTP_codecoke-client')+'<br/>'+Request.QueryString.Count+'---<br>')
Response.Write('<br/>-----'+GC.query.str('n1')+'---<br>')


Response.Write('<br/>-----'+(''== Request.Cookies.Item('test').Item()))
Response.Write('<br/>-----'+(undefined== Request.ServerVariables.Item('HTTP_codecoke-client').Item()))
Response.Write('<br/>-----'+(undefined=== Request.QueryString.Item('HTTP_codecoke-client').Item()))
*/




%>