package azura.gallerid.gal
{
	import azura.common.algorithm.crypto.MC5Old;
	import azura.common.util.ByteUtil;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	public class MemSource implements GalleridIOld
	{
		private var mc5_data:Dictionary=new Dictionary();
		
		public function get mc5List():Vector.<String>
		{
			return null;
		}
		
		public function getData(mc5:String, ret_ByteArray:Function):void
		{
			var data:ByteArray = mc5_data[mc5];
			data=ByteUtil.clone(data);
			ret_ByteArray.call(null,data);
		}
		
		public function close():void{
		}
		
		internal function put(data:ByteArray):String{
			var mc5:String=MC5Old.hash(data);
			mc5_data[mc5]=data;
			data.position=0;
			return mc5;
		}
	}
}