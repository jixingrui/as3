package azura.common.collections
{
	public class Heap
	{
		private var _content : Vector.<HeapI>;
		
		/**
		 * A BinaryHeap implementation taken from the Javascript example at https://github.com/bgrins/javascript-astar/blob/master/graph.js
		 */
		public function Heap()
		{
			_content = new Vector.<HeapI>();
		}
		
		public function reset() : void {
			_content = new Vector.<HeapI>();
		}
		
		public function get content():Vector.<HeapI>{
			return _content;
		}
		
		/**
		 * 
		 * @param element its parent also gets checked
		 * 
		 */
		public function push( element : HeapI ) : void {
			
			//add the new element to the end of the array
			_content.push(element);
			
			//Allow it to sink down.
			this.sinkDown( _content.length - 1 );
		}
		
		/**
		 * 
		 * @return the node with the lowest score
		 * 
		 */
		public function pop() : HeapI {
			
			// Store the first element so we can return it later.
			var result : HeapI = _content[0];
			
			// Get the element at the end of the array.
			var end : HeapI = _content.pop();
			
			// If there are any elements left, put the end element at the
			// start, and let it bubble up.
			if (_content.length > 0) {
				_content[0] = end;
				this.bubbleUp(0);
			}
			return result;
		}
		
		public function remove( node : HeapI ) : void {
			var i : int = _content.indexOf(node);
			
			// When it is found, the process seen in 'pop' is repeated
			// to fill up the hole.
			var end : HeapI = _content.pop();
			if (i != _content.length - 1) {
				_content[i] = end;
				if (end.score_heap < node.score_heap)
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
		
		
		public function rescoreElement( node : HeapI ) : void {
			
			sinkDown( _content.indexOf(node) );
		}
		
		
		private function sinkDown( n : int ) : void {
			
			// Fetch the element that has to be sunk.
			var element : HeapI = _content[n];
			
			// When at 0, an element can not sink any further.
			while (n > 0) {
				
				// Compute the parent element's index, and fetch it.
				//var parentN : Number = ((n + 1) >> 1) -1 ;
				var parentN : Number = _content.indexOf(element.parent_heap);
				if (parentN == -1 ){
					parentN = 0;
				}
				
				var	parent : HeapI = _content[parentN];
				
				// Swap the elements if the parent is greater.
				if (element.score_heap < parent.score_heap) {
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
			var	element : HeapI = _content[n];
			var	elemScore : Number = element.score_heap;
			
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
					var child1 : HeapI = _content[child1N];
					var	child1Score : Number = child1.score_heap;
					// If the score is less than our element's, we need to swap.
					if (child1Score < elemScore)
						swap = child1N;
				}
				// Do the same checks for the other child.
				if (child2N < length) {
					var child2 : HeapI = _content[child2N];
					var	child2Score : Number = child2.score_heap;
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