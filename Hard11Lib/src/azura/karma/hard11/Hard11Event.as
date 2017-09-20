package azura.karma.hard11
{
	import flash.events.Event;
	
	public class Hard11Event extends Event
	{
		public static const Rename_L:String="RENAME_L";
//		public static const RenameComplete:String="_RenameComplete";
		public static const Jump:String="_Jump";
		public var newName:String;
		public var idxLocal:int;
		public var item:HardItem;
		public function Hard11Event(type:String)
		{
			super(type,true,true);
		}
	}
}