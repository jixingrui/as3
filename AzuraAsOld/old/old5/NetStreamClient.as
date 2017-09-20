package azura.fractale.rtm
{
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.utils.setTimeout;
	
	public class NetStreamClient extends EventDispatcher
	{
		private var speakerId:String;
		private var speakerName:String;
		private var listenReady:Boolean;
		private var udp_tcp:String;
		private var helloHappened:Boolean;
		
		public function NetStreamClient(speakerId:String,udp_tcp:Boolean){
			this.speakerId=speakerId;
			if(udp_tcp)
				this.udp_tcp="udp";
			else
				this.udp_tcp="tcp";
			
			setTimeout(timeout,5000);
		}
		
		public function timeout():void{
			if(helloHappened)
				return;
			
			trace("hello timeout: "+udp_tcp);
			helloHappened=true;
			var e:RtmEvent=new RtmEvent(RtmEvent.HEAR_HELLO);
			e.success=false;
			e.peerId=speakerId;
			dispatchEvent(e);
		}
		
		public function hello(name:String):void{
			trace("hear hello: "+udp_tcp);
			
			if(helloHappened)
				return;
			
			helloHappened=true;
			speakerName=name;
			
			var e:RtmEvent=new RtmEvent(RtmEvent.HEAR_HELLO);
			e.success=true;
			e.peerId=speakerId;
			dispatchEvent(e);
		}
		
		public function type(text:String):void{
			var e:RtmEvent=new RtmEvent(RtmEvent.RECEIVE);
			e.peerId=speakerId;
			e.text=speakerName+"("+udp_tcp+"):"+text;
			dispatchEvent(e);
		}
		
		internal function onNetStreamStatus( event:NetStatusEvent ):void
		{
//			trace("onNetStreamStatus : "+ event.info.code );
			switch( event.info.code )
			{
				case "NetStream.Play.Start":
				{
					if(!listenReady){
						listenReady=true;
						
						var el:RtmEvent=new RtmEvent(RtmEvent.LISTEN_READY);
						el.peerId=speakerId;
						dispatchEvent(el);
					}
					break;
				}
			}
		}
	}
}