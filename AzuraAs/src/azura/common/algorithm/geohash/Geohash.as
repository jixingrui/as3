package azura.common.algorithm.geohash
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;

	/**
	 * Geohash算出を行うためのユーティリティクラス
	 * TODO 上下左右の矩形取得ロジックの実装
	 * TODO 拡大/縮小ロジックの実装
	 * TODO Number型で計算しているので端数がぶれるのでその対応。
	 * 
	 * @see http://en.wikipedia.org/wiki/Geohash
	 */
	public class Geohash
	{
		/** Base32用の変換テーブル */
		private static const BASE32:Array = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "b", "c", "d", "e", "f",
			"g", "h", "j", "k", "m", "n", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
		/** BASE32で表現されるbit数*/
		private static const BASE32_BIT_SIZE:int = 5;
		/** デフォルトとなる精度 */
		private static const ACCURACY_DEFAULT:int = 6;
		/** 緯度のキー情報 */
		public static const LAT_KEY:String = "lat";
		/** 経度のキー情報 */
		public static const LNG_KEY:String = "lng";
		
		/** 
		 * 上方向
		 * @deprecated 未実装
		 */
		private static const UPPER_DIRECTION:int = 1;
		/** 
		 * 下方向
		 * @deprecated 未実装
		 */
		private static const LOWER_DIRECTION:int = 2;
		/** 
		 * 左方向
		 * @deprecated 未実装
		 */
		private static const LEFT_DIRECTION:int = 3;
		/** 
		 *　右方向
		 * @deprecated 未実装
		 */
		private static const RIGHT_DIRECTION:int = 4;
		
		/** 
		 * キャッシュテーブル
		 * @deprecated 実装されていません。
		 */
		public var hashMap:Dictionary;
		
		/** コンストラクタ */
		public function Geohash()
		{
			hashMap = new Dictionary();
		}
		/**
		 * 位置情報をgeohashにエンコードする。
		 * @param	lat 緯度
		 * @param	lng 経度
		 * @param	act 精度(1 <= act)
		 * @return エンコードされたgeohash情報
		 */
		public function encode(lat:Number, lng:Number, act:int=ACCURACY_DEFAULT):String
		{
			//TODO キャッシュを調べてから実処理
			var la:String = getLatBits(lat, act);
			var ln:String = getLngBits(lng, act);
			
			return this.getGeohash(la, ln, act);
		}
		/**
		 * Geohashを位置情報にデコードする
		 * @param	hash Geohash情報
		 * @return デコードされた位置情報
		 */
		public function decode(hash:String):Object
		{
			//TODO キャッシュを調べてから実処理
			if (hash == null || hash.length == 0) {
				throw new ArgumentError();
			}
			// ビット数列に変換する
			var bitValue:String = this.convertBits(hash);
			// 緯度経度に分割
			var latlng:Object = this.divide(bitValue);
			trace("lat::" + latlng[Geohash.LAT_KEY] + ", lng::" + latlng[Geohash.LNG_KEY]);
			// 緯度の2分割法で絞り込みを行う。
			var lat:Number = this.findLatRectangle(latlng[Geohash.LAT_KEY]);
			var lng:Number = this.findLngRectangle(latlng[Geohash.LNG_KEY]);
			return {"lat" : lat, "lng" : lng}
		}
		/**
		 * 5byteずつのbit配列に変換して返す。
		 * @param	geohash	ジオハッシュ情報
		 * @return	ビット列に分解されたビット列
		 */
		private function convertBits(geohash:String):String
		{
			var ret:String = "";
			var index:int = geohash.length;
			for (var i:int = 0; i < index; i++)
			{
				var c:String = geohash.charAt(i);
				var line:int = BASE32.indexOf(c);
				if (line == -1)
				{
					throw new ArgumentError(c + "::一致するBASE32のエンコード情報が見つかりませんでした");
				}
				// 5bitのbit列に変換
				//TODO bit数のバリデーションが必要
				var bitSize:String = line.toString(2);
				// 空白を0で埋める。
				while(bitSize.length < 5)
				{
					bitSize = "0" + bitSize;
				}
				ret += bitSize;
			}
			return ret;
		}
		/**
		 * ビット配列を緯度/経度情報に分割して返す。
		 * @param	bitValue	ビット配列
		 * @return	位置情報を内包するオブジェクト
		 */
		private function divide(bitValue:String):Object
		{
			var lng:String = "";	// 経度(偶数列)
			var lat:String = "";	// 緯度(奇数列)
			var bitIndex:int = bitValue.length;
			for (var j:int = 0; j < bitIndex; j++)
			{
				var c:String = bitValue.charAt(j);
				if (j % 2 == 0) {
					lng += c;
				} else
				{
					lat += c;
				}
			}
			return {
				"lat" : lat,
				"lng" : lng
			}
		}
		/**
		 * 緯度情報を求める。
		 * @param coordination 座標
		 */
		private function findLatRectangle(coordination:String):Number
		{
			return findRectangle(coordination, -90, 90);
		}
		/**
		 * 経度情報を求める
		 * @param coordination 座標
		 */
		private function findLngRectangle(coordination:String):Number
		{
			return findRectangle(coordination, -180, 180);
		}
		/**
		 * 2分割法で位置情報を算出する
		 * @param	coordination	位置情報
		 * @param	min	最小値
		 * @param	max	最大値
		 */
		private function findRectangle(coordination:String, min:Number, max:Number):Number
		{
			trace("coordination count :: " + coordination.length);
			var index:int = coordination.length;
			var mid:Number = 0;
			for (var i:int = 0; i < index; i++)
			{
				var c:int = int(coordination.charAt(i));
				switch (c) {
				case 0:
					max = mid;
					mid = (mid + min) / 2;
					break;
				case 1:
					min = mid;
					mid = (mid + max) / 2;
					break;
				default:
					throw new ArgumentError();
				}
			}
			trace("mid is " + mid);
			return mid;
		}
		
		/**
		 * 指定されたGeohashを1レベル拡大して返す。
		 * Geohashが既に最高精度の場合はnullを返す。
		 * TODO 拡大サイズを指定できるように
		 * @param	geohash 拡大元となるGeohash
		 * @return 拡大されたgeohashの文字列
		 * @deprecated 未実装
		 */
		public function expand(geohash:String):String
		{
			//TODO geohashをbit列にデコード
			// 指定されたサイズに従って拡大(分岐を取る)
			// エンコードして返す。
			throw new IllegalOperationError("未実装です。");
		}
		/**
		 * 指定されたgeohashを1レベル縮小して返す。
		 * Geohashが既に最小精度の場合はnullを返す。
		 * TODO 縮小サイズを指定できるように
		 * @param	geohash 対象となるgeohash
		 * @return
		 */
		public function reduction(geohash:String):String
		{
			if (geohash.length <= 1) {
				return null;
			}
			return geohash.substr(0, geohash.length -1);
		}
		
		/**
		 * 対象のgeohashの隣合うgeohashを取得する。
		 * @param	geohash 基点となるgeohash
		 * @param	direction	基点となるgeohashと隣り合う方向
		 * @return
		 */
		public function moveGeohash(geohash:String, direction:int):String
		{
			//TODO 
			return null
		}
		/**
		 * 隣接するGeohashの一覧を返す。
		 * 具体的には、指定されたgeohashを中心として同サイズの9ブロックを返す。
		 * 返される配列の格納方法は...どうしようかな。
		 * @param	geohash 対象のgeohash
		 * @return 	隣接するgeohashの一覧
		 */
		public function adjacentGeohash(geohash:String):Array
		{
			//TODO 
			return null;
		}
		
		/**
		 * 対象となる位置情報の表す緯度をbit列で求める。
		 * @param	loc 位置情報
		 * @return	位置情報を表すBit列
		 */
		private function getLatBits(loc:Number, act:int):String
		{
			return this.getBits(loc, -90,  90, act);
		}
		/**
		 * 対象となる位置情報の表す経度をbit列で求める。
		 * @param	loc 位置情報
		 * @return	位置情報を表すBit列
		 */
		private function getLngBits(loc:Number, act:int):String
		{
			return this.getBits(loc, -180,  180, act);
		}
		/**
		 * 指定された位置情報を表すbit列を絞り込む
		 * 緯度の場合はmin=-90,max=90を、経度の場合はmin=-180,max=180を設定する。
		 * @param	loc 位置情報
		 * @param	min 最小値
		 * @param	max 最大値
		 * @return 該当の位置情報を示すBit文字列
		 * TODO 文字列ではなくてint型でいけるはず。
		 */
		private function getBits(loc:Number, min:Number, max:Number, accuracy:int):String
		{
			var mid:Number = 0;
			var bits:String = "";
			
			// 絞り込み処理
			var index:int = BASE32_BIT_SIZE * accuracy / 2;
			for (var i:int = 0; i < index; i++)
			{
				// TODO min == あるいはmax== がlocの場合を考慮していない
				if (Math.abs(min - loc) < Math.abs(max - loc))
				{
					max = mid;
					mid = (min + mid) / 2
					bits += "0";
				}
				else
				{
					min = mid;
					mid = (mid + max) / 2
					bits += "1";
				}
			}
			trace(bits);
			return bits;
		}
		/**
		 * 位置情報を示すgeohashの矩形を取得する
		 * @param	lat
		 * @param	lng
		 * @return Geohash情報
		 */
		private function getGeohash(lat:String, lng:String, accuracy:int):String
		{
			// 0を基点に偶数列を経度、奇数列を緯度とするように結合する
			var latlng:String = "";
			var latlngIndex:int = BASE32_BIT_SIZE * accuracy;
			for (var i:int = 0; i < accuracy * latlngIndex; i++)
			{
				//偶数列
				if (i % 2 == 0) {
					latlng += lng.charAt(i / 2);
				}
				else 
				{
					latlng += lat.charAt(i / 2);
					
				}
			}
			
			// 5bitずつ6桁に分割し10進数に変換
			var cnt:int = accuracy;
			var baseArray:Array = []
			for (var j:int = 0; j <  cnt; j++)
			{
				baseArray.push(parseInt(latlng.substr(j * BASE32_BIT_SIZE, BASE32_BIT_SIZE), 2));
			}
			
			// BASE32のMAPに従って抽出
			var hash:String = "";
			var index:int = baseArray.length;
			for (var k:int = 0; k < baseArray.length; k++)
			{
				hash += BASE32[baseArray[k]];
			}
			trace( "hash : " + hash );
			
			return hash;
			
		}
		
	}
}