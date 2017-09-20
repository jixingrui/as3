package azura.karma.reader
{
	import azura.common.collections.ZintBuffer;
	import azura.helios.hard10.ie.HardReaderI;
	import azura.karma.editor.def.KarmaField;
	import azura.karma.editor.KarmaPanel;
	
	public class FieldReader implements HardReaderI
	{
		private var user:KarmaPanel;
		
		public var core:KarmaField=new KarmaField();
		
		public function FieldReader(user:KarmaPanel)
		{
			this.user=user;
		}
		
		public function init():void
		{
			core.init();
			
			user.typeBox.type=core.type;
			user.taFieldNote.text=core.note;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			core.readFrom(zb);
			
			user.typeBox.type=core.type;
			user.taFieldNote.text=core.note;
		}
		
		public function toBytes():ZintBuffer
		{
			core.type=user.typeBox.type;
			core.note=user.taFieldNote.text;
			
			var zb:ZintBuffer=new ZintBuffer();
			core.writeTo(zb);
			return zb;
		}
	}
}