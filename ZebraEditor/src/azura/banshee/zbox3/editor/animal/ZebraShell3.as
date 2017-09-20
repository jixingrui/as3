package azura.banshee.zbox3.editor.animal
{
	import azura.banshee.zebra.Zebra3;
	import azura.common.collections.BytesI;
	import azura.common.collections.NameI;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.source.GsFile;
	
	public class ZebraShell3 implements NameI
	{
		private var _name:String='';
		public var zebra:Zebra3;
//		public var source:GsFile;
		
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