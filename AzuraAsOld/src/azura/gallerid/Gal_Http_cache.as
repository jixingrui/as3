package azura.gallerid
{
	
	import azura.common.algorithm.crypto.Rot;
	import azura.common.async2.AsyncLoader2;
	import azura.common.collections.ZintBuffer;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	
	public class Gal_Http_cache extends AsyncLoader2
	{
		public static var folderUrl:String;
		
		private var loader:URLLoader;
		
		public function Gal_Http_cache(md5:String){
			super(md5);
		}
		
		private function get md5():String{
			return key as String;
		}
		
		override public function get value():*{
			return new ZintBuffer(super.value);
		}
		
		override public function process():void
		{
			if(md5==null||md5.length!=32){
				trace("invalid md5: \""+md5+"\" returning null");
				submit(new ZintBuffer());
				return;
			} 
			
			var url:String=folderUrl +"/"+ md5;
			
			loader=new URLLoader();
			loader.addEventListener(Event.COMPLETE,onComplete);
			loader.dataFormat=URLLoaderDataFormat.BINARY;
			
			var request:URLRequest = new URLRequest(url);
			loader.load(request);
			
			function onComplete(event:Event):void
			{				
				var ba:ByteArray=loader.data;
				
				submit(ba);
				
				loader=null;
			}
		}
		
		override public function dispose():void
		{
		}
		
	}
}