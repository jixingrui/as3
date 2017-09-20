package azura.common.algorithm.pathfinding.astar2
{
	import azura.avalon.zbase.zway.WayDot45;
	import azura.common.collections.Heap;
	
	import flash.geom.Point;
	
	public class AStar
	{
		
		private var openHeap : Heap=new Heap();
		private var closedList : Vector.<AStarNode>=new Vector.<AStarNode>();
		
		public static function search(start:AStarI,end:AStarI):Vector.<AStarI>{
			if(start.node==null||end.node==null)
				throw new Error();
			
			var astar:AStar=new AStar();
			return astar.search_(start.node,end.node);
		}
		
		/**
		 * 
		 * @return a path without start or end. null if not found
		 * 
		 */
		private function search_(  start : AStarNode, end:AStarNode) : Vector.<AStarI> {
			
			openHeap.push(start);
			
			while( openHeap.size > 0 ){
				// Grab the lowest f(x) to process next.  Heap keeps this sorted for us.
				var currentNode : AStarNode = openHeap.pop() as AStarNode;
				
				// End case -- result has been found, return the traced path				
				if(currentNode == end) {
					var curr : AStarNode = currentNode;
					var ret : Vector.<AStarI> = new Vector.<AStarI>();
					while(curr.parent) {
						ret.push(curr.host);
						curr = curr.parent;
					}
					ret.shift();
					ret = ret.reverse();
					cleanUp();
					return ret;
				}
				
				// Normal case -- move currentNode from open to closed, process each of its neighbors
				currentNode.closed = true;
				closedList.push(currentNode);
				
				if(WayDot45(currentNode.host).xy==-655286){
					trace("current focus",this);
				}
				
				if(WayDot45(currentNode.host).xy==-7405555){
					trace("current right",this);
				}
				
				if(WayDot45(currentNode.host).xy==-9895923){
					trace("current wrong",this);
				}
				
				var neighbors : Vector.<AStarI> = currentNode.host.stepChoices();
				var il : uint = neighbors.length;
				
				for(var i: int =0; i < il; i++) {
					
					var next : AStarNode = neighbors[i].node;
					
					if(WayDot45(next.host).xy==-7405555){
						trace("neighbor right",this);
					}
					
					if(WayDot45(next.host).xy==-9895923){
						trace("neighbor wrong",this);
					}
					
					if(next.closed || next.host.isWall) {
						// not a valid node to process, skip to next neighbor
						continue;
					}
					
					// gProbe is the g score of start-current-neighbor path. if it is better than 
					// neighbor.g, then we have found a better start-neighbor path.
					var toNeighborStepCost:Number=currentNode.host.stepCost(next.host);
					var toNeighborCost : Number = currentNode.realCostSpentToGetHere+toNeighborStepCost;
					var beenVisited : Boolean = next.visited;
					if ( !beenVisited ){
						closedList.push(next);
					}
					if( beenVisited == false || toNeighborCost < next.realCostSpentToGetHere) {
						
						// Found an optimal (so far) path to this node.  Take score for node to see how good it is.
						next.visited = true;
						next.parent = currentNode;
						next.estimateCostLeft = next.host.estimateCost(end.host); 
						next.realCostSpentToGetHere = toNeighborCost;
						next.estimateCostTotal = next.realCostSpentToGetHere + next.estimateCostLeft;
						
						if (!beenVisited) {
							// Pushing to heap will put it in proper place based on the score value.
							openHeap.push(next);
						}else {
							// Already seen the node, but since it has been rescored we need to reorder it in the heap
							openHeap.rescoreElement(next);
						}
					}
				}
			}
			
			cleanUp();
			return null;
		}
		
		private function cleanUp():void{
			for each(var c:AStarNode in closedList){
				c.reset();
			}
		}
	}
}