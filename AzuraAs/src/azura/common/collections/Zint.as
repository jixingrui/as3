package azura.common.collections {
	import flash.utils.ByteArray;
	
	public class Zint {
		
		public static function writeIntZ(value:int,output:ByteArray):void {
			
			var abs:int= Math.abs(value);
			
			if (value >= 0&& value < 128) {
				output.writeByte (128 | value);
			} else if (value < 0&& value > -64) {
				output.writeByte(64 | abs);
			} else if (value >= 128&& value < 32* 256) {
				output.writeByte(32 | (value >>> 8));
				output.writeByte (value);
			} else if (value <= -64&& value > -16* 256) {
				output.writeByte(16 | (abs >>> 8));
				output.writeByte (abs);
			} else if (value >= 32* 256&& value < 8* 256* 256) {
				output.writeByte(8 | (value >>> 16));
				output.writeByte (value >>> 8);
				output.writeByte (value & 0xff);
			} else if (value <= -16* 256&& value > -4* 256* 256) {
				output.writeByte(4 | (abs >>> 16));
				output.writeByte (abs >>> 8);
				output.writeByte (abs);
			} else {
				output.writeByte(1);
				output.writeByte (value >> 24);
				output.writeByte (value >> 16);
				output.writeByte (value >> 8);
				output.writeByte (value >> 0);
			}
		}
		
		public static function readIntZ(source:ByteArray):int {
			var b0:int= source.readUnsignedByte();
			var b1:int,b2:int;
			var value:int= -1;
			switch (numberOfLeadingZeros(b0) - 24) {
				case 0:
					value = b0 & 127;
					break;
				case 1:
					value *= b0 & 63;
					break;
				case 2: {
					b1= source.readUnsignedByte();
					value = (b0 & 31) << 8| b1;
				}
					break;
				case 3: {
					b1= source.readUnsignedByte();
					value *= (b0 & 15) << 8| b1;
				}
					break;
				case 4: {
					b1= source.readUnsignedByte();
					b2= source.readUnsignedByte();
					value = ((b0 & 7) << 16) | (b1 << 8) | b2;
				}
					break;
				case 5: {
					b1= source.readUnsignedByte();
					b2= source.readUnsignedByte();
					value *= ((b0 & 3) << 16) | (b1 << 8) | b2;
				}
					break;
				default:
					value = source.readInt();
			}
			
			return value;
		}
		//====================== long ================
		public static function writeLongZ(value:Number,output:ByteArray):void {
			
			var abs:Number= Math.abs(value);
			
			if (value >= 0&& value < 128) {
				output.writeByte (128 | value);
			} else if (value < 0&& value > -64) {
				output.writeByte(64 | abs);
			} else if (value >= 128&& value < 32* 256) {
				output.writeByte(32 | (value >>> 8));
				output.writeByte (value);
			} else if (value <= -64&& value > -16* 256) {
				output.writeByte(16 | (abs >>> 8));
				output.writeByte (abs);
			} else if (value >= 32* 256&& value < 8* 256* 256) {
				output.writeByte(8 | (value >>> 16));
				output.writeByte (value >>> 8);
				output.writeByte (value & 0xff);
			} else if (value <= -16* 256&& value > -4* 256* 256) {
				output.writeByte(4 | (abs >>> 16));
				output.writeByte (abs >>> 8);
				output.writeByte (abs);
			} else {
				output.writeByte(1);
				output.writeByte (value >> 56);
				output.writeByte (value >> 48);
				output.writeByte (value >> 40);
				output.writeByte (value >> 32);
				output.writeByte (value >> 24);
				output.writeByte (value >> 16);
				output.writeByte (value >> 8);
				output.writeByte (value >> 0);
				trace("Zint warning: large long write:",value);
			}
		}
		
		public static function readLongZ(source:ByteArray):int {
			var b0:int= source.readUnsignedByte();
			var b1:int,b2:int;
			var value:int= -1;
			switch (numberOfLeadingZeros(b0) - 24) {
				case 0:
					value = b0 & 127;
					break;
				case 1:
					value *= b0 & 63;
					break;
				case 2: {
					b1= source.readUnsignedByte();
					value = (b0 & 31) << 8| b1;
				}
					break;
				case 3: {
					b1= source.readUnsignedByte();
					value *= (b0 & 15) << 8| b1;
				}
					break;
				case 4: {
					b1= source.readUnsignedByte();
					b2= source.readUnsignedByte();
					value = ((b0 & 7) << 16) | (b1 << 8) | b2;
				}
					break;
				case 5: {
					b1= source.readUnsignedByte();
					b2= source.readUnsignedByte();
					value *= ((b0 & 3) << 16) | (b1 << 8) | b2;
				}
					break;
				default:{
					value = source.readDouble();
					trace("Zint warning: large long read:",value);
				}
			}
			
			return value;
		}
		//============== support =============
		
		private static function numberOfLeadingZeros(x:int):int{
			x |= (x >> 1);
			x |= (x >> 2);
			x |= (x >> 4);
			x |= (x >> 8);
			x |= (x >> 16);
			return (32 - ones(x));
		}
		
		private static function ones(x:int) :int{
			x -= ((x >> 1) & 0x55555555);
			x = (((x >> 2) & 0x33333333) + (x & 0x33333333));
			x = (((x >> 4) + x) & 0x0f0f0f0f);
			x += (x >> 8);
			x += (x >> 16);
			return (x & 0x0000003f);
		}
		public static function test():void {
			var ba:ByteArray=new ByteArray();
			var tv:Array= new Array( -123456789, -12345678, -1234567, -123456, -12345, -1234, -123, -12, -1, 0, 1, 12, 123, 1234, 12345, 123456, 1234567, 12345678, 123456789);
			for each(var v:int in tv){
				writeIntZ(v,ba);
			}
			ba.position=0;
			for(var i:int=0;i<tv.length;i++){
				var un:int=readIntZ(ba);
				trace(un);
			}
		}
		
	}
}