package zz.karma.Ice{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_Point extends KarmaReaderA {
		public static const type:int = 94023389;

		public function K_Point(space:KarmaSpace) {
			super(space, type , 94041398);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			x = karma.getInt(0);
			y = karma.getInt(1);
		}

		override public function toKarma():Karma {
			karma.setInt(0, x);
			karma.setInt(1, y);
			return karma;
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var x:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var y:int;

	}
}