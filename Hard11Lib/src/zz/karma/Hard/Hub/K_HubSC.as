package zz.karma.Hard.Hub{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_HubSC extends KarmaReaderA {
		public static const type:int = 18401777;

		public function K_HubSC(space:KarmaSpace) {
			super(space, type , 18912911);
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
		*<p>[HardMsgSC] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var send:Karma;

		/**
		*HardMsgSC
		*/
		public static const T_HardMsgSC:int = 18406057;
		/**
		*CustomMsg
		*/
		public static const T_CustomMsg:int = 18389991;
	}
}