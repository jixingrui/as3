package zz.karma.Maze{

import azura.common.collections.ZintBuffer;
import azura.karma.run.Karma;
import azura.karma.run.KarmaReaderA;
import azura.karma.run.bean.KarmaList;
import azura.karma.def.KarmaSpace;

	/**
	*<p>note: empty
	*/
	public class K_Room extends KarmaReaderA {
		public static const type:int = 56529372;

		public function K_Room(space:KarmaSpace) {
			super(space, type , 57934918);
		}

		override public function fromKarma(karma:Karma):void {
			tag = karma.getString(0);
			groundImage = karma.getBytes(1);
			mask = karma.getBytes(2);
			baseList = karma.getList(3);
			tid = karma.getInt(4);
			name = karma.getString(5);
			tidParent = karma.getInt(6);
		}

		override public function toKarma():Karma {
			karma.setString(0, tag);
			karma.setBytes(1, groundImage);
			karma.setBytes(2, mask);
			karma.setInt(4, tid);
			karma.setString(5, name);
			karma.setInt(6, tidParent);
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
		*<p>GalPack of .zebra
		*/
		public var groundImage:ZintBuffer;
		/**
		*<p>type = BYTES
		*<p> --note-- 
		*<p>GalPack of Zmask
		*/
		public var mask:ZintBuffer;
		/**
		*<p>type = LIST
		*<p>[Base] empty
		*<p> --note-- 
		*<p>empty
		*/
		public var baseList:KarmaList;
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
		public var tidParent:int;

		/**
		*Base
		*/
		public static const T_Base:int = 56530018;
	}
}