package zzz.karma._Hard._Hub._HubCS{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class HardMsgCS extends KarmaReaderA {
		public static const type:int = 18406023;
		public static const version:int = 18912965;

		public function HardMsgCS(space:KarmaSpace) {
			super(space, type , version);
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_idxHard:int = 0;
		/**
		*<p>type = KARMA
		*<p>[CS] empty
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_msgCS:int = 1;

		/**
		*CS
		*/
		public static const T_CS:int = 18389857;
	}
}