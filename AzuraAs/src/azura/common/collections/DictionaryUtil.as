package azura.common.collections
{
	import flash.utils.Dictionary;

	public class DictionaryUtil
	{
		public static function getLength(dict:Dictionary):int
		{
			if(dict==null)
				return 0;
			
			var n:int = 0;
			for (var key:* in dict) {
				n++;
			}
			return n;
		}
		
	}
}