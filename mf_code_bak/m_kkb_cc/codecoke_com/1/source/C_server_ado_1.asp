<%
codecoke.fn.declareClass({
	'_basic_':{
		'name':'C_server_ado'
		,'fn':function(_o) {
			this.attr={
				'prsType':{
					  'p_bigint':{'n':20,'l':8}
					  ,'p_int':{'n':3,'l':4}
					  ,'p_smallint':{'n':2,'l':2}
					  ,'p_tinyint':{'n':16,'l':1}
					  ,'p_char':{'n':129,'l':38}
					  ,'p_varchar':{'n':200,'l':50}
					  ,'p_nvarchar':{'n':130,'l':50}
					  ,'p_ntxt':{'n':130,'l':255}
					  ,'p_txt':{'n':130,'l':500}
					  ,'p_txts':{'n':203,'l':-1}
					  ,'p_guid':{'n':72,'l':38}
					  ,'p_bit':{'n':11,'l':1}
					  ,'p_datetime':{'n':135,'l':4}
					  ,'p_smalldatetime':{'n':135,'l':2}
					}
			};

			this.sett ={
				'datalink_pk':{
					'mssql':'Driver={SQL Server};Provider=SQLNCLI10;MarsConn=True;DataTypeCompatibility=80;'
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
		_n=='cmd' && (this.attr.cmd_rcd =GC.serverobj.attr.cmd_rcd);
		_n =='xhr' && (this.attr.xhrVasion=GC.serverobj.attr.xhrVasion);
	}
	,'close':function (_n,_p) {
		//this.attr[_n]=
		//_n=='cmd_rcd' ? GC.serverobj.close( _n,( _p || this.attr.cmd_rcd) ):GC.serverobj.close(_n);
		if ('cmd_rcd'==_n||'cmd_all'==_n) {
			GC.serverobj.close( _n, this.attr.cmd_rcd );
			this.attr.cmd_rcd =null;
			//delete this.attr.cmd;
			'cmd_all'==_n && (delete this.attr.cmd)
			delete this.attr.cmd_rcd;
		}else {
			this.attr[_n]=GC.serverobj.close(_n);
		}



	}
	,'_getDataConnStr':function(_dtype,_dlink) {
		if (!_dtype) {return this.sett.datalink_mssql}
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
	,'connMssqlExe':function(_sql,_type,_datalink) {
		return this._connExecute({
			'sql':_sql
			,'type':_type
			,'datalink':_datalink
			,'datatype':'mssql'
		});
	}
	,'_connExecute':function(_o) {
		if (!_o || !_o.sql) {return {'err':'err_connExecute:_need_o.sql_sql sucore_'};}
		var _r ={};
		var _connstr =this._getDataConnStr(_o.datatype,_o.datalink);
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
						_r.icount=0;
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
	,'_cmdAddPrs' : function (_a) {
			//[prName,prType,pLength,pvalue]
			//[prName,prType,prLen]
			if(!codecoke.is.Arr(_a)) return;
			var _x =_a.length
			for (var i=0; i<_x; i++) {
				var _pr ={};
				if(codecoke.is.Arr(_a[i])) {
					_pr.name =_a[i][0].indexOf('@')== 0 ? _a[i][0] :'@'+_a[i][0];
					_pr.t = this.attr.prsType['p_'+_a[i][1]];
					_pr.type =_pr.t.n;
					_pr.len =(_a[i][2] || _pr.t.l);
					_pr.v =codecoke.is.Nt(_a[i][3]) ? null :_a[i][3] ;
					if(!_pr.t ){ continue ;}
					if(codecoke.is.Nt(_pr.v)) {
						this.attr.cmd.Parameters.Append(			this.attr.cmd.CreateParameter(_pr.name,_pr.type,2,_pr.len) );
					}else{
						this.attr.cmd.Parameters.Append( this.attr.cmd.CreateParameter(_pr.name,_pr.type,1,_pr.len,_pr.v) );
					}
				}else{
					_pr.name =_a[0].indexOf('@')== 0 ? _a[0] :'@'+_a[0];
					_pr.t = this.attr.prsType['p_'+_a[1]];
					_pr.type =_pr.t.n;
					_pr.len =(_a[2] || _pr.t.l);
					_pr.v =codecoke.is.Nt(_a[3]) ? null :_a[3] ;
					if(!_pr.t) return ;
					if(codecoke.is.Nt(_pr.v)) {
						this.attr.cmd.Parameters.Append( this.attr.cmd.CreateParameter(_pr.name,_pr.type,2,_pr.len) );
					}else{
						this.attr.cmd.Parameters.Append( this.attr.cmd.CreateParameter(_pr.name,_pr.type,1,_pr.len,_pr.v));
					}
					break;
				}
			}
		}
		,'prRowsExe':function (_o) {
			/*
			执行存储过程：入参、出参、并获取记录集
			必需：_o.prsArr,_o.prName
			可选	_o.datalink
			*/
			this.creat('cmd');
			codecoke.is.Arr(_o.prsArr) && this._cmdAddPrs(_o.prsArr);
			_o._datalink = _o.datalink ?
				this._getDataConnStr('mssql',_o.datalink)
				:this._getDataConnStr('mssql')
			;
			var _r={};
			try {
				this.attr.cmd.CommandType=4;
				this.attr.cmd.ActiveConnection=_o._datalink;
				this.attr.cmd.CommandText =_o.prName;
				if(_o.conntimeout) {
					this.attr.cmd.CommandTimeout=_o.conntimeout
				}
				this.attr.cmd_rcd = this.attr.cmd.Execute();
				_r.prs={};
				if(this.attr.cmd_rcd.State>0 && !this.attr.cmd_rcd.EOF) {
					_r.rows =this.attr.cmd_rcd.GetString(
						2,-1
						,this.sett.rowssplitstr+'\'\''+this.sett.rowssplitstr
						,this.sett.rowssplitstr+'\'\'\''+this.sett.rowssplitstr
						,'null'
					).split(this.sett.rowssplitstr+'\'\'\''+this.sett.rowssplitstr)
					;
					this.close('cmd_rcd');
					_r.icount=_r.rows.length = _r.rows.length-1;
					for (var _i=0;_i<_r.icount;_i++){
						_r.rows[_i]=_r.rows[_i].split(this.sett.rowssplitstr+'\'\''+this.sett.rowssplitstr);
					}
				}else {
					_r.rows=[];
					_r.icount=0;
				}
				var _pras = this.attr.cmd.Parameters;
				this.attr.cmd =null;
				for (var _i=0,_prasN =_pras.count; _i<_prasN; _i++) {
					var _rv  =_pras.item(_i).value;
					if(codecoke.is.Nt(_rv)) continue;
					var _rn =(''+_pras.item(_i).name).substr(1);
					if('date'==typeof _rv) {
						_rv=(new Date(_rv)).getTime();
					}else if ('string'==typeof _rv) {
						_rv=codecoke.get.str(_rv,'oneblank');
					}
					_r.prs[_rn] = _rv;
				}

			}
			catch (e) {
				_r.err='ado.prRowsExe '+e.description;
			}finally{
				this.close('cmd_all');
			}
			return _r;
		}
		,'prExe' : function (_prName,_prsArrs,_datalink) {
			this.creat('cmd');
			codecoke.is.Arr(_prsArrs) && this._cmdAddPrs(_prsArrs);
			var _r ={};
			try{
				this.attr.cmd.CommandType=4;
				//1 sql 2 table 4 pro
				this.attr.cmd.ActiveConnection= this._getDataConnStr('mssql',_datalink)
				this.attr.cmd.CommandText =_prName;
				this.attr.cmd.Execute();
				this.attr.cmd.State>0 && this.attr.cmd.Close();
				var _pras = this.attr.cmd.Parameters;
				this.close('cmd_all');
				_r.prs={}
				for (var _i=0,_prasN =_pras.count; _i<_prasN; _i++) {
					var _rv  =_pras.item(_i).value;
					if(codecoke.is.Nt(_rv)) continue;
					var _rn =(''+_pras.item(_i).name).substr(1);
					if('date'==typeof _rv){
						_rv=(new Date(_rv)).getTime();
					}else if ('string'==typeof _rv) {
						_rv=codecoke.get.str(_rv,'oneblank')
					}
					_r.prs[_rn] = _rv;
				}
				_prasN=null;

			}catch (e){
				_r.err ='ado.prExe '+e.description;
			}finally{
				this.close('cmd_all');
			}
			return _r;
	}

})
;

codecoke.fn.declareClassByArr([
{
	'_basic_':{
		'name':'C_server_DB'
		,'fn':function(_dbAttr) {
			this.attr= this.attr || {
					'datalink':{
						'access':'/db/lks_0.accdb'
						,'mssql':'uid=sa;pwd=123456;Database=codecoke_com_1;addr={127.0.0.1,1433}'
					}
			};
			_dbAttr && _dbAttr.datalink && (this.attr.datalink=_dbAttr.datalink);
			(!this.ado) && codecoke.fn.newFunIn(this,'ado','C_server_ado',this.attr);
			this._ini_();

		}
	}
	,'_ini_':function() {
	}
}
])
;
%>