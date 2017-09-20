package zzz.karma{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: C:Client
	*<p>S:Server
	*<p>P:Programmer
	*<p>H:Hard general
	*<p>I:Hard Individual
	*/
	public class Hard extends KarmaReaderA {
		public static const type:int = 18389414;
		public static const version:int = 18912893;

		public function Hard(space:KarmaSpace) {
			super(space, type , version);
		}


	}
}