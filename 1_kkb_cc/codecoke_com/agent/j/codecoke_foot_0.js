/*codecoke_foot_0*/

codecoke.fn.declareClass({
	'_basic_':{
		'name':'_NS_doc_All'
		,'fn':function(_docSettingO,_self_name,_docFootCall) {
				this.attr={
						'self_name':_self_name
						,'Els':{
								'go2headerEl':$('<sup></sup>',{'text':'top ↑','class':'iR go2head','click':this.go2header})
								,'go2footerEl':$('<sup></sup>',{'text':'foot ↓','class':'iR go2footer','click':this.go2footer})
								//,'doctitle':$(document
						}
						,'ajaxDebug':1
						//,'docFootCalls':{}
				}
				;
				!this.DocFootCalls && (this.DocFootCalls={});
				if (_docSettingO && _docSettingO.docElArr) {
						var _n,_v,_a;
						for (var _i=0,_x=_docSettingO.docElArr.length; _i<_x; _i++) {
							_a = _docSettingO.docElArr[_i].indexOf(':');
							_a >1 && (_n =  _docSettingO.docElArr[_i].substr(0,_a));
							_n  && (_v= _docSettingO.docElArr[_i].substring(_a+1));
							_v && $(_v).length && (this.attr.Els[_n]=$(_v));
							_n ='';_v ='';
						}
				}
				$sev.localsetting && (this.$localsetting =$sev.localsetting);
				//this.attr.Els.doctitle=$(document.title);
				this._ini_();
		}
	}
	,'_ini_':function() {
		codecoke.fn.newFunIn(this,[
				['UI','_NS_doc_UI',this]
				//,['iEscape','_doc_iEscape',codecoke.attr.runnerSetting.f62,codecoke.attr.runnerSetting.iEscapePublicKey]
				,['foot','_NS_doc_foot',this]
				,['ihead','_NS_doc_ihead',this]
				,['ajaxerr','_NS_doc_ajax_err',this]
				,['iform','_NS_doc_iform',this]
				,['jsload','_NS_doc_jsload',this,this.$localsetting.basic.gtpath.jsload]
		]);
		var _this=this;
		window['alertt'] =function() {_this.UI.alertt.apply(_this.UI,Array.prototype.slice.call(arguments))};
		/*
		_this.jsload.get('json^$sev@siteinfo'+($sev.localsetting.sitename_pk ? '&sitename_pk='+$sev.localsetting.sitename_pk :''),function(_d) {
			$sev.siteinfo=_d;
			_this.setWhenSiteInfoLoad();
		});
		*/
		this.getSiteInfoAndThen();
	}
	,'getSiteInfoAndThen':function() {
		var _this =this;
			if (!$sev.siteinfo) {
				_this.jsload.get('json^$sev@siteinfo?gt=_js'+($sev.localsetting.sitename_pk ? '&sitename_pk='+$sev.localsetting.sitename_pk :'')+'',function(_d) {
					$sev.siteinfo=_d;
					_this.setWhenSiteInfoLoad();
					_this.check_docCallsData();
				});
			}else {
				_this.check_docCallsData();
			}

	}
	,'check_docCallsData':function() {
		//var _arg = Array.prototype.slice.call(arguments);
		var _this =this;
		for (var _a in _this.DocFootCalls) {if( _this.DocFootCalls.hasOwnProperty(_a) && codecoke.is.Func(_this.DocFootCalls[_a]) && !_this.DocFootCalls[_a]['iHadBeCalled']){
				//var _arg =arguments.length ?  Array.prototype.slice.call(arguments).unshift(_this):[_this];
				//_this.attr.docFootCalls[_a].apply(_this.attr.docFootCalls[_a],_arg);
				_this.DocFootCalls[_a](_this);
				_this.DocFootCalls[_a]['iHadBeCalled']=1;
		}}

	}
	,'check_after_lapiGo':function(_lapiGoStr) {
		//lapiGo
		var _this =this;
		if (!_lapiGoStr) {return;}
		var _goArr =_lapiGoStr.split('||||');
		var _x =_goArr.length;

		for (var _i=0; _i<_x; _i++) {
			_goArr[_i] && _goArr[_i].indexOf('@')>0 && this.jsload.get(_goArr[_i]);
			//_goFn[_i]=function() {
			//	_this.jsload.get(_goArr[_i]);
			//}
		}
		/*
		var _fn =function() {
			var _nArr=Array.prototype.slice.call(arguments,1);
			if (!_nArr.length) {
				_this.jsload.get(arguments[0]);
			}else {
				_this.jsload.get(arguments[0],_nArr,this);
			}

		}
		_this.jsload.get(_goArr[0],_goArr,_fn)

		*/
		//alert(_goFn[0]);
		//_goFn[0]();
		//alert($sev.localsetting.lapiGo);
	}

	,'setWhenSiteInfoLoad':function() {
		this.attr.Els.ihead2Clear && this.attr.Els.iHead && (this.attr.Els.ihead2Clear.before(this.attr.Els.iHead));

		this.attr.Els.footNav && this.attr.Els.footNav.prepend(this.attr.Els.go2headerEl.clone()).find('ul').append(
				$('<li></li>',{
					'id':'addFavorite'
					,'text':'\[+\] 收藏本页'
					,'class':'aLink'
					,'click':function() {
						var _u= window.location.href+'',_t= document.title+'';
						if (window.sidebar && window.sidebar.addPanel) {
								window.sidebar.addPanel(_t, _u,'');
						}else if (window.external) {
								window.external.AddFavorite(_u,_t);
						}else {
							alert('您的浏览器只能手动将添加到收藏夹');
						}

					}
				})
		)
		;

		this.UI.bind_mouseover_liveshow('div.acTag_dl_fl dl:has(dd)','dl.iShow','iShow');
		//this.UI.bind_mouseover_liveshow('div.iTopUser .iTopUserContent','div.iTopUserContent','iSkip');
		this.UI.bind_mouseover_elchildshow('#ibar_headtop','div.iTopUserContent:has(div.iTopUserContentZone)','iSkip')

		this.UI.bind_hexcall();

		/*
		$('#ibar_headtop:has(div.iTopUserContentZone)').live({
			'mouseenter':function() {
				$('div.iTopUserContent:has(div.iTopUserContentZone)',$(this)).removeClass('iSkip');
			}
			,'mouseleave':function() {
				$('div.iTopUserContent:has(div.iTopUserContentZone)',$(this)).addClass('iSkip');
			}
		});
		*/

		this.attr.Els.powered
			&& !this.attr.Els.copyright
			&& this.attr.Els.powered.prepend(
				$('<a></a>',{	'href':'http://www.miibeian.gov.cn/','text':$sev.siteinfo.attr.miibeian	,'target':'_blank'})
			).before(
				$('<div />',{'id':'copyright'
					,'html':'&#x00a9;&nbsp;'+$sev.siteinfo.attr.createtime.substr(0,$sev.siteinfo.attr.createtime.indexOf('-'))+'-'+(new Date()).getFullYear()+' <a href="/" id="copyrightUrl">'+($sev.siteinfo.attr.name || window.location.hostname)+'</a>All Rights Reserved.'
				})
			) && (this.attr.Els.copyright = $('#copyright'))
		;
		this.attr.Els.iHeadFoot
			&& this.attr.Els.iHeadFoot.prepend(
				$('<div />',{'id':'ggSearch','class':'iR','html':$sev.siteinfo.attr.ggSearchStr})
			).prepend(
					this.attr.Els.go2footerEl.clone()
			)
		;
		this.check_after_lapiGo($sev.siteinfo.attr.lapiGo || $sev.localsetting.lapiGo);

		//$('div.ggSearch').html($sev.siteinfo.attr.ggSearchStr);
	}
	,'setWhenPageFirstLoad':function() {}
	,'go2header':function(){$(window).scrollTop(0);}
	,'go2footer':function() {$(window).scrollTop(99999);}

});



//jQuery.noConflict();
(function($) {$(function() {

	// more code using $ as alias to jQuery
	var _docSettingO={
			'docElArr':[
				'iWallpaper:#iWallpaper'
				,'ihead2Clear:#ihead2Clear'
				,'iContent:#iContent','iCon:#iCon'
				,'iHead:#iHead'
				,'iHeadLogo:#iLogo'
				,'iHeadFoot:#iHeadFoot'
				,'iFoot:#iFoot'
				,'footNav:#footNav'
				,'powered:#powered'
			]
	}
	;
	codecoke.fn.newFunIn(window,'doc','_NS_doc_All',_docSettingO,'doc');


	doc.DocFootCalls.footnavtest=function(_doc) {
		this.doc =_doc;
		this.doc.foot.nav.prepend(
			$('<span class="iL mrR5 cHand">look $sev.localsetting</span>').click(function() {alertt(JSON.stringify($sev.localsetting,'',' '),'$sev.localsetting');})
		).prepend(
			$('<span class="iL cHand">look $sev.siteinfo</span>').click(function() {alertt(JSON.stringify($sev.siteinfo,'',' '),'$sev.siteinfo');})
		);
	}
	;
	/*
	$sev.siteinfo.cookiesetting.lukasu_sS		{
					'attr':{
						'name':'lukasu_Ss'
						,'path':'/'
						,'addtimetype':'d'
						,'addtimelength':120
						,'nameAttr':{
							'userkeystr':['K',2]
							,'usernames':['Um',2]
							,'usersort':['uS',2]
						}
					}
				}

	*/
	/*
	doc.DocFootCalls.lukasu_cookie=codecoke.fn.newFnCookie([$sev.siteinfo.cookiesetting.lukasu_sS,doc]);

	doc.DocFootCalls.t12=function(_doc) {
		codecoke.fn.newFnAt(
			'icookie'
			,_doc.DocFootCalls
			,'cookie_lukasu_sS'
			,[$sev.siteinfo.cookiesetting.lukasu_sS.attr,_doc]  // ini(_o,doc)
		);

		var _cookie =_doc.DocFootCalls.cookie_lukasu_sS;
		$('#myt4').html(_cookie.get('userkeystr')
					+'<br/>'+_cookie.get('usernames')
					+'<br/>'+_cookie.get('usersort')
		);
		$('#myt5').text(codecoke.get.decodeUri(''+document.cookie));
		$('#myt6').text(JSON.stringify($sev.siteinfo,'','  '));
		$('#myt7').text(JSON.stringify($sev.localsetting,'','  '));
	}
	;
	*/

	doc.DocFootCalls.t13=function(_doc) {


		//$('#myt5').text(codecoke.get.decodeUri(''+document.cookie));
		//$('#myt6').text(JSON.stringify($sev.siteinfo,'','  '));
		//$('#myt7').text(JSON.stringify($sev.localsetting,'','  '));
		//alert(_bar.cookie.get('userkeystr'));


	}


});})(jQuery);

//jQuery(function($) {
	//doc.jsload.get('doc@hex12345.md5','/2.asp',true,function() {doc.ihead.msg.write(doc.hex.md5('i23456',16),'red','add');})
	//doc.jsload.get('doc@hex.md5',function() {doc.ihead.msg.write(doc.hex.md5('i23456',16),'red','add');doc.ihead.msg.write(doc.iEscape.de('i23456'),'blue','add');})
	//doc.jsload.get('$sev@siteinfo'+($sev.localsetting.sitename_pk ? '&sitename_pk='+$sev.localsetting.sitename_pk :''),function(_d) {	$('#myt2').html('<textarea cols="150" ows="8">'+JSON.stringify($sev.siteinfo)+'</textarea>');	})
	//doc.UI.paper.add('<span>yes</span>',1,1);doc.UI.paper.add('#myt2');doc.UI.paper.add('<span>yes 1</span>',1,1);
//});