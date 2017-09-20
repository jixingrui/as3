package azura.gallerid4
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	public class Gal4Http implements CancelableI
	{
		private static var taskQue:Vector.<Gal4Http>=new Vector.<Gal4Http>();
		private static var this_this:Dictionary=new Dictionary();
		private static const threads:int=4;
		private static var running:int=0;
		
		private static function checkRun():void{
			while(running<threads && taskQue.length>0){
				var current:Gal4Http=taskQue.shift();
				running++;
				current.load();
			}
		}
		
		private static var lastUrl:String;
		
		public static function load(url:String,ret_ByteArray:Function):CancelableI{
			if(url==lastUrl){
				trace("== duplicate loading ==","HttpLoader",url);
			}
			lastUrl=url;
			return new Gal4Http(url,ret_ByteArray);
		}
		
		//=================================================================
		
		private var ret_ByteArray:Function;
		private var url:String;
		
		private var loader:URLLoader;
		private var que_streaming_done:int=0;
		private var hasProgress:Boolean=true;
		private var timeout:Timer;
		
		function Gal4Http(url:String,ret_ByteArray:Function)
		{
			this.url=url;
			this.ret_ByteArray=ret_ByteArray;
			
			taskQue.push(this);
			checkRun();
		}
		
		public function read(gr:Gal4):void{
			
		}
		
		private function load():void{
			this_this[this]=this;
			que_streaming_done=1;
			loader=new URLLoader();
			loader.dataFormat=URLLoaderDataFormat.BINARY;
			loader.addEventListener(ProgressEvent.PROGRESS, loaderHandler);    
			loader.addEventListener(Event.COMPLETE, loaderHandler);    
			loader.addEventListener(IOErrorEvent.IO_ERROR, loaderHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderHandler);  
			//						loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, loaderHandler);
			
			var request:URLRequest = new URLRequest(url);
			loader.load(request);
			
			timeout=new Timer(5000,0);
			timeout.addEventListener(TimerEvent.TIMER,onTimeoutCheck);
//			timeout.start();
//			trace("requesting",url,this);
		}
		
		private function onTimeoutCheck(event:TimerEvent):void{
			if(que_streaming_done==2){
				timeout.removeEventListener(TimerEvent.TIMER,onTimeoutCheck);
				timeout.stop();
			}else if(hasProgress){
				hasProgress=false;
			}else{
				tryLater();
			}
		}
		
		private function loaderHandler(event:*):void   
		{   
			switch(event.type) {   
				case ProgressEvent.PROGRESS:   {
					hasProgress=true;
					//					trace(url+" progress: " + event);   
				}
					break;   
				case Event.COMPLETE:   {
//					trace("complete",url,this);
					running--;
					que_streaming_done=2;
					onTimeoutCheck(null);
					delete this_this[this];
					ret_ByteArray.call(null,loader.data);
					checkRun();
				}
					break;   
				case SecurityErrorEvent.SECURITY_ERROR:
				case IOErrorEvent.IO_ERROR:{
					trace("==== io error ====",url,this);
					tryLater();
				}
					break;   
			}   
		}  
		
		private function tryLater():void{
			running--;
			que_streaming_done=0;
			stopLoader();
			delete this_this[this];
			taskQue.push(this);
			checkRun();
		}
		
		private function stopLoader():void{
			loader.removeEventListener(ProgressEvent.PROGRESS, loaderHandler);    
			loader.removeEventListener(Event.COMPLETE, loaderHandler);    
			loader.removeEventListener(IOErrorEvent.IO_ERROR, loaderHandler);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderHandler);
			try
			{
				loader.close();
			} 
			catch(error:Error) 
			{
				
			}
			loader=null;
		}
		
		public function cancel():void
		{
			if(que_streaming_done==0){
				var idx:int=taskQue.indexOf(this);
				taskQue.splice(idx,1);
			}else if(que_streaming_done==1){
				trace("============= canceled =========",url,this);
				running--;
				stopLoader();
				delete this_this[this];
				checkRun();
			}
		}
	}
}