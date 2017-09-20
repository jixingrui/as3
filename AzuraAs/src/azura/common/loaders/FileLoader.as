package azura.common.loaders
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import mx.core.ByteArrayAsset;
	
	public class FileLoader
	{
		private var urlLoader:URLLoader;
		private var onReady_ByteArray:Function;
		private function loaded(event:Event):void{
			onReady_ByteArray.call(null,urlLoader.data);
			urlLoader=null;
			delete file_file[this];
		}
		private function load_(url:String,onReady_ByteArray:Function):void
		{
			file_file[this]=this;
			this.onReady_ByteArray=onReady_ByteArray;
			urlLoader=new URLLoader();
			urlLoader.dataFormat=URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(Event.COMPLETE,loaded);
			urlLoader.load(new URLRequest(url));
		}
		
		private static var file_file:Dictionary=new Dictionary();
		public static function load(url:String,onReady_ByteArray:Function):void
		{
			var fl:FileLoader=new FileLoader();
			fl.load_(url,onReady_ByteArray);
		}
	}
}