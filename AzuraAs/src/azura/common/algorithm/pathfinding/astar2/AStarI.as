package azura.common.algorithm.pathfinding.astar2
{

	public interface AStarI
	{
		function get node():AStarNode;
		
		function get isWall():Boolean;
		
		function estimateCost(far:AStarI):Number;
		
		function stepCost(neighbor:AStarI):Number;
		
		function stepChoices() : Vector.<AStarI>;
	}
}