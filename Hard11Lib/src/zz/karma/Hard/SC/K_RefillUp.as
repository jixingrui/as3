package zz.karma.Hard.SC{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_RefillUp extends KarmaReaderA {
		public static const type:int = 18410303;

		public function K_RefillUp(space:KarmaSpace) {
			super(space, type , 18912917);
		}

		override public function fromKarma(karma:Karma):void {
			itemList = karma.getList(0);
		}

		override public function toKarma():Karma {
			return karma;
		}

		/**
		*<p>type = LIST
		*<p>[Item] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var itemList:KarmaList;

		/**
		*Item
		*/
		public static const T_Item:int = 18389685;
	}
}