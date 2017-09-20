package azura.avalon.maze.data
{
	import azura.common.collections.ZintBuffer;
	import azura.common.ui.list.ListItemI;
	
	import org.osflash.signals.Signal;
	
	[Bindable]
	public class Room2D implements ListItemI
	{
		public var uid:String;
		public var name:String;
		public var zmax:int;
		public var regions:int;
		/**
		 *view angle: 30,45 
		 */
		public var tilt:int;
		/**
		 * where is north
		 */
		public var pan:int;
		public var scale:int=100;
		public var mc5:String;
		public var cargo:ZintBuffer;
		
		public function clear():void
		{
			uid='';
			name='';
			zmax=-1;
			regions=0;
			tilt=0;
			pan=0;
			scale=100;
			mc5='';
			cargo=null;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			uid=zb.readUTFZ();
			name=zb.readUTFZ();
			zmax=zb.readZint();
			regions=zb.readZint();
			tilt=zb.readZint();
			pan=zb.readZint();
			scale=zb.readZint();
			mc5=zb.readUTFZ();
			cargo=zb.readBytesZ();
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTFZ(uid);
			zb.writeUTFZ(name);
			zb.writeZint(zmax);
			zb.writeZint(regions);
			zb.writeZint(tilt);
			zb.writeZint(pan);
			zb.writeZint(scale);
			zb.writeUTFZ(mc5);
			zb.writeBytesZ(cargo);
			return zb;
		}
	}
}