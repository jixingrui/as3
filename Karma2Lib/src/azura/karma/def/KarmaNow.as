package azura.karma.def
{
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;
	
	public class KarmaNow implements ZintCodecI
	{
		public var editor:KarmaDefPack=new KarmaDefPack();
		public var history:KarmaHistory;
		
		public function KarmaNow(space:KarmaSpace)
		{
			history=new KarmaHistory(space);
		}
		
		public function readFrom(reader:ZintBuffer):void
		{
			editor.fromBytes(reader.readBytesZ());
			history.fromBytes(editor.core.historyData);
		}
		
		public function writeTo(writer:ZintBuffer):void
		{
			throw new Error();
		}
	}
}