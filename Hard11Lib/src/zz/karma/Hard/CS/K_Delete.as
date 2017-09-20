package zz.karma.Hard.CS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: depends on selected
	*<p>if C.State.selected_up_down=up 删除钮是灰色
	*<p>反之，发送
	*/
	public class K_Delete extends KarmaReaderA {
		public static const type:int = 18416124;

		public function K_Delete(space:KarmaSpace) {
			super(space, type , 18912955);
		}

		override public function fromKarma(karma:Karma):void {
		}

		override public function toKarma():Karma {
			return karma;
		}


	}
}