/*codecoke_query_0 w@codecoke.com 2011/5/9*/
(function(_myCodeNameSpace_){if (window[_myCodeNameSpace_]){return window[_myCodeNameSpace_];}
		window[_myCodeNameSpace_]={
			'attr':{
				'softcreatebyurl':'http://www.codecoke.com/','_BasicFuncObject':{}
				,'classFuncBasicName':'_BasicFuncClassObject_'
				,'runnerSetting':{
					'iEscapePublicKey':'z1R5JCOhsGkFBYoPQxrgNH9KLe6j0AZM4pDqnSUadTV2XctIwu8lW7y3mfviEb'
					,'iEscapeCookiekey':'tI7s2pwo0SLEmGdfh8bNBquaeW1ZgilMyjrOHQv6Vz4Tc3n5U9RXJCPYFDkKAx'
					,'f62':'Az0yBx1wCv2uD3rEt4sFqGpHoInJmKiLlMkNjOgPhQfRdSbcTaU9V8W7X6Y5Ze'
					,'f10':'0123456789'
					,'f10E':'ABCDEFGHIJK'
				}
			}
			,'runnerSetting':{
				'iEscapePublicKey':'z1R5JCOhsGkFBYoPQxrgNH9KLe6j0AZM4pDqnSUadTV2XctIwu8lW7y3mfviEb'
				,'iEscapeCookiekey':'tI7s2pwo0SLEmGdfh8bNBquaeW1ZgilMyjrOHQv6Vz4Tc3n5U9RXJCPYFDkKAx'
				,'f62':'Az0yBx1wCv2uD3rEt4sFqGpHoInJmKiLlMkNjOgPhQfRdSbcTaU9V8W7X6Y5Ze'
				,'f10':'0123456789'
				,'f10E':'ABCDEFGHIJK'
				//,'classFuncBasicName':'_BasicFuncClassObject_'
			}
			,'is':{
				'Null':function(a){return a===null;}
				,'Undefined':function(a){return  (typeof a === 'undefined');	}
				,'Nt':function(a){return (a==null || a==undefined || a===''|| ((''+a)==='') || ((''+a)=='null') || ((''+a)=='undefined'));	}
				,'Func':function(a){return ((typeof(a)==='function')||(typeof(a)==='object' && Object.prototype.toString.apply(a) === '[object Function]'));}
				,'Str':function(a){return (typeof(a) === 'string'||(typeof(a)==='object' && Object.prototype.toString.apply(a) === '[object String]'))	}
				,'Arr':function(a){return(a && typeof(a)==='object' && Object.prototype.toString.apply(a) === '[object Array]');}
				,'Boolean':function(a){return (typeof(a)==='boolean'||(typeof(a)==='object' && Object.prototype.toString.apply(a) === '[object Boolean]'))}
				,'Date':function(a){return (typeof(a)==='object' && Object.prototype.toString.apply(a) === '[object Date]');}
				,'Mail':function(a) {
					return (
						a && (typeof(a)==='string')	&& (a.indexOf('@')>0) &&
						/^[a-z0-9]{1,}(?:[\.\_\-]{0,1}[a-z0-9]{1,})?(?:[\.\_\-]{0,1}[a-z0-9]{1,})?\@[a-z0-9]{1,}(?:[a-z0-9]{0,8}[\-]{0,1}(?:[a-z0-9]{1,}\.[a-z0-9]{2,4})?[a-z0-9]{0,8})?\.[a-z]{2,4}$/i.test(a)
					);
				}
				,'Handphone':function(a) {return ( a && /^1[3|5|8][0-9]{9}$/.test((''+a)) );}
				,'Num':function(a){return(typeof(a)==='number' && Object.prototype.toString.apply(a) === '[object Number]');}
				,'Obj':function(a){	return (typeof(a)==='object' && a !==null && Object.prototype.toString.apply(a) === '[object Object]');}
				,'EmptyObj':function(_o) {for (var _a in _o) {if(_o.hasOwnProperty(_a)){return false;}}	return true;}
				,'Regexp':function(a){return (typeof(a)==='object' && Object.prototype.toString.apply(a) === '[object RegExp]');}
				,'TimeDir':function(a) {
					return a && a.length && a.length === 8 && /^(?:19|20)[0-9]{2}(?:[0][1-9]|1[012])(?:0[1-9]|[12][0-9]|3[01])$/.test(''+a);
				}
			}
		};
})('codecoke');
