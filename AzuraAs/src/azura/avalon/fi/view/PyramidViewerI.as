package azura.avalon.fi.view
{
	import azura.avalon.fi.TileFi;
	import azura.common.algorithm.FoldIndex;

	public interface PyramidViewerI
	{
		/**
		 * 
		 * @param current in visual now
		 * @param deltaIn new
		 * @param deltaOut old and gone
		 * 
		 */
		function pyramidView(current:FiSet,deltaIn:FiSet,deltaOut:FiSet):void;
	}
}