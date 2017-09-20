package azura.common.algorithm.crypto
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	public class Stega
	{
		public static function decode(book:BitmapData, length:int):ByteArray{
			
			var extracted:ByteArray=new ByteArray();
			
			for (var i:int = 0; i < book.width; i++)
				for (var j:int = 0; j < book.height; j++) {
					var color:int = book.getPixel32(i, j);
					extracted[i * book.height + j] = extract233(color);
				}
			
			var result:ByteArray=new ByteArray();
			extracted.readBytes(result,0,length);
			return result;
		}
		
		private static function extract233(color:int):int{
			var b:int = 0x0;
			b |= color & 0x7;
			b |= (color & 0x700) >>> 5;
			b |= (color & 0x30000) >>> 10;
			return b;
		}
	}
}