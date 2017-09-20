package azura.phoenix12.drop.maze3.service{ 
import azura.expresso.Datum;
import azura.expresso.NameSpace;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.Rpcr;
import azura.expresso.rpc.RpcNodeA;
import azura.expresso.rpc.RpcTunnelI;
public class WooEditCSA extends RpcNodeA {
	private var handler:WooEditCSI;
	public function WooEditCSA(ns:NameSpace,tunnel:RpcTunnelI,handler:WooEditCSI){
		super(ns,tunnel);
		this.handler=handler;
	}
	override protected function serve(rpc:Rpc):void{
		switch(rpc.service){
		case 1024:
			handler.hardHandler(rpc.getDatum(1025));
			break;
		}
	}
	protected function hardCall(arg1021:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1021, arg1021);
		super.callToRemote(rpc, 1020);
	}
	protected function dumpCall(func_Ret1030:Function):void{
		var ret1030:Rpcr=new Rpcr(this,func_Ret1030);
		ret1030.ruler=1030;
		super.callToRemoteRpcr(ret1030, 1028);
	}
}
}