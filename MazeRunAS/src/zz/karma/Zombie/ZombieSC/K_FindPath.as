package zz.karma.Zombie.ZombieSC{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_FindPath extends KarmaReaderA {
		public static const type:int = 99366954;

		public function K_FindPath(space:KarmaSpace) {
			super(space, type , 110963650);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			xStart = karma.getInt(0);
			yStart = karma.getInt(1);
			xEnd = karma.getInt(2);
			yEnd = karma.getInt(3);
			session = karma.getInt(4);
		}

		override public function toKarma():Karma {
			karma.setInt(0, xStart);
			karma.setInt(1, yStart);
			karma.setInt(2, xEnd);
			karma.setInt(3, yEnd);
			karma.setInt(4, session);
			return karma;
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var xStart:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var yStart:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var xEnd:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var yEnd:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var session:int;

	}
}