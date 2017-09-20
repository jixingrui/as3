package azura.phoenix12.drop.maze3.service{ 
import azura.expresso.Datum;
import azura.expresso.NameSpace;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.Rpcr;
import azura.expresso.rpc.RpcNodeA;
import azura.expresso.rpc.RpcTunnelI;
public class DoorEditCSA extends RpcNodeA {
	private var handler:DoorEditCSI;
	public function DoorEditCSA(ns:NameSpace,tunnel:RpcTunnelI,handler:DoorEditCSI){
		super(ns,tunnel);
		this.handler=handler;
	}
	override protected function serve(rpc:Rpc):void{
		switch(rpc.service){
		case 1015:
			handler.hardHandler(rpc.getDatum(1016));
			break;
		}
	}
	protected function hardCall(arg1008:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1008, arg1008);
		super.callToRemote(rpc, 1007);
	}
	protected function dumpCall(func_Ret1013:Function):void{
		var ret1013:Rpcr=new Rpcr(this,func_Ret1013);
		ret1013.ruler=1013;
		super.callToRemoteRpcr(ret1013, 1011);
	}
}
}