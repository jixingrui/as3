package azura.common.algorithm.pathfinding.astar3
{
	import flash.geom.Point;
	
	public class AStarNode3
	{
		public var
		root : AStar3,
		estimatedHereEndCost : uint,
		estimatedStartHereEndCost : uint,
		storedStartHereCost : uint,
		visited : Boolean,
		closed : Boolean,
		parent : AStarNode3,
		next : AStarNode3,
		host:AStarI3;
		
		public function AStarNode3(root:AStar3,host:AStarI3){
			this.root=root;
			this.host=host;
			host.node=this;
		}
		
		public function get score():uint{
			return estimatedStartHereEndCost;
		}
	}
}