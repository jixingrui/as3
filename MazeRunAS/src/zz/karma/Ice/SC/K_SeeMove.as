package zz.karma.Ice.SC{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_SeeMove extends KarmaReaderA {
		public static const type:int = 113916805;

		public function K_SeeMove(space:KarmaSpace) {
			super(space, type , 113917438);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			id = karma.getInt(0);
			x = karma.getInt(1);
			y = karma.getInt(2);
			angle = karma.getInt(3);
		}

		override public function toKarma():Karma {
			karma.setInt(0, id);
			karma.setInt(1, x);
			karma.setInt(2, y);
			karma.setInt(3, angle);
			return karma;
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var id:int;
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
		public var angle:int;

	}
}