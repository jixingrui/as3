package azura.avalon.maze3.service
{
	import azura.common.collections.ZintBuffer;
	import azura.expresso.Datum;
	import azura.expresso.rpc.RpcTunnelI;
	import azura.helios.hard10.hub.HardHub;
	import azura.phoenix12.drop.maze3.param.Arg1051Hint;
	import azura.phoenix12.drop.maze3.param.Arg1055Hint;
	import azura.phoenix12.drop.maze3.param.Ret1068Hint;
	import azura.phoenix12.drop.maze3.service.SeekerEditCSA;
	import azura.phoenix12.drop.maze3.service.SeekerEditCSI;
	
	public class Maze3SeekerEditCS extends SeekerEditCSA implements SeekerEditCSI, RpcTunnelI
	{
		public var hub:HardHub;
		
		public function Maze3SeekerEditCS(tunnel:RpcTunnelI)
		{
			super(Maze3SeekerEditNet.nsMaze3, tunnel, this);
			hub=new HardHub(this);
		}
		
		public function dump(onDump_ZintBuffer:Function):void{
			super.dumpCall(func);
			function func(ret1068:Datum):void{
				var data:ZintBuffer=ret1068.getBean(Ret1068Hint.seekerDump).asBytes();
				onDump_ZintBuffer.call(null,data);
			}
		}
		
		public function hardHandler(arg1055:Datum):void
		{
			var msg:ZintBuffer=arg1055.getBean(Arg1055Hint.msg).asBytes();
			hub.receive(msg);
		}
		
		public function tunnelSend(zb:ZintBuffer):void
		{
			var arg1051:Datum=ns.newDatum(Arg1051Hint.CLASS);
			arg1051.getBean(Arg1051Hint.msg).setBytes(zb);
			super.hardCall(arg1051);
		}
		
		public function connected():void
		{
		}
		
		public function disconnected():void
		{
		}
	}
}