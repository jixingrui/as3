package zz.karma.Hard.Hub.HubCS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_HardMsgCS extends KarmaReaderA {
		public static const type:int = 18406023;

		public function K_HardMsgCS(space:KarmaSpace) {
			super(space, type , 18912965);
		}

		override public function fromKarma(karma:Karma):void {
			idxHard = karma.getInt(0);
			msgCS = karma.getKarma(1);
		}

		override public function toKarma():Karma {
			karma.setInt(0, idxHard);
			karma.setKarma(1, msgCS);
			return karma;
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var idxHard:int;
		/**
		*<p>type = KARMA
		*<p>[CS] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var msgCS:Karma;

		/**
		*CS
		*/
		public static const T_CS:int = 18389857;
	}
}