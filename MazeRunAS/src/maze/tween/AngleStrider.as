package maze.tween
{
	import azura.common.algorithm.FastMath;
	
	import flash.geom.Point;

	public class AngleStrider
	{
		private var _angle:int;
		private var stepLength:int;
		private var oneStep:Point;
				
		public function AngleStrider(angle:int,stepLength:int):void{
			this._angle=angle;
			this.stepLength=stepLength;
			oneStep=FastMath.angle2Xy(angle,stepLength);
//			trace("one step",oneStep.x,oneStep.y,this);
//			oneStep=FastMath.normalToIso(oneStep.x,oneStep.y);
//			var dist:Number=FastMath.dist(0,0,oneStep.x,oneStep.y);
//			trace("angle walk dist=",dist,this);
		}
		
		public function get angle():int
		{
			return _angle;
		}

		public function next():Point{
			return oneStep;
		}
	}
}