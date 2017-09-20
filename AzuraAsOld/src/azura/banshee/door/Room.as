package azura.banshee.door
{
	import azura.common.collections.ZintBuffer;
	import azura.common.ui.list.ListItemI;
	
	import org.osflash.signals.Signal;
	
	[Bindable]
	public class Room implements ListItemI
	{
		public var zimage_zpano_zforest:int;
		public var zmax:int;
		/**
		 *view angle: 30,45 
		 */
		public var tilt:int;
		/**
		 * where is north
		 */
		public var pan:int;
		public var scale:Number;
		public var mc5:String;
		public var cargo:ZintBuffer;
		
		private var _onMapChange:Signal=new Signal();
		
		public function get onUpdate():Signal
		{
			return _onMapChange;
		}
		
		public function clear():void
		{
			zimage_zpano_zforest=0;
			tilt=0;
			pan=0;
			scale=1;
			mc5='';
			cargo=null;
			
			onUpdate.dispatch();
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			zimage_zpano_zforest=zb.readZint();
			zmax=zb.readZint();
			tilt=zb.readZint();
			pan=zb.readZint();
			scale=zb.readZint()/100;
			mc5=zb.readUTF();
			cargo=zb.readBytesZ();
			
			onUpdate.dispatch();
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(zimage_zpano_zforest);
			zb.writeZint(zmax);
			zb.writeZint(tilt);
			zb.writeZint(pan);
			zb.writeZint(scale*100);
			zb.writeUTF(mc5);
			zb.writeBytesZ(cargo);
			return zb;
		}
	}
}