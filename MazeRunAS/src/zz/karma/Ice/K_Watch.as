package zz.karma.Ice{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_Watch extends KarmaReaderA {
		public static const type:int = 93513828;

		public function K_Watch(space:KarmaSpace) {
			super(space, type , 93525167);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			idTarget = karma.getInt(0);
			comparator = karma.getInt(1);
			limit = karma.getInt(2);
		}

		override public function toKarma():Karma {
			karma.setInt(0, idTarget);
			karma.setInt(1, comparator);
			karma.setInt(2, limit);
			return karma;
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var idTarget:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>0 : ==
		*<p>1 : >
		*<p>2 : <
		*<p>3 : >=
		*<p>4 : <=
		*/
		public var comparator:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var limit:int;

	}
}