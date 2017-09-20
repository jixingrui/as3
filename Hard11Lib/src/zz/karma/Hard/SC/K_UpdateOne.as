package zz.karma.Hard.SC{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_UpdateOne extends KarmaReaderA {
		public static const type:int = 18410309;

		public function K_UpdateOne(space:KarmaSpace) {
			super(space, type , 18912923);
		}

		override public function fromKarma(karma:Karma):void {
			up_down = karma.getBoolean(0);
			idx = karma.getInt(1);
			item = karma.getKarma(2);
		}

		override public function toKarma():Karma {
			karma.setBoolean(0, up_down);
			karma.setInt(1, idx);
			karma.setKarma(2, item);
			return karma;
		}

		/**
		*<p>type = BOOLEAN
		*<p> --note-- 
		*<p>empty
		*/
		public var up_down:Boolean;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var idx:int;
		/**
		*<p>type = KARMA
		*<p>[Item] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var item:Karma;

		/**
		*Item
		*/
		public static const T_Item:int = 18389685;
	}
}