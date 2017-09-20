package azura.avalon.fi.land
{
	import azura.avalon.fi.TileFi;
	
	import flash.display.BitmapData;

	public interface LandUserI
	{
		function _updateLand(tile:TileLand,bd:BitmapData):void;
		function _removeLand(tile:TileLand):void;
	}
}