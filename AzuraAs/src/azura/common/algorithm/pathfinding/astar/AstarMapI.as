package azura.common.algorithm.pathfinding.astar
{
	public interface AstarMapI
	{
		function get width():int;
		function get height():int;
		function setRoad(x:int,y:int,isRoad:Boolean):void;
		function isRoad(x:int,y:int,accurate:Boolean=false) : Boolean;
	}
}