package zzz.karma._Hard._CS{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: if selected : hold，且把C.state.upList里最后一个Item赋值给C.state.heldItemMom
	*<p>
	*<p>if unselected: unhold
	*/
	public class Hold extends KarmaReaderA {
		public static const type:int = 18416126;
		public static const version:int = 18912957;

		public function Hold(space:KarmaSpace) {
			super(space, type , version);
		}


	}
}