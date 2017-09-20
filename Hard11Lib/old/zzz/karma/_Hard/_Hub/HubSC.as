package zzz.karma._Hard._Hub{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class HubSC extends KarmaReaderA {
		public static const type:int = 18401777;
		public static const version:int = 18912911;

		public function HubSC(space:KarmaSpace) {
			super(space, type , version);
		}

		/**
		*<p>type = KARMA
		*<p>[CustomMsg] empty
		*<p>[HardMsgSC] empty
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_send:int = 0;

		/**
		*HardMsgSC
		*/
		public static const T_HardMsgSC:int = 18406057;
		/**
		*CustomMsg
		*/
		public static const T_CustomMsg:int = 18389991;
	}
}