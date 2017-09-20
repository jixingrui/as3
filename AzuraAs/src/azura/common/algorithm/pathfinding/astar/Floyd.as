package azura.common.algorithm.pathfinding.astar
{
	
	import flash.geom.Point;

	public class Floyd
	{
		private var map:AstarMapI;
		
		public function Floyd(map:AstarMapI){
			this.map=map;
		}
		
		public function compact(path:Vector.<Point>):Vector.<Point> {
			if (path == null)
				return null;
			
			var _floydPath:Vector.<Point> = path.concat();
			var len:int = _floydPath.length;
			if (len > 2){
				var vector:Point = new Point(0, 0);
				var tempVector:Point = new Point(0, 0);
				floydVector(vector, _floydPath[len - 1], _floydPath[len - 2]);
				for (var i:int = _floydPath.length - 3; i >= 0; i--){
					floydVector(tempVector, _floydPath[i + 1], _floydPath[i]);
					if (vector.x == tempVector.x && vector.y == tempVector.y){
						_floydPath.splice(i + 1, 1);
					} else {
						vector.x = tempVector.x;
						vector.y = tempVector.y;
					}
				}
			}
			len = _floydPath.length;
			for (i = len - 1; i >= 0; i--){
				for (var j:int = 0; j <= i - 2; j++){
					if (floydCrossAble(_floydPath[i], _floydPath[j])){
						for (var k:int = i - 1; k > j; k--){
							_floydPath.splice(k, 1);
						}
						i = j;
						len = _floydPath.length;
						break;
					}
				}
			}
			return _floydPath;
		}
		
		private function floydCrossAble(n1:Point, n2:Point):Boolean {
			var ps:Vector.<Point> = bresenhamPoints(new Point(n1.x, n1.y), new Point(n2.x, n2.y));
			for (var i:int = ps.length - 2; i > 0; i--){
//				if (ps[i].x>=0&&ps[i].y>=0&&ps[i].x<map.width&&ps[i].y<map.height&&!map.isRoad(ps[i].x,ps[i].y)) {
				if(!map.isRoad(ps[i].x,ps[i].y)){
//					trace("not road");
					return false;
				}
			}
			return true;
		}
		
		private function bresenhamPoints(p1:Point, p2:Point):Vector.<Point> {
			var steep:Boolean = Math.abs(p2.y - p1.y) > Math.abs(p2.x - p1.x);
			if (steep) {
				var temp:int = p1.x;
				p1.x = p1.y;
				p1.y = temp;
				temp = p2.x;
				p2.x = p2.y;
				p2.y = temp;
			}
			var stepX:int = p2.x > p1.x?1:(p2.x < p1.x? -1:0);
			var deltay:Number = (p2.y - p1.y)/Math.abs(p2.x-p1.x);
			var ret:Vector.<Point> = new Vector.<Point>();
			var nowX:Number = p1.x + stepX;
			var nowY:Number = p1.y + deltay;
			if (steep) {
				ret.push(new Point(p1.y,p1.x));
			}else {
				ret.push(new Point(p1.x,p1.y));
			}
			if (Math.abs(p1.x - p2.x) == Math.abs(p1.y - p2.y)) {
				if(p1.x<p2.x&&p1.y<p2.y){
					ret.push(new Point(p1.x, p1.y + 1), new Point(p2.x, p2.y - 1));
				}else if(p1.x>p2.x&&p1.y>p2.y){
					ret.push(new Point(p1.x, p1.y - 1), new Point(p2.x, p2.y + 1));
				}else if(p1.x<p2.x&&p1.y>p2.y){
					ret.push(new Point(p1.x, p1.y - 1), new Point(p2.x, p2.y + 1));
				}else if(p1.x>p2.x&&p1.y<p2.y){
					ret.push(new Point(p1.x, p1.y + 1), new Point(p2.x, p2.y - 1));
				}
			}
			while (nowX != p2.x) {
				var fy:int=Math.floor(nowY)
				var cy:int = Math.ceil(nowY);
				if (steep) {
					ret.push(new Point(fy, nowX));
				}else{
					ret.push(new Point(nowX, fy));
				}
				if (fy != cy) {
					if (steep) {
						ret.push(new Point(cy,nowX));
					}else{
						ret.push(new Point(nowX, cy));
					}
				}else if(deltay!=0){
					if (steep) {
						ret.push(new Point(cy+1,nowX));
						ret.push(new Point(cy-1,nowX));
					}else{
						ret.push(new Point(nowX, cy+1));
						ret.push(new Point(nowX, cy-1));
					}
				}
				nowX += stepX;
				nowY += deltay;
			}
			if (steep) {
				ret.push(new Point(p2.y,p2.x));
			}else {
				ret.push(new Point(p2.x,p2.y));
			}
			return ret;
		}
		
		private function floydVector(target:Point, n1:Point, n2:Point):void {
			target.x = n1.x - n2.x;
			target.y = n1.y - n2.y;
		}
	}
}