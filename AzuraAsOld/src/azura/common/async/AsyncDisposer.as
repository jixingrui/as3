package azura.common.async
{
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	public class AsyncDisposer
	{
		protected var first:AsyncLoader;
		private var AsyncLoader_AsyncLoader:Dictionary=new Dictionary();
		private var disposeTimer:Timer;
		private var autoCancel:Boolean;
		internal var isReady:Boolean;
		
		public function AsyncDisposer(first:AsyncLoader,disposeDelay:int,autoCancel:Boolean)
		{
			this.first=first;
			this.autoCancel=autoCancel;
			AsyncLoader_AsyncLoader[first]=first;
			disposeTimer=new Timer(disposeDelay+Math.random()*int.MAX_VALUE%100,1);
			disposeTimer.addEventListener(TimerEvent.TIMER_COMPLETE,doDispose);
			function doDispose(event:TimerEvent):void{
				disposeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,doDispose);
				
				removeTask();
				
				if(isReady)
					first.dispose();
			}
		}
		
		internal function removeTask():void{
			throw new Error("AsyncDisposer: must override this");
		}
		
		private function countDown():void{
			disposeTimer.start();
		}
		
		internal function addUser(loader:AsyncLoader):void{
			AsyncLoader_AsyncLoader[loader]=loader;
			disposeTimer.reset();
		}
		
		internal function cancel(loader:AsyncLoader):void{
			delete AsyncLoader_AsyncLoader[loader];
			if(allCanceled()){
				countDown();
			}
		}
		
		internal function allCanceled():Boolean{
			return getLength(AsyncLoader_AsyncLoader)==0;
			function getLength(dict:Dictionary):int
			{
				var n:int = 0;
				for (var key:* in dict) {
					n++;
				}
				return n;
			}
		}
		
		internal function ready():void{
			if(isReady)
				throw new Error("AsycTask: cannot submit twice");
			isReady=true;
		}
		
		internal function checkService():void{			
			for each(var loader:AsyncLoader in AsyncLoader_AsyncLoader){
				if(loader.hasServed_)
					continue;
				
//				loader.hasServed_=true;
				loader.value_=first.value_;
//				setTimeout(loader.serve,0);
				loader.serve();
//				setTimeout(loader.callBack_,0,loader);
//				loader.callBack_.call(null,loader);
			}
			if(autoCancel){
				AsyncLoader_AsyncLoader=new Dictionary();
				countDown();
			}
		}
	}
}