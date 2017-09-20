package azura.common.loaders
{
	import azura.common.async2.LoaderConfig;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.system.ImageDecodingPolicy;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class BitmapDataLoader
	{
		private static var loader_null:Dictionary=new Dictionary();
		
		public static function load(callback_BitmapData:Function,data:ByteArray):void{
			var user:BitmapDataLoader=new BitmapDataLoader(data,callback_BitmapData);
			loader_null[user]=null;
		}
		
		private var callback:Function;
		private var loader:Loader;
		
		function BitmapDataLoader(data:ByteArray,callback_BitmapData:Function){
			this.callback=callback_BitmapData;
			
			var lc:LoaderContext=new LoaderContext();
			lc.imageDecodingPolicy=ImageDecodingPolicy.ON_LOAD;
			loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, bitmapLoaded);
			loader.loadBytes(data,lc);
		}
				
		private function bitmapLoaded(event:Event):void
		{						
			var image:BitmapData=Bitmap(LoaderInfo(event.target).loader.content).bitmapData;
//			loader.unloadAndStop();		
			delete loader_null[this];
			callback.call(null,image);
		}
	}
}