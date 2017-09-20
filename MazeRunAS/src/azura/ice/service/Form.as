package azura.ice.service
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	public class Form implements BytesI
	{
		public static var stand:String="stand";
		public static var walk:String="walk";
		public static var attack:String="attack";
		
		public var skin:String;
		public var action:String;
		public var speed:int;
		public function Form()
		{
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTFZ(skin);
			zb.writeUTFZ(action);
			zb.writeZint(speed);
			return zb;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			skin=zb.readUTFZ();
			action=zb.readUTFZ();
			speed=zb.readZint();
		}
		
		public function toString():String{
			//			trace("skin=",skin,"action=",action,this);
			return "skin="+skin+" action="+action+" speed="+speed;
		}
	}
}