package azura.phoenix12.drop.maze3.service{ 
import azura.expresso.Datum;
import azura.expresso.rpc.Rpc;
import azura.expresso.rpc.RpcNodeI;
	public interface SwitchSCI extends RpcNodeI{
		function doorHandler(arg1034:Datum):void;
		function wooHandler(arg1037:Datum):void;
		function seekerHandler(arg1059:Datum):void;
	}
}