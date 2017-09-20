package azura.common.algorithm {	
	import azura.common.collections.RectC;
	
	import flash.geom.Rectangle;
	
	public class FoldIndex {
		private static const zMax:int = 15;
		
		public  var fi:int;
		public  var x:int;
		public  var y:int;
		public  var z:int;
		public  var xp:int;
		public  var yp:int;
		
		function FoldIndex(fi:int,x:int,y:int,z:int,xp:int,yp:int){
			this.fi=fi;
			this.x=x;
			this.y=y;
			this.z=z;
			this.xp=xp;
			this.yp=yp;
		}
		
		public static function fromXyz(x:int, y:int, z:int):FoldIndex {
			var side:int = sideLength(z);
			var xp:int = x + side / 2;
			var yp:int = y + side / 2;
			
			var fi:int = 1 << (z * 2);
			fi |= xp << z;
			fi |= yp;
			
			if (z < 0 || z > zMax || xp < 0 || xp > side || yp < 0 || yp > side)
				return null;
			else
				return new FoldIndex(fi, x, y, z, xp, yp);
		}
		
		public static function fromFi(fi:int):FoldIndex{
			if (fi <= 0)
				return null;
			
			var z:int = FastMath.log2(fi) >>> 1;
			var mask:int = FastMath.pow2x(z) - 1;
			var xp:int = (fi >>> z) & mask;
			var yp:int = fi & mask;
			
			var side:int = sideLength(z);
			var x:int = xp - side / 2;
			var y:int = yp - side / 2;
			return new FoldIndex(fi, x, y, z, xp, yp); 
		}
		
		public static function getZ(fi:int):int {
			return (31- numberOfLeadingZeros(fi)) >>> 1;
		}
		
		public static function divide(num:int, div:int):int {
			if (num >= 0)
				return num / div;
			else
				return (num + 1) / div - 1;
		}
		public static function mod(x:int, m:int):int {
			if (m <= 0) {
				throw new Error();
			}
			var result:int = x % m;
			return (result >= 0) ? result : result + m;
		}
		
		public static function getChamberCount(maxLevel:int):int {
			maxLevel &= 0xf;
			return -1>>> (31- maxLevel * 2);
		}
		
		public static function getUp(fi:FoldIndex):FoldIndex {
			if(fi.z<1)
				return null;
			
			//			var z:int=fi.z-1;
			//			var side:int=FoldIndex.sideLength(z);
			//			var x:int=fi.xp/2-side/2;
			//			var y:int=fi.yp/2-side/2;
			var up:FoldIndex = fromXyz(divide(fi.x,2),divide(fi.y,2),fi.z-1);
			//			trace(fi,"->",up);
			return up;
		}
		
		public static function getLow4(fi:FoldIndex):Vector.<FoldIndex> {
			//todo: side is suspicious here
			var z:int=fi.z+1;
			var side:int=FoldIndex.sideLength(z);
			var x:int=fi.xp*2-side/2;
			var y:int=fi.yp*2-side/2;
			
			var result:Vector.<FoldIndex>= new Vector.<FoldIndex>();
			result[0] = fromXyz(x, y, z);
			result[1] = fromXyz(x+1, y, z);
			result[2] = fromXyz(x, y+1, z);
			result[3] = fromXyz(x+1, y+1, z);
			return result;
		}
		
		//		public static function isUpper(upper:int, lower:int):Boolean {
		////			var xylUpper:Vector.<int>= getXyz(upper);
		////			var xylLower:Vector.<int>= getXyz(lower);
		//			var dl:int= xylLower[2] - xylUpper[2];
		//			if (dl > 0&& xylUpper[0] == xylLower[0] >>> dl && xylUpper[1] == xylLower[1] >>> dl) {
		//				return true;
		//			} else {
		//				return false;
		//			}
		//		}
		private static function numberOfLeadingZeros(i:int):int {
			if (i == 0)
				return 32;
			var n:int = 1;
			if (i >>> 16 == 0) { n += 16; i <<= 16; }
			if (i >>> 24 == 0) { n +=  8; i <<=  8; }
			if (i >>> 28 == 0) { n +=  4; i <<=  4; }
			if (i >>> 30 == 0) { n +=  2; i <<=  2; }
			n -= i >>> 31;
			return n;
		}
		
		/**
		 * 
		 * @param viewRect center coordinate, on z
		 * @return fi in range
		 * 
		 */
		public static function covers(viewRect:Rectangle,z:int):Vector.<FoldIndex>{
			viewRect=viewRect.clone();
			var bound:int = sideLength(z);
			viewRect.x+=bound/2;
			viewRect.y+=bound/2;
			
			var left:int = FastMath.bound(viewRect.left, 0, bound);
			var right:int = FastMath.bound(viewRect.right, 0, bound);
			var top:int = FastMath.bound(viewRect.top, 0, bound);
			var bottom:int = FastMath.bound(viewRect.bottom, 0, bound);
			
			var result:Vector.<FoldIndex> = new Vector.<FoldIndex>();
			
			var x:int,y:int,fi:FoldIndex;
			for (x = left; x <= right; x++)
				for (y = top; y <= bottom; y++) {
					fi = FoldIndex.fromXyz(x-bound/2, y-bound/2, z);
					result.push(fi);
				}
			return result;
		}

		public static function covers2(viewRect:RectC,z:int):Vector.<FoldIndex>{
			viewRect=viewRect.clone();
			var bound:int = sideLength(z);
			viewRect.xc+=bound/2;
			viewRect.yc+=bound/2;
			
			var left:int = FastMath.bound(viewRect.left, 0, bound);
			var right:int = FastMath.bound(viewRect.right, 0, bound);
			var top:int = FastMath.bound(viewRect.top, 0, bound);
			var bottom:int = FastMath.bound(viewRect.bottom, 0, bound);
			
			var result:Vector.<FoldIndex> = new Vector.<FoldIndex>();
			
			var x:int,y:int,fi:FoldIndex;
			for (x = left; x <= right; x++)
				for (y = top; y <= bottom; y++) {
					fi = FoldIndex.fromXyz(x-bound/2, y-bound/2, z);
					result.push(fi);
				}
			return result;
		}
		/**
		 * @param z
		 *            [0,30]
		 * @return exclusive
		 */
		public static function sideLength(z:int):int {
			return FastMath.pow2x(z);
		}
		
		public function toString():String{
			return "(fi=" + fi + ",x=" + x + ",y=" + y + ",z=" + z + ")";
		}
	}
}