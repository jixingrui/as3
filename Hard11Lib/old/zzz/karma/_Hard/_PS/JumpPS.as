package zzz.karma._Hard._PS{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: 根据S.State.selected_up_down能分成两种情况：上跳，下跳
	*<p>
	*<p>上跳时：把S.State.selectedItem追加到S.State.upList的队尾
	*<p>
	*<p>下跳时：在S.State.upList里，把S.State.selectedItem和它之后的Item都移出
	*<p>
	*<p>生成RefillUp,把S.State.upList->RefillUp.itemList,发送RefillUp
	*/
	public class JumpPS extends KarmaReaderA {
		public static const type:int = 18413746;
		public static const version:int = 18912943;

		public function JumpPS(space:KarmaSpace) {
			super(space, type , version);
		}


	}
}