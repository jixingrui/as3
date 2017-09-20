package azura.helios.hard10.ui
{
	
	import flash.events.Event;
	import azura.helios.hard10.hub.HardItem;
	
	public class HardEvent extends Event
	{
		public static const Rename_L:String="RENAME_L";
//		public static const RenameComplete:String="_RenameComplete";
		public static const Jump:String="_Jump";
		public var newName:String;
		public var idxLocal:int;
		public var item:HardItem;
		public function HardEvent(type:String)
		{
			super(type,true,true);
		}
	}
}