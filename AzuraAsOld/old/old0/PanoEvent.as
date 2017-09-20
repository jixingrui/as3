package pano.res
{
	import flash.events.Event;
	
	public class PanoEvent extends Event
	{
		public static var PANO:String="PANO";
		public var name:String;
		public function PanoEvent(name:String=null)
		{
			super(PANO);
			this.name=name;
		}
		
		override public function clone():Event{
			var ret:PanoEvent=new PanoEvent(name);
			return ret;
		}
	}
}