package floor
{
	import a.Statics;
	
	import azura.banshee.engine.mouse.MouseDUMI;
	import azura.banshee.zbase.WayDot45;
	import azura.common.algorithm.pathfinding.astar2.AStar;
	import azura.common.algorithm.pathfinding.astar2.AStarI;
	import azura.common.algorithm.pathfinding.astar2.AStarNode;
	import azura.common.ui.mouse.WatcherDrag;
	import azura.common.ui.mouse.WatcherEvent;
	import azura.avalon.maze.data.Door;
	import azura.avalon.maze.data.RegionNode;
	
	import flash.geom.Point;
	
	public class MouseStartPos 
	{
		private var host:LayerStationFloors;
		
		private var wg:WatcherDrag;
		
		public function MouseStartPos(host:LayerStationFloors)
		{
			this.host=host;				
			wg=new WatcherDrag(Statics.stage);
			wg.addEventListener(WatcherEvent.DRAG_START,onClick);
		}
		
		public function onClick(we:WatcherEvent):void{
			var xg:int=host.root.xRoot+we.position.x/host.root.scaleLocal;
			var yg:int=host.root.yRoot+we.position.y/host.root.scaleLocal;
			
			host.start(xg,yg);
		}
		
		public function dispose():void{
			wg.dispose();
			wg=null;
			host=null;
		}
		
	}
}

