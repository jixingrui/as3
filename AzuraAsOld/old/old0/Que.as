package common.async
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	public class Que extends EventDispatcher
	{
		internal var priority:int;
		
		internal var taskQue:Vector.<AsyncTask>=new Vector.<AsyncTask>();
		internal var key_AsyncTask:Dictionary=new Dictionary();
		private var disposeDelay:int;
		private var workDelay:int;
		private var threads:int;
		internal var working:int;
		
		public function Que(disposeDelay:int,workDelay:int,threads:int=1)
		{
			this.disposeDelay=disposeDelay;
			this.workDelay=workDelay;
			this.threads=threads;
		}
		public function push(user:AsyncUserA,front:Boolean=false):void{
			var task:AsyncTask=key_AsyncTask[user.key];
			if(task==null){
				task=new AsyncTask(this,user,disposeDelay);
				key_AsyncTask[user.key]=task;	
			}
			
			task.addUser(user);
			if(!task.inQue){
				task.inQue=true;
				if(front)
					taskQue.unshift(task);
				else
					taskQue.push(task);
			}
		}
		
		internal function work(event:Event=null):Boolean{
			if(working>=threads||taskQue.length==0){
				return false;
			}else{
				var task:AsyncTask=taskQue.shift();
				task.inQue=false;
				working++;
				setTimeout(task.work,workDelay);
				work();
				return true;
			}
		}
		
		internal function aWorkDone():void{
			working--;	
			this.dispatchEvent(new Event(Event.COMPLETE));	
		}
	}
}