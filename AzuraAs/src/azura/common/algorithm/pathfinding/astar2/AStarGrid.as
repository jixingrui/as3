package azura.common.algorithm.pathfinding.astar2
{
	import flash.geom.Point;

	public class AStarGrid implements AStarI
	{
		public static var grid : Vector.<Vector.<AStarI>>;

		public var position : Point;
		private var _isWall : Boolean;
		private var node_:AStarNode;
		
		public function AStarGrid(){
			node_=new AStarNode(this);
		}
		
		public function get node():AStarNode{
			return node_;
		}
		
		public function get isWall():Boolean
		{
			return _isWall;
		}
		
		public function set isWall(value:Boolean):void
		{
			_isWall = value;
		}
		
		public function estimateCost(far:AStarI):Number{
			var other:AStarGrid=far as AStarGrid;
			return AStarNode.diagnal_dist(position.x,position.y,other.position.x,other.position.y);
		}
		
		public function stepCost(neighbor:AStarI):Number{
			return 1;
//			return AStarNode.manhattan_dist(position,AStarUser(neighbor).position);
		}
				
		public function stepChoices():Vector.<AStarI> {
			return gridNeighbors(position.x,position.y,grid,true);
		}
		
		public static function gridNeighbors(x:Number,y:Number,grid:Vector.<Vector.<AStarI>>,allowDiagonal:Boolean):Vector.<AStarI> {
			var ret : Vector.<AStarI> = new Vector.<AStarI>();
			
			try{
				if( grid[x-1] && grid[x-1][y]) {
					ret.push(grid[x-1][y]);
				}
			}catch(e:ReferenceError){}catch(e:RangeError){}
			try{
				if(grid[x+1] && grid[x+1][y]) {
					ret.push(grid[x+1][y]);
				}
			}catch(e:ReferenceError){}catch(e:RangeError){}
			try{
				if(grid[x] && grid[x][y-1]) {
					ret.push(grid[x][y-1]);
				}
			}catch(e:ReferenceError){}catch(e:RangeError){}
			try{
				if(grid[x] && grid[x][y+1]) {
					ret.push(grid[x][y+1]);
				}
			}catch(e:ReferenceError){}catch(e:RangeError){}
			
			//diags
			if ( allowDiagonal ){
				try{
					if ( !grid[x][y-1].isWall || !grid[x+1][y].isWall ){		
						ret.push(grid[x+1][y-1]); //up right
					}
				}catch(e:ReferenceError){}catch(e:RangeError){}
				try{
					if ( !grid[x+1][y].isWall || !grid[x][y+1].isWall ){
						ret.push(grid[x+1][y+1]); //down right
					}
				}catch(e:ReferenceError){}catch(e:RangeError){}
				try{
					if ( !grid[x-1][y].isWall || !grid[x][y+1].isWall ){
						ret.push( grid[x-1][y+1]  ); //down left
					}
					
				}catch(e:ReferenceError){}catch(e:RangeError){}
				try{
					if ( !grid[x-1][y].isWall || !grid[x][y-1].isWall ){
						ret.push( grid[x-1][y-1] );//up left
					}
				}catch(e:ReferenceError){}catch(e:RangeError){}
			}
			
			return ret;
		}
	}
}