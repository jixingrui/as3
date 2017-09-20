package azura.banshee.layers.zpano
{
	import azura.banshee.door.Door;
	
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class ArrowClicker extends Arrow
	{
		public var onDoorClick:Signal;
		public function ArrowClicker(stage:Stage, door:Door)
		{
			super(stage, door);
		}
		
		private function get door():Door{
			return source as Door;
		}
		
		override public function click(event:MouseEvent):void{
			onDoorClick.dispatch(door);
		}
		
	}
}