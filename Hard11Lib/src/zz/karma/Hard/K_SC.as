package zz.karma.Hard{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_SC extends KarmaReaderA {
		public static const type:int = 18389853;

		public function K_SC(space:KarmaSpace) {
			super(space, type , 18912901);
		}

		override public function fromKarma(karma:Karma):void {
			send = karma.getKarma(0);
		}

		override public function toKarma():Karma {
			karma.setKarma(0, send);
			return karma;
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
		public var send:Karma;

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