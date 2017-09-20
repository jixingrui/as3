package zz.karma{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_Zombie extends KarmaReaderA {
		public static const type:int = 94410490;

		public function K_Zombie(space:KarmaSpace) {
			super(space, type , 94418138);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
		}

		override public function toKarma():Karma {
			return karma;
		}


	}
}