package zz.karma.Hard.CS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: depends on selected
	*<p>
	*/
	public class K_Jump extends KarmaReaderA {
		public static const type:int = 18416130;

		public function K_Jump(space:KarmaSpace) {
			super(space, type , 18912961);
		}

		override public function fromKarma(karma:Karma):void {
		}

		override public function toKarma():Karma {
			return karma;
		}


	}
}