package azura.banshee.zebra.editor.zforest
{
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	import flash.geom.Point;
	
	public class MoveItemG3 implements GdragI
	{
		private var downRoot:Point;		
		private var host:ZforestEditor3Canvas;
		public function MoveItemG3(host:ZforestEditor3Canvas)
		{
			this.host=host;
		}
		
		public function dragStart(x:Number,y:Number):Boolean
		{
			downRoot=new Point(host.ec.space.xView,host.ec.space.yView);
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			var ddx:Number=x/host.ec.space.scaleView;
			var ddy:Number=y/host.ec.space.scaleView;			
			
			host.moveZtree(downRoot.x+ddx,downRoot.y+ddy);
			return false;
		}
		
		public function dragEnd():Boolean
		{
//			host.mouseMode=LayerZforestEditor.MouseDragScreen;
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