package azura.gallerid
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.DataLoader;
	
	import common.algorithm.crypto.Rot;
	import common.async.AsyncBoxI;
	import common.async.AsyncQue;
	import common.async.AsyncTask;
	import common.async.AsyncUserA;
	import common.async2.Async;
	import common.async2.AsyncLoader;
	import common.async2.AsyncLoaderI;
	import common.collections.ZintBuffer;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	public class Gal_Http extends AsyncLoader 
	{
		{
			Async.configParallel("http",0,true,8);
		}
				
		public static function load(md5:String,ready:Function=null,front:Boolean=false):void{
			var user:Gal_Http=new Gal_Http(md5,ready);
			Async.enque("http",user,front);
			
			trace("Gal_Http: "+md5);
		}
		
		public static var httpRoot:String;
		
		function Gal_Http(md5:String,ret:Function){
			super(md5,ret);
		}
		
		override public function process():void
		{
			var md5:String=key as String;
			Gal_File.load(md5,fileLoaded);
			function fileLoaded(ba:ByteArray):void{
				if(ba!=null){
					submit(new ZintBuffer(ba));
				}else if(md5==null||md5.length!=32){
					trace("invalid md5: \""+md5+"\" returning null");
					submit(new ZintBuffer());
				}else{
					//					trace("cache miss: "+md5);
					
					var timeout:Timer;
					timeout=new Timer(8000,1);
					timeout.addEventListener(TimerEvent.TIMER_COMPLETE,onTimeOut);
					timeout.start();
					
					var url:String=httpRoot + md5;
					var loader:DataLoader=new DataLoader(url,{onComplete:onComplete,onError:onError,format:"binary"});
					loader.load();
					
					function onComplete(event:Event):void
					{				
						Gal_File.putDirect(md5, loader.content);
						
						var ba:ByteArray=Rot.process(loader.content,false);;
						submit(new ZintBuffer(ba));
						
						timeout.stop();
						timeout.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimeOut);
						timeout=null;
						loader=null;
					}
					
					function onError(event:LoaderEvent):void {
						//						Alert.show("网络错误！");
						setTimeout(loader.load,10000,true);
						timeout.reset();
						timeout.start();
					}
					
					function onTimeOut(event:TimerEvent):void{
						//						Alert.show("网速慢！别跑太快");
						loader.load(true);
						timeout.reset();
						timeout.start();
					}
				}
			}
		}
		
		override public function dispose():void
		{
//			value=null;
			trace("Gal_Http: dispose "+key);
		}
		
//		override public function copy(from:AsyncLoaderI, to:AsyncLoaderI):void
//		{
//			Gal_Http(to).value=Gal_Http(from).value;
//		}
//		
//		override public function process(answer:AsyncTask):void
//		{
//			
//		}
		
//		override public function ready(value:AsyncBoxI):void
//		{
//			super.discard();
//			
//			if(ret_ZintBuffer==null)
//				return;
//			
//			var box:ByteArrayBox=value as ByteArrayBox;
//			if(box.ba!=null){
//				ret_ZintBuffer.call(null,new ZintBuffer(box.ba));
//			}else{
//				ret_ZintBuffer.call(null,null);
//			}
//			
//		}
		
	}
}