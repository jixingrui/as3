package azura.banshee.starling.layers
{
	import azura.banshee.chessboard.dish.DishUserI;
	import azura.banshee.chessboard.dish.PlateType;
	import azura.banshee.chessboard.dish.PyramidDish;
	import azura.banshee.chessboard.dish.TileDish;
	import azura.banshee.chessboard.land.TileLand;
	import azura.banshee.chessboard.loaders.starling.MapLoaderMosaic;
	import azura.banshee.chessboard.loaders.starling.MapLoaderStarling;
	
	import common.algorithm.FastMath;
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureSmoothing;
	
	public class LayerFloorMosaic extends Sprite implements DishUserI
	{
		private static var viewExtend:int=1024;
		private var _dishMosaic:PyramidDish;
		private var TileDish_PlateLoader:Dictionary=new Dictionary();
		
		public function set dishMosaic(value:PyramidDish):void
		{
			_dishMosaic = value;
			_dishMosaic.user=this;
		}
		
		public function look(xc:int,yc:int):void{
			if(stage==null)
				return;
			
			this.x=-xc+stage.stageWidth/2;
			this.y=-yc+stage.stageHeight/2;
			
			if(_dishMosaic!=null){
				var vcs:Rectangle=new Rectangle();
				vcs.x=xc*scale;
				vcs.y=yc*scale;
				vcs.width=(stage.stageWidth+viewExtend)*scale;
				vcs.height=(stage.stageHeight+viewExtend)*scale;				
				_dishMosaic.look(level,vcs);
			}
		}
		
		public function clear():void{
			if(_dishMosaic!=null)
				_dishMosaic.clear();
			_dishMosaic=null;
		}
		
		private function get level():int{
			return Math.ceil(_dishMosaic.levelMax/2);
		}
		
		private function get scale():Number{
			return FastMath.pow2(level)/_dishMosaic.bound;
		}
		
		public function _updateTile(tile:TileDish):void{
			TileDish_PlateLoader[tile]=MapLoaderMosaic.load(tile,texReady);
		}
		
		private function texReady(pl:MapLoaderStarling):void{
			var image:Image=pl.value as Image;
//			image.smoothing=TextureSmoothing.TRILINEAR;
			var tile:TileLand=pl.tile;
			
			if(tile.plateType==PlateType.Solid)
				image.blendMode='none';
			
			image.x=tile.x*256/scale-_dishMosaic.bound*256/2;
			image.y=tile.y*256/scale-_dishMosaic.bound*256/2;
			image.scaleX=1/scale;
			image.scaleY=1/scale;
			
			addChild(image);
			flatten();
		}
		
		public function _removeTile(tile:TileDish):void{
			var pl:MapLoaderStarling=TileDish_PlateLoader[tile];
			delete TileDish_PlateLoader[tile];
			
			pl.cancel();
			if(pl.hasServed){
				removeChild(pl.value as Image);
				flatten();			
			}
		}
	}
}