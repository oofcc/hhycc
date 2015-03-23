<%
codecoke.fn.declareClass({
	'_basic_':{
		'name':'C_server_ado'
		,'fn':function(_o) {
			this.attr={}
			this.sett ={
				'datalink_pk':{
					'mssql':'Driver={SQL Server};Provider=SQLNCLI10MarsConn=True;DataTypeCompatibility=80;'
					,'access':'Provider=Microsoft.ACE.OLEDB.12.0; persist security info=false; data source='
					//Driver={SQL Server};Provider=SQLNCLI10MarsConn=True;DataTypeCompatibility=80;uid=sa;pwd=i23456;Database=j_orz_asia;addr={127.0.0.1,1433}
					//,'access':'Provider=Microsoft.Jet.OLEDB.4.0; persist security info=false; data source='+Server.MapPath('data/data.mdb')
				}
				,'rowssplitstr':'яЯ'
			}
			if (_o && _o.datalink) {
				_o.datalink.access && ( this.sett.datalink_access = this.sett.datalink_pk.access+Server.MapPath(_o.datalink.access));
				_o.datalink.mssql && ( this.sett.datalink_mssql = this.sett.datalink_pk.mssql+_o.datalink.mssql+';') ;

			}

		}
	}
	,'creat':function(_n) {
		if (this.attr[_n]) {return this.attr[_n];}
		!GC.serverobj && codecoke.fn.newFunIn(GC,'serverobj','C_server_serverobject');
		this.attr[_n] =GC.serverobj.creat(_n);
		_n =='xhr' && (this.attr.xhrVasion=GC.serverobj.attr.xhrVasion);
	}
	,'close':function (_n) {
		this.attr[_n]=GC.serverobj.close(_n);
	}
	,'_getDateConnStr':function(_dtype,_dlink) {
		if (!_dtype) {return this.sett.datalink_access}
		if (!_dlink) { return 'access'==_dtype ? this.sett.datalink_access : this.sett.datalink_mssql;}
		return 'access'==_dtype ? this.sett.datalink_pk.access+Server.MapPath(_dlink) :  this.sett.datalink_pk.mssql + _dlink ;
	}
	,'connAccExe':function(_sql,_type,_datalink) {
		return this._connExecute({
			'sql':_sql
			,'type':_type
			,'datalink':_datalink
			,'datatype':'access'
		});
	}
	,'_connExecute':function(_o) {
		if (!_o || !_o.sql) {return {'err':'err_connExecute:_need_o.sql_sql sucore_'};}
		var _r ={};
		var _connstr =this._getDateConnStr(_o.datatype,_o.datalink);
		if (!_connstr) {return {'err':'err_connExecute:_need_Connection_string_'};}
		// e.number 。_-2147467259 数据库不可写
		if (_o.type) {
			if ('rowsarr'==_o.type) {
				try {
					this.creat('conn');
					this.attr.conn.Open(_connstr);
					var _rcd = this.attr.conn.Execute(_o.sql,1,1);
					if( _rcd.State>0 && !_rcd.EOF ) {
						_r.rows =_rcd.GetString(
							2,-1
							,this.sett.rowssplitstr+'\'\''+this.sett.rowssplitstr
							,this.sett.rowssplitstr+'\'\'\''+this.sett.rowssplitstr
							,'null'
						).split(this.sett.rowssplitstr+'\'\'\''+this.sett.rowssplitstr)
						;
						_r.icount=_r.rows.length = _r.rows.length-1
						for (var _i=0;_i<_r.icount;_i++){_r.rows[_i]=_r.rows[_i].split(this.sett.rowssplitstr+'\'\''+this.sett.rowssplitstr);}
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
			this.creat('conn');
			this.attr.conn.Open(_connstr);
			this.attr.conn.Execute(_o.sql,1,128);
			_r.msg = 'msg_ok!!'
		}catch (e) {
			_r.err =('err_connExecute:_ExeDo_'+e.description+'_'+(e.number||'')).replace(/\'/g,'\\\'');
		}finally{
			this.close('conn');
		}
		return _r;
	}

});

%>