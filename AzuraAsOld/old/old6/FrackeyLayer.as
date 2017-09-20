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
		
		private var validated:Boolean=false;
		private var rc4Read:RC4;
		private var rc4Write:RC4;
		private var fc:FrackeyC;
		
		private var responded:Boolean;
		internal var isConnecting:Boolean;
		internal var isConnected:Boolean;
		
		private var receiveBuffer:ZintBuffer=new ZintBuffer();
		private var readMark:int=0;
		
		public function FrackeyLayer(upper:FrackSocketA)
		{
			this.upper=upper;
			socket=new Socket();
			//			socket.addEventListener(Event.CONNECT, socketConnectHandler);
			socket.addEventListener(Event.CLOSE, socketCloseHandler);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, validationHandler);
			socket.addEventListener(IOErrorEvent.IO_ERROR, ioHandler);
		}
		
		//		private function socketConnectHandler(event:Event):void
		//		{
		//			var b:ByteArray=new ByteArray();
		//			b.writeMultiByte("hello","iso-8859-1");
		//			socket.writeBytes(b);
		//			socket.flush();
		//		}
		
		internal function sendToNet(zb:ZintBuffer):void{
			
			trace("send to net");
			
			zb.position=0;
			var sendBuffer:ZintBuffer=zb.clone();
			
			var enc:ByteArray=rc4Write.process(sendBuffer);
			socket.writeBytes(enc);
			socket.flush();
		}
		
		internal function connect(config:FrackConfigI):void{
			isConnecting=true;
			fc=new FrackeyC(new HintBook(config.frackey));
			socket.connect(config.host,config.port);
		}
		
		internal function close():void{
			isConnecting=false;
			isConnected=true;
			socket.close();
		}
		
		private function validationHandler(event:ProgressEvent):void{
			if(socket.bytesAvailable<36)
				return;
			else if(socket.bytesAvailable==36){
				
				trace("validated");
				
				var challenge:ByteArray=new ByteArray();
				socket.readBytes(challenge,0,36);
				var response:ByteArray=fc.respond(challenge);
				var key:ByteArray=fc.key;
				key=MD5.b2b(key);
				fc=null;
				
				rc4Read=new RC4(key);
				rc4Write=rc4Read.clone();
				validated=true;
				socket.writeBytes(response);
				
				socket.removeEventListener(ProgressEvent.SOCKET_DATA, validationHandler);
				socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
				//				socket.addEventListener(ProgressEvent.SOCKET_DATA, helloHandler);
				socket.flush();
				
				isConnecting=false;
				isConnected=true;
				upper.onConnected.dispatch();
				
			}else{
				trace("validation failed :"+socket.bytesAvailable+"/36");
			}
		}
		
		//		private function helloHandler(event:ProgressEvent):void{
		//			if(socket.bytesAvailable<5)
		//				return;
		//			else{
		//				var hello:ByteArray=new ByteArray();
		//				socket.readBytes(hello,0,5);
		//				socket.removeEventListener(ProgressEvent.SOCKET_DATA, helloHandler);
		//				socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
		//				
		////				trace(hello+" "+socket.bytesAvailable);
		//				//connected
		//				isConnecting=false;
		//				isConnected=true;
		//				upper.onConnected.dispatch();
		//				
		//				if(socket.bytesAvailable>0)
		//					socketDataHandler(null);
		//			}
		//		}
		
		private function socketDataHandler(event:ProgressEvent):void{
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
					chunk=receiveBuffer.readBytes_();
					readMark=receiveBuffer.position;
				} 
				catch(error:EOFError) 
				{
					//					trace("ZintLayer: received piece "+shard.length/1000+"kb");
				}
				catch(error:Error){
					trace("ZintLayer: unmanaged error "+error.message);
				}finally{
					receiveBuffer.position=writeMark;
				}
				if(chunk!=null){
					upper.onSocketReceive.dispatch(chunk);
					//					upper.receivedFromNet(chunk);
					//					trace("ZintLayer: "+chunk.length/1000+"kb used. "+(writeMark-readMark)/1000+"kb left");
					return true;
				}else{
					return false;
				}
			}
		}
		
		private function ioHandler(event:IOErrorEvent):void{
			isConnecting=false;
			isConnected=false;
			//			upper.closeInternal();
			trace("socket error: \n"+event.toString());
		}
		
		private function socketCloseHandler(event:Event):void
		{
			isConnecting=false;
			isConnected=false;
			//			upper.closeInternal();
			trace("socket closed: \n"+event.toString());
		}
	}
}