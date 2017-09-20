package azura.banshee.ice
{
	import azura.common.collections.ZintBuffer;

	public class WalkerZ extends Zombie
	{
		public var isMe:Boolean=false;
		
		public function WalkerZ()
		{
			super();
		}
		
		public function fromBrief(zb:ZintBuffer):void{
			var old:Zombie=super.clone();
			
			id=zb.readZint();
			version=zb.readZint();
			x=zb.readZint();
			y=zb.readZint();
			z=zb.readZint();
			angle=zb.readZint();
//			trace("angle=",angle,this);
			
			check(old);
		}
		
		override public function toString():String{
			return "WalkerZ id="+id+" version="+version+" x="+x+" y="+y;
		}
	}
}