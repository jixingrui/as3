package azura.touch.detector
{
	import azura.touch.TouchRawI;
	import azura.touch.gesture.GestureI;

	public class Gdetector implements TouchRawI
	{
		public var user:GestureI;
		
		public function Gdetector(user:GestureI)
		{
			this.user=user;
		}
		
		public function handDown(handId:int, x:Number, y:Number):void
		{
		}
		
		public function handUp(handId:int, x:Number, y:Number):void
		{
		}
		
		public function handMove(handId:int, x:Number, y:Number):void
		{
		}
		
		public function handOut(handId:int):void
		{
		}
	}
}