package azura.common.algorithm.pathfinding
{
	import azura.common.algorithm.pathfinding.astar.AStarEidiot;
	import azura.common.algorithm.pathfinding.astar.AstarMapI;
	import azura.common.algorithm.pathfinding.astar.Floyd;
	
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class PathFinder
	{
		//step=1
		private var map:AstarMapI;
		//		private var astarOriginal:AStarEidiot;
		private var floydOriginal:Floyd;
		
		private var stride:int=8;
		private var strider:Strider;
		private var astarStrider:AStarEidiot;
		//		private var floydStrider:Floyd;
		
//		public function PathStrider(stride:int=8){
//			this.stride=stride;
//		}
		
		public function setMap(map:AstarMapI):void{
			this.map=map;
			//			astarOriginal=new AStarEidiot(map,8000);
			floydOriginal=new Floyd(map);
			
			strider=new Strider(map,stride);
			astarStrider=new AStarEidiot(strider,1200);
			//			floydStrider=new Floyd(strider);
		}
		
		public function find(startX:int, startY:int, endX:int, endY:int):Vector.<Point>
		{
			
//			var isRoad:Boolean=map.isRoad(endX,endY,true);
//			if(!isRoad)
//				return null;
			
			var t:int=getTimer();
			
			var bs:BhStrider=new BhStrider(startX,startY,endX,endY);
			var bad:Boolean;
			while(bs.stepForward(stride)>0){
				if(!map.isRoad(bs.xNow,bs.yNow)){
					bad=true;
					break;
				}
			}
			
			//			trace("ray cost",getTimer()-t,this);
			//			t=getTimer();
			
			var path:Vector.<Point>;
			
			if(!bad){
				
				path=new Vector.<Point>();
				//				path.push(new Point(startX,startY));
				path.push(new Point(endX,endY));
				
//				trace("ray cost",getTimer()-t,this);
				
			}else{
				t=getTimer();
				
				var start:Point=new Point(startX/stride,startY/stride);
				var end:Point=new Point(endX/stride,endY/stride);
				path=astarStrider.find(start,end);
				
				if(path==null){
					//					trace("path problem",this);
//					trace("astar failed cost",getTimer()-t,this);
					return null;
				}
				
				for each(var ps:Point in path){
					ps.x*=stride;
					ps.y*=stride;
				}
				
				path[0]=new Point(startX,startY);
				path[path.length-1]=new Point(endX,endY);
				
				if(path.length>1)
					path=floydOriginal.compact(path);
				
				path.shift();
				
//				trace("astar cost",getTimer()-t,this);
			}
			
			
			return path;
		}
		
		//				/**
		//				 * 
		//				 * original
		//				 * 
		//				 */
		//				public function find(startX:int, startY:int, endX:int, endY:int):void
		//				{
		//					var raw:Vector.<Point>=astarOriginal.find(startX,startY,endX,endY);
		//					if(raw==null)
		//						return ;
		//					
		//					var fpath:Vector.<Point>=floydOriginal.compact(raw);
		//					if(fpath.length>0)
		//						_pathReady.call(null,fpath);
		//					
		//				}
	}
}