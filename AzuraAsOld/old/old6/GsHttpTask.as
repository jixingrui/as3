package azura.gallerid3.source
{
	import azura.common.algorithm.crypto.Rot;
	import azura.common.loaders.HttpLoader;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import azura.gallerid3.CancelableI;
	import azura.gallerid3.GalItem;
	
	public class GsHttpTask implements CancelableI
	{
		public var item:GalItem;
		private var ret_GalItem:Function;
		private var worker:CancelableI;
		
		public function GsHttpTask(item:GalItem,ret_GalItem:Function){
			this.item=item;
			item.worker=this;
			this.ret_GalItem=ret_GalItem;
		}
		
		public function load(url:String):void{
//			trace("requesting "+url);
			worker=new HttpLoader(url,ret_ByteArray_Proxy);
		}
		
		public function ret_ByteArray_Proxy(data:ByteArray):void{
			item.data=Rot.decrypt(data);
			item.worker=null;
			ret_GalItem.call(null,item);
		}
		
		public function cancel():void{
			worker.cancel();
			worker=null;
			item=null;
		}
		
	}
}