package azura.expresso.rpc
{
	import azura.common.collections.ZintBuffer;
	
	import flash.utils.ByteArray;

	public interface RpcTunnelI
	{
		function tunnelSend(zb:ZintBuffer):void;
	}
}