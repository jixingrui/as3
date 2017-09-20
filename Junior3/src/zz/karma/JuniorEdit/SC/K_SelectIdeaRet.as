package zz.karma.JuniorEdit.SC{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_SelectIdeaRet extends KarmaReaderA {
		public static const type:int = 70158554;

		public function K_SelectIdeaRet(space:KarmaSpace) {
			super(space, type , 70160615);
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