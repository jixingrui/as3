package azura.helios.drass9
{
	import azura.common.collections.ZintBuffer;
	import azura.expresso.rpc.RpcTunnelI;
	import azura.helios.drass9.ui.Drass9;
	
	import flash.utils.Dictionary;
	
	public class DrassHub
	{
		public var tunnel:RpcTunnelI;
		public var drassId_DrassClient:Dictionary=new Dictionary();
		public var DrassClient_drassId:Dictionary=new Dictionary();
		
		public function DrassHub(tunnel:RpcTunnelI)
		{
			this.tunnel=tunnel;
		}
		
		public function connected():void{
//			for each(var cs:DrassClient in drassId_DrassClient){
//				cs.connected();
//			}
		}
		
		public function register(ui:Drass9,drassId:int):void{
			var cs:DrassClient=new DrassClient(ui,this);
			drassId_DrassClient[drassId]=cs;
			DrassClient_drassId[cs]=drassId;
			ui.cs=cs;
		}
		
		public function receive(zb:ZintBuffer):void{
			var drassId:int=zb.readZint();
			var dr:DrassClient=drassId_DrassClient[drassId];
			dr.receive(zb.readBytesZ());
		}
		
		public function send(zb:ZintBuffer,cs:DrassClient):void{
			var drassId:int=DrassClient_drassId[cs];
			
			var pack:ZintBuffer=new ZintBuffer();
			pack.writeZint(drassId);
			pack.writeBytesZ(zb);
			
			tunnel.tunnelSend(pack);
		}
		
		public function tunnelSend(zb:ZintBuffer,drassId:Number):void{
			var pack:ZintBuffer=new ZintBuffer();
			pack.writeZint(drassId);
			pack.writeBytesZ(zb);
			
			tunnel.tunnelSend(pack);
		}
	}
}