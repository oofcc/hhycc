<%
codecoke.fn.declareClass({
	'_basic_':{
		'name':'C_server_xhr'
		,'fn':function() {
			this.attr={'timeArr':[2000, 2000, 2000, 20000]};
		}
	}
	,'creat':function(_n) {
		if (this.attr[_n]) {return this.attr[_n];}
		this.attr[_n] =GC.serverobj.creat(_n);
		_n =='xhr' && (this.attr.xhrVasion=GC.serverobj.attr.xhrVasion);
	}
	,'close':function(_n) {
		this.attr[_n]=GC.serverobj.close(_n);
	}
	,'loadtxtO':function(_url,_headerArr,_timeArr) {
		if (!_url) {return '{"err":"err_pas:need_xhr_get_url"}';}
		this.creat('xhr');
		this.attr.xhrVasion !=='Microsoft.XMLHTTP'
		?	 (
				_timeArr && codecoke.is.Arr(_timeArr)
				? this.attr.xhr.setTimeouts(
					(_timeArr[0] || this.attr.timeArr[0] ),(_timeArr[1] || this.attr.timeArr[1] )
					,(_timeArr[2] || this.attr.timeArr[2] ),(_timeArr[3] || this.attr.timeArr[3])
				)
				: this.attr.xhr.setTimeouts(this.attr.timeArr[0],this.attr.timeArr[1],this.attr.timeArr[2],this.attr.timeArr[3])
			)
		:	''
		;

		var _r ={};
		var _al =arguments.length;
		try {
			this.attr.xhr.open('GET',_url,false);
			if (_headerArr && codecoke.is.Arr(_headerArr) && _headerArr.length) {
				for (var _i=0,_x=_headerArr.length; _i<_x; _i++) {
					_headerArr[_i][0]
					&& undefined !== _headerArr[_i][1]
					&& this.attr.xhr.setRequestHeader(_headerArr[_i][0],_headerArr[_i][1])
					;
				}
			}
			this.attr.xhr.send();
			if (this.attr.xhr.status == 200) {
				_r.txt =this.attr.xhr.responseText;
			}else {
				_r.err = 'err_'+this.attr.xhr.status+':'+this.attr.xhr.statusText
			}
		}catch (e) {
			_r.err = 'err_xhr:'+ (e.number && e.number == -2147012894 ? '_linksTimeOut' :'')+e.description;
		}finally{
			if (codecoke.is.Func(arguments[arguments.length-1])) {
				arguments[arguments.length-1].call(this,this.attr.xhr,_r);
			}
			this.close('xhr');
		}
		return _r;
	}

});


%>