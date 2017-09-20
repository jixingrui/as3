package azura.common.collections.bitset
{
	public class BitArray{
		
		public var bits:Array;
		public var Size:int;
		
		public function BitArray(size:int) {
			if (size < 1) {
				throw new Error("BitArray : size must be at least 1");
			}
			this.Size = size;
			this.bits = makeArray(size);
		}
		
		public function getSize():int {
			return Size;
		}
		
		public  function getSizeInBytes():int 
		{
			return (this.Size + 7) >> 3;
		}
		
		private function ensureCapacity(size:int):void 
		{
			if (size > bits.length << 5) 
			{
				var newArray:Array = new Array(size);
				if (bits != null)
				{
//					System.Array.Copy(bytes, 0, newArray, 0, bytes.length);
					for (var i:int=0;i<bits.length;i++)
					{
						newArray[i] = bits[i];
					}
				}
				
				this.bits = newArray;
			}
		}
		
		/**
		 * @param i bit to get
		 * @return true iff bit i is set
		 */
		public function _get(i:int):Boolean {
			return (bits[i >> 5] & (1 << (i & 0x1F))) != 0;
		}
		
		/**
		 * Sets bit i.
		 *
		 * @param i bit to set
		 */
		public function _set(i:int):void {
			bits[i >> 5] |= 1 << (i & 0x1F);
		}
		
		public function setRange(start:int, end:int, value:Boolean):Boolean {
			if (end < start) 
				throw new Error("BitArray isRange : end before start");
			if (end == start) 
				return true; // empty range matches

			ensureCapacity(end);
			
			end--; // will be easier to treat this as the last actually set bit -- inclusive    
			var firstInt:int = start >> 5;
			var lastInt:int = end >> 5;
			for (var i:int = firstInt; i <= lastInt; i++) {
				var firstBit:int = i > firstInt ? 0 : start & 0x1F;
				var lastBit:int = i < lastInt ? 31 : end & 0x1F;
				var mask:int;
				if (firstBit == 0 && lastBit == 31) {
					mask = -1;
				} else {
					mask = 0;
					for (var j:int = firstBit; j <= lastBit; j++) {
						mask |= 1 << j;
					}
				}
				
				// Return false if we're looking for 1s and the masked bits[i] isn't all 1s (that is,
				// equals the mask, or we're looking for 0s and the masked portion is not all 0s
				if ((bits[i] & mask) != (value ? mask : 0)) {
					return false;
				}
			}
			return true;
		}
		
		public function setSize(siz:int):void {
			Size = siz;
		}
		
		private static function makeArray(size:int):Array {
			var arraySize:int = size >> 5;
			if ((size & 0x1F) != 0) {
				arraySize++;
			}
			return new Array(arraySize);
		}
		
		public function appendBit(bit:Boolean):void 
		{
			this.ensureCapacity(this.Size + 1);
			if (bit) 
			{
				this.bits[this.Size >> 5] |= (1 << (this.Size & 0x1F));
			}
			this.Size++;
		}
		
		}
		
}
