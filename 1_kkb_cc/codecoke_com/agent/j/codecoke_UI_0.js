/**/
codecoke.fn.declareClassByArr([
{
	'_basic_':{
		'name':'_NS_doc_UI_paper'
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
		'name':'_NS_doc_UI'
		,'fn':function(_doc) {
			this.doc =_doc;
			this.attr={};
			this._ini_();
		}
	}
	,'_ini_':function() {
		codecoke.fn.newFunIn(this,'paper','_NS_doc_UI_paper',this.doc);
	}
	,'bind_mouseover_liveshow':function(_queryParnetElstr,_queryShowElstr,_cssName) {
			if (!_queryShowElstr) {return false;}
			_cssName = _cssName ||'iShow';

			$(_queryParnetElstr).live({
				'mouseenter':function() {
					!$(this).hasClass(_cssName)
						&& $(_queryShowElstr,$(this).parent()).removeClass(_cssName)
						&& $(this).addClass(_cssName);
				}
				,'mouseleave':function() {
					$(this).hasClass(_cssName)
						&& $(_queryShowElstr,$(this).parent()).removeClass(_cssName);
					}
			})
			;
	}
	,'bind_mouseover_elchildshow':function(_El,_Elchild,_cssName) {
			$(_El).live({
				'mouseenter':function() {
					$(_Elchild,$(this)).removeClass(_cssName);
				}
				,'mouseleave':function() {
					$(_Elchild,$(this)).addClass(_cssName);
				}
			});

	}
	,'bind_hexcall':function(_attrName) {
		 //C3_hexCall="json^$app@userbar_lukasu.signout"
		 var _this =this;
		 $('a[C3_hexCall]').live('click',function() {
					//alert($(this).attr('C3_hexCall'))
					_this.doc.jsload.get($(this).attr('C3_hexCall'));
		 });
	}
	,'alertt':function(_t,_n) {
			var _e =this.attr['win_alert_show_el'] = $('#win_alert_show');
			if (!_e.length) {
				this.paper.add('<div id="win_alert_show"><h3>Window Alert Info</h3><hr/></div>',1)
				_e =$('#win_alert_show');
			}else {
				this.paper.show('win_alert_show');
			}
			if (_n) {
				_e.append($('<p class="cRed pdT5"></p>').text(''+_n)).append($('<div class="bdB1 pd5" />').text(_t))
			}else {
				_e.append($('<div class="bdB1 pd5" />').text(_t))
			}
	}

}
]);