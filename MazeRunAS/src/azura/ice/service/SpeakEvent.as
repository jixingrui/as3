package azura.ice.service
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	public class SpeakEvent implements BytesI
	{
		public static var stand:String="stand";
		public static var walk:String="walk";
		public static var attack:String="attack";
		
		public var action:String;
		public var angle:int;
		public function SpeakEvent()
		{
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTFZ(action);
			zb.writeZint(angle);
			return zb;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			action=zb.readUTFZ();
			angle=zb.readZint();
		}
		
		public function toString():String{
			//			trace("skin=",skin,"action=",action,this);
			return "action="+action;
		}
	}
}