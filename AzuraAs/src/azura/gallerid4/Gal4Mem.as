package azura.gallerid4
{
	
	import azura.common.collections.ZintBuffer;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class Gal4Mem
	{
		private var me5_ByteArray:Dictionary=new Dictionary();
		private var bufferIndex:Vector.<String>=new Vector.<String>();
		private static var capacity:int=2000;
		private static var limit:int=500000;
		
		public function write(me5:String,data:ByteArray):void{
			if(data.length>limit)
				return;
			
			var old:ByteArray=me5_ByteArray[me5];
			if(old!=null)
				return;
			
			bufferIndex.push(me5);
			me5_ByteArray[me5]=new ZintBuffer(data);
			
			if(bufferIndex.length>capacity){
				var me5:String=bufferIndex.shift();
				delete me5_ByteArray[me5];
			}
		}
		
		public function read(me5:String):ByteArray{
			return me5_ByteArray[me5];
		}
		
		public function clear():void{
			me5_ByteArray=new Dictionary();
			bufferIndex=new Vector.<String>();
		}
	}
}