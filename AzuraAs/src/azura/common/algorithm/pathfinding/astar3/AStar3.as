package azura.common.algorithm.pathfinding.astar3
{
	import flash.geom.Point;
	
	
	public class AStar3
	{
		private var 
		_openHeap : BinaryHeap=new BinaryHeap(),
			currentNode : AStarNode3,
			ret : Vector.<AStarI3>,
			i : uint, j : uint;
		
		public static function search(start : AStarI3, end:AStarI3 ) : Vector.<AStarI3> {
			var run:AStar3= new AStar3();
			return run.search_(new AStarNode3(run,start),new AStarNode3(run,end));
		}
		
		private function search_( start : AStarNode3, end:AStarNode3 ) : Vector.<AStarI3> {
			
			_openHeap.push(start);
			
			while( _openHeap.size > 0 ){
				currentNode = _openHeap.pop();
				
				if (currentNode == end) {
					i = 0;
					while (currentNode.parent) {
						currentNode.parent.next = currentNode;
						i++;
						currentNode = currentNode.parent;
					}
					ret = new Vector.<AStarI3>(i+1, true);
					for (j = 0; currentNode; j++) {
						ret[j] = currentNode.host;
						currentNode = currentNode.next;
					}
					return ret;
				}
				
				currentNode.closed = true;
				
				for each(var n:AStarI3 in currentNode.host.stepChoices())	{
					
					var neighbor:AStarNode3=n.node;
					if(neighbor==null || neighbor.root!=this)
						neighbor=new AStarNode3(this,n);
					
					if (neighbor.closed)
						continue;
					
					var probeStartHereCost:Number = currentNode.storedStartHereCost + currentNode.host.stepCostNear(neighbor.host);
					
					if ( !neighbor.visited ) {
						
						neighbor.visited = true;
						neighbor.parent = currentNode;
						neighbor.storedStartHereCost = probeStartHereCost;
						neighbor.estimatedHereEndCost = neighbor.host.estimateCostFar(end.host);
						neighbor.estimatedStartHereEndCost = probeStartHereCost + neighbor.estimatedHereEndCost;
						
						_openHeap.push(neighbor);						
					} else if ( probeStartHereCost < neighbor.storedStartHereCost) {
						
						neighbor.parent = currentNode;
						neighbor.storedStartHereCost = probeStartHereCost;
						neighbor.estimatedStartHereEndCost = probeStartHereCost + neighbor.estimatedHereEndCost;
						
						_openHeap.rescoreElement(neighbor);
					}
					
				}
			}
			
			return null;
		}
	}
}