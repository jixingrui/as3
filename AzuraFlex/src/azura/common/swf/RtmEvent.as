package azura.common.swf
{
	import flash.events.Event;
	
	public class RtmEvent extends Event
	{
		public static var CS_CONNECT:String="CS_CONNECT";
		public static var CS_LISTEN_RTMFP:String="CS_LISTEN_RTMFP";
		public static var CS_CLOSE_CHAT:String="CS_CLOSE_CHAT";
		public static var CS_CLOSE_CHANNEL:String="CS_CLOSE_CHANNEL";
		
		public static var UI_ASK_MIC:String="UI_ASK_MIC";
		public static var UI_GIVEUP_MIC:String="UI_GIVEUP_MIC";
		
		public static var RTM_SERVER_FAIL:String="RTM_SERVER_FAIL";
		public static var RTM_CUMULUS:String="RTM_CUMULUS";
		public static var RTM_CHANNEL_AVAILABLE:String="RTM_CHANNEL_AVAILABLE";
		public static var RTM_MIC_OBTAINED:String="RTM_MIC_OBTAINED";
		public static var RTM_MIC_RETURNED:String="RTM_MIC_RETURNED";
		public static var RTM_MIC_ATREMOTE:String="RTM_MIC_ATREMOTE";
		public static var RTM_CLOSE_CHANNEL:String="RTM_CLOSE_CHANNEL";
		
		public var rtmpUrl:String;
		public var rtmfpUrl:String;
		public var senderKey:String;
		public var receiverKey:String;
		public var peerId:String;
		public var rtmp_rtmfp:Boolean;
		
		public function RtmEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event{
			var re:RtmEvent=new RtmEvent(type);
			re.rtmpUrl=rtmpUrl;
			re.rtmfpUrl=rtmfpUrl;
			re.senderKey=senderKey;
			re.receiverKey=receiverKey;
			re.peerId=peerId;
			re.rtmp_rtmfp=rtmp_rtmfp;
			return re;
		}
	}
}