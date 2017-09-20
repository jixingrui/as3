package azura.banshee.chessboard.loaders
{
	import azura.banshee.chessboard.dish.Shard;
	import azura.banshee.naga.ImageStarling;
	import azura.banshee.naga.starling.FrameStarling;
	
	import common.async.AsyncBoxI;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class ShardBox implements AsyncBoxI
	{
		public var image:ImageStarling;
		
		public function dispose():void{
			image.dispose();
//			trace("ShardBox.dispose");
		}
		
		[Bindable]
		public static var count:int;
		public static function add(value:int):void{
			count+=value;
//			trace("ShardBox: "+count);
		}
	}
}