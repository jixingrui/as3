package azura.common.algorithm.crypto
{
	
	import flash.utils.ByteArray;
	
	public class CRC32 {
		
		
		/** The fast CRC table. Computed once when the CRC32 class is loaded. */
		private static var crcTable:Array = makeCrcTable();
		
		/** Make the table for a fast CRC. */
		private static function makeCrcTable():Array {
			var crcTable:Array = new Array(256);
			for (var n:int = 0; n < 256; n++) {
				var c:uint = n;
				for (var k:int = 8; --k >= 0; ) {
					if((c & 1) != 0) c = 0xedb88320 ^ (c >>> 1);
					else c = c >>> 1;
				}
				crcTable[n] = c;
			}
			return crcTable;
		}
		
		public static function compute(data:ByteArray):uint{
			var crc32:CRC32=new CRC32();
			crc32.update(data);
			return crc32.crc;
		}
		
		private var crc:uint;
		
		private function update(buf:ByteArray):void {
			var off:uint = 0;
			var len:uint = buf.length;
			var c:uint = ~crc;
			while(--len >= 0) c = crcTable[(c ^ buf[off++]) & 0xff] ^ (c >>> 8);
			crc = ~c;
		}
		
	}
	
}