package zzz.karma._Hard._SC{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class AppendDown extends KarmaReaderA {
		public static const type:int = 18390013;
		public static const version:int = 18912913;

		public function AppendDown(space:KarmaSpace) {
			super(space, type , version);
		}

		/**
		*<p>type = LIST
		*<p>[Item] empty
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_itemList:int = 0;
		/**
		*<p>type = BOOLEAN
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_end:int = 1;

		/**
		*Item
		*/
		public static const T_Item:int = 18389685;
	}
}