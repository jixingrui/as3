package zz.karma.Hard.PS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: 硬性规定每次追加一页，
	*<p>delta：从数据库中拿的一段数据，它是从S.State.downList最后一个Item后面的Item开始，拿S.State.pageSize个。（downList取决于母节点）
	*<p>把delta追加给S.State.downList，生成AppendDown，
	*<p>delta->AppendDown.itemList
	*<p>{如果delta的数量等于S.State.pageSize
	*<p>flase->AppendDown.end
	*<p>如果delta的数量小于S.State.pageSize
	*<p>true->AppendDown.end}
	*<p>AppendDown->SC.send,发送出去
	*<p>（如果尾巴恰好在pageSize的整数倍，刚好传过去的时候，是看不到end标记的，要下一次再拖拽一下，会把end标记传过去）
	*/
	public class K_AppendDownPS extends KarmaReaderA {
		public static const type:int = 18413734;

		public function K_AppendDownPS(space:KarmaSpace) {
			super(space, type , 18912931);
		}

		override public function fromKarma(karma:Karma):void {
		}

		override public function toKarma():Karma {
			return karma;
		}


	}
}