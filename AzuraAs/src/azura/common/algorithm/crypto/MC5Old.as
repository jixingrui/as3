package azura.common.algorithm.crypto
{
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.Hex;
	
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	public class MC5Old
	{
		public var log2:int;
		public var md5:String;
		public var crc32:String;
		
		public function toString():String{
			return Hex.byteToHex(log2)+md5+crc32;
		}
		
		public function fromString(mc5:String):void{
			var log2s:String=mc5.substring(0,2);
			md5=mc5.substring(2,34);
			crc32=mc5.substring(34,42);
			
			log2=parseInt(log2s,16);
		}
		
		public function fromBytes(data:ByteArray):void{
			log2=FastMath.log2(data.length);
			md5=MD5.b2s(data);
			crc32=MC5Old.getCrc32(data);
		}
		
		/**
		 * t [0-13) [0,8k)<br/>
		 * s [13-17) [8k,128k)<br/>
		 * m [17-23) [128k,8m)<br/>
		 * l [23-28) [8m,200m)<br/>
		 * x [28-?) [200m-?)
		 */
		public static function getSize(mc5:String):String{
			var shell:MC5Old=new MC5Old();
			shell.fromString(mc5);
			if(shell.log2<13)
				return "t";
			else if(shell.log2<17)
				return "s";
			else if(shell.log2<23)
				return "m";
			else if(shell.log2<28)
				return "l";
			else
				return "x";
		}
		
		public static function hash(data:ByteArray):String{
			var mc5:MC5Old=new MC5Old();
			mc5.fromBytes(data);
			return mc5.toString();
		}
		
		public static function log2Valid(mc5:String,data:ByteArray):Boolean{
			var shell:MC5Old=new MC5Old();
			shell.fromString(mc5);
			var log2:int=FastMath.log2(data.length);
			return shell.log2==log2;
		}
		
		public static function crc32Valid(mc5:String,data:ByteArray):Boolean{
			var shell:MC5Old=new MC5Old();
			shell.fromString(mc5);
			var crc32:String=MC5Old.getCrc32(data);
			return shell.crc32==crc32;
		}
		
		public static function getCrc32(data:ByteArray):String{
			//			var start:int=getTimer();
			var crc32:String=CRC32.compute(data).toString(16);
			while (crc32.length < 8) crc32 = 0 + crc32;
			//			trace("crc32",getTimer()-start);
			return crc32;
		}
	}
}