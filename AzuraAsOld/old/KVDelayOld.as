package azura.common.async2
{
	import azura.common.collections.DictionaryUtil;
	
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	public class KVDelayOld 
	{
		private var disposeTimer:Timer;
		public var delay:int=0;
		
		public function KVDelayOld(q:Que)
		{
			super(q);
		}
				
		override internal function load(loader:AsyncLoader2):void{
			stopCount();
			super.load(loader);
		}
		
		internal function release(loader:AsyncLoader2,delay:int):void{
			if(loader==null)
				throw new Error();
			if(delay<0)
				throw new Error();
			if(userList[loader]==null)
				throw new Error();
			
			this.delay=delay;
			delete userList[loader];
			if(userCount==0){
				if(start_pushed_working_ready_disposed==2){
					super.dispose();
				}else{
					disposeTimer=new Timer(delay,1);
					disposeTimer.addEventListener(TimerEvent.TIMER_COMPLETE,doDispose);
					disposeTimer.start();
				}
			}
		}
		
		private function stopCount():void{
			if(disposeTimer!=null){
				disposeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,doDispose);
				disposeTimer.stop();
				disposeTimer=null;
			}
		}
		
		private function doDispose(event:TimerEvent):void{
			stopCount();
			super.dispose();
		}
		
	}
}