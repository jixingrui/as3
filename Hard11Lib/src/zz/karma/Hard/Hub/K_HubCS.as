package zz.karma.Hard.Hub{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_HubCS extends KarmaReaderA {
		public static const type:int = 18389993;

		public function K_HubCS(space:KarmaSpace) {
			super(space, type , 18912909);
		}

		override public function fromKarma(karma:Karma):void {
			send = karma.getKarma(0);
		}

		override public function toKarma():Karma {
			karma.setKarma(0, send);
			return karma;
		}

		/**
		*<p>type = KARMA
		*<p>[CustomMsg] empty
		*<p>[HardMsgCS] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var send:Karma;

		/**
		*CustomMsg
		*/
		public static const T_CustomMsg:int = 18389991;
		/**
		*HardMsgCS
		*/
		public static const T_HardMsgCS:int = 18406023;
	}
}