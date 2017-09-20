package azura.maze4.service
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import zz.karma.Maze.K_Woo;

	public class WooPack implements BytesI
	{
		public var woo:K_Woo=new K_Woo(MazePack.ksMaze);
		public var room:RoomPack;
		
		public function WooPack()
		{
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			woo.fromBytes(zb);
		}
		
		public function toBytes():ZintBuffer
		{
			return null;
		}
	}
}