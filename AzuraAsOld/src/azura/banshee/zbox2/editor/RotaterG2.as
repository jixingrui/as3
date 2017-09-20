package azura.banshee.zbox2.editor
{
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.Neck;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	import flash.geom.Point;
	
	public class RotaterG2 implements GdragI
	{
		private var host:LayerZebra2;
		public function RotaterG2(host:LayerZebra2)
		{
			this.host=host;
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
		
		public function dragEnd():Boolean
		{
			return false;
		}
		
		private function rotate(x:Number,y:Number):void{
//			var flat:Point=Neck.topToFlat(x,y);
			var angle:Number=FastMath.xy2Angle(x,y);
			
//			trace("angle=",angle,this);
			host.actor.zbox.angleLocal=angle;
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