package zz.karma.Hard.PS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: 删掉S.State.selectedItem
	*<p>S.State.upList最后一个Item.numChildren减1
	*<p>之后生成RefillPS触发它
	*/
	public class K_DeletePS extends KarmaReaderA {
		public static const type:int = 18413740;

		public function K_DeletePS(space:KarmaSpace) {
			super(space, type , 18912937);
		}

		override public function fromKarma(karma:Karma):void {
		}

		override public function toKarma():Karma {
			return karma;
		}


	}
}