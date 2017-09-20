package azura.gallerid3
{
	import azura.common.algorithm.crypto.MC5;
	import azura.common.collections.ZintBuffer;
	import azura.common.util.OS;
	import azura.gallerid3.source.GsCacheFile;
	import azura.gallerid3.source.GsCacheSo;
	import azura.gallerid3.source.GsPack;
	import azura.gallerid3.source.GsPackStore;
	
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import azura.gallerid3.i.Mc5DiskI;
	
	public class CopyofGallerid
	{
		private static var instance:CopyofGallerid = new CopyofGallerid();	
		public static function singleton():CopyofGallerid {			
			return instance;			
		}		
		
		private var local:Mc5DiskI;
		private var packStore:GsPackStore;
		
		public function CopyofGallerid() {			
			if( instance ) throw new Error( "Gallerid and can only be accessed through Gallerid.getInstance()" );
			
			if(OS.isBrowser){
				local=new GsCacheSo();
			}else{
				local=new GsCacheFile();
				packStore=new GsPackStore();
			}
		}		
		
		public function addPack(pack:GsPack):void{
			packStore.addSource(pack);
		}
		
		public function removePack(pack:GsPack):void{
			packStore.removeSource(pack);
		}
		
		public function cache(mc5:String,cypher:ByteArray):ZintBuffer{
			var t:Number=getTimer();
			return local.cache(mc5,cypher);
			trace('cache to local',getTimer()-t,this);
		}
		
		public function touch(mc5:String):void{
			
		}
		
		public function getData(mc5:String,ret_GalItem:Function=null):GalItem{
			
			var item:GalItem=new GalItem(mc5,ret_GalItem);
			
			//			var t:int=getTimer();
			item.data=local.getData(mc5);
			if(item.data!=null){
				//				trace("file read",getTimer()-t,this);
				if(ret_GalItem!=null)
					setTimeout(ret_GalItem,0,item);
				//					ret_GalItem.call(null,item);
				return item;
			}
			if(packStore!=null){
				item.data=packStore.getSync(mc5);
				if(item.data!=null){
					if(ret_GalItem!=null)
						setTimeout(ret_GalItem,0,item);
					//						ret_GalItem.call(null,item);
					return item;
				}
			}
			item.loadHttp();
			return item;
		}
		
	}
}