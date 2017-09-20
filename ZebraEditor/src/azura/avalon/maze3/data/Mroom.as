package azura.avalon.maze3.data
{
	import azura.common.collections.ZintBuffer;
	import azura.common.ui.list.ListItemI;
	import azura.helios.hard10.ie.HardReaderI;
	
	import mx.utils.UIDUtil;
	
	import org.osflash.signals.Signal;
	
	[Bindable]
	public class Mroom implements HardReaderI
	{
		public var uid:String;
		public var name:String;
		public var zmax:int;
		public var regionCount:int;
		/**
		 *view angle: 30,45 
		 */
		public var tilt:int;
		/**
		 * where is north
		 */
		public var pan:int;
		public var scale:int;
		public var me5Zforest:String;
		public var cargo:ZintBuffer;
		
		public function init():void
		{
			uid=UIDUtil.createUID();
			name='';
			zmax=-1;
			regionCount=0;
			tilt=0;
			pan=0;
			scale=100;
			me5Zforest='';
			cargo=null;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			uid=zb.readUTFZ();
			name=zb.readUTFZ();
			zmax=zb.readZint();
			regionCount=zb.readZint();
			tilt=zb.readZint();
			pan=zb.readZint();
			scale=zb.readZint();
			me5Zforest=zb.readUTFZ();
			cargo=zb.readBytesZ();
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTFZ(uid);
			zb.writeUTFZ(name);
			zb.writeZint(zmax);
			zb.writeZint(regionCount);
			zb.writeZint(tilt);
			zb.writeZint(pan);
			zb.writeZint(scale);
			zb.writeUTFZ(me5Zforest);
			zb.writeBytesZ(cargo);
			return zb;
		}
	}
}