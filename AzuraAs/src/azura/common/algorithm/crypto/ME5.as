package azura.common.algorithm.crypto
{
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.Hex;
	
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	public class ME5
	{
		private static var Windows:int = 1;
		private static var Android:int = 2;
		private static var Ios:int = 4;
		private static var Cpu:int = 8;
		public static var totalLength:int=44;
		
		public var log2:int;
		public var md5:String;
		public var crc32:String;
		public var os:int;
		
		public function toString():String{
			return Hex.byteToHex(log2)+md5+crc32+Hex.byteToHex(os);
		}
		
		public function fromString(me5:String):void{
			var log2String:String=me5.substring(0,2);
			md5=me5.substring(2,34);
			crc32=me5.substring(34,42);
			var osString:String=me5.substr(42,44);
			
			log2=parseInt(log2String,16);
			os=parseInt(osString,16);
		}
		
		public function fromBytes(data:ByteArray):ME5{
			log2=FastMath.log2(data.length);
			md5=MD5.b2s(data);
			crc32=ME5.getCrc32(data);
			return this;
		}
		
		public static function getCrc32(data:ByteArray):String{
			var crc32:String=CRC32.compute(data).toString(16);
			while (crc32.length < 8) crc32 = 0 + crc32;
			return crc32;
		}
		
		public function isCpu():Boolean {
			return (os & Cpu) != 0;
		}
		
		public function setCpu(value:Boolean):ME5 {
			if (value) {
				os |= Cpu;
			} else {
				os &= (~Cpu);
			}
			return this;
		}
		
		public function isWindows():Boolean {
			return (os & Windows) != 0;
		}
		
		public function setWindows(value:Boolean):ME5 {
			if (value) {
				os |= Windows;
			} else {
				os &= (~Windows);
			}
			return this;
		}
		
		public function isAndroid():Boolean {
			return (os & Android) != 0;
		}
		
		public function setAndroid(value:Boolean):ME5 {
			if (value) {
				os |= Android;
			} else {
				os &= (~Android);
			}
			return this;
		}
		
		public function isIos():Boolean {
			return (os & Ios) != 0;
		}
		
		public function setIos(value:Boolean):ME5 {
			if (value) {
				os |= Ios;
			} else {
				os &= (~Ios);
			}
			return this;
		}
		
		/**
		 * t [0-13) [0,8k)<br/>
		 * s [13-17) [8k,128k)<br/>
		 * m [17-23) [128k,8m)<br/>
		 * l [23-28) [8m,200m)<br/>
		 * x [28-?) [200m-?)
		 */
		public static function getSize(me5:String):String{
			var shell:ME5=new ME5();
			shell.fromString(me5);
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
		
//		public static function hash(data:ByteArray):String{
//			var me5:ME5=new ME5();
//			me5.fromBytes(data);
//			return me5.toString();
//		}
		
//		public static function log2Valid(me5:String,data:ByteArray):Boolean{
//			var shell:ME5=new ME5();
//			shell.fromString(me5);
//			var log2:int=FastMath.log2(data.length);
//			return shell.log2==log2;
//		}
//		
//		public static function crc32Valid(me5:String,data:ByteArray):Boolean{
//			var shell:ME5=new ME5();
//			shell.fromString(me5);
//			var crc32:String=ME5.getCrc32(data);
//			return shell.crc32==crc32;
//		}
		
	}
}