package old.azura.avalon.ice.layers
{
	import old.azura.avalon.ice.GlobalState;
	import old.azura.avalon.ice.GenomeIceOld;
	import old.azura.avalon.ice.map.MapLoaderClearG;
	import old.azura.avalon.ice.map.MapLoaderG;
	import azura.banshee.zebra.zimage.large.PyramidZimage;
	import azura.banshee.zebra.zimage.large.TileZimage;
	import old.azura.avalon.ice.plain.Layer;
	import old.azura.avalon.ice.plain.LayerUserI;
	import azura.common.algorithm.FastMath;
	import azura.common.collections.DictionaryUtil;
	import azura.common.collections.ZintBuffer;
	import azura.common.ui.Toast;
	import azura.gallerid.Gal_Http2Old;
	
	import com.genome2d.Genome2D;
	import com.genome2d.components.GComponent;
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.node.GNode;
	import com.genome2d.signals.GNodeMouseSignal;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	public class LayerPictureG extends GComponent implements LayerUserI
	{
		private var pyramid:PyramidZimage;
		private var TileDish_MapLoaderClearG:Dictionary=new Dictionary();
		private var layer_:Layer;
		private var this_:LayerPictureG;
		
		private var dm:DragManagerOld=new DragManagerOld();
		
		//		private var boardPos:Point=new Point();
		
		public function LayerPictureG()
		{
//			super(p_node);
			this_=this;
			node.mouseEnabled=true;
			
			dm.onDragMove.add(onDragMove);
			function onDragMove(x:int,y:int):void{
				//				trace("drag move");
				
				//				var lx:int=dm.historyPoint.x-x+dm.startPoint.x;
				//				var ly:int=dm.historyPoint.y-y+dm.startPoint.y;
				
				//				x=Math.min(x,layer_.dish_.bound*128);
				//				y=Math.min(y,layer_.dish_.bound*128);
				
				//				var p:Point=limit(x,y);
				
//				trace("drag move: "+x+","+y);
				
				//				if(Math.abs(x)>100||Math.abs(y)>100)
				//					return;
				
				layer_.look(-x,-y);
				
				node.transform.x=-layer_.dish_.bound*128+x;
				node.transform.y=-layer_.dish_.bound*128+y;
			}
			dm.onClose.add(onClose);
			function onClose():void{
				clear();
			}
		}
		
		private function onMouseDown(s:GNodeMouseSignal):void{
			//			trace("layer mouse down");
			
			var g:Point = s.dispatcher.transform.localToGlobal(new Point(s.localX,s.localY));
			//			g=limit(g);
			dm.start(g.x,g.y);
			GenomeIceOld.instance.walkEnabled=false;
			
		}
		private function onMouseUp(s:GNodeMouseSignal):void{
			//			trace("layer mouse up");
			
			var g:Point= s.dispatcher.transform.localToGlobal(new Point(s.localX,s.localY));
			//			g=limit(g);
			dm.end(g.x,g.y);
			GenomeIceOld.instance.walkEnabled=true;
		}
		
		private function onMouseMove(s:GNodeMouseSignal):void{
			//			trace("layer mouse move");
			
			var g:Point= s.dispatcher.transform.localToGlobal(new Point(s.localX,s.localY));
			//			g=limit(g);
			dm.move(g.x,g.y);
		}
		
		
		public function show(md5:String):void{
			if(DictionaryUtil.getLength(TileDish_MapLoaderClearG)>0)
				return;

			Toast.show("双击关闭");
			
			node.onMouseDown.add(onMouseDown);
			node.onMouseUp.add(onMouseUp);
			node.onMouseMove.add(onMouseMove);
			
			new Gal_Http2Old(md5).load(ready);
			function ready(gh:Gal_Http2Old):void{
				var zb:ZintBuffer=gh.value as ZintBuffer;
				zb.uncompress();
//				pyramid=new PyramidLand();
//				pyramid.decode(zb);
				
				layer_=new Layer(this_);
				layer_.dish=pyramid;
				layer_.look(0,0);
				GenomeIceOld.instance.walkEnabled=false;
				
				dm.limit(layer_.dish_.bound*128,layer_.dish_.bound*128);
			}	
		}
		
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
				
				sp.node.transform.x=tile.x*256+128;
				sp.node.transform.y=tile.y*256+128;
			}
		}
		
		public function _removeTile(tile:TileZimage):void{
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
			return layer_.dish_.zMax;
		}
		public function get visualWidth():int{
			return GlobalState.stage.stageWidth;
		}
		public function get visualHeight():int{
			return GlobalState.stage.stageHeight;
		}
		public function clear():void{
			GenomeIceOld.instance.walkEnabled=true;
			
			//			boardPos=new Point();
			dm.clear();
			
			node.onMouseDown.remove(onMouseDown);
			node.onMouseUp.remove(onMouseUp);
			
			if(pyramid!=null)
				pyramid.clear();
			pyramid=null;
		}
	}
}