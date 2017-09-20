/*
 * This file is part of the AABBTree library for haxe (https://github.com/azrafe7/as3AABBTree).
 * 
 * Developed by Giuseppe Di Mauro (aka azrafe7) and realeased under the MIT license (see LICENSE file).
 * 
 * The code is heavily inspired by the implementations of a dynamic AABB tree by 
 * 
 *  - Nathanael Presson 	(Bullet Physics - http://bulletphysics.org)
 *	- Erin Catto 			(Box2D - http://www.box2d.org)
 */

package azura.common.algorithm.aabb
{

	/**
	 * Node class used by AABBTree.
	 * 
	 * @author azrafe7
	 */
	public class Node 
	{
		public var parent:Node = null;
		public var left:Node = null;
		public var right:Node = null;
		
		public var id:int = -1;
		public var data:*;

		// fat AABB
		public var aabb:AABBox;
		
		// 0 for leaves
		public var invHeight:int = -1;
		
		public function Node(aabb:AABBox, data:*)
		{
			this.aabb = aabb;
			this.data = data;
		}
		
		/** If it's a leaf both left and right nodes should be null. */
		public function isLeaf():Boolean
		{
			return left == null;
		}
	}
}