package azura.gallerid
{
	import azura.common.algorithm.crypto.MC5Old;
	import azura.common.algorithm.crypto.Rot;
	import azura.common.collections.ZintBuffer;
	
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	
	public class Gal_FileOld
	{		
		{
			SharedObject.getLocal("diskspace").flush(100000000);
		}
		
		public static function touch():void{
			
		}
				
		public static function put(data:ByteArray):String{
			var mc5:String=MC5Old.hash(data);
			var cypher:ByteArray=Rot.encrypt(data);
			putDirect(mc5,cypher);
			return mc5;
		}
		
		public static function hasData(mc5:String):Boolean{
			var so:SharedObject=SharedObject.getLocal(mc5);
			return so.data.byteArray!=null;
		}
		
		internal static function putDirect(mc5:String,cypher:ByteArray):void{
			var so:SharedObject=SharedObject.getLocal(mc5);
			var ba:ByteArray=new ByteArray();
			ba.writeBytes(cypher);
			ba.position=0;
			cypher.position=0;
			so.data.byteArray=ba;
			so.flush();
		}
		
		public static function getData(mc5:String):ZintBuffer{
			var data:ZintBuffer=Gal_Memory.getData(mc5);
			if(data!=null)
				return data;
			
			var cypher:ByteArray=getDirect(mc5);
			if(cypher==null)
				return null;
			
			return Rot.decrypt(cypher);
		}
		
		private static function getDirect(mc5:String):ByteArray{
			var so:SharedObject=SharedObject.getLocal(mc5);
			var cypher:ByteArray= so.data.byteArray;
			so.close();
			return cypher;
		}
	}
}
