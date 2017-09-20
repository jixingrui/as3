package zz.karma.JuniorEdit{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_CS extends KarmaReaderA {
		public static const type:int = 18383336;

		public function K_CS(space:KarmaSpace) {
			super(space, type , 70160614);
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
		*<p>[Save] empty
		*<p>[Wipe] empty
		*<p>[Load] empty
		*<p>[Sdk] empty
		*<p>[ReportRelation] empty
		*<p>[TestRun] empty
		*<p>[SelectIdea] empty
		*<p>[SaveIdea] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var send:Karma;

		/**
		*Wipe
		*/
		public static const T_Wipe:int = 18384280;
		/**
		*TestRun
		*/
		public static const T_TestRun:int = 65371461;
		/**
		*SaveIdea
		*/
		public static const T_SaveIdea:int = 70159980;
		/**
		*Load
		*/
		public static const T_Load:int = 18384283;
		/**
		*Sdk
		*/
		public static const T_Sdk:int = 18384286;
		/**
		*ReportRelation
		*/
		public static const T_ReportRelation:int = 18384290;
		/**
		*Save
		*/
		public static const T_Save:int = 18384277;
		/**
		*SelectIdea
		*/
		public static const T_SelectIdea:int = 70158352;
	}
}