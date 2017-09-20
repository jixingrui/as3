package azura.common.loaders
{
	import flash.utils.ByteArray;
	
	public class PngLoader extends BitmapDataLoader
	{
		public function PngLoader(data:ByteArray, callback_BitmapData:Function)
		{
			super(data, callback_BitmapData);
		}
	}
}