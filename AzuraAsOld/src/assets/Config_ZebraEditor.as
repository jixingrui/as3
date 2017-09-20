package assets
{
	import azura.common.algorithm.crypto.MC5Old;
	import azura.gallerid3.i.Mc5ConfigI;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;
	
	public class Config_ZebraEditor implements Mc5ConfigI
	{
		private var xml:XML;
		
		private var _onReady:Signal=new Signal();
		
		public function Config_ZebraEditor()
		{
			var loader: URLLoader = new URLLoader(new URLRequest("assets/config.xml"));
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