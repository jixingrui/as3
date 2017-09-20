package zz.karma.JuniorEdit.CS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_Load extends KarmaReaderA {
		public static const type:int = 18384283;

		public function K_Load(space:KarmaSpace) {
			super(space, type , 18913508);
		}

		override public function fromKarma(karma:Karma):void {
			db = karma.getBytes(0);
		}

		override public function toKarma():Karma {
			karma.setBytes(0, db);
			return karma;
		}

		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>empty
		*/
		public var db:ZintBuffer;

	}
}