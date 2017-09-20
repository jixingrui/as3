package azura.banshee.starling.layers
{
	import azura.banshee.chessboard.dish.DishUserI;
	import azura.banshee.chessboard.dish.PlateType;
	import azura.banshee.chessboard.dish.PyramidDish;
	import azura.banshee.chessboard.dish.TileDish;
	import azura.banshee.chessboard.land.TileLand;
	import azura.banshee.chessboard.loaders.starling.MapLoaderStarling;
	import azura.banshee.chessboard.loaders.starling.MapLoaderClear;
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class LayerFloorClear extends Sprite implements DishUserI
	{
		private var _dishClear:PyramidDish;
		private var TileDish_MapLoaderClear:Dictionary=new Dictionary();
		
		public function set dishClear(value:PyramidDish):void
		{
			_dishClear = value;
			_dishClear.user=this;
		}
		
		public function look(xc:int,yc:int):void{
			if(stage==null)
				return;
			
			this.x=-xc+stage.stageWidth/2;
			this.y=-yc+stage.stageHeight/2;
			
			if(_dishClear!=null){
				var vc:Rectangle=new Rectangle();
				vc.x=xc;
				vc.y=yc;
				vc.width=stage.stageWidth;
				vc.height=stage.stageHeight;				
				_dishClear.look(_dishClear.levelMax,vc);
			}
		}
		
		public function clear():void{
			if(_dishClear!=null)
				_dishClear.clear();
			_dishClear=null;
		}
		
		public function _updateTile(tile:TileDish):void{
			TileDish_MapLoaderClear[tile]=MapLoaderClear.load(tile,texReady);
		}
		
		private function texReady(pl:MapLoaderStarling):void{
			var image:Image=pl.value as Image;
			var tile:TileLand=pl.tile;
			image.x=tile.x*256-_dishClear.bound*256/2;
			image.y=tile.y*256-_dishClear.bound*256/2;
			image.smoothing='none';
			if(tile.plateType==PlateType.Solid)
				image.blendMode='none';
			
			addChild(image);
			flatten();
		}
		
		public function _removeTile(tile:TileDish):void{
			var pl:MapLoaderStarling=TileDish_MapLoaderClear[tile];
			delete TileDish_MapLoaderClear[tile];

			pl.cancel();
			if(pl.hasServed){
				removeChild(pl.value as Image);
				flatten();			
			}
		}
	}
}