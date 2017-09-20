package zzz.karma._Hard._PS{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: 检查是否有重名：检查S.State.selectedItem与之并列的其他Item.name与Rename.name是否相同，相同视为重名
	*<p>
	*<p>如果不重名，生成UpdateOne，
	*<p>S.State.selectedItem->UpdateOne.item，
	*<p>S.State.selectedIdx->UpdateOne.idx
	*<p>S.State.selected_up_down->UpdateOne.up_down
	*<p>再把UpdateOne->SC.send，发送出去
	*<p>
	*<p>如果重名，结束
	*/
	public class RenamePS extends KarmaReaderA {
		public static const type:int = 18413738;
		public static const version:int = 18912935;

		public function RenamePS(space:KarmaSpace) {
			super(space, type , version);
		}


	}
}