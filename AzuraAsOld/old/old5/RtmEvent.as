package azura.fractale.rtm
{
	import flash.events.Event;
	import flash.geom.PerspectiveProjection;
	
	public class RtmEvent extends Event
	{
		public static var CONNECTED:String="CUMULUS_CONNECTED";
		public static var CONNECTION_FAILED:String="CONNECTION_FAILED";
		public static var LISTEN_READY:String="LISTEN_READY";
		public static var HEAR_HELLO:String="HEAR_HELLO";
		public static var RECEIVE:String="RECEIVE";
		
		public function RtmEvent(type:String)
		{
			super(type);
		}
		
		public var peerId:String;
		public var text:String;
		public var success:Boolean;
		
		override public function clone():Event{
			var c:RtmEvent=new RtmEvent(super.type);
			c.peerId=this.peerId;
			c.text=this.text;
			return c;
		}
	}
}