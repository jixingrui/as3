package azura.avalon.zbase.bus
{
	public class Pack16
	{

		public static function pack(left:int, right:int):int {
			return (left << 16) | (right & 0xffff);
		}
		
		public static function extractLeft(lr:int):int {
			return lr >> 16;
		}
		
		public static function extractRight(lr:int):int {
			return ((lr & 0xffff)<<16)>>16;
		}
	}
}