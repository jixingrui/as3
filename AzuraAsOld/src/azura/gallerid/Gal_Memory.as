package azura.gallerid
{
	import azura.common.algorithm.crypto.MC5Old;
	import azura.common.collections.ZintBuffer;
	
	import flash.utils.Dictionary;
	
	public class Gal_Memory
	{
		private static var mc5_data:Dictionary=new Dictionary();
		
		public static function put(data:ZintBuffer):String{
			var mc5:String=MC5Old.hash(data);
			putData(mc5,data);
			return mc5;
		}
		
		public static function putData(mc5:String,data:ZintBuffer):void{
			mc5_data[mc5]=data;
			data.position=0;
		}
		
		public static function getData(mc5:String):ZintBuffer{
			var result:ZintBuffer=null;
			var stored:ZintBuffer=mc5_data[mc5];
			if(stored!=null)
			{
				result=stored.clone();
			}
			return result;
		} 
		
	}
}

