package azura.banshee.door
{
	import org.osflash.signals.Signal;

	[Bindable]
	public class GroundItem
	{
		public var x:int;
		public var y:int;
		public var z:int;
		public var tilt:int;
		public var pan:int;
		public var roll:int;
		
		public var foot_ass_head:int;
		public var scale:int;
		public var mc5:String;
		
		public var onUpdate:Signal=new Signal();
		
		public function GroundItem()
		{
		}
	}
}