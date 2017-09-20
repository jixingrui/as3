package azura.common.algorithm
{
	
	import flash.geom.Point;
	
	public class Neck
	{
		/**
		 * @param xy
		 *            center coordinate
		 * @param angle
		 *            [0,360)
		 * @return flat center coordinate
		 */
		public static function topToFlat(x:Number, y:Number, angle:Number=0):Point {
			var flat:Point= new Point();
			var arc:Number= FastMath.angle2radian(angle);
			var atan:Number= Math.atan2(y, x);
			flat.x = Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2)) * Math
				.cos(atan - arc);
			flat.y = Math.sqrt((Math.pow(x, 2) + Math.pow(y, 2)) / 2) * Math
				.sin(atan - arc);
			return flat;
		}
		
		
		/**
		 * @param xy
		 *            center coordinate
		 * @param angle
		 *            [0,360)
		 * @return top center coordinate
		 */
		public static function flatToTop(x:Number,y:Number, angle:Number=0):Point {
			var top:Point= new Point();
			var arc:Number= FastMath.angle2radian(angle);
			var atan:Number= Math.atan2(y * Math.sqrt(2), x);
			top.x = Math.sqrt(Math.pow(x, 2) + 2 * Math.pow(y, 2)) * Math
				.cos(atan + arc);
			top.y = Math.sqrt(Math.pow(x, 2) + 2 * Math.pow(y, 2)) * Math
				.sin(atan + arc);
			return top;
		}
		
		public static function tpToFc(x:Number,y:Number,bound:Number):Point{
			x-=bound/2;
			y-=bound/2;
			
			var f:Point=Neck.topToFlat(x,y,0);
			f.x=f.x*8;
			f.y=f.y*8;
			return f;
		}
		
		public static function fcToTp(x:Number,y:Number,bound:Number):Point{
			var f:Point=Neck.flatToTop(x/8,y/8,0);
			f.x+=bound/2;
			f.y+=bound/2;
			f.x=Math.round(f.x);
			f.y=Math.round(f.y);
			return f;
		}
		
		public static function tcToFc(x:Number,y:Number,bound:Number):Point{
			return new Point(x-bound/2,y-bound/2);
		}
		
		public static function tpToTc(x:Number,y:Number,bound:Number):Point{
			return new Point(x-bound/2,y-bound/2);
		}
		
		public static function tcToTp(x:Number,y:Number,bound:Number):Point{
			return new Point(x+bound/2,y+bound/2);
		}
	}
}