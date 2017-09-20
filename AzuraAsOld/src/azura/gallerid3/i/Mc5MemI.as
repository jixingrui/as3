package azura.gallerid3.i
{
	import azura.common.collections.ZintBuffer;

	public interface Mc5MemI
	{
		function getData(mc5:String):ZintBuffer;
		function cache(mc5:String,data:ZintBuffer):void;
	}
}