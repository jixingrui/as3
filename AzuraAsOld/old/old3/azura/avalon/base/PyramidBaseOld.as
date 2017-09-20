package old.azura.avalon.base
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	
	import azura.common.algorithm.FoldIndex;
	import azura.common.algorithm.pathfinding.astar.AstarMapI;
	import azura.common.collections.ZintBuffer;
	
	public class PyramidBaseOld extends PyramidFi implements AstarMapI
	{
		internal static var tileSize:int=32;
		private var _scale:int;
		public function PyramidBaseOld(data:ZintBuffer)
		{
			this._scale=data.readZint();
//			init(data.readZint());
			zMax=data.readZint();
			for each(var fi:int in getPyramidIterator()){
				var tile:TileBaseOld=getTile_(fi) as TileBaseOld;
				tile.decode(data.readBytes_());
			}
		}	
		
		public function get scale():Number
		{
			return _scale/100;
		}

		override public function createTile(fi:int):TileFi{
			return new TileBaseOld(fi,this);
		}
		
		public function getHeight(xTp:int,yTp:int):int{
			var fi:int=FoldIndex.mix(xTp/tileSize,yTp/tileSize,zMax).fi;
			var tc:TileBaseOld=getTile_(fi) as TileBaseOld;
			return tc.getHTop(xTp%tileSize,yTp%tileSize);
		}
		
		public function isRoadFlat(xFc:int,yFc:int):Boolean{
			var xFp:int=xFc+bound/2;
			var yFp:int=yFc+bound/2;
			var fi:int=FoldIndex.mix(xFp/tileSize,yFp/tileSize,zMax).fi;
			var tb:TileBaseOld=getTile_(fi) as TileBaseOld;
			return tb.isRoadFlat(xFp%tileSize,yFp%tileSize);
		}
		
		public function getYOffset(xFc:int,yFc:int):int{
			var xFp:int=xFc+bound/2;
			var yFp:int=yFc+bound/2;
			var fi:int=FoldIndex.mix(xFp/tileSize,yFp/tileSize,zMax).fi;
			var tc:TileBaseOld=getTile_(fi) as TileBaseOld;
			return tc.getHFlat(xFp%tileSize,yFp%tileSize);
		}
				
		override public function get bound():int{
			return super.bound*tileSize;
		}
		
		public function get height():int
		{
			return bound;
		}
		
		public function get width():int
		{
			return bound;
		}
		
		public function setRoad(xTp:int, yTp:int, isRoad:Boolean):void
		{
		}
		
		/**
		 * 
		 * @param xy top and positive
		 * 
		 */
		public function isRoad(xTp:int, yTp:int):Boolean
		{
			if (xTp < 0 || xTp == width || yTp < 0 || yTp == height)
			{
				return false;
			}
			else
			{
				var fi:int=FoldIndex.mix(xTp/tileSize,yTp/tileSize,zMax).fi;
				var tc:TileBaseOld=getTile_(fi) as TileBaseOld;
				return tc.isRoad(xTp%tileSize,yTp%tileSize);
			}
		}
	}
}