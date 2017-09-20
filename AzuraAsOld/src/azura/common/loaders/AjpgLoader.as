package azura.common.loaders
{
	import azura.common.async.Async;
	import azura.common.async.AsyncLoader;
	import azura.common.async.AsyncLoaderI;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid4.Gal4Http;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	public class AjpgLoader extends AsyncLoader implements AsyncLoaderI
	{
//		{Async.configSerial("ajpg",20000,true,1);}
		public static function load(ret:Function,md5:String):void{
			var user:AjpgLoader=new AjpgLoader(md5,ret);
			Async.enque(user);
		}
		
		private static const ModePng:int = 1;
		private static const ModeAjpg:int = 2;
		
		private var alpha:Alpha5;
		private var loader:Loader;
		private var mode:int=ModeAjpg;
		
		function AjpgLoader(md5:String,ret:Function){
			super(md5,ret);
		}
						
		override public function process():void
		{
//			Gal_Http.load(key as String,fileLoaded);	
			new Gal4Http(key as String,fileLoaded);
			function fileLoaded(data:ByteArray):void{				
				var zb:ZintBuffer=new ZintBuffer(data);
				if(zb==null){
					trace("AjpgLoader loaded null");
					//					answer.submit(null);
				}else{
					mode=zb.readZint();
					var width:int=zb.readZint();
					var height:int=zb.readZint();
					var data:ByteArray;
					
					if(mode==ModeAjpg){
						alpha=new Alpha5(zb.readBytesZ());
						data=zb.readBytesZ();
					}else{
						data=zb.readBytesZ();
					}				
					
					loader=new Loader();
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, bitmapLoaded);
					loader.loadBytes(data);
				}
			}
			
			function bitmapLoaded(event:Event):void
			{						
				var image:BitmapData=Bitmap(LoaderInfo(event.target).loader.content).bitmapData;
				loader.unloadAndStop();	
				
				if(mode==ModePng||alpha.isSolid){
				}else{
					var ajpg:BitmapData=new BitmapData(image.width,image.height,true,0x0);
					ajpg.copyPixels(image,image.rect,new Point());
					alpha.pasteTo(ajpg);
					submit(ajpg);
				}
			}
		}
		
		override public function dispose():void
		{
		}
	}
}