package azura.banshee.zebra.i
{
	import azura.banshee.zebra.Zebra;
	
	import flash.geom.Rectangle;

	public interface ZebraBranchNodeI
	{
		/**
		 * 
		 * @param angle [0,360)
		 * 
		 */
		function set angle(value:Number):void;
		function get angle():Number;
		function look(viewLocal:Rectangle):void;
		function load(source:Zebra,ret_ZebraBranchI:Function):void;
		function show():void;
		/**
		 *Stops loading and prevents loaded event from firing 
		 * 
		 */
		function dispose():void;
		function get boundingBox():Rectangle;
	}
}