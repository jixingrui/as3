package azura.phoenix12.drop.frackSS.service{ 
import azura.expresso.Datum;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.RpcNodeI;
	public interface hubSCI extends RpcNodeI{
		function registerHandler(arg1135:Datum, ret1136:Rpc):void;
		function sendHandler(arg1139:Datum):void;
	}
}