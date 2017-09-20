package azura.avalon.fi.mask.old
{
	import azura.avalon.fi.TileFi;
	
	import flash.display.BitmapData;

	public interface MaskUserI
	{		
		function _updateShard(tile:TileMask, idxShard:int, bd:BitmapData, x:Number, y:Number, depth:int):void;
		function _removeShard(tile:TileMask, idxShard:int):void;
	}
}