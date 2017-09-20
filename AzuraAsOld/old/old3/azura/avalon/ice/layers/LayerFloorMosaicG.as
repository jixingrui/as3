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
	
	import azura.common.algorithm.FastMath;
	import old.azura.avalon.ice.GlobalState;
	import old.azura.avalon.ice.map.MapLoaderG;
	import old.azura.avalon.ice.map.MapLoaderMosaicG;
	
	import flash.utils.Dictionary;
	
	public class LayerFloorMosaicG extends GComponent implements LayerUserI
	{
		private var _dishMosaic:PyramidDish;
		private var TileDish_MapLoaderMosaicG:Dictionary=new Dictionary();
		private var layer_:Layer;
		
//		public function LayerFloorMosaicG(p_node:GNode)
//		{
////			super(p_node);
//		}
		
		public function _updateTile(tile:TileZimage):void{
			var mlm:MapLoaderMosaicG=new MapLoaderMosaicG(tile);
			TileDish_MapLoaderMosaicG[tile]=mlm;
			mlm.load(texReady);
		}
		
		private function texReady(pl:MapLoaderG):void{
			pl.hold();
			
			var sp:GSprite=pl.value as GSprite;
			var tile:TileZimage=pl.tile;
			
			sp.node.mouseEnabled=true;
			node.addChild(sp.node);
			
			sp.node.transform.x=tile.x*256;
			sp.node.transform.y=tile.y*256;
		}
		
		public function _removeTile(tile:TileZimage):void{
			var pl:MapLoaderG=TileDish_MapLoaderMosaicG[tile];
			delete TileDish_MapLoaderMosaicG[tile];

			if(pl.hasServed){
				node.removeChild(GSprite(pl.value).node);
			}
			pl.release(200000);
		}
		
		private var scale_:Number;
		public function get scale():Number{
			return scale_;
//			return FastMath.pow2(layer_.dish_.levelMax-level);
		}
		public function set layer(value:Layer):void{
			this.layer_=value;
			level_=Math.ceil(layer_.dish_.zMax/2);
			
			scale_=FastMath.pow2(layer_.dish_.zMax-level);
			
			node.transform.x=128*scale-128;
			node.transform.y=128*scale-128;
			node.transform.scaleX=scale;
			node.transform.scaleY=scale;
		}
		public function set x(value:Number):void{
//			node.transform.x=(value+visualWidth/2)*scale;
		}		
		public function set y(value:Number):void{
//			node.transform.y=(value+visualHeight/2)*scale;
		}
		private var level_:int;
		public function get level():int{
			return level_;
//			var 
//			var temp:Number= Math.ceil(layer_.dish_.levelMax/2);
//			return Math.max(layer_.dish_.levelMax-2,temp);
//			return temp;
		}
		public function get visualWidth():int{
			var factor:Number=Math.max(1,1/GenomeIceOld.instance.cameraGame.zoom);
			return GlobalState.stage.stageWidth/scale*factor;
		}
		public function get visualHeight():int{
			var factor:Number=Math.max(1,1/GenomeIceOld.instance.cameraGame.zoom);
			return GlobalState.stage.stageHeight/scale*factor;
		}
		public function clear():void{
			
		}
	}
}