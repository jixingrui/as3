package azura.gallerid4
{
	import azura.common.async2.Async2;
	import azura.common.async2.AsyncLoader2;
	import azura.common.async2.AsyncLoader2I;
	import azura.common.collections.ZintBuffer;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	public class AsyncWriter extends AsyncLoader2 implements AsyncLoader2I
	{
		public var cypher:ByteArray;
		
		public var me5:String;
		protected var file:File;
		
		public var data:ZintBuffer;
		protected var fs:FileStream=new FileStream();
		
		public function AsyncWriter(me5:String,file:File){
			super(me5);
			this.me5=me5;
			this.file=file;
		}
		
		override public function process():void
		{
//			trace("write to disk",me5,this);
			fs.addEventListener(Event.CLOSE,onComplete);
			fs.openAsync(file,FileMode.WRITE);
			fs.writeBytes(cypher);
			fs.close();
		}

		private function onComplete(event:Event):void{
			submit(fs);
			release();
		}
		
		override public function dispose():void
		{
			fs=null;
		}
		
	}
}