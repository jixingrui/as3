package azura.common.algorithm.pathfinding {
	
	
	public class BhStrider {
		private var _xNow:int, _yNow:int, _xDest:int, _yDest:int;
		private var dx:int, dy:int, stepx:int, stepy:int, fraction:int;
		
		public function get yDest():int
		{
			return _yDest;
		}

		public function get xDest():int
		{
			return _xDest;
		}

		public function get yNow():int
		{
			return _yNow;
		}
		
		public function get xNow():int
		{
			return _xNow;
		}
		
		public function BhStrider(xStart:int, yStart:int, xEnd:int, yEnd:int){
			this._xNow = xStart;
			this._yNow = yStart;
			this._xDest = xEnd;
			this._yDest = yEnd;
			dy = yEnd - yStart;
			dx = xEnd - xStart;
			if (dy < 0) {
				dy = -dy;
				stepy = -1;
			} else {
				stepy = 1;
			}
			if (dx < 0) {
				dx = -dx;
				stepx = -1;
			} else {
				stepx = 1;
			}
			dy <<= 1;
			dx <<= 1;
			
			if (dx > dy)
				fraction = dy - (dx >> 1);
			else
				fraction = dx - (dy >> 1);
		}
		
		/**
		 * @return passed. >0 means going
		 */
		public function stepForward(stride:int):int {
			var passed:int = -1;
			if (dx > dy) {
				while (++passed < stride && xNow != xDest) {
					if (fraction >= 0) {
						_yNow += stepy;
						fraction -= dx;
					}
					_xNow += stepx;
					fraction += dy;
				}
			} else {
				while (++passed < stride && _yNow != yDest) {
					if (fraction >= 0) {
						_xNow += stepx;
						fraction -= dy;
					}
					_yNow += stepy;
					fraction += dx;
				}
			}
			return passed;
		}
	}
}