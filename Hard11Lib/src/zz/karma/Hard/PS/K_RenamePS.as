package zz.karma.Hard.PS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: 检查是否有重名：检查S.State.selectedItem与之并列的其他Item.name与Rename.name是否相同，相同视为重名
	*<p>如果不重名，生成UpdateOne，
	*<p>S.State.selectedItem->UpdateOne.item，
	*<p>S.State.selectedIdx->UpdateOne.idx
	*<p>S.State.selected_up_down->UpdateOne.up_down
	*<p>再把UpdateOne->SC.send，发送出去
	*<p>如果重名，结束
	*/
	public class K_RenamePS extends KarmaReaderA {
		public static const type:int = 18413738;

		public function K_RenamePS(space:KarmaSpace) {
			super(space, type , 18912935);
		}

		override public function fromKarma(karma:Karma):void {
		}

		override public function toKarma():Karma {
			return karma;
		}


	}
}