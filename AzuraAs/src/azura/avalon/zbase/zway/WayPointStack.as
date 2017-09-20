package azura.avalon.zbase.zway
{
	import azura.common.algorithm.FastMath;
	
	import flash.geom.Point;
	
	
	public class WayPointStack
	{
		public static var threshold:int=179;
		public var canSee:CanSeeI;
		public var stack:Vector.<WayPoint>;
		
		public var scale:int;
		
		public static function load(seer:CanSeeI,path:Vector.<Point>,scale:int):Vector.<Point>{
			var wps:WayPointStack=new WayPointStack();
			wps.canSee=seer;
			wps.scale=scale;
			return wps.load_(path);
		}
		
		private function load_(path:Vector.<Point>):Vector.<Point>{
			
			//validate upstream
			if(path.length<2)
				throw new Error();
			
			//init
			stack=new Vector.<WayPoint>();
			var start:WayPoint=new WayPoint();
			start.me=path[0];			
			var current:WayPoint=start;
			stack.push(current);
			
			//load
			for(var i:int=1;i<path.length;i++){
				current.next=new WayPoint();
				current.next.prev=current;
				current=current.next;
				stack.push(current);
				
				current.me=path[i];
				current.prev.checkAngle();
			}
			
			//smooth
			stack.sort(angleSort);
			var changed:Boolean=process();
			while(changed){
				changed=process();
			}
			
			//debug
//			for each(var wp:WayPoint in stack){
//				trace("angle=",wp.angle,this);
//			}
			
			//output
			path=new Vector.<Point>();
			current=start;
			while(current!=null){
				path.push(current.me);
				current=current.next;
			}
			
			return path;
		}
		
		private function process():Boolean{
			var changed:Boolean=false;
			for(var i:int=0;i<stack.length;i++){
				var target:WayPoint=stack[i];
				//				trace("angle=",target.angle,this);
				//terminal is filtered out
				if(target.checked||target.angle>threshold)
					continue;
				
				if(canSee.canSee(target.prev.me,target.next.me)){
					target.prev.next=target.next;
					target.next.prev=target.prev;
					target.prev.checkAngle();
					target.next.checkAngle();
					stack.splice(i,1);
					stack.sort(angleSort);
					changed=true;
				}else if(target.angle<145){
					var distPrev:int=FastMath.dist(target.me.x,target.me.y,target.prev.me.x,target.prev.me.y);
					if(distPrev>(64/scale)){
						var midPrev:Point=FastMath.midPoint(target.me,target.prev.me);
						insert(target.prev,midPrev,target);
						target.checked=false;
						changed=true;
					}
					var distNext:int=FastMath.dist(target.me.x,target.me.y,target.next.me.x,target.next.me.y);
					if(distNext>(64/scale)){
						var midNext:Point=FastMath.midPoint(target.me,target.next.me);
						insert(target,midNext,target.next);
						target.checked=false;
						changed=true;
					}
					
				}else{
					target.checked=true;
				}
				if(changed)
					break;
			}
			return changed;
		}
		
		private function insert(prev:WayPoint,ins:Point,next:WayPoint):void{
			var mid:WayPoint=new WayPoint();
			mid.me=ins;
			mid.prev=prev;
			mid.next=next;
			prev.next=mid;
			next.prev=mid;
			stack.push(mid);
			//			stack.sort(angleSort);
		}
		
		private function angleSort(one:WayPoint,two:WayPoint):int{
			if(one.angle>two.angle){
				return 1;
			}else if(one.angle<two.angle){
				return -1;
			}else{
				return 0;
			}
		}
	}
}