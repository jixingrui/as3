package azura.avalon.maze.service
{
	import azura.common.collections.ZintBuffer;
	import azura.expresso.rpc.RpcTunnelI;
	
	
	public class MazeWalkBridge implements RpcTunnelI
	{
		private var host:SwitchCS;
		public function MazeWalkBridge(host:SwitchCS)
		{
			this.host=host;
		}
		
		public function tunnelSend(zb:ZintBuffer):void
		{
			host.mazeWalkSend(zb);
		}
	}
}