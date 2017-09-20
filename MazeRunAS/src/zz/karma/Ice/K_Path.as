package zz.karma.Ice{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_Path extends KarmaReaderA {
		public static const type:int = 94023610;

		public function K_Path(space:KarmaSpace) {
			super(space, type , 94041399);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			path = karma.getList(0);
		}

		override public function toKarma():Karma {
			return karma;
		}

		/**
		*<p>type = LIST
		*<p>[Point] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var path:KarmaList;

		/**
		*Point
		*/
		public static const T_Point:int = 94023389;
	}
}