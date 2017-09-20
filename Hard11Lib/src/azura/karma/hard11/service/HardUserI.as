package azura.karma.hard11.service
{
	import azura.common.collections.ZintBuffer;

	public interface HardUserI
	{
		function tunnelSend(zb:ZintBuffer):void;
		function receiveCustom(zb:ZintBuffer):void;
	}
}