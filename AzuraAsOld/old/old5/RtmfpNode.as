package azura.fractale.rtm
{
	import flash.net.NetStream;

	public class RtmfpNode extends RtmBase
	{
		public function RtmfpNode(server:String, name:String)
		{
			super(server, name,true);
		}
		
		override public function play(listenStream:NetStream,speakerId:String):void{
			listenStream.play("p2p");
		}
		
		override public function newSpeakStream():NetStream{
			var ns:NetStream= new NetStream(_netConnection,NetStream.DIRECT_CONNECTIONS);
			ns.audioReliable=true;
			return ns;
		}
		
		override public function newListenerStream(idSpeaker:String):NetStream{
			return new NetStream(_netConnection,idSpeaker);
		}
		
		override public function publish():void{
			_speakStream.publish("p2p");
			super.speak(true);
		}
	}
}