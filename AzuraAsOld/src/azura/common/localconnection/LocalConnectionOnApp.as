package azura.common.localconnection
{
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	public class LocalConnectionOnApp
	{
		private static var instance:LocalConnectionOnApp;
		
		public static function get singleton():LocalConnectionOnApp{
			if(instance==null)
				instance=new LocalConnectionOnApp();
			return instance;
		}
		
		private var lc:LocalConnection;
		function LocalConnectionOnApp()
		{
			lc=new LocalConnection();
			lc.addEventListener(StatusEvent.STATUS, onLCStatus);
			lc.client=this;
			lc.allowDomain("*");
			lc.connect("_app");
		}
		
		protected function onLCStatus(event:StatusEvent):void
		{
			trace("LocalConnectionOnApp:", event.code);
		}
		
		private var ret:Function;
		
		public function requestInput(ret_string:Function):void{
			ret=ret_string;			
			lc.send("_loader","request");
		}
		
		public function receive(text:String):void{
			if(ret!=null){
				ret.call(null,text);
				ret=null;
			}else{
				trace("LocalConnectionOnApp: request/receive did no match");
			}
		}
	}
}