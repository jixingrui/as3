package azura.banshee.chessboard.loaders.filter
{
	import azura.banshee.chessboard.dish.Shard;
	import azura.banshee.naga.ImageStarling;
	
	import common.async.AsyncBoxI;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class ShardFilterBox implements AsyncBoxI
	{
		public var image:ImageStarling;
		public var mask:Texture;
		
		public function dispose():void{
			image.dispose();
			mask.dispose();
			
			trace("shard disposed");
		}
	}
}