package azura.fractale.rtm
{
	import flash.net.NetStream;
	import flash.net.ObjectEncoding;
	
	public class RtmpNode extends RtmBase
	{
		public function RtmpNode(server:String, name:String, tcpId:String)
		{
			super(server, name,false);
			super.peerId=tcpId;
		}
		
		override public function play(listenStream:NetStream,speakerId:String):void{
			listenStream.play(speakerId);
		}
		
		override public function newSpeakStream():NetStream{
			return new NetStream(_netConnection);
		}
		
		override public function newListenerStream(idSpeaker:String):NetStream{
			return new NetStream(_netConnection);
		}
		
		override public function publish():void{
			_speakStream.publish(peerId);
			super.speak(true);
		}
	}
}