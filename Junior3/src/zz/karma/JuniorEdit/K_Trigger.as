package zz.karma.JuniorEdit{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_Trigger extends KarmaReaderA {
		public static const type:int = 18383349;

		public function K_Trigger(space:KarmaSpace) {
			super(space, type , 18913496);
		}

		override public function fromKarma(karma:Karma):void {
			on = karma.getInt(0);
			off = karma.getInt(1);
		}

		override public function toKarma():Karma {
			karma.setInt(0, on);
			karma.setInt(1, off);
			return karma;
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var on:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var off:int;

	}
}