package azura.banshee.door
{
	import azura.common.collections.ZintBuffer;
	import azura.common.ui.list.ListItemI;
	
	[Bindable]
	public class Door extends GroundItem implements ListItemI
	{
		public var uid:String;
		public var toDoorUid:String;
		public var toDoorName:String;
		public var dx:int;
		public var dy:int;
				
		public function clear():void
		{
			uid='';
			toDoorUid='';
			toDoorName='';
			x=0;
			y=0;
			z=0;
			tilt=0;
			pan=0;
			roll=0;
			foot_ass_head=0;
			scale=1;
			mc5='';
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			uid=zb.readUTF();
			toDoorUid=zb.readUTF();
			toDoorName=zb.readUTF();
			dx=zb.readZint();
			dy=zb.readZint();
			x=zb.readZint();
			y=zb.readZint();
			z=zb.readZint();
			tilt=zb.readZint();
			pan=zb.readZint();
			roll=zb.readZint();
			foot_ass_head=zb.readZint();
			scale=zb.readZint();
			mc5=zb.readUTF();
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTF(uid);
			zb.writeUTF(toDoorUid);
			zb.writeUTF(toDoorName);
			zb.writeZint(dx);
			zb.writeZint(dy);
			zb.writeZint(x);
			zb.writeZint(y);
			zb.writeZint(z);
			zb.writeZint(tilt);
			zb.writeZint(pan);
			zb.writeZint(roll);
			zb.writeZint(foot_ass_head);
			zb.writeZint(scale);
			zb.writeUTF(mc5);
			return zb;
		}
	}
}