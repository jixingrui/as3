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
	
	public class GsCacheFile implements Mc5DiskI
	{
		private var mc5_FileWriteTask:Dictionary=new Dictionary();
		
		private var writingSo:SharedObject;
		
		public function GsCacheFile(){
			writingSo=SharedObject.getLocal("AsyncWriteLog");
		}
		
		public function getData(mc5:String):ZintBuffer
		{
			var ft:FileWriteTask=mc5_FileWriteTask[mc5];
			if(ft!=null){
				//				trace("file writing on read",mc5,this);
				return ft.plain;
			}
			
			var file:File=getFile(mc5);
			if(!file.exists)
				return null;
			
			if(writingSo.hasOwnProperty(mc5)){
				trace("=============== partial data ==============",plain.length,mc5);				
				return null;
			}
			
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
			
			var ft:FileWriteTask=mc5_FileWriteTask[mc5];
			if(ft!=null){
				//				trace("file writing on write",mc5,this);
				return ft.plain;
			}
			
			writingSo.data[mc5]=true;
			writingSo.flush();
			
			ft=new FileWriteTask();
			mc5_FileWriteTask[mc5]=ft;
			ft.host=this;
			ft.mc5=mc5;
			if(targetIsCypher){
				ft.cypher=target;
				ft.plain=Rot.decrypt(target);
			}else{
				ft.plain=new ZintBuffer(target);
				ft.cypher=Rot.encrypt(target);
			}
			ft.file=getFile(mc5);
			ft.write();
			return ft.plain;
		}
		
		public function remove(mc5:String):void{
			delete mc5_FileWriteTask[mc5];
			delete writingSo.data[mc5];
			writingSo.flush();
		}
		
		private function getFile(mc5:String):File{
			return File.applicationStorageDirectory.resolvePath("mc5/"+mc5);
		}
	}
}