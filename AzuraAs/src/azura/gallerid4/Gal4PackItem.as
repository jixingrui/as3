package azura.gallerid4
{
	import azura.common.collections.ZintBuffer;
	
	import flash.utils.ByteArray;

	public class Gal4PackItem
	{
		public var mc5:String;
		public var isOnDisk:Boolean;
		public var length:int;
		public var cypher:ByteArray=new ByteArray();
		
		public function Gal4PackItem()
		{
		}
		
		public function write():void{
			if(isOnDisk==false)
				Gal4.write(mc5,cypher,false,false);
		}
	}
}