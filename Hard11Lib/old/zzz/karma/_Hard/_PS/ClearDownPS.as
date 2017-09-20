package zzz.karma._Hard._PS{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: 把S.State.downList清空
	*<p>ClearDown->SC.send,发送出去
	*/
	public class ClearDownPS extends KarmaReaderA {
		public static const type:int = 18413736;
		public static const version:int = 18912933;

		public function ClearDownPS(space:KarmaSpace) {
			super(space, type , version);
		}


	}
}