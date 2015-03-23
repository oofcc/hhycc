/**/
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
]);