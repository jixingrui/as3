package azura.common.util
{
	import flash.utils.ByteArray;
	
	public class ByteUtil
	{
		
		public static function clone(ba:ByteArray):ByteArray{
			var result:ByteArray=new ByteArray();
			result.writeBytes(ba);
			result.position=ba.position;
			return result;
		}
		
		public static function int2Byte(value:int):ByteArray{
			var bb:ByteArray=new ByteArray();
			bb[0]=value>>>24;
			bb[1]=value>>>16;
			bb[2]=value>>>8;
			bb[3]=value>>>0;
			return bb;
		}
		
		public static function byte2int(bb:ByteArray):int{
			return ((bb[0] & 0xff) << 24)|((bb[1] & 0xff) << 16)|((bb[2] & 0xff) << 8)|((bb[3] & 0xff) << 0);
		}
	}
}