package old.azura.avalon.ice.layers
{
	import old.azura.avalon.ice.GlobalState;
	import old.azura.avalon.ice.dish.Shard;
	import old.azura.avalon.ice.dish.TileDish;
	import azura.banshee.zebra.zimage.large.TileZimage;
	import old.azura.avalon.ice.plain.Layer;
	import old.azura.avalon.ice.plain.LayerUserI;
	import azura.avalon.ice.loaders.CookieLoader;
	import azura.banshee.loaders.g2d.ShardLoaderG;
	import old.azura.banshee.naga.Frame;
	
	import com.genome2d.components.GComponent;
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.node.GNode;
	
	import flash.utils.Dictionary;
	
	public class LayerAssG extends GComponent implements LayerUserI
	{
		private var layer_:Layer;
		private var Key_ShardLoader:Dictionary=new Dictionary();
		public var TileDish_CookieLoader:Dictionary=new Dictionary();
		
		public function LayerAssG()
		{
//			super(p_node);
		}
		
//		public function showNum():void{
//			trace(node.numChildren);
//		}
		
		public function _updateTile(tile:TileZimage):void{
			var loader:CookieLoader=new CookieLoader(tile as TileDish);
			TileDish_CookieLoader[tile]=loader;
			loader.load(cookieReady);
			function cookieReady(cl:CookieLoader):void{
				cl.hold();
				for(var i:int=0;i<cl.shardList.length;i++){
//					var key:String=tile.getKey()+i;//getKey(tile.fi,i);
					var key:String='';
					var shard:Shard=cl.shardList[i];
					var frame:Frame=cl.atlas.getFrame(i);
					
					var sl:ShardLoaderG=new ShardLoaderG(key,shard,frame);
					Key_ShardLoader[key]=sl;
					sl.load(shardReady);
				}
				function shardReady(sl:ShardLoaderG):void{
					sl.hold();
					node.addChild(GSprite(sl.value).node);
					GlobalState.requestSort(true);
				}
			}
		}
		
		public function _removeTile(tile:TileZimage):void{
			
			var cl:CookieLoader=TileDish_CookieLoader[tile];
			delete TileDish_CookieLoader[tile];			
			
			cl.release(30000);
			if(cl.hasServed){
				for(var i:int=0;i<cl.shardList.length;i++){
//					var key:String=tile.getKey()+i;//getKey(tile.fi,i);
					var key:String='';
					var sl:ShardLoaderG=Key_ShardLoader[key];
					delete Key_ShardLoader[key];
					
					sl.release(20000);
					if(sl.hasServed){
						node.removeChild(GSprite(sl.value).node);
					}
				}
			}
		}
		public function set layer(value:Layer):void{
			this.layer_=value;
			node.transform.x=value.dish_.bound*128-128;
			node.transform.y=value.dish_.bound*128-128;
		}
		public function set x(value:Number):void{
//			node.transform.x=value+visualWidth/2+layer_.dish_.bound*256/2;
		}		
		public function set y(value:Number):void{
//			node.transform.y=value+visualHeight/2+layer_.dish_.bound*256/2;
		}
		public function get level():int{
			return layer_.dish_.zMax;
		}
		public function get scale():Number{
			return 1;			
		}
		public function get visualWidth():int{
			return GlobalState.stage.stageWidth;
		}
		public function get visualHeight():int{
			return GlobalState.stage.stageHeight;
		}
		public function clear():void{
			GlobalState.swamp.clear();
			node.disposeChildren();			
		}
		
	}
}
