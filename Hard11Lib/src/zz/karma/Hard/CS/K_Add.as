package zz.karma.Hard.CS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: if 上选中，加号是灰色
	*<p>else 发送Add
	*<p>
	*/
	public class K_Add extends KarmaReaderA {
		public static const type:int = 18390071;

		public function K_Add(space:KarmaSpace) {
			super(space, type , 18912945);
		}

		override public function fromKarma(karma:Karma):void {
		}

		override public function toKarma():Karma {
			return karma;
		}


	}
}