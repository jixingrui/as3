package azura.gallerid3.source
{
	import azura.common.algorithm.crypto.MC5Old;
	import azura.common.algorithm.crypto.Rot;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.i.Mc5DiskI;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import mx.events.FileEvent;
	
	public class GsAppMc5 implements Mc5DiskI
	{
		
		public function GsAppMc5(){
		}
		
		public function getData(mc5:String):ZintBuffer
		{
			var file:File=getFile(mc5);
			
			var fs:FileStream=new FileStream();
			fs.open(file,FileMode.READ);
			
			var cypher:ByteArray=new ByteArray(); 
			fs.readBytes(cypher);
			fs.close();
			
			var plain:ZintBuffer = Rot.decrypt(cypher);
			if(MC5Old.log2Valid(mc5,plain)){
				return plain;
			}else{
				trace("=============== disk cache corrupted ==============",plain.length,mc5);				
				return null;
			}
		}
		
		public function cache(mc5:String, target:ByteArray, targetIsCypher:Boolean):ZintBuffer{
			return null;
		}
		
		private function getFile(mc5:String):File{
			return File.applicationDirectory.resolvePath("assets/mc5/"+mc5);
		}
	}
}