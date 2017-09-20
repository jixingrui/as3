package azura.common.ui.grid
{
	public interface GridI
	{
//		function gridAddItem(item:ItemI):void;
		function gridMoveItem(item:ItemI,x:Number,y:Number):void;
//		function gridRemoveItem(item:ItemI):void;
		function gridMoveShell(x:Number,y:Number):void;
		
		
		/**
		 *  show green arrow indicating there is more
		 */
		function showHead(value:Boolean):void;		
		/**
		 *  show green arrow indicating there is more
		 */
		function showTail(value:Boolean):void;
//		function hitHead():void;
//		function hitTail():void;
		
		function gridPageSize(value:int):void;
		function gridPageCount(value:int):void;
		function gridAtPage(idx:int):void;
	}
}