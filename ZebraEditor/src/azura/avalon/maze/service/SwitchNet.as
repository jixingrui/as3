package azura.avalon.maze.service
{
	import azura.avalon.maze.service.SwitchCS;
	import azura.common.collections.ZintBuffer;
	import azura.expresso.NameSpace;
	import azura.expresso.rpc.RpcTunnelI;
	import azura.fractale.FrackConfigI;
	import azura.fractale.filter.FrackSocketA;
	import azura.phoenix12.drop.maze2.Def_maze2;


	public class SwitchNet extends FrackSocketA implements RpcTunnelI
	{
		public static var nsMaze2:NameSpace=new NameSpace(Def_maze2.data);
		public static var cs:SwitchCS;
		
		public function SwitchNet(config:FrackConfigI) {
			super(config);
			var local:SwitchCS=new SwitchCS(this);
			onConnected.add(local.connected);
			onDisconnected.add(local.disconnected);
			onSocketReceive.add(local.tunnelReceive);
			
			if(cs!=null)
				throw new Error("initialized twice");
			cs=local;
		}		
		
		public function tunnelSend(zb:ZintBuffer):void
		{
			super.sendToNet(zb);
		}
	}
}