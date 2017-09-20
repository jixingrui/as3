package azura.gallerid
{
//	import com.greensock.events.LoaderEvent;
//	import com.greensock.loading.DataLoader;
	
	import common.algorithm.crypto.Rot;
	import common.async.Async;
	import common.async.AsyncLoader;
	import common.collections.ZintBuffer;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	
	public class Gal_HttpOld extends AsyncLoader 
	{
		public static var file:String;
		public static var cache:String;
		public static function load(md5:String,ready:Function,now:Boolean=false,useCacheUrl:Boolean=false):void{
			var user:Gal_HttpOld=new Gal_HttpOld(md5,ready,now,useCacheUrl);
			Async.enque(user);
			
			//			trace("Gal_Http: "+md5);
		}
		
		private var timeout:Timer;
//		private var loader:DataLoader;
		private var useCacheUrl:Boolean;
		
		function Gal_HttpOld(md5:String,ret:Function,now:Boolean,useCacheUrl:Boolean){
			super(md5,ret,now);
			this.useCacheUrl=useCacheUrl;
		}
		
		override public function process():void
		{
			var md5:String=key as String;
			if(md5==null||md5.length!=32){
				trace("invalid md5: \""+md5+"\" returning null");
				submit(new ZintBuffer());
				return;
			} 
			
			var ba:ByteArray=Gal_File.getData(md5);
			
			if(ba!=null){
				submit(new ZintBuffer(ba));
			}else{
				//					trace("cache miss: "+md5);
				
				timeout=new Timer(8000,1);
				timeout.addEventListener(TimerEvent.TIMER_COMPLETE,onTimeOut);
				timeout.start();
				
				var url:String;
				if(useCacheUrl)
					url=cache+md5;
				else
					url=file+ md5;
				
//				loader=new DataLoader(url,{onComplete:onComplete,onError:onError,format:"binary"});
//				loader.load();
//				
//				function onComplete(event:Event):void
//				{				
//					var ba:ByteArray=loader.content;
//					if(!useCacheUrl){
//						Gal_File.putDirect(md5, ba);					
//						ba=Rot.process(ba,false);;
//					}
//					
//					timeout.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimeOut);
//					timeout.stop();
//					timeout=null;
//					loader=null;
//					
//					submit(new ZintBuffer(ba));
//				}
//				
//				function onError(event:LoaderEvent):void {
//					Alert.show("阿里云OSS报错！"+url);
//					cancel();
////					setTimeout(loader.load,8000,true);
////					timeout.reset();
////					timeout.start();
//				}
				
				
			}
		}
		
		private function onTimeOut(event:TimerEvent):void{
			//					Alert.show("阿里云OSS无响应！"+url);
//			loader.load(true);
			timeout.reset();
			timeout.start();
		}
		
		override public function dispose():void
		{
			if(timeout!=null)
			{
				timeout.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimeOut);
				timeout.stop();
				timeout=null;
			}
		}
		
	}
}