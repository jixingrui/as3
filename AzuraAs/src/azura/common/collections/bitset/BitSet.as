package azura.common.collections.bitset {
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	
	public class BitSet implements BytesI{
		
		private static /*final*/ const CAR_MASK:int = 0xffffffff;
		
		private var train:Vector.<int>=new Vector.<int>() /* int */;
		
		private static function carIndex(bitIndex:int):int {
			return bitIndex>>5;
		}
		
		private function ensureCapacity(carIndex:int):void {
			var size:int=carIndex+1;
			if (train.length < size) {
				var oldLength:int=train.length;
				for(var i:int=oldLength;i<size;i++){
					train.push(0);
				}
			} 
		}
		
		private static function checkRange(fromIndex:int, toIndex:int):void {
			if (fromIndex < 0)
				throw new Error("fromIndex < 0: " + fromIndex);
			
			if (toIndex < 0)
				throw new Error("toIndex < 0: " + toIndex);
			
			if (fromIndex > toIndex)
				throw new Error((("fromIndex: " + fromIndex) + " > toIndex: ") + toIndex);
			
		}
		
		public function getBitAt(bitIndex:int):Boolean {
			if (bitIndex < 0)
				throw new Error("bitIndex < 0: " + bitIndex);
			
			var carIndex:int = carIndex(bitIndex);
			return (carIndex < train.length) && ((train[carIndex] & (1 << bitIndex)) != 0);
		}
		
		public function setBitAt(bitIndex:int,truth:Boolean=true):BitSet {
			if(truth==false)
				return clearBitAt(bitIndex);
			
			if (bitIndex < 0)
				throw new Error("bitIndex < 0: " + bitIndex);
			
			var carIndex:int = carIndex(bitIndex);
			ensureCapacity(carIndex);
			train[carIndex] |= 1 << bitIndex;
			
			return this;
		}
		
		private function clearBitAt(bitIndex:int):BitSet {
			if (bitIndex < 0)
				throw new Error("bitIndex < 0: " + bitIndex);
			
			var carIndex:int = carIndex(bitIndex);
			if (carIndex >= train.length)
				return this;
			
			train[carIndex] &= ~(1 << bitIndex);
			
			recalculateCarsInUse();
			
			return this;
		}
		
		private function recalculateCarsInUse():void {
			var i:int=train.length-1;
			while((i>=0)&&train[i]==0){
				train.pop();
				i--;
			}
		}
		
		public function setRange(fromIndex:int, toIndex:int):void {
			checkRange(fromIndex, toIndex);
			if (fromIndex == toIndex)
				return ;
			
			var startCarIndex:int = carIndex(fromIndex);
			var endCarIndex:int = carIndex(toIndex - 1);
			ensureCapacity(endCarIndex);
			var firstCarMask:Number = CAR_MASK << fromIndex;
			var lastCarMask:Number = CAR_MASK >>> -toIndex;
			if (startCarIndex == endCarIndex) {
				train[startCarIndex] |= firstCarMask & lastCarMask;
			} else {
				train[startCarIndex] |= firstCarMask;
				for (var i:int = startCarIndex + 1 ; i < endCarIndex ; i++)
					train[i] = CAR_MASK;
				train[endCarIndex] |= lastCarMask;
			}
		}
		
		public function get length():int{
			return train.length*32;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			var lbs:LBSet=new LBSet();
			lbs.fromBytes(zb);
			var copy:BitSet=lbs.toBitSet();
			copyFrom(copy);
		}
		
		public function toBytes():ZintBuffer
		{
			var lbs:LBSet=new LBSet();
			lbs.fromBitSet(this);
			return lbs.toBytes();
		}
		
		public function copyFrom(bs:BitSet):void{
			this.train=bs.train.slice();
		}
		
		public function clear():void{
			this.train=new Vector.<int>();
		}
		
	}
	
	
}