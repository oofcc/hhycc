<%@language="Javascript" codepage="936"%><html><head><%
var arrInfo = new Array;
if(Request.ServerVariables("Request_Method").Item == "POST")
{
	var Upload = GetObject("Script:" + Server.MapPath("FyUpload.sct"));
	Upload.ReadForm(200 * 1024);
	/* 指定file_01的保存位置为C:\，文件名为上传前的文件名 */
	Upload.Field.file_01.SavePath = "C:\\" + Upload.Field.file_01.SourceName;
	Upload.SaveFile(); // 未指定保存位置的使用默认保存路径。
	for(var i in Upload.Field)
	{
		if(Upload.Field[i].Message) arrInfo.push(Upload.Field[i].Message);
	}
	Upload.Dispose();
}
%><title>文件上传</title></head><body>
<form method="post" enctype="multipart/form-data">
<p><%=arrInfo.join("<br>").fontcolor("red")%></p>
<input type="file" name="file_01"><br>
<input type="file" name="file_02"><br>
<input type="file" name="file_03"><br>
<input type="file" name="file_04"><br>
<input type="submit">
</form></body></html>