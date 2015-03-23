/*codecoke_query_0 w@codecoke.com 2011/5/9*/

codecoke.fn.declareClassByArr([
{
	'_basic_':{
		'name':'_NS_get_iEscape'
		,'fn':function(_f62,_k){
			this.attr={'s':_f62,'k':_k,'ka':_f62.split('')};
			!this.attr.k &&(this.attr.k=this.gk());
		}
	}
	,'_Di':function(_n,_arr,K){_arr[_arr.length]=(K||this.attr.k).charAt(_n);}
	,'_Ui':function(_y,s,K){return(K||this.attr.k).indexOf(s.charAt(_y));}
	,'gk':function(){return this.attr.ka.sort(function(){return(Math.random()<0.5)?1:-1;}).join('');}
	,'de':function(_str,K){var nl=_str.length,_arr=[],a,b,c,x,N2=62*62,N5=62*5;for(x=0;x<nl;x++){a=_str.charCodeAt(x);a<N5?(this._Di(Math.floor(a/62),_arr,K),this._Di(a%62,_arr,K)):(this._Di(Math.floor(a/N2)+5,_arr,K),this._Di(Math.floor(a/62)%62,_arr,K),this._Di(a%62,_arr,K));}b=_arr.join('');c=b.length;return(String(c).length+String(c)+b);}
	,'dei':function(_str,_k){var K=_k||this.gk();return this.de(_str,K)+K;}
	,'un':function(_str,K){var c=_str.charAt(0)*1;if(isNaN(c)){return'';}c=_str.substr(1,c)*1;if(isNaN(c)){return'';}var nl=_str.length,_arr=[],a,f,b,x=String(c).length+1;if(nl!=x+c){return''}while(x<nl){a=this._Ui(x++,_str,K);f=(a<5)?(a*62+this._Ui(x,_str,K)):((a-5)*62*62+this._Ui(x,_str,K)*62+this._Ui(x+=1,_str,K));_arr[_arr.length]=String.fromCharCode(f);x++;}return _arr.join('');}
	,'uni':function(_str){if(!_str){return'';}var _l=_str.length-62;if(_l<1){return this.un(_str);}return this.un(_str.substring(0,_l),_str.substring(_l));}
}
,
{
	'_basic_':{
		'name':'_doc_UI_paper'
		,'fn':function(_doc) {
				this.doc = _doc;
				this.el_parent = this.doc.attr.Els.iWallpaper || $('body');
				this.attr={
					'winid':'win_paper_all'
					,'conid':'win_paper_content'
					,'boxid':'win_paper_box'
					,'barid':'win_paper_bar'
					,'toolid':'win_paper_tool'
					,'zoneClassName':'win_paper_zone'
				};
				this.el = $('#'+this.attr.winid);
		}
	}
	,'winhide':function(_id) {
		_id && $('#paper_'+_id).length && !$('#paper_'+_id).hasClass('iSkip') && $('#paper_'+_id).addClass('iSkip');
		!this.el.hasClass('iSkip') && this.el.addClass('iSkip');
	}
	,'show':function(_id) {
		_id && $('#paper_'+_id).length && $('#paper_'+_id).hasClass('iSkip') && $('#paper_'+_id).removeClass('iSkip');
		 this.el.removeClass('iSkip');
	}
	,'clear':function() {
		this.el_box.empty();
		this.winhide();
	}
	,'creatPaperWin':function() {
		if (this.el.length) {return;}
			this.el_parent.append(
				$('<div id="'+this.attr.winid+'" class="'+this.attr.winid+'"></div>')
				.append(
					$('<div id="'+this.attr.conid+'" class="'+this.attr.conid+'"></div>')
					.append(
							$('<div id="'+this.attr.barid+'" class="'+this.attr.barid+'">&nbsp;</div>')
							.prepend(
									$('<span />', {'text': '╳  关闭窗口','class':'cHand','click': codecoke.get.bindFn(this,this.winhide)})
							).prepend('<span class="iL">▉</span>')
					).append('<div id="'+this.attr.toolid+'" class="'+this.attr.toolid+'"></div><div id="'+this.attr.boxid+'" class="'+this.attr.boxid+'"></div>')
				)
			);
			this.el=$('#'+this.attr.winid);
			this.el_tool=$('#'+this.attr.toolid);
			this.el_bar=$('#'+this.attr.barid);
			this.el_box=$('#'+this.attr.boxid);

	}
	,'add':function(_el,_barShow,_JustShowMeOnly) {
			this.creatPaperWin();
			if (!_el) {return;}
			var _paper_id,_me;
			if (codecoke.is.Str(_el)) {
				_el.indexOf('#')==0 &&(_paper_id='paper_'+_el.substring(1));
				_el = $(_el);
			}
			_paper_id=_paper_id
						|| (	'paper_'+( _el.length && ('attr' in _el) ? _el.attr('id') :'') )
						|| 'notPaperIdName'
			;
			_me = $('#'+_paper_id);
			this.el.hasClass('iSkip') && this.el.removeClass('iSkip');
			_JustShowMeOnly && $('div.'+this.attr.zoneClassName,this.el_box).not('.iSkip').addClass('iSkip');

		if (!_me.length ){
			this.el_box.append($('<div id="'+_paper_id+'" class="'+this.attr.zoneClassName+'"></div>').append(_el));
			_me =$('#'+_paper_id);
		}else {
			!$(_el).closest(_me).length && _me.append(_el);
		}
		_me.hasClass('iSkip') && _me.removeClass('iSkip');
		(_barShow && this.el_bar.removeClass('iSkip')) || this.el_bar.addClass('iSkip');

	}
	,'remove':function(_id) {
		if (!_id || !$('#paper_'+_id).length) {return false;}
		$('#paper_'+_id).empty();
		return true;
	}
}
,
{
	'_basic_':{
		'name':'_doc_ihead'
		,'fn':function(_doc) {
			this.doc =_doc;
			this.el=this.doc.attr.Els.iHead;

			//this.clearEl=$('#ihead2Clear');
			this.el_top =$('#iHeadtop');
			this.el_topright=$('#iHeadtopright');
			this.el_topleft=$('#iHeadtopleft');
			codecoke.fn.newFunIn(this,'msg','_doc_ihead_msg',this);
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
		'name':'_doc_foot'
		,'fn':function(_doc) {
			this.doc =_doc;
			this.el=this.doc.attr.Els.iFoot;
			this.poweredEl=this.doc.attr.Els.powered;
			this.nav=this.doc.attr.Els.footNav;
			this._size =this.el.offset();
		}
	}
}
,{
	'_basic_':{
		'name':'_doc_ihead_msg'
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
]);


