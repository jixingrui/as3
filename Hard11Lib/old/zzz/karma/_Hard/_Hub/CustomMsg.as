package zzz.karma._Hard._Hub{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class CustomMsg extends KarmaReaderA {
		public static const type:int = 18389991;
		public static const version:int = 18912907;

		public function CustomMsg(space:KarmaSpace) {
			super(space, type , version);
		}

		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_data:int = 0;

	}
}