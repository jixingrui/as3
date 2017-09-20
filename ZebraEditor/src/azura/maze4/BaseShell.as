package azura.maze4
{
	import azura.common.collections.NameI;
	import azura.karma.def.KarmaSpace;
	
	import zz.karma.Maze.Room.K_Base;
	
	public class BaseShell implements NameI
	{
		public var base:K_Base;
		
		public function BaseShell(ks:KarmaSpace){
			base=new K_Base(ks);
		}
		
		public function get name():String
		{
			return base.name;
		}
		
		public function set name(value:String):void
		{
			base.name=value;
		}
	}
}