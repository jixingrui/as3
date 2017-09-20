package azura.banshee.mass.view.e
{
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	public class DragGreenBox2 implements GdragI
	{
		public var nve:MassTreeNVE2;
		private var startX:Number;
		private var startY:Number;
		
		public function dragStart(x:Number,y:Number):Boolean
		{
			startX=nve.zbox.x;
			startY=nve.zbox.y;
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			var toX:Number=startX;
			var toY:Number=startY;
			if(nve.model.box.x.int_percent==true)
				toX+=dx;
			if(nve.model.box.y.int_percent==true)
				toY+=dy;
			nve.zbox.move(toX,toY);
			MassTreeVE2(nve.tree).updatePos(nve);
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