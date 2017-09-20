package assets
{
	import azura.common.algorithm.crypto.Stega;
	import azura.common.loaders.BitmapLoader;
	import azura.common.loaders.PngLoader;
	import azura.fractale.FrackConfigI;
	import azura.fractale.algorithm.HintBook;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.core.BitmapAsset;
	
	import org.osflash.signals.Signal;
	
	public class Config_Maze4 implements FrackConfigI
	{
		[Embed(source = "assets/homura.png")]
		private static var icon:Class;
		
		private var xml:XML;
		
		public var onReady:Signal=new Signal();
		
		public function Config_Maze4(url:String="assets/config_maze4.xml")
		{
			var loader: URLLoader = new URLLoader(new URLRequest(url));
			loader.addEventListener(Event.COMPLETE, configFileReady);
			
			function configFileReady(event: Event): void
			{
				var loader: URLLoader=event.target as URLLoader; 
				xml = XML(loader.data);
				onReady.dispatch();
			}	
		}	
		
		public function get iconUrl():String{
			return xml.icon;
		}
		
		public function get host():String
		{
			return xml.maze4.host;
		}
		
		public function get port():int
		{
			return xml.maze4.port;
		}
		
		public function get frackey():ByteArray
		{
			var book:BitmapData=BitmapAsset(new icon()).bitmapData;
			var data:ByteArray=Stega.decode(book,HintBook.dataLength);
			return data;
		}
		
	}
}