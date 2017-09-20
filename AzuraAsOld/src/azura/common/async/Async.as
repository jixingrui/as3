package azura.common.async
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class Async
	{
		private static var Class_AsyncQue:Dictionary=new Dictionary();
		private static var workFlow:Vector.<AsyncQue>=new Vector.<AsyncQue>();
		
		public static function register(priority:int,clazz:Class,threads:int,autoCancel:Boolean,disposeDelay:int):void{
			var que:AsyncQue=new AsyncQue(priority,threads,autoCancel,disposeDelay);
			Class_AsyncQue[clazz]=que;
			que.addEventListener(Event.COMPLETE,schedule);
			
			workFlow.push(que);
			workFlow.sort(sortByPriority);
			function sortByPriority(one:AsyncQue,other:AsyncQue):Number{
				if(one.priority>other.priority)
					return 1;
				else if(one.priority<other.priority)
					return -1;
				else
					return 0;
			}
		}
		
		public static function getClass(obj:Object):Class {
			return Class(getDefinitionByName(getQualifiedClassName(obj)));
		}
		
		public static function enque(user:AsyncLoader):void{
			var clazz:Class=getClass(user);
			var que:AsyncQue=Class_AsyncQue[clazz];
			if(que==null)
				throw new Error("Async must be configured before use: "+clazz);
			
			que.push(user);
			schedule();
		}
		
		private static function schedule(event:Event=null):void{
			for(var i:int=0;i<workFlow.length;i++){
				var que:AsyncQue=workFlow[i];
				if(que.working>0){
					return;
				}else if(que.assignWork()){
					return;
				}
			}
		}
	}
}