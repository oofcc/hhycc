<!--#include file="const.asp"-->
<!--#include file="basicFaction.asp"-->

<%

/*

十万条记录不是 Access 数据库的极限。何况你的方法不是真正意义上的分页（应当利用 PageSize 和 AbsolutePage 属性）。
VBScript code

 Set rs = New ADODB.Recordset
rs.CursorLocation = adUseClient
rs.PageSize = 20
rs.Open "Select * From 客", iConc, adOpenKeyset, adLockOptimisticlng
Pages = rs.PageCount
lngCurrentPage = 1

 此时打开的记录集只有 20 条记录。

翻页时：

 If lngCurrentPage < lngPages Then
lngCurrentPage = lngCurrentPage + 1
rs.AbsolutePage = lngCurrentPage
End If




*/

//Response.Write(''+codecoke.getValueInArr('txt1',[['',''],['txt','txtv'],['','']]));



//aregument
//arguments
if(typeof site=='undefined') site={};
site.databaselinks ='Provider =Sqloledb; User ID =sa; Password =i23456; Initial Catalog =icathy_1; Data Source =127.0.0.1,1433;';

//ConnStr  = "Driver={SQL Server};Provider=SQLNCLI10;uid=xq_orz_090619;pwd=x_986h)he3^dsh1shn;Database=ylxq_forum;addr={127.0.0.1,7413};MarsConn=True;DataTypeCompatibility=80"

/*
Dim con As New ADODB.Connection
Dim cmd As New ADODB.Command
Dim rst As New ADODB.Recordset
Dim strOldUDT As String
Dim strNewUDT As String
Dim aryTempUDT() As String
Dim strTempID As String
Dim i As Integer

con.ConnectionString = "Provider=SQLNCLI10;" _
         & "Server=(local);" _
         & "Database=AdventureWorks;" _
         & "Integrated Security=SSPI;" _
         & "DataTypeCompatibility=80;"

con.Open

' Get the UDT value.
Set cmd.ActiveConnection = con
cmd.CommandText = "SELECT ID, Pnt FROM dbo.Points.ToString()"
Set rst = cmd.Execute
strTempID = rst.Fields(0).Value
strOldUDT = rst.Fields(1).Value

' Do something with the UDT by adding i to each point.
arytempUDT = Split(strOldUDT, ",")
i = 3
strNewUDT = LTrim(Str(Int(aryTempUDT(0)) + i)) + "," + _
   LTrim(Str(Int(aryTempUDT(1)) + i))

' Insert the new value back into the database.
cmd.CommandText = "UPDATE dbo.Points SET Pnt = '" + strNewUDT + _
   "' WHERE ID = '" + strTempID + "'"
cmd.Execute

con.Close
Set con = Nothing


Dim con As New ADODB.Connection

con.ConnectionString = "Provider=SQLNCLI10;" _
         & "Server=(local);" _
         & "Database=AdventureWorks;" _
         & "Integrated Security=SSPI;" _
         & "DataTypeCompatibility=80;" _
         & "MARS Connection=True;"
con.Open

Dim recordset1 As New ADODB.Recordset
Dim recordset2 As New ADODB.Recordset

Dim recordsaffected As Integer
Set recordset1 =  con.Execute("SELECT * FROM Table1", recordsaffected, adCmdText)
Set recordset2 =  con.Execute("SELECT * FROM Table2", recordsaffected, adCmdText)

con.Close
Set con = Nothing

*/


codecoke.adocmd=function() {
	this.databaselinks = arguments[0] || site.databaselinks;

};

codecoke.adocmd.prototype ={
	creat : function() {
		if(this.cmd) {this.cmd.close;this.cmd=null;}
		this.cmd = Server.CreateObject('ADODB.Command');
		this.cmd.CommandType=4;
		this.cmd.NamedParameters = true;
		this.cmd.Prepared=true;
		this.cmd.Parameters.Append(this.cmd.CreateParameter("RETURN",2,4));
	},
	add : function() {
		if(!this.cmd) this.creat();
		if(!codecoke.check.isArray(arguments[0])) return;
		var _pArr = arguments[0];
		var _typeArr = [ ['int',3],['smallint',2],['tinyint',16],['char',129],['varchar',200],['nvarchar',130],['guid',72],['bit',11],['datatime',135] ]
		var _x = _pArr.length;
		//['name','inOrout','dataType','dataLength','inputData']
		for (var _i=0; _i<_x; _i++) {
			var _name = _pArr[_i][0].trim();
			var _type = codecoke.getValueInArr((_pArr[_i][2]).trim().toLowerCase(),_typeArr) || 200;
			if(_pArr[_i][1]=='in') {
				this.cmd.Parameters.Append(this.cmd.CreateParameter(_name,_type,1,_pArr[_i][3],_pArr[_i][4]));
			}else{
				this.cmd.Parameters.Append(this.cmd.CreateParameter(_name,_type,2,_pArr[_i][3]));
			}

		}

	},
	exec : function() {
		if(!arguments[0]) return;
		if(!this.cmd) this.creat() ;
		this.cmd.CommandText = arguments[0].trim();
		this.cmd.ActiveConnection = this.databaselinks;
		var _robj = {'paras':null};
		if(arguments[1] && codecoke.check.isArray(arguments[1])) { this.add(arguments[1]); }
		if(arguments[2]) {
			var _rows = this.cmd.Execute;
			var _rName = arguments[2].trim();
			if(_rows.EOF && _rows.BOF){
				_robj[_rName] = null;
			}else {
				_robj[_rName] =_rows.GetString(2,-1, '\'\'\'', '\'\'\'\'\'', '').split('\'\'\'\'\'').popSelf().childSplit('\'\'\'');
			}
			if(_rows.state>0) {_rows.close;}
		}else {
			this.cmd.Execute;
		}
		_robj.paras = this.cmd.Parameters;
		this.cmd.close;
		delete(this.cmd.ActiveConnection);
		this.cmd =null;
		return _robj;

	}

	/*,
	getrows : function(_rsArr,_fieldsLenght) {
		var _X=_rsArr.length/_fieldsLenght, _rArr=[], _sp;
		for(var _i=0;_i<_X;_i++) {
			_rArr[_i]=[];
			_sp=_i*_fieldsLenght;
			for(var _j=0; _j< _fieldsLenght; _j++){ _rArr[_i][_j]=_rsArr[_sp+_j];}
		}
		return _rArr;
		//_rArr =null;
	}
	*/
}

/*
var _conn = new  codecoke.adocmd();
	_conn.creat();
	_conn.add([
		['@userPcID','in','char',36,'70237198-47BF-4443-AC53-1B1CBB346BF7'],
		['@userOutPcID','out','char',36]
	]);
	_conn.cmd.CommandText ='tmp_1_tb1'
	_conn.cmd.ActiveConnection=site.databaselinks

	var _rs = _conn.cmd.Execute;

	var _rsw =_rs.GetString(2,-1, '\'\'\'', '\'\'\'\'\'', '').replace(/\'\'\'\'\'$/,'').split('\'\'\'\'\'').childSplit('\'\'\'');

	Response.Write(_rsw.childJoin('___').join('<br>'))

	Response.Write('<hr>'+[1,2].childJoin('_').join('x'))


//var _conn =new creatDatabaseObject();

	//_conn.creat();
	//_conn.cmd.Parameters.Append(_conn.cmd.CreateParameter('@userPcID',129,1,36,'70237198-47BF-4443-AC53-1B1CBB346BF7'));
	//_conn.cmd.Parameters.Append(_conn.cmd.CreateParameter('@userOutPcID',129,2,36));
*/
	var _inpara =[
		['@userPcID','in','char',36,'70237198-47BF-4443-AC53-1B1CBB346BF7'],
		['@userOutPcID','out','char',36]
	];

	var _rs = (new codecoke.adocmd()).exec('tmp_1_tb1',_inpara,'_rows');
		var _rArr = _rs._rows;
		for (var _i=0; _i<_rArr.length; _i++) {
		Response.Write(_rArr[_i][0]+'_'+_rArr[_i][1]+'<br>')
		}

	//}

	//if(_rs.state>0) {_rs.close;}
	var _para = _rs.paras;
	Response.Write('returnvalue____'+_para('RETURN')+'<br>')
	Response.Write('inID____'+_para('@userPcID')+'<br>')
	Response.Write('outID____'+_para('@userOutPcID')+'<br>')
	_rs = null;

	var _rs2 = (new codecoke.adocmd()).exec('tmp_2_tb2');
	Response.Write(_rs2.paras('RETURN')+'___rs2_ruturn<br/>')
	//Response.Write('rsClose____'+_rs.state+'<hr>')


	var _rs3 =(new codecoke.adocmd()).exec('prQueryicathyOther',null,'_rows'); //跨库访问；

	for (var _i=0; _i<_rs3._rows.length; _i++) {
		Response.Write(_rs3._rows[_i][0]+':__'+_rs3._rows[_i][1]+'<br/>')

	}

	Response.Write('<hr/>_RS3___'+_rs3.paras('RETURN'));


	//_conn.cmd.close;
	//_conn.cmd=null;
//	_conn.cmd.close
	//Response.Write('____'+_conn.cmd.state)
	//_conn.clear();

/*	//On Error Resume Next;

	//Response.Write(err.number)

	//On Error Goto 0;

	function fDataGetString(oRs, bShow, bReturn, sCst){
     if(!sCst){
      var str=oRs.GetString(2,-1, '#', '@<br/>\n', 'empty...');
     } else {
      var str=eval('oRs.GetString('+sCst+')')

*/






<!-- BeginGetRowsJS -->
<%@ LANGUAGE="JScript" %>
<%// use this meta tag instead of adojavas.inc%>
<!--METADATA TYPE="typelib" uuid="00000205-0000-0010-8000-00AA006D2EA4" -->

<html>

<head>
<title>ADO Recordset.GetRows Example (JScript)</title>
<style>
<!--
BODY {
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   BACKGROUND-COLOR:white;
   COLOR:black;
    }
.thead {
   background-color: #008080;
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   font-size: x-small;
   color: white;
   }
.thead2 {
   background-color: #800000;
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   font-size: x-small;
   color: white;
   }
.tbody {
   text-align: center;
   background-color: #f7efde;
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   font-size: x-small;
    }
-->
</style>
</head>

<body bgcolor="white">

<h1>ADO Recordset.GetRows Example (JScript)</h1>
    <!-- Page text goes here -->
<%
        var Connect = "Provider='sqloledb';Data Source=" + Request.ServerVariables("SERVER_NAME") + ";" +
            "Initial Catalog='Northwind';Integrated Security='SSPI';";
    var mySQL = "select * from customers;";
    var showblank = " ";
    var shownull = "-null-";

    var connTemp = Server.CreateObject("ADODB.Connection");

    try
    {
        connTemp.Open(Connect);
        var rsTemp = Server.CreateObject("ADODB.Recordset");
        rsTemp.ActiveConnection = connTemp;
        rsTemp.CursorLocation = adUseClient;
        rsTemp.CursorType = adOpenKeyset;
        rsTemp.LockType = adLockOptimistic;
        rsTemp.Open(mySQL);

        rsTemp.MoveFirst();

        if (rsTemp.RecordCount == 0)
        {
            Response.Write("No records matched ");
            Response.Write (mySQL & "So cannot make table...");
            connTemp.Close();
            Response.End();
        } else
        {
            Response.Write('<table width="100%" border="2">');
            Response.Write('<tr class="thead2">');

            //  Headings On The Table for each Field Name
            for (var i=0; i<rsTemp.Fields.Count; i++)
            {
                fieldObject = rsTemp.fields(i);
                Response.Write('<td width="' + Math.floor(100 / rsTemp.Fields.Count) + '%">' + fieldObject.name + "</td>");
            }

            Response.Write("</tr>");

            // JScript doesn't support multi-dimensional arrays
            // so we'll convert the returned array to a single
            // dimensional JScript array and then display the data.
            tempArray = rsTemp.GetRows();
            recArray = tempArray.toArray();

            var col = 1;
            var maxCols = rsTemp.Fields.Count;

            for (var thisField=0; thisField<recArray.length; thisField++)
            {
                if (col == 1)
                    Response.Write('<tr class="tbody">');
                if (recArray[thisField] == null)
                        recArray[thisField] = shownull;
                if (recArray[thisField] == "")
                        recArray[thisField] = showblank;
                Response.Write("<td>" + recArray[thisField] + "</td>");
                col++
                if (col > maxCols)
                {
                    Response.Write("</tr>");
                    col = 1;
                }
            }
            Response.Write("</table>");
        }
    }
    catch (e)
    {
        Response.Write(e.message);
    }
    finally
    {
        // clean up
        if (rsTemp.State == adStateOpen)
            rsTemp.Close;
        if (connTemp.State == adStateOpen)
            connTemp.Close;
        rsTemp = null;
        connTemp = null;
    }
%>

</body>

</html>
<!-- EndGetRowsJS -->


<!-- BeginExecuteJS -->
<%@LANGUAGE="JScript"%>
<%// use this meta tag instead of adojavas.inc%>
<!--METADATA TYPE="typelib" uuid="00000205-0000-0010-8000-00AA006D2EA4" -->

<%
    strLastName = new String(Request.Form("AuthorLName"));

    if (strLastName.indexOf("undefined") > -1)
        strLastName = "";
%>

<html>

<head>
<title>Execute, Requery and Clear Methods Example (JScript)</title>
<style>
<!--
BODY {
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   BACKGROUND-COLOR:white;
   COLOR:black;
    }
-->
</style>
</head>

<body bgcolor="White">
<h1>Execute, Requery and Clear Methods Example (JScript)</h1>
<%
    if (strLastName.length > 0)
    {
        // command and recordset variables
        var Connect = "Provider='sqloledb';Data Source=" + Request.ServerVariables("SERVER_NAME") + ";" +
            "Initial Catalog='pubs';Integrated Security='SSPI';";
        var Cnxn = Server.CreateObject("ADODB.Connection");
        var cmdAuthor = Server.CreateObject("ADODB.Command");
        var rsAuthor = Server.CreateObject("ADODB.Recordset");
        var rsAuthor2 = Server.CreateObject("ADODB.Recordset");
        var SQLAuthor2, strMessage, strMessage2;
        var Err, ErrCount;

        try
        {
            // open connection
            Cnxn.Open(Connect);

            // command object parameters
            cmdAuthor.CommandText = "SELECT * FROM Authors WHERE au_lname = ?";
            cmdAuthor.Parameters.Append(cmdAuthor.CreateParameter("Last Name", adChar, adParamInput, 20, strLastName));
            cmdAuthor.ActiveConnection = Cnxn;

            // recordset from command.execute
            rsAuthor = cmdAuthor.Execute();

            // recordset from connection.execute
            SQLAuthor2 = "SELECT * FROM Authors";
            rsAuthor2 = Cnxn.Execute(SQLAuthor2);

                // check for errors
                ErrCount = Cnxn.errors.count;
                if(ErrCount !== 0) //write the errors
                {
                    for(Err = 0; Err = ErrCount; Err++){
                        Err = Cnxn.errors.item;
                        Response.Write(Err);
                    }
                    // clean out any existing errors
                    Cnxn.Errors.Clear;
                }

                // show the data
            Response.Write("<HR><HR>");

                // first recordset
            Response.Write("<b>Command.Execute results</b>")
            while (!rsAuthor.EOF)
            {
                // build output string by starting a new line
                strMessage = "<P>";
                strMessage += "<br>";

                // recordset data
                strMessage += rsAuthor("au_fname") + " ";
                strMessage += rsAuthor("au_lname") + " ";

                // end the line
                strMessage += "</P>";

                // show the results
                Response.Write(strMessage);

                // get next record
                rsAuthor.MoveNext;
            }

            Response.Write("<HR><HR>");

            // second recordset
            Response.Write("<b>Connection.Execute results</b>")
            while (!rsAuthor2.EOF)
            {
                // start a new line
                strMessage2 = "<P>";

                // first and last name are in first column
                strMessage2 += rsAuthor2("au_fname") + " "
                strMessage2 += rsAuthor2("au_lname") + " ";

                // end the line
                strMessage2 += "</P>";

                // show results
                Response.Write(strMessage2);

                // get next record
                rsAuthor2.MoveNext;
            }
        }
        catch (e)
        {
            Response.Write(e.message);
        }
        finally
        {
            // clean up
            if (rsAuthor.State == adStateOpen)
                rsAuthor.Close;
            if (rsAuthor2.State == adStateOpen)
                rsAuthor2.Close;
            if (Cnxn.State == adStateOpen)
                Cnxn.Close;
            rsAuthor1 = null;
            rsAuthor2 = null;
            Cnxn = null;
        }
    }
%>

<hr>


<form method="POST" action="ExecuteJS.asp" id=form1 name=form1>
  <p align="left">Enter last name of author to find (e.g., Ringer): <input type="text" name="AuthorLName" size="40"></p>
  <p align="left"><input type="submit" value="Submit" name="B1"><input type="reset" value="Reset" name="B2"></p>
</form>
</body>

</html>
<!-- EndExecuteJS -->




<!-- BeginFindJS -->
<%@  Language=JavaScript %>
<%// use this meta tag instead of adojavas.inc%>
<!--METADATA TYPE="typelib" uuid="00000205-0000-0010-8000-00AA006D2EA4" -->

<html>

<head>
<title>ADO Recordset.Find Example</title>
<style>
<!--
BODY {
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   BACKGROUND-COLOR:white;
   COLOR:black;
    }
.thead {
   background-color: #008080;
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   font-size: x-small;
   color: white;
   }
.thead2 {
   background-color: #800000;
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   font-size: x-small;
   color: white;
   }
.tbody {
   text-align: center;
   background-color: #f7efde;
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   font-size: x-small;
    }
-->
</style>
</head>

<body bgcolor="white">

<h1>ADO Recordset.Find Example</h1>
<%
    // connection and recordset variables
    var Cnxn = Server.CreateObject("ADODB.Connection");
    var strCnxn = "Provider='sqloledb';Data Source=" + Request.ServerVariables("SERVER_NAME") + ";" +
            "Initial Catalog='Northwind';Integrated Security='SSPI';";
    var rsCustomers = Server.CreateObject("ADODB.Recordset");
        // display string
    var strMessage;
    var strFind;

    try
    {
            // open connection
        Cnxn.Open(strCnxn);

            //create recordset using object refs
        SQLCustomers = "select * from Customers;";

        rsCustomers.ActiveConnection = Cnxn;
        rsCustomers.CursorLocation = adUseClient;
        rsCustomers.CursorType = adOpenKeyset;
        rsCustomers.LockType = adLockOptimistic;
        rsCustomers.Source = SQLCustomers;

        rsCustomers.Open();
        rsCustomers.MoveFirst();

            //find criteria
        strFind = "CompanyName like 'g%'"
        rsCustomers.Find(strFind);

        if (rsCustomers.EOF) {
            Response.Write("No records matched ");
            Response.Write(SQLCustomers & "So cannot make table...");
            Cnxn.Close();
            Response.End();
        }
        else {
            Response.Write('<table width="100%" border="2">');
            Response.Write('<tr class="thead2">');
            // Put Headings On The Table for each Field Name
            for (thisField = 0; thisField < rsCustomers.Fields.Count; thisField++) {
                fieldObject = rsCustomers.Fields(thisField);
                Response.Write('<th width="' + Math.floor(100 / rsCustomers.Fields.Count) + '%">' + fieldObject.Name + "</th>");
            }
            Response.Write("</tr>");

            while (!rsCustomers.EOF) {
                Response.Write('<tr class="tbody">');
                for(thisField=0; thisField<rsCustomers.Fields.Count; thisField++) {
                    fieldObject = rsCustomers.Fields(thisField);
                    strField = fieldObject.Value;
                    if (strField == null)
                        strField = "-Null-";
                    if (strField == "")
                        strField = "";
                    Response.Write("<td>" + strField + "</td>");
                }
                rsCustomers.Find(strFind, 1, adSearchForward)
                Response.Write("</tr>");
            }
            Response.Write("</table>");
        }
    }
    catch (e)
    {
        Response.Write(e.message);
    }
    finally
    {
        // clean up
        if (rsCustomers.State == adStateOpen)
            rsCustomers.Close;
        if (Cnxn.State == adStateOpen)
            Cnxn.Close;
        rsCustomers = null;
        Cnxn = null;
    }
%>

</body>

</html>
<!-- EndFindJS -->

<!-- BeginAddNewJS -->
<%@LANGUAGE="JScript" %>
<!-- Include file for JScript ADO Constants -->
<%// use this meta tag instead of adojavas.inc%>
<!--METADATA TYPE="typelib" uuid="00000205-0000-0010-8000-00AA006D2EA4" -->

<html>

<head>
    <title>Add New Method Example (JScript)</title>
<style>
<!--
body {
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   BACKGROUND-COLOR:white;
   COLOR:black;
    }
-->
</style>
</head>

<body>
<h1>AddNew Method Example (JScript)</h1>

<%
    if (Request.Form("Addit") == "AddNew")
    {
        // connection and recordset variables
        var Cnxn = Server.CreateObject("ADODB.Connection")
        var strCnxn = "Provider='sqloledb';Data Source=" + Request.ServerVariables("SERVER_NAME") + ";" +
            "Initial Catalog='Northwind';Integrated Security='SSPI';";
        var rsEmployee = Server.CreateObject("ADODB.Recordset");
        //record variables
        var FName = String(Request.Form("FirstName"));
        var LName = String(Request.Form("LastName"));

        try
        {
            // open connection
            Cnxn.Open(strCnxn)

            // open Employee recordset using client-side cursor
            rsEmployee.CursorLocation = adUseClient;
            rsEmployee.Open("Employees", strCnxn, adOpenKeyset, adLockOptimistic, adCmdTable);

            rsEmployee.AddNew();
            rsEmployee("FirstName") = FName;
            rsEmployee("LastName") = LName;
            rsEmployee.Update;

            // of course, you would normally do error handling here
            Response.Write("New record added.")
        }
        catch (e)
        {
            Response.Write(e.message);
        }
        finally
        {
            // clean up
            if (rsEmployee.State == adStateOpen)
                rsEmployee.Close;
            if (Cnxn.State == adStateOpen)
                Cnxn.Close;
            rsEmployee = null;
            Cnxn = null;
        }
    }
%>

<form method="post" action="AddNewJS.asp" id=form1 name=form1>
<table>
<tr>
    <td colspan="2">
    <h4>Please enter the record to add:</h4>
    </td>
</tr>
<tr>
    <td>
        First Name:
    </td>
    <td>
        <input name="FirstName" maxLength=20>
    </td>
</tr>
<tr>
    <td>
        Last Name:
    </td>
    <td>
        <input name="LastName" size="30" maxLength=30>
    </td>
</tr>
<tr>
    <td align="right">
        <input type="submit" value="Submit" name="Submit">
    </td>
    <TD align="left">
        <INPUT type="reset" value="Reset" name="Reset">
    </TD>
</tr>
</table>
<INPUT type="hidden" value="AddNew" name="Addit">
</form>
</body>
</HTML>
<!-- EndAddNewJS -->


<!-- BeginAppendJS -->
<%@LANGUAGE="JScript" %>
<%// use this meta tag instead of adojavas.inc%>
<!--METADATA TYPE="typelib" uuid="00000205-0000-0010-8000-00AA006D2EA4" -->

<html>
<head>
    <title>Append and CreateParameter Methods Example (JScript)</title>
<style>
<!--
body {
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   BACKGROUND-COLOR:white;
   COLOR:black;
    }
-->
</style>
</head>

<body>
<h1>Append and CreateParameter Methods Example (JScript)</h1>
<%
    // verify user-input
    var iRoyalty = parseInt(Request.Form("RoyaltyValue"));
    if (iRoyalty > -1)
    {

        // connection, recordset and command variables
        var strCnxn = "Provider='sqloledb';Data Source=" + Request.ServerVariables("SERVER_NAME") + ";" +
            "Initial Catalog='pubs';Integrated Security='SSPI';";
        var Cnxn = Server.CreateObject("ADODB.Connection");
        var cmdByRoyalty = Server.CreateObject("ADODB.Command");
        var rsByRoyalty = Server.CreateObject("ADODB.Recordset");
        var rsAuthor = Server.CreateObject("ADODB.Recordset");
        // display variables
        var strMessage;

        try
        {
            // open connection and set cursor location
            Cnxn.Open(strCnxn);
            Cnxn.CursorLocation = adUseClient;

            // command object initial parameters
            cmdByRoyalty.CommandText = "byroyalty";
            cmdByRoyalty.CommandType = adCmdStoredProc;

            // create the new parameter and append to
            // the Command object's parameters collection
            var prmByRoyalty = cmdByRoyalty.CreateParameter("percentage", adInteger, adParamInput);
            cmdByRoyalty.Parameters.Append(prmByRoyalty);
            prmByRoyalty.Value = iRoyalty;

            cmdByRoyalty.ActiveConnection = Cnxn;

            // execute command
            rsByRoyalty = cmdByRoyalty.Execute();

            // display results
            rsAuthor.Open("Authors", Cnxn);


            while (!rsByRoyalty.EOF)
            {
                rsAuthor.Filter = "au_id='" + rsByRoyalty.Fields("au_id") + "'";

                // start new line
                strMessage = "<P>";

                // recordset data
                strMessage += rsAuthor.Fields("au_fname") + " ";
                strMessage += rsAuthor.Fields("au_lname") + " ";

                // end the line
                strMessage += "</P>";

                // show result
                Response.Write(strMessage);

                // et next record
                rsByRoyalty.MoveNext;
            }
        }
        catch (e)
        {
            Response.Write(e.message);
        }
        finally
        {
            // clean up
            if (rsByRoyalty.State == adStateOpen)
                rsByRoyalty.Close;
            if (rsAuthor.State == adStateOpen)
                rsAuthor.Close;
            if (Cnxn.State == adStateOpen)
                Cnxn.Close;
            rsByRoyalty = null;
            rsAuthor = null;
            Cnxn = null;
        }
    }
%>

<hr>


<form method="POST" action="AppendJS.asp" id=form1 name=form1>
  <p align="left">Enter royalty percentage to find (e.g., 40): <input type="text" name="RoyaltyValue" size="5"></p>
  <p align="left"><input type="submit" value="Submit" name="B1"><input type="reset" value="Reset" name="B2"></p>
</form>
&nbsp;


</body>

</html>
<!-- EndAppendJS -->






<!-- BeginFilterJS -->
<%@  Language=JavaScript %>
<%// use this meta tag instead of adojavas.inc%>
<!--METADATA TYPE="typelib" uuid="00000205-0000-0010-8000-00AA006D2EA4" -->

<html>

<head>
<title>ADO Recordset.Filter Example</title>
<style>
<!--
BODY {
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   BACKGROUND-COLOR:white;
   COLOR:black;
    }
.thead {
   background-color: #008080;
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   font-size: x-small;
   color: white;
   }
.thead2 {
   background-color: #800000;
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   font-size: x-small;
   color: white;
   }
.tbody {
   text-align: center;
   background-color: #f7efde;
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   font-size: x-small;
    }
-->
</style>
</head>

<body bgcolor="White">

<h1>ADO Recordset.Filter Example</h1>
<!-- Page text goes here -->
<%
    // connection and recordset variables
    var Cnxn = Server.CreateObject("ADODB.Connection")
    var strCnxn = "Provider='sqloledb';Data Source=" + Request.ServerVariables("SERVER_NAME") + ";" +
            "Initial Catalog='Northwind';Integrated Security='SSPI';";
    var rsCustomers = Server.CreateObject("ADODB.Recordset");
    var SQLCustomers = "select * from Customers;";
    // record variables
    var fld, filter
    var showBlank = " ";
    var showNull = "-NULL-";

    try
    {
        //open connection
        Cnxn.Open(strCnxn);

        // create recordset client-side using object refs
        rsCustomers.ActiveConnection = Cnxn;
        rsCustomers.CursorLocation = adUseClient;
        rsCustomers.CursorType = adOpenKeyset;
        rsCustomers.LockType = adLockOptimistic;
        rsCustomers.Source = SQLCustomers;
        rsCustomers.Open();

        rsCustomers.MoveFirst();

        //set filter
        filter = "CompanyName LIKE 'b*'";
        rsCustomers.Filter = filter

        if (rsCustomers.RecordCount == 0) {
            Response.Write("No records matched ");
            Response.Write (SQLCustomers + "So cannot make table...");
            Cnxn.Close();
            Response.End
        }
        else {
        // show the data
            Response.Write('<table width="100%" border="2">');
            while(!rsCustomers.EOF) {
                Response.Write('<tr class="tbody">');
                for (var thisField = 0; thisField < rsCustomers.Fields.Count; thisField++) {
                    fld = rsCustomers(thisField);
                    fldValue = fld.Value;
                    if (fldValue == null)
                        fldValue = showNull;
                    if (fldValue == "")
                        thisField=showBlank;
                    Response.Write("<td>" + fldValue + "</td>")
                }
                rsCustomers.MoveNext();
                Response.Write("</tr>");
            }
            // close the table
            Response.Write("</table>");
        }
    }
    catch (e)
    {
        Response.Write(e.message);
    }
    finally
    {
        // clean up
        if (rsCustomers.State == adStateOpen)
            rsCustomers.Close;
        if (Cnxn.State == adStateOpen)
            Cnxn.Close;
        rsCustomers = null;
        Cnxn = null;
    }
%>

</body>

</html>
<!-- EndFilterJS -->

<!-- BeginActualSizeJS -->
<%@LANGUAGE="JScript" %>
<%// use this meta tag instead of adojavas.inc%>
<!--METADATA TYPE="typelib" uuid="00000205-0000-0010-8000-00AA006D2EA4" -->
<html>

<head>
    <title>ActualSize and DefinedSize Properties Example (JScript)</title>
<style>
<!--
body {
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   BACKGROUND-COLOR:white;
   COLOR:black;
    }
.thead2 {
   background-color: #800000;
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   font-size: x-small;
   color: white;
   }
.tbody {
   text-align: center;
   background-color: #f7efde;
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   font-size: x-small;
    }
-->
</style>
</head>

<body bgcolor="White">

<h1>ADO ActualSize and DefinedSize Properties (JScript)</h1>
<%
    // connection and recordset variables
    var Cnxn = Server.CreateObject("ADODB.Connection")
    var strCnxn = "Provider='sqloledb';Data Source=" + Request.ServerVariables("SERVER_NAME") + ";" +
            "Initial Catalog='Northwind';Integrated Security='SSPI';";
    var rsSuppliers = Server.CreateObject("ADODB.Recordset");
    // display variables
    var fld, strMessage;

    try
    {
        // open connection
        Cnxn.Open(strCnxn);

        // Open a recordset on the stores table
        rsSuppliers.Open("Suppliers", strCnxn);

        // build table headers
        Response.Write("<table>");
        Response.Write('<tr class="thead2"><th>Field Value</th>');
        Response.Write("<th>Defined Size</th>");
        Response.Write("<th>Actual Size</th></tr>");

        while (!rsSuppliers.EOF)
        {
            // start a new line
            strMessage = '<tr class="tbody">';

            // Display the contents of the chosen field with
            // its defined size and actual size
            fld = rsSuppliers("CompanyName");
            strMessage += '<td align="left">' + fld.Value + "</td>"
            strMessage += "<td>" + fld.DefinedSize + "</td>";
            strMessage += "<td>" + fld.ActualSize + "</td>";

            // end the line
            strMessage += "</tr>";

            // display data
            Response.Write(strMessage);

            // get next record
            rsSuppliers.MoveNext;

        }
         // close the table
        Response.Write("</table>");
    }
    catch (e)
    {
        Response.Write(e.message);
    }
    finally
    {
        // clean up
        if (rsSuppliers.State == adStateOpen)
            rsSuppliers.Close;
        if (Cnxn.State == adStateOpen)
            Cnxn.Close;
        rsSuppliers = null;
        Cnxn = null;
    }
%>

</body>

</html>
<!-- EndActualSizeJS -->


<!-- BeginActiveConnectionJS -->
<%@LANGUAGE="JScript"%>
<%// use this meta tag instead of adojavas.inc%>
<!--METADATA TYPE="typelib" uuid="00000205-0000-0010-8000-00AA006D2EA4" -->

<html>
<head>
    <title>ActiveConnection, CommandText, CommandTimeout, CommandType, Size, and Direction Properties</title>
<style>
<!--
BODY {
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   BACKGROUND-COLOR:white;
   COLOR:black;
    }
.thead {
   background-color: #008080;
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   font-size: x-small;
   color: white;
   }
.thead2 {
   background-color: #800000;
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   font-size: x-small;
   color: white;
   }
.tbody {
   text-align: center;
   background-color: #f7efde;
   font-family: 'Verdana','Arial','Helvetica',sans-serif;
   font-size: x-small;
    }
-->
</style>
</head>

<body bgcolor="White">

<%
    var iRoyalty = parseInt(Request.Form("RoyaltyValue"));
    // check user input

    if (iRoyalty > -1)
    {
            // connection and recordset variables
        var Cnxn = Server.CreateObject("ADODB.Connection")
        var strCnxn = "Provider='sqloledb';Data Source=" + Request.ServerVariables("SERVER_NAME") + ";" +
            "Initial Catalog='pubs';Integrated Security='SSPI';";
        var cmdByRoyalty = Server.CreateObject("ADODB.Command");
        var rsByRoyalty = Server.CreateObject("ADODB.Recordset");
        var rsAuthor = Server.CreateObject("ADODB.Recordset");
        // display variables
        var filter, strMessage;

        try
        {
            // open connection
            Cnxn.Open(strCnxn);

            cmdByRoyalty.CommandText = "byroyalty";
            cmdByRoyalty.CommandType = adCmdStoredProc;
            cmdByRoyalty.CommandTimeOut = 15;

            // The stored procedure called above is as follows:
                //    CREATE PROCEDURE byroyalty
                //  @percentage int
                //    AS
                //  SELECT au_id from titleauthor
                //  WHERE titleauthor.royaltyper = @percentage
                //  GO

            prmByRoyalty = Server.CreateObject("ADODB.Parameter");
            prmByRoyalty.Type = adInteger;
            prmByRoyalty.Size = 3;
            prmByRoyalty.Direction = adParamInput;
            prmByRoyalty.Value = iRoyalty;
            cmdByRoyalty.Parameters.Append(prmByRoyalty);

            cmdByRoyalty.ActiveConnection = Cnxn;

            // recordset by Command - Execute
            rsByRoyalty = cmdByRoyalty.Execute();

            // recordset by Recordset - Open
            rsAuthor.Open("Authors", Cnxn);

            while (!rsByRoyalty.EOF)
            {
                // set filter
                filter = "au_id='" + rsByRoyalty("au_id")
                rsAuthor.Filter = filter + "'";

                // start new line
                strMessage = "<P>";

                // get data
                strMessage += rsAuthor("au_fname") + " ";
                strMessage += rsAuthor("au_lname") + " ";

                // end line
                strMessage += "</P>";

                // show data
                Response.Write(strMessage);

                // get next record
                rsByRoyalty.MoveNext;
            }
        }
        catch (e)
        {
            Response.Write(e.message);
        }
        finally
        {
            // clean up
            if (rsByRoyalty.State == adStateOpen)
                rsByRoyalty.Close;
            if (rsAuthor.State == adStateOpen)
                rsAuthor.Close;
            if (Cnxn.State == adStateOpen)
                Cnxn.Close;
            rsByRoyalty = null;
            rsAuthor = null;
            Cnxn = null;
        }
    }
%>

<hr>


<form method="POST" action="ActiveConnectionJS.asp">
  <p align="left">Enter royalty percentage to find (e.g., 40): <input type="text" name="RoyaltyValue" size="5"></p>
  <p align="left"><input type="submit" value="Submit" name="B1"><input type="reset" value="Reset" name="B2"></p>
</form>
&nbsp;


</body>

</html>
<!-- EndActiveConnectionJS -->





var _rr = [1,2]
_rr.pop();

Response.Write('<hr>pop___'+parseInt(5.12))
Response.Write('<hr />'+codecoke.creat.guid().length)

Response.Write('<hr> isstrnull:__'+codecoke.check.isStrNull('null'))

Response.Write('<hr>mail : '+codecoke.req.queryStr('myMail ','mail')+'<br>'+codecoke.scriptVersion.publishdate);

//var tmd5;

//Server.Execute('./strMd5.asp');

//Response.Write(tmd5('abc'));


//Response.Write(Request.QueryString('mymail')+'')

//Response.Write('<hr>'+'1我'.strSize()+'___'+codecoke.get.num('0') )
//Response.Write(codecoke.query.str())

//Response.Write('<br/>'+isFinite(parseInt('0'))+parseInt('100000456800000017000300000000000000000000000000001'))
//Response.Write((''+null).toLowerCase())
/*function ShowDriveList(){
   var fso, s, n, e, x;                     // 声明变量。
   fso = new ActiveXObject("Scripting.FileSystemObject");
   e = new Enumerator(fso.Drives);          // 在驱动器上创建 Enumerator。
   s = "";
   for (;!e.atEnd();e.moveNext())           // 枚举驱动器集合。
      {
         x = e.item();
         s = s + x.DriveLetter;
         s += " - ";
         if (x.DriveType == 3)              // 查看是否网络驱动。
            n = x.ShareName;                // 获取共享名。
         else if (x.IsReady)                // 查看驱动器是否已就绪。
            n = x.VolumeName;               // 获取卷名。
         else
            n = "[驱动器未就绪]";
         s +=  n + "<br>";
      }
   return(s);                               // 返回活动驱动器列表。
}



 var A = function() {};
     * A.prototype.foo = 'foo';
     * var a = new A();
     * a.foo = 'foo';
     * alert(a.hasOwnProperty('foo')); // true
     * alert(YAHOO.lang.hasOwnProperty(a, 'foo')); // false when using fallback
     * </pre>
var _A = function() {};
_A.prototype.fo1 ='fo1'

var _a = new _A();
_a.foo='fo1';
_a.fo1='fo1'

,




	getQuery : function(_n,_type) {
		if(codecoke.check.isStrNull(_n)|| !Request[_type]) return null;
		_n =(''+_n).trim();
		var _v = null;
		switch (true) {
		case (_type=='QueryString') :
			_v =  ''+Request[_type](_n);
			this._str = (_v==='undefined') ? null : _v;
			break;
		default:
			this._str =''+_type;

		}

	},
	string : function (_n) {

	}
*/

//;

//Response.Write(codecoke.query.string('id'))

//Response.Write(codecoke.check.isArray([codecoke,{'foo':'foo1'}]))


//Response.Write(codecoke.check.isUndefined(Request.ServerVariables("HTTP_REFERER")))
//Response.Write(codecoke.check.isString(Request.ServerVariables('HTTP_REFERER')))


//Response.Write(_a.hasOwnProperty('fo1'))

//Response.Write(codecoke.check.hasOwnProperty(_a,'fo1'))

//Response.Write(codecoke.check.isObject(codecoke.authorMail))

//Response.Write(codecoke.check.isFunction(codecoke.check.isFunction))

//Response.Write(codecoke.check.isNumber(12/2))





//莫非 429f15e6e8527fd4










%>