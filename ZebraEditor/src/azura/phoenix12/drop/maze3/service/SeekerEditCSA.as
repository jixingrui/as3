package azura.phoenix12.drop.maze3.service{ 
import azura.expresso.Datum;
import azura.expresso.NameSpace;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.Rpcr;
import azura.expresso.rpc.RpcNodeA;
import azura.expresso.rpc.RpcTunnelI;
public class SeekerEditCSA extends RpcNodeA {
	private var handler:SeekerEditCSI;
	public function SeekerEditCSA(ns:NameSpace,tunnel:RpcTunnelI,handler:SeekerEditCSI){
		super(ns,tunnel);
		this.handler=handler;
	}
	override protected function serve(rpc:Rpc):void{
		switch(rpc.service){
		case 1054:
			handler.hardHandler(rpc.getDatum(1055));
			break;
		}
	}
	protected function hardCall(arg1051:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1051, arg1051);
		super.callToRemote(rpc, 1050);
	}
	protected function dumpCall(func_Ret1068:Function):void{
		var ret1068:Rpcr=new Rpcr(this,func_Ret1068);
		ret1068.ruler=1068;
		super.callToRemoteRpcr(ret1068, 1066);
	}
}
}