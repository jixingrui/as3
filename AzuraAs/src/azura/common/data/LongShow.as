package azura.common.data
{
	import com.hurlant.util.Hex;
	
	import flash.utils.ByteArray;
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;

	public class LongShow implements ZintCodecI
	{
//		public var high:int;
//		public var low:int;
		
		private var hex:String;
		
		public function LongShow()
		{
		}
		
		public function readFrom(reader:ZintBuffer):void
		{
			var byte64:ByteArray=new ByteArray();
			reader.readBytes(byte64,0,8);
			hex=Hex.fromArray(byte64);
//			high=reader.readInt();
//			low=reader.readInt();
		}
		
		public function writeTo(writer:ZintBuffer):void
		{
			var byte64:ByteArray=Hex.toArray(hex);
			if(byte64.length!=8)
				throw new Error();
			
			writer.writeBytes(byte64);
//			writer.writeInt(high);
//			writer.writeInt(low);
		}
		
		public function toString():String{
			return hex;
		}
		
//		public function toNumber():Number{
//			return (high<<32)|low;
//		}
		
//		override public function 
	}
}