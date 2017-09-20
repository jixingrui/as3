package azura.common.ui.chat
{
	import flash.events.Event;
	
	public class MsgEvent extends Event
	{
		public static var VOICE:String="VOICE";
		
		public var mc5:String;
		
		public function MsgEvent(type:String)
		{
			super(type,true);
		}
		
//		override public function clone():Event{
//			var c:MsgEvent=new MsgEvent(type);
//			c.mc5=mc5;
//			return c;
//		}
	}
}