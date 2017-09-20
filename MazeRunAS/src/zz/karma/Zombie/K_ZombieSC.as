package zz.karma.Zombie{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_ZombieSC extends KarmaReaderA {
		public static const type:int = 94417820;

		public function K_ZombieSC(space:KarmaSpace) {
			super(space, type , 118541582);
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
		*<p>[IceSC] empty
		*<p>[FindPath] empty
		*<p>[RandDest] empty
		*<p>[Escape] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var msg:Karma;

		/**
		*Escape
		*/
		public static const T_Escape:int = 118540453;
		/**
		*FindPath
		*/
		public static const T_FindPath:int = 99366954;
		/**
		*RandDest
		*/
		public static const T_RandDest:int = 110962795;
		/**
		*IceSC
		*/
		public static const T_IceSC:int = 94410968;
	}
}