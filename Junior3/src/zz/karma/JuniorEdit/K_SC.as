package zz.karma.JuniorEdit{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_SC extends KarmaReaderA {
		public static const type:int = 18383265;

		public function K_SC(space:KarmaSpace) {
			super(space, type , 70158939);
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
		*<p>[SaveRet] empty
		*<p>[SdkRet] empty
		*<p>[ReportIdeaRet] empty
		*<p>[TestRunRet] empty
		*<p>[SelectIdeaRet] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var send:Karma;

		/**
		*TestRunRet
		*/
		public static const T_TestRunRet:int = 65371169;
		/**
		*SelectIdeaRet
		*/
		public static const T_SelectIdeaRet:int = 70158554;
		/**
		*SdkRet
		*/
		public static const T_SdkRet:int = 18383838;
		/**
		*ReportIdeaRet
		*/
		public static const T_ReportIdeaRet:int = 18383840;
		/**
		*SaveRet
		*/
		public static const T_SaveRet:int = 18383814;
	}
}