package azura.common.collections
{
	import flash.utils.Dictionary;
	
	public class Mc5QueCache
	{
		private static var instance:Mc5QueCache = new Mc5QueCache();	
		public static function singleton():Mc5QueCache {			
			return instance;			
		}		
		
		private var mc5_ZintBuffer:Dictionary=new Dictionary();
		private var que:Vector.<String>=new Vector.<String>();
		private var limit:int=1000;
		
		public function cache(mc5:String,data:ZintBuffer):void{
			var zb:ZintBuffer=mc5_ZintBuffer[mc5];
			if(zb==null){
				mc5_ZintBuffer[mc5]=data;
				que.push(data);
				
				if(que.length>limit){
					var mc5:String=que.shift();
					delete mc5_ZintBuffer[mc5];
				}
			}
		}
		
		public function getData(mc5:String):ZintBuffer{
			return mc5_ZintBuffer[mc5];
		}
	}
}