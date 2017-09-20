package zz.karma.Ice.CS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

import zz.karma.Ice.K_Pos;

	/**
	*<p>note: empty
	*/
	public class K_EnterRoom extends KarmaReaderA {
		public static const type:int = 93484473;

		public function K_EnterRoom(space:KarmaSpace) {
			super(space, type , 121761294);
		initialPos=new K_Pos(space);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			roomUID = karma.getString(0);
			initialPos.fromKarma(karma.getKarma(1));
			form = karma.getBytes(2);
			base = karma.getBytes(3);
		}

		override public function toKarma():Karma {
			karma.setString(0, roomUID);
			if(initialPos != null)
				karma.setKarma(1, initialPos.toKarma());
			karma.setBytes(2, form);
			karma.setBytes(3, base);
			return karma;
		}

		/**
		*<p>type = STRING
		*<p> --note-- 
		*<p>empty
		*/
		public var roomUID:String;
		/**
		*<p>type = KARMA
		*<p>[Pos] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var initialPos:K_Pos;
		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>形象数据。包含图形和当前的动作。
		*/
		public var form:ZintBuffer;
		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>empty
		*/
		public var base:ZintBuffer;

		/**
		*Pos
		*/
		public static const T_Pos:int = 93485143;
	}
}