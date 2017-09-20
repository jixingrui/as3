package zz.karma.Ice.SC{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_SeeChange extends KarmaReaderA {
		public static const type:int = 94033940;

		public function K_SeeChange(space:KarmaSpace) {
			super(space, type , 110063164);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			id = karma.getInt(0);
			form = karma.getBytes(1);
			angle = karma.getInt(2);
		}

		override public function toKarma():Karma {
			karma.setInt(0, id);
			karma.setBytes(1, form);
			karma.setInt(2, angle);
			return karma;
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var id:int;
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
		public var angle:int;

	}
}