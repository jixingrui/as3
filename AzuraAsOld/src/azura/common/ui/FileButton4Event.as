package azura.common.ui
{
	import azura.common.collections.ZintBuffer;
	
	import flash.events.Event;
	import flash.utils.ByteArray;

	public class FileButton4Event extends Event
	{
		public var _fileName:String;
		public var _data:ByteArray;

		public static const _FILEREADY:String="_FILEREADY";

		public function FileButton4Event()
		{
			super(_FILEREADY);
		}

	}
}