package azura.banshee.naga.g2d.layers
{
	import azura.banshee.chessboard.land.PyramidLand;
	import azura.banshee.chessboard.land.TileLand;
	import azura.banshee.naga.g2d.GenomeChessboard;
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
	
	public class LayerPictureG2 extends GComponent implements LayerUserI
	{
		private var pyramid:PyramidLand;
		private var TileDish_MapLoaderClearG:Dictionary=new Dictionary();
		private var layer_:Layer;
		private var this_:LayerPictureG;
		
		private var dm:DragManager=new DragManager();
		
		private var boardPos:Point=new Point();
		
		public function LayerPictureG2(p_node:GNode)
		{
			super(p_node);
			this_=this;
			node.mouseEnabled=true;
			
			dm.onDragMove.add(onDragMove);
			function onDragMove(x:int,y:int):void{
				//				trace("drag move");
				
				var lx:int=boardPos.x-x+dm.startPoint.x;
				var ly:int=boardPos.y-y+dm.startPoint.y;
				layer_.look(lx,ly);
				
				node.transform.x=-layer_.dish_.bound*128-lx;
				node.transform.y=-layer_.dish_.bound*128-ly;
			}
			dm.onClose.add(onClose);
			function onClose():void{
				clear();
			}
		}
		
		private function onMouseDown(s:GNodeMouseSignal):void{
			//			trace("layer mouse down");
			
			var g:Point = s.dispatcher.transform.localToGlobal(new Point(s.localX,s.localY));
			
			dm.start(g.x,g.y);
			
			boardPos=new Point();
			
		}
		private function onMouseUp(s:GNodeMouseSignal):void{
			//			trace("layer mouse up");
			
			var g:Point= s.dispatcher.transform.localToGlobal(new Point(s.localX,s.localY));
			
			dm.end(g.x,g.y);
			
			//			boardPos.x-=g.x-dm.startPoint.x;
			//			boardPos.y-=g.y-dm.startPoint.y;
		}
		
		private function onMouseMove(s:GNodeMouseSignal):void{
			//			trace("layer mouse move");
			
			var g:Point= s.dispatcher.transform.localToGlobal(new Point(s.localX,s.localY));
			dm.move(g.x,g.y);
			
			//			var lx:int=boardPos.x-g.x+dm.startPoint.x;
			//			var ly:int=boardPos.y-g.y+dm.startPoint.y;
		}
		public function show(md5:String):void{
			if(DictionaryUtil.getLength(TileDish_MapLoaderClearG)>0)
				return;
			
			
			node.onMouseDown.add(onMouseDown);
			node.onMouseUp.add(onMouseUp);
			node.onMouseMove.add(onMouseMove);
			
			new Gal_Http2(md5).load(ready);
			function ready(gh:Gal_Http2):void{
				var zb:ZintBuffer=gh.value as ZintBuffer;
				zb.uncompress();
				pyramid=new PyramidLand();
				pyramid.decode(zb);
				
				layer_=new Layer(this_);
				layer_.dish=pyramid;
				layer_.look(0,0);
				GenomeChessboard.instance.walkEnabled=false;
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
			GenomeChessboard.instance.walkEnabled=true;
			
			boardPos=new Point();
			
			node.onMouseDown.remove(onMouseDown);
			node.onMouseUp.remove(onMouseUp);
			
			if(pyramid!=null)
				pyramid.clear();
			pyramid=null;
		}
	}
}