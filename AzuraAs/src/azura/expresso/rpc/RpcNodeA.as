package azura.expresso.rpc {
	import azura.common.collections.IdGenStore;
	import azura.common.collections.ZintBuffer;
	import azura.expresso.NameSpace;
	
	import flash.errors.IllegalOperationError;
	
	/**
	 * 
	 * capability missing: server asks client to return something. this is intended for security reason.
	 * 
	 */
	public class RpcNodeA {
		//abstract
		protected function serve(rpcWithArg:Rpc):void {throw new IllegalOperationError("RpcNodeA.serve: please override");}
		
		private static var session_Rpcr:IdGenStore = new IdGenStore()
		
		public var ns:NameSpace;
		private var tunnel:RpcTunnelI;
		
		public function RpcNodeA(ns:NameSpace,tunnel:RpcTunnelI) {
			this.ns = ns;
			this.tunnel=tunnel;
		}
		
		final protected function callToRemote(rpc:Rpc, service:int):void {
			rpc.type=Rpc.Single;			
			rpc.service = service;
			tunnelSend(rpc);
		}
		
		final protected function callToRemoteRpcr(rpcShell:Rpcr, service:int):void {
			rpcShell.type=Rpc.Bi_Call;
			rpcShell.service=service;
			rpcShell.session = session_Rpcr.add(rpcShell);
			tunnelSend(rpcShell);
		}
		
		final internal function returnToRemote(rpcWithReturn:Rpc):void {
			tunnelSend(rpcWithReturn);
		}
		
		private function tunnelSend(rpc:Rpc):void{
			tunnel.tunnelSend(rpc.encode());
		}
		
		final public function tunnelReceive(zb:ZintBuffer):void {
			var rpc:Rpc= new Rpc(this);
			rpc.decode(zb);
			switch(rpc.type)
			{
				case Rpc.Single:
				case Rpc.Bi_Call:
				{
					serve(rpc);
				}
					break;
				case Rpc.Bi_Return:{
					var shell:Rpcr= session_Rpcr.remove(rpc.session);
					shell.returnHandler(rpc.getDatum(shell.ruler));
				}
					break;							
				default:
				{
					break;
				}
			}
		}
		
		
	}
}