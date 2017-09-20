package azura.gallerid3.i
{
	import azura.common.collections.ZintBuffer;
	
	import flash.utils.ByteArray;

	public interface Mc5DiskI
	{
		/**
		 * @return plain data
		 */
		function getData(mc5:String):ZintBuffer;
		/**
		 * @return plain data
		 */
		function cache(mc5:String,target:ByteArray,targetIsCypher:Boolean):ZintBuffer;
	}
}