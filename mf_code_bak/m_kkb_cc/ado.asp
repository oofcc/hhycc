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
codecoke.fn.newFunIn(
	GC
	,'DB'
	,'C_server_DB'
	,{
		'datalink':{
			'access':'/db/lks_0.accdb'
			,'mssql':'uid=sa;pwd=i23456;Database=ylxq_forum_01;addr={127.0.0.1,1433}'
		}
	}
);

Response.Write('<br/>conn:'+GC.DB.ado._getDataConnStr());
Response.Write('<br/>conn:'+GC.DB.ado._getDataConnStr('mssql'));

var _r = GC.DB.ado.connMssqlExe('select top 10 * from [v_innerUserInfo_1] where UserGroupID <9 order by UserIntid desc','rowsarr');
//var _r = GC.DB.ado.connMssqlExe('select top 10 * from [v_innerUserInfo_1] where UserIntid =2 order by UserIntid desc','rowsarr');


Response.Write('<br/>---------<br/>'+(_r.err || _r.msg || _r.rows.join('<hr/>')))


/*
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
]);
codecoke.fn.newFunIn(GC,'ado1','C_server_ado',{
		'datalink':{
			'access':'/db/lks_0.accdb'
			,'mssql':'uid=sa;pwd=i23456;Database=ylxq_forum_01;addr={127.0.0.1,1433}'
		}

	});



['ado1','C_server_ado',
	{
		'datalink':{
			'access':'/db/lks_0.accdb'
			,'mssql':'uid=sa;pwd=i23456;Database=ylxq_forum_01;addr={127.0.0.1,1433}'
		}

	}
]
);



var _r1= GC.ado1.connAccExe('select top 2 [pd_name] from lks_test','rowsarr');

Response.Write('<br/>---------<br/>'+(_r1.err || _r1.msg || _r1.rows.join('<hr/>')))

Response.Write('<br/>---------<br/>'+(_r.err || _r.msg || _r.rows.join('<hr/>')))
*/


/*select top 10 * from [Dv_user] order by userID desc

//Response.Write(ado1.sett.datalink_mssql)
/*
var ado = new _ado({
	'datalink':{
		'access':'/db/lks_0.accdb'
		,'mssql':'uid=sa;pwd=i23456;Database=j_orz_asia;addr={127.0.0.1,1433}'
	}

});
*/

%>