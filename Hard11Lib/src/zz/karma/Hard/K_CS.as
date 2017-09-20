package zz.karma.Hard{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: send msg from c to s
	*/
	public class K_CS extends KarmaReaderA {
		public static const type:int = 18389857;

		public function K_CS(space:KarmaSpace) {
			super(space, type , 18912905);
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
		public var send:Karma;

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