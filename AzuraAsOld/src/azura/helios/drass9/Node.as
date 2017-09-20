package azura.helios.drass9
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.utils.ByteArray;
	
	public class Node implements BytesI
	{
		public var id:ByteArray=new ByteArray();
		public var data:ZintBuffer;
		public function Node()
		{
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			zb.readBytes(id,0,8);
			data=zb.readBytesZ();
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeBytes(id,0,8);
			zb.writeBytesZ(data);
			return zb;
		}
		
		public function clear():void{
			
		}
	}
}