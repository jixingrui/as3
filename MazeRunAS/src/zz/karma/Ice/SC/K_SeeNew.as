package zz.karma.Ice.SC{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

import zz.karma.Ice.K_Pos;

	/**
	*<p>note: empty
	*/
	public class K_SeeNew extends KarmaReaderA {
		public static const type:int = 93487617;

		public function K_SeeNew(space:KarmaSpace) {
			super(space, type , 93525175);
		pos=new K_Pos(space);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			pos.fromKarma(karma.getKarma(0));
			form = karma.getBytes(1);
			id = karma.getInt(2);
		}

		override public function toKarma():Karma {
			if(pos != null)
				karma.setKarma(0, pos.toKarma());
			karma.setBytes(1, form);
			karma.setInt(2, id);
			return karma;
		}

		/**
		*<p>type = KARMA
		*<p>[Pos] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var pos:K_Pos;
		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>empty
		*/
		public var form:ZintBuffer;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var id:int;

		/**
		*Pos
		*/
		public static const T_Pos:int = 93485143;
	}
}