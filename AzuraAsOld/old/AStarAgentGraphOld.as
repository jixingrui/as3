package azura.banshee.zbase
{
	import azura.banshee.zbase.astar.AStarNode;
	import azura.common.algorithm.FastMath;

	public class AStarAgentGraphOld implements AStarAgentI
	{
		public var wn:WayNode;
		public var an:AStarNode;
		
		public function AStarAgentGraphOld(map:WayMap)
		{
//			super(map);
			wn=new WayNode(map);
		}
		
		public function get isWall():Boolean
		{
			return false;
		}
		
		public function lookDist(far:AStarAgentI):Number
		{
			var other:AStarAgentGraphOld=far as AStarAgentGraphOld;
			return FastMath.dist(wn.x,wn.y,other.wn.x,other.wn.y);
		}
		
		public function walkDist(neighbor:AStarAgentI):Number
		{
			var other:AStarAgentGraphOld=neighbor as AStarAgentGraphOld;
			return FastMath.dist(wn.x,wn.y,other.wn.x,other.wn.y);
		}
		
		public function neighborAstar():Vector.<AStarNode>
		{
//			return super.neighbors;
			return null;
		}
	}
}