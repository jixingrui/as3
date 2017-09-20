package zz.karma.Zombie.ZombieSC{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_RandDest extends KarmaReaderA {
		public static const type:int = 110962795;

		public function K_RandDest(space:KarmaSpace) {
			super(space, type , 110963651);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			session = karma.getInt(0);
			xFrom = karma.getInt(1);
			yTo = karma.getInt(2);
		}

		override public function toKarma():Karma {
			karma.setInt(0, session);
			karma.setInt(1, xFrom);
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
		public var xFrom:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var yTo:int;

	}
}