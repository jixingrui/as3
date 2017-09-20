package azura.common.ui.grid
{
	public interface ItemI
	{
		//		function get gridIdx():int;
		//		function set gridIdx(value:int):void;
		function gridMoveItem(x:Number,y:Number):void;
		function set gridAlpha(value:Number):void;
		function get gridVisible():Boolean;
		function set gridVisible(value:Boolean):void;
	}
}