package azura.karma.service
{
	import azura.common.collections.ZintBuffer;
	import azura.expresso.NameSpace;
	import azura.expresso.rpc.RpcTunnelI;
	import azura.fractale.FrackConfigI;
	import azura.fractale.filter.FrackSocketA;
	import azura.phoenix12.drop.karma.Def_karma;
	
	
	public class KarmaNet extends FrackSocketA implements RpcTunnelI
	{
		public static var nsKarma:NameSpace=new NameSpace(Def_karma.data);
		public static var cs:KarmaCS;
		
		public function KarmaNet(config:FrackConfigI) {
			super(config);
			if(cs!=null)
				throw new Error("initialized twice");
			
			cs=new KarmaCS(this);
			onConnected.add(cs.connected);
			onDisconnected.add(cs.disconnected);
			onSocketReceive.add(cs.tunnelReceive);
		}		
		
		public function tunnelSend(zb:ZintBuffer):void
		{
			super.sendToNet(zb);
		}
	}
}