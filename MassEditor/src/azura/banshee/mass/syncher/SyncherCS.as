package azura.banshee.mass.syncher
{
	import azura.expresso.Datum;
	import azura.phoenix12.drop.frackSS.param.Arg1135Hint;
	import azura.phoenix12.drop.frackSS.param.Arg1139Hint;
	import azura.phoenix12.drop.frackSS.param.Arg1143Hint;
	import azura.phoenix12.drop.frackSS.param.Ret1136Hint;
	import azura.phoenix12.drop.frackSS.service.hubCSA;
	import azura.phoenix12.drop.frackSS.service.hubCSI;
	
	public class SyncherCS extends hubCSA implements hubCSI
	{
		private var channelId:String;
		private var userId:String;
		
		public var sn:SyncherNet;
		
		public var view:SyncherPanel;
		
		public function SyncherCS(sn:SyncherNet)
		{
			super(sn.nsSyncher, sn, this);
		}
		
		public function register(channelId:String):void{
			this.channelId=channelId;
			var arg1135:Datum=ns.newDatum(Arg1135Hint.CLASS);
			arg1135.getBean(Arg1135Hint.channel_id).setString(channelId);
			registerCall(arg1135,ret);
			function ret(r:Datum):void{
				userId=r.getBean(Ret1136Hint.userId).asString();
				trace("my userId",userId,"SyncherCS");
			}
		}
		
		public function send(msg:String):void{
			var arg1139:Datum=ns.newDatum(Arg1139Hint.CLASS);
			arg1139.getBean(Arg1139Hint.msg).setString(msg);
			sendCall(arg1139);
		}
		
		public function receiveHandler(arg1143:Datum):void
		{
			var from:String=arg1143.getBean(Arg1143Hint.from).asString();
			var msg:String=arg1143.getBean(Arg1143Hint.msg).asString();
			trace("receive",msg,"from",from,this);
			
			if(from==this.userId)
				return;
			
			view.receive(msg);
		}
		
		public function connected():void
		{
			trace("connected",this);
		}
		
		public function disconnected():void
		{
		}
		
	}
}