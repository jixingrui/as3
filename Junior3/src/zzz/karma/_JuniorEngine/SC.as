package zzz.karma._JuniorEngine{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class SC extends KarmaReaderA {
		public static const type:int = 18829676;
		public static const version:int = 18913689;

		public function SC(space:KarmaSpace) {
			super(space, type , version);
		}

		/**
		*<p>type = KARMA
		*<p>[Mark] empty
		*<p>[NewInstanceR] empty
		*<p>[SCI] empty
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_send:int = 0;

		/**
		*Mark
		*/
		public static const T_Mark:int = 18829759;
		/**
		*SCI
		*/
		public static const T_SCI:int = 18829763;
		/**
		*NewInstanceR
		*/
		public static const T_NewInstanceR:int = 18829761;
	}
}