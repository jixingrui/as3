package zexia.common.video
{
	public class NsClientTracer
	{
		public function onPlayStatus(info:Object):void{
			traceObject(info);
		}		
		public function onXMPData(info:Object):void{
			traceObject(info);
		}
		public function onMetaData(info:Object):void { 
			traceObject(info);
		} 
		public function onCuePoint(info:Object):void { 
			traceObject(info);
		} 
		
		public function traceObject(info:Object,head:String=""):void{
			for (var propName:String in info) {  
				var value:Object=info[propName];
				
				if(hasKey(value)){
					trace(head+"<"+propName+">");
					traceObject(value,head+"  ");
					trace(head+"<"+propName+"/>");
				}
				else
					trace(head+propName + " = " + info[propName]);  
			}  
		}
		
		public function hasKey(obj:Object):Boolean
		{
			for(var key:Object in obj)
			{
				return true;
			}        
			return false;
		}
	}
}