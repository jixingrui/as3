package azura.gallerid4
{
	import azura.common.algorithm.crypto.Rot;
	import azura.common.collections.ZintBuffer;
	import azura.common.util.OS;
	
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class Gal4Storage
	{
		private var fileStateSo:SharedObject;
		private var me5_onDisk:Dictionary=new Dictionary();
		private var storage:Gal4StorageI;
		
		public function Gal4Storage(){
			fileStateSo=SharedObject.getLocal("fileStateSo");
			
			if(OS.isBrowser)
				storage=new Gal4StorageSo;
			else
				storage=new Gal4StorageDisk;
			
			for(var me5:String in fileStateSo.data){
				var o:Object=fileStateSo.data[me5];
				if(o==true){
					me5_onDisk[me5]=true;
					//					trace("contains",me5,this);					
				}else{
					trace("Error: me5 not in file store",me5,this);
					delete fileStateSo.data[me5];
				}
			}
			
			trace("Gallerid loaded",this);
		}
		
		/**
		 * 
		 * @param source is plain or cypher
		 * @return plain
		 * 
		 */
		public function write(me5:String, source:ByteArray, plain_cypher:Boolean,flush:Boolean):ZintBuffer{
			
			if(contains(me5)){
				if(plain_cypher)
					return new ZintBuffer(source);
				else
					return Rot.decrypt(source);
			}
			
			if(fileStateSo.data[me5]==true){
				trace("Error: duplicate write",me5,this);
			}
			
			var data:ZintBuffer=null;
			var cypher:ZintBuffer=null;
			if(plain_cypher){
				data=new ZintBuffer(source);
				cypher=Rot.encrypt(source);
			}else{
				cypher=new ZintBuffer(source);
				data=Rot.decrypt(source);
			}
			
			storage.write(me5,cypher);
			
			me5_onDisk[me5]=true;
			fileStateSo.data[me5]=true;
			if(flush)
				fileStateSo.flush();
			return data;
		}
		
		public function flush():void{
			fileStateSo.flush();
		}
		
		public function contains(me5:String):Boolean{
			return me5_onDisk[me5]==true;
		}
		
		public function delete_(me5:String):Boolean{
			if(!contains(me5))
				return false;
			
			delete me5_onDisk[me5];
			fileStateSo[me5]=false;
			
			storage.deleteFile(me5);
			
			return true;
		}
		
		public function readSync(me5:String):ZintBuffer{
			var cypher:ByteArray=storage.readSync(me5);
			if(cypher==null)
				return null;
			else
				return Rot.decrypt(cypher);
		}
		
		public function readAsync(ret:Gal4):void{
			storage.readAsync(ret);
		}
		
		public function clear():void{
			storage.clear();
			fileStateSo.clear();
			me5_onDisk=new Dictionary();
		}
	}
}