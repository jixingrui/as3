package zz.karma.Hard.CS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: if selected : hold，且把C.state.upList里最后一个Item赋值给C.state.heldItemMom
	*<p>if unselected: unhold
	*/
	public class K_Hold extends KarmaReaderA {
		public static const type:int = 18416126;

		public function K_Hold(space:KarmaSpace) {
			super(space, type , 18912957);
		}

		override public function fromKarma(karma:Karma):void {
		}

		override public function toKarma():Karma {
			return karma;
		}


	}
}