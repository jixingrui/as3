package azura.banshee.starling.layers
{
	import azura.banshee.chessboard.dish.DishUserI;
	import azura.banshee.chessboard.dish.PyramidDish;
	import azura.banshee.chessboard.dish.Shard;
	import azura.banshee.chessboard.dish.TileDish;
	import azura.banshee.chessboard.loaders.CookieLoader;
	import common.loaders.ShardLoaderStarling;
	import azura.banshee.naga.starling.Foot;
	import azura.banshee.naga.starling.ImageStarling;
	import azura.banshee.naga.Atlas;
	import azura.banshee.naga.Frame;
	
	import cblib.Static;
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import starling.display.Sprite;
	
	public class LayerAss extends Sprite implements DishUserI
	{
		private var _dishAss:PyramidDish;
		private var Key_ShardLoader:Dictionary=new Dictionary();
		public var TileDish_CookieLoader:Dictionary=new Dictionary();
		
		public function LayerAss(){
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
			
			removeChildren();
		}
		
		public function _updateTile(tile:TileDish):void{
			TileDish_CookieLoader[tile]=CookieLoader.load(tile,cookieReady);
			
			function cookieReady(cl:CookieLoader):void{
				for(var i:int=0;i<cl.shardList.length;i++){
					var key:String=tile.getKey()+i;//getKey(tile.fi,i);
					var shard:Shard=cl.shardList[i];
					var frame:Frame=cl.atlas.getFrame(i);
					
					Key_ShardLoader[key]=ShardLoaderStarling.load(key,shard,frame,shardReady);
				}
				function shardReady(sl:ShardLoaderStarling):void{
					addChild(sl.value as ImageStarling);
					sortChildren(Foot.compare);//todo: half sort
					//					trace("LayerAss: "+sl.key);
				}
			}
		}
		
		public function _removeTile(tile:TileDish):void{	
			var cl:CookieLoader=TileDish_CookieLoader[tile];
			delete TileDish_CookieLoader[tile];			
			
			cl.cancel();
			if(cl.hasServed){
				for(var i:int=0;i<cl.shardList.length;i++){
					var key:String=tile.getKey()+i;//getKey(tile.fi,i);
					var sl:ShardLoaderStarling=Key_ShardLoader[key];
					delete Key_ShardLoader[key];
					
					sl.cancel();
					if(sl.hasServed){
						removeChild(sl.value as ImageStarling);
						//					trace("LayerAss: "+sl.key+" removed");
					}
				}
			}
		}
		
	}
}
