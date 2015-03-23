<HTML>
<HEAD>
<TITLE>AspJpeg User Manual Chapter 1 - Quick Start</TITLE>
</HEAD>
<BODY>

<%@LANGUAGE=VBSCRIPT CODEPAGE=65001%>

<%

'On Error Resume Next




' Create instance of AspJpeg
Set Jpeg = Server.CreateObject("persits.jpeg")
'Jpeg.RegKey = "lptn9dQO1enAePApb2wFaCZawYWzfm07lHujBk+G6n06ACJljlaLWRlBUnc9ClZzDNy+YSgbaIVb"

'Jpeg.RegKey ="04199-91425-50868"
' Compute path to source image
Path = Server.MapPath(".") & "/apple_small.jpg"

' Open source image
Jpeg.Open Path

' Decrease image size by 50%
Jpeg.Width = Jpeg.OriginalWidth /2
Jpeg.Height = Jpeg.OriginalHeight / 2

' create thumbnail and save it to disk
Jpeg.Save Server.MapPath("apple_small3.jpg")

Response.Write Jpeg.Expires

%>

<hr>Original Image:<BR>
<IMG SRC="apple_small.jpg"><P>

Thumbnail (50%):<BR>
<IMG SRC="apple_small3.jpg">



</BODY>
</HTML>
