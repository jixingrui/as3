package azura.gallerid3.source
{
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.i.Mc5MemI;
	
	import flash.utils.Dictionary;
	
	public class GsMem implements Mc5MemI
	{
		private var mc5_ZintBuffer:Dictionary=new Dictionary();
		
		public function GsMem()
		{
		}
		
		public function getData(mc5:String):ZintBuffer
		{
			var data:ZintBuffer = mc5_ZintBuffer[mc5];
			if(data==null)
				return null;
			else
				return data.clone();
		}
		
		public function cache(mc5:String, zb:ZintBuffer):void
		{
			mc5_ZintBuffer[mc5]=zb;
		}
	}
}