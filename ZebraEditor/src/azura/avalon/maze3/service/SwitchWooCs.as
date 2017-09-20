package azura.avalon.maze3.service
{
	import azura.common.collections.ZintBuffer;
	import azura.expresso.Datum;
	import azura.expresso.rpc.RpcTunnelI;
	import azura.phoenix12.drop.maze3.param.Arg1037Hint;
	import azura.phoenix12.drop.maze3.param.Arg1046Hint;
	import azura.phoenix12.drop.maze3.service.SwitchCSA;
	import azura.phoenix12.drop.maze3.service.SwitchCSI;
	
	public class SwitchWooCs extends SwitchCSA implements SwitchCSI, RpcTunnelI
	{
		public var cs:Maze3WooEditCS;
		
		public function SwitchWooCs(tunnel:RpcTunnelI)
		{
			super(Maze3WooEditNet.nsMaze3, tunnel, this);
			cs=new Maze3WooEditCS(this);
		}
		
		public function doorHandler(arg1042:Datum):void
		{
			throw new Error();
		}
		
		public function wooHandler(arg1046:Datum):void
		{
			var zb:ZintBuffer=arg1046.getBean(Arg1046Hint.msg).asBytes();
			cs.tunnelReceive(zb);
		}
		
		public function seekerHandler(arg1063:Datum):void{
			throw new Error();
		}
		
		public function connected():void
		{
		}
		
		public function disconnected():void
		{
		}
		
		public function tunnelSend(zb:ZintBuffer):void
		{
			var arg1037:Datum=ns.newDatum(Arg1037Hint.CLASS);
			arg1037.getBean(Arg1037Hint.msg).setBytes(zb);
			wooCall(arg1037);
		}
	}
}