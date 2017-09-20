package azura.fractale.rtm
{
	
	import azura.common.swf.RtmEvent;
	
	import azura.common.util.Fork;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.osflash.signals.Signal;
	
	public class RtmTwin
	{
		private var rtmp:Rtmp;
		private var rtmfp:Rtmfp;
		
		internal var rtmToUse:Rtm;
		internal var rtmActive:Rtm;
		
		internal var micAt_local_center_remote:int;
		
		internal var forkFail:Fork=new Fork(serverFail,"rtmp","rtmfp");
		
		private var dp:IEventDispatcher;
		public function RtmTwin(dispatcher:IEventDispatcher){
			this.dp=dispatcher;
		}
		
		internal function dispatchEvent(re:RtmEvent):void{
			dp.dispatchEvent(re);
		}
		
		private function serverFail():void{
			dispatchEvent(new RtmEvent(RtmEvent.RTM_SERVER_FAIL));
		}
		
		public function receiveEvent(re:RtmEvent):void{
			
			if(re.type==RtmEvent.CS_CONNECT){
				rtmp=new Rtmp(this);
				rtmp.connect(re.rtmpUrl,re.senderKey,re.receiverKey);
				
				rtmfp=new Rtmfp(this);
				rtmfp.connect(re.rtmfpUrl,re.senderKey,re.receiverKey);
			}else if(re.type==RtmEvent.CS_LISTEN_RTMFP){
				rtmfp.listen(re.peerId);
			}else if(re.type==RtmEvent.UI_ASK_MIC){
				if(rtmToUse==null){
					return;
				}else if(rtmActive==null){
					rtmActive=rtmToUse;
					rtmActive.askMic();
				}else if(micAt_local_center_remote==2){
					dispatchEvent(new RtmEvent(RtmEvent.RTM_MIC_ATREMOTE));
				}					
			}else if(re.type==RtmEvent.UI_GIVEUP_MIC){
				if(micAt_local_center_remote==0 && rtmActive!=null){
					rtmActive.returnMic();
					rtmActive=null;
				}
			}else if(re.type==RtmEvent.CS_CLOSE_CHANNEL){
				if(re.rtmp_rtmfp){
					rtmp.close();
				}else{
					rtmfp.close();
				}
			}else if(re.type==RtmEvent.CS_CLOSE_CHAT){
				rtmp.close();
				rtmfp.close();
				rtmToUse=null;
				rtmActive=null;
				micAt_local_center_remote=1;
			}
		}
		
		internal function cumulusConnected(peerId:String):void{
			var re:RtmEvent=new RtmEvent(RtmEvent.RTM_CUMULUS);
			re.peerId=peerId;
			dispatchEvent(re);
		}
		
		internal function retry():void{
			rtmActive=null;
			checkCloseRtmp();
			receiveEvent(new RtmEvent(RtmEvent.UI_ASK_MIC));
		}
		
		internal function channelReady(rtm:Rtm):void{
			if(rtmToUse==null){
				dispatchEvent(new RtmEvent(RtmEvent.RTM_CHANNEL_AVAILABLE));
			}
			if(rtm is Rtmfp){
				rtmToUse=rtm;
				checkCloseRtmp();
			}else if(rtmToUse==null){
				rtmToUse=rtm;
			}
		}
		
		internal function checkCloseRtmp():void{
			if(rtmToUse is Rtmfp && rtmActive==null){
				rtmp.close();
			}
		}
	}
}