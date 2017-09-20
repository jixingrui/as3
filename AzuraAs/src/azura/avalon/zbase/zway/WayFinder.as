package azura.avalon.zbase.zway
{
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.pathfinding.BhStrider;
	import azura.common.algorithm.pathfinding.astar.AStarEidiot;
	import azura.common.algorithm.pathfinding.astar.Floyd;
	import azura.common.algorithm.pathfinding.astar2.AStar;
	import azura.common.algorithm.pathfinding.astar2.AStarI;
	import azura.common.algorithm.pathfinding.astar2.AStarNode;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	public class WayFinder implements CanSeeI
	{
		private var zway:Zway=new Zway();
		
		private var astarGrid:AStarEidiot;
		private var floyd:Floyd;
		
		private var startDot:WayDot45;
		private var endDot:WayDot45;		
		private var startPoint:Point;
		private var endPoint:Point;
		
		private var scale:Number;
		
		public function WayFinder(zway:Zway,scale:Number){
			this.zway=zway;
			this.scale=scale;
			floyd=new Floyd(zway.base);
		}
		
		public function start(x:int,y:int):WayDot45{
			startDot=pointToNode(x,y);
			if(startDot!=null){
				startPoint=new Point(x/scale,y/scale);
				return startDot;
			}else{
				return null;
			}
		}
		
		public function end(x:int,y:int):WayDot45{
			endDot=pointToNode(x,y);
			if(endDot!=null){
				endPoint=new Point(x/scale,y/scale);
				return endDot;
			}else{
				return null;
			}
		}
		
		public function pointToNode(x:int,y:int):WayDot45{
			x/=scale;
			y/=scale;
			
			if(!zway.base.isRoad(x,y,true))
				return null;
			
			var point:Point=new Point(x,y);
			var node:WayDot45;
			var searchRange:int=64;
			var kn:Vector.<WayDot45>;
			var checked:Dictionary=new Dictionary();
			var count:int;
			while(node==null&&searchRange<1024){
//				kn=zway.wayMap.search(x,y,searchRange);
				kn=null;
				for each(var wn:WayDot45 in kn){
					if(checked[wn]==true)
						continue;
					
					checked[wn]=true;
					var np:Point=new Point(wn.x,wn.y);
					if(canSee(point,np)){
						node=wn;
						break;
					}
				}
				searchRange*=2;
			}
			return node;
		}
		
		public function searchPath():Vector.<Point>{
			
			if(startDot==null||endDot==null||startDot.group!=endDot.group){
				return null;
			}
			
			var path:Vector.<Point>;			
			path=directRay();
			
			if(path==null){
				path=wayPointAstar(startDot,endDot);
				if(path==null)
					return null;
				
				path.unshift(startPoint);
				path.push(endPoint);
				
				path=WayPointStack.load(this,path,scale);
			}
			
			if(path==null)
				return null;
			
			for each(var p:Point in path){
				p.x*=scale;
				p.y*=scale;
			}
			
			path.shift();
			path.unshift(startPoint);
			path.pop();
			path.push(endPoint);
			
			return path;
		}
		
		private function directRay():Vector.<Point>{
			if(canSee(startPoint,endPoint)){
				var result:Vector.<Point>=new Vector.<Point>();
				result.push(startPoint);
				result.push(endPoint);
				return result;
			}else
				return null;
		}
		
		private function gridAstar():Vector.<Point>{
			if(FastMath.dist(startPoint.x,startPoint.y,endPoint.x,endPoint.y)>200)
				return null;	
			
			var path:Vector.<Point>= astarGrid.find(startPoint,endPoint);
			path=floyd.compact(path);
			
			return path;
		}
		
		private function wayPointAstar(start:WayDot45,end:WayDot45):Vector.<Point>{
			
			//translate to point list
			var path:Vector.<AStarI>=null;//AStar.search(start,end);
			if(path==null)
				return null;
			
			var walkPath:Vector.<Point>=new Vector.<Point>();
			for each(var p:WayDot45 in path){
				walkPath.push(new Point(p.x,p.y));
			}
			
			return walkPath;
		}
		
		public function canSee(start:Point,end:Point):Boolean{
			var bs:BhStrider=new BhStrider(start.x,start.y,end.x,end.y);
			var block:Boolean;
			while(bs.stepForward(8/scale)>0){
				if(!zway.base.isRoad(bs.xNow,bs.yNow,true)){
					block=true;
					break;
				}
			}
			return !block;
		}
	}
}








//		private function shrinkPathBiDirectionalOld(walkPath:Vector.<Point>):Vector.<Point>{
//			var minPath:Vector.<Point>=new Vector.<Point>();
//			
//			var startBase:Point=startPoint;
//			var startPath:Vector.<Point>=new Vector.<Point>();
//			var startNextSee:Point;
//			var startStride:int=0;
//			
//			var endBase:Point=endPoint;
//			var endPath:Vector.<Point>=new Vector.<Point>();
//			var endNextSee:Point;
//			var endStride:int=0;
//			
//			var probe:Point;
//			var start_end:Boolean=true;
//			
//			startPath.push(startBase);
//			endPath.push(endBase);
//			while(walkPath.length>0){
//				if(walkPath.length==1){
//					var pl:Point=walkPath[0];
//					if(!canSee(startBase,pl)){
//						startBase=startNextSee;
//						startPath.push(startBase);						
//					}
//					if(!canSee(endBase,pl)){
//						endBase=endNextSee;
//						endPath.unshift(endBase);
//					}
//					if(!canSee(startBase,endBase)){
//						startPath.push(pl);
//					}
//					break;
//				}else if(start_end){
//					probe=walkPath.shift();
//					startStride++;
//					if(canSee(startBase,probe)){
//						startNextSee=probe;
//					}else if(startStride==1){
//						startStride=0;
//						startNextSee=probe;
//						startBase=startNextSee;
//						startPath.push(startBase);
//					}else{
//						startStride=0;
//						startBase=startNextSee;
//						startPath.push(startBase);
//						walkPath.unshift(probe);
//					}
//				}else{
//					probe=walkPath.pop();
//					endStride++;
//					if(canSee(probe,endBase)){
//						endNextSee=probe;
//					}else if(endStride==1){
//						endStride=0;
//						endNextSee=probe;
//						endBase=endNextSee;
//						endPath.unshift(endBase);
//					}else{
//						endStride=0;
//						endBase=endNextSee;
//						endPath.unshift(endBase);
//						walkPath.push(probe);
//					}
//				}
//				start_end=!start_end;
//			}
//			for each(probe in startPath){
//				minPath.push(probe);
//			}
//			for each(probe in endPath){
//				minPath.push(probe);
//			}
//			
//			return minPath;
//		}


//		private function removeSharpOld(source:Vector.<Point>):Vector.<Point>{
//			var pre:Point;
//			var current:Point;
//			var next:Point;
//			for(var i:int=1;i<source.length-1;i++){
//				pre=source[i-1].clone();
//				current=source[i].clone();
//				next=source[i+1].clone();
//				
//				var angle:int=FastMath.p3ToAngle(pre,current,next);
//				var d1:int=FastMath.dist(pre.x,pre.y,current.x,current.y);
//				var d2:int=FastMath.dist(next.x,next.y,current.x,current.y);
//				if(angle<120&&d1>32&&d2>32){
//					pre.x=(pre.x*3+current.x)/4;
//					pre.y=(pre.y*3+current.y)/4;
//					next.x=(next.x*3+current.x)/4;
//					next.y=(next.y*3+current.y)/4;
//					while(true){
//						if(FastMath.dist(pre.x,pre.y,next.x,next.y)<32){
//							break;
//						}else if(canSee(pre,next)){
//							if(canSee(pre,source[i+1])){
//								source.splice(i,1);
//								source.splice(i,0,pre);									
//							}else if(canSee(next,source[i-1])){
//								source.splice(i,1);
//								source.splice(i,0,next);			
//							}else{
//								source.splice(i,1);
//								source.splice(i,0,pre);
//								source.splice(i+1,0,next);
//								i--;
//							}
//							break;
//						}else{
//							pre.x=(pre.x*3+current.x)/4;
//							pre.y=(pre.y*3+current.y)/4;
//							next.x=(next.x*3+current.x)/4;
//							next.y=(next.y*3+current.y)/4;
//						}
//					}
//				}
//			}
//			return source;
//		}
