package azura.maze4
{
	import azura.banshee.zbox3.Zspace3;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	public class DragLook implements GdragI
	{
		public var space:Zspace3;
		private var startX:Number;
		private var startY:Number;
		
		public function DragLook(space:Zspace3){
			this.space=space;
		}
		
		public function dragStart(x:Number,y:Number):Boolean
		{
			startX=space.xView;
			startY=space.yView;
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			space.look(startX-dx/space.scaleView,startY-dy/space.scaleView);
			return false;
		}
		
		public function dragEnd():Boolean
		{
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