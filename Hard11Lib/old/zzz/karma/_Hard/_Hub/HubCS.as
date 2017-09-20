package zzz.karma._Hard._Hub{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class HubCS extends KarmaReaderA {
		public static const type:int = 18389993;
		public static const version:int = 18912909;

		public function HubCS(space:KarmaSpace) {
			super(space, type , version);
		}

		/**
		*<p>type = KARMA
		*<p>[CustomMsg] empty
		*<p>[HardMsgCS] empty
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_send:int = 0;

		/**
		*CustomMsg
		*/
		public static const T_CustomMsg:int = 18389991;
		/**
		*HardMsgCS
		*/
		public static const T_HardMsgCS:int = 18406023;
	}
}