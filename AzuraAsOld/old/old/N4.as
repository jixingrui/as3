package azura.banshee.naga.app
{
	import azura.gallerid.Gal_Memory;
	
	import common.collections.ZintBuffer;
	
	import flash.utils.ByteArray;

	public class N4
	{
		public var head:String;
		public var stand:String;
		public var walk:String;
		public var run:String;
		public var grab:String;
		
		
		
		public function decode(ba:ByteArray):void{
			var zb:ZintBuffer=new ZintBuffer(ba);
			
			head=zb.readUTF();
			stand=Gal_Memory.put(zb.readBytes_());
			walk=Gal_Memory.put(zb.readBytes_());
			run=Gal_Memory.put(zb.readBytes_());
			grab=Gal_Memory.put(zb.readBytes_());
		}
	}
}