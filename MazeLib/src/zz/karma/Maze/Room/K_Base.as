package zz.karma.Maze.Room{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_Base extends KarmaReaderA {
		public static const type:int = 56530018;

		public function K_Base(space:KarmaSpace) {
			super(space, type , 56619176);
		}

		override public function fromKarma(karma:Karma):void {
			name = karma.getString(0);
			zbase = karma.getBytes(1);
		}

		override public function toKarma():Karma {
			karma.setString(0, name);
			karma.setBytes(1, zbase);
			return karma;
		}

		/**
		*<p>type = STRING
		*<p> --note-- 
		*<p>empty
		*/
		public var name:String;
		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>data
		*/
		public var zbase:ZintBuffer;

	}
}