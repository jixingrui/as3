package azura.avalon.maze3.service
{
	import azura.common.collections.ZintBuffer;
	import azura.expresso.Datum;
	import azura.expresso.rpc.RpcTunnelI;
	import azura.phoenix12.drop.maze3.param.Arg1059Hint;
	import azura.phoenix12.drop.maze3.param.Arg1063Hint;
	import azura.phoenix12.drop.maze3.service.SwitchCSA;
	import azura.phoenix12.drop.maze3.service.SwitchCSI;
	
	public class SwitchSeekerCs extends SwitchCSA implements SwitchCSI, RpcTunnelI
	{
		public var cs:Maze3SeekerEditCS;
		
		public function SwitchSeekerCs(tunnel:RpcTunnelI)
		{
			super(Maze3WooEditNet.nsMaze3, tunnel, this);
			cs=new Maze3SeekerEditCS(this);
		}
		
		public function doorHandler(arg1042:Datum):void
		{
			throw new Error();
		}
		
		public function wooHandler(arg1046:Datum):void
		{
			throw new Error();
		}
		
		public function seekerHandler(arg1063:Datum):void{
			var zb:ZintBuffer=arg1063.getBean(Arg1063Hint.msg).asBytes();
			cs.tunnelReceive(zb);
		}
		
		public function connected():void
		{
		}
		
		public function disconnected():void
		{
		}
		
		public function tunnelSend(zb:ZintBuffer):void
		{
			var arg1059:Datum=ns.newDatum(Arg1059Hint.CLASS);
			arg1059.getBean(Arg1059Hint.msg).setBytes(zb);
			seekerCall(arg1059);
		}
	}
}