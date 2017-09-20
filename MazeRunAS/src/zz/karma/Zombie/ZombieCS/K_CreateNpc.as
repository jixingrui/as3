package zz.karma.Zombie.ZombieCS{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

import zz.karma.Zombie.K_Pos;

	/**
	*<p>note: empty
	*/
	public class K_CreateNpc extends KarmaReaderA {
		public static const type:int = 94411149;

		public function K_CreateNpc(space:KarmaSpace) {
			super(space, type , 94418143);
		startPos=new K_Pos(space);
		}

		override public function fromKarma(karma:Karma):void {
			if(karma==null) return;
			aiType = karma.getInt(0);
			shape = karma.getString(1);
			mapBase = karma.getBytes(2);
			startPos.fromKarma(karma.getKarma(3));
		}

		override public function toKarma():Karma {
			karma.setInt(0, aiType);
			karma.setString(1, shape);
			karma.setBytes(2, mapBase);
			if(startPos != null)
				karma.setKarma(3, startPos.toKarma());
			return karma;
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>1=zombie
		*<p>2=shooter
		*/
		public var aiType:int;
		/**
		*<p>type = STRING
		*<p> --note-- 
		*<p>animal mc5
		*/
		public var shape:String;
		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>RoadMap.fromBytes();
		*/
		public var mapBase:ZintBuffer;
		/**
		*<p>type = KARMA
		*<p>[Pos] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var startPos:K_Pos;

		/**
		*Pos
		*/
		public static const T_Pos:int = 94416506;
	}
}