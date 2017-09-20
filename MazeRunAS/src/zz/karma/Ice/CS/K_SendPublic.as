package zz.karma.Ice.CS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: 
	*/
	public class K_SendPublic extends KarmaReaderA {
		public static const type:int = 94026582;

		public function K_SendPublic(space:KarmaSpace) {
			super(space, type , 94041402);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			msg = karma.getBytes(0);
		}

		override public function toKarma():Karma {
			karma.setBytes(0, msg);
			return karma;
		}

		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>empty
		*/
		public var msg:ZintBuffer;

	}
}