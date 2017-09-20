package azura.banshee.chessboard.loaders.filter
{
	import azura.banshee.chessboard.dish.DishUserI;
	import azura.banshee.chessboard.dish.PyramidDish;
	import azura.banshee.chessboard.dish.Shard;
	import azura.banshee.chessboard.dish.TileDish;
	import azura.banshee.chessboard.loaders.CookieLoader;
	import azura.banshee.chessboard.loaders.PlateLoader;
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class LayerAssFilter extends Sprite implements DishUserI
	{
		private var _dishAss:PyramidDish;
		private var Key_ShardLoader:Dictionary=new Dictionary();
		private var TileDish_PlateLoader:Dictionary=new Dictionary();
		
		public function LayerAssFilter(){
			super.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			function onEnterFrame(event:Event):void{
				//				sortChildren(ImageWithFoot.compareYFoot);
			}
		}
		
		public function set dishAss(value:PyramidDish):void
		{
			_dishAss = value;
			_dishAss.user=this;
		}
		
		public function look(xc:int,yc:int):void{
			if(stage==null)
				return;
			
			this.x=-xc+stage.stageWidth/2;
			this.y=-yc+stage.stageHeight/2;
			
			if(_dishAss!=null){
				var vc:Rectangle=new Rectangle();
				vc.x=xc;
				vc.y=yc;
				vc.width=stage.stageWidth;
				vc.height=stage.stageHeight;				
				_dishAss.look(_dishAss.levelMax,vc);
			}
		}
		
		public function clear():void{
			if(_dishAss!=null)
				_dishAss.clear();
			_dishAss=null;
		}
		
		public function _updateTile(tile:TileDish):void{
			TileDish_PlateLoader[tile]=PlateLoader.load(tile,texReady,PlateLoader.Mosaic);			
		}
		
		private function texReady(texture:Texture,tile:TileDish):void{
//			for(var i:int=0;i<tile.shardList.length;i++){
//				var key:String=getKey(tile.fi,i);
//				var shard:Shard=tile.shardList[i];
//				
//				//sub texture
//				var region:Rectangle=new Rectangle();
//				region.x=(shard.x+_dishAss.bound*256)%256;
//				region.y=(shard.y+_dishAss.bound*256)%256;
//				region.width=shard.width;
//				region.height=shard.height;
//				
//				var subTexture:Texture=Texture.fromTexture(texture,region);
//				
//				var sl:ShardFilterLoader=Key_ShardLoader[key];
//				if(sl!=null)
//					throw new Error("LayerAss: tex already exist");
//				
//				Key_ShardLoader[key]=ShardFilterLoader.load(key,shard,subTexture,shardReady);
//			}
		}
		
		private function shardReady(image:Image,key:String):void{
			this.addChild(image);
		}
		
		private function getKey(fi:int,idx:int):String{
			return fi+"_"+idx;
		}
		
		public function _removeTile(tile:TileDish):void{
//			var loader:PlateLoader=TileDish_PlateLoader[tile];
//			delete TileDish_PlateLoader[tile];
//			if(loader.discard())
//				return;
//			
//			for(var i:int=0;i<tile.shardList.length;i++){
//				var key:String=getKey(tile.fi,i);
//				var sl:ShardFilterLoader=Key_ShardLoader[key];
//				delete Key_ShardLoader[key];
//				
//				if(!sl.discard())
//					removeChild(sl.image);
//				else if(sl.image!=null && this.contains(sl.image))
//					throw new Error("LayerAss: shard leak");
//			}
		}
	}
}
