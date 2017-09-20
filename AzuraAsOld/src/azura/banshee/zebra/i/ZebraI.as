package azura.banshee.zebra.i
{
	import azura.gallerid3.i.GsI;
	
	import flash.geom.Rectangle;
	
	public interface ZebraI extends GsI
	{
		function get boundingBox():Rectangle;
//		function get width():int;
//		function get height():int;
	}
}