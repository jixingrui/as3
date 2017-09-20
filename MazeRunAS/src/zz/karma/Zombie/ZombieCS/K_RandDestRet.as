package zz.karma.Zombie.ZombieCS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_RandDestRet extends KarmaReaderA {
		public static const type:int = 110963347;

		public function K_RandDestRet(space:KarmaSpace) {
			super(space, type , 110963649);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			session = karma.getInt(0);
			xTo = karma.getInt(1);
			yTo = karma.getInt(2);
		}

		override public function toKarma():Karma {
			karma.setInt(0, session);
			karma.setInt(1, xTo);
			karma.setInt(2, yTo);
			return karma;
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var session:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var xTo:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var yTo:int;

	}
}