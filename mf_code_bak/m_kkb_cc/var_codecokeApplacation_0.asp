<%
//===============applacation============//
	var _appStr =function (){
		this.cacheName='A$';
		//60000 1分钟，3600000 1小时
		this.cacheDefaultOverTime=3600000;
		this.adds ={
			'something' :{fn:'strInMySize',fmax:10}
		};
		this.overTimeKeys ={
			'banSigns':3600000*5
			,'boardCounts':60000*15
			,'boardLastPost':3600000
			,'banBBSpost':3600000
			,'banBBSreplys':3600000*2
		}
	  }
	  ;
	_appStr.prototype={
		'get':function(_k) {
			var _overTime =codecoke.get.n_0(Application(this.cacheName+_k+'$time'));
			if(!_overTime){return null;}
			if( $sev.$runsett.sevtime < _overTime) {
				return codecoke.get.str(Application(this.cacheName+_k),'oneblank');
			}else{
				this.remove(_k);
				return null;
			}
		}
		,'remove':function(_k){
			Application.Lock;
			Application.Contents.Remove(this.cacheName+_k+'$time');
			Application.Contents.Remove(this.cacheName+_k);
			Application.unLock;
		}
		,'clear':function(){
			var x;
			var _e = new Enumerator(Application.Contents);
			for (;!_e.atEnd();_e.moveNext()){
				x = _e.item();
				if(x.indexOf(this.cacheName)> -1 || x.indexOf('$time') >-1){
					Application.Lock;
					Application.Contents.Remove(x+'$time');
					Application.Contents.Remove(x);
					Application.unLock;
				}
			}
		}
		,'set':function(_k,_v,_addtime){
			var _overTime;
			if(_addtime) {
				_overTime= _addtime;
			}else{
				_overTime = this.cacheDefaultOverTime;
				for (var _i in this.overTimeKeys ) {if(this.overTimeKeys.hasOwnProperty(_i) && (_k.indexOf('_'+_i)> -1)) {
					_overTime = this.overTimeKeys[_i]; break;
				}}
			}
			Application.Lock;
			Application(this.cacheName+_k+'$time')= _overTime + $sev.$runsett.sevtime;
			Application(this.cacheName+_k)=_v;
			Application.unLock;
		}
	};
	codecoke.aps = new _appStr();
	%>
