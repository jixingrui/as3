package azura.avalon.maze3.data
{
	import azura.avalon.maze3.ui.woo.cargo.WooCargo;
	import azura.banshee.zebra.Zebra;
	import azura.common.collections.ZintBuffer;
	import azura.helios.hard10.ie.HardReaderI;
	
	import mx.utils.UIDUtil;
	
	[Bindable]
	public class Mwoo implements HardReaderI
	{
		public var uid:String;
		public var name:String;
		
		public var dx:int;
		public var dy:int;
		public var inRegion:int=-1;
		public var icon:Zebra=new Zebra();
		
//		public var cargoData:ZintBuffer;
		public var cargo:WooCargo=new WooCargo();
				
		public function fromBytes(zb:ZintBuffer):void
		{
			uid=zb.readUTFZ();
			name=zb.readUTFZ();
			dx=zb.readZint();
			dy=zb.readZint();
			inRegion=zb.readZint();
			icon.fromBytes(zb.readBytesZ());
//			cargoData=zb.readBytesZ();
			cargo.fromBytes(zb.readBytesZ());
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTFZ(uid);
			zb.writeUTFZ(name);
			zb.writeZint(dx);
			zb.writeZint(dy);
			zb.writeZint(inRegion);
			zb.writeBytesZ(icon.toBytes());
			zb.writeBytesZ(cargo.toBytes());
			return zb;
		}
		
		public function init():void
		{
			uid=UIDUtil.createUID();
			name='';
			dx=0;
			dy=0;
			inRegion=-1;
			icon.clear();
//			cargoData=null;
			cargo=new WooCargo();
		}
		
		public function toString():String{
			return "[W]"+name+cargo.toString();
		}
	}
}