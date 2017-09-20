package azura.banshee.chessboard.loaders
{
	import azura.banshee.chessboard.dish.Shard;
	import azura.banshee.chessboard.dish.TileDish;
	import azura.banshee.naga.starling.AtlasStarling;
	
	import common.async.AsyncBoxI;
	
	public class CookieBox implements AsyncBoxI{
		private var tile:TileDish;
		public var shardList:Vector.<Shard>;
		public var atlas:AtlasStarling;
		public function CookieBox(tile:TileDish,shardList:Vector.<Shard>,atlas:AtlasStarling){
			this.tile=tile;
			this.shardList=shardList;
			this.atlas=atlas;
		}
		public function dispose():void{
//<<<<<<< .mine
////			atlas.dispose();
////			atlas=null;
////			shardList=null;
//=======
//			tile.atlas.dispose();
//			tile.atlas=null;
//			tile.shardList=new Vector.<Shard>();
//>>>>>>> .r206
		}
	}
}