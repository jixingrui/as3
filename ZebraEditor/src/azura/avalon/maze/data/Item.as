package azura.avalon.maze.data
{
	import azura.banshee.door.DoorI;
	import azura.banshee.zebra.box.AbBoxI;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.common.ui.list.ListItemI;
	
	[Bindable]
	public class Item implements BytesI, ListItemI, AbBoxI
	{
		public var uid:String;
		public var name:String;
		public var x:int;
		public var y:int;
		public var z:int;
		public var dx:int;
		public var dy:int;
		public var dz:int;
		public var tilt:int;
		public var pan:int;
		public var roll:int;
		public var scale:int=100;
		public var region:int=-1;
		public var mc5:String;
		public var cargo:ZintBuffer;
		
		public var regionNode:RegionNode;
		public var reverse:Boolean;
		
		public function get priority():int
		{
			return 0;
		}
		
		public function zboxTouched():Boolean
		{
			trace("click item",name,this);
			return false;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			uid=zb.readUTF();
			name=zb.readUTF();
			x=zb.readZint();
			y=zb.readZint();
			z=zb.readZint();
			dx=zb.readZint();
			dy=zb.readZint();
			dz=zb.readZint();
			tilt=zb.readZint();
			pan=zb.readZint();
			roll=zb.readZint();
			scale=zb.readZint();
			region=zb.readZint();
			mc5=zb.readUTF();
			cargo=zb.readBytesZ();
			
			if(this is Door)
				return;
			trace(name,region);
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTF(uid);
			zb.writeUTF(name);
			zb.writeZint(x);
			zb.writeZint(y);
			zb.writeZint(z);
			zb.writeZint(dx);
			zb.writeZint(dy);
			zb.writeZint(dz);
			zb.writeZint(tilt);
			zb.writeZint(pan);
			zb.writeZint(roll);
			zb.writeZint(scale);
			zb.writeZint(region);
			zb.writeUTF(mc5);
			zb.writeBytesZ(cargo);
			return zb;
		}
		
		public function clear():void
		{
			uid='';
			name='';
			x=0;
			y=0;
			z=0;
			dx=0;
			dy=0;
			dz=0;
			tilt=0;
			pan=0;
			roll=0;
			scale=100;
			region=-1;
			mc5='';
			cargo=null;
		}
		
		public function toString():String{
			return "[I]"+name;
		}
	}
}