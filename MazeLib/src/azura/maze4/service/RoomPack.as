package azura.maze4.service
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import zz.karma.Maze.K_Room;
	import zz.karma.Maze.K_Woo;

	public class RoomPack implements BytesI
	{
		public var kr:K_Room=new K_Room(MazePack.ksMaze);
		public var wooList:Vector.<WooPack>=new Vector.<WooPack>();
		
		public function RoomPack()
		{
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			kr.fromBytes(zb.readBytesZ());
			var size:int=zb.readZint();
			for(var i:int=0;i<size;i++){
				var kw:WooPack=new WooPack();
				kw.room=this;
				kw.fromBytes(zb.readBytesZ());
				wooList.push(kw);
			}
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeBytesZ(kr.toBytes());
			zb.writeZint(wooList.length);
			for each(var woo:WooPack in wooList){
				zb.writeBytesZ(woo.toBytes());
			}
			return zb;
		}
	}
}