package zzz.karma._Hard._PS{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: 删掉S.State.selectedItem
	*<p>S.State.upList最后一个Item.numChildren减1
	*<p>之后生成RefillPS触发它
	*/
	public class DeletePS extends KarmaReaderA {
		public static const type:int = 18413740;
		public static const version:int = 18912937;

		public function DeletePS(space:KarmaSpace) {
			super(space, type , version);
		}


	}
}