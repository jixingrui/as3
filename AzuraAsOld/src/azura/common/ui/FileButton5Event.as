package azura.common.ui
{
	import azura.common.collections.ZintBuffer;
	
	import flash.events.Event;
	import flash.utils.ByteArray;

	public class FileButton5Event extends Event
	{
		public var fileName:String;
		public var data:ByteArray;

		public static const _FILEREADY:String="_FILEREADY";

		public function FileButton5Event()
		{
			super(_FILEREADY);
		}

	}
}