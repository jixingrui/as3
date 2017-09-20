package azura.avalon.maze.data
{
	import azura.avalon.maze3.data.Maze;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	public class Dump implements BytesI
	{
		public var eyeRoomUID:String;
		public var eyeX:int;
		public var eyeY:int;
		public var maze:Maze=new Maze();
		
		public function fromBytes(zb:ZintBuffer):void
		{
			eyeRoomUID=zb.readUTFZ();
			eyeX=zb.readZint();
			eyeY=zb.readZint();
			maze.fromBytes(zb.readBytesZ());
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTFZ(eyeRoomUID);
			zb.writeZint(eyeX);
			zb.writeZint(eyeY);
			zb.writeBytesZ(maze.toBytes());
			return zb;
		}
	}
}