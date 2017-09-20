package azura.banshee.naga.g2d.layers
{
	import azura.banshee.chessboard.land.PyramidLand;
	import azura.banshee.chessboard.land.TileLand;
	import azura.banshee.naga.g2d.GenomeBooter;
	import azura.banshee.plain.Layer;
	import azura.banshee.plain.LayerUserI;
	import azura.gallerid.Gal_Http2;
	
	import com.genome2d.Genome2D;
	import com.genome2d.components.GComponent;
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.node.GNode;
	import com.genome2d.signals.GNodeMouseSignal;
	
	import common.algorithm.FastMath;
	import common.collections.DictionaryUtil;
	import common.collections.ZintBuffer;
	import common.loaders.GlobalState;
	import common.loaders.g2d.map.MapLoaderClearG;
	import common.loaders.g2d.map.MapLoaderG;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	public class LayerPictureG3 extends GComponent implements LayerUserI
	{
		private var pyramid:PyramidLand;
		private var TileDish_MapLoaderClearG:Dictionary=new Dictionary();
		private var layer_:Layer;
		private var this_:LayerPictureG;
		
		private var dragStart:Point=new Point();
		private var boardPos:Point=new Point();
		
		public function LayerPictureG3(p_node:GNode)
		{
			super(p_node);
			this_=this;
			node.mouseEnabled=true;
		}
		private function onMouseDown(s:GNodeMouseSignal):void{
			trace("layer mouse down");
			
			node.onMouseMove.add(onMouseMove);
			
			dragStart = s.dispatcher.transform.localToGlobal(new Point(s.localX,s.localY));
			
		}
		private function onMouseUp(s:GNodeMouseSignal):void{
			
			node.onMouseMove.remove(onMouseMove);
			
			var v:Point= s.dispatcher.transform.localToGlobal(new Point(s.localX,s.localY));
			
			var dist:int=FastMath.dist(dragStart.x,dragStart.y,v.x,v.y);
			if(dist<60)
			{
				this_.clear();
			}else{
				boardPos.x-=v.x-dragStart.x;
				boardPos.y-=v.y-dragStart.y;
			}
		}
		private function onMouseMove(s:GNodeMouseSignal):void{
			var v:Point= s.dispatcher.transform.localToGlobal(new Point(s.localX,s.localY));
			
			var lx:int=boardPos.x-v.x+dragStart.x;
			var ly:int=boardPos.y-v.y+dragStart.y;
			layer_.look(lx,ly);
			
			node.transform.x=-layer_.dish_.bound*128-lx;
			node.transform.y=-layer_.dish_.bound*128-ly;
		}
		public function show(md5:String):void{
			if(DictionaryUtil.getLength(TileDish_MapLoaderClearG)>0)
				return;
			
			
			node.onMouseDown.add(onMouseDown);
			node.onMouseUp.add(onMouseUp);
			
			new Gal_Http2(md5).load(ready);
			function ready(gh:Gal_Http2):void{
				var zb:ZintBuffer=gh.value as ZintBuffer;
				zb.uncompress();
				pyramid=new PyramidLand();
				pyramid.decode(zb);
				
				layer_=new Layer(this_);
				layer_.dish=pyramid;
				layer_.look(0,0);
				GenomeBooter.instance.walkEnabled=false;
			}	
		}
		
		public function _updateTile(tile:TileLand):void{
			
			var loader:MapLoaderClearG=new MapLoaderClearG(tile);
			TileDish_MapLoaderClearG[tile]=loader;
			loader.load(texReady);
			
			function texReady(pl:MapLoaderG):void{
				pl.hold();
				
				var sp:GSprite=pl.value as GSprite;
				var tile:TileLand=pl.tile;
				
				sp.node.mouseEnabled=true;
				node.addChild(sp.node);
				
				sp.node.transform.x=tile.x*256+128;
				sp.node.transform.y=tile.y*256+128;
			}
		}
		
		public function _removeTile(tile:TileLand):void{
			var pl:MapLoaderG=TileDish_MapLoaderClearG[tile];
			delete TileDish_MapLoaderClearG[tile];
			
			pl.release(20000);
			if(pl.hasServed){
				node.removeChild(GSprite(pl.value).node);
			}
		}
		
		public function set layer(value:Layer):void{
			this.layer_=value;
			
			node.transform.x=-layer_.dish_.bound*128;
			node.transform.y=-layer_.dish_.bound*128;
		}
		public function set x(value:Number):void{
			node.transform.x=value+visualWidth/2;
		}		
		public function set y(value:Number):void{
			node.transform.y=value+visualHeight/2;
		}
		public function get level():int{
			return layer_.dish_.levelMax;
		}
		public function get visualWidth():int{
			return GlobalState.stage.stageWidth;
		}
		public function get visualHeight():int{
			return GlobalState.stage.stageHeight;
		}
		public function clear():void{
			GenomeBooter.instance.walkEnabled=true;
			
			boardPos=new Point();
			
			node.onMouseDown.remove(onMouseDown);
			node.onMouseUp.remove(onMouseUp);
			
			if(pyramid!=null)
				pyramid.clear();
			pyramid=null;
		}
	}
}