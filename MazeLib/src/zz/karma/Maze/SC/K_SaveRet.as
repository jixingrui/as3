package zz.karma.Maze.SC{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_SaveRet extends KarmaReaderA {
		public static const type:int = 56645893;

		public function K_SaveRet(space:KarmaSpace) {
			super(space, type , 58135106);
		}

		override public function fromKarma(karma:Karma):void {
			mazeData = karma.getBytes(0);
			slaveList = karma.getBytes(1);
		}

		override public function toKarma():Karma {
			karma.setBytes(0, mazeData);
			karma.setBytes(1, slaveList);
			return karma;
		}

		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>empty
		*/
		public var mazeData:ZintBuffer;
		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>empty
		*/
		public var slaveList:ZintBuffer;

	}
}