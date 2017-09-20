package zz.karma.Hard{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_PS extends KarmaReaderA {
		public static const type:int = 18389855;

		public function K_PS(space:KarmaSpace) {
			super(space, type , 18912903);
		}

		override public function fromKarma(karma:Karma):void {
		}

		override public function toKarma():Karma {
			return karma;
		}


	}
}