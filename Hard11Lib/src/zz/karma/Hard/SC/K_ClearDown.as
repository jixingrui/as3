package zz.karma.Hard.SC{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_ClearDown extends KarmaReaderA {
		public static const type:int = 18410301;

		public function K_ClearDown(space:KarmaSpace) {
			super(space, type , 18912915);
		}

		override public function fromKarma(karma:Karma):void {
		}

		override public function toKarma():Karma {
			return karma;
		}


	}
}