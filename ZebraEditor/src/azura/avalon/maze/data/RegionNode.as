package azura.avalon.maze.data
{
	import azura.common.algorithm.pathfinding.astar2.AStarI;
	import azura.common.algorithm.pathfinding.astar2.AStarNode;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	public class RegionNode implements AStarI
	{
		public static const FARDIST:int=9999;
		public var stepList:Vector.<AStarI> =new Vector.<AStarI>();
		private var node_:AStarNode;
		
		public var room:RoomShellOld;
		public var doorList:Vector.<Door>=new Vector.<Door>();
		
		public var pathStart:Point,pathEnd:Point;
		public var doorsToShow:Vector.<Door>=new Vector.<Door>();
		public var xMouse:int,yMouse:int;
		private var _isTerminal:Boolean=false;
		
		public function RegionNode(room:RoomShellOld)
		{
			this.room=room;
			node_=new AStarNode(this);
		}
		
		public function get isTerminal():Boolean
		{
			return _isTerminal;
		}

		public function set isTerminal(value:Boolean):void
		{
			_isTerminal = value;
		}

		public function link(to:AStarI):void{
			stepList.push(to);
		}
		
		public function get node():AStarNode{
			return node_;
		}
		
		public function stepChoices():Vector.<AStarI>
		{
			return stepList;
		}
		
		public function get isWall():Boolean{
			return !isTerminal;
		}
		
		public function estimateCost(far:AStarI):Number{
			if(isTerminal){
				return 0;
			}else{
				return RegionNode.FARDIST;
			}
		}
		
		//ToDo: use walk path length
		public function stepCost(neighbor:AStarI):Number{
			if(isTerminal){
				var d:Door=neighbor as Door;
				return AStarNode.manhattan_dist(xMouse,yMouse,d.x,d.y);
			}else{
				return RegionNode.FARDIST;
			}
		}
	}
}