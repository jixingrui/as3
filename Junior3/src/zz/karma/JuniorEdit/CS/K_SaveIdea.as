package zz.karma.JuniorEdit.CS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_SaveIdea extends KarmaReaderA {
		public static const type:int = 70159980;

		public function K_SaveIdea(space:KarmaSpace) {
			super(space, type , 70160616);
		}

		override public function fromKarma(karma:Karma):void {
			idea = karma.getKarma(0);
		}

		override public function toKarma():Karma {
			karma.setKarma(0, idea);
			return karma;
		}

		/**
		*<p>type = KARMA
		*<p>[Idea] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var idea:Karma;

		/**
		*Idea
		*/
		public static const T_Idea:int = 69803052;
	}
}