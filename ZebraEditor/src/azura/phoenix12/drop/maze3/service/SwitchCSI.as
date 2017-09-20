package azura.phoenix12.drop.maze3.service{ 
import azura.expresso.Datum;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.RpcNodeI;
	public interface SwitchCSI extends RpcNodeI{
		function doorHandler(arg1042:Datum):void;
		function wooHandler(arg1046:Datum):void;
		function seekerHandler(arg1063:Datum):void;
	}
}