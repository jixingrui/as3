package azura.common.algorithm.pathfinding
{
	import azura.common.algorithm.FastMath;

	public class ZigRuler
	{
		private var _dist:int=0;
		private var _x:int,_y:int;
		public function ZigRuler(x:int,y:int)
		{
			this._x=x;
			this._y=y;
		}
		
		public function add(x:int,y:int):void{
			_dist+=FastMath.dist(this._x,this._y,x,y);
			_x=x;
			_y=y;
		}
		
		public function get dist():int{
			return _dist;
		}
	}
}