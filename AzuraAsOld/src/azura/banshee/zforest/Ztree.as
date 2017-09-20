package azura.banshee.zforest
{
	import azura.banshee.zebra.Zebra;
	import azura.common.collections.BytesI;
	import azura.common.collections.bitset.LBSet;
	import azura.common.collections.NameI;
	import azura.common.collections.ZintBuffer;
	
	public class Ztree implements BytesI,NameI
	{
		private var _name:String;
		public var rootX:int;
		public var rootY:int;
		public var zebra:Zebra=new Zebra();
		public var zbase:LBSet=new LBSet();
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			_name=zb.readUTFZ();
			rootX=zb.readZint();
			rootY=zb.readZint();
			zebra.fromBytes(zb.readBytesZ());
			zbase.fromBytes(zb.readBytesZ());
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTFZ(_name);
			zb.writeZint(rootX);
			zb.writeZint(rootY);
			zb.writeBytesZ(zebra.toBytes());
			zb.writeBytesZ(zbase.toBytes());
			return zb;
		}
	}
}