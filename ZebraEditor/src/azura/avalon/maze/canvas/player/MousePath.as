package azura.avalon.maze.canvas.player
{
	import azura.avalon.maze.data.RegionNode;
	import azura.avalon.zbase.zway.WayDot45;
	import azura.common.algorithm.pathfinding.astar2.AStar;
	import azura.common.algorithm.pathfinding.astar2.AStarI;
	
	import flash.geom.Point;
	
	public class MousePath 
	{
		private var host:LayerMazePlayer;
		[Bindable]
		public var start_end:Boolean=true;
		public var startR:RegionNode,endR:RegionNode;
		
		private var startPoint:Point=new Point();
		
		private var startNode:WayDot45,endNode:WayDot45;
		
		public function MousePath(host:LayerMazePlayer)
		{
			this.host=host;				
		}
		
		public function get priority():int{
			return 0;
		}
		
		public function mouseDown(x:int, y:int):Boolean
		{
			var xg:int=host.root.xRoot+x/host.root.scaleLocal;
			var yg:int=host.root.yView+y/host.root.scaleLocal;
			
			if(start_end){
				
				startNode=host.wayFinder.start(xg,yg);
				if(startNode==null){
					host.drawPoint(xg,yg,0xff888888,4);
					return true;
				}
				
				host.maze.cleanPath();
				host.clearPoints();
				
				startPoint.x=xg;
				startPoint.y=yg;
				
				startR=host.currentRoom.regionList[startNode.group];
				
				startR.xMouse=xg;
				startR.yMouse=yg;
				startR.isTerminal=true;
				
				start_end=false;
				host.drawPoint(xg,yg,0xff00ff00,4);
				host.mouseMode=LayerMazePlayer.MOUSEDRAGSCREEN;
			}else{
				
				endNode=host.wayFinder.end(xg,yg);
				if(endNode==null){
					host.drawPoint(xg,yg,0xff888888,4);
					return true;
				}
				
				endR=host.currentRoom.regionList[endNode.group];
				endR.xMouse=xg;
				endR.yMouse=yg;
				endR.isTerminal=true;
				trace("end at",endR.room,x,y,this);
				
				start_end=true;
				host.drawPoint(xg,yg,0xff00ff00,4);
				
				if(endR==startR){
					startR.pathStart=startPoint.clone();
					startR.pathEnd=new Point(xg,yg);
					host.showPath();
				}else{
					
					var pathRD:Vector.<AStarI>=AStar.search(startR,endR);
					if(pathRD==null){
						trace("path not found",this);
						host.mouseMode=LayerMazePlayer.MOUSEDRAGSCREEN;
						return true;
					}
					
					var str:String="path:";
					for each(var prd:AStarI in pathRD){
						str+=" "+prd;
					}
					trace(str,this);
					
					host.maze.cleanPath();
					host.clearPoints();
					
					startR.pathStart=startPoint.clone();
					var startDoor:Door=pathRD[0] as Door;
					startR.pathEnd=new Point(startDoor.x,startDoor.y);
					
					var endDoor:Door=pathRD[pathRD.length-1] as Door;
					endR.pathStart=new Point(endDoor.x,endDoor.y);
					endR.pathEnd=new Point(xg,yg);
					
					for(var i:int=0;i<pathRD.length-1;i++){
						var current:Door=pathRD[i] as Door;
						var next:Door=pathRD[i+1] as Door;
						if(current.toDoor==next)
							continue;
						
						current.regionNode.pathStart=new Point(current.x,current.y);
						current.regionNode.pathEnd=new Point(next.x,next.y);
						current.regionNode.doorsToShow.push(current);
						current.regionNode.doorsToShow.push(next);
					}
					
					host.showPath();
				}
				
				host.mouseMode=LayerMazePlayer.MOUSEDRAGSCREEN;
			}
			
			return true;
		}
		
		public function mouseMove(x:int, y:int):void
		{
		}
		
		public function mouseUp(x:int, y:int):void
		{
		}
	}
}

