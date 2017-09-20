package azura.gallerid.gal
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	public class GalFileOld
	{
		public function GalFileOld()
		{
		}
		
		
		internal static function check(mc5:String):void{
			var file:File=File.applicationStorageDirectory.resolvePath(mc5);
			if(file.exists){
				var fss:FileStreamSource=new FileStreamSource();
				fss.open(file);
				GalOld.addSource(fss);
			}
		}
		
		internal static function copySource(source:FileStreamSource):void{
			var master:String=source.mc5List[0];
			var file:File=File.applicationStorageDirectory.resolvePath(master);
			if(file.exists)
				return;
			
			var fileStream:FileStream=new FileStream();
			fileStream.open(file,FileMode.WRITE);
			
			fileStream.writeInt(source.mc5List.length);
			for each(var mc5:String in source.mc5List){
				var ba:ByteArray=source.getDataSync(mc5);
				
				fileStream.writeUTF(mc5);
				fileStream.writeInt(ba.length);
				fileStream.writeBytes(ba);
			}
			fileStream.close();
		}
	}
}