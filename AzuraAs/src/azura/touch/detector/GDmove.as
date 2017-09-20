package azura.touch.detector
{
	import azura.touch.gesture.GestureI;
	import azura.touch.gesture.GmoveI;
	
	public class GDmove extends Gdetector
	{
		public function GDmove(user:GmoveI)
		{
			super(user);
		}
		
		public function get target():GmoveI{
			return user as GmoveI;
		}
		
		override public function handMove(touchId:int, x:Number, y:Number):void
		{
			target.handMove(x,y);
		}
	}
}