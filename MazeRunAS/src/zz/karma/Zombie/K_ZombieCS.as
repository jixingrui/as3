package zz.karma.Zombie{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_ZombieCS extends KarmaReaderA {
		public static const type:int = 94417305;

		public function K_ZombieCS(space:KarmaSpace) {
			super(space, type , 118541581);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			msg = karma.getKarma(0);
		}

		override public function toKarma():Karma {
			karma.setKarma(0, msg);
			return karma;
		}

		/**
		*<p>type = KARMA
		*<p>[IceCS] empty
		*<p>[CreateNpc] empty
		*<p>[MazeInfo] empty
		*<p>[FindPathRet] empty
		*<p>[RandDestRet] empty
		*<p>[EscapeRet] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var msg:Karma;

		/**
		*MazeInfo
		*/
		public static const T_MazeInfo:int = 98702674;
		/**
		*EscapeRet
		*/
		public static const T_EscapeRet:int = 118541137;
		/**
		*IceCS
		*/
		public static const T_IceCS:int = 94410550;
		/**
		*FindPathRet
		*/
		public static const T_FindPathRet:int = 99367636;
		/**
		*CreateNpc
		*/
		public static const T_CreateNpc:int = 94411149;
		/**
		*RandDestRet
		*/
		public static const T_RandDestRet:int = 110963347;
	}
}