package azura.fractale.filter
{
	import azura.common.collections.ZintBuffer;
	
	import flash.errors.EOFError;
	import flash.utils.ByteArray;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	public class ZintLayer
	{
		// all network packets must be smaller than the cap
//		private static const LENGTHCAP:int = 524288;
		
		private var upper:FrackSocketA;
//		internal var fl:FrackeyLayer;
		private var receiveBuffer:ZintBuffer=new ZintBuffer();
		private var readMark:int=0;
//		private var timer:uint;
		
		public function ZintLayer(upper:FrackSocketA)
		{
			this.upper=upper;
		}
		
//		private var sendBuffer:ZintBuffer=new ZintBuffer();
//		public function sendToNet(zb:ZintBuffer):void{
//			zb.position=0;
//			if(zb.bytesAvailable<LENGTHCAP)
//				sendBuffer.writeBytes_(zb);
//			else
//				throw new Error("net send: packet too large");
//		}
		
//		private function sendToNetAction():void{
//			if(sendBuffer.position>0){
//				sendBuffer.position=0;
//				fl.sendToNet(sendBuffer);
//				sendBuffer=new ZintBuffer();
//			}
//		}
		
//		internal function connected():void{
////			timer=setInterval(sendToNetAction,50);
//			upper.connected();
//		}
		
//		internal function disconnected():void{
//			clearInterval(timer);
//			upper.closeInternal();
//		}
		
		internal function receiveFromNet(shard:ByteArray):void{
//			trace('ZintLayer received: '+shard.bytesAvailable/1000+"kb");
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
		
	}
}