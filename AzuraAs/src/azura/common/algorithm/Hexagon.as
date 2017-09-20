package azura.common.algorithm {
	import flash.geom.Point;
	
	public class Hexagon {
		
		private static var sqrt2:Number= Math.sqrt(2);
		private static var sqrt3:Number= Math.sqrt(3);
		
		public static function inHex(x:Number, y:Number, w:Number, h:Number):Boolean {
			if (Math.abs(y - (h - 1) / 2) >= w * sqrt3 / 4) {
				return false;
			} else if (w / 2- Math.abs(x - (w - 1) / 2) > Math.abs(y - (h - 1) / 2) / sqrt3) {
				return true;
			} else {
				return false;
			}
		}
		
		public static function top2flat(x:Number, y:Number, w:Number, h:Number, n:int):Point {
			
			if (!inHex(x, y, w, h)) {
				return null;
			}
			
			var xd:Number= x - (w - 1) / 2;
			var yd:Number= y - (h - 1) / 2;
			
			var atan:Number= 0;
			if (xd == 0&& yd == 0) {
				return new Point(0, 0);
			} else if (xd == 0&& yd > 0) {
				atan = Math.PI / 2;
			} else if (xd == 0&& yd < 0) {
				atan = Math.PI / 2* 3;
			} else {
				atan = Math.atan2(yd, xd);
			}
			
			var upn:Number= Math.sqrt(xd * xd + yd * yd) * Math.cos(atan - n * Math.PI / 3);
			var vpn:Number= Math.sqrt(xd * xd + yd * yd) * Math.sin(atan - n * Math.PI / 3) / sqrt2;
			
			return new Point(Math.round(upn + (w - 1) / 2), Math.round(vpn + (h - 1) / 2));
		}
		
		public static function flat2top(u:Number, v:Number, w:Number, h:Number, n:int):Point {
			
			var ud:Number= u - (w - 1) / 2;
			var vd:Number= v - (h - 1) / 2;
			
			var atan:Number= 0;
			if (ud == 0&& vd == 0) {
				return new Point(0, 0);
			} else if (ud == 0&& vd > 0) {
				atan = Math.PI / 2;
			} else if (ud == 0&& vd < 0) {
				atan = Math.PI / 2* 3;
			} else {
				atan = Math.atan2(sqrt2 * vd, ud);
			}
			
			var xd:Number= Math.sqrt(ud * ud + 2* vd * vd) * Math.cos(atan + n * Math.PI / 3);
			var yd:Number= Math.sqrt(ud * ud + 2* vd * vd) * Math.sin(atan + n * Math.PI / 3);
			
			var x:int= Math.round(xd + (w - 1) / 2);
			var y:int= Math.round(yd + (h - 1) / 2);
			
			if (inHex(x, y, w, h)) {
				return new Point(x, y);
			} else {
				return null;
			}
			
		}
		
	}
}