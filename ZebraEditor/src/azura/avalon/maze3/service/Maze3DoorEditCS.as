package azura.avalon.maze3.service
{
	import azura.common.collections.ZintBuffer;
	import azura.expresso.Datum;
	import azura.expresso.rpc.RpcTunnelI;
	import azura.helios.hard10.hub.HardHub;
	import azura.phoenix12.drop.maze3.param.Arg1008Hint;
	import azura.phoenix12.drop.maze3.param.Arg1016Hint;
	import azura.phoenix12.drop.maze3.param.Ret1013Hint;
	import azura.phoenix12.drop.maze3.service.DoorEditCSA;
	import azura.phoenix12.drop.maze3.service.DoorEditCSI;
	
	public class Maze3DoorEditCS extends DoorEditCSA implements DoorEditCSI,RpcTunnelI
	{
		public var hub:HardHub;
		
		public function Maze3DoorEditCS(tunnel:RpcTunnelI)
		{
			super(Maze3DoorEditNet.nsMaze3, tunnel, this);
			hub=new HardHub(this);
		}
		
		public function hardHandler(arg1016:Datum):void
		{
			var msg:ZintBuffer=arg1016.getBean(Arg1016Hint.msg).asBytes();
			hub.receive(msg);
		}
		
		public function tunnelSend(zb:ZintBuffer):void
		{
			var arg1008:Datum=ns.newDatum(Arg1008Hint.CLASS);
			arg1008.getBean(Arg1008Hint.msg).setBytes(zb);
			super.hardCall(arg1008);
		}
		
		public function dump(onDump_ZintBuffer:Function):void{
			super.dumpCall(func);
			function func(ret1013:Datum):void{
				var data:ZintBuffer=ret1013.getBean(Ret1013Hint.maze).asBytes();
				onDump_ZintBuffer.call(null,data);
			}
		}
		
		public function connected():void
		{
		}
		
		public function disconnected():void
		{
		}
	}
}