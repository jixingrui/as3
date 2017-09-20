package zz.karma.Zombie.ZombieSC{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;


	/**
	*<p>note: empty
	*/
	public class K_Escape extends KarmaReaderA {
		public static const type:int = 118540453;

		public function K_Escape(space:KarmaSpace) {
			super(space, type , 121126495);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			session = karma.getInt(0);
			xRunner = karma.getInt(1);
			yRunner = karma.getInt(2);
			dist = karma.getInt(3);
			xMonster = karma.getInt(4);
			yMonster = karma.getInt(5);
		}

		override public function toKarma():Karma {
			karma.setInt(0, session);
			karma.setInt(1, xRunner);
			karma.setInt(2, yRunner);
			karma.setInt(3, dist);
			karma.setInt(4, xMonster);
			karma.setInt(5, yMonster);
			return karma;
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var session:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var xRunner:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var yRunner:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var dist:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var xMonster:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var yMonster:int;

	}
}