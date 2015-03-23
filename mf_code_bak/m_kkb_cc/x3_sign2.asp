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



var _r1=GC.DB.ado.prExe('prGetUserInfo',[
	['userID','int',4,5389]
		,['myUserID','int',4,5389]
]);



Response.Write('<br/>'+(_r1.err||_r1.prs.userID))
//Response.Write(_r.err||_r.rows)



/*

Response.Write('<br/>conn:'+GC.DB.ado._getDataConnStr('access'));
Response.Write('<br/>conn:'+GC.DB.ado._getDataConnStr());
Response.Write('<br/>conn:'+GC.DB.ado._getDataConnStr('mssql','uid=sa;pwd=i234567;Database=ylxq_forum_01;addr={127.0.0.1,1433}'));
Response.Write('<br/>conn:'+GC.DB.ado._getDataConnStr('mssql'));

GC.DB.ado.creat('cmd');
//1 sql 2 table 4 pro
GC.DB.ado.attr.cmd.CommandType=4;
GC.DB.ado.attr.cmd.CommandText ='dbo.prGetUserInfo';

//GC.DB.ado.attr.cmd.Parameters.Append(GC.DB.ado.attr.cmd.CreateParameter('@userID',3,1,4,2));
GC.DB.ado.cmdAddPrs([
	['userID','int',4,5389]
	,['myUserID','int',4,5389]
	]);
//GC.DB.ado.attr.cmd.Parameters.Append(GC.DB.ado.attr.cmd.CreateParameter('@myUserID',3,1,4,2));
*/
/*
prName prtype(int..),in Or out ,prValue
0 : 类型无法确定；1: 输入参数；2: 输入参数；3：输入或输出参数；4: 返回值
*/

//GC.DB.ado.attr.cmd.ActiveConnection=GC.DB.ado._getDataConnStr('mssql');
//var _cord = GC.DB.ado.attr.cmd.Execute().GetString(2,-1,'\'\'\'','\'\'\'\'\'','null');
//Response.Write('============'+GC.DB.ado.attr.cmd.State)
//GC.DB.ado.attr.cmd_rcd=GC.DB.ado.attr.cmd.Execute();
//Response.Write('=_rcd.State==========='+_rcd.State)
//Response.Write('============'+GC.DB.ado.attr.cmd.State)
//GC.DB.ado.close('cmd');
//Response.Write('<br/>=====cmd_rcd.State 1:======='+GC.DB.ado.attr.cmd_rcd.State)
//var _rcd1=GC.DB.ado.attr.cmd_rcd.GetString(2,-1,'\'\'\'','\'\'\'\'\'','null')

//GC.DB.ado.close('cmd_rcd');
//delete GC.DB.ado.attr.cmd_rcd
//Response.Write('<br/>=====cmd_rcd.State 2======='+GC.DB.ado.attr.cmd_rcd.State)

//var _pras = GC.DB.ado.attr.cmd.Parameters;
//Response.Write('<br/>____________'+ GC.DB.ado.attr.cmd.ActiveConnection)
//GC.DB.ado.attr.cmd.Close();
//Response.Write(GC.DB.ado.attr.cmd.Parameters.Item(0).name)

//Response.Write('<br/>'+_pras.item(0).name+' '+_pras.item(0).value)
//Response.Write('<br/>'+_pras.item(1).name+' '+_pras.item(1).value)
//Response.Write('<br/>'+_pras.item(2).name+' '+_pras.item(2).value)
//Response.Write('<br>'+_rcd1)
//GC.DB.ado.close('cmd_all');


/*
prName prtype(int..),in Or out ,prValue
0 : 类型无法确定；
1: 输入参数；
2: 输入参数；
3：输入或输出参数；
4: 返回值
*/

/*
this.cmd.ActiveConnection= this.connStr
			this.cmd.CommandText =_prName;
			this.cmd.Execute();
			if(this.cmd.State>0) this.cmd.Close();
			var _pras = this.cmd.Parameters;
			this.cmd = null;

*/

//Response.Write(''+GC.DB.ado.attr.cmd1)

//GC.DB.ado.close('cmd');





/*
var _r = GC.DB.ado.connMssqlExe('select top 10 * from [v_innerUserInfo_1] where UserGroupID <9 order by UserIntid desc','rowsarr');
//var _r = GC.DB.ado.connMssqlExe('select top 10 * from [v_innerUserInfo_1] where UserIntid =2 order by UserIntid desc','rowsarr');


Response.Write('<br/>---------<br/>'+(_r.err || _r.msg || _r.rows.join('<hr/>')))


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