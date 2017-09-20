package azura.fractale.algorithm
{
	
	import com.hurlant.util.Hex;
	
	import azura.common.algorithm.crypto.DH;
	import azura.common.algorithm.crypto.RC4;
	import azura.common.util.ByteUtil;
	
	import flash.utils.ByteArray;
	
	public class FrackeyC
	{
		private var book:HintBook;
		public var key:ByteArray;
		
		public function FrackeyC(book:HintBook)
		{
			this.book=book;
		}	
		
		/**
		 * @param challenge
		 *            length=36
		 * @return KeyExchangerC.key is now ready
		 */
		public function respond(challenge:ByteArray):ByteArray {
			if (challenge.length != 36)
				return null;
			
			var hint:ByteArray=new ByteArray();
			var rc4_halfKeyServer:ByteArray=new ByteArray();
			var rc4_nonce:ByteArray=new ByteArray();
			challenge.readBytes(hint,0,4);
			challenge.readBytes(rc4_nonce,0,28);
			challenge.readBytes(rc4_halfKeyServer,0,4);
			
			var bookKey:ByteArray=book.getKey(hint);
			if(bookKey==null)
			{
				bookKey=new ByteArray();
				for(var i:int=0;i<4;i++)
					bookKey.writeDouble(Math.random()*Number.MAX_VALUE);
			}
			
			var rc4Insecure:RC4=new RC4(bookKey);
			var halfKeyServer:ByteArray=rc4Insecure.process(rc4_halfKeyServer);
			var nonce:ByteArray=rc4Insecure.process(rc4_nonce);
			
			var dh:DH=new DH();
			var halfKeyClient:ByteArray=ByteUtil.int2Byte(dh.getHalfKey());
			var sk:ByteArray=ByteUtil.int2Byte(dh.getSharedKey(ByteUtil.byte2int(halfKeyServer)));
			
			var rc4_halfKeyClient:ByteArray=rc4Insecure.process(halfKeyClient);
			var rc4_nonceBack:ByteArray=rc4Insecure.process(nonce);
			
			var result:ByteArray=new ByteArray();
			result.writeBytes(rc4_halfKeyClient);
			result.writeBytes(rc4_nonceBack);
			
			key=new ByteArray();
			key.writeBytes(nonce);
			key.writeBytes(sk);
			key.writeBytes(halfKeyClient);
			
			return result;
		}
		
		private function show(ba:ByteArray):void{
			trace(Hex.fromArray(ba));
		}
	}
}