package zz.karma{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_JuniorEdit extends KarmaReaderA {
		public static const type:int = 18383034;

		public function K_JuniorEdit(space:KarmaSpace) {
			super(space, type , 18913488);
		}

		override public function fromKarma(karma:Karma):void {
		}

		override public function toKarma():Karma {
			return karma;
		}


	}
}