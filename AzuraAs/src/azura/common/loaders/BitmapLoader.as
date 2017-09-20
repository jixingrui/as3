package azura.common.loaders
{
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	public class BitmapLoader
	{
		private static var loader_null:Dictionary=new Dictionary();
		
		public static function load(url:String, callBack_Bitmap:Function):void{
			var user:BitmapLoader=new BitmapLoader(url,callBack_Bitmap);
			loader_null[user]=null;
		}
		
		private var url:String;
		private var loader:Loader;
		private var callback:Function;
		
		function BitmapLoader(url:String,callBack_Bitmap:Function){
			this.url=url;
			this.callback=callBack_Bitmap;
			
			loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, bitmapLoaded);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIoError);
			loader.load(new URLRequest(url));
		}
		
		private function onIoError(e:IOErrorEvent):void{
			trace("file not found:"+url);
			cleanUp();
		}
		
		private function bitmapLoaded(event:Event):void
		{						
			var bm:Bitmap=LoaderInfo(event.target).loader.content as Bitmap;
			if(bm!=null){
				callback.call(null,bm);
			}else{
				trace("file is not image:"+url);				
			}
			cleanUp();
		}
		
		private function cleanUp():void{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, bitmapLoaded);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onIoError);
			loader.unloadAndStop();		
			callback=null;
			delete loader[this];
		}
	}
}