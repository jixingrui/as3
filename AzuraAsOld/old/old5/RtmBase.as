package azura.fractale.rtm
{
	import azura.fractale.stream.Mic;
	
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.ObjectEncoding;
	import flash.utils.Dictionary;
	
	public class RtmBase extends EventDispatcher
	{
		public var peerId:String;
		public var name:String;
		public var server:String;
		
		internal var _netConnection:NetConnection;
		internal var _speakStream:NetStream;
		private var id_Netstream:Dictionary=new Dictionary();
		private var hasF:Boolean;
		
		public function RtmBase(server:String,name:String,hasF:Boolean){
			this.name=name;
			this.server=server;
			this.hasF=hasF;
		}
		
		public function connect():void
		{
			_netConnection = new NetConnection();
			if(!hasF)
				_netConnection.objectEncoding=ObjectEncoding.AMF0;
			_netConnection.maxPeerConnections=20;
			_netConnection.addEventListener (NetStatusEvent.NET_STATUS, onNetConnectionStatus );
			_netConnection.connect(server);						
		}
		
		public function listen(speakerId:String):void{
			var listenStream:NetStream=newListenerStream(speakerId);
			id_Netstream[speakerId]=listenStream;
			
			var nsc:NetStreamClient=new NetStreamClient(speakerId,hasF);
			nsc.addEventListener(RtmEvent.LISTEN_READY,relay);
			nsc.addEventListener(RtmEvent.HEAR_HELLO,relay);
			nsc.addEventListener(RtmEvent.RECEIVE,relay);
			
			listenStream.addEventListener(NetStatusEvent.NET_STATUS,nsc.onNetStreamStatus);
			listenStream.bufferTime=0;
			listenStream.client = nsc;
			
			play(listenStream,speakerId);
			
			function relay(e:RtmEvent):void{
//				trace("RtmBase relay: "+e.type);
				dispatchEvent(e);
			}
		}
		
		public function disconnect(id:String):void{
			var ns:NetStream=id_Netstream[id];
			if(ns!=null){
				ns.close();
				delete id_Netstream[id];
			}
		}
		
		public function play(listenStream:NetStream,speakerId:String):void{
			throw IllegalOperationError("override this");
		}	
		
		public function publish():void{
			throw IllegalOperationError("override this");
		}
		
		public function newSpeakStream():NetStream{
			throw IllegalOperationError("override this");
		}
		
		public function newListenerStream(idSpeaker:String):NetStream{
			throw IllegalOperationError("override this");
		}
		
		public function speak(speak:Boolean):void{
			if(speak)
				_speakStream.attachAudio(Mic.getMicrophone());
			else
				_speakStream.attachAudio(null);
		}
		
		public function sayHello():void{
			_speakStream.send("hello",name);
		}
		
		public function type(text:String):void{
			_speakStream.send("type",text);
		}
		
		protected function onNetConnectionStatus( event:NetStatusEvent ):void
		{
//			trace("onNetStatus : "+ event.info.code );
			switch( event.info.code )
			{
				case "NetConnection.Connect.Success":
				{
					if(event.target.nearID!="")
						peerId = event.target.nearID;
					_speakStream=newSpeakStream();
					_speakStream.addEventListener( NetStatusEvent.NET_STATUS, speakerNetStreamStatus );
					_speakStream.bufferTime=0;
					publish();
					break;
				}
				case "NetConnection.Connect.Closed":
				case "NetConnection.Connect.Failed":
				case "NetConnection.Connect.Rejected":
				case "NetConnection.Connect.AppShutdown":
				case "NetConnection.Connect.InvalidApp":
				{
					var ec:RtmEvent=new RtmEvent(RtmEvent.CONNECTION_FAILED);
					dispatchEvent(ec);
					break;
				}
				default:
					break;
			}
		}	
		
		protected function speakerNetStreamStatus( event:NetStatusEvent ):void
		{
//			trace("speakerNetStreamStatus : "+ event.info.code );
			switch( event.info.code )
			{
				case "NetStream.Publish.Start":
				{
					var ec:RtmEvent=null;
					ec=new RtmEvent(RtmEvent.CONNECTED);
					ec.peerId=peerId;
					dispatchEvent(ec);
					break;
				}
			}
		}	
		
		public function close():void{
			_netConnection.close();
		}
	}
}