package zzz.karma._Hard._Hub._HubSC{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class HardMsgSC extends KarmaReaderA {
		public static const type:int = 18406057;
		public static const version:int = 18912967;

		public function HardMsgSC(space:KarmaSpace) {
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
		*<p>[SC] empty
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_msgSC:int = 1;

		/**
		*SC
		*/
		public static const T_SC:int = 18389853;
	}
}