package azura.avalon.maze.data
{
	import azura.banshee.zbase.astar.AStarI;
	import azura.banshee.zbase.astar.AStarNode;
	import azura.common.algorithm.FastMath;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.utils.Dictionary;
	
	public class AStarRD implements AStarI 
	{
		public static const FARDIST:int=9999;
		
		public var stepList:Vector.<AStarI> =new Vector.<AStarI>();
		private var step_dist:Dictionary=new Dictionary();
		
		private var node_:AStarNode;
		
		public function AStarRD(){
			node_=new AStarNode(this);
		}
		
		public function link(to:AStarRD):void{
			stepList.push(to);
			var dist:Number=FARDIST;
			var left:Door=this as Door;
			var right:Door=to as Door;
			if(left!=null&&right!=null&&left.room==right.room){
				dist=AStarNode.manhattan_dist(left.x,left.y,right.x,right.y);	
			}
			this.step_dist[to]=dist;
		}
		
		public function get node():AStarNode{
			return node_;
		}
		
		public function get isWall():Boolean
		{
			return false;
		}
		
		public function lookDist(far:AStarI):Number
		{
			var left:Door=this as Door;
			var right:Door=far as Door;
			if(left!=null&&right!=null&&left.room==right.room){
				return AStarNode.manhattan_dist(left.x,left.y,right.x,right.y);	
			}else{
				return far.lookDist(this);
			}
		}
		
		public function walkDist(neighbor:AStarI):Number
		{
			var left:Door=this as Door;
			var right:Door=neighbor as Door;
			if(left!=null&&right!=null){
				return step_dist[neighbor];
			}else{
				return neighbor.walkDist(this);
			}
		}
		
		public function stepChoices():Vector.<AStarI>
		{
			return stepList;
		}
		
	}
}