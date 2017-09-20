package azura.common.loaders
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class CommonImageLoader
	{
		private static var loader_null:Dictionary=new Dictionary();
		
		public static function load(callback_BitmapData:Function,data:ByteArray):void{
			var user:CommonImageLoader=new CommonImageLoader(data,callback_BitmapData);
			loader_null[user]=null;
		}
		
		private var callback:Function;
		private var loader:Loader;
		
		function CommonImageLoader(data:ByteArray,callback_BitmapData:Function){
			this.callback=callback_BitmapData;
			
			loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, bitmapLoaded);
			loader.loadBytes(data);
		}
				
		private function bitmapLoaded(event:Event):void
		{						
			var image:BitmapData=Bitmap(LoaderInfo(event.target).loader.content).bitmapData;
			loader.unloadAndStop();		
			callback.call(null,image);
			delete loader[this];
		}
	}
}