package azura.phoenix12.drop.maze3.service{ 
import azura.expresso.Datum;
import azura.expresso.NameSpace;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.Rpcr;
import azura.expresso.rpc.RpcNodeA;
import azura.expresso.rpc.RpcTunnelI;
public class SeekerEditSCA extends RpcNodeA {
	private var handler:SeekerEditSCI;
	public function SeekerEditSCA(ns:NameSpace,tunnel:RpcTunnelI,handler:SeekerEditSCI){
		super(ns,tunnel);
		this.handler=handler;
	}
	override protected function serve(rpc:Rpc):void{
		switch(rpc.service){
		case 1050:
			handler.hardHandler(rpc.getDatum(1051));
			break;
		case 1066:
			rpc.setDatum(1067,ns.newDatum(1068));
			handler.dumpHandler(rpc);
			break;
		}
	}
	protected function hardCall(arg1055:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1055, arg1055);
		super.callToRemote(rpc, 1054);
	}
}
}