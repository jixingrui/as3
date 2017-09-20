package zz.karma.Hard.CS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_AskMore extends KarmaReaderA {
		public static const type:int = 18419577;

		public function K_AskMore(space:KarmaSpace) {
			super(space, type , 18912963);
		}

		override public function fromKarma(karma:Karma):void {
			pageSize = karma.getInt(0);
		}

		override public function toKarma():Karma {
			karma.setInt(0, pageSize);
			return karma;
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>full page size
		*/
		public var pageSize:int;

	}
}