package azura.fractale.rtm
{
	import azura.common.swf.RtmEvent;
	
	import azura.common.algorithm.FastMath;
	import azura.common.ui.alert.Toast;
	
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.media.Microphone;
	import flash.media.SoundCodec;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;
	
	public class Rtm
	{
		protected var nc:NetConnection;
		
		public var client:RtmClient;
		
		protected var senderStream:NetStream;
		protected var receiverStream:NetStream;
		
		protected var url:String;
		protected var sendKey:String;
		protected var receiveKey:String;
		
		protected var youHearMe:Boolean;
		protected var iHearYou:Boolean;
		
		protected var iHearYouTimer:Timer;
		
		public var ready:Boolean;
		
		protected var twin:RtmTwin;
		
		private var challengeValue:int;
		
		internal var isConnected:Boolean;
		internal var failed:Boolean;
		
		public function Rtm(twin:RtmTwin)
		{
			this.twin=twin;
			client=new RtmClient(this);
		}
		
		internal function connect(url:String, sendKey:String,receiveKey:String):void{
			this.url=url;
			this.sendKey=sendKey;
			this.receiveKey=receiveKey;
			
			nc=new NetConnection();
			nc.addEventListener(NetStatusEvent.NET_STATUS,netConnectionHandler);
			nc.connect(url);
			trace("connecting to url ",url);
		}
		
		protected function netConnectionHandler(event:NetStatusEvent):void{
//			trace(event.info.code,toString());
			if ("NetConnection.Connect.Closed" == event.info.code){
				trace(event.info.code,url,sendKey);
			}else if("NetConnection.Connect.Failed" == event.info.code){
				failed=true;
				if(this is Rtmp)
					twin.forkFail.ready("rtmp");
				else
					twin.forkFail.ready("rtmfp");
			}
		}
		
		protected function netStreamHandler(event:NetStatusEvent):void{
			if ("NetStream.Play.Start" == event.info.code)
			{
				iHearYou=true;
				
				if(iHearYouTimer!=null)
					return;
				
				iHearYouTimer=new Timer(500,10);
				iHearYouTimer.addEventListener(TimerEvent.TIMER,onTick);
				iHearYouTimer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimeout);
				iHearYouTimer.start();
			}
		}
		
		private function onTick(te:TimerEvent):void{
			senderStream.send("iHearYou");
			if(youHearMe&&iHearYou){
				iHearYouTimer.removeEventListener(TimerEvent.TIMER,onTick);
				iHearYouTimer.stop();
				iHearYouTimer=null;
				
				ready=true;
				twin.channelReady(this);
			}
		}
		
		private function onTimeout(te:TimerEvent):void{
			trace("connection failed: timeout",this);
			iHearYouTimer.removeEventListener(TimerEvent.TIMER,onTick);
			iHearYouTimer.stop();
			iHearYouTimer=null;
		}
		
		internal function askMic():void{ 
			challengeValue=FastMath.random(1,999999);
			senderStream.send("askMic",challengeValue);
		}
		
		internal function close():void{
			if(iHearYouTimer!=null){
				iHearYouTimer.removeEventListener(TimerEvent.TIMER,onTick);
				iHearYouTimer.stop();
				iHearYouTimer=null;
			}
			if(nc!=null && nc.connected)
				nc.close();
			isConnected=false;
			ready=false;
			iHearYou=false;
			youHearMe=false;
			nc=null;
			senderStream=null;
			receiverStream=null;
		}
		
		internal function streamSaysIHearYou():void{
			youHearMe=true;
			isConnected=true;
		}
		
		internal function streamAskMic(remoteValue:int):void{
			if(twin.rtmToUse!=this){
				senderStream.send("retry");
				trace("retry, change channel");
			}else if(twin.rtmActive==null){
				doGiveMic();
			}else if(remoteValue==challengeValue){
				senderStream.send("retry");
				trace("retry, challenge equal");
			}else if(remoteValue>challengeValue){
				doGiveMic();
			}else{
				trace("ask collided, but i won, and awaiting the other side to deliver the mic");
			}
		}
		
		private function doGiveMic():void{
			challengeValue=0;
			twin.rtmActive=this;
			twin.micAt_local_center_remote=2;
			senderStream.send("giveMic");
			trace("give mic");
		}
		
		internal function streamRetry():void{
			twin.retry();
		}
		
		internal function streamGiveMic():void{
			twin.micAt_local_center_remote=0;
			twin.rtmActive=this;
			trace("mic obtained",this);
			var mic:Microphone=Mic.getMic();
			if(mic==null){
				Toast.show("未找到麦克风");
			}
			trace("speaking",this);
			senderStream.attachAudio(mic);
			
			twin.dispatchEvent(new RtmEvent(RtmEvent.RTM_MIC_OBTAINED));
		}
		
		internal function returnMic():void{
			twin.micAt_local_center_remote=1;
			senderStream.attachAudio(null);
			senderStream.send("returnMic");
		}
		
		internal function streamReturnMic():void{
			challengeValue=0;
			twin.micAt_local_center_remote=1;
			twin.rtmActive=null;
			if(twin.rtmToUse!=this){
				var re:RtmEvent=new RtmEvent(RtmEvent.RTM_CLOSE_CHANNEL);
				re.rtmp_rtmfp=this is Rtmp;
				twin.dispatchEvent(re);
			}
			trace("mic returned",this);
		}
		
		public function toString():String{
			if(this is Rtmp)
				return "rtmp";
			else
				return "rtmfp";
		}
	}
}