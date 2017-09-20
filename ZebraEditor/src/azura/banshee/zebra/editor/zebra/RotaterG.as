package azura.banshee.zebra.editor.zebra
{
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.Neck;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	import flash.geom.Point;
	
	public class RotaterG implements GdragI
	{
		private var host:LayerZebra;
		public function RotaterG(host:LayerZebra)
		{
			this.host=host;
		}
		
		public function dragStart():Boolean
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
			var flat:Point=Neck.topToFlat(x,y);
			var angle:int=FastMath.xy2Angle(flat.x,flat.y);
			host.actor.angle=angle;
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