package azura.common.algorithm.crypto {
	import com.hurlant.math.BigInteger;	
	
	public class DH {
		private static const prime:int= 999334939;
		private static const ground:int= 97;
		
		private var seed:int;
		private var halfKey:int;
		
		public function DH(){
			seed=Math.random()*prime;
			halfKey= modPow(ground, seed, prime);
		}
		
		public function getHalfKey():int {
			return halfKey;
		}
		
		public function getSharedKey(halfKeyOther:int):int {
			return modPow(halfKeyOther, seed, prime);
		}
		
		private function modPow(root:int, pow:int, mod:int):int {
			var bigRoot:BigInteger=new BigInteger(Number(root).toString(16));
			var bigMod:BigInteger=new BigInteger(Number(mod).toString(16));
			var mp:BigInteger=bigRoot.modPowInt(pow,bigMod);
			return mp.intValue();
		}
	}
}