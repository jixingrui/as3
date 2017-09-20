package azura.avalon.maze.service
{
	import azura.common.collections.ZintBuffer;
	import azura.expresso.Datum;
	import azura.expresso.rpc.RpcTunnelI;
	import azura.helios.drass9.DrassHub;
	import azura.phoenix12.drop.maze2.param.Arg958Hint;
	import azura.phoenix12.drop.maze2.param.Arg962Hint;
	import azura.phoenix12.drop.maze2.param.Ret993Hint;
	import azura.phoenix12.drop.maze2.service.EditCSA;
	import azura.phoenix12.drop.maze2.service.EditCSI;
	
	public class MazeEditCS extends EditCSA implements EditCSI,RpcTunnelI
	{
		public var hub:DrassHub;
		
		public function MazeEditCS(tunnel:RpcTunnelI)
		{
			super(SwitchNet.nsMaze2, tunnel, this);
			hub=new DrassHub(this);
		}
		
		public function drassHandler(arg962:Datum):void
		{
			var msg:ZintBuffer=arg962.getBean(Arg962Hint.msg).asBytes();
			hub.receive(msg);
		}
		
		public function tunnelSend(zb:ZintBuffer):void
		{
			var arg958:Datum=ns.newDatum(Arg958Hint.CLASS);
			arg958.getBean(Arg958Hint.msg).setBytes(zb);
			super.drassCall(arg958);
		}
		
		public function dump(onDump_ZintBuffer:Function):void{
			super.dumpCall(func);
			function func(ret993:Datum):void{
				var data:ZintBuffer=ret993.getBean(Ret993Hint.maze).asBytes();
				onDump_ZintBuffer.call(null,data);
			}
		}
		
		public function connected():void
		{
			hub.connected();
		}
		
		public function disconnected():void
		{
		}
	}
}