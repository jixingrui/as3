package zzz.karma._Hard._CS{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: depends on held
	*<p>
	*<p>if C.State.selected_up_down=up drop钮是灰色
	*<p>其他情况，发送
	*/
	public class Drop extends KarmaReaderA {
		public static const type:int = 18416128;
		public static const version:int = 18912959;

		public function Drop(space:KarmaSpace) {
			super(space, type , version);
		}


	}
}