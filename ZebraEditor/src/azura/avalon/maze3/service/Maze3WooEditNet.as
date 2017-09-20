package azura.avalon.maze3.service
{
	import azura.common.collections.ZintBuffer;
	import azura.expresso.NameSpace;
	import azura.expresso.rpc.RpcTunnelI;
	import azura.fractale.FrackConfigI;
	import azura.fractale.filter.FrackSocketA;
	import azura.phoenix12.drop.maze3.Def_maze3;


	public class Maze3WooEditNet extends FrackSocketA implements RpcTunnelI
	{
		public static var nsMaze3:NameSpace=new NameSpace(Def_maze3.data);
		public static var cs:SwitchWooCs;
		
		public function Maze3WooEditNet(config:FrackConfigI) {
			super(config);
			var local:SwitchWooCs=new SwitchWooCs(this);
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