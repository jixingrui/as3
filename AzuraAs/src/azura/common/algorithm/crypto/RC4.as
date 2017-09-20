package azura.common.algorithm.crypto {
	import flash.utils.ByteArray;
	
	public class RC4 {
		
		private var state:ByteArray=new ByteArray();
		private var x:int;
		private var y:int;
		
		public function RC4(key:ByteArray=null){
			
			if (key == null) {
				return;
			}
			
			for (var i:int= 0; i < 256; i++) {
				state[i] = i;
			}
			
			x = 0;
			y = 0;
			
			var index1:int= 0;
			var index2:int= 0;
			
			var tmp:uint;
			
			for (var j:int= 0; j < 256; j++) {
				
				index2 = ((key[index1] & 0xff) + (state[j] & 0xff) + index2) & 0xff;
				
				tmp = state[j];
				state[j] = state[index2];
				state[index2] = tmp;
				
				index1 = (index1 + 1) % key.length;
			}
			
		}
		
		public function process(buf:ByteArray):ByteArray {
			
			var xorIndex:int;
			var tmp:uint;
			
			if (buf == null) {
				return null;
			}
			
			var result:ByteArray= new ByteArray();
			
			for (var i:int= 0; i < buf.length; i++) {
				
				x = (x + 1) & 0xff;
				y = ((state[x] & 0xff) + y) & 0xff;
				
				tmp = state[x];
				state[x] = state[y];
				state[y] = tmp;
				
				xorIndex = ((state[x] & 0xff) + (state[y] & 0xff)) & 0xff;
				result[i] = (buf[i] ^ state[xorIndex]);
			}
			
			return result;
		}
		
		public function clone():RC4 {
			var result:RC4= new RC4();
			this.state.readBytes(result.state);
			result.x = this.x;
			result.y = this.y;
			return result;
		}
	}
}