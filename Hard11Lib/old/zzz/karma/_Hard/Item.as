package zzz.karma._Hard{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class Item extends KarmaReaderA {
		public static const type:int = 18389685;
		public static const version:int = 18912895;

		public function Item(space:KarmaSpace) {
			super(space, type , version);
		}

		/**
		*<p>type = STRING
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_name:int = 0;
		/**
		*<p>type = STRING
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_nameTail:int = 1;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>>0显示加号
		*/
		public static const F_numChildren:int = 2;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_color:int = 3;
		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_data:int = 4;

	}
}