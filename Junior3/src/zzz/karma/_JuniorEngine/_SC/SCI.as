package zzz.karma._JuniorEngine._SC{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class SCI extends KarmaReaderA {
		public static const type:int = 18829763;
		public static const version:int = 18913703;

		public function SCI(space:KarmaSpace) {
			super(space, type , version);
		}

		/**
		*<p>type = KARMA
		*<p>[Notify] empty
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_msg:int = 0;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_idInstance:int = 1;

		/**
		*Notify
		*/
		public static const T_Notify:int = 18829948;
	}
}