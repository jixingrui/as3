package azura.expresso.rpc
{
	import azura.expresso.Datum;

	public class Rpcr extends Rpc
	{
		private var call_Datum:Function;
		
		public function Rpcr(node:RpcNodeA,call_Datum:Function)
		{
			super(node);
			this.call_Datum=call_Datum;
		}
		
		public function returnHandler(ret:Datum):void{
			call_Datum.call(null,ret);
		}
	}
}