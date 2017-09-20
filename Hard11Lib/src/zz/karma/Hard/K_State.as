package zz.karma.Hard{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: Server and Client each has one copy
	*/
	public class K_State extends KarmaReaderA {
		public static const type:int = 18389688;

		public function K_State(space:KarmaSpace) {
			super(space, type , 18912897);
		}

		override public function fromKarma(karma:Karma):void {
			selectedIdx = karma.getInt(0);
			selected_up_down = karma.getBoolean(1);
			upList = karma.getList(2);
			downList = karma.getList(3);
			pageSize = karma.getInt(4);
			heldItem = karma.getKarma(5);
			heldItemMom = karma.getKarma(6);
			isTree = karma.getBoolean(7);
			selectedItem = karma.getKarma(8);
		}

		override public function toKarma():Karma {
			karma.setInt(0, selectedIdx);
			karma.setBoolean(1, selected_up_down);
			karma.setInt(4, pageSize);
			karma.setKarma(5, heldItem);
			karma.setKarma(6, heldItemMom);
			karma.setBoolean(7, isTree);
			karma.setKarma(8, selectedItem);
			return karma;
		}

		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>-1=unselected
		*/
		public var selectedIdx:int;
		/**
		*<p>type = BOOLEAN
		*<p> --note-- 
		*<p>empty
		*/
		public var selected_up_down:Boolean;
		/**
		*<p>type = LIST
		*<p>[Item] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var upList:KarmaList;
		/**
		*<p>type = LIST
		*<p>[Item] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var downList:KarmaList;
		/**
		*<p>type = INT
		*<p> --note-- 
		*<p>record from askMore
		*/
		public var pageSize:int;
		/**
		*<p>type = KARMA
		*<p>[Item] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var heldItem:Karma;
		/**
		*<p>type = KARMA
		*<p>[Item] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var heldItemMom:Karma;
		/**
		*<p>type = BOOLEAN
		*<p> --note-- 
		*<p>empty
		*/
		public var isTree:Boolean;
		/**
		*<p>type = KARMA
		*<p>[Item] empty
		*<p> --note-- 
		*<p>根据State.selected_up_down和State.selectedIdx找到Item放在这里
		*/
		public var selectedItem:Karma;

		/**
		*Item
		*/
		public static const T_Item:int = 18389685;
	}
}