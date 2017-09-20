package azura.phoenix12.drop.zui.service{ 
import azura.expresso.Datum;
import azura.expresso.NameSpace;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.Rpcr;
import azura.expresso.rpc.RpcNodeA;
import azura.expresso.rpc.RpcTunnelI;
public class zuiCSA extends RpcNodeA {
	private var handler:zuiCSI;
	public function zuiCSA(ns:NameSpace,tunnel:RpcTunnelI,handler:zuiCSI){
		super(ns,tunnel);
		this.handler=handler;
	}
	override protected function serve(rpc:Rpc):void{
		switch(rpc.service){
		case 1076:
			handler.hardHandler(rpc.getDatum(1077));
			break;
		case 1101:
			handler.tellActionHandler(rpc.getDatum(1102));
			break;
		case 1148:
			handler.tellScreenSettingHandler(rpc.getDatum(1149));
			break;
		}
	}
	protected function hardCall(arg1073:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1073, arg1073);
		super.callToRemote(rpc, 1072);
	}
	protected function saveCall(func_Ret1082:Function):void{
		var ret1082:Rpcr=new Rpcr(this,func_Ret1082);
		ret1082.ruler=1082;
		super.callToRemoteRpcr(ret1082, 1080);
	}
	protected function loadCall(arg1085:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1085, arg1085);
		super.callToRemote(rpc, 1084);
	}
	protected function wipeCall():void{
		var rpc:Rpc=new Rpc(this);
		super.callToRemote(rpc, 1088);
	}
	protected function setTargetCall():void{
		var rpc:Rpc=new Rpc(this);
		super.callToRemote(rpc, 1091);
	}
	protected function reportActionCall(func_Ret1096:Function):void{
		var ret1096:Rpcr=new Rpcr(this,func_Ret1096);
		ret1096.ruler=1096;
		super.callToRemoteRpcr(ret1096, 1094);
	}
	protected function selectByActionCall(arg1098:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1098, arg1098);
		super.callToRemote(rpc, 1097);
	}
	protected function saveMsgCall(arg1106:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1106, arg1106);
		super.callToRemote(rpc, 1105);
	}
	protected function setScreenSettingCall(arg1121:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1121, arg1121);
		super.callToRemote(rpc, 1120);
	}
	protected function getScreenSettingCall(func_Ret1126:Function):void{
		var ret1126:Rpcr=new Rpcr(this,func_Ret1126);
		ret1126.ruler=1126;
		super.callToRemoteRpcr(ret1126, 1124);
	}
	protected function selectToActionCall(arg1133:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1133, arg1133);
		super.callToRemote(rpc, 1132);
	}
}
}