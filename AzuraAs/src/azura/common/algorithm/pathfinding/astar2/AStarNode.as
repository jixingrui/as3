package azura.common.algorithm.pathfinding.astar2
{
	import azura.common.collections.HeapI;
	
	import flash.geom.Point;
	
	public class AStarNode implements HeapI
	{
		//h(n) 是从状态n到目标状态的最佳路径的估计代价
		public var estimateCostLeft : Number=0;
		//f(n) 是从初始状态经由状态n到目标状态的代价估计
		public var estimateCostTotal : Number=0;
		//g(n) 是在状态空间中从初始状态到状态n的实际代价
		public var realCostSpentToGetHere : Number=0;
		internal var visited : Boolean=false;
		internal var closed : Boolean=false;
		internal var parent : AStarNode=null;
		
		public var host:AStarI;
		public function AStarNode(host:AStarI){
			this.host=host;
		}
		
		public function reset():void{
			estimateCostLeft=0;
			estimateCostTotal=0;
			realCostSpentToGetHere=0;
			visited=false;
			closed=false;
			parent=null;
		}
				
		public function get score_heap():Number{
			return estimateCostTotal;
		}
		
		public function get parent_heap():HeapI{
			return parent;
		}
		
		//============================= stored standard services ==========================
		public static function manhattan_dist( xs:int,ys:int,xe:int,ye:int ) : Number{
			var dx : uint = Math.abs( xe-xs );
			var dy : uint = Math.abs( ye-ys );
			return dx + dy;
		}
		
		public static function diagnal_dist( xs:int,ys:int,xe:int,ye:int  ) : Number{
			var dx : uint = Math.abs( xe-xs );
			var dy : uint = Math.abs( ye-ys );
			return (dx>dy)?(dx+0.4*dy):(dy+0.4*dx);
		}
		
	}
}