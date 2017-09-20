package azura.karma.hard11.service
{
	import azura.common.collections.ZintBuffer;
	import azura.karma.def.KarmaSpace;
	import azura.karma.hard11.Hard11UI;
	import azura.karma.run.Karma;
	
	import zz.karma.Hard.Hub.HubCS.K_HardMsgCS;
	import zz.karma.Hard.Hub.HubSC.K_HardMsgSC;
	import zz.karma.Hard.Hub.K_CustomMsg;
	import zz.karma.Hard.Hub.K_HubCS;
	import zz.karma.Hard.Hub.K_HubSC;
	
	public class HubC_SC extends K_HubSC implements HardTunnelI
	{
		private var user:HardUserI;
		
		private var hardList:Vector.<HardC_SC>=new Vector.<HardC_SC>(8);
		
		public function HubC_SC(space:KarmaSpace,user:HardUserI)
		{
			super(space);
			this.user=user;
		}
		
		public function register(idx:int,ui:Hard11UI):void{
			var cs:HardC_SC=new HardC_SC(space,this);
			cs.ui=ui;
			ui.cs=cs;
			hardList[idx]=cs;
		}
		
		//============== send ======================
		public function sendHard(msg:Karma, by:HardC_SC):void
		{
			var idx:int=hardList.indexOf(by);
			
			var cs:K_HardMsgCS=new K_HardMsgCS(space);
			cs.idxHard=idx;
			cs.msgCS=msg;
			sendHub(cs.toKarma());
		}
		
		public function sendCustom(cargo:ZintBuffer):void{
			var c:K_CustomMsg=new K_CustomMsg(space);
			c.data=cargo;
			sendHub(c.toKarma());
		}
		
		public function sendHub(msg:Karma):void{
			var cs:K_HubCS=new K_HubCS(space);
			cs.send=msg;
			user.tunnelSend(cs.toBytes());
		}
		
		//================== receive ==================
		public function receive(zb:ZintBuffer):void{
			fromBytes(zb);
			if(send.type==T_HardMsgSC){
				receiveHard(send);
			}else if(send.type==T_CustomMsg){
				receiveCustom(send);
			}
		}
		
		private function receiveHard(msg:Karma):void{
			var hm:K_HardMsgSC=new K_HardMsgSC(space);
			hm.fromKarma(msg);
			
			var target:HardC_SC=hardList[hm.idxHard];
			target.receive(hm.msgSC);
		}
		
		private function receiveCustom(msg:Karma):void{
			var c:K_CustomMsg=new K_CustomMsg(space);
			c.fromKarma(msg);
			user.receiveCustom(c.data);
		}
	}
}