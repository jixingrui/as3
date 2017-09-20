package zz.karma.Hard{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_Item extends KarmaReaderA {
		public static const type:int = 18389685;

		public function K_Item(space:KarmaSpace) {
			super(space, type , 84998000);
		}

		override public function fromKarma(karma:Karma):void {
			name = karma.getString(0);
			nameTail = karma.getString(1);
			numChildren = karma.getInt(2);
			color = karma.getInt(3);
			data = karma.getBytes(4);
			sortValue = karma.getInt(5);
		}

		override public function toKarma():Karma {
			karma.setString(0, name);
			karma.setString(1, nameTail);
			karma.setInt(2, numChildren);
			karma.setInt(3, color);
			karma.setBytes(4, data);
			karma.setInt(5, sortValue);
			return karma;
		}

		/**
		*<p>type = STRING
		*<p> --note-- 
		*<p>empty
		*/
		public var name:String;
		/**
		*<p>type = STRING
		*<p> --note-- 
		*<p>empty
		*/
		public var nameTail:String;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>>0显示加号
		*/
		public var numChildren:int;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var color:int;
		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>empty
		*/
		public var data:ZintBuffer;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public var sortValue:int;

	}
}