風雲ASP(组件&无组件)上传 [2006-11-30]

最新的组件发布地址是：http://www.zope.org/Members/Rimifon/FyUpload.sct，需要最新版本，请留意该文件的最后更新时间
本组件会尽早同步更新发布在中国站长站（www.chinaz.com）。

有组件上传：
	第一次使用需要右键“FyUpload.sct”文件 - 注册
	创建对象：Set Upload = Server.CreateObject("Rimifon.Upload")

无组件上传：
	创建对象：Set Upload = GetObject("script:组件地址#Upload")
	组件地址为硬盘绝对路径，也可以为http完整路径(针对IIS 5.0)

简单测试代码：
/-*- Upload.html -*-/
<form method=post action=Upload.asp enctype=multipart/form-data>
<input name=MyFile type=file>
<input type=submit></form>

/-*- Upload.asp -*-/
<%Set Upload = Server.CreateObject("Rimifon.Upload")
Upload.ReadForm 204800	' 设置缓冲区大小，Windows 2003默认不允许超过204800，否则会上传失败。
Upload.SaveFile		' 保存文件到当前目录，如需保存到Upload目录下，则使用SaveFile "Upload"
Upload.Dispose		' 释放内存
Set Upload = Nothing%>

其它详细属性和方法：
Upload.Charset	' 当页面编码为utf-8时请设置该值为"UTF-8"，默认为"gb2312"
Upload.Filter	' 设置允许上传的文件类型，默认为“rar|zip|txt|gif|jpg|bmp|htm|html|swf|mht”，为空则允许任何格式文件上传。
Upload.MaxSize	' 设置单个文件允许上传的最大大小（Bytes），如不限制则为0（默认为0）
Upload.Field	' 客户端提交的表单元素；
			针对文本元素：Upload.Field.test.Value	' 读出表单元素"test"的值
			针对文件元素：
				Upload.Field.MyFile.FilePath	' 读出文件在客户端的位置
				Upload.Field.MyFile.SourceName	' 读出文件的源文件名
				Upload.Field.MyFile.FileName	' 文件保存在服务器的文件名
				Upload.Field.MyFile.FileSize	' 读出文件大小
				Upload.Field.MyFile.FileType	' 读出文件的Mime类型
				Upload.Field.MyFile.SavePath	' 获取或设置该文件保存位置的绝对路径
				Upload.Field.MyFile.Message	' 服务器拒绝该文件时返回的信息
				Upload.Field.MyFile.Value	' 文件数据（unicode字符）
				存数据库时直接使用rs("FileData").AppendChunk Upload.Field.MyFile.Value的方式即可
Upload.Form("test")	' 返回表单元素"test"的值，是Upload.Field.test.Value的简化读取方式，当不存在"test"元素时返回空值。
Upload.ReadForm FormSize, ProgID
			读取表单，FormSize为缓冲区大小，默认为0，推荐在204800以下（可解决2003下不能上传大文件的问题）。
			提供参数2(ProgID)会为上传提供进度数据（Application），需要上传进度条时才用到这个参数。
				总文件大小：Application(ProgID + "_TotalBytes")
				已上传数据量：Application(ProgID + "_ReadBytes")
				进度条统计完毕后，建议清除这两个变量：Application.Contents.Remove(ProgID + "_TotalBytes")
Upload.SaveFile SavePath
			保存文件到当前目录的SavePath（该目录必需存在）下，默认为当前目录。
Upload.Dispose		释放内存

附带代码：
	Test_00.asp	vbs(asp) 调用简单示例
	Test_01.asp	指定保存位置测试