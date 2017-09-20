package zz.karma.Hard.Hub.HubSC{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_HardMsgSC extends KarmaReaderA {
		public static const type:int = 18406057;

		public function K_HardMsgSC(space:KarmaSpace) {
			super(space, type , 18912967);
		}

		override public function fromKarma(karma:Karma):void {
			idxHard = karma.getInt(0);
			msgSC = karma.getKarma(1);
		}

		override public function toKarma():Karma {
			karma.setInt(0, idxHard);
			karma.setKarma(1, msgSC);
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
		*<p>[SC] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var msgSC:Karma;

		/**
		*SC
		*/
		public static const T_SC:int = 18389853;
	}
}