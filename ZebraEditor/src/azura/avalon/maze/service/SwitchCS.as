package azura.avalon.maze.service
{
	import azura.common.collections.ZintBuffer;
	import azura.expresso.Datum;
	import azura.expresso.rpc.RpcTunnelI;
	import azura.phoenix12.drop.maze2.param.Arg976Hint;
	import azura.phoenix12.drop.maze2.param.Arg980Hint;
	import azura.phoenix12.drop.maze2.param.Arg984Hint;
	import azura.phoenix12.drop.maze2.param.Arg988Hint;
	import azura.phoenix12.drop.maze2.service.SwitchCSA;
	import azura.phoenix12.drop.maze2.service.SwitchCSI;
	
	public class SwitchCS extends SwitchCSA implements SwitchCSI
	{
		public var mazeEditCS:MazeEditCS;
		public var mazeWalkCS:MazeWalkCS;
		
		public function SwitchCS(tunnel:RpcTunnelI)
		{
			super(SwitchNet.nsMaze2, tunnel, this);
			mazeEditCS=new MazeEditCS(new MazeEditBridge(this));
			mazeWalkCS=new MazeWalkCS(new MazeWalkBridge(this));
		}
		
		public function editHandler(arg984:Datum):void
		{
			var msg:ZintBuffer=arg984.getBean(Arg984Hint.msg).asBytes();
			mazeEditCS.tunnelReceive(msg);
		}
		
		public function mazeEditSend(zb:ZintBuffer):void{
			var arg976:Datum=ns.newDatum(Arg976Hint.CLASS);
			arg976.getBean(Arg976Hint.msg).setBytes(zb);
			super.editCall(arg976);
		}
		
		public function walkHandler(arg988:Datum):void
		{
			var msg:ZintBuffer=arg988.getBean(Arg988Hint.msg).asBytes();
			mazeWalkCS.tunnelReceive(msg);
		}
		public function mazeWalkSend(zb:ZintBuffer):void{
			var arg980:Datum=ns.newDatum(Arg980Hint.CLASS);
			arg980.getBean(Arg980Hint.msg).setBytes(zb);
			super.walkCall(arg980);
		}
		
		public function connected():void
		{
			mazeEditCS.connected();
			mazeWalkCS.connected();
		}
		
		public function disconnected():void
		{
			mazeEditCS.disconnected();
			mazeWalkCS.disconnected();
		}
	}
}