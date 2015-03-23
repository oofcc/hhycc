<%If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
Set Upload = GetObject("script:" & Server.MapPath("FyUpload.sct"))
Upload.ReadForm
Upload.SaveFile
If Upload.Field.upfile.Message = "" Then
Response.Write "<a href=" & Upload.Field.upfile.FileName & ">обть</a>"
Else
Response.Write Upload.Field.upfile.Message
End If
Upload.Dispose
Set Upload = Nothing
End If%><form enctype="multipart/form-data" method="post">
<input name="upfile" type="file"><input type="submit"></form>