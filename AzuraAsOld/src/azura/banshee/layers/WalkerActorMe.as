package azura.banshee.layers
{
	import azura.common.algorithm.mover.MotorI;

	public class WalkerActorMe extends WalkerActor
	{
		private var screen:MotorI;
		public function WalkerActorMe(screen:MotorI)
		{
			this.screen=screen;
		}
		
		override public function jumpTo(x:Number, y:Number):void
		{
			screen.jumpTo(x,y);
			super.jumpTo(x,y);
		}
		
		override public function turnTo(angle:int):int
		{
			screen.turnTo(angle);			
			return super.turnTo(angle);;
		}
		
	}
}