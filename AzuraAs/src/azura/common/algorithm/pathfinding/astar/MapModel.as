package azura.common.algorithm.pathfinding.astar
{
	import azura.common.algorithm.pathfinding.astar.AstarMapI;

	/**
	 * 地图模型类
	 *
	 * @author	eidiot (http://eidiot.net)
	 * @version	1.0
	 * @date	070416
	 */
	public class MapModel implements AstarMapI
	{
		private var starMap:Array;
		private var _width:int, _height:int;

		public function MapModel(width:int, height:int, fillRoad:Boolean=false)
		{
			this._width=width;
			this._height=height;
			reset();
			for (var i:int=0; i < width; i++)
				for (var j:int=0; j < height; j++)
				{
					starMap[i][j]=true;
				}
		}
		
		public function get height():int
		{
			return _height;
		}

		public function get width():int
		{
			return _width;
		}

		public function reset():void
		{

			starMap=new Array();
			for (var i:int=0; i < width; i++)
			{
				starMap[i]=new Array();
			}
		}

		public function setRoad(x:int, y:int, isRoad:Boolean):void
		{
			this.starMap[x][y]=isRoad;
		}

		/**
		 * 是否为障碍
		 * @param p_startX	始点X坐标
		 * @param p_startY	始点Y坐标
		 * @param p_endX	终点X坐标
		 * @param p_endY	终点Y坐标
		 * @return 0为障碍 1为通路
		 */
		public function isRoad(x:int, y:int, accurate:Boolean=false):Boolean
		{
			if (x < 0 || x == width || y < 0 || y == height)
			{
				return false;
			}
			else
			{
				return this.starMap[x][y];
			}
		}
	}
}