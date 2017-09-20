package old.azura.avalon.ice.swamp
{
	import flash.events.Event;
	
	public class SkinEvent extends Event
	{
		public static var CHANGE:String="CHANGE";
		
		public var md5N4:String;
		
		public function SkinEvent()
		{
			super(CHANGE);
		}
	}
}