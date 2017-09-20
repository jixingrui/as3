package azura.phoenix12.drop.maze3.service{ 
import azura.expresso.Datum;
import azura.expresso.NameSpace;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.Rpcr;
import azura.expresso.rpc.RpcNodeA;
import azura.expresso.rpc.RpcTunnelI;
public class DoorEditSCA extends RpcNodeA {
	private var handler:DoorEditSCI;
	public function DoorEditSCA(ns:NameSpace,tunnel:RpcTunnelI,handler:DoorEditSCI){
		super(ns,tunnel);
		this.handler=handler;
	}
	override protected function serve(rpc:Rpc):void{
		switch(rpc.service){
		case 1007:
			handler.hardHandler(rpc.getDatum(1008));
			break;
		case 1011:
			rpc.setDatum(1012,ns.newDatum(1013));
			handler.dumpHandler(rpc);
			break;
		}
	}
	protected function hardCall(arg1016:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1016, arg1016);
		super.callToRemote(rpc, 1015);
	}
}
}