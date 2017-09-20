package azura.common.util
{
	import azura.common.collections.ZintBuffer;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	public class FileUtil
	{
		
		public static function read(file:File):ZintBuffer{
			var fs:FileStream=new FileStream();
			fs.open(file,FileMode.READ);			
			var zb:ZintBuffer=new ZintBuffer();
			fs.readBytes(zb);
			fs.close();
			return zb;
		}
		public static function getNoExt(fileName:String):String{
			return fileName.substring(0,fileName.indexOf("."));
		}
		
		public static function getExt(fileName:String):String{
			return fileName.substring(fileName.lastIndexOf("."),fileName.length);
		}
		
		public static function string2Bytes(utf8:String):ByteArray{
			var b:ByteArray=new ByteArray();
			b.writeMultiByte(utf8,"UTF-8");
			b.position=0;
			return b;
		}
	}
}