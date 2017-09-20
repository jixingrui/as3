package zz.karma{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_Ice extends KarmaReaderA {
		public static const type:int = 93484272;

		public function K_Ice(space:KarmaSpace) {
			super(space, type , 93560463);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
		}

		override public function toKarma():Karma {
			return karma;
		}


	}
}