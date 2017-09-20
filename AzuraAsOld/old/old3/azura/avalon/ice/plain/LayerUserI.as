package old.azura.avalon.ice.plain
{
	import old.azura.avalon.ice.land.LandUserI;

	public interface LayerUserI extends LandUserI
	{
		function set layer(value:Layer):void;
		function set x(value:Number):void;
		function set y(value:Number):void;
		function get visualWidth():int;
		function get visualHeight():int;
//		function get scale():Number;
		function get level():int;
		function clear():void;
	}
}