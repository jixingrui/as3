package azura.phoenix12.drop.frackSS.service{ 
import azura.expresso.Datum;
import azura.expresso.NameSpace;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.Rpcr;
import azura.expresso.rpc.RpcNodeA;
import azura.expresso.rpc.RpcTunnelI;
public class hubSCA extends RpcNodeA {
	private var handler:hubSCI;
	public function hubSCA(ns:NameSpace,tunnel:RpcTunnelI,handler:hubSCI){
		super(ns,tunnel);
		this.handler=handler;
	}
	override protected function serve(rpc:Rpc):void{
		switch(rpc.service){
		case 1134:
			var arg1135:Datum=rpc.getDatum(1135);
			rpc.setDatum(1136,ns.newDatum(1136));
			handler.registerHandler(arg1135,rpc);
			break;
		case 1138:
			handler.sendHandler(rpc.getDatum(1139));
			break;
		}
	}
	protected function receiveCall(arg1143:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1143, arg1143);
		super.callToRemote(rpc, 1142);
	}
}
}