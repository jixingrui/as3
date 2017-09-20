package azura.avalon.fi
{
	import azura.common.algorithm.FoldIndex;
	
	import flash.utils.Dictionary;
	
	public class PyramidFi
	{
		public var zMax:int=-1;
		public var tileSide:int=512;
		protected var fi_TileFi:Dictionary=new Dictionary();
		
		public function getTile(x:int,y:int,z:int):TileFi{
			if (z < 0 || z > zMax)
				return null;
			
			if (z == 0) {
				
				if (x >= -tileSide / 2 && x <= tileSide / 2 - 1
					&& y >= -tileSide / 2 && y <= tileSide / 2 - 1)
					return getTile_(1);
				else
					return null;
			} else {
				var dx:int = FoldIndex.divide(x, tileSide);
				var dy:int = FoldIndex.divide(y, tileSide);
				var fi:FoldIndex = FoldIndex.fromXyz(dx, dy, z);
				if (fi != null)
					return getTile_(fi.fi);
				else
					return null;
			}
		}
		
		public function getTile_(fi:int):TileFi {
			var result:TileFi = fi_TileFi[fi];
			if (result == null) {
				result = createTile(fi);
				fi_TileFi[fi] = result;
			}
			return result;
		}
		
		protected function globalToTile(xy:int, z:int):int {
			if (z == 0) {
				return xy + tileSide / 2;
			} else {
				var result:int = xy % tileSide;
				return (result >= 0) ? result : result + tileSide;
			}
		}
		
		internal function getUpper(fi:FoldIndex):TileFi{
			var upper:FoldIndex=FoldIndex.getUp(fi);
			if(upper==null)
				return null;
			else
				return fi_TileFi[upper.fi];
		}
		
		public function get bound():int{
			return FoldIndex.sideLength(zMax);
		}
		
		//		public function getLower4(fi:int):Vector.<TileFi>{
		//			var result:Vector.<TileFi>=new Vector.<TileFi>();
		//			for each(var fiLower:int in FoldIndex.getLower4(fi)){
		//				result.push(getTile_(fiLower));
		//			}
		//			return result;
		//		}
		
		public function createTile(fi:int):TileFi{
			throw new Error('must override createTile(fi:int)');
		}
		
		public function getPyramidIterator():Vector.<int>{
			var it:Vector.<int>=new Vector.<int>();
			for(var z:int=0;z<=zMax;z++){
				var side:int=FoldIndex.sideLength(z);
				for(var i:int=0;i<side;i++)
					for(var j:int=0;j<side;j++){
						var fi:int=FoldIndex.fromXyz(i-side/2,j-side/2,z).fi;
						it.push(fi);
					}
			}
			return it;
		}
		
		public function getLayerIterator(z:int):Vector.<int>{
			var it:Vector.<int>=new Vector.<int>();
			var side:int=FoldIndex.sideLength(z);
			for(var i:int=0;i<side;i++)
				for(var j:int=0;j<side;j++){
					var fi:int=FoldIndex.fromXyz(i-side/2,j-side/2,z).fi;
					it.push(fi);
				}
			return it;
		}
		
		public function dispose():void{
			fi_TileFi=null;
		}
	}
}