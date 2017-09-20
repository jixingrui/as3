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
	import old.azura.avalon.ice.map.MapLoaderClearG;
	import old.azura.avalon.ice.map.MapLoaderG;
	
	import flash.utils.Dictionary;
	
	public class LayerFloorClearG extends GComponent implements LayerUserI
	{
		private var _dishClear:PyramidDish;
		private var TileDish_MapLoaderClearG:Dictionary=new Dictionary();
		private var layer_:Layer;
		
//		public function LayerFloorClearG(p_node:GNode)
//		{
////			super(p_node);
//		}
		
		public function _updateTile(tile:TileZimage):void{
			
			var loader:MapLoaderClearG=new MapLoaderClearG(tile);
			TileDish_MapLoaderClearG[tile]=loader;
			loader.load(texReady);
					
			function texReady(pl:MapLoaderG):void{
				pl.hold();
				
				var sp:GSprite=pl.value as GSprite;
				var tile:TileZimage=pl.tile;
				
				sp.node.mouseEnabled=true;
				node.addChild(sp.node);
				
				sp.node.transform.x=tile.x*256;
				sp.node.transform.y=tile.y*256;
			}
		}
		
		public function _removeTile(tile:TileZimage):void{
			var pl:MapLoaderG=TileDish_MapLoaderClearG[tile];
			delete TileDish_MapLoaderClearG[tile];
			
			pl.release(200000);
			if(pl.hasServed){
				node.removeChild(GSprite(pl.value).node);
			}
		}
		
		public function set layer(value:Layer):void{
			this.layer_=value;
		}
		public function set x(value:Number):void{
//			node.transform.x=value+visualWidth/2;
		}		
		public function set y(value:Number):void{
//			node.transform.y=value+visualHeight/2;
		}
		public function get level():int{
			return layer_.dish_.zMax;
		}
		public function get visualWidth():int{
			var factor:Number=Math.max(1,1/GenomeIceOld.instance.cameraGame.zoom);
			factor=Math.min(1.5,factor);
			return GlobalState.stage.stageWidth*factor;
		}
		public function get visualHeight():int{
			var factor:Number=Math.max(1,1/GenomeIceOld.instance.cameraGame.zoom);
			factor=Math.min(1.5,factor);
			return GlobalState.stage.stageHeight*factor;
		}
		public function clear():void{
			
		}
	}
}