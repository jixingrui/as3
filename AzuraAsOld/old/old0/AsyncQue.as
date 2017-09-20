package common.async
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	public class AsyncQue extends EventDispatcher
	{
		private static var name_Que:Dictionary=new Dictionary();
		private static var serialList:Vector.<Que>=new Vector.<Que>();
		
		public static function configParallel(name:String,disposeDelay:int,workDelay:int,threads:int):void{
//			trace("AsyncQue: parallel "+name+" threads "+threads);
			
			var que:Que=name_Que[name];
			if(que!=null)
				throw new Error("AsyncQue: cannot config twice: "+name);
			
			que=new Que(disposeDelay,workDelay,threads);
			name_Que[name]=que;
			que.addEventListener(Event.COMPLETE,que.work);
		}
		public static function configSerial(name:String,disposeDelay:int,workDelay:int,priority:int):void{
//			trace("AsyncQue: serial "+name+" priority "+priority);
			
			if(priority<=0)
				throw new Error("AsyncQue: serial priority must >0");
			var que:Que=name_Que[name];
			if(que!=null)
				throw new Error("AsyncQue: cannot config twice: "+name);
			
			que=new Que(disposeDelay,workDelay);
			name_Que[name]=que;
			que.addEventListener(Event.COMPLETE,checkSerialWork);
			
			que.priority=priority;
			serialList.push(que);
			serialList.sort(sortByPriority);
			function sortByPriority(one:Que,other:Que):Number{
				if(one.priority>other.priority)
					return 1;
				else if(one.priority<other.priority)
					return -1;
				else
					return 0;
			}
		}
		
		public static function enque(name:String,user:AsyncUserA,front:Boolean=false):void{
			var que:Que=name_Que[name];
			if(que==null)
				throw new Error("AsyncQue: must config before use: "+name);
			
			que.push(user,front);
			if(que.priority>0)
				checkSerialWork();
			else
				que.work();
		}
		
		private static function checkSerialWork(event:Event=null):void{
			for(var i:int=0;i<serialList.length;i++){
				var que:Que=serialList[i];
				if(que.working>0){
					return;
				}else if(que.work()){
					return;
				}
			}
		}
	}
}