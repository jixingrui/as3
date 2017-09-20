package azura.karma.reader
{
	import azura.common.collections.ZintBuffer;
	import azura.helios.hard10.ie.HardReaderI;
	import azura.karma.editor.KarmaPanel;
	import azura.karma.editor.def.KarmaTooth;
	
	public class ForkReader implements HardReaderI
	{
		private var user:KarmaPanel;
		
		public var core:KarmaTooth=new KarmaTooth();
		
		public function ForkReader(user:KarmaPanel)
		{
			this.user=user;
		}
		
		public function init():void
		{
			core.init();
			
			user.taForkNote.text=core.note;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			core.readFrom(zb);
			
			user.taForkNote.text=core.note;
		}
		
		public function toBytes():ZintBuffer
		{
			core.note=user.taForkNote.text;
			
			var zb:ZintBuffer=new ZintBuffer();
			core.writeTo(zb);
			return zb;
		}
	}
}