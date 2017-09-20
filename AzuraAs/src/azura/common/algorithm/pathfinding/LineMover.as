package azura.common.algorithm.pathfinding
{
	import azura.common.algorithm.FastMath;
	
	import flash.geom.Point;
	
	public class LineMover
	{		
		public var xNow:Number=0, yNow:Number=0;
		public var xDest:Number=0, yDest:Number=0;
		private var sealed:Boolean;
		public var speed:Number=4;
		
		public function LineMover(xFrom:int=0,yFrom:int=0)
		{
			xNow=xFrom;
			yNow=yFrom;
		}
		public function walkTo(x:Number,y:Number):void{
			xDest=x;
			yDest=y;
			sealed=false;
		}
		
		public function get moving():Boolean{
			return xNow!=yDest||yNow!=yDest;
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
			//y
			var dy:Number=yDest - yNow;
			var sy:Number=FastMath.sign(dy);
			var by:Number=Math.abs(dy);
			
			var stepX:Number;
			var stepY:Number;
			
			if(bx>by){
				stepX=Math.min(speed,Math.sqrt(bx));
				stepY=stepX*by/bx;
			}else{
				stepY=Math.min(speed,Math.sqrt(by));
				stepX=stepY*bx/by;
			}
			
			xNow+=sx*stepX;
			yNow+=sy*stepY;
			
			if(Math.abs(xDest-xNow)<=1)
				xNow=xDest;
			if(Math.abs(yDest-yNow)<=1)
				yNow=yDest;
			
			return new Point(xNow,yNow);
		}
	}
}