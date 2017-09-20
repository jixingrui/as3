package azura.common.algorithm.pathfinding.astar3
{
	import flash.geom.Point;

	public class AStarGrid3
	{
		
		//static function
		private static function getGridNeighbors( grid : Vector.<Vector.<AStarNode3>> , node : AStarNode3) : Vector.<AStarNode3> {
			var ret : Vector.<AStarNode3> = new Vector.<AStarNode3>(8, true),
				x : uint = node.host.point.x,
				y : uint = node.host.point.y,
				gridWidth : uint = grid.length,
				gridHeight : uint = grid[x].length,
				id : uint;
			
			if (x > 0) {
				ret[id++] = grid[x - 1][y];
				if (y > 0)
					ret[id++] = grid[x - 1][y - 1];
				if (y < gridHeight - 1)
					ret[id++] = grid[x - 1][y + 1];
			}
			if (x < gridWidth - 1) {
				ret[id++] = grid[x + 1][y];
				if (y > 0)
					ret[id++] = grid[x + 1][y - 1];
				if (y < gridHeight - 1)
					ret[id++] = grid[x + 1][y + 1];
			}
			if (y > 0)
				ret[id++] = grid[x][y - 1];
			if (y < gridHeight - 1)
				ret[id++] = grid[x][y + 1];
			
			return ret;
		}
		
		private static function heuristic( pos0 : Point, pos1 : Point ) : uint{
			var d1 : int = pos1.x - pos0.x,
				d2 : int = pos1.y - pos0.y;
			d1 = d1 < 0 ? -d1 : d1;
			d2 = d2 < 0 ? -d2 : d2;
			//var diag:int = Math.SQRT2 * diag + d1 + d2 - 2 * diag;
			//var diag:int = d1 > d2 ? d1 : d2;
			var diag:int = d1 + d2; // using of this heuristic might result with incorect results, see https://github.com/shdpl/AS3-AStar/pull/1
			return diag;
		}
	}
}