package azura.common.ui.bubble
{
	import flash.events.Event;
	
	public class BubbleEvent extends Event
	{
		public static var BUBBLE:String="BUBBLE";
		
		public var bubble:Bubble;
		
		public function BubbleEvent(bubble:Bubble)
		{
			super(BUBBLE);
			this.bubble=bubble;
		}
	}
}