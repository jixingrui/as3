package azura.avalon.zbase.zway
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.avalon.zbase.Zbase;
	
	public class Zway implements BytesI
	{
		public var base:Zbase=new Zbase();
//		public var wayMap:CopyofBusMap=new CopyofBusMap();
		
		public function fromBytes(zb:ZintBuffer):void
		{
			base.fromBytes(zb.readBytesZ());
//			wayMap.fromBytes(zb.readBytesZ());
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeBytesZ(base.toBytes());
//			zb.writeBytesZ(wayMap.toBytes());
			return zb;
		}
	}
}