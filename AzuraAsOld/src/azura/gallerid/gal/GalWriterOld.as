package azura.gallerid.gal
{
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class GalWriterOld
	{
		
		private static var holder:Dictionary=new Dictionary();
		
		private var stream:FileStream=new FileStream();
		
		private var shrink:Vector.<String>;
		
		private var md5:String;
		
		private var onReady:Function;
		
		private var fileName:String;
		
		function GalWriterOld(ret:Function)
		{
			this.onReady=ret;
		}
		
		public function save(shrink:Vector.<String>):void{
			this.shrink=shrink;
			
			var file:File=File.desktopDirectory.resolvePath(fileName);
			file.browseForSave('');
			file.addEventListener(Event.SELECT,onSelected);
			function onSelected(e:Event):void{
				try
				{
					stream.open(file,FileMode.WRITE);
					stream.writeInt(shrink.length);
					saveNext();
				} 
				catch(error:Error) 
				{
//					Alert.show("请改名保存","文件使用中");
				}
			}
			
		}
		
		private function saveNext():void{
			if(shrink.length==0){
				stream.close();
				onReady.call();
				delete holder[this];
			}else{
				md5=shrink.shift();
				GalOld.getData(md5,dataReady);
			}
		}
		private function dataReady(ba:ByteArray):void{
			stream.writeUTF(md5);
			stream.writeInt(ba.length);
			stream.writeBytes(ba);
			saveNext();
		}
		
		public static function write(list:Vector.<String>, ret:Function, fileName:String):void{
			var dict:Dictionary=new Dictionary();
			var shrink:Vector.<String>=new Vector.<String>();
			for each(var md5:String in list){
				if(dict[md5]!=null)
					continue;
				
				shrink.push(md5);
				dict[md5]=md5;
			}
			
			var sw:GalWriterOld=new GalWriterOld(ret);
			sw.fileName=fileName;
			sw.save(shrink);
			
			holder[sw]=sw;
		}
	}
}