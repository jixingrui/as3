package azura.common.localconnection
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;
	
	public class Config_SwfShell
	{
		public var onReady:Signal=new Signal();
		private var loader:URLLoader;
		private var xml:XML;
		
		public function Config_SwfShell()
		{
			loader = new URLLoader(new URLRequest("assets/config.xml"));
			loader.addEventListener(Event.COMPLETE, fileLoaded);
		}	
		
		private function fileLoaded(event: Event): void
		{
			xml = XML(loader.data);
			loader.close();
			loader=null;
			onReady.dispatch();
		}	
		
		public function get configUrl():String
		{
			return xml.config;
		}
		
	}
}