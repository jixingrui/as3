package azura.phoenix12.drop.frackSS.service{ 
import azura.expresso.Datum;
import azura.expresso.NameSpace;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.Rpcr;
import azura.expresso.rpc.RpcNodeA;
import azura.expresso.rpc.RpcTunnelI;
public class hubCSA extends RpcNodeA {
	private var handler:hubCSI;
	public function hubCSA(ns:NameSpace,tunnel:RpcTunnelI,handler:hubCSI){
		super(ns,tunnel);
		this.handler=handler;
	}
	override protected function serve(rpc:Rpc):void{
		switch(rpc.service){
		case 1142:
			handler.receiveHandler(rpc.getDatum(1143));
			break;
		}
	}
	protected function registerCall(arg1135:Datum, func_Ret1136:Function):void{
		var ret1136:Rpcr=new Rpcr(this,func_Ret1136);
		ret1136.setDatum(1135, arg1135);
		ret1136.ruler=1136;
		super.callToRemoteRpcr(ret1136, 1134);
	}
	protected function sendCall(arg1139:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1139, arg1139);
		super.callToRemote(rpc, 1138);
	}
}
}