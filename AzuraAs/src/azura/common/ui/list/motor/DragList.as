package azura.common.ui.list.motor
{
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	public class DragList implements GdragI
	{
		public var H_V:Boolean;
		public var motor:ListMotor2;
		
		public function DragList()
		{
		}
		
		public function dragStart(x:Number,y:Number):Boolean
		{
			motor.dragStart();
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
//			motor.dragMove(0);
//			return false;
			
			if(H_V){
				motor.dragMove(dx/2);
			}else{
				motor.dragMove(dy/2);
			}
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