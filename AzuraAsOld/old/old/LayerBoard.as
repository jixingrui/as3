package azura.banshee.starling.layers
{
	import azura.banshee.starling.StarlingAll;
	import azura.gallerid.Gal_Http;
	
	import common.algorithm.FastMath;
	import common.collections.ZintBuffer;
	import common.loaders.CommonImageLoader;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	public class LayerBoard extends Sprite
	{
		private var board:Image;
		private var bd:BitmapData;
		private var dragStart:Point=new Point();
		
		private var boardStart:Point=new Point();
		
		private var instance:LayerBoard;
		
		public function LayerBoard(){
			instance=this;
		}
		
		public function showImage(md5Jpg:String):void{
			
			Gal_Http.load(md5Jpg,fileLoaded,true);
			function fileLoaded(gh:Gal_Http):void{				
				var zb:ZintBuffer=new ZintBuffer(gh.value);
				CommonImageLoader.load(loaded,zb);				
			}
			function loaded(bd_:BitmapData):void{
				bd=bd_;
				if(board!=null)
					return;
				
				board=new Image(Texture.fromBitmapData(bd));
				board.smoothing=TextureSmoothing.NONE;
				board.x=StarlingAll.stage2D.stageWidth/2-bd.width/2;
				board.y=StarlingAll.stage2D.stageHeight/2-bd.height/2;
				board.addEventListener(TouchEvent.TOUCH,onTouch);
				addChild(board);
				instance.touchable=true;
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
					
					boardStart.x=board.x;
					boardStart.y=board.y;
				}
				if(touch.phase == TouchPhase.ENDED)
				{
					var dist:int=FastMath.dist(dragStart.x,dragStart.y,touch.globalX,touch.globalY);
					if(dist<30)
					{
						removeChild(board);
						board.dispose();
						board=null;
						instance.touchable=false;
					}
				}
				if(touch.phase==TouchPhase.MOVED){
					if(bd.width>StarlingAll.stage2D.stageWidth){
						var destX:int=boardStart.x+(touch.globalX-dragStart.x);
						if(destX<=0 && destX+bd.width>=StarlingAll.stage2D.stageWidth){
							board.x=destX;
						}
					}
					if(bd.height>StarlingAll.stage2D.stageHeight){
						var destY:int=boardStart.y+(touch.globalY-dragStart.y);
						if(destY<=0 && destY+bd.height>=StarlingAll.stage2D.stageHeight){
							board.y=destY;
						}
					}
				}
			}
		}
	}
}