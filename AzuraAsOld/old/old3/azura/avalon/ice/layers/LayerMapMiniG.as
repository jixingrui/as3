package old.azura.avalon.ice.layers
{
	import old.azura.avalon.ice.dish.PyramidDish;
	import azura.banshee.zebra.zimage.large.TileZimage;
	import old.azura.avalon.ice.GenomeIceOld;
	import old.azura.avalon.ice.plain.Layer;
	import old.azura.avalon.ice.plain.LayerUserI;
	
	import com.genome2d.components.GComponent;
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.node.GNode;
	
	import old.azura.avalon.ice.GlobalState;
	import old.azura.avalon.ice.map.MapLoaderG;
	import old.azura.avalon.ice.map.MapLoaderMiniG;
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	public class LayerMapMiniG extends GComponent implements LayerUserI
	{
		internal static var borderX:int=10;
		internal static var borderY:int=10;
		internal var mapWidth:int=180;
		internal var mapHeight:int=150;
		
		private var _dishClear:PyramidDish;
		private var TileDish_MapLoaderMiniG:Dictionary=new Dictionary();
		private var layer_:Layer;
		
		public function LayerMapMiniG()
		{
//			super(p_node);
			checkMask();
		}
		
		public function _updateTile(tile:TileZimage):void{
			
			var loader:MapLoaderMiniG=new MapLoaderMiniG(tile);
			TileDish_MapLoaderMiniG[tile]=loader;
			loader.load(texReady);
			
			function texReady(pl:MapLoaderG):void{
				pl.hold();
				
				var sp:GSprite=pl.value as GSprite;
				var tile:TileZimage=pl.tile;
				
//				sp.node.mouseEnabled=true;
				node.addChild(sp.node);
				
				sp.node.transform.x=tile.x*256;
				sp.node.transform.y=tile.y*256;
			}
		}
		
		public function _removeTile(tile:TileZimage):void{
			var pl:MapLoaderG=TileDish_MapLoaderMiniG[tile];
			delete TileDish_MapLoaderMiniG[tile];
			
			pl.release(200000);
			if(pl.hasServed){
				node.removeChild(GSprite(pl.value).node);
			}
		}
		
		public function set layer(value:Layer):void{
			this.layer_=value;
		}
		public function set x(value:Number):void{
//			node.transform.x=value+mapWidth/2+borderX;
			node.transform.x=value+borderX+mapWidth/2-GlobalState.stage.stageWidth/2/GenomeIceOld.instance.cameraGame.zoom;
		}		
		public function set y(value:Number):void{
//			node.transform.y=value-mapHeight/2-borderY+GlobalState.stage.stageHeight;
			node.transform.y=value-borderY-mapHeight/2+GlobalState.stage.stageHeight/2/GenomeIceOld.instance.cameraGame.zoom;
		}
		private function checkMask():void{
			return;
			
			var rect:Rectangle=new Rectangle();
			rect.x=+borderX;
			rect.y=+GlobalState.stage.stageHeight-mapHeight-borderY;
			rect.width=mapWidth;
			rect.height=mapHeight;
						
			node.maskRect=rect;
		}
		public function get visualWidth():int{
			return mapWidth;
		}
		public function get visualHeight():int{
			return mapHeight;
		}		
		public function get level():int{
			var sqrt:int= Math.floor(layer_.dish_.zMax/2);
			var minus:int=layer_.dish_.zMax-4;
			var result:int=Math.min(sqrt,minus);
			result=Math.max(0,result);
			return result;
		}
		public function clear():void{
			
		}
	}
}