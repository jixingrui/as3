package azura.common.async2
{
	import avmplus.getQualifiedClassName;
	
	import azura.common.collections.DictionaryUtil;
	
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import mx.collections.AsyncListView;
	
	public class KV
	{
		public var key:*;
		public var value:*;
		
		private var worker:AsyncLoader2;
		
		protected var q:Que;
		internal var userList:Dictionary=new Dictionary();
		
		protected var start_pushed_working_ready_disposed:int=0;
		
		private var disposeTimer:Timer;
		public var delay:int=0;
		
		public function KV(q:Que){
			this.q=q;
		}
		
		internal function load(loader:AsyncLoader2):void{
			stopCountDown();
			userList[loader]=loader;
			if(start_pushed_working_ready_disposed==0){
				start_pushed_working_ready_disposed=1;
				worker=loader;
				q.load(this);
			}else if(start_pushed_working_ready_disposed==3){
				loader.serve();
			}else if(start_pushed_working_ready_disposed==4){
				throw new Error();
			}
		}
		
		internal function submit(value_:*):void{
			
//			if(value_==null)
//				throw new Error("KV: cannot submit null");
			if(this.value!=null && value_!=null)
				throw new Error("KV: cannot submit twice");
			if(this.start_pushed_working_ready_disposed!=2)
				throw new Error("KV: work did not start");
			if(q==null)
				throw new Error("KV: cannot submit after dispose");
			
			this.start_pushed_working_ready_disposed=3;
			this.value=value_;
			
			q.workDone();
			for each(var l:AsyncLoader2 in userList){
				l.serve();
			}
			
			if(userCount==0)
				delayedDispose();
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
				if(start_pushed_working_ready_disposed==3){
					delayedDispose();
				}
			}
		}
		
		private function delayedDispose():void{
			stopCountDown();
			
			disposeTimer=new Timer(delay,1);
			disposeTimer.addEventListener(TimerEvent.TIMER_COMPLETE,dispose);
			disposeTimer.start();
		}
		
		internal function get userCount():int{
			return DictionaryUtil.getLength(userList);
		}
		
		//		private static var activeCount:int=0;
		internal function workKV():void{
			if(start_pushed_working_ready_disposed==2)
				throw new Error("Async2: kv is already working");
			
			if(start_pushed_working_ready_disposed==3)
				throw new Error("Async2: kv work already done");
			
			start_pushed_working_ready_disposed=2;
			worker.process();
			//			activeCount++;
			//			trace("KV: active="+activeCount);
		}
		
		private function stopCountDown():void{
			if(disposeTimer==null)
				return;
			
			disposeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,dispose);
			disposeTimer.stop();
			disposeTimer=null;
		}
		
		internal function dispose(event:TimerEvent=null):void{
			if(userCount>0)
				throw new Error();
			
			stopCountDown();
			if(start_pushed_working_ready_disposed==2)
				throw new Error();
			start_pushed_working_ready_disposed=4;
			worker.dispose();
			worker=null;
			userList=null;
			value=null;
			q.remove(this);
			q=null;
			//			activeCount--;
			//			trace("KV: active="+activeCount);
		}
		
	}
}