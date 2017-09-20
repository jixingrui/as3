package azura.banshee.zebra.i
{
	import azura.common.algorithm.mover.old.PlayerI;
	
	import flash.geom.Rectangle;
	
	import org.osflash.signals.Signal;

	public interface ZmatrixOpI
	{
		/**
		 * @param angle [0,360)
		 */
		function set angle(value:int):void;
		function set scale(value:Number):void;
		function set fps(value:int):void;
		function set framePercent(value:int):void;
		function get framePercent():int;
		function get boundingBox():Rectangle;
		function load(angle:int,ret_ZmatrixOp:Function):void;
		function dispose():void;
		function show():void;
	}
}