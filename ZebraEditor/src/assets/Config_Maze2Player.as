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
	
	public class Config_Maze2Player
	{
		private var xml:XML;
		private var _onReady:Signal=new Signal();
		
		public function Config_Maze2Player(url:String="assets/config.xml")
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
		
		public function get maze():String{
			return xml.maze;
		}
		
		public function get pack():String{
			return xml.pack;
		}
		
		public function get entrance():String{
			return xml.entrance;
		}
	}
}