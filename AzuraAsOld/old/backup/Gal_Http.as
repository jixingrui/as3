package azura.gallerid
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.DataLoader;
	
	import common.algorithm.crypto.Rot;
	import common.async.AsyncBoxI;
	import common.async.AsyncQue;
	import common.async.AsyncTask;
	import common.async.AsyncUserA;
	import common.collections.ZintBuffer;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	public class Gal_Http extends AsyncUserA
	{
		{
			AsyncQue.configParallel("http",0,0,8);
		}
				
		public static function load(md5:String,ret_ZintBuffer:Function=null,front:Boolean=false):void{
			var user:Gal_Http=new Gal_Http(md5,ret_ZintBuffer);
			AsyncQue.enque("http",user,front);
		}
		
		[Bindable]
		public static var stats:Stats=new Stats(2);
		
		public static var httpRoot:String;
		private var ret_ZintBuffer:Function;
		
		function Gal_Http(md5:String,ret_ZintBuffer:Function){
			super(md5);
			this.ret_ZintBuffer=ret_ZintBuffer;
		}
		
		override public function process(answer:AsyncTask):void
		{
			var md5:String=key as String;
			Gal_File.load(md5,fileLoaded);
			function fileLoaded(ba:ByteArray):void{
				if(ba!=null){
					//					trace("cache hit: "+md5);
					var box:ByteArrayBox=new ByteArrayBox();
					box.ba=ba;
					answer.submit(box);
				}else if(md5==null||md5.length!=32){
					trace("invalid md5: \""+md5+"\" returning null");
					answer.submit(new ByteArrayBox());
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
						stats.add(loader.content.length);
						Gal_File.putDirect(md5, loader.content);
						
						var box:ByteArrayBox=new ByteArrayBox();
						box.ba=Rot.process(loader.content,false);;
						answer.submit(box);
						
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
		
		override public function ready(value:AsyncBoxI):void
		{
			super.discard();
			
			if(ret_ZintBuffer==null)
				return;
			
			var box:ByteArrayBox=value as ByteArrayBox;
			if(box.ba!=null){
				ret_ZintBuffer.call(null,new ZintBuffer(box.ba));
			}else{
				ret_ZintBuffer.call(null,null);
			}
			
		}
		
	}
}