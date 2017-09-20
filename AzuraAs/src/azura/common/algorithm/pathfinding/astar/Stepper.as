package azura.common.algorithm.pathfinding.astar
{
	import flash.geom.Point;

	public class Stepper
	{
		[Bindable]
		public var current:Point=new Point();
		private var delta:Point=new Point();

		private var step:int;

		public function clear():void
		{
			step=0;
			this.current.x=0;
			this.current.y=0;
		}

		public function reset(stepV:int, driftX:int, driftY:int):void
		{
			if (stepV > 0)
			{
				this.current.x=0;
				this.current.y=0;

				this.step=stepV;

				delta.x=driftX / step;
				delta.y=driftY / step;
			}
		}

		public function running():Boolean
		{
			return step > 0;
		}

		public function nextAndFinished():Boolean
		{
			step--;
			if (step <= 0)
			{
				current.x=0;
				current.y=0;
				return true;
			}
			else
			{
				current.x+=delta.x;
				current.y+=delta.y;
				return false;
			}
		}

		public function toString():String
		{
			return current.x + ' ' + current.y;
		}
	}
}