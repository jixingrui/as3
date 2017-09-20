package azura.avalon.zbase
{
	import azura.common.algorithm.pathfinding.astar.AStarEidiot;
	import azura.common.algorithm.pathfinding.astar.AstarMapI;
	import azura.common.algorithm.pathfinding.astar.Floyd;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Point;
	import azura.common.algorithm.pathfinding.Strider;
	
	public class Core1 implements CoreI
	{
		private var _pathReady:Function;
		
		//step=1
		private var map:AstarMapI;
		private var astarOriginal:AStarEidiot;
		private var floydOriginal:Floyd;
		
		//step=32
		private var stride:int=32;
		private var strider:Strider;
		private var astarStrider:AStarEidiot;
		private var floydStrider:Floyd;
		
		public function set pathReady(value:Function):void
		{
			_pathReady=value;
		}
		
		public function setMap(map:AstarMapI):void{
			this.map=map;
			astarOriginal=new AStarEidiot(map,8000);
			floydOriginal=new Floyd(map);
			
			strider=new Strider(map,stride);
			astarStrider=new AStarEidiot(strider,4000);
			floydStrider=new Floyd(strider);
		}
		
		public function setBase(data:ZintBuffer):void
		{
			var base:Zbase = new Zbase();
			base.fromBytes(data);			
			setMap(base);
		}
		
		public function find(startX:int, startY:int, endX:int, endY:int):void
		{
			var start:Point=new Point(startX/stride,startY/stride);
			var end:Point=new Point(endX/stride,endY/stride);
			var aPath:Vector.<Point>=astarStrider.find(start,end);
			if(aPath==null){
				trace(this,"path problem");
				return ;
			}
			
			var fPath:Vector.<Point>=floydStrider.compact(aPath);
			for each(var ps:Point in fPath){
				ps.x*=stride;
				ps.y*=stride;
			}
			fPath.unshift(new Point(startX,startY));
			fPath.push(new Point(endX,endY));
			
			fPath=floydOriginal.compact(fPath);
			
			if(fPath.length>0)
				_pathReady.call(null,fPath);
			
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