package zz.karma.Zombie.ZombieCS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_MazeInfo extends KarmaReaderA {
		public static const type:int = 98702674;

		public function K_MazeInfo(space:KarmaSpace) {
			super(space, type , 98702897);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			data = karma.getBytes(0);
		}

		override public function toKarma():Karma {
			karma.setBytes(0, data);
			return karma;
		}

		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>empty
		*/
		public var data:ZintBuffer;

	}
}