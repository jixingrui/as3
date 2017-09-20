package azura.maze4.service
{
	import azura.karma.hard11.HardReaderI;
	
	import zz.karma.Maze.K_Room;
	
	public class RoomReader extends K_Room implements HardReaderI
	{
		public function RoomReader()
		{
			super(Connection.ksMaze);
		}
		
		public function init():void
		{
			trace("init",this);
		}
		
	}
}