package zz.karma.Ice{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_Pos extends KarmaReaderA {
		public static const type:int = 93485143;

		public function K_Pos(space:KarmaSpace) {
			super(space, type , 93560353);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			x = karma.getInt(0);
			y = karma.getInt(1);
			z = karma.getInt(2);
			angle = karma.getInt(3);
		}

		override public function toKarma():Karma {
			karma.setInt(0, x);
			karma.setInt(1, y);
			karma.setInt(2, z);
			karma.setInt(3, angle);
			return karma;
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var x:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var y:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var z:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var angle:int;

	}
}