package azura.phoenix12.drop.karma.service{ 
import azura.expresso.Datum;
import azura.expresso.NameSpace;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.Rpcr;
import azura.expresso.rpc.RpcNodeA;
import azura.expresso.rpc.RpcTunnelI;
public class editSCA extends RpcNodeA {
	private var handler:editSCI;
	public function editSCA(ns:NameSpace,tunnel:RpcTunnelI,handler:editSCI){
		super(ns,tunnel);
		this.handler=handler;
	}
	override protected function serve(rpc:Rpc):void{
		switch(rpc.service){
		case 1154:
			handler.hardHandler(rpc.getDatum(1155));
			break;
		case 1162:
			rpc.setDatum(1163,ns.newDatum(1164));
			handler.saveHandler(rpc);
			break;
		case 1166:
			handler.loadHandler(rpc.getDatum(1167));
			break;
		case 1170:
			handler.wipeHandler();
			break;
		case 1173:
			rpc.setDatum(1174,ns.newDatum(1175));
			handler.javaHandler(rpc);
			break;
		case 1177:
			rpc.setDatum(1178,ns.newDatum(1179));
			handler.as3Handler(rpc);
			break;
		case 1181:
			handler.selectHandler();
			break;
		}
	}
	protected function hardCall(arg1159:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1159, arg1159);
		super.callToRemote(rpc, 1158);
	}
	protected function selectedIsCall(arg1185:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1185, arg1185);
		super.callToRemote(rpc, 1184);
	}
}
}