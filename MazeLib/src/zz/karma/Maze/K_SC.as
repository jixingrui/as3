package zz.karma.Maze{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_SC extends KarmaReaderA {
		public static const type:int = 56645837;

		public function K_SC(space:KarmaSpace) {
			super(space, type , 58135105);
		}

		override public function fromKarma(karma:Karma):void {
			msg = karma.getKarma(0);
		}

		override public function toKarma():Karma {
			karma.setKarma(0, msg);
			return karma;
		}

		/**
		*<p>type = KARMA
		*<p>[SaveRet] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var msg:Karma;

		/**
		*SaveRet
		*/
		public static const T_SaveRet:int = 56645893;
	}
}