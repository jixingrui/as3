package azura.common.algorithm.geohash
{
	import flash.display.Sprite;
	
	public class GeoSample extends Sprite
	{
		public function GeoSample()
		{
			var geo:Geohash = new Geohash();
			// 富山城址公園の緯度経度をgeohashにエンコード
			var hash:String = geo.encode(36.693286, 137.210877);
			trace(hash);
			// 富山城址公園のgeohashを緯度経度にデコード
			var latlng:Object = geo.decode("xn98drccvhm2");
			trace(latlng[Geohash.LAT_KEY], latlng[Geohash.LNG_KEY]);
		}
	}
}