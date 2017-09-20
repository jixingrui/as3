package azura.gallerid4
{
	import azura.common.algorithm.crypto.Rot;
	import azura.common.collections.ZintBuffer;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class Gal4StorageDisk implements Gal4StorageI
	{
		private var readerStore:Dictionary=new Dictionary();
		
		public function write(me5:String, cypher:ByteArray):void{
			var file:File=getFile(me5);
			if(file.exists){
				trace("Error: duplicate write",me5,this);
			}
			var fs:FileStream=new FileStream();
			fs.open(file,FileMode.WRITE);
			fs.writeBytes(cypher);
			fs.close();
		}
		
		public function readSync(me5:String):ByteArray{
			var file:File=getFile(me5);
			if(!file.exists||file.isDirectory)
				return null;
			
			var cypher:ByteArray=new ByteArray();
			var fs:FileStream=new FileStream();
			fs.open(file,FileMode.READ);
			fs.readBytes(cypher);
			fs.close();
			return cypher;
		}
		
		public function readAsync(ret:Gal4):void{
			var file:File=getFile(ret.mc5);
			var reader:AsyncReader=new AsyncReader(this,ret,file);
			readerStore[ret.mc5]=reader;
			reader.read();
		}
		
		public function readDone(reader:AsyncReader):void{
			delete readerStore[reader.gal.mc5];
			Gal4.mem.write(reader.gal.mc5,reader.plain);
			reader.gal.ready();
		}
		
		public function deleteFile(me5:String):void{
			var file:File=getFile(me5);
			file.deleteFile();
		}
		
		public function clear():void{
			File.applicationStorageDirectory.resolvePath("me5/").deleteDirectory(true);
		}
		
		private function getFile(me5:String):File{
			return File.applicationStorageDirectory.resolvePath("me5/"+me5);
		}
	}
}