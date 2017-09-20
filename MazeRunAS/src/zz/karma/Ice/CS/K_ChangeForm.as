package zz.karma.Ice.CS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: 
	*/
	public class K_ChangeForm extends KarmaReaderA {
		public static const type:int = 93559043;

		public function K_ChangeForm(space:KarmaSpace) {
			super(space, type , 93560354);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			form = karma.getBytes(0);
		}

		override public function toKarma():Karma {
			karma.setBytes(0, form);
			return karma;
		}

		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>empty
		*/
		public var form:ZintBuffer;

	}
}