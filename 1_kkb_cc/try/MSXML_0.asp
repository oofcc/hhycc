<%
/*
var xsldoc = new ActiveXObject("Msxml2.FreeThreadedDOMDocument.3.0");
var xmldoc = new ActiveXObject("Msxml2.FreeThreadedDOMDocument.3.0");
var xsltemp = new ActiveXObject("Msxml2.XSLTemplate.3.0");
var xslproc;

xsldoc.load("sampleXSLWithObject.xml");
if (xsldoc.parseError.errorCode != 0) {
   var myErr = xsldoc.parseError;
   WScript.Echo("You have error " + myErr.reason);
} else {
   xsltemp.stylesheet = xsldoc.documentElement;
   xslproc = xsltemp.createProcessor();
   xmldoc.loadXML("<level>Twelve</level>");
   xslproc.input = xmldoc;

   xslproc.addObject(xmldoc, "urn:my-object");
   xslproc.transform();
   WScript.Echo(xslproc.output);
}

var objSrvHTTP;
   var objXMLDocument;
   objSrvHTTP = Server.CreateObject ("Msxml2.ServerXMLHTTP.3.0");
   objXMLDocument = Server.CreateObject ("Msxml2.DOMDocument.3.0");

   objXMLDocument.async= false;
   objXMLDocument.loadXML ("<msg><id>1</id></msg>");

   objSrvHTTP.open ("POST","http://someotherserver/respond.asp",false);
   objSrvHTTP.send (objXMLDocument);
   Response.ContentType = "text/xml";
   Response.Write (objSrvHTTP.responseXML.xml);

var objSrvHTTP;
   var objXMLSend;
   var objXMLReceive;
   objSrvHTTP = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0");
   objXMLSend = Server.CreateObject("Msxml2.DOMDocument.3.0");
   objXMLReceive = Server.CreateObject("Msxml2.DOMDocument.3.0");

   objXMLSend.async = false;
   objXMLSend.loadXML ("<msg><id>2</id></msg>");

   objSrvHTTP.open ("POST","http://someotherserver/respond.asp",false);
   objSrvHTTP.send (objXMLSend);
   objXMLReceive = objSrvHTTP.responseXML;
   Response.ContentType = "text/xml";
   Response.Write (objXMLReceive.xml);


 var objSrvHTTP;
   objSrvHTTP = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0");
   objSrvHTTP.open ("GET","http://someotherserver/secure.asp",false, _
                       "testuser", "testpassword";
   objSrvHTTP.send ();
   Response.ContentType = "text/xml";
   Response.Write (objSrvHTTP.responseXML.xml);



Client-Side Code


The following code sample provides a client-side file upload using Stream and MSXML objects:


<HTML>
<HEAD><TITLE>File Send</TITLE></HEAD>
<BODY>
   <INPUT id=btn_send name="btn_send" type=button value="FILE SEND">
   <DIV id=div_message>Ready</DIV>
</BODY>
</HTML>

<SCRIPT LANGUAGE=JavaScript>

// files upload function
function btn_send.onclick()
{
   // create ADO-stream Object
   var ado_stream = new ActiveXObject("ADODB.Stream");

   // create XML document with default header and primary node
   var xml_dom = new ActiveXObject("MSXML2.DOMDocument");
   xml_dom.loadXML('<?xml version="1.0" ?> <root/>');
   // specify namespaces datatypes
   xml_dom.documentElement.setAttribute("xmlns:dt", "urn:schemas-microsoft-com:datatypes");

   // create a new node and set binary content
   var l_node1 = xml_dom.createElement("file1");
   l_node1.dataType = "bin.base64";
   // open stream object and read source file
   ado_stream.Type = 1;  // 1=adTypeBinary
   ado_stream.Open();
   ado_stream.LoadFromFile("c:\\tmp\\myfile.doc");
   // store file content into XML node
   l_node1.nodeTypedValue = ado_stream.Read(-1); // -1=adReadAll
   ado_stream.Close();
   xml_dom.documentElement.appendChild(l_node1);

   // we can create more XML nodes for multiple file upload

   // send XML documento to Web server
   var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
   xmlhttp.open("POST","./file_recieve.asp",false);
   xmlhttp.send(xml_dom);
   // show server message in message-area
   div_message.innerHTML = xmlhttp.ResponseText;
}
</SCRIPT>


Server-Side Code


The following code sample provides a server-side file upload using the same objects:



   Response.Expires = 0

   ' define variables and COM objects
   dim ado_stream
   dim xml_dom
   dim xml_file1

   ' create Stream Object
   set ado_stream = Server.CreateObject("ADODB.Stream")
   ' create XMLDOM object and load it from request ASP object
   set xml_dom = Server.CreateObject("MSXML2.DOMDocument")
   xml_dom.load(request)
   ' retrieve XML node with binary content
   set xml_file1 = xml_dom.selectSingleNode("root/file1")

   ' open stream object and store XML node content into it
   ado_stream.Type = 1  ' 1=adTypeBinary
   ado_stream.open
   ado_stream.Write xml_file1.nodeTypedValue
   ' save uploaded file
   ado_stream.SaveToFile "c:\tmp\upload1.doc",2  ' 2=adSaveCreateOverWrite
   ado_stream.close

   ' destroy COM object
   set ado_stream = Nothing
   set xml_dom = Nothing
   ' write message to browser
   Response.Write "Upload successful!"
%>


function Base64EncodeFile(fileSpec){
var xml_dom = new ActiveXObject("MSXML2.DOMDocument");
var ado_stream = new ActiveXObject("ADODB.Stream");
var tmpNode = xml_dom.createElement("tmpNode");
tmpNode.dataType = "bin.base64";

ado_stream.Type = 1; // 1=adTypeBinary
if(ado_stream.state==0){ // 0=adStateClosed 1=adStateOpen
ado_stream.Open();
}
ado_stream.LoadFromFile(fileSpec);
tmpNode.nodeTypedValue = ado_stream.Read(-1); // -1=adReadAll
ado_stream.Close();

return tmpNode.text;
}

function Base64EncodeText(TextStr){
var xml_dom = new ActiveXObject("MSXML2.DOMDocument");
var ado_stream = new ActiveXObject("ADODB.Stream");
var tmpNode = xml_dom.createElement("tmpNode");
tmpNode.dataType = "bin.base64";

ado_stream.Charset = "gb2312";
ado_stream.Type = 2; // 1=adTypeBinary 2=adTypeText
if(ado_stream.state==0){ // 0=adStateClosed 1=adStateOpen
ado_stream.Open();
}
ado_stream.WriteText(TextStr);
ado_stream.Position = 0;
ado_stream.Type = 1; // 1=adTypeBinary 2=adTypeText
tmpNode.nodeTypedValue = ado_stream.Read(-1); // -1=adReadAll
ado_stream.Close();

return tmpNode.text;
}
function Base64DecodeText(Base64Str){
var xml_dom = new ActiveXObject("MSXML2.DOMDocument");
var ado_stream = new ActiveXObject("ADODB.Stream");
var tmpNode = xml_dom.createElement("tmpNode");
tmpNode.dataType = "bin.base64";
tmpNode.text = Base64Str;

ado_stream.Charset = "gb2312";
ado_stream.Type = 1; // 1=adTypeBinary 2=adTypeText
ado_stream.Open();
ado_stream.Write(tmpNode.nodeTypedValue);
ado_stream.Position = 0;
ado_stream.Type = 2; // 1=adTypeBinary 2=adTypeText
var str = ado_stream.ReadText(-1); // -1=adReadAll
ado_stream.Close();

return str;
}


*/


%>