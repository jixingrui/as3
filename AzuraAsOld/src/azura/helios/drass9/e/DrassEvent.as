package azura.helios.drass9.e
{
	import azura.helios.drass9.DrassNode;
	
	import flash.events.Event;
	
	public class DrassEvent extends Event
	{
		public static const Rename:String="_Rename";
		public static const RenameComplete:String="_RenameComplete";
		public static const RightClick:String="_RightClick";
		public static const Jump:String="_Jump";
		public var newName:String;
		public var idxLocal:int;
		public var item:DrassNode;
		public function DrassEvent(type:String)
		{
			super(type,true,true);
		}
	}
}