package zzz.karma._Hard{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: send msg from c to s
	*/
	public class CS extends KarmaReaderA {
		public static const type:int = 18389857;
		public static const version:int = 18912905;

		public function CS(space:KarmaSpace) {
			super(space, type , version);
		}

		/**
		*<p>type = KARMA
		*<p>[Add] empty
		*<p>[SelectCS] empty
		*<p>[UnselectCS] empty
		*<p>[Rename] empty
		*<p>[Save] empty
		*<p>[Delete] empty
		*<p>[Hold] empty
		*<p>[Drop] empty
		*<p>[Jump] empty
		*<p>[AskMore] empty
		*<p> --note-- 
		*<p>pack me and send to server，数据同步到界面上去
		*/
		public static const F_send:int = 0;

		/**
		*AskMore
		*/
		public static const T_AskMore:int = 18419577;
		/**
		*Rename
		*/
		public static const T_Rename:int = 18416120;
		/**
		*Save
		*/
		public static const T_Save:int = 18416122;
		/**
		*Delete
		*/
		public static const T_Delete:int = 18416124;
		/**
		*Hold
		*/
		public static const T_Hold:int = 18416126;
		/**
		*Drop
		*/
		public static const T_Drop:int = 18416128;
		/**
		*Jump
		*/
		public static const T_Jump:int = 18416130;
		/**
		*SelectCS
		*/
		public static const T_SelectCS:int = 18416116;
		/**
		*Add
		*/
		public static const T_Add:int = 18390071;
		/**
		*UnselectCS
		*/
		public static const T_UnselectCS:int = 18416118;
	}
}