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
	
	public class Config_Maze2Editor implements FrackConfigI,Mc5ConfigI,VoiceConfigI
	{
		[Embed(source = "assets/homura.png")]
		private static var homura:Class;
		
		private var xml:XML;
		
		private var _onReady:Signal=new Signal();
		
		public function Config_Maze2Editor(url:String="assets/config.xml")
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
			return xml.maze2.host;
		}
		
		public function get port():int
		{
			return xml.maze2.port;
		}
		
		public function get frackey():ByteArray
		{
			return getBook();
		}
		
		public function get mc5t():String
		{
			return xml.mc5.t;
		}
		
		public function get mc5s():String
		{
			return xml.mc5.s;
		}
		
		public function get mc5m():String
		{
			return xml.mc5.m;
		}
		
		public function get mc5l():String
		{
			return xml.mc5.l;
		}
		
		public function get mc5x():String
		{
			return xml.mc5.x;
		}
		
		public function get voice():String{
			return xml.voice;
		}
		
		public function mc5ToUrl(mc5:String):String{
			var url:String;
			var size:String=MC5Old.getSize(mc5);
			switch(size)
			{
				case "t":
				{
					url=mc5t+"/"+mc5;
					break;
				}
				case "s":
				{
					url=mc5s+"/"+mc5;
					break;
				}
				case "m":
				{
					url=mc5m+"/"+mc5;
					break;
				}
				case "l":
				{
					url=mc5l+"/"+mc5;
					break;
				}
				case "x":
				{
					url=mc5x+"/"+mc5;
					break;
				}
			}
			return url;
		}
	}
}