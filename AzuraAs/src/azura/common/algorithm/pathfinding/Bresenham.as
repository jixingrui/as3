package azura.common.algorithm.pathfinding {
	import flash.geom.Point;	
	
	public class Bresenham {
		private var xNow:int, yNow:int, xEnd:int, yEnd:int;
		private var dx:int, dy:int, stepx:int, stepy:int, fraction:int, step:int, stepSize:int;
		
		public function Bresenham(xStart:int, yStart:int, xEnd:int, yEnd:int, stepSize:int=1) {
			this.xNow = xStart;
			this.yNow = yStart;
			this.xEnd = xEnd;
			this.yEnd = yEnd;
			dy = yEnd - yStart;
			dx = xEnd - xStart;
			stepSize = stepSize > 0? stepSize : 1;
			this.stepSize = stepSize;
			if (dy < 0) {
				dy = -dy;
				stepy = -1* stepSize;
			} else {
				stepy = 1* stepSize;
			}
			if (dx < 0) {
				dx = -dx;
				stepx = -1* stepSize;
			} else {
				stepx = 1* stepSize;
			}
			dy <<= 1;
			dx <<= 1;
			
			if (dx > dy)
				fraction = dy - (dx >> 1);
			else
				fraction = dx - (dy >> 1);
		}
		
		private function hasNext():Boolean {
			if (dx > dy)
				return xNow != xEnd;
			else
				return yNow != yEnd;
		}
		
		public function next():Point{
			if(!hasNext())
				return null;
			
			step += 2* stepSize;
			if (dx > dy) {
				if (fraction >= 0) {
					yNow += stepy;
					fraction -= dx;
				}
				xNow += stepx;
				fraction += dy;
				if (step >= dx) {
					xNow = xEnd;
					yNow = yEnd;
				}
			} else {
				if (fraction >= 0) {
					xNow += stepx;
					fraction -= dy;
				}
				yNow += stepy;
				fraction += dx;
				if (step >= dy) {
					xNow = xEnd;
					yNow = yEnd;
				}
			}
			
			return new Point(xNow, yNow);
		}
	}
}