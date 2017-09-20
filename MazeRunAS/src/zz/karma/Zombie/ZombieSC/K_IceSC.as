package zz.karma.Zombie.ZombieSC{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_IceSC extends KarmaReaderA {
		public static const type:int = 94410968;

		public function K_IceSC(space:KarmaSpace) {
			super(space, type , 94418144);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			msg = karma.getBytes(0);
		}

		override public function toKarma():Karma {
			karma.setBytes(0, msg);
			return karma;
		}

		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>empty
		*/
		public var msg:ZintBuffer;

	}
}