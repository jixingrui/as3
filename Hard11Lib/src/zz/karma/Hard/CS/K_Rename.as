package zz.karma.Hard.CS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: depends on selected
	*/
	public class K_Rename extends KarmaReaderA {
		public static const type:int = 18416120;

		public function K_Rename(space:KarmaSpace) {
			super(space, type , 18912951);
		}

		override public function fromKarma(karma:Karma):void {
			name = karma.getString(0);
		}

		override public function toKarma():Karma {
			karma.setString(0, name);
			return karma;
		}

		/**
		*<p>type = STRING
		*<p> --note-- 
		*<p>new name
		*/
		public var name:String;

	}
}