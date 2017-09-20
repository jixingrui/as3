package zz.karma.Hard.CS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_SelectCS extends KarmaReaderA {
		public static const type:int = 18416116;

		public function K_SelectCS(space:KarmaSpace) {
			super(space, type , 18912947);
		}

		override public function fromKarma(karma:Karma):void {
			up_down = karma.getBoolean(0);
			idx = karma.getInt(1);
		}

		override public function toKarma():Karma {
			karma.setBoolean(0, up_down);
			karma.setInt(1, idx);
			return karma;
		}

		/**
		*<p>type = BOOLEAN
		*<p> --note-- 
		*<p>empty
		*/
		public var up_down:Boolean;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var idx:int;

	}
}