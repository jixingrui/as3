package zz.karma.Hard.PS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: 生成ClearDownPS,触发它，生成AppendDownPS,触发它
	*/
	public class K_RefillDownPS extends KarmaReaderA {
		public static const type:int = 18413744;

		public function K_RefillDownPS(space:KarmaSpace) {
			super(space, type , 18912941);
		}

		override public function fromKarma(karma:Karma):void {
		}

		override public function toKarma():Karma {
			return karma;
		}


	}
}