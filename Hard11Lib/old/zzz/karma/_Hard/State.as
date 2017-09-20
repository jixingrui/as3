package zzz.karma._Hard{

import azura.karma.run.KarmaReaderA;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: Server and Client each has one copy
	*/
	public class State extends KarmaReaderA {
		public static const type:int = 18389688;
		public static const version:int = 18912897;

		public function State(space:KarmaSpace) {
			super(space, type , version);
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>-1=unselected
		*/
		public static const F_selectedIdx:int = 0;
		/**
		*<p>type = BOOLEAN
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_selected_up_down:int = 1;
		/**
		*<p>type = LIST
		*<p>[Item] empty
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_upList:int = 2;
		/**
		*<p>type = LIST
		*<p>[Item] empty
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_downList:int = 3;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>record from askMore
		*/
		public static const F_pageSize:int = 4;
		/**
		*<p>type = KARMA
		*<p>[Item] empty
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_heldItem:int = 5;
		/**
		*<p>type = KARMA
		*<p>[Item] empty
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_heldItemMom:int = 6;
		/**
		*<p>type = BOOLEAN
		*<p> --note-- 
		*<p>empty
		*/
		public static const F_isTree:int = 7;
		/**
		*<p>type = KARMA
		*<p>[Item] empty
		*<p> --note-- 
		*<p>根据State.selected_up_down和State.selectedIdx找到Item放在这里
		*/
		public static const F_selectedItem:int = 8;

		/**
		*Item
		*/
		public static const T_Item:int = 18389685;
	}
}