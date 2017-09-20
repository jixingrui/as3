package azura.common.loaders
{
	import azura.common.alert.AlertShow;
	import azura.gallerid3.i.CancelableI;
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.BinaryDataLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.data.DataLoaderVars;
	import com.greensock.loading.data.LoaderMaxVars;
	
	import flash.utils.ByteArray;
	
	public class GreenSockLoader implements CancelableI
	{
		private static var queue:LoaderMax;
		
		{
			queue=new LoaderMax(new LoaderMaxVars().autoLoad(true).maxConnections(8));
		}
		
		public static function load(url:String,ret_ByteArray:Function):CancelableI{
			return new GreenSockLoader(url,ret_ByteArray);
		}
		
		private static var counter:int;
		
		private var ret_ByteArray:Function;
		private var loader:BinaryDataLoader;
		private var url:String;
		private var strong:GreenSockLoader;
		
		function GreenSockLoader(url:String,ret_ByteArray:Function)
		{
			this.url=url;
			this.ret_ByteArray=ret_ByteArray;
			strong=this;
			loader=new BinaryDataLoader(url,new DataLoaderVars().onComplete(completeHandler).onError(errorHandler));
			queue.append(loader);
			trace(++counter);
			//			trace("start",url);
		}
		
		private function completeHandler(event:LoaderEvent):void {
			//			trace("complete",url);
			var data:ByteArray=event.target.content as ByteArray;
			loader.dispose(true);
			loader=null;
			strong=null;
			ret_ByteArray.call(null,data);
			trace(--counter);
		}
		
		private function errorHandler(event:LoaderEvent):void {
			AlertShow.show(url,"阿里云下载失败");
		}
		
		public function cancel():void
		{
			trace("http canceled",url,this);
			if(loader!=null){
				loader.cancel();
				strong=null;				
			}
		}
	}
}
