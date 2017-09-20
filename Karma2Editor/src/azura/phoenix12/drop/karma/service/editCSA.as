package azura.phoenix12.drop.karma.service{ 
import azura.expresso.Datum;
import azura.expresso.NameSpace;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.Rpcr;
import azura.expresso.rpc.RpcNodeA;
import azura.expresso.rpc.RpcTunnelI;
public class editCSA extends RpcNodeA {
	private var handler:editCSI;
	public function editCSA(ns:NameSpace,tunnel:RpcTunnelI,handler:editCSI){
		super(ns,tunnel);
		this.handler=handler;
	}
	override protected function serve(rpc:Rpc):void{
		switch(rpc.service){
		case 1158:
			handler.hardHandler(rpc.getDatum(1159));
			break;
		case 1184:
			handler.selectedIsHandler(rpc.getDatum(1185));
			break;
		}
	}
	protected function hardCall(arg1155:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1155, arg1155);
		super.callToRemote(rpc, 1154);
	}
	protected function saveCall(func_Ret1164:Function):void{
		var ret1164:Rpcr=new Rpcr(this,func_Ret1164);
		ret1164.ruler=1164;
		super.callToRemoteRpcr(ret1164, 1162);
	}
	protected function loadCall(arg1167:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1167, arg1167);
		super.callToRemote(rpc, 1166);
	}
	protected function wipeCall():void{
		var rpc:Rpc=new Rpc(this);
		super.callToRemote(rpc, 1170);
	}
	protected function javaCall(func_Ret1175:Function):void{
		var ret1175:Rpcr=new Rpcr(this,func_Ret1175);
		ret1175.ruler=1175;
		super.callToRemoteRpcr(ret1175, 1173);
	}
	protected function as3Call(func_Ret1179:Function):void{
		var ret1179:Rpcr=new Rpcr(this,func_Ret1179);
		ret1179.ruler=1179;
		super.callToRemoteRpcr(ret1179, 1177);
	}
	protected function selectCall():void{
		var rpc:Rpc=new Rpc(this);
		super.callToRemote(rpc, 1181);
	}
}
}