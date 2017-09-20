package azura.gallerid3
{
	
	import azura.common.ui.alert.AlertShow;
	import azura.common.collections.ZintBuffer;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;
	
	public class GalleridWriter
	{
		private static var holder:Dictionary=new Dictionary();
		
		private var stream:FileStream=new FileStream();
		
		private var shrink:Vector.<String>;
		
		private var md5:String;
		
		private var onReady:Function;
		
		private var fileName:String;
		
		function GalleridWriter(ret:Function=null)
		{
			this.onReady=ret;
		}
		
		public function save(shrink:Vector.<String>):void{
			this.shrink=shrink;
			
			var file:File=File.desktopDirectory.resolvePath(fileName);
			file.browseForSave('');
			file.addEventListener(Event.SELECT,onSelected);
			function onSelected(e:Event):void{
				if(file.exists)
					AlertShow.show("请改名保存","文件已存在");
				
				stream.open(file,FileMode.WRITE);
				stream.writeInt(shrink.length);
				
				for each(var mc5:String in shrink){
					var item:GalMail=Gallerid.singleton().getData(mc5);
					stream.writeUTF(mc5);
					stream.writeInt(item._data.length);
					stream.writeBytes(item._data);
				}
				
				stream.close();
				if(onReady!=null)
					onReady.call();
				delete holder[this];
			}
		}
		
		public static function write(fileName:String, list:Vector.<String>, ret:Function=null):void{
			var dict:Dictionary=new Dictionary();
			var shrink:Vector.<String>=new Vector.<String>();
			for each(var md5:String in list){
				if(dict[md5]!=null)
					continue;
				
				shrink.push(md5);
				dict[md5]=md5;
			}
			
			var sw:GalleridWriter=new GalleridWriter(ret);
			sw.fileName=fileName;
			sw.save(shrink);
			
			holder[sw]=sw;
		}
	}
}