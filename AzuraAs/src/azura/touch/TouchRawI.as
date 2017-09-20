package azura.touch
{
	public interface TouchRawI
	{
		/**
		 * 
		 * down can only happen once
		 * @return stop propagation
		 * 
		 */
		function handDown(handId:int,x:Number,y:Number):void;		
		/**
		 * 
		 * up pairs with down
		 * @return stop propagation
		 * 
		 */
		function handUp(handId:int,x:Number,y:Number):void;		
		/**
		 * 
		 * move does not  need down in advance
		 * @return stop propagation
		 * 
		 */
		function handMove(handId:int,x:Number,y:Number):void;		
		/**
		 * 
		 * out is stand alone
		 * @return stop propagation
		 * 
		 */
		function handOut(handId:int):void;
	}
}