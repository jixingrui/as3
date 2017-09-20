package azura.common.loaders
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;
	
	public class XmlLoader
	{
		public static function load(url:String,ret_XML:Function):void{
			var xl:XmlLoader=new XmlLoader(url,ret_XML);
		}
		
		private var loader:URLLoader;
		private var strong:XmlLoader;
		private var ret_XML:Function;
		
		public function XmlLoader(url:String,ret_XML:Function)
		{
			trace("loading ",url,this);
			this.ret_XML=ret_XML;
			loader = new URLLoader(new URLRequest(url+"?rand="+Math.random()));
			loader.addEventListener(Event.COMPLETE, fileLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			strong=this;
		}	
		
		private function fileLoaded(event: Event): void
		{
			var xml:XML=new XML(loader.data);
			ret_XML.call(null,xml);
			loader.close();
			loader=null;
			strong=null;
		}	
		
		private function errorHandler(event:Event):void{
			ret_XML.call(null,null);
		}
	}
}