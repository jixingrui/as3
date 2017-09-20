package azura.touch.detector
{
	import azura.touch.TouchRawI;
	import azura.touch.gesture.GrotateI;
	
	public class GDrotate implements TouchRawI
	{
		public var target:GrotateI;
		
		public function GDrotate(target:GrotateI)
		{
			this.target=target;
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