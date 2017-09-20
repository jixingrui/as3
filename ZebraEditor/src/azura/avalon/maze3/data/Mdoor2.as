package azura.avalon.maze3.data
{
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.Zebra2Old;
	import azura.common.collections.ZintBuffer;
	import azura.helios.hard10.ie.HardReaderI;
	
	import mx.utils.UIDUtil;
	
	[Bindable]
	public class Mdoor2 implements HardReaderI
	{
		public var toDoorUid:String;
		public var toDoorName:String;
		
		public var uid:String;
		public var name:String;
		
		public var dx:int;
		public var dy:int;
		public var inRegion:int=-1;
//		public var zebraData:ZintBuffer;
		public var cargo:ZintBuffer;
		
		public var zebra:Zebra2Old=new Zebra2Old();
		
		public var room:RoomShell;
				
		public function fromBytes(zb:ZintBuffer):void
		{
			toDoorUid=zb.readUTFZ();
			toDoorName=zb.readUTFZ();
			uid=zb.readUTFZ();
			name=zb.readUTFZ();
			dx=zb.readZint();
			dy=zb.readZint();
			inRegion=zb.readZint();
			zebra.fromBytes(zb.readBytesZ());
			cargo=zb.readBytesZ();
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTFZ(toDoorUid);
			zb.writeUTFZ(toDoorName);
			zb.writeUTFZ(uid);
			zb.writeUTFZ(name);
			zb.writeZint(dx);
			zb.writeZint(dy);
			zb.writeZint(inRegion);
			zb.writeBytesZ(zebra.toBytes());
			zb.writeBytesZ(cargo);
			return zb;
		}
		
		public function init():void
		{
			uid=UIDUtil.createUID();
			name='';
			dx=0;
			dy=0;
			inRegion=-1;
			zebra.clear();
			cargo=null;
		}
		
		public function toString():String{
			return "[D]"+name;
		}
	}
}