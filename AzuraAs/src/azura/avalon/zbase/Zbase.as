package azura.avalon.zbase
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	import azura.avalon.fi.view.PyramidViewerI;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.FoldIndex;
	import azura.common.algorithm.pathfinding.astar.AstarMapI;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	public class Zbase extends PyramidFi implements BytesI,AstarMapI
	{
		public var width_:int;
		public var height_:int;
		
		override public function createTile(fi:int):TileFi{
			return new ZbaseTile(fi,this);
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			width_=zb.readZint();
			height_=zb.readZint();
			zMax=zb.readZint();
			tileSide=zb.readZint();
			for each(var fi:int in getPyramidIterator()){
				var tb:ZbaseTile=getTile_(fi) as ZbaseTile;
				tb.fromBytes(zb.readBytesZ());
			}
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(width_);
			zb.writeZint(height_);
			zb.writeZint(zMax);
			zb.writeZint(tileSide);
			for each(var fi:int in getPyramidIterator()){
				var tb:ZbaseTile=getTile_(fi) as ZbaseTile;
				zb.writeBytesZ(tb.toBytes());
			}
			return zb;
		}
		
		public function clear():void{
		}
		
		override public function get bound():int{
			return super.bound*tileSide;
		}
		
		public function get height():int
		{
			return height_;
		}
		
		public function get width():int
		{
			return width_;
		}
		
		public function setRoad(xTp:int, yTp:int, isRoad:Boolean):void
		{
		}
		
		/**
		 * 
		 * @param xy center coordinate
		 * 
		 */
		public function isRoad(x:int, y:int, accurate:Boolean=false):Boolean
		{
			var tile:ZbaseTile = getTile(x, y, zMax) as ZbaseTile;
			
			if (tile == null)
				return false;
			x=globalToTile(x,zMax);
			y=globalToTile(y,zMax);
			return tile.canWalk(x, y);
		}
	}
	
}
