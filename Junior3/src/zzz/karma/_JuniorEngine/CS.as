package zzz.karma._JuniorEngine{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class CS extends KarmaReaderA {
		public static const type:int = 18828821;
		public static const version:int = 18913687;

		public function CS(space:KarmaSpace) {
			super(space, type , version);
		}

		/**
		*<p>type = KARMA
		*<p>[Mark] empty
		*<p>[SetOutputLevel] empty
		*<p>[NewInstance] empty
		*<p>[CSI] empty
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_send:int = 0;

		/**
		*Mark
		*/
		public static const T_Mark:int = 18828973;
		/**
		*CSI
		*/
		public static const T_CSI:int = 18828980;
		/**
		*NewInstance
		*/
		public static const T_NewInstance:int = 18828978;
		/**
		*SetOutputLevel
		*/
		public static const T_SetOutputLevel:int = 18828976;
	}
}