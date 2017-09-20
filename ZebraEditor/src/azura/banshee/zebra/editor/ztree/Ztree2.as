package azura.banshee.zebra.editor.ztree
{
	import azura.banshee.zebra.Zebra2Old;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.bitset.LBSet;
	
	public class Ztree2 implements BytesI
	{
		private var _name:String;
		public var rootX:int;
		public var rootY:int;
		public var zebra:Zebra2Old=new Zebra2Old();
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