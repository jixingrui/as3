package zzz.karma._Hard{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class SC extends KarmaReaderA {
		public static const type:int = 18389853;
		public static const version:int = 18912901;

		public function SC(space:KarmaSpace) {
			super(space, type , version);
		}

		/**
		*<p>type = KARMA
		*<p>[AppendDown] empty
		*<p>[ClearDown] empty
		*<p>[RefillUp] empty
		*<p>[UnselectSC] empty
		*<p>[SelectSC] empty
		*<p>[UpdateOne] empty
		*<p>[ClearHold] empty
		*<p>[ClearUp] empty
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_send:int = 0;

		/**
		*AppendDown
		*/
		public static const T_AppendDown:int = 18390013;
		/**
		*ClearDown
		*/
		public static const T_ClearDown:int = 18410301;
		/**
		*ClearHold
		*/
		public static const T_ClearHold:int = 18410861;
		/**
		*RefillUp
		*/
		public static const T_RefillUp:int = 18410303;
		/**
		*UnselectSC
		*/
		public static const T_UnselectSC:int = 18410305;
		/**
		*SelectSC
		*/
		public static const T_SelectSC:int = 18410307;
		/**
		*UpdateOne
		*/
		public static const T_UpdateOne:int = 18410309;
		/**
		*ClearUp
		*/
		public static const T_ClearUp:int = 18410311;
	}
}