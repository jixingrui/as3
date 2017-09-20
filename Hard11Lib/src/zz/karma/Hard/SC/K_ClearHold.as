package zz.karma.Hard.SC{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_ClearHold extends KarmaReaderA {
		public static const type:int = 18410861;

		public function K_ClearHold(space:KarmaSpace) {
			super(space, type , 18912925);
		}

		override public function fromKarma(karma:Karma):void {
		}

		override public function toKarma():Karma {
			return karma;
		}


	}
}