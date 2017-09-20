package zz.karma.Ice{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_SC extends KarmaReaderA {
		public static const type:int = 93487551;

		public function K_SC(space:KarmaSpace) {
			super(space, type , 123987277);
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
		*<p>[EnterRoomRet] empty
		*<p>[SeeNew] empty
		*<p>[SeeMoveAlong] empty
		*<p>[SeeLeave] empty
		*<p>[WatchNotify] empty
		*<p>[ReceiveMsg] empty
		*<p>[SeeChange] empty
		*<p>[SeeMove] empty
		*<p>[SeeStop] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var msg:Karma;

		/**
		*ReceiveMsg
		*/
		public static const T_ReceiveMsg:int = 94025674;
		/**
		*SeeNew
		*/
		public static const T_SeeNew:int = 93487617;
		/**
		*SeeLeave
		*/
		public static const T_SeeLeave:int = 93524496;
		/**
		*WatchNotify
		*/
		public static const T_WatchNotify:int = 93523591;
		/**
		*SeeStop
		*/
		public static const T_SeeStop:int = 123986839;
		/**
		*SeeMoveAlong
		*/
		public static const T_SeeMoveAlong:int = 93489797;
		/**
		*EnterRoomRet
		*/
		public static const T_EnterRoomRet:int = 93489339;
		/**
		*SeeChange
		*/
		public static const T_SeeChange:int = 94033940;
		/**
		*SeeMove
		*/
		public static const T_SeeMove:int = 113916805;
	}
}