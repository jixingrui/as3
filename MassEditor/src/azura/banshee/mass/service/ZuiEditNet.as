package azura.banshee.mass.service
{
	import azura.common.collections.ZintBuffer;
	import azura.expresso.NameSpace;
	import azura.expresso.rpc.RpcTunnelI;
	import azura.fractale.FrackConfigI;
	import azura.fractale.filter.FrackSocketA;
	import azura.phoenix12.drop.zui.Def_zui;
	import azura.banshee.mass.service.ZuiCS;


	public class ZuiEditNet extends FrackSocketA implements RpcTunnelI
	{
		public static var nsZui:NameSpace=new NameSpace(Def_zui.data);
		public static var cs:ZuiCS;
		
		public function ZuiEditNet(config:FrackConfigI) {
			super(config);
			var local:ZuiCS=new ZuiCS(this);
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