<%
codecoke.fn.declareClass({
	'_basic_':{
		'name':'C_server_file'
		,'fn':function() {
			//this.sett={};
			this.attr={};
			this._d={};
			this.fn={};
		}
	}
	,'creat':function  (_n) {
		if (this.attr[_n]) {return this.attr[_n];}
		!GC.serverobj && codecoke.fn.newFunIn(GC,'serverobj','C_server_serverobject');
		this.attr[_n] =GC.serverobj.creat(_n);
		_n =='xhr' && (this.attr.xhrVasion=GC.serverobj.attr.xhrVasion);
	}
	,'getdriversarr':function() {
		if (!this._d.driversarr) {
			this._d.driversarr=[];
			this.creat('fso');
			var _d =new Enumerator(this.attr.fso.Drives);
			this.close('fso');
			 for (; !_d.atEnd(); _d.moveNext()){
				if (_d.item().DriveType===2) {
					this._d.driversarr.push(_d.item().DriveLetter);
				}

			 }
			 _d =null;

		}
		 return this._d.driversarr;
		//return this.sett.driversarr;
	}
	,'close':function (_n) {
		this.attr[_n]=GC.serverobj.close(_n);
	}
	,'exists':function(_f,_t) {
		if (!_f) {return 0;}
		_t = _t &&(_t=='file' || _t=='folder')
		? _t
		: /.+\.[a-zA-Z]{2,4}$/.test(''+_f) ? 'file' :'folder'
		;
		return _t=='file' ? this.isfilehas(_f) : this.isfolderhas(_f);
	}
	,'isfilehas':function(_urlfile) {
		this.creat('fso');
		var _r =0;
		try {
			this.attr.fso.FileExists(Server.MapPath(_urlfile)) &&(_r=1);
			//this.close('fso');
		}catch (e) {
			//=e.description;
			//this.close('fso');
		}finally{
			this.close('fso');
		}
		return _r;
	}
	,'isfolderhas':function(_folder) {
		this.creat('fso');
		var _r =0;
		try {
			this.attr.fso.FolderExists(Server.MapPath(_folder)) &&(_r=1);
		}catch (e) {
			//_r=e.description;
		}finally{
			this.close('fso');
		}
		return _r;
	}
	,'readtxt':function(_urlfile) {
		var _r={'err':'err_file_readtxt:'+_urlfile};
		try {
			this.creato('adostr');
			this.attr.adostr.type=2;
			this.attr.adostr.mode=3;
			this.attr.adostr.charset='utf-8';
			this.attr.adostr.open;
			this.attr.adostr.LoadFromFile(Server.MapPath(_urlfile));
			_r.txt=(''+this.attr.adostr.readtext).replace(/^[\s\t ]+|[\s\t ]+$/g,'');
			//this.close('adostr');
			delete _r.err;
			//_r.err =null;
		}catch (e) {
			_r.err='err_file_readtxt:'+e.description;
			//this.close('adostr');
			//_r.msg=null;
		}finally{
			this.close('adostr');
		}
		return _r;
	}
	,'str_txt2obj':function(_t) {
		var _q1 = _t.indexOf("'"),_q2= _t.indexOf('"'),_q =(_q2>0 && _q2<_q1) ? 0 :1;
		try {_t= _q ? eval('('+_t+')') : eval("("+_t+")") ;}catch (e) {_t= 'err_file_str_txt2obj:'+e.description;}
		return _t;
	}
	,'readtxt2obj':function(_urlfile) {
		var _r=this.readtxt(_urlfile);
		return (_r.err || !_r.txt) ? 'err_file_readtxt2obj:'+_r.err : this.str_txt2obj(_r.txt);
	}
});
%>