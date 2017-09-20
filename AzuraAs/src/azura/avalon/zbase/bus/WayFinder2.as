package azura.avalon.zbase.bus
{
	import azura.avalon.zbase.zway.CanSeeI;
	import azura.avalon.zbase.zway.WayDot45;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.pathfinding.BhStrider;
	import azura.common.algorithm.pathfinding.astar3.AStar3;
	import azura.common.algorithm.pathfinding.astar3.AStarI3;
	
	import flash.geom.Point;
	
	public class WayFinder2 implements CanSeeI
	{
		public var zway:RoadMap;
		
		private var scale:Number;
		
		public function WayFinder2(roadMap:RoadMap){
			this.zway=roadMap;
			this.scale=FastMath.pow2x(roadMap.base.shrinkZ);
		}
		
		public function getEscapeRoute(runner:Point,monster:Point):Vector.<Point>{
			monster.x/=scale;
			monster.y/=scale;
			
			var startStation:WayDot45=zway.getStation(runner.x,runner.y);
			
			runner.x/=scale;
			runner.y/=scale;
			
			var closerDist:int=FastMath.dist(startStation.x,startStation.y,runner.x,runner.y);
			var closer:WayDot45=startStation;
			for each(var n:WayDot45 in startStation.neighbors){
//				if(canSee(runner,n.point)==false)
//					continue;
				
				var dist:int=FastMath.distP(runner,n.point);
				if(dist<closerDist){
					closerDist=dist;
					closer=n;
				}
			}
			var path:Vector.<Point>=new Vector.<Point>();
			var distTotal:int=dist;
			var step:WayDot45=closer;
			while(distTotal<500/scale){
				var sp:Point=step.point;
//				var np:Point=next.point;
				
				var next:WayDot45=stepNext(monster,step);
				distTotal+=FastMath.distP(sp,next.point);
				step=next;
				
				sp.x=sp.x*scale+scale/2;
				sp.y=sp.y*scale+scale/2;
				path.push(sp);
			}
			//			path.push(runner);
			return path;
		}
		
		private function stepNext(monster:Point,current:WayDot45):WayDot45{
			var distMax:int=0;
			var next:WayDot45;
			for each(var n:WayDot45 in current.neighbors){
				var dist:int=FastMath.distP(monster,n.point);
				trace("nDist=",dist,this);
				if(dist>distMax){
					distMax=dist;
					next=n;
				}
			}
			return next;
		}
		
		public function rayDist(start:Point,end:Point):int{
			var bs:BhStrider=new BhStrider(start.x,start.y,end.x,end.y);
			var dist:int=0;
			while(true){
				var step:int=bs.stepForward(4);
				if(step<=0)
					break;
				
				if(zway.base.isRoad(bs.xNow,bs.yNow,true)){
					dist+=step;
				}else{
					break;
				}
			}
			return dist;
		}
		
		public function rayCast(start:Point,end:Point):Point{
			var path:Vector.<Point>=new Vector.<Point>();
			path.push(start.clone());
			//			var result:Point=start.clone();
			var bs:BhStrider=new BhStrider(start.x,start.y,end.x,end.y);
			var interrupt:Boolean;
			while(bs.stepForward(4)>0){
				if(zway.base.isRoad(bs.xNow,bs.yNow,true)){
					//					result.x=bs.xNow;
					//					result.y=bs.yNow;
					var step:Point=new Point(bs.xNow,bs.yNow);
					path.push(step);
				}else{
					interrupt=true;
					break;
				}
			}
			if(interrupt && path.length>1){
				path.pop();
			}
			//			var idx:int=5;
			//			if(path.length<5){
			//				idx=path.length/2;
			//			}
			//			path=path.splice(idx,1);
			return path.pop();
		}
		
		public function searchPath(start:Point,end:Point,smooth:int=2):Vector.<Point>{
			var path:Vector.<Point>=new Vector.<Point>();			
			if(canSee(start,end)){
				path.push(start,end);
				return path;
			}
			
			var startDot:WayDot45=zway.getStation(start.x,start.y);
			var endDot:WayDot45=zway.getStation(end.x,end.y);
			if(startDot==null || endDot==null)
				return null;
			
			//			trace("start dot: x=",startDot.x,"y=",startDot.y,"xy=",startDot.xy,this);
			
			var startFake:WayDot45=new WayDot45();
			startFake.x=start.x/scale;
			startFake.y=start.y/scale;
			startFake.neighborsExt.push(startDot);
			startDot.neighborsExt.push(startFake);
			
			var endFake:WayDot45=new WayDot45();
			endFake.x=end.x/scale;
			endFake.y=end.y/scale;
			endFake.neighborsExt.push(endDot);
			endDot.neighborsExt.push(endFake);
			
			
			if(path.length==0){
				path=wayPointAstar(startFake,endFake);
				startDot.neighborsExt.removeAt(startDot.neighborsExt.indexOf(startFake));
				endDot.neighborsExt.removeAt(endDot.neighborsExt.indexOf(endFake));
				if(path==null)
					return null;
				for each(var p:Point in path){
					p.x=p.x*scale+scale/2;
					p.y=p.y*scale+scale/2;
				}
				
				path.shift();
				path.unshift(start);
				path.pop();
				path.push(end);
				
				removeDummySE(path);
				for(var i:int=0;i<smooth;i++){
					cutSharp(path);			
					//					removeDummy(path);
				}
			}
			return path;
		}
		
		private function wayPointAstar(start:WayDot45,end:WayDot45):Vector.<Point>{
			
			//translate to point list
			var path:Vector.<AStarI3>=AStar3.search(start,end);
			if(path==null)
				return null;
			
			var walkPath:Vector.<Point>=new Vector.<Point>();
			for each(var p:WayDot45 in path){
				walkPath.push(p.point);
			}
			
			//			walkPath.unshift(startDot.point);
			//			walkPath.push(endDot.point);
			
			return walkPath;
		}
		
		public function canSee(start:Point,end:Point):Boolean{
			var bs:BhStrider=new BhStrider(start.x,start.y,end.x,end.y);
			var block:Boolean;
			//			var stride:int=8/scale;
			while(bs.stepForward(1)>0){
				if(!zway.base.isRoad(bs.xNow,bs.yNow,true)){
					block=true;
					break;
				}
			}
			return !block;
		}
		
		
		private function cutSharp(path:Vector.<Point>):Boolean{
			if(path.length<=2)
				return false;
			
			var mod:Boolean=false;
			
			for(var i:int=1;i<path.length-1;i++){
				
				var angle:int=FastMath.p3ToAngle(path[i-1],path[i],path[i+1]);
				if(angle>150)
					continue;
				
				var mid1:Point=new Point();
				var mid2:Point=new Point();
				
				var dist1:int=FastMath.distP(path[i-1],path[i]);
				var dist2:int=FastMath.distP(path[i],path[i+1]);
				var diff:Number=(dist1>dist2)?dist2/dist1:dist1/dist2;
				if(diff<0.5){
					if(dist1<dist2){
						mid2.x=path[i].x*(1-diff)+path[i+1].x*diff;
						mid2.y=path[i].y*(1-diff)+path[i+1].y*diff;
						if(canSee(path[i-1],mid2)){
							path[i]=mid2;
							i--;
							continue;
						}
					}else{
						mid1.x=path[i].x*(1-diff)+path[i-1].x*diff;
						mid1.y=path[i].y*(1-diff)+path[i-1].y*diff;
						if(canSee(path[i+1],mid1)){
							path[i]=mid1;
							i--;
							continue;
						}
					}
				}
				
				mid1.x=(path[i-1].x+path[i].x)/2;
				mid1.y=(path[i-1].y+path[i].y)/2;
				mid2.x=(path[i].x+path[i+1].x)/2;
				mid2.y=(path[i].y+path[i+1].y)/2;
				
				if(canSee(mid1,mid2)){
					path[i]=mid1;
					path.insertAt(i+1,mid2);
					if(dist1<dist2)
						removeDummyAt(path,i);
					else
						removeDummyAt(path,i+1);
					//					i++;
					continue;
				}
				
				if(angle>120)
					continue;
				
				mid1.x=(path[i-1].x+path[i].x*3)/4;
				mid1.y=(path[i-1].y+path[i].y*3)/4;
				mid2.x=(path[i].x*3+path[i+1].x)/4;
				mid2.y=(path[i].y*3+path[i+1].y)/4;
				
				if(canSee(mid1,mid2)){
					path[i]=mid1;
					path.insertAt(i+1,mid2);
					if(dist1<dist2)
						removeDummyAt(path,i);
					else
						removeDummyAt(path,i+1);
					//					i++;
					continue;
				}
				
			}
			return mod;
		}
		
		private function removeDummyAt(path:Vector.<Point>,idx:int):Boolean{
			if(idx<1 && idx>path.length-2)
				return false;
			
			if(canSee(path[idx-1],path[idx+1])){
				path.splice(idx,1);
				return true;
			}
			
			return false;
		}
		
		private function removeDummySE(path:Vector.<Point>):void{
			
			var anyMod:Boolean=false;
			var mod:Boolean=true;
			while(mod){
				mod=removeDummyAt(path,1);				
			}
			
			mod=true;
			while(mod){
				mod=removeDummyAt(path,path.length-2);					
			}
			
		}
	}
}
