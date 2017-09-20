package azura.phoenix12.drop.zui.service{ 
import azura.expresso.Datum;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.RpcNodeI;
	public interface zuiCSI extends RpcNodeI{
		function hardHandler(arg1077:Datum):void;
		function tellActionHandler(arg1102:Datum):void;
		function tellScreenSettingHandler(arg1149:Datum):void;
	}
}