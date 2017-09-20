package azura.banshee.engine
{
	public interface TextureResI
	{
		function get texture():Object;
		function get pivotX():Number;
		function get pivotY():Number;
		function get width():Number;
		function get height():Number;
		function get center_LT():Boolean;
//		function get smoothing():Boolean;
	}
}