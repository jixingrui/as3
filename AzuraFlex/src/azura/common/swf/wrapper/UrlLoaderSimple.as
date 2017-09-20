package azura.common.swf.wrapper
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	public class UrlLoaderSimple extends URLLoader
	{
		private static var loader_loader:Dictionary=new Dictionary();
		
		private var this_:URLLoader;
		public function UrlLoaderSimple(url:String,ret_Object:Function):void{
			super();
			this_=this;
			url+="?rand="+Math.random();
			
			addEventListener(Event.COMPLETE,onComplete);
			addEventListener(IOErrorEvent.IO_ERROR,onIoError);
			
			var ur:URLRequest=new URLRequest(url);
//			var header:URLRequestHeader = new URLRequestHeader("Cache-Control", "no-cache");
//			ur.requestHeaders.push(header);
			load(ur);
			
			function onComplete(event:Event):void{
				var result:Object=data;
				ret_Object.call(null,result);
				
				delete loader_loader[this_];
			}
			function onIoError(e:IOErrorEvent):void{
//				Alert.show("Loading failed: "+url+" "+e.text);
//				AlertPanel.show(url,"file not found");
//				Toast.show("网络连接失败");
			}
			
		}
		
		public static function load(url:String,ret_Object:Function):void{
			var uls:UrlLoaderSimple=new UrlLoaderSimple(url,ret_Object);
			loader_loader[uls]=uls;					
		}
	}
}