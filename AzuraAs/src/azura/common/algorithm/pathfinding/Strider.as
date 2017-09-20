package azura.common.algorithm.pathfinding
{
	import azura.common.algorithm.pathfinding.astar.AstarMapI;
	
	public class Strider implements AstarMapI
	{
		private var map:AstarMapI;
		private var stride:int;
		
		public function Strider(map:AstarMapI,stride:int)
		{
			this.map=map;
			this.stride=stride;
		}
		
		public function get width():int
		{
			return map.width/stride;
		}
		
		public function get height():int
		{
			return map.height/stride;
		}
		
		public function isRoad(x:int, y:int, accurate:Boolean=false):Boolean
		{
			return map.isRoad(x*stride,y*stride);
		}
		
		public function setRoad(x:int, y:int, isRoad:Boolean):void
		{
		}
		
	}
}