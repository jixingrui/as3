package azura.avalon.zbase
{
	import azura.common.collections.ZintBuffer;

	public interface CoreI
	{
		function set pathReady(value:Function):void;
		
		function setBase(data:ZintBuffer):void;
		
		function find(startX:int, startY:int, endX:int, endY:int):void;
	}
}