package azura.banshee.zbox2.editor
{
	import azura.banshee.zbox2.zebra.ZebraC2;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.Neck;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	import flash.geom.Point;
	
	public class RotaterG3 implements GdragI
	{
		private var target:ZebraC2;
		public function RotaterG3(target:ZebraC2)
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
			target.zbox.angleLocal=angle;
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