package azura.karma.reader
{
	import azura.common.collections.ZintBuffer;
	import azura.helios.hard10.ie.HardReaderI;
	import azura.karma.editor.def.KarmaDef;
	import azura.karma.editor.KarmaPanel;
	
	public class KarmaReader implements HardReaderI
	{
		private var user:KarmaPanel;
		
		public var def:KarmaDef=new KarmaDef();
		
		public function KarmaReader(user:KarmaPanel)
		{
			this.user=user;
		}
		
		public function init():void
		{
			def.init();
			
			user.taKarmaNote.text=def.note;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			def.fromBytes(zb);
			
			user.taKarmaNote.text=def.note;
		}
		
		public function toBytes():ZintBuffer
		{
			def.note=user.taKarmaNote.text;
			
			return def.toBytes();
		}
	}
}