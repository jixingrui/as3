package azura.common.algorithm {
	import flash.geom.Point;
	
	public class Hexagon2 {
		
		private static var sqrt2:Number= Math.sqrt(2);
		private static var sqrt3:Number= Math.sqrt(3);
		
		/**
		 * 
		 * @param n=0-5
		 * 
		 */
		public static function top2flat(x:Number, y:Number, n:int):Point {
			
			var atan:Number= 0;
			if (x == 0&& y == 0) {
				return new Point(0, 0);
			} else if (x == 0&& y > 0) {
				atan = Math.PI / 2;
			} else if (x == 0&& y < 0) {
				atan = Math.PI / 2* 3;
			} else {
				atan = Math.atan2(y, x);
			}
			
			var upn:Number= Math.sqrt(x * x + y * y) * Math.cos(atan - n * Math.PI / 3);
			var vpn:Number= Math.sqrt(x * x + y * y) * Math.sin(atan - n * Math.PI / 3) / sqrt2;
			
			return new Point(upn, vpn);
		}
		
		/**
		 * 
		 * flat and center
		 * @param n [0,360)
		 * 
		 */
		public static function flat2top(u:Number, v:Number,  n:int):Point {
			
			var atan:Number= 0;
			if (u == 0&& v == 0) {
				return new Point(0, 0);
			} else if (u == 0&& v > 0) {
				atan = Math.PI / 2;
			} else if (u == 0&& v < 0) {
				atan = Math.PI / 2* 3;
			} else {
				atan = Math.atan2(sqrt2 * v, u);
			}
			
			var x:Number= Math.sqrt(u * u + 2* v * v) * Math.cos(atan + n * Math.PI / 3);
			var y:Number= Math.sqrt(u * u + 2* v * v) * Math.sin(atan + n * Math.PI / 3);
						
			return new Point(x, y);
			
		}
		
	}
}