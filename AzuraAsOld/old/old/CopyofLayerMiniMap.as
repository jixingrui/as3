package azura.banshee.starling.layers
{
	import azura.banshee.chessboard.dish.DishUserI;
	import azura.banshee.chessboard.dish.PlateType;
	import azura.banshee.chessboard.dish.PyramidDish;
	import azura.banshee.chessboard.dish.TileDish;
	import azura.banshee.chessboard.land.TileLand;
	import azura.banshee.chessboard.loaders.starling.MapLoaderStarling;
	import azura.banshee.chessboard.loaders.starling.MapLoaderMini;
	
	import common.algorithm.FastMath;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class CopyofLayerMiniMap extends Sprite implements DishUserI
	{
		private var _dishMiniMap:PyramidDish;
		private var TileDish_PlateLoader:Dictionary=new Dictionary();
		
		private static var borderX:int=10;
		private static var borderY:int=10;
		private var mapCx:int=90;
		private var mapCy:int=75;
		private var mapWidth:int=mapCx*2;
		private var mapHeight:int=mapCy*2;
		
		private var red:Image;
		
		public function CopyofLayerMiniMap(){
			var bd:BitmapData=new BitmapData(4,4,true,0x0);
			var shape:Shape=new Shape();
			shape.graphics.beginFill(0xff0000,1);
			shape.graphics.drawCircle(2,2,2);
			shape.graphics.endFill();			
			bd.draw(shape);
			red=new Image(Texture.fromBitmapData(bd,false));
			red.touchable=false;
		}
		
		public override function render(support:RenderSupport, alpha:Number):void
		{
			support.finishQuadBatch();			
			Starling.context.setScissorRectangle(new Rectangle(borderX,stage.stageHeight-mapCy*2-borderY,mapWidth,mapHeight));
			super.render(support,alpha);
			support.finishQuadBatch();
			Starling.context.setScissorRectangle(null);
		}
		
		public function set dishMiniMap(value:PyramidDish):void
		{
			_dishMiniMap = value;
			_dishMiniMap.user=this;
		}
		
		public function look(xFc:int,yFc:int):void{
			if(stage==null)
				return;
			
			this.x=-xFc*scale+mapCx+borderX;
			this.y=-yFc*scale+stage.stageHeight-mapCy-borderY;
			
			red.x=xFc*scale-2;
			red.y=yFc*scale-2;
			
			if(_dishMiniMap!=null){
				var vcs:Rectangle=new Rectangle();
				vcs.x=xFc*scale;
				vcs.y=yFc*scale;
				vcs.width=mapWidth;
				vcs.height=mapHeight;				
				_dishMiniMap.look(level,vcs);
			}
		}
		
		public function clear():void{
			if(_dishMiniMap!=null)
				_dishMiniMap.clear();
			_dishMiniMap=null;
		}
		
		private function get level():int{
			var sqrt:int= Math.floor(_dishMiniMap.levelMax/2);
			var minus:int=_dishMiniMap.levelMax-4;
			var result:int=Math.min(sqrt,minus);
			result=Math.max(0,result);
			return result;
		}
		
		private function get scale():Number{
			return FastMath.pow2(level)/_dishMiniMap.bound;
		}
		
		public function _updateTile(tile:TileDish):void{
			TileDish_PlateLoader[tile]=MapLoaderMini.load(tile,texReady);
		}
		
		private function texReady(pl:MapLoaderStarling):void{
			var image:Image=pl.value as Image;
			var tile:TileLand=pl.tile;
			
			image.x=tile.x*256-_dishMiniMap.bound*256/2*scale;
			image.y=tile.y*256-_dishMiniMap.bound*256/2*scale;
			if(tile.plateType==PlateType.Solid)
				image.blendMode='none';
			addChild(image);
			
			removeChild(red);
			addChild(red);
			
//			flatten();
		}
		
		public function _removeTile(tile:TileDish):void{
			var pl:MapLoaderStarling=TileDish_PlateLoader[tile];
			delete TileDish_PlateLoader[tile];
			
			pl.cancel();
			if(pl.hasServed){
				removeChild(pl.value as Image);
//				flatten();			
			}
						
			if(this.getChildIndex(red)>=0)
				removeChild(red);
		}
	}
}