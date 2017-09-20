package azura.fractale.rtm
{
	import azura.common.algorithm.FastMath;
	import azura.common.util.Fork;
	
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.setTimeout;
	
	import org.osflash.signals.Signal;
	
	public class Rtmfp extends Rtm
	{
		public var peerId:String;
		private var peerIdRemote:String;
		
		//		internal var onCumulus:Signal=new Signal(String);
		
		private var fork:Fork=new Fork(onFork,"localPeer","remotePeer");
		
		public function Rtmfp(twin:RtmTwin){
			super(twin);
		}
		
		override protected function netConnectionHandler(event:NetStatusEvent):void{
			super.netConnectionHandler(event);
			
			if ("NetConnection.Connect.Success" == event.info.code){
				
				peerId = nc.nearID;	
				senderStream=new NetStream(nc,NetStream.DIRECT_CONNECTIONS);
				senderStream.publish(sendKey);
				
				twin.cumulusConnected(peerId);
				
				fork.ready("localPeer");
			}
		}
		
		public function listen(peerIdRemote:String):void
		{
			this.peerIdRemote=peerIdRemote;
			fork.ready("remotePeer");
		}
		
		private function onFork():void{
			receiverStream=new NetStream(nc,peerIdRemote);
			receiverStream.client=client;
			receiverStream.addEventListener(NetStatusEvent.NET_STATUS,netStreamHandler);
			receiverStream.play(receiveKey);		
			//			setTimeout(receiverStream.play,FastMath.random(1000,5000),receiveKey);
		}
		
	}
}