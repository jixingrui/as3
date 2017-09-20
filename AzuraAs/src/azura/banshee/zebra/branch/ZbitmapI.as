package azura.banshee.zebra.branch
{
	import flash.display.BitmapData;

	public interface ZbitmapI
	{
		function get bitmapData():BitmapData;
		function get nativeTexture():Object;
		function set nativeTexture(value:Object):void;
	}
}