/*codecoke_query_0 w@codecoke.com 2011/5/9*/

codecoke.fn.declareClassByArr([
{
	'_basic_':{
		'name':'_NS_doc_ihead_msg'
		,'fn':function(_ihead) {
				this.ihead =_ihead;

		}
	}
	,'_getMsgBoxEl':function() {
		if (!this.el || !this.el.length) {
				this.ihead.el.append('<div id="headMsg" class="headMsg"></div>');
				this.el =$('#headMsg');
		}
	}
	,'write':function(_msg,_color,_type) {
			this._getMsgBoxEl();
			_color = (_color || 'red');
			if(codecoke.is.Obj(_msg)) {
				this.el.removeClass('iSkip').append(
					$('<div class="'+_color+'_warning"></div>').append(_msg)
				);
			}else if('add'==_type || (_type && codecoke.is.Num(_type))) {
				this.el.removeClass('iSkip').append(
					$('<div class="'+_color+'_warning"></div>').html(_msg)
				);
			}else {
				this.el.removeClass('iSkip').html('<div class="'+_color+'_warning">'+_msg+'</div>')
			}

			if(_type && codecoke.is.Num(_type) && ! this.inHide) {
				this.inHide=1;
				setTimeout(codecoke.get.bindFn(this,this.hide),_type*1000);
			}
	}
	,'hide':function() {
			if (!this.inHide) {return;}
				this._getMsgBoxEl();
				this.inHide=0;
				this.el.addClass('iSkip').empty();
	}

}
,
{
	'_basic_':{
		'name':'_NS_doc_ihead'
		,'fn':function(_doc) {
			this.doc =_doc;
			this.el=this.doc.attr.Els.iHead;

			//this.clearEl=$('#ihead2Clear');
			this.el_top =$('#iHeadtop');
			this.el_topright=$('#iHeadtopright');
			this.el_topleft=$('#iHeadtopleft');
			codecoke.fn.newFunIn(this,'msg','_NS_doc_ihead_msg',this);
			//<div id="iHeadtopright"></div><div id="iHeadtopleft">&nbsp;</div><div id="iHeadtopmax">
		}
	}
	,'setDocTitle':function(_t,_add) {
		_t = _t || $sev.siteinfo.attr.title||$sev.siteinfo.attr.name;
		try {
			document.title=_add ? document.title+'-'+_t :_t;
		}catch (e) {}

	}
	,'setDocLogo':function(_t,_url) {
		!_url &&_t.indexOf('|')>0 &&(
			_url =_t.substring(0,_t.indexOf('|'))
			,_t = _t.substring(_t.indexOf('|')+1)
		);
		this.doc.attr.Els.iHeadLogo &&	this.doc.attr.Els.iHeadLogo.html('<a href="'+(_url || '/' )+'">'+(_t || $sev.siteinfo.attr.domain ||$sev.localsetting.head.web_rootdomain)+'</a>')
	}
}
,
{
	'_basic_':{
		'name':'_doc_icontent'
		,'fn':function(_doc) {
				this.doc = _doc;
				this.el =this.doc.attr.Els.iContent;
		}
	}
}
,
{
	'_basic_':{
		'name':'_NS_doc_foot'
		,'fn':function(_doc) {
			this.doc =_doc;
			this.el=this.doc.attr.Els.iFoot;
			this.poweredEl=this.doc.attr.Els.powered;
			this.nav=this.doc.attr.Els.footNav;
			this._size =this.el.offset();
		}
	}
}

]);


