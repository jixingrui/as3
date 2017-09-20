package zz.karma.Zombie.ZombieCS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_FindPathRet extends KarmaReaderA {
		public static const type:int = 99367636;

		public function K_FindPathRet(space:KarmaSpace) {
			super(space, type , 110963648);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			path = karma.getBytes(0);
			session = karma.getInt(1);
		}

		override public function toKarma():Karma {
			karma.setBytes(0, path);
			karma.setInt(1, session);
			return karma;
		}

		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>empty
		*/
		public var path:ZintBuffer;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var session:int;

	}
}