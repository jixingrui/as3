package azura.fractale.stream.udp
{
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	public class RtmfpClient
	{
		private var receiverStream:NetStream;
		public function RtmfpClient(rtmfp:NetConnection,idPublisherFar:String)
		{
			receiverStream=new NetStream(rtmfp,idPublisherFar);
			receiverStream.client=this;
			receiverStream.addEventListener(NetStatusEvent.NET_STATUS,receiverStatus);
			receiverStream.receiveAudio(true);
			receiverStream.play("p2p");
		}

		private function receiverStatus(event:NetStatusEvent):void{
			trace("bob stream: "+event.info.code);
		}
		
		public function finger(msg:String):void{
			trace("bob sees: "+msg);
		}
	}
}