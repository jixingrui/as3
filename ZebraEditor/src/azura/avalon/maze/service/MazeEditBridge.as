package azura.avalon.maze.service
{
	import azura.common.collections.ZintBuffer;
	import azura.expresso.rpc.RpcTunnelI;
	
	public class MazeEditBridge implements RpcTunnelI
	{
		private var host:SwitchCS;
		public function MazeEditBridge(host:SwitchCS)
		{
			this.host=host;
		}
		
		public function tunnelSend(zb:ZintBuffer):void
		{
			host.mazeEditSend(zb);
		}
	}
}