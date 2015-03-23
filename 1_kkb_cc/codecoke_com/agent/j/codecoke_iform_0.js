/**/

codecoke.fn.declareClassByArr([
{
	'_basic_':{
		'name':'_NS_doc_iform'
		,'fn':function(_doc) {
				this.doc=_doc;
				this.creatformArr=[
					['<form', '','','','','>']
					,['<div class="yellow_warning',' iSkip','">','','</div>']
					,[] //about
					,[]//inputs
					,['<div class="red_warning iSkip">','','</div>'	]
					,[] //mintxt
					,[
						'<div class="iformBottom">'
						,''
						,'<button class="iformBtn" type="button">'
						,''
						,'</button>'
						,''
						,'</div>'
					]
					,[]//endtxt
					,['</form>']
				];
		}
	}
	,'checkIformInputs':function(_next) {
		var _err='',_min,_max,_v='',_before,_n;
		var _this =this;
		!this.el.red_warning.hasClass('iSkip') && this.el.red_warning.addClass('iSkip');
		this.el.inputs =$('input[name]',this.iform);
		if (this.el.inputs && this.el.inputs.length) {
			this.el.inputs.removeAttr('class');
			this.el.div_inputs.find('sup').text('  ');
			this.v={};
			this.el.inputs.each(function(_i) {
				_before = $(this).prev().text() || '输入框	';
				_n = $(this).attr('name');
				_v =$(this).val()||'';
				if (_v) {
					_v =_v.replace(/^\s+|\s+$/,'');
					$(this).val(_v);
					_this.v[_n]=_v;
				}				_min = $(this).attr('minlength') || 0;
				_max =$(this).attr('maxlength')||0;
				_max= _max>50000 ? 0 :_max;
				if (_min && _min>_v.length) {
					_err = '错误提示_<strong>'+_before+'</strong> 的输入内容不得少于 '+_min+' 字符';
					$(this).attr('class','input_err');
					$(this).next().text(' X ')
					return false;
				};
				if (_max && _v && (_v.length > _max || codecoke.get.strlen(_v)>_max) ) {
					_err = '错误提示_<strong>'+_before+'</strong> 的输入内容不得大于 '+_max+' 字符，一个中文算2字符。';
					$(this).attr('class','input_err');
					$(this).next().text(' X ');
					return false;
				}
				_v && ($(this).attr('className','input_ok') || $(this).next().text(' √ ') );
			});
		}

		if (_err) {
			this.el.red_warning.removeClass('iSkip').html(_err);
			return false;
		}
		if (_next && codecoke.is.Func(_next)) {
			_next(this);
		}else {
			return this;
		}
	}
	,'getIformElements':function(_r) {
			_r.el.btn =$('button.iformBtn',_r.iform);
			_r.el.red_warning = $('div.red_warning',_r.iform);
			_r.el.yellow_warning = $('div.yellow_warning',_r.iform);
			_r.el.inputs =$('input[name]',_r.iform);
			_r.el.div_inputs=$('div.iform_inputs',_r.iform);

			var _min,_max,_after,_size
			_r.el.inputs.length && _r.el.inputs.each(function(_i) {
				_size = $(this).attr('size');
				(!_size || _size==28 || _size==20 ) && $(this).attr('size',30);
				_min = $(this).attr('minlength') || 0;
				_max =$(this).attr('maxlength')||0;
				_max= _max>50000 ? 0 :_max;
				_after= _min && _max
						? '<span class="cRed">*</span><span>'+_min+' 到 '+_max+' 字符</span>'
						: (
							_min ? '<span class="cRed">*</span><span> 不少于 '+_min+' 字符</span>'
							: (
								_max ? '<span>不超过 '+_max+' 字符</span>' :'<span class="cGray">可不填</span>'
							)
						)
				;
				_after && $(this).after(_after).after('<sup>&nbsp;</sup>');
				_r.n[$(this).attr('name')]=$(this);}

			);
	}
	,'elementsReset':function(_f) {
		//if (!_f) {return ;}
		this.el.inputs && this.el.inputs.removeAttr('class').val('');
		this.el.red_warning && this.el.red_warning.addClass('iSkip').empty();
		this.el.btn && this.el.btn.removeAttr('disabled').text('提交');
	}
	,'get':function(_o) {
				var _arr = codecoke.get.clone(this.creatformArr);
				var _form_id =_arr[0][1] =' id="'+_o.id+'"';

				_arr[0][4] =' class="iform '+( _o._class||'')+'"' ;
				//_arr[4][1] = _o.red_warning ?  _o.red_warning :'';

				if (_o.yellow_warning) {
					_arr[1][1]=''; // del iSkip
					_arr[1][3]=_o.yellow_warning;
				}


				_arr[2]= _o.about ?(
						_o.about.indexOf('<div')==0 ? _o.about :'<div class="iform_about">'+_o.about+'</div>'
					) :'';
				_arr[3] = _o.inputs
						?(
							codecoke.is.Arr(_o.inputs)
							? '<div class="iform_inputs"><p>'+_o.inputs.join('</p><p>')+'</p></div>'
							: (_o.inputs.indexOf('<div')==0? _o.inputs : '<div class="iform_inputs">'+_o.inputs+'</div>')
						)
						:''
				;
				_arr[4][1] = _o.red_warning ?  _o.red_warning :'';
				_arr[6][3]= _o.buttontxt ||'提交';
				for (var _i=0,_x=_arr.length; _i<_x; _i++) {	_arr[_i].length && codecoke.is.Arr(_arr[_i]) && ( _arr[_i]= _arr[_i].join(''));	}
				var F ={
					'iform':$(_arr.join('')).submit(function () {return false;})
					,'id':_o.id
					,'el':{}
					,'n':{}
					,'v':{}
					,'fn':{}
				};
				this.getIformElements(F);
				_o.ck && F.el.btn.bind('click',codecoke.get.bindFn(F,this.checkIformInputs,_o.ck));
				F.fn.reset= codecoke.fn.bindFn(F,this.elementsReset);
				return F;

		}


}





]);