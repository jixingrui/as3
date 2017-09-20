package azura.gallerid3.source
{
	import azura.common.algorithm.crypto.Rot;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.i.Mc5DiskI;
	
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	
	public class GsCacheSo implements Mc5DiskI
	{
		
		public function GsCacheSo()
		{
			SharedObject.getLocal("diskspace").flush(100000000);
		}
		
		public function getData(mc5:String):ZintBuffer
		{
			var so:SharedObject=SharedObject.getLocal(mc5);
			var cypher:ByteArray= so.data.byteArray;
			so.close();
			return Rot.decrypt(cypher);
		}
		
		public function cache(mc5:String, target:ByteArray, targetIsCypher:Boolean):ZintBuffer{
			var so:SharedObject=SharedObject.getLocal(mc5);
			
			if(targetIsCypher){
				var plain:ZintBuffer=Rot.decrypt(target);
				so.data.byteArray=target;
				so.flush();
				return plain;
			}else{
				so.data.byteArray=Rot.encrypt(target);
				so.flush();
				return new ZintBuffer(target);
			}
		}
	}
}