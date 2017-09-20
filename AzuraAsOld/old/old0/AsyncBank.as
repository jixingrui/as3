package common.async.old
{
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	public class AsyncBank
	{
		private var taskQue:Vector.<AsyncTask>=new Vector.<AsyncTask>();
		private var key_AsyncTask:Dictionary=new Dictionary();
		private var threadMax:int;
		private var threadRunning:int;
		private var timer:Timer;
		private var delay:int;
		
		public function AsyncBank(threads:int=0,delay:int=0){
			this.threadMax=threads;
			this.delay=delay;
			timer=new Timer(1000,0);
			timer.addEventListener(TimerEvent.TIMER,gc,false,0,true);
			timer.start();
		}				  
		
		private function gc(event:TimerEvent):void{
			for each(var task:AsyncTask in key_AsyncTask){
				if(task.cache.isEmpty && !task.working){
					delete key_AsyncTask[task.key];
				}
			}
		}
		
		public function ask(user:AsyncUserI):void{
			var task:AsyncTask=key_AsyncTask[user.key];
			if(task==null){
				task=new AsyncTask(user.key);
				key_AsyncTask[user.key]=task;				
			}
			if(!task.serve(user)&&!task.working){
				task.working=true;
				taskQue.push(task);
			}else{
//				trace('async using cache');
			}
			nextWork();
		}
		
		public function answer(user:AsyncUserI,value:Object):void{
			var result:AsyncTask=key_AsyncTask[user.key];	
			
			result.value=value;
			
			threadRunning--;
			nextWork();
		}
		
		private function nextWork():void{
			setTimeout(doNextWork,delay);
		}
		
		private function doNextWork():void{
			if(threadMax==0 || threadRunning<threadMax){
				var task:AsyncTask=taskQue.shift();
				if(task!=null){
					threadRunning++;
					task.work();
				}		
			}
		}
	}
}