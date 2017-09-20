package zz.karma.Maze{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_Woo extends KarmaReaderA {
		public static const type:int = 56529397;

		public function K_Woo(space:KarmaSpace) {
			super(space, type , 67388637);
		}

		override public function fromKarma(karma:Karma):void {
			tag = karma.getString(0);
			animal = karma.getBytes(1);
			doorToName = karma.getString(2);
			tid = karma.getInt(3);
			name = karma.getString(4);
			doorToTid = karma.getInt(5);
			x = karma.getInt(6);
			y = karma.getInt(7);
			angle = karma.getInt(8);
		}

		override public function toKarma():Karma {
			karma.setString(0, tag);
			karma.setBytes(1, animal);
			karma.setString(2, doorToName);
			karma.setInt(3, tid);
			karma.setString(4, name);
			karma.setInt(5, doorToTid);
			karma.setInt(6, x);
			karma.setInt(7, y);
			karma.setInt(8, angle);
			return karma;
		}

		/**
		*<p>type = STRING
		*<p> --note-- 
		*<p>empty
		*/
		public var tag:String;
		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>GalPack of button.animal
		*/
		public var animal:ZintBuffer;
		/**
		*<p>type = STRING
		*<p> --note-- 
		*<p>empty
		*/
		public var doorToName:String;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var tid:int;
		/**
		*<p>type = STRING
		*<p> --note-- 
		*<p>empty
		*/
		public var name:String;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var doorToTid:int;
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