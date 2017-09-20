package zz.karma.JuniorEdit.SC{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_SaveRet extends KarmaReaderA {
		public static const type:int = 18383814;

		public function K_SaveRet(space:KarmaSpace) {
			super(space, type , 18913498);
		}

		override public function fromKarma(karma:Karma):void {
			version = karma.getInt(0);
			db = karma.getBytes(1);
		}

		override public function toKarma():Karma {
			karma.setInt(0, version);
			karma.setBytes(1, db);
			return karma;
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var version:int;
		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>empty
		*/
		public var db:ZintBuffer;

	}
}