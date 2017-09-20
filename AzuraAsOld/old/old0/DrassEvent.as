package azura.hellios.drass6.itemRenderer
{
	import flash.events.Event;
	
	public class DrassEvent extends Event
	{
		public static const Rename:String="_Rename";
		public static const RenameComplete:String="_RenameComplete";
		public static const RightClick:String="_RightClick";
		public var newName:String;
		public var idxLocal:int;
		public function DrassEvent(type:String)
		{
			super(type,true,true);
		}
	}
}