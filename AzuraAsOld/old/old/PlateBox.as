package azura.banshee.chessboard.loaders
{
	import common.async.AsyncBoxI;
	
	import flash.utils.setTimeout;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class PlateBox implements AsyncBoxI
	{
		public var image:Image;
		
		public function dispose():void
		{
			image.texture.dispose();
			image.dispose();
//			setTimeout(texture.dispose,0);
//			texture.dispose();
//			trace("PlateBox.dispose");
		}
		
//		public static var count:int;
//		public static function add(value:int):void{
//			count+=value;
//			trace("PlateBox: "+count);
//		}
	}
}