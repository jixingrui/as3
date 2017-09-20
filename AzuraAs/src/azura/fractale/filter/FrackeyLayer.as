package azura.fractale.filter
{
	import azura.common.algorithm.crypto.MD5;
	import azura.common.algorithm.crypto.RC4;
	import azura.common.collections.ZintBuffer;
	import azura.fractale.FrackConfigI;
	import azura.fractale.algorithm.FrackeyC;
	import azura.fractale.algorithm.HintBook;
	
	import flash.errors.EOFError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	public class FrackeyLayer
	{
		private var socket:Socket;
		private var upper:FrackSocketA;
		
		private var rc4Read:RC4;
		private var rc4Write:RC4;
		private var fc:FrackeyC;
		
		private var responded:Boolean;
		internal var isConnecting:Boolean;
		internal var isConnected:Boolean;
		
		private var receiveBuffer:ZintBuffer=new ZintBuffer();
		private var readMark:int=0;
		
		public static var socketSendTimes:int;
		public static var socketSendBytes:int;
		
		public static function showStat():void{
			trace("socket send",socketSendTimes,"times, total",socketSendBytes,"byte",FrackeyLayer);
		}
		
		public function FrackeyLayer(upper:FrackSocketA)
		{
			this.upper=upper;
			socket=new Socket();
			socket.addEventListener(Event.CLOSE, socketCloseHandler);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, validationHandler);
			socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		internal function sendToNet(zb:ZintBuffer):void{
			
			var packet:ZintBuffer=new ZintBuffer();
			packet.writeBytesZ(zb);
			
			var enc:ByteArray=rc4Write.process(packet);
//			trace("socket send ",enc.bytesAvailable,"byte",this);
			socketSendTimes++;
			socketSendBytes+=enc.bytesAvailable;
			socket.writeBytes(enc);
			socket.flush();
		}
		
		internal function connect(config:FrackConfigI):void{
			if(isConnecting || isConnected)
				throw new Error();
			
			isConnecting=true;
			fc=new FrackeyC(new HintBook(config.frackey));
			socket.connect(config.host,config.port);
			trace("connecting to",config.host,config.port,this);
		}
		
		internal function close():void{
			isConnecting=false;
			isConnected=true;
			socket.close();
		}
		
		private function validationHandler(event:ProgressEvent):void{
			if(rc4Read!=null){
				var hello:int=socket.readByte();
				if(hello!=123)
					trace("connection error: hello not match",this);
				
				trace("socket connected",hello,this);
				
				socket.removeEventListener(ProgressEvent.SOCKET_DATA, validationHandler);
				socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
				
				isConnecting=false;
				isConnected=true;
				
				upper.connected();
				
				socketDataHandler(null);
				
			}else if(socket.bytesAvailable<36)
				return;
			else if(socket.bytesAvailable==36){
				
				var challenge:ByteArray=new ByteArray();
				socket.readBytes(challenge,0,36);
				var response:ByteArray=fc.respond(challenge);
				var key:ByteArray=fc.key;
				key=MD5.b2b(key);
				fc=null;
				
				rc4Read=new RC4(key);
				rc4Write=rc4Read.clone();
				socket.writeBytes(response);
				socket.flush();
			}else{
				trace("validation failed :",socket.bytesAvailable+"/36",this);
			}
		}
		
		private function socketDataHandler(event:ProgressEvent):void{
//			trace("socket receive",socket.bytesAvailable,this);
			var enc:ByteArray=new ByteArray();
			socket.readBytes(enc,0,socket.bytesAvailable);
			var dec:ByteArray=rc4Read.process(enc);
			rollerReceive(dec);
		}
		
		private function rollerReceive(shard:ByteArray):void{
			receiveBuffer.writeBytes(shard);
			var writeMark:int=receiveBuffer.position;
			
			var rolling:Boolean=true;
			while(rolling){
				rolling=roll();
			}
			
			function roll():Boolean{
				var chunk:ZintBuffer=null;
				try
				{
					receiveBuffer.position=readMark;
					chunk=receiveBuffer.readBytesZ();
					readMark=receiveBuffer.position;
				} 
				catch(error:EOFError) 
				{
					//					trace("ZintLayer: received piece "+shard.length/1000+"kb");
				}
				catch(error:Error){
					trace("unmanaged error",error.message,this);
				}finally{
					receiveBuffer.position=writeMark;
				}
				if(chunk!=null && chunk.length>0){
//					trace("FrackLayer: "+chunk.length/1000+"kb used. "+(writeMark-readMark)/1000+"kb left", this);
					upper.onSocketReceive.dispatch(chunk);
					//					upper.receivedFromNet(chunk);
					return true;
				}else{
					return false;
				}
			}
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void{
			if(isConnected){
				trace("掉线了！和服务器的连接已断开。",this);
			}
//				AlertOk.show(null,"掉线了！和服务器的连接已断开。","网络错误");
			isConnecting=false;
			isConnected=false;
			//			trace("socket error: \n"+event.toString());
			upper.onSocketError.dispatch();
		}
		
		private function socketCloseHandler(event:Event):void
		{
			isConnecting=false;
			isConnected=false;
			trace("socket closed: \n"+event.toString(),this);
			upper.onDisconnected.dispatch();
		}
	}
}