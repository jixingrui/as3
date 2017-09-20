package azura.common.algorithm.aabb
{
	import azura.common.collections.IdGenStore;
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	public class AABBTree
	{
		/** Algorithm to use for choosing where to insert a new leaf. */
		public var insertStrategy:IInsertStrategy;
		
		public var root:Node = null;
		
		protected var id_Node:IdGenStore=new IdGenStore();
		protected var data_Node:Dictionary;
		protected var id_Leaf:Dictionary;
		
		/**
		 * Creates a new AABBTree.
		 * 
		 * @param	fattenDelta				How much to fatten the aabbs (to avoid updating the nodes too frequently when the underlying data moves/resizes).
		 * @param	insertStrategy			Strategy to use for choosing where to insert a new leaf. Defaults to `InsertStrategyPerimeter`.
		 * @param	initialPoolCapacity		How much free nodes to have in the pool initially.
		 * @param	poolGrowthCapacity		The pool will grow by this factor when it's empty.
		 */
		public function AABBTree():void
		{
			this.insertStrategy = new InsertStrategyPerimeter();
			clear();
		}
		
		public function getNode(id:int):Node{
			return id_Node.get(id);
		}
		/** Total number of nodes (includes unused ones). */
		public function get numNodes():int {
			return id_Node.size();
		}
		
		/** Total number of leaves. */
		protected var _numLeaves:int = 0;
		public function get numLeaves():int {
			return _numLeaves;
		}
		
		/** Height of the tree. */
		public function get height():int {
			return root != null ? root.invHeight : -1;
		}
		
		/** 
		 * Inserts a leaf node with the specified `aabb` values and associated `data`.
		 * 
		 * The user must store the returned id and use it later to apply changes to the node (removeLeaf(), updateLeaf()).
		 * 
		 * @return The index of the inserted node.
		 */
		private function insertLeaf(data:*, x:Number, y:Number, width:Number = 0, height:Number = 0):void
		{
			// create new node and fatten its aabb
			var leafNode:Node = new Node(new AABBox(x,y,width,height),data);
			leafNode.id=id_Node.add(leafNode);
			leafNode.invHeight = 0;
			id_Leaf[leafNode.id] = leafNode;
			data_Node[data]=leafNode;
			_numLeaves++;
			
			if (root == null) {
				root = leafNode;
				return;
			}
			
			// find best sibling to insert the leaf
			var leafAABB:AABBox = leafNode.aabb;
			var combinedAABB:AABBox = new AABBox();
			var left:Node;
			var right:Node;
			var node:Node = root;
			var exit:Boolean = false;
			while (!node.isLeaf() && !exit)
			{
				switch (insertStrategy.choose(leafAABB, node))
				{
					case InsertChoice.PARENT:
						exit = true;
						break;
					case InsertChoice.DESCEND_LEFT:
						node = node.left;
						break;
					case InsertChoice.DESCEND_RIGHT:
						node = node.right;
						break;
				}
			}
			
			var sibling:Node = node;
			
			// create a new parent
			var oldParent:Node = sibling.parent;
			combinedAABB.asUnionOf(leafAABB, sibling.aabb);
			var newParent:Node = new Node(combinedAABB,null);
			newParent.parent=oldParent;
			newParent.id=id_Node.add(newParent);
			newParent.invHeight = sibling.invHeight + 1;
			
			// the sibling was not the root
			if (oldParent != null) {
				
				if (oldParent.left == sibling) {
					oldParent.left = newParent;
				} else {
					oldParent.right = newParent;
				}
			} else {
				// the sibling was the root
				root = newParent;
			}
			newParent.left = sibling;
			newParent.right = leafNode;
			sibling.parent = newParent;
			leafNode.parent = newParent;
			
			// walk back up the tree fixing heights and AABBs
			node = leafNode.parent;
			while (node != null)
			{
				node = id_Node.get(balance(node.id));
				
				left = node.left;
				right = node.right;
				
				node.invHeight = 1 + int(Math.max(left.invHeight, right.invHeight));
				node.aabb.asUnionOf(left.aabb, right.aabb);
				
				node = node.parent;
			}
		}
		
		/** 
		 * Updates the aabb of leaf node with the specified `leafId` (must be a leaf node).
		 * 
		 * @return false if the fat aabb didn't need to be expanded.
		 */
		public function updateLeaf(data:*, rect:Rectangle):Boolean
		{
			
			var newAABB:AABBox = new AABBox(rect.x, rect.y, rect.width, rect.height);
			
			var leafNode:Node = data_Node[data];
			
			if (leafNode!=null && leafNode.aabb.contains(newAABB)) {
				return false;
			}
			
			if(leafNode!=null)
				removeLeaf(data);
			
			insertLeaf(data, rect.x, rect.y, rect.width, rect.height);
			
			return true;
		}
		
		/** 
		 * Removes the leaf node with the specified `leafId` from the tree (must be a leaf node).
		 */
		public function removeLeaf(data:*):void
		{
			var leafNode:Node = data_Node[data];
			
			//======================= todo: should not be null ============
			if(leafNode==null)
				return;
			
			delete id_Leaf[leafNode.id];
			
			if (leafNode == root) {
				disposeNode(root);
				root = null;
				return;
			}
			
			var parent:Node = leafNode.parent;
			var grandParent:Node = parent.parent;
			var sibling:Node = parent.left == leafNode ? parent.right : parent.left;
			
			if (grandParent != null) {
				// connect sibling to grandParent
				if (grandParent.left == parent) {
					grandParent.left = sibling;
				} else {
					grandParent.right = sibling;
				}
				sibling.parent = grandParent;
				
				// adjust ancestor bounds
				var node:Node = grandParent;
				while (node != null)
				{
					node = id_Node.get(balance(node.id));
					
					var left:Node = node.left;
					var right:Node = node.right;
					
					node.aabb.asUnionOf(left.aabb, right.aabb);
					node.invHeight = 1 + int(Math.max(left.invHeight, right.invHeight));
					
					node = node.parent;
				}
			} else {
				root = sibling;
				root.parent = null;
			}
			
			// destroy parent
			disposeNode(parent);
			disposeNode(leafNode);
		}
		
		/** 
		 * Removes all nodes from the tree. 
		 */
		public function clear():void
		{
			root = null;
			data_Node=new Dictionary();
			id_Leaf = new Dictionary();
			id_Node.clear();
		}
		
		/** Returns a clone of the aabb associated to the node with the specified `leafId` (must be a leaf node). */
		private function getFatAABB(leafId:int):AABBox
		{
			var leafNode:Node = id_Node.get(leafId);
			
			return leafNode.aabb.clone();
		}
		
		/**
		 * Queries the tree for objects in the specified AABB.
		 * 
		 * @param	into			Hit objects will be appended to this (based on callback return value).
		 * @param	strictMode		If set to true only objects fully contained in the AABB will be processed. Otherwise they will be checked for intersection (default).
		 * @param	callback		A function called for every object hit (function callback(data:AABBI, id:int):HitBehaviour).
		 * 
		 * @return A list of all the objects found (or `into` if it was specified).
		 */
		public function query(x:Number, y:Number, width:Number = 0, height:Number = 0, strictMode:Boolean = false):Vector.<Object>
		{
			var res:Vector.<Object> = new Vector.<Object>();
			if (root == null) return res;
			
			var stack:Vector.<Node> = new <Node>[root];
			var queryAABB:AABBox = new AABBox(x, y, width, height);
			var cnt:int = 0;
			while (stack.length > 0) {
				var node:Node = stack.pop();
				cnt++;
				
				if (queryAABB.overlaps(node.aabb)) {
					if (node.isLeaf() && (!strictMode || (strictMode && queryAABB.contains(node.aabb)))) {
						res.push(node.data);
					} else {
						if (node.left != null) stack.push(node.left);
						if (node.right != null) stack.push(node.right);
					}
				}
			}
			return res;
		}
		
		/**
		 * Queries the tree for objects overlapping the specified point.
		 * 
		 * @return A list of all the objects found (or `into` if it was specified).
		 */
		public function queryPoint(x:Number, y:Number):Vector.<Object>
		{
			return query(x, y, 0, 0, false);
		}
		
		/** Returns the node with the specified `id` to the pool. */
		protected function disposeNode(node:Node):void {
			if (node.isLeaf()){
				_numLeaves--;
				delete data_Node[node.data];
			}
			id_Node.remove(node.id);
		}
		
		/**
		 * Performs a left or right rotation if `nodeId` is unbalanced.
		 * 
		 * @return The new parent index.
		 */
		protected function balance(nodeId:int):int
		{
			var A:Node = id_Node.get(nodeId);
			
			if (A.isLeaf() || A.invHeight < 2) {
				return A.id;
			}
			
			var B:Node = A.left;
			var C:Node = A.right;
			
			var balanceValue:int = C.invHeight - B.invHeight;
			
			// rotate C up
			if (balanceValue > 1) return rotateLeft(A, B, C);
			
			// rotate B up
			if (balanceValue < -1) return rotateRight(A, B, C);
			
			return A.id;
		}
		
		/** Returns max height distance between two children (of the same parent) in the tree. */
		private function getMaxBalance():int
		{
			var maxBalance:int = 0;
			for (var i:int = 0; i < numNodes; i++) {
				var node:Node = id_Node.get(i);
				if (node.invHeight <= 1 || node == null) continue;
				
				var left:Node = node.left;
				var right:Node = node.right;
				var balance:int = Math.abs(right.invHeight - left.invHeight);
				maxBalance = int(Math.max(maxBalance, balance));
			}
			
			return maxBalance;
		}
		
		/*
		*           A			parent
		*         /   \
		*        B     C		left and right nodes
		*             / \
		*            F   G
		*/
		protected function rotateLeft(parentNode:Node, leftNode:Node, rightNode:Node):int
		{
			var F:Node = rightNode.left;
			var G:Node = rightNode.right;
			
			// swap A and C
			rightNode.left = parentNode;
			rightNode.parent = parentNode.parent;
			parentNode.parent = rightNode;
			
			// A's old parent should point to C
			if (rightNode.parent != null) {
				if (rightNode.parent.left == parentNode) {
					rightNode.parent.left = rightNode;
				} else {
					rightNode.parent.right = rightNode;
				}
			} else {
				root = rightNode;
			}
			
			// rotate
			if (F.invHeight > G.invHeight) {
				rightNode.right = F;
				parentNode.right = G;
				G.parent = parentNode;
				parentNode.aabb.asUnionOf(leftNode.aabb, G.aabb);
				rightNode.aabb.asUnionOf(parentNode.aabb, F.aabb);
				
				parentNode.invHeight = 1 + int(Math.max(leftNode.invHeight, G.invHeight));
				rightNode.invHeight = 1 + int(Math.max(parentNode.invHeight, F.invHeight));
			} else {
				rightNode.right = G;
				parentNode.right = F;
				F.parent = parentNode;
				parentNode.aabb.asUnionOf(leftNode.aabb, F.aabb);
				rightNode.aabb.asUnionOf(parentNode.aabb, G.aabb);
				
				parentNode.invHeight = 1 + int(Math.max(leftNode.invHeight, F.invHeight));
				rightNode.invHeight = 1 + int(Math.max(parentNode.invHeight, G.invHeight));
			}
			
			return rightNode.id;
		}
		
		/*
		*             A			parent
		*          /   \
		*        B    C		left and right nodes
		*      / \
		*    D  E
		*/
		protected function rotateRight(parentNode:Node, leftNode:Node, rightNode:Node):int
		{
			var D:Node = leftNode.left;
			var E:Node = leftNode.right;
			
			// swap A and B
			leftNode.left = parentNode;
			leftNode.parent = parentNode.parent;
			parentNode.parent = leftNode;
			
			// A's old parent should point to B
			if (leftNode.parent != null)
			{
				if (leftNode.parent.left == parentNode) {
					leftNode.parent.left = leftNode;
				} else {
					leftNode.parent.right = leftNode;
				}
			} else {
				root = leftNode;
			}
			
			// rotate
			if (D.invHeight > E.invHeight) {
				leftNode.right = D;
				parentNode.left = E;
				E.parent = parentNode;
				parentNode.aabb.asUnionOf(rightNode.aabb, E.aabb);
				leftNode.aabb.asUnionOf(parentNode.aabb, D.aabb);
				
				parentNode.invHeight = 1 + int(Math.max(rightNode.invHeight, E.invHeight));
				leftNode.invHeight = 1 + int(Math.max(parentNode.invHeight, D.invHeight));
			} else {
				leftNode.right = E;
				parentNode.left = D;
				D.parent = parentNode;
				parentNode.aabb.asUnionOf(rightNode.aabb, D.aabb);
				leftNode.aabb.asUnionOf(parentNode.aabb, E.aabb);
				
				parentNode.invHeight = 1 + int(Math.max(rightNode.invHeight, D.invHeight));
				leftNode.invHeight = 1 + int(Math.max(parentNode.invHeight, E.invHeight));
			}
			
			return leftNode.id;
		}
		
		static protected function getKeysFromDict(dict:Dictionary):Vector.<int>
		{
			var res:Vector.<int> = new Vector.<int>();
			for (var k:* in dict) res.push(k as int);
			return res;
		}
		
		static protected function segmentIntersect(p0x:Number, p0y:Number, p1x:Number, p1y:Number, q0x:Number, q0y:Number, q1x:Number, q1y:Number):Boolean
		{
			var intX:Number, intY:Number;
			var a1:Number, a2:Number;
			var b1:Number, b2:Number;
			var c1:Number, c2:Number;
			
			a1 = p1y - p0y;
			b1 = p0x - p1x;
			c1 = p1x * p0y - p0x * p1y;
			a2 = q1y - q0y;
			b2 = q0x - q1x;
			c2 = q1x * q0y - q0x * q1y;
			
			var denom:Number = a1 * b2 - a2 * b1;
			if (denom == 0) {
				return false;
			}
			
			intX = (b1 * c2 - b2 * c1) / denom;
			intY = (a2 * c1 - a1 * c2) / denom;
			
			// check to see if distance between intersection and endpoints
			// is longer than actual segments.
			// return false otherwise.
			if (distanceSquared(intX, intY, p1x, p1y) > distanceSquared(p0x, p0y, p1x, p1y)) return false;
			if (distanceSquared(intX, intY, p0x, p0y) > distanceSquared(p0x, p0y, p1x, p1y)) return false;
			if (distanceSquared(intX, intY, q1x, q1y) > distanceSquared(q0x, q0y, q1x, q1y)) return false;
			if (distanceSquared(intX, intY, q0x, q0y) > distanceSquared(q0x, q0y, q1x, q1y)) return false;
			
			return true;
		}
		
		static protected function distanceSquared(px:Number, py:Number, qx:Number, qy:Number):Number { return sqr(px - qx) + sqr(py - qy); }
		
		static protected function sqr(x:Number):Number { return x * x; }
		
	}
}