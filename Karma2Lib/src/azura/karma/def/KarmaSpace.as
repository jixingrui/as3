package azura.karma.def
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.karma.run.Karma;
	
	import flash.utils.Dictionary;
	
	public class KarmaSpace implements BytesI
	{
		private var type_KarmaNow:Dictionary=new Dictionary();
		
		public function KarmaSpace()
		{
		}
		
		public function getDef(type:int):KarmaNow{
			return type_KarmaNow[type];
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			zb.uncompress();
			var size:int = zb.readZint();
			for (var i:int = 0; i < size; i++) {
				var kNow:KarmaNow = new KarmaNow(this);
				kNow.readFrom(zb);
				type_KarmaNow[kNow.editor.core.id]=kNow;
			}
		}
		
		public function toBytes():ZintBuffer
		{
			throw new Error();
		}
	}
}