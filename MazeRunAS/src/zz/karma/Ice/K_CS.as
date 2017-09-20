package zz.karma.Ice{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_CS extends KarmaReaderA {
		public static const type:int = 93484375;

		public function K_CS(space:KarmaSpace) {
			super(space, type , 109296932);
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
		*<p>[EnterRoom] empty
		*<p>[Jump] empty
		*<p>[Move] empty
		*<p>[ChangeSpeed] empty
		*<p>[AddWatch] empty
		*<p>[RemoveWatch] empty
		*<p>[ChangeForm] empty
		*<p>[SendPrivate] empty
		*<p>[SendPublic] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var msg:Karma;

		/**
		*ChangeForm
		*/
		public static const T_ChangeForm:int = 93559043;
		/**
		*Move
		*/
		public static const T_Move:int = 93485888;
		/**
		*SendPrivate
		*/
		public static const T_SendPrivate:int = 94026312;
		/**
		*AddWatch
		*/
		public static const T_AddWatch:int = 93522544;
		/**
		*RemoveWatch
		*/
		public static const T_RemoveWatch:int = 93517606;
		/**
		*Jump
		*/
		public static const T_Jump:int = 93485716;
		/**
		*ChangeSpeed
		*/
		public static const T_ChangeSpeed:int = 93487160;
		/**
		*EnterRoom
		*/
		public static const T_EnterRoom:int = 93484473;
		/**
		*SendPublic
		*/
		public static const T_SendPublic:int = 94026582;
	}
}