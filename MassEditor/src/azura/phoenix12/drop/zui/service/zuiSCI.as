package azura.phoenix12.drop.zui.service{ 
import azura.expresso.Datum;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.RpcNodeI;
	public interface zuiSCI extends RpcNodeI{
		function hardHandler(arg1073:Datum):void;
		function saveHandler(ret1082:Rpc):void;
		function loadHandler(arg1085:Datum):void;
		function wipeHandler():void;
		function setTargetHandler():void;
		function reportActionHandler(ret1096:Rpc):void;
		function selectByActionHandler(arg1098:Datum):void;
		function saveMsgHandler(arg1106:Datum):void;
		function setScreenSettingHandler(arg1121:Datum):void;
		function getScreenSettingHandler(ret1126:Rpc):void;
		function selectToActionHandler(arg1133:Datum):void;
	}
}