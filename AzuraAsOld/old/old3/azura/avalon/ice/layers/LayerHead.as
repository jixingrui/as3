package old.azura.avalon.ice.layers
{
	import azura.banshee.zebra.zimage.large.TileZimage;
	import old.azura.avalon.ice.plain.Layer;
	import old.azura.avalon.ice.plain.LayerUserI;
	
	import com.genome2d.components.GComponent;
	import com.genome2d.node.GNode;
	
	public class LayerHead extends GComponent implements LayerUserI
	{
//		public function LayerHead(p_node:GNode=null)
//		{
////			super(p_node);
//		}
		
		public function set layer(value:Layer):void
		{
			node.transform.x=value.dish_.bound*128-128;
			node.transform.y=value.dish_.bound*128-128;
		}
		
		public function set x(value:Number):void
		{
		}
		
		public function set y(value:Number):void
		{
		}
		
		public function get visualWidth():int
		{
			return 0;
		}
		
		public function get visualHeight():int
		{
			return 0;
		}
		
		public function get level():int
		{
			return 0;
		}
		
		public function clear():void
		{
			node.disposeChildren();
		}
		
		public function _updateTile(tile:TileZimage):void
		{
		}
		
		public function _removeTile(tile:TileZimage):void
		{
		}
	}
}