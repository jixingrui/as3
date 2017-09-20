package azura.fractale.filter
{
	import azura.common.collections.ZintBuffer;

	public interface FrackUserIOld
	{
		function connected():void;
		function disconnected():void;
		function receivedFromNet(zb:ZintBuffer):void;
	}
}