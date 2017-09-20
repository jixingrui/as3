package azura.common.graphics
{
	import flash.events.Event;
	
	public class ClickEvent extends Event
	{
		public static var Body:String='Body';
		public function ClickEvent(type:String)
		{
			super(type);
		}
	}
}