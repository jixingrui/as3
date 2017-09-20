package zz.karma.Maze{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_CS extends KarmaReaderA {
		public static const type:int = 56645238;

		public function K_CS(space:KarmaSpace) {
			super(space, type , 68978266);
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
		*<p>[Save] empty
		*<p>[Load] empty
		*<p>[Clear] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var msg:Karma;

		/**
		*Save
		*/
		public static const T_Save:int = 56645347;
		/**
		*Load
		*/
		public static const T_Load:int = 56645353;
		/**
		*Clear
		*/
		public static const T_Clear:int = 68977234;
	}
}