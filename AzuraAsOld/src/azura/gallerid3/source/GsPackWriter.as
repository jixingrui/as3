package azura.gallerid3.source
{
	import azura.common.algorithm.crypto.MC5Old;
	import azura.common.collections.DictionaryUtil;
	import azura.gallerid3.Gallerid;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class GsPackWriter
	{
		private var master:String;
		private var masterData:ByteArray;
		private var mc5_mc5:Dictionary=new Dictionary();
		
		public function setMaster(data:ByteArray):void{
			master=MC5Old.hash(data);
			masterData=data;
		}
		
		public function addSlaves(mc5List:Vector.<String>):void{
			for each(var mc5:String in mc5List){
				if(mc5.length!=42)
					continue;
				
				var data:ByteArray=Gallerid.singleton().getData(mc5).dataClone();
				if(data==null)
					throw new Error();
				
				mc5_mc5[mc5]=mc5;
			}
		}
		
		public function toBytes():ByteArray{
			var size:int=DictionaryUtil.getLength(mc5_mc5)+1;			
			var ba:ByteArray=new ByteArray();
			ba.writeInt(size);
			
			ba.writeUTF(master);
			ba.writeInt(masterData.length);
			ba.writeBytes(masterData);
			
			var mc5:String;
			var data:ByteArray;
			for(mc5 in mc5_mc5){
//				data=GsFile.getSync(mc5);
				data=Gallerid.singleton().getData(mc5).dataClone();
				ba.writeUTF(mc5);
				ba.writeInt(data.length);
				ba.writeBytes(data);
			}
			return ba;
		}
	}
}