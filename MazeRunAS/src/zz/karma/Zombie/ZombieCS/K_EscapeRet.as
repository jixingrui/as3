package zz.karma.Zombie.ZombieCS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_EscapeRet extends KarmaReaderA {
		public static const type:int = 118541137;

		public function K_EscapeRet(space:KarmaSpace) {
			super(space, type , 121126494);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			session = karma.getInt(0);
			path = karma.getBytes(1);
		}

		override public function toKarma():Karma {
			karma.setInt(0, session);
			karma.setBytes(1, path);
			return karma;
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var session:int;
		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>empty
		*/
		public var path:ZintBuffer;

	}
}