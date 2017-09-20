package azura.common.algorithm.pathfinding
{
	import azura.common.algorithm.FastMath;
	
	import flash.geom.Point;
	
	public class CopyofLineMover
	{		
		public var xNow:Number=0, yNow:Number=0;
		public var xDest:Number=0, yDest:Number=0;
		private var sealed:Boolean;
		
		public function CopyofLineMover(xFrom:int=0,yFrom:int=0)
		{
			xNow=xFrom;
			yNow=yFrom;
		}
		public function walkTo(x:Number,y:Number):void{
			xDest=x;
			yDest=y;
			sealed=false;
		}
		
		//		public function get angle():int{
		//			var a:int=FastMath.xy2Angle(xDest-xNow,yDest-yNow);
		//			return a;
		//		}
		
		public function get dist():int{
			return Math.sqrt(Math.pow((xDest-xNow),2)+Math.pow((yDest-yNow),2));
		}
		
		public function jumpTo(x:Number,y:Number):void{
			xNow=xDest=x;
			yNow=yDest=y;
			sealed=false;
		}
		
		public function next():Point
		{			
			if(xDest==xNow&&yDest==yNow){
				if(sealed)
					return null;
				else{
					sealed=true;
					return new Point(xDest,yDest);
				}
			}
			
			//x
			var dx:Number=xDest - xNow;
			var sx:Number=FastMath.sign(dx);
			var bx:Number=Math.abs(dx);
			if (bx > 1)
			{
				//				xNow+=sx * Math.pow(bx,1/3);
				var stepX:Number=Math.min(8,Math.sqrt(bx));
				xNow+=sx * stepX;
			}
			else
			{
				xNow=xDest;
			}
			
			//y
			var dy:Number=yDest - yNow;
			var sy:Number=FastMath.sign(dy);
			var by:Number=Math.abs(dy);
			if (by > 1)
			{
				//				yNow+=sy * Math.pow(by,1/3);
				var stepY:Number=Math.min(8,Math.sqrt(by));
				yNow+=sy * stepY;
			}
			else
			{
				yNow=yDest;
			}
			return new Point(xNow,yNow);
		}
	}
}