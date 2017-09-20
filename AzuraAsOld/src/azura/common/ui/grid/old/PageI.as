package azura.common.ui.grid.old
{
	public interface PageI
	{
		function show():void;
		function moveIn(from_left_right:Boolean):void;
		function moveOut(to_left_right:Boolean):void;
	}
}