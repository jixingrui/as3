package azura.phoenix12.drop.maze3.service{ 
import azura.expresso.Datum;
import azura.expresso.NameSpace;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.Rpcr;
import azura.expresso.rpc.RpcNodeA;
import azura.expresso.rpc.RpcTunnelI;
public class SwitchCSA extends RpcNodeA {
	private var handler:SwitchCSI;
	public function SwitchCSA(ns:NameSpace,tunnel:RpcTunnelI,handler:SwitchCSI){
		super(ns,tunnel);
		this.handler=handler;
	}
	override protected function serve(rpc:Rpc):void{
		switch(rpc.service){
		case 1041:
			handler.doorHandler(rpc.getDatum(1042));
			break;
		case 1045:
			handler.wooHandler(rpc.getDatum(1046));
			break;
		case 1062:
			handler.seekerHandler(rpc.getDatum(1063));
			break;
		}
	}
	protected function doorCall(arg1034:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1034, arg1034);
		super.callToRemote(rpc, 1033);
	}
	protected function wooCall(arg1037:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1037, arg1037);
		super.callToRemote(rpc, 1036);
	}
	protected function seekerCall(arg1059:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1059, arg1059);
		super.callToRemote(rpc, 1058);
	}
}
}