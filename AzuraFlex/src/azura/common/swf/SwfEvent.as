package azura.common.swf
{
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	public class SwfEvent extends Event
	{
		public static var ASK_INPUT:String='ASK_INPUT';
		public static var ANSWER_INPUT:String='ANSWER_INPUT';
		public static var ASK_SCAN:String='ASK_SCAN';
		public static var ANSWER_SCAN:String='ANSWER_SCAN';
		public static var RECSTART:String="RECSTART";
		public static var RECSTOP:String="RECSTOP";
		public static var RECDONE:String="RECDONE";
		public static var RECRAW:String="RECRAW";
		public static var KEY_RETURN:String="KEY_RETURN";
		
		public var success:Boolean;
		public var session:String;
		public var string:String;
		public var data:ByteArray;
		public var milliseconds:int;
		
		public function SwfEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event{
			var se:SwfEvent=new SwfEvent(type);
			se.session=session;
			se.success=success;
			se.string=string;
			se.data=data;
			se.milliseconds=milliseconds;
			return se;
		}
	}
}