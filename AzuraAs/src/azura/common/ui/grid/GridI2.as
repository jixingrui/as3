package azura.common.ui.grid
{
	public interface GridI2
	{
		function gridMoveShell(x:Number,y:Number):void;
		/**
		 *  show green arrow indicating there is more
		 */
		function showHead(value:Boolean):void;		
		/**
		 *  show green arrow indicating there is more
		 */
		function showTail(value:Boolean):void;
		function set gridPageSize(value:int):void;
		function set gridPageCount(value:int):void;
		function set gridAtPage(idx:int):void;
	}
}