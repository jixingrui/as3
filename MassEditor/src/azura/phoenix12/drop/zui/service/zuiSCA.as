package azura.phoenix12.drop.zui.service{ 
import azura.expresso.Datum;
import azura.expresso.NameSpace;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.Rpcr;
import azura.expresso.rpc.RpcNodeA;
import azura.expresso.rpc.RpcTunnelI;
public class zuiSCA extends RpcNodeA {
	private var handler:zuiSCI;
	public function zuiSCA(ns:NameSpace,tunnel:RpcTunnelI,handler:zuiSCI){
		super(ns,tunnel);
		this.handler=handler;
	}
	override protected function serve(rpc:Rpc):void{
		switch(rpc.service){
		case 1072:
			handler.hardHandler(rpc.getDatum(1073));
			break;
		case 1080:
			rpc.setDatum(1081,ns.newDatum(1082));
			handler.saveHandler(rpc);
			break;
		case 1084:
			handler.loadHandler(rpc.getDatum(1085));
			break;
		case 1088:
			handler.wipeHandler();
			break;
		case 1091:
			handler.setTargetHandler();
			break;
		case 1094:
			rpc.setDatum(1095,ns.newDatum(1096));
			handler.reportActionHandler(rpc);
			break;
		case 1097:
			handler.selectByActionHandler(rpc.getDatum(1098));
			break;
		case 1105:
			handler.saveMsgHandler(rpc.getDatum(1106));
			break;
		case 1120:
			handler.setScreenSettingHandler(rpc.getDatum(1121));
			break;
		case 1124:
			rpc.setDatum(1125,ns.newDatum(1126));
			handler.getScreenSettingHandler(rpc);
			break;
		case 1132:
			handler.selectToActionHandler(rpc.getDatum(1133));
			break;
		}
	}
	protected function hardCall(arg1077:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1077, arg1077);
		super.callToRemote(rpc, 1076);
	}
	protected function tellActionCall(arg1102:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1102, arg1102);
		super.callToRemote(rpc, 1101);
	}
	protected function tellScreenSettingCall(arg1149:Datum):void{
		var rpc:Rpc=new Rpc(this);
		rpc.setDatum(1149, arg1149);
		super.callToRemote(rpc, 1148);
	}
}
}