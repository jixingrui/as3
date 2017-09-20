package azura.avalon.fi.t256.old
{
	import flash.display.BitmapData;

	public interface T256UserI
	{
		function positionTile256(fi:int,xScreen:Number,yScreen:Number):void;
		function removeTile256(fi:int):void;
	}
}