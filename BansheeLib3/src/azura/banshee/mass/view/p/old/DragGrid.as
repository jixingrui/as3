package azura.banshee.mass.view.p.old
{
	import azura.common.ui.grid.GridMotor2;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	public class DragGrid implements GdragI
	{
		public var motor:GridMotor2;
		
		public function DragGrid()
		{
		}
		
		public function dragStart(x:Number,y:Number):Boolean
		{
			motor.dragStart();
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
//			trace("drag grid",dx,dy,this);
			motor.dragMove(dx,dy);
			return false;
		}
		
		public function dragEnd():Boolean
		{
			motor.dragEnd();
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