package zz.karma.Hard.CS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: depends on held
	*<p>if C.State.selected_up_down=up drop钮是灰色
	*<p>其他情况，发送
	*/
	public class K_Drop extends KarmaReaderA {
		public static const type:int = 18416128;

		public function K_Drop(space:KarmaSpace) {
			super(space, type , 18912959);
		}

		override public function fromKarma(karma:Karma):void {
		}

		override public function toKarma():Karma {
			return karma;
		}


	}
}