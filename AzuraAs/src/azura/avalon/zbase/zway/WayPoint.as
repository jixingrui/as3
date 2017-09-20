package azura.avalon.zbase.zway
{
	import azura.common.algorithm.FastMath;
	
	import flash.geom.Point;
	
	public class WayPoint
	{
		public var me:Point;
		public var prev:WayPoint,next:WayPoint;
		public var angle:int=180;
		public var checked:Boolean;
		
		public function checkAngle():void{
			if(prev!=null&&next!=null)
				angle=FastMath.p3ToAngle(prev.me,me,next.me);
			
			checked=false;
		}
	}
}