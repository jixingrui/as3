package azura.gallerid3
{
	import azura.common.ui.alert.AlertShow;
	
	import azura.common.collections.ZintBuffer;
	import azura.common.util.OS;
	import azura.gallerid3.i.Mc5ConfigI;
	import azura.gallerid3.i.Mc5DiskI;
	import azura.gallerid3.i.Mc5MemI;
	import azura.gallerid3.source.GsAppMc5;
	import azura.gallerid3.source.GsCacheFile;
	import azura.gallerid3.source.GsCacheSo;
	import azura.gallerid3.source.GsFile;
	import azura.gallerid3.source.GsMem;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class Gallerid
	{
		private static var instance:Gallerid = new Gallerid();	
		public static function singleton():Gallerid {			
			return instance;			
		}		
		public var mc5Config:Mc5ConfigI;
		
		private var diskCache:Mc5DiskI;
		
		//		private var appMc5:Mc5DiskI;
		
		public var mem:Mc5MemI;
		
		public function Gallerid() {			
			if( instance ) throw new Error( "Gallerid and can only be accessed through Gallerid.getInstance()" );
			
			mem=new GsMem();
			
			if(OS.isBrowser){
				diskCache=new GsCacheSo();
			}else{
				diskCache=new GsCacheFile();
				
				//				appMc5=new GsAppMc5();
			}
		}		
		
		/**
		 * @return plain data
		 */
		public function cache(mc5:String,target:ByteArray,targetIsCypher:Boolean):ZintBuffer{
			return diskCache.cache(mc5,target,targetIsCypher);
		}
		
		public function cacheMem(mc5:String,data:ByteArray):void{
			mem.cache(mc5,new ZintBuffer(data));
		}
		
		/**
		 * 
		 * @param file
		 * @return master
		 * 
		 */
		public function cacheMemFromPack(file:File):String{
			var fileStream:FileStream=new FileStream();
			fileStream.open(file,FileMode.READ);
			var size:int =fileStream.readInt();
			var nextStart:int=fileStream.position;
			
			var master:String;
			var length:int;
			var mc5:String;
			var mc5_pos:Dictionary=new Dictionary();
			for(var i:int=0;i<size;i++){
				fileStream.position=nextStart;
				
				mc5=fileStream.readUTF();
				
				if(i==0)
					master=mc5;
				
				if(mc5.length==42){
					mc5_pos[mc5]=fileStream.position;
				}else{
					trace("file contains empty mc5:"+i);
				}
				
				length=fileStream.readInt();
				nextStart=fileStream.position+length;
			}
			for(mc5 in mc5_pos){
				var pos:int=mc5_pos[mc5];
				fileStream.position=pos;
				length=fileStream.readInt();
				var data:ZintBuffer=new ZintBuffer();
				fileStream.readBytes(data,0,length);
				cacheMem(mc5,data);
			}
			
			fileStream.close();
			
			return master;
		}
		
		public function touch(mc5:String):void{
			if(mc5!=null&&mc5.length==42)
				getData(mc5);
		}
		
		public function getData(mc5:String):GalMail{
			
			var item:GalMail = new GalMail(mc5);
			
			item.data=mem.getData(mc5);
			if(item._data!=null){
				item.dispatchLater();
				return item;
			}
			
			//			throw new Error("shouldn't be here",this);
			
			//app
			//			if(!OS.isBrowser){
			//				
			//				item.data=appMc5.getData(mc5);
			//				
			//				item.data=GsPack.getSync(mc5);
			//				if(item._data!=null){
			//					item.dispatchLater();
			//					return item;
			//				}
			//			}
			
			//disk
			//			item.data=diskCache.getData(mc5);
			//			if(item._data!=null){
			//				item.dispatchLater();
			//				return item;
			//			}
			
			//http
			var url:String=mc5Config.mc5ToUrl(mc5);
			item.loadHttp(url);
			return item;
		}
		
	}
}