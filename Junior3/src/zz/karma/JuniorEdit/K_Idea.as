package zz.karma.JuniorEdit{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_Idea extends KarmaReaderA {
		public static const type:int = 69803052;

		public function K_Idea(space:KarmaSpace) {
			super(space, type , 92571204);
		}

		override public function fromKarma(karma:Karma):void {
			defaultValue = karma.getBoolean(0);
			note = karma.getString(1);
			flashy = karma.getBoolean(2);
			outLink = karma.getBoolean(3);
		}

		override public function toKarma():Karma {
			karma.setBoolean(0, defaultValue);
			karma.setString(1, note);
			karma.setBoolean(2, flashy);
			karma.setBoolean(3, outLink);
			return karma;
		}

		/**
		*<p>type = BOOLEAN
		*<p> --note-- 
		*<p>empty
		*/
		public var defaultValue:Boolean;
		/**
		*<p>type = STRING
		*<p> --note-- 
		*<p>empty
		*/
		public var note:String;
		/**
		*<p>type = BOOLEAN
		*<p> --note-- 
		*<p>empty
		*/
		public var flashy:Boolean;
		/**
		*<p>type = BOOLEAN
		*<p> --note-- 
		*<p>empty
		*/
		public var outLink:Boolean;

	}
}