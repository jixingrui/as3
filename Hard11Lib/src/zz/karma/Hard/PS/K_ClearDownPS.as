package zz.karma.Hard.PS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: 把S.State.downList清空
	*<p>ClearDown->SC.send,发送出去
	*/
	public class K_ClearDownPS extends KarmaReaderA {
		public static const type:int = 18413736;

		public function K_ClearDownPS(space:KarmaSpace) {
			super(space, type , 18912933);
		}

		override public function fromKarma(karma:Karma):void {
		}

		override public function toKarma():Karma {
			return karma;
		}


	}
}