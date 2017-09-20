package azura.common.loaders
{
	import flash.utils.ByteArray;
	
	public class JpgLoader extends BitmapDataLoader
	{
		public function JpgLoader(data:ByteArray, callback_BitmapData:Function)
		{
			super(data, callback_BitmapData);
		}
	}
}