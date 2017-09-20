package azura.common.algorithm.pathfinding.astar3
{
	import flash.geom.Point;

	public interface AStarI3
	{
		function set node(n:AStarNode3):void;
		
		function get node():AStarNode3;
				
		function get point():Point;
		
		function stepChoices() : Vector.<AStarI3>;
		
		function estimateCostFar(far:AStarI3):Number;
		
		function stepCostNear(neighbor:AStarI3):Number;
		
	}
}