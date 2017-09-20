package azura.fractale.stream.udp
{
	import flash.events.NetStatusEvent;
	import flash.media.Microphone;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Dictionary;
	
	public class Rtmfp
	{
		private static var instance:Rtmfp = new Rtmfp();	
		public function Rtmfp() {			
			if( instance ) throw new Error( "Singleton can only be accessed through Singleton.getInstance()" ); 
			rtmfp = new NetConnection();
			rtmfp.addEventListener(NetStatusEvent.NET_STATUS,rtmfpListener);
//			rtmfp.connect(cirrus,DEVELOPER_KEY);
			rtmfp.connect(cumulus);
		}		
		public static function getInstance():Rtmfp {			
			return instance;			
		}
		
		private const cumulus:String = "rtmfp://121.199.0.249";
		private const cirrus:String = "rtmfp://p2p.rtmfp.net";
		private const DEVELOPER_KEY:String = "72d1729cd761b216584be95b-89efddcac283";
		
		private var rtmfp:NetConnection;
		public var idRtmfp:String;
		private var publisherStream:NetStream;
		private var callBack_idRtmfp:Function;
		
		private var publisherReady:Boolean;
		
		public var id_Client:Dictionary=new Dictionary();
		
		public function lazyGetId(callBack_idRtmfp:Function):void{
			this.callBack_idRtmfp=callBack_idRtmfp;
			
			lazyTellId();
		}
		
		private function lazyTellId():void{
			if(publisherReady && callBack_idRtmfp!=null){
				callBack_idRtmfp.call(this,idRtmfp);
				callBack_idRtmfp=null;
			}
		}
		
		public function listen(idPublisherFar:String):void{
			var client:RtmfpClient=new RtmfpClient(rtmfp,idPublisherFar);
			id_Client[idPublisherFar]=client;
		}
		
		public function speak(words:String):void{
			publisherStream.send("finger",words);
		}
		
		private function rtmfpListener(event:NetStatusEvent):void{
			trace("rtmfp: "+event.info.code);
			
//			return;//=======================3/3
			
			if(idRtmfp==null){
				//rtmfp init
				idRtmfp = rtmfp.nearID;		
				
				publisherStream=new NetStream(rtmfp,NetStream.DIRECT_CONNECTIONS);
				publisherStream.addEventListener(NetStatusEvent.NET_STATUS,onPublished);
				publisherStream.attachAudio(Microphone.getEnhancedMicrophone());
				
				var publisherHandler:Object = new Object();
				publisherHandler.onPeerConnect = function(receiver:NetStream):Boolean{
					trace("receiver connects: "+receiver.farID);
					
					return true;
				}				
				publisherStream.client = publisherHandler;
				publisherStream.publish("p2p");
				
			}
			
		}
		
		private function onPublished(event:NetStatusEvent):void{
			trace("publisher stream: "+event.info.code);
			if(!publisherReady){
				publisherReady=true;
				lazyTellId();
			}
		}
		
	}
}