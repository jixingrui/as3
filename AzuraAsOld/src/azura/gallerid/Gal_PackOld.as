package azura.gallerid
{
	import azura.common.algorithm.crypto.MC5Old;
	import azura.common.algorithm.crypto.MD5;
	import azura.common.collections.DictionaryUtil;
	import azura.common.collections.ZintBuffer;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class Gal_PackOld
	{
		public var master:String;
		private var slave_slave:Dictionary=new Dictionary();
		
		public static function load(data:ByteArray,disk:Boolean=false):Gal_PackOld{
			var gp:Gal_PackOld=new Gal_PackOld();
			gp.decode(data,disk);
			return gp;
		}
		
		public function setMaster(data:ZintBuffer):void{
			master=MC5Old.hash(data);
			Gal_Memory.putData(master,data);
		}
		
		public function addSlave(slave:String):void{
			slave_slave[slave]=slave;
		}
		
		public function eat(pray:Gal_PackOld):void{
			for each(var slave:String in pray.slave_slave){
				addSlave(slave);
			}
		}
		
//		public function get slaveList():Vector.<String>{
//			var result:Vector.<String>=new Vector.<String>();
//			for each(var slave:String in slave_slave){
//				result.push(slave);
//			}
//			return result;
//		}
		
		public function encode():ByteArray{
			var size:int=DictionaryUtil.getLength(slave_slave);
			var ba:ByteArray=new ByteArray();
			ba.writeInt(size+1);
			ba.writeUTF(master);
			var data:ByteArray=Gal_FileOld.getData(master);
			ba.writeInt(data.length);
			ba.writeBytes(data);
			for each(var slave:String in slave_slave){
				ba.writeUTF(slave);
				data=Gal_FileOld.getData(slave);
				ba.writeInt(data.length);
				ba.writeBytes(data);
			}
			return ba;
		}
		
		/**
		 * 
		 * @param disk: write to disk cache
		 * 
		 */
		public function decode(ba:ByteArray,disk:Boolean=false):void{
			var size:int=ba.readInt()-1;
			master=ba.readUTF();
			var length:int=ba.readInt();
			var data:ZintBuffer=new ZintBuffer();
			ba.readBytes(data,0,length);
			
			put(master,data);

			for(var i:int=0;i<size;i++){
				var slave:String=ba.readUTF();
				addSlave(slave);
				length=ba.readInt();
				data=new ZintBuffer();
				ba.readBytes(data,0,length);
				
				put(slave,data);
			}
			
			function put(mc5:String,data:ZintBuffer):void{
				if(disk&&!Gal_FileOld.hasData(mc5))
					Gal_FileOld.put(data);
				else
					Gal_Memory.putData(mc5,data);
			}
		}
		
	}
}