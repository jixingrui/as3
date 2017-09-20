package azura.fractale.rtm
{
	import azura.common.algorithm.FastMath;
	
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	public class Rtmp extends Rtm
	{
		
		public function Rtmp(twin:RtmTwin){
			super(twin);
		}
				
		override protected function netConnectionHandler(event:NetStatusEvent):void{
			super.netConnectionHandler(event);
			
			if ("NetConnection.Connect.Success" == event.info.code)
			{
				senderStream=new NetStream(nc);
				senderStream.publish(sendKey);
				
				receiverStream=new NetStream(nc);
				receiverStream.client=client;
				receiverStream.addEventListener(NetStatusEvent.NET_STATUS,netStreamHandler);
				receiverStream.play(receiveKey);
//				setTimeout(receiverStream.play,FastMath.random(1000,3000),receiveKey);
			}
		}
	}
}

