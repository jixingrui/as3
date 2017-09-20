package azura.phoenix12.drop.maze3.service{ 
import azura.expresso.Datum;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.RpcNodeI;
	public interface DoorEditSCI extends RpcNodeI{
		function hardHandler(arg1008:Datum):void;
		function dumpHandler(ret1013:Rpc):void;
	}
}