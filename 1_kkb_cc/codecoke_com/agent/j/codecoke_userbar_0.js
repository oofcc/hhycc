/**/
codecoke.fn.declareClassByArr([
{
	'_basic_':{
		'name':'_NS_doc_userbar_action'
		,'fn':function(_tp,_o,_doc) {
			//_this = _tp.iuserbar
			this.doc =_tp.doc;
			!this.attr &&(this.attr=_o.iuserbarAttr ||{
						'headtop':{
							'id':'ibar_headtop'
							,'css_id':'iTopUser'
							,'p_id':'iHeadtopright'
							,'bar_id':'ibar_headtop_bar'
							,'con_id':'ibar_headtop_content'
							,'tool_id':'ibar_headtop_tool'
						}
						,'sideright':{
							'id':'ibar_side_right'
							,'p_id':'iCon'

						}
						,'sideleft':{
								'id':'ibar_side_left'
								,'p_id':'iCon'
						}
			});

			var _childAttr= _o.childAttr
			for (var _a in _childAttr) {if( _childAttr.hasOwnProperty(_a) && !_tp[_a]){
					this['_ini_attr_'+_a] && this['_ini_attr_'+_a]();
					this['_ini_child_attr'](_tp,_a,_childAttr[_a]);
			}}
		}
	}
	,'_ini_child_attr':function(_tp,_childName,_childAttr) {
		var _this=this;
			_tp[_childName]={'attr':_childAttr,'mather':_tp};
			_this['child_'+_childName+'_write'] && (
				_tp[_childName]['write']=function() {return _this['child_'+_childName+'_write'].apply(_tp[_childName],Array.prototype.slice.call(arguments));}
			);
	}
	,'_ini_attr_headtop':function() {
			!this.attr.headtop.tmpl &&(this.attr.headtop.tmpl=
				'<div id="{ id}" class="{ id} iTopUser">'
					+'<div id="{ bar_id}" class="{ bar_id} iTopUserBar">#$bar_id$</div>'
					+'<div id="{ con_id}" class="{ con_id} iTopUserContent iSkip">'
						+'<div id="{ tool_id}" class="{ tool_id} iTopUserTool"><a href="#">#{ tool_id}</a><a href="" class="navNow">navNow</a></div>'
						+'<!--div class="iTopUserContentZone">#{ tool_id} after</div-->'
					+'</div>'
				+'</div>'

			)
			;
			!this.attr.headtop.p_el &&( this.attr.headtop.p_el = this.attr.headtop.p_el ||
				(
					$('#'+this.attr.headtop.p_id)[0] ? $('#'+this.attr.headtop.p_id) :this.doc.ihead.el_topright
				)
			)
			;
	}
	,'_ini_attr_sideright':function() {
		//alert('sideright');
		!this.attr.sideright.tmpl &&(this.attr.sideright.tmpl='<div id="{ id}" class="{ id} ">ibar_side_right</div>');
		!this.attr.sideright.p_el &&(this.attr.sideright.p_el = $('#'+this.attr.sideright.p_id));

	}
	,'_ini_attr_sidemax':function() {
		//alert('sideright');
		!this.attr.sidemax.tmpl &&(this.attr.sidemax.tmpl='<div id="{ id}" class="{ id} iConMax"></div>');
		!this.attr.sidemax.p_el &&(this.attr.sidemax.p_el = $('#'+this.attr.sidemax.p_id));

	}

	,'sideright_creat':function() {
			var _sr = this.attr.sideright;
			!$('#'+_sr.id)[0] && _sr.p_el.prepend(codecoke.fn.getTmplate(_sr.tmpl,_sr));
			!_sr.el &&(_sr.el =$('#'+_sr.id));

	}
	,'sidemax_creat':function() {
			var _sm = this.attr.sidemax;
			if (!_sm.el) {
					! this.attr.sideright.el && this.sideright_creat();
					this.attr.sideright.el.after(codecoke.fn.getTmplate(_sm.tmpl,_sm));
					_sm.el = $('#'+_sm.id);
					//_sm.el.after('<div class="iCF"></div>')
			}
			//alert(_sm.el.html()+'\n'+'111')

			//!$('#'+_sr.id)[0] && _sr.p_el.prepend(codecoke.fn.getTmplate(_sr.tmpl,_sr));
			//!_sr.el &&(_sr.el =$('#'+_sr.id));

	}
	,'headtop_creat':function() {
			var _ht = this.attr.headtop;
			!$('#'+_ht.id)[0] && _ht.p_el.append(codecoke.fn.getTmplate(_ht.tmpl,_ht));
			_ht.el = $('#'+_ht.id);
			_ht.el_bar = $('#'+_ht.bar_id);
			_ht.el_con = $('#'+_ht.con_id);
			_ht.el_tool = $('#'+_ht.tool_id);
	}
	//,'child_headtop_write':function(_fn) {
	//	!this.mather.iuserbar.attr.headtop.el && this.mather.iuserbar.headtop_creat();
	//	_fn && _fn.apply(this,Array.prototype.slice.call(arguments,1));


		//_ibar.attr.headtop.el_con.append('<div>i am child headtop con</div>')
		//alert(_ibar.attr.headtop.el_con.html())
		//alert(this.attr.id+'\n'+_bar.cookie.get('userkeystr')+'\n'+_bar.iuserbar.attr.headtop.id)

		//alert(this.attr.name +'\n'+this.cookie.get('userkeystr')+'\n'+this.iuserbar.attr.headtop.id)
	//}

}

])
;