package old.azura.avalon.base
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	import azura.common.collections.BitSet;
	import azura.common.collections.ByteMatrix;
	import azura.common.collections.LBSet;
	import azura.common.collections.ObjectCache;
	import azura.common.collections.ZintBuffer;
	
	public class TileBaseOld extends TileFi
	{
		private var topMap:ByteMatrix;
		private var flatMap:ByteMatrix;
		
		public function TileBaseOld(fi:int, pyramid:PyramidFi)
		{
			super(fi, pyramid);
		}
		
		public function decode(zb:ZintBuffer):void{
			topMap=new ByteMatrix(PyramidBaseOld.tileSize,zb.readBytes_());
			flatMap=new ByteMatrix(PyramidBaseOld.tileSize,zb.readBytes_());
		}
		
		public function getHTop(x:int,y:int):int{
			return topMap.getByte(x,y);
		}
		
		public function getHFlat(x:int,y:int):int{
			return flatMap.getByte(x,y);
		}
		
		public function isRoadFlat(x:int,y:int):Boolean{
			return flatMap.hasValue(x,y);
		}
		
		public function isRoad(x:int,y:int):Boolean{
			return topMap.hasValue(x,y);
		}
		
	}
}