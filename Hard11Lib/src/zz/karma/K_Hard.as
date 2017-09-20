package zz.karma{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: C:Client
	*<p>S:Server
	*<p>P:Programmer
	*<p>H:Hard general
	*<p>I:Hard Individual
	*/
	public class K_Hard extends KarmaReaderA {
		public static const type:int = 18389414;

		public function K_Hard(space:KarmaSpace) {
			super(space, type , 18912893);
		}

		override public function fromKarma(karma:Karma):void {
		}

		override public function toKarma():Karma {
			return karma;
		}


	}
}