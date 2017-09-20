package zzz.karma._JuniorEngine._CS{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class CSI extends KarmaReaderA {
		public static const type:int = 18828980;
		public static const version:int = 18913697;

		public function CSI(space:KarmaSpace) {
			super(space, type , version);
		}

		/**
		*<p>type = KARMA
		*<p>[TurnOn] empty
		*<p>[TurnOff] empty
		*<p>[AddValue] empty
		*<p>[SetValue] empty
		*<p>[AskState] empty
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
		*AddValue
		*/
		public static const T_AddValue:int = 18829343;
		/**
		*TurnOff
		*/
		public static const T_TurnOff:int = 18829341;
		/**
		*TurnOn
		*/
		public static const T_TurnOn:int = 18829339;
		/**
		*AskState
		*/
		public static const T_AskState:int = 18829347;
		/**
		*SetValue
		*/
		public static const T_SetValue:int = 18829345;
	}
}