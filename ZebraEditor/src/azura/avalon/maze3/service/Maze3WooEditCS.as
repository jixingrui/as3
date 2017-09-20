package azura.avalon.maze3.service
{
	import azura.common.collections.ZintBuffer;
	import azura.expresso.Datum;
	import azura.expresso.NameSpace;
	import azura.expresso.rpc.RpcTunnelI;
	import azura.helios.hard10.hub.HardHub;
	import azura.phoenix12.drop.maze3.param.Arg1021Hint;
	import azura.phoenix12.drop.maze3.param.Arg1025Hint;
	import azura.phoenix12.drop.maze3.param.Ret1030Hint;
	import azura.phoenix12.drop.maze3.service.WooEditCSA;
	import azura.phoenix12.drop.maze3.service.WooEditCSI;
	
	public class Maze3WooEditCS extends WooEditCSA implements WooEditCSI, RpcTunnelI
	{
		public var hub:HardHub;
		
		public function Maze3WooEditCS(tunnel:RpcTunnelI)
		{
			super(Maze3WooEditNet.nsMaze3, tunnel, this);
			hub=new HardHub(this);
		}
		
		public function dump(onDump_ZintBuffer:Function):void{
			super.dumpCall(func);
			function func(ret1030:Datum):void{
				var data:ZintBuffer=ret1030.getBean(Ret1030Hint.wooLayer).asBytes();
				onDump_ZintBuffer.call(null,data);
			}
		}
		
		public function hardHandler(arg1025:Datum):void
		{
			var msg:ZintBuffer=arg1025.getBean(Arg1025Hint.msg).asBytes();
			hub.receive(msg);
		}
		
		public function tunnelSend(zb:ZintBuffer):void
		{
			var arg1021:Datum=ns.newDatum(Arg1021Hint.CLASS);
			arg1021.getBean(Arg1021Hint.msg).setBytes(zb);
			super.hardCall(arg1021);
		}
		
		public function connected():void
		{
		}
		
		public function disconnected():void
		{
		}
	}
}