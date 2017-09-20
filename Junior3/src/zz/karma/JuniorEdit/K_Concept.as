package zz.karma.JuniorEdit{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_Concept extends KarmaReaderA {
		public static const type:int = 18383338;

		public function K_Concept(space:KarmaSpace) {
			super(space, type , 72010314);
		}

		override public function fromKarma(karma:Karma):void {
			counterTrigger = karma.getInt(0);
			note = karma.getString(1);
			ioType = karma.getInt(2);
			id = karma.getInt(3);
			name = karma.getString(4);
		}

		override public function toKarma():Karma {
			karma.setInt(0, counterTrigger);
			karma.setString(1, note);
			karma.setInt(2, ioType);
			karma.setInt(3, id);
			karma.setString(4, name);
			return karma;
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var counterTrigger:int;
		/**
		*<p>type = STRING
		*<p> --note-- 
		*<p>empty
		*/
		public var note:String;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var ioType:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var id:int;
		/**
		*<p>type = STRING
		*<p> --note-- 
		*<p>empty
		*/
		public var name:String;

	}
}