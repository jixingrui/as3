package zz.karma.Hard.SC{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_AppendDown extends KarmaReaderA {
		public static const type:int = 18390013;

		public function K_AppendDown(space:KarmaSpace) {
			super(space, type , 18912913);
		}

		override public function fromKarma(karma:Karma):void {
			itemList = karma.getList(0);
			end = karma.getBoolean(1);
		}

		override public function toKarma():Karma {
			karma.setBoolean(1, end);
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
		*<p>type = BOOLEAN
		*<p> --note-- 
		*<p>empty
		*/
		public var end:Boolean;

		/**
		*Item
		*/
		public static const T_Item:int = 18389685;
	}
}