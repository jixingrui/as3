package azura.helios.hard10.hub
{
	import azura.common.collections.DictionaryUtil;
	import azura.common.collections.ZintBuffer;
	import azura.expresso.rpc.RpcTunnelI;
	import azura.helios.hard10.ui.Hard10UI;
	
	import flash.utils.Dictionary;
	
	public class HardHub
	{
		private var tunnel:RpcTunnelI;
		
		private var id_HardCS:Dictionary=new Dictionary();
		
		public function HardHub(tunnel:RpcTunnelI)
		{
			this.tunnel=tunnel;
		}
		
		public function connected():void{
		}
		
		public function receive(zb:ZintBuffer):void{
			var drassId:int=zb.readZint();
			var dr:HardCS=id_HardCS[drassId];
			dr.receive(zb.readBytesZ());
		}
		
		public function send(id:int, zb:ZintBuffer):void{			
			var pack:ZintBuffer=new ZintBuffer();
			pack.writeZint(id);
			pack.writeBytesZ(zb);
			
			tunnel.tunnelSend(pack);
		}
		
		public function register(ui:Hard10UI):void{
			for each(var old:HardCS in id_HardCS){
				if(ui==old.ui)
					throw new Error();
			}
			var length:int=DictionaryUtil.getLength(id_HardCS);
			var cs:HardCS=new HardCS(length,ui,this);
			ui.cs=cs;
			id_HardCS[cs.id]=cs;
			cs.ui.start();
		}
		
	}
}