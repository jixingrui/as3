package azura.phoenix12.drop.maze3.service{ 
import azura.expresso.Datum;
import azura.expresso.NameSpace;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.Rpcr;
import azura.expresso.rpc.RpcNodeA;
import azura.expresso.rpc.RpcTunnelI;
public class SwitchSCA extends RpcNodeA {
	private var handler:SwitchSCI;
	public function SwitchSCA(ns:NameSpace,tunnel:RpcTunnelI,handler:SwitchSCI){
		super(ns,tunnel);
		this.handler=handler;
	}
	override protected function serve(rpc:Rpc):void{
		switch(rpc.service){
		case 1033:
			handler.doorHandler(rpc.getDatum(1034));
			break;
		case 1036:
			handler.wooHandler(rpc.getDatum(1037));
			break;
		case 1058:
			handler.seekerHandler(rpc.getDatum(1059));
			break;
		}
	}
	protected function doorCall(arg1042:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1042, arg1042);
		super.callToRemote(rpc, 1041);
	}
	protected function wooCall(arg1046:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1046, arg1046);
		super.callToRemote(rpc, 1045);
	}
	protected function seekerCall(arg1063:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1063, arg1063);
		super.callToRemote(rpc, 1062);
	}
}
}