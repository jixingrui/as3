package zz.karma.Ice.CS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

import zz.karma.Ice.K_Pos;

	/**
	*<p>note: empty
	*/
	public class K_Jump extends KarmaReaderA {
		public static const type:int = 93485716;

		public function K_Jump(space:KarmaSpace) {
			super(space, type , 93525169);
		to=new K_Pos(space);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			to.fromKarma(karma.getKarma(0));
		}

		override public function toKarma():Karma {
			if(to != null)
				karma.setKarma(0, to.toKarma());
			return karma;
		}

		/**
		*<p>type = KARMA
		*<p>[Pos] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var to:K_Pos;

		/**
		*Pos
		*/
		public static const T_Pos:int = 93485143;
	}
}