package zz.karma.Ice.CS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_ChangeSpeed extends KarmaReaderA {
		public static const type:int = 93487160;

		public function K_ChangeSpeed(space:KarmaSpace) {
			super(space, type , 93525171);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			speed = karma.getInt(0);
		}

		override public function toKarma():Karma {
			karma.setInt(0, speed);
			return karma;
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var speed:int;

	}
}