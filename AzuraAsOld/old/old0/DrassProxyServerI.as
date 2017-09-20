package azura.hellios.drass6
{
	import common.collections.ZintBuffer;

	public interface DrassProxyServerI
	{
		function sendToDrassServer(zb:ZintBuffer):void;
	}
}