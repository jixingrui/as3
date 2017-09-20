package azura.common.algorithm
{
	import azura.common.algorithm.crypto.CRC32;
	import azura.common.graphics.Point3;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	public class FastMath
	{
		
		public static function zeroPad(number:int, width:int=10):String {
			var ret:String = ""+number;
			while( ret.length < width )
				ret="0" + ret;
			return ret;
		}
		
		public static function roundByChance(raw:Number):int{
			var int_:int=raw;
			var small_:Number=raw-int_;
			var result:int=int_;
			if(Math.random()<small_)
				result+=1;
			return result;
		}
		
		public static function pow2x(x:int):int {
			if(x>=0)
				return ~(-1 << x)+1;
			else
				return 0;
		}	
		
		public static function hashCode(s:String):int{
			var result:int;
			for(var i:int=0;i<s.length;i++){
				result+=s.charCodeAt(i)*31^(s.length-i-1);
			}
			return result;
		}
		
		public static function hashColor(s:String):uint{
			var data:ByteArray=new ByteArray();
			data.writeUTF(s);
			var crc32:uint=CRC32.compute(data);
			return crc32;
		}
		
		/**
		 * 
		 * @return [0,359] 0=up
		 * 
		 */
		public static function xy2Angle(dx:Number,dy:Number):Number{			
			var rad:Number=Math.atan2(dy,dx);
			var angle:Number=radian2angle(rad);
			angle=(angle+90+360)%360;
			//			trace(dx+','+dy+' ='+angle);
			return angle;
		}
		
		/**
		 * 
		 * @param angle [0,359] 0=up
		 * 
		 */
		public static function angle2Xy(angle:int,r:int=1000):Point{
			angle=(angle-90+360)%360;;
			var rad:Number=angle2radian(angle);
			var result:Point=new Point();
			result.x=r*cos(rad);
			result.y=r*sin(rad);
			return result;
		}
		
		public static function p3ToAngle(left:Point,center:Point,right:Point):int{
			var angle1:int=xy2Angle(left.x-center.x,left.y-center.y);
			var angle2:int=xy2Angle(right.x-center.x,right.y-center.y);
			var delta:int= Math.abs(angle1-angle2);
			if(delta>180)
				delta=360-delta;
			return delta;
		}
		
		public static function sign(n:Number):int
		{
			return (n < 0) ? -1 : 1;
		}
		
		public static function distP(p1:Point,p2:Point):Number{
			return Math.sqrt(Math.pow(p1.x-p2.x,2)+Math.pow(p1.y-p2.y,2));
		}
		
		public static function dist(x1:Number,y1:Number,x2:Number,y2:Number):Number{
			return Math.sqrt(Math.pow(x1-x2,2)+Math.pow(y1-y2,2));
		}
		
		public static function angle2radian(degree:Number):Number{
			return Math.PI*degree/180;
		}
		
		public static function radian2angle(radian:Number):Number{
			return 180*radian/Math.PI;
		}
		
		/**
		 * 
		 * @param tilt in degrees
		 * @param pan in degrees
		 * @param radius
		 * @return xyz
		 * 
		 */
		public static function tprToxyz(tilt:Number,pan:Number,radius:Number):Point3{
			
			var t:Number=FastMath.angle2radian(tilt);
			var p:Number=FastMath.angle2radian(pan);
			
			var result:Point3=new Point3();
			result.x=radius*cos(t)*sin(p);
			result.y=-radius*sin(t);
			result.z=radius*cos(t)*cos(p);
			
			return result;
		}
		
		//		public static function xyzTotpr(x:Number,y:Number,z:Number):Point3{
		//			
		//			return result;
		//		}
		
		/**
		 * 
		 * @param from inclusive
		 * @param to exclusive
		 * 
		 */
		public static function random(from:int,to:int):int{
			to=Math.max(from+1,to);
			var seed:Number=Math.random();
			return seed*int.MAX_VALUE%(to-from)+from;
		}
		
		public static function log2(input:Number):int{
			if(input<=0){
				return 0;
			}else if((input&(input-1))==0){
				var a:int=0;
				while(input>1){input>>=1; ++a;}
				return a;
			}else{
				return Math.log(input)*Math.LOG2E;
			}
		}
		
		/**
		 * @param target
		 * @param min
		 *            inclusive
		 * @param max
		 *            exclusive
		 * @return bounded target
		 */
		public static function bound(target:int, min:int , max:int ):int {
			target = Math.max(target, min);
			target = Math.min(target, max - 1);
			return target;
		}
		
		public static function midPoint(one:Point,two:Point):Point{
			var mid:Point=new Point();
			mid.x=(one.x+two.x)/2;
			mid.y=(one.y+two.y)/2;
			return mid;
		}
		
		/**
		 * 
		 * @return hit point or null
		 * 
		 */
		public static function lineToRectangleHit(xStart:int,yStart:int,xEnd:int,yEnd:int,rect:Rectangle):Point{
			
			var p:Array = [xStart-xEnd, xEnd-xStart, yStart-yEnd, yEnd-yStart];
			var q:Array = [xStart - rect.left, rect.right - xStart, yStart - rect.bottom, rect.top - yStart];
			var u1:int = int.MIN_VALUE;
			var u2:int = int.MAX_VALUE;
			
			for (var i:int=0;i<=4;i++) {
				if (p[i] == 0) {
					if (q[i] < 0)
						return null;
				}
				else {
					var t:Number = q[i] / p[i];
					if (p[i] < 0 && u1 < t)
						u1 = t;
					else if (p[i] > 0 && u2 > t)
						u2 = t;
				}
			}
			
			if (u1 > u2 || u1 > 1 || u1 < 0)
				return null;
			
			var collision:Point=new Point();
			collision.x = xStart + u1*(xEnd-xStart);
			collision.y = yStart + u1*(yEnd-yStart);
			
			return collision;
		}
		
		public static function rotatePoint(xAxis:Number,yAxis:Number,x:Number,y:Number,rad:Number):Point{
			var p:Point=new Point();
			var sin:Number=sin(rad);
			var cos:Number=cos(rad);
			p.x=(x-xAxis)*cos +(y-yAxis)*sin+xAxis; 
			p.y=-(x-xAxis)*sin + (y-yAxis)*cos+yAxis;
			return p;
		}
		
		public static function rotateRectangle(axis:Point,rect:Rectangle,rad:Number):Rectangle{
			var p1:Point=rotatePoint(axis.x,axis.y,rect.left,rect.top,rad);
			var p2:Point=rotatePoint(axis.x,axis.y,rect.left,rect.bottom,rad);
			var p3:Point=rotatePoint(axis.x,axis.y,rect.right,rect.top,rad);
			var p4:Point=rotatePoint(axis.x,axis.y,rect.right,rect.bottom,rad);
			
			var result:Rectangle=new Rectangle();
			result.x=Math.min(p1.x,p2.x,p3.x,p4.x);
			result.right=Math.max(p1.x,p2.x,p3.x,p4.x);
			result.y=Math.min(p1.y,p2.y,p3.y,p4.y);
			result.bottom=Math.max(p1.y,p2.y,p3.y,p4.y);
			
			return result;
		}
		
		public static function isoToNormal(x:Number, y:Number):Point {
			var flat:Point= new Point();
			var atan:Number= Math.atan2(y, x);
			flat.x = Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2)) * cos(atan);
			flat.y = Math.sqrt((Math.pow(x, 2) + Math.pow(y, 2)) / 2) * sin(atan);
			return flat;
		}
		
		
		public static function normalToIso(x:Number,y:Number):Point {
			var top:Point= new Point();
			var atan:Number= Math.atan2(y * 1.414, x);
			top.x = Math.sqrt(Math.pow(x, 2) + 2 * Math.pow(y, 2)) * cos(atan);
			top.y = Math.sqrt(Math.pow(x, 2) + 2 * Math.pow(y, 2)) * sin(atan);
			return top;
		}
		
		public static function sin(x:Number):Number{
			//1.27323954  = 4/pi
			//0.405284735 =-4/(pi^2)

			//always wrap input angle to -PI..PI
			if (x < -3.14159265)
				x += 6.28318531;
			else
				if (x >  3.14159265)
					x -= 6.28318531;
			
			//compute sine
			if (x < 0)
				return 1.27323954 * x + .405284735 * x * x;
			else
				return 1.27323954 * x - 0.405284735 * x * x;
		}
		
		public static function cos(x:Number):Number{
			//1.27323954  = 4/pi
			//0.405284735 =-4/(pi^2)
			
			//always wrap input angle to -PI..PI
			if (x < -3.14159265)
				x += 6.28318531;
			else
				if (x >  3.14159265)
					x -= 6.28318531;
			
			//compute cosine: sin(x + PI/2) = cos(x)
			x += 1.57079632;
			if (x >  3.14159265)
				x -= 6.28318531;
			
			if (x < 0)
				return 1.27323954 * x + 0.405284735 * x * x;
			else
				return 1.27323954 * x - 0.405284735 * x * x;
		}
		
	}
}