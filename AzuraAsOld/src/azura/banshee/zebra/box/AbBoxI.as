package azura.banshee.zebra.box
{
	public interface AbBoxI
	{
		function get priority():int;
		/**
		 * 
		 * @return stop propagation
		 * 
		 */
		function zboxTouched():Boolean;
	}
}