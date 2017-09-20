package azura.gallerid
{
	
	import azura.common.algorithm.crypto.Rot;
	import azura.common.async2.Async2;
	import azura.common.async2.AsyncLoader2;
	import azura.common.collections.ZintBuffer;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	public class Gal_Http2Old extends AsyncLoader2
	{
		{
			Async2.newSequence(6)
				.order(Gal_Http2Old);
		}
		public static var folderUrl:String;
		private var loader:URLLoader;
		
		public function Gal_Http2Old(md5:String){
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
			
			var ba:ByteArray=Gal_FileOld.getData(md5);
			
			if(ba!=null){
				//				setTimeout(submit,1000,ba);
				submit(ba);
			}else{
				var url:String=folderUrl + "/" + md5;
				//				trace("Gal_Http2: "+url);
				
				loader=new URLLoader();
				loader.dataFormat=URLLoaderDataFormat.BINARY;
				loader.addEventListener(ProgressEvent.PROGRESS, loaderHandler);    
				loader.addEventListener(Event.COMPLETE, loaderHandler);    
				loader.addEventListener(IOErrorEvent.IO_ERROR, loaderHandler);  
				
				var request:URLRequest = new URLRequest(url);
				loader.load(request);
				
				function loaderHandler(event:*):void   
				{   
					switch(event.type) {   
						case ProgressEvent.PROGRESS:   
							//							trace("progress: " + event);   
							break;   
						case Event.COMPLETE:   {
							var ba:ByteArray=loader.data;
							Gal_FileOld.putDirect(md5, ba);					
							ba=Rot.decrypt(ba);
							
							submit(ba);
						}
							break;   
						case IOErrorEvent.IO_ERROR:{
							//							Toast.show("无法连接服务器");
						}
							break;   
					}   
				}  
			}
		}
		
		//		override public function cancel():void{
		//			if(loader!=null){
		//				loader.close();
		//				//				cancel();
		//				//cannot sumbit?
		//			}
		//			super.cancel();
		//		}
		
		override public function dispose():void
		{
		}
		
	}
}