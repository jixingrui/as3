package azura.common.async
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	public class AsyncQue extends EventDispatcher
	{
		internal var priority:int;
		internal var working:int;
		
		private var workerQue:Vector.<AsyncWorker>=new Vector.<AsyncWorker>();
		private var key_AsyncWorker:Dictionary=new Dictionary();
		private var disposeDelay:int;
		private var autoCancel:Boolean;
		private var threads:int;
		
		public function AsyncQue(priority:int,threads:int,autoCancel:Boolean,disposeDelay:int)
		{
			this.priority=priority;
			this.disposeDelay=disposeDelay;
			this.autoCancel=autoCancel;
			this.threads=threads;
		}
		public function push(user:AsyncLoader):void{
			var worker:AsyncWorker=key_AsyncWorker[user.key];
			if(worker==null){
				worker=new AsyncWorker(this,user,disposeDelay,autoCancel);
				key_AsyncWorker[user.key]=worker;	
			}
			worker.addUser(user);
			
			if(worker.isReady){//just serve
				worker.checkService();
			}else if(worker.isWorking){
				//do nothing
			}else if(user.loadNow){
				working++;
//				setTimeout(worker.work,0);
				worker.work();
			}else if(!worker.isInQue){
				worker.isInQue=true;
				workerQue.push(worker);
			}
		}
		
		internal function assignWork(event:Event=null):Boolean{
			if(working>=threads||workerQue.length==0){
				return false;
			}else{
				var worker:AsyncWorker=workerQue.shift();
				worker.isInQue=false;
				working++;
//				worker.work();
				setTimeout(worker.work,0);
				assignWork();
				return true;
			}
		}
		
		internal function aWorkDone():void{
			working--;	
			this.dispatchEvent(new Event(Event.COMPLETE));	
		}
		
		internal function removeWorker(key:*):void{
			delete key_AsyncWorker[key];
		}
	}
}