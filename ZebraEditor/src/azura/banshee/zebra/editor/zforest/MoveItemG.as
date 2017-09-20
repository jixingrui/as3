package azura.banshee.zebra.editor.zforest
{
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	import flash.geom.Point;
	
	public class MoveItemG implements GdragI
	{
		private var downRoot:Point;		
		private var host:LayerZforestEditor;
		public function MoveItemG(host:LayerZforestEditor)
		{
			this.host=host;
		}
		
		public function dragStart():Boolean
		{
			downRoot=new Point(host.root.xView,host.root.yView);
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			var ddx:Number=x/host.root.scaleLocal;
			var ddy:Number=y/host.root.scaleLocal;			
			
			host.moveZtree(downRoot.x+ddx,downRoot.y+ddy);
			return false;
		}
		
		public function dragEnd():Boolean
		{
			host.mouseMode=LayerZforestEditor.MouseDragScreen;
			return false;
		}
		
		public function get touchBox():TouchBox
		{
			return null;
		}
		
		public function set touchBox(box:TouchBox):void
		{
		}
	}
}