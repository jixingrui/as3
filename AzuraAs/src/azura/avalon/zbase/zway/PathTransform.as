package azura.avalon.zbase.zway
{
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.pathfinding.BhStrider;
	
	import flash.geom.Point;

	public class PathTransform
	{
		
		public static  function fatten(source:Vector.<Point>,step:int):Vector.<Point>{
			var fat:Vector.<Point>=new Vector.<Point>();
			var current:Point;
			var next:Point;
			for each(next in source){
				if(current==null){
					current=next;
					fat.push(current);
					continue;
				}
				
				var stride:int=FastMath.dist(current.x,current.y,next.x,next.y)/2;
				while(stride>step){
					stride*=0.75;
				}
				var bs:BhStrider=new BhStrider(current.x,current.y,next.x,next.y);
				while(bs.stepForward(stride)>0){
					var dist:int=FastMath.dist(bs.xNow,bs.yNow,bs.xDest,bs.yDest);
					if(dist>stride/4)
						fat.push(new Point(bs.xNow,bs.yNow));
				}
				current=next;
				fat.push(current);
			}
			return fat;
		}
	}
}