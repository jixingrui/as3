package zz.karma.JuniorEdit.CS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_TestRun extends KarmaReaderA {
		public static const type:int = 65371461;

		public function K_TestRun(space:KarmaSpace) {
			super(space, type , 65371616);
		}

		override public function fromKarma(karma:Karma):void {
		}

		override public function toKarma():Karma {
			return karma;
		}


	}
}