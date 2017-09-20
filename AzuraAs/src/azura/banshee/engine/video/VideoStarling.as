package azura.banshee.engine.video
{
	import azura.banshee.engine.TextureResI;
	import azura.common.async2.AsyncLoader2;
	import azura.common.util.Fork;
	
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import org.osflash.signals.Signal;
	
	import starling.textures.Texture;
	
	public class VideoStarling extends AsyncLoader2 implements VideoI,TextureResI
	{
		private var url:String;
		
		private var _netConnection:NetConnection;
		private var _netStream:NetStream;
		private var _texture:Texture;
		
		private var _duration:Number=0;
		private var _width:Number=0;
		private var _height:Number=0;
		
		private var _onStart:Signal=new Signal();
		private var _onClose:Signal=new Signal();
		
		private var cycle_:Boolean;
		
		private var fork:Fork=new Fork(trueStart,"meta","start");
		
		public var timeoutTime:int=2000;
		
		public function VideoStarling(url:String)
		{
			super(url);
			this.url=url;
		}
		
		public function get onStart():Signal
		{
			return _onStart;
		}
		
		public function get onClose():Signal
		{
			return _onClose;
		}
		
		public function get height():Number
		{
			return _height;
		}
		
		public function set height(value:Number):void
		{
			_height = value;
		}
		
		public function get width():Number
		{
			return _width;
		}
		
		public function set width(value:Number):void
		{
			_width = value;
		}
		
		public function get duration():Number
		{
			return _duration;
		}
		
		public function set duration(value:Number):void
		{
			_duration = value;
		}
		
		public function onMetaData(width:Number,height:Number,duration:Number):void{
			_width=width;
			_height=height;
			_duration=duration;
			
			//			Toast.show("video meta w="+width+" h= "+height+" duration="+duration);
			fork.ready("meta");
		}
		
		override public function process():void{
			_netConnection = new NetConnection();
			_netConnection.addEventListener(NetStatusEvent.NET_STATUS,onNetStatusNC);
			_netConnection.connect(null);
			_netStream = new NetStream(_netConnection);
			_netStream.addEventListener(NetStatusEvent.NET_STATUS,onNetStatusNS);
			_netStream.client=new NsClientReporter(this);
			_netStream.inBufferSeek=true;
			Texture.fromNetStream(_netStream, 1, textureLoaded);
			_netStream.play(url);
			
			timeout=setTimeout(replay,timeoutTime);
			
			function textureLoaded(texture:Texture):void{
				trace("submit",this);
				clearTimeout(timeout);
				timeout=0;
				retryCount=0;
				_texture=texture;
				submit(texture);
			}
		}
		
		private var timeout:uint;
		private var retryCount:int=0;
		private var retrying:Boolean;
		private function replay():void{
			trace("video timeout, try again",this);
			retrying=true;
			retryCount++;				
			if(retryCount>1){
				onClose.dispatch();
			}else{
				_netStream.close();
				_netStream.play(url);
				timeout=setTimeout(replay,timeoutTime);
			}
		}
		
		private function onNetStatusNS(nse:NetStatusEvent):void{
			trace(nse.info.code,this);
			if(nse.info.code=="NetStream.Play.Start"){
				trace("fork:start",this);
				fork.ready("start");
			}else if (nse.info.code == "NetStream.Buffer.Flush") {
				if(cycle_){
					_netStream.seek(0);
				}
			}else if (nse.info.code == "NetStream.Play.Stop") {
				//				trace("videstop",this);
				if(retrying)
					retrying=false;
				else
					onClose.dispatch();
			}else if (nse.info.code == "NetStream.Play.Failed") {
				trace("video failed",this);
				clearTimeout(timeout);
				onClose.dispatch();
			}
		}
		
		private function onNetStatusNC(nse:NetStatusEvent):void{
			trace(nse.info.code,this);
		}
		
		private function trueStart():void{
			trace("true start",this);
			onStart.dispatch();
		}
		
		override public function dispose():void{
			_netStream.close();
			_netStream=null;
			_netConnection.close();
			_netConnection=null;
			_texture.dispose();
			_texture=null;
		}
		
		public function cycle(value:Boolean):void
		{
			this.cycle_=value;
		}
		
		public function pause():void
		{
			_netStream.pause();
		}
		
		public function close():void{
			//			_netStream.close();
			trace("video close",key,this);
			release(0);
			onClose.dispatch();
		}
		
		public function resume():void
		{
			_netStream.resume();
		}
		
		public function seek(time:Number):void
		{
			_netStream.seek(time);
		}
		
		public function get time():Number
		{
			if(_netStream!=null)
				return _netStream.time;
			else
				return 0;
		}
		
		//================ display resource ============
		public function get texture():Object
		{
			return _texture;
		}
		
		public function get pivotX():Number
		{
			return 0;
		}
		
		public function get pivotY():Number
		{
			return 0;
		}
		
		public function get center_LT():Boolean
		{
			return true;
		}
		
		//		public function get smoothing():Boolean
		//		{
		//			return true;
		//		}
	}
}