package azura.touch.watcherOld
{
	import flash.events.Event;
	import flash.geom.Point;
	
	public class WatcherEvent extends Event
	{
		public static var DOUBLECLICK:String="DOUBLECLICK";
		public static var ZOOM:String="ZOOM";
		public static var DRAG_START:String="DRAG_START";
		public static var DRAG_MOVE:String="DRAG_MOVE";
		public static var DRAG_END:String="DRAG_END";
		
		public var position:Point;
		public var delta:Point;
		public var scaleX:Number;
		public var scaleY:Number;
		
		public function WatcherEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}