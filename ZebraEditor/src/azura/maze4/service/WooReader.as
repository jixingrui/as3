package azura.maze4.service
{
	import azura.karma.def.KarmaSpace;
	import azura.karma.hard11.HardReaderI;
	
	import zz.karma.Maze.K_Woo;
	
	public class WooReader extends K_Woo implements HardReaderI
	{
		public function WooReader()
		{
			super(Connection.ksMaze);
		}
		
		public function init():void
		{
		}
	}
}