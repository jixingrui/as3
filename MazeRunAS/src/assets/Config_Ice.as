package assets
{
	import azura.common.algorithm.crypto.Stega;
	import azura.fractale.FrackConfigI;
	import azura.fractale.algorithm.HintBook;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.core.BitmapAsset;
	
	import org.osflash.signals.Signal;
	
	public class Config_Ice implements FrackConfigI
	{
		[Embed(source = "assets/homura.png")]
		private static var icon:Class;
		
		private var xml:XML;
		
		public var onReady:Signal=new Signal();
		
		public function Config_Ice(url:String="assets/config.xml")
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
		
		//================== net =============
		
		public function get host():String
		{
			return xml.ice.host;
		}
		
		public function get port():int
		{
			return xml.ice.port;
		}
		
		public function get frackey():ByteArray
		{
			var book:BitmapData=BitmapAsset(new icon()).bitmapData;
			var data:ByteArray=Stega.decode(book,HintBook.dataLength);
			return data;
		}
		
		//=================== data ==================
		public function get maze():String{
			return xml.mazeRun.maze;
		}
		
		public function get karma():String{
			return xml.mazeRun.karma;
		}
		
		public function get shooter1():String{
			return xml.mazeRun.shooter1;
		}
		
		public function get shooter2():String{
			return xml.mazeRun.shooter2;
		}
		
		public function get zombie1():String{
			return xml.mazeRun.zombie1;
		}
		
		public function get zombie2():String{
			return xml.mazeRun.zombie2;
		}
		
		public function get speedZombie():Number{
			return xml.mazeRun.speedZombie;
		}
		
		public function get speedShooter():Number{
			return xml.mazeRun.speedShooter;
		}
	}
}