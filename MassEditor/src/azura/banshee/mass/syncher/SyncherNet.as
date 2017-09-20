package azura.banshee.mass.syncher
{
	import azura.common.collections.ZintBuffer;
	import azura.expresso.NameSpace;
	import azura.expresso.rpc.RpcTunnelI;
	import azura.fractale.FrackConfigI;
	import azura.fractale.filter.FrackSocketA;
	import azura.phoenix12.drop.frackSS.Def_frackSS;


	public class SyncherNet extends FrackSocketA implements RpcTunnelI
	{
		public var nsSyncher:NameSpace=new NameSpace(Def_frackSS.data);
		public var cs:SyncherCS;
		
		public function SyncherNet(config:FrackConfigI) {
			super(config);
			var local:SyncherCS=new SyncherCS(this);
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