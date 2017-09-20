package azura.gallerid4
{
	import azura.common.algorithm.crypto.Rot;
	import azura.common.collections.ZintBuffer;
	
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	
	public class Gal4StorageSo implements Gal4StorageI
	{
		public function Gal4StorageSo()
		{
			SharedObject.getLocal("diskspace").flush(100000000);
		}
		
		public function write(me5:String, cypher:ByteArray):void{
			var so:SharedObject=SharedObject.getLocal(me5);
			if(so.data.cypher!=null){
				trace("Error: duplicate write",me5,this);
			}
			so.data.cypher=cypher;
			so.flush();
		}
		
		public function readSync(me5:String):ByteArray
		{
			var so:SharedObject=SharedObject.getLocal(me5);
			var cypher:ByteArray= so.data.cypher;
			so.close();
			return cypher;
		}
		
		public function readAsync(gal:Gal4):void
		{
			var cypher:ByteArray=readSync(gal.mc5);
			gal.data=Rot.decrypt(cypher);
			Gal4.mem.write(gal.mc5,gal.data);
			setTimeout(gal.ready,0);
		}
		
		public function deleteFile(me5:String):void
		{
			var so:SharedObject=SharedObject.getLocal(me5);
			so.clear();
		}
		
		public function clear():void
		{
			trace("todo: delete all",this);
		}
	}
}