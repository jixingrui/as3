package azura.banshee.starling.layers
{
	import azura.banshee.chessboard.dish.PlateType;
	import azura.banshee.chessboard.land.LandUserI;
	import azura.banshee.chessboard.land.PyramidLand;
	import azura.banshee.chessboard.land.TileLand;
	import azura.banshee.chessboard.loaders.starling.MapLoaderStarling;
	import azura.banshee.chessboard.loaders.starling.MapLoaderPano;
	import azura.gallerid.Gal_Http;
	
	import common.algorithm.FastMath;
	import common.collections.DictionaryUtil;
	import common.collections.ZintBuffer;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class LayerPano extends Sprite implements LandUserI
	{
		private var pyramid:PyramidLand;
		private var this_:LayerPano;
		
		private var TileLand_MapLoaderPano:Dictionary=new Dictionary();
		
		private var dragStart:Point=new Point();
		private var boardPos:Point=new Point();
		
//		private var busy:Boolean;
		
		public function LayerPano()
		{
			super();
			this_=this;	
		}
		
		public function show(md5Pano:String):void{
			if(DictionaryUtil.getLength(TileLand_MapLoaderPano)>0)
				return;
			
			Gal_Http.load(md5Pano,ready,true);
			function ready(gh:Gal_Http):void{
				var zb:ZintBuffer=gh.value as ZintBuffer;
				zb.uncompress();
				pyramid=new PyramidLand();
				pyramid.decode(zb);
				pyramid.user=this_;
				
				boardPos=new Point();
				this_.touchable=true;
				this_.addEventListener(TouchEvent.TOUCH,onTouch);
				look(0,0);
			}		
			function onTouch(e:TouchEvent):void
			{
				e.stopImmediatePropagation();
				e.stopPropagation();
				var touch:Touch = e.getTouch(stage);
				if(!touch)
					return;
				
				if(touch.phase==TouchPhase.BEGAN){
					dragStart.x=touch.globalX;
					dragStart.y=touch.globalY;
				}
				if(touch.phase == TouchPhase.ENDED)
				{
					var dist:int=FastMath.dist(dragStart.x,dragStart.y,touch.globalX,touch.globalY);
					if(dist<30)
					{
						this_.clear();
					}else{
						boardPos.x-=touch.globalX-dragStart.x;
						boardPos.y-=touch.globalY-dragStart.y;
					}
				}
				if(touch.phase==TouchPhase.MOVED){
					look(boardPos.x-touch.globalX+dragStart.x,boardPos.y-touch.globalY+dragStart.y);
				}
			}
		}
		
		public function _updateTile(tile:TileLand):void
		{
//			trace("load: "+tile.fi);
			TileLand_MapLoaderPano[tile]=MapLoaderPano.load(tile,texReady);
		}
		
		private function texReady(pl:MapLoaderStarling):void{
//			trace("ready: "+pl.tile.fi);
			if(TileLand_MapLoaderPano[pl.tile]!=pl){
				trace("pano loading error");
				return;
			}
			
			var image:Image=pl.value as Image;
			var tile:TileLand=pl.tile;
			image.x=tile.x*256-pyramid.bound*256/2;
			image.y=tile.y*256-pyramid.bound*256/2;
			image.smoothing='none';
			if(tile.plateType==PlateType.Solid)
				image.blendMode='none';
			
			addChild(image);
			flatten();
		}
		
		public function _removeTile(tile:TileLand):void
		{
			var pl:MapLoaderStarling=TileLand_MapLoaderPano[tile];
			delete TileLand_MapLoaderPano[tile];
			
			trace("cancel: "+tile.fi);
			pl.cancel();
			if(pl.hasServed){
				removeChild(pl.value as Image);
				flatten();			
			}
		}
		
		public function look(xc:int,yc:int):void{
			if(stage==null)
				return;
			
			this.x=-xc+stage.stageWidth/2;
			this.y=-yc+stage.stageHeight/2;
			
			if(pyramid!=null){
				var vc:Rectangle=new Rectangle();
				vc.x=xc;
				vc.y=yc;
				vc.width=stage.stageWidth;
				vc.height=stage.stageHeight;				
				pyramid.look(pyramid.levelMax,vc);
			}
		}
		
		public function clear():void{
			touchable=false;
			if(pyramid!=null)
				pyramid.clear();
			pyramid=null;
		}
	}
}