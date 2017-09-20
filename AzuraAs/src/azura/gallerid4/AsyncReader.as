package azura.gallerid4
{
	import azura.common.algorithm.crypto.Rot;
	import azura.common.collections.ZintBuffer;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	public class AsyncReader 
	{
		protected var host:Gal4StorageDisk;
		internal var gal:Gal4;
		protected var file:File;
		
		public var plain:ZintBuffer;
		protected var fs:FileStream=new FileStream();
		
		public function AsyncReader(host:Gal4StorageDisk, gal:Gal4, file:File)
		{
			this.host=host;
			this.gal=gal;
			this.file=file;
		}
		
		public function read():void{
			fs.addEventListener(Event.COMPLETE,onComplete);
			fs.openAsync(file,FileMode.READ);
		}
		
		private function onComplete(event:Event):void{
			var cypher:ByteArray=new ByteArray();
			fs.readBytes(cypher);
			fs.close();
			plain=Rot.decrypt(cypher);
			
			gal.data=plain;
			host.readDone(this);
//			gal.ready();
		}
	}
}