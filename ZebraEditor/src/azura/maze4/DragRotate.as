package azura.maze4
{
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.common.algorithm.FastMath;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	public class DragRotate implements GdragI
	{
		public var canvas:Maze4Canvas;
		private var target:ZebraC3;
		public function DragRotate(target:ZebraC3)
		{
			this.target=target;
		}
		
		public function dragStart(x:Number,y:Number):Boolean
		{
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			rotate(x,y);
			return false;
		}
		
		private function rotate(x:Number,y:Number):void{
			var angle:Number=FastMath.xy2Angle(x,y);
			target.zbox.angle=angle;
		}
		
		public function dragEnd():Boolean
		{
			Maze4EditorPanel.me.rotateEnd();
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