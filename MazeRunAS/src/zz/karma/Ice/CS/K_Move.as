package zz.karma.Ice.CS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_Move extends KarmaReaderA {
		public static const type:int = 93485888;

		public function K_Move(space:KarmaSpace) {
			super(space, type , 97785731);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			path = karma.getBytes(0);
		}

		override public function toKarma():Karma {
			karma.setBytes(0, path);
			return karma;
		}

		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>empty
		*/
		public var path:ZintBuffer;

	}
}