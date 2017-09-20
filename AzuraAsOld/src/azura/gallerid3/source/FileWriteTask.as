package azura.gallerid3.source
{
	import azura.common.collections.ZintBuffer;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	public class FileWriteTask
	{
		public var host:GsCacheFile;
		public var mc5:String;
		public var cypher:ByteArray;
		public var plain:ZintBuffer;
		public var file:File;
		private var fs:FileStream=new FileStream();
		
//		private var start:int;
		public function write():void{
//			start=getTimer();
			fs.openAsync(file,FileMode.WRITE);
			fs.addEventListener(Event.CLOSE,onClose);
			fs.writeBytes(cypher);
			fs.close();
		}
		
		private function onClose(event:Event):void{
			host.remove(mc5);
//			trace("file written",getTimer()-start,this);
		}
	}
}