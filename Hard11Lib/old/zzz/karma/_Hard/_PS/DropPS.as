package zzz.karma._Hard._PS{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: 移动
	*<p>根据S.State.selectedItem的值分成三种情况：没选中、下选中自己、下选中不是自己
	*<p>定义heldItem在downlist里：S.State.heldItemMom与S.State.upList中最后一个Item相同
	*<p>
	*<p>heldItem在downlist里：
	*<p>{如果下选中自己或没选中：结束
	*<p>如果下选中不是自己：在数据库中，把S.State.heldItem放在S.State.selectedItem的后面，之后生成RefillPS触发它，生成ClearHold->SC.send,发送它}
	*<p>
	*<p>heldItem不在downlist里：
	*<p>{如果下选中（不可能选中自己）：在数据库中，把S.State.heldItem放在S.State.selectedItem的后面，
	*<p>如果没选中时：把S.State.heldItem随机插在S.State.downList里}
	*<p>
	*<p>S.State.heldItemMom.numChildren减1，
	*<p>S.State.upList最后一个Item.numChildren加1
	*<p>清空S.State.heldItemMom、heldItem
	*<p>
	*<p>之后生成RefillPS触发它，生成ClearHold->SC.send,发送它
	*<p>
	*<p>
	*/
	public class DropPS extends KarmaReaderA {
		public static const type:int = 18413742;
		public static const version:int = 18912939;

		public function DropPS(space:KarmaSpace) {
			super(space, type , version);
		}


	}
}