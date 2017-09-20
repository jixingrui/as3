package azura.avalon.mouse
{
	public interface MouseDragTargetI extends MouseTargetI
	{
		function dragStart(x:int,y:int):void;
		function dragMove(x:int,y:int):void;
		function dragEnd(x:int,y:int):void;
	}
}