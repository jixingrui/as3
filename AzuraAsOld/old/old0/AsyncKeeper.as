package common.async
{
	import common.collections.DictionaryUtil;
	
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	public class AsyncKeeper
	{
		internal var box:AsyncBoxI;
		private var user_user:Dictionary=new Dictionary();
		private var waitList:Vector.<AsyncUserA>=new Vector.<AsyncUserA>();
		private var disposeTimer:Timer;
		
		public function AsyncKeeper(disposeDelay:int)
		{
			disposeTimer=new Timer(disposeDelay+Math.random()*int.MAX_VALUE%60,1);
			disposeTimer.addEventListener(TimerEvent.TIMER_COMPLETE,onDispose);
			function onDispose(event:TimerEvent):void{
				dispose();
			}
		}
		
		internal function dispose():void{
			throw new Error("AsyncKeeper.dispose: must override this");
		}
		
		internal function addUser(user:AsyncUserA):void{
			user_user[user]=user;
			waitList.push(user);
			disposeTimer.stop();
		}
		
		internal function discard(user:AsyncUserA):void{
			delete user_user[user];
			if(allDiscarded()){
				dispose();
			}
		}
		
		internal function allDiscarded():Boolean{
			return DictionaryUtil.getLength(user_user)==0;
		}
		
		internal function checkService():void{
			var user:AsyncUserA=waitList.shift();
			if(user==null)
				return;
			
			if(!user.discarded){
				user.served=true;
				user.ready(box);
			}
			checkService();
		}
	}
}