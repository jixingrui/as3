package assets
{
	import azura.common.algorithm.crypto.MC5Old;
	import azura.common.algorithm.crypto.Stega;
	import azura.common.sound.VoiceConfigI;
	import azura.fractale.FrackConfigI;
	import azura.fractale.algorithm.HintBook;
	import azura.gallerid3.i.Mc5ConfigI;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.core.BitmapAsset;
	
	import org.osflash.signals.Signal;
	
	public class Config_Maze3 implements FrackConfigI
	{
		[Embed(source = "assets/homura.png")]
		private static var homura:Class;
		
		private var xml:XML;
		
		private var _onReady:Signal=new Signal();
		
		public function Config_Maze3(url:String="assets/config.xml")
		{
			var loader: URLLoader = new URLLoader(new URLRequest(url));
			loader.addEventListener(Event.COMPLETE, handleCompleted);
			
			function handleCompleted(event: Event): void
			{
				var loader: URLLoader=event.target as URLLoader; 
				xml = XML(loader.data);
				onReady.dispatch();
			}	
		}	
		
		public function get onReady():Signal
		{
			return _onReady;
		}
		
		private static function getBook():ByteArray{
			var book:BitmapData=BitmapAsset(new homura()).bitmapData;
			var data:ByteArray=Stega.decode(book,HintBook.dataLength);
			return data;
		}
		
		public function get host():String
		{
			return xml.maze3.host;
		}
		
		public function get port():int
		{
			return xml.maze3.port;
		}
		
		public function get frackey():ByteArray
		{
			return getBook();
		}
	}
}