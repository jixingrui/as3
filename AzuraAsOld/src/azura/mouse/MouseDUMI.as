package azura.mouse
{
	public interface MouseDUMI extends MouseI
	{
		/**
		 * 
		 * relative to the screen center
		 * @return consume the event and stop propagation
		 * 
		 */
		function mouseDown(x:int,y:int):Boolean;
		/**
		 * 
		 * relative to the screen center
		 * 
		 */
		function mouseMove(x:int,y:int):void;
		/**
		 * 
		 * relative to the screen center
		 * 
		 */
		function mouseUp(x:int,y:int):void;	
	}
}