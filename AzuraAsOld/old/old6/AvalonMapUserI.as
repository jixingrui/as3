package azura.avalon.map.old
{
	import flash.display.BitmapData;
	
	public interface AvalonMapUserI
	{
		function _updateTerrain(key:String, bd:BitmapData):void;
		function _updateFurniture(key:String, bd:BitmapData):void;
		function _positionTerrain(key:String, xScreen:Number, yScreen:Number):void;
		function _positionFurniture(key:String, xScreen:Number, yScreen:Number, depth:int):void;
		function _remove(key:String):void;
		function _centerDepth(depth:int):void;
	}
}