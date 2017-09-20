package azura.phoenix12.drop.karma.service{ 
import azura.expresso.Datum;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.RpcNodeI;
	public interface editSCI extends RpcNodeI{
		function hardHandler(arg1155:Datum):void;
		function saveHandler(ret1164:Rpc):void;
		function loadHandler(arg1167:Datum):void;
		function wipeHandler():void;
		function javaHandler(ret1175:Rpc):void;
		function as3Handler(ret1179:Rpc):void;
		function selectHandler():void;
	}
}