package azura.karma.def
{
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;
	import azura.karma.run.bean.BeanTypeE;
	
	public class KarmaFieldV implements ZintCodecI
	{
		public var tid:int;
		public var type:int;
		public var fork:Vector.<int>;
		
		public var space:KarmaSpace;
		
		public function KarmaFieldV(space:KarmaSpace)
		{
			this.space=space;
		}
		
		public function newBean():Bean{
			return new Bean(this);
		}
		
		public function readFrom(reader:ZintBuffer):void
		{
			tid = reader.readInt();
			type = reader.readZint();
			if (type == BeanTypeE.KARMA || type == BeanTypeE.LIST) {
				var size:int = reader.readZint();
				fork = new Vector.<int>(size);
				for (var i:int = 0; i < size; i++) {
					fork[i]=reader.readInt();
				}
			}
		}
		
		public function writeTo(writer:ZintBuffer):void
		{
			throw new Error();
		}
	}
}