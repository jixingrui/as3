package azura.fractale
{
	import flash.utils.ByteArray;

	public interface FrackConfigI
	{
		function get host():String;
		function get port():int;
		function get frackey():ByteArray;
	}
}