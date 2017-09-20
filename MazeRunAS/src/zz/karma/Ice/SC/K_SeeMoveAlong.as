package zz.karma.Ice.SC{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_SeeMoveAlong extends KarmaReaderA {
		public static const type:int = 93489797;

		public function K_SeeMoveAlong(space:KarmaSpace) {
			super(space, type , 97787343);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			id = karma.getInt(0);
			path = karma.getBytes(1);
		}

		override public function toKarma():Karma {
			karma.setInt(0, id);
			karma.setBytes(1, path);
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
		public var path:ZintBuffer;

	}
}