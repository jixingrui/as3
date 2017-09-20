package azura.common.algorithm
{
	public class Hex
	{
		
		private static var HEXES:String = "0123456789abcdef";
		
		public static function byteToHex(b:int):String {
			return "" + HEXES.charAt((b & 0xF0) >> 4) + HEXES.charAt((b & 0x0F));
		}
		
//		public static String getHex(byte[] raw) {
//			if (raw == null) {
//				return null;
//			}
//			final StringBuilder hex = new StringBuilder(2 * raw.length);
//			for (final byte b : raw) {
//				hex.append(HEXES.charAt((b & 0xF0) >> 4)).append(
//					HEXES.charAt((b & 0x0F)));
//			}
//			return hex.toString();
//		}
	}
}