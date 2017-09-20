package azura.karma.run
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.karma.def.KarmaNow;
	import azura.karma.def.KarmaSpace;

	public class KarmaReaderA implements KarmaI,BytesI
	{
		protected  var space:KarmaSpace;
		protected var karma:Karma;
		
		public function KarmaReaderA(space:KarmaSpace, type:int, codeVersion:int) {
			this.space = space;
			this.karma=new Karma(space);
			karma.fromType(type);
			var kn:KarmaNow=space.getDef(type);
			if(kn.history.getHead().version!=codeVersion)
				throw new Error("Karma version not match");
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			karma.fromBytes(zb);
			fromKarma(karma);
		}
		
		public function toBytes():ZintBuffer
		{
			return toKarma().toBytes();
		}
		
		public function fromKarma(karma:Karma):void{
			throw new Error("override");
		}
		
		public function toKarma():Karma{
			throw new Error("override");
		}
	}
}