package azura.avalon.mouse
{
	import flash.geom.Rectangle;

	public interface MouseTargetI
	{
		function get priority():int;
		function get active():Boolean;
	}
}