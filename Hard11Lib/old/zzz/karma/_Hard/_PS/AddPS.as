package zzz.karma._Hard._PS{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: 根据State.selectedIdx是不是-1和State.selected_up_down的值，分成两种情况：没选中和下选中
	*<p>
	*<p>没选中时，生成一个Item，放在数据库队尾
	*<p>下选中时，生成一个Item，放在数据库selectedItem的后面
	*<p>
	*<p>S.State.upList最后一个Item.numChildren加1
	*<p>之后生成RefillPS触发它
	*/
	public class AddPS extends KarmaReaderA {
		public static const type:int = 18390037;
		public static const version:int = 18912929;

		public function AddPS(space:KarmaSpace) {
			super(space, type , version);
		}


	}
}