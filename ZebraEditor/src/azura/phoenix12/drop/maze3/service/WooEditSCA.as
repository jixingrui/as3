package azura.phoenix12.drop.maze3.service{ 
import azura.expresso.Datum;
import azura.expresso.NameSpace;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.Rpcr;
import azura.expresso.rpc.RpcNodeA;
import azura.expresso.rpc.RpcTunnelI;
public class WooEditSCA extends RpcNodeA {
	private var handler:WooEditSCI;
	public function WooEditSCA(ns:NameSpace,tunnel:RpcTunnelI,handler:WooEditSCI){
		super(ns,tunnel);
		this.handler=handler;
	}
	override protected function serve(rpc:Rpc):void{
		switch(rpc.service){
		case 1020:
			handler.hardHandler(rpc.getDatum(1021));
			break;
		case 1028:
			rpc.setDatum(1029,ns.newDatum(1030));
			handler.dumpHandler(rpc);
			break;
		}
	}
	protected function hardCall(arg1025:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1025, arg1025);
		super.callToRemote(rpc, 1024);
	}
}
}