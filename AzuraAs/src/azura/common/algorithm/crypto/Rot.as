package azura.common.algorithm.crypto
{
	import azura.common.collections.Zint;
	import azura.common.collections.ZintBuffer;
	
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	public class Rot
	{
		public static function encrypt(data:ByteArray):ZintBuffer{
			return process(data,true);
		}
		public static function decrypt(data:ByteArray):ZintBuffer{
			return process(data,false);
		}
		private static function process(source:ByteArray,reverse:Boolean):ZintBuffer
		{
			if(source==null)
				return null;
			
			//			var start:Number=getTimer();
			var result:ZintBuffer=new ZintBuffer();
			var i:int=0;
			var sign:int=(reverse)?-1:1;
			var length:int=Math.min(1024,source.length);
			while(i<length){
				result[i]=source[i]+i*sign;
				i++;
			}
			if(i<source.length){
				result.position=i;
				result.writeBytes(source,i);
			}
			//			trace("rot",(getTimer()-start));
			source.position=0;
			result.position=0;
			return result;
		}
	}
}