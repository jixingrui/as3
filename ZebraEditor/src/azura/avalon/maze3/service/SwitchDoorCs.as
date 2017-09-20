package azura.avalon.maze3.service
{
	import azura.common.collections.ZintBuffer;
	import azura.expresso.Datum;
	import azura.expresso.rpc.RpcTunnelI;
	import azura.phoenix12.drop.maze3.param.Arg1034Hint;
	import azura.phoenix12.drop.maze3.param.Arg1042Hint;
	import azura.phoenix12.drop.maze3.service.SwitchCSA;
	import azura.phoenix12.drop.maze3.service.SwitchCSI;
	
	public class SwitchDoorCs extends SwitchCSA implements SwitchCSI, RpcTunnelI
	{
		public var cs:Maze3DoorEditCS;
		
		public function SwitchDoorCs(tunnel:RpcTunnelI)
		{
			super(Maze3DoorEditNet.nsMaze3, tunnel, this);
			cs=new Maze3DoorEditCS(this);
		}
		
		public function doorHandler(arg1042:Datum):void
		{
			var zb:ZintBuffer=arg1042.getBean(Arg1042Hint.msg).asBytes();
			cs.tunnelReceive(zb);
		}
		
		public function wooHandler(arg1046:Datum):void
		{
			throw new Error();
		}
		
		public function seekerHandler(arg1063:Datum):void{
			throw new Error();
		}
		
		public function connected():void
		{
			cs.connected();
		}
		
		public function disconnected():void
		{
			cs.disconnected();
		}
		
		public function tunnelSend(zb:ZintBuffer):void
		{
			var arg1034:Datum=ns.newDatum(Arg1034Hint.CLASS);
			arg1034.getBean(Arg1034Hint.msg).setBytes(zb);
			doorCall(arg1034);
		}
	}
}