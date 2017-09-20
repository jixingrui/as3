package azura.banshee.zbox3.editor
{
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.common.algorithm.FastMath;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	public class RotaterG5 implements GdragI
	{
		private var target:ZebraC3;
		public function RotaterG5(target:ZebraC3)
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