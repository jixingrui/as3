package azura.fractale.algorithm {
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	
	public class HintBook {
		private static const hintSize:int= 4;
		private static const keySize:int= 32;
		private static const bookSize:int= 360;
		public static const dataLength:int= (hintSize + keySize) * bookSize;
		
		private var book:ByteArray;
		private var hint_index:Dictionary=new Dictionary();
		
		public function HintBook(data:ByteArray) {
			if (data.length == dataLength) {
				book = data;
				for (var i:int= 0; i < bookSize; i++) {
					var hint:ByteArray= new ByteArray();
					book.readBytes(hint,0,hintSize);
					hint_index[hint.toString()]=i;
				}
			} else
				throw new Error("data length must be "
					+ dataLength);
		}
		
		public function getKey(hint:ByteArray):ByteArray {
			if(hint_index[hint.toString()]==undefined)
				return null;
			var index:int= hint_index[hint.toString()];
			if (index >= 0&& index < bookSize) {
				var key:ByteArray= new ByteArray();
				book.position=hintSize * bookSize + index * keySize;
				book.readBytes(key,0,keySize);
				return key;
			} else {
				return null;
			}
		}
	}
}