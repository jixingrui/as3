package azura.common.algorithm.pathfinding.astar3
{
	public class BinaryHeap
	{
		private var _content : Vector.<AStarNode3>;

		/**
		 * A BinaryHeap implementation taken from the Javascript example at https://github.com/bgrins/javascript-astar/blob/master/graph.js
		 */
		public function BinaryHeap()
		{
			_content = new Vector.<AStarNode3>();
		}
		
		public function reset() : void {
			_content = new Vector.<AStarNode3>();
		}
		
		public function get content():Vector.<AStarNode3>{
			return _content;
		}
		
		
		public function push( element : AStarNode3 ) : void {
			
			//add the new element to the end of the array
			_content.push(element);
			
			//Allow it to sink down.
			this.sinkDown( _content.length - 1 );
		}
		
		public function pop() : AStarNode3 {
			
			// Store the first element so we can return it later.
			var result : AStarNode3 = _content[0];
			
			// Get the element at the end of the array.
			var end : AStarNode3 = _content.pop();
			
			// If there are any elements left, put the end element at the
			// start, and let it bubble up.
			if (_content.length > 0) {
				_content[0] = end;
				this.bubbleUp(0);
			}
			return result;
		}
		
		
		public function remove( node : AStarNode3 ) : void {
			var i : int = _content.indexOf(node);
			
			// When it is found, the process seen in 'pop' is repeated
			// to fill up the hole.
			var end : AStarNode3 = _content.pop();
			if (i != _content.length - 1) {
				_content[i] = end;
				if (end.score < node.score)
				{
					sinkDown(i);
				}
				else
				{
					bubbleUp(i);
				}
			}
		}
		
		
		public function get size() : int {
			return _content.length;
		}
		
		
		public function rescoreElement( node : AStarNode3 ) : void {
			
			sinkDown( _content.indexOf(node) );
		}
		
		
		private function sinkDown( n : int ) : void {
			
			// Fetch the element that has to be sunk.
			var element : AStarNode3 = _content[n];
			
			// When at 0, an element can not sink any further.
			while (n > 0) {
				
				// Compute the parent element's index, and fetch it.
				var parentN : Number = ((n + 1) >> 1) -1 ;
				//var parentN : Number = _content.indexOf(element.parent);
				if (parentN == -1 ){
					parentN = 0;
				}
				
				var	parent : AStarNode3 = _content[parentN];
				
				// Swap the elements if the parent is greater.
				if (element.score < parent.score) {
					_content[parentN] = element;
					_content[n] = parent;
					// Update 'n' to continue at the new position.
					n = parentN;
				}
					// Found a parent that is less, no need to sink any further.
				else {
					break;
				}
			}
		}
		
		private function bubbleUp( n : Number ) : void {
			// Look up the target element and its score.
			var length : int = _content.length;
			var	element : AStarNode3 = _content[n];
			var	elemScore : Number = element.score;
			
			while(true) {
				
				// Compute the indices of the child elements.
				var child2N : Number = (n + 1) << 1;
				var	child1N : Number = child2N - 1;
				
				// This is used to store the new position of the element,
				// if any.
				var swap : * = null;
				
				// If the first child exists (is inside the array)...
				if (child1N < length) {
					// Look it up and compute its score.
					var child1 : AStarNode3 = _content[child1N];
					var	child1Score : Number = child1.score;
					// If the score is less than our element's, we need to swap.
					if (child1Score < elemScore)
						swap = child1N;
				}
				// Do the same checks for the other child.
				if (child2N < length) {
					var child2 : AStarNode3 = _content[child2N];
					var	child2Score : Number = child2.score;
					if (child2Score < (swap == null ? elemScore : child1Score)){
						swap = child2N;
					}
				}
				
				// If the element needs to be moved, swap it, and continue.
				if (swap != null) {
					_content[n] = _content[swap];
					_content[swap] = element;
					n = swap;
				}
					// Otherwise, we are done.
				else {
					break;
				}
			}
		}
		
		
	}
}