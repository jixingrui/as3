package azura.banshee.zebra
{
	import azura.common.collections.BytesI;
	import azura.common.collections.NameI;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.source.GsFile;
	
	public class ZebraShell implements NameI
	{
		private var _name:String='';
		public var zebra:Zebra;
		public var source:GsFile;
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name=value;
		}
	}
}